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
cONsT nMAxSAtURaTIoN = 100	
cONsT nBLaNKnOIsYDoTOdDS = 0.2  	
cONsT nCOlORnOIsYDoTOdDS = 0.1  	
cONsT nCHaRCoUNt = 4	
cONsT nPIxELwIDtH = 22	
cONsT nPIxELhEIgHT = 22	
cONsT nCOlORhUE = -1	
cONsT nANgLErANdOM = 10         	
cONsT nLEnGThRAnDOm = 30        	
cONsT cCHaRSeT = "0123456789"
dIM bUF(), dIGtALsTR
dIM lINeS(), lINeCOuNT
dIM cURsORx, cURsORy, dIRx, dIRy
rANdOMiZE
cALl cREaTVaLIdCOdE("YZM")
sUB cDGeN_rESeT()
lINeCOuNT = 0
cURsORx = 0
cURsORy = 0
dIRx = 0
dIRy = 1
eND sUB
sUB cDGeN_cLEaR()
dIM b, c
rEDiM bUF(nPIxELhEIgHT - 1, nCHaRCoUNt * nPIxELwIDtH - 1)
fOR c = 0 tO nPIxELhEIgHT - 1
fOR b = 0 tO nCHaRCoUNt * nPIxELwIDtH - 1
bUF(c, b) = 0
nEXt
nEXt
eND sUB
sUB cDGeN_pSEt(a, b)
bUF(b, a) = 1
eND sUB
sUB cDGeN_lINe(a, b, c, d)
dIM e, f, g, h
e = c - a
f = d - b
iF aBS(e) > aBS(f) tHEn g = aBS(e) eLSe g = aBS(f)
fOR h = 0 tO g
cDGeN_pSEt a + e * h / g, b + f * h / g
nEXt
eND sUB
sUB cDGeN_fOWaRDdRAw(a)
a = sGN(a) * aBS(a) * (1 - nLEnGThRAnDOm / 100 + rND * nLEnGHtRAnDOm * 2 / 100)
rEDiM pREsERvE lINeS(3, lINeCOuNT)
lINeS(0, lINeCOuNT) = cURsORx
lINeS(1, lINeCOuNT) = cURsORy
cURsORx = cURsORx + dIRx * a
cURsORy = cURsORy + dIRy * a
lINeS(2, lINeCOuNT) = cURsORx
lINeS(3, lINeCOuNT) = cURsORy
lINeCOuNT = lINeCOuNT + 1
eND sUB
sUB cDGeN_sETdIReCTiON(a)
dIM b, c
a = sGN(a) * (aBS(a) - nANgLErANdOM + rND * nANgLErANdOM * 2) / 180 * 3.1415926
b = dIRx
c = dIRy
dIRx = b * cOS(a) - c * sIN(a)
dIRy = b * sIN(a) + c * cOS(a)
eND sUB
sUB cDGeN_mOVeTOmIDdLE(a, b)
dIM c, d
c = lINeS(2, a) - lINeS(0, a)
d = lINeS(3, a) - lINeS(1, a)
cURsORx = lINeS(0, a) + sGN(c) * aBS(c) * b / 100
cURsORy = lINeS(1, a) + sGN(d) * aBS(d) * b / 100
eND sUB
sUB cDGeN_mOVeCUrSOr(a)
cURsORx = lINeS(0, a)
cURsORy = lINeS(1, a)
eND sUB
sUB cDGeN_cLOsE(a)
rEDiM pREsERvE lINeS(3, lINeCOuNT)
lINeS(0, lINeCOuNT) = cURsORx
lINeS(1, lINeCOuNT) = cURsORy
cURsORx = lINeS(0, a)
cURsORy = lINeS(1, a)
lINeS(2, lINeCOuNT) = cURsORx
lINeS(3, lINeCOuNT) = cURsORy
lINeCOuNT = lINeCOuNT + 1
eND sUB
sUB cDGeN_cLOsEToMIdDLe(a, b)
dIM c, d
rEDiM pREsERvE lINeS(3, lINeCOuNT)
lINeS(0, lINeCOuNT) = cURsORx
lINeS(1, lINeCOuNT) = cURsORy
c = lINeS(2, a) - lINeS(0, a)
d = lINeS(3, a) - lINeS(1, a)
cURsORx = lINeS(0, a) + sGN(c) * aBS(c) * b / 100
cURsORy = lINeS(1, a) + sGN(d) * aBS(d) * b / 100
lINeS(2, lINeCOuNT) = cURsORx
lINeS(3, lINeCOuNT) = cURsORy
lINeCOuNT = lINeCOuNT + 1
eND sUB
sUB cDGeN_fLUsH(a, b)
dIM c, d, e, f
dIM g, h, i, j, k, l
dIM m
c = d = e = f = 0
fOR m = 0 tO lINeCOuNT - 1
iF c < lINeS(0, m) tHEn c = lINeS(0, m)
iF c < lINeS(2, m) tHEn c = lINeS(2, m)
iF d > lINeS(0, m) tHEn d = lINeS(0, m)
iF d > lINeS(2, m) tHEn d = lINeS(2, m)
iF e < lINeS(1, m) tHEn e = lINeS(1, m)
iF e < lINeS(3, m) tHEn e = lINeS(3, m)
iF f > lINeS(1, m) tHEn f = lINeS(1, m)
iF f > lINeS(3, m) tHEn f = lINeS(3, m)
nEXt
g = c - d
h = e - f
iF g = 0 tHEn g = 1
iF h = 0 tHEn h = 1
c = d
e = f
iF g > h tHEn
i = (nPIxELwIDtH - 2) / g
j = (nPIxELhEIgHT - 2) / g
k = 0
l = (g - h) / 2
eLSe
i = (nPIxELwIDtH - 2) / h
j = (nPIxELhEIgHT - 2) / h
k = (h - g) / 2
l = 0
eND iF
fOR m = 0 tO lINeCOuNT - 1
lINeS(0, m) = rOUnD((lINeS(0, m) - c + k) * i, 0)
iF lINeS(0, m) < 0 tHEn lINeS(0, m) = 0
iF lINeS(0, m) >= nPIxELwIDtH - 2 tHEn lINeS(0, m) = nPIxELwIDtH - 3
lINeS(1, m) = rOUnD((lINeS(1, m) - e + l) * j, 0)
iF lINeS(1, m) < 0 tHEn lINeS(1, m) = 0
iF lINeS(1, m) >= nPIxELhEIgHT - 2 tHEn lINeS(1, m) = nPIxELhEIgHT - 3
lINeS(2, m) = rOUnD((lINeS(2, m) - d + k) * i, 0)
iF lINeS(2, m) < 0 tHEn lINeS(2, m) = 0
iF lINeS(2, m) >= nPIxELwIDtH - 2 tHEn lINeS(2, m) = nPIxELwIDtH - 3
lINeS(3, m) = rOUnD((lINeS(3, m) - f + l) * j, 0)
iF lINeS(3, m) < 0 tHEn lINeS(3, m) = 0
iF lINeS(3, m) >= nPIxELhEIgHT - 2 tHEn lINeS(3, m) = nPIxELhEIgHT - 3
cDGeN_lINe lINeS(0, m) + a + 1, lINeS(1, m) + b + 1, lINeS(2, m) + a + 1, lINeS(3, m) + b + 1
nEXt
eND sUB
sUB cDGeN_cHAr(a, b, c)
cDGeN_rESeT
sELeCT cASe a
cASe "0"
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 1.5
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw 0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw 0.7
cDGeN_cLOsE 0
cASe "1"
cDGeN_sETdIReCTiON -90
cDGeN_fOWaRDdRAw 0.5
cDGeN_mOVeTOmIDdLE 0, 50
cDGeN_sETdIReCTiON 90
cDGeN_fOWaRDdRAw -1.4
cDGeN_sETdIReCTiON 30
cDGeN_fOWaRDdRAw 0.4
cASe "2"
cDGeN_sETdIReCTiON 45
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -120
cDGeN_fOWaRDdRAw 0.4
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.6
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 1.6
cDGeN_sETdIReCTiON -135
cDGeN_fOWaRDdRAw 1.0
cASe "3"
cDGeN_sETdIReCTiON -90
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON 135
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON -120
cDGeN_fOWaRDdRAw 0.6
cDGeN_sETdIReCTiON 80
cDGeN_fOWaRDdRAw 0.5
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.5
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.5
cASe "4"
cDGeN_sETdIReCTiON 20
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON -110
cDGeN_fOWaRDdRAw 1.2
cDGeN_mOVeTOmIDdLE 1, 60
cDGeN_sETdIReCTiON 90
cDGeN_fOWaRDdRAw 0.7
cDGeN_mOVeCUrSOr 2
cDGeN_fOWaRDdRAw -1.5
cASe "5"
cDGeN_sETdIReCTiON 90
cDGeN_fOWaRDdRAw 1.0
cDGeN_sETdIReCTiON -90
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON -90
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON 30
cDGeN_fOWaRDdRAw 0.4
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.4
cDGeN_sETdIReCTiON 30
cDGeN_fOWaRDdRAw 0.5
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.8
cASe "6"
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 1.5
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 0.5
cDGeN_cLOsEToMIdDLe 2, 50
cASe "7"
cDGeN_sETdIReCTiON 180
cDGeN_fOWaRDdRAw 0.3
cDGeN_sETdIReCTiON 90
cDGeN_fOWaRDdRAw 0.9
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 1.3
cASe "8"
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.8
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.8
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON 110
cDGeN_fOWaRDdRAw -1.5
cDGeN_sETdIReCTiON -110
cDGeN_fOWaRDdRAw 0.9
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.8
cDGeN_sETdIReCTiON 60
cDGeN_fOWaRDdRAw 0.9
cDGeN_sETdIReCTiON 70
cDGeN_fOWaRDdRAw 1.5	
cDGeN_cLOsE 0
cASe "9"
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -1.5
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw 0.5
cDGeN_cLOsEToMIdDLe 2, 50
cASe "A"
cDGeN_sETdIReCTiON -(rND * 20 + 150)
cDGeN_fOWaRDdRAw rND * 0.2 + 1.1
cDGeN_sETdIReCTiON rND * 20 + 140
cDGeN_fOWaRDdRAw rND * 0.2 + 1.1
cDGeN_mOVeTOmIDdLE 0, 30
cDGeN_cLOsEToMIdDLe 1, 70
cASe "B"
cDGeN_sETdIReCTiON -(rND * 20 + 50)
cDGeN_fOWaRDdRAw rND * 0.4 + 0.8
cDGeN_sETdIReCTiON rND * 20 + 110
cDGeN_fOWaRDdRAw rND * 0.2 + 0.6
cDGeN_sETdIReCTiON -(rND * 20 + 110)
cDGeN_fOWaRDdRAw rND * 0.2 + 0.6
cDGeN_sETdIReCTiON rND * 20 + 110
cDGeN_fOWaRDdRAw rND * 0.4 + 0.8
cDGeN_cLOsE 0
cASe "C"
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON -60
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 1.5
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw -0.7
cDGeN_sETdIReCTiON 120
cDGeN_fOWaRDdRAw 0.7
eND sELeCT
cDGeN_fLUsH b, c
eND sUB
sUB cDGeN_bLUr()
dIM b, c
fOR c = 1 tO nPIxELhEIgHT - 2
fOR b = 1 tO nCHaRCoUNt * nPIxELwIDtH - 2
iF bUF(c, b) = 0 tHEn
iF ((bUF(c, b - 1) oR bUF(c + 1, b)) aND 1) <> 0 tHEn
bUF(c, b) = 2
eND iF
eND iF
nEXt
nEXt
eND sUB
sUB cDGeN_nOIsYDoT()
dIM b, c, d, e
fOR c = 0 tO nPIxELhEIgHT - 1
fOR b = 0 tO nCHaRCoUNt * nPIxELwIDtH - 1
iF bUF(c, b) <> 0 tHEn
d = iNT(rND * rND * nMAxSAtURaTIoN)
sELeCT cASe nCOlORnOIsYDoTOdDS
cASe 0
e = nMAxSAtURaTIoN
cASe 1
e = 0
cASe eLSe
e = d
eND sELeCT
iF rND < nCOlORnOIsYDoTOdDS tHEn bUF(c, b) = e eLSe bUF(c, b) = nMAxSAtURaTIoN
eLSe
d = iNT(rND * nMAxSAtURaTIoN)
sELeCT cASe nBLaNKnOIsYDoTOdDS
cASe 0
e = 0
cASe 1
e = nMAxSAtURaTIoN
cASe eLSe
e = d
eND sELeCT
iF rND < nBLaNKnOIsYDoTOdDS tHEn bUF(c, b) = e eLSe bUF(c, b) = 0
eND iF
nEXt
nEXt
eND sUB
sUB cDGeN()
dIM b, c
dIGtALsTR = ""
cDGeN_cLEaR
fOR b = 0 tO nCHaRCoUNt - 1
c = mID(cCHaRSeT, iNT(rND * lEN(cCHaRSeT)) + 1, 1)
dIGtALsTR = dIGtALsTR + c
cDGeN_cHAr c, b * nPIxELwIDtH, 0
nEXt
cDGeN_bLUr
cDGeN_nOIsYDoT
eND sUB
fUNcTIoN hSBtORgB(a, b, c)
dIM aRGb(3), e, f, g
dIM h, i, j
dIM k, l, m, n, o
a = (a mOD 360)
iF b > 100 tHEn
b = 100
eLSeIF b < 0 tHEn
b = 0
eND iF
iF c > 100 tHEn
c = 100
eLSeIF c < 0 tHEn
c = 0
eND iF
iF b > 0 tHEn
h = a / 60
i = b / 100
j = c / 100
k = iNT(h)
l = h - k
m = j * (1 - i)
n = j * (1 - i * l)
o = j * (1 - i * (1 - l))
sELeCT cASe k
cASe 0
aRGb(0) = j * 255
aRGb(1) = o * 255
aRGb(2) = m * 255
cASe 1
aRGb(0) = n * 255
aRGb(1) = j * 255
aRGb(2) = m * 255
cASe 2
aRGb(0) = m * 255
aRGb(1) = j * 255	
aRGb(2) = o * 255
cASe 3
aRGb(0) = m * 255
aRGb(1) = n * 255
aRGb(2) = j * 255
cASe 4
aRGb(0) = o * 255
aRGb(1) = m * 255
aRGb(2) = j * 255
cASe 5
aRGb(0) = j * 255
aRGb(1) = m * 255
aRGb(2) = n * 255
eND sELeCT	
eLSe
aRGb(0) = (c * 255) / 100
aRGb(1) = aRGb(0)
aRGb(2) = aRGb(0)
eND iF
hSBtORgB = cHRb(rOUnD(aRGb(2), 0)) & cHRb(rOUnD(aRGb(1), 0)) & cHRb(rOUnD(aRGb(0), 0))
eND fUNcTIoN
sUB cREaTVaLIdCOdE(a)
dIM b, c, d
rESpONsE.eXPiREs = -9999
rESpONsE.aDDhEAdER "pragma", "no-cache"
rESpONsE.aDDhEAdER "cache-ctrol", "no-cache"
rESpONsE.cONtENtTYpE = "image/bmp"
cALl cDGeN
sESsIOn(a) = dIGtALsTR	
dIM e, f, g, h
e = nCHaRCoUNt * nPIxELwIDtH
f = nPIxELhEIgHT
h = e * f * 3
g = h + 54
rESpONsE.bINaRYwRItE cHRb(66) & cHRb(77) & _
cHRb(g mOD 256) & cHRb((g \ 256) mOD 256) & cHRb((g \ 256 \ 256) mOD 256) & cHRb(g \ 256 \ 256 \ 256) & _
cHRb(0) & cHRb(0) & cHRb(0) & cHRb(0) & _
cHRb(54) & cHRb(0) & cHRb(0) & cHRb(0)
rESpONsE.bINaRYwRItE cHRb(40) & cHRb(0) & cHRb(0) & cHRb(0) & _
cHRb(e mOD 256) & cHRb((e \ 256) mOD 256) & cHRb((e \ 256 \ 256) mOD 256) & cHRb(e \ 256 \ 256 \ 256) & _
cHRb(f mOD 256) & cHRb((f \ 256) mOD 256) & cHRb((f \ 256 \ 256) mOD 256) & cHRb(f \ 256 \ 256 \ 256) & _
cHRb(1) & cHRb(0) & _
cHRb(24) & cHRb(0) & _
cHRb(0) & cHRb(0) & cHRb(0) & cHRb(0) & _
cHRb(h mOD 256) & cHRb((h \ 256) mOD 256) & cHRb((h \ 256 \ 256) mOD 256) & cHRb(h \ 256 \ 256 \ 256) & _
cHRb(18) & cHRb(11) & cHRb(0) & cHRb(0) & _
cHRb(18) & cHRb(11) & cHRb(0) & cHRb(0) & _
cHRb(0) & cHRb(0) & cHRb(0) & cHRb(0) & _
cHRb(0) & cHRb(0) & cHRb(0) & cHRb(0)
iF nCOlORhUE = -1 tHEn
d = iNT(rND * 360)
eLSeIF nCOlORhUE = -2 tHEn
d = 0
eLSe
d = nCOlORhUE
eND iF
fOR c = 0 tO nPIxELhEIgHT - 1
fOR b = 0 tO lEN(dIGtALsTR) * nPIxELwIDtH - 1
iF nCOlORhUE = -2 tHEn
rESpONsE.bINaRYwRItE hSBtORgB(d, 0, 100 - bUF(nPIxELhEIgHT - 1 - c, b))
eLSe
rESpONsE.bINaRYwRItE hSBtORgB(d, bUF(nPIxELhEIgHT - 1 - c, b), 100)
eND iF
nEXt
nEXt
eND sUB
%>


