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
fUNcTIoN sAVeREmOTeFIlE(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
sAVeREmOTeFIlE = 0
dIM c, d, e
cALl hANdLEpATh(b)
sET d = cREaTEoBJeCT("Microsoft.XMLHTTP")
wITh d
.oPEn "Get", a, fALsE, "", ""
.sENd
iF eRR tHEn
sAVeREmOTeFIlE = 9999 : eXIt fUNcTIoN
eND iF
e =.rESpONsEBoDY
sAVeREmOTeFIlE =.sTAtUS
eND wITh
sET d = nOThINg
sET c = cREaTEoBJeCT("ADODB.Stream")
wITh c
.tYPe = 1
.oPEn
.wRItE e
.sAVeTOfILe b, 2
.cANcEL
.cLOsE
eND wITh
sET c = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "SaveRemoteFile 下载远程文件 函数出错，RemoteFileUrl=" & a & "<hr>LocalFileName=" & b
eND fUNcTIoN
fUNcTIoN dOWnFIlE(a, b)
dOWnFIlE = sAVeREmOTeFIlE(a, b)
eND fUNcTIoN
fUNcTIoN pOPuPDoWNfILe(a)
dIM b, c
cALl hANdLEpATh(a)
rESpONsE.cLEaR
sET b = cREaTEoBJeCT("ADODB.Stream")
b.oPEn
b.tYPe = 1
b.lOAdFRoMFiLE a
c = iNStRReV(a, "\") + 1
rESpONsE.aDDhEAdER "Content-Disposition", "attachment; filename=" & mID(a, c)
rESpONsE.aDDhEAdER "Content-Length", b.sIZe
rESpONsE.cHArSEt = "UTF-8"
rESpONsE.cONtENtTYpE = "application/octet-stream"
rESpONsE.bINaRYwRItE b.rEAd
rESpONsE.fLUsH
rESpONsE.wRItE("")
b.cLOsE
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN xMLgETsTAtUS(bYVaL a)
oN eRRoR rESuME nEXt
dIM b
sET b = cREaTEoBJeCT("Microsoft.XMLHTTP")
wITh b
.oPEn "Get", a, fALsE
.sETrEQuEStHEaDEr "cache-control", "no-cache"
.sETrEQuEStHEaDEr "Content-Type", "application/x-www-form-urlencoded"
.sENd
xMLgETsTAtUS =.sTAtUS
eND wITh
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN xMLpOSt(a, b)
xMLpOSt = hANdLExMLpOSt(a, b, "gb2312")(0)
eND fUNcTIoN
fUNcTIoN uTFxMLpOSt(a, b)
uTFxMLpOSt = hANdLExMLpOSt(a, b, "utf-8")(0)
eND fUNcTIoN
fUNcTIoN hANdLExMLpOSt(bYVaL a, bYVaL b, c)
dIM d, dATaARrAY(6), f
c = hANdLEsTRcHArSEt(c)
sET d = cREaTEoBJeCT("Microsoft.XMLHTTP")
cALl d.oPEn("POST", a, fALsE)
cALl d.sETrEQuEStHEaDEr("cache-control", "no-cache")
cALl d.sETrEQuEStHEaDEr("Content-Type", "application/x-www-form-urlencoded")
cALl d.sETrEQuEStHEaDEr("Connection", "close")
cALl d.sENd(b)
iF d.rEAdYStATe <> 4 tHEn
f = "error"
eLSe
f = bYTeSToBStR(d.rESpONsEBoDY, c)
eND iF
dATaARrAY(0) = f
dATaARrAY(1) = d.sTAtUS
dATaARrAY(2) = d.rESpONsEBoDY	
hANdLExMLpOSt = dATaARrAY
sET d = nOThINg
eND fUNcTIoN
fUNcTIoN xMLgET(bYVaL a)
xMLgET = hANdLExMLgET(a, "gb2312")(0)
eND fUNcTIoN
fUNcTIoN hANdLExMLgET(bYVaL a, b)
dIM c, dATaARrAY(1), e
b = hANdLEsTRcHArSEt(b)
sET c = cREaTEoBJeCT("Microsoft.XMLHTTP")
cALl c.oPEn("Get", a, fALsE)
cALl c.sETrEQuEStHEaDEr("cache-control", "no-cache")
cALl c.sETrEQuEStHEaDEr("Content-Type", "application/x-www-form-urlencoded")
cALl c.sETrEQuEStHEaDEr("Cookie", "Admin%5FPassWord=admin; Admin%5FUserName=admin; CNZZDATA5865366=cnzz_eid%3D1338721452-1438760869-%26ntime%3D1438760869; style=default; sswbr=1; Hm_lvt_c39492dd0d3beab26d196a53cbd72d54=1440725802,1442725700; BD_UPN=112451; ASPSESSIONIDSCDQDRAC=CNOHMAHANIPHOFLHKCIKFIGH")
cALl c.sENd
iF c.rEAdYStATe <> 4 tHEn
e = "error"
eLSe
e = bYTeSToBStR(c.rESpONsEBoDY, b)
eND iF
dATaARrAY(0) = e
dATaARrAY(1) = c.sTAtUS
sET c = nOThINg
iF eRR tHEn
dATaARrAY(0) = ""
dATaARrAY(1) = -1
eND iF
hANdLExMLgET = dATaARrAY
eND fUNcTIoN
fUNcTIoN cOOkIEsPOsT(a, b)
cOOkIEsPOsT = hANdLEcOOkIEsPOsT(a, b, "gb2312")
eND fUNcTIoN
fUNcTIoN hANdLEcOOkIEsPOsT(a, b, c)
dIM d, dATaARrAY(1), f
c = hANdLEsTRcHArSEt(c)
b = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;" & b
sET d = cREaTEoBJeCT("msxml2.serverXMLHTTP")
cALl d.oPEn("POST", a, fALsE)
cALl d.sETrEQuEStHEaDEr("Content-Type", "application/x-www-form-urlencoded")
cALl d.sETrEQuEStHEaDEr("Cookie", b)
cALl d.sENd
iF d.rEAdYStATe <> 4 tHEn
f = "error"
eLSe
f = bYTeSToBStR(d.rESpONsEBoDY, c)
eND iF
dATaARrAY(0) = f
dATaARrAY(1) = d.sTAtUS
sET d = nOThINg
hANdLEcOOkIEsPOsT = dATaARrAY
eND fUNcTIoN
fUNcTIoN gETrEMoTEfILeSIzE(a)
dIM b
sET b = cREaTEoBJeCT("MSXML2.XMLHTTP")
wITh b
.oPEn "get", a, fALsE
cALl .sETrEQuEStHEaDEr("range", "bytes=-1")
.sENd
gETrEMoTEfILeSIzE = sPLiT(.gETrESpONsEHeADeR("Content-Range"), "/")(1)
eND wITh
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN dOWnREmOTeFIlE(a)
dIM b, c
cALl hANdLEpATh(a)
rESpONsE.cLEaR
sET b = cREaTEoBJeCT("ADODB.Stream")
wITh b
.oPEn
.tYPe = 1
.lOAdFRoMFiLE a
c = iNStRReV(a, "\") + 1
rESpONsE.aDDhEAdER "Content-Disposition", "attachment; filename=" & mID(a, c)
rESpONsE.aDDhEAdER "Content-Length",.sIZe
rESpONsE.cHArSEt = "UTF-8"
rESpONsE.cONtENtTYpE = "application/octet-stream"
rESpONsE.bINaRYwRItE.rEAd
rESpONsE.fLUsH
rESpONsE.wRItE("")
.cLOsE
eND wITh
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN iMAgEStOBaSE64(a)
dIM b
dIM c
dIM d
dIM e
dIM f
dIM g
dIM h
dIM i
e = hANdLEpATh(a)
i = mID(e, iNStRReV(e, ".") + 1)
sET g = cREaTEoBJeCT("msxml2.FreeThreadedDOMDocument")
cALl g.lOAdXMl("<?xml version='1.0'?><Base64Data />")
sET d = cREaTEoBJeCT("Scripting.FileSystemObject")
iF d.fILeEXiSTs(e) tHEn
sET f = cREaTEoBJeCT("ADODB.Stream")
f.tYPe = 1
f.oPEn
cALl f.lOAdFRoMFiLE(e)
g.dOCuMEnTElEMeNT.dATaTYpE = "bin.base64"
g.dOCuMEnTElEMeNT.nODeTYpEDvALuE = f.rEAd
sET b = cREaTEoBJeCT("msxml2.FreeThreadedDOMDocument")
cALl b.lOAd(g)
iF b.rEAdYStATe > 2 tHEn
sET c = b.gETeLEmENtSByTAgNAmE("Base64Data")
h = c.iTEm(0).tEXt
eLSe
h = ""
eND iF
sET b = nOThINg
sET f = nOThINg
eLSe
h = ""
eND iF
sET d = nOThINg
sET g = nOThINg
iMAgEStOBaSE64 = h
eND fUNcTIoN
fUNcTIoN bASe64tOImAGeS(a, b)
dIM c
a = hANdLEpATh(a)
c = "<data>" & b & "</data>"
dIM d : sET d = cREaTEoBJeCT("MSXML2.DOMDocument")
dIM e : sET e = cREaTEoBJeCT("ADODB.Stream")
d.rESoLVeEXtERnALs = fALsE
cALl d.lOAdXMl(c)
cALl d.dOCuMEnTElEMeNT.sETaTTrIBuTE("xmlns:dt", "urn:schemas-microsoft-com:datatypes")
d.dOCuMEnTElEMeNT.dATaTYpE = "bin.base64"
e.tYPe = 1
e.oPEn
cALl e.wRItE(d.dOCuMEnTElEMeNT.nODeTYpEDvALuE)
cALl e.sAVeTOfILe(a)
e.cLOsE
sET d = nOThINg
sET e = nOThINg
eND fUNcTIoN
fUNcTIoN gETsQLiNCoNTeNT(a, b, c, d)
gETsQLiNCoNTeNT = hANdLEsQLiN(a, b, c, d, "gb2312")(0)
eND fUNcTIoN
fUNcTIoN hANdLEsQLiN(a, b, c, d, e)
dIM f, dATaARrAY	
c = lCAsE(c)
iF c = "post" tHEn
dATaARrAY = hANdLExMLpOSt(a, hANdLEpOStCOoKIeSPaRAmE(b, "post"), e)
eLSeIF c = "get" tHEn
b = hANdLUrLCaNShU(b)
dATaARrAY = hANdLExMLgET(a & b, e)
eLSeIF c = "cookies" tHEn
dATaARrAY = hANdLEcOOkIEsPOsT(a, hANdLEpOStCOoKIeSPaRAmE(b, "cookies"), e)
eND iF
iF cSTr(d) = "0" tHEn
dATaARrAY(0) = rEPlACe(dATaARrAY(0), "<", "&lt;")
eLSeIF cSTr(d) = "1" tHEn
dATaARrAY(0) = rEPlACe(dATaARrAY(0), "<br>", vBCrLF)
dATaARrAY(0) = dELhTMl(dATaARrAY(0))
eND iF
hANdLEsQLiN = dATaARrAY
eND fUNcTIoN
fUNcTIoN sQLiNUrL(bYVaL a)
dIM b, c, d
sQLiNUrL = fALsE
c = fALsE : d = fALsE
sET b = cREaTEoBJeCT("Microsoft.XMLHTTP")
wITh b
.oPEn "GET", a, fALsE
.sENd
iF b.sTAtUS <> 200 tHEn
eXIt fUNcTIoN
eND iF
cALl .oPEn("GET", a & " And 1=1", fALsE)
.sENd
c = .sTAtUS
cALl.oPEn("GET", a & " And 1=2", fALsE)
.sENd ""
d = .sTAtUS
eND wITh
sET b=nOThINg
iF c = 200 aND d = 500 tHEn sQLiNUrL = tRUe
eND fUNcTIoN
fUNcTIoN hANdLUrLCaNShU(a)
dIM b, c, d, e, f, g
c = sPLiT(a, "=")
fOR d = 0 tO uBOuND(c)
e = c(d)
iF b <> "" tHEn b = b & "="
iF iNStR(e, "&") tHEn
f = mID(e, 1, iNStR(e, "&") - 1)
g = mID(e, iNStR(e, "&"))
e = eSCaPE(f) & g
eLSeIF d = uBOuND(c) tHEn
e = eSCaPE(e)
eND iF
b = b & e
nEXt
hANdLUrLCaNShU = b
eND fUNcTIoN
fUNcTIoN hANdLEsTRcHArSEt(a)
iF a = "1" oR uCAsE(a) = "GB2312" oR a = "" tHEn
a = "GB2312"
eLSeIF a = "0" oR uCAsE(a) = "UTF-8" tHEn
a = "UTF-8"
eLSeIF a = "2" oR uCAsE(a) = "UNICODE" tHEn
a = "UNICODE"
eND iF
hANdLEsTRcHArSEt = a
eND fUNcTIoN
fUNcTIoN uRLeNCoDInG(a)
a = rEPlACe(a, "1", "%31")
a = rEPlACe(a, "0", "%30")
a = rEPlACe(a, "A", "%41")
a = rEPlACe(a, "我", "%CE%D2")
a = rEPlACe(a, "#", "%23")
a = rEPlACe(a, "a", "%61")
a = rEPlACe(a, "n", "%6E")
a = rEPlACe(a, "d", "%64")
a = rEPlACe(a, " ", "%20")
a = rEPlACe(a, "=", "%3D")
a = rEPlACe(a, "e", "%65")
a = rEPlACe(a, "x", "%78")
a = rEPlACe(a, "i", "%69")
a = rEPlACe(a, "s", "%73")
a = rEPlACe(a, "t", "%74")
a = rEPlACe(a, "(", "%28")
a = rEPlACe(a, ")", "%29")
a = rEPlACe(a, "l", "%6C")
a = rEPlACe(a, "c", "%63")
a = rEPlACe(a, "*", "%2A")
a = rEPlACe(a, "f", "%66")
a = rEPlACe(a, "r", "%72")
a = rEPlACe(a, "o", "%6F")
a = rEPlACe(a, "m", "%6D")
a = rEPlACe(a, "w", "%77")
a = rEPlACe(a, "h", "%68")
uRLeNCoDInG = a
eND fUNcTIoN
fUNcTIoN gETwINhTTp(a, b, c, d, e)
dIM f, g
sET f = cREaTEoBJeCT("WinHttp.WinHttpRequest.5.1")
wITh f
iF b = "" tHEn
b = gETwEBsITe(a)
eND iF
iF c = "" tHEn
c = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;"
eND iF
e = tRIm(e)
iF e = "" oR e = "1" oR e = "gb2312" tHEn
e = "gb2312"
eLSe
e = "utf-8"
eND iF
.sETtIMeOUtS 60000, 60000, 60000, 3000
.oPTiON(4) = 13056
.oPTiON(6) = fALsE
.oPEn "GET", a, fALsE
.sETrEQuEStHEaDEr "Accept", "*/*"
.sETrEQuEStHEaDEr "Accept-Language", "zh-cn,zh"
.sETrEQuEStHEaDEr "User-Agent", "Mozilla/6.0"
.sETrEQuEStHEaDEr "Content-Type", "application/x-www-form-urlencoded"
.sETrEQuEStHEaDEr "Referer", b
.sETrEQuEStHEaDEr "Connection", "Close"
.sETrEQuEStHEaDEr "Cookie", c
d = hANdLEpOStCOoKIeSPaRAmE(d, "post")
.sENd(d)
.wAItFOrREsPOnSE
g = bYTeSToBStR(.rESpONsEBoDY, e)
eND wITh
gETwINhTTp = g
eND fUNcTIoN
%>   
