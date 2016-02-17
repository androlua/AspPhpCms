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



Function getHttpPage(ByVal a, ByVal b)
    getHttpPage = handleGetHttpPage(a, b)(0)
End Function

Function handleGetHttpPage(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d, e, f, g, h
    c = Now()
    b = handleStrCharSet(b)
    If IsNull(a) = True Or Len(a) < 18 Or a = "$False$" Then
        handleGetHttpPage = "$False$"
        Exit Function
    End If
    Dim i
    Set i = CreateObject("MSXML2.XMLHTTP")
        Call i.Open("GET", a, False)
        i.send
        If i.readyState <> 4 Then
            Set i = Nothing
            handleGetHttpPage = "$False$"
            Exit Function
        End If

        f = BytesToBstr(i.responseBody, b)
        d = i.Status
        e = DateDiff("s", c, Now())
        h = strLength(f)

        g = "|-*ypia=|"
        handleGetHttpPage = Split(f & g & d & g & e & g & h, g)

    Set i = Nothing
End Function


Function getURLContent(a, b)
    getURLContent = getHttpPage(a, b)
End Function

Function getHttpUrl(a, b)
    getHttpUrl = getHttpPage(a, b)
End Function
Function bytesToBstr(a, b)
    Dim c
    If isNul(a) Then Exit Function
    Set c = CreateObject("ADODB.Stream")
        c.Type = 1
        c.Mode = 3
        c.Open
        Call c.Write(a)
        c.Position = 0
        c.Type = 2
        c.Charset = b
        bytesToBstr = c.ReadText
        c.Close
    Set c = Nothing
End Function






Function strCut(ByVal a, ByVal b, ByVal c, ByVal d)

    Dim e, f, g, h, i
    If InStr(a, b) = False Or InStr(a, c) = False Then
        i = ""
        Exit Function
    End If
    Select Case d

        Case 1
            e = InStr(a, b)
            f = Mid(a, e + Len(b))
            g = e + InStr(f, c) + Len(b) + Len(c) - 1

        Case Else
            e = InStr(a, b) + Len(b)
            f = Mid(a, e)

            g = e + InStr(f, c) - 1

    End Select
    h = g - e
    If h >= 0 Then
        i = Mid(a, e, h)
    Else
        i = ""
    End If
    If d = 3 Then
        i = b & i
    End If
    If d = 4 Then
        i = i & c
    End If
    strCut = i


End Function

Function getStrCut(ByVal a, ByVal b, ByVal c, ByVal d)
    getStrCut = ""

    If InStr(a, b) > 0 And InStr(a, c) > 0 Then
        getStrCut = strCut(a, b, c, d)
    End If
End Function

Function cutStr(ByVal a, ByVal b, ByVal c)
    Dim d, e, f
    f = 0
    b = CInt(b)
    If c = "" Then c = "..."
    If LCase(c) = "none" Or LCase(c) = "null" Then c = ""
    cutStr = a
    For d = 1 To Len(a)
        e = Asc(Mid(CStr(a), d, 1))
        If e < 0 Then e = e + 65536
        If e < 255 Then f = f + 1
        If e > 255 Then f = f + 2
        If f >= b Then cutStr = Left(a, d) & c : Exit Function
    Next
End Function

Function cutStrNOLU(a, b, c)
    Dim d, e, f, g, h
    b = LCase(b)
    c = LCase(c)
    e = LCase(a)

    If InStr(e, b) > 0 Then
        f = InStr(e, b)
        d = Mid(a, f)
        e = Mid(d, Len(b) + 1)
        h = Mid(d, 1, Len(b) + 1)

        e = Replace(e, "<", "&lt;")


        g = InStr(e, c)
        Call echo("nEndLen", g)

        d = Mid(a, f, g + Len(b))


        cutStrNOLU = d
    End If
End Function


Function setCutTDStr(ByVal a, ByVal b, ByVal c)
    Dim d, e, f, g, h, i
    a = CStr(a & "")
    If a = "" Then setCutTDStr = a : Exit Function
    If b = "" Then setCutTDStr = a : Exit Function
    g = 0 : i = False
    h = Int(b / 6.3)
    For d = 1 To Len(a)
        e = Mid(a, d, 1)
        If g >= h Then
            i = True
            Exit For
        Else
            f = f & e
        End If
        If Asc(e) < 0 Then
            g = g + 2
        Else
            g = g + 1
        End If
    Next
    If i = True Then

        f = "<span Title=""" & showHTMLCode(a) & """ style=""background-color:" & c & ";"">" & f & "</span>"
    End If
    setCutTDStr = f
End Function

Function cutTDStr(a, b)
    cutTDStr = setCutTDStr(a, b, "#FBE3EF")
End Function

Function getArrayList(ByVal a, ByVal b, ByVal c, ByVal d, ByVal e, ByVal f)

    If IsNull(a) = True Or IsNull(b) = True Or IsNull(c) = True Then
        getArrayList = ""
        Exit Function
    End If
    Dim g, h, i, j
    a = Replace(Replace(a, Chr(10), "【换行】"), Chr(13), "【换行】")
    Set h = CreateObject("VBscript.RegExp")
        h.IgnoreCase = True
        h.Global = True
        h.pattern = "(" & b & ").+?(" & c & ")"
        Set i = h.Execute(a)
            For Each j In i
                g = g & "$Array$" & j.Value
            Next
        Set i = Nothing
        If g = "" Then
            getArrayList = ""
            Exit Function
        End If
        g = Right(g, Len(g) - 7)
        If d = False Then
            h.pattern = b
            g = h.Replace(g, "")
        End If
        If e = False Then
            h.pattern = c
            g = h.Replace(g, "")
        End If
    Set h = Nothing
    If f = "1" Or f = "去掉字符" Or f = True Then
        g = Replace(g, """", "")
        g = Replace(g, "'", "")
        g = Replace(g, " ", "")
        g = Replace(g, "(", "")
        g = Replace(g, ")", "")
    End If
    getArrayList = g
End Function

Function getArray(a, b, c, d, e)
    getArray = getArrayList(a, b, c, d, e, "")
End Function

Function getArray1(a, b, c, d, e)
    getArray1 = getArrayList(a, b, c, d, e, "去掉字符")
End Function

Function getSplit(ByVal a, ByVal b, ByVal c)
    Dim d
    d = Split(a, b)
    getSplit = d(c)
End Function

Function getSplitCount(ByVal a, ByVal b)
    Dim c
    c = Split(a, b)
    getSplitCount = UBound(c)
    If getSplitCount > 0 Then getSplitCount = getSplitCount + 1
End Function


Function agent(ByVal a)

    Server.ScriptTimeout = 999


    Dim b
    Set b = CreateObject("WinHttp.WinHttpRequest.5.1")

        b.Open "GET", a, False
        If Request.ServerVariables("HTTP_REFERER") <> "" Then
            b.SetRequestHeader "Referer", Request.ServerVariables("HTTP_REFERER")
        End If
        If Request.Cookies <> "" Then
            b.SetRequestHeader "Cookie", Request.Cookies
        End If
        b.SetRequestHeader "User-Agent", Request.ServerVariables("HTTP_USER_AGENT")
        b.SetRequestHeader "X-Forwarded-For", Request.ServerVariables("REMOTE_ADDR") & ", " & Request.ServerVariables("LOCAL_ADDR")
        b.SetRequestHeader "Connection", "Close"
        b.SetRequestHeader "Nuclear-Atk", "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME") & "?" & Request.QueryString
        b.SetRequestHeader "Nuclear-Atk-Host", Request.ServerVariables("HTTP_HOST")
        b.send

        Response.Status = b.Status & " " & b.StatusText
        Response.ContentType = b.GetResponseHeader("Content-Type")
        Response.BinaryWrite b.responseBody
End Function

%>



