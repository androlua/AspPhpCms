<?PHP
//新网站函数

//特殊字符替换
function specialStrReplace( $content){
    $content= Replace($content, '\\|', '[$特殊字符A]$');
    $content= Replace($content, '\\-', '[$特殊字符B]$');
    $content= Replace($content, '\\,', '[$特殊字符C]$');
    $content= Replace($content, '\\\'', '[$特殊字符D]$');
    $content= Replace($content, '\\"', '[$特殊字符E]$');
    $specialStrReplace= $content;
    return @$specialStrReplace;
}
//解特殊字符替换
function unSpecialStrReplace( $content, $startStr){
    $content= Replace($content, '[$特殊字符A]$', $startStr . '|');
    $content= Replace($content, '[$特殊字符B]$', $startStr . '-');
    $content= Replace($content, '[$特殊字符C]$', $startStr . ',');
    $content= Replace($content, '[$特殊字符D]$', $startStr . '\'');
    $content= Replace($content, '[$特殊字符E]$', $startStr . '"');
    $unSpecialStrReplace= $content;
    return @$unSpecialStrReplace;
}

//栏目类型处理 首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单
function handleColumnType($columnName){
    $s ='';
    switch ( $columnName ){
        case '首页' ; $s= 'home';break;
        case '文本' ; $s= 'text';break;
        case '产品' ; $s= 'product';break;
        case '新闻' ; $s= 'news';break;
        case '视频' ; $s= 'video';break;
        case '下载' ; $s= 'download';break;
        case '案例' ; $s= 'case';break;
        case '留言' ; $s= 'message';break;
        case '反馈' ; $s= 'feedback';break;
        case '招聘' ; $s= 'job';break;
        case '订单' ; $s= 'order';
    }
    $handleColumnType= $s;
    return @$handleColumnType;
}

?>