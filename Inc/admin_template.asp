<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-29
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<!--#Include File = "../Inc/Config.Asp"--> 
<!--#Include File = "function.asp"--> 
<!DOCTYPE html> 
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
<% 

If Session("adminusername") = "" Then
    Call eerr("��ʾ", "δ��¼�����ȵ�¼") 
End If 


Select Case Request("act")
    Case "templateFileList" : folderSearch(Request("dir")) : templateFileList(Request("dir"))'ģ���б�
    Case "delTemplateFile" : Call delTemplateFile(Request("dir"), Request("fileName")) : folderSearch(Request("dir")) : templateFileList(Request("dir"))
    Case "addEditFile" : folderSearch(Request("dir")) : Call addEditFile(Request("dir"), Request("fileName"))'��ʾ����޸��ļ�
    Case Else : folderSearch(Request("dir"))                                        'Ĭ��
End Select

'ģ���ļ��б�
Sub templateFileList(dir)
    Dim content, splStr, fileName, s 
    content = getDirHtmlListName(dir) 
    splStr = Split(content, vbCrLf) 
    For Each fileName In splStr
		if fileName<>"" then
			s = "<a href=""../index.asp?templatedir=" & escape(dir) & "&templateName=" & fileName & """ target='_blank'>Ԥ��</a> " 
			Call echo(fileName, s & "| <a href='?act=addEditFile&dir=" & dir & "&fileName=" & fileName & "'>�޸�</a> | <a href='?act=delTemplateFile&dir=" & Request("dir") & "&fileName=" & fileName & "' onclick='return checkDel()'>ɾ��</a>") 
		end if
    Next 
End Sub
 
'ɾ��ģ���ļ�
Sub delTemplateFile(dir, fileName)
    Dim filePath 
	
	call handlePower("ɾ��ģ���ļ�")						'����Ȩ�޴���
	
    filePath = dir & "/" & fileName 
    Call deleteFile(filePath) 
    Call echo("ɾ���ļ�", filePath) 
End Sub
 

'����޸��ļ�
Function addEditFile(dir, fileName)
    Dim filePath 
    If Right(LCase(fileName), 5) <> ".html" Then
        fileName = fileName & ".html" 
    End If 
    filePath = dir & "/" & fileName
	
	if checkFile(filePath)=false then
		call handlePower("���ģ���ļ�")						'����Ȩ�޴���
	else
		call handlePower("�޸�ģ���ļ�")						'����Ȩ�޴���	
	end if
	 
    '��������
    If Request("issave") = "true" Then
        Call createfile(filePath, Request("content")) 
    End If 
%> 
<form name="form1" method="post" action="?act=addEditFile&issave=true"> 
  <table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline"> 
    <tr> 
      <td height="30">Ŀ¼<% =dir%><br> 
      <input name="dir" type="hidden" id="dir" value="<% =dir%>" /></td> 
    </tr> 
    <tr> 
      <td>�ļ����� 
      <input name="fileName" type="text" id="fileName" value="<% =fileName%>" size="40"> 
      <br> 
      <textarea name="Content" cols="110" rows="25" id="Content"><%call rw(getFText(filePath))%></textarea></td> 
    </tr> 
    <tr> 
      <td height="40" align="center"><input type="submit" name="button" id="button" value=" ���� " /></td> 
    </tr> 
  </table> 
</form>
<% End Function
'�ļ�������
Function folderSearch(dir)
%> 
<form name="form2" method="post" action="?act=templateFileList"> 
  <table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline"> 
    <tr> 
      <td height="30"><input name="dir" type="text" id="dir" value="<% =dir%>" size="60" /> 
        <input type="submit" name="button2" id="button2" value=" ���� " /></td> 
    </tr> 
  </table> 
</form> 
<% End Function%>
