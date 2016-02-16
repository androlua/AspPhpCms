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
fUNcTIoN mSGbOX(bYVaL a)
a=rEPlACe(rEPlACe(a,cHR(10),"\n"),cHR(13),"\n")
rESpONsE.wRItE("<script>alert('"& a &"');</script>")
eND fUNcTIoN
fUNcTIoN mBInFO(a,b)
mBInFO=mSGbOX(a)
eND fUNcTIoN
sUB aDDrQ(a,b)
rESpONsE.qUErYStRInG(a) = b
eND sUB
fUNcTIoN rC(a)
rC = rEQuESt.cOOkIEs(a)
eND fUNcTIoN
sUB aDDrC(a,b,c)
rESpONsE.cOOkIEs(a) = b
iF c<>"" tHEn rESpONsE.cOOkIEs(a).eXPiREs = c
eND sUB
sUB rR(a)
rESpONsE.rEDiREcT(a)
eND sUB	
fUNcTIoN rF(a)
rF = rEQuESt.fORm(a)
eND fUNcTIoN
fUNcTIoN aDSqLRf(a)
aDSqLRf= rEPlACe(rEQuESt.fORm(a),"'","''")
eND fUNcTIoN
fUNcTIoN rQ(a)
rQ = rEQuESt.qUErYStRInG(a)
eND fUNcTIoN
fUNcTIoN rFQ(a)
rFQ = rEQuESt(a)
eND fUNcTIoN
fUNcTIoN rW(a)
rESpONsE.wRItE(a)
eND fUNcTIoN
fUNcTIoN rWBr(a)
rESpONsE.wRItE(a & vBCrLF)
eND fUNcTIoN
fUNcTIoN rWEnD(a)
rESpONsE.wRItE(a)
rESpONsE.eND()
eND fUNcTIoN
fUNcTIoN hTMeND(a)
cALl  rWEnD(a)
eND fUNcTIoN
fUNcTIoN dIE(a)
rESpONsE.wRItE(a)
rESpONsE.eND()
eND fUNcTIoN
fUNcTIoN dEBuG(a)
rESpONsE.wRItE("<div  style=""border:solid 1px #000000;margin-bottom:2px;"">调试" & a & "</div>" & vBCrLF)
eND fUNcTIoN
fUNcTIoN tRAcE(a)
tRAcE = dEBuG(a)
eND fUNcTIoN
fUNcTIoN eCHo(a, b)
cALl eCHoPRoMPt(a, b)
eND fUNcTIoN
fUNcTIoN eCHoREd(a, b)
rESpONsE.wRItE("<font color=Red>" & a & "</font>：" & b & "<br>")
eND fUNcTIoN
fUNcTIoN eCHoREdB(a, b)
rESpONsE.wRItE("<b><font color=Red>" & a & "</font>：" & b & "</b><br>")
eND fUNcTIoN
fUNcTIoN eCHoPRoMPt(a, b)
rESpONsE.wRItE("<font color=Green>" & a & "</font>：" & b & "<br>")
eND fUNcTIoN
fUNcTIoN eCHoSTr(a, b)
cALl eCHoPRoMPt(a, b)
eND fUNcTIoN
fUNcTIoN pRInT_r(a)
dIM b,c
iF tYPeNAmE(a) = "Variant()" tHEn
fOR b=0 tO uBOuND(a)
c = c & "["& b &"] => " & a(b) & vBCrLF
nEXt
eLSe
c = a
eND iF
rESpONsE.wRItE(c)
eND fUNcTIoN
fUNcTIoN sETcOLoREcHO(a, b, c)
rESpONsE.wRItE("<font color="& a &">" & b & "</font>：" & c & "<br>")
eND fUNcTIoN
fUNcTIoN eERr(a, b)
rESpONsE.wRItE("<font color=red>" & a & "</font>：" & b)
rESpONsE.eND()
eND fUNcTIoN
sUB dOEvENtS()
rESpONsE.fLUsH()
eND sUB
fUNcTIoN iIF(a, b, c)
iF(a) tHEn iIF = b eLSe iIF = c
eND fUNcTIoN
fUNcTIoN hR()
rESpONsE.wRItE("<hr size='1' color='#666666'> ")
eND fUNcTIoN
pUBlIC sUB pRInT(bYVaL a)
rESpONsE.wRItE(a & vBCrLF) : rESpONsE.fLUsH()
eND sUB
pUBlIC sUB pRInTLn(bYVaL a)
rESpONsE.wRItE(a & "<br />" & vBCrLF) : rESpONsE.fLUsH()
eND sUB
pUBlIC sUB pRInTHtML(bYVaL a)
rESpONsE.wRItE(hTMlENcODe(a) & vBCrLF)
eND sUB
pUBlIC sUB pRInTLnHTmL(bYVaL a)
rESpONsE.wRItE(hTMlENcODe(a) & "<br />") & vBCrLF
eND sUB
pUBlIC sUB pRInTEnD(bYVaL a)
rESpONsE.wRItE(a) :  rESpONsE.eND()
eND sUB
fUNcTIoN iSChECkED(bYVaL a, bYVaL b)
iF a = b tHEn iSChECkED = "checked='checked'" eLSe iSChECkED = ""
eND fUNcTIoN
fUNcTIoN iSSeLEcTEd(bYVaL a, bYVaL b)
iF a = b tHEn iSSeLEcTEd = "selected='selected'" eLSe iSSeLEcTEd = ""
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
fUNcTIoN eXEc(bYVaL a)
iF a="" tHEn eXIt fUNcTIoN: eND iF
oN eRRoR rESuME nEXt
eXEcUTe(a)
oN eRRoR gOTo 0
eND fUNcTIoN
%>


