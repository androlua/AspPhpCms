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
fUNcTIoN cLOsEHtML(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c, d, e, f, g, h, i, j, k : b = a
sET h = cREaTEoBJeCT("VBscript.RegExp")
h.iGNoREcASe = tRUe
h.gLObAL = tRUe
c = "p,div,span,table,ul,font,b,u,i,h1,h2,h3,h4,h5,h6"
d = sPLiT(c,",")
fOR e = 0 tO uBOuND(d)
f = 0
g = 0
h.pATtERn = "<(" + tRIm(d(e)) + ")((\s+[^<>])+|)>"
sET i = h.eXEcUTe(b)
fOR eACh k iN i
f = f + 1
b = rEPlACe(b, k.vALuE, "<"& lCAsE(k.sUBmATcHEs(0)) & k.sUBmATcHEs(1) &">")
nEXt
h.pATtERn = "<\/" + d(e) + ">"
sET i = h.eXEcUTe(b)
fOR eACh k iN i
g = g + 1
b = rEPlACe(b, k.vALuE, "</"& lCAsE(k.sUBmATcHEs(0)) &">")
nEXt
fOR j = 1 tO f - g
b = b + "</" + d(e) + ">"
nEXt
nEXt
cLOsEHtML = b
sET h = nOThINg
eND fUNcTIoN
%>

