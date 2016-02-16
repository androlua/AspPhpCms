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
<!--#iNClUDe fILe = "Inc/Config.Asp"-->
<!--#iNClUDe fILe = "inc/admin_function.Asp"--><%
dIM cODe
dIM wEBfOLdERnAMe
dIM mODuLErEPlACeARrAY(99, 99)
cALl oPEnCOnN()
dIM wEBuRLfILePAtH
dIM wEBuRLpREfIX
dIM tEMpLAtENaME
dIM eDItORtYPe : eDItORtYPe = "asp"
dIM dB_pREfIX : dB_pREfIX = "xy_"
dIM cFG_WEbSItEUrL, cFG_WEbTEmPLaTE, cFG_WEbIMaGEs, cFG_WEbCSs, cFG_WEbJS, cFG_WEbTItLE, cFG_WEbKEyWOrDS, cFG_WEbDEsCRiPTiON, cFG_WEbSItEBoTToM, cFG_FLaGS
dIM gBL_COlUMnNAmE, gBL_COlUMnID, gBL_ID, gBL_COlUMnTYpE, gBL_COlUMnENtYPe, gBL_TAbLE, gBL_DEtAIlTItLE, gBL_FLaGS
dIM wEBtEMpLAtE
dIM gBL_URl, gBL_FIlEPaTH
dIM gBL_ISoNHtML
dIM gBL_BOdYCoNTeNT
dIM iSMaKEhTMl
fUNcTIoN hANdLEaCTiON(a)
dIM b, c, d, e, f, g, h
b = "{\$" : c = "\$}"
d = gETaRRaY(a, b, c, tRUe, tRUe)
e = sPLiT(d, "$Array$")
fOR eACh g iN e
f = tRIm(g)
f = hANdLEiNMoDUlE(f, "start")
iF f <> "" tHEn
f = tRIm(mID(f, 3, lEN(f) - 4)) & " "
h = tRUe
iF cHEcKFuNVaLUe(f, "# ") = tRUe tHEn
f = ""
eLSeIF cHEcKFuNVaLUe(f, "GetLableValue ") = tRUe tHEn
f = xY_gETlABlEVaLUe(f)
eLSeIF cHEcKFuNVaLUe(f, "Include ") = tRUe tHEn
f = xY_iNClUDe(f)
eLSeIF cHEcKFuNVaLUe(f, "CustomNavList ") = tRUe tHEn
f = xY_pHP_NAvLIsT(f)
eLSeIF cHEcKFuNVaLUe(f, "DetailList ") = tRUe tHEn
f = xY_pHP_DEtAIlLIsT(f)
eLSeIF cHEcKFuNVaLUe(f, "CommentList ") = tRUe tHEn
f = xY_pHP_COmMEnTLiST(f)
eLSeIF cHEcKFuNVaLUe(f, "MainInfo ") = tRUe tHEn
f = xY_pHP_SInGLePAgE(f)
eLSeIF cHEcKFuNVaLUe(f, "GetColumnContent ") = tRUe tHEn
f = xY_pHP_GEtCOlUMnCOnTEnT(f)
eLSeIF cHEcKFuNVaLUe(f, "Layout ") = tRUe tHEn
f = xY_lAYoUT(f)
eLSeIF cHEcKFuNVaLUe(f, "Module ") = tRUe tHEn
f = xY_mODuLE(f)
eLSeIF cHEcKFuNVaLUe(f, "GetColumnUrl ") = tRUe tHEn
f = xY_gETcOLuMNuRL(f)
eLSeIF cHEcKFuNVaLUe(f, "GetOnePageUrl ") = tRUe tHEn
f = xY_gEToNEpAGeURl(f)
eLSeIF cHEcKFuNVaLUe(f, "DisplayWrap ") = tRUe tHEn
f = xY_dISpLAyWRaP(f)
eLSeIF cHEcKFuNVaLUe(f, "ReadColumeSetTitle ") = tRUe tHEn
f = xY_rEAdCOlUMeSEtTItLE(f)
eLSeIF cHEcKFuNVaLUe(f, "displayEditor ") = tRUe tHEn
f = dISpLAyEDiTOr(f)
eLSeIF cHEcKFuNVaLUe(f, "JsWebStat ") = tRUe tHEn
f = xY_jSWeBStAT(f)
eLSeIF cHEcKFuNVaLUe(f, "XorEnc ") = tRUe tHEn
f = xOReNC(nOW(), 31380)
eLSeIF cHEcKFuNVaLUe(f, "copyTemplateMaterial ") = tRUe tHEn
f = ""
eLSeIF cHEcKFuNVaLUe(f, "clearCache ") = tRUe tHEn
f = ""
eLSe
h = fALsE
eND iF
iF iSNuL(f) = tRUe tHEn f = ""
iF h = tRUe tHEn
a = rEPlACe(a, g, f)
eND iF
eND iF
nEXt
hANdLEaCTiON = a
eND fUNcTIoN
fUNcTIoN xY_dISpLAyWRaP(bYVaL a)
dIM b
b = gETdEFaULtVAlUE(a)
xY_dISpLAyWRaP = b
eND fUNcTIoN
fUNcTIoN xY_gETcOLuMNuRL(a)
dIM b, c
b = rPArAM(a, "columnName")
c = gETcOLuMNuRL(b, "name")
iF rEQuESt("gl") <> "" tHEn
c = c & "&gl=" & rEQuESt("gl")
eND iF
xY_gETcOLuMNuRL = c
eND fUNcTIoN
fUNcTIoN xY_gEToNEpAGeURl(a)
dIM b, c
b = rPArAM(a, "title")
c = gEToNEpAGeURl(b)
iF rEQuESt("gl") <> "" tHEn
c = c & "&gl=" & rEQuESt("gl")
eND iF
xY_gEToNEpAGeURl = c
eND fUNcTIoN
fUNcTIoN xY_gETlABlEVaLUe(a)
dIM b, c, d
b = rPArAM(a, "title")
c = rPArAM(a, "content")
d = d & "title=" & gETcONtENtRUnSTr(b) & "<hr>"
d = d & "content=" & gETcONtENtRUnSTr(c) & "<hr>"
xY_gETlABlEVaLUe = d
cALl eCHo("title", b)
xY_gETlABlEVaLUe = "【title=】【" & b & "】"
eND fUNcTIoN
fUNcTIoN rEPlACeGLoBLeVArIAbLE(bYVaL a)
a = hANdLErGV(a, "[$cfg_webSiteUrl$]", cFG_WEbSItEUrL)
a = hANdLErGV(a, "[$cfg_webTemplate$]", cFG_WEbTEmPLaTE)
a = hANdLErGV(a, "[$cfg_webImages$]", cFG_WEbIMaGEs)
a = hANdLErGV(a, "[$cfg_webCss$]", cFG_WEbCSs)
a = hANdLErGV(a, "[$cfg_webJs$]", cFG_WEbJS)
a = hANdLErGV(a, "[$cfg_webTitle$]", cFG_WEbTItLE)
a = hANdLErGV(a, "[$cfg_webKeywords$]", cFG_WEbKEyWOrDS)
a = hANdLErGV(a, "[$cfg_webDescription$]", cFG_WEbDEsCRiPTiON)
a = hANdLErGV(a, "[$cfg_webSiteBottom$]", cFG_WEbSItEBoTToM)
a = hANdLErGV(a, "[$gbl_columnId$]", gBL_COlUMnID)
a = hANdLErGV(a, "[$gbl_columnName$]", gBL_COlUMnNAmE)
a = hANdLErGV(a, "[$gbl_columnType$]", gBL_COlUMnTYpE)
a = hANdLErGV(a, "[$gbl_columnENType$]", gBL_COlUMnENtYPe)
a = hANdLErGV(a, "[$gbl_Table$]", gBL_TAbLE)
a = hANdLErGV(a, "[$gbl_Id$]", gBL_ID)
a = hANdLErGV(a, "[$WebImages$]", cFG_WEbIMaGEs)
a = hANdLErGV(a, "[$WebCss$]", cFG_WEbCSs)
a = hANdLErGV(a, "[$WebJs$]", cFG_WEbJS)
a = hANdLErGV(a, "{$Web_Title$}", cFG_WEbTItLE)
a = hANdLErGV(a, "{$Web_KeyWords$}", cFG_WEbKEyWOrDS)
a = hANdLErGV(a, "{$Web_Description$}", cFG_WEbDEsCRiPTiON)
a = hANdLErGV(a, "{$EDITORTYPE$}", eDItORtYPe)
rEPlACeGLoBLeVArIAbLE = a
eND fUNcTIoN
fUNcTIoN hANdLErGV(bYVaL a, b, c)
a = rEPlACe(a, b, c)
a = rEPlACe(a, lCAsE(b), c)
iF iNStR(b, "{") > 0 tHEn
b = rEPlACe(rEPlACe(b, "{", "["), "}", "]")
eLSe
b = rEPlACe(rEPlACe(b, "[", "{"), "]", "}")
eND iF
a = rEPlACe(a, b, c)
a = rEPlACe(a, lCAsE(b), c)
hANdLErGV = a
eND fUNcTIoN
sUB lOAdWEbCOnFIg()
dIM b
cALl oPEnCOnN()
rS.oPEn "select * from " & dB_pREfIX & "website", cONn, 1, 1
iF nOT rS.eOF tHEn
cFG_WEbSItEUrL = pHPtRIm(rS("webSiteUrl"))
cFG_WEbTEmPLaTE = pHPtRIm(rS("webTemplate"))
cFG_WEbIMaGEs = pHPtRIm(rS("webImages"))
cFG_WEbCSs = pHPtRIm(rS("webCss"))
cFG_WEbJS = pHPtRIm(rS("webJs"))
cFG_WEbTItLE = rS("webTitle")
cFG_WEbKEyWOrDS = rS("webKeywords")
cFG_WEbDEsCRiPTiON = rS("webDescription")
cFG_WEbSItEBoTToM = rS("webSiteBottom")
cFG_FLaGS = rS("flags")
iF rEQuESt("templatedir") <> "" tHEn
b = hANdLEhTTpURl(rEPlACe(rEQuESt("templatedir"), hANdLEpATh("/"), "/"))
cFG_WEbIMaGEs = rEPlACe(cFG_WEbIMaGEs, cFG_WEbTEmPLaTE, b)
cFG_WEbCSs = rEPlACe(cFG_WEbCSs, cFG_WEbTEmPLaTE, b)
cFG_WEbJS = rEPlACe(cFG_WEbJS, cFG_WEbTEmPLaTE, b)
cFG_WEbTEmPLaTE = b
eND iF
wEBtEMpLAtE = cFG_WEbTEmPLaTE
eND iF : rS.cLOsE
eND sUB
fUNcTIoN tHIsPOsITiON(a)
dIM b
b = "<a href=""/"">首页</a>"
iF gBL_COlUMnNAmE <> "" tHEn
b = b & " >> <a href=""" & gETcOLuMNuRL(gBL_COlUMnNAmE, "name") & """>" & gBL_COlUMnNAmE & "</a>"
eND iF
a = rEPlACe(a, "[$detailPosition$]", b)
a = rEPlACe(a, "[$detailTitle$]", gBL_DEtAIlTItLE)
a = rEPlACe(a, "[$detailContent$]", gBL_BOdYCoNTeNT)
tHIsPOsITiON = a
eND fUNcTIoN
fUNcTIoN gETdETaILlISt(a, b, c, d, bYVaL e, f, g, h)
cALl oPEnCOnN()
dIM i, j, k, l, m, n, o, p
dIM q, r, s
dIM t
dIM u
dIM v
dIM w
m = lCAsE(c)
dIM x
x = rPArAM(a, "listFileName")
dIM y
y = rQ("id")
iF e = "*" tHEn
e = lCAsE(gETfIElDLiST(dB_pREfIX & m))
eND iF
e = sPEcIAlSTrREpLAcE(e)
v = sPLiT(e, ",")
b = rEPlACe(b, "{$lableTitle$}", d)
b = rEPlACe(b, "{$actionName$}", c)
b = rEPlACe(b, "{$lableTitle$}", d)
b = rEPlACe(b, "{$tableName$}", m)
b = rEPlACe(b, "{$nPageSize$}", f)
b = rEPlACe(b, "{$page$}", rEQuESt("page"))
b = rEPlACe(b, "{$nPageSize" & f & "$}", " selected")
fOR j = 1 tO 9
b = rEPlACe(b, "{$nPageSize" & j & "0$}", "")
nEXt
i = gETsTRcUT(b, "[list]", "[/list]", 2)
iF "ASP" = "ASP" tHEn
rS.oPEn "select * from " & dB_pREfIX & m & " " & h, cONn, 1, 1
s = rS.rECoRDcOUnT
q = gETrSPaGEnUMbER(rS, s, f, g)
fOR j = 1 tO q
k = i
fOR p = 1 tO 3
k = rEPlACe(k, "[$id$]", rS("id"))
fOR n = 0 tO uBOuND(v)
iF v(n) <> "" tHEn
o = sPLiT(v(n) & "|||", "|")
u = o(0)
w = rS(u) & ""
k = rEPlACeVAlUEpARaM(k, u, w)
eND iF
iF iSMaKEhTMl = tRUe tHEn
r = gETrSUrL(rS("fileName"), rS("customAUrl"), "/html/detail" & rS("id"))
eLSe
r = hANdLEwEBuRL("?act=detail&id=" & rS("id"))
iF rS("customAUrl") <> "" tHEn
r = rS("customAUrl")
eND iF
eND iF
k = rEPlACeVAlUEpARaM(k, "url", r)
nEXt
nEXt
r = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rS("id") & "&n=" & gETrND(11)
k = hANdLEdISpLAyONlINeEDiTDiALoG(r, k, "", "div|li|span")
l = l & k
rS.mOVeNExT : nEXt : rS.cLOsE
b = rEPlACe(b, "[list]" & i & "[/list]", l)
iF iSMaKEhTMl = tRUe tHEn
r = ""
iF lEN(x) > 5 tHEn
r = mID(x, 1, lEN(x) - 5) & "[id].html"
r = uRLaDDhTTpURl(cFG_WEbSItEUrL, r)
eND iF
eLSe
r = gETuRLaDDtOPaRAm(gETuRL(), "?page=[id]", "replace")
eND iF
b = rEPlACe(b, "[$pageInfo$]", wEBpAGeCOnTRoL(s, f, g, r))
eLSe
rS.oPEn "select * from " & dB_pREfIX & m & " " & h, cONn, 1, 1
s = rS.rECoRDcOUnT
pAGe = rEQuESt("page")
r = gETuRLaDDtOPaRAm(gETuRL(), "?page=[id]", "replace")
b = rEPlACe(b, "[$pageInfo$]", wEBpAGeCOnTRoL(s, f, pAGe, r))
iF pAGe <> "" tHEn
pAGe = pAGe - 1
eND iF
rS.oPEn "select * from " & dB_pREfIX & m & " " & h & " limit " & f * pAGe & "," & f & "", cONn, 1, 1
wHIlE nOT rS.eOF
k = i
fOR p = 1 tO 3
k = rEPlACe(k, "[$id$]", rS("id"))
k = rEPlACe(k, "[$phpArray$]", "")
fOR n = 0 tO uBOuND(v)
iF v(n) <> "" tHEn
o = sPLiT(v(n) & "|||", "|")
u = o(0)
w = rS(u) & ""
k = rEPlACeVAlUEpARaM(k, u, w)
eND iF
iF iSMaKEhTMl = tRUe tHEn
r = gETrSUrL(rS("fileName"), rS("customAUrl"), "/html/detail" & rS("id"))
eLSe
r = hANdLEwEBuRL("?act=detail&id=" & rS("id"))
eND iF
k = rEPlACeVAlUEpARaM(k, "url", r)
nEXt
nEXt
r = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rS("id") & "&n=" & gETrND(11)
k = hANdLEdISpLAyONlINeEDiTDiALoG(r, k, "", "div|li|span")
l = l & k
rS.mOVeNExT : wENd : rS.cLOsE
b = rEPlACe(b, "[list]" & i & "[/list]", l)
eND iF
gETdETaILlISt = b
eND fUNcTIoN
fUNcTIoN dEFaULtLIsTTeMPlATe()
dIM b, c, d, e, f, g
c = gETfTExT(cFG_WEbTEmPLaTE & "/" & tEMpLAtENaME)
e = "[list]"
f = "<!--#" & e & " start#-->"
g = "<!--#" & e & " end#-->"
iF iNStR(c, f) > 0 aND iNStR(c, g) > 0 tHEn
d = sTRcUT(c, f, g, 2)
eLSe
f = "<!--#" & e
g = "#-->"
iF iNStR(c, f) > 0 aND iNStR(c, g) > 0 tHEn
dEFaULtSTr = sTRcUT(c, f, g, 2)
eND iF
eND iF
iF d = "" tHEn
b = "<ul class=""list"">" & vBCrLF
b = b & "[list]    <li><a href=""[$url$]"" target=""[$target$]"">[$title$]</a><span class=""time"">[$adddatetime format_time='7'$]</span></li>" & vBCrLF
b = b & "[/list]" & vBCrLF
b = b & "</ul>" & vBCrLF
b = b & "<div class=""clear10""></div>" & vBCrLF
b = b & "<div>[$pageInfo$]</div>" & vBCrLF
d = b
eND iF
dEFaULtLIsTTeMPlATe = d
eND fUNcTIoN
fUNcTIoN aRItCLeRElATeDTaGS(a)
dIM b, c, d, e
c = sPLiT(a, ",")
fOR eACh d iN c
iF d <> "" tHEn
iF b <> "" tHEn
b = b & ","
eND iF
e = gETcOLuMNuRL(d, "name")
b = b & "<a href=""" & e & """ rel=""category tag"" class=""ablue"">" & d & "</a>" & vBCrLF
eND iF
nEXt
b = "<footer class=""articlefooter"">" & vBCrLF & "标签： " & b & "</footer>" & vBCrLF
aRItCLeRElATeDTaGS = b
eND fUNcTIoN
iF rEQuESt("db_PREFIX") <> "" tHEn
dB_pREfIX = rEQuESt("db_PREFIX")
eLSeIF sESsIOn("db_PREFIX") <> "" tHEn
dB_pREfIX = sESsIOn("db_PREFIX")
eND iF
cALl lOAdWEbCOnFIg()
iSMaKEhTMl = fALsE
iF rEQuESt("isMakeHtml") = "1" oR rEQuESt("isMakeHtml") = "true" tHEn
iSMaKEhTMl = tRUe
eND iF
tEMpLAtENaME = rEQuESt("templateName")
iF rEQuESt("act") = "makehtml" tHEn
cALl eCHo("makehtml", "makehtml")
iSMaKEhTMl = tRUe
cALl mAKeWEbHTmL(" action actionType='" & rEQuESt("act") & "' columnName='" & rEQuESt("columnName") & "' id='" & rEQuESt("id") & "' ")
cALl cREaTEfILe("index.html", cODe)
eLSeIF rEQuESt("act") = "copyHtmlToWeb" tHEn
cALl cOPyHTmLToWEb()
eLSeIF rEQuESt("act") = "makeallhtml" tHEn
cALl mAKeALlHTmL("", "", "")
eLSeIF rEQuESt("isMakeHtml") <> "" aND rEQuESt("isSave") <> "" tHEn
iSMaKEhTMl = tRUe
cALl rW(mAKeWEbHTmL(" action actionType='" & rEQuESt("act") & "' columnName='" & rEQuESt("columnName") & "' columnType='" & rEQuESt("columnType") & "' id='" & rEQuESt("id") & "' npage='" & rEQuESt("page") & "' "))
gBL_FIlEPaTH = rEPlACe(gBL_URl, cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
iF gBL_FIlEPaTH <> "" aND gBL_ISoNHtML = tRUe tHEn
cALl cREaTEdIRfOLdER(gBL_FIlEPaTH)
cALl cREaTEfILe(gBL_FIlEPaTH, cODe)
iF rEQuESt("act") = "detail" tHEn
cONn.eXEcUTe("update " & dB_pREfIX & "ArticleDetail set ishtml=true where id=" & rEQuESt("id"))
eLSeIF rEQuESt("act") = "nav" tHEn
iF rEQuESt("id") <> "" tHEn
cONn.eXEcUTe("update " & dB_pREfIX & "WebColumn set ishtml=true where id=" & rEQuESt("id"))
eLSe
cONn.eXEcUTe("update " & dB_pREfIX & "WebColumn set ishtml=true where columnname='" & rEQuESt("columnName") & "'")
eND iF
eND iF
cALl eCHo("生成文件路径", "<a href=""" & gBL_FIlEPaTH & """ target='_blank'>" & gBL_FIlEPaTH & "</a>")
eND iF
eLSe
iF lCAsE(rEQuESt("issave")) = "1" tHEn
cALl mAKeALlHTmL(rEQuESt("columnType"), rEQuESt("columnName"), rEQuESt("columnId"))
eLSe
cALl rW(mAKeWEbHTmL(" action actionType='" & rEQuESt("act") & "' columnName='" & rEQuESt("columnName") & "' columnType='" & rEQuESt("columnType") & "' id='" & rEQuESt("id") & "' npage='" & rEQuESt("page") & "' "))
eND iF
eND iF
sUB mAKeALlHTmL(a, b, c)
dIM d, e, f, g, h, i, j, k
iSMaKEhTMl = tRUe
cALl eCHo("栏目", "")
iF a <> "" tHEn
j = "where columnType='" & a & "'"
eND iF
iF b <> "" tHEn
j = gETwHErEAnD(j, "where columnName='" & b & "'")
eND iF
iF c <> "" tHEn
j = gETwHErEAnD(j, "where id='" & c & "'")
eND iF
rSS.oPEn "select * from " & dB_pREfIX & "webcolumn " & j & " order by sortrank asc", cONn, 1, 1
wHIlE nOT rSS.eOF
gBL_COlUMnNAmE = ""
iF rSS("isonhtml") = tRUe tHEn
iF rSS("columntype") = "新闻" tHEn	
h=gETrECoRDcOUnT(dB_pREfIX & "articledetail", " where parentid=" & rSS("id"))	
g = rSS("npagesize")
i = gETpAGeNUmB(cINt(h), cINt(g))
fOR f = 1 tO i
k = gETrSUrL(rSS("fileName"), rSS("customAUrl"), "/nav" & rSS("id"))
gBL_FIlEPaTH = rEPlACe(k, cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" oR gBL_FIlEPaTH = "" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
d = " action actionType='nav' columnName='" & rSS("columnname") & "' npage='" & f & "' listfilename='" & gBL_FIlEPaTH & "' "
cALl mAKeWEbHTmL(d)
iF f > 1 tHEn
gBL_FIlEPaTH = mID(gBL_FIlEPaTH, 1, lEN(gBL_FIlEPaTH) - 5) & f & ".html"
eND iF
e = "<a href=""" & gBL_FIlEPaTH & """ target='_blank'>" & gBL_FIlEPaTH & "</a>(" & rSS("isonhtml") & ")"
cALl eCHo(d, e)
iF gBL_FIlEPaTH <> "" tHEn
cALl cREaTEdIRfOLdER(gBL_FIlEPaTH)
cALl cREaTEfILe(gBL_FIlEPaTH, cODe)
eND iF
dOEvENtS()
tEMpLAtENaME = ""
nEXt
eLSe
d = " action actionType='nav' columnName='" & rSS("columnname") & "'"
cALl mAKeWEbHTmL(d)
gBL_FIlEPaTH = rEPlACe(gETcOLuMNuRL(rSS("columnname"), "name"), cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
e = "<a href=""" & gBL_FIlEPaTH & """ target='_blank'>" & gBL_FIlEPaTH & "</a>(" & rSS("isonhtml") & ")"
cALl eCHo(d, e)
iF gBL_FIlEPaTH <> "" tHEn
cALl cREaTEdIRfOLdER(gBL_FIlEPaTH)
cALl cREaTEfILe(gBL_FIlEPaTH, cODe)
eND iF
dOEvENtS()
tEMpLAtENaME = ""
eND iF
cONn.eXEcUTe("update " & dB_pREfIX & "WebColumn set ishtml=true where id=" & rSS("id"))
eND iF
rSS.mOVeNExT : wENd : rSS.cLOsE
iF j = "" tHEn
cALl eCHo("文章", "")
rSS.oPEn "select * from " & dB_pREfIX & "articledetail order by sortrank asc", cONn, 1, 1
wHIlE nOT rSS.eOF
gBL_COlUMnNAmE = ""
d = " action actionType='detail' columnName='" & rSS("parentid") & "' id='" & rSS("id") & "'"
cALl mAKeWEbHTmL(d)
gBL_FIlEPaTH = rEPlACe(gBL_URl, cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
e = "<a href=""" & gBL_FIlEPaTH & """ target='_blank'>" & gBL_FIlEPaTH & "</a>(" & rSS("isonhtml") & ")"
cALl eCHo(d, e)
iF gBL_FIlEPaTH <> "" aND rSS("isonhtml") = tRUe tHEn
cALl cREaTEdIRfOLdER(gBL_FIlEPaTH)
cALl cREaTEfILe(gBL_FIlEPaTH, cODe)
cONn.eXEcUTe("update " & dB_pREfIX & "ArticleDetail set ishtml=true where id=" & rSS("id"))
eND iF
tEMpLAtENaME = ""
rSS.mOVeNExT : wENd : rSS.cLOsE
cALl eCHo("单页", "")
rSS.oPEn "select * from " & dB_pREfIX & "onepage order by sortrank asc", cONn, 1, 1
wHIlE nOT rSS.eOF
gBL_COlUMnNAmE = ""
d = " action actionType='onepage' id='" & rSS("id") & "'"
cALl mAKeWEbHTmL(d)
gBL_FIlEPaTH = rEPlACe(gBL_URl, cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
e = "<a href=""" & gBL_FIlEPaTH & """ target='_blank'>" & gBL_FIlEPaTH & "</a>(" & rSS("isonhtml") & ")"
cALl eCHo(d, e)
iF gBL_FIlEPaTH <> "" aND rSS("isonhtml") = tRUe tHEn
cALl cREaTEdIRfOLdER(gBL_FIlEPaTH)
cALl cREaTEfILe(gBL_FIlEPaTH, cODe)
cONn.eXEcUTe("update " & dB_pREfIX & "onepage set ishtml=true where id=" & rSS("id"))
eND iF
tEMpLAtENaME = ""
rSS.mOVeNExT : wENd : rSS.cLOsE
eND iF
eND sUB
sUB cOPyHTmLToWEb()
dIM b, c, d, e, f, g, h, i, j, k, l, m, n, o
wEBfOLdERnAMe = cFG_WEbTEmPLaTE
iF lEFt(wEBfOLdERnAMe, 1) = "/" tHEn
wEBfOLdERnAMe = mID(wEBfOLdERnAMe, 2)
eND iF
iF rIGhT(wEBfOLdERnAMe, 1) = "/" tHEn
wEBfOLdERnAMe = mID(wEBfOLdERnAMe, 1, lEN(wEBfOLdERnAMe) - 1)
eND iF
iF iNStR(wEBfOLdERnAMe, "/") > 0 tHEn
wEBfOLdERnAMe = mID(wEBfOLdERnAMe, iNStR(wEBfOLdERnAMe, "/") + 1)
eND iF
b = "/htmladmin/" & wEBfOLdERnAMe & "/"
cALl dELeTEfOLdER(b)
cALl cREaTEdIRfOLdER(b)
l = b & "Images/"
m = b & "Css/"
n = b & "Js/"
cALl cOPyFOlDEr(cFG_WEbIMaGEs, l)
cALl cOPyFOlDEr(cFG_WEbCSs, m)
cALl cREaTEfOLdER(n)
i = gETfILeFOlDErLIsT(cFG_WEbCSs, tRUe, "css", "", "", "", "")
h = sPLiT(i, vBCrLF)
fOR eACh d iN h
iF d <> "" tHEn
cALl eCHo("css", d)
i = gETfTExT(d)
i = rEPlACe(i, cFG_WEbIMaGEs, "../")
cALl cREaTEfILe(d, i)
eND iF
nEXt
i = gETfILeFOlDErLIsT(l, tRUe, "js", "", "", "", "")
o = sPLiT(i, vBCrLF)
fOR eACh d iN o
iF d <> "" tHEn
c = n & gETfILeNAmE(d)
cALl eCHo("js", d)
cALl mOVeFIlE(d, c)
eND iF
nEXt
iSMaKEhTMl = tRUe
rSS.oPEn "select * from " & dB_pREfIX & "webcolumn where isonhtml=true", cONn, 1, 1
wHIlE nOT rSS.eOF
gBL_FIlEPaTH = rEPlACe(gETcOLuMNuRL(rSS("columnname"), "name"), cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
iF rIGhT(gBL_FIlEPaTH, 5) = ".html" tHEn
f = f & gBL_FIlEPaTH & vBCrLF
e = rEPlACe(gBL_FIlEPaTH, "/", "_")
c = b & e
cALl cOPyFIlE(gBL_FIlEPaTH, c)
cALl eCHo("导航", gBL_FIlEPaTH)
eND iF
rSS.mOVeNExT : wENd : rSS.cLOsE
rSS.oPEn "select * from " & dB_pREfIX & "articledetail where isonhtml=true", cONn, 1, 1
wHIlE nOT rSS.eOF
gBL_URl = gETrSUrL(rSS("fileName"), rSS("customAUrl"), "/html/detail" & rSS("id"))
gBL_FIlEPaTH = rEPlACe(gBL_URl, cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
iF rIGhT(gBL_FIlEPaTH, 5) = ".html" tHEn
f = f & gBL_FIlEPaTH & vBCrLF
e = rEPlACe(gBL_FIlEPaTH, "/", "_")
c = b & e
cALl cOPyFIlE(gBL_FIlEPaTH, c)
cALl eCHo("文章" & rSS("title"), gBL_FIlEPaTH)
eND iF
rSS.mOVeNExT : wENd : rSS.cLOsE
rSS.oPEn "select * from " & dB_pREfIX & "onepage where isonhtml=true", cONn, 1, 1
wHIlE nOT rSS.eOF
gBL_URl = gETrSUrL(rSS("fileName"), rSS("customAUrl"), "/page/page" & rSS("id"))
gBL_FIlEPaTH = rEPlACe(gBL_URl, cFG_WEbSItEUrL, "")
iF rIGhT(gBL_FIlEPaTH, 1) = "/" tHEn
gBL_FIlEPaTH = gBL_FIlEPaTH & "index.html"
eND iF
iF rIGhT(gBL_FIlEPaTH, 5) = ".html" tHEn
f = f & gBL_FIlEPaTH & vBCrLF
e = rEPlACe(gBL_FIlEPaTH, "/", "_")
c = b & e
cALl cOPyFIlE(gBL_FIlEPaTH, c)
cALl eCHo("单页" & rSS("title"), gBL_FIlEPaTH)
eND iF
rSS.mOVeNExT : wENd : rSS.cLOsE
h = sPLiT(f, vBCrLF)
fOR eACh d iN h
iF d <> "" tHEn
d = b & rEPlACe(d, "/", "_")
cALl eCHo("filePath", d)
i = gETfTExT(d)
i = rEPlACe(i, cFG_WEbSItEUrL, "")
i = rEPlACe(i, cFG_WEbTEmPLaTE, "")
fOR eACh j iN h
i = rEPlACe(i, j, rEPlACe(j, "/", "_"))
nEXt
fOR eACh j iN o
iF j <> "" tHEn
e = gETfILeNAmE(j)
i = rEPlACe(i, "Images/" & e, "js/" & e)
eND iF
nEXt
iF iNStR(i, "/Jquery/Jquery.Min.js") > 0 tHEn
i = rEPlACe(i, "/Jquery/Jquery.Min.js", "js/Jquery.Min.js")
cALl cOPyFIlE("/Jquery/Jquery.Min.js", n & "/Jquery.Min.js")
eND iF
cALl cREaTEfILe(d, i)
eND iF
nEXt
cALl eCHo("webFolderName", wEBfOLdERnAMe)
cALl mAKeHTmLWeBToZIp(b)
eND sUB
fUNcTIoN mAKeHTmLWeBToZIp(a)
dIM b, c, d, e, f, g, h, i
dIM j
b = gETfILeFOlDErLIsT(a, tRUe, "全部", "", "全部文件夹", "", "")
c = sPLiT(b, vBCrLF)
fOR eACh d iN c
iF cHEcKFoLDeR(d) = fALsE tHEn
f = hANdLEfILePAtHArRAy(d)
g = lCAsE(f(2))
h = lCAsE(f(4))
g = rEMoTEnUMbER(g)
i = tRUe
iF iNStR("|" & j & "|", "|" & g & "|") > 0 aND h = "html" tHEn
i = fALsE
eND iF
iF i = tRUe tHEn
iF e <> "" tHEn e = e & "|"
e = e & rEPlACe(d, hANdLEpATh("/"), "")
j = j & g & "|"
eND iF
eND iF
nEXt
cALl rW(e)
e = e & "|||||"
cALl cREaTEfILe("htmladmin/1.txt", e)
cALl eCHo("<hr>cccccccccccc", e)
cALl eCHo("", xMLpOSt("http://127.0.0.1/myZIP.php?webFolderName=" & wEBfOLdERnAMe, "content=" & eSCaPE(e)))
eND fUNcTIoN
fUNcTIoN mAKeWEbHTmL(a)
dIM b, c, d, e, f
b = rPArAM(a, "actionType")
d = rPArAM(a, "npage")
d = gETnUMbER(d)
iF d = "" tHEn
d = 1
eLSe
d = cINt(d)
eND iF
iF b = "nav" tHEn
gBL_COlUMnTYpE = rPArAM(a, "columnType")
gBL_COlUMnNAmE = rPArAM(a, "columnName")
gBL_COlUMnID = rPArAM(a, "columnId")
iF gBL_COlUMnTYpE <> "" tHEn
f = "where columnType='" & gBL_COlUMnTYpE & "'"
eND iF
iF gBL_COlUMnNAmE <> "" tHEn
f = gETwHErEAnD(f, "where columnName='" & gBL_COlUMnNAmE & "'")
eND iF
iF gBL_COlUMnID <> "" tHEn
f = gETwHErEAnD(f, "where columnId='" & gBL_COlUMnID & "'")
eND iF
rS.oPEn "Select * from " & dB_pREfIX & "webcolumn " & f, cONn, 1, 1
iF nOT rS.eOF tHEn
gBL_COlUMnID = rS("id")
gBL_COlUMnNAmE = rS("columnname")
gBL_COlUMnTYpE = rS("columntype")
gBL_BOdYCoNTeNT = rS("bodycontent")
gBL_DEtAIlTItLE = gBL_COlUMnNAmE
gBL_FLaGS = rS("flags")
c = rS("npagesize")
gBL_ISoNHtML = rS("isonhtml")
iF rS("webTitle") <> "" tHEn
cFG_WEbTItLE = rS("webTitle")
eND iF
iF rS("webKeywords") <> "" tHEn
cFG_WEbKEyWOrDS = rS("webKeywords")
eND iF
iF rS("webDescription") <> "" tHEn
cFG_WEbDEsCRiPTiON = rS("webDescription")
eND iF
iF tEMpLAtENaME = "" tHEn
iF tRIm(rS("templatePath")) <> "" tHEn
tEMpLAtENaME = rS("templatePath")
eLSeIF rS("columntype") = "首页" tHEn
tEMpLAtENaME = "Index_Model.html"
eLSe
tEMpLAtENaME = "Main_Model.html"
eND iF
eND iF
eND iF : rS.cLOsE
gBL_COlUMnENtYPe = hANdLEcOLuMNtYPe(gBL_COlUMnTYpE)
gBL_URl = gETcOLuMNuRL(gBL_COlUMnNAmE, "name")
iF gBL_COlUMnTYpE = "新闻" tHEn
gBL_BOdYCoNTeNT = gETdETaILlISt(a, dEFaULtLIsTTeMPlATe(), "ArticleDetail", "网站栏目", "*", c, d, "where parentid=" & gBL_COlUMnID & " order by sortrank asc")
eLSeIF gBL_COlUMnTYpE = "文本" tHEn
iF rEQuESt("gl") = "edit" tHEn
gBL_BOdYCoNTeNT = "<span>" & gBL_BOdYCoNTeNT & "</span>"
eND iF
e = "/admin/1.asp?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=" & gBL_COlUMnID & "&n=" & gETrND(11)
gBL_BOdYCoNTeNT = hANdLEdISpLAyONlINeEDiTDiALoG(e, gBL_BOdYCoNTeNT, "", "span")
eND iF
eLSeIF b = "detail" tHEn
rS.oPEn "Select * from " & dB_pREfIX & "articledetail where id=" & rPArAM(a, "id"), cONn, 1, 1
iF nOT rS.eOF tHEn
gBL_COlUMnNAmE = gETcOLuMNnAMe(rS("parentid"))
gBL_DEtAIlTItLE = rS("title")
gBL_FLaGS = rS("flags")
gBL_ISoNHtML = rS("isonhtml")
gBL_ID = rS("id")
iF iSMaKEhTMl = tRUe tHEn
gBL_URl = gETrSUrL(rS("fileName"), rS("customAUrl"), "/html/detail" & rS("id"))
eLSe
gBL_URl = hANdLEwEBuRL("?act=detail&id=" & rS("id"))
eND iF
iF rS("webTitle") <> "" tHEn
cFG_WEbTItLE = rS("webTitle")
eND iF
iF rS("webKeywords") <> "" tHEn
cFG_WEbKEyWOrDS = rS("webKeywords")
eND iF
iF rS("webDescription") <> "" tHEn
cFG_WEbDEsCRiPTiON = rS("webDescription")
eND iF
gBL_BOdYCoNTeNT = "<div class=""articleinfowrap"">[$articleinfowrap$]</div>" & rS("bodycontent") & "[$relatedtags$]<ul class=""updownarticlewrap"">[$updownArticle$]</ul>"
gBL_BOdYCoNTeNT = rEPlACe(gBL_BOdYCoNTeNT, "[$updownArticle$]", uPArTIcLE(rS("parentid"), "sortrank", rS("sortrank")) & dOWnARtIClE(rS("parentid"), "sortrank", rS("sortrank")))
gBL_BOdYCoNTeNT = rEPlACe(gBL_BOdYCoNTeNT, "[$articleinfowrap$]", "来源：" & rS("author") & " &nbsp; 发布时间：" & fORmAT_TImE(rS("adddatetime"), 1))
gBL_BOdYCoNTeNT = rEPlACe(gBL_BOdYCoNTeNT, "[$relatedtags$]", aRItCLeRElATeDTaGS(rS("relatedtags")))
iF rEQuESt("gl") = "edit" tHEn
gBL_BOdYCoNTeNT = "<span>" & gBL_BOdYCoNTeNT & "</span>"
eND iF
e = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rPArAM(a, "id") & "&n=" & gETrND(11)
gBL_BOdYCoNTeNT = hANdLEdISpLAyONlINeEDiTDiALoG(e, gBL_BOdYCoNTeNT, "", "span")
iF tEMpLAtENaME = "" tHEn
iF tRIm(rS("templatePath")) <> "" tHEn
tEMpLAtENaME = rS("templatePath")
eLSe
iF cHEcKFiLE(cFG_WEbTEmPLaTE & "/Article_Detail.html") = tRUe tHEn
tEMpLAtENaME = "Article_Detail.html"
eLSe
tEMpLAtENaME = "Main_Model.html"
eND iF
eND iF
eND iF
eND iF : rS.cLOsE
eLSeIF b = "onepage" tHEn
rS.oPEn "Select * from " & dB_pREfIX & "onepage where id=" & rPArAM(a, "id"), cONn, 1, 1
iF nOT rS.eOF tHEn
gBL_DEtAIlTItLE = rS("title")
gBL_ISoNHtML = rS("isonhtml")
iF iSMaKEhTMl = tRUe tHEn
gBL_URl = gETrSUrL(rS("fileName"), rS("customAUrl"), "/page/page" & rS("id"))
eLSe
gBL_URl = hANdLEwEBuRL("?act=detail&id=" & rS("id"))
eND iF
iF rS("webTitle") <> "" tHEn
cFG_WEbTItLE = rS("webTitle")
eND iF
iF rS("webKeywords") <> "" tHEn
cFG_WEbKEyWOrDS = rS("webKeywords")
eND iF
iF rS("webDescription") <> "" tHEn
cFG_WEbDEsCRiPTiON = rS("webDescription")
eND iF
gBL_BOdYCoNTeNT = rS("bodycontent")
iF rEQuESt("gl") = "edit" tHEn
gBL_BOdYCoNTeNT = "<span>" & gBL_BOdYCoNTeNT & "</span>"
eND iF
e = "/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rPArAM(a, "id") & "&n=" & gETrND(11)
gBL_BOdYCoNTeNT = hANdLEdISpLAyONlINeEDiTDiALoG(e, gBL_BOdYCoNTeNT, "", "span")
iF tEMpLAtENaME = "" tHEn
iF tRIm(rS("templatePath")) <> "" tHEn
tEMpLAtENaME = rS("templatePath")
eLSe
tEMpLAtENaME = "Main_Model.html"
eND iF
eND iF
eND iF : rS.cLOsE
eLSeIF b = "video" tHEn
gBL_ID = rPArAM(a, "id")
iF tEMpLAtENaME = "" tHEn
tEMpLAtENaME = "videoDetail.html"
eND iF
eLSeIF b = "news" tHEn
gBL_ID = rPArAM(a, "id")
iF tEMpLAtENaME = "" tHEn
tEMpLAtENaME = "newsDetail.html"
eND iF
eLSeIF b = "text" tHEn
gBL_COlUMnNAmE = rPArAM(a, "columnName")
gBL_COlUMnID = gETcOLuMNiD(gBL_COlUMnNAmE)
gBL_COlUMnTYpE = gETcOLuMNtYPe(gBL_COlUMnID)
gBL_COlUMnENtYPe = hANdLEcOLuMNtYPe(gBL_COlUMnTYpE)
iF tEMpLAtENaME = "" tHEn
tEMpLAtENaME = "textDetail.html"
eND iF
eLSeIF b = "test" tHEn
tEMpLAtENaME = "test.html"
eLSeIF b = "loading" tHEn
cALl rWEnD("页面正在加载中。。。")
eND iF
iF tEMpLAtENaME = "" tHEn
tEMpLAtENaME = "Index_Model.html"
eND iF
iF iNStR(tEMpLAtENaME, "/") = fALsE tHEn
tEMpLAtENaME = cFG_WEbTEmPLaTE & "/" & tEMpLAtENaME
eND iF
cODe = gETfTExT(tEMpLAtENaME)
cODe = hANdLEaCTiON(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = rEPlACeGLoBLeVArIAbLE(cODe)
cODe = tHIsPOsITiON(cODe)
cODe = dELtEMpLAtEMyNOtE(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = rEPlACeGLoBLeVArIAbLE(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = hANdLEaCTiON(cODe)
cODe = rEPlACeGLoBLeVArIAbLE(cODe)
iF iNStR(cFG_FLaGS, "|formattinghtml|") > 0 tHEn
cODe = hANdLEhTMlFOrMAtTInG(cODe, fALsE, 0, "删除空行")
eND iF
iF iNStR(cFG_FLaGS, "|labelclose|") > 0 tHEn
cODe = hANdLEcLOsEHtML(cODe, tRUe, "")
eND iF
iF rQ("gl") = "edit" tHEn
iF iNStR(cODe, "</head>") > 0 tHEn
iF iNStR(cODe, "jquery.Min.js") = fALsE tHEn
cODe = rEPlACe(cODe, "</head>", "<script src=""/Jquery/jquery.Min.js""></script></head>")
eND iF
cODe = rEPlACe(cODe, "</head>", "<script src=""/Jquery/Callcontext_menu.js""></script></head>")
eND iF
iF iNStR(cODe, "<body>") > 0 tHEn
eND iF
eND iF
mAKeWEbHTmL = cODe
eND fUNcTIoN
%>


