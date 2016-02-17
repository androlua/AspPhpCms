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



Function SmallClassList(a, b, c, d)
	Dim e,f,g,h,i,j,k,l
	If b<>"" Then
		e = " class='"& b &"'"
	End If
	Rs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",Conn,1,1
	While Not Rs.Eof
		h = Rs("SmallClassName")
		i = FontColorFontB(h,Rs("FontB"),Rs("FontColor")) 	
		l = GetSmallClassFileName( Rs("BigClassName"), Rs("SmallClassName") )
		Call WebDebug(l,"act=CreateClass&ProDid=" & a & "&ProSid=" & Rs("SmallClassName"))
		k = ATarget(Rs("Target"))
		
		g = "        <li"& e &"><a "& AHref(l,i,k) & StyleClass(c) &">"& i &"</a></li>" & vbCrlf
		g = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & Rs("Id") & "&n=" & GetRnd(11), g, "<a ")
		f=f & g
		
	Rs.MoveNext:Wend:Rs.Close
	SmallClassList = f
End Function

Function ThreeClassList(a, b, c, d, e)
	Dim f,g,h,i,j,k,l,m
	If b<>"" Then
		f = " class='"& b &"'"
	End If
	Rs.Open"Select * From [ThreeClass] Where BigClassName='"& a &"' Order By Sort",Conn,1,1
	While Not Rs.Eof
		i = Rs("ThreeClassName")
		j = FontColorFontB(i,Rs("FontB"),Rs("FontColor")) 	
		
		m = GetThreeClassFileName( Rs("BigClassName"), Rs("SmallClassName") , Rs("ThreeClassName") )
		Call WebDebug(m,"act=CreateClass&ProDid=" & a & "&ProSid=" & Rs("SmallClassName") & "&ProTid=" & Rs("ThreeClassName"))

		If d="文本类型" Then
			m = "{$GetProductUrl did='"& Rs("BigClassName") &"' sid='"& Rs("SmallClassName") &"' tid='"& Rs("ThreeClassName") &"' title='"& Rs("ThreeClassName") &"'$}"
		End If
		
		l = ATarget(Rs("Target"))				
		
		h = "        <li"& f &"><a "& AHref(m,j,l) & StyleClass(c) &">"& j &"</a></li>" & vbCrlf	
		h = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & Rs("Id") & "&n=" & GetRnd(11), h, "<a ")
		
		g=g & h
	Rs.MoveNext:Wend:Rs.Close
	ThreeClassList = g
End Function

Function GetClassParam(ByVal a,ByVal b,ByVal c)
	Dim d,e,f,g,h
	d = "Select * From ["& a &"] " & c
	TempRs2.Open d,Conn,1,1
	If Not TempRs2.Eof Then
		
		If b = "[url]" then
			If LCase(a) = "bigclass" Then
				g = GetBigClassFileName(TempRs2("BigClassName"))
				h = "act=CreateClass&ProDid=" & TempRs2("BigClassName")
			ElseIf LCase(a) = "smallclass" Then
				g = GetSmallClassFileName( TempRs2("BigClassName"), TempRs2("SmallClassName") )
				h = "act=CreateClass&ProDid=" & TempRs2("BigClassName") & "&ProSid=" & TempRs2("SmallClassName")
			ElseIf LCase(a) = "threeclass" Then
				g = GetThreeClassFileName( TempRs2("BigClassName"), TempRs2("SmallClassName"),TempRs2("ThreeClassName"))
				h = "act=CreateClass&ProDid=" & TempRs2("BigClassName") & "&ProSid=" & TempRs2("SmallClassName") & "&ProTid=" & TempRs2("ThreeClassName")
			End If			
			g = FullHttpUrl(Host,g)
			Call WebDebug(g, h)
			GetClassParam = g
		ElseIf b<>"" Then
			GetClassParam = TempRs2(b)
		End If
	End If:TempRs2.Close
End Function

%>

