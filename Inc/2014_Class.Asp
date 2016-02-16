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
fUNcTIoN sMAlLClASsLIsT(a, b, c, d)
dIM e,f,g,h,i,j,k,l
iF b<>"" tHEn
e = " class='"& b &"'"
eND iF
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
h = rS("SmallClassName")
i = fONtCOlORfONtB(h,rS("FontB"),rS("FontColor")) 	
l = gETsMAlLClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") )
cALl wEBdEBuG(l,"act=CreateClass&ProDid=" & a & "&ProSid=" & rS("SmallClassName"))
k = aTArGEt(rS("Target"))
g = "        <li"& e &"><a "& aHReF(l,i,k) & sTYlEClASs(c) &">"& i &"</a></li>" & vBCrLF
g = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & rS("Id") & "&n=" & gETrND(11), g, "<a ")
f=f & g
rS.mOVeNExT:wENd:rS.cLOsE
sMAlLClASsLIsT = f
eND fUNcTIoN
fUNcTIoN tHReEClASsLIsT(a, b, c, d, e)
dIM f,g,h,i,j,k,l,m
iF b<>"" tHEn
f = " class='"& b &"'"
eND iF
rS.oPEn"Select * From [ThreeClass] Where BigClassName='"& a &"' Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
i = rS("ThreeClassName")
j = fONtCOlORfONtB(i,rS("FontB"),rS("FontColor")) 	
m = gETtHReEClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") , rS("ThreeClassName") )
cALl wEBdEBuG(m,"act=CreateClass&ProDid=" & a & "&ProSid=" & rS("SmallClassName") & "&ProTid=" & rS("ThreeClassName"))
iF d="文本类型" tHEn
m = "{$GetProductUrl did='"& rS("BigClassName") &"' sid='"& rS("SmallClassName") &"' tid='"& rS("ThreeClassName") &"' title='"& rS("ThreeClassName") &"'$}"
eND iF
l = aTArGEt(rS("Target"))	
h = "        <li"& f &"><a "& aHReF(m,j,l) & sTYlEClASs(c) &">"& j &"</a></li>" & vBCrLF	
h = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & rS("Id") & "&n=" & gETrND(11), h, "<a ")
g=g & h
rS.mOVeNExT:wENd:rS.cLOsE
tHReEClASsLIsT = g
eND fUNcTIoN
fUNcTIoN gETcLAsSPaRAm(bYVaL a,bYVaL b,bYVaL c)
dIM d,e,f,g,h
d = "Select * From ["& a &"] " & c
tEMpRS2.oPEn d,cONn,1,1
iF nOT tEMpRS2.eOF tHEn
iF b = "[url]" tHEn
iF lCAsE(a) = "bigclass" tHEn
g = gETbIGcLAsSFiLEnAMe(tEMpRS2("BigClassName"))
h = "act=CreateClass&ProDid=" & tEMpRS2("BigClassName")
eLSeIF lCAsE(a) = "smallclass" tHEn
g = gETsMAlLClASsFIlENaME( tEMpRS2("BigClassName"), tEMpRS2("SmallClassName") )
h = "act=CreateClass&ProDid=" & tEMpRS2("BigClassName") & "&ProSid=" & tEMpRS2("SmallClassName")
eLSeIF lCAsE(a) = "threeclass" tHEn
g = gETtHReEClASsFIlENaME( tEMpRS2("BigClassName"), tEMpRS2("SmallClassName"),tEMpRS2("ThreeClassName"))
h = "act=CreateClass&ProDid=" & tEMpRS2("BigClassName") & "&ProSid=" & tEMpRS2("SmallClassName") & "&ProTid=" & tEMpRS2("ThreeClassName")
eND iF	
g = fULlHTtPUrL(hOSt,g)
cALl wEBdEBuG(g, h)
gETcLAsSPaRAm = g
eLSeIF b<>"" tHEn
gETcLAsSPaRAm = tEMpRS2(b)
eND iF
eND iF:tEMpRS2.cLOsE
eND fUNcTIoN
%>

