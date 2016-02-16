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
fUNcTIoN iSSeLFrEFeR()
dIM b, c
b = cSTr(rEQuESt.sERvERvARiABlES("HTTP_REFERER"))
c = cSTr(rEQuESt.sERvERvARiABlES("SERVER_NAME"))
iF mID(b, 8, lEN(c)) = c tHEn
iSSeLFrEFeR = tRUe
eLSe
iSSeLFrEFeR = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN iSSaFEsTR(a)
dIM b, c, d
b = "' 　&<>?%,;:()`~!@#$^*{}[]|+-=" & cHR(34) & cHR(9) & cHR(32)
c = lEN(b)
iSSaFEsTR = tRUe
fOR d = 1 tO c
iF iNStR(a, mID(b, d, 1)) > 0 tHEn
iSSaFEsTR = fALsE
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
%>

