<?php
//define('$db',"aaa");
$conn="";
function openConn() {
	global $conn;
	$conn = new mysql();
	
	$dbhost='localhost';$dbuser='root';$dbpwd='root';$dbname='phpwebdata'; 
	
	
	
	$conna = @mysql_connect($dbhost,$dbuser,$dbpwd);
    if(!$conna){
		exit('<a href="//phpinc/startInstall.php" target="_blank">连接服务器失败，点击配置</a>');
	}
    if(!mysql_select_db($dbname,$conna)){
		exit('<a href="//phpinc/startInstall.php" target="_blank">连接数据库失败，点击配置</a>');	
	}
	
	mysql_query("set names 'gb2312'"); //数据库输出编码
	
	$conn->connect($dbhost,$dbuser,$dbpwd);
	$conn->select_db($dbname);
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

?>
