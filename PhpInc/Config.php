<?php 


define('WEBCOLUMNTYPE','首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单'); 		//网站栏目类型列表
define('EDITORTYPE','php'); 		//编辑器类型，是ASP,或PHP,或jSP,或.NET
define('WEB_VIEWURL','../index.php'); 		//网站显示URL
define('WEB_ADMINURL','/admin/index.php'); 		//后端网站，在线编辑用到20160216
//=========

$ReadBlockList='';

$SysStyle=array(9);
$SysStyle[0] = '#999999';
$makeHtmlFileToLCase	 =''; $makeHtmlFileToLCase=true		;//生成HTML文件转小写
$isWebLabelClose =''; $isWebLabelClose=true					;//闭合标签(20150831)

$HandleisCache =''; $HandleisCache=false						;//缓冲是否处理了
$db_PREFIX =''; $db_PREFIX = 'xy_' 		 ;//表前缀
$adminDir ='';$adminDir='/admin/'							;//后台目录


$openErrorLog =''; $openErrorLog = true ;//开启错误日志
$openWriteSystemLog =''; $openWriteSystemLog = '|txt|database|' ;//开启写系统日志 txt写入文本 database写入数据库
$openTestEcho=''; $openTestEcho=true											;//开关测试回显
$webVersion =''; $webVersion='ASPPHPCMS V1.01'												;//网站版本


$WEB_CACHEFile =''; $WEB_CACHEFile='/admin/'. EDITORTYPE .'cachedata.txt'								;//缓冲文件
$WEB_CACHEContent =''; $WEB_CACHEContent=''								;//缓冲文件内容



?>