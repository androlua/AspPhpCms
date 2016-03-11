<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-03-11
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered by ASPPHPCMS 
'************************************************************
%>
<% 

'��ô�����ֶ��б�
Function getHandleFieldList(tableName, sType)
    Dim s 
    If WEB_CACHEContent = "" Then
        WEB_CACHEContent = getftext(WEB_CACHEFile) 
    End If 
    s = getConfigContentBlock(WEB_CACHEContent, "#" & tableName & sType & "#") 

    If s = "" Then
        If sType = "�ֶ������б�" Then
            s = LCase(getFieldConfigList(tableName)) 
        Else
            s = LCase(getFieldList(tableName)) 
        End If 
        WEB_CACHEContent = setConfigFileBlock(WEB_CACHEFile, s, "#" & tableName & sType & "#") 
        Call sysEcho("����", tableName & sType) 
    End If 
    getHandleFieldList = s 
End Function 
'��ģ������ 20160310
Function getTemplateContent(templateFileName)
    Call loadWebConfig() 
    '��ģ��
    Dim templateFile, customTemplateFile, content 
    customTemplateFile = ROOT_PATH & "template/" & db_PREFIX & "/" & templateFileName 
    'Ϊ�ֻ���
    If checkMobile() = True Then
        templateFile = ROOT_PATH & "/Template/mobile/" & templateFileName 
    ElseIf checkFile(customTemplateFile) = True Then
        templateFile = customTemplateFile 
    Else
        templateFile = ROOT_PATH & templateFileName 
    End If 
    content = getFText(templateFile) 
    content = Replace(content, "{$webVersion$}", webVersion)                        '��վ�汾
    content = Replace(content, "{$Web_Title$}", cfg_webTitle)                       '��վ����
    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)                        'ASP��PHP
    content = Replace(content, "{$adminDir$}", adminDir)                            '��̨Ŀ¼

    content = Replace(content, "[$adminId$]", Session("adminId"))              '����ԱID
    content = Replace(content, "{$adminusername$}", Session("adminusername"))       '�����˺�����
    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)                        '��������
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                      'ǰ̨
    content = Replace(content, "{$webVersion$}", webVersion)                        '�汾
    content = Replace(content, "{$WebsiteStat$}", getConfigFileBlock(WEB_CACHEFile, "#�ÿ���Ϣ#")) '����ÿ���Ϣ


    content = Replace(content, "{$DB_PREFIX$}", db_PREFIX)                          '��ǰ׺
    content = Replace(content, "{$adminflags$}", IIF(Session("adminflags") = "|*|", "��������Ա", "��ͨ����Ա")) '����Ա����
    content = Replace(content, "{$SERVER_SOFTWARE$}", Request.ServerVariables("SERVER_SOFTWARE")) '�������汾
    content = Replace(content, "{$SERVER_NAME$}", Request.ServerVariables("SERVER_NAME")) '��������ַ
    content = Replace(content, "{$LOCAL_ADDR$}", Request.ServerVariables("LOCAL_ADDR")) '������IP
    content = Replace(content, "{$SERVER_PORT$}", Request.ServerVariables("SERVER_PORT")) '�������˿�


    getTemplateContent = content 
End Function

'�����б���
Function displayFlags(flags)
    Dim c 
    'ͷ��[h]
    If InStr("|" & flags & "|", "|h|") > 0 Then
        c = c & "ͷ " 
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

    displayFlags = c 
End Function 


