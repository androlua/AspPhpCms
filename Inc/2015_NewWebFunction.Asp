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



Function specialStrReplace(ByVal a)
    a = Replace(a, "\|", "[$特殊字符A]$")
    a = Replace(a, "\-", "[$特殊字符B]$")
    a = Replace(a, "\,", "[$特殊字符C]$")
    a = Replace(a, "\'", "[$特殊字符D]$")
    a = Replace(a, "\""", "[$特殊字符E]$")
    specialStrReplace = a
End Function

Function unSpecialStrReplace(ByVal a, b)
    a = Replace(a, "[$特殊字符A]$", b & "|")
    a = Replace(a, "[$特殊字符B]$", b & "-")
    a = Replace(a, "[$特殊字符C]$", b & ",")
    a = Replace(a, "[$特殊字符D]$", b & "'")
    a = Replace(a, "[$特殊字符E]$", b & """")
    unSpecialStrReplace = a
End Function


Function getColumnId(a)
    a = Replace(a, "'", "")
    getColumnId = -1
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where columnName='" & a & "'", conn, 1, 1
    If Not rsx.EOF Then
        getColumnId = rsx("id")
    End If : rsx.Close
End Function



Function getColumnName(a)
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where id=" & a, conn, 1, 1
    If Not rsx.EOF Then
        getColumnName = rsx("columnName")
    End If : rsx.Close
End Function



Function getColumnUrl(a, b)
    Dim c, d
    If b = "name" Then
        d = " where columnname='" & a & "'"
    Else
        d = " where id=" & a & ""
    End If
    rsx.Open "select * from " & db_PREFIX & "webcolumn" & d, conn, 1, 1
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            c = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id"))
        Else
            c = handleWebUrl("?act=nav&columnName=" & rsx("columnname"))
            If rsx("customAUrl") <> "" Then
                c = rsx("customAUrl")
            End If
        End If
    End If : rsx.Close

    getColumnUrl = c
End Function


Function getColumnType(a)
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where id=" & a, conn, 1, 1
    If Not rsx.EOF Then
        getColumnType = rsx("columnType")
    End If : rsx.Close
End Function


Function getColumnBodyContent(a)
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where id=" & a, conn, 1, 1
    If Not rsx.EOF Then
        getColumnBodyContent = rsx("bodyContent")
    End If : rsx.Close
End Function


Function handleColumnType(a)
    Dim b
    Select Case a
        Case "首页" : b = "home"
        Case "文本" : b = "text"
        Case "产品" : b = "product"
        Case "新闻" : b = "news"
        Case "视频" : b = "video"
        Case "下载" : b = "download"
        Case "案例" : b = "case"
        Case "留言" : b = "message"
        Case "反馈" : b = "feedback"
        Case "招聘" : b = "job"
        Case "订单" : b = "order"
    End Select
    handleColumnType = b
End Function

Function displayEditor(a)
    Dim b
    b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shCore.js""></script> " & vbCrLf
    b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushJScript.js""></script>" & vbCrLf
    b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushPhp.js""></script> " & vbCrLf
    b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushVb.js""></script> " & vbCrLf
    b = b & "<link type=""text/css"" rel=""stylesheet"" href=""\Jquery\syntaxhighlighter\styles/shCore.css""/>" & vbCrLf
    b = b & "<link type=""text/css"" rel=""stylesheet"" href=""\Jquery\syntaxhighlighter\styles/shThemeDefault.css""/>" & vbCrLf
    b = b & "<script type=""text/javascript"">" & vbCrLf
    b = b & "    SyntaxHighlighter.config.clipboardSwf = '\Jquery\syntaxhighlighter\scripts/clipboard.swf';" & vbCrLf
    b = b & "    SyntaxHighlighter.all();" & vbCrLf
    b = b & "</script>" & vbCrLf

    displayEditor = b
End Function

Function handleWebUrl(a)
    If Request("gl") <> "" Then
        a = getUrlAddToParam(a, "&gl=" & Request("gl"), "replace")
    End If
    If Request("templatedir") <> "" Then
        a = getUrlAddToParam(a, "&templatedir=" & Request("templatedir"), "replace")
    End If
    handleWebUrl = a
End Function






Function handleDisplayOnlineEditDialog(a, b, c, d)
    Dim e, f, g, h
    If Request("gl") = "edit" Then
        If InStr(a, "&") > 0 Then
            a = a & "&vbgl=true"
        End If
        h = False
        e = getControlStr(a) & """" & c
        If d <> "" Then
            f = Split(d, "|")
            For Each g In f
                If g <> "" And InStr(b, g) > 0 Then
                    b = Replace2(b, g, g & e)
                    h = True
                    Exit For
                End If
            Next
        End If
        If h = False Then






            b = htmlAddAction(b, e)


        End If
    End If
    handleDisplayOnlineEditDialog = b
End Function

Function getControlStr(a)
    If Request("gl") = "edit" Then
        getControlStr = " onMouseMove=""onColor(this,'#FDFAC6','red')"" onMouseOut=""offColor(this,'','')"" onDblClick=""window1('" & a & "','信息修改')"" title='双击在线修改' oncontextmenu=""CommonMenu(event,this,'')"
    End If
End Function


Function htmlAddAction(a, b)
    Dim c, d, e, f, g
    c = a
    c = phptrim(c)
    d = Mid(c, 1, InStr(c, " "))
    e = ">"
    f = True

    g = Trim(LCase(Replace(d, "<", "")))
    If InStr(c, d) = False Or InStr(c, e) = False Or InStr("|a|div|span|font|h1|h2|h3|h4|h5|h6|dt|dd|dl|li|ul|table|tr|td|", "|" & g & "|") = False Then
        f = False
    End If

    If f = True Then
        a = d & b & Right(c, Len(c) - Len(d))
    End If
    htmlAddAction = a
End Function

%>


