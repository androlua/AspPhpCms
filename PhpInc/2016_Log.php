<?PHP
//��־�ļ�

//������־
function errorLog($content){
    if( $GLOBALS['openErrorLog']== true ){
        rw($content);
    }
}

//д��ϵͳ������־
function writeSystemLog($tableName, $msgStr){
    $logFile=''; $s=''; $url=''; $ip=''; $addDateTime ='';
    $logFile= $GLOBALS['adminDir'] . '/data/systemLog/' . format_Time(Now(), 2) . '.txt';
    $url= ADSql(getThisUrlFileParam());
    $addDateTime= format_Time(Now(), 1);
    $ip= getIP();
    if( instr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $s= $s . '������' . @$_SESSION['adminusername'] . vbCrlf();
        $s= $s . '��' . $tableName . vbCrlf();
        $s= $s . '��Ϣ��' . $msgStr . vbCrlf();
        $s= $s . '��ַ��' . $url . vbCrlf();
        $s= $s . 'ʱ�䣺' . $addDateTime . vbCrlf();
        $s= $s . 'IP��' . $ip . vbCrlf();
        $s= $s . '------------------------' . vbCrlf();
        createAddFile($logFile, $s);
        //call echo(logfile,"log")
    }

    if( instr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $GLOBALS['conn=']=OpenConn();
        //�жϱ����
        if( instr(getHandleTableList(),'|'. $GLOBALS['db_PREFIX'] . 'systemlog' .'|')>0 ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'SystemLog (tablename,msgstr,url,adminname,ip,adddatetime) values(\'' . $tableName . '\',\'' . $msgStr . '\',\'' . $url . '\',\'' . @$_SESSION['adminusername'] . '\',\'' . $ip . '\',\'' . $addDateTime . '\')');
        }
    }

}

?>