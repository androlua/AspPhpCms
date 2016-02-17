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



Function XY_PHP_NavList(a)
    Dim b
    b = RParam(a, "sql")
    If b = "" Then
        b = "select * from " & db_PREFIX & "webcolumn where flags like'%top%' order by sortRank asc"
    End If
    b = replaceGlobleVariable(b)
    XY_PHP_NavList = XY_PHP_GeneralList(a, "WebColumn", b)
End Function


Function XY_PHP_CommentList(a)
    Dim b, c
    b = RParam(a, "sql")
    c = RParam(a, "itemID")
    c = replaceGlobleVariable(c)


    If b = "" Then
        b = "select * from " & db_PREFIX & "TableComment where itemID=" & c & " and through=1 order by adddatetime asc"
    End If
    b = replaceGlobleVariable(b)
    XY_PHP_CommentList = XY_PHP_GeneralList(a, "TableComment", b)
End Function


Function XY_PHP_DetailList(a)
    Dim b, c, d, e, f, g, h, i, j

    a = Replace(a, "[$detailTitle$]", gbl_detailTitle)

    b = RParam(a, "sql")
    f = RParam(a, "topNumb")
    If b = "" Then
        If f <> "" Then
            f = " top " & f & " "
        End If
        b = "Select " & f & "* From " & db_PREFIX & "ArticleDetail"
    End If

    g = LCase(RParam(a, "rand"))
    If g = "true" Or g = "1" Then
        b = b & " where id in(" & getRandArticleId("", f) & ")"
    End If


    i = RParam(a, "columnName")
    If i <> "" Then
        h = Split(i, "[Array]")
        For Each d In h
            e = getColumnId(d)
            If e <> "" Then
                If j <> "" Then
                    j = j & ","
                End If
                j = j & e
            End If
        Next
    End If
    If j <> "" Then
        b = getWhereAnd(b, "where parentId in(" & j & ")")
    End If

    c = RParam(a, "addSql")
    If c <> "" Then
        b = getWhereAnd(b, c)
    End If
    b = replaceGlobleVariable(b)
    XY_PHP_DetailList = XY_PHP_GeneralList(a, "ArticleDetail", b)
End Function

Function getOnePageUrl(a)
    Dim b
    rsx.Open "select * from " & db_PREFIX & "onepage where title='" & a & "'", conn, 1, 1
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            b = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/page/page" & rsx("id"))
        Else
            b = handleWebUrl("?act=onepage&id=" & rsx("id"))
            If rsx("customAUrl") <> "" Then
                b = rsx("customAUrl")
            End If
        End If
    End If : rsx.Close

    getOnePageUrl = b
End Function

Function getRsUrl(a, b, c)
    Dim d

    If a = "" Then
        a = c
    End If

    If a <> "" Then
        d = a
        If InStr(LCase(d), ".html") = False And Right(d, 1) <> "/" Then
            d = d & ".html"
        End If
    End If
    If Trim(b) <> "" Then
        d = Trim(b)
    End If
    If InStr(cfg_flags, "|addwebsite|") > 0 Then
        d = urlAddHttpUrl(cfg_webSiteUrl, d)
    End If
    getRsUrl = d
End Function


Function XY_PHP_GeneralList(a, b, c)
    Dim d, e, f, g, h
    Dim i, j, k, l, m
    Dim n, o, p, q
    Dim r, s, t, u, v, w, x, y
    Dim z
    r = GetDefaultValue(a)
    Dim aa
    z = Trim(LCase(RParam(a, "noFollow")))
    Dim ba
    Dim ca
    Dim da
    Dim ea
    Dim fa
    Dim ga, ha, ia, ja

    fa = LCase(getFieldList(db_PREFIX & b))
    ga = Split(fa, ",")


    rs.Open c, conn, 1, 1

    e = RParam(a, "topNumb")
    If e = "" Then
        e = rs.RecordCount
    Else
        e = CInt(e)
    End If
    If e > rs.RecordCount Then
        e = rs.RecordCount
    End If
    For s = 1 To e
        If rs.EOF Then Exit For
        ea = False

        q = rs("id")

        If b = "WebColumn" Then
            If isMakeHtml = True Then
                y = getRsUrl(rs("fileName"), rs("customAUrl"), "/nav" & rs("id"))
            Else
                y = handleWebUrl("?act=nav&columnName=" & rs("columnname")) 			
                If rs("customAUrl") <> "" Then
                    y = rs("customAUrl")
                End If
            End If

            If gbl_columnName = "" And rs("columnType") = "首页" Then
                gbl_columnName = rs("columnName")
            End If
            If rs("columnName") = gbl_columnName Then
                ea = True
            End If



        ElseIf b = "ArticleDetail" Then
            If isMakeHtml = True Then
                y = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id"))
            Else
                y = handleWebUrl("?act=detail&id=" & rs("id"))  			
                If rs("customAUrl") <> "" Then
                    y = rs("customAUrl")
                End If
            End If

            h = ""
            If rs("titlecolor") <> "" Then
                h = "color:" & rs("titlecolor") & ";"
            End If
            If InStr(rs("flags"), "|b|") > 0 Then
                h = h & "font-weight:bold;"
            End If
            If h <> "" Then
                h = "style=""" & h & """"
            End If
        ElseIf b = "TableComment" Then


        End If


        If y = WEBURLFILEPATH Or ea = True Then
            w = "[list-focus]" : x = "[/list-focus]"
        Else
            w = "[list-" & s & "]" : x = "[/list-" & s & "]"
        End If


        If s = e And ea = False Then
            w = "[list-end]" : x = "[/list-end]"
        End If


        For aa = 6 To 2 Step - 1
            If InStr(r, w) = False And s Mod aa = 0 Then
                w = "[list-mod" & aa & "]" : x = "[/list-mod" & aa & "]"
                If InStr(r, w) > 0 Then
                    Exit For
                End If
            End If
        Next


        If InStr(r, w) = False Then
            w = "[list]" : x = "[/list]"
        End If



        If InStr(r, w) > 0 And InStr(r, x) > 0 Then
            u = StrCut(r, w, x, 2)
            For t = 1 To 3
                u = handleReplaceValueParam(u, "ni", s)
                u = handleReplaceValueParam(u, "编号-1", s - 1)
                u = handleReplaceValueParam(u, "编号", s)
                u = Replace(u, "[$id$]", rs("id"))
                u = Replace(u, "[$url$]", y)

                For ja = 0 To UBound(ga)
                    If ga(ja) <> "" Then
                        ha = ga(ja)
                        ia = rs(ha) & ""

                        u = replaceValueParam(u, ha, ia)
                    End If
                Next
                u = replaceValueParam(u, "abcolor", h)
            Next



            w = "[list-" & s & " startdialog]" : x = "[/list-" & s & " startdialog]"
            If InStr(r, w) > 0 And InStr(r, x) > 0 Then
                u = StrCut(r, w, x, 2) & u
            End If

            w = "[list-" & s & " enddialog]" : x = "[/list-" & s & " enddialog]"
            If InStr(r, w) > 0 And InStr(r, x) > 0 Then
                u = u & StrCut(r, w, x, 2)
            End If



            If b = "WebColumn" Then
                y = WEB_ADMINURL & "?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=" & rs("id") & "&n=" & getRnd(11)

            ElseIf b = "ArticleDetail" Then
                y = WEB_ADMINURL & "?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11)
            End If
            u = HandleDisplayOnlineEditDialog(y, u, "", "div|li|span")
            v = v & u
        End If
    rs.MoveNext : Next : rs.Close


    w = "[dialog start]" : x = "[/dialog start]"
    If InStr(r, w) > 0 And InStr(r, x) > 0 Then
        v = StrCut(r, w, x, 2) & v
    End If

    w = "[dialog end]" : x = "[/dialog end]"
    If InStr(r, w) > 0 And InStr(r, x) > 0 Then
        v = v & StrCut(r, w, x, 2)
    End If
    XY_PHP_GeneralList = v
End Function


Function upArticle(a, b, c)
    Dim d
    d = "select * from " & db_PREFIX & "articledetail where parentid=" & a & " and " & b & "<" & c & " order by " & b & " desc"
    upArticle = handleUpDownArticle("上一篇：", d)
End Function

Function downArticle(a, b, c)
    Dim d
    d = "select * from " & db_PREFIX & "articledetail where parentid=" & a & " and " & b & ">" & c & " order by " & b & " asc"
    downArticle = handleUpDownArticle("下一篇：", d)
End Function

Function handleUpDownArticle(a, b)
    Dim c, d

    rsx.Open b, conn, 1, 1
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            d = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/html/detail" & rsx("id"))
        Else
            d = handleWebUrl("?act=detail&id=" & rsx("id"))
        End If
        c = "<li><a href=""" & d & """>" & a & rsx("title") & "</a></li>"
    Else
        c = "<li>" & a & "没有</li>"
    End If : rsx.Close
    handleUpDownArticle = c
End Function



Function XY_PHP_SinglePage(a)
    Dim b, c, d, e, f, g
    g = RParam(a, "fieldname")
    If g = "" Then
        g = "bodycontent"
    End If
    b = RParam(a, "title")
    d = GetDefaultValue(a)
    f = "select * from " & db_PREFIX & "onepage where title='" & b & "'"
    rs.Open f, conn, 1, 1
    If rs.EOF Then

        If RParam(a, "autoadd") = "true" Then
            conn.Execute("insert into " & db_PREFIX & "onepage (title,displaytitle," & g & ") values('" & b & "','" & b & "','" & ADSql(d) & "')")
        End If
    Else
        e = rs("id")
        d = rs(g)
    End If : rs.Close
    If e = "" Then
        e = XY_PHP_GetFieldValue("", f, "id")
    End If
    c = WEB_ADMINURL & "?act=addEditHandle&actionType=OnePage&lableTitle=单页管理&nPageSize=10&page=&switchId=2&id=" & e & "&n=" & getRnd(11)
    If Request("gl") = "edit" Then
        d = "<span>" & d & "</span>"
    End If

    d = HandleDisplayOnlineEditDialog(c, d, "", "span")
    XY_PHP_SinglePage = d
End Function

Function XY_PHP_GetColumnContent(a)
    Dim b, c, d, e, f, g
    g = RParam(a, "fieldname")
    If g = "" Then
        g = "bodycontent"
    End If
    b = RParam(a, "columnname")
    d = GetDefaultValue(a)
    f = "select * from " & db_PREFIX & "webcolumn where columnname='" & b & "'"
    rs.Open f, conn, 1, 1
    If Not rs.EOF Then
        e = rs("id")
        d = rs(g)
    End If : rs.Close
    If e = "" Then
        e = XY_PHP_GetFieldValue("", f, "id")
    End If
    c = WEB_ADMINURL & "?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&switchId=2&id=" & e & "&n=" & getRnd(11)
    If Request("gl") = "edit" Then
        d = "<span>" & d & "</span>"
    End If

    d = HandleDisplayOnlineEditDialog(c, d, "", "span")
    XY_PHP_GetColumnContent = d
End Function


Function XY_PHP_GetFieldValue(a, b, c)
    Dim d, e
    rs.Open b, conn, 1, 1
    If Not rs.EOF Then
        e = rs(c)
    End If : rs.Close
    XY_PHP_GetFieldValue = e
End Function


Function getRandArticleId(a, b)
    Dim c, d, e, f
    rs.Open "select * from " & db_PREFIX & "articledetail " & a, conn, 1, 1
    While Not rs.EOF
        If e <> "" Then e = e & ","
        e = e & rs("id")
    rs.MoveNext : Wend : rs.Close
    getRandArticleId = RandomShow(e, ",", 4)
    c = Split(e, ",") : e = "" : f = 0
    For Each d In c
        If e <> "" Then e = e & ","
        e = e & d
        f = f + 1
        If f >= b Then Exit For
    Next
    getRandArticleId = e
End Function


Function XY_Layout(a)
    Dim b, c, d
    b = RParam(a, "layoutname")
    rs.Open "select * from " & db_PREFIX & "weblayout where layoutname='" & b & "'", conn, 1, 1
    If Not rs.EOF Then
        XY_Layout = rs("bodycontent")
    End If : rs.Close





End Function

Function XY_Module(a)
    Dim b, c, d
    b = RParam(a, "modulename")
    rs.Open "select * from " & db_PREFIX & "webmodule where modulename='" & b & "'", conn, 1, 1
    If Not rs.EOF Then
        XY_Module = rs("bodycontent")
    End If : rs.Close
End Function

Function XY_JsWebStat(a)
    Dim b, c
    c = Trim(RParam(a, "fileName"))
    If c = "" Then
        c = "/inc/Create_Html.Asp"
    End If
    c = Replace(c, "/", "\/")
    b = "<script>document.writeln(""<script src=\'" & c & "?act=WebStat&GoToUrl="""
    b = b & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)"
    b = b & "+""&co=""+escape(document.cookie)"
    b = b & "+"" \'><\/script>"");</script>"
    XY_JsWebStat = b
End Function

%>


