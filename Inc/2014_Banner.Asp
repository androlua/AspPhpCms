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
fUNcTIoN xY_dETaILbANnER(a)
dIM b, c, d, e, f, g, h
b = rPArAM(a, "defaultimage")
c = pUBnAVdID
iF c = "" tHEn c = pUBpROdID
d = pUBnAVsID
iF d = "" tHEn d = pUBpROsID
e = pUBpROtID
iF e = "" tHEn e = pUBpROtID
iF pUBiD <> "" tHEn
iF pUBaCTiONtYPe = "MainInfo" tHEn
f = pUBiD
eLSeIF pUBaCTiONtYPe = "Article" tHEn
g = pUBiD
eND iF
eND iF
iF c <> "" tHEn
rS.oPEn "Select * From [BigClass] Where BigClassName='" & c & "' And ImgPath<>''", cONn, 1, 1
iF nOT rS.eOF tHEn
h = rS("ImgPath")
eND iF : rS.cLOsE
eND iF
iF d <> "" tHEn
rS.oPEn "Select * From [SmallClass] Where BigClassName='" & c & "' And SmallClassName='" & d & "' And ImgPath<>''", cONn, 1, 1
iF nOT rS.eOF tHEn
h = rS("ImgPath")
eND iF : rS.cLOsE
eND iF
iF e <> "" tHEn
rS.oPEn "Select * From [ThreeClass] Where BigClassName='" & c & "' And SmallClassName='" & d & "' And ThreeClassName='" & e & "' And ImgPath<>''", cONn, 1, 1
iF nOT rS.eOF tHEn
h = rS("ImgPath")
eND iF : rS.cLOsE
eND iF
iF c <> "" tHEn
rS.oPEn "Select * From [NavBigClass] Where BigClassName='" & c & "' And ImgPath<>''", cONn, 1, 1
iF nOT rS.eOF tHEn
h = rS("ImgPath")
eND iF : rS.cLOsE
eND iF
iF d <> "" tHEn
rS.oPEn "Select * From [NavSmallClass] Where BigClassName='" & c & "' And SmallClassName='" & d & "' And ImgPath<>''", cONn, 1, 1
iF nOT rS.eOF tHEn
h = rS("ImgPath")
eND iF : rS.cLOsE
eND iF
iF g <> "" aND 1 = 2 tHEn
rS.oPEn "Select * From [Product] Where Id=" & g & " And (BigFiles<>'' Or SmallFiles<>'')", cONn, 1, 1
iF nOT rS.eOF tHEn
h = iIF(rS("BigFiles") <> "", rS("BigFiles"), rS("SmallFiles"))
eND iF : rS.cLOsE
eND iF
xY_dETaILbANnER = iIF(h <> "", h, b)
xY_dETaILbANnER = hANdLEhTTpURl(xY_dETaILbANnER)
iF 1 = 2 tHEn
cALl eCHo("PubNavDid", pUBnAVdID)
cALl eCHo("PubNavSid", pUBnAVsID)
cALl eCHo("PubProDid", pUBpROdID)
cALl eCHo("PubProSid", pUBpROsID)
cALl eCHo("PubProTid", pUBpROtID)
cALl eCHo("PubActionType", pUBaCTiONtYPe)
cALl eCHo("PubID", pUBiD)
cALl eCHo("PubClassName", pUBcLAsSNaME)
cALl eCHo("PubWD", pUBwD)
cALl eCHo("ImgUrl", h)
eND iF
eND fUNcTIoN
fUNcTIoN bANnERsWItCH(bYVaL a, bYVaL b)
dIM c, d, e, f, g, h
h = 22
iF lCAsE(lEFt(a, 4)) = "sql:" tHEn
e = mID(a, 5)
eLSe
e = "Where BigClassName='" & a & "' And Recommend<>0 Order By Sort"
eND iF
d = d & "<div class=""bannerlb pr"" id=""flashs"">" & vBCrLF
f = "Select * From [Product] " & e
rS.oPEn f, cONn, 1, 1
fOR c = 1 tO rS.rECoRDcOUnT
iF c > b tHEn eXIt fOR
g = rS("FileName")
iF cHEcKReMOtEUrL(g) = fALsE tHEn
g = gEThANdLEuRL(rS("FileName"))
cALl wEBdEBuG(g, "act=CreateArticle&ID=" & rS("Id"))
eND iF
sHOwTItLE = cUTsTR(rS("Title"), h, "... ")
sHOwTItLE = fONtCOlORfONtB(sHOwTItLE, rS("FontB"), rS("FontColor"))
d = d & "    <div title=""" & sHOwTItLE & """ alt=""" & sHOwTItLE & """ onClick=""window.open('" & g & "')"" class=""bgitem"" id=""flashbg" & c - 1 & """  style=""background: url('" & rS("BigFiles") & "') no-repeat scroll center top;" & vBCrLF
d = d & "height: 496px;cursor:pointer; width: 100%; margin:0 auto;""></div>" & vBCrLF & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
d = d & "</div> " & vBCrLF
bANnERsWItCH = d
eND fUNcTIoN
fUNcTIoN bANnERsWItCH2(bYVaL a, bYVaL b)
dIM c, d
rS.oPEn "Select * From[Product] Where BigClassName='" & a & "'", cONn, 1, 1
d = d & "<div class=""container"" id=""idTransformView2"">" & vBCrLF
d = d & "  <ul class=""slider slider2"" id=""idSlider2"">" & vBCrLF
fOR c = 1 tO b
iF rS.eOF tHEn b = c - 1 : eXIt fOR
d = d & "    <li><img src=""" & rS("BigFiles") & """/></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
d = d & "  </ul>" & vBCrLF
d = d & "  <ul class=""num"" id=""idNum2"">" & vBCrLF
fOR c = 1 tO b
d = d & "    <li>" & c & "</li>" & vBCrLF
nEXt
d = d & "  </ul>" & vBCrLF
d = d & "</div>" & vBCrLF
bANnERsWItCH2 = d
eND fUNcTIoN
%>


