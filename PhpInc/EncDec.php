<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-29
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By AspPhpCMS 
************************************************************/
?>
<?PHP
//���ܽ���(2014)


//����Html�ϴ����ܽ��� 20150121 specialHtmlUploadEncryptionDecrypt(Content,"Decrypt")
function specialHtmlUploadEncryptionDecrypt($content, $sType){
    $splStr=''; $splxx=''; $c=''; $s ='';
    $c = '��|[*-24156*]' . "\n" ;
    $splStr = aspSplit($c, "\n") ;
    foreach( $splStr as $s){
        if( instr($s, '|') > 0 ){
            $splxx = aspSplit($s, '|') ;
            if( $sType == '1' || $sType == '����' || $sType == 'Decrypt' ){
                $content = Replace($content, $splxx[1], $splxx[0]) ;
            }else{
                $content = Replace($content, $splxx[0], $splxx[1]) ;
            }
        }
    }
    $specialHtmlUploadEncryptionDecrypt = $content ;
    return @$specialHtmlUploadEncryptionDecrypt;
}

//����ASP��������
function encAspContent( $content){
    $splStr=''; $c=''; $s=''; $THStr ='';
    $c = 'Str=Str&"|Str=Str & |If | Then|End If|&vbCrlf|Temp |Rs(|Rs.|.AddNew|("Title")|("Content")|=False|ElseIf|' ;
    $c = $c . 'Conn.Execute("| Exit For|[Product]|.Open|.Close|Exit For|Exit Function|MoveNext:Next:|Str ' ;
    $splStr = aspSplit($c, '|') ;
    foreach( $splStr as $s){
        if( $s <> '' ){
            $THStr = UpperCaseORLowerCase($s) ;
            $content = Replace($content, Chr(9), '') ;//Chr(9) = Tab
            $content = Replace($content, $s, $THStr) ;
        }
    }
    $encAspContent = $content ;
    return @$encAspContent;
}
//�ô�Сд�ҵ�
function upperCaseORLowerCase( $content){
    $i=''; $s=''; $c=''; $nRnd ='';
    $c = '' ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;

        $nRnd = intval(rnd() * 1) ;
        if( $nRnd == 0 ){
            $c = $c . LCase($s) ;
        }else{
            $c = $c . UCase($s) ;
        }
    }
    $upperCaseORLowerCase = $c ;
    return @$upperCaseORLowerCase;
}
//����  Encryption
function encCode( $content){
    $i=''; $c ='';
    $c = '' ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $c = $c . '%' . Hex(Asc(mid($content, $i, 1))) ;
    }
    $encCode = $c ;
    return @$encCode;
}
//����  Decrypt
function decCode( $content){
    $i=''; $c=''; $splStr ='';
    $c = '' ;
    $splStr = aspSplit($content, '%') ;
    for( $i = 1 ; $i<= UBound($splStr); $i++){
        if( $splStr[$i] <> '' ){
            $c = $c . Chr(intval('&H' . $splStr[$i])) ;
        }
    }
    $decCode = $c ;
    return @$decCode;
}
//�����ֵ�ת��Ϊ&#��ͷ��unicode�ַ�����ʽ
function toUnicode($str){
    $i=''; $j=''; $c=''; $p ='';
    $toUnicode = '' ;
    $c = '' ;
    $p = '' ;
    for( $i = 1 ; $i<= strlen($str); $i++){
        $c = mid($str, $i, 1) ;
        $j = AscW($c) ;
        if( $j < 0 ){
            $j = $j + 65536 ;
        }
        if( $j >= 0 && $j <= 128 ){
            if( $p == 'c' ){
                $toUnicode = ' ' . toUnicode ;
                $p = 'e' ;
            }
            $toUnicode = toUnicode . $c ;
        }else{
            if( $p == 'e' ){
                $toUnicode = toUnicode . ' ' ;
                $p = 'c' ;
            }
            $toUnicode = toUnicode . '&#' . $j . ';' ;
        }
    }
    return @$toUnicode;
}
//����26��ĸ����
function japan( $iStr, $sType){
    if( IsNull($iStr) || $GLOBALS['IsEmpty'][$iStr] ){
        $japan = '' ;
        return @$japan;
    }
    $f=''; $i=''; $e ='';
    if( $sType == '' ){ $sType = 0 ;}
    //F=array("��","��","��","��","��","��","��","��","��","��",_
    //"��","��","��","��","��","��","��","��","��","��","��","��",_
    //"��","��","��","��")
    //E = Array("Jn0;", "Jn1;", "Jn2;", "Jn3;", "Jn4;", "Jn5;", "Jn6;", "Jn7;", "Jn8;", "Jn9;", "Jn10;", "Jn11;", "Jn12;", "Jn13;", "Jn14;", "Jn15;", "Jn16;", "Jn17;", "Jn18;", "Jn19;", "Jn20;", "Jn21;", "Jn22;", "Jn23;", "Jn24;", "Jn25;")
    $e = aspSplit('Jn0;,Jn1;,Jn2;,Jn3;,Jn4;,Jn5;,Jn6;,Jn7;,Jn8;,Jn9;,Jn10;,Jn11;,Jn12;,Jn13;,Jn14;,Jn15;,Jn16;,Jn17;,Jn18;,Jn19;,Jn20;,Jn21;,Jn22;,Jn23;,Jn24;,Jn25;', ',') ;

    //F = Array(Chr( -23116), Chr( -23124), Chr( -23122), Chr( -23120),    Chr(-23118), Chr( -23114), Chr( -23112), Chr( -23110),     Chr(-23099), Chr( -23097), Chr( -23095), Chr( -23075),   Chr(-23079), Chr( -23081), Chr( -23085), Chr( -23087),  Chr(-23052), Chr( -23076), Chr( -23078), Chr( -23082),  Chr(-23084), Chr( -23088), Chr( -23102), Chr( -23104), Chr(-23106), Chr( -23108))
    $f = aspSplit(Chr( -23116) . ',' . Chr( -23124) . ',' . Chr( -23122) . ',' . Chr( -23120) . ',' . Chr( -23118) . ',' . Chr( -23114) . ',' . Chr( -23112) . ',' . Chr( -23110) . ',' . Chr( -23099) . ',' . Chr( -23097) . ',' . Chr( -23095) . ',' . Chr( -23075) . ',' . Chr( -23079) . ',' . Chr( -23081) . ',' . Chr( -23085) . ',' . Chr( -23087) . ',' . Chr( -23052) . ',' . Chr( -23076) . ',' . Chr( -23078) . ',' . Chr( -23082) . ',' . Chr( -23084) . ',' . Chr( -23088) . ',' . Chr( -23102) . ',' . Chr( -23104) . ',' . Chr( -23106) . ',' . Chr( -23108), ',') ;
    $japan = $iStr ;
    for( $i = 0 ; $i<= 25; $i++){
        if( $sType == 0 ){
            $japan = Replace(japan, $f[$i], $e[$i]) ;
        }else{
            $japan = Replace(japan, $e[$i], $f[$i]) ;
        }
    }
    return @$japan;
}
//����26��ĸ ����
function japan26($iStr){
    $japan26 = japan($iStr, 0) ;
    return @$japan26;
}
//����26��ĸ ����
function unJapan26($iStr){
    $unJapan26 = japan($iStr, 1) ;
    return @$unJapan26;
}
//��������������Ϊ��HTML����
function handleHTML( $content){
    //Content = Replace(Content, "&", "&amp;")
    $content = Replace($content, '<', '&lt;') ;
    $handleHTML = $content ;
    return @$handleHTML;
}
//�⿪ ��������������Ϊ��HTML����
function unHandleHTML( $content){
    //Content = Replace(Content, "&amp;", "&")
    $content = Replace($content, '&lt;', '<') ;
    $unHandleHTML = $content ;
    return @$unHandleHTML;
}
//Сд����   [����չΪ��д������]
function lcaseEnc($str){
    $i=''; $n=''; $s=''; $c ='';
    $c = '' ;
    for( $i = 1 ; $i<= strlen($str); $i++){
        $s = mid($str, $i, 1) ;
        $n = AscW($s) ;
        if( $n >= 97 && $n <= 122 ){
            $c = $c . chr($n + 1) ;
        }else{
            $c = $c . $s ;
        }
    }
    $c = Replace($c, "\n", '��') ;
    $lcaseEnc = $c ;
    return @$lcaseEnc;
}
//Сд����
function lcaseDec($str){
    $i=''; $n=''; $s=''; $c ='';
    $c = '' ;
    for( $i = 1 ; $i<= strlen($str); $i++){
        $s = mid($str, $i, 1) ;
        $n = AscW($s) ;
        if( $n >= 97 && $n <= 123 ){
            $c = $c . chr($n - 1) ;
        }else{
            $c = $c . $s ;
        }
    }
    $c = Replace($c, '��', "\n") ;
    $lcaseDec = $c ;
    return @$lcaseDec;
}



