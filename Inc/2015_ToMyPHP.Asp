<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-24
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<% 
'与php通用   我的后台

'加载文件
Function XY_Include(action)
    Dim templateFilePath, Block, startStr, endStr, content 
    templateFilePath = LCase(RParam(action, "File")) 
    Block = LCase(RParam(action, "Block")) 

    Dim findstr, replaceStr                                                         '查找字符，替换字符
    findstr = RParam(action, "findstr") 
    replaceStr = RParam(action, "replacestr") 

    templateFilePath = HandleFileUrl(templateFilePath)                              '处理文件路径
    If checkFile(templateFilePath) = False Then
        templateFilePath = webTemplate & templateFilePath 
    End If 
    content = GetFText(templateFilePath) 
    If Block <> "" Then
        startStr = "<!--#" & Block & " start#-->" 
        endStr = "<!--#" & Block & " end#-->" 
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            content = StrCut(content, startStr, endStr, 2) 
        End If 
    End If 
    '替换读出来的内容
    If findstr <> "" Then
        content = Replace(content, findstr, replaceStr) 
    End If 

    XY_Include = content 
End Function 

'显示栏目列表
Function XY_AP_ColumnList(action)
    Dim sql 
    sql = RParam(action, "sql") 
    If sql = "" Then
        sql = "select * from " & db_PREFIX & "webcolumn where flags like'%top%' order by sortRank asc" 
    End If 
    sql = replaceGlobleVariable(sql) 
    XY_AP_ColumnList = XY_AP_GeneralList(action, "WebColumn", sql) 
End Function 

'显示评论列表
Function XY_AP_CommentList(action)
    Dim sql, itemID 
    sql = RParam(action, "sql") 
    itemID = RParam(action, "itemID") 
    itemID = replaceGlobleVariable(itemID) 
    'call eerr("itemID",itemID)

    If sql = "" Then
        sql = "select * from " & db_PREFIX & "TableComment where itemID=" & itemID & " and through=1 order by adddatetime asc" 
    End If 
    sql = replaceGlobleVariable(sql) 
    XY_AP_CommentList = XY_AP_GeneralList(action, "TableComment", sql) 
End Function 

'显示文章列表
Function XY_AP_ArticleList(action)
    Dim sql, addSql, columnName, columnId, topNumb, idRand, splStr, s, columnIdList 

    'action = Replace(action, "[$detailTitle$]", gbl_detailTitle)               '处理当前标题
    action = replaceGlobleVariable(action)                                          '处理下替换标签

    'call echo(gbl_detailTitle,action)
    sql = RParam(action, "sql") 
    topNumb = RParam(action, "topNumb") 
    If sql = "" Then
        If topNumb <> "" Then
            topNumb = " top " & topNumb & " " 
        End If 
        sql = "Select " & topNumb & "* From " & db_PREFIX & "ArticleDetail" 
    End If 
    'id随机
    idRand = LCase(RParam(action, "rand")) 
    If idRand = "true" Or idRand = "1" Then
        sql = sql & " where id in(" & getRandArticleId("", topNumb) & ")" 
    End If 

    '栏目名称 对栏目数组处理如 模板分享下载[Array]CSS3[Array]HTML5
    s = RParam(action, "columnName") 
    If s <> "" Then
        splStr = Split(s, "[Array]") 
        For Each columnName In splStr
            columnId = getColumnId(columnName) 
            If columnId <> "" Then
                If columnIdList <> "" Then
                    columnIdList = columnIdList & "," 
                End If 
                columnIdList = columnIdList & columnId 
            End If 
        Next 
    End If 
    If columnIdList <> "" Then
        sql = getWhereAnd(sql, "where parentId in(" & columnIdList & ")") 
    End If 
    '追加sql
    addSql = RParam(action, "addSql") 
    If addSql <> "" Then
        sql = getWhereAnd(sql, addSql) 
    End If 
    sql = replaceGlobleVariable(sql) 
    'call echo(RParam(action, "columnName") ,sql)
    XY_AP_ArticleList = XY_AP_GeneralList(action, "ArticleDetail", sql) 
End Function 
'显示搜索统计
Function XY_AP_SearchStatList(action)
    Dim sql, addSql, topNumb 

    topNumb = RParam(action, "topNumb") 
    If sql = "" Then
        If topNumb <> "" Then
            topNumb = " top " & topNumb & " " 
        End If 
        sql = "Select " & topNumb & "* From " & db_PREFIX & "SearchStat" 
    End If 
    '追加sql
    addSql = RParam(action, "addSql") 
    If addSql <> "" Then
        sql = getWhereAnd(sql, addSql) 
    End If 
    sql = replaceGlobleVariable(sql) 
    'call eerr("sql",sql)
    XY_AP_SearchStatList = XY_AP_GeneralList(action, "SearchStat", sql) 
