<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-16
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By �ƶ� 
'************************************************************
%>
<!--#iNClUDe fILe = "../Inc/Config.Asp"-->
<!dOCtYPe hTMl>
<hTMl xMLnS="http://www.w3.org/1999/xhtml">
<hEAd>
<mETa hTTp-eQUiV="Content-Type" cONtENt="text/html; charset=gb2312" />
<tITlE>ģ���ļ�����</tITlE>
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
iF(cONfIRm("ȷ��Ҫɾ����ɾ���󽫲��ɻָ���"))
rETuRN tRUe;
eLSe
rETuRN fALsE;
}
</sCRiPT>
<%
iF sESsIOn("adminusername") = "" tHEn
cALl eERr("��ʾ","δ��¼�����ȵ�¼")
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
f="<a href=""../index.asp?templatedir="& eSCaPE(dIR) &"&templateName="& d &""" target='_blank'>Ԥ��</a> "
cALl eCHo(d,f & "| <a href='?act=addEditFile&dir="& dIR &"&fileName="& d &"'>�޸�</a> | <a href='?act=delTemplateFile&dir="& rEQuESt("dir") &"&fileName="& d &"' onclick='return checkDel()'>ɾ��</a>")	
nEXt
eND sUB
sUB dELtEMpLAtEFiLE(a,b)
dIM c
c=a & "/" & b
cALl dELeTEfILe(c)
cALl eCHo("ɾ���ļ�", c)
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
<td height="30">Ŀ¼<%=a%><br>
<input name="dir" type="hidden" id="dir" value="<%=a%>" /></td>
</tr>
<tr>
<td>�ļ�����
<input name="fileName" type="text" id="fileName" value="<%=b%>" size="40">
<br>
<textarea name="Content" cols="110" rows="25" id="Content"><%=gETfTExT(c)%></textarea></td>
</tr>
<tr>
<td height="40" align="center"><input type="submit" name="button" id="button" value=" ���� " /></td>
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
<input type="submit" name="button2" id="button2" value=" ���� " /></td>
</tr>
</table>
</form>
<%eND fUNcTIoN%>

