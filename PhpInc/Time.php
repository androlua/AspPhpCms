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
//Time ʱ������� (2013,9,27)

//ʱ�䴦��
function format_Time($timeStr, $nType){
    $y=''; $m=''; $d=''; $h=''; $mi=''; $s ='';
    $format_Time = '' ;
    if( IsDate($timeStr) == false ){ return @$format_Time; }
    $y = CStr(Year($timeStr)) ;
    $m = CStr(Month($timeStr)) ;
    if( strlen($m) == 1 ){ $m = '0' . $m ;}
    $d = CStr(Day($timeStr)) ;//��vb.net��Ҫ������  D = CStr(CDate(timeStr).Day)
    if( strlen($d) == 1 ){ $d = '0' . $d ;}
    $h = CStr(Hour($timeStr)) ;
    if( strlen($h) == 1 ){ $h = '0' . $h ;}
    $mi = CStr(Minute($timeStr)) ;
    if( strlen($mi) == 1 ){ $mi = '0' . $mi ;}
    $s = CStr(Second($timeStr)) ;
    if( strlen($s) == 1 ){ $s = '0' . $s ;}
    switch ( $nType ){
        case 1;
        //yyyy-mm-dd hh:mm:ss
        $format_Time = $y . '-' . $m . '-' . $d . ' ' . $h . ':' . $mi . ':' . $s ;break;
        case 2;
        //yyyy-mm-dd
        $format_Time = $y . '-' . $m . '-' . $d ;break;
        case 3;
        //hh:mm:ss
        $format_Time = $h . ':' . $mi . ':' . $s ;break;
        case 4;
        //yyyy��mm��dd��
        $format_Time = $y . '��' . $m . '��' . $d . '��' ;break;
        case 5;
        //yyyymmdd
        $format_Time = $y . $m . $d ;break;
        case 6;
        //yyyymmddhhmmss
        $format_Time = $y . $m . $d . $h . $mi . $s ;break;
        case 7;
        //mm-dd
        $format_Time = $m . '-' . $d ;break;
        case 8;
        //yyyy��mm��dd��
        $format_Time = $y . '��' . $m . '��' . $d . '��' . ' ' . $h . ':' . $mi . ':' . $s ;break;
        case 9;
        //yyyy��mm��dd��Hʱmi��S�� ����
        $format_Time = $y . '��' . $m . '��' . $d . '��' . ' ' . $h . 'ʱ' . $mi . '��' . $s . '�룬' . GetDayStatus($h, 1) ;break;
        case 10;
        //yyyy��mm��dd��Hʱ
        $format_Time = $y . '��' . $m . '��' . $d . '��' . $h . 'ʱ' ;break;
        case 11;
        //yyyy��mm��dd��Hʱmi��S��
        $format_Time = $y . '��' . $m . '��' . $d . '��' . ' ' . $h . 'ʱ' . $mi . '��' . $s . '��' ;break;
        case 12;
        //yyyy��mm��dd��Hʱmi��
        $format_Time = $y . '��' . $m . '��' . $d . '��' . ' ' . $h . 'ʱ' . $mi . '��' ;break;
        case 13;
        //yyyy��mm��dd��Hʱmi�� ����
        $format_Time = $m . '��' . $d . '��' . ' ' . $h . ':' . $mi . ' ' . GetDayStatus($h, 0) ;break;
        case 14;
        //yyyy��mm��dd��
        $format_Time = $y . '/' . $m . '/' . $d ;break;
        case 15;
        //yyyy��mm�� ��1��
        $format_Time = $y . '��' . $m . '�� ��' . GetCountPage($d, 7) . '��' ;
    }
    return @$format_Time;
}
//��õ�ǰʱ�ڻ����Լ���

