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



Function cssCompression(a, b)
    b = CStr(b)

    If b = "1" Then
        a = RegExp_Replace(a, "\/\*(.|" & vbCrLf & ")*?\*\/", "")
        a = RegExp_Replace(a, "\s*([\{\}\:\;\,])\s*", "$1")
        a = RegExp_Replace(a, "\,[\s\.\#\d]*\{", "{")
        a = RegExp_Replace(a, ";\s*;", ";")

    Else
        If b >= 2 Then
            a = RegExp_Replace(a, "\/\*(.|" & vbCrLf & ")*?\*\/", "")
        End If
        a = RegExp_Replace(a, "\s*([\{\}\:\;\,])\s*", "$1")
        a = RegExp_Replace(a, "\,[\s\.\#\d]*\{", "{")
        a = RegExp_Replace(a, ";\s*;", ";")
        a = RegExp_Replace(a, ";\s*}", "}")
        a = RegExp_Replace(a, "([^\s])\{([^\s])", "$1{$2")
        a = RegExp_Replace(a, "([^\s])\}([^" & vbCrLf & "]s*)", "$1}" & vbCrLf & "$2")



    End If
    a = trimVBcrlf(a)
    cssCompression = a
End Function


Function deleteCssNote(a)
    deleteCssNote = RegExp_Replace(a, "\/\*(.|" & vbCrLf & ")*?\*\/", "")
End Function


Function unCssCompression(a)
    a = RegExp_Replace(a, "\s*([\{\}\:\;\,])\s*", "$1")
    a = RegExp_Replace(a, ";\s*;", ";")
    a = RegExp_Replace(a, "\,[\s\.\#\d]*{", "{")
    a = RegExp_Replace(a, "([^\s])\{([^\s])", "$1 {" & vbCrLf & "" & vbTab & "$2")
    a = RegExp_Replace(a, "([^\s])\}([^" & vbCrLf & "]*)", "$1" & vbCrLf & "}" & vbCrLf & "$2")
    a = RegExp_Replace(a, "([^\s]);([^\s\}])", "$1;" & vbCrLf & "" & vbTab & "$2")
    unCssCompression = a
End Function


Function trimVbCrlf(a)
    trimVbCrlf = rtrimVBcrlf(ltrimVBcrlf(a))
End Function


Function pHPTrim(a)
    pHPTrim = trimVbCrlf(a)
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


Function rtrimVBcrlf(a)
    Dim b, c
    b = Len(a)
    c = True
    While c And b >= 2
        If Mid(a, b, 1) = " " Or Mid(a, b, 1) = vbTab Then
            b = b - 1
        ElseIf Mid(a, b - 1, 2) = vbCrLf Then
            b = b - 2
        Else
            c = False
        End If
    Wend
    rtrimVBcrlf = RTrim(Left(a, b))
End Function




Function trimVbTab(a)
    trimVbTab = RTrimVBTab(LTrimVbTab(a))
End Function



Function lTrimVbTab(a)
    Dim b, c
    b = 1
    c = True
    While c
        If Mid(a, b, 1) = " " Then
            b = b + 1
        ElseIf Mid(a, b, 1) = vbTab Then
            b = b + 1
        Else
            c = False
        End If
    Wend
    lTrimVbTab = Right(a, Len(a) - b + 1)
End Function


Function rTrimVBTab(a)
    Dim b, c
    b = Len(a)
    c = True
    While c And b >= 2
        If Mid(a, b, 1) = " " Then
            b = b - 1
        ElseIf Mid(a, b - 1, 1) = vbTab Then
            b = b - 1
        Else
            c = False
        End If
    Wend
    rTrimVBTab = RTrim(Left(a, b))
End Function



Function getHtmlCssStyle(ByVal a)
    Dim b, c, d, e, f, g, h
    b = Split(a, vbCrLf)
    d = False

    For Each c In b
        If d = False Then
            If InStr(LCase(c), "<style") > 0 Then
                e = Mid(c, InStr(LCase(c), "<style"))
                e = Mid(e, 1, InStr(e, ">"))
                f = Mid(c, InStr(LCase(c), e) + Len(e))

                If InStr(f, "</style>") > 0 Then
                    g = Mid(f, 1, InStr(f, "</style>") - 1)
                    h = h & g & vbCrLf
                Else
                    h = h & f & vbCrLf
                    d = True
                End If





            End If
        ElseIf d = True Then
            If InStr(LCase(c), "</style>") > 0 Then
                g = Mid(c, 1, InStr(LCase(c), "</style>") - 1)
                h = h & g & vbCrLf



                d = False
            Else
                h = h & c & vbCrLf
            End If
        End If
    Next
    getHtmlCssStyle = h
End Function


