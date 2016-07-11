<% 
'发送邮箱 call Send_Email("313801120@qq.com", "标题", "111", "内容")
Function send_Email(ToMail, ToTitle, MyEmalName, ToContent)
    Dim JMail, isgo, MailBody 
    Response.AddHeader "Content-Type", "text/html; charset=gb2312" 
    Set JMail = CreateObject("JMail.Message")
        'JMail.ISOEncodeHeaders = False ' 是否进行ISO编码，默认为True
        JMail.ContentTransferEncoding = "base64" 
        JMail.Encoding = "base64" 
        JMail.ContentType = "text/html"                                                 '正常显示内容的代码
        JMail.silent = True 
        JMail.Logging = True 
        JMail.Charset = "gb2312" 
        JMail.MailServerUserName = "m18251922007"                                       '此为您邮箱的登录帐号，使用时请更改为自己的邮箱登录帐号
        JMail.MailServerPassword = "mydd3a"                                             '此为您邮箱的登录密码，使用时请更改为自己的邮箱登录密码
        JMail.From = "m18251922007@163.com"                                             '"m18251922007@163.com" '发件人Email
        JMail.FromName = MyEmalName                                                     '发件人姓名
        JMail.AddRecipient ToMail                                                       '收件人Email
        JMail.Subject = ToTitle                                                         '邮件主题
        '邮件主体（HTML(注意信件内链接附件的方式)）
        MailBody = MailBody & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>" 
        MailBody = MailBody & ToContent 
        MailBody = MailBody & "</body></html>" 
        JMail.Body = MailBody                                                           '邮件正文
        send_Email = JMail.send("smtp.163.com")                                         'SMTP服务器地址         //返回发送是否成功
        JMail.Close 
    Set JMail = Nothing 
End Function 
'邮箱发送 例：Response.Write( ServerSend_Email("m18251922007","mydd3a","313801120@qq.com", "标题", "11@aa.com", "内容"  ) )
'邮箱发送
Function serverSend_Email(ServerUserName, ServerPassword, ToMail, ToTitle, MyEmalName, ToContent)
    Dim JMail, isgo, MailBody 
    Response.AddHeader "Content-Type", "text/html; charset=gb2312" 
    Set JMail = CreateObject("JMail.Message")
        'JMail.ISOEncodeHeaders = False ' 是否进行ISO编码，默认为True
        JMail.ContentTransferEncoding = "base64" 
        JMail.Encoding = "base64" 
        JMail.ContentType = "text/html"                                                 '正常显示内容的代码
        JMail.silent = True 
        JMail.Logging = True 
        JMail.Charset = "gb2312" 
        JMail.MailServerUserName = ServerUserName                                       '此为您邮箱的登录帐号，使用时请更改为自己的邮箱登录帐号
        JMail.MailServerPassword = ServerPassword                                       '此为您邮箱的登录密码，使用时请更改为自己的邮箱登录密码
        JMail.From = "m18251922007@163.com"                                             '"m18251922007@163.com" '发件人Email
        JMail.FromName = MyEmalName                                                     '发件人姓名
        JMail.AddRecipient ToMail                                                       '收件人Email
        JMail.Subject = ToTitle                                                         '邮件主题
        '邮件主体（HTML(注意信件内链接附件的方式)）
        MailBody = MailBody & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>" 
        MailBody = MailBody & ToContent 
        MailBody = MailBody & "</body></html>" 
        JMail.Body = MailBody                                                           '邮件正文
        serverSend_Email = JMail.send("smtp.163.com")                                   'SMTP服务器地址         //返回发送是否成功
        JMail.Close 
    Set JMail = Nothing 
End Function 


'处理替换列表 (ReplaceList改成handleReplaceList)为了兼容php程序
Function handleReplaceList(ByVal content, yStr, tStr)
    Dim YSplStr, TSplStr, i, s 
    YSplStr = Split(yStr, "|") 
    TSplStr = Split(tStr & "||||||||||||||||||||||||||||||||", "|") 
    For i = 0 To UBound(YSplStr)
        s = YSplStr(i) 
        If s <> "" Then
            content = Replace(content, s, TSplStr(i)) 
        End If 
    Next 
    handleReplaceList = content 
End Function 

