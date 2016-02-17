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



Function PopularSearchesList(a,b,c,d)
    Dim e, f, g, h,i,j,k,l,m
  	If d = "" Then d = " Where Through<>0 Order By Sort Desc"
	Rs.Open"Select * From [SearchCount] " & d,Conn,1,1
	For f=1 To b
		If Rs.Eof Then Exit For
			k = Rs("Title")
			
			j = "/Inc/Create_Html.Asp?act=Search&MackHtml=False&wd=" & k
			If CheckMakeHtmlFile(Rs("FileName"))=False Then
				j = Rs("FileName")
			End If
			
			l = k
			l = FontColorFontB(l,Rs("FontB"),Rs("FontColor")) 	
			If k = m Then		
				g = TextFontB(k,True)
			Else
				g = "<a href='"& j &"'"& SetHtmlParam(a,"target|title|alt|id|class|style") &">"& l &"</a>"
			End If
			
			
			g = DisplayOnlineED2(WEB_ADMINURL &"SearchGl.Asp?act=ShowEdit&Id=" & Rs("Id") & "&n=" & GetRnd(11), g, "<li|<a ")
			h=h & g
			If f+1<b And f+1<=Rs.RecordCount Then h=h & c & vbCrlf
	Rs.MoveNext:Next:Rs.Close
    PopularSearchesList=h
End Function


%>

