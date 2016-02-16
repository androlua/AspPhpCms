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
fUNcTIoN hANdLElINkLIsT(a, b)
dIM c,d,e,f,g
c=sPLiT(a,"$Split$")
fOR eACh e iN c
iF e <> "" tHEn
iF iNStR(e,"(")>0 tHEn
f = mID(e,1,iNStR(e,"(")-1)
g = mID(e,iNStR(e,"(")+1)
iF g<>"" tHEn
iF rIGhT(g,1) = ")" tHEn g=lEFt(g,lEN(g)-1)
eND iF
iF g="收藏" tHEn
e = "<a href='javascript:;' onClick=""window.external.addFavorite('"& wEBuRL &"','"& wEBtITlE &"')"">"& f &"</a>"
eLSeIF g="设为首页" tHEn
e = "<a href='javascript:;' onClick=""var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& wEBuRL &"');"">"& f &"</a>"
eLSe
e = "<a href='"& g &"'>"& f &"</a>"
eND iF
eND iF
d=d & e & b
eND iF
nEXt
iF d <> "" tHEn d=lEFt(d,lEN(d)-lEN(b))
hANdLElINkLIsT = d
eND fUNcTIoN
fUNcTIoN fRIeNDlINkTExT(a)
dIM b, c, d, e, f, g, h
rSX.oPEn "Select * From [FriendLink] Where Through<>0 Order By Sort", cONn, 1, 1
fOR g = 1 tO rSX.rECoRDcOUnT
b = rSX("Url")
d = aTArGEt(rSX("Target"))
e = aREl(rSX("NoFollow"))
c = rSX("Title")
f = rSX("ImgPath")
h = h & "<a href='" & b & "'" & d & "" & e & ">" & fONtCOlORfONtB(c, rSX("FontB"), rSX("FontColor")) & "</a>" & a & vBCrLF
rSX.mOVeNExT : nEXt : rSX.cLOsE
fRIeNDlINkTExT = h
eND fUNcTIoN
%>

