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
//������������ 20160129
function saveArticleComment(){
    $itemid=''; $iP=''; $bodycontent ='';
    $itemid = @$_REQUEST['itemid'] ;
    $bodycontent = ADSql(@$_REQUEST['content']) ;
    $iP = getIP() ;
    $GLOBALS['conn=']=OpenConn() ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'tablecomment (tableName,itemid,ip,bodycontent,adddatetime) values(\'ArticleDetail\',' . $itemid . ',\'' . $iP . '\',\'' . $bodycontent . '\',\'' . Now() . '\')') ;
    ASPEcho('��ʾ', '���۳ɹ����ȴ�����Ա���') ;
}
?>

