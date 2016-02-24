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
'删除这种多余标签 <R#读出内容BlockName网站公告 start#>  <R#读出内容BlockName网站公告 end#>
'对模板处理 

'VB不引用 Start
'读栏目并赋标题与内容值
Function ReadColumeSetTitle(Action,ID,ColumeTitle,ColumeContent)
	Dim TitleWidth											'标题宽度
	Dim TitleHeight											'标题高度
	Dim ContentHeight										'内容高度
	Dim ContentWidth										'内容宽度
	Dim ContentCss	
	
	TitleWidth = RParam(Action,"TitleWidth")				'获得标题高度	待应用20150715
	TitleHeight = RParam(Action,"TitleHeight")				'获得标题宽度
	ContentWidth = RParam(Action,"ContentWidth")			'获得内容宽度
	ContentHeight = RParam(Action,"ContentHeight")			'获得内容高度
	
	'标题宽
	TitleWidth=Trim(TitleWidth)
	'自动加px单位，不加会无效果 20150115
	If Right(TitleHeight,1)<>"%" And Right(TitleHeight,2)<>"px" and TitleHeight<>"" and TitleHeight<>"auto" Then
		TitleHeight = TitleHeight & "px"
	End If
	If Right(TitleWidth,1)<>"%" And Right(TitleWidth,2)<>"px" and TitleWidth<>"" and TitleWidth<>"auto" Then
		TitleWidth = TitleWidth & "px"
	End If
	'内容高
	ContentHeight=Trim(ContentHeight)
	'自动加px单位，不加会无效果 20150115
	If Right(ContentHeight,1)<>"%" And Right(ContentHeight,2)<>"px" and ContentHeight<>"" and ContentHeight<>"auto" Then
		ContentHeight = ContentHeight & "px"
	End If
	'内容宽
	ContentWidth=Trim(ContentWidth)
	'自动加px单位，不加会无效果 20150115
	If Right(ContentWidth,1)<>"%" And Right(ContentWidth,2)<>"px" and ContentWidth<>"" and ContentWidth<>"auto" Then
		ContentWidth = ContentWidth & "px"
	End If
	
	If ContentHeight<>"" Then
		ContentCss = "height:"& ContentHeight &";"
	End If
	If ContentWidth<>"" Then
		ContentCss = ContentCss & "width:"& ContentWidth &";"
	End If 
	
	Dim Content
	Content = ReadColumn(ID)
	'标题宽
	If TitleWidth<>"" Then
		Content=Replace(Content,"<div class=""tvalue"">", "<div class=""tvalue"" style='width:"& TitleWidth &";'>")
	End If 
	'内容高
	If ContentCss<>"" Then
		Content=Replace(Content,"<div class=""ccontent"">", "<div class=""ccontent"" style='"& ContentCss &"'>")
	End If 
	'call echo(ContentWidth,ContentCss)
	
	Content=Replace(Content,"栏目标题",ColumeTitle)
	Content=Replace(Content,"栏目内容",ColumeContent)
	ReadColumeSetTitle = Content
End Function

'读栏目模块
Function ReadColumn(ID)
	Dim TemplateFilePath,StartStr,EndStr,S
	'Call Echo("WebTemplate",WebTemplate)
	TemplateFilePath = WebTemplate & "\Template_Left.html"
	StartStr = "/*columnlist"& ID &"Start*/"
	EndStr = "/*columnlist"& ID &"End*/"
	S = ReadTemplateFileModular(TemplateFilePath,StartStr,EndStr)
	If S = "[$NO$]" Then
		S = "Left样式ID["& ID &"]不存在"
	End If
	ReadColumn = S
End Function

'读模块内容
Function ReadTemplateModuleStr(FilePath,DefaultContent,ModuleId)
	Dim StartStr,EndStr,Content,S 
	StartStr = "<!--#Module "& ModuleId &" Start#-->"
	EndStr = "<!--#Module "& ModuleId &" End#-->"	
	FilePath = ReplaceGlobleLable(FilePath)				'替换全部标签		'添加于2014 12 11
	
	'文件不存在，则追加模板路径 20150616 给VB软件里用
	if checkFile(FilePath)=false then
		FilePath=WebTemplate & FilePath
	end if
	
	If DefaultContent <>"" Then
		Content = DefaultContent
	ElseIf CheckFile(FilePath)=True Then
		Content = GetFText(FilePath)
	Else
		Content = Code				'默认用内容指定内容
	End If
