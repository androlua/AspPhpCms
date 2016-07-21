<?PHP
//Check验证 (2013,10,26)

//检测URL文件名称是否带参数，如:.js?  .css?  用法 checkUrlFileNameParam("http://sdfsd.com/aaa.js","js|css|")
function checkUrlFileNameParam($httpurl,$sList){
    $url='';$splstr='';$searchStr='';
    $url=lCase($httpurl);
    $sList=lCase($sList);
    $splstr=aspSplit($sList,'|');
    foreach( $splstr as $key=>$searchStr){
        if( $searchStr<>'' ){
            $searchStr='.'. $searchStr .'?';
            //call echo("searchStr",searchStr)
            if( inStr($url,$searchStr) > 0 ){
                $checkUrlFileNameParam=true;
                return @$checkUrlFileNameParam;
            }
        }
    }
    $checkUrlFileNameParam=false;
    return @$checkUrlFileNameParam;
}

//是大写 20160105
function isUCase($content){
    $i=''; $s ='';
    $isUCase= true;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', $s)== false ){
            $isUCase= false;
            return @$isUCase;
        }
    }
    return @$isUCase;
}
//是小写 20160105
function isLCase($content){
    $i=''; $s ='';
    $isLCase= true;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('abcdefghijklmnopqrstuvwxyz', $s)== false ){
            $isLCase= false;
            return @$isLCase;
        }
    }
    return @$isLCase;
}


//检测错误


//把字符true转真类型 false转假类型
function strToTrueFalse( $content){
    $content= aspTrim(lCase($content));
    $strToTrueFalse= IIF($content== 'true', true, false);
    return @$strToTrueFalse;
}
//把字符true转1类型 false转0类型
function strTrueFalseToInt( $content){
    $content= aspTrim(lCase($content));
    $strTrueFalseToInt= IIF($content== 'true', 1, 0);
    return @$strTrueFalseToInt;
}
//检查换行
function checkVbCrlf($content){
    $checkVbCrlf= false;
    if( inStr($content, vbCrlf()) > 0 ){ $checkVbCrlf= true ;}
    return @$checkVbCrlf;
}
//检查换行    辅助
function checkBr($content){
    $checkBr= checkVbCrlf($content);
    return @$checkBr;
}

