<?PHP
//Time ʱ������� (2013,9,27)

//ʱ�䴦��
function format_Time($timeStr, $nType){
    $y=''; $m=''; $d=''; $h=''; $mi=''; $s ='';
    $format_Time= '';
    if( isDate($timeStr)== false ){ return @$format_Time; }
    $y= cStr(year($timeStr));
    $m= cStr(month($timeStr));
    if( len($m)== 1 ){ $m= '0' . $m ;}
    $d= cStr(day($timeStr)); //��vb.net��Ҫ������  D = CStr(CDate(timeStr).Day)
    if( len($d)== 1 ){ $d= '0' . $d ;}
    $h= cStr(hour($timeStr));
    if( len($h)== 1 ){ $h= '0' . $h ;}
    $mi= cStr(minute($timeStr));
    if( len($mi)== 1 ){ $mi= '0' . $mi ;}
    $s= cStr(second($timeStr));
    if( len($s)== 1 ){ $s= '0' . $s ;}
    switch ( $nType ){
        case 1;
        //yyyy-mm-dd hh:mm:ss
        $format_Time= $y . '-' . $m . '-' . $d . ' ' . $h . ':' . $mi . ':' . $s ;break;
        case 2;
        //yyyy-mm-dd
        $format_Time= $y . '-' . $m . '-' . $d ;break;
        case 3;
        //hh:mm:ss
        $format_Time= $h . ':' . $mi . ':' . $s ;break;
        case 4;
        //yyyy��mm��dd��
        $format_Time= $y . '��' . $m . '��' . $d . '��' ;break;
        case 5;
        //yyyymmdd
        $format_Time= $y . $m . $d ;break;
        case 6;
        //yyyymmddhhmmss
        $format_Time= $y . $m . $d . $h . $mi . $s ;break;
        case 7;
        //mm-dd
        $format_Time= $m . '-' . $d ;break;
        case 8;
        //yyyy��mm��dd��
        $format_Time= $y . '��' . $m . '��' . $d . '��' . ' ' . $h . ':' . $mi . ':' . $s ;break;
        case 9;
        //yyyy��mm��dd��Hʱmi��S�� ����
        $format_Time= $y . '��' . $m . '��' . $d . '��' . ' ' . $h . 'ʱ' . $mi . '��' . $s . '�룬' . getDayStatus($h, 1) ;break;
        case 10;
        //yyyy��mm��dd��Hʱ
        $format_Time= $y . '��' . $m . '��' . $d . '��' . $h . 'ʱ' ;break;
        case 11;
        //yyyy��mm��dd��Hʱmi��S��
        $format_Time= $y . '��' . $m . '��' . $d . '��' . ' ' . $h . 'ʱ' . $mi . '��' . $s . '��' ;break;
        case 12;
        //yyyy��mm��dd��Hʱmi��
        $format_Time= $y . '��' . $m . '��' . $d . '��' . ' ' . $h . 'ʱ' . $mi . '��' ;break;
        case 13;
        //yyyy��mm��dd��Hʱmi�� ����
        $format_Time= $m . '��' . $d . '��' . ' ' . $h . ':' . $mi . ' ' . getDayStatus($h, 0) ;break;
        case 14;
        //yyyy��mm��dd��
        $format_Time= $y . '/' . $m . '/' . $d ;break;
        case 15;
        //yyyy��mm�� ��1��
        $format_Time= $y . '��' . $m . '�� ��' . GetCountPage($d, 7) . '��';
    }
    return @$format_Time;
}
//��õ�ǰʱ�ڻ����Լ���

//��õ�ǰ��״̬
function getDayStatus($h, $SType){
    $c ='';
    if( left($h, 1)== '0' ){
        $h= right($h, 1);
    }
    $h= CInt($h);
    if( $h >= 0 && $h <= 5 ){
        $c= '�賿';
    }else if( $h >= 6 && $h <= 8 ){
        $c= '����';
    }else if( $h >= 9 && $h <= 12 ){
        $c= '����';
    }else if( $h >= 13 && $h <= 18 ){
        $c= '����';
    }else if( $h >= 19 && $h <= 24 ){
        $c= '����';
    }else{
        $c= '��ҹ';
    }
    if( $SType== 1 ){ $c= '<b>' . $c . '</b>' ;}
    $getDayStatus= $c;
    return @$getDayStatus;
}
//ʱ�����
function printTimeValue($vv){

    $v=''; $c=''; $n ='';
    $v= $vv ; $c= '';
    if( $v >= 86400 ){
        $n= $v % 86400;
        $v= fix($v / 60 / 60 / 24); //�������ǳ�24������60����Ϊһ����24��Сʱ��С�������ɵX  20150119
        $c= $c . $v . '��';
        $v= $n;
    }
    if( $v >= 3600 ){
        $n= $v % 3600;
        $v= fix($v / 60 / 60);
        $c= $c . $v . 'Сʱ';
        $v= $n;
    }

    if( $v >= 60 ){
        $n= $v % 60;
        $v= fix($v / 60);
        $c= $c . $v . '��';
        $v= $n;
    }
    if( $v > 0 ){
        $c= $c . $v . '��';
    }

    $printTimeValue= $c;
    return @$printTimeValue;
}
//������ʱ  (�ʴ���Сʱ�������ʾ)
function printAskTime($vv){

    $v=''; $c=''; $n ='';
    $v= $vv;
    $c= '';
    if( $v >= 3600 ){
        $n= $v % 3600;
        $v= fix($v / 60 / 60);
        $c= $c . $v . 'Сʱ';
        $v= $n;
        $printAskTime= $c ; return @$printAskTime;
    }
    if( $v >= 60 ){
        $n= $v % 60;
        $v= fix($v / 60);
        $c= $c . $v . '����';
        $v= $n;
        $printAskTime= $c ; return @$printAskTime;
    }
    if( $v >= 0 ){
        $c= $c . $v . '����';
        $printAskTime= $c ; return @$printAskTime;
    }
    return @$printAskTime;
}
//���ʱ��
function getTimerSet(){
    $n ='';
    $n= formatNumber((timer() - $GLOBALS['PubTimer']) * 1000, 2, - 1) / 1000;
    $getTimerSet= toNumber($n, 3);
    return @$getTimerSet;
}
//����ʱ��
function calculationTimer($PubTimer){
    $n ='';
    $n= formatNumber((timer() - $PubTimer) * 1000, 2, - 1) / 1000;
    $calculationTimer= toNumber($n, 3);
    return @$calculationTimer;
}

//���ʱ��
function getTimer(){
    $getTimer= '<br>------------------------------------<br>ҳ��ִ��ʱ�䣺' . getTimerSet() . ' ��';
    return @$getTimer;
}
//���ʱ��
function VBGetTimer(){
    $n ='';
    $n= dateDiff('s', $GLOBALS['PubTimer'], now());
    $n= printTimeValue($n);
    $VBGetTimer= vbCrlf() . '------------------------------------' . vbCrlf() . '����ʱ�䣺' . $n;
    return @$VBGetTimer;
}
//��õ�����
function VBEchoTimer(){
    $n ='';
    $n= dateDiff('s', $GLOBALS['PubTimer'], now());
    $n= printTimeValue($n);
    $VBEchoTimer= '����ʱ�䣺' . $n;
    return @$VBEchoTimer;
}
//���ʱ�������
function VBRunTimer($startTime){
    $n ='';
    $n= dateDiff('s', $startTime, now());
    $n= printTimeValue($n);
    $VBRunTimer= '����ʱ�䣺' . $n;
    return @$VBRunTimer;
}
?>