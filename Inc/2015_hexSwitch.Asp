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
fUNcTIoN sTRtOHeX(bYVaL a)
dIM b, c
fOR b = 1 tO lEN(a)
c = c & hEX(aSC(mID(a, b, 1)))
nEXt
sTRtOHeX = c
eND fUNcTIoN
fUNcTIoN hEXtOStR(bYVaL a)
dIM b, c
fOR b = 1 tO lEN(a) sTEp 2
c = mID(a, b, 2)
iF c="DA" tHEn
hEXtOStR=hEXtOStR & vBCrLF
eLSe
iF iSNuMErIC(mID(a, b, 1)) tHEn
hEXtOStR=hEXtOStR & cHR("&H" & c)
eLSe
hEXtOStR=hEXtOStR & cHR("&H" & c & mID(a, b + 2, 2))
b = b + 2
eND iF
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN bD(a)
bD=hEXtOStR(a)
eND fUNcTIoN
fUNcTIoN c2To16(a)
dIM b
b = 1
fOR b = 1 tO lEN(a) sTEp 4
c2To16 = c2To16 & hEX(c2To10(mID(a, b, 4)))
nEXt
eND fUNcTIoN
fUNcTIoN c2To10(a)
dIM b
c2To10 = 0
iF a = "0" tHEn eXIt fUNcTIoN
b = 0
fOR b = 0 tO lEN(a) - 1
iF mID(a, lEN(a) - b, 1) = "1" tHEn c2To10 = c2To10 + 2 ^(b)
nEXt
eND fUNcTIoN
fUNcTIoN c16tO2(a)
dIM b, c
b = 0
fOR b = 1 tO lEN(tRIm(a))
c = c10tO2(cINt(iNT("&h" & mID(a, b, 1))))
dO wHIlE lEN(c) < 4
c = "0" & c
lOOp
c16tO2 = c16tO2 & c
nEXt
eND fUNcTIoN
fUNcTIoN c10tO2(a)
dIM b, c, d, e
b = sGN(a)
a = aBS(a)
c = 1
dO
iF a < 2 ^ c tHEn
eXIt dO
eLSe
c = c + 1
eND iF
lOOp
d = a
e = 0
fOR e = c tO 1 sTEp - 1
iF d >= 2 ^(e - 1) tHEn
d = d - 2 ^(e - 1)
c10tO2 = c10tO2 & "1"
eLSe
c10tO2 = c10tO2 & "0"
eND iF
nEXt
iF b = -1 tHEn c10tO2 = "-" & c10tO2
eND fUNcTIoN
fUNcTIoN sTR2BIn(a)
dIM b, c, d, e, f
sTR2BIn = ""
fOR b = 1 tO lEN(a)
d = mID(a, b, 1)
c = aSC(d)
iF c < 0 tHEn
c = c + 65535
eND iF
iF c > 255 tHEn
e = lEFt(hEX(aSC(d)), 2)
f = rIGhT(hEX(aSC(d)), 2)
sTR2BIn = sTR2BIn & cHRb("&H" & e) & cHRb("&H" & f)
eLSe
sTR2BIn = sTR2BIn & cHRb(aSCb(d))
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN bYTeS2bSTr(a)
dIM b
dIM c, d, e
b = ""
fOR c = 1 tO lENb(a)
d = aSCb(mIDb(a, c, 1))
iF d < &h80 tHEn
b = b & cHR(d)
eLSe
e = aSCb(mIDb(a, c + 1, 1))
b = b & cHR(cLNg(d) * &h100 + cINt(e))
c = c + 1
eND iF
nEXt
bYTeS2bSTr = b
eND fUNcTIoN
%>

