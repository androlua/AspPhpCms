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
fUNcTIoN iNFoCOlOR(a, b)
iF b <> "" tHEn a = "<font color=" & b & ">" & a & "</font>"
iNFoCOlOR = a
eND fUNcTIoN
fUNcTIoN iMGeRRoR()
iMGeRRoR = " onerror=""this.src='/UploadFiles/NoImg.jpg'"""
eND fUNcTIoN
fUNcTIoN tARgETsTR(bYVaL a)
iF a <> "" tHEn
tARgETsTR = " target='" & a & "'"
eND iF
eND fUNcTIoN
fUNcTIoN aTArGEt(a)
aTArGEt = tARgETsTR(a)
eND fUNcTIoN
fUNcTIoN aTItLE(bYVaL a)
iF a <> "" tHEn
aTItLE = " Title='" & a & "'"
eND iF
eND fUNcTIoN
fUNcTIoN iMGaLT(bYVaL a)
iF a <> "" tHEn
iMGaLT = " alt='" & a & "'"
eND iF
eND fUNcTIoN
fUNcTIoN iMGtITlEAlT(bYVaL a)
iF a <> "" tHEn
iMGtITlEAlT = " alt='" & a & "' title='" & a & "'"
eND iF
eND fUNcTIoN
fUNcTIoN aREl(bYVaL a)
iF a = tRUe tHEn
aREl = " rel='nofollow'"
eND iF
eND fUNcTIoN
fUNcTIoN sTYlEClASs(bYVaL a)
iF a <> "" tHEn
sTYlEClASs = " class='" & a & "'"
eND iF
eND fUNcTIoN
fUNcTIoN tEXtFOnTB(bYVaL a, b)
iF b = tRUe tHEn
a = "<strong>" & a & "</strong>"
eND iF
tEXtFOnTB = a
eND fUNcTIoN
fUNcTIoN tEXtFOnTCoLOr(bYVaL a, b)
iF b <> "" tHEn
a = "<font color='" & b & "'>" & a & "</font>"
eND iF
tEXtFOnTCoLOr = a
eND fUNcTIoN
fUNcTIoN fONtCOlORfONtB(a, b, c)
fONtCOlORfONtB = tEXtFOnTCoLOr(tEXtFOnTB(a, b), c)
eND fUNcTIoN
fUNcTIoN gETdEFaULtFIlENaME()
gETdEFaULtFIlENaME = fORmAT_TImE(nOW(), 6)
eND fUNcTIoN
fUNcTIoN aHReF(a, b, c)
a = hANdLEhTTpURl(a)
aHReF = "href='" & a & "'" & aTItLE(b) & aTArGEt(c)
eND fUNcTIoN
fUNcTIoN iMGsRC(a, b, c)
a = hANdLEhTTpURl(a)
iMGsRC = "src='" & a & "'" & aTItLE(b) & iMGaLT(b) & aTArGEt(c)
eND fUNcTIoN
fUNcTIoN sELeCTtARgET(a)
dIM b, c
b = b & "<select name=""Target"" id=""Target"">" & vBCrLF
b = b & "  <option value=''>链接打开方式</option>" & vBCrLF
iF a = "" tHEn c = " selected" eLSe c = ""
b = b & "  <option" & c & " value=''>本页打开</option>" & vBCrLF
iF a = "_blank" tHEn c = " selected" eLSe c = ""
b = b & "  <option value=""_blank""" & c & ">新页打开</option>" & vBCrLF
iF a = "Index" tHEn c = " selected" eLSe c = ""
b = b & "  <option value=""Index""" & c & ">Index页打开</option>" & vBCrLF
iF a = "Main" tHEn c = " selected" eLSe c = ""
b = b & "  <option value=""Main""" & c & ">Main页打开</option>" & vBCrLF
b = b & "</select>" & vBCrLF
sELeCTtARgET = b
eND fUNcTIoN
fUNcTIoN sELeCTfONtCOlOR(a)
dIM b, c
b = b & "  <select name=""FontColor"" id=""FontColor"">" & vBCrLF
b = b & "    <option value=''>文本颜色</option>" & vBCrLF
iF a = "Red" tHEn c = " selected" eLSe c = ""
b = b & "    <option value=""Red"" class=""FontColor_Red""" & c & ">红色</option>" & vBCrLF
iF a = "Blue" tHEn c = " selected" eLSe c = ""
b = b & "    <option value=""Blue"" class=""FontColor_Blue""" & c & ">蓝色</option>" & vBCrLF
iF a = "Green" tHEn c = " selected" eLSe c = ""
b = b & "    <option value=""Green"" class=""FontColor_Green""" & c & ">绿色</option>" & vBCrLF
iF a = "Black" tHEn c = " selected" eLSe c = ""
b = b & "    <option value=""Black"" class=""FontColor_Black""" & c & ">黑色</option>" & vBCrLF
iF a = "White" tHEn c = " selected" eLSe c = ""
b = b & "    <option value=""White"" class=""FontColor_White""" & c & ">白色</option>" & vBCrLF
b = b & "  </select>" & vBCrLF
sELeCTfONtCOlOR = b
eND fUNcTIoN
fUNcTIoN sELeCTsEX(a)
dIM b, c
b = b & "  <select name=""FontColor"" id=""FontColor"">" & vBCrLF
b = b & "    <option value=""男"">男</option>" & vBCrLF
c = iIF(a = "女", " selected", "")
b = b & "    <option value=""女""" & c & ">女</option>" & vBCrLF
b = b & "  </select>" & vBCrLF
sELeCTsEX = b
eND fUNcTIoN
fUNcTIoN sELeCTsESsIOnCOoKIeS(a)
dIM b, c
b = b & "  <select name=""VerificationMode"" id=""VerificationMode"">" & vBCrLF
b = b & "    <option value=""1"">Session验证</option>" & vBCrLF
c = iIF(a = "0", " selected", "")
b = b & "    <option value=""0""" & c & ">Cookies验证</option>" & vBCrLF
b = b & "  </select>" & vBCrLF
sELeCTsESsIOnCOoKIeS = b
eND fUNcTIoN
fUNcTIoN sHOwSElECtLIsT(a, b, c, d)
dIM e, f, g, h
a = tRIm(a)
iF c = "" tHEn c = "|_-|"
iF a <> "" tHEn e = e & "  <select name=""" & a & """ id=""" & a & """>" & vBCrLF
g = sPLiT(b, c)
fOR eACh h iN g
f = ""
iF h = d tHEn f = " selected"
e = e & "    <option value=""" & h & """" & f & ">" & h & "</option>" & vBCrLF
nEXt
iF a <> "" tHEn e = e & "  </select>" & vBCrLF
sHOwSElECtLIsT = e
eND fUNcTIoN
fUNcTIoN sHOwARtIClELiSTsTYlE(bYVaL a)
sHOwARtIClELiSTsTYlE = hANdLEaRTiCLeLIsTStYLeORiNFoSTyLE("文章展示样式", "ArticleListStyle", a)
eND fUNcTIoN
fUNcTIoN sHOwARtIClEInFOsTYlE(bYVaL a)
sHOwARtIClEInFOsTYlE = hANdLEaRTiCLeLIsTStYLeORiNFoSTyLE("文章信息展示样式", "ArticleInfoStyle", a)
eND fUNcTIoN
fUNcTIoN hANdLEaRTiCLeLIsTStYLeORiNFoSTyLE(a, b, bYVaL c)
dIM d, e, f, g, h, i
d = gETwEBiMAgES() & "\" & a & "\"
e = gETfILeFOlDErLIsT(d, tRUe, "html", "名称", "", "", "")
c = lCAsE(c)
f = f & "  <select name=""" & b & """ id=""" & b & """>" & vBCrLF
f = f & "    <option value=""""></option>" & vBCrLF
g = sPLiT(e, vBCrLF)
fOR eACh h iN g
iF h <> "" tHEn
i = iIF(lCAsE(h) = c, " selected", "")
f = f & "    <option value=""" & h & """" & i & ">" & h & "</option>" & vBCrLF
eND iF
nEXt
f = f & "  </select>" & vBCrLF
hANdLEaRTiCLeLIsTStYLeORiNFoSTyLE = f
eND fUNcTIoN
fUNcTIoN sHOwWEbMOdULeSKiNS(a, bYVaL b)
dIM c, d, e, f, g, h
c = gETwEBsKInS() & "\Index\column"
d = gETdIRfOLdERnAMeLIsT(c)
b = lCAsE(b)
e = e & "  <select name=""" & a & """ id=""" & a & """>" & vBCrLF
e = e & "    <option value=""""></option>" & vBCrLF
f = sPLiT(d, vBCrLF)
fOR eACh g iN f
iF g <> "" tHEn
h = iIF(lCAsE(g) = b, " selected", "")
e = e & "    <option value=""" & g & """" & h & ">" & g & "</option>" & vBCrLF
eND iF
nEXt
e = e & "  </select>" & vBCrLF
sHOwWEbMOdULeSKiNS = e
eND fUNcTIoN
fUNcTIoN sHOwRAdIOlISt(a, b, c, d)
dIM e, f, g, h, i
a = tRIm(a)
iF c = "" tHEn c = "|_-|"
i = 0
g = sPLiT(b, c)
fOR eACh h iN g
f = "" : i = i + 1
iF h = d tHEn f = " checked"
e = e & "<input type=""radio"" name=""" & a & """ id=""" & a & i & """ value=""radio"" " & f & "><label for=""" & a & i & """>" & h & "</label>" & vBCrLF
nEXt
sHOwRAdIOlISt = e
eND fUNcTIoN
fUNcTIoN iNPuTChECkBOx(a, b, c)
iNPuTChECkBOx=hANdLEiNPuTChECkBOx(a, b, 1, c,"")
eND fUNcTIoN
fUNcTIoN iNPuTChECkBOx3(a, b, c, d)
iNPuTChECkBOx3=hANdLEiNPuTChECkBOx(a, b, c, d,"newidname")
eND fUNcTIoN
fUNcTIoN hANdLEiNPuTChECkBOx(a, b, c, d,e)
dIM f,g,h
iF cSTr(c) = "True" oR cSTr(b) = "1" tHEn g = " checked" eLSe g = ""
h=a	
e="|"& e &"|"
iF iNStR(e,"|newidname|")>0 tHEn
h = a & pHPrANd(1, 9999)
eND iF
f="<input type='checkbox' name='" & a & "' id='" & h & "'" & g & " value='" & c & "'>"
iF d <> "" tHEn f = "<label for='" & h & "'>" & f & d & "</label> "
hANdLEiNPuTChECkBOx=f
eND fUNcTIoN
fUNcTIoN iNPuTTeXT(a, b, c, d)
dIM e
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
e = " style='width:" & c & ";'"
eND iF
iNPuTTeXT = "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & e & " />" & d
eND fUNcTIoN
fUNcTIoN iNPuTTeXT2(a, b, c, d, e)
dIM f
iF d <> "" tHEn
d = " class=""" & d & """"
eND iF
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
f = " style='width:" & c & ";'"
eND iF
iNPuTTeXT2 = "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & f & d & " />" & e
eND fUNcTIoN
fUNcTIoN iNPuTLeFTtEXt(a, b, c, d)
dIM e
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
e = " style='width:" & c & ";'"
eND iF
iNPuTLeFTtEXt = d & "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & e & " />" & vBCrLF
eND fUNcTIoN
fUNcTIoN iNPuTLeFTtEXtHElPTeXTrIGhT(a, b, c, d)
dIM e
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
e = " style='width:" & c & ";'"
eND iF
iNPuTLeFTtEXtHElPTeXTrIGhT = "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & e & " />" & d
eND fUNcTIoN
fUNcTIoN iNPuTLeFTtEXtCOnTEnT(a, b, c, d)
iNPuTLeFTtEXtCOnTEnT = hANdLEiNPuTLeFTrIGhTTeXTcONtENt("左边", a, b, c, d)
eND fUNcTIoN
fUNcTIoN iNPuTRiGHtTExTCoNTeNT(a, b, c, d)
iNPuTRiGHtTExTCoNTeNT = hANdLEiNPuTLeFTrIGhTTeXTcONtENt("右边", a, b, c, d)
eND fUNcTIoN
fUNcTIoN hANdLEiNPuTLeFTrIGhTTeXTcONtENt(a, b, c, d, e)
dIM f
d = tRIm(lCAsE(d))
iF d <> "" tHEn
iF rIGhT(d, 1) <> "%" aND rIGhT(d, 2) <> "px" tHEn
d = d & "px"
eND iF
f = " style='width:" & d & ";'"
eND iF
iF f = "" tHEn
f = " style='text-align:center;'"
eLSe
f = rEPlACe(f, ";'", ";text-align:center;'")
eND iF
hANdLEiNPuTLeFTrIGhTTeXTcONtENt = "<input name=""" & b & """ type=""text"" id=""" & b & """ value=""" & c & """" & f & " />"
iF a = "左边" tHEn
hANdLEiNPuTLeFTrIGhTTeXTcONtENt = e & hANdLEiNPuTLeFTrIGhTTeXTcONtENt & vBCrLF
eLSe
hANdLEiNPuTLeFTrIGhTTeXTcONtENt = hANdLEiNPuTLeFTrIGhTTeXTcONtENt & e
eND iF
eND fUNcTIoN
fUNcTIoN iNPuTLeFTpASsTExT(a, b, c, d)
dIM e
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
e = " style='width:" & c & ";'"
eND iF
iNPuTLeFTpASsTExT = d & "<input name=""" & a & """ type=""password"" id=""" & a & """ value=""" & b & """" & e & " />" & vBCrLF
eND fUNcTIoN
fUNcTIoN iNPuTLeFTpASsTExTCoNTeNT(a, b, c, d)
dIM e
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
e = " style='width:" & c & ";'"
eND iF
iF e = "" tHEn
e = " style='text-align:center;'"
eLSe
e = rEPlACe(e, ";'", ";text-align:center;'")
eND iF
iNPuTLeFTpASsTExTCoNTeNT = d & "<input name=""" & a & """ type=""password"" id=""" & a & """ value=""" & b & """" & e & " />" & vBCrLF
eND fUNcTIoN
fUNcTIoN iNPuTHiDDeNTeXT(a, b)
iNPuTHiDDeNTeXT = "<input name=""" & a & """ type=""hidden"" id=""" & a & """ value=""" & b & """ />" & vBCrLF
eND fUNcTIoN
fUNcTIoN iNPuTTeXTaREa(a, b, c, d, e)
dIM f, g
c = tRIm(lCAsE(c))
iF c <> "" tHEn
iF rIGhT(c, 1) <> "%" aND rIGhT(c, 2) <> "px" tHEn
c = c & "px"
eND iF
f = " style='width:" & c & ";'"
eND iF
iF d <> "" tHEn
iF cHEcKNuMBeR(d) tHEn
d = d & "px"
eND iF
g = "height:" & d & ";"
iF f <> "" tHEn
f = rEPlACe(f, ";'", ";" & g & ";'")
eLSe
f = " style='height:" & d & ";'"
eND iF
eND iF
f = rEPlACe(f, ";;", ";")
iNPuTTeXTaREa = "<textarea name=""" & a & """ type=""text"" id=""" & a & """" & f & ">" & b & "</textarea>" & e
eND fUNcTIoN
fUNcTIoN iNPuTHiDDeNTeXTaREa(a, b, c, d, e)
iNPuTHiDDeNTeXTaREa = hANdLEiNPuTHiDDeNTeXTaREa(a, b, c, d, "", e)
eND fUNcTIoN
fUNcTIoN hANdLEiNPuTHiDDeNTeXTaREa(a, b, c, d, e, f)
dIM g, h
iF e <> "" tHEn
e = " class=""" & e & """"
eND iF
iF c <> "" tHEn g = " style='width:" & c & ";'"
iF d <> "" tHEn
h = "height:" & d & ";"
iF g <> "" tHEn
g = rEPlACe(g, ";'", ";" & h & ";'")
eLSe
g = " style='height:" & d & ";display:none;'"
eND iF
eND iF
hANdLEiNPuTHiDDeNTeXTaREa = "<textarea name=""" & a & """ type=""text"" id=""" & a & """" & g & e & ">" & b & "</textarea>" & f
eND fUNcTIoN
fUNcTIoN sHOwSElECtDIrLIsT(a, b)
dIM c, d, e, f
c = sPLiT(gETdIRfILeSOrT(a), vBCrLF)
fOR eACh e iN c
iF e <> "" tHEn
f = iIF(b = e, " selected", "")
d = d & "<option value=""" & a & e & """ " & f & ">" & e & "</option>" & vBCrLF
eND iF
nEXt
sHOwSElECtDIrLIsT = d
eND fUNcTIoN
fUNcTIoN iNPuTDiSAbLEd(bYVaL a)
iNPuTDiSAbLEd = rEPlACe(a, "<input ", "<input disabled=""disabled"" ")
eND fUNcTIoN
fUNcTIoN iNPuTAdDAlT(bYVaL a, b)
dIM c, d
c = "<input "
d = c & "alt=""" & b & """ "
iF iNStR(a, c) > 0 tHEn
a = rEPlACe(a, c, d)
eLSe
c = "<textarea "
d = c & "alt=""" & b & """ "
iF iNStR(a, c) > 0 tHEn
a = rEPlACe(a, c, d)
eND iF
eND iF
iNPuTAdDAlT = a
eND fUNcTIoN
fUNcTIoN wEBtITlE_iNPuTTeXTaREa(a)
wEBtITlE_iNPuTTeXTaREa = iNPuTTeXT("WebTitle", a, "70%", "  多个关键词用-隔开")
eND fUNcTIoN
fUNcTIoN wEBkEYwORdS_iNPuTTeXT(a)
wEBkEYwORdS_iNPuTTeXT = iNPuTTeXT("WebKeywords", a, "70%", " 请以，隔开(中文逗号)")
eND fUNcTIoN
fUNcTIoN wEBdEScRIpTIoN_iNPuTTeXTaREa(a)
wEBdEScRIpTIoN_iNPuTTeXTaREa = iNPuTTeXTaREa("WebDescription", a, "99%", "100px", "")
eND fUNcTIoN
fUNcTIoN fOLdERnAMe_InPUtTExT(a)
fOLdERnAMe_InPUtTExT = iNPuTTeXT("FolderName", a, "40%", "")
eND fUNcTIoN
fUNcTIoN fILeNAmE_iNPuTTeXT(a)
fILeNAmE_iNPuTTeXT = iNPuTTeXT("FileName", a, "40%", ".html 也可以是网络上的链接地址")
eND fUNcTIoN
fUNcTIoN tEMpLAtEPaTH_INpUTtEXt(a)
tEMpLAtEPaTH_INpUTtEXt = iNPuTTeXT("TemplatePath", a, "40%", " 不填为默认")
eND fUNcTIoN
fUNcTIoN cLIcKPiNYiNHtMLsTR(a)
cLIcKPiNYiNHtMLsTR = "<a href=""javascript:GetPinYin('FolderName','" & a & "','AjAx.Asp?act=GetPinYin')"" >获得拼音</a>"
eND fUNcTIoN
fUNcTIoN sHOwFOnTCoLOrFOnTB(a, b)
sHOwFOnTCoLOrFOnTB = sELeCTfONtCOlOR(a) & iNPuTChECkBOx("FontB", b, "加粗")
eND fUNcTIoN
fUNcTIoN sHOwSOrT(a)
sHOwSOrT = iNPuTTeXT("Sort", a, "30px", "")
sHOwSOrT = rEPlACe(sHOwSOrT, ";'", ";text-align:center;'")
eND fUNcTIoN
fUNcTIoN sHOwWEbNAvTYpE(a, b, c, d, e, f)
dIM g
g = g & iNPuTChECkBOx("NavTop", a, "顶部导航")
g = g & iNPuTChECkBOx("NavButtom", b, "底部导航")
g = g & iNPuTChECkBOx("NavLeft", c, "左边导航")
g = g & iNPuTChECkBOx("NavContent", d, "中间导航")
g = g & iNPuTChECkBOx("NavRight", e, "右边导航")
g = g & iNPuTChECkBOx("NavOthre", f, "其它导航")
sHOwWEbNAvTYpE = g
eND fUNcTIoN
fUNcTIoN sHOwONhTMl(a)
sHOwONhTMl = iNPuTChECkBOx("OnHtml", a, "生成HTML")
eND fUNcTIoN
fUNcTIoN sHOwTHrOUgH(a)
sHOwTHrOUgH = iNPuTChECkBOx("Through", a, "审核")
eND fUNcTIoN
fUNcTIoN sHOwREcOMmENd(a)
sHOwREcOMmENd = iNPuTChECkBOx("Recommend", a, "推荐")
eND fUNcTIoN
fUNcTIoN sHOwONoFFiMG(a, b, c, d, e)
dIM f, g, h
iF rQ("page") <> "" tHEn f = "&page=" & rQ("page") eLSe f = ""
iF d = tRUe tHEn
g = "<img src=""/Admin/Images/yes.gif"">"
eLSe
g = "<img src=""/Admin/Images/webno.gif"">"
eND iF
h = gETuRLaDDtOPaRAm(gETuRL(), "/Admin/HandleDatabase.Asp?act=SetTrueFalse&Table=" & b & "&FieldName=" & c & "&Url=" & e & "&Id=" & a, "replace")
sHOwONoFFiMG = "<a href=""" & h & """>" & g & "</a>"
eND fUNcTIoN
fUNcTIoN nEWsHOwONoFFiMG(a, b, c, d, e)
dIM f, g
iF rQ("page") <> "" tHEn f = "&page=" & rQ("page") eLSe f = ""
iF d = 1 tHEn
g = "<img src=""/Images/yes.gif"">"
eLSe
g = "<img src=""/Images/webno.gif"">"
eND iF
nEWsHOwONoFFiMG = "<a href=/WebAdmin/ZAction.Asp?act=Through&Table=" & b & "&FieldName=" & c & "&Url=" & e & "&Id=" & a & f & ">" & g & "</a>"
eND fUNcTIoN
fUNcTIoN cONtROlDIaLOgCSs()
dIM b
b = "<style>" & vBCrLF
b = b & "/*控制Css20150128*/" & vBCrLF
b = b & ".controlDialog{" & vBCrLF
b = b & "    position:relative;" & vBCrLF
b = b & "    height:50px;" & vBCrLF
b = b & "    width:auto;" & vBCrLF
b = b & "}" & vBCrLF
b = b & ".controlDialog .menu{" & vBCrLF
b = b & "    position:absolute;" & vBCrLF
b = b & "    right:0px;" & vBCrLF
b = b & "    top:0px;" & vBCrLF
b = b & "}" & vBCrLF
b = b & ".controlDialog .menu a{" & vBCrLF
b = b & "    color:#FF0000;" & vBCrLF
b = b & "    font-size:14px;" & vBCrLF
b = b & "    text-decoration:none;" & vBCrLF
b = b & "    background-color:#FFFFFF;" & vBCrLF
b = b & "    border:1px solid #003300;" & vBCrLF
b = b & "    padding:4px;" & vBCrLF
b = b & "}" & vBCrLF
b = b & ".controlDialog .menu a:hover{" & vBCrLF
b = b & "    color:#C60000;" & vBCrLF
b = b & "    text-decoration:underline;" & vBCrLF
b = b & "}" & vBCrLF
b = b & "</style>" & vBCrLF
cONtROlDIaLOgCSs = b
eND fUNcTIoN
fUNcTIoN bATcHDeLEtETeMPsTR(a,b,c)
dIM d,e
fOR d = 1 tO 9
iF iNStR(a,b)=fALsE tHEn
eXIt fOR
eND iF
e=gETsTRcUT(a,b,c,1)
a=rEPlACe(a,e,"")	
nEXt
bATcHDeLEtETeMPsTR=a
eND fUNcTIoN
%>

