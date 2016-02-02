<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-01-26
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
cLAsS cLS_AB_JSoN
pUBlIC cOLlECtIOn, cOUnT, qUOtEDvARs, kINd, sTReNCoDE
pRIvATe s_ChARsET
pRIvATe sUB cLAsS_iNItIAlIZe
eND sUB
pRIvATe sUB cLAsS_tERmINaTE
sET cOLlECtIOn = nOThINg
eND sUB
pUBlIC pROpERtY lET cHArSEt(bYVaL s)
s_ChARsET = uCAsE(s)
eND pROpERtY
pUBlIC pROpERtY gET cHArSEt()
cHArSEt = s_ChARsET
eND pROpERtY
pUBlIC fUNcTIoN [nEW](bYVaL a)
sET [nEW] = nEW cLS_AB_JSoN
sELeCT cASe lCAsE(a)
cASe "0", "object" [nEW].kINd = 0
cASe "1", "array"  [nEW].kINd = 1
eND sELeCT
eND fUNcTIoN
pRIvATe pROpERtY gET cOUnTEr
cOUnTEr = cOUnT
cOUnT = cOUnT + 1
eND pROpERtY
pUBlIC pROpERtY lET pAIr(bYVaL p, bYVaL v)
iF iSNuLL(p) tHEn p = cOUnTEr
iF vARtYPe(v) = 9 tHEn
iF tYPeNAmE(v) = "Cls_AB_JSON" tHEn
sET cOLlECtIOn(p) = v
eLSe
cOLlECtIOn(p) = v
eND iF
eLSe
cOLlECtIOn(p) = v
eND iF
eND pROpERtY
pUBlIC dEFaULt pROpERtY gET pAIr(bYVaL p)
iF iSNuLL(p) tHEn p = cOUnT - 1
iF iSObJEcT(cOLlECtIOn(p)) tHEn
sET pAIr = cOLlECtIOn(p)
eLSe
pAIr = cOLlECtIOn(p)
eND iF
eND pROpERtY
pUBlIC sUB cLEaN
cOLlECtIOn.rEMoVEaLL
eND sUB
pUBlIC sUB rEMoVE(bYVaL a)
iF cOLlECtIOn.eXIsTS(a) tHEn cOLlECtIOn.rEMoVE a
eND sUB
pUBlIC fUNcTIoN tOJsON(bYVaL a)
dIM b,c,d : c = 0 : d = 0
dIM e, f, g, h, i
dIM j : j = "/"
dIM k : k = "json2.js"	
dIM l : l = j&k
sELeCT cASe vARtYPe(a)
cASe 1
tOJsON = "null"
cASe 7
tOJsON = """" & jSEnCOdE__(cSTr(a)) & """"
cASe 8
sELeCT cASe tYPeNAmE(a)
cASe "IRequest", "IRequestDictionary"
iF a = rEQuESt.qUErYStRInG oR a = rEQuESt.fORm oR a = rEQuESt.cOOkIEs tHEn
e = tRUe
tOJsON = tOJsON & "{"
fOR eACh c iN a
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
tOJsON = tOJsON & iIF(qUOtEDvARs, """" & iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c)) & """", jSEnCOdE__(c)) & ":" & tOJsON(a(c))
nEXt
tOJsON = tOJsON & "}"
eND iF
cASe "JScriptTypeInfo"
iF iSFiLE(l) tHEn
aB.uSE "jsLib"
sET h = aB.h.nEW
h.bASePAtH = j
h.iNC(k)
sET i = h.oBJeCT
tOJsON = i.tOStRInG(a)
sET i = nOThINg
sET h = nOThINg
eLSe
tOJsON = a
eND iF
cASe eLSe
iF a="" tHEn
tOJsON = """"""
eLSe
tOJsON = """" & iIF(sTReNCoDE,jSEnCOdE(a),jSEnCOdE__(a)) & """"
eND iF
eND sELeCT
cASe 9
sELeCT cASe tYPeNAmE(a)
cASe "Nothing","Empty"
tOJsON = "{}"
cASe "Recordset"
iF a.sTAtE = 0 tHEn
tOJsON = "[]"
eLSe
iF iSNuL(a) tHEn
tOJsON = "[]"
eLSe
oN eRRoR rESuME nEXt
sET a = a.cLOnE
oN eRRoR gOTo 0
iF a.rECoRDcOUnT = 1 tHEn
e = tRUe
tOJsON = tOJsON & "[{"
fOR d = 0 tO a.fIElDS.cOUnT-1
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
iF qUOtEDvARs tHEn
tOJsON = tOJsON & """" & iIF(sTReNCoDE,jSEnCOdE(lCAsE(a.fIElDS(d).nAMe)),jSEnCOdE__(lCAsE(a.fIElDS(d).nAMe))) & """:" & tOJsON(a.fIElDS(d).vALuE)
eLSe
tOJsON = tOJsON & iIF(sTReNCoDE,jSEnCOdE(lCAsE(a.fIElDS(d).nAMe)),jSEnCOdE__(lCAsE(a.fIElDS(d).nAMe))) & ":" & tOJsON(a.fIElDS(d).vALuE)
eND iF
nEXt
tOJsON = tOJsON & "}]"
eLSe
f = tRUe
tOJsON = tOJsON & "["
a.mOVeFIrST
dO wHIlE nOT a.eOF
iF f tHEn f = fALsE eLSe tOJsON = tOJsON & ","
e = tRUe
tOJsON = tOJsON & "{"
fOR d = 0 tO a.fIElDS.cOUnT-1
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
iF qUOtEDvARs tHEn
tOJsON = tOJsON & """" & iIF(sTReNCoDE,jSEnCOdE(lCAsE(a.fIElDS(d).nAMe)),jSEnCOdE__(lCAsE(a.fIElDS(d).nAMe))) & """:" & tOJsON(a.fIElDS(d).vALuE)
eLSe
tOJsON = tOJsON & iIF(sTReNCoDE,jSEnCOdE(lCAsE(a.fIElDS(d).nAMe)),jSEnCOdE__(lCAsE(a.fIElDS(d).nAMe))) & ":" & tOJsON(a.fIElDS(d).vALuE)
eND iF
nEXt
tOJsON = tOJsON & "}"
c = c + 1
a.mOVeNExT
lOOp
tOJsON = tOJsON & "]"
eND iF
eND iF
eND iF
cASe "Dictionary", "IRequest", "IRequestDictionary", "IApplicationObject", "ISessionObject"
iF tYPeNAmE(a) = "IRequest" tHEn
dIM m : sET m = sERvER.cREaTEoBJeCT(aB.dICtNAmE)
m.aDD "clientcertificate", a.cLIeNTcERtIFiCAtE
m.aDD "cookies", a.cOOkIEs
m.aDD "form", a.fORm
m.aDD "querystring", a.qUErYStRInG
m.aDD "servervariables", a.sERvERvARiABlES
m.aDD "totalbytes", a.tOTaLByTEs
tOJsON = tOJsON(m)
eLSeIF tYPeNAmE(a) = "IApplicationObject" oR tYPeNAmE(a) = "ISessionObject" tHEn
g = a.cONtENtS.cOUnT
iF g = 0 tHEn
tOJsON = "{}"
eLSe
e = tRUe
tOJsON = tOJsON & "{"
fOR eACh c iN a.cONtENtS
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
tOJsON = tOJsON & iIF(qUOtEDvARs, """" & iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c)) & """", iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c))) & ":" & tOJsON(a(c))
nEXt
tOJsON = tOJsON & "}"
eND iF
eLSeIF tYPeNAmE(a) = "Dictionary" tHEn
g = a.cOUnT
iF g = 0 tHEn
tOJsON = "{}"
eLSe
e = tRUe
tOJsON = tOJsON & "{"
fOR eACh c iN a
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
tOJsON = tOJsON & iIF(qUOtEDvARs, """" & iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c)) & """", iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c))) & ":" & tOJsON(a(c))
nEXt
tOJsON = tOJsON & "}"
eND iF
eLSe
e = tRUe
tOJsON = tOJsON & "{"
fOR eACh c iN a
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
tOJsON = tOJsON & iIF(qUOtEDvARs, """" & iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c)) & """", iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c))) & ":" & tOJsON(a(c))
nEXt
tOJsON = tOJsON & "}"
eND iF
cASe "Cls_AB_JSON"
e = tRUe
tOJsON = tOJsON & iIF(a.kINd, "[", "{")
fOR eACh c iN a.cOLlECtIOn
iF e tHEn e = fALsE eLSe tOJsON = tOJsON & ","
tOJsON = tOJsON & iFThEN(a.kINd=0, iIF(qUOtEDvARs, """" & iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c)) & """", iIF(sTReNCoDE,jSEnCOdE(c),jSEnCOdE__(c))) & ":") & tOJsON(a(c))
nEXt
tOJsON = tOJsON & iIF(a.kINd, "]", "}")
cASe "JScriptTypeInfo"
iF iSFiLE(l) tHEn
aB.uSE "jsLib"
sET h = aB.h.nEW
h.bASePAtH = j
h.iNC(k)
sET i = h.oBJeCT
tOJsON = i.tOStRInG(a)
sET i = nOThINg
sET h = nOThINg
eLSe
tOJsON = "{}"
eND iF
cASe "VBScriptTypeInfo"
tOJsON = "{}"
cASe eLSe
tOJsON = "{}"
eND sELeCT
cASe 11
tOJsON = iIF(a, "true", "false")
cASe 12, 8192, 8204, 8209
tOJsON = rENdERaRRaY(a, 1, "")
cASe 2, 3, 17, 19
tOJsON = cLNg(a)
cASe 4, 5, 6, 14
tOJsON = rEPlACe(cDBl(a), ",", ".")
cASe eLSe
tOJsON = """" & iIF(sTReNCoDE,jSEnCOdE(cSTr(a)),jSEnCOdE__(cSTr(a))) & """"
eND sELeCT
eND fUNcTIoN
fUNcTIoN fIElDToJSoN(a,bYVaL b)
dIM c, d,e,f,g
b = "|" & lCAsE(b) & "|"
c = tRUe
d = d & "{"
wHIlE nOT a.eOF
fOR g = 0 tO a.fIElDS.cOUnT-1
e = a.fIElDS(g).nAMe
f = a.fIElDS(g).vALuE
iF iNStR(b,"|"& lCAsE(e) &"|")>0 tHEn
iF c tHEn c = fALsE eLSe d = d & ","
iF qUOtEDvARs tHEn
d = d & """" & iIF(sTReNCoDE,jSEnCOdE(e),jSEnCOdE__(e)) & """:" & tOJsON(f)
eLSe
d = d & iIF(sTReNCoDE,jSEnCOdE(e),jSEnCOdE__(e)) & ":" & tOJsON(f)
eND iF
eND iF
nEXt
d = d & "}"
a.mOVeNExT:wENd:a.cLOsE
d= "["& d &"]"	
fIElDToJSoN = d
eND fUNcTIoN
pRIvATe fUNcTIoN rENdERaRRaY(bYVaL a, bYVaL b, bYVaL c)
dIM d : d = lBOuND(a, b)
dIM e : e = uBOuND(a, b)
dIM f, g
dIM h : h = ","
rENdERaRRaY = "["
fOR f = d tO e
iF f = e tHEn
h = ""
eND iF
oN eRRoR rESuME nEXt
g = rENdERaRRaY(a, b + 1, c & f & "," )
iF eRR = 9 tHEn
oN eRRoR gOTo 0
rENdERaRRaY = rENdERaRRaY & tOJsON(eVAl("arr(" & c & f & ")")) & h
eLSe
rENdERaRRaY = rENdERaRRaY & g & "" & h
eND iF
nEXt
rENdERaRRaY = rENdERaRRaY & "]"
eND fUNcTIoN
pUBlIC fUNcTIoN jSEnCOdE(bYVaL a)
iF iSNuL(a) tHEn jSEnCOdE = "" : eXIt fUNcTIoN
dIM b, c, d, e, f, g, h
b = aRRaY(&h27,&h22,&h5C,&h2F,&h08,&h0C,&h0A,&h0D,&h09)
c = aRRaY(&h27,&h22,&h5C,&h2F,&h62,&h66,&h6E,&h72,&h749)
fOR d = 1 tO lEN(a)
g = tRUe
f = mID(a, d, 1)
fOR e = 0 tO uBOuND(b)
iF f = cHR(b(e)) tHEn
h = h & "\" & cHR(c(e))
g = fALsE
eXIt fOR
eND iF
nEXt
iF g tHEn
dIM i
i = aSCw(f)
iF i > 31 aND i < 127 tHEn
h = h & f
eLSeIF i > -1 oR i < 65535 tHEn
h = h & "\u" & sTRiNG(4 - lEN(hEX(i)), "0") & hEX(i)
eND iF
eND iF
nEXt
jSEnCOdE = h
eND fUNcTIoN
pRIvATe fUNcTIoN jSEnCOdE__(bYVaL a)
iF iSNuL(a) tHEn jSEnCOdE__ = "" : eXIt fUNcTIoN
dIM b, c, d, e, f, g, h
b = aRRaY(&h27,&h22,&h5C,&h2F,&h08,&h0C,&h0A,&h0D,&h09)
c = aRRaY(&h27,&h22,&h5C,&h2F,&h62,&h66,&h6E,&h72,&h749)
fOR d = 1 tO lEN(a)
g = tRUe
f = mID(a, d, 1)
fOR e = 0 tO uBOuND(b)
iF f = cHR(b(e)) tHEn
h = h & "\" & cHR(c(e))
g = fALsE
eXIt fOR
eND iF
nEXt
iF g tHEn h = h & f
nEXt
jSEnCOdE__ = h
eND fUNcTIoN
pUBlIC fUNcTIoN sTRiNGiFY(bYVaL a)
sTRiNGiFY = tOJsON(a)
eND fUNcTIoN
pUBlIC pROpERtY gET jSStRInG
jSStRInG = tOJsON(mE)
eND pROpERtY
pUBlIC fUNcTIoN tOObJEcT(bYVaL a)
oN eRRoR rESuME nEXt
iF eRR tHEn eRR.cLEaR
dIM b,c : b = 0 : c = 0
dIM d, e, f, g
dIM h : h = aB.bASePAtH & "jsLib/core/"
dIM i : i = "json2.js"
dIM j : j = h&i
sELeCT cASe vARtYPe(a)
cASe 9
sET tOObJEcT = a
cASe 8
sELeCT cASe tYPeNAmE(a)
cASe "JScriptTypeInfo"
iF iSFiLE(j) tHEn
aB.uSE "jsLib"
sET e = aB.e.nEW
e.bASePAtH = h
e.iNC(i)
sET f = e.oBJeCT
iF iSObJEcT(f.tOObJEcT(a)) tHEn sET tOObJEcT = f.tOObJEcT(a) eLSe tOObJEcT = f.tOObJEcT(a)
sET f = nOThINg
sET e = nOThINg
eLSe
tOObJEcT = a
eND iF
cASe "String"
iF lCAsE(a) = "null" tHEn
tOObJEcT = nULl
eLSeIF lCAsE(a) = "empty" tHEn
tOObJEcT = eMPtY
eLSeIF a = "" oR a = """""" tHEn
tOObJEcT = ""
eLSeIF lCAsE(a) = "nothing" tHEn
sET tOObJEcT = nOThINg
eLSeIF lCAsE(a) = "true" oR lCAsE(a) = "false" tHEn
tOObJEcT = cBOoL(a)
eLSeIF iSInT(a) tHEn
tOObJEcT = cLNg(a)
eLSeIF tESt(a,"double") tHEn
tOObJEcT = cDBl(a)
eLSeIF tESt(a,"date") tHEn
tOObJEcT = cDAtE(a)
eLSe
aB.uSE "Sc"
sET d = aB.d.nEW
d.lANg = "js"
d.aDD "var jsonObject = " & a & ";"
iF iSObJEcT(d.cODeOBjECt.jSOnOBjECt) tHEn sET tOObJEcT = d.cODeOBjECt.jSOnOBjECt eLSe sET tOObJEcT = nOThINg
eND iF
cASe eLSe
iF iSObJEcT(mE.jSEvAL(a)) tHEn sET g = mE.jSEvAL(a) eLSe g = mE.jSEvAL(a)
iF iSObJEcT(g) tHEn sET tOObJEcT = g eLSe tOObJEcT = g
eND sELeCT
cASe eLSe
iF iSObJEcT(mE.jSEvAL(a)) tHEn sET g = mE.jSEvAL(a) eLSe g = mE.jSEvAL(a)
iF iSObJEcT(g) tHEn sET tOObJEcT = g eLSe tOObJEcT = g
eND sELeCT
iF eRR tHEn : tOObJEcT = a : eRR.cLEaR : eND iF
oN eRRoR gOTo 0
eND fUNcTIoN
pUBlIC fUNcTIoN pARsE(bYVaL a)
iF iSObJEcT(tOObJEcT(a)) tHEn sET pARsE = tOObJEcT(a) eLSe pARsE = tOObJEcT(a)
eND fUNcTIoN
pUBlIC sUB sETjSArRAyITeM(bYReF a, bYVaL b, bYVaL c)
oN eRRoR rESuME nEXt
aB.uSE "Sc"
dIM d : sET d = aB.d.nEW
d.lANg = "js"
d.aDD "var itemTemp=null; function setJSArray(arr, index){try { itemTemp = arr[index]; } catch(e) { itemTemp = null; }}"
d.rUN "setJSArray", aRRaY(b, c)
sET a = d.cODeOBjECt.iTEmTEmP
iF eRR.nUMbER=0 tHEn
eXIt sUB
eND iF
a = d.cODeOBjECt.iTEmTEmP
oN eRRoR gOTo 0
eND sUB
pUBlIC fUNcTIoN gETjSArRAyITeM(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
aB.uSE "Sc"
dIM c : sET c = aB.c.nEW
c.lANg = "js"
c.aDD "function getJSArray(arr, index){var temp=null; try { temp = arr[index]; } catch(e) {} return temp;}"
iF iSObJEcT(c.rUN("getJSArray", aRRaY(a, b))) tHEn
sET gETjSArRAyITeM = c.rUN("getJSArray", aRRaY(a, b))
eLSe
gETjSArRAyITeM = c.rUN("getJSArray", aRRaY(a, b))
eND iF
oN eRRoR gOTo 0
eND fUNcTIoN
pUBlIC fUNcTIoN jSEvAL(bYVaL a)
oN eRRoR rESuME nEXt
iF eRR tHEn eRR.cLEaR
dIM b, c, d, e
aB.uSE "Sc"
sET b = aB.b.nEW
b.lANg = "js"
b.aDD "function toEval(str) { var _temp = null; try { eval('_temp = (' + str + ');'); } catch(e) { _temp = null; } return (_temp);}"
sET d = b.oBJeCT
iF iSObJEcT(d.tOEvAL(a)) tHEn sET jSEvAL = d.tOEvAL(a) eLSe jSEvAL = d.tOEvAL(a)
sET d = nOThINg
sET b = nOThINg
iF eRR.nUMbER <> 0 tHEn : eRR.cLEaR : jSEvAL = a : eND iF
oN eRRoR gOTo 0
eND fUNcTIoN
pUBlIC fUNcTIoN vBEvAL(bYVaL a)
oN eRRoR rESuME nEXt
iF eRR tHEn eRR.cLEaR
iF iSObJEcT(eVAl(a)) tHEn sET vBEvAL = eVAl(a) eLSe vBEvAL = eVAl(a)
iF eRR.nUMbER <> 0 tHEn : eRR.cLEaR : vBEvAL = a : eND iF
oN eRRoR gOTo 0
eND fUNcTIoN
pUBlIC fUNcTIoN jSArRAyTOvBArRAy(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c
iF tYPeNAmE(a) = "JScriptTypeInfo" tHEn
b = a.jOIn("{@Lx.Split@}")
c = sPLiT(b, "{@Lx.Split@}")
eND iF
jSArRAyTOvBArRAy = c
oN eRRoR gOTo 0
eND fUNcTIoN
pUBlIC fUNcTIoN vBArRAyTOjSArRAy(bYVaL a)
oN eRRoR rESuME nEXt
aB.uSE "Sc"
dIM b : sET b = aB.sC.nEW
b.lANg = "js"
dIM c : sET c = b.mODuLEs.aDD("NewModule")
c.aDDcODe "function jsVBArrayToJSArray(vbArr){ var temp = new VBArray(vbArr); return temp.toArray(); }"
dIM d : sET d = c.cODeOBjECt
iF iSObJEcT(d.jSVbARrAYtOJsARrAY(a)) tHEn
sET vBArRAyTOjSArRAy = d.jSVbARrAYtOJsARrAY(a)
eLSe
vBArRAyTOjSArRAy = d.jSVbARrAYtOJsARrAY(a)
eND iF
oN eRRoR gOTo 0
eND fUNcTIoN
pUBlIC sUB fLUsH
rESpONsE.cLEaR()
rESpONsE.cHArSEt = s_ChARsET
rESpONsE.cONtENtTYpE = "application/json"
nOCaCHe()
iF tYPeNAmE(rESpONsE) <> "Empty" tHEn
pUT jSStRInG
eLSeIF wSCrIPt <> eMPtY tHEn
wSCrIPt.eCHo(jSStRInG)
eND iF
eND sUB
pUBlIC fUNcTIoN cLOnE
sET a = cOLcLOnE(mE)
eND fUNcTIoN
pUBlIC fUNcTIoN jSObJEcT
sET a = aB.jSOn.nEW(0)
eND fUNcTIoN
pUBlIC fUNcTIoN jSArRAy
sET a = aB.jSOn.nEW(1)
eND fUNcTIoN
pUBlIC fUNcTIoN tOStR(bYVaL a)
tOStR = aB.jSOn.tOJsON(a)
eND fUNcTIoN
pUBlIC fUNcTIoN qUErYToJSoN(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
dIM c, d, e, f
sET d = jSArRAy()
iF nOT iSObJEcT(a) oR tYPeNAmE(a)<>"Connection" tHEn:eRR.cLEaR:sET qUErYToJSoN=d:eXIt fUNcTIoN:eND iF
sET c = a.eXEcUTe(b)
iF eRR.nUMbER<>0 tHEn : eRR.cLEaR : sET qUErYToJSoN = d : eXIt fUNcTIoN : eND iF
dIM g : g = 0
dO wHIlE nOT (c.eOF oR c.bOF)
sET f = jSObJEcT()
d(g) = f
fOR eACh e iN c.fIElDS
d(g)(e.nAMe) = e.vALuE
nEXt
g = g + 1
sET f = nOThINg
c.mOVeNExT
lOOp
c.cLOsE : sET c = nOThINg
sET qUErYToJSoN = d
oN eRRoR gOTo 0
eND fUNcTIoN
pRIvATe fUNcTIoN cOLcLOnE(bYVaL a)
dIM b, c
sET b = nEW cLS_AB_JSoN
b.kINd = a.kINd
fOR eACh c iN a.cOLlECtIOn
iF iSObJEcT(a(c)) tHEn
sET b(c) = cOLcLOnE(a(c))
eLSe
b(c) = a(c)
eND iF
nEXt
sET cOLcLOnE = b
eND fUNcTIoN
pRIvATe fUNcTIoN eSCaPE__(bYVaL a)
dIM b, c, d
b = &h22
c = &h5C
d = &h2F
dIM e, f, g
fOR e = 1 tO (lEN(a))
f = mID(a, e, 1)
iF aSCw(f) > &h00 aND aSCw(f) < &h1F tHEn
f = eSCaPEqUEnCE(f)
eLSeIF aSCw(f) >= &hC280 aND aSCw(f) <= &hC2bF tHEn
f = "\u00" + rIGhT(pADlEFt(hEX(aSCw(f) - &hC200), 2, 0), 2)
eLSeIF aSCw(f) >= &hC380 aND aSCw(f) <= &hC3bF tHEn
f = "\u00" + rIGhT(pADlEFt(hEX(aSCw(f) - &hC2c0), 2, 0), 2)
eLSe
sELeCT cASe aSCw(f)
cASe b: f = eSCaPEqUEnCE(f)
cASe c: f = eSCaPEqUEnCE(f)
cASe d: f = eSCaPEqUEnCE(f)
eND sELeCT
eND iF
g = g & f
nEXt
eSCaPE__ = g
eND fUNcTIoN
pRIvATe fUNcTIoN eSCaPEqUEnCE(bYVaL a)
eSCaPEqUEnCE = "\u00" + rIGhT(pADlEFt(hEX(aSCw(a)), 2, 0), 2)
eND fUNcTIoN
pRIvATe fUNcTIoN pADlEFt(bYVaL a, bYVaL b, bYVaL c)
pADlEFt = rIGhT(cLOnEIt(c, b) & a, b)
eND fUNcTIoN
pRIvATe fUNcTIoN cLOnEIt(bYVaL a, bYVaL b)
dIM c:fOR c = 1 tO b : cLOnEIt = cLOnEIt & a : nEXt
eND fUNcTIoN
eND cLAsS
%>