'从右边开始截取 作用：删除左边空格
Function leftSpace(ByVal content, ByVal AddNumb)
    Dim i, nCount 
    nCount = 0 
    For i = Len(content) To 1 Step - 1
        If Mid(content, i, 1) <> " " Then Exit For 
        nCount = nCount + 1 
    Next 
    If nCount > AddNumb And Replace(content, " ", "") <> "" Then
        content = Left(content, Len(content) - nCount + AddNumb) 
    ElseIf nCount < AddNumb And 1 = 1 Then
        For i = nCount To AddNumb - 1
            content = content & " " 
        Next 
    End If 
    leftSpace = content 
End Function 
'从右边开始截取 作用：删除右边空格
Function rightSpace(ByVal content, ByVal AddNumb)
    Dim i, nCount 
    nCount = 0 
    For i = 1 To Len(content)
        If Mid(content, i, 1) <> " " Then Exit For 
        nCount = nCount + 1 
    Next 
    If nCount > AddNumb Then
        content = Right(content, Len(content) - nCount + AddNumb) 
    ElseIf nCount < AddNumb Then
        For i = nCount To AddNumb - 1
            content = " " & content 
        Next 
    End If 
    rightSpace = content 
End Function 

'=============== 下面为2013,11,1添加
'获得QQ
Function getQQ(ByVal content, nOK)
    Dim splStr, i, j, s, c, qQ, nErr, QQYes 
    content = Replace(Replace(LCase(content), "&nbsp;", ""), " ", "") 
    nOK = 0 
    If InStr(content, "qq") > 0 Then
        splStr = Split(content, "qq") 
        For i = 1 To UBound(splStr)
            s = splStr(i) 
            qQ = "" : nErr = 14 : QQYes = False 
            For j = 1 To Len(s)
                If InStr("0123456789", Mid(s, j, 1)) = False Then
                    If QQYes = True Then Exit For                                                   'qq开始累加时则退出
                    If nErr = 0 Then Exit For                                                       '错误大于N退出
                    nErr = nErr - 1 
                    If Mid(s, j, 1) = "群" Then Exit For                                            '为QQ群退出
                Else
                    QQYes = True 
                    qQ = qQ & Mid(s, j, 1) 
                End If 
                If j > 30 Then Exit For                                                         'j大于20退出
            Next 
            If Len(qQ) >= 6 And Len(qQ) <= 10 And InStr(vbCrLf & c, vbCrLf & qQ & vbCrLf) = False Then
                If InStr(vbCrLf & c, vbCrLf & qQ & vbCrLf) = False Then
                    c = c & qQ & vbCrLf 
                    nOK = nOK + 1 
                End If 
            End If 
        Next 
    End If 
    getQQ = c 
End Function 
'获得手机
Function getTel(ByVal content, nOK)
    Dim splStr, i, j, s, c, tel, nErr, TelYes 
    content = Replace(Replace(LCase(content), "&nbsp;", ""), "手机", "tel") 
    nOK = 0 
    If InStr(content, "tel") > 0 Then
        splStr = Split(content, "tel") 
        For i = 1 To UBound(splStr)
            s = splStr(i) 
            tel = "" : nErr = 14 : TelYes = False 
            For j = 1 To Len(s)
                If InStr("0123456789", Mid(s, j, 1)) = False Then
                    If TelYes = True Then Exit For                                                  'Tel开始累加时则退出
                    If nErr = 0 Then Exit For                                                       '错误大于N退出
                    nErr = nErr - 1 
                Else
                    TelYes = True 
                    tel = tel & Mid(s, j, 1) 
                End If 
                If j > 30 Then Exit For                                                         'j大于20退出
            Next 
            If Len(tel) = 11 Then
                If InStr(vbCrLf & c, vbCrLf & tel & vbCrLf) = False Then
                    c = c & tel & vbCrLf 
                    nOK = nOK + 1 
                End If 
            End If 
        Next 
    End If 
    getTel = c 
