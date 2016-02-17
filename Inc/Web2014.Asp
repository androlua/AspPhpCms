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




Function ScrollPhoto(a,b,c,d,e,f)
	Dim g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v
	q = 22
    g=g & "<div id="""& e &""">" & vbCrlf
    g=g & "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vbCrlf
    g=g & "  <tr>" & vbCrlf
	
	h="Select * From [Product] Where BigClassName='" & a &"'"&f
	Rs.Open h,Conn,1,1
		For o=1 To b
		If Rs.Eof Then Exit For
		
		
		i = Rs("FileName")
		If CheckRemoteUrl(i)=False Then
			i = GetHandleUrl( Rs("FileName") )		
			Call WebDebug(i,"act=CreateArticle&ID=" & Rs("Id") )
		End If
		
		k = "_top"
		j = Rs("Title")
		u = IIF(Rs("TitleAlt")="",j,Rs("TitleAlt"))
		
		t = 20
		s = CutStr(j,t,"... ")
		s = FontColorFontB(s,Rs("FontB"),Rs("FontColor"))
		
		l = "<a "& AHref(i,u,k) &">"
		
		If IsNul(Rs("SmallFiles")) Then		
	    	If IsNul(Rs("BigFiles")) Then p="Images/error.gif" Else p=Rs("BigFiles")
		Else
	    	If IsNul(Rs("SmallFiles")) Then p="Images/error.gif" Else p=Rs("SmallFiles")
		End If
		r = IIF(Rs("BigFilesAlt")="",j,Rs("BigFilesAlt"))
		
		
		If m = "nonehref" Then
			l = "<a href=""#"" " & v & ">"
		End If
	
		
		g=g & "    <td width=""200"" height=""170"" valign=""middle""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vbCrlf
		g=g & "      <tr>" & vbCrlf
		g=g & "        <td align=""center"">" & l & "<img src=""" & p & """ width=""" & c & """ height=""" & d & """ border=""0"" "& ImgTitleAlt(r) &" class=""idimg""></a></td>" & vbCrlf
		g=g & "      </tr>" & vbCrlf
		g=g & "      <tr>" & vbCrlf
		g=g & "        <td height=""30"" align=""center"">" & vbCrlf
		g=g & l & s &"</a>" & vbCrlf
		If n Then
			g=g & "<br>价格:<font color=red>"&Rs("Price")&"￥</font>" & vbCrlf
			g=g & "&nbsp;&nbsp;<a href=""Shop.Asp?Id="&Rs(0)&""" class=Price>购买</a>" & vbCrlf
		End If	
				
		g=g & "                  </td>" & vbCrlf
		g=g & "      </tr>" & vbCrlf
		g=g & "    </table></td>" & vbCrlf
		g=g & "    <td width=""15"">&nbsp;</td>" & vbCrlf
	Rs.MoveNext:Next:Rs.Close
    g=g & "    <td>&nbsp;</td>" & vbCrlf
    g=g & "  </tr>" & vbCrlf
    g=g & "</table>" & vbCrlf
    g=g & "</div>" & vbCrlf
	ScrollPhoto = g
End Function


function FriendLink()
    dim b, c, d, e, f, g, h
    rsx.open "Select * From [FriendLink] Where Through=True Order By Sort", conn, 1, 1
    for g = 1 to rsx.recordCount
        b = rsx("Url")
        d = ATarget(rsx("Target"))
        e = ARel(rsx("NoFollow"))
        c = rsx("Title")
        f = rsx("ImgPath")
        h = h & "<div class='LinkBlock'><a href='" & b & "'" & d & "" & e & "><img src=" & f & "></a><br>"
        h = h & "<a href='" & b & "'" & d & "" & e & ">" & FontColorFontB(c, rsx("FontB"), rsx("FontColor")) & "</a></div>" & vbCrLf
    rsx.moveNext : next : rsx.close
    FriendLink = h
end function


