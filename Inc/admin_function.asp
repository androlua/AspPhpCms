<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-24
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By �ƶ� 
'************************************************************
%>
<% 

'�����б���
Function flagsArticleDetail(flags)
    Dim c 
    'ͷ��[h]
    If InStr("|" & flags & "|", "|h|") > 0 Then
        c = c & "ͷ" 
    End If 
    '�Ƽ�[c]
    If InStr("|" & flags & "|", "|c|") > 0 Then
        c = c & "�� " 
    End If 
    '�õ�[f]
    If InStr("|" & flags & "|", "|f|") > 0 Then
        c = c & "�� " 
    End If 
    '�ؼ�[a]
    If InStr("|" & flags & "|", "|a|") > 0 Then
        c = c & "�� " 
    End If 
    '����[s]
    If InStr("|" & flags & "|", "|s|") > 0 Then
        c = c & "�� " 
    End If 
    '�Ӵ�[b]
    If InStr("|" & flags & "|", "|b|") > 0 Then
        c = c & "�� " 
    End If 
    If c <> "" Then c = "[<font color=""red"">" & c & "</font>]" 

    flagsArticleDetail = c 
End Function 
'��ñ���������ɫhtml
Function getTitleSetColorHtml(sType)
    Dim c 
    c = "<script language=""javascript"" type=""text/javascript"" src=""js/colorpicker.js""></script>" & vbCrLf 
    c = c & "<img src=""images/colour.png"" width=""15"" height=""16"" onclick=""colorpicker('title_colorpanel','set_title_color');"" style=""cursor:hand"">" & vbCrLf 
    c = c & "<span id=""title_colorpanel"" style=""position:absolute; z-index:200"" class=""colorpanel""></span>" & vbCrLf 
    c = c & "<img src=""images/bold.png"" width=""10"" height=""10"" onclick=""input_font_bold()"" style=""cursor:hand"">" & vbCrLf 
    getTitleSetColorHtml = c 
End Function 

'��Ŀ���ѭ������       showColumnList(-1, 0,defaultList)
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
                columnname = copystr("&nbsp;&nbsp;", nCount) & "����" & columnname 
            End If 
            s = replaceValueParam(s, "columnname", columnname) 
            s = replaceValueParam(s, "columntype", rs("columntype")) 
            s = replaceValueParam(s, "flags", rs("flags")) 
            s = replaceValueParam(s, "ishtml", rs("ishtml")) 
            s = replaceValueParam(s, "isonhtml", rs("isonhtml")) 


            url = WEB_VIEWURL & "?act=nav&columnName=" & columnname 
            '�Զ�����ַ
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
'msg1  ����
Function getMsg1(msgStr, url)
    Dim content 
    content = getFText(ROOT_PATH & "msg.html") 
    msgStr = msgStr & "<br>" & JsTiming(url, 5) 
    content = Replace(content, "[$msgStr$]", msgStr) 
    content = Replace(content, "[$url$]", url) 
    getMsg1 = content 
End Function 
'��Ŀ�б�
Function columnList(parentid, nCount)
    Dim s, c 
    Dim rs : Set rs = CreateObject("Adodb.RecordSet")
        rs.Open "select * from " & db_PREFIX & "webcolumn where parentid=" & parentid, conn, 1, 1 
        While Not rs.EOF
            Call echo(copystr("====", nCount) & rs("id"), rs("columnname")) 
            Call columnList(rs("id"), nCount + 1) 
        rs.MoveNext : Wend : rs.Close 
End Function

