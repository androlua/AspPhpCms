<?php
// URL 网址处理

/* 暂时屏蔽20151221
//处理文件目录完整/转\  20150124
function HandleFileUrl($FileUrl){
    $FileUrl = str_replace('/', '\\', $FileUrl);
	while(strpos($FileUrl,"\\\\")==true){
    	$FileUrl = str_replace("\\\\", "\\",$FileUrl);
	}
	return $FileUrl;
}
*/
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

?>