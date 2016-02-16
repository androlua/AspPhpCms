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
fUNcTIoN uTF2GB(bYVaL a)
dIM b, c
fOR b = 1 tO lEN(a)
iF mID(a, b, 1) = "%" tHEn
iF lEN(a) >= b + 8 tHEn
c = c & cONvCHiNEsE(mID(a, b, 9))
b = b + 8
eLSe
c = c & mID(a, b, 1)
eND iF
eLSe
c = c & mID(a, b, 1)
eND iF
nEXt
uTF2GB = c
eND fUNcTIoN
fUNcTIoN cHEcKUtFToGB2312(bYVaL a)
dIM b, c
cHEcKUtFToGB2312 = tRUe
fOR b = 1 tO lEN(a)
iF mID(a, b, 1) = "%" tHEn
iF lEN(a) >= b + 8 tHEn
iF cONvCHiNEsE(mID(a, b, 9)) = "[出错Error]" tHEn
cHEcKUtFToGB2312 = fALsE : eXIt fUNcTIoN
eND iF
b = b + 8
eLSe
c = c & mID(a, b, 1)
eND iF
eLSe
c = c & mID(a, b, 1)
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN cONvCHiNEsE(a)
oN eRRoR rESuME nEXt
eRR.cLEaR
dIM b, c, d, e, f
b = sPLiT(mID(a, 2), "%")
c = 0
d = 0
fOR c = 0 tO uBOuND(b)
b(c) = c16tO2(b(c))
nEXt
fOR c = 0 tO uBOuND(b) - 1
e = iNStR(b(c), "0")
f = ""
fOR d = 1 tO e - 1
iF d = 1 tHEn
b(c) = rIGhT(b(c), lEN(b(c)) - e)
f = f & b(c)
eLSe
c = c + 1
b(c) = rIGhT(b(c), lEN(b(c)) - 2)
f = f & b(c)
eND iF
nEXt
iF lEN(c2To16(f)) = 4 tHEn
cONvCHiNEsE = cONvCHiNEsE & cHRw(iNT("&H" & c2To16(f)))
eLSe
cONvCHiNEsE = cONvCHiNEsE & cHR(iNT("&H" & c2To16(f)))
eND iF
iF eRR <> 0 tHEn cONvCHiNEsE = "[出错Error]" : eXIt fUNcTIoN
nEXt
eND fUNcTIoN
fUNcTIoN uTF8_UrLEnCOdINg(a)
dIM b, c, d
dIM e
dIM f
iF a = "" tHEn
uTF8_UrLEnCOdINg = a
eXIt fUNcTIoN
eND iF
fOR e = 1 tO lEN(a)
b = mID(a, e, 1)
f = aSCw(b)
iF f < 0 tHEn f = f + 65536
iF(f aND &hFF80) = 0 tHEn
d = d & b
eLSe
iF(f aND &hF000) = 0 tHEn
c = "%" & hEX(((f \ 2 ^ 6)) oR &hC0) & hEX(f aND &h3F oR &h80)
d = d & c
eLSe
c = "%" & hEX((f \ 2 ^ 12) oR &hE0) & "%" & _
hEX((f \ 2 ^ 6) aND &h3F oR &h80) & "%" & _
hEX(f aND &h3F oR &h80)
d = d & c
eND iF
eND iF
nEXt
uTF8_UrLEnCOdINg = d
eND fUNcTIoN
fUNcTIoN tOUtF8(a)
dIM b, c, d
dIM e
dIM f
iF a = "" tHEn
tOUtF8 = a
eXIt fUNcTIoN
eND iF
fOR e = 1 tO lEN(a)
b = mID(a, e, 1)
f = aSCw(b)
iF f < 0 tHEn f = f + 65536
iF(f aND &hFF80) = 0 tHEn
d = d & b
eLSe
iF(f aND &hF000) = 0 tHEn
c = "%" & hEX(((f / 2 ^ 6)) oR &hC0) & hEX(f aND &h3F oR &h80)
d = d & c
eLSe
c = "%" & hEX((f / 2 ^ 12) oR &hE0) & "%" & _
hEX((f / 2 ^ 6) aND &h3F oR &h80) & "%" & _
hEX(f aND &h3F oR &h80)
d = d & c
eND iF
eND iF
nEXt
tOUtF8 = d
eND fUNcTIoN
fUNcTIoN cHInESe2UnICoDE(a)
dIM b
dIM c
dIM d
iF(iSNuLL(a)) tHEn
eXIt fUNcTIoN
eND iF
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
d = d & cHR(38)
d = d & cHR(35)
d = d & cHR(120)
d = d & hEX(aSCw(c))
d = d & cHR(59)
nEXt
cHInESe2UnICoDE = d
eND fUNcTIoN
fUNcTIoN iSVaLIdHEx(a)
dIM b
iSVaLIdHEx = tRUe
a = uCAsE(a)
iF lEN(a) <> 3 tHEn iSVaLIdHEx = fALsE : eXIt fUNcTIoN
iF lEFt(a, 1) <> "%" tHEn iSVaLIdHEx = fALsE : eXIt fUNcTIoN
b = mID(a, 2, 1)
iF nOT(((b >= "0") aND(b <= "9")) oR((b >= "A") aND(b <= "Z"))) tHEn iSVaLIdHEx = fALsE : eXIt fUNcTIoN
b = mID(a, 3, 1)
iF nOT(((b >= "0") aND(b <= "9")) oR((b >= "A") aND(b <= "Z"))) tHEn iSVaLIdHEx = fALsE : eXIt fUNcTIoN
eND fUNcTIoN
fUNcTIoN eSCaPE(a)
dIM b, c, d, e
c = ""
fOR b = 1 tO lEN(a)
d = mID(a, b, 1)
e = aSCw(d)
iF(e >= 48 aND e <= 57) oR(e >= 65 aND e <= 90) oR(e >= 97 aND e <= 122) tHEn
c = c & d
eLSeIF iNStR("@*_-./", d) > 0 tHEn
c = c & d
eLSeIF e > 0 aND e < 16 tHEn
c = c & "%0" & hEX(e)
eLSeIF e >= 16 aND e < 256 tHEn
c = c & "%" & hEX(e)
eLSe
c = c & "%u" & hEX(e)
eND iF
nEXt
eSCaPE = c
eND fUNcTIoN
fUNcTIoN uNEsCApE(a)
dIM b, c, d, e, f, g, h
e = fALsE
f = ""
c = ""
fOR b = 1 tO lEN(a)
d = mID(a, b, 1)
iF d = "+" tHEn
c = c & " "
eLSeIF mID(a, b, 2) = "%u" aND b <= lEN(a) - 5 tHEn
iF iSNuMErIC("&H" & mID(a, b + 2, 4)) tHEn
c = c & cHRw(cINt("&H" & mID(a, b + 2, 4)))
b = b + 5
eLSe
c = c & d
eND iF
eLSeIF d = "%" aND b <= lEN(a) - 2 tHEn
g = mID(a, b + 1, 2)
iF iSNuMErIC("&H" & g) tHEn
h = cINt("&H" & g)
iF e = tRUe tHEn
e = fALsE
c = c & cHR(cINt("&H" & f & g))
eLSe
iF aBS(h) <= 127 tHEn
c = c & cHR(h)
eLSe
e = tRUe
f = g
eND iF
eND iF
b = b + 2
eLSe
c = c & d
eND iF
eLSe
c = c & d
eND iF
nEXt
uNEsCApE = c
eND fUNcTIoN
fUNcTIoN cHInESeTOuNIcODe(a)
dIM b, c, d
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
c = "&#x" & hEX(aSCw(c)) & ";"
d = d & c
nEXt
cHInESeTOuNIcODe = d
eND fUNcTIoN
fUNcTIoN uNIcODeTOcHInESe(a)
dIM b, c, d
b = sPLiT(a, ";")
fOR eACh c iN b
iF iNStR(c, "&#x") > 0 tHEn
c = rIGhT(c, lEN(c) - 3)
d = d & cHRw(cINt("&H" & c))
eND iF
nEXt
uNIcODeTOcHInESe = d
eND fUNcTIoN
fUNcTIoN uRLeNCoDE(bYReF a)
dIM b
dIM c
fOR b = 1 tO lEN(a)
iF aSC(mID(a, b, 1)) < 0 tHEn
c = "%" & rIGhT(cSTr(hEX(aSC(mID(a, b, 1)))), 2)
c = "%" & lEFt(cSTr(hEX(aSC(mID(a, b, 1)))), lEN(cSTr(hEX(aSC(mID(a, b, 1))))) - 2) & c
uRLeNCoDE = uRLeNCoDE & c
eLSeIF(aSC(mID(a, b, 1)) >= 65 aND aSC(mID(a, b, 1)) <= 90) oR(aSC(mID(a, b, 1)) >= 97 aND aSC(mID(a, b, 1)) <= 122) tHEn
uRLeNCoDE = uRLeNCoDE & mID(a, b, 1)
eLSe
uRLeNCoDE = uRLeNCoDE & "%" & hEX(aSC(mID(a, b, 1)))
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN uRLdECoDE(bYReF a)
dIM b
iF iNStR(a, "%") = 0 tHEn uRLdECoDE = a : eXIt fUNcTIoN
fOR b = 1 tO lEN(a)
iF mID(a, b, 1) = "%" tHEn
iF vAL("&H" & mID(a, b + 1, 2)) > 127 tHEn
uRLdECoDE = uRLdECoDE & cHR(vAL("&H" & mID(a, b + 1, 2) & mID(a, b + 4, 2)))
b = b + 5
eLSe
uRLdECoDE = uRLdECoDE & cHR(vAL("&H" & mID(a, b + 1, 2)))
b = b + 2
eND iF
eLSe
uRLdECoDE = uRLdECoDE & mID(a, b, 1)
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN gBToUTf8(a)
dIM b, c, d
dIM e
dIM f
iF a = "" tHEn
gBToUTf8 = a
eXIt fUNcTIoN
eND iF
fOR e = 1 tO lEN(a)
b = mID(a, e, 1)
f = aSCw(b)
iF f < 0 tHEn f = f + 65536
iF(f aND &hFF80) = 0 tHEn
d = d & b
eLSe
iF(f aND &hF000) = 0 tHEn
c = "%" & hEX(((f \ 2 ^ 6)) oR &hC0) & hEX(f aND &h3F oR &h80)
d = d & c
eLSe
c = "%" & hEX((f \ 2 ^ 12) oR &hE0) & "%" & _
hEX((f \ 2 ^ 6) aND &h3F oR &h80) & "%" & _
hEX(f aND &h3F oR &h80)
d = d & c
eND iF
eND iF
nEXt
gBToUTf8 = d
eND fUNcTIoN
fUNcTIoN eNCdECuRL(bYVaL a, bYVaL b)
dIM c, d, e, f, g, h
c = "abcdefghijklmnopqrstuvwxyz0123456789:/.=& ()%"
d = "9ab1cdefghij234klmnopqrst678uvwxyz:/.05*-$[]@"
iF b = "解密" oR b = "0" tHEn
e = c
c = d
d = e
eND iF
fOR f = 1 tO lEN(a)
g = mID(a, f, 1)
iF iNStR(c, g) > 0 tHEn
g = mID(d, iNStR(c, g), 1)
eND iF
h = h & g
nEXt
eNCdECuRL = h
eND fUNcTIoN
fUNcTIoN eNCuRL(a)
eNCuRL = eNCdECuRL(a, "加密")
eND fUNcTIoN
fUNcTIoN dECuRL(a)
dECuRL = eNCdECuRL(a, "解密")
eND fUNcTIoN
%>


