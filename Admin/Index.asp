<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-02
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By �ƶ� 
'************************************************************
%>
<!--#iNClUDe fILe = "../Inc/Config.Asp"-->
<%
dIM rOOt_PaTH : rOOt_PaTH = hANdLEpATh("./")
dIM wEBcOLuMNtYPe : wEBcOLuMNtYPe = "��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����"
dIM eDItORtYPe : eDItORtYPe = "asp"
dIM wEBvERsIOn
%>
<!--#Include File = "function.Asp"-->
<!--#Include File = "setAccess.Asp"-->
<%
sUB hANdLErESeTAcCEsSDaTA()
cALl rESeTAcCEsSDaTA()
eND sUB
dIM dB_pREfIX
dB_pREfIX="xy_"	
wEBvERsIOn = "v1.0011"
dIM cFG_WEbSItEUrL, cFG_WEbTItLE, cFG_FLaGS,cFG_WEbTEmPLaTE
sUB lOAdWEbCOnFIg()
cALl oPEnCOnN()
rS.oPEn "select * from "& dB_pREfIX &"website", cONn, 1, 1
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
rS.oPEn "Select * From "& dB_pREfIX &"admin Where username='" & b & "' And pwd='" & c & "'", cONn, 1, 1
iF rS.eOF tHEn
iF rEQuESt.cOOkIEs("nLogin") = "" tHEn
cALl sETcOOkIE("nLogin", "1", tIMe() + 3600)
e = rEQuESt.cOOkIEs("nLogin")
eLSe
e = rEQuESt.cOOkIEs("nLogin")
cALl sETcOOkIE("nLogin", cINt(e) + 1, tIMe() + 3600)
eND iF
cALl rW(gETmSG1("�˺��������<br>�������" & e & "�ε�¼", "?act=displayAdminLogin"))
eLSe
sESsIOn("adminusername") = b
sESsIOn("adminId") = rS("Id")
sESsIOn("DB_PREFIX") = dB_pREfIX
d = "addDateTime='" & rS("UpDateTime") & "',UpDateTime='" & nOW() & "',RegIP='" & nOW() & "',UpIP='" & gETiP() & "'"
cONn.eXEcUTe("update "& dB_pREfIX &"admin set " & d & " where id=" & rS("id"))
cALl rW(gETmSG1("��¼�ɹ������ڽ����̨...", "?act=adminIndex"))
eND iF : rS.cLOsE
eND sUB
sUB aDMiNOuT()
sESsIOn("adminusername") = ""
sESsIOn("adminId") = ""
cALl rW(gETmSG1("�˳��ɹ������ڽ����¼����...", "?act=displayAdminLogin"))
eND sUB
sUB aDMiNInDEx()
cALl lOAdWEbCOnFIg()
dIM b
b = gETfTExT(rOOt_PaTH & "adminIndex.html")
b = rEPlACe(b, "{$adminusername$}", sESsIOn("adminusername"))
b = rEPlACe(b, "{$frontView$}", "../" & eDItORtYPe & "web." & eDItORtYPe)
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
eLSeIF iNStR("|TableComment|","|"& a &"|")>0 tHEn
d = " order by adddatetime desc"
eLSeIF iNStR("|Admin|","|"& a &"|")>0 tHEn
d = ""
eND iF
cALl dISpALyMAnAGe(a, c, "*", b, d)
eND sUB
sUB aDDeDItHAnDLe(a)
iF a = "Admin" tHEn
cALl aDDeDItDIsPLaY(a, "����Ա", "")
eLSeIF a = "WebSite" tHEn
cALl aDDeDItDIsPLaY(a, "վ������", "webdescription,websitebottom|textarea2")
eLSeIF a = "ArticleDetail" tHEn
cALl aDDeDItDIsPLaY(a, "������Ϣ", "sortrank||0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSeIF a = "WebColumn" tHEn
cALl aDDeDItDIsPLaY(a, "��վ��Ŀ", "npagesize|numb|10,sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSeIF a = "OnePage" tHEn
cALl aDDeDItDIsPLaY(a, "��ҳ", "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
eLSeIF a = "TableComment" tHEn
cALl aDDeDItDIsPLaY(a, "����", "reply|textarea2,bodycontent|textarea2")
eLSeIF a = "WebLayout" tHEn
cALl aDDeDItDIsPLaY(a, "��վ����", "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2,actioncontent|textarea2")
eLSeIF a = "WebModule" tHEn
cALl aDDeDItDIsPLaY(a, "��վģ��", "sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2")
eND iF
eND sUB
sUB sAVeADdEDiTHaNDlE(a)
iF a = "Admin" tHEn
cALl sAVeADdEDiT(a, "��վģ��", "username,pseudonym,pwd|md5")
eLSeIF a = "WebSite" tHEn
cALl sAVeADdEDiT(a, "վ������", "flags,websiteurl,webtemplate,webimages,webcss,webjs,webtitle,webkeywords,webdescription,websitebottom")
eLSeIF a = "ArticleDetail" tHEn
cALl sAVeADdEDiT(a, "������Ϣ", "relatedtags,labletitle,target,nofollow|numb|0,isonhtml|numb|0,parentid,title,foldername,filename,customaurl,smallimage,bigimage,author,sortrank||0,flags,webtitle,webkeywords,webdescription,bannerimage,simpleintroduction,bodycontent,titlecolor")
eLSeIF a = "WebColumn" tHEn
cALl sAVeADdEDiT(a, "��վ��Ŀ", "npagesize|numb|10,labletitle,target,nofollow|numb|0,isonhtml|numb|0,columntype,parentid,columnname,columnenname,foldername,filename,customaurl,sortrank||0,webtitle,webkeywords,webdescription,showtitle,flags,simpleintroduction,bodycontent")
eLSeIF a = "OnePage" tHEn
cALl sAVeADdEDiT(a, "��ҳ", "labletitle,target,nofollow|numb|0,isonhtml|numb|0,title,displaytitle,foldername,filename,customaurl,webtitle,webkeywords,webdescription,simpleintroduction,bodycontent")
eLSeIF a = "TableComment" tHEn
cALl sAVeADdEDiT(a, "����", "through|numb|0,reply,bodycontent")
eLSeIF a = "WebLayout" tHEn
cALl sAVeADdEDiT(a, "��վ����", "layoutlist,layoutname,sortrank|numb,isdisplay|yesno,simpleintroduction,bodycontent,actioncontent,replacestyle")
eLSeIF a = "WebModule" tHEn
cALl sAVeADdEDiT(a, "��վģ��", "modulename,moduletype,sortrank|numb,simpleintroduction,bodycontent")
eND iF
eND sUB
sUB dISpLAyLAyOUt()
dIM b, c
c = rEQuESt("lableTitle")
cALl lOAdWEbCOnFIg()
b = gETfTExT(rOOt_PaTH & rEQuESt("templateFile"))
b = rEPlACe(b, "{$Web_Title$}", cFG_WEbTItLE)
b = rEPlACe(b, "{$position$}", rEQuESt("lableTitle"))
iF c = "����Robots" tHEn
b = rEPlACe(b, "[$bodycontent$]", gETfTExT("/robots.txt"))
eLSeIF c = "ģ�����" tHEn
b=dISpLAyTEmPLaTEsLIsT(b)
eND iF
cALl rW(b)
eND sUB
fUNcTIoN dISpLAyTEmPLaTEsLIsT(a)
dIM b,c,d,e,f,g,h,i
dIM j
cALl lOAdWEbCOnFIg()
e = gETsTRcUT(a, "[list]", "[/list]", 2)
j=sPLiT("/Templates/|/Templates2015/|/Templates2016/","|")
fOR eACh b iN j
iF b<>"" tHEn
f=gETdIRfOLdERnAMeLIsT(b)
g=sPLiT(f,vBCrLF)
fOR eACh d iN g
iF d <>"" aND iNStR("#_",lEFt(d,1))=fALsE tHEn
c=b & d & "/"
h=e
iF cFG_WEbTEmPLaTE=c tHEn
d=rEPlACe(d,d, "<font color=red>"& d &"</font>")
h=rEPlACe(h,"����</a>","</a>")	
eND iF
h = rEPlACeVAlUEpARaM(h, "templatepath", c)
h = rEPlACeVAlUEpARaM(h, "templatename", d)
i=i & h & vBCrLF
eND iF
nEXt
eND iF
nEXt
a = rEPlACe(a, "[list]" & e & "[/list]", i)
dISpLAyTEmPLaTEsLIsT=a
eND fUNcTIoN
fUNcTIoN iSOpENtEMpLAtE()
dIM b,c,d,e
b=rEQuESt("templatePath")
c=rEQuESt("templateName")
d="webtemplate='"& b &"',webimages='"& b &"Images/'"
d=d & ",webcss='"& b &"css/',webjs='"& b &"Js/'"
cONn.eXEcUTe("update "& dB_pREfIX &"website set " & d)
e = "?act=displayLayout&templateFile=manageTemplates.html&lableTitle=ģ�����"
cALl rW(gETmSG1("����ģ��ɹ������ڽ���ģ��������...", e))
eND fUNcTIoN
cALl oPEnCOnN()
sELeCT cASe rEQuESt("act")
cASe "dispalyManageHandle" : dISpALyMAnAGeHAnDLe(rEQuESt("actionType"))
cASe "addEditHandle" : aDDeDItHAnDLe(rEQuESt("actionType"))
cASe "saveAddEditHandle" : sAVeADdEDiTHaNDlE(rEQuESt("actionType"))
cASe "delHandle" : cALl dEL(rEQuESt("actionType"), rEQuESt("lableTitle"))
cASe "sortHandle" : sORtHAnDLe(rEQuESt("actionType"))
cASe "displayLayout" : dISpLAyLAyOUt()
cASe "saveRobots" : sAVeRObOTs()
cASe "saveSiteMap" : sAVeSItEMaP()
cASe "isOpenTemplate" : iSOpENtEMpLAtE()
cASe "setAccess" : hANdLErESeTAcCEsSDaTA()
cASe "login" : lOGiN()
cASe "adminOut" : aDMiNOuT()
cASe "adminIndex" : aDMiNInDEx()
cASe eLSe : dISpLAyADmINlOGiN()
eND sELeCT
%>

