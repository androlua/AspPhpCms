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
sUB sQLiN()
dIM b, c, d, e
b = "'|;|and|(|)|exec|insert|select|delete|update|count|*|chr|mid|master|truncate|char|declare"
c = sPLiT(b, "|")
iF rEQuESt.qUErYStRInG <> "" tHEn
fOR eACh e iN rEQuESt.qUErYStRInG
fOR d = 0 tO uBOuND(c)
iF iNStR(lCAsE(rEQuESt.qUErYStRInG), c(d)) <> 0 tHEn
cALl sAVeSQlINiNFo(c(d))
cALl eERr("Post注入", "你的IP[" & gETiP & "]已被收录")
eND iF
nEXt
nEXt
eND iF
iF rEQuESt.fORm <> "" tHEn
fOR eACh e iN rEQuESt.qUErYStRInG
fOR d = 0 tO uBOuND(c)
iF iNStR(lCAsE(rEQuESt.qUErYStRInG), c(d)) <> 0 tHEn
cALl sAVeSQlINiNFo(c(d))
cALl eERr("Get注入", "你的IP[" & gETiP & "]已被收录")
eND iF
nEXt
nEXt
eND iF
eND sUB
fUNcTIoN sAVeSQlINiNFo(a)
dIM b, c, d, e, f, g, h
b = sERvER.mAPpATh("./SqlIn.Txt")
c = nOW()
d = rEQuESt.sERvERvARiABlES("Remote_Addr")
a = c & " - " & d & "   " & a
sET g = cREaTEoBJeCT("Scripting.FileSystemObject")
iF g.fILeEXiSTs(b) tHEn
sET e = g.oPEnTExTFiLE(b, 1)
sET h = g.gETfILe(b)
iF h.sIZe > 0 tHEn f = e.rEAdALl
sET h = nOThINg
sET e = nOThINg
sET e = g.cREaTEtEXtFIlE(b, tRUe)
e.wRItELiNE(f & vBCrLF & a)
sET e = nOThINg
eLSe
sET e = g.cREaTEtEXtFIlE(b, tRUe)
e.wRItELiNE(a)
sET e = nOThINg
eND iF
sET g = nOThINg
eND fUNcTIoN
%>

