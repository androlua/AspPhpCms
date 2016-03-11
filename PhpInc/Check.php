<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//Check验证 (2013,10,26)

//检测URL文件名称是否带参数，如:.js?  .css?  用法 checkUrlFileNameParam("http://sdfsd.com/aaa.js","js|css|")
function checkUrlFileNameParam($httpurl,$sList){
    $url='';$splstr='';$searchStr='';
    $url=lcase($httpurl);
    $sList=lcase($sList);
    $splstr=aspSplit($sList,'|');
    foreach( $splstr as $searchStr){
        if( $searchStr<>'' ){
            $searchStr='.'. $searchStr .'?';
            //call echo("searchStr",searchStr)
            if( instr($url,$searchStr) > 0 ){
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
    $isUCase = true ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( instr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', $s) == false ){
            $isUCase = false ;
            return @$isUCase;
        }
    }
    return @$isUCase;
}
//是小写 20160105
function isLCase($content){
    $i=''; $s ='';
    $isLCase = true ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( instr('abcdefghijklmnopqrstuvwxyz', $s) == false ){
            $isLCase = false ;
            return @$isLCase;
        }
    }
    return @$isLCase;
}


//检测错误


//把字符true转真类型 false转假类型
function strToTrueFalse( $content){
    $content = AspTrim(LCase($content)) ;
    $strToTrueFalse = IIF($content == 'true', true, false) ;
    return @$strToTrueFalse;
}
//把字符true转1类型 false转0类型
function strTrueFalseToInt( $content){
    $content = AspTrim(LCase($content)) ;
    $strTrueFalseToInt = IIF($content == 'true', 1, 0) ;
    return @$strTrueFalseToInt;
}
//检查换行
function checkVbCrlf($content){
    $checkVbCrlf = false ;
    if( instr($content, vbCrlf()) > 0 ){ $checkVbCrlf = true ;}
    return @$checkVbCrlf;
}
//检查换行    辅助
function checkBr($content){
    $checkBr = checkVbCrlf($content) ;
    return @$checkBr;
}

//判断数字奇偶
function isParity($Numb){
    $isParity = '' ;
    if( is_numeric($Numb) ){
        $isParity = '这不是一个数字啊' ;
        return @$isParity;
    }
    if( $Numb % 2 == 0 ){
        $isParity = 0 ;
    }else{
        $isParity = 1 ;
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
    if( IsNull($fString) ){
        $replace_SQLText = '' ;
        return @$replace_SQLText;
    }else{
        $fString = AspTrim($fString) ;
        $fString = Replace($fString, '\'', '\'\'') ;
        $fString = Replace($fString, ';', '；') ;
        $fString = Replace($fString, '--', '—') ;
        $fString = $GLOBALS['HTMLEncode'][$fString] ;
        $replace_SQLText = $fString ;
    }
    return @$replace_SQLText;
}
//********************************************************
//检查是否外部提交数据
//********************************************************
function chkPost(){
    $Server_v1=''; $Server_v2 ='';
    $chkPost = false ;
    $Server_v1 = CStr(ServerVariables('HTTP_REFERER')) ;
    $Server_v2 = CStr(ServerVariables('SERVER_NAME')) ;
    ASPEcho($Server_v1, $Server_v2) ;
    if( mid($Server_v1, 8, strlen($Server_v2)) <> $Server_v2 ){
        $chkPost = false ;
    }else{
        $chkPost = true ;
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
    $isValidEmail = true ;
    $names = aspSplit($email, '@') ;
    if( UBound($names) <> 1 ){ $isValidEmail = false ; return @$isValidEmail; }
    foreach( $names as $Name){
        if( strlen($Name) <= 0 ){ $isValidEmail = false ; return @$isValidEmail; }
        for( $i = 1 ; $i<= strlen($Name); $i++){
            $c = LCase(mid($Name, $i, 1)) ;
            if( instr('abcdefghijklmnopqrstuvwxyz_-.', $c) <= 0 && is_numeric($c) ){ $isValidEmail = false ; return @$isValidEmail; }
        }
        if( substr($Name, 0 , 1) == '.' || substr($Name, - 1) == '.' ){ $isValidEmail = false ; return @$isValidEmail; }
    }
    if( instr($names[1], '.') <= 0 ){ $isValidEmail = false ; return @$isValidEmail; }
    $i = strlen($names[1]) - strrpos($names[1], '.') ;
    if( $i <> 2 && $i <> 3 ){ $isValidEmail = false ; return @$isValidEmail; }
    if( instr($email, '..') > 0 ){ $isValidEmail = false ;}
    return @$isValidEmail;
}
//检测为有效字符
function isCode( $content){
    $c ='';
    $c = Replace($content, ' ', '') ;
    $c = Replace($c, Chr(13), '') ;
    $c = Replace($c, Chr(10), '') ;
    $c = Replace($c, "\t", '') ;
    $isCode = IIF($c <> '', true, false) ;
    return @$isCode;
}
//测试是否为数字
function checkNumber( $content){
    $i=''; $s ='';
    if( strlen($content) == 0 ){ $checkNumber = false ; return @$checkNumber; }
    $checkNumber = true ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( instr('0123456789', LCase($s)) == false ){
            $checkNumber = false ;
            return @$checkNumber;
        }
    }
    return @$checkNumber;
}
//测试是否为数字 (辅助)
function isNumber( $content){
    $isNumber = checkNumber($content) ;
    return @$isNumber;
}
//测试是否为字母
function checkABC( $content){
    $i=''; $s ='';
    $checkABC = true ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( instr('abcdefghijklmnopqrstuvwxyz', LCase($s)) == false ){
            $checkABC = false ;
            return @$checkABC;
        }
    }
    return @$checkABC;
}
//获得字符长度 汉字算两个字符
function getLen($content){
    $i=''; $s=''; $n ='';
    $n = 0 ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = Asc(mid(CStr($content), $i, 1)) ;
        if( $s < 0 ){
            $n = $n + 2 ;
        }else{
            $n = $n + 1 ;
        }
    }
    $getLen = $n ;
    return @$getLen;
}
//测试是否为时间类型
function checkTime($DateTime){
    $checkTime = IIF(IsDate($DateTime) == false, false, true) ;
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
    $foundInArr = false ;
    if( instr($strArr, $strSplit) > 0 ){
        $arrTemp = aspSplit($strArr, $strSplit) ;
        for( $i = 0 ; $i<= UBound($arrTemp); $i++){
            if( LCase(AspTrim($arrTemp[$i])) == LCase(AspTrim($strToFind)) ){
                $foundInArr = true ; break;
            }
        }
    }else{
        if( LCase(AspTrim($strArr)) == LCase(AspTrim($strToFind)) ){ $foundInArr = true ;}
    }
    return @$foundInArr;
}
?>