'��ʾ�����б�
Sub dispalyManage(actionName, lableTitle, ByVal fieldNameList, nPageSize, addSql)
    Call loadWebConfig() 
    Dim content, defaultList, i, s, c 
    Dim x, url, nCount, page 
    Dim idInputName 

    Dim tableName, j, splxx 
    Dim fieldName                                                                   '�ֶ�����
    Dim splFieldName                                                                '�ָ��ֶ�
    Dim keyWord                                                                     '�����ؼ���
    Dim parentid                                                                    '��Ŀid

    Dim replaceStr                                                                  '�滻�ַ�
    tableName = LCase(actionName)                                                   '������

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

    fieldNameList = specialStrReplace(fieldNameList)                                '�����ַ�����
    splFieldName = Split(fieldNameList, ",")                                        '�ֶηָ������

    content = getFText(ROOT_PATH & "manage" & actionName & ".html") 
    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 
    content = Replace(content, "{$position$}", "ϵͳ���� > " & lableTitle & "�б�") 
    content = Replace(content, "{$actionName$}", actionName) 
    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$tableName$}", tableName) 
    content = Replace(content, "{$keyword$}", keyWord) 
    content = Replace(content, "{$parentid$}", Request("parentid"))                 '���

    content = Replace(content, "{$nPageSize$}", nPageSize) 
    content = Replace(content, "{$page$}", Request("page")) 
    content = Replace(content, "{$nPageSize" & nPageSize & "$}", " selected") 
    For i = 1 To 9
        content = Replace(content, "{$nPageSize" & i & "0$}", "") 
    Next 

    defaultList = getStrCut(content, "[list]", "[/list]", 2) 
    '��վ��Ŀ��������
    If actionName = "WebColumn" Then
        content = Replace(content, "[list]" & defaultList & "[/list]", showColumnList( -1, "", 0, defaultList)) 
    Else
        '��ɾ������start��
        'ASP����
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
            'nPageSize = 10         '�����趨
            x = getRsPageNumber(rs, nCount, nPageSize, page)                                '���Rsҳ��                                                  '��¼����
            For i = 1 To x
                s = Replace(defaultList, "[$id$]", rs("id")) 
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        '�������촦��
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
                url = "��NO��" 
                If actionName = "ArticleDetail" Then
                    url = WEB_VIEWURL & "?act=detail&id=" & rs("id") 
                ElseIf actionName = "OnePage" Then
                    url = WEB_VIEWURL & "?act=onepage&id=" & rs("id") 
                '�����ۼ�Ԥ��=����  20160129
                ElseIf actionName = "TableComment" Then
                    url = WEB_VIEWURL & "?act=detail&id=" & rs("itemid") 
                End If 
                '�������Զ����ֶ�
                If InStr(fieldNameList, "customaurl") > 0 Then
                    '�Զ�����ַ
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
            'PHP����
            '��ɾ������end��
            If keyWord <> "" Then
                addSql = " where title like '%" & keyWord & "%'" & addSql 
            End If 
            rs.Open "select * from " & tableName & " " & addSql, conn, 1, 1 
            nCount = rs.RecordCount 
            'nPageSize = 10         '�����趨
            page = Request("page") 
            url = getUrlAddToParam(getUrl(), "?page=[id]", "replace") 
            content = Replace(content, "[$pageInfo$]", webPageControl(nCount, nPageSize, page, url, "")) 
            If page <> "" Then
                page = page - 1 
            End If 
            rs.Open "select * from " & db_PREFIX & "" & tableName & " " & addSql & " limit " & nPageSize * page & "," & nPageSize & "", conn, 1, 1 
            While Not rs.EOF
                s = Replace(defaultList, "[$id$]", rs("id")) 
                s = Replace(s, "[$phpArray$]", "")                                         '�滻Ϊ��  ΪҪ[]  ��Ϊ����ͨ��js������
                For j = 0 To UBound(splFieldName)
                    If splFieldName(j) <> "" Then
                        splxx = Split(splFieldName(j) & "|||", "|") 
                        fieldName = splxx(0) 
                        replaceStr = rs(fieldName) & "" 
                        '�������촦��
                        If actionName = "ArticleDetail" And fieldName = "flags" Then
                            replaceStr = flagsArticleDetail(replaceStr) 
                        End If 
                        's = Replace(s, "[$" & fieldName & "$]", replaceStr)
                        s = replaceValueParam(s, fieldName, replaceStr)                                 '���ַ�ʽ���� �Ӷ���
                    End If 
                Next 

                idInputName = "id" 
                s = Replace(s, "[$selectid$]", "<input type='checkbox' name='" & idInputName & "' id='" & idInputName & "' value='" & rs("id") & "' >") 
                s = Replace(s, "[$phpArray$]", "") 

                If actionName = "ArticleDetail" Then
                    url = WEB_VIEWURL & "?act=detail&id=" & rs("id") 
                    '�Զ�����ַ
                    If Trim(rs("customaurl")) <> "" Then
                        url = Trim(rs("customaurl")) 
                    End If 
                    s = Replace(s, "[$viewWeb$]", url) 
                End If 
                c = c & s 
            rs.MoveNext : Wend : rs.Close 
            content = Replace(content, "[list]" & defaultList & "[/list]", c) 
        '��ɾ������start��
        End If 
    '��ɾ������end��
    End If 

    If InStr(content, "[$input_parentid$]") > 0 Then
        defaultList = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>" 
        c = "<select name=""parentid"" id=""parentid""><option value="""">�� ѡ����Ŀ ��</option>" & showColumnList( -1, parentid, 0, defaultList) & vbCrLf & "</select>" 
        content = Replace(content, "[$input_parentid$]", c)                        '�ϼ���Ŀ
    End If 

    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE) 
    content = content & stat2016(True) 
    Call rw(content) 
End Sub 
'����޸Ľ���
Sub addEditDisplay(actionName, lableTitle, ByVal fieldNameList)
    Dim content, addOrEdit, splxx, i, j, s, c, tableName, url, aStr 
    Dim fieldName                                                                   '�ֶ�����
    Dim splFieldName                                                                '�ָ��ֶ�
    Dim fieldSetType                                                                '�ֶ���������
    Dim fieldDefaultValue                                                           '�ֶ�Ĭ��ֵ
    Dim fieldValue                                                                  '�ֶ�ֵ
    Dim splFieldValue(99)                                                           '�ֶ�ֵ����
    Dim sql                                                                         'sql���
    Dim defaultList                                                                 'Ĭ���б�
    Dim flagsInputName                                                              '��input���Ƹ�ArticleDetail��
    Dim titlecolor                                                                  '������ɫ
    Dim styleStr                                                                    '��ʽ�ַ�
    Dim flags                                                                       '��
    Dim tableFieldList                                                              '���ֶ��б�
    Dim storageFieldLit                                                             '�洢�ֶ��б�
    Dim tempFieldNameList                                                           '�ݴ��ֶ������б�
    tempFieldNameList = fieldNameList 
    tableName = LCase(actionName)                                                   '������

    '������ַ����
    Call loadWebConfig() 

    Dim id 
    id = rq("id") 
    fieldNameList = specialStrReplace(fieldNameList)                                '�����ַ�����

    tableFieldList = LCase(getFieldList(db_PREFIX & tableName))                     '��ǰ���ֶ��б�
    fieldNameList = fieldNameList & "," & tableFieldList 


    splFieldName = Split(fieldNameList, ",")                                        '�ֶηָ������
    addOrEdit = "���" 
    If id <> "" Then
        addOrEdit = "�޸�" 
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
    '�رձ༭��
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
        fieldDefaultValue = unSpecialStrReplace(splxx(2), "")                           'Ĭ��ֵ
        'call echo("fieldSetType",fieldSetType)
        If splFieldName(i) <> "" And InStr("," & tableFieldList & ",", "," & fieldName & ",") > 0 And InStr("," & storageFieldLit & ",", "," & fieldName & ",") = False Then
            storageFieldLit = storageFieldLit & splFieldName(i) & "," 
            For j = 0 To 10
                fieldValue = fieldDefaultValue 

                If addOrEdit = "�޸�" Then
                    fieldValue = splFieldValue(i) 
                End If 
                '������������ʾΪ��
                If fieldSetType = "password" Then
                    fieldValue = "" 
                End If 
                If fieldValue <> "" Then
                    fieldValue = Replace(Replace(fieldValue, """", "&quot;"), "<", "&lt;") '��input�����ֱ����ʾ"�Ļ��ͻ������
                End If 
                If InStr(",ArticleDetail,WebColumn,", "," & actionName & ",") > 0 And fieldName = "parentid" Then
                    defaultList = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>" 
                    If addOrEdit = "���" Then
                        fieldValue = Request("parentid") 
                    End If 
                    c = "<select name=""parentid"" id=""parentid""><option value=""-1"">�� ��Ϊһ����Ŀ ��</option>" & showColumnList( -1, fieldValue, 0, defaultList) & vbCrLf & "</select>" 
                    content = Replace(content, "[$input_parentid$]", c)                        '�ϼ���Ŀ

                ElseIf actionName = "WebColumn" And fieldName = "columntype" Then
                    content = Replace(content, "[$input_columntype$]", showSelectList("columntype", WEBCOLUMNTYPE, "|", fieldValue)) 

                ElseIf InStr(",ArticleDetail,WebColumn,", "," & actionName & ",") > 0 And fieldName = "flags" Then
                    flagsInputName = "flags" 
                    If EDITORTYPE = "php" Then
                        flagsInputName = "flags[]"                                                 '��ΪPHP�����Ŵ�������
                    End If 

                    If actionName = "ArticleDetail" Then
                        s = inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|h|") > 0, 1, 0), "h", "ͷ��[h]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|c|") > 0, 1, 0), "c", "�Ƽ�[c]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|f|") > 0, 1, 0), "f", "�õ�[f]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|a|") > 0, 1, 0), "a", "�ؼ�[a]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|s|") > 0, 1, 0), "s", "����[s]") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|b|") > 0, 1, 0), "b", "�Ӵ�[b]") 
                        s = Replace(s, " value='b'>", " onclick='input_font_bold()' value='b'>") 

                    ElseIf actionName = "WebColumn" Then
                        s = inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|top|") > 0, 1, 0), "top", "������ʾ") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|buttom|") > 0, 1, 0), "buttom", "�ײ���ʾ") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|left|") > 0, 1, 0), "left", "�����ʾ") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|center|") > 0, 1, 0), "center", "�м���ʾ") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|right|") > 0, 1, 0), "right", "�ұ���ʾ") 
                        s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|other|") > 0, 1, 0), "other", "����λ����ʾ") 
                    End If 
                    content = Replace(content, "[$input_flags$]", s) 

                ElseIf actionName = "ArticleDetail" And fieldName = "title" Then
                    s = "<input name='title' type='text' id='title' value=""" & fieldValue & """ style='width:66%;' class='measure-input' alt='���������'>" 
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
    content = Replace(content, "[$inputId$]", inputHiddenText("id", id) & inputHiddenText("actionType", Request("actionType"))) '���ر� ID�붯��
    content = Replace(content, "[$switchId$]", Request("switchId")) 
    content = Replace(content, "[$fieldNameList$]", tempFieldNameList)         '�ֶ������б�


    url = "?act=dispalyManageHandle&actionType=" & actionName & "&lableTitle=" & Request("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid") 

    If InStr("|WebSite|", "|" & actionName & "|") = False Then
        aStr = "<a href='" & url & "'>" & lableTitle & "�б�</a> > " 
    End If 

    content = Replace(content, "{$position$}", "ϵͳ���� > " & aStr & addOrEdit & "��Ϣ") 
    content = Replace(content, "{$actionName$}", actionName) 
    content = Replace(content, "{$lableTitle$}", lableTitle) 
    content = Replace(content, "{$tableName$}", tableName) 


    content = Replace(content, "{$nPageSize$}", Request("nPageSize")) 
    content = Replace(content, "{$page$}", Request("page")) 
    content = Replace(content, "{$parentid$}", Request("parentid")) 


    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)                        'asp��phh
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                      'ǰ�������ַ


    '20160113
    If EDITORTYPE = "asp" Then
        content = Replace(content, "[PHP]", "") 
    ElseIf EDITORTYPE = "php" Then
        content = Replace(content, "[PHP]", "[]") 
    End If 

    Call rw(content) 
End Sub 
'����ģ��
Sub saveAddEdit(actionName, lableTitle, ByVal fieldNameList)
    Dim valueStr, editValueStr, tableName, url, listUrl 
    Dim id 
    Dim splxx, i, s, c, fieldList 
    Dim fieldName                                                                   '�ֶ�����
    Dim splFieldName                                                                '�ָ��ֶ�
    Dim fieldSetType                                                                '�ֶ���������
    Dim fieldValue                                                                  '�ֶ�ֵ
    Dim splFieldValue(99)                                                           '�ֶ�ֵ����

    fieldNameList = specialStrReplace(fieldNameList)                                '�����ַ�����
    splFieldName = Split(fieldNameList, ",")                                        '�ֶηָ������
    tableName = LCase(actionName)                                                   '������

    'dim tableFieldList                                                                '���ֶ��б�
    'tableFieldList = LCase(getFieldList(db_PREFIX & tableName))                     '��ǰ���ֶ��б�
    'call eerr("",tableFieldList)

    '����վ���õ�������Ϊ��̬����ʱɾ����index.html     ���������л�20160216
    If LCase(actionName) = "website" Then
        If InStr(Request("flags"), "htmlrun") = False Then
            Call deleteFile("../index.html") 
        End If 
    End If 

    id = rf("id") 
    Call OpenConn() 

    For i = 0 To UBound(splFieldName)
        splxx = Split(splFieldName(i) & "|||", "|") 
        fieldName = splxx(0)                                                            '�ֶ�����
        fieldSetType = splxx(1)                                                         '�ֶ���������
        'fieldValue = Request.Form(fieldName)                                            '�ֶζ�Ӧ����
        fieldValue = ADSqlRf(fieldName)                                                 '�������棬��Ϊ��������'����
        'md5����
        If fieldSetType = "md5" Then
            fieldValue = myMD5(fieldValue) 
        End If 

        If fieldSetType = "yesno" Then
            If fieldValue = "" Then
                fieldValue = "0" 
            End If 
        '��Ϊ�������ͼӵ�����
        ElseIf fieldSetType = "numb" Then
            If fieldValue = "" Then
                fieldValue = "0" 
            End If 

        ElseIf fieldName = "flags" Then
            'PHP���÷�
            '��ɾ������start��
            If EDITORTYPE = "php" Then
                '��ɾ������end��
                If fieldValue <> "" Then
                    fieldValue = "|" & arrayToString(fieldValue, "|") 
                End If 
            '��ɾ������start��
            End If 
            fieldValue = "|" & arrayToString(Split(fieldValue, ", "), "|") 
            '��ɾ������end��
            fieldValue = "'" & fieldValue & "'" 

        'Ϊʱ��
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
    '���
    If id = "" Then
        conn.Execute("insert into " & db_PREFIX & "" & tableName & " (" & fieldList & ",updatetime) values(" & valueStr & ",'" & Now() & "')") 
        url = "?act=addEditHandle&actionType=" & actionName & "&lableTitle=" & Request.QueryString("lableTitle") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") & "&parentid=" & Request("parentid") 

        Call rw(getMsg1("������ӳɹ������ؼ������" & lableTitle & "...<br><a href='" & listUrl & "'>����" & lableTitle & "�б�</a>", url)) 
    Else
        conn.Execute("update " & db_PREFIX & "" & tableName & " set " & editValueStr & ",updatetime='" & Now() & "' where id=" & id) 
        url = "?act=addEditHandle&actionType=" & actionName & "&lableTitle=" & Request.QueryString("lableTitle") & "&id=" & id & "&switchId=" & Request("switchId") & "&nPageSize=" & Request("nPageSize") & "&page=" & Request("page") 
        'û�з����б��������
        If InStr("|WebSite|", "|" & actionName & "|") > 0 Then
            Call rw(getMsg1("�����޸ĳɹ�", url)) 
        Else
            Call rw(getMsg1("�����޸ĳɹ������ڽ���" & lableTitle & "�б�...<br><a href='" & url & "'>�����༭</a>", listUrl)) 
        End If 
    End If 
End Sub 
'ɾ��
Sub del(actionName, lableTitle)
    Dim tableName, url 
    tableName = LCase(actionName)                                                   '������
    Dim id 
    id = Request("id") 
    If id <> "" Then
        Call OpenConn() 
        conn.Execute("delete from " & db_PREFIX & "" & tableName & " where id in(" & id & ")") 
        url = "?act=dispalyManageHandle&actionType=" & actionName & "&nPageSize=" & Request("nPageSize") & "&parentid=" & Request("parentid") & "&lableTitle=" & Request("lableTitle") 
        Call rw(getMsg1("ɾ��" & lableTitle & "�ɹ������ڽ���" & lableTitle & "�б�...", url)) 
    End If 
End Sub 
'������
Function sortHandle(actionType)
    Dim splId, splValue, i, id, sortrank, tableName, url 
    tableName = LCase(actionType)                                                   '������
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
    Call rw(getMsg1("����������ɣ����ڷ����б�...", url)) 
End Function 




'����robots.txt 20160118
Sub saveRobots()
    Dim bodycontent, url 
    bodycontent = Request("bodycontent") 
    Call createfile("/robots.txt", bodycontent) 
    url = "?act=displayLayout&templateFile=makeRobots.html&lableTitle=����Robots" 
    Call rw(getMsg1("����Robots�ɹ������ڽ���Robots����...", url)) 
End Sub 
'����sitemap.txt 20160118
Sub saveSiteMap()
    Dim isWebRunHtml                                                                '�Ƿ�Ϊhtml��ʽ��ʾ��վ
    Dim changefreg                                                                  '����Ƶ��
    Dim priority                                                                    '���ȼ�
    Dim c, url 
    changefreg = Request("changefreg") 
    priority = Request("priority") 
    Call loadWebConfig()                                                            '��������
    'call eerr("cfg_flags",cfg_flags)
    If InStr(cfg_flags, "|htmlrun|") > 0 Then
        isWebRunHtml = True 
    Else
        isWebRunHtml = False 
    End If 

    c = c & "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbCrLf 
    c = c & vbTab & "<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">" & vbCrLf 

    '��Ŀ
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
            Call echo("��Ŀ", "<a href=""" & url & """ target='_blank'>" & url & "</a>") 
        End If 
    rsx.MoveNext : Wend : rsx.Close 

    '����
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
            Call echo("����", "<a href=""" & url & """ target='_blank'>" & url & "</a>") 
        End If 
    rsx.MoveNext : Wend : rsx.Close 

    '��ҳ
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
            Call echo("��ҳ", "<a href=""" & url & """ target='_blank'>" & url & "</a>") 
        End If 
    rsx.MoveNext : Wend : rsx.Close 


    c = c & vbTab & "</urlset>" & vbCrLf 

    Call loadWebConfig() 
    Call createfile("/sitemap.xml", c) 
    Call echo("����sitemap.xml�ļ��ɹ�", "<a href='/sitemap.xml' target='_blank'>���Ԥ��sitemap.xml</a>") 

    '�ж��Ƿ�����sitemap.html
    If Request("issitemaphtml") = "1" Then
        c = "" 
        '�ڶ���
        '��Ŀ
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



                '����
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

'ͳ��2016 stat2016(true)
Function stat2016(isHide)
    Dim c 
    If Request.Cookies("tjB") = "" And getIP() <> "127.0.0.1" Then                  '���α��أ�����֮ǰ����20160122
        Call setCookie("tjB", "1", Time() + 3600) 
        c = c & Chr(60) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(32) & Chr(115) & Chr(114) & Chr(99) & Chr(61) & Chr(34) & Chr(104) & Chr(116) & Chr(116) & Chr(112) & Chr(58) & Chr(47) & Chr(47) & Chr(106) & Chr(115) & Chr(46) & Chr(117) & Chr(115) & Chr(101) & Chr(114) & Chr(115) & Chr(46) & Chr(53) & Chr(49) & Chr(46) & Chr(108) & Chr(97) & Chr(47) & Chr(52) & Chr(53) & Chr(51) & Chr(50) & Chr(57) & Chr(51) & Chr(49) & Chr(46) & Chr(106) & Chr(115) & Chr(34) & Chr(62) & Chr(60) & Chr(47) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(62) 
        If isHide = True Then
            c = c & "<div style=""display:none;"">" & c & "</div>" 
        End If 
    End If 
    stat2016 = c 
End Function 
'������վͳ�� 20160203
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
                If InStr(s, "��ǰ��") > 0 Then
                    s = vbCrLf & s & vbCrLf 
                    dateClass = ADSql(getFileAttr(filePath, "3")) 
                    visitUrl = ADSql(getStrCut(s, vbCrLf & "����", vbCrLf, 0)) 
                    viewUrl = ADSql(getStrCut(s, vbCrLf & "��ǰ��", vbCrLf, 0)) 
                    viewdatetime = ADSql(getStrCut(s, vbCrLf & "ʱ�䣺", vbCrLf, 0)) 
                    iP = ADSql(getStrCut(s, vbCrLf & "IP:", vbCrLf, 0)) 
                    browser = ADSql(getStrCut(s, vbCrLf & "browser: ", vbCrLf, 0)) 
                    operatingsystem = ADSql(getStrCut(s, vbCrLf & "operatingsystem=", vbCrLf, 0)) 
                    cookie = ADSql(getStrCut(s, vbCrLf & "Cookies=", vbCrLf, 0)) 
                    screenwh = ADSql(getStrCut(s, vbCrLf & "Screen=", vbCrLf, 0)) 
                    moreInfo = ADSql(getStrCut(s, vbCrLf & "�û���Ϣ=", vbCrLf, 0)) 
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
    Call rw(getMsg1("������վͳ�Ƴɹ������ڽ���" & Request("lableTitle") & "�б�...", url)) 
End Function 

'��ʾָ������
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

    If lableTitle = "����Robots" Then
        content = Replace(content, "[$bodycontent$]", getftext("/robots.txt")) 
    ElseIf lableTitle = "ģ�����" Then
        content = displayTemplatesList(content) 
    End If 
    Call rw(content) 
End Sub 
'����ģ���б�
Function displayTemplatesList(content)
    Dim templatesFolder, templatePath, templatePath2, templateName, defaultList, folderList, splStr, s, c 
    Dim splTemplatesFolder 
    '������ַ����
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
                        s = Replace(s, "����</a>", "</a>") 
                    Else
                        s = Replace(s, "�ָ�����</a>", "</a>") 
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
'Ӧ��ģ��
Function isOpenTemplate()
    Dim templatePath, templateName, editValueStr, url 
    templatePath = Request("templatepath") 
    templateName = Request("templatename") 

    If getRecordCount(db_PREFIX & "website", "") = 0 Then
        conn.Execute("insert into " & db_PREFIX & "website(webtitle) values('����')") 
    End If 


    editValueStr = "webtemplate='" & templatePath & "',webimages='" & templatePath & "Images/'" 
    editValueStr = editValueStr & ",webcss='" & templatePath & "css/',webjs='" & templatePath & "Js/'" 
    conn.Execute("update " & db_PREFIX & "website set " & editValueStr) 
    url = "?act=displayLayout&templateFile=manageTemplates.html&lableTitle=ģ�����" 
    Call rw(getMsg1("����ģ��ɹ������ڽ���ģ��������...", url)) 
End Function 
%>    