'��Ŀ���ѭ������       showColumnList(-1, 0,defaultList)
Function showColumnList(ByVal parentid, ByVal thisPId, nCount, ByVal action)
    Dim i, s, c, selectcolumnname, selStr, url, isFocus, sql, addSql 
    Dim rs : Set rs = CreateObject("Adodb.RecordSet")
        Dim fieldNameList, splFieldName, k, fieldName, replaceStr, startStr, endStr, topNumb, modI 
        Dim subHeaderStr, subFooterStr 

        subHeaderStr = getStrCut(action, "[subheader]", "[/subheader]", 2) 
        subFooterStr = getStrCut(action, "[subfooter]", "[/subfooter]", 2) 

        fieldNameList = getHandleFieldList(db_PREFIX & "webcolumn", "�ֶ��б�") 
        splFieldName = Split(fieldNameList, ",") 
        sql = "select * from " & db_PREFIX & "webcolumn where parentid=" & parentid 
        '����׷��SQL
        startStr = "[sql-" & nCount & "]" : endStr = "[/sql-" & nCount & "]" 
        If InStr(action, startStr) = False And InStr(action, endStr) = False Then
            startStr = "[sql]" : endStr = "[/sql]" 
        End If 
        addSql = getStrCut(action, startStr, endStr, 2) 
        If addSql <> "" Then
            sql = getWhereAnd(sql, addSql) 
        End If 
        'call echo("addsql",addsql)
        rs.Open sql & " order by sortrank asc", conn, 1, 1 
        For i = 1 To rs.RecordCount
            If Not rs.EOF Then
                selStr = "" 
                isFocus = False 
                If CStr(rs("id")) = CStr(thisPId) Then
                    selStr = " selected " 
                    isFocus = True 
                End If 

                '��ַ�ж�
                If isFocus = True Then
                    startStr = "[list-focus]" : endStr = "[/list-focus]" 
                Else
                    startStr = "[list-" & i & "]" : endStr = "[/list-" & i & "]" 
                End If 

                '�����ʱ����ǰ����20160202
                If i = topNumb And isFocus = False Then
                    startStr = "[list-end]" : endStr = "[/list-end]" 
                End If 
                '��[list-mod2]  [/list-mod2]    20150112
                For modI = 6 To 2 Step - 1
                    If InStr(action, startStr) = False And i Mod modI = 0 Then
                        startStr = "[list-mod" & modI & "]" : endStr = "[/list-mod" & modI & "]" 
                        If InStr(action, startStr) > 0 Then
                            Exit For 
                        End If 
                    End If 
                Next 

                'û������Ĭ��
                If InStr(action, startStr) = False Then
                    startStr = "[list]" : endStr = "[/list]" 
                End If 

                'call rwend(action)
                'call echo(startStr,endStr)
                If InStr(action, startStr) > 0 And InStr(action, endStr) > 0 Then
                    s = strCut(action, startStr, endStr, 2) 

                    s = replaceValueParam(s, "id", rs("id")) 
                    s = replaceValueParam(s, "selected", selStr) 
                    selectcolumnname = rs("columnname") 
                    If nCount >= 1 Then
                        selectcolumnname = copystr("&nbsp;&nbsp;", nCount) & "����" & selectcolumnname 
                    End If 
                    s = replaceValueParam(s, "selectcolumnname", selectcolumnname) 


                    For k = 0 To UBound(splFieldName)
                        If splFieldName(k) <> "" Then
                            fieldName = splFieldName(k) 
                            replaceStr = rs(fieldName) & "" 

                            s = replaceValueParam(s, fieldName, replaceStr) 
                        End If 
                    Next 

                    url = WEB_VIEWURL & "?act=nav&columnName=" & rs("columnname") 
                    '�Զ�����ַ
                    If Trim(rs("customaurl")) <> "" Then
                        url = Trim(rs("customaurl")) 
                    End If 
                    s = Replace(s, "[$viewWeb$]", url) 
                    s = replaceValueParam(s, "url", url) 

                    If EDITORTYPE = "php" Then
                        s = Replace(s, "[$phpArray$]", "[]") 
                    Else
                        s = Replace(s, "[$phpArray$]", "") 
                    End If 

                    's=copystr("",nCount) & rs("columnname") & "<hr>"
                    c = c & s & vbCrLf 
                    s = showColumnList(rs("id"), thisPId, nCount + 1, action) 
                    If s <> "" Then s = vbCrLf & subHeaderStr & s & subFooterStr 
                    c = c & s 
                End If 
            End If 
        rs.MoveNext : Next : rs.Close 
        showColumnList = c 
End Function


'msg1  ����
Function getMsg1(msgStr, url)
    Dim content 
    content = getFText(ROOT_PATH & "msg.html") 
    msgStr = msgStr & "<br>" & jsTiming(url, 5) 
    content = Replace(content, "[$msgStr$]", msgStr) 
    content = Replace(content, "[$url$]", url) 
    getMsg1 = content 
End Function 

'���Ȩ��
Function checkPower(powerName)
    If InStr("|" & Session("adminflags") & "|", "|" & powerName & "|") > 0 Or InStr("|" & Session("adminflags") & "|", "|*|") > 0 Then
        checkPower = True 
    Else
        checkPower = False 
    End If 
End Function 
'�����̨����Ȩ��
Function handlePower(powerName)
    If checkPower(powerName) = False Then
        Call eerr("��ʾ", "��û�С�" & powerName & "��Ȩ�ޣ�<a href='javascript:history.go(-1);'>�������</a>") 
    End If 
End Function 
'������Ϣ
Function sysEcho(title, content)
    If openTestEcho = True Then
        Call echo(title, content) 
    End If 
End Function 