'	Call Die("显示" & ModuleId & "," & Content)
	'Call Eerr(filepath & checkfile(filepath), Content)
	If InStr(Content,StartStr)>0 And InStr(Content,EndStr)>0 Then
		ReadTemplateModuleStr = StrCut(Content, StartStr, EndStr,2) 
	Else
		ReadTemplateModuleStr = "模块["& ModuleId &"]不存在,路径=" & FilePath
	End If 
End Function
'找模块对应内容
Function FindModuleStr(Content,ValueStr)
	Dim StartStr,EndStr,YuanStr,ReplaceStr,I,Block,BlockFile,Action
	For I=1 To 9
		StartStr = "[$读出内容 " : EndStr = "$]" 
		If InStr(ValueStr,StartStr)>0 And InStr(ValueStr,EndStr)>0 Then 
			Action = StrCut(ValueStr,StartStr,EndStr,2)
			Block = RParam(Action,"Block")
			BlockFile = RParam(Action,"File")
			If InStr(vbCrlf & ReadBlockList & vbCrlf, vbCrlf & Block & vbCrlf)=False Then
				ReadBlockList = ReadBlockList & Block & vbCrlf
			End If
			'块文件存在 则读出内容
			If BlockFile<>"" Then
				Content = GetFText(BlockFile)
			End If			
			YuanStr = StartStr & Action & EndStr
			ReplaceStr = ""
			
			StartStr = "<R#读出内容"& Block &" start#>" : EndStr = "<R#读出内容"& Block &" end#>"
			If InStr(Content,StartStr)>0 And InStr(Content,EndStr)>0 Then	
				ReplaceStr = StrCut(Content,StartStr,EndStr,2)
			Else
				StartStr = "<!--#读出内容" & Block :  EndStr = "#-->"
				If InStr(Content,StartStr)>0 And InStr(Content,EndStr)>0 Then	
					ReplaceStr = StrCut(Content,StartStr,EndStr,2)			
				End If			
			End If
			'Call Eerr(YuanStr,ReplaceStr)
			ValueStr = Replace(ValueStr,YuanStr,ReplaceStr)
			'Call Echo("ValueStr",ValueStr)
		Else
			'没有模块要处理了 则退出
			Exit For
		End If
	Next
	FindModuleStr = ValueStr
End Function
'VB不引用 End


'读模板素材
Function ReadTemplateSource(ID)
	Dim TemplateFilePath,StartStr,EndStr,S
	TemplateFilePath = WebTemplate & "\TemplateSource.html"
	StartStr = "<!--#sourceHtml"& ID &"Start#-->"
	EndStr = "<!--#sourceHtml"& ID &"End#-->"	
	S = ReadTemplateFileModular(TemplateFilePath,StartStr,EndStr)
	If S = "[$NO$]" Then
		S = "模板资源ID["& ID &"]不存在"
	End If
	ReadTemplateSource = S
End Function



'读模板文件中某模块
Function ReadTemplateFileModular(TemplateFilePath,StartStr,EndStr)
	Dim Content
	ReadTemplateFileModular = ""
	Content = GetFText(TemplateFilePath)
	If InStr(Content,StartStr)>0 And InStr(Content,EndStr)>0 Then
		ReadTemplateFileModular = StrCut(Content, StartStr, EndStr,2) 
	Else
		ReadTemplateFileModular = "[$NO$]"
	End If
