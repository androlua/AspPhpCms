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
//����������Ϣ
function aboutAuthor(){
    $c ='';
    $c = $c . '<pre>' . vbCrlf() ;
    $c = $c . '���ߣ�С��' . vbCrlf() ;
    $c = $c . '��ϵ��ʽ' . vbCrlf() ;
    $c = $c . 'QQ��313801120' . vbCrlf() ;
    $c = $c . '���䣺313801120@qq.com' . vbCrlf() ;
    $c = $c . '΢�ţ�mq313801120' . vbCrlf() ;
    $c = $c . '����Ⱥ35915100(Ⱥ�����м�����)' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . 'ҵ���س�' . vbCrlf() ;
    $c = $c . '��ͨASP,VB���򿪷�������������һ��ASP��վ��̨��VB���������' . vbCrlf() ;
    $c = $c . '��������HTML��DIV��CSS��JS' . vbCrlf() ;
    $c = $c . '����ʹ��Dreamweaver��Fireworks�� Flash��Photoshop�����' . vbCrlf() ;
    $c = $c . '�Ծ�PHP��Android�ȱ������' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '��������' . vbCrlf() ;
    $c = $c . '��ѧ����ǿ����֪ʶ���ܿ졢����������ѣ�������ս��' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '��������' . vbCrlf() ;
    $c = $c . '2007��1�� �� 2012��1�� �Ϻ���ӳ����' . vbCrlf() ;
    $c = $c . '�������ݣ���վ����' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '2013---2014���Ͼ���˼�²������޹�˾' . vbCrlf() ;
    $c = $c . '�������ݣ���վ����' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '2014---����΢ս���������޹�˾' . vbCrlf() ;
    $c = $c . '�������ݣ���վ��վ�������Լ���VB������һ����վ�������������' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '��վ������' . vbCrlf() ;
    $c = $c . 'http://www.863health.com/' . vbCrlf() ;
    $c = $c . 'http://www.wzl99.com/' . vbCrlf() ;
    $c = $c . 'http://www.jfh6666.com/' . vbCrlf() ;

    $c = $c . '</pre>' . vbCrlf() ;
    echo($c) ; die() ;
}

//������Ϣ
function authorInfo($FileInfo){
    $authorInfo = handleAuthorInfo($fileInfo,'asp');
    return @$authorInfo;
}
//����������Ϣ
function handleAuthorInfo($fileInfo,$sType){
    $c='';$phpS='';$aspS='';
    if( $sType=='php' ){
        $phpS='/';
    }else{
        $aspS='\'';
    }
    $c = $aspS . $phpS . '************************************************************' . vbCrlf() ;
    if( $FileInfo <> '' ){ $c = $c . $aspS . '  �ļ���' . $FileInfo . vbCrlf() ;}
    $c = $c . $aspS .'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)' . vbCrlf();
    $c = $c . $aspS .'��Ȩ��Դ���빫����������;�������ʹ�á� ' . vbCrlf();
    $c = $c . $aspS .'������' . Format_Time(Now(), 2) . vbCrlf() ;
    $c = $c . $aspS .'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com' . vbCrlf();
    $c = $c . $aspS .'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���' . vbCrlf();
    $c = $c . $aspS .'*                                    Powered by ASPPHPCMS ' . vbCrlf();
    $c = $c . $aspS .'************************************************************' . $phpS . vbCrlf();
    $handleAuthorInfo = $c ;
    return @$handleAuthorInfo;
}


function authorInfo2(){
    $c ='';
    $c = '                \'\'\'' . vbCrlf() ;
    $c = $c . '               (0 0)' . vbCrlf() ;
    $c = $c . '   +-----oOO----(_)------------+' . vbCrlf() ;
    $c = $c . '   |                           |' . vbCrlf() ;
    $c = $c . '   |    ������һ��������       |' . vbCrlf() ;
    $c = $c . '   |    QQ:313801120           |' . vbCrlf() ;
    $c = $c . '   |    sharembweb.com         |' . vbCrlf() ;
    $c = $c . '   |                           |' . vbCrlf() ;
    $c = $c . '   +------------------oOO------+' . vbCrlf() ;
    $c = $c . '              |__|__|' . vbCrlf() ;
    $c = $c . '               || ||' . vbCrlf() ;
    $c = $c . '              ooO Ooo' . vbCrlf() ;

    $authorInfo2 = $c ;
    return @$authorInfo2;
}
?>