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
sUB aNQuANwEB(a)
dIM b, c
iF a <> "" tHEn
eLSeIF rEQuESt("Folder") <> "" tHEn
a = rEQuESt("Folder")
eLSeIF rEQuESt("FolderPath") <> "" tHEn
a = rEQuESt("FolderPath")
eND iF
cALl eCHo("文件夹路径", a)
b = a & "\Inc\"
cALl eCHo("操作文件夹", b)
cALl dELsELfILe(b, "Install.Asp")
cALl hANdLEaNQuAN(b)
c = a & "\Admin\"
cALl eCHo("操作文件夹", c)
cALl dELsELfILe(c, "test.html|复件 MemberManage.Asp")
cALl hANdLEaNQuAN(c)
rESpONsE.eND()
eND sUB
fUNcTIoN hANdLEaNQuAN(a)
dIM b, c, d, e, f, g, h, i, j, k, l, m, n
n = vBCrLF & "'******** 压缩处理 ********" & vBCrLF
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("Scripting.FileSystemObject")
iF nOT b.fOLdEReXIsTS(a) tHEn eXIt fUNcTIoN
sET c = b.gETfOLdER(a)
fOR eACh e iN c.fILeS
g = lCAsE(rIGhT(e.nAMe, lEN(e.nAMe) - iNStRReV(e.nAMe, ".")))
iF g = "asp" tHEn
i = gETfTExT(e)
iF iNStR(i, "<" & "%") > 0 tHEn
j = cHEcKCoDE(e)
i = rEAdFIlE(e, j)
iF iNStR(i, n) > 0 tHEn
cALl eCHo(e, "已经压缩[" & j & "]")
eLSeIF i <> "" tHEn
i = gETaNQuANcONtENt(e, j)
k = iNStR(i, "<" & "%" & vBCrLF)
iF k > 0 tHEn
l = mID(i, 1, k + 2)
m = mID(i, k + 2)
i = l & n & m
eLSe
i = i & vBCrLF & "<" & "%" & n & "%" & ">"
eND iF
cALl wRItEToFIlE(e, i, j)
cALl eCHo(e, "修改成功[" & j & "]")
eND iF
dOEvENtS
eND iF
eND iF
nEXt
cALl eCHo(a, "共有文件数【" & c.fILeS.cOUnT & "】<hr>")
sET d = c.sUBfOLdERs
fOR eACh f iN d
nEXt
sET d = nOThINg
sET c = nOThINg
sET b = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "GetFileFolderList 获得全部文件（夹）列表 函数出错，FolderName=" & fOLdERnAMe
eND fUNcTIoN
fUNcTIoN gETaNQuANcONtENt(a, b)
dIM c, d, e, f, g, h, i, j, k, l, m
sET c = nEW aSPcODe
m = 19999
c.sETcOUnTRoW = m
c.sETaNQuANtYPe = "|行不退格|NO处理成一行|NO函数变量简洁处理|函数全部小写|"
aCTiON = "|note=false|color=false|clickdim=false|html=false|code=true|anquan=true|"
c.sETaSPsETtYPe = aCTiON
e = c.hANdLEaSPcODe(rEAdFIlE(a, b))
e = rEPlACe(rEPlACe(rEPlACe(e, "&lt;", "<"), "&#x5B;", "["), "&amp;", "&")
gETaNQuANcONtENt = e
eND fUNcTIoN
fUNcTIoN sHOwASpCOdECoLOr(a)
dIM b, c, d, e, f, g, h, i, j, k
sET b = nEW aSPcODe
k = 19999
b.sETcOUnTRoW = k
aCTiON = "|note=false|color=true|clickdim=false|html=false|code=true|anquan=true|"
b.sETaSPsETtYPe = aCTiON
a = b.hANdLEaSPcODe(a)
a = "<pre>" & a & "</pre>"
sHOwASpCOdECoLOr = a
eND fUNcTIoN
fUNcTIoN aSPsHOwCOdE(a)
dIM b, c, d, e, f, g, h, i, j, k
sET b = nEW aSPcODe
k = 19999
b.sETcOUnTRoW = k
aCTiON = "|note=true|color=true|clickdim=false|html=false|code=true|anquan=true|"
b.sETaSPsETtYPe = aCTiON
a = b.hANdLEaSPcODe(a)
a = "<pre>" & a & "</pre>"
aSPsHOwCOdE = a
eND fUNcTIoN
fUNcTIoN oPTiMIzATiONaSPcODe(a)
dIM b, c, d
sET b = nEW aSPcODe
c = 19999
b.sETcOUnTRoW = c
d = "|empty=true|fuhao=false|note=true|color=false|clickdim=true|html=false|code=true|anquan=false|"
b.sETaSPsETtYPe = d
a = b.hANdLEaSPcODe(a)
a=rEPlACe(a,"&lt;","<")
oPTiMIzATiONaSPcODe = a
eND fUNcTIoN
pRIvATe cHAr_SeT, fILeNAmE, aCTiON, nOTe, cOLoR, cLIcKDiM, hTMl, cODe
cLAsS aSPcODe
pRIvATe aSPd, aSPhELpTItLE, aSPhELpCOnTEnT, cOUnTRoW, rOWmSG
pRIvATe aRRaYCoLOr(199), bLUeSTr, rEDsTR, mYDiMLiST, wRItELiST
pRIvATe fUNvALuE, fUNnAMe, fUNdIM, fUNdIMsTR, fUNdIMnUMb, oKFuNDiM, nOFuNDiM, nODiMNuMB
pRIvATe rOOtFUnDIm, rOOtFUnDImSTr, rOOtFUnDImNUmB, oKRoOTfUNdIM, nORoOTfUNdIM, aSPsETtYPe, cASeNUmB
pRIvATe rSPaCEsTR, rSPaCEnUMb, aRF
pRIvATe aRRsTR(20), aRRnUMb, cSS, nROw, nOTeC, tEMpNOtE, nLEn, nLEn1, nLEn2, nLEn3
pRIvATe eVAlLIsT, bADdIMlISt, rEPlACeDImLIsT, aNQuANdIM, aNQuANtYPe, bR
fUNcTIoN hANdLEaSPcODe(bYVaL a)
dIM b, c, d, e, f, g, h, i, j, k, l
dIM m, n, o, p, q, r, s, t, u, v
dIM w, x, y, z, aA, bA, cA
dIM dA, eA, fA, gA, hA, iA, jA, kA, lA, mA, nA, oA, pA
dIM qA, rA, sA, tA, uA
dIM vA, wA, xA, yA
a = rEPlACe(a, vBTaB, "    ")
dA = sPLiT(a, vBCrLF)
qA = tRUe
nROw = 0 : cASeNUmB = 0
rSPaCEsTR = "    " : rSPaCEnUMb = 0
rA = fALsE : sA = fALsE
nODiMNuMB = 0
oKFuNDiM = "," : oKRoOTfUNdIM = ","
iF uBOuND(dA) > cOUnTRoW tHEn
rOWmSG = "显示[" & cOUnTRoW & "/" & uBOuND(dA) & "]"
eLSe
cOUnTRoW = uBOuND(dA)
eND iF
fOR cA = 0 tO cOUnTRoW
b = dA(cA) : c = b
iF iNStR(aSPsETtYPe, "|code=false|") = fALsE tHEn
b = tRIm(b)
eND iF
vA = tRIm(b)
aRF = ","
pA = 0
wA = "" : xA = 0 : yA = 0
aA = "" : bA = 1
f = lCAsE(b)
iF qA = tRUe aND tA <> "" tHEn
tA = tA & vBCrLF
eND iF
kA = "" : nA = "" : lA = "" : oA = ""
fOR gA = 1 tO lEN(b)
jA = mID(b, gA, 1)
iF qA = tRUe tHEn
tA = tA & jA
eND iF
u = rEPlACe(mID(b, 1, gA - 1), " ", "")
v = rEPlACe(mID(b, gA + 1), " ", "")
iF jA = "<" tHEn
iF mID(b, gA + 1, 2) = "%@" tHEn
qA = tRUe
sA = tRUe
kA = kA & "&lt;%@"
tA = tA & "&lt;%@"
gA = gA + 3
jA = mID(b, gA, 1)
eLSeIF mID(b, gA + 1, 1) = "%" tHEn
d = lEFt(rEPlACe(mID(b, gA), " ", ""), 4)
iF d = "<" & "%%" & ">" tHEn
gA = gA + iNStR(mID(b, gA), "%" & ">") + 1
eLSe
qA = tRUe
kA = kA & "&lt;%"
tA = tA & "&lt;%"
gA = gA + 2
eND iF
jA = mID(b, gA, 1)
eLSeIF lCAsE(mID(b, gA, 4)) = "<!--" aND iNStR(lCAsE(mID(b, gA)), "#include ") > 0 aND nA = "" tHEn
uA = mID(b, gA)
g = iNStR(lCAsE(uA), "#include ") + 8
uA = "&lt;!--" & "#Include "
kA = kA & uA
qA = tRUe
rA = tRUe
gA = gA + g
jA = mID(b, gA, 1)
eLSeIF kA = "" tHEn
qA = fALsE
eND iF
eND iF
iF qA = fALsE tHEn
iF jA = "<" tHEn
jA = "&lt;"
eLSeIF jA = "&" tHEn
jA = "&amp;"
eND iF
kA = kA & jA
eLSeIF jA = "%" aND mID(b, gA + 1, 1) = ">" tHEn
qA = fALsE : rA = fALsE : sA = fALsE
jA = jA & ">"
iF iNStR(aSPsETtYPe, "|code=false|") = fALsE tHEn
iF iNStR(tA, vBCrLF) > 0 tHEn
iF iNStR(aSPsETtYPe, "|html=false|") = fALsE tHEn
jA = jA & "<br>"
eND iF
nROw = nROw + 1
eND iF
eND iF
kA = kA & jA
gA = gA + 1
jA = mID(b, gA, 1)
tA = ""
eLSeIF jA = ">" aND rA = tRUe tHEn
qA = fALsE : rA = fALsE
d = lCAsE(tRIm(mID(b & " ", gA + 1)))
iF d <> "" tHEn
iF lEFt(d, 5) = "<!--#" tHEn
jA = jA & vBCrLF
eLSe
jA = jA & "<br>"
eND iF
nROw = nROw + 1
eND iF
kA = kA & jA
eLSeIF(jA = """" oR nA <> "") aND qA = tRUe tHEn
iF jA = """" tHEn pA = pA + 1
iF pA mOD 2 = 0 tHEn
iF mID(b, gA + 1, 1) <> """" tHEn
nA = nA & jA
x = 1
d = rIGhT(rEPlACe(mID(b, 1, gA - lEN(nA)), " ", ""), 1)
nA = rEPlACe(nA, "&", "&amp;")
nA = rEPlACe(nA, "<", "&lt;")
nA = rEPlACe(nA, "[", "&#x5B;")
iF iNStR(mID(b, 1, gA), "CreateObject") > 0 tHEn
nA = hANdLEwRItE(nA)
eND iF
iF iNStR(aSPsETtYPe, "|color=false|") = fALsE tHEn
nA = "<font color=#008000>" & nA & "</font>"
eND iF
iF d = "(" tHEn
x = 0
eND iF
kA = lEFtSPaCE(kA, x)
iF rA = tRUe tHEn
nA = rEPlACe(nA, ".asp", ".Asp")
eND iF
kA = kA & nA
pA = 0 : nA = ""
eLSe
nA = nA & jA
eND iF
eLSe
nA = nA & jA
eND iF
iF gA = lEN(b) tHEn
iF iNStR(aSPsETtYPe, "|color=false|") = fALsE tHEn
nA = rEPlACe(nA, "&", "&amp;")
nA = rEPlACe(nA, "<", "&lt;")
kA = kA & "<span style=""background:#FFB3B0;"" title=""错误：双引号有问题"">" & nA & "</span>"
eND iF
eND iF
eLSeIF jA = "'" tHEn
d = tRIm(mID(b, gA + 1))
vA = mID(b, 1, gA - 1)
jA = jA & d
y = rIGhT(tRIm(d), 1)
iF y = "=" oR y = "/" oR((y = ")" oR y = "）") aND iNStR(d, "(201") > 0) tHEn
jA = jA & vBCrLF
eND iF
jA = rEPlACe(jA, "&", "&amp;")
jA = rEPlACe(jA, "<", "&lt;")
jA = rEPlACe(jA, "[", "&#x5B;")
iF iNStR(aSPsETtYPe, "|color=false|") = fALsE tHEn
w = w + 1
jA = "<span id=""Note_" & w & """ style=""color:#999999"">" & jA & "</span>"
eND iF
iF iNStR(aSPsETtYPe, "|code=false|") = fALsE tHEn
iF iNStR(aSPsETtYPe, "|note=false|") = fALsE tHEn
iF gA <> 1 tHEn kA = lEFtSPaCE(kA, 4)
kA = kA & jA
eND iF
eLSe
kA = kA & jA
eND iF
eXIt fOR
eLSeIF iNStR("+-*/\=&<>()^,%:", jA) > 0 aND qA = tRUe aND rA = fALsE oR(rA = tRUe aND jA = "=") tHEn
d = rIGhT(u, 1) : i = tRUe
j = "" : x = 1
iF(jA = ">" aND d = "<") oR jA = "(" oR jA = ")" tHEn
x = 0
iF jA = "(" aND gA > 1 tHEn
e = mID(b, 1, gA - 1)
e = rIGhT(tRIm(e), 1)
iF iNStR("+-*\/", e) > 0 tHEn
jA = " " & jA
eND iF
eND iF
eLSeIF(jA = "=" aND d = "<") oR(jA = "=" aND d = ">") tHEn
x = 0
eLSeIF jA = "," tHEn
x = 0
eND iF
iF jA = ":" tHEn
iF d = ":" oR rEPlACe(v, ":", "") = "" tHEn
i = fALsE
eLSe
xA = xA + 1
y = mID(b, yA + 1, gA - yA - 1)
y = rEPlACe(y, "&", "&amp;")
y = rEPlACe(y, "<", "&lt;")
y = rEPlACe(y, "[", "&#x5B;")
y = rEPlACe(y, "%", "&#x25;")
yA = gA
wA = wA & y & "[云端]"
eND iF
eLSeIF jA = "-" tHEn
y = lCAsE(rEPlACe(mID(b, 1, gA), " ", ""))
iF y = "chr(-" tHEn x = 0
eND iF
iF iNStR(aSPsETtYPe, "|color=false|") = fALsE tHEn
iF jA = "," oR jA = ":" tHEn
j = "#000000"
eLSeIF jA = "(" oR jA = ")" tHEn
j = "#000099"
eLSe
j = "#0000FF"
eND iF
iF jA <> "" tHEn jA = "<font color=" & j & ">" & jA & "</font>"
eND iF
iF i = tRUe tHEn
kA = lEFtSPaCE(kA, x)
kA = kA & jA
eND iF
eLSeIF cHEcKAbC(jA) = tRUe oR jA = "_" oR oA <> "" tHEn
oA = oA & jA
i = tRUe
d = mID(b & " ", gA + 1, 1)
e = mID(oA, 1, 1)
iF cHEcKAbC(d) <> tRUe aND d <> "_" tHEn
i = fALsE
eND iF
iF cHEcKNuMBeR(d) = tRUe aND cHEcKAbC(e) = tRUe tHEn
i = tRUe
eND iF
iF i = fALsE tHEn
iF xA = 0 aND(lCAsE(oA) = "then" oR lCAsE(oA) = "else" oR lCAsE(oA) = "end") tHEn
iF bA = 1 tHEn
d = mID(b, bA, gA - lEN(oA) - bA + 1)
aA = mID(b, 1, gA) & "[云端]"
eLSe
d = mID(b, bA + 1, gA - lEN(oA) - bA)
aA = aA & tRIm(d) & "[云端]" & oA & "[云端]"
eND iF
bA = gA
eND iF
uA = oA
j = "" : x = 1
d = rEPlACe(mID(b, 1, gA - lEN(oA)), " ", "")
e = rIGhT(d, 1)
iF d = "" oR e = "." tHEn
x = 0
eLSeIF uCAsE(oA) = "LANGUAGE" aND e = "@" tHEn
x = 0
j = "#990033"
eLSeIF uCAsE(oA) = "CODEPAGE" aND iNStR(b, "@") > 0 tHEn
x = 1
j = "#990033"
eLSeIF e = "(" oR rIGhT(d, 3) = "<" & "%=" tHEn
x = 0
eLSeIF uCAsE(lEFt(oA, 1)) = "H" aND mID(b, gA - lEN(oA), 1) = "&" aND oA <> "Hour" tHEn
x = 0
eND iF
d = oA
i =(lCAsE(oA) = "eval" oR lCAsE(oA) = "execute") aND mID(" " & b, gA - lEN(oA) + 1, 1) = " "
kA = lEFtSPaCE(kA, x)
oA = aSPcOLoR(b, gA, oA, aSPsETtYPe, j)
iF iNStR(aSPsETtYPe, "|html=false|") = fALsE tHEn
iF i = tRUe tHEn
oA = "<font style=""background:#FFB3B0;"" title=""注意：" & d & "后门程序"">" & oA & "</font>"
cALl hANdLEeVAlLIsT(c, "<font color=red>" & d & "()函数可以执行任意ASP代码</font>", cA)
eLSeIF lCAsE(oA) = "createtextfile" tHEn
cALl hANdLEeVAlLIsT(c, "使用了FSO的CreateTextFile写文件", cA)
eLSeIF lCAsE(oA) = "savetofile" aND mID(" " & b, gA - lEN(d) + 1, 1) = "." tHEn
cALl hANdLEeVAlLIsT(c, "使用了Stream的SaveToFile函数写文件", cA)
eLSeIF lCAsE(oA) = "save" aND mID(" " & b, gA - lEN(d) + 1, 1) = "." tHEn
cALl hANdLEeVAlLIsT(c, "使用了XMLHTTP的Save函数写文件", cA)
eND iF
eND iF
iF lCAsE(uA) = "rem" tHEn
jA = mID(b, gA + 1) : gA = gA + lEN(jA)
w = w + 1
iF iNStR(aSPsETtYPe, "|note=false|") = fALsE tHEn
jA = "<span id=""Note_" & w & """ style=""color:#999999"">" & jA & "</span>"
kA = kA & oA & jA
eLSe
oA = ""
eND iF
eLSe
kA = kA & oA : oA = ""
eND iF
eND iF
eLSeIF cHEcKNuMBeR(jA) = tRUe oR lA <> "" tHEn
lA = lA & jA
d = rIGhT(rEPlACe(mID(b, 1, gA - lEN(lA)), " ", ""), 2)
e = mID(b & " ", gA + 1, 1)
j = "" : x = 1
iF cHEcKNuMBeR(e) = fALsE aND e <> "." tHEn
iF iNStR(aSPsETtYPe, "|color=false|") = fALsE tHEn
lA = "<font color=#FF0000>" & lA & "</font>"
eND iF
iF rIGhT(d, 1) = "(" tHEn
x = 0
eLSeIF rIGhT(d, 2) = "(-" tHEn
x = 0
eLSeIF d = "=-" tHEn
x = 0
eND iF
kA = lEFtSPaCE(kA, x)
kA = kA & lA
lA = ""
eND iF
eLSe
iF jA = "<" tHEn jA = "&lt;"
kA = kA & jA
eND iF
nEXt
iF kA <> "" tHEn
i = tRUe
iF xA > 1 aND 1 = 2 tHEn
eA = sPLiT(wA, "[云端]")
z = ""
fOR hA = 0 tO uBOuND(eA)
iF hA = 1 oR hA = 3 tHEn
z = z & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb + 1) & eA(hA) & vBCrLF
eLSe
z = z & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & eA(hA) & vBCrLF
eND iF
nEXt
kA = z
eLSeIF iNStR(aRF, ",end,function,") > 0 oR iNStR(aRF, ",end,sub,") > 0 tHEn
d = "Function" : e = "End Function"
iF iNStR(aRF, ",end,sub,") > 0 tHEn
d = "Sub" : e = "End Sub"
eND iF
cALl rOWlOCaTIoN(kA, d, e, i, tRUe)
nROw = nROw + 1
iF iNStR(aSPsETtYPe, "|html=false|") = fALsE tHEn
kA = kA & "</div>"
eND iF
iF nOFuNDiM <> "," tHEn
eA = sPLiT(nOFuNDiM, ",")
fOR eACh d iN eA
iF d <> "" tHEn
cSS = cSS & "." & fUNnAMe & d & "{background:#333333;color:#666666}"
nODiMNuMB = nODiMNuMB + 1
eND iF
nEXt
eND iF
fUNnAMe = ""
eLSeIF(iNStR(aRF, ",function,") > 0 oR iNStR(aRF, ",sub,") > 0) aND iNStR(aRF, ",exit,") = fALsE tHEn
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
fOR hA = rSPaCEnUMb tO 20
aRRsTR(hA) = ""
nEXt
d = "Function"
iF iNStR(aRF, ",sub,") > 0 tHEn d = "Sub"
aRRsTR(rSPaCEnUMb) = d
rSPaCEnUMb = rSPaCEnUMb + 1
i = fALsE
iF iNStR(aSPsETtYPe, "|html=false|") = fALsE tHEn
d = "style='cursor:hand' title='点击收缩'"
kA = rEPlACe(kA, "Function</", "<font " & d & " onclick=""OnOffDiv(this,'ID" & fUNnAMe & "')"">Function</font></")
kA = rEPlACe(kA, "Sub</", "<font " & d & " onclick=""OnOffDiv(this,'ID" & fUNnAMe & "')"">Sub</font></")
kA = "<div id=""ID" & fUNnAMe & """>" & kA
eND iF
eLSeIF iNStR(aRF, ",end,class,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "Class", "End Class", i, tRUe)
eLSeIF iNStR(aRF, ",class,") > 0 tHEn
aRRsTR(rSPaCEnUMb) = "Class"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",get,") > 0 oR iNStR(aRF, ",let,") > 0 tHEn
aRRsTR(rSPaCEnUMb) = "GetLet"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",end,") > 0 aND iNStR(lCAsE(vA), "end property") > 0 tHEn
cALl rOWlOCaTIoN(kA, "GetLet", "End Property", i, tRUe)
eLSeIF iNStR(aRF, ",if,") > 0 aND iNStR(aRF, ",then,") > 0 aND(iNStR(aRF, ",end,if,") > 0 oR iNStR(aRF, ",else,") > 0) tHEn
iF xA = 0 tHEn
y = rEPlACe(aA, "[云端] [云端]", " ")
eA = sPLiT(y, "[云端]")
z = ""
fOR hA = 0 tO uBOuND(eA) - 1
iF hA = 1 oR hA = 3 tHEn
z = z & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb + 1) & eA(hA) & vBCrLF
eLSe
z = z & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & eA(hA) & vBCrLF
eND iF
nEXt
z = lEFt(z, lEN(z) - 2) & " If"
eND iF
eLSeIF(iNStR(aRF, ",else,") > 0 oR iNStR(aRF, ",elseif,") > 0) aND iNStR(aRF, ",case,else,") = fALsE tHEn
cALl rOWlOCaTIoN(kA, "IF", "ElseIf", i, "else")
eLSeIF iNStR(aRF, ",if,") > 0 aND iNStR(aRF, ",then,") > 0 aND rIGhT(lCAsE(rEPlACe(rEPlACe(tRIm(vA), "%" & ">", ""), " ", "")), 4) = "then" tHEn
aRRsTR(rSPaCEnUMb) = "IF"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",end,if,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "IF", "End IF", i, tRUe)
eLSeIF iNStR(aRF, ",for,") > 0 aND iNStR(aRF, ",exit,for,") = fALsE tHEn
aRRsTR(rSPaCEnUMb) = "For"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",next,") > 0 aND iNStR(aRF, ",on,resume,next,") = fALsE aND iNStR(aRF, ",for,next,") = fALsE tHEn
cALl rOWlOCaTIoN(kA, "For", "Next", i, tRUe)
eLSeIF iNStR(aRF, ",do,while,") > 0 oR iNStR(aRF, ",do,until,") > 0 oR aRF = ",do," tHEn
aRRsTR(rSPaCEnUMb) = "Do"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",loop,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "Do", "Loop", i, tRUe)
eLSeIF iNStR(aRF, ",while,") > 0 tHEn
aRRsTR(rSPaCEnUMb) = "While"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",wend,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "While", "Wend", i, tRUe)
eLSeIF iNStR(aRF, ",set,nothing,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "Set", "Set Nothing", i, tRUe)
eLSeIF iNStR(aRF, "set,") > 0 tHEn
aRRsTR(rSPaCEnUMb) = "Set"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",end,with,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "With", "End Width", i, tRUe)
eLSeIF iNStR(aRF, "with,") > 0 tHEn
aRRsTR(rSPaCEnUMb) = "With"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 1 : i = fALsE
eLSeIF iNStR(aRF, ",select,case,") > 0 tHEn
aRRsTR(rSPaCEnUMb) = "Case"
kA = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
rSPaCEnUMb = rSPaCEnUMb + 2 : cASeNUmB = 1 : i = fALsE
eLSeIF iNStR(aRF, ",case,") > 0 tHEn
cALl rOWlOCaTIoN(kA, "Case", "Case", i, "else")
eLSeIF iNStR(aRF, ",end,select,") > 0 tHEn
cASeNUmB = 0
cALl rOWlOCaTIoN(kA, "Case", "End Select", i, tRUe)
eLSeIF kA = "%" & ">" tHEn
rSPaCEnUMb = 0
eND iF
iF i = tRUe tHEn
tEMpNOtE = nOTeC : nOTeC = ""
iF lEFt(b, 1) = "'" aND rSPaCEnUMb > 0 tHEn
nOTeC = kA : kA = ""
eND iF
iF tEMpNOtE <> "" tHEn
y = kA
y = gETnOTeC(tEMpNOtE, "")
iF kA = "" tHEn
y = lEFt(y, lEN(y) - 2)
eND iF
kA = y & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
eLSe
iF kA <> "" tHEn kA = cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb) & kA
eND iF
iF tRIm(kA) = "&lt;%" tHEn kA = tRIm(kA)
iF kA <> "" aND iNStR(aSPsETtYPe, "|html=false|") = fALsE tHEn kA = kA & "<span id=""Id" & nROw & """ onClick=""TestInput('Id" & nROw & "');"" style=""color:red;"" title=点击写笔记>&nbsp;</span>"
eND iF
eND iF
iF iNStR(aNQuANtYPe, "|行不退格|") > 0 tHEn
kA = tRIm(kA)
eND iF
bR = vBCrLF
iF iNStR(aNQuANtYPe, "|处理成一行|") > 0 tHEn
bR = ": "
eND iF
iF iNStR(aSPsETtYPe, "|code=false|") = fALsE tHEn
iF kA <> "" tHEn
iF qA = fALsE aND rIGhT(tRIm(c), 2) <> "%" & ">" tHEn
d = lTRiM(c)
e = lEFt(c, lEN(c) - lEN(d))
kA = e & tRIm(kA)
eLSeIF qA = fALsE aND rIGhT(tRIm(c), 2) = "%" & ">" tHEn
kA = tRIm(kA)
eND iF
fA = fA & kA & bR : nROw = nROw + 1
eND iF
eLSe
fA = fA & kA & bR : nROw = nROw + 1
eND iF
nEXt
iF nORoOTfUNdIM <> "," tHEn
eA = sPLiT(nORoOTfUNdIM, ",")
fOR eACh d iN eA
iF d <> "" tHEn
cSS = cSS & ".call" & d & "{background:#333333;color:#666666}"
nODiMNuMB = nODiMNuMB + 1
eND iF
nEXt
eND iF
iF bADdIMlISt <> "" tHEn
cALl cREaTEaDDfILe("自定变量里没有的变量列表.ini", bADdIMlISt)
eND iF
hANdLEaSPcODe = fA
eND fUNcTIoN
fUNcTIoN gETnOTeC(a, b)
dIM c, d, e
iF a = "" tHEn eXIt fUNcTIoN
e = rSPaCEnUMb
fOR c = 20 tO 0 sTEp - 1
iF aRRsTR(c) <> "" tHEn
e = c
eXIt fOR
eND iF
nEXt
d = rSPaCEnUMb
iF b = "else" tHEn d = d - 1
gETnOTeC = cOPySTrNUmB(rSPaCEsTR, d) & a & vBCrLF
a = ""
eND fUNcTIoN
fUNcTIoN aSPcOLoR(bYVaL a, bYVaL b, c, d, e)
dIM f, g, h, i, j, k, l, m, n, o, p, q, r
dIM s, t, u, v, w, x, y, z
w = c
c = ""
p = lCAsE(w)
x = ""
t = iNStR(lCAsE(bLUeSTr), "," & p & ",")
u = iNStR(lCAsE(rEDsTR), "," & p & ",")
iF p = "vbcrlf" tHEn
aSPcOLoR = "vbCrlf"
iF iNStR(d, "|color=false|") = fALsE tHEn
aSPcOLoR = "<font color=#009999>vbCrlf</font>"
eND iF
eXIt fUNcTIoN
eLSeIF t > 0 tHEn
iF p = "dim" tHEn
f = rEPlACe(mID(a, b + 1), " ", "") & ","
iF iNStR(f, "'") > 0 tHEn
f = lEFt(f, iNStR(f, "'") - 1) & ","
eND iF
iF iNStR(f, ":") > 0 tHEn
f = lEFt(f, iNStR(f, ":") - 1) & ","
eND iF
iF fUNnAMe <> "" tHEn f = rEPlACeDIm(f) & ","
f = mYFuNDiM(f) & ","
iF fUNnAMe = "" tHEn
iF rOOtFUnDImSTr = "" tHEn f = "," & f
rOOtFUnDImSTr = rOOtFUnDImSTr & f
rOOtFUnDIm = rOOtFUnDIm & f
nORoOTfUNdIM = nORoOTfUNdIM & f
eLSe
iF fUNdIMsTR = "" tHEn f = "," & f
fUNdIMsTR = fUNdIMsTR & f
fUNdIM = fUNdIM & f
nOFuNDiM = nOFuNDiM & f
aNQuANdIM = aNQuANdIM & f & ","
eND iF
eLSeIF p = "set" tHEn
f = rEPlACe(mID(a, b + 1), " ", "") & ","
iF iNStR(f, "=") tHEn
f = lEFt(f, iNStR(f, "=") - 1)
f = mYFuNDiM(f) & ","
eND iF
iF fUNnAMe = "" oR iNStR(fUNdIM, "," & f) = fALsE tHEn
iF rOOtFUnDImSTr = "" tHEn f = "," & f
rOOtFUnDImSTr = rOOtFUnDImSTr & f
rOOtFUnDIm = rOOtFUnDIm & f
nORoOTfUNdIM = rEPlACe(nORoOTfUNdIM, "," & mYFuNDiM(f) & ",", ",")
eLSe
iF fUNdIMsTR = "" tHEn f = "," & f
fUNdIMsTR = fUNdIMsTR & f
nOFuNDiM = rEPlACe(nOFuNDiM, "," & mYFuNDiM(f) & ",", ",")
eND iF
eLSeIF p = "const" tHEn
f = rEPlACe(mID(a, b + 1), " ", "") & ","
iF iNStR(f, "=") > 0 tHEn
f = lEFt(f, iNStR(f, "=") - 1)
f = rEPlACe(f, " ", "")
f = mYFuNDiM(f) & ","
iF fUNnAMe = "" tHEn
iF rOOtFUnDImSTr = "" tHEn f = "," & f
rOOtFUnDImSTr = rOOtFUnDImSTr & f
rOOtFUnDIm = rOOtFUnDIm & f
nORoOTfUNdIM = nORoOTfUNdIM & f
eLSe
iF fUNdIMsTR = "" tHEn f = "," & f
fUNdIMsTR = fUNdIMsTR & f
fUNdIM = fUNdIM & f
rOOtFUnDIm = rOOtFUnDIm & f
eND iF
eND iF
eLSeIF p = "call" tHEn
f = rEPlACe(mID(a, b + 1), " ", "") & ","
iF iNStR(f, "(") > 0 tHEn
f = lEFt(f, iNStR(f, "(") - 1)
f = rEPlACe(f, " ", "")
f = mYFuNDiM(f) & ","
iF rOOtFUnDImSTr = "" tHEn f = "," & f
rOOtFUnDImSTr = rOOtFUnDImSTr & f
rOOtFUnDIm = rOOtFUnDIm & f
eND iF
eLSeIF(p = "sub" oR p = "function") aND fUNnAMe = "" tHEn
iF gETfUNnAMeDIm(a, fUNnAMe, fUNdIM) <> "" tHEn
fUNnAMe = rEPlACe(tRIm(fUNnAMe), vBCrLF, "")
iF iNStR(fUNnAMe, " ") tHEn
fUNnAMe = mID(fUNnAMe, iNStRReV(fUNnAMe, " ") + 1)
eND iF
fUNdIM = rEPlACe(fUNdIM, vBCrLF, "")
aNQuANdIM = fUNdIM & ","
fUNdIM = "," & rEPlACeDIm(fUNnAMe & "," & fUNdIM) & ","
fUNdIM = "," & mYFuNDiM(fUNdIM) & ","
nOFuNDiM = ","
fUNdIMsTR = fUNdIM
fUNdIMnUMb = 0
eND iF
eND iF
aRF = aRF & p & ","
iF iNStR(d, "|code=false|") = fALsE tHEn
aSPcOLoR = mID(bLUeSTr, t + 1, lEN(p))
w = aSPcOLoR
eLSe
aSPcOLoR = w
eND iF
iF iNStR(d, "|color=false|") = fALsE tHEn
iF e = "" tHEn e = "#0000FF"
aSPcOLoR = "<font color=" & e & ">" & aSPcOLoR & "</font>"
eND iF
x = "错误 ASP内置函数不能用 "
eLSeIF u > 0 tHEn
v = aSPhELpTIp(w, mID(a, b + 1))
iF v <> "" tHEn v = "title=""" & v & """"
iF iNStR(d, "|code=false|") = fALsE tHEn
aSPcOLoR = mID(rEDsTR, u + 1, lEN(p))
w = aSPcOLoR
eLSe
aSPcOLoR = w
eND iF
iF iNStR(d, "|color=false|") = fALsE tHEn
iF e = "" tHEn e = "#990099"
aSPcOLoR = "<font color=" & e & " " & v & ">" & aSPcOLoR & "</font>"
eND iF
x = "注意 ASP内置函数 "
eND iF
iF iNStR(d, "|clickdim=false|") = fALsE tHEn
iF fUNdIM <> "" tHEn
i = sPLiT(fUNdIM, ",")
fOR h = 0 tO uBOuND(i)
r = i(h)
iF p = lCAsE(r) tHEn
fUNdIMnUMb = fUNdIMnUMb + 1
q = ""
iF iNStR(fUNdIMsTR, "," & r & ",") > 0 tHEn
q = " title='" & x & "点击让变量突出显示" & h & "-" & fUNdIMnUMb & "_有[]处' onclick=""AddColor('" & fUNnAMe & r & "_', '" & lCAsE(aRRaYCoLOr(h)) & "');"""
fUNdIMsTR = rEPlACe(fUNdIMsTR, "," & r & ",", ",")
iF iNStR(oKFuNDiM, "," & r & ",") = fALsE tHEn
oKFuNDiM = oKFuNDiM & r & ","
eLSe
nOFuNDiM = rEPlACe(nOFuNDiM, "," & r & ",", ",")
eND iF
eLSe
nOFuNDiM = rEPlACe(nOFuNDiM, "," & r & ",", ",")
eND iF
iF x <> "" tHEn
y = aSPcOLoR
eLSe
y = mYFuNDiM(r)
eND iF
v = aSPhELpTIp(y, "")
iF v <> "" tHEn v = "title=""" & v & """"
iF iNStR(aNQuANtYPe, "|函数变量简洁处理|") > 0 tHEn
iF iNStR("," & aNQuANdIM, "," & y & ",") > 0 tHEn
z = sPLiT(aNQuANdIM, ",")
fOR b = 0 tO uBOuND(z)
iF z(b) = y tHEn
iF b + 1 > 26 tHEn
y = mID("ABCDEFGHIJKLMNOPQRSTUVWXYZ",(b + 1) / 26, 1)
y = y & mID("ABCDEFGHIJKLMNOPQRSTUVWXYZ",(b + 1) mOD 26, 1)
eLSe
y = mID("ABCDEFGHIJKLMNOPQRSTUVWXYZ", b + 1, 1)
eND iF
eXIt fOR
eND iF
nEXt
eND iF
eND iF
aSPcOLoR = "<span name='" & r & "' id='" & fUNnAMe & r & "_" & fUNdIMnUMb & "' " & v & " class='" & fUNnAMe & r & "' " & q & ">" & y & "</span>"
eXIt fUNcTIoN
eND iF
nEXt
eND iF
iF rOOtFUnDIm <> "" aND iNStR(d, "|clickdim=false|") = fALsE tHEn
i = sPLiT(rOOtFUnDIm, ",")
fOR h = 0 tO uBOuND(i)
r = i(h)
iF p = lCAsE(r) tHEn
rOOtFUnDImNUmB = rOOtFUnDImNUmB + 1
q = ""
iF iNStR(rOOtFUnDImSTr, "," & r & ",") > 0 tHEn
q = " title='" & x & "点击让变量突出显示" & h & "-" & rOOtFUnDImNUmB & "_有[]处' onclick=""AddColor('" & r & "_', '" & lCAsE(aRRaYCoLOr(h)) & "');"""
rOOtFUnDImSTr = rEPlACe(rOOtFUnDImSTr, "," & r & ",", ",")
iF iNStR(oKRoOTfUNdIM, "," & r & ",") = fALsE tHEn
oKRoOTfUNdIM = oKRoOTfUNdIM & r & ","
eLSe
nORoOTfUNdIM = rEPlACe("," & nORoOTfUNdIM, "," & r & ",", ",")
eND iF
eLSe
nORoOTfUNdIM = rEPlACe("," & nORoOTfUNdIM, "," & r & ",", ",")
eND iF
iF x <> "" tHEn
y = aSPcOLoR
eLSe
y = mYFuNDiM(r)
eND iF
v = aSPhELpTIp(y, "")
iF v <> "" tHEn v = "title=""" & v & """"
aSPcOLoR = "<span name='call" & r & "' id='" & r & "_" & rOOtFUnDImNUmB & "' " & v & " class='call" & r & "' " & q & ">" & y & "</span>"
eXIt fUNcTIoN
eND iF
nEXt
eND iF
eND iF
iF aSPcOLoR = "" tHEn
aSPcOLoR = w
iF iNStR(d, "|code=false|") = fALsE tHEn
aSPcOLoR = mYFuNDiM(aSPcOLoR)
eND iF
aSPcOLoR = aSPcOLoR
eND iF
iF iNStR(aNQuANtYPe, "|函数全部小写|") > 0 tHEn
aSPcOLoR = lCAsE(aSPcOLoR)
eND iF
eND fUNcTIoN
sUB rOWlOCaTIoN(a, bYVaL b, c, d, e)
dIM f, g, h, i, j, k,l
k = "|"
aRRnUMb = -1
fOR f = 20 tO 0 sTEp - 1
iF aRRsTR(f) = b tHEn
aRRnUMb = f
eXIt fOR
eLSeIF aRRsTR(f) <> "" tHEn
k = k & aRRsTR(f) & "|"
eND iF
nEXt
g = rSPaCEnUMb - 1 - cASeNUmB
iF g < 0 tHEn g = -9
iF aRRnUMb = g tHEn
iF e = "else" tHEn
a = gETnOTeC(nOTeC, "else") & cOPySTrNUmB(rSPaCEsTR, rSPaCEnUMb - 1) & a
d = fALsE
eLSe
iF e = tRUe tHEn aRRsTR(aRRnUMb) = ""
rSPaCEnUMb = rSPaCEnUMb - 1
eND iF
eLSe
h = fALsE
iF aRRnUMb >= 0 tHEn
iF(iNStR(k, "|IF|") > 0 oR iNStR(k, "|Function|") > 0) aND aRRsTR(aRRnUMb) = "Set" tHEn
h = "不操作"
eLSe
rSPaCEnUMb = aRRnUMb
h = gETnOTeC(nOTeC, "") & cOPySTrNUmB(rSPaCEsTR, aRRnUMb)
rSPaCEnUMb = aRRnUMb
iF e = tRUe tHEn aRRsTR(aRRnUMb) = ""
d = fALsE
iF e = "else" tHEn
rSPaCEnUMb = rSPaCEnUMb + 1
eND iF
eND iF
eND iF
iF h <> "不操作" tHEn
i = ""
iF aRRnUMb >= 0 tHEn
fOR f = 10 tO aRRnUMb + 1 sTEp - 1
iF aRRsTR(f) <> "" tHEn
i = i & aRRsTR(f) & "|"
eND iF
nEXt
eLSe
h = fALsE
k = ""
eND iF
iF h <> fALsE tHEn
l = "#CCCCCC" : j = "注意：" & c & "前面有【" & i & "】未关闭"
eLSe
l = "#FFB3B0" : j = "错误：" & c & "，未定义" & b
h = ""
eND iF
iF k <> "|" aND iNStR(aSPsETtYPe, "|html=false|") = fALsE tHEn
a = h & "<font style=""border:1px #000000 dotted;background:" & l & ";"" title=""" & j & """>" & a & "</font>"
eLSe
a = h & a
eND iF
eND iF
eND iF
eND sUB
pRIvATe sUB cLAsS_iNItIAlIZe()
dIM b, c, d
sET aSPd = cREaTEoBJeCT("Scripting.Dictionary")
aSPd.aDD "Abs", "返回数字的绝对值"
aSPd.aDD "Sqr", "返回数值表达式的平方根"
aSPd.aDD "Sgn", "返回表示数字符号的整数"
aSPd.aDD "Rnd", "返回一个随机生成的数字"
aSPd.aDD "Log", "返回指定数值的自然对数"
aSPd.aDD "Exp", "返回e的指定次幂"
aSPd.aDD "Sin", "返回指定弧度的正弦值"
aSPd.aDD "Cos", "返回指定弧度的余弦值"
aSPd.aDD "Tan", "返回指定弧度的正切值"
aSPd.aDD "Atn", "返回指定数值的反正切值"
aSPd.aDD "Int", "返回指定数字的整数部分"
aSPd.aDD "Round", "对参数按指定的位数进行四舍五入"
aSPd.aDD "Fix", "返回指定数值的整数部分"
aSPd.aDD "Now", "返回当前的日期时间"
aSPd.aDD "Date", "返回当前的系统日期"
aSPd.aDD "Time", "返回当前的系统时间"
aSPd.aDD "Year", "从指定的表达式中提取年份"
aSPd.aDD "Month", "从指定的表达式中提取月份"
aSPd.aDD "Day", "从指定表达式中提取日期"
aSPd.aDD "Hour", "从指定的表达式中提取整点值"
aSPd.aDD "Minute", "从指定的表达式中提取分钟数"
aSPd.aDD "Second", "从指定的表达式中提取秒数"
aSPd.aDD "DateAdd", "将指定日期添加上指定时间间隔并返回新值"
aSPd.aDD "DateDiff", "计算两个日期之间的时间间隔"
aSPd.aDD "DatePart", "返回给定日期中的某一部分"
aSPd.aDD "DateSerial", "根据提供的年月日的数值返回一个Date子类型的数据"
aSPd.aDD "DateValue", "将指定的字符串转化为Date子类型的数据"
aSPd.aDD "MonthName", "根据指定的数字返回代表该月份的字符串"
aSPd.aDD "Weekday", "返回代表一周中某一天的整数"
aSPd.aDD "WeekdayName", "根据周次返回代表该周次的字符串"
aSPd.aDD "TimeSerial", "根据提供的时分秒的数值返回一个Date子类型的数据"
aSPd.aDD "TimeValue", "将指定的字符串转化为Date子类型的数据"
aSPd.aDD "CBool", "将表达式转化为Boolean子类型"
aSPd.aDD "CByte", "将表达式转化为Byte子类型"
aSPd.aDD "CDbl", "将表达式转化为Double子类型"
aSPd.aDD "Chr", "将ANSI字符代码（～）转化为对应的字符"
aSPd.aDD "CInt", "将表达式转化为Integer数值子类型"
aSPd.aDD "CLng", "将表达式转化为Long数值子类型"
aSPd.aDD "Cstr", "将表达式转化为String子类型"
aSPd.aDD "CCur", "将表达式转化为Currency子类型"
aSPd.aDD "CDate", "将日期表达式转化为Date子类型"
aSPd.aDD "CSng", "将表达式转化为Single数值子类型"
aSPd.aDD "Asc", "返回与字符串首字母相对应的ANSI字符代码（～）"
aSPd.aDD "Oct", "返回八进制的字符串"
aSPd.aDD "Hex", "返回十六进制的字符串"
aSPd.aDD "FormatNumber", "格式化指定的数值表达式"
aSPd.aDD "FormatDateTime", "格式化指定的日期时间表达式"
aSPd.aDD "FormatCurrency", "格式化指定的货币表达式"
aSPd.aDD "FormatPercent", "格式化某一数值为百分数"
aSPd.aDD "IsArray", "判断某一变量是否为数组变量"
aSPd.aDD "IsDate", "判断某一变量是否为或者可以转化为日期表达式"
aSPd.aDD "IsEmpty", "判断变量是否为空"
aSPd.aDD "IsNull", "判断表达式中是否包含有效数据"
aSPd.aDD "IsNumeric", "判断表达式的值是否为数字"
aSPd.aDD "Is_object_", "判断表达式的值是否为某一对象"
aSPd.aDD "VarType", "返回指定变量的子类型"
aSPd.aDD "TypeName", "返回指定变量子类型的信息"
aSPd.aDD "MsgBox", "弹出含有提示信息的对话框"
aSPd.aDD "InputBox", "弹出可输入数据的对话框"
aSPd.aDD "ScriptEngine", "返回一个代表当前所使用的脚本语言的字符串"
aSPd.aDD "ScriptEngineBuildVersion", "返回所使用的脚本引擎的编译版本号"
aSPd.aDD "ScriptEngineMajorVersion", "返回所使用的脚本引擎的主版本号"
aSPd.aDD "ScriptEngineMinorVersion", "返回所使用脚本引擎的次版本号"
aSPd.aDD "Array", "利用所给的参数返回一个数组"
aSPd.aDD "UBound", "返回数组的最大可用下标"
aSPd.aDD "LBound", "返回数组的最小可用下标"
aSPd.aDD "Filter", "返回一个数组其中包含了满足条件的字符串"
aSPd.aDD "InStr", "返回某字符串在指定字符串中第一次出现的位置"
aSPd.aDD "InStrRev", "返回某字符串在指定字符串中从结尾算起的出现位置"
aSPd.aDD "Join", "将数组中的字符串连接为一个字符串"
aSPd.aDD "LCase", "将字符串中的字母全部转换为小写形式"
aSPd.aDD "Left", "从字符串的左端取指定数目的字符"
aSPd.aDD "Len", "返回字符串的长度或者存储某一变量所需要的字节数"
aSPd.aDD "Ltrim", "返回不带前导空格的字符串"
aSPd.aDD "Replace", "将字符串中指定字符串替换为其他内容"
aSPd.aDD "Right", "从字符串的右侧获取指定数目的字符"
aSPd.aDD "Rtrim", "删除字符串的后续空格"
aSPd.aDD "Mid", "从字符串中指定位置获取指定长度的字符串"
aSPd.aDD "Split", "返回包含指定数目子字符串的一维数组"
aSPd.aDD "StrComp", "对两个指定的字符串进行比较"
aSPd.aDD "StrReverse", "将指定字符串倒序排列并返回重新排列后的字符串"
aSPd.aDD "String", "返回由指定数目的某一字符组成的字符串"
aSPd.aDD "Trim", "删除字符串的前导和后续空格"
aSPd.aDD "Space", "返回由指定数目的空格组成的字符串"
aSPd.aDD "UCase", "将字符串中的字母全部转换为大写形式"
aSPd.aDD "LoadPicture", "返回一个图片对象"
aSPd.aDD "Create_object_", "创建并返回一个对象"
aSPd.aDD "Get_object_", "从指定文件中获得一个Automation对象"
aSPd.aDD "RGB", "返回代表某一颜色的整数"
aSPd.aDD "Angle", "翻译：角度,观点"
aSPhELpTItLE = aSPd.kEYs
aSPhELpCOnTEnT = aSPd.iTEmS
b = "#990000,#999900,#333366,#663300,#669966,#FF6600,#CC33CC,#993366,#FF0099,#669900,#336699,#99CCCC,#CC3366,#FF9900,#9933FF,#669900,#6699FF,#333366,#99CC66,#996600,#000033,#003300,#330000,#660000,#000099,#330099,#6600FF,#990000,#CC0000,#FF0000,#990066,#FF0066,#CC00CC,"
c = sPLiT(b, ",")
fOR d = 1 tO uBOuND(c)
aRRaYCoLOr(d) = c(d)
nEXt
bLUeSTr = ",If,Then,ElseIf,Else,End,Function,Sub,ByVal,,Dim,Nothing,On,Resume,Call,True,False,Not,Is,Or,And,For,Next,Exit,Execute,Randomize,Do,While,Loop,Set,Mod,To,Each,In,Select,Case,Until,With,Wend,Step,Option,Explicit,Class,Private,Public,Get,Let,Const,ByRef,ReDim,Preserve,LANGUAGE,Rem,Execute,,"
rEDsTR = ",Abs,Sqr,Sgn,Rnd,Log,Exp,Sin,Cos,Tan,Atn,Int,Round,Fix,Now,Date,Time,Year,Month,Day,Hour,Minute,Second,DateAdd,DateDiff,DatePart,DateSerial,DateValue,MonthName,Weekday,WeekdayName,TimeSerial,TimeValue,CBool,CByte,CDbl,Chr,CInt,CLng,Cstr,CCur,CDate,CSng,Asc,Oct,Hex,FormatNumber,FormatDateTime,FormatCurrency,FormatPercent,IsArray,IsDate,IsEmpty,IsNull,IsNumeric,Is_object_,VarType,TypeName,MsgBox,InputBox,ScriptEngine,ScriptEngineBuildVersion,ScriptEngineMajorVersion,ScriptEngineMinorVersion,Array,UBound,LBound,Filter,InStr,InStrRev,Join,LCase,Left,Len,Ltrim,Replace,Right,Rtrim,Mid,Split,StrComp,StrReverse,String,Trim,Space,UCase,LoadPicture,Create_object_,Get_object_,RGB,Request,ServerVariables,"
rEDsTR = rEDsTR & ",Response,Write,MoveNext,Close,Eof,Bof,Server,MapPath,Server,CreateObject,Err,Error,Description,CInt,CStr,String,CDate,Size,Session,Open,AddNew,Update,HTMLEncode,File,Test,Type,Mode,CharSet,Form,InStrB,URLEncode,Field,RegExp,Number,QueryString,Name,Item,AscB,MidB,LenB,Buffer,Expires,AddHeader,Timer,BinaryWrite,Redirect,Version,Property,ChrB,Cookies,Value,Clear,ContentType,AscW,AppliCation,Lock,UnLock,Contents,CodePage,ScriptTimeOut,Cancel,ExpiresAbsolute,CacheControl,ChrW,Source,Eval,Name,Count,Match,Fields,"
mYDiMLiST = ",A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,nCount,Code,Id,IP,Str,Length,Txt,Title,Content,Age,Sex,CountNumb,UserName,UserPass,PassWord,UserAdmin,AdminName,AdminPass,UserPassWord,Tel,Fax,Mail,ListCode,Regex,Reg,Re,Values,StrChar,TempChar,Fso,Fs,Fc,Ts,Path,FileName,FolderName,ClsCache,CacheObj,Obj,Conn,Rs,Rss,Rsx,Sql,AddSql,SetCache,CacheName,CacheValue,GetCache,CacheData,Flag,CacheFlag,CacheTime,FilterStr,CheckFile,FilePath,Html,HtmlStr,HtmlName,ServerMap,StrBadChar,ArrBadChar,YY,Mi,StrDateTime,IsHtml,AA,Ret,S1,S2,C1,C2,PosX,PosY,sUserName,sPassWord,MyArray,Page,SiteInfo,PageUrl,MakeName,FName,MakeFolder,Folder,Class_Initialize,Class_Terminate,"
mYDiMLiST=mYDiMLiST &"MakeFile,HtmlMaker,GetName,ConnStr,UserIp,UserIp2,GetBody,XmlHttp,ResponseBody,ReadyState,SetTimeOuts,SaveImage,ToFile,Action,Act,Step1,Step2,Step3,Step4,Step5,Success,Check_Install,Install,GetRnd,N1,N2,N3,N4,N5,T0,Check_Write,ObjFolder,ObjSubFolders,SubFCount,ObjTest,Ver,IntVal,Color,StrTemp,Arr,Ch,Cnf,Co,SS,Tp,Dire,V1,V2,V3,Ma,FolderPath,db,Eval,Execute,Include,Inc,Did,Sid,Tid,Folders,Files,Fl,File_F,SubFolders,MyFile,F1,F2,F3,F4,F5,RemoveIframe,RemoveScript,FileTxt,File_W,IframeStr,TempStr,TempC,Days,StrLen,StrUrl,TotalNumber,MaxperPage,CurrentPage,Email,Names,NoHtml,New,Text,FindWord,RsClass,StrNoResult,StrWord,ClassId,MM,DD,RiQi,XiaoShi,FenZhong,Miao,Info,Pass,"
mYDiMLiST=mYDiMLiST &"ServerList,SetDot,Px,Py,Graph,Width,Height,SetDraw,PIndex,PNumber,DotData,Angle,SitePath,SiteCharset,RsId,Rs1,Xx,Add,Edit,Del,AddSub,Sql1,Admin,cName,MaxPage,Cn,En,NewStr,HaveChar,LastChar,DirPath,Strng,Temp,Echo,ToPic,ChkStr,Val,Str0,Str1,Str2,Str3,GetIP,ShowMsg,ShowPage,StrLength,Fso1,Fso2,StrField,KeyWord,Main,SplStr,Splxx,LCaseS,ArrID,DoMain,Url,Url1,StrPage,Host,Iswww,"
mYDiMLiST=mYDiMLiST & "Pattern,Send,Pos,Dec,Res,LoopCount,TempResult,II,OpenTextFile,ReadLine,FileExists,DeleteFile,CloseDB,ComeUrl,Cook,StyleId,FText,CreateTextFile,StarTime,EndTime,DBPath,BB,File,Stm,Read,Width,Height,LoadFromFile,FoundErr,ErrMsg,Msg,FsoType,Search,QQ,Rw,Echo,Eerr,mCode,OutPut,Margin,Create,Border,OffSet,III,Ex,Pth,NewCnt,AddCode,Stream,ThePath,TheFolder,SysFileList,MMMM,AAA,WS,SI,Timer1,Tmp,Hu,StartN,EndN,GPath,PortNum,FC2,OFile,TFile,TFile2,FSubFolers,RenameFolder,Rs_1,Rs_2,Rs_3,Rsp,Rsl,Web_Name,Web_Url,Web_Image,Web_Title,Web_Keywords,Web_Description,Web_Copyright,Web_Theme,Web_Consult,Web_TopHTML,Web_BottomHTML,Web_Tel,HtmlWrite,ErrNo,,,,"
wRItELiST = ",Adodb.Connection,Adodb.RecordSet,Scripting.FileSystemObject,ADODB.Stream,"
rEPlACeDImLIsT = ",NumbCount=nCount,OKNumb=nOK,ErrNumb=nErr,StrErr=C,ErrMsg=C,StrTemp=C,fString=C,,,,,,,"
eND sUB
fUNcTIoN aSPhELpTIp(bYVaL a, bYVaL b)
dIM c, d, e
fOR c = 0 tO aSPd.cOUnT - 1
iF lCAsE(aSPhELpTItLE(c)) = lCAsE(a) tHEn
iF lCAsE(a) = "chr" tHEn
d = lEFt(b, iNStR(b, ")") - 1)
d = rEPlACe(d, "(", "")
e = vBCrLF & "Chr(" & d & ")="
iF cHEcKNuMBeR(d) = tRUe tHEn
iF d = "10" oR d = "13" tHEn
e = e & "(回车键)"
eLSeIF d = "32" tHEn
e = e & "(空格)"
eLSeIF d = "0" tHEn
e = e & "(中断程序,停止执行)"
eLSe
e = e & "(" & cHR(d) & ")"
eND iF
e = rEPlACe(e, "'", "&#x27;")
eLSe
e = e & d
eND iF
eND iF
aSPhELpTIp = aSPhELpCOnTEnT(c) & e
eXIt fOR
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN mYFuNDiM(bYVaL a)
dIM b, c, d, e, f, g, h, i
b = sPLiT(a, ",")
fOR eACh c iN b
c = tRIm(c)
f = lCAsE(c)
iF c <> "" tHEn
iF iNStR(c, "(") > 0 tHEn
c = mID(c, 1, iNStR(c, "(") - 1)
eND iF
i = tRUe
h = iNStR(lCAsE(rEPlACeDImLIsT), "," & f & "=")
g = iNStR(lCAsE(mYDiMLiST), "," & f & ",")
iF h > 0 tHEn
e = mID(rEPlACeDImLIsT, h + 1)
e = mID(e, 1, iNStR(e, ",") - 1)
e = mID(e, iNStR(e, "=") + 1)
iF iNStR(fUNdIM & rOOtFUnDIm, "," & e & ",") > 0 tHEn
c = e
i = fALsE
eND iF
eND iF
iF i = tRUe tHEn
iF g > 0 tHEn
c = mID(mYDiMLiST, g + 1, lEN(f))
eLSeIF iNStR("," & bADdIMlISt, "," & c & ",") = fALsE tHEn
bADdIMlISt = bADdIMlISt & c & ","
eND iF
eND iF
d = d & c & ","
eND iF
nEXt
iF d <> "" tHEn d = lEFt(d, lEN(d) - 1)
mYFuNDiM = d
eND fUNcTIoN
fUNcTIoN hANdLEwRItE(a)
dIM b, c
b = lEFt(a, lEN(a) - 1)
b = rIGhT(b, lEN(b) - 1)
b = lCAsE(tRIm(b))
c = iNStR(lCAsE(wRItELiST), "," & b & ",")
iF c > 0 tHEn
a = """" & mID(wRItELiST, c + 1, lEN(b)) & """"
eND iF
hANdLEwRItE = a
eND fUNcTIoN
fUNcTIoN cOPySTrNUmB(bYVaL a, b)
iF iNStR(aSPsETtYPe, "|code=false|") > 0 tHEn cOPySTrNUmB = "" : eXIt fUNcTIoN
dIM c, d
iF b > 0 tHEn
d = a
fOR c = 1 tO b - 1
a = a & d
nEXt
eLSe
a = ""
eND iF
cOPySTrNUmB = a
eND fUNcTIoN
fUNcTIoN lEFtSPaCE(bYVaL a, bYVaL b)
iF iNStR(aSPsETtYPe, "|code=false|") > 0 tHEn lEFtSPaCE = a : eXIt fUNcTIoN
dIM c, d
d = 0
fOR c = lEN(a) tO 1 sTEp - 1
iF mID(a, c, 1) <> " " tHEn eXIt fOR
d = d + 1
nEXt
iF d > b aND rEPlACe(a, " ", "") <> "" tHEn
a = lEFt(a, lEN(a) - d + b)
eLSeIF d < b aND 1 = 1 tHEn
fOR c = d tO b - 1
a = a & " "
nEXt
eND iF
lEFtSPaCE = a
eND fUNcTIoN
sUB hANdLEeVAlLIsT(bYVaL a, b, c)
a = rEPlACe(a, "<", "&lt;")
eVAlLIsT = eVAlLIsT & "【" & a & "】" & b & "|在第[" & c + 1 & "]行<br>"
eND sUB
pUBlIC pROpERtY lET sETaSPsETtYPe(sTR)
aSPsETtYPe = sTR
eND pROpERtY
pUBlIC pROpERtY lET sETcOUnTRoW(sTR)
cOUnTRoW = cINt(sTR)
eND pROpERtY
pUBlIC pROpERtY lET sETrEPlACeDImLIsT(sTR)
rEPlACeDImLIsT = sTR
eND pROpERtY
pUBlIC pROpERtY lET sETaNQuANtYPe(sTR)
aNQuANtYPe = sTR
eND pROpERtY
pUBlIC pROpERtY gET gETcSS
gETcSS = cSS
eND pROpERtY
pUBlIC pROpERtY gET gETnROw
gETnROw = nROw
eND pROpERtY
pUBlIC pROpERtY gET gETnODiMNuMB
gETnODiMNuMB = nODiMNuMB
eND pROpERtY
pUBlIC pROpERtY gET gETrOWmSG
gETrOWmSG = rOWmSG
eND pROpERtY
pUBlIC pROpERtY gET gETeVAlLIsT
gETeVAlLIsT = eVAlLIsT
eND pROpERtY
pRIvATe sUB cLAsS_tERmINaTE()
eND sUB
eND cLAsS
%>


