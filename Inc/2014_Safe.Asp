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
<%





Function IsSelfRefer()
	Dim b, c
	b = CStr(Request.ServerVariables("HTTP_REFERER"))
	c = CStr(Request.ServerVariables("SERVER_NAME"))
	If Mid(b, 8, Len(c)) = c Then
		IsSelfRefer = True
	Else
		IsSelfRefer = False
	End If
End Function




Function IsSafeStr(a)
	Dim b, c, d
	b = "' 　&<>?%,;:()`~!@#$^*{}[]|+-=" & Chr(34) & Chr(9) & Chr(32)
	c = Len(b)
	IsSafeStr = True
	For d = 1 To c
		If Instr(a, Mid(b, d, 1)) > 0 Then
			IsSafeStr = False
			Exit Function
		End If
	Next
End Function
%>

