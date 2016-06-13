<?php
//define('$db',"aaa");
$conn="";
$dbhost='localhostNO';$dbuser='root';$dbpwd='root';$dbname='phpwebdata';  

function openConn() {
	global $conn;
	$conn = new mysql();
	
	
	
	$conna = @mysql_connect($GLOBALS['dbhost'],$GLOBALS['dbuser'],$GLOBALS['dbpwd']);
    if(!$conna){
		header('Location:'.$GLOBALS['webDir'].'/phpinc/startInstall.php');			//直接跳转安装页
		exit('<a href="'.$GLOBALS['webDir'].'/phpinc/startInstall.php" target="_blank">连接服务器失败，点击配置1</a>');
		 
	}
    if(!mysql_select_db($GLOBALS['dbname'],$conna)){
		header('Location:'.$GLOBALS['webDir'].'/phpinc/startInstall.php');			//直接跳转安装页
		exit('<a href="'.$GLOBALS['webDir'].'/phpinc/startInstall.php" target="_blank">连接数据库失败，点击配置2</a>');	
	}
	
	mysql_query("set names 'gb2312'"); //数据库输出编码
	
	$conn->connect($GLOBALS['dbhost'],$GLOBALS['dbuser'],$GLOBALS['dbpwd']);
	$conn->select_db($GLOBALS['dbname']);
	//$conn->select_db("phpcmsv9");
	return $conn;
}

//Sql测试查找
function testSql() {
	global $conn; 
	$rs=$conn->query("select * From padmin"); 
	while($arr=$conn->fetch_array($rs)){ 
		echo($arr["UserName"] . "<hr>");	
	}
}
//Sql测试查找
function testSql2() { 
	$conn=openConn();
	$rs=$conn->query("select * From padmin"); 
	while($arr=$conn->fetch_array($rs)){
		echo($arr["UserName"] . "<hr>");	
	}
}
//获得总记录
function getRecordCount($tableName,$addSql){	
	$conn=openConn();
	$rsObj=$GLOBALS['conn']->query( 'select * from ' . $tableName . ' ' . $addSql);
	return @mysql_num_rows($rsObj) ;
}
//检测SQL语句
function checkSql($sql){
	$conn=openConn();
	return $GLOBALS['conn']->checkSQL($sql);
}

?>