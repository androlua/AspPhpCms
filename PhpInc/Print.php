<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-24
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By �ƶ� 
************************************************************/
?>
<?PHP
//�������(2014,03,28)

//Ը����ʾ����
function printPre($content){
    $content = Replace($content, '<', '&lt;') ;
    $printPre = '<pre>' . $content . '</pre>' ;
    return @$printPre;
}

//������Ϣ
function authorInfo($FileInfo){
    $c ='';
    $c = '\'************************************************************' . "\n" ;
    if( $FileInfo <> '' ){ $c = $c . '\'  �ļ���' . $FileInfo . "\n" ;}
    $c = $c . '\'  ���ߣ��ƶ�' . "\n" ;
    $c = $c . '\'  ��Ȩ��Դ���빫����������;�������ʹ�á�' . "\n" ;
    $c = $c . '\'  ������' . Format_Time(Now(), 2) . "\n" ;
    $c = $c . '\'  ��ϵ��QQ313801120  ����Ⱥ35915100    ����313801120@qq.com' . "\n" ;
    $c = $c . '\'                                       Powered By �ƶ� ' . "\n" ;
    $c = $c . '\'************************************************************' . "\n" ;
    $authorInfo = $c ;
    return @$authorInfo;
}
function authorInfo2(){
    $c ='';
    $c = '                \'\'\'' . "\n" ;
    $c = $c . '               (0 0)' . "\n" ;
    $c = $c . '   +-----oOO----(_)------------+' . "\n" ;
    $c = $c . '   |                           |' . "\n" ;
    $c = $c . '   |    ������һ��������       |' . "\n" ;
    $c = $c . '   |    QQ:313801120           |' . "\n" ;
    $c = $c . '   |                           |' . "\n" ;
    $c = $c . '   +------------------oOO------+' . "\n" ;
    $c = $c . '              |__|__|' . "\n" ;
    $c = $c . '               || ||' . "\n" ;
    $c = $c . '              ooO Ooo' . "\n" ;

    $authorInfo2 = $c ;
    return @$authorInfo2;
}
//�۵��˵�
function foldingMenu($id, $s, $msg){
    //On Error Resume Next
    $nRnd=''; $c ='';
    if( $id == '' ){

        $nRnd = CLng(rnd() * 29252888) ;
    }else{
        $nRnd = $id ;
    }
    $c = '<div style="width:100%; font-size:12px;;line-height:150%;margin-bottom:4px;">' ;
    $c = $c . '  <label onClick="ERRORDIV' . $nRnd . '.style.display=(ERRORDIV' . $nRnd . '.style.display==\'none\'?\'\':\'none\')">' ;
    $c = $c . '  <span style="background-color:#666;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer">�� ' . $s . ' ��</span><br />' ;
    $c = $c . '  </label>' ;
    $c = $c . '  <div id="ERRORDIV' . $nRnd . '" style="width:100%;border:1px solid #820222;padding:5px;overflow:hidden;display:none;">' ;
    $c = $c . $msg ;
    $c = $c . '  </div>' ;
    $c = $c . '</div>' ;
    $foldingMenu = $c ;
    return @$foldingMenu;
}
//���ر����ɫ
function returnRen($Lable, $msg){
    $returnRen = '<font color=red>' . $Lable . '</font>��' . $msg ;
    return @$returnRen;
}
//����Hr
function returnHr(){
    $returnHr = '<hr size=\'1\' color=\'#666666\'> ' ;
    return @$returnHr;
}
//����Hr
function returnRenHr(){
    $returnRenHr = '<hr size=\'1\' color=\'red\'> ' ;
    return @$returnRenHr;
}
//���������Ϣ �ڶ���
function showErr( $ErrCode, $ErrDesc){
    $c ='';
    $c = '<style>.ab-showerr{width:400px;font-size:12px;font-family:Consolas;margin:10px auto;padding:0;background-color:#FFF;}' ;
    $c = $c . '.ab-showerr h3,.ab-showerr h4{font-size:12px;margin:0;line-height:24px;text-align:center;background-color:#999;border:1px solid #555;color:#FFF;border-bottom:none;}.ab-showerr h4{padding:5px;line-height:1.5em;text-align:left;background-color:#FFC;color:#000; font-weight:normal;}' ;
    $c = $c . '.ab-showerr h4 strong{color:red;}.ab-showerr table{width:100%;margin:0;padding:0;border-collapse:collapse;border:1px solid #555;border-bottom:none;}.ab-showerr th{background-color:#EEE;white-space:nowrap;}.ab-showerr thead th{background-color:#CCC;}.ab-showerr th,.ab-showerr td{font-size:12px;border:1px solid #999;padding:6px;line-height:20px;word-break:break-all;}.ab-showerr span.info{color:#F30;}</style>' ;
    $c = $c . '<div class="ab-showerr"><h3>Microsoft VBScript ����������</h3><h4>��������ˣ�������룺 <strong>' . $ErrCode . '</strong> �������Ǵ���������</h4><table><tr><td>' . $ErrDesc . '</td></tr></table></div>' ;
    echo($c) ; die() ;
}

//��ӡForm��ת�͵�ֵ������д����  ��Ϊ��������VB�������  ��Print.Asp���ù���
function printFormInfo(){ //���պ���
}


//DedeCms������ʽ 20150113
function dedeCMSMsg(){
    $c ='';
    $c = '<style> ' . "\n" ;
    $c = $c . '.msgbox {' . "\n" ;
    $c = $c . '    width: 450px;' . "\n" ;
    $c = $c . '    border: 1px solid #DADADA;' . "\n" ;
    $c = $c . '    margin:0 auto;' . "\n" ;
    $c = $c . '    margin-top:20px;' . "\n" ;
    $c = $c . '    line-height:20px;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.msgbox .ptitle{' . "\n" ;
    $c = $c . '    padding: 6px;' . "\n" ;
    $c = $c . '    font-size: 12px;' . "\n" ;
    $c = $c . '    border-bottom: 1px solid #DADADA;' . "\n" ;
    $c = $c . '    background: #DBEEBD url(/plus/img/wbg.gif);' . "\n" ;
    $c = $c . '    font-weight:bold;' . "\n" ;
    $c = $c . '    text-align:center;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.msgbox .pcontent{' . "\n" ;
    $c = $c . '    height: 100px;' . "\n" ;
    $c = $c . '    font-size: 10pt;' . "\n" ;
    $c = $c . '    background: #ffffff;' . "\n" ;
    $c = $c . '    text-align:center;' . "\n" ;
    $c = $c . '    padding-top:30px;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</style> ' . "\n" ;
    $c = $c . '<div class="msgbox">' . "\n" ;
    $c = $c . '    <div class="ptitle">��ʾ��Ϣ��</div>' . "\n" ;
    $c = $c . '    <div class="pcontent">' . "\n" ;
    $c = $c . '        �ɹ���¼������ת����������ҳ��<br>' . "\n" ;
    $c = $c . '        <a href="#">�����������û��Ӧ����������...</a>' . "\n" ;
    $c = $c . '' . "\n" ;
    $c = $c . '    </div>' . "\n" ;
    $c = $c . '</div>' . "\n" ;
    $dedeCMSMsg = $c ;
    return @$dedeCMSMsg;
}
?>