Function handleCleanCss(ByVal a)
    Dim b, c, d, e, f
    a = Replace(a, "{", vbCrLf & "{" & vbCrLf)
    a = Replace(a, "}", vbCrLf & "}" & vbCrLf)
    a = Replace(a, ";", ";" & vbCrLf)

    b = Split(a, vbCrLf)
    e = False
    For Each c In b
        c = trimVbCrlf(c)
        f = ""
        If c <> "" Then
            If InStr(c, "{") > 0 And InStr(c, "}") = False Then
                e = True
                f = c
            ElseIf InStr(c, "}") > 0 Then
                e = False
            End If
            If Left(c, 1) <> "{" Then d = d & vbCrLf
            If e = True Then c = "    " & c
            If f <> "" Then c = f
            d = d & c

        End If
    Next
    d = trimVbCrlf(d)
    handleCleanCss = d
End Function




Function removeExcessRow(a)
    Dim b, c, d, e
    b = Split(a, vbCrLf)
    For Each c In b
        e = Replace(Replace(c, " ", ""), vbTab, "")
        If e <> "" Then
            d = d & c & vbCrLf
        End If
    Next
    If d <> "" Then d = Left(d, Len(d) - 2)
    removeExcessRow = d
End Function




Function cssAddToStyle(a, b)
    Dim c, d, e, f
    If InStr(b, "{") > 0 Then
        c = Trim(Mid(b, 1, InStr(b, "{") - 1))
    End If
    d = FindCssStyle(a, c)
    e = CssStyleAddToParam(d, b)
    a = Replace(a, d, e)

    cssAddToStyle = a


End Function


Function checkCssStyle(a, b)
    Dim c
    checkCssStyle = True
    If InStr(b, "{") > 0 Then
        c = Trim(Mid(b, 1, InStr(b, "{") - 1))
    End If
    If c = "" Then
        checkCssStyle = False
    ElseIf FindCssStyle(a, c) = "" Then
        checkCssStyle = False
    End If
End Function



Function cssStyleAddToParam(ByVal a, ByVal b)
    Dim c, d, e, f, g, h
    h = Mid(a, 1, InStr(a, "{"))
    If InStr(a, "{") > 0 Then
        a = Mid(a, InStr(a, "{") + 1)
    End If
    If InStr(a, "}") > 0 Then
        a = Mid(a, 1, InStr(a, "}") - 1)
    End If
    If InStr(b, "{") > 0 Then
        b = Mid(b, InStr(b, "{") + 1)
    End If
    If InStr(b, "}") > 0 Then
        b = Mid(b, 1, InStr(b, "}") - 1)
    End If
    c = Split(Replace(a & ";" & b, vbCrLf, ""), ";")
    For Each e In c
        e = Trim(e)
        If InStr(e, ":") > 0 And e <> "" Then
            g = Trim(Mid(e, 1, InStr(e, ":") - 1))
            If InStr("|" & f & "|", "|" & g & "|") = False Then
                f = f & g & "|"

                d = d & "    " & e & ";" & vbCrLf
            End If
        End If
    Next
    If h <> "" Then
        d = h & vbCrLf & d & "}"
    End If
    cssStyleAddToParam = d

End Function


Function findCssStyle(ByVal a, ByVal b)
    Dim c, d, e, f


    b = Trim(b)
    c = Split(a, vbCrLf)
    For Each d In c
        If InStr(d, b) > 0 Then
            f = Trim(d)
            If InStr(f, "{") > 0 Then
                f = Trim(Mid(f, 1, InStr(f, "{") - 1))
            End If
            If f = b Then

                If InStr(d, "}") > 0 Then
                    findCssStyle = Mid(d, 1, InStr(d, "}") + 1)

                    Exit Function
                Else
                    e = Mid(a, InStr(a, d & vbCrLf) + 1)
                    e = Mid(e, 1, InStr(e, "}") + 1)
                    findCssStyle = e
                    Exit Function
                End If

            End If

        End If
    Next
End Function





