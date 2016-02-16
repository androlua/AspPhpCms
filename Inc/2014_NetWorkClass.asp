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
cLAsS nETwORkCLaSS
dIM mDBpATh, dATaBAsETyPE
dIM cONn
dIM rS
dIM rSS
dIM rST
dIM rSX
dIM rSD
dIM tEMpRS
dIM rSTeMP
dIM sPLsPEcIAlURl
dIM cAChEDiR
dIM wEBsITe	
dIM sOUrCEuRLlISt	
dIM cLEaNUrLLiST	
dIM iDEnTIcALuRLlISt	
dIM dIFfEReNTuRLlISt	
dIM dIFfEReNTpARaMEtERuRLlISt	
dIM sQLiNUrLLiST	
dIM wEBsTAtE	
dIM wEBfILeSIzE	
dIM pUBhTTpURl	
dIM pUBwEBtITlE	
dIM pUBwEBsITe	
dIM iSReADcAChEFiLE	
dIM dEPtH	
fUNcTIoN gEThTTpURlCOnTEnTUrLLiST(bYVaL a,b,c,d,e)
dIM f,g,h,i
a = hANdLEuRLcOMpLEtE(a)
a = hANdLEsPEcIAlURl(a)
a = hANdLEiNVaLIdURl(a)
a = rEMoVEnONwEBpAGe(a)
iF a<>"" tHEn
iF c<>"" tHEn
wEBsITe = c	
eLSe
wEBsITe=gETwEBsITe(a)
eND iF
iF iSReADcAChEFiLE=tRUe tHEn	
h = cAChEDiR & sETfILeNAmE(gETwEBsITe(a)) & "/"
cALl cREaTEfOLdER(h)
i = h & sETfILeNAmE(a)
iF cHEcKFiLE(i)=tRUe tHEn
g=sPLiT(gETfTExT(i & ".txt"),vBCrLF)
g(0) = gETfTExT(i)
d = g(2)	
e = g(3)	
eND iF
eND iF
iF iSEmPTy(g) tHEn
g = hANdLExMLgET(a, b)
cALl eCHo(a,i):dOEvENtS	
cALl cREaTEfILe(i, g(0))
cALl cREaTEfILe(i & ".txt", vBCrLF & g(1) & vBCrLF & d & vBCrLF & e )
eND iF
f = g(0)	
wEBsTAtE = g(1)	
wEBfILeSIzE = sTRiNGlENgTH(f)	
pUBhTTpURl=a	
pUBwEBtITlE = rEGeXPgETsTR("<TITLE>([^<>]*)</TITLE>", f, 1)	
pUBwEBsITe = gETwEBsITe(a)	
iF 1=2 tHEn
f = gETcONtENtAHrEF(a, f)
eLSe
f = gETaURlTItLElISt(f,"")                         	
f = bATcHFuLLhTTpURl(wEBsITe,f)	
eND iF
sOUrCEuRLlISt = f	
f = hANdLEsPEcIAlURl(f)
f = hANdLEiNVaLIdURl(f)
f = rEMoVEnONwEBpAGe(f)
f = rEMoVEwIDtHUrL(f)                                 	
cLEaNUrLLiST = f	
iDEnTIcALuRLlISt = gETiDEnTIcALwEBsITeURlLIsT(wEBsITe,f)	
dIFfEReNTuRLlISt = gETdIFfEReNTwEBsITeURlLIsT(wEBsITe,f)	
eND iF
eND fUNcTIoN
pUBlIC pROpERtY gET gETsOUrCEuRLlISt()
gETsOUrCEuRLlISt = sOUrCEuRLlISt
eND pROpERtY
pUBlIC pROpERtY gET gETcLEaNUrLLiST()
gETcLEaNUrLLiST = cLEaNUrLLiST
eND pROpERtY
pUBlIC pROpERtY gET gETiDEnTIcALuRLlISt()
gETiDEnTIcALuRLlISt = iDEnTIcALuRLlISt
eND pROpERtY
pUBlIC pROpERtY gET gETdIFfEReNTuRLlISt()
gETdIFfEReNTuRLlISt = dIFfEReNTuRLlISt
eND pROpERtY
pUBlIC pROpERtY gET gETdIFfEReNTpARaMEtERuRLlISt()
gETdIFfEReNTpARaMEtERuRLlISt = hANdLEdIFfEReNTpARaMEtERuRLlISt(iDEnTIcALuRLlISt)
eND pROpERtY
pUBlIC pROpERtY gET gETsQLiNUrLLiST()
gETsQLiNUrLLiST = hANdLEsQLiNUrLLiST(iDEnTIcALuRLlISt)
eND pROpERtY
pUBlIC pROpERtY gET gETwEBsTAtE()
gETwEBsTAtE =wEBsTAtE
eND pROpERtY
pUBlIC pROpERtY gET gETwEBfILeSIzE()
gETwEBfILeSIzE =wEBfILeSIzE
eND pROpERtY
pUBlIC pROpERtY lET sETiSReADcAChEFiLE(sTR)
iSReADcAChEFiLE = sTR
eND pROpERtY
fUNcTIoN hANdLEfULlHTtPUrL(a,b)	
dIM c,d,e,f,g,h
a=gETwEBsITe(a)
c = sPLiT(b, vBCrLF)
b=""
fOR eACh f iN c
iF iNStR(f,"$Array$")>0 tHEn
h=sPLiT(f,"$Array$")
d=h(0)
e=h(1)
eLSe
d = f
e=""
eND iF
d = fULlHTtPUrL(a,d)
iF iNStR(vBCrLF & b & vBCrLF, vBCrLF & d & vBCrLF)=fALsE tHEn
b=b & d & vBCrLF
iF g<>"" tHEn g=g & vBCrLF
g=g & d & "$Array$" & e
eND iF
nEXt
hANdLEfULlHTtPUrL = g
eND fUNcTIoN
pUBlIC fUNcTIoN gETsEArCHuRL(a,b)
dIM c,d,e,f
c = sPLiT(a, vBCrLF)
fOR eACh d iN c
iF iNStR(vBCrLF & e & vBCrLF, vBCrLF & d & vBCrLF)=fALsE aND iNStR(d,b)>0  tHEn
iF e<>"" tHEn e=e & vBCrLF
e=e & d
eND iF
nEXt
gETsEArCHuRL=e
eND fUNcTIoN		                            	
fUNcTIoN rEMoVEwIDtHUrL(a)
dIM b,c,d,e
b = sPLiT(a, vBCrLF)
fOR eACh c iN b
e=fALsE
iF iNStR(vBCrLF & d & vBCrLF, vBCrLF & c & vBCrLF)=fALsE  tHEn
e=tRUe
iF rIGhT(c,1)<>"/" tHEn
iF iNStR(vBCrLF & d & vBCrLF, vBCrLF & c & "/" & vBCrLF)>0  tHEn
e=fALsE
eND iF
eND iF
iF e=tRUe tHEn
iF d<>"" tHEn d=d & vBCrLF
d=d & c
eND iF
eND iF
nEXt
rEMoVEwIDtHUrL=d
eND fUNcTIoN	
fUNcTIoN hANdLEsQLiNUrLLiST(a)
dIM b,c,d,e
b = sPLiT(a, vBCrLF)
a=""
fOR eACh c iN b
d=rEMoTEhTTpURlPArAMeTEr(c)
iF iNStR(d,"?")>0 aND iNStR(vBCrLF & a & vBCrLF, vBCrLF & d & vBCrLF)=fALsE tHEn	
a=a & d & vBCrLF
iF e<>"" tHEn e=e & vBCrLF
e=e & c
eND iF
nEXt
hANdLEsQLiNUrLLiST=e
eND fUNcTIoN	
fUNcTIoN hANdLEdIFfEReNTpARaMEtERuRLlISt(a)
dIM b,c,d,e
b = sPLiT(a, vBCrLF)
a=""
fOR eACh c iN b
d=rEMoTEhTTpURlPArAMeTEr(c)
iF lEN(d)>3 aND iNStR(vBCrLF & a & vBCrLF, vBCrLF & d & vBCrLF)=fALsE tHEn	
a=a & d & vBCrLF
iF e<>"" tHEn e=e & vBCrLF
e=e & c
eND iF
nEXt
hANdLEdIFfEReNTpARaMEtERuRLlISt=e
eND fUNcTIoN	
fUNcTIoN hANdLEsPEcIAlURl(a)
dIM b, c, d, e, f
d = sPLiT(a, vBCrLF)
a=""	
fOR eACh e iN d
f = tRUe
fOR eACh c iN sPLsPEcIAlURl
iF c <> "" aND lEFt(c, 1) <> "#" tHEn
iF iNStR(e, c) > 0 tHEn f = fALsE: eXIt fOR
eND iF
nEXt
iF f = tRUe tHEn
iF a<>"" tHEn
a=a & vBCrLF
eND iF
a = a & hANdLEhTTpURl(e)
eND iF
nEXt
hANdLEsPEcIAlURl = a
eND fUNcTIoN
fUNcTIoN hANdLEiNVaLIdURl(a)
dIM b, c, d, e
b = sPLiT(a, vBCrLF)
a=""
fOR eACh c iN b
c = hANdLEhTTpURl(c)
d = mID(c, iNStRReV(c, "/") + 1)
e = tRUe
iF e = tRUe tHEn
e = lEN(c)>3
eND iF
iF e = tRUe tHEn
e = lEFt(d, 1) <> "#"
eND iF
iF e = tRUe tHEn
e = iNStR(vBCrLF & a & vBCrLF, vBCrLF & c & vBCrLF) = fALsE
eND iF
iF e = tRUe tHEn
e = lEFt(lCAsE(d), 11) <> "javascript:"
eND iF
iF e = tRUe tHEn
iF iNStR(lCAsE(c), "javascript:") > 0 oR iNStR(lCAsE(c), "'") > 0 tHEn
e = fALsE
eND iF
eND iF
iF e = tRUe tHEn
iF a<>"" tHEn
a=a & vBCrLF
eND iF
a = a & c
eND iF
nEXt
hANdLEiNVaLIdURl = a
eND fUNcTIoN
fUNcTIoN rEMoVEnONwEBpAGe(a)
dIM b, c, d, e, f, g, h
b = sPLiT(a, vBCrLF)
fOR eACh c iN b
c = tRIm(c)
h = tRUe
iF c <> "" tHEn
c = hANdLEhTTpURl(c)
d = lCAsE(c)
f = mID(d, iNStRReV(d, "/") + 1)
iF iNStR(f, "?") tHEn
f = mID(f, 1, iNStR(f, "?") - 1)
eND iF
iF iNStR(f, ".") > 0 tHEn
g = mID(f, iNStRReV(f, ".") + 1)
iF iNStR("|jpg|gif|png|bmp|zip|rar|js|xml|doc|pdf|ppt|xlsx|xls|exe|txt|", "|" & g & "|") > 0 tHEn
h = fALsE
eND iF
eND iF
eND iF
iF h = tRUe tHEn
iF iNStR(vBCrLF & e & vBCrLF, vBCrLF & c & vBCrLF) = fALsE tHEn
iF e<>"" tHEn
e=e & vBCrLF
eND iF
e = e & c
eND iF
eND iF
nEXt
rEMoVEnONwEBpAGe = e
eND fUNcTIoN
fUNcTIoN gETiDEnTIcALwEBsITeURlLIsT(bYVaL a, bYVaL b)
gETiDEnTIcALwEBsITeURlLIsT = gETiDEnTIcALoRDiFFeREnTWeBSiTE(a, b, "identica")
eND fUNcTIoN
fUNcTIoN gETdIFfEReNTwEBsITeURlLIsT(bYVaL a, bYVaL b)
gETdIFfEReNTwEBsITeURlLIsT = gETiDEnTIcALoRDiFFeREnTWeBSiTE(a, b, "different")
eND fUNcTIoN
fUNcTIoN gETiDEnTIcALoRDiFFeREnTWeBSiTE(bYVaL a, bYVaL b, c)
dIM d, e, f, g, h
c = lCAsE(c)
d = sPLiT(b, vBCrLF)
b=""
fOR eACh e iN d
e = tRIm(e)
g = lCAsE(gETwEBsITe(e))
h = fALsE
iF c = "identica" oR c = "1" tHEn
iF g = a oR iNStR(g,a)>0 tHEn
h=tRUe
eND iF
eLSe
iF g <> a  aND iNStR(g,a)=fALsE tHEn
h=tRUe
eND iF
eND iF
iF h = tRUe tHEn
iF iNStR(vBCrLF & b & vBCrLF, vBCrLF & e & vBCrLF) = fALsE tHEn
iF b<>"" tHEn
b=b & vBCrLF
eND iF
b = b & e
eND iF
eND iF
nEXt
gETiDEnTIcALoRDiFFeREnTWeBSiTE = b
eND fUNcTIoN	
pRIvATe sUB cLAsS_iNItIAlIZe()
sPLsPEcIAlURl = sPLiT(gETfTExT("\VB工程\Config\不处理域名列表.ini"), vBCrLF)
cAChEDiR = "E:\E盘\WEB网站\网站UrlScan\"
dATaBAsETyPE = "Access"
iSReADcAChEFiLE=tRUe	
iF cHEcKFoLDeR(cAChEDiR)=fALsE tHEn
cALl eERr("缓存目录路径不存在", cAChEDiR)
eND iF
sET rS = cREaTEoBJeCT("Adodb.RecordSet")
sET rSX = cREaTEoBJeCT("Adodb.RecordSet")
sET rSS = cREaTEoBJeCT("Adodb.RecordSet")
sET rST = cREaTEoBJeCT("Adodb.Recordset")
sET rSD = cREaTEoBJeCT("Adodb.Recordset")
sET tEMpRS = cREaTEoBJeCT("Adodb.RecordSet")
sET tEMpRS2 = cREaTEoBJeCT("Adodb.RecordSet")
sET rSTeMP = cREaTEoBJeCT("Adodb.RecordSet")	
eND sUB
pRIvATe sUB cLAsS_tERmINaTE()
eND sUB
pUBlIC pROpERtY lET sETcAChEDiR(fOLdERpATh)
cAChEDiR = fOLdERpATh
eND pROpERtY
pUBlIC pROpERtY lET sETdATaBAsETyPE(sTR)
dATaBAsETyPE = sTR
eND pROpERtY
pUBlIC pROpERtY gET gETtXTfILePAtH(uRL)
gETtXTfILePAtH = cAChEDiR & sETfILeNAmE(uRL)
eND pROpERtY 	
sUB oPEnCOnN()
dIM b, c, d, e, f
iF dATaBAsETyPE = "Access" tHEn
mDBpATh = "/../网站备份\数据库/WebUrlScan.mdb"
cALl hANdLEpATh(mDBpATh)
eND iF
iF mDBpATh <> "" tHEn
cALl hANdLEpATh(mDBpATh)
sET cONn = cREaTEoBJeCT("Adodb.Connection")
cONn.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & mDBpATh
eLSe
iF dATaBAsETyPE = "SqlServerWebData" tHEn
b = "WebData"
d = "sa"
c = "aaa"
e = "127.0.0.1,1433"
eLSeIF dATaBAsETyPE = "SqlServerLocalData" tHEn
b = "LocalData"
d = "sa"
c = "aaa"
e = "127.0.0.1,1433"
eLSeIF dATaBAsETyPE = "RemoteSqlServer" tHEn
b = "qds0140159_db"
d = "qds0140159": c = "L4dN4eRd"
e = "qds-014.hichina.com"
eND iF
f = " Password = " & c & "; user id =" & d & "; Initial Catalog =" & b & "; data source =" & e & ";Provider = sqloledb;"
sET cONn = cREaTEoBJeCT("Adodb.Connection")
cONn.oPEn f
eND iF
sET rS = cREaTEoBJeCT("Adodb.Recordset")
sET rSS = cREaTEoBJeCT("Adodb.Recordset")
sET rST = cREaTEoBJeCT("Adodb.Recordset")
sET rSX = cREaTEoBJeCT("Adodb.Recordset")
sET rSD = cREaTEoBJeCT("Adodb.Recordset")
sET tEMpRS = cREaTEoBJeCT("Adodb.RecordSet")
sET rSTeMP = cREaTEoBJeCT("Adodb.RecordSet")
eND sUB
sUB cLEaRDaTAbASeS()
cONn.eXEcUTe ("Delete From [WebUrlScan]")
eND sUB
fUNcTIoN aDDuRL(a,b)
cALl oPEnCOnN()
aDDuRL=fALsE
rS.oPEn"Select * From [WebUrlScan] Where HttpUrl='"& pUBhTTpURl &"'",cONn,1,3
iF rS.eOF tHEn
rS.aDDnEW
rS("WebSite")=pUBwEBsITe
rS("HttpUrl")=pUBhTTpURl
rS("Title")=pUBwEBtITlE
rS("Title")=pUBwEBtITlE
rS("WebState")=wEBsTAtE
rS("WebFileSize")=wEBfILeSIzE
rS("toUrl")=a
rS("ToTitle")=b
rS.uPDaTE
aDDuRL=tRUe
eND iF :rS.cLOsE
eND fUNcTIoN
fUNcTIoN cHEcKUrL(a)
cALl oPEnCOnN()
rS.oPEn"Select * From [WebUrlScan] Where HttpUrl='"& a &"'",cONn,1,1
cHEcKUrL=fALsE
iF nOT rS.eOF tHEn
cHEcKUrL=tRUe
eND iF
rS.cLOsE
eND fUNcTIoN
fUNcTIoN bATcHAdDUrL(a,b)
dIM c,d,e,f,g,h
c=sPLiT(b,vBCrLF)
fOR eACh d iN c	
d=pHPtRIm(d)	
iF iNStR(d,"$Array$")	>0 tHEn
g=sPLiT(d,"$Array$")
d = g(0)
h=g(1)
eND iF
iF lEN(d)>3 tHEn
iF cHEcKUrL(d)=fALsE tHEn
cALl gEThTTpURlCOnTEnTUrLLiST(d,"","",a,h)	
f = aDDuRL(a,h)
e=e & d & "("& f &")" & vBCrLF
eLSe	
e=e & d & "(exist)" & vBCrLF
eND iF
eND iF
nEXt
bATcHAdDUrL = e
eND fUNcTIoN
eND cLAsS
%>


