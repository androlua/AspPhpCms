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
//添加于 20160203

//获取浏览器类型(可以判断:47种浏览器;GoogLe,Grub,MSN,Yahoo!蜘蛛;十种常见IE插件)  Response.Write getBrType("")
function getBrType($theInfo){
    $strType=''; $tmp1=''; $s ='';
    $s = 'Other Unknown' ;
    if( $theInfo == '' ){
        $theInfo = UCase(ServerVariables('HTTP_USER_AGENT')) ;
    }
    if( instr($theInfo, UCase('mozilla')) > 0 ){ $s = 'Mozilla' ;}
    if( instr($theInfo, UCase('icab')) > 0 ){ $s = 'iCab' ;}
    if( instr($theInfo, UCase('lynx')) > 0 ){ $s = 'Lynx' ;}
    if( instr($theInfo, UCase('links')) > 0 ){ $s = 'Links' ;}
    if( instr($theInfo, UCase('elinks')) > 0 ){ $s = 'ELinks' ;}
    if( instr($theInfo, UCase('jbrowser')) > 0 ){ $s = 'JBrowser' ;}
    if( instr($theInfo, UCase('konqueror')) > 0 ){ $s = 'konqueror' ;}
    if( instr($theInfo, UCase('wget')) > 0 ){ $s = 'wget' ;}
    if( instr($theInfo, UCase('ask jeeves')) > 0 || instr($theInfo, UCase('teoma')) > 0 ){ $s = 'Ask Jeeves/Teoma' ;}
    if( instr($theInfo, UCase('wget')) > 0 ){ $s = 'wget' ;}
    if( instr($theInfo, UCase('opera')) > 0 ){ $s = 'opera' ;}
    if( instr($theInfo, UCase('NOKIAN')) > 0 ){ $s = 'NOKIAN(诺基亚手机)' ;}
    if( instr($theInfo, UCase('SPV')) > 0 ){ $s = 'SPV(多普达手机)' ;}
    if( instr($theInfo, UCase('Jakarta Commons')) > 0 ){ $s = 'Jakarta Commons-HttpClient' ;}
    if( instr($theInfo, UCase('Gecko')) > 0 ){
        $strType = '[Gecko] ' ;
        $s = 'Mozilla Series' ;
        if( instr($theInfo, UCase('aol')) > 0 ){ $s = 'AOL' ;}
        if( instr($theInfo, UCase('netscape')) > 0 ){ $s = 'Netscape' ;}
        if( instr($theInfo, UCase('firefox')) > 0 ){ $s = 'FireFox' ;}
        if( instr($theInfo, UCase('chimera')) > 0 ){ $s = 'Chimera' ;}
        if( instr($theInfo, UCase('camino')) > 0 ){ $s = 'Camino' ;}
        if( instr($theInfo, UCase('galeon')) > 0 ){ $s = 'Galeon' ;}
        if( instr($theInfo, UCase('k-meleon')) > 0 ){ $s = 'K-Meleon' ;}
        $s = $strType . $s ;
    }
    if( instr($theInfo, UCase('bot')) > 0 || instr($theInfo, UCase('crawl')) > 0 ){
        $strType = '[Bot/Crawler]' ;
        if( instr($theInfo, UCase('grub')) > 0 ){ $s = 'Grub' ;}
        if( instr($theInfo, UCase('googlebot')) > 0 ){ $s = 'GoogleBot' ;}
        if( instr($theInfo, UCase('msnbot')) > 0 ){ $s = 'MSN Bot' ;}
        if( instr($theInfo, UCase('slurp')) > 0 ){ $s = 'Yahoo! Slurp' ;}
        $s = $strType . $s ;
    }
    if( instr($theInfo, UCase('applewebkit')) > 0 ){
        $strType = '[AppleWebKit]' ;
        $s = '' ;
        if( instr($theInfo, UCase('omniweb')) > 0 ){ $s = 'OmniWeb' ;}
        if( instr($theInfo, UCase('safari')) > 0 ){ $s = 'Safari' ;}
        $s = $strType . $s ;
    }
    if( instr($theInfo, UCase('msie')) > 0 ){
        $strType = '[MSIE' ;
        $tmp1 = mid($theInfo,(instr($theInfo, UCase('MSIE')) + 4), 6) ;
        $tmp1 = substr($tmp1, 0 , instr($tmp1, ';') - 1) ;
        $strType = $strType . $tmp1 . ']' ;
        $s = 'Internet Explorer' ;
        $s = $strType . $s ;
    }
    if( instr($theInfo, UCase('msn')) > 0 ){ $s = 'MSN' ;}
    if( instr($theInfo, UCase('aol')) > 0 ){ $s = 'AOL' ;}
    if( instr($theInfo, UCase('webtv')) > 0 ){ $s = 'WebTV' ;}
    if( instr($theInfo, UCase('myie2')) > 0 ){ $s = 'MyIE2' ;}
    if( instr($theInfo, UCase('maxthon')) > 0 ){ $s = 'Maxthon(傲游浏览器)' ;}
    if( instr($theInfo, UCase('gosurf')) > 0 ){ $s = 'GoSurf(冲浪高手浏览器)' ;}
    if( instr($theInfo, UCase('netcaptor')) > 0 ){ $s = 'NetCaptor' ;}
    if( instr($theInfo, UCase('sleipnir')) > 0 ){ $s = 'Sleipnir' ;}
    if( instr($theInfo, UCase('avant browser')) > 0 ){ $s = 'AvantBrowser' ;}
    if( instr($theInfo, UCase('greenbrowser')) > 0 ){ $s = 'GreenBrowser' ;}
    if( instr($theInfo, UCase('slimbrowser')) > 0 ){ $s = 'SlimBrowser' ;}
    if( instr($theInfo, UCase('360SE')) > 0 ){ $s = $s . '-360SE(360安全浏览器)' ;}
    if( instr($theInfo, UCase('QQDownload')) > 0 ){ $s = $s . '-QQDownload(QQ下载器)' ;}
    if( instr($theInfo, UCase('TheWorld')) > 0 ){ $s = $s . '-TheWorld(世界之窗浏览器)' ;}
    if( instr($theInfo, UCase('icafe8')) > 0 ){ $s = $s . '-icafe8(网维大师网吧管理插件)' ;}
    if( instr($theInfo, UCase('TencentTraveler')) > 0 ){ $s = $s . '-TencentTraveler(腾讯TT浏览器)' ;}
    if( instr($theInfo, UCase('baiduie8')) > 0 ){ $s = $s . '-baiduie8(百度IE8.0)' ;}
    if( instr($theInfo, UCase('iCafeMedia')) > 0 ){ $s = $s . '-iCafeMedia(网吧网媒趋势插件)' ;}
    if( instr($theInfo, UCase('DigExt')) > 0 ){ $s = $s . '-DigExt(IE5允许脱机阅读模式特殊标记)' ;}
    if( instr($theInfo, UCase('baiduds')) > 0 ){ $s = $s . '-baiduds(百度硬盘搜索)' ;}
    if( instr($theInfo, UCase('CNCDialer')) > 0 ){ $s = $s . '-CNCDialer(数控拨号)' ;}
    if( instr($theInfo, UCase('NOKIAN85')) > 0 ){ $s = $s . '-NOKIAN85(诺基亚手机)' ;}
    if( instr($theInfo, UCase('SPV_C600')) > 0 ){ $s = $s . '-SPV_C600(多普达C600)' ;}
    if( instr($theInfo, UCase('Smartphone')) > 0 ){ $s = $s . '-Smartphone(Windows Mobile for Smartphone Edition 操作系统的智能手机)' ;}
    $getBrType = $s ;
    return @$getBrType;
}
?>