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




Function ProductList(a, b, c, d, e, f, ByVal g)
	
    Dim h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x
    Dim y, z, aa, ba, ca, da, ea
    Dim fa, ga, ha, ia, ja, ka, la, ma
    Dim na, oa, pa, qa, ra, sa, ta, ua,  va, wa
	Dim xa,ya,za,abb,bbb,cbb,dbb
	Dim ebb,fbb,DownloadModuleTypeList		
	Dim hbb
	Set hbb = CreateObject("Adodb.RecordSet")
	Dim PageParam				
	Dim ModuleName				
	Dim TitleLen				
	Dim NewFile					
	Dim ArticleDescription		
	Dim ModI					
	Dim AImg					
	
	NewFile=CreateHtmlPath	
	
	If InStr(CreateHtmlPath,".")>0 Then
		NewFile=Mid(CreateHtmlPath,1,InStr(CreateHtmlPath,".")-1)	
		NewFile = Host() & NewFile & "[id]" & Mid(CreateHtmlPath,InStr(CreateHtmlPath,"."))
	End If	
	NewFile = HandleHttpUrl(NewFile)
	
	
	
	
	
	
	
	If a <> "" Then
		PageParam=PageParam & "&ProDid=" & a
	End If
	If b <> "" Then
		PageParam=PageParam & "&ProSid=" & b
	End If
	If c <> "" Then
		PageParam=PageParam & "&ProTid=" & c
	End If
	If a="" Then a = "产品"

    If WebActionType = "Nav" Then
		
        a = WebNavDid : b = WebNavSid       								
    End If
	
    If d = "Search" Then
        h = ""
        If InStr(e, "{分}") > 0 Then
            w = Split(e, "{分}")
            If w(2) <> "" Then
                h = " And BigClassName='" & w(0) & "' And SmallClassName='" & w(1) & "' And ThreeClassName='" & w(2) & "'"
            ElseIf w(1) <> "" Then
                h = " And BigClassName='" & w(0) & "' And SmallClassName='" & w(1) & "'"
            ElseIf w(0) <> "" Then
                h = " And BigClassName='" & w(0) & "'"
            End If
        End If
        i = "Select * From [Product] Where Title Like '%" & f & "%'" & h
        fa = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME")
        ga = Split(Request.ServerVariables("QUERY_STRING"), "&")
        For Each l In ga
            ha = Split(l, "=")
            If StrComp(ha(0), "page", vbTextCompare) <> 0 Then
                ia = ia & ha(0) & "=" & ha(1) & "&"
            End If
        Next
        ja = fa & "?" & ia & "page="
    ElseIf c <> "" Then
        i = "Select * From [Product] Where BigClassName='" & a & "' And SmallClassName='" & b & "' And ThreeClassName='" & c & "'"
    ElseIf b <> "" Then
        i = "Select * From [Product] Where BigClassName='" & a & "' And SmallClassName='" & b & "'"
    Else
        i = "Select * From [Product] Where BigClassName='" & a & "'"
    End If


    WebNavType = ""

    v = "对不起，没有找到目标！关键词尽量要精简！"

	Dim TemplateSourceID				
	TemplateSourceID = GetArticleListStyle(a,b,c)
	na = ReadArticleListStyleSource(TemplateSourceID)
	
	
	
	n = GetArticlePageSize(a,b,c)
	
	
	
	
	dim qbb,rbb,sbb
	za="<!--#config "
	abb="#-->"
	qbb=GetStrCut(na,za,abb,2)
	rbb=lcase(RParam(qbb,"dispalyPageInfo"))
	sbb=HandleNumber(RParam(qbb,"nPageSize"))
	if sbb<>"" then n=cint(sbb)
	
	
	
	
	If IsNul(TitleLen)=True Then TitleLen = 32								
	If IsNul(n)=True Then n = 3								
	
    Call GetTemplateSplit(na, oa, pa, qa)
	
	If pa="" Then
		ProductList =  "出错了2，S=" & ra & "<hr>，里面没有Did=【" & a & "】这个参数。" & TemplateSourceID
		Exit Function
	End If
	
	
	i = GetWhereAnd(i,h)
	i = GetWhereAnd(i,GetProductListSort(a,b,c))		
	
    hbb.Open i, Conn, 1, 1
    If Not hbb.EOF Then
        v = "搜索结果：符合查询条件的记录 <strong>" & hbb.RecordCount & " </strong>条，以下为您列出"
        hbb.PageSize = n
        m = hbb.RecordCount
        n = hbb.PageSize
        o = hbb.PageCount
        If Not IsNumeric(g) Or g = "" Then
            g = 1
        Else
            g = CInt(g)
        End If
        If g < 1 Then
            g = 1
        ElseIf g > o Then
            g = o
        End If
        hbb.AbsolutePage = g
        If g = o Then
            l = m - (o - 1) * n
        Else
            l = n
        End If
        For j = 1 To l	
			
			q = hbb("FileName")
			If CheckRemoteUrl(q)=False Then		
				q = GetHandleUrl(hbb("FileName"))
				Call WebDebug(q, "act=CreateArticle&ID=" & hbb("Id"))
			End If
			
			ArticleDescription = hbb("ArticleDescription")								
			If ArticleDescription="#" Or ArticleDescription="null" Or ArticleDescription="empty" Then
				ArticleDescription = ""
			ElseIf IsNul(ArticleDescription) Then
				ArticleDescription = hbb("Content")
			End If	
			
            sa = IIF(IsNul(hbb("SmallFiles")), hbb("BigFiles"), hbb("SmallFiles"))
			sa = ReplaceGlobleLable(sa)
			
			If sa="" Then
				sa = "/UploadFiles/NoImg.jpg"
			End If
			
			
            ta = "<img src='" & sa & "'" & SetHtmlParam(fa, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
			AImg = ImgSrc(sa, hbb("Title"), hbb("Target"))
			
            ua = "<a src='" & hbb("BigFiles") & "'" & SetHtmlParam(fa, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
            s = CutStr(hbb("Title"), TitleLen, "... ")
            s = FontColorFontB(s, hbb("FontB"), hbb("FontColor"))
            ua = "<a " & AHref(q, hbb("Title"), hbb("Target")) & SetHtmlParam(fa, "aclass") & ">" & s & "</a>" & vbCrLf
            va = AHref(q, hbb("Title"), hbb("Target")) & SetHtmlParam(fa, "aclass")
            If f <> "" Then
                s = Replace(s, f, "<font color=red><b>" & f & "</b></font>")
            End If
			
			
			
			za="[list-"& j &"]" : abb="[/list-"& j &"]"			
			
			For ModI=6 To 2 Step -1
				If InStr(pa,za)=False And j Mod ModI =0 Then
					za="[list-mod"& ModI &"]" : abb="[/list-mod"& ModI &"]"
					If InStr(pa,za)>0 Then
						
						Exit For
					End If
				End If
			Next 			
			
			If InStr(pa,za)=False Then
				za="[list]" : abb="[/list]"
			End If
			If InStr(pa,za) And InStr(pa,abb) Then
				ra = StrCut(pa,za,abb,2)
			Else
				ra = pa
			End If
			
			
			ra = Replace(ra,"[$i$]",j)
			ra = Replace(ra,"[$i-1$]",j-1)
			
			For k=1 To 6
				ra = ReplaceValueParam(ra,"ni",j)								
				ra = ReplaceValueParam(ra,"编号-1",j-1)								
				ra = ReplaceValueParam(ra,"编号",j)								
				ra = ReplaceValueParam(ra,"title",hbb("Title"))
				ra = ReplaceValueParam(ra,"showtitle",s)
				ra = ReplaceValueParam(ra,"adddatetime",hbb("AddDateTime"))
				ra = ReplaceValueParam(ra,"imgfile",sa)
				ra = ReplaceValueParam(ra,"imgurl",sa)
				ra = ReplaceValueParam(ra,"img",sa)
				ra = ReplaceValueParam(ra,"url",q)
				ra = ReplaceValueParam(ra,"href",q)
				ra = ReplaceValueParam(ra,"aurl",va)
				ra = ReplaceValueParam(ra,"astr",ua)
				ra = ReplaceValueParam(ra,"aimg",AImg)				
				ra = ReplaceValueParam(ra,"description",hbb("WebDescription"))
				ra = ReplaceValueParam(ra,"content",hbb("Content"))
				ra = ReplaceValueParam(ra,"price",hbb("Price"))
				ra = ReplaceValueParam(ra,"author",hbb("Author"))
				ra = ReplaceValueParam(ra,"articledescription",ArticleDescription)
								
			Next

			
			ra = DisplayOnlineEditDialog(""& adminDir &"Product.Asp?act=ShowEditProduct&id=" & hbb("Id") & "&n=" & GetRnd(11), ra)
            p = p & ra

        hbb.MoveNext : Next
    End If : hbb.Close

	
	
    If g <= 1 Then
        y = "<span class='PageBox'>首页</span>"
        z = "<span class='PageBox'>上一页</span>"
    Else
        If ja <> "" Then		
			q = ja & "1"
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=1")
            y = "<a href='" & q & "'>首页</a>"
			
			q = ja &(g - 1)
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & (g - 1))
            z = "<a href='" & q & "'>上一页</a>"
			
        Else
			
			q = Replace(NewFile,"[id]", "")
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=1")
            y = "<a href='" & q & "'>首页</a>"
			
			
			q = Replace(NewFile,"[id]", g-1)
			
			If g-1=1 Then
				q = Replace(NewFile,"[id]", "")
			End If
			
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & g - 1)
            z = "<a href='" & q & "'>上一页</a>"
        End If
    End If

    If g >= o Then
        aa = "<span class='PageBox'>下一页</span>"
        ba = "<span class='PageBox'>尾页</span>"
    Else
        If ja <> "" Then
			q = ja &(g + 1)
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & (g+1))
            aa = "<a href='" & q & "'>下一页</a>"
			
			q = ja & o
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & o)
            ba = "<a href='" & q & "'>尾页</a>"
        Else
			
			q = Replace(NewFile,"[id]", g+1)
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & (g+1))
            aa = "<a href='" & q & "'>下一页</a>"
			
			
			q = Replace(NewFile,"[id]", o)
			Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & o)
            ba = "<a href='" & q & "'>尾页</a>"
        End If
    End If

    ca = g - 2
    da = g + 2
    If ca <= 0 Then
        da = da + ca * - 1 + 1
        ca = 1
    End If
    If da > o Then
        ca = ca + (o - da)
        da = o
    End If

    For j = ca To da
        If j >= 1 And j <= o Then
            If j = g Then
                u = u & "<span class='PageBox'>" & j & "</span>"
            Else
                If ja <> "" Then
					q = ja & j & "'" & ma
					Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & j)
                    u = u & "&nbsp;<a href='" & q & ">" & j & "</a>"
                Else

					q = Replace(NewFile,"[id]", IIF(j<>1,j,""))
					Call WebDebug(q, "act=CreateClass"& PageParam &"&Page=" & j)
                    u = u & "&nbsp;<a href='" & q & "'" & ma & ">" & j & "</a>"
                End If

            End If
        End If
    Next
    p = oa & p & qa
	
	if rbb<>"false" and rbb<>"0" then
	    p = p & "<div class='t_page ColorLink'>总数：" & m & "条&nbsp;&nbsp;当前页数：<span class='FontRed'>" & g & "</span>/" & o & "&nbsp;" & y & "&nbsp;&nbsp;" & z & "&nbsp;" & u & "&nbsp;&nbsp;" & aa & "&nbsp;&nbsp;" & ba & "</div>"
	end if

    CreatePage = o

    If f <> "" Then
        p = "<div class='SearchEcho'>" & v & "</div>" & vbCrLf & p
    End If
    ProductList = p
