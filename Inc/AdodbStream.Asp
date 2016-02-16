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
fUNcTIoN cHEcKCoDE(bYVaL a)
cHEcKCoDE=gETfILeCHaRSeT(a)
eND fUNcTIoN
fUNcTIoN gETfILeCHaRSeT(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("ADODB.Stream")
b.tYPe = 1
b.mODe = 3
b.oPEn
b.pOSiTIoN = 0
cALl b.lOAdFRoMFiLE(a)
c = b.rEAd(2)
iF tYPeNAmE(c) = "Null" tHEn gETfILeCHaRSeT = "gb2312" : eXIt fUNcTIoN
iF aSCb(mIDb(c, 1, 1)) = &hEF aND aSCb(mIDb(c, 2, 1)) = &hBB tHEn
gETfILeCHaRSeT = "utf-8"
eLSeIF aSCb(mIDb(c, 1, 1)) = &hFF aND aSCb(mIDb(c, 2, 1)) = &hFE tHEn
gETfILeCHaRSeT = "unicode"
eLSe
gETfILeCHaRSeT = "gb2312"
eND iF
b.cLOsE
sET b = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "getFileCharset，获得文件编码 函数出错，FileName=" & a
eND fUNcTIoN
fUNcTIoN sENiORcHEcKCoDE(bYVaL a)
dIM b, c
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("ADODB.Stream")
b.tYPe = 1
b.mODe = 3
b.oPEn
b.pOSiTIoN = 0
cALl b.lOAdFRoMFiLE(a)
c = b.rEAd(2)
iF tYPeNAmE(c) = "Null" tHEn sENiORcHEcKCoDE = cHEcKFiLEcODe(a) : eXIt fUNcTIoN
iF aSCb(mIDb(c, 1, 1)) = &hEF aND aSCb(mIDb(c, 2, 1)) = &hBB tHEn
sENiORcHEcKCoDE = "UTF-8"
eLSeIF aSCb(mIDb(c, 1, 1)) = &hFF aND aSCb(mIDb(c, 2, 1)) = &hFE tHEn
sENiORcHEcKCoDE = "UNICODE"
eLSe
sENiORcHEcKCoDE = cHEcKFiLEcODe(a)
eND iF
b.cLOsE
sET b = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "CheckCode，获得文件编码 函数出错，FileName=" & a
eND fUNcTIoN
fUNcTIoN rEAdFIlE(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
iF b = "1" oR uCAsE(b) = "GB2312" tHEn
b = "GB2312"
eLSeIF b = "0" oR uCAsE(b) = "UTF-8" tHEn
b = "UTF-8"
eLSeIF b = "2" oR uCAsE(b) = "UNICODE" tHEn
b = "UNICODE"
eLSe
b = cHEcKCoDE(a)
iF b = "" tHEn eXIt fUNcTIoN
eND iF
dIM c, d, e, f
cALl hANdLEpATh(a)
iF cHEcKFiLE(a)=fALsE tHEn
rEAdFIlE=""
eXIt fUNcTIoN
eND iF
sET d = cREaTEoBJeCT("ADODB.Stream")
d.tYPe = 2
d.mODe = 3
d.cHArSEt = b
d.oPEn
sET f = cREaTEoBJeCT("Scripting.FileSystemObject")
sET e = f.gETfILe(a)
iF e.sIZe > 0 tHEn
cALl d.lOAdFRoMFiLE(a)
eND iF
c = d.rEAdTExT
d.cLOsE
sET d = nOThINg
rEAdFIlE = c
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "ReadFile，数据流读出内容 函数出错，FileName=" & a
sET f = nOThINg
sET d = nOThINg
eND fUNcTIoN
fUNcTIoN gETsTExT(a)
gETsTExT = rEAdFIlE(a, "")
eND fUNcTIoN
fUNcTIoN gETfTExTUtF(a)
gETfTExTUtF=rEAdFIlE(a,"utf-8")
eND fUNcTIoN
fUNcTIoN wRItEToFIlE(bYVaL a, bYVaL b, bYVaL c)
oN eRRoR rESuME nEXt
iF c = "1" oR uCAsE(c) = "GB2312" tHEn
c = "GB2312"
eLSeIF c = "0" oR uCAsE(c) = "UTF-8" tHEn
c = "UTF-8"
eLSeIF c = "2" oR uCAsE(c) = "UNICODE" tHEn
c = "UNICODE"
eLSe
c = "GB2312"
eND iF
dIM d
cALl hANdLEpATh(a)
sET d = cREaTEoBJeCT("ADODB.Stream")
d.tYPe = 2
d.mODe = 3
d.cHArSEt = c
d.oPEn
cALl d.wRItETeXT(b)
cALl d.sAVeTOfILe(a, 2)
d.fLUsH
d.cLOsE
wRItEToFIlE = a & "写入成功"
sET d = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "WriteToFile，数据流写入内容 函数出错，FileName=" & a & "，Content字符" & lEN(b)
eND fUNcTIoN
fUNcTIoN cREaTEfILeUTf(bYVaL a, bYVaL b)
cALl wRItEToFIlE(a,b,"utf-8")
eND fUNcTIoN
fUNcTIoN gETuGTeXT(bYVaL a)
dIM b, c, d
dIM e
b = cHEcKCoDE(a)
e = fALsE
iF b = "utf-8" tHEn
c = "gb2312"
eLSeIF b = "gb2312" tHEn
c = "utf-8"
eND iF
d = c
iF c <> "" tHEn
iF cHEcKStR(lCAsE(gETuGTeXT), "<meta [^>]*charset *= *" & c) = tRUe tHEn
gETuGTeXT = rEAdFIlE(a, d)
e = tRUe
eND iF
eND iF
iF e = fALsE tHEn
gETuGTeXT = rEAdFIlE(a, b)
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKCoNTeNTcHArSEt(bYVaL a, bYVaL b)
a = lCAsE(a)
b = lCAsE(b)
cHEcKCoNTeNTcHArSEt = tRUe
iF iNStR(a, "<meta ") > 0 tHEn
dIM c, d, e, f, g
fOR c = 1 tO lEN(a)
d = mID(a, c, 1)
iF d = "<" tHEn
e = lCAsE(mID(a, c))
f = lCAsE(mID(e, 1, iNStR(e, " ")))
iF f = "<meta " tHEn
g = mID(e, 1, iNStR(e, ">"))
iF iNStR(g, "charset") > 0 tHEn
iF iNStR(g, b) = 0 tHEn cHEcKCoNTeNTcHArSEt = fALsE
eND iF
eND iF
eND iF
nEXt
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKFiLEcODe(a)
dIM b, c, d, e, f, g, h
f = bINaRYrEAdFIlE(a)
iF lEN(f) > 2500 tHEn
f = rIGhT(f, 2500)
eND iF
h = lEN(f)
e = a & "_Temp"
b = sPLiT("GB2312|UTF-8|UNICODE", "|")
fOR eACh g iN b
d = rEAdFIlE(a, g)
cALl wRItEToFIlE(e, d, g)
c = bINaRYrEAdFIlE(e)
c = rIGhT(c, h)
iF f = c tHEn
cHEcKFiLEcODe = g
cALl dELeTEfILe(e)
eXIt fOR
eND iF
nEXt
cALl dELeTEfILe(e)
eND fUNcTIoN
fUNcTIoN gETfILeBInARyCOnTEnT(a)
dIM b
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("ADODB.Stream")
b.mODe = 3
b.tYPe = 1
b.oPEn
cALl b.lOAdFRoMFiLE(a)
gETfILeBInARyCOnTEnT = b.rEAd
b.cLOsE
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN bINaRYrEAdFIlE(a)
dIM b, c, d, e
cALl hANdLEpATh(a)
sET e = cREaTEoBJeCT("ADODB.Stream")
e.mODe = 3
e.tYPe = 1
e.oPEn
cALl e.lOAdFRoMFiLE(a)
d = "" : b = 0 : c = 1
wHIlE b < e.sIZe
d = d & aSCb(e.rEAd(c))
b = b + c
dOEvENtS
wENd
sET e = nOThINg
bINaRYrEAdFIlE = d
eND fUNcTIoN
fUNcTIoN rEAdBInARy(a, b)
dIM c, d, e, f
iF b = "" tHEn b = 0
cALl hANdLEpATh(a)
sET f = cREaTEoBJeCT("ADODB.Stream")
f.mODe = 3
f.tYPe = 1
f.oPEn
cALl f.lOAdFRoMFiLE(a)
e = "" : c = 0 : d = 1
wHIlE c < f.sIZe
e = e &(aSCb(f.rEAd(d)) + b) & "|"
c = c + d
wENd
iF e <> "" tHEn e = lEFt(e, lEN(e) - 1)
sET f = nOThINg
rEAdBInARy = e
eND fUNcTIoN
fUNcTIoN dECsAVeBInARy(a, b, c)
dIM d, bUF(), f
iF c = "" tHEn c = 0
d = sPLiT(b, "|")
rEDiM bUF(uBOuND(d))
fOR f = 0 tO uBOuND(d)
bUF(f) = cBYtE(cINt(d(f)) - c)
nEXt
cALl wRItEBiNArY(a, bUF)
eND fUNcTIoN
sUB wRItEBiNArY(a, b)
dIM c, d, e, f
cALl hANdLEpATh(a)
iF tYPeNAmE(b)<>"Byte()" tHEn
e = uBOuND(b) : rEDiM d(e \ 2)
fOR c = 0 tO e - 1 sTEp 2
d(c \ 2) = cHRw(b(c + 1) * 256 + b(c))
nEXt
iF c = e tHEn d(c \ 2) = cHRw(b(c))
d = jOIn(d, "")
eLSe	
d=b
eND iF
sET f = cREaTEoBJeCT("ADODB.Stream")
f.tYPe = 1
f.oPEn
wITh cREaTEoBJeCT("ADODB.Stream")
.tYPe = 2
.oPEn
cALl.wRItETeXT(d)
.pOSiTIoN = 2
cALl.cOPyTO(f)
.cLOsE
eND wITh
cALl f.sAVeTOfILe(a, 2)
f.cLOsE
sET f = nOThINg
eND sUB
pUBlIC fUNcTIoN gETfILeCHaRSeT2(bYVaL a)
dIM b
iF eRR tHEn
eRR.cLEaR
eND iF
cALl hANdLEpATh(a)
dIM c, d
sET c = cREaTEoBJeCT("ADODB.Stream")
wITh c
.tYPe = 1
.mODe = 3
.oPEn
.lOAdFRoMFiLE a
d =.rEAd(3)
.cLOsE
eND wITh
sET c = nOThINg
iF eRR.nUMbER <> 0 tHEn
eRR.cLEaR : gETfILeCHaRSeT2 = "" : eXIt fUNcTIoN
eND iF
b = bINtOHeX(d)
iF b = "EFBBBF" tHEn
gETfILeCHaRSeT2 = "UTF-8"
eLSe
b = lEFt(b, 4)
iF b = "FEFF" tHEn
gETfILeCHaRSeT2 = "UNICODE BIG"
eLSeIF b = "FFFE" tHEn
gETfILeCHaRSeT2 = "UNICODE"
eLSeIF b = "3C25" oR b = "3C21" tHEn
gETfILeCHaRSeT2 = "GB2312"
eLSe
gETfILeCHaRSeT2 = "GB2312"
eND iF
eND iF
iF eRR.nUMbER <> 0 tHEn
eRR.cLEaR : gETfILeCHaRSeT2 = "" : eXIt fUNcTIoN
eND iF
eND fUNcTIoN
pUBlIC fUNcTIoN bINtOHeX(bYVaL a)
dIM b, c
b = 0
fOR c = 1 tO lENb(a)
b = b * 256 + aSCb(mIDb(a, c, 1))
nEXt
bINtOHeX = hEX(b)
eND fUNcTIoN
fUNcTIoN bASe64eNCoDE(a)
dIM b,c
sET b=cREaTEoBJeCT("adodb.stream")
b.tYPe=2
b.cHArSEt="unicode"
b.mODe=3
cALl b.oPEn()
b.wRItETeXT a
b.pOSiTIoN=0
b.tYPe=1
sET c=cREaTEoBJeCT("msxml.domdocument")
cALl c.lOAdXMl("<root/>")
c.dOCuMEnTElEMeNT.dATaTYpE="bin.base64"
c.dOCuMEnTElEMeNT.nODeTYpEDvALuE=b.rEAd()
bASe64eNCoDE=c.dOCuMEnTElEMeNT.tEXt
eND fUNcTIoN
fUNcTIoN bASe64dECoDE(a)
dIM b
sET b=cREaTEoBJeCT("msxml.domdocument")
cALl b.lOAdXMl("<root/>")
b.dOCuMEnTElEMeNT.dATaTYpE="bin.base64"
b.dOCuMEnTElEMeNT.tEXt=a
bASe64dECoDE=b.dOCuMEnTElEMeNT.nODeTYpEDvALuE
eND fUNcTIoN
%>


