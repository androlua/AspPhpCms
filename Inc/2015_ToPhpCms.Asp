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
    XY_PHP_NavList = XY_PHP_GeneralList(a, "nav", "Select * From [v9_category] where parentid=0 and ismenu=1 order by listorder asc")
End Function


Function XY_PHP_DetailList(a)
    XY_PHP_DetailList = XY_PHP_GeneralList(a, "detail", "Select top 6 * From [v9_picture]")
End Function


Function XY_PHP_GeneralList(a, b, c)
    Dim d, e, f, g, h, i, j
    Call HandleFunParameter(a, d, e, f, g, h, i, j)
    Dim k, l, m, n, o, p, q, r
    Dim s
    k = GetDefaultValue(a)
    Dim t
    s = Trim(LCase(RParam(a, "noFollow")))

    rs.Open c, conn, 1, 1

    For l = 1 To rs.RecordCount
        If rs.EOF Then Exit For

        If b = "nav" Then
            r = b & "_" & rs("catid") & ".html"
            d = rs("catname")
            g = rs("catname")

        ElseIf b = "detail" Then
            r = b & "_" & rs("ID") & ".html"
            d = ""
            g = rs("title")
        End If

        If r = WEBURLFILEPATH Then
            p = "[list-focus]" : q = "[/list-focus]"
        Else
            p = "[list-" & l & "]" : q = "[/list-" & l & "]"
        End If

        r = WEBURLPREFIX & r

        For t = 6 To 2 Step - 1
            If InStr(k, p) = False And l Mod t = 0 Then
                p = "[list-mod" & t & "]" : q = "[/list-mod" & t & "]"
                If InStr(k, p) > 0 Then
                    Exit For
                End If
            End If
        Next


        If InStr(k, p) = False Then
            p = "[list]" : q = "[/list]"
        End If

        If InStr(k, p) > 0 And InStr(k, q) > 0 Then
            n = StrCut(k, p, q, 2)
            For m = 1 To 3
                n = ReplaceValueParam(n, "ni", l)
                n = ReplaceValueParam(n, "编号-1", l - 1)
                n = ReplaceValueParam(n, "编号", l)
                n = ReplaceValueParam(n, "bigclassname", d)
                n = ReplaceValueParam(n, "title", g)
                n = ReplaceValueParam(n, "url", r)
            Next



            p = "[list-" & l & " startdialog]" : q = "[/list-" & l & " startdialog]"
            If InStr(k, p) > 0 And InStr(k, q) > 0 Then
                n = StrCut(k, p, q, 2) & n
            End If

            p = "[list-" & l & " enddialog]" : q = "[/list-" & l & " enddialog]"
            If InStr(k, p) > 0 And InStr(k, q) > 0 Then
                n = n & StrCut(k, p, q, 2)
            End If
            o = o & n
        End If
    rs.MoveNext : Next : rs.Close


    p = "[dialog start]" : q = "[/dialog start]"
    If InStr(k, p) > 0 And InStr(k, q) > 0 Then
        o = StrCut(k, p, q, 2) & o
    End If

    p = "[dialog end]" : q = "[/dialog end]"
    If InStr(k, p) > 0 And InStr(k, q) > 0 Then
        o = o & StrCut(k, p, q, 2)
    End If
    XY_PHP_GeneralList = o
End Function



Function XY_PHP_SinglePage(a)
	XY_PHP_SinglePage=XY_PHP_GetFieldValue(a,"select * from [v9_page]","content")
End Function

function XY_PHP_GetFieldValue(a,b,c)
	rs.open b,conn,1,1
	if not rs.eof then
		XY_PHP_GetFieldValue=rs(c)
	else
		XY_PHP_GetFieldValue=GetDefaultValue(a)
	end if:rs.close
end function
%>


















