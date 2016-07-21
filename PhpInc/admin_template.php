<?php 
//ϵͳ
require_once './ASP.php';
require_once './sys_FSO.php';
require_once './Conn.php';
require_once './MySqlClass.php'; 
require_once './sys_Url.php'; 

require_once './Common.php';  

require_once './config.php'; 
require_once './admin_setAccess.php';
require_once './admin_function.php';

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
    Eerr('��ʾ', 'δ��¼�����ȵ�¼');
}

$conn=OpenConn();
switch ( @$_REQUEST['act'] ){
    case 'templateFileList' ; displayTemplateDirDialog(@$_REQUEST['dir']) ; templateFileList(@$_REQUEST['dir']);break;//ģ���б�
    case 'delTemplateFile' ; delTemplateFile(@$_REQUEST['dir'], @$_REQUEST['fileName']) ; displayTemplateDirDialog(@$_REQUEST['dir']) ; templateFileList(@$_REQUEST['dir'])		;break;//ɾ��ģ���ļ�
    case 'addEditFile' ; displayTemplateDirDialog(@$_REQUEST['dir']) ; addEditFile(@$_REQUEST['dir'], @$_REQUEST['fileName']);break;//��ʾ����޸��ļ�
    default ; displayTemplateDirDialog(@$_REQUEST['dir']); //��ʾģ��Ŀ¼���
}

//ģ���ļ��б�
function templateFileList($dir){
    $content=''; $splStr=''; $fileName=''; $s='';$fileType ='';$folderName='';$filePath='';

    if( @$_SESSION['adminusername']== 'ASPPHPCMS' ){
        $content= getDirFolderNameList($dir,'');
        $splStr= aspSplit($content, vbCrlf());
        foreach( $splStr as $key=>$folderName){
            $s='<a href=\'?act=templateFileList&dir='. $dir . '/' . $folderName .'\'>'. $folderName .'</a>';
            aspEcho('<img src=\'../admin/Images/file/folder.gif\'>',$s);
        }
        $content= getDirFileNameList($dir,'');
    }else{
        $content= getDirHtmlNameList($dir);
    }
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$fileName){
        if( $fileName<>'' ){
            $fileType=lCase(getFileAttr($fileName,4));
            $filePath=$dir . '/' . $filename;
            if( inStr('|asa|asp|aspx|bat|bmp|cfm|cmd|com|css|db|default|dll|doc|exe|fla|folder|gif|h|htm|html|inc|ini|jpg|js|jtbc|log|mdb|mid|mp3|php|png|rar|real|rm|swf|txt|wav|xls|xml|zip|','|'. $fileType .'|')==false ){
                $fileType='default';
            }

            $s= '<a href="../index.php?templatedir=' . escape($dir) . '&templateName=' . $fileName . '" target=\'_blank\'>Ԥ��</a> ';
            aspEcho('<img src=\'../admin/Images/file/'. $fileType .'.gif\'>' . $fileName . '��'. printSpaceValue(getFSize($filePath)) .'��', $s . '| <a href=\'?act=addEditFile&dir=' . $dir . '&fileName=' . $fileName . '\'>�޸�</a> | <a href=\'?act=delTemplateFile&dir=' . @$_REQUEST['dir'] . '&fileName=' . $fileName . '\' onclick=\'return checkDel()\'>ɾ��</a>');
        }
    }



}

//ɾ��ģ���ļ�
function delTemplateFile($dir, $fileName){
    $filePath ='';

    handlePower('ɾ��ģ���ļ�');						//����Ȩ�޴���

    $filePath= $dir . '/' . $fileName;
    DeleteFile($filePath);
    aspEcho('ɾ���ļ�', $filePath);
}

//��ʾ�����ʽ�б�
function displayPanelList($dir){
    $content='';$splstr='';$s='';$c='';
    $content=getDirFolderNameList($dir);
    $splstr=aspSplit($content,vbCrlf());
    $c='<select name=\'selectLeftStyle\'>';
    foreach( $splstr as $key=>$s){
        $s='<option value=\'\'>'. $s .'</option>';
        $c=$c . $s . vbCrlf();
    }
    $displayPanelList= $c . '</select>';
    return @$displayPanelList;
}


//����޸��ļ�
function addEditFile($dir, $fileName){
    $filePath='';$promptMsg='';

    if( right(lCase($fileName), 5) <> '.html' && @$_SESSION['adminusername'] <> 'ASPPHPCMS' ){
        $fileName= $fileName . '.html';
    }
    $filePath= $dir . '/' . $fileName;

    if( CheckFile($filePath)==false ){
        handlePower('���ģ���ļ�');						//����Ȩ�޴���
    }else{
        handlePower('�޸�ģ���ļ�');						//����Ȩ�޴���
    }

    //��������
    if( @$_REQUEST['issave']== 'true' ){
        createFile($filePath, @$_REQUEST['content']);
        $promptMsg='����ɹ�';
    }
    ?>
    <form name="form1" method="post" action="?act=addEditFile&issave=true">
    <table width="99%" border="0" cellspacing="0" cellpadding="0" class="tableline">
    <tr>
    <td height="30">Ŀ¼<?=$dir?><br>
    <input name="dir" type="hidden" id="dir" value="<?=$dir?>" /></td>
    </tr>
    <tr>
    <td>�ļ�����
    <input name="fileName" type="text" id="fileName" value="<?=$fileName?>" size="40">&nbsp;<input type="submit" name="button" id="button" value=" ���� " /><?=$promptMsg?>
    <br>
    <textarea name="content" style="width:99%;height:480px;"id="content"><?PHP Rw(getFText($filePath))?></textarea></td>
    </tr>
    </table>
    </form>
    <?PHP }
    //�ļ�������
    function displayTemplateDirDialog($dir){
        $folderPath='';
        ?>
        <form name="form2" method="post" action="?act=templateFileList">
        <table width="99%" border="0" cellspacing="0" cellpadding="0" class="tableline">
        <tr>
        <td height="30"><input name="dir" type="text" id="dir" value="<?=$dir?>" size="60" />
        <input type="submit" name="button2" id="button2" value=" ���� " /><?PHP
        $folderPath=$dir . '/images/column/';
        if( CheckFolder($folderPath) ){
            Rw('�����ʽ' . displayPanelList($folderPath));
        }
        $folderPath=$dir . '/images/nav/';
        if( CheckFolder($folderPath) ){
            Rw('������ʽ' . displayPanelList($folderPath));
        }
        ?></td>
        </tr>
        </table>
        </form>
        <?PHP }?>