Function ReadNewList(a, b, c, d)
	Dim e,f
	If c = "" Then c = 28
	Dim g,h,i,j,k
	
	If a <> "" Then
		i = "Where BigClassName='"& a &"'"
	End If
	i = "Select Top "& b &" * From [Product] " & i & d
	Rs.Open i,Conn,1,1
	For k=1 To b
		If Rs.Eof Then Exit For		
		
		g = Rs("FileName")
		If CheckRemoteUrl(g)=False Then
			g = GetHandleUrl( Rs("FileName") )		
			Call WebDebug(g,"act=CreateArticle&ID=" & Rs("Id") )
		End If
		

		e = Rs("Title")
		f = IIF(Rs("TitleAlt")="",e,Rs("TitleAlt"))		
		j = CutStr(e,c,"... ")
		j = FontColorFontB(j,Rs("FontB"),Rs("FontColor"))
		h=h & "<div class='News'><a "& AHref(g,f,Rs("Target")) &">"& j &"</a></div>" & vbCrlf
		
	Rs.MoveNext : Next : Rs.Close
	ReadNewList = h
End Function


Function LiTypeNewList(a, b, c, d)
	If c = "" Then c = 28
	Dim e,f,g,h,i
	If a <> "" Then
		g = "Where BigClassName='"& a &"'"
	End If
	g = "Select Top "& b &" * From [Product] " & g & d
	Rs.Open g,Conn,1,1
	For i=1 To b
		If Rs.Eof Then Exit For		
		
		e = Rs("FileName")
		If CheckRemoteUrl(e)=False Then
			e = GetHandleUrl( Rs("FileName") )		
			Call WebDebug(e,"act=CreateArticle&ID=" & Rs("Id") )
		End If
		
		h = CutStr(Rs("Title"),c,"... ")
		h = FontColorFontB(h,Rs("FontB"),Rs("FontColor"))
		f=f & "<li><a "& AHref(e,Rs("Title"),Rs("Target")) &">"& h &"</a></li>" & vbCrlf
		
	Rs.MoveNext : Next : Rs.Close
	LiTypeNewList = f
End Function


Function CaseList(a,b,c)
	Dim d,e,f,g,h,i,j,k,l
    d = "Select * From [Product] Where BigClassName='"& a &"' And (len(BigFiles)>3 Or len(SmallFiles)>3) Order By Id Desc"
    Rs.Open d, Conn, 1, 1
	For e=1 To b
		If Rs.Eof Then Exit For		
		f = GetHandleUrl( Rs("FileName") )
		g = Rs("Title")
		h = g
		If i <> "" Then
			h = Replace(h, i, "<font color=red><b>"& i &"</b></font>")
		End If		
		h = CutStr(h,28,"... ")			

		If IsNul(Rs("SmallFiles")) Then		
	    	If IsNul(Rs("BigFiles")) Then l="Images/error.gif" Else l=Rs("BigFiles")
		Else
	    	If IsNul(Rs("SmallFiles")) Then l="Images/error.gif" Else l=Rs("SmallFiles")
		End If
		h = FontColorFontB(h,Rs("FontB"),Rs("FontColor"))
		j = Rs("Target")		
			
			k=k & "<div class='ImageBlock'><a "& AHref(f,g,j) &"><img "& ImgSrc(l,g,j) &"/></a><p><a "& AHref(f,Rs("Title"),Rs("Target")) &">"& h &"</a></p></div>"
	Rs.MoveNext : Next :Rs.Close
		
	CaseList = k
End Function


Function ReadScrollMemberList(a, b)
    Dim c, d, e, f
    f = "Select * From [Member] Order By Id Desc"
    Rs.Open f, Conn, 1, 1
    For d = 1 To Rs.RecordCount
        If Rs.Eof Or d > a Then Exit For
        e = e & "<li>" & Rs("UserName") & "</li>"
    Rs.MoveNext : Next : Rs.Close
    ReadScrollMemberList = e
End Function



