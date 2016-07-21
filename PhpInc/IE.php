<?PHP
//����� 20160203

//��ȡ���������(�����ж�:47�������;GoogLe,Grub,MSN,Yahoo!֩��;ʮ�ֳ���IE���)  Response.Write getBrType("")
function getBrType($theInfo){
    $strType=''; $tmp1=''; $s ='';
    $s= 'Other Unknown';
    if( $theInfo== '' ){
        $theInfo= uCase(serverVariables('HTTP_USER_AGENT'));
    }
    if( inStr($theInfo, uCase('mozilla')) > 0 ){ $s= 'Mozilla' ;}
    if( inStr($theInfo, uCase('icab')) > 0 ){ $s= 'iCab' ;}
    if( inStr($theInfo, uCase('lynx')) > 0 ){ $s= 'Lynx' ;}
    if( inStr($theInfo, uCase('links')) > 0 ){ $s= 'Links' ;}
    if( inStr($theInfo, uCase('elinks')) > 0 ){ $s= 'ELinks' ;}
    if( inStr($theInfo, uCase('jbrowser')) > 0 ){ $s= 'JBrowser' ;}
    if( inStr($theInfo, uCase('konqueror')) > 0 ){ $s= 'konqueror' ;}
    if( inStr($theInfo, uCase('wget')) > 0 ){ $s= 'wget' ;}
    if( inStr($theInfo, uCase('ask jeeves')) > 0 || inStr($theInfo, uCase('teoma')) > 0 ){ $s= 'Ask Jeeves/Teoma' ;}
    if( inStr($theInfo, uCase('wget')) > 0 ){ $s= 'wget' ;}
    if( inStr($theInfo, uCase('opera')) > 0 ){ $s= 'opera' ;}
    if( inStr($theInfo, uCase('NOKIAN')) > 0 ){ $s= 'NOKIAN(ŵ�����ֻ�)' ;}
    if( inStr($theInfo, uCase('SPV')) > 0 ){ $s= 'SPV(���մ��ֻ�)' ;}
    if( inStr($theInfo, uCase('Jakarta Commons')) > 0 ){ $s= 'Jakarta Commons-HttpClient' ;}
    if( inStr($theInfo, uCase('Gecko')) > 0 ){
        $strType= '[Gecko] ';
        $s= 'Mozilla Series';
        if( inStr($theInfo, uCase('aol')) > 0 ){ $s= 'AOL' ;}
        if( inStr($theInfo, uCase('netscape')) > 0 ){ $s= 'Netscape' ;}
        if( inStr($theInfo, uCase('firefox')) > 0 ){ $s= 'FireFox' ;}
        if( inStr($theInfo, uCase('chimera')) > 0 ){ $s= 'Chimera' ;}
        if( inStr($theInfo, uCase('camino')) > 0 ){ $s= 'Camino' ;}
        if( inStr($theInfo, uCase('galeon')) > 0 ){ $s= 'Galeon' ;}
        if( inStr($theInfo, uCase('k-meleon')) > 0 ){ $s= 'K-Meleon' ;}
        $s= $strType . $s;
    }
    if( inStr($theInfo, uCase('bot')) > 0 || inStr($theInfo, uCase('crawl')) > 0 ){
        $strType= '[Bot/Crawler]';
        if( inStr($theInfo, uCase('grub')) > 0 ){ $s= 'Grub' ;}
        if( inStr($theInfo, uCase('googlebot')) > 0 ){ $s= 'GoogleBot' ;}
        if( inStr($theInfo, uCase('msnbot')) > 0 ){ $s= 'MSN Bot' ;}
        if( inStr($theInfo, uCase('slurp')) > 0 ){ $s= 'Yahoo! Slurp' ;}
        $s= $strType . $s;
    }
    if( inStr($theInfo, uCase('applewebkit')) > 0 ){
        $strType= '[AppleWebKit]';
        $s= '';
        if( inStr($theInfo, uCase('omniweb')) > 0 ){ $s= 'OmniWeb' ;}
        if( inStr($theInfo, uCase('safari')) > 0 ){ $s= 'Safari' ;}
        $s= $strType . $s;
    }
    if( inStr($theInfo, uCase('msie')) > 0 ){
        $strType= '[MSIE';
        $tmp1= mid($theInfo,(inStr($theInfo, uCase('MSIE')) + 4), 6);
        $tmp1= left($tmp1, inStr($tmp1, ';') - 1);
        $strType= $strType . $tmp1 . ']';
        $s= 'Internet Explorer';
        $s= $strType . $s;
    }
    if( inStr($theInfo, uCase('msn')) > 0 ){ $s= 'MSN' ;}
    if( inStr($theInfo, uCase('aol')) > 0 ){ $s= 'AOL' ;}
    if( inStr($theInfo, uCase('webtv')) > 0 ){ $s= 'WebTV' ;}
    if( inStr($theInfo, uCase('myie2')) > 0 ){ $s= 'MyIE2' ;}
    if( inStr($theInfo, uCase('maxthon')) > 0 ){ $s= 'Maxthon(���������)' ;}
    if( inStr($theInfo, uCase('gosurf')) > 0 ){ $s= 'GoSurf(���˸��������)' ;}
    if( inStr($theInfo, uCase('netcaptor')) > 0 ){ $s= 'NetCaptor' ;}
    if( inStr($theInfo, uCase('sleipnir')) > 0 ){ $s= 'Sleipnir' ;}
    if( inStr($theInfo, uCase('avant browser')) > 0 ){ $s= 'AvantBrowser' ;}
    if( inStr($theInfo, uCase('greenbrowser')) > 0 ){ $s= 'GreenBrowser' ;}
    if( inStr($theInfo, uCase('slimbrowser')) > 0 ){ $s= 'SlimBrowser' ;}
    if( inStr($theInfo, uCase('360SE')) > 0 ){ $s= $s . '-360SE(360��ȫ�����)' ;}
    if( inStr($theInfo, uCase('QQDownload')) > 0 ){ $s= $s . '-QQDownload(QQ������)' ;}
    if( inStr($theInfo, uCase('TheWorld')) > 0 ){ $s= $s . '-TheWorld(����֮�������)' ;}
    if( inStr($theInfo, uCase('icafe8')) > 0 ){ $s= $s . '-icafe8(��ά��ʦ���ɹ�����)' ;}
    if( inStr($theInfo, uCase('TencentTraveler')) > 0 ){ $s= $s . '-TencentTraveler(��ѶTT�����)' ;}
    if( inStr($theInfo, uCase('baiduie8')) > 0 ){ $s= $s . '-baiduie8(�ٶ�IE8.0)' ;}
    if( inStr($theInfo, uCase('iCafeMedia')) > 0 ){ $s= $s . '-iCafeMedia(������ý���Ʋ��)' ;}
    if( inStr($theInfo, uCase('DigExt')) > 0 ){ $s= $s . '-DigExt(IE5�����ѻ��Ķ�ģʽ������)' ;}
    if( inStr($theInfo, uCase('baiduds')) > 0 ){ $s= $s . '-baiduds(�ٶ�Ӳ������)' ;}
    if( inStr($theInfo, uCase('CNCDialer')) > 0 ){ $s= $s . '-CNCDialer(���ز���)' ;}
    if( inStr($theInfo, uCase('NOKIAN85')) > 0 ){ $s= $s . '-NOKIAN85(ŵ�����ֻ�)' ;}
    if( inStr($theInfo, uCase('SPV_C600')) > 0 ){ $s= $s . '-SPV_C600(���մ�C600)' ;}
    if( inStr($theInfo, uCase('Smartphone')) > 0 ){ $s= $s . '-Smartphone(Windows Mobile for Smartphone Edition ����ϵͳ�������ֻ�)' ;}
    $getBrType= $s;
    return @$getBrType;
}
?>