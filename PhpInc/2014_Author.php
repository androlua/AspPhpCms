<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//关于作者信息
function aboutAuthor(){
    $c ='';
    $c = $c . '<pre>' . vbCrlf() ;
    $c = $c . '作者：小孙' . vbCrlf() ;
    $c = $c . '联系方式' . vbCrlf() ;
    $c = $c . 'QQ：313801120' . vbCrlf() ;
    $c = $c . '邮箱：313801120@qq.com' . vbCrlf() ;
    $c = $c . '微信：mq313801120' . vbCrlf() ;
    $c = $c . '交流群35915100(群里已有几百人)' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '业务及特长' . vbCrlf() ;
    $c = $c . '精通ASP,VB程序开发，独立开发出一套ASP网站后台和VB辅助软件。' . vbCrlf() ;
    $c = $c . '熟练掌握HTML、DIV、CSS、JS' . vbCrlf() ;
    $c = $c . '熟练使用Dreamweaver、Fireworks、 Flash、Photoshop等软件' . vbCrlf() ;
    $c = $c . '自觉PHP、Android等编程语言' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '自我评价' . vbCrlf() ;
    $c = $c . '自学能力强、新知识接受快、勇于面对困难，敢于挑战。' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '工作经历' . vbCrlf() ;
    $c = $c . '2007年1月 至 2012年1月 上海子映网络' . vbCrlf() ;
    $c = $c . '工作内容：网站开发' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '2013---2014，南京麦思德餐饮有限公司' . vbCrlf() ;
    $c = $c . '工作内容：网站开发' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '2014---至今，微战略网络有限公司' . vbCrlf() ;
    $c = $c . '工作内容：网站整站开发，自己用VB开发出一款网站制作辅助软件。' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '' . vbCrlf() ;
    $c = $c . '网站案例：' . vbCrlf() ;
    $c = $c . 'http://www.863health.com/' . vbCrlf() ;
    $c = $c . 'http://www.wzl99.com/' . vbCrlf() ;
    $c = $c . 'http://www.jfh6666.com/' . vbCrlf() ;

    $c = $c . '</pre>' . vbCrlf() ;
    echo($c) ; die() ;
}

//作者信息
function authorInfo($FileInfo){
    $authorInfo = handleAuthorInfo($fileInfo,'asp');
    return @$authorInfo;
}
//处理作者信息
function handleAuthorInfo($fileInfo,$sType){
    $c='';$phpS='';$aspS='';
    if( $sType=='php' ){
        $phpS='/';
    }else{
        $aspS='\'';
    }
    $c = $aspS . $phpS . '************************************************************' . vbCrlf() ;
    if( $FileInfo <> '' ){ $c = $c . $aspS . '  文件：' . $FileInfo . vbCrlf() ;}
    $c = $c . $aspS .'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)' . vbCrlf();
    $c = $c . $aspS .'版权：源代码公开，各种用途均可免费使用。 ' . vbCrlf();
    $c = $c . $aspS .'创建：' . Format_Time(Now(), 2) . vbCrlf() ;
    $c = $c . $aspS .'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com' . vbCrlf();
    $c = $c . $aspS .'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得' . vbCrlf();
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
    $c = $c . '   |    让我们一起来体验       |' . vbCrlf() ;
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