'��ʾ�����б�
Function dispalyManage(actionName, lableTitle, ByVal nPageSize, addSql)
    Call handlePower("��ʾ" & lableTitle)                                           '����Ȩ�޴���
    Call loadWebConfig() 
    Dim content, i, s, c, fieldNameList, sql, action 
    Dim x, url, nCount, nPage 
    Dim idInputName 

    Dim tableName, j, splxx 
    Dim fieldName                                                                   '�ֶ�����
    Dim splFieldName                                                                '�ָ��ֶ�
    Dim searchfield, keyWord                                                        '�����ֶΣ������ؼ���
    Dim parentid                                                                    '��Ŀid

    Dim replaceStr                                                                  '�滻�ַ�
    tableName = LCase(actionName)                                                   '������

    searchfield = Request("searchfield")                                            '��������ֶ�ֵ
    keyWord = Request("keyword")                                                    '��������ؼ���ֵ
    If Request.Form("parentid") <> "" Then
        parentid = Request.Form("parentid") 
    Else
        parentid = Request.QueryString("parentid") 
    End If 

    Dim id 
    id = rq("id") 

    fieldNameList = getHandleFieldList(db_PREFIX & tableName, "�ֶ��б�") 

    fieldNameList = specialStrReplace(fieldNameList)                                '�����ַ�����
    splFieldName = Split(fieldNameList, ",")                                        '�ֶηָ������
	
    '��ģ�� 
    content=getTemplateContent("manage" & tableName & ".html" )

    action = getStrCut(content, "[list]", "[/list]", 2) 
    '��վ��Ŀ��������      ��Ŀ��һ��20160301
    If actionName = "WebColumn" Then
        action = getStrCut(content, "[action]", "[/action]", 1) 
        content = Replace(content, action, showColumnList( -1, "", 0, action)) 
    Else
        If keyWord <> "" And searchfield <> "" Then
            addSql = getWhereAnd(" where " & searchfield & " like '%" & keyWord & "%' ", addSql) 
        End If 
        If parentid <> "" Then
            addSql = getWhereAnd(" where parentid=" & parentid & " ", addSql) 
        End If 
        'call echo(tableName,addsql)
        sql = "select * from " & db_PREFIX & tableName & " " & addSql 
        '���SQL
        If checksql(sql) = False Then
            Call errorLog("������ʾ��<br>action=" & action & "<hr>sql=" & sql & "<br>") 
            Exit Function 
        End If 
        rs.Open sql, conn, 1, 1 
        nCount = rs.RecordCount 
        nPage = Request("page") 
        content = Replace(content, "[$pageInfo$]", webPageControl(nCount, nPageSize, nPage, url, "")) 

        If EDITORTYPE = "asp" Then
            x = getRsPageNumber(rs, nCount, nPageSize, nPage)                                '���Rsҳ��                                                  '��¼����
        Else
            If nPage <> "" Then
                nPage = nPage - 1 
            End If 
            sql = "select * from " & db_PREFIX & "" & tableName & " " & addSql & " limit " & nPageSize * nPage & "," & nPageSize 
            rs.Open sql, conn, 1, 1 
            x = rs.RecordCount 
        End If 
        For i = 1 To x
			'��PHP��$rs=mysql_fetch_array($rsObj);											//��PHP�ã���Ϊ�� asptophpת��������
            s = Replace(action, "[$id$]", rs("id")) 
            For j = 0 To UBound(splFieldName)
                If splFieldName(j) <> "" Then
                    splxx = Split(splFieldName(j) & "|||", "|") 
                    fieldName = splxx(0) 
                    replaceStr = rs(fieldName) & "" 
                    '�������촦��
                    If fieldName = "flags" Then
                        replaceStr =displayFlags(replaceStr) 
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
			s = replaceValueParam(s, "cfg_websiteurl", cfg_webSiteUrl)
			
            c = c & s 
        rs.MoveNext : Next : rs.Close 
        content = Replace(content, "[list]" & action & "[/list]", c) 
        '���ύ����parentid(��ĿID) searchfield(�����ֶ�) keyword(�ؼ���) addsql(����)
        url = "?page=[id]&addsql=" & Request("addsql") & "&keyword=" & Request("keyword") & "&searchfield=" & Request("searchfield") & "&parentid=" & Request("parentid") 
        url = getUrlAddToParam(getUrl(), url, "replace") 
        'call echo("url",url)
        content = Replace(content, "[list]" & action & "[/list]", c) 

    End If 

    If InStr(content, "[$input_parentid$]") > 0 Then
        action = "[list]<option value=""[$id$]""[$selected$]>[$selectcolumnname$]</option>[/list]" 
        c = "<select name=""parentid"" id=""parentid""><option value="""">�� ѡ����Ŀ ��</option>" & showColumnList( -1, parentid, 0, action) & vbCrLf & "</select>" 
        content = Replace(content, "[$input_parentid$]", c)                        '�ϼ���Ŀ
    End If 

    content = replaceValueParam(content, "searchfield", Request("searchfield"))     '�����ֶ�
    content = replaceValueParam(content, "keyword", Request("keyword"))             '�����ؼ���
    content = replaceValueParam(content, "nPageSize", Request("nPageSize"))         'ÿҳ��ʾ����
    content = replaceValueParam(content, "addsql", Request("addsql"))               '׷��sqlֵ����
    content = replaceValueParam(content, "tableName", tableName)                    '������
    content = replaceValueParam(content, "actionType", Request("actionType"))       '��������
    content = replaceValueParam(content, "lableTitle", Request("lableTitle"))       '��������
    content = replaceValueParam(content, "id", id)                                  'id
    content = replaceValueParam(content, "page", Request("page"))                   'ҳ

    content = replaceValueParam(content, "parentid", Request("parentid"))           '��Ŀid


    url = getUrlAddToParam(getThisUrl(), "?parentid=&keyword=&searchfield=&page=", "delete") 
    content = replaceValueParam(content, "position", "ϵͳ���� > <a href='" & url & "'>" & lableTitle & "�б�</a>") 'positionλ��


    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)                        'asp��phh
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                      'ǰ�������ַ
    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 



    content = content & stat2016(True) 
    Call rw(content) 
End Function 


'����޸Ľ���
Function addEditDisplay(actionName, lableTitle, ByVal fieldNameList)
    Dim content, addOrEdit, splxx, i, j, s, c, tableName, url, aStr 
    Dim fieldName                                                                   '�ֶ�����
    Dim splFieldName                                                                '�ָ��ֶ�
    Dim fieldSetType                                                                '�ֶ���������
    Dim fieldValue                                                                  '�ֶ�ֵ
    Dim sql                                                                         'sql���
    Dim defaultList                                                                 'Ĭ���б�
    Dim flagsInputName                                                              '��input���Ƹ�ArticleDetail��
    Dim titlecolor                                                                  '������ɫ
    Dim styleStr                                                                    '��ʽ�ַ�
    Dim flags                                                                       '��
    Dim splStr, fieldConfig, defaultFieldValue, postUrl 


    Dim id 
    id = rq("id") 
    addOrEdit = "���" 
    If id <> "" Then
        addOrEdit = "�޸�" 
    End If 

    If InStr(",Admin,", "," & actionName & ",") > 0 And id = Session("adminId") & "" Then
        Call handlePower("�޸�����")                                                    '����Ȩ�޴���
    Else
        Call handlePower("��ʾ" & lableTitle)                                           '����Ȩ�޴���
    End If 



    fieldNameList = "," & specialStrReplace(fieldNameList) & ","                    '�����ַ����� �Զ����ֶ��б�
    tableName = LCase(actionName)                                                   '������

    Dim systemFieldList                                                             '���ֶ��б�
    systemFieldList = getHandleFieldList(db_PREFIX & tableName, "�ֶ������б�") 
    splStr = Split(systemFieldList, ",") 


    '��ģ�� 
    content=getTemplateContent("addEdit" & tableName & ".html" )

    '�رձ༭��
    If InStr(cfg_flags, "|iscloseeditor|") > 0 Then
        s = getStrCut(content, "<!--#editor start#-->", "<!--#editor end#-->", 1) 
        If s <> "" Then
            content = Replace(content, s, "") 
        End If 
    End If 

    'id=*  �Ǹ���վ����ʹ�õģ���Ϊ��û�й����б�ֱ�ӽ����޸Ľ���
    If id = "*" Then
        sql = "select * from " & db_PREFIX & "" & tableName 
    Else
        sql = "select * from " & db_PREFIX & "" & tableName & " where id=" & id 
    End If 
    If id <> "" Then
        rs.Open sql, conn, 1, 1 
        If Not rs.EOF Then
            id = rs("id") 
        End If 
        '������ɫ
        If InStr(systemFieldList, ",titlecolor|") > 0 Then
            titlecolor = rs("titlecolor") 
        End If 
        '��
        If InStr(systemFieldList, ",flags|") > 0 Then
            flags = rs("flags") 
        End If 
    End If 

    If InStr(",Admin,", "," & actionName & ",") > 0 Then
        '���޸ĳ�������Ա��ʱ�䣬�ж����Ƿ��г�������ԱȨ��
        If flags = "|*|" Then
            Call handlePower("*")                                                           '����Ȩ�޴���
        End If 
        '��������Ա��ʾ                '������ؼ� id<>""  Ҫ��Ȼ�жϳ���20160229
        If flags = "|*|" Or(Session("adminId") = id And Session("adminflags") = "|*|" And id <> "") Then
            s = getStrCut(content, "<!--��ͨ����Ա-->", "<!--��ͨ����Աend-->", 1) 
            content = Replace(content, s, "") 
            s = getStrCut(content, "<!--�û�Ȩ��-->", "<!--�û�Ȩ��end-->", 1) 
            content = Replace(content, s, "") 

            'call echo("","1")
            '��ͨ����ԱȨ��ѡ���б�
        ElseIf(id <> "" Or addOrEdit = "���") And Session("adminflags") = "|*|" Then
            s = getStrCut(content, "<!--��������Ա-->", "<!--��������Աend-->", 1) 
            content = Replace(content, s, "") 
            s = getStrCut(content, "<!--�û�Ȩ��-->", "<!--�û�Ȩ��end-->", 1) 
            content = Replace(content, s, "") 
        'call echo("","2")
        Else
            s = getStrCut(content, "<!--��������Ա-->", "<!--��������Աend-->", 1) 
            content = Replace(content, s, "") 
            s = getStrCut(content, "<!--��ͨ����Ա-->", "<!--��ͨ����Աend-->", 1) 
            content = Replace(content, s, "") 
        'call echo("","3")
        End If 
    End If
    For Each fieldConfig In splStr
        If fieldConfig <> "" Then
            splxx = Split(fieldConfig & "|||", "|") 
            fieldName = splxx(0)                                                            '�ֶ�����
            fieldSetType = splxx(1)                                                         '�ֶ���������
            defaultFieldValue = splxx(2)                                                    'Ĭ���ֶ�ֵ
            '���Զ���
            If InStr(fieldNameList, "," & fieldName & "|") > 0 Then
                fieldConfig = Mid(fieldNameList, InStr(fieldNameList, "," & fieldName & "|") + 1) 
                fieldConfig = Mid(fieldConfig, 1, InStr(fieldConfig, ",") - 1) 
                splxx = Split(fieldConfig & "|||", "|") 
                fieldSetType = splxx(1)                                                         '�ֶ���������
                defaultFieldValue = splxx(2)                                                    'Ĭ���ֶ�ֵ
            End If 

            fieldValue = defaultFieldValue 
            If addOrEdit = "�޸�" Then
                fieldValue = rs(fieldName) 
            End If 
            'call echo(fieldConfig,fieldValue)

            '������������ʾΪ��
            If fieldSetType = "password" Then
                fieldValue = "" 
            End If 
            If fieldValue <> "" Then
                fieldValue = Replace(Replace(fieldValue, """", "&quot;"), "<", "&lt;") '��input�����ֱ����ʾ"�Ļ��ͻ������
            End If 
            If InStr(",ArticleDetail,WebColumn,", "," & actionName & ",") > 0 And fieldName = "parentid" Then
                defaultList = "[list]<option value=""[$id$]""[$selected$]>[$selectcolumnname$]</option>[/list]" 
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
                    s = s & Replace(inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|b|") > 0, 1, 0), "b", "�Ӵ�[b]"), "", "") 
                    s = Replace(s, " value='b'>", " onclick='input_font_bold()' value='b'>") 


                ElseIf actionName = "WebColumn" Then
                    s = inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|top|") > 0, 1, 0), "top", "������ʾ") 
                    s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|foot|") > 0, 1, 0), "foot", "�ײ���ʾ") 
                    s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|left|") > 0, 1, 0), "left", "�����ʾ") 
                    s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|center|") > 0, 1, 0), "center", "�м���ʾ") 
                    s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|right|") > 0, 1, 0), "right", "�ұ���ʾ") 
                    s = s & inputCheckBox3(flagsInputName, iif(InStr("|" & fieldValue & "|", "|other|") > 0, 1, 0), "other", "����λ����ʾ") 
                End If 
                content = Replace(content, "[$input_flags$]", s) 
 

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
            content = replaceValueParam(content, fieldName, fieldValue) 
        End If 
    Next 
    If id <> "" Then
        rs.Close 
    End If 
    'call die("")
    content = Replace(content, "[$switchId$]", Request("switchId")) 


    url = getUrlAddToParam(getThisUrl(), "?act=dispalyManageHandle", "replace") 
    'call echo(getThisUrl(),url)
    If InStr("|WebSite|", "|" & actionName & "|") = False Then
        aStr = "<a href='" & url & "'>" & lableTitle & "�б�</a> > " 
    End If 

    content = replaceValueParam(content, "position", "ϵͳ���� > " & aStr & addOrEdit & "��Ϣ") 

    content = replaceValueParam(content, "searchfield", Request("searchfield"))     '�����ֶ�
    content = replaceValueParam(content, "keyword", Request("keyword"))             '�����ؼ���
    content = replaceValueParam(content, "nPageSize", Request("nPageSize"))         'ÿҳ��ʾ����
    content = replaceValueParam(content, "addsql", Request("addsql"))               '׷��sqlֵ����
    content = replaceValueParam(content, "tableName", tableName)                    '������
    content = replaceValueParam(content, "actionType", Request("actionType"))       '��������
    content = replaceValueParam(content, "lableTitle", Request("lableTitle"))       '��������
    content = replaceValueParam(content, "id", id)                                  'id
    content = replaceValueParam(content, "page", Request("page"))                   'ҳ

    content = replaceValueParam(content, "parentid", Request("parentid"))           '��Ŀid


    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)                        'asp��phh
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL)                      'ǰ�������ַ
    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 



    postUrl = getUrlAddToParam(getThisUrl(), "?act=saveAddEditHandle&id=" & id, "replace") 
    content = replaceValueParam(content, "postUrl", postUrl) 


    '20160113
    If EDITORTYPE = "asp" Then
        content = Replace(content, "[$phpArray$]", "") 
    ElseIf EDITORTYPE = "php" Then
        content = Replace(content, "[$phpArray$]", "[]") 
    End If 

    Call rw(content) 
