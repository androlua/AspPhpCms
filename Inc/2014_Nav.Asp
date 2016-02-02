<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-01-20
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
sUB hANdLEwEBcONfIG()
dIM b, c
b = iIF(pUBnAVdID <> "", pUBnAVdID, pUBpROdID)
cALl gETnAVcONfIG(b)
iF pUBiD <> "" tHEn
c = "Select * From [Product] Where Id=" & pUBiD
rS.oPEn c, cONn, 1, 1
iF nOT rS.eOF tHEn
cALl gETnAVcONfIG(rS("BigClassName"))
mAInNAv = rS("BigClassName")
eND iF : rS.cLOsE
eXIt sUB
eND iF
eND sUB
fUNcTIoN gETnAVcONfIG(a)
rSTeMP.oPEn "Select * From [NavBigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT rSTeMP.eOF tHEn
mAInNAv = rSTeMP("BigClassName")
pUBnAVtYPe = rSTeMP("NavType")
pUBnAVdID = mAInNAv
eND iF : rSTeMP.cLOsE
eND fUNcTIoN
fUNcTIoN gETnAVtYPe(a)
rSTeMP.oPEn "Select * From [NavBigClass] Where BigClassName='" & a & "'", cONn, 1, 1
iF nOT rSTeMP.eOF tHEn
gETnAVtYPe = rSTeMP("NavType")
eND iF : rSTeMP.cLOsE
eND fUNcTIoN
fUNcTIoN rEAdNAvCSs(a, b)
eND fUNcTIoN
fUNcTIoN hANdLEnAViGAtIOn(a, b)
dIM c, d, e, f, g, h, i, j, k, l, m, n, o
dIM p, q, r
dIM s
dIM t, u
dIM v
t = pHPtRIm(rPArAM(a, "styleID"))
u = pHPtRIm(rPArAM(a, "styleValue"))
iF t <> "" tHEn
cALl rEAdNAvCSs(t, u)
eND iF
iF cHEcKStRIsNUmBErTYpE(u) tHEn
v = "_" & u
eND iF
iF b = "" tHEn
b = rPArAM(a, "AddSql")
eND iF
iF b = "" tHEn
b = " Where NavTop<>0 Order By Sort Asc"
eND iF
m = "Select * From [NavBigClass]"
iF uSErID <> "" tHEn m = gETwHErEAnD(m, " And UserId=" & uSErID)
m = gETwHErEAnD(m, b)
iF cHEcKSqL(m) = fALsE tHEn cALl eERr("Sql", m)
n = lCAsE(rPArAM(a, "DropDownMenu"))
o = lCAsE(rPArAM(a, "FocusType"))
s = lCAsE(rPArAM(a, "isConcise"))
iF s = "true" tHEn
s = fALsE
eLSe
s = tRUe
eND iF
rS.oPEn m, cONn, 1, 1
iF s = tRUe tHEn d = d & cOPySTr(" ", 4) & "<li class=left></li>" & vBCrLF
fOR c = 1 tO rS.rECoRDcOUnT
g = tRIm(rS("FileName"))
iF g <> "" aND rIGhT(g, 1) <> "/" aND rIGhT(g, 1) <> "\" tHEn g = g & ".html"
h = "/" & gETwEBfOLdERnAMe() & rS("FolderName") & "/"
i = rS("BigClassName")
f = rS("FileName")
iF cHEcKMaKEhTMlFIlE(f) = tRUe tHEn
f = h & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = fULlHTtPUrL(hOSt, f)
eND iF
cALl wEBdEBuG(f, "act=Nav&NavDid=" & i)
iF iNStR("|产品|新闻|下载|", "|" & rS("NavType") & "|") > 0 tHEn
cALl wEBdEBuG(f, "act=Nav&NavDid=" & i & "&Page=1")
eND iF
k = fONtCOlORfONtB(i, rS("FontB"), rS("FontColor"))
l = rS("Target")
iF pUBnAVdID = rS("BigClassName") tHEn
iF o = "a" tHEn
e = cOPySTr(" ", 8) & "<li class=focus><a " & aHReF(f, k, l) & ">" & k & "</a>"
eLSe
e = cOPySTr(" ", 8) & "<li class=focus>" & k
eND iF
eLSe
e = cOPySTr(" ", 8) & "<li><a " & aHReF(f, k, l) & ">" & k & "</a>"
eND iF
e = dISpLAyONlINeED2("/admin/NavManage.Asp?act=EditNavBig&Id=" & rS("Id") & "&n=" & gETrND(11), e, "<li")
d = d & e
p = ""
iF rS("NavType") = "文本" aND n = "true" tHEn
rSS.oPEn "Select * From [NavSmallClass] Where BigClassName='" & rS("BigClassName") & "'", cONn, 1, 1
iF nOT rSS.eOF tHEn
d = d & vBCrLF & cOPySTr(" ", 8) & "<ul>" & vBCrLF & cOPySTr(" ", 12)
fOR q = 1 tO rSS.rECoRDcOUnT
g = tRIm(rSS("FileName"))
iF g <> "" aND rIGhT(g, 1) <> "/" aND rIGhT(g, 1) <> "\" tHEn g = g & ".html"
j = rSS("SmallClassName")
f = rSS("FileName")
iF cHEcKMaKEhTMlFIlE(f) = tRUe tHEn
f = h & g
f = h & "/" & rSS("FolderName") & "/" & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
cALl wEBdEBuG(f, "act=Nav&NavDid=" & i & "&NavSid=" & j)
eND iF
r = fONtCOlORfONtB(j, rSS("FontB"), rSS("FontColor"))
l = rSS("Target") : l = "_blank"
e = "<a " & aHReF(f, r, l) & ">" & r & "</a>"
e = dISpLAyONlINeEDiTDiALoG("/admin/NavManage.Asp?act=EditNavSmall&Id=" & rSS("Id") & "&n=" & gETrND(11), e)
p = p & cOPySTr(" ", 8) & "<li>" & e & "</li>" & vBCrLF
rSS.mOVeNExT : nEXt
eND iF : rSS.cLOsE
eLSeIF rS("NavType") = "产品" aND n = "true" tHEn
rSS.oPEn "Select * From [SmallClass] Where BigClassName='" & rS("BigClassName") & "'", cONn, 1, 1
iF nOT rSS.eOF tHEn
d = d & vBCrLF & cOPySTr(" ", 8) & "<ul>" & vBCrLF & cOPySTr(" ", 12)
fOR q = 1 tO rSS.rECoRDcOUnT
g = tRIm(rSS("FileName"))
iF g <> "" aND rIGhT(g, 1) <> "/" aND rIGhT(g, 1) <> "\" tHEn g = g & ".html"
j = rSS("SmallClassName")
f = rSS("FileName")
iF cHEcKMaKEhTMlFIlE(f) = tRUe tHEn
f = h & g
f = h & "/" & rSS("FolderName") & "/" & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
cALl wEBdEBuG(f, "act=CreateClass&ProDid=" & i & "&ProSid=" & j & "&Page=1")
eND iF
r = fONtCOlORfONtB(j, rSS("FontB"), rSS("FontColor"))
l = rSS("Target") : l = "_blank"
e = "<a " & aHReF(f, r, l) & ">" & r & "</a>"
e = dISpLAyONlINeEDiTDiALoG("/admin/ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & rSS("Id") & "&n=" & gETrND(11), e)
p = rTRiMVbCRlF(p) & vBCrLF & cOPySTr(" ", 12) & "<li>" & e & "</li>" & vBCrLF
rSS.mOVeNExT : nEXt
eND iF : rSS.cLOsE
eND iF
iF p <> "" tHEn d = d & p & "</ul>" & vBCrLF
d = d & cOPySTr(" ", 8) & "</li>" & vBCrLF
iF s = tRUe tHEn d = d & cOPySTr(" ", 8) & "<li class=line></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
iF s = tRUe tHEn d = d & cOPySTr(" ", 8) & "<li class=right></li>" & vBCrLF
iF t <> "" tHEn
d = "<ul class='nav" & t & v & "'>" & vBCrLF & d & vBCrLF & "</ul>" & vBCrLF
eND iF
hANdLEnAViGAtIOn = d
eND fUNcTIoN
fUNcTIoN dIVtOPnAViGAtIOn(a, b)
dIM c, d, e, f, g, h, i, j, k, l
l = "Select * From [NavBigClass]"
iF uSErID <> "" tHEn l = gETwHErEAnD(l, " And UserId=" & uSErID)
l = gETwHErEAnD(l, b)
iF cHEcKSqL(l) = fALsE tHEn cALl eERr("Sql", l)
rS.oPEn l, cONn, 1, 1
d = d & "<li class=left></li>" & vBCrLF
fOR c = 1 tO rS.rECoRDcOUnT
g = rS("FileName")
iF g <> "" aND rIGhT(g, 1) <> "/" tHEn g = g & ".html"
h = "/" & gETwEBfOLdERnAMe() & rS("FolderName") & "/"
i = rS("BigClassName")
f = rS("FileName")
iF cHEcKReMOtEUrL(f) = fALsE tHEn
f = h & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = fULlHTtPUrL(hOSt, f)
cALl wEBdEBuG(f, "act=Nav&NavDid=" & i)
eND iF
j = fONtCOlORfONtB(i, rS("FontB"), rS("FontColor"))
k = rS("Target")
iF a = rS("BigClassName") tHEn
d = d & "<li class=focus>" & j & "</li>" & vBCrLF
eLSe
d = d & "<li><a " & aHReF(f, j, k) & ">" & j & "</a></li>" & vBCrLF
eND iF
d = d & "<li class=line></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
d = d & "<li class=right></li>" & vBCrLF
dIVtOPnAViGAtIOn = d
eND fUNcTIoN
fUNcTIoN wEBfOOtNAvIGaTIoN(a)
dIM b, c, d, e, f, g, h, i, j
j = "Select * From [NavBigClass] "
iF uSErID <> "" tHEn j = gETwHErEAnD(j, " And UserId=" & uSErID)
j = gETwHErEAnD(j, a)
rS.oPEn j, cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
e = rS("FileName")
iF e <> "" aND rIGhT(e, 1) <> "/" tHEn e = e & ".html"
f = "/" & rS("FolderName") & "/"
h = fONtCOlORfONtB(g, rS("FontB"), rS("FontColor"))
i = rS("Target")
g = rS("BigClassName")
d = rS("FileName")
iF cHEcKReMOtEUrL(d) = fALsE tHEn
d = f & e
d = rEPlACe(rEPlACe(d, "//", "/"), "//", "/")
cALl wEBdEBuG(d, "act=Nav&NavDid=" & g)
eND iF
c = c & "<a " & aHReF(d, h, i) & ">" & h & "</a>"
iF b <> rS.rECoRDcOUnT tHEn c = c & " &nbsp;| &nbsp; "
rS.mOVeNExT : nEXt : rS.cLOsE
wEBfOOtNAvIGaTIoN = c
eND fUNcTIoN
fUNcTIoN gETnAVtYPeINnAMe(a)
iF lCAsE(a) = "home" tHEn a = "首页"
gETnAVtYPeINnAMe = gETnAVpARaM("NavBigClass", "BigClassName", "Where NavType='" & a & "'")
eND fUNcTIoN
fUNcTIoN gETnAVpARaM(bYVaL a, bYVaL b, bYVaL c)
dIM d, e, f, g
d = "Select * From [" & a & "] " & c
tEMpRS.oPEn d, cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
iF b = "[url]" tHEn
e = tEMpRS("FileName")
iF e <> "" aND rIGhT(e, 1) <> "/" tHEn e = e & ".html"
g = "/" & gETwEBfOLdERnAMe() & tEMpRS("FolderName") & "/"
f = tEMpRS("FileName")
iF cHEcKReMOtEUrL(f) = fALsE tHEn
f = g & e
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = fULlHTtPUrL(hOSt, f)
cALl wEBdEBuG(f, "act=Nav&NavDid=" & rS("BigClassName"))
eND iF
gETnAVpARaM = f
eLSeIF b <> "" tHEn
gETnAVpARaM = tEMpRS(b)
eND iF
eND iF : tEMpRS.cLOsE
eND fUNcTIoN
fUNcTIoN xY_cUStOMnAVlISt(a)
dIM b, c, d, e, f, g, h
cALl hANdLEfUNpARaMEtER(a, b, c, d, e, f, g, h)
cALl xY_aUToADdHAnDLe(a)
dIM i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
dIM aA
dIM bA
dIM cA
dIM dA
dIM eA
i = gETdEFaULtVAlUE(a)
dIM fA, gA, hA, iA
dIM jA
dIM kA
dIM lA
dIM mA, nA
dIM oA, pA
eA = tRIm(lCAsE(rPArAM(a, "noFollow")))
z = "Select * From [NavBigClass] Where NavTop<>0 Order By Sort Asc"
rS.oPEn z, cONn, 1, 1
fOR j = 1 tO rS.rECoRDcOUnT
iF rS.eOF tHEn eXIt fOR
iF rS("BigClassName") = pUBnAVdID tHEn
n = "[list-focus]" : o = "[/list-focus]"
eLSe
n = "[list-" & j & "]" : o = "[/list-" & j & "]"
eND iF
fOR kA = 6 tO 2 sTEp - 1
iF iNStR(i, n) = fALsE aND j mOD kA = 0 tHEn
n = "[list-mod" & kA & "]" : o = "[/list-mod" & kA & "]"
iF iNStR(i, n) > 0 tHEn
eXIt fOR
eND iF
eND iF
nEXt
iF iNStR(i, n) = fALsE tHEn
n = "[list]" : o = "[/list]"
eND iF
iF iNStR(i, n) > 0 aND iNStR(i, o) > 0 tHEn
l = sTRcUT(i, n, o, 2)
pA = tRIm(rS("FileName"))
iF pA <> "" aND rIGhT(pA, 1) <> "/" aND rIGhT(pA, 1) <> "\" tHEn pA = pA & ".html"
oA = "/" & gETwEBfOLdERnAMe() & rS("FolderName") & "/"
b = rS("BigClassName")
p = rS("FileName")
iF cHEcKMaKEhTMlFIlE(p) = tRUe tHEn
p = oA & pA
p = rEPlACe(rEPlACe(p, "//", "/"), "//", "/")
p = fULlHTtPUrL(hOSt, p)
eND iF
iF rS("CustomAUrl") <> "" tHEn
p = rS("CustomAUrl")
eLSe
cALl wEBdEBuG(p, "act=Nav&NavDid=" & b)
eND iF
iF iNStR("|产品|新闻|下载|", "|" & rS("NavType") & "|") > 0 tHEn
cALl wEBdEBuG(p, "act=Nav&NavDid=" & b & "&Page=1")
eND iF
q = aHReF(p, rS("BigClassName"), rS("Target"))
r = "<a " & aHReF(p, rS("BigClassName"), rS("Target")) & sEThTMlPArAM(a, "aclass") & iIF(eA = "true", " rel='nofollow'", "") & ">" & t & "</a>" & vBCrLF
bA = rS("WebDescription")
t = cUTsTR(rS("BigClassName"), g, "... ")
t = fONtCOlORfONtB(t, rS("FontB"), rS("FontColor"))
fOR k = 1 tO 3
l = rEPlACeVAlUEpARaM(l, "ni", j)
l = rEPlACeVAlUEpARaM(l, "编号-1", j - 1)
l = rEPlACeVAlUEpARaM(l, "编号", j)
l = rEPlACeVAlUEpARaM(l, "bigclassname", rS("BigClassName"))
l = rEPlACeVAlUEpARaM(l, "title", rS("BigClassName"))
l = rEPlACeVAlUEpARaM(l, "showtitle", t)
l = rEPlACeVAlUEpARaM(l, "url", p)
l = rEPlACeVAlUEpARaM(l, "aurl", q)
l = rEPlACeVAlUEpARaM(l, "astr", r)
nEXt
p = "/admin/Product.Asp?act=ShowEditProduct&Id=" & rS("Id") & "&n=" & gETrND(11)
l = dISpLAyONlINeEDiTDiALoG("/admin/NavManage.Asp?act=EditNavBig&Id=" & rS("Id") & "&n=" & gETrND(11), l)
n = "[list-" & j & " startdialog]" : o = "[/list-" & j & " startdialog]"
iF iNStR(i, n) > 0 aND iNStR(i, o) > 0 tHEn
l = sTRcUT(i, n, o, 2) & l
eND iF
n = "[list-" & j & " enddialog]" : o = "[/list-" & j & " enddialog]"
iF iNStR(i, n) > 0 aND iNStR(i, o) > 0 tHEn
l = l & sTRcUT(i, n, o, 2)
eND iF
m = m & l
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
n = "[dialog start]" : o = "[/dialog start]"
iF iNStR(i, n) > 0 aND iNStR(i, o) > 0 tHEn
m = sTRcUT(i, n, o, 2) & m
eND iF
n = "[dialog end]" : o = "[/dialog end]"
iF iNStR(i, n) > 0 aND iNStR(i, o) > 0 tHEn
m = m & sTRcUT(i, n, o, 2)
eND iF
xY_cUStOMnAVlISt = m
eND fUNcTIoN
%>

