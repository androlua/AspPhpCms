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
<!--#Include File = "Config.Asp"-->
<%

Dim UserID
Dim WebBottom, DisplayYes, pubCode,Code, Did, Sid, Tid, ShowTitle			
Dim TempDid, TempSid, TempTid
Dim DefaultWebTitle, DefaultWebKeywords, DefaultWebDescription 		
Dim WebNavType
DisplayYes = True
Server.ScriptTimeout = 1800
Dim WebActionType
Dim WebNavDid, WebNavSid
Dim DefaultWebBanner
Dim WebFolderName
Dim LocalTestFolder
Dim NavDid, NavSid, ProDid, ProSid, ProTid
Dim ArticleDid,ArticleSid,ArticleTid,ArticleTitle					
Dim ArticleID,ArticleDateTime,ArticleContent,ArticleAuthor			
Dim ArticleBigFiles,ArticleSmallFiles								
Dim WebTemplate, WebSkins											
Dim WebImages,WebCss,WebJs											
Dim TemplateHTMLCode												
Dim JsUrl,JsContent													
Dim Tplpath,TplContent,TplListContent								
Dim WebModuleSkins													
Dim WebFindTpl														
Dim WebReplaceTpl													
Dim WebCodeFindTpl													
Dim WebCodeReplaceTpl												
dim isHtmlFormatting													
dim DB_PREFIX															

Call OpenConn()
Dim ObjYK : Set ObjYK = New ClassYouKou
Dim ObjMSD : Set ObjMSD = New Maiside								
dim ModuleReplaceArray(99,99)									







Select Case Request("act")
    Case "auto", "autoweb","AutoAddWebInfo" : AutoAddWebInfo(Request("DataFolderPath"))	
    Case "Nav"	
		NavDid = Request("NavDid")
		If NavDid="" And Request("NavDidType")<>"" Then
			NavDid = GetNavTypeInName(Request("NavDidType"))
		End If
		
		Call MakeWebHtml(NavDid,Request("NavSid"),"","","","Nav","","","")		
	Case "ShowNavList" : ShowNavList()			
	Case "CreateNavList" : CreateNavList()		
	Case "ShowClassList" : ShowClassList()		
    Case "CreateInfo" :
		Call MakeWebHtml(Rq("NavDid"),Rq("NavSid"),Rq("ProDid"),Rq("ProSid"),Rq("ProTid"),Rq("ActionType"),Rq("ID"),Rq("ClassName"),Rq("WD"))
	Case "CreateClass" : Call MakeWebHtml("","",Request("ProDid"),Request("ProSid"),Request("ProTid"),"Class","","","")		
	Case "CreateClassList" : CreateClassList()		
	Case "ShowArticleList" : ShowArticleList()		
	Case "CreateArticle" : Call MakeWebHtml("","","","","","Article", Request("Id"),"","")			
	Case "CreateArticleList" : CreateArticleList()			
 	Case "Search" : Call MakeWebHtml("","",Request("Did"),Request("Sid"),Request("Tid"),"Search","",Request("ClassName"),Request("wd"))	
	
    Case "MainInfo" : Call MakeWebHtml("","","","","","MainInfo",Request("Id"),"","")		
	Case "MakeSiteMap" : Call MakeSiteMap():Response.End()		
	
	Case "ShowMemberList" : ShowMemberList()		
	Case "ShowDelHtmllist" : ShowDelHtmllist()		
	Case "DelFile": DelFile(Request("FileName"))	
	
	Case "ShowWorkList","工作","work","笔记","工作列表" : ShowWorkList()	
	Case "ShowWork" : ShowWork(Request("FilePath"))
	
	Case "news" : Rw(GetFText("/Templates/MaiSiDe/QQShare.Html")) : Response.End()			
	Case "AddProduct" : AddProduct()		
	Case "DeleteProduct" : DeleteProduct("Where Id=" & Request("Id"))			
	
	Case "AotuAddKeyWord" : AotuAddKeyWord()	
	Case "WebNavigationUsrList" : WebNavigationUsrList()		
	Case "WebStat" : WebStat(""& adminDir &"Data/Stat/")		
	Case "FormSubmit" : FormSubmit()					
	Case "RunFile" : RunFile()							
	Case "showweb" : Response.Redirect("/Inc/Create_Html.Asp?act=Nav&NavDidType=首页&MackHtml=False&Debug=True" & IIF(Request("gl")<>"","&gl=" & Request("gl"),""))	
	Case "aboutauthor","about","author" : Call AboutAuthor()				
	case "default" : Call Default()

End Select

