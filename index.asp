<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-29
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<!--#Include File = "Inc/Config.Asp"-->       
<!--#Include File = "inc/admin_function.Asp"--> 
<% 
'asp������

Call openconn() 
'=========

Dim code                                                                        'html����
Dim templateName                                                                'ģ������
Dim cfg_webSiteUrl, cfg_webTemplate, cfg_webImages, cfg_webCss, cfg_webJs, cfg_webTitle, cfg_webKeywords, cfg_webDescription, cfg_webSiteBottom, cfg_flags 
Dim glb_columnName, glb_columnId, glb_id, glb_columnType, glb_columnENType, glb_table, glb_detailTitle, glb_flags 
Dim webTemplate                                                                 '��վģ��·��
Dim glb_url, glb_filePath                                                       '��ǰ������ַ,���ļ�·��
Dim glb_isonhtml                                                                '�Ƿ����ɾ�̬��ҳ

Dim glb_bodyContent                                                             '��������
Dim glb_artitleAuthor                                                           '��������
Dim glb_artitleAdddatetime                                                      '�������ʱ��
Dim glb_upArticle                                                               '��һƪ����
Dim glb_downArticle                                                             '��һƪ����
Dim glb_aritcleRelatedTags                                                      '���±�ǩ��
Dim glb_aritcleSmallImage, glb_aritcleBigImage                                  '����Сͼ�����´�ͼ
Dim glb_searchKeyWord                                                           '�����ؼ���

Dim isMakeHtml                                                                  '�Ƿ�������ҳ
'������   ReplaceValueParamΪ�����ַ���ʾ��ʽ
Function handleAction(content)
    Dim startStr, endStr, ActionList, splStr, action, s, HandYes 
    startStr = "{\$" : endStr = "\$}" 
    ActionList = GetArray(content, startStr, endStr, True, True) 
    'Call echo("ActionList ", ActionList)
    splStr = Split(ActionList, "$Array$") 
    For Each s In splStr
        action = Trim(s) 
        action = HandleInModule(action, "start")                                        '����\'�滻��
        If action <> "" Then
            action = Trim(Mid(action, 3, Len(action) - 4)) & " " 
            'call echo("s",s)
            HandYes = True                                                                  '����Ϊ��
            '{VB #} �����Ƿ���ͼƬ·���Ŀ����Ϊ����VB�ﲻ�������·��
            If CheckFunValue(action, "# ") = True Then
                action = "" 
            '����
            ElseIf CheckFunValue(action, "GetLableValue ") = True Then
                action = XY_getLableValue(action) 

            '�����ļ�
            ElseIf CheckFunValue(action, "Include ") = True Then
                action = XY_Include(action) 

            '��Ŀ�б�
            ElseIf CheckFunValue(action, "ColumnList ") = True Then
                action = XY_AP_ColumnList(action) 
            '�����б�
            ElseIf CheckFunValue(action, "ArticleList ") = True Then
                action = XY_AP_ArticleList(action) 
            '�����б�
            ElseIf CheckFunValue(action, "CommentList ") = True Then
                action = XY_AP_CommentList(action) 
            '����ͳ���б�
            ElseIf CheckFunValue(action, "SearchStatList ") = True Then
                action = XY_AP_SearchStatList(action) 



            '��ʾ��ҳ����
            ElseIf CheckFunValue(action, "GetOnePageBody ") = True Then
                action = XY_AP_GetOnePageBody(action) 
            '��ʾ��������
            ElseIf CheckFunValue(action, "GetArticleBody ") = True Then
                action = XY_AP_GetArticleBody(action) 
            '��ʾ��Ŀ����
            ElseIf CheckFunValue(action, "GetColumnBody ") = True Then
                action = XY_AP_GetColumnBody(action) 



            '�����ĿURL
            ElseIf CheckFunValue(action, "GetColumnUrl ") = True Then
                action = XY_GetColumnUrl(action) 
            '�������URL
            ElseIf CheckFunValue(action, "GetArticleUrl ") = True Then
                action = XY_GetArticleUrl(action) 
            '��õ�ҳURL
            ElseIf CheckFunValue(action, "GetOnePageUrl ") = True Then
                action = XY_GetOnePageUrl(action) 

            '��ʾ������
            ElseIf CheckFunValue(action, "DisplayWrap ") = True Then
                action = XY_DisplayWrap(action) 
            '�������ģ�� 20150108
            ElseIf CheckFunValue(action, "GetContentModule ") = True Then
                action = XY_ReadTemplateModule(action) 
            '��ʾ����
            ElseIf CheckFunValue(action, "Layout ") = True Then
                action = XY_Layout(action) 
            '��ʾģ��
            ElseIf CheckFunValue(action, "Module ") = True Then
                action = XY_Module(action) 
            '��ģ����ʽ�����ñ���������   ������и���ĿStyle��������
            ElseIf CheckFunValue(action, "ReadColumeSetTitle ") = True Then
                action = XY_ReadColumeSetTitle(action) 

            '��ʾ�༭��
            ElseIf CheckFunValue(action, "displayEditor ") = True Then
                action = displayEditor(action) 

            'Js����վͳ��
            ElseIf CheckFunValue(action, "JsWebStat ") = True Then
                action = XY_JsWebStat(action) 

                '------------------- ������ -----------------------
            '��ͨ����A
            ElseIf CheckFunValue(action, "HrefA ") = True Then
                action = XY_HrefA(action) 

            '��ʱ������
            ElseIf CheckFunValue(action, "copyTemplateMaterial ") = True Then
                action = "" 
            ElseIf CheckFunValue(action, "clearCache ") = True Then
                action = "" 


            Else
                HandYes = False                                                                 '����Ϊ��
            End If 
            'ע���������е�����ʾ �� And IsNul(Action)=False
            If isNul(action) = True Then action = "" 
            If HandYes = True Then
                content = Replace(content, s, action) 
            End If 
        End If 
    Next 
    handleAction = content 
