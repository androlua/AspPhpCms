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









Function getDidSidTidSQl(a, b, c)
    Dim d, e
    e = " Where "
    If a <> "" Then
        d = d & e & "BigClassName='" & a & "'"
        e = " And "
    End If
    If b <> "" Then
        d = d & e & "SmallClassName='" & b & "'"
        e = " And "
    End If
    If c <> "" Then
        d = d & e & "ThreeClassName='" & c & "'"
    End If
    getDidSidTidSQl = d
End Function

Function checkBigClass(a)
    checkBigClass = conn.Execute("Select Count(*) From [BigClass] Where BigClassName='" & a & "'")(0)
End Function

Function checkSmallClass(a, b)
    Dim c, d
    c = "Select Count(*) From [SmallClass]"
    d = getDidSidTidSQl(a, b, "")
    c = GetWhereAnd(c, d)
    checkSmallClass = conn.Execute(c)(0)
End Function

Function checkThreeClass(a, b, c)
    Dim d, e
    d = "Select Count(*) From [ThreeClass]"
    e = getDidSidTidSQl(a, b, c)
    d = GetWhereAnd(d, e)
    checkThreeClass = conn.Execute(d)(0)
End Function

Function checkProduct(a, b, c)
    Dim d
    d = "Select Count(*) From [Product]"
    If a <> "" Then d = GetWhereAnd(d, "BigClassName='" & a & "'")
    If b <> "" Then d = GetWhereAnd(d, "SmallClassName='" & b & "'")
    If c <> "" Then d = GetWhereAnd(d, "ThreeClassName='" & c & "'")
    checkProduct = conn.Execute(d)(0)
End Function

Function autoAddMainInfo(a, b, c)
    Call HandleAutoAddMainInfo(a, b, False, c)
End Function

Function handleAutoAddMainInfo(a, b, c, d)
    Dim e
    e = "Select * From [MainInfo] Where Title='" & a & "'"
    If UserId <> "" Then e = GetWhereAnd(e, " And UserId=" & UserId)
    If CheckSql(e) = False Then Call eerr("Sql", e)
    rs.Open e, conn, 1, 3
    If rs.EOF Then
        rs.AddNew
        rs("Title") = a
        rs("ShowTitle") = b
        rs("Content") = d
        rs("OnHtml") = c
        rs.Update
    End If : rs.Close
End Function

Function autoAddBigClass(a)
    Dim b, c
    If conn.Execute("Select Count(*) From [BigClass] Where BigClassName='" & a & "'")(0) = 0 Then
        b = PinYin(a, 3)
        c = conn.Execute("Select Count(*) From [SmallClass]")(0) + 1
        conn.Execute("Insert Into[BigClass](BigClassName,FolderName,Sort) Values('" & a & "', '" & b & "'," & c & ")")
        autoAddBigClass = "【" & a & "】创建大类成功"
    Else
        autoAddBigClass = "【" & a & "】大类已存在"
    End If
End Function

Function autoAddSmallClass(a, b)
    Dim c, d
    If conn.Execute("Select Count(*) From [SmallClass] Where BigClassName='" & a & "' And  SmallClassName='" & b & "'")(0) = 0 Then
        c = PinYin(b, 3)
        d = conn.Execute("Select Count(*) From [SmallClass] Where BigClassName='" & a & "'")(0) + 1
        conn.Execute("Insert Into[SmallClass](BigClassName,SmallClassName,FolderName,Sort) Values('" & a & "','" & b & "', '" & c & "'," & d & ")")
        autoAddSmallClass = "【" & a & "】创建小类成功"
    Else
        autoAddSmallClass = "【" & a & "】小类已存在"
    End If
End Function

Function autoAddThreeClass(a, b, c)
    Dim d, e
    If conn.Execute("Select Count(*) From [ThreeClass] Where BigClassName='" & a & "' And  SmallClassName='" & b & "' And ThreeClassName='" & c & "'")(0) = 0 Then
        d = PinYin(b, 3)
        e = conn.Execute("Select Count(*) From [SmallClass] Where BigClassName='" & a & "' And  SmallClassName='" & b & "'")(0) + 1
        conn.Execute("Insert Into[ThreeClass](BigClassName,SmallClassName,ThreeClassName,FolderName,Sort) Values('" & a & "','" & b & "','" & c & "', '" & d & "'," & e & ")")
        autoAddThreeClass = "【" & b & "】创建子类成功"
    Else
        autoAddThreeClass = "【" & b & "】子类已存在"
    End If
End Function

