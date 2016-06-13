<?php
// URL 网址处理

//url加密  
function escape($str){
    $sublen=strlen($str);
    $retrunString="";
    for ($i=0;$i<$sublen;$i++){
        if(ord($str[$i])>=127){
            $tmpString=bin2hex(iconv("gb2312","ucs-2",substr($str,$i,2)));
            //$tmpString=substr($tmpString,2,2).substr($tmpString,0,2);window下可能要打开此项
            $retrunString.="%u".$tmpString;
            $i++;
        } else
            {
            $retrunString.="%".dechex(ord($str[$i]));
        }
    }
    return $retrunString;
}
//解密escape gb2312编码
function unEscape($str) {
    $str = rawurldecode($str);
    preg_match_all("/%u.{4}|&#x.{4};|&#d+;|.+/U",$str,$r);
    $ar = $r[0];
    foreach($ar as $k=>$v) {
        if(substr($v,0,2) == "%u")
        $ar[$k] = iconv("UCS-2","GBK",pack("H4",substr($v,-4)));
        elseif(substr($v,0,3) == "&#x")
        $ar[$k] = iconv("UCS-2","GBK",pack("H4",substr($v,3,-1)));
        elseif(substr($v,0,2) == "&#") {
            $ar[$k] = iconv("UCS-2","GBK",pack("n",substr($v,2,-1)));
        }
    }
    return join("",$ar);
}
//解密escape utf-8编码
function UtfUnEscape($str){
    $ret = '';
    $len = strlen($str);
    for ($i = 0; $i < $len; $i++){
        if ($str[$i] == '%' && $str[$i+1] == 'u'){
            $val = hexdec(substr($str, $i+2, 4));
            if ($val < 0x7f) $ret .= chr($val);
            else if($val < 0x800) $ret .= chr(0xc0|($val>>6)).chr(0x80|($val&0x3f));
            else $ret .= chr(0xe0|($val>>12)).chr(0x80|(($val>>6)&0x3f)).chr(0x80|($val&0x3f));
            $i += 5;
        }
        else if ($str[$i] == '%'){
            $ret .= urldecode(substr($str, $i, 3));
            $i += 2;
        }
        else $ret .= $str[$i];
    }
    return $ret;
}

//检测域名存在   例：checkDomainName('http://www.baidu.com/a/b/sdf')
function checkDomainName($httpurl){
	$url=getwebsite($httpurl);
	$url2=$url."/a/1/b/2/cdefg/";
	return IIF(checkHttpUrlSize($url,$url2)==1,0,1);
}
//检测两个请求网址内容大小是否一致
function checkHttpUrlSize($url,$url2){
	if(getHttpUrlSize($url)==getHttpUrlSize($url2)){
		return 1;
	}else{
		return 0;
	}
}
//获得请求网址大小
function getHttpUrlSize($httpurl){
	$arr=@get_headers($httpurl,1);
	if(!empty($arr)){
		if(@is_array( $arr["Content-Length"] ) ){
			return $arr["Content-Length"][0];
		}else{
			if(!empty(@$arr["Content-Length"])){
				return $arr["Content-Length"];
			}else{
				return 0;
			}
		}
	}else{
		return 0;
	}
}
//获得请求网址类型
function getHttpUrlType($httpurl){
	$arr=@get_headers($httpurl,1);
	if(!empty($arr)){
		if(@is_array( $arr["Content-Type"] ) ){
			return $arr["Content-Type"][0];
		}else{
			return @$arr["Content-Type"];
		} 
	}else{
		return '';
	}
}
//获得请求网址状态
function getHttpUrlState($httpurl){
	$arr=@get_headers($httpurl,1);
	if(!empty($arr)){
		if( is_array( $arr[0] ) ){
			$s = $arr[0][0];
		}else{
			$s = $arr[0];
		}	
		$splstr=aspSplit($s," ");
		$s=intval($splstr[1]);
		return $s;
	}else{
		return -1;
	}
	
}
//获得请求网址服务器
function getHttpUrlServerName($httpurl){
	$arr=@get_headers($httpurl,1);
	if(!empty($arr)){
		if(@is_array( $arr["Server"] ) ){
			return $arr["Server"][0];
		}else{
			return @$arr["Server"];
		} 
	}else{
		return '';
	}
	
}



//print_r(get_headers('http://baidu.com/',1));			//测试用到


?>