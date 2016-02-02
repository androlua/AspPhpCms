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
sELeCT cASe rEQuESt("a")
cASe "ayawawa", "wawa" : cALl aYAwAWa() : rESpONsE.eND()
cASe "row", "space" : cALl hANdROwSPaCE() : rESpONsE.eND()
cASe "ShowAoutAddList" : cALl sHOwAOuTAdDLiST() : rESpONsE.eND()
cASe "AutoAddWebInfo" : cALl aUToADdWEbINfO(rEQuESt("DataFolderPath")) : rESpONsE.eND()
cASe "ClearDatabases" : cALl cLEaRDaTAbASeS() : rESpONsE.eND()
cASe "AddDateViewWebEffect" : cALl aDDdATeVIeWWeBEfFEcT() : rESpONsE.eND()
eND sELeCT
sUB sHOwAOuTAdDLiST()
dIM b, c, d, e, f, g
d = "/DataDir/自动添加网站信息/"
cALl hANdLEpATh(d)
cALl eCHo("显示自动添加信息选择列表", d)
f = gETdIRfOLdERlISt(d)
cALl eCHo("清空数据库，方便查看程序是否添加成功", "<a href=?a=ClearDatabases>点击操作</a>")
cALl eCHo("写入数据查看网站效果", "<a href=?a=AddDateViewWebEffect>点击操作</a>")
b = sPLiT(f, vBCrLF)
fOR eACh d iN b
iF d <> "" tHEn
e = mID(d, iNStRReV(d, "\") + 1)
g = "?act=AutoAddWebInfo&DataFolderPath=" & d
cALl eCHo(e, "<a href='" & g & "' target='_self'>" & d & "</a>")
eND iF
nEXt
eND sUB
sUB aDDdATeVIeWWeBEfFEcT()
dIM b, c, d, e, f, g, h, i, j, k, l
dIM m, n
cALl oPEnCOnN()
c = "E:\E盘\WEB网站\网站备份\Datamaiside20141201.mdb"
sET b = cREaTEoBJeCT("Adodb.Connection")
b.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & c
rS.oPEn "Select * From [NavBigClass] Where (NavType='产品' Or NavType='新闻') Order By NavType", cONn, 1, 1
wHIlE nOT rS.eOF
iF iNStR("|" & d & "|", "|" & rS("BigClassName") & "|") = fALsE tHEn
d = d & rS("BigClassName") & "|"
eND iF
rS.mOVeNExT : wENd : rS.cLOsE
iF 1 = 2 tHEn
i = "E:\E盘\WEB网站\网站备份\文章\"
cALl dELeTEfOLdER(i)
cALl cREaTEfOLdER(i)
k = 0
rS.oPEn "Select * From [Product] Where Len(Content)>200", b, 1, 1
wHIlE nOT rS.eOF
k = k + 1
j = i & k & ".txt"
cALl eCHo("创建文章", j)
cALl cREaTEfILe(j, rS("Content"))
rS.mOVeNExT : wENd : rS.cLOsE
rESpONsE.eND()
eND iF
h = b.eXEcUTe("Select Count(*) From [Product] Where (BigFiles<>'' Or SmallFiles<>'')")(0)
cALl eCHo("nCount", h)
rS.oPEn "Select * From [BigClass]", cONn, 1, 1
wHIlE nOT rS.eOF
iF iNStR("|" & d & "|", "|" & rS("BigClassName") & "|") = fALsE tHEn
d = d & rS("BigClassName") & "|"
eND iF
rS.mOVeNExT : wENd : rS.cLOsE
l = 0
f = sPLiT(d, "|")
fOR eACh g iN f
iF g <> "" aND tRIm(lCAsE(g)) <> "banner" tHEn
cALl eCHo("大类名称", g & "(添加数量" & cOPyDAtEToWEbDAtE(cONn, b, g, 18, e, l) & ")")
eND iF
nEXt
eND sUB
fUNcTIoN cOPyDAtEToWEbDAtE(a, b, c, d, e, f)
dIM g, h, i, j, k, l, m, n
a.eXEcUTe("Delete From [Product] Where BigClassName='" & c & "'")
k = 0
fOR g = 1 tO d
n = " Where BigFiles<>'' Or SmallFiles<>''"
iF c = "常见问题" tHEn
n = " Where BigFiles='' And SmallFiles=''"
eND iF
rSX.oPEn "Select * From [Product]", b, 1, 3
i = tRUe
wHIlE nOT rSX.eOF aND i = tRUe
m = fALsE
iF c = "常见问题" aND rSX("BigFiles") = "" aND rSX("SmallFiles") = "" tHEn
m = tRUe
eLSeIF rSX("BigFiles") <> "" oR rSX("SmallFiles") <> "" tHEn
m = tRUe
eND iF
iF m = tRUe tHEn
iF iNStR("|" & e & "|", "|" & rSX(0) & "|") = fALsE tHEn
e = e & rSX(0) & "|"
i = fALsE
rSS.oPEn "Select * From [Product]", a, 1, 3
rSS.aDDnEW
rSS("BigClassName") = c
rSS("Title") = rSX("Title")
j = rEPlACe(tRIm(rSX("SmallFiles")), "\", "/")
iF lEFt(j, 1) = "/" tHEn j = "http://maiside.net/" & j
rSS("SmallFiles") = rSX("SmallFiles")
j = rEPlACe(tRIm(rSX("BigFiles")), "\", "/")
iF lEFt(j, 1) = "/" tHEn j = "http://maiside.net/" & j
rSS("BigFiles") = j
f = f + 1
l = rSX("Content")
iF lEN(l) < 200 tHEn
l = gETfTExT("E:\E盘\WEB网站\网站备份\文章\" & f & ".txt")
eND iF
rSS("WebTitle") = rSX("WebTitle")
rSS("WebKeywords") = rSX("WebKeywords")
rSS("WebDescription") = rSX("WebDescription")
rSS("FileName") = pINyIN(tRIm(rSX("Title")), 3)
iF lEN(l) < 255 tHEn
l = l & gETaRTiCLeFIlLCoNTeNT("", "", 9)
eND iF
rSS("Content") = l
rSS("Author") = "站长"
rSS("ArticleSource") = "本站"
k = k + 1
rSS.uPDaTE : rSS.cLOsE
eND iF
eND iF
rSX.mOVeNExT : wENd : rSX.cLOsE
nEXt
cOPyDAtEToWEbDAtE = k
eND fUNcTIoN
sUB cLEaRDaTAbASeS()
dIM b, c
cALl oPEnCOnN()
rS.oPEn "Select * From [WebSite]", cONn, 1, 3
iF nOT rS.eOF tHEn
rS("WebTitle") = "网站标题"
rS("WebKeywords") = "网站关键词"
rS("WebSiteBottom") = "网站底部"
rS.uPDaTE
eND iF : rS.cLOsE
rS.oPEn "Select * From [MainInfo]", cONn, 1, 3
fOR b = 1 tO rS.rECoRDcOUnT
rS("ShowTitle") = "文本标题(" & b & ")"
rS("Content") = "文本内容(" & b & ")"
rS.uPDaTE
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [Product]", cONn, 1, 3
fOR b = 1 tO rS.rECoRDcOUnT
rS("Title") = "信息标题(" & b & ")"
rS("Content") = "信息内容(" & b & ")"
iF rS("BigFiles") <> "" tHEn
rS("BigFiles") = "/UploadFiles/NoImg.jpg"
eND iF
iF rS("SmallFiles") <> "" tHEn
rS("SmallFiles") = "/UploadFiles/NoImg.jpg"
eND iF
rS("WebTitle") = "网站自定标题(" & b & ")"
rS("WebKeywords") = "网站关键词(" & b & ")"
rS("WebDescription") = "网站描述(" & b & ")"
rS.uPDaTE
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [NavBigClass]", cONn, 1, 3
fOR b = 1 tO rS.rECoRDcOUnT
rSX.oPEn "Select * From [SmallClass] Where BigClassName='" & rS("BigClassName") & "'", cONn, 1, 3
fOR c = 1 tO rSX.rECoRDcOUnT
rSX("BigClassName") = "大导航(" & b & ")"
rSX("SmallClassName") = "小导航(" & c & ")"
rSX.uPDaTE
rSX.mOVeNExT : nEXt : rSX.cLOsE
rS("BigClassName") = "大导航(" & b & ")"
rS.uPDaTE
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [FriendLink]", cONn, 1, 3
fOR b = 1 tO rS.rECoRDcOUnT
rS("Title") = "友链接(" & b & ")"
rS.uPDaTE
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [GuestBook]", cONn, 1, 3
fOR b = 1 tO rS.rECoRDcOUnT
rS("Content") = "留言内容(" & b & ")"
rS("Reply") = "回复内容(" & b & ")"
rS.uPDaTE
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [SearchCount]", cONn, 1, 3
fOR b = 1 tO rS.rECoRDcOUnT
rS("Title") = "搜索词(" & b & ")"
rS.uPDaTE
rS.mOVeNExT : nEXt : rS.cLOsE
cALl eCHo("操作完成", "空数据库方便调试程序成功")
eND sUB
sUB aUToADdWEbINfO(a)
dIM b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x
dIM y, z, aA, bA, cA, dA, eA, fA, gA, hA, iA
dIM jA, kA, lA, mA, nA, oA, pA, qA, rA, sA, tA, uA, vA, wA, xA, yA, zA
dIM aBB, bBB, cBB, dBB, eBB, fBB, gBB, hBB, iBB
dIM jBB, kBB, lBB
dIM mBB
dIM nBB
gBB = nOW()
z = hANdLEpATh(a) & "\"
cALl rW("<script type='text/javascript' src='/Skins/Default/Js/MyFunction.Js'></script>")
cALl eCHo("数据文件夹", z)
gA = " style='margin-top:10px;width:250px;height:16px;overflow:hidden;background:#ECE9D8;border:1px double #716F64;'"
cONn.eXEcUTe("Delete From [NavBigClass]")
cONn.eXEcUTe("Delete From [NavSmallClass]")
cONn.eXEcUTe("Delete From [BigClass]")
cONn.eXEcUTe("Delete From [SmallClass]")
cONn.eXEcUTe("Delete From [ThreeClass]")
cONn.eXEcUTe("Delete From [Product]")
cONn.eXEcUTe("Delete From [MainInfo]")
cONn.eXEcUTe("Delete From [SearchCount]")
cONn.eXEcUTe("Delete From [Member]")
cONn.eXEcUTe("Delete From [GuestBook]")
cONn.eXEcUTe("Delete From [FriendLink]")
cONn.eXEcUTe("Delete From [Admin]")
cALl dELeTEfOLdER("../UploadFiles/image")
cALl cREaTEfOLdER("../UploadFiles/image")
t = z & "网站配置.ini"
iF cHEcKFiLE(t) tHEn
p = gETfTExT(t)
rS.oPEn "Select * From [WebSite]", cONn, 1, 3
iF rS.eOF tHEn rS.aDDnEW
iF iNStR(p, "WebSiteUrl=") > 0 tHEn
rS("WebSiteUrl") = sTRcUT(p, "WebSiteUrl=", "【End】", 2)
eND iF
iF iNStR(p, "WebTitle=") > 0 tHEn
rS("WebTitle") = sTRcUT(p, "WebTitle=", "【End】", 2)
eND iF
iF iNStR(p, "WebKeywords=") > 0 tHEn
rS("WebKeywords") = sTRcUT(p, "WebKeywords=", "【End】", 2)
eND iF
iF iNStR(p, "WebDescription=") > 0 tHEn
rS("WebDescription") = sTRcUT(p, "WebDescription=", "【End】", 2)
eND iF
iF iNStR(p, "WebSiteBottom=") > 0 tHEn
rS("WebSiteBottom") = sTRcUT(p, "WebSiteBottom=", "【End】", 2)
eND iF
iF iNStR(p, "WebTemplate=") > 0 tHEn
rS("WebTemplate") = sTRcUT(p, "WebTemplate=", "【End】", 2)
eND iF
iF iNStR(p, "WebSkins=") > 0 tHEn
rS("WebSkins") = sTRcUT(p, "WebSkins=", "【End】", 2)
eND iF
iF iNStR(p, "WebImages=") > 0 tHEn
rS("WebImages") = sTRcUT(p, "WebImages=", "【End】", 2)
eND iF
iF iNStR(p, "WebCss=") > 0 tHEn
rS("WebCss") = sTRcUT(p, "WebCss=", "【End】", 2)
eND iF
iF iNStR(p, "WebJs=") > 0 tHEn
rS("WebJs") = sTRcUT(p, "WebJs=", "【End】", 2)
eND iF
rS.uPDaTE : rS.cLOsE
fA = "<div id='WebSite' " & gA & "><span onclick=""OnOffDiv(this,'WebSite')"">添加网站配置</span><br></div>" & vBCrLF
cALl rW(fA)
eND iF
t = z & "后台账号.ini"
iF cHEcKFiLE(t) tHEn
p = gETfTExT(t)
c = sPLiT(p, vBCrLF)
fOR e = 0 tO uBOuND(c)
h = c(e)
iF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||", "|")
vA = tRIm(d(0))
wA = d(1)
iF wA = "" tHEn wA = vA
hBB = d(2)
rS.oPEn "Select * From [Admin] Where UserName='" & vA & "'", cONn, 1, 3
iF rS.eOF tHEn rS.aDDnEW
rS("UserName") = vA
rS("Pwd") = mD5(wA, 2) & mD5(wA, 4)
rS("QuanXian") = hBB
rS.uPDaTE
fA = fA & "添加后台账号>>" & vA & "<br>"
rS.cLOsE
eND iF
nEXt
fA = "<div id='AdminUser' " & gA & "><span onclick=""OnOffDiv(this,'WebSite')"">添加后台账号</span><br></div>" & vBCrLF
cALl rW(fA)
eLSe
rS.oPEn "Select * From [Admin] Where UserName='admin'", cONn, 1, 3
vA = "admin" : wA = "admin"
iF rS.eOF tHEn rS.aDDnEW
rS("UserName") = vA
rS("Pwd") = mD5(wA, 2) & mD5(wA, 4)
rS.uPDaTE : rS.cLOsE
eND iF
aA = z & "导航/Nav.ini"
iF cHEcKFiLE(aA) = tRUe tHEn
p = gETfTExT(aA)
c = sPLiT(p, vBCrLF)
fA = "<div id='Nav' " & gA & "><span onclick=""OnOffDiv(this,'Nav')"">添加网站导航</span><br>" & vBCrLF
fOR e = 0 tO uBOuND(c)
h = c(e)
iF lCAsE(tRIm(h)) = "#end#" oR lCAsE(tRIm(h)) = "#end" tHEn
eXIt fOR
eLSeIF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||||||", "|")
bA = tRIm(d(0))
cA = tRIm(d(1))
dA = tRIm(d(2))
u = tRIm(d(3))
mBB = tRIm(d(4))
eA = tRIm(d(5))
iF cA = "" tHEn cA = "文本"
iF dA = "" tHEn dA = e
k = d(6)
cBB = d(7)
cBB = iIF(cBB = "" oR cBB = "1", tRUe, fALsE)
rS.oPEn "Select * From [NavBigClass] Where BigClassName='" & bA & "'", cONn, 1, 3
iF rS.eOF aND bA <> "" tHEn
rS.aDDnEW
rS("BigClassName") = bA
rS("NavTop") = tRUe
rS("NavType") = cA
rS("FileName") = u
rS("TemplatePath") = mBB
rS("OnHtml") = cBB
iF k = "NOFolderName" oR k = "NO文件夹" tHEn
k = ""
eLSeIF d(0) = "网站地图" tHEn
rS("FolderName") = "Sitemap"
eLSeIF d(1) <> "首页" tHEn
k = iIF(k = "", pINyIN(d(0), 3), k)
rS("FolderName") = k
eLSe
rS("FolderName") = "/"
eND iF
iF iNStR(eA, "NO顶部") > 0 tHEn rS("NavTop") = fALsE
iF iNStR(eA, "底部") > 0 tHEn rS("NavButtom") = tRUe
iF iNStR(eA, "左边") > 0 tHEn rS("NavLeft") = tRUe
iF iNStR(eA, "中间") > 0 tHEn rS("NavContent") = tRUe
iF iNStR(eA, "右边") > 0 tHEn rS("NavRight") = tRUe
iF iNStR(eA, "其它") > 0 tHEn rS("NavOthre") = tRUe
iF iNStR("|产品|新闻|", "|" & cA & "|") > 0 tHEn
cALl aUToADdBIgCLaSS(d(0))
eND iF
p = bA & " 详细信息内容写在这里面<hr>更多....."
t = z & "导航/" & bA & ".txt"
iF cHEcKFiLE(t) = tRUe tHEn
p = gETfTExT(t)
eND iF
rS("Content") = p
rS("Sort") = dA
fA = fA & "名称=" & bA & "<br>类型=" & cA & "<br>排序=" & dA & _
"<br>文件夹=" & k & "<br>静态文件名=" & u & "<br>模板=" & mBB & "<br>" & vBCrLF
rS.uPDaTE
t = z & "导航/" & bA & ".ini"
iF cHEcKFiLE(t) = tRUe tHEn
p = gETfTExT(t)
hA = sPLiT(p, vBCrLF)
fOR f = 0 tO uBOuND(hA)
h = hA(f)
iF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||", "|")
iA = d(0)
u = d(2)
mBB = d(3)
iF dA = "" tHEn dA = f
rSX.oPEn "Select * From [NavSmallClass] Where BigClassName='" & bA & "' And SmallClassName='" & iA & "'", cONn, 1, 3
iF rSX.eOF tHEn
rSX.aDDnEW
rSX("BigClassName") = bA
rSX("SmallClassName") = iA
rSX("FolderName") = pINyIN(iA, 3)
rSX("TemplatePath") = mBB
p = bA & " 详细信息内容写在这里面<hr>更多....."
t = z & "导航/" & bA & "》" & iA & ".txt"
iF cHEcKFiLE(t) = tRUe tHEn
p = gETfTExT(t)
eND iF
rSX("Content") = p
fA = fA & " &nbsp; &nbsp; 添加导航小类 " & bA & "》" & iA & "<br>"
rSX.uPDaTE
eND iF : rSX.cLOsE
eND iF
nEXt
eND iF
fA = fA & "<hr>" & vBCrLF
eND iF : rS.cLOsE
eND iF
nEXt
eND iF
cALl rW(fA & "</div>")
mA = z & "类别/Class.ini"
iF cHEcKFiLE(aA) = tRUe tHEn
p = gETfTExT(mA)
nA = sPLiT(p, vBCrLF)
fA = "<div id='Class' " & gA & "><span onclick=""OnOffDiv(this,'Class')"">添加产品类别</span><br>" & vBCrLF
fOR e = 0 tO uBOuND(nA)
h = nA(e)
iF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||", "|")
m = tRIm(d(0))
kA = d(1)
u = d(2)
mBB = d(3)
iF kA = "" tHEn kA = e
iF lEFt(d(0), 2) = vBTaB & vBTaB tHEn
lBB = m
rA = "Select * From [ThreeClass] Where BigClassName='" & jBB & "' And SmallClassName='" & kBB & "' And ThreeClassName='" & lBB & "'"
iF u = "" tHEn u = lBB
nBB = cOPySTr("&nbsp;", 8) & lBB
eLSeIF lEFt(d(0), 1) = vBTaB tHEn
kBB = m : lBB = ""
rA = "Select * From [SmallClass] Where BigClassName='" & jBB & "' And SmallClassName='" & kBB & "'"
iF u = "" tHEn u = kBB
nBB = cOPySTr("&nbsp;", 4) & kBB
eLSe
jBB = m : kBB = "" : lBB = ""
rA = "Select * From [BigClass] Where BigClassName='" & jBB & "'"
iF u = "" tHEn u = jBB
nBB = jBB
eND iF
rS.oPEn rA, cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
iF jBB <> "" tHEn rS("BigClassName") = jBB
iF kBB <> "" tHEn rS("SmallClassName") = kBB
iF lBB <> "" tHEn rS("ThreeClassName") = lBB
rS("Sort") = kA
rS("FolderName") = pINyIN(u, 3)
rS.uPDaTE
fA = fA & nBB & "<br>"
eND iF : rS.cLOsE
eND iF
nEXt
cALl rW(fA & "</div>")
eND iF
jA = z & "Product\"
iF cHEcKFoLDeR(jA) = tRUe tHEn
fA = "<div id='Product' " & gA & "><span onclick=""OnOffDiv(this,'Product')"">添加Product信息</span><br>" & vBCrLF
b = sPLiT(gETdIRiNIlISt(jA), vBCrLF)
fOR eACh t iN b
iF t <> "" tHEn
h = mID(t, iNStRReV(t, "\") + 1) : h = lEFt(h, lEN(h) - 4) & "》》"
d = sPLiT(h, "》")
m = d(0) : n = d(1) : o = d(2)
p = gETfTExT(t) & vBCrLF
iF iNStR(p, "#自动添加大类") > 0 aND m <> "" tHEn
cALl aUToADdBIgCLaSS(m)
eND iF
iF iNStR(p, "#自动添加小类") > 0 aND n <> "" tHEn
cALl aUToADdSMaLLcLAsS(m, n)
eND iF
iF iNStR(p, "#自动添加子类") > 0 aND o <> "" tHEn
cALl aUToADdTHrEEcLAsS(m, n, o)
eND iF
iF iNStR(p, "========================") > 0 tHEn
c = sPLiT(p, "========================" & vBCrLF)
eLSe
c = sPLiT(p, vBCrLF)
eND iF
fOR e = 0 tO uBOuND(c)
h = c(e)
iF h <> "" aND lEFt(tRIm(h), 1) <> "#" aND h <> vBCrLF tHEn
d = sPLiT(h & "||||||", "|")
l = d(0)
kA = d(1)
lA = d(2)
mBB = d(3)
u = aOTuGEtPRoDUcTFiLEnAMe(l)
rS.oPEn "Select * From [Product] Where BigClassName='" & m & "' And SmallClassName='" & n & "' And ThreeClassName='" & o & "' And Title='" & l & "'", cONn, 1, 3
iF rS.eOF aND tRIm(l) <> "" tHEn
rS.aDDnEW
rS("BigClassName") = m
rS("SmallClassName") = n
rS("ThreeClassName") = o
rS("Title") = l
rS("BigFiles") = lA
rS("TemplatePath") = mBB
rS("FileName") = u
p = m & ">>" & n & ">>" & o & ">><p>" & l & " 详细内容信息。"
rS("Content") = p
rS.uPDaTE
fA = fA & "大类=" & m & "<br>小类=" & n & "<br>子类=" & o & _
"<br>标题=" & l & "<br>静态文件名=" & u & "<br>模板=" & mBB & "<hr>" & vBCrLF
eND iF : rS.cLOsE
eLSeIF iNStR(h, "#导入文件夹#") > 0 tHEn
cALl lEAdINgIMaGE(m, n, o, h)
eLSeIF iNStR(h, "#导入新闻文件夹#") > 0 tHEn
cALl lEAdINgNEwS(m, n, o, h)
eND iF
nEXt
eND iF
nEXt
cALl rW(fA & "</div>")
eND iF
jA = z & "MainInfo\"
iF cHEcKFoLDeR(jA) = tRUe tHEn
fA = "<div id='MainInfo' " & gA & "><span onclick=""OnOffDiv(this,'MainInfo')"">添加MainInfo信息</span><br>" & vBCrLF
b = sPLiT(gETdIRiNIlISt(jA), vBCrLF)
fOR eACh t iN b
iF t <> "" tHEn
p = vBCrLF & gETfTExT(t) & vBCrLF
l = mID(t, iNStRReV(t, "\") + 1) : l = lEFt(l, lEN(l) - 4)
iF iNStR(p, "WebTitle=") > 0 tHEn
rS("WebTitle") = sTRcUT(p, "WebTitle=", "【End】", 2)
eND iF
rS.oPEn "Select * From [MainInfo]", cONn, 1, 3
rS.aDDnEW
iF iNStR(p, vBCrLF & "Title=") > 0 tHEn
l = sTRcUT(p, vBCrLF & "Title=", "【End】", 2)
eND iF
rS("Title") = l
iF iNStR(p, "ShowTitle=") > 0 tHEn
rS("ShowTitle") = sTRcUT(p, "ShowTitle=", "【End】", 2)
eND iF
iF iNStR(p, "Sort=") > 0 tHEn
rS("Sort") = sTRcUT(p, "Sort=", "【End】", 2)
eND iF
iF iNStR(p, "Content=") > 0 tHEn
rS("Content") = sTRcUT(p, "Content=", "【End】", 2)
eND iF
rS.uPDaTE : rS.cLOsE
fA = fA & "添加文本【" & l & "】<hr>"
eND iF
nEXt
cALl rW(fA & "</div>")
eND iF
t = z & "友情链接.ini"
iF cHEcKFiLE(t) = tRUe tHEn
p = gETfTExT(t)
c = sPLiT(p, vBCrLF)
fA = "<div id='FriendLink' " & gA & "><span onclick=""OnOffDiv(this,'FriendLink')"">添加友情链接</span><br>" & vBCrLF
fOR e = 0 tO uBOuND(c)
h = c(e) : i = lCAsE(tRIm(h))
iF i = "#end" oR i = "end" tHEn
eXIt fOR
eLSeIF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||", "|")
l = d(0)
v = d(1)
kA = iIF(d(2) = "", e, d(2))
sA = d(3)
tA = d(4)
uA = iIF(d(5) = "", tRUe, d(5))
rS.oPEn "Select * From [FriendLink] Where Title='" & l & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("Title") = l
rS("Url") = v
rS("Sort") = kA
rS("ImgPath") = sA
rS("Alt") = tA
rS("Through") = uA
rS("Target") = "_blank"
fA = fA & "标题=" & l & "<br>网址=" & v & "<br>排序=" & kA & "<br>" & vBCrLF
rS.uPDaTE
fA = fA & "<hr>" & vBCrLF
eND iF : rS.cLOsE
eND iF
nEXt
cALl rW(fA & "</div>")
eND iF
t = z & "SearchCount.ini"
iF cHEcKFiLE(t) = tRUe tHEn
p = gETfTExT(t)
c = sPLiT(p, vBCrLF)
fA = "<div id='SearchCount' " & gA & "><span onclick=""OnOffDiv(this,'SearchCount')"">添加搜索关键词</span><br>" & vBCrLF
fOR e = 0 tO uBOuND(c)
h = tRIm(c(e))
iF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||", "|")
l = d(0)
kA = d(1)
uA = iIF(d(2) = "" oR lCAsE(d(2)) = "true", 1, 0)
rS.oPEn "Select * From [SearchCount] Where Title='" & l & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("Title") = l
rS("Sort") = kA
rS("Through") = uA
rS("Target") = "_blank"
fA = fA & "标题=" & l & "<br>网址=" & v & "<br>排序=" & kA & "<br>" & vBCrLF
rS.uPDaTE
fA = fA & "<hr>" & vBCrLF
eND iF : rS.cLOsE
eND iF
nEXt
cALl rW(fA & "</div>")
eND iF
t = z & "Member.ini"
iF cHEcKFiLE(t) = tRUe tHEn
p = gETfTExT(t)
c = sPLiT(p, vBCrLF)
fA = "<div id='Member' " & gA & "><span onclick=""OnOffDiv(this,'Member')"">添加会员</span><br>" & vBCrLF
fOR e = 0 tO uBOuND(c)
h = tRIm(c(e))
iF h <> "" aND lEFt(tRIm(h), 1) <> "#" tHEn
d = sPLiT(h & "||||||", "|")
vA = d(0)
wA = d(1)
iF wA = "" tHEn wA = vA
rS.oPEn "Select * From [Member] Where UserName='" & vA & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("UserName") = vA
rS("Pwd") = mD5(wA, 2) & mD5(wA, 4)
fA = fA & "会员：" & vA & "<br>" & vBCrLF
rS.uPDaTE
fA = fA & "<hr>" & vBCrLF
eND iF : rS.cLOsE
eND iF
nEXt
cALl rW(fA & "</div>")
eND iF
aBB = 0
c = sPLiT("NavBigClass,NavSmallClass,Bigclass,SmallClass,ThreeClass", ",")
fOR eACh bBB iN c
rS.oPEn "Select * From [" & bBB & "] Where ImgPath=''", cONn, 1, 3
wHIlE nOT rS.eOF
iF bBB = "NavBigClass" oR bBB = "Bigclass" tHEn
iBB = tRIm(rS("BigClassName"))
eLSeIF bBB = "NavSmallClass" oR bBB = "SmallClass" tHEn
iBB = tRIm(rS("SmallClassName"))
eLSeIF bBB = "ThreeClass" tHEn
iBB = tRIm(rS("ThreeClassName"))
eND iF
t = "/Data/WebImg/Banner/" & iBB & ".jpg"
iF cHEcKFiLE(t) = tRUe tHEn
rS("ImgPath") = t
eLSeIF a = "E:\E盘\WEB网站\至前网站\DataDir\自动添加网站信息\麦思德" tHEn
rS("ImgPath") = "/Data/WebImg/Banner/麦思德理念.jpg"
eLSe
aBB = aBB + 1
iF aBB > 21 tHEn aBB = iNT(aBB / 21) + 1
rS("ImgPath") = "/Skins/YouKou/Index/Banner/Banner" & aBB & ".jpg"
eND iF
rS.mOVeNExT : wENd : rS.cLOsE
nEXt
iF a = "E:\E盘\WEB网站\至前网站\DataDir\自动添加网站信息\麦思德" tHEn
cALl lEAdINgPRoDUcTClASs("副导航", "汉堡加盟菜单", "", "\DataDir\自动添加网站信息\麦思德\Product\数据\产品\")
cALl lEAdINgPRoDUcTClASs("副导航", "汉堡培训分类", "", "\DataDir\自动添加网站信息\麦思德\Product\数据\产品\")
cALl eCHo("当前操作网站", "麦思德")
eLSe
iF a = "E:\E盘\WEB网站\至前网站\DataDir\自动添加网站信息\微战略" tHEn
cALl eCHo("当前操作网站", "微战略")
eND iF
cALl cREaTEfOLdER("\UploadFiles\image\Product")
p = gETdIRfILeLIsT("/UploadFiles/培训图片/") & cOPySTr(vBCrLF, 99)
c = sPLiT(p, vBCrLF)
rS.oPEn "Select * From [ThreeClass] Where BigClassName='产品展示'", cONn, 1, 1
fOR e = 1 tO rS.rECoRDcOUnT
qA = " And ThreeClassName='" & rS("ThreeClassName") & "' And Title='" & rS("ThreeClassName") & "'"
rSX.oPEn "Select * From [Product] Where BigClassName='" & rS("BigClassName") & "' And SmallClassName='" & rS("SmallClassName") & "' " & qA, cONn, 1, 3
iF rSX.eOF tHEn
rSX.aDDnEW
h = c(e - 1)
h = rEPlACe(h, sERvER.mAPpATh("/"), "")
rSX("BigClassName") = rS("BigClassName")
rSX("SmallClassName") = rS("SmallClassName")
rSX("ThreeClassName") = rS("ThreeClassName")
rSX("Title") = rS("ThreeClassName")
rSX("BigFiles") = h
rSX("FileName") = gETrND(9)
p = rS("BigClassName") & ">>" & rS("SmallClassName") & ">>" & rS("ThreeClassName") & ">><p>" & rS("ThreeClassName") & " 详细内容信息。"
rSX("Content") = p
rSX.uPDaTE
eND iF : rSX.cLOsE
rS.mOVeNExT : nEXt : rS.cLOsE
p = gETdIRjPGlISt(z & "\Product\数据\产品\")
c = sPLiT(p, vBCrLF)
fOR eACh h iN c
iF h <> "" tHEn
l = gETfILePAtHNaME(h)
rSX.oPEn "Select * From [Product] Where Title='" & l & "'", cONn, 1, 3
iF rSX.eOF tHEn rSX.aDDnEW
t = lEFt(h, lEN(h) - 4) & ".jpg"
eBB = "/UploadFiles/image/Product/" & l & ".jpg"
iF cHEcKFiLE(eBB) = fALsE tHEn cALl cOPyFIlE(t, eBB)
rSX("BigFiles") = eBB
p = ""
fBB = z & "Product\数据\产品\" & h & ".txt"
iF cHEcKFiLE(fBB) = fALsE tHEn fBB = z & "Product\数据\产品\默认培训.txt"
p = p & rEPlACe(rEPlACe(gETfTExT(fBB), vBCrLF, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
rSX("Content") = p
rSX.uPDaTE
rSX.cLOsE
eND iF
nEXt
eND iF
cALl xY_aUToBAtCHaDDaRTiCLe("FolderPath='" & z & "\自动批量添加文章信息' ")
cALl eCHo("自动生成数据文件夹路径", z)
cALl rW(gETtIMeR())
iF rEQuESt("WebDebug") = "True" tHEn
rESpONsE.rEDiREcT("/Inc/Create_Html.Asp?act=Nav&NavType=首页&Debug=1&MackHtml=False")
eND iF
eND sUB
sUB lEAdINgIMaGE(a, b, c, d)
dIM e, f, g, h, i, j, k, l, m
e = tRIm(rEPlACe(d, "#导入文件夹#", ""))
f = gETdIRfILeLIsT(e)
g = sPLiT(f, vBCrLF) : k = 0
fOR eACh i iN g
iF i <> "" tHEn
k = k + 1
i = rEPlACe(i, sERvER.mAPpATh("/"), "")
l = "/UploadFiles/image/" & mID(i, iNStRReV(i, "\") + 1)
iF cHEcKFiLE(l) = fALsE tHEn cALl cOPyFIlE(i, l)
rS.oPEn "Select * From [Product]", cONn, 1, 3
rS.aDDnEW
m = gETfILePAtHNaME(i)
rS("BigClassName") = a
rS("SmallClassName") = b
rS("ThreeClassName") = c
rS("Title") = m
rS("BigFiles") = l
rS("FileName") = aOTuGEtPRoDUcTFiLEnAMe(m)
rS.uPDaTE : rS.cLOsE
eND iF
nEXt
eND sUB
sUB lEAdINgNEwS(a, b, c, d)
dIM e, f, g, h, i, j, k, l
e = tRIm(rEPlACe(d, "#导入新闻文件夹#", ""))
f = gETdIRtXTlISt(e)
g = sPLiT(f, vBCrLF) : k = 0
fOR eACh i iN g
iF i <> "" tHEn
k = k + 1
i = rEPlACe(i, sERvER.mAPpATh("/"), "")
rS.oPEn "Select * From [Product]", cONn, 1, 3
rS.aDDnEW
l = gETfILePAtHNaME(i)
rS("BigClassName") = a
rS("SmallClassName") = b
rS("ThreeClassName") = c
rS("Title") = l
rS("FileName") = aOTuGEtPRoDUcTFiLEnAMe(l)
f = rEPlACe(gETfTExT(i), vBCrLF, "<br>")
rS("Content") = f
rS.uPDaTE : rS.cLOsE
eND iF
nEXt
eND sUB
sUB lEAdINgPRoDUcTClASs(a, b, c, d)
dIM e, f, g, h, i, j, k, l, m
m = gETdIRfOLdERlISt(tRIm(d))
iF c = "" tHEn
g = sPLiT(m, vBCrLF)
fOR eACh e iN g
iF e <> "" tHEn
c = gETfILePAtHNaME(e)
cALl lEAdINgIMaGE(a, b, c, e)
eND iF
nEXt
eND iF
eND sUB
sUB cLAsSToADdPRoDUcT(a, b, c, d)
dIM e, f
iF b <> "" tHEn
f = " Where BigClassName='" & b & "' "
eND iF
iF tABlECoUNt("SmallClass", f) = 0 tHEn
rS.oPEn "Select * From [BigClass] " & f, cONn, 1, 1
wHIlE nOT rS.eOF
rSX.oPEn "Select * From [Product] Where BigClassName='" & rS("BigClassName") & "'", cONn, 1, 3
iF rSX.eOF tHEn
rSX.aDDnEW
rSX("BigClassName") = rS("BigClassName")
rSX("Title") = rS("BigClassName")
e = gETfTExT(a & "/Product/数据/默认文章.txt")
e = e & rEPlACe(rEPlACe(e, vBCrLF, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
rSX("Content") = e
rSX("FileName") = aOTuGEtPRoDUcTFiLEnAMe(rS("BigClassName"))
rSX.uPDaTE
eND iF : rSX.cLOsE
rS.mOVeNExT : wENd : rS.cLOsE
eND iF
iF c <> "" tHEn
f = " And SmallClassName='" & c & "' "
eND iF
iF tABlECoUNt("ThreeClass", f) = 0 tHEn
rS.oPEn "Select * From [SmallClass] ", f, cONn, 1, 1
wHIlE nOT rS.eOF
rSX.oPEn "Select * From [Product] Where BigClassName='" & rS("BigClassName") & "' And SmallClassName='" & rS("SmallClassName") & "'", cONn, 1, 3
iF rSX.eOF tHEn
rSX.aDDnEW
rSX("BigClassName") = rS("BigClassName")
rSX("SmallClassName") = rS("SmallClassName")
rSX("Title") = rS("SmallClassName")
e = gETfTExT(a & "/Product/数据/默认文章.txt")
e = e & rEPlACe(rEPlACe(e, vBCrLF, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
rSX("Content") = e
rSX("FileName") = aOTuGEtPRoDUcTFiLEnAMe(rS("SmallClassName"))
rSX.uPDaTE
eND iF : rSX.cLOsE
rS.mOVeNExT : wENd : rS.cLOsE
eND iF
iF d <> "" tHEn
f = " And ThreeClassName='" & d & "' "
eND iF
rS.oPEn "Select * From [ThreeClass] " & f, cONn, 1, 1
wHIlE nOT rS.eOF
rSX.oPEn "Select * From [Product] Where BigClassName='" & rS("BigClassName") & "' And SmallClassName='" & rS("SmallClassName") & "' And ThreeClassName='" & rS("ThreeClassName") & "'", cONn, 1, 3
iF rSX.eOF tHEn
rSX.aDDnEW
rSX("BigClassName") = rS("BigClassName")
rSX("SmallClassName") = rS("SmallClassName")
rSX("ThreeClassName") = rS("ThreeClassName")
rSX("Title") = rS("ThreeClassName")
e = gETfTExT(a & "/Product/数据/默认文章.txt")
e = e & rEPlACe(rEPlACe(e, vBCrLF, "<br>"), "    ", "&nbsp;&nbsp;&nbsp;&nbsp;")
rSX("Content") = e
rSX("FileName") = aOTuGEtPRoDUcTFiLEnAMe(rS("ThreeClassName"))
rSX.uPDaTE
eND iF : rSX.cLOsE
rS.mOVeNExT : wENd : rS.cLOsE
eND sUB
sUB aYAwAWa()
rESpONsE.aDDhEAdER "Content-Type", "text/html; charset=gb2312"
dIM b, c, d, e, f, g, h, i, j, k, l, m, n
l = "E:\E盘\需要文件\ayawawa\"
iF cHEcKFoLDeR(l) = fALsE tHEn
cALl cREaTEfOLdER(l)
eND iF
f = gETdIRfILeLIsT("E:\E盘\WEB网站\至前网站\函数\Tools\DataDir\http：揦揦diary。jiayuan。com揦\")
n = n
b = sPLiT(f, vBCrLF)
fOR eACh h iN b
iF h <> "" tHEn
i = cHEcKCoDE(h)
e = rEAdFIlE(h, 0)
iF iNStR(e, "_杨冰阳_世纪佳缘交友网</title>") > 0 tHEn
g = sTRcUT(e, "<title>", "_杨冰阳_", 2)
k = sTRcUT(e, "<!-- JiaThis Button END -->" & vBCrLF & "<span>", "</span></h5>", 2)
k = fORmAT_TImE(k, 2)
j = k & " " & sETfILeNAmE(g) & ".txt"
f = sTRcUT(e, "<div class=""txt"">", "<span class=""jiathis_txt"">分享到</span>", 2)
f = rEPlACe(dELhTMl(f), "&nbsp;", " ")
f = dELhTMlNOtE(f)
f = uNHtMLcODe(f)
m = l & j
cALl cREaTEfILe(m, f)
n = n + 1
cALl eCHo("保存成功【" & n & "】", m)
eND iF
dOEvENtS
eND iF
nEXt
rESpONsE.eND()
eND sUB
sUB hANdROwSPaCE()
rESpONsE.aDDhEAdER "Content-Type", "text/html; charset=gb2312"
dIM b, c, d, e, f, g, h, i, j, k, l, m, n, o
l = sERvER.mAPpATh("ayawawa\") & "\"
iF cHEcKFoLDeR(l) = fALsE tHEn
cALl cREaTEfOLdER(l)
eND iF
f = gETdIRfILeLIsT("E:\E盘\WEB网站\至前网站\ayawawa")
b = sPLiT(f, vBCrLF)
fOR eACh h iN b
iF h <> "" tHEn
i = cHEcKCoDE(h)
e = rEAdFIlE(h, 1)
e = uNHtMLcODe(e)
o = sPLiT(e, vBCrLF) : e = ""
fOR eACh d iN o
e = e & tRIm(d) & vBCrLF
nEXt
j = mID(h, iNStRReV(h, "\"))
cALl eCHo("创建成功", j)
m = l & j
cALl cREaTEfILe(h, e)
dOEvENtS
eND iF
nEXt
rESpONsE.eND()
eND sUB
sUB aYAwAWaSInA()
rESpONsE.aDDhEAdER "Content-Type", "text/html; charset=gb2312"
dIM b, c, d, e, f, g, h, i, j, k, l, m, n
l = "E:\E盘\需要文件\Ayawawa_Sina\"
iF cHEcKFoLDeR(l) = fALsE tHEn
cALl cREaTEfOLdER(l)
eND iF
f = gETdIRfILeLIsT("E:\E盘\WEB网站\至前网站\函数\Tools\DataDir\http：揦揦blog。sina。com。cn揦\")
n = n
b = sPLiT(f, vBCrLF)
fOR eACh h iN b
iF h <> "" tHEn
i = cHEcKCoDE(h)
e = rEAdFIlE(h, 0)
g = sTRcUT(e, "<title>", "</title>", 2)
iF iNStR(g, "_ayawawa_") > 0 tHEn
g = mID(g, 1, iNStR(g, "_ayawawa_") - 1)
eND iF
iF iNStR(g, "娃娃微问答") > 0 oR iNStR(g, "娃娃微信答") > 0 tHEn
g = rEPlACe(g, "&nbsp;", " ")
g = mID(g, 11)
eND iF
iF iNStR(g, "答读者来信") > 0 tHEn
g = mID(g, 7)
eND iF
iF iNStR(g, "【来信】") > 0 tHEn
g = mID(g, 5)
eND iF
iF iNStR(e, "<span class=""time SG_txtc"">(") = fALsE tHEn
cALl eCHo(h, "没有时间可截取")
eLSe
k = sTRcUT(e, "<span class=""time SG_txtc"">(", ")</span>", 2)
k = fORmAT_TImE(k, 2)
j = k & " " & sETfILeNAmE(g) & ".txt"
f = sTRcUT(e, "<!-- 正文开始 -->", "<!-- 正文结束 -->", 2)
f = rEPlACe(dELhTMl(f), "&nbsp;", " ")
f = dELhTMlNOtE(f)
f = uNHtMLcODe(f)
iF iNStR(f, "我的更多文章：") > 0 tHEn
f = mID(f, 1, iNStRReV(f, "我的更多文章：") - 8)
eND iF
m = l & j
cALl cREaTEfILe(m, f)
n = n + 1
cALl eCHo("保存成功【" & n & "】", m)
eND iF
dOEvENtS
eND iF
nEXt
rESpONsE.eND()
eND sUB
sUB aDDlAOlUO()
dIM b, c, d, e, f, g, h, i, j, k, l, m
dIM n, o
b = "E:\E盘\需要文件\学习\好文章\老罗语录.txt"
h = gETfTExT(b)
c = sPLiT(h, "====== 回答记者问 ======")
n = c(0)
o = c(1)
c = sPLiT(n, vBCrLF)
i = "罗永浩" : j = "语录"
m = cONn.eXEcUTe("Select Count(*) From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' ")(0)
fOR eACh h iN c
h = tRIm(h)
iF h <> "" tHEn
rS.oPEn "Select * From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' And Content='" & h & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("BigclassName") = i
rS("SmallClassName") = j
m = m + 1
rS("Title") = m
rS("Sort") = m
rS("Content") = h
cALl eCHo(l, "添加成功")
rS.uPDaTE
eND iF : rS.cLOsE
eND iF
nEXt
c = sPLiT(o, vBCrLF & vBCrLF)
i = "罗永浩" : j = "语录"
m = cONn.eXEcUTe("Select Count(*) From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' ")(0)
fOR eACh h iN c
h = tRIm(h)
iF rEPlACe(h, vBCrLF, "") <> "" tHEn
rS.oPEn "Select * From [Product] Where BigclassName='" & i & "' And SmallClassName='" & j & "' And Content='" & h & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("BigclassName") = i
rS("SmallClassName") = j
m = m + 1
rS("Title") = m
rS("Sort") = m
rS("Content") = h
cALl eCHo(l, "添加成功")
rS.uPDaTE
eND iF : rS.cLOsE
eND iF
nEXt
eND sUB
%>

