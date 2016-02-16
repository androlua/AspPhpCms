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
fUNcTIoN gETwHErEAnD(bYVaL a, bYVaL b)
dIM c, d
iF tRIm(b) = "" tHEn gETwHErEAnD = a : eXIt fUNcTIoN
iF iNStR(lCAsE(a), " where ") > 0 tHEn
d = " And "
eLSe
d = " Where "
eND iF
iF b <> "" tHEn
b = tRIm(b)
c = lCAsE(b)
iF lEFt(c, 6) = "order " oR lEFt(c, 6) = "group " tHEn
gETwHErEAnD = a & " " & b : eXIt fUNcTIoN 	
eLSeIF lEFt(c, 6) = "where " tHEn
b = mID(b, 7)
eLSeIF lEFt(c, 4) = "and " tHEn
b = mID(b, 5)
eND iF
a = a & d & b
eND iF
gETwHErEAnD = a
eND fUNcTIoN
fUNcTIoN oRAnDSeARcH(a, b, c)
dIM d, e, f
c = rEGeXP_REpLAcE(c, " or ", " Or ")
c = rEGeXP_REpLAcE(c, " and ", " And ")
iF iNStR(c, " Or ") > 0 tHEn
d = sPLiT(c, " Or ")
fOR eACh e iN d
iF e <> "" tHEn
iF f <> "" tHEn f = f & " Or "
f = f & " " & b & " Like '%" & e & "%'"
eND iF
nEXt
eLSeIF iNStR(c, " And ") > 0 tHEn
d = sPLiT(c, " And ")
fOR eACh e iN d
iF e <> "" tHEn
iF f <> "" tHEn f = f & " And "
f = f & " " & b & " Like '%" & e & "%'"
eND iF
nEXt
eLSeIF c <> "" tHEn
d = sPLiT(c, " And ")
fOR eACh e iN d
iF e <> "" tHEn
iF f <> "" tHEn f = f & " And "
f = f & " " & b & " Like '%" & e & "%'"
eND iF
nEXt
eND iF
iF f <> "" tHEn
iF iNStR(lCAsE(a), " where ") = 0 tHEn
f = " Where " & f
eLSe
f = " And " & f
eND iF
a = a & f
eND iF
oRAnDSeARcH = a
eND fUNcTIoN
%>

