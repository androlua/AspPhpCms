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
fUNcTIoN pOPuLArSEaRChESlISt(a,b,c,d)
dIM e, f, g, h,i,j,k,l,m
iF d = "" tHEn d = " Where Through<>0 Order By Sort Desc"
rS.oPEn"Select * From [SearchCount] " & d,cONn,1,1
fOR f=1 tO b
iF rS.eOF tHEn eXIt fOR
k = rS("Title")
j = "/Inc/Create_Html.Asp?act=Search&MackHtml=False&wd=" & k
iF cHEcKMaKEhTMlFIlE(rS("FileName"))=fALsE tHEn
j = rS("FileName")
eND iF
l = k
l = fONtCOlORfONtB(l,rS("FontB"),rS("FontColor")) 	
iF k = m tHEn	
g = tEXtFOnTB(k,tRUe)
eLSe
g = "<a href='"& j &"'"& sEThTMlPArAM(a,"target|title|alt|id|class|style") &">"& l &"</a>"
eND iF
g = dISpLAyONlINeED2("/admin/SearchGl.Asp?act=ShowEdit&Id=" & rS("Id") & "&n=" & gETrND(11), g, "<li|<a ")
h=h & g
iF f+1<b aND f+1<=rS.rECoRDcOUnT tHEn h=h & c & vBCrLF
rS.mOVeNExT:nEXt:rS.cLOsE
pOPuLArSEaRChESlISt=h
eND fUNcTIoN
%> 