//htmlת����js
function htmlToJs( $c){
    $c = Replace('' . $c, '\\', '\\\\') ;
    $c = Replace($c, '/', '\\/') ;
    $c = Replace($c, '\'', '\\\'') ;
    $c = Replace($c, '"', '\\"') ;
    $c = Join(aspSplit($c, "\n"), '");' . "\n" . 'document.write("') ;
    $c = 'document.write("' . $c . '");' ;
    $htmlToJs = $c ;
    return @$htmlToJs;
}
//jsת����html
function jsToHtml( $c){
    $c = Replace($c, 'document.write("', '') ;
    $c = Replace($c, '");', '') ;
    $c = Replace($c, '\\"', '"') ;
    $c = Replace($c, '\\\'', '\'') ;
    $c = Replace($c, '\\/', '/') ;
    $c = Replace($c, '\\\\', '\\') ;
    $jsToHtml = $c ;
    return @$jsToHtml;
}
//htmlת����Asp
function htmlToAsp( $c){
    $c = Replace($c, '"', '""') ;
    $c = Join(aspSplit($c, "\n"), '")' . "\n" . 'Response.Write("') ;
    $c = 'Response.Write("' . $c . '")' ;
    $htmlToAsp = $c ;
    return @$htmlToAsp;
}
//HtmlתAsp�����洢
function htmlToAspDim( $c){
    $c = Replace($c, '"', '""') ;
    $c = Join(aspSplit($c, "\n"), '"' . "\n" . 'C=C & "') ;
    $c = 'C=C & "' . $c . '"' ;
    $htmlToAspDim = $c ;
    return @$htmlToAspDim;
}
//Aspת����html
function aspToHtml( $c){
    $c = Replace($c, 'Response.Write("', '') ;
    $c = Replace($c, '""', '"') ;
    $aspToHtml = $c ;
    return @$aspToHtml;
}
//�ļ���������
function setFileName( $fileName){
    $i=''; $s=''; $c=''; $tStr=''; $c2 ='';
    $c = '\\/:*?"<>|.,' ;
    $c2 = 'Ʋ�X���ǣ������Һᡣ��' ;
    for( $i = 1 ; $i<= strlen($c); $i++){
        $s = mid($c, $i, 1) ;
        $tStr = mid($c2, $i, 1) ;
        $fileName = Replace($fileName, $s, $tStr) ;
    }
    $fileName = Replace($fileName, '&nbsp;', ' ') ;
    $fileName = Replace($fileName, '&quot;', '˫') ;
    $fileName = Replace($fileName, "\n", '') ;
    $setFileName = $fileName ;
    return @$setFileName;
}
//�ļ���������⿪
function unSetFileName( $fileName){
    $i=''; $s=''; $c=''; $tStr=''; $c2 ='';
    $c = '\\/:*?"<>|.' ;
    $c2 = 'Ʋ�X���ǣ������Һᡣ��' ;

    for( $i = 1 ; $i<= strlen($c); $i++){
        $s = mid($c2, $i, 1) ;
        $tStr = mid($c, $i, 1) ;
        $fileName = Replace($fileName, $s, $tStr) ;
    }
    $unSetFileName = $fileName ;
    return @$unSetFileName;
}