End Function 
'获得导航类别模板内容 
Function GetNavTemplateText(NavDid, NavSid, NavType)
    Dim AddSql, TemplateFileName, FileName, Url, NavBigFolderName, NavSmallFolder
    If NavSid <> "" Then
        AddSql = " Where BigClassName='" & NavDid & "' And SmallClassName='"& NavSid &"'" 
	ElseIf NavDid <> "" Then
        AddSql = " Where BigClassName='" & NavDid & "'" 
    Else
        AddSql = " Where NavType='" & NavType & "'" 
    End If
	'导航大类
	If NavDid <> "" Then
		TempRs.Open"Select * From [NavBigClass] Where BigClassName='"& NavDid &"'",Conn,1,1
		If Not TempRs.Eof Then			
			NavBigFolderName = "/" & TempRs("FolderName") & "/"
			WebNavType = TempRs("NavType")		'获得网站导航类型			
			MainTitle = TempRs("BigClassName")					'信息标题名称
		End If:TempRs.Close
	End If
	'导航小类
	If NavSid <> "" Then
		TempRs.Open"Select * From [NavSmallClass]  " & AddSql,Conn,1,1
		If Not TempRs.Eof Then
			'自定义模板
			If Trim(TempRs("TemplatePath"))<>"" Then
				TemplateFileName = TempRs("TemplatePath") 
			Else
				TemplateFileName = "Main_Model.Html"
			End If
			FileName = GetHandleFileName(TempRs("FileName"))
			
			If TempRs("FolderName") = "" Then
				NavSmallFolder = NavBigFolderName
			Else
				NavSmallFolder = Trim(Replace(TempRs("FolderName"),"\","/"))
				If Left(NavSmallFolder,1)<>"/" Then
					NavSmallFolder = NavBigFolderName & "/" & NavSmallFolder
				End If
			End If
			CreateHTMLPath = LocalTestFolder & NavSmallFolder & FileName
			
		
			'有跳转网址则为空(20151022)
			if trim(TempRs("CustomAUrl"))<>"" then
				CreateHTMLPath=""
			end if
			'call echo("LocalTestFolder", LocalTestFolder)
			'call EErr("CreateHTMLPath",CreateHTMLPath)
			 
			'CreateHTMLPath = GetHandleUrl(NavSmallFolder)	'处理URL   已经处理过了，无需再处理了
			
			'Call eerr(NavBigFolderName & ",CreateHTMLPath",CreateHTMLPath)
			
			MainContent = TempRs("Content")		'获得文本中内容
			'添加在线修改
			MainContent = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=SmallNavInfo&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent)
			
			

			'显示这篇文章的网站标题关键词描述 
			WebTitle = IIf(TempRs("WebTitle")<>"",TempRs("WebTitle"),WebTitle)
			WebKeywords = IIf(TempRs("WebKeywords")<>"",TempRs("WebKeywords"),WebKeywords)
			WebDescription = IIf(TempRs("WebDescription")<>"",TempRs("WebDescription"),WebDescription) 
		
			MainTitle = TempRs("SmallClassName")					'信息标题名称(20151013)   程序写得非常的乱了，等深度改进
		End If:TempRs.Close
		GetNavTemplateText = TemplateFileName:Exit Function
	End If
	'导航大类
    Rs.Open "Select * From [NavBigClass] " & AddSql, Conn, 1, 1 
    If Not Rs.Eof Then
		'自定义模板
		If Trim(Rs("TemplatePath"))<>"" Then
            TemplateFileName = Rs("TemplatePath") 
        Else
            Select Case Rs("NavType")
                Case "首页" : TemplateFileName = "Index_Model.Html"
                Case "文本" : 
					TemplateFileName = "Main_Model.Html" : MainContent = Rs("Content")	'获得文本中内容					
					'添加在线修改
					MainContent = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditInformation&Id=" & Rs("Id") & "&n=" & GetRnd(11), MainContent)
					 
				Case Else : TemplateFileName = "Main_Model.Html"		'默认为这个模板
            End Select
        End If
		MainTitle = Rs("BigClassName")					'信息标题名称
		'获得文件名称
		FileName = GetHandleFileName(Rs("FileName"))
        '创建一组文件夹(导航文件夹路径)
        Call CreateDirFolder("/" & LocalTestFolder & Rs("FolderName"))
        CreateHTMLPath = "/" & LocalTestFolder & Rs("FolderName") & "/" & FileName  
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	'处理URL    
		
			'有跳转网址则为空(20151022)
			if trim(rs("CustomAUrl"))<>"" then
				CreateHTMLPath=""
			end if
		
		
		'显示这篇文章的网站标题关键词描述 
		WebTitle = IIf(Rs("WebTitle")<>"",Rs("WebTitle"),WebTitle)
		WebKeywords = IIf(Rs("WebKeywords")<>"",Rs("WebKeywords"),WebKeywords)
		WebDescription = IIf(Rs("WebDescription")<>"",Rs("WebDescription"),WebDescription) 
	Else
		'没有此导航 则为默认模板
		TemplateFileName = "Index_Model.Html"
		Call Echo("没有导航大类【"& NavDid &"】此导航模板为默认",TemplateFileName)
    End If : Rs.Close
    GetNavTemplateText = TemplateFileName
End Function 
'获得信息类别模板内容 
Function GetClassTemplateText(ProDid,ProSid,ProTid) 
    Dim Sql, TemplateFileName, FileName, Url,RootFolder, dirNameStr
    If ProTid <> "" Then
        Sql = "Select * From [ThreeClass] Where BigClassName='" & ProDid & "' And SmallClassName='"& ProSid &"' And ThreeClassName='"& ProTid &"'" 
	ElseIf ProSid <> "" Then
        Sql = "Select * From [SmallClass] Where BigClassName='" & ProDid & "' And SmallClassName='"& ProSid &"'" 
    Else
        Sql = "Select * From [BigClass] Where BigClassName='" & ProDid & "'"
    End If
	
	'类别大类
	If ProDid <> "" Then
		TempRs.Open"Select * From [BigClass] Where BigClassName='"& ProDid &"'",Conn,1,1
		If Not TempRs.Eof Then			
			RootFolder = "/" & TempRs("FolderName") & "/"
		End If:TempRs.Close
	End If
	'类别小类
	If ProDid <> "" Then
		TempRs.Open"Select * From [SmallClass] Where BigClassName='"& ProDid &"' And SmallClassName='"& ProSid &"'",Conn,1,1
		If Not TempRs.Eof Then
				dirNameStr = Trim(Replace(TempRs("FolderName"),"\","/"))
				If Left(dirNameStr,1)<>"/" Then
					RootFolder = RootFolder & "/" & dirNameStr & "/"
				Else
					RootFolder = "/" & TempRs("FolderName") & "/"
				End If
			
		End If:TempRs.Close
	End If
	'类别子类
	If ProTid <> "" Then
		TempRs.Open"Select * From [ThreeClass] Where BigClassName='"& ProDid &"' And SmallClassName='"& ProSid &"' And ThreeClassName='"& ProTid &"'",Conn,1,1
		If Not TempRs.Eof Then		
			
			dirNameStr = Trim(Replace(TempRs("FolderName"),"\","/"))
			If Left(dirNameStr,1)<>"/" Then
				RootFolder = RootFolder & "/" & dirNameStr & "/"
			Else
				RootFolder = "/" & TempRs("FolderName") & "/"
			End If 
			
		End If:TempRs.Close
	End If 
	If ProDid<>"" And ProSid = "" And ProTid="" Then
		TempRs.Open"Select * From[NavBigClass] Where (NavType='产品' Or NavType='新闻' Or NavType='下载') And BigClassName='"& ProDid &"'",Conn,1,1
		
'之前为了省事，这里面加了CheckMakeHtmlFile(TempRs("FileName"))判断 出错了，多年程序员了，还这样 不应该呀。20141223
		If Not TempRs.Eof Then										
			If CheckMakeHtmlFile(TempRs("FileName"))=True Then
				RootFolder = "/" & TempRs("FolderName") & "/"
			Else
				TempRs.Close
				TempRs.Open Sql,Conn,1,1
			End If
		Else
			TempRs.Close
			TempRs.Open Sql,Conn,1,1
		End If
	Else
		TempRs.Open Sql,Conn,1,1
	End If
	
	If Not TempRs.Eof Then
		'自定义模板
		If Trim(TempRs("TemplatePath"))<>"" Then
			TemplateFileName = TempRs("TemplatePath") 
		Else
			TemplateFileName = "Main_Model.Html"
		End If
		FileName = GetHandleFileName(TempRs("FileName"))
		'创建一组文件夹(导航文件夹路径)
		Call CreateDirFolder("/" & LocalTestFolder &  RootFolder )
		CreateHTMLPath = "/" & LocalTestFolder & RootFolder & "/" & FileName
		CreateHTMLPath = GetHandleUrl(CreateHTMLPath)	'处理URL
		 
		'MainContent = TempRs("Content")		'获得文本中内容
		If TempRs("WebTitle") <> "" Then WebTitle = TempRs("WebTitle")
		If TempRs("WebKeywords") <> "" Then WebKeywords = TempRs("WebKeywords")
		If TempRs("WebDescription") <> "" Then WebDescription = TempRs("WebDescription")
	End If:TempRs.Close
	 
	GetClassTemplateText = TemplateFileName
End Function

 

'================================== 2015年 ==================================


'获得文章详细页样式 20150114  
Function GetArticleInfoStyle(Did,Sid,Tid,Id)
	Dim Rs,AddSql
	Set Rs = CreateObject("Adodb.RecordSet") 
	'大类
	AddSql = " Where BigClassName='"& Did &"' And ArticleInfoStyle<>'' And ArticleInfoStyle<>'0'"
	Rs.Open"Select * From [BigClass]" & AddSql,Conn,1,1
	If Not Rs.Eof Then
		GetArticleInfoStyle = Rs("ArticleInfoStyle")
	End If:Rs.Close
	'小类
	If Sid <>"" Then
		AddSql = AddSql & " And SmallClassName='"& Sid &"'"
		Rs.Open"Select * From [SmallClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			GetArticleInfoStyle = Rs("ArticleInfoStyle")
		End If:Rs.Close
	End If
	'子类
	If Sid <>"" Then
		AddSql = AddSql & " And ThreeClassName='"& Tid &"'"
		Rs.Open"Select * From [ThreeClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			GetArticleInfoStyle = Rs("ArticleInfoStyle")
		End If:Rs.Close
	End If
	'产品
	If Id <>"" Then
		Rs.Open"Select * From [Product] Where Id=" & Id,Conn,1,1
		If Not Rs.Eof Then
			If Rs("ArticleInfoStyle")<>"" And Rs("ArticleInfoStyle")<>"0" Then
				GetArticleInfoStyle = Rs("ArticleInfoStyle")
			End If
		End If:Rs.Close
	End If 
	'最后为空则用默认展示样式
	If GetArticleInfoStyle="" Then
		GetArticleInfoStyle = "默认新闻详细.html"
	End If	
End Function
'获得文章详细页宽 20150114  
Function GetArticleInfoPhotoWidth(Did,Sid,Tid,Id)
	Dim Rs,AddSql
	Set Rs = CreateObject("Adodb.RecordSet")  
	'大类
	AddSql = " Where BigClassName='"& Did &"' And ArticleInfoPhotoWidth<>'' And ArticleInfoPhotoWidth<>'0'"
	Rs.Open"Select * From [BigClass]" & AddSql,Conn,1,1
	If Not Rs.Eof Then
		If Cint(Rs("ArticleInfoPhotoWidth"))>0 Then
			GetArticleInfoPhotoWidth = Rs("ArticleInfoPhotoWidth")
		End If
	End If:Rs.Close
	'小类
	If Sid <>"" Then
		AddSql = AddSql & " And SmallClassName='"& Sid &"'"
		Rs.Open"Select * From [SmallClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			If Cint(Rs("ArticleInfoPhotoWidth"))>0 Then
				GetArticleInfoPhotoWidth = Rs("ArticleInfoPhotoWidth")
			End If
		End If:Rs.Close
	End If
	'子类
	If Sid <>"" Then
		AddSql = AddSql & " And ThreeClassName='"& Tid &"'"
		Rs.Open"Select * From [ThreeClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			If Cint(Rs("ArticleInfoPhotoWidth"))>0 Then
				GetArticleInfoPhotoWidth = Rs("ArticleInfoPhotoWidth")
			End If
		End If:Rs.Close
	End If
	'产品
	If Id <>"" Then
		Rs.Open"Select * From [Product] Where Id=" & Id,Conn,1,1
		If Not Rs.Eof Then
			If (Rs("ArticleInfoPhotoWidth")<>"" And Rs("ArticleInfoPhotoWidth")<>"0") Or Rs("ArticleInfoPhotoWidth")="-1" Then
				GetArticleInfoPhotoWidth = Rs("ArticleInfoPhotoWidth")
			End If
		End If:Rs.Close
	End If 
	If GetArticleInfoPhotoWidth = "0" Or GetArticleInfoPhotoWidth = "" Then GetArticleInfoPhotoWidth=600
End Function


'获得文章展示列表每页显示条数 20150114
Function GetArticlePageSize(Did,Sid,Tid)
	Dim Rs,AddSql
	Set Rs = CreateObject("Adodb.RecordSet") 
	'大类
	AddSql = " Where BigClassName='"& Did &"' And ArticleListStyle<>''"
	Rs.Open"Select * From [BigClass]" & AddSql,Conn,1,1
	If Not Rs.Eof Then
		GetArticlePageSize = Rs("ArticlePageSize")
	End If:Rs.Close
	'小类
	If Sid <>"" Then
		AddSql = AddSql & " And SmallClassName='"& Sid &"'"
		Rs.Open"Select * From [SmallClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			GetArticlePageSize = Rs("ArticlePageSize")
		End If:Rs.Close
	End If
	'子类
	If Sid <>"" Then
		AddSql = AddSql & " And ThreeClassName='"& Tid &"'"
		Rs.Open"Select * From [ThreeClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			GetArticlePageSize = Rs("ArticlePageSize")
		End If:Rs.Close
	End If
	'当前每页显示数为空或0时则为默认显示9条
	If GetArticlePageSize = "" Or GetArticlePageSize="0" Then	
		GetArticlePageSize = 9
	End If
End Function


'获得文章展示列表样式 20150114   配置 S = ReadTemplateFileSource("产品详细") 使用
Function GetArticleListStyle(Did,Sid,Tid)
	Dim Rs,AddSql
	Set Rs = CreateObject("Adodb.RecordSet")
 	'导航大类 默认大类类型
	Rs.Open"Select * From [NavBigClass] Where BigClassName='"& Did &"'",Conn,1,1
	If Not Rs.Eof Then
		If InStr("|产品|新闻|下载|","|"& Rs("NavType") &"|")>0 Then
			GetArticleListStyle = "默认"& Rs("NavType") &"列表.html"
		End If
	End If:Rs.Close	
	'大类
	AddSql = " Where BigClassName='"& Did &"' And ArticleListStyle<>''"
	Rs.Open"Select * From [BigClass]" & AddSql,Conn,1,1
	If Not Rs.Eof Then
		GetArticleListStyle = Rs("ArticleListStyle")
	End If:Rs.Close
	'小类
	If Sid <>"" Then
		AddSql = AddSql & " And SmallClassName='"& Sid &"'"
		Rs.Open"Select * From [SmallClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			GetArticleListStyle = Rs("ArticleListStyle")
		End If:Rs.Close
	End If
	'子类
	If Sid <>"" Then
		AddSql = AddSql & " And ThreeClassName='"& Tid &"'"
		Rs.Open"Select * From [ThreeClass]" & AddSql,Conn,1,1
		If Not Rs.Eof Then
			GetArticleListStyle = Rs("ArticleListStyle")
		End If:Rs.Close
	End If
	'最后为空则用默认展示样式
	If GetArticleListStyle="" Then
		GetArticleListStyle = "默认新闻列表.html"
	End If	
End Function

'读文件模板素材 
Function ReadTemplateFileSource(TemplateFilePath,ID)
	Dim StartStr,EndStr,S,c
	StartStr = "<!--#sourceHtml"& Replace(ID,".html","") &"Start#-->"
	EndStr = "<!--#sourceHtml"& Replace(ID,".html","") &"End#-->"	
	S = ReadTemplateFileModular(TemplateFilePath,StartStr,EndStr)
	If S = "[$NO$]" Then
		'加一个读取本文本里配置列表(20150815)
		c=GetStrCut(pubCode,StartStr,EndStr,2)
		if c<>"" then
			ReadTemplateFileSource=c
		'	call rwend(c)
			exit function
		end if
		c=getftext(TemplateFilePath)
		'存在 <!--#TemplateSplitStart#-->  就返回当前全部内容
		if instr(c,"<!--#DialogStart#-->")>0 then
			ReadTemplateFileSource=c
			exit function
		end if
		
		S = "模板资源ID["& ID &"]不存在,路径TemplateFilePath=" & handlePath(TemplateFilePath)
	End If
	ReadTemplateFileSource = S
End Function
'读出文件展示列表资源
Function ReadArticleListStyleSource(ID)
	dim filePath
	filePath = getWebImages() & "\文章展示样式\" & ID
	if checkFile(filePath)=false then
		filePath = WebTemplate & "\Resources\" & ID
	end if
	'call echo(checkfile(filePath),filePath)
	ReadArticleListStyleSource = ReadTemplateFileSource(filePath ,ID)
	
End Function
'读出文件信息列表资源
Function ReadArticleInfoStyleSource(ID)
	dim filePath
	filePath = getWebImages() & "\文章信息展示样式\" & ID
	if checkFile(filePath)=false then
		filePath = WebTemplate & "\Resources\" & ID
	end if
	ReadArticleInfoStyleSource = ReadTemplateFileSource(filePath ,ID)
End Function

%>