End Function 
'获得邮箱
Function getMail(ByVal content, nOK)
    Dim splStr, i, j, s, c, mail, nErr, MailYes 
    content = Replace(Replace(LCase(content), "&nbsp;", ""), "邮箱", "mail") 
    nOK = 0 
    If InStr(content, "mail") > 0 Then
        splStr = Split(content, "mail") 
        For i = 1 To UBound(splStr)
            s = splStr(i) 
            mail = "" : nErr = 14 : MailYes = False 
            For j = 1 To Len(s)
                If InStr("0123456789abcdefghijklmnopqrstuvwxyz.@", Mid(s, j, 1)) = False Then
                    If MailYes = True Then Exit For                                                 'Mail开始累加时则退出
                    If nErr = 0 Then Exit For                                                       '错误大于N退出
                    nErr = nErr - 1 
                Else
                    MailYes = True 
                    mail = mail & Mid(s, j, 1) 
                End If 
                If j > 30 Then Exit For                                                         'j大于20退出
            Next 
            If InStr(mail, ".") > 0 And InStr(mail, "@") > 0 Then
                If InStr(vbCrLf & c, vbCrLf & mail & vbCrLf) = False Then
                    c = c & mail & vbCrLf 
                    nOK = nOK + 1 
                End If 
            End If 
        Next 
    End If 
    getMail = c 
End Function 
'获得图片列表
Function getImgStr(httpurl, content, nOK)
    Dim splStr, i, c, url, UrlList 
    content = getIMG(content) 
    splStr = Split(content, vbCrLf) 
    nOK = 0 
    For Each url In splStr
        If InStr("|" & UrlList & "|", "|" & url & "|") = False Then
            If Left(url, 1) = "/" Or(InStr(url, "http://") = False And InStr(url, "www.") = False) Then
                url = fullHttpUrl(httpurl, url) 
            End If 
            nOK = nOK + 1 
            c = c & url & "<br>" 
        End If 
    Next 
    getImgStr = c 
End Function 
'获得Css列表
Function getCssStr(httpurl, content, nOK)
    Dim splStr, i, c, url, UrlList 
    content = getCssHref(content) 
    splStr = Split(content, vbCrLf) 
    nOK = 0 
    For Each url In splStr
        If InStr("|" & UrlList & "|", "|" & url & "|") = False Then
            If Left(url, 1) = "/" Or(InStr(url, "http://") = False And InStr(url, "www.") = False) Then
                url = fullHttpUrl(httpurl, url) 
            End If 
            nOK = nOK + 1 
            c = c & url & "<br>" 
        End If 
    Next 
    getCssStr = c 
End Function 
'获得Js列表
Function getJsStr(httpurl, content, nOK)
    Dim splStr, i, c, url, UrlList 
    content = getJsSrc(content) 
    splStr = Split(content, vbCrLf) 
    nOK = 0 
    For Each url In splStr
        If InStr("|" & UrlList & "|", "|" & url & "|") = False Then
            If Left(url, 1) = "/" Or(InStr(url, "http://") = False And InStr(url, "www.") = False) Then
                url = fullHttpUrl(httpurl, url) 
            End If 
            nOK = nOK + 1 
            c = c & url & "<br>" 
        End If 
    Next 
    getJsStr = c 
End Function 


'获得网址列表 Rw(GetUrlStr("", "链接", Content, "", 0))
Function getUrlStr(httpurl, sType, content, SearchValue, nOK)
    Dim HrefList, splStr, title, url, c, s, LcaseUrl, UrlList, TitleList, SVal, SVal2 
    If sType = "链接" Then
        HrefList = getAURL(content) 
    ElseIf sType = "链接标题" Then
        HrefList = getATitle(content) 
    Else
        HrefList = getAURLTitle(content) 
    End If 
    splStr = Split(HrefList, vbCrLf) 
    nOK = 0 
    For Each s In splStr
        If s <> "" Then
            If sType = "链接" Then
                url = Trim(s) 
                If InStr(LCase(url), "javascript:") = False And url <> "#" And url <> "" Then
                    If InStr("|" & UrlList & "|", "|" & url & "|") = False Then
                        If Left(url, 1) = "/" Or(InStr(url, "http://") = False And InStr(url, "www.") = False) Then
                            url = fullHttpUrl(httpurl, url) 
                        End If 
                        nOK = nOK + 1 
                        c = c & url & vbCrLf 
                    End If 
                End If 
            ElseIf sType = "链接标题" Then
                If InStr("|" & TitleList & "|", "|" & s & "|") = False Then
                    TitleList = TitleList & s & "|" 
                    nOK = nOK + 1 
                    c = c & s & vbCrLf 
                End If 
            Else
                If InStr(s, "【_|-】") > 0 Then
                    url = Mid(s, 1, InStr(s, "【_|-】") - 1) : LcaseUrl = url 
                    title = Mid(s, Len(url) + 6) 
                    If InStr(LCase(LcaseUrl), "javascript:") = False And url <> "#" And url <> "" Then
                        If InStr("|" & UrlList & "|", "|" & url & "|") = False Then
                            If Left(url, 1) = "/" Or(InStr(LcaseUrl, "http://") = False And InStr(LcaseUrl, "www.") = False) Then
                                url = fullHttpUrl(httpurl, url) 
                            End If 
                            nOK = nOK + 1 
                            c = c & url & "   &nbsp;  " & title & vbCrLf 
                        End If 
                    End If 
                End If 
            End If 
        End If 
    Next 
    If SearchValue <> "" Then
        SearchValue = Replace(SearchValue, " and ", " And ") 
        splStr = Split(SearchValue, " And ") 
        SVal = splStr(0) 
        If UBound(splStr) > 0 Then SVal2 = splStr(1) 
        splStr = Split(c, vbCrLf) : nOK = 0 : c = "" 
        For Each s In splStr
            If SVal2 <> "" Then
                If InStr(s, SVal) > 0 And InStr(s, SVal2) > 0 Then
                    If InStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = False Then
                        nOK = nOK + 1 
                        c = c & s & "<br>" 
                    End If 
                End If 
            Else
                If InStr(s, SVal) > 0 Then
                    If InStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = False Then
                        nOK = nOK + 1 
                        c = c & s & "<br>" 
                    End If 
                End If 
            End If 
        Next 
    End If 
    getUrlStr = c 
