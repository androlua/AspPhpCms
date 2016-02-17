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





Function MsgBox(ByVal a)
	a=Replace(Replace(a,Chr(10),"\n"),Chr(13),"\n")
	Response.Write("<script>alert('"& a &"');</script>")
End Function

function MBInfo(a,b)
	MBInfo=MsgBox(a)
end function

Sub AddRq(a,b)
	Response.QueryString(a) = b
End Sub

Function Rc(a)
	Rc = Request.Cookies(a)
End Function

Sub AddRc(a,b,c)
	Response.Cookies(a) = b
	If c<>"" Then Response.Cookies(a).Expires = c
End Sub

Sub Rr(a)
	Response.Redirect(a)
End Sub				

Function Rf(a)
    Rf = Request.Form(a)
End Function
Function ADSqlRf(a)
	ADSqlRf= replace(request.Form(a),"'","''")
End Function

Function Rq(a)
    Rq = Request.QueryString(a)
End Function

Function Rfq(a)
    Rfq = Request(a)
End Function

Function Rw(a)
    Response.Write(a)
End Function

Function RwBr(a)
    Response.Write(a & vbCrlf)
End Function

Function RwEnd(a)
    Response.Write(a)
	Response.End()
End Function

Function HtmEnd(a)
	Call  RwEnd(a)
End Function

Function Die(a)
    Response.Write(a)
	Response.End()
End Function

Function Debug(a)
    Response.Write("<div  style=""border:solid 1px #000000;margin-bottom:2px;"">调试" & a & "</div>" & vbCrlf)
End Function

Function Trace(a)
	Trace = Debug(a)
End Function

Function Echo(a, b)
    Call echoPrompt(a, b)
End Function

Function EchoRed(a, b)
    Response.Write("<font color=Red>" & a & "</font>：" & b & "<br>")
End Function

Function EchoRedB(a, b)
    Response.Write("<b><font color=Red>" & a & "</font>：" & b & "</b><br>")
End Function

Function echoPrompt(a, b)
	Response.Write("<font color=Green>" & a & "</font>：" & b & "<br>")
End Function

Function echoStr(a, b)
	Call echoPrompt(a, b)
End Function

Function Print_R(a)
	Dim b,c
	If TypeName(a) = "Variant()" Then
		For b=0 To Ubound(a)
			c = c & "["& b &"] => " & a(b) & vbCrlf
		Next
	Else
		c = a
	End If
	Response.Write(c)
End Function

Function SetColorEcho(a, b, c)
    Response.Write("<font color="& a &">" & b & "</font>：" & c & "<br>")
End Function

Function Eerr(a, b)

    Response.Write("<font color=red>" & a & "</font>：" & b)
	Response.End()
End Function

Sub DoEvents()
    Response.Flush()
End Sub

Function IIf(a, b, c)
    If(a) Then IIf = b Else IIf = c
End Function

Function HR()
    Response.Write("<hr size='1' color='#666666'> ")
End Function




Public Sub Print(ByVal a)
	Response.Write(a & VbCrLf) : Response.Flush()
End Sub

Public Sub Println(ByVal a)
	Response.Write(a & "<br />" & VbCrLf) : Response.Flush()
End Sub

Public Sub PrintHtml(ByVal a)
	Response.Write(HtmlEncode(a) & VbCrLf)
End Sub
Public Sub PrintlnHtml(ByVal a)
	Response.Write(HtmlEncode(a) & "<br />") & VbCrLf
End Sub







Public Sub PrintEnd(ByVal a)
	Response.Write(a) :  Response.End()
End Sub





Function IsChecked(ByVal a, ByVal b)
    If a = b Then IsChecked = "checked='checked'" Else IsChecked = ""
End Function

Function IsSelected(ByVal a, ByVal b)
    If a = b Then IsSelected = "selected='selected'" Else IsSelected = ""
End Function


Sub DoError(a, b)

    Dim c, d
    Randomize
    c = CLng(Rnd() * 29252888)
    d = "<br />"
    d = d & "<div style=""width:100%; font-size:12px;;line-height:150%"">"
    d = d & "  <label onClick=""ERRORDIV" & c & ".style.display=(ERRORDIV" & c & ".style.display=='none'?'':'none')"">"
    d = d & "  <span style=""background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">〖 出错 提示信息 ERROR 〗</span><br />"
    d = d & "  </label>"
    d = d & "  <div id=""ERRORDIV" & c & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;"">"
    d = d & " <span style=""color:#FF0000;"">出错描述</span> " & a & "<br />"
    d = d & " <span style=""color:#FF0000;"">回显信息</span> " & b & "<br />"
    d = d & "  </div>"
    d = d & "</div>"
    d = d & "<br />"
    Response.Write(d)
    Response.End()
End Sub


Function Exec(Byval a)
	IF a="" Then Exit Function: End If
	On Error Resume Next
	Execute(a)
	On Error Goto 0
End Function

%>



