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



Function checkStr(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    checkStr = True
    Set c = CreateObject("VBscript.RegExp")
        c.Global = True
        c.IgnoreCase = True
        c.pattern = b
        Set d = c.Execute(a)
            If d.Count = 0 Then checkStr = False
        Set d = Nothing
    Set c = Nothing
    If Err Then Call doError(Err.Description, "CheckStr 检查字符是否存在 函数出错，SerchValue=" & b)
End Function

Function regExp_CheckStr(a, b)
    regExp_CheckStr = checkStr(a, b)
End Function

Function existsStr(a, b)
    existsStr = checkStr(a, b)
End Function

Function regExp_Instr(a, b)
    regExp_Instr = checkStr(a, b)
End Function


Function regExp_Replace(ByVal a, ByVal b, ByVal c)
    On Error Resume Next
    Dim d
    Set d = CreateObject("VBscript.RegExp")
        d.pattern = b
        d.IgnoreCase = True
        d.Global = True
        regExp_Replace = d.Replace(a, c)
    Set d = Nothing
    If Err Then Call doError(Err.Description, "RegExp_Replace 替换内容 函数出错，SetPattern=" & b & " |Str=" & c)
End Function

Function replaceColor(a, b, c, d)
    If d <> "" Then c = "<font color=" & d & ">" & c & "</font>"
    replaceColor = regExp_Replace(a, b, c)
End Function

Function delHtml(ByVal a)
    On Error Resume Next
    Dim b, c
    Set b = CreateObject("VBscript.RegExp")
        b.IgnoreCase = True
        b.Global = True
        b.pattern = "(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)"
        c = b.Replace(a, "")
        delHtml = c
    Set b = Nothing
    If Err Then Call doError(Err.Description, "DelHtml 删除HTML标签 函数出错，")
End Function

Function regExp_DelHtml(a)
    regExp_DelHtml = delHtml(a)
End Function

Function getAUrlTitleList(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d, e, f, g
    d = ""
    Set g = CreateObject("VBscript.RegExp")
        g.IgnoreCase = True
        g.Global = True
        g.pattern = "<a [^>]*href *= *[""']([^""'> ]+)[^>]*>([^<]+)"
        Set e = g.Execute(a)
            For Each f In e
                If b = "链接" Or b = "网址" Or b = "0" Then
                    c = f.SubMatches(0)
                ElseIf b = "标题" Or b = "1" Then
                    c = f.SubMatches(1)
                Else
                    c = f.SubMatches(0) & "$Array$" & f.SubMatches(1)
                End If
                If InStr(vbCrLf & d & vbCrLf, vbCrLf & c & vbCrLf) = False Then
                    d = d & c & vbCrLf
                End If
            Next
        Set e = Nothing
    Set g = Nothing
    If d <> "" Then d = Left(d, Len(d) - 2)
    getAUrlTitleList = d
    If Err Then Call doError(Err.Description, "GetHrefUrlTitleList 获得内容中链接与标题列表 函数出错，C=" & d)
End Function

Function getAURL(a)
    getAURL = getAUrlTitleList(a, 0)
End Function

Function getATitle(a)
    getATitle = getAUrlTitleList(a, 1)
End Function

Function getAURLTitle(a)
    getAURLTitle = getAUrlTitleList(a, "链接和标题")
End Function



Function getContentAUrlList(ByVal a)
    On Error Resume Next
    Dim b, c, d, e, f
    c = ""
    Set f = CreateObject("VBscript.RegExp")
        f.IgnoreCase = True
        f.Global = True
        f.pattern = "<a [^>]*href *= *[""']([^""'> ]+)[^>]*>"
        Set d = f.Execute(a)
            For Each e In d
                b = e.SubMatches(0)
                If InStr(vbCrLf & c & vbCrLf, vbCrLf & b & vbCrLf) = False Then
                    c = c & b & vbCrLf
                End If
            Next
        Set d = Nothing
    Set f = Nothing
    If c <> "" Then c = Left(c, Len(c) - 2)
    getContentAUrlList = c
    If Err Then Call doError(Err.Description, "GetHrefUrlTitleList 获得内容中链接与标题列表 函数出错，C=" & c)
End Function



Function regExp_GetImgUrlList(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d, e, f, g, h
    h = ""
    b = LCase(b)
    Set e = CreateObject("VBscript.RegExp")
        e.IgnoreCase = True
        e.Global = True
        e.pattern = "<img *src *= *[""|'| ]*([^""'> ]+)"
        Set c = e.Execute(a)
            For Each d In c
                g = d.SubMatches(0)
                f = Right(g, Len(g) - InStrRev(g, "."))
                If b = f Or b = "全部" Or b = "" Then
                    If InStr(vbCrLf & h & vbCrLf, vbCrLf & g & vbCrLf) = False Then
                        h = h & g & vbCrLf
                    End If
                End If
            Next
        Set c = Nothing
    Set e = Nothing
    If h <> "" Then h = Left(h, Len(h) - 2)
    regExp_GetImgUrlList = h
    If Err Then Call doError(Err.Description, "GetIMGUrlList 获得图片中网址 函数出错，c=" & h)
End Function

Function getIMG(a)
    getIMG = regExp_GetImgUrlList(a, "全部")
End Function

Function getIMGJpg(a)
    getIMGJpg = regExp_GetImgUrlList(a, "JPG")
End Function

Function getIMGGif(a)
    getIMGGif = regExp_GetImgUrlList(a, "GIF")
End Function

Function getIMGBmp(a)
    getIMGBmp = regExp_GetImgUrlList(a, "Bmp")
End Function

Function getASPFunctionList(ByVal a)
    On Error Resume Next
    Dim b, c, d, e, f, g
    g = ""
    Set d = CreateObject("VBscript.RegExp")
        d.IgnoreCase = True
        d.Global = True
        d.pattern = "(sub|function) .*?\)"

        Set b = d.Execute(a)
            For Each c In b
                g = g & c & vbCrLf
            Next
        Set b = Nothing
    Set d = Nothing
    If g <> "" Then g = Left(g, Len(g) - 2)
    getASPFunctionList = g
    If Err Then Call doError(Err.Description, "GetASPFunctionList 获得ASP函数列表 函数出错，c=" & g)
End Function

Function getASPDimFunction(ByVal a, b, c, d)

    a = Replace(a, "()", "( )")
    Dim e, f, g
    Set g = CreateObject("VBscript.RegExp")
        g.IgnoreCase = True
        g.Global = True

        a = regExp_Replace(a, "ByVal ", "")
        g.pattern = "(sub|function) *([^\(]+) *\(([^\)]+)\)"
        Set e = g.Execute(a)
            For Each f In e

                If InStr(b, "{") = False Then
                    b = b & Trim(f) & vbCrLf
                    c = c & Trim(f.SubMatches(1)) & vbCrLf
                    d = d & Replace(f.SubMatches(2), " ", "") & vbCrLf
                End If
            Next
        Set e = Nothing
    Set g = Nothing

    getASPDimFunction = b
    If Err Then Call doError(Err.Description, "GetASPFunctionList 获得ASP函数列表 函数出错，")
End Function


Function strLength(a)
    Dim b, c, d
    c = 0
    Set b = CreateObject("VBscript.RegExp")
        b.Global = True
        b.IgnoreCase = True
        b.pattern = "[\u4E00-\u9FA5\uF900-\uFA2D]"
        For Each d In b.Execute(a)
            c = c + 1
        Next
    Set b = Nothing
    c = c + Len(a)
    strLength = c
End Function

Function regExpGetLenght(a)
    regExpGetLenght = strLength(a)
End Function

Function stringLength(a)
    stringLength = strLength(a)
End Function

Function getCssHref(ByVal a)
    On Error Resume Next
    Dim b, c, d, e, f, g
    Set d = CreateObject("VBscript.RegExp")
        d.IgnoreCase = True
        d.Global = True
        d.pattern = "<link .*?href *= *[""|'| ]*([^""'>]+)"
        Set b = d.Execute(a)
            For Each c In b
                If InStr(LCase(c), "stylesheet") > 0 Then
                    f = c.SubMatches(0)
                    g = g & f & vbCrLf
                End If
            Next
        Set b = Nothing
    Set d = Nothing
    If g <> "" Then g = Left(g, Len(g) - 2)
    getCssHref = g
    If Err Then Call doError(Err.Description, "GetCssHref 获得HTML中Css 函数出错，C =" & g)
End Function

Function getJsSrc(ByVal a)
    On Error Resume Next
    Dim b, c, d, e, f, g
    Set d = CreateObject("VBscript.RegExp")
        d.IgnoreCase = True
        d.Global = True
        d.pattern = "<script .*?src *= *[""|'| ]*([^""'>]+)"
        Set b = d.Execute(a)
            For Each c In b
                f = c.SubMatches(0)
                g = g & f & vbCrLf
            Next
        Set b = Nothing
    Set d = Nothing
    If g <> "" Then g = Left(g, Len(g) - 2)
    getJsSrc = g
    If Err Then Call doError(Err.Description, "GetJsSrc 获得HTML中Js 函数出错，C =" & g)
End Function

Function delHTMLScript(ByVal a)
    On Error Resume Next
    Dim b, c
    Set b = CreateObject("VBscript.RegExp")
        b.IgnoreCase = True
        b.Global = True
        b.pattern = "<script.*</script>"
        c = b.Replace(a, "")
        delHTMLScript = c
    Set b = Nothing
    If Err Then Call doError(Err.Description, "删除HTML中<scirpt 函数出错，")
End Function

Function getMeta(ByVal a, b, c)
    On Error Resume Next
    Dim d, e, f, g, h, i
    i = ""
    b = LCase(b)
    c = 0
    Set f = CreateObject("VBscript.RegExp")
        f.IgnoreCase = True
        f.Global = True
        f.pattern = "<meta .*?content *= *[""|'| ]*([^""'>]+)"
        Set d = f.Execute(a)
            For Each e In d
                If InStr(LCase(e), b) > 0 Then
                    h = e.SubMatches(0)
                    i = i & h & vbCrLf
                    c = c + 1
                End If
            Next
        Set d = Nothing
    Set f = Nothing
    If i <> "" Then i = Left(i, Len(i) - 2)
    getMeta = i
    If Err Then Call doError(Err.Description, "GetKeyWords 获得HTML中keywords 函数出错，C =" & i)
End Function

Function delHtmlNote(a)
    Dim b, c
    b = CStr(a)
    Set c = CreateObject("VBscript.RegExp")
        c.pattern = "<!--\/*[^<>]*-->"
        c.IgnoreCase = True
        c.Global = True
        b = c.Replace(b, "")
        delHtmlNote = b
    Set c = Nothing
End Function

Function delHtmlMyNote(a)
    Dim b, c
    b = CStr(a)
    Set c = CreateObject("VBscript.RegExp")
        c.pattern = "<!--#\/*[^<>]*#-->"
        c.IgnoreCase = True
        c.Global = True
        b = c.Replace(b, "")
        delHtmlMyNote = b
    Set c = Nothing
End Function

Function getStrImgList(ByVal a)
    a = Replace(a, "'", """")
    Dim b, c, d, e, f
    b = "" : c = ""
    Set f = CreateObject("VBscript.RegExp")

        f.IgnoreCase = True
        f.Global = True
        f.pattern = "<img [^>]*src=""([^"">]+)[^>]+>"
        Set d = f.Execute(a)
            For Each e In d
                b = b & e & "|"
                c = c & e.SubMatches(0) & "|"
            Next
        Set d = Nothing
    Set f = Nothing
    If b <> "" Then
        b = Left(b, Len(b) - 1)
        c = Left(c, Len(c) - 1)
    End If


    getStrImgList = c
End Function

Function getEMailList(a)
    Dim b, c, d, e
    Set b = CreateObject("VBscript.RegExp")
        b.pattern = "\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
        b.IgnoreCase = True
        b.Global = True
        e = ""
        Set d = b.Execute(a)
            For Each c In d
                If InStr("," & e & ",", "," & c.Value & ",") = 0 Then
                    e = e & c.Value & ","
                End If
            Next
        Set d = Nothing
    Set b = Nothing
    If e <> "" Then e = Left(e, Len(e) - 1)
    getEMailList = e
End Function

Function oflink_lcasetag(a)
    Dim b, c, d
    Set b = CreateObject("VBscript.RegExp")
        b.pattern = "<.+?\>"
        b.IgnoreCase = True
        b.Global = True
        Set d = b.Execute(a)
            a = a
            For Each c In d
                a = Replace(a, c.Value, LCase(c.Value))
            Next
            oflink_lcasetag = a
        Set d = Nothing
    Set b = Nothing
End Function





Function scriptHtml(ByVal a, b, c)
    Dim d
    Set d = CreateObject("VBscript.RegExp")
        d.IgnoreCase = True
        d.Global = True
        Select Case c
            Case 1
                d.pattern = "<" & b & "([^>])*>"
                a = d.Replace(a, "")
            Case 2
                d.pattern = "<" & b & "([^>])*>.*?</" & b & "([^>])*>"
                a = d.Replace(a, "")
            Case 3
                d.pattern = "<" & b & "([^>])*>"
                a = d.Replace(a, "")
                d.pattern = "</" & b & "([^>])*>"
                a = d.Replace(a, "")
        End Select
        scriptHtml = a
    Set d = Nothing
End Function






Function getRegExp(a, b, c, d, e)
    Dim f, g, h, i, j, k
    i = ""
    If c <> "" Then c = CInt(c)
    If d <> "" Then d = CInt(d)
    If e <> "" Then e = CInt(e)
    j = False
    If c <> "" Or d <> "" Or e <> "" Then j = True
    Set f = CreateObject("VBscript.RegExp")
        f.pattern = a
        f.IgnoreCase = True
        f.Global = True
        Set h = f.Execute(b)
            For Each g In h
                If j = True Then
                    k = ""
                    If c <> "" Then
                        k = k & g.SubMatches(c)
                    End If
                    If d <> "" Then
                        If k <> "" Then k = k & "[$Split$]"
                        k = k & g.SubMatches(d)
                    End If
                    If e <> "" Then
                        If k <> "" Then k = k & "[$Split$]"
                        k = k & g.SubMatches(e)
                    End If
                    If k <> "" Then i = i & k & "[$Array$]"
                Else
                    i = i & g & "[$Array$]"
                End If
            Next
            If i <> "" Then i = Left(i, Len(i) - 9)
            getRegExp = i
End Function




Function getImgJsUrl(a, b)
    Dim c, d, e, f, g
    b = LCase(b)
    d = RegExpGetStr("<[img|script][^<>]*src[^<>]*[\/]?>", a, 2)
    e = Split(d, "[$Array$]")
    g = ""
    For Each c In e
        f = RegExpGetStr("src=[""|']?([^""' ]*)([""|']?).*[\/]?>", c, 1)
        If b = "1" Or b = "不重复" Then
            If InStr(vbCrLf & g & vbCrLf, vbCrLf & f & vbCrLf) Then
                f = ""
            End If
        End If
        If f <> "" Then
            g = g & f & vbCrLf
        End If
    Next
    If g <> "" Then g = Left(g, Len(g) - 2)
    getImgJsUrl = g
End Function








Function regExpGetStr(a, b, c)
    Dim d, e, f, g
    g = ""
    regExpGetStr = ""
    Set d = CreateObject("VBscript.RegExp")
        d.IgnoreCase = True
        d.Global = True
        d.pattern = a
        Set f = d.Execute(b)
            For Each e In f
                If c = 1 Then
                    e = d.Replace(e, "$1")
                ElseIf c = 2 Then
                    g = g & e & "[$Array$]"
                End If
                regExpGetStr = e
            Next
        Set f = Nothing
    Set d = Nothing
    If c = 2 Then
        If g <> "" Then g = Left(g, Len(g) - 9)
        regExpGetStr = g
    End If
End Function


Function newGetPingIP(a)
    Dim b, c, d
    Dim e, f, g, h
    newGetPingIP = ""
    b = "/备份/cmd.exe"

    c = GetPingInfo(b, a)
    d = Split(c, "Request timed out.")

    If UBound(d) >= 4 Then
        f = Trim(Replace(Replace(Replace(a, "http://", ""), "www.", ""), "/", ""))
        e = "http://whois.www.net.cn/whois/api_webinfo?host=" & f & "&_=" & getRnd(9)
        c = GetHttpPage(e, "utf-8")
        g = """ip"":""" : h = """"
        If InStr(c, g) > 0 And InStr(c, h) > 0 Then
            newGetPingIP = StrCut(c, g, h, 2)
        End If
    Else
        g = " [" : h = "]"
        If InStr(c, g) > 0 And InStr(c, h) > 0 Then
            newGetPingIP = StrCut(c, g, h, 2)
        Else
            newGetPingIP = "NO"

        End If
    End If
End Function

Function getPingIP(a, b)
    Dim c, d, e

    d = " [" : e = "]"
    c = GetPingInfo(a, b)
    If InStr(c, d) > 0 And InStr(c, e) > 0 Then
        getPingIP = StrCut(c, d, e, 2)
    Else
        getPingIP = "NO"

    End If
End Function

Function getPingInfo(a, b)
    Dim c, d
    Set c = CreateObject("WScript.Shell")
        Call HandlePath(a)
        Set d = c.exec(a & " /c ping " & b)
            getPingInfo = d.stdout.readall
End Function

Function regExpTest(a, b)
    Dim c
    Set c = CreateObject("VBscript.RegExp")
        c.IgnoreCase = True
        c.Global = True
        c.pattern = b
        regExpTest = c.Test(a)
    Set c = Nothing
End Function


Function getRegExpStr(ByVal a, ByVal b, ByVal c)
    On Error Resume Next
    Dim d, e, f, g, h, i
    e = ""
    Set h = CreateObject("VBscript.RegExp")
        h.IgnoreCase = True
        h.Global = True
        h.pattern = b
        Set f = h.Execute(a)
            For Each g In f
                i = Replace(c, "\S1\", g.SubMatches(0))
                i = Replace(i, "\S2\", g.SubMatches(1))
                i = Replace(i, "\S3\", g.SubMatches(2))
                i = Replace(i, "\S4\", g.SubMatches(3))
                i = Replace(i, "\S5\", g.SubMatches(4))
                a = Replace(a, g, i)
            Next
        Set f = Nothing
    Set h = Nothing
    getRegExpStr = a
End Function




Function regExpReplaceCssDir(ByVal a, b)
    Dim c, d, e, f
    Dim g, h
    Set e = CreateObject("VBscript.RegExp")
        e.ignoreCase = True
        e.global = True
        e.pattern = "<link .*?href *= *[""|'| ]*([^""'>]+)"
        Set c = e.Execute(a)
            For Each d In c
                If InStr(LCase(d), "stylesheet") > 0 Then
                    g = d.subMatches(0)
                    h = getStrFileName(g)
                    f = Replace(d, g, b & h)
                    a = Replace(a, d, f)
                End If
            Next
        Set c = Nothing
    Set e = Nothing
    regExpReplaceCssDir = a
End Function



Function deleteNullRow(ByVal a)
    deleteNullRow = regExp_Replace(a, "\r\n\s*\r\n", "")
End Function
%>



