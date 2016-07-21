<?PHP
//����վ����

//�����ַ��滻
function specialStrReplace( $content){
    $content= replace($content, '\\|', '[$�����ַ�A]$');
    $content= replace($content, '\\-', '[$�����ַ�B]$');
    $content= replace($content, '\\,', '[$�����ַ�C]$');
    $content= replace($content, '\\\'', '[$�����ַ�D]$');
    $content= replace($content, '\\"', '[$�����ַ�E]$');
    $specialStrReplace= $content;
    return @$specialStrReplace;
}
//�������ַ��滻
function unSpecialStrReplace( $content, $startStr){
    $content= replace($content, '[$�����ַ�A]$', $startStr . '|');
    $content= replace($content, '[$�����ַ�B]$', $startStr . '-');
    $content= replace($content, '[$�����ַ�C]$', $startStr . ',');
    $content= replace($content, '[$�����ַ�D]$', $startStr . '\'');
    $content= replace($content, '[$�����ַ�E]$', $startStr . '"');
    $unSpecialStrReplace= $content;
    return @$unSpecialStrReplace;
}

//��Ŀ���ʹ��� ��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����
function handleColumnType($columnName){
    $s ='';
    switch ( $columnName ){
        case '��ҳ' ; $s= 'home';break;
        case '�ı�' ; $s= 'text';break;
        case '��Ʒ' ; $s= 'product';break;
        case '����' ; $s= 'news';break;
        case '��Ƶ' ; $s= 'video';break;
        case '����' ; $s= 'download';break;
        case '����' ; $s= 'case';break;
        case '����' ; $s= 'message';break;
        case '����' ; $s= 'feedback';break;
        case '��Ƹ' ; $s= 'job';break;
        case '����' ; $s= 'order';
    }
    $handleColumnType= $s;
    return @$handleColumnType;
}

?>