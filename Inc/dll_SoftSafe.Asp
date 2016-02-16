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
cLAsS dLLsOFtSAfE
pRIvATe fRMnAMe	
pRIvATe sUB cLAsS_iNItIAlIZe()
eND sUB
pRIvATe sUB cLAsS_tERmINaTE()
eND sUB
pUBlIC pROpERtY lET sETfRMnAMe(sTR)
fRMnAMe=sTR
eND pROpERtY
pUBlIC pROpERtY gET gETfRMnAMe()
gETfRMnAMe = fRMnAMe
eND pROpERtY
fUNcTIoN iSAcCEsSPaSS(bYVaL a,b)
iSAcCEsSPaSS=fALsE
iF cHEcKFiLE(a) = fALsE tHEn
cALl mBInFO("出错", "没有数据库"): eXIt fUNcTIoN
eND iF
b = fILeCReATeDAtE(a)
b = fORmAT_TImE(b, 4) & "313801120"
iF (cHEcKAcCEsSPaSS(a, b)) = fALsE tHEn
cALl mBInFO("出错", "数据库密码错误" & b): eXIt fUNcTIoN
eND iF
iSAcCEsSPaSS=tRUe
eND fUNcTIoN
fUNcTIoN cHEcKFiLE(bYVaL a)
oN eRRoR rESuME nEXt
dIM b
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("Scripting.FileSystemObject")
cHEcKFiLE = b.fILeEXiSTs(a)
sET b = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "CheckFile 检查文件 函数出错，FileName=" & a
eND fUNcTIoN
fUNcTIoN fILeCReATeDAtE(a)
fILeCReATeDAtE = gETfILeCReATeDAtE(a)
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
fUNcTIoN cHEcKAcCEsSPaSS(a, b)
oN eRRoR rESuME nEXt
dIM c
cHEcKAcCEsSPaSS = tRUe
sET c = cREaTEoBJeCT("Adodb.Connection")
c.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & b & "';Data Source = " & a
c.cLOsE
iF eRR <> 0 tHEn
eRR.cLSoE
cHEcKAcCEsSPaSS = fALsE
eND iF
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
fUNcTIoN gETfILeCReATeDAtE(bYVaL a)
oN eRRoR rESuME nEXt
dIM b, c
cALl hANdLEpATh(a)
sET b = cREaTEoBJeCT("Scripting.FileSystemObject")
iF b.fILeEXiSTs(a) = tRUe tHEn
sET c = b.gETfILe(a)
gETfILeCReATeDAtE = c.dATeCReATeD
sET c = nOThINg
eND iF
sET b = nOThINg
iF eRR tHEn dOErROr eRR.dEScRIpTIoN, "GetFileCreateDate 获得文件创建时间 函数出错，FileName=" & a
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
fUNcTIoN rW(a)
rESpONsE.wRItE(a)
eND fUNcTIoN
fUNcTIoN mSGbOX(bYVaL a)
a = rEPlACe(rEPlACe(a, cHR(10), "\n"), cHR(13), "\n")
rESpONsE.wRItE("<script>alert('" & a & "');</script>")
eND fUNcTIoN
fUNcTIoN mBInFO(a, b)
mBInFO = mSGbOX(a)
eND fUNcTIoN
eND cLAsS
dIM tEStOBj : sET tEStOBj = nEW dLLsOFtSAfE	
dIM aCCeSSpASs
sELeCT cASe rEQuESt("act")
cASe "handle" : cALl tEStOBj.rW(tEStOBj.iSAcCEsSPaSS(rEQuESt("MDBPath"),aCCeSSpASs))
cASe eLSe:dEFaULt()
eND sELeCT
sUB dEFaULt()
%>
<form id="form1" name="form1" method="post" action="?act=handle">
发送内容
<input name="MDBPath" type="text" id="MDBPath" value="<%="\VB工程\Data\Access.Mdb"%>" />
<input type="submit" name="button" id="button" value="提交" />
</form>
<%eND sUB%>