Function ReadClassList(a, b, c, d, e)
    Dim f, g, h, i,j,k,l,m,n,o,p,q,r,s
	Rs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",Conn,1,1
	r=0
	While Not Rs.Eof
		j = Rs("SmallClassName")
		k = FontColorFontB(j,Rs("FontB"),Rs("FontColor")) 	
		l = GetSmallClassFileName( Rs("BigClassName"), Rs("SmallClassName") )
		Call WebDebug(l,"act=CreateClass&ProDid=" & a & "&ProSid=" & Rs("SmallClassName"))
		m = ATarget(Rs("Target"))
		If e<>"" Then
			r=r+1
			s = " onmousemove=""ShowHideDiv('ProList"& r &"');"""
		End If
		
		i=i & "        <div class='ClassSmall'"& s &"><A "& AHref(l,"",m) & StyleClass("ClassSid") &">"& k &"</A></div>" & vbCrlf
		If e<>"" Then
			i=i & "<div id=""ProList"& r &""" style=""display:none"">" & vbCrlf
		End If
		Rsx.Open"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& Rs("SmallClassName") &"' Order By Sort,ID Asc",Conn,1,1
		If Not Rsx.Eof Then				
			For g=1 To Rsx.RecordCount
				If TableCount("Product","Where BigClassName='"& a &"' And SmallClassName='"& Rsx("SmallClassName") &"' And ThreeClassName='"& Rsx("ThreeClassName") &"'" )>1 Then
					
					n =  GetThreeClassFileName(Rsx("BigClassName"),Rsx("SmallClassName"),Rsx("ThreeClassName"))
				Else
					
					n = GetProductUrl("Where BigClassName='"& Rsx("BigClassName") &"' And SmallClassName='"& Rsx("SmallClassName") &"' And ThreeClassName='"& Rsx("ThreeClassName") &"'")
				End If
				
				
				
				m = ATarget(Rsx("Target"))
				q = Rsx("ThreeClassName")
				p = FontColorFontB(q,Rsx("FontB"),Rsx("FontColor")) 	
				If q = c Then
					p="<font color=red>"& p  &"</font>"
				End If
				i=i & "                <div class='ClassThree'><a "& AHref(n,"",m) & StyleClass("ClassTid") &">"& p &"</a></div>" & vbCrlf
			Rsx.MoveNext:Next
		End If:Rsx.Close
		If e<>"" Then
			i=i & "</div>" & vbCrlf
		End If
		i=i & "<div class='clear10'></div>"
	Rs.MoveNext:Wend:Rs.Close
	ReadClassList = i
End Function


Function HotSearch(a)
    Dim b, c, d, e,f,g,h,i,j
  	If a = "" Then a = " Where Through=True Order By Sort Desc"
	Rs.Open"Select * From [SearchCount] " & a,Conn,1,1
	For c=1 To 10
		If Rs.Eof Then Exit For			
			h = Rs("Title")
			g = "/Inc/Create_Html.Asp?act=Search&MackHtml=False&wd=" & h
			i = h
			i = FontColorFontB(i,Rs("FontB"),Rs("FontColor")) 	
			If h = j Then				
				e=e & "            "& TextFontB(h,True) &"&nbsp;" & vbCrlf
			Else
				e=e & "            <a "& AHref(g,h,Rs("Target")) &">"& i &"</a>&nbsp;" & vbCrlf
			End If
	Rs.MoveNext:Next:Rs.Close
    HotSearch=e
End Function


Function JsBanner2011(a, b, c, d, e, f)
    Dim g, h, i, j
    g = ""
    g = g & "<SCRIPT language=JavaScript type=text/javascript> " & vbCrlf
    g = g & "var bannerAD=new Array(); " & vbCrlf
    g = g & "var bannerADlink=new Array(); " & vbCrlf
    g = g & "var adNum=0; " & vbCrlf
    Rs.Open "Select Top " & b & " * From[Product] Where BigClassName='" & a & "'", Conn, 1, 1

    If Rs.Eof And e Then
        Rss.Open "Select BigClassName From [BigClass] Where BigClassName='" & a & "'", Conn, 1, 3
        If Rss.Eof Then
            Rss.AddNew
            Rss("BigClassName") = a
            Rss.Update
        End If : Rss.Close
        For j = 1 To b
            Conn.Execute("Insert Into[Product](BigClassName,Title,BigFiles) Values('" & a & "','" & a & j & "','UpLoadFiles/Pic/" & j & ".jpg')")
        Next
    End If
    For h = 1 To Rs.RecordCount
        If h = 1 Then i = Rs("BigFiles")
        g = g & "bannerAD[" & h - 1 & "]=""" & Replace(Rs("BigFiles"), vbCrlf, "") & """; " & vbCrlf
        g = g & "bannerADlink[" & h - 1 & "]=""#""" & vbCrlf
        g = g & "" & vbCrlf
    Rs.MoveNext : Next : Rs.Close
    g = g & "var preloadedimages=new Array(); " & vbCrlf
    g = g & "for(i=1;i<bannerAD.length;i++){ " & vbCrlf
    g = g & "preloadedimages[i]=new Image(); " & vbCrlf
    g = g & "preloadedimages[i].src=bannerAD[i]; " & vbCrlf
    g = g & "} " & vbCrlf
    g = g & "" & vbCrlf
    g = g & "function setTransition(){ " & vbCrlf
    g = g & "if(document.all){ " & vbCrlf
    g = g & "bannerADrotator.filters.revealTrans.Transition=Math.floor(Math.random()*23); " & vbCrlf
    g = g & "bannerADrotator.filters.revealTrans.apply(); " & vbCrlf
    g = g & "} " & vbCrlf
    g = g & "} " & vbCrlf
    g = g & "" & vbCrlf
    g = g & "function playTransition(){ " & vbCrlf
    g = g & "if(document.all) " & vbCrlf
    g = g & "bannerADrotator.filters.revealTrans.play() " & vbCrlf
    g = g & "} " & vbCrlf
    g = g & "" & vbCrlf
    g = g & "function nextAd(){ " & vbCrlf
    g = g & "if(adNum<bannerAD.length-1)adNum++ ; " & vbCrlf
    g = g & "else adNum=0; " & vbCrlf
    g = g & "setTransition(); " & vbCrlf
    g = g & "document.images.bannerADrotator.src=bannerAD[adNum]; " & vbCrlf
    g = g & "playTransition(); " & vbCrlf
    g = g & "theTimer=setTimeout(""nextAd()"", 4000); " & vbCrlf
    g = g & "} " & vbCrlf
    g = g & "" & vbCrlf
    g = g & "function jump2url(){ " & vbCrlf
    g = g & "jumpUrl=bannerADlink[adNum]; " & vbCrlf
    g = g & "jumpTarget='_self'; " & vbCrlf
    g = g & "if(jumpUrl != ''){ " & vbCrlf


    g = g & "} " & vbCrlf
    g = g & "} " & vbCrlf
    g = g & "function displayStatusMsg() { " & vbCrlf
    g = g & "status=bannerADlink[adNum]; " & vbCrlf
    g = g & "document.returnValue = true; " & vbCrlf
    g = g & "}" & vbCrlf
    g = g & "</SCRIPT>" & vbCrlf
    g = g & "<A onmouseover=""displayStatusMsg();return document.returnValue"" href=""javascript:jump2url()"">" & vbCrlf
    g = g & "<IMG id=bannerADrotator style=""FILTER: revealTrans(duration=2,transition=40)"" height=" & d & " src=""" & i & """ width=" & c & " align=middle name=bannerADrotator></A>" & vbCrlf
    g = g & "<SCRIPT language=JavaScript type=text/javascript>nextAd()</SCRIPT>" & vbCrlf
    JsBanner2011 = g
End Function






Sub MakeSiteMap()
    Dim b, c, d, e,f, g,h,i,j,k,l,m,n,o,p,q,r,s,t
	Dim u,v
	p = GetHost()
	s = Format_Time(Now(),2)
	t = 0
	

    Rs.Open "Select * From [WebSite]", Conn, 1, 1
    If Not Rs.Eof Then
		q = Rs("WebTitle")
    End If : Rs.Close

	
    u=u & "<?xml version=""1.0"" encoding=""gb2312""?>" & vbCrlf
    u=u & "<urlset" & vbCrlf
    u=u & "    xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9""" & vbCrlf
    u=u & "    xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""" & vbCrlf
    u=u & "    xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9" & vbCrlf
    u=u & "       http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"">" & vbCrlf
	
    v=v & "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">" & vbCrlf
    v=v & "<head>" & vbCrlf
    v=v & "<title>网站地图-"& q &"</title>" & vbCrlf
    v=v & "<meta http-equiv=""Content-type"" content=""text/html;"" charset=""gb2312"" />" & vbCrlf
    v=v & "<style type=""text/css"">" & vbCrlf
    v=v & "A{" & vbCrlf
    v=v & "font-size: 14px;text-decoration:none;" & vbCrlf
    v=v & "color: #000000;" & vbCrlf
    v=v & "line-height:30px;" & vbCrlf
    v=v & "}</style>" & vbCrlf
    v=v & "</head>" & vbCrlf
    v=v & "<body>" & vbCrlf
	
	
   	
    Rs.Open "Select * From [NavBigClass] Where OnHtml=True Order By Sort", Conn, 1, 1
	For b = 1 To Rs.RecordCount
        g = Rs("FileName")
        If g <> "" Then g = g & ".html"
		h = "/" & Rs("FolderName") & "/"
        f = h & g
        f = Replace(Replace(f, "//", "/"), "//", "/")
		f = UrlAddHttpUrl(p,f)
		k = Rs("BigClassName")
		r = IIF(Rs("WebTitle")="",q,Rs("WebTitle"))
		
	 	
		Call Echo(r,f)
		
		u=u & "<url>" & vbCrlf & "<loc>"& f &"</loc>" & vbCrlf & "<priority>0.5</priority>" & vbCrlf
		u=u & "<lastmod>"& s &"</lastmod>" & vbCrlf & "<changefreq>weekly</changefreq>" & vbCrlf & "</url>" & vbCrlf
		
		t = t + 1
		v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
		If Rs("NavType") = "文本" Then
			Rss.Open "Select * From [NavSmallClass] Where BigClassName='"& Rs("BigClassName") &"' And OnHtml=True Order By Sort", Conn, 1, 1
			If Not Rss.Eof Then
				For c = 1 To Rss.RecordCount
					g = Rss("FileName")
					If g <> "" Then g = g & ".html"
					f = h & g
					f = h & "/" & Rss("FolderName") & "/" & g
					f = Replace(Replace(f, "//", "/"), "//", "/")
					f = UrlAddHttpUrl(p,f)
					m = Rss("SmallClassName")
					r = IIF(Rss("WebTitle")="",q,Rss("WebTitle"))					
					
					Call Echo(r,f)
					u=u & "<url>" & vbCrlf & "<loc>"& f &"</loc>" & vbCrlf & "<priority>0.5</priority>" & vbCrlf
					u=u & "<lastmod>"& s &"</lastmod>" & vbCrlf & "<changefreq>weekly</changefreq>" & vbCrlf & "</url>" & vbCrlf
					
					t = t + 1
					v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
				Rss.MoveNext: Next 	
			End If : Rss.Close		
		End If
	Rs.MoveNext : Next : Rs.Close
	
	
    Rs.Open "Select * From [BigClass] Where OnHtml=True Order By Sort", Conn, 1, 1
	For b = 1 To Rs.RecordCount
        g = Rs("FileName")
        If g <> "" Then g = g & ".html"
		h = "/" & Rs("FolderName") & "/"
        f = h & g
        f = Replace(Replace(f, "//", "/"), "//", "/")
		f = UrlAddHttpUrl(p,f)
		k = Rs("BigClassName")
		r = IIF(Rs("WebTitle")="",q,Rs("WebTitle"))
	 	
		Call Echo(r,f)
		u=u & "<url>" & vbCrlf & "<loc>"& f &"</loc>" & vbCrlf & "<priority>0.5</priority>" & vbCrlf
		u=u & "<lastmod>"& s &"</lastmod>" & vbCrlf & "<changefreq>weekly</changefreq>" & vbCrlf & "</url>" & vbCrlf
		
		t = t + 1
		v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
		Rss.Open "Select * From [SmallClass] Where BigClassName='"& Rs("BigClassName") &"' And  OnHtml=True Order By Sort", Conn, 1, 1
		If Not Rss.Eof Then		
			For c = 1 To Rss.RecordCount
				g = Rss("FileName")
				If g <> "" Then g = g & ".html"
				i = "/" & Rss("FolderName") & "/"
				f = h & "/" & Rss("FolderName") & "/" & g
				f = Replace(Replace(f, "//", "/"), "//", "/")
				f = UrlAddHttpUrl(p,f)
				m = Rss("SmallClassName")
				r = IIF(Rss("WebTitle")="",q,Rss("WebTitle"))
				
				Call Echo(r,f)
				u=u & "<url>" & vbCrlf & "<loc>"& f &"</loc>" & vbCrlf & "<priority>0.5</priority>" & vbCrlf
				u=u & "<lastmod>"& s &"</lastmod>" & vbCrlf & "<changefreq>weekly</changefreq>" & vbCrlf & "</url>" & vbCrlf
				
				t = t + 1
				v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
				
				
				Rsx.Open"Select * From [ThreeClass] Where BigClassName='"& k &"' And SmallClassName='"& m &"' And  OnHtml=True Order By Sort",Conn,1,1
				For d = 1 To Rsx.RecordCount
					g = Rsx("FileName")
					If g <> "" Then g = g & ".html"
					f = h & i & "/" & Rsx("FolderName") & "/" & g
					f = Replace(Replace(f, "//", "/"), "//", "/")
					f = UrlAddHttpUrl(p,f)
					n = Rsx("SmallClassName")
					r = IIF(Rsx("WebTitle")="",q,Rsx("WebTitle"))
					
					Call Echo(r,f)
					u=u & "<url>" & vbCrlf & "<loc>"& f &"</loc>" & vbCrlf & "<priority>0.5</priority>" & vbCrlf
					u=u & "<lastmod>"& s &"</lastmod>" & vbCrlf & "<changefreq>weekly</changefreq>" & vbCrlf & "</url>" & vbCrlf
					
					t = t + 1
					v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
				Rsx.MoveNext : Next : Rsx.Close				
			Rss.MoveNext: Next
			End If : Rss.Close
	Rs.MoveNext : Next : Rs.Close	
	
    Rs.Open "Select * From [Product] Where OnHtml=True Order By Sort", Conn, 1, 1
	For b = 1 To Rs.RecordCount
        g = Rs("FileName")
        If g <> "" Then g = g & ".html"
		h = "/Html/" & Rs("FolderName") & "/"
        f = h & g
        f = Replace(Replace(f, "//", "/"), "//", "/")
		f = UrlAddHttpUrl(p,f)
		k = Rs("BigClassName")
		r = IIF(Rs("WebTitle")="",q,Rs("WebTitle"))
		
		Call Echo(r,f)
		u=u & "<url>" & vbCrlf & "<loc>"& f &"</loc>" & vbCrlf & "<priority>0.5</priority>" & vbCrlf
		u=u & "<lastmod>"& s &"</lastmod>" & vbCrlf & "<changefreq>weekly</changefreq>" & vbCrlf & "</url>" & vbCrlf
		
		t = t + 1
		v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
	Rs.MoveNext : Next : Rs.Close	
	
	Call CreateFile("/sitemap.xml", u & "</urlset>")
	Call CreateFile("/sitemap.html", v & "</body></html>")
	
	Call Echo("sitemap.html文档","<a href='/sitemap.html' target='_blank'>sitemap.html</a><br>")
	Call Echo("sitemap.xml文档","<a href='/sitemap.xml' target='_blank'>sitemap.xml</a>")
