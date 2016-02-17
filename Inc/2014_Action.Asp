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




function clearModuleReplaceArray()
	dim b
	for b=1 to ubound(ModuleReplaceArray)-1
		ModuleReplaceArray(b,0)=""
		ModuleReplaceArray(0,b)=""
	next
end function

function printModuleReplaceArray()
	dim b
	for b=1 to ubound(ModuleReplaceArray)-1
		if ModuleReplaceArray(b,0)="" then
			exit function
		end if
		call echo(ModuleReplaceArray(b,0),ModuleReplaceArray(0,b))
	next
end function



Function CheckFunValue(a,b)
	CheckFunValue = ( Left(a,Len(b)) = b )
End Function

Function ManyTimesHandleTemplateAction(ByVal a)
	
	Dim b
	a = ReplaceGlobleLable(a)						
	a = RunHtmlAspCode(a)							
	For b =1 To 6
		a = HandleTemplateAction(a, True)
	Next
	a = DelTemplateMyNote(a)						
	a = Replace(a, "href=""/", "href=""" & Host())	
	a = TrimVbCrlf(a)								
	a = ReplaceGlobleLable(a)						
	
	if isHtmlFormatting=true then
		a = HandleHtmlFormatting(a,false,0,"删除空行")
	end if
	
	
	if isWebLabelClose=true then
		
		if 1=2 then
			a=handleImgClose(a,true)
			a=handleBrClose(a,false)
			a=handleHrClose(a,false)
			a=handleHrClose(a,false)
			a=handleHtmlLabelClose(a,"input",false)		
			a=replace(a,"onClick=","onclick=")
			a=replace(a,"onSubmit=","onsubmit=")
		else
			
			a=handleCloseHtml(a,true,"")			
		end if		
	end if
	
	
	
	
	ManyTimesHandleTemplateAction = a
End Function

