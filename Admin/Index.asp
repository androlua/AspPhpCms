<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-16
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#iNClUDe fILe = "../Inc/Config.Asp"-->
<%
dIM rOOt_PaTH : rOOt_PaTH = hANdLEpATh("./")
dIM wEBcOLuMNtYPe : wEBcOLuMNtYPe = "首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单"
dIM eDItORtYPe : eDItORtYPe = "asp"
dIM wEBvERsIOn
%>
<!--#Include File = "../Inc/admin_function.asp"-->
<!--#Include File = "../Inc/admin_setAccess.asp"-->
<%
sUB hANdLErESeTAcCEsSDaTA()
cALl rESeTAcCEsSDaTA()
eND sUB
dIM dB_pREfIX
dB_pREfIX = "xy_"
wEBvERsIOn = "v1.0011"
dIM cFG_WEbSItEUrL, cFG_WEbTItLE, cFG_FLaGS, cFG_WEbTEmPLaTE
sUB lOAdWEbCOnFIg()
cALl oPEnCOnN()
rS.oPEn "select * from " & dB_pREfIX & "website", cONn, 1, 1
iF nOT rS.eOF tHEn
cFG_WEbSItEUrL = rS("webSiteUrl") & ""
cFG_WEbTItLE = rS("webTitle") & ""
cFG_FLaGS = rS("flags") & ""
cFG_WEbTEmPLaTE = rS("webtemplate") & ""
eND iF : rS.cLOsE
eND sUB
iF sESsIOn("adminusername") = "" tHEn
iF rEQuESt("act") <> "" aND rEQuESt("act") <> "displayAdminLogin" aND rEQuESt("act") <> "login" aND rEQuESt("act") <> "resetAccessData" tHEn
cALl rR("?act=displayAdminLogin")
eND iF
eND iF
sUB dISpLAyADmINlOGiN()
iF sESsIOn("adminusername") <> "" tHEn
cALl aDMiNInDEx()
eLSe
cALl lOAdWEbCOnFIg()
dIM b
b = gETfTExT(rOOt_PaTH & "login.html")
b = rEPlACe(b, "{$webVersion$}", wEBvERsIOn)
b = rEPlACe(b, "{$Web_Title$}", cFG_WEbTItLE)
cALl rW(b)
eND iF
eND sUB
sUB lOGiN()
dIM b, c, d
b = rEPlACe(rEQuESt.fORm("username"), "'", "")
c = rEPlACe(rEQuESt.fORm("password"), "'", "")
c = mYMd5(c)
dIM e
cALl oPEnCOnN()
rS.oPEn "Select * From " & dB_pREfIX & "admin Where username='" & b & "' And pwd='" & c & "'", cONn, 1, 1
iF rS.eOF tHEn
iF rEQuESt.cOOkIEs("nLogin") = "" tHEn
cALl sETcOOkIE("nLogin", "1", tIMe() + 3600)
e = rEQuESt.cOOkIEs("nLogin")
eLSe
e = rEQuESt.cOOkIEs("nLogin")
cALl sETcOOkIE("nLogin", cINt(e) + 1, tIMe() + 3600)
eND iF
cALl rW(gETmSG1("账号密码错误<br>这是你第" & e & "次登录", "?act=displayAdminLogin"))
eLSe
sESsIOn("adminusername") = b
sESsIOn("adminId") = rS("Id")
sESsIOn("DB_PREFIX") = dB_pREfIX
d = "addDateTime='" & rS("UpDateTime") & "',UpDateTime='" & nOW() & "',RegIP='" & nOW() & "',UpIP='" & gETiP() & "'"
cONn.eXEcUTe("update " & dB_pREfIX & "admin set " & d & " where id=" & rS("id"))
cALl rW(gETmSG1("登录成功，正在进入后台...", "?act=adminIndex"))
eND iF : rS.cLOsE
eND sUB
sUB aDMiNOuT()
sESsIOn("adminusername") = ""
sESsIOn("adminId") = ""
cALl rW(gETmSG1("退出成功，正在进入登录界面...", "?act=displayAdminLogin"))
eND sUB
sUB aDMiNInDEx()
cALl lOAdWEbCOnFIg()
dIM b
b = gETfTExT(rOOt_PaTH & "adminIndex.html")
b = rEPlACe(b, "{$adminusername$}", sESsIOn("adminusername"))
b = rEPlACe(b, "{$frontView$}", "../" & eDItORtYPe & "web." & eDItORtYPe)
b = rEPlACe(b, "{$EDITORTYPE$}", eDItORtYPe)
b = rEPlACe(b, "{$Web_Title$}", cFG_WEbTItLE)
b = rEPlACe(b, "{$DB_PREFIX$}", dB_pREfIX)
cALl rW(b)
eND sUB
sUB dISpALyMAnAGeHAnDLe(a)
dIM b, c, d
b = rEQuESt("nPageSize")
iF b = "" tHEn
b = 10
eND iF
c = rEQuESt("lableTitle")
d = "order by sortrank asc"
iF a = "Bidding" tHEn
d = "order by nComputerSearch desc"
eLSeIF iNStR("|TableComment|", "|" & a & "|") > 0 tHEn
d = " order by adddatetime desc"
eLSeIF iNStR("|WebsiteStat|", "|" & a & "|") > 0 tHEn
d = " order by viewdatetime desc"
eLSeIF iNStR("|Admin|", "|" & a & "|") > 0 tHEn
d = ""
eND iF
cALl dISpALyMAnAGe(a, c, "*", b, d)
eND sUB
sUB aDDeDItHAnDLe(a, b)
iF a = "Admin" tHEn
cALl aDDeDItDIsPLaY(a, b, "")
eLSeIF a = "WebSite" tHEn
cALl aDDeDItDIsPLaY(a, b, "webdescription,websitebottom|textarea2")
eLSeIF a = "ArticleDetail" tHEn
cALl aDDeDItDIsPLaY(a, b, "sortrank||0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSeIF a = "WebColumn" tHEn
cALl aDDeDItDIsPLaY(a, b, "npagesize|numb|10,sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSeIF a = "OnePage" tHEn
cALl aDDeDItDIsPLaY(a, b, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSeIF a = "TableComment" tHEn
cALl aDDeDItDIsPLaY(a, b, "reply|textarea2,bodycontent|textarea2")
eLSeIF a = "WebLayout" tHEn
cALl aDDeDItDIsPLaY(a, b, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2,actioncontent|textarea2")
eLSeIF a = "WebModule" tHEn
cALl aDDeDItDIsPLaY(a, b, "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSe
cALl aDDeDItDIsPLaY(a, b, "")
eND iF
eND sUB
sUB sAVeADdEDiTHaNDlE(a, b)
iF a = "Admin" tHEn
cALl sAVeADdEDiT(a, b, "username,pseudonym,pwd|md5")
eLSeIF a = "WebSite" tHEn
cALl sAVeADdEDiT(a, b, "flags,websiteurl,webtemplate,webimages,webcss,webjs,webtitle,webkeywords,webdescription,websitebottom")
eLSeIF a = "ArticleDetail" tHEn
cALl sAVeADdEDiT(a, b, "relatedtags,labletitle,target,nofollow|numb|0,isonhtml|numb|0,parentid,title,foldername,filename,customaurl,smallimage,bigimage,author,sortrank||0,flags,webtitle,webkeywords,webdescription,bannerimage,simpleintroduction,bodycontent,titlecolor,noteinfo")
eLSeIF a = "WebColumn" tHEn
cALl sAVeADdEDiT(a, b, "npagesize|numb|10,labletitle,target,nofollow|numb|0,isonhtml|numb|0,columntype,parentid,columnname,columnenname,foldername,filename,customaurl,sortrank||0,webtitle,webkeywords,webdescription,showtitle,flags,simpleintroduction,bodycontent,noteinfo")
eLSeIF a = "OnePage" tHEn
cALl sAVeADdEDiT(a, b, "labletitle,target,nofollow|numb|0,isonhtml|numb|0,title,displaytitle,foldername,filename,customaurl,webtitle,webkeywords,webdescription,simpleintroduction,bodycontent,noteinfo")
eLSeIF a = "TableComment" tHEn
cALl sAVeADdEDiT(a, b, "through|numb|0,reply,bodycontent")
eLSeIF a = "WebLayout" tHEn
cALl sAVeADdEDiT(a, b, "layoutlist,layoutname,sortrank|numb,isdisplay|yesno,simpleintroduction,bodycontent,actioncontent,replacestyle")
eLSeIF a = "WebModule" tHEn
cALl sAVeADdEDiT(a, b, "modulename,moduletype,sortrank|numb,simpleintroduction,bodycontent")
eLSeIF a = "WebsiteStat" tHEn
cALl sAVeADdEDiT(a, b, "visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime|date,ip,dateclass,noteinfo")
eND iF
eND sUB
cALl oPEnCOnN()
sELeCT cASe rEQuESt("act")
cASe "dispalyManageHandle" : cALl dISpALyMAnAGeHAnDLe(rEQuESt("actionType"))
cASe "addEditHandle" : cALl aDDeDItHAnDLe(rEQuESt("actionType"), rEQuESt("lableTitle"))
cASe "saveAddEditHandle" : cALl sAVeADdEDiTHaNDlE(rEQuESt("actionType"), rEQuESt("lableTitle"))
cASe "delHandle" : cALl dEL(rEQuESt("actionType"), rEQuESt("lableTitle"))
cASe "sortHandle" : cALl sORtHAnDLe(rEQuESt("actionType"))
cASe "displayLayout" : dISpLAyLAyOUt()
cASe "saveRobots" : sAVeRObOTs()
cASe "saveSiteMap" : sAVeSItEMaP()
cASe "isOpenTemplate" : iSOpENtEMpLAtE()
cASe "updateWebsiteStat" : uPDaTEwEBsITeSTaT()
cASe "setAccess" : hANdLErESeTAcCEsSDaTA()
cASe "login" : lOGiN()
cASe "adminOut" : aDMiNOuT()
cASe "adminIndex" : aDMiNInDEx()
cASe eLSe : dISpLAyADmINlOGiN()
eND sELeCT
%>         

