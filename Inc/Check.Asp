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
fUNcTIoN iSUcASe(a)
dIM b, c
iSUcASe = tRUe
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("ABCDEFGHIJKLMNOPQRSTUVWXYZ", c) = fALsE tHEn
iSUcASe = fALsE
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN iSLcASe(a)
dIM b, c
iSLcASe = tRUe
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("abcdefghijklmnopqrstuvwxyz", c) = fALsE tHEn
iSLcASe = fALsE
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
sUB cHEcKErR(a)
iF eRR.nUMbER <> 0 tHEn
cALl eCHo(eRR.nUMbER, "自定义错误信息：" & a & "<br>系统错误信息：" & eRR.dEScRIpTIoN & "<br>最初生成错误的对象或应用程序的名称：" & eRR.sOUrCE)
eND iF
eND sUB
fUNcTIoN sTRtOTrUEfALsE(bYVaL a)
a = tRIm(lCAsE(a))
sTRtOTrUEfALsE = iIF(a = "true", tRUe, fALsE)
eND fUNcTIoN
fUNcTIoN sTRtRUeFAlSEtOInT(bYVaL a)
a = tRIm(lCAsE(a))
sTRtRUeFAlSEtOInT = iIF(a = "true", 1, 0)
eND fUNcTIoN
fUNcTIoN cHEcKVbCRlF(a)
cHEcKVbCRlF = fALsE
iF iNStR(a, vBCrLF) > 0 tHEn cHEcKVbCRlF = tRUe
eND fUNcTIoN
fUNcTIoN cHEcKBr(a)
cHEcKBr = cHEcKVbCRlF(a)
eND fUNcTIoN
fUNcTIoN iSPaRItY(a)
iSPaRItY = ""
iF nOT iSNuMErIC(a) tHEn
iSPaRItY = "这不是一个数字啊"
eXIt fUNcTIoN
eND iF
iF a mOD 2 = 0 tHEn
iSPaRItY = 0
eLSe
iSPaRItY = 1
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKEvAL(a)
oN eRRoR rESuME nEXt
cALl eXEcUTe(a)
iF eRR.nUMbER = 0 tHEn
cHEcKEvAL = tRUe
eLSe
cHEcKEvAL = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN rEPlACe_SqLTeXT(a)
iF iSNuLL(a) tHEn
rEPlACe_SqLTeXT = ""
eXIt fUNcTIoN
eLSe
a = tRIm(a)
a = rEPlACe(a, "'", "''")
a = rEPlACe(a, ";", "；")
a = rEPlACe(a, "--", "—")
a = hTMlENcODe(a)
rEPlACe_SqLTeXT = a
eND iF
eND fUNcTIoN
fUNcTIoN cHKpOSt()
dIM b, c
cHKpOSt = fALsE
b = cSTr(rEQuESt.sERvERvARiABlES("HTTP_REFERER"))
c = cSTr(rEQuESt.sERvERvARiABlES("SERVER_NAME"))
cALl eCHo(b, c)
iF mID(b, 8, lEN(c)) <> c tHEn
cHKpOSt = fALsE
eLSe
cHKpOSt = tRUe
eND iF
eND fUNcTIoN
fUNcTIoN iSMaIL(a)
iSMaIL = tRUe
dIM b
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.pATtERn = "([\.a-zA-Z0-9_-]){2,10}@([a-zA-Z0-9_-]){2,10}(\.([a-zA-Z0-9]){2,}){1,4}$"
iSMaIL = b.tESt(a)
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN iSVaLIdEMaIL(a)
dIM b, c, d, e
iSVaLIdEMaIL = tRUe
b = sPLiT(a, "@")
iF uBOuND(b) <> 1 tHEn iSVaLIdEMaIL = fALsE : eXIt fUNcTIoN
fOR eACh c iN b
iF lEN(c) <= 0 tHEn iSVaLIdEMaIL = fALsE : eXIt fUNcTIoN
fOR d = 1 tO lEN(c)
e = lCAsE(mID(c, d, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz_-.", e) <= 0 aND nOT iSNuMErIC(e) tHEn iSVaLIdEMaIL = fALsE : eXIt fUNcTIoN
nEXt
iF lEFt(c, 1) = "." oR rIGhT(c, 1) = "." tHEn iSVaLIdEMaIL = fALsE : eXIt fUNcTIoN
nEXt
iF iNStR(b(1), ".") <= 0 tHEn iSVaLIdEMaIL = fALsE : eXIt fUNcTIoN
d = lEN(b(1)) - iNStRReV(b(1), ".")
iF d <> 2 aND d <> 3 tHEn iSVaLIdEMaIL = fALsE : eXIt fUNcTIoN
iF iNStR(a, "..") > 0 tHEn iSVaLIdEMaIL = fALsE
eND fUNcTIoN
fUNcTIoN iSCoDE(bYVaL a)
dIM b
b = rEPlACe(a, " ", "")
b = rEPlACe(b, cHR(13), "")
b = rEPlACe(b, cHR(10), "")
b = rEPlACe(b, vBTaB, "")
iSCoDE = iIF(b <> "", tRUe, fALsE)
eND fUNcTIoN
fUNcTIoN cHEcKNuMBeR(bYVaL a)
dIM b, c
iF lEN(a) = 0 tHEn cHEcKNuMBeR = fALsE : eXIt fUNcTIoN
cHEcKNuMBeR = tRUe
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789", lCAsE(c)) = fALsE tHEn
cHEcKNuMBeR = fALsE
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN iSNuMBeR(bYVaL a)
iSNuMBeR = cHEcKNuMBeR(a)
eND fUNcTIoN
fUNcTIoN cHEcKAbC(bYVaL a)
dIM b, c
cHEcKAbC = tRUe
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("abcdefghijklmnopqrstuvwxyz", lCAsE(c)) = fALsE tHEn
cHEcKAbC = fALsE
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN gETlEN(a)
dIM b, c, d
d = 0
fOR b = 1 tO lEN(a)
c = aSC(mID(cSTr(a), b, 1))
iF c < 0 tHEn
d = d + 2
eLSe
d = d + 1
eND iF
nEXt
gETlEN = d
eND fUNcTIoN
fUNcTIoN cHEcKTiME(a)
cHEcKTiME = iIF(iSDaTE(a) = fALsE, fALsE, tRUe)
eND fUNcTIoN
fUNcTIoN iSNuL(bYVaL a)
oN eRRoR rESuME nEXt : iF eRR.nUMbER <> 0 tHEn eRR.cLEaR
iSNuL = fALsE
sELeCT cASe vARtYPe(a)
cASe vBEmPTy, vBNuLL
iSNuL = tRUe : eXIt fUNcTIoN
cASe vBStRInG
iF a = "" tHEn iSNuL = tRUe : eXIt fUNcTIoN
cASe vBObJEcT
sELeCT cASe tYPeNAmE(a)
cASe "Nothing", "Empty"
iSNuL = tRUe : eXIt fUNcTIoN
cASe "Recordset"
iF a.sTAtE = 0 tHEn iSNuL = tRUe : eXIt fUNcTIoN
iF a.bOF aND a.eOF tHEn iSNuL = tRUe : eXIt fUNcTIoN
cASe "Dictionary"
iF a.cOUnT = 0 tHEn iSNuL = tRUe : eXIt fUNcTIoN
eND sELeCT
cASe vBArRAy, 8194, 8204, 8209
iF uBOuND(a) = -1 tHEn iSNuL = tRUe : eXIt fUNcTIoN
eND sELeCT
oN eRRoR gOTo 0
eND fUNcTIoN
fUNcTIoN fOUnDInARr(a, b, c)
dIM d, e
fOUnDInARr = fALsE
iF iNStR(a, c) > 0 tHEn
d = sPLiT(a, c)
fOR e = 0 tO uBOuND(d)
iF lCAsE(tRIm(d(e))) = lCAsE(tRIm(b)) tHEn
fOUnDInARr = tRUe : eXIt fOR
eND iF
nEXt
eLSe
iF lCAsE(tRIm(a)) = lCAsE(tRIm(b)) tHEn fOUnDInARr = tRUe
eND iF
eND fUNcTIoN
%>