Function handleCutCssCode(a, b)
    Dim c, d, e, f, g, h, i
    d = "url\(" : e = "\)"
    c = getArray(b, d, e, False, False)
    f = Split(c, "$Array$")
    For Each g In f
        If g <> "" And InStr(g, ".") > 0 And InStr(vbCrLf & i & vbCrLf, vbCrLf & g & vbCrLf) = False Then
            i = i & g & vbCrLf
            h = Replace(Replace(Replace(g, """", ""), "'", ""), "\", "/")
            If InStr(h, "/") > 0 Then
                h = Mid(h, InStrRev(h, "/") + 1)
            End If
            b = Replace(b, g, a & h)
        End If
    Next
    handleCutCssCode = b
End Function


Function handleCutDivCode(a, b)
    Dim c, d, e, f, g, h, i, j
    d = "url\(" : e = "\)"
    c = GetArray(b, d, e, False, False)
    f = Split(c, "$Array$")
    For Each g In f

        If g <> "" And InStr(g, ".") > 0 And InStr(g, "{$#") = False Then

            If GetWebSite(g) = "" Then
                i = Replace(Replace(Replace(g, """", ""), "'", ""), "\", "/")
                If InStr(i, "/") > 0 Then
                    i = Mid(i, InStrRev(i, "/") + 1)
                End If
                b = Replace(b, g, a & g)
            End If
        End If
    Next


    c = GetImgJsUrl(b, "不重复") & vbCrLf & GetHtmlBackGroundImgList(b)
    f = Split(c, vbCrLf)
    For Each g In f
        If g <> "" Then
            j = False

            If Left(g, 1) = "\" Then

            ElseIf InStr(g, ".") > 0 And Left(g, 5) <> "HTTP:" And InStr(g, "{$#") = False Then
                j = True
            End If
            If j = True Then
                h = a & RemoveFileDir(g)

                b = Replace(b, """" & g & """", """" & h & """")
                b = Replace(b, "'" & g & "'", """" & h & """")
                b = Replace(b, "=" & g & " ", """" & h & """")
                b = Replace(b, "=" & g & ">", """" & h & """")
            End If
        End If
    Next
    handleCutDivCode = b
End Function


Function getHtmlBackGroundImgList(ByVal a)
    a = GetArray(a, " background=""", """", False, False)
    a = Replace(a, "$Array$", vbCrLf)
    getHtmlBackGroundImgList = a
End Function



Function getHandleWebHtmlLink(a, b)
    Dim c, d, e, f, g, h, i, j
    c = "<link "
    j = ""
    d = ">"
    e = GetArray(b, c, d, False, False)

    f = Split(e, "$Array$")
    For Each h In f
        If h <> "" And InStr(LCase(h), "stylesheet") > 0 Then

            h = LCase(Replace(Replace(Replace(h, """", ""), "'", ""), ">", " ")) & " "
            c = "href=" : d = " "
            If InStr(h, c) > 0 And InStr(h, d) > 0 Then
                h = StrCut(h, c, d, 2)
            End If
            i = HandleHttpUrl(h)
            If InStr(i, "/") > 0 Then
                i = Mid(i, InStrRev(i, "/") + 1)
            End If
            If LCase(i) <> "common.css" And LCase(i) <> "public.css" Then
                i = a & i
                j = j & "<link href=""" & i & """ rel=""stylesheet"" type=""text/css"" />" & vbCrLf
            End If
        End If
    Next
    If j <> "" Then j = Left(j, Len(j) - 2)
    getHandleWebHtmlLink = j
End Function



Function getCssListUrlList(a)
    Dim b, c, d, e, f, g, h, i
    b = "<link "
    h = ""
    c = ">"
    d = GetArray(a, b, c, False, False)

    e = Split(d, "$Array$")
    For Each g In e
        If g <> "" And InStr(LCase(g), "stylesheet") > 0 Then

            g = LCase(Replace(Replace(Replace(g, """", ""), "'", ""), ">", " ")) & " "
            b = "href=" : c = " "
            If InStr(g, b) > 0 And InStr(g, c) > 0 Then
                g = StrCut(g, b, c, 2)
            End If
            If InStr(vbCrLf & i & vbCrLf, vbCrLf & g & vbCrLf) = False Then
                If i <> "" Then i = i & vbCrLf
                i = i & g & vbCrLf
            End If
        End If
    Next
    getCssListUrlList = i
End Function


Function handleReadCssContent(a, b, c)
    Dim d, e, f
    d = getFText(a)

    e = "/*CssCodeStart*/"
    f = "/*CssCodeEnd*/"
    If InStr(d, e) > 0 And InStr(d, f) > 0 Then
        d = StrCut(d, e, f, 2)
    End If

    If c = True Then
        d = cssCompression(d, 0)
    End If
    If b <> "" Then
        d = "/*" & b & " start*/" & d & "/*" & b & " end*/"
    End If
    handleReadCssContent = d
End Function




Function handleCssPX(ByVal a)
    a = LCase(Trim(a))
    If Right(a, 1) <> "%" And Right(a, 2) <> "px" Then
        a = a & "px"
    End If
    handleCssPX = a
End Function





Function handleHtmlStyle(a)
    Dim b, c, d
    b = a
    d = InStr(LCase(b), "</style>") + 7
    b = Mid(b, 1, d)

    d = InStrRev(LCase(b), "<style")
    If d > 0 Then
        b = Mid(b, d)
    End If
    c = b
    c = cssCompression(c, 0) & vbCrLf
    c = removeBlankLines(c)

    a = Replace(a, b, c)
    handleHtmlStyle = a
End Function

%>



