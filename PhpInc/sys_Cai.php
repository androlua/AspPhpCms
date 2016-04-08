<?php

//获得网址内容页
function get_url_content($url){
   if(function_exists('curl_init')) {
      $ch = curl_init();
      $timeout = 5;
      curl_setopt($ch, CURLOPT_URL, $url);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
      $file_contents = curl_exec($ch);
      curl_close($ch);
   } else {
	  $file_contents = @file_get_contents($url);
   }
   return $file_contents;
}
//获得网址内容页  (辅助上面)
function getHttpPage($url){
	return get_url_content($url);
}
//获得网址内容页  (辅助上面)
function getHttpUrl($url,$rel){
	return get_url_content($url);
}

//分割字符   
//测试 echo(GetArray("11{@11 中国人len(now()) 22@}333abcdefg{@getLableValue title='标题 now()'content=\"len(now())\"@}123456{@aa title='aa'@}eeeee{@getLableValue title='aa'@} bb", "{@", "@}", true, true));   
function  getArray( $content, $startStr, $endStr, $startType, $endType){
     $s=""; $i=""; $listStr ="";
    for( $i = 0 ; $i<= 999; $i++){				//30为截取条件
		//echo($content . "=" . instr($content, $startStr));
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0){ 		
			$s = mid($content, 1, instr($content, $endStr) + 1) ;
			//echo("    s=" . $s . "<br>");
            $content = mid($content, instr($content, $endStr) + strlen($endStr),-1) ;
            $s = mid($s, instr($s, $startStr) + strlen($startStr),-1);
			//echo("    s2=" . $s . "<br>");

            $s = substr($s, 0 , strlen($s) - strlen($endStr)) ;
            if( $startType == true ){ $s = $startStr . $s ;}
            if( $endType == true ){ $s = $s . $endStr ;}
            if( $listStr <> "" ){ $listStr = $listStr . '$Array$' ;}
            $listStr = $listStr . $s ;
        }else{
             break;
        }
    }
    $GetArray = $listStr ;
 return @$GetArray;} 
 
 ?>