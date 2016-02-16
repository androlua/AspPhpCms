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
fUNcTIoN pROdUCtLIsT(a, b, c, d, e, f, bYVaL g)
dIM h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x
dIM y, z, aA, bA, cA, dA, eA
dIM fA, gA, hA, iA, jA, kA, lA, mA
dIM nA, oA, pA, qA, rA, sA, tA, uA,  vA, wA
dIM xA,yA,zA,aBB,bBB,cBB,dBB
dIM eBB,fBB,dOWnLOaDMoDUlETyPElISt	
dIM hBB
sET hBB = cREaTEoBJeCT("Adodb.RecordSet")
dIM pAGePArAM	
dIM mODuLEnAMe	
dIM tITlELeN	
dIM nEWfILe	
dIM aRTiCLeDEsCRiPTiON	
dIM mODi	
dIM aIMg	
nEWfILe=cREaTEhTMlPAtH	
iF iNStR(cREaTEhTMlPAtH,".")>0 tHEn
nEWfILe=mID(cREaTEhTMlPAtH,1,iNStR(cREaTEhTMlPAtH,".")-1)	
nEWfILe = hOSt() & nEWfILe & "[id]" & mID(cREaTEhTMlPAtH,iNStR(cREaTEhTMlPAtH,"."))
eND iF	
nEWfILe = hANdLEhTTpURl(nEWfILe)
iF a <> "" tHEn
pAGePArAM=pAGePArAM & "&ProDid=" & a
eND iF
iF b <> "" tHEn
pAGePArAM=pAGePArAM & "&ProSid=" & b
eND iF
iF c <> "" tHEn
pAGePArAM=pAGePArAM & "&ProTid=" & c
eND iF
iF a="" tHEn a = "产品"
iF wEBaCTiONtYPe = "Nav" tHEn
a = wEBnAVdID : b = wEBnAVsID       	
eND iF
iF d = "Search" tHEn
h = ""
iF iNStR(e, "{分}") > 0 tHEn
w = sPLiT(e, "{分}")
iF w(2) <> "" tHEn
h = " And BigClassName='" & w(0) & "' And SmallClassName='" & w(1) & "' And ThreeClassName='" & w(2) & "'"
eLSeIF w(1) <> "" tHEn
h = " And BigClassName='" & w(0) & "' And SmallClassName='" & w(1) & "'"
eLSeIF w(0) <> "" tHEn
h = " And BigClassName='" & w(0) & "'"
eND iF
eND iF
i = "Select * From [Product] Where Title Like '%" & f & "%'" & h
fA = "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & rEQuESt.sERvERvARiABlES("SCRIPT_NAME")
gA = sPLiT(rEQuESt.sERvERvARiABlES("QUERY_STRING"), "&")
fOR eACh l iN gA
hA = sPLiT(l, "=")
iF sTRcOMp(hA(0), "page", vBTeXTcOMpARe) <> 0 tHEn
iA = iA & hA(0) & "=" & hA(1) & "&"
eND iF
nEXt
jA = fA & "?" & iA & "page="
eLSeIF c <> "" tHEn
i = "Select * From [Product] Where BigClassName='" & a & "' And SmallClassName='" & b & "' And ThreeClassName='" & c & "'"
eLSeIF b <> "" tHEn
i = "Select * From [Product] Where BigClassName='" & a & "' And SmallClassName='" & b & "'"
eLSe
i = "Select * From [Product] Where BigClassName='" & a & "'"
eND iF
wEBnAVtYPe = ""
v = "对不起，没有找到目标！关键词尽量要精简！"
dIM tEMpLAtESoURcEId	
tEMpLAtESoURcEId = gETaRTiCLeLIsTStYLe(a,b,c)
nA = rEAdARtIClELiSTsTYlESoURcE(tEMpLAtESoURcEId)
n = gETaRTiCLePAgESiZE(a,b,c)
dIM qBB,rBB,sBB
zA="<!--#config "
aBB="#-->"
qBB=gETsTRcUT(nA,zA,aBB,2)
rBB=lCAsE(rPArAM(qBB,"dispalyPageInfo"))
sBB=hANdLEnUMbER(rPArAM(qBB,"nPageSize"))
iF sBB<>"" tHEn n=cINt(sBB)
iF iSNuL(tITlELeN)=tRUe tHEn tITlELeN = 32	
iF iSNuL(n)=tRUe tHEn n = 3	
cALl gETtEMpLAtESpLIt(nA, oA, pA, qA)
iF pA="" tHEn
pROdUCtLIsT =  "出错了2，S=" & rA & "<hr>，里面没有Did=【" & a & "】这个参数。" & tEMpLAtESoURcEId
eXIt fUNcTIoN
eND iF
i = gETwHErEAnD(i,h)
i = gETwHErEAnD(i,gETpROdUCtLIsTSoRT(a,b,c))	
hBB.oPEn i, cONn, 1, 1
iF nOT hBB.eOF tHEn
v = "搜索结果：符合查询条件的记录 <strong>" & hBB.rECoRDcOUnT & " </strong>条，以下为您列出"
hBB.pAGeSIzE = n
m = hBB.rECoRDcOUnT
n = hBB.pAGeSIzE
o = hBB.pAGeCOuNT
iF nOT iSNuMErIC(g) oR g = "" tHEn
g = 1
eLSe
g = cINt(g)
eND iF
iF g < 1 tHEn
g = 1
eLSeIF g > o tHEn
g = o
eND iF
hBB.aBSoLUtEPaGE = g
iF g = o tHEn
l = m - (o - 1) * n
eLSe
l = n
eND iF
fOR j = 1 tO l	
q = hBB("FileName")
iF cHEcKReMOtEUrL(q)=fALsE tHEn	
q = gEThANdLEuRL(hBB("FileName"))
cALl wEBdEBuG(q, "act=CreateArticle&ID=" & hBB("Id"))
eND iF
aRTiCLeDEsCRiPTiON = hBB("ArticleDescription")	
iF aRTiCLeDEsCRiPTiON="#" oR aRTiCLeDEsCRiPTiON="null" oR aRTiCLeDEsCRiPTiON="empty" tHEn
aRTiCLeDEsCRiPTiON = ""
eLSeIF iSNuL(aRTiCLeDEsCRiPTiON) tHEn
aRTiCLeDEsCRiPTiON = hBB("Content")
eND iF	
sA = iIF(iSNuL(hBB("SmallFiles")), hBB("BigFiles"), hBB("SmallFiles"))
sA = rEPlACeGLoBLeLAbLE(sA)
iF sA="" tHEn
sA = "/UploadFiles/NoImg.jpg"
eND iF
tA = "<img src='" & sA & "'" & sEThTMlPArAM(fA, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
aIMg = iMGsRC(sA, hBB("Title"), hBB("Target"))
uA = "<a src='" & hBB("BigFiles") & "'" & sEThTMlPArAM(fA, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
s = cUTsTR(hBB("Title"), tITlELeN, "... ")
s = fONtCOlORfONtB(s, hBB("FontB"), hBB("FontColor"))
uA = "<a " & aHReF(q, hBB("Title"), hBB("Target")) & sEThTMlPArAM(fA, "aclass") & ">" & s & "</a>" & vBCrLF
vA = aHReF(q, hBB("Title"), hBB("Target")) & sEThTMlPArAM(fA, "aclass")
iF f <> "" tHEn
s = rEPlACe(s, f, "<font color=red><b>" & f & "</b></font>")
eND iF
zA="[list-"& j &"]" : aBB="[/list-"& j &"]"	
fOR mODi=6 tO 2 sTEp -1
iF iNStR(pA,zA)=fALsE aND j mOD mODi =0 tHEn
zA="[list-mod"& mODi &"]" : aBB="[/list-mod"& mODi &"]"
iF iNStR(pA,zA)>0 tHEn
eXIt fOR
eND iF
eND iF
nEXt 	
iF iNStR(pA,zA)=fALsE tHEn
zA="[list]" : aBB="[/list]"
eND iF
iF iNStR(pA,zA) aND iNStR(pA,aBB) tHEn
rA = sTRcUT(pA,zA,aBB,2)
eLSe
rA = pA
eND iF
rA = rEPlACe(rA,"[$i$]",j)
rA = rEPlACe(rA,"[$i-1$]",j-1)
fOR k=1 tO 6
rA = rEPlACeVAlUEpARaM(rA,"ni",j)	
rA = rEPlACeVAlUEpARaM(rA,"编号-1",j-1)	
rA = rEPlACeVAlUEpARaM(rA,"编号",j)	
rA = rEPlACeVAlUEpARaM(rA,"title",hBB("Title"))
rA = rEPlACeVAlUEpARaM(rA,"showtitle",s)
rA = rEPlACeVAlUEpARaM(rA,"adddatetime",hBB("AddDateTime"))
rA = rEPlACeVAlUEpARaM(rA,"imgfile",sA)
rA = rEPlACeVAlUEpARaM(rA,"imgurl",sA)
rA = rEPlACeVAlUEpARaM(rA,"img",sA)
rA = rEPlACeVAlUEpARaM(rA,"url",q)
rA = rEPlACeVAlUEpARaM(rA,"href",q)
rA = rEPlACeVAlUEpARaM(rA,"aurl",vA)
rA = rEPlACeVAlUEpARaM(rA,"astr",uA)
rA = rEPlACeVAlUEpARaM(rA,"aimg",aIMg)	
rA = rEPlACeVAlUEpARaM(rA,"description",hBB("WebDescription"))
rA = rEPlACeVAlUEpARaM(rA,"content",hBB("Content"))
rA = rEPlACeVAlUEpARaM(rA,"price",hBB("Price"))
rA = rEPlACeVAlUEpARaM(rA,"author",hBB("Author"))
rA = rEPlACeVAlUEpARaM(rA,"articledescription",aRTiCLeDEsCRiPTiON)
nEXt
rA = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"Product.Asp?act=ShowEditProduct&id=" & hBB("Id") & "&n=" & gETrND(11), rA)
p = p & rA
hBB.mOVeNExT : nEXt
eND iF : hBB.cLOsE
iF g <= 1 tHEn
y = "<span class='PageBox'>首页</span>"
z = "<span class='PageBox'>上一页</span>"
eLSe
iF jA <> "" tHEn	
q = jA & "1"
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=1")
y = "<a href='" & q & "'>首页</a>"
q = jA &(g - 1)
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & (g - 1))
z = "<a href='" & q & "'>上一页</a>"
eLSe
q = rEPlACe(nEWfILe,"[id]", "")
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=1")
y = "<a href='" & q & "'>首页</a>"
q = rEPlACe(nEWfILe,"[id]", g-1)
iF g-1=1 tHEn
q = rEPlACe(nEWfILe,"[id]", "")
eND iF
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & g - 1)
z = "<a href='" & q & "'>上一页</a>"
eND iF
eND iF
iF g >= o tHEn
aA = "<span class='PageBox'>下一页</span>"
bA = "<span class='PageBox'>尾页</span>"
eLSe
iF jA <> "" tHEn
q = jA &(g + 1)
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & (g+1))
aA = "<a href='" & q & "'>下一页</a>"
q = jA & o
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & o)
bA = "<a href='" & q & "'>尾页</a>"
eLSe
q = rEPlACe(nEWfILe,"[id]", g+1)
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & (g+1))
aA = "<a href='" & q & "'>下一页</a>"
q = rEPlACe(nEWfILe,"[id]", o)
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & o)
bA = "<a href='" & q & "'>尾页</a>"
eND iF
eND iF
cA = g - 2
dA = g + 2
iF cA <= 0 tHEn
dA = dA + cA * - 1 + 1
cA = 1
eND iF
iF dA > o tHEn
cA = cA + (o - dA)
dA = o
eND iF
fOR j = cA tO dA
iF j >= 1 aND j <= o tHEn
iF j = g tHEn
u = u & "<span class='PageBox'>" & j & "</span>"
eLSe
iF jA <> "" tHEn
q = jA & j & "'" & mA
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & j)
u = u & "&nbsp;<a href='" & q & ">" & j & "</a>"
eLSe
q = rEPlACe(nEWfILe,"[id]", iIF(j<>1,j,""))
cALl wEBdEBuG(q, "act=CreateClass"& pAGePArAM &"&Page=" & j)
u = u & "&nbsp;<a href='" & q & "'" & mA & ">" & j & "</a>"
eND iF
eND iF
eND iF
nEXt
p = oA & p & qA
iF rBB<>"false" aND rBB<>"0" tHEn
p = p & "<div class='t_page ColorLink'>总数：" & m & "条&nbsp;&nbsp;当前页数：<span class='FontRed'>" & g & "</span>/" & o & "&nbsp;" & y & "&nbsp;&nbsp;" & z & "&nbsp;" & u & "&nbsp;&nbsp;" & aA & "&nbsp;&nbsp;" & bA & "</div>"
eND iF
cREaTEpAGe = o
iF f <> "" tHEn
p = "<div class='SearchEcho'>" & v & "</div>" & vBCrLF & p
eND iF
pROdUCtLIsT = p
eND fUNcTIoN
fUNcTIoN gETpROdUCtLIsTSoRT(a,b,c)
dIM aDDsORtTYpE	
dIM oRDeRSoRTtYPe	
dIM tIMeSOrTTyPE	
dIM g
iF a<>"" tHEn
rS.oPEn"Select * From [BigClass] Where BigClassName='"& a &"'",cONn,1,1
iF nOT rS.eOF tHEn
aDDsORtTYpE = rS("AddSortType")
oRDeRSoRTtYPe = rS("OrderSortType")
tIMeSOrTTyPE = rS("TimeSortType")
eND iF:rS.cLOsE
eND iF
iF b<>"" tHEn
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS("AddSortType")="无" tHEn
aDDsORtTYpE=""
eLSeIF rS("AddSortType")="" tHEn
aDDsORtTYpE = rS("AddSortType")
eND iF
iF rS("OrderSortType")="无" tHEn
oRDeRSoRTtYPe=""
eLSeIF rS("OrderSortType")="" tHEn
oRDeRSoRTtYPe = rS("OrderSortType")
eND iF
iF rS("TimeSortType")="无" tHEn
tIMeSOrTTyPE=""
eLSeIF rS("TimeSortType")="" tHEn
tIMeSOrTTyPE = rS("TimeSortType")
eND iF
eND iF:rS.cLOsE
eND iF
iF b<>"" tHEn
rS.oPEn"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS("AddSortType")="无" tHEn
aDDsORtTYpE=""
eLSeIF rS("AddSortType")="" tHEn
aDDsORtTYpE = rS("AddSortType")
eND iF
iF rS("OrderSortType")="无" tHEn
oRDeRSoRTtYPe=""
eLSeIF rS("OrderSortType")="" tHEn
oRDeRSoRTtYPe = rS("OrderSortType")
eND iF
iF rS("TimeSortType")="无" tHEn
tIMeSOrTTyPE=""
eLSeIF rS("TimeSortType")="" tHEn
tIMeSOrTTyPE = rS("TimeSortType")
eND iF
eND iF:rS.cLOsE
eND iF
iF aDDsORtTYpE = "添加正排序" tHEn
iF g<>"" tHEn g = g & ","
g=g & "Id Asc"
eLSeIF aDDsORtTYpE = "添加倒排序" tHEn
iF g<>"" tHEn g = g & ","
g=g & "Id  Desc"	
eND iF
iF oRDeRSoRTtYPe = "顺序正排序" tHEn
iF g<>"" tHEn g = g & ","
g=g & "Sort Asc"
eLSeIF oRDeRSoRTtYPe = "顺序倒排序" tHEn
iF g<>"" tHEn g = g & ","
g=g & "Sort Desc"	
eND iF
iF tIMeSOrTTyPE = "时间正排序" tHEn
iF g<>"" tHEn g = g & ","
g=g & "AddDateTime Asc"
eLSeIF tIMeSOrTTyPE = "时间倒排序" tHEn
iF g<>"" tHEn g = g & ","
g=g & "AddDateTime Desc"	
eND iF
iF g<>"" tHEn g = " Order By " & g
gETpROdUCtLIsTSoRT = g
iF 1=2 tHEn
cALl eCHo("Did",a)
cALl eCHo("Sid",b)
cALl eCHo("Tid",c)
cALl eCHo("AddSortType",aDDsORtTYpE)
cALl eCHo("OrderSortType",oRDeRSoRTtYPe)
cALl eCHo("TimeSortType",tIMeSOrTTyPE)
cALl eCHo("Sql",g)
eND iF
eND fUNcTIoN
%>


