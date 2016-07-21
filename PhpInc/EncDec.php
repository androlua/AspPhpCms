<?PHP
//加密解密(2014)


//特殊Html上传加密解密 20150121 specialHtmlUploadEncryptionDecrypt(Content,"Decrypt")
function specialHtmlUploadEncryptionDecrypt($content, $sType){
    $splStr=''; $splxx=''; $c=''; $s ='';
    $c= '·|[*-24156*]' . vbCrlf();
    $splStr= aspSplit($c, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( inStr($s, '|') > 0 ){
            $splxx= aspSplit($s, '|');
            if( $sType== '1' || $sType== '解密' || $sType== 'Decrypt' ){
                $content= replace($content, $splxx[1], $splxx[0]);
            }else{
                $content= replace($content, $splxx[0], $splxx[1]);
            }
        }
    }
    $specialHtmlUploadEncryptionDecrypt= $content;
    return @$specialHtmlUploadEncryptionDecrypt;
}

//加密ASP代码内容
function encAspContent( $content){
    $splStr=''; $c=''; $s=''; $THStr ='';
    $c= 'Str=Str&"|Str=Str & |If | Then|End If|&vbCrlf|Temp |Rs(|Rs.|.AddNew|("Title")|("Content")|=False|ElseIf|';
    $c= $c . 'Conn.Execute("| Exit For|[Product]|.Open|.Close|Exit For|Exit Function|MoveNext:Next:|Str ';
    $splStr= aspSplit($c, '|');
    foreach( $splStr as $key=>$s){
        if( $s <> '' ){
            $THStr= upperCaseORLowerCase($s);
            $content= replace($content, chr(9), ''); //Chr(9) = Tab
            $content= replace($content, $s, $THStr);
        }
    }
    $encAspContent= $content;
    return @$encAspContent;
}
//让大小写乱掉
function upperCaseORLowerCase( $content){
    $i=''; $s=''; $c=''; $nRnd ='';
    $c= '';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);

        $nRnd= CInt(rnd() * 1);
        if( $nRnd== 0 ){
            $c= $c . lCase($s);
        }else{
            $c= $c . uCase($s);
        }
    }
    $upperCaseORLowerCase= $c;
    return @$upperCaseORLowerCase;
}
//加密  Encryption
function encCode( $content){
    $i=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($content); $i++){
        $c= $c . '%' . hex(asc(mid($content, $i, 1)));
    }
    $encCode= $c;
    return @$encCode;
}
//解密  Decrypt
function decCode( $content){
    $i=''; $c=''; $splStr ='';
    $c= '';
    $splStr= aspSplit($content, '%');
    for( $i= 1 ; $i<= uBound($splStr); $i++){
        if( $splStr[$i] <> '' ){
            $c= $c . chr(CInt('&H' . $splStr[$i]));
        }
    }
    $decCode= $c;
    return @$decCode;
}
//将汉字等转换为&#开头的unicode字符串形式
function toUnicode($str){
    $i=''; $j=''; $c=''; $p ='';
    $toUnicode= '';
    $c= '';
    $p= '';
    for( $i= 1 ; $i<= len($str); $i++){
        $c= mid($str, $i, 1);
        $j= ascW($c);
        if( $j < 0 ){
            $j= $j + 65536;
        }
        if( $j >= 0 && $j <= 128 ){
            if( $p== 'c' ){
                $toUnicode= ' ' . toUnicode;
                $p= 'e';
            }
            $toUnicode= $toUnicode . $c;
        }else{
            if( $p== 'e' ){
                $toUnicode= $toUnicode . ' ';
                $p= 'c';
            }
            $toUnicode= $toUnicode . '&#' . $j . ';';
        }
    }
    return @$toUnicode;
}
//日文26字母编码
function japan( $iStr, $sType){
    if( isNull($iStr) || $GLOBALS['IsEmpty'][$iStr] ){
        $japan= '';
        return @$japan;
    }
    $f=''; $i=''; $e ='';
    if( $sType== '' ){ $sType= 0 ;}
    //F=array("ゴ","ガ","ギ","グ","ゲ","ザ","ジ","ズ","ヅ","デ",_
    //"ド","ポ","ベ","プ","ビ","パ","ヴ","ボ","ペ","ブ","ピ","バ",_
    //"ヂ","ダ","ゾ","ゼ")
    //E = Array("Jn0;", "Jn1;", "Jn2;", "Jn3;", "Jn4;", "Jn5;", "Jn6;", "Jn7;", "Jn8;", "Jn9;", "Jn10;", "Jn11;", "Jn12;", "Jn13;", "Jn14;", "Jn15;", "Jn16;", "Jn17;", "Jn18;", "Jn19;", "Jn20;", "Jn21;", "Jn22;", "Jn23;", "Jn24;", "Jn25;")
    $e= aspSplit('Jn0;,Jn1;,Jn2;,Jn3;,Jn4;,Jn5;,Jn6;,Jn7;,Jn8;,Jn9;,Jn10;,Jn11;,Jn12;,Jn13;,Jn14;,Jn15;,Jn16;,Jn17;,Jn18;,Jn19;,Jn20;,Jn21;,Jn22;,Jn23;,Jn24;,Jn25;', ',');

    //F = Array(Chr( -23116), Chr( -23124), Chr( -23122), Chr( -23120),    Chr(-23118), Chr( -23114), Chr( -23112), Chr( -23110),     Chr(-23099), Chr( -23097), Chr( -23095), Chr( -23075),   Chr(-23079), Chr( -23081), Chr( -23085), Chr( -23087),  Chr(-23052), Chr( -23076), Chr( -23078), Chr( -23082),  Chr(-23084), Chr( -23088), Chr( -23102), Chr( -23104), Chr(-23106), Chr( -23108))
    $f= aspSplit(chr( -23116) . ',' . chr( -23124) . ',' . chr( -23122) . ',' . chr( -23120) . ',' . chr( -23118) . ',' . chr( -23114) . ',' . chr( -23112) . ',' . chr( -23110) . ',' . chr( -23099) . ',' . chr( -23097) . ',' . chr( -23095) . ',' . chr( -23075) . ',' . chr( -23079) . ',' . chr( -23081) . ',' . chr( -23085) . ',' . chr( -23087) . ',' . chr( -23052) . ',' . chr( -23076) . ',' . chr( -23078) . ',' . chr( -23082) . ',' . chr( -23084) . ',' . chr( -23088) . ',' . chr( -23102) . ',' . chr( -23104) . ',' . chr( -23106) . ',' . chr( -23108), ',');
    $japan= $iStr;
    for( $i= 0 ; $i<= 25; $i++){
        if( $sType== 0 ){
            $japan= replace(japan, $f[$i], $e[$i]);
        }else{
            $japan= replace(japan, $e[$i], $f[$i]);
        }
    }
    return @$japan;
}
//日文26字母 加密
function japan26($iStr){
    $japan26= japan($iStr, 0);
    return @$japan26;
}
//日文26字母 解密
function unJapan26($iStr){
    $unJapan26= japan($iStr, 1);
    return @$unJapan26;
}
//处理内容让它成为纯HTML代码
function handleHTML( $content){
    //Content = Replace(Content, "&", "&amp;")
    $content= replace($content, '<', '&lt;');
    $handleHTML= $content;
    return @$handleHTML;
}
//解开 处理内容让它成为纯HTML代码
function unHandleHTML( $content){
    //Content = Replace(Content, "&amp;", "&")
    $content= replace($content, '&lt;', '<');
    $unHandleHTML= $content;
    return @$unHandleHTML;
}
//小写加密   [可扩展为大写与数字]
function lcaseEnc($str){
    $i=''; $n=''; $s=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($str); $i++){
        $s= mid($str, $i, 1);
        $n= ascW($s);
        if( $n >= 97 && $n <= 122 ){
            $c= $c . chr($n + 1);
        }else{
            $c= $c . $s;
        }
    }
    $c= replace($c, vbCrlf(), '＠');
    $lcaseEnc= $c;
    return @$lcaseEnc;
}
//小写解密
function lcaseDec($str){
    $i=''; $n=''; $s=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($str); $i++){
        $s= mid($str, $i, 1);
        $n= ascW($s);
        if( $n >= 97 && $n <= 123 ){
            $c= $c . chr($n - 1);
        }else{
            $c= $c . $s;
        }
    }
    $c= replace($c, '＠', vbCrlf());
    $lcaseDec= $c;
    return @$lcaseDec;
}