//判断数字奇偶
function isParity($Numb){
    $isParity= '';
    if( is_numeric($Numb) ){
        $isParity= '这不是一个数字啊';
        return @$isParity;
    }
    if( $Numb % 2== 0 ){
        $isParity= 0;
    }else{
        $isParity= 1;
    }
    return @$isParity;
}
//检测eval正确性
function checkEval($content){ //留空函数
}
//********************************************************
//过滤SQL非法字符并格式化html代码
//********************************************************
function replace_SQLText($fString){
    if( isNull($fString) ){
        $replace_SQLText= '';
        return @$replace_SQLText;
    }else{
        $fString= aspTrim($fString);
        $fString= replace($fString, '\'', '\'\'');
        $fString= replace($fString, ';', '；');
        $fString= replace($fString, '--', '—');
        $fString= displayHtml($fString);
        $replace_SQLText= $fString;
    }
    return @$replace_SQLText;
}
//********************************************************
//检查是否外部提交数据
//********************************************************
function chkPost(){
    $Server_v1=''; $Server_v2 ='';
    $chkPost= false;
    $Server_v1= cStr(serverVariables('HTTP_REFERER'));
    $Server_v2= cStr(serverVariables('SERVER_NAME'));
    aspEcho($Server_v1, $Server_v2);
    if( mid($Server_v1, 8, len($Server_v2)) <> $Server_v2 ){
        $chkPost= false;
    }else{
        $chkPost= true;
    }
    return @$chkPost;
}
//Response.Write(IsMail("asdf@sdf.com"))
//正则表达验证邮箱
function isMail($email){ //留空函数
}
//邮箱验证第二种
function isValidEmail($email){
    $names=''; $Name=''; $i=''; $c ='';
    $isValidEmail= true;
    $names= aspSplit($email, '@');
    if( uBound($names) <> 1 ){ $isValidEmail= false ; return @$isValidEmail; }
    foreach( $names as $key=>$Name){
        if( len($Name) <= 0 ){ $isValidEmail= false ; return @$isValidEmail; }
        for( $i= 1 ; $i<= len($Name); $i++){
            $c= lCase(mid($Name, $i, 1));
            if( inStr('abcdefghijklmnopqrstuvwxyz_-.', $c) <= 0 && is_numeric($c) ){ $isValidEmail= false ; return @$isValidEmail; }
        }
        if( left($Name, 1)== '.' || right($Name, 1)== '.' ){ $isValidEmail= false ; return @$isValidEmail; }
    }
    if( inStr($names[1], '.') <= 0 ){ $isValidEmail= false ; return @$isValidEmail; }
    $i= len($names[1]) - inStrRev($names[1], '.');
    if( $i <> 2 && $i <> 3 ){ $isValidEmail= false ; return @$isValidEmail; }
    if( inStr($email, '..') > 0 ){ $isValidEmail= false ;}
    return @$isValidEmail;
}
//检测为有效字符
function isCode( $content){
    $c ='';
    $c= replace($content, ' ', '');
    $c= replace($c, chr(13), '');
    $c= replace($c, chr(10), '');
    $c= replace($c, vbTab(), '');
    $isCode= IIF($c <> '', true, false);
    return @$isCode;
}
//测试是否为数字
function checkNumber( $content){
    $i=''; $s ='';
    if( len($content)== 0 ){ $checkNumber= false ; return @$checkNumber; }
    $checkNumber= true;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789', lCase($s))== false ){
            $checkNumber= false;
            return @$checkNumber;
        }
    }
    return @$checkNumber;
}
//测试是否为数字 (辅助)
function isNumber( $content){
    $isNumber= checkNumber($content);
    return @$isNumber;
}
//测试是否为字母
function checkABC( $content){
    $i=''; $s ='';
    $checkABC= true;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('abcdefghijklmnopqrstuvwxyz', lCase($s))== false ){
            $checkABC= false;
            return @$checkABC;
        }
    }
    return @$checkABC;
}
//获得字符长度 汉字算两个字符
function getLen($content){
    $i=''; $s=''; $n ='';
    $n= 0;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= asc(mid(cStr($content), $i, 1));
        if( $s < 0 ){
            $n= $n + 2;
        }else{
            $n= $n + 1;
        }
    }
    $getLen= $n;
    return @$getLen;
}
//测试是否为时间类型
function checkTime($DateTime){
    $checkTime= IIF(isDate($DateTime)== false, false, true);
    return @$checkTime;
}
//判断是否为空
function isNul( $s){ return ''; return ''; return ''; return ''; return ''; return ''; return ''; //留空函数
}


//****************************************************
//函数名：FoundInArr
//作  用：检查一个数组中所有元素是否包含指定字符串
//时  间：2011年10月13日
//参  数： strArr
//strToFind
//strSplit
//返回值：字符串
//调  试：SHtml=R_("{测试}",Function FoundInArr(strArr, strToFind, strSplit))
//****************************************************
function foundInArr($strArr, $strToFind, $strSplit){
    $arrTemp=''; $i ='';
    $foundInArr= false;
    if( inStr($strArr, $strSplit) > 0 ){
        $arrTemp= aspSplit($strArr, $strSplit);
        for( $i= 0 ; $i<= uBound($arrTemp); $i++){
            if( lCase(aspTrim($arrTemp[$i]))== lCase(aspTrim($strToFind)) ){
                $foundInArr= true ; break;
            }
        }
    }else{
        if( lCase(aspTrim($strArr))== lCase(aspTrim($strToFind)) ){ $foundInArr= true ;}
    }
    return @$foundInArr;
}
?>