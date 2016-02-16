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
fUNcTIoN dIVnAViGAtIOn(a)
dIM b, c, d, e, f, g, h, i
rS.oPEn "Select * From [NavBigClass] " & a, cONn, 1, 1
c = c & "<li class=left></li>" & vBCrLF
fOR b = 1 tO rS.rECoRDcOUnT
e = rS("FileName")
iF e <> "" aND rIGhT(e,1)<>"/" tHEn e = e & ".html"
f = "/" & rS("FolderName") & "/"
g = rS("BigClassName")
h = fONtCOlORfONtB(g, rS("FontB"), rS("FontColor"))
i = rS("Target")
d = rS("FileName")
iF cHEcKReMOtEUrL(d)=fALsE tHEn
d = f & e
d = rEPlACe(rEPlACe(d, "//", "/"), "//", "/")
d = fULlHTtPUrL(hOSt(),d)	
cALl wEBdEBuG(d,"act=Nav&NavDid=" & g)
eND iF
c = c & "<li><a " & aHReF(d, "", i) & ">" & h & "</a></li>" &vBCrLF
c = c & "<li class=line></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
c = c & "<li class=right></li>" & vBCrLF
dIVnAViGAtIOn = c
eND fUNcTIoN
fUNcTIoN wEBdEBuG(a, b)
iF rEQuESt("Debug") <> "" aND gETiP = "127.0.0.1" tHEn
a = "/WebAdmin/ShowWeb.Asp?Debug=1&" & b
iF rEQuESt("MackHtml") = "False" tHEn
a = a & "&MackHtml=False"
eND iF
a = a & "&UserId=" & uSErID
eLSe
a = lCAsE(a)
eND iF
wEBdEBuG = a
eND fUNcTIoN
%>

