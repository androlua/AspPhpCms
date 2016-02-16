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
fUNcTIoN bATcHFiNDfUNcTIoN(a,b)
dIM c,d,e,f,g
dIM h,i
iF cHEcKFiLE(a)=fALsE tHEn
bATcHFiNDfUNcTIoN=""
cALl eCHo("配置文件不存在", a)
eXIt fUNcTIoN
eND iF
c=gETfTExT(a)
d = lCAsE(c)
d=rEPlACe(rEPlACe(d, ",","|"), vBCrLF,"|")
e=sPLiT(b,"|")
fOR eACh f iN e
iF f<>"" aND iNStR(d,"|"& f &"|") tHEn
g=g & gETfINdFIlEFuNCtIOn(a,f) & vBCrLF
eND iF
nEXt
bATcHFiNDfUNcTIoN = g
eND fUNcTIoN
fUNcTIoN gETfINdFIlEFuNCtIOn(bYVaL a,bYVaL b)
dIM c,d,e,f,g,h
dIM i,j
b=lCAsE(pHPtRIm(b))
iF cHEcKFiLE(a)=fALsE tHEn
gETfINdFIlEFuNCtIOn=""
cALl eCHo("配置文件不存在", a)
eXIt fUNcTIoN
eND iF
d=gETfTExT(a)
e=sPLiT(d,vBCrLF)
fOR eACh g iN e
iF iNStR(g,",")>0 tHEn
c=mID(g,1,iNStR(g,",")-1)
iF iNStR(c,"(")>0 tHEn
c=mID(c,1,iNStR(c,"(")-1)
eND iF
h=lCAsE(mID(g,iNStRReV(g,",")+1))
iF iNStR("|"& h &"|","|"& b &"|")>0 tHEn
sET i = nEW aSPcODe
i.sETcOUnTRoW = 9999
i.sETaSPsETtYPe = "||"	
i.sETfINdFUnCTiONlISt=b
j=gETfTExT(c)
j = i.hANdLEaSPcODe(j)	
gETfINdFIlEFuNCtIOn = i.gETfINdFUnCTiONcONtENt
sET i=nOThINg
eXIt fUNcTIoN
eND iF
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN gETaSPcODe(bYVaL a)
gETaSPcODe = hANdLEgETaSPcODe(a, "")
eND fUNcTIoN
fUNcTIoN hANdLEgETaSPcODe(bYVaL a, b)
dIM c, d, e, f, g, h, i, j, k, l, m
h = fALsE
i = 0
c = sPLiT(a, vBCrLF)
iF iNStR("|" & b & "|", "|全部为ASP|") > 0 oR iNStR("|" & b & "|", "|默认ASP自检打开|") > 0 tHEn
h = tRUe
eND iF
fOR eACh e iN c
k = ""
fOR g = 1 tO lEN(e)
d = mID(e, g, 1)
iF d = "<" aND h = fALsE aND j = "" tHEn
iF mID(e, g + 1, 1) = "%" tHEn
h = tRUe
d = "<" & "%"
g = g + 1
iF iNStR("|" & b & "|", "|去ASP开始结束标签|") = fALsE tHEn
k = k & d
eND iF
eND iF
eLSeIF d = "%" aND mID(e, g + 1, 1) = ">" aND h = tRUe aND j = "" tHEn
h = fALsE
d = "%" & ">"
g = g + 1
iF iNStR("|" & b & "|", "|去ASP开始结束标签|") = fALsE tHEn
f = f & d & vBCrLF
eND iF
iF iNStR("|" & b & "|", "|第一段|") > 0 oR iNStR("|" & b & "|", "|第一段代码|") > 0 oR iNStR("|" & b & "|", "|获取第一段|") > 0 oR iNStR("|" & b & "|", "|1|") > 0 tHEn
hANdLEgETaSPcODe = f & k
eXIt fUNcTIoN
eND iF
eLSeIF h = tRUe tHEn
iF(d = """" oR j <> "") tHEn
iF d = """" tHEn i = i + 1
j = j & d
iF i mOD 2 = 0 tHEn
iF mID(e, g + 1, 1) <> """" tHEn
k = k & j
i = 0 : j = ""
eND iF
eND iF
eLSeIF d = "'" tHEn
iF iNStR("|" & b & "|", "|去注释部分|") > 0 tHEn
eXIt fOR
eND iF
k = k & mID(e, g)
eXIt fOR
eLSe
k = k & d
eND iF
eND iF
nEXt
iF h = tRUe tHEn	
m = tRUe
iF tRImVBcRLf(k) = "" tHEn
iF iNStR("|" & b & "|", "|每行不为空|") > 0 oR iNStR("|" & b & "|", "|去空行|") > 0 tHEn
m = fALsE
eND iF
eND iF
iF m = tRUe tHEn
iF iNStR("|" & b & "|", "|处理成Execute代码|") > 0 tHEn
k = tRImVBcRLf(k) : l = lCAsE(k)
f = f & k & " : "
iF lEFt(l, 3) = "if " aND rIGhT(l, 5) <> " then" tHEn
f = f & " End If : "
eND iF
eLSe
k = rTRiM(k)
f = f & k & vBCrLF
eND iF
eND iF
eND iF
nEXt
iF iNStR("  " & f,vBCrLF)>0 tHEn f = lEFt(f,lEN(f)-2)
hANdLEgETaSPcODe = f
eND fUNcTIoN
fUNcTIoN dELaSPnOTe(bYVaL a)
dIM b, c, d, e, f, g, h, i, j
dIM k
d = fALsE
k = fALsE
e = fALsE
j = 0
b = sPLiT(a, vBCrLF)
fOR eACh g iN b
fOR c = 1 tO lEN(g)
f = mID(g, c, 1)
iF f = "<" aND h = "" tHEn
iF mID(g, c + 1, 1) = "%" tHEn
d = tRUe
f = "<" & "%"
c = c + 1
eND iF
eLSeIF f = "%" aND mID(g, c + 1, 1) = ">" aND h = "" tHEn
d = fALsE
f = "%" & ">"
c = c + 1
eND iF
iF d = tRUe tHEn
iF(f = """" oR h <> "") tHEn
iF f = """" tHEn j = j + 1
h = h & f
iF j mOD 2 = 0 tHEn
iF mID(g, c + 1, 1) <> """" tHEn
i = i & h
j = 0 : h = ""
eND iF
eND iF
eLSeIF f = "'" tHEn
eXIt fOR
eLSe
i = i & f
eND iF
eLSe
i = i & f
eND iF
dOEvENtS
nEXt
i = rTRiM(i)
i = i & vBCrLF
dOEvENtS
nEXt
iF i <> "" tHEn i = lEFt(i, lEN(i) - 2)
dELaSPnOTe = i
eND fUNcTIoN
fUNcTIoN fINdASpFUnCTiON(a, b, c, d)
dIM e, f, g, h, i, j, k, l, m, n, o
dIM uPWoRD	
dIM q, r
dIM s
g = fALsE
s = fALsE
h = fALsE
o = 0
e = sPLiT(a, vBCrLF)
iF b = "" tHEn b = 0
iF c = "" tHEn c = 0
iF iNStR("|" & d & "|", "|全部为ASP|") > 0 oR iNStR("|" & d & "|", "|默认ASP自检打开|") > 0 tHEn
g = tRUe
eND iF
fOR eACh j iN e
fOR f = 1 tO lEN(j)
i = mID(j, f, 1)
iF i = "<" aND k = "" tHEn
iF mID(j, f + 1, 1) = "%" tHEn
g = tRUe
f = f + 1
eND iF
eLSeIF i = "%" aND mID(j, f + 1, 1) = ">" aND k = "" tHEn
g = fALsE
f = f + 1
eND iF
iF g = tRUe tHEn
iF(i = """" oR k <> "") tHEn
iF i = """" tHEn o = o + 1
k = k & i
iF o mOD 2 = 0 tHEn
iF mID(j, f + 1, 1) <> """" tHEn
m = rIGhT(rEPlACe(mID(j, 1, f - lEN(k)), " ", ""), 1)
iF s = tRUe tHEn n = n & k
o = 0 : k = ""
eND iF
eND iF
eLSeIF i = "'" tHEn
iF s = tRUe tHEn n = n & mID(j, f)
eXIt fOR
eLSeIF cHEcKAbC(i) = tRUe oR(i = "_" aND l <> "") oR l <> "" tHEn
l = l & i
m = lCAsE(mID(j & " ", f + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", m) = 0 aND nOT(m = "_" aND l <> "") tHEn
q = mID(j, f + 1)
iF iNStR("|function|sub|", "|" & lCAsE(l) & "|") tHEn
iF s = fALsE aND lCAsE(uPWoRD) <> "end" tHEn
s = tRUe
iF lCAsE(l) = "sub" tHEn b = b + 1 eLSe c = c + 1
r = gETfUNdIMnAMe(q)
eLSeIF s = tRUe aND lCAsE(uPWoRD) = "end" tHEn
n = n & l & vBCrLF
iF iNStR("|" & d & "|", "|加密变量|") > 0 tHEn n = n & "'[NOHandle]" & eNCcODe(r) & vBCrLF & vBCrLF
s = fALsE
eND iF
eLSeIF s = tRUe aND lCAsE(l) = "dim" tHEn
r = r & "," & gETdIMnAMe(q)
eLSeIF s = tRUe aND iNStR("|" & d & "|", "|变量处理|") > 0 tHEn
l = rEPlACeDIm2(r, l)
eND iF
uPWoRD = l
iF s = tRUe tHEn n = n & l
l = ""
eND iF
eLSeIF s = tRUe tHEn
n = n & i
eND iF
eND iF
dOEvENtS
nEXt
n = rTRiM(n)
iF s = tRUe tHEn
n = n & vBCrLF
eND iF
dOEvENtS
nEXt
fINdASpFUnCTiON = n
eND fUNcTIoN
fUNcTIoN fIRsTLeTTeRUpPErCAsE(a)
dIM b, c, d, e, f, g, h, i, j, k, l
dIM m
d = fALsE
m = fALsE
e = fALsE
l = 0
b = sPLiT(a, vBCrLF)
fOR eACh g iN b
fOR c = 1 tO lEN(g)
f = mID(g, c, 1)
iF f = "<" aND h = "" tHEn
iF mID(g, c + 1, 1) = "%" tHEn
d = tRUe
c = c + 1
f = "<%"
eND iF
eLSeIF f = "%" aND mID(g, c + 1, 1) = ">" aND h = "" tHEn
d = fALsE
c = c + 1
k = k & "%" & ">"
eND iF
iF d = tRUe tHEn
iF(f = """" oR h <> "") tHEn
iF f = """" tHEn l = l + 1
h = h & f
iF l mOD 2 = 0 tHEn
iF mID(g, c + 1, 1) <> """" tHEn
j = rIGhT(rEPlACe(mID(g, 1, c - lEN(h)), " ", ""), 1)
iF m = tRUe tHEn k = k & h
l = 0 : h = ""
eND iF
eND iF
eLSeIF f = "'" tHEn
iF m = tRUe tHEn k = k & mID(g, c)
eXIt fOR
eLSeIF cHEcKAbC(f) = tRUe oR(f = "_" aND i <> "") oR i <> "" tHEn
i = i & f
j = lCAsE(mID(g & " ", c + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 aND nOT(j = "_" aND i <> "") tHEn
k = k & uCAsE(lEFt(i, 1)) & mID(i, 2)
i = ""
eND iF
eLSe
k = k & f
eND iF
eND iF
dOEvENtS
nEXt
k = rTRiM(k)
iF m = tRUe tHEn
k = k & vBCrLF
eND iF
k = k & vBCrLF
dOEvENtS
nEXt
fIRsTLeTTeRUpPErCAsE = k
eND fUNcTIoN
fUNcTIoN cONtENtLUsHOw(a)
dIM b,c,d
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
c = iIF(pHPrND(0,1)="0",lCAsE(c),uCAsE(c))
d=d & c
nEXt
cONtENtLUsHOw = d
eND fUNcTIoN
fUNcTIoN aSPtOVb(a)
a= dELeTEsTRcUT(a,vBCrLF & "'开始",vBCrLF & "'结束",1,0)
a= dELeTEsTRcUT(a,vBCrLF & "'VB不引用 Start", vBCrLF & "'VB不引用 End",1,0)
a = rEPlACe(a,"Response.End()","Response.End")
a = rEPlACe(a,"Server."&"MapPath(Path)","App"&".Path & ""\"" & Path")
a = rEPlACe(a,"Server."&"MapPath(""/"")","App."&"Path & ""\""")
a = rEPlACe(a,"Server."&"MapPath(""\"")","App."&"Path & ""\""")
a = rEPlACe(a,"Server."&"MapPath("".\"")","App."&"Path & "".\""")
a = rEPlACe(a,"Server."&"MapPath(""./"")","App."&"Path & "".\""")
a = rEPlACe(a,""" & Request."&"ServerVariables(""HTTP_HOST"") & ""","127.0.0.1")
a = rEPlACe(a,vBTaB,"    ")	
a = rEPlACe(a,"request(""Debug"")"," 1=2 and ""11""")	
a = rEPlACe(a,"Request(""gl"")"," 1=2 and ""11""")	
a = rEPlACe(a,"Request."&"QueryString(""Debug"")"," 1=2 and ""11""")	
aSPtOVb = a
eND fUNcTIoN
fUNcTIoN aSPtOVbNEt(a)
dIM b,c,d,e,f,g,h,i
dIM j,k,l,m
b=sPLiT(a,vBCrLF)
fOR eACh d iN b
h=pHPtRIm(lCAsE(d)):e=pHPtRIm(d)
iF iNStR(lCAsE(d)," doerror ")>0 aND iNStR(lCAsE(d),"call ")=fALsE tHEn
d=rEGeXP_REpLAcE(d, " doError ", " call doError(") & ")"
eND iF
iF lEFt(h,4)="sub " tHEn
d=fUNcTIoNPaRAmTOnET(d)	
eLSeIF lEFt(h,9)="function " tHEn
d=fUNcTIoNPaRAmTOnET(d)	
f=mID(d,iNStR(lCAsE(d),"function ") + 9)
i=pHPtRIm( mID(f,1,iNStR(f,"(")-1))
d = d & vBCrLF & i & "="""""
eLSeIF lEFt(h,4)="set " tHEn
d=mID(d, iNStR(lCAsE(d),"set ")+3)
eLSeIF lEFt(h,4)="dim " tHEn
d=dIMaDDdEFaULtVAlUE(d)
eLSeIF lEFt(h,1)="." tHEn
j=mID(d,1,iNStR(d,".")-1)
k=""
iF iNStR(d,"'")>0 tHEn
k=mID(d,iNStR(d,"'"))
eND iF
l=mID(d,iNStR(d,"."))
iF iNStR(d,"'")>0 tHEn
l=mID(l,1,iNStR(l,"'")-1)
eND iF
m=l
l=j & "call " & mID(l,1,iNStR(l," ")) & "(" & mID(l,iNStR(l," ")) & ")" & k
iF iNStR(m,"=")=fALsE aND iNStR(m,"(")=fALsE  tHEn
d=l
eND iF
eLSeIF lEFt(h,2)="if" tHEn
j=mID(d,1,iNStR(lCAsE(d),"if")-1)
k=""
iF iNStR(d,"'")>0 tHEn
k=mID(d,iNStR(d,"'"))
eND iF
l=mID(d,iNStR(lCAsE(d),"if"))
iF iNStR(d,"'")>0 tHEn
l=mID(l,1,iNStR(l,"'")-1)
eND iF
iF rIGhT(rTRiMVbTAb(lCAsE(l)),5)<>" then" tHEn
l=l & " :end if  "
eND iF
l = j & l & k
eLSeIF lEFt(h,4)="wend" tHEn
d= "end While"
eND iF
g=g & d & vBCrLF
nEXt
aSPtOVbNEt=g
eND fUNcTIoN
fUNcTIoN dIMaDDdEFaULtVAlUE(a)
dIM b,c,d,e,f,g,h
g=a
e=mID(a,1,iNStR(lCAsE(a),"dim ")+3)
a=mID(a,lEN(e))
b=sPLiT(a,",")
fOR eACh c iN b	
h=""
iF iNStR(c,":")>0 tHEn
h=mID(c,iNStR(c,":"))
c=mID(c,1,iNStR(c,":")-1)
eLSeIF iNStR(c,"'")>0 tHEn
h=mID(c,iNStR(c,"'"))
c=mID(c,1,iNStR(c,"'")-1)
eND iF
iF iNStR(lCAsE("|c|content|html|htmlstr|strhtml|cssstr|strcss|StyleName|parentUrl|parentParentUrl|parentParentParentUrl|szRet|Url|UrlFileName|urlList|UrlParam|WebSite|FanCharSet|s1|s2|s3|c1|c2|c3|c4|c5|En1|En2|En3|En4|s|temp|temp1|temp2|temp3|yinghaoLabel|parentName|valueStr|valueStr1|valueStr2|valueStr3|noDanYinShuangYinStr|PubAHrefList|PubATitleList|yinghaoLabel|parentName|valueStr|nLen|ParamList|ParamNameList|ParamList|Str_unicode|valueLabel||"), "|" & pHPtRIm(lCAsE(c)) & "|")>0 oR rIGhT(pHPtRIm(lCAsE(c)),3)="str" tHEn
f= f & c & "=""""" & vBCrLF
eND iF
iF d<>"" tHEn d=d & ","
d=d & c & h
nEXt
dIMaDDdEFaULtVAlUE=g & vBCrLF & f
eND fUNcTIoN
fUNcTIoN fUNcTIoNPaRAmTOnET(a)
dIM b,c,d,e,f,g,h
b=mID(a,1,iNStR(a,"("))
c=mID(a,iNStR(a,")"))
d=mID(a,iNStR(a,"(")+1)
d=mID(d,1,iNStR(d,")")-1)
e=sPLiT(d,",")
fOR eACh f iN e
f=pHPtRIm(f)
h=lCAsE(f)
iF iNStR(h,"byval")=fALsE aND iNStR(h,"byref")=fALsE tHEn
f=" byref " & f
eND iF
iF g<>"" tHEn g=g & ","
g=g & f
nEXt
fUNcTIoNPaRAmTOnET = b & g & c
eND fUNcTIoN
fUNcTIoN gETbEFoREnSTr(a,b,c)
dIM d, e, f, g, h, i, j, k, l, m
dIM n
dIM aRRaYWc(999)	
dIM aRRaYWcCOuNT	
dIM q
dIM aRRaYZc(999)	
dIM aRRaYZcCOuNT	
dIM t
dIM aRRaYNc(999)	
dIM aRRaYNcCOuNT	
dIM w
dIM aRRaYFc(999)	
dIM aRRaYFcCOuNT	
dIM aRRaYCoUNtSTr(999)	
dIM nARrAYcOUnT											  	
dIM bA
dIM cA
dIM dA
dIM eA
dIM fA
dIM gA
dIM hA
dIM iA
dIM jA
dIM kA
dIM lA
i = 0
aRRaYWcCOuNT=0	
aRRaYZcCOuNT=0	
aRRaYNcCOuNT=0	
aRRaYFcCOuNT=0	
nARrAYcOUnT=0	
d = sPLiT(a, vBCrLF)
fOR m = 0 tO uBOuND(d)
f = d(m)
cA = f
iA = "" : jA = ""
lA = ""
kA = ""
iF(m + 1) <= uBOuND(d) tHEn
kA = d(m + 1)
eND iF
t = ""
fOR h = 1 tO lEN(f)
e = mID(f, h, 1)
gA = rIGhT(rEPlACe(mID(f, 1, h - 1), " ", ""), 1)
hA = lEFt(rEPlACe(mID(f, h + 1), " ", ""), 1)
fA = mID(f, h + 1)
iF(e = """" oR n <> "") tHEn
iF e = """" tHEn i = i + 1
iF i mOD 2 = 0 tHEn
iF mID(f, h + 1, 1) <> """" tHEn
n = n & e
j = rIGhT(rEPlACe(mID(f, 1, h - lEN(n)), " ", ""), 1)
n = rIGhT(n, lEN(n) - 1)
n = lEFt(n, lEN(n) - 1)
n = rEPlACe(n, """""", "\""")
n = """" & n & """"
aRRaYWcCOuNT=aRRaYWcCOuNT+1	
aRRaYWc(aRRaYWcCOuNT)=n	
nARrAYcOUnT=nARrAYcOUnT+1	
aRRaYCoUNtSTr(nARrAYcOUnT)=n	
iA = iA & n
i = 0 : n = ""
eLSe
n = n & e
eND iF
eLSe
n = n & e
eND iF
eLSeIF iNStR(".&=,+-*/:()><", e) > 0 aND t = "" tHEn
iF q <> "" tHEn
l = q
eA = dA
dA = lCAsE(l)
iA = iA & q
q = ""
eND iF
eA = dA
dA = e
aRRaYFcCOuNT=aRRaYFcCOuNT+1	
aRRaYFc(aRRaYFcCOuNT)=e	
nARrAYcOUnT=nARrAYcOUnT+1	
aRRaYCoUNtSTr(nARrAYcOUnT)=e	
eLSeIF e = "'" tHEn
lA = "//" & mID(f, h + 1)
eXIt fOR
eLSeIF cHEcKAbC(e) = tRUe oR e = "_" oR q <> "" tHEn
q = q & e
bA = tRUe
j = mID(f & " ", h + 1, 1)
k = mID(q, 1, 1)
iF cHEcKAbC(j) <> tRUe aND j <> "_" tHEn
bA = fALsE
eND iF
iF cHEcKNuMBeR(j) = tRUe aND cHEcKAbC(k) = tRUe tHEn
bA = tRUe
eND iF
iF bA = fALsE tHEn
iF lCAsE(q) = "rem" tHEn
e = mID(f, h + 1) : h = h + lEN(e)
q = q & e
eND iF
aRRaYZcCOuNT=aRRaYZcCOuNT+1	
aRRaYZc(aRRaYZcCOuNT)=q	
nARrAYcOUnT=nARrAYcOUnT+1	
aRRaYCoUNtSTr(nARrAYcOUnT)=q	
l = q
eA = dA
dA = lCAsE(l)
iA = iA & q
q = ""
eND iF
eLSeIF cHEcKNuMBeR(e) = tRUe oR t <> "" tHEn
t = t & e
iF hA <> "." aND cHEcKNuMBeR(hA) = fALsE tHEn
iA = iA & t
aRRaYNcCOuNT=aRRaYNcCOuNT+1	
aRRaYNc(aRRaYNcCOuNT)=t	
nARrAYcOUnT=nARrAYcOUnT+1	
aRRaYCoUNtSTr(nARrAYcOUnT)=t	
t = ""
eND iF
eLSe
iA = iA & e
eND iF
jA = jA & e
nEXt
g = g & iA
nEXt
iF b="单词" tHEn
iF uBOuND(aRRaYCoUNtSTr)>=c tHEn
gETbEFoREnSTr=aRRaYZc(c)
eND iF	
eLSeIF b="输入" tHEn
iF uBOuND(aRRaYCoUNtSTr)>=c tHEn
gETbEFoREnSTr=aRRaYWc(c)
eND iF	
eLSeIF b="符号" tHEn
iF uBOuND(aRRaYCoUNtSTr)>=c tHEn
gETbEFoREnSTr=aRRaYFc(c)
eND iF	
eLSeIF b="数字" tHEn
iF uBOuND(aRRaYCoUNtSTr)>=c tHEn
gETbEFoREnSTr=aRRaYNc(c)
eND iF	
eLSeIF b="全部" tHEn
iF uBOuND(aRRaYCoUNtSTr)>=c tHEn
gETbEFoREnSTr=aRRaYCoUNtSTr(c)	
eND iF	
eLSe
gETbEFoREnSTr=g
eND iF
eND fUNcTIoN
fUNcTIoN gETsTRdIM(bYVaL a)
a=rEPlACe(rEPlACe(a,vBCrLF,":"),vBTaB," ")
iF iNStR(a,":")>0 tHEn
a=mID(a,1,iNStR(a,":")-1)
eND iF
iF iNStR(a,"'")>0 tHEn
a=mID(a,1,iNStR(a,"'")-1)
eND iF
a=pHPtRIm(a)
iF lEFt(a,3)="dim" tHEn
a=mID(a,4)
eND iF
a=rEPlACe(a," ","")
dIM b,c,d
iF iNStR(a,"(")>0 tHEn
b=sPLiT(a,",")
fOR eACh c iN b
iF c <>"" tHEn
iF d<>"" tHEn d=d & ","
iF iNStR(c,"(")>0 tHEn
c=mID(c,1,iNStR(c,"(")-1)
eND iF
d=d & c
eND iF
nEXt
a=d
eND iF
gETsTRdIM=a
eND fUNcTIoN
fUNcTIoN gETfUNcTIoNStRDiM(bYVaL a)
dIM b,c,d,e
iF iNStR(a,")")>0 tHEn
a=mID(a,1,iNStR(a,")")-1)
eND iF
iF iNStR(a,"(")>0 tHEn
a=mID(a,iNStR(a,"(")+1)
eND iF
a=rEPlACe(a,","," ")
b=sPLiT(a," ")
fOR eACh c iN b
e=lCAsE(c)
iF e<>"" aND e<> "byval" aND e<>"byref" tHEn
iF d<>"" tHEn d=d & ","
d=d & c
eND iF
nEXt
gETfUNcTIoNStRDiM=d
eND fUNcTIoN
%>