End Function

Function GetProductListSort(a,b,c)
	Dim AddSortType									
	Dim OrderSortType								
	Dim TimeSortType								
	Dim g
	
	
	If a<>"" Then
		Rs.Open"Select * From [BigClass] Where BigClassName='"& a &"'",Conn,1,1
		If Not Rs.Eof Then
			AddSortType = Rs("AddSortType")
			OrderSortType = Rs("OrderSortType")
			TimeSortType = Rs("TimeSortType")
		End If:Rs.Close
	End If
	
	If b<>"" Then
		Rs.Open"Select * From [SmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"'",Conn,1,1
		If Not Rs.Eof Then
			
			If Rs("AddSortType")="无" Then
				AddSortType=""
			ElseIf Rs("AddSortType")="" Then
				AddSortType = Rs("AddSortType")
			End If
			
			If Rs("OrderSortType")="无" Then
				OrderSortType=""
			ElseIf Rs("OrderSortType")="" Then
				OrderSortType = Rs("OrderSortType")
			End If
			
			If Rs("TimeSortType")="无" Then
				TimeSortType=""
			ElseIf Rs("TimeSortType")="" Then
				TimeSortType = Rs("TimeSortType")
			End If
		End If:Rs.Close
	End If
	
	If b<>"" Then
		Rs.Open"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'",Conn,1,1
		If Not Rs.Eof Then
			
			If Rs("AddSortType")="无" Then
				AddSortType=""
			ElseIf Rs("AddSortType")="" Then
				AddSortType = Rs("AddSortType")
			End If
			
			If Rs("OrderSortType")="无" Then
				OrderSortType=""
			ElseIf Rs("OrderSortType")="" Then
				OrderSortType = Rs("OrderSortType")
			End If
			
			If Rs("TimeSortType")="无" Then
				TimeSortType=""
			ElseIf Rs("TimeSortType")="" Then
				TimeSortType = Rs("TimeSortType")
			End If
		End If:Rs.Close
	End If
	
	If AddSortType = "添加正排序" Then
		If g<>"" Then g = g & ","
		g=g & "Id Asc"
	ElseIf AddSortType = "添加倒排序" Then
		If g<>"" Then g = g & ","
		g=g & "Id  Desc"	
	End If
	
	If OrderSortType = "顺序正排序" Then
		If g<>"" Then g = g & ","
		g=g & "Sort Asc"
	ElseIf OrderSortType = "顺序倒排序" Then
		If g<>"" Then g = g & ","
		g=g & "Sort Desc"	
	End If
	
	If TimeSortType = "时间正排序" Then
		If g<>"" Then g = g & ","
		g=g & "AddDateTime Asc"
	ElseIf TimeSortType = "时间倒排序" Then
		If g<>"" Then g = g & ","
		g=g & "AddDateTime Desc"	
	End If
	If g<>"" Then g = " Order By " & g
	
	GetProductListSort = g
	If 1=2 Then
		Call Echo("Did",a)
		Call Echo("Sid",b)
		Call Echo("Tid",c)
		Call Echo("AddSortType",AddSortType)
		Call Echo("OrderSortType",OrderSortType)
		Call Echo("TimeSortType",TimeSortType)
		Call Echo("Sql",g)
	End If
End Function





%>













