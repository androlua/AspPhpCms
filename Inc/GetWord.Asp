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
dIM wORdREaDCoNTeNT
fUNcTIoN gETkEYwORd(bYVaL a)
gETkEYwORd = gEThANdLEkEYwORd(a,"")
eND fUNcTIoN
fUNcTIoN gEThANdLEkEYwORd(bYVaL a, b)
dIM c, d, e, f, g, h, i
iF wORdREaDCoNTeNT = "" tHEn
wORdREaDCoNTeNT = vBCrLF & gETfTExT("/DataDir/keyWord.txt")  & vBCrLF
eND iF
c = 0
iF cSTr(b)="1" tHEn
g = a & "    "
fOR e = 1 tO lEN(a)
fOR f = 2 tO 4
i = mID(g, e, f)
iF iNStR(" " & h & " ", " " & i & " ") = fALsE tHEn
iF iNStR(wORdREaDCoNTeNT, vBCrLF & i & vBCrLF) > 0 tHEn
h = h & i & " "
c = c + 1
eND iF
eND iF
nEXt
nEXt
eLSe 	
d = sPLiT(wORdREaDCoNTeNT, vBCrLF)
fOR eACh i iN d
iF i <> "" tHEn
iF iNStR(" " & h & " ", " " & i & " ") = fALsE tHEn
iF iNStR(a, i) > 0 tHEn
h = h & i & " "
c = c + 1
eND iF
eND iF
eND iF
nEXt
eND iF
gEThANdLEkEYwORd = h
eND fUNcTIoN
fUNcTIoN gETcHInAStR(a)
dIM b, c, d, e
fOR b = 1 tO lEN(a)
d = aSC(mID(a, b, 1))
e = mID(a, b, 1)
iF d < 0 tHEn
iF (d <= - 22033 aND d >= - 24158) = fALsE aND iNStR ("�? ", e) = fALsE tHEn
c = c & e
eND iF
eLSeIF rIGhT(c,1)<>" " tHEn
c = c & " "
eND iF
nEXt
gETcHInAStR = c
eND fUNcTIoN
%>