End Function 

'通用信息列表
Function XY_AP_GeneralList(action, tableName, sql)
    Dim title, topNumb, addSql, isB, abcolor 
    Dim columnName, columnEnName, simpleIntroduction, bodyContent, showTitle 
    Dim bannerImage, smallImage, bigImage, id 
    Dim defaultStr, i, j, s, c, startStr, endStr, url 
    Dim noFollow                                                                    '不追踪 20141222
    defaultStr = GetDefaultValue(action)                                            '获得默认内容
    Dim modI                                                                        '余循环20150112
    noFollow = Trim(LCase(RParam(action, "noFollow")))                              '不追踪
    Dim lableTitle                                                                  '标题标题
    Dim target                                                                      'a链接打开目标方式
    Dim adddatetime                                                                 '添加时间
    Dim isFocus 
    Dim fieldNameList                                                               '字段列表
    Dim splFieldName, fieldName, replaceStr, k 

    fieldNameList = LCase(getFieldList(db_PREFIX & tableName)) 
    splFieldName = Split(fieldNameList, ",") 

    'call echo("sql",sql)
    rs.Open sql, conn, 1, 1 
    '加强处理
    topNumb = RParam(action, "topNumb") 
    If topNumb = "" Then
        topNumb = rs.RecordCount 
    Else
        topNumb = CInt(topNumb) 
    End If 
    If topNumb > rs.RecordCount Then
        topNumb = rs.RecordCount 
    End If 
    For i = 1 To topNumb
        If rs.EOF Then Exit For 
        isFocus = False                                                                 '交点为假

        id = rs("id") 
        '【导航】
        If tableName = "WebColumn" Then
            If isMakeHtml = True Then
                url = getRsUrl(rs("fileName"), rs("customAUrl"), "/nav" & rs("id")) 
            Else
                url = handleWebUrl("?act=nav&columnName=" & rs("columnname"))               '会追加gl等参数
                If rs("customAUrl") <> "" Then
                    url = rs("customAUrl") 
                End If 
            End If 
            '全局栏目名称为空则为自动定位首页 追加(20160128)
            If gbl_columnName = "" And rs("columnType") = "首页" Then
                gbl_columnName = rs("columnName") 
            End If 
            If rs("columnName") = gbl_columnName Then
                isFocus = True 
            End If 


        '【文章】
        ElseIf tableName = "ArticleDetail" Then
            If isMakeHtml = True Then
                url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id")) 
            Else
                url = handleWebUrl("?act=detail&id=" & rs("id"))                            '会追加gl等参数
                If rs("customAUrl") <> "" Then
                    url = rs("customAUrl") 
                End If 
            End If 
            'A链接添加颜色
            abcolor = "" 
            If rs("titlecolor") <> "" Then
                abcolor = "color:" & rs("titlecolor") & ";" 
            End If 
            If InStr(rs("flags"), "|b|") > 0 Then
                abcolor = abcolor & "font-weight:bold;" 
            End If 
            If abcolor <> "" Then
                abcolor = " style=""" & abcolor & """" 
            End If 
        ElseIf tableName = "TableComment" Then
            'call eerr("defaultStr",defaultStr)

        End If 

        '网址判断
        If url = WEBURLFILEPATH Or isFocus = True Then
            startStr = "[list-focus]" : endStr = "[/list-focus]" 
        Else
            startStr = "[list-" & i & "]" : endStr = "[/list-" & i & "]" 
        End If 

        '在最后时排序当前交点20160202
        If i = topNumb And isFocus = False Then
            startStr = "[list-end]" : endStr = "[/list-end]" 
        End If 

        '例[list-mod2]  [/list-mod2]    20150112
        For modI = 6 To 2 Step - 1
            If InStr(defaultStr, startStr) = False And i Mod modI = 0 Then
                startStr = "[list-mod" & modI & "]" : endStr = "[/list-mod" & modI & "]" 
                If InStr(defaultStr, startStr) > 0 Then
                    Exit For 
                End If 
            End If 
        Next 

        '没有则用默认
        If InStr(defaultStr, startStr) = False Then
            startStr = "[list]" : endStr = "[/list]" 
        End If 



        If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
            s = StrCut(defaultStr, startStr, endStr, 2) 
            For j = 1 To 3
                s = handleReplaceValueParam(s, "ni", i)                                         '不对为i，因为i会与imgurl冲突 [$i$]
                s = handleReplaceValueParam(s, "编号-1", i - 1)                                 '不对为i，因为i会与imgurl冲突 [$i$]
                s = handleReplaceValueParam(s, "编号", i)                                       '不对为i，因为i会与imgurl冲突 [$i$]
                s = Replace(s, "[$id$]", rs("id")) 
                s = Replace(s, "[$url$]", url) 

                For k = 0 To UBound(splFieldName)
                    If splFieldName(k) <> "" Then
                        fieldName = splFieldName(k) 
                        replaceStr = rs(fieldName) & "" 

                        s = replaceValueParam(s, fieldName, replaceStr) 
                    End If 
                Next 
                s = replaceValueParam(s, "abcolor", abcolor) 
            Next 


            '开始位置加Dialog内容
            startStr = "[list-" & i & " startdialog]" : endStr = "[/list-" & i & " startdialog]" 
            If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
                s = StrCut(defaultStr, startStr, endStr, 2) & s 
            End If 
            '结束位置加Dialog内容
            startStr = "[list-" & i & " enddialog]" : endStr = "[/list-" & i & " enddialog]" 
            If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
                s = s & StrCut(defaultStr, startStr, endStr, 2) 
            End If 

            '加控制
            '【导航】
            If tableName = "WebColumn" Then
                url = WEB_ADMINURL & "?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=" & rs("id") & "&n=" & getRnd(11) 
            '【文章】
            ElseIf tableName = "ArticleDetail" Then
                url = WEB_ADMINURL & "?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11) 
            End If 
            s = HandleDisplayOnlineEditDialog(url, s, "", "div|li|span") 
            c = c & s 
        End If 
    rs.MoveNext : Next : rs.Close 

    '开始内容加Dialog内容
    startStr = "[dialog start]" : endStr = "[/dialog start]" 
    If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
        c = StrCut(defaultStr, startStr, endStr, 2) & c 
    End If 
    '结束内容加Dialog内容
    startStr = "[dialog end]" : endStr = "[/dialog end]" 
    If InStr(defaultStr, startStr) > 0 And InStr(defaultStr, endStr) > 0 Then
        c = c & StrCut(defaultStr, startStr, endStr, 2) 
    End If 
    XY_AP_GeneralList = c 
End Function 



'获得文本内容 这个是干什么用得？？？20150121           改进加在线管理(20160127)
Function XY_AP_SinglePage(action)
    Dim title, url, content, id, sql, fieldName 
    fieldName = RParam(action, "fieldname")                                         '字段名称
    If fieldName = "" Then
        fieldName = "bodycontent" 
    End If 
    title = RParam(action, "title")                                                 '获得标题
    content = GetDefaultValue(action)                                               '获得默认内容
    sql = "select * from " & db_PREFIX & "onepage where title='" & title & "'" 
    rs.Open sql, conn, 1, 1 
    If rs.EOF Then
        '自动添加 20160113
        If RParam(action, "autoadd") = "true" Then
            conn.Execute("insert into " & db_PREFIX & "onepage (title,displaytitle," & fieldName & ") values('" & title & "','" & title & "','" & ADSql(content) & "')") 
        End If 
    Else
        id = rs("id") 
        content = rs(fieldName) 
    End If : rs.Close 
    If id = "" Then
        id = XY_AP_GetFieldValue("", sql, "id") 
    End If 
    url = WEB_ADMINURL & "?act=addEditHandle&actionType=OnePage&lableTitle=单页管理&nPageSize=10&page=&switchId=2&id=" & id & "&n=" & getRnd(11) 
    If Request("gl") = "edit" Then
        content = "<span>" & content & "</span>" 
    End If 

    content = HandleDisplayOnlineEditDialog(url, content, "", "span") 
    XY_AP_SinglePage = content 
End Function 
'获得导航内容
Function XY_AP_GetColumnContent(action)
    Dim columnname, url, content, id, sql, fieldName 
    fieldName = RParam(action, "fieldname")                                         '字段名称
    If fieldName = "" Then
        fieldName = "bodycontent" 
    End If 
    columnname = RParam(action, "columnname")                                       '栏目名称
    content = GetDefaultValue(action)                                               '获得默认内容
    sql = "select * from " & db_PREFIX & "webcolumn where columnname='" & columnname & "'" 
    rs.Open sql, conn, 1, 1 
    If Not rs.EOF Then
        id = rs("id") 
        content = rs(fieldName) 
    End If : rs.Close 
    If id = "" Then
        id = XY_AP_GetFieldValue("", sql, "id") 
    End If 
    url = WEB_ADMINURL & "?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&switchId=2&id=" & id & "&n=" & getRnd(11) 
    If Request("gl") = "edit" Then
        content = "<span>" & content & "</span>" 
    End If 

    content = HandleDisplayOnlineEditDialog(url, content, "", "span") 
    XY_AP_GetColumnContent = content 
End Function 

'获得单个字段内容
Function XY_AP_GetFieldValue(action, sql, fieldName)
    Dim title, content 
    rs.Open sql, conn, 1, 1 
    If Not rs.EOF Then
        content = rs(fieldName) 
    End If : rs.Close 
    XY_AP_GetFieldValue = content 
End Function 

'布局20151231
Function XY_Layout(action)
    Dim layoutName, s, c 
    layoutName = RParam(action, "layoutname") 
    rs.Open "select * from " & db_PREFIX & "weblayout where layoutname='" & layoutName & "'", conn, 1, 1 
    If Not rs.EOF Then
        XY_Layout = rs("bodycontent") 
    End If : rs.Close 
    'rs.open"select * from webmodule where moduletype='"& layoutname &"'",conn,1,1
    'while not rs.eof
    'c=c & rs("bodycontent")
    'rs.movenext:wend:rs.close
'XY_Layout=c
End Function 
'模块20151231
Function XY_Module(action)
    Dim moduleName, s, c 
    moduleName = RParam(action, "modulename") 
    rs.Open "select * from " & db_PREFIX & "webmodule where modulename='" & moduleName & "'", conn, 1, 1 
    If Not rs.EOF Then
        XY_Module = rs("bodycontent") 
    End If : rs.Close 
End Function 
'Js版网站统计
Function XY_JsWebStat(action)
    Dim s, fileName 
    fileName = Trim(RParam(action, "fileName")) 
    If fileName = "" Then
        fileName = "[$WEB_VIEWURL$]?dataact=WebStat" 
    End If 
    fileName = Replace(fileName, "/", "\/") 
    s = "<script>document.writeln(""<script src=\'" & fileName & "&GoToUrl=""" 
    s = s & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)" 
    s = s & "+""&co=""+escape(document.cookie)"                                 '收集cookie 不需要则屏蔽掉
    s = s & "+"" \'><\/script>"");</script>" 
    XY_JsWebStat = s 
