<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//日志文件

//错误日志
function errorLog($content){
    if( $GLOBALS['openErrorLog'] == true ){
        rw($content) ;
    }
}

//写入系统操作日志
function writeSystemLog($tableName, $msgStr){
    $logFile=''; $s=''; $url=''; $ip=''; $addDateTime ='';
    $logFile = $GLOBALS['adminDir'] . '/data/systemLog/' . format_Time(Now(), 2) . '.txt' ;
    $url = ADSql(getThisUrlFileParam());
    $addDateTime = format_Time(Now(), 1) ;
    $ip = getIP() ;
    if( instr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $s = $s . '姓名：' . @$_SESSION['adminusername'] . vbCrlf() ;
        $s = $s . '表：' . $tableName . vbCrlf() ;
        $s = $s . '信息：' . $msgStr . vbCrlf() ;
        $s = $s . '网址：' . $url . vbCrlf() ;
        $s = $s . '时间：' . $addDateTime . vbCrlf() ;
        $s = $s . 'IP：' . $ip . vbCrlf() ;
        $s = $s . '------------------------' . vbCrlf() ;
        createAddFile($logFile, $s) ;
        //call echo(logfile,"log")
    }

    if( instr($GLOBALS['openWriteSystemLog'], '|txt|') > 0 ){
        $GLOBALS['conn=']=OpenConn() ;
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'SystemLog (tablename,msgstr,url,adminname,ip,adddatetime) values(\'' . $tableName . '\',\'' . $msgStr . '\',\'' . $url . '\',\'' . @$_SESSION['adminusername'] . '\',\'' . $ip . '\',\'' . $addDateTime . '\')') ;
    }

}

?>