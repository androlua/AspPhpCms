<?php
//define('$db',"aaa");
$conn="";
$dbhost='localhostNO';$dbuser='root';$dbpwd='root';$dbname='phpwebdata';  

function openConn() {
	global $conn;
	$conn = new mysql();
	
	
	
	$conna = @mysql_connect($GLOBALS['dbhost'],$GLOBALS['dbuser'],$GLOBALS['dbpwd']);
    if(!$conna){
		header('Location:'.$GLOBALS['webDir'].'/phpinc/startInstall.php');			//ֱ����ת��װҳ
		exit('<a href="'.$GLOBALS['webDir'].'/phpinc/startInstall.php" target="_blank">���ӷ�����ʧ�ܣ��������1</a>');
		 
	}
    if(!mysql_select_db($GLOBALS['dbname'],$conna)){
		header('Location:'.$GLOBALS['webDir'].'/phpinc/startInstall.php');			//ֱ����ת��װҳ
		exit('<a href="'.$GLOBALS['webDir'].'/phpinc/startInstall.php" target="_blank">�������ݿ�ʧ�ܣ��������2</a>');	
	}
	
	mysql_query("set names 'gb2312'"); //���ݿ��������
	
	$conn->connect($GLOBALS['dbhost'],$GLOBALS['dbuser'],$GLOBALS['dbpwd']);
	$conn->select_db($GLOBALS['dbname']);
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
//���SQL���
function checkSql($sql){
	$conn=openConn();
	return $GLOBALS['conn']->checkSQL($sql);
}

?>