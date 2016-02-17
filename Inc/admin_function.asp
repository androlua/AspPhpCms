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


Function flagsArticleDetail(a)
    Dim b

    If InStr("|" & a & "|", "|h|") > 0 Then
        b = b & "头"
    End If

    If InStr("|" & a & "|", "|c|") > 0 Then
        b = b & "推 "
    End If

    If InStr("|" & a & "|", "|f|") > 0 Then
        b = b & "幻 "
    End If

    If InStr("|" & a & "|", "|a|") > 0 Then
        b = b & "特 "
    End If

    If InStr("|" & a & "|", "|s|") > 0 Then
        b = b & "滚 "
    End If

    If InStr("|" & a & "|", "|b|") > 0 Then
        b = b & "粗 "
    End If
    If b <> "" Then b = "[<font color=""red"">" & b & "</font>]"

    flagsArticleDetail = b
End Function

Function getTitleSetColorHtml(a)
    Dim b
    b = "<script language=""javascript"" type=""text/javascript"" src=""js/colorpicker.js""></script>" & vbCrLf
    b = b & "<img src=""images/colour.png"" width=""15"" height=""16"" onclick=""colorpicker('title_colorpanel','set_title_color');"" style=""cursor:hand"">" & vbCrLf
    b = b & "<span id=""title_colorpanel"" style=""position:absolute; z-index:200"" class=""colorpanel""></span>" & vbCrLf
    b = b & "<img src=""images/bold.png"" width=""10"" height=""10"" onclick=""input_font_bold()"" style=""cursor:hand"">" & vbCrLf
    getTitleSetColorHtml = b
End Function


Function showColumnList(ByVal a, ByVal b, c, ByVal d)
    Dim e, f, g, h, i
    Dim j : Set j = CreateObject("Adodb.RecordSet")
        j.Open "select * from " & db_PREFIX & "webcolumn where parentid=" & a & "  order by sortrank asc", conn, 1, 1
        While Not j.EOF
            h = ""
            If CStr(j("id")) = CStr(b) Then
                h = " selected "
            End If
            e = d
            e = replaceValueParam(e, "sortrank", j("sortrank"))
            e = replaceValueParam(e, "id", j("id"))
            e = replaceValueParam(e, "parentid", j("parentid"))
            e = replaceValueParam(e, "selected", h)
            g = j("columnname")
            If c >= 1 Then
                g = copystr("&nbsp;&nbsp;", c) & "├─" & g
            End If
            e = replaceValueParam(e, "columnname", g)
            e = replaceValueParam(e, "columntype", j("columntype"))
            e = replaceValueParam(e, "flags", j("flags"))
            e = replaceValueParam(e, "ishtml", j("ishtml"))
            e = replaceValueParam(e, "isonhtml", j("isonhtml"))


            i = WEB_VIEWURL & "?act=nav&columnName=" & g

            If Trim(j("customaurl")) <> "" Then
                i = Trim(j("customaurl"))
            End If
            e = Replace(e, "[$viewWeb$]", i)

            If EDITORTYPE = "php" Then
                e = Replace(e, "[$phpArray$]", "[]")
            Else
                e = Replace(e, "[$phpArray$]", "")
            End If


            f = f & e & vbCrLf
            f = f & showColumnList(j("id"), b, c + 1, d)
        j.MoveNext : Wend : j.Close
        showColumnList = f
End Function

Function getMsg1(a, b)
    Dim c
    c = getFText(ROOT_PATH & "msg.html")
    a = a & "<br>" & JsTiming(b, 5)
    c = Replace(c, "[$msgStr$]", a)
    c = Replace(c, "[$url$]", b)
    getMsg1 = c
End Function

Function columnList(a, b)
    Dim c, d
    Dim e : Set e = CreateObject("Adodb.RecordSet")
        e.Open "select * from " & db_PREFIX & "webcolumn where parentid=" & a, conn, 1, 1
        While Not e.EOF
            Call echo(copystr("====", b) & e("id"), e("columnname"))
            Call columnList(e("id"), b + 1)
        e.MoveNext : Wend : e.Close
End Function


