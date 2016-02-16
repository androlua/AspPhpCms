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
cLAsS mAIsIDe
fUNcTIoN lEFtCLaSSlISt(a, b, c, d)
dIM e, f, g, h,i,j,k,l,m,n,o,p
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
i = rS("SmallClassName")
j = fONtCOlORfONtB(i,rS("FontB"),rS("FontColor")) 	
k = gETsMAlLClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") )
cALl wEBdEBuG(k,"act=CreateClass&ProDid=" & a & "&ProSid=" & rS("SmallClassName"))
l = aTArGEt(rS("Target"))
h=h & "        <div class='ClassSmall'><A "& aHReF(k,"",l) & sTYlEClASs("ClassSid") &">"& j &"</A></div>" & vBCrLF
rSX.oPEn"Select * From [ThreeClass] Where BigClassName='"& a &"' And SmallClassName='"& rS("SmallClassName") &"' Order By Sort,ID Asc",cONn,1,1
iF nOT rSX.eOF tHEn	
fOR f=1 tO rSX.rECoRDcOUnT
iF i="汉堡加盟菜单" tHEn
m =  gETtHReEClASsFIlENaME(rSX("BigClassName"),rSX("SmallClassName"),rSX("ThreeClassName"))
eLSe
m = gETpROdUCtURl("Where BigClassName='"& rSX("BigClassName") &"' And SmallClassName='"& rSX("SmallClassName") &"' And ThreeClassName='"& rSX("ThreeClassName") &"'")
eND iF
l = aTArGEt(rSX("Target"))
p = rSX("ThreeClassName")
o = fONtCOlORfONtB(p,rSX("FontB"),rSX("FontColor")) 	
iF p = c tHEn
o="<font color=red>"& o  &"</font>"
eND iF
h=h & "                <div class='ClassThree'><a "& aHReF(m,"",l) & sTYlEClASs("ClassTid") &">"& o &"</a></div>" & vBCrLF
rSX.mOVeNExT:nEXt
eND iF:rSX.cLOsE
h=h & "<div class='clear10'></div>"
rS.mOVeNExT:wENd:rS.cLOsE
lEFtCLaSSlISt = h
eND fUNcTIoN
eND cLAsS
%>

