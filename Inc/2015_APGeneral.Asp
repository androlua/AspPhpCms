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
<% 
'ASP��PHPͨ�ú���


'������ر�ǩ ��  ���Ľ�
Function aritcleRelatedTags(relatedTags)
    Dim c, splStr, s, url 
    splStr = Split(relatedTags, ",") 
    For Each s In splStr
        If s <> "" Then
            If c <> "" Then
                c = c & "," 
            End If 
            url = getColumnUrl(s, "name") 
            c = c & "<a href=""" & url & """ rel=""category tag"" class=""ablue"">" & s & "</a>" & vbCrLf 
        End If 
    Next 

    c = "<footer class=""articlefooter"">" & vbCrLf & "��ǩ�� " & c & "</footer>" & vbCrLf 
    aritcleRelatedTags = c 
End Function 


'����������id�б�
Function getRandArticleId(addSql, topNumb)
    Dim splStr, s, c, nIndex 
    rs.Open "select * from " & db_PREFIX & "articledetail " & addSql, conn, 1, 1 
    While Not rs.EOF
        If c <> "" Then c = c & "," 
        c = c & rs("id") 
    rs.MoveNext : Wend : rs.Close 
    getRandArticleId = RandomShow(c, ",", 4) 
    splStr = Split(c, ",") : c = "" : nIndex = 0 
    For Each s In splStr
        If c <> "" Then c = c & "," 
        c = c & s 
        nIndex = nIndex + 1 
        If nIndex >= topNumb Then Exit For 
    Next 
    getRandArticleId = c 
End Function 

'��һƪ���� �������sortrank(����)Ҳ���Ը�Ϊid,�����õ�ʱ���Ҫ��id
Function upArticle(parentid, lableName, lableValue)
    Dim sql 
    sql = "select * from " & db_PREFIX & "articledetail where parentid=" & parentid & " and " & lableName & "<" & lableValue & " order by " & lableName & " desc" 
    upArticle = handleUpDownArticle("��һƪ��", sql) 
End Function 
'��һƪ����
Function downArticle(parentid, lableName, lableValue)
    Dim sql 
    sql = "select * from " & db_PREFIX & "articledetail where parentid=" & parentid & " and " & lableName & ">" & lableValue & " order by " & lableName & " asc" 
    downArticle = handleUpDownArticle("��һƪ��", sql) 
End Function 
'��������ҳ
Function handleUpDownArticle(lableTitle, sql)
    Dim c, url 
    'call echo("sql",sql)
    rsx.Open sql, conn, 1, 1 
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/html/detail" & rsx("id")) 
        Else
            url = handleWebUrl("?act=detail&id=" & rsx("id")) 
        End If 
        c = "<a href=""" & url & """>" & lableTitle & rsx("title") & "</a>" 
    Else
        c = lableTitle & "û��" 
    End If : rsx.Close 
    handleUpDownArticle = c 
End Function 
'���RS��ַ ������һҳ ��һҳ
Function getRsUrl(fileName, customAUrl, defaultFileName)
    Dim url 
    '��Ĭ���ļ�����
    If fileName = "" Then
        fileName = defaultFileName 
    End If 
    '��ַ
    If fileName <> "" Then
        url = fileName 
        If InStr(LCase(url), ".html") = False And Right(url, 1) <> "/" Then
            url = url & ".html" 
        End If 
    End If 
    If Trim(customAUrl) <> "" Then
        url = Trim(customAUrl) 
    End If 
    If InStr(cfg_flags, "|addwebsite|") > 0 Then
        url = urlAddHttpUrl(cfg_webSiteUrl, url) 
    End If 
    getRsUrl = url 
End Function 

'��õ�ҳurl 20160114
Function getOnePageUrl(title)
    Dim url 
    rsx.Open "select * from " & db_PREFIX & "onepage where title='" & title & "'", conn, 1, 1 
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/page/page" & rsx("id")) 
        Else
            url = handleWebUrl("?act=onepage&id=" & rsx("id")) 
            If rsx("customAUrl") <> "" Then
                url = rsx("customAUrl") 
            End If 
        End If 
    End If : rsx.Close 

    getOnePageUrl = url 
End Function 
'�������
Function getArticleUrl(title)
    Dim url 
    rsx.Open "select * from " & db_PREFIX & "articledetail where title='" & title & "'", conn, 1, 1 
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/detail/" & rsx("id")) 
        Else
            url = handleWebUrl("?act=article&id=" & rsx("id")) 
            If rsx("customAUrl") <> "" Then
                url = rsx("customAUrl") 
            End If 
        End If 
    End If : rsx.Close 

    getArticleUrl = url 
End Function 
'�����Ŀurl 20160114
Function getColumnUrl(columnNameOrId, sType)
    Dim url, addSql 

    columnNameOrId = replaceGlobleVariable(columnNameOrId)    '�������� <a href="{$GetColumnUrl columnname='[$glb_columnName$]' $}" >����ͼƬ</a>

    If sType = "name" Then
        addSql = " where columnname='" & columnNameOrId & "'" 
    Else
        addSql = " where id=" & columnNameOrId & "" 
    End If 
    rsx.Open "select * from " & db_PREFIX & "webcolumn" & addSql, conn, 1, 1 
    If Not rsx.EOF Then
        If isMakeHtml = True Then
            url = getRsUrl(rsx("fileName"), rsx("customAUrl"), "/nav" & rsx("id")) 
        Else
            url = handleWebUrl("?act=nav&columnName=" & rsx("columnname")) 
            If rsx("customAUrl") <> "" Then
                url = rsx("customAUrl") 
            End If 
        End If 
    End If : rsx.Close 

    getColumnUrl = url 
End Function 
'�����Ŀ���ƶ�Ӧ��id
Function getColumnId(columnName)
    columnName = Replace(columnName, "'", "")                                       'ע�⣬���������
    getColumnId = -1 
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where columnName='" & columnName & "'", conn, 1, 1 
    If Not rsx.EOF Then
        getColumnId = rsx("id") 
    End If : rsx.Close 
End Function 


'�����ĿID��Ӧ������
Function getColumnName(columnID)
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where id=" & columnID, conn, 1, 1 
    If Not rsx.EOF Then
        getColumnName = rsx("columnName") 
    End If : rsx.Close 
End Function 




'�����ĿID��Ӧ������
Function getColumnType(columnID)
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where id=" & columnID, conn, 1, 1 
    If Not rsx.EOF Then
        getColumnType = rsx("columnType") 
    End If : rsx.Close 
End Function 

'�����ĿID��Ӧ������
Function getColumnBodyContent(columnID)
    rsx.Open "Select * from " & db_PREFIX & "webcolumn where id=" & columnID, conn, 1, 1 
    If Not rsx.EOF Then
        getColumnBodyContent = rsx("bodyContent") 
    End If : rsx.Close 
End Function 







'��վͳ��2014
Function webStat(folderPath)
    Dim dateTime, content, splStr 
    Dim thisUrl, goToUrl, caiShu, c, fileName, co, IE, XP 
    goToUrl = Request.ServerVariables("HTTP_REFERER") 
    thisUrl = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME") 
    caiShu = Request.ServerVariables("QUERY_STRING") 
    If caiShu <> "" Then
        thisUrl = thisUrl & "?" & caiShu 
    End If 
    goToUrl = Request("GoToUrl") 
    thisUrl = Request("ThisUrl") 
    co = Request.QueryString("co") 
    dateTime = Now() 
    content = Request.ServerVariables("HTTP_USER_AGENT") 
    content = Replace(content, "MSIE", "Internet Explorer") 
    content = Replace(content, "NT 5.0", "2000") 
    content = Replace(content, "NT 5.1", "XP") 
    content = Replace(content, "NT 5.2", "2003") 

    splStr = Split(content & ";;;;", ";") 
    IE = splStr(1) 
    XP = Trim(splStr(2)) 
    If Right(XP, 1) = ")" Then XP = Mid(XP, 1, Len(XP) - 1) 
    c = "����" & goToUrl & vbCrLf 
    c = c & "��ǰ��" & thisUrl & vbCrLf 
    c = c & "ʱ�䣺" & dateTime & vbCrLf 
    c = c & "IP:" & getIP() & vbCrLf 
    c = c & "IE:" & getBrType("") & vbCrLf 
    c = c & "Cookies=" & co & vbCrLf 
    c = c & "XP=" & XP & vbCrLf 
    c = c & "Screen=" & Request("screen") & vbCrLf                                  '��Ļ�ֱ���
    c = c & "�û���Ϣ=" & Request.ServerVariables("HTTP_USER_AGENT") & vbCrLf       '�û���Ϣ

    c = c & "-------------------------------------------------" & vbCrLf 
    'c=c & "CaiShu=" & CaiShu & vbcrlf
    fileName = folderPath & format_Time(Now(), 2) & ".txt" 
    Call createAddFile(fileName, c) 
    c = c & vbCrLf & fileName 
    c = Replace(c, vbCrLf, "\n") 
    c = Replace(c, """", "\""") 
    'Response.Write("eval(""var MyWebStat=\""" & C & "\"""")")
    webStat = c 
