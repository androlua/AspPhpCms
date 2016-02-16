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
<%
fUNcTIoN gETdIDsIDtIDsQL(a, b, c)
dIM d, e
e = " Where "
iF a <> "" tHEn
d = d & e & "BigClassName='" & a & "'"
e = " And "
eND iF
iF b <> "" tHEn
d = d & e & "SmallClassName='" & b & "'"
e = " And "
eND iF
iF c <> "" tHEn
d = d & e & "ThreeClassName='" & c & "'"
eND iF
gETdIDsIDtIDsQL = d
eND fUNcTIoN
fUNcTIoN cHEcKBiGClASs(a)
cHEcKBiGClASs = cONn.eXEcUTe("Select Count(*) From [BigClass] Where BigClassName='" & a & "'")(0)
eND fUNcTIoN
fUNcTIoN cHEcKSmALlCLaSS(a, b)
dIM c, d
c = "Select Count(*) From [SmallClass]"
d = gETdIDsIDtIDsQL(a, b, "")
c = gETwHErEAnD(c, d)
cHEcKSmALlCLaSS = cONn.eXEcUTe(c)(0)
eND fUNcTIoN
fUNcTIoN cHEcKThREeCLaSS(a, b, c)
dIM d, e
d = "Select Count(*) From [ThreeClass]"
e = gETdIDsIDtIDsQL(a, b, c)
d = gETwHErEAnD(d, e)
cHEcKThREeCLaSS = cONn.eXEcUTe(d)(0)
eND fUNcTIoN
fUNcTIoN cHEcKPrODuCT(a, b, c)
dIM d
d = "Select Count(*) From [Product]"
iF a <> "" tHEn d = gETwHErEAnD(d, "BigClassName='" & a & "'")
iF b <> "" tHEn d = gETwHErEAnD(d, "SmallClassName='" & b & "'")
iF c <> "" tHEn d = gETwHErEAnD(d, "ThreeClassName='" & c & "'")
cHEcKPrODuCT = cONn.eXEcUTe(d)(0)
eND fUNcTIoN
fUNcTIoN aUToADdMAiNInFO(a, b, c)
cALl hANdLEaUToADdMAiNInFO(a, b, fALsE, c)
eND fUNcTIoN
fUNcTIoN hANdLEaUToADdMAiNInFO(a, b, c, d)
dIM e
e = "Select * From [MainInfo] Where Title='" & a & "'"
iF uSErID <> "" tHEn e = gETwHErEAnD(e, " And UserId=" & uSErID)
iF cHEcKSqL(e) = fALsE tHEn cALl eERr("Sql", e)
rS.oPEn e, cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("Title") = a
rS("ShowTitle") = b
rS("Content") = d
rS("OnHtml") = c
rS.uPDaTE
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN aUToADdBIgCLaSS(a)
dIM b, c
iF cONn.eXEcUTe("Select Count(*) From [BigClass] Where BigClassName='" & a & "'")(0) = 0 tHEn
b = pINyIN(a, 3)
c = cONn.eXEcUTe("Select Count(*) From [SmallClass]")(0) + 1
cONn.eXEcUTe("Insert Into[BigClass](BigClassName,FolderName,Sort) Values('" & a & "', '" & b & "'," & c & ")")
aUToADdBIgCLaSS = "【" & a & "】创建大类成功"
eLSe
aUToADdBIgCLaSS = "【" & a & "】大类已存在"
eND iF
eND fUNcTIoN
fUNcTIoN aUToADdSMaLLcLAsS(a, b)
dIM c, d
iF cONn.eXEcUTe("Select Count(*) From [SmallClass] Where BigClassName='" & a & "' And  SmallClassName='" & b & "'")(0) = 0 tHEn
c = pINyIN(b, 3)
d = cONn.eXEcUTe("Select Count(*) From [SmallClass] Where BigClassName='" & a & "'")(0) + 1
cONn.eXEcUTe("Insert Into[SmallClass](BigClassName,SmallClassName,FolderName,Sort) Values('" & a & "','" & b & "', '" & c & "'," & d & ")")
aUToADdSMaLLcLAsS = "【" & a & "】创建小类成功"
eLSe
aUToADdSMaLLcLAsS = "【" & a & "】小类已存在"
eND iF
eND fUNcTIoN
fUNcTIoN aUToADdTHrEEcLAsS(a, b, c)
dIM d, e
iF cONn.eXEcUTe("Select Count(*) From [ThreeClass] Where BigClassName='" & a & "' And  SmallClassName='" & b & "' And ThreeClassName='" & c & "'")(0) = 0 tHEn
d = pINyIN(b, 3)
e = cONn.eXEcUTe("Select Count(*) From [SmallClass] Where BigClassName='" & a & "' And  SmallClassName='" & b & "'")(0) + 1
cONn.eXEcUTe("Insert Into[ThreeClass](BigClassName,SmallClassName,ThreeClassName,FolderName,Sort) Values('" & a & "','" & b & "','" & c & "', '" & d & "'," & e & ")")
aUToADdTHrEEcLAsS = "【" & b & "】创建子类成功"
eLSe
aUToADdTHrEEcLAsS = "【" & b & "】子类已存在"
eND iF
eND fUNcTIoN
fUNcTIoN aUToADdARtIClE(a, b, c, d, e)
aUToADdARtIClE = aUToADdARtIClEAcTIoN("", a, b, c, d, "", e)
eND fUNcTIoN
fUNcTIoN aUToADdARtIClEAcTIoN(a, b, c, d, e, f, g)
dIM h, i, j,k
dIM l, m, n, o
dIM p, q, r, s, t, u
l = rPArAM(a, "BigImage")
m = rPArAM(a, "SmallImage")
l = hANdLEhTTpURl(rEPlACe(l, "[$样式名称$]", wEBsKInS))
m = hANdLEhTTpURl(rEPlACe(m, "[$样式名称$]", wEBsKInS))
p = rPArAM(a, "Keywords")
q = rPArAM(a, "Description")
p = hANdLEhTTpURl(rEPlACe(p, "[$样式名称$]", wEBsKInS))
q = hANdLEhTTpURl(rEPlACe(q, "[$样式名称$]", wEBsKInS))
t = lCAsE(rPArAM(a, "OriginalTitleYes"))
dIM mEMbERpRIcE	
dIM pRIcE	
mEMbERpRIcE =rPArAM(a, "memberprice")	
pRIcE =rPArAM(a, "price")	
e = tRIm(e)
h = h & gETdIDsIDtIDsQL(b, c, d)
iF e <> "" tHEn h = h & " And Title='" & e & "'"
i = "Select * From [Product]" & gETwHErEAnD(i, h)
rSTeMP.oPEn i, cONn, 1, 3
iF rSTeMP.eOF tHEn
iF t = "true" tHEn
j = e
eLSe
j = b & "-" & c & "-" & d & "-" & e
eND iF
rSTeMP.aDDnEW
rSTeMP("BigClassName") = b
rSTeMP("SmallClassName") = c
rSTeMP("ThreeClassName") = d
rSTeMP("WebTitle") = e
rSTeMP("Title") = j
n = rEPlACe(l, "[id]", f)
o = rEPlACe(m, "[id]", f)
iF n <> "" tHEn rSTeMP("BigFiles") = n
iF o <> "" tHEn rSTeMP("SmallFiles") = o
r = rEPlACe(p, "[id]", j)
s = rEPlACe(q, "[id]", j)
rSTeMP("WebKeywords") = r
rSTeMP("WebDescription") = s
rSTeMP("Content") = g
cALl eCHo(a,mEMbERpRIcE)
iF pRIcE<>"" tHEn
iF iNStR(pRIcE,"-")>0 tHEn
k=sPLiT(pRIcE,"-")
rSTeMP("price") = pHPrANd(cINt(k(0)),cINt(k(1)))
eND iF
eND iF
iF mEMbERpRIcE<>"" tHEn
iF iNStR(mEMbERpRIcE,"-")>0 tHEn
k=sPLiT(mEMbERpRIcE,"-")
rSTeMP("memberprice") = pHPrANd(cINt(k(0)),cINt(k(1)))
eND iF
eND iF
rSTeMP.uPDaTE
u = rSTeMP(0)
rSTeMP.cLOsE
rSTeMP.oPEn "Select * From [Product] where id=" & u, cONn, 1, 3
iF nOT rSTeMP.eOF tHEn
rSTeMP("FileName") = "article" & u
rSTeMP.uPDaTE
eND iF
aUToADdARtIClEAcTIoN = tRUe
eLSe
aUToADdARtIClEAcTIoN = fALsE
eND iF : rSTeMP.cLOsE
eND fUNcTIoN
fUNcTIoN aUToADdBIgCLaSSaNDaRTiCLe(a, b)
dIM c
cALl aUToADdBIgCLaSS(a)
fOR c = 1 tO b
cALl aUToADdARtIClE(a, "", "", a & "标题-" & c, a & "内容-" & c)
nEXt
eND fUNcTIoN
fUNcTIoN gETwEBtEMpLAtE()
dIM b
sET b = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [WebSite]", cONn, 1, 1
iF nOT b.eOF tHEn
gETwEBtEMpLAtE = b("WebTemplate")
eND iF : b.cLOsE
eND fUNcTIoN
fUNcTIoN gETwEBsKInS()
dIM b
sET b = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [WebSite]", cONn, 1, 1
iF nOT b.eOF tHEn
gETwEBsKInS = b("WebSkins")
eND iF : b.cLOsE
eND fUNcTIoN
fUNcTIoN gETwEBiMAgES()
dIM b
sET b = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [WebSite]", cONn, 1, 1
iF nOT b.eOF tHEn
gETwEBiMAgES = b("WebImages")
eND iF : b.cLOsE
eND fUNcTIoN
fUNcTIoN dETaILpAGeADdHTmLPrEFiX(bYVaL a)
a = hANdLEhTTpURl(a)
iF iNStR(a, "/") = fALsE tHEn
a = "/Html/" & a
eLSe
a = rEPlACeN(gETwEBfOLdERnAMe() & a, "//", "/", 3)
eND iF
iF lEFt(a, 1) <> "/" tHEn a = "/" & a
dETaILpAGeADdHTmLPrEFiX = a
eND fUNcTIoN
fUNcTIoN gEThANdLEfOLdERnAMe(a)
a = pINyIN2(a)
a = rEPlACe(rEPlACe(a, "/", "\"), " ", "")
a = rEPlACe(rEPlACe(a, "\\", "\"), "\\", "\")
gEThANdLEfOLdERnAMe = a
eND fUNcTIoN
fUNcTIoN gETmAInINfOUrL(a)
dIM b, c
rS.oPEn "Select * From [MainInfo] Where Title='" & a & "'", cONn, 1, 1
iF nOT rS.eOF tHEn
iF tRIm(rS("TemplatePath")) <> "" tHEn
tEMpLAtEPaTH = wEBtEMpLAtE & rS("TemplatePath")
eLSe
tEMpLAtEPaTH = wEBtEMpLAtE & "Main_Model.Html"
eND iF
c = tRIm(rS("FileName"))
iF cHEcKMaKEhTMlFIlE(c) = tRUe tHEn
b = gEThANdLEfILeNAmE(c)
c = dETaILpAGeADdHTmLPrEFiX(rS("FolderName")) & "/" & c
c = gEThANdLEuRL(c)
eND iF
c = wEBdEBuG(c, "act=MainInfo&Id=" & rS("Id"))
eND iF : rS.cLOsE
gETmAInINfOUrL = c
eND fUNcTIoN
fUNcTIoN gETmAInURl(a)
gETmAInURl = gETmAInINfOUrL(a)
eND fUNcTIoN
fUNcTIoN gETnAVuRL(a, b)
dIM c, d, e
sET e = cREaTEoBJeCT("Adodb.RecordSet")
e.oPEn "Select * From [NavBigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT e.eOF tHEn
d = tRIm(e("FolderName"))
c = gETwEBfOLdERnAMe & "/" & e("FolderName") & "/" & e("FileName")
c = gEThANdLEuRL(c)
iF cHEcKMaKEhTMlFIlE(e("FileName")) = fALsE tHEn
c = e("FileName")
eND iF
c = wEBdEBuG(c, "act=Nav&NavDid=" & a)
eND iF : e.cLOsE
iF b <> "" tHEn
e.oPEn "Select * From [NavSmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", cONn, 1, 3
iF nOT e.eOF tHEn
iF e("FolderName") = "" tHEn
c = "/" & d & "/"
eLSe
c = "/" & e("FolderName") & "/"
eND iF
iF e("FileName") = "" tHEn
e("FileName") = hTMlFIlENaME(e("SmallClassName"))
e.uPDaTE
eND iF
c = gETwEBfOLdERnAMe & c & e("FileName")
c = gEThANdLEuRL(c)
iF cHEcKMaKEhTMlFIlE(e("FileName")) = fALsE tHEn
c = e("FileName")
eND iF
c = wEBdEBuG(c, "act=Nav&NavDid=" & a & "&NavSid=" & b)
eND iF : e.cLOsE
eND iF
gETnAVuRL = c
eND fUNcTIoN
fUNcTIoN gETnAVtARgET(a, b)
iF b <> "" tHEn
tEMpRS.oPEn "Select * From [NavSmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
gETnAVtARgET = tEMpRS("Target")
eND iF : tEMpRS.cLOsE
eXIt fUNcTIoN
eND iF
tEMpRS.oPEn "Select * From [NavBigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
gETnAVtARgET = tEMpRS("Target")
eND iF : tEMpRS.cLOsE
eND fUNcTIoN
fUNcTIoN gETbIGcLAsSFoLDeRNaME(a)
dIM b
sET b = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [BigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT b.eOF tHEn
gETbIGcLAsSFoLDeRNaME = "/" & b("FolderName") & "/" & b("FileName")
gETbIGcLAsSFoLDeRNaME = gEThANdLEuRL(gETbIGcLAsSFoLDeRNaME)
iF cHEcKMaKEhTMlFIlE(b("FileName")) = fALsE tHEn
gETbIGcLAsSFoLDeRNaME = b("FileName")
eND iF
cALl wEBdEBuG(gETbIGcLAsSFoLDeRNaME, "act=CreateClass&ProDid=" & b("BigClassName") & "&page=1")
eND iF : b.cLOsE
eND fUNcTIoN
fUNcTIoN gETbIGcLAsSFiLEnAMe(a)
gETbIGcLAsSFiLEnAMe = gETbIGcLAsSFoLDeRNaME(a)
eND fUNcTIoN
fUNcTIoN gETbIGcLAsSUrL(a)
gETbIGcLAsSUrL = gETbIGcLAsSFoLDeRNaME(a)
eND fUNcTIoN
fUNcTIoN gETsMAlLClASsFOlDErNAmE(a, b)
dIM c, d, e, f
sET f = cREaTEoBJeCT("Adodb.RecordSet")
f.oPEn "Select * From [BigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT f.eOF tHEn
d = "/" & f("FolderName") & "/"
gETsMAlLClASsFOlDErNAmE = d
cALl wEBdEBuG(gETsMAlLClASsFOlDErNAmE, "act=CreateClass&ProDid=" & f("BigClassName"))
eND iF : f.cLOsE
iF b <> "" tHEn
f.oPEn "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", cONn, 1, 1
iF nOT f.eOF tHEn
e = tRIm(rEPlACe(f("FolderName"), "\", "/"))
iF lEFt(e, 1) <> "/" tHEn
d = d & "/" & e & "/"
eLSe
d = "/" & f("FolderName") & "/"
eND iF
iF cHEcKMaKEhTMlFIlE(f("FileName")) = tRUe tHEn
d = d & f("FileName")
d = "/" & gETwEBfOLdERnAMe() & gEThANdLEuRL(d)
eLSe
d = "/" & gETwEBfOLdERnAMe() & f("FileName")
iF gETwEBsITe(f("FileName")) <> "" tHEn
d = f("FileName")
eND iF
eND iF
gETsMAlLClASsFOlDErNAmE = d
cALl wEBdEBuG(gETsMAlLClASsFOlDErNAmE, "act=CreateClass&ProDid=" & a & "&ProSid=" & f("SmallClassName"))
eND iF : f.cLOsE
eND iF
eND fUNcTIoN
fUNcTIoN gETsMAlLClASsFIlENaME(a, b)
gETsMAlLClASsFIlENaME = gETsMAlLClASsFOlDErNAmE(a, b)
eND fUNcTIoN
fUNcTIoN gETsMAlLClASsURl(a, b)
gETsMAlLClASsURl = gETsMAlLClASsFOlDErNAmE(a, b)
eND fUNcTIoN
fUNcTIoN gETtHReEClASsFOlDErNAmE(a, b, c)
dIM d, e
tEMpRS.oPEn "Select * From [BigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
d = "/" & tEMpRS("FolderName") & "/"
gETtHReEClASsFOlDErNAmE = d
cALl wEBdEBuG(gETtHReEClASsFOlDErNAmE, "act=CreateClass&ProDid=" & tEMpRS("BigClassName"))
eND iF : tEMpRS.cLOsE
iF b <> "" tHEn
tEMpRS.oPEn "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
e = tRIm(rEPlACe(tEMpRS("FolderName"), "\", "/"))
iF lEFt(e, 1) <> "/" tHEn
d = d & "/" & e & "/"
eLSe
d = "/" & tEMpRS("FolderName") & "/"
eND iF
gETtHReEClASsFOlDErNAmE = d
cALl wEBdEBuG(gETtHReEClASsFOlDErNAmE, "act=CreateClass&ProDid=" & a & "&ProSid=" & tEMpRS("SmallClassName"))
eND iF : tEMpRS.cLOsE
eND iF
iF c <> "" tHEn
tEMpRS.oPEn "Select * From [ThreeClass] Where BigClassName='" & a & "' And SmallClassName='" & b & "' And ThreeClassName='" & c & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
e = tRIm(rEPlACe(tEMpRS("FolderName"), "\", "/"))
iF lEFt(e, 1) <> "/" tHEn
d = d & "/" & e & "/"
eLSe
d = "/" & tEMpRS("FolderName") & "/"
iF gETwEBsITe(tEMpRS("FileName")) <> "" tHEn
d = tEMpRS("FileName")
eND iF
eND iF
iF cHEcKMaKEhTMlFIlE(tEMpRS("FileName")) = tRUe tHEn
d = d & tEMpRS("FileName")
d = gEThANdLEuRL(d)
eLSe
d = tEMpRS("FileName")
eND iF
gETtHReEClASsFOlDErNAmE = d
cALl wEBdEBuG(gETtHReEClASsFOlDErNAmE, "act=CreateClass&ProDid=" & a & "&ProSid=" & b & "&ProTid=" & tEMpRS("ThreeClassName"))
eND iF : tEMpRS.cLOsE
eND iF
eND fUNcTIoN
fUNcTIoN gETtHReEClASsFIlENaME(a, b, c)
gETtHReEClASsFIlENaME = gETtHReEClASsFOlDErNAmE(a, b, c)
eND fUNcTIoN
fUNcTIoN gETtHReEClASsURl(a, b, c)
gETtHReEClASsURl = gETtHReEClASsFOlDErNAmE(a, b, c)
eND fUNcTIoN
fUNcTIoN gETcLAsSUrL(a, b, c)
dIM d
iF c <> "" tHEn
d = gETtHReEClASsFOlDErNAmE(a, b, c)
eLSeIF b <> "" tHEn
d = gETsMAlLClASsFOlDErNAmE(a, b)
eLSe
d = gETbIGcLAsSFoLDeRNaME(a)
eND iF
d = tRIm(rEPlACe(d, "\", "/"))
iF lEFt(d, 1) <> "/" aND gETwEBsITe(d) = "" tHEn d = "/" & d
gETcLAsSUrL = d
eND fUNcTIoN
fUNcTIoN gETcLAsSUrL_nAV(a, b, c)
dIM d
d = gETcLAsSUrL(a, b, c)
d = mID(d, 2)
iF rIGhT(d, 1) = "/" tHEn d = lEFt(d, lEN(d) - 1)
gETcLAsSUrL_nAV = d
eND fUNcTIoN
fUNcTIoN gETpROdUCtURl(a)
tEMpRS.oPEn "Select * From [Product] " & a, cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
gETpROdUCtURl = gEThANdLEuRL(tEMpRS("FileName"))
cALl wEBdEBuG(gETpROdUCtURl, "act=CreateArticle&ID=" & tEMpRS("Id"))
eND iF : tEMpRS.cLOsE
eND fUNcTIoN
fUNcTIoN aOTuGEtPRoDUcTFiLEnAMe(bYVaL a)
dIM b, c, d
d = a
a = mD5(d, 2) & mD5(d, 4)
b = tRUe
wHIlE b
tEMpRS.oPEn "Select * From [Product] Where Title='" & a & "'", cONn, 1, 1
iF tEMpRS.eOF tHEn
b = fALsE
aOTuGEtPRoDUcTFiLEnAMe = a
eLSe
d = d & "1"
a = mD5(d, 2) & mD5(d, 4)
eND iF : tEMpRS.cLOsE
wENd
eND fUNcTIoN
fUNcTIoN uPPaGE(a)
dIM b, c, d, e, f, g, h, i, j
rSTeMP.oPEn "Select * From [Product] Where ID=" & a, cONn, 1, 1
iF nOT rSTeMP.eOF tHEn
c = rSTeMP("BigClassName")
d = rSTeMP("SmallClassName")
e = rSTeMP("ThreeClassName")
eND iF : rSTeMP.cLOsE
iF e <> "" tHEn
b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And ThreeClassName='" & e & "' And"
eLSeIF d <> "" tHEn
b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And"
eLSe
b = "BigClassName='" & c & "' And "
eND iF
f = "Select * from [Product] where " & b & "  Id < " & a & " order by Id  desc"
rSTeMP.oPEn f, cONn, 1, 1
iF nOT rSTeMP.eOF tHEn
g = rSTeMP("FileName")
iF cHEcKReMOtEUrL(g) = fALsE tHEn
g = gEThANdLEuRL(rSTeMP("FileName"))
cALl wEBdEBuG(g, "act=CreateArticle&ID=" & rSTeMP("Id"))
eND iF
h = "_top"
i = rSTeMP("Title")
j = "<a " & aHReF(g, i, h) & ">上一篇："
uPPaGE = j & cUTsTR(i, 100, "...") & "</a><br>"
eLSe
uPPaGE = iNFoCOlOR("上一篇：没有<br>", sYSsTYlE(0)) & ""
eND iF
rSTeMP.cLOsE
eND fUNcTIoN
fUNcTIoN dOWnPAgE(a)
dIM b, c, d, e, f, g, h, i, j
rSTeMP.oPEn "Select * From [Product] Where ID=" & a, cONn, 1, 1
iF nOT rSTeMP.eOF tHEn
c = rSTeMP("BigClassName")
d = rSTeMP("SmallClassName")
e = rSTeMP("ThreeClassName")
eND iF : rSTeMP.cLOsE
iF e <> "" tHEn
b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And ThreeClassName='" & e & "' And"
eLSeIF d <> "" tHEn
b = "BigClassName='" & c & "' And SmallClassName='" & d & "' And"
eLSe
b = "BigClassName='" & c & "' And "
eND iF
f = "select * from Product where " & b & "  Id > " & a & " order by Id  asc"
rSTeMP.oPEn f, cONn, 1, 1
iF nOT rSTeMP.eOF tHEn
g = rSTeMP("FileName")
iF cHEcKReMOtEUrL(g) = fALsE tHEn
g = gEThANdLEuRL(rSTeMP("FileName"))
cALl wEBdEBuG(g, "act=CreateArticle&ID=" & rSTeMP("Id"))
eND iF
h = "_top"
i = rSTeMP("Title")
j = "<a " & aHReF(g, i, h) & ">下一篇："
dOWnPAgE = j & cUTsTR(i, 100, "...") & "</a><br>"
eLSe
dOWnPAgE = iNFoCOlOR("下一篇：没有<br>", sYSsTYlE(0))
eND iF
rSTeMP.cLOsE
eND fUNcTIoN
fUNcTIoN gEThANdLEfILeNAmE(bYVaL a)
iF a = "" oR a = "/" oR a = "\" tHEn
gEThANdLEfILeNAmE = "/Index.Html"
eLSe
gEThANdLEfILeNAmE = a & ".Html"
eND iF
eND fUNcTIoN
fUNcTIoN hTMlFIlENaME(bYVaL a)
hTMlFIlENaME = hANdLEsAVeFIlENaME(a, tRUe)
eND fUNcTIoN
fUNcTIoN hANdLEsAVeFIlENaME(bYVaL a, b)
dIM c, d, e
a = tRIm(a)
iF cHEcKMaKEhTMlFIlE(a) = tRUe tHEn
c = ":*?""<>|.,"
fOR d = 1 tO lEN(c)
e = mID(c, d, 1)
a = rEPlACe(a, e, "")
nEXt
iF b = tRUe tHEn
a = tRIm(pINyIN2(a))
eND iF
eND iF
hANdLEsAVeFIlENaME = lEFt(a, 100)
eND fUNcTIoN
fUNcTIoN cHEcKMaKEhTMlFIlE(bYVaL a)
dIM b
a = tRIm(lCAsE(rEPlACe(a, "\", "/"))) : b = a
iF iNStR(a, "/") > 0 tHEn
a = tRIm(mID(a, iNStRReV(a, "/") + 1))
eND iF
cHEcKMaKEhTMlFIlE = tRUe
iF lEFt(b, 7) = "http://" oR lEFt(b, 4) = "www." oR lEFt(b, 4) = "url:" oR lEFt(b, 5) = "/url:" oR lEFt(a, 1) = "#" oR lEFt(a, 11) = "javascript:" tHEn
cHEcKMaKEhTMlFIlE = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN dISpLAyONlINeEDiTDiALoG(a, b)
dISpLAyONlINeEDiTDiALoG = hANdLEdISpLAyONlINeEDiTDiALoG(a, b, "", "")
eND fUNcTIoN
fUNcTIoN dISpLAyONlINeED2(a, b, c)
dISpLAyONlINeED2 = hANdLEdISpLAyONlINeEDiTDiALoG(a, b, "", c)
eND fUNcTIoN
%>


