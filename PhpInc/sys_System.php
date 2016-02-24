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
<?php

// 获取用户真实IP
function getIP() {
	if (getenv ( "HTTP_CLIENT_IP" ) && strcasecmp ( getenv ( "HTTP_CLIENT_IP" ), "unknown" ))
		$ip = getenv ( "HTTP_CLIENT_IP" );
	else if (getenv ( "HTTP_X_FORWARDED_FOR" ) && strcasecmp ( getenv ( "HTTP_X_FORWARDED_FOR" ), "unknown" ))
		$ip = getenv ( "HTTP_X_FORWARDED_FOR" );
	else if (getenv ( "REMOTE_ADDR" ) && strcasecmp ( getenv ( "REMOTE_ADDR" ), "unknown" ))
		$ip = getenv ( "REMOTE_ADDR" );
	else if (isset ( $_SERVER ['REMOTE_ADDR'] ) && $_SERVER ['REMOTE_ADDR'] && strcasecmp ( $_SERVER ['REMOTE_ADDR'], "unknown" ))
		$ip = $_SERVER ['REMOTE_ADDR'];
	else
		$ip = "unknown";
	return ($ip);
}

// 检测客户端系统操作类型的函数 待测试
function sysinfo($agent) {
	$sys = "";
	if (stristr ( 'win', $agent ) && stristr ( 'nt 5\.1', $agent )) {
		$sys = "Windows XP";
	} elseif (stristr ( 'win', $agent ) && strstr ( '98', $agent )) {
		$sys = "Windows 98";
	} elseif (stristr ( 'win', $agent ) && stristr ( 'nt 5\.0', $agent )) {
		$sys = "Windows 2000";
	} elseif (stristr ( 'win 9x', $agent ) && strpos ( $agent, '4.90' )) {
		$sys = "Windows ME";
	} elseif (stristr ( 'win', $agent ) && strpos ( $agent, '95' )) {
		$sys = "Windows 95";
	} elseif (stristr ( 'win', $agent ) && stristr ( 'nt', $agent )) {
		$sys = "Windows NT";
	} elseif (stristr ( 'win', $agent ) && strstr ( '32', $agent )) {
		$sys = "Windows 32";
	} elseif (stristr ( 'linux', $agent )) {
		$sys = "Linux";
	} elseif (stristr ( 'unix', $agent )) {
		$sys = "Unix";
	} elseif (stristr ( 'ibm', $agent ) && stristr ( 'os', $agent )) {
		$sys = "IBM OS/2";
	} elseif (stristr ( 'NetBSD', $agent )) {
		$sys = "NetBSD";
	} elseif (stristr ( 'BSD', $agent )) {
		$sys = "BSD";
	} elseif (stristr ( 'FreeBSD', $agent )) {
		$sys = "FreeBSD";
	} else
		$sys = "Unknown";
	return $sys;
}
