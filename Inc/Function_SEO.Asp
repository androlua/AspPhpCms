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

Function DivNavigation(a)
	Dim b, c, d, e, f, g, h, i
	Rs.Open "Select * From [NavBigClass] " & a, Conn, 1, 1
	c = c & "<li class=left></li>" & vbCrlf
	For b = 1 To Rs.RecordCount
		e = Rs("FileName")
		If e <> "" And Right(e,1)<>"/" Then e = e & ".html"
	
		f = "/" & Rs("FolderName") & "/"
		g = Rs("BigClassName")
		h = FontColorFontB(g, Rs("FontB"), Rs("FontColor"))
		i = Rs("Target")
		
		d = Rs("FileName")
		If CheckRemoteUrl(d)=False Then
			d = f & e
			d = Replace(Replace(d, "//", "/"), "//", "/")
			d = FullHttpUrl(Host(),d)		
			Call WebDebug(d,"act=Nav&NavDid=" & g)
		End If
		
		c = c & "<li><a " & AHref(d, "", i) & ">" & h & "</a></li>" &vbCrlf
		c = c & "<li class=line></li>" & vbCrlf
	Rs.MoveNext : Next : Rs.Close
	c = c & "<li class=right></li>" & vbCrlf
	DivNavigation = c
End Function


function WebDebug(a, b)
    if request("Debug") <> "" and getIP = "127.0.0.1" then
        a = "/WebAdmin/ShowWeb.Asp?Debug=1&" & b
        if request("MackHtml") = "False" then
            a = a & "&MackHtml=False"
        end if
        a = a & "&UserId=" & UserID
    else
        a = lCase(a)
    end if
    WebDebug = a
end function




%>

