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
cONsT cAChEPrEFiX = "CACHE_"
fUNcTIoN aDDcAChE(a)
dIM b,aRY(4)
iF nOT iSArRAy(a) tHEn
rESpONsE.wRItE "Error:AddCache(varAry)参数错误，参数不是数组"
rESpONsE.eND()
eND iF
iF uBOuND(a) <> 3 tHEn
rESpONsE.wRItE "Error:AddCache(varAry)参数错误，数组长度错误"
rESpONsE.eND()
eND iF
iF a(0) = "" tHEn
rESpONsE.wRItE "Error:AddCache(varAry)错误，key不能为空"
rESpONsE.eND()
eND iF
iF a(1) = "" oR nOT iSNuMErIC(a(1)) tHEn a(1) = 1200
aPPlICaTIoN.lOCk()
aPPlICaTIoN(cAChEPrEFiX & a(0)) = aRRaY(a(0),a(1),a(2),a(3),dATeADd("s",a(1),nOW()))
aPPlICaTIoN.uNLoCK()
eND fUNcTIoN
fUNcTIoN cHEcKCaCHe(a)
dIM b
fOR eACh b iN aPPlICaTIoN.cONtENtS
iF lCAsE(b) = lCAsE(cAChEPrEFiX & a) tHEn cHEcKCaCHe = tRUe : eXIt fUNcTIoN
nEXt
cHEcKCaCHe = fALsE
eND fUNcTIoN
fUNcTIoN rEMoVEcAChE(a)
aPPlICaTIoN.lOCk()
aPPlICaTIoN.cONtENtS.rEMoVE(cAChEPrEFiX & a)
aPPlICaTIoN.uNLoCK()
eND fUNcTIoN
fUNcTIoN uPDaTEcAChE(a)
dIM b
b = gETcAChE(a(0))
iF nOT iSNuLL(a(1)) tHEn b(1) = a(1)
iF nOT iSNuLL(a(2)) tHEn b(2) = a(2)
iF nOT iSNuLL(a(3)) tHEn b(3) = a(3)
iF b(1) = "" oR nOT iSNuMErIC(b(1)) tHEn b(1) = 1200
aPPlICaTIoN.lOCk()
aPPlICaTIoN(cAChEPrEFiX & b(0)) = aRRaY(b(0),b(1),b(2),b(3),dATeADd("s",b(1),nOW()))
aPPlICaTIoN.uNLoCK()
eND fUNcTIoN
fUNcTIoN pRInTCaCHe(a)
dIM b, c, d
iF cHEcKCaCHe(a) tHEn
b = gETcAChE(a)
rESpONsE.wRItE "<pre>{" & cHR(10)
rESpONsE.wRItE cHR(32) & "缓存名称" & cHR(32) & ":" & cHR(32) & cAChEPrEFiX & b(0) & cHR(10)
rESpONsE.wRItE cHR(32) & "缓存key " & cHR(32) & ":" & cHR(32) & b(0) & cHR(10)
rESpONsE.wRItE cHR(32) & "缓存时间" & cHR(32) & ":" & cHR(32) & b(1) & cHR(10)
rESpONsE.wRItE cHR(32) & "到期时间" & cHR(32) & ":" & cHR(32) & b(4) & cHR(10)
rESpONsE.wRItE cHR(32) & "是否到期" & cHR(32) & ":" & cHR(32) & b(5) & cHR(10)
rESpONsE.wRItE cHR(32) & "缓存说明" & cHR(32) & ":" & cHR(32) & b(3) & cHR(10)
rESpONsE.wRItE cHR(32) & "缓存内容" & cHR(32) & ":" & cHR(32)
d = vARtYPe(b(2))
iF iNStR(",0,1,2,3,4,5,6,7,8,11,", "," & d & ",") > 0 tHEn
rESpONsE.wRItE b(2)
eLSe
rESpONsE.wRItE tYPeNAmE(b(2))
eND iF
rESpONsE.wRItE cHR(10)
rESpONsE.wRItE "}</pre>" & cHR(10)
eLSe
rESpONsE.wRItE "不存在该缓存"
eND iF
eND fUNcTIoN
fUNcTIoN gETcAChE(a)
dIM b, c
b = aPPlICaTIoN(cAChEPrEFiX & a)
c = fALsE
iF dATeDIfF("s", nOW(), b(4)) <= 0 tHEn c = tRUe
gETcAChE = aRRaY(b(0), b(1), b(2), b(3), b(4), c)
eND fUNcTIoN
fUNcTIoN hCShOW(a)
dIM b, c, d
iF cHEcKCaCHe(a) tHEn
b = gETcAChE(a)
d = vARtYPe(b(2))
iF iNStR(",0,1,2,3,4,5,6,7,8,11,", "," & d & ",") > 0 tHEn
hCShOW = b(2)
eLSe
hCShOW = tYPeNAmE(b(2))
eND iF
eLSe
hCShOW = "不存在该缓存"
eND iF
eND fUNcTIoN
sUB bR(a)
rESpONsE.wRItE a & "<br />" & vBCrLF
eND sUB
fUNcTIoN rEMoVEaLLcAChE()
aPPlICaTIoN.lOCk
aPPlICaTIoN.cONtENtS.rEMoVEaLL
aPPlICaTIoN.uNLoCK
eND fUNcTIoN
%>

