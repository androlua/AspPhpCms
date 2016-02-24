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

'暂时保留
'处理链接列表 例如    HandleLinkList("加入收藏(收藏)$Split$设为首页(设为首页)$Split${$NavBigLink$联系我们}$Split$腾讯微博(http://www.baidu.com/)$Split$新浪微博(http://www.google.cn)"," | ")
Function HandleLinkList(Content, ListSplValue)
	Dim SplStr,C,S,ShowStr,Action
	SplStr=Split(Content,"$Split$")
	For Each S In SplStr
		If S <> "" Then
			If InStr(S,"(")>0 Then
				ShowStr = Mid(S,1,InStr(S,"(")-1)
				Action = Mid(S,InStr(S,"(")+1)
				If Action<>"" Then
					If Right(Action,1) = ")" Then Action=Left(Action,Len(Action)-1)
				End If
				If Action="收藏" Then
					S = "<a href='javascript:;' onClick=""window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"">"& ShowStr &"</a>"
				ElseIf Action="设为首页" Then
					S = "<a href='javascript:;' onClick=""var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"">"& ShowStr &"</a>"
				Else
					S = "<a href='"& Action &"'>"& ShowStr &"</a>"
				End If 
			End If
			C=C & S & ListSplValue
		End If
	Next
	If C <> "" then C=Left(C,Len(C)-Len(ListSplValue))
	HandleLinkList = C
End Function

'友情链接文本版
function FriendLinkText(splStr)
    dim url, title, Target, Rel, ImgPath, i, c 
    rsx.open "Select * From [FriendLink] Where Through<>0 Order By Sort", conn, 1, 1 
    for i = 1 to rsx.recordCount
        url = rsx("Url") 
        Target = ATarget(rsx("Target")) 
        Rel = ARel(rsx("NoFollow")) 
        title = rsx("Title") 
        ImgPath = rsx("ImgPath") 
        c = c & "<a href='" & url & "'" & Target & "" & Rel & ">" & FontColorFontB(title, rsx("FontB"), rsx("FontColor")) & "</a>" & splStr & vbCrLf 
    rsx.moveNext : next : rsx.close 
    FriendLinkText = c 
end function


%>