End Function 



'����ģ��
Function saveAddEdit(actionName, lableTitle, ByVal fieldNameList)
    Dim tableName, url, listUrl 
    Dim id, addOrEdit,sql

    id = Request("id") 
    addOrEdit = IIF(id = "", "���", "�޸�") 

    Call handlePower(addOrEdit & lableTitle)                                        '����Ȩ�޴���


    Call OpenConn() 

    fieldNameList = "," & specialStrReplace(fieldNameList) & ","                    '�����ַ����� �Զ����ֶ��б�
    tableName = LCase(actionName)                                                   '������


    sql = getPostSql(id, tableName, fieldNameList) 
    '���SQL
    If checksql(sql) = False Then
        Call errorLog("������ʾ��<hr>sql=" & sql & "<br>") 
        Exit Function 
    End If
    'conn.Execute(sql) 				'���SQLʱ�Ѿ������ˣ�����Ҫ��ִ����
    '����վ���õ�������Ϊ��̬����ʱɾ����index.html     ���������л�20160216
    If LCase(actionName) = "website" Then
        If InStr(Request("flags"), "htmlrun") = False Then
            Call deleteFile("../index.html") 
        End If 
    End If 

    listUrl = getUrlAddToParam(getThisUrl(), "?act=dispalyManageHandle", "replace") 

    '���
    If id = "" Then

        url = getUrlAddToParam(getThisUrl(), "?act=addEditHandle", "replace") 

        Call rw(getMsg1("������ӳɹ������ؼ������" & lableTitle & "...<br><a href='" & listUrl & "'>����" & lableTitle & "�б�</a>", url)) 
    Else
        url = getUrlAddToParam(getThisUrl(), "?act=addEditHandle&switchId=" & Request.Form("switchId"), "replace") 

        'û�з����б��������
        If InStr("|WebSite|", "|" & actionName & "|") > 0 Then
            Call rw(getMsg1("�����޸ĳɹ�", url)) 
        Else
            Call rw(getMsg1("�����޸ĳɹ������ڽ���" & lableTitle & "�б�...<br><a href='" & url & "'>�����༭</a>", listUrl)) 
        End If 
    End If 
    Call writeSystemLog(tableName, addOrEdit & lableTitle)                          'ϵͳ��־
