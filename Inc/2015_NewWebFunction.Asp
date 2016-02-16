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
<%
fUNcTIoN sPEcIAlSTrREpLAcE(bYVaL a)
a = rEPlACe(a, "\|", "[$特殊字符A]$")
a = rEPlACe(a, "\-", "[$特殊字符B]$")
a = rEPlACe(a, "\,", "[$特殊字符C]$")
a = rEPlACe(a, "\'", "[$特殊字符D]$")
a = rEPlACe(a, "\""", "[$特殊字符E]$")
sPEcIAlSTrREpLAcE = a
eND fUNcTIoN
fUNcTIoN uNSpECiALsTRrEPlACe(bYVaL a, b)
a = rEPlACe(a, "[$特殊字符A]$", b & "|")
a = rEPlACe(a, "[$特殊字符B]$", b & "-")
a = rEPlACe(a, "[$特殊字符C]$", b & ",")
a = rEPlACe(a, "[$特殊字符D]$", b & "'")
a = rEPlACe(a, "[$特殊字符E]$", b & """")
uNSpECiALsTRrEPlACe = a
eND fUNcTIoN
fUNcTIoN gETcOLuMNiD(a)
a = rEPlACe(a, "'", "")
gETcOLuMNiD = -1
rSX.oPEn "Select * from " & dB_pREfIX & "webcolumn where columnName='" & a & "'", cONn, 1, 1
iF nOT rSX.eOF tHEn
gETcOLuMNiD = rSX("id")
eND iF : rSX.cLOsE
eND fUNcTIoN
fUNcTIoN gETcOLuMNnAMe(a)
rSX.oPEn "Select * from " & dB_pREfIX & "webcolumn where id=" & a, cONn, 1, 1
iF nOT rSX.eOF tHEn
gETcOLuMNnAMe = rSX("columnName")
eND iF : rSX.cLOsE
eND fUNcTIoN
fUNcTIoN gETcOLuMNuRL(a, b)
dIM c, d
iF b = "name" tHEn
d = " where columnname='" & a & "'"
eLSe
d = " where id=" & a & ""
eND iF
rSX.oPEn "select * from " & dB_pREfIX & "webcolumn" & d, cONn, 1, 1
iF nOT rSX.eOF tHEn
iF iSMaKEhTMl = tRUe tHEn
c = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/nav" & rSX("id"))
eLSe
c = hANdLEwEBuRL("?act=nav&columnName=" & rSX("columnname"))
iF rSX("customAUrl") <> "" tHEn
c = rSX("customAUrl")
eND iF
eND iF
eND iF : rSX.cLOsE
gETcOLuMNuRL = c
eND fUNcTIoN
fUNcTIoN gETcOLuMNtYPe(a)
rSX.oPEn "Select * from " & dB_pREfIX & "webcolumn where id=" & a, cONn, 1, 1
iF nOT rSX.eOF tHEn
gETcOLuMNtYPe = rSX("columnType")
eND iF : rSX.cLOsE
eND fUNcTIoN
fUNcTIoN gETcOLuMNbODyCOnTEnT(a)
rSX.oPEn "Select * from " & dB_pREfIX & "webcolumn where id=" & a, cONn, 1, 1
iF nOT rSX.eOF tHEn
gETcOLuMNbODyCOnTEnT = rSX("bodyContent")
eND iF : rSX.cLOsE
eND fUNcTIoN
fUNcTIoN hANdLEcOLuMNtYPe(a)
dIM b
sELeCT cASe a
cASe "首页" : b = "home"
cASe "文本" : b = "text"
cASe "产品" : b = "product"
cASe "新闻" : b = "news"
cASe "视频" : b = "video"
cASe "下载" : b = "download"
cASe "案例" : b = "case"
cASe "留言" : b = "message"
cASe "反馈" : b = "feedback"
cASe "招聘" : b = "job"
cASe "订单" : b = "order"
eND sELeCT
hANdLEcOLuMNtYPe = b
eND fUNcTIoN
fUNcTIoN dISpLAyEDiTOr(a)
dIM b
b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shCore.js""></script> " & vBCrLF
b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushJScript.js""></script>" & vBCrLF
b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushPhp.js""></script> " & vBCrLF
b = b & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushVb.js""></script> " & vBCrLF
b = b & "<link type=""text/css"" rel=""stylesheet"" href=""\Jquery\syntaxhighlighter\styles/shCore.css""/>" & vBCrLF
b = b & "<link type=""text/css"" rel=""stylesheet"" href=""\Jquery\syntaxhighlighter\styles/shThemeDefault.css""/>" & vBCrLF
b = b & "<script type=""text/javascript"">" & vBCrLF
b = b & "    SyntaxHighlighter.config.clipboardSwf = '\Jquery\syntaxhighlighter\scripts/clipboard.swf';" & vBCrLF
b = b & "    SyntaxHighlighter.all();" & vBCrLF
b = b & "</script>" & vBCrLF
dISpLAyEDiTOr = b
eND fUNcTIoN
fUNcTIoN hANdLEwEBuRL(a)
iF rEQuESt("gl") <> "" tHEn
a = gETuRLaDDtOPaRAm(a, "&gl=" & rEQuESt("gl"), "replace")
eND iF
iF rEQuESt("templatedir") <> "" tHEn
a = gETuRLaDDtOPaRAm(a, "&templatedir=" & rEQuESt("templatedir"), "replace")
eND iF
hANdLEwEBuRL = a
eND fUNcTIoN
fUNcTIoN hANdLEdISpLAyONlINeEDiTDiALoG(a, b, c, d)
dIM e, f, g, h
iF rEQuESt("gl") = "edit" tHEn
iF iNStR(a, "&") > 0 tHEn
a = a & "&vbgl=true"
eND iF
h = fALsE
e = gETcONtROlSTr(a) & """" & c
iF d <> "" tHEn
f = sPLiT(d, "|")
fOR eACh g iN f
iF g <> "" aND iNStR(b, g) > 0 tHEn
b = rEPlACe2(b, g, g & e)
h = tRUe
eXIt fOR
eND iF
nEXt
eND iF
iF h = fALsE tHEn
b = hTMlADdACtIOn(b, e)
eND iF
eND iF
hANdLEdISpLAyONlINeEDiTDiALoG = b
eND fUNcTIoN
fUNcTIoN gETcONtROlSTr(a)
iF rEQuESt("gl") = "edit" tHEn
gETcONtROlSTr = " onMouseMove=""onColor(this,'#FDFAC6','red')"" onMouseOut=""offColor(this,'','')"" onDblClick=""window1('" & a & "','信息修改')"" title='双击在线修改' oncontextmenu=""CommonMenu(event,this,'')"
eND iF
eND fUNcTIoN
fUNcTIoN hTMlADdACtIOn(a, b)
dIM c, d, e, f, g
c = a
c = pHPtRIm(c)
d = mID(c, 1, iNStR(c, " "))
e = ">"
f = tRUe
g = tRIm(lCAsE(rEPlACe(d, "<", "")))
iF iNStR(c, d) = fALsE oR iNStR(c, e) = fALsE oR iNStR("|a|div|span|font|h1|h2|h3|h4|h5|h6|dt|dd|dl|li|ul|table|tr|td|", "|" & g & "|") = fALsE tHEn
f = fALsE
eND iF
iF f = tRUe tHEn
a = d & b & rIGhT(c, lEN(c) - lEN(d))
eND iF
hTMlADdACtIOn = a
eND fUNcTIoN
%>


