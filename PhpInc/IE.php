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
//����� 20160203

//��ȡ���������(�����ж�:47�������;GoogLe,Grub,MSN,Yahoo!֩��;ʮ�ֳ���IE���)  Response.Write getBrType("")
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
    if( instr($theInfo, UCase('NOKIAN')) > 0 ){ $s = 'NOKIAN(ŵ�����ֻ�)' ;}
    if( instr($theInfo, UCase('SPV')) > 0 ){ $s = 'SPV(���մ��ֻ�)' ;}
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
    if( instr($theInfo, UCase('maxthon')) > 0 ){ $s = 'Maxthon(���������)' ;}
    if( instr($theInfo, UCase('gosurf')) > 0 ){ $s = 'GoSurf(���˸��������)' ;}
    if( instr($theInfo, UCase('netcaptor')) > 0 ){ $s = 'NetCaptor' ;}
    if( instr($theInfo, UCase('sleipnir')) > 0 ){ $s = 'Sleipnir' ;}
    if( instr($theInfo, UCase('avant browser')) > 0 ){ $s = 'AvantBrowser' ;}
    if( instr($theInfo, UCase('greenbrowser')) > 0 ){ $s = 'GreenBrowser' ;}
    if( instr($theInfo, UCase('slimbrowser')) > 0 ){ $s = 'SlimBrowser' ;}
    if( instr($theInfo, UCase('360SE')) > 0 ){ $s = $s . '-360SE(360��ȫ�����)' ;}
    if( instr($theInfo, UCase('QQDownload')) > 0 ){ $s = $s . '-QQDownload(QQ������)' ;}
    if( instr($theInfo, UCase('TheWorld')) > 0 ){ $s = $s . '-TheWorld(����֮�������)' ;}
    if( instr($theInfo, UCase('icafe8')) > 0 ){ $s = $s . '-icafe8(��ά��ʦ���ɹ�����)' ;}
    if( instr($theInfo, UCase('TencentTraveler')) > 0 ){ $s = $s . '-TencentTraveler(��ѶTT�����)' ;}
    if( instr($theInfo, UCase('baiduie8')) > 0 ){ $s = $s . '-baiduie8(�ٶ�IE8.0)' ;}
    if( instr($theInfo, UCase('iCafeMedia')) > 0 ){ $s = $s . '-iCafeMedia(������ý���Ʋ��)' ;}
    if( instr($theInfo, UCase('DigExt')) > 0 ){ $s = $s . '-DigExt(IE5�����ѻ��Ķ�ģʽ������)' ;}
    if( instr($theInfo, UCase('baiduds')) > 0 ){ $s = $s . '-baiduds(�ٶ�Ӳ������)' ;}
    if( instr($theInfo, UCase('CNCDialer')) > 0 ){ $s = $s . '-CNCDialer(���ز���)' ;}
    if( instr($theInfo, UCase('NOKIAN85')) > 0 ){ $s = $s . '-NOKIAN85(ŵ�����ֻ�)' ;}
    if( instr($theInfo, UCase('SPV_C600')) > 0 ){ $s = $s . '-SPV_C600(���մ�C600)' ;}
    if( instr($theInfo, UCase('Smartphone')) > 0 ){ $s = $s . '-Smartphone(Windows Mobile for Smartphone Edition ����ϵͳ�������ֻ�)' ;}
    $getBrType = $s ;
    return @$getBrType;
}
?>