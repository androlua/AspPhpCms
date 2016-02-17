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












Function NewsHandleListGroup(a, b, c, d, e, f, g)
    Dim h, i, j, k, l, m, n,o
    b = CInt(b)
	
	
	Dim p,q
	p = RParam(g,"Sid")
	q = RParam(g,"Tid")
	
	n = RParam(g,"AddSql")

	
	If LCase(Left(a, 4)) = "sql:" Then
        n = Mid(a, 5)
    ElseIf a<>"" Then
        n = "Where BigClassName='" & a & "'"
    End If
	
	
	n = RParam(g,"AddSql")
	k = "Select * From [Product] " & IIF(a<>""," Where BigClassName='" & a & "' ","")
	k = GetWhereAnd(k, IIF(p<>""," Where SmallClassName='" & p & "' ",""))
	k = GetWhereAnd(k, IIF(q<>""," Where ThreeClassName='" & q & "' ",""))
	
	k = GetWhereAnd(k,n)
	
	
	
	
	
	
	
	
    Rs.Open k, Conn, 1, 1
    For m = 1 To Rs.RecordCount
        If m > b Then Exit For
		
		
		h = Rs("FileName")
		If CheckMakeHtmlFile(h)=True Then
			h = GetHandleFileName(h)
			h = DetailPageAddHtmlPrefix(Rs("FolderName")) & "/" & h
		End If
		Call WebDebug(h, "act=CreateArticle&ID=" & Rs("Id"))
		
		
        l = CutStr(Rs("Title"), e, "... ")
        l = FontColorFontB(l, Rs("FontB"), Rs("FontColor"))

        i = "<a " & AHref(h, Rs("Title"), Rs("Target")) & ">" & l & "</a>" & vbCrLf
        If LCase(f) = "true" Then
            i = i & "<span class=""timeright"">" & Format_Time(Rs("UpDateTime"), 14) & "</span>" & vbCrLf
        End If
		i = DisplayOnlineEditDialog(""& adminDir &"Product.Asp?act=ShowEditProduct&Id=" & Rs("Id") & "&n=" & GetRnd(11), i)
        j = j & c & i & d
    Rs.MoveNext : Next : Rs.Close
    NewsHandleListGroup = j
End Function

Function NewsList(a,b,c,d,e,f)
	
	NewsList = NewsHandleListGroup(a,b,c,d, 28, e,f)
End Function

Function GetArticleParam(ByVal a,ByVal b,ByVal c)
	Dim d,e,f,g
	d = "Select * From ["& a &"] " & c
	TempRs.Open d,Conn,1,1
	If Not TempRs.Eof Then
	
		
		If b = "[url]" then		
			f = TempRs("FileName")
			If CheckRemoteUrl(f)=False Then
				f = GetHandleUrl(TempRs("FileName"))
				f = FullHttpUrl(Host,f)
				Call WebDebug(f, "act=CreateArticle&ID=" & TempRs("Id"))
			End If
	
			GetArticleParam = f
		ElseIf b<>"" Then
			GetArticleParam = TempRs(b)
		End If
	End If:TempRs.Close
End Function
%>

