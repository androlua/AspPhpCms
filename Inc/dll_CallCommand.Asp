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
<!--#Include file="config.asp"-->
<%

Class dllCommand







    Private FrmName


    Private Sub Class_Initialize()

    End Sub

    Private Sub Class_Terminate()

    End Sub

    Public Property Let setFrmName(Str)
         FrmName = Str
    End Property

    Public Property Get getFrmName()
        getFrmName = FrmName
    End Property


    Function handAction(ByVal a)
        Dim b, c
        a = PHPTrim(a)
        c = a

        If InStr(c, " ") > 0 Then
            b = Mid(c, 1, InStr(c, " ") - 1)
            c = Mid(c, InStr(c, " ") + 1)
        End If

        If b = "ask" Then
             handAction = ask(c)

        ElseIf InStr("|access|accesspass|", "|" & LCase(b) & "|") > 0 Then
            Dim d: Set d = New clsAccessPass
            Dim e
            handAction = HandlePath(c) & " 密码为" & vbCrLf & d.INNER_GetAccessPwd(HandlePath(c), e, True)

        ElseIf Right(c, 1) = "=" Then
            c = Mid(a, 1, Len(a) - 1)
            handAction = a & "" & getVBScript("function Run(a):Run=eval(a):end function ", c)

        ElseIf a = "test" Then
            handAction = a & "=" & getVBScript("function Run(a):Run=eval(a):end function ", "1+2")

        Else
            handAction = ask(a)
        End If
        Call CreateFile("1.txt", handAction)
    End Function

    Function ask(a)
        ask = ""
        If InStr("|35915100|", "|" & a & "|") > 0 Then
            ask = "35915100 仿站与ASP程序维护群"
        ElseIf InStr("|313801120|qq313801120|", "|" & a & "|") > 0 Then
            ask = "313801120为作者QQ号" & vbCrLf & "多年WEB开发程序员。"

        ElseIf InStr("|小云|小孙|孙晓云|", "|" & a & "|") > 0 Then

            ask = "孙晓云是这款软件的开发人员，" & vbCrLf & "可联系QQ313801120。11111"
        End If
    End Function


    Function Eerr(a, b)
        Response.Write ("<font color=red>" & a & "</font>：" & b)
    End Function

    Function Rw(a)
        Response.Write a
    End Function

    Function PHPTrim(a)
        PHPTrim = TrimVbCrlf(a)
    End Function
    Function ECHO(a, b)
        Call echoPrompt(a, b)
    End Function
    Function TrimVbCrlf(a)
        TrimVbCrlf = rtrimVBcrlf(ltrimVBcrlf(a))
    End Function
    Function echoPrompt(a, b)
        Response.Write "<font color=Green>" & a & "</font>：" & b & "<br>"
    End Function
    Function rtrimVBcrlf(a)
        Dim b, c
        b = Len(a)
        c = True
        While c And b >= 2
            If Mid(a, b, 1) = " " & Mid(a, b, 1) = vbTab Then
                b = b - 1
            ElseIf Mid(a, b - 1, 2) = vbCrLf Then
                b = b - 2
            Else
                c = False
            End If
        Wend
        rtrimVBcrlf = RTrim(Left(a, b))
    End Function
    Function ltrimVBcrlf(a)
        Dim b, c
        b = 1
        c = True
        While c
            If Mid(a, b, 1) = " " Or Mid(a, b, 1) = vbTab Then
                b = b + 1
            ElseIf Mid(a, b, 2) = vbCrLf Then
                b = b + 2
            Else
                c = False
            End If
        Wend
        ltrimVBcrlf = Right(a, Len(a) - b + 1)
    End Function
	
	
	Function getVBScript(ByVal a, ByVal b)
		Dim c
		Set c = CreateObject("ScriptControl")
		c.Language = "VBScript"
		c.AddCode a
		c.AddCode "Function mytest(): mytest = ""【vb内容】"":End Function"
		
		getVBScript = c.Run("Run", b)
	End Function
			
End Class


Dim ddlCD : Set ddlCD = New dllCommand	




select case request("act")
	case "handle" : call ddlCD.rw(ddlCD.handAction(request("command")))
	case else:Default()
end select


sub Default()
%>
<form id="form1" name="form1" method="post" action="?act=handle">
  发送内容
  <input name="command" type="text" id="command" value="3+3*5=" />
  <input type="submit" name="button" id="button" value="提交" />
</form>
<form id="form2" name="form1" method="post" action="?act=handle">
  发送内容
  <input name="command" type="text" id="command" value="ask 35915100" />
  <input type="submit" name="button" id="button" value="提交" />
</form>
<%end sub%>

