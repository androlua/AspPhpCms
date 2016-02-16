<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-03
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN sCRoLLpHOtO(a,b,c,d,e,f)
dIM g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v
q = 22
g=g & "<div id="""& e &""">" & vBCrLF
g=g & "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vBCrLF
g=g & "  <tr>" & vBCrLF
h="Select * From [Product] Where BigClassName='" & a &"'"&f
rS.oPEn h,cONn,1,1
fOR o=1 tO b
iF rS.eOF tHEn eXIt fOR
i = rS("FileName")
iF cHEcKReMOtEUrL(i)=fALsE tHEn
i = gEThANdLEuRL( rS("FileName") )	
cALl wEBdEBuG(i,"act=CreateArticle&ID=" & rS("Id") )
eND iF
k = "_top"
j = rS("Title")
u = iIF(rS("TitleAlt")="",j,rS("TitleAlt"))
t = 20
s = cUTsTR(j,t,"... ")
s = fONtCOlORfONtB(s,rS("FontB"),rS("FontColor"))
l = "<a "& aHReF(i,u,k) &">"
iF iSNuL(rS("SmallFiles")) tHEn	
iF iSNuL(rS("BigFiles")) tHEn p="Images/error.gif" eLSe p=rS("BigFiles")
eLSe
iF iSNuL(rS("SmallFiles")) tHEn p="Images/error.gif" eLSe p=rS("SmallFiles")
eND iF
r = iIF(rS("BigFilesAlt")="",j,rS("BigFilesAlt"))
iF m = "nonehref" tHEn
l = "<a href=""#"" " & v & ">"
eND iF
g=g & "    <td width=""200"" height=""170"" valign=""middle""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vBCrLF
g=g & "      <tr>" & vBCrLF
g=g & "        <td align=""center"">" & l & "<img src=""" & p & """ width=""" & c & """ height=""" & d & """ border=""0"" "& iMGtITlEAlT(r) &" class=""idimg""></a></td>" & vBCrLF
g=g & "      </tr>" & vBCrLF
g=g & "      <tr>" & vBCrLF
g=g & "        <td height=""30"" align=""center"">" & vBCrLF
g=g & l & s &"</a>" & vBCrLF
iF n tHEn
g=g & "<br>价格:<font color=red>"&rS("Price")&"￥</font>" & vBCrLF
g=g & "&nbsp;&nbsp;<a href=""Shop.Asp?Id="&rS(0)&""" class=Price>购买</a>" & vBCrLF
eND iF	
g=g & "                  </td>" & vBCrLF
g=g & "      </tr>" & vBCrLF
g=g & "    </table></td>" & vBCrLF
g=g & "    <td width=""15"">&nbsp;</td>" & vBCrLF
rS.mOVeNExT:nEXt:rS.cLOsE
g=g & "    <td>&nbsp;</td>" & vBCrLF
g=g & "  </tr>" & vBCrLF
g=g & "</table>" & vBCrLF
g=g & "</div>" & vBCrLF
sCRoLLpHOtO = g
eND fUNcTIoN
fUNcTIoN fRIeNDlINk()
dIM b, c, d, e, f, g, h
rSX.oPEn "Select * From [FriendLink] Where Through=True Order By Sort", cONn, 1, 1
fOR g = 1 tO rSX.rECoRDcOUnT
b = rSX("Url")
d = aTArGEt(rSX("Target"))
e = aREl(rSX("NoFollow"))
c = rSX("Title")
f = rSX("ImgPath")
h = h & "<div class='LinkBlock'><a href='" & b & "'" & d & "" & e & "><img src=" & f & "></a><br>"
h = h & "<a href='" & b & "'" & d & "" & e & ">" & fONtCOlORfONtB(c, rSX("FontB"), rSX("FontColor")) & "</a></div>" & vBCrLF
rSX.mOVeNExT : nEXt : rSX.cLOsE
fRIeNDlINk = h
eND fUNcTIoN
fUNcTIoN rEAdNEwLIsT(a, b, c, d)
dIM e,f
iF c = "" tHEn c = 28
dIM g,h,i,j,k
iF a <> "" tHEn
i = "Where BigClassName='"& a &"'"
eND iF
i = "Select Top "& b &" * From [Product] " & i & d
rS.oPEn i,cONn,1,1
fOR k=1 tO b
iF rS.eOF tHEn eXIt fOR	
g = rS("FileName")
iF cHEcKReMOtEUrL(g)=fALsE tHEn
g = gEThANdLEuRL( rS("FileName") )	
cALl wEBdEBuG(g,"act=CreateArticle&ID=" & rS("Id") )
eND iF
e = rS("Title")
f = iIF(rS("TitleAlt")="",e,rS("TitleAlt"))	
j = cUTsTR(e,c,"... ")
j = fONtCOlORfONtB(j,rS("FontB"),rS("FontColor"))
h=h & "<div class='News'><a "& aHReF(g,f,rS("Target")) &">"& j &"</a></div>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
rEAdNEwLIsT = h
eND fUNcTIoN
fUNcTIoN lITyPEnEWlISt(a, b, c, d)
iF c = "" tHEn c = 28
dIM e,f,g,h,i
iF a <> "" tHEn
g = "Where BigClassName='"& a &"'"
eND iF
g = "Select Top "& b &" * From [Product] " & g & d
rS.oPEn g,cONn,1,1
fOR i=1 tO b
iF rS.eOF tHEn eXIt fOR	
e = rS("FileName")
iF cHEcKReMOtEUrL(e)=fALsE tHEn
e = gEThANdLEuRL( rS("FileName") )	
cALl wEBdEBuG(e,"act=CreateArticle&ID=" & rS("Id") )
eND iF
h = cUTsTR(rS("Title"),c,"... ")
h = fONtCOlORfONtB(h,rS("FontB"),rS("FontColor"))
f=f & "<li><a "& aHReF(e,rS("Title"),rS("Target")) &">"& h &"</a></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
lITyPEnEWlISt = f
eND fUNcTIoN
fUNcTIoN cASeLIsT(a,b,c)
dIM d,e,f,g,h,i,j,k,l
d = "Select * From [Product] Where BigClassName='"& a &"' And (len(BigFiles)>3 Or len(SmallFiles)>3) Order By Id Desc"
rS.oPEn d, cONn, 1, 1
fOR e=1 tO b
iF rS.eOF tHEn eXIt fOR	
f = gEThANdLEuRL( rS("FileName") )
g = rS("Title")
h = g
iF i <> "" tHEn
h = rEPlACe(h, i, "<font color=red><b>"& i &"</b></font>")
eND iF	
h = cUTsTR(h,28,"... ")	
iF iSNuL(rS("SmallFiles")) tHEn	
iF iSNuL(rS("BigFiles")) tHEn l="Images/error.gif" eLSe l=rS("BigFiles")
eLSe
iF iSNuL(rS("SmallFiles")) tHEn l="Images/error.gif" eLSe l=rS("SmallFiles")
eND iF
h = fONtCOlORfONtB(h,rS("FontB"),rS("FontColor"))
j = rS("Target")	
k=k & "<div class='ImageBlock'><a "& aHReF(f,g,j) &"><img "& iMGsRC(l,g,j) &"/></a><p><a "& aHReF(f,rS("Title"),rS("Target")) &">"& h &"</a></p></div>"
rS.mOVeNExT : nEXt :rS.cLOsE
cASeLIsT = k
eND fUNcTIoN
fUNcTIoN rEAdSCrOLlMEmBErLIsT(a, b)
dIM c, d, e, f
f = "Select * From [Member] Order By Id Desc"
rS.oPEn f, cONn, 1, 1
fOR d = 1 tO rS.rECoRDcOUnT
iF rS.eOF oR d > a tHEn eXIt fOR
e = e & "<li>" & rS("UserName") & "</li>"
rS.mOVeNExT : nEXt : rS.cLOsE
rEAdSCrOLlMEmBErLIsT = e
eND fUNcTIoN
fUNcTIoN rEAdCLaSSlISt(a, b, c, d, e)
dIM f, g, h, i,j,k,l,m,n,o,p,q,r,s
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",cONn,1,1
r=0
wHIlE nOT rS.eOF
j = rS("SmallClassName")
k = fONtCOlORfONtB(j,rS("FontB"),rS("FontColor")) 	
l = gETsMAlLClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") )
cALl wEBdEBuG(l,"act=CreateClass&ProDid=" & a & "&ProSid=" & rS("SmallClassName"))
m = aTArGEt(rS("Target"))
iF e<>"" tHEn
r=r+1
s = " onmousemove=""ShowHideDiv('ProList"& r &"');"""
eND iF
i=i & "        <div class='ClassSmall'"& s &"><A "& aHReF(l,"",m) & sTYlEClASs("ClassSid") &">"& k &"</A></div>" & vBCrLF
iF e<>"" tHEn
i=i & "<div id=""ProList"& r &""" style=""display:none"">" & vBCrLF
eND iF
rSX.oPEn"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& rS("SmallClassName") &"' Order By Sort,ID Asc",cONn,1,1
iF nOT rSX.eOF tHEn	
fOR g=1 tO rSX.rECoRDcOUnT
iF tABlECoUNt("Product","Where BigClassName='"& a &"' And SmallClassName='"& rSX("SmallClassName") &"' And ThreeClassName='"& rSX("ThreeClassName") &"'" )>1 tHEn
n =  gETtHReEClASsFIlENaME(rSX("BigClassName"),rSX("SmallClassName"),rSX("ThreeClassName"))
eLSe
n = gETpROdUCtURl("Where BigClassName='"& rSX("BigClassName") &"' And SmallClassName='"& rSX("SmallClassName") &"' And ThreeClassName='"& rSX("ThreeClassName") &"'")
eND iF
m = aTArGEt(rSX("Target"))
q = rSX("ThreeClassName")
p = fONtCOlORfONtB(q,rSX("FontB"),rSX("FontColor")) 	
iF q = c tHEn
p="<font color=red>"& p  &"</font>"
eND iF
i=i & "                <div class='ClassThree'><a "& aHReF(n,"",m) & sTYlEClASs("ClassTid") &">"& p &"</a></div>" & vBCrLF
rSX.mOVeNExT:nEXt
eND iF:rSX.cLOsE
iF e<>"" tHEn
i=i & "</div>" & vBCrLF
eND iF
i=i & "<div class='clear10'></div>"
rS.mOVeNExT:wENd:rS.cLOsE
rEAdCLaSSlISt = i
eND fUNcTIoN
fUNcTIoN hOTsEArCH(a)
dIM b, c, d, e,f,g,h,i,j
iF a = "" tHEn a = " Where Through=True Order By Sort Desc"
rS.oPEn"Select * From [SearchCount] " & a,cONn,1,1
fOR c=1 tO 10
iF rS.eOF tHEn eXIt fOR	
h = rS("Title")
g = "/Inc/Create_Html.Asp?act=Search&MackHtml=False&wd=" & h
i = h
i = fONtCOlORfONtB(i,rS("FontB"),rS("FontColor")) 	
iF h = j tHEn	
e=e & "            "& tEXtFOnTB(h,tRUe) &"&nbsp;" & vBCrLF
eLSe
e=e & "            <a "& aHReF(g,h,rS("Target")) &">"& i &"</a>&nbsp;" & vBCrLF
eND iF
rS.mOVeNExT:nEXt:rS.cLOsE
hOTsEArCH=e
eND fUNcTIoN
fUNcTIoN jSBaNNeR2011(a, b, c, d, e, f)
dIM g, h, i, j
g = ""
g = g & "<SCRIPT language=JavaScript type=text/javascript> " & vBCrLF
g = g & "var bannerAD=new Array(); " & vBCrLF
g = g & "var bannerADlink=new Array(); " & vBCrLF
g = g & "var adNum=0; " & vBCrLF
rS.oPEn "Select Top " & b & " * From[Product] Where BigClassName='" & a & "'", cONn, 1, 1
iF rS.eOF aND e tHEn
rSS.oPEn "Select BigClassName From [BigClass] Where BigClassName='" & a & "'", cONn, 1, 3
iF rSS.eOF tHEn
rSS.aDDnEW
rSS("BigClassName") = a
rSS.uPDaTE
eND iF : rSS.cLOsE
fOR j = 1 tO b
cONn.eXEcUTe("Insert Into[Product](BigClassName,Title,BigFiles) Values('" & a & "','" & a & j & "','UpLoadFiles/Pic/" & j & ".jpg')")
nEXt
eND iF
fOR h = 1 tO rS.rECoRDcOUnT
iF h = 1 tHEn i = rS("BigFiles")
g = g & "bannerAD[" & h - 1 & "]=""" & rEPlACe(rS("BigFiles"), vBCrLF, "") & """; " & vBCrLF
g = g & "bannerADlink[" & h - 1 & "]=""#""" & vBCrLF
g = g & "" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
g = g & "var preloadedimages=new Array(); " & vBCrLF
g = g & "for(i=1;i<bannerAD.length;i++){ " & vBCrLF
g = g & "preloadedimages[i]=new Image(); " & vBCrLF
g = g & "preloadedimages[i].src=bannerAD[i]; " & vBCrLF
g = g & "} " & vBCrLF
g = g & "" & vBCrLF
g = g & "function setTransition(){ " & vBCrLF
g = g & "if(document.all){ " & vBCrLF
g = g & "bannerADrotator.filters.revealTrans.Transition=Math.floor(Math.random()*23); " & vBCrLF
g = g & "bannerADrotator.filters.revealTrans.apply(); " & vBCrLF
g = g & "} " & vBCrLF
g = g & "} " & vBCrLF
g = g & "" & vBCrLF
g = g & "function playTransition(){ " & vBCrLF
g = g & "if(document.all) " & vBCrLF
g = g & "bannerADrotator.filters.revealTrans.play() " & vBCrLF
g = g & "} " & vBCrLF
g = g & "" & vBCrLF
g = g & "function nextAd(){ " & vBCrLF
g = g & "if(adNum<bannerAD.length-1)adNum++ ; " & vBCrLF
g = g & "else adNum=0; " & vBCrLF
g = g & "setTransition(); " & vBCrLF
g = g & "document.images.bannerADrotator.src=bannerAD[adNum]; " & vBCrLF
g = g & "playTransition(); " & vBCrLF
g = g & "theTimer=setTimeout(""nextAd()"", 4000); " & vBCrLF
g = g & "} " & vBCrLF
g = g & "" & vBCrLF
g = g & "function jump2url(){ " & vBCrLF
g = g & "jumpUrl=bannerADlink[adNum]; " & vBCrLF
g = g & "jumpTarget='_self'; " & vBCrLF
g = g & "if(jumpUrl != ''){ " & vBCrLF
g = g & "} " & vBCrLF
g = g & "} " & vBCrLF
g = g & "function displayStatusMsg() { " & vBCrLF
g = g & "status=bannerADlink[adNum]; " & vBCrLF
g = g & "document.returnValue = true; " & vBCrLF
g = g & "}" & vBCrLF
g = g & "</SCRIPT>" & vBCrLF
g = g & "<A onmouseover=""displayStatusMsg();return document.returnValue"" href=""javascript:jump2url()"">" & vBCrLF
g = g & "<IMG id=bannerADrotator style=""FILTER: revealTrans(duration=2,transition=40)"" height=" & d & " src=""" & i & """ width=" & c & " align=middle name=bannerADrotator></A>" & vBCrLF
g = g & "<SCRIPT language=JavaScript type=text/javascript>nextAd()</SCRIPT>" & vBCrLF
jSBaNNeR2011 = g
eND fUNcTIoN
sUB mAKeSItEMaP()
dIM b, c, d, e,f, g,h,i,j,k,l,m,n,o,p,q,r,s,t
dIM u,v
p = gEThOSt()
s = fORmAT_TImE(nOW(),2)
t = 0
rS.oPEn "Select * From [WebSite]", cONn, 1, 1
iF nOT rS.eOF tHEn
q = rS("WebTitle")
eND iF : rS.cLOsE
u=u & "<?xml version=""1.0"" encoding=""gb2312""?>" & vBCrLF
u=u & "<urlset" & vBCrLF
u=u & "    xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9""" & vBCrLF
u=u & "    xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""" & vBCrLF
u=u & "    xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9" & vBCrLF
u=u & "       http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"">" & vBCrLF
v=v & "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">" & vBCrLF
v=v & "<head>" & vBCrLF
v=v & "<title>网站地图-"& q &"</title>" & vBCrLF
v=v & "<meta http-equiv=""Content-type"" content=""text/html;"" charset=""gb2312"" />" & vBCrLF
v=v & "<style type=""text/css"">" & vBCrLF
v=v & "A{" & vBCrLF
v=v & "font-size: 14px;text-decoration:none;" & vBCrLF
v=v & "color: #000000;" & vBCrLF
v=v & "line-height:30px;" & vBCrLF
v=v & "}</style>" & vBCrLF
v=v & "</head>" & vBCrLF
v=v & "<body>" & vBCrLF
rS.oPEn "Select * From [NavBigClass] Where OnHtml=True Order By Sort", cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
g = rS("FileName")
iF g <> "" tHEn g = g & ".html"
h = "/" & rS("FolderName") & "/"
f = h & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = uRLaDDhTTpURl(p,f)
k = rS("BigClassName")
r = iIF(rS("WebTitle")="",q,rS("WebTitle"))
cALl eCHo(r,f)
u=u & "<url>" & vBCrLF & "<loc>"& f &"</loc>" & vBCrLF & "<priority>0.5</priority>" & vBCrLF
u=u & "<lastmod>"& s &"</lastmod>" & vBCrLF & "<changefreq>weekly</changefreq>" & vBCrLF & "</url>" & vBCrLF
t = t + 1
v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
iF rS("NavType") = "文本" tHEn
rSS.oPEn "Select * From [NavSmallClass] Where BigClassName='"& rS("BigClassName") &"' And OnHtml=True Order By Sort", cONn, 1, 1
iF nOT rSS.eOF tHEn
fOR c = 1 tO rSS.rECoRDcOUnT
g = rSS("FileName")
iF g <> "" tHEn g = g & ".html"
f = h & g
f = h & "/" & rSS("FolderName") & "/" & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = uRLaDDhTTpURl(p,f)
m = rSS("SmallClassName")
r = iIF(rSS("WebTitle")="",q,rSS("WebTitle"))	
cALl eCHo(r,f)
u=u & "<url>" & vBCrLF & "<loc>"& f &"</loc>" & vBCrLF & "<priority>0.5</priority>" & vBCrLF
u=u & "<lastmod>"& s &"</lastmod>" & vBCrLF & "<changefreq>weekly</changefreq>" & vBCrLF & "</url>" & vBCrLF
t = t + 1
v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
rSS.mOVeNExT: nEXt 	
eND iF : rSS.cLOsE	
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
rS.oPEn "Select * From [BigClass] Where OnHtml=True Order By Sort", cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
g = rS("FileName")
iF g <> "" tHEn g = g & ".html"
h = "/" & rS("FolderName") & "/"
f = h & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = uRLaDDhTTpURl(p,f)
k = rS("BigClassName")
r = iIF(rS("WebTitle")="",q,rS("WebTitle"))
cALl eCHo(r,f)
u=u & "<url>" & vBCrLF & "<loc>"& f &"</loc>" & vBCrLF & "<priority>0.5</priority>" & vBCrLF
u=u & "<lastmod>"& s &"</lastmod>" & vBCrLF & "<changefreq>weekly</changefreq>" & vBCrLF & "</url>" & vBCrLF
t = t + 1
v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
rSS.oPEn "Select * From [SmallClass] Where BigClassName='"& rS("BigClassName") &"' And  OnHtml=True Order By Sort", cONn, 1, 1
iF nOT rSS.eOF tHEn	
fOR c = 1 tO rSS.rECoRDcOUnT
g = rSS("FileName")
iF g <> "" tHEn g = g & ".html"
i = "/" & rSS("FolderName") & "/"
f = h & "/" & rSS("FolderName") & "/" & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = uRLaDDhTTpURl(p,f)
m = rSS("SmallClassName")
r = iIF(rSS("WebTitle")="",q,rSS("WebTitle"))
cALl eCHo(r,f)
u=u & "<url>" & vBCrLF & "<loc>"& f &"</loc>" & vBCrLF & "<priority>0.5</priority>" & vBCrLF
u=u & "<lastmod>"& s &"</lastmod>" & vBCrLF & "<changefreq>weekly</changefreq>" & vBCrLF & "</url>" & vBCrLF
t = t + 1
v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
rSX.oPEn"Select * From [ThreeClass] Where BigClassName='"& k &"' And SmallClassName='"& m &"' And  OnHtml=True Order By Sort",cONn,1,1
fOR d = 1 tO rSX.rECoRDcOUnT
g = rSX("FileName")
iF g <> "" tHEn g = g & ".html"
f = h & i & "/" & rSX("FolderName") & "/" & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = uRLaDDhTTpURl(p,f)
n = rSX("SmallClassName")
r = iIF(rSX("WebTitle")="",q,rSX("WebTitle"))
cALl eCHo(r,f)
u=u & "<url>" & vBCrLF & "<loc>"& f &"</loc>" & vBCrLF & "<priority>0.5</priority>" & vBCrLF
u=u & "<lastmod>"& s &"</lastmod>" & vBCrLF & "<changefreq>weekly</changefreq>" & vBCrLF & "</url>" & vBCrLF
t = t + 1
v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
rSX.mOVeNExT : nEXt : rSX.cLOsE	
rSS.mOVeNExT: nEXt
eND iF : rSS.cLOsE
rS.mOVeNExT : nEXt : rS.cLOsE	
rS.oPEn "Select * From [Product] Where OnHtml=True Order By Sort", cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
g = rS("FileName")
iF g <> "" tHEn g = g & ".html"
h = "/Html/" & rS("FolderName") & "/"
f = h & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = uRLaDDhTTpURl(p,f)
k = rS("BigClassName")
r = iIF(rS("WebTitle")="",q,rS("WebTitle"))
cALl eCHo(r,f)
u=u & "<url>" & vBCrLF & "<loc>"& f &"</loc>" & vBCrLF & "<priority>0.5</priority>" & vBCrLF
u=u & "<lastmod>"& s &"</lastmod>" & vBCrLF & "<changefreq>weekly</changefreq>" & vBCrLF & "</url>" & vBCrLF
t = t + 1
v=v & "<div>"& t &".<a href="""& f &""">"& r &"</a></div>"
rS.mOVeNExT : nEXt : rS.cLOsE	
cALl cREaTEfILe("/sitemap.xml", u & "</urlset>")
cALl cREaTEfILe("/sitemap.html", v & "</body></html>")
cALl eCHo("sitemap.html文档","<a href='/sitemap.html' target='_blank'>sitemap.html</a><br>")
cALl eCHo("sitemap.xml文档","<a href='/sitemap.xml' target='_blank'>sitemap.xml</a>")
eND sUB
fUNcTIoN wEBsTAt(a)
dIM b, c, d
dIM e, f, g, h, i, j, k, l, m, n ,o
f = rEQuESt.sERvERvARiABlES("HTTP_REFERER")
e = "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & rEQuESt.sERvERvARiABlES("SCRIPT_NAME")
g = rEQuESt.sERvERvARiABlES("QUERY_STRING")
iF g <> "" tHEn
e = e & "?" & g
eND iF
f = rEQuESt("GoToUrl")
e = rEQuESt("ThisUrl")
l = rEQuESt.qUErYStRInG("co")
b = nOW()
c = rEQuESt.sERvERvARiABlES("HTTP_USER_AGENT")
c=rEPlACe(c,"MSIE","Internet Explorer")
c=rEPlACe(c,"NT 5.0","2000")
c=rEPlACe(c,"NT 5.1","XP")
c=rEPlACe(c,"NT 5.2","2003")
d = sPLiT(c & ";;;;", ";")
m = d(1)
n = tRIm(d(2))
iF rIGhT(n,1)=")" tHEn n=mID(n,1,lEN(n)-1)
h = "来访" & f & vBCrLF
h = h & "当前：" & e & vBCrLF
h = h & "时间：" & b & vBCrLF
h = h & "IP:" & gETiP() & vBCrLF
h = h & "IE:" & gETbRTyPE("") & vBCrLF
h = h & "Cookies=" & l & vBCrLF
h = h & "XP=" & n & vBCrLF
h = h & "Screen=" & rEQuESt("screen") & vBCrLF
h = h & "用户信息=" &rEQuESt.sERvERvARiABlES("HTTP_USER_AGENT")  & vBCrLF
h = h & "-------------------------------------------------" & vBCrLF
i = a & fORmAT_TImE(nOW(), 2) & ".txt"
cALl cREaTEaDDfILe(i, h)
h = h & vBCrLF & i
h = rEPlACe(h, vBCrLF, "\n")
h = rEPlACe(h, """", "\""")
wEBsTAt = h
eND fUNcTIoN
%>