End Function 

'ɾ��
Function del(actionName, lableTitle)
    Dim tableName, url 
    tableName = LCase(actionName)                                                   '������
    Dim id 

    Call handlePower("ɾ��" & lableTitle)                                           '����Ȩ�޴���



    id = Request("id") 
    If id <> "" Then
    	url = getUrlAddToParam(getThisUrl(), "?act=dispalyManageHandle", "replace") 
        Call OpenConn() 


        '����Ա
        If actionName = "Admin" Then
            rs.Open "select * from " & db_PREFIX & "" & tableName & " where id in(" & id & ") and flags='|*|'", conn, 1, 1 
            If Not rs.EOF Then
                Call rwend(getMsg1("ɾ��ʧ�ܣ�ϵͳ����Ա������ɾ�������ڽ���" & lableTitle & "�б�...", url)) 
            End If : rs.Close 
        End If 
        conn.Execute("delete from " & db_PREFIX & "" & tableName & " where id in(" & id & ")") 
        Call rw(getMsg1("ɾ��" & lableTitle & "�ɹ������ڽ���" & lableTitle & "�б�...", url)) 

        Call writeSystemLog(tableName, "ɾ��" & lableTitle)                             'ϵͳ��־
    End If 
End Function 


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
    url = getUrlAddToParam(getThisUrl(), "?act=dispalyManageHandle", "replace") 
    Call rw(getMsg1("����������ɣ����ڷ����б�...", url)) 

    Call writeSystemLog(tableName, "����" & Request("lableTitle"))                  'ϵͳ��־
