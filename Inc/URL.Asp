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
fUNcTIoN gETtHIsURlNOpARaM()
dIM b
iF lCAsE(rEQuESt.sERvERvARiABlES("HTTPS")) = "off" tHEn
b = "http://"
eLSe
b = "https://"
eND iF
gETtHIsURlNOpARaM = b & rEQuESt.sERvERvARiABlES("HTTP_HOST") & rEQuESt.sERvERvARiABlES("SCRIPT_NAME")
eND fUNcTIoN
fUNcTIoN gETgOToURl()
gETgOToURl = rEQuESt.sERvERvARiABlES("HTTP_REFERER")
eND fUNcTIoN
fUNcTIoN gETgOToURlNOpARaM()
gETgOToURlNOpARaM = gETgOToURl()
iF iNStR(gETgOToURlNOpARaM, "?") > 0 tHEn
gETgOToURlNOpARaM = mID(gETgOToURlNOpARaM, 1, iNStR(gETgOToURlNOpARaM, "?") - 1)
eND iF
eND fUNcTIoN
fUNcTIoN gETgOToURlNOfILeNAmE()
gETgOToURlNOfILeNAmE = gETgOToURl()
iF rIGhT(gETgOToURlNOfILeNAmE, 1) <> "/" tHEn
iF iNStRReV(gETgOToURlNOfILeNAmE, "/") > 0 tHEn
gETgOToURlNOfILeNAmE = mID(gETgOToURlNOpARaM, 1, iNStRReV(gETgOToURlNOpARaM, "/"))
eND iF
eND iF
eND fUNcTIoN
fUNcTIoN gETiP2()
oN eRRoR rESuME nEXt
dIM b, c, d
b = rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR")
c = rEQuESt.sERvERvARiABlES("REMOTE_ADDR")
d = iIF(iSNuL(b) oR lCAsE(b) = "unknown", c, b)
iF iNStR(d, ".") = 0 tHEn d = "0.0.0.0"
gETiP2 = d
eND fUNcTIoN
fUNcTIoN gETiP()
oN eRRoR rESuME nEXt
dIM b
iF rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR") = "" oR iNStR(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), "unknown") > 0 tHEn
b = rEQuESt.sERvERvARiABlES("REMOTE_ADDR")
eLSeIF iNStR(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), ",") > 0 tHEn
b = mID(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), 1, iNStR(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), ",") - 1)
eLSeIF iNStR(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), ";") > 0 tHEn
b = mID(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), 1, iNStR(rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR"), ";") - 1)
eLSe
b = rEQuESt.sERvERvARiABlES("HTTP_X_FORWARDED_FOR")
eND iF
gETiP = tRIm(mID(b, 1, 30))
eND fUNcTIoN
fUNcTIoN gETsERvICeRIp()
gETsERvICeRIp = rEQuESt.sERvERvARiABlES("LOCAL_ADDR")
eND fUNcTIoN
fUNcTIoN gETrEMoTEiP()
gETrEMoTEiP = gETsERvICeRIp()
eND fUNcTIoN
fUNcTIoN hANdLEhTTpURl(a)
dIM b
iF iSNuL(a) tHEn eXIt fUNcTIoN
a = rEPlACe(tRIm(a), "\", "/")
b = mID(a, 1, iNStR(a, ":") + 2)
a = mID(a, iNStR(a, ":") + 3)
a = rEPlACe(a, "http://", "【|http|】")
a = rEPlACe(a, "https://", "【|https|】")
a = rEPlACe(a, "ftp://", "【|ftp|】")
wHIlE iNStR(a, "//") > 0
a = rEPlACe(a, "//", "/")
wENd
a = rEPlACe(a, "【|http|】", "http://")
a = rEPlACe(a, "【|https|】", "https://")
a = rEPlACe(a, "【|ftp|】", "ftp://")
hANdLEhTTpURl = b & a
eND fUNcTIoN
fUNcTIoN hANdLEfILeURl(a)
a = rEPlACe(a, "/", "\")
dIM b
fOR b = 1 tO 99
a = rEPlACe(a, "\\", "\")
iF iNStR(a, "\\") = fALsE tHEn
eXIt fOR
eND iF
nEXt
hANdLEfILeURl = a
eND fUNcTIoN
fUNcTIoN hANdLEuRLcOMpLEtE(a)
dIM b
hANdLEuRLcOMpLEtE = a
iF iNStR(a, "?") > 0 tHEn eXIt fUNcTIoN
iF rIGhT(a, 1) <> "/" tHEn
iF a & "/" = gETwEBsITe(a) tHEn
hANdLEuRLcOMpLEtE = a & "/"
eXIt fUNcTIoN
eND iF
eND iF
b = mID(a, iNStRReV(a, "/") + 1)
iF b <> "" aND iNStR(b, ".") = fALsE tHEn
hANdLEuRLcOMpLEtE = a & "/"
eND iF
eND fUNcTIoN
fUNcTIoN uRLaDDhTTpURl(a, b)
a = rEPlACe(a, "\", "/")
b = hANdLEhTTpURl(b)
iF iNStR(lCAsE(b), "http://") = 0 aND iNStR(lCAsE(b), "www.") = 0 tHEn
iF rIGhT(a, 1) = "/" aND lEFt(b, 1) = "/" tHEn
b = a & mID(b, 2)
eLSeIF rIGhT(a, 1) <> "/" aND lEFt(b, 1) <> "/" tHEn
b = a & "/" & b
eLSe
b = a & b
eND iF
eND iF
uRLaDDhTTpURl = b
eND fUNcTIoN
fUNcTIoN wEBdOMaIN()
dIM b, c
b = rEQuESt.sERvERvARiABlES("SERVER_PORT")
iF b <> 80 tHEn b = ":" & b eLSe b = ""
wEBdOMaIN = "http://" & rEQuESt.sERvERvARiABlES("SERVER_NAME") & b
eND fUNcTIoN
fUNcTIoN hOSt()
hOSt = "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & "/"
eND fUNcTIoN
fUNcTIoN hTTpHOsT()
hTTpHOsT = hOSt()
eND fUNcTIoN
fUNcTIoN gEThOSt()
gEThOSt = hOSt()
eND fUNcTIoN
fUNcTIoN gETuRL()
gETuRL = gETtHIsURl()
eND fUNcTIoN
fUNcTIoN gETtHIsURl()
dIM b, c
b = "http://" & rEQuESt.sERvERvARiABlES("server_name")
c = rEQuESt.sERvERvARiABlES("SERVER_PORT")
iF c <> 80 tHEn
b = b & ":" & c
eND iF
b = b & rEQuESt.sERvERvARiABlES("script_name")
iF rEQuESt.sERvERvARiABlES("QUERY_STRING") <> "" tHEn b = b & "?" & rEQuESt.sERvERvARiABlES("QUERY_STRING")
gETtHIsURl = b
eND fUNcTIoN
fUNcTIoN gETtHIsURlNOfILeNAmE()
dIM b
b = gETtHIsURl()
iF rIGhT(b, 1) <> "/" tHEn
iF iNStRReV(b, "/") > 0 tHEn
b = mID(b, 1, iNStRReV(b, "/"))
eND iF
eND iF
gETtHIsURlNOfILeNAmE = b
eND fUNcTIoN
fUNcTIoN gETwEBsITe(bYVaL a)
dIM b, c, d
c = a
b = tRIm(lCAsE(rEPlACe(a, "?", "/")))
b = rEPlACe(rEPlACe(b, "\", "/"), "http://", "")
iF iNStR(b, "/") > 0 tHEn b = mID(b, 1, iNStR(b, "/") - 1)
b = "http://" & b & "/"
dIM e, f, g
a = rEPlACe(lCAsE(a), "http://", "")
iF iNStR(a, "?") > 0 tHEn a = mID(a, 1, iNStR(a, "?") - 1)
iF lEFt(a, 9) = "localhost" tHEn
iF iNStR(a, "/") > 0 tHEn
a = mID(a, 1, iNStR(a, "/") - 1)
eLSe
a = "localhost"
eND iF
eLSeIF lEFt(a, 8) = "192.168." oR lEFt(a, 9) = "127.0.0.1" tHEn
a = a & "/"
a = "http://" & mID(a, 1, iNStR(a, "/") - 1) & "/"
gETwEBsITe = a : eXIt fUNcTIoN
eLSe
e = sPLiT(a, ".")
iF(iNStR(a, "www.") > 0 aND uBOuND(e) >= 2) oR uBOuND(e) >= 1 tHEn
iF iNStR(a, "/") > 0 tHEn
f = mID(a, 1, iNStR(a, "/") - 1)
iF f = gETdIAnNUmB(f) tHEn
a = f
eND iF
eND iF
eLSe
a = ""
eND iF
eND iF
d = fALsE
g = ".com.hk|.sh.cn|.com.cn|.net.cn|.org.cn"
g = g & "|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in"
e = sPLiT(g, "|")
fOR eACh f iN e
iF f <> "" tHEn
iF iNStR(a, f) > 0 tHEn
a = "http://" & lEFt(a, iNStR(a, f) + lEN(f) - 1) & "/" : d = tRUe : eXIt fOR
eND iF
eND iF
nEXt
gETwEBsITe = lEFt(a, 255)
iF gETwEBsITe = "http:///" tHEn gETwEBsITe = ""
iF d = fALsE tHEn
gETwEBsITe = ""
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKUrL(a)
cHEcKUrL = iIF(gETwEBsITe(a) = "", fALsE, tRUe)
eND fUNcTIoN
fUNcTIoN cHEcKHtTPuRL(a)
cHEcKHtTPuRL = cHEcKUrL(a)
eND fUNcTIoN
fUNcTIoN iSUrL(a)
iSUrL = cHEcKUrL(a)
eND fUNcTIoN
fUNcTIoN iSHtTPuRL(a)
iSHtTPuRL = cHEcKUrL(a)
eND fUNcTIoN
fUNcTIoN fULlHTtPUrL(bYVaL a, bYVaL b)
eRR.cLEaR
dIM c, d, e, f, g, h, i, j, k, l, m, n
a = pHPtRIm(a)
b = pHPtRIm(b)
iF b = "" tHEn fULlHTtPUrL = "" : eXIt fUNcTIoN
iF tRIm(a) = "" tHEn fULlHTtPUrL = b : eXIt fUNcTIoN
a = rEPlACe(a, "\", "/")
b = rEPlACe(b, "\", "/")
iF lEFt(b, 2) = "//" tHEn
fULlHTtPUrL = "http:" & b
eXIt fUNcTIoN
eND iF
c = gETwEBsITe(a)
l = c
m = gETwEBsITe(b)
iF rIGhT(c, 1) = "/" tHEn c = lEFt(c, lEN(c) - 1)
d = lEFt(a, iNStRReV(a, "/"))
e = sPLiT(a, "/")
fOR f = 0 tO uBOuND(e)
iF f + 1 = uBOuND(e) tHEn i = h
iF f + 2 = uBOuND(e) tHEn j = h
iF f + 3 = uBOuND(e) tHEn k = h
g = e(f)
h = h & g & "/"
nEXt
b = tRIm(b)
n = fALsE
iF b <> "" aND iNStR(lEFt(b, 10), "www.") = fALsE aND iNStR(lEFt(b, 10), "http://") = fALsE aND iNStR(lEFt(b, 10), "https://") = fALsE tHEn
n = tRUe
iF l <> m tHEn
iF l = rEPlACe(m, "http://", "http://www.") tHEn
n = fALsE
iF iNStR(lCAsE(b), "http://") > 0 tHEn
b = "http://www." & rIGhT(b, lEN(b) - 7)
eLSe
b = "http://www." & b
eND iF
eND iF
eND iF
eND iF
iF n = tRUe tHEn
iF lEFt(b, 1) = "/" tHEn
b = c & b
eLSeIF lEFt(b, 9) = "../../../" tHEn
b = k & rIGhT(b, lEN(b) - 9)
eLSeIF lEFt(b, 6) = "../../" tHEn
b = j & rIGhT(b, lEN(b) - 6)
eLSeIF lEFt(b, 3) = "../" tHEn
b = i & rIGhT(b, lEN(b) - 3)
eLSeIF lEFt(b, 2) = "./" tHEn
b = d & mID(b, 3)
eLSe
b = d & b
eND iF
eND iF
iF iNStR(lCAsE(a), "http://") > 0 aND iNStR(lCAsE(b), "http://") = 0 tHEn
b = "http://" & b
eLSeIF iNStR(lCAsE(a), "https://") > 0 aND iNStR(lCAsE(b), "https://") = 0 tHEn
b = "https://" & b
eND iF
fULlHTtPUrL = b
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "FullHttpUrl 获得域名 完整网址，HttpUrl=" & a & "<hr>Url=" & b
eND fUNcTIoN
fUNcTIoN bATcHFuLLhTTpURl(a, b)
dIM c, d, e
c = sPLiT(b, vBCrLF)
fOR eACh d iN c
iF lEN(d) > 3 tHEn
iF e <> "" tHEn e = e & vBCrLF
e = e & fULlHTtPUrL(a, d)
eND iF
nEXt
bATcHFuLLhTTpURl = e
eND fUNcTIoN
fUNcTIoN uRLjIAnJIeHAnDLe(bYVaL a)
a = rEPlACe(a, "&amp;", "&")
uRLjIAnJIeHAnDLe = a
eND fUNcTIoN
fUNcTIoN uRLtOAsC(a)
dIM b
fOR b = 1 tO lEN(a)
uRLtOAsC = uRLtOAsC & "%" & hEX(aSCw(mID(a, b, 1)))
nEXt
eND fUNcTIoN
fUNcTIoN gETwEBtITlE(a)
gETwEBtITlE = mYStRCuT(a, "<title>", "</title>", 0)
eND fUNcTIoN
fUNcTIoN mYStRCuT(a, b, c, d)
dIM e, f, g
e = lCAsE(a)
iF iNStR(e, b) > 0 aND iNStR(e, c) > 0 tHEn
f = iNStR(e, b) + lEN(b)
g = iNStR(e, c) - f
mYStRCuT = mID(a, f, g)
iF d = 1 oR d = 3 tHEn mYStRCuT = b & mYStRCuT
iF d = 2 oR d = 3 tHEn mYStRCuT = mYStRCuT & c
eND iF
eND fUNcTIoN
fUNcTIoN gETcONtENtAHrEF(a, b, c, d)
dIM e, f, g, h, i, j, k
fOR e = 1 tO lEN(b)
f = mID(b, e, 1)
iF f = "<" tHEn
g = lCAsE(mID(b, e))
h = lCAsE(mID(g, 1, iNStR(g, " ")))
iF h = "<a " tHEn
j = mID(g, 1, iNStR(g, "</") + 2)
i = lEN(j) - 1
k = k & hANdLElINk(a, j, "href", "", "url", c, d) & vBCrLF
e = e + i
eND iF
eND iF
dOEvENtS
nEXt
iF k <> "" tHEn k = lEFt(k, lEN(k) - 2)
gETcONtENtAHrEF = k
eND fUNcTIoN
fUNcTIoN gETcONtENtIMgSRc(a, b, c, d)
dIM e, f, g, h, i, j, k
fOR e = 1 tO lEN(b)
f = mID(b, e, 1)
iF f = "<" tHEn
g = lCAsE(mID(b, e))
h = lCAsE(mID(g, 1, iNStR(g, " ")))
iF h = "<img " tHEn
j = mID(g, 1, iNStR(g, ">"))
i = lEN(j) - 1
k = k & hANdLElINk(a, j, "src", "", "url", c, d) & vBCrLF
e = e + i
eND iF
eND iF
dOEvENtS
nEXt
iF k <> "" tHEn k = lEFt(k, lEN(k) - 2)
gETcONtENtIMgSRc = k
eND fUNcTIoN
fUNcTIoN hANdLEcONeNTuRL(a, b, c, d)
dIM e, f, g, h, i, j, k, l
fOR e = 1 tO lEN(b)
f = mID(b, e, 1)
iF f = "<" tHEn
g = mID(b, e)
h = lCAsE(g)
h = rEPlACe(rEPlACe(h, cHR(10), " " & vBCrLF), cHR(13), " " & vBCrLF)
k = mID(g, 1, iNStR(g, ">"))
i = lCAsE(mID(h, 1, iNStR(h, " ")))
iF i = "<link " tHEn
j = lEN(k) - 1
l = l & hANdLElINk(a, k, "href", "", "", c, d)
e = e + j
eLSeIF i = "<img " tHEn
j = lEN(k) - 1
l = l & hANdLElINk(a, k, "src", "", "", c, d)
e = e + j
eLSeIF i = "<a " tHEn
j = lEN(k) - 1
iF iNStR(lCAsE(k), "javascript:") = 0 tHEn
l = l & hANdLElINk(a, k, "href", "", "", c, d)
eLSe
l = l & k
eND iF
e = e + j
eLSeIF i = "<script " tHEn
j = lEN(k) - 1
iF iNStR(lCAsE(k), "src") > 0 tHEn
l = l & hANdLElINk(a, k, "src", "", "", c, d)
eLSe
l = l & k
eND iF
e = e + j
eLSeIF i = "<embed " tHEn
j = lEN(k) - 1
l = l & hANdLElINk(a, k, "src", "", "", c, d)
e = e + j
eLSeIF i = "<param " tHEn
j = lEN(k) - 1
iF iNStR(lCAsE(k), "movie") > 0 tHEn
l = l & hANdLElINk(a, k, "value", "", "", c, d)
eLSe
l = l & k
eND iF
e = e + j
eLSeIF i = "<meta " tHEn
j = lEN(k) - 1
iF iNStR(lCAsE(k), "keywords") > 0 tHEn
l = l & hANdLElINk(a, k, "content", wEBkEYwORdS, "", c, d)
eLSeIF iNStR(lCAsE(k), "description") > 0 tHEn
l = l & hANdLElINk(a, k, "content", wEBdEScRIpTIoN, "", c, d)
eLSe
l = l & k
eND iF
e = e + j
eLSe
l = l & f
eND iF
eLSe
l = l & f
eND iF
dOEvENtS
nEXt
hANdLEcONeNTuRL = l
eND fUNcTIoN
fUNcTIoN rEPlACeCOnTEnTJsDIr(a, b, c, d)
dIM e, f, g
e = sPLiT(a, vBCrLF)
fOR eACh f iN e
iF g <> "" tHEn g = g & vBCrLF
iF iNStR(f, "<script ") > 0 aND iNStR(f, "</script>") > 0 tHEn
f = hANdLElINk(b, f, "src", "", "replaceDir", c, d)
eND iF
g = g & f
nEXt
rEPlACeCOnTEnTJsDIr = g
eND fUNcTIoN
fUNcTIoN hANdLElINk(a, b, c, d, e, f, g)
oN eRRoR rESuME nEXt
dIM h, i, j, k, l, m, n, o, p, q, r, s
s = a
e = lCAsE(e)
b = rEPlACe(rEPlACe(b, "= ", "="), "= ", "=")
b = rEPlACe(rEPlACe(b, " =", "="), " =", "=")
l = lCAsE(b)
iF iNStR(l, " href=") = 0 aND iNStR(l, " src=") = 0 tHEn
hANdLElINk = ""
eXIt fUNcTIoN
eLSeIF iNStR(l, " href=\""") > 0 tHEn
b = rEPlACe(b, "\""", """") : l = lCAsE(b)
eND iF
o = c & "="""
p = """"
iF iNStR(l, o) > 0 aND iNStR(l, p) > 0 tHEn
m = sTRcUT(b, o, p, 2)
iF d <> "" tHEn
n = d
eLSe
n = fULlHTtPUrL(a, m)
iF e = "replacedir" tHEn
n = s & hANdLEfILePAtHArRAy(n)(2)
eND iF
f = f & n & vBCrLF
q = iNStR(b, ">")
r = rIGhT(b, lEN(b) - q)
r = mID(r, 1, iNStRReV(r, "</") - 1)
r = rEPlACe(r, vBCrLF, "【换行】")
g = g & r & vBCrLF
eND iF
iF m <> n tHEn
q = iNStR(b, o) - 1 + lEN(o)
r = rIGhT(b, lEN(b) - q)
r = mID(r, iNStR(r, p))
q = lEFt(b, q)
b = q & n & r
eND iF
iF e = "url" tHEn
hANdLElINk = n
eLSe
hANdLElINk = b
eND iF
eXIt fUNcTIoN
eND iF
o = c & "='"
p = "'"
iF iNStR(l, o) > 0 aND iNStR(l, p) > 0 tHEn
m = sTRcUT(l, o, p, 2)
iF d <> "" tHEn
n = d
eLSe
n = fULlHTtPUrL(a, m)
iF e = "replacedir" tHEn
n = s & hANdLEfILePAtHArRAy(n)(2)
eND iF
f = f & n & vBCrLF
q = iNStR(b, ">")
r = rIGhT(b, lEN(b) - q)
r = mID(r, 1, iNStRReV(r, "</") - 1)
r = rEPlACe(r, vBCrLF, "【换行】")
g = g & r & vBCrLF
eND iF
iF m <> n tHEn
q = iNStR(b, o) - 1 + lEN(o)
r = rIGhT(b, lEN(b) - q)
r = mID(r, iNStR(r, p))
q = lEFt(b, q)
b = q & n & r
eND iF
iF e = "url" tHEn
hANdLElINk = n
eLSe
hANdLElINk = b
eND iF
eXIt fUNcTIoN
eND iF
o = c & "="
p = " "
iF iNStR(l, o) > 0 aND iNStR(l, p) > 0 tHEn
m = sTRcUT(l, o, p, 2)
iF d <> "" tHEn
n = d
eLSe
n = fULlHTtPUrL(a, m)
iF e = "replacedir" tHEn
n = s & hANdLEfILePAtHArRAy(n)(2)
eND iF
f = f & n & vBCrLF
q = iNStR(b, ">")
r = rIGhT(b, lEN(b) - q)
r = mID(r, 1, iNStRReV(r, "</") - 1)
r = rEPlACe(r, vBCrLF, "【换行】")
g = g & r & vBCrLF
eND iF
iF m <> n tHEn
q = iNStR(b, o) - 1 + lEN(o)
r = rIGhT(b, lEN(b) - q)
r = mID(r, iNStR(r, p))
q = lEFt(b, q)
b = q & n & r
eND iF
iF e = "url" tHEn
hANdLElINk = n
eLSe
hANdLElINk = b
eND iF
eXIt fUNcTIoN
eND iF
iF e <> "url" tHEn hANdLElINk = b
cALl cREaTEaDDfILe("出错内容列表.txt", a & vBCrLF & b & vBCrLF & c & vBCrLF & d & vBCrLF & e & vBCrLF & "----------------------" & vBCrLF)
eND fUNcTIoN
fUNcTIoN gETeNDuRLhANdLEnAMe(a)
dIM b
b = rEPlACe(tRIm(a), "\", "/")
iF rIGhT(b, 1) = "/" tHEn b = mID(b, 1, lEN(b) - 1)
b = mID(b, iNStRReV(b, "/") + 1)
gETeNDuRLhANdLEnAMe = b
eND fUNcTIoN
fUNcTIoN gETwEBfOLdERnAMe()
iF gETiP = "127.0.0.1" oR iNStR(gETiP, "192.168.") > 0 tHEn
gETwEBfOLdERnAMe = "/wwwroot/" & wEBfOLdERnAMe & "/"
eND iF
eND fUNcTIoN
fUNcTIoN gETwEBhOMe()
dIM b
iF gETiP = "127.0.0.1" oR iNStR(gETiP, "192.168.") > 0 tHEn
cALl oPEnCOnN()
rS.oPEn "Select * From [WebSite]", cONn, 1, 1
iF nOT rS.eOF tHEn
gETwEBhOMe = "/wwwroot/" & gETeNDuRLhANdLEnAMe(rS("WebSkins")) & "/Index.html"
eND iF : rS.cLOsE
eND iF
iF gETwEBhOMe = "" tHEn
gETwEBhOMe = "/Index.html"
eND iF
eND fUNcTIoN
fUNcTIoN gETuRLlIStINwEBsITeLIsT(a)
dIM b, c, d
d = sPLiT(a, vBCrLF)
fOR eACh b iN d
b = gETwEBsITe(b)
iF b <> "" aND iNStR(vBCrLF & c & vBCrLF, vBCrLF & b & vBCrLF) = 0 tHEn
c = c & b & vBCrLF
eND iF
dOEvENtS
nEXt
gETuRLlIStINwEBsITeLIsT = c
eND fUNcTIoN
fUNcTIoN gETtHIsURlFIlENaME()
dIM b
b = rEQuESt.sERvERvARiABlES("SCRIPT_NAME")
iF lEFt(b, 1) = "/" tHEn b = rIGhT(b, lEN(b) - 1)
gETtHIsURlFIlENaME = b
eND fUNcTIoN
fUNcTIoN hANdLEwEBhTMlIMg(a, b, c, d)
dIM e, f, g, h
dIM i, j
e = gETcONtENtIMgSRc("", b, c, d)
f = sPLiT(e, vBCrLF)
fOR eACh g iN f
iF g <> "" tHEn
h = hANdLEhTTpURl(g)
iF iNStR(h, "/") > 0 tHEn
h = mID(h, iNStRReV(h, "/") + 1)
eND iF
h = a & h
i = "src=""" : j = """"
iF iNStR(b, i) > 0 aND iNStR(b, j) > 0 tHEn
b = rEGeXP_REpLAcE(b, i & g & j, i & h & j)
eND iF
i = "src='" : j = "'"
iF iNStR(b, i) > 0 aND iNStR(b, j) > 0 tHEn
b = rEGeXP_REpLAcE(b, i & g & j, i & h & j)
eND iF
eND iF
nEXt
hANdLEwEBhTMlIMg = b
eND fUNcTIoN
fUNcTIoN hANdLEwEBcSSiMG(a, b)
dIM c, d, e, f, g, h, i
c = "url\("
d = "\)"
e = gETaRRaY(b, c, d, fALsE, fALsE)
f = sPLiT(e, "$Array$")
fOR eACh h iN f
iF h <> "" tHEn
i = hANdLEhTTpURl(h)
iF iNStR(i, "/") > 0 tHEn
i = mID(i, iNStRReV(i, "/") + 1)
eND iF
i = a & i
c = "url("
d = ")"
iF iNStR(b, c) > 0 aND iNStR(b, d) > 0 tHEn
b = rEGeXP_REpLAcE(b, c & h & d, c & i & d)
eND iF
eND iF
nEXt
hANdLEwEBcSSiMG = b
eND fUNcTIoN
fUNcTIoN bATcHHaNDlEUrLInTEgRItY(a, b)
dIM c, d, e
c = sPLiT(b, vBCrLF)
fOR eACh d iN c
iF d <> "" tHEn
d = fULlHTtPUrL(a, d)
iF iNStR(vBCrLF & e & vBCrLF, vBCrLF & d & vBCrLF) = fALsE tHEn
e = e & d & vBCrLF
eND iF
eND iF
nEXt
bATcHHaNDlEUrLInTEgRItY = e
eND fUNcTIoN
fUNcTIoN rEPlACeCOnTEnTImAGePAtH(a, b)
dIM c, d, e, f
a = hANdLEhTTpURl(a)
iF rIGhT(a, 1) <> "/" tHEn a = a & "/"
e = gETdIRfILeNAmELiST(a)
f = sPLiT(e, vBCrLF)
fOR eACh c iN f
iF c <> "" tHEn
d = "file:///" & a & c
b = rEPlACe(b, """" & c & """", """" & d & """")
b = rEPlACe(b, "'" & c & "'", """" & d & """")
b = rEPlACe(b, "=" & c & " ", """" & d & """")
b = rEPlACe(b, "=" & c & ">", """" & d & """")
b = rEPlACe(b, "(" & c & ")", "(" & d & ")")
b = rEPlACe(b, "(" & c & ";", "(" & d & ";")
eND iF
nEXt
rEPlACeCOnTEnTImAGePAtH = b
eND fUNcTIoN
fUNcTIoN gETcSSlINkLIsT(bYVaL a)
dIM b, c, d, e, f, g
b = "<link" : c = "/>"
a = gETaRRaY(a, b, c, fALsE, fALsE)
d = sPLiT(a, "$Array$")
fOR eACh e iN d
iF iNStR(lCAsE(e), "stylesheet") > 0 tHEn
g = sTRcUT(e, "href=""", """", 2)
cALl eCHo(g, e)
f = f & g & vBCrLF
eND iF
nEXt
gETcSSlINkLIsT = f
eND fUNcTIoN
fUNcTIoN gEThTMlBAcKGrOUnDUrLLiST(a)
dIM b, c, d, e, f, g, h, i, j, k
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF c = "<" tHEn
d = mID(a, b)
e = lCAsE(d)
h = mID(d, 1, iNStR(d, ">"))
f = lCAsE(mID(e, 1, iNStR(e, " ")))
iF iNStR(h, "url(") > 0 tHEn
j = "url(" : k = ")"
i = i & sTRcUT(h, j, k, 2) & vBCrLF
b = b + g
eND iF
eND iF
dOEvENtS
nEXt
gEThTMlBAcKGrOUnDUrLLiST = i
eND fUNcTIoN
fUNcTIoN gETiMGuRLlISt(a)
dIM b, c, d, e, f, g, h, i
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF c = "<" tHEn
d = mID(a, b)
e = lCAsE(d)
h = mID(d, 1, iNStR(d, ">"))
f = lCAsE(mID(e, 1, iNStR(e, " ")))
iF f = "<img " tHEn
i = i & gETlINkURl(h, "src") & vBCrLF
b = b + g
eND iF
eND iF
dOEvENtS
nEXt
gETiMGuRLlISt = i
eND fUNcTIoN
fUNcTIoN gETlINkURl(bYVaL a, b)
dIM c, d, e, f
a = rEPlACe(rEPlACe(a, "= ", "="), "= ", "=")
a = rEPlACe(rEPlACe(a, " =", "="), " =", "=")
c = lCAsE(a)
d = b & "="""
e = """"
iF iNStR(c, d) > 0 aND iNStR(c, e) > 0 tHEn
f = sTRcUT(c, d, e, 2)
gETlINkURl = f
eND iF
eND fUNcTIoN
fUNcTIoN lOCaLUrLOrREmOTeURl(a, b)
dIM c
b = fALsE
a = tRIm(a)
c = rEPlACe(a, "\", "/")
iF lEFt(lCAsE(c), 7) = "http://" oR lEFt(lCAsE(c), 4) = "www." oR lEFt(lCAsE(c), 4) = "[网址]" tHEn
b = tRUe
eND iF
iF b = fALsE tHEn
a = sETfILeNAmE(a)
eND iF
lOCaLUrLOrREmOTeURl = a
eND fUNcTIoN
fUNcTIoN cHEcKReMOtEUrL(a)
dIM b
a = tRIm(a)
b = rEPlACe(uNSeTFiLEnAMe(a), "\", "/")
cHEcKReMOtEUrL = fALsE
iF lEFt(lCAsE(b), 7) = "http://" oR lEFt(lCAsE(b), 4) = "www." oR lEFt(lCAsE(b), 4) = "[网址]" tHEn
iF lEFt(lCAsE(b), 4) = "[网址]" tHEn
a = mID(a, iNStR(a, "[网址]") + 1)
eND iF
cHEcKReMOtEUrL = tRUe
eND iF
eND fUNcTIoN
fUNcTIoN gEThANdLEuRL(bYVaL a)
dIM b
a = cSTr(tRIm(a))
iF a <> "" tHEn
a = rEPlACe(tRIm(a), "\", "/")
iF iNStR(a, "://") = fALsE tHEn a = rEPlACe(rEPlACe(a, "//", "/"), "//", "/")
eND iF
iF lEFt(a, 1) <> "/" aND rIGhT(a, 1) <> "/" tHEn
a = "/Html/" & a & ".Html"
eLSeIF rIGhT(lCAsE(a), 4) <> ".html" tHEn
b = mID(a, iNStRReV(a, "/") + 1)
iF iNStR(b, ".") = fALsE tHEn
iF b <> "" tHEn
a = a & ".Html"
eND iF
eND iF
eND iF
gEThANdLEuRL = a
eND fUNcTIoN
fUNcTIoN wEBdEBuG(a, b)
iF rEQuESt.qUErYStRInG("Debug") <> "" tHEn
iF gETwEBsITe(b) <> "" tHEn
a = b
wEBdEBuG = a
eXIt fUNcTIoN
eLSe
a = "/Inc/Create_Html.Asp?Debug=1&" & b
eND iF
iF rEQuESt("MackHtml") = "False" tHEn
a = a & "&MackHtml=False"
eND iF
iF rEQuESt("gl") <> "" tHEn
a = a & "&gl=" & rEQuESt("gl")
eND iF
eLSe
iF cHEcKMaKEhTMlFIlE(a) = tRUe tHEn
a = lCAsE(a)
eND iF
eND iF
iF cHEcKMaKEhTMlFIlE(a) = tRUe tHEn
a = fULlHTtPUrL(hOSt(), a)
eLSe
a = tRIm(a)
iF lEFt(lCAsE(a), 4) = "url:" tHEn
a = mID(a, 5)
eND iF
iF lEFt(lCAsE(a), 5) = "/url:" tHEn
a = mID(a, 6)
eND iF
a = hANdLEtEMpLAtEAcTIoN(a, fALsE)
eND iF
wEBdEBuG = a
eND fUNcTIoN
fUNcTIoN aSAiLInKAdD(a)
dIM b
a = " " & a
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.iGNoREcASe = tRUe
b.gLObAL = tRUe
b.pATtERn = "(http://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?)"
a = b.rEPlACe(a, "<a href='$1' target='_blank'>$1</a>")
b.pATtERn = "([^(http:\/\/)])(www\.([\w-]+\.)+[\w]+(\/[\w-]+)*[\/]?([\w-]+\.[\w]+)?(\?[\w]+=[\w]+(&[\w]+=[\w]+)*)?)"
a = b.rEPlACe(a, "$1<a href='http://$2' target='_blank'>$2</a>")
b.pATtERn = "(mailto:)?([\w]+@([\w-]+\.)+[\w]+)"
a = b.rEPlACe(a, "<a href='mailto:$2'>$1$2</a>")
sET b = nOThINg
aSAiLInKAdD = rEPlACe(tRIm(a), " </a>", "")
aSAiLInKAdD = rEPlACe(tRIm(a), " ;</a>", "")
aSAiLInKAdD = rEPlACe(tRIm(a), " ；</a>", "")
eND fUNcTIoN
fUNcTIoN aSAiLInKDeL(a)
dIM b
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.iGNoREcASe = tRUe
b.gLObAL = tRUe
b.pATtERn = "<a[^>]+>(.+?)<\/a>"
aSAiLInKDeL = b.rEPlACe(a, "$1")
eND fUNcTIoN
fUNcTIoN iSWwW(a)
iSWwW = fALsE
dIM b, c
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.pATtERn = "^\w+((-\w+)|(\.\w+))*[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$"
b.iGNoREcASe = tRUe
sET c = b.eXEcUTe(a)
iF c.cOUnT tHEn iSWwW = tRUe
eND fUNcTIoN
fUNcTIoN gETuRLaDDtOPaRAm(bYVaL a, bYVaL b, c)
dIM d, e, f, g, h, i, j, k
dIM l
dIM m
dIM n
dIM o
dIM p
b = hANdLEhTTpURl(b)
a = tRIm(a)
iF rIGhT(a, 1) = "?" oR rIGhT(a, 1) = "&" tHEn
a = tRIm(mID(a, 1, lEN(a) - 1))
eND iF
b = tRIm(b)
iF lEFt(b, 1) = "?" oR lEFt(b, 1) = "&" tHEn
b = tRIm(mID(b, 2))
eND iF
iF a = "" tHEn gETuRLaDDtOPaRAm = "?" & b : eXIt fUNcTIoN
i = a
iF iNStR(a, "?") > 0 tHEn
i = mID(a, 1, iNStR(a, "?") - 1)
k = gETwEBsITe(a)
l = mID(a, iNStR(a, "?") + 1)
i = hANdLEhTTpURl(i)
iF rIGhT(i, 1) <> "/" tHEn
j = mID(i, iNStRReV(i, "/") + 1)
i = lEFt(i, lEN(i) - lEN(j))
eND iF
eND iF
iF lCAsE(c) = "replace" oR c = "替换" tHEn
d = b & "&" & l
iF iNStR(b, "?") > 0 tHEn
j = mID(b, 1, iNStR(b, "?") - 1)
eND iF
eLSeIF(lCAsE(c) <> "delete" oR lCAsE(c) <> "del") tHEn
d = l & "&" & b
eND iF
d = rEPlACe(d, "?", "&")
iF lCAsE(c) = "delete" oR lCAsE(c) = "del" tHEn
e = sPLiT(lCAsE(b), "&") : b = "&"
fOR eACh g iN e
iF iNStR(g, "=") tHEn
g = mID(g, 1, iNStR(g, "=") - 1)
eND iF
iF g <> "" tHEn
b = b & g & "&"
eND iF
nEXt
eND iF
e = sPLiT(d, "&")
fOR eACh g iN e
iF iNStR(g, "=") > 0 tHEn
f = sPLiT(g, "=")
m = f(0)
n = f(1)
p = tRUe
iF lCAsE(c) = "delete" oR lCAsE(c) = "del" tHEn
iF iNStR("&" & b & "&", "&" & lCAsE(m) & "&") > 0 tHEn
p = fALsE
eND iF
eND iF
iF iNStR("|" & o & "|", "|" & lCAsE(m) & "|") = fALsE aND p = tRUe tHEn
o = o & lCAsE(m) & "|"
h = h & iIF(h = "", "?", "&")
h = h & m & "=" & n
eND iF
eND iF
nEXt
h = j & h
iF gETwEBsITe(h) = "" tHEn
iF lEFt(b, 1) = "/" tHEn
h = k & h
eLSe
h = i & h
eND iF
eND iF
gETuRLaDDtOPaRAm = h
eND fUNcTIoN
fUNcTIoN gROuPUrL(a, b)
dIM c, d
c = "/"
a = rEPlACe(a, iIF(c = "/", "\", "/"), c)
b = rEPlACe(b, iIF(c = "/", "\", "/"), c)
a = pHPtRIm(a)
b = pHPtRIm(b)
fOR d = 0 tO 99
iF rIGhT(a, 1) = c tHEn
a = mID(a, 1, lEN(a) - 1)
eLSe
eXIt fOR
eND iF
nEXt
fOR d = 0 tO 99
iF lEFt(b, 1) = c tHEn
b = mID(b, 2)
eLSe
eXIt fOR
eND iF
nEXt
gROuPUrL = a & c & b
eND fUNcTIoN
fUNcTIoN hANdLEpOStCOoKIeSPaRAmE(a, b)
dIM c, d, e, f, g
c = sPLiT(a, "&")
fOR eACh d iN c
iF iNStR(d, "=") > 0 tHEn
f = mID(d, 1, iNStR(d, "="))
g = mID(d, iNStR(d, "=") + 1)
iF lCAsE(b) = "post" oR b = "" tHEn
iF e <> "" tHEn e = e & "&"
g = eSCaPE(g)
eLSeIF lCAsE(b) = "cookies" oR lCAsE(b) = "cookie" tHEn
iF e <> "" tHEn e = e & ";"
g = uRLeNCoDInG(g)
eND iF
e = e & f & g
eND iF
nEXt
hANdLEpOStCOoKIeSPaRAmE = e
eND fUNcTIoN
fUNcTIoN rEMoTEhTTpURlPArAMeTEr(a)
dIM b, c, d, e, f
iF iNStR(a, "?") = fALsE tHEn
rEMoTEhTTpURlPArAMeTEr = a
eXIt fUNcTIoN
eND iF
b = sPLiT(a, "&")
fOR eACh c iN b
iF iNStR(c, "=") > 0 tHEn
e = mID(c, 1, iNStR(c, "="))
f = mID(c, iNStR(c, "=") + 1)
iF d <> "" tHEn d = d & "&"
d = d & e
eND iF
nEXt
rEMoTEhTTpURlPArAMeTEr = d
eND fUNcTIoN
fUNcTIoN cHEcKUrLNaME(a)
dIM b, c, d
a = lCAsE(a)
d = lCAsE(rEQuESt.sERvERvARiABlES("script_name"))
b = sPLiT(a, "|")
fOR eACh c iN b
iF c <> "" tHEn
iF iNStR(d, c) > 0 tHEn
cHEcKUrLNaME = tRUe
eXIt fUNcTIoN
eND iF
eND iF
nEXt
cHEcKUrLNaME = fALsE
eND fUNcTIoN
fUNcTIoN hANdLEhTTpURlARrAY(bYVaL a)
dIM b, c, d, e, f, g, h
a = hANdLEhTTpURl(a)
b = mID(a, 1, iNStRReV(a, "/"))
e = mID(a, iNStRReV(a, "/") + 1) : c = e
iF iNStR(e, "?") > 0 tHEn
c = mID(e, 1, iNStR(e, "?") - 1)
eND iF
d = mID(c, iNStRReV(c, ".") + 1)
f = mID(a, 1, iNStR(a, ":") - 1)
g = gETwEBsITe(a)
h = mID(b, lEN(g))
dIM i
i = sPLiT(a & vBCrLF & b & vBCrLF & c & vBCrLF & d & vBCrLF & e & vBCrLF & f & vBCrLF & g & vBCrLF & h, vBCrLF)
hANdLEhTTpURlARrAY = i
eND fUNcTIoN
fUNcTIoN rEMoTEjSCsSPaRAm(a, b)
rEMoTEjSCsSPaRAm = hANdLErEMoTEjSCsSPaRAm(a, b, "|替换内容|替换网址")
eND fUNcTIoN
fUNcTIoN hANdLErEMoTEjSCsSPaRAm(a, b, c)
dIM d, e, f, g, h, i, j, k
c = "|" & c & "|"
d = sPLiT(b, vBCrLF)
fOR eACh f iN d
iF f <> "" tHEn
iF e <> "" tHEn e = e & vBCrLF
g = hANdLEhTTpURlARrAY(f)
h = g(2)
i = lCAsE(g(3))
j = lCAsE(g(4))
iF(i = "js" oR i = "css") aND iNStR(j, "?") > 0 tHEn
k = mID(f, 1, iNStR(f, "?") - 1)
iF iNStR(c, "|替换内容|") > 0 tHEn
a = rEPlACe(a, f, k)
eND iF
iF iNStR(c, "|替换网址|") > 0 tHEn
b = rEPlACe(b, f, k)
eND iF
eND iF
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN bATcHHaNDlEHtTPuRLcOMpLEtE(a, b)
dIM c, d, e, f, g
c = gETwEBsITe(a)
d = sPLiT(b, vBCrLF)
fOR eACh e iN d
e = pHPtRIm(e)
f = lCAsE(e)
iF f <> "#" aND lEFt(f, 11) <> "javascript:" tHEn
iF iNStR(vBCrLF & lCAsE(g) & vBCrLF, vBCrLF & f & vBCrLF) = fALsE tHEn
iF g <> "" tHEn g = g & vBCrLF
g = g & uRLaDDhTTpURl(c, e)
eND iF
eND iF
nEXt
bATcHHaNDlEHtTPuRLcOMpLEtE = g
eND fUNcTIoN
fUNcTIoN iSWeBSiTE(bYVaL a, bYVaL b)
iSWeBSiTE = hANdLEiSWeBSiTE(a, b, "")
eND fUNcTIoN
fUNcTIoN iSSoNWeBSiTE(bYVaL a, bYVaL b)
iSSoNWeBSiTE = hANdLEiSWeBSiTE(a, b, "子域名")
eND fUNcTIoN
fUNcTIoN hANdLEiSWeBSiTE(bYVaL a, bYVaL b, c)
a = gETwEBsITe(a)
b = gETwEBsITe(b)
iF iNStR(a, "://") > 0 tHEn
a = mID(a, iNStR(a, "://") + 3)
eND iF
iF lEFt(a, 4) = "www." tHEn
a = mID(a, 5)
eND iF
iF iNStR(b, "://") > 0 tHEn
b = mID(b, iNStR(b, "://") + 3)
eND iF
iF lEFt(b, 4) = "www." tHEn
b = mID(b, 5)
eND iF
iF c = "子域名" tHEn
dIM d, e, f
f = ".com.hk|.sh.cn|.com.cn|.net.cn|.org.cn"
f = f & "|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in"
d = sPLiT(f, "|")
fOR eACh e iN d
iF e <> "" tHEn
a = rEPlACe(a, e, "")
b = rEPlACe(b, e, "")
eND iF
nEXt
iF iNStR(a, ".") tHEn
a = mID(a, iNStR(a, ".") + 1)
eND iF
iF iNStR(b, ".") tHEn
b = mID(b, iNStR(b, ".") + 1)
eND iF
eND iF
hANdLEiSWeBSiTE = fALsE
iF a = b tHEn
hANdLEiSWeBSiTE = tRUe
eND iF
eND fUNcTIoN
fUNcTIoN gETcONtENtURlLIsT(a, bYVaL b)
gETcONtENtURlLIsT = hANdLEgETcONtENtURlLIsT(a, b, "|*|内链|")
eND fUNcTIoN
fUNcTIoN hANdLEgETcONtENtURlLIsT(a, bYVaL b, c)
dIM d, e, f, g, h, i, j, k, l, m, n, o, p, q
c = "|" & lCAsE(tRIm(c)) & "|"
n = gETwEBsITe(a)
fOR d = 1 tO lEN(b)
e = mID(b, d, 1)
f = mID(b & " ", d + 1, 1)
h = mID(b, d + 1) : g = lCAsE(h)
iF e = "<" tHEn
l = ""
o = ""
p = fALsE
iF lEFt(g, 2) = "a " tHEn
o = "a"
q = "href"
p = tRUe
eLSeIF lEFt(g, 5) = "link " tHEn
o = "link"
q = "href"
p = tRUe
eLSeIF lEFt(g, 4) = "img " tHEn
o = "img"
q = "src"
p = tRUe
eLSeIF lEFt(g, 7) = "script " tHEn
o = "script"
q = "src"
p = tRUe
eND iF
iF p = tRUe tHEn
iF iNStR(c, "|" & o & "|") > 0 oR iNStR(c, "|*|") > 0 tHEn
j = iNStR(h, ">")
i = mID(h, 1, j)
l = rPArAM(i, q)
d = d + j
eND iF
eND iF
iF l <> "" tHEn
m = lCAsE(l)
iF m <> "#" aND lEFt(m, 11) <> "javascript:" tHEn
iF iNStR(vBCrLF & k & vBCrLF, vBCrLF & l & vBCrLF) = fALsE tHEn
l = fULlHTtPUrL(a, l)
p = iSSoNWeBSiTE(l, a)
iF iNStR(c, "|内链|") > 0 tHEn
iF p = tRUe tHEn
k = k & l & vBCrLF
eND iF
eLSeIF iNStR(c, "|外链|") > 0 tHEn
iF p = fALsE tHEn
k = k & l & vBCrLF
eND iF
eLSe
k = k & l & vBCrLF
eND iF
eND iF
eND iF
eND iF
eND iF
nEXt
iF k <> "" tHEn k = lEFt(k, lEN(k) - 2)
hANdLEgETcONtENtURlLIsT = k
eND fUNcTIoN
fUNcTIoN gETiNChAIn(a, b)
dIM c, d, e, f, g
c = sPLiT(b, vBCrLF)
b = ""
fOR eACh d iN c
iF d <> "" tHEn
f = lCAsE(d)
iF lEFt(f, 1) <> "#" aND lEFt(f, 11) <> "javascript:" tHEn
iF iNStR(vBCrLF & b & vBCrLF, vBCrLF & d & vBCrLF) = fALsE tHEn
d = fULlHTtPUrL(a, d)
g = iSSoNWeBSiTE(d, a)
iF g = tRUe tHEn
b = b & d & vBCrLF
eND iF
eND iF
eND iF
eND iF
nEXt
iF b <> "" tHEn b = lEFt(b, lEN(b) - 2)
gETiNChAIn = b
eND fUNcTIoN
%>


