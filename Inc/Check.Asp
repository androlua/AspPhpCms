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



Function isUCase(a)
    Dim b, c
    isUCase = True
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("ABCDEFGHIJKLMNOPQRSTUVWXYZ", c) = False Then
            isUCase = False
            Exit Function
        End If
    Next
End Function

Function isLCase(a)
    Dim b, c
    isLCase = True
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("abcdefghijklmnopqrstuvwxyz", c) = False Then
            isLCase = False
            Exit Function
        End If
    Next
End Function



Sub checkErr(a)
    If Err.Number <> 0 Then
        Call echo(Err.Number, "自定义错误信息：" & a & "<br>系统错误信息：" & Err.Description & "<br>最初生成错误的对象或应用程序的名称：" & Err.Source)
    End If
End Sub


Function strToTrueFalse(ByVal a)
    a = Trim(LCase(a))
    strToTrueFalse = IIF(a = "true", True, False)
End Function

Function strTrueFalseToInt(ByVal a)
    a = Trim(LCase(a))
    strTrueFalseToInt = IIF(a = "true", 1, 0)
End Function

Function checkVbCrlf(a)
    checkVbCrlf = False
    If InStr(a, vbCrLf) > 0 Then checkVbCrlf = True
End Function

Function checkBr(a)
    checkBr = checkVbCrlf(a)
End Function


Function isParity(a)
    isParity = ""
    If Not IsNumeric(a) Then
        isParity = "这不是一个数字啊"
        Exit Function
    End If
    If a Mod 2 = 0 Then
        isParity = 0
    Else
        isParity = 1
    End If
End Function

Function checkEval(a)
    On Error Resume Next
    Call Execute(a)
    If Err.Number = 0 Then
        checkEval = True
    Else
        checkEval = False
    End If
End Function



Function replace_SQLText(a)
    If IsNull(a) Then
        replace_SQLText = ""
        Exit Function
    Else
        a = Trim(a)
        a = Replace(a, "'", "''")
        a = Replace(a, ";", "；")
        a = Replace(a, "--", "—")
        a = HTMLEncode(a)
        replace_SQLText = a
    End If
End Function



Function chkPost()
    Dim b, c
    chkPost = False
    b = CStr(Request.ServerVariables("HTTP_REFERER"))
    c = CStr(Request.ServerVariables("SERVER_NAME"))
    Call echo(b, c)
    If Mid(b, 8, Len(c)) <> c Then
        chkPost = False
    Else
        chkPost = True
    End If
End Function


Function isMail(a)
    isMail = True
    Dim b
    Set b = CreateObject("VBscript.RegExp")
        b.pattern = "([\.a-zA-Z0-9_-]){2,10}@([a-zA-Z0-9_-]){2,10}(\.([a-zA-Z0-9]){2,}){1,4}$"
        isMail = b.Test(a)
    Set b = Nothing
End Function

Function isValidEmail(a)
    Dim b, c, d, e
    isValidEmail = True
    b = Split(a, "@")
    If UBound(b) <> 1 Then isValidEmail = False : Exit Function
    For Each c In b
        If Len(c) <= 0 Then isValidEmail = False : Exit Function
        For d = 1 To Len(c)
            e = LCase(Mid(c, d, 1))
            If InStr("abcdefghijklmnopqrstuvwxyz_-.", e) <= 0 And Not IsNumeric(e) Then isValidEmail = False : Exit Function
        Next
        If Left(c, 1) = "." Or Right(c, 1) = "." Then isValidEmail = False : Exit Function
    Next
    If InStr(b(1), ".") <= 0 Then isValidEmail = False : Exit Function
    d = Len(b(1)) - InStrRev(b(1), ".")
    If d <> 2 And d <> 3 Then isValidEmail = False : Exit Function
    If InStr(a, "..") > 0 Then isValidEmail = False
End Function

Function isCode(ByVal a)
    Dim b
    b = Replace(a, " ", "")
    b = Replace(b, Chr(13), "")
    b = Replace(b, Chr(10), "")
    b = Replace(b, vbTab, "")
    isCode = IIF(b <> "", True, False)
End Function

Function checkNumber(ByVal a)
    Dim b, c
    If Len(a) = 0 Then checkNumber = False : Exit Function
    checkNumber = True
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789", LCase(c)) = False Then
            checkNumber = False
            Exit Function
        End If
    Next
End Function

Function isNumber(ByVal a)
    isNumber = checkNumber(a)
End Function

Function checkABC(ByVal a)
    Dim b, c
    checkABC = True
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("abcdefghijklmnopqrstuvwxyz", LCase(c)) = False Then
            checkABC = False
            Exit Function
        End If
    Next
End Function

Function getLen(a)
    Dim b, c, d
    d = 0
    For b = 1 To Len(a)
        c = Asc(Mid(CStr(a), b, 1))
        If c < 0 Then
            d = d + 2
        Else
            d = d + 1
        End If
    Next
    getLen = d
End Function

Function checkTime(a)
    checkTime = IIF(IsDate(a) = False, False, True)
End Function

Function isNul(ByVal a)
    On Error Resume Next : If Err.Number <> 0 Then Err.Clear
    isNul = False
    Select Case VarType(a)
        Case vbEmpty, vbNull
            isNul = True : Exit Function
        Case vbString
            If a = "" Then isNul = True : Exit Function
        Case vbObject
            Select Case TypeName(a)
                Case "Nothing", "Empty"
                    isNul = True : Exit Function
                Case "Recordset"
                    If a.State = 0 Then isNul = True : Exit Function
                    If a.BOF And a.EOF Then isNul = True : Exit Function
                Case "Dictionary"
                    If a.Count = 0 Then isNul = True : Exit Function
            End Select
    Case vbArray, 8194, 8204, 8209
        If UBound(a) = -1 Then isNul = True : Exit Function
    End Select
    On Error Goto 0
End Function












Function foundInArr(a, b, c)
    Dim d, e
    foundInArr = False
    If InStr(a, c) > 0 Then
        d = Split(a, c)
        For e = 0 To UBound(d)
            If LCase(Trim(d(e))) = LCase(Trim(b)) Then
                foundInArr = True : Exit For
            End If
        Next
    Else
        If LCase(Trim(a)) = LCase(Trim(b)) Then foundInArr = True
    End If
End Function
%>