End Function 

'�����ֶ�
function updateField()
	dim tableName,id,fieldname,fieldvalue,fieldNameList,url
	tableName = LCase(request("actionType"))        '������
	id = request("id")								'id
	fieldname=lcase(request("fieldname"))				'�ֶ�����
	fieldvalue=request("fieldvalue")				'�ֶ�ֵ
	
    fieldNameList = getHandleFieldList(db_PREFIX & tableName, "�ֶ��б�")
	'call echo(fieldname,fieldvalue)
	'call echo("fieldNameList",fieldNameList)
	if instr(fieldNameList,","& fieldname &",")=false then
		call eerr("������ʾ","��("& tableName &")�������ֶ�("& fieldname &")")
	else
		conn.Execute("update " & db_PREFIX & tableName & " set "& fieldname &"=" & fieldvalue & " where id=" & id) 
	end if
	
    url = getUrlAddToParam(getThisUrl(), "?act=dispalyManageHandle", "replace") 
    Call rw(getMsg1("�����ɹ������ڷ����б�...", url)) 
	
end function



'����robots.txt 20160118
Sub saveRobots()
    Dim bodycontent, url 
    Call handlePower("�޸�����Robots")                                              '����Ȩ�޴���
    bodycontent = Request("bodycontent") 
    Call createfile(ROOT_PATH & "/../robots.txt", bodycontent) 
    url = "?act=displayLayout&templateFile=makeRobots.html&lableTitle=����Robots" 
    Call rw(getMsg1("����Robots�ɹ������ڽ���Robots����...", url)) 

    Call writeSystemLog("", "����Robots.txt")                                       'ϵͳ��־
