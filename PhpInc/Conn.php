<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-03-11
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-03-11
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?php
//define('$db',"aaa");
$conn="";
function openConn() {
	global $conn;
	$conn = new mysql();
	
	$dbhost='localhostNO';$dbuser='root';$dbpwd='root';$dbname='phpwebdata'; 
	
	
	
	$conna = @mysql_connect($dbhost,$dbuser,$dbpwd);
    if(!$conna){
		header('Location://phpinc/startInstall.php');			//ֱ����ת��װҳ
		exit('<a href="//phpinc/startInstall.php" target="_blank">���ӷ�����ʧ�ܣ��������1</a>');
		 
	}
    if(!mysql_select_db($dbname,$conna)){
		header('Location://phpinc/startInstall.php');			//ֱ����ת��װҳ
		exit('<a href="//phpinc/startInstall.php" target="_blank">�������ݿ�ʧ�ܣ��������2</a>');	
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
//���SQL���
function checkSql($sql){
	$conn=openConn();
	return $GLOBALS['conn']->checkSQL($sql);
}

?>