<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-17
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#Include File = "../Inc/Config.Asp"-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>模板文件管理</title>
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
    if(confirm("确认要删除吗？删除后将不可恢复！"))
    return true;
    else
    return false;
}
</script>
<%

If Session("adminusername") = "" Then
    Call eerr("提示", "未登录，请先登录")
End If


Select Case Request("act")
    Case "templateFileList" : folderSearch(Request("dir")) : templateFileList(Request("dir"))
    Case "delTemplateFile" : Call delTemplateFile(Request("dir"), Request("fileName")) : folderSearch(Request("dir")) : templateFileList(Request("dir"))
    Case "addEditFile" : folderSearch(Request("dir")) : Call addEditFile(Request("dir"), Request("fileName"))
    Case Else : folderSearch(Request("dir"))
End Select


Sub templateFileList(a)
    Dim b, c, d, e
    b = getDirHtmlListName(a)
    c = Split(b, vbCrLf)
    For Each d In c
		if d<>"" then
			e = "<a href=""../index.asp?templatedir=" & escape(a) & "&templateName=" & d & """ target='_blank'>预览</a> "
			Call echo(d, e & "| <a href='?act=addEditFile&dir=" & a & "&fileName=" & d & "'>修改</a> | <a href='?act=delTemplateFile&dir=" & Request("dir") & "&fileName=" & d & "' onclick='return checkDel()'>删除</a>")
		end if
    Next
End Sub


Sub delTemplateFile(a, b)
    Dim c
    c = a & "/" & b
    Call deleteFile(c)
    Call echo("删除文件", c)
End Sub



Function addEditFile(a, b)
    Dim c
    If Right(LCase(b), 5) <> ".html" Then
        b = b & ".html"
    End If
    c = a & "/" & b

    If Request("issave") = "true" Then
        Call createfile(c, Request("content"))
    End If
%>
<form name="form1" method="post" action="?act=addEditFile&issave=true">
  <table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline">
    <tr>
      <td height="30">目录<% =a%><br>
      <input name="dir" type="hidden" id="dir" value="<% =a%>" /></td>
    </tr>
    <tr>
      <td>文件名称
      <input name="fileName" type="text" id="fileName" value="<% =b%>" size="40">
      <br>
      <textarea name="Content" cols="110" rows="25" id="Content"><%call rw(getFText(c))%></textarea></td>
    </tr>
    <tr>
      <td height="40" align="center"><input type="submit" name="button" id="button" value=" 保存 " /></td>
    </tr>
  </table>
</form>
<% End Function

Function folderSearch(a)
%>
<form name="form2" method="post" action="?act=templateFileList">
  <table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline">
    <tr>
      <td height="30"><input name="dir" type="text" id="dir" value="<% =a%>" size="60" />
        <input type="submit" name="button2" id="button2" value=" 进入 " /></td>
    </tr>
  </table>
</form>
<% End Function%>