Function ReplaceGlobleLable(a)
	
	
	a = Replace(a,"[$样式目录$]",WebSkins)			
	a = Replace(a,"[$WebSkins$]",WebSkins)			
	
	a = Replace(a,"[$WebSkinsIndex$]",WebSkins & "Index\")			
	a = Replace(a,"[$样式Index目录$]",WebSkins & "Index\")			
	
	a = Replace(a,"[$模版文件夹$]",WebTemplate)			
	a = Replace(a,"[$模版路径$]",WebTemplate)			
	a = Replace(a,"[$模板目录$]",WebTemplate)			
	a = Replace(a,"[$WebTemplate$]",WebTemplate)		
	
	a = Replace(a,"[$图片目录$]",WebImages)			
	a = Replace(a,"[$WebImages$]",WebImages)		
	
	a = Replace(a,"[$Css目录$]",WebCss)			
	a = Replace(a,"[$WebCss$]",WebCss)			
	
	a = Replace(a,"[$Js目录$]",WebJs)			
	a = Replace(a,"[$WebJs$]",WebJs)		
	a = Replace(a,"[$UploadFiles$]","/UploadFiles/")		    		
	a = Replace(a,"[$UploadFilesPic$]","/UploadFiles/Pic/")		
	
	
	
	a = Replace(a,"[$模块目录$]",WebTemplate & "Module\")			
	a = Replace(a,"[$TemplateModule$]",WebTemplate & "Module\")		
	
	a = Replace(a,"[$域名$]", Host())		
	a = Replace(a,"[$DoMain$]", Host())		
	
	a = Replace(a,"[$Did$]", IIF(PubNavDid<>"",PubNavDid,PubProDid))		
	ReplaceGlobleLable = a
End Function


Function RunHtmlAspCode(ByVal  a)
	Dim b,c, d
	For d = 1 To 8
		
		b = HandleGetAspCode(a,"获取第一段")
		
		
		c = HandleGetAspCode(b,"|第一段|去ASP开始结束标签|去注释部分|每行不为空|处理成Execute代码|")
		
		
		c=TrimVbCrlf(c)
		
		If Left(c,1)="=" Then
			c =  "ExecuteResut" & c
		End If
		
		
		
		Execute(c)
		
		
		If b<>"" Then	
			
			
			
			
			a = Replace(a,b,ExecuteResut)
		
		Else
			Exit For
		End If
	Next
	RunHtmlAspCode = a
End Function

Function HandleTemplateAction(a,b)
	Dim c,d,e,f,g,h,i
	dim isResetRunAction					
	isResetRunAction = false				
	c = "{\$" : d = "\$}"
	dim k
	k=a	
	k=DelTemplateMyNote(k)			
	e = GetArray(k, c, d, True, True)
	f=Split(e,"$Array$")
	For Each h In f
		g=Trim(h)
		
		g = HandleInModule(g,"start") 						
		If g<>"" Then
			
			g = Trim(Mid(g,3,Len(g)-4)) & " "

			i = True			
			
			If pingBiLable(g) Then
				g = ""
			
			ElseIf CheckFunValue(g, "# ")=True Then
				g = ""
				
			
			ElseIf CheckFunValue(g, "ReadColumeSetTitle ")=True Then
				g = XY_ReadColumeSetTitle(g)
			
			ElseIf CheckFunValue(g, "ReadTemplateSource ")=True Then
				g = XY_ReadTemplateSource(g)
			
			ElseIf CheckFunValue(g, "ReadTemplateModule ")=True Then
				g = XY_ReadTemplateModule(g)
			
			ElseIf CheckFunValue(g, "GetContentModule ")=True Then
				g = XY_GetContentModule(g)
			
			ElseIf CheckFunValue(g, "ReplaceTemplateContent ")=True Then
				g = XY_ReplaceTemplateContent(a,h,g)
			
			ElseIf CheckFunValue(g, "ShowTemplateModule ")=True Then
				g = XY_ShowTemplateModule(g)

            ElseIf CheckFunValue(g, "Layout ") = True Then
                g = XY_Layout(g)

            ElseIf CheckFunValue(g, "Module ") = True Then
                g = XY_Module(g)
				
				
			
			ElseIf CheckFunValue(g, "Include ")=True Then
				g = XY_Include(g)
				
			
			
			ElseIf CheckFunValue(g, "MainInfo ")=True Then
				g = XY_MainInfo(g) 				
			
			ElseIf CheckFunValue(g, "MainInfoA ")=True Then
				g = XY_MainInfoA(g)				
			
			ElseIf CheckFunValue(g, "MainInfoUrl ")=True Then
				g = XY_MainInfoUrl(g)
			
			ElseIf CheckFunValue(g, "MainInfo_GetShowTitle ")=True Then
				g = XY_MainInfo_GetShowTitle(g)
			
			ElseIf CheckFunValue(g, "ShowThisText ")=True Then
				g = XY_ShowThisText(g)
			
			
			
			ElseIf CheckFunValue(g, "NavDidA ")=True Then
				g = XY_NavDidA(g)
			
			ElseIf CheckFunValue(g, "GetNavUrl ")=True Then
				g = XY_GetNavUrl(g)
			
			ElseIf CheckFunValue(g, "NavDidExists ")=True Then
				g = XY_NavDidExists(g)
				
				
			
				
			

				
			
			ElseIf CheckFunValue(g, "HrefA ")=True Then
				g = XY_HrefA(g)
				
			
			ElseIf CheckFunValue(g, "BannerSwitch ")=True Then
				g = XY_BannerSwitch(g)
			
			ElseIf CheckFunValue(g, "BannerSwitch2 ")=True Then
				g = XY_BannerSwitch2(g)
			
			ElseIf CheckFunValue(g, "DetailBanner ")=True Then
				g = XY_DetailBanner(g)
				
				
			
			
			
			ElseIf CheckFunValue(g, "News ")=True Then
				g = XY_News(g)
			
			ElseIf CheckFunValue(g, "ShowNewsList ")=True Then
				g = XY_ShowNewsList(g)
			
			ElseIf CheckFunValue(g, "RelatedInformationList ")=True Then
				g = XY_RelatedInformationList(g)				
			
			ElseIf CheckFunValue(g, "CustomInfoList ")=True Then
				g = XY_CustomInfoList(g)	
			
			ElseIf CheckFunValue(g, "getArticleInfo ")=True Then
				g = XY_getArticleInfo(g)	
			
			
			
			ElseIf CheckFunValue(g, "CustomGuestBookList ")=True Then
				g = XY_CustomGuestBookList(g)						
								 	
			
			ElseIf CheckFunValue(g, "SmallClassList ")=True Then
				g = XY_SmallClassList(g)
			
			ElseIf CheckFunValue(g, "CustomSmallClassList ")=True Then
				g = XY_CustomSmallClassList(g)
			
			ElseIf CheckFunValue(g, "ThreeClassList ")=True Then
				g = XY_ThreeClassList(g)
			
			ElseIf CheckFunValue(g, "CustomTwoDirectoryClassList ")=True Then
				g = XY_CustomTwoDirectoryClassList(g)
			
			ElseIf CheckFunValue(g, "RecommendNavigation ")=True Then
				g = XY_RecommendNavigation(g)
				
			
			ElseIf CheckFunValue(g, "CustomNavList ")=True Then
				g = XY_CustomNavList(g)
				
				
				
				
			
			
			ElseIf CheckFunValue(g, "Links ")=True Then
				g = XY_Links(g)
			
			ElseIf CheckFunValue(g, "LinkList ")=True Then
				g = XY_LinkList(g)
			
			ElseIf CheckFunValue(g, "FriendLinkLI ")=True Then
				g = XY_FriendLinkLI(g)
				
					
			
			
			ElseIf CheckFunValue(g, "GetDidAHrefUrl ")=True Then
				g = XY_GetDidAHrefUrl(g)
			
			ElseIf CheckFunValue(g, "GetSidAHrefUrl ")=True Then
				g = XY_GetSidAHrefUrl(g)
			
			ElseIf CheckFunValue(g, "GetTidAHrefUrl ")=True Then
				g = XY_GetTidAHrefUrl(g)
			
			ElseIf CheckFunValue(g, "GetProductUrl ")=True Then
				g = XY_GetProductUrl(g)
				
				
				
				
			
			ElseIf CheckFunValue(g, "PopularSearchesList ")=True Then
				g = XY_PopularSearchesList(g)				
				
				
			
			
			ElseIf CheckFunValue(g, "BatchAutoAddProductClass ")=True Then
				g = XY_BatchAutoAddProductClass(g)
			
			ElseIf CheckFunValue(g, "BatchAutoAddNavClass ")=True Then
				g = XY_BatchAutoAddNavClass(g)
				
				
				
			
			ElseIf CheckFunValue(g, "AutoAddDid ")=True Then
				g = XY_AutoAddDid(g)
			
			ElseIf CheckFunValue(g, "AutoAddSid ")=True Then
				g = XY_AutoAddSid(g)
			
			ElseIf CheckFunValue(g, "AutoAddTid ")=True Then
				g = XY_AutoAddTid(g)
			
			ElseIf CheckFunValue(g, "AutoAddProduct ")=True Then
				g = XY_AutoAddProduct(g)
			
			ElseIf CheckFunValue(g, "AutoAddGuestBook ")=True Then
				g = XY_AutoAddGuestBook(g)
			
			ElseIf CheckFunValue(g, "UpdateBigNav ")=True Then
				g = XY_UpdateBigNav(g)
			
			ElseIf CheckFunValue(g, "AutoBatchAddArticle ")=True Then
				g = XY_AutoBatchAddArticle(g)
			
			ElseIf CheckFunValue(g, "AutoAddInputConfig ")=True Then
				g = XY_AutoAddInputConfig(g)
				
			
			
			ElseIf CheckFunValue(g, "ShowPhotoList ")=True Then
				g = XY_ShowPhotoList(g)
			
			ElseIf CheckFunValue(g, "ShowAppointProductList ")=True Then
				g = XY_ShowAppointProductList(g)
			
			ElseIf CheckFunValue(g, "zoomImage ")=True Then
				g = XY_zoomImage(g)
			
			
			
			
			ElseIf CheckFunValue(g, "QQLIStyleListShow ")=True Then
				g = XY_QQLIStyleListShow(g)
			
			ElseIf CheckFunValue(g, "OnLineQQPopup ")=True Then
				g = XY_OnLineQQPopup(g)
			
			ElseIf CheckFunValue(g, "GetOnLineQQUrl ")=True Then
				g = XY_GetOnLineQQUrl(g)
				
				
			
			
			ElseIf CheckFunValue(g, "FormSubmit ")=True Then
				g = XY_FormSubmit(g)
				
			
			
			ElseIf CheckFunValue(g, "SiteMap ")=True Then
				g = XY_SiteMap(g)
				
			
			
			ElseIf CheckFunValue(g, "Article_Did ")=True Then
				g = ArticleDid
			
			ElseIf CheckFunValue(g, "Article_Sid ")=True Then
				g = ArticleSid
			
			ElseIf CheckFunValue(g, "Article_Tid ")=True Then
				g = ArticleTid
			
			ElseIf CheckFunValue(g, "Article_Title ")=True Then
				g = ArticleTitle
			
			ElseIf CheckFunValue(g, "Article_BigFiles ")=True Then
				g = ArticleBigFiles
			
			ElseIf CheckFunValue(g, "Article_SmallFiles ")=True Then
				g = ArticleSmallFiles
			
			ElseIf CheckFunValue(g, "Article_Id ")=True Then
				g = ArticleID
			
			ElseIf CheckFunValue(g, "Article_DateTime ")=True Then
				g = ArticleDateTime
			
			ElseIf CheckFunValue(g, "Article_Author ")=True Then
				g = ArticleAuthor
			
			ElseIf CheckFunValue(g, "Article_Content ")=True Then
				g = ArticleContent
				
			
			
			ElseIf CheckFunValue(g, "GetTableList ")=True Then
				g = XY_GetTableList(g)
			
			ElseIf CheckFunValue(g, "DeleteTable ")=True Then
				g = XY_DeleteTable(g)
			
			ElseIf CheckFunValue(g, "executeSQL ")=True Then
				g = XY_executeSQL(g)
				
				
			
			
			ElseIf CheckFunValue(g, "ForArray ")=True Then
				g = XY_ForArray(g)
			
			
			
			ElseIf CheckFunValue(g, "GetNavParam ")=True Then
				g = XY_GetNavParam(g)
			
			ElseIf CheckFunValue(g, "GetClassParam ")=True Then
				g = XY_GetClassParam(g)
			
			ElseIf CheckFunValue(g, "GetArticleParam ")=True Then
				g = XY_GetArticleParam(g)
			
			ElseIf CheckFunValue(g, "GetMainParam ")=True Then
				g = XY_GetMainParam(g)
				
			
			
			ElseIf CheckFunValue(g, "clearCache ")=True Then
				g = XY_clearCache(g)
				
				
				
				
			
			
			ElseIf CheckFunValue(g, "JsAutoUpdateWebPage ")=True Then
				g = JsContent
			
			ElseIf CheckFunValue(g, "Position ")=True Then
				g = XY_Position(g)
			
			ElseIf CheckFunValue(g, "FastNavigation ")=True Then
				g = XY_FastNavigation(g)
				
			
			
			ElseIf CheckFunValue(g, "DebugWebSkin ")=True Then
				g = XY_DebugWebSkin(g)
				
			
			
			ElseIf CheckFunValue(g, "ResetRunAction ")=True Then
				isResetRunAction=XY_ResetRunAction(g)
				g = ""
				
			
			ElseIf CheckFunValue(g, "onLineViewDialog ")=True Then
				g = XY_onLineViewDialog(g)
				 			
				
			
			
			ElseIf CheckFunValue(g, "copyTemplateMaterial ")=True Then
				g = VB_copyTemplateMaterial(g)			
				
			
			
			
			ElseIf CheckFunValue(g, "GetTableFieldValue ")=True Then
				g = GetTableFieldValue(g)			
			
			ElseIf CheckFunValue(g, "WebTopNav ")=True Then				
				g = HandleNavigation(g,"")
			
			ElseIf CheckFunValue(g, "WebBottomNav ")=True Then					
				g = XY_WebBottomNav(g)							
			
			ElseIf CheckFunValue(g, "Web_Title ")=True Then
				g = XY_WebTitle
			
			ElseIf CheckFunValue(g, "Web_KeyWords ")=True Then
				g = XY_WebKeywords
			
			ElseIf CheckFunValue(g, "Web_Description ")=True Then
				g = XY_WebDescription
			
			ElseIf CheckFunValue(g, "WebBottom ")=True Or g = "WebBottom" Then
				g = XY_WebBottom(g)			
			
			ElseIf CheckFunValue(g, "MainNav ")=True Then
				g = MainNav
			
			ElseIf CheckFunValue(g, "MainTitle ")=True Then
				g = MainTitle
			
			ElseIf CheckFunValue(g, "MainContent ")=True Then
				g = MainContent
			
			ElseIf CheckFunValue(g, "JsWebStat ")=True Then
				g = XY_JsWebStat(g)
				
				
			Else			
				i = False			
			End If
			
			If IsNUl(g) =True Then g=""
			If i = True Then
				a = Replace(a,h,g)
				
				
				a = handleModuleReplaceArray(a)
				call clearModuleReplaceArray()
				
				
				If b=True Then
					Code=a			
				End If
			End If
			
			if isResetRunAction then
				
				HandleTemplateAction = HandleTemplateAction(a,b)
				Exit Function
			end if
		End If
	Next
	HandleTemplateAction = a
End Function


function XY_DeleteTable(a)
	dim b,c,d
	d = RParam(a,"tablename")
	c = RParam(a,"addsql")
	b = "select * from ["& d &"] "
	b = GetWhereAnd(b & " ",c)
	if CheckSql(b)=false then
		XY_DeleteTable = "sql出错=" & b
		exit function
	end if
	b = "delete from ["& d &"] "
	b = GetWhereAnd(b & " ",c)
	conn.execute(b)
end function

function XY_executeSQL(a)
	dim b
	b = RParam(a,"sql")
	call CheckSql(b)
end function

function XY_getArticleInfo(a)
	dim b,c,d,e,f,g,h
	if ArticleId="" then
		XY_getArticleInfo = ""	
		exit function
	end if
	c = GetDefaultValue(a)
	rs.open"Select * From [Product] Where id=" & ArticleId ,conn,1,1
	if not rs.eof then
		d = Rs("FileName")
		If CheckMakeHtmlFile(d)=True Then
			d = GetHandleUrl( Rs("FileName") )
			Call WebDebug(d,"act=CreateArticle&ID=" & Rs("Id") )
		End If
		
		e = IIF(Rs("SmallFiles")<>"",Rs("SmallFiles"),Rs("BigFiles"))		
		f = "<a src='" & Rs("BigFiles") & "'" & SetHtmlParam(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
		g = AHref(d, Rs("Title"), Rs("Target")) & SetHtmlParam(a, "aclass")
		h = "<img src='" & e & "'" & SetHtmlParam(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
	
	
		c = ReplaceValueParam(c,"id",  rs("id"))		
		c = ReplaceValueParam(c,"title",Rs("Title"))
		c = ReplaceValueParam(c,"showtitle",ShowTitle)
		c = ReplaceValueParam(c,"adddatetime",Rs("AddDateTime"))
		c = ReplaceValueParam(c,"imgfile",e)
		c = ReplaceValueParam(c,"imgurl",e)
		c = ReplaceValueParam(c,"url",d)
		c = ReplaceValueParam(c,"aurl",g)
		c = ReplaceValueParam(c,"astr",f)
		c = ReplaceValueParam(c,"description",Rs("WebDescription"))
		c = ReplaceValueParam(c,"content",Rs("Content"))
		c = ReplaceValueParam(c,"price",Rs("Price"))
		c = ReplaceValueParam(c,"author",Rs("Author"))
		c = ReplaceValueParam(c,"nViewCount",Rs.RecordCount)		
	end if:rs.close
	XY_getArticleInfo = c
end function

function XY_ResetRunAction(a)
	dim b
	b = LCase(RParam(a,"operate"))
	if b="true" then
		XY_ResetRunAction=true
	else
		XY_ResetRunAction = false
	end if
end function

function XY_ForArray(a)
	dim b,c,d,e,f,g,h,i,j
	b = atRParam(a,"arraylist")				
	c = RParam(a,"splitstr")
	j = RParam(a,"nloop")				
	
	if b="" then
		b=copyStr("循环" & c,j)
	end if
	
	d = GetDefaultValue(a)
	
	e=split(b,c)
	for f = 0 to Ubound(e)
		g=e(f)
		if g <>"" then
			h=d
			h = ReplaceValueParam(h,"fortitle",  g)
			h = ReplaceValueParam(h,"forid",  f)
			h = ReplaceValueParam(h,"fori",  f)
			h = ReplaceValueParam(h,"forcount",  ubound(e)+1)
			i=i & h
		end if
	next
	XY_ForArray =i
end function

function XY_GetTableList(a)
	dim b,c,d,e,f,g
	b = RParam(a,"sql")
	c = RParam(a,"splitstr")
	e = RParam(a,"fieldnamelist")
	if lcase(c)="vbcrlf" then c=vbcrlf
	
	if CheckSql(b)=false then
		XY_GetTableList = "sql出错=" & b
		exit function
	end if
	if e="" then
		XY_GetTableList = ""
		exit function
	end if
	e=replace(e,"，",",")
	f=split(e,",")
	rs.open b,conn,1,1
	
	while not rs.eof
		for each d in f
			d=trim(d)
			
			if g<>"" then g=g & c
			g=g & rs(d)
		next
	rs.movenext:wend:rs.close
	
	XY_GetTableList = g
end function

Function XY_FormSubmit(a)
	Dim b,c,d,e,f,g,h,i,j
	
	Dim k,l,m,n,o,p,q,InfoS	
	Dim s,t
	dim fieldName								
	dim v,w,x,y
	dim Placeholder										
	dim passWordFieldName								
	dim isAddTableNameInput								
	isAddTableNameInput=true							
	
	s = RParam(a,"submitname")
	t = RParam(a,"resetname")
	If s = "" Then s="提交"
	If t = "" Then t="重置"
	
	
	k = RParam(a,"Did")
	n = RParam(a,"ClassName")
	l = RParam(a,"TableName")
	m = RParam(a,"FormName")
	o = RParam(a,"isVerificationCode")

	b = "<div class="""& n &""">" & vbCrlf
    b = b & "<form name="""& m &""" id="""& m &""" method=""post"" action=""/Inc/Create_Html.Asp?act=FormSubmit"" onSubmit=""return CheckForm(this);"">" & vbCrlf
	Rs.Open"Select * From [InputConfig] Where BigClassName='"& k &"' And Through<>0 Order By Sort",Conn,1,1
	While Not Rs.Eof
		
		fieldName=Rs("FieldName")
		if fieldName="自定义" then
			fieldName=Rs("CustomFieldName")
		end if
		
		if isAddTableNameInput=true then
			if lcase(fieldName)="tablename" then
				isAddTableNameInput=false
			end if
		end if
		
		Placeholder=Rs("Placeholder")
		if Placeholder<>"" then
			Placeholder = " placeholder="""& Placeholder &""""
		end if
	
		c=""
		
		If Rs("VerificationType") <> "" And Rs("VerificationType") <> "无" Then			
			c="alt="""& IIF(Rs("VerificationMsg")<>"",Rs("VerificationMsg"),"请输入" & Rs("FrontTitle"))
			
			If Rs("VerificationType")<>"不为空" Then
				c=c & "{Array}["& Rs("VerificationType") &"]"
			End If			
			c=c & """"
		End If
		d=""
		e=LCase(Trim(Rs("InputWidth")))
		If e<>"" Then
			e = HandleCssPX(e)
			d = d & IIF(d=""," style='width:"& e &";","width:"& e &";")
		End If
		f=LCase(Trim(Rs("InputHeight")))
		If f<>"" Then
			f = HandleCssPX(f)
			d = d & IIF(d=""," style='height:"& f &";","height:"& f &";")
			
			If Rs("InputType")<>"文本域" Then
				d = d & IIF(d=""," style='line-height:"& f &";","line-height:"& f &";")
				
			End If
		End If
		If d <> "" Then d=d & "'"
		
		
		
		InfoS = "    <dl>" & vbCrlf
		InfoS = InfoS & "    <dt>"& Replace(Rs("FrontTitle")," ","&nbsp;") &"</dt>" & vbCrlf		
		
		

  		p="":q=""
		If Rs("InputType")="单文本" Or Rs("InputType")="单文本居中" Then
			If Rs("InputType")="单文本居中" Then
				If d="" Then
					d = " style='text-align:center;'"
				Else
					d=replace(d,"style='","style='text-align:center;")
				End If
			End If
			InfoS = InfoS & "    <dd><input type=""text"" name="""& fieldName &""" id="""& fieldName &""" "& c &" value="""& Rs("DefaultValue") &""""& d & Placeholder &"></dd>" & vbCrlf
		ElseIf Rs("InputType")="密码" Then
			passWordFieldName = fieldName
			InfoS = InfoS & "    <dd><input type=""password"" name="""& fieldName &""" id="""& fieldName &""" "& c &" value="""& Rs("DefaultValue") &""""& d & Placeholder &"></dd>" & vbCrlf
		ElseIf Rs("InputType")="确认密码" Then
			c=Mid(c,1,len(c)-1) & passWordFieldName & """"
			InfoS = InfoS & "    <dd><input type=""password"" name="""& fieldName &""" id="""& fieldName &""" "& c &" value="""& Rs("DefaultValue") &""""& d & Placeholder &"></dd>" & vbCrlf
		ElseIf Rs("InputType")="文本域" Then
			InfoS = InfoS & "    <dd><textarea  name="""& fieldName &""" id="""& fieldName &""" "& c & d & Placeholder &">"& Rs("DefaultValue") &"</textarea></dd>" & vbCrlf
		
		
		ElseIf Rs("InputType")="验证码" Then
			If d="" Then
				d = " style='text-align:center;'"
			Else
				d=replace(d,"style='","style='text-align:center;")
			End If
			
			if fieldName="" then
				fieldName="YZM"
			end if
			InfoS = InfoS & "    <dd><input type=""text"" name="""& fieldName &""" id="""& fieldName &""" "& c &" value="""& Rs("DefaultValue") &""""& d & Placeholder &"></dd>" & vbCrlf
			InfoS = InfoS & "    <dd><img src=""/Inc/Code_7.asp"" id='imgcaptcha' onClick=""this.src='/Inc/Code_7.asp?n='+Math.random()"" style=""cursor:pointer;"" title=""点击换一张验证码""><a href=""javascript:;"" onClick=""$('#imgcaptcha').click();"">&nbsp;看不清？换一张</a></dd>" & vbCrlf

		ElseIf Rs("InputType")="隐藏域" Then
			InfoS = InfoS & "    <dd>" & InputHiddenText(fieldName, Rs("DefaultValue")) & vbCrlf
		
		
		ElseIf Rs("InputType")="单选" Then
			j=0
			g=Split(Rs("DefaultValue"),"|")
			For Each h In g
				If h <> "" Then
					j=j+1
					If InStr("|"& q &"|","|"& h &"|")=False Then
p=p & "<input type=""radio"" name="""& fieldName &""" id="""& fieldName & j &""" value="""& h &""" /><label for="""& fieldName & j &""">"& h &"</label>" & vbCrlf
						q=q & h & "|"
					Else
						p = Replace(p," value="""& h &""" />"," value="""& h &""" checked />")
					End If
				End If
			Next
			
			InfoS = InfoS & p
			
			
		ElseIf Rs("InputType")="多选" Then
			j=0
			g=Split(Rs("DefaultValue"),"|")
			For Each h In g
				If h <> "" Then
					j=j+1
					If InStr("|"& q &"|","|"& h &"|")=False Then
p=p & "<input type=""checkbox"" name="""& fieldName &""" id="""& fieldName & j &""" value="""& h &""" /><label for="""& fieldName & j &""">"& h &"</label>" & vbCrlf
						q=q & h & "|"
					Else
						p = Replace(p," value="""& h &""" />"," value="""& h &""" checked />")
					End If
				End If
			Next
			
			InfoS = InfoS & p
			
		ElseIf Rs("InputType")="下拉列表" Then
		
			InfoS = InfoS & "<select name="""& fieldName &""" id="""& fieldName &""">" & vbCrlf
			j=0
			v=Rs("DefaultValue")			
			v=replace(v,"\|","[$特殊字符A]$")
			v=replace(v,"\-","[$特殊字符B]$")
			g=Split(Rs("DefaultValue"),"|")
			For Each h In g
				If h <> "" Then
					j=j+1
					h=replace(h,"[$特殊字符A]$","|")
					h=replace(h,"[$特殊字符B]$","-")
					w=split(h & "-" & h,"-")
					x=w(0)
					y=w(1)
					InfoS = InfoS & "<option value="""& x &""" "& IIF(j=1,"selected","") & ">"& y &"</option>" & vbCrlf
				End If
			Next
			
			InfoS = InfoS & "</select>" & vbCrlf
			
		End If
		
		If Rs("TipsText")<>"" Then
			InfoS = InfoS & "    <dt>"& Rs("TipsText") &"</dt>" & vbCrlf
		End If
		
		InfoS = InfoS & "</dl>" & vbCrlf
		
		InfoS = DisplayOnlineED2(WEB_ADMINURL &"TableManage.Asp?act=ShowEdit&Id=" & Rs(0) & "&TableName=InputConfig"& "&n=" & GetRnd(11), InfoS, "<li|<a ")
		
		b=b & InfoS
		
	Rs.MoveNext:Wend:Rs.Close
 	
	b=b & InputHiddenText("DialogTitle",k)
	if l<>"" and isAddTableNameInput=true then
    b = b & "<input name=""TableName"" type=""hidden"" id=""TableName"" value="""& l &""">" & vbCrlf
	end if
    b = b & "<div class=""submitbtn"">" & vbCrlf
    b = b & "<input type=""submit"" name=""Submit"" value="""& s &""" class=""btn white"">" & vbCrlf
    b = b & "<input name=""button"" type=""reset"" class=""btn white"" id=""button"" value="""& t &""">" & vbCrlf
    b = b & "</div>" & vbCrlf
    b = b & "</form>" & vbCrlf
    b = b & "</div>" & vbCrlf
	XY_FormSubmit = b
End Function


Function XY_FastNavigation(a)
	Dim b,c,d, e, f, g, h, i,j,k,l,m,n,o, p
	Dim q
	d = RParam(a,"UlClass")
	e = RParam(a,"LiClass")
	f = RParam(a,"AClass")
	g = RParam(a,"FocusClass")
	h = LCase(RParam(a,"FocusText"))
	n = RParam(a,"DefaultSqlType")
	o = RParam(a,"DefaultDid")
	
	
	p = "nav"
	
	l = PubNavSid
	If PubNavDid<>"" Then
		m = GetNavType(PubNavDid)		
		If m="文本" Then
			j = "Select * From [NavSmallClass] Where BigClassName='"& PubNavDid &"' Order By Sort"
		Else
			j = "Select * From [SmallClass] Where BigClassName='"& PubNavDid &"' Order By Sort"
			p = "product"
			l = PubProSid
		End If	
	ElseIf PubProDid <> "" Then
		j = "Select * From [SmallClass] Where BigClassName='"& PubProDid &"' Order By Sort"
		p = "product"
		l = PubProSid
	End If
	If j<>"" Then
		Rss.Open j, Conn, 1, 1
		If Rss.Eof And o<>"" Then
			Rss.Close
			If n = "nav" Then
				j = "Select * From [NavSmallClass] Where BigClassName='"& o &"' Order By Sort"
			Else
				j = "Select * From [SmallClass] Where BigClassName='"& o &"' Order By Sort"
			End If
			Rss.Open j, Conn, 1, 1
			
		End If
		While Not Rss.Eof
			If p = "nav" Then
				i = GetNavUrl(Rss("BigClassName"), Rss("SmallClassName"))
			Else
				i = GetSmallClassFolderName(Rss("BigClassName"), Rss("SmallClassName"))
				
				
			End If
			
			
			b = Rss("SmallClassName")
			q = FontColorFontB(b, Rss("FontB"), Rss("FontColor"))
			If Rss("SmallClassName") = l Then
				If g<>"" And h="true" Then
					b = "<span class="""& g &""">"& q &"</span>"
				Else
					If g<>"" Then
						b = "<a "& AHref(i, Rss("SmallClassName"), Rss("Target")) &" class="""& g &""">"& q &"</a>"	
					Else
						b = "<a "& AHref(i, Rss("SmallClassName"), Rss("Target")) &">"& q &"</a>"	
					End If
				End If
			Else
				If f<>"" Then
					b = "<a "& AHref(i, Rss("SmallClassName"), Rss("Target")) &" class="""& f &""">"& q &"</a>"	
				Else
					b = "<a "& AHref(i, Rss("SmallClassName"), Rss("Target")) &">"& q &"</a>"	
				End If
			End If
			
			If p = "nav" Then
				b = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavSmall&Id=" & Rss("Id") & "&n=" & GetRnd(11), b)
			Else
				b = DisplayOnlineEditDialog(""& adminDir &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & Rss("Id") & "&n=" & GetRnd(11), b)
			End If
			
			
			
			If d<>"" Or  e<>"" Then
				If e<>"" And e<>"#" Then
					b = "<li class="""& e &""">" & b
				Else
					b = "<li>" & b
				End If
				b = b & "</li>"
			End If
			c=c & b & vbCrlf
		Rss.MoveNext:Wend:Rss.Close
	End If
	
	If d<>"" Or e<>"" Then
		If d<>"" And d<>"#" Then
			c = "<ul class="""& d &""">" & c
		Else
			c = "<ul>" & c
		End If
		c = c & "</ul>"
	End If
	
	XY_FastNavigation = c
End Function



Function XY_Position(a)
    Dim b, c, d, e, f, g
	Dim h,i, j,k,l,m,n,o,p
	Dim q
	
	
		
	
	
	
	f = RParam(a,"Delimiter")						
	If f="" Then f = " > "
	
	
	g = HandleNumber(RParam(a,"nDirectory"))		
	
	If IsNul(g)=True Then
		g = 5
	Else
		g = Cint(g)
	End If
	

    TempRs.Open "Select * From [NavBigClass] Where NavType='首页'", Conn, 1, 1
    If Not TempRs.Eof Then
        b = "/" & GetWebFolderName() & TempRs("FolderName") & "/" & TempRs("FileName")
        b = GetHandleUrl(b)
		Call WebDebug(b,"act=showweb")
		i = "<a " & AHref(b, "首页", TempRs("Target")) & ">首页</a>"
    End If : TempRs.Close
	

	d = "/" & GetWebFolderName()
    If PubNavDid <> "" Or PubProDid<>"" Then
		h = IIF(PubNavDid <> "", PubNavDid, PubProDid)
        TempRs.Open "Select * From [NavBigClass] Where BigClassName='" & h & "'", Conn, 1, 1		
        If Not TempRs.Eof Then


			
			b = GetNavUrl(TempRs("BigClassName"),"")
			
			
			Call WebDebug(b,"act=Nav&NavDid=" & TempRs("BigClassName"))
            d = "/" & GetWebFolderName() & TempRs("FolderName") & "/"
            j = "<a " & AHref(b, TempRs("BigClassName"), TempRs("Target")) & ">" & TempRs("BigClassName") & "</a>" 		
			
			j = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), j, "<li|<a ")
			
        End If : TempRs.Close
    End If

    If PubNavSid <> "" Then
        TempRs.Open "Select * From [NavSmallClass] Where BigClassName='" & PubNavDid & "' And SmallClassName='" & PubNavSid & "'", Conn, 1, 1
        If Not TempRs.Eof Then
		
			
			
			
			
			
			
			
			
			

			
			b = GetNavUrl(TempRs("BigClassName"),TempRs("SmallClassName"))
			
			
			
			Call WebDebug(b,"act=Nav&NavDid=" & TempRs("BigClassName") & "&NavSid=" & TempRs("SmallClassName"))
            k = "<a " & AHref(b, TempRs("SmallClassName"), TempRs("Target")) & ">" & TempRs("SmallClassName") & "</a>"
			
			k = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavSmall&Id=" & TempRs("Id") & "&n=" & GetRnd(11), k, "<li|<a ")
        End If : TempRs.Close
    End If
	

	d = "/" & GetWebFolderName()
    If PubProDid <> "" And j="" Then
        TempRs.Open "Select * From [BigClass] Where BigClassName='" & PubProDid & "'", Conn, 1, 1
        If Not TempRs.Eof Then

			

			b = GetClassUrl(TempRs("BigClassName"),"","")
			
			Call WebDebug(b,"act=CreateClass&ProDid=" & TempRs("BigClassName"))
            d = "/" & GetWebFolderName() & TempRs("FolderName") & "/"
            l = "<a " & AHref(b, TempRs("BigClassName"), TempRs("Target")) & ">" & TempRs("BigClassName") & "</a>"
			
			l = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditBigClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), l, "<li|<a ")
        End If : TempRs.Close
    End If

    If PubProSid <> "" Then
        TempRs.Open "Select * From [SmallClass] Where BigClassName='" & PubProDid & "' And SmallClassName='" & PubProSid & "'", Conn, 1, 1
        If Not TempRs.Eof Then
			
			
			
			
			
			
			
			
			
			
			
			
			

			
			b = GetClassUrl(TempRs("BigClassName"), TempRs("SmallClassName"), "")
			
			
			Call WebDebug(b,"act=CreateClass&ProDid=" & TempRs("BigClassName") & "&ProSid=" & TempRs("SmallClassName"))
            e = "/" & TempRs("FolderName") & "/"
            m = "<a " & AHref(b, TempRs("SmallClassName"), TempRs("Target")) & ">" & TempRs("SmallClassName") & "</a>"
			
			
			m = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), m, "<li|<a ")
        End If : TempRs.Close
    End If

    If PubProTid <> "" Then
        TempRs.Open "Select * From [ThreeClass] Where BigClassName='" & PubProDid & "' And SmallClassName='" & PubProSid & "' And ThreeClassName='" & PubProTid & "'", Conn, 1, 1
        If Not TempRs.Eof Then
		
		
			
			
			
			
			
			
			
			


			
			
			Call WebDebug(b,"act=CreateClass&ProDid=" & TempRs("BigClassName") & "&ProSid=" & TempRs("SmallClassName") & "&ProTid=" & TempRs("ThreeClassName"))
            n = "<a " & AHref(b, TempRs("ThreeClassName"), TempRs("Target")) & ">" & TempRs("ThreeClassName") & "</a>"
			
			n = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), n, "<li|<a ")
        End If : TempRs.Close
    End If
	
	If PubId <>"" Then
		TempRs.Open"Select * From [Product] Where Id=" & PubId,Conn,1,1
		If Not TempRs.Eof Then
			b = TempRs("FileName")
			If CheckMakeHtmlFile(b)=True Then
				b = GetHandleUrl(TempRs("FileName"))
				Call WebDebug(b, "act=CreateArticle&ID=" & TempRs("Id"))
			End If
			o =  "<a " & AHref(b, TempRs("Title"), TempRs("Target")) & ">" & TempRs("Title") & "</a>"
			o = DisplayOnlineED2(WEB_ADMINURL &"Product.Asp?act=ShowEditProduct&Id=" & TempRs("Id") & "&n=" & GetRnd(11), o, "<li|<a ")
		End If : TempRs.Close
	End If
	
	
	If MainTitle<>"" Then
		TempRs.Open"Select * From [MainInfo] Where ShowTitle='"& MainTitle &"'",Conn,1,1
		If Not TempRs.Eof Then
			b = GetMainInfoUrl(MainTitle)	
			If CheckMakeHtmlFile(b)=True Then
				b = GetHandleUrl(TempRs("FileName"))
				Call WebDebug(b, "act=MainInfo&ID=" & TempRs("Id"))
			End If
			q =   "[-|_]" & "<a " & AHref(b, TempRs("ShowTitle"), TempRs("Target")) & ">" & TempRs("ShowTitle") & "</a>"
			q = DisplayOnlineED2(WEB_ADMINURL &"MainInfo.Asp?act=ShowEdit&Id=" & TempRs("Id") & "&n=" & GetRnd(11), q, "<li|<a ")
		End If : TempRs.Close
		
		
	End If
	
	
	
	c = j & "[-|_]" & k & "[-|_]" & l & "[-|_]" & m & "[-|_]" & n & "[-|_]" & o & q
	
    XY_Position = i & f & InAfterToBeforeGetArray(c,g, f)
End Function


Function InAfterToBeforeGetArray(a, ByVal b, c)
	Dim d,e,f,g
	d=Split(a,"[-|_]")
	For e = Ubound(d) To 0 Step - 1	
		f = d(e)
		If f <>"" Then
			If g<>"" Then f = f & c
			g = f & g
			b=b-1
			If b<=0 Then Exit For
		End If
	Next
	InAfterToBeforeGetArray = g
End Function



Function XY_GetNavParam(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim i,j
	i = RParam(a,"TableName")
	j = RParam(a,"FieldName")
	XY_GetNavParam = GetNavParam(i,j,h)
End Function

Function XY_GetClassParam(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim i,j
	i = RParam(a,"TableName")
	j = RParam(a,"FieldName")
	XY_GetClassParam = GetClassParam(i,j,h)
End Function

Function XY_GetArticleParam(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim i,j
	i = RParam(a,"TableName")
	j = RParam(a,"FieldName")
	XY_GetArticleParam = GetArticleParam(i,j,h)
End Function

Function XY_GetMainParam(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim i,j
	i = RParam(a,"TableName")
	j = RParam(a,"FieldName")
	XY_GetMainParam = GetMainParam(i,j,h)
End Function

Function XY_GetDidAHrefUrl(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	XY_GetDidAHrefUrl = GetBigClassFileName(b)
End Function

Function XY_GetSidAHrefUrl(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	XY_GetSidAHrefUrl = GetSmallClassFileName(b,c)
End Function

Function XY_GetTidAHrefUrl(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	XY_GetTidAHrefUrl = GetThreeClassFileName(b,c,d)
End Function

Function XY_GetProductUrl(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim i
	If e<>"" Then i = "And Title='"& e &"'"
	i = GetWhereAnd(GetDidSidTidSQl(b,c,d),i)
	i = GetWhereAnd(i,h)
	
	
    TempRs.Open "Select * From [Product] " & i, Conn, 1, 1
    If Not TempRs.Eof Then
        XY_GetProductUrl = GetHandleUrl(TempRs("FileName"))
		Call WebDebug(XY_GetProductUrl,"act=CreateArticle&ID=" & TempRs("Id") )
    End If : TempRs.Close
End Function

Function XY_GetNavUrl(a)
	Dim b, c, d
	b = RParam(a,"Did")
	c = RParam(a,"Sid")
	
	
	d = GetNavUrl(b,c)
	XY_GetNavUrl = d
	
End Function

Function XY_NavDidExists(a)
	dim b,c,d
	b = RParam(a,"navdid")
	c = RParam(a,"valueStr")
	d = RParam(a,"defaultStr")
	
	if b=pubNavDid then
		XY_NavDidExists=c
	else
		XY_NavDidExists=d	
	end if

end Function

Function XY_SiteMap(a)
	Dim b,c, d
	c = RParam(a,"NavAddSql")
	d = RParam(a,"ClassAddSql")
	b = RParam(a,"class")
	
	
	
	XY_SiteMap = SiteMap(a)			
End Function



Function XY_QQLIStyleListShow(a)
	Dim b,c,d,e,f,g,h,i,j
	i = RParam(a,"ShowQQPhoto")
	Rs.Open "Select * From [QQMSN]", Conn, 1, 1
	If Not Rs.Eof Then
		b = Split(Rs("QQName"), "|")
		c = Split(Rs("QQNumber"), "|")
		j = Rs("QQStyle")
		
		For f = 0 To UBound(c)
			d=c(f) : e=b(f)
			If e <> "" Then
				
				g = "<li"& SetHtmlParam(a,"liclass") &">"
				If i = "true" Then
					e="<img src='http://wpa.qq.com/pa?p=1:"& d &":"& j &"' align='absmiddle'>" & e
				End If
				h=h & g &"<a target=blank href='tencent://message/?uin=" & d & "&Site=com&Menu=yes' "& SetHtmlParam(a,"aclass") &">"& e &"</a></li>" & vbCrlf
			End If
		Next
	End If : Rs.Close
	
	XY_QQLIStyleListShow = h
End Function

Function XY_OnLineQQPopup(a)
	Dim b, c, d,e,f,g,h,i,j
	Dim OnQQDialogue		
	Dim OnQQPopup			
	
	b = RParam(a,"QQList")
	c = RParam(a,"QQNameList")
	f = RParam(a,"Site")
	OnQQDialogue = RParam(a,"OnQQDialogue")
	OnQQPopup = RParam(a,"OnQQPopup")
	
	
	
	b=Replace(b, "，",",")
	c=Replace(c, "，",",")
	d = Split(b, ",")
	e = Split(c, ",")
	For g=0 To Ubound(d)
		h = d(g)
		i = ""
		If Ubound(e)>=g Then
			i = e(g)
		End If
		If OnQQDialogue="true" Then
			j=j & "window.location.href='tencent://message/?uin="& h &"&Site="& f &"&Menu=yes';" & vbCrlf
		End If
		If OnQQPopup = "true" Then
			j=j & "window.location.href='tencent://AddContact/?fromId=50&fromSubId=1&subcmd=all&uin="& h &"';" & vbCrlf
		End If
	Next
	If j <>"" Then
		j="<script>"& j &"</script>"
	End If
	XY_OnLineQQPopup = j
End Function

Function XY_GetOnLineQQUrl(a)
	Dim b,c,d,e,f
	b = RParam(a,"Title")
	c = RParam(a,"QQList")
	c = Replace(Replace(Replace(c," ",""),",","|"),"，","|")
	d = RParam(a,"AutoAdd")
	e = RParam(a,"IsOnlineChat")
	f = RParam(a,"IsAddFriend")
	
	Rs.Open"Select * From [OnLineQQ] Where Title='"& b &"'",Conn,1,3
	If Not Rs.Eof Then
		XY_GetOnLineQQUrl = "javascript:OnLineQQ('"& Rs("QQ") &"',"& LCase(Rs("IsOnlineChat")) &", "& LCase(Rs("IsAddFriend")) &");"
	ElseIf d="true" Then
		Rs.AddNew
		Rs("Title") = b
		Rs("QQ") = c
		Rs("IsOnlineChat") = IIF(e="true",True,False)
		Rs("IsAddFriend") = IIF(f="true",True,False)
		Rs.Update
		XY_GetOnLineQQUrl = "javascript:OnLineQQ('"& c &"',"& e &", "& f &");"
	End If:Rs.Close
	XY_GetOnLineQQUrl = XY_GetOnLineQQUrl & """" & getControlStr(""& adminDir &"OnLineQQManage.Asp") & """"
		
	
End Function


Function XY_ShowPhotoList(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim i,j, k,l,m,n,o,p,q,r,s,t,u,v,w,x
	Call XY_AutoAddHandle(a)			
	
	k = RParam(a,"SplTypeStr")
	p = LCase(RParam(a,"AYes"))
	x = LCase(RParam(a,"AImg"))
	r = LCase(RParam(a,"SplStartStr"))
	s = LCase(RParam(a,"SplEndStr"))
	j = "Select * From [Product] Where BigClassName='"& b &"'"
	j = GetWhereAnd(j,h)
	
	Rs.Open j,Conn,1,1
	For l=1 To f
		If Rs.Eof Then Exit For
		
		q = Rs("FileName")
		If CheckMakeHtmlFile(q)=True Then
			q = GetHandleUrl( Rs("FileName") )
			Call WebDebug(q,"act=CreateArticle&ID=" & Rs("Id") )
		End If
		
		t = IIF(Rs("SmallFiles")<>"",Rs("SmallFiles"),Rs("BigFiles"))
		n = ""
		If x = "true" Then
			n = "<img src='"& t &"'" & SetHtmlParam(a,"imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") &">"
		End If
		If p="true" Then
			n="<a href='"& q &"'" & SetHtmlParam(a,"target|title|alt|id|class") &">"& n &"</a>"
		End If
		n = r & n & k & s & vbCrlf
		 	u = "<a src='" & Rs("BigFiles") & "'" & SetHtmlParam(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
			v = AHref(q, Rs("Title"), Rs("Target")) & SetHtmlParam(a, "aclass")
			w = "<img src='" & t & "'" & SetHtmlParam(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
			
			
			
			n = Replace(n,"[$i$]",l)
			n = Replace(n,"[$i-1$]",l-1)
			
			For m=1 To 6
				n = ReplaceValueParam(n,"ni",l)								
				n = ReplaceValueParam(n,"编号-1",l-1)								
				n = ReplaceValueParam(n,"编号",l)								
				n = ReplaceValueParam(n,"title",Rs("Title"))
				n = ReplaceValueParam(n,"showtitle",ShowTitle)
				n = ReplaceValueParam(n,"adddatetime",Rs("AddDateTime"))
				n = ReplaceValueParam(n,"imgfile",t)
				n = ReplaceValueParam(n,"imgurl",t)
				n = ReplaceValueParam(n,"url",q)
				n = ReplaceValueParam(n,"aurl",v)
				n = ReplaceValueParam(n,"astr",u)
				n = ReplaceValueParam(n,"description",Rs("WebDescription"))
				n = ReplaceValueParam(n,"content",Rs("Content"))
				n = ReplaceValueParam(n,"price",Rs("Price"))
				n = ReplaceValueParam(n,"author",Rs("Author"))
			Next
			
			n = DisplayOnlineEditDialog(""& adminDir &"Product.Asp?act=ShowEditProduct&Id=" & Rs("Id") & "&n=" & GetRnd(11), n)
			
		o=o & n
	Rs.MoveNext:Next:Rs.Close
	XY_ShowPhotoList=o
End Function

Sub GetTemplateSplit(a,b,c,d)
	Dim e,f
	
	e = "<!--#DialogStart#-->" : f = "<!--#DialogStartEnd#-->"
	If InStr(a,e)>0 And InStr(a,f)>0 Then
		b = StrCut(a,e,f,2)
	End If
	
	e = "<!--#TemplateSplitStart#-->" : f = "<!--#TemplateSplitEnd#-->"
	If InStr(a,e)>0 And InStr(a,f)>0 Then
		c = StrCut(a,e,f,2)
	End If
	
	e = "<!--#DialogEnd#-->" : f = "<!--#DialogEndEnd#-->"
	If InStr(a,e)>0 And InStr(a,f)>0 Then
		d = StrCut(a,e,f,2)
	End If
End Sub

Function XY_ShowAppointProductList(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Call XY_AutoAddHandle(a)			
	
	Dim j, k,l,m,n,o,p,q,r,s,t,u,v,w,x
	Dim y,z,aa
	
	t = RParam(a,"TemplateId")
	u = ReadTemplateSource(t)
	Call GetTemplateSplit(u,v,w,x)		
	
	j = "Select * From [Product] Where BigClassName='"& b &"'"
	j = GetWhereAnd(j,h)
	Rs.Open j,Conn,1,1
	For k=1 To f
		If Rs.Eof Then Exit For
		
		o = Rs("FileName")
		If CheckMakeHtmlFile(o)=True Then
		o = GetHandleUrl( Rs("FileName") )
			Call WebDebug(o,"act=CreateArticle&ID=" & Rs("Id") )
		End If
		
		q = IIF(IsNul(Rs("SmallFiles")),Rs("BigFiles"),Rs("SmallFiles"))
		p = "<img src='"& q &"'" & SetHtmlParam(a,"imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") &">"
		
		r = "<a src='"& Rs("BigFiles") &"'" & SetHtmlParam(a,"imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") &">"
        y = CutStr(Rs("Title"), g, "... ")
        y = FontColorFontB(y, Rs("FontB"), Rs("FontColor"))		
		r = "<a " & AHref(o, Rs("Title"), Rs("Target")) & SetHtmlParam(a,"aclass") &">" & y & "</a>" & vbCrLf
		s = AHref(o, Rs("Title"), Rs("Target")) & SetHtmlParam(a,"aclass")
		
		l = Replace(w,"[$title$]",y)
		z = IIF(isNul(Rs("Price")),0,Rs("Price"))
		l = Replace(l,"[$price$]",z)
		l = Replace(l,"[$url$]",s)
		aa = IIF(isNul(Rs("WebDescription")),"",Rs("WebDescription"))
		l = Replace(l,"[$productabout$]",aa)
		l = Replace(l,"[$showimages$]",p)
		l = Replace(l,"[$imgfile$]",q)
		l = Replace(l,"[$imgurl$]",q)
		
		m=m & l
	Rs.MoveNext:Next:Rs.Close
	XY_ShowAppointProductList= v & m & x
End Function

Function XY_zoomImage(a)
	dim b,c, d, e, f, g, h, i,j,k,l
	b = RParam(a,"imageFilePath")
	
	if checkFile(b)=false then
		exit function
	end if
	call getImageWidthHeight(b,c,d)			
	
	e = RParam(a,"nSetWidth")
	f = RParam(a,"nSetHeight")
	g = RParam(a,"nLeft")
	h = RParam(a,"nTop")
	
	k = RParam(a,"nWrapWidth")					
	l = RParam(a,"nWrapHeight") 					
	
	i = RParam(a,"sType")
	if i<>"" then i="|"& i &"|"
	
	
	
	
	j=zoomImage(k,l,c, d, e, f, g, h, i)
	XY_zoomImage=j
end function

Function XY_PopularSearchesList(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim j
	j = RParam(a,"SplTypeStr")
	XY_PopularSearchesList = PopularSearchesList(a,f,j,h)
End Function

Function XY_SmallClassList(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Call XY_AutoAddHandle(a)			
	
	Dim j,k
	j=RParam(a,"LiClass")
	k=RParam(a,"AClass")
	
	
	Dim l,m
	l = SmallClassList(b, j, k, h)
	
	i = RParam(a,"ULClass")
	If i<>"" Then
		m = vbCrlf & "<ul class='"& i &"'>"
	Else
		m = vbCrlf & "<ul>"
	End If
	
	m = m & vbCrlf & l & vbCrlf & "</ul>" & vbCrlf	
	XY_SmallClassList = m
End Function

Function XY_CustomSmallClassList(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)		
	Call XY_AutoAddHandle(a)			
	Dim i,j,k,l,m,n,o,p,q,r,s
	j = GetDefaultValue(a)
	i = "Select * From [SmallClass]" & GetDidSidTidSQl(b,"","")
	i =  GetWhereAnd(i,h)		
	Rs.Open i,Conn,1,1
	For k = 1 To f
		If Rs.Eof Then Exit For
		n="[list-"& k &"]" : o="[/list-"& k &"]"
		
		If InStr(j,n)=False Then
			n="[list]" : o="[/list]"
		End If
		If InStr(j,n)>0 And InStr(j,o)>0 Then
			l = StrCut(j,n,o,2)
						
			l = Replace(l,"[$bigclassname$]",Rs("BigClassName"))
			l = Replace(l,"[$smallclassname$]",Rs("SmallClassName"))
			
			
			p = GetSmallClassFileName( Rs("BigClassName"), Rs("SmallClassName") )
			Call WebDebug(p,"act=CreateClass&ProDid=" & Rs("BigClassName") & "&ProSid=" & Rs("SmallClassName") & "&page=1")
			l = Replace(l,"[$url$]",p)
						
			
			n="[list-"& k &" startdialog]" : o="[/list-"& k &" startdialog]"
			If InStr(j,n)>0 And InStr(j,o)>0 Then
				l = StrCut(j,n,o,2) & l
			End If
			
			n="[list-"& k &" enddialog]" : o="[/list-"& k &" enddialog]"
			If InStr(j,n)>0 And InStr(j,o)>0 Then
				l = l & StrCut(j,n,o,2)
			End If			
			m = m & l
		End If	
	Rs.MoveNext:Next:Rs.Close
	
	
	n="[dialog start]" : o="[/dialog start]"
	If InStr(j,n)>0 And InStr(j,o)>0 Then
		m = StrCut(j,n,o,2) & m
	End If
	
	n="[dialog end]" : o="[/dialog end]"
	If InStr(j,n)>0 And InStr(j,o)>0 Then
		m = m &  StrCut(j,n,o,2)
	End If
	
	XY_CustomSmallClassList = m
End Function

Function XY_ThreeClassList(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Call XY_AutoAddHandle(a)			
	Dim TidAType									
	TidAType = RParam(a,"TidAType")	
	
	Dim k,l
	k=RParam(a,"ThreeLiCss"):l=RParam(a,"ThreeACss")
	Dim m,n
	
	m = ThreeClassList(b,k, l, TidAType, h)
	
	i = RParam(a,"ULClass")
	If i<>"" Then
		n = vbCrlf & "<ul class='"& i &"'>"
	Else
		n = vbCrlf & "<ul>"
	End If
	
	n = n & vbCrlf & m & vbCrlf & "</ul>" & vbCrlf	
	XY_ThreeClassList = n
End Function


Function XY_RecommendNavigation(a)
	Dim b,c,d,e,f,g,h,i,j
	Dim k
	Dim l,m,n,Content	
	
	h = PubNavDid
	If h="" Then h=PubProDid
	
	
	
	
	
	
	k = RParam(a,"UlClass")	
	If k <> "" Then k = " class="""& k &""""
	
	l = "推荐导航"
	m = "推荐导航"
	n = "true"
	Content = ReadMainInfo(l)
	If Content="" Then
		Content = GetDefaultValue(a)
		
		If LCase(n)="true" Then
			Call AutoAddMainInfo(l,m,Content)
			Conn.Execute("Update [MainInfo] Set DispalyEditor=False Where Title='"& l &"'")
		End If
	End If
	Content = TrimVbCrlf(Content)
	c=Split(Content,vbCrlf)
	For Each f In c
		f = TrimVbCrlf(f)
		If f<>"" Then
			j = f
			If InStr("，"& f &"，","，"& h &"，")>0 Then
				Exit For
			End If
		End If
	Next
	
	j=Replace(j,"," , "，")
	j=Replace(Replace(j,"\，","【撇分号】"), "\|", "【撇分割】")
	If j<>"" Then
		c=Split(j,"，")
		For Each f In c
			d=Split(f & "||", "|")
 			l=d(0):m=IIF(d(1)="",d(0),d(1)):i=d(2)
				
				If i="" Then
					i = GetNavUrl(l,"")
				End If
				
				If i="" Then
					i = GetClassUrl(l,"","")
				End If
				
				If i="" Then
					i = GetMainUrl(l)
				End If
			
			If l=h Then
				m="<font color=red>"& m &"</font>"
			End If
			
			g = g & "<li><a href="""& i &""">"& m &"</a></li>" & vbCrlf
		Next
	End If
	b = ReadMainId("推荐导航")
	If b<>"" And Request("gl") = "edit" Then
		g = DisplayOnlineEditDialog(""& adminDir &"MainInfo.Asp?act=ShowEdit&Id=" & b & "&n=" & GetRnd(11), g)
	End If
	
	g= "<ul"& k &">"& g &"</ul>"
	XY_RecommendNavigation = g
End Function


Function XY_CustomTwoDirectoryClassList(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)		
	Dim i,j,k,l,m,n,o,p,q,r,s,t,u,v
	Dim w,x,y
	Dim SidAType									
	Dim TidAType									
	Dim SmallUrl									
	Dim SmallAddSql									
	SmallAddSql = RParam(a,"SmallAddSql")	
	
	i = GetDefaultValue(a)
	t = RParam(a,"DefaultImage")	
	SidAType = RParam(a,"SidAType")	
	TidAType = RParam(a,"TidAType")	
	
	
	y = "Select * From [SmallClass]" & GetDidSidTidSQl(b,"","")
	y =  GetWhereAnd(y,h)		
	Rs.Open y,Conn,1,1
	For j = 1 To Rs.RecordCount
		n="[smalllist-"& j &"]" : o="[/smalllist-"& j &"]"
		
		If InStr(i,n)=False Then
			n="[smalllist]" : o="[/smalllist]"
		End If
		w="":x=""
		If InStr(i,n)>0 And InStr(i,o)>0 Then
			x = StrCut(i,n,o,2) & vbCrlf
			x=Replace(x, "[$smallname$]", Rs("SmallClassName"))
			
			SmallUrl = getClassUrl(Rs("BigClassName"),Rs("SmallClassName"),"")					
			
			x = Replace(x, "[$smallurl$]", SmallUrl)
			
			
			y = "Select * From [ThreeClass] Where BigClassName='"& Rs("BigClassName") &"' And SmallClassName='"& Rs("SmallClassName") &"'"
			y =  GetWhereAnd(y,SmallAddSql)		
			Rsx.Open y,Conn,1,1
			For k = 1 To Rsx.RecordCount
				n="[threelist-"& j &"]" : o="[/threelist-"& j &"]"
				
				If InStr(i,n)=False Then
					n="[threelist]" : o="[/threelist]"
				End If
				If InStr(i,n)>0 And InStr(i,o)>0 Then
					l = StrCut(i,n,o,2) & vbCrlf
					p = GetThreeClassFolderName( Rsx("BigClassName"), Rsx("SmallClassName"), Rsx("ThreeClassName")) 		
					
					
					Call WebDebug(p,"act=CreateClass&ProDid=" & b & "&ProSid=" & Rs("SmallClassName"))
					If TidAType="文本类型" Then
						p = "{$GetProductUrl did='"& Rsx("BigClassName") &"' sid='"& Rsx("SmallClassName") &"' tid='"& Rsx("ThreeClassName") &"' title='"& Rsx("ThreeClassName") &"'$}"
					End If		
								
					l = Replace(l, "[$smallname$]", Rsx("SmallClassName"))
					l = Replace(l, "[$threename$]", Rsx("ThreeClassName"))
					l = Replace(l, "[$threeurl$]", p)
					
					
					
					l = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & Rsx("Id") & "&n=" & GetRnd(11), l, "<li|<a ")
					
					w=w & l & vbCrlf
					
				End If
			Rsx.MoveNext:Next:Rsx.Close
		End If
		
		n="[smalldialog start]" : o="[/smalldialog start]"
		If InStr(i,n)>0 And InStr(i,o)>0 Then
			w = StrCut(i,n,o,2) & vbCrlf & w
		End If
		
		n="[smalldialog end]" : o="[/smalldialog end]"
		If InStr(i,n)>0 And InStr(i,o)>0 Then
			w = w & vbCrlf & StrCut(i,n,o,2)
		End If
		
		
		
		x = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & Rs("Id") & "&n=" & GetRnd(11), x, "<li|<a ")
		
		
		
		m=m & x & w & vbCrlf				
			
	Rs.MoveNext:Next:Rs.Close
	
	
	n="[dialog start]" : o="[/dialog start]"
	If InStr(i,n)>0 And InStr(i,o)>0 Then
		m = StrCut(i,n,o,2) & vbCrlf & m
	End If
	
	n="[dialog end]" : o="[/dialog end]"
	If InStr(i,n)>0 And InStr(i,o)>0 Then
		m = m & vbCrlf &   StrCut(i,n,o,2)
	End If
	
	
	XY_CustomTwoDirectoryClassList = m
End Function

Function XY_News(a)
	Dim b,c,d,e,f,g,h,i,j,k,l
	Call HandleFunParameter(a,b,c,d,e,f,g,h)		
	Dim m,n,o,p,q
	Dim CssStyle															
	Dim ContentWidth														
	ContentWidth = LCase(Trim(RParam(a,"ContentWidth")))				
	If ContentWidth<>"" Then
		If Right(ContentWidth,1)<>"%" And Right(ContentWidth,1)<>"px" Then
			ContentWidth = ContentWidth & "px"
		End If
	End If
	If ContentWidth <>"" Then
		CssStyle = " style=""width:"& ContentWidth &";"""
	End If
	
	
	
	If CheckBigClass(b) = 0 Then
		i = RParam(a,"AutoAddDid")
		If LCase(i)="true" Then
			Call AutoAddBigClass(b)
		End If		
	End If
	
	If CheckSmallClass(b,c) = 0 Then
		p = RParam(a,"AutoAddSid")
		If LCase(p)="true" Then
			Call AutoAddSmallClass(b,c)
		End If		
	End If
	
	If CheckThreeClass(b,c,d) = 0 Then
		q = RParam(a,"AutoAddTid")
		If LCase(q)="true" Then
			Call AutoAddThreeClass(b,c,d)
		End If		
	End If
	
	If CheckProduct(b,c,d)=0 Then				
		j = RParam(a,"AutoAdd")
		If LCase(j)="true" Then
		 	For k = 1 To f
				Call AutoAddArticle(b, c, d, b & "-标题" & k, b & "-内容" & k)		
			Next
		End If	
	End If
	o = RParam(a,"DateYes")						
	m =  NewsList(b,f,"<li>","</li>" & vbCrlf,o, a)
	l = RParam(a,"ULClass")
	If l<>"" Then
		n = vbCrlf & "<ul class='"& l &"'"& CssStyle &">"
	Else
		n = vbCrlf & "<ul>"
	End If
	n = n & vbCrlf & m & vbCrlf & "</ul>" & vbCrlf	
	XY_News = n
End Function

Function XY_CustomInfoList(a)
	XY_CustomInfoList=HandleDispalyArticleList(a,"")
End Function

Function XY_RelatedInformationList(a)
	Dim b,c,d,e,f,g,h
	e = RParam(a,"DefaultRelatedLableList")	
	c = RParam(a,"AddSql")	
	d = RParam(a,"DefaultAddSql")	
	d = HandleInModule(d,"end")
	
	If PubId<>"" Then
		b = GetWhereAnd(b, "And Id<>" & PubId)
		Rs.Open"Select * From [Product] Where Id=" & PubId,Conn,1,1
		If Not Rs.Eof Then
			If Rs("RelatedTags")<>"||" And Rs("RelatedTags")<>"" Then
				e = Rs("RelatedTags")
				
			End If
		End If:Rs.Close
	Else
		b = GetWhereAnd(b & " ",d)
	End If
	e = Replace(e,"'","")		
	
	If e<>"" Then
		f=Split(e,"|")
		For Each g In f
			If g<>"" Then
				g = "|"& g &"|"
				b = GetWhereAnd(b, "And RelatedTags Like '%"& g &"%'")
			End If	
		Next
	Else
		b = GetWhereAnd(b & " ",d)
	End If
	b =  GetWhereAnd(b & " ",c)
	
	XY_RelatedInformationList = HandleDispalyArticleList(a,b)
End Function

Function HandleDispalyArticleList(a,b)
	Dim c,d,e,f,g,h,i
	Call HandleFunParameter(a,c,d,e,f,g,h,i)		
	Call XY_AutoAddHandle(a)			
	Dim j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
	Dim DescriptionLabel					
	Dim WebDescription						
	Dim Price								
	Dim Content								
	Dim noFollow							
	j = GetDefaultValue(a)		
	Dim fa,ga,ha,ia
	Dim ArticleDescription		
	Dim ModI								
	Dim HtmlCode							
	Dim ma,na
	dim tempCode							
	dim replaceStrName						
	dim defaultaddcontent					
	dim addContent							
	dim dispalyPage							
	dim nPageSize							
	defaultaddcontent = ModuleFindContent(a,"defaultaddcontent")
	
	
	
	replaceStrName = RParam(a,"replacestrname")
	
	dispalyPage =lcase(RParam(a,"dispalyPage"))
	nPageSize =lcase(RParam(a,"nPageSize"))
	
	
	
	o="[htmlcode]" : p="[/htmlcode]"
	If InStr(j,o)>0 And InStr(j,p)>0 Then
		HtmlCode = StrCut(j,o,p,2)
	End If
	Dim ua,va,wa,xa,ya,za
	
	
	If CheckBigClass(c) = 0 Then
		fa = RParam(a,"AutoAddDid")
		If LCase(fa)="true" Then
			Call AutoAddBigClass(c)
		End If		
	End If
	
	If CheckSmallClass(c,d) = 0 Then
		ga = RParam(a,"AutoAddSid")
		If LCase(ga)="true" Then
			Call AutoAddSmallClass(c,d)
		End If		
	End If
	
	If CheckThreeClass(c,d,e) = 0 Then
		ha = RParam(a,"AutoAddTid")
		If LCase(ha)="true" Then
			Call AutoAddThreeClass(c,d,e)
		End If		
	End If
	
	If CheckProduct(c,d,e)=0 Then				
		ia = RParam(a,"AutoAdd")
		
		If LCase(ia)="true" Then
		 	For k = 1 To g
				if defaultaddcontent<>"" then
					m = defaultaddcontent					
					m = ReplaceValueParam(m,"ni",k)								
					m = ReplaceValueParam(m,"编号-1",k-1)								
					m = ReplaceValueParam(m,"编号",k)								
					m = ReplaceValueParam(m,"did",  c)
					m = ReplaceValueParam(m,"sid",  d)	
					m = ReplaceValueParam(m,"tid",  e)	
				else
					m = c & "-内容"
				end if
				
				
				Call autoAddArticleAction(a,c, d, e, c & "-标题" & k,"", m)
				
			Next
		End If
	End If
	
	x = RParam(a,"DefaultImage")	
	y = RParam(a,"RndShow")	
	noFollow = Trim(LCase(RParam(a,"noFollow")))	
	
	If b="" Then
		b = "Select * From [Product]" & GetDidSidTidSQl(c,d,e)
		b =  GetWhereAnd(b,i)	
		Rs.Open b,Conn,1,1
		
		If y="true" Then
			z = GetProductRndIdList(Rs,g)
			b = "Select * From [Product] Where Id In("& z &")"
			
			Rs.Close
			Rs.Open b,Conn,1,1
		End If
	Else
		b = "Select * From [Product]" & b
		
		Rs.Open b,Conn,1,1
	End If
	
	
	dim abb,bbb,cbb,dbb
	if nPageSize="" then
		nPageSize=999
	end if
	
	abb = rs.RecordCount
	bbb = Request("page")
	cbb = getRsPageNumber(rs, abb, nPageSize, bbb)

	For k = 1 To g
		If Rs.Eof Then Exit For
		o="[list-"& k &"]" : p="[/list-"& k &"]"
		
		
		For ModI=6 To 2 Step -1
			If InStr(j,o)=False And k Mod ModI =0 Then
				o="[list-mod"& ModI &"]" : p="[/list-mod"& ModI &"]"
				If InStr(j,o)>0 Then
					
					Exit For
				End If
			End If
		Next
		
		
		If InStr(j,o)=False Then
			o="[list]" : p="[/list]"
		End If
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			m = StrCut(j,o,p,2)
			
			q = Rs("FileName")
			If CheckMakeHtmlFile(q)=True Then
				q = GetHandleFileName(q)
				q = DetailPageAddHtmlPrefix(Rs("FolderName")) & q
			End If
			
			if Rs("CustomAUrl")<>"" then
				q=rs("CustomAUrl")
			end if
			
			Call WebDebug(q, "act=CreateArticle&ID=" & Rs("Id"))
			
			r = AHref(q, Rs("Title"), Rs("Target"))
			
			s = "<a " & AHref(q, Rs("Title"), Rs("Target")) & SetHtmlParam(a, "aclass") & IIF(noFollow="true"," rel='nofollow'","") & ">" & u & "</a>" & vbCrLf
			
			
			WebDescription = Rs("WebDescription")
			
			u = CutStr(Rs("Title"), h, "... ")
			u = FontColorFontB(u, Rs("FontB"), Rs("FontColor"))			
			
			w = IIF(IsNul(Rs("SmallFiles")),Rs("BigFiles"),Rs("SmallFiles"))			
			If w="" Then w=x				
			
			t = ImgSrc(w, Rs("Title"), Rs("Target"))
			
			ArticleDescription = Rs("ArticleDescription")								
			If ArticleDescription="#" Or ArticleDescription="null" Or ArticleDescription="empty" Then
				ArticleDescription = ""
			ElseIf IsNul(ArticleDescription) Then
				ArticleDescription = Rs("Content")
			End If	
			
			For l=1 To 3
				m = ReplaceValueParam(m,"ni",k)								
				m = ReplaceValueParam(m,"编号-1",k-1)								
				m = ReplaceValueParam(m,"编号",k)								
				
				
				
				
				
				
				m = ReplaceValueParam(m,"id",  Rs("Id"))
				m = ReplaceValueParam(m,"title",  Rs("Title"))
				m = ReplaceValueParam(m,"showtitle",u)
				m = ReplaceValueParam(m,"adddatetime",Rs("AddDateTime"))
				m = ReplaceValueParam(m,"imgfile",w)
				m = ReplaceValueParam(m,"imgurl",w)
				m = ReplaceValueParam(m,"url",q)
				m = ReplaceValueParam(m,"aurl",r)
				m = ReplaceValueParam(m,"aimg",t)				
				m = ReplaceValueParam(m,"astr",s)
				m = ReplaceValueParam(m,"description",Rs("WebDescription"))
				m = ReplaceValueParam(m,"content",Rs("Content"))
				m = ReplaceValueParam(m,"price",Rs("Price"))			
				m = ReplaceValueParam(m,"memberprice",Rs("memberprice"))			
				m = ReplaceValueParam(m,"newprice",Rs("NewPrice"))		
				m = ReplaceValueParam(m,"sold",Rs("sold"))				
				m = ReplaceValueParam(m,"author",Rs("Author"))
				m = ReplaceValueParam(m,"productabout",Rs("WebDescription"))
				m = ReplaceValueParam(m,"articledescription",ArticleDescription)
			Next
			
			q = ""& adminDir &"Product.Asp?act=ShowEditProduct&Id=" & Rs("Id") & "&n=" & GetRnd(11)
			m = DisplayOnlineEditDialog(q, m)
			
			
			
			
			o="[list-"& k &" startdialog]" : p="[/list-"& k &" startdialog]"
			If InStr(j,o)>0 And InStr(j,p)>0 Then
				m = StrCut(j,o,p,2) & m
			End If
			
			o="[list-"& k &" enddialog]" : p="[/list-"& k &" enddialog]"
			If InStr(j,o)>0 And InStr(j,p)>0 Then
				m = m & StrCut(j,o,p,2)
			End If
			
			if replaceStrName<>"" then
				call addModuleReplaceArray(replaceStrName & k,m)
			else
				n = n & m
			end if
		End If	
	Rs.MoveNext:Next:Rs.Close
	
	
	o="[dialog start]" : p="[/dialog start]"
	If InStr(j,o)>0 And InStr(j,p)>0 Then
		n = StrCut(j,o,p,2) & n
	End If
	
	o="[dialog end]" : p="[/dialog end]"
	If InStr(j,o)>0 And InStr(j,p)>0 Then
		n = n &  StrCut(j,o,p,2)
	End If
	
	If HtmlCode<>"" Then
		ya=0:za=0
		ma=Split(n, "[$vbCrlf$]") : n=""
		For k=0 To Ubound(ma)
			m = ma(k)
			
			If k=0 Then
				m = Replace(m,"[noneOrblack]","black")
			Else
				m = Replace(m,"[noneOrblack]","none")
			End If
			
			If m <> "" And InStr(m, "[$Array$]") Then 		
				If (k+1) Mod 2=0 Then
					m = Replace(m,"[@i@]",ya)
					ya=ya+1				
				Else
					m = Replace(m,"[@i@]",za)
					za=za+1				
				End If		
				na=Split(m, "[$Array$]")
				
				If (k+1) Mod 2=0 Then
					wa = wa & na(0)
					xa = xa & na(1)	
				Else
					ua = ua & na(0)
					va = va & na(1)
				End If
			End If
		Next
		HtmlCode = Replace(HtmlCode,"[$Module_1$]", ua)
		HtmlCode = Replace(HtmlCode,"[$Module_2$]", va)
		HtmlCode = Replace(HtmlCode,"[$Module_3$]", wa)
		HtmlCode = Replace(HtmlCode,"[$Module_4$]", xa)
		n = HtmlCode
	End If
	
	
		
	dim ebb,fbb,gbb,hbb,pageStr	
	If bbb <= 1 Then
		
		
		o="[defaultHomePageStr]" : p="[/defaultHomePageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			ebb = StrCut(j,o,p,2)
		else
			ebb = "<span class='PageBox'>首页</span> &nbsp;"
		end if
		
		
		o="[defaultParentPageStr]" : p="[/defaultParentPageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			fbb = StrCut(j,o,p,2)
		else
	        fbb = "<span class='PageBox'>上一页</span> &nbsp;"
		end if
    Else		
		
		q=mid(CreateHtmlPath,1,instrrev(CreateHtmlPath,".")-1) & "" & mid(CreateHtmlPath,instr(CreateHtmlPath,"."))
		q=replace(q,"///","/")
		Call WebDebug(q, GetUrlAddToParam(GetUrl(),"&page=1","replace"))
		
		o="[homePageStr]" : p="[/homePageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			ebb = StrCut(j,o,p,2)
		else
			ebb = "<a href=""[$url$]"">首页</a> &nbsp;"
		end if
		ebb=replace(ebb,"[$url$]",q)
		
		
		q=mid(CreateHtmlPath,1,instrrev(CreateHtmlPath,".")-1) & "_" & (bbb-1) & mid(CreateHtmlPath,instr(CreateHtmlPath,"."))
		q=replace(q,"///","/")
		Call WebDebug(q,  GetUrlAddToParam(GetUrl(),"&page=" & bbb-1,"replace") )
		o="[parentPageStr]" : p="[/parentPageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			fbb = StrCut(j,o,p,2)
		else
			fbb = "<a href=""[$url$]"">上一页</a> &nbsp;"
		end if
		fbb=replace(fbb,"[$url$]",q)
	
		
		
	end if
	

    If bbb >= dbb Then
	
		
		o="[defaultNextPageStr]" : p="[/defaultNextPageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			gbb = StrCut(j,o,p,2)
		else
			gbb = "<span class='PageBox'>下一页</span> &nbsp;"
		end if
		
		
		o="[defaultEndPageStr]" : p="[/defaultEndPageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			hbb = StrCut(j,o,p,2)
		else
	        hbb = "<span class='PageBox'>尾页</span>"
		end if

    Else
		
		if CreateHtmlPath<>"" then
			
			q=mid(CreateHtmlPath,1,instrrev(CreateHtmlPath,".")-1) & "_" & (bbb+1) & mid(CreateHtmlPath,instr(CreateHtmlPath,"."))
		end if
		q=replace(q,"///","/")
		Call WebDebug(q,  GetUrlAddToParam(GetUrl(),"&page=" & bbb+1,"replace")  )
		
		o="[nextPageStr]" : p="[/nextPageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			gbb = StrCut(j,o,p,2)
		else
			gbb = "<a href=""[$url$]"">下一页</a> &nbsp;"
		end if
		gbb=replace(gbb,"[$url$]",q)
	
		if CreateHtmlPath<>"" then
			
			q=mid(CreateHtmlPath,1,instrrev(CreateHtmlPath,".")-1) & "_" & dbb & mid(CreateHtmlPath,instr(CreateHtmlPath,"."))
		end if
		q=replace(q,"///","/")
		Call WebDebug(q,  GetUrlAddToParam(GetUrl(),"&page=" & dbb,"replace")  )
		
		o="[endPageStr]" : p="[/endPageStr]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			hbb = StrCut(j,o,p,2)
		else
			hbb = "<a href=""[$url$]"">尾页</a> &nbsp;"
		end if
		hbb=replace(hbb,"[$url$]",q)
	end if
	
	pageStr = ebb & fbb & gbb & hbb	
	if dispalyPage="true" or dispalyPage="1" then	
		
		o="[page]" : p="[/page]"
		If InStr(j,o)>0 And InStr(j,p)>0 Then
			m = StrCut(j,o,p,2)
			m=replace(m,"[$homePageStr$]",ebb)				
			m=replace(m,"[$parentPageStr$]",fbb)			
			m=replace(m,"[$nextPageStr$]",gbb)				
			m=replace(m,"[$endPageStr$]",hbb)				
			m=replace(m,"[$Page$]",bbb)							
			m=replace(m,"[$MaxPage$]",dbb)						
			m=replace(m,"[$nCount$]",abb)						
			n=n & m
		else		
			n = n & "<div class='t_page ColorLink'>总数：" & abb & "条&nbsp;&nbsp;当前页数：<span class='FontRed'>" & bbb & "</span>/" & dbb & "&nbsp;" & pageStr & "</div>"
		end if
	end if
	
	HandleDispalyArticleList = n
End Function



Function XY_CustomGuestBookList(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)		
	Call XY_AutoAddHandle(a)			
	Dim i,j,k,l,m,n,o,p,q,r,s
	j = GetDefaultValue(a)
	
	
	i = "Select * From [GuestBook]" & GetDidSidTidSQl(b,c,d)
	i =  GetWhereAnd(i,h)		
	Rs.Open i,Conn,1,1
	For k = 1 To f
		If Rs.Eof Then Exit For
		n="[list-"& k &"]" : o="[/list-"& k &"]"
		
		If InStr(j,n)=False Then
			n="[list]" : o="[/list]"
		End If
		If InStr(j,n)>0 And InStr(j,o)>0 Then
			l = StrCut(j,n,o,2)
						
			l = ReplaceValueParam(l,"guestname",Rs("GuestName"))			
			l = ReplaceValueParam(l,"email",Rs("EMail"))					
			l = ReplaceValueParam(l,"tel",Rs("Tel"))						
			l = ReplaceValueParam(l,"qq",Rs("QQ"))							
			l = ReplaceValueParam(l,"ip",Rs("IP"))							
			l = ReplaceValueParam(l,"content",Rs("Content"))				
			l = ReplaceValueParam(l,"reply",Rs("Reply"))					
			
			
			
			n="[list-"& k &" startdialog]" : o="[/list-"& k &" startdialog]"
			If InStr(j,n)>0 And InStr(j,o)>0 Then
				l = StrCut(j,n,o,2) & l
			End If
			
			n="[list-"& k &" enddialog]" : o="[/list-"& k &" enddialog]"
			If InStr(j,n)>0 And InStr(j,o)>0 Then
				l = l & StrCut(j,n,o,2)
			End If			
			m = m & l
		End If	
	Rs.MoveNext:Next:Rs.Close
	
	
	n="[dialog start]" : o="[/dialog start]"
	If InStr(j,n)>0 And InStr(j,o)>0 Then
		m = StrCut(j,n,o,2) & m
	End If
	
	n="[dialog end]" : o="[/dialog end]"
	If InStr(j,n)>0 And InStr(j,o)>0 Then
		m = m &  StrCut(j,n,o,2)
	End If
	
	XY_CustomGuestBookList = m
End Function

Function XY_ShowNewsList(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)		
	Dim i,j,k,l,m
	Call XY_AutoAddHandle(a)			
	
	Dim n,o,p,q,r,s,t,u,v
	u = RParam(a,"DateYes")						
	v = RParam(a,"NewsStyle")					
	o="<ul" & SetHtmlParam(a,"ulclass") &">"
	q = "Select * From [Product]" & GetDidSidTidSQl(b,c,d) & GetWhereAnd(q,h)
	If v<>"" And v<>"default" Then
		m = "Select * From [Product]" & GetDidSidTidSQl(b,c,d)
		m =  GetWhereAnd(m," Where (BigFiles<>'' Or SmallFiles<>'')")
		m =  GetWhereAnd(m,h)
		
		Rs.Open m,Conn,1,1
		If Not Rs.Eof Then
		
			k="<img src='"& IIF(Rs("BigFiles")<>"",Rs("BigFiles"),Rs("SmallFiles")) &"'" & SetHtmlParam(a,"imgclass|imgwidth|imgheight") &">"
			
			
			r = Rs("FileName")
			If CheckMakeHtmlFile(r)=True Then
				r = GetHandleUrl(Rs("FileName"))
				Call WebDebug(r, "act=CreateArticle&ID=" & Rs("Id"))
			End If
			
			k = "<a " & AHref(r, Rs("Title"), Rs("Target")) & SetHtmlParam(a,"aclass") & ">" & k & "</a>"			
			
			If InStr("|footphotonews|topphotonews|","|"& v &"|") > 0 Then
				k =k & "<span" & SetHtmlParam(a,"textclass") &">" & CutStr(Rs("Content"), 100, "... ") & "</span>"
			End If
			l = Rs("ID")
		End If:Rs.Close
		q= "Select * From [Product]" & GetDidSidTidSQl(b,c,d)
		If l <> "" Then q =  GetWhereAnd(q," Where Id<>"& l &"")
		q =  GetWhereAnd(q,h)
	End If
	Rs.Open q,Conn,1,1
	For n=1 To f
		If Rs.Eof Then Exit For
		
		r = Rs("FileName")
		If CheckMakeHtmlFile(r)=True Then
        	r = GetHandleUrl(Rs("FileName"))
	        Call WebDebug(r, "act=CreateArticle&ID=" & Rs("Id"))
		End If
		
        s = CutStr(Rs("Title"), g, "... ")
        s = FontColorFontB(s, Rs("FontB"), Rs("FontColor"))

        t = "<a " & AHref(r, Rs("Title"), Rs("Target")) & SetHtmlParam(a,"aclass") & ">" & s & "</a>"
        If u <> "" Then
            t = t & "<span class=""timeright"">" & Format_Time(Rs("UpDateTime"), u) & "</span>" & vbCrLf
        End If
		o=o & "<li" & SetHtmlParam(a,"liclass") &">"& t &"</li>" & vbCrlf
	Rs.MoveNext:Next:Rs.Close
	o = o & "</ul>" & vbCrlf
	
	If InStr("|topphoto|topphotonews|","|"& v &"|") > 0 Then
		o=k & o
	ElseIf InStr("|footphoto|footphotonews|","|"& v &"|") > 0 Then
		o= o & k
	End If
	
	XY_ShowNewsList = o	
End Function

Function XY_BannerSwitch(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	XY_BannerSwitch = BannerSwitch(b,f)
End Function

Function XY_BannerSwitch2(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	XY_BannerSwitch2 = BannerSwitch2(b,f)
End Function

Function XY_LinkList(a)
	Dim b,c
	c = " | "								
	b = RParam(a,"Title")
	c = RParam(a,"spltypestr")	
	XY_LinkList = HandleLinkList(b,c)	
End Function

Function XY_Links(a)
	Dim b,c,d
	c = " | "								
	b = RParam(a,"AddSql")
	c = RParam(a,"spltypestr")		
	Dim e,f,g,h,i,j,k,l
	l = "Select * From [FriendLink]"
	l = GetWhereAnd(l,b)
	Rsx.Open l,Conn,1,1
	For j=1 To Rsx.RecordCount
		e =  Rsx("Url")
		g = ATarget(Rsx("Target"))
		h = ARel(Rsx("NoFollow"))
		f = Rsx("Title")
		i = Rsx("ImgPath")
		d = "<a href='"& e &"'"& g &""&h & SetHtmlParam(a,"class")&" title="""& f &""">"& FontColorFontB(f,Rsx("FontB"),Rsx("FontColor")) &"</a>" & c
		
		
		d = DisplayOnlineED2(WEB_ADMINURL &"FriendLink.Asp?act=ShowEdit&Id=" & Rsx("Id") & "&n=" & GetRnd(11), d, "<li|<a ")
		k=k & d & vbCrlf		
	Rsx.MoveNext:Next:Rsx.Close
	XY_Links = k
End Function

Function XY_FriendLinkLI(a)
	Dim b
	b = RParam(a,"AddSql")
	Dim c,d,e,f,g,h,i,j,k
	j = "Select * From [FriendLink]"
	j = GetWhereAnd(j,b)
	Rsx.Open j,Conn,1,1
	For h=1 To Rsx.RecordCount
		c =  Rsx("Url")
		e = ATarget(Rsx("Target"))
		f = ARel(Rsx("NoFollow"))
		d = Rsx("Title")
		g = Rsx("ImgPath")
		k = "<a href='"& c &"'"& e &""&f & SetHtmlParam(a,"class")&" >" & FontColorFontB(d,Rsx("FontB"),Rsx("FontColor")) &"</a>"
		k = HandleDisplayOnlineEditDialog(""& adminDir &"FriendLink.Asp?act=ShowEdit&Id=" & Rs("Id") & "&n=" & GetRnd(11), k,"style='float:right;padding:0 4px;'","")
		
		i=i & "<li"& SetHtmlParam(a,"liclass") &">" & k & "</li>"
	Rsx.MoveNext:Next:Rsx.Close
	XY_FriendLinkLI = i
End Function




Function XY_HrefA(a)
	Dim b,c,d,e,f,g,h
	a = HandleInModule(a,"start")
	b = RParam(a,"Content")
	f = RParam(a,"Type")
	If f="收藏" Then
		
		
		g = "shoucang(document.title,window.location)"
		d = "<a href='javascript:;' onClick="""& g &""" " & SetHtmlParam(a,"target|title|alt|id|class|style") &">"& b &"</a>"
	ElseIf f="设为首页" Then
		
		
		g = "SetHome(this,window.location)"
		d = "<a href='javascript:;' onClick="""& g &"""" & SetHtmlParam(a,"target|title|alt|id|class|style") &">"& b &"</a>"
	Else
		b = RParam(a,"Title")
	End If
	
	b = HandleInModule(b,"end")
	If d = "" Then d = "<a" & SetHtmlParam(a,"href|target|title|alt|id|class|rel|style") &">"& b &"</a>"
	
	XY_HrefA = d
End Function

Function XY_ShowThisText(a)
	Dim b
	b = GetDefaultValue(a)
	XY_ShowThisText = b
End Function




Function XY_MainInfo2(a)
	Dim b,c,d,e
	
	b = RParam(a,"Title")
	c = RParam(a,"ShowTitle")
	d = RParam(a,"AutoAdd")	
	
	e = ReadMainInfo(b)
	If e="" Then
		e = GetDefaultValue(a)
		
		If LCase(d)="true" Then
			Call AutoAddMainInfo(b,c,e)
		End If
	End If
	XY_MainInfo2 = e
End Function

Function XY_MainInfo(a)
	Dim b,c,d,e, f, g, h
	
	b = RParam(a,"Title")
	c = RParam(a,"ShowTitle")
	d = RParam(a,"AutoAdd")	
	h = RParam(a,"OnHtml")
	If h="" Then h=False	
	
	e = ReadMainInfo(b)
	If e="" Then
		e = GetDefaultValue(a)
		
		If LCase(d)="true" Then
			Call HandleAutoAddMainInfo(b,c,h,e)
		End If
	End If
	f = ReadMainId(b)
	If f<>"" And Request("gl") = "edit" Then
		
		g = ""& adminDir &"MainInfo.Asp?act=ShowEdit&Id=" & f & "&n=" & GetRnd(11)
		e = DisplayOnlineED2(g, e, "<span |<div ")
	End If
	
	e = HandleContentParamLabel(a,e)
	
	XY_MainInfo = e
End Function

Function HandleContentParamLabel(a,ByVal b)
	Dim c,d,e
	
	c = RParam(a,"DelHtml")			
	If c="true" Then b = Replace(DelHtml(b),"<","&lt;")			
	
	d = RParam(a,"trim")			
	If d="true" Then b = TrimVbCrlf(b)

	
	e = RParam(a,"Len")			
	e = HandleNumber(e)
	If e<>"" Then b = CutStr(b,e,"...")
	HandleContentParamLabel = b
End Function


Function XY_MainInfoA(a)
	Dim b,c,d,e,f
	
	b = RParam(a,"Title")
	c = RParam(a,"ShowTitle")
	d = RParam(a,"AutoAdd")	
	f = GetMainInfoUrl(b)		
	
	If f="" Then
		e = GetDefaultValue(a)
		
		If LCase(d)="true" Then
			Call AutoAddMainInfo(b,c,e)
		End If
	End If
	XY_MainInfoA = "<a href='"& f &"'"& SetHtmlParam(a,"target|title|alt|id|class|style|") &">"& b &"</a>"
End Function

Function XY_MainInfoUrl(a)
	Dim b,c,d,e,f
	
	b = RParam(a,"Title")
	c = RParam(a,"ShowTitle")
	d = RParam(a,"AutoAdd")	
	f = GetMainInfoUrl(b)		
	
	If f="" Then
		e = GetDefaultValue(a)
		
		If LCase(d)="true" Then
			Call AutoAddMainInfo(b,c,e)
		End If
	End If
	XY_MainInfoUrl = f
End Function

Function XY_MainInfo_GetShowTitle(a)
	Dim b,c,d,e,f,g,h
	
	b = RParam(a,"Title")
	c = RParam(a,"ShowTitle")
	d = RParam(a,"AutoAdd")
	
	g = ReadMainInfoShowTitle(b)		
	
	If g="" Then
		e = GetDefaultValue(a)
		
		If LCase(d)="true" Then
			Call AutoAddMainInfo(b,c,e)
		End If
		g = c
	End If
	h = ReadMainId(b)
	If h<>"" And Request("gl") = "edit" Then
		
		f = ""& adminDir &"MainInfo.Asp?act=ShowEdit&Id=" & h & "&n=" & GetRnd(11)
		g = DisplayOnlineED2(f, g, "<span |<div ")
	End If
	
	
	XY_MainInfo_GetShowTitle = g
	
End Function




Function XY_NavDidA(a)	
	Dim b,NavDid	
	NavDid = RParam(a, "NavDid")
	b = GetNavUrl(NavDid, "")		
	b = FullHttpUrl(Host(),b)
	XY_NavDidA = "<a href='"& b &"'"& SetHtmlParam(a,"target|title|alt|id|class|style|") &">"& NavDid &"</a>"
End Function

Function XY_NavDidUrl(a)	
	Dim b,NavDid	
	NavDid = RParam(a, "NavDid")
	b = GetNavUrl(NavDid, "")		
	XY_NavDidUrl = b
End Function

Function XY_WebTitle()
	Dim b
	XY_WebTitle = WebTitle
	b = Trim(LCase(WebTitle))
	If b="#" Or b="null" Or b="empty" Then
		XY_WebTitle = ""
	End If	
End Function

Function XY_WebKeywords()
	Dim b
	XY_WebKeywords = WebKeywords
	b = Trim(LCase(WebKeywords))
	If b="#" Or b="null" Or b="empty" Then
		XY_WebKeywords = ""
	End If	
End Function

Function XY_WebDescription()
	Dim b
	XY_WebDescription = WebDescription
	b = Trim(LCase(WebDescription))
	If b="#" Or b="null" Or b="empty" Then
		XY_WebDescription = ""
	End If	
End Function


Function XY_WebBottom(a)
	If WebBottom = "[底部无内容]" Or WebBottom="[$网站底部$]"  Then
		
		Rs.Open "Select * From [WebSite]", Conn, 1, 3
		If Not Rs.Eof Then
			WebBottom=GetDefaultValue(a)
			Rs("WebSiteBottom") = WebBottom
			Rs.Update
		End If : Rs.Close
	End If
	XY_WebBottom = WebBottom
End Function


Function XY_WebBottomNav(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	
	Dim i,j, k, l, m, n, o, p,q,r
	r = RParam(a,"SplTypeStr")
	If h="" Then h="Where NavButtom<>0  Order By Sort Asc"
	
	q  = "Select * From [NavBigClass] "
	If UserId<>"" Then q = GetWhereAnd(q, " And UserId=" & UserId) 			
	q = GetWhereAnd(q, h)
	Rs.Open q, Conn, 1, 1
	For i = 1 To Rs.RecordCount
		m = Rs("FileName")
		If m <> "" And Right(m,1)<>"/" Then m = m & ".html"
	
		n = "/" & GetWebFolderName() & Rs("FolderName") & "/"
		b = Rs("BigClassName")
		o = FontColorFontB(b, Rs("FontB"), Rs("FontColor"))
		p = Rs("Target")
		
		l = Rs("FileName")
		If CheckMakeHtmlFile(l)=True Then
			l = n & m
			l = Replace(Replace(l, "//", "/"), "//", "/")
			l = FullHttpUrl(Host,l)	
		End If
		Call WebDebug(l,"act=Nav&NavDid=" & b)	
		If InStr("|产品|新闻|下载|","|" & Rs("NavType") & "|")>0 Then
			Call WebDebug(l,"act=Nav&NavDid=" & b & "&Page=1")	
		End If		
		
		j = "<a " & AHref(l, o, p) & SetHtmlParam(a,"aclass|class|style") & ">" & o & "</a>"
		If i <> Rs.RecordCount And r<>"" Then j = j & r
		
		j = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavBig&Id=" & Rs("Id") & "&n=" & GetRnd(11), j, "<li|<a ")
		k = k & j
	Rs.MoveNext : Next : Rs.Close
	XY_WebBottomNav = k
End Function





Function XY_BatchAutoAddProductClass(a)
	Dim b,c,d,e,f,g,h,i,j,k,l,m,n
	b = GetDefaultValue(a)
	Dim o,p
	p = LCase(Trim(RParam(a,"RootDirYes")))			
	o = RParam(a,"Operate")
	If o="false" Then Exit Function				
	c = Split(b, vbCrlf) 	
	For d = 0 To UBound(c)
		e = Replace(c(d),vbTab, CopyStr(" ",4))
		If e <> "" And Left(Trim(e),1)<>"#" Then
			f = Split(e & "||||||", "|")
			g = Trim(f(0))
			n = f(1)
			h = f(2)
			i = f(3)
			If n = "" Then n =  d
			If Left(f(0),12)= CopyStr(" ",12) Then
				f(0)=Replace(f(0),"[类别]", j & "_" & k & "_" & l)
				f(0)=" did='"& j &"' sid='"& k &"' tid='"& l &"'" & f(0)
				Call XY_AutoAddProduct(f(0))			
				
			ElseIf Left(f(0),8)= CopyStr(" ",8) Then
				l=g
				m="Select * From [ThreeClass] Where BigClassName='" & j & "' And SmallClassName='"& k &"' And ThreeClassName='"& l &"'"
				If h = "" Then h = l
			ElseIf Left(f(0),4)=CopyStr(" ",4)  Then
				k=g : l=""
				m="Select * From [SmallClass] Where BigClassName='" & j & "' And SmallClassName='"& k &"'"					
				If h = "" Then h = k
			ElseIf g<>"" Then
				j=g : k="" : l=""
				m="Select * From [BigClass] Where BigClassName='" & j & "'"				
				If h = "" Then h = j
			End If
			If j<>"" Then
				Rs.Open m, Conn, 1, 3
				If Rs.Eof Then
					Rs.AddNew
						If j <>"" Then Rs("BigClassName") = j
						If k <>"" Then Rs("SmallClassName") = k
						If l <>"" Then Rs("ThreeClassName") = l
						Rs("Sort") = n
						If h<>"" And p="true" Then h = "/" & h
						Rs("FolderName") = PinYin(h, 3)
					Rs.Update
					
				End If:Rs.Close
			End If
		End If
	Next
	
End Function


Function XY_BatchAutoAddNavClass(a)
	Dim b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q
	b = GetDefaultValue(a)
	Dim r,s,t
	dim isDelTable												
	dim v
	dim w:Set w = CreateObject("Adodb.RecordSet")
	dim x
	
	v = LCase(Trim(RParam(a,"isaddfoldername")))			
	
	r = RParam(a,"Operate")
	s = LCase(Trim(RParam(a,"RootDirYes")))			
	isDelTable = LCase(Trim(RParam(a,"isDelTable")))			
	x = LCase(Trim(RParam(a,"isFileNameToPinYin")))			
	dim url											
	
	
	
	If r="false" Then Exit Function				
	
	if isDelTable<>"true" then
		w.Open"Select * From [NavBigClass]",Conn,1,1
		If w.RecordCount>1 Then w.Close : Exit Function			
		If Not w.Eof Then
			If w("BigClassName")<>"测试首页" Then w.Close : Exit Function			
		End If
		w.Close
	end if
	Conn.Execute("Delete From [NavBigClass]")				
	
	c = Split(b, vbCrlf)
	For d = 0 To UBound(c)
		e = Replace(c(d),vbTab, CopyStr(" ",4))
		q=phpTrim(e)
		If q <> ""  And Left(Trim(e),1)<>"#" Then
			l = RParam(e,"Sort")
			h = RParam(e,"FileName")
			i = RParam(e,"FolderName")
			j = RParam(e,"Template")
			t = RParam(e,"Content")
			p = RParam(e,"WebTitle")								
			n = "|" & RParam(e,"NavLocation") & "|"			
			url = phptrim(clearRParam(e,"url"))							
			
		 	if h="null" then h=""
			
			If l = "" Then l =  d
			o=""
			If Left(e,4)=CopyStr(" ",4)  Then
				g = RParam(e,"Sid") : m=""
				
				k="Select * From [NavSmallClass] Where BigClassName='" & f & "' And SmallClassName='"& g &"'"					
				o="navsmall"
				If h="" Then h = g			
			Else
				f = RParam(e,"Did") : g=""
				m = RParam(e,"NavType")				
				
				If h="" Then h = f			
				k="Select * From [NavBigClass] Where BigClassName='" & f & "'"
			End If
			If f<>"" Then
				
				w.Open k, Conn, 1, 3
				If w.Eof Then
					w.AddNew
						If f <>"" Then w("BigClassName") = f
						If g <>"" Then w("SmallClassName") = g
						w("TemplatePath") = j						
						If m <>"首页" Then
							if v="true" and i<>"null" And i<>"空" then
								If i =  "" Then
									if g<>"" then
										i=g
									else									
										i=f
									end if	
								end if							
								If i<>"" And s="true" Then i = "/" & i
								
								w("FolderName") = PinYin(i, 3)
							end if
							if trim(lcase(h))="thistemplate" then								
									h=mid(j,1,instrrev(j,".")-1)
							elseif trim(lcase(h))="this" then							
								if g<>"" then
									h=g
								else
									h=f
								end if
							end if
							
							if x="true" then
								h=HtmlFileName(h)						
							else
								h=SetFileName(h)						
							end if
							
							w("FileName") = h	

						End If
						
						w("Sort") = l
						If m<>"" Then
							w("NavType") = m							
							If InStr(n,"顶部")>0 Then
								w("NavTop") = True
							Else
								w("NavTop") = False
							End If
						End If
						If (m="文本" Or o="navsmall") and t="" Then
							t = f & " " & g & " 详细信息内容写在这里面。更多....."
							
						elseif (m="产品" or m="新闻") and instr("|no|#|","|" & t & "|")=false then							
							call XY_AutoAddProduct("{$AutoAddProduct did='"& f &"' title='在这里面写上信息标题[id]{@Array@}' topnumb='20' bigimage='/UploadFiles/NoImg.jpg' default='在这里面写上信息内容[id]' autoadddid='true'$}")
						End If
						If InStr(n,"底部") > 0 Then w("NavButtom") = True
						If InStr(n,"左边") > 0 Then w("NavLeft") = True
						If InStr(n,"中间") > 0 Then w("NavContent") = True
						If InStr(n,"右边") > 0 Then w("NavRight") = True
						If InStr(n,"其它") > 0 Then w("NavOthre") = True				
						
						If InStr("|产品|新闻|下载|", "|"& m &"|")>0 Then
							Call AutoAddBigClass(f)
						End If
						if p="" then
							if g<>"" then
								p=g
							else
								p=f
							end if
						end if
						if lcase(p)="null" then
							p=""
						end if
						call echo(f,p)
						
						w("CustomAUrl") = url						
						w("WebTitle") = p
						w("Content") = t
					w.Update
				End If:w.Close
			End If
		End If
	Next
	
End Function



Function XY_AutoAddHandle(a)
	Dim b,c,d,e,f,g,h,i,j,k
	Dim l,m,n
	Call HandleFunParameter(a,b,c,d,e,f,g,h)		
	Dim o,p
	dim defaultaddcontent					
	dim addContent							
	
	
	defaultaddcontent = ModuleFindContent(a,"defaultaddcontent")
	
	
	
	If CheckBigClass(b) = 0 Then
		l = RParam(a,"AutoAddDid")
		If LCase(l)="true" Then
			Call AutoAddBigClass(b)
		End If		
	End If
	
	If CheckSmallClass(b,c) = 0 Then
		m = RParam(a,"AutoAddSid")
		If LCase(m)="true" Then
			Call AutoAddSmallClass(b,c)
		End If		
	End If
	
	If CheckThreeClass(b,c,d) = 0 Then
		n = RParam(a,"AutoAddTid")
		If LCase(n)="true" Then
			Call AutoAddThreeClass(b,c,d)
		End If		
	End If
	
	If CheckProduct(b,"","")=0 Then
		i = RParam(a,"AutoAdd")
		If LCase(i)="true" Then
		 	For j = 1 To f
			
			if defaultaddcontent<>"" then
					o = defaultaddcontent					
					o = ReplaceValueParam(o,"ni",j)								
					o = ReplaceValueParam(o,"编号-1",j-1)								
					o = ReplaceValueParam(o,"编号",j)								
					o = ReplaceValueParam(o,"did",  b)	
					o = ReplaceValueParam(o,"sid",  c)	
					o = ReplaceValueParam(o,"tid",  d)	
				else
					o = b & "-内容"
				end if
			
				Call AutoAddArticle(b,c,d,b & c & d & "-标题" & j,o)		
			Next
		End If
	End If	
End Function

Function XY_AutoAddDid(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim j,k
	j=Split(b,"[Array]")
	For Each k In j
		If k<>"" Then
			Call AutoAddBigClass(k)
		End If
	Next
End Function

Function XY_AutoAddSid(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim j,k,l,m
	j=Split(d,"[Array]")
	
	l = GetDidSidTidSQl(b,"","")
	l = GetWhereAnd(l,h)
	Rs.Open"Select * From [ThreeClass] " & l,Conn,1,1
	m=Rs.RecordCount : Rs.Close
	If m<>0 Then Exit Function
	j=Split(c,"[Array]")
	For Each k In j
		If k<>"" Then
			Call AutoAddSmallClass(b,k)
		End If
	Next
End Function

Function XY_AutoAddTid(a)
	Dim b,c,d,e,f,g,h,i
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Dim j,k,l,m
	j=Split(d,"[Array]")
	
	l = GetDidSidTidSQl(b,c,"")	
	l = GetWhereAnd(l,h)
	Rs.Open"Select * From [ThreeClass] " & l,Conn,1,1
	m=Rs.RecordCount : Rs.Close
	If m<>0 Then Exit Function	
	For Each k In j
		If k<>"" Then
			Call AutoAddThreeClass(b,c,k)
		End If
	Next
End Function

Function XY_AutoAddProduct(a)
	Dim b,c,d,e,f,g,h
	Call HandleFunParameter(a,b,c,d,e,f,g,h)
	Call XY_AutoAddHandle(a)			
	Dim i,j,k,l,m,n,o
	j = GetDefaultValue(a)
	Rs.Open"Select * From [Product] " & GetDidSidTidSQl(b,c,d),Conn,1,1
	n = Rs.RecordCount:Rs.Close
	
	If n>0 Then Exit Function
	
	o = Split(e, "{@Array@}")
	If n<f Then
		For l = 1 To f-n
			If Ubound(o)	>=l-1 Then
				e=o(l-1)
				
				if e="" then
					e=o(0)
				end if
			Else
				e=o(0)
			End If
			
			If Instr(e,"[id]")>0 Then
				m = Replace(e,"[id]",l)
			ElseIf Ubound(o)<=0 Then
				m = e & "-" & l
			Else
				m = e
			End If
			
			k = Replace(j,"[id]",l)
			Call AutoAddArticleAction(a,b,c,d,m,l,k)
		Next
	End If
End Function

Function XY_AutoAddGuestBook(a)
	Dim b,c,d,e,f,g,h,i,j,k,l
	c = RParam(a,"TopNumb")
	d = RParam(a,"GuestName")
	e = RParam(a,"EMail")
	f = RParam(a,"Message")
	g = RParam(a,"Reply")
	h = RParam(a,"Tel")
	i = RParam(a,"QQ")
	j = RParam(a,"MSN")
	k = RParam(a,"IP")
	Rs.Open"Select * From [GuestBook]",Conn,1,1
	l = Rs.RecordCount
	Rs.Close
	
	If l>0 Then Exit Function			
	For b=1 To c
		Rs.Open"Select * From [GuestBook] Where Content='"& f &"'",Conn,1,3
		If Rs.Eof Then
			Rs.AddNew
			Rs("GuestName")=Replace(d,"[id]",b)			
			Rs("EMail")=Replace(e,"[id]",b)					
			Rs("Content")=Replace(f,"[id]",b)				
			Rs("Reply")=Replace(g,"[id]",b)					
			Rs("Tel")=Replace(h,"[id]",b)						
			Rs("QQ")=Replace(i,"[QQ]",b)						
			Rs("MSN")=Replace(j,"[MSN]",b)					
			Rs("IP")=Replace(k,"[IP]",b)						
			Rs.Update
		End If:Rs.Close
	Next
End Function

Function XY_UpdateBigNav(a)
	Dim b,c
	b = RParam(a,"Did")
	If b="" Then Exit Function						
	c = ModuleFindContent(a,"content")
	Rs.Open"Select * From [NavBigClass] Where BigClassName='"& b &"'",Conn,1,3
	If Not Rs.Eof Then
		Rs("Content") = c
		Rs.Update
	End If:Rs.Close
End Function

Function XY_AutoBatchAddArticle(a)
	Dim b,c,d,e,f,g,h,i,j
	b = Trim(RParam(a,"FolderPath"))
	If b="" Then Exit Function				
	If CheckFolder(b)=False Then Exit Function	
	g = GetDirFolderNameList(b)
	If g = "" Then Exit Function							
	h = Split(g,vbCrlf)
	For Each d In h
		If d <>"" And Left(d,1)<>"#" Then
			Call AddArticle20141218(b,d,"","")
			
			c = b & "\" & d
			g = GetDirFolderNameList(c)
			
			i = Split(g,vbCrlf)
			For Each e In i
				If e <>"" And Left(e,1)<>"#" Then
					
					Call AddArticle20141218(b, d, e, "")
				End If
			Next
		End If
	Next	
End Function

Function XY_AutoAddInputConfig(a)
	Dim b,c,d,e,f,g,h,i,j,k,l,m,n,o
	
	b = RParam(a,"Did")							
	c = RParam(a,"fronttitle")			
	d = RParam(a,"backendtitle")		
	e = RParam(a,"inputtype")				
	
	f = RParam(a,"fieldname")								
	g = RParam(a,"defaultvalue")						
	h = RParam(a,"inputwidth")							
	i = RParam(a,"inputheight")							
	
	j = RParam(a,"verificationmsg")							
	k = RParam(a,"listshow")										
	l = RParam(a,"through")											
	m = RParam(a,"verificationtype")						
	n = RParam(a,"Sort")												
	o = RParam(a,"tipstext")										
	
	If d="" Then Exit Function				
	Rs.Open"Select * From [InputConfig] Where BigClassName='"& b &"' And fronttitle='"& c &"'",Conn,1,3
	If Rs.Eof Then
		Rs.AddNew
		Rs("BigClassName") = b
		Rs("fronttitle") = c
		Rs("backendtitle") = d
		Rs("inputtype") = e
		
		Rs("fieldname") = f
		Rs("defaultvalue") = g
		Rs("inputwidth") = h
		Rs("inputheight") = i
		
		Rs("verificationmsg") = j
		Rs("verificationtype") = m
		
		If l<>"" Then Rs("through") = True
		If k<>"" Then Rs("listshow") = True
		If n<>"" Then Rs("Sort") = n
		Rs("tipstext") = o
		
		Rs.Update
	End If:Rs.Close
	

End Function

Function AddArticle20141218(a,b,c,d)
	Dim e,f,g,h,i,j,k
	Call Echo("", a & "\" & b & "\" & c & "\" & d)
	e = GetFileFolderList(a & "\" & b & "\" & c & "\" & d, True, "|txt|doc|docx|", "", "", "", "")
	f=Split(e,vbCrlf)
	For Each g In f
		If g<>"" Then
			h = LCase(getFileExtName(g))
			i = GetFilePathName(g)
			If h = "txt" Then
				e=GetFText(g)
			ElseIf h = "doc" Or h = "docx" Then
				e=GetDocText(g)
			End If
			j = "Select * From [Product] Where Title='"& i &"' "
			If b<>"" Then j = GetWhereAnd(j, "And BigClassName='"& b &"'")
			If c<>"" Then j = GetWhereAnd(j, "And SmallClassName='"& c &"'")
			If d<>"" Then j = GetWhereAnd(j, "And ThreeClassName='"& d &"'")			
			Rs.Open j,Conn,1,3
			If Rs.Eof Then
				Rs.AddNew
				Rs("BigClassName") = b
				Rs("SmallClassName") = c
				Rs("ThreeClassName") = d
				Rs("WebTitle") = i
				Rs("Title") = i
				Rs("FileName") = HtmlFileName(i)
				Rs("Content") = e
				Rs.Update		
			End If:Rs.Close
			
			
			
			
		End IF
	Next
	
End Function



Function XY_ReadColumeSetTitle(a)
	Dim b,c,d,e,f,g,h,i,j,k
	a = HandleInModule(a,"start")
	d = RParam(a,"style")
	e = RParam(a,"Title")
	
	
	
	f = ModuleFindContent(a,"value")
	
	f = FindModuleStr(Code,f)					

	g = RParam(a,"MoreClass")
	h = Trim(RParam(a,"MoreUrl"))
	i = RParam(a,"MoreStr")
	f = HandleInModule(f,"end")
	XY_ReadColumeSetTitle = ReadColumeSetTitle(a, d,e,f)
	
	If g="" Then g="more"			
	
	
	If h<>"" And i<>"" Then
		
		j = "<a " & AHref(h, e, "") & " class='"& g &"'>" & i & "</a>" 		
		XY_ReadColumeSetTitle = Replace(XY_ReadColumeSetTitle,"<!--#AMore#-->",j)
	End If
End Function

Function XY_ReadTemplateSource(a)
	Dim b
	b = RParam(a,"SourceId")	
	XY_ReadTemplateSource = ReadTemplateSource(b)
End Function

Function XY_ReadTemplateModule(a)
	Dim b,c
	Dim SourceList				
	Dim ReplaceList				
	Dim f,g,h,i,j
	
	
	c = RParam(a,"File")
	b = RParam(a,"ModuleId")
	SourceList = RParam(a,"SourceList")
	ReplaceList = RParam(a,"ReplaceList")
	
	
	If b="" Then b = RParam(a,"ModuleName")			
	c = c & ".html"
	
	

	XY_ReadTemplateModule = ReadTemplateModuleStr(c,"",b)
	
	
	If SourceList<>"" And ReplaceList<>"" Then
		f = Split(SourceList,"[Array]")
		g = Split(ReplaceList,"[Array]")
		For h = 0 To Ubound(f)
			i = f(h)
			j = g(h)
			If i <>"" Then
				XY_ReadTemplateModule=Replace(XY_ReadTemplateModule, i, j)
			End If
		Next
	End If
	
End Function

Function XY_GetContentModule(a)
	XY_GetContentModule = XY_ReadTemplateModule(a)
End Function

Function XY_ReplaceTemplateContent(a,b,c)
	
	Dim d,e
	d = ModuleFindContent(c,"SourceStr")
	e = ModuleFindContent(c,"ReplaceStr")
	
	
	If InStr(a,d)>0 Then
		a = Replace(a,b,"")				
		a = Replace(a,d,e)				
		
	End If
	XY_ReplaceTemplateContent = ""
End Function


Function XY_ShowTemplateModule(a)
	Dim b,c
	Dim d,e,f
	Dim g,h
	b = RParam(a,"DefaultModule")
	c = RParam(a,"SelectModule")
	
	
	d = PubProDid
	e = PubProSid
	f = PubProTid
	
	
	If PubID<>"" Then
		If PubActionType = "MainInfo" Then
			Rs.Open"Select * From [MainInfo] Where Id=" & PubID,Conn,1,1
			If Not Rs.Eof Then
				If Rs(c)<>"" Then
					g = Rs(c)
					
				End If
			End If:Rs.Close		
		ElseIf PubActionType = "Article" Then
			Rs.Open"Select * From [Product] Where Id=" & PubID,Conn,1,1
			If Not Rs.Eof Then
				If Rs(c)<>"" Then
					h = Rs(c)
				End If
				d=Rs("BigClassName")
				e=Rs("SmallClassName")
				f=Rs("ThreeClassName")
			End If:Rs.Close			
		End If
	End If
	
	If PubNavDid<>"" Then
		Rs.Open"Select * From [NavBigClass] Where BigClassName='"& PubNavDid &"'",Conn,1,1
		If Not Rs.Eof Then
			
			If Rs(c)<>"" Then
				b = Rs(c)
			End If
		End If:Rs.Close
	End If
	
	If PubNavSid<>"" Then
		Rs.Open"Select * From [NavSmallClass] Where BigClassName='"& PubNavDid &"' And SmallClassName='"& PubNavSid &"'",Conn,1,1
		If Not Rs.Eof Then
			If Rs(c)<>"" Then
				b = Rs(c)
			End If
		End If:Rs.Close
	End If
	
	
	If d<>"" Then
		Rs.Open"Select * From [BigClass] Where BigClassName='"& d &"'",Conn,1,1
		If Not Rs.Eof Then
			If Rs(c)<>"" Then
				b = Rs(c)
			End If
		End If:Rs.Close
	End If
	
	If e<>"" Then
		Rs.Open"Select * From [SmallClass] Where BigClassName='"& d &"' And SmallClassName='"& e &"'",Conn,1,1
		If Not Rs.Eof Then
			If Rs(c)<>"" Then
				b = Rs(c)
			End If
		End If:Rs.Close
	End If
	
	If f<>"" Then
		Rs.Open"Select * From [SmallClass] Where BigClassName='"& d &"' And SmallClassName='"& e &"' And ThreeClassName='"& f &"'",Conn,1,1
		If Not Rs.Eof Then
			If Rs(c)<>"" Then
				b = Rs(c)
			End If
		End If:Rs.Close
	End If

	
	If g<>"" Then
		b = g
	ElseIf h<>"" Then
		b = h
	End If
	
	
	Dim i,j,k
	i=Split(b,"|")
	For Each j In i
		If j<>"" Then
			Rs.Open"Select * From [TemplateModule] Where Title='"& j &"'",Conn,1,1
			If Not Rs.Eof Then
				k=k & Rs("Content") & vbCrlf
			End If:Rs.Close	
		End If
	Next
	
	
		
	k = HandleCodeReplace(k)			
	
	
	XY_ShowTemplateModule = k
End Function




Function GetTableFieldValue(a)			
	Dim b,c,d,e,f,g
	b = " table='" : c = "'"
	If InStr(a,b)>0 And InStr(a,c)>0 Then
		e = StrCut(a,b,c,2)
	End If
	b = " field='" : c = "'"
	If InStr(a,b)>0 And InStr(a,c)>0 Then
		f = StrCut(a,b,c,2)
	End If
	g = "Select * From ["& e &"]"
	If UserId<>"" Then
		If LCase(e)<>"member" Then
			g = g & " Where UserId=" & UserId
		Else
			g = g & " Where Id=" & UserId
		End If
	End If
	
	If CheckSql("Select "& f &" From ["& e &"]")=False Then Exit Function
	
	If CheckSql(g)=False Then Exit Function			
	Rs.Open g,Conn,1,1
	If Not Rs.Eof Then
		GetTableFieldValue = Rs(f)
	Else
		GetTableFieldValue = "表["& e &"]字段["& f &"]没找到内容"		
	End If : Rs.Close
End Function

Function SetHtmlParam(a,b)
	Dim c,d,e,f,g,h
	e = "'"
	c=Split(b,"|")
	For Each d In c
		d=Trim(d)
		If d <> "" Then
			
			h = d
			If Left(h,3)="img" then
				h = Mid(h,4)
			ElseIf Left(h,1)="a" then
				h = Mid(h,2)
			ElseIf InStr("|ul|li|", "|" & Left(h,2) & "|")>0 then
				h = Mid(h,3)
			End If
			h = " " & h & "='"
			
			d= " " & d & "='"
			If InStr(a,d)>0 And InStr(a,e)>0 Then
				g = StrCut(a,d,e,2)
				g = HandleInModule(g,"end") 			
				f=f &  h & g & e
			End If
		End If
	Next
	SetHtmlParam = f
End Function





function XY_onLineViewDialog(a)
    Dim b,c,d
	
	c = LCase(RParam(a,"operate"))
	if c<>"true" then
		exit function
	end if
	
    b = "<style type=""text/css"">" & vbCrlf
    b = b & "#dontrolbox{" & vbCrlf
    b = b & "	position:fixed !Important;bottom:0;right:0;position:absolute;z-index:1000;" & vbCrlf
    b = b & "	border:1px solid #CCCCCC;" & vbCrlf
    b = b & "	background-color:#FDFCE8;" & vbCrlf
    b = b & "	width:110px;" & vbCrlf
    b = b & "	height:100px;" & vbCrlf
    b = b & "	text-align:center;" & vbCrlf
    b = b & "	line-height:26px;" & vbCrlf
    b = b & "	font-size:12px;" & vbCrlf
    b = b & "}" & vbCrlf
    b = b & "</style>" & vbCrlf
    b = b & "<div id=""dontrolbox"">" & vbCrlf
	d = GetUrlAddToParam(geturl,"MackHtml=False","replace")	
	d = GetUrlAddToParam(d,"nn=" & GetRnd(11),"replace")		
	
    b = b & "	<a href="""&   GetUrlAddToParam(d,"gl=edit","delete") & """>正确显示</a><br>" & vbCrlf
    b = b & "	<a href="""&   GetUrlAddToParam(d,"gl=edit","replace") & """>在线修改</a><br>" & vbCrlf
	
	d = GetUrlAddToParam(geturl,"MackHtml=true","replace")
	d = GetUrlAddToParam(d,"gl=edit","delete")
	
    b = b & "	<a href="""& GetUrlAddToParam(d,"gotoHtml=true","replace") &""" target='_blank'>HTML版</a>" & vbCrlf
    b = b & "</div>" & vbCrlf
	
	
    If GetIP = "127.0.0.1" Or InStr(GetIP, "192.168.") > 0 Then
		If Request("MackHtml") = "False" Then
        	XY_onLineViewDialog = b
		end if
    End If	
end function



Function XY_DebugWebSkin(a)
	Dim b,c,d,e,f ,g,h,i,j
	Dim CssStr	
	d=Split(Request.QueryString(),"&")
	For Each e In d
		i = Mid(e,1,InStr(e,"=")-1)
		j = Mid(e,InStr(e,"=")+1) 		
		If LCase(i)<>"n" And LCase(i)<>"findtpl" And LCase(i)<>"replacetpl" Then
			If j<>"" Then
				h = h & IIF(h="","?","&") & i & "=" & j
			End If
		End If
	Next
	h =  "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME") & h & "&n=" & GetRnd(11)
	
	
	b = WebSkins & "Index\column"
	c = GetDirFolderNameList(b)
	d=Split(c,vbCrlf)
	For Each e In d
		If e <>"" Then
			g=h & "&FindTpl=style='312'&ReplaceTpl=style='"& e &"'"
			f=f & "<a href="""& g &""">"& e &"</a><br>" & vbCrlf
		End If
	Next
	If f <> "" Then	
		CssStr = "<style>" & vbCrlf
		CssStr = CssStr & "/*网站样式切换 <div id=""webStyleTab""></div>*/" & vbCrlf
		CssStr = CssStr & "#webStyleTab{" & vbCrlf
		CssStr = CssStr & "	position:fixed;" & vbCrlf
		CssStr = CssStr & "	width:51px;" & vbCrlf
		CssStr = CssStr & "	height:177px;" & vbCrlf
		CssStr = CssStr & "	z-index:999;" & vbCrlf
		CssStr = CssStr & "	left: 0px;" & vbCrlf
		CssStr = CssStr & "	top: 0px;" & vbCrlf
		CssStr = CssStr & "}" & vbCrlf
		CssStr = CssStr & "</style>" & vbCrlf	
		f = CssStr & "<div id=""webStyleTab"">" & f &  "</div>"
	End If
	XY_DebugWebSkin = f
End Function



Select Case Request("actgl")
	Case "login" : Call gl_Login()
	Case "action" : Call gl_Action()
	Case "delaction" : Call dle_Action()
	Case "testdialog" : Call test_Dialog()
End Select


Sub gl_Action()
	Call OpenConn()
	Rs.Open"Select * From [WebSite]",Conn,1,1
	If Not Rs.Eof Then
		Call Die("【显示动作】" & vbCrlf & Rs("TemplateMain3"))
	End If
	Response.End()
End Sub

Sub dle_Action()
	Call OpenConn()
	Rs.Open"Select * From [WebSite]",Conn,1,3
	If Not Rs.Eof Then
		Rs("TemplateMain3") = ""
		Rs.Update
		Call Rw("删除动作成功")
	End If
	Response.End()
End Sub

Sub gl_Login()
	Call OpenConn()
	Rs.Open"Select * From [WebSite]",Conn,1,3
	If Not Rs.Eof Then
		Rs("TemplateMain2") = Format_Time(Now(),1) & vbCrlf & Rs("TemplateMain2")
		Rs.Update
		Call Rw("登录成功")
	End If
	Response.End()
End Sub

Sub test_Dialog()
	Call Echo("记录登录", "<a href='?actgl=login' target='_blank'>记录登录</a>")
	Call Echo("获得动作", "<a href='?actgl=action' target='_blank'>获得动作</a>")
	Call Echo("删除动作", "<a href='?actgl=delaction' target='_blank'>删除动作</a>")
	Response.End()
End Sub


Function VB_copyTemplateMaterial(a)	
	VB_copyTemplateMaterial=""
End Function

function pingBiLable(a)
	pingBiLable = false
end function

%>



