//��Htmlת��ASP�������ַ�ת��Chr(*)��ʽ
function HTMLToAscChr($title){
    $i=''; $s=''; $c ='';
    $c = '' ;
    for( $i = 1 ; $i<= strlen($title); $i++){
        $s = mid($title, $i, 1) ;
        $c = $c . 'Chr(' . Asc($s) . ')&' ;
    }
    if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - 1) ;}
    $HTMLToAscChr = $c ;
    //HTMLToAscChr = "<" & "%=" & C & "%" & ">"
    return @$HTMLToAscChr;
}
//����AscChr
function unHTMLToAscChr($content){
    $i=''; $s=''; $c=''; $splStr=''; $temp ='';
    $c = $content ; $temp = '' ;
    $c = Replace($c, 'Chr(', '') ;
    $c = Replace($c, ')&', ' ') ;
    $c = Replace($c, ')', ' ') ;
    $splStr = aspSplit($c, ' ') ;
    for( $i = 0 ; $i<= UBound($splStr) - 1; $i++){
        $s = $splStr[$i] ;
        $temp = $temp . Chr($s) ;
    }
    $unHTMLToAscChr = $temp ;
    return @$unHTMLToAscChr;
}

//������λ
function variableDisplacement($content, $nPass){
    $c=''; $i=''; $s=''; $LetterGroup=''; $DigitalGroup=''; $nLetterGroup=''; $nDigitalGroup=''; $nLetterLen=''; $nDigitalLen=''; $nX ='';
    //��ĸ��
    //LetterGroup="abcdefghijklmnopqrstuvwxyz"
    $LetterGroup = 'yzoehijklmfgqrstuvpabnwxcd' ;
    //��ĸ��
    $nLetterGroup = strlen($LetterGroup) ;
    //������
    //DigitalGroup="0123456789"
    $DigitalGroup = '4539671820' ;
    //���ֳ�
    $nDigitalGroup = strlen($DigitalGroup) ;
    $c = '' ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $nLetterLen = instr($LetterGroup, $s) ;
        $nDigitalLen = instr($DigitalGroup, $s) ;
        //��ĸ����
        if( $nLetterLen > 0 ){
            $nX = $nLetterLen + $nPass ;
            if( $nX > $nLetterGroup ){
                $nX = $nX - $nLetterGroup ;
            }else if( $nX <= 0 ){
                //Call Echo("nX",nX & "," & (nLetterGroup - nX) & "/" & nLetterGroup)
                $nX = $nX + $nLetterGroup ;
            }
            $s = mid($LetterGroup, $nX, 1) ;
            //���ִ���
        }else if( $nDigitalLen > 0 ){
            $nX = $nDigitalLen + $nPass ;
            if( $nX > $nDigitalGroup ){
                $nX = $nX - $nDigitalGroup ;
            }else if( $nX <= 0 ){
                //Call Echo("nX",nX & "," & (nLetterGroup - nX) & "/" & nLetterGroup)
                $nX = $nX + $nDigitalGroup ;
            }
            $s = mid($DigitalGroup, $nX, 1) ;


        }
        $c = $c . $s ;
    }
    $variableDisplacement = $c ;
    return @$variableDisplacement;
}








?>