End Function 
'获得Html中翻页配置 (采集用到)
Function getPageConfig(httpurl, content, sType)
    Dim splStr, i, s, s2, s3, c, url, TempUrl, ArrUrl(99), UrlList, pageUrl, nLen, splxx 
    content = getAURL(content) 
    splStr = Split(content, vbCrLf) 
    For Each url In splStr
        If url <> "" Then
            TempUrl = url 
            If InStr(LCase(url), "javascript:") = False And url <> "#" Then
                url = Replace(Replace(Replace(Replace(Replace(url, "0", ""), "1", ""), "2", ""), "3", ""), "4", "") 
                url = Replace(Replace(Replace(Replace(Replace(url, "5", ""), "6", ""), "7", ""), "8", ""), "9", "") 
                If sType = "注入" And InStr(url, "?") > 0 Then url = handlSqlInUrl(url) 
                c = c & url & vbCrLf 
                nLen = InStr(vbCrLf & UrlList, vbCrLf & url & "【】") 
                If nLen > 0 Then
                    s = Mid(UrlList, nLen) 
                    s = Mid(s, 1, InStr(s, vbCrLf) - 1) 
                    splxx = Split(s, "【】") 
                    s2 = splxx(0) 
                    s3 = splxx(1) + 1 
                    UrlList = Replace(UrlList, s, s2 & "【】" & s3 & "【】" & splxx(2)) 
                    pageUrl = url 
                Else
                    UrlList = UrlList & url & "【】0【】" & fullHttpUrl(httpurl, TempUrl) & vbCrLf 
                End If 
            End If 
        End If 
    Next 
    splStr = Split(UrlList, vbCrLf) : c = "" 
    If sType = "注入" Then
        For Each s In splStr
            If InStr(s, "【】") > 0 Then
                splxx = Split(s, "【】") 
                url = Trim(splxx(2)) 
                If InStr(url, httpurl) > 0 Then
                    If InStr(vbCrLf & c, vbCrLf & url & vbCrLf) = False Then
                        c = c & url & vbCrLf 
                    End If 
                End If 
            End If 
        Next 
        getPageConfig = c : Exit Function 
    End If 
    '处理出页配置
    For Each s In splStr
        If InStr(s, "【】") > 0 Then
            splxx = Split(s, "【】") 
            If splxx(1) > 0 Then ArrUrl(splxx(1)) = splxx(0) & "  &nbsp; | &nbsp; " & splxx(2) 
        End If 
    Next 
    For i = 99 To 0 Step - 1
        If ArrUrl(i) <> "" Then
            If InStr(ArrUrl(i), httpurl) > 0 Then
                c = c & ArrUrl(i) & "，   出现[" & i & "]次<br>" 
            End If 
        End If 
    Next 
    getPageConfig = c 
