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



Sub FormSubmit()
	Dim b,c,d,e,f,g,h
	Call OpenConn()
	c=Split(Request.Form(),"&")
	b = Rf("TableName")
	h = Trim(Rf("YZM"))
	
	If h<>"" Then
		If Session("YZM") <>h Then
			Call Javascript("返回", "验证码不正确", "")
			Response.End()
		End If
	End If
	
	g = LCase(GetFieldList(b))
	
	
	Rs.Open"Select * From ["& b &"]",Conn,1,3
	Rs.AddNew
		For Each d In c
			e = LCase(Mid(d,1,InStr(d,"=")-1))
			
			f = Rf(e)
			If InStr(","& g &",", ","& e &",")>0 Then
				Rs(e)=f
			End If
			
		Next
	Rs.Update:Rs.Close

	
	
	Call Javascript("返回", "提交"& Rf("DialogTitle") &"成功", "")
End Sub

%>









