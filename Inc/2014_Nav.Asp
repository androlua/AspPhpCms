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


Sub handleWebConfig()
    Dim b, c
    b = IIF(PubNavDid <> "", PubNavDid, PubProDid)

    Call GetNavConfig(b)
    If PubId <> "" Then
        c = "Select * From [Product] Where Id=" & PubId
        rs.Open c, conn, 1, 1
        If Not rs.EOF Then

            Call GetNavConfig(rs("BigClassName"))
            MainNav = rs("BigClassName")
        End If : rs.Close
        Exit Sub
    End If
End Sub

Function getNavConfig(a)
    RsTemp.Open "Select * From [NavBigClass] Where BigClassName='" & a & "'", conn, 1, 1
    If Not RsTemp.EOF Then
        MainNav = RsTemp("BigClassName")
        PubNavType = RsTemp("NavType")
        PubNavDid = MainNav
    End If : RsTemp.Close
End Function

Function getNavType(a)
    RsTemp.Open "Select * From [NavBigClass] Where BigClassName='" & a & "'", conn, 1, 1
    If Not RsTemp.EOF Then
        getNavType = RsTemp("NavType")
    End If : RsTemp.Close
End Function



Function readNavCSS(a, b)
End Function



Function handleNavigation(a, b)
    Dim c, d, e, f, g, h, i, j, k, l, m, n, o
    Dim p, q, r
    Dim s
    Dim t, u
    Dim v



    t = PHPTrim(RParam(a, "styleID"))
    u = PHPTrim(RParam(a, "styleValue"))
    If t <> "" Then
        Call ReadNavCSS(t, u)
    End If


    If checkStrIsNumberType(u) Then
        v = "_" & u
    End If


    If b = "" Then
        b = RParam(a, "AddSql")
    End If

    If b = "" Then
        b = " Where NavTop<>0 Order By Sort Asc"
    End If


    m = "Select * From [NavBigClass]"
    If UserId <> "" Then m = GetWhereAnd(m, " And UserId=" & UserId)
    m = GetWhereAnd(m, b)
    If CheckSql(m) = False Then Call eerr("Sql", m)
    n = LCase(RParam(a, "DropDownMenu"))
    o = LCase(RParam(a, "FocusType"))
    s = LCase(RParam(a, "isConcise"))
    If s = "true" Then
        s = False
    Else
        s = True
    End If


    rs.Open m, conn, 1, 1
    If s = True Then d = d & CopyStr(" ", 4) & "<li class=left></li>" & vbCrLf
    For c = 1 To rs.RecordCount
        g = Trim(rs("FileName"))

        If g <> "" And Right(g, 1) <> "/" And Right(g, 1) <> "\" Then g = g & ".html"
        h = "/" & GetWebFolderName() & rs("FolderName") & "/"
        i = rs("BigClassName")

        f = rs("FileName")
        If CheckMakeHtmlFile(f) = True Then
            f = h & g
            f = Replace(Replace(f, "//", "/"), "//", "/")
            f = FullHttpUrl(host, f)
        End If
        Call WebDebug(f, "act=Nav&NavDid=" & i)
        If InStr("|产品|新闻|下载|", "|" & rs("NavType") & "|") > 0 Then
            Call WebDebug(f, "act=Nav&NavDid=" & i & "&Page=1")
        End If

        k = FontColorFontB(i, rs("FontB"), rs("FontColor"))
        l = rs("Target")
        If PubNavDid = rs("BigClassName") Then
            If o = "a" Then
                e = CopyStr(" ", 8) & "<li class=focus><a " & AHref(f, k, l) & ">" & k & "</a>"
            Else
                e = CopyStr(" ", 8) & "<li class=focus>" & k
            End If
        Else

            e = CopyStr(" ", 8) & "<li><a " & AHref(f, k, l) & ">" & k & "</a>"
        End If

        e = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavBig&Id=" & rs("Id") & "&n=" & getRnd(11), e, "<li")

        d = d & e

        p = ""

        If rs("NavType") = "文本" And n = "true" Then
            rss.Open "Select * From [NavSmallClass] Where BigClassName='" & rs("BigClassName") & "'", conn, 1, 1
            If Not rss.EOF Then

                d = d & vbCrLf & CopyStr(" ", 8) & "<ul>" & vbCrLf & CopyStr(" ", 12)
                For q = 1 To rss.RecordCount
                    g = Trim(rss("FileName"))

                    If g <> "" And Right(g, 1) <> "/" And Right(g, 1) <> "\" Then g = g & ".html"

                    j = rss("SmallClassName")

                    f = rss("FileName")
                    If CheckMakeHtmlFile(f) = True Then
                        f = h & g
                        f = h & "/" & rss("FolderName") & "/" & g
                        f = Replace(Replace(f, "//", "/"), "//", "/")
                        Call WebDebug(f, "act=Nav&NavDid=" & i & "&NavSid=" & j)
                    End If

                    r = FontColorFontB(j, rss("FontB"), rss("FontColor"))
                    l = rss("Target") : l = "_blank"
                    e = "<a " & AHref(f, r, l) & ">" & r & "</a>"

                    e = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavSmall&Id=" & rss("Id") & "&n=" & getRnd(11), e)
                    p = p & CopyStr(" ", 8) & "<li>" & e & "</li>" & vbCrLf

                rss.MoveNext : Next
            End If : rss.Close

        ElseIf rs("NavType") = "产品" And n = "true" Then
            rss.Open "Select * From [SmallClass] Where BigClassName='" & rs("BigClassName") & "'", conn, 1, 1
            If Not rss.EOF Then
                d = d & vbCrLf & CopyStr(" ", 8) & "<ul>" & vbCrLf & CopyStr(" ", 12)
                For q = 1 To rss.RecordCount
                    g = Trim(rss("FileName"))

                    If g <> "" And Right(g, 1) <> "/" And Right(g, 1) <> "\" Then g = g & ".html"
                    j = rss("SmallClassName")

                    f = rss("FileName")
                    If CheckMakeHtmlFile(f) = True Then
                        f = h & g
                        f = h & "/" & rss("FolderName") & "/" & g
                        f = Replace(Replace(f, "//", "/"), "//", "/")
                        Call WebDebug(f, "act=CreateClass&ProDid=" & i & "&ProSid=" & j & "&Page=1")
                    End If

                    r = FontColorFontB(j, rss("FontB"), rss("FontColor"))
                    l = rss("Target") : l = "_blank"
                    e = "<a " & AHref(f, r, l) & ">" & r & "</a>"
                    e = DisplayOnlineEditDialog(""& adminDir &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & rss("Id") & "&n=" & getRnd(11), e)
                    p = rtrimVBcrlf(p) & vbCrLf & CopyStr(" ", 12) & "<li>" & e & "</li>" & vbCrLf
                rss.MoveNext : Next
            End If : rss.Close
        End If
        If p <> "" Then d = d & p & "</ul>" & vbCrLf


        d = d & CopyStr(" ", 8) & "</li>" & vbCrLf

        If s = True Then d = d & CopyStr(" ", 8) & "<li class=line></li>" & vbCrLf
    rs.MoveNext : Next : rs.Close
    If s = True Then d = d & CopyStr(" ", 8) & "<li class=right></li>" & vbCrLf

    If t <> "" Then
        d = "<ul class='nav" & t & v & "'>" & vbCrLf & d & vbCrLf & "</ul>" & vbCrLf
    End If

    handleNavigation = d
End Function

Function divTopNavigation(a, b)
    Dim c, d, e, f, g, h, i, j, k, l
    l = "Select * From [NavBigClass]"
    If UserId <> "" Then l = GetWhereAnd(l, " And UserId=" & UserId)
    l = GetWhereAnd(l, b)
    If CheckSql(l) = False Then Call eerr("Sql", l)
    rs.Open l, conn, 1, 1
    d = d & "<li class=left></li>" & vbCrLf
    For c = 1 To rs.RecordCount
        g = rs("FileName")
        If g <> "" And Right(g, 1) <> "/" Then g = g & ".html"
        h = "/" & GetWebFolderName() & rs("FolderName") & "/"
        i = rs("BigClassName")

        f = rs("FileName")
        If CheckRemoteUrl(f) = False Then
            f = h & g
            f = Replace(Replace(f, "//", "/"), "//", "/")
            f = FullHttpUrl(host, f)
            Call WebDebug(f, "act=Nav&NavDid=" & i)
        End If

        j = FontColorFontB(i, rs("FontB"), rs("FontColor"))
        k = rs("Target")
        If a = rs("BigClassName") Then
            d = d & "<li class=focus>" & j & "</li>" & vbCrLf
        Else
            d = d & "<li><a " & AHref(f, j, k) & ">" & j & "</a></li>" & vbCrLf
        End If
        d = d & "<li class=line></li>" & vbCrLf
    rs.MoveNext : Next : rs.Close
    d = d & "<li class=right></li>" & vbCrLf
    divTopNavigation = d
End Function

Function webFootNavigation(a)
    Dim b, c, d, e, f, g, h, i, j
    j = "Select * From [NavBigClass] "
    If UserId <> "" Then j = GetWhereAnd(j, " And UserId=" & UserId)
    j = GetWhereAnd(j, a)
    rs.Open j, conn, 1, 1
    For b = 1 To rs.RecordCount
        e = rs("FileName")
        If e <> "" And Right(e, 1) <> "/" Then e = e & ".html"

        f = "/" & rs("FolderName") & "/"
        h = FontColorFontB(g, rs("FontB"), rs("FontColor"))
        i = rs("Target")
        g = rs("BigClassName")

        d = rs("FileName")
        If CheckRemoteUrl(d) = False Then
            d = f & e
            d = Replace(Replace(d, "//", "/"), "//", "/")
            Call WebDebug(d, "act=Nav&NavDid=" & g)
        End If

        c = c & "<a " & AHref(d, h, i) & ">" & h & "</a>"
        If b <> rs.RecordCount Then c = c & " &nbsp;| &nbsp; "
    rs.MoveNext : Next : rs.Close
    webFootNavigation = c
End Function


Function getNavTypeInName(a)
    If LCase(a) = "home" Then a = "首页"
    getNavTypeInName = GetNavParam("NavBigClass", "BigClassName", "Where NavType='" & a & "'")
End Function

Function getNavParam(ByVal a, ByVal b, ByVal c)
    Dim d, e, f, g
    d = "Select * From [" & a & "] " & c
    TempRs.Open d, conn, 1, 1
    If Not TempRs.EOF Then

        If b = "[url]" Then
            e = TempRs("FileName")
            If e <> "" And Right(e, 1) <> "/" Then e = e & ".html"
            g = "/" & GetWebFolderName() & TempRs("FolderName") & "/"

            f = TempRs("FileName")
            If CheckRemoteUrl(f) = False Then
                f = g & e
                f = Replace(Replace(f, "//", "/"), "//", "/")
                f = FullHttpUrl(host, f)
                Call WebDebug(f, "act=Nav&NavDid=" & rs("BigClassName"))
            End If

            getNavParam = f
        ElseIf b <> "" Then
            getNavParam = TempRs(b)
        End If
    End If : TempRs.Close
End Function






Function XY_CustomNavList(a)
    Dim b, c, d, e, f, g, h
    Call HandleFunParameter(a, b, c, d, e, f, g, h)
    Call XY_AutoAddHandle(a)
    Dim i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    Dim aa
    Dim ba
    Dim ca
    Dim da
    Dim ea
    i = GetDefaultValue(a)
    Dim fa, ga, ha, ia
    Dim ja
    Dim ka
    Dim la
    Dim ma, na
    Dim oa, pa

    ea = Trim(LCase(RParam(a, "noFollow")))
    z = "Select * From [NavBigClass] Where NavTop<>0 Order By Sort Asc"

    rs.Open z, conn, 1, 1

    For j = 1 To rs.RecordCount
        If rs.EOF Then Exit For
        If rs("BigClassName") = PubNavDid Then
            n = "[list-focus]" : o = "[/list-focus]"
        Else
            n = "[list-" & j & "]" : o = "[/list-" & j & "]"
        End If

        For ka = 6 To 2 Step - 1
            If InStr(i, n) = False And j Mod ka = 0 Then
                n = "[list-mod" & ka & "]" : o = "[/list-mod" & ka & "]"
                If InStr(i, n) > 0 Then

                    Exit For
                End If
            End If
        Next


        If InStr(i, n) = False Then
            n = "[list]" : o = "[/list]"
        End If



        If InStr(i, n) > 0 And InStr(i, o) > 0 Then
            l = StrCut(i, n, o, 2)


            pa = Trim(rs("FileName"))

            If pa <> "" And Right(pa, 1) <> "/" And Right(pa, 1) <> "\" Then pa = pa & ".html"
            oa = "/" & GetWebFolderName() & rs("FolderName") & "/"
            b = rs("BigClassName")

            p = rs("FileName")
            If CheckMakeHtmlFile(p) = True Then
                p = oa & pa
                p = Replace(Replace(p, "//", "/"), "//", "/")
                p = FullHttpUrl(host, p)
            End If

            If rs("CustomAUrl") <> "" Then
                p = rs("CustomAUrl")
            Else
                Call WebDebug(p, "act=Nav&NavDid=" & b)
            End If

            If InStr("|产品|新闻|下载|", "|" & rs("NavType") & "|") > 0 Then
                Call WebDebug(p, "act=Nav&NavDid=" & b & "&Page=1")
            End If

            q = AHref(p, rs("BigClassName"), rs("Target"))

            r = "<a " & AHref(p, rs("BigClassName"), rs("Target")) & SetHtmlParam(a, "aclass") & IIF(ea = "true", " rel='nofollow'", "") & ">" & t & "</a>" & vbCrLf


            ba = rs("WebDescription")

            t = CutStr(rs("BigClassName"), g, "... ")
            t = FontColorFontB(t, rs("FontB"), rs("FontColor"))



            For k = 1 To 3
                l = ReplaceValueParam(l, "ni", j)
                l = ReplaceValueParam(l, "编号-1", j - 1)
                l = ReplaceValueParam(l, "编号", j)






                l = ReplaceValueParam(l, "bigclassname", rs("BigClassName"))
                l = ReplaceValueParam(l, "title", rs("BigClassName"))
                l = ReplaceValueParam(l, "showtitle", t)
                l = ReplaceValueParam(l, "url", p)
                l = ReplaceValueParam(l, "aurl", q)
                l = ReplaceValueParam(l, "astr", r)
            Next

            p = ""& adminDir &"Product.Asp?act=ShowEditProduct&Id=" & rs("Id") & "&n=" & getRnd(11)


            l = DisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavBig&Id=" & rs("Id") & "&n=" & getRnd(11), l)



            n = "[list-" & j & " startdialog]" : o = "[/list-" & j & " startdialog]"
            If InStr(i, n) > 0 And InStr(i, o) > 0 Then
                l = StrCut(i, n, o, 2) & l
            End If

            n = "[list-" & j & " enddialog]" : o = "[/list-" & j & " enddialog]"
            If InStr(i, n) > 0 And InStr(i, o) > 0 Then
                l = l & StrCut(i, n, o, 2)
            End If
            m = m & l
        End If
    rs.MoveNext : Next : rs.Close


    n = "[dialog start]" : o = "[/dialog start]"
    If InStr(i, n) > 0 And InStr(i, o) > 0 Then
        m = StrCut(i, n, o, 2) & m
    End If

    n = "[dialog end]" : o = "[/dialog end]"
    If InStr(i, n) > 0 And InStr(i, o) > 0 Then
        m = m & StrCut(i, n, o, 2)
    End If
    XY_CustomNavList = m
End Function

%>


