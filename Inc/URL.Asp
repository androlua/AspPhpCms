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

















Function getThisUrlNoParam()
    Dim b
    If LCase(Request.ServerVariables("HTTPS")) = "off" Then
        b = "http://"
    Else
        b = "https://"
    End If
    getThisUrlNoParam = b & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME")
End Function


Function getGoToUrl()
    getGoToUrl = Request.ServerVariables("HTTP_REFERER")
End Function


Function getGoToUrlNoParam()
    getGoToUrlNoParam = getGoToUrl()
    If InStr(getGoToUrlNoParam, "?") > 0 Then
        getGoToUrlNoParam = Mid(getGoToUrlNoParam, 1, InStr(getGoToUrlNoParam, "?") - 1)
    End If
End Function


Function getGoToUrlNoFileName()
    getGoToUrlNoFileName = getGoToUrl()
    If Right(getGoToUrlNoFileName, 1) <> "/" Then
        If InStrRev(getGoToUrlNoFileName, "/") > 0 Then
            getGoToUrlNoFileName = Mid(getGoToUrlNoParam, 1, InStrRev(getGoToUrlNoParam, "/"))
        End If
    End If
End Function


Function getIP2()
    On Error Resume Next
    Dim b, c, d
    b = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
    c = Request.ServerVariables("REMOTE_ADDR")
    d = IIF(isNul(b) Or LCase(b) = "unknown", c, b)
    If InStr(d, ".") = 0 Then d = "0.0.0.0"
    getIP2 = d
End Function


Function getIP()
    On Error Resume Next
    Dim b
    If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" Or InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
        b = Request.ServerVariables("REMOTE_ADDR")
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then
        b = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") - 1)
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then
        b = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") - 1)
    Else
        b = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
    End If
    getIP = Trim(Mid(b, 1, 30))
End Function


Function getServicerIP()
    getServicerIP = Request.ServerVariables("LOCAL_ADDR")
End Function


Function getRemoteIP()
    getRemoteIP = getServicerIP()
End Function





