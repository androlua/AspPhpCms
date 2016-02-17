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



Function SiteMap(a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n
    Dim o, p
    Dim q, r, s, t, u
    q = RParam(a, "ShieldNavDidList")
    r = RParam(a, "ShieldNavSidList")
    s = RParam(a, "ShieldDidList")
    t = RParam(a, "ShieldSidList")
    u = RParam(a, "ShieldTidList")

    e = e & vbCrLf & "<!--SiteMap start-->" & vbCrLf
    e = e & "<div class=""sitemap_con"">" & vbCrLf

    Rs.Open "Select * From [NavBigClass] Order By Sort", Conn, 1, 1
    For b = 1 To Rs.RecordCount
        h = Rs("BigClassName")
        If InStr("|" & q & "|", "|" & h & "|") = False Then
            f = GetNavUrl(Rs("BigClassName"), "")
            i = FontColorFontB(h, Rs("FontB"), Rs("FontColor"))
            g = Rs("Target") : g = "_blank"

            e = e & "    <h4><a " & AHref(f, h, g) & ">" & i & "</a></h4>" & vbCrLf
            If Rs("NavType") = "文本" Then
                Rss.Open "Select * From [NavSmallClass] Where BigClassName='" & Rs("BigClassName") & "' Order By Sort", Conn, 1, 1
                If Not Rss.EOF Then
                    p = ""
                    For c = 1 To Rss.RecordCount
                        j = Rss("SmallClassName")
                        If InStr("|" & r & "|", "|" & j & "|") = False Then
                            f = GetNavUrl(Rss("BigClassName"), Rss("SmallClassName"))
                            k = FontColorFontB(j, Rss("FontB"), Rss("FontColor"))
                            g = Rss("Target") : g = "_blank"
                            p = p & CopyStr(" ", 16) & "<li><a " & AHref(f, "", g) & ">" & k & "</a></li>" & vbCrLf
                        End If
                    Rss.MoveNext : Next

                    If p <> "" Then
                        e = e & CopyStr(" ", 8) & "<div class=""group"">" & vbCrLf & CopyStr(" ", 12) & "<ul>" & vbCrLf
                        e = e & p
                        e = e & CopyStr(" ", 12) & "</ul>" & vbCrLf & CopyStr(" ", 12) & "<div class=""clear""></div>" & vbCrLf
                        e = e & CopyStr(" ", 8) & "</div>" & vbCrLf
                    End If

                End If : Rss.Close
            End If
        End If
    Rs.MoveNext : Next : Rs.Close

    Rs.Open "Select * From [BigClass] Order By Sort", Conn, 1, 1
    For b = 1 To Rs.RecordCount
        h = Rs("BigClassName")
        If InStr("|" & s & "|", "|" & h & "|") = False Then
            f = GetBigClassUrl(Rs("BigClassName"))
            i = FontColorFontB(h, Rs("FontB"), Rs("FontColor"))
            g = Rs("Target") : g = "_blank"

            e = e & "    <h4><a " & AHref(f, h, g) & ">" & i & "</a></h4>" & vbCrLf
            Rss.Open "Select * From [SmallClass] Where BigClassName='" & Rs("BigClassName") & "' Order By Sort", Conn, 1, 1
            If Not Rss.EOF Then
                e = e & CopyStr(" ", 8) & "<div class=""group"">" & vbCrLf & CopyStr(" ", 12) & "<ul>" & vbCrLf
                For c = 1 To Rss.RecordCount
                    j = Rss("SmallClassName")
                    If InStr("|" & t & "|", "|" & j & "|") = False Then
                        f = GetSmallClassUrl(Rss("BigClassName"), Rss("SmallClassName"))
                        k = FontColorFontB(j, Rss("FontB"), Rss("FontColor"))
                        g = Rss("Target") : g = "_blank"

                        e = e & CopyStr(" ", 16) & "<li><a " & AHref(f, "", g) & ">" & k & "</a>"

                        n = " Where BigClassName='" & Rss("BigClassName") & "' And  SmallClassName='" & Rss("SmallClassName") & "'"
                        Rsx.Open "Select * From [ThreeClass]" & n & " Order By Sort", Conn, 1, 1
                        o = ""
                        For d = 1 To Rsx.RecordCount
                            l = Rsx("ThreeClassName")

                            If InStr("|" & u & "|", "|" & l & "|") = False Then
                                f = GetThreeClassUrl(h, j, l)
                                m = FontColorFontB(l, Rsx("FontB"), Rsx("FontColor"))
                                g = Rsx("Target") : g = "_blank"
                                o = o & CopyStr(" ", 16) & "<li><a " & AHref(f, "", g) & ">" & m & "</a></li>" & vbCrLf
                            End If
                        Rsx.MoveNext : Next : Rsx.Close
                        If o = "" Then
                            e = e & "</li>" & vbCrLf
                        Else
                            o = vbCrLf & CopyStr(" ", 16) & "<ul>" & vbCrLf & o & CopyStr(" ", 16) & "</ul>"
                            e = e & o & CopyStr(" ", 16) & "</li>" & vbCrLf
                        End If
                    End If
                Rss.MoveNext : Next
                e = e & CopyStr(" ", 12) & "</ul>" & vbCrLf & CopyStr(" ", 12) & "<div class=""clear""></div>" & vbCrLf
                e = e & CopyStr(" ", 8) & "</div>" & vbCrLf
            End If : Rss.Close
        End If
    Rs.MoveNext : Next : Rs.Close
    e = e & "</div>" & vbCrLf & "<!--SiteMap end-->" & vbCrLf & vbCrLf
    SiteMap = e
End Function


Function SiteMap2(a,b, c)
    Dim d, e, f, g,h, i,j, k,l,m,n,o,p,q,r,s,t,u,v
    i=i & vbCrlf & "<!--SiteMap start-->" & vbCrlf
    i=i & "<div class="""& a &""">" & vbCrlf		
    i=i & "<ul>" & vbCrlf	
    Rs.Open "Select * From [NavBigClass] " & b, Conn, 1, 1
	For e = 1 To Rs.RecordCount
        k = Rs("FileName")
        If k <> "" Then k = k & ".html"
		l = "/" & Rs("FolderName") & "/"
		o = Rs("BigClassName")
		
		j = Rs("FileName")
		If CheckRemoteUrl(j)=False Then			
			j = l & k
			j = Replace(Replace(j, "//", "/"), "//", "/")
			Call WebDebug(j,"act=Nav&NavDid=" & o)
		End If
		
		p = FontColorFontB(o,Rs("FontB"),Rs("FontColor"))
		n = Rs("Target") : n="_blank"
		
		u = False
		i=i & "	<li><a "& AHref(j,o,n) &">"& p &"</a>"
		If Rs("NavType") = "文本" Then
			Rss.Open "Select * From [NavSmallClass] Where BigClassName='"& Rs("BigClassName") &"'", Conn, 1, 1
			If Not Rss.Eof Then
				i=i & vbCrlf & CopyStr(" ",8) & "<ul>"& vbCrlf & CopyStr(" ",12) & "<li>"
				For f = 1 To Rss.RecordCount
					k = Rss("FileName")
					If k <> "" Then k = k & ".html"
					q = Rss("SmallClassName")
					
					
					j = Rss("FileName")
					If CheckRemoteUrl(j)=False Then	
						j = l & k
						j = l & "/" & Rss("FolderName") & "/" & k
						j = Replace(Replace(j, "//", "/"), "//", "/")
						Call WebDebug(j,"act=Nav&NavDid=" & o & "&NavSid=" & q)
					End If
					
					r = FontColorFontB(q,Rss("FontB"),Rss("FontColor"))
					n = Rss("Target") : n="_blank"
					i = i & "<a "& AHref(j,"",n) &">" & r & "</a>" & vbCrlf
				Rss.MoveNext: Next
				i=i & CopyStr(" ",12) & "</li>"& vbCrlf & CopyStr(" ",8) &"</ul>" & vbCrlf
				u = True
			End If : Rss.Close
		End If
		If u=True Then
			i=i & CopyStr(" ",4) & "</li><div class=""clear""></div>" & vbCrlf
		Else
			i=i & "</li>" & vbCrlf
		End If
	Rs.MoveNext : Next : Rs.Close
	
    Rs.Open "Select * From [BigClass] " & c, Conn, 1, 1
	For e = 1 To Rs.RecordCount
        k = Rs("FileName")
        If k <> "" Then k = k & ".html"
		l = "/" & Rs("FolderName") & "/"
		o = Rs("BigClassName")

		j = Rs("FileName")
		If CheckRemoteUrl(j)=False Then
			j = l & k
			j = Replace(Replace(j, "//", "/"), "//", "/")
			Call WebDebug(j,"act=CreateClass&ProDid=" & o)
		End If
		
		p = FontColorFontB(o,Rs("FontB"),Rs("FontColor"))
		n = Rs("Target") : n="_blank"
		u = False
		i=i & CopyStr(" ",4) & "<li><a "& AHref(j,o,n) &">"& p &"</a>"
		Rss.Open "Select * From [SmallClass] Where BigClassName='"& Rs("BigClassName") &"'", Conn, 1, 1
		If Not Rss.Eof Then			
			i=i & vbCrlf & CopyStr(" ",8) & "<ul>" & vbCrlf
			For f = 1 To Rss.RecordCount
				k = Rss("FileName")
				If k <> "" Then k = k & ".html"
				m = "/" & Rss("FolderName") & "/"
				q = Rss("SmallClassName")

				j = Rss("FileName")
				If CheckRemoteUrl(j)=False Then
					j = l & "/" & Rss("FolderName") & "/" & k
					j = Replace(Replace(j, "//", "/"), "//", "/")
					Call WebDebug(j,"act=CreateClass&ProDid=" & o & "&ProSid=" &q)
				End If
				
				r = FontColorFontB(q,Rss("FontB"),Rss("FontColor"))
				n = Rss("Target") : n="_blank"
				i = i & CopyStr(" ",12) & "<li><a "& AHref(j,"",n) &">" & r & "</a>"
				Rsx.Open"Select * From [ThreeClass] Where BigClassName='"& o &"' And SmallClassName='"& q &"' Order By Sort,ID Asc",Conn,1,1
				v = ""
				For g = 1 To Rsx.RecordCount				
					k = Rsx("FileName")
					If k <> "" Then k = k & ".html"
					s = Rsx("ThreeClassName")

					j = Rsx("FileName")
					If CheckRemoteUrl(j)=False Then
						j = l & m & "/" & Rsx("FolderName") & "/" & k
						j = Replace(Replace(j, "//", "/"), "//", "/")
						Call WebDebug(j,"act=CreateClass&ProDid=" & o & "&ProSid=" & q & "&ProTid=" & s)
					End If
					
					t = FontColorFontB(s,Rsx("FontB"),Rsx("FontColor"))
					n = Rsx("Target") : n="_blank"
					v = v & "<a "& AHref(j,"",n) &">" & t & "</a>"					
				Rsx.MoveNext : Next : Rsx.Close
				If v <> "" Then i=i & "("& v &")"
				i=i & "</li>" & vbCrlf
			Rss.MoveNext: Next
			i=i & CopyStr(" ",8) & "</ul>" & vbCrlf
			u=True
		End If : Rss.Close
		If u=True Then
			i=i & CopyStr(" ",4) & "</li><div class=""clear""></div>" & vbCrlf
		Else
			i=i & "</li>" & vbCrlf
		End If
	Rs.MoveNext : Next : Rs.Close
		
    i=i & "</ul>" & vbCrlf	
    i=i & "</div>" & vbCrlf
    i=i & "<!--SiteMap end-->" & vbCrlf & vbCrlf
    SiteMap2=i
End Function
%>

