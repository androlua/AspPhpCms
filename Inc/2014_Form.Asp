<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'Form

'表单提交
Sub FormSubmit()
	Dim TableName,SplStr,S,FieldName,FieldContent,FieldList,YZM
	Call OpenConn()
	SplStr=Split(Request.Form(),"&")
	TableName = Rf("TableName")
	YZM = Trim(Rf("YZM"))
	
	If YZM<>"" Then
		If Session("YZM") <>YZM Then
			Call Javascript("返回", "验证码不正确", "")
			Response.End()
		End If
	End If
	
	FieldList = LCase(GetFieldList(TableName))
	'Call Echo("FieldList",FieldList)
	'Call Echo("TableName", TableName)
	Rs.Open"Select * From ["& TableName &"]",Conn,1,3
	Rs.AddNew
		For Each S In SplStr
			FieldName = LCase(Mid(S,1,InStr(S,"=")-1))
			'FieldContent = Mid(S,InStr(S,"=")+1) 
			FieldContent = Rf(FieldName)
			If InStr(","& FieldList &",", ","& FieldName &",")>0 Then
				Rs(FieldName)=FieldContent
			End If
			'Call Echo(FieldName,FieldContent & "," & unescape(FieldContent))
		Next
	Rs.Update:Rs.Close
'	Call Echo("DialogTitle",Rf("DialogTitle"))
	'Call Die("留言内容")
	
	Call Javascript("返回", "提交"& Rf("DialogTitle") &"成功", "")
End Sub

'获得POST字段名称列表 20160226
function getFormFieldName()
	dim s,c,splstr,fieldName
	splstr=split(Request.Form,"&")
	for each s in splstr
		fieldName = LCase(Mid(s, 1, InStr(s, "=") - 1)) 
		if c<>"" then c=c & "|"
		c=c & fieldName
	next
	getFormFieldName=c
end function
 
%>







