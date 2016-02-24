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
<!--#Include File = "Inc/Config.Asp"-->     
<!--#Include File = "inc/admin_function.Asp"--><% 
'asp服务器

Dim code 
Dim WebFolderName 
Dim ModuleReplaceArray(99, 99)                                                  '模块替换数组20150712
Call openconn() 

Dim WEBURLFILEPATH 
Dim WEBURLPREFIX 
Dim templateName                                                                '模板名称
Dim EDITORTYPE : EDITORTYPE = "asp"                                             '编辑器类型，是ASP,或PHP,或jSP,或.NET
Dim WEB_VIEWURL : WEB_VIEWURL = "/aspweb.asp"                                   '网站显示URL

'=========

Dim db_PREFIX : db_PREFIX = "xy_"                                               '表前缀


Dim cfg_webSiteUrl, cfg_webTemplate, cfg_webImages, cfg_webCss, cfg_webJs, cfg_webTitle, cfg_webKeywords, cfg_webDescription, cfg_webSiteBottom, cfg_flags 
Dim gbl_columnName, gbl_columnId, gbl_id, gbl_columnType, gbl_columnENType, gbl_table, gbl_detailTitle, gbl_flags 
Dim webTemplate                                                                 '网站模板路径
Dim gbl_url, gbl_filePath                                                       '当前链接网址,和文件路径
Dim gbl_isonhtml                                                                '是否生成静态网页

Dim gbl_bodyContent                                                             '主体内容
Dim gbl_artitleAuthor                                                           '文章作者
Dim gbl_artitleAdddatetime                                                      '文章添加时间
Dim gbl_upArticle                                                               '上一篇文章
Dim gbl_downArticle                                                             '下一篇文章
Dim gbl_aritcleRelatedTags                                                      '文章标签组
Dim gbl_aritcleSmallImage, gbl_aritcleBigImage                                  '文章小图与文章大图
Dim gbl_searchKeyWord                                                           '搜索关键词

Dim isMakeHtml                                                                  '是否生成网页
'处理动作   ReplaceValueParam为控制字符显示方式
Function handleAction(content)
    Dim startStr, endStr, ActionList, splStr, action, s, HandYes 
    startStr = "{\$" : endStr = "\$}" 
    ActionList = GetArray(content, startStr, endStr, True, True) 
    'Call echo("ActionList ", ActionList)
    splStr = Split(ActionList, "$Array$")
    For Each s In splStr
        action = Trim(s) 
        action = HandleInModule(action, "start")                                        '处理\'替换掉
        If action <> "" Then
            action = Trim(Mid(action, 3, Len(action) - 4)) & " " 
            'call echo("s",s)
            HandYes = True                                                                  '处理为真
            '{VB #} 这种是放在图片路径里，目的是为了在VB里不处理这个路径
            If CheckFunValue(action, "# ") = True Then
                action = "" 
            '测试
            ElseIf CheckFunValue(action, "GetLableValue ") = True Then
                action = XY_getLableValue(action) 

            '加载文件
            ElseIf CheckFunValue(action, "Include ") = True Then
                action = XY_Include(action) 

            '栏目列表
            ElseIf CheckFunValue(action, "ColumnList ") = True Then
                action = XY_AP_ColumnList(action) 

            '文章列表
            ElseIf CheckFunValue(action, "ArticleList ") = True Then
                action = XY_AP_ArticleList(action) 

            '评论列表
            ElseIf CheckFunValue(action, "CommentList ") = True Then
                action = XY_AP_CommentList(action) 

            '评论列表
            ElseIf CheckFunValue(action, "SearchStatList ") = True Then
                action = XY_AP_SearchStatList(action) 



            '显示单页内容
            ElseIf CheckFunValue(action, "MainInfo ") = True Then
                action = XY_AP_SinglePage(action) 

            '显示栏目内容
            ElseIf CheckFunValue(action, "GetColumnContent ") = True Then
                action = XY_AP_GetColumnContent(action) 


            '显示布局
            ElseIf CheckFunValue(action, "Layout ") = True Then
                action = XY_Layout(action) 
            '显示模块
            ElseIf CheckFunValue(action, "Module ") = True Then
                action = XY_Module(action) 
            '获得栏目URL
            ElseIf CheckFunValue(action, "GetColumnUrl ") = True Then
                action = XY_GetColumnUrl(action) 
            '获得单页URL
            ElseIf CheckFunValue(action, "GetOnePageUrl ") = True Then
                action = XY_GetOnePageUrl(action) 
            '显示包裹块
            ElseIf CheckFunValue(action, "DisplayWrap ") = True Then
                action = XY_DisplayWrap(action) 



            '读模板样式并设置标题与内容   软件里有个栏目Style进行设置
            ElseIf CheckFunValue(action, "ReadColumeSetTitle ") = True Then
                action = XY_ReadColumeSetTitle(action) 

            '显示编辑器
            ElseIf CheckFunValue(action, "displayEditor ") = True Then
                action = displayEditor(action) 

            'Js版网站统计
            ElseIf CheckFunValue(action, "JsWebStat ") = True Then
                action = XY_JsWebStat(action) 

                '------------------- 链接区 -----------------------
            '普通链接A
            ElseIf CheckFunValue(action, "HrefA ") = True Then
                action = XY_HrefA(action) 

            '暂时不屏蔽
            ElseIf CheckFunValue(action, "copyTemplateMaterial ") = True Then
                action = "" 
            ElseIf CheckFunValue(action, "clearCache ") = True Then
                action = "" 


            Else
                HandYes = False                                                                 '处理为假
            End If 
            '注意这样，有的则不显示 晕 And IsNul(Action)=False
            If isNul(action) = True Then action = "" 
            If HandYes = True Then
                content = Replace(content, s, action) 
            End If 
        End If 
    Next 
    handleAction = content 
