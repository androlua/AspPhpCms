<?PHP
//��־�ļ�

//������־
function errorLog($content){
    if( $GLOBALS['openErrorLog']== true ){
        Rw($content);
    }
}

//д��ϵͳ������־
function writeSystemLog($tableName, $msgStr){
    $logFile=''; $s=''; $url=''; $ip=''; $addDateTime='';$logDir='';
    $logDir= $GLOBALS['webDir'] . $GLOBALS['adminDir'] . '/data/systemLog/';
    CreateDirFolder($logDir);		//�����ļ���
    $logFile=$logDir . '/' . Format_Time(now(), 2) . '.txt';
    $url= ADSql(getThisUrlFileParam());
    $addDateTime= Format_Time(now(), 1);
    $ip= getIP();
    if( inStr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $s= $s . '������' . @$_SESSION['adminusername'] . vbCrlf();
        $s= $s . '��' . $tableName . vbCrlf();
        $s= $s . '��Ϣ��' . $msgStr . vbCrlf();
        $s= $s . '��ַ��' . $url . vbCrlf();
        $s= $s . 'ʱ�䣺' . $addDateTime . vbCrlf();
        $s= $s . 'IP��' . $ip . vbCrlf();
        $s= $s . '------------------------' . vbCrlf();
        CreateAddFile($logFile, $s);
        //call echo(logfile,"log")
    }

    if( inStr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $GLOBALS['conn=']=OpenConn();
        //�жϱ����
        if( inStr(getHandleTableList(),'|'. $GLOBALS['db_PREFIX'] . 'systemlog' .'|')>0 ){
            connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'SystemLog (tablename,msgstr,url,adminname,ip,adddatetime) values(\'' . $tableName . '\',\'' . $msgStr . '\',\'' . $url . '\',\'' . @$_SESSION['adminusername'] . '\',\'' . $ip . '\',\'' . $addDateTime . '\')');
        }
    }

}

?>