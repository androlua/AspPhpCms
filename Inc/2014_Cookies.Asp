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
fUNcTIoN gETcOOkIE(bYVaL a)
dIM b : b = eASp_PaRAm(a)
iF rESpONsE.cOOkIEs(b(0)).hASkEYs aND nOT iSN(b(1)) tHEn
gETcOOkIE = sAFeDAtA("", rEQuESt.cOOkIEs(b(0))(b(1)), 0)
eLSe
gETcOOkIE = sAFeDAtA("", rEQuESt.cOOkIEs(b(0)), 0)
eND iF
iF iSN(gETcOOkIE) tHEn gETcOOkIE = ""
eND fUNcTIoN
sUB rEMoVEcOOkIE(bYVaL a)
dIM b : b = eASp_PaRAm(a)
iF rESpONsE.cOOkIEs(b(0)).hASkEYs aND nOT iSN(b(1)) tHEn
rESpONsE.cOOkIEs(b(0))(b(1)) = eMPtY
eLSe
rESpONsE.cOOkIEs(b(0)) = eMPtY
rESpONsE.cOOkIEs(b(0)).eXPiREs = nOW()
eND iF
eND sUB
sUB sETaPP(a, b)
aPPlICaTIoN.lOCk
aPPlICaTIoN.cONtENtS.iTEm(a) = b
aPPlICaTIoN.uNLoCK
eND sUB
fUNcTIoN gETaPP(a)
iF iSN(a) tHEn gETaPP = "" : eXIt fUNcTIoN
gETaPP = aPPlICaTIoN.cONtENtS.iTEm(a)
eND fUNcTIoN
sUB rEMoVEaPP(a)
aPPlICaTIoN.lOCk
aPPlICaTIoN.cONtENtS.rEMoVE(a)
aPPlICaTIoN.uNLoCK
eND sUB
fUNcTIoN sETcOOkIE(a, b, c)
rESpONsE.cOOkIEs(a) = b
rESpONsE.cOOkIEs(a).eXPiREs = nOW+1
eND fUNcTIoN
%>

