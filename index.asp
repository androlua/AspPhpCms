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
<!--#Include File = "Inc/Config.Asp"-->
<!--#Include File = "inc/admin_function.Asp"--><%


Dim code
Dim WebFolderName
Dim ModuleReplaceArray(99, 99)
Call openconn()

Dim WEBURLFILEPATH
Dim WEBURLPREFIX
Dim templateName
Dim EDITORTYPE : EDITORTYPE = "asp"



Dim db_PREFIX : db_PREFIX = "xy_"



Dim cfg_webSiteUrl, cfg_webTemplate, cfg_webImages, cfg_webCss, cfg_webJs, cfg_webTitle, cfg_webKeywords, cfg_webDescription, cfg_webSiteBottom, cfg_flags
Dim gbl_columnName, gbl_columnId, gbl_id, gbl_columnType, gbl_columnENType, gbl_table, gbl_detailTitle, gbl_flags
Dim webTemplate
Dim gbl_url, gbl_filePath
Dim gbl_isonhtml

Dim gbl_bodyContent
dim gbl_artitleAuthor														
dim gbl_artitleAdddatetime													
dim gbl_upArticle															
dim gbl_downArticle															
dim gbl_aritcleRelatedTags													
dim gbl_aritcleSmallImage,gbl_aritcleBigImage										

Dim isMakeHtml

Function handleAction(a)
    Dim b, c, d, e, f, g, h
    b = "{\$" : c = "\$}"
    d = GetArray(a, b, c, True, True)

    e = Split(d, "$Array$")
    For Each g In e
        f = Trim(g)
        f = HandleInModule(f, "start")
        If f <> "" Then
            f = Trim(Mid(f, 3, Len(f) - 4)) & " "

            h = True

            If CheckFunValue(f, "# ") = True Then
                f = ""

            ElseIf CheckFunValue(f, "GetLableValue ") = True Then
                f = XY_getLableValue(f)


            ElseIf CheckFunValue(f, "Include ") = True Then
                f = XY_Include(f)


            ElseIf CheckFunValue(f, "CustomNavList ") = True Then
                f = XY_PHP_NavList(f)


            ElseIf CheckFunValue(f, "DetailList ") = True  or CheckFunValue(f, "CustomInfoList ") = True     Then
                f = XY_PHP_DetailList(f)


            ElseIf CheckFunValue(f, "CommentList ") = True Then
                f = XY_PHP_CommentList(f)



            ElseIf CheckFunValue(f, "MainInfo ") = True Then
                f = XY_PHP_SinglePage(f)

            ElseIf CheckFunValue(f, "GetColumnContent ") = True Then
                f = XY_PHP_GetColumnContent(f)



            ElseIf CheckFunValue(f, "Layout ") = True Then
                f = XY_Layout(f)

            ElseIf CheckFunValue(f, "Module ") = True Then
                f = XY_Module(f)

            ElseIf CheckFunValue(f, "GetColumnUrl ") = True Then
                f = XY_GetColumnUrl(f)

            ElseIf CheckFunValue(f, "GetOnePageUrl ") = True Then
                f = XY_GetOnePageUrl(f)

            ElseIf CheckFunValue(f, "DisplayWrap ") = True Then
                f = XY_DisplayWrap(f)




            ElseIf CheckFunValue(f, "ReadColumeSetTitle ") = True Then
                f = XY_ReadColumeSetTitle(f)


            ElseIf CheckFunValue(f, "displayEditor ") = True Then
                f = displayEditor(f)


            ElseIf CheckFunValue(f, "JsWebStat ") = True Then
                f = XY_JsWebStat(f)





            ElseIf CheckFunValue(f, "copyTemplateMaterial ") = True Then
                f = ""
            ElseIf CheckFunValue(f, "clearCache ") = True Then
                f = ""


            Else
                h = False
            End If

            If isNul(f) = True Then f = ""
            If h = True Then
                a = Replace(a, g, f)
            End If
        End If
    Next
    handleAction = a
End Function

Function XY_DisplayWrap(ByVal a)
    Dim b
    b = GetDefaultValue(a)
    XY_DisplayWrap = b
End Function

Function XY_GetColumnUrl(a)
    Dim b, c
    b = RParam(a, "columnName")
    c = getColumnUrl(b, "name")
    If Request("gl") <> "" Then
        c = c & "&gl=" & Request("gl")
    End If
    XY_GetColumnUrl = c
End Function

Function XY_GetOnePageUrl(a)
    Dim b, c
    b = RParam(a, "title")
    c = getOnePageUrl(b)
    If Request("gl") <> "" Then
        c = c & "&gl=" & Request("gl")
    End If
    XY_GetOnePageUrl = c
End Function

Function XY_getLableValue(a)
    Dim b, c, d

    b = RParam(a, "title")
    c = RParam(a, "content")
    d = d & "title=" & GetContentRunStr(b) & "<hr>"
    d = d & "content=" & GetContentRunStr(c) & "<hr>"
    XY_getLableValue = d
    Call echo("title", b)
    XY_getLableValue = "【title=】【" & b & "】"
End Function

Function replaceGlobleVariable(ByVal a)
    a = handleRGV(a, "[$cfg_webSiteUrl$]", cfg_webSiteUrl)
    a = handleRGV(a, "[$cfg_webTemplate$]", cfg_webTemplate)
    a = handleRGV(a, "[$cfg_webImages$]", cfg_webImages)
    a = handleRGV(a, "[$cfg_webCss$]", cfg_webCss)
    a = handleRGV(a, "[$cfg_webJs$]", cfg_webJs)
    a = handleRGV(a, "[$cfg_webTitle$]", cfg_webTitle)
    a = handleRGV(a, "[$cfg_webKeywords$]", cfg_webKeywords)
    a = handleRGV(a, "[$cfg_webDescription$]", cfg_webDescription)
    a = handleRGV(a, "[$cfg_webSiteBottom$]", cfg_webSiteBottom)

    a = handleRGV(a, "[$gbl_columnId$]", gbl_columnId)
    a = handleRGV(a, "[$gbl_columnName$]", gbl_columnName)
    a = handleRGV(a, "[$gbl_columnType$]", gbl_columnType)
    a = handleRGV(a, "[$gbl_columnENType$]", gbl_columnENType)


    a = handleRGV(a, "[$gbl_Table$]", gbl_table)
    a = handleRGV(a, "[$gbl_Id$]", gbl_id)



    a = handleRGV(a, "[$WebImages$]", cfg_webImages)
    a = handleRGV(a, "[$WebCss$]", cfg_webCss)
    a = handleRGV(a, "[$WebJs$]", cfg_webJs)

    a = handleRGV(a, "{$Web_Title$}", cfg_webTitle)
    a = handleRGV(a, "{$Web_KeyWords$}", cfg_webKeywords)
    a = handleRGV(a, "{$Web_Description$}", cfg_webDescription)
    a = handleRGV(a, "{$EDITORTYPE$}", EDITORTYPE)
	
	
    a = handleRGV(a, "{$gbl_artitleAuthor$}", gbl_artitleAuthor)
    a = handleRGV(a, "{$gbl_artitleAdddatetime$}", gbl_artitleAdddatetime)
    a = handleRGV(a, "{$gbl_upArticle$}", gbl_upArticle)
    a = handleRGV(a, "{$gbl_downArticle$}", gbl_downArticle)
    a = handleRGV(a, "{$gbl_aritcleRelatedTags$}", gbl_aritcleRelatedTags)
    a = handleRGV(a, "{$gbl_aritcleBigImage$}", gbl_aritcleBigImage)
    a = handleRGV(a, "{$gbl_aritcleSmallImage$}", gbl_aritcleSmallImage)
	

    replaceGlobleVariable = a
End Function

Function handleRGV(ByVal a, b, c)
    a = Replace(a, b, c)
    a = Replace(a, LCase(b), c)

    If InStr(b, "{") > 0 Then
        b = Replace(Replace(b, "{", "["), "}", "]")
    Else
        b = Replace(Replace(b, "[", "{"), "]", "}")
    End If
    a = Replace(a, b, c)
    a = Replace(a, LCase(b), c)
    handleRGV = a
End Function

Sub loadWebConfig()
    Dim b
    Call openconn()
    rs.Open "select * from " & db_PREFIX & "website", conn, 1, 1
    If Not rs.EOF Then
        cfg_webSiteUrl = phptrim(rs("webSiteUrl"))
        cfg_webTemplate = phptrim(rs("webTemplate"))
        cfg_webImages = phptrim(rs("webImages"))
        cfg_webCss = phptrim(rs("webCss"))
        cfg_webJs = phptrim(rs("webJs"))
        cfg_webTitle = rs("webTitle")
        cfg_webKeywords = rs("webKeywords")
        cfg_webDescription = rs("webDescription")
        cfg_webSiteBottom = rs("webSiteBottom")
        cfg_flags = rs("flags")


        If Request("templatedir") <> "" Then
            b = handlehttpurl(Replace(Request("templatedir"), handlePath("/"), "/"))
            cfg_webImages = Replace(cfg_webImages, cfg_webTemplate, b)
            cfg_webCss = Replace(cfg_webCss, cfg_webTemplate, b)
            cfg_webJs = Replace(cfg_webJs, cfg_webTemplate, b)
            cfg_webTemplate = b
        End If




        webTemplate = cfg_webTemplate
    End If : rs.Close
End Sub

Function thisPosition(a)
    Dim b
    b = "<a href=""/"">首页</a>"
    If gbl_columnName <> "" Then
        b = b & " >> <a href=""" & getColumnUrl(gbl_columnName, "name") & """>" & gbl_columnName & "</a>"
    End If
    a = Replace(a, "[$detailPosition$]", b)
    a = Replace(a, "[$detailTitle$]", gbl_detailTitle)
    a = Replace(a, "[$detailContent$]", gbl_bodyContent)

    thisPosition = a
End Function


Function getDetailList(a, b, c, d, ByVal e, f, g, h)
    Call openconn()
    Dim i, j, k, l, m, n, o, p
    Dim q, r, s
    Dim t

    Dim u
    Dim v

    Dim w
    m = LCase(c)
    Dim x
    x = RParam(a, "listFileName")

    Dim y
    y = rq("id")

    If e = "*" Then
        e = LCase(getFieldList(db_PREFIX & m))
    End If

    e = specialStrReplace(e)
    v = Split(e, ",")

    b = Replace(b, "{$lableTitle$}", d)
    b = Replace(b, "{$actionName$}", c)
    b = Replace(b, "{$lableTitle$}", d)
    b = Replace(b, "{$tableName$}", m)



    b = Replace(b, "{$nPageSize$}", f)
    b = Replace(b, "{$page$}", Request("page"))
    b = Replace(b, "{$nPageSize" & f & "$}", " selected")
    For j = 1 To 9
        b = Replace(b, "{$nPageSize" & j & "0$}", "")
    Next

    i = getStrCut(b, "[list]", "[/list]", 2)



    If "ASP" = "ASP" Then
        rs.Open "select * from " & db_PREFIX & m & " " & h, conn, 1, 1
        s = rs.RecordCount

        q = getRsPageNumber(rs, s, f, g)
        For j = 1 To q
            k = i

            For p = 1 To 3
                k = Replace(k, "[$id$]", rs("id"))
                For n = 0 To UBound(v)
                    If v(n) <> "" Then
                        o = Split(v(n) & "|||", "|")
                        u = o(0)
                        w = rs(u) & ""
                        k = replaceValueParam(k, u, w)
                    End If

                    If isMakeHtml = True Then
                        r = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id"))
                    Else
                        r = handleWebUrl("?act=detail&id=" & rs("id"))
                        If rs("customAUrl") <> "" Then
                            r = rs("customAUrl")
                        End If
                    End If
                    k = replaceValueParam(k, "url", r)
                Next
            Next

            r = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11)
            k = HandleDisplayOnlineEditDialog(r, k, "", "div|li|span")

            l = l & k
        rs.MoveNext : Next : rs.Close
        b = Replace(b, "[list]" & i & "[/list]", l)

        If isMakeHtml = True Then
            r = ""
            If Len(x) > 5 Then
                r = Mid(x, 1, Len(x) - 5) & "[id].html"
                r = urlAddHttpUrl(cfg_webSiteUrl, r)
            End If
        Else
            r = getUrlAddToParam(getUrl(), "?page=[id]", "replace")
        End If

        b = Replace(b, "[$pageInfo$]", webPageControl(s, f, g, r))
    Else


        rs.Open "select * from " & db_PREFIX & m & " " & h, conn, 1, 1
        s = rs.RecordCount

        page = Request("page")
        r = getUrlAddToParam(getUrl(), "?page=[id]", "replace")
        b = Replace(b, "[$pageInfo$]", webPageControl(s, f, page, r))
        If page <> "" Then
            page = page - 1
        End If
        rs.Open "select * from " & db_PREFIX & m & " " & h & " limit " & f * page & "," & f & "", conn, 1, 1
        While Not rs.EOF
            k = i
            For p = 1 To 3
                k = Replace(k, "[$id$]", rs("id"))
                k = Replace(k, "[$phpArray$]", "")
                For n = 0 To UBound(v)
                    If v(n) <> "" Then
                        o = Split(v(n) & "|||", "|")
                        u = o(0)
                        w = rs(u) & ""
                        k = replaceValueParam(k, u, w)
                    End If

                    If isMakeHtml = True Then
                        r = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id"))
                    Else
                        r = handleWebUrl("?act=detail&id=" & rs("id"))
                    End If
                    k = replaceValueParam(k, "url", r)
                Next
            Next

            r = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11)
            k = HandleDisplayOnlineEditDialog(r, k, "", "div|li|span")

            l = l & k
        rs.MoveNext : Wend : rs.Close
        b = Replace(b, "[list]" & i & "[/list]", l)

    End If

    getDetailList = b
End Function



Function defaultListTemplate()
    Dim b, c, d, e, f, g

    c = getFText(cfg_webTemplate & "/" & templateName)

    e = "list"
    f = "<!--#" & e & " start#-->"
    g = "<!--#" & e & " end#-->"
    If InStr(c, f) > 0 And InStr(c, g) > 0 Then
        d = StrCut(c, f, g, 2)
    Else
        f = "<!--#" & e
        g = "#-->"
        If InStr(c, f) > 0 And InStr(c, g) > 0 Then
            d = StrCut(c, f, g, 2)
        End If
    End If
    If d = "" Then
        b = "<ul class=""list"">" & vbCrLf
        b = b & "[list]    <li><a href=""[$url$]"" target=""[$target$]"">[$title$]</a><span class=""time"">[$adddatetime format_time='7'$]</span></li>" & vbCrLf
        b = b & "[/list]" & vbCrLf
        b = b & "</ul>" & vbCrLf
        b = b & "<div class=""clear10""></div>" & vbCrLf
        b = b & "<div>[$pageInfo$]</div>" & vbCrLf
        d = b
    End If

    defaultListTemplate = d
End Function

Function aritcleRelatedTags(a)
    Dim b, c, d, e
    c = Split(a, ",")
    For Each d In c
        If d <> "" Then
            If b <> "" Then
                b = b & ","
            End If
            e = getColumnUrl(d, "name")
            b = b & "<a href=""" & e & """ rel=""category tag"" class=""ablue"">" & d & "</a>" & vbCrLf
        End If
    Next

    b = "<footer class=""articlefooter"">" & vbCrLf & "标签： " & b & "</footer>" & vbCrLf
    aritcleRelatedTags = b
End Function


If Request("db_PREFIX") <> "" Then
    db_PREFIX = Request("db_PREFIX")
ElseIf Session("db_PREFIX") <> "" Then
    db_PREFIX = Session("db_PREFIX")
End If

Call loadWebConfig()
isMakeHtml = False
If Request("isMakeHtml") = "1" Or Request("isMakeHtml") = "true" Then
    isMakeHtml = True
End If
templateName = Request("templateName")



If Request("act") = "makehtml" Then
    Call echo("makehtml", "makehtml")
    isMakeHtml = True
    Call makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' id='" & Request("id") & "' ")
    Call createfile("index.html", code)


ElseIf Request("act") = "copyHtmlToWeb" Then
    Call copyHtmlToWeb()

ElseIf Request("act") = "makeallhtml" Then
    Call makeAllHtml("", "", "")


ElseIf Request("isMakeHtml") <> "" And Request("isSave") <> "" Then
    isMakeHtml = True
    Call rw(makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' columnType='" & Request("columnType") & "' id='" & Request("id") & "' npage='" & Request("page") & "' "))

    gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "")
    If Right(gbl_filePath, 1) = "/" Then
        gbl_filePath = gbl_filePath & "index.html"
    End If

    If gbl_filePath <> "" And gbl_isonhtml = True Then
        Call createDirFolder(getFileAttr(gbl_filePath,"1"))
        Call createfile(gbl_filePath, code)
        If Request("act") = "detail" Then
            conn.Execute("update " & db_PREFIX & "ArticleDetail set ishtml=true where id=" & Request("id"))
        ElseIf Request("act") = "nav" Then
            If Request("id") <> "" Then
                conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where id=" & Request("id"))
            Else
                conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where columnname='" & Request("columnName") & "'")
            End If
        End If
        Call echo("生成文件路径", "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>")
		
		
		if gbl_columnType="新闻" then
			call makeAllHtml("", "", gbl_columnId)
		end if
		
    End If
Else
    If LCase(Request("issave")) = "1" Then
        Call makeAllHtml(Request("columnType"), Request("columnName"), Request("columnId"))
    Else
        Call rw(makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' columnType='" & Request("columnType") & "' id='" & Request("id") & "' npage='" & Request("page") & "' "))
    End If
End If



Sub makeAllHtml(a, b, c)
    Dim d, e, f, g, h, i, j, k
    isMakeHtml = True

    Call echo("栏目", "")
    If a <> "" Then
        j = "where columnType='" & a & "'"
    End If
    If b <> "" Then
        j = getWhereAnd(j, "where columnName='" & b & "'")
    End If
    If c <> "" Then
        j = getWhereAnd(j, "where id=" & c & "")
    End If
    rss.Open "select * from " & db_PREFIX & "webcolumn " & j & " order by sortrank asc", conn, 1, 1
    While Not rss.EOF
        gbl_columnName = ""

        If rss("isonhtml") = True Then
            If rss("columntype") = "新闻" Then				
				h=getRecordCount(db_PREFIX & "articledetail", " where parentid=" & rss("id"))			
                g = rss("npagesize")
                i = getPageNumb(CInt(h), CInt(g))
                For f = 1 To i
                    k = getRsUrl(rss("fileName"), rss("customAUrl"), "/nav" & rss("id"))
                    gbl_filePath = Replace(k, cfg_webSiteUrl, "")
                    If Right(gbl_filePath, 1) = "/" Or gbl_filePath = "" Then
                        gbl_filePath = gbl_filePath & "index.html"
                    End If

                    d = " action actionType='nav' columnName='" & rss("columnname") & "' npage='" & f & "' listfilename='" & gbl_filePath & "' "

                    Call makeWebHtml(d)
                    If f > 1 Then
                        gbl_filePath = Mid(gbl_filePath, 1, Len(gbl_filePath) - 5) & f & ".html"
                    End If
                    e = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")"
                    Call echo(d, e)
                    If gbl_filePath <> "" Then
                        Call createDirFolder(getFileAttr(gbl_filePath,"1"))
                        Call createfile(gbl_filePath, code)
                    End If
                    doevents()
                    templateName = ""
                Next
            Else
                d = " action actionType='nav' columnName='" & rss("columnname") & "'"
                Call makeWebHtml(d)
                gbl_filePath = Replace(getColumnUrl(rss("columnname"), "name"), cfg_webSiteUrl, "")
                If Right(gbl_filePath, 1) = "/" Then
                    gbl_filePath = gbl_filePath & "index.html"
                End If
                e = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")"
                Call echo(d, e)
                If gbl_filePath <> "" Then
                    Call createDirFolder( getFileAttr(gbl_filePath,"1"))
                    Call createfile(gbl_filePath, code)
                End If
                doevents()
                templateName = ""
            End If
            conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where id=" & rss("id"))
        End If
    rss.MoveNext : Wend : rss.Close
    If j = "" Then

        Call echo("文章", "")
        rss.Open "select * from " & db_PREFIX & "articledetail order by sortrank asc", conn, 1, 1
        While Not rss.EOF
            gbl_columnName = ""
            d = " action actionType='detail' columnName='" & rss("parentid") & "' id='" & rss("id") & "'"

            Call makeWebHtml(d)
            gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "")
            If Right(gbl_filePath, 1) = "/" Then
                gbl_filePath = gbl_filePath & "index.html"
            End If
            e = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")"
            Call echo(d, e)

            If gbl_filePath <> "" And rss("isonhtml") = True Then
                Call createDirFolder(getFileAttr(gbl_filePath,"1"))
                Call createfile(gbl_filePath, code)
                conn.Execute("update " & db_PREFIX & "ArticleDetail set ishtml=true where id=" & rss("id"))
            End If
            templateName = ""
        rss.MoveNext : Wend : rss.Close


        Call echo("单页", "")
        rss.Open "select * from " & db_PREFIX & "onepage order by sortrank asc", conn, 1, 1
        While Not rss.EOF
            gbl_columnName = ""
            d = " action actionType='onepage' id='" & rss("id") & "'"

            Call makeWebHtml(d)
            gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "")
            If Right(gbl_filePath, 1) = "/" Then
                gbl_filePath = gbl_filePath & "index.html"
            End If
            e = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")"
            Call echo(d, e)

            If gbl_filePath <> "" And rss("isonhtml") = True Then
                Call createDirFolder(getFileAttr(gbl_filePath,"1"))
                Call createfile(gbl_filePath, code)
                conn.Execute("update " & db_PREFIX & "onepage set ishtml=true where id=" & rss("id"))
            End If
            templateName = ""
        rss.MoveNext : Wend : rss.Close

    End If


End Sub

Sub copyHtmlToWeb()
    Dim b, c, d, e, f, g, h, i, j, k,l, m, n, o, p
    WebFolderName = cfg_webTemplate
    If Left(WebFolderName, 1) = "/" Then
        WebFolderName = Mid(WebFolderName, 2)
    End If
    If Right(WebFolderName, 1) = "/" Then
        WebFolderName = Mid(WebFolderName, 1, Len(WebFolderName) - 1)
    End If
    If InStr(WebFolderName, "/") > 0 Then
        WebFolderName = Mid(WebFolderName, InStr(WebFolderName, "/") + 1)
    End If
    b = "/htmladmin/" & WebFolderName & "/"
    Call deleteFolder(b)
    Call createDirFolder(b)
    m = b & "Images/"
    n = b & "Css/"
    o = b & "Js/"
    Call copyFolder(cfg_webImages, m)
    Call copyFolder(cfg_webCss, n)
    Call createFolder(o)



    p = Split(getDirJsList(o), vbCrLf)
    For Each d In p
        If d <> "" Then
            c = o & getFileName(d)
            Call echo("js", d)
            Call moveFile(d, c)
        End If
    Next

    h = Split(getDirCssList(n), vbCrLf)
    For Each d In h
        If d <> "" Then
			i=getftext(d)
			i=replace(i,cfg_webImages, "../images/")
			call createfile(d,i)
			call echo("css",cfg_webImages)
        End If
    Next

    isMakeHtml = True
    rss.Open "select * from " & db_PREFIX & "webcolumn where isonhtml=true", conn, 1, 1
    While Not rss.EOF
        gbl_filePath = Replace(getColumnUrl(rss("columnname"), "name"), cfg_webSiteUrl, "")
        If Right(gbl_filePath, 1) = "/" Then
            gbl_filePath = gbl_filePath & "index.html"
        End If
        If Right(gbl_filePath, 5) = ".html" Then
            f = f & gbl_filePath & vbCrLf
            e = Replace(gbl_filePath, "/", "_")
            c = b & e
            Call copyfile(gbl_filePath, c)
            Call echo("导航", gbl_filePath)
        End If
    rss.MoveNext : Wend : rss.Close
    rss.Open "select * from " & db_PREFIX & "articledetail where isonhtml=true", conn, 1, 1
    While Not rss.EOF
        gbl_url = getRsUrl(rss("fileName"), rss("customAUrl"), "/html/detail" & rss("id"))
        gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "")
        If Right(gbl_filePath, 1) = "/" Then
            gbl_filePath = gbl_filePath & "index.html"
        End If
        If Right(gbl_filePath, 5) = ".html" Then
            f = f & gbl_filePath & vbCrLf
            e = Replace(gbl_filePath, "/", "_")
            c = b & e
            Call copyfile(gbl_filePath, c)
            Call echo("文章" & rss("title"), gbl_filePath)
        End If
    rss.MoveNext : Wend : rss.Close

    rss.Open "select * from " & db_PREFIX & "onepage where isonhtml=true", conn, 1, 1
    While Not rss.EOF
        gbl_url = getRsUrl(rss("fileName"), rss("customAUrl"), "/page/page" & rss("id"))
        gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "")
        If Right(gbl_filePath, 1) = "/" Then
            gbl_filePath = gbl_filePath & "index.html"
        End If
        If Right(gbl_filePath, 5) = ".html" Then
            f = f & gbl_filePath & vbCrLf
            e = Replace(gbl_filePath, "/", "_")
            c = b & e
            Call copyfile(gbl_filePath, c)
            Call echo("单页" & rss("title"), gbl_filePath)
        End If
    rss.MoveNext : Wend : rss.Close
	
    h = Split(f, vbCrLf)
    For Each d In h
        If d <> "" Then
            d = b & Replace(d, "/", "_")
            Call echo("filePath", d)
            i = getftext(d)
            i = Replace(i, cfg_webSiteUrl, "")
            i = Replace(i, cfg_webTemplate, "")
            For Each j In h
				k=j
				if right(k,11)="/index.html" then
					k=left(k,len(k)-11) & "/"
				end if				
                i = Replace(i, k, Replace(j, "/", "_"))
            Next

            For Each j In p
                If j <> "" Then
                    e = getFileName(j)
                    i = Replace(i, "Images/" & e, "js/" & e)
                End If
            Next
            If InStr(i, "/Jquery/Jquery.Min.js") > 0 Then
                i = Replace(i, "/Jquery/Jquery.Min.js", "js/Jquery.Min.js")
                Call copyfile("/Jquery/Jquery.Min.js", o & "/Jquery.Min.js")
            End If
            Call createfile(d, i)
        End If
    Next



	
    Call echo("webFolderName", WebFolderName)
    Call makeHtmlWebToZip(b)
End Sub

Function makeHtmlWebToZip(a)
    Dim b, c, d, e, f, g, h, i
    Dim j
    b = GetFileFolderList(a, True, "全部", "", "全部文件夹", "", "")
    c = Split(b, vbCrLf)
    For Each d In c
        If checkfolder(d) = False Then
            f = HandleFilePathArray(d)
            g = LCase(f(2))
            h = LCase(f(4))
            g = remoteNumber(g)
            i = True

            If InStr("|" & j & "|", "|" & g & "|") > 0 And h = "html" Then
                i = False
            End If
            If i = True Then

                If e <> "" Then e = e & "|"
                e = e & Replace(d, HandlePath("/"), "")
                j = j & g & "|"
            End If
        End If
    Next
    Call rw(e)
    e = e & "|||||"
    Call createfile("htmladmin/1.txt", e)
    Call echo("<hr>cccccccccccc", e)

    Call echo("", XMLPost("http://127.0.0.1/myZIP.php?webFolderName=" & WebFolderName, "content=" & escape(e)))

End Function




Function makeWebHtml(a)
    Dim b, c, d, e, f
    b = RParam(a, "actionType")
    d = RParam(a, "npage")
    d = getnumber(d)
    If d = "" Then
        d = 1
    Else
        d = CInt(d)
    End If

    If b = "nav" Then
        gbl_columnType = RParam(a, "columnType")
        gbl_columnName = RParam(a, "columnName")
        gbl_columnId = RParam(a, "columnId")
        If gbl_columnType <> "" Then
            f = "where columnType='" & gbl_columnType & "'"
        End If
        If gbl_columnName <> "" Then
            f = getWhereAnd(f, "where columnName='" & gbl_columnName & "'")
        End If
        If gbl_columnId <> "" Then
            f = getWhereAnd(f, "where columnId='" & gbl_columnId & "'")
        End If
        rs.Open "Select * from " & db_PREFIX & "webcolumn " & f, conn, 1, 1
        If Not rs.EOF Then
            gbl_columnId = rs("id")
            gbl_columnName = rs("columnname")
            gbl_columnType = rs("columntype")
            gbl_bodyContent = rs("bodycontent")
            gbl_detailTitle = gbl_columnName
            gbl_flags = rs("flags")
            c = rs("npagesize")
            gbl_isonhtml = rs("isonhtml")

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")
            End If
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")
            End If
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")
            End If
            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath")
                ElseIf rs("columntype") = "首页" Then
                    templateName = "Index_Model.html"
                Else
                    templateName = "Main_Model.html"
                End If
            End If
        End If : rs.Close
        gbl_columnENType = handleColumnType(gbl_columnType)
        gbl_url = getColumnUrl(gbl_columnName, "name")

		
        If instr("|新闻|产品|下载|视频|","|"& gbl_columnType &"|")>0 Then
            gbl_bodyContent = getDetailList(a, defaultListTemplate(), "ArticleDetail", "网站栏目", "*", c, d, "where parentid=" & gbl_columnId & " order by sortrank asc")
        ElseIf gbl_columnType = "文本" Then

            If Request("gl") = "edit" Then
                gbl_bodyContent = "<span>" & gbl_bodyContent & "</span>"
            End If
            e = "/admin/1.asp?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=" & gbl_columnId & "&n=" & getRnd(11)
            gbl_bodyContent = HandleDisplayOnlineEditDialog(e, gbl_bodyContent, "", "span")

        End If

    ElseIf b = "detail" Then
        rs.Open "Select * from " & db_PREFIX & "articledetail where id=" & RParam(a, "id"), conn, 1, 1
        If Not rs.EOF Then
            gbl_columnName = getColumnName(rs("parentid"))
            gbl_detailTitle = rs("title")
            gbl_flags = rs("flags")
            gbl_isonhtml = rs("isonhtml")
            gbl_id = rs("id")
            If isMakeHtml = True Then
                gbl_url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id"))
            Else
                gbl_url = handleWebUrl("?act=detail&id=" & rs("id"))
            End If

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")
            End If
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")
            End If
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")
            End If
			
			gbl_artitleAuthor=rs("author")			
			gbl_artitleAdddatetime=rs("adddatetime")
			gbl_upArticle=upArticle(rs("parentid"), "sortrank", rs("sortrank"))
			gbl_downArticle=downArticle(rs("parentid"), "sortrank", rs("sortrank"))
			gbl_aritcleRelatedTags=aritcleRelatedTags(rs("relatedtags"))
			gbl_aritcleSmallImage=rs("smallimage")
			gbl_aritcleBigImage=rs("bigimage")
			






			
			gbl_bodyContent=rs("bodycontent")


            If Request("gl") = "edit" Then
                gbl_bodyContent = "<span>" & gbl_bodyContent & "</span>"
            End If
            e = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & RParam(a, "id") & "&n=" & getRnd(11)
            gbl_bodyContent = HandleDisplayOnlineEditDialog(e, gbl_bodyContent, "", "span")


            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath")
                Else

                    If checkFile(cfg_webTemplate & "/Article_Detail.html") = True Then
                        templateName = "Article_Detail.html"
                    Else
                        templateName = "Main_Model.html"
                    End If

                End If
            End If

        End If : rs.Close


    ElseIf b = "onepage" Then
        rs.Open "Select * from " & db_PREFIX & "onepage where id=" & RParam(a, "id"), conn, 1, 1
        If Not rs.EOF Then
            gbl_detailTitle = rs("title")
            gbl_isonhtml = rs("isonhtml")
            If isMakeHtml = True Then
                gbl_url = getRsUrl(rs("fileName"), rs("customAUrl"), "/page/page" & rs("id"))
            Else
                gbl_url = handleWebUrl("?act=detail&id=" & rs("id"))
            End If

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")
            End If
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")
            End If
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")
            End If

            gbl_bodyContent = rs("bodycontent")



            If Request("gl") = "edit" Then
                gbl_bodyContent = "<span>" & gbl_bodyContent & "</span>"
            End If
            e = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & RParam(a, "id") & "&n=" & getRnd(11)
            gbl_bodyContent = HandleDisplayOnlineEditDialog(e, gbl_bodyContent, "", "span")


            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath")
                Else
                    templateName = "Main_Model.html"

                End If
            End If

        End If : rs.Close


    ElseIf b = "loading" Then
        Call rwend("页面正在加载中。。。")
    End If

    If templateName = "" Then
        templateName = "Index_Model.html"
    End If

    If InStr(templateName, "/") = False Then
        templateName = cfg_webTemplate & "/" & templateName
    End If

    code = getftext(templateName)


    code = handleAction(code)
    code = handleAction(code)
    code = handleAction(code)
    code = handleAction(code)
    code = handleAction(code)
    code = replaceGlobleVariable(code)
    code = thisPosition(code)
	
    code = handleAction(code)
    code = replaceGlobleVariable(code)
	
	
    code = handleAction(code)
    code = handleAction(code)
    code = handleAction(code)
    code = replaceGlobleVariable(code)
	
	
    code = delTemplateMyNote(code) 														


    If InStr(cfg_flags, "|formattinghtml|") > 0 Then

        code = HandleHtmlFormatting(code, False, 0, "删除空行")
    End If

    If InStr(cfg_flags, "|labelclose|") > 0 Then
        code = handleCloseHtml(code, True, "")
    End If


    If Rq("gl") = "edit" Then
        If InStr(code, "</head>") > 0 Then
            If InStr(code, "jquery.Min.js") = False Then
                code = Replace(code, "</head>", "<script src=""/Jquery/jquery.Min.js""></script></head>")
            End If
            code = Replace(code, "</head>", "<script src=""/Jquery/Callcontext_menu.js""></script></head>")
        End If
        If InStr(code, "<body>") > 0 Then

        End If
    End If

    makeWebHtml = code
End Function

%>


