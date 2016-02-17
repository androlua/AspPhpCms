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
<!--#Include File = "Config.Asp"-->
<%

Select Case Request("act")
	Case "SaveFile" : SaveFile( Request("FilePath"))			
	Case "GetFunctionCode" : GetFunctionCode(Request("Lable"))	
	Case "SaveQQDialogue" : Call SaveQQDialogue()				
	Case "UserLogin" : Call UserLogin()						 	
	Case "UserReg" : Call UserReg()								
	Case "MobileArticleList" : Call MobileArticleList()			
	Case "ShowArticleNumb" : Call ShowArticleNumb()				
	Case "SaveAJAXEdit" : Call SaveAJAXEdit()					
	Case "SaveAJAXTEXTEdit" : Call SaveAJAXTEXTEdit()					
	
	Case "DeleteAction" : Call DeleteAction()					
	
	Case "showArticleList" : Call showArticleList()					
End Select


function showArticleList()
	call openconn()
	dim b,c,d,e
	b=Rq("did")
	e=HandleNumber(Rq("Numb")) 	
	if e<>"" then
		c = "select top "& e &" * from [product]"
	else	
		c = "select * from [product]"
	end if
	if b<>"" then
		c=c & " where BigClassName='"& b &"'"
	end if
	rs.open c,conn,1,1
	Dim f : Set f = New Cls_AB_JSON
	
	call rw(f.toJSON(rs))
	
	rs.close
end function

function showArticleList2()
	call openconn()
	dim b,c,d,e
	b=Rq("did")
	e=HandleNumber(Rq("Numb")) 	
	if e<>"" then
		c = "select top "& e &" * from [product]"
	else	
		c = "select * from [product]"
	end if
	if b<>"" then
		c=c & " where BigClassName='"& b &"'"
	end if
	rs.open c,conn,1,1
	Dim f : Set f = New Cls_AB_JSON
	
	call rw(f.toJSON(rs))
	rs.close
end function


Function DeleteAction()
	Dim C	
	C=C & "MDBPath=" & Rq("MDBPath") & vbCrlf
	C=C & "TableName=" & Rq("TableName") & vbCrlf
	C=C & "FieldName=" & Rq("FieldName") & vbCrlf
	C=C & "ID=" & Rq("ID") & vbCrlf
	
	MdbPath=Request("MDBPath")
	Call OpenConn()
	Dim c
	c = "Select * From ["& Request("TableName") &"] Where Id=" & Request("Id")
	
	Rs.Open c,Conn,1,3
	If Not Rs.Eof Then
		Rs.Delete
		Rs.Update
		Call Rw("删除ID【"& Request("Id") &"】成功")
	Else		
		Call Rw("ID【"& Request("Id") &"】不存在，删除失败")
	End If:Rs.Close
End Function

Function SaveAJAXEdit()
	Dim b
	
	b=b & "MDBPath=" & Rq("MDBPath") & "("& IsNul(Rq("MDBPath")) &")" & vbCrlf
	b=b & "MDBPath=" & HandlePath(Rq("MDBPath")) & vbCrlf
	b=b & "TableName=" & Rq("TableName") & vbCrlf
	b=b & "FieldName=" & Rq("FieldName") & vbCrlf
	b=b & "Content=" & Rq("Content") & vbCrlf
	b=b & "ID=" & Rq("ID") & vbCrlf
	Call Rw("<pre>"& b &"</pre>"):Doevents
	
	Call OpenConn()
	Dim c
	c = "Select * From ["& Request("TableName") &"] Where Id=" & Request("Id")
	
	Rs.Open c,Conn,1,3
	If Not Rs.Eof Then
		Rs(Rq("FieldName")) = Request("Content")
		Rs.Update
	End If:Rs.Close
End Function

Function SaveAJAXTEXTEdit()
	Dim C	
	C=C & "FilePath=" & Rq("FilePath") & vbCrlf
	
	
	C=C & "content=" & Request.Form("content") & vbCrlf
	C=C & "count=" & Request.Form("count") & vbCrlf
	Call Rw("<pre>"& C &"</pre>"):Doevents
	Call CreateFile(Request("FilePath"),Request("content"))
End Function