End Sub



Function WebStat(a)
    Dim b, c, d
    Dim e, f, g, h, i, j, k, l, m, n ,o
    f = Request.ServerVariables("HTTP_REFERER")
    e = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME")
    g = Request.ServerVariables("QUERY_STRING")
    If g <> "" Then
        e = e & "?" & g
    End If
	f = Request("GoToUrl")
	e = Request("ThisUrl")
    l = Request.QueryString("co")
    b = Now()
    c = Request.ServerVariables("HTTP_USER_AGENT")
	c=replace(c,"MSIE","Internet Explorer")
	c=replace(c,"NT 5.0","2000")
	c=replace(c,"NT 5.1","XP")
	c=replace(c,"NT 5.2","2003")
	
    d = Split(c & ";;;;", ";")
    m = d(1)
    n = Trim(d(2))
	If Right(n,1)=")" Then n=Mid(n,1,Len(n)-1)
    h = "来访" & f & vbCrlf
    h = h & "当前：" & e & vbCrlf
    h = h & "时间：" & b & vbCrlf
    h = h & "IP:" & GetIP() & vbCrlf
    h = h & "IE:" & getBrType("") & vbCrlf
    h = h & "Cookies=" & l & vbCrlf
    h = h & "XP=" & n & vbCrlf
    h = h & "Screen=" & Request("screen") & vbCrlf
    h = h & "用户信息=" &Request.ServerVariables("HTTP_USER_AGENT")  & vbCrlf
	
    h = h & "-------------------------------------------------" & vbCrlf
	
    i = a & Format_Time(Now(), 2) & ".txt"
    Call CreateAddFile(i, h)
    h = h & vbCrlf & i
    h = Replace(h, vbCrlf, "\n")
    h = Replace(h, """", "\""")

	WebStat = h
End Function


%>



