<?php 
//ϵͳ
require_once './../PHP2/ImageWaterMark/Include/ASP.php';
require_once './../PHP2/ImageWaterMark/Include/sys_FSO.php';
require_once './../PHP2/ImageWaterMark/Include/Conn.php';
require_once './../PHP2/ImageWaterMark/Include/MySqlClass.php'; 

require_once './../PHP2/Web/Inc/Common.php'; 

require_once './config.php'; 
require_once './setAccess.php';
require_once './function.php';

?><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ģ���ļ�����</title>
</head>
<body>
<style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
}
a:link,a:visited,a:active {
    color: #000000;
    text-decoration: none;
}
a:hover {
    color: #666666;
    text-decoration: none;
}
.tableline{
    border: 1px solid #999999;
}
body,td,th {
    font-size: 12px;
}
a {
    font-size: 12px;
}
-->
</style>
<script language="javascript">
function checkDel()
    {
    if(confirm("ȷ��Ҫɾ����ɾ���󽫲��ɻָ���"))
    return true;
    else
    return false;
}
</script>
<?PHP

if( @$_SESSION['adminusername']== '' ){
    eerr('��ʾ', 'δ��¼�����ȵ�¼') ;
}


switch ( @$_REQUEST['act'] ){
    case 'templateFileList' ; folderSearch(@$_REQUEST['dir']) ; templateFileList(@$_REQUEST['dir']);break;//ģ���б�
    case 'delTemplateFile' ; delTemplateFile(@$_REQUEST['dir'], @$_REQUEST['fileName']) ; folderSearch(@$_REQUEST['dir']) ; templateFileList(@$_REQUEST['dir']);break;
    case 'addEditFile' ; folderSearch(@$_REQUEST['dir']) ; addEditFile(@$_REQUEST['dir'], @$_REQUEST['fileName']);break;//��ʾ����޸��ļ�
    default ; folderSearch(@$_REQUEST['dir']) ;//Ĭ��
}

//ģ���ļ��б�
function templateFileList($dir){
    $content=''; $splStr=''; $fileName=''; $s ='';
    if( @$_SESSION['adminusername']== 'ASPPHPCMS' ){
        $content= getDirFileNameList($dir,'');
    }else{
        $content= getDirHtmlNameList($dir);
    }
    $splStr= aspSplit($content, vbCrlf()) ;
    foreach( $splStr as $fileName){
        if( $fileName<>'' ){
            $s= '<a href="../phpweb.php?templatedir=' . escape($dir) . '&templateName=' . $fileName . '" target=\'_blank\'>Ԥ��</a> ' ;
            ASPEcho($fileName, $s . '| <a href=\'?act=addEditFile&dir=' . $dir . '&fileName=' . $fileName . '\'>�޸�</a> | <a href=\'?act=delTemplateFile&dir=' . @$_REQUEST['dir'] . '&fileName=' . $fileName . '\' onclick=\'return checkDel()\'>ɾ��</a>') ;
        }
    }
}

//ɾ��ģ���ļ�
function delTemplateFile($dir, $fileName){
    $filePath ='';

    handlePower('ɾ��ģ���ļ�')						;//����Ȩ�޴���

    $filePath= $dir . '/' . $fileName ;
    deleteFile($filePath) ;
    ASPEcho('ɾ���ļ�', $filePath) ;
}


//����޸��ļ�
function addEditFile($dir, $fileName){
    $filePath ='';

    if( substr(LCase($fileName), - 5) <> '.html' && @$_SESSION['adminusername'] <> 'ASPPHPCMS' ){
        $fileName= $fileName . '.html' ;
    }
    $filePath= $dir . '/' . $fileName;

    if( checkFile($filePath)==false ){
        handlePower('���ģ���ļ�')						;//����Ȩ�޴���
    }else{
        handlePower('�޸�ģ���ļ�')						;//����Ȩ�޴���
    }

    //��������
    if( @$_REQUEST['issave']== 'true' ){
        createfile($filePath, @$_REQUEST['content']) ;
    }
    ?>
    <form name="form1" method="post" action="?act=addEditFile&issave=true">
    <table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline">
    <tr>
    <td height="30">Ŀ¼<?=$dir?><br>
    <input name="dir" type="hidden" id="dir" value="<?=$dir?>" /></td>
    </tr>
    <tr>
    <td>�ļ�����
    <input name="fileName" type="text" id="fileName" value="<?=$fileName?>" size="40">
    <br>
    <textarea name="content" cols="110" rows="25" id="content"><? rw(getFText($filePath))?></textarea></td>
    </tr>
    <tr>
    <td height="40" align="center"><input type="submit" name="button" id="button" value=" ���� " /></td>
    </tr>
    </table>
    </form>
    <?PHP }
    //�ļ�������
    function folderSearch($dir){
        ?>
        <form name="form2" method="post" action="?act=templateFileList">
        <table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline">
        <tr>
        <td height="30"><input name="dir" type="text" id="dir" value="<?=$dir?>" size="60" />
        <input type="submit" name="button2" id="button2" value=" ���� " /></td>
        </tr>
        </table>
        </form>
        <? }?>


