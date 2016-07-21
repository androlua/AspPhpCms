<?PHP

//判断是否为字符转义
function isStrTransferred($content){
    $splstr='';$i='';$s='';$nCount='';
    $nCount=0;
    for( $i= 0 ; $i<= len($content)-1; $i++){
        $s=mid($content,len($content)-$i,1);
        if( $s=='\\' ){
            $nCount=$nCount+1;
        }else{
            $isStrTransferred=IIF($nCount % 2==1,true,false);
            return @$isStrTransferred;
        }
    }
    return @$isStrTransferred;
}

//计算比率，游戏开发中用到 20150601
function getBL($setWidth, $setHeight, $nDanFuXianZhi){
    $splStr=aspArray(3);
    $nWidthZheFu =''; $nWidthZheFu= 1; //宽正负
    $nHeightZheFu =''; $nHeightZheFu= 1; //高正负
    $nBFB ='';//百分比
    $nXXFBX ='';//每个百分比，因为要判断他不能超过10
    if( $setWidth < 0 ){
        $setWidth= $setWidth * - 1;
        $nWidthZheFu= -1;
    }
    if( $setHeight < 0 ){
        $setHeight= $setHeight * - 1;
        $nHeightZheFu= -1;
    }
    if( $setWidth > $setHeight ){
        $nBFB= formatNumber($setWidth / $setHeight, 2); ////长宽 百分比
        $splStr[0]= $nBFB;
        $splStr[1]= 1;
    }else{
        $nBFB= formatNumber($setHeight / $setWidth, 2); ////高宽 百分比
        $splStr[0]= 1;
        $splStr[1]= $nBFB;
    }
    //每步超出指定值，处理
    //if nBFB>=nDanFuXianZhi then
    $nXXFBX= formatNumber($nDanFuXianZhi / $nBFB, 2);
    $splStr[0]= $splStr[0] * $nXXFBX;
    $splStr[1]= $splStr[1] * $nXXFBX;
    //end if

    $splStr[0]= $splStr[0] * $nWidthZheFu;
    $splStr[1]= $splStr[1] * $nHeightZheFu;
    $splStr[2]= $nBFB;
    $splStr[3]= getCountPage($setWidth, $splStr[0]);
    //Call echo("page count 页数", splStr(3))
    $splStr[3]= getCountStep($setWidth, $setHeight, $splStr[0], $splStr[1], $splStr[3]);

    $getBL= $splStr;
    return @$getBL;
}

//获得总步数
function getCountStep($nWidthStep, $nHeightStep, $nWidthBL, $nHeightBL, $nCountPage){
    $i ='';
    $getCountStep= '';
    if( $nWidthStep < 0 ){
        $nWidthStep= $nWidthStep * - 1;
    }
    if( $nHeightStep < 0 ){
        $nHeightStep= $nHeightStep * - 1;
    }
    if( $nWidthBL < 0 ){
        $nWidthBL= $nWidthBL * - 1;
    }
    if( $nHeightBL < 0 ){
        $nHeightBL= $nHeightBL * - 1;
    }
    for( $i= $nCountPage - 10 ; $i<= $nCountPage; $i++){
        //call echo(i & "、nWidthBL*i>=nWidthStep",nWidthBL*i &">="&nWidthStep    & "   |  " & nHeightBL*i &">="& nHeightStep)
        if( $nWidthBL * $i >= $nWidthStep || $nHeightBL * $i >= $nHeightStep ){
            $getCountStep= $i;
            //call echo("getCountStep",getCountStep)
        }
    }
    return @$getCountStep;
}


//获得中文汉字内容
function getChina($content){
    $i=''; $c=''; $j=''; $s ='';
    for( $i= 1 ; $i<= len($content); $i++){
        $j= asc(mid($content, $i, 1));
        $s= mid($content, $i, 1);
        //是汉字累加
        if( $j < 0 ){
            if(($j <= -22033 && $j >= -24158)== false ){
                $c= $c . $s;
            }
        }
    }
    $getChina= $c;
    return @$getChina;
}
//判断是否有中文
function isChina($content){
    $i=''; $j=''; $s ='';
    for( $i= 1 ; $i<= len($content); $i++){
        $j= asc(mid($content, $i, 1));
        $s= mid($content, $i, 1);
        //是汉字累加
        if( $j < 0 ){
            if(($j <= -22033 && $j >= -24158)== false ){
                $isChina=true;
                return @$isChina;
            }
        }
    }
    $isChina=false;
    return @$isChina;
}
//判断是否有中文 (辅助)
function checkChina($content){
    $checkChina=isChina($content);
    return @$checkChina;
}

