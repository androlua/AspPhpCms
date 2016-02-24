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
'函数名：NewsHandleListGroup
'作  用：显示新闻列表
'时  间：2014年10月12日
'参  数：Did 大类名称
'*       TopNumb 显示条数
'*       StartLable 开始标签
'*       EndLable 结束标签
'*       CutStrNumb 截取字符数
'*       DateYes 显示时间True,False
'返回值：字符串
'调  试：Call Echo("测试函数 NewsHandleListGroup", NewsHandleListGroup("产品大类", 6, "<li>", "</li>", 32, False, ""))
'****************************************************
Function NewsHandleListGroup(Did, TopNumb, StartLable, EndLable, CutStrNumb, DateYes, Action)
    Dim Url, S, C, Sql, ShowTitle, I, AddSql,FileName
    TopNumb = CInt(TopNumb)                        '给显示条数转成数字类型，要不然会不提作用
	
	
	Dim Sid,Tid
	Sid = RParam(Action,"Sid")
	Tid = RParam(Action,"Tid")
	
	AddSql = RParam(Action,"AddSql")
    
	'废掉20121224
	If LCase(Left(Did, 4)) = "sql:" Then
        AddSql = Mid(Did, 5)
    ElseIf Did<>"" Then
        AddSql = "Where BigClassName='" & Did & "'"' And Recommend<>0 Order By Sort"
    End If
	
	'更新于20141224
	AddSql = RParam(Action,"AddSql")
	Sql = "Select * From [Product] " & IIF(Did<>""," Where BigClassName='" & Did & "' ","")
	Sql = GetWhereAnd(Sql, IIF(Sid<>""," Where SmallClassName='" & Sid & "' ",""))
	Sql = GetWhereAnd(Sql, IIF(Tid<>""," Where ThreeClassName='" & Tid & "' ",""))
	
	Sql = GetWhereAnd(Sql,AddSql)
	
	'If AddSql <>"" Then
	'	Sql = GetWhereAnd(Sql,AddSql)
	'Else
	'	Sql = GetWhereAnd(Sql," And Recommend<>0 Order By Sort")
	'End If
	
	'Call echo("Sql",Sql)
    Rs.Open Sql, Conn, 1, 1 
    For I = 1 To Rs.RecordCount
        If I > TopNumb Then Exit For
		 
		'Edit 20141220
		Url = Rs("FileName")
		If CheckMakeHtmlFile(Url)=True Then
			Url = GetHandleFileName(Url)
			Url = DetailPageAddHtmlPrefix(Rs("FolderName")) & "/" & Url
		End If
		Call WebDebug(Url, "act=CreateArticle&ID=" & Rs("Id"))                      '调试
		
		
        ShowTitle = CutStr(Rs("Title"), CutStrNumb, "... ")
        ShowTitle = FontColorFontB(ShowTitle, Rs("FontB"), Rs("FontColor"))

        S = "<a " & AHref(Url, Rs("Title"), Rs("Target")) & ">" & ShowTitle & "</a>" & vbCrLf 
        If LCase(DateYes) = "true" Then
            S = S & "<span class=""timeright"">" & Format_Time(Rs("UpDateTime"), 14) & "</span>" & vbCrLf 
        End If 
		S = DisplayOnlineEditDialog(""& adminDir &"Product.Asp?act=ShowEditProduct&Id=" & Rs("Id") & "&n=" & GetRnd(11), S)
        C = C & StartLable & S & EndLable 
    Rs.MoveNext : Next : Rs.Close 
    NewsHandleListGroup = C 
End Function
'新闻列表
Function NewsList(Did,TopNumb,StartLable,EndLable,DateYes,Action)
	'Call Echo("NewsList","NewsList")
	NewsList = NewsHandleListGroup(Did,TopNumb,StartLable,EndLable, 28, DateYes,Action)
End Function
'获得文件参数
Function GetArticleParam(ByVal TableName,ByVal FieldName,ByVal AddSql)
	Dim Sql,FileName,Url,BigFolder
	Sql = "Select * From ["& TableName &"] " & AddSql
	TempRs.Open Sql,Conn,1,1
	If Not TempRs.Eof Then
	
		'根据名称获得网址			
		If FieldName = "[url]" then		
			Url = TempRs("FileName")
			If CheckRemoteUrl(Url)=False Then
				Url = GetHandleUrl(TempRs("FileName")) 
				Url = FullHttpUrl(Host,Url)
				Call WebDebug(Url, "act=CreateArticle&ID=" & TempRs("Id"))                      '调试  
			End If 
	
			GetArticleParam = Url
		ElseIf FieldName<>"" Then
			GetArticleParam = TempRs(FieldName)
		End If
	End If:TempRs.Close
End Function
%>