End Function 
'获得网页中注入网址
Function getSqlInUrl(httpurl, content, sType)
    Dim splStr, i, s, s2, s3, c, url, TempUrl, ArrUrl(99), UrlList, pageUrl, nLen, splxx 
    content = getAURL(content) 
    splStr = Split(content, vbCrLf) 
    For Each url In splStr
        If url <> "" Then
            TempUrl = url 
            If InStr(url, "?") > 0 Then
                c = c & url & vbCrLf 
                url = handlSqlInUrl(url) 
                nLen = InStr(vbCrLf & UrlList, vbCrLf & url & "【】") 
                If nLen > 0 Then
                    s = Mid(UrlList, nLen) 
                    s = Mid(s, 1, InStr(s, vbCrLf) - 1) 
                    splxx = Split(s, "【】") 
                    s2 = splxx(0) 
                    s3 = splxx(1) + 1 
                    UrlList = Replace(UrlList, s, s2 & "【】" & s3 & "【】" & splxx(2)) 
                    pageUrl = url 
                Else
                    UrlList = UrlList & url & "【】0【】" & fullHttpUrl(httpurl, TempUrl) & vbCrLf 
                End If 
            End If 
        End If 
    Next 
    splStr = Split(UrlList, vbCrLf) 
    For Each s In splStr
        If InStr(s, "【】") > 0 Then
            splxx = Split(s, "【】") 
            If s3 > 0 Then
                If sType = "注入" Then
                    ArrUrl(splxx(1)) = splxx(2) 
                Else
                    ArrUrl(splxx(1)) = splxx(0) & "  &nbsp; | &nbsp; " & splxx(2) 
                End If 
            End If 
        End If 
    Next 
    c = "" 
    For i = 99 To 0 Step - 1
        If ArrUrl(i) <> "" Then
            If sType = "注入" Then
                c = c & ArrUrl(i) & vbCrLf 
            Else
                c = c & ArrUrl(i) & "，   出现[" & i & "]次<br>" 
            End If 
        End If 
    Next 
    getSqlInUrl = c 
End Function 
'处理注入网址，配置获得网站注入网址
Function handlSqlInUrl(httpurl)
    Dim url, splStr, i, s 
    splStr = Split(httpurl, "=") 
    For i = 0 To UBound(splStr)
        If i = UBound(splStr) Then url = url & "=" : Exit For 
        s = splStr(i) 
        If i Mod 2 = 0 Then
            url = url & splStr(i) 
        Else
            If InStr(s, "&") > 0 Then
                url = url & "=" & Mid(s, InStr(s, "&")) 
            End If 
        End If 
    Next 
    handlSqlInUrl = url 
End Function 

