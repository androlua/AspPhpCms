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
fUNcTIoN xY_pHP_NAvLIsT(a)
dIM b
b = rPArAM(a, "sql")
iF b = "" tHEn
b = "select * from " & dB_pREfIX & "webcolumn where flags like'%top%' order by sortRank asc"
eND iF
b = rEPlACeGLoBLeVArIAbLE(b)
xY_pHP_NAvLIsT = xY_pHP_GEnERaLLiST(a, "WebColumn", b)
eND fUNcTIoN
fUNcTIoN xY_pHP_COmMEnTLiST(a)
dIM b, c
b = rPArAM(a, "sql")
c = rPArAM(a, "itemID")
c = rEPlACeGLoBLeVArIAbLE(c)
iF b = "" tHEn
b = "select * from " & dB_pREfIX & "TableComment where itemID=" & c & " and through=1 order by adddatetime asc"
eND iF
b = rEPlACeGLoBLeVArIAbLE(b)
xY_pHP_COmMEnTLiST = xY_pHP_GEnERaLLiST(a, "TableComment", b)
eND fUNcTIoN
fUNcTIoN xY_pHP_DEtAIlLIsT(a)
dIM b, c, d, e, f, g, h, i, j
a = rEPlACe(a, "[$detailTitle$]", gBL_DEtAIlTItLE)
b = rPArAM(a, "sql")
f = rPArAM(a, "topNumb")
iF b = "" tHEn
iF f <> "" tHEn
f = " top " & f & " "
eND iF
b = "Select " & f & "* From " & dB_pREfIX & "ArticleDetail"
eND iF
g = lCAsE(rPArAM(a, "rand"))
iF g = "true" oR g = "1" tHEn
b = b & " where id in(" & gETrANdARtIClEId("", f) & ")"
eND iF
i = rPArAM(a, "columnName")
iF i <> "" tHEn
h = sPLiT(i, "[Array]")
fOR eACh d iN h
e = gETcOLuMNiD(d)
iF e <> "" tHEn
iF j <> "" tHEn
j = j & ","
eND iF
j = j & e
eND iF
nEXt
eND iF
iF j <> "" tHEn
b = gETwHErEAnD(b, "where parentId in(" & j & ")")
eND iF
c = rPArAM(a, "addSql")
iF c <> "" tHEn
b = gETwHErEAnD(b, c)
eND iF
b = rEPlACeGLoBLeVArIAbLE(b)
xY_pHP_DEtAIlLIsT = xY_pHP_GEnERaLLiST(a, "ArticleDetail", b)
eND fUNcTIoN
fUNcTIoN gEToNEpAGeURl(a)
dIM b
rSX.oPEn "select * from " & dB_pREfIX & "onepage where title='" & a & "'", cONn, 1, 1
iF nOT rSX.eOF tHEn
iF iSMaKEhTMl = tRUe tHEn
b = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/page/page" & rSX("id"))
eLSe
b = hANdLEwEBuRL("?act=onepage&id=" & rSX("id"))
iF rSX("customAUrl") <> "" tHEn
b = rSX("customAUrl")
eND iF
eND iF
eND iF : rSX.cLOsE
gEToNEpAGeURl = b
eND fUNcTIoN
fUNcTIoN gETrSUrL(a, b, c)
dIM d
iF a = "" tHEn
a = c
eND iF
iF a <> "" tHEn
d = a
iF iNStR(lCAsE(d), ".html") = fALsE aND rIGhT(d, 1) <> "/" tHEn
d = d & ".html"
eND iF
eND iF
iF tRIm(b) <> "" tHEn
d = tRIm(b)
eND iF
iF iNStR(cFG_FLaGS, "|addwebsite|") > 0 tHEn
d = uRLaDDhTTpURl(cFG_WEbSItEUrL, d)
eND iF
gETrSUrL = d
eND fUNcTIoN
fUNcTIoN xY_pHP_GEnERaLLiST(a, b, c)
dIM d, e, f, g, h
dIM i, j, k, l, m
dIM n, o, p, q
dIM r, s, t, u, v, w, x, y
dIM z
r = gETdEFaULtVAlUE(a)
dIM aA
z = tRIm(lCAsE(rPArAM(a, "noFollow")))
dIM bA
dIM cA
dIM dA
dIM eA
dIM fA
dIM gA, hA, iA, jA
fA = lCAsE(gETfIElDLiST(dB_pREfIX & b))
gA = sPLiT(fA, ",")
rS.oPEn c, cONn, 1, 1
e = rPArAM(a, "topNumb")
iF e = "" tHEn
e = rS.rECoRDcOUnT
eLSe
e = cINt(e)
eND iF
iF e > rS.rECoRDcOUnT tHEn
e = rS.rECoRDcOUnT
eND iF
fOR s = 1 tO e
iF rS.eOF tHEn eXIt fOR
eA = fALsE
q = rS("id")
iF b = "WebColumn" tHEn
iF iSMaKEhTMl = tRUe tHEn
y = gETrSUrL(rS("fileName"), rS("customAUrl"), "/nav" & rS("id"))
eLSe
y = hANdLEwEBuRL("?act=nav&columnName=" & rS("columnname"))
iF rS("customAUrl") <> "" tHEn
y = rS("customAUrl")
eND iF
iF rEQuESt("gl") <> "" tHEn
y = y & "&gl=" & rEQuESt("gl")
eND iF
eND iF
iF gBL_COlUMnNAmE = "" aND rS("columnType") = "首页" tHEn
gBL_COlUMnNAmE = rS("columnName")
eND iF
iF rS("columnName") = gBL_COlUMnNAmE tHEn
eA = tRUe
eND iF
eLSeIF b = "ArticleDetail" tHEn
iF iSMaKEhTMl = tRUe tHEn
y = gETrSUrL(rS("fileName"), rS("customAUrl"), "/html/detail" & rS("id"))
eLSe
y = hANdLEwEBuRL("?act=detail&id=" & rS("id"))
iF rS("customAUrl") <> "" tHEn
y = rS("customAUrl")
eND iF
iF rEQuESt("gl") <> "" tHEn
y = y & "&gl=" & rEQuESt("gl")
eND iF
eND iF
h = ""
iF rS("titlecolor") <> "" tHEn
h = "color:" & rS("titlecolor") & ";"
eND iF
iF iNStR(rS("flags"), "|b|") > 0 tHEn
h = h & "font-weight:bold;"
eND iF
iF h <> "" tHEn
h = "style=""" & h & """"
eND iF
eLSeIF b = "TableComment" tHEn
eND iF
iF y = wEBuRLfILePAtH oR eA = tRUe tHEn
w = "[list-focus]" : x = "[/list-focus]"
eLSe
w = "[list-" & s & "]" : x = "[/list-" & s & "]"
eND iF
iF s = e aND eA = fALsE tHEn
w = "[list-end]" : x = "[/list-end]"
eND iF
fOR aA = 6 tO 2 sTEp - 1
iF iNStR(r, w) = fALsE aND s mOD aA = 0 tHEn
w = "[list-mod" & aA & "]" : x = "[/list-mod" & aA & "]"
iF iNStR(r, w) > 0 tHEn
eXIt fOR
eND iF
eND iF
nEXt
iF iNStR(r, w) = fALsE tHEn
w = "[list]" : x = "[/list]"
eND iF
iF iNStR(r, w) > 0 aND iNStR(r, x) > 0 tHEn
u = sTRcUT(r, w, x, 2)
fOR t = 1 tO 3
u = hANdLErEPlACeVAlUEpARaM(u, "ni", s)
u = hANdLErEPlACeVAlUEpARaM(u, "编号-1", s - 1)
u = hANdLErEPlACeVAlUEpARaM(u, "编号", s)
u = rEPlACe(u, "[$id$]", rS("id"))
u = rEPlACe(u, "[$url$]", y)
fOR jA = 0 tO uBOuND(gA)
iF gA(jA) <> "" tHEn
hA = gA(jA)
iA = rS(hA) & ""
u = rEPlACeVAlUEpARaM(u, hA, iA)
eND iF
nEXt
u = rEPlACeVAlUEpARaM(u, "abcolor", h)
nEXt
w = "[list-" & s & " startdialog]" : x = "[/list-" & s & " startdialog]"
iF iNStR(r, w) > 0 aND iNStR(r, x) > 0 tHEn
u = sTRcUT(r, w, x, 2) & u
eND iF
w = "[list-" & s & " enddialog]" : x = "[/list-" & s & " enddialog]"
iF iNStR(r, w) > 0 aND iNStR(r, x) > 0 tHEn
u = u & sTRcUT(r, w, x, 2)
eND iF
iF b = "WebColumn" tHEn
y = "/admin/index.asp?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=" & rS("id") & "&n=" & gETrND(11)
eLSeIF b = "ArticleDetail" tHEn
y = "/admin/index.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=" & rS("id") & "&n=" & gETrND(11)
eND iF
u = hANdLEdISpLAyONlINeEDiTDiALoG(y, u, "", "div|li|span")
v = v & u
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
w = "[dialog start]" : x = "[/dialog start]"
iF iNStR(r, w) > 0 aND iNStR(r, x) > 0 tHEn
v = sTRcUT(r, w, x, 2) & v
eND iF
w = "[dialog end]" : x = "[/dialog end]"
iF iNStR(r, w) > 0 aND iNStR(r, x) > 0 tHEn
v = v & sTRcUT(r, w, x, 2)
eND iF
xY_pHP_GEnERaLLiST = v
eND fUNcTIoN
fUNcTIoN uPArTIcLE(a, b, c)
dIM d
d = "select * from " & dB_pREfIX & "articledetail where parentid=" & a & " and " & b & "<" & c & " order by " & b & " desc"
uPArTIcLE = hANdLEuPDoWNaRTiCLe("上一篇：", d)
eND fUNcTIoN
fUNcTIoN dOWnARtIClE(a, b, c)
dIM d
d = "select * from " & dB_pREfIX & "articledetail where parentid=" & a & " and " & b & ">" & c & " order by " & b & " asc"
dOWnARtIClE = hANdLEuPDoWNaRTiCLe("下一篇：", d)
eND fUNcTIoN
fUNcTIoN hANdLEuPDoWNaRTiCLe(a, b)
dIM c, d
rSX.oPEn b, cONn, 1, 1
iF nOT rSX.eOF tHEn
iF iSMaKEhTMl = tRUe tHEn
d = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/html/detail" & rSX("id"))
eLSe
d = hANdLEwEBuRL("?act=detail&id=" & rSX("id"))
eND iF
c = "<li><a href=""" & d & """>" & a & rSX("title") & "</a></li>"
eLSe
c = "<li>" & a & "没有</li>"
eND iF : rSX.cLOsE
hANdLEuPDoWNaRTiCLe = c
eND fUNcTIoN
fUNcTIoN xY_pHP_SInGLePAgE(a)
dIM b, c, d, e, f, g
g = rPArAM(a, "fieldname")
iF g = "" tHEn
g = "bodycontent"
eND iF
b = rPArAM(a, "title")
d = gETdEFaULtVAlUE(a)
f = "select * from " & dB_pREfIX & "onepage where title='" & b & "'"
rS.oPEn f, cONn, 1, 1
iF rS.eOF tHEn
iF rPArAM(a, "autoadd") = "true" tHEn
cONn.eXEcUTe("insert into " & dB_pREfIX & "onepage (title,displaytitle," & g & ") values('" & b & "','" & b & "','" & aDSqL(d) & "')")
eND iF
eLSe
e = rS("id")
d = rS(g)
eND iF : rS.cLOsE
iF e = "" tHEn
e = xY_pHP_GEtFIeLDvALuE("", f, "id")
eND iF
c = "/admin/index.asp?act=addEditHandle&actionType=OnePage&lableTitle=单页管理&nPageSize=10&page=&id=" & e & "&n=" & gETrND(11)
iF rEQuESt("gl") = "edit" tHEn
d = "<span>" & d & "</span>"
eND iF
d = hANdLEdISpLAyONlINeEDiTDiALoG(c, d, "", "span")
xY_pHP_SInGLePAgE = d
eND fUNcTIoN
fUNcTIoN xY_pHP_GEtCOlUMnCOnTEnT(a)
dIM b, c, d, e, f, g
g = rPArAM(a, "fieldname")
iF g = "" tHEn
g = "bodycontent"
eND iF
b = rPArAM(a, "columnname")
d = gETdEFaULtVAlUE(a)
f = "select * from " & dB_pREfIX & "webcolumn where columnname='" & b & "'"
rS.oPEn f, cONn, 1, 1
iF nOT rS.eOF tHEn
e = rS("id")
d = rS(g)
eND iF : rS.cLOsE
iF e = "" tHEn
e = xY_pHP_GEtFIeLDvALuE("", f, "id")
eND iF
c = "/admin/index.asp?act=addEditHandle&actionType=OnePage&lableTitle=单页管理&nPageSize=10&page=&id=" & e & "&n=" & gETrND(11)
iF rEQuESt("gl") = "edit" tHEn
d = "<span>" & d & "</span>"
eND iF
d = hANdLEdISpLAyONlINeEDiTDiALoG(c, d, "", "span")
xY_pHP_GEtCOlUMnCOnTEnT = d
eND fUNcTIoN
fUNcTIoN xY_pHP_GEtFIeLDvALuE(a, b, c)
dIM d, e
rS.oPEn b, cONn, 1, 1
iF nOT rS.eOF tHEn
e = rS(c)
eND iF : rS.cLOsE
xY_pHP_GEtFIeLDvALuE = e
eND fUNcTIoN
fUNcTIoN gETrANdARtIClEId(a, b)
dIM c, d, e, f
rS.oPEn "select * from " & dB_pREfIX & "articledetail " & a, cONn, 1, 1
wHIlE nOT rS.eOF
iF e <> "" tHEn e = e & ","
e = e & rS("id")
rS.mOVeNExT : wENd : rS.cLOsE
gETrANdARtIClEId = rANdOMsHOw(e, ",", 4)
c = sPLiT(e, ",") : e = "" : f = 0
fOR eACh d iN c
iF e <> "" tHEn e = e & ","
e = e & d
f = f + 1
iF f >= b tHEn eXIt fOR
nEXt
gETrANdARtIClEId = e
eND fUNcTIoN
fUNcTIoN xY_lAYoUT(a)
dIM b, c, d
b = rPArAM(a, "layoutname")
rS.oPEn "select * from " & dB_pREfIX & "weblayout where layoutname='" & b & "'", cONn, 1, 1
iF nOT rS.eOF tHEn
xY_lAYoUT = rS("bodycontent")
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN xY_mODuLE(a)
dIM b, c, d
b = rPArAM(a, "modulename")
rS.oPEn "select * from " & dB_pREfIX & "webmodule where modulename='" & b & "'", cONn, 1, 1
iF nOT rS.eOF tHEn
xY_mODuLE = rS("bodycontent")
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN xY_jSWeBStAT(a)
dIM b, c
c = tRIm(rPArAM(a, "fileName"))
iF c = "" tHEn
c = "/inc/Create_Html.Asp"
eND iF
c = rEPlACe(c, "/", "\/")
b = "<script>document.writeln(""<script src=\'" & c & "?act=WebStat&GoToUrl="""
b = b & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)"
b = b & "+""&co=""+escape(document.cookie)"
b = b & "+"" \'><\/script>"");</script>"
xY_jSWeBStAT = b
eND fUNcTIoN
%>


