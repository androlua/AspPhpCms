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

Sub GetWebConfig(a)
	
	If DefaultWebTitle <> "" Then		
		WebTitle = DefaultWebTitle
		WebKeywords = DefaultWebKeywords
		WebDescription = DefaultWebDescription
		Exit Sub
	End If

    Rs.Open "Select * From [WebSite] Where UserId="&a, Conn, 1, 1
    If Not Rs.Eof Then
        WebTemplate = Rs("WebTemplate")
        WebSkins = Rs("WebSkins") 		
		
		WebTitle = Rs("WebTitle")
        WebKeywords = Rs("WebKeywords")
        WebDescription = Rs("WebDescription")
		WebBottom = Rs("WebSiteBottom")
    End If : Rs.Close
End Sub

Function GetNavTemplateText(a, b, c,d)
    Dim e, f, g, h,i
    If b <> "" Then
        e = " Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
	ElseIf a <> "" Then
        e = " Where BigClassName='" & a & "'"
    Else
        e = " Where NavType='" & c & "'"
    End If

	
	If a <> "" Then
		TempRs.Open"Select * From [NavBigClass] Where BigClassName='"& a &"' And UserId="&d,Conn,1,1
		If Not TempRs.Eof Then			
			i = "/" & TempRs("FolderName") & "/"
			WebNavType = TempRs("NavType")		
		End If:TempRs.Close
	End If
	
	If b <> "" Then
		TempRs.Open"Select * From [NavSmallClass]  " & e & " And UserId="&d,Conn,1,1
		If Not TempRs.Eof Then
			
			If Trim(TempRs("TemplatePath"))<>"" Then
				f = TempRs("TemplatePath")
			Else
				f = "Main_Model.Html"
			End If
			g = GetHandleFileName(TempRs("FileName"))
			
			Call CreateDirFolder("/" & i & TempRs("FolderName"))
			CreateHTMLPath = "/" & i & TempRs("FolderName") & "/" & g
			CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
			
			MainContent = TempRs("Content")		

			
			WebTitle = IIf(TempRs("WebTitle")<>"",TempRs("WebTitle"),WebTitle)
			WebKeywords = IIf(TempRs("WebKeywords")<>"",TempRs("WebKeywords"),WebKeywords)
			WebDescription = IIf(TempRs("WebDescription")<>"",TempRs("WebDescription"),WebDescription)
		
		End If:TempRs.Close
		GetNavTemplateText = f:Exit Function
	End If
	
    Rs.Open "Select * From [NavBigClass] " & e & "And UserId="&d, Conn, 1, 1
    If Not Rs.Eof Then
		
		If Trim(Rs("TemplatePath"))<>"" Then
            f = Rs("TemplatePath")
        End If
		
		g = GetHandleFileName(Rs("FileName"))

        Call CreateDirFolder("/" & Rs("FolderName"))
        CreateHTMLPath = "/" & Rs("FolderName") & "/" & g
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
		
		MainContent = Rs("Content")		

		
		WebTitle = IIf(Rs("WebTitle")<>"",Rs("WebTitle"),WebTitle)
		WebKeywords = IIf(Rs("WebKeywords")<>"",Rs("WebKeywords"),WebKeywords)
		WebDescription = IIf(Rs("WebDescription")<>"",Rs("WebDescription"),WebDescription)
	Else
		
		f = "Index_Model.Html"
		Call Echo("没有导航大类【"& a &"】此导航模板为默认",f)
    End If : Rs.Close
    GetNavTemplateText = f
End Function

Function GetClassTemplateText(a,b,c,d)
    Dim e, f, g, h,i
    If c <> "" Then
        e = "Select * From [ThreeClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'"
	ElseIf b <> "" Then
        e = "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
    Else
        e = "Select * From [BigClass] Where BigClassName='" & a & "'"
    End If
	
	If a <> "" Then
		TempRs.Open"Select * From [BigClass] Where BigClassName='"& a &"' And UserID=" & d,Conn,1,1
		If Not TempRs.Eof Then			
			i = "/" & TempRs("FolderName") & "/"
		End If:TempRs.Close
	End If
	
	If a <> "" Then
		TempRs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And UserID=" & d,Conn,1,1
		If Not TempRs.Eof Then			
			i = i & "/" & TempRs("FolderName") & "/"
		End If:TempRs.Close
	End If
	
	If c <> "" Then
		TempRs.Open"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And ThreeClassName='"& c &"' And UserID=" & d,Conn,1,1
		If Not TempRs.Eof Then			
			i = i & "/" & TempRs("FolderName") & "/"
		End If:TempRs.Close
	End If
	
	TempRs.Open e,Conn,1,1
	If Not TempRs.Eof Then
		
		If Trim(TempRs("TemplatePath"))<>"" Then
			f = TempRs("TemplatePath")
		Else
			f = "Template_Main.html"			
		End If
		g = GetHandleFileName(TempRs("FileName"))
		
		Call CreateDirFolder("/" & i )
		CreateHTMLPath = "/" & i & "/" & g
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
		
		
		If TempRs("WebTitle") <> "" Then WebTitle = TempRs("WebTitle")
		If TempRs("WebKeywords") <> "" Then WebKeywords = TempRs("WebKeywords")
		If TempRs("WebDescription") <> "" Then WebDescription = TempRs("WebDescription")
	End If:TempRs.Close
	
	GetClassTemplateText = f
End Function

Function GetMainInfo(a,b)
	Dim c,d
	Rs.Open"Select * From [MainInfo] Where Title='"& a &"' And Recommend=1 And UserID="& b &" Order By Sort,ID",Conn,1,1
	If Not Rs.Eof Then
		 GetMainInfo = Rs("Content")
	End If : Rs.Close
End Function

Function ProductNavList(a, b, c)
	Dim d, e, f, g,h,i,j,k,l,m,n,o
	Rs.Open"Select * From [SmallClass] Where BigClassName='"& a &"'  And UserID="& UserID & " Order By Sort",Conn,1,1
	While Not Rs.Eof
		h = Rs("SmallClassName")
		i = FontColorFontB(h,Rs("FontB"),Rs("FontColor")) 	
		j = GetSmallClassFileName( Rs("BigClassName"), Rs("SmallClassName") )
		Call WebDebug(j,"act=CreateClass&ProDid=" & a & "&ProSid=" & Rs("SmallClassName"))
		k = ATarget(Rs("Target"))
		
		g=g & "        <div class='ClassSmall'><A "& AHref(j,"",k) & StyleClass("ClassSid") &">"& i &"</A></div>" & vbCrlf

		g=g & "<div class='clear10'></div>"
	Rs.MoveNext:Wend:Rs.Close
	ProductNavList = g
End Function



Sub CreateArticle(a)
	Dim b,c
	Rs.Open"Select * From [Product] Where Id=" & a,Conn,1,1
	If Not Rs.Eof Then
		TempDid = Rs("BigclassName")
		TempSid = Rs("SmallclassName")
		TempTid = Rs("ThreeclassName")		
		MainTitle = Rs("Title")					
		c = ""
		If IsNul(Rs("SmallFiles"))=False Then	
			If IsNul(Rs("SmallFiles")) Then c="Images/error.gif" Else c=Rs("SmallFiles")	
		ElseIf IsNul(Rs("BigFiles"))=False Then	
			If IsNul(Rs("BigFiles")) Then c="Images/error.gif" Else c=Rs("BigFiles")
		End If
		MainContent = "<div class='ArticleTitle'>"& Rs("Title") &"</div>"
		
		If c <> "" And len(c)>5  Then
			If CheckFile(c)=True Then
				MainContent = MainContent & "<div style='text-align:center; border:1px double #CCCCCC; padding:4px;margin-bottom:10px;'><img src='"& c &"' width='"& HandleShowImg(c,740,0,"宽") &"'></div>"
			End If
		End If
		MainContent = MainContent & Rs("Content")
		
		
		MainContent = MainContent & "<hr>" & UpPage(Rs(0)) & DownPage(Rs(0))
		
		
		If Trim(Rs("TemplatePath"))<>"" Then
			TemplatePath = WebTemplate & Rs("TemplatePath")
		Else
			TemplatePath = WebTemplate & "Template_Main.Html"
		End If
		b = GetHandleFileName(Rs("FileName"))
		
		Call CreateDirFolder("/Html")
		CreateHTMLPath = "/Html/" & Rs("FolderName") & "/" & b
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
		
		
		WebTitle = IIf(Rs("Title")<>"",Rs("Title"),WebTitle)
		WebTitle = IIf(Rs("WebTitle")<>"",Rs("WebTitle"),WebTitle)
		WebKeywords = IIf(Rs("WebKeywords")<>"",Rs("WebKeywords"),WebKeywords)
		WebDescription = IIf(Rs("WebDescription")<>"",Rs("WebDescription"),WebDescription)
	End If:Rs.Close
End Sub
%>

