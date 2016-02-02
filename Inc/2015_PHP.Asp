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
fUNcTIoN fORmATtINgJSpHP(bYVaL a)
dIM b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x,y
dIM z, aA, bA
dIM cA
dIM dA
dIM eA
dIM fA
dIM gA, hA, iA
dIM jA
jA = ""
gA = "    " : hA = 0
k = 0
dIM kA
b = sPLiT(a, vBCrLF)
fOR i = 0 tO uBOuND(b)
e = b(i)
e = pHPtRIm(e)
e = rEPlACe(rEPlACe(e, cHR(10), ""), cHR(13), "")
f = pHPtRIm(e)
fA = e
o = "" : p = ""
q = ""
r = ""
s = ""
iA = 0
iF(i + 1) <= uBOuND(b) tHEn
r = b(i + 1)
s = gETbEFoREnSTr(r, "全部", 1)
eND iF
t = ""
u = tRUe
fOR h = 1 tO lEN(e)
c = mID(e, h, 1) : d = c
v = rIGhT(rEPlACe(mID(e, 1, h - 1), " ", ""), 1)
w = lEFt(rEPlACe(mID(e, h + 1), " ", ""), 1)
x = mID(e, h + 1)
iF(c = """" oR c = "'" aND dA = "") oR c = dA oR cA <> "" tHEn
kA = tRUe
iF kA = tRUe aND v = "\" tHEn
iF lEN(cA) >=1 tHEn
iF iSStRTrANsFErREd(cA)=tRUe tHEn	
kA = fALsE
eND iF
eLSe
kA = fALsE
eND iF
eND iF
iF cA = "" tHEn
dA = c
eND iF
iF c = dA aND kA = tRUe tHEn k = k + 1
iF k mOD 2 = 0 aND v <> "\" tHEn
iF mID(e, h + 1, 1) <> dA tHEn
cA = cA & c
o = o & cA
k = 0 : cA = ""
dA = ""
eLSe
cA = cA & c
eND iF
eLSe
cA = cA & c
eND iF
eLSeIF(c = "/" aND w = "*") oR jA <> "" tHEn
q = mID(e, h)
iF jA <> "" tHEn jA = jA & vBCrLF
jA = jA & q
iF iNStR(q, "*/") > 0 tHEn
o = o & jA
jA = ""
eND iF
eXIt fOR
eLSeIF c = "/" aND w = "/" tHEn
q = mID(e, h)
o = o & q
eXIt fOR
eLSeIF iNStR(".&=,+-*/:()><;", c) > 0 aND t = "" tHEn
iF eA <> "" tHEn
n = eA
aA = z
z = lCAsE(n)
o = o & eA
eA = ""
eND iF
iF c=";" aND iNStR("{;",rIGhT(tRIm(o),1))>0 tHEn
c=""
eND iF
o = o & c
aA = z
z = c
eLSeIF cHEcKAbC(c) = tRUe oR c = "_" oR eA <> "" tHEn
eA = eA & c
bA = tRUe
l = mID(e & " ", h + 1, 1)
m = mID(eA, 1, 1)
iF cHEcKAbC(l) <> tRUe aND l <> "_" tHEn
bA = fALsE
eND iF
iF cHEcKNuMBeR(l) = tRUe aND cHEcKAbC(m) = tRUe tHEn
bA = tRUe
eND iF
iF bA = fALsE tHEn
iF lCAsE(eA) = "rem" tHEn
c = mID(e, h + 1) : h = h + lEN(c)
eA = eA & c
eND iF
n = eA
aA = z
z = lCAsE(n)
o = o & eA
eA = ""
eND iF
eLSeIF cHEcKNuMBeR(c) = tRUe oR t <> "" tHEn
t = t & c
iF w <> "." aND cHEcKNuMBeR(w) = fALsE tHEn
o = o & t
t = ""
eND iF
eLSe
iF c = "{" tHEn 		    	
iF pHPtRIm(o) <> "" tHEn
iA = 1
eLSe
hA = hA + 1
eND iF
eLSeIF c = "}" tHEn
iF hA > 0 tHEn
iF pHPtRIm(o) <> "" tHEn	
y =x
iF iNStR(y,"//")>0 tHEn
y=mID(y,1,iNStR(y,"//")-1)
eND iF	
iF pHPtRIm(y) <> "" tHEn
iA = -1
eLSe
iA = 0
eND iF
eLSe
hA = hA - 1
eND iF
eND iF
eND iF
bA = tRUe
iF c = " " aND h > 1 tHEn
iF mID(e, h - 1, 1) = " " tHEn
bA = fALsE
eND iF
eND iF
iF bA = tRUe tHEn
o = o & c
eND iF
eND iF
p = p & c
iF u = fALsE tHEn eXIt fOR
nEXt
iF o = ";}" tHEn
o = "}"
eND iF
iF o <> "" aND hA > 0 tHEn
o = cOPySTrNUmB(gA, hA) & rEPlACe(o, vBCrLF, vBCrLF & cOPySTrNUmB(gA, hA))
eND iF
hA = hA + iA
iF jA = "" tHEn
g = g & o & vBCrLF
eND iF
nEXt
fORmATtINgJSpHP = g
eND fUNcTIoN
sUB pRInTAcCEsSToPHpINsTAlLFiLE()
dIM b, c, d, e, f, g, h
cALl oPEnCOnN()
b = gETtABlELiST()
c = sPLiT(b, vBCrLF)
fOR eACh d iN c
d = lCAsE(d)
b = gETfIElDLiST(d)
cALl eCHo(d, b)
e = sPLiT(b, ",")
h = h & """{$mydbpre}" & d & """ => ""CREATE TABLE `{$mydbpre}" & d & "` (" & vBCrLF
h = h & "`id` int(5) unsigned NOT NULL auto_increment," & vBCrLF
fOR eACh f iN e
iF f <> "" tHEn
f = lCAsE(f)
g = gETfIElDAlT(d, f)
iF g = "VarChar" tHEn
h = h & "`" & f & "` varchar(255) NOT NULL default ''," & vBCrLF
eLSeIF g = "Int" tHEn
h = h & "`" & f & "` int(8) NOT NULL default '0'," & vBCrLF
eLSeIF iNStR("|simpleintroduction|bodycontent|content|template|", "|" & f & "|") > 0 oR iNStR(f, "module") > 0 tHEn
h = h & "`" & f & "` mediumtext," & vBCrLF
eLSe
h = h & "`" & f & "` varchar(250) NOT NULL default ''," & vBCrLF
eND iF
eND iF
nEXt
h = h & "PRIMARY KEY  (`Id`)" & vBCrLF
h = h & "){$char};""," & vBCrLF
nEXt
dIM i, j, k, l, m
j = "//access start"
k = "//access end"
i = "\PHP2\ImageWaterMark\Include\Install.php"
b = gETfTExT(i)
l = gETsTRcUT(b, j, k, 1)
m = j & vBCrLF & h & k
b = rEPlACe(b, l, m)
cALl cREaTEfILe(i, b)
cALl eCHo("操作完成，打印数据库到php能生成文件", "<a href=""http://127.0.0.1/PHP2/ImageWaterMark/Include/Install.php"">http://127.0.0.1/PHP2/ImageWaterMark/Include/Install.php</a>")
eND sUB
%>

