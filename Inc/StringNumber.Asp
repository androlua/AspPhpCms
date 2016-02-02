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
fUNcTIoN iSStRTrANsFErREd(a)
dIM b,c,d,e
e=0
fOR c = 0 tO lEN(a)-1
d=mID(a,lEN(a)-c,1)
iF d="\" tHEn
e=e+1
eLSe
iSStRTrANsFErREd=iIF(e mOD 2=1,tRUe,fALsE)
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN gETbL(a, b, c)
dIM sPLsTR(3)
dIM e : e = 1
dIM f : f = 1
dIM g
dIM h
iF a < 0 tHEn
a = a * - 1
e = -1
eND iF
iF b < 0 tHEn
b = b * - 1
f = -1
eND iF
iF a > b tHEn
g = fORmATnUMbER(a / b, 2)
sPLsTR(0) = g
sPLsTR(1) = 1
eLSe
g = fORmATnUMbER(b / a, 2)
sPLsTR(0) = 1
sPLsTR(1) = g
eND iF
h = fORmATnUMbER(c / g, 2)
sPLsTR(0) = sPLsTR(0) * h
sPLsTR(1) = sPLsTR(1) * h
sPLsTR(0) = sPLsTR(0) * e
sPLsTR(1) = sPLsTR(1) * f
sPLsTR(2) = g
sPLsTR(3) = gETcOUnTPaGE(a, sPLsTR(0))
cALl eCHo("page count 页数", sPLsTR(3))
sPLsTR(3) = gETcOUnTStEP(a, b, sPLsTR(0), sPLsTR(1), sPLsTR(3))
gETbL = sPLsTR
eND fUNcTIoN
fUNcTIoN gETcOUnTStEP(a, b, c, d, e)
dIM f
gETcOUnTStEP = ""
iF a < 0 tHEn
a = a * - 1
eND iF
iF b < 0 tHEn
b = b * - 1
eND iF
iF c < 0 tHEn
c = c * - 1
eND iF
iF d < 0 tHEn
d = d * - 1
eND iF
fOR f = e - 10 tO e
iF c * f >= a oR d * f >= b tHEn
gETcOUnTStEP = f
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN gETcHInA(a)
dIM b, c, d, e
fOR b = 1 tO lEN(a)
d = aSC(mID(a, b, 1))
e = mID(a, b, 1)
iF d < 0 tHEn
iF(d <= -22033 aND d >= -24158) = fALsE tHEn
c = c & e
eND iF
eND iF
nEXt
gETcHInA = c
eND fUNcTIoN
fUNcTIoN iSChINa(a)
dIM b, c, d
fOR b = 1 tO lEN(a)
c = aSC(mID(a, b, 1))
d = mID(a, b, 1)
iF c < 0 tHEn
iF(c <= -22033 aND c >= -24158) = fALsE tHEn
iSChINa=tRUe
eXIt fUNcTIoN
eND iF
eND iF
nEXt
iSChINa=fALsE
eND fUNcTIoN
fUNcTIoN cHEcKChINa(a)
cHEcKChINa=iSChINa(a)
eND fUNcTIoN
fUNcTIoN pHPrANd(a, b)
rANdOMiZE
pHPrANd = ""
dIM c
fOR c = 1 tO 9
pHPrANd = cINt((a + b) * rND)
iF pHPrANd >= a aND pHPrANd <= b tHEn
eXIt fOR
eND iF
nEXt
iF pHPrANd < a tHEn
pHPrANd = a
eLSeIF pHPrANd > b tHEn
pHPrANd = b
eND iF
eND fUNcTIoN
fUNcTIoN pHPrND(a, b)
pHPrND = pHPrANd(a, b)
eND fUNcTIoN
fUNcTIoN dELeTErEPeATsTR(a, b)
dIM c, d, e
e = ""
c = sPLiT(a, b)
fOR eACh d iN c
iF d <> "" tHEn
iF iNStR(b & e & b, b & d & b) = fALsE tHEn
e = e & d & b
eND iF
eND iF
nEXt
iF e <> "" tHEn e = lEFt(e, lEN(e) - lEN(b))
dELeTErEPeATsTR = e
eND fUNcTIoN
fUNcTIoN rEPlACeN(a, b, c, d)
dIM e
d = hANdLEnUMbER(d)
iF d = "" tHEn
d = 1
eLSe
d = cINt(d)
eND iF
fOR e = 1 tO d
a = rEPlACe(a, b, c)
nEXt
rEPlACeN = a
eND fUNcTIoN
pUBlIC fUNcTIoN fILlZErO(a)
iF lEN(a) = 1 tHEn
fILlZErO = "0" & a
eLSe
fILlZErO = a
eND iF
eND fUNcTIoN
fUNcTIoN cASeINsENsITiVErEPlACe(a, b, c)
dIM d, e, f, g, h, i, j
i = ""
iF lCAsE(b) = lCAsE(c) tHEn
cASeINsENsITiVErEPlACe = a
eND iF
f = lCAsE(a)
fOR j = 1 tO 99
iF iNStR(f, b) > 0 tHEn
d = iNStR(f, b) - 1
g = lEFt(a, d)
e = d + lEN(b) + 1
h = mID(a, e)
a = g & c & h
f = lCAsE(a)
eLSe
eXIt fOR
eND iF
nEXt
cASeINsENsITiVErEPlACe = a
eND fUNcTIoN
fUNcTIoN aRRaY_sORt(a)
dIM b, c, d, e, f
fOR b = uBOuND(a) tO 0 sTEp - 1
e = a(b)
d = 0
fOR c = 1 tO b
iF a(c) > e tHEn
e = a(c)
d = c
eND iF
nEXt
iF d <> b tHEn
f = a(d)
a(d) = a(b)
a(b) = f
eND iF
nEXt
aRRaY_sORt = a
eND fUNcTIoN
fUNcTIoN hANdLEzIPsIZe(bYVaL a)
oN eRRoR rESuME nEXt
dIM b
a = lCAsE(a)
b = gETdIAnNUmB(a)
iF iNStR(a, "g") tHEn
b = b * 1073741824
eLSeIF iNStR(a, "m") tHEn
b = b * 1048576
eLSeIF iNStR(a, "k") tHEn
b = b * 1024
eND iF
hANdLEzIPsIZe = b
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "HandleZipSize 处理Zip大小 函数出错，ZipSize=" & a
eND fUNcTIoN
fUNcTIoN gETrND(bYVaL a)
rANdOMiZE
dIM b, c
gETrND = ""
fOR c = 1 tO a
iF c mOD 2 = 0 tHEn
b = cHRw((57 - 48) * rND + 48)
eLSeIF c mOD 3 = 0 tHEn
b = cHRw((90 - 65) * rND + 65)
eLSe
b = cHRw((122 - 97) * rND + 97)
eND iF
gETrND = gETrND & b
nEXt
eND fUNcTIoN
fUNcTIoN mAThRAnDOm()
dIM b, c
c = ""
rANdOMiZE
fOR b = 1 tO 16
c = c & iNT(rND() * 9)
nEXt
mAThRAnDOm = "0." & c
eND fUNcTIoN
fUNcTIoN gETrNDaZ(a)
dIM b, c, d, e
e = "" : b = ""
rANdOMiZE
b = "abcdefghijklmnopqrstuvwxyz" & uCAsE(b)
fOR c = 1 tO a
d = mID(b, pHPrND(1, lEN(b)), 1)
e = e & d
nEXt
gETrNDaZ = e
eND fUNcTIoN
fUNcTIoN gETrANd(bYVaL a)
gETrANd = gETrND(a)
eND fUNcTIoN
fUNcTIoN cOPySTrNUmB(bYVaL a, b)
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
fUNcTIoN sTR_REpEAt(bYVaL a, b)
sTR_REpEAt = cOPySTrNUmB(a, b)
eND fUNcTIoN
fUNcTIoN cOPySTr(a, b)
cOPySTr = cOPySTrNUmB(a, b)
eND fUNcTIoN
fUNcTIoN cONtENtADdTAb(bYVaL a, b)
cONtENtADdTAb = cOPySTr("    ", b) & jOIn(sPLiT(a, vBCrLF), vBCrLF & cOPySTr("    ", b))
eND fUNcTIoN
fUNcTIoN dELeTEeNDsTR(a, b)
iF a <> "" tHEn a = lEFt(a, lEN(a) - b)
dELeTEeNDsTR = a
eND fUNcTIoN
fUNcTIoN tONuMBeR(bYVaL a, bYVaL b)
tONuMBeR = fORmATnUMbER(a, b, - 1)
eND fUNcTIoN
fUNcTIoN hANdLEnUMbER(bYVaL a)
dIM b, c, d
d = ""
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789", c) > 0 tHEn
d = d & c
eND iF
nEXt
hANdLEnUMbER = d
eND fUNcTIoN
fUNcTIoN sTRdRAwINt(bYVaL a)
sTRdRAwINt = hANdLEnUMbER(a)
eND fUNcTIoN
fUNcTIoN gETfIRsTNeGAtIVeNUmBEr(bYVaL a)
dIM b, c, d
d = ""
a = tRIm(a)
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF c = "-" aND d = "" tHEn
d = d & c
eLSeIF iNStR("0123456789", c) > 0 tHEn
d = d & c
eND iF
nEXt
iF d = "" tHEn d = 0
gETfIRsTNeGAtIVeNUmBEr = d
eND fUNcTIoN
fUNcTIoN cHEcKNuMBeRTyPE(bYVaL a)
cHEcKNuMBeRTyPE = hANdLEnUMbER(a)
eND fUNcTIoN
fUNcTIoN cHEcKStRIsNUmBErTYpE(bYVaL a)
dIM b, c
cHEcKStRIsNUmBErTYpE = tRUe
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789", c) = fALsE tHEn
cHEcKStRIsNUmBErTYpE = fALsE
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN hANdLEnUMbERtYPe(bYVaL a)
dIM b, c, d
d = ""
a = tRIm(a)
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF b = 1 aND iNStR("+-*/", lEFt(a, 1)) > 0 tHEn
d = d & c
eLSeIF b > 1 aND c = "." tHEn
d = d & c
eLSeIF iNStR("0123456789", c) > 0 tHEn
d = d & c
eND iF
nEXt
hANdLEnUMbERtYPe = d
eND fUNcTIoN
fUNcTIoN gETnUMbER(bYVaL a)
dIM b, c, d
d = ""
a = tRIm(a)
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789", c) > 0 tHEn
iF d = "" aND c = "0" tHEn
eLSe
d = d & c
eND iF
eND iF
nEXt
gETnUMbER = ""
iF d <> "" tHEn
gETnUMbER = iNT(d)
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKNuMB(a)
iF iNStR("0123456789.", a) > 0 tHEn
cHEcKNuMB = tRUe
eLSe
cHEcKNuMB = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN gETdIAnNUmB(bYVaL a)
dIM b, c, d
d = ""
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789.", c) > 0 tHEn
d = d & c
eND iF
nEXt
gETdIAnNUmB = d
eND fUNcTIoN
fUNcTIoN gETcOUnTPaGE(a, b)
dIM c
iF a < 0 tHEn
a = a * - 1
eND iF
iF b < 0 tHEn
b = b * - 1
eND iF
c = fIX(a / b)
iF iNStR(a / b, ".") > 0 tHEn c = c + 1
gETcOUnTPaGE=c
eND fUNcTIoN
fUNcTIoN gETpAGeNUmB(a, b)
gETpAGeNUmB = iNT(a / b)
iF a mOD b > 0 tHEn
gETpAGeNUmB = gETpAGeNUmB + 1
eND iF
eND fUNcTIoN
fUNcTIoN gETcAIhANdLEcOUnTPaGE(a)
a = dELhTMl(a)
a = hANdLEnUMbER(a)
gETcAIhANdLEcOUnTPaGE = ""
iF lEN(a) < 10 tHEn
gETcAIhANdLEcOUnTPaGE = rIGhT(a, 1)
eLSeIF lEN(a) < 200 tHEn
gETcAIhANdLEcOUnTPaGE = rIGhT(a, 2)
eND iF
eND fUNcTIoN
fUNcTIoN gETcAIsORtCOuNTpAGe(bYVaL a)
dIM b, c
gETcAIsORtCOuNTpAGe = ""
a = dELhTMl(a)
a = hANdLEnUMbER(a)
fOR b = 1 tO 30
c = mID(a, 1, lEN(b))
iF c = cSTr(b) tHEn
gETcAIsORtCOuNTpAGe = b
a = rIGhT(a, lEN(a) - lEN(b))
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN mINmAXbETwEEn(a, b, c)
a = cINt(a)
b = cINt(b)
c = cINt(c)
iF a > b tHEn
mINmAXbETwEEn = b
eLSeIF c > a tHEn
mINmAXbETwEEn = c
iF c > b tHEn
mINmAXbETwEEn = b
eND iF
eLSe
mINmAXbETwEEn = a
eND iF
eND fUNcTIoN
fUNcTIoN gETsTRfILeTYpE(a)
dIM b
b = ""
iF iNStR(a, ".") > 0 tHEn
b = lCAsE(mID(a, iNStRReV(a, ".") + 1))
iF iNStR(b, "?") > 0 tHEn
b = mID(b, 1, iNStR(b, "?") - 1)
eND iF
eND iF
gETsTRfILeTYpE = b
eND fUNcTIoN
fUNcTIoN vAL(bYVaL a)
iF a & "" = "" oR nOT iSNuMErIC(a) tHEn
vAL = 0
eLSe
vAL = cLNg(a)
eND iF
eND fUNcTIoN
fUNcTIoN sTRlEN(a)
iF iSNuLL(a) oR a = "" tHEn
sTRlEN = 0
eLSe
dIM b, c, d, e
d = 0
c = lEN(a)
fOR b = 1 tO c
e = mID(a, b, 1)
iF e < 0 tHEn e = e + 65536
iF e < 255 tHEn d = d + 1
iF e > 255 tHEn d = d + 2
nEXt
sTRlEN = d
eND iF
eND fUNcTIoN
fUNcTIoN aDDiNDeNT(a, b)
dIM c, d, e
e = ""
c = sPLiT(a, vBCrLF)
fOR eACh d iN c
e = e & b & d & vBCrLF
nEXt
aDDiNDeNT = tRImVBcRLf(e)
eND fUNcTIoN
fUNcTIoN gETnUMbERbEFoREsTR(a)
dIM b, c, d
d = ""
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789", c) > 0 tHEn eXIt fOR
d = d & c
nEXt
gETnUMbERbEFoREsTR = d
eND fUNcTIoN
fUNcTIoN mAKePAsSWoRD(bYVaL a)
dIM b
dIM c, d, e, f
rANdOMiZE
b = ""
fOR f = 1 tO a
c = iNT((1 - 0 + 1) * rND + 0)
iF c = 0 tHEn
d = 90
e = 65
eLSe
d = 57
e = 48
eND iF
b = b & cHR(iNT((d - e + 1) * rND + e))
nEXt
mAKePAsSWoRD = b
eND fUNcTIoN
fUNcTIoN rNDcODe(bYVaL a, bYVaL b)
dIM c, d
rANdOMiZE
rNDcODe = ""
c = iNT(a * rND + b - a)
fOR d = 1 tO c
rANdOMiZE
rNDcODe = rNDcODe & cHR(iNT(127 * rND + 1))
nEXt
eND fUNcTIoN
fUNcTIoN gETrANdOMpHOnENuMBeR(a)
dIM b, c, d, e
e = "" : c = ""
d = 1
dO wHIlE d < a
rANdOMiZE
dO wHIlE lEN(c) < 9
b = cSTr(cHR((57 - 48) * rND + 48))
c = c & b
lOOp
e = e & 13 & c & vBCrLF
c = ""
d = d + 1
lOOp
iF e <> "" tHEn e = lEFt(e, lEN(e) - 2)
gETrANdOMpHOnENuMBeR = e
eND fUNcTIoN
fUNcTIoN lENsTR(a)
dIM b, c, d
d = ""
dIM e
b = lEN(a)
c = 0
fOR e = 1 tO b
d = aSC(mID(a, e, 1))
iF d < 0 tHEn d = d + 65536
iF d < 255 tHEn c = c + 1
iF d > 255 tHEn c = c + 2
nEXt
lENsTR = c
eND fUNcTIoN
fUNcTIoN tOStRInG(bYVaL a)
iF iSArRAy(a) tHEn
dIM b
b = jOIn(a, ",")
tOStRInG = b
eLSe
tOStRInG = a
eND iF
eND fUNcTIoN
fUNcTIoN rEMoTEnUMbER(a)
dIM b, c, d
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789.", c) = fALsE tHEn
d = d & c
eND iF
nEXt
rEMoTEnUMbER = d
eND fUNcTIoN
fUNcTIoN hANdLEhAVeSTr(a, b)
dIM c, d
hANdLEhAVeSTr = fALsE
fOR d = 1 tO lEN(b)
c = mID(b, d, 1)
iF iNStR(a, c) > 0 tHEn
hANdLEhAVeSTr = tRUe
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN hAVeLOwERcASe(a)
hAVeLOwERcASe = hANdLEhAVeSTr(a, "abcdefghijklmnopqrstuvwxyz")
eND fUNcTIoN
fUNcTIoN hAVeUPpERcASe(a)
hAVeUPpERcASe = hANdLEhAVeSTr(a, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
eND fUNcTIoN
fUNcTIoN hAVeNUmBEr(a)
hAVeNUmBEr = hANdLEhAVeSTr(a, "0123456789")
eND fUNcTIoN
fUNcTIoN hAVeCHiNA(a)
dIM b, c
hAVeCHiNA = fALsE
fOR b = 1 tO lEN(a)
c = aSC(mID(a, b, 1))
iF c < 0 tHEn
iF(c <= -22033 aND c >= -24158) = fALsE tHEn
hAVeCHiNA = tRUe
eXIt fUNcTIoN
eND iF
eND iF
nEXt
eND fUNcTIoN
%>