End Function 

'替换全局变量 {$cfg_websiteurl$}
Function replaceGlobleVariable(ByVal content)
    content = handleRGV(content, "{$cfg_webSiteUrl$}", cfg_webSiteUrl)              '网址
    content = handleRGV(content, "{$cfg_webTemplate$}", cfg_webTemplate)            '模板
    content = handleRGV(content, "{$cfg_webImages$}", cfg_webImages)                '图片路径
    content = handleRGV(content, "{$cfg_webCss$}", cfg_webCss)                      'css路径
    content = handleRGV(content, "{$cfg_webJs$}", cfg_webJs)                        'js路径
    content = handleRGV(content, "{$cfg_webTitle$}", cfg_webTitle)                  '网站标题
    content = handleRGV(content, "{$cfg_webKeywords$}", cfg_webKeywords)            '网站关键词
    content = handleRGV(content, "{$cfg_webDescription$}", cfg_webDescription)      '网站描述
    content = handleRGV(content, "{$cfg_webSiteBottom$}", cfg_webSiteBottom)        '网站描述

    content = handleRGV(content, "{$gbl_columnId$}", gbl_columnId)                  '栏目Id
    content = handleRGV(content, "{$gbl_columnName$}", gbl_columnName)              '栏目名称
    content = handleRGV(content, "{$gbl_columnType$}", gbl_columnType)              '栏目类型
    content = handleRGV(content, "{$gbl_columnENType$}", gbl_columnENType)          '栏目英文类型


    content = handleRGV(content, "{$gbl_Table$}", gbl_table)                        '表
    content = handleRGV(content, "{$gbl_Id$}", gbl_id)                              'id


    '兼容旧版本
    content = handleRGV(content, "{$WebImages$}", cfg_webImages)                    '图片路径
    content = handleRGV(content, "{$WebCss$}", cfg_webCss)                          'css路径
    content = handleRGV(content, "{$WebJs$}", cfg_webJs)                            'js路径

    content = handleRGV(content, "{$Web_Title$}", cfg_webTitle) 
    content = handleRGV(content, "{$Web_KeyWords$}", cfg_webKeywords) 
    content = handleRGV(content, "{$Web_Description$}", cfg_webDescription) 
    content = handleRGV(content, "{$EDITORTYPE$}", EDITORTYPE)                      '后缀
    content = handleRGV(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                    '首页显示网址




    '文章用到
    content = handleRGV(content, "{$gbl_artitleAuthor$}", gbl_artitleAuthor)        '文章作者
    content = handleRGV(content, "{$gbl_artitleAdddatetime$}", gbl_artitleAdddatetime) '文章添加时间
    content = handleRGV(content, "{$gbl_upArticle$}", gbl_upArticle)                '上一篇文章
    content = handleRGV(content, "{$gbl_downArticle$}", gbl_downArticle)            '下一篇文章
    content = handleRGV(content, "{$gbl_aritcleRelatedTags$}", gbl_aritcleRelatedTags) '文章标签组
    content = handleRGV(content, "{$gbl_aritcleBigImage$}", gbl_aritcleBigImage)    '文章大图
    content = handleRGV(content, "{$gbl_aritcleSmallImage$}", gbl_aritcleSmallImage) '文章小图
    content = handleRGV(content, "{$gbl_searchKeyWord$}", gbl_searchKeyWord)        '首页显示网址


    replaceGlobleVariable = content 
End Function 
'处理替换
Function handleRGV(ByVal content, findStr, replaceStr)
    Dim lableName 
    '对[$$]处理
    lableName = Mid(findStr, 3, Len(findStr) - 4) & " " 
    lableName = Mid(lableName, 1, InStr(lableName, " ") - 1) 
    content = replaceValueParam(content, lableName, replaceStr) 
    content = replaceValueParam(content, LCase(lableName), replaceStr) 
    '直接替换{$$}这种方式，兼容之前网站
    content = Replace(content, findStr, replaceStr) 
    content = Replace(content, LCase(findStr), replaceStr) 
    handleRGV = content 
End Function 
'加载网址配置
Sub loadWebConfig()
    Dim templatedir 
    Call openconn() 
    rs.Open "select * from " & db_PREFIX & "website", conn, 1, 1 
    If Not rs.EOF Then
        cfg_webSiteUrl = phptrim(rs("webSiteUrl"))                                      '网址
        cfg_webTemplate = phptrim(rs("webTemplate"))                                    '模板路径
        cfg_webImages = phptrim(rs("webImages"))                                        '图片路径
        cfg_webCss = phptrim(rs("webCss"))                                              'css路径
        cfg_webJs = phptrim(rs("webJs"))                                                'js路径
        cfg_webTitle = rs("webTitle")                                                   '网址标题
        cfg_webKeywords = rs("webKeywords")                                             '网站关键词
        cfg_webDescription = rs("webDescription")                                       '网站描述
        cfg_webSiteBottom = rs("webSiteBottom")                                         '网站地底
        cfg_flags = rs("flags")                                                         '旗

        '改换模板20160202
        If Request("templatedir") <> "" Then
            templatedir = handlehttpurl(Replace(Request("templatedir"), handlePath("/"), "/")) 
            cfg_webImages = Replace(cfg_webImages, cfg_webTemplate, templatedir) 
            cfg_webCss = Replace(cfg_webCss, cfg_webTemplate, templatedir) 
            cfg_webJs = Replace(cfg_webJs, cfg_webTemplate, templatedir) 
            cfg_webTemplate = templatedir 
        End If 
        webTemplate = cfg_webTemplate 
    End If : rs.Close 
End Sub 
'网站位置 待完善
Function thisPosition(content)
    Dim c 
    c = "<a href=""/"">首页</a>" 
    If gbl_columnName <> "" Then
        c = c & " >> <a href=""" & getColumnUrl(gbl_columnName, "name") & """>" & gbl_columnName & "</a>" 
    End If 
    content = Replace(content, "[$detailPosition$]", c) 
    content = Replace(content, "[$detailTitle$]", gbl_detailTitle) 
    content = Replace(content, "[$detailContent$]", gbl_bodyContent) 

    thisPosition = content 
End Function 

'显示管理列表
Function getDetailList(action, content, actionName, lableTitle, ByVal fieldNameList, nPageSize, nPage, addSql)
    Call openconn() 
    Dim defaultList, i, s, c, tableName, j, splxx, k 
    Dim x, url, nCount 
    Dim idInputName, pageInfo 

    Dim fieldName                                                                   '字段名称
    Dim splFieldName                                                                '分割字段

    Dim replaceStr                                                                  '替换字符
    tableName = LCase(actionName)                                                   '表名称
    Dim listFileName                                                                '列表文件名称
    listFileName = RParam(action, "listFileName") 

    Dim id 
    id = rq("id") 

    If fieldNameList = "*" Then
        fieldNameList = LCase(getFieldList(db_PREFIX & tableName)) 
    End If 

    fieldNameList = specialStrReplace(fieldNameList)                                '特殊字符处理
    splFieldName = Split(fieldNameList, ",")                                        '字段分割成数组

    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$actionName$}", actionName) 
    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$tableName$}", tableName) 



    content = Replace(content, "{$nPageSize$}", nPageSize) 
    content = Replace(content, "{$page$}", Request("page")) 
    content = Replace(content, "{$nPageSize" & nPageSize & "$}", " selected") 
    For i = 1 To 9
        content = Replace(content, "{$nPageSize" & i & "0$}", "") 
    Next 
    defaultList = getStrCut(content, "[list]", "[/list]", 2) 
    pageInfo = getStrCut(content, "[page]", "[/page]", 1) 
    If pageInfo <> "" Then
        content = Replace(content, pageInfo, "") 
    End If 

    'call echo("pageInfo",pageInfo)

    '【删除此行start】
    'ASP部分
    If "ASP" = "ASP" Then
        rs.Open "select * from " & db_PREFIX & tableName & " " & addSql, conn, 1, 1 
        nCount = rs.RecordCount 
        'nPageSize = 10         '上面设定
        x = getRsPageNumber(rs, nCount, nPageSize, nPage)                               '获得Rs页数                                                  '记录总数
        For i = 1 To x
            s = defaultList 
            '处理三次，这样就会导致速度过慢了20160202
            For k = 1 To 3
                s = Replace(s, "[$id$]", rs("id")) 
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        s = replaceValueParam(s, fieldName, replaceStr) 
                    End If 

                    If isMakeHtml = True Then
                        url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id")) 
                    Else
                        url = handleWebUrl("?act=detail&id=" & rs("id")) 
                        If rs("customAUrl") <> "" Then
                            url = rs("customAUrl") 
                        End If 
                    End If 
                    s = replaceValueParam(s, "url", url) 
                Next 
            Next 
            '文章列表加在线编辑
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11) 
            s = HandleDisplayOnlineEditDialog(url, s, "", "div|li|span") 

            c = c & s 
        rs.MoveNext : Next : rs.Close 
        content = Replace(content, "[list]" & defaultList & "[/list]", c) 

        If isMakeHtml = True Then
            url = "" 
            If Len(listFileName) > 5 Then
                url = Mid(listFileName, 1, Len(listFileName) - 5) & "[id].html" 
                url = urlAddHttpUrl(cfg_webSiteUrl, url) 
            End If 
        Else
            url = getUrlAddToParam(getUrl(), "?page=[id]", "replace") 
        End If 

        content = Replace(content, "[$pageInfo$]", webPageControl(nCount, nPageSize, nPage, url, pageInfo)) 
    Else
        'PHP部分
        '【删除此行end】
        rs.Open "select * from " & db_PREFIX & tableName & " " & addSql, conn, 1, 1 
        nCount = rs.RecordCount 
        'nPageSize = 10         '上面设定
        page = Request("page") 
        url = getUrlAddToParam(getUrl(), "?page=[id]", "replace") 
        content = Replace(content, "[$pageInfo$]", webPageControl(nCount, nPageSize, page, url, pageInfo)) 
        If page <> "" Then
            page = page - 1 
        End If 
        rs.Open "select * from " & db_PREFIX & tableName & " " & addSql & " limit " & nPageSize * page & "," & nPageSize & "", conn, 1, 1 
        While Not rs.EOF
            s = defaultList 
            For k = 1 To 3
                s = Replace(s, "[$id$]", rs("id")) 
                s = Replace(s, "[$phpArray$]", "")                                         '替换为空  为要[]  因为我是通过js处理了
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        s = replaceValueParam(s, fieldName, replaceStr)                             '这种方式处理 加动作
                    End If 

                    If isMakeHtml = True Then
                        url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id")) 
                    Else
                        url = handleWebUrl("?act=detail&id=" & rs("id")) 
                    End If 
                    s = replaceValueParam(s, "url", url) 
                Next 
            Next 
            '文章列表加在线编辑
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11) 
            s = HandleDisplayOnlineEditDialog(url, s, "", "div|li|span") 

            c = c & s 
        rs.MoveNext : Wend : rs.Close 
        content = Replace(content, "[list]" & defaultList & "[/list]", c) 
    '【删除此行start】
    End If 
    '【删除此行end】
    getDetailList = content 
End Function 

'****************************************************
'默认列表模板
Function defaultListTemplate()
    Dim c, templateHtml, listTemplate, lableName, startStr, endStr 

    templateHtml = getFText(cfg_webTemplate & "/" & templateName) 

    lableName = "list" 
    startStr = "<!--#" & lableName & " start#-->" 
    endStr = "<!--#" & lableName & " end#-->" 
    If InStr(templateHtml, startStr) > 0 And InStr(templateHtml, endStr) > 0 Then
        listTemplate = StrCut(templateHtml, startStr, endStr, 2) 
    Else
        startStr = "<!--#" & lableName 
        endStr = "#-->" 
        If InStr(templateHtml, startStr) > 0 And InStr(templateHtml, endStr) > 0 Then
            listTemplate = StrCut(templateHtml, startStr, endStr, 2) 
        End If 
    End If 
    If listTemplate = "" Then
        c = "<ul class=""list"">" & vbCrLf 
        c = c & "[list]    <li><a href=""[$url$]"" target=""[$target$]"">[$title$]</a><span class=""time"">[$adddatetime format_time='7'$]</span></li>" & vbCrLf 
        c = c & "[/list]" & vbCrLf 
        c = c & "</ul>" & vbCrLf 
        c = c & "<div class=""clear10""></div>" & vbCrLf 
        c = c & "<div>[$pageInfo$]</div>" & vbCrLf 
        listTemplate = c 
    End If 

    defaultListTemplate = listTemplate 
End Function 

'记录表前缀
If Request("db_PREFIX") <> "" Then
    db_PREFIX = Request("db_PREFIX") 
ElseIf Session("db_PREFIX") <> "" Then
    db_PREFIX = Session("db_PREFIX") 
End If 
'加载网址配置
Call loadWebConfig() 
isMakeHtml = False 
If Request("isMakeHtml") = "1" Or Request("isMakeHtml") = "true" Then
    isMakeHtml = True 
End If 
templateName = Request("templateName")                                          '模板名称

'保存数据处理页
Select Case Request("dataact")
    Case "articlecomment" : SaveArticleComment() : Response.End()                   '保存文章评论
    Case "WebStat" : WebStat(adminDir & "/Data/Stat/") : Response.End()                  '网站统计
End Select

'生成html
If Request("act") = "makehtml" Then
    Call echo("makehtml", "makehtml") 
    isMakeHtml = True 
    Call makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' id='" & Request("id") & "' ") 
    Call createfile("index.html", code) 

'复制Html到网站
ElseIf Request("act") = "copyHtmlToWeb" Then
    Call copyHtmlToWeb() 
'全部生成
ElseIf Request("act") = "makeallhtml" Then
    Call makeAllHtml("", "", "") 

'生成当前页面
ElseIf Request("isMakeHtml") <> "" And Request("isSave") <> "" Then 
    isMakeHtml = True 
    Call rw(makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' columnType='" & Request("columnType") & "' id='" & Request("id") & "' npage='" & Request("page") & "' ")) 
    gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "") 
    If Right(gbl_filePath, 1) = "/" Then
        gbl_filePath = gbl_filePath & "index.html" 
	elseif gbl_filePath="" and gbl_columnType="首页" then
        gbl_filePath = "index.html" 
    End If 
    '文件不为空  并且开启生成html
    If gbl_filePath <> "" And gbl_isonhtml = True Then
        Call createDirFolder(getFileAttr(gbl_filePath, "1")) 
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

        '新闻则批量生成 20160216
        If gbl_columnType = "新闻" Then
            Call makeAllHtml("", "", gbl_columnId) 
        End If 

    End If 

'全部生成
ElseIf Request("act") = "Search" Then
    Call rw(makeWebHtml("actionType='Search' npage='1' ")) 
Else
    If LCase(Request("issave")) = "1" Then
        Call makeAllHtml(Request("columnType"), Request("columnName"), Request("columnId")) 
    Else
        Call rw(makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' columnType='" & Request("columnType") & "' id='" & Request("id") & "' npage='" & Request("page") & "' ")) 
    End If 
End If 





'http://127.0.0.1/aspweb.asp?act=nav&columnName=ASP
'http://127.0.0.1/aspweb.asp?act=detail&id=75
'生成html静态页
Function makeWebHtml(action)
    Dim actionType, npagesize, npage, url, addSql 
    actionType = RParam(action, "actionType") 
    npage = RParam(action, "npage") 
    npage = getnumber(npage) 
    If npage = "" Then
        npage = 1 
    Else
        npage = CInt(npage) 
    End If 
    '导航
    If actionType = "nav" Then
        gbl_columnType = RParam(action, "columnType") 
        gbl_columnName = RParam(action, "columnName") 
        gbl_columnId = RParam(action, "columnId") 
        If gbl_columnType <> "" Then
            addSql = "where columnType='" & gbl_columnType & "'" 
        End If 
        If gbl_columnName <> "" Then
            addSql = getWhereAnd(addSql, "where columnName='" & gbl_columnName & "'") 
        End If 
        If gbl_columnId <> "" Then
            addSql = getWhereAnd(addSql, "where columnId='" & gbl_columnId & "'") 
        End If 
        rs.Open "Select * from " & db_PREFIX & "webcolumn " & addSql, conn, 1, 1 
        If Not rs.EOF Then
            gbl_columnId = rs("id") 
            gbl_columnName = rs("columnname") 
            gbl_columnType = rs("columntype") 
            gbl_bodyContent = rs("bodycontent") 
            gbl_detailTitle = gbl_columnName 
            gbl_flags = rs("flags") 
            npagesize = rs("npagesize")                                                     '每页显示条数
            gbl_isonhtml = rs("isonhtml")                                                   '是否生成静态网页

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")                                                   '网址标题
            End If 
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")                                             '网站关键词
            End If 
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")                                       '网站描述
            End If 
            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath") 
                ElseIf rs("columntype") <> "首页" Then
                    templateName = getDateilTemplate(rs("id"), "List") 
                End If 
            End If 
        End If : rs.Close 
        gbl_columnENType = handleColumnType(gbl_columnType) 
        gbl_url = getColumnUrl(gbl_columnName, "name") 

        '列表
        If InStr("|新闻|产品|下载|视频|", "|" & gbl_columnType & "|") > 0 Then
            gbl_bodyContent = getDetailList(action, defaultListTemplate(), "ArticleDetail", "网站栏目", "*", npagesize, npage, "where parentid=" & gbl_columnId & " order by sortrank asc") 
        ElseIf gbl_columnType = "文本" Then
            '航行栏目加管理
            If Request("gl") = "edit" Then
                gbl_bodyContent = "<span>" & gbl_bodyContent & "</span>" 
            End If 
            url = "/admin/1.asp?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=" & gbl_columnId & "&n=" & getRnd(11) 
            gbl_bodyContent = HandleDisplayOnlineEditDialog(url, gbl_bodyContent, "", "span") 

        End If 
    '细节
    ElseIf actionType = "detail" Then
        rs.Open "Select * from " & db_PREFIX & "articledetail where id=" & RParam(action, "id"), conn, 1, 1 
        If Not rs.EOF Then
            gbl_columnName = getColumnName(rs("parentid")) 
            gbl_detailTitle = rs("title") 
            gbl_flags = rs("flags") 
            gbl_isonhtml = rs("isonhtml")                                                   '是否生成静态网页
            gbl_id = rs("id")                                                               '文章ID
            If isMakeHtml = True Then
                gbl_url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id")) 
            Else
                gbl_url = handleWebUrl("?act=detail&id=" & rs("id")) 
            End If 

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")                                                   '网址标题
            End If 
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")                                             '网站关键词
            End If 
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")                                       '网站描述
            End If 

            gbl_artitleAuthor = rs("author") 
            gbl_artitleAdddatetime = rs("adddatetime") 
            gbl_upArticle = upArticle(rs("parentid"), "sortrank", rs("sortrank")) 
            gbl_downArticle = downArticle(rs("parentid"), "sortrank", rs("sortrank")) 
            gbl_aritcleRelatedTags = aritcleRelatedTags(rs("relatedtags")) 
            gbl_aritcleSmallImage = rs("smallimage") 
            gbl_aritcleBigImage = rs("bigimage") 

            '文章内容
            'gbl_bodyContent = "<div class=""articleinfowrap"">[$articleinfowrap$]</div>" & rs("bodycontent") & "[$relatedtags$]<ul class=""updownarticlewrap"">[$updownArticle$]</ul>"
            '上一篇文章，下一篇文章
            'gbl_bodyContent = Replace(gbl_bodyContent, "[$updownArticle$]", upArticle(rs("parentid"), "sortrank", rs("sortrank")) & downArticle(rs("parentid"), "sortrank", rs("sortrank")))
            'gbl_bodyContent = Replace(gbl_bodyContent, "[$articleinfowrap$]", "来源：" & rs("author") & " &nbsp; 发布时间：" & format_Time(rs("adddatetime"), 1))
            'gbl_bodyContent = Replace(gbl_bodyContent, "[$relatedtags$]", aritcleRelatedTags(rs("relatedtags")))

            gbl_bodyContent = rs("bodycontent") 

            '文章详细加控制
            If Request("gl") = "edit" Then
                gbl_bodyContent = "<span>" & gbl_bodyContent & "</span>" 
            End If 
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & RParam(action, "id") & "&n=" & getRnd(11) 
            gbl_bodyContent = HandleDisplayOnlineEditDialog(url, gbl_bodyContent, "", "span") 

            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath") 
                Else
                    templateName = getDateilTemplate(rs("parentid"), "Detail") 
                End If 
            End If 

        End If : rs.Close 

    '单页
    ElseIf actionType = "onepage" Then
        rs.Open "Select * from " & db_PREFIX & "onepage where id=" & RParam(action, "id"), conn, 1, 1 
        If Not rs.EOF Then
            gbl_detailTitle = rs("title") 
            gbl_isonhtml = rs("isonhtml")                                                   '是否生成静态网页
            If isMakeHtml = True Then
                gbl_url = getRsUrl(rs("fileName"), rs("customAUrl"), "/page/page" & rs("id")) 
            Else
                gbl_url = handleWebUrl("?act=detail&id=" & rs("id")) 
            End If 

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")                                                   '网址标题
            End If 
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")                                             '网站关键词
            End If 
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")                                       '网站描述
            End If 
            '内容
            gbl_bodyContent = rs("bodycontent") 


            '文章详细加控制
            If Request("gl") = "edit" Then
                gbl_bodyContent = "<span>" & gbl_bodyContent & "</span>" 
            End If 
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & RParam(action, "id") & "&n=" & getRnd(11) 
            gbl_bodyContent = HandleDisplayOnlineEditDialog(url, gbl_bodyContent, "", "span") 


            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath") 
                Else
                    templateName = "Main_Model.html" 
                'call echo(templateName,"templateName")
                End If 
            End If 

        End If : rs.Close 

    '搜索
    ElseIf actionType = "Search" Then
        templateName = "Main_Model.html" 
        gbl_searchKeyWord = Request("wd") 
        addSql = " where title like '%" & gbl_searchKeyWord & "%'" 
        npagesize = 20 
        'call echo(npagesize, npage)
        gbl_bodyContent = getDetailList(action, defaultListTemplate(), "ArticleDetail", "网站栏目", "*", npagesize, npage, addSql) 

    '加载等待
    ElseIf actionType = "loading" Then
        Call rwend("页面正在加载中。。。") 
    End If 
    '模板为空，则用默认首页模板
    If templateName = "" Then
        templateName = "Index_Model.html"                                               '默认模板
    End If 
    '检测当前路径是否有模板
    If InStr(templateName, "/") = False Then
        templateName = cfg_webTemplate & "/" & templateName 
    End If 
    'call echo("templateName",templateName)
    code = getftext(templateName) 


    code = handleAction(code)                                                       '处理动作 
    code = thisPosition(code) 														'位置   
    code = replaceGlobleVariable(code)                                              '替换全局标签
    code = handleAction(code)                                                       '处理动作	'再来一次，处理数据内容里动作
	
    code = thisPosition(code) 														'位置 
    code = replaceGlobleVariable(code)                                              '替换全局标签
    code = delTemplateMyNote(code)                                                  '删除无用内容

    '格式化
    If InStr(cfg_flags, "|formattinghtml|") > 0 Then
        'code = HtmlFormatting(code)        '简单
        code = HandleHtmlFormatting(code, False, 0, "删除空行")                         '自定义
    End If 
    '闭合标签
    If InStr(cfg_flags, "|labelclose|") > 0 Then
        code = handleCloseHtml(code, True, "")                                          '图片自动加alt  "|*|",
    End If 

    '在线编辑20160127
    If Rq("gl") = "edit" Then
        If InStr(code, "</head>") > 0 Then
            If InStr(code, "jquery.Min.js") = False Then
                code = Replace(code, "</head>", "<script src=""/Jquery/jquery.Min.js""></script></head>") 
            End If 
            code = Replace(code, "</head>", "<script src=""/Jquery/Callcontext_menu.js""></script></head>") 
        End If 
        If InStr(code, "<body>") > 0 Then
        'Code = Replace(Code,"<body>", "<body onLoad=""ContextMenu.intializeContextMenu()"">")
        End If 
    End If 

    makeWebHtml = code 
End Function 
'获得默认细节模板页
Function getDateilTemplate(parentid, templateType)
    Dim templateName 
    templateName = "Main_Model.html" 
    rsx.Open "select * from " & db_PREFIX & "webcolumn where id=" & parentid, conn, 1, 1 
    If Not rsx.EOF Then
        'call echo("columntype",rsx("columntype"))
        If rsx("columntype") = "新闻" Then
            '新闻细节页
            If checkFile(cfg_webTemplate & "/News_" & templateType & ".html") = True Then
                templateName = "News_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "产品" Then
            '产品细节页
            If checkFile(cfg_webTemplate & "/Product_" & templateType & ".html") = True Then
                templateName = "Product_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "下载" Then
            '下载细节页
            If checkFile(cfg_webTemplate & "/Down_" & templateType & ".html") = True Then
                templateName = "Down_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "视频" Then
            '视频细节页
            If checkFile(cfg_webTemplate & "/Video_" & templateType & ".html") = True Then
                templateName = "Video_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "文本" Then
            '视频细节页
            If checkFile(cfg_webTemplate & "/Page_" & templateType & ".html") = True Then
                templateName = "Page_" & templateType & ".html" 
            End If 
        End If 
    End If : rsx.Close 
    'call echo(templateType,templateName)
    getDateilTemplate = templateName 

End Function 

'生成全部html页面
Sub makeAllHtml(columnType, columnName, columnId)
    Dim action, s, i, nPageSize, nCountSize, nPage, addSql, url 
    isMakeHtml = True 
    '栏目
    Call echo("栏目", "") 
    If columnType <> "" Then
        addSql = "where columnType='" & columnType & "'" 
    End If 
    If columnName <> "" Then
        addSql = getWhereAnd(addSql, "where columnName='" & columnName & "'") 
    End If 
    If columnId <> "" Then
        addSql = getWhereAnd(addSql, "where id=" & columnId & "") 
    End If 
    rss.Open "select * from " & db_PREFIX & "webcolumn " & addSql & " order by sortrank asc", conn, 1, 1 
    While Not rss.EOF
        gbl_columnName = "" 
        '开启生成html
        If rss("isonhtml") = True Then
            If rss("columntype") = "新闻" Then
                nCountSize = getRecordCount(db_PREFIX & "articledetail", " where parentid=" & rss("id")) '记录数
                nPageSize = rss("npagesize") 
                nPage = getPageNumb(CInt(nCountSize), CInt(nPageSize)) 
                For i = 1 To nPage
                    url = getRsUrl(rss("fileName"), rss("customAUrl"), "/nav" & rss("id")) 
                    gbl_filePath = Replace(url, cfg_webSiteUrl, "") 
                    If Right(gbl_filePath, 1) = "/" Or gbl_filePath = "" Then
                        gbl_filePath = gbl_filePath & "index.html" 
                    End If 
                    'call echo("gbl_filePath",gbl_filePath)
                    action = " action actionType='nav' columnName='" & rss("columnname") & "' npage='" & i & "' listfilename='" & gbl_filePath & "' " 
                    'call echo("action",action)
                    Call makeWebHtml(action) 
                    If i > 1 Then
                        gbl_filePath = Mid(gbl_filePath, 1, Len(gbl_filePath) - 5) & i & ".html" 
                    End If 
                    s = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")" 
                    Call echo(action, s) 
                    If gbl_filePath <> "" Then
                        Call createDirFolder(getFileAttr(gbl_filePath, "1")) 
                        Call createfile(gbl_filePath, code) 
                    End If 
                    doevents() 
                    templateName = ""                                                               '清空模板文件名称
                Next 
            Else
                action = " action actionType='nav' columnName='" & rss("columnname") & "'" 
                Call makeWebHtml(action) 
                gbl_filePath = Replace(getColumnUrl(rss("columnname"), "name"), cfg_webSiteUrl, "") 
                If Right(gbl_filePath, 1) = "/" Then
                    gbl_filePath = gbl_filePath & "index.html" 
                End If 
                s = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")" 
                Call echo(action, s) 
                If gbl_filePath <> "" Then
                    Call createDirFolder(getFileAttr(gbl_filePath, "1")) 
                    Call createfile(gbl_filePath, code) 
                End If 
                doevents() 
                templateName = "" 
            End If 
            conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where id=" & rss("id")) '更新导航为生成状态
        End If 
    rss.MoveNext : Wend : rss.Close 
    If addSql = "" Then
        '文章
        Call echo("文章", "") 
        rss.Open "select * from " & db_PREFIX & "articledetail order by sortrank asc", conn, 1, 1 
        While Not rss.EOF
            gbl_columnName = "" 
            action = " action actionType='detail' columnName='" & rss("parentid") & "' id='" & rss("id") & "'" 
            'call echo("action",action)
            Call makeWebHtml(action) 
            gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "") 
            If Right(gbl_filePath, 1) = "/" Then
                gbl_filePath = gbl_filePath & "index.html" 
            End If 
            s = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")" 
            Call echo(action, s) 
            '文件不为空  并且开启生成html
            If gbl_filePath <> "" And rss("isonhtml") = True Then
                Call createDirFolder(getFileAttr(gbl_filePath, "1")) 
                Call createfile(gbl_filePath, code) 
                conn.Execute("update " & db_PREFIX & "ArticleDetail set ishtml=true where id=" & rss("id")) '更新文章为生成状态
            End If 
            templateName = ""                                                               '清空模板文件名称
        rss.MoveNext : Wend : rss.Close 

        '单页
        Call echo("单页", "") 
        rss.Open "select * from " & db_PREFIX & "onepage order by sortrank asc", conn, 1, 1 
        While Not rss.EOF
            gbl_columnName = "" 
            action = " action actionType='onepage' id='" & rss("id") & "'" 
            'call echo("action",action)
            Call makeWebHtml(action) 
            gbl_filePath = Replace(gbl_url, cfg_webSiteUrl, "") 
            If Right(gbl_filePath, 1) = "/" Then
                gbl_filePath = gbl_filePath & "index.html" 
            End If 
            s = "<a href=""" & gbl_filePath & """ target='_blank'>" & gbl_filePath & "</a>(" & rss("isonhtml") & ")" 
            Call echo(action, s) 
            '文件不为空  并且开启生成html
            If gbl_filePath <> "" And rss("isonhtml") = True Then
                Call createDirFolder(getFileAttr(gbl_filePath, "1")) 
                Call createfile(gbl_filePath, code) 
                conn.Execute("update " & db_PREFIX & "onepage set ishtml=true where id=" & rss("id")) '更新单页为生成状态
            End If 
            templateName = ""                                                               '清空模板文件名称
        rss.MoveNext : Wend : rss.Close 

    End If 


End Sub 

'复制html到网站
Sub copyHtmlToWeb()
    Dim webDir, toFilePath, filePath, fileName, fileList, cssFileList, splStr, content, s, s1, c, webImages, webCss, webJs, splJs 
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
    webDir = "/htmladmin/" & WebFolderName & "/" 
    Call deleteFolder(webDir) 
    Call createDirFolder(webDir) 
    webImages = webDir & "Images/" 
    webCss = webDir & "Css/" 
    webJs = webDir & "Js/" 
    Call copyFolder(cfg_webImages, webImages) 
    Call copyFolder(cfg_webCss, webCss) 
    Call createFolder(webJs)                                                        '创建Js文件夹


    '处理Js文件夹
    splJs = Split(getDirJsList(webJs), vbCrLf) 
    For Each filePath In splJs
        If filePath <> "" Then
            toFilePath = webJs & getFileName(filePath) 
            Call echo("js", filePath) 
            Call moveFile(filePath, toFilePath) 
        End If 
    Next 
    '处理Css文件夹
    splStr = Split(getDirCssList(webCss), vbCrLf) 
    For Each filePath In splStr
        If filePath <> "" Then
            content = getftext(filePath) 
            content = Replace(content, cfg_webImages, "../images/") 
            Call createfile(filePath, content) 
            Call echo("css", cfg_webImages) 
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
            fileList = fileList & gbl_filePath & vbCrLf 
            fileName = Replace(gbl_filePath, "/", "_") 
            toFilePath = webDir & fileName 
            Call copyfile(gbl_filePath, toFilePath) 
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
            fileList = fileList & gbl_filePath & vbCrLf 
            fileName = Replace(gbl_filePath, "/", "_") 
            toFilePath = webDir & fileName 
            Call copyfile(gbl_filePath, toFilePath) 
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
            fileList = fileList & gbl_filePath & vbCrLf 
            fileName = Replace(gbl_filePath, "/", "_") 
            toFilePath = webDir & fileName 
            Call copyfile(gbl_filePath, toFilePath) 
            Call echo("单页" & rss("title"), gbl_filePath) 
        End If 
    rss.MoveNext : Wend : rss.Close 
    '批量处理html文件列表
    splStr = Split(fileList, vbCrLf) 
    For Each filePath In splStr
        If filePath <> "" Then
            filePath = webDir & Replace(filePath, "/", "_") 
            Call echo("filePath", filePath) 
            content = getftext(filePath) 
            content = Replace(content, cfg_webSiteUrl, "")                                  '删除网址
            content = Replace(content, cfg_webTemplate, "")                                 '删除模板路径
            For Each s In splStr
                s1 = s 
                If Right(s1, 11) = "/index.html" Then
                    s1 = Left(s1, Len(s1) - 11) & "/" 
                End If 
                content = Replace(content, s1, Replace(s, "/", "_")) 
            Next 

            For Each s In splJs
                If s <> "" Then
                    fileName = getFileName(s) 
                    content = Replace(content, "Images/" & fileName, "js/" & fileName) 
                End If 
            Next 
            If InStr(content, "/Jquery/Jquery.Min.js") > 0 Then
                content = Replace(content, "/Jquery/Jquery.Min.js", "js/Jquery.Min.js") 
                Call copyfile("/Jquery/Jquery.Min.js", webJs & "/Jquery.Min.js") 
            End If 
            Call createfile(filePath, content) 
        End If 
    Next 




    Call echo("webFolderName", WebFolderName) 
    Call makeHtmlWebToZip(webDir) 
End Sub 
'使htmlWeb文件夹用php压缩
Function makeHtmlWebToZip(webDir)
    Dim content, splStr, filePath, c, fileArray, fileName, fileType, isTrue 
    Dim cleanFileList                                                               '干净文件列表 为了删除翻页文件
    content = GetFileFolderList(webDir, True, "全部", "", "全部文件夹", "", "") 
    splStr = Split(content, vbCrLf) 
    For Each filePath In splStr
        If checkfolder(filePath) = False Then
            fileArray = HandleFilePathArray(filePath) 
            fileName = LCase(fileArray(2)) 
            fileType = LCase(fileArray(4)) 
            fileName = remoteNumber(fileName) 
            isTrue = True 

            If InStr("|" & cleanFileList & "|", "|" & fileName & "|") > 0 And fileType = "html" Then
                isTrue = False 
            End If 
            If isTrue = True Then
                'call echo(fileType,fileName)
                If c <> "" Then c = c & "|" 
                c = c & Replace(filePath, HandlePath("/"), "") 
                cleanFileList = cleanFileList & fileName & "|" 
            End If 
        End If 
    Next 
    Call rw(c) 
    c = c & "|||||" 
    Call createfile("htmladmin/1.txt", c) 
    Call echo("<hr>cccccccccccc", c) 
    'Call Echo("",XMLPost("http://127.0.0.1/7.asp", "content=" & escape(c)))
    Call echo("", XMLPost("http://127.0.0.1/myZIP.php?webFolderName=" & WebFolderName, "content=" & escape(c))) 
'call DeleteFile("htmladmin/1.txt")
End Function 
%> 


