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
<!--#iNClUDe fILe = "../Inc/Config.Asp"-->
<!dOCtYPe hTMl>
<hTMl xMLnS="http://www.w3.org/1999/xhtml">
<hEAd>
<mETa hTTp-eQUiV="Content-Type" cONtENt="text/html; charset=gb2312" />
<tITlE>模板文件管理</tITlE>
</hEAd>
<bODy>
<sTYlE tYPe="text/css">
<!--
bODy {
mARgIN-lEFt: 0pX;
mARgIN-tOP: 0pX;
mARgIN-rIGhT: 0pX;
mARgIN-bOTtOM: 0pX;
}
a:lINk,a:vISiTEd,a:aCTiVE {
cOLoR: #000000;
tEXt-dECoRAtIOn: nONe;
}
a:hOVeR {
cOLoR: #666666;
tEXt-dECoRAtIOn: nONe;
}
.tABlELiNE{
bORdER: 1pX sOLiD #999999;
}
bODy,tD,tH {
fONt-sIZe: 12pX;
}
a {
fONt-sIZe: 12pX;
}
-->
</sTYlE>
<sCRiPT lANgUAgE="javascript">
fUNcTIoN cHEcKDeL()
{
iF(cONfIRm("确认要删除吗？删除后将不可恢复！"))
rETuRN tRUe;
eLSe
rETuRN fALsE;
}
</sCRiPT>
<%
iF sESsIOn("adminusername") = "" tHEn
cALl eERr("提示","未登录，请先登录")
eND iF
sELeCT cASe rEQuESt("act")
cASe "templateFileList" : sOLdERsEArCH(rEQuESt("dir")): tEMpLAtEFiLElISt(rEQuESt("dir"))	
cASe "delTemplateFile" : cALl dELtEMpLAtEFiLE(rEQuESt("dir"),rEQuESt("fileName")) : sOLdERsEArCH(rEQuESt("dir")): tEMpLAtEFiLElISt(rEQuESt("dir"))
cASe "addEditFile" : sOLdERsEArCH(rEQuESt("dir")): cALl aDDeDItFIlE(rEQuESt("dir"),rEQuESt("fileName"))	
cASe eLSe : sOLdERsEArCH(rEQuESt("dir"))	
eND sELeCT
sUB tEMpLAtEFiLElISt(dIR)
dIM b,c,d,e,f
b = gETdIRhTMlLIsTNaME(dIR)
c=sPLiT(b,vBCrLF)
fOR eACh d iN c
f="<a href=""../index.asp?templatedir="& eSCaPE(dIR) &"&templateName="& d &""" target='_blank'>预览</a> "
cALl eCHo(d,f & "| <a href='?act=addEditFile&dir="& dIR &"&fileName="& d &"'>修改</a> | <a href='?act=delTemplateFile&dir="& rEQuESt("dir") &"&fileName="& d &"' onclick='return checkDel()'>删除</a>")	
nEXt
eND sUB
sUB dELtEMpLAtEFiLE(a,b)
dIM c
c=a & "/" & b
cALl dELeTEfILe(c)
cALl eCHo("删除文件", c)
eND sUB
fUNcTIoN aDDeDItFIlE(a,b)
dIM c
iF rIGhT(lCAsE(b),5)<>".html" tHEn
b=b & ".html"
eND iF
c=a & "/" & b
iF rEQuESt("issave")="true" tHEn
cALl cREaTEfILe(c,rEQuESt("content"))
eND iF
%>
<form name="form1" method="post" action="?act=addEditFile&issave=true">
<table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline">
<tr>
<td height="30">目录<%=a%><br>
<input name="dir" type="hidden" id="dir" value="<%=a%>" /></td>
</tr>
<tr>
<td>文件名称
<input name="fileName" type="text" id="fileName" value="<%=b%>" size="40">
<br>
<textarea name="Content" cols="110" rows="25" id="Content"><%=gETfTExT(c)%></textarea></td>
</tr>
<tr>
<td height="40" align="center"><input type="submit" name="button" id="button" value=" 保存 " /></td>
</tr>
</table>
</form>
<%eND fUNcTIoN
fUNcTIoN sOLdERsEArCH(a)
%>
<form name="form2" method="post" action="?act=templateFileList">
<table width="800" border="0" cellspacing="0" cellpadding="0" class="tableline">
<tr>
<td height="30"><input name="dir" type="text" id="dir" value="<%=a%>" size="60" />
<input type="submit" name="button2" id="button2" value=" 进入 " /></td>
</tr>
</table>
</form>
<%eND fUNcTIoN%>