Sub ShowArticleNumb()
	Dim b
	b = Request("Id")
	Call OpenConn()
	Rs.Open"Select * From [Product] Where Id=" & b,Conn,1,3
	If Not Rs.Eof Then
		Rs("Hits") = Rs("Hits")+1
		Rs.Update
		Call Rw(Rs("Hits"))
	End If:Rs.Close
End Sub


Sub MobileArticleList()
	
	Dim b,c,d,e
	Call OpenConn()
	If Session("ShowMobileArticleNumb") = "" Then Session("ShowMobileArticleNumb")=12
	d = 0
    b=b & "<?xml version=""1.0"" encoding=""gb2312"" ?> " & vbCrlf
    b=b & "<clists> " & vbCrlf
	c = "Select * From [Product] Where BigClassName='信息中心' Order By Id Desc"
	Rs.Open c,Conn,1,1
	For e =1 To Rs.RecordCount
		If d>10 Then Exit For
		If e > Session("ShowMobileArticleNumb") then
			d=d+1
		    b=b & "<clist id="""& Rs("ID") &""" title="""& Rs("Title") &""" image=""0"" time="""& Rs("AddDateTime") &"""/>" & vbCrlf
		End If
	Rs.MoveNext:Next:Rs.Close
	Session("ShowMobileArticleNumb")=Session("ShowMobileArticleNumb")+d
    b=b & "</clists>" & vbCrlf
	Call Rw(b)
End Sub

Sub UserReg()
	Dim b,c,d
	b=Replace(Request("UserName"),"'","")
	c=Replace(Request("PassWord"),"'","")
	If Request("P")="" Then
		c = MD5(c,2) & MD5(c,4)
	End If
	d=Replace(Request("Email"),"'","")	
	Response.Cookies("UserName")=b
	Response.Cookies("UserName").Expires=Date+10	
	Call OpenConn()
	Rs.Open"Select * From [Member] Where UserName='"& b &"'",Conn,1,3
	If Not Rs.Eof Then
		Call Rw("用户名已被注册")
	Else
		Rs.Close
		Rs.Open"Select * From [Member] Where Email='"& d &"'",Conn,1,3
		If Not Rs.Eof Then
			Call Rw("邮箱已被注册")
		Else
			Rs.AddNew
			Rs("UserName")=b
			Rs("Pwd")=c
			Rs("Email")=d
			Rs("MyMoney") = 100000
			Rs.Update
			Response.Cookies("PassWord")=c
			Response.Cookies("PassWord").Expires=date+10
			Session("Email")=Rs("Email")
			Session("MyMoney")=CLng(Rs("MyMoney"))
			Call Rw("OK")
		End If
		Response.End()
	End If:Rs.Close
End Sub

Sub UserLogin()
	Dim b,c,d
	b=Replace(Request("UserName"),"'","")
	c=Replace(Request("PassWord"),"'","")
	If Request("P")="" Then
		c = MD5(c,2) & MD5(c,4)
	End If
	d=Replace(Request("autologin"),"'","")
	
	Response.Cookies("UserName")=b
	Response.Cookies("UserName").Expires=date+10
	
	Call OpenConn()

	Rs.Open"Select * From [Member] Where UserName='"& b &"' Or Email='"& b &"'",Conn,1,3
	If Rs.Eof Then
		Call Rw("用户名不存在")
	Else
		If Rs("Pwd")<>c Then
			Call Rw("密码不正确")
		Else
			Response.Cookies("PassWord")=c
			Response.Cookies("PassWord").Expires=date+10
			Session("Email")=Rs("Email")
			Session("MyMoney")=CLng(Rs("MyMoney"))
			Call Rw("OK")
		End If
	End If:Rs.Close
End Sub


Sub SaveQQDialogue()
	Dim b,c
	b = Request("QQ")
	c = Request("ClickStyle")
	Call CreateAddFile("/QQ/QQ.txt","聊天QQ=" & b & "，样式=" & c & "，时间=" & Format_Time(Now(),8))
	Call Rw("保存QQ对话成功")
End Sub


Sub GetFunctionCode(a)
	Dim b
	b = GetFText("FSO.Asp")
	b = StrCut(b,"Function " & a,"End Function",1)
	
	Call Rw(ShowAspCodeColor(b))
End Sub
%>

