<?php 


define('WEBCOLUMNTYPE','��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����'); 		//��վ��Ŀ�����б�
define('EDITORTYPE','php'); 		//�༭�����ͣ���ASP,��PHP,��jSP,��.NET
define('WEB_VIEWURL','../index.php'); 		//��վ��ʾURL
define('WEB_ADMINURL','/admin/index.php'); 		//�����վ�����߱༭�õ�20160216
//=========

$ReadBlockList='';

$SysStyle=array(9);
$SysStyle[0] = '#999999';
$makeHtmlFileToLCase	 =''; $makeHtmlFileToLCase=true		;//����HTML�ļ�תСд
$isWebLabelClose =''; $isWebLabelClose=true					;//�պϱ�ǩ(20150831)

$HandleisCache =''; $HandleisCache=false						;//�����Ƿ�����
$db_PREFIX =''; $db_PREFIX = 'xy_' 		 ;//��ǰ׺
$adminDir ='';$adminDir='/admin/'							;//��̨Ŀ¼


$openErrorLog =''; $openErrorLog = true ;//����������־
$openWriteSystemLog =''; $openWriteSystemLog = '|txt|database|' ;//����дϵͳ��־ txtд���ı� databaseд�����ݿ�
$openTestEcho=''; $openTestEcho=true											;//���ز��Ի���
$webVersion =''; $webVersion='ASPPHPCMS V1.01'												;//��վ�汾


$WEB_CACHEFile =''; $WEB_CACHEFile='/admin/'. EDITORTYPE .'cachedata.txt'								;//�����ļ�
$WEB_CACHEContent =''; $WEB_CACHEContent=''								;//�����ļ�����



?>