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
<?php

// ��ȡ�û���ʵIP
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

// ���ͻ���ϵͳ�������͵ĺ��� ������
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