Function autoAddArticle(a, b, c, d, e)
    autoAddArticle = AutoAddArticleAction("", a, b, c, d, "", e)
End Function

Function autoAddArticleAction(a, b, c, d, e, f, g)
    Dim h, i, j,k
    Dim l, m, n, o
    Dim p, q, r, s, t, u

    l = RParam(a, "BigImage")
    m = RParam(a, "SmallImage")
    l = HandleHttpUrl(Replace(l, "[$样式名称$]", WebSkins))
    m = HandleHttpUrl(Replace(m, "[$样式名称$]", WebSkins))

    p = RParam(a, "Keywords")
    q = RParam(a, "Description")
    p = HandleHttpUrl(Replace(p, "[$样式名称$]", WebSkins))
    q = HandleHttpUrl(Replace(q, "[$样式名称$]", WebSkins))

    t = LCase(RParam(a, "OriginalTitleYes"))
	
	dim memberprice			
	dim price				
    memberprice =RParam(a, "memberprice")			
    price =RParam(a, "price")						
	
	

    e = Trim(e)
    h = h & getDidSidTidSQl(b, c, d)
    If e <> "" Then h = h & " And Title='" & e & "'"
    i = "Select * From [Product]" & GetWhereAnd(i, h)
    RsTemp.Open i, conn, 1, 3
    If RsTemp.EOF Then
        If t = "true" Then
            j = e
        Else
            j = b & "-" & c & "-" & d & "-" & e
        End If
        RsTemp.AddNew
        RsTemp("BigClassName") = b
        RsTemp("SmallClassName") = c
        RsTemp("ThreeClassName") = d
        RsTemp("WebTitle") = e
        RsTemp("Title") = j




        n = Replace(l, "[id]", f)
        o = Replace(m, "[id]", f)
        If n <> "" Then RsTemp("BigFiles") = n
        If o <> "" Then RsTemp("SmallFiles") = o

        r = Replace(p, "[id]", j)
        s = Replace(q, "[id]", j)

        RsTemp("WebKeywords") = r
        RsTemp("WebDescription") = s

        RsTemp("Content") = g
		
		call echo(a,memberprice)
		
		if price<>"" then
			if instr(price,"-")>0 then
				k=split(price,"-")
        		RsTemp("price") = PHPRand(cint(k(0)),cint(k(1)))
			end if
		end if
		
		if memberprice<>"" then
			if instr(memberprice,"-")>0 then
				k=split(memberprice,"-")
        		RsTemp("memberprice") = PHPRand(cint(k(0)),cint(k(1)))
			end if
		end if

        RsTemp.Update
        u = RsTemp(0)
        RsTemp.Close

        RsTemp.Open "Select * From [Product] where id=" & u, conn, 1, 3
        If Not RsTemp.EOF Then
            RsTemp("FileName") = "article" & u
            RsTemp.Update
        End If

        autoAddArticleAction = True
    Else
        autoAddArticleAction = False
    End If : RsTemp.Close
End Function

Function autoAddBigClassAndArticle(a, b)
    Dim c
    Call AutoAddBigClass(a)
    For c = 1 To b
        Call AutoAddArticle(a, "", "", a & "标题-" & c, a & "内容-" & c)
    Next
End Function








Function getWebTemplate()
    Dim b
    Set b = CreateObject("Adodb.RecordSet")
        b.Open "Select * From [WebSite]", conn, 1, 1
        If Not b.EOF Then
            getWebTemplate = b("WebTemplate")
        End If : b.Close
End Function

Function getWebSkins()
    Dim b
    Set b = CreateObject("Adodb.RecordSet")
        b.Open "Select * From [WebSite]", conn, 1, 1
        If Not b.EOF Then
            getWebSkins = b("WebSkins")
        End If : b.Close
End Function

Function getWebImages()
    Dim b
    Set b = CreateObject("Adodb.RecordSet")
        b.Open "Select * From [WebSite]", conn, 1, 1
        If Not b.EOF Then
            getWebImages = b("WebImages")
        End If : b.Close
End Function


Function detailPageAddHtmlPrefix(ByVal a)
    a = HandleHttpUrl(a)
    If InStr(a, "/") = False Then
        a = "/Html/" & a
    Else
        a = ReplaceN(GetWebFolderName() & a, "//", "/", 3)


    End If
    If Left(a, 1) <> "/" Then a = "/" & a
    detailPageAddHtmlPrefix = a
End Function

