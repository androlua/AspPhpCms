<?PHP
//Check��֤ (2013,10,26)

//���URL�ļ������Ƿ����������:.js?  .css?  �÷� checkUrlFileNameParam("http://sdfsd.com/aaa.js","js|css|")
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

//�Ǵ�д 20160105
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
//��Сд 20160105
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


//������


//���ַ�trueת������ falseת������
function strToTrueFalse( $content){
    $content= aspTrim(lCase($content));
    $strToTrueFalse= IIF($content== 'true', true, false);
    return @$strToTrueFalse;
}
//���ַ�trueת1���� falseת0����
function strTrueFalseToInt( $content){
    $content= aspTrim(lCase($content));
    $strTrueFalseToInt= IIF($content== 'true', 1, 0);
    return @$strTrueFalseToInt;
}
//��黻��
function checkVbCrlf($content){
    $checkVbCrlf= false;
    if( inStr($content, vbCrlf()) > 0 ){ $checkVbCrlf= true ;}
    return @$checkVbCrlf;
}
//��黻��    ����
function checkBr($content){
    $checkBr= checkVbCrlf($content);
    return @$checkBr;
}

//�ж�������ż
function isParity($Numb){
    $isParity= '';
    if( is_numeric($Numb) ){
        $isParity= '�ⲻ��һ�����ְ�';
        return @$isParity;
    }
    if( $Numb % 2== 0 ){
        $isParity= 0;
    }else{
        $isParity= 1;
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
    if( isNull($fString) ){
        $replace_SQLText= '';
        return @$replace_SQLText;
    }else{
        $fString= aspTrim($fString);
        $fString= replace($fString, '\'', '\'\'');
        $fString= replace($fString, ';', '��');
        $fString= replace($fString, '--', '��');
        $fString= displayHtml($fString);
        $replace_SQLText= $fString;
    }
    return @$replace_SQLText;
}
//********************************************************
//����Ƿ��ⲿ�ύ����
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
//��������֤����
function isMail($email){ //���պ���
}
//������֤�ڶ���
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
//���Ϊ��Ч�ַ�
function isCode( $content){
    $c ='';
    $c= replace($content, ' ', '');
    $c= replace($c, chr(13), '');
    $c= replace($c, chr(10), '');
    $c= replace($c, vbTab(), '');
    $isCode= IIF($c <> '', true, false);
    return @$isCode;
}
//�����Ƿ�Ϊ����
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
//�����Ƿ�Ϊ���� (����)
function isNumber( $content){
    $isNumber= checkNumber($content);
    return @$isNumber;
}
//�����Ƿ�Ϊ��ĸ
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
//����ַ����� �����������ַ�
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
//�����Ƿ�Ϊʱ������
function checkTime($DateTime){
    $checkTime= IIF(isDate($DateTime)== false, false, true);
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