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

function XY_DetailBanner(a)
    dim b, c, d, e, f, g, h
    b = RParam(a, "defaultimage")

    c = PubNavDid
    if c = "" then c = PubProDid
    d = PubNavSid
    if d = "" then d = PubProSid
    e = PubProTid
    if e = "" then e = PubProTid

    if PubID <> "" then
        if PubActionType = "MainInfo" then
            f = PubID
        elseIf PubActionType = "Article" then
            g = PubID
        end if
    end if


    if c <> "" then
        rs.open "Select * From [BigClass] Where BigClassName='" & c & "' And ImgPath<>''", conn, 1, 1
        if not rs.eOF then
            h = rs("ImgPath")
        end if : rs.close
    end if

    if d <> "" then
        rs.open "Select * From [SmallClass] Where BigClassName='" & c & "' And SmallClassName='" & d & "' And ImgPath<>''", conn, 1, 1
        if not rs.eOF then
            h = rs("ImgPath")
        end if : rs.close
    end if

    if e <> "" then
        rs.open "Select * From [ThreeClass] Where BigClassName='" & c & "' And SmallClassName='" & d & "' And ThreeClassName='" & e & "' And ImgPath<>''", conn, 1, 1
        if not rs.eOF then
            h = rs("ImgPath")
        end if : rs.close
    end if


    if c <> "" then
        rs.open "Select * From [NavBigClass] Where BigClassName='" & c & "' And ImgPath<>''", conn, 1, 1
        if not rs.eOF then
            h = rs("ImgPath")
        end if : rs.close
    end if

    if d <> "" then
        rs.open "Select * From [NavSmallClass] Where BigClassName='" & c & "' And SmallClassName='" & d & "' And ImgPath<>''", conn, 1, 1
        if not rs.eOF then
            h = rs("ImgPath")
        end if : rs.close
    end if

    if g <> "" and 1 = 2 then
        rs.open "Select * From [Product] Where Id=" & g & " And (BigFiles<>'' Or SmallFiles<>'')", conn, 1, 1
        if not rs.eOF then
            h = IIF(rs("BigFiles") <> "", rs("BigFiles"), rs("SmallFiles"))
        end if : rs.close
    end if

    XY_DetailBanner = IIF(h <> "", h, b)
    XY_DetailBanner = HandleHttpUrl(XY_DetailBanner)

    if 1 = 2 then
        call echo("PubNavDid", PubNavDid)
        call echo("PubNavSid", PubNavSid)
        call echo("PubProDid", PubProDid)
        call echo("PubProSid", PubProSid)
        call echo("PubProTid", PubProTid)

        call echo("PubActionType", PubActionType)
        call echo("PubID", PubID)
        call echo("PubClassName", PubClassName)
        call echo("PubWD", PubWD)
        call echo("ImgUrl", h)
    end if

end function



function BannerSwitch(byVal a, byVal b)
    dim c, d, e, f, g, h
    h = 22
    if lCase(left(a, 4)) = "sql:" then
        e = mid(a, 5)
    else
        e = "Where BigClassName='" & a & "' And Recommend<>0 Order By Sort"
    end if
    d = d & "<div class=""bannerlb pr"" id=""flashs"">" & vbCrLf
    f = "Select * From [Product] " & e
    rs.open f, conn, 1, 1
    for c = 1 to rs.recordCount
        if c > b then exit for

        g = rs("FileName")
        if CheckRemoteUrl(g) = false then
            g = GetHandleUrl(rs("FileName"))
            call WebDebug(g, "act=CreateArticle&ID=" & rs("Id"))
        end if

        ShowTitle = CutStr(rs("Title"), h, "... ")
        ShowTitle = FontColorFontB(ShowTitle, rs("FontB"), rs("FontColor"))

        d = d & "    <div title=""" & ShowTitle & """ alt=""" & ShowTitle & """ onClick=""window.open('" & g & "')"" class=""bgitem"" id=""flashbg" & c - 1 & """  style=""background: url('" & rs("BigFiles") & "') no-repeat scroll center top;" & vbCrLf
        d = d & "height: 496px;cursor:pointer; width: 100%; margin:0 auto;""></div>" & vbCrLf & vbCrLf


    rs.moveNext : next : rs.close


    d = d & "</div> " & vbCrLf

    BannerSwitch = d
end function


function BannerSwitch2(byVal a, byVal b)
    dim c, d
    rs.open "Select * From[Product] Where BigClassName='" & a & "'", conn, 1, 1
    d = d & "<div class=""container"" id=""idTransformView2"">" & vbCrLf
    d = d & "  <ul class=""slider slider2"" id=""idSlider2"">" & vbCrLf
    for c = 1 to b
        if rs.eOF then b = c - 1 : exit for
        d = d & "    <li><img src=""" & rs("BigFiles") & """/></li>" & vbCrLf
    rs.moveNext : next : rs.close
    d = d & "  </ul>" & vbCrLf
    d = d & "  <ul class=""num"" id=""idNum2"">" & vbCrLf

    for c = 1 to b
        d = d & "    <li>" & c & "</li>" & vbCrLf
    next
    d = d & "  </ul>" & vbCrLf
    d = d & "</div>" & vbCrLf
    BannerSwitch2 = d
end function

%>


