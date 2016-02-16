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
fUNcTIoN xY_pHP_NAvLIsT(a)
xY_pHP_NAvLIsT = xY_pHP_GEnERaLLiST(a, "nav", "Select * From [v9_category] where parentid=0 and ismenu=1 order by listorder asc")
eND fUNcTIoN
fUNcTIoN xY_pHP_DEtAIlLIsT(a)
xY_pHP_DEtAIlLIsT = xY_pHP_GEnERaLLiST(a, "detail", "Select top 6 * From [v9_picture]")
eND fUNcTIoN
fUNcTIoN xY_pHP_GEnERaLLiST(a, b, c)
dIM d, e, f, g, h, i, j
cALl hANdLEfUNpARaMEtER(a, d, e, f, g, h, i, j)
dIM k, l, m, n, o, p, q, r
dIM s
k = gETdEFaULtVAlUE(a)
dIM t
s = tRIm(lCAsE(rPArAM(a, "noFollow")))
rS.oPEn c, cONn, 1, 1
fOR l = 1 tO rS.rECoRDcOUnT
iF rS.eOF tHEn eXIt fOR
iF b = "nav" tHEn
r = b & "_" & rS("catid") & ".html"
d = rS("catname")
g = rS("catname")
eLSeIF b = "detail" tHEn
r = b & "_" & rS("ID") & ".html"
d = ""
g = rS("title")
eND iF
iF r = wEBuRLfILePAtH tHEn
p = "[list-focus]" : q = "[/list-focus]"
eLSe
p = "[list-" & l & "]" : q = "[/list-" & l & "]"
eND iF
r = wEBuRLpREfIX & r
fOR t = 6 tO 2 sTEp - 1
iF iNStR(k, p) = fALsE aND l mOD t = 0 tHEn
p = "[list-mod" & t & "]" : q = "[/list-mod" & t & "]"
iF iNStR(k, p) > 0 tHEn
eXIt fOR
eND iF
eND iF
nEXt
iF iNStR(k, p) = fALsE tHEn
p = "[list]" : q = "[/list]"
eND iF
iF iNStR(k, p) > 0 aND iNStR(k, q) > 0 tHEn
n = sTRcUT(k, p, q, 2)
fOR m = 1 tO 3
n = rEPlACeVAlUEpARaM(n, "ni", l)
n = rEPlACeVAlUEpARaM(n, "编号-1", l - 1)
n = rEPlACeVAlUEpARaM(n, "编号", l)
n = rEPlACeVAlUEpARaM(n, "bigclassname", d)
n = rEPlACeVAlUEpARaM(n, "title", g)
n = rEPlACeVAlUEpARaM(n, "url", r)
nEXt
p = "[list-" & l & " startdialog]" : q = "[/list-" & l & " startdialog]"
iF iNStR(k, p) > 0 aND iNStR(k, q) > 0 tHEn
n = sTRcUT(k, p, q, 2) & n
eND iF
p = "[list-" & l & " enddialog]" : q = "[/list-" & l & " enddialog]"
iF iNStR(k, p) > 0 aND iNStR(k, q) > 0 tHEn
n = n & sTRcUT(k, p, q, 2)
eND iF
o = o & n
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
p = "[dialog start]" : q = "[/dialog start]"
iF iNStR(k, p) > 0 aND iNStR(k, q) > 0 tHEn
o = sTRcUT(k, p, q, 2) & o
eND iF
p = "[dialog end]" : q = "[/dialog end]"
iF iNStR(k, p) > 0 aND iNStR(k, q) > 0 tHEn
o = o & sTRcUT(k, p, q, 2)
eND iF
xY_pHP_GEnERaLLiST = o
eND fUNcTIoN
fUNcTIoN xY_pHP_SInGLePAgE(a)
xY_pHP_SInGLePAgE=xY_pHP_GEtFIeLDvALuE(a,"select * from [v9_page]","content")
eND fUNcTIoN
fUNcTIoN xY_pHP_GEtFIeLDvALuE(a,b,c)
rS.oPEn b,cONn,1,1
iF nOT rS.eOF tHEn
xY_pHP_GEtFIeLDvALuE=rS(c)
eLSe
xY_pHP_GEtFIeLDvALuE=gETdEFaULtVAlUE(a)
eND iF:rS.cLOsE
eND fUNcTIoN
%>


