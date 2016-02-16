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
fUNcTIoN sITeMAp(a)
dIM b, c, d, e, f, g, h, i, j, k, l, m, n
dIM o, p
dIM q, r, s, t, u
q = rPArAM(a, "ShieldNavDidList")
r = rPArAM(a, "ShieldNavSidList")
s = rPArAM(a, "ShieldDidList")
t = rPArAM(a, "ShieldSidList")
u = rPArAM(a, "ShieldTidList")
e = e & vBCrLF & "<!--SiteMap start-->" & vBCrLF
e = e & "<div class=""sitemap_con"">" & vBCrLF
rS.oPEn "Select * From [NavBigClass] Order By Sort", cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
h = rS("BigClassName")
iF iNStR("|" & q & "|", "|" & h & "|") = fALsE tHEn
f = gETnAVuRL(rS("BigClassName"), "")
i = fONtCOlORfONtB(h, rS("FontB"), rS("FontColor"))
g = rS("Target") : g = "_blank"
e = e & "    <h4><a " & aHReF(f, h, g) & ">" & i & "</a></h4>" & vBCrLF
iF rS("NavType") = "文本" tHEn
rSS.oPEn "Select * From [NavSmallClass] Where BigClassName='" & rS("BigClassName") & "' Order By Sort", cONn, 1, 1
iF nOT rSS.eOF tHEn
p = ""
fOR c = 1 tO rSS.rECoRDcOUnT
j = rSS("SmallClassName")
iF iNStR("|" & r & "|", "|" & j & "|") = fALsE tHEn
f = gETnAVuRL(rSS("BigClassName"), rSS("SmallClassName"))
k = fONtCOlORfONtB(j, rSS("FontB"), rSS("FontColor"))
g = rSS("Target") : g = "_blank"
p = p & cOPySTr(" ", 16) & "<li><a " & aHReF(f, "", g) & ">" & k & "</a></li>" & vBCrLF
eND iF
rSS.mOVeNExT : nEXt
iF p <> "" tHEn
e = e & cOPySTr(" ", 8) & "<div class=""group"">" & vBCrLF & cOPySTr(" ", 12) & "<ul>" & vBCrLF
e = e & p
e = e & cOPySTr(" ", 12) & "</ul>" & vBCrLF & cOPySTr(" ", 12) & "<div class=""clear""></div>" & vBCrLF
e = e & cOPySTr(" ", 8) & "</div>" & vBCrLF
eND iF
eND iF : rSS.cLOsE
eND iF
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [BigClass] Order By Sort", cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
h = rS("BigClassName")
iF iNStR("|" & s & "|", "|" & h & "|") = fALsE tHEn
f = gETbIGcLAsSUrL(rS("BigClassName"))
i = fONtCOlORfONtB(h, rS("FontB"), rS("FontColor"))
g = rS("Target") : g = "_blank"
e = e & "    <h4><a " & aHReF(f, h, g) & ">" & i & "</a></h4>" & vBCrLF
rSS.oPEn "Select * From [SmallClass] Where BigClassName='" & rS("BigClassName") & "' Order By Sort", cONn, 1, 1
iF nOT rSS.eOF tHEn
e = e & cOPySTr(" ", 8) & "<div class=""group"">" & vBCrLF & cOPySTr(" ", 12) & "<ul>" & vBCrLF
fOR c = 1 tO rSS.rECoRDcOUnT
j = rSS("SmallClassName")
iF iNStR("|" & t & "|", "|" & j & "|") = fALsE tHEn
f = gETsMAlLClASsURl(rSS("BigClassName"), rSS("SmallClassName"))
k = fONtCOlORfONtB(j, rSS("FontB"), rSS("FontColor"))
g = rSS("Target") : g = "_blank"
e = e & cOPySTr(" ", 16) & "<li><a " & aHReF(f, "", g) & ">" & k & "</a>"
n = " Where BigClassName='" & rSS("BigClassName") & "' And  SmallClassName='" & rSS("SmallClassName") & "'"
rSX.oPEn "Select * From [ThreeClass]" & n & " Order By Sort", cONn, 1, 1
o = ""
fOR d = 1 tO rSX.rECoRDcOUnT
l = rSX("ThreeClassName")
iF iNStR("|" & u & "|", "|" & l & "|") = fALsE tHEn
f = gETtHReEClASsURl(h, j, l)
m = fONtCOlORfONtB(l, rSX("FontB"), rSX("FontColor"))
g = rSX("Target") : g = "_blank"
o = o & cOPySTr(" ", 16) & "<li><a " & aHReF(f, "", g) & ">" & m & "</a></li>" & vBCrLF
eND iF
rSX.mOVeNExT : nEXt : rSX.cLOsE
iF o = "" tHEn
e = e & "</li>" & vBCrLF
eLSe
o = vBCrLF & cOPySTr(" ", 16) & "<ul>" & vBCrLF & o & cOPySTr(" ", 16) & "</ul>"
e = e & o & cOPySTr(" ", 16) & "</li>" & vBCrLF
eND iF
eND iF
rSS.mOVeNExT : nEXt
e = e & cOPySTr(" ", 12) & "</ul>" & vBCrLF & cOPySTr(" ", 12) & "<div class=""clear""></div>" & vBCrLF
e = e & cOPySTr(" ", 8) & "</div>" & vBCrLF
eND iF : rSS.cLOsE
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
e = e & "</div>" & vBCrLF & "<!--SiteMap end-->" & vBCrLF & vBCrLF
sITeMAp = e
eND fUNcTIoN
fUNcTIoN sITeMAp2(a,b, c)
dIM d, e, f, g,h, i,j, k,l,m,n,o,p,q,r,s,t,u,v
i=i & vBCrLF & "<!--SiteMap start-->" & vBCrLF
i=i & "<div class="""& a &""">" & vBCrLF	
i=i & "<ul>" & vBCrLF	
rS.oPEn "Select * From [NavBigClass] " & b, cONn, 1, 1
fOR e = 1 tO rS.rECoRDcOUnT
k = rS("FileName")
iF k <> "" tHEn k = k & ".html"
l = "/" & rS("FolderName") & "/"
o = rS("BigClassName")
j = rS("FileName")
iF cHEcKReMOtEUrL(j)=fALsE tHEn	
j = l & k
j = rEPlACe(rEPlACe(j, "//", "/"), "//", "/")
cALl wEBdEBuG(j,"act=Nav&NavDid=" & o)
eND iF
p = fONtCOlORfONtB(o,rS("FontB"),rS("FontColor"))
n = rS("Target") : n="_blank"
u = fALsE
i=i & "	<li><a "& aHReF(j,o,n) &">"& p &"</a>"
iF rS("NavType") = "文本" tHEn
rSS.oPEn "Select * From [NavSmallClass] Where BigClassName='"& rS("BigClassName") &"'", cONn, 1, 1
iF nOT rSS.eOF tHEn
i=i & vBCrLF & cOPySTr(" ",8) & "<ul>"& vBCrLF & cOPySTr(" ",12) & "<li>"
fOR f = 1 tO rSS.rECoRDcOUnT
k = rSS("FileName")
iF k <> "" tHEn k = k & ".html"
q = rSS("SmallClassName")
j = rSS("FileName")
iF cHEcKReMOtEUrL(j)=fALsE tHEn	
j = l & k
j = l & "/" & rSS("FolderName") & "/" & k
j = rEPlACe(rEPlACe(j, "//", "/"), "//", "/")
cALl wEBdEBuG(j,"act=Nav&NavDid=" & o & "&NavSid=" & q)
eND iF
r = fONtCOlORfONtB(q,rSS("FontB"),rSS("FontColor"))
n = rSS("Target") : n="_blank"
i = i & "<a "& aHReF(j,"",n) &">" & r & "</a>" & vBCrLF
rSS.mOVeNExT: nEXt
i=i & cOPySTr(" ",12) & "</li>"& vBCrLF & cOPySTr(" ",8) &"</ul>" & vBCrLF
u = tRUe
eND iF : rSS.cLOsE
eND iF
iF u=tRUe tHEn
i=i & cOPySTr(" ",4) & "</li><div class=""clear""></div>" & vBCrLF
eLSe
i=i & "</li>" & vBCrLF
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [BigClass] " & c, cONn, 1, 1
fOR e = 1 tO rS.rECoRDcOUnT
k = rS("FileName")
iF k <> "" tHEn k = k & ".html"
l = "/" & rS("FolderName") & "/"
o = rS("BigClassName")
j = rS("FileName")
iF cHEcKReMOtEUrL(j)=fALsE tHEn
j = l & k
j = rEPlACe(rEPlACe(j, "//", "/"), "//", "/")
cALl wEBdEBuG(j,"act=CreateClass&ProDid=" & o)
eND iF
p = fONtCOlORfONtB(o,rS("FontB"),rS("FontColor"))
n = rS("Target") : n="_blank"
u = fALsE
i=i & cOPySTr(" ",4) & "<li><a "& aHReF(j,o,n) &">"& p &"</a>"
rSS.oPEn "Select * From [SmallClass] Where BigClassName='"& rS("BigClassName") &"'", cONn, 1, 1
iF nOT rSS.eOF tHEn	
i=i & vBCrLF & cOPySTr(" ",8) & "<ul>" & vBCrLF
fOR f = 1 tO rSS.rECoRDcOUnT
k = rSS("FileName")
iF k <> "" tHEn k = k & ".html"
m = "/" & rSS("FolderName") & "/"
q = rSS("SmallClassName")
j = rSS("FileName")
iF cHEcKReMOtEUrL(j)=fALsE tHEn
j = l & "/" & rSS("FolderName") & "/" & k
j = rEPlACe(rEPlACe(j, "//", "/"), "//", "/")
cALl wEBdEBuG(j,"act=CreateClass&ProDid=" & o & "&ProSid=" &q)
eND iF
r = fONtCOlORfONtB(q,rSS("FontB"),rSS("FontColor"))
n = rSS("Target") : n="_blank"
i = i & cOPySTr(" ",12) & "<li><a "& aHReF(j,"",n) &">" & r & "</a>"
rSX.oPEn"Select * From [ThreeClass] Where BigClassName='"& o &"' And SmallClassName='"& q &"' Order By Sort,ID Asc",cONn,1,1
v = ""
fOR g = 1 tO rSX.rECoRDcOUnT	
k = rSX("FileName")
iF k <> "" tHEn k = k & ".html"
s = rSX("ThreeClassName")
j = rSX("FileName")
iF cHEcKReMOtEUrL(j)=fALsE tHEn
j = l & m & "/" & rSX("FolderName") & "/" & k
j = rEPlACe(rEPlACe(j, "//", "/"), "//", "/")
cALl wEBdEBuG(j,"act=CreateClass&ProDid=" & o & "&ProSid=" & q & "&ProTid=" & s)
eND iF
t = fONtCOlORfONtB(s,rSX("FontB"),rSX("FontColor"))
n = rSX("Target") : n="_blank"
v = v & "<a "& aHReF(j,"",n) &">" & t & "</a>"	
rSX.mOVeNExT : nEXt : rSX.cLOsE
iF v <> "" tHEn i=i & "("& v &")"
i=i & "</li>" & vBCrLF
rSS.mOVeNExT: nEXt
i=i & cOPySTr(" ",8) & "</ul>" & vBCrLF
u=tRUe
eND iF : rSS.cLOsE
iF u=tRUe tHEn
i=i & cOPySTr(" ",4) & "</li><div class=""clear""></div>" & vBCrLF
eLSe
i=i & "</li>" & vBCrLF
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
i=i & "</ul>" & vBCrLF	
i=i & "</div>" & vBCrLF
i=i & "<!--SiteMap end-->" & vBCrLF & vBCrLF
sITeMAp2=i
eND fUNcTIoN
%>

