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


Function SaveRemoteFile(ByVal a, ByVal b)
    On Error Resume Next
    SaveRemoteFile = 0
    Dim c, d, e
    Call HandlePath(b)
    Set d = CreateObject("Microsoft.XMLHTTP")
        With d
            .Open "Get", a, False, "", ""
            .send
            If Err Then
                SaveRemoteFile = 9999 : Exit Function
            End If
            e =.responseBody
            SaveRemoteFile =.Status
        End With
    Set d = Nothing
    Set c = CreateObject("ADODB.Stream")
        With c
            .Type = 1
            .Open
            .Write e

            .SaveToFile b, 2
            .Cancel
            .Close
        End With
    Set c = Nothing
    If Err Then DoError Err.Description, "SaveRemoteFile 下载远程文件 函数出错，RemoteFileUrl=" & a & "<hr>LocalFileName=" & b
End Function



Function DownFile(a, b)
    DownFile = SaveRemoteFile(a, b)
End Function



Function popupDownFile(a)
    Dim b, c
    Call HandlePath(a)
    Response.Clear
    Set b = CreateObject("ADODB.Stream")
        b.Open
        b.Type = 1
        b.LoadFromFile a
        c = InStrRev(a, "\") + 1
        Response.AddHeader "Content-Disposition", "attachment; filename=" & Mid(a, c)
        Response.AddHeader "Content-Length", b.Size
        Response.Charset = "UTF-8"
        Response.ContentType = "application/octet-stream"
        Response.BinaryWrite b.Read
        Response.Flush
        Response.Write("")
        b.Close
    Set b = Nothing
End Function





Function XMLGetStatus(ByVal a)
    On Error Resume Next
    Dim b
    Set b = CreateObject("Microsoft.XMLHTTP")
        With b
            .Open "Get", a, False
            .setRequestHeader "cache-control", "no-cache"
            .setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
            .send
            XMLGetStatus =.Status
        End With
    Set b = Nothing




End Function





Function XMLPost(a, b)
    XMLPost = HandleXMLPost(a, b, "gb2312")(0)
End Function



Function UTFXMLPost(a, b)
    UTFXMLPost = HandleXMLPost(a, b, "utf-8")(0)
End Function



Function HandleXMLPost(ByVal a, ByVal b, c)
    Dim d, dataArray(6), f
    c = handleStrCharSet(c)
    Set d = CreateObject("Microsoft.XMLHTTP")
        Call d.Open("POST", a, False)
        Call d.setRequestHeader("cache-control", "no-cache")
        Call d.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        Call d.setRequestHeader("Connection", "close")

        Call d.send(b)
        If d.ReadyState <> 4 Then
            f = "error"
        Else
            f = BytesToBstr(d.responseBody, c)

        End If
        dataArray(0) = f
        dataArray(1) = d.Status
        dataArray(2) = d.responseBody			
        HandleXMLPost = dataArray
    Set d = Nothing
End Function



Function XmlGet(ByVal a)
    XmlGet = handleXmlGet(a, "gb2312")(0)
End Function



Function handleXmlGet(ByVal a, b)

    Dim c, dataArray(1), e

    b = handleStrCharSet(b)
    Set c = CreateObject("Microsoft.XMLHTTP")
        Call c.Open("Get", a, False)
        Call c.setRequestHeader("cache-control", "no-cache")
        Call c.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        Call c.SetRequestHeader("Cookie", "Admin%5FPassWord=admin; Admin%5FUserName=admin; CNZZDATA5865366=cnzz_eid%3D1338721452-1438760869-%26ntime%3D1438760869; style=default; sswbr=1; Hm_lvt_c39492dd0d3beab26d196a53cbd72d54=1440725802,1442725700; BD_UPN=112451; ASPSESSIONIDSCDQDRAC=CNOHMAHANIPHOFLHKCIKFIGH")
        Call c.send
        If c.ReadyState <> 4 Then
            e = "error"
        Else

            e = BytesToBstr(c.responseBody, b)

        End If
        dataArray(0) = e
        dataArray(1) = c.Status
    Set c = Nothing
    If Err Then
        dataArray(0) = ""
        dataArray(1) = -1
    End If
    handleXmlGet = dataArray
End Function



Function CookiesPost(a, b)
    CookiesPost = handleCookiesPost(a, b, "gb2312")
End Function



Function handleCookiesPost(a, b, c)
    Dim d, dataArray(1), f
    c = handleStrCharSet(c)
    b = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;" & b
    Set d = CreateObject("msxml2.serverXMLHTTP")
        Call d.Open("POST", a, False)

        Call d.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")

        Call d.setRequestHeader("Cookie", b)
        Call d.send
        If d.ReadyState <> 4 Then
            f = "error"
        Else
            f = BytesToBstr(d.Responsebody, c)

        End If
        dataArray(0) = f
        dataArray(1) = d.Status
    Set d = Nothing
    handleCookiesPost = dataArray
End Function





Function getRemoteFileSize(a)
    Dim b
    Set b = CreateObject("MSXML2.XMLHTTP")
        With b
            .Open "get", a, False
            call .setRequestHeader("range", "bytes=-1")
            .send
            getRemoteFileSize = Split(.getResponseHeader("Content-Range"), "/")(1)
        End With
    Set b = Nothing
End Function





Function DownRemoteFile(a)
    Dim b, c
    Call HandlePath(a)
    Response.Clear
    Set b = CreateObject("ADODB.Stream")
        With b
            .Open
            .Type = 1
            .LoadFromFile a
            c = InStrRev(a, "\") + 1
            Response.AddHeader "Content-Disposition", "attachment; filename=" & Mid(a, c)
            Response.AddHeader "Content-Length",.Size
            Response.Charset = "UTF-8"
            Response.ContentType = "application/octet-stream"
            Response.BinaryWrite.Read
            Response.Flush
            Response.Write("")
            .Close
        End With
    Set b = Nothing
End Function






Function ImagesToBase64(a)
    Dim b
    Dim c
    Dim d
    Dim e
    Dim f
    Dim g
    Dim h
    Dim i


    e = HandlePath(a)
    i = Mid(e, InStrRev(e, ".") + 1)
    Set g = CreateObject("msxml2.FreeThreadedDOMDocument")

        call g.loadxml("<?xml version='1.0'?><Base64Data />")
        Set d = CreateObject("Scripting.FileSystemObject")
            If d.FileExists(e) Then

                Set f = CreateObject("ADODB.Stream")
                    f.Type = 1
                    f.Open
                    call f.LoadFromFile(e)


                    g.documentElement.DataType = "bin.base64"
                    g.documentElement.nodeTypedValue = f.Read


                    Set b = CreateObject("msxml2.FreeThreadedDOMDocument")
                        call b.Load(g)
                        If b.ReadyState > 2 Then
                            Set c = b.getElementsByTagName("Base64Data")


                                h = c.Item(0).Text
                        Else
                            h = ""
                        End If
                            Set b = Nothing
                    Set f = Nothing
            Else
                h = ""
            End If

                Set d = Nothing
        Set g = Nothing


        ImagesToBase64 = h
End Function




Function Base64ToImages(a, b)
    Dim c
    a = HandlePath(a)
    c = "<data>" & b & "</data>"
    Dim d : Set d = CreateObject("MSXML2.DOMDocument")
        Dim e : Set e = CreateObject("ADODB.Stream")
            d.resolveExternals = False
            Call d.loadxml(c)
            Call d.documentElement.setAttribute("xmlns:dt", "urn:schemas-microsoft-com:datatypes")
            d.documentElement.DataType = "bin.base64"
            e.Type = 1
            e.Open
            Call e.Write(d.documentElement.nodeTypedValue)
            Call e.SaveToFile(a)
            e.Close
        Set d = Nothing
    Set e = Nothing
End Function



























Function getSqlInContent(a, b, c, d)
    getSqlInContent = handleSqlIn(a, b, c, d, "gb2312")(0)
End Function



Function handleSqlIn(a, b, c, d, e)
    Dim f, dataArray				
    c = LCase(c)

    If c = "post" Then
        dataArray = HandleXMLPost(a, handlePostCookiesParame(b, "post"), e)

    ElseIf c = "get" Then
        b = HandlUrlCanShu(b)
        dataArray = handleXmlGet(a & b, e)


    ElseIf c = "cookies" Then
        dataArray = handleCookiesPost(a, handlePostCookiesParame(b, "cookies"), e)

    End If
    If CStr(d) = "0" Then
        dataArray(0) = Replace(dataArray(0), "<", "&lt;")
    ElseIf CStr(d) = "1" Then
        dataArray(0) = Replace(dataArray(0), "<br>", vbCrLf)
        dataArray(0) = DelHtml(dataArray(0))
    End If
    handleSqlIn = dataArray
End Function




Function SqlInUrl(ByVal a)
    Dim b, c, d
    SqlInUrl = False
    c = False : d = False
    Set b = CreateObject("Microsoft.XMLHTTP")
		with b
        .Open "GET", a, False
        .send
        If b.Status <> 200 Then
            Exit Function
        End If
        call .Open("GET", a & " And 1=1", False)
        .send
        c = .Status

        call.Open("GET", a & " And 1=2", False)
        .send ""
        d = .Status
	end with
	set b=nothing
        If c = 200 And d = 500 Then SqlInUrl = True
End Function




Function HandlUrlCanShu(a)
    Dim b, c, d, e, f, g
    c = Split(a, "=")
    For d = 0 To UBound(c)
        e = c(d)
        If b <> "" Then b = b & "="
        If InStr(e, "&") Then
            f = Mid(e, 1, InStr(e, "&") - 1)
            g = Mid(e, InStr(e, "&"))
            e = escape(f) & g
        ElseIf d = UBound(c) Then
            e = escape(e)
        End If
        b = b & e
    Next
    HandlUrlCanShu = b
End Function










Function handleStrCharSet(a)
    If a = "1" Or UCase(a) = "GB2312" Or a = "" Then
        a = "GB2312"
    ElseIf a = "0" Or UCase(a) = "UTF-8" Then
        a = "UTF-8"
    ElseIf a = "2" Or UCase(a) = "UNICODE" Then
        a = "UNICODE"
    End If
    handleStrCharSet = a
End Function



Function URLEncoding(a)

    a = Replace(a, "1", "%31")
    a = Replace(a, "0", "%30")
    a = Replace(a, "A", "%41")
    a = Replace(a, "我", "%CE%D2")
    a = Replace(a, "#", "%23")

    a = Replace(a, "a", "%61")
    a = Replace(a, "n", "%6E")
    a = Replace(a, "d", "%64")
    a = Replace(a, " ", "%20")
    a = Replace(a, "=", "%3D")
    a = Replace(a, "e", "%65")
    a = Replace(a, "x", "%78")
    a = Replace(a, "i", "%69")
    a = Replace(a, "s", "%73")
    a = Replace(a, "t", "%74")
    a = Replace(a, "(", "%28")
    a = Replace(a, ")", "%29")
    a = Replace(a, "l", "%6C")
    a = Replace(a, "c", "%63")
    a = Replace(a, "*", "%2A")
    a = Replace(a, "f", "%66")
    a = Replace(a, "r", "%72")
    a = Replace(a, "o", "%6F")
    a = Replace(a, "m", "%6D")
    a = Replace(a, "w", "%77")
    a = Replace(a, "h", "%68")
    URLEncoding = a
End Function







Function getWinHttp(a, b, c, d, e)
    Dim f, g
    Set f = CreateObject("WinHttp.WinHttpRequest.5.1")
        With f

            If b = "" Then
                b = getwebsite(a)
            End If

            If c = "" Then
                c = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;"
            End If

            e = Trim(e)
            If e = "" Or e = "1" Or e = "gb2312" Then
                e = "gb2312"
            Else
                e = "utf-8"
            End If


            .SetTimeouts 60000, 60000, 60000, 3000





            .Option(4) = 13056
            .Option(6) = False

            .Open "GET", a, False

            .SetRequestHeader "Accept", "*/*"
            .SetRequestHeader "Accept-Language", "zh-cn,zh"
            .SetRequestHeader "User-Agent", "Mozilla/6.0"
            .SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
            .SetRequestHeader "Referer", b
            .SetRequestHeader "Connection", "Close"


            .SetRequestHeader "Cookie", c

            d = handlePostCookiesParame(d, "post")


            .Send(d)
            .WaitForResponse



            g = BytesToBstr(.Responsebody, e)


        End With
        getWinHttp = g
End Function


%>

