<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-29
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By AspPhpCMS 
************************************************************/
?>
<?php
/*********************************************
*Mysql数据库生成程序
*作者：小云，QQ：313801120，E-mail:313801120@qq.com
*********************************************/
define('IN_GB', TRUE); 

/*操作数据库

$db = new mysql();
$db->connect("localhost","root","root");
$db->select_db("webdata");

$db->query("delete From padmin"); 

for($i=0;$i<9;$i++){
	$dbsql = "Insert into padmin (UserName) Values('user_". $i ."')";
	$db->query($dbsql);
}

$rs=$db->query("select * From padmin"); 
while($arr=$db->fetch_array($rs)){ 
	echo($arr["UserName"] . "<hr>");

}
*/

if(!defined('IN_GB'))
	exit('Access denied!');

class mysql{
	var $querynum = 0;//查询次数
	var $showError = true;
	
	function connect($dbhost, $dbuser, $dbpw, $dbname='',$dbcharset='') {
		if(!@mysql_connect($dbhost, $dbuser, $dbpw)) {
			$this->show('无法连接到MySQL服务器.');
			return false;
		}
		if($dbname) {
			$this->select_db($dbname);
		}
		if($dbcharset && $this->version() > '4.1') {
			$this->query("SET NAMES '".$dbcharset."'");
		}
		mysql_query("set names 'utf-8'"); 						//打开数据库编码
		return true;
	}

	function select_db($dbname) {
		return mysql_select_db($dbname);
	}

	function fetch_array($query, $result_type = MYSQL_ASSOC) {
		return @mysql_fetch_array($query, $result_type);
	}

	function query($sql){ 
		//不能替换，因为插入和更新时有值会被替换掉(20151130)
		//$sql=replace(replace($sql,"["," "),"]"," ");				//删除[]  因为在php里不允许用 [product]  这种(20150810)  免得出错
		
		
		$sql=$this->handleSqlTop($sql);
		if(!($query = @mysql_query($sql))) 
			$this->show('MySQL 执行错误', $sql);
		$this->querynum++;
		return $query;
	}
	
	//处理SQL显示条数TOP
	function handleSqlTop( $sql){
		$s=""; $nLength=""; $leftStr=""; $rightStr=""; $nRow ="";
		$s = LCase($sql) ;
		$nLength = instr($s, " top ") ;
		if( $nLength > 0 ){
			$leftStr = mid($sql, 1, $nLength) ;
			$rightStr = mid($sql, $nLength + 5,-1) ;
			$rightStr = AspTrim($rightStr) ;
			$nRow = mid($rightStr, 1, instr($rightStr, " ")) ;
			$rightStr = mid($rightStr, instr($rightStr, " "),-1) ;
			//call echo("nRow",nRow)
			//call echo("leftStr",leftStr)
			//call echo("rightStr",rightStr)
			$sql = $leftStr . $rightStr . " limit " . $nRow ;
		}
		$handleSqlTop = $sql ;
		return @$handleSqlTop;}

	function affected_rows() {
		return mysql_affected_rows();
	}

	function result($query, $row) {
		return mysql_result($query, $row);
	}

	function num_rows($query) {
		return @mysql_num_rows($query);
	}
	//获得记录总数
	function recordcount($query){
		return num_rows($query);
	}

	function num_fields($query) {
		return mysql_num_fields($query);
	}

	function free_result($query) {
		return mysql_free_result($query);
	}

	function insert_id() {
		return mysql_insert_id();
	}

	function fetch_row($query) {
		return mysql_fetch_row($query);
	}

	function fetch_assoc($query){
		return mysql_fetch_assoc($query);
	}
	
	function fetch_object(){
		return mysql_fetch_object($query);
	}
	
	function version() {
		return mysql_get_server_info();
	}

	function close() {
		return mysql_close();
	}

	function error() {
		return mysql_error();
	}
	
	function errno() {
		return mysql_errno();
	}
	
	//出错提示
	function show($message = '', $sql = '') {
		if($this->showError)
			exit($message.'<br>'.($sql?'出错sql语句:'.$sql.'<br>':'').'出错信息:<br>'.$this->errno().': '.$this->error());
	}
}

class pagination extends mysql{
//分页类
	var $totalrows = 0;//共有信息条数
	var $messagenum;//每页信息条数$maxnum
	var $pageindex;//当前页面$page
	var $pagesnum;//共显示多少页$maxpages
	var $pageprenum;//当前页之前显示多少页$pagepre
	var $expansion;//扩展
	var $totalpages;//可分总页数
	var $self;//当前页面
	var $psumarr = array();
	var $plistarr = array();
	
	function pagination($mnum,$page,$pnum,$ppre,$num=0,$sql='',$exp=''){
	//构造函数
		$this->messagenum = $mnum;
		$this->pageindex = $page;
		$this->pagesnum = $pnum;
		$this->pageprenum = $ppre;
		$this->expansion = $exp;
		$this->self = $_SERVER['PHP_SELF'];
		
		if($num) 
			$this->totalrows = $num;
		elseif($sql){
			$query = $this->query($sql);
			$rows = $this->fetch_array($query,MYSQL_NUM);
			$this->totalrows = $rows[0];
		}
		
		//----------------------------
		if($this->totalrows){
			$this->pageSum();
			$this->pageBefore();
			$this->pageList();
			$this->pageAfter();
		}
	}
	
