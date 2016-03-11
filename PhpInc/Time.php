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
//Time 时间操作类 (2013,9,27)

//时间处理
function format_Time($timeStr, $nType){
    $y=''; $m=''; $d=''; $h=''; $mi=''; $s ='';
    $format_Time = '' ;
    if( IsDate($timeStr) == false ){ return @$format_Time; }
    $y = CStr(Year($timeStr)) ;
    $m = CStr(Month($timeStr)) ;
    if( strlen($m) == 1 ){ $m = '0' . $m ;}
    $d = CStr(Day($timeStr)) ;//在vb.net里要这样用  D = CStr(CDate(timeStr).Day)
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
        //yyyy年mm月dd日
        $format_Time = $y . '年' . $m . '月' . $d . '日' ;break;
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
        //yyyy年mm月dd日
        $format_Time = $y . '年' . $m . '月' . $d . '日' . ' ' . $h . ':' . $mi . ':' . $s ;break;
        case 9;
        //yyyy年mm月dd日H时mi分S秒 早上
        $format_Time = $y . '年' . $m . '月' . $d . '日' . ' ' . $h . '时' . $mi . '分' . $s . '秒，' . GetDayStatus($h, 1) ;break;
        case 10;
        //yyyy年mm月dd日H时
        $format_Time = $y . '年' . $m . '月' . $d . '日' . $h . '时' ;break;
        case 11;
        //yyyy年mm月dd日H时mi分S秒
        $format_Time = $y . '年' . $m . '月' . $d . '日' . ' ' . $h . '时' . $mi . '分' . $s . '秒' ;break;
        case 12;
        //yyyy年mm月dd日H时mi分
        $format_Time = $y . '年' . $m . '月' . $d . '日' . ' ' . $h . '时' . $mi . '分' ;break;
        case 13;
        //yyyy年mm月dd日H时mi分 早上
        $format_Time = $m . '月' . $d . '日' . ' ' . $h . ':' . $mi . ' ' . GetDayStatus($h, 0) ;break;
        case 14;
        //yyyy年mm月dd日
        $format_Time = $y . '/' . $m . '/' . $d ;break;
        case 15;
        //yyyy年mm月 第1周
        $format_Time = $y . '年' . $m . '月 第' . GetCountPage($d, 7) . '周' ;
    }
    return @$format_Time;
}
//获得当前时期还可以计算

//获得当前天状态
function getDayStatus($h, $SType){
    $c ='';
    if( substr($h, 0 , 1) == '0' ){
        $h = substr($h, - 1) ;
    }
    $h = intval($h) ;
    if( $h >= 0 && $h <= 5 ){
        $c = '凌晨' ;
    }else if( $h >= 6 && $h <= 8 ){
        $c = '早上' ;
    }else if( $h >= 9 && $h <= 12 ){
        $c = '上午' ;
    }else if( $h >= 13 && $h <= 18 ){
        $c = '下午' ;
    }else if( $h >= 19 && $h <= 24 ){
        $c = '晚上' ;
    }else{
        $c = '深夜' ;
    }
    if( $SType == 1 ){ $c = '<b>' . $c . '</b>' ;}
    $getDayStatus = $c ;
    return @$getDayStatus;
}
//时间计算
function printTimeValue($vv){

    $v=''; $c=''; $n ='';
    $v = $vv ; $c = '' ;
    if( $v >= 86400 ){
        $n = $v % 86400 ;
        $v = Fix($v / 60 / 60 / 24) ;//这里面是除24，不是60，因为一天有24个小时，小云你这个傻X  20150119
        $c = $c . $v . '天' ;
        $v = $n ;
    }
    if( $v >= 3600 ){
        $n = $v % 3600 ;
        $v = Fix($v / 60 / 60) ;
        $c = $c . $v . '小时' ;
        $v = $n ;
    }

    if( $v >= 60 ){
        $n = $v % 60 ;
        $v = Fix($v / 60) ;
        $c = $c . $v . '分' ;
        $v = $n ;
    }
    if( $v >= 0 ){
        $c = $c . $v . '秒' ;
    }

    $printTimeValue = $c ;
    return @$printTimeValue;
}
//计算整时  (问答以小时或分钟显示)
function printAskTime($vv){

    $v=''; $c=''; $n ='';
    $v = $vv ;
    $c = '' ;
    if( $v >= 3600 ){
        $n = $v % 3600 ;
        $v = Fix($v / 60 / 60) ;
        $c = $c . $v . '小时' ;
        $v = $n ;
        $printAskTime = $c ; return @$printAskTime;
    }
    if( $v >= 60 ){
        $n = $v % 60 ;
        $v = Fix($v / 60) ;
        $c = $c . $v . '分钟' ;
        $v = $n ;
        $printAskTime = $c ; return @$printAskTime;
    }
    if( $v >= 0 ){
        $c = $c . $v . '秒钟' ;
        $printAskTime = $c ; return @$printAskTime;
    }
    return @$printAskTime;
}
//获得时间
function getTimerSet(){
    $n ='';
    $n = FormatNumber((Timer() - $GLOBALS['PubTimer']) * 1000, 2, - 1) / 1000 ;
    $getTimerSet = toNumber($n, 3) ;
    return @$getTimerSet;
}
//计算时间
function calculationTimer($PubTimer){
    $n ='';
    $n = FormatNumber((Timer() - $PubTimer) * 1000, 2, - 1) / 1000 ;
    $calculationTimer = toNumber($n, 3) ;
    return @$calculationTimer;
}

//获得时间
function getTimer(){
    $getTimer = '<br>------------------------------------<br>页面执行时间：' . getTimerSet() . ' 秒' ;
    return @$getTimer;
}
//获得时间
function vBGetTimer(){
    $n ='';
    $n = DateDiff('s', $GLOBALS['PubTimer'], Now()) ;
    $n = printTimeValue($n) ;
    $vBGetTimer = vbCrlf() . '------------------------------------' . vbCrlf() . '运行时间：' . $n ;
    return @$vBGetTimer;
}
//获得第三种
function vBEchoTimer(){
    $n ='';
    $n = DateDiff('s', $GLOBALS['PubTimer'], Now()) ;
    $n = printTimeValue($n) ;
    $vBEchoTimer = '运行时间：' . $n ;
    return @$vBEchoTimer;
}
//获得时间第四种
function vBRunTimer($startTime){
    $n ='';
    $n = DateDiff('s', $startTime, Now()) ;
    $n = printTimeValue($n) ;
    $vBRunTimer = '运行时间：' . $n ;
    return @$vBRunTimer;
}
?>