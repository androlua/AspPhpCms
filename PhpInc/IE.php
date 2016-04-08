<?PHP
//添加于 20160203

//获取浏览器类型(可以判断:47种浏览器;GoogLe,Grub,MSN,Yahoo!蜘蛛;十种常见IE插件)  Response.Write getBrType("")
function getBrType($theInfo){
    $strType=''; $tmp1=''; $s ='';
    $s= 'Other Unknown';
    if( $theInfo== '' ){
        $theInfo= strtoupper(ServerVariables('HTTP_USER_AGENT'));
    }
    if( instr($theInfo, strtoupper('mozilla')) > 0 ){ $s= 'Mozilla' ;}
    if( instr($theInfo, strtoupper('icab')) > 0 ){ $s= 'iCab' ;}
    if( instr($theInfo, strtoupper('lynx')) > 0 ){ $s= 'Lynx' ;}
    if( instr($theInfo, strtoupper('links')) > 0 ){ $s= 'Links' ;}
    if( instr($theInfo, strtoupper('elinks')) > 0 ){ $s= 'ELinks' ;}
    if( instr($theInfo, strtoupper('jbrowser')) > 0 ){ $s= 'JBrowser' ;}
    if( instr($theInfo, strtoupper('konqueror')) > 0 ){ $s= 'konqueror' ;}
    if( instr($theInfo, strtoupper('wget')) > 0 ){ $s= 'wget' ;}
    if( instr($theInfo, strtoupper('ask jeeves')) > 0 || instr($theInfo, strtoupper('teoma')) > 0 ){ $s= 'Ask Jeeves/Teoma' ;}
    if( instr($theInfo, strtoupper('wget')) > 0 ){ $s= 'wget' ;}
    if( instr($theInfo, strtoupper('opera')) > 0 ){ $s= 'opera' ;}
    if( instr($theInfo, strtoupper('NOKIAN')) > 0 ){ $s= 'NOKIAN(诺基亚手机)' ;}
    if( instr($theInfo, strtoupper('SPV')) > 0 ){ $s= 'SPV(多普达手机)' ;}
    if( instr($theInfo, strtoupper('Jakarta Commons')) > 0 ){ $s= 'Jakarta Commons-HttpClient' ;}
    if( instr($theInfo, strtoupper('Gecko')) > 0 ){
        $strType= '[Gecko] ';
        $s= 'Mozilla Series';
        if( instr($theInfo, strtoupper('aol')) > 0 ){ $s= 'AOL' ;}
        if( instr($theInfo, strtoupper('netscape')) > 0 ){ $s= 'Netscape' ;}
        if( instr($theInfo, strtoupper('firefox')) > 0 ){ $s= 'FireFox' ;}
        if( instr($theInfo, strtoupper('chimera')) > 0 ){ $s= 'Chimera' ;}
        if( instr($theInfo, strtoupper('camino')) > 0 ){ $s= 'Camino' ;}
        if( instr($theInfo, strtoupper('galeon')) > 0 ){ $s= 'Galeon' ;}
        if( instr($theInfo, strtoupper('k-meleon')) > 0 ){ $s= 'K-Meleon' ;}
        $s= $strType . $s;
    }
    if( instr($theInfo, strtoupper('bot')) > 0 || instr($theInfo, strtoupper('crawl')) > 0 ){
        $strType= '[Bot/Crawler]';
        if( instr($theInfo, strtoupper('grub')) > 0 ){ $s= 'Grub' ;}
        if( instr($theInfo, strtoupper('googlebot')) > 0 ){ $s= 'GoogleBot' ;}
        if( instr($theInfo, strtoupper('msnbot')) > 0 ){ $s= 'MSN Bot' ;}
        if( instr($theInfo, strtoupper('slurp')) > 0 ){ $s= 'Yahoo! Slurp' ;}
        $s= $strType . $s;
    }
    if( instr($theInfo, strtoupper('applewebkit')) > 0 ){
        $strType= '[AppleWebKit]';
        $s= '';
        if( instr($theInfo, strtoupper('omniweb')) > 0 ){ $s= 'OmniWeb' ;}
        if( instr($theInfo, strtoupper('safari')) > 0 ){ $s= 'Safari' ;}
        $s= $strType . $s;
    }
    if( instr($theInfo, strtoupper('msie')) > 0 ){
        $strType= '[MSIE';
        $tmp1= mid($theInfo,(instr($theInfo, strtoupper('MSIE')) + 4), 6);
        $tmp1= substr($tmp1, 0 , instr($tmp1, ';') - 1);
        $strType= $strType . $tmp1 . ']';
        $s= 'Internet Explorer';
        $s= $strType . $s;
    }
    if( instr($theInfo, strtoupper('msn')) > 0 ){ $s= 'MSN' ;}
    if( instr($theInfo, strtoupper('aol')) > 0 ){ $s= 'AOL' ;}
    if( instr($theInfo, strtoupper('webtv')) > 0 ){ $s= 'WebTV' ;}
    if( instr($theInfo, strtoupper('myie2')) > 0 ){ $s= 'MyIE2' ;}
    if( instr($theInfo, strtoupper('maxthon')) > 0 ){ $s= 'Maxthon(傲游浏览器)' ;}
    if( instr($theInfo, strtoupper('gosurf')) > 0 ){ $s= 'GoSurf(冲浪高手浏览器)' ;}
    if( instr($theInfo, strtoupper('netcaptor')) > 0 ){ $s= 'NetCaptor' ;}
    if( instr($theInfo, strtoupper('sleipnir')) > 0 ){ $s= 'Sleipnir' ;}
    if( instr($theInfo, strtoupper('avant browser')) > 0 ){ $s= 'AvantBrowser' ;}
    if( instr($theInfo, strtoupper('greenbrowser')) > 0 ){ $s= 'GreenBrowser' ;}
    if( instr($theInfo, strtoupper('slimbrowser')) > 0 ){ $s= 'SlimBrowser' ;}
    if( instr($theInfo, strtoupper('360SE')) > 0 ){ $s= $s . '-360SE(360安全浏览器)' ;}
    if( instr($theInfo, strtoupper('QQDownload')) > 0 ){ $s= $s . '-QQDownload(QQ下载器)' ;}
    if( instr($theInfo, strtoupper('TheWorld')) > 0 ){ $s= $s . '-TheWorld(世界之窗浏览器)' ;}
    if( instr($theInfo, strtoupper('icafe8')) > 0 ){ $s= $s . '-icafe8(网维大师网吧管理插件)' ;}
    if( instr($theInfo, strtoupper('TencentTraveler')) > 0 ){ $s= $s . '-TencentTraveler(腾讯TT浏览器)' ;}
    if( instr($theInfo, strtoupper('baiduie8')) > 0 ){ $s= $s . '-baiduie8(百度IE8.0)' ;}
    if( instr($theInfo, strtoupper('iCafeMedia')) > 0 ){ $s= $s . '-iCafeMedia(网吧网媒趋势插件)' ;}
    if( instr($theInfo, strtoupper('DigExt')) > 0 ){ $s= $s . '-DigExt(IE5允许脱机阅读模式特殊标记)' ;}
    if( instr($theInfo, strtoupper('baiduds')) > 0 ){ $s= $s . '-baiduds(百度硬盘搜索)' ;}
    if( instr($theInfo, strtoupper('CNCDialer')) > 0 ){ $s= $s . '-CNCDialer(数控拨号)' ;}
    if( instr($theInfo, strtoupper('NOKIAN85')) > 0 ){ $s= $s . '-NOKIAN85(诺基亚手机)' ;}
    if( instr($theInfo, strtoupper('SPV_C600')) > 0 ){ $s= $s . '-SPV_C600(多普达C600)' ;}
    if( instr($theInfo, strtoupper('Smartphone')) > 0 ){ $s= $s . '-Smartphone(Windows Mobile for Smartphone Edition 操作系统的智能手机)' ;}
    $getBrType= $s;
    return @$getBrType;
}
?>