	function pageSum(){
		$this->totalpages = ceil($this->totalrows/$this->messagenum);
	    $this->psumarr[] = $this->totalrows;
		$this->psumarr[] = $this->pageindex."/".$this->totalpages;
	}
	
	function pagePre(){
	    return $this->pageindex - 1;
	}
	
	function pageNext(){
	    return $this->pageindex + 1;
	}
	
	function pageBefore(){	
	    if($this->pageindex != 1){
			$this->plistarr['first'] = array($this->self."?page=1".$this->expansion, "|&lsaquo;");
			$this->plistarr['pre'] =  array($this->self."?page=".$this->pagePre().$this->expansion, "&lsaquo;&lsaquo;");
		}

	}
	
	function pageList(){
		if($this->pagesnum >= $this->totalpages){
			$pgstart = 1;
			$pgend = $this->totalpages;
		}
		elseif(($this->pageindex - $this->pageprenum -1 + $this->pagesnum) > $this->totalpages){
			$pgstart = $this->totalpages - $this->pagesnum + 1;
			$pgend = $this->totalpages;
		}
		else{
			$pgstart = (($this->pageindex <= $this->pageprenum)?1:($this->pageindex-$this->pageprenum));
			$pgend = (($pgstart == 1)?$this->pagesnum:($pgstart + $this->pagesnum - 1));
		}

		for($pg=$pgstart;$pg<=$pgend;$pg++){
				$this->plistarr[$pg] =  array($this->self."?page=".$pg.$this->expansion, $pg);
		}
	}
	
	function pageAfter(){
		if($this->pageindex != $this->totalpages){
			$this->plistarr['next'] = array($this->self.'?page='.$this->pageNext().$this->expansion, "&rsaquo;&rsaquo;");
			$this->plistarr['last'] = array($this->self.'?page='.$this->totalpages.$this->expansion, "&rsaquo;|");
		}	
	}
	
	function pageFormat(){
		if(!$this->totalrows)
			return '';
		$pagestr = '';
		foreach($this->psumarr as $value){
			$pagestr .= $this->htmlTag('li','class="p_num"',$this->htmlTag('b','',$value));
		}
		
		foreach($this->plistarr as $key => $val){
			if($key == $this->pageindex){
				$pagestr .= $this->htmlTag('li','class="p_curpage"',$this->htmlTag('a','href="'.$val[0].'"',$val[1]));
			}
			else{
				$pagestr .= $this->htmlTag('li','class="p_num"',$this->htmlTag('a','href="'.$val[0].'"',$val[1]));
			}	
		}
		
		return $pagestr;
	}
	
	function htmlTag($tag,$attr='',$content=''){
		if($content == '')
		   return '<'.$tag.(($attr=='')?'':' '.$attr).' />';
		else 
			return '<'.$tag.(($attr=='')?'':' '.$attr).'>'.$content.'</'.$tag.'>';
	}
}

class gbManage extends mysql {
	function insertData($tbName,$values){
		$sql = "INSERT INTO `{$tbName}` ( ";
		$columnArr = $valArr = array();
		foreach ($values as $key => $value){
			$columnArr[] = "`{$key}`";
			$valArr[] = is_null($values) ? 'NULL' : "'{$value}'";
		}
		$sql .= implode(', ', $columnArr);
		$sql .= " ) VALUES ( ";
		$sql .= implode(', ', $valArr);
		$sql .= " )";
		
		return $this->query($sql);
	}
	
	function updateData($tbName,$values,$expansion='',$condition=''){
		$sql = "UPDATE `{$tbName}` SET ";
		$sqlArr = array();
		foreach ($values as $key => $value){
			$sqlArr[] = "`{$key}` = '$value'";
		}
		$sql .= implode(', ',$sqlArr);
		$sql .= $expansion;
		if($condition)
			$sql .= " WHERE " . $condition;
		
		return $this->query($sql);		
	}
	
	function return_row($sql){
		$query = $this->query($sql);
		if($this->num_rows($query))
			return $this->fetch_array($query);
	}
	
	function return_array($sql) {
		$arr = array();
		$query = $this->query($sql);
		while($row = $this->fetch_array($query)){
			$arr[] = $row;
		}
		return $arr;
	}
}

class Fanso_lite{
	var $template_dir = 'templates/';
	var $include_header = true;
	var $include_footer = true;
	var $head = 'header.html';
	var $foot = 'footer.html';

	function display($file_name){
		echo $this->parseHeader().$this->fetch($file_name).$this->parseFooter();
	}

	function fetch($file_name){
		global $vartem;
		$compiledfile_url = $this->template_dir . $file_name;
		ob_start();
		require($compiledfile_url);
		$content = ob_get_contents();
		ob_end_clean();
		return $content;
	}
	
	function parseHeader(){
		$headerContent = $this->fetch($this->head);
		if(!$this->include_header)
			$headerContent = preg_replace('/<center>.+/is','<center>',$headerContent);
		return $headerContent;
	}
	
	function parseFooter(){		
		global $vartem;
		$vartem['querytime'] = queryTime();
		
		$footerContent = $this->fetch($this->foot);
		if(!$this->include_footer)
			$footerContent = preg_replace('/^.+<\/center>/is','</center>',$footerContent);
		return $footerContent;
	}
}
?>