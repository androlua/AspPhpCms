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
fUNcTIoN sENd_EmAIl(a, b, c, d)
dIM e, f, g
rESpONsE.aDDhEAdER "Content-Type", "text/html; charset=gb2312"
sET e = cREaTEoBJeCT("JMail.Message")
e.cONtENtTRaNSfEReNCoDInG = "base64"
e.eNCoDInG = "base64"
e.cONtENtTYpE = "text/html"
e.sILeNT = tRUe
e.lOGgINg = tRUe
e.cHArSEt = "gb2312"
e.mAIlSErVErUSeRNaME = "m18251922007"
e.mAIlSErVErPAsSWoRD = "mydd3a"
e.fROm = "m18251922007@163.com"
e.fROmNAmE = c
e.aDDrECiPIeNT a
e.sUBjECt = b
g = g & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>"
g = g & d
g = g & "</body></html>"
e.bODy = g
sENd_EmAIl = e.sENd("smtp.163.com")
e.cLOsE
sET e = nOThINg
eND fUNcTIoN
fUNcTIoN sERvERsENd_EmAIl(a, b, c, d, e, f)
dIM g, h, i
rESpONsE.aDDhEAdER "Content-Type", "text/html; charset=gb2312"
sET g = cREaTEoBJeCT("JMail.Message")
g.cONtENtTRaNSfEReNCoDInG = "base64"
g.eNCoDInG = "base64"
g.cONtENtTYpE = "text/html"
g.sILeNT = tRUe
g.lOGgINg = tRUe
g.cHArSEt = "gb2312"
g.mAIlSErVErUSeRNaME = a
g.mAIlSErVErPAsSWoRD = b
g.fROm = "m18251922007@163.com"
g.fROmNAmE = e
g.aDDrECiPIeNT c
g.sUBjECt = d
i = i & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>"
i = i & f
i = i & "</body></html>"
g.bODy = i
sERvERsENd_EmAIl = g.sENd("smtp.163.com")
g.cLOsE
sET g = nOThINg
eND fUNcTIoN
fUNcTIoN fINdASpCOdE(bYVaL a)
a = gETaSPcODe(a)
a = gETaSPfUNcTIoNLiST(a)
fINdASpCOdE =a
eND fUNcTIoN
fUNcTIoN fINdASpFUnLIsT(bYVaL a)
dIM b,c,d,e,f,g
a = fINdASpCOdE(a)	
b=sPLiT(a,vBCrLF)
fOR eACh e iN b
f = e : e = lCAsE(e)
iF e <>"" tHEn
c=0
iF iNStR(e,"function ")>0 tHEn
c=iNStR(e,"function ")+8
eLSeIF iNStR(e,"sub ")>0 tHEn
c=iNStR(e,"sub ")+3
eND iF
iF c > 0 tHEn
f = mID(f,c)
iF iNStR(f,"(")>0 tHEn
f=mID(f,1,iNStR(f,"(")-1)
eLSe
f=mID(f,1,iNStR(f & " "," ")-1)
eND iF	
g = g & tRIm(f) & vBCrLF
eND iF
eND iF	
dOEvENtS
nEXt
fINdASpFUnLIsT=g
eND fUNcTIoN
fUNcTIoN fINdASpFUnCTiONcODe(bYVaL a, bYVaL b)
dIM c, d, e, f
iF cHEcKStR(b, "sub ") tHEn
c = "end sub"
eLSe
c = "end function"
eND iF
a = rIGhT(a, lEN(a) - iNStR(lCAsE(a), lCAsE(b)) + 1)
d = sPLiT(a, vBCrLF)
fOR eACh e iN d
f = f & e & vBCrLF
iF cHEcKStR(e, c) = tRUe tHEn eXIt fOR
nEXt
fINdASpFUnCTiONcODe = f
eND fUNcTIoN
fUNcTIoN hANdLErEPlACeLIsT(bYVaL a, b, c)
dIM d, e, f, g
d = sPLiT(b, "|")
e = sPLiT(c & "||||||||||||||||||||||||||||||||", "|")
fOR f = 0 tO uBOuND(d)
g = d(f)
iF g <> "" tHEn
a = rEPlACe(a, g, e(f))
eND iF
nEXt
hANdLErEPlACeLIsT = a
eND fUNcTIoN
fUNcTIoN gETfUNnAMeDIm(bYVaL a, b, c)
dIM d, e, f, g
a = tRIm(a)
iF iNStR(lCAsE(a), "sub ") > 0 tHEn
d = "sub"
eLSeIF iNStR(lCAsE(a), "function ") > 0 tHEn
d = "function"
eLSe
eXIt fUNcTIoN
eND iF
a = rEPlACe(a, ":", ")") & ")"
e = iNStR(a, d & " ") + lEN(d & " ")
f = iNStR(e, a, ")")
a = mID(a, e, f - e)
g = d & " " & a
iF iNStR(a, "(") > 0 tHEn
b = lEFt(a, iNStR(a, "(") - 1)
iF iNStR(b, " ") tHEn
b = mID(b, iNStR(b, " "))
eND iF
g = g & ")"
e = iNStR(g, "(") + 1
f = iNStR(e, g, ")")
c = mID(g, e, f - e)
c = rEGeXP_REpLAcE(c, "ByVal ", "")
c = rEGeXP_REpLAcE(c, "ByRef ", "")
c = rEPlACe(c, " ", "")
eLSe
b = a
eND iF
gETfUNnAMeDIm = g
eND fUNcTIoN
fUNcTIoN lEFtSPaCE(bYVaL a, bYVaL b)
dIM c, d
d = 0
fOR c = lEN(a) tO 1 sTEp - 1
iF mID(a, c, 1) <> " " tHEn eXIt fOR
d = d + 1
nEXt
iF d > b aND rEPlACe(a, " ", "") <> "" tHEn
a = lEFt(a, lEN(a) - d + b)
eLSeIF d < b aND 1 = 1 tHEn
fOR c = d tO b - 1
a = a & " "
nEXt
eND iF
lEFtSPaCE = a
eND fUNcTIoN
fUNcTIoN rIGhTSpACe(bYVaL a, bYVaL b)
dIM c, d
d = 0
fOR c = 1 tO lEN(a)
iF mID(a, c, 1) <> " " tHEn eXIt fOR
d = d + 1
nEXt
iF d > b tHEn
a = rIGhT(a, lEN(a) - d + b)
eLSeIF d < b tHEn
fOR c = d tO b - 1
a = " " & a
nEXt
eND iF
rIGhTSpACe = a
eND fUNcTIoN
fUNcTIoN iNFuNAdDDiM(bYVaL a)
dIM b, c, d, e, f, g, h, i, j, k
c = sPLiT("A_p,B_p,C_4,D_2,E_4,F_9,G_1,H_2,I_2,J_3,K_1,L_o,M_m,N_u,O_o,P_n,Q_o,R_l,S_i,T_2,U_2,V_2,W_2,X_2,Y_2,Z_2", ",")
b = sPLiT(a, vBCrLF)
g = uBOuND(b) - 1
e = sTRcUT(a, "(", ")", 2)
d = sPLiT(e, ",")
h = uBOuND(d) + 1
iF h = 0 tHEn
iNFuNAdDDiM = a
eXIt fUNcTIoN
eND iF
i = cINt(g / h)
k = 0
fOR f = 0 tO uBOuND(b)
e = b(f)
iF tRIm(e) <> "" tHEn
j = j & b(f) & vBCrLF
eND iF
iF i <> 0 tHEn
iF f mOD i = 0 aND uBOuND(d) >= k aND f <> uBOuND(b) tHEn
j = j & "dIm " & c(k) & vBCrLF
k = k + 1
eND iF
eND iF
nEXt
iF j <> "" tHEn j = lEFt(j, lEN(j) - 2)
iNFuNAdDDiM = j
eND fUNcTIoN
fUNcTIoN gETqQ(bYVaL a, b)
dIM c, d, e, f, g, h, i, j
a = rEPlACe(rEPlACe(lCAsE(a), "&nbsp;", ""), " ", "")
b = 0
iF iNStR(a, "qq") > 0 tHEn
c = sPLiT(a, "qq")
fOR d = 1 tO uBOuND(c)
f = c(d)
h = "" : i = 14 : j = fALsE
fOR e = 1 tO lEN(f)
iF iNStR("0123456789", mID(f, e, 1)) = fALsE tHEn
iF j = tRUe tHEn eXIt fOR
iF i = 0 tHEn eXIt fOR
i = i - 1
iF mID(f, e, 1) = "群" tHEn eXIt fOR
eLSe
j = tRUe
h = h & mID(f, e, 1)
eND iF
iF e > 30 tHEn eXIt fOR
nEXt
iF lEN(h) >= 6 aND lEN(h) <= 10 aND iNStR(vBCrLF & g, vBCrLF & h & vBCrLF) = fALsE tHEn
iF iNStR(vBCrLF & g, vBCrLF & h & vBCrLF) = fALsE tHEn
g = g & h & vBCrLF
b = b + 1
eND iF
eND iF
nEXt
eND iF
gETqQ = g
eND fUNcTIoN
fUNcTIoN gETtEL(bYVaL a, b)
dIM c, d, e, f, g, h, i, j
a = rEPlACe(rEPlACe(lCAsE(a), "&nbsp;", ""), "手机", "tel")
b = 0
iF iNStR(a, "tel") > 0 tHEn
c = sPLiT(a, "tel")
fOR d = 1 tO uBOuND(c)
f = c(d)
h = "" : i = 14 : j = fALsE
fOR e = 1 tO lEN(f)
iF iNStR("0123456789", mID(f, e, 1)) = fALsE tHEn
iF j = tRUe tHEn eXIt fOR
iF i = 0 tHEn eXIt fOR
i = i - 1
eLSe
j = tRUe
h = h & mID(f, e, 1)
eND iF
iF e > 30 tHEn eXIt fOR
nEXt
iF lEN(h) = 11 tHEn
iF iNStR(vBCrLF & g, vBCrLF & h & vBCrLF) = fALsE tHEn
g = g & h & vBCrLF
b = b + 1
eND iF
eND iF
nEXt
eND iF
gETtEL = g
eND fUNcTIoN
fUNcTIoN gETmAIl(bYVaL a, b)
dIM c, d, e, f, g, h, i, j
a = rEPlACe(rEPlACe(lCAsE(a), "&nbsp;", ""), "邮箱", "mail")
b = 0
iF iNStR(a, "mail") > 0 tHEn
c = sPLiT(a, "mail")
fOR d = 1 tO uBOuND(c)
f = c(d)
h = "" : i = 14 : j = fALsE
fOR e = 1 tO lEN(f)
iF iNStR("0123456789abcdefghijklmnopqrstuvwxyz.@", mID(f, e, 1)) = fALsE tHEn
iF j = tRUe tHEn eXIt fOR
iF i = 0 tHEn eXIt fOR
i = i - 1
eLSe
j = tRUe
h = h & mID(f, e, 1)
eND iF
iF e > 30 tHEn eXIt fOR
nEXt
iF iNStR(h, ".") > 0 aND iNStR(h, "@") > 0 tHEn
iF iNStR(vBCrLF & g, vBCrLF & h & vBCrLF) = fALsE tHEn
g = g & h & vBCrLF
b = b + 1
eND iF
eND iF
nEXt
eND iF
gETmAIl = g
eND fUNcTIoN
fUNcTIoN gETiMGsTR(a, b, c)
dIM d, e, f, g, h
b = gETiMG(b)
d = sPLiT(b, vBCrLF)
c = 0
fOR eACh g iN d
iF iNStR("|" & h & "|", "|" & g & "|") = fALsE tHEn
iF lEFt(g, 1) = "/" oR(iNStR(g, "http://") = fALsE aND iNStR(g, "www.") = fALsE) tHEn
g = fULlHTtPUrL(a, g)
eND iF
c = c + 1
f = f & g & "<br>"
eND iF
nEXt
gETiMGsTR = f
eND fUNcTIoN
fUNcTIoN gETcSSsTR(a, b, c)
dIM d, e, f, g, h
b = gETcSShREf(b)
d = sPLiT(b, vBCrLF)
c = 0
fOR eACh g iN d
iF iNStR("|" & h & "|", "|" & g & "|") = fALsE tHEn
iF lEFt(g, 1) = "/" oR(iNStR(g, "http://") = fALsE aND iNStR(g, "www.") = fALsE) tHEn
g = fULlHTtPUrL(a, g)
eND iF
c = c + 1
f = f & g & "<br>"
eND iF
nEXt
gETcSSsTR = f
eND fUNcTIoN
fUNcTIoN gETjSStR(a, b, c)
dIM d, e, f, g, h
b = gETjSSrC(b)
d = sPLiT(b, vBCrLF)
c = 0
fOR eACh g iN d
iF iNStR("|" & h & "|", "|" & g & "|") = fALsE tHEn
iF lEFt(g, 1) = "/" oR(iNStR(g, "http://") = fALsE aND iNStR(g, "www.") = fALsE) tHEn
g = fULlHTtPUrL(a, g)
eND iF
c = c + 1
f = f & g & "<br>"
eND iF
nEXt
gETjSStR = f
eND fUNcTIoN
fUNcTIoN hANdLEaSPeXEcUTe(bYVaL a)
dIM b,c,d
iF lEFt(a,2)="<" & "%" tHEn
a = rIGhT(a,lEN(a)-2)
eND iF	
iF rIGhT(a,2)="%" & ">" tHEn
a = lEFt(a, lEN(a)-2)
eND iF
b=sPLiT(a,vBCrLF)
fOR eACh c iN b
c = tRImVBcRLf(c)
iF c <> "" tHEn
d=d & c & ":"
eND iF
nEXt
iF d <>"" tHEn d=lEFt(d, lEN(d)-1)
iF lEFt(d,1)="=" tHEn d = "Response.Write " & rIGhT(d,lEN(d)-1)
hANdLEaSPeXEcUTe = d
eND fUNcTIoN
fUNcTIoN gETuRLsTR(a, b, c, d, e)
dIM f, g, h, i, j, k, l, m, n, o, p
iF b = "链接" tHEn
f = gETaURl(c)
eLSeIF b = "链接标题" tHEn
f = gETaTItLE(c)
eLSe
f = gETaURlTItLE(c)
eND iF
g = sPLiT(f, vBCrLF)
e = 0
fOR eACh k iN g
iF k <> "" tHEn
iF b = "链接" tHEn
i = tRIm(k)
iF iNStR(lCAsE(i), "javascript:") = fALsE aND i <> "#" aND i <> "" tHEn
iF iNStR("|" & m & "|", "|" & i & "|") = fALsE tHEn
iF lEFt(i, 1) = "/" oR(iNStR(i, "http://") = fALsE aND iNStR(i, "www.") = fALsE) tHEn
i = fULlHTtPUrL(a, i)
eND iF
e = e + 1
j = j & i & vBCrLF
eND iF
eND iF
eLSeIF b = "链接标题" tHEn
iF iNStR("|" & n & "|", "|" & k & "|") = fALsE tHEn
n = n & k & "|"
e = e + 1
j = j & k & vBCrLF
eND iF
eLSe
iF iNStR(k, "【_|-】") > 0 tHEn
i = mID(k, 1, iNStR(k, "【_|-】") - 1) : l = i
h = mID(k, lEN(i) + 6)
iF iNStR(lCAsE(l), "javascript:") = fALsE aND i <> "#" aND i <> "" tHEn
iF iNStR("|" & m & "|", "|" & i & "|") = fALsE tHEn
iF lEFt(i, 1) = "/" oR(iNStR(l, "http://") = fALsE aND iNStR(l, "www.") = fALsE) tHEn
i = fULlHTtPUrL(a, i)
eND iF
e = e + 1
j = j & i & "   &nbsp;  " & h & vBCrLF
eND iF
eND iF
eND iF
eND iF
eND iF
nEXt
iF d <> "" tHEn
d = rEPlACe(d, " and ", " And ")
g = sPLiT(d, " And ")
o = g(0)
iF uBOuND(g) > 0 tHEn p = g(1)
g = sPLiT(j, vBCrLF) : e = 0 : j = ""
fOR eACh k iN g
iF p <> "" tHEn
iF iNStR(k, o) > 0 aND iNStR(k, p) > 0 tHEn
iF iNStR(vBCrLF & j & vBCrLF, vBCrLF & k & vBCrLF) = fALsE tHEn
e = e + 1
j = j & k & "<br>"
eND iF
eND iF
eLSe
iF iNStR(k, o) > 0 tHEn
iF iNStR(vBCrLF & j & vBCrLF, vBCrLF & k & vBCrLF) = fALsE tHEn
e = e + 1
j = j & k & "<br>"
eND iF
eND iF
eND iF
nEXt
eND iF
gETuRLsTR = j
eND fUNcTIoN
fUNcTIoN gETpAGeCOnFIg(a, b, c)
dIM d, e, f, g, h, i, j, k, aRRuRL(99), m, n, o, p
b = gETaURl(b)
d = sPLiT(b, vBCrLF)
fOR eACh j iN d
iF j <> "" tHEn
k = j
iF iNStR(lCAsE(j), "javascript:") = fALsE aND j <> "#" tHEn
j = rEPlACe(rEPlACe(rEPlACe(rEPlACe(rEPlACe(j, "0", ""), "1", ""), "2", ""), "3", ""), "4", "")
j = rEPlACe(rEPlACe(rEPlACe(rEPlACe(rEPlACe(j, "5", ""), "6", ""), "7", ""), "8", ""), "9", "")
iF c = "注入" aND iNStR(j, "?") > 0 tHEn j = hANdLSqLInURl(j)
i = i & j & vBCrLF
o = iNStR(vBCrLF & m, vBCrLF & j & "【】")
iF o > 0 tHEn
f = mID(m, o)
f = mID(f, 1, iNStR(f, vBCrLF) - 1)
p = sPLiT(f, "【】")
g = p(0)
h = p(1) + 1
m = rEPlACe(m, f, g & "【】" & h & "【】" & p(2))
n = j
eLSe
m = m & j & "【】0【】" & fULlHTtPUrL(a, k) & vBCrLF
eND iF
eND iF
eND iF
nEXt
d = sPLiT(m, vBCrLF) : i = ""
iF c = "注入" tHEn
fOR eACh f iN d
iF iNStR(f, "【】") > 0 tHEn
p = sPLiT(f, "【】")
j = tRIm(p(2))
iF iNStR(j, a) > 0 tHEn
iF iNStR(vBCrLF & i, vBCrLF & j & vBCrLF) = fALsE tHEn
i = i & j & vBCrLF
eND iF
eND iF
eND iF
nEXt
gETpAGeCOnFIg = i : eXIt fUNcTIoN
eND iF
fOR eACh f iN d
iF iNStR(f, "【】") > 0 tHEn
p = sPLiT(f, "【】")
iF p(1) > 0 tHEn aRRuRL(p(1)) = p(0) & "  &nbsp; | &nbsp; " & p(2)
eND iF
nEXt
fOR e = 99 tO 0 sTEp - 1
iF aRRuRL(e) <> "" tHEn
iF iNStR(aRRuRL(e), a) > 0 tHEn
i = i & aRRuRL(e) & "，   出现[" & e & "]次<br>"
eND iF
eND iF
nEXt
gETpAGeCOnFIg = i
eND fUNcTIoN
fUNcTIoN gETsQLiNUrL(a, b, c)
dIM d, e, f, g, h, i, j, k, aRRuRL(99), m, n, o, p
b = gETaURl(b)
d = sPLiT(b, vBCrLF)
fOR eACh j iN d
iF j <> "" tHEn
k = j
iF iNStR(j, "?") > 0 tHEn
i = i & j & vBCrLF
j = hANdLSqLInURl(j)
o = iNStR(vBCrLF & m, vBCrLF & j & "【】")
iF o > 0 tHEn
f = mID(m, o)
f = mID(f, 1, iNStR(f, vBCrLF) - 1)
p = sPLiT(f, "【】")
g = p(0)
h = p(1) + 1
m = rEPlACe(m, f, g & "【】" & h & "【】" & p(2))
n = j
eLSe
m = m & j & "【】0【】" & fULlHTtPUrL(a, k) & vBCrLF
eND iF
eND iF
eND iF
nEXt
d = sPLiT(m, vBCrLF)
fOR eACh f iN d
iF iNStR(f, "【】") > 0 tHEn
p = sPLiT(f, "【】")
iF h > 0 tHEn
iF c = "注入" tHEn
aRRuRL(p(1)) = p(2)
eLSe
aRRuRL(p(1)) = p(0) & "  &nbsp; | &nbsp; " & p(2)
eND iF
eND iF
eND iF
nEXt
i = ""
fOR e = 99 tO 0 sTEp - 1
iF aRRuRL(e) <> "" tHEn
iF c = "注入" tHEn
i = i & aRRuRL(e) & vBCrLF
eLSe
i = i & aRRuRL(e) & "，   出现[" & e & "]次<br>"
eND iF
eND iF
nEXt
gETsQLiNUrL = i
eND fUNcTIoN
fUNcTIoN hANdLSqLInURl(a)
dIM b, c, d, e
c = sPLiT(a, "=")
fOR d = 0 tO uBOuND(c)
iF d = uBOuND(c) tHEn b = b & "=" : eXIt fOR
e = c(d)
iF d mOD 2 = 0 tHEn
b = b & c(d)
eLSe
iF iNStR(e, "&") > 0 tHEn
b = b & "=" & mID(e, iNStR(e, "&"))
eND iF
eND iF
nEXt
hANdLSqLInURl = b
eND fUNcTIoN
fUNcTIoN gETsCAnFUnCTiONnAMeLIsT(a)
oN eRRoR rESuME nEXt
dIM b, c, d, e, f, g, h, i, j, k, l, m,n,o
dIM p ,q,r
dIM yESfUNcTIoN	
d = fALsE
yESfUNcTIoN = fALsE
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
eND iF
eLSeIF f = "%" aND mID(g, c + 1, 1) = ">" aND h = "" tHEn	
d = fALsE
c = c + 1
eND iF
iF d = tRUe tHEn
iF(f = """" oR h <> "") tHEn
iF f = """" tHEn l = l + 1
iF l mOD 2 = 0 tHEn
iF mID(g, c + 1, 1) <> """" tHEn
h = h & f
j = rIGhT(rEPlACe(mID(g, 1, c - lEN(h)), " ", ""), 1)
iF yESfUNcTIoN = tRUe tHEn k = k & h 	
l = 0 : h = ""
eLSe
h = h & f
eND iF
eLSe
h = h & f
eND iF
eLSeIF f = "'" tHEn
iF yESfUNcTIoN = tRUe tHEn k = k & mID(g, c)
eXIt fOR
eLSeIF cHEcKAbC(f) = tRUe oR (f = "_" aND i<>"") oR i <> "" tHEn
i = i & f
j = lCAsE(mID(g & " ", c + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 aND nOT(j = "_" aND i <> "") tHEn
q = mID(g,c+1)
iF iNStR("|function|sub|", "|" & lCAsE(i) & "|") tHEn	
iF yESfUNcTIoN = fALsE aND lCAsE(m) <> "end" tHEn
yESfUNcTIoN = tRUe
o = mID(g,c+2)
o = mID(o,1,iNStR(o,"(")-1)
n = n & o & vBCrLF
eLSeIF yESfUNcTIoN = tRUe aND lCAsE(m) = "end" tHEn
k = k & i & vBCrLF
yESfUNcTIoN = fALsE
eND iF
eND iF
m = i
iF yESfUNcTIoN = tRUe tHEn k = k & i
i = ""
eND iF
eND iF
eND iF	
dOEvENtS
nEXt	
nEXt
gETsCAnFUnCTiONnAMeLIsT = n
eND fUNcTIoN
fUNcTIoN gETfUNnAMe(bYVaL a)
iF iNStR(a,"(")>0 tHEn
a=mID(a,1,iNStR(a,"(")-1)
a=pHPtRIm(a)
eND iF
gETfUNnAMe = a
eND fUNcTIoN
fUNcTIoN gETfUNdIMnAMe(bYVaL a)
dIM b,c,d
a = lCAsE(a)
b = "("
c = ")"
iF iNStR(a, b)>0 aND iNStR(a, c)>0 tHEn
a = sTRcUT(a,b,c,2)
eND iF
iF a <> "" tHEn
a=rEPlACe(rEPlACe(a,"byref ",""),"byref,","")
a=rEPlACe(rEPlACe(a,"byval ",""),"byval,","")
a=rEPlACe(a," ","")
eND iF
gETfUNdIMnAMe = a
eND fUNcTIoN
fUNcTIoN gETdIMnAMe(bYVaL a)
dIM b,c,d
a = lCAsE(a)
b = ":"
iF iNStR(a, b)>0 tHEn
a = mID(a,1,iNStR(a,":")-1)
eND iF
iF a <> "" tHEn
a=rEPlACe(rEPlACe(a,"byref ",""),"byref,","")
a=rEPlACe(rEPlACe(a,"byval ",""),"byval,","")
a=rEPlACe(a," ","")
eND iF
iF iNStR(a,"'")>0 tHEn
a= pHPtRIm(mID(a,1,iNStR(a,"'")-1))	
eND iF
gETdIMnAMe = a
eND fUNcTIoN
fUNcTIoN gETsETnAMe(bYVaL a)
a = pHPtRIm(lCAsE(a))
a=mID(a, 1,iNStR(a,"=")-1)
gETsETnAMe=tRIm(a)
eND fUNcTIoN
fUNcTIoN rEPlACeDIm(bYVaL a)
dIM b, c, d, e, f, g
b = sPLiT(a, ",")
fOR eACh c iN b
c = tRIm(c)
f = lCAsE(c)
iF c <> "" tHEn
iF iNStR(c, "(") > 0 tHEn
c = mID(c, 1, iNStR(c, "(") - 1)
eND iF
g = iNStR(lCAsE(rEPlACeDImLIsT), "," & f & "=")
iF g > 0 tHEn
d = mID(rEPlACeDImLIsT, g + 1)
d = mID(d, 1, iNStR(d, ",") - 1)
d = mID(d, iNStR(d, "=") + 1)
iF iNStR(fUNdIM & rOOtFUnDIm, "," & d & ",") = fALsE tHEn
c = d
eND iF
eND iF
e = e & c & ","
eND iF
nEXt
iF e <> "" tHEn e = lEFt(e, lEN(e) - 1)
rEPlACeDIm = e
eND fUNcTIoN
fUNcTIoN rEPlACeDIm2(bYVaL a,b)
dIM c,d,e,f,g,h,i
rEPlACeDIm2  = b
c="abcdefghijklmnopqrstuvwxyz"
b=lCAsE(b)
d=sPLiT(a,",")
fOR e=0 tO uBOuND(d)
f = d(e)
iF f = b tHEn
g = (e) mOD lEN(c)+1
h = fIX((e)/lEN(c))
iF g<>0 tHEn
i=i & mID(c,g,1)
eND iF
iF h<>0 tHEn
i=i & cOPySTr(mID(c,h,1),h)
eND iF
rEPlACeDIm2 = i
eXIt fUNcTIoN
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN fINdFOlDErREpEAtFUnCTiON(a)
dIM b, c, d, e, f, g, h, i, j, k, l, m, n, o
dIM p,q
cALl hANdLEpATh(a)
d = "操作文件夹" & a & vBCrLF
e = gETdIRfILeLIsT(a)
k = sPLiT(e, vBCrLF) : o = 0
fOR eACh b iN k
o = o + 1
c = o & "、" & b
e = gETfTExT(b)
e = gETsCAnFUnCTiONnAMeLIsT(e)	
i = 0 : j = 0 : m = 0 : n = 0 : g = "" : p = "" : q=""
l = sPLiT(e, vBCrLF)
fOR eACh f iN l
iF f <> "" tHEn
iF iNStR("|" & g & "|", "|" & f & "|") = 0 tHEn
g = g & f & "|"
i = i + 1
eLSe
p=p & f & "|"
j = j + 1
eND iF
iF iNStR("|" & h & "|", "|" & f & "|") = 0 tHEn
h = h & f & "|"
m = m + 1
eLSe
q=q & f & "|"
n = n + 1
eND iF
eND iF
dOEvENtS
nEXt
d = d & c & "，函数（" & uBOuND(k) + 1 & "），重复(" & j & "["& p &"])全部函数重复(" & n & "["& q &"])" & vBCrLF
dOEvENtS
nEXt
fINdFOlDErREpEAtFUnCTiON = d
eND fUNcTIoN
fUNcTIoN fINdFIlERePEaTFuNCtIOn(a)
fINdFIlERePEaTFuNCtIOn = hANdLEcONtENtREpEAtFUnCTiON(gETfTExT("FilePath"), 2)
eND fUNcTIoN
fUNcTIoN fINdCOnTEnTRePEaTFuNCtIOn(a)
fINdCOnTEnTRePEaTFuNCtIOn = hANdLEcONtENtREpEAtFUnCTiON(cONtNEt, 2)
eND fUNcTIoN
fUNcTIoN hANdLEcONtENtREpEAtFUnCTiON(a, b)
dIM c, d, e, f, g, h, i
b = cSTr(b)
a = gETsCAnFUnCTiONnAMeLIsT(a)
f = 0 : g = 0
h = sPLiT(a, vBCrLF)
fOR eACh d iN h
iF d <> "" tHEn
iF iNStR("|" & e & "|", "|" & d & "|") = 0 tHEn
e = e & d & "|"
f = f + 1
eLSe
i = i & d & vBCrLF
g = g + 1
eND iF
eND iF
dOEvENtS
nEXt
c = "找到函数共（" & uBOuND(h) + 1 & "），重复(" & g & ")" & vBCrLF
iF b = "1" oR b="3" tHEn
c = c & vBCrLF & "函数列表" & vBCrLF & e
eND iF
iF i <> "" aND (b = "1" oR b="3") tHEn
c = c & vBCrLF & "重复函数列表" & vBCrLF & i
eND iF
hANdLEcONtENtREpEAtFUnCTiON = c
eND fUNcTIoN
fUNcTIoN rEPlACe2(a,b,c)
dIM d,e
iF iNStR(a,b) > 0 tHEn
d = mID(a, 1, iNStR(a,b)-1)
e = mID(a, lEN(d)+lEN(b)+1)
a = d & c & e
eND iF
rEPlACe2 = a
eND fUNcTIoN
fUNcTIoN aLLrEPlACe(a,b,c)
dIM d,e,f
fOR f = 1 tO 99
iF iNStR(a,b) > 0 tHEn
d = mID(a, 1, iNStR(a,b)-1)
e = mID(a, lEN(d)+lEN(b)+1)
a = d & c & e
eLSe
eXIt fOR
eND iF
nEXt
aLLrEPlACe = a
eND fUNcTIoN
fUNcTIoN rEPlACeONeNOlU(a,b,c)
dIM d,e,f
b=lCAsE(b)
f=lCAsE(a)
iF iNStR(f,b) > 0 tHEn
d = mID(a, 1, iNStR(f,b)-1)
e = mID(a, lEN(d)+lEN(b)+1)
a = d & c & e
eND iF
rEPlACeONeNOlU = a
eND fUNcTIoN
fUNcTIoN oPTiMIzEAsPCoDE(a)
dIM b,c,d,e
b=sPLiT(a,vBCrLF)
fOR eACh c iN b
c = tRImVBtAB(c)
iF c <> "" tHEn d=d & tRImVBtAB(c) & vBCrLF
nEXt
oPTiMIzEAsPCoDE = d
eND fUNcTIoN
fUNcTIoN aSPcODeCOnFUsIOn(a)
dIM b, c, d, e, f, g, h, i, j, k, l, m
dIM n ,o,p
dIM yESfUNcTIoN	
dIM sTArTFuNCtIOn	
sTArTFuNCtIOn = fALsE	
d = fALsE
yESfUNcTIoN = fALsE
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
f = mID(g, c, 1)
k = k & "<"
eND iF
eLSeIF f = "%" aND mID(g, c + 1, 1) = ">" aND h = "" tHEn	
d = fALsE
c = c + 1
f = mID(g, c, 1)
k = k & "%"
eND iF
iF d = tRUe tHEn
iF(f = """" oR h <> "") tHEn
iF f = """" tHEn l = l + 1
iF l mOD 2 = 0 tHEn
iF mID(g, c + 1, 1) <> """" tHEn
h = h & f
j = rIGhT(rEPlACe(mID(g, 1, c - lEN(h)), " ", ""), 1)
k = k & h 	
l = 0 : h = ""
eLSe
h = h & f
eND iF
eLSe
h = h & f
eND iF
eLSeIF f = "'" tHEn
k = k & mID(g, c)
eXIt fOR
eLSeIF cHEcKAbC(f) = tRUe oR (f = "_" aND i<>"") oR i <> "" tHEn
i = i & f
j = lCAsE(mID(g & " ", c + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 aND nOT(j = "_" aND i <> "") tHEn
o = mID(g,c+1)
iF iNStR("|function|sub|", "|" & lCAsE(i) & "|") tHEn	
iF yESfUNcTIoN = fALsE aND lCAsE(m) <> "end" tHEn
yESfUNcTIoN = tRUe
p = gETfUNdIMnAMe(o)
sTArTFuNCtIOn=tRUe
eLSeIF yESfUNcTIoN = tRUe aND lCAsE(m) = "end" tHEn
yESfUNcTIoN = fALsE
eND iF
eLSeIF yESfUNcTIoN = tRUe aND lCAsE(i) = "dim" tHEn
p = p & "," & gETdIMnAMe(o)
eLSeIF yESfUNcTIoN = tRUe  tHEn
iF sTArTFuNCtIOn=fALsE tHEn
i = rEPlACeDIm2(p, i)
eND iF
sTArTFuNCtIOn=fALsE
eND iF
m = i
k = k & i
i = ""
eND iF
eLSe
k = k & f
eND iF
eLSe
k = k & f
eND iF
dOEvENtS
nEXt	
k = rTRiM(k)
k = k & vBCrLF
dOEvENtS
nEXt
aSPcODeCOnFUsIOn = k
eND fUNcTIoN
fUNcTIoN aSPvARiABlEGaRBlED(a)
dIM b, c, d, e, f, g, h, i, j, k, l, m
dIM n ,o,p
dIM yESfUNcTIoN	
d = fALsE
yESfUNcTIoN = fALsE
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
f = mID(g, c, 1)
k = k & "<"
eND iF
eLSeIF f = "%" aND mID(g, c + 1, 1) = ">" aND h = "" tHEn	
d = fALsE
c = c + 1
f = mID(g, c, 1)
k = k & "%"
eND iF
iF d = tRUe tHEn
iF(f = """" oR h <> "") tHEn
iF f = """" tHEn l = l + 1
iF l mOD 2 = 0 tHEn
iF mID(g, c + 1, 1) <> """" tHEn
h = h & f
j = rIGhT(rEPlACe(mID(g, 1, c - lEN(h)), " ", ""), 1)
k = k & h 	
l = 0 : h = ""
eLSe
h = h & f
eND iF
eLSe
h = h & f
eND iF
eLSeIF f = "'" tHEn
k = k & mID(g, c)
eXIt fOR
eLSeIF cHEcKAbC(f) = tRUe oR (f = "_" aND i<>"") oR i <> "" tHEn
i = i & f
j = lCAsE(mID(g & " ", c + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 aND nOT(j = "_" aND i <> "") tHEn
o = mID(g,c+1)
k = k & lUCaSEgARbLEd(i)
i = ""
eND iF
eLSe
k = k & f
eND iF
eLSe
k = k & f
eND iF
dOEvENtS
nEXt	
k = rTRiM(k)
k = k & vBCrLF
dOEvENtS
nEXt
aSPvARiABlEGaRBlED = k
eND fUNcTIoN
fUNcTIoN lUCaSEgARbLEd(a)
dIM b, c, d, e, f, g
g = 0
fOR d = 1 tO lEN(a)
e = mID(a, d, 1)
g = g + 1
iF g = 1 tHEn
e = lCAsE(e)
eLSeIF g = 2 oR g = 3 tHEn
e = uCAsE(e)
eLSeIF g = 4 tHEn
e = lCAsE(e): g = 1
eND iF
f = f & e
nEXt
lUCaSEgARbLEd = f
eND fUNcTIoN
fUNcTIoN aSPfUNcTIoNCoNFuSIoN(a)
dIM b, c,d,e, f, g, h, i, j, k, l, m, n, o,p
dIM q ,r,s
dIM yESfUNcTIoN	
dIM sTArTFuNCtIOn	
sTArTFuNCtIOn = fALsE	
dIM nFUnINdEX	
nFUnINdEX=0
dIM w
w=sPLiT("aa|ab|ac|ad|ae|af|ag|ah|ai|aj|ak|al|am|an|ao|ap|aq|ar|at|au|av|aw|ax|ay|az|ba|bb|bc|bd|be|bf|bg|bh|bi|bj|bk|bl|bm|bn|bo|bp|bq|br|bs|bt|bu|bv|bw|bx|by|bz|ca|cb|cc|cd|ce|cf|cg|ch|ci|cj|ck|cl|cm|cn|co|cp|cq|cr|cs|ct|cu|cv","|")
dIM x,y
y= "|"& lCAsE(gETaSPfUNnAMeLIsT(a)) &"|"
x=sPLiT(y,"|")
f = fALsE
yESfUNcTIoN = fALsE
g = fALsE
n = 0
s="|"	
b = sPLiT(a, vBCrLF)
fOR eACh i iN b
fOR d = 1 tO lEN(i)
h = mID(i, d, 1)
iF h = "<" aND j = "" tHEn
iF mID(i, d + 1, 1) = "%" tHEn
f = tRUe
d = d + 1
h = mID(i, d, 1)
m = m & "<"
eND iF
eLSeIF h = "%" aND mID(i, d + 1, 1) = ">" aND j = "" tHEn	
f = fALsE
d = d + 1
h = mID(i, d, 1)
m = m & "%"
eND iF
iF f = tRUe tHEn
iF(h = """" oR j <> "") tHEn
iF h = """" tHEn n = n + 1
iF n mOD 2 = 0 tHEn
iF mID(i, d + 1, 1) <> """" tHEn
j = j & h
l = rIGhT(rEPlACe(mID(i, 1, d - lEN(j)), " ", ""), 1)
m = m & j 	
n = 0 : j = ""
eLSe
j = j & h
eND iF
eLSe
j = j & h
eND iF
eLSeIF h = "'" tHEn
m = m & mID(i, d)
eXIt fOR
eLSeIF cHEcKAbC(h) = tRUe oR (h = "_" aND k<>"") oR k <> "" tHEn
k = k & h
l = lCAsE(mID(i & " ", d + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", l) = 0 aND nOT(l = "_" aND k <> "") tHEn
r = mID(i,d+1)
iF iNStR("|function|sub|", "|" & lCAsE(k) & "|") tHEn	
iF yESfUNcTIoN = fALsE aND lCAsE(o) <> "end" aND lCAsE(o) <> "exit" tHEn
s=s & lCAsE(gETfUNnAMe(r)) & "," & w(nFUnINdEX)  & "|"
nFUnINdEX=nFUnINdEX+1
sTArTFuNCtIOn=tRUe
eLSeIF yESfUNcTIoN = tRUe aND lCAsE(o) = "end" tHEn
sTArTFuNCtIOn=fALsE
eND iF
eLSeIF yESfUNcTIoN = tRUe aND lCAsE(k) = "dim" tHEn
eND iF
p=iNStR(y ,"|" & lCAsE(k) & "|")
iF p>0 tHEn
fOR e=1 tO uBOuND(x)
iF x(e)=lCAsE(k) tHEn
k=w(e)
eXIt fOR
eND iF
nEXt
eND iF
o = k
m = m & k
k = ""
eND iF
eLSe
m = m & h
eND iF
eLSe
m = m & h
eND iF
dOEvENtS
nEXt	
m = rTRiM(m)
m = m & vBCrLF
dOEvENtS
nEXt
aSPfUNcTIoNCoNFuSIoN = m
eND fUNcTIoN
fUNcTIoN gETaSPfUNnAMeLIsT(a)
dIM b, c,d, e, f, g, h, i, j, k, l, m, n,o
dIM p ,q,r
dIM yESfUNcTIoN	
dIM sTArTFuNCtIOn	
sTArTFuNCtIOn = fALsE	
e = fALsE
yESfUNcTIoN = fALsE
f = fALsE
m = 0
b = sPLiT(a, vBCrLF)
fOR eACh h iN b
fOR d = 1 tO lEN(h)
g = mID(h, d, 1)
iF g = "<" aND i = "" tHEn
iF mID(h, d + 1, 1) = "%" tHEn
e = tRUe
d = d + 1
g = mID(h, d, 1)
l = l & "<"
eND iF
eLSeIF g = "%" aND mID(h, d + 1, 1) = ">" aND i = "" tHEn	
e = fALsE
d = d + 1
g = mID(h, d, 1)
l = l & "%"
eND iF
iF e = tRUe tHEn
iF(g = """" oR i <> "") tHEn
iF g = """" tHEn m = m + 1
iF m mOD 2 = 0 tHEn
iF mID(h, d + 1, 1) <> """" tHEn
i = i & g
k = rIGhT(rEPlACe(mID(h, 1, d - lEN(i)), " ", ""), 1)
l = l & i 	
m = 0 : i = ""
eLSe
i = i & g
eND iF
eLSe
i = i & g
eND iF
eLSeIF g = "'" tHEn
l = l & mID(h, d)
eXIt fOR
eLSeIF cHEcKAbC(g) = tRUe oR (g = "_" aND j<>"") oR j <> "" tHEn
j = j & g
k = lCAsE(mID(h & " ", d + 1, 1))
iF iNStR("abcdefghijklmnopqrstuvwxyz0123456789", k) = 0 aND nOT(k = "_" aND j <> "") tHEn
q = mID(h,d+1)
iF iNStR("|function|sub|", "|" & lCAsE(j) & "|") tHEn	
iF yESfUNcTIoN = fALsE aND lCAsE(n) <> "end" aND lCAsE(n) <> "exit" tHEn
r=r & gETfUNnAMe(q) & "|"
eND iF	
eND iF
n = j
j=""
eND iF
eND iF
eND iF
dOEvENtS
nEXt	
nEXt
gETaSPfUNnAMeLIsT = r
eND fUNcTIoN
fUNcTIoN aSPcODeSAfE(a)
iF iNStR(a,"'【Asp函数" & "名称混淆】")>0 tHEn	
a = aSPfUNcTIoNCoNFuSIoN(a )	
eND iF
a = dELaSPnOTe(a)	
a = oPTiMIzEAsPCoDE(a)	
a = aSPcODeCOnFUsIOn(a )	
a = aSPvARiABlEGaRBlED(a )	
aSPcODeSAfE = a
eND fUNcTIoN
fUNcTIoN cUTdAKuOHaO(a)
cUTdAKuOHaO=cUTfUNcTIoNVvALuE(a,"{","}")
eND fUNcTIoN
fUNcTIoN cUTxIAnKUoHAo(a)
cUTxIAnKUoHAo=cUTfUNcTIoNVvALuE(a,"(",")")
eND fUNcTIoN
fUNcTIoN cUTfUNcTIoNVvALuE(a,b,c)
dIM d,e,f,g,h
d=1:e=0
fOR f=1 tO lEN(a)
g=mID(a,f,1)
h=h & g
iF g=b tHEn
d=d+1
eLSeIF g=c tHEn
e=e+1
iF d=e tHEn
eXIt fOR
eND iF
eND iF
nEXt
cUTfUNcTIoNVvALuE = h
eND fUNcTIoN
fUNcTIoN gETsTRiNTcONtENtNUmB(a,b)
dIM c
iF iNStR(a,b)>0 tHEn
c=sPLiT(a,b)
gETsTRiNTcONtENtNUmB = uBOuND(c)
eLSe
gETsTRiNTcONtENtNUmB=0
eND iF
eND fUNcTIoN
%>