Sub dispalyManage(a, b, ByVal c, d, e)
    Call loadWebConfig()
    Dim f, g, h, i, j
    Dim k, l, m, n
    Dim o

    Dim p, q, r
    Dim s
    Dim t
    Dim u
    Dim v

    Dim w
    p = LCase(a)

    u = Request("keyword")
    v = Request("parentid")

    Dim x
    x = rq("id")

    If c = "*" Then
        c = LCase(getFieldList(db_PREFIX & p))
    End If

    c = specialStrReplace(c)
    t = Split(c, ",")

    f = getFText(ROOT_PATH & "manage" & a & ".html")
    f = Replace(f, "{$Web_Title$}", cfg_webTitle)
    f = Replace(f, "{$position$}", "系统管理 > " & b & "列表")
    f = Replace(f, "{$actionName$}", a)
    f = Replace(f, "{$lableTitle$}", b)
    f = Replace(f, "{$tableName$}", p)
    f = Replace(f, "{$keyword$}", u)
    f = Replace(f, "{$parentid$}", Request("parentid"))

    f = Replace(f, "{$nPageSize$}", d)
    f = Replace(f, "{$page$}", Request("page"))
    f = Replace(f, "{$nPageSize" & d & "$}", " selected")
    For h = 1 To 9
        f = Replace(f, "{$nPageSize" & h & "0$}", "")
    Next

    g = getStrCut(f, "[list]", "[/list]", 2)

    If a = "WebColumn" Then
        f = Replace(f, "[list]" & g & "[/list]", showColumnList( -1, "", 0, g))
    Else


        If "ASP" = "ASP" Then
            If u <> "" Then
                e = getWhereAnd(" where title like '%" & u & "%' ", e)
            End If
            If v <> "" Then
                e = getWhereAnd(" where parentid=" & v & " ", e)
            End If


            rs.Open "select * from " & db_PREFIX & p & " " & e, conn, 1, 1
            m = rs.RecordCount
            n = Request("page")

            k = getRsPageNumber(rs, m, d, n)
            For h = 1 To k
                i = Replace(g, "[$id$]", rs("id"))
                For q = 0 To UBound(t)
                    If t(q) <> "" Then
                        r = Split(t(q) & "|||", "|")
                        s = r(0)
                        w = rs(s) & ""

                        If a = "ArticleDetail" And s = "flags" Then
                            w = flagsArticleDetail(w)
                        End If


                        i = replaceValueParam(i, s, w)

                    End If

                Next
                o = "id"
                i = Replace(i, "[$selectid$]", "<input type='checkbox' name='" & o & "' id='" & o & "' value='" & rs("id") & "' >")
                i = Replace(i, "[$phpArray$]", "")
                l = "【NO】"
                If a = "ArticleDetail" Then
                    l = WEB_VIEWURL & "?act=detail&id=" & rs("id")
                ElseIf a = "OnePage" Then
                    l = WEB_VIEWURL & "?act=onepage&id=" & rs("id")

                ElseIf a = "TableComment" Then
                    l = WEB_VIEWURL & "?act=detail&id=" & rs("itemid")
                End If

                If InStr(c, "customaurl") > 0 Then

                    If Trim(rs("customaurl")) <> "" Then
                        l = Trim(rs("customaurl"))
                    End If
                End If
                i = Replace(i, "[$viewWeb$]", l)
                j = j & i
            rs.MoveNext : Next : rs.Close
            f = Replace(f, "[list]" & g & "[/list]", j)
            l = getUrlAddToParam(getUrl(), "?page=[id]", "replace")

            f = Replace(f, "[$pageInfo$]", webPageControl(m, d, n, l))
        Else


            If u <> "" Then
                e = " where title like '%" & u & "%'" & e
            End If
            rs.Open "select * from " & p & " " & e, conn, 1, 1
            m = rs.RecordCount

            n = Request("page")
            l = getUrlAddToParam(getUrl(), "?page=[id]", "replace")
            f = Replace(f, "[$pageInfo$]", webPageControl(m, d, n, l))
            If n <> "" Then
                n = n - 1
            End If
            rs.Open "select * from " & db_PREFIX & "" & p & " " & e & " limit " & d * n & "," & d & "", conn, 1, 1
            While Not rs.EOF
                i = Replace(g, "[$id$]", rs("id"))
                i = Replace(i, "[$phpArray$]", "")
                For q = 0 To UBound(t)
                    If t(q) <> "" Then
                        r = Split(t(q) & "|||", "|")
                        s = r(0)
                        w = rs(s) & ""

                        If a = "ArticleDetail" And s = "flags" Then
                            w = flagsArticleDetail(w)
                        End If

                        i = replaceValueParam(i, s, w)
                    End If
                Next

                o = "id"
                i = Replace(i, "[$selectid$]", "<input type='checkbox' name='" & o & "' id='" & o & "' value='" & rs("id") & "' >")
                i = Replace(i, "[$phpArray$]", "")

                If a = "ArticleDetail" Then
                    l = WEB_VIEWURL & "?act=detail&id=" & rs("id")

                    If Trim(rs("customaurl")) <> "" Then
                        l = Trim(rs("customaurl"))
                    End If
                    i = Replace(i, "[$viewWeb$]", l)
                End If
                j = j & i
            rs.MoveNext : Wend : rs.Close
            f = Replace(f, "[list]" & g & "[/list]", j)

        End If

    End If

    If InStr(f, "[$input_parentid$]") > 0 Then
        g = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>"
        j = "<select name=""parentid"" id=""parentid""><option value="""">≡ 选择栏目 ≡</option>" & showColumnList( -1, v, 0, g) & vbCrLf & "</select>"
        f = Replace(f, "[$input_parentid$]", j)
    End If
	
    f = Replace(f, "{$EDITORTYPE$}", EDITORTYPE)
    f = f & stat2016(True)
    Call rw(f)
End Sub

Sub addEditDisplay(a, b, ByVal c)
    Dim d, e, f, g, h, i, j, k, l, m
    Dim n
    Dim o
    Dim p
    Dim q
    Dim r
    Dim splFieldValue(99)
    Dim t
    Dim u
    Dim v
    Dim w
    Dim x
    Dim y
    Dim z
    Dim aa
    Dim ba
    ba = c
    k = LCase(a)


    Call loadWebConfig()

    Dim ca
    ca = rq("id")
    c = specialStrReplace(c)

    z = LCase(getFieldList(db_PREFIX & k))
    c = c & "," & z


    o = Split(c, ",")
    e = "添加"
    If ca <> "" Then
        e = "修改"
        If ca = "*" Then
            t = "select * from " & db_PREFIX & "" & k
        Else
            t = "select * from " & db_PREFIX & "" & k & " where id=" & ca
        End If
        rs.Open t, conn, 1, 1
        If Not rs.EOF Then
            ca = rs("id")
            For g = 0 To UBound(o)
                f = Split(o(g) & "|||", "|")
                n = f(0)
                If o(g) <> "" And InStr("," & z & ",", "," & n & ",") > 0 And InStr("," & aa & ",", "," & n & ",") = False Then
                    splFieldValue(g) = rs(n)
                    If a = "ArticleDetail" And n = "titlecolor" Then
                        w = rs(n)
                    ElseIf n = "flags" Then
                        y = rs(n)
                    End If
                End If
            Next
        End If : rs.Close
    End If
    d = getFText(ROOT_PATH & "addEdit" & k & ".html")
    d = Replace(d, "{$Web_Title$}", cfg_webTitle)

    If InStr(cfg_flags, "|iscloseeditor|") > 0 Then
        i = getStrCut(d, "<!--#editor start#-->", "<!--#editor end#-->", 1)
        If i <> "" Then
            d = Replace(d, i, "")
        End If
    End If

    For g = 0 To UBound(o)
        f = Split(o(g) & "|||", "|")
        n = f(0)
        p = f(1)
        q = unSpecialStrReplace(f(2), "")

        If o(g) <> "" And InStr("," & z & ",", "," & n & ",") > 0 And InStr("," & aa & ",", "," & n & ",") = False Then
            aa = aa & o(g) & ","
            For h = 0 To 10
                r = q

                If e = "修改" Then
                    r = splFieldValue(g)
                End If

                If p = "password" Then
                    r = ""
                End If
                If r <> "" Then
                    r = Replace(Replace(r, """", "&quot;"), "<", "&lt;")
                End If
                If InStr(",ArticleDetail,WebColumn,", "," & a & ",") > 0 And n = "parentid" Then
                    u = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>"
                    If e = "添加" Then
                        r = Request("parentid")
                    End If
                    j = "<select name=""parentid"" id=""parentid""><option value=""-1"">≡ 作为一级栏目 ≡</option>" & showColumnList( -1, r, 0, u) & vbCrLf & "</select>"
                    d = Replace(d, "[$input_parentid$]", j)

                ElseIf a = "WebColumn" And n = "columntype" Then
                    d = Replace(d, "[$input_columntype$]", showSelectList("columntype", WEBCOLUMNTYPE, "|", r))

                ElseIf InStr(",ArticleDetail,WebColumn,", "," & a & ",") > 0 And n = "flags" Then
                    v = "flags"
                    If EDITORTYPE = "php" Then
                        v = "flags[]"
                    End If

                    If a = "ArticleDetail" Then
                        i = inputCheckBox3(v, iif(InStr("|" & r & "|", "|h|") > 0, 1, 0), "h", "头条[h]")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|c|") > 0, 1, 0), "c", "推荐[c]")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|f|") > 0, 1, 0), "f", "幻灯[f]")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|a|") > 0, 1, 0), "a", "特荐[a]")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|s|") > 0, 1, 0), "s", "滚动[s]")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|b|") > 0, 1, 0), "b", "加粗[b]")
                        i = Replace(i, " value='b'>", " onclick='input_font_bold()' value='b'>")

                    ElseIf a = "WebColumn" Then
                        i = inputCheckBox3(v, iif(InStr("|" & r & "|", "|top|") > 0, 1, 0), "top", "顶部显示")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|buttom|") > 0, 1, 0), "buttom", "底部显示")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|left|") > 0, 1, 0), "left", "左边显示")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|center|") > 0, 1, 0), "center", "中间显示")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|right|") > 0, 1, 0), "right", "右边显示")
                        i = i & inputCheckBox3(v, iif(InStr("|" & r & "|", "|other|") > 0, 1, 0), "other", "其它位置显示")
                    End If
                    d = Replace(d, "[$input_flags$]", i)

                ElseIf a = "ArticleDetail" And n = "title" Then
                    i = "<input name='title' type='text' id='title' value=""" & r & """ style='width:66%;' class='measure-input' alt='请输入标题'>"
                    x = " style='color:" & w & ";"
                    If InStr("|" & y & "|", "|b|") > 0 Then
                        x = x & "font-weight: bold;"
                    End If
                    i = Replace(i, " style='", x)
                    d = Replace(d, "[$input_title$]", i & inputHiddenText("titlecolor", w) & getTitleSetColorHtml(""))


                ElseIf p = "textarea1" Then
                    d = Replace(d, "[$input_" & n & "$]", handleInputHiddenTextArea(n, r, "97%", "120px", "input-text", ""))
                ElseIf p = "textarea2" Then
                    d = Replace(d, "[$input_" & n & "$]", handleInputHiddenTextArea(n, r, "97%", "300px", "input-text", ""))
                ElseIf p = "textarea3" Then
                    d = Replace(d, "[$input_" & n & "$]", handleInputHiddenTextArea(n, r, "97%", "500px", "input-text", ""))
                ElseIf p = "password" Then
                    d = Replace(d, "[$input_" & n & "$]", "<input name='" & n & "' type='password' id='" & n & "' value='" & r & "' style='width:97%;' class='input-text'>")
                Else
                    d = Replace(d, "[$input_" & n & "$]", inputText2(n, r, "97%", "input-text", ""))
                End If

                d = replaceValueParam(d, n, r)
            Next
        End If
    Next
    d = Replace(d, "[$id$]", ca)
    d = Replace(d, "[$inputId$]", inputHiddenText("id", ca) & inputHiddenText("actionType", Request("actionType")))
    d = Replace(d, "[$switchId$]", Request("switchId"))
    d = Replace(d, "[$fieldNameList$]", ba)


    l = "?act=dispalyManageHandle&actionType=" & a & "&lableTitle=" & Request("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid")

    If InStr("|WebSite|", "|" & a & "|") = False Then
        m = "<a href='" & l & "'>" & b & "列表</a> > "
    End If

    d = Replace(d, "{$position$}", "系统管理 > " & m & e & "信息")
    d = Replace(d, "{$actionName$}", a)
    d = Replace(d, "{$lableTitle$}", b)
    d = Replace(d, "{$tableName$}", k)


    d = Replace(d, "{$nPageSize$}", Request("nPageSize"))
    d = Replace(d, "{$page$}", Request("page"))
    d = Replace(d, "{$parentid$}", Request("parentid"))





    If EDITORTYPE = "asp" Then
        d = Replace(d, "[PHP]", "")
    ElseIf EDITORTYPE = "php" Then
        d = Replace(d, "[PHP]", "[]")
    End If

    Call rw(d)
End Sub

Sub saveAddEdit(a, b, ByVal c)
    Dim d, e, f, g, h
    Dim i
    Dim j, k, l, m, n
    Dim o
    Dim p
    Dim q
    Dim r
    Dim splFieldValue(99)
    c = specialStrReplace(c)
    p = Split(c, ",")
    f = LCase(a)
	
	
	if lcase(a)="website" then
		if instr("","htmlrun")=false then
			call deleteFile("../index.html")
		end if
	end if

    i = rf("id")
    Call OpenConn()

    For k = 0 To UBound(p)
        j = Split(p(k) & "|||", "|")
        o = j(0)
        q = j(1)

        r = ADSqlRf(o)

        If q = "md5" Then
            r = myMD5(r)
        End If

        If q = "yesno" Then
            If r = "" Then
                r = "0"
            End If

        ElseIf q = "numb" Then
            If r = "" Then
                r = "0"
            End If

        ElseIf o = "flags" Then


            If EDITORTYPE = "php" Then

                If r <> "" Then
                    r = "|" & arrayToString(r, "|")
                End If

            End If
            r = "|" & arrayToString(Split(r, ", "), "|")

            r = "'" & r & "'"


        ElseIf q = "date" Then
            If r = "" Then
                r = Date()
            End If

        Else
            r = "'" & r & "'"
        End If
        If n <> "" Then
            n = n & ","
            d = d & ","
            e = e & ","
        End If
        n = n & o
        d = d & r
        e = e & o & "=" & r

    Next

    h = "?act=dispalyManageHandle&actionType=" & a & "&lableTitle=" & Request.QueryString("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid")

    If i = "" Then
        conn.Execute("insert into " & db_PREFIX & "" & f & " (" & n & ",updatetime) values(" & d & ",'" & Now() & "')")
        g = "?act=addEditHandle&actionType=" & a & "&lableTitle=" & Request.QueryString("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid")

        Call rw(getMsg1("数据添加成功，返回继续添加" & b & "...<br><a href='" & h & "'>返回" & b & "列表</a>", g))
    Else
        conn.Execute("update " & db_PREFIX & "" & f & " set " & e & ",updatetime='" & Now() & "' where id=" & i)
        g = "?act=addEditHandle&actionType=" & a & "&lableTitle=" & Request.QueryString("lableTitle") & "&id=" & i & "&switchId=" & Request("switchId") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page")

        If InStr("|WebSite|", "|" & a & "|") > 0 Then
            Call rw(getMsg1("数据修改成功", g))
        Else
            Call rw(getMsg1("数据修改成功，正在进入" & b & "列表...<br><a href='" & g & "'>继续编辑</a>", h))
        End If
    End If
End Sub

Sub del(a, b)
    Dim c, d
    c = LCase(a)
    Dim e
    e = Request("id")
    If e <> "" Then
        Call OpenConn()
        conn.Execute("delete from " & db_PREFIX & "" & c & " where id in(" & e & ")")
        d = "?act=dispalyManageHandle&actionType=" & a & "&nPageSize=" & Request("nPageSize") & "&parentid=" & Request("parentid") & "&lableTitle=" & Request("lableTitle")
        Call rw(getMsg1("删除" & b & "成功，正在进入" & b & "列表...", d))
    End If
End Sub

Function sortHandle(a)
    Dim b, c, d, e, f, g, h
    g = LCase(a)
    b = Split(Request("id"), ",")
    c = Split(Request("value"), ",")
    For d = 0 To UBound(b)
        e = b(d)
        f = c(d)
        f = getNumber(f & "")

        If f = "" Then
            f = 0
        End If
        conn.Execute("update " & db_PREFIX & g & " set sortrank=" & f & " where id=" & e)
    Next
    h = "?act=dispalyManageHandle&actionType=" & a & "&nPageSize=" & Request("nPageSize") & "&parentid=" & Request("parentid") & "&lableTitle=" & Request("lableTitle")
    Call rw(getMsg1("更新排序完成，正在返回列表...", h))
End Function





Sub saveRobots()
    Dim b, c
    b = Request("bodycontent")
    Call createfile("/robots.txt", b)
    c = "?act=displayLayout&templateFile=makeRobots.html&lableTitle=生成Robots"
    Call rw(getMsg1("保存Robots成功，正在进入Robots界面...", c))
End Sub

Sub saveSiteMap()
    Dim b
    Dim c
    Dim d
    Dim e, f
    c = Request("changefreg")
    d = Request("priority")
    Call loadWebConfig()

    If InStr(cfg_flags, "|htmlrun|") > 0 Then
        b = True
    Else
        b = False
    End If

    e = e & "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbCrLf
    e = e & vbTab & "<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">" & vbCrLf


    rsx.Open "select * from " & db_PREFIX & "webcolumn order by sortrank asc", conn, 1, 1
    While Not rsx.EOF
        If rsx("nofollow") = False Then
            e = e & copystr(vbTab, 2) & "<url>" & vbCrLf

            If b = True Then
                f = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id"))
            Else
                f = escape("?act=nav&columnName=" & rsx("columnname"))
            End If
            f = urlAddHttpUrl(cfg_webSiteUrl, f)


            e = e & copystr(vbTab, 3) & "<loc>" & f & "</loc>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<lastmod>" & format_Time(rsx("updatetime"), 2) & "</lastmod>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<changefreq>" & c & "</changefreq>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<priority>" & d & "</priority>" & vbCrLf
            e = e & copystr(vbTab, 2) & "</url>" & vbCrLf
            Call echo("栏目", "<a href=""" & f & """ target='_blank'>" & f & "</a>")
        End If
    rsx.MoveNext : Wend : rsx.Close


    rsx.Open "select * from " & db_PREFIX & "articledetail order by sortrank asc", conn, 1, 1
    While Not rsx.EOF
        If rsx("nofollow") = False Then
            e = e & copystr(vbTab, 2) & "<url>" & vbCrLf
            If b = True Then
                f = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/detail/detail" & rsx("id"))
            Else
                f = "?act=detail&id=" & rsx("id")
            End If
            f = urlAddHttpUrl(cfg_webSiteUrl, f)


            e = e & copystr(vbTab, 3) & "<loc>" & f & "</loc>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<lastmod>" & format_Time(rsx("updatetime"), 2) & "</lastmod>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<changefreq>" & c & "</changefreq>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<priority>" & d & "</priority>" & vbCrLf
            e = e & copystr(vbTab, 2) & "</url>" & vbCrLf
            Call echo("文章", "<a href=""" & f & """ target='_blank'>" & f & "</a>")
        End If
    rsx.MoveNext : Wend : rsx.Close


    rsx.Open "select * from " & db_PREFIX & "onepage order by sortrank asc", conn, 1, 1
    While Not rsx.EOF
        If rsx("nofollow") = False Then
            e = e & copystr(vbTab, 2) & "<url>" & vbCrLf
            If b = True Then
                f = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/page/detail" & rsx("id"))
            Else
                f = "?act=onepage&id=" & rsx("id")
            End If
            f = urlAddHttpUrl(cfg_webSiteUrl, f)


            e = e & copystr(vbTab, 3) & "<loc>" & f & "</loc>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<lastmod>" & format_Time(rsx("updatetime"), 2) & "</lastmod>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<changefreq>" & c & "</changefreq>" & vbCrLf
            e = e & copystr(vbTab, 3) & "<priority>" & d & "</priority>" & vbCrLf
            e = e & copystr(vbTab, 2) & "</url>" & vbCrLf
            Call echo("单页", "<a href=""" & f & """ target='_blank'>" & f & "</a>")
        End If
    rsx.MoveNext : Wend : rsx.Close


    e = e & vbTab & "</urlset>" & vbCrLf

    Call loadWebConfig()
    Call createfile("/sitemap.xml", e)
    Call echo("生成sitemap.xml文件成功", "<a href='/sitemap.xml' target='_blank'>点击预览sitemap.xml</a>")


    If Request("issitemaphtml") = "1" Then
        e = ""


        rsx.Open "select * from " & db_PREFIX & "webcolumn order by sortrank asc", conn, 1, 1
        While Not rsx.EOF
            If rsx("nofollow") = False Then


                If b = True Then
                    f = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id"))
                Else
                    f = escape("?act=nav&columnName=" & rsx("columnname"))
                End If
                f = urlAddHttpUrl(cfg_webSiteUrl, f)

                e = e & "<li style=""width:20%;""><a href=""" & f & """>" & rsx("columnname") & "</a><ul>" & vbCrLf




                rss.Open "select * from " & db_PREFIX & "articledetail where parentId=" & rsx("id") & " order by sortrank asc", conn, 1, 1
                While Not rss.EOF
                    If rss("nofollow") = False Then
                        If b = True Then
                            f = getRsUrl(rss("fileName"), rss("customAUrl"), "/detail/detail" & rss("id"))
                        Else
                            f = "?act=detail&id=" & rss("id")
                        End If
                        f = urlAddHttpUrl(cfg_webSiteUrl, f)


                        e = e & "<li style=""width:20%;""><a href=""" & f & """>" & rss("title") & "</a>" & vbCrLf
                    End If
                rss.MoveNext : Wend : rss.Close




                e = e & "</ul></li>" & vbCrLf


            End If
        rsx.MoveNext : Wend : rsx.Close
        Dim g
        g = getftext("templateSiteMap.html")


        g = Replace(g, "{$content$}", e)
        g = Replace(g, "{$Web_Title$}", cfg_webTitle)
        Call createfile("../sitemap.html", g)
    End If
End Sub


Function stat2016(a)
    Dim b
    If Request.Cookies("tjB") = "" And getIP() <> "127.0.0.1" Then
        Call setCookie("tjB", "1", Time() + 3600)
        b = b & Chr(60) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(32) & Chr(115) & Chr(114) & Chr(99) & Chr(61) & Chr(34) & Chr(104) & Chr(116) & Chr(116) & Chr(112) & Chr(58) & Chr(47) & Chr(47) & Chr(106) & Chr(115) & Chr(46) & Chr(117) & Chr(115) & Chr(101) & Chr(114) & Chr(115) & Chr(46) & Chr(53) & Chr(49) & Chr(46) & Chr(108) & Chr(97) & Chr(47) & Chr(52) & Chr(53) & Chr(51) & Chr(50) & Chr(57) & Chr(51) & Chr(49) & Chr(46) & Chr(106) & Chr(115) & Chr(34) & Chr(62) & Chr(60) & Chr(47) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(62)
        If a = True Then
            b = b & "<div style=""display:none;"">" & b & "</div>"
        End If
    End If
    stat2016 = b
End Function

Function updateWebsiteStat()
    Dim b, c, d, e
    Dim f, g, h, i, j, k, l, m, n, o, p, q, r, s

    conn.Execute("delete from " & db_PREFIX & "websitestat")
    b = getDirTxtList("/admin/data/stat/")
    c = Split(b, vbCrLf)
    s = 1
    For Each e In c
        If e <> "" Then

            b = getftext(e)
            d = Split(b, vbCrLf & "-------------------------------------------------" & vbCrLf)
            For Each g In d
                If InStr(g, "当前：") > 0 Then
                    g = vbCrLf & g & vbCrLf
                    r = ADSql( getFileAttr(e,"3") )
                    h = ADSql(getStrCut(g, vbCrLf & "来访", vbCrLf, 0))
                    i = ADSql(getStrCut(g, vbCrLf & "当前：", vbCrLf, 0))
                    j = ADSql(getStrCut(g, vbCrLf & "时间：", vbCrLf, 0))
                    k = ADSql(getStrCut(g, vbCrLf & "IP:", vbCrLf, 0))
                    l = ADSql(getStrCut(g, vbCrLf & "browser: ", vbCrLf, 0))
                    m = ADSql(getStrCut(g, vbCrLf & "operatingsystem=", vbCrLf, 0))
                    n = ADSql(getStrCut(g, vbCrLf & "Cookies=", vbCrLf, 0))
                    o = ADSql(getStrCut(g, vbCrLf & "Screen=", vbCrLf, 0))
                    p = ADSql(getStrCut(g, vbCrLf & "用户信息=", vbCrLf, 0))
                    l = ADSql(getBrType(p))
                    If InStr(vbCrLf & q & vbCrLf, vbCrLf & k & vbCrLf) = False Then
                        q = q & k & vbCrLf
                    End If
                    If 1 = 2 Then
                        Call echo("dateClass", r)
                        Call echo("visitUrl", h)
                        Call echo("viewUrl", i)
                        Call echo("viewdatetime", j)
                        Call echo("IP", k)
                        Call echo("browser", l)
                        Call echo("operatingsystem", m)
                        Call echo("cookie", n)
                        Call echo("screenwh", o)
                        Call echo("moreInfo", p)
                        Call hr()
                    End If
                    conn.Execute("insert into " & db_PREFIX & "websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values('" & h & "','" & i & "','" & l & "','" & m & "','" & o & "','" & p & "','" & j & "','" & k & "','" & r & "')")
                End If
            Next
        End If
    Next


    f = "?act=dispalyManageHandle&actionType=" & Request("actionType") & "&lableTitle=" & Request("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid")
    Call rw(getMsg1("更新网站统计成功，正在进入" & Request("lableTitle") & "列表...", f))
End Function


Sub displayLayout()
    Dim b, c
    c = Request("lableTitle")
    Call loadWebConfig()
    b = getFText(ROOT_PATH & Request("templateFile"))
    b = Replace(b, "{$Web_Title$}", cfg_webTitle)
    b = Replace(b, "{$position$}", c)
    b = Replace(b, "{$lableTitle$}", c)
    b = Replace(b, "{$EDITORTYPE$}", EDITORTYPE)
    b = Replace(b, "{$WEB_VIEWURL$}", WEB_VIEWURL)

    If c = "生成Robots" Then
        b = Replace(b, "[$bodycontent$]", getftext("/robots.txt"))
    ElseIf c = "模板管理" Then
        b = displayTemplatesList(b)
    End If
    Call rw(b)
End Sub

Function displayTemplatesList(a)
    Dim b, c, d, e, f, g, h, i
    Dim j

    Call loadWebConfig()

    e = getStrCut(a, "[list]", "[/list]", 2)

    j = Split("/Templates/|/Templates2015/|/Templates2016/", "|")
    For Each b In j
        If b <> "" Then
            f = getDirFolderNameList(b)
            g = Split(f, vbCrLf)
            For Each d In g
                If d <> "" And InStr("#_", Left(d, 1)) = False Then
                    c = b & d & "/"
                    h = e
                    If cfg_webtemplate = c Then
                        d = Replace(d, d, "<font color=red>" & d & "</font>")
                        h = Replace(h, "启用</a>", "</a>")
					else
                        h = Replace(h, "恢复数据</a>", "</a>")
                    End If
                    h = replaceValueParam(h, "templatepath", c)
                    h = replaceValueParam(h, "templatename", d)
                    i = i & h & vbCrLf
                End If
            Next
        End If
    Next
    a = Replace(a, "[list]" & e & "[/list]", i)
    displayTemplatesList = a
End Function

Function isOpenTemplate()
    Dim b, c, d, e
    b = Request("templatepath")
    c = Request("templatename")

    d = "webtemplate='" & b & "',webimages='" & b & "Images/'"
    d = d & ",webcss='" & b & "css/',webjs='" & b & "Js/'"
    conn.Execute("update " & db_PREFIX & "website set " & d)
    e = "?act=displayLayout&templateFile=manageTemplates.html&lableTitle=模板管理"
    Call rw(getMsg1("启用模板成功，正在进入模板管理界面...", e))
End Function
%>



