<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-01
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN gEThTTpPAgE(bYVaL a, bYVaL b)
gEThTTpPAgE = hANdLEgEThTTpPAgE(a, b)(0)
eND fUNcTIoN
fUNcTIoN hANdLEgEThTTpPAgE(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
dIM c, d, e, f, g, h
c = nOW()
b = hANdLEsTRcHArSEt(b)
iF iSNuLL(a) = tRUe oR lEN(a) < 18 oR a = "$False$" tHEn
hANdLEgEThTTpPAgE = "$False$"
eXIt fUNcTIoN
eND iF
dIM i
sET i = cREaTEoBJeCT("MSXML2.XMLHTTP")
cALl i.oPEn("GET", a, fALsE)
i.sENd
iF i.rEAdYStATe <> 4 tHEn
sET i = nOThINg
hANdLEgEThTTpPAgE = "$False$"
eXIt fUNcTIoN
eND iF
f = bYTeSToBStR(i.rESpONsEBoDY, b)
d = i.sTAtUS
e = dATeDIfF("s", c, nOW())
h = sTRlENgTH(f)
g = "|-*ypia=|"
hANdLEgEThTTpPAgE = sPLiT(f & g & d & g & e & g & h, g)
sET i = nOThINg
eND fUNcTIoN
fUNcTIoN gETuRLcONtENt(a, b)
gETuRLcONtENt = gEThTTpPAgE(a, b)
eND fUNcTIoN
fUNcTIoN gEThTTpURl(a, b)
gEThTTpURl = gEThTTpPAgE(a, b)
eND fUNcTIoN
fUNcTIoN bYTeSToBStR(a, b)
dIM c
iF iSNuL(a) tHEn eXIt fUNcTIoN
sET c = cREaTEoBJeCT("ADODB.Stream")
c.tYPe = 1
c.mODe = 3
c.oPEn
cALl c.wRItE(a)
c.pOSiTIoN = 0
c.tYPe = 2
c.cHArSEt = b
bYTeSToBStR = c.rEAdTExT
c.cLOsE
sET c = nOThINg
eND fUNcTIoN
fUNcTIoN sTRcUT(bYVaL a, bYVaL b, bYVaL c, bYVaL d)
dIM e, f, g, h, i
iF iNStR(a, b) = fALsE oR iNStR(a, c) = fALsE tHEn
i = ""
eXIt fUNcTIoN
eND iF
sELeCT cASe d
cASe 1
e = iNStR(a, b)
f = mID(a, e + lEN(b))
g = e + iNStR(f, c) + lEN(b) + lEN(c) - 1
cASe eLSe
e = iNStR(a, b) + lEN(b)
f = mID(a, e)
g = e + iNStR(f, c) - 1
eND sELeCT
h = g - e
iF h >= 0 tHEn
i = mID(a, e, h)
eLSe
i = ""
eND iF
iF d = 3 tHEn
i = b & i
eND iF
iF d = 4 tHEn
i = i & c
eND iF
sTRcUT = i
eND fUNcTIoN
fUNcTIoN gETsTRcUT(bYVaL a, bYVaL b, bYVaL c, bYVaL d)
gETsTRcUT = ""
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
gETsTRcUT = sTRcUT(a, b, c, d)
eND iF
eND fUNcTIoN
fUNcTIoN cUTsTR(bYVaL a, bYVaL b, bYVaL c)
dIM d, e, f
f = 0
b = cINt(b)
iF c = "" tHEn c = "..."
iF lCAsE(c) = "none" oR lCAsE(c) = "null" tHEn c = ""
cUTsTR = a
fOR d = 1 tO lEN(a)
e = aSC(mID(cSTr(a), d, 1))
iF e < 0 tHEn e = e + 65536
iF e < 255 tHEn f = f + 1
iF e > 255 tHEn f = f + 2
iF f >= b tHEn cUTsTR = lEFt(a, d) & c : eXIt fUNcTIoN
nEXt
eND fUNcTIoN
fUNcTIoN cUTsTRnOLu(a, b, c)
dIM d, e, f, g, h
b = lCAsE(b)
c = lCAsE(c)
e = lCAsE(a)
iF iNStR(e, b) > 0 tHEn
f = iNStR(e, b)
d = mID(a, f)
e = mID(d, lEN(b) + 1)
h = mID(d, 1, lEN(b) + 1)
e = rEPlACe(e, "<", "&lt;")
g = iNStR(e, c)
cALl eCHo("nEndLen", g)
d = mID(a, f, g + lEN(b))
cUTsTRnOLu = d
eND iF
eND fUNcTIoN
fUNcTIoN sETcUTtDStR(bYVaL a, bYVaL b, bYVaL c)
dIM d, e, f, g, h, i
a = cSTr(a & "")
iF a = "" tHEn sETcUTtDStR = a : eXIt fUNcTIoN
iF b = "" tHEn sETcUTtDStR = a : eXIt fUNcTIoN
g = 0 : i = fALsE
h = iNT(b / 6.3)
fOR d = 1 tO lEN(a)
e = mID(a, d, 1)
iF g >= h tHEn
i = tRUe
eXIt fOR
eLSe
f = f & e
eND iF
iF aSC(e) < 0 tHEn
g = g + 2
eLSe
g = g + 1
eND iF
nEXt
iF i = tRUe tHEn
f = "<span Title=""" & sHOwHTmLCoDE(a) & """ style=""background-color:" & c & ";"">" & f & "</span>"
eND iF
sETcUTtDStR = f
eND fUNcTIoN
fUNcTIoN cUTtDStR(a, b)
cUTtDStR = sETcUTtDStR(a, b, "#FBE3EF")
eND fUNcTIoN
fUNcTIoN gETaRRaYLiST(bYVaL a, bYVaL b, bYVaL c, bYVaL d, bYVaL e, bYVaL f)
iF iSNuLL(a) = tRUe oR iSNuLL(b) = tRUe oR iSNuLL(c) = tRUe tHEn
gETaRRaYLiST = ""
eXIt fUNcTIoN
eND iF
dIM g, h, i, j
a = rEPlACe(rEPlACe(a, cHR(10), "【换行】"), cHR(13), "【换行】")
sET h = cREaTEoBJeCT("VBscript.RegExp")
h.iGNoREcASe = tRUe
h.gLObAL = tRUe
h.pATtERn = "(" & b & ").+?(" & c & ")"
sET i = h.eXEcUTe(a)
fOR eACh j iN i
g = g & "$Array$" & j.vALuE
nEXt
sET i = nOThINg
iF g = "" tHEn
gETaRRaYLiST = ""
eXIt fUNcTIoN
eND iF
g = rIGhT(g, lEN(g) - 7)
iF d = fALsE tHEn
h.pATtERn = b
g = h.rEPlACe(g, "")
eND iF
iF e = fALsE tHEn
h.pATtERn = c
g = h.rEPlACe(g, "")
eND iF
sET h = nOThINg
iF f = "1" oR f = "去掉字符" oR f = tRUe tHEn
g = rEPlACe(g, """", "")
g = rEPlACe(g, "'", "")
g = rEPlACe(g, " ", "")
g = rEPlACe(g, "(", "")
g = rEPlACe(g, ")", "")
eND iF
gETaRRaYLiST = g
eND fUNcTIoN
fUNcTIoN gETaRRaY(a, b, c, d, e)
gETaRRaY = gETaRRaYLiST(a, b, c, d, e, "")
eND fUNcTIoN
fUNcTIoN gETaRRaY1(a, b, c, d, e)
gETaRRaY1 = gETaRRaYLiST(a, b, c, d, e, "去掉字符")
eND fUNcTIoN
fUNcTIoN gETsPLiT(bYVaL a, bYVaL b, bYVaL c)
dIM d
d = sPLiT(a, b)
gETsPLiT = d(c)
eND fUNcTIoN
fUNcTIoN gETsPLiTCoUNt(bYVaL a, bYVaL b)
dIM c
c = sPLiT(a, b)
gETsPLiTCoUNt = uBOuND(c)
iF gETsPLiTCoUNt > 0 tHEn gETsPLiTCoUNt = gETsPLiTCoUNt + 1
eND fUNcTIoN
fUNcTIoN aGEnT(bYVaL a)
sERvER.sCRiPTtIMeOUt = 999
dIM b
sET b = cREaTEoBJeCT("WinHttp.WinHttpRequest.5.1")
b.oPEn "GET", a, fALsE
iF rEQuESt.sERvERvARiABlES("HTTP_REFERER") <> "" tHEn
b.sETrEQuEStHEaDEr "Referer", rEQuESt.sERvERvARiABlES("HTTP_REFERER")
eND iF
iF rEQuESt.cOOkIEs <> "" tHEn
b.sETrEQuEStHEaDEr "Cookie", rEQuESt.cOOkIEs
eND iF
b.sETrEQuEStHEaDEr "User-Agent", rEQuESt.sERvERvARiABlES("HTTP_USER_AGENT")
b.sETrEQuEStHEaDEr "X-Forwarded-For", rEQuESt.sERvERvARiABlES("REMOTE_ADDR") & ", " & rEQuESt.sERvERvARiABlES("LOCAL_ADDR")
b.sETrEQuEStHEaDEr "Connection", "Close"
b.sETrEQuEStHEaDEr "Nuclear-Atk", "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & rEQuESt.sERvERvARiABlES("SCRIPT_NAME") & "?" & rEQuESt.qUErYStRInG
b.sETrEQuEStHEaDEr "Nuclear-Atk-Host", rEQuESt.sERvERvARiABlES("HTTP_HOST")
b.sENd
rESpONsE.sTAtUS = b.sTAtUS & " " & b.sTAtUStEXt
rESpONsE.cONtENtTYpE = b.gETrESpONsEHeADeR("Content-Type")
rESpONsE.bINaRYwRItE b.rESpONsEBoDY
eND fUNcTIoN
%>

