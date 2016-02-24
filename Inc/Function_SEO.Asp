<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-24
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
'Div版网站导航
Function DivNavigation(AddSql)
	Dim I, C, Url, FileName, BigFolder, Did, ShowDid, Target 
	Rs.Open "Select * From [NavBigClass] " & AddSql, Conn, 1, 1 
	C = C & "<li class=left></li>" & vbCrlf
	For I = 1 To Rs.RecordCount
		FileName = Rs("FileName") 
		If FileName <> "" And Right(FileName,1)<>"/" Then FileName = FileName & ".html"  
	
		BigFolder = "/" & Rs("FolderName") & "/" 
		Did = Rs("BigClassName") 
		ShowDid = FontColorFontB(Did, Rs("FontB"), Rs("FontColor")) 
		Target = Rs("Target")
		
		Url = Rs("FileName")
		If CheckRemoteUrl(Url)=False Then
			Url = BigFolder & FileName 
			Url = Replace(Replace(Url, "//", "/"), "//", "/")
			Url = FullHttpUrl(Host(),Url)		
			Call WebDebug(Url,"act=Nav&NavDid=" & Did)'调试
		End If
		
		C = C & "<li><a " & AHref(Url, "", Target) & ">" & ShowDid & "</a></li>" &vbCrlf
		C = C & "<li class=line></li>" & vbCrlf
	Rs.MoveNext : Next : Rs.Close 
	C = C & "<li class=right></li>" & vbCrlf
	DivNavigation = C 
End Function

'网站调试网址配置 (20140408改进)
function WebDebug(url, DebugUrl)
    if request("Debug") <> "" and getIP = "127.0.0.1" then
        url = "/WebAdmin/ShowWeb.Asp?Debug=1&" & DebugUrl 
        if request("MackHtml") = "False" then
            url = url & "&MackHtml=False" 
        end if 
        url = url & "&UserId=" & UserID 
    else
        url = lCase(url)                                      '对URL进行小写转换
    end if 
    WebDebug = url 
end function




%>