//PHP里Rand使用20150212


//引用上面，为什么？因为我老写错这个单词



//删除重复内容  20141220
function deleteRepeatStr($content, $SplType){
    $splStr=''; $s=''; $c ='';
    $c= '';
    $splStr= aspSplit($content, $SplType);
    foreach( $splStr as $key=>$s){
        if( $s <> '' ){
            if( inStr($SplType . $c . $SplType, $SplType . $s . $SplType)== false ){
                $c= $c . $s . $SplType;
            }
        }
    }
    if( $c <> '' ){ $c= left($c, len($c) - len($SplType)); }
    $deleteRepeatStr= $c;
    return @$deleteRepeatStr;
}

//替换内容N次 20141220
function replaceN($content, $YunStr, $ReplaceStr, $nNumb){
    $i ='';
    $nNumb= handleNumber($nNumb);
    if( $nNumb== '' ){
        $nNumb= 1;
    }else{
        $nNumb= CInt($nNumb);
    }
    for( $i= 1 ; $i<= $nNumb; $i++){
        $content= replace($content, $YunStr, $ReplaceStr);
    }

    $replaceN= $content;
    return @$replaceN;
}

//asp日期补0函数   引用别人20141216
function fillZero($content){
    if( len($content)== 1 ){
        $fillZero= '0' . $content;
    }else{
        $fillZero= $content;
    }
    return @$fillZero;
}

//不分大小写替换，作者：小云，写于20140925 用法Response.Write(CaseInsensitiveReplace("112233aabbbccddee","b","小云你牛"))
function caseInsensitiveReplace($content, $Check_Str, $Replace_Str){
    $StartLen=''; $EndLen=''; $LowerCase=''; $startStr=''; $endStr=''; $c=''; $i ='';
    $c= '';
    if( lCase($Check_Str)== lCase($Replace_Str) ){
        $caseInsensitiveReplace= $content;
    }
    $LowerCase= lCase($content);
    for( $i= 1 ; $i<= 99; $i++){
        if( inStr($LowerCase, $Check_Str) > 0 ){
            $StartLen= inStr($LowerCase, $Check_Str) - 1;
            $startStr= left($content, $StartLen);
            $EndLen= $StartLen + len($Check_Str) + 1;
            $endStr= mid($content, $EndLen,-1);
            $content= $startStr . $Replace_Str . $endStr;
            //Call Echo(StartLen,EndLen)
            //Call Echo(StartStr,EndStr)
            //Call Echo("Content",Content)
            $LowerCase= lCase($content);
        }else{
            break;
        }
    }
    $caseInsensitiveReplace= $content;
    return @$caseInsensitiveReplace;
}

//数组数字排序 (2013,10,1)
function array_Sort($sArray){
    $i=''; $j=''; $MinmaxSlot=''; $Minmax=''; $temp ='';
    for( $i= uBound($sArray) ; $i>= 0 ; $i--){
        $Minmax= $sArray[$i];
        $MinmaxSlot= 0;
        for( $j= 1 ; $j<= $i; $j++){
            if( $sArray[$j] > $Minmax ){
                $Minmax= $sArray[$j];
                $MinmaxSlot= $j;
            }
        }
        if( $MinmaxSlot <> $i ){
            $temp= $sArray[$MinmaxSlot];
            $sArray[$MinmaxSlot]= $sArray[$i];
            $sArray[$i]= $temp;
        }
    }
    $array_Sort= $sArray;
    return @$array_Sort;
}

//处理Zip大小
function handleZipSize( $ZipSize){

    $nSize ='';
    $ZipSize= lCase($ZipSize);
    $nSize= getDianNumb($ZipSize);
    if( inStr($ZipSize, 'g') ){
        $nSize= $nSize * 1073741824;
    }else if( inStr($ZipSize, 'm') ){
        $nSize= $nSize * 1048576;
    }else if( inStr($ZipSize, 'k') ){
        $nSize= $nSize * 1024;
    }
    $handleZipSize= $nSize;

    return @$handleZipSize;
}

