<?PHP
//Cai采集内容(2014)

//获得采集内容

//处理获得采集内容
function handleGetHttpPage( $httpurl, $Char_Set){ return ''; 	 return ''; //留空函数
}
//获得请求url状态

//获得请求url的服务器名称


//获得采集内容 (辅助)

//获得采集内容 (辅助)

function bytesToBstr($body, $Cset){ return ''; //留空函数
}
//截取字符串 更新20160114
//c=[A]abbccdd[/A]
//0=abbccdd
//1=[A]abbccdd[/A]
//3=[A]abbccdd
//4=abbccdd[/A]
//截取字符串
function strCut( $content, $startStr, $endStr, $cutType){
    $s1=''; $s1Str=''; $s2=''; $s3=''; $c=''; $tempContent=''; $tempStartStr=''; $tempEndStr ='';
    $tempStartStr= $startStr;
    $tempEndStr= $endStr;
    $tempContent= $content;
    $cutType= '|' . $cutType . '|';
    //不区分大小写
    if( inStr($cutType, '|lu|') > 0 ){
        $content= lCase($content);
        $startStr= lCase($startStr);
        $endStr= lCase($endStr);
    }
    if( inStr($content, $startStr)== false || inStr($content, $endStr)== false ){
        $c= '';
        return '';
    }
    if( inStr($cutType, '|1|') > 0 ){
        $s1= inStr($content, $startStr);
        $s1Str= mid($content, $s1 + len($startStr),-1);
        $s2= $s1 + inStr($s1Str, $endStr) + len($startStr) + len($endStr) - 1; //为什么要减1
    }else{
        $s1= inStr($content, $startStr) + len($startStr);
        $s1Str= mid($content, $s1,-1);
        //S2 = InStr(S1, content, EndStr)
        $s2= $s1 + inStr($s1Str, $endStr) - 1;
    }
    $s3= $s2 - $s1;
    if( $s3 >= 0 ){
        $c= mid($tempContent, $s1, $s3);
    }else{
        $c= '';
    }
    if( inStr($cutType, '|3|') > 0 ){
        $c= $tempStartStr . $c;
    }
    if( inStr($cutType, '|4|') > 0 ){
        $c= $c . $tempEndStr;
    }
    $strCut= $c;
    return @$strCut;
}
//获得截取内容,20150305
function getStrCut( $content, $startStr, $endStr, $cutType){
    $getStrCut= strCut($content, $startStr, $endStr, $cutType);
    return @$getStrCut;
}
//接取字符 CutStr(Content,22,"null")
function cutStr( $content, $cutNumb, $MoreStr){
    $i=''; $s=''; $n ='';
    $n= 0;
    $cutNumb= CInt($cutNumb); //转换成数字类型    追加于20141107
    if( $MoreStr== '' ){ $MoreStr= '...' ;}
    if( lCase($MoreStr)== 'none' || lCase($MoreStr)== 'null' ){ $MoreStr= '' ;}
    $cutStr= $content;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= asc(mid(cStr($content), $i, 1));
        if( $s < 0 ){ $s= $s + 65536 ;}
        if( $s < 255 ){ $n= $n + 1 ;}
        if( $s > 255 ){ $n= $n + 2 ;}
        if( $n >= $cutNumb ){ $cutStr= left($content, $i) . $MoreStr ; return @$cutStr; }
    }
    return @$cutStr;
}
//截取内容，不区分大小写 20150327  C=CutStrNOLU(c,"<heAd",">")
function cutStrNOLU($content, $startStr, $endStr){
    $s=''; $LCaseContent=''; $nStartLen=''; $nEndLen=''; $NewStartStr ='';
    $startStr= lCase($startStr);
    $endStr= lCase($endStr);
    $LCaseContent= lCase($content);

    if( inStr($LCaseContent, $startStr) > 0 ){
        $nStartLen= inStr($LCaseContent, $startStr);
        $s= mid($content, $nStartLen,-1);
        $LCaseContent= mid($s, len($startStr) + 1,-1);
        $NewStartStr= mid($s, 1, len($startStr) + 1); //获得开始字符

        $LCaseContent= replace($LCaseContent, '<', '&lt;');
        //Call eerr("111",LCaseContent)

        $nEndLen= inStr($LCaseContent, $endStr);
        aspEcho('nEndLen', $nEndLen);

        $s= mid($content, $nStartLen, $nEndLen + len($startStr));
        //Call Echo(nStartLen,nEndLen)
        //Call Echo("S",S)
        $cutStrNOLU= $s;
    }
    return @$cutStrNOLU;
}

//接取TD字符
function setCutTDStr( $content, $TDWidth, $MoreColor){
    $i=''; $s=''; $c=''; $n=''; $EndNumb=''; $YesMore ='';
    $content= cStr($content . '');
    if( $content== '' ){ $setCutTDStr= $content ; return @$setCutTDStr; }
    if( $TDWidth== '' ){ $setCutTDStr= $content ; return @$setCutTDStr; }//TDWidth为空，则为自动
    $n= 0 ; $YesMore= false;
    $EndNumb= int($TDWidth / 6.3);
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $n >= $EndNumb ){
            $YesMore= true;
            break;
        }else{
            $c= $c . $s;
        }
        if( asc($s) < 0 ){
            $n= $n + 2;
        }else{
            $n= $n + 1;
        }
    }
    if( $YesMore== true ){
        //需要处理Title标题的HTML
        $c= '<span Title="' . displayHtml($content) . '" style="background-color:' . $MoreColor . ';">' . $c . '</span>';
    }
    $setCutTDStr= $c;
    return @$setCutTDStr;
}
//接取TD字符 (辅助)
function cutTDStr($content, $TDWidth){
    $cutTDStr= setCutTDStr($content, $TDWidth, '#FBE3EF');
    return @$cutTDStr;
}
//分割字符

//分割字符 不处理字符 (辅助)

//分割字符 去掉字符 (辅助)
function getArray1($content, $startStr, $endStr, $StartType, $EndType){
    $getArray1= getArrayList($content, $startStr, $endStr, $StartType, $EndType, '去掉字符');
    return @$getArray1;
}
//截取指定分割值
function getSplit( $content, $splStr, $n){
    $splxx ='';
    $splxx= aspSplit($content, $splStr);
    $getSplit= $splxx[$n];
    return @$getSplit;
}
//获得分数总数
function getSplitCount( $content, $splStr){
    $splxx ='';
    $splxx= aspSplit($content, $splStr);
    $getSplitCount= uBound($splxx);
    if( getSplitCount > 0 ){ $getSplitCount= getSplitCount + 1 ;}//不为空加一
    return @$getSplitCount;
}

//代理 因为它不能与VB软件共存
function agent( $httpurl){ //留空函数
}

?>