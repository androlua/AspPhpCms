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
fUNcTIoN nEWsHAnDLeLIsTGrOUp(a, b, c, d, e, f, g)
dIM h, i, j, k, l, m, n,o
b = cINt(b)
dIM p,q
p = rPArAM(g,"Sid")
q = rPArAM(g,"Tid")
n = rPArAM(g,"AddSql")
iF lCAsE(lEFt(a, 4)) = "sql:" tHEn
n = mID(a, 5)
eLSeIF a<>"" tHEn
n = "Where BigClassName='" & a & "'"
eND iF
n = rPArAM(g,"AddSql")
k = "Select * From [Product] " & iIF(a<>""," Where BigClassName='" & a & "' ","")
k = gETwHErEAnD(k, iIF(p<>""," Where SmallClassName='" & p & "' ",""))
k = gETwHErEAnD(k, iIF(q<>""," Where ThreeClassName='" & q & "' ",""))
k = gETwHErEAnD(k,n)
rS.oPEn k, cONn, 1, 1
fOR m = 1 tO rS.rECoRDcOUnT
iF m > b tHEn eXIt fOR
h = rS("FileName")
iF cHEcKMaKEhTMlFIlE(h)=tRUe tHEn
h = gEThANdLEfILeNAmE(h)
h = dETaILpAGeADdHTmLPrEFiX(rS("FolderName")) & "/" & h
eND iF
cALl wEBdEBuG(h, "act=CreateArticle&ID=" & rS("Id"))
l = cUTsTR(rS("Title"), e, "... ")
l = fONtCOlORfONtB(l, rS("FontB"), rS("FontColor"))
i = "<a " & aHReF(h, rS("Title"), rS("Target")) & ">" & l & "</a>" & vBCrLF
iF lCAsE(f) = "true" tHEn
i = i & "<span class=""timeright"">" & fORmAT_TImE(rS("UpDateTime"), 14) & "</span>" & vBCrLF
eND iF
i = dISpLAyONlINeEDiTDiALoG("/admin/Product.Asp?act=ShowEditProduct&Id=" & rS("Id") & "&n=" & gETrND(11), i)
j = j & c & i & d
rS.mOVeNExT : nEXt : rS.cLOsE
nEWsHAnDLeLIsTGrOUp = j
eND fUNcTIoN
fUNcTIoN nEWsLIsT(a,b,c,d,e,f)
nEWsLIsT = nEWsHAnDLeLIsTGrOUp(a,b,c,d, 28, e,f)
eND fUNcTIoN
fUNcTIoN gETaRTiCLePArAM(bYVaL a,bYVaL b,bYVaL c)
dIM d,e,f,g
d = "Select * From ["& a &"] " & c
tEMpRS.oPEn d,cONn,1,1
iF nOT tEMpRS.eOF tHEn
iF b = "[url]" tHEn	
f = tEMpRS("FileName")
iF cHEcKReMOtEUrL(f)=fALsE tHEn
f = gEThANdLEuRL(tEMpRS("FileName"))
f = fULlHTtPUrL(hOSt,f)
cALl wEBdEBuG(f, "act=CreateArticle&ID=" & tEMpRS("Id"))
eND iF
gETaRTiCLePArAM = f
eLSeIF b<>"" tHEn
gETaRTiCLePArAM = tEMpRS(b)
eND iF
eND iF:tEMpRS.cLOsE
eND fUNcTIoN
%>
