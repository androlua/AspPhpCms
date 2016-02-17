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


Class Maiside
	
	Function LeftClassList(a, b, c, d)
		Dim e, f, g, h,i,j,k,l,m,n,o,p
		Rs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",Conn,1,1
		While Not Rs.Eof
			i = Rs("SmallClassName")
			j = FontColorFontB(i,Rs("FontB"),Rs("FontColor")) 	
			k = GetSmallClassFileName( Rs("BigClassName"), Rs("SmallClassName") )
			Call WebDebug(k,"act=CreateClass&ProDid=" & a & "&ProSid=" & Rs("SmallClassName"))
			l = ATarget(Rs("Target"))
			
			h=h & "        <div class='ClassSmall'><A "& AHref(k,"",l) & StyleClass("ClassSid") &">"& j &"</A></div>" & vbCrlf
			Rsx.Open"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& Rs("SmallClassName") &"' Order By Sort,ID Asc",Conn,1,1
			If Not Rsx.Eof Then				
				For f=1 To Rsx.RecordCount
					
					If i="汉堡加盟菜单" Then
						
						m =  GetThreeClassFileName(Rsx("BigClassName"),Rsx("SmallClassName"),Rsx("ThreeClassName"))
					Else
						
						m = GetProductUrl("Where BigClassName='"& Rsx("BigClassName") &"' And SmallClassName='"& Rsx("SmallClassName") &"' And ThreeClassName='"& Rsx("ThreeClassName") &"'")
					End If
					
					
					
					l = ATarget(Rsx("Target"))
					p = Rsx("ThreeClassName")
					o = FontColorFontB(p,Rsx("FontB"),Rsx("FontColor")) 	
					If p = c Then
						o="<font color=red>"& o  &"</font>"
					End If
					h=h & "                <div class='ClassThree'><a "& AHref(m,"",l) & StyleClass("ClassTid") &">"& o &"</a></div>" & vbCrlf
				Rsx.MoveNext:Next
			End If:Rsx.Close
			h=h & "<div class='clear10'></div>"
		Rs.MoveNext:Wend:Rs.Close
		LeftClassList = h
	End Function

	
	

End Class
%>