//html转换成js
function htmlToJs( $c){
    $c= replace('' . $c, '\\', '\\\\');
    $c= replace($c, '/', '\\/');
    $c= replace($c, '\'', '\\\'');
    $c= replace($c, '"', '\\"');
    $c= join(aspSplit($c, vbCrlf()), '");' . vbCrlf() . 'document.write("');
    $c= 'document.write("' . $c . '");';
    $htmlToJs= $c;
    return @$htmlToJs;
}
//js转换成html
function jsToHtml( $c){
    $c= replace($c, 'document.write("', '');
    $c= replace($c, '");', '');
    $c= replace($c, '\\"', '"');
    $c= replace($c, '\\\'', '\'');
    $c= replace($c, '\\/', '/');
    $c= replace($c, '\\\\', '\\');
    $jsToHtml= $c;
    return @$jsToHtml;
}
//html转换成Asp
function htmlToAsp( $c){
    $c= replace($c, '"', '""');
    $c= join(aspSplit($c, vbCrlf()), '")' . vbCrlf() . 'Response.Write("');
    $c= 'Response.Write("' . $c . '")';
    $htmlToAsp= $c;
    return @$htmlToAsp;
}
//Html转Asp变量存储
function htmlToAspDim( $c){
    $c= replace($c, '"', '""');
    $c= join(aspSplit($c, vbCrlf()), '"' . vbCrlf() . 'C=C & "');
    $c= 'C=C & "' . $c . '"';
    $htmlToAspDim= $c;
    return @$htmlToAspDim;
}
//Asp转换成html
function aspToHtml( $c){
    $c= replace($c, 'Response.Write("', '');
    $c= replace($c, '""', '"');
    $aspToHtml= $c;
    return @$aspToHtml;
}
//文件命名规则
function setFileName( $fileName){
    $i=''; $s='';$tStr='';$splstr='';$splReplace='';
    $splstr=array('\\','/',':','*','?','"','<','>','|','.',',');					//换这种方法是为了与PHP版通用 20160511
    $splReplace=array('撇','揦','：','星','？','“','左','右','横','。','，');
    for( $i=0 ; $i<= uBound($splstr); $i++){
        $s=$splstr[$i];
        $tStr=$splReplace[$i];
        $fileName= replace($fileName, $s, $tStr);
    }
    $fileName= replace($fileName, '&nbsp;', ' ');
    $fileName= replace($fileName, '&quot;', '双');
    $fileName= replace($fileName, vbCrlf(), '');
    $setFileName= $fileName;
    return @$setFileName;
}
//文件命名规则解开
function unSetFileName( $fileName){
    $i=''; $s='';$tStr='';$splstr='';$splReplace='';

    $splstr=array('\\','/',':','*','?','"','<','>','|','.',',');
    $splReplace=array('撇','揦','：','星','？','“','左','右','横','。','，');
    for( $i=0 ; $i<= uBound($splstr); $i++){
        $s=$splstr[$i];
        $tStr=$splReplace[$i];
        $fileName= replace($fileName, $tStr,$s);
    }

    $unSetFileName= $fileName;
    return @$unSetFileName;
}

