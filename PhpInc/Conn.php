<?php
//define('$db',"aaa");
$conn="";
function openConn() {
	global $conn;
	$conn = new mysql();
	
	$dbhost='localhost';$dbuser='root';$dbpwd='root';$dbname='phpwebdata'; 
	
	
	
	$conna = @mysql_connect($dbhost,$dbuser,$dbpwd);
    if(!$conna){
		exit('<a href="//phpinc/startInstall.php" target="_blank">���ӷ�����ʧ�ܣ��������</a>');
	}
    if(!mysql_select_db($dbname,$conna)){
		exit('<a href="//phpinc/startInstall.php" target="_blank">�������ݿ�ʧ�ܣ��������</a>');	
	}
	
	mysql_query("set names 'gb2312'"); //���ݿ��������
	
	$conn->connect($dbhost,$dbuser,$dbpwd);
	$conn->select_db($dbname);
	//$conn->select_db("phpcmsv9");
	return $conn;
}

//Sql���Բ���
function testSql() {
	global $conn; 
	$rs=$conn->query("select * From padmin"); 
	while($arr=$conn->fetch_array($rs)){ 
		echo($arr["UserName"] . "<hr>");	
	}
}
//Sql���Բ���
function testSql2() { 
	$conn=openConn();
	$rs=$conn->query("select * From padmin"); 
	while($arr=$conn->fetch_array($rs)){
		echo($arr["UserName"] . "<hr>");	
	}
}
//����ܼ�¼
function getRecordCount($tableName,$addSql){	
	$conn=openConn();
	$rsObj=$GLOBALS['conn']->query( 'select * from ' . $tableName . ' ' . $addSql);
	return @mysql_num_rows($rsObj) ;
}

?>