End Function 


'�滻ȫ�ֱ��� {$cfg_websiteurl$}
Function replaceGlobleVariable(ByVal content)
    content = handleRGV(content, "{$cfg_webSiteUrl$}", cfg_webSiteUrl)              '��ַ
    content = handleRGV(content, "{$cfg_webTemplate$}", cfg_webTemplate)            'ģ��
    content = handleRGV(content, "{$cfg_webImages$}", cfg_webImages)                'ͼƬ·��
    content = handleRGV(content, "{$cfg_webCss$}", cfg_webCss)                      'css·��
    content = handleRGV(content, "{$cfg_webJs$}", cfg_webJs)                        'js·��
    content = handleRGV(content, "{$cfg_webTitle$}", cfg_webTitle)                  '��վ����
    content = handleRGV(content, "{$cfg_webKeywords$}", cfg_webKeywords)            '��վ�ؼ���
    content = handleRGV(content, "{$cfg_webDescription$}", cfg_webDescription)      '��վ����
    content = handleRGV(content, "{$cfg_webSiteBottom$}", cfg_webSiteBottom)        '��վ����

    content = handleRGV(content, "{$glb_columnId$}", glb_columnId)                  '��ĿId
    content = handleRGV(content, "{$glb_columnName$}", glb_columnName)              '��Ŀ����
    content = handleRGV(content, "{$glb_columnType$}", glb_columnType)              '��Ŀ����
    content = handleRGV(content, "{$glb_columnENType$}", glb_columnENType)          '��ĿӢ������

    content = handleRGV(content, "{$glb_Table$}", glb_table)                        '��
    content = handleRGV(content, "{$glb_Id$}", glb_id)                              'id


    '���ݾɰ汾 ��������ȥ��
    content = handleRGV(content, "{$WebImages$}", cfg_webImages)                    'ͼƬ·��
    content = handleRGV(content, "{$WebCss$}", cfg_webCss)                          'css·��
    content = handleRGV(content, "{$WebJs$}", cfg_webJs)                            'js·��
    content = handleRGV(content, "{$Web_Title$}", cfg_webTitle) 
    content = handleRGV(content, "{$Web_KeyWords$}", cfg_webKeywords) 
    content = handleRGV(content, "{$Web_Description$}", cfg_webDescription) 


    content = handleRGV(content, "{$EDITORTYPE$}", EDITORTYPE)                      '��׺
    content = handleRGV(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                    '��ҳ��ʾ��ַ
    '�����õ�
    content = handleRGV(content, "{$glb_artitleAuthor$}", glb_artitleAuthor)        '��������
    content = handleRGV(content, "{$glb_artitleAdddatetime$}", glb_artitleAdddatetime) '�������ʱ��
    content = handleRGV(content, "{$glb_upArticle$}", glb_upArticle)                '��һƪ����
    content = handleRGV(content, "{$glb_downArticle$}", glb_downArticle)            '��һƪ����
    content = handleRGV(content, "{$glb_aritcleRelatedTags$}", glb_aritcleRelatedTags) '���±�ǩ��
    content = handleRGV(content, "{$glb_aritcleBigImage$}", glb_aritcleBigImage)    '���´�ͼ
    content = handleRGV(content, "{$glb_aritcleSmallImage$}", glb_aritcleSmallImage) '����Сͼ
    content = handleRGV(content, "{$glb_searchKeyWord$}", glb_searchKeyWord)        '��ҳ��ʾ��ַ


    replaceGlobleVariable = content 
End Function 

'�����滻
Function handleRGV(ByVal content, findStr, replaceStr)
    Dim lableName 
    '��[$$]����
    lableName = Mid(findStr, 3, Len(findStr) - 4) & " " 
    lableName = Mid(lableName, 1, InStr(lableName, " ") - 1) 
    content = replaceValueParam(content, lableName, replaceStr) 
    content = replaceValueParam(content, LCase(lableName), replaceStr) 
    'ֱ���滻{$$}���ַ�ʽ������֮ǰ��վ
    content = Replace(content, findStr, replaceStr) 
    content = Replace(content, LCase(findStr), replaceStr) 
    handleRGV = content 
End Function 

'������ַ����
Sub loadWebConfig()
    Dim templatedir 
    Call openconn() 
    rs.Open "select * from " & db_PREFIX & "website", conn, 1, 1 
    If Not rs.EOF Then
        cfg_webSiteUrl = phptrim(rs("webSiteUrl"))                                      '��ַ
        cfg_webTemplate = phptrim(rs("webTemplate"))                                    'ģ��·��
        cfg_webImages = phptrim(rs("webImages"))                                        'ͼƬ·��
        cfg_webCss = phptrim(rs("webCss"))                                              'css·��
        cfg_webJs = phptrim(rs("webJs"))                                                'js·��
        cfg_webTitle = rs("webTitle")                                                   '��ַ����
        cfg_webKeywords = rs("webKeywords")                                             '��վ�ؼ���
        cfg_webDescription = rs("webDescription")                                       '��վ����
        cfg_webSiteBottom = rs("webSiteBottom")                                         '��վ�ص�
        cfg_flags = rs("flags")                                                         '��

        '�Ļ�ģ��20160202
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

'��վλ�� ������
Function thisPosition(content)
    Dim c 
    c = "<a href=""/"">��ҳ</a>" 
    If glb_columnName <> "" Then
        c = c & " >> <a href=""" & getColumnUrl(glb_columnName, "name") & """>" & glb_columnName & "</a>" 
    End If 
    content = Replace(content, "[$detailPosition$]", c) 
    content = Replace(content, "[$detailTitle$]", glb_detailTitle) 
    content = Replace(content, "[$detailContent$]", glb_bodyContent) 

    thisPosition = content 
End Function 


'��ʾ�����б�
Function getDetailList(action, content, actionName, lableTitle, ByVal fieldNameList, nPageSize, nPage, addSql)
    Call openconn() 
    Dim defaultList, i, s, c, tableName, j, splxx, k 
    Dim x, url, nCount 
    Dim pageInfo 

    Dim fieldName                                                                   '�ֶ�����
    Dim splFieldName                                                                '�ָ��ֶ�

    Dim replaceStr                                                                  '�滻�ַ�
    tableName = LCase(actionName)                                                   '������
    Dim listFileName                                                                '�б��ļ�����
    listFileName = RParam(action, "listFileName") 

    Dim id 
    id = rq("id") 

    If fieldNameList = "*" Then
        fieldNameList = getHandleFieldList(db_PREFIX & tableName, "�ֶ��б�") 
    End If 

    fieldNameList = specialStrReplace(fieldNameList)                                '�����ַ�����
    splFieldName = Split(fieldNameList, ",")                                        '�ֶηָ������

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

    '��ɾ������start��
    'ASP����
    If "ASP" = "ASP" Then
        rs.Open "select * from " & db_PREFIX & tableName & " " & addSql, conn, 1, 1 
        nCount = rs.RecordCount 
        'nPageSize = 10         '�����趨
        x = getRsPageNumber(rs, nCount, nPageSize, nPage)                               '���Rsҳ��                                                  '��¼����
        For i = 1 To x
            s = defaultList 
            '�������Σ������ͻᵼ���ٶȹ�����20160202
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
            '�����б�����߱༭
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11) 
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
        'PHP����
        '��ɾ������end��
        rs.Open "select * from " & db_PREFIX & tableName & " " & addSql, conn, 1, 1 
        nCount = rs.RecordCount 
        'nPageSize = 10         '�����趨
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
                s = Replace(s, "[$phpArray$]", "")                                         '�滻Ϊ��  ΪҪ[]  ��Ϊ����ͨ��js������
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        s = replaceValueParam(s, fieldName, replaceStr)                             '���ַ�ʽ���� �Ӷ���
                    End If 

                    If isMakeHtml = True Then
                        url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id")) 
                    Else
                        url = handleWebUrl("?act=detail&id=" & rs("id")) 
                    End If 
                    s = replaceValueParam(s, "url", url) 
                Next 
            Next 
            '�����б�����߱༭
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=" & rs("id") & "&n=" & getRnd(11) 
            s = HandleDisplayOnlineEditDialog(url, s, "", "div|li|span") 

            c = c & s 
        rs.MoveNext : Wend : rs.Close 
        content = Replace(content, "[list]" & defaultList & "[/list]", c) 
    '��ɾ������start��
    End If 
    '��ɾ������end��
    getDetailList = content 
End Function 


'****************************************************
'Ĭ���б�ģ��
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


'��¼��ǰ׺
If Request("db_PREFIX") <> "" Then
    db_PREFIX = Request("db_PREFIX") 
ElseIf Session("db_PREFIX") <> "" Then
    db_PREFIX = Session("db_PREFIX") 
End If 
'������ַ����
Call loadWebConfig() 
isMakeHtml = False                                                              'Ĭ������HTMLΪ�ر�
If Request("isMakeHtml") = "1" Or Request("isMakeHtml") = "true" Then
    isMakeHtml = True 
End If 
templateName = Request("templateName")                                          'ģ������

'�������ݴ���ҳ
Select Case Request("dataact")
    Case "articlecomment" : SaveArticleComment() : Response.End()                   '������������
    Case "WebStat" : WebStat(adminDir & "/Data/Stat/") : Response.End()             '��վͳ��
End Select

'����html
If Request("act") = "makehtml" Then
    Call echo("makehtml", "makehtml") 
    isMakeHtml = True 
    Call makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' id='" & Request("id") & "' ") 
    Call createfile("index.html", code) 

'����Html����վ
ElseIf Request("act") = "copyHtmlToWeb" Then
    Call copyHtmlToWeb() 
'ȫ������
ElseIf Request("act") = "makeallhtml" Then
    Call makeAllHtml("", "", "") 

'���ɵ�ǰҳ��
ElseIf Request("isMakeHtml") <> "" And Request("isSave") <> "" Then

    Call handlePower("����HTMLҳ��")                                                '����Ȩ�޴���

    isMakeHtml = True 
    Call rw(makeWebHtml(" action actionType='" & Request("act") & "' columnName='" & Request("columnName") & "' columnType='" & Request("columnType") & "' id='" & Request("id") & "' npage='" & Request("page") & "' ")) 
    glb_filePath = Replace(glb_url, cfg_webSiteUrl, "") 
    If Right(glb_filePath, 1) = "/" Then
        glb_filePath = glb_filePath & "index.html" 
    ElseIf glb_filePath = "" And glb_columnType = "��ҳ" Then
        glb_filePath = "index.html" 
    End If 
    '�ļ���Ϊ��  ���ҿ�������html
    If glb_filePath <> "" And glb_isonhtml = True Then
        Call createDirFolder(getFileAttr(glb_filePath, "1")) 
        Call createfile(glb_filePath, code) 
        If Request("act") = "detail" Then
            conn.Execute("update " & db_PREFIX & "ArticleDetail set ishtml=true where id=" & Request("id")) 
        ElseIf Request("act") = "nav" Then
            If Request("id") <> "" Then
                conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where id=" & Request("id")) 
            Else
                conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where columnname='" & Request("columnName") & "'") 
            End If 
        End If 
        Call echo("�����ļ�·��", "<a href=""" & glb_filePath & """ target='_blank'>" & glb_filePath & "</a>") 

        '�������������� 20160216
        If glb_columnType = "����" Then
            Call makeAllHtml("", "", glb_columnId) 
        End If 

    End If 

'ȫ������
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
'����html��̬ҳ
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
    '����
    If actionType = "nav" Then
        glb_columnType = RParam(action, "columnType") 
        glb_columnName = RParam(action, "columnName") 
        glb_columnId = RParam(action, "columnId") 
        If glb_columnType <> "" Then
            addSql = "where columnType='" & glb_columnType & "'" 
        End If 
        If glb_columnName <> "" Then
            addSql = getWhereAnd(addSql, "where columnName='" & glb_columnName & "'") 
        End If 
        If glb_columnId <> "" Then
            addSql = getWhereAnd(addSql, "where columnId='" & glb_columnId & "'") 
        End If 
        rs.Open "Select * from " & db_PREFIX & "webcolumn " & addSql, conn, 1, 1 
        If Not rs.EOF Then
            glb_columnId = rs("id") 
            glb_columnName = rs("columnname") 
            glb_columnType = rs("columntype") 
            glb_bodyContent = rs("bodycontent") 
            glb_detailTitle = glb_columnName 
            glb_flags = rs("flags") 
            npagesize = rs("npagesize")                                                     'ÿҳ��ʾ����
            glb_isonhtml = rs("isonhtml")                                                   '�Ƿ����ɾ�̬��ҳ

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")                                                   '��ַ����
            End If 
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")                                             '��վ�ؼ���
            End If 
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")                                       '��վ����
            End If 
            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath") 
                ElseIf rs("columntype") <> "��ҳ" Then
                    templateName = getDateilTemplate(rs("id"), "List") 
                End If 
            End If 
        End If : rs.Close 
        glb_columnENType = handleColumnType(glb_columnType) 
        glb_url = getColumnUrl(glb_columnName, "name") 

        '�б�
        If InStr("|����|��Ʒ|����|��Ƶ|", "|" & glb_columnType & "|") > 0 Then
            glb_bodyContent = getDetailList(action, defaultListTemplate(), "ArticleDetail", "��վ��Ŀ", "*", npagesize, npage, "where parentid=" & glb_columnId & " order by sortrank asc") 
        ElseIf glb_columnType = "�ı�" Then
            '������Ŀ�ӹ���
            If Request("gl") = "edit" Then
                glb_bodyContent = "<span>" & glb_bodyContent & "</span>" 
            End If 
            url = "/admin/1.asp?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=" & glb_columnId & "&n=" & getRnd(11) 
            glb_bodyContent = HandleDisplayOnlineEditDialog(url, glb_bodyContent, "", "span") 

        End If 
    'ϸ��
    ElseIf actionType = "detail" Then
        rs.Open "Select * from " & db_PREFIX & "articledetail where id=" & RParam(action, "id"), conn, 1, 1 
        If Not rs.EOF Then
            glb_columnName = getColumnName(rs("parentid")) 
            glb_detailTitle = rs("title") 
            glb_flags = rs("flags") 
            glb_isonhtml = rs("isonhtml")                                                   '�Ƿ����ɾ�̬��ҳ
            glb_id = rs("id")                                                               '����ID
            If isMakeHtml = True Then
                glb_url = getRsUrl(rs("fileName"), rs("customAUrl"), "/html/detail" & rs("id")) 
            Else
                glb_url = handleWebUrl("?act=detail&id=" & rs("id")) 
            End If 

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")                                                   '��ַ����
            End If 
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")                                             '��վ�ؼ���
            End If 
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")                                       '��վ����
            End If 

            glb_artitleAuthor = rs("author") 
            glb_artitleAdddatetime = rs("adddatetime") 
            glb_upArticle = upArticle(rs("parentid"), "sortrank", rs("sortrank")) 
            glb_downArticle = downArticle(rs("parentid"), "sortrank", rs("sortrank")) 
            glb_aritcleRelatedTags = aritcleRelatedTags(rs("relatedtags")) 
            glb_aritcleSmallImage = rs("smallimage") 
            glb_aritcleBigImage = rs("bigimage") 

            '��������
            'glb_bodyContent = "<div class=""articleinfowrap"">[$articleinfowrap$]</div>" & rs("bodycontent") & "[$relatedtags$]<ul class=""updownarticlewrap"">[$updownArticle$]</ul>"
            '��һƪ���£���һƪ����
            'glb_bodyContent = Replace(glb_bodyContent, "[$updownArticle$]", upArticle(rs("parentid"), "sortrank", rs("sortrank")) & downArticle(rs("parentid"), "sortrank", rs("sortrank")))
            'glb_bodyContent = Replace(glb_bodyContent, "[$articleinfowrap$]", "��Դ��" & rs("author") & " &nbsp; ����ʱ�䣺" & format_Time(rs("adddatetime"), 1))
            'glb_bodyContent = Replace(glb_bodyContent, "[$relatedtags$]", aritcleRelatedTags(rs("relatedtags")))

            glb_bodyContent = rs("bodycontent") 

            '������ϸ�ӿ���
            If Request("gl") = "edit" Then
                glb_bodyContent = "<span>" & glb_bodyContent & "</span>" 
            End If 
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=" & RParam(action, "id") & "&n=" & getRnd(11) 
            glb_bodyContent = HandleDisplayOnlineEditDialog(url, glb_bodyContent, "", "span") 

            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath") 
                Else
                    templateName = getDateilTemplate(rs("parentid"), "Detail") 
                End If 
            End If 

        End If : rs.Close 

    '��ҳ
    ElseIf actionType = "onepage" Then
        rs.Open "Select * from " & db_PREFIX & "onepage where id=" & RParam(action, "id"), conn, 1, 1 
        If Not rs.EOF Then
            glb_detailTitle = rs("title") 
            glb_isonhtml = rs("isonhtml")                                                   '�Ƿ����ɾ�̬��ҳ
            If isMakeHtml = True Then
                glb_url = getRsUrl(rs("fileName"), rs("customAUrl"), "/page/page" & rs("id")) 
            Else
                glb_url = handleWebUrl("?act=detail&id=" & rs("id")) 
            End If 

            If rs("webTitle") <> "" Then
                cfg_webTitle = rs("webTitle")                                                   '��ַ����
            End If 
            If rs("webKeywords") <> "" Then
                cfg_webKeywords = rs("webKeywords")                                             '��վ�ؼ���
            End If 
            If rs("webDescription") <> "" Then
                cfg_webDescription = rs("webDescription")                                       '��վ����
            End If 
            '����
            glb_bodyContent = rs("bodycontent") 


            '������ϸ�ӿ���
            If Request("gl") = "edit" Then
                glb_bodyContent = "<span>" & glb_bodyContent & "</span>" 
            End If 
            url = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=" & RParam(action, "id") & "&n=" & getRnd(11) 
            glb_bodyContent = HandleDisplayOnlineEditDialog(url, glb_bodyContent, "", "span") 


            If templateName = "" Then
                If Trim(rs("templatePath")) <> "" Then
                    templateName = rs("templatePath") 
                Else
                    templateName = "Main_Model.html" 
                'call echo(templateName,"templateName")
                End If 
            End If 

        End If : rs.Close 

    '����
    ElseIf actionType = "Search" Then
        templateName = "Main_Model.html" 
        glb_searchKeyWord = Request("wd") 
        addSql = " where title like '%" & glb_searchKeyWord & "%'" 
        npagesize = 20 
        'call echo(npagesize, npage)
        glb_bodyContent = getDetailList(action, defaultListTemplate(), "ArticleDetail", "��վ��Ŀ", "*", npagesize, npage, addSql) 

    '���صȴ�
    ElseIf actionType = "loading" Then
        Call rwend("ҳ�����ڼ����С�����") 
    End If 
    'ģ��Ϊ�գ�����Ĭ����ҳģ��
    If templateName = "" Then
        templateName = "Index_Model.html"                                               'Ĭ��ģ��
    End If 
    '��⵱ǰ·���Ƿ���ģ��
    If InStr(templateName, "/") = False Then
        templateName = cfg_webTemplate & "/" & templateName 
    End If 
    'call echo("templateName",templateName)
    code = getftext(templateName) 


    code = handleAction(code)                                                       '������
    code = thisPosition(code)                                                       'λ��
    code = replaceGlobleVariable(code)                                              '�滻ȫ�ֱ�ǩ
    code = handleAction(code)                                                       '������    '����һ�Σ��������������ﶯ��

    code = thisPosition(code)                                                       'λ��
    code = replaceGlobleVariable(code)                                              '�滻ȫ�ֱ�ǩ
    code = delTemplateMyNote(code)                                                  'ɾ����������

    '��ʽ��
    If InStr(cfg_flags, "|formattinghtml|") > 0 Then
        'code = HtmlFormatting(code)        '��
        code = HandleHtmlFormatting(code, False, 0, "ɾ������")                         '�Զ���
    End If 
    '�պϱ�ǩ
    If InStr(cfg_flags, "|labelclose|") > 0 Then
        code = handleCloseHtml(code, True, "")                                          'ͼƬ�Զ���alt  "|*|",
    End If 

    '���߱༭20160127
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
    'call echo(templateName,templateName)
    makeWebHtml = code 
End Function 

'���Ĭ��ϸ��ģ��ҳ
Function getDateilTemplate(parentid, templateType)
    Dim templateName 
    templateName = "Main_Model.html" 
    rsx.Open "select * from " & db_PREFIX & "webcolumn where id=" & parentid, conn, 1, 1 
    If Not rsx.EOF Then
        'call echo("columntype",rsx("columntype"))
        If rsx("columntype") = "����" Then
            '����ϸ��ҳ
            If checkFile(cfg_webTemplate & "/News_" & templateType & ".html") = True Then
                templateName = "News_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "��Ʒ" Then
            '��Ʒϸ��ҳ
            If checkFile(cfg_webTemplate & "/Product_" & templateType & ".html") = True Then
                templateName = "Product_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "����" Then
            '����ϸ��ҳ
            If checkFile(cfg_webTemplate & "/Down_" & templateType & ".html") = True Then
                templateName = "Down_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "��Ƶ" Then
            '��Ƶϸ��ҳ
            If checkFile(cfg_webTemplate & "/Video_" & templateType & ".html") = True Then
                templateName = "Video_" & templateType & ".html" 
            End If 
        ElseIf rsx("columntype") = "�ı�" Then
            '��Ƶϸ��ҳ
            If checkFile(cfg_webTemplate & "/Page_" & templateType & ".html") = True Then
                templateName = "Page_" & templateType & ".html" 
            End If 
        End If 
    End If : rsx.Close 
    'call echo(templateType,templateName)
    getDateilTemplate = templateName 

End Function 


'����ȫ��htmlҳ��
Sub makeAllHtml(columnType, columnName, columnId)
    Dim action, s, i, nPageSize, nCountSize, nPage, addSql, url 
    Call handlePower("����ȫ��HTMLҳ��")                                            '����Ȩ�޴���

    isMakeHtml = True 
    '��Ŀ
    Call echo("��Ŀ", "") 
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
        glb_columnName = "" 
        '��������html
        If rss("isonhtml") = True Then
            If rss("columntype") = "����" Then
                nCountSize = getRecordCount(db_PREFIX & "articledetail", " where parentid=" & rss("id")) '��¼��
                nPageSize = rss("npagesize") 
                nPage = getPageNumb(CInt(nCountSize), CInt(nPageSize)) 
                For i = 1 To nPage
                    url = getRsUrl(rss("fileName"), rss("customAUrl"), "/nav" & rss("id")) 
                    glb_filePath = Replace(url, cfg_webSiteUrl, "") 
                    If Right(glb_filePath, 1) = "/" Or glb_filePath = "" Then
                        glb_filePath = glb_filePath & "index.html" 
                    End If 
                    'call echo("glb_filePath",glb_filePath)
                    action = " action actionType='nav' columnName='" & rss("columnname") & "' npage='" & i & "' listfilename='" & glb_filePath & "' " 
                    'call echo("action",action)
                    Call makeWebHtml(action) 
                    If i > 1 Then
                        glb_filePath = Mid(glb_filePath, 1, Len(glb_filePath) - 5) & i & ".html" 
                    End If 
                    s = "<a href=""" & glb_filePath & """ target='_blank'>" & glb_filePath & "</a>(" & rss("isonhtml") & ")" 
                    Call echo(action, s) 
                    If glb_filePath <> "" Then
                        Call createDirFolder(getFileAttr(glb_filePath, "1")) 
                        Call createfile(glb_filePath, code) 
                    End If 
                    doevents() 
                    templateName = ""                                                               '���ģ���ļ�����
                Next 
            Else
                action = " action actionType='nav' columnName='" & rss("columnname") & "'" 
                Call makeWebHtml(action) 
                glb_filePath = Replace(getColumnUrl(rss("columnname"), "name"), cfg_webSiteUrl, "") 
                If Right(glb_filePath, 1) = "/" Or glb_filePath = "" Then
                    glb_filePath = glb_filePath & "index.html" 
                End If 
                s = "<a href=""" & glb_filePath & """ target='_blank'>" & glb_filePath & "</a>(" & rss("isonhtml") & ")" 
                Call echo(action, s) 
                If glb_filePath <> "" Then
                    Call createDirFolder(getFileAttr(glb_filePath, "1")) 
                    Call createfile(glb_filePath, code) 
                End If 
                doevents() 
                templateName = "" 
            End If 
            conn.Execute("update " & db_PREFIX & "WebColumn set ishtml=true where id=" & rss("id")) '���µ���Ϊ����״̬
        End If 
    rss.MoveNext : Wend : rss.Close 
    If addSql = "" Then
        '����
        Call echo("����", "") 
        rss.Open "select * from " & db_PREFIX & "articledetail order by sortrank asc", conn, 1, 1 
        While Not rss.EOF
            glb_columnName = "" 
            action = " action actionType='detail' columnName='" & rss("parentid") & "' id='" & rss("id") & "'" 
            'call echo("action",action)
            Call makeWebHtml(action) 
            glb_filePath = Replace(glb_url, cfg_webSiteUrl, "") 
            If Right(glb_filePath, 1) = "/" Then
                glb_filePath = glb_filePath & "index.html" 
            End If 
            s = "<a href=""" & glb_filePath & """ target='_blank'>" & glb_filePath & "</a>(" & rss("isonhtml") & ")" 
            Call echo(action, s) 
            '�ļ���Ϊ��  ���ҿ�������html
            If glb_filePath <> "" And rss("isonhtml") = True Then
                Call createDirFolder(getFileAttr(glb_filePath, "1")) 
                Call createfile(glb_filePath, code) 
                conn.Execute("update " & db_PREFIX & "ArticleDetail set ishtml=true where id=" & rss("id")) '��������Ϊ����״̬
            End If 
            templateName = ""                                                               '���ģ���ļ�����
        rss.MoveNext : Wend : rss.Close 

        '��ҳ
        Call echo("��ҳ", "") 
        rss.Open "select * from " & db_PREFIX & "onepage order by sortrank asc", conn, 1, 1 
        While Not rss.EOF
            glb_columnName = "" 
            action = " action actionType='onepage' id='" & rss("id") & "'" 
            'call echo("action",action)
            Call makeWebHtml(action) 
            glb_filePath = Replace(glb_url, cfg_webSiteUrl, "") 
            If Right(glb_filePath, 1) = "/" Then
                glb_filePath = glb_filePath & "index.html" 
            End If 
            s = "<a href=""" & glb_filePath & """ target='_blank'>" & glb_filePath & "</a>(" & rss("isonhtml") & ")" 
            Call echo(action, s) 
            '�ļ���Ϊ��  ���ҿ�������html
            If glb_filePath <> "" And rss("isonhtml") = True Then
                Call createDirFolder(getFileAttr(glb_filePath, "1")) 
                Call createfile(glb_filePath, code) 
                conn.Execute("update " & db_PREFIX & "onepage set ishtml=true where id=" & rss("id")) '���µ�ҳΪ����״̬
            End If 
            templateName = ""                                                               '���ģ���ļ�����
        rss.MoveNext : Wend : rss.Close 

    End If 


End Sub 


'����html����վ
Sub copyHtmlToWeb()
    Dim webDir, toFilePath, filePath, fileName, fileList, splStr, content, s, s1, c, webImages, webCss, webJs, splJs 


    Call handlePower("��������HTMLҳ��")                                            '����Ȩ�޴���

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
    Call createFolder(webJs)                                                        '����Js�ļ���


    '����Js�ļ���
    splJs = Split(getDirJsList(webJs), vbCrLf) 
    For Each filePath In splJs
        If filePath <> "" Then
            toFilePath = webJs & getFileName(filePath) 
            Call echo("js", filePath) 
            Call moveFile(filePath, toFilePath) 
        End If 
    Next 
    '����Css�ļ���
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
        glb_filePath = Replace(getColumnUrl(rss("columnname"), "name"), cfg_webSiteUrl, "") 
        If Right(glb_filePath, 1) = "/" Then
            glb_filePath = glb_filePath & "index.html" 
        End If 
        If Right(glb_filePath, 5) = ".html" Then
            fileList = fileList & glb_filePath & vbCrLf 
            fileName = Replace(glb_filePath, "/", "_") 
            toFilePath = webDir & fileName 
            Call copyfile(glb_filePath, toFilePath) 
            Call echo("����", glb_filePath) 
        End If 
    rss.MoveNext : Wend : rss.Close 
    rss.Open "select * from " & db_PREFIX & "articledetail where isonhtml=true", conn, 1, 1 
    While Not rss.EOF
        glb_url = getRsUrl(rss("fileName"), rss("customAUrl"), "/html/detail" & rss("id")) 
        glb_filePath = Replace(glb_url, cfg_webSiteUrl, "") 
        If Right(glb_filePath, 1) = "/" Then
            glb_filePath = glb_filePath & "index.html" 
        End If 
        If Right(glb_filePath, 5) = ".html" Then
            fileList = fileList & glb_filePath & vbCrLf 
            fileName = Replace(glb_filePath, "/", "_") 
            toFilePath = webDir & fileName 
            Call copyfile(glb_filePath, toFilePath) 
            Call echo("����" & rss("title"), glb_filePath) 
        End If 
    rss.MoveNext : Wend : rss.Close 

    rss.Open "select * from " & db_PREFIX & "onepage where isonhtml=true", conn, 1, 1 
    While Not rss.EOF
        glb_url = getRsUrl(rss("fileName"), rss("customAUrl"), "/page/page" & rss("id")) 
        glb_filePath = Replace(glb_url, cfg_webSiteUrl, "") 
        If Right(glb_filePath, 1) = "/" Then
            glb_filePath = glb_filePath & "index.html" 
        End If 
        If Right(glb_filePath, 5) = ".html" Then
            fileList = fileList & glb_filePath & vbCrLf 
            fileName = Replace(glb_filePath, "/", "_") 
            toFilePath = webDir & fileName 
            Call copyfile(glb_filePath, toFilePath) 
            Call echo("��ҳ" & rss("title"), glb_filePath) 
        End If 
    rss.MoveNext : Wend : rss.Close 
    '��������html�ļ��б�
    splStr = Split(fileList, vbCrLf) 
    For Each filePath In splStr
        If filePath <> "" Then
            filePath = webDir & Replace(filePath, "/", "_") 
            Call echo("filePath", filePath) 
            content = getftext(filePath) 
            content = Replace(content, cfg_webSiteUrl, "")                                  'ɾ����ַ
            content = Replace(content, cfg_webTemplate, "")                                 'ɾ��ģ��·��
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

'ʹhtmlWeb�ļ�����phpѹ��
Function makeHtmlWebToZip(webDir)
    Dim content, splStr, filePath, c, fileArray, fileName, fileType, isTrue 
    Dim cleanFileList                                                               '�ɾ��ļ��б� Ϊ��ɾ����ҳ�ļ�
    content = GetFileFolderList(webDir, True, "ȫ��", "", "ȫ���ļ���", "", "") 
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
    Call echo("", XMLPost("http://127.0.0.1/myZIP.php?webFolderName=" & WebFolderName, "content=" & escape(c))) 

End Function 

%>   

