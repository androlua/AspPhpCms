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
fUNcTIoN cSScOMpREsSIoN(a, b)
b = cSTr(b)
iF b = "1" tHEn
a = rEGeXP_REpLAcE(a, "\/\*(.|" & vBCrLF & ")*?\*\/", "")
a = rEGeXP_REpLAcE(a, "\s*([\{\}\:\;\,])\s*", "$1")
a = rEGeXP_REpLAcE(a, "\,[\s\.\#\d]*\{", "{")
a = rEGeXP_REpLAcE(a, ";\s*;", ";")
eLSe
iF b >= 2 tHEn
a = rEGeXP_REpLAcE(a, "\/\*(.|" & vBCrLF & ")*?\*\/", "")
eND iF
a = rEGeXP_REpLAcE(a, "\s*([\{\}\:\;\,])\s*", "$1")
a = rEGeXP_REpLAcE(a, "\,[\s\.\#\d]*\{", "{")
a = rEGeXP_REpLAcE(a, ";\s*;", ";")
a = rEGeXP_REpLAcE(a, ";\s*}", "}")
a = rEGeXP_REpLAcE(a, "([^\s])\{([^\s])", "$1{$2")
a = rEGeXP_REpLAcE(a, "([^\s])\}([^" & vBCrLF & "]s*)", "$1}" & vBCrLF & "$2")
eND iF
a = tRImVBcRLf(a)
cSScOMpREsSIoN = a
eND fUNcTIoN
fUNcTIoN dELeTEcSSnOTe(a)
dELeTEcSSnOTe = rEGeXP_REpLAcE(a, "\/\*(.|" & vBCrLF & ")*?\*\/", "")
eND fUNcTIoN
fUNcTIoN uNCsSCoMPrESsIOn(a)
a = rEGeXP_REpLAcE(a, "\s*([\{\}\:\;\,])\s*", "$1")
a = rEGeXP_REpLAcE(a, ";\s*;", ";")
a = rEGeXP_REpLAcE(a, "\,[\s\.\#\d]*{", "{")
a = rEGeXP_REpLAcE(a, "([^\s])\{([^\s])", "$1 {" & vBCrLF & "" & vBTaB & "$2")
a = rEGeXP_REpLAcE(a, "([^\s])\}([^" & vBCrLF & "]*)", "$1" & vBCrLF & "}" & vBCrLF & "$2")
a = rEGeXP_REpLAcE(a, "([^\s]);([^\s\}])", "$1;" & vBCrLF & "" & vBTaB & "$2")
uNCsSCoMPrESsIOn = a
eND fUNcTIoN
fUNcTIoN tRImVBcRLf(a)
tRImVBcRLf = rTRiMVbCRlF(lTRiMVbCRlF(a))
eND fUNcTIoN
fUNcTIoN pHPtRIm(a)
pHPtRIm = tRImVBcRLf(a)
eND fUNcTIoN
fUNcTIoN lTRiMVbCRlF(a)
dIM b, c
b = 1
c = tRUe
wHIlE c
iF mID(a, b, 1) = " " oR mID(a, b, 1) = vBTaB tHEn
b = b + 1
eLSeIF mID(a, b, 2) = vBCrLF tHEn
b = b + 2
eLSe
c = fALsE
eND iF
wENd
lTRiMVbCRlF = rIGhT(a, lEN(a) - b + 1)
eND fUNcTIoN
fUNcTIoN rTRiMVbCRlF(a)
dIM b, c
b = lEN(a)
c = tRUe
wHIlE c aND b >= 2
iF mID(a, b, 1) = " " oR mID(a, b, 1) = vBTaB tHEn
b = b - 1
eLSeIF mID(a, b - 1, 2) = vBCrLF tHEn
b = b - 2
eLSe
c = fALsE
eND iF
wENd
rTRiMVbCRlF = rTRiM(lEFt(a, b))
eND fUNcTIoN
fUNcTIoN tRImVBtAB(a)
tRImVBtAB = rTRiMVbTAb(lTRiMVbTAb(a))
eND fUNcTIoN
fUNcTIoN lTRiMVbTAb(a)
dIM b, c
b = 1
c = tRUe
wHIlE c
iF mID(a, b, 1) = " " tHEn
b = b + 1
eLSeIF mID(a, b, 1) = vBTaB tHEn
b = b + 1
eLSe
c = fALsE
eND iF
wENd
lTRiMVbTAb = rIGhT(a, lEN(a) - b + 1)
eND fUNcTIoN
fUNcTIoN rTRiMVbTAb(a)
dIM b, c
b = lEN(a)
c = tRUe
wHIlE c aND b >= 2
iF mID(a, b, 1) = " " tHEn
b = b - 1
eLSeIF mID(a, b - 1, 1) = vBTaB tHEn
b = b - 1
eLSe
c = fALsE
eND iF
wENd
rTRiMVbTAb = rTRiM(lEFt(a, b))
eND fUNcTIoN
fUNcTIoN gEThTMlCSsSTyLE(bYVaL a)
dIM b, c, d, e, f, g, h
b = sPLiT(a, vBCrLF)
d = fALsE
fOR eACh c iN b
iF d = fALsE tHEn
iF iNStR(lCAsE(c), "<style") > 0 tHEn
e = mID(c, iNStR(lCAsE(c), "<style"))
e = mID(e, 1, iNStR(e, ">"))
f = mID(c, iNStR(lCAsE(c), e) + lEN(e))
iF iNStR(f, "</style>") > 0 tHEn
g = mID(f, 1, iNStR(f, "</style>") - 1)
h = h & g & vBCrLF
eLSe
h = h & f & vBCrLF
d = tRUe
eND iF
eND iF
eLSeIF d = tRUe tHEn
iF iNStR(lCAsE(c), "</style>") > 0 tHEn
g = mID(c, 1, iNStR(lCAsE(c), "</style>") - 1)
h = h & g & vBCrLF
d = fALsE
eLSe
h = h & c & vBCrLF
eND iF
eND iF
nEXt
gEThTMlCSsSTyLE = h
eND fUNcTIoN
fUNcTIoN hANdLEcLEaNCsS(bYVaL a)
dIM b, c, d, e, f
a = rEPlACe(a, "{", vBCrLF & "{" & vBCrLF)
a = rEPlACe(a, "}", vBCrLF & "}" & vBCrLF)
a = rEPlACe(a, ";", ";" & vBCrLF)
b = sPLiT(a, vBCrLF)
e = fALsE
fOR eACh c iN b
c = tRImVBcRLf(c)
f = ""
iF c <> "" tHEn
iF iNStR(c, "{") > 0 aND iNStR(c, "}") = fALsE tHEn
e = tRUe
f = c
eLSeIF iNStR(c, "}") > 0 tHEn
e = fALsE
eND iF
iF lEFt(c, 1) <> "{" tHEn d = d & vBCrLF
iF e = tRUe tHEn c = "    " & c
iF f <> "" tHEn c = f
d = d & c
eND iF
nEXt
d = tRImVBcRLf(d)
hANdLEcLEaNCsS = d
eND fUNcTIoN
fUNcTIoN rEMoVEeXCeSSrOW(a)
dIM b, c, d, e
b = sPLiT(a, vBCrLF)
fOR eACh c iN b
e = rEPlACe(rEPlACe(c, " ", ""), vBTaB, "")
iF e <> "" tHEn
d = d & c & vBCrLF
eND iF
nEXt
iF d <> "" tHEn d = lEFt(d, lEN(d) - 2)
rEMoVEeXCeSSrOW = d
eND fUNcTIoN
fUNcTIoN cSSaDDtOStYLe(a, b)
dIM c, d, e, f
iF iNStR(b, "{") > 0 tHEn
c = tRIm(mID(b, 1, iNStR(b, "{") - 1))
eND iF
d = fINdCSsSTyLE(a, c)
e = cSSsTYlEAdDToPArAM(d, b)
a = rEPlACe(a, d, e)
cSSaDDtOStYLe = a
eND fUNcTIoN
fUNcTIoN cHEcKCsSStYLe(a, b)
dIM c
cHEcKCsSStYLe = tRUe
iF iNStR(b, "{") > 0 tHEn
c = tRIm(mID(b, 1, iNStR(b, "{") - 1))
eND iF
iF c = "" tHEn
cHEcKCsSStYLe = fALsE
eLSeIF fINdCSsSTyLE(a, c) = "" tHEn
cHEcKCsSStYLe = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN cSSsTYlEAdDToPArAM(bYVaL a, bYVaL b)
dIM c, d, e, f, g, h
h = mID(a, 1, iNStR(a, "{"))
iF iNStR(a, "{") > 0 tHEn
a = mID(a, iNStR(a, "{") + 1)
eND iF
iF iNStR(a, "}") > 0 tHEn
a = mID(a, 1, iNStR(a, "}") - 1)
eND iF
iF iNStR(b, "{") > 0 tHEn
b = mID(b, iNStR(b, "{") + 1)
eND iF
iF iNStR(b, "}") > 0 tHEn
b = mID(b, 1, iNStR(b, "}") - 1)
eND iF
c = sPLiT(rEPlACe(a & ";" & b, vBCrLF, ""), ";")
fOR eACh e iN c
e = tRIm(e)
iF iNStR(e, ":") > 0 aND e <> "" tHEn
g = tRIm(mID(e, 1, iNStR(e, ":") - 1))
iF iNStR("|" & f & "|", "|" & g & "|") = fALsE tHEn
f = f & g & "|"
d = d & "    " & e & ";" & vBCrLF
eND iF
eND iF
nEXt
iF h <> "" tHEn
d = h & vBCrLF & d & "}"
eND iF
cSSsTYlEAdDToPArAM = d
eND fUNcTIoN
fUNcTIoN fINdCSsSTyLE(bYVaL a, bYVaL b)
dIM c, d, e, f
b = tRIm(b)
c = sPLiT(a, vBCrLF)
fOR eACh d iN c
iF iNStR(d, b) > 0 tHEn
f = tRIm(d)
iF iNStR(f, "{") > 0 tHEn
f = tRIm(mID(f, 1, iNStR(f, "{") - 1))
eND iF
iF f = b tHEn
iF iNStR(d, "}") > 0 tHEn
fINdCSsSTyLE = mID(d, 1, iNStR(d, "}") + 1)
eXIt fUNcTIoN
eLSe
e = mID(a, iNStR(a, d & vBCrLF) + 1)
e = mID(e, 1, iNStR(e, "}") + 1)
fINdCSsSTyLE = e
eXIt fUNcTIoN
eND iF
eND iF
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN hANdLEcUTcSScODe(a, b)
dIM c, d, e, f, g, h, i
d = "url\(" : e = "\)"
c = gETaRRaY(b, d, e, fALsE, fALsE)
f = sPLiT(c, "$Array$")
fOR eACh g iN f
iF g <> "" aND iNStR(g, ".") > 0 aND iNStR(vBCrLF & i & vBCrLF, vBCrLF & g & vBCrLF) = fALsE tHEn
i = i & g & vBCrLF
h = rEPlACe(rEPlACe(rEPlACe(g, """", ""), "'", ""), "\", "/")
iF iNStR(h, "/") > 0 tHEn
h = mID(h, iNStRReV(h, "/") + 1)
eND iF
b = rEPlACe(b, g, a & h)
eND iF
nEXt
hANdLEcUTcSScODe = b
eND fUNcTIoN
fUNcTIoN hANdLEcUTdIVcODe(a, b)
dIM c, d, e, f, g, h, i, j
d = "url\(" : e = "\)"
c = gETaRRaY(b, d, e, fALsE, fALsE)
f = sPLiT(c, "$Array$")
fOR eACh g iN f
iF g <> "" aND iNStR(g, ".") > 0 aND iNStR(g, "{$#") = fALsE tHEn
iF gETwEBsITe(g) = "" tHEn
i = rEPlACe(rEPlACe(rEPlACe(g, """", ""), "'", ""), "\", "/")
iF iNStR(i, "/") > 0 tHEn
i = mID(i, iNStRReV(i, "/") + 1)
eND iF
b = rEPlACe(b, g, a & g)
eND iF
eND iF
nEXt
c = gETiMGjSUrL(b, "不重复") & vBCrLF & gEThTMlBAcKGrOUnDImGLiST(b)
f = sPLiT(c, vBCrLF)
fOR eACh g iN f
iF g <> "" tHEn
j = fALsE
iF lEFt(g, 1) = "\" tHEn
eLSeIF iNStR(g, ".") > 0 aND lEFt(g, 5) <> "HTTP:" aND iNStR(g, "{$#") = fALsE tHEn
j = tRUe
eND iF
iF j = tRUe tHEn
h = a & rEMoVEfILeDIr(g)
b = rEPlACe(b, """" & g & """", """" & h & """")
b = rEPlACe(b, "'" & g & "'", """" & h & """")
b = rEPlACe(b, "=" & g & " ", """" & h & """")
b = rEPlACe(b, "=" & g & ">", """" & h & """")
eND iF
eND iF
nEXt
hANdLEcUTdIVcODe = b
eND fUNcTIoN
fUNcTIoN gEThTMlBAcKGrOUnDImGLiST(bYVaL a)
a = gETaRRaY(a, " background=""", """", fALsE, fALsE)
a = rEPlACe(a, "$Array$", vBCrLF)
gEThTMlBAcKGrOUnDImGLiST = a
eND fUNcTIoN
fUNcTIoN gEThANdLEwEBhTMlLInK(a, b)
dIM c, d, e, f, g, h, i, j
c = "<link "
j = ""
d = ">"
e = gETaRRaY(b, c, d, fALsE, fALsE)
f = sPLiT(e, "$Array$")
fOR eACh h iN f
iF h <> "" aND iNStR(lCAsE(h), "stylesheet") > 0 tHEn
h = lCAsE(rEPlACe(rEPlACe(rEPlACe(h, """", ""), "'", ""), ">", " ")) & " "
c = "href=" : d = " "
iF iNStR(h, c) > 0 aND iNStR(h, d) > 0 tHEn
h = sTRcUT(h, c, d, 2)
eND iF
i = hANdLEhTTpURl(h)
iF iNStR(i, "/") > 0 tHEn
i = mID(i, iNStRReV(i, "/") + 1)
eND iF
iF lCAsE(i) <> "common.css" aND lCAsE(i) <> "public.css" tHEn
i = a & i
j = j & "<link href=""" & i & """ rel=""stylesheet"" type=""text/css"" />" & vBCrLF
eND iF
eND iF
nEXt
iF j <> "" tHEn j = lEFt(j, lEN(j) - 2)
gEThANdLEwEBhTMlLInK = j
eND fUNcTIoN
fUNcTIoN gETcSSlIStURlLIsT(a)
dIM b, c, d, e, f, g, h, i
b = "<link "
h = ""
c = ">"
d = gETaRRaY(a, b, c, fALsE, fALsE)
e = sPLiT(d, "$Array$")
fOR eACh g iN e
iF g <> "" aND iNStR(lCAsE(g), "stylesheet") > 0 tHEn
g = lCAsE(rEPlACe(rEPlACe(rEPlACe(g, """", ""), "'", ""), ">", " ")) & " "
b = "href=" : c = " "
iF iNStR(g, b) > 0 aND iNStR(g, c) > 0 tHEn
g = sTRcUT(g, b, c, 2)
eND iF
iF iNStR(vBCrLF & i & vBCrLF, vBCrLF & g & vBCrLF) = fALsE tHEn
iF i <> "" tHEn i = i & vBCrLF
i = i & g & vBCrLF
eND iF
eND iF
nEXt
gETcSSlIStURlLIsT = i
eND fUNcTIoN
fUNcTIoN hANdLErEAdCSsCOnTEnT(a, b, c)
dIM d, e, f
d = gETfTExT(a)
e = "/*CssCodeStart*/"
f = "/*CssCodeEnd*/"
iF iNStR(d, e) > 0 aND iNStR(d, f) > 0 tHEn
d = sTRcUT(d, e, f, 2)
eND iF
iF c = tRUe tHEn
d = cSScOMpREsSIoN(d, 0)
eND iF
iF b <> "" tHEn
d = "/*" & b & " start*/" & d & "/*" & b & " end*/"
eND iF
hANdLErEAdCSsCOnTEnT = d
eND fUNcTIoN
fUNcTIoN hANdLEcSSpX(bYVaL a)
a = lCAsE(tRIm(a))
iF rIGhT(a, 1) <> "%" aND rIGhT(a, 2) <> "px" tHEn
a = a & "px"
eND iF
hANdLEcSSpX = a
eND fUNcTIoN
fUNcTIoN hANdLEhTMlSTyLE(a)
dIM b, c, d
b = a
d = iNStR(lCAsE(b), "</style>") + 7
b = mID(b, 1, d)
d = iNStRReV(lCAsE(b), "<style")
iF d > 0 tHEn
b = mID(b, d)
eND iF
c = b
c = cSScOMpREsSIoN(c, 0) & vBCrLF
c = rEMoVEbLAnKLiNEs(c)
a = rEPlACe(a, b, c)
hANdLEhTMlSTyLE = a
eND fUNcTIoN
%>


