<?PHP
//Cai�ɼ�����(2014)

//��òɼ�����

//�����òɼ�����
function handleGetHttpPage( $httpurl, $Char_Set){ return ''; 	 return ''; //���պ���
}
//�������url״̬

//�������url�ķ���������


//��òɼ����� (����)

//��òɼ����� (����)

function bytesToBstr($body, $Cset){ return ''; //���պ���
}
//��ȡ�ַ��� ����20160114
//c=[A]abbccdd[/A]
//0=abbccdd
//1=[A]abbccdd[/A]
//3=[A]abbccdd
//4=abbccdd[/A]
//��ȡ�ַ���
function strCut( $content, $startStr, $endStr, $cutType){
    $s1=''; $s1Str=''; $s2=''; $s3=''; $c=''; $tempContent=''; $tempStartStr=''; $tempEndStr ='';
    $tempStartStr= $startStr;
    $tempEndStr= $endStr;
    $tempContent= $content;
    $cutType= '|' . $cutType . '|';
    //�����ִ�Сд
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
        $s2= $s1 + inStr($s1Str, $endStr) + len($startStr) + len($endStr) - 1; //ΪʲôҪ��1
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
//��ý�ȡ����,20150305
function getStrCut( $content, $startStr, $endStr, $cutType){
    $getStrCut= strCut($content, $startStr, $endStr, $cutType);
    return @$getStrCut;
}
//��ȡ�ַ� CutStr(Content,22,"null")
function cutStr( $content, $cutNumb, $MoreStr){
    $i=''; $s=''; $n ='';
    $n= 0;
    $cutNumb= CInt($cutNumb); //ת������������    ׷����20141107
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
//��ȡ���ݣ������ִ�Сд 20150327  C=CutStrNOLU(c,"<heAd",">")
function cutStrNOLU($content, $startStr, $endStr){
    $s=''; $LCaseContent=''; $nStartLen=''; $nEndLen=''; $NewStartStr ='';
    $startStr= lCase($startStr);
    $endStr= lCase($endStr);
    $LCaseContent= lCase($content);

    if( inStr($LCaseContent, $startStr) > 0 ){
        $nStartLen= inStr($LCaseContent, $startStr);
        $s= mid($content, $nStartLen,-1);
        $LCaseContent= mid($s, len($startStr) + 1,-1);
        $NewStartStr= mid($s, 1, len($startStr) + 1); //��ÿ�ʼ�ַ�

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

//��ȡTD�ַ�
function setCutTDStr( $content, $TDWidth, $MoreColor){
    $i=''; $s=''; $c=''; $n=''; $EndNumb=''; $YesMore ='';
    $content= cStr($content . '');
    if( $content== '' ){ $setCutTDStr= $content ; return @$setCutTDStr; }
    if( $TDWidth== '' ){ $setCutTDStr= $content ; return @$setCutTDStr; }//TDWidthΪ�գ���Ϊ�Զ�
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
        //��Ҫ����Title�����HTML
        $c= '<span Title="' . displayHtml($content) . '" style="background-color:' . $MoreColor . ';">' . $c . '</span>';
    }
    $setCutTDStr= $c;
    return @$setCutTDStr;
}
//��ȡTD�ַ� (����)
function cutTDStr($content, $TDWidth){
    $cutTDStr= setCutTDStr($content, $TDWidth, '#FBE3EF');
    return @$cutTDStr;
}
//�ָ��ַ�

//�ָ��ַ� �������ַ� (����)

//�ָ��ַ� ȥ���ַ� (����)
function getArray1($content, $startStr, $endStr, $StartType, $EndType){
    $getArray1= getArrayList($content, $startStr, $endStr, $StartType, $EndType, 'ȥ���ַ�');
    return @$getArray1;
}
//��ȡָ���ָ�ֵ
function getSplit( $content, $splStr, $n){
    $splxx ='';
    $splxx= aspSplit($content, $splStr);
    $getSplit= $splxx[$n];
    return @$getSplit;
}
//��÷�������
function getSplitCount( $content, $splStr){
    $splxx ='';
    $splxx= aspSplit($content, $splStr);
    $getSplitCount= uBound($splxx);
    if( getSplitCount > 0 ){ $getSplitCount= getSplitCount + 1 ;}//��Ϊ�ռ�һ
    return @$getSplitCount;
}

//���� ��Ϊ��������VB�������
function agent( $httpurl){ //���պ���
}

?>