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

'文章列表旗
Function flagsArticleDetail(flags)
    Dim c 
    '头条[h]
    If InStr("|" & flags & "|", "|h|") > 0 Then
        c = c & "头" 
    End If 
    '推荐[c]
    If InStr("|" & flags & "|", "|c|") > 0 Then
        c = c & "推 " 
    End If 
    '幻灯[f]
    If InStr("|" & flags & "|", "|f|") > 0 Then
        c = c & "幻 " 
    End If 
    '特荐[a]
    If InStr("|" & flags & "|", "|a|") > 0 Then
        c = c & "特 " 
    End If 
    '滚动[s]
    If InStr("|" & flags & "|", "|s|") > 0 Then
        c = c & "滚 " 
    End If 
    '加粗[b]
    If InStr("|" & flags & "|", "|b|") > 0 Then
        c = c & "粗 " 
    End If 
    If c <> "" Then c = "[<font color=""red"">" & c & "</font>]" 

    flagsArticleDetail = c 
End Function 
'获得标题设置颜色html
Function getTitleSetColorHtml(sType)
    Dim c 
    c = "<script language=""javascript"" type=""text/javascript"" src=""js/colorpicker.js""></script>" & vbCrLf 
    c = c & "<img src=""images/colour.png"" width=""15"" height=""16"" onclick=""colorpicker('title_colorpanel','set_title_color');"" style=""cursor:hand"">" & vbCrLf 
    c = c & "<span id=""title_colorpanel"" style=""position:absolute; z-index:200"" class=""colorpanel""></span>" & vbCrLf 
    c = c & "<img src=""images/bold.png"" width=""10"" height=""10"" onclick=""input_font_bold()"" style=""cursor:hand"">" & vbCrLf 
    getTitleSetColorHtml = c 
End Function 

'栏目类别循环配置       showColumnList(-1, 0,defaultList)
Function showColumnList(ByVal parentid, ByVal thisPId, nCount, ByVal defaultList)
    Dim s, c, columnname, selStr, url 
    Dim rs : Set rs = CreateObject("Adodb.RecordSet")
        rs.Open "select * from " & db_PREFIX & "webcolumn where parentid=" & parentid & "  order by sortrank asc", conn, 1, 1 
        While Not rs.EOF
            selStr = "" 
            If CStr(rs("id")) = CStr(thisPId) Then
                selStr = " selected " 
            End If 
            s = defaultList 
            s = replaceValueParam(s, "sortrank", rs("sortrank")) 
            s = replaceValueParam(s, "id", rs("id")) 
            s = replaceValueParam(s, "parentid", rs("parentid")) 
            s = replaceValueParam(s, "selected", selStr) 
            columnname = rs("columnname") 
            If nCount >= 1 Then
                columnname = copystr("&nbsp;&nbsp;", nCount) & "├─" & columnname 
            End If 
            s = replaceValueParam(s, "columnname", columnname) 
            s = replaceValueParam(s, "columntype", rs("columntype")) 
            s = replaceValueParam(s, "flags", rs("flags")) 
            s = replaceValueParam(s, "ishtml", rs("ishtml")) 
            s = replaceValueParam(s, "isonhtml", rs("isonhtml")) 


            url = WEB_VIEWURL & "?act=nav&columnName=" & columnname 
            '自定义网址
            If Trim(rs("customaurl")) <> "" Then
                url = Trim(rs("customaurl")) 
            End If 
            s = Replace(s, "[$viewWeb$]", url) 

            If EDITORTYPE = "php" Then
                s = Replace(s, "[$phpArray$]", "[]") 
            Else
                s = Replace(s, "[$phpArray$]", "") 
            End If 

            's=copystr("",nCount) & rs("columnname") & "<hr>"
            c = c & s & vbCrLf 
            c = c & showColumnList(rs("id"), thisPId, nCount + 1, defaultList) 
        rs.MoveNext : Wend : rs.Close 
        showColumnList = c 
End Function
'msg1  辅助
Function getMsg1(msgStr, url)
    Dim content 
    content = getFText(ROOT_PATH & "msg.html") 
    msgStr = msgStr & "<br>" & JsTiming(url, 5) 
    content = Replace(content, "[$msgStr$]", msgStr) 
    content = Replace(content, "[$url$]", url) 
    getMsg1 = content 
End Function 
'栏目列表
Function columnList(parentid, nCount)
    Dim s, c 
    Dim rs : Set rs = CreateObject("Adodb.RecordSet")
        rs.Open "select * from " & db_PREFIX & "webcolumn where parentid=" & parentid, conn, 1, 1 
        While Not rs.EOF
            Call echo(copystr("====", nCount) & rs("id"), rs("columnname")) 
            Call columnList(rs("id"), nCount + 1) 
        rs.MoveNext : Wend : rs.Close 
End Function