End Sub 


'����sitemap.xml 20160118
Sub saveSiteMap()
    Dim isWebRunHtml                                                                '�Ƿ�Ϊhtml��ʽ��ʾ��վ
    Dim changefreg                                                                  '����Ƶ��
    Dim priority                                                                    '���ȼ�
    Dim c, url 
    Call handlePower("�޸�����SiteMap")                                             '����Ȩ�޴���

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
    Call createfile(ROOT_PATH & "/../sitemap.xml", c) 
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
        templateContent = getftext(ROOT_PATH & "templateSiteMap.html") 


        templateContent = Replace(templateContent, "{$content$}", c) 
        templateContent = Replace(templateContent, "{$Web_Title$}", cfg_webTitle) 
        Call createfile(ROOT_PATH & "/../sitemap.html", templateContent) 
    	Call echo("����sitemap.html�ļ��ɹ�", "<a href='/sitemap.html' target='_blank'>���Ԥ��sitemap.html</a>") 
    End If 
    Call writeSystemLog("", "����sitemap.xml")                                      'ϵͳ��־
End Sub 



'ͳ��2016 stat2016(true)
Function stat2016(isHide)
    Dim c 
    If Request.Cookies("tjB") = "" And getIP() <> "127.0.0.1" Then                  '���α��أ�����֮ǰ����20160122
        Call setCookie("tjB", "1", Time() + 3600) 
        c = c & Chr(60) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(32) & Chr(115) & Chr(114) & Chr(99) & Chr(61) & Chr(34) & Chr(104) & Chr(116) & Chr(116) & Chr(112) & Chr(58) & Chr(47) & Chr(47) & Chr(106) & Chr(115) & Chr(46) & Chr(117) & Chr(115) & Chr(101) & Chr(114) & Chr(115) & Chr(46) & Chr(53) & Chr(49) & Chr(46) & Chr(108) & Chr(97) & Chr(47) & Chr(52) & Chr(53) & Chr(51) & Chr(50) & Chr(57) & Chr(51) & Chr(49) & Chr(46) & Chr(106) & Chr(115) & Chr(34) & Chr(62) & Chr(60) & Chr(47) & Chr(115) & Chr(99) & Chr(114) & Chr(105) & Chr(112) & Chr(116) & Chr(62) 
        If isHide = True Then
            c = "<div style=""display:none;"">" & c & "</div>" 
        End If 
    End If 
    stat2016 = c 
End Function 


