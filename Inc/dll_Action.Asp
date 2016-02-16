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
oPTiON eXPlICiT
dIM c
c="{$getLableValue title='标题 now()'content=""len(now())""$}"
cALl rW(hANdLEaCTiON(c))
fUNcTIoN hANdLEaCTiON(a)
dIM b, c, d, e, f, g, h
b = "{\$" : c = "\$}"
d = gETaRRaY(a, b, c, tRUe, tRUe)
e = sPLiT(d, "$Array$")
fOR eACh g iN e
f = tRIm(g)
iF f <> "" tHEn
f = tRIm(mID(f,3,lEN(f)-4)) & " "
h = tRUe
iF cHEcKFuNVaLUe(f, "# ") = tRUe tHEn
f = ""
eLSeIF cHEcKFuNVaLUe(f, "getLableValue ") = tRUe tHEn
f = xY_gETlABlEVaLUe(f)
eLSe
h = fALsE
eND iF
iF iSNuL(f) = tRUe tHEn f = ""
iF h = tRUe tHEn
a = rEPlACe(a, g, f)
eND iF
eND iF
nEXt
hANdLEaCTiON = a
eND fUNcTIoN
fUNcTIoN xY_gETlABlEVaLUe(a)
dIM b,c,d
b = rPArAM(a, "title")
c = rPArAM(a, "content")
d=d & "title=" & gETcONtENtRUnSTr(b) & "<hr>"
d=d & "content=" & gETcONtENtRUnSTr(c) & "<hr>"
xY_gETlABlEVaLUe = d
eND fUNcTIoN
fUNcTIoN rEPlACeVAlUEpARaM(a,b,c)
dIM d,e,f,g,h,i,j
iF iSNuL(c)=tRUe tHEn c=""
d="[$"& b : e = "$]"
iF iNStR(a,d)>0 aND iNStR(a,e)>0 tHEn
f = sTRcUT(a,d,e,1)
i = rPArAM(f,"DelHtml")	
iF i="true" tHEn c = rEPlACe(dELhTMl(c),"<","&lt;")	
j = rPArAM(f,"Trim")	
iF j="true" tHEn c = tRImVBcRLf(c)
g = rPArAM(f,"Len")	
g = hANdLEnUMbER(g)
iF g<>"" tHEn c = cUTsTR(c,g,"...")
h  = rPArAM(f,"Format_Time")	
iF h<>"" tHEn
c = fORmAT_TImE(c, h)
eND iF	
a = rEPlACe(a,f,c)
eND iF
rEPlACeVAlUEpARaM = a
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
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "DelHtml 删除HTML标签 函数出错，strHtml=" & a
eND fUNcTIoN
fUNcTIoN tRImVBcRLf(a)
tRImVBcRLf = rTRiMVbCRlF(lTRiMVbCRlF(a))
eND fUNcTIoN
fUNcTIoN hANdLEnUMbER(bYVaL a)
dIM b, c, d
d = ""
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF iNStR("0123456789", c) > 0 tHEn
d = d & c
eND iF
nEXt
hANdLEnUMbER = d
eND fUNcTIoN
fUNcTIoN cUTsTR(bYVaL a, bYVaL b, bYVaL c)
dIM d, e, f
f = 0
b = cINt(b)
iF c = "" tHEn c = "..."
iF lCAsE(c) = "none" oR lCAsE(c) = "null" tHEn c = ""
cUTsTR = a
fOR d = 1 tO lEN(a)
e = aSC(mID(cSTr(a), d, 1))
iF e < 0 tHEn e = e + 65536
iF e < 255 tHEn f = f + 1
iF e > 255 tHEn f = f + 2
iF f >= b tHEn cUTsTR = lEFt(a, d) & c : eXIt fUNcTIoN
nEXt
eND fUNcTIoN
fUNcTIoN fORmAT_TImE(a, b)
dIM c, d, e, f, g, h
fORmAT_TImE = ""
iF iSDaTE(a) = fALsE tHEn eXIt fUNcTIoN
c = cSTr(yEAr(a))
d = cSTr(mONtH(a))
iF lEN(d) = 1 tHEn d = "0" & d
e = cSTr(dAY(a))
iF lEN(e) = 1 tHEn e = "0" & e
f = cSTr(hOUr(a))
iF lEN(f) = 1 tHEn f = "0" & f
g = cSTr(mINuTE(a))
iF lEN(g) = 1 tHEn g = "0" & g
h = cSTr(sECoND(a))
iF lEN(h) = 1 tHEn h = "0" & h
sELeCT cASe b
cASe 1
fORmAT_TImE = c & "-" & d & "-" & e & " " & f & ":" & g & ":" & h
cASe 2
fORmAT_TImE = c & "-" & d & "-" & e
cASe 3
fORmAT_TImE = f & ":" & g & ":" & h
cASe 4
fORmAT_TImE = c & "年" & d & "月" & e & "日"
cASe 5
fORmAT_TImE = c & d & e
cASe 6
fORmAT_TImE = c & d & e & f & g & h
cASe 7
fORmAT_TImE = d & "-" & e
cASe 8
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & ":" & g & ":" & h
cASe 9
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒，" & gETdAYsTAtUS(f, 1)
cASe 10
fORmAT_TImE = c & "年" & d & "月" & e & "日" & f & "时"
cASe 11
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒"
cASe 12
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分"
cASe 13
fORmAT_TImE = d & "月" & e & "日" & " " & f & ":" & g & " " & gETdAYsTAtUS(f, 0)
cASe 14
fORmAT_TImE = c & "/" & d & "/" & e
cASe 15
fORmAT_TImE = c & "年" & d & "月 第" & gETcOUnTPaGE(e, 7) & "周"
eND sELeCT
eND fUNcTIoN
fUNcTIoN rTRiMVbCRlF(a)
dIM b, c
b = lEN(a)
c = tRUe
wHIlE c aND b >= 2
iF mID(a, b, 1) = " " oR mID(a, b, 1) = vBTaB tHEn
b = b - 1
eLSeIF mID(a, b - 1, 2) = vBCrLF tHEn
b = b - 2
eLSe
c = fALsE
eND iF
wENd
rTRiMVbCRlF = rTRiM(lEFt(a, b))
eND fUNcTIoN
fUNcTIoN lTRiMVbCRlF(a)
dIM b, c
b = 1
c = tRUe
wHIlE c
iF mID(a, b, 1) = " " oR mID(a, b, 1) = vBTaB tHEn
b = b + 1
eLSeIF mID(a, b, 2) = vBCrLF tHEn
b = b + 2
eLSe
c = fALsE
eND iF
wENd
lTRiMVbCRlF = rIGhT(a, lEN(a) - b + 1)
eND fUNcTIoN
fUNcTIoN gETdAYsTAtUS(a, b)
dIM c
iF lEFt(a, 1) = "0" tHEn
a = rIGhT(a, 1)
eND iF
a = cINt(a)
iF a >= 0 aND a <= 5 tHEn
c = "凌晨"
eLSeIF a >= 6 aND a <= 8 tHEn
c = "早上"
eLSeIF a >= 9 aND a <= 12 tHEn
c = "上午"
eLSeIF a >= 13 aND a <= 18 tHEn
c = "下午"
eLSeIF a >= 19 aND a <= 24 tHEn
c = "晚上"
eLSe
c = "深夜"
eND iF
iF b = 1 tHEn c = "<b>" & c & "</b>"
gETdAYsTAtUS = c
eND fUNcTIoN
fUNcTIoN gETcOUnTPaGE(a, b)
iF a < 0 tHEn
a = a * - 1
eND iF
iF b < 0 tHEn
b = b * - 1
eND iF
gETcOUnTPaGE = fIX(a / b)
iF iNStR(a / b, ".") > 0 tHEn gETcOUnTPaGE = gETcOUnTPaGE + 1
eND fUNcTIoN
fUNcTIoN eCHoPRoMPt(a, b)
rESpONsE.wRItE("<font color=Green>" & a & "</font>：" & b & "<br>")
eND fUNcTIoN
fUNcTIoN eCHo(a, b)
cALl eCHoPRoMPt(a, b)
eND fUNcTIoN
fUNcTIoN gETaRRaY(a, b, c, d, e)
gETaRRaY = gETaRRaYLiST(a, b, c, d, e, "")
eND fUNcTIoN
fUNcTIoN cHEcKFuNVaLUe(a, b)
cHEcKFuNVaLUe =(lEFt(a, lEN(b)) = b)
eND fUNcTIoN
fUNcTIoN iSNuL(bYVaL a)
oN eRRoR rESuME nEXt : iF eRR.nUMbER <> 0 tHEn eRR.cLEaR
iSNuL = fALsE
sELeCT cASe vARtYPe(a)
cASe vBEmPTy, vBNuLL
iSNuL = tRUe : eXIt fUNcTIoN
cASe vBStRInG
iF a = "" tHEn iSNuL = tRUe : eXIt fUNcTIoN
cASe vBObJEcT
sELeCT cASe tYPeNAmE(a)
cASe "Nothing", "Empty"
iSNuL = tRUe : eXIt fUNcTIoN
cASe "Recordset"
iF a.sTAtE = 0 tHEn iSNuL = tRUe : eXIt fUNcTIoN
iF a.bOF aND a.eOF tHEn iSNuL = tRUe : eXIt fUNcTIoN
cASe "Dictionary"
iF a.cOUnT = 0 tHEn iSNuL = tRUe : eXIt fUNcTIoN
eND sELeCT
cASe vBArRAy, 8194, 8204, 8209
iF uBOuND(a) = -1 tHEn iSNuL = tRUe : eXIt fUNcTIoN
eND sELeCT
oN eRRoR gOTo 0
eND fUNcTIoN
fUNcTIoN gETaRRaYLiST(bYVaL a, bYVaL b, bYVaL c, bYVaL d, bYVaL e, bYVaL f)
iF iSNuLL(a) = tRUe oR iSNuLL(b) = tRUe oR iSNuLL(c) = tRUe tHEn
gETaRRaYLiST = ""
eXIt fUNcTIoN
eND iF
dIM g, h, i, j
a = rEPlACe(rEPlACe(a, cHR(10), "【换行】"), cHR(13), "【换行】")
sET h = cREaTEoBJeCT("VBscript.RegExp")
h.iGNoREcASe = tRUe
h.gLObAL = tRUe
h.pATtERn = "(" & b & ").+?(" & c & ")"
sET i = h.eXEcUTe(a)
fOR eACh j iN i
g = g & "$Array$" & j.vALuE
nEXt
sET i = nOThINg
iF g = "" tHEn
gETaRRaYLiST = ""
eXIt fUNcTIoN
eND iF
g = rIGhT(g, lEN(g) - 7)
iF d = fALsE tHEn
h.pATtERn = b
g = h.rEPlACe(g, "")
eND iF
iF e = fALsE tHEn
h.pATtERn = c
g = h.rEPlACe(g, "")
eND iF
sET h = nOThINg
iF f = "1" oR f = "去掉字符" oR f = tRUe tHEn
g = rEPlACe(g, """", "")
g = rEPlACe(g, "'", "")
g = rEPlACe(g, " ", "")
g = rEPlACe(g, "(", "")
g = rEPlACe(g, ")", "")
eND iF
gETaRRaYLiST = g
eND fUNcTIoN
fUNcTIoN rPArAM(bYVaL a, bYVaL b)
dIM c
c = hANdLErPArAM(a, b, "'")
iF c = "" tHEn
c = hANdLErPArAM(a, b, """")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, b, "")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, lCAsE(b), "'")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, lCAsE(b), """")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, lCAsE(b), "")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, uCAsE(b), "'")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, uCAsE(b), """")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, uCAsE(b), "")
eND iF	
rPArAM = c
eND fUNcTIoN
fUNcTIoN hANdLErPArAM(bYVaL a, bYVaL b, bYVaL c)
dIM d,e
e = iIF(c<>"",c," ")
a = vBCrLF & " " & a
d = " " & b
iF iNStR(a, d & "=" & c) = fALsE tHEn
d = "'" & b
eND iF
iF iNStR(a, d & "=" & c) = fALsE tHEn
d = """" & b
eND iF
iF iNStR(a, d & "=" & c) = fALsE tHEn
d = vBTaB & b
eND iF
iF iNStR(a, d & "=" & c) = fALsE tHEn
d = vBCrLF & b
eND iF
iF iNStR(a, d & "=" & c) > 0 aND iNStR(a, e) > 0 tHEn
hANdLErPArAM = sTRcUT(a, d & "=" & c, e, 2)
hANdLErPArAM = hANdLEiNMoDUlE(hANdLErPArAM, "end")
iF iNStR(hANdLErPArAM, "{$") > 0 aND iNStR(hANdLErPArAM, "$}") > 0 tHEn
hANdLErPArAM = hANdLEaCTiON(hANdLErPArAM)
eND iF
eND iF
eND fUNcTIoN
fUNcTIoN iIF(a, b, c)
iF(a) tHEn iIF = b eLSe iIF = c
eND fUNcTIoN
fUNcTIoN sTRcUT(bYVaL a, bYVaL b, bYVaL c, bYVaL d)
oN eRRoR rESuME nEXt
dIM e, f, g
sELeCT cASe d
cASe 1
e = iNStR(a, b)
f = iNStR(e, a, c) + lEN(c)
cASe 2, 0, ""
e = iNStR(a, b) + lEN(b)
f = iNStR(e, a, c)
eND sELeCT
g = f - e
iF g >= 0 tHEn
sTRcUT = mID(a, e, g)
eLSe
sTRcUT = ""
eND iF
iF eRR <> 0 tHEn cALl eERr(b, a)
eND fUNcTIoN
fUNcTIoN hANdLEiNMoDUlE(a, b)
b = lCAsE(cSTr(b))
iF b = "1" oR b = "start" tHEn
a = rEPlACe(a, "\'", "\|*|\")
a = rEPlACe(a, "\=", "\|&|\")
eLSeIF b = "2" oR b = "end" tHEn
a = rEPlACe(a, "\|*|\", "'")
a = rEPlACe(a, "\$", "$")
a = rEPlACe(a, "\}", "}")
a = rEPlACe(a, "\|&|\", "=")
eND iF
hANdLEiNMoDUlE = a
eND fUNcTIoN
fUNcTIoN eERr(a, b)
rESpONsE.wRItE("<font color=red>" & a & "</font>：" & b)
rESpONsE.eND()
eND fUNcTIoN
fUNcTIoN rW(a)
rESpONsE.wRItE(a)
eND fUNcTIoN
fUNcTIoN gETfTExT(a)
gETfTExT = gETfILeTExT(a)
eND fUNcTIoN
fUNcTIoN gETfILeTExT(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c, d
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("Scripting.FileSystemObject")
iF b.fILeEXiSTs(a) = tRUe tHEn
sET c = b.oPEnTExTFiLE(a, 1)
sET d = b.gETfILe(a)
iF d.sIZe = 0 tHEn eXIt fUNcTIoN
sET d = nOThINg
gETfILeTExT = c.rEAdALl
sET c = nOThINg
eND iF
sET b = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "GetFileText 读取文件内容 函数出错，FileName=" & a
eND fUNcTIoN
fUNcTIoN hANdLEpATh(a)
a = rEPlACe(a, "/", "\")
a = rEPlACe(a, "\\", "\")
a = rEPlACe(a, "\\", "\")
dIM b
b = fALsE
iF rIGhT(a, 1) = "\" tHEn
b = tRUe
eND iF
iF iNStR(a, ":") = 0 tHEn
iF lEFt(a, 1) = "\" tHEn
a = sERvER.mAPpATh("\") & "\" & a
eLSe
a = sERvER.mAPpATh(".\") & "\" & a
eND iF
eND iF
a = rEPlACe(a, "/", "\")
a = rEPlACe(a, "\\", "\")
a = rEPlACe(a, "\\", "\")
a = fULlPAtH(a)
iF b = tRUe tHEn
a = a & "\"
eND iF
hANdLEpATh = a
eND fUNcTIoN
sUB dOErROr(a, b)
dIM c, d
rANdOMiZE
c = cLNg(rND() * 29252888)
d = "<br />"
d = d & "<div style=""width:100%; font-size:12px;;line-height:150%"">"
d = d & "  <label onClick=""ERRORDIV" & c & ".style.display=(ERRORDIV" & c & ".style.display=='none'?'':'none')"">"
d = d & "  <span style=""background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">〖 出错 提示信息 ERROR 〗</span><br />"
d = d & "  </label>"
d = d & "  <div id=""ERRORDIV" & c & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;"">"
d = d & " <span style=""color:#FF0000;"">出错描述</span> " & a & "<br />"
d = d & " <span style=""color:#FF0000;"">回显信息</span> " & b & "<br />"
d = d & "  </div>"
d = d & "</div>"
d = d & "<br />"
rESpONsE.wRItE(d)
rESpONsE.eND()
eND sUB
fUNcTIoN fULlPAtH(bYVaL a)
dIM b, c, d
a = rEPlACe(a, "/", "\")
b = sPLiT(a, "\")
fOR eACh c iN b
c = tRIm(c)
iF c <> "" aND c <> "." tHEn
iF iNStR(d, "\") > 0 aND c = ".." tHEn
d = mID(d, 1, iNStRReV(d, "\") - 1)
eLSe
iF d <> "" aND rIGhT(d, 1) <> "\" tHEn d = d & "\"
d = d & c
eND iF
eND iF
nEXt
fULlPAtH = d
eND fUNcTIoN
fUNcTIoN gETcONtENtRUnSTr(bYVaL a)
gETcONtENtRUnSTr = hANdLEcONtENtCOdE(a, "")
eND fUNcTIoN
fUNcTIoN hANdLEcONtENtCOdE(bYVaL a, b)
dIM c, d, e, f, g, h, i
dIM j
dIM k
dIM l
l = lCAsE(a)
iF b = "check" oR b = "检测" tHEn
hANdLEcONtENtCOdE = fALsE
eND iF
i = "|printpre|authorinfo|foldingmenu|returnren|returnhr|returnrenhr|showerr|printforminfo|dedecmsmsg|getdidsidtidsql|checkbigclass|checksmallclass|checkthreeclass|checkproduct|autoaddmaininfo|handleautoaddmaininfo|"
i = i & "|autoaddbigclass|autoaddsmallclass|autoaddthreeclass|autoaddarticle|autoaddarticleaction|gethttppage|geturlcontent|gethttpurl|bytestobstr|strcut|getstrcut|cutstr|cutstrnolu|setcuttdstr|specialhtmluploadencryptiondecrypt|"
i = i & "|encaspcontent|uppercaseorlowercase|enccode|deccode|tounicode|japan|japan26|unjapan26|send_email|serversend_email|findaspcode|findaspfunlist|findaspfunctioncode|handleReplaceList|getfunnamedim|getkeyword|gethandlekeyword|"
i = i & "|getchinastr|checkstr|regexp_checkstr|existsstr|regexp_replace|replacecolor|delhtml|regexp_delhtml|getaurltitlelist|phprand|phprnd|deleterepeatstr|replacen|fillzero|caseinsensitivereplace|saveremotefile|"
i = i & "|downfile|xmlgetstatus|xmlpost|utfxmlpost|handlexmlpost|format_time|getthisurlnoparam|getgotourl|getgotourlnoparam|getgotourlnofilename|getip2|getip|getfiletext|getftext|getfiletype|checkfile|existsfile|"
i = i & "|createfile|checkurl|is_url|checkerr|strtotruefalse|strtruefalsetoint|checkvbcrlf|checkbr|isparity|checkeval|htmlcode|showhtml|unhtmlcode|echohtml|errortext|testhtml|checkcode|seniorcheckcode|readfile|testgetpy|"
i = i & "|pinyin|deleterepeatarray|getarraycount|randomshow|arrayrandomshow|csscompression|deletecssnote|uncsscompression|trimvbcrlf|phptrim|ltrimvbcrlf|rtrimvbcrlf|utf2gb|checkutftogb2312|convchinese|getwebtemplate|"
i = i & "|getwebskins|detailpageaddhtmlprefix|gethandlefoldername|getmaininfourl|htmlformatting|getcontentrunstr|checkcontentrunstr|handledoublequotation|strdq|handlecontentcode|getaspcode|handlegetaspcode|getrandcolor|"
i = i & "|now|date|len|left|right|mid|lcase|ucase|"
g = sPLiT(i, "|")
fOR eACh j iN g
iF j <> "" tHEn
c = lCAsE(j & "(") : d = ")"
k = iNStR(" " & l, " " & c)
iF k > 0 aND iNStR(l, d) > 0 tHEn
iF b = "check" oR b = "检测" tHEn
hANdLEcONtENtCOdE = tRUe
eXIt fUNcTIoN
eND iF
eXIt fOR
eND iF
eND iF
nEXt
iF j = "" tHEn
iF b <> "check" aND b <> "检测" tHEn
hANdLEcONtENtCOdE = a
eND iF
eXIt fUNcTIoN
eND iF
j = lCAsE(j)
c = j & "(" : d = ")"
k = iNStR(l, c)
f = mID(a, iNStR(l, c))
f = mID(f, 1, iNStRReV(f, d))
e = mID(a, iNStR(l, c) + lEN(c))
e = mID(e, 1, iNStRReV(e, d) - 1)
iF cHEcKCoNTeNTrUNsTR(a) = tRUe tHEn
e = gETcONtENtRUnSTr(e)
eND iF
e = hANdLEdOUbLEqUOtATiON(e)
h = sPLiT(e & ",1", ",")
iF j = "printpre" tHEn
e = pRInTPrE(sTRdQ(e))
eLSeIF j = "now" tHEn
e = nOW()
eLSeIF j = "date" tHEn
e = dATe
eLSeIF j = "len" tHEn
e = lEN(e)
eLSeIF j = "lcase" tHEn
e = lCAsE(e)
eLSeIF j = "ucase" tHEn
e = uCAsE(e)
eLSeIF j = "left" tHEn
h = sPLiT(e & ",1", ",")
e = lEFt(tRIm(h(0)), tRIm(h(1)))
eLSeIF j = "right" tHEn
e = rIGhT(tRIm(h(0)), tRIm(h(1)))
eLSeIF j = "mid" tHEn
h = sPLiT(e & ",99999", ",")
iF uBOuND(h) >= 2 tHEn
e = mID(tRIm(h(0)), tRIm(h(1)), tRIm(h(2)))
eLSe
e = mID(tRIm(h(0)), tRIm(h(1)))
eND iF
eND iF
a = rEPlACe(a, f, e)
hANdLEcONtENtCOdE = a
eND fUNcTIoN
fUNcTIoN cHEcKCoNTeNTrUNsTR(bYVaL a)
cHEcKCoNTeNTrUNsTR = hANdLEcONtENtCOdE(a, "check")
eND fUNcTIoN
fUNcTIoN hANdLEdOUbLEqUOtATiON(bYVaL a)
dIM b
b = pHPtRIm(a)
iF lEFt(b, 1) = """" aND rIGhT(b, 1) = """" tHEn
a = mID(b, 2, lEN(b) - 2)
eND iF
hANdLEdOUbLEqUOtATiON = a
eND fUNcTIoN
fUNcTIoN pRInTPrE(a)
a = rEPlACe(a, "<", "&lt;")
pRInTPrE = "<pre>" & a & "</pre>"
eND fUNcTIoN
fUNcTIoN sTRdQ(bYVaL a)
sTRdQ = hANdLEdOUbLEqUOtATiON(a)
eND fUNcTIoN
fUNcTIoN pHPtRIm(a)
pHPtRIm = tRImVBcRLf(a)
eND fUNcTIoN
%>

