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
<?PHP
//Check��֤ (2013,10,26)

//���URL�ļ������Ƿ����������:.js?  .css?  �÷� checkUrlFileNameParam("http://sdfsd.com/aaa.js","js|css|")
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

//�Ǵ�д 20160105
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
//��Сд 20160105
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


//������


//���ַ�trueת������ falseת������
function strToTrueFalse( $content){
    $content = AspTrim(LCase($content)) ;
    $strToTrueFalse = IIF($content == 'true', true, false) ;
    return @$strToTrueFalse;
}
//���ַ�trueת1���� falseת0����
function strTrueFalseToInt( $content){
    $content = AspTrim(LCase($content)) ;
    $strTrueFalseToInt = IIF($content == 'true', 1, 0) ;
    return @$strTrueFalseToInt;
}
//��黻��
function checkVbCrlf($content){
    $checkVbCrlf = false ;
    if( instr($content, vbCrlf()) > 0 ){ $checkVbCrlf = true ;}
    return @$checkVbCrlf;
}
//��黻��    ����
function checkBr($content){
    $checkBr = checkVbCrlf($content) ;
    return @$checkBr;
}

//�ж�������ż
function isParity($Numb){
    $isParity = '' ;
    if( is_numeric($Numb) ){
        $isParity = '�ⲻ��һ�����ְ�' ;
        return @$isParity;
    }
    if( $Numb % 2 == 0 ){
        $isParity = 0 ;
    }else{
        $isParity = 1 ;
    }
    return @$isParity;
}
//���eval��ȷ��
function checkEval($content){ //���պ���
}
//********************************************************
//����SQL�Ƿ��ַ�����ʽ��html����
//********************************************************
function replace_SQLText($fString){
    if( IsNull($fString) ){
        $replace_SQLText = '' ;
        return @$replace_SQLText;
    }else{
        $fString = AspTrim($fString) ;
        $fString = Replace($fString, '\'', '\'\'') ;
        $fString = Replace($fString, ';', '��') ;
        $fString = Replace($fString, '--', '��') ;
        $fString = $GLOBALS['HTMLEncode'][$fString] ;
        $replace_SQLText = $fString ;
    }
    return @$replace_SQLText;
}
//********************************************************
//����Ƿ��ⲿ�ύ����
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
//��������֤����
function isMail($email){ //���պ���
}
//������֤�ڶ���
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
//���Ϊ��Ч�ַ�
function isCode( $content){
    $c ='';
    $c = Replace($content, ' ', '') ;
    $c = Replace($c, Chr(13), '') ;
    $c = Replace($c, Chr(10), '') ;
    $c = Replace($c, "\t", '') ;
    $isCode = IIF($c <> '', true, false) ;
    return @$isCode;
}
//�����Ƿ�Ϊ����
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
//�����Ƿ�Ϊ���� (����)
function isNumber( $content){
    $isNumber = checkNumber($content) ;
    return @$isNumber;
}
//�����Ƿ�Ϊ��ĸ
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
//����ַ����� �����������ַ�
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
//�����Ƿ�Ϊʱ������
function checkTime($DateTime){
    $checkTime = IIF(IsDate($DateTime) == false, false, true) ;
    return @$checkTime;
}
//�ж��Ƿ�Ϊ��
function isNul( $s){ return ''; return ''; return ''; return ''; return ''; return ''; return ''; //���պ���
}


//****************************************************
//��������FoundInArr
//��  �ã����һ������������Ԫ���Ƿ����ָ���ַ���
//ʱ  �䣺2011��10��13��
//��  ���� strArr
//strToFind
//strSplit
//����ֵ���ַ���
//��  �ԣ�SHtml=R_("{����}",Function FoundInArr(strArr, strToFind, strSplit))
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