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
sUB nOCaCHe()
rESpONsE.bUFfER = tRUe
rESpONsE.eXPiREs = 0
rESpONsE.eXPiREsABsOLuTE = nOW() - 1
rESpONsE.cAChECoNTrOL = "no-cache"
rESpONsE.aDDhEAdER "Expires",dATe()
rESpONsE.aDDhEAdER "Pragma","no-cache"
rESpONsE.aDDhEAdER "Cache-Control","private, no-cache, must-revalidate"
eND sUB
fUNcTIoN xY_cLEaRCaCHe(a)
oN eRRoR rESuME nEXt	
dIM b
b = lCAsE(rPArAM(a,"operate"))
iF b="true" aND hANdLEiSCaCHe=fALsE tHEn
cALl nOCaCHe()
hANdLEiSCaCHe=fALsE	
eND iF
eND fUNcTIoN
%>