End Function 


'显示包裹块20160127
Function XY_DisplayWrap(ByVal action)
    Dim content 
    content = GetDefaultValue(action) 
    XY_DisplayWrap = content 
End Function 
'获得栏目Url20160126
Function XY_GetColumnUrl(action)
    Dim columnName, url 
    columnName = RParam(action, "columnName") 
    url = getColumnUrl(columnName, "name") 
    If Request("gl") <> "" Then
        url = url & "&gl=" & Request("gl") 
    End If 
    XY_GetColumnUrl = url 
End Function 
'获得单页Url20160128
Function XY_GetOnePageUrl(action)
    Dim title, url 
    title = RParam(action, "title") 
    url = getOnePageUrl(title) 
    If Request("gl") <> "" Then
        url = url & "&gl=" & Request("gl") 
    End If 
    XY_GetOnePageUrl = url 
End Function 
'获得标签内容 测试
Function XY_getLableValue(action)
    Dim title, content, c 
    'call echo("Action",Action)
    title = RParam(action, "title") 
    content = RParam(action, "content") 
    c = c & "title=" & GetContentRunStr(title) & "<hr>" 
    c = c & "content=" & GetContentRunStr(content) & "<hr>" 
    XY_getLableValue = c 
    Call echo("title", title) 
    XY_getLableValue = "【title=】【" & title & "】" 
End Function 















'普通链接A
Function XY_HrefA(action)
    Dim content, Href, c, AContent, AType, url, title 
    action = HandleInModule(action, "start") 
    content = RParam(action, "Content") 
    AType = RParam(action, "Type") 
    If AType = "收藏" Then
        '第一种方法
        'Url = "window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"
        url = "shoucang(document.title,window.location)" 
        c = "<a href='javascript:;' onClick=""" & url & """ " & SetHtmlParam(action, "target|title|alt|id|class|style") & ">" & content & "</a>" 
    ElseIf AType = "设为首页" Then
        '第一种方法
        'Url = "var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"
        url = "SetHome(this,window.location)" 
        c = "<a href='javascript:;' onClick=""" & url & """" & SetHtmlParam(action, "target|title|alt|id|class|style") & ">" & content & "</a>" 
    Else
        content = RParam(action, "Title") 
    End If 

    content = HandleInModule(content, "end") 
    If c = "" Then c = "<a" & SetHtmlParam(action, "href|target|title|alt|id|class|rel|style") & ">" & content & "</a>" 

    XY_HrefA = c 
End Function 
%>     


