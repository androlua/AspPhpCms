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
sUB gETwEBcONfIG(a)
iF dEFaULtWEbTItLE <> "" tHEn	
wEBtITlE = dEFaULtWEbTItLE
wEBkEYwORdS = dEFaULtWEbKEyWOrDS
wEBdEScRIpTIoN = dEFaULtWEbDEsCRiPTiON
eXIt sUB
eND iF
rS.oPEn "Select * From [WebSite] Where UserId="&a, cONn, 1, 1
iF nOT rS.eOF tHEn
wEBtEMpLAtE = rS("WebTemplate")
wEBsKInS = rS("WebSkins") 	
wEBtITlE = rS("WebTitle")
wEBkEYwORdS = rS("WebKeywords")
wEBdEScRIpTIoN = rS("WebDescription")
wEBbOTtOM = rS("WebSiteBottom")
eND iF : rS.cLOsE
eND sUB
fUNcTIoN gETnAVtEMpLAtETeXT(a, b, c,d)
dIM e, f, g, h,i
iF b <> "" tHEn
e = " Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
eLSeIF a <> "" tHEn
e = " Where BigClassName='" & a & "'"
eLSe
e = " Where NavType='" & c & "'"
eND iF
iF a <> "" tHEn
tEMpRS.oPEn"Select * From [NavBigClass] Where BigClassName='"& a &"' And UserId="&d,cONn,1,1
iF nOT tEMpRS.eOF tHEn	
i = "/" & tEMpRS("FolderName") & "/"
wEBnAVtYPe = tEMpRS("NavType")	
eND iF:tEMpRS.cLOsE
eND iF
iF b <> "" tHEn
tEMpRS.oPEn"Select * From [NavSmallClass]  " & e & " And UserId="&d,cONn,1,1
iF nOT tEMpRS.eOF tHEn
iF tRIm(tEMpRS("TemplatePath"))<>"" tHEn
f = tEMpRS("TemplatePath")
eLSe
f = "Main_Model.Html"
eND iF
g = gEThANdLEfILeNAmE(tEMpRS("FileName"))
cALl cREaTEdIRfOLdER("/" & i & tEMpRS("FolderName"))
cREaTEhTMlPAtH = "/" & i & tEMpRS("FolderName") & "/" & g
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
mAInCOnTEnT = tEMpRS("Content")	
wEBtITlE = iIF(tEMpRS("WebTitle")<>"",tEMpRS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(tEMpRS("WebKeywords")<>"",tEMpRS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(tEMpRS("WebDescription")<>"",tEMpRS("WebDescription"),wEBdEScRIpTIoN)
eND iF:tEMpRS.cLOsE
gETnAVtEMpLAtETeXT = f:eXIt fUNcTIoN
eND iF
rS.oPEn "Select * From [NavBigClass] " & e & "And UserId="&d, cONn, 1, 1
iF nOT rS.eOF tHEn
iF tRIm(rS("TemplatePath"))<>"" tHEn
f = rS("TemplatePath")
eND iF
g = gEThANdLEfILeNAmE(rS("FileName"))
cALl cREaTEdIRfOLdER("/" & rS("FolderName"))
cREaTEhTMlPAtH = "/" & rS("FolderName") & "/" & g
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
mAInCOnTEnT = rS("Content")	
wEBtITlE = iIF(rS("WebTitle")<>"",rS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(rS("WebKeywords")<>"",rS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(rS("WebDescription")<>"",rS("WebDescription"),wEBdEScRIpTIoN)
eLSe
f = "Index_Model.Html"
cALl eCHo("没有导航大类【"& a &"】此导航模板为默认",f)
eND iF : rS.cLOsE
gETnAVtEMpLAtETeXT = f
eND fUNcTIoN
fUNcTIoN gETcLAsSTeMPlATeTExT(a,b,c,d)
dIM e, f, g, h,i
iF c <> "" tHEn
e = "Select * From [ThreeClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'"
eLSeIF b <> "" tHEn
e = "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
eLSe
e = "Select * From [BigClass] Where BigClassName='" & a & "'"
eND iF
iF a <> "" tHEn
tEMpRS.oPEn"Select * From [BigClass] Where BigClassName='"& a &"' And UserID=" & d,cONn,1,1
iF nOT tEMpRS.eOF tHEn	
i = "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
eND iF
iF a <> "" tHEn
tEMpRS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And UserID=" & d,cONn,1,1
iF nOT tEMpRS.eOF tHEn	
i = i & "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
eND iF
iF c <> "" tHEn
tEMpRS.oPEn"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And ThreeClassName='"& c &"' And UserID=" & d,cONn,1,1
iF nOT tEMpRS.eOF tHEn	
i = i & "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
eND iF
tEMpRS.oPEn e,cONn,1,1
iF nOT tEMpRS.eOF tHEn
iF tRIm(tEMpRS("TemplatePath"))<>"" tHEn
f = tEMpRS("TemplatePath")
eLSe
f = "Template_Main.html"	
eND iF
g = gEThANdLEfILeNAmE(tEMpRS("FileName"))
cALl cREaTEdIRfOLdER("/" & i )
cREaTEhTMlPAtH = "/" & i & "/" & g
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
iF tEMpRS("WebTitle") <> "" tHEn wEBtITlE = tEMpRS("WebTitle")
iF tEMpRS("WebKeywords") <> "" tHEn wEBkEYwORdS = tEMpRS("WebKeywords")
iF tEMpRS("WebDescription") <> "" tHEn wEBdEScRIpTIoN = tEMpRS("WebDescription")
eND iF:tEMpRS.cLOsE
gETcLAsSTeMPlATeTExT = f
eND fUNcTIoN
fUNcTIoN gETmAInINfO(a,b)
dIM c,d
rS.oPEn"Select * From [MainInfo] Where Title='"& a &"' And Recommend=1 And UserID="& b &" Order By Sort,ID",cONn,1,1
iF nOT rS.eOF tHEn
gETmAInINfO = rS("Content")
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN pROdUCtNAvLIsT(a, b, c)
dIM d, e, f, g,h,i,j,k,l,m,n,o
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"'  And UserID="& uSErID & " Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
h = rS("SmallClassName")
i = fONtCOlORfONtB(h,rS("FontB"),rS("FontColor")) 	
j = gETsMAlLClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") )
cALl wEBdEBuG(j,"act=CreateClass&ProDid=" & a & "&ProSid=" & rS("SmallClassName"))
k = aTArGEt(rS("Target"))
g=g & "        <div class='ClassSmall'><A "& aHReF(j,"",k) & sTYlEClASs("ClassSid") &">"& i &"</A></div>" & vBCrLF
g=g & "<div class='clear10'></div>"
rS.mOVeNExT:wENd:rS.cLOsE
pROdUCtNAvLIsT = g
eND fUNcTIoN
sUB cREaTEaRTiCLe(a)
dIM b,c
rS.oPEn"Select * From [Product] Where Id=" & a,cONn,1,1
iF nOT rS.eOF tHEn
tEMpDId = rS("BigclassName")
tEMpSId = rS("SmallclassName")
tEMpTId = rS("ThreeclassName")	
mAInTItLE = rS("Title")	
c = ""
iF iSNuL(rS("SmallFiles"))=fALsE tHEn	
iF iSNuL(rS("SmallFiles")) tHEn c="Images/error.gif" eLSe c=rS("SmallFiles")	
eLSeIF iSNuL(rS("BigFiles"))=fALsE tHEn	
iF iSNuL(rS("BigFiles")) tHEn c="Images/error.gif" eLSe c=rS("BigFiles")
eND iF
mAInCOnTEnT = "<div class='ArticleTitle'>"& rS("Title") &"</div>"
iF c <> "" aND lEN(c)>5  tHEn
iF cHEcKFiLE(c)=tRUe tHEn
mAInCOnTEnT = mAInCOnTEnT & "<div style='text-align:center; border:1px double #CCCCCC; padding:4px;margin-bottom:10px;'><img src='"& c &"' width='"& hANdLEsHOwIMg(c,740,0,"宽") &"'></div>"
eND iF
eND iF
mAInCOnTEnT = mAInCOnTEnT & rS("Content")
mAInCOnTEnT = mAInCOnTEnT & "<hr>" & uPPaGE(rS(0)) & dOWnPAgE(rS(0))
iF tRIm(rS("TemplatePath"))<>"" tHEn
tEMpLAtEPaTH = wEBtEMpLAtE & rS("TemplatePath")
eLSe
tEMpLAtEPaTH = wEBtEMpLAtE & "Template_Main.Html"
eND iF
b = gEThANdLEfILeNAmE(rS("FileName"))
cALl cREaTEdIRfOLdER("/Html")
cREaTEhTMlPAtH = "/Html/" & rS("FolderName") & "/" & b
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
wEBtITlE = iIF(rS("Title")<>"",rS("Title"),wEBtITlE)
wEBtITlE = iIF(rS("WebTitle")<>"",rS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(rS("WebKeywords")<>"",rS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(rS("WebDescription")<>"",rS("WebDescription"),wEBdEScRIpTIoN)
eND iF:rS.cLOsE
eND sUB
%>