Function getHandleFolderName(a)
    a = PinYin2(a)
    a = Replace(Replace(a, "/", "\"), " ", "")
    a = Replace(Replace(a, "\\", "\"), "\\", "\")
    getHandleFolderName = a
End Function




Function getMainInfoUrl(a)
    Dim b, c
    rs.Open "Select * From [MainInfo] Where Title='" & a & "'", conn, 1, 1
    If Not rs.EOF Then

        If Trim(rs("TemplatePath")) <> "" Then
            TemplatePath = WebTemplate & rs("TemplatePath")
        Else
            TemplatePath = WebTemplate & "Main_Model.Html"
        End If



        c = Trim(rs("FileName"))

        If CheckMakeHtmlFile(c) = True Then
            b = GetHandleFileName(c)
            c = detailPageAddHtmlPrefix(rs("FolderName")) & "/" & c
            c = GetHandleUrl(c)
        End If

        c = WebDebug(c, "act=MainInfo&Id=" & rs("Id"))
    End If : rs.Close
    getMainInfoUrl = c
End Function

Function getMainUrl(a)
    getMainUrl = getMainInfoUrl(a)
End Function

Function getNavUrl(a, b)
    Dim c, d, e

    Set e = CreateObject("Adodb.RecordSet")
        e.Open "Select * From [NavBigClass] Where BigClassName='" & a & "'", conn, 1, 1
        If Not e.EOF Then
            d = Trim(e("FolderName"))
            c = GetWebFolderName & "/" & e("FolderName") & "/" & e("FileName")
            c = GetHandleUrl(c)

            If CheckMakeHtmlFile(e("FileName")) = False Then
                c = e("FileName")
            End If

            c = WebDebug(c, "act=Nav&NavDid=" & a)
        End If : e.Close
        If b <> "" Then
            e.Open "Select * From [NavSmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", conn, 1, 3
            If Not e.EOF Then
                If e("FolderName") = "" Then
                    c = "/" & d & "/"
                Else
                    c = "/" & e("FolderName") & "/"
                End If
                If e("FileName") = "" Then
                    e("FileName") = HtmlFileName(e("SmallClassName"))
                    e.Update
                End If
                c = GetWebFolderName & c & e("FileName")
                c = GetHandleUrl(c)


                If CheckMakeHtmlFile(e("FileName")) = False Then
                    c = e("FileName")
                End If

                c = WebDebug(c, "act=Nav&NavDid=" & a & "&NavSid=" & b)

            End If : e.Close
        End If
        getNavUrl = c

End Function

Function getNavTarget(a, b)
    If b <> "" Then
        TempRs.Open "Select * From [NavSmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", conn, 1, 1
        If Not TempRs.EOF Then
            getNavTarget = TempRs("Target")
        End If : TempRs.Close
        Exit Function
    End If
    TempRs.Open "Select * From [NavBigClass] Where BigClassName='" & a & "'", conn, 1, 1
    If Not TempRs.EOF Then
        getNavTarget = TempRs("Target")
    End If : TempRs.Close
End Function

Function getBigClassFolderName(a)
    Dim b
    Set b = CreateObject("Adodb.RecordSet")
        b.Open "Select * From [BigClass] Where BigClassName='" & a & "'", conn, 1, 1
        If Not b.EOF Then

            getBigClassFolderName = "/" & b("FolderName") & "/" & b("FileName")
            getBigClassFolderName = GetHandleUrl(getBigClassFolderName)


            If CheckMakeHtmlFile(b("FileName")) = False Then
                getBigClassFolderName = b("FileName")
            End If

            Call WebDebug(getBigClassFolderName, "act=CreateClass&ProDid=" & b("BigClassName") & "&page=1")
        End If : b.Close
End Function

Function getBigClassFileName(a)
    getBigClassFileName = getBigClassFolderName(a)
End Function

Function getBigClassUrl(a)
    getBigClassUrl = getBigClassFolderName(a)
End Function

Function getSmallClassFolderName(a, b)
    Dim c, d, e, f
    Set f = CreateObject("Adodb.RecordSet")

        f.Open "Select * From [BigClass] Where BigClassName='" & a & "'", conn, 1, 1
        If Not f.EOF Then

            d = "/" & f("FolderName") & "/"







            getSmallClassFolderName = d
            Call WebDebug(getSmallClassFolderName, "act=CreateClass&ProDid=" & f("BigClassName"))
        End If : f.Close
        If b <> "" Then
            f.Open "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", conn, 1, 1
            If Not f.EOF Then


                e = Trim(Replace(f("FolderName"), "\", "/"))
                If Left(e, 1) <> "/" Then
                    d = d & "/" & e & "/"
                Else
                    d = "/" & f("FolderName") & "/"
                End If







                If CheckMakeHtmlFile(f("FileName")) = True Then
                    d = d & f("FileName")
                    d = "/" & GetWebFolderName() & GetHandleUrl(d)
                Else
                    d = "/" & GetWebFolderName() & f("FileName")

                    If GetWebSite(f("FileName")) <> "" Then
                        d = f("FileName")
                    End If
                End If

                getSmallClassFolderName = d

                Call WebDebug(getSmallClassFolderName, "act=CreateClass&ProDid=" & a & "&ProSid=" & f("SmallClassName"))
            End If : f.Close
        End If
End Function

Function getSmallClassFileName(a, b)
    getSmallClassFileName = getSmallClassFolderName(a, b)
End Function

Function getSmallClassUrl(a, b)
    getSmallClassUrl = getSmallClassFolderName(a, b)
End Function

Function getThreeClassFolderName(a, b, c)
    Dim d, e

    TempRs.Open "Select * From [BigClass] Where BigClassName='" & a & "'", conn, 1, 1
    If Not TempRs.EOF Then

        d = "/" & TempRs("FolderName") & "/"







        getThreeClassFolderName = d
        Call WebDebug(getThreeClassFolderName, "act=CreateClass&ProDid=" & TempRs("BigClassName"))
    End If : TempRs.Close
    If b <> "" Then
        TempRs.Open "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", conn, 1, 1
        If Not TempRs.EOF Then








            e = Trim(Replace(TempRs("FolderName"), "\", "/"))
            If Left(e, 1) <> "/" Then
                d = d & "/" & e & "/"
            Else
                d = "/" & TempRs("FolderName") & "/"
            End If

            getThreeClassFolderName = d
            Call WebDebug(getThreeClassFolderName, "act=CreateClass&ProDid=" & a & "&ProSid=" & TempRs("SmallClassName"))
        End If : TempRs.Close
    End If
    If c <> "" Then
        TempRs.Open "Select * From [ThreeClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "' And ThreeClassName='" & c & "'", conn, 1, 1
        If Not TempRs.EOF Then

            e = Trim(Replace(TempRs("FolderName"), "\", "/"))
            If Left(e, 1) <> "/" Then
                d = d & "/" & e & "/"
            Else
                d = "/" & TempRs("FolderName") & "/"


                If GetWebSite(TempRs("FileName")) <> "" Then
                    d = TempRs("FileName")
                End If

            End If








            If CheckMakeHtmlFile(TempRs("FileName")) = True Then
                d = d & TempRs("FileName")
                d = GetHandleUrl(d)
            Else
                d = TempRs("FileName")
            End If

            getThreeClassFolderName = d
            Call WebDebug(getThreeClassFolderName, "act=CreateClass&ProDid=" & a & "&ProSid=" & b & "&ProTid=" & TempRs("ThreeClassName"))
        End If : TempRs.Close
    End If
End Function

Function getThreeClassFileName(a, b, c)
    getThreeClassFileName = getThreeClassFolderName(a, b, c)
End Function

Function getThreeClassUrl(a, b, c)
    getThreeClassUrl = getThreeClassFolderName(a, b, c)
End Function

Function getClassUrl(a, b, c)
    Dim d
    If c <> "" Then
        d = getThreeClassFolderName(a, b, c)
    ElseIf b <> "" Then
        d = getSmallClassFolderName(a, b)
    Else
        d = getBigClassFolderName(a)
    End If
    d = Trim(Replace(d, "\", "/"))
    If Left(d, 1) <> "/" And GetWebSite(d) = "" Then d = "/" & d
    getClassUrl = d
End Function

Function getClassUrl_Nav(a, b, c)
    Dim d
    d = getClassUrl(a, b, c)
    d = Mid(d, 2)
    If Right(d, 1) = "/" Then d = Left(d, Len(d) - 1)
    getClassUrl_Nav = d
End Function

Function getProductUrl(a)
    TempRs.Open "Select * From [Product] " & a, conn, 1, 1
    If Not TempRs.EOF Then
        getProductUrl = GetHandleUrl(TempRs("FileName"))
        Call WebDebug(getProductUrl, "act=CreateArticle&ID=" & TempRs("Id"))
    End If : TempRs.Close
End Function

Function aotuGetProductFileName(ByVal a)
    Dim b, c, d
    d = a
    a = Md5(d, 2) & Md5(d, 4)
    b = True
    While b
        TempRs.Open "Select * From [Product] Where Title='" & a & "'", conn, 1, 1
        If TempRs.EOF Then
            b = False
            aotuGetProductFileName = a
        Else
            d = d & "1"
            a = Md5(d, 2) & Md5(d, 4)
        End If : TempRs.Close

    Wend
End Function

Function upPage(a)
    Dim b, c, d, e, f, g, h, i, j
    RsTemp.Open "Select * From [Product] Where ID=" & a, conn, 1, 1
    If Not RsTemp.Eof Then
        c = RsTemp("BigClassName")
        d = RsTemp("SmallClassName")
        e = RsTemp("ThreeClassName")
    End If : RsTemp.Close

    If e <> "" Then
        b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And ThreeClassName='" & e & "' And"
    ElseIf d <> "" Then
        b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And"
    Else
        b = "BigClassName='" & c & "' And "
    End If
    f = "Select * from [Product] where " & b & "  Id < " & a & " order by Id  desc"

    RsTemp.Open f, conn, 1, 1
    If Not RsTemp.Eof Then

        g = RsTemp("FileName")
        If CheckRemoteUrl(g) = False Then
            g = GetHandleUrl(RsTemp("FileName"))
            Call WebDebug(g, "act=CreateArticle&ID=" & RsTemp("Id"))
        End If

        h = "_top"
        i = RsTemp("Title")
        j = "<a " & AHref(g, i, h) & ">上一篇："

        upPage = j & CutStr(i, 100, "...") & "</a><br>"
    Else
        upPage = InfoColor("上一篇：没有<br>", SysStyle(0)) & ""
    End If
    RsTemp.Close
End Function

Function downPage(a)
    Dim b, c, d, e, f, g, h, i, j
    RsTemp.Open "Select * From [Product] Where ID=" & a, conn, 1, 1
    If Not RsTemp.EOF Then
        c = RsTemp("BigClassName")
        d = RsTemp("SmallClassName")
        e = RsTemp("ThreeClassName")
    End If : RsTemp.Close

    If e <> "" Then
        b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And ThreeClassName='" & e & "' And"
    ElseIf d <> "" Then
        b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And"

    Else
        b = "BigClassName='" & c & "' And "
    End If
    f = "select * from Product where " & b & "  Id > " & a & " order by Id  asc"
    RsTemp.Open f, conn, 1, 1
    If Not RsTemp.EOF Then

        g = RsTemp("FileName")
        If CheckRemoteUrl(g) = False Then
            g = GetHandleUrl(RsTemp("FileName"))
            Call WebDebug(g, "act=CreateArticle&ID=" & RsTemp("Id"))
        End If

        h = "_top"
        i = RsTemp("Title")
        j = "<a " & AHref(g, i, h) & ">下一篇："

        downPage = j & CutStr(i, 100, "...") & "</a><br>"

    Else
        downPage = InfoColor("下一篇：没有<br>", SysStyle(0))
    End If
    RsTemp.Close
End Function


Function getHandleFileName(ByVal a)

    If a = "" Or a = "/" Or a = "\" Then
        getHandleFileName = "/Index.Html"
    Else
        getHandleFileName = a & ".Html"
    End If
End Function




Function htmlFileName(ByVal a)
    htmlFileName = handleSaveFileName(a, True)
End Function

Function handleSaveFileName(ByVal a, b)
    Dim c, d, e
    a = Trim(a)
    If CheckMakeHtmlFile(a) = True Then
        c = ":*?""<>|.,"
        For d = 1 To Len(c)
            e = Mid(c, d, 1)
            a = Replace(a, e, "")
        Next
        If b = True Then
            a = Trim(PinYin2(a))
        End If
    End If

    handleSaveFileName = Left(a, 100)
End Function


Function checkMakeHtmlFile(ByVal a)
    Dim b
    a = Trim(LCase(Replace(a, "\", "/"))) : b = a
    If InStr(a, "/") > 0 Then
        a = Trim(Mid(a, InStrRev(a, "/") + 1))
    End If
    checkMakeHtmlFile = True
    If Left(b, 7) = "http://" Or Left(b, 4) = "www." Or Left(b, 4) = "url:" Or Left(b, 5) = "/url:" Or Left(a, 1) = "#" Or Left(a, 11) = "javascript:" Then
        checkMakeHtmlFile = False
    End If
End Function






Function displayOnlineEditDialog(a, b)
    displayOnlineEditDialog = HandleDisplayOnlineEditDialog(a, b, "", "")
End Function

Function displayOnlineED2(a, b, c)
    displayOnlineED2 = HandleDisplayOnlineEditDialog(a, b, "", c)
End Function
%>