Sub MakeWebHtml(a,b,c,d,e, f,g,h,i)
	Dim j,k,l,m,n,o,p,q
	Dim TempMainContent				
	Dim CustomTemplateFile			
	dim content						
	dim u : u=true			
	
	PubNavDid = a
	PubNavSid = b
	PubProDid = c
	PubProSid = d
	PubProTid = e
	PubActionType = f				
	PubID = g
	PubClassName = h
	PubWD = i
	Call HandleWebConfig()		
	JsUrl = "/Inc/Create_Html.Asp?act=CreateInfo&NavDid=" & a & "&NavSid=" & b
	JsUrl = JsUrl & "&ProDid=" & c & "&ProSid=" & d & "&ProTid=" & e
	JsUrl = JsUrl & "&ActionType=" & f & "&ID=" & g & "&ClassName=" & h & "&WD=" & i
	JsUrl = JsUrl & "&MackHtml=" & Rq("MackHtml") & "&Debug=" & Rq("Debug")
	JsContent = "<script type='text/javascript'>AjaxNoReturn('"& JsUrl &"');</script>"
	m=True		
	Call GetWebConfig()	
	
	LocalTestFolder = GetWebFolderName()						
	
	WebActionType = f		
	
	If f="Nav" Then
		If a = "" Then n = Request("NavType")
    	TemplatePath = GetNavTemplateText(a, b, n)
		WebNavDid=a:WebNavSid=b		
	
	ElseIf f="Class" Then	
    	TemplatePath = GetClassTemplateText(c, d, e)
		
	
	ElseIf f = "Article" Then
		Call CreateArticle(g)
	
	ElseIf f = "MainInfo" Then
		Call CreateMainInfo(g)
	End If
	
	If TemplatePath = "" Then
		TemplatePath = WebTemplate & "Main_Model.Html"
	Else
		TemplatePath = Replace(TemplatePath,"/","\")
		
		If Left(TemplatePath,1)<>"\" Then TemplatePath = WebTemplate & TemplatePath
	End If
	
	
	If Rq("HttpUrl")<>"" Then	
		Code = GetHttpPage(Rq("HttpUrl"),"")
	
	ElseIf Request("Template")<>"" Then
		
		Dim v,w
		If Request("Template")="表单验证" Then
			Code = GetFText(WebTemplate & "Index_Model.Html")
			If InStr(Code,"</head>")>0 Then			
				Code = Mid(Code,1,InStr(Code,"</head>")+7)
			End If
			o = "{$FormSubmit did='"& Request("Did") &"' tablename='InputValue' formname='formdialog' classname='formdialog' isverificationcode='true'$}"
			code=code & "<script src=""/Jquery/Function.js""></script>" & vbcrlf
			Code = Code & "<body>" & o
			If Request("formedit")="true" Then
				Code = Code & "<div>复制下面代码放到网页里 就可以显示上面的表单了。</div><div>"& Replace(o,"{","&#x7B;") &"</div>"
			End If
		Else		
			CustomTemplateFile = TrimVbCrlf(HandleFileUrl(Request("Template")))
			If Left(CustomTemplateFile,1)<>"\" Then
				CustomTemplateFile = WebTemplate & CustomTemplateFile
			End If
			
			
			
			
			If Request("Code")<>"" Then
				Call CreateFile(CustomTemplateFile,Request("Code"))
			End If
			Code = GetFText(CustomTemplateFile)
			
		End If
		
		
		Tplpath = Replace(Request("Template"),"/","\")
		If InStr(Tplpath,"\")>0 Then Tplpath = Mid(Tplpath,InStrRev(Tplpath,"\")+1)
		If InStr(Tplpath,".")>0 Then Tplpath = Mid(Tplpath, 1, InStrRev(Tplpath,".")-1)
		Tplpath = WebTemplate & "Config\" & Tplpath & ".tpl"
		TplContent = GetFText(TplPath)
		v="#默认网页模板列表# start" : w="#默认网页模板列表# end"
		If InStr(TplContent,v)>0 And InStr(TplContent,w)>0 Then
			TplListContent = StrCut(TplContent,v,w,2)
			
		End If
		
	Else
	    Code = GetFText(TemplatePath)
	End If
	Call HandleCodeReplace(Code)				
	pubCode = Code							
	
	
	
	
	If Request("MackHtml") <> "False" Then
	    Call Echo("模板路径TemplatePath", TemplatePath)
	End If	
	
	If TempDid <> "" Then c = TempDid : d = TempSid :  e = TempTid			

 	TemplateHTMLCode = Code					
 	
	If WebSkins = "\Skins\YouKou\" Then
		
		
		
		
		Code = Replace(Code, "{$WebBottomNav$}", ObjYK.WebNavigation("Where NavButtom=True  Order By Sort Asc"))
		
		
		Code = Replace(Code, "{$Banner$}", ObjYK.BannerTab("Banner",6,"","",""))
		
		
		Code = Replace(Code, "{$热搜关键词$}", HotSearch(""))
		
		Code = Replace(Code, "{$产品类别展示$}", ReadClassList("产品展示", d, e, "","菜单移动显示"))
		
		Code = Replace(Code, "{$为什么在悠口培训$}", ReadMainInfo("为什么在悠口培训"))
		
		
		Code = Replace(Code, "{$最新学员$}", ObjYK.ShowHandleUserList(100))
		Code = Replace(Code, "{$最新学员$}", ReadScrollMemberList(100,""))
		
		Code = Replace(Code, "{$热门技术推荐$}", CaseList("产品展示",12," Where Recommend=True And BigFiles<>'' "))
		
		Code = Replace(Code, "{$友情链接$}", ObjYK.FriendLink())
		
		
		Code = Replace(Code, "{$悠口培训新闻$}", ReadNewList("悠口培训新闻",6, 40 ,"Order By Id Desc"))
		Code = Replace(Code, "{$餐饮行业新闻$}", ReadNewList("餐饮行业新闻",6, 40 ,"Order By Id Desc"))
		Code = Replace(Code, "{$餐饮店面经营管理$}", ReadNewList("餐饮店面经营管理",6, 40 ,"Order By Id Desc"))
		Code = Replace(Code, "{$饮食文化$}", ReadNewList("饮食文化",6, 40 ,"Order By Id Desc"))
		Code = Replace(Code, "{$地方特色美食$}", ReadNewList("地方特色美食",6, 40 ,"Order By Id Desc"))
		Code = Replace(Code, "{$厨艺培训交流$}", ReadNewList("厨艺培训交流",6, 40 ,"Order By Id Desc"))
		
		Code = Replace(Code, "{$网站地图$}", GetNavUrl("网站地图",""))
		Code = Replace(Code, "{$网站地图Target$}", GetNavTarget("网站地图",""))	
		
		Code = Replace(Code, "{$培训场景More$}", GetBigClassUrl("培训场景"))
		Code = Replace(Code, "{$热门技术推荐More$}", GetBigClassUrl("热门技术推荐"))
		Code = Replace(Code, "{$悠口培训基地一览More$}", GetBigClassUrl("悠口培训基地一览"))
		Code = Replace(Code, "{$学员风采More$}", GetBigClassUrl("学员风采"))
		Code = Replace(Code, "{$诱人美味More$}", GetBigClassUrl("诱人美味"))	
		Code = Replace(Code, "{$悠口培训新闻More$}", GetBigClassUrl("悠口培训新闻"))
		Code = Replace(Code, "{$餐饮行业新闻More$}", GetBigClassUrl("餐饮行业新闻"))
		Code = Replace(Code, "{$餐饮店面经营管理More$}", GetBigClassUrl("餐饮店面经营管理"))
		Code = Replace(Code, "{$饮食文化More$}", GetBigClassUrl("饮食文化"))
		Code = Replace(Code, "{$地方特色美食More$}", GetBigClassUrl("地方特色美食"))
		Code = Replace(Code, "{$厨艺培训交流More$}", GetBigClassUrl("厨艺培训交流"))
		
		DefaultWebBanner = "/Skins/YouKou/Index/Banner.jpg"
		Code = Replace(Code, "{$MainBanner$}",  ObjYK.MainBanner(a,b,c,d,e))
	
		Code = Replace(Code, "{$培训场景$}", ScrollPhoto("培训场景",12,160,130,"培训场景","") )
		Code = Replace(Code, "{$培训场景JS$}", JsPhotoScroll("培训场景",740,158) )
		
		Code = Replace(Code, "{$诱人美味$}", ScrollPhoto("诱人美味",12,160,130,"诱人美味","") )
		Code = Replace(Code, "{$诱人美味JS$}", JsPhotoScroll("诱人美味",960,158) )
		
		Code = Replace(Code, "{$学员风采$}", ScrollPhoto("学员风采",12,160,130,"学员风采","") )
		Code = Replace(Code, "{$学员风采JS$}", JsPhotoScroll("学员风采",960,158) )
		
		Code = Replace(Code, "{$悠口培训基地一览$}", ScrollPhoto("悠口培训基地一览",12,160,130,"悠口培训基地一览","") )
		Code = Replace(Code, "{$悠口培训基地一览JS$}", JsPhotoScroll("悠口培训基地一览",960,158) )
		

		
		o = StrCut(GetFText("/Templates/PublicModule/QQOnline2/2.html"),"[开始]","[结束]",2)
		If o = "" Then Call Eerr("QQ样式二","为空")
		Code = Replace(Code, "<body>", "<body>" & o)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		o = StrCut(GetFText("../Templates/PublicModule/右下角浮动层.html"),"[开始]","[结束]",2)
		Code = Replace(Code, "<body>", "<body>" & o)
		Code = Replace(Code, "{$最新动态标题$}", "悠口最新动态")
		Code = Replace(Code, "{$最新动态内容$}", LiTypeNewList("悠口最新动态",6, 40 ,""))
	
 		TemplateHTMLCode = Code					
	
	
	ElseIf WebSkins = "\Skins\MaiSiDe\" Then
		
		
		Code = Replace(Code, "{$WebTopNav$}", ObjYK.NewWebNavigation(a,"Where NavTop=True  Order By Sort Asc"))
		
		Code = Replace(Code, "{$WebBottomNav$}", ObjYK.WebNavigation("Where NavButtom=True  Order By Sort Asc"))
		
		
		Code = Replace(Code, "{$Banner$}", ObjYK.BannerTab("Banner",6,"","",""))
		
		
		Code = Replace(Code, "{$热搜关键词$}", HotSearch(""))
		
		Code = Replace(Code, "{$产品类别展示$}", ObjMSD.LeftClassList("副导航", d, e, ""))
		
		Code = Replace(Code, "{$为什么在麦思德培训$}", ReadMainInfo("为什么在麦思德培训"))
		
		
		Code = Replace(Code, "{$最新学员$}", ObjYK.ShowHandleUserList(100))
		Code = Replace(Code, "{$最新学员$}", ReadScrollMemberList(100,""))
		
		Code = Replace(Code, "{$热门技术推荐$}", CaseList("产品展示",12," Where Recommend=True And BigFiles<>'' "))
		
		Code = Replace(Code, "{$友情链接$}", ObjYK.FriendLink())
		
		
		Code = Replace(Code, "{$麦思德汉堡新闻$}", ReadNewList("麦思德汉堡新闻",6, 40 ," Order By AddDateTime Desc"))
		Code = Replace(Code, "{$餐饮行业新闻$}", ReadNewList("餐饮行业新闻",6, 40 ," Order By AddDateTime Desc"))
		Code = Replace(Code, "{$餐饮店面经营管理$}", ReadNewList("餐饮店面经营管理",6, 40 ," Order By AddDateTime Desc"))
		Code = Replace(Code, "{$饮食文化$}", ReadNewList("饮食文化",6, 40 ," Order By Sort Asc"))
		Code = Replace(Code, "{$地方特色美食$}", ReadNewList("地方特色美食",6, 40 ," Order By AddDateTime Desc"))
		Code = Replace(Code, "{$常见问题解答$}", ReadNewList("常见问题解答",6, 40 ," Order By AddDateTime Desc"))
		
		Code = Replace(Code, "{$网站地图$}", GetNavUrl("网站地图",""))
		Code = Replace(Code, "{$网站地图Target$}", GetNavTarget("网站地图",""))	
		
		Code = Replace(Code, "{$麦思德汉堡新闻链接$}", GetClassUrl_Nav("麦思德汉堡新闻","",""))
		Code = Replace(Code, "{$成功案例链接$}", GetClassUrl_Nav("成功案例","",""))	
		Code = Replace(Code, "{$汉堡加盟菜单副导航链接$}", GetClassUrl_Nav("副导航","汉堡加盟菜单",""))	

		Code = Replace(Code, "{$麦思德汉堡新闻More$}", GetBigClassUrl("麦思德汉堡新闻"))
		Code = Replace(Code, "{$培训场景More$}", GetBigClassUrl("培训场景"))
		Code = Replace(Code, "{$热门技术推荐More$}", GetBigClassUrl("热门技术推荐"))
		Code = Replace(Code, "{$麦思德培训基地一览More$}", GetBigClassUrl("麦思德培训基地一览"))
		Code = Replace(Code, "{$学员风采More$}", GetBigClassUrl("学员风采"))
		Code = Replace(Code, "{$诱人美味More$}", GetBigClassUrl("诱人美味"))	
		Code = Replace(Code, "{$麦思德培训新闻More$}", GetBigClassUrl("麦思德培训新闻"))
		Code = Replace(Code, "{$餐饮行业新闻More$}", GetBigClassUrl("餐饮行业新闻"))
		Code = Replace(Code, "{$餐饮店面经营管理More$}", GetBigClassUrl("餐饮店面经营管理"))
		Code = Replace(Code, "{$饮食文化More$}", GetBigClassUrl("饮食文化"))
		Code = Replace(Code, "{$地方特色美食More$}", GetBigClassUrl("地方特色美食"))
		Code = Replace(Code, "{$常见问题解答More$}", GetBigClassUrl("常见问题解答"))
		Code = Replace(Code, "{$麦思德培训基地一览More$}", GetBigClassUrl("麦思德培训基地一览"))
		Code = Replace(Code, "{$成功案例More$}", GetBigClassUrl("成功案例"))
		
		DefaultWebBanner = "/DataDir/WebImg/Banner/麦思德理念.jpg"
		Code = Replace(Code, "{$MainBanner$}",  ObjYK.MainBanner(a,b,c,d,e))
	
		Code = Replace(Code, "{$培训场景$}", ScrollPhoto("培训场景",12,160,130,"培训场景"," Order By AddDateTime Desc") )
		Code = Replace(Code, "{$培训场景JS$}", JsPhotoScroll("培训场景",740,158) )
	
		Code = Replace(Code, "{$成功案例$}", ScrollPhoto("成功案例",12,160,130,"成功案例"," Order By AddDateTime Desc") )
		Code = Replace(Code, "{$成功案例JS$}", JsPhotoScroll("成功案例",740,158) )
		
		Code = Replace(Code, "{$诱人美味$}", ScrollPhoto("诱人美味",12,160,130,"诱人美味"," Order By AddDateTime Desc") )
		Code = Replace(Code, "{$诱人美味JS$}", JsPhotoScroll("诱人美味",960,158) )
		
		Code = Replace(Code, "{$学员风采$}", ScrollPhoto("学员风采",12,160,130,"学员风采"," Order By AddDateTime Desc") )
		Code = Replace(Code, "{$学员风采JS$}", JsPhotoScroll("学员风采",960,158) )
		
		Code = Replace(Code, "{$麦思德培训基地一览$}", ScrollPhoto("麦思德培训基地一览",12,160,130,"麦思德培训基地一览"," Order By AddDateTime Desc") )
		Code = Replace(Code, "{$麦思德培训基地一览JS$}", JsPhotoScroll("麦思德培训基地一览",960,158) )
		
		
		Code = ManyTimesHandleTemplateAction(Code)			
		If 1=1 Then
		o = StrCut(GetFText("../Templates/PublicModule/右下角浮动层.html"),"[开始]","[结束]",2)
		Code = Replace(Code, "<body>", "<body>" & o)
		Code = Replace(Code, "{$最新动态标题$}", "麦思德最新动态")
		Code = Replace(Code, "{$最新动态内容$}", LiTypeNewList("麦思德最新动态",6, 40 ,""))
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		o = StrCut(GetFText("../Templates/PublicModule/餐饮菜单图片.html"),"[开始]","[结束]",2)
		Code = Replace(Code, "<!--餐饮图片-->", o)
		
		o = StrCut(GetFText("../Templates/PublicModule/展示Banner.html"),"[开始]","[结束]",2)
		Code = Replace(Code, "<!--展示Banner-->", o)
		
		o = StrCut(GetFText("../Templates/PublicModule/展示Banner.html"),"[JS开始]","[JS结束]",2)
		Code = Replace(Code, "<!--JS展示Banner-->", o)
		
		
		
		
		
		o = StrCut(GetFText("../Templates/PublicModule/麦思德视频.html"),"[开始]","[结束]",2)
		Code = Replace(Code, "<body>", "<body>" & o)
		
		End If
		
		
		
 		TemplateHTMLCode = Code					
 	End If
	
 	
	If f="Class" Or InStr("|产品|新闻|下载|","|" & WebNavType & "|")>0  Then
		MainContent = ProductList(c, d, e,f,"","",1)
		j = Code
		
		Code = ManyTimesHandleTemplateAction(j)					
		
		MainContent = ProductList(c, d, e,f,"","", 1) : TempMainContent = MainContent
		Code = Replace(TemplateHTMLCode, "{$MainContent$}", MainContent)
		
		
		If CreateHtmlPath = "" Then
			Call Eerr("Class","创建类出问题，可能没有这个类")
		End If
		If CheckMakeHtmlFile(CreateHtmlPath) = False Then
			Call WriteToFile(CreateHtmlPath, ManyTimesHandleTemplateAction(j),1)	
			call handleMakeHtmlFileEditTime(CreateHtmlPath)		
		end if
		
		If CreatePage > 1 Then
			For l=2 To CreatePage
				If (Request("Page")=CStr(l) Or Request("Page")="") And InStr(TemplateHTMLCode,"{$MainContent$}")>0 Then
					k = CreateHtmlPath					
					
					MainContent = ProductList(c, d, e,f,"","", l)
					Code = Replace(TemplateHTMLCode, "{$MainContent$}", MainContent)
					Code = ManyTimesHandleTemplateAction(Code)		
					Call CreateDirFolder(k)		
					
					q=k
					q=Mid(k,1,InStr(k,".")-1)
					q=q & l & Mid(k,InStr(k,"."))
					
					If Request("MackHtml") <> "False" Then
						Call Echo("当前第【"& l &"】页",q)
					End If
					if makeHtmlFileToLCase = true then
						q=lcase(q)		
					end if
					
					content=HandleWebCodeReplaceTpl(ManyTimesHandleTemplateAction(Code))
					
					if u=true then
						if checkHtmlFormatting(content)=false then
							call echoRed("检测html标签出错", CreateHtmlPath)
						end if
					end if
				
					
					Call WriteToFile(q, content,1) 	
		 			call handleMakeHtmlFileEditTime(q)		
				End If
				DoEvents
			Next
			If Request("Page")="" Then
				Code = Replace(TemplateHTMLCode, "{$MainContent$}", TempMainContent)
				Code = ManyTimesHandleTemplateAction(Code)		
			End If
		End If
		m=True 			
		
		
		If Request("MackHtml") <> "False" Then
			Call Echo(c & ">>" & d & ">>" & e ,"共生成【"& CreatePage &"】页")
		End If
	ElseIf f = "Search" Then
		Page = IIF(Request("Page")<>"",Request("Page"),1)
		MainContent =  ProductList(c, d, e,f, h, i, Page)	
		m=False
	End If
	
	If Rq("HttpIP")<>"" Then	
		Code = Replace(Code, GetServicerIP, Rq("HttpIP"))
	End If
	
	
	Code = ManyTimesHandleTemplateAction(Code)

	
	If Request("MackHtml") <> "False" Then
		
		if checkfolder(CreateHtmlPath)=true then
			m=false
		end if
		
		If GetIP="127.0.0.1" Or Session("Administrator") <> "" Or MD5(Request("P"), 1) = "d7213640" Then
			Call Echo("生成Html路径CreateHtmlPath", "<a href='"& HandleHttpUrl(WebDoMain() & CreateHtmlPath) &"'"& ATarget("_blank") &">"& handlePath(CreateHtmlPath) &"</a>") 			
			DoEvents
			Call Echo("CreateHtmlYes",m)
			If CheckFile(TemplatePath)=True Then
				
				
				
				If m=True Then
					If CheckMakeHtmlFile(CreateHtmlPath)=True Then
						Call CreateDirFolder(CreateHtmlPath)		
						if makeHtmlFileToLCase = true then
							CreateHtmlPath=lcase(CreateHtmlPath)		
						end if
						content=HandleWebCodeReplaceTpl(ManyTimesHandleTemplateAction(Code))
						
						if u=true then
							if checkHtmlFormatting(content)=false then
								call echoRed("检测html标签出错", CreateHtmlPath)
							end if
						end if
						
						Call WriteToFile(CreateHtmlPath, content,1)			
						
						call handleMakeHtmlFileEditTime(CreateHtmlPath)		
					End If
				End If
			Else
				Call SetColorEcho("Green","生成失败", "模板文件【"& TemplatePath  &"】不存在")
			End If
		Else
			Call Echo("生成文件失败","未登录")
		End If
		If Request("gotoHtml") = "true" Then
			call eerr("跳转网址" & HandleHttpUrl(WebDoMain() & CreateHtmlPath), "<script>javascript:location='"& HandleHttpUrl(WebDoMain() & CreateHtmlPath) &"'</script>")
		end if
	End If
	
	If Request("DisplayYes")="False"  Then DisplayYes = False
    If DisplayYes = True Then
		
		If Rq("ToHtml")="true" Then
			
			Call Die("<script>location.href='"& CreateHtmlPath &"'</script>")
			Call eerr("CreateHtmlPath",CreateHtmlPath)		
		
		ElseIf Rq("gl") = "edit" Then			
			If InStr(Code,"</head>")>0 Then
				Code = Replace(Code,"</head>", "<script src=""/Jquery/Callcontext_menu.js""></script></head>")
			Else
				Code = Code & ControlDialogCss()
			End If
			If InStr(Code,"<body>")>0 Then
				Code = Replace(Code,"<body>", "<body onLoad=""ContextMenu.intializeContextMenu()"">")
			Else
				Code = Code & ControlDialogCss()
			End If
		End If
		Call Rw(HandleWebCodeReplaceTpl(Code))		
	End If
End Sub


Function handleMakeHtmlFileEditTime(a)
    If checkfolder("\VB工程\") = False Then Exit Function
    If 1 = 2 Then Exit Function
	
    Dim b, c, templateFileEditTime 	
    b = WebTemplate & "/AVBConfig/" & HandleFilePathArray(TemplatePath)(3) & ".tpl"
	
	
	
    templateFileEditTime = GetFileEditDate(b)

    c = GetStrCut(getftext(b), "<VB IncludeTemplateFile path='", "'", 2)
    If c <> "" Then
		
        c = GetStrCut(getftext("\VB工程\SysInfo.ini"), "DefaultTemplateFolder=", vbCrLf, 2) & c
		
		dim fileTime				
		fileTime = GetFileEditDate(c)
		
		templateFileEditTime=fileTime
		
		if templateFileEditTime<>"" then			
			if cdate(fileTime)<cdate(templateFileEditTime) then
				templateFileEditTime=fileTime
			end if
		else
			templateFileEditTime=fileTime
		end if

    End If
	
    If templateFileEditTime <> "" Then
        Call ModifyFileModifydate(a, templateFileEditTime)
    End If
End Function



Sub Default()	
	If GetIP<>"127.0.0.1" And Session("Administrator") = "" Then
		Call Echo("提示","管理员未登录")
		If Request("VBPass") <> "" Then
			Session("Administrator") = "vbLogin"
		End If
		Exit Sub
	End If
	Dim b,c
    b=b & "<script language=""javascript"">" & vbCrlf
    b=b & "// 确定操作" & vbCrlf
    b=b & "function Confirm(){" & vbCrlf
    b=b & "	if(confirm(""你确定要操作吗？\n操作后将不可恢复""))" & vbCrlf
    b=b & "	return true;" & vbCrlf
    b=b & "	else" & vbCrlf
    b=b & "	return false;" & vbCrlf
    b=b & "}" & vbCrlf
    b=b & "</script>" & vbCrlf
	Call Rw(b)
	Call Rw("<div style=""height:400px;"">")
	c=" onClick='return Confirm();'"
	b = "全部生成</a> &nbsp; | <a "& AHref("?act=CreateNavList&File=False","","_blank") & c &">生成全部未生成</a>"
	b = b & "  | <a href=http://www.maiside.net/Inc/Create_Html.Asp target='_blank'>新页打开</a>"
	Call Echo("导航生成","<a "& AHref("?act=ShowNavList","","_blank") &">点击进入</a> &nbsp; | <a "& AHref("?act=CreateNavList","","_blank") & c & ">" & b)	
	Call Rw("<hr>")
	
	b = "全部生成</a> &nbsp; | <a "& AHref("?act=CreateClassList&File=False","","_blank") & c &">生成全部未生成</a>"
	Call Echo("类别生成","<a "& AHref("?act=ShowClassList","","_blank") &">点击进入</a> &nbsp; | <a "& AHref("?act=CreateClassList","","_blank") & c &">" & b)	
	Call Rw("<hr>")
	
	b = "全部生成</a> &nbsp; | <a "& AHref("?act=CreateArticleList&File=False","","_blank") & c &">生成全部未生成</a>"	
	Call Echo("文章生成","<a "& AHref("?act=ShowArticleList","","_blank") &">点击进入</a> &nbsp; | <a "& AHref("?act=CreateArticleList","","_blank") & c &">" & b)
	Call Rw("<hr>")
	
	Call Echo("会员生成","<a "& AHref("?act=ShowMemberList","","_blank") &">点击进入</a> &nbsp; | <a "& AHref("?act=CreateMemberList","","_blank") & c &">全部生成</a>")
	Call Rw("<hr>")
	
	Call Echo("生成RSS/Feed.Xml","<a "& AHref("Rss.Asp","","_blank") & c &">点击生成</a>")
	Call Rw("<hr>")
	Call Echo("删除文件","<a "& AHref("?act=ShowDelHtmllist","","_blank") &">点击进入</a> &nbsp; | <a "& AHref("?act=ShowDelHtmllist&All=True","","_blank") & c &">删除全部HTML</a>")
	Call Hr()
	Call Echo("生成网站地图","<a "& AHref("?act=MakeSiteMap","","_blank") &">点击进入</a>")
	Call Rw("</div>")
End Sub

Sub ShowNavList()
	Dim b,c
	Call Rw("<title>显示生成导航列表</title>")
    Rs.Open "Select * From [NavBigClass] Order By Sort Asc", Conn, 1, 1
    While Not Rs.Eof		
		If Rs("OnHtml") = True Then
					
			b = Rs("FileName")
			If CheckMakeHtmlFile(b)=True Then
				c =  "<a href=""?act=Nav&NavDid="& Rs("BigClassName") &"&DisplayYes=False"" "& ATarget("_blank") &">点击生成</a>&nbsp;|&nbsp;"
				c=c &  "<a href=""?Debug=1&act=Nav&NavDid="& Rs("BigClassName") &"&MackHtml=False"" "& ATarget("_blank") &">动态预览</a>"
				Call Echo( Rs("BigClassName") & "("& Rs("NavType") &")",c)
			Else
				Call Rw(Rs("BigClassName") & " &nbsp; &nbsp; 为网址("& b &")，不生成<br>")
			End If
			
		Else
			Call Rw(Rs("BigClassName") & " &nbsp; &nbsp; 生成HTML未开启<br>")
		End If
    	Rsx.Open "Select * From [NavSmallClass] Where BigClassName='"& Rs("BigClassName") &"' Order By Sort Asc", Conn, 1, 1
		While Not Rsx.Eof
			
			If Rsx("OnHtml") = True Then
			
				b = Rsx("FileName")
				If CheckMakeHtmlFile(b)=True Then
					c = "<a href=""?act=Nav&NavDid="& Rsx("BigClassName") &"&NavSid="& Rsx("SmallClassName") &""" "& ATarget("_blank") &">点击生成</a>&nbsp;|&nbsp;"
					c=c &  "<a href=""?Debug=1&act=Nav&NavDid="& Rs("BigClassName") &"&NavSid="& Rsx("SmallClassName") &"&MackHtml=False"" "& ATarget("_blank") &">动态预览</a>"
					Call Echo( " &nbsp; &nbsp;[小类] " & Rsx("SmallClassName"), c)
				Else
					Call Rw(" &nbsp; &nbsp;[小类] " & Rsx("SmallClassName") & "为网址，不生成<br>")
				End If
				
				
			Else
				Call Rw(" &nbsp; &nbsp;[小类] " & Rsx("SmallClassName") & "生成HTML未开启<br>")
			End If
		Rsx.MoveNext : Wend : Rsx.Close
    Rs.MoveNext : Wend : Rs.Close
	Call Echo("全部生成", "<a href=""?act=CreateNavList"" "& ATarget("_blank") &">点击生成全部导航</a>")
End Sub



Function HandleCodeReplace(ByVal a)
	Dim b,c,d,e,f,g
	
	
	
	b = Request("FindTpl")
	c = Request("ReplaceTpl")
	
	
	If b = "" Then
		b = "style='312'"
	End If
	
	If WebModuleSkins <> "" Then
		c = c & "style='"& WebModuleSkins &"'"		
	End If
	If c = "" Then HandleCodeReplace=a : Exit Function
	
	
	
	d=Split(b,"|")
	e=Split(c,"|")
	For f=0 To Ubound(d)
		g=""
		If Ubound(e)>=f Then
			g=e(f)
		End If
		a=Replace(a,d(f),g)
	Next
	
	
	d=Split(WebFindTpl,"[$Array$]")
	e=Split(WebReplaceTpl,"[$Array$]")
	For f=0 To Ubound(d)
		g=""
		If Ubound(e)>=f Then
			g=e(f)
		End If
		a=Replace(a,d(f),g)
	Next
	HandleCodeReplace = a
	
End Function

Function HandleWebCodeReplaceTpl(a)
	Dim b,c,d,e
	
	b=Split(WebCodeFindTpl,"[$Array$]")
	c=Split(WebCodeReplaceTpl,"[$Array$]")
	For d=0 To Ubound(b)
		e=""
		If Ubound(c)>=d Then
			e=c(d)
		End If
		a=Replace(a,b(d),e)
	Next
	HandleWebCodeReplaceTpl = a
End Function

Sub RunFile()
	Dim b,c
	b=Request("File")
	c=GetFText(b)
	c = ManyTimesHandleTemplateAction(c)					
	Rw(c)
	Response.End()
End Sub


Function  CreateNavList()
	Dim b, c,d,e,f,g,h
	f = 0					
	d = Now ()
	DisplayYes = False			
	Set b = CreateObject("Adodb.RecordSet")
	Set c = CreateObject("Adodb.RecordSet")
	b.Open "Select * From [NavBigClass] Where OnHtml=True Order By Sort", Conn, 1, 1
	f = f + b.RecordCount
	While Not b.Eof
		g = False
		If LCase(Request("File"))="false" Then
			Call GetNavTemplateText(b("BigClassName"), "", "")
			g = CheckFile(CreateHtmlPath)
		End If
		e = e + 1
		Call Echo("当前位置",e & "/" & f)
		
		If g = False Then
			h = b("FileName")
			If CheckMakeHtmlFile(h)=True Then			
				Call Echo("导航大类", b("BigClassName"))
				Call MakeWebHtml(b("BigClassName"),"","","","","Nav","","","")
			Else
				Call Rw("导航大类：" & b("BigClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
			End If
			
			
		Else
			Call Echo("导航大类("& b("BigClassName") &")", "<a href='"& CreateHtmlPath &"'"& ATarget("_blank") &">"& CreateHtmlPath &"</a>" & "已经存在")
		End If
		
		c.Open "Select * From [NavSmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", Conn, 1, 1
		f = f + c.RecordCount
		While Not c.Eof				
			g = False
			If LCase(Request("File"))="false" Then
				Call GetNavTemplateText(c("BigClassName"), c("SmallClassName"), "")
				g = CheckFile(CreateHtmlPath)
			End If
			e = e + 1
			If g = False Then
				h = c("FileName")
				If CheckMakeHtmlFile(h)=True Then			
					Call Echo(" &nbsp; &nbsp;导航小类", c("SmallClassName"))
					Call MakeWebHtml(c("BigClassName"),c("SmallClassName"),"","","","Nav","","","")
				Else
					Call Rw("导航小类：" & c("SmallClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
				End If
				
			Else
				Call Echo(" &nbsp; &nbsp;导航小类", "<a href='"& CreateHtmlPath &"'"& ATarget("_blank") &">"& CreateHtmlPath &"</a>" & "已经存在")
			End If
		c.MoveNext : Wend : c.Close
		DoEvents
		Call HR()
	b.MoveNext:Wend:b.Close
	Set b = Nothing
	Set c = Nothing
	Call Echo("操作完成", "导航，共生成文件【"& f &"】个，用时" & PrintTimeValue(DateDiff("s", d, Now())) )
End Function

Sub ShowClassList()
	Dim b,S	
	Call Rw("<title>显示生成产品类别列表</title>")
    Rs.Open "Select * From [BigClass] Order By Sort Asc", Conn, 1, 1
    While Not Rs.Eof
	
		b = Rs("FileName")
		If CheckMakeHtmlFile(b)=True Then
			S = "<a href=""?act=CreateClass&ProDid="& Rs("BigClassName") &""" "& ATarget("_blank") &">点击生成</a>&nbsp;|&nbsp;"
			S=S & "<a href=""?Debug=1&act=CreateClass&ProDid="& Rs("BigClassName") &"&MackHtml=False"" "& ATarget("_blank") &">动态预览</a>"
			Call Echo( Rs("BigClassName") & "(大类)", S)
		Else
			Call Rw("类别大类：" & Rs("BigClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
		End If
		
    	Rsx.Open "Select * From [SmallClass] Where BigClassName='"& Rs("BigClassName") &"' Order By Sort Asc", Conn, 1, 1
		While Not Rsx.Eof
		
			b = Rsx("FileName")
			If CheckMakeHtmlFile(b)=True Then
				S = "<a href=""?act=CreateClass&ProDid="& Rsx("BigClassName") &"&ProSid="& Rsx("SmallClassName") &""" "& ATarget("_blank") &">点击生成</a>&nbsp;|&nbsp;"
				S=S & "<a href=""?Debug=1&act=CreateClass&ProDid="& Rs("BigClassName") &"&ProSid="& Rsx("SmallClassName") &"&MackHtml=False"" "& ATarget("_blank") &">动态预览</a>"
				
				Call Echo( " &nbsp; &nbsp;"&  Rsx("SmallClassName") &"[小类] ", S)
			Else
				Call Rw("类别小类：" & Rsx("SmallClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
			End If
			
			
			
			
			Rss.Open "Select * From [ThreeClass] Where BigClassName='"& Rsx("BigClassName") &"' And SmallClassName='"& Rsx("SmallClassName") &"' Order By Sort Asc", Conn, 1, 1
			While Not Rss.Eof
			
			
			b = Rss("FileName")
			If CheckMakeHtmlFile(b)=True Then
				S = "<a href=""?act=CreateClass&ProDid="& Rss("BigClassName") &"&ProSid="& Rss("SmallClassName") &"&ProTid="& Rss("ThreeClassName") &""" "& ATarget("_blank") &">点击生成</a>&nbsp;|&nbsp;"
				
S=S & "<a href=""?Debug=1&act=CreateClass&ProDid="& Rs("BigClassName") &"&ProSid="& Rsx("SmallClassName") &"&ProTid=" & Rss("ThreeClassName") &"&MackHtml=False"" "& ATarget("_blank") &">动态预览</a>"
				
				
				
				Call Echo( " &nbsp; &nbsp; &nbsp; &nbsp;"&  Rss("ThreeClassName") &"[子类] ", S)
			Else
				Call Rw("类别子类：" & Rss("ThreeClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
			End If
			Rss.MoveNext : Wend : Rss.Close
		Rsx.MoveNext : Wend : Rsx.Close
    Rs.MoveNext : Wend : Rs.Close
	Call Echo("全部生成", "<a href=""?act=CreateClassList"" "& ATarget("_blank") &">点击生成全部信息类别列表</a>")
End Sub

Function  CreateClassList()
	Dim b, c, d,e,f,g,h,i,j
	g = 0					
	f = 0
	e = Now ()
	DisplayYes = False			
	Set b = CreateObject("Adodb.RecordSet")
	Set c = CreateObject("Adodb.RecordSet")
	Set d = CreateObject("Adodb.RecordSet")
	b.Open "Select * From [BigClass] Where OnHtml=True Order By Sort", Conn, 1, 1
	g = g + b.RecordCount
	While Not b.Eof
		i = False
		If LCase(Request("File"))="false" Then
			Call GetClassTemplateText(b("BigClassName"), "", "")
			i = CheckFile(CreateHtmlPath)
		End If	
		f = f + 1
		Call Echo("当前位置",f & "/" & g)
		If i = False Then	
		
			j = b("FileName")
			If CheckMakeHtmlFile(j)=True Then
				Call Echo("类别大类", b("BigClassName"))
				Call MakeWebHtml("","",b("BigClassName"),"","","Class","","","")
			Else
				Call Rw("类别大类：" & b("BigClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
			End If
		Else
			CreateHtmlPath = "<a href='"& CreateHtmlPath &"' target='_blank'>"& CreateHtmlPath &"</a>"
			Call Echo("类别大类("& b("BigClassName") &")", CreateHtmlPath & "已经存在")
		End If
		Call Hr()
		DoEvents
		
		c.Open "Select * From [SmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", Conn, 1, 1
		g = g + c.RecordCount
		While Not c.Eof		
			i = False
			If LCase(Request("File"))="false" Then
				Call GetClassTemplateText(c("BigClassName"), c("SmallClassName"), "")
				i = CheckFile(CreateHtmlPath)
			End If		
			f = f + 1
			Call Echo("当前位置",f & "/" & g)
			If i = False Then	
			
			j = c("FileName")
			If CheckMakeHtmlFile(j)=True Then
				Call Echo(" &nbsp; &nbsp;类别小类", c("SmallClassName"))
				Call MakeWebHtml("","",c("BigClassName"),c("SmallClassName"),"","Class","","","")
			Else
				Call Rw("类别子类：" & c("SmallClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
			End If
				
			Else
				CreateHtmlPath = "<a href='"& CreateHtmlPath &"' target='_blank'>"& CreateHtmlPath &"</a>"
				Call Echo(" &nbsp; &nbsp;类别小类("& c("SmallClassName") &")", CreateHtmlPath & "已经存在")
			End If
			Call Hr()
			DoEvents
			h = " And SmallClassName='"& c("SmallClassName") &"' And OnHtml=True Order By Sort Asc"
			d.Open "Select * From [ThreeClass] Where BigClassName='"& b("BigClassName") &"' " & h, Conn, 1, 1
			g = g + d.RecordCount
			While Not d.Eof		
				i = False
				If LCase(Request("File"))="false" Then
					Call Echo("WebTitle",WebTitle)
					Call GetClassTemplateText(d("BigClassName"), d("SmallClassName"), d("ThreeClassName"))
					i = CheckFile(CreateHtmlPath)
				End If
				f = f + 1
				Call Echo("当前位置",f & "/" & g)
				If i = False Then
				


				j = d("FileName")
				If CheckMakeHtmlFile(j)=True Then
					Call Echo(" &nbsp; &nbsp; &nbsp; &nbsp;类别子类", d("SmallClassName"))
					Call MakeWebHtml("","",d("BigClassName"),d("SmallClassName"), d("ThreeClassName"),"Class","","","")
				Else
					Call Rw("类别子类：" & d("ThreeClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
				End If
				
				
				Else
					CreateHtmlPath = "<a href='"& CreateHtmlPath &"' target='_blank'>"& CreateHtmlPath &"</a>"
					Call Echo(" &nbsp; &nbsp; &nbsp; &nbsp;类别子类("& d("ThreeClassName") &")", CreateHtmlPath & "已经存在")
				End If
				Call Hr()
				DoEvents
			d.MoveNext : Wend : d.Close
			DoEvents			
		c.MoveNext : Wend : c.Close 		
	b.MoveNext:Wend:b.Close
	Set b = Nothing
	Set c = Nothing
	Set d = Nothing
	Call Echo("操作完成", "产品类别，共生成文件【"& g &"】个，用时" & PrintTimeValue(DateDiff("s", e, Now())) )
End Function

Sub ShowMemberList()
	Dim b
    Rs.Open "Select * From [Member] Order By Sort Asc", Conn, 1, 1
    While Not Rs.Eof
    	Call Echo( Rs("MyName") & "(会员账号)", "<a href=""?act=CreateMember&ID="& Rs("ID") &""" "& ATarget("_blank") &">点击生成</a>")
    Rs.MoveNext : Wend : Rs.Close
	Call Echo("全部生成", "<a href=""?act=CreateMemeberList"" "& ATarget("_blank") &">点击生成全部文章信息</a>")
End Sub
Sub ShowDelHtmllist()
	Dim b,c,d,e,f,g
	b=False
	If b = False Then
		If GetIP()="127.0.0.1" Then b=True
	End If
	c = Replace(Replace(LCase(GetHost()),"http://",""),"/","")
	If b = False Then
		If c="127.0.0.1" Or c = "localhost" Or Left(c,8)="192.168." Then b=True
	End If
	If b=True Then
		Call Echo("提示", "为本地，不可操作")		
		Response.End()
		Exit Sub
	End If
	e=GetDirHtmlList("/")
	d=Split(e,vbCrlf)
	For Each f In d
		Call Echo("删除文件成功", f)
		Call DeleteFile(f)
	Next
	e =GetDirFolderNameList("/")
	d=Split(e,vbCrlf)
	For Each g In d
		If InStr(LCase("|Action|Admin|AspBox|aspnet_client|BBS|DataDir|Data|Editor|Help|Images|Inc|Jquery|M|Maiside|maisideAPP|Mobile|Module|OtherAsp|QQ|Skins|Templates|UploadFiles|User|WebAdmin|Xinxi|XSS|CGI-BIN|HttpErrors|Web_Soft|"),"|"& LCase(g) &"|")=False Then
			Call Echo("删除文件夹成功", g)
			Call DeleteFolder("/" & g)
		End If
	Next
	Call Echo("删除全部HTML","完成")
End Sub

Sub ShowDelHtmllist2()
	Dim b, c,d,e,f,g,h,i,j,k,l
	f = 0					
	d = Now ()
	DisplayYes = False			
	Set b = CreateObject("Adodb.RecordSet")
	Set c = CreateObject("Adodb.RecordSet")
	Set j = CreateObject("Adodb.RecordSet")
	Set l = CreateObject("Adodb.RecordSet")
	
	b.Open "Select * From [NavBigClass] Where OnHtml=True Order By Sort", Conn, 1, 1
	f=f+b.RecordCount
	While Not b.Eof
		e = e + 1
		h = GetNavUrl(b("BigClassName"),"")
		If Right(h,1) = "/" Then h=h & "Index.html"		
		i = IIF(CheckFile(h)=True And Request("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
		i= "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
		Call Echo(b("BigClassName"), i )
		If Request("All")= "True" Then DelFile(h) : Call Echo("当前位置",e & "/" & f)
		Call HR()		
		DoEvents
		
		c.Open "Select * From [NavSmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", Conn, 1, 1
		f=f+c.RecordCount
		While Not c.Eof
		e = e + 1
			h =  GetNavUrl(c("BigClassName"),c("SmallClassName"))
			If Right(h,1) = "/" Then h=h & "Index.html"
			If Request("All")= "True" Then DelFile(h) : Call Echo("当前位置",e & "/" & f)
			
			i = IIF(CheckFile(h)=True And Request("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
			Call Echo(c("SmallClassName"),h & i)
			Call HR()
			DoEvents
		c.MoveNext : Wend : c.Close
	b.MoveNext:Wend:b.Close
	
	b.Open "Select * From [BigClass] Where OnHtml=True Order By Sort", Conn, 1, 1
	f=f+b.RecordCount
	While Not b.Eof
		e = e + 1
		h = GetBigClassFolderName(b("BigClassName"))
		If Right(h,1) = "/" Then h=h & "Index.html"			
		i = IIF(CheckFile(h)=True And Request("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
		i= "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
		Call Echo(b("BigClassName"), i )
		If Request("All")= "True" Then DelFile(h) : Call Echo("当前位置",e & "/" & f)
		Call HR()
		DoEvents
		
		c.Open "Select * From [SmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", Conn, 1, 1
		f=f+c.RecordCount
		While Not c.Eof	
		e = e + 1
			h = GetSmallClassFolderName(c("BigClassName"),c("SmallClassName") )
			If Right(h,1) = "/" Then h=h & "Index.html"			
			i = IIF(CheckFile(h)=True And Request("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
			i = "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
			Call Echo(" &nbsp; &nbsp; " & c("SmallClassName"), i )
			If Request("All")= "True" Then DelFile(h) : Call Echo("当前位置",e & "/" & f)
			Call HR()
			DoEvents
					
			k = " And SmallClassName='"& c("SmallClassName") &"' And OnHtml=True Order By Sort Asc"
			j.Open "Select * From [ThreeClass] Where BigClassName='"& c("BigClassName") &"' " & k, Conn, 1, 1
			f=f+j.RecordCount
			While Not j.Eof	
				e = e + 1
				h = GetThreeClassFolderName(j("BigClassName"),j("SmallClassName"),j("ThreeClassName") )
				If Right(h,1) = "/" Then h=h & "Index.html"
				i = IIF(CheckFile(h)=True And Request("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
				i = "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
				Call Echo(" &nbsp; &nbsp; &nbsp; &nbsp; " & j("ThreeClassName"), i )
				If Request("All")= "True" Then DelFile(h) : Call Echo("当前位置",e & "/" & f)
				Call HR()
				DoEvents
				
			j.MoveNext : Wend : j.Close		
		c.MoveNext : Wend : c.Close
	b.MoveNext:Wend:b.Close
	
	
    l.Open "Select * From [Product] Where OnHtml=True Order By Sort Asc", Conn, 1, 1
	f=f+l.RecordCount
    While Not l.Eof
		e = e + 1
		
		h = GetProductUrl("Where Id=" & l("ID"))
		If Right(h,1) = "/" Then h=h & "Index.html"
		i = IIF(CheckFile(h)=True And Request("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
		i = "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
		Call Echo(l("ID"), i )
		If Request("All")= "True" Then DelFile(h) : Call Echo("当前位置",e & "/" & f)
		Call HR()
		DoEvents
    l.MoveNext : Wend : l.Close
	
	If Request("All")= "True" Then
		Call Echo("操作完成", "删除，共删除文件【"& f &"】个，用时" & PrintTimeValue(DateDiff("s", d, Now())) )
	Else
		Call Echo("全部删除","<a "& AHref("?act=ShowDelHtmllist&All=True","","_blank") &">点击删除全部HTML</a>")
	End If
End Sub

Function DelFile(a)
	Dim b
	b = DeleteFile(a)
	Call Echo("删除文件", a & " &nbsp;" & b)
End Function

Sub ShowArticleList()
	Dim b,c
    Rs.Open "Select * From [Product] Where OnHtml=True Order By Id Desc", Conn, 1, 1 		
    While Not Rs.Eof	
		b = Rs("FileName")
		If CheckMakeHtmlFile(b)=True Then
			c = IIF(Rs("OnHtml") = True,"<a href=""?act=CreateArticle&ID="& Rs("ID") &""" "& ATarget("_blank") &">点击生成</a>&nbsp;|&nbsp;","")				
			
			c = c & "<a href=""?Debug=1&act=CreateArticle&ID="& Rs("ID") &"&MackHtml=False"" "& ATarget("_blank") &">动态预览</a>"
			
			b = GetHandleUrl( Rs("FolderName") & Rs("FileName"))
			b = " &nbsp; <a href='"& b &"' target='_blank'>"& b &"</a>," & CheckFile(b)		
			
			Call Echo( Rs("Title") & "(信息标题)", c & b & ",日期" & Format_Time(Rs("AddDateTime"),4))
		Else
			Call Rw("文章信息：" &  Rs("Title") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
		End If		
		
    Rs.MoveNext : Wend : Rs.Close
	Call Echo("全部生成", "<a href=""?act=CreateArticleList"" "& ATarget("_blank") &">点击生成全部文章信息</a>")
End Sub

Sub CreateArticle(a)
	Dim b,c,d,e
	Dim f,g,h,i
	Dim OriginalPhotoWidth		
	Dim nDetailPhotoWidth		
	Dim DetailPhotoWidthStr		
	Dim m,n,o,p,q,r,s
	Dim Author			
		
	Rs.Open"Select * From [Product] Where Id=" & a,Conn,1,1
	If Not Rs.Eof Then
		TempDid = Rs("BigClassName")
		TempSid = Rs("SmallClassName")
		TempTid = Rs("ThreeClassName")		
		
		
		PubProDid=TempDid
		PubProSid=TempSid
		PubProTid=TempTid
		
		MainTitle = Rs("Title")					
				
		c = Trim(IIF(IsNul(Rs("BigFiles")),Rs("SmallFiles"),Rs("BigFiles")))
		
		
		c = ReplaceGlobleLable(c) : d = c
		
		Dim TemplateSourceID				
		TemplateSourceID = GetArticleInfoStyle(TempDid,TempSid,TempTid,a)
		e = ReadArticleInfoStyleSource(TemplateSourceID)
				
		If (d <> "" And len(d)>5)  Then
			If CheckUrl(d) = False And checkFile(d)=True Then
				nDetailPhotoWidth = GetArticleInfoPhotoWidth(TempDid,TempSid,TempTid,a)					
				nDetailPhotoWidth = Cint(nDetailPhotoWidth)			

				
				
				
				OriginalPhotoWidth = GetImageWidthValue(d)					
				nDetailPhotoWidth = IIF(OriginalPhotoWidth>nDetailPhotoWidth,nDetailPhotoWidth,OriginalPhotoWidth)
				
				If nDetailPhotoWidth<>"" Then DetailPhotoWidthStr = " width="""& nDetailPhotoWidth &""""
				
			Else
				nDetailPhotoWidth = ""				
				DetailPhotoWidthStr = ""
			End If
		End If
		
		Author = Rs("Author")
		If Author="" Then Author="本站"
		

		
		
		e = Replace(e,"[$updownpage$]",UpPage(Rs(0)) & DownPage(Rs(0))) 			
		
		e = Replace(e,"[$detilphotowidth$]",nDetailPhotoWidth)						
		e = Replace(e,"[$detilphotowidthstr$]",DetailPhotoWidthStr)					
		
		e = ReplaceValueParam(e,"did",TempDid)
		e = ReplaceValueParam(e,"id",Rs("Id"))			
		e = ReplaceValueParam(e,"title",Rs("title"))
		e = ReplaceValueParam(e,"imgurl",c)
		e = ReplaceValueParam(e,"price",Rs("Price"))
		e = ReplaceValueParam(e,"description",Rs("WebDescription"))									
		e = ReplaceValueParam(e,"adddatetime",Rs("AddDateTime"))
		e = ReplaceValueParam(e,"author",Author)
		e = ReplaceValueParam(e,"content",Rs("Content"))
		MainContent = e
		
		
		If nDetailPhotoWidth = "" Then
			h = "<!--#photo start#-->" : i = "<!--#photo end#-->"
			
			If InStr(MainContent,h)>0 And InStr(MainContent,i)>0 Then
				e = StrCut(MainContent,h,i,2)
				
			End If
		End If
		
		
		
		MainContent = DisplayOnlineEditDialog(""& adminDir &"Product.Asp?act=ShowEditProduct&Id=" & Rs("Id") & "&n=" & GetRnd(11), MainContent)
		
		
		
		ArticleDid=Rs("BigClassName")				
		ArticleSid=Rs("SmallClassName")				
		ArticleTid=Rs("ThreeClassName")				
		ArticleTitle=Rs("Title")					
		ArticleBigFiles=Rs("BigFiles")				
		ArticleSmallFiles=Rs("SmallFiles")			
		
		ArticleID=Rs("Id")							
		ArticleDateTime=Rs("AddDateTime")			
		ArticleContent=Rs("Content")				
		ArticleAuthor = Rs("Author")				
		
		
		If Trim(Rs("TemplatePath"))<>"" Then
			TemplatePath = WebTemplate & Rs("TemplatePath")
		Else
			TemplatePath = WebTemplate & "Main_Model.Html"
		End If
		b = Rs("FileName")
		If CheckMakeHtmlFile(b)=True Then
			b = GetHandleFileName(b)
			b = DetailPageAddHtmlPrefix(Rs("FolderName")) & "/" & b
		End If
		CreateHTMLPath = b
		
		
		WebTitle = IIf(Rs("Title")<>"",Rs("Title"),WebTitle)
		WebTitle = IIf(Rs("WebTitle")<>"",Rs("WebTitle"),WebTitle)
		WebKeywords = IIf(Rs("WebKeywords")<>"",Rs("WebKeywords"),WebKeywords)
		WebDescription = IIf(Rs("WebDescription")<>"",Rs("WebDescription"),WebDescription)
	End If:Rs.Close
End Sub

Sub CreateMainInfo(a)
	Dim b,c
	Rs.Open"Select * From [MainInfo] Where Id=" & a,Conn,1,1
	If Not Rs.Eof Then
		
		
		
		
		MainContent = Rs("Content")
		MainContent = DisplayOnlineEditDialog(""& adminDir &"MainInfo.Asp?act=ShowEdit&Id=" & Rs("Id") & "&n=" & GetRnd(11), MainContent)			
		MainTitle = Rs("ShowTitle")
		
		
		If Trim(Rs("TemplatePath"))<>"" Then
			TemplatePath = WebTemplate & Rs("TemplatePath")
		Else
			TemplatePath = WebTemplate & "Main_Model.Html"
		End If
		
		b = Trim(Rs("FileName"))
		
		b = GetHandleFileName(b)
		
		Call CreateDirFolder("/Html")
		CreateHTMLPath = DetailPageAddHtmlPrefix(Rs("FolderName")) & "/" & b
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	
		
		
		WebTitle = IIf(Rs("Title")<>"",Rs("Title"),WebTitle)
		WebTitle = IIf(Rs("WebTitle")<>"",Rs("WebTitle"),WebTitle)
		WebKeywords = IIf(Rs("WebKeywords")<>"",Rs("WebKeywords"),WebKeywords)
		WebDescription = IIf(Rs("WebDescription")<>"",Rs("WebDescription"),WebDescription)
	End If:Rs.Close
End Sub

Sub CreateArticleList()
	Dim b,c,d,e,f
	d = 0					
	c = Now ()
	DisplayYes = False			
	Set b=CreateObject("Adodb.RecordSet")
    b.Open "Select Top 2999 * From [Product] Where ONHtml=True", Conn, 1, 1
    While Not b.Eof
		e = False
		call echo("文章ID", b("ID"))
		If LCase(Request("File"))="false" Then
			Call CreateArticle(b("ID"))
			e = CheckFile(CreateHtmlPath)
		End If
		d = d + 1
		Doevents
		If e = False Then
			Call Echo("当前位置", d & "/" & b.RecordCount)
			Doevents
			
			f = b("FileName")
			If CheckMakeHtmlFile(f)=True Then
				Call MakeWebHtml("","","","","","Article", b("Id"),"","")
			Else
				Call Rw("文章信息：" & b("Title") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
			End If
		Else
			CreateHtmlPath = "<a href='"& CreateHtmlPath &"' target='_blank'>"& CreateHtmlPath &"</a>"
			Call Echo("文章ID("& b("ID") &")", CreateHtmlPath & "已经存在，当前位置("& d & "/" & b.RecordCount &")")
		End If
		Call Hr()
		DoEvents
    b.MoveNext : Wend : b.Close
	Set b=Nothing
	Call Echo("操作完成", "文章，共生成文件【"& d &"】个，用时" & PrintTimeValue(DateDiff("s", c, Now())) )
End Sub

Sub GetWebConfig()
	Dim b, c
	
	If DefaultWebTitle <> "" Then		
		WebTitle = DefaultWebTitle
		WebKeywords = DefaultWebKeywords
		WebDescription = DefaultWebDescription
		Exit Sub
	End If

    Rs.Open "Select * From [WebSite]", Conn, 1, 1
    If Not Rs.Eof Then
        WebTemplate = HandleHttpUrl(Rs("WebTemplate"))
        WebSkins = HandleHttpUrl(Rs("WebSkins")) 		
        WebImages = HandleHttpUrl(Rs("WebImages")) 		
        WebCss = HandleHttpUrl(Rs("WebCss")) 		
        WebJs = HandleHttpUrl(Rs("WebJs"))
		
		WebFolderName = PHPTrim(Rs("WebFolderName"))			
		
		
		isHtmlFormatting = LCase(Rs("isHtmlFormatting"))
		isHtmlFormatting=IIF(isHtmlFormatting="0" Or isHtmlFormatting="false",false,true)
		
		isWebLabelClose = LCase(Rs("isWebLabelClose"))
		isWebLabelClose=IIF(isWebLabelClose="0" Or isWebLabelClose="false",false,true)
		
		WebUrl = Rs("WebSiteUrl")
		WebTitle = Rs("WebTitle")
        WebKeywords = Rs("WebKeywords")
        WebDescription = Rs("WebDescription")
		WebBottom = Rs("WebSiteBottom")
		
		WebModuleSkins = Rs("ModuleSkins")				
		WebFindTpl = Rs("FindTpl")				
		WebReplaceTpl = Rs("ReplaceTpl")		
		
		
		WebCodeFindTpl = Rs("WebCodeFindTpl")		
		WebCodeReplaceTpl = Rs("WebCodeReplaceTpl")		
		
		If IsNul(WebCodeFindTpl) Then WebCodeFindTpl=""
		If IsNul(WebCodeReplaceTpl) Then WebCodeReplaceTpl=""
		
		
		c=Rs("Id")
		b = ""& adminDir &"WebSiteConfig.Asp?n=" & GetRnd(11)	
		WebBottom = DisplayOnlineEditDialog(b, WebBottom)
		
		
		
    End If : Rs.Close
End Sub





Function Navigation(a)
    Dim b,c, d, e, f,g,h,i,j,k,l,m
    Rs.Open "Select * From [NavBigClass]" & a, Conn, 1, 1
	For b = 1 To Rs.RecordCount
        f = Rs("FileName")
        If f <> "" Then f = f & ".html"
		h = "/" & Rs("FolderName") & "/"
        e = h & f
        e = Replace(Replace(e, "//", "/"), "//", "/")
		j = Rs("BigClassName")
		k = FontColorFontB(j,Rs("FontB"),Rs("FontColor"))
		i = Rs("Target")
		g = ""
      	If b = 1 Then g = " class='CurrentLi'"
		c = "<li"& g &"><a "& AHref(e,"",i) &"{下拉菜单}>" & k & "</a></li> "
		If Rs("NavType") = "文本" Then
			Rss.Open "Select * From [NavSmallClass] Where BigClassName='"& Rs("BigClassName") &"'", Conn, 1, 1
			If Not Rs.Eof Then
				c = c & "<div id='m"& b &"' onmouseover='mcancelclosetime()' onmouseout='mclosetime()'>"
				While Not Rss.Eof
					f = Rss("FileName")
					If f <> "" Then f = f & ".html"
					e = h & f
					e = h & "/" & Rss("FolderName") & "/" & f
					e = Replace(Replace(e, "//", "/"), "//", "/")
					l = Rss("SmallClassName")
					m = FontColorFontB(l,Rss("FontB"),Rss("FontColor"))
					i = Rss("Target")
					c = c & "<a "& AHref(e,"",i) &">" & m & "</a>"
				Rss.MoveNext:Wend:Rss.Close
				c = c & "</div>"
				c = Replace(c,"{下拉菜单}", " onmouseover=mopen('m"& b &"') onmouseout='mclosetime()' ")
			End If
		ElseIf Rs("NavType") = "产品" Or Rs("NavType") = "新闻" Then
			Rss.Open "Select * From [SmallClass] Where BigClassName='"& Rs("BigClassName") &"'", Conn, 1, 1
			If Not Rs.Eof Then
				c = c & "<div id='m"& b &"' onmouseover='mcancelclosetime()' onmouseout='mclosetime()'>"
				While Not Rss.Eof
					f = Rss("FileName")
					If f <> "" Then f = f & ".html"
					e = h & f
					e = h & "/" & Rss("FolderName") & "/" & f
					e = Replace(Replace(e, "//", "/"), "//", "/")
					l = Rss("SmallClassName")
					m = FontColorFontB(l,Rss("FontB"),Rss("FontColor"))
					i = Rss("Target")
					c = c & "<a "& AHref(e,"",i) &">" & m & "</a>"
				Rss.MoveNext:Wend:Rss.Close
				c = c & "</div>"
				c = Replace(c,"{下拉菜单}", " onmouseover=mopen('m"& b &"') onmouseout='mclosetime()' ")
			End If
		
		End If
		c = Replace(c,"{下拉菜单}","")		
        d = d & c
    Rs.MoveNext : Next : Rs.Close
    Navigation = d
End Function

Function BottomNavigation(a)
    Dim b,c, d, e, f,g,h,i,j,k
    Rs.Open "Select * From [NavBigClass]" & a, Conn, 1, 1
	For b = 1 To Rs.RecordCount
        f = Rs("FileName")
        If f <> "" Then f = f & ".html"
		h = "/" & Rs("FolderName") & "/"
        e = h & f
        e = Replace(Replace(e, "//", "/"), "//", "/")
		i = Rs("BigClassName")
		j = FontColorFontB(i,Rs("FontB"),Rs("FontColor"))
		k = Rs("Target")
		d=d & "<a "& AHref(e,"",k) &"{下拉菜单}>" & j & "</a>"
		If b <> Rs.RecordCount Then d = d & " &nbsp;| &nbsp; "
		
	Rs.MoveNext : Next : Rs.Close
	BottomNavigation = d
End Function


Function GetMainInfo(a, b, c)
	Dim d,e
	Rs.Open"Select * From [MainInfo] Where Title='"& b &"' And Recommend=True Order By Sort,ID",Conn,1,1
	If Not Rs.Eof Then
		a = Replace(a, Replace(c,"$}","Title$}"), Rs("Title"))
		a = Replace(a, Replace(c,"$}","ShowTitle$}"), Rs("ShowTitle"))
		a = Replace(a, Replace(c,"$}","Content$}"), Rs("Content"))		
	End If : Rs.Close
	GetMainInfo = a
End Function

Function Logo(a)
	Dim b,c
	Rs.Open"Select * From [Product] Where BigClassName='"& a &"' And Recommend=True Order By Sort,ID",Conn,1,1
	If Not Rs.Eof Then
		b = GetHandleUrl( Rs("FileName") )
		c = "<a href='"& b &"' target='_blank'><img border=0 src='"& Rs("BigFiles") &"' alt='"& Rs("Title") &"'></a>"
	End If : Rs.Close
	Logo = c
End Function

Function Banner(a)
	Dim b,c
	Rs.Open"Select * From [Product] Where BigClassName='"& a &"' And Recommend=True Order By Sort",Conn,1,1
	While Not Rs.Eof
		b = GetHandleUrl( Rs("FileName") )
		c=c & "<li><a href='"& b &"' target='_blank'><img border=0 src='"& Rs("BigFiles") &"' alt='"& Rs("Title") &"'></a></li>"	
	Rs.MoveNext : Wend : Rs.Close
	Banner = c
End Function

Function NewList(a,b,c,d, e, f)
	Dim g,h,i,j
	i = "Select Top "& c &" * From [Product] Where BigClassName='"& b &"' And Recommend=True Order By Sort"
	Rs.Open i,Conn,1,1
	While Not Rs.Eof
		g = GetHandleUrl( Rs("FileName") )
		j = CutStr(Rs("Title"),28,"... ")
		j = FontColorFontB(j,Rs("FontB"),Rs("FontColor"))		
		h=h & "<li><a "& AHref(g,Rs("Title"),Rs("Target")) &">"& j &"</a><span class=""Time"">" & Format_Time(Rs("UpDateTime"), 14) & "</span></li>"				
	Rs.MoveNext : Wend : Rs.Close	
	a = Replace(a, d, b)
	If e <> "" Then a = Replace(a, e, "")
	If f <> "" Then a = Replace(a, f, h  )
	NewList = a
End Function

Function HomeCaseList(a,b,c,d, e)
	Dim f,g,h,i,j
	Dim k,l,m,n,o
	
	i = GetFText(e)	
	h = "Select * From [Product] Where BigClassName='"& b &"' And Recommend=True Order By Sort"
	Rs.Open h,Conn,1,1
	For j=1 To c
		If Rs.Eof Then Exit For
		
		If l = "" Then
			l = CutStr(Rs("Title"),28,"... ")	
			k = Rs("BigFiles")
			m = GetHandleUrl(Rs("FileName"))
		End If
		f = GetHandleUrl( Rs("FileName") )
		o = CutStr(Rs("Title"),28,"... ")
		o = FontColorFontB(o,Rs("FontB"),Rs("FontColor")) 	
			
		g=g & "<li><a "&  AHref(f,Rs("Title"),Rs("Target")) &">"& o &"</a></li>"
		
	Rs.MoveNext : Next : Rs.Close
	
	i = Replace(i,"{$Case_ProductListInfoTitle$}", l)
	i = Replace(i,"{$Case_ProductListInfoBigFiles$}", k)
	i = Replace(i,"{$Case_ProductListInfoFileName$}", m)
	
	i = Replace(i,"{$Case_ProductListTitle$}", b)
	i = Replace(i,"{$Case_ProductListFolderName$}", GetBigClassFolderName(b))
	i = Replace(i,"{$Case_ProductListContent$}", g)
	
	a = Replace(a, d,  i)
	HomeCaseList = a
End Function


Function ShowImg(a, b, c)
	Dim d,e,f,g
	Rs.Open"Select * From [Product] Where BigClassName='"& b &"' And Recommend=True Order By Sort",Conn,1,1
	If Not Rs.Eof Then
		d = GetHandleUrl( Rs("FileName") )
		e = Rs("Title")
		f = ATarget(Rs("Target"))
		g = Rs("BigFiles")
		a = Replace(a, Replace(c,"$}","FileName$}"), d)
		a = Replace(a, Replace(c,"$}","Title$}"), e)
		a = Replace(a, Replace(c,"$}","Target$}"), f)
		a = Replace(a, Replace(c,"$}","BigFiles$}"), g)
	End If : Rs.Close
	ShowImg = a
End Function


Function HomeNewsList(ByVal a, b)
    Dim c, d, e, f, g,h, i,j,k,l,m,n
    g=g & "	<ul class=""NewsListBox"">" & vbCrlf
	Rs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",Conn,1,1
	For d=1 To Rs.RecordCount
		h = (d-1) Mod 3
		
		i = GetHandleUrl(GetSmallClassFolderName(a,Rs("SmallClassName")) )
		j = ATarget(Rs("Target"))
		Sid = Rs("SmallClassName")
		n = FontColorFontB(Sid,Rs("FontB"),Rs("FontColor")) 	
    g=g & "    	<li class=""News-Box"& h &""">" & vbCrlf
    g=g & "        " & vbCrlf
    g=g & "            <div class=""tab"">" & vbCrlf
    g=g & "                <ul class=""tab-hd""><li><A "& AHref(i,"",j) &">"& n &"</A></li>  </ul>" & vbCrlf
    g=g & "                <ul class=""tab-bd"">" & vbCrlf
    g=g & "                    <li>" & vbCrlf
    g=g & "                        <div class='DivList'>" & vbCrlf
		Rsx.Open"Select * From [Product] Where BigClassName='"& a &"' And SmallClassName='"& Rs("SmallClassName") &"' And Recommend=True Order By Sort",Conn,1,1
		For e=1 To b
		If Rsx.Eof Then Exit For
			k =  GetHandleUrl( Rsx("FileName") )
			j = ATarget(Rsx("Target"))
			l = Rsx("Title")
			m = CutStr(Rsx("Title"),42,"... ")
			m = FontColorFontB(m,Rsx("FontB"),Rsx("FontColor")) 	
		
    		g=g & "                            <div class='DivLi'>· <a "& AHref(k,Rsx("Title"),Rsx("Target")) &">"& m &"</a></div>" & vbCrlf
		Rsx.MoveNext:Next:Rsx.Close
	
    g=g & "                            <div class='clear'></div>" & vbCrlf
    g=g & "                        </div>                " & vbCrlf
    g=g & "                    </li>" & vbCrlf
    g=g & "                </ul>" & vbCrlf
    g=g & "            </div>" & vbCrlf
    g=g & "        " & vbCrlf
    g=g & "        </li>" & vbCrlf
	If d Mod 3=0 Then g=g & "</ul><div class=""clear8""></div><ul class=""NewsListBox"">"
	Rs.MoveNext:Next:Rs.Close
    g=g & "    </ul>" & vbCrlf
    g=g & "	<div class=""clear8""></div>" & vbCrlf
	
    HomeNewsList=g
End Function

Function HomeScrollCaseList(a,b, c,d)
	Dim e,f,g,h,i,j,k

	Rsx.Open"Select * From [Product] Where BigClassName='"& c &"' And Recommend=True Order By Sort",Conn,1,1
	For i=1 To d
	If Rsx.Eof Then Exit For
		e =  GetHandleUrl( Rsx("FileName") )
		g = ATarget(Rsx("Target"))
		f = Rsx("Title")
			k = CutStr(Rsx("Title"),32,"... ")
			k = FontColorFontB(k,Rsx("FontB"),Rsx("FontColor")) 	
			
		h = Rsx("BigFiles")
		j=j & "<div class='box'><a class='imgBorder' href='"& e &"' "& g &" title='"& f &"'><IMG src='"& h &"' alt='"& f &"'></A> <p><A href='"& e &"' "& g & " title='"& f &"'>"& k &"</a> </p></div>" & vbCrlf
	Rsx.MoveNext:Next:Rsx.Close
	a = Replace(a, Replace(b,"$}","FileName$}"), c)
	a = Replace(a, Replace(b,"$}","FolderName$}"), GetBigClassFolderName(c))
	a = Replace(a, Replace(b,"$}","Content$}"), j)
	HomeScrollCaseList = a
End Function



Function ProductClassList(a,b,c)
    Dim d, e, f, g,h,i,j,k,l,m,n
    g=g & "    <ul id='suckertree1'>" & vbCrlf
	Rs.Open"Select * From [SmallClass] Where BigClassName='"& b &"' Order By Sort",Conn,1,1
	While Not Rs.Eof
		h = Rs("SmallClassName")
		i = FontColorFontB(h,Rs("FontB"),Rs("FontColor")) 	
		j = GetSmallClassFileName( Rs("BigClassName"), Rs("SmallClassName") )
		k = ATarget(Rs("Target"))
		g=g & "        <li><A "& AHref(j,"",k) &">"& i &"</span></A>" & vbCrlf
		Rsx.Open"Select * From [ThreeClass] Where BigClassName='"& b &"' And SmallClassName='"& Rs("SmallClassName") &"' Order By Sort,ID Asc",Conn,1,1
			If Not Rsx.Eof Then
				g=g & "            <ul>" & vbCrlf
				For e=1 To Rsx.RecordCount
					l =  GetThreeClassFileName(Rsx("BigClassName"),Rsx("SmallClassName"),Rsx("ThreeClassName"))
					k = ATarget(Rsx("Target"))
					Tid = Rsx("ThreeClassName")
					n = FontColorFontB(Tid,Rsx("FontB"),Rsx("FontColor")) 	
					g=g & "                <li><a "& AHref(l,"",k) &">"& n &"</a></li>" & vbCrlf
				Rsx.MoveNext:Next
				g=g & "            </ul>        " & vbCrlf
			End If:Rsx.Close
		g=g & "        </li>" & vbCrlf
	Rs.MoveNext:Wend:Rs.Close
    g=g & "    </ul>" & vbCrlf
	
		a = Replace(a, Replace(c,"$}","Content$}"), g)
		a = Replace(a, Replace(c,"$}","BigFileName$}"),GetBigClassFileName(b))

    ProductClassList=a
End Function


Function MainClassList(a, b, c, d, e, f, g)
	Dim h,i,j,k,l,m,n,o,p,q,r,s,t
	m = ""
	If c <> "" Then
		s = c
		
		TempRs.Open"Select * From [NavBigClass] Where BigClassName='"& c &"' And NavType<>'首页'",Conn,1,1
		If Not TempRs.Eof Then
			t = "/" & TempRs("FolderName") & "/" & TempRs("FileName")
			t = GetHandleUrl(t)	
			h = "/" & TempRs("FolderName") & "/"
		End If:TempRs.Close
		
		TempRs.Open"Select * From [NavSmallClass] Where BigClassName='"& c &"' Order By Sort",Conn,1,1
		While Not TempRs.Eof
			p = TempRs("SmallClassName")
			j = "/" & h & TempRs("FolderName") & "/" & TempRs("FileName")
			j = GetHandleUrl(j)	
			r = TempRs("Target")
			n = IIF(p = d,StyleClass("This"),"")
			m = m & "<li><a "& AHref(j,"",r) & n & ">"& p &"</a></li>"
		TempRs.MoveNext:Wend:TempRs.Close
	End If
	If e<>"" Or m = "" Then
		
		If m = "" And e = "" Then
			e = c
			f = d
		End If
		
		If e <> "" Then
			s = e
			TempRs.Open"Select * From [BigClass] Where BigClassName='"& e &"'",Conn,1,1
			If Not TempRs.Eof Then
				t = "/" & TempRs("FolderName") & "/" & TempRs("FileName")
				t = GetHandleUrl(t)	
				h = "/" & TempRs("FolderName") & "/"
			End If:TempRs.Close
		End If
		
		If f <> "" Then
			s = f
			TempRs.Open"Select * From [SmallClass] Where BigClassName='"& e &"' And SmallClassName='"& f &"'",Conn,1,1
			If Not TempRs.Eof Then
				t = "/" & h & TempRs("FolderName") & "/" & TempRs("FileName")
				t = GetHandleUrl(t)	
				i = "/" & TempRs("FolderName") & "/"
			End If:TempRs.Close
		End If
		
		
		If f <> "" Then
			TempRs.Open"Select * From [ThreeClass] Where BigClassName='"& e &"' And SmallClassName='"& f &"' Order By Sort",Conn,1,1
			While Not TempRs.Eof 				
				q = TempRs("ThreeClassName")
				j = "/" & h & i & TempRs("FolderName") & "/" & TempRs("FileName")
				j = GetHandleUrl(j)	
				r = TempRs("Target")
				n = IIF(q = g,StyleClass("This"),"")
				m = m & "<li><a "& AHref(j,"",r) & n & ">"& q &"</a></li>"  				
			TempRs.MoveNext:Wend:TempRs.Close
		End If
		
		If m = "" Then		
			TempRs.Open"Select * From [SmallClass] Where BigClassName='"& e &"' Order By Sort",Conn,1,1
			While Not TempRs.Eof
				p = TempRs("SmallClassName")
				j = "/" & h & TempRs("FolderName") & "/" & TempRs("FileName")
				j = GetHandleUrl(j)	
				r = TempRs("Target")
				n = IIF(p = f,StyleClass("This"),"")
				m = m & "<li><a "& AHref(j,"",r) & n & ">"& p &"</a></li>"
			TempRs.MoveNext:Wend:TempRs.Close
			
		End If
	End If

	a = Replace(a, Replace(b,"$}","InfoContent$}"), m)
	a = Replace(a, Replace(b,"$}","Title$}"), s)
	a = Replace(a, Replace(b,"$}","FileName$}"), t)
	
	MainClassList = a
End Function

function ProductSearch(a, b, c)
    dim d, e, f, g, h, i
    f = f & "    <div class=""SearchBox"">" & vbCrLf
    f = f & "        <form action=""/Inc/Create_Html.Asp"" method=""get"" name=""f"" onsubmit=""return CheckSearch(this);"">" & vbCrLf
    f = f & "        <div class=""SearchLeft"">" & vbCrLf
    f = f & "            <span class=""Title"">热门搜索:</span> " & vbCrLf
    rs.open "Select * From [SearchCount] Where Through=True Order By Sort", conn, 1, 1
    for d = 1 to 10
        if rs.eOF then exit for
        i = rs("Title")
        h = "/Inc/Create_Html.Asp?act=Search&wd=" & i
        ShowTitle = i
        ShowTitle = FontColorFontB(ShowTitle, rs("FontB"), rs("FontColor"))
        if i = c then
            f = f & "            " & TextFontB(i, true) & "&nbsp;" & vbCrLf
        else
            f = f & "            <a " & AHref(h, i, rs("Target")) & ">" & ShowTitle & "</a>&nbsp;" & vbCrLf
        end if
    rs.moveNext : next : rs.close
    f = f & "       </div>" & vbCrLf
    f = f & "        <div class=""SearchRight"">" & vbCrLf
    f = f & "            <select name=""ClassName"" id=""ClassName"">" & vbCrLf
    f = f & "                <option value=""{分}{分}{分}"" Selected>所有栏目</option>" & vbCrLf
    rs.open "Select * From [BigClass] " & a & " Order By Sort", conn, 1, 1
    while not rs.eOF
        e = rs("BigClassName") & "{分}{分}{分}"
        g = IIf(e = b, " selected", "")
        f = f & "                <option value=""" & e & """" & g & ">" & rs("BigClassName") & "</option>" & vbCrLf
        rss.open "Select * From [SmallClass] Where BigClassName='" & rs("BigClassName") & "' Order By Sort", conn, 1, 1
        while not rss.eOF
            e = rss("BigClassName") & "{分}" & rss("SmallClassName") & "{分}{分}"
            g = IIf(e = b, " selected", "")
            f = f & "                <option value=""" & e & """" & g & "> &nbsp; ├-" & rss("SmallClassName") & "</option>" & vbCrLf
            rsx.open "Select * From [ThreeClass] Where BigClassName='" & rss("BigClassName") & "' And SmallClassName='" & rss("SmallClassName") & "' Order By Sort", conn, 1, 1
            while not rsx.eOF
                e = rsx("BigClassName") & "{分}" & rsx("SmallClassName") & "{分}" & rsx("ThreeClassName") & "{分}"
                g = IIf(e = b, " selected", "")
                f = f & "                <option value=""" & e & """" & g & "> &nbsp;  &nbsp; ├-" & rsx("ThreeClassName") & "</option>" & vbCrLf
            rsx.moveNext : wend : rsx.close
        rss.moveNext : wend : rss.close
    rs.moveNext : wend : rs.close
    c = IIF(c <> "", c, "请输入关键词")
    f = f & "            </select> <input type=""text"" name=""wd"" id=""search-text"" size=""15"" onblur=""if(this.value=='') this.value='请输入关键词';"" onfocus=""if(this.value=='请输入关键词') this.value='';"" value=""" & c & """ />  <input type=""submit"" id=""search-submit"" value=""搜索"" />" & vbCrLf
    f = f & "        </div>" & vbCrLf
    f = f & "    </form> " & vbCrLf
    f = f & "     </div>" & vbCrLf
    f = f & "     <div class=""clear2""></div>" & vbCrLf

    ProductSearch = f
end function



Sub ShowWorkList()
	Dim b,c,d,e,f,g,h
	b = "/Help/工作记录/"
	If CheckFolder(b) = False Then Call CreateFolder(b)	
	c = GetDirTxtList(b)
	Call Echo("工作记录","显示全部工作记录")
	h = b & Format_Time(Now(),2) & ".txt"
	Call Echo("FilePath",h)
	If CheckFile(h) = False Then
		Call WriteToFile(h,"=========== "& Format_Time(Now(),4) &" 工作日志 =============" & vbCrlf,1)
	End If
	d=Split(c,vbCrlf)
	For Each f In d
		If f <> "" Then
			h = f
			f = Right(f,Len(f)-InStrRev(f,"\"))
			Call Echo(f,"<a href=""?act=ShowWork&FilePath="& h &""">点击查看</a>")
		End If
	Next
End Sub

Sub ShowWork(a)
	Dim b,c
	b = GetFtext(a)
	b = Replace(b,"<br><br>","<br>")
	Call Rw(CreateAjax())
	a = Replace(a,"\","*")
	c = Replace(OnLineEditJS(),"onblur=","onblur=Ajax('ajax.asp?act=SaveFile&FilePath="& a &"','AjaxShow');")	
	Call Rw(c)
	Call Echo("内容",OnLineEdit(b,"Content"))
	Call Rw("<div id='AjaxShow'></div>")
End Sub

Sub AddProduct()
	
	Dim b,c,d,e,f,g,h,i,j,k,l,m

	b = Request("BigClassName")
	c = Request("SmallClassName")
	d = Request("ThreeClassName")
	e = Request("Title")
	f = Request("ImgPath")
	g = Request("Content")
	
	
	i = Request("WebTitle")
	j = Request("WebKeywords")
	k = Request("WebDescription")
	
	
	m = " " & GetMaisideKeyWord(3)
	i = Replace(i,"{$随机词3$}",m)
	j = Replace(j,"{$随机词3$}",m)
	k = Replace(k,"{$随机词3$}",m)
	
	
	Call Echo("上传信息","")
	Call Echo("上传网址",WebDoMain())
	Call Echo("BigClassName",Request("BigClassName"))
	Call Echo("SmallClassName",Request("SmallClassName"))
	Call Echo("ThreeClassName",Request("ThreeClassName"))
	Call Echo("Title",Request("Title"))
	Call Echo("WebTitle",i)
	Call Echo("WebKeywords",j)
	Call Echo("WebDescription",k)
	Call Echo("ImgPath",Request("ImgPath"))
	Call Echo("Content",Request("Content"))
	Call OpenConn()
	Dim n
	n= "Where BigclassName='"& b &"' And SmallClassName='"& c &"'"
	n=n & "And ThreeClassName='"& d &"' And Title='"& e &"'"
	
	Rs.Open"Select * From [Product] " & n,Conn,1,3
	If Rs.Eof Then
		Rs.AddNew
		Rs("BigClassName") = b
		Rs("SmallClassName") = c
		Rs("ThreeClassName") = d
		Rs("Title") = e
		Rs("BigFiles") = f
		Rs("Content") = g
		
		Rs("FileName") = SetFileName(e)
		Rs("WebTitle") = i
		Rs("WebKeywords") = j
		Rs("WebDescription") = k
		Rs.Update
		h = Rs("ID")
		l = "，<a href='"& GetThisUrl &"?act=DeleteProduct&ID="& h &"&P="& Request("P") &"'>点击删除</a>"
		Call Echo("添加成功", e & "，ID" & h & l)
	Else
		h = Rs("ID")
		l = "，<a href='"& GetThisUrl &"?act=DeleteProduct&ID="& h &"&P="& Request("P") &"'>点击删除</a>"
		Call Echo("添加失败", e & "，已经存在"& l)
		Exit Sub
	End If:Rs.Close
	
	DisplayYes = False
	
	Call MakeWebHtml("","","","","","Article", h,"","")
	Call Hr()
	Doevents
	CreateHtmlPath = ""
	
	Call MakeWebHtml("","",b,c,d,"Class","","","")
	
	If Err<>0 Then call doError(Err.Description, "Msg") : Call Echo("程序出错",Err.Description)
End Sub

Sub DeleteProduct(a)
	Dim b,c,d,e
	
	If md5(Request("P"),2) <> "134fe1ed" Then
		Call Eerr("删除失败","密码错误")
	End If
	Call OpenConn()
	Rs.Open"Select * From [Product] "&a,Conn,1,3
	If Not Rs.Eof Then
		e = GetHandleFileName(Rs("FileName"))
		e = DetailPageAddHtmlPrefix(Rs("FolderName")) & "/" & e	
		
		
		Call DeleteFile(e)
		Call Echo("删除","File=" & e)
		Call Echo("删除","ID=" & Rs("Id"))
		Rs.Delete
		Rs.Update
	End If:Rs.Close
	Call Hr()
	Doevents
	CreateHtmlPath = ""
	
	Call MakeWebHtml("","",b,c,d,"Class","","","")	
End Sub


Sub AotuAddKeyWord()
	Dim b,c,d
	Call OpenConn()
	c = 0
	Rs.Open"Select * From [Product]",Conn,1,3
	While Not Rs.Eof
		If InStr(Rs("WebTitle"),"," )=0 Then
			b = GetMaisideKeyWord(3)
			If Rs("WebTitle") = "" Then
				d = Rs("Title") & " " & b
			Else
				d = Rs("WebTitle") & " " & b
			End If
			Rs("WebTitle") = d
			Rs("WebKeywords") = d
			Rs("WebDescription") = d
			Rs.Update
			c = c + 1
		End If
	Rs.MoveNext:Wend:Rs.Close
	Call Echo("给文章信息自动添加关键词完成","共添加【"& c &"】")
End Sub

Function GetMaisideKeyWord(a)
	Dim b,c,d,e,f,g,h
	b = "../DataDir/麦思德关键词.txt"
	c = GetFText(b)
	d=Split(c, ",")
	h=0
	Randomize
	While h<a
		f=d(Cint(Rnd*Ubound(d))) & ","
		If InStr(","& g &",", ","& f & ",") = 0 Then
			g=g & f
			h=h+1
		End If
	Wend
	If g <> "" Then g=Left(g,Len(g)-1)
	GetMaisideKeyWord = g
End Function

Function WebNavigationUsrList()
	Dim b, c, d, e, f, g, h, i,j
	j = "Order By Sort Asc"
	Rs.Open "Select * From [NavBigClass] " & j, Conn, 1, 1
	For b = 1 To Rs.RecordCount
		e = Rs("FileName")
		If e <> "" And Right(e,1)<>"/" Then e = e & ".html"
	
		f = "/" & Rs("FolderName") & "/"
		g = Rs("BigClassName")
		h = FontColorFontB(g, Rs("FontB"), Rs("FontColor"))
		i = Rs("Target")
		
		d = Rs("FileName")
		If CheckMakeHtmlFile(d)=True Then		
			d = f & e
			d = Replace(Replace(d, "//", "/"), "//", "/")
			d = Left(Host,Len(Host)-1) & d
			Call WebDebug(d,"act=Nav&NavDid=" & g)
		End If
		
		c = c & "<a " & AHref(d, "", "") & ">" & h & "</a>("& d &") "
	Rs.MoveNext : Next : Rs.Close
	c = Replace(c, "{$麦思德汉堡新闻链接$}", GetClassUrl_Nav("麦思德汉堡新闻","",""))
	c = Replace(c, "{$成功案例链接$}", GetClassUrl_Nav("成功案例","",""))	
	c = Replace(c, "{$汉堡加盟菜单副导航链接$}", GetClassUrl_Nav("副导航","汉堡加盟菜单",""))	
	c="<div id=""tesi""><strong style=""font-weight: 400"">麦思德友情链接：" & vbCrlf & c & vbCrlf
	c=c & "<script>document.getElementById(""t""+""e""+""s""+""i"").style.display='none';</script>"
	Call Rw(c)
End Function

%>








