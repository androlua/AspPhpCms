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
fUNcTIoN hTMlFOrMAtTInG(a)
hTMlFOrMAtTInG = hANdLEhTMlFOrMAtTInG(a, fALsE, 0, "")
eND fUNcTIoN
fUNcTIoN hANdLEhTMlFOrMAtTInG(bYVaL a, b, c, d)
dIM e, f, g, h, i, j, k, l, m, n
dIM o
dIM p,q
dIM lEVeLArRAy(299), s
dIM t
dIM u
dIM v
dIM iSPrE	
u = fALsE
v = fALsE
iSPrE=fALsE	
o = 0
d = "|" & d & "|"
e = sPLiT(a, vBCrLF)
fOR eACh f iN e
g = f:p=f
f = tRImVBcRLf(f) : h = lCAsE(f)
iF(lEFt(h, 8) = "<script " oR lEFt(h, 8) = "<script>") aND iNStR(f, "</script>") = fALsE aND u = fALsE tHEn
u = tRUe
i = i & pHPtRIm(g) & vBCrLF
eLSeIF u = tRUe tHEn
iF lEFt(h, 9) = "</script>" tHEn
u = fALsE
i = i & pHPtRIm(g) & vBCrLF
eLSe
i = i & g & vBCrLF
eND iF
eLSeIF(lEFt(h, 10) = "<textarea " oR lEFt(h, 10) = "<textarea>") aND iNStR(f, "</textarea>") = fALsE aND v = fALsE tHEn
v = tRUe
i = i & pHPtRIm(g) & vBCrLF
eLSeIF v = tRUe tHEn
i = i & pHPtRIm(g) & vBCrLF
iF lEFt(h, 11) = "</textarea>" tHEn
v = fALsE
eND iF
eLSeIF(lEFt(h, 5) = "<pre " oR lEFt(h, 5) = "<pre>") aND iNStR(f, "</pre>") = fALsE aND iSPrE = fALsE tHEn
iSPrE = tRUe
i = i & pHPtRIm(g) & vBCrLF
eLSeIF iSPrE = tRUe tHEn
i = i & g & vBCrLF
iF lEFt(h, 6) = "</pre>" tHEn
iSPrE = fALsE
eND iF
eLSeIF f <> "" aND u = fALsE aND v = fALsE tHEn
j = "|" & lEFt(h, 4) & "|" : k = "|" & lEFt(h, 5) & "|" : l = "|" & lEFt(h, 6) & "|"
m = "|" & lEFt(h, 7) & "|" : n = "|" & lEFt(h, 8) & "|"
s = ""
t = ""
iF iNStR("|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |", j) > 0 tHEn
s = j
t = mID(j, 3, 2)
eLSeIF iNStR("|<div>|<div |", k) > 0 tHEn
s = k
t = mID(k, 3, 3)
eLSeIF iNStR("|<span>|<span |<form>|<form |", l) > 0 tHEn
s = l
t = mID(l, 3, 4)
eLSeIF iNStR("|<table>|<table |<tbody>|<tbody |", m) > 0 tHEn
s = m
t = mID(m, 3, 5)
eLSeIF iNStR("|<center>|<center |", n) > 0 tHEn
s = n
t = mID(n, 3, 6)
eND iF
s = tRIm(rEPlACe(rEPlACe(s, "<", ""), ">", ""))
iF s <> "" tHEn
f = cOPySTr("    ", o) & f
iF rIGhT(h, 3 + lEN(t)) <> "</" & t & ">" aND iNStR(h, "</" & t & ">") = fALsE tHEn
o = o + 1
iF o >= 0 tHEn
lEVeLArRAy(o) = s
eND iF
eND iF
eLSeIF iNStR("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|", "|" & lEFt(h, 5) & "|") > 0 oR iNStR("|</div>|", "|" & lEFt(h, 6) & "|") > 0 oR iNStR("|</span>|</form>|", "|" & lEFt(h, 7) & "|") > 0 oR iNStR("|</table>|</tbody>|", "|" & lEFt(h, 8) & "|") > 0 oR iNStR("|</center>|", "|" & lEFt(h, 9) & "|") > 0 tHEn
o = o - 1
f = cOPySTr("    ", o) & f
eLSe
f = cOPySTr("    ", o) & f
iF rIGhT(h, 6) = "</div>" tHEn
iF cHEcKHtMLfORmATtINg(h) = fALsE tHEn
f = lEFt(f, lEN(f) - 6)
o = o - 1
f = f & vBCrLF & cOPySTr("    ", o) & "</div>"
eND iF
eLSeIF rIGhT(h, 7) = "</span>" tHEn
iF cHEcKHtMLfORmATtINg(h) = fALsE tHEn
f = lEFt(f, lEN(f) - 7)
o = o - 1
f = f & vBCrLF & cOPySTr("    ", o) & "</span>"
eND iF
eLSeIF iNStR("|</ul>|</dt>|<dl>|<dd>|", k) > 0 tHEn
f = lEFt(f, lEN(f) - 5)
o = o - 1
f = f & vBCrLF & cOPySTr("    ", o) & rIGhT(h, 5)
eND iF
p=pHPtRIm(lCAsE(p))
iF iNStR(p,"</")>0 tHEn
q=mID(p,iNStR(p,"</"))
iF iNStR("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|", "|" & q & "|") > 0 aND o>0 tHEn
o = o - 1
eND iF
eND iF
eND iF
i = i & f & vBCrLF
eLSeIF f = "" tHEn
iF iNStR(d, "|delblankline|") = fALsE aND iNStR(d, "|删除空行|") = fALsE tHEn
i = i & vBCrLF
eND iF
eND iF
nEXt
hANdLEhTMlFOrMAtTInG = i
c = o
iF o <> 0 aND(lCAsE(b) = "1" oR lCAsE(b) = "true") tHEn
cALl eCHo("HTML标签有错误", o)
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKHtMLfORmATtINg(bYVaL a)
dIM b, c, d, e, f, g
a = lCAsE(a)
b = sPLiT("ul|li|dt|dd|dl|div|span", "|")
fOR eACh c iN b
c = pHPtRIm(c)
iF c <> "" tHEn
f = 0
g = "<" & c & " "
iF iNStR(a, g) > 0 tHEn
e = sPLiT(a, g)
f = f + uBOuND(e)
eND iF
g = "<" & c & ">"
iF iNStR(a, g) > 0 tHEn
e = sPLiT(a, g)
f = f + uBOuND(e)
eND iF
g = "</" & c & ">"
iF iNStR(a, g) > 0 tHEn
e = sPLiT(a, g)
f = f - uBOuND(e)
eND iF
iF f <> 0 tHEn
cHEcKHtMLfORmATtINg = fALsE
eXIt fUNcTIoN
eND iF
eND iF
nEXt
cHEcKHtMLfORmATtINg = tRUe
eND fUNcTIoN
%>