//把Html转成ASP，并且字符转成Chr(*)样式
function HTMLToAscChr($title){
    $i=''; $s=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($title); $i++){
        $s= mid($title, $i, 1);
        $c= $c . 'Chr(' . asc($s) . ')&';
    }
    if( $c <> '' ){ $c= left($c, len($c) - 1); }
    $HTMLToAscChr= $c;
    //HTMLToAscChr = "<" & "%=" & C & "%" & ">"
    return @$HTMLToAscChr;
}
//解密AscChr
function unHTMLToAscChr($content){
    $i=''; $s=''; $c=''; $splStr=''; $temp ='';
    $c= $content ; $temp= '';
    $c= replace($c, 'Chr(', '');
    $c= replace($c, ')&', ' ');
    $c= replace($c, ')', ' ');
    $splStr= aspSplit($c, ' ');
    for( $i= 0 ; $i<= uBound($splStr) - 1; $i++){
        $s= $splStr[$i];
        $temp= $temp . chr($s);
    }
    $unHTMLToAscChr= $temp;
    return @$unHTMLToAscChr;
}

//变量移位
function variableDisplacement($content, $nPass){
    $c=''; $i=''; $s=''; $LetterGroup=''; $DigitalGroup=''; $nLetterGroup=''; $nDigitalGroup=''; $nLetterLen=''; $nDigitalLen=''; $nX ='';
    //字母组
    //LetterGroup="abcdefghijklmnopqrstuvwxyz"
    $LetterGroup= 'yzoehijklmfgqrstuvpabnwxcd';
    //字母长
    $nLetterGroup= len($LetterGroup);
    //数字组
    //DigitalGroup="0123456789"
    $DigitalGroup= '4539671820';
    //数字长
    $nDigitalGroup= len($DigitalGroup);
    $c= '';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        $nLetterLen= inStr($LetterGroup, $s);
        $nDigitalLen= inStr($DigitalGroup, $s);
        //字母处理
        if( $nLetterLen > 0 ){
            $nX= $nLetterLen + $nPass;
            if( $nX > $nLetterGroup ){
                $nX= $nX - $nLetterGroup;
            }else if( $nX <= 0 ){
                //Call Echo("nX",nX & "," & (nLetterGroup - nX) & "/" & nLetterGroup)
                $nX= $nX + $nLetterGroup;
            }
            $s= mid($LetterGroup, $nX, 1);
            //数字处理
        }else if( $nDigitalLen > 0 ){
            $nX= $nDigitalLen + $nPass;
            if( $nX > $nDigitalGroup ){
                $nX= $nX - $nDigitalGroup;
            }else if( $nX <= 0 ){
                //Call Echo("nX",nX & "," & (nLetterGroup - nX) & "/" & nLetterGroup)
                $nX= $nX + $nDigitalGroup;
            }
            $s= mid($DigitalGroup, $nX, 1);


        }
        $c= $c . $s;
    }
    $variableDisplacement= $c;
    return @$variableDisplacement;
}


?>