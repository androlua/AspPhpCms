<?PHP
//���ú�����ȫ (2013,9,27Option Explicit)

//�ɹ���Զ���ǻ����� 2013,10,4,��

//��ʾ�����Ի���20150312
function msgBox( $content){
    $content= Replace(Replace($content, Chr(10), '\\n'), Chr(13), '\\n');
    echo('<script>alert(\'' . $content . '\');</script>');
}
//��ʾ20150729
function MBInfo($title, $content){ //���պ���
}
//��Queststring��ֵ
function addRq($GookeName, $valueStr){
    @$_GET[$GookeName]= $valueStr;
}
//���Cookiesֵ
function rc($GookeName){
    $rc= @$_COOKIE[$GookeName];
    return @$rc;
}
//��Cookies��ֵ
function addRc($GookeName, $valueStr, $DateStr){
    @$_COOKIE[$GookeName]= $valueStr;
    if( $DateStr <> '' ){ @$_COOKIE[$GookeName]= $DateStr ;}
}
//ASP�Դ�����ת

//�滻Request.Form����
function rf($str){
    $rf= @$_POST[$str];
    return @$rf;
}

//��ô�ֵ
function rq($str){
    $rq= @$_GET[$str];
    return @$rq;
}
//��ô�ֵ
function rfq($str){
    $rfq= @$_REQUEST[$str];
    return @$rfq;
}
//�滻Response.Write����
function rw($str){
    echo($str);
}
//������ݼӻ���
function rwBr($str){
    echo($str . vbCrlf());
}
//�滻Response.Write���� + Response.End()
function rwEnd($str){
    echo($str);
    die();
}
//HTML����
function htmEnd($str){
    RwEnd($str);
}
//�滻Response.Write����+Response.End()
function PHPDie($str){
    echo($str);
    die();
}
//�滻Response.Write����
function debug($str){
    echo('<div  style="border:solid 1px #000000;margin-bottom:2px;">����' . $str . '</div>' . vbCrlf());
}
//����
function FlashTrace($str){
    $FlashTrace= debug($str);
    return @$FlashTrace;
}
//������ʾ��Ϣ
function ASPEcho($Word, $str){
    echoPrompt($Word, $str);
}
//������ʾ��Ϣ+��ɫ
function echoRed($Word, $str){
    echo('<font color=Red>' . $Word . '</font>��' . $str . '<br>');
}
//������ʾ��Ϣ+��ɫ+��
function echoRedB($Word, $str){
    echo('<b><font color=Red>' . $Word . '</font>��' . $str . '</b><br>');
}
//��������
function echoPrompt($Word, $str){
    echo('<font color=Green>' . $Word . '</font>��' . $str . '<br>');
}
//��������
function echoStr($Word, $str){
    echoPrompt($Word, $str);
}
//��ӡ���� ��ӡPHP���õ�
function PHPPrint_R($content){
    $i=''; $c ='';
    if( gettype($content)== 'Variant()' ){
        for( $i= 0 ; $i<= UBound($content); $i++){
            $c= $c . '[' . $i . '] => ' . $content[$i] . vbCrlf();
        }
    }else{
        $c= $content;
    }
    echo($c);
}
//������ʾ��Ϣ ��ɫ
function setColorEcho($color, $Word, $str){
    echo('<font color=' . $color . '>' . $Word . '</font>��' . $str . '<br>');
}
//������ʾ��Ϣ��ͣ
function eerr($Word, $str){
    //Response.Write(TypeName(Word) & "-" & TypeName(Str)):Response.End()
    echo('<font color=red>' . $Word . '</font>��' . $str);
    die();
}
//������������
function doEvents(){
    PHPFlush();
}
//����:ASP���IIF �磺IIf(1 = 2, "a", "b")

//Hr
function HR(){
    echo('<hr size=\'1\' color=\'#666666\'> ');
}
//BR 20160517
function BR(){
    echo('<br/>');
}

//����ַ��� ���ñ���20141217
//Public Sub Echo(ByVal s) : Response.Write(s) : End Sub
//����ַ�����һ�����з�
function PHPPrint( $s){
    echo($s . vbCrlf()) ; PHPFlush();
}
//����ַ�����һ��html���з�
function println( $s){
    echo($s . '<br />' . vbCrlf()) ; PHPFlush();
}
//����ַ�������HTML��ǩתΪ��ͨ�ַ�
function printHtml( $s){
    echo(displayHtml($s) . vbCrlf());
}
function printlnHtml( $s){
    echo(displayHtml($s) . '<br />') . vbCrlf();
}
//���������ֱ�����Ϊ�ַ���(Json��ʽ)
//Public Sub PrintString(ByVal s) : Response.Write(Str.ToString(s) & VbCrLf) : End Sub
//Public Sub PrintlnString(ByVal s) : Response.Write(Str.ToString(s)) & "<br />" & VbCrLf : End Sub
//���������ʽ�����ַ���
//Public Sub PrintFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & VbCrLf : End Sub
//Public Sub PrintlnFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & "<br />" & VbCrLf : End Sub
//����ַ�������ֹ��������
function printEnd( $s){
    echo($s) ; die();
}




//�ж��Ƿ�һ����һ������checked,���߷��ؿ�ֵ
function isChecked( $str, $str2){
    if( $str== $str2 ){ $isChecked= 'checked=\'checked\'' ;}else{ $isChecked== '' ;}
    return @$isChecked;
}
//�ж��Ƿ�һ����һ������selected,���߷��ؿ�ֵ
function isSelected( $str, $str2){
    if( $str== $str2 ){ $isSelected= 'selected=\'selected\'' ;}else{ $isSelected== '' ;}
    return @$isSelected;
}


function doError($s, $msg){
    //On Error Resume Next
    $nRnd=''; $c ='';

    $nRnd= intval(rnd() * 29252888);
    $c= '<br />';
    $c= $c . '<div style="width:100%; font-size:12px;;line-height:150%">';
    $c= $c . '  <label onClick="ERRORDIV' . $nRnd . '.style.display=(ERRORDIV' . $nRnd . '.style.display==\'none\'?\'\':\'none\')">';
    $c= $c . '  <span style="background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer">�� ���� ��ʾ��Ϣ ERROR ��</span><br />';
    $c= $c . '  </label>';
    $c= $c . '  <div id="ERRORDIV' . $nRnd . '" style="width:100%;border:1px solid #820222;padding:5px;overflow:hidden;">';
    $c= $c . ' <span style="color:#FF0000;">��������</span> ' . $s . '<br />';
    $c= $c . ' <span style="color:#FF0000;">������Ϣ</span> ' . $msg . '<br />';
    $c= $c . '  </div>';
    $c= $c . '</div>';
    $c= $c . '<br />';
    echo($c);
    die(); //��ֹ������ֹͣ
}

//ִ��ASP�ű�
function PHPExec( $tStr){
    if( $tStr== '' ){ return '';  }

    Execute($tStr);

}

?>