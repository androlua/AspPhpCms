<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-02
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN xY_iNClUDe(a)
dIM b, c, d, e, f
b = lCAsE(rPArAM(a, "File"))
c = lCAsE(rPArAM(a, "Block"))
dIM g, h
g = rPArAM(a, "findstr")
h = rPArAM(a, "replacestr")
b = hANdLEfILeURl(b)
iF cHEcKFiLE(b) = fALsE tHEn
b = wEBtEMpLAtE & b
eND iF
f = gETfTExT(b)
iF c <> "" tHEn
d = "<!--#" & c & " start#-->"
e = "<!--#" & c & " end#-->"
iF iNStR(f, d) > 0 aND iNStR(f, e) > 0 tHEn
f = sTRcUT(f, d, e, 2)
eND iF
eND iF
iF g <> "" tHEn
f = rEPlACe(f, g, h)
eND iF
xY_iNClUDe = f
eND fUNcTIoN
fUNcTIoN hANdLEmODuLErEPlACeARrAY(bYVaL a)
dIM b, c, d, e, f
fOR b = 1 tO uBOuND(mODuLErEPlACeARrAY) - 1
iF mODuLErEPlACeARrAY(b, 0) = "" tHEn
eXIt fOR
eND iF
f = mODuLErEPlACeARrAY(b, 0)
e = mODuLErEPlACeARrAY(0, b)
iF f = "【删除】" tHEn
a = rEPlACe(a, e, "")
eLSe
c = "<replacestrname " & f & ">" : d = "</replacestrname " & f & ">"
iF iNStR(a, c) > 0 aND iNStR(a, d) > 0 tHEn
a = rEPlACeCOnTEnTMoDUlE(a, c, d, e, "")
eND iF
c = "<replacestrname " & f & "/>"
iF iNStR(a, c) > 0 tHEn
a = rEPlACeCOnTEnTRoWMoDUlE(a, "<replacestrname " & f & "/>", e, "")
eND iF
eND iF
nEXt
hANdLEmODuLErEPlACeARrAY = a
eND fUNcTIoN
fUNcTIoN dELtEMpLAtEMyNOtE(a)
dIM b, c, d, e, f, g, h, i
dIM j, k, l, m, n, o
f = 99
fOR d = 1 tO f
b = "<R#读出内容" : c = " start#>"
h = sTRcUT(a, b, c, 2)
iF h <> "" tHEn
b = "<R#读出内容" & h & " start#>" : c = "<R#读出内容" & h & " end#>"
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
e = sTRcUT(a, b, c, 1)
a = rEPlACe(a, e, "")
eND iF
eLSe
eXIt fOR
eND iF
nEXt
iF rEQuESt("gl") = "yun" tHEn
j = gETfTExT("/Jquery/dragsort/Config.html")
j = gETfTExT("/Jquery/dragsort/模块拖拽.html")
b = "<style>"
c = "</style>"
iF iNStR(j, b) > 0 aND iNStR(j, c) > 0 tHEn
k = sTRcUT(j, b, c, 1)
eND iF
b = "<!--#top start#-->"
c = "<!--#top end#-->"
iF iNStR(j, b) > 0 aND iNStR(j, c) > 0 tHEn
l = sTRcUT(j, b, c, 2)
eND iF
b = "<!--#foot start#-->"
c = "<!--#foot end#-->"
iF iNStR(j, b) > 0 aND iNStR(j, c) > 0 tHEn
m = sTRcUT(j, b, c, 2)
eND iF
b = "<!--#value start#-->"
c = "<!--#value end#-->"
iF iNStR(j, b) > 0 aND iNStR(j, c) > 0 tHEn
n = sTRcUT(j, b, c, 2)
eND iF
b = "<dIv datid='"
c = "</dIv>"
j = gETaRRaY(a, b, c, fALsE, fALsE)
g = sPLiT(j, "$Array$")
fOR eACh e iN g
b = "【DatId】'"
i = mID(e, 1, iNStR(e, b) - 1)
e = mID(e, iNStR(e, b) + lEN(b))
e = "<div" & e & "</div>"
o = o & rEPlACe(rEPlACe(n, "{$value$}", e), "{$id$", i)
nEXt
o = rEPlACe(o, "【换行】", vBCrLF)
o = l & o & m
a = mID(a, 1, iNStR(a, "<body>") - 1)
a = rEPlACe(a, "</head>", k & "</head></body>" & o & "</body></html>")
eND iF
b = "<dIv datid='" : c = "【DatId】'"
fOR d = 1 tO f
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
i = sTRcUT(a, b, c, 2)
a = rEPlACe2(a, b & i & c, "<div ")
eLSe
eXIt fOR
eND iF
nEXt
a = rEPlACe(a, "</dIv>", "</div>")
b = "<!--#dialogteststart#-->" : c = "<!--#dialogtestend#-->"
a = rEPlACe(a, "<!--#dialogtest start#-->", b)
a = rEPlACe(a, "<!--#dialogtest end#-->", c)
fOR d = 1 tO f
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
e = sTRcUT(a, b, c, 1)
a = rEPlACe2(a, e, "")
eLSe
eXIt fOR
eND iF
nEXt
b = "<!--#teststart#-->" : c = "<!--#testend#-->"
a = rEPlACe(a, "<!--#del start#-->", b)
a = rEPlACe(a, "<!--#del end#-->", c)
a = rEPlACe(a, "<!--#test start#-->", b)
a = rEPlACe(a, "<!--#test end#-->", c)
fOR d = 1 tO f
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
e = sTRcUT(a, b, c, 1)
a = rEPlACe2(a, e, "")
eLSe
eXIt fOR
eND iF
nEXt
a = rEPlACe(a, "<sPAn class=""testspan"">", "")
a = rEPlACe(a, "<sPAn class=""testhidde"">", "")
a = rEPlACe(a, "</sPAn>", "")
b = "<!--#" : c = "#-->"
fOR d = 1 tO f
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
e = sTRcUT(a, b, c, 1)
a = rEPlACe2(a, e, "")
eLSe
eXIt fOR
eND iF
nEXt
dELtEMpLAtEMyNOtE = a
eND fUNcTIoN
sUB hANdLEfUNpARaMEtER(a, b, c, d, e, f, g, h)
dIM i, j
b = rPArAM(a, "Did")
c = rPArAM(a, "Sid")
d = rPArAM(a, "Tid")
b = iIF(b = "[$PubProDid$]", pUBpROdID, b)
c = iIF(c = "[$PubProSid$]", pUBpROsID, c)
d = iIF(d = "[$PubProTid$]", pUBpROtID, d)
e = rPArAM(a, "Title")
f = rPArAM(a, "TopNumb")
g = rPArAM(a, "CutStrNumb")
iF g = "" tHEn g = 28
h = rPArAM(a, "AddSql")
eND sUB
fUNcTIoN hANdLErEPlACeVAlUEpARaM(a, bYVaL b, c)
iF iNStR(a, "[$" & b)=fALsE tHEn
b=lCAsE(b)
eND iF
hANdLErEPlACeVAlUEpARaM=rEPlACeVAlUEpARaM(a, b, c)
eND fUNcTIoN
fUNcTIoN rEPlACeVAlUEpARaM(a, b, c)
dIM d, e, f,g, h, i, j, k, l, m
dIM iFStR	
dIM o
dIM vALuEStR	
dIM eLSeSTr	
dIM iNStRStR	
iF iSNuL(c) = tRUe tHEn c = ""
d = "[$" & b : e = "$]"
iF iNStR(a, d) > 0 aND iNStR(a, e) > 0 tHEn
iF iNStR(a, d & e) > 0 tHEn
f = d & e
eLSeIF iNStR(a, d & " ") > 0 tHEn
f = sTRcUT(a, d & " ", e, 1)
eLSe
f = sTRcUT(a, d, e, 1)
eND iF
g=f
f=hANdLEiNMoDUlE(f,"start")
j = rPArAM(f, "delHtml")
iF j = "true" tHEn c = rEPlACe(dELhTMl(c), "<", "&lt;")
l = rPArAM(f, "trim")
iF l = "true" tHEn c = tRImVBcRLf(c)
h = rPArAM(f, "len")
h = hANdLEnUMbER(h)
iF h <> "" tHEn c = cUTsTR(c, h, "...")
i = rPArAM(f, "format_Time")
iF i <> "" tHEn
c = fORmAT_TImE(c, i)
eND iF
m = rPArAM(f, "getcolumnname")
iF m <> "" tHEn
iF m="@ME" tHEn
m=c
eND iF
c = gETcOLuMNnAMe(m)
eND iF	
m = rPArAM(f, "getcolumnurl")
iF m <> "" tHEn
iF m="@ME" tHEn
m=c
eND iF
c = gETcOLuMNuRL(m,"id")
eND iF	
iFStR=rPArAM(f,"if")
o=rPArAM(f,"elseif")	
vALuEStR=rPArAM(f,"value")
eLSeSTr=rPArAM(f,"else")
iNStRStR=rPArAM(f,"instr")
iF iFStR<>"" oR iNStRStR<>"" tHEn
iF (iFStR=cSTr(c) aND iFStR<>"") oR (o=cSTr(c) aND o<>"") tHEn
c=vALuEStR
eLSeIF iNStR(cSTr(c),iNStRStR)>0 aND iNStRStR<>"" tHEn
c=vALuEStR
eLSe
iF eLSeSTr<>"@ME" tHEn
c=eLSeSTr
eND iF
eND iF
eND iF
k = rPArAM(f, "function")
iF k <> "" tHEn
k=rEPlACe(k,"@ME",c)
c=hANdLEcONtENtCOdE(k,"")
eND iF
a = rEPlACe(a, g, c)
eND iF
rEPlACeVAlUEpARaM = a
eND fUNcTIoN
fUNcTIoN tEStFUnCTiON(a)
tEStFUnCTiON=a & "(end)"
eND fUNcTIoN
%>

