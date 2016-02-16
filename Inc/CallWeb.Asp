<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-16
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#iNClUDe fILe = "Config.Asp"-->
<%
dIM tEMp,aDD,sQL,x,i
dIM tHIsWEbSItE
tHIsWEbSItE = hOSt	
sESsIOn("Administrator") = "admin"
cALl oPEnCOnN()
sELeCT cASe rEQuESt("act")
cASe "nav" :  cALl rW(dIVnAViGAtIOn("Where NavTop=True  Order By Sort Asc"))
cASe "foot" :  cALl rW(dIVwEBbOTtOM())
cASe "article" : cALl rW(dIVaRTiCLe)
cASe "JSShowWeb" : cALl jSShOWwEB()	
cASe "articleList","ShowProduct"
sESsIOn("BigClassName")=""
sESsIOn("SmallClassName")=""
sESsIOn("ThreeClassName")=""
iF rQ("Bid")<>"" tHEn sHOwBIdID(rQ("Bid"))
iF rQ("Sid")<>"" tHEn sHOwSIdID(rQ("Sid"))
iF rQ("Tid")<>"" tHEn sHOwTIdID(rQ("Tid"))
sHOwPRoDUcT():aRTiCLeLIsT()
eND sELeCT
sUB jSShOWwEB()
dIM b,c
b = dIVnAViGAtIOn("Where NavTop=True  Order By Sort Asc")
b=rEPlACe(b,vBCrLF,"\n")
b=rEPlACe(b,"/","\/")
c=c & "document.all.nav.innerHTML="""& b &"""" & vBCrLF
b=rEPlACe(dIVwEBbOTtOM,vBCrLF,"\n")
b=rEPlACe(rEPlACe(b,"/","\/"),"""","\""")
c=c & "document.all.foot.innerHTML="""& b &"""" & vBCrLF
cALl rW(c)
eND sUB
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
d = fULlHTtPUrL(tHIsWEbSItE,d)	
cALl wEBdEBuG(d,"act=Nav&NavDid=" & g)
eND iF
c = c & "<li><a " & aHReF(d, "", i) & ">" & h & "</a></li>" &vBCrLF
c = c & "<li class=line></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
c = c & "<li class=right></li>" & vBCrLF
dIVnAViGAtIOn = c
eND fUNcTIoN
fUNcTIoN dIVwEBbOTtOM()
rS.oPEn"Select * From [WebSite]",cONn,1,1
iF nOT rS.eOF tHEn
dIVwEBbOTtOM=rS("WebSiteBottom")
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN dIVaRTiCLe()
dIM b,c
c=tRIm(rEQuESt("Id"))
rS.oPEn"Select * From [Product] Where Id=" & c,cONn,1,1
iF nOT rS.eOF tHEn
b=b & "<div class=""your_position"">首页 ><Span>信息中心</Span></div>" & vBCrLF
b=b & "<div class=""allpagenewstitle"">"& rS("Title") &"</div>" & vBCrLF
b=b & "<div  class=""allpagenewsinfo"">作者："& rS("Author") &"　　发布时间："& rS("AddDateTime") &"</div>" & vBCrLF
b=b & "<div class=""allpagenewscontent"">" & vBCrLF
b=b & rS("Content") & vBCrLF
b=b & "</div>" & vBCrLF
eLSe
b = "没有文章"
eND iF:rS.cLOsE
dIVaRTiCLe = b
eND fUNcTIoN
fUNcTIoN sHOwTIdID(a)
rS.oPEn"Select * From [ThreeClass] Where Id="&a,cONn,1,1
iF nOT rS.eOF tHEn
sESsIOn("BigClassName")=rS("BigClassName")
sESsIOn("SmallClassName")=rS("SmallClassName")
sESsIOn("ThreeClassName")=rS("ThreeClassName")
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN sHOwSIdID(a)
rS.oPEn"Select * From [SmallClass] Where Id="&a,cONn,1,1
iF nOT rS.eOF tHEn
sESsIOn("BigClassName")=rS("BigClassName")
sESsIOn("SmallClassName")=rS("SmallClassName")
sESsIOn("ThreeClassName")=""
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN sHOwBIdID(a)
rS.oPEn"Select * From [BigClass] Where Id="&a,cONn,1,1
iF nOT rS.eOF tHEn
sESsIOn("BigClassName")=rS("BigClassName")
sESsIOn("ThreeClassName")=""
sESsIOn("SmallClassName")=""
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN sHOwPRoDUcT()
iF sESsIOn("ThreeClassName")<>"" tHEn
aDD=" Where BigClassName='"&sESsIOn("BigClassName")&"' And SmallClassName='"&sESsIOn("SmallClassName")&"' And ThreeClassName='"&sESsIOn("ThreeClassName")&"'"
eLSeIF sESsIOn("SmallClassName")<>"" tHEn
aDD=" Where BigClassName='"&sESsIOn("BigClassName")&"' And SmallClassName='"&sESsIOn("SmallClassName")&"'"
eLSeIF sESsIOn("BigClassName")<>"" tHEn
aDD=" Where BigClassName='"&sESsIOn("BigClassName")&"'"
eND iF
eND fUNcTIoN
fUNcTIoN aRTiCLeLIsT()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title>文章列表</title>
</head>
<body>
<script language="javascript" src=""& adminDir &"Images/Function.Js"></script>
<link href=""& adminDir &"Css/Main.Css" rel="stylesheet"  type="text/css">
<link href=""& adminDir &"Css/BodyCss.Css" rel="stylesheet"  type="text/css">
<div class="ClickYes">
<div class="Div800Center">
<%
rW("&nbsp;<a href=""?act=ShowProduct"">产品展示 >> </a>")
rS.oPEn"Select BigClassName,Id From [BigClass] Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
iF sESsIOn("BigClassName")=rS(0) tHEn tEMp="<font color=red>"&rS(0)&"</font>" eLSe tEMp=rS(0)
rW("<a href=?act=ShowProduct&Bid="&rS("Id")&">"&tEMp&"</a> | ")
rS.mOVeNExT:wENd:rS.cLOsE
%>
</div>
<div class="div5"></div>
<%iF sESsIOn("BigClassName")<>"" tHEn
rS.oPEn"Select BigClassName,SmallClassName,Id From [SmallClass] Where BigClassName='"&sESsIOn("BigClassName")&"' Order By Sort",cONn,1,1
iF nOT rS.eOF tHEn
rW("<div class=""Div800Center"" style=""background:#C1CDE3;"">")
wHIlE nOT rS.eOF
iF sESsIOn("SmallClassName")=rS(1) tHEn tEMp="<font color=red>"&rS(1)&"</font>" eLSe tEMp=rS(1)
rW("<a href=?act=ShowProduct&Sid="&rS("Id")&">"&tEMp&"</a> | ")
rS.mOVeNExT:wENd
rW("</div><div class=""div5""></div>")
eND iF:rS.cLOsE
eND iF
%>
<%iF sESsIOn("SmallClassName")<>"" tHEn
rS.oPEn"Select BigClassName,SmallClassName,ThreeClassName,Id From [ThreeClass] Where BigClassName='"&sESsIOn("BigClassName")&"' And SmallClassName='"&sESsIOn("SmallClassName")&"' Order By Sort",cONn,1,1
iF nOT rS.eOF tHEn
rW("<div class=""Div800Center"" style=""background:#C1CDE3;"">")
wHIlE nOT rS.eOF
iF sESsIOn("ThreeClassName")=rS(2) tHEn tEMp="<font color=red>"&rS(2)&"</font>" eLSe tEMp=rS(2)
rW("<a href=?act=ShowProduct&Tid="&rS("Id")&">"&tEMp&"</a> | ")
rS.mOVeNExT:wENd
rW("</div><div class=""div5""></div>")
eND iF:rS.cLOsE
eND iF
%>
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" class="border" align="center">
<form id="formPro" name="formPro" method="post" action="?act=aa">
<tr bgcolor="A4B6D7" class="title">
<td width="30" height="25" align="center" bgcolor="A4B6D7"><b>选中</b></td>
<td width="100" height="25" align="center"><span style="font-weight: bold">信息大类</span></td>
<td width="78" align="center" bgcolor="A4B6D7"><span style="font-weight: bold">信息小类</span></td>
<td width="78" align="center"><span style="font-weight: bold">信息子类</span></td>
<td align="center"><span style="font-weight: bold">信息名称</span></td>
<td width="40" align="center"><b>审核</b></td>
<td width="81" align="center"><span style="font-weight: bold">发布时间</span></td>
<td width="92" align="center"><b>操作选项</b></td>
</tr>
<%
iF sESsIOn("BigClassName")<>"" oR sESsIOn("SmallClassName")<>"" oR sESsIOn("ThreeClassName")<>"" tHEn
aDD=" Where "
iF sESsIOn("BigClassName")<>"" tHEn aDD=aDD&" BigClassName='"&sESsIOn("BigClassName")&"'"	
iF sESsIOn("SmallClassName")<>"" tHEn aDD=aDD&" And SmallClassName='"&sESsIOn("SmallClassName")&"'"
iF sESsIOn("ThreeClassName")<>"" tHEn aDD=aDD&" And ThreeClassName='"&sESsIOn("ThreeClassName")&"'"
eLSeIF rF("Search")<>"" tHEn
aDD=" Where Title like '%"&rF("Search")&"%'"
eLSeIF rF("Sql")<>"" tHEn
aDD=" "&rF("Sql")
eND iF
iF rQ("page") <> "" tHEn tEMp = "&page=" & rQ("page") eLSe tEMp = ""
sQL="Select * From [Product]"&aDD&" Order By Sort"
rS.oPEn sQL,cONn,1,1
iF rS.eOF tHEn
eLSe
rS.pAGeSIzE = 11
nCOuNT=rS.rECoRDcOUnT
nPAgESiZE=rS.pAGeSIzE
mAXpAGe=rS.pAGeCOuNT
pAGe=rEQuESt("page")
iF nOT iSNuMErIC(pAGe) oR pAGe="" tHEn
pAGe=1
eLSe
pAGe=cINt(pAGe)
eND iF
iF pAGe < 1 tHEn
pAGe = 1
eLSeIF  pAGe > mAXpAGe tHEn
pAGe = mAXpAGe
eND iF
rS.aBSoLUtEPaGE = pAGe
iF pAGe = mAXpAGe tHEn
x = nCOuNT-(mAXpAGe-1)*nPAgESiZE
eLSe
x = nPAgESiZE
eND iF
fOR i=1 tO x
%>
<tr bgcolor="#E8FFED" id="TR83" class="tdbg" onMouseOver="onColor(this);" onMouseOut="offColor(this);">
<td height="22" align="center" >
<input name="selectPid" type="checkbox" id="selectPid" value="<%=rS(0)%>" onClick="ShowColor(this,1)" />
<input name="Id" type="hidden" id="Id" value="<%=rS(0)%>"></td>
<td width="100" align="center"><%=rS("BigClassName")%>&nbsp;</td>
<td width="100" align="center"><%=rS("SmallClassName")%>&nbsp;</td>
<td width="100" align="center"><%=rS("ThreeClassName")%>&nbsp;</td>
<td align="left"><a href="#" title="文章标题" name="<%=rS("ID")%>"><%=rS("Title")%></a></td>
<td align="center"><%
cALl rW(sHOwONoFFiMG(rS(0), "Product", "Through", rS("Through"), "/Inc/CallWeb.Asp?act=ShowProduct"))
%></td>
<td align="center"><%=rS("UpDateTime")%>&nbsp;</td>
<td align="center" bgcolor="#E8FFED"><a href="?act=ShowEditProduct&amp;Id=<%=rS(0)&tEMp%>">修改</a> | <a href="?act=DelId&Id=<%=rS(0)&tEMp%>" onClick="return CheckDel();">删除</a></td>
</tr>
<%rS.mOVeNExT:nEXt:eND iF:rS.cLOsE%>
<tr bgcolor="#A4B6D7" class="tdbg">
<td height="22" colspan="9" align="left" ><a href="javascript:Checkmm('全选');">全选</a> <a href="javascript:Checkmm('反选');">反选</a><span style="text-align:center;">
<select name="Sel" id="Sel" onchange="javascript:PROonclick();">
<option>请选择操作</option>
<%	
rW("<option value=""?act=AllSave"&tEMp&""">更新信息</option>")
rW("<option value=""?act=AllDel"&tEMp&""">删除选择</option>")
%>
</select>
</span></td>
</tr></form>
</table>
<div style="text-align:center;">
<%cALl rW(pAGeCOnTRoL(nCOuNT,mAXpAGe,pAGe,"border=0 align=center","<p align=center>"))%></div>
</div>
</body></html>
<%eND fUNcTIoN%>

