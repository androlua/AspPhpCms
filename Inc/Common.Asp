<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-03-11
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered by ASPPHPCMS 
'************************************************************
%>
<%
'常用函数大全 (2013,9,27Option Explicit)
 
'成功永远都是缓慢的 2013,10,4,悟 

'显示弹窗对话框20150312
Function MsgBox(ByVal Content)
	Content=Replace(Replace(Content,Chr(10),"\n"),Chr(13),"\n")
	Response.Write("<script>alert('"& Content &"');</script>")
End Function
'提示20150729
function MBInfo(title,content)
	MBInfo=MsgBox(title)
end function
'给Queststring赋值
Sub AddRq(GookeName,ValueStr)
	Response.QueryString(GookeName) = ValueStr 
End Sub
'获得Cookies值
Function Rc(GookeName)
	Rc = Request.Cookies(GookeName)
End Function
'给Cookies赋值
Sub AddRc(GookeName,ValueStr,DateStr)
	Response.Cookies(GookeName) = ValueStr 
	If DateStr<>"" Then Response.Cookies(GookeName).Expires = DateStr
End Sub
'ASP自带的跳转
Sub Rr(Url)
	Response.Redirect(Url)
End Sub				
'替换Request.Form对象 
Function Rf(Str)
    Rf = Request.Form(Str) 
End Function 
Function ADSqlRf(inputName)
	ADSqlRf= replace(request.Form(inputName),"'","''") 
End Function
'获得传值
Function Rq(Str)
    Rq = Request.QueryString(Str)
End Function
'获得传值
Function Rfq(Str)
    Rfq = Request(Str)
End Function
'替换Response.Write对象 
Function Rw(Str)
    Response.Write(Str)
End Function
'输出内容加换行
Function RwBr(Str)
    Response.Write(Str & vbCrlf) 
End Function
'替换Response.Write对象 + Response.End()
Function RwEnd(Str)
    Response.Write(Str)
	Response.End()
End Function
'HTML结束
Function HtmEnd(Str)
	Call  RwEnd(Str)
End Function
'替换Response.Write对象+Response.End()
Function Die(Str)
    Response.Write(Str)
	Response.End()
End Function
'替换Response.Write对象 
Function Debug(Str)
    Response.Write("<div  style=""border:solid 1px #000000;margin-bottom:2px;"">调试" & Str & "</div>" & vbCrlf)
End Function
'跟踪 
Function Trace(Str)
	Trace = Debug(Str)
End Function
'测试显示信息 
Function Echo(Word, Str)
    Call echoPrompt(Word, Str)
End Function
'测试显示信息+红色
Function EchoRed(Word, Str)
    Response.Write("<font color=Red>" & Word & "</font>：" & Str & "<br>")
End Function
'测试显示信息+红色+粗
Function EchoRedB(Word, Str)
    Response.Write("<b><font color=Red>" & Word & "</font>：" & Str & "</b><br>")
End Function
'回显内容
Function echoPrompt(Word, Str)
	Response.Write("<font color=Green>" & Word & "</font>：" & Str & "<br>")
End Function
'回显内容
Function echoStr(Word, Str)
	Call echoPrompt(Word, Str)
End Function
'打印数组 打印PHP里用到
Function Print_R(Content)
	Dim I,C
	If TypeName(Content) = "Variant()" Then 
		For I=0 To Ubound(Content)
			C = C & "["& I &"] => " & Content(I) & vbCrlf
		Next
	Else
		C = Content
	End If
	Response.Write(C)
End Function
'测试显示信息 颜色
Function SetColorEcho(Color, Word, Str)
    Response.Write("<font color="& Color &">" & Word & "</font>：" & Str & "<br>")
End Function
'测试显示信息暂停 
Function Eerr(Word, Str)
'	Response.Write(TypeName(Word) & "-" & TypeName(Str)):Response.End()
    Response.Write("<font color=red>" & Word & "</font>：" & Str)
	Response.End() 
End Function 
'立即回显内容 
Sub DoEvents()
    Response.Flush() 
End Sub 
'功能:ASP里的IIF 如：IIf(1 = 2, "a", "b") 
Function IIf(bExp, sVal1, sVal2)
    If(bExp) Then IIf = sVal1 Else IIf = sVal2 
End Function 
'Hr 
Function HR()
    Response.Write("<hr size='1' color='#666666'> ") 
End Function 

'输出字符串 引用别人20141217
'Public Sub Echo(ByVal s) : Response.Write(s) : End Sub
'输出字符串和一个换行符
Public Sub Print(ByVal s)
	Response.Write(s & VbCrLf) : Response.Flush()
End Sub
'输出字符串和一个html换行符
Public Sub Println(ByVal s)
	Response.Write(s & "<br />" & VbCrLf) : Response.Flush()
End Sub
'输出字符串并将HTML标签转为普通字符
Public Sub PrintHtml(ByVal s)
	Response.Write(HtmlEncode(s) & VbCrLf)
End Sub
Public Sub PrintlnHtml(ByVal s)
	Response.Write(HtmlEncode(s) & "<br />") & VbCrLf
End Sub
'将任意变量直接输出为字符串(Json格式)
'Public Sub PrintString(ByVal s) : Response.Write(Str.ToString(s) & VbCrLf) : End Sub
'Public Sub PrintlnString(ByVal s) : Response.Write(Str.ToString(s)) & "<br />" & VbCrLf : End Sub
'输出经过格式化的字符串
'Public Sub PrintFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & VbCrLf : End Sub
'Public Sub PrintlnFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & "<br />" & VbCrLf : End Sub
'输出字符串并终止程序运行
Public Sub PrintEnd(ByVal s)
	Response.Write(s) :  Response.End()
End Sub




'判断是否一样，一样返回checked,否者返回空值 
Function IsChecked(ByVal Str, ByVal Str2)
    If Str = Str2 Then IsChecked = "checked='checked'" Else IsChecked = "" 
End Function 
'判断是否一样，一样返回selected,否者返回空值 
Function IsSelected(ByVal Str, ByVal Str2)
    If Str = Str2 Then IsSelected = "selected='selected'" Else IsSelected = "" 
End Function 

'处理错误信息 If Err Then doError Err.Description, "Msg" 
Sub DoError(S, Msg)
    'On Error Resume Next
    Dim nRnd, C 
    Randomize 
    nRnd = CLng(Rnd() * 29252888) 
    C = "<br />" 
    C = C & "<div style=""width:100%; font-size:12px;;line-height:150%"">" 
    C = C & "  <label onClick=""ERRORDIV" & nRnd & ".style.display=(ERRORDIV" & nRnd & ".style.display=='none'?'':'none')"">" 
    C = C & "  <span style=""background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">〖 出错 提示信息 ERROR 〗</span><br />" 
    C = C & "  </label>" 
    C = C & "  <div id=""ERRORDIV" & nRnd & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;"">" 
    C = C & " <span style=""color:#FF0000;"">出错描述</span> " & S & "<br />" 
    C = C & " <span style=""color:#FF0000;"">回显信息</span> " & Msg & "<br />" 
    C = C & "  </div>" 
    C = C & "</div>" 
    C = C & "<br />" 
    Response.Write(C) 
    Response.End()    '终止，程序停止 
End Sub 

'执行ASP脚本
Function Exec(Byval tStr) 
	IF tStr="" Then Exit Function: End If
	On Error Resume Next
	Execute(tStr)
	On Error Goto 0
End Function
 
%> 