'������վͳ�� 20160203
Function updateWebsiteStat()
    Dim content, splStr, splxx, filePath 
    Dim url, s, visitUrl, viewUrl, viewdatetime, ip, browser, operatingsystem, cookie, screenwh, moreInfo, ipList, dateClass, nCount 

    Call handlePower("������վͳ��")                                                '����Ȩ�޴���

    conn.Execute("delete from " & db_PREFIX & "websitestat") 
    content = getDirTxtList(adminDir & "/data/stat/") 
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
                    ip = ADSql(getStrCut(s, vbCrLf & "IP:", vbCrLf, 0)) 
                    browser = ADSql(getStrCut(s, vbCrLf & "browser: ", vbCrLf, 0)) 
                    operatingsystem = ADSql(getStrCut(s, vbCrLf & "operatingsystem=", vbCrLf, 0)) 
                    cookie = ADSql(getStrCut(s, vbCrLf & "Cookies=", vbCrLf, 0)) 
                    screenwh = ADSql(getStrCut(s, vbCrLf & "Screen=", vbCrLf, 0)) 
                    moreInfo = ADSql(getStrCut(s, vbCrLf & "�û���Ϣ=", vbCrLf, 0)) 
                    browser = ADSql(getBrType(moreInfo)) 
                    If InStr(vbCrLf & ipList & vbCrLf, vbCrLf & ip & vbCrLf) = False Then
                        ipList = ipList & ip & vbCrLf 
                    End If 
                    screenwh = Left(screenwh, 20) 
                    If 1 = 2 Then
                        Call echo("dateClass", dateClass) 
                        Call echo("visitUrl", visitUrl) 
                        Call echo("viewUrl", viewUrl) 
                        Call echo("viewdatetime", viewdatetime) 
                        Call echo("IP", ip) 
                        Call echo("browser", browser) 
                        Call echo("operatingsystem", operatingsystem) 
                        Call echo("cookie", cookie) 
                        Call echo("screenwh", screenwh) 
                        Call echo("moreInfo", moreInfo) 
                        Call hr() 
                    End If 
                    conn.Execute("insert into " & db_PREFIX & "websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values('" & visitUrl & "','" & viewUrl & "','" & browser & "','" & operatingsystem & "','" & screenwh & "','" & moreInfo & "','" & viewdatetime & "','" & ip & "','" & dateClass & "')") 
                End If 
            Next 
        End If 
    Next 
    url = getUrlAddToParam(getThisUrl(), "?act=dispalyManageHandle", "replace") 

    Call rw(getMsg1("������վͳ�Ƴɹ������ڽ���" & Request("lableTitle") & "�б�...", url)) 
    Call writeSystemLog("", "������վͳ��")                                         'ϵͳ��־
End Function 

'��ϸ��վͳ��
Function websiteDetail()
    Dim content, splxx, filePath 
    Dim s, ip, ipList
    Dim nIP, nPV, i, timeStr, c 

    Call handlePower("��վͳ����ϸ")                                                '����Ȩ�޴���

    For i = 1 To 30
        timeStr = getHandleDate((i - 1) * - 1)                                          'format_Time(Now() - i + 1, 2)
        filePath = adminDir & "/data/stat/" & timeStr & ".txt" 
        content = getftext(filePath) 
        splxx = Split(content, vbCrLf & "-------------------------------------------------" & vbCrLf) 
        nIP = 0
		nPv=0
        ipList = "" 
        For Each s In splxx
            If InStr(s, "��ǰ��") > 0 Then
                s = vbCrLf & s & vbCrLf 
                ip = ADSql(getStrCut(s, vbCrLf & "IP:", vbCrLf, 0)) 
				nPV=nPV+1
                If InStr(vbCrLf & ipList & vbCrLf, vbCrLf & ip & vbCrLf) = False Then
                    ipList = ipList & ip & vbCrLf
                    nIP = nIP + 1
                End If
            End If 
        Next 
        Call echo(timeStr, "IP(" & nIP & ") PV("& nPV &")") 
        If i < 4 Then
            c = c & timeStr & " IP(" & nIP & ") PV("& nPV &")" & "<br>" 
        End If 
    Next 

    Call setConfigFileBlock(WEB_CACHEFile, c, "#�ÿ���Ϣ#") 
    Call writeSystemLog("", "��ϸ��վͳ��")                                         'ϵͳ��־

End Function 

'��ʾָ������
Sub displayLayout()
    Dim content, lableTitle 
    Call handlePower("��ʾ" & lableTitle)                                           '����Ȩ�޴���
	'��ģ�� 
    lableTitle = Request("lableTitle") 
    content=getTemplateContent(Request("templateFile"))
    content = Replace(content, "[$position$]", lableTitle) 
    content = replaceValueParam(content, "lableTitle", lableTitle) 
	

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

    Call handlePower("����ģ��")                                                    '����Ȩ�޴���

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
    Call writeSystemLog("", "Ӧ��ģ��" & templatePath)                              'ϵͳ��־
End Function 


%>           

