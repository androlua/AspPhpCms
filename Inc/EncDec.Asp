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
fUNcTIoN sPEcIAlHTmLUpLOaDEnCRyPTiONdECrYPt(a, b)
dIM c, d, e, f
e = "·|[*-24156*]" & vBCrLF
c = sPLiT(e, vBCrLF)
fOR eACh f iN c
iF iNStR(f, "|") > 0 tHEn
d = sPLiT(f, "|")
iF b = "1" oR b = "解密" oR b = "Decrypt" tHEn
a = rEPlACe(a, d(1), d(0))
eLSe
a = rEPlACe(a, d(0), d(1))
eND iF
eND iF
nEXt
sPEcIAlHTmLUpLOaDEnCRyPTiONdECrYPt = a
eND fUNcTIoN
fUNcTIoN eNCaSPcONtENt(bYVaL a)
dIM b, c, d, e
c = "Str=Str&""|Str=Str & |If | Then|End If|&vbCrlf|Temp |Rs(|Rs.|.AddNew|(""Title"")|(""Content"")|=False|ElseIf|"
c = c & "Conn.Execute(""| Exit For|[Product]|.Open|.Close|Exit For|Exit Function|MoveNext:Next:|Str "
b = sPLiT(c, "|")
fOR eACh d iN b
iF d <> "" tHEn
e = uPPeRCaSEoRLoWErCAsE(d)
a = rEPlACe(a, cHR(9), "")
a = rEPlACe(a, d, e)
eND iF
nEXt
eNCaSPcONtENt = a
eND fUNcTIoN
fUNcTIoN uPPeRCaSEoRLoWErCAsE(bYVaL a)
dIM b, c, d, e
d = ""
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
rANdOMiZE
e = cINt(rND() * 1)
iF e = 0 tHEn
d = d & lCAsE(c)
eLSe
d = d & uCAsE(c)
eND iF
nEXt
uPPeRCaSEoRLoWErCAsE = d
eND fUNcTIoN
fUNcTIoN eNCcODe(bYVaL a)
dIM b, c
c = ""
fOR b = 1 tO lEN(a)
c = c & "%" & hEX(aSC(mID(a, b, 1)))
nEXt
eNCcODe = c
eND fUNcTIoN
fUNcTIoN dECcODe(bYVaL a)
dIM b, c, d
c = ""
d = sPLiT(a, "%")
fOR b = 1 tO uBOuND(d)
iF d(b) <> "" tHEn
c = c & cHR(cINt("&H" & d(b)))
eND iF
nEXt
dECcODe = c
eND fUNcTIoN
pUBlIC fUNcTIoN tOUnICoDE(a)
dIM b, c, d, e
tOUnICoDE = ""
d = ""
e = ""
fOR b = 1 tO lEN(a)
d = mID(a, b, 1)
c = aSCw(d)
iF c < 0 tHEn
c = c + 65536
eND iF
iF c >= 0 aND c <= 128 tHEn
iF e = "c" tHEn
tOUnICoDE = " " & tOUnICoDE
e = "e"
eND iF
tOUnICoDE = tOUnICoDE & d
eLSe
iF e = "e" tHEn
tOUnICoDE = tOUnICoDE & " "
e = "c"
eND iF
tOUnICoDE = tOUnICoDE & "&#" & c & ";"
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN jAPaN(bYVaL a, b)
iF iSNuLL(a) oR iSEmPTy(a) tHEn
jAPaN = ""
eXIt fUNcTIoN
eND iF
dIM c, d, e
iF b = "" tHEn b = 0
e = sPLiT("Jn0;,Jn1;,Jn2;,Jn3;,Jn4;,Jn5;,Jn6;,Jn7;,Jn8;,Jn9;,Jn10;,Jn11;,Jn12;,Jn13;,Jn14;,Jn15;,Jn16;,Jn17;,Jn18;,Jn19;,Jn20;,Jn21;,Jn22;,Jn23;,Jn24;,Jn25;", ",")
c = sPLiT(cHR( -23116) & "," & cHR( -23124) & "," & cHR( -23122) & "," & cHR( -23120) & "," & cHR( -23118) & "," & cHR( -23114) & "," & cHR( -23112) & "," & cHR( -23110) & "," & cHR( -23099) & "," & cHR( -23097) & "," & cHR( -23095) & "," & cHR( -23075) & "," & cHR( -23079) & "," & cHR( -23081) & "," & cHR( -23085) & "," & cHR( -23087) & "," & cHR( -23052) & "," & cHR( -23076) & "," & cHR( -23078) & "," & cHR( -23082) & "," & cHR( -23084) & "," & cHR( -23088) & "," & cHR( -23102) & "," & cHR( -23104) & "," & cHR( -23106) & "," & cHR( -23108), ",")
jAPaN = a
fOR d = 0 tO 25
iF b = 0 tHEn
jAPaN = rEPlACe(jAPaN, c(d), e(d))
eLSe
jAPaN = rEPlACe(jAPaN, e(d), c(d))
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN jAPaN26(a)
jAPaN26 = jAPaN(a, 0)
eND fUNcTIoN
fUNcTIoN uNJaPAn26(a)
uNJaPAn26 = jAPaN(a, 1)
eND fUNcTIoN
fUNcTIoN hANdLEhTMl(bYVaL a)
a = rEPlACe(a, "<", "&lt;")
hANdLEhTMl = a
eND fUNcTIoN
fUNcTIoN uNHaNDlEHtML(bYVaL a)
a = rEPlACe(a, "&lt;", "<")
uNHaNDlEHtML = a
eND fUNcTIoN
fUNcTIoN lCAsEEnC(a)
dIM b, c, d, e
e = ""
fOR b = 1 tO lEN(a)
d = mID(a, b, 1)
c = aSCw(d)
iF c >= 97 aND c <= 122 tHEn
e = e & cHRw(c + 1)
eLSe
e = e & d
eND iF
nEXt
e = rEPlACe(e, vBCrLF, "＠")
lCAsEEnC = e
eND fUNcTIoN
fUNcTIoN lCAsEDeC(a)
dIM b, c, d, e
e = ""
fOR b = 1 tO lEN(a)
d = mID(a, b, 1)
c = aSCw(d)
iF c >= 97 aND c <= 123 tHEn
e = e & cHRw(c - 1)
eLSe
e = e & d
eND iF
nEXt
e = rEPlACe(e, "＠", vBCrLF)
lCAsEDeC = e
eND fUNcTIoN
fUNcTIoN hTMlTOjS(bYVaL a)
a = rEPlACe("" & a, "\", "\\")
a = rEPlACe(a, "/", "\/")
a = rEPlACe(a, "'", "\'")
a = rEPlACe(a, """", "\""")
a = jOIn(sPLiT(a, vBCrLF), """);" & vBCrLF & "document.write(""")
a = "document.write(""" & a & """);"
hTMlTOjS = a
eND fUNcTIoN
fUNcTIoN jSToHTmL(bYVaL a)
a = rEPlACe(a, "document.write(""", "")
a = rEPlACe(a, """);", "")
a = rEPlACe(a, "\""", """")
a = rEPlACe(a, "\'", "'")
a = rEPlACe(a, "\/", "/")
a = rEPlACe(a, "\\", "\")
jSToHTmL = a
eND fUNcTIoN
fUNcTIoN hTMlTOaSP(bYVaL a)
a = rEPlACe(a, """", """""")
a = jOIn(sPLiT(a, vBCrLF), """)" & vBCrLF & "Response.Write(""")
a = "Response.Write(""" & a & """)"
hTMlTOaSP = a
eND fUNcTIoN
fUNcTIoN hTMlTOaSPdIM(bYVaL a)
a = rEPlACe(a, """", """""")
a = jOIn(sPLiT(a, vBCrLF), """" & vBCrLF & "C=C & """)
a = "C=C & """ & a & """"
hTMlTOaSPdIM = a
eND fUNcTIoN
fUNcTIoN aSPtOHtML(bYVaL a)
a = rEPlACe(a, "Response.Write(""", "")
a = rEPlACe(a, """""", """")
aSPtOHtML = a
eND fUNcTIoN
fUNcTIoN sETfILeNAmE(bYVaL a)
dIM b, c, d, e, f
d = "\/:*?""<>|.,"
f = "撇揦：星？“左右横。，"
fOR b = 1 tO lEN(d)
c = mID(d, b, 1)
e = mID(f, b, 1)
a = rEPlACe(a, c, e)
nEXt
a = rEPlACe(a, "&nbsp;", " ")
a = rEPlACe(a, "&quot;", "双")
a = rEPlACe(a, vBCrLF, "")
sETfILeNAmE = a
eND fUNcTIoN
fUNcTIoN uNSeTFiLEnAMe(bYVaL a)
dIM b, c, d, e, f
d = "\/:*?""<>|."
f = "撇揦：星？“左右横。，"
fOR b = 1 tO lEN(d)
c = mID(f, b, 1)
e = mID(d, b, 1)
a = rEPlACe(a, c, e)
nEXt
uNSeTFiLEnAMe = a
eND fUNcTIoN
fUNcTIoN hTMlTOaSCcHR(a)
dIM b, c, d
d = ""
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
d = d & "Chr(" & aSC(c) & ")&"
nEXt
iF d <> "" tHEn d = lEFt(d, lEN(d) - 1)
hTMlTOaSCcHR = d
eND fUNcTIoN
fUNcTIoN uNHtMLtOAsCChR(a)
dIM b, c, d, e, f
d = a : f = ""
d = rEPlACe(d, "Chr(", "")
d = rEPlACe(d, ")&", " ")
d = rEPlACe(d, ")", " ")
e = sPLiT(d, " ")
fOR b = 0 tO uBOuND(e) - 1
c = e(b)
f = f & cHR(c)
nEXt
uNHtMLtOAsCChR = f
eND fUNcTIoN
fUNcTIoN vARiABlEDiSPlACeMEnT(a, b)
dIM c, d, e, f, g, h, i, j, k, l
f = "yzoehijklmfgqrstuvpabnwxcd"
h = lEN(f)
g = "4539671820"
i = lEN(g)
c = ""
fOR d = 1 tO lEN(a)
e = mID(a, d, 1)
j = iNStR(f, e)
k = iNStR(g, e)
iF j > 0 tHEn
l = j + b
iF l > h tHEn
l = l - h
eLSeIF l <= 0 tHEn
l = l + h
eND iF
e = mID(f, l, 1)
eLSeIF k > 0 tHEn
l = k + b
iF l > i tHEn
l = l - i
eLSeIF l <= 0 tHEn
l = l + i
eND iF
e = mID(g, l, 1)
eND iF
c = c & e
nEXt
vARiABlEDiSPlACeMEnT = c
eND fUNcTIoN
fUNcTIoN xOReNC(a, b)
dIM c, d, e, f, g
c = a
d = lEN(c) : f = ""
fOR g = 0 tO d - 1
e = aSCw(rIGhT(c, d - g)) xOR b
f = f & cHRw(iNT(e))
nEXt
f = rEPlACe(f, cHRw(34), "ㄨ")
xOReNC = f
eND fUNcTIoN
fUNcTIoN xORdEC(a, b)
dIM c, d, e, f, g
c = a : f = ""
c = rEPlACe(c, "ㄨ", cHRw(34))
d = lEN(c)
fOR g = 0 tO d - 1
e = aSCw(rIGhT(c, d - g)) xOR b
f = f & cHRw(iNT(e))
nEXt
f = rEPlACe(f, "＠", vBCrLF)
xORdEC = f
eND fUNcTIoN
fUNcTIoN hANdLEeVAlADdDEc(bYVaL a, b)
dIM c
c = b & "Execute unDec_log(""" & eNCcODe(a) & """)" & b
c = c & "Function unDec_log(ByVal Content)" & b
c = c & "    Dim I, C, SplStr " & b
c = c & "    SplStr = Split(Content, ""%"") " & b
c = c & "    For I = 1 To UBound(SplStr)" & b
c = c & "        C = C & Chr(CInt(""&H"" & SplStr(I))) " & b
c = c & "    Next " & b
c = c & "    unDec_log = C " & b
c = c & "End Function " & b
hANdLEeVAlADdDEc = c
eND fUNcTIoN
fUNcTIoN eVAlADdDEc(bYVaL a)
eVAlADdDEc = hANdLEeVAlADdDEc(a, vBCrLF)
eND fUNcTIoN
fUNcTIoN vBEvALaDDdEC(bYVaL a)
vBEvALaDDdEC = eSCaPE(hANdLEeVAlADdDEc(a, ":"))
eND fUNcTIoN
fUNcTIoN xDEc(a)
dIM b, c, d, e, f
b = a
b = rEPlACe(b, "ㄨ", cHR(34))
c = lEN(b) : d = "" : e = ""
fOR f = 0 tO c - 1
d = aSC(rIGhT(b, c - f)) xOR 20
e = e & cHR(iNT(d))
nEXt
e = rEPlACe(e, "＠", vBCrLF)
xDEc = e
eND fUNcTIoN
pUBlIC fUNcTIoN tOHeXCoLOr(a)
dIM b
tOHeXCoLOr = ""
b = cSTr(hEX(a))
sELeCT cASe lEN(b)
cASe 1 : tOHeXCoLOr = "&H00000" & b
cASe 2 : tOHeXCoLOr = "&H0000" & b
cASe 3 : tOHeXCoLOr = "&H000" & b
cASe 4 : tOHeXCoLOr = "&H00" & b
cASe 5 : tOHeXCoLOr = "&H0" & b
cASe 6 : tOHeXCoLOr = "&H" & b
eND sELeCT
eND fUNcTIoN
pUBlIC fUNcTIoN cOLoRRgB(a)
dIM b, c
b = "" : c = ""
dIM aRRaYStR(2)
aRRaYStR(0) =(a mOD b)
aRRaYStR(1) =((a mOD c) \ b)
aRRaYStR(2) =(a \ c)
cOLoRRgB = aRRaYStR
eND fUNcTIoN
fUNcTIoN sIMpLEeNC(a)
a = rEPlACe(a, "x", "輕")
a = rEPlACe(a, "f", "蚛")
a = rEPlACe(a, "s", "鋋")
a = rEPlACe(a, "h", "孿")
a = rEPlACe(a, "t", "謣")
a = rEPlACe(a, "o", "薺")
a = rEPlACe(a, "<", "讞")
a = rEPlACe(a, ">", "旻")
a = rEPlACe(a, "a", "艓")
a = rEPlACe(a, "c", "襋")
a = rEPlACe(a, "n", "贁")
a = rEPlACe(a, "m", "曁")
a = rEPlACe(a, vBCrLF, "樞")
sIMpLEeNC = a
eND fUNcTIoN
fUNcTIoN sIMpLEdEC(a)
a = rEPlACe(a, "輕", "x")
a = rEPlACe(a, "蚛", "f")
a = rEPlACe(a, "鋋", "s")
a = rEPlACe(a, "孿", "h")
a = rEPlACe(a, "謣", "t")
a = rEPlACe(a, "薺", "o")
a = rEPlACe(a, "讞", "<")
a = rEPlACe(a, "旻", ">")
a = rEPlACe(a, "艓", "a")
a = rEPlACe(a, "襋", "c")
a = rEPlACe(a, "贁", "n")
a = rEPlACe(a, "曁", "m")
a = rEPlACe(a, "樞", vBCrLF)
sIMpLEdEC = a
eND fUNcTIoN
fUNcTIoN eNCaSPeVAlRUn(bYVaL a)
dIM b, c, d
a = rEPlACe(a, "<" & "%", "")
a = rEPlACe(a, "%" & ">", "")
a = rEPlACe(a, """", """""")
a = rEPlACe(a, "x", "輕")
a = rEPlACe(a, "f", "蚛")
a = rEPlACe(a, "s", "鋋")
a = rEPlACe(a, "o", "薺")
a = rEPlACe(a, "e", "療")
b = sPLiT(a, vBCrLF)
d = ""
fOR c = 0 tO uBOuND(b)
iF iNStR(b(c), "'") = fALsE aND lEN(b(c)) > 1 tHEn
d = d & b(c) & "⊙"
eND iF
nEXt
d = lEFt(d, lEN(d) - 1)
d = "Execute MyEval(""" & d & """)" & vBCrLF
d = d & "Function MyEval(HtmlStr)" & vBCrLF
d = d & vBTaB & "MyEval=Replace(HtmlStr,""⊙"",vbCrlf)" & vBCrLF
d = d & vBTaB & "MyEval=Replace(MyEval,""輕"",""x"")" & vBCrLF
d = d & vBTaB & "MyEval=Replace(MyEval,""蚛"",""f"")" & vBCrLF
d = d & vBTaB & "MyEval=Replace(MyEval,""鋋"",""s"")" & vBCrLF
d = d & vBTaB & "MyEval=Replace(MyEval,""薺"",""o"")" & vBCrLF
d = d & vBTaB & "MyEval=Replace(MyEval,""療"",""e"")" & vBCrLF
d = d & "End Function" & vBCrLF
eNCaSPeVAlRUn = "<" & "%" & vBCrLF & d & "%" & ">"
eND fUNcTIoN
%>


