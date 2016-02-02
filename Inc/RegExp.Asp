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
fUNcTIoN cHEcKStR(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
dIM c, d
cHEcKStR = tRUe
sET c = cREaTEoBJeCT("VBscript.RegExp")
c.gLObAL = tRUe
c.iGNoREcASe = tRUe
c.pATtERn = b
sET d = c.eXEcUTe(a)
iF d.cOUnT = 0 tHEn cHEcKStR = fALsE
sET d = nOThINg
sET c = nOThINg
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "CheckStr 检查字符是否存在 函数出错，SerchValue=" & b)
eND fUNcTIoN
fUNcTIoN rEGeXP_CHeCKsTR(a, b)
rEGeXP_CHeCKsTR = cHEcKStR(a, b)
eND fUNcTIoN
fUNcTIoN eXIsTSsTR(a, b)
eXIsTSsTR = cHEcKStR(a, b)
eND fUNcTIoN
fUNcTIoN rEGeXP_INsTR(a, b)
rEGeXP_INsTR = cHEcKStR(a, b)
eND fUNcTIoN
fUNcTIoN rEGeXP_REpLAcE(bYVaL a, bYVaL b, bYVaL c)
oN eRRoR rESuME nEXt
dIM d
sET d = cREaTEoBJeCT("VBscript.RegExp")
d.pATtERn = b
d.iGNoREcASe = tRUe
d.gLObAL = tRUe
rEGeXP_REpLAcE = d.rEPlACe(a, c)
sET d = nOThINg
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "RegExp_Replace 替换内容 函数出错，SetPattern=" & b & " |Str=" & c)
eND fUNcTIoN
fUNcTIoN rEPlACeCOlOR(a, b, c, d)
iF d <> "" tHEn c = "<font color=" & d & ">" & c & "</font>"
rEPlACeCOlOR = rEGeXP_REpLAcE(a, b, c)
eND fUNcTIoN
fUNcTIoN dELhTMl(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.iGNoREcASe = tRUe
b.gLObAL = tRUe
b.pATtERn = "(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)"
c = b.rEPlACe(a, "")
dELhTMl = c
sET b = nOThINg
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "DelHtml 删除HTML标签 函数出错，")
eND fUNcTIoN
fUNcTIoN rEGeXP_DElHTmL(a)
rEGeXP_DElHTmL = dELhTMl(a)
eND fUNcTIoN
fUNcTIoN gETaURlTItLElISt(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
dIM c, d, e, f, g
d = ""
sET g = cREaTEoBJeCT("VBscript.RegExp")
g.iGNoREcASe = tRUe
g.gLObAL = tRUe
g.pATtERn = "<a [^>]*href *= *[""']([^""'> ]+)[^>]*>([^<]+)"
sET e = g.eXEcUTe(a)
fOR eACh f iN e
iF b = "链接" oR b = "网址" oR b = "0" tHEn
c = f.sUBmATcHEs(0)
eLSeIF b = "标题" oR b = "1" tHEn
c = f.sUBmATcHEs(1)
eLSe
c = f.sUBmATcHEs(0) & "$Array$" & f.sUBmATcHEs(1)
eND iF
iF iNStR(vBCrLF & d & vBCrLF, vBCrLF & c & vBCrLF) = fALsE tHEn
d = d & c & vBCrLF
eND iF
nEXt
sET e = nOThINg
sET g = nOThINg
iF d <> "" tHEn d = lEFt(d, lEN(d) - 2)
gETaURlTItLElISt = d
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetHrefUrlTitleList 获得内容中链接与标题列表 函数出错，C=" & d)
eND fUNcTIoN
fUNcTIoN gETaURl(a)
gETaURl = gETaURlTItLElISt(a, 0)
eND fUNcTIoN
fUNcTIoN gETaTItLE(a)
gETaTItLE = gETaURlTItLElISt(a, 1)
eND fUNcTIoN
fUNcTIoN gETaURlTItLE(a)
gETaURlTItLE = gETaURlTItLElISt(a, "链接和标题")
eND fUNcTIoN
fUNcTIoN gETcONtENtAUrLLiST(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c, d, e, f
c = ""
sET f = cREaTEoBJeCT("VBscript.RegExp")
f.iGNoREcASe = tRUe
f.gLObAL = tRUe
f.pATtERn = "<a [^>]*href *= *[""']([^""'> ]+)[^>]*>"
sET d = f.eXEcUTe(a)
fOR eACh e iN d
b = e.sUBmATcHEs(0)
iF iNStR(vBCrLF & c & vBCrLF, vBCrLF & b & vBCrLF) = fALsE tHEn
c = c & b & vBCrLF
eND iF
nEXt
sET d = nOThINg
sET f = nOThINg
iF c <> "" tHEn c = lEFt(c, lEN(c) - 2)
gETcONtENtAUrLLiST = c
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetHrefUrlTitleList 获得内容中链接与标题列表 函数出错，C=" & c)
eND fUNcTIoN
fUNcTIoN rEGeXP_GEtIMgURlLIsT(bYVaL a, bYVaL b)
oN eRRoR rESuME nEXt
dIM c, d, e, f, g, h
h = ""
b = lCAsE(b)
sET e = cREaTEoBJeCT("VBscript.RegExp")
e.iGNoREcASe = tRUe
e.gLObAL = tRUe
e.pATtERn = "<img *src *= *[""|'| ]*([^""'> ]+)"
sET c = e.eXEcUTe(a)
fOR eACh d iN c
g = d.sUBmATcHEs(0)
f = rIGhT(g, lEN(g) - iNStRReV(g, "."))
iF b = f oR b = "全部" oR b = "" tHEn
iF iNStR(vBCrLF & h & vBCrLF, vBCrLF & g & vBCrLF) = fALsE tHEn
h = h & g & vBCrLF
eND iF
eND iF
nEXt
sET c = nOThINg
sET e = nOThINg
iF h <> "" tHEn h = lEFt(h, lEN(h) - 2)
rEGeXP_GEtIMgURlLIsT = h
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetIMGUrlList 获得图片中网址 函数出错，c=" & h)
eND fUNcTIoN
fUNcTIoN gETiMG(a)
gETiMG = rEGeXP_GEtIMgURlLIsT(a, "全部")
eND fUNcTIoN
fUNcTIoN gETiMGjPG(a)
gETiMGjPG = rEGeXP_GEtIMgURlLIsT(a, "JPG")
eND fUNcTIoN
fUNcTIoN gETiMGgIF(a)
gETiMGgIF = rEGeXP_GEtIMgURlLIsT(a, "GIF")
eND fUNcTIoN
fUNcTIoN gETiMGbMP(a)
gETiMGbMP = rEGeXP_GEtIMgURlLIsT(a, "Bmp")
eND fUNcTIoN
fUNcTIoN gETaSPfUNcTIoNLiST(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c, d, e, f, g
g = ""
sET d = cREaTEoBJeCT("VBscript.RegExp")
d.iGNoREcASe = tRUe
d.gLObAL = tRUe
d.pATtERn = "(sub|function) .*?\)"
sET b = d.eXEcUTe(a)
fOR eACh c iN b
g = g & c & vBCrLF
nEXt
sET b = nOThINg
sET d = nOThINg
iF g <> "" tHEn g = lEFt(g, lEN(g) - 2)
gETaSPfUNcTIoNLiST = g
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetASPFunctionList 获得ASP函数列表 函数出错，c=" & g)
eND fUNcTIoN
fUNcTIoN gETaSPdIMfUNcTIoN(bYVaL a, b, c, d)
a = rEPlACe(a, "()", "( )")
dIM e, f, g
sET g = cREaTEoBJeCT("VBscript.RegExp")
g.iGNoREcASe = tRUe
g.gLObAL = tRUe
a = rEGeXP_REpLAcE(a, "ByVal ", "")
g.pATtERn = "(sub|function) *([^\(]+) *\(([^\)]+)\)"
sET e = g.eXEcUTe(a)
fOR eACh f iN e
iF iNStR(b, "{") = fALsE tHEn
b = b & tRIm(f) & vBCrLF
c = c & tRIm(f.sUBmATcHEs(1)) & vBCrLF
d = d & rEPlACe(f.sUBmATcHEs(2), " ", "") & vBCrLF
eND iF
nEXt
sET e = nOThINg
sET g = nOThINg
gETaSPdIMfUNcTIoN = b
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetASPFunctionList 获得ASP函数列表 函数出错，")
eND fUNcTIoN
fUNcTIoN sTRlENgTH(a)
dIM b, c, d
c = 0
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.gLObAL = tRUe
b.iGNoREcASe = tRUe
b.pATtERn = "[\u4E00-\u9FA5\uF900-\uFA2D]"
fOR eACh d iN b.eXEcUTe(a)
c = c + 1
nEXt
sET b = nOThINg
c = c + lEN(a)
sTRlENgTH = c
eND fUNcTIoN
fUNcTIoN rEGeXPgETlENgHT(a)
rEGeXPgETlENgHT = sTRlENgTH(a)
eND fUNcTIoN
fUNcTIoN sTRiNGlENgTH(a)
sTRiNGlENgTH = sTRlENgTH(a)
eND fUNcTIoN
fUNcTIoN gETcSShREf(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c, d, e, f, g
sET d = cREaTEoBJeCT("VBscript.RegExp")
d.iGNoREcASe = tRUe
d.gLObAL = tRUe
d.pATtERn = "<link .*?href *= *[""|'| ]*([^""'>]+)"
sET b = d.eXEcUTe(a)
fOR eACh c iN b
iF iNStR(lCAsE(c), "stylesheet") > 0 tHEn
f = c.sUBmATcHEs(0)
g = g & f & vBCrLF
eND iF
nEXt
sET b = nOThINg
sET d = nOThINg
iF g <> "" tHEn g = lEFt(g, lEN(g) - 2)
gETcSShREf = g
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetCssHref 获得HTML中Css 函数出错，C =" & g)
eND fUNcTIoN
fUNcTIoN gETjSSrC(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c, d, e, f, g
sET d = cREaTEoBJeCT("VBscript.RegExp")
d.iGNoREcASe = tRUe
d.gLObAL = tRUe
d.pATtERn = "<script .*?src *= *[""|'| ]*([^""'>]+)"
sET b = d.eXEcUTe(a)
fOR eACh c iN b
f = c.sUBmATcHEs(0)
g = g & f & vBCrLF
nEXt
sET b = nOThINg
sET d = nOThINg
iF g <> "" tHEn g = lEFt(g, lEN(g) - 2)
gETjSSrC = g
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetJsSrc 获得HTML中Js 函数出错，C =" & g)
eND fUNcTIoN
fUNcTIoN dELhTMlSCrIPt(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.iGNoREcASe = tRUe
b.gLObAL = tRUe
b.pATtERn = "<script.*</script>"
c = b.rEPlACe(a, "")
dELhTMlSCrIPt = c
sET b = nOThINg
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "删除HTML中<scirpt 函数出错，")
eND fUNcTIoN
fUNcTIoN gETmETa(bYVaL a, b, c)
oN eRRoR rESuME nEXt
dIM d, e, f, g, h, i
i = ""
b = lCAsE(b)
c = 0
sET f = cREaTEoBJeCT("VBscript.RegExp")
f.iGNoREcASe = tRUe
f.gLObAL = tRUe
f.pATtERn = "<meta .*?content *= *[""|'| ]*([^""'>]+)"
sET d = f.eXEcUTe(a)
fOR eACh e iN d
iF iNStR(lCAsE(e), b) > 0 tHEn
h = e.sUBmATcHEs(0)
i = i & h & vBCrLF
c = c + 1
eND iF
nEXt
sET d = nOThINg
sET f = nOThINg
iF i <> "" tHEn i = lEFt(i, lEN(i) - 2)
gETmETa = i
iF eRR tHEn cALl dOErROr(eRR.dEScRIpTIoN, "GetKeyWords 获得HTML中keywords 函数出错，C =" & i)
eND fUNcTIoN
fUNcTIoN dELhTMlNOtE(a)
dIM b, c
b = cSTr(a)
sET c = cREaTEoBJeCT("VBscript.RegExp")
c.pATtERn = "<!--\/*[^<>]*-->"
c.iGNoREcASe = tRUe
c.gLObAL = tRUe
b = c.rEPlACe(b, "")
dELhTMlNOtE = b
sET c = nOThINg
eND fUNcTIoN
fUNcTIoN dELhTMlMYnOTe(a)
dIM b, c
b = cSTr(a)
sET c = cREaTEoBJeCT("VBscript.RegExp")
c.pATtERn = "<!--#\/*[^<>]*#-->"
c.iGNoREcASe = tRUe
c.gLObAL = tRUe
b = c.rEPlACe(b, "")
dELhTMlMYnOTe = b
sET c = nOThINg
eND fUNcTIoN
fUNcTIoN gETsTRiMGlISt(bYVaL a)
a = rEPlACe(a, "'", """")
dIM b, c, d, e, f
b = "" : c = ""
sET f = cREaTEoBJeCT("VBscript.RegExp")
f.iGNoREcASe = tRUe
f.gLObAL = tRUe
f.pATtERn = "<img [^>]*src=""([^"">]+)[^>]+>"
sET d = f.eXEcUTe(a)
fOR eACh e iN d
b = b & e & "|"
c = c & e.sUBmATcHEs(0) & "|"
nEXt
sET d = nOThINg
sET f = nOThINg
iF b <> "" tHEn
b = lEFt(b, lEN(b) - 1)
c = lEFt(c, lEN(c) - 1)
eND iF
gETsTRiMGlISt = c
eND fUNcTIoN
fUNcTIoN gETeMAiLLiST(a)
dIM b, c, d, e
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.pATtERn = "\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
b.iGNoREcASe = tRUe
b.gLObAL = tRUe
e = ""
sET d = b.eXEcUTe(a)
fOR eACh c iN d
iF iNStR("," & e & ",", "," & c.vALuE & ",") = 0 tHEn
e = e & c.vALuE & ","
eND iF
nEXt
sET d = nOThINg
sET b = nOThINg
iF e <> "" tHEn e = lEFt(e, lEN(e) - 1)
gETeMAiLLiST = e
eND fUNcTIoN
fUNcTIoN oFLiNK_LCaSEtAG(a)
dIM b, c, d
sET b = cREaTEoBJeCT("VBscript.RegExp")
b.pATtERn = "<.+?\>"
b.iGNoREcASe = tRUe
b.gLObAL = tRUe
sET d = b.eXEcUTe(a)
a = a
fOR eACh c iN d
a = rEPlACe(a, c.vALuE, lCAsE(c.vALuE))
nEXt
oFLiNK_LCaSEtAG = a
sET d = nOThINg
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN sCRiPThTMl(bYVaL a, b, c)
dIM d
sET d = cREaTEoBJeCT("VBscript.RegExp")
d.iGNoREcASe = tRUe
d.gLObAL = tRUe
sELeCT cASe c
cASe 1
d.pATtERn = "<" & b & "([^>])*>"
a = d.rEPlACe(a, "")
cASe 2
d.pATtERn = "<" & b & "([^>])*>.*?</" & b & "([^>])*>"
a = d.rEPlACe(a, "")
cASe 3
d.pATtERn = "<" & b & "([^>])*>"
a = d.rEPlACe(a, "")
d.pATtERn = "</" & b & "([^>])*>"
a = d.rEPlACe(a, "")
eND sELeCT
sCRiPThTMl = a
sET d = nOThINg
eND fUNcTIoN
fUNcTIoN gETrEGeXP(a, b, c, d, e)
dIM f, g, h, i, j, k
i = ""
iF c <> "" tHEn c = cINt(c)
iF d <> "" tHEn d = cINt(d)
iF e <> "" tHEn e = cINt(e)
j = fALsE
iF c <> "" oR d <> "" oR e <> "" tHEn j = tRUe
sET f = cREaTEoBJeCT("VBscript.RegExp")
f.pATtERn = a
f.iGNoREcASe = tRUe
f.gLObAL = tRUe
sET h = f.eXEcUTe(b)
fOR eACh g iN h
iF j = tRUe tHEn
k = ""
iF c <> "" tHEn
k = k & g.sUBmATcHEs(c)
eND iF
iF d <> "" tHEn
iF k <> "" tHEn k = k & "[$Split$]"
k = k & g.sUBmATcHEs(d)
eND iF
iF e <> "" tHEn
iF k <> "" tHEn k = k & "[$Split$]"
k = k & g.sUBmATcHEs(e)
eND iF
iF k <> "" tHEn i = i & k & "[$Array$]"
eLSe
i = i & g & "[$Array$]"
eND iF
nEXt
iF i <> "" tHEn i = lEFt(i, lEN(i) - 9)
gETrEGeXP = i
eND fUNcTIoN
fUNcTIoN gETiMGjSUrL(a, b)
dIM c, d, e, f, g
b = lCAsE(b)
d = rEGeXPgETsTR("<[img|script][^<>]*src[^<>]*[\/]?>", a, 2)
e = sPLiT(d, "[$Array$]")
g = ""
fOR eACh c iN e
f = rEGeXPgETsTR("src=[""|']?([^""' ]*)([""|']?).*[\/]?>", c, 1)
iF b = "1" oR b = "不重复" tHEn
iF iNStR(vBCrLF & g & vBCrLF, vBCrLF & f & vBCrLF) tHEn
f = ""
eND iF
eND iF
iF f <> "" tHEn
g = g & f & vBCrLF
eND iF
nEXt
iF g <> "" tHEn g = lEFt(g, lEN(g) - 2)
gETiMGjSUrL = g
eND fUNcTIoN
fUNcTIoN rEGeXPgETsTR(a, b, c)
dIM d, e, f, g
g = ""
rEGeXPgETsTR = ""
sET d = cREaTEoBJeCT("VBscript.RegExp")
d.iGNoREcASe = tRUe
d.gLObAL = tRUe
d.pATtERn = a
sET f = d.eXEcUTe(b)
fOR eACh e iN f
iF c = 1 tHEn
e = d.rEPlACe(e, "$1")
eLSeIF c = 2 tHEn
g = g & e & "[$Array$]"
eND iF
rEGeXPgETsTR = e
nEXt
sET f = nOThINg
sET d = nOThINg
iF c = 2 tHEn
iF g <> "" tHEn g = lEFt(g, lEN(g) - 9)
rEGeXPgETsTR = g
eND iF
eND fUNcTIoN
fUNcTIoN nEWgETpINgIP(a)
dIM b, c, d
dIM e, f, g, h
nEWgETpINgIP = ""
b = "/备份/cmd.exe"
c = gETpINgINfO(b, a)
d = sPLiT(c, "Request timed out.")
iF uBOuND(d) >= 4 tHEn
f = tRIm(rEPlACe(rEPlACe(rEPlACe(a, "http://", ""), "www.", ""), "/", ""))
e = "http://whois.www.net.cn/whois/api_webinfo?host=" & f & "&_=" & gETrND(9)
c = gEThTTpPAgE(e, "utf-8")
g = """ip"":""" : h = """"
iF iNStR(c, g) > 0 aND iNStR(c, h) > 0 tHEn
nEWgETpINgIP = sTRcUT(c, g, h, 2)
eND iF
eLSe
g = " [" : h = "]"
iF iNStR(c, g) > 0 aND iNStR(c, h) > 0 tHEn
nEWgETpINgIP = sTRcUT(c, g, h, 2)
eLSe
nEWgETpINgIP = "NO"
eND iF
eND iF
eND fUNcTIoN
fUNcTIoN gETpINgIP(a, b)
dIM c, d, e
d = " [" : e = "]"
c = gETpINgINfO(a, b)
iF iNStR(c, d) > 0 aND iNStR(c, e) > 0 tHEn
gETpINgIP = sTRcUT(c, d, e, 2)
eLSe
gETpINgIP = "NO"
eND iF
eND fUNcTIoN
fUNcTIoN gETpINgINfO(a, b)
dIM c, d
sET c = cREaTEoBJeCT("WScript.Shell")
cALl hANdLEpATh(a)
sET d = c.eXEc(a & " /c ping " & b)
gETpINgINfO = d.sTDoUT.rEAdALl
eND fUNcTIoN
fUNcTIoN rEGeXPtESt(a, b)
dIM c
sET c = cREaTEoBJeCT("VBscript.RegExp")
c.iGNoREcASe = tRUe
c.gLObAL = tRUe
c.pATtERn = b
rEGeXPtESt = c.tESt(a)
sET c = nOThINg
eND fUNcTIoN
fUNcTIoN gETrEGeXPsTR(bYVaL a, bYVaL b, bYVaL c)
oN eRRoR rESuME nEXt
dIM d, e, f, g, h, i
e = ""
sET h = cREaTEoBJeCT("VBscript.RegExp")
h.iGNoREcASe = tRUe
h.gLObAL = tRUe
h.pATtERn = b
sET f = h.eXEcUTe(a)
fOR eACh g iN f
i = rEPlACe(c, "\S1\", g.sUBmATcHEs(0))
i = rEPlACe(i, "\S2\", g.sUBmATcHEs(1))
i = rEPlACe(i, "\S3\", g.sUBmATcHEs(2))
i = rEPlACe(i, "\S4\", g.sUBmATcHEs(3))
i = rEPlACe(i, "\S5\", g.sUBmATcHEs(4))
a = rEPlACe(a, g, i)
nEXt
sET f = nOThINg
sET h = nOThINg
gETrEGeXPsTR = a
eND fUNcTIoN
fUNcTIoN rEGeXPrEPlACeCSsDIr(bYVaL a, b)
dIM c, d, e, f
dIM g, h
sET e = cREaTEoBJeCT("VBscript.RegExp")
e.iGNoREcASe = tRUe
e.gLObAL = tRUe
e.pATtERn = "<link .*?href *= *[""|'| ]*([^""'>]+)"
sET c = e.eXEcUTe(a)
fOR eACh d iN c
iF iNStR(lCAsE(d), "stylesheet") > 0 tHEn
g = d.sUBmATcHEs(0)
h = gETsTRfILeNAmE(g)
f = rEPlACe(d, g, b & h)
a = rEPlACe(a, d, f)
eND iF
nEXt
sET c = nOThINg
sET e = nOThINg
rEGeXPrEPlACeCSsDIr = a
eND fUNcTIoN
fUNcTIoN dELeTEnULlROw(bYVaL a)
dELeTEnULlROw = rEGeXP_REpLAcE(a, "\r\n\s*\r\n", "")
eND fUNcTIoN
%>

