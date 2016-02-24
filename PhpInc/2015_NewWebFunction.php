<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-24
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By 云端 
************************************************************/
?>
<?PHP
//新网站函数

//特殊字符替换
function specialStrReplace( $content){
    $content = Replace($content, '\\|', '[$特殊字符A]$') ;
    $content = Replace($content, '\\-', '[$特殊字符B]$') ;
    $content = Replace($content, '\\,', '[$特殊字符C]$') ;
    $content = Replace($content, '\\\'', '[$特殊字符D]$') ;
    $content = Replace($content, '\\"', '[$特殊字符E]$') ;
    $specialStrReplace = $content ;
    return @$specialStrReplace;
}
//解特殊字符替换
function unSpecialStrReplace( $content, $startStr){
    $content = Replace($content, '[$特殊字符A]$', $startStr . '|') ;
    $content = Replace($content, '[$特殊字符B]$', $startStr . '-') ;
    $content = Replace($content, '[$特殊字符C]$', $startStr . ',') ;
    $content = Replace($content, '[$特殊字符D]$', $startStr . '\'') ;
    $content = Replace($content, '[$特殊字符E]$', $startStr . '"') ;
    $unSpecialStrReplace = $content ;
    return @$unSpecialStrReplace;
}

//栏目类型处理 首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单
function handleColumnType($columnName){
    $s ='';
    switch ( $columnName ){
        case '首页' ; $s = 'home';break;
        case '文本' ; $s = 'text';break;
        case '产品' ; $s = 'product';break;
        case '新闻' ; $s = 'news';break;
        case '视频' ; $s = 'video';break;
        case '下载' ; $s = 'download';break;
        case '案例' ; $s = 'case';break;
        case '留言' ; $s = 'message';break;
        case '反馈' ; $s = 'feedback';break;
        case '招聘' ; $s = 'job';break;
        case '订单' ; $s = 'order';
    }
    $handleColumnType = $s ;
    return @$handleColumnType;
}

?>

