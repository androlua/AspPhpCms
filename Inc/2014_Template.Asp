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
fUNcTIoN rEAdCOlUMeSEtTItLE(a,b,c,d)
dIM tITlEWiDTh	
dIM tITlEHeIGhT	
dIM cONtENtHEiGHt	
dIM cONtENtWIdTH	
dIM cONtENtCSs	
tITlEWiDTh = rPArAM(a,"TitleWidth")	
tITlEHeIGhT = rPArAM(a,"TitleHeight")	
cONtENtWIdTH = rPArAM(a,"ContentWidth")	
cONtENtHEiGHt = rPArAM(a,"ContentHeight")	
tITlEWiDTh=tRIm(tITlEWiDTh)
iF rIGhT(tITlEHeIGhT,1)<>"%" aND rIGhT(tITlEHeIGhT,2)<>"px" aND tITlEHeIGhT<>"" aND tITlEHeIGhT<>"auto" tHEn
tITlEHeIGhT = tITlEHeIGhT & "px"
eND iF
iF rIGhT(tITlEWiDTh,1)<>"%" aND rIGhT(tITlEWiDTh,2)<>"px" aND tITlEWiDTh<>"" aND tITlEWiDTh<>"auto" tHEn
tITlEWiDTh = tITlEWiDTh & "px"
eND iF
cONtENtHEiGHt=tRIm(cONtENtHEiGHt)
iF rIGhT(cONtENtHEiGHt,1)<>"%" aND rIGhT(cONtENtHEiGHt,2)<>"px" aND cONtENtHEiGHt<>"" aND cONtENtHEiGHt<>"auto" tHEn
cONtENtHEiGHt = cONtENtHEiGHt & "px"
eND iF
cONtENtWIdTH=tRIm(cONtENtWIdTH)
iF rIGhT(cONtENtWIdTH,1)<>"%" aND rIGhT(cONtENtWIdTH,2)<>"px" aND cONtENtWIdTH<>"" aND cONtENtWIdTH<>"auto" tHEn
cONtENtWIdTH = cONtENtWIdTH & "px"
eND iF
iF cONtENtHEiGHt<>"" tHEn
cONtENtCSs = "height:"& cONtENtHEiGHt &";"
eND iF
iF cONtENtWIdTH<>"" tHEn
cONtENtCSs = cONtENtCSs & "width:"& cONtENtWIdTH &";"
eND iF
dIM j
j = rEAdCOlUMn(b)
iF tITlEWiDTh<>"" tHEn
j=rEPlACe(j,"<div class=""tvalue"">", "<div class=""tvalue"" style='width:"& tITlEWiDTh &";'>")
eND iF
iF cONtENtCSs<>"" tHEn
j=rEPlACe(j,"<div class=""ccontent"">", "<div class=""ccontent"" style='"& cONtENtCSs &"'>")
eND iF
j=rEPlACe(j,"栏目标题",c)
j=rEPlACe(j,"栏目内容",d)
rEAdCOlUMeSEtTItLE = j
eND fUNcTIoN
fUNcTIoN rEAdCOlUMn(a)
dIM b,c,d,e
b = wEBtEMpLAtE & "\Template_Left.html"
c = "/*columnlist"& a &"Start*/"
d = "/*columnlist"& a &"End*/"
e = rEAdTEmPLaTEfILeMOdULaR(b,c,d)
iF e = "[$NO$]" tHEn
e = "Left样式ID["& a &"]不存在"
eND iF
rEAdCOlUMn = e
eND fUNcTIoN
fUNcTIoN rEAdTEmPLaTEmODuLEsTR(a,b,c)
dIM d,e,f,g
d = "<!--#Module "& c &" Start#-->"
e = "<!--#Module "& c &" End#-->"	
a = rEPlACeGLoBLeLAbLE(a)	
iF cHEcKFiLE(a)=fALsE tHEn
a=wEBtEMpLAtE & a
eND iF
iF b <>"" tHEn
f = b
eLSeIF cHEcKFiLE(a)=tRUe tHEn
f = gETfTExT(a)
eLSe
f = cODe	
eND iF
iF iNStR(f,d)>0 aND iNStR(f,e)>0 tHEn
rEAdTEmPLaTEmODuLEsTR = sTRcUT(f, d, e,2)
eLSe
rEAdTEmPLaTEmODuLEsTR = "模块["& c &"]不存在,路径=" & a
eND iF
eND fUNcTIoN
fUNcTIoN fINdMOdULeSTr(a,b)
dIM c,d,e,f,g,h,i,j
fOR g=1 tO 9
c = "[$读出内容 " : d = "$]"
iF iNStR(b,c)>0 aND iNStR(b,d)>0 tHEn
j = sTRcUT(b,c,d,2)
h = rPArAM(j,"Block")
i = rPArAM(j,"File")
iF iNStR(vBCrLF & rEAdBLoCKlISt & vBCrLF, vBCrLF & h & vBCrLF)=fALsE tHEn
rEAdBLoCKlISt = rEAdBLoCKlISt & h & vBCrLF
eND iF
iF i<>"" tHEn
a = gETfTExT(i)
eND iF	
e = c & j & d
f = ""
c = "<R#读出内容"& h &" start#>" : d = "<R#读出内容"& h &" end#>"
iF iNStR(a,c)>0 aND iNStR(a,d)>0 tHEn	
f = sTRcUT(a,c,d,2)
eLSe
c = "<!--#读出内容" & h :  d = "#-->"
iF iNStR(a,c)>0 aND iNStR(a,d)>0 tHEn	
f = sTRcUT(a,c,d,2)	
eND iF	
eND iF
b = rEPlACe(b,e,f)
eLSe
eXIt fOR
eND iF
nEXt
fINdMOdULeSTr = b
eND fUNcTIoN
fUNcTIoN rEAdTEmPLaTEsOUrCE(a)
dIM b,c,d,e
b = wEBtEMpLAtE & "\TemplateSource.html"
c = "<!--#sourceHtml"& a &"Start#-->"
d = "<!--#sourceHtml"& a &"End#-->"	
e = rEAdTEmPLaTEfILeMOdULaR(b,c,d)
iF e = "[$NO$]" tHEn
e = "模板资源ID["& a &"]不存在"
eND iF
rEAdTEmPLaTEsOUrCE = e
eND fUNcTIoN
fUNcTIoN rEAdTEmPLaTEfILeMOdULaR(a,b,c)
dIM d
rEAdTEmPLaTEfILeMOdULaR = ""
d = gETfTExT(a)
iF iNStR(d,b)>0 aND iNStR(d,c)>0 tHEn
rEAdTEmPLaTEfILeMOdULaR = sTRcUT(d, b, c,2)
eLSe
rEAdTEmPLaTEfILeMOdULaR = "[$NO$]"
eND iF
eND fUNcTIoN
fUNcTIoN gETnAVtEMpLAtETeXT(a, b, c)
dIM d, e, f, g, h, i
iF b <> "" tHEn
d = " Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
eLSeIF a <> "" tHEn
d = " Where BigClassName='" & a & "'"
eLSe
d = " Where NavType='" & c & "'"
eND iF
iF a <> "" tHEn
tEMpRS.oPEn"Select * From [NavBigClass] Where BigClassName='"& a &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn	
h = "/" & tEMpRS("FolderName") & "/"
wEBnAVtYPe = tEMpRS("NavType")	
mAInTItLE = tEMpRS("BigClassName")	
eND iF:tEMpRS.cLOsE
eND iF
iF b <> "" tHEn
tEMpRS.oPEn"Select * From [NavSmallClass]  " & d,cONn,1,1
iF nOT tEMpRS.eOF tHEn
iF tRIm(tEMpRS("TemplatePath"))<>"" tHEn
e = tEMpRS("TemplatePath")
eLSe
e = "Main_Model.Html"
eND iF
f = gEThANdLEfILeNAmE(tEMpRS("FileName"))
iF tEMpRS("FolderName") = "" tHEn
i = h
eLSe
i = tRIm(rEPlACe(tEMpRS("FolderName"),"\","/"))
iF lEFt(i,1)<>"/" tHEn
i = h & "/" & i
eND iF
eND iF
cREaTEhTMlPAtH = lOCaLTeSTfOLdER & i & f
iF tRIm(tEMpRS("CustomAUrl"))<>"" tHEn
cREaTEhTMlPAtH=""
eND iF
mAInCOnTEnT = tEMpRS("Content")	
mAInCOnTEnT = dISpLAyONlINeEDiTDiALoG("/admin/NavManage.Asp?act=SmallNavInfo&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), mAInCOnTEnT)
wEBtITlE = iIF(tEMpRS("WebTitle")<>"",tEMpRS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(tEMpRS("WebKeywords")<>"",tEMpRS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(tEMpRS("WebDescription")<>"",tEMpRS("WebDescription"),wEBdEScRIpTIoN)
mAInTItLE = tEMpRS("SmallClassName")	
eND iF:tEMpRS.cLOsE
gETnAVtEMpLAtETeXT = e:eXIt fUNcTIoN
eND iF
rS.oPEn "Select * From [NavBigClass] " & d, cONn, 1, 1
iF nOT rS.eOF tHEn
iF tRIm(rS("TemplatePath"))<>"" tHEn
e = rS("TemplatePath")
eLSe
sELeCT cASe rS("NavType")
cASe "首页" : e = "Index_Model.Html"
cASe "文本" :
e = "Main_Model.Html" : mAInCOnTEnT = rS("Content")	
mAInCOnTEnT = dISpLAyONlINeEDiTDiALoG("/admin/NavManage.Asp?act=EditInformation&Id=" & rS("Id") & "&n=" & gETrND(11), mAInCOnTEnT)
cASe eLSe : e = "Main_Model.Html"	
eND sELeCT
eND iF
mAInTItLE = rS("BigClassName")	
f = gEThANdLEfILeNAmE(rS("FileName"))
cALl cREaTEdIRfOLdER("/" & lOCaLTeSTfOLdER & rS("FolderName"))
cREaTEhTMlPAtH = "/" & lOCaLTeSTfOLdER & rS("FolderName") & "/" & f
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
iF tRIm(rS("CustomAUrl"))<>"" tHEn
cREaTEhTMlPAtH=""
eND iF
wEBtITlE = iIF(rS("WebTitle")<>"",rS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(rS("WebKeywords")<>"",rS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(rS("WebDescription")<>"",rS("WebDescription"),wEBdEScRIpTIoN)
eLSe
e = "Index_Model.Html"
cALl eCHo("没有导航大类【"& a &"】此导航模板为默认",e)
eND iF : rS.cLOsE
gETnAVtEMpLAtETeXT = e
eND fUNcTIoN
fUNcTIoN gETcLAsSTeMPlATeTExT(a,b,c)
dIM d, e, f, g,h, i
iF c <> "" tHEn
d = "Select * From [ThreeClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'"
eLSeIF b <> "" tHEn
d = "Select * From [SmallClass] Where BigClassName='" & a & "' And SmallClassName='"& b &"'"
eLSe
d = "Select * From [BigClass] Where BigClassName='" & a & "'"
eND iF
iF a <> "" tHEn
tEMpRS.oPEn"Select * From [BigClass] Where BigClassName='"& a &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn	
h = "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
eND iF
iF a <> "" tHEn
tEMpRS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn
i = tRIm(rEPlACe(tEMpRS("FolderName"),"\","/"))
iF lEFt(i,1)<>"/" tHEn
h = h & "/" & i & "/"
eLSe
h = "/" & tEMpRS("FolderName") & "/"
eND iF
eND iF:tEMpRS.cLOsE
eND iF
iF c <> "" tHEn
tEMpRS.oPEn"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"' And ThreeClassName='"& c &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn	
i = tRIm(rEPlACe(tEMpRS("FolderName"),"\","/"))
iF lEFt(i,1)<>"/" tHEn
h = h & "/" & i & "/"
eLSe
h = "/" & tEMpRS("FolderName") & "/"
eND iF
eND iF:tEMpRS.cLOsE
eND iF
iF a<>"" aND b = "" aND c="" tHEn
tEMpRS.oPEn"Select * From[NavBigClass] Where (NavType='产品' Or NavType='新闻' Or NavType='下载') And BigClassName='"& a &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn	
iF cHEcKMaKEhTMlFIlE(tEMpRS("FileName"))=tRUe tHEn
h = "/" & tEMpRS("FolderName") & "/"
eLSe
tEMpRS.cLOsE
tEMpRS.oPEn d,cONn,1,1
eND iF
eLSe
tEMpRS.cLOsE
tEMpRS.oPEn d,cONn,1,1
eND iF
eLSe
tEMpRS.oPEn d,cONn,1,1
eND iF
iF nOT tEMpRS.eOF tHEn
iF tRIm(tEMpRS("TemplatePath"))<>"" tHEn
e = tEMpRS("TemplatePath")
eLSe
e = "Main_Model.Html"
eND iF
f = gEThANdLEfILeNAmE(tEMpRS("FileName"))
cALl cREaTEdIRfOLdER("/" & lOCaLTeSTfOLdER &  h )
cREaTEhTMlPAtH = "/" & lOCaLTeSTfOLdER & h & "/" & f
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
iF tEMpRS("WebTitle") <> "" tHEn wEBtITlE = tEMpRS("WebTitle")
iF tEMpRS("WebKeywords") <> "" tHEn wEBkEYwORdS = tEMpRS("WebKeywords")
iF tEMpRS("WebDescription") <> "" tHEn wEBdEScRIpTIoN = tEMpRS("WebDescription")
eND iF:tEMpRS.cLOsE
gETcLAsSTeMPlATeTExT = e
eND fUNcTIoN
fUNcTIoN gETaRTiCLeINfOStYLe(a,b,c,d)
dIM e,f
sET e = cREaTEoBJeCT("Adodb.RecordSet")
f = " Where BigClassName='"& a &"' And ArticleInfoStyle<>'' And ArticleInfoStyle<>'0'"
e.oPEn"Select * From [BigClass]" & f,cONn,1,1
iF nOT e.eOF tHEn
gETaRTiCLeINfOStYLe = e("ArticleInfoStyle")
eND iF:e.cLOsE
iF b <>"" tHEn
f = f & " And SmallClassName='"& b &"'"
e.oPEn"Select * From [SmallClass]" & f,cONn,1,1
iF nOT e.eOF tHEn
gETaRTiCLeINfOStYLe = e("ArticleInfoStyle")
eND iF:e.cLOsE
eND iF
iF b <>"" tHEn
f = f & " And ThreeClassName='"& c &"'"
e.oPEn"Select * From [ThreeClass]" & f,cONn,1,1
iF nOT e.eOF tHEn
gETaRTiCLeINfOStYLe = e("ArticleInfoStyle")
eND iF:e.cLOsE
eND iF
iF d <>"" tHEn
e.oPEn"Select * From [Product] Where Id=" & d,cONn,1,1
iF nOT e.eOF tHEn
iF e("ArticleInfoStyle")<>"" aND e("ArticleInfoStyle")<>"0" tHEn
gETaRTiCLeINfOStYLe = e("ArticleInfoStyle")
eND iF
eND iF:e.cLOsE
eND iF
iF gETaRTiCLeINfOStYLe="" tHEn
gETaRTiCLeINfOStYLe = "默认新闻详细.html"
eND iF	
eND fUNcTIoN
fUNcTIoN gETaRTiCLeINfOPhOToWIdTH(a,b,c,d)
dIM e,f
sET e = cREaTEoBJeCT("Adodb.RecordSet")
f = " Where BigClassName='"& a &"' And ArticleInfoPhotoWidth<>'' And ArticleInfoPhotoWidth<>'0'"
e.oPEn"Select * From [BigClass]" & f,cONn,1,1
iF nOT e.eOF tHEn
iF cINt(e("ArticleInfoPhotoWidth"))>0 tHEn
gETaRTiCLeINfOPhOToWIdTH = e("ArticleInfoPhotoWidth")
eND iF
eND iF:e.cLOsE
iF b <>"" tHEn
f = f & " And SmallClassName='"& b &"'"
e.oPEn"Select * From [SmallClass]" & f,cONn,1,1
iF nOT e.eOF tHEn
iF cINt(e("ArticleInfoPhotoWidth"))>0 tHEn
gETaRTiCLeINfOPhOToWIdTH = e("ArticleInfoPhotoWidth")
eND iF
eND iF:e.cLOsE
eND iF
iF b <>"" tHEn
f = f & " And ThreeClassName='"& c &"'"
e.oPEn"Select * From [ThreeClass]" & f,cONn,1,1
iF nOT e.eOF tHEn
iF cINt(e("ArticleInfoPhotoWidth"))>0 tHEn
gETaRTiCLeINfOPhOToWIdTH = e("ArticleInfoPhotoWidth")
eND iF
eND iF:e.cLOsE
eND iF
iF d <>"" tHEn
e.oPEn"Select * From [Product] Where Id=" & d,cONn,1,1
iF nOT e.eOF tHEn
iF (e("ArticleInfoPhotoWidth")<>"" aND e("ArticleInfoPhotoWidth")<>"0") oR e("ArticleInfoPhotoWidth")="-1" tHEn
gETaRTiCLeINfOPhOToWIdTH = e("ArticleInfoPhotoWidth")
eND iF
eND iF:e.cLOsE
eND iF
iF gETaRTiCLeINfOPhOToWIdTH = "0" oR gETaRTiCLeINfOPhOToWIdTH = "" tHEn gETaRTiCLeINfOPhOToWIdTH=600
eND fUNcTIoN
fUNcTIoN gETaRTiCLePAgESiZE(a,b,c)
dIM d,e
sET d = cREaTEoBJeCT("Adodb.RecordSet")
e = " Where BigClassName='"& a &"' And ArticleListStyle<>''"
d.oPEn"Select * From [BigClass]" & e,cONn,1,1
iF nOT d.eOF tHEn
gETaRTiCLePAgESiZE = d("ArticlePageSize")
eND iF:d.cLOsE
iF b <>"" tHEn
e = e & " And SmallClassName='"& b &"'"
d.oPEn"Select * From [SmallClass]" & e,cONn,1,1
iF nOT d.eOF tHEn
gETaRTiCLePAgESiZE = d("ArticlePageSize")
eND iF:d.cLOsE
eND iF
iF b <>"" tHEn
e = e & " And ThreeClassName='"& c &"'"
d.oPEn"Select * From [ThreeClass]" & e,cONn,1,1
iF nOT d.eOF tHEn
gETaRTiCLePAgESiZE = d("ArticlePageSize")
eND iF:d.cLOsE
eND iF
iF gETaRTiCLePAgESiZE = "" oR gETaRTiCLePAgESiZE="0" tHEn	
gETaRTiCLePAgESiZE = 9
eND iF
eND fUNcTIoN
fUNcTIoN gETaRTiCLeLIsTStYLe(a,b,c)
dIM d,e
sET d = cREaTEoBJeCT("Adodb.RecordSet")
d.oPEn"Select * From [NavBigClass] Where BigClassName='"& a &"'",cONn,1,1
iF nOT d.eOF tHEn
iF iNStR("|产品|新闻|下载|","|"& d("NavType") &"|")>0 tHEn
gETaRTiCLeLIsTStYLe = "默认"& d("NavType") &"列表.html"
eND iF
eND iF:d.cLOsE	
e = " Where BigClassName='"& a &"' And ArticleListStyle<>''"
d.oPEn"Select * From [BigClass]" & e,cONn,1,1
iF nOT d.eOF tHEn
gETaRTiCLeLIsTStYLe = d("ArticleListStyle")
eND iF:d.cLOsE
iF b <>"" tHEn
e = e & " And SmallClassName='"& b &"'"
d.oPEn"Select * From [SmallClass]" & e,cONn,1,1
iF nOT d.eOF tHEn
gETaRTiCLeLIsTStYLe = d("ArticleListStyle")
eND iF:d.cLOsE
eND iF
iF b <>"" tHEn
e = e & " And ThreeClassName='"& c &"'"
d.oPEn"Select * From [ThreeClass]" & e,cONn,1,1
iF nOT d.eOF tHEn
gETaRTiCLeLIsTStYLe = d("ArticleListStyle")
eND iF:d.cLOsE
eND iF
iF gETaRTiCLeLIsTStYLe="" tHEn
gETaRTiCLeLIsTStYLe = "默认新闻列表.html"
eND iF	
eND fUNcTIoN
fUNcTIoN rEAdTEmPLaTEfILeSOuRCe(a,b)
dIM c,d,e,f
c = "<!--#sourceHtml"& rEPlACe(b,".html","") &"Start#-->"
d = "<!--#sourceHtml"& rEPlACe(b,".html","") &"End#-->"	
e = rEAdTEmPLaTEfILeMOdULaR(a,c,d)
iF e = "[$NO$]" tHEn
f=gETsTRcUT(pUBcODe,c,d,2)
iF f<>"" tHEn
rEAdTEmPLaTEfILeSOuRCe=f
eXIt fUNcTIoN
eND iF
f=gETfTExT(a)
iF iNStR(f,"<!--#DialogStart#-->")>0 tHEn
rEAdTEmPLaTEfILeSOuRCe=f
eXIt fUNcTIoN
eND iF
e = "模板资源ID["& b &"]不存在,路径TemplateFilePath=" & hANdLEpATh(a)
eND iF
rEAdTEmPLaTEfILeSOuRCe = e
eND fUNcTIoN
fUNcTIoN rEAdARtIClELiSTsTYlESoURcE(a)
dIM b
b = gETwEBiMAgES() & "\文章展示样式\" & a
iF cHEcKFiLE(b)=fALsE tHEn
b = wEBtEMpLAtE & "\Resources\" & a
eND iF
rEAdARtIClELiSTsTYlESoURcE = rEAdTEmPLaTEfILeSOuRCe(b ,a)
eND fUNcTIoN
fUNcTIoN rEAdARtIClEInFOsTYlESoURcE(a)
dIM b
b = gETwEBiMAgES() & "\文章信息展示样式\" & a
iF cHEcKFiLE(b)=fALsE tHEn
b = wEBtEMpLAtE & "\Resources\" & a
eND iF
rEAdARtIClEInFOsTYlESoURcE = rEAdTEmPLaTEfILeSOuRCe(b ,a)
eND fUNcTIoN
%>