'获得扫描后函数名称列表
Function getScanFunctionNameList(content)
    On Error Resume Next 
    Dim splStr, i, YesASP, YesWord, Sx, s, Wc, Zc, s1, AspCode, SYHCount, UpWord, FunList, s2 
    Dim UpWordn, tempS, DimList 
    Dim YesFunction                                                                 '函数是否为真
    YesASP = False                                                                  '是ASP 默认为假
    YesFunction = False                                                             '是函数 默认为假
    YesWord = False                                                                 '是单词 默认为假
    SYHCount = 0                                                                    '双引号默认为0
    splStr = Split(content, vbCrLf)                                                 '分割行
    '循环分行
    For Each s In splStr
        '循环每个字符
        For i = 1 To Len(s)
            Sx = Mid(s, i, 1) 
            'Asp开始
            If Sx = "<" And Wc = "" Then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                If Mid(s, i + 1, 1) = "%" Then
                    YesASP = True                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                End If 
            'ASP结束
            ElseIf Sx = "%" And Mid(s, i + 1, 1) = ">" And Wc = "" Then                     'Wc为输出内容
                YesASP = False                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
            End If 
            If YesASP = True Then
                '输入文本
                If(Sx = """" Or Wc <> "") Then
                    '双引号累加
                    If Sx = """" Then SYHCount = SYHCount + 1 
                    '判断是否"在最后
                    If SYHCount Mod 2 = 0 Then
                        If Mid(s, i + 1, 1) <> """" Then
                            Wc = Wc & Sx 
                            s1 = Right(Replace(Mid(s, 1, i - Len(Wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            If YesFunction = True Then AspCode = AspCode & Wc                               '函数代码累加
                            SYHCount = 0 : Wc = ""                                                          '清除
                        Else
                            Wc = Wc & Sx 
                        End If 
                    Else
                        Wc = Wc & Sx 
                    End If 
                ElseIf Sx = "'" Then                                                            '注释则退出
                    If YesFunction = True Then AspCode = AspCode & Mid(s, i) 
                    Exit For 
                '字母
                ElseIf checkABC(Sx) = True Or(Sx = "_" And Zc <> "") Or Zc <> "" Then
                    Zc = Zc & Sx 
                    s1 = LCase(Mid(s & " ", i + 1, 1)) 
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 And Not(s1 = "_" And Zc <> "") Then'最简单判断
                        tempS = Mid(s, i + 1) 
                        If InStr("|function|sub|", "|" & LCase(Zc) & "|") Then
                            '函数开始
                            If YesFunction = False And LCase(UpWord) <> "end" Then
                                YesFunction = True 
                                s2 = Mid(s, i + 2) 
                                s2 = Mid(s2, 1, InStr(s2, "(") - 1) 
                                FunList = FunList & s2 & vbCrLf 
                            ElseIf YesFunction = True And LCase(UpWord) = "end" Then                        '获得上一个单词
                                AspCode = AspCode & Zc & vbCrLf 

                                YesFunction = False 
                            End If 

                        End If 
                        UpWord = Zc                                                                     '记住当前单词
                        If YesFunction = True Then AspCode = AspCode & Zc 
                        Zc = "" 
                    End If 

                End If 
            End If 
            doEvents 
        Next 

    Next 
    getScanFunctionNameList = FunList 
End Function 
'获得函数名称20150402
Function getFunName(ByVal c)
    If InStr(c, "(") > 0 Then
        c = Mid(c, 1, InStr(c, "(") - 1) 
        c = PHPTrim(c) 
    End If 
    getFunName = c 
End Function 
'获得函数名称中变量
Function getFunDimName(ByVal c)
    Dim startStr, endStr, s 
    c = LCase(c) 
    startStr = "(" 
    endStr = ")" 
    If InStr(c, startStr) > 0 And InStr(c, endStr) > 0 Then
        c = strCut(c, startStr, endStr, 2) 
    End If 
    If c <> "" Then
        c = Replace(Replace(c, "byref ", ""), "byref,", "") 
        c = Replace(Replace(c, "byval ", ""), "byval,", "") 
        c = Replace(c, " ", "") 
    End If 
    getFunDimName = c 
End Function 
'获得变量定义的名称
Function getDimName(ByVal c)
    Dim startStr, endStr, s 
    c = LCase(c) 
    startStr = ":" 
    If InStr(c, startStr) > 0 Then
        c = Mid(c, 1, InStr(c, ":") - 1) 
    End If 
    If c <> "" Then
        c = Replace(Replace(c, "byref ", ""), "byref,", "") 
        c = Replace(Replace(c, "byval ", ""), "byval,", "") 
        c = Replace(c, " ", "") 
    End If 
    If InStr(c, "'") > 0 Then
        c = PHPTrim(Mid(c, 1, InStr(c, "'") - 1))                                       '刪除里面的'注释部分    20150330
    End If 
    getDimName = c 
End Function 

'获得JS变量定义的名称
Function getVarName(ByVal content)
    Dim splstr,i,s,c
    content = LCase(content) 
    If InStr(content, ";") > 0 Then
        content = Mid(content, 1, InStr(content, ";") - 1) 
    End If
	splstr=split(content,",")
	for each s in splstr
		if instr(s,"=")>0 then
			s=mid(s,1,instr(s,"=")-1)
		end if
		s=trim(s)
		if c<>"" then
			c=c & ","
		end if
		if s <>"" then
			c=c & s 
		end if
	next
	'call rwend(c)
    getVarName = c 
End Function 


'获得Set变量定义的名称 暂时用不上
Function getSetName(ByVal c)
    c = PHPTrim(LCase(c)) 
    c = Mid(c, 1, InStr(c, "=") - 1) 
    getSetName = Trim(c) 
End Function 
'替换变量
Function replaceDim(ByVal content)
    Dim splStr, s, tempS, c, lCaseS, DimInTHNumb 
    splStr = Split(content, ",") 
    For Each s In splStr
        s = Trim(s) 
        lCaseS = LCase(s) 
        If s <> "" Then
            '对变量中()处理，
            If InStr(s, "(") > 0 Then
                s = Mid(s, 1, InStr(s, "(") - 1) 
            End If 
            DimInTHNumb = InStr(LCase(ReplaceDimList), "," & lCaseS & "=")                  '替换变量
            If DimInTHNumb > 0 Then                                                         '替换变量
                tempS = Mid(ReplaceDimList, DimInTHNumb + 1) 
                tempS = Mid(tempS, 1, InStr(tempS, ",") - 1) 
                tempS = Mid(tempS, InStr(tempS, "=") + 1) 
                If InStr(FunDim & RootFunDim, "," & tempS & ",") = False Then
                    s = tempS 
                End If 
            End If 
            c = c & s & "," 
        End If 
    Next 
    If c <> "" Then c = Left(c, Len(c) - 1) 
    replaceDim = c 
End Function 
'替换变量名称(最优化处理) 加强于20141017
Function replaceDim2(ByVal DimList, DimName)
    Dim ZD, splStr, i, s, nMod, nInt, c 
    replaceDim2 = DimName 
    ZD = "abcdefghijklmnopqrstuvwxyz" 
    DimName = LCase(DimName) 
    splStr = Split(DimList, ",") 
    For i = 0 To UBound(splStr)
        s = splStr(i) 
        If s = DimName Then
            nMod =(i) Mod Len(ZD) + 1 
            nInt = Fix((i) / Len(ZD)) 

            If nMod <> 0 Then
                c = c & Mid(ZD, nMod, 1) 
            End If 
            If nInt <> 0 Then
                c = c & copyStr(Mid(ZD, nInt, 1), nInt) 
            End If 
            'Call Echo(I,Len(ZD))
            'Call Echo("nMod",nMod)
            'Call Echo("nInt",nInt)
            'Call Echo("C",C)
            replaceDim2 = c 
            Exit Function 
        End If 
    Next 
End Function 
'找当前文件夹重复函数主程序
Function findFolderRepeatFunction(folderPath)
    Dim filePath, s, c, content, Funs, FunList, AllFunList, nOK, nErr, splStr, splxx, nAllOK, nAllErr, nI 
    Dim ErrFunList, AllErrFunList 
    Call handlePath(folderPath)                                                     '获得完整路径
    c = "操作文件夹" & folderPath & vbCrLf 
    content = getDirFileList(folderPath, "") 
    splStr = Split(content, vbCrLf) : nI = 0 
    For Each filePath In splStr
        nI = nI + 1 
        s = nI & "、" & filePath 
        content = getFText(filePath) 
        content = getScanFunctionNameList(content)                                      '获得ASP函数名称列表
        nOK = 0 : nErr = 0 : nAllOK = 0 : nAllErr = 0 : FunList = "" : ErrFunList = "" : AllErrFunList = "" 
        splxx = Split(content, vbCrLf) 
        For Each Funs In splxx
            If Funs <> "" Then
                If InStr("|" & FunList & "|", "|" & Funs & "|") = 0 Then
                    FunList = FunList & Funs & "|" 
                    nOK = nOK + 1 
                Else
                    ErrFunList = ErrFunList & Funs & "|" 
                    nErr = nErr + 1 
                End If 
                If InStr("|" & AllFunList & "|", "|" & Funs & "|") = 0 Then
                    AllFunList = AllFunList & Funs & "|"                                            '全部函数
                    nAllOK = nAllOK + 1 
                Else
                    AllErrFunList = AllErrFunList & Funs & "|" 
                    nAllErr = nAllErr + 1 
                End If 
            End If 
            doEvents 
        Next 
        'Call CreateFile("allfun.txt", AllFunList)
        c = c & s & "，函数（" & UBound(splStr) + 1 & "），重复(" & nErr & "[" & ErrFunList & "])全部函数重复(" & nAllErr & "[" & AllErrFunList & "])" & vbCrLf 
        doEvents 
    Next 
    findFolderRepeatFunction = c 
End Function 
'找当前文件重复函数 (辅助)
Function findFileRepeatFunction(filePath)
    findFileRepeatFunction = handleContentRepeatFunction(getFText("FilePath"), 2) 
End Function 
'找当前内容重复函数
Function findContentRepeatFunction(content)
    findContentRepeatFunction = handleContentRepeatFunction(Contnet, 2) 
End Function 
'处理内容重复函数列表 sType为0为不显示，1为显示函数列表，2为显示重复函数列表，3为显示函数与重复函数列表
Function handleContentRepeatFunction(content, sType)
    Dim c, Funs, FunList, nOK, nErr, splxx, ErrFunList 
    sType = CStr(sType) 
    content = getScanFunctionNameList(content)                                      '获得ASP函数名称列表
    nOK = 0 : nErr = 0 
    splxx = Split(content, vbCrLf) 
    For Each Funs In splxx
        If Funs <> "" Then
            If InStr("|" & FunList & "|", "|" & Funs & "|") = 0 Then
                FunList = FunList & Funs & "|" 
                nOK = nOK + 1 
            Else
                ErrFunList = ErrFunList & Funs & vbCrLf 
                nErr = nErr + 1 
            End If 
        End If 
        doEvents 
    Next 
    c = "找到函数共（" & UBound(splxx) + 1 & "），重复(" & nErr & ")" & vbCrLf 
    '函数列表
    If sType = "1" Or sType = "3" Then
        c = c & vbCrLf & "函数列表" & vbCrLf & FunList 
    End If 
    '重复函数列表
    If ErrFunList <> "" And(sType = "1" Or sType = "3") Then
        c = c & vbCrLf & "重复函数列表" & vbCrLf & ErrFunList 
    End If 
    handleContentRepeatFunction = c 
End Function 
'替换字符内容2 自己写得一个 区分大小写
Function replace2(content, SearchStr, replaceStr)
    Dim LeftStr, RightStr 
    If InStr(content, SearchStr) > 0 Then
        LeftStr = Mid(content, 1, InStr(content, SearchStr) - 1) 
        RightStr = Mid(content, Len(LeftStr) + Len(SearchStr) + 1) 
        content = LeftStr & replaceStr & RightStr 
    End If 
    replace2 = content 
End Function 
'替换全部字符内容2 自己写得一个 区分大小写
Function allReplace(content, SearchStr, replaceStr)
    Dim LeftStr, RightStr, i 
    For i = 1 To 99
        If InStr(content, SearchStr) > 0 Then
            LeftStr = Mid(content, 1, InStr(content, SearchStr) - 1) 
            RightStr = Mid(content, Len(LeftStr) + Len(SearchStr) + 1) 
            content = LeftStr & replaceStr & RightStr 
        Else
            Exit For 
        End If 
    Next 
    allReplace = content 
End Function 
'替换一次，不区分大小写
Function replaceOneNOLU(content, SearchStr, replaceStr)
    Dim LeftStr, RightStr, LCaseContent 
    SearchStr = LCase(SearchStr) 
    LCaseContent = LCase(content) 
    If InStr(LCaseContent, SearchStr) > 0 Then
        LeftStr = Mid(content, 1, InStr(LCaseContent, SearchStr) - 1) 
        RightStr = Mid(content, Len(LeftStr) + Len(SearchStr) + 1) 
        content = LeftStr & replaceStr & RightStr 
    End If 
    replaceOneNOLU = content 
End Function 
'优化ASP代码 删除左右空格
Function optimizeAspCode(content)
    Dim splStr, s, c, i 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        s = trimVbTab(s) 
        If s <> "" Then c = c & trimVbTab(s) & vbCrLf 
    Next 
    optimizeAspCode = c 
End Function 

'截取函数里大括号
Function cutDaKuoHao(content)
    cutDaKuoHao = cutFunctionvValue(content, "{", "}") 
End Function 
'截取函数里小括号
Function cutXianKuoHao(content)
    cutXianKuoHao = cutFunctionvValue(content, "(", ")") 
End Function 

'截取函数值20150716
Function cutFunctionvValue(content, startStr, endStr)
    Dim ku1, ku2, i, s, c 
    ku1 = 1 : ku2 = 0 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        c = c & s 
        If s = startStr Then
            ku1 = ku1 + 1 
        ElseIf s = endStr Then
            ku2 = ku2 + 1 
            If ku1 = ku2 Then
                Exit For 
            End If 
        End If 
    Next 
    cutFunctionvValue = c 
End Function 
'获得字符在内容里出现次数20150721
Function getStrIntContentNumb(content, findStr)
    Dim splStr 
    If InStr(content, findStr) > 0 Then
        splStr = Split(content, findStr) 
        getStrIntContentNumb = UBound(splStr) 
    Else
        getStrIntContentNumb = 0 
    End If 
End Function 
%> 