End Function 


'��ģ������
Function readTemplateModuleStr(filePath, defaultContent, ModuleId)
    Dim startStr, endStr, content, s 
    startStr = "<!--#Module " & ModuleId & " Start#-->" 
    endStr = "<!--#Module " & ModuleId & " End#-->" 
    'FilePath = ReplaceGlobleLable(FilePath)                '�滻ȫ����ǩ        '������2014 12 11

    '�ļ������ڣ���׷��ģ��·�� 20150616 ��VB��������
    If checkFile(filePath) = False Then
        filePath = WebTemplate & filePath 
    End If 

    If defaultContent <> "" Then
        content = defaultContent 
    ElseIf checkFile(filePath) = True Then
        content = GetFText(filePath) 
    Else
        content = code                                                               'Ĭ��������ָ������
    End If 
    'Call Die("��ʾ" & ModuleId & "," & Content)
    'Call Eerr(filepath & checkfile(filepath), Content)
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        readTemplateModuleStr = StrCut(content, startStr, endStr, 2) 
    Else
        readTemplateModuleStr = "ģ��[" & ModuleId & "]������,·��=" & filePath 
    End If 
End Function 
'��ģ���Ӧ����
Function findModuleStr(content, valueStr)
    Dim startStr, endStr, YuanStr, replaceStr, i, Block, BlockFile, action 
    For i = 1 To 9
        startStr = "[$�������� " : endStr = "$]" 
        If InStr(valueStr, startStr) > 0 And InStr(valueStr, endStr) > 0 Then
            action = StrCut(valueStr, startStr, endStr, 2) 
            Block = RParam(action, "Block") 
            BlockFile = RParam(action, "File") 
            If InStr(vbCrLf & ReadBlockList & vbCrLf, vbCrLf & Block & vbCrLf) = False Then
                ReadBlockList = ReadBlockList & Block & vbCrLf 
            End If 
            '���ļ����� ���������
            If BlockFile <> "" Then
                content = GetFText(BlockFile) 
            End If 
            YuanStr = startStr & action & endStr 
            replaceStr = "" 

            startStr = "<R#��������" & Block & " start#>" : endStr = "<R#��������" & Block & " end#>" 
            If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
                replaceStr = StrCut(content, startStr, endStr, 2) 
            Else
                startStr = "<!--#��������" & Block : endStr = "#-->" 
                If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
                    replaceStr = StrCut(content, startStr, endStr, 2) 
                End If 
            End If 
            'Call Eerr(YuanStr,ReplaceStr)
            valueStr = Replace(valueStr, YuanStr, replaceStr) 
        'Call Echo("ValueStr",ValueStr)
        Else
            'û��ģ��Ҫ������ ���˳�
            Exit For 
        End If 
    Next 
    findModuleStr = valueStr 
End Function 

'�жϴ�ֵ�Ƿ����
Function checkFunValue(action, FunName)
    checkFunValue =(Left(action, Len(FunName)) = FunName) 
End Function

%>    
