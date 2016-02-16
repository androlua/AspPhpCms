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
fUNcTIoN rEAdMAiNInFOsHOwTItLE(a)
dIM b
b = "Select * From [MainInfo] Where Title='" & a & "' And Recommend<>0 "
iF uSErID <> "" tHEn b = b & " And UserId=" & uSErID
rS.oPEn b & " Order By Sort,ID", cONn, 1, 1
iF nOT rS.eOF tHEn
rEAdMAiNInFOsHOwTItLE = rS("ShowTitle")
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN rEAdMAiNInFO(a)
dIM b
b = "Select * From [MainInfo] Where Title='" & a & "' And Recommend<>0 "
iF uSErID <> "" tHEn b = b & " And UserId=" & uSErID
b = b & " Order By Sort,ID"
rS.oPEn b, cONn, 1, 1
iF nOT rS.eOF tHEn
rEAdMAiNInFO = rS("Content")
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN rEAdMAiNId(a)
dIM b
b = "Select * From [MainInfo] Where Title='" & a & "' And Recommend<>0 "
iF uSErID <> "" tHEn b = b & " And UserId=" & uSErID
rS.oPEn b, cONn, 1, 1
iF nOT rS.eOF tHEn
rEAdMAiNId = rS("Id")
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN gETmAInPArAM(bYVaL a, bYVaL b, bYVaL c)
dIM d, e, f
d = "Select * From [" & a & "] " & c
tEMpRS.oPEn d, cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
iF b = "[url]" tHEn
e = tRIm(tEMpRS("FileName"))
iF e = "" tHEn e = "MainInfo" & tEMpRS("Id")
f = gEThANdLEfILeNAmE(e)
f = wEBdEBuG(f, "act=MainInfo&Id=" & tEMpRS("Id"))
gETmAInPArAM = f
eLSeIF b <> "" tHEn
gETmAInPArAM = tEMpRS(b)
eND iF
eND iF : tEMpRS.cLOsE
eND fUNcTIoN
%>