////生成随机数
function getRnd( $nCount){

    $s=''; $i=''; $c='';
    for( $i= 1 ; $i<= $nCount; $i++){
        if( $i % 2== 0 ){
            $s= chr((57 - 48) * rnd() + 48); //0~9
        }else if( $i % 3== 0 ){
            $s= chr((90 - 65) * rnd() + 65); //A~Z
        }else{
            $s= chr((122 - 97) * rnd() + 97); //a~z
        }
        $c=$c . $s;
    }
    $getRnd=$c;
    return @$getRnd;
}

//获得随机数，仿js(20150826)
function mathRandom(){
    $i=''; $c ='';
    $c= '';

    for( $i= 1 ; $i<= 16; $i++){
        $c= $c . int(rnd() * 9);
    }
    $mathRandom= '0.' . $c;
    return @$mathRandom;
}


//获得指定位数随机A到Z字符
function getRndAZ($nCount){
    $zd=''; $i=''; $s=''; $c ='';
    $c= '' ; $zd= '';

    $zd= 'abcdefghijklmnopqrstuvwxyz' . uCase($zd);
    for( $i= 1 ; $i<= $nCount; $i++){
        $s= mid($zd, pHPRnd(1, len($zd)), 1);
        $c= $c . $s;
    }
    $getRndAZ= $c;
    return @$getRndAZ;
}

//获得随机数 （辅助上面）
function getRand( $nCount){
    $getRand= getRnd($nCount);
    return @$getRand;
}

//拷贝内容N次 InputStr输入值  Multiplier乘数和php里面一样2014 12 02
//如果 multiplier 被设置为小于等于0，函数返回空字符串。
function copyStrNumb( $InputStr, $Multiplier){
    $i=''; $s ='';
    if( $Multiplier > 0 ){
        $s= $InputStr;
        for( $i= 1 ; $i<= $Multiplier - 1; $i++){
            $InputStr= $InputStr . $s;
        }
    }else{
        $InputStr= '';
    }
    $copyStrNumb= $InputStr;
    return @$copyStrNumb;
}

//拷贝内容N次  PHP里函数
function PHPStr_Repeat( $InputStr, $Multiplier){
    $PHPStr_Repeat= copyStrNumb($InputStr, $Multiplier);
    return @$PHPStr_Repeat;
}

//引用上面的
function copyStr($InputStr, $Multiplier){
    $copyStr= copyStrNumb($InputStr, $Multiplier);
    return @$copyStr;
}

//内容加Tab
function contentAddTab( $content, $nNumb){
    $contentAddTab= copyStr('    ', $nNumb) . join(aspSplit($content, vbCrlf()), vbCrlf() . copyStr('    ', $nNumb));
    return @$contentAddTab;
}

//删除最后指定字符20150228 Content=DeleteEndStr(Content,2)
function deleteEndStr($content, $nLen){
    if( $content <> '' ){ $content= left($content, len($content) - $nLen); }
    $deleteEndStr= $content;
    return @$deleteEndStr;
}


//StringNumber (2013,9,27)
function toNumber( $n, $d){
    $toNumber= formatNumber($n, $d, - 1);
    return @$toNumber;
}

//处理成数字
function handleNumber( $content){
    $i=''; $s=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789', $s) > 0 ){
            $c= $c . $s;
        }
    }
    $handleNumber= $c;
    return @$handleNumber;
}

//字符串中提取数字 20150507
function strDrawInt( $content){
    $strDrawInt= handleNumber($content);
    return @$strDrawInt;
}

//处理成数字 首字符可以是-符号
function getFirstNegativeNumber( $content){
    $i=''; $s=''; $c ='';
    $c= '';
    $content= aspTrim($content);
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '-' && $c== '' ){
            $c= $c . $s;
        }else if( inStr('0123456789', $s) > 0 ){
            $c= $c . $s;
        }
    }
    if( $c== '' ){ $c= 0 ;}
    $getFirstNegativeNumber= $c;
    return @$getFirstNegativeNumber;
}

//检测是否为数字类型
function checkNumberType( $content){
    $checkNumberType= handleNumber($content);
    return @$checkNumberType;
}

