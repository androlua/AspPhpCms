<?PHP
//����� 20160203

//��ȡ���������(�����ж�:47�������;GoogLe,Grub,MSN,Yahoo!֩��;ʮ�ֳ���IE���)  Response.Write getBrType("")
function getBrType($theInfo){
    $strType=''; $tmp1 ='';
    $getBrType = 'Other Unknown' ;
    if( $theInfo == '' ){
        $theInfo = UCase(ServerVariables('HTTP_USER_AGENT')) ;
    }
    if( instr($theInfo, UCase('mozilla')) > 0 ){ $getBrType = 'Mozilla' ;}
    if( instr($theInfo, UCase('icab')) > 0 ){ $getBrType = 'iCab' ;}
    if( instr($theInfo, UCase('lynx')) > 0 ){ $getBrType = 'Lynx' ;}
    if( instr($theInfo, UCase('links')) > 0 ){ $getBrType = 'Links' ;}
    if( instr($theInfo, UCase('elinks')) > 0 ){ $getBrType = 'ELinks' ;}
    if( instr($theInfo, UCase('jbrowser')) > 0 ){ $getBrType = 'JBrowser' ;}
    if( instr($theInfo, UCase('konqueror')) > 0 ){ $getBrType = 'konqueror' ;}
    if( instr($theInfo, UCase('wget')) > 0 ){ $getBrType = 'wget' ;}
    if( instr($theInfo, UCase('ask jeeves')) > 0 || instr($theInfo, UCase('teoma')) > 0 ){ $getBrType = 'Ask Jeeves/Teoma' ;}
    if( instr($theInfo, UCase('wget')) > 0 ){ $getBrType = 'wget' ;}
    if( instr($theInfo, UCase('opera')) > 0 ){ $getBrType = 'opera' ;}
    if( instr($theInfo, UCase('NOKIAN')) > 0 ){ $getBrType = 'NOKIAN(ŵ�����ֻ�)' ;}
    if( instr($theInfo, UCase('SPV')) > 0 ){ $getBrType = 'SPV(���մ��ֻ�)' ;}
    if( instr($theInfo, UCase('Jakarta Commons')) > 0 ){ $getBrType = 'Jakarta Commons-HttpClient' ;}
    if( instr($theInfo, UCase('Gecko')) > 0 ){
        $strType = '[Gecko] ' ;
        $getBrType = 'Mozilla Series' ;
        if( instr($theInfo, UCase('aol')) > 0 ){ $getBrType = 'AOL' ;}
        if( instr($theInfo, UCase('netscape')) > 0 ){ $getBrType = 'Netscape' ;}
        if( instr($theInfo, UCase('firefox')) > 0 ){ $getBrType = 'FireFox' ;}
        if( instr($theInfo, UCase('chimera')) > 0 ){ $getBrType = 'Chimera' ;}
        if( instr($theInfo, UCase('camino')) > 0 ){ $getBrType = 'Camino' ;}
        if( instr($theInfo, UCase('galeon')) > 0 ){ $getBrType = 'Galeon' ;}
        if( instr($theInfo, UCase('k-meleon')) > 0 ){ $getBrType = 'K-Meleon' ;}
        $getBrType = $strType . getBrType ;
    }
    if( instr($theInfo, UCase('bot')) > 0 || instr($theInfo, UCase('crawl')) > 0 ){
        $strType = '[Bot/Crawler]' ;
        if( instr($theInfo, UCase('grub')) > 0 ){ $getBrType = 'Grub' ;}
        if( instr($theInfo, UCase('googlebot')) > 0 ){ $getBrType = 'GoogleBot' ;}
        if( instr($theInfo, UCase('msnbot')) > 0 ){ $getBrType = 'MSN Bot' ;}
        if( instr($theInfo, UCase('slurp')) > 0 ){ $getBrType = 'Yahoo! Slurp' ;}
        $getBrType = $strType . getBrType ;
    }
    if( instr($theInfo, UCase('applewebkit')) > 0 ){
        $strType = '[AppleWebKit]' ;
        $getBrType = '' ;
        if( instr($theInfo, UCase('omniweb')) > 0 ){ $getBrType = 'OmniWeb' ;}
        if( instr($theInfo, UCase('safari')) > 0 ){ $getBrType = 'Safari' ;}
        $getBrType = $strType . getBrType ;
    }
    if( instr($theInfo, UCase('msie')) > 0 ){
        $strType = '[MSIE' ;
        $tmp1 = mid($theInfo,(instr($theInfo, UCase('MSIE')) + 4), 6) ;
        $tmp1 = substr($tmp1, 0 , instr($tmp1, ';') - 1) ;
        $strType = $strType . $tmp1 . ']' ;
        $getBrType = 'Internet Explorer' ;
        $getBrType = $strType . getBrType ;
    }
    if( instr($theInfo, UCase('msn')) > 0 ){ $getBrType = 'MSN' ;}
    if( instr($theInfo, UCase('aol')) > 0 ){ $getBrType = 'AOL' ;}
    if( instr($theInfo, UCase('webtv')) > 0 ){ $getBrType = 'WebTV' ;}
    if( instr($theInfo, UCase('myie2')) > 0 ){ $getBrType = 'MyIE2' ;}
    if( instr($theInfo, UCase('maxthon')) > 0 ){ $getBrType = 'Maxthon(���������)' ;}
    if( instr($theInfo, UCase('gosurf')) > 0 ){ $getBrType = 'GoSurf(���˸��������)' ;}
    if( instr($theInfo, UCase('netcaptor')) > 0 ){ $getBrType = 'NetCaptor' ;}
    if( instr($theInfo, UCase('sleipnir')) > 0 ){ $getBrType = 'Sleipnir' ;}
    if( instr($theInfo, UCase('avant browser')) > 0 ){ $getBrType = 'AvantBrowser' ;}
    if( instr($theInfo, UCase('greenbrowser')) > 0 ){ $getBrType = 'GreenBrowser' ;}
    if( instr($theInfo, UCase('slimbrowser')) > 0 ){ $getBrType = 'SlimBrowser' ;}
    if( instr($theInfo, UCase('360SE')) > 0 ){ $getBrType = getBrType . '-360SE(360��ȫ�����)' ;}
    if( instr($theInfo, UCase('QQDownload')) > 0 ){ $getBrType = getBrType . '-QQDownload(QQ������)' ;}
    if( instr($theInfo, UCase('TheWorld')) > 0 ){ $getBrType = getBrType . '-TheWorld(����֮�������)' ;}
    if( instr($theInfo, UCase('icafe8')) > 0 ){ $getBrType = getBrType . '-icafe8(��ά��ʦ���ɹ�����)' ;}
    if( instr($theInfo, UCase('TencentTraveler')) > 0 ){ $getBrType = getBrType . '-TencentTraveler(��ѶTT�����)' ;}
    if( instr($theInfo, UCase('baiduie8')) > 0 ){ $getBrType = getBrType . '-baiduie8(�ٶ�IE8.0)' ;}
    if( instr($theInfo, UCase('iCafeMedia')) > 0 ){ $getBrType = getBrType . '-iCafeMedia(������ý���Ʋ��)' ;}
    if( instr($theInfo, UCase('DigExt')) > 0 ){ $getBrType = getBrType . '-DigExt(IE5�����ѻ��Ķ�ģʽ������)' ;}
    if( instr($theInfo, UCase('baiduds')) > 0 ){ $getBrType = getBrType . '-baiduds(�ٶ�Ӳ������)' ;}
    if( instr($theInfo, UCase('CNCDialer')) > 0 ){ $getBrType = getBrType . '-CNCDialer(���ز���)' ;}
    if( instr($theInfo, UCase('NOKIAN85')) > 0 ){ $getBrType = getBrType . '-NOKIAN85(ŵ�����ֻ�)' ;}
    if( instr($theInfo, UCase('SPV_C600')) > 0 ){ $getBrType = getBrType . '-SPV_C600(���մ�C600)' ;}
    if( instr($theInfo, UCase('Smartphone')) > 0 ){ $getBrType = getBrType . '-Smartphone(Windows Mobile for Smartphone Edition ����ϵͳ�������ֻ�)' ;}
    return @$getBrType;
}
?>