//��õ�ǰ��״̬
function getDayStatus($h, $SType){
    $c ='';
    if( substr($h, 0 , 1) == '0' ){
        $h = substr($h, - 1) ;
    }
    $h = intval($h) ;
    if( $h >= 0 && $h <= 5 ){
        $c = '�賿' ;
    }else if( $h >= 6 && $h <= 8 ){
        $c = '����' ;
    }else if( $h >= 9 && $h <= 12 ){
        $c = '����' ;
    }else if( $h >= 13 && $h <= 18 ){
        $c = '����' ;
    }else if( $h >= 19 && $h <= 24 ){
        $c = '����' ;
    }else{
        $c = '��ҹ' ;
    }
    if( $SType == 1 ){ $c = '<b>' . $c . '</b>' ;}
    $getDayStatus = $c ;
    return @$getDayStatus;
}
//ʱ�����
function printTimeValue($vv){

    $v=''; $c=''; $n ='';
    $v = $vv ; $c = '' ;
    if( $v >= 86400 ){
        $n = $v % 86400 ;
        $v = Fix($v / 60 / 60 / 24) ;//�������ǳ�24������60����Ϊһ����24��Сʱ��С�������ɵX  20150119
        $c = $c . $v . '��' ;
        $v = $n ;
    }
    if( $v >= 3600 ){
        $n = $v % 3600 ;
        $v = Fix($v / 60 / 60) ;
        $c = $c . $v . 'Сʱ' ;
        $v = $n ;
    }

    if( $v >= 60 ){
        $n = $v % 60 ;
        $v = Fix($v / 60) ;
        $c = $c . $v . '��' ;
        $v = $n ;
    }
    if( $v >= 0 ){
        $c = $c . $v . '��' ;
    }

    $printTimeValue = $c ;
    return @$printTimeValue;
}
//������ʱ  (�ʴ���Сʱ�������ʾ)
function printAskTime($vv){

    $v=''; $c=''; $n ='';
    $v = $vv ;
    $c = '' ;
    if( $v >= 3600 ){
        $n = $v % 3600 ;
        $v = Fix($v / 60 / 60) ;
        $c = $c . $v . 'Сʱ' ;
        $v = $n ;
        $printAskTime = $c ; return @$printAskTime;
    }
    if( $v >= 60 ){
        $n = $v % 60 ;
        $v = Fix($v / 60) ;
        $c = $c . $v . '����' ;
        $v = $n ;
        $printAskTime = $c ; return @$printAskTime;
    }
    if( $v >= 0 ){
        $c = $c . $v . '����' ;
        $printAskTime = $c ; return @$printAskTime;
    }
    return @$printAskTime;
}
//���ʱ��
function getTimerSet(){
    $n ='';
    $n = FormatNumber((Timer() - $GLOBALS['PubTimer']) * 1000, 2, - 1) / 1000 ;
    $getTimerSet = toNumber($n, 3) ;
    return @$getTimerSet;
}
//����ʱ��
function calculationTimer($PubTimer){
    $n ='';
    $n = FormatNumber((Timer() - $PubTimer) * 1000, 2, - 1) / 1000 ;
    $calculationTimer = toNumber($n, 3) ;
    return @$calculationTimer;
}

//���ʱ��
function getTimer(){
    $getTimer = '<br>------------------------------------<br>ҳ��ִ��ʱ�䣺' . getTimerSet() . ' ��' ;
    return @$getTimer;
}
//���ʱ��
function vBGetTimer(){
    $n ='';
    $n = DateDiff('s', $GLOBALS['PubTimer'], Now()) ;
    $n = printTimeValue($n) ;
    $vBGetTimer = vbCrlf() . '------------------------------------' . vbCrlf() . '����ʱ�䣺' . $n ;
    return @$vBGetTimer;
}
//��õ�����
function vBEchoTimer(){
    $n ='';
    $n = DateDiff('s', $GLOBALS['PubTimer'], Now()) ;
    $n = printTimeValue($n) ;
    $vBEchoTimer = '����ʱ�䣺' . $n ;
    return @$vBEchoTimer;
}
//���ʱ�������
function vBRunTimer($startTime){
    $n ='';
    $n = DateDiff('s', $startTime, Now()) ;
    $n = printTimeValue($n) ;
    $vBRunTimer = '����ʱ�䣺' . $n ;
    return @$vBRunTimer;
}
?>