//检测字符内容为数字类型
function checkStrIsNumberType( $content){
    $i=''; $s ='';
    $checkStrIsNumberType= true;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789', $s)== false ){
            $checkStrIsNumberType= false;
            return @$checkStrIsNumberType;
        }
    }
    return @$checkStrIsNumberType;
}

//处理成数字类型
function handleNumberType( $content){
    $i=''; $s=''; $c ='';
    $c= '';
    $content= aspTrim($content);
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $i== 1 && inStr('+-*/', left($content, 1)) > 0 ){
            $c= $c . $s;
        }else if( $i > 1 && $s== '.' ){
            $c= $c . $s;
        }else if( inStr('0123456789', $s) > 0 ){
            $c= $c . $s;
        }
    }
    $handleNumberType= $c;
    return @$handleNumberType;
}

//获得数字 只单独获得数字 并且第一个字数不能为零0     20150322
function getNumber( $content){
    $i=''; $s=''; $c ='';
    $c= '';
    $content= aspTrim($content);
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789', $s) > 0 ){
            if( $c== '' && $s== '0' ){ //待改进，因为现在脑子不够用了，就这么定敢20150322
            }else{
                $c= $c . $s;
            }
        }
    }
    $getNumber= '';
    if( $c <> '' ){
        $getNumber= int($c);
    }
    return @$getNumber;
}

//检测是否为数字
function checkNumb($s){
    if( inStr('0123456789.', $s) > 0 ){
        $checkNumb= true;
    }else{
        $checkNumb= false;
    }
    return @$checkNumb;
}

//获得有小数点数字
function getDianNumb( $content){
    $i=''; $s=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789.', $s) > 0 ){
            $c= $c . $s;
        }
    }
    $getDianNumb= $c;
    return @$getDianNumb;
}

//获得总页数
function getCountPage($nCount, $nPageSize){
    //把负数转成正确进行计算20150502
    $nCountPage='';
    if( $nCount < 0 ){
        $nCount= $nCount * - 1;
    }
    if( $nPageSize < 0 ){
        $nPageSize= $nPageSize * - 1;
    }
    $nCountPage= fix($nCount / $nPageSize);
    if( inStr($nCount / $nPageSize, '.') > 0 ){ $nCountPage= $nCountPage + 1 ;}
    $getCountPage=$nCountPage;
    return @$getCountPage;
}

//获得处理后页数
function getPageNumb($nRecordCount, $nPageSize){
    $n='';
    $n= int($nRecordCount / $nPageSize);
    if( $nRecordCount % $nPageSize > 0 ){
        $n=$n + 1;
    }
    $getPageNumb=$n;
    return @$getPageNumb;
}

//处理获得采集总页数
function getCaiHandleCountPage($content){
    $content= delHtml($content);
    $content= handleNumber($content);
    $getCaiHandleCountPage= '';
    if( len($content) < 10 ){
        $getCaiHandleCountPage= right($content, 1);
    }else if( len($content) < 200 ){
        $getCaiHandleCountPage= right($content, 2);
    }
    return @$getCaiHandleCountPage;
}

//获得采集排序总页数 20150312
function getCaiSortCountPage( $content){
    $i=''; $s ='';
    $getCaiSortCountPage= '';
    $content= delHtml($content);
    $content= handleNumber($content);
    for( $i= 1 ; $i<= 30; $i++){
        $s= mid($content, 1, len($i));
        if( $s== cStr($i) ){
            $getCaiSortCountPage= $i;
            //Call Echo(i,s)
            $content= right($content, len($content) - len($i));
        }
    }
    return @$getCaiSortCountPage;
}

//最大与最小之间 Between the minimum and maximum
function minMaxBetween($Minimum, $Maximum, $ValueNumb){
    $Minimum= CInt($Minimum); //最小数
    $Maximum= CInt($Maximum); //最大数
    $ValueNumb= CInt($ValueNumb); //当前数
    if( $Minimum > $Maximum ){
        $minMaxBetween= $Maximum;
    }else if( $ValueNumb > $Minimum ){
        $minMaxBetween= $ValueNumb;
        if( $ValueNumb > $Maximum ){
            $minMaxBetween= $Maximum;
        }
    }else{
        $minMaxBetween= $Minimum;
    }
    return @$minMaxBetween;
}