Function handleHttpUrl(a)
    Dim b
    If IsNul(a) Then Exit Function
    a = Replace(Trim(a), "\", "/")
    b = Mid(a, 1, InStr(a, ":") + 2)
    a = Mid(a, InStr(a, ":") + 3)
    a = Replace(a, "http://", "【|http|】")
    a = Replace(a, "https://", "【|https|】")
    a = Replace(a, "ftp://", "【|ftp|】")

    While InStr(a, "//") > 0
        a = Replace(a, "//", "/")
    Wend
    a = Replace(a, "【|http|】", "http://")
    a = Replace(a, "【|https|】", "https://")
    a = Replace(a, "【|ftp|】", "ftp://")
    handleHttpUrl = b & a
End Function


Function handleFileUrl(a)
    a = Replace(a, "/", "\")
    Dim b
    For b = 1 To 99
        a = Replace(a, "\\", "\")

        If InStr(a, "\\") = False Then
            Exit For
        End If
    Next
    handleFileUrl = a
End Function


Function handleUrlComplete(a)
    Dim b
    handleUrlComplete = a
    If InStr(a, "?") > 0 Then Exit Function

    If Right(a, 1) <> "/" Then
        If a & "/" = GetWebSite(a) Then
            handleUrlComplete = a & "/"
            Exit Function
        End If
    End If
    b = Mid(a, InStrRev(a, "/") + 1)
    If b <> "" And InStr(b, ".") = False Then
        handleUrlComplete = a & "/"
    End If
End Function


Function urlAddHttpUrl(a, b)
    a = Replace(a, "\", "/")
    b = handleHttpUrl(b)
    If InStr(LCase(b), "http://") = 0 And InStr(LCase(b), "www.") = 0 Then
        If Right(a, 1) = "/" And Left(b, 1) = "/" Then
            b = a & Mid(b, 2)
        ElseIf Right(a, 1) <> "/" And Left(b, 1) <> "/" Then
            b = a & "/" & b
        Else
            b = a & b
        End If
    End If
    urlAddHttpUrl = b
End Function


Function webDoMain()
    Dim b, c
    b = Request.ServerVariables("SERVER_PORT")
    If b <> 80 Then b = ":" & b Else b = ""
    webDoMain = "http://" & Request.ServerVariables("SERVER_NAME") & b
End Function


Function host()
    host = "http://" & Request.ServerVariables("HTTP_HOST") & "/"
End Function


Function httpHost()
    httpHost = host()
End Function


Function getHost()
    getHost = host()
End Function


Function getUrl()
    getUrl = GetThisUrl()

End Function


Function getThisUrl()
    Dim b, c

    b = "http://" & Request.ServerVariables("server_name")

    c = Request.ServerVariables("SERVER_PORT")
    If c <> 80 Then
        b = b & ":" & c
    End If

    b = b & Request.ServerVariables("script_name")
    If Request.ServerVariables("QUERY_STRING") <> "" Then b = b & "?" & Request.ServerVariables("QUERY_STRING")

    getThisUrl = b
End Function
Function getThisUrlNoFileName()
    Dim b
    b = getThisUrl()
    If Right(b, 1) <> "/" Then
        If InStrRev(b, "/") > 0 Then
            b = Mid(b, 1, InStrRev(b, "/"))
        End If
    End If
    getThisUrlNoFileName = b
End Function


Function getWebSite(ByVal a)


    Dim b, c, d
    c = a
    b = Trim(LCase(Replace(a, "?", "/")))
    b = Replace(Replace(b, "\", "/"), "http://", "")
    If InStr(b, "/") > 0 Then b = Mid(b, 1, InStr(b, "/") - 1)
    b = "http://" & b & "/"
    Dim e, f, g
    a = Replace(LCase(a), "http://", "")
    If InStr(a, "?") > 0 Then a = Mid(a, 1, InStr(a, "?") - 1)
    If Left(a, 9) = "localhost" Then
        If InStr(a, "/") > 0 Then
            a = Mid(a, 1, InStr(a, "/") - 1)
        Else
            a = "localhost"
        End If
    ElseIf Left(a, 8) = "192.168." Or Left(a, 9) = "127.0.0.1" Then
        a = a & "/"
        a = "http://" & Mid(a, 1, InStr(a, "/") - 1) & "/"
        getWebSite = a : Exit Function
    Else
        e = Split(a, ".")
        If(InStr(a, "www.") > 0 And UBound(e) >= 2) Or UBound(e) >= 1 Then
            If InStr(a, "/") > 0 Then
                f = Mid(a, 1, InStr(a, "/") - 1)
                If f = GetDianNumb(f) Then
                    a = f
                End If
            End If
        Else
            a = ""
        End If
    End If
    d = False
    g = ".com.hk|.sh.cn|.com.cn|.net.cn|.org.cn"
    g = g & "|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in"
    e = Split(g, "|")
    For Each f In e
        If f <> "" Then
            If InStr(a, f) > 0 Then
                a = "http://" & Left(a, InStr(a, f) + Len(f) - 1) & "/" : d = True : Exit For
            End If
        End If
    Next
    getWebSite = Left(a, 255)

    If getWebSite = "http:///" Then getWebSite = ""
    If d = False Then
        getWebSite = ""
    End If

End Function

Function checkUrl(a)
    checkUrl = IIF(getWebSite(a) = "", False, True)
End Function

Function checkHttpUrl(a)
    checkHttpUrl = checkUrl(a)
End Function

Function isUrl(a)
    isUrl = checkUrl(a)
End Function

Function isHttpUrl(a)
    isHttpUrl = checkUrl(a)
End Function


Function fullHttpUrl(ByVal a, ByVal b)

    Err.Clear
    Dim c, d, e, f, g, h, i, j, k, l, m, n
    a = pHPTrim(a)
    b = pHPTrim(b)

    If b = "" Then fullHttpUrl = "" : Exit Function
    If Trim(a) = "" Then fullHttpUrl = b : Exit Function
    a = Replace(a, "\", "/")
    b = Replace(b, "\", "/")


    If Left(b, 2) = "//" Then
        fullHttpUrl = "http:" & b
        Exit Function
    End If


    c = getWebSite(a)
    l = c
    m = getWebSite(b)
    If Right(c, 1) = "/" Then c = Left(c, Len(c) - 1)
    d = Left(a, InStrRev(a, "/"))
    e = Split(a, "/")
    For f = 0 To UBound(e)
        If f + 1 = UBound(e) Then i = h
        If f + 2 = UBound(e) Then j = h
        If f + 3 = UBound(e) Then k = h
        g = e(f)
        h = h & g & "/"
    Next
    b = Trim(b)
    n = False
    If b <> "" And InStr(Left(b, 10), "www.") = False And InStr(Left(b, 10), "http://") = False And InStr(Left(b, 10), "https://") = False Then
        n = True
        If l <> m Then
            If l = Replace(m, "http://", "http://www.") Then
                n = False
                If InStr(LCase(b), "http://") > 0 Then
                    b = "http://www." & Right(b, Len(b) - 7)
                Else
                    b = "http://www." & b
                End If
            End If
        End If
    End If

    If n = True Then
        If Left(b, 1) = "/" Then
            b = c & b
        ElseIf Left(b, 9) = "../../../" Then
            b = k & Right(b, Len(b) - 9)
        ElseIf Left(b, 6) = "../../" Then
            b = j & Right(b, Len(b) - 6)
        ElseIf Left(b, 3) = "../" Then
            b = i & Right(b, Len(b) - 3)
        ElseIf Left(b, 2) = "./" Then
            b = d & Mid(b, 3)
        Else
            b = d & b
        End If
    End If
    If InStr(LCase(a), "http://") > 0 And InStr(LCase(b), "http://") = 0 Then
        b = "http://" & b
    ElseIf InStr(LCase(a), "https://") > 0 And InStr(LCase(b), "https://") = 0 Then
        b = "https://" & b
    End If
    fullHttpUrl = b
    If Err Then doError Err.Description, "FullHttpUrl 获得域名 完整网址，HttpUrl=" & a & "<hr>Url=" & b
End Function


Function batchFullHttpUrl(a, b)
    Dim c, d, e
    c = Split(b, vbCrLf)
    For Each d In c
        If Len(d) > 3 Then
            If e <> "" Then e = e & vbCrLf
            e = e & fullHttpUrl(a, d)
        End If
    Next
    batchFullHttpUrl = e
End Function



Function uRLJianJieHandle(ByVal a)
    a = Replace(a, "&amp;", "&")
    uRLJianJieHandle = a
End Function


Function urlToAsc(a)
    Dim b
    For b = 1 To Len(a)
        urlToAsc = urlToAsc & "%" & Hex(AscW(Mid(a, b, 1)))
    Next
End Function



Function getWebTitle(a)
    getWebTitle = MyStrCut(a, "<title>", "</title>", 0)
End Function


Function myStrCut(a, b, c, d)
    Dim e, f, g
    e = LCase(a)
    If InStr(e, b) > 0 And InStr(e, c) > 0 Then
        f = InStr(e, b) + Len(b)
        g = InStr(e, c) - f
        myStrCut = Mid(a, f, g)
        If d = 1 Or d = 3 Then myStrCut = b & myStrCut
        If d = 2 Or d = 3 Then myStrCut = myStrCut & c
    End If
End Function


Function getContentAHref(a, b, c, d)
    Dim e, f, g, h, i, j, k
    For e = 1 To Len(b)
        f = Mid(b, e, 1)
        If f = "<" Then
            g = LCase(Mid(b, e))
            h = LCase(Mid(g, 1, InStr(g, " ")))
            If h = "<a " Then
                j = Mid(g, 1, InStr(g, "</") + 2)
                i = Len(j) - 1
                k = k & HandleLink(a, j, "href", "", "url", c, d) & vbCrLf
                e = e + i
            End If
        End If
        DoEvents
    Next
    If k <> "" Then k = Left(k, Len(k) - 2)
    getContentAHref = k
End Function


Function getContentImgSrc(a, b, c, d)
    Dim e, f, g, h, i, j, k
    For e = 1 To Len(b)
        f = Mid(b, e, 1)
        If f = "<" Then
            g = LCase(Mid(b, e))
            h = LCase(Mid(g, 1, InStr(g, " ")))
            If h = "<img " Then
                j = Mid(g, 1, InStr(g, ">"))
                i = Len(j) - 1

                k = k & HandleLink(a, j, "src", "", "url", c, d) & vbCrLf
                e = e + i
            End If
        End If
        DoEvents
    Next
    If k <> "" Then k = Left(k, Len(k) - 2)
    getContentImgSrc = k
End Function


Function handleConentUrl(a, b, c, d)
    Dim e, f, g, h, i, j, k, l
    For e = 1 To Len(b)
        f = Mid(b, e, 1)
        If f = "<" Then
            g = Mid(b, e)
            h = LCase(g)
            h = Replace(Replace(h, Chr(10), " " & vbCrLf), Chr(13), " " & vbCrLf)
            k = Mid(g, 1, InStr(g, ">"))
            i = LCase(Mid(h, 1, InStr(h, " ")))
            If i = "<link " Then
                j = Len(k) - 1
                l = l & HandleLink(a, k, "href", "", "", c, d)
                e = e + j
            ElseIf i = "<img " Then
                j = Len(k) - 1
                l = l & HandleLink(a, k, "src", "", "", c, d)
                e = e + j
            ElseIf i = "<a " Then
                j = Len(k) - 1

                If InStr(LCase(k), "javascript:") = 0 Then
                    l = l & HandleLink(a, k, "href", "", "", c, d)
                Else
                    l = l & k
                End If
                e = e + j
            ElseIf i = "<script " Then
                j = Len(k) - 1
                If InStr(LCase(k), "src") > 0 Then
                    l = l & HandleLink(a, k, "src", "", "", c, d)
                Else
                    l = l & k
                End If
                e = e + j
            ElseIf i = "<embed " Then
                j = Len(k) - 1
                l = l & HandleLink(a, k, "src", "", "", c, d)
                e = e + j
            ElseIf i = "<param " Then
                j = Len(k) - 1
                If InStr(LCase(k), "movie") > 0 Then
                    l = l & HandleLink(a, k, "value", "", "", c, d)
                Else
                    l = l & k
                End If
                e = e + j
            ElseIf i = "<meta " Then
                j = Len(k) - 1

                If InStr(LCase(k), "keywords") > 0 Then
                    l = l & HandleLink(a, k, "content", WebKeywords, "", c, d)

                ElseIf InStr(LCase(k), "description") > 0 Then
                    l = l & HandleLink(a, k, "content", WebDescription, "", c, d)
                Else
                    l = l & k
                End If
                e = e + j
            Else
                l = l & f
            End If
        Else
            l = l & f
        End If
        DoEvents
    Next
    handleConentUrl = l
End Function



Function replaceContentJsDir(a, b, c, d)
    Dim e, f, g
    e = Split(a, vbCrLf)
    For Each f In e
        If g <> "" Then g = g & vbCrLf
        If InStr(f, "<script ") > 0 And InStr(f, "</script>") > 0 Then
            f = HandleLink(b, f, "src", "", "replaceDir", c, d)
        End If
        g = g & f
    Next
    replaceContentJsDir = g
End Function




Function handleLink(a, b, c, d, e, f, g)
    On Error Resume Next
    Dim h, i, j, k, l, m, n, o, p, q, r, s
    s = a
    e = LCase(e)
    b = Replace(Replace(b, "= ", "="), "= ", "=")
    b = Replace(Replace(b, " =", "="), " =", "=")
    l = LCase(b)

    If InStr(l, " href=") = 0 And InStr(l, " src=") = 0 Then
        handleLink = ""
        Exit Function
    ElseIf InStr(l, " href=\""") > 0 Then
        b = Replace(b, "\""", """") : l = LCase(b)
    End If
    o = c & "="""
    p = """"
    If InStr(l, o) > 0 And InStr(l, p) > 0 Then
        m = StrCut(b, o, p, 2)
        If d <> "" Then
            n = d
        Else
            n = fullHttpUrl(a, m)

            If e = "replacedir" Then
                n = s & HandleFilePathArray(n)(2)
            End If
            f = f & n & vbCrLf

            q = InStr(b, ">")
            r = Right(b, Len(b) - q)
            r = Mid(r, 1, InStrRev(r, "</") - 1)
            r = Replace(r, vbCrLf, "【换行】")
            g = g & r & vbCrLf
        End If
        If m <> n Then

            q = InStr(b, o) - 1 + Len(o)
            r = Right(b, Len(b) - q)
            r = Mid(r, InStr(r, p))
            q = Left(b, q)
            b = q & n & r
        End If
        If e = "url" Then
            handleLink = n
        Else
            handleLink = b
        End If
        Exit Function
    End If
    o = c & "='"
    p = "'"
    If InStr(l, o) > 0 And InStr(l, p) > 0 Then
        m = StrCut(l, o, p, 2)
        If d <> "" Then
            n = d
        Else
            n = fullHttpUrl(a, m)

            If e = "replacedir" Then
                n = s & HandleFilePathArray(n)(2)
            End If
            f = f & n & vbCrLf

            q = InStr(b, ">")
            r = Right(b, Len(b) - q)
            r = Mid(r, 1, InStrRev(r, "</") - 1)
            r = Replace(r, vbCrLf, "【换行】")
            g = g & r & vbCrLf
        End If
        If m <> n Then

            q = InStr(b, o) - 1 + Len(o)
            r = Right(b, Len(b) - q)
            r = Mid(r, InStr(r, p))
            q = Left(b, q)
            b = q & n & r
        End If
        If e = "url" Then
            handleLink = n
        Else
            handleLink = b
        End If
        Exit Function
    End If
    o = c & "="
    p = " "
    If InStr(l, o) > 0 And InStr(l, p) > 0 Then
        m = StrCut(l, o, p, 2)
        If d <> "" Then
            n = d
        Else
            n = fullHttpUrl(a, m)

            If e = "replacedir" Then
                n = s & HandleFilePathArray(n)(2)
            End If
            f = f & n & vbCrLf

            q = InStr(b, ">")
            r = Right(b, Len(b) - q)
            r = Mid(r, 1, InStrRev(r, "</") - 1)
            r = Replace(r, vbCrLf, "【换行】")
            g = g & r & vbCrLf
        End If
        If m <> n Then

            q = InStr(b, o) - 1 + Len(o)
            r = Right(b, Len(b) - q)
            r = Mid(r, InStr(r, p))
            q = Left(b, q)
            b = q & n & r
        End If
        If e = "url" Then
            handleLink = n
        Else
            handleLink = b
        End If
        Exit Function
    End If
    If e <> "url" Then handleLink = b
    Call CreateAddFile("出错内容列表.txt", a & vbCrLf & b & vbCrLf & c & vbCrLf & d & vbCrLf & e & vbCrLf & "----------------------" & vbCrLf)
End Function


Function getEndUrlHandleName(a)
    Dim b
    b = Replace(Trim(a), "\", "/")
    If Right(b, 1) = "/" Then b = Mid(b, 1, Len(b) - 1)
    b = Mid(b, InStrRev(b, "/") + 1)
    getEndUrlHandleName = b
End Function


Function getWebFolderName()
    If getIP = "127.0.0.1" Or InStr(getIP, "192.168.") > 0 Then
        getWebFolderName = "/wwwroot/" & WebFolderName & "/"
    End If
End Function


Function getWebHome()
    Dim b
    If getIP = "127.0.0.1" Or InStr(getIP, "192.168.") > 0 Then
        Call OpenConn()
        rs.Open "Select * From [WebSite]", conn, 1, 1
        If Not rs.EOF Then
            getWebHome = "/wwwroot/" & getEndUrlHandleName(rs("WebSkins")) & "/Index.html"
        End If : rs.Close
    End If
    If getWebHome = "" Then
        getWebHome = "/Index.html"
    End If
End Function


Function getUrlListInWebSiteList(a)
    Dim b, c, d
    d = Split(a, vbCrLf)
    For Each b In d
        b = getWebSite(b)
        If b <> "" And InStr(vbCrLf & c & vbCrLf, vbCrLf & b & vbCrLf) = 0 Then
            c = c & b & vbCrLf
        End If
        Doevents
    Next
    getUrlListInWebSiteList = c
End Function


Function getThisUrlFileName()
    Dim b
    b = Request.ServerVariables("SCRIPT_NAME")
    If Left(b, 1) = "/" Then b = Right(b, Len(b) - 1)
    getThisUrlFileName = b
End Function


Function handleWebHtmlImg(a, b, c, d)
    Dim e, f, g, h
    Dim i, j
    e = getContentImgSrc("", b, c, d)
    f = Split(e, vbCrLf)
    For Each g In f
        If g <> "" Then
            h = handleHttpUrl(g)
            If InStr(h, "/") > 0 Then
                h = Mid(h, InStrRev(h, "/") + 1)
            End If
            h = a & h

            i = "src=""" : j = """"
            If InStr(b, i) > 0 And InStr(b, j) > 0 Then
                b = RegExp_Replace(b, i & g & j, i & h & j)
            End If
            i = "src='" : j = "'"
            If InStr(b, i) > 0 And InStr(b, j) > 0 Then
                b = RegExp_Replace(b, i & g & j, i & h & j)
            End If
        End If
    Next
    handleWebHtmlImg = b
End Function


Function handleWebCssImg(a, b)
    Dim c, d, e, f, g, h, i
    c = "url\("
    d = "\)"
    e = GetArray(b, c, d, False, False)

    f = Split(e, "$Array$")
    For Each h In f
        If h <> "" Then
            i = handleHttpUrl(h)
            If InStr(i, "/") > 0 Then
                i = Mid(i, InStrRev(i, "/") + 1)
            End If
            i = a & i
            c = "url("
            d = ")"
            If InStr(b, c) > 0 And InStr(b, d) > 0 Then

                b = RegExp_Replace(b, c & h & d, c & i & d)
            End If
        End If
    Next
    handleWebCssImg = b
End Function


Function batchHandleUrlIntegrity(a, b)
    Dim c, d, e
    c = Split(b, vbCrLf)
    For Each d In c
        If d <> "" Then
            d = fullHttpUrl(a, d)
            If InStr(vbCrLf & e & vbCrLf, vbCrLf & d & vbCrLf) = False Then
                e = e & d & vbCrLf
            End If
        End If
    Next
    batchHandleUrlIntegrity = e
End Function


Function replaceContentImagePath(a, b)
    Dim c, d, e, f
    a = handleHttpUrl(a)
    If Right(a, 1) <> "/" Then a = a & "/"
    e = GetDirFileNameList(a)
    f = Split(e, vbCrLf)
    For Each c In f
        If c <> "" Then
            d = "file:///" & a & c

            b = Replace(b, """" & c & """", """" & d & """")
            b = Replace(b, "'" & c & "'", """" & d & """")
            b = Replace(b, "=" & c & " ", """" & d & """")
            b = Replace(b, "=" & c & ">", """" & d & """")

            b = Replace(b, "(" & c & ")", "(" & d & ")")
            b = Replace(b, "(" & c & ";", "(" & d & ";")
        End If
    Next
    replaceContentImagePath = b
End Function


Function getCssLinkList(ByVal a)
    Dim b, c, d, e, f, g
    b = "<link" : c = "/>"
    a = GetArray(a, b, c, False, False)
    d = Split(a, "$Array$")
    For Each e In d
        If InStr(LCase(e), "stylesheet") > 0 Then
            g = StrCut(e, "href=""", """", 2)
            Call echo(g, e)
            f = f & g & vbCrLf
        End If
    Next
    getCssLinkList = f
End Function


Function getHtmlBackGroundUrlList(a)
    Dim b, c, d, e, f, g, h, i, j, k
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If c = "<" Then
            d = Mid(a, b)
            e = LCase(d)
            h = Mid(d, 1, InStr(d, ">"))
            f = LCase(Mid(e, 1, InStr(e, " ")))
            If InStr(h, "url(") > 0 Then
                j = "url(" : k = ")"
                i = i & StrCut(h, j, k, 2) & vbCrLf
                b = b + g
            End If
        End If
        DoEvents
    Next
    getHtmlBackGroundUrlList = i
End Function


Function getImgUrlList(a)
    Dim b, c, d, e, f, g, h, i
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If c = "<" Then
            d = Mid(a, b)
            e = LCase(d)
            h = Mid(d, 1, InStr(d, ">"))
            f = LCase(Mid(e, 1, InStr(e, " ")))
            If f = "<img " Then
                i = i & GetLinkUrl(h, "src") & vbCrLf
                b = b + g

            End If
        End If
        DoEvents
    Next
    getImgUrlList = i
End Function


Function getLinkUrl(ByVal a, b)
    Dim c, d, e, f
    a = Replace(Replace(a, "= ", "="), "= ", "=")
    a = Replace(Replace(a, " =", "="), " =", "=")
    c = LCase(a)

    d = b & "="""
    e = """"
    If InStr(c, d) > 0 And InStr(c, e) > 0 Then
        f = StrCut(c, d, e, 2)
        getLinkUrl = f
    End If
End Function


Function localUrlOrRemoteUrl(a, b)
    Dim c
    b = False
    a = Trim(a)
    c = Replace(a, "\", "/")
    If Left(LCase(c), 7) = "http://" Or Left(LCase(c), 4) = "www." Or Left(LCase(c), 4) = "[网址]" Then
        b = True
    End If
    If b = False Then
        a = SetFileName(a)
    End If
    localUrlOrRemoteUrl = a
End Function


Function checkRemoteUrl(a)
    Dim b
    a = Trim(a)
    b = Replace(UnSetFileName(a), "\", "/")
    checkRemoteUrl = False
    If Left(LCase(b), 7) = "http://" Or Left(LCase(b), 4) = "www." Or Left(LCase(b), 4) = "[网址]" Then
        If Left(LCase(b), 4) = "[网址]" Then
            a = Mid(a, InStr(a, "[网址]") + 1)
        End If
        checkRemoteUrl = True
    End If
End Function


Function getHandleUrl(ByVal a)
    Dim b
    a = CStr(Trim(a))
    If a <> "" Then
        a = Replace(Trim(a), "\", "/")
        If InStr(a, "://") = False Then a = Replace(Replace(a, "//", "/"), "//", "/")
    End If
    If Left(a, 1) <> "/" And Right(a, 1) <> "/" Then
        a = "/Html/" & a & ".Html"
    ElseIf Right(LCase(a), 4) <> ".html" Then
        b = Mid(a, InStrRev(a, "/") + 1)
        If InStr(b, ".") = False Then
            If b <> "" Then
                a = a & ".Html"
            End If
        End If
    End If
    getHandleUrl = a
End Function


Function webDebug(a, b)
    If Request.QueryString("Debug") <> "" Then
        If getwebsite(b) <> "" Then
            a = b
            webDebug = a
            Exit Function
        Else
            a = "/Inc/Create_Html.Asp?Debug=1&" & b
        End If
        If Request("MackHtml") = "False" Then
            a = a & "&MackHtml=False"
        End If
        If Request("gl") <> "" Then
            a = a & "&gl=" & Request("gl")
        End If
    Else
        If CheckMakeHtmlFile(a) = True Then
            a = LCase(a)
        End If
    End If
    If CheckMakeHtmlFile(a) = True Then
        a = fullHttpUrl(host(), a)
    Else

        a = Trim(a)
        If Left(LCase(a), 4) = "url:" Then
            a = Mid(a, 5)
        End If
        If Left(LCase(a), 5) = "/url:" Then
            a = Mid(a, 6)
        End If
        a = HandleTemplateAction(a, False)

    End If

    webDebug = a
End Function




Function asaiLinkAdd(a)
    Dim b
    a = " " & a
    Set b = CreateObject("VBscript.RegExp")
        b.IgnoreCase = True
        b.Global = True

        b.pattern = "(http://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?)"
        a = b.Replace(a, "<a href='$1' target='_blank'>$1</a>")

        b.pattern = "([^(http:\/\/)])(www\.([\w-]+\.)+[\w]+(\/[\w-]+)*[\/]?([\w-]+\.[\w]+)?(\?[\w]+=[\w]+(&[\w]+=[\w]+)*)?)"
        a = b.Replace(a, "$1<a href='http://$2' target='_blank'>$2</a>")

        b.pattern = "(mailto:)?([\w]+@([\w-]+\.)+[\w]+)"
        a = b.Replace(a, "<a href='mailto:$2'>$1$2</a>")
    Set b = Nothing
    asaiLinkAdd = Replace(Trim(a), " </a>", "")
    asaiLinkAdd = Replace(Trim(a), " ;</a>", "")
    asaiLinkAdd = Replace(Trim(a), " ；</a>", "")
End Function




Function asaiLinkDel(a)
    Dim b
    Set b = CreateObject("VBscript.RegExp")
        b.IgnoreCase = True
        b.Global = True
        b.pattern = "<a[^>]+>(.+?)<\/a>"
        asaiLinkDel = b.Replace(a, "$1")
End Function


Function iswww(a)
    iswww = False
    Dim b, c
    Set b = CreateObject("VBscript.RegExp")
        b.pattern = "^\w+((-\w+)|(\.\w+))*[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$"
        b.IgnoreCase = True
        Set c = b.Execute(a)
            If c.Count Then iswww = True
End Function








Function getUrlAddToParam(ByVal a, ByVal b, c)
    Dim d, e, f, g, h, i, j, k
    Dim l
    Dim m
    Dim n
    Dim o
    Dim p

    b = handleHttpUrl(b)


    a = Trim(a)

    If Right(a, 1) = "?" Or Right(a, 1) = "&" Then
        a = Trim(Mid(a, 1, Len(a) - 1))
    End If

    b = Trim(b)

    If Left(b, 1) = "?" Or Left(b, 1) = "&" Then
        b = Trim(Mid(b, 2))
    End If

    If a = "" Then getUrlAddToParam = "?" & b : Exit Function

    i = a
    If InStr(a, "?") > 0 Then
        i = Mid(a, 1, InStr(a, "?") - 1)
        k = getWebSite(a)
        l = Mid(a, InStr(a, "?") + 1)

        i = handleHttpUrl(i)
        If Right(i, 1) <> "/" Then
            j = Mid(i, InStrRev(i, "/") + 1)
            i = Left(i, Len(i) - Len(j))

        End If
    End If


    If LCase(c) = "replace" Or c = "替换" Then
        d = b & "&" & l

        If InStr(b, "?") > 0 Then
            j = Mid(b, 1, InStr(b, "?") - 1)

        End If
    ElseIf(LCase(c) <> "delete" Or LCase(c) <> "del") Then
        d = l & "&" & b
    End If

    d = Replace(d, "?", "&")


    If LCase(c) = "delete" Or LCase(c) = "del" Then
        e = Split(LCase(b), "&") : b = "&"
        For Each g In e
            If InStr(g, "=") Then
                g = Mid(g, 1, InStr(g, "=") - 1)
            End If
            If g <> "" Then
                b = b & g & "&"
            End If
        Next

    End If


    e = Split(d, "&")
    For Each g In e
        If InStr(g, "=") > 0 Then
            f = Split(g, "=")
            m = f(0)
            n = f(1)

            p = True

            If LCase(c) = "delete" Or LCase(c) = "del" Then
                If InStr("&" & b & "&", "&" & LCase(m) & "&") > 0 Then
                    p = False
                End If
            End If

            If InStr("|" & o & "|", "|" & LCase(m) & "|") = False And p = True Then
                o = o & LCase(m) & "|"
                h = h & IIF(h = "", "?", "&")
                h = h & m & "=" & n
            End If
        End If
    Next



    h = j & h
    If getWebSite(h) = "" Then
        If Left(b, 1) = "/" Then
            h = k & h
        Else
            h = i & h
        End If

    End If


    getUrlAddToParam = h
End Function





Function groupUrl(a, b)
    Dim c, d
    c = "/"
    a = Replace(a, IIF(c = "/", "\", "/"), c)
    b = Replace(b, IIF(c = "/", "\", "/"), c)
    a = phptrim(a)
    b = phptrim(b)
    For d = 0 To 99
        If Right(a, 1) = c Then
            a = Mid(a, 1, Len(a) - 1)
        Else
            Exit For
        End If
    Next
    For d = 0 To 99
        If Left(b, 1) = c Then
            b = Mid(b, 2)
        Else
            Exit For
        End If
    Next
    groupUrl = a & c & b
End Function




Function handlePostCookiesParame(a, b)
    Dim c, d, e, f, g
    c = Split(a, "&")
    For Each d In c
        If InStr(d, "=") > 0 Then
            f = Mid(d, 1, InStr(d, "="))
            g = Mid(d, InStr(d, "=") + 1)
            If LCase(b) = "post" Or b = "" Then
                If e <> "" Then e = e & "&"
                g = escape(g)
            ElseIf LCase(b) = "cookies" Or LCase(b) = "cookie" Then
                If e <> "" Then e = e & ";"
                g = URLEncoding(g)
            End If
            e = e & f & g

        End If
    Next
    handlePostCookiesParame = e
End Function



Function remoteHttpUrlParameter(a)
    Dim b, c, d, e, f

    If InStr(a, "?") = False Then
        remoteHttpUrlParameter = a
        Exit Function
    End If
    b = Split(a, "&")
    For Each c In b
        If InStr(c, "=") > 0 Then
            e = Mid(c, 1, InStr(c, "="))
            f = Mid(c, InStr(c, "=") + 1)
            If d <> "" Then d = d & "&"
            d = d & e
        End If
    Next
    remoteHttpUrlParameter = d
End Function




Function checkUrlName(a)
    Dim b, c, d
    a = LCase(a)
    d = LCase(Request.ServerVariables("script_name"))
    b = Split(a, "|")
    For Each c In b
        If c <> "" Then
            If InStr(d, c) > 0 Then
                checkUrlName = True
                Exit Function
            End If
        End If
    Next
    checkUrlName = False
End Function















Function handleHttpUrlArray(ByVal a)
    Dim b, c, d, e, f, g, h
    a = handleHttpUrl(a)

    b = Mid(a, 1, InStrRev(a, "/"))
    e = Mid(a, InStrRev(a, "/") + 1) : c = e
    If InStr(e, "?") > 0 Then
        c = Mid(e, 1, InStr(e, "?") - 1)
    End If
    d = Mid(c, InStrRev(c, ".") + 1)
    f = Mid(a, 1, InStr(a, ":") - 1)
    g = getWebSite(a)
    h = Mid(b, Len(g))

    Dim i
    i = Split(a & vbCrLf & b & vbCrLf & c & vbCrLf & d & vbCrLf & e & vbCrLf & f & vbCrLf & g & vbCrLf & h, vbCrLf)
    handleHttpUrlArray = i
End Function



Function remoteJsCssParam(a, b)
    remoteJsCssParam = handleRemoteJsCssParam(a, b, "|替换内容|替换网址")
End Function


Function handleRemoteJsCssParam(a, b, c)
    Dim d, e, f, g, h, i, j, k
    c = "|" & c & "|"
    d = Split(b, vbCrLf)
    For Each f In d
        If f <> "" Then
            If e <> "" Then e = e & vbCrLf
            g = handleHttpUrlArray(f)
            h = g(2)
            i = LCase(g(3))
            j = LCase(g(4))
            If(i = "js" Or i = "css") And InStr(j, "?") > 0 Then
                k = Mid(f, 1, InStr(f, "?") - 1)


                If InStr(c, "|替换内容|") > 0 Then
                    a = Replace(a, f, k)
                End If
                If InStr(c, "|替换网址|") > 0 Then
                    b = Replace(b, f, k)
                End If
            End If
        End If
    Next
End Function



Function batchHandleHttpUrlComplete(a, b)
    Dim c, d, e, f, g
    c = getwebsite(a)
    d = Split(b, vbCrLf)
    For Each e In d
        e = phptrim(e)
        f = LCase(e)
        If f <> "#" And Left(f, 11) <> "javascript:" Then
            If InStr(vbCrLf & LCase(g) & vbCrLf, vbCrLf & f & vbCrLf) = False Then
                If g <> "" Then g = g & vbCrLf
                g = g & urlAddHttpUrl(c, e)
            End If
        End If
    Next
    batchHandleHttpUrlComplete = g
End Function



Function isWebSite(ByVal a, ByVal b)
    isWebSite = handleIsWebSite(a, b, "")
End Function

Function isSonWebSite(ByVal a, ByVal b)
    isSonWebSite = handleIsWebSite(a, b, "子域名")
End Function


Function handleIsWebSite(ByVal a, ByVal b, c)
    a = getwebsite(a)
    b = getwebsite(b)
    If InStr(a, "://") > 0 Then
        a = Mid(a, InStr(a, "://") + 3)
    End If
    If Left(a, 4) = "www." Then
        a = Mid(a, 5)
    End If
    If InStr(b, "://") > 0 Then
        b = Mid(b, InStr(b, "://") + 3)
    End If
    If Left(b, 4) = "www." Then
        b = Mid(b, 5)
    End If

    If c = "子域名" Then
        Dim d, e, f
        f = ".com.hk|.sh.cn|.com.cn|.net.cn|.org.cn"
        f = f & "|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in"
        d = Split(f, "|")
        For Each e In d
            If e <> "" Then
                a = Replace(a, e, "")
                b = Replace(b, e, "")
            End If
        Next

        If InStr(a, ".") Then
            a = Mid(a, InStr(a, ".") + 1)
        End If
        If InStr(b, ".") Then
            b = Mid(b, InStr(b, ".") + 1)
        End If


    End If
    handleIsWebSite = False
    If a = b Then
        handleIsWebSite = True
    End If
End Function



Function getContentUrlList(a, ByVal b)
    getContentUrlList = HandleGetContentUrlList(a, b, "|*|内链|")
End Function

Function handleGetContentUrlList(a, ByVal b, c)
    Dim d, e, f, g, h, i, j, k, l, m, n, o, p, q
    c = "|" & LCase(Trim(c)) & "|"
    n = getwebsite(a)
    For d = 1 To Len(b)
        e = Mid(b, d, 1)
        f = Mid(b & " ", d + 1, 1)
        h = Mid(b, d + 1) : g = LCase(h)
        If e = "<" Then
            l = ""
            o = ""
            p = False
            If Left(g, 2) = "a " Then
                o = "a"
                q = "href"
                p = True
            ElseIf Left(g, 5) = "link " Then
                o = "link"
                q = "href"
                p = True
            ElseIf Left(g, 4) = "img " Then
                o = "img"
                q = "src"
                p = True
            ElseIf Left(g, 7) = "script " Then
                o = "script"
                q = "src"
                p = True
            End If
            If p = True Then
                If InStr(c, "|" & o & "|") > 0 Or InStr(c, "|*|") > 0 Then
                    j = InStr(h, ">")
                    i = Mid(h, 1, j)
                    l = RParam(i, q)
                    d = d + j
                End If
            End If
            If l <> "" Then
                m = LCase(l)
                If m <> "#" And Left(m, 11) <> "javascript:" Then
                    If InStr(vbCrLf & k & vbCrLf, vbCrLf & l & vbCrLf) = False Then
                        l = fullHttpUrl(a, l)
                        p = isSonWebSite(l, a)
                        If InStr(c, "|内链|") > 0 Then
                            If p = True Then
                                k = k & l & vbCrLf
                            End If
                        ElseIf InStr(c, "|外链|") > 0 Then
                            If p = False Then
                                k = k & l & vbCrLf
                            End If
                        Else
                            k = k & l & vbCrLf
                        End If
                    End If
                End If
            End If
        End If
    Next
    If k <> "" Then k = Left(k, Len(k) - 2)
    handleGetContentUrlList = k
End Function

Function getInChain(a, b)
    Dim c, d, e, f, g
    c = Split(b, vbCrLf)
    b = ""
    For Each d In c
        If d <> "" Then
            f = LCase(d)
            If Left(f, 1) <> "#" And Left(f, 11) <> "javascript:" Then
                If InStr(vbCrLf & b & vbCrLf, vbCrLf & d & vbCrLf) = False Then
                    d = fullHttpUrl(a, d)
                    g = isSonWebSite(d, a)
                    If g = True Then
                        b = b & d & vbCrLf
                    End If
                End If
            End If
        End If
    Next
    If b <> "" Then b = Left(b, Len(b) - 2)
    getInChain = b
End Function
%>


