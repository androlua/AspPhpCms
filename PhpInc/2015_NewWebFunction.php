<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-29
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By AspPhpCMS 
************************************************************/
?>
<?PHP
//����վ����

//�����ַ��滻
function specialStrReplace( $content){
    $content = Replace($content, '\\|', '[$�����ַ�A]$') ;
    $content = Replace($content, '\\-', '[$�����ַ�B]$') ;
    $content = Replace($content, '\\,', '[$�����ַ�C]$') ;
    $content = Replace($content, '\\\'', '[$�����ַ�D]$') ;
    $content = Replace($content, '\\"', '[$�����ַ�E]$') ;
    $specialStrReplace = $content ;
    return @$specialStrReplace;
}
//�������ַ��滻
function unSpecialStrReplace( $content, $startStr){
    $content = Replace($content, '[$�����ַ�A]$', $startStr . '|') ;
    $content = Replace($content, '[$�����ַ�B]$', $startStr . '-') ;
    $content = Replace($content, '[$�����ַ�C]$', $startStr . ',') ;
    $content = Replace($content, '[$�����ַ�D]$', $startStr . '\'') ;
    $content = Replace($content, '[$�����ַ�E]$', $startStr . '"') ;
    $unSpecialStrReplace = $content ;
    return @$unSpecialStrReplace;
}

//��Ŀ���ʹ��� ��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����
function handleColumnType($columnName){
    $s ='';
    switch ( $columnName ){
        case '��ҳ' ; $s = 'home';break;
        case '�ı�' ; $s = 'text';break;
        case '��Ʒ' ; $s = 'product';break;
        case '����' ; $s = 'news';break;
        case '��Ƶ' ; $s = 'video';break;
        case '����' ; $s = 'download';break;
        case '����' ; $s = 'case';break;
        case '����' ; $s = 'message';break;
        case '����' ; $s = 'feedback';break;
        case '��Ƹ' ; $s = 'job';break;
        case '����' ; $s = 'order';
    }
    $handleColumnType = $s ;
    return @$handleColumnType;
}

?>