//获得内容文件名称中类型  (在FSO文件里已经有这个功能了20141220)
function getStrFileType($fileName){
    $c ='';
    $c= '';
    if( inStr($fileName, '.') > 0 ){
        $c= lCase(mid($fileName, inStrRev($fileName, '.') + 1,-1));
        if( inStr($c, '?') > 0 ){
            $c= mid($c, 1, inStr($c, '?') - 1);
        }
    }
    $getStrFileType= $c;
    return @$getStrFileType;
}

//将字符类型转成数字类型
function val( $s){
    if( $s . ''== '' || is_numeric($s) ){
        $val= 0;
    }else{
        $val= cLng($s);
    }
    return @$val;
}

//返回字符串左边N个byte
function PHPStrLen($str){

    if( isNull($str) || $str== '' ){
        $PHPStrLen= 0;
    }else{
        $i=''; $n=''; $k=''; $chrA ='';
        $k= 0;
        $n= len($str);
        for( $i= 1 ; $i<= $n; $i++){


            $chrA= mid($str, $i, 1);

            //If Asc(chrA) >= 0 And Asc(chrA) <= 255 Then
            //K = K + 1
            //Else
            //K = K + 2
            //End If

            if( $chrA < 0 ){ $chrA= $chrA + 65536 ;}
            if( $chrA < 255 ){ $k= $k + 1 ;}
            if( $chrA > 255 ){ $k= $k + 2 ;}

        }
        $PHPStrLen= $k;
    }
    return @$PHPStrLen;
}

//循环加缩进 AddIndent(Content,"    ")
function addIndent($content, $IndentStr){
    $splStr=''; $s=''; $c ='';
    $c= '';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        $c= $c . $IndentStr . $s . vbCrlf();
    }
    $addIndent= TrimVbCrlf($c);
    return @$addIndent;
}

//获得数字前字符 2014 12 12(作用是为夏文强切换分块服务的)
function getNumberBeforeStr($content){
    $i=''; $s=''; $c ='';
    $c= '';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789', $s) > 0 ){ break; }
        $c= $c . $s;
    }
    $getNumberBeforeStr= $c;
    return @$getNumberBeforeStr;
}

//获得随机数 20141212
//用法response.write makePassword(6)
function makePassword( $maxLen){
    $strNewPass ='';
    $whatsNext=''; $upper=''; $lower=''; $intCounter ='';

    $strNewPass= '';
    for( $intCounter= 1 ; $intCounter<= $maxLen; $intCounter++){
        $whatsNext= int((1 - 0 + 1) * rnd() + 0);
        if( $whatsNext== 0 ){
            $upper= 90;
            $lower= 65;
        }else{
            $upper= 57;
            $lower= 48;
        }
        $strNewPass= $strNewPass . chr(int(($upper - $lower + 1) * rnd() + $lower));
    }
    $makePassword= $strNewPass;
    return @$makePassword;
}

//功能说明：生成随机字符串，包括大小写字母，数字，和其它符合，常用于干扰码。 20141212
//参数说明：stars--干扰码最小长度，ends--干扰码最大长度
//用法'Response.Write rndcode(20, 330)
function rndcode( $stars, $ends){
    $rndlen=''; $i ='';

    $rndcode= '';
    $rndlen= int($stars * rnd() + $ends - $stars);
    for( $i= 1 ; $i<= $rndlen; $i++){

        $rndcode= $rndcode . chr(int(127 * rnd() + 1));
    }
    return @$rndcode;
}

//获得随机手机号码 没什么意义，引用别人的  20141217
//例:CAll Rw(GetRandomPhoneNumber(41))
function getRandomPhoneNumber($nCount){
    $num1=''; $rndnum=''; $j=''; $c ='';
    $c= '' ; $rndnum= '';
    $j= 1;
    while( $j < $nCount){

        while( len($rndnum) < 9 ){//产生随机数的个数
            $num1= cStr(chr((57 - 48) * rnd() + 48));
            $rndnum= $rndnum . $num1;
        }
        $c= $c . 13 . $rndnum . vbCrlf();
        $rndnum= '';
        $j= $j + 1;
    }
    if( $c <> '' ){ $c= left($c, len($c) - 2); }
    $getRandomPhoneNumber= $c;
    return @$getRandomPhoneNumber;
}

//获得字符长度
function lenStr($content){
    $l=''; $t=''; $c ='';
    $c= '';
    $i ='';
    $l= len($content);
    $t= 0;
    for( $i= 1 ; $i<= $l; $i++){
        $c= asc(mid($content, $i, 1));
        if( $c < 0 ){ $c= $c + 65536 ;}
        if( $c < 255 ){ $t= $t + 1 ;}
        if( $c > 255 ){ $t= $t + 2 ;}
    }
    $lenStr= $t;
    return @$lenStr;
}

//数组转字符串
function toString( $arr){
    if( is_array($arr) ){
        $tmp ='';
        $tmp= join($arr, ',');
        $toString= $tmp;
        $GLOBALS['Else'];
        $toString= $arr;
    }
    return @$toString;
}
//移除数字(20151022)
function remoteNumber($content){
    $i=''; $s=''; $c ='';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr('0123456789.', $s)== false ){
            $c= $c . $s;
        }
    }
    $remoteNumber= $c;
    return @$remoteNumber;
}


//================================================= 判断有特殊字符 start
//处理有无指定字符
function handleHaveStr($content, $zd){
    $s=''; $i ='';
    $handleHaveStr= false;
    for( $i= 1 ; $i<= len($zd); $i++){
        $s= mid($zd, $i, 1);
        if( inStr($content, $s) > 0 ){
            $handleHaveStr= true;
            return @$handleHaveStr;
        }
    }
    return @$handleHaveStr;
}
//有小写(20151224)
function haveLowerCase($content){
    $haveLowerCase= handleHaveStr($content, 'abcdefghijklmnopqrstuvwxyz');
    return @$haveLowerCase;
}
//有大写(20151224)
function haveUpperCase($content){
    $haveUpperCase= handleHaveStr($content, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    return @$haveUpperCase;
}
//有数字(20151224)
function haveNumber($content){
    $haveNumber= handleHaveStr($content, '0123456789');
    return @$haveNumber;
}
//有汉字(20151224)
function haveChina($content){
    $i=''; $j ='';
    $haveChina= false;
    for( $i= 1 ; $i<= len($content); $i++){
        $j= asc(mid($content, $i, 1));
        //是汉字累加
        if( $j < 0 ){
            if(($j <= -22033 && $j >= -24158)== false ){
                $haveChina= true;
                return @$haveChina;
            }
        }
    }
    return @$haveChina;
}
//================================================= 判断有特殊字符 end




//*************************************************
//函数名：EncodeJP
//作  用：过滤日本片假名导致Access搜索失效的bug
//*************************************************
function EncodeJP($Str){
    if( $Str=='' ){
        $Str=replace($Str,'ガ','&#12460;');
        $Str=replace($Str,'ギ','&#12462;');
        $Str=replace($Str,'グ','&#12464;');
        $Str=replace($Str,'ア','&#12450;');
        $Str=replace($Str,'ゲ','&#12466;');
        $Str=replace($Str,'ゴ','&#12468;');
        $Str=replace($Str,'ザ','&#12470;');
        $Str=replace($Str,'ジ','&#12472;');
        $Str=replace($Str,'ズ','&#12474;');
        $Str=replace($Str,'ゼ','&#12476;');
        $Str=replace($Str,'ゾ','&#12478;');
        $Str=replace($Str,'ダ','&#12480;');
        $Str=replace($Str,'ヂ','&#12482;');
        $Str=replace($Str,'ヅ','&#12485;');
        $Str=replace($Str,'デ','&#12487;');
        $Str=replace($Str,'ド','&#12489;');
        $Str=replace($Str,'バ','&#12496;');
        $Str=replace($Str,'パ','&#12497;');
        $Str=replace($Str,'ビ','&#12499;');
        $Str=replace($Str,'ピ','&#12500;');
        $Str=replace($Str,'ブ','&#12502;');
        $Str=replace($Str,'ブ','&#12502;');
        $Str=replace($Str,'プ','&#12503;');
        $Str=replace($Str,'ベ','&#12505;');
        $Str=replace($Str,'ペ','&#12506;');
        $Str=replace($Str,'ボ','&#12508;');
        $Str=replace($Str,'ポ','&#12509;');
        $Str=replace($Str,'ヴ','&#12532;');
    }
    $EncodeJP=$Str;
    return @$EncodeJP;
}
?>