'显示管理列表
Sub dispalyManage(actionName, lableTitle, ByVal fieldNameList, nPageSize, addSql)
    Call loadWebConfig() 
    Dim content, defaultList, i, s, c 
    Dim x, url, nCount, page 
    Dim idInputName 

    Dim tableName, j, splxx 
    Dim fieldName                                                                   '字段名称
    Dim splFieldName                                                                '分割字段
    Dim keyWord                                                                     '搜索关键词
    Dim parentid                                                                    '栏目id

    Dim replaceStr                                                                  '替换字符
    tableName = LCase(actionName)                                                   '表名称

    keyWord = Request("keyword") 
    If Request.Form("parentid") <> "" Then
        parentid = Request.Form("parentid") 
    Else
        parentid = Request.QueryString("parentid") 
    End If 

    Dim id 
    id = rq("id") 

    If fieldNameList = "*" Then
        fieldNameList = LCase(getFieldList(db_PREFIX & tableName)) 
    End If 

    fieldNameList = specialStrReplace(fieldNameList)                                '特殊字符处理
    splFieldName = Split(fieldNameList, ",")                                        '字段分割成数组

    content = getFText(ROOT_PATH & "manage" & actionName & ".html") 
    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 
    content = Replace(content, "{$position$}", "系统管理 > " & lableTitle & "列表") 
    content = Replace(content, "{$actionName$}", actionName) 
    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$tableName$}", tableName) 
    content = Replace(content, "{$keyword$}", keyWord) 
    content = Replace(content, "{$parentid$}", Request("parentid"))                 '类别

    content = Replace(content, "{$nPageSize$}", nPageSize) 
    content = Replace(content, "{$page$}", Request("page")) 
    content = Replace(content, "{$nPageSize" & nPageSize & "$}", " selected") 
    For i = 1 To 9
        content = Replace(content, "{$nPageSize" & i & "0$}", "") 
    Next 

    defaultList = getStrCut(content, "[list]", "[/list]", 2) 
    '网站栏目单独处理
    If actionName = "WebColumn" Then
        content = Replace(content, "[list]" & defaultList & "[/list]", showColumnList( -1, "", 0, defaultList)) 
    Else
        '【删除此行start】
        'ASP部分
        If "ASP" = "ASP" Then
            If keyWord <> "" Then
                addSql = getWhereAnd(" where title like '%" & keyWord & "%' ", addSql) 
            End If 
            If parentid <> "" Then
                addSql = getWhereAnd(" where parentid=" & parentid & " ", addSql) 
            End If 
            'call echo(tableName,addsql)

            rs.Open "select * from " & db_PREFIX & tableName & " " & addSql, conn, 1, 1 
            nCount = rs.RecordCount 
            page = Request("page") 
            'nPageSize = 10         '上面设定
            x = getRsPageNumber(rs, nCount, nPageSize, page)                                '获得Rs页数                                                  '记录总数
            For i = 1 To x
                s = Replace(defaultList, "[$id$]", rs("id")) 
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        '对文章旗处理
                        If actionName = "ArticleDetail" And fieldName = "flags" Then
                            replaceStr = flagsArticleDetail(replaceStr) 
                        End If 
                        'call echo("fieldname",fieldname)
                        's = Replace(s, "[$" & fieldName & "$]", replaceStr)
                        s = replaceValueParam(s, fieldName, replaceStr) 

                    End If 

                Next 
                idInputName = "id" 
                s = Replace(s, "[$selectid$]", "<input type='checkbox' name='" & idInputName & "' id='" & idInputName & "' value='" & rs("id") & "' >") 
                s = Replace(s, "[$phpArray$]", "") 
                url = "【NO】" 
                If actionName = "ArticleDetail" Then
                    url = WEB_VIEWURL & "?act=detail&id=" & rs("id") 
                ElseIf actionName = "OnePage" Then
                    url = WEB_VIEWURL & "?act=onepage&id=" & rs("id") 
                '给评论加预览=文章  20160129
                ElseIf actionName = "TableComment" Then
                    url = WEB_VIEWURL & "?act=detail&id=" & rs("itemid") 
                End If 
                '必需有自定义字段
                If InStr(fieldNameList, "customaurl") > 0 Then
                    '自定义网址
                    If Trim(rs("customaurl")) <> "" Then
                        url = Trim(rs("customaurl")) 
                    End If 
                End If 
                s = Replace(s, "[$viewWeb$]", url) 
                c = c & s 
            rs.MoveNext : Next : rs.Close 
            content = Replace(content, "[list]" & defaultList & "[/list]", c) 
            url = getUrlAddToParam(getUrl(), "?page=[id]", "replace") 
            'call echo("url",url)
            content = Replace(content, "[$pageInfo$]", webPageControl(nCount, nPageSize, page, url, "")) 
        Else
            'PHP部分
            '【删除此行end】
            If keyWord <> "" Then
                addSql = " where title like '%" & keyWord & "%'" & addSql 
            End If 
            rs.Open "select * from " & tableName & " " & addSql, conn, 1, 1 
            nCount = rs.RecordCount 
            'nPageSize = 10         '上面设定
            page = Request("page") 
            url = getUrlAddToParam(getUrl(), "?page=[id]", "replace") 
            content = Replace(content, "[$pageInfo$]", webPageControl(nCount, nPageSize, page, url, "")) 
            If page <> "" Then
                page = page - 1 
            End If 
            rs.Open "select * from " & db_PREFIX & "" & tableName & " " & addSql & " limit " & nPageSize * page & "," & nPageSize & "", conn, 1, 1 
            While Not rs.EOF
                s = Replace(defaultList, "[$id$]", rs("id")) 
                s = Replace(s, "[$phpArray$]", "")                                         '替换为空  为要[]  因为我是通过js处理了
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        '对文章旗处理
                        If actionName = "ArticleDetail" And fieldName = "flags" Then
                            replaceStr = flagsArticleDetail(replaceStr) 
                        End If 
                        's = Replace(s, "[$" & fieldName & "$]", replaceStr)
                        s = replaceValueParam(s, fieldName, replaceStr)                                 '这种方式处理 加动作
                    End If 
                Next 

                idInputName = "id" 
                s = Replace(s, "[$selectid$]", "<input type='checkbox' name='" & idInputName & "' id='" & idInputName & "' value='" & rs("id") & "' >") 
                s = Replace(s, "[$phpArray$]", "") 

                If actionName = "ArticleDetail" Then
                    url = WEB_VIEWURL & "?act=detail&id=" & rs("id") 
                    '自定义网址
                    If Trim(rs("customaurl")) <> "" Then
                        url = Trim(rs("customaurl")) 
                    End If 
                    s = Replace(s, "[$viewWeb$]", url) 
                End If 
                c = c & s 
            rs.MoveNext : Wend : rs.Close 
            content = Replace(content, "[list]" & defaultList & "[/list]", c) 
        '【删除此行start】
        End If 
    '【删除此行end】
    End If 

    If InStr(content, "[$input_parentid$]") > 0 Then
        defaultList = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>" 
        c = "<select name=""parentid"" id=""parentid""><option value="""">≡ 选择栏目 ≡</option>" & showColumnList( -1, parentid, 0, defaultList) & vbCrLf & "</select>" 
        content = Replace(content, "[$input_parentid$]", c)                        '上级栏目
    End If 

    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE) 
    content = content & stat2016(True) 
    Call rw(content) 
End Sub 
'添加修改界面
Sub addEditDisplay(actionName, lableTitle, ByVal fieldNameList)
    Dim content, addOrEdit, splxx, i, j, s, c, tableName, url, aStr 
    Dim fieldName                                                                   '字段名称
    Dim splFieldName                                                                '分割字段
    Dim fieldSetType                                                                '字段设置类型
    Dim fieldDefaultValue                                                           '字段默认值
    Dim fieldValue                                                                  '字段值
    Dim splFieldValue(99)                                                           '字段值数据
    Dim sql                                                                         'sql语句
    Dim defaultList                                                                 '默认列表
    Dim flagsInputName                                                              '旗input名称给ArticleDetail用
    Dim titlecolor                                                                  '标题颜色
    Dim styleStr                                                                    '样式字符
    Dim flags                                                                       '旗
    Dim tableFieldList                                                              '表字段列表
    Dim storageFieldLit                                                             '存储字段列表
    Dim tempFieldNameList                                                           '暂存字段名称列表
    tempFieldNameList = fieldNameList 
    tableName = LCase(actionName)                                                   '表名称

    '加载网址配置
    Call loadWebConfig() 

    Dim id 
    id = rq("id") 
    fieldNameList = specialStrReplace(fieldNameList)                                '特殊字符处理

    tableFieldList = LCase(getFieldList(db_PREFIX & tableName))                     '当前表字段列表
    fieldNameList = fieldNameList & "," & tableFieldList 


    splFieldName = Split(fieldNameList, ",")                                        '字段分割成数组
    addOrEdit = "添加" 
    If id <> "" Then
        addOrEdit = "修改" 
        If id = "*" Then
            sql = "select * from " & db_PREFIX & "" & tableName 
        Else
            sql = "select * from " & db_PREFIX & "" & tableName & " where id=" & id 
        End If 
        rs.Open sql, conn, 1, 1 
        If Not rs.EOF Then
            id = rs("id") 
            For i = 0 To UBound(splFieldName)
                splxx = Split(splFieldName(i) & "|||", "|") 
                fieldName = splxx(0) 
                If splFieldName(i) <> "" And InStr("," & tableFieldList & ",", "," & fieldName & ",") > 0 And InStr("," & storageFieldLit & ",", "," & fieldName & ",") = False Then
                    splFieldValue(i) = rs(fieldName) 
                    If actionName = "ArticleDetail" And fieldName = "titlecolor" Then
                        titlecolor = rs(fieldName) 
                    ElseIf fieldName = "flags" Then
                        flags = rs(fieldName) 
                    End If 
                End If 
            Next 
        End If : rs.Close 
    End If 
    content = getFText(ROOT_PATH & "addEdit" & tableName & ".html") 
    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 
    '关闭编辑器
    If InStr(cfg_flags, "|iscloseeditor|") > 0 Then
        s = getStrCut(content, "<!--#editor start#-->", "<!--#editor end#-->", 1) 
        If s <> "" Then
            content = Replace(content, s, "") 
        End If 
    End If 

    For i = 0 To UBound(splFieldName)
        splxx = Split(splFieldName(i) & "|||", "|") 
        fieldName = splxx(0) 
        fieldSetType = splxx(1) 
        fieldDefaultValue = unSpecialStrReplace(splxx(2), "")                           '默认值
        'call echo("fieldSetType",fieldSetType)
        If splFieldName(i) <> "" And InStr("," & tableFieldList & ",", "," & fieldName & ",") > 0 And InStr("," & storageFieldLit & ",", "," & fieldName & ",") = False Then
            storageFieldLit = storageFieldLit & splFieldName(i) & "," 
            For j = 0 To 10
                fieldValue = fieldDefaultValue 

                If addOrEdit = "修改" Then
                    fieldValue = splFieldValue(i) 
                End If 
                '密码类型则显示为空
                If fieldSetType = "password" Then
                    fieldValue = "" 
                End If 
                If fieldValue <> "" Then
                    fieldValue = Replace(Replace(fieldValue, """", "&quot;"), "<", "&lt;") '在input里如果直接显示"的话就会出错了
                End If 
                If InStr(",ArticleDetail,WebColumn,", "," & actionName & ",") > 0 And fieldName = "parentid" Then
                    defaultList = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>" 
                    If addOrEdit = "添加" Then
                        fieldValue = Request("parentid") 
                    End If 
                    c = "<select name=""parentid"" id=""parentid""><option value=""-1"">≡ 作为一级栏目 ≡</option>" & showColumnList( -1, fieldValue, 0, defaultList) & vbCrLf & "</select>" 
                    content = Replace(content, "[$input_parentid$]", c)                        '上级栏目

                ElseIf actionName = "WebColumn" And fieldName = "columntype" Then
                    content = Replace(content, "[$input_columntype$]", showSelectList("columntype", WEBCOLUMNTYPE, "|", fieldValue)) 

                ElseIf InStr(",ArticleDetail,WebColumn,", "," & actionName & ",") > 0 And fieldName = "flags" Then
                    flagsInputName = "flags" 
                    If EDITORTYPE = "php" Then
                        flagsInputName = "flags[]"                                                 '因为PHP这样才代表数组
                    End If 

                    If actionName = "ArticleDetail" Then
                        s = inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|h|") > 0, 1, 0), "h", "头条[h]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|c|") > 0, 1, 0), "c", "推荐[c]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|f|") > 0, 1, 0), "f", "幻灯[f]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|a|") > 0, 1, 0), "a", "特荐[a]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|s|") > 0, 1, 0), "s", "滚动[s]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|b|") > 0, 1, 0), "b", "加粗[b]") 
                        s = Replace(s, " value='b'>", " onclick='input_font_bold()' value='b'>") 

                    ElseIf actionName = "WebColumn" Then
                        s = inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|top|") > 0, 1, 0), "top", "顶部显示") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|buttom|") > 0, 1, 0), "buttom", "底部显示") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|left|") > 0, 1, 0), "left", "左边显示") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|center|") > 0, 1, 0), "center", "中间显示") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|right|") > 0, 1, 0), "right", "右边显示") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|other|") > 0, 1, 0), "other", "其它位置显示") 
                    End If 
                    content = Replace(content, "[$input_flags$]", s) 

                ElseIf actionName = "ArticleDetail" And fieldName = "title" Then
                    s = "<input name='title' type='text' id='title' value=""" & fieldValue & """ style='width:66%;' class='measure-input' alt='请输入标题'>" 
                    styleStr = " style='color:" & titlecolor & ";" 
                    If InStr("|" & flags & "|", "|b|") > 0 Then
                        styleStr = styleStr & "font-weight: bold;" 
                    End If 
                    s = Replace(s, " style='", styleStr) 
                    content = Replace(content, "[$input_title$]", s & inputHiddenText("titlecolor", titlecolor) & getTitleSetColorHtml("")) 


                ElseIf fieldSetType = "textarea1" Then
                    content = Replace(content, "[$input_" & fieldName & "$]", handleInputHiddenTextArea(fieldName, fieldValue, "97%", "120px", "input-text", "")) 
                ElseIf fieldSetType = "textarea2" Then
                    content = Replace(content, "[$input_" & fieldName & "$]", handleInputHiddenTextArea(fieldName, fieldValue, "97%", "300px", "input-text", "")) 
                ElseIf fieldSetType = "textarea3" Then
                    content = Replace(content, "[$input_" & fieldName & "$]", handleInputHiddenTextArea(fieldName, fieldValue, "97%", "500px", "input-text", "")) 
                ElseIf fieldSetType = "password" Then
                    content = Replace(content, "[$input_" & fieldName & "$]", "<input name='" & fieldName & "' type='password' id='" & fieldName & "' value='" & fieldValue & "' style='width:97%;' class='input-text'>") 
                Else
                    content = Replace(content, "[$input_" & fieldName & "$]", inputText2(fieldName, fieldValue, "97%", "input-text", "")) 
                End If 
                'content = Replace(content, "[$" & fieldName & "$]", fieldValue)
                content = replaceValueParam(content, fieldName, fieldValue) 
            Next 
        End If 
    Next 
    content = Replace(content, "[$id$]", id) 
    content = Replace(content, "[$inputId$]", inputHiddenText("id", id) & inputHiddenText("actionType", Request("actionType"))) '隐藏表单 ID与动作
    content = Replace(content, "[$switchId$]", Request("switchId")) 
    content = Replace(content, "[$fieldNameList$]", tempFieldNameList)         '字段名称列表


    url = "?act=dispalyManageHandle&actionType=" & actionName & "&lableTitle=" & Request("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid") 

    If InStr("|WebSite|", "|" & actionName & "|") = False Then
        aStr = "<a href='" & url & "'>" & lableTitle & "列表</a> > " 
    End If 

    content = Replace(content, "{$position$}", "系统管理 > " & aStr & addOrEdit & "信息") 
    content = Replace(content, "{$actionName$}", actionName) 
    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$tableName$}", tableName) 


    content = Replace(content, "{$nPageSize$}", Request("nPageSize")) 
    content = Replace(content, "{$page$}", Request("page")) 
    content = Replace(content, "{$parentid$}", Request("parentid")) 


    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)                        'asp与phh
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                      '前端浏览网址


    '20160113
    If EDITORTYPE = "asp" Then
        content = Replace(content, "[PHP]", "") 
    ElseIf EDITORTYPE = "php" Then
        content = Replace(content, "[PHP]", "[]") 
    End If 

    Call rw(content) 
End Sub 
'保存模块
Sub saveAddEdit(actionName, lableTitle, ByVal fieldNameList)
    Dim valueStr, editValueStr, tableName, url, listUrl 
    Dim id 
    Dim splxx, i, s, c, fieldList 
    Dim fieldName                                                                   '字段名称
    Dim splFieldName                                                                '分割字段
    Dim fieldSetType                                                                '字段设置类型
    Dim fieldValue                                                                  '字段值
    Dim splFieldValue(99)                                                           '字段值数据

    fieldNameList = specialStrReplace(fieldNameList)                                '特殊字符处理
    splFieldName = Split(fieldNameList, ",")                                        '字段分割成数组
    tableName = LCase(actionName)                                                   '表名称

    'dim tableFieldList                                                                '表字段列表
    'tableFieldList = LCase(getFieldList(db_PREFIX & tableName))                     '当前表字段列表
    'call eerr("",tableFieldList)

    '对网站配置单独处理，为动态运行时删除，index.html     动，静，切换20160216
    If LCase(actionName) = "website" Then
        If InStr(Request("flags"), "htmlrun") = False Then
            Call deleteFile("../index.html") 
        End If 
    End If 

    id = rf("id") 
    Call OpenConn() 

    For i = 0 To UBound(splFieldName)
        splxx = Split(splFieldName(i) & "|||", "|") 
        fieldName = splxx(0)                                                            '字段名称
        fieldSetType = splxx(1)                                                         '字段设置类型
        'fieldValue = Request.Form(fieldName)                                            '字段对应内容
        fieldValue = ADSqlRf(fieldName)                                                 '代替上面，因为它处理了'符号
        'md5加密
        If fieldSetType = "md5" Then
            fieldValue = myMD5(fieldValue) 
        End If 

        If fieldSetType = "yesno" Then
            If fieldValue = "" Then
                fieldValue = "0" 
            End If 
        '不为数字类型加单引号
        ElseIf fieldSetType = "numb" Then
            If fieldValue = "" Then
                fieldValue = "0" 
            End If 

        ElseIf fieldName = "flags" Then
            'PHP里用法
            '【删除此行start】
            If EDITORTYPE = "php" Then
                '【删除此行end】
                If fieldValue <> "" Then
                    fieldValue = "|" & arrayToString(fieldValue, "|") 
                End If 
            '【删除此行start】
            End If 
            fieldValue = "|" & arrayToString(Split(fieldValue, ", "), "|") 
            '【删除此行end】
            fieldValue = "'" & fieldValue & "'" 

        '为时期
        ElseIf fieldSetType = "date" Then
            If fieldValue = "" Then
                fieldValue = Date() 
            End If 

        Else
            fieldValue = "'" & fieldValue & "'" 
        End If 
        If fieldList <> "" Then
            fieldList = fieldList & "," 
            valueStr = valueStr & "," 
            editValueStr = editValueStr & "," 
        End If 
        fieldList = fieldList & fieldName 
        valueStr = valueStr & fieldValue 
        editValueStr = editValueStr & fieldName & "=" & fieldValue 
    'call echo(fieldname,fieldvalue)
    Next 

    listUrl = "?act=dispalyManageHandle&actionType=" & actionName & "&lableTitle=" & Request.QueryString("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid") 
    '添加
    If id = "" Then
        conn.Execute("insert into " & db_PREFIX & "" & tableName & " (" & fieldList & ",updatetime) values(" & valueStr & ",'" & Now() & "')") 
        url = "?act=addEditHandle&actionType=" & actionName & "&lableTitle=" & Request.QueryString("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid") 

        Call rw(getMsg1("数据添加成功，返回继续添加" & lableTitle & "...<br><a href='" & listUrl & "'>返回" & lableTitle & "列表</a>", url)) 
    Else
        conn.Execute("update " & db_PREFIX & "" & tableName & " set " & editValueStr & ",updatetime='" & Now() & "' where id=" & id) 
        url = "?act=addEditHandle&actionType=" & actionName & "&lableTitle=" & Request.QueryString("lableTitle") & "&id=" & id & "&switchId=" & Request("switchId") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") 
        '没有返回列表管理设置
        If InStr("|WebSite|", "|" & actionName & "|") > 0 Then
            Call rw(getMsg1("数据修改成功", url)) 
        Else
            Call rw(getMsg1("数据修改成功，正在进入" & lableTitle & "列表...<br><a href='" & url & "'>继续编辑</a>", listUrl)) 
        End If 
    End If 
End Sub 
'删除
Sub del(actionName, lableTitle)
    Dim tableName, url 
    tableName = LCase(actionName)                                                   '表名称
    Dim id 
    id = Request("id") 
    If id <> "" Then
        Call OpenConn() 
        conn.Execute("delete from " & db_PREFIX & "" & tableName & " where id in(" & id & ")") 
        url = "?act=dispalyManageHandle&actionType=" & actionName & "&nPageSize=" & Request("nPageSize") & "&parentid=" & Request("parentid") & "&lableTitle=" & Request("lableTitle") 
        Call rw(getMsg1("删除" & lableTitle & "成功，正在进入" & lableTitle & "列表...", url)) 
    End If 
End Sub 
'排序处理
Function sortHandle(actionType)
    Dim splId, splValue, i, id, sortrank, tableName, url 
    tableName = LCase(actionType)                                                   '表名称
    splId = Split(Request("id"), ",") 
    splValue = Split(Request("value"), ",") 
    For i = 0 To UBound(splId)
        id = splId(i) 
        sortrank = splValue(i) 
        sortrank = getNumber(sortrank & "") 

        If sortrank = "" Then
            sortrank = 0 
        End If 
        conn.Execute("update " & db_PREFIX & tableName & " set sortrank=" & sortrank & " where id=" & id) 
    Next 
    url = "?act=dispalyManageHandle&actionType=" & actionType & "&nPageSize=" & Request("nPageSize") & "&parentid=" & Request("parentid") & "&lableTitle=" & Request("lableTitle") 
    Call rw(getMsg1("更新排序完成，正在返回列表...", url)) 
End Function 




'保存robots.txt 20160118
Sub saveRobots()
    Dim bodycontent, url 
    bodycontent = Request("bodycontent") 
    Call createfile("/robots.txt", bodycontent) 
    url = "?act=displayLayout&templateFile=makeRobots.html&lableTitle=生成Robots" 
    Call rw(getMsg1("保存Robots成功，正在进入Robots界面...", url)) 
End Sub 
'保存sitemap.txt 20160118
Sub saveSiteMap()
    Dim isWebRunHtml                                                                '是否为html方式显示网站
    Dim changefreg                                                                  '更新频率
    Dim priority                                                                    '优先级
    Dim c, url 
    changefreg = Request("changefreg") 
    priority = Request("priority") 
    Call loadWebConfig()                                                            '加载配置
    'call eerr("cfg_flags",cfg_flags)
    If InStr(cfg_flags, "|htmlrun|") > 0 Then
        isWebRunHtml = True 
    Else
        isWebRunHtml = False 
    End If 

    c = c & "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbCrLf 
    c = c & vbTab & "<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">" & vbCrLf 

    '栏目
    rsx.Open "select * from " & db_PREFIX & "webcolumn order by sortrank asc", conn, 1, 1 
    While Not rsx.EOF
        If rsx("nofollow") = False Then
            c = c & copystr(vbTab, 2) & "<url>" & vbCrLf 

            If isWebRunHtml = True Then
                url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id")) 
            Else
                url = escape("?act=nav&columnName=" & rsx("columnname")) 
            End If 
            url = urlAddHttpUrl(cfg_webSiteUrl, url) 
            'call echo(cfg_webSiteUrl,url)

            c = c & copystr(vbTab, 3) & "<loc>" & url & "</loc>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<lastmod>" & format_Time(rsx("updatetime"), 2) & "</lastmod>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<changefreq>" & changefreg & "</changefreq>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<priority>" & priority & "</priority>" & vbCrLf 
            c = c & copystr(vbTab, 2) & "</url>" & vbCrLf 
            Call echo("栏目", "<a href=""" & url & """ target='_blank'>" & url & "</a>") 
        End If 
    rsx.MoveNext : Wend : rsx.Close 

    '文章
    rsx.Open "select * from " & db_PREFIX & "articledetail order by sortrank asc", conn, 1, 1 

    While Not rsx.EOF
        If rsx("nofollow") = False Then
            c = c & copystr(vbTab, 2) & "<url>" & vbCrLf 
            If isWebRunHtml = True Then
                url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/detail/detail" & rsx("id")) 
            Else
                url = "?act=detail&id=" & rsx("id") 
            End If 
            url = urlAddHttpUrl(cfg_webSiteUrl, url) 
            'call echo(cfg_webSiteUrl,url)

            c = c & copystr(vbTab, 3) & "<loc>" & url & "</loc>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<lastmod>" & format_Time(rsx("updatetime"), 2) & "</lastmod>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<changefreq>" & changefreg & "</changefreq>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<priority>" & priority & "</priority>" & vbCrLf 
            c = c & copystr(vbTab, 2) & "</url>" & vbCrLf 
            Call echo("文章", "<a href=""" & url & """ target='_blank'>" & url & "</a>") 
        End If 
    rsx.MoveNext : Wend : rsx.Close 

    '单页
    rsx.Open "select * from " & db_PREFIX & "onepage order by sortrank asc", conn, 1, 1 
    While Not rsx.EOF
        If rsx("nofollow") = False Then
            c = c & copystr(vbTab, 2) & "<url>" & vbCrLf 
            If isWebRunHtml = True Then
                url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/page/detail" & rsx("id")) 
            Else
                url = "?act=onepage&id=" & rsx("id") 
            End If 
            url = urlAddHttpUrl(cfg_webSiteUrl, url) 
            'call echo(cfg_webSiteUrl,url)

            c = c & copystr(vbTab, 3) & "<loc>" & url & "</loc>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<lastmod>" & format_Time(rsx("updatetime"), 2) & "</lastmod>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<changefreq>" & changefreg & "</changefreq>" & vbCrLf 
            c = c & copystr(vbTab, 3) & "<priority>" & priority & "</priority>" & vbCrLf 
            c = c & copystr(vbTab, 2) & "</url>" & vbCrLf 
            Call echo("单页", "<a href=""" & url & """ target='_blank'>" & url & "</a>") 
        End If 
    rsx.MoveNext : Wend : rsx.Close 


    c = c & vbTab & "</urlset>" & vbCrLf 

    Call loadWebConfig() 
    Call createfile("/sitemap.xml", c) 
    Call echo("生成sitemap.xml文件成功", "<a href='/sitemap.xml' target='_blank'>点击预览sitemap.xml</a>") 

    '判断是否生成sitemap.html
    If Request("issitemaphtml") = "1" Then
        c = "" 
        '第二种
        '栏目
        rsx.Open "select * from " & db_PREFIX & "webcolumn order by sortrank asc", conn, 1, 1 
        While Not rsx.EOF
            If rsx("nofollow") = False Then


                If isWebRunHtml = True Then
                    url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id")) 
                Else
                    url = escape("?act=nav&columnName=" & rsx("columnname")) 
                End If 
                url = urlAddHttpUrl(cfg_webSiteUrl, url) 

                c = c & "<li style=""width:20%;""><a href=""" & url & """>" & rsx("columnname") & "</a><ul>" & vbCrLf 



                '文章
                rss.Open "select * from " & db_PREFIX & "articledetail where parentId=" & rsx("id") & " order by sortrank asc", conn, 1, 1 
                While Not rss.EOF
                    If rss("nofollow") = False Then
                        If isWebRunHtml = True Then
                            url = getRsUrl(rss("fileName"), rss("customAUrl"), "/detail/detail" & rss("id")) 
                        Else
                            url = "?act=detail&id=" & rss("id") 
                        End If 
                        url = urlAddHttpUrl(cfg_webSiteUrl, url) 


                        c = c & "<li style=""width:20%;""><a href=""" & url & """>" & rss("title") & "</a>" & vbCrLf 

                    End If 
                rss.MoveNext : Wend : rss.Close 




                c = c & "</ul></li>" & vbCrLf 


            End If 
        rsx.MoveNext : Wend : rsx.Close 
        Dim templateContent 
        templateContent = getftext("templateSiteMap.html") 


        templateContent = Replace(templateContent, "{$content$}", c) 
        templateContent = Replace(templateContent, "{$Web_Title$}", cfg_webTitle) 
        Call createfile("../sitemap.html", templateContent) 
    End If 
End Sub 

'统计2016 stat2016(true)
Function stat2016(isHide)
    Dim c 
    If Request.Cookies("tjB") = "" And getIP() <> "127.0.0.1" Then                  '屏蔽本地，引用之前代码20160122
        Call setCookie("tjB", "1", Time() + 3600) 
        c = c & Chr(60) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(32) & Chr(115) & Chr(114) & Chr(99) & Chr(61) & Chr(34) & Chr(104) & Chr(116) & Chr(116) & Chr(112) & Chr(58) & Chr(47) & Chr(47) & Chr(106) & Chr(115) & Chr(46) & Chr(117) & Chr(115) & Chr(101) & Chr(114) & Chr(115) & Chr(46) & Chr(53) & Chr(49) & Chr(46) & Chr(108) & Chr(97) & Chr(47) & Chr(52) & Chr(53) & Chr(51) & Chr(50) & Chr(57) & Chr(51) & Chr(49) & Chr(46) & Chr(106) & Chr(115) & Chr(34) & Chr(62) & Chr(60) & Chr(47) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(62) 
        If isHide = True Then
            c = c & "<div style=""display:none;"">" & c & "</div>" 
        End If 
    End If 
    stat2016 = c 
End Function 
'更新网站统计 20160203
Function updateWebsiteStat()
    Dim content, splStr, splxx, filePath 
    Dim url, s, visitUrl, viewUrl, viewdatetime, iP, browser, operatingsystem, cookie, screenwh, moreInfo, ipList, dateClass, nCount 

    conn.Execute("delete from " & db_PREFIX & "websitestat") 
    content = getDirTxtList("/admin/data/stat/") 
    splStr = Split(content, vbCrLf) 
    nCount = 1 
    For Each filePath In splStr
        If filePath <> "" Then
            'call echo("filePath",filePath)
            content = getftext(filePath) 
            splxx = Split(content, vbCrLf & "-------------------------------------------------" & vbCrLf) 
            For Each s In splxx
                If InStr(s, "当前：") > 0 Then
                    s = vbCrLf & s & vbCrLf 
                    dateClass = ADSql(getFileAttr(filePath, "3")) 
                    visitUrl = ADSql(getStrCut(s, vbCrLf & "来访", vbCrLf, 0)) 
                    viewUrl = ADSql(getStrCut(s, vbCrLf & "当前：", vbCrLf, 0)) 
                    viewdatetime = ADSql(getStrCut(s, vbCrLf & "时间：", vbCrLf, 0)) 
                    iP = ADSql(getStrCut(s, vbCrLf & "IP:", vbCrLf, 0)) 
                    browser = ADSql(getStrCut(s, vbCrLf & "browser: ", vbCrLf, 0)) 
                    operatingsystem = ADSql(getStrCut(s, vbCrLf & "operatingsystem=", vbCrLf, 0)) 
                    cookie = ADSql(getStrCut(s, vbCrLf & "Cookies=", vbCrLf, 0)) 
                    screenwh = ADSql(getStrCut(s, vbCrLf & "Screen=", vbCrLf, 0)) 
                    moreInfo = ADSql(getStrCut(s, vbCrLf & "用户信息=", vbCrLf, 0)) 
                    browser = ADSql(getBrType(moreInfo)) 
                    If InStr(vbCrLf & ipList & vbCrLf, vbCrLf & iP & vbCrLf) = False Then
                        ipList = ipList & iP & vbCrLf 
                    End If 
                    If 1 = 2 Then
                        Call echo("dateClass", dateClass) 
                        Call echo("visitUrl", visitUrl) 
                        Call echo("viewUrl", viewUrl) 
                        Call echo("viewdatetime", viewdatetime) 
                        Call echo("IP", iP) 
                        Call echo("browser", browser) 
                        Call echo("operatingsystem", operatingsystem) 
                        Call echo("cookie", cookie) 
                        Call echo("screenwh", screenwh) 
                        Call echo("moreInfo", moreInfo) 
                        Call hr() 
                    End If 
                    conn.Execute("insert into " & db_PREFIX & "websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values('" & visitUrl & "','" & viewUrl & "','" & browser & "','" & operatingsystem & "','" & screenwh & "','" & moreInfo & "','" & viewdatetime & "','" & iP & "','" & dateClass & "')") 
                End If 
            Next 
        End If 
    Next 


    url = "?act=dispalyManageHandle&actionType=" & Request("actionType") & "&lableTitle=" & Request("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid") 
    Call rw(getMsg1("更新网站统计成功，正在进入" & Request("lableTitle") & "列表...", url)) 
End Function 

'显示指定布局
Sub displayLayout()
    Dim content, lableTitle 
    lableTitle = Request("lableTitle") 
    Call loadWebConfig() 
    content = getFText(ROOT_PATH & Request("templateFile")) 
    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 
    content = Replace(content, "{$position$}", lableTitle) 
    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE) 
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL) 

    If lableTitle = "生成Robots" Then
        content = Replace(content, "[$bodycontent$]", getftext("/robots.txt")) 
    ElseIf lableTitle = "模板管理" Then
        content = displayTemplatesList(content) 
    End If 
    Call rw(content) 
End Sub 
'处理模板列表
Function displayTemplatesList(content)
    Dim templatesFolder, templatePath, templatePath2, templateName, defaultList, folderList, splStr, s, c 
    Dim splTemplatesFolder 
    '加载网址配置
    Call loadWebConfig() 

    defaultList = getStrCut(content, "[list]", "[/list]", 2) 

    splTemplatesFolder = Split("/Templates/|/Templates2015/|/Templates2016/", "|") 
    For Each templatesFolder In splTemplatesFolder
        If templatesFolder <> "" Then
            folderList = getDirFolderNameList(templatesFolder) 
            splStr = Split(folderList, vbCrLf) 
            For Each templateName In splStr
                If templateName <> "" And InStr("#_", Left(templateName, 1)) = False Then
                    templatePath = templatesFolder & templateName & "/" 
                    templatePath2 = templatePath 
                    s = defaultList 
                    If cfg_webtemplate = templatePath Then
                        templateName = "<font color=red>" & templateName & "</font>" 
                        templatePath2 = "<font color=red>" & templatePath2 & "</font>" 
                        s = Replace(s, "启用</a>", "</a>") 
                    Else
                        s = Replace(s, "恢复数据</a>", "</a>") 
                    End If 
                    s = replaceValueParam(s, "templatename", templateName) 
                    s = replaceValueParam(s, "templatepath", templatePath) 
                    s = replaceValueParam(s, "templatepath2", templatePath2) 
                    c = c & s & vbCrLf 
                End If 
            Next 
        End If 
    Next 
    content = Replace(content, "[list]" & defaultList & "[/list]", c) 
    displayTemplatesList = content 
End Function 
'应用模板
Function isOpenTemplate()
    Dim templatePath, templateName, editValueStr, url 
    templatePath = Request("templatepath") 
    templateName = Request("templatename") 

    If getRecordCount(db_PREFIX & "website", "") = 0 Then
        conn.Execute("insert into " & db_PREFIX & "website(webtitle) values('测试')") 
    End If 


    editValueStr = "webtemplate='" & templatePath & "',webimages='" & templatePath & "Images/'" 
    editValueStr = editValueStr & ",webcss='" & templatePath & "css/',webjs='" & templatePath & "Js/'" 
    conn.Execute("update " & db_PREFIX & "website set " & editValueStr) 
    url = "?act=displayLayout&templateFile=manageTemplates.html&lableTitle=模板管理" 
    Call rw(getMsg1("启用模板成功，正在进入模板管理界面...", url)) 
End Function 
%>    

