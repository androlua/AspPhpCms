<?PHP
//日志文件

//错误日志
function errorLog($content){
    if( $GLOBALS['openErrorLog']== true ){
        rw($content);
    }
}

//写入系统操作日志
function writeSystemLog($tableName, $msgStr){
    $logFile=''; $s=''; $url=''; $ip=''; $addDateTime ='';
    $logFile= $GLOBALS['adminDir'] . '/data/systemLog/' . format_Time(Now(), 2) . '.txt';
    $url= ADSql(getThisUrlFileParam());
    $addDateTime= format_Time(Now(), 1);
    $ip= getIP();
    if( instr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $s= $s . '姓名：' . @$_SESSION['adminusername'] . vbCrlf();
        $s= $s . '表：' . $tableName . vbCrlf();
        $s= $s . '信息：' . $msgStr . vbCrlf();
        $s= $s . '网址：' . $url . vbCrlf();
        $s= $s . '时间：' . $addDateTime . vbCrlf();
        $s= $s . 'IP：' . $ip . vbCrlf();
        $s= $s . '------------------------' . vbCrlf();
        createAddFile($logFile, $s);
        //call echo(logfile,"log")
    }

    if( instr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $GLOBALS['conn=']=OpenConn();
        //判断表存在
        if( instr(getHandleTableList(),'|'. $GLOBALS['db_PREFIX'] . 'systemlog' .'|')>0 ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'SystemLog (tablename,msgstr,url,adminname,ip,adddatetime) values(\'' . $tableName . '\',\'' . $msgStr . '\',\'' . $url . '\',\'' . @$_SESSION['adminusername'] . '\',\'' . $ip . '\',\'' . $addDateTime . '\')');
        }
    }

}

?>