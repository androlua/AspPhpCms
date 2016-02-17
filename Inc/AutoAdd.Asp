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


Select Case Request("a")
    Case "ayawawa", "wawa" : Call Ayawawa() : Response.End()
    Case "row", "space" : Call HandRowSpace() : Response.End()
    Case "ShowAoutAddList" : Call ShowAoutAddList() : Response.End()
    Case "AutoAddWebInfo" : Call AutoAddWebInfo(Request("DataFolderPath")) : Response.End()
    Case "ClearDatabases" : Call ClearDatabases() : Response.End()
    Case "AddDateViewWebEffect" : Call AddDateViewWebEffect() : Response.End()
End Select


Sub showAoutAddList()
    Dim b, c, d, e, f, g
    d = "/DataDir/自动添加网站信息/"
    Call HandlePath(d)
    Call echo("显示自动添加信息选择列表", d)
    f = GetDirFolderList(d)
    Call echo("清空数据库，方便查看程序是否添加成功", "<a href=?a=ClearDatabases>点击操作</a>")
    Call echo("写入数据查看网站效果", "<a href=?a=AddDateViewWebEffect>点击操作</a>")
    b = Split(f, vbCrLf)
    For Each d In b
        If d <> "" Then
            e = Mid(d, InStrRev(d, "\") + 1)
            g = "?act=AutoAddWebInfo&DataFolderPath=" & d
            Call echo(e, "<a href='" & g & "' target='_self'>" & d & "</a>")
        End If
    Next
End Sub




Sub addDateViewWebEffect()
    Dim b, c, d, e, f, g, h, i, j, k, l
    Dim m, n
    Call OpenConn()
    c = "E:\E盘\WEB网站\网站备份\Datamaiside20141201.mdb"
    Set b = CreateObject("Adodb.Connection")
        b.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & c

        rs.Open "Select * From [NavBigClass] Where (NavType='产品' Or NavType='新闻') Order By NavType", conn, 1, 1
        While Not rs.EOF
            If InStr("|" & d & "|", "|" & rs("BigClassName") & "|") = False Then
                d = d & rs("BigClassName") & "|"
            End If
        rs.MoveNext : Wend : rs.Close


        If 1 = 2 Then
            i = "E:\E盘\WEB网站\网站备份\文章\"
            Call DeleteFolder(i)
            Call CreateFolder(i)
            k = 0
            rs.Open "Select * From [Product] Where Len(Content)>200", b, 1, 1
            While Not rs.EOF
                k = k + 1
                j = i & k & ".txt"
                Call echo("创建文章", j)
                Call CreateFile(j, rs("Content"))
            rs.MoveNext : Wend : rs.Close
            Response.End()
        End If




        h = b.Execute("Select Count(*) From [Product] Where (BigFiles<>'' Or SmallFiles<>'')")(0)
        Call echo("nCount", h)

        rs.Open "Select * From [BigClass]", conn, 1, 1
        While Not rs.EOF
            If InStr("|" & d & "|", "|" & rs("BigClassName") & "|") = False Then
                d = d & rs("BigClassName") & "|"
            End If
        rs.MoveNext : Wend : rs.Close
        l = 0

        f = Split(d, "|")
        For Each g In f
            If g <> "" And Trim(LCase(g)) <> "banner" Then
                Call echo("大类名称", g & "(添加数量" & CopyDateToWebDate(conn, b, g, 18, e, l) & ")")
            End If
        Next
End Sub



Function copyDateToWebDate(a, b, c, d, e, f)
    Dim g, h, i, j, k, l, m, n
    a.Execute("Delete From [Product] Where BigClassName='" & c & "'")
    k = 0
    For g = 1 To d
        n = " Where BigFiles<>'' Or SmallFiles<>''"
        If c = "常见问题" Then
            n = " Where BigFiles='' And SmallFiles=''"

        End If
        rsx.Open "Select * From [Product]", b, 1, 3
        i = True
        While Not rsx.EOF And i = True
            m = False
            If c = "常见问题" And rsx("BigFiles") = "" And rsx("SmallFiles") = "" Then
                m = True
            ElseIf rsx("BigFiles") <> "" Or rsx("SmallFiles") <> "" Then
                m = True
            End If
            If m = True Then
                If InStr("|" & e & "|", "|" & rsx(0) & "|") = False Then
                    e = e & rsx(0) & "|"

                    i = False
                    rss.Open "Select * From [Product]", a, 1, 3
                    rss.AddNew
                    rss("BigClassName") = c
                    rss("Title") = rsx("Title")

                    j = Replace(Trim(rsx("SmallFiles")), "\", "/")
                    If Left(j, 1) = "/" Then j = "http://maiside.net/" & j
                    rss("SmallFiles") = rsx("SmallFiles")

                    j = Replace(Trim(rsx("BigFiles")), "\", "/")
                    If Left(j, 1) = "/" Then j = "http://maiside.net/" & j
                    rss("BigFiles") = j

                    f = f + 1
                    l = rsx("Content")
                    If Len(l) < 200 Then
                        l = GetFText("E:\E盘\WEB网站\网站备份\文章\" & f & ".txt")
                    End If

                    rss("WebTitle") = rsx("WebTitle")
                    rss("WebKeywords") = rsx("WebKeywords")
                    rss("WebDescription") = rsx("WebDescription")

                    rss("FileName") = PinYin(Trim(rsx("Title")), 3)


                    If Len(l) < 255 Then
                        l = l & GetArticleFillContent("", "", 9)
                    End If

                    rss("Content") = l
                    rss("Author") = "站长"
                    rss("ArticleSource") = "本站"
                    k = k + 1
                    rss.Update : rss.Close
                End If
            End If
        rsx.MoveNext : Wend : rsx.Close
    Next
    copyDateToWebDate = k
End Function




Sub clearDatabases()
    Dim b, c
    Call OpenConn()

    rs.Open "Select * From [WebSite]", conn, 1, 3
    If Not rs.EOF Then
        rs("WebTitle") = "网站标题"
        rs("WebKeywords") = "网站关键词"
        rs("WebSiteBottom") = "网站底部"
        rs.Update
    End If : rs.Close

    rs.Open "Select * From [MainInfo]", conn, 1, 3
    For b = 1 To rs.RecordCount
        rs("ShowTitle") = "文本标题(" & b & ")"
        rs("Content") = "文本内容(" & b & ")"
        rs.Update
    rs.MoveNext : Next : rs.Close

    rs.Open "Select * From [Product]", conn, 1, 3
    For b = 1 To rs.RecordCount
        rs("Title") = "信息标题(" & b & ")"
        rs("Content") = "信息内容(" & b & ")"
        If rs("BigFiles") <> "" Then
            rs("BigFiles") = "/UploadFiles/NoImg.jpg"
        End If
        If rs("SmallFiles") <> "" Then
            rs("SmallFiles") = "/UploadFiles/NoImg.jpg"
        End If
        rs("WebTitle") = "网站自定标题(" & b & ")"
        rs("WebKeywords") = "网站关键词(" & b & ")"
        rs("WebDescription") = "网站描述(" & b & ")"
        rs.Update
    rs.MoveNext : Next : rs.Close

    rs.Open "Select * From [NavBigClass]", conn, 1, 3
    For b = 1 To rs.RecordCount

        rsx.Open "Select * From [SmallClass] Where BigClassName='" & rs("BigClassName") & "'", conn, 1, 3
        For c = 1 To rsx.RecordCount
            rsx("BigClassName") = "大导航(" & b & ")"
            rsx("SmallClassName") = "小导航(" & c & ")"
            rsx.Update
        rsx.MoveNext : Next : rsx.Close
        rs("BigClassName") = "大导航(" & b & ")"
        rs.Update
    rs.MoveNext : Next : rs.Close

    rs.Open "Select * From [FriendLink]", conn, 1, 3
    For b = 1 To rs.RecordCount
        rs("Title") = "友链接(" & b & ")"
        rs.Update
    rs.MoveNext : Next : rs.Close

    rs.Open "Select * From [GuestBook]", conn, 1, 3
    For b = 1 To rs.RecordCount
        rs("Content") = "留言内容(" & b & ")"
        rs("Reply") = "回复内容(" & b & ")"
        rs.Update
    rs.MoveNext : Next : rs.Close


    rs.Open "Select * From [SearchCount]", conn, 1, 3
    For b = 1 To rs.RecordCount
        rs("Title") = "搜索词(" & b & ")"
        rs.Update
    rs.MoveNext : Next : rs.Close
    Call echo("操作完成", "空数据库方便调试程序成功")
End Sub




Sub autoAddWebInfo(a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x
    Dim y, z, aa, ba, ca, da, ea, fa, ga, ha, ia
    Dim ja, ka, la, ma, na, oa, pa, qa, ra, sa, ta, ua, va, wa, xa, ya, za
    Dim abb, bbb, cbb, dbb, ebb, fbb, gbb, hbb, ibb
    Dim jbb, kbb, lbb
    Dim mbb
    Dim nbb

    gbb = Now()

    z = HandlePath(a) & "\"
    Call rw("<script type='text/javascript' src='/Skins/Default/Js/MyFunction.Js'></script>")
    Call echo("数据文件夹", z)
    ga = " style='margin-top:10px;width:250px;height:16px;overflow:hidden;background:#ECE9D8;border:1px double #716F64;'"

    conn.Execute("Delete From [NavBigClass]")
    conn.Execute("Delete From [NavSmallClass]")
    conn.Execute("Delete From [BigClass]")
    conn.Execute("Delete From [SmallClass]")
    conn.Execute("Delete From [ThreeClass]")
    conn.Execute("Delete From [Product]")
    conn.Execute("Delete From [MainInfo]")
    conn.Execute("Delete From [SearchCount]")
    conn.Execute("Delete From [Member]")
    conn.Execute("Delete From [GuestBook]")
    conn.Execute("Delete From [FriendLink]")
    conn.Execute("Delete From [Admin]")


    Call DeleteFolder("../UploadFiles/image")
    Call CreateFolder("../UploadFiles/image")


    t = z & "网站配置.ini"
    If checkFile(t) Then
        p = GetFText(t)
        rs.Open "Select * From [WebSite]", conn, 1, 3
        If rs.EOF Then rs.AddNew

        If InStr(p, "WebSiteUrl=") > 0 Then
            rs("WebSiteUrl") = StrCut(p, "WebSiteUrl=", "【End】", 2)
        End If

        If InStr(p, "WebTitle=") > 0 Then
            rs("WebTitle") = StrCut(p, "WebTitle=", "【End】", 2)
        End If

        If InStr(p, "WebKeywords=") > 0 Then
            rs("WebKeywords") = StrCut(p, "WebKeywords=", "【End】", 2)
        End If

        If InStr(p, "WebDescription=") > 0 Then
            rs("WebDescription") = StrCut(p, "WebDescription=", "【End】", 2)
        End If

        If InStr(p, "WebSiteBottom=") > 0 Then
            rs("WebSiteBottom") = StrCut(p, "WebSiteBottom=", "【End】", 2)
        End If

        If InStr(p, "WebTemplate=") > 0 Then
            rs("WebTemplate") = StrCut(p, "WebTemplate=", "【End】", 2)
        End If

        If InStr(p, "WebSkins=") > 0 Then
            rs("WebSkins") = StrCut(p, "WebSkins=", "【End】", 2)
        End If

        If InStr(p, "WebImages=") > 0 Then
            rs("WebImages") = StrCut(p, "WebImages=", "【End】", 2)
        End If

        If InStr(p, "WebCss=") > 0 Then
            rs("WebCss") = StrCut(p, "WebCss=", "【End】", 2)
        End If

        If InStr(p, "WebJs=") > 0 Then
            rs("WebJs") = StrCut(p, "WebJs=", "【End】", 2)
        End If


        rs.Update : rs.Close

        fa = "<div id='WebSite' " & ga & "><span onclick=""OnOffDiv(this,'WebSite')"">添加网站配置</span><br></div>" & vbCrLf
        Call rw(fa)
    End If


    t = z & "后台账号.ini"
    If checkFile(t) Then
        p = GetFText(t)
        c = Split(p, vbCrLf)
        For e = 0 To UBound(c)
            h = c(e)
            If h <> "" And Left(Trim(h), 1) <> "#" Then
                d = Split(h & "||||||", "|")
                va = Trim(d(0))
                wa = d(1)
                If wa = "" Then wa = va
                hbb = d(2)

                rs.Open "Select * From [Admin] Where UserName='" & va & "'", conn, 1, 3
                If rs.EOF Then rs.AddNew
                rs("UserName") = va
                rs("Pwd") = MD5(wa, 2) & MD5(wa, 4)
                rs("QuanXian") = hbb
                rs.Update
                fa = fa & "添加后台账号>>" & va & "<br>"
                rs.Close
            End If
        Next
        fa = "<div id='AdminUser' " & ga & "><span onclick=""OnOffDiv(this,'WebSite')"">添加后台账号</span><br></div>" & vbCrLf
        Call rw(fa)
    Else
        rs.Open "Select * From [Admin] Where UserName='admin'", conn, 1, 3
        va = "admin" : wa = "admin"
        If rs.EOF Then rs.AddNew
        rs("UserName") = va
        rs("Pwd") = MD5(wa, 2) & MD5(wa, 4)
        rs.Update : rs.Close
    End If



    aa = z & "导航/Nav.ini"
    If checkFile(aa) = True Then
        p = GetFText(aa)
        c = Split(p, vbCrLf)
        fa = "<div id='Nav' " & ga & "><span onclick=""OnOffDiv(this,'Nav')"">添加网站导航</span><br>" & vbCrLf
        For e = 0 To UBound(c)
            h = c(e)

            If LCase(Trim(h)) = "#end#" Or LCase(Trim(h)) = "#end" Then
                Exit For
            ElseIf h <> "" And Left(Trim(h), 1) <> "#" Then
                d = Split(h & "||||||||||", "|")

                ba = Trim(d(0))
                ca = Trim(d(1))
                da = Trim(d(2))
                u = Trim(d(3))
                mbb = Trim(d(4))
                ea = Trim(d(5))
                If ca = "" Then ca = "文本"
                If da = "" Then da = e
                k = d(6)
                cbb = d(7)
                cbb = IIF(cbb = "" Or cbb = "1", True, False)

                rs.Open "Select * From [NavBigClass] Where BigClassName='" & ba & "'", conn, 1, 3
                If rs.EOF And ba <> "" Then
                    rs.AddNew
                    rs("BigClassName") = ba
                    rs("NavTop") = True
                    rs("NavType") = ca
                    rs("FileName") = u
                    rs("TemplatePath") = mbb

                    rs("OnHtml") = cbb
                    If k = "NOFolderName" Or k = "NO文件夹" Then
                        k = ""
                    ElseIf d(0) = "网站地图" Then
                        rs("FolderName") = "Sitemap"
                    ElseIf d(1) <> "首页" Then
                        k = IIF(k = "", PinYin(d(0), 3), k)
                        rs("FolderName") = k
                    Else
                        rs("FolderName") = "/"
                    End If



                    If InStr(ea, "NO顶部") > 0 Then rs("NavTop") = False
                    If InStr(ea, "底部") > 0 Then rs("NavButtom") = True
                    If InStr(ea, "左边") > 0 Then rs("NavLeft") = True
                    If InStr(ea, "中间") > 0 Then rs("NavContent") = True
                    If InStr(ea, "右边") > 0 Then rs("NavRight") = True
                    If InStr(ea, "其它") > 0 Then rs("NavOthre") = True


                    If InStr("|产品|新闻|", "|" & ca & "|") > 0 Then
                        Call AutoAddBigClass(d(0))
                    End If
                    p = ba & " 详细信息内容写在这里面<hr>更多....."
                    t = z & "导航/" & ba & ".txt"
                    If checkFile(t) = True Then
                        p = GetFText(t)
                    End If
                    rs("Content") = p
                    rs("Sort") = da
                    fa = fa & "名称=" & ba & "<br>类型=" & ca & "<br>排序=" & da & _
                     "<br>文件夹=" & k & "<br>静态文件名=" & u & "<br>模板=" & mbb & "<br>" & vbCrLf
                    rs.Update


                    t = z & "导航/" & ba & ".ini"
                    If checkFile(t) = True Then
                        p = GetFText(t)
                        ha = Split(p, vbCrLf)
                        For f = 0 To UBound(ha)
                            h = ha(f)
                            If h <> "" And Left(Trim(h), 1) <> "#" Then
                                d = Split(h & "||||||", "|")
                                ia = d(0)
                                u = d(2)
                                mbb = d(3)
                                If da = "" Then da = f
                                rsx.Open "Select * From [NavSmallClass] Where BigClassName='" & ba & "' And SmallClassName='" & ia & "'", conn, 1, 3
                                If rsx.EOF Then
                                    rsx.AddNew
                                    rsx("BigClassName") = ba
                                    rsx("SmallClassName") = ia
                                    rsx("FolderName") = PinYin(ia, 3)
                                    rsx("TemplatePath") = mbb

                                    p = ba & " 详细信息内容写在这里面<hr>更多....."
                                    t = z & "导航/" & ba & "》" & ia & ".txt"
                                    If checkFile(t) = True Then
                                        p = GetFText(t)
                                    End If
                                    rsx("Content") = p
                                    fa = fa & " &nbsp; &nbsp; 添加导航小类 " & ba & "》" & ia & "<br>"
                                    rsx.Update
                                End If : rsx.Close
                            End If
                        Next
                    End If
                    fa = fa & "<hr>" & vbCrLf
                End If : rs.Close
            End If
        Next
    End If
    Call rw(fa & "</div>")




    ma = z & "类别/Class.ini"
    If checkFile(aa) = True Then
        p = GetFText(ma)
        na = Split(p, vbCrLf)
        fa = "<div id='Class' " & ga & "><span onclick=""OnOffDiv(this,'Class')"">添加产品类别</span><br>" & vbCrLf
        For e = 0 To UBound(na)
            h = na(e)
            If h <> "" And Left(Trim(h), 1) <> "#" Then
                d = Split(h & "||||||", "|")
                m = Trim(d(0))
                ka = d(1)
                u = d(2)
                mbb = d(3)
                If ka = "" Then ka = e
                If Left(d(0), 2) = vbTab & vbTab Then
                    lbb = m
                    ra = "Select * From [ThreeClass] Where BigClassName='" & jbb & "' And SmallClassName='" & kbb & "' And ThreeClassName='" & lbb & "'"
                    If u = "" Then u = lbb
                    nbb = copystr("&nbsp;", 8) & lbb
                ElseIf Left(d(0), 1) = vbTab Then
                    kbb = m : lbb = ""
                    ra = "Select * From [SmallClass] Where BigClassName='" & jbb & "' And SmallClassName='" & kbb & "'"
                    If u = "" Then u = kbb
                    nbb = copystr("&nbsp;", 4) & kbb
                Else
                    jbb = m : kbb = "" : lbb = ""
                    ra = "Select * From [BigClass] Where BigClassName='" & jbb & "'"
                    If u = "" Then u = jbb
                    nbb = jbb
                End If
                rs.Open ra, conn, 1, 3
                If rs.EOF Then
                    rs.AddNew
                    If jbb <> "" Then rs("BigClassName") = jbb
                    If kbb <> "" Then rs("SmallClassName") = kbb
                    If lbb <> "" Then rs("ThreeClassName") = lbb
                    rs("Sort") = ka
                    rs("FolderName") = PinYin(u, 3)
                    rs.Update
                    fa = fa & nbb & "<br>"
                End If : rs.Close


            End If
        Next
        Call rw(fa & "</div>")
    End If



    ja = z & "Product\"
    If CheckFolder(ja) = True Then

        fa = "<div id='Product' " & ga & "><span onclick=""OnOffDiv(this,'Product')"">添加Product信息</span><br>" & vbCrLf
        b = Split(GetDirIniList(ja), vbCrLf)
        For Each t In b
            If t <> "" Then
                h = Mid(t, InStrRev(t, "\") + 1) : h = Left(h, Len(h) - 4) & "》》"
                d = Split(h, "》")
                m = d(0) : n = d(1) : o = d(2)

                p = GetFText(t) & vbCrLf
                If InStr(p, "#自动添加大类") > 0 And m <> "" Then
                    Call AutoAddBigClass(m)
                End If
                If InStr(p, "#自动添加小类") > 0 And n <> "" Then
                    Call AutoAddSmallClass(m, n)
                End If
                If InStr(p, "#自动添加子类") > 0 And o <> "" Then
                    Call AutoAddThreeClass(m, n, o)
                End If

                If InStr(p, "========================") > 0 Then
                    c = Split(p, "========================" & vbCrLf)
                Else
                    c = Split(p, vbCrLf)
                End If
                For e = 0 To UBound(c)
                    h = c(e)
                    If h <> "" And Left(Trim(h), 1) <> "#" And h <> vbCrLf Then
                        d = Split(h & "||||||", "|")
                        l = d(0)
                        ka = d(1)
                        la = d(2)
                        mbb = d(3)
                        u = AotuGetProductFileName(l)
                        rs.Open "Select * From [Product] Where BigClassName='" & m & "' And SmallClassName='" & n & "' And ThreeClassName='" & o & "' And Title='" & l & "'", conn, 1, 3
                        If rs.EOF And Trim(l) <> "" Then
                            rs.AddNew
                            rs("BigClassName") = m
                            rs("SmallClassName") = n
                            rs("ThreeClassName") = o
                            rs("Title") = l
                            rs("BigFiles") = la
                            rs("TemplatePath") = mbb
                            rs("FileName") = u
                            p = m & ">>" & n & ">>" & o & ">><p>" & l & " 详细内容信息。"
                            rs("Content") = p
                            rs.Update
                            fa = fa & "大类=" & m & "<br>小类=" & n & "<br>子类=" & o & _
                             "<br>标题=" & l & "<br>静态文件名=" & u & "<br>模板=" & mbb & "<hr>" & vbCrLf
                        End If : rs.Close

                    ElseIf InStr(h, "#导入文件夹#") > 0 Then
                        Call LeadingImage(m, n, o, h)

                    ElseIf InStr(h, "#导入新闻文件夹#") > 0 Then
                        Call LeadingNews(m, n, o, h)
                    End If
                Next
            End If
        Next
        Call rw(fa & "</div>")
    End If



    ja = z & "MainInfo\"
    If CheckFolder(ja) = True Then

        fa = "<div id='MainInfo' " & ga & "><span onclick=""OnOffDiv(this,'MainInfo')"">添加MainInfo信息</span><br>" & vbCrLf
        b = Split(GetDirIniList(ja), vbCrLf)
        For Each t In b
            If t <> "" Then
                p = vbCrLf & GetFText(t) & vbCrLf
                l = Mid(t, InStrRev(t, "\") + 1) : l = Left(l, Len(l) - 4)

                If InStr(p, "WebTitle=") > 0 Then
                    rs("WebTitle") = StrCut(p, "WebTitle=", "【End】", 2)
                End If

                rs.Open "Select * From [MainInfo]", conn, 1, 3
                rs.AddNew
                If InStr(p, vbCrLf & "Title=") > 0 Then
                    l = StrCut(p, vbCrLf & "Title=", "【End】", 2)
                End If
                rs("Title") = l
                If InStr(p, "ShowTitle=") > 0 Then
                    rs("ShowTitle") = StrCut(p, "ShowTitle=", "【End】", 2)
                End If
                If InStr(p, "Sort=") > 0 Then
                    rs("Sort") = StrCut(p, "Sort=", "【End】", 2)
                End If
                If InStr(p, "Content=") > 0 Then
                    rs("Content") = StrCut(p, "Content=", "【End】", 2)
                End If
                rs.Update : rs.Close
                fa = fa & "添加文本【" & l & "】<hr>"

            End If
        Next
        Call rw(fa & "</div>")
    End If



    t = z & "友情链接.ini"
    If checkFile(t) = True Then
        p = GetFText(t)
        c = Split(p, vbCrLf)
        fa = "<div id='FriendLink' " & ga & "><span onclick=""OnOffDiv(this,'FriendLink')"">添加友情链接</span><br>" & vbCrLf
        For e = 0 To UBound(c)
            h = c(e) : i = LCase(Trim(h))

            If i = "#end" Or i = "end" Then
                Exit For
            ElseIf h <> "" And Left(Trim(h), 1) <> "#" Then
                d = Split(h & "||||||", "|")
                l = d(0)
                v = d(1)
                ka = IIF(d(2) = "", e, d(2))
                sa = d(3)
                ta = d(4)
                ua = IIF(d(5) = "", True, d(5))


                rs.Open "Select * From [FriendLink] Where Title='" & l & "'", conn, 1, 3
                If rs.EOF Then
                    rs.AddNew
                    rs("Title") = l
                    rs("Url") = v
                    rs("Sort") = ka
                    rs("ImgPath") = sa
                    rs("Alt") = ta
                    rs("Through") = ua
                    rs("Target") = "_blank"

                    fa = fa & "标题=" & l & "<br>网址=" & v & "<br>排序=" & ka & "<br>" & vbCrLf
                    rs.Update

                    fa = fa & "<hr>" & vbCrLf
                End If : rs.Close
            End If
        Next
        Call rw(fa & "</div>")
    End If



    t = z & "SearchCount.ini"
    If checkFile(t) = True Then
        p = GetFText(t)
        c = Split(p, vbCrLf)
        fa = "<div id='SearchCount' " & ga & "><span onclick=""OnOffDiv(this,'SearchCount')"">添加搜索关键词</span><br>" & vbCrLf
        For e = 0 To UBound(c)
            h = Trim(c(e))
            If h <> "" And Left(Trim(h), 1) <> "#" Then
                d = Split(h & "||||||", "|")
                l = d(0)
                ka = d(1)
                ua = IIF(d(2) = "" Or LCase(d(2)) = "true", 1, 0)
                rs.Open "Select * From [SearchCount] Where Title='" & l & "'", conn, 1, 3
                If rs.EOF Then
                    rs.AddNew
                    rs("Title") = l
                    rs("Sort") = ka
                    rs("Through") = ua
                    rs("Target") = "_blank"

                    fa = fa & "标题=" & l & "<br>网址=" & v & "<br>排序=" & ka & "<br>" & vbCrLf
                    rs.Update

                    fa = fa & "<hr>" & vbCrLf
                End If : rs.Close
            End If
        Next
        Call rw(fa & "</div>")
    End If



    t = z & "Member.ini"
    If checkFile(t) = True Then
        p = GetFText(t)
        c = Split(p, vbCrLf)
        fa = "<div id='Member' " & ga & "><span onclick=""OnOffDiv(this,'Member')"">添加会员</span><br>" & vbCrLf
        For e = 0 To UBound(c)
            h = Trim(c(e))
            If h <> "" And Left(Trim(h), 1) <> "#" Then
                d = Split(h & "||||||", "|")
                va = d(0)
                wa = d(1)
                If wa = "" Then wa = va

                rs.Open "Select * From [Member] Where UserName='" & va & "'", conn, 1, 3
                If rs.EOF Then
                    rs.AddNew
                    rs("UserName") = va
                    rs("Pwd") = MD5(wa, 2) & MD5(wa, 4)

                    fa = fa & "会员：" & va & "<br>" & vbCrLf
                    rs.Update

                    fa = fa & "<hr>" & vbCrLf
                End If : rs.Close
            End If
        Next
        Call rw(fa & "</div>")
    End If



    abb = 0
    c = Split("NavBigClass,NavSmallClass,Bigclass,SmallClass,ThreeClass", ",")
    For Each bbb In c
        rs.Open "Select * From [" & bbb & "] Where ImgPath=''", conn, 1, 3
        While Not rs.EOF

            If bbb = "NavBigClass" Or bbb = "Bigclass" Then
                ibb = Trim(rs("BigClassName"))
            ElseIf bbb = "NavSmallClass" Or bbb = "SmallClass" Then
                ibb = Trim(rs("SmallClassName"))
            ElseIf bbb = "ThreeClass" Then
                ibb = Trim(rs("ThreeClassName"))
            End If

            t = "/Data/WebImg/Banner/" & ibb & ".jpg"

            If checkFile(t) = True Then
                rs("ImgPath") = t

            ElseIf a = "E:\E盘\WEB网站\至前网站\DataDir\自动添加网站信息\麦思德" Then
                rs("ImgPath") = "/Data/WebImg/Banner/麦思德理念.jpg"

            Else
                abb = abb + 1
                If abb > 21 Then abb = Int(abb / 21) + 1
                rs("ImgPath") = "/Skins/YouKou/Index/Banner/Banner" & abb & ".jpg"
            End If
        rs.MoveNext : Wend : rs.Close
    Next

    If a = "E:\E盘\WEB网站\至前网站\DataDir\自动添加网站信息\麦思德" Then
        Call LeadingProductClass("副导航", "汉堡加盟菜单", "", "\DataDir\自动添加网站信息\麦思德\Product\数据\产品\")
        Call LeadingProductClass("副导航", "汉堡培训分类", "", "\DataDir\自动添加网站信息\麦思德\Product\数据\产品\")




        Call echo("当前操作网站", "麦思德")

    Else
        If a = "E:\E盘\WEB网站\至前网站\DataDir\自动添加网站信息\微战略" Then



            Call echo("当前操作网站", "微战略")
        End If

        Call CreateFolder("\UploadFiles\image\Product")

        p = GetDirFileList("/UploadFiles/培训图片/") & CopyStr(vbCrLf, 99)
        c = Split(p, vbCrLf)
        rs.Open "Select * From [ThreeClass] Where BigClassName='产品展示'", conn, 1, 1
        For e = 1 To rs.RecordCount
            qa = " And ThreeClassName='" & rs("ThreeClassName") & "' And Title='" & rs("ThreeClassName") & "'"
            rsx.Open "Select * From [Product] Where BigClassName='" & rs("BigClassName") & "' And SmallClassName='" & rs("SmallClassName") & "' " & qa, conn, 1, 3
            If rsx.EOF Then
                rsx.AddNew
                h = c(e - 1)
                h = Replace(h, Server.MapPath("/"), "")
                rsx("BigClassName") = rs("BigClassName")
                rsx("SmallClassName") = rs("SmallClassName")
                rsx("ThreeClassName") = rs("ThreeClassName")
                rsx("Title") = rs("ThreeClassName")
                rsx("BigFiles") = h
                rsx("FileName") = getRnd(9)
                p = rs("BigClassName") & ">>" & rs("SmallClassName") & ">>" & rs("ThreeClassName") & ">><p>" & rs("ThreeClassName") & " 详细内容信息。"
                rsx("Content") = p
                rsx.Update
            End If : rsx.Close
        rs.MoveNext : Next : rs.Close


        p = GetDirJpgList(z & "\Product\数据\产品\")
        c = Split(p, vbCrLf)
        For Each h In c
            If h <> "" Then
                l = GetFilePathName(h)
                rsx.Open "Select * From [Product] Where Title='" & l & "'", conn, 1, 3
                If rsx.EOF Then rsx.AddNew
                t = Left(h, Len(h) - 4) & ".jpg"
                ebb = "/UploadFiles/image/Product/" & l & ".jpg"
                If checkFile(ebb) = False Then Call CopyFile(t, ebb)
                rsx("BigFiles") = ebb
                p = ""

                fbb = z & "Product\数据\产品\" & h & ".txt"
                If checkFile(fbb) = False Then fbb = z & "Product\数据\产品\默认培训.txt"
                p = p & Replace(Replace(GetFText(fbb), vbCrLf, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
                rsx("Content") = p
                rsx.Update

                rsx.Close

            End If
        Next
    End If

    Call XY_AutoBatchAddArticle("FolderPath='" & z & "\自动批量添加文章信息' ")

    Call echo("自动生成数据文件夹路径", z)
    Call rw(GetTimer())



    If Request("WebDebug") = "True" Then
        Response.Redirect("/Inc/Create_Html.Asp?act=Nav&NavType=首页&Debug=1&MackHtml=False")
    End If
End Sub





Sub leadingImage(a, b, c, d)
    Dim e, f, g, h, i, j, k, l, m
    e = Trim(Replace(d, "#导入文件夹#", ""))
    f = GetDirFileList(e)
    g = Split(f, vbCrLf) : k = 0
    For Each i In g
        If i <> "" Then
            k = k + 1
            i = Replace(i, Server.MapPath("/"), "")
            l = "/UploadFiles/image/" & Mid(i, InStrRev(i, "\") + 1)
            If checkFile(l) = False Then Call CopyFile(i, l)
            rs.Open "Select * From [Product]", conn, 1, 3
            rs.AddNew
            m = GetFilePathName(i)
            rs("BigClassName") = a
            rs("SmallClassName") = b
            rs("ThreeClassName") = c
            rs("Title") = m
            rs("BigFiles") = l
            rs("FileName") = AotuGetProductFileName(m)
            rs.Update : rs.Close
        End If
    Next

End Sub




Sub leadingNews(a, b, c, d)
    Dim e, f, g, h, i, j, k, l
    e = Trim(Replace(d, "#导入新闻文件夹#", ""))
    f = GetDirTxtList(e)
    g = Split(f, vbCrLf) : k = 0
    For Each i In g
        If i <> "" Then
            k = k + 1
            i = Replace(i, Server.MapPath("/"), "")
            rs.Open "Select * From [Product]", conn, 1, 3
            rs.AddNew
            l = GetFilePathName(i)
            rs("BigClassName") = a
            rs("SmallClassName") = b
            rs("ThreeClassName") = c

            rs("Title") = l
            rs("FileName") = AotuGetProductFileName(l)

            f = Replace(GetFText(i), vbCrLf, "<br>")
            rs("Content") = f
            rs.Update : rs.Close
        End If
    Next

End Sub




Sub leadingProductClass(a, b, c, d)
    Dim e, f, g, h, i, j, k, l, m
    m = GetDirFolderList(Trim(d))

    If c = "" Then
        g = Split(m, vbCrLf)
        For Each e In g
            If e <> "" Then
                c = GetFilePathName(e)

                Call LeadingImage(a, b, c, e)
            End If
        Next
    End If
End Sub




Sub classToAddProduct(a, b, c, d)

    Dim e, f


    If b <> "" Then
        f = " Where BigClassName='" & b & "' "
    End If
    If TableCount("SmallClass", f) = 0 Then
        rs.Open "Select * From [BigClass] " & f, conn, 1, 1
        While Not rs.EOF
            rsx.Open "Select * From [Product] Where BigClassName='" & rs("BigClassName") & "'", conn, 1, 3
            If rsx.EOF Then
                rsx.AddNew
                rsx("BigClassName") = rs("BigClassName")
                rsx("Title") = rs("BigClassName")
                e = GetFText(a & "/Product/数据/默认文章.txt")
                e = e & Replace(Replace(e, vbCrLf, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
                rsx("Content") = e
                rsx("FileName") = AotuGetProductFileName(rs("BigClassName"))
                rsx.Update
            End If : rsx.Close
        rs.MoveNext : Wend : rs.Close
    End If

    If c <> "" Then
        f = " And SmallClassName='" & c & "' "
    End If

    If TableCount("ThreeClass", f) = 0 Then

        rs.Open "Select * From [SmallClass] ", f, conn, 1, 1
        While Not rs.EOF
            rsx.Open "Select * From [Product] Where BigClassName='" & rs("BigClassName") & "' And SmallClassName='" & rs("SmallClassName") & "'", conn, 1, 3
            If rsx.EOF Then
                rsx.AddNew
                rsx("BigClassName") = rs("BigClassName")
                rsx("SmallClassName") = rs("SmallClassName")
                rsx("Title") = rs("SmallClassName")
                e = GetFText(a & "/Product/数据/默认文章.txt")
                e = e & Replace(Replace(e, vbCrLf, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
                rsx("Content") = e
                rsx("FileName") = AotuGetProductFileName(rs("SmallClassName"))
                rsx.Update
            End If : rsx.Close
        rs.MoveNext : Wend : rs.Close
    End If

    If d <> "" Then
        f = " And ThreeClassName='" & d & "' "
    End If
    rs.Open "Select * From [ThreeClass] " & f, conn, 1, 1
    While Not rs.EOF
        rsx.Open "Select * From [Product] Where BigClassName='" & rs("BigClassName") & "' And SmallClassName='" & rs("SmallClassName") & "' And ThreeClassName='" & rs("ThreeClassName") & "'", conn, 1, 3
        If rsx.EOF Then
            rsx.AddNew
            rsx("BigClassName") = rs("BigClassName")
            rsx("SmallClassName") = rs("SmallClassName")
            rsx("ThreeClassName") = rs("ThreeClassName")
            rsx("Title") = rs("ThreeClassName")
            e = GetFText(a & "/Product/数据/默认文章.txt")
            e = e & Replace(Replace(e, vbCrLf, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
            rsx("Content") = e
            rsx("FileName") = AotuGetProductFileName(rs("ThreeClassName"))
            rsx.Update
        End If : rsx.Close
    rs.MoveNext : Wend : rs.Close
End Sub








Sub ayawawa()
    Response.AddHeader "Content-Type", "text/html; charset=gb2312"
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n
    l = "E:\E盘\需要文件\ayawawa\"

    If CheckFolder(l) = False Then
        Call CreateFolder(l)
    End If
    f = GetDirFileList("E:\E盘\WEB网站\至前网站\函数\Tools\DataDir\http：揦揦diary。jiayuan。com揦\")
    n = n
    b = Split(f, vbCrLf)
    For Each h In b
        If h <> "" Then
            i = CheckCode(h)
            e = ReadFile(h, 0)

            If InStr(e, "_杨冰阳_世纪佳缘交友网</title>") > 0 Then
                g = StrCut(e, "<title>", "_杨冰阳_", 2)

                k = StrCut(e, "<!-- JiaThis Button END -->" & vbCrLf & "<span>", "</span></h5>", 2)
                k = Format_Time(k, 2)

                j = k & " " & SetFileName(g) & ".txt"
                f = StrCut(e, "<div class=""txt"">", "<span class=""jiathis_txt"">分享到</span>", 2)
                f = Replace(DelHTML(f), "&nbsp;", " ")
                f = DelHtmlNote(f)
                f = unHTMLCode(f)
                m = l & j
                Call CreateFile(m, f)
                n = n + 1
                Call echo("保存成功【" & n & "】", m)
            End If
            doEvents
        End If

    Next
    Response.End()
End Sub




Sub handRowSpace()
    Response.AddHeader "Content-Type", "text/html; charset=gb2312"
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n, o
    l = Server.MapPath("ayawawa\") & "\"

    If CheckFolder(l) = False Then
        Call CreateFolder(l)
    End If
    f = GetDirFileList("E:\E盘\WEB网站\至前网站\ayawawa")

    b = Split(f, vbCrLf)
    For Each h In b
        If h <> "" Then
            i = CheckCode(h)
            e = ReadFile(h, 1)

            e = unHTMLCode(e)
            o = Split(e, vbCrLf) : e = ""
            For Each d In o
                e = e & Trim(d) & vbCrLf
            Next

            j = Mid(h, InStrRev(h, "\"))
            Call echo("创建成功", j)
            m = l & j

            Call CreateFile(h, e)
            doEvents
        End If

    Next
    Response.End()
End Sub




Sub ayawawaSina()
    Response.AddHeader "Content-Type", "text/html; charset=gb2312"
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n
    l = "E:\E盘\需要文件\Ayawawa_Sina\"

    If CheckFolder(l) = False Then
        Call CreateFolder(l)
    End If
    f = GetDirFileList("E:\E盘\WEB网站\至前网站\函数\Tools\DataDir\http：揦揦blog。sina。com。cn揦\")
    n = n
    b = Split(f, vbCrLf)
    For Each h In b
        If h <> "" Then
            i = CheckCode(h)
            e = ReadFile(h, 0)
            g = StrCut(e, "<title>", "</title>", 2)

            If InStr(g, "_ayawawa_") > 0 Then
                g = Mid(g, 1, InStr(g, "_ayawawa_") - 1)
            End If
            If InStr(g, "娃娃微问答") > 0 Or InStr(g, "娃娃微信答") > 0 Then
                g = Replace(g, "&nbsp;", " ")
                g = Mid(g, 11)

            End If
            If InStr(g, "答读者来信") > 0 Then
                g = Mid(g, 7)
            End If
            If InStr(g, "【来信】") > 0 Then
                g = Mid(g, 5)
            End If

            If InStr(e, "<span class=""time SG_txtc"">(") = False Then
                Call echo(h, "没有时间可截取")
            Else
                k = StrCut(e, "<span class=""time SG_txtc"">(", ")</span>", 2)
                k = Format_Time(k, 2)

                j = k & " " & SetFileName(g) & ".txt"
                f = StrCut(e, "<!-- 正文开始 -->", "<!-- 正文结束 -->", 2)
                f = Replace(DelHTML(f), "&nbsp;", " ")
                f = DelHtmlNote(f)
                f = unHTMLCode(f)

                If InStr(f, "我的更多文章：") > 0 Then
                    f = Mid(f, 1, InStrRev(f, "我的更多文章：") - 8)
                End If

                m = l & j
                Call CreateFile(m, f)
                n = n + 1
                Call echo("保存成功【" & n & "】", m)
            End If
            doEvents
        End If

    Next
    Response.End()
End Sub



Sub addLaoLuo()
    Dim b, c, d, e, f, g, h, i, j, k, l, m
    Dim n, o
    b = "E:\E盘\需要文件\学习\好文章\老罗语录.txt"
    h = GetFText(b)
    c = Split(h, "====== 回答记者问 ======")
    n = c(0)
    o = c(1)


    c = Split(n, vbCrLf)
    i = "罗永浩" : j = "语录"
    m = conn.Execute("Select Count(*) From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' ")(0)
    For Each h In c
        h = Trim(h)
        If h <> "" Then
            rs.Open "Select * From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' And Content='" & h & "'", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("BigclassName") = i
                rs("SmallClassName") = j
                m = m + 1
                rs("Title") = m
                rs("Sort") = m
                rs("Content") = h
                Call echo(l, "添加成功")
                rs.Update
            End If : rs.Close
        End If
    Next

    c = Split(o, vbCrLf & vbCrLf)
    i = "罗永浩" : j = "语录"
    m = conn.Execute("Select Count(*) From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' ")(0)
    For Each h In c
        h = Trim(h)
        If Replace(h, vbCrLf, "") <> "" Then
            rs.Open "Select * From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' And Content='" & h & "'", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("BigclassName") = i
                rs("SmallClassName") = j
                m = m + 1
                rs("Title") = m
                rs("Sort") = m
                rs("Content") = h
                Call echo(l, "添加成功")
                rs.Update
            End If : rs.Close
        End If
    Next
End Sub



%>



