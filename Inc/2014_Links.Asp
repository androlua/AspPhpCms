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



Function HandleLinkList(a, b)
	Dim c,d,e,f,g
	c=Split(a,"$Split$")
	For Each e In c
		If e <> "" Then
			If InStr(e,"(")>0 Then
				f = Mid(e,1,InStr(e,"(")-1)
				g = Mid(e,InStr(e,"(")+1)
				If g<>"" Then
					If Right(g,1) = ")" Then g=Left(g,Len(g)-1)
				End If
				If g="收藏" Then
					e = "<a href='javascript:;' onClick=""window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"">"& f &"</a>"
				ElseIf g="设为首页" Then
					e = "<a href='javascript:;' onClick=""var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"">"& f &"</a>"
				Else
					e = "<a href='"& g &"'>"& f &"</a>"
				End If
			End If
			d=d & e & b
		End If
	Next
	If d <> "" then d=Left(d,Len(d)-Len(b))
	HandleLinkList = d
End Function


function FriendLinkText(a)
    dim b, c, d, e, f, g, h
    rsx.open "Select * From [FriendLink] Where Through<>0 Order By Sort", conn, 1, 1
    for g = 1 to rsx.recordCount
        b = rsx("Url")
        d = ATarget(rsx("Target"))
        e = ARel(rsx("NoFollow"))
        c = rsx("Title")
        f = rsx("ImgPath")
        h = h & "<a href='" & b & "'" & d & "" & e & ">" & FontColorFontB(c, rsx("FontB"), rsx("FontColor")) & "</a>" & a & vbCrLf
    rsx.moveNext : next : rsx.close
    FriendLinkText = h
end function


%>

