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
//���ú�����ȫ (2013,9,27Option Explicit)

//�ɹ���Զ���ǻ����� 2013,10,4,��

//��ʾ�����Ի���20150312
function MsgBox( $Content){
    $Content=Replace(Replace($Content,Chr(10),'\\n'),Chr(13),'\\n');
    echo('<script>alert(\''. $Content .'\');</script>');
}
//��ʾ20150729
function MBInfo($title,$content){	 //���պ���
}
//��Queststring��ֵ
function AddRq($GookeName,$ValueStr){
    @$_GET[$GookeName] = $ValueStr ;
}
//���Cookiesֵ
function Rc($GookeName){
    $Rc = @$_COOKIE[$GookeName];
    return @$Rc;
}
//��Cookies��ֵ
function AddRc($GookeName,$ValueStr,$DateStr){
    @$_COOKIE[$GookeName] = $ValueStr ;
    if( $DateStr<>'' ){ @$_COOKIE[$GookeName] = $DateStr;}
}
//ASP�Դ�����ת

//�滻Request.Form����
function Rf($Str){
    $Rf = @$_POST[$Str] ;
    return @$Rf;
}

//��ô�ֵ
function Rq($Str){
    $Rq = @$_GET[$Str];
    return @$Rq;
}
//��ô�ֵ
function Rfq($Str){
    $Rfq = @$_REQUEST[$Str];
    return @$Rfq;
}
//�滻Response.Write����
function Rw($Str){
    echo($Str);
}
//������ݼӻ���
function RwBr($Str){
    echo($Str . vbCrlf()) ;
}
//�滻Response.Write���� + Response.End()
function RwEnd($Str){
    echo($Str);
    die();
}
//HTML����
function HtmEnd($Str){
    RwEnd($Str);
}
//�滻Response.Write����+Response.End()
function PHPDie($Str){
    echo($Str);
    die();
}
//�滻Response.Write����
function Debug($Str){
    echo('<div  style="border:solid 1px #000000;margin-bottom:2px;">����' . $Str . '</div>' . vbCrlf());
}
//����
function FlashTrace($Str){
    $FlashTrace = Debug($Str);
    return @$FlashTrace;
}
//������ʾ��Ϣ
function ASPEcho($Word, $Str){
    echoPrompt($Word, $Str);
}
//������ʾ��Ϣ+��ɫ
function EchoRed($Word, $Str){
    echo('<font color=Red>' . $Word . '</font>��' . $Str . '<br>');
}
//������ʾ��Ϣ+��ɫ+��
function EchoRedB($Word, $Str){
    echo('<b><font color=Red>' . $Word . '</font>��' . $Str . '</b><br>');
}
//��������
function echoPrompt($Word, $Str){
    echo('<font color=Green>' . $Word . '</font>��' . $Str . '<br>');
}
//��������
function echoStr($Word, $Str){
    echoPrompt($Word, $Str);
}
//��ӡ���� ��ӡPHP���õ�
function PHPPrint_R($Content){
    $I='';$C='';
    if( TypeName($Content) == 'Variant()' ){
        for( $I=0 ; $I<= Ubound($Content); $I++){
            $C = $C . '['. $I .'] => ' . $Content[$I] . vbCrlf();
        }
    }else{
        $C = $Content;
    }
    echo($C);
}
//������ʾ��Ϣ ��ɫ
function SetColorEcho($Color, $Word, $Str){
    echo('<font color='. $Color .'>' . $Word . '</font>��' . $Str . '<br>');
}
//������ʾ��Ϣ��ͣ
function Eerr($Word, $Str){
    //	Response.Write(TypeName(Word) & "-" & TypeName(Str)):Response.End()
    echo('<font color=red>' . $Word . '</font>��' . $Str);
    die() ;
}
//������������
function DoEvents(){
    PHPFlush() ;
}
//����:ASP���IIF �磺IIf(1 = 2, "a", "b")

//Hr
function HR(){
    echo('<hr size=\'1\' color=\'#666666\'> ') ;
}

//����ַ��� ���ñ���20141217
//Public Sub Echo(ByVal s) : Response.Write(s) : End Sub
//����ַ�����һ�����з�
function PHPPrint( $s){
    echo($s . vbCrlf()) ; PHPFlush();
}
//����ַ�����һ��html���з�
function Println( $s){
    echo($s . '<br />' . vbCrlf()) ; PHPFlush();
}
//����ַ�������HTML��ǩתΪ��ͨ�ַ�
function PrintHtml( $s){
    echo($GLOBALS['HtmlEncode'][$s] . vbCrlf());
}
function PrintlnHtml( $s){
    echo($GLOBALS['HtmlEncode'][$s] . '<br />') . vbCrlf();
}
//���������ֱ�����Ϊ�ַ���(Json��ʽ)
//Public Sub PrintString(ByVal s) : Response.Write(Str.ToString(s) & VbCrLf) : End Sub
//Public Sub PrintlnString(ByVal s) : Response.Write(Str.ToString(s)) & "<br />" & VbCrLf : End Sub
//���������ʽ�����ַ���
//Public Sub PrintFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & VbCrLf : End Sub
//Public Sub PrintlnFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & "<br />" & VbCrLf : End Sub
//����ַ�������ֹ��������
function PrintEnd( $s){
    echo($s) ; die();
}




//�ж��Ƿ�һ����һ������checked,���߷��ؿ�ֵ
function IsChecked( $Str, $Str2){
    if( $Str == $Str2 ){ $IsChecked = 'checked=\'checked\'' ;}else{ $IsChecked == '' ;}
    return @$IsChecked;
}
//�ж��Ƿ�һ����һ������selected,���߷��ؿ�ֵ
function IsSelected( $Str, $Str2){
    if( $Str == $Str2 ){ $IsSelected = 'selected=\'selected\'' ;}else{ $IsSelected == '' ;}
    return @$IsSelected;
}


function DoError($S, $Msg){
    //On Error Resume Next
    $nRnd=''; $C ='';

    $nRnd = CLng(rnd() * 29252888) ;
    $C = '<br />' ;
    $C = $C . '<div style="width:100%; font-size:12px;;line-height:150%">' ;
    $C = $C . '  <label onClick="ERRORDIV' . $nRnd . '.style.display=(ERRORDIV' . $nRnd . '.style.display==\'none\'?\'\':\'none\')">' ;
    $C = $C . '  <span style="background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer">�� ���� ��ʾ��Ϣ ERROR ��</span><br />' ;
    $C = $C . '  </label>' ;
    $C = $C . '  <div id="ERRORDIV' . $nRnd . '" style="width:100%;border:1px solid #820222;padding:5px;overflow:hidden;">' ;
    $C = $C . ' <span style="color:#FF0000;">��������</span> ' . $S . '<br />' ;
    $C = $C . ' <span style="color:#FF0000;">������Ϣ</span> ' . $Msg . '<br />' ;
    $C = $C . '  </div>' ;
    $C = $C . '</div>' ;
    $C = $C . '<br />' ;
    echo($C) ;
    die() ;//��ֹ������ֹͣ
}

//ִ��ASP�ű�
function PHPExec( $tStr){
    if( $tStr=='' ){ return ''; }

    Execute($tStr);

}

?>