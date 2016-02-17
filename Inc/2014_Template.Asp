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





Function ReadColumeSetTitle(a,b,c,d)
	Dim TitleWidth											
	Dim TitleHeight											
	Dim ContentHeight										
	Dim ContentWidth										
	Dim ContentCss	
	
	TitleWidth = RParam(a,"TitleWidth")				
	TitleHeight = RParam(a,"TitleHeight")				
	ContentWidth = RParam(a,"ContentWidth")			
	ContentHeight = RParam(a,"ContentHeight")			
	
	
	TitleWidth=Trim(TitleWidth)
	
	If Right(TitleHeight,1)<>"%" And Right(TitleHeight,2)<>"px" and TitleHeight<>"" and TitleHeight<>"auto" Then
		TitleHeight = TitleHeight & "px"
	End If
	If Right(TitleWidth,1)<>"%" And Right(TitleWidth,2)<>"px" and TitleWidth<>"" and TitleWidth<>"auto" Then
		TitleWidth = TitleWidth & "px"
	End If
	
	ContentHeight=Trim(ContentHeight)
	
	If Right(ContentHeight,1)<>"%" And Right(ContentHeight,2)<>"px" and ContentHeight<>"" and ContentHeight<>"auto" Then
		ContentHeight = ContentHeight & "px"
	End If
	
	ContentWidth=Trim(ContentWidth)
	
	If Right(ContentWidth,1)<>"%" And Right(ContentWidth,2)<>"px" and ContentWidth<>"" and ContentWidth<>"auto" Then
		ContentWidth = ContentWidth & "px"
	End If
	
	If ContentHeight<>"" Then
		ContentCss = "height:"& ContentHeight &";"
	End If
	If ContentWidth<>"" Then
		ContentCss = ContentCss & "width:"& ContentWidth &";"
	End If
	
	Dim j
	j = ReadColumn(b)
	
	If TitleWidth<>"" Then
		j=Replace(j,"<div class=""tvalue"">", "<div class=""tvalue"" style='width:"& TitleWidth &";'>")
	End If
	
	If ContentCss<>"" Then
		j=Replace(j,"<div class=""ccontent"">", "<div class=""ccontent"" style='"& ContentCss &"'>")
	End If
	
	
	j=Replace(j,"栏目标题",c)
	j=Replace(j,"栏目内容",d)
	ReadColumeSetTitle = j
End Function


Function ReadColumn(a)
	Dim b,c,d,e
	
	b = WebTemplate & "\Template_Left.html"
	c = "/*columnlist"& a &"Start*/"
	d = "/*columnlist"& a &"End*/"
	e = ReadTemplateFileModular(b,c,d)
	If e = "[$NO$]" Then
		e = "Left样式ID["& a &"]不存在"
	End If
	ReadColumn = e
End Function


Function ReadTemplateModuleStr(a,b,c)
	Dim d,e,f,g
	d = "<!--#Module "& c &" Start#-->"
	e = "<!--#Module "& c &" End#-->"	
	a = ReplaceGlobleLable(a)				
	
	
	if checkFile(a)=false then
		a=WebTemplate & a
	end if
	
	If b <>"" Then
		f = b
	ElseIf CheckFile(a)=True Then
		f = GetFText(a)
	Else
		f = Code				
	End If

	
	If InStr(f,d)>0 And InStr(f,e)>0 Then
		ReadTemplateModuleStr = StrCut(f, d, e,2)
	Else
		ReadTemplateModuleStr = "模块["& c &"]不存在,路径=" & a
	End If
End Function

Function FindModuleStr(a,b)
	Dim c,d,e,f,g,h,i,j
	For g=1 To 9
		c = "[$读出内容 " : d = "$]"
		If InStr(b,c)>0 And InStr(b,d)>0 Then
			j = StrCut(b,c,d,2)
			h = RParam(j,"Block")
			i = RParam(j,"File")
			If InStr(vbCrlf & ReadBlockList & vbCrlf, vbCrlf & h & vbCrlf)=False Then
				ReadBlockList = ReadBlockList & h & vbCrlf
			End If
			
			If i<>"" Then
				a = GetFText(i)
			End If			
			e = c & j & d
			f = ""
			
			c = "<R#读出内容"& h &" start#>" : d = "<R#读出内容"& h &" end#>"
			If InStr(a,c)>0 And InStr(a,d)>0 Then	
				f = StrCut(a,c,d,2)
			Else
				c = "<!--#读出内容" & h :  d = "#-->"
				If InStr(a,c)>0 And InStr(a,d)>0 Then	
					f = StrCut(a,c,d,2)			
				End If			
			End If
			
			b = Replace(b,e,f)
			
		Else
			
			Exit For
		End If
	Next
	FindModuleStr = b
End Function




Function ReadTemplateSource(a)
	Dim b,c,d,e
	b = WebTemplate & "\TemplateSource.html"
	c = "<!--#sourceHtml"& a &"Start#-->"
	d = "<!--#sourceHtml"& a &"End#-->"	
	e = ReadTemplateFileModular(b,c,d)
	If e = "[$NO$]" Then
		e = "模板资源ID["& a &"]不存在"
	End If
	ReadTemplateSource = e
End Function




Function ReadTemplateFileModular(a,b,c)
	Dim d
	ReadTemplateFileModular = ""
	d = GetFText(a)
	If InStr(d,b)>0 And InStr(d,c)>0 Then
		ReadTemplateFileModular = StrCut(d, b, c,2)
	Else
		ReadTemplateFileModular = "[$NO$]"
	End If
End Function

Function GetNavTemplateText(a, b, c)
    Dim d, e, f, g, h, i
    If b <> "" Then
        d = " Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
	ElseIf a <> "" Then
        d = " Where BigClassName='" & a & "'"
    Else
        d = " Where NavType='" & c & "'"
    End If
	
	If a <> "" Then
		TempRs.Open"Select * From [NavBigClass] Where BigClassName='"& a &"'",Conn,1,1
		If Not TempRs.Eof Then			
			h = "/" & TempRs("FolderName") & "/"
			WebNavType = TempRs("NavType")		
			MainTitle = TempRs("BigClassName")					
		End If:TempRs.Close
	End If
	
	If b <> "" Then
		TempRs.Open"Select * From [NavSmallClass]  " & d,Conn,1,1
		If Not TempRs.Eof Then
			
			If Trim(TempRs("TemplatePath"))<>"" Then
				e = TempRs("TemplatePath")
			Else
				e = "Main_Model.Html"
			End If
			f = GetHandleFileName(TempRs("FileName"))
			
			If TempRs("FolderName") = "" Then
				i = h
			Else
				i = Trim(Replace(TempRs("FolderName"),"\","/"))
				If Left(i,1)<>"/" Then
					i = h & "/" & i
				End If
			End If
			CreateHTMLPath = LocalTestFolder & i & f
			
		
			
			if trim(TempRs("CustomAUrl"))<>"" then
				CreateHTMLPath=""
			end if
			
			
			
			
			
			
			
			MainContent = TempRs("Content")		
			
			MainContent = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=SmallNavInfo&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent)
			
			

			
			WebTitle = IIf(TempRs("WebTitle")<>"",TempRs("WebTitle"),WebTitle)
			WebKeywords = IIf(TempRs("WebKeywords")<>"",TempRs("WebKeywords"),WebKeywords)
			WebDescription = IIf(TempRs("WebDescription")<>"",TempRs("WebDescription"),WebDescription)
		
			MainTitle = TempRs("SmallClassName")					
		End If:TempRs.Close
		GetNavTemplateText = e:Exit Function
	End If
	
    Rs.Open "Select * From [NavBigClass] " & d, Conn, 1, 1
    If Not Rs.Eof Then
		
		If Trim(Rs("TemplatePath"))<>"" Then
            e = Rs("TemplatePath")
        Else
            Select Case Rs("NavType")
                Case "首页" : e = "Index_Model.Html"
                Case "文本" :
					e = "Main_Model.Html" : MainContent = Rs("Content")	
					
					MainContent = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditInformation&Id=" & Rs("Id") & "&n=" & GetRnd(11), MainContent)
					
				Case Else : e = "Main_Model.Html"		
            End Select
        End If
		MainTitle = Rs("BigClassName")					
		
		f = GetHandleFileName(Rs("FileName"))

        Call CreateDirFolder("/" & LocalTestFolder & Rs("FolderName"))
        CreateHTMLPath = "/" & LocalTestFolder & Rs("FolderName") & "/" & f
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
		
			
			if trim(rs("CustomAUrl"))<>"" then
				CreateHTMLPath=""
			end if
		
		
		
		WebTitle = IIf(Rs("WebTitle")<>"",Rs("WebTitle"),WebTitle)
		WebKeywords = IIf(Rs("WebKeywords")<>"",Rs("WebKeywords"),WebKeywords)
		WebDescription = IIf(Rs("WebDescription")<>"",Rs("WebDescription"),WebDescription)
	Else
		
		e = "Index_Model.Html"
		Call Echo("没有导航大类【"& a &"】此导航模板为默认",e)
    End If : Rs.Close
    GetNavTemplateText = e
End Function

Function GetClassTemplateText(a,b,c)
    Dim d, e, f, g,h, i
    If c <> "" Then
        d = "Select * From [ThreeClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'"
	ElseIf b <> "" Then
        d = "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
    Else
        d = "Select * From [BigClass] Where BigClassName='" & a & "'"
    End If
	
	
	If a <> "" Then
		TempRs.Open"Select * From [BigClass] Where BigClassName='"& a &"'",Conn,1,1
		If Not TempRs.Eof Then			
			h = "/" & TempRs("FolderName") & "/"
		End If:TempRs.Close
	End If
	
	If a <> "" Then
		TempRs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"'",Conn,1,1
		If Not TempRs.Eof Then
				i = Trim(Replace(TempRs("FolderName"),"\","/"))
				If Left(i,1)<>"/" Then
					h = h & "/" & i & "/"
				Else
					h = "/" & TempRs("FolderName") & "/"
				End If
			
		End If:TempRs.Close
	End If
	
	If c <> "" Then
		TempRs.Open"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'",Conn,1,1
		If Not TempRs.Eof Then		
			
			i = Trim(Replace(TempRs("FolderName"),"\","/"))
			If Left(i,1)<>"/" Then
				h = h & "/" & i & "/"
			Else
				h = "/" & TempRs("FolderName") & "/"
			End If
			
		End If:TempRs.Close
	End If
	If a<>"" And b = "" And c="" Then
		TempRs.Open"Select * From[NavBigClass] Where (NavType='产品' Or NavType='新闻' Or NavType='下载') And BigClassName='"& a &"'",Conn,1,1
		

		If Not TempRs.Eof Then										
			If CheckMakeHtmlFile(TempRs("FileName"))=True Then
				h = "/" & TempRs("FolderName") & "/"
			Else
				TempRs.Close
				TempRs.Open d,Conn,1,1
			End If
		Else
			TempRs.Close
			TempRs.Open d,Conn,1,1
		End If
	Else
		TempRs.Open d,Conn,1,1
	End If
	
	If Not TempRs.Eof Then
		
		If Trim(TempRs("TemplatePath"))<>"" Then
			e = TempRs("TemplatePath")
		Else
			e = "Main_Model.Html"
		End If
		f = GetHandleFileName(TempRs("FileName"))
		
		Call CreateDirFolder("/" & LocalTestFolder &  h )
		CreateHTMLPath = "/" & LocalTestFolder & h & "/" & f
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
		
		
		If TempRs("WebTitle") <> "" Then WebTitle = TempRs("WebTitle")
		If TempRs("WebKeywords") <> "" Then WebKeywords = TempRs("WebKeywords")
		If TempRs("WebDescription") <> "" Then WebDescription = TempRs("WebDescription")
	End If:TempRs.Close
	
	GetClassTemplateText = e
End Function







Function GetArticleInfoStyle(a,b,c,d)
	Dim e,f
	Set e = CreateObject("Adodb.RecordSet")
	
	f = " Where BigClassName='"& a &"' And ArticleInfoStyle<>'' And ArticleInfoStyle<>'0'"
	e.Open"Select * From [BigClass]" & f,Conn,1,1
	If Not e.Eof Then
		GetArticleInfoStyle = e("ArticleInfoStyle")
	End If:e.Close
	
	If b <>"" Then
		f = f & " And SmallClassName='"& b &"'"
		e.Open"Select * From [SmallClass]" & f,Conn,1,1
		If Not e.Eof Then
			GetArticleInfoStyle = e("ArticleInfoStyle")
		End If:e.Close
	End If
	
	If b <>"" Then
		f = f & " And ThreeClassName='"& c &"'"
		e.Open"Select * From [ThreeClass]" & f,Conn,1,1
		If Not e.Eof Then
			GetArticleInfoStyle = e("ArticleInfoStyle")
		End If:e.Close
	End If
	
	If d <>"" Then
		e.Open"Select * From [Product] Where Id=" & d,Conn,1,1
		If Not e.Eof Then
			If e("ArticleInfoStyle")<>"" And e("ArticleInfoStyle")<>"0" Then
				GetArticleInfoStyle = e("ArticleInfoStyle")
			End If
		End If:e.Close
	End If
	
	If GetArticleInfoStyle="" Then
		GetArticleInfoStyle = "默认新闻详细.html"
	End If	
End Function

Function GetArticleInfoPhotoWidth(a,b,c,d)
	Dim e,f
	Set e = CreateObject("Adodb.RecordSet")
	
	f = " Where BigClassName='"& a &"' And ArticleInfoPhotoWidth<>'' And ArticleInfoPhotoWidth<>'0'"
	e.Open"Select * From [BigClass]" & f,Conn,1,1
	If Not e.Eof Then
		If Cint(e("ArticleInfoPhotoWidth"))>0 Then
			GetArticleInfoPhotoWidth = e("ArticleInfoPhotoWidth")
		End If
	End If:e.Close
	
	If b <>"" Then
		f = f & " And SmallClassName='"& b &"'"
		e.Open"Select * From [SmallClass]" & f,Conn,1,1
		If Not e.Eof Then
			If Cint(e("ArticleInfoPhotoWidth"))>0 Then
				GetArticleInfoPhotoWidth = e("ArticleInfoPhotoWidth")
			End If
		End If:e.Close
	End If
	
	If b <>"" Then
		f = f & " And ThreeClassName='"& c &"'"
		e.Open"Select * From [ThreeClass]" & f,Conn,1,1
		If Not e.Eof Then
			If Cint(e("ArticleInfoPhotoWidth"))>0 Then
				GetArticleInfoPhotoWidth = e("ArticleInfoPhotoWidth")
			End If
		End If:e.Close
	End If
	
	If d <>"" Then
		e.Open"Select * From [Product] Where Id=" & d,Conn,1,1
		If Not e.Eof Then
			If (e("ArticleInfoPhotoWidth")<>"" And e("ArticleInfoPhotoWidth")<>"0") Or e("ArticleInfoPhotoWidth")="-1" Then
				GetArticleInfoPhotoWidth = e("ArticleInfoPhotoWidth")
			End If
		End If:e.Close
	End If
	If GetArticleInfoPhotoWidth = "0" Or GetArticleInfoPhotoWidth = "" Then GetArticleInfoPhotoWidth=600
End Function



Function GetArticlePageSize(a,b,c)
	Dim d,e
	Set d = CreateObject("Adodb.RecordSet")
	
	e = " Where BigClassName='"& a &"' And ArticleListStyle<>''"
	d.Open"Select * From [BigClass]" & e,Conn,1,1
	If Not d.Eof Then
		GetArticlePageSize = d("ArticlePageSize")
	End If:d.Close
	
	If b <>"" Then
		e = e & " And SmallClassName='"& b &"'"
		d.Open"Select * From [SmallClass]" & e,Conn,1,1
		If Not d.Eof Then
			GetArticlePageSize = d("ArticlePageSize")
		End If:d.Close
	End If
	
	If b <>"" Then
		e = e & " And ThreeClassName='"& c &"'"
		d.Open"Select * From [ThreeClass]" & e,Conn,1,1
		If Not d.Eof Then
			GetArticlePageSize = d("ArticlePageSize")
		End If:d.Close
	End If
	
	If GetArticlePageSize = "" Or GetArticlePageSize="0" Then	
		GetArticlePageSize = 9
	End If
End Function



Function GetArticleListStyle(a,b,c)
	Dim d,e
	Set d = CreateObject("Adodb.RecordSet")
 	
	d.Open"Select * From [NavBigClass] Where BigClassName='"& a &"'",Conn,1,1
	If Not d.Eof Then
		If InStr("|产品|新闻|下载|","|"& d("NavType") &"|")>0 Then
			GetArticleListStyle = "默认"& d("NavType") &"列表.html"
		End If
	End If:d.Close	
	
	e = " Where BigClassName='"& a &"' And ArticleListStyle<>''"
	d.Open"Select * From [BigClass]" & e,Conn,1,1
	If Not d.Eof Then
		GetArticleListStyle = d("ArticleListStyle")
	End If:d.Close
	
	If b <>"" Then
		e = e & " And SmallClassName='"& b &"'"
		d.Open"Select * From [SmallClass]" & e,Conn,1,1
		If Not d.Eof Then
			GetArticleListStyle = d("ArticleListStyle")
		End If:d.Close
	End If
	
	If b <>"" Then
		e = e & " And ThreeClassName='"& c &"'"
		d.Open"Select * From [ThreeClass]" & e,Conn,1,1
		If Not d.Eof Then
			GetArticleListStyle = d("ArticleListStyle")
		End If:d.Close
	End If
	
	If GetArticleListStyle="" Then
		GetArticleListStyle = "默认新闻列表.html"
	End If	
End Function


Function ReadTemplateFileSource(a,b)
	Dim c,d,e,f
	c = "<!--#sourceHtml"& Replace(b,".html","") &"Start#-->"
	d = "<!--#sourceHtml"& Replace(b,".html","") &"End#-->"	
	e = ReadTemplateFileModular(a,c,d)
	If e = "[$NO$]" Then
		
		f=GetStrCut(pubCode,c,d,2)
		if f<>"" then
			ReadTemplateFileSource=f
		
			exit function
		end if
		f=getftext(a)
		
		if instr(f,"<!--#DialogStart#-->")>0 then
			ReadTemplateFileSource=f
			exit function
		end if
		
		e = "模板资源ID["& b &"]不存在,路径TemplateFilePath=" & handlePath(a)
	End If
	ReadTemplateFileSource = e
End Function

Function ReadArticleListStyleSource(a)
	dim b
	b = getWebImages() & "\文章展示样式\" & a
	if checkFile(b)=false then
		b = WebTemplate & "\Resources\" & a
	end if
	
	ReadArticleListStyleSource = ReadTemplateFileSource(b ,a)
	
End Function

Function ReadArticleInfoStyleSource(a)
	dim b
	b = getWebImages() & "\文章信息展示样式\" & a
	if checkFile(b)=false then
		b = WebTemplate & "\Resources\" & a
	end if
	ReadArticleInfoStyleSource = ReadTemplateFileSource(b ,a)
End Function

%>






