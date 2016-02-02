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
fUNcTIoN sHOwHTmLCoDE(a)
iF nOT iSNuLL(a) tHEn
a = rEPlACe(a, " ", "&nbsp;")
a = rEPlACe(a, "<", "&lt;")
a = rEPlACe(a, ">", "&gt;")
a = rEPlACe(a, "”", "&rdquo;")
a = rEPlACe(a, "“", "&ldquo;")
a = rEPlACe(a, "&", "&amp;")
eND iF
sHOwHTmLCoDE = a
eND fUNcTIoN
fUNcTIoN sHOwHTmL(a)
sHOwHTmL=rEPlACe(a, "<", "&lt;")
eND fUNcTIoN
fUNcTIoN uNHtMLcODe(a)
iF nOT iSNuLL(a) tHEn
a = rEPlACe(a, "&nbsp;", " ")
a = rEPlACe(a, "&lt;", "<")
a = rEPlACe(a, "&gt;", ">")
a = rEPlACe(a, "&rdquo;", "”")
a = rEPlACe(a, "&ldquo;", "“")
a = rEPlACe(a, "&mdash;", "—")
a = rEPlACe(a, "&lsquo;", "‘")
a = rEPlACe(a, "&rsquo;", "’")
a = rEPlACe(a, "&amp;", "&")
eND iF
uNHtMLcODe = a
eND fUNcTIoN
fUNcTIoN eCHoHTmL(a)
iF nOT iSNuLL(a) tHEn
a = rEPlACe(a, " ", "&nbsp;")
a = rEPlACe(a, "<", "&lt;")
eND iF
eCHoHTmL = a
eND fUNcTIoN
fUNcTIoN eRRoRTeXT(a, b, c)
iF iSNuLL(a) tHEn rW "<meta http-equiv=""refresh"" content=""" & a & ";URL=" & c & """"""">" & vBCrLF
rW("<fieldset>") & vBCrLF
rW("<legend>&nbsp;Report&nbsp;</legend>") & vBCrLF
rW("<div style=""padding-left:20px;padding-top:10px;color:red;font-weight:bold;text-align:center;"">" & b & "</div>") & vBCrLF
rW("<div style=""height:200p;text-align:center;""><P>") & vBCrLF
rW("<a href=""" & c & """>如果您的游览器没有自动跳转,请点这里>></a><P>") & vBCrLF  	
rW("</div></fieldset>") : rESpONsE.eND()
eND fUNcTIoN
sUB tEStHTmL()
dIM b
b = "<font style=""font-size:12px"">显示<b>1</b></font>"
cALl eCHo("S",b)
b = hTMlENcODe(b)
cALl eCHo("S",b)
b = hTMlDEcODe(b)
cALl eCHo("S",b)
b = hTMlFIlTEr(b)
cALl eCHo("S",b)
eND sUB
fUNcTIoN hTMlDEcODe(bYVaL a)
iF nOT iSNuL(a) tHEn
a = rEGrEPlACe(a, "<br\s*/?\s*>", vBCrLF)
a = rEPlACe(a, "&nbsp;&nbsp; &nbsp;", cHR(9))
a = rEPlACe(a, "&quot;", cHR(34))
a = rEPlACe(a, "&nbsp;", cHR(32))
a = rEPlACe(a, "&#39;", cHR(39))
a = rEPlACe(a, "&apos;", cHR(39))
a = rEPlACe(a, "&gt;", ">")
a = rEPlACe(a, "&lt;", "<")
a = rEPlACe(a, "&amp;", cHR(38))
a = rEPlACe(a, "&#38;", cHR(38))
hTMlDEcODe = a
eND iF
eND fUNcTIoN
fUNcTIoN hTMlENcODe(bYVaL a)
iF nOT iSNuL(a) tHEn
a = rEPlACe(a, cHR(38), "&#38;")
a = rEPlACe(a, "<", "&lt;")
a = rEPlACe(a, ">", "&gt;")
a = rEPlACe(a, cHR(39), "&#39;")
a = rEPlACe(a, cHR(32), "&nbsp;")
a = rEPlACe(a, cHR(34), "&quot;")
a = rEPlACe(a, cHR(9), "&nbsp;&nbsp; &nbsp;")
a = rEPlACe(a, vBCrLF, "<br />")
eND iF
hTMlENcODe = a
eND fUNcTIoN
fUNcTIoN hTMlFIlTEr(bYVaL a)
a = rEGrEPlACe(a,"<[^>]+>","")
a = rEPlACe(a, ">", "&gt;")
a = rEPlACe(a, "<", "&lt;")
hTMlFIlTEr = a
eND fUNcTIoN
fUNcTIoN rEGrEPlACe(bYVaL a, bYVaL b, bYVaL c)
rEGrEPlACe = eASp_RePLaCE(a,b,c,0)
eND fUNcTIoN
fUNcTIoN eASp_RePLaCE(bYVaL a, bYVaL b, bYVaL c, bYVaL d)
dIM e,f : e = a
iF nOT iSNuL(a) tHEn
sET f = cREaTEoBJeCT("VBscript.RegExp")
f.gLObAL = tRUe
f.iGNoREcASe = tRUe
iF d = 1 tHEn f.mULtILiNE = tRUe
f.pATtERn = b
e = f.rEPlACe(e,c)
sET f = nOThINg
eND iF
eASp_RePLaCE = e
eND fUNcTIoN
fUNcTIoN hANdLEhTMlLAbELcLOsE(a,b,c)
dIM d,e,f,g,h,i,j,k,l
d = "<" & b : e = ">"
i = gETaRRaY(a, d, e, tRUe, fALsE)
f=sPLiT(i,"$Array$")
fOR eACh j iN f
l=pHPtRIm(j)
iF rIGhT(l,1)="/" tHEn
l=pHPtRIm(lEFt(l,lEN(l)-1))
eND iF
iF c=tRUe tHEn
k = lCAsE(j)
iF iNStR(k,"alt")=fALsE tHEn
l = l & " alt="""""
eND iF
eND iF
a = rEPlACe(a,j & ">", l & " />")
nEXt
hANdLEhTMlLAbELcLOsE=a
eND fUNcTIoN
fUNcTIoN hANdLEiMGcLOsE(a,b)
hANdLEiMGcLOsE=hANdLEhTMlLAbELcLOsE(a,"img",b)
eND fUNcTIoN
fUNcTIoN hANdLEbRClOSe(a,b)
hANdLEbRClOSe=hANdLEhTMlLAbELcLOsE(a,"br",fALsE)
hANdLEbRClOSe=rEPlACe(hANdLEbRClOSe,"<br>","<br />")
eND fUNcTIoN
fUNcTIoN hANdLEhRClOSe(a,b)
hANdLEhRClOSe=hANdLEhTMlLAbELcLOsE(a,"hr",fALsE)
hANdLEhRClOSe=rEPlACe(hANdLEhRClOSe,"<hr>","<hr />")
eND fUNcTIoN
fUNcTIoN hANdLEcLOsEHtML(a,b,c)
dIM d, e, f, g, h, i, j, k
c="|"& c &"|"
j = "<"
k = ">"
fOR d = 1 tO lEN(a)
f = mID(a, d, 1)
e = mID(a, d)
iF f = "<" tHEn
iF iNStR(e, ">") > 0 tHEn
f = mID(e, 1, iNStR(e, ">"))
d = d + lEN(f) - 1
f = mID(f, 2, lEN(f) - 2)
f = pHPtRIm(f)
iF rIGhT(f, 1) = "/" tHEn
f = pHPtRIm(lEFt(f, lEN(f) - 1))
eND iF
e = rIGhT(e, lEN(e) - lEN(f) - 2)
i = mID(f, 1, iNStR(f & " ", " ") - 1)
i = lCAsE(i)
iF  iNStR(c,"|处理A链接|")>0 tHEn
f = hTMlLAbELtOClEAn(f,i,"http://127.0.0.1/TestWeb/Web/","处理A链接")
eLSeIF  iNStR(c,"|处理A链接第二种|")>0 tHEn
f = hTMlLAbELtOClEAn(f,i,"http://127.0.0.1/debugRemoteWeb.asp?url=","处理A链接")
eLSe
f = hTMlLAbELtOClEAn(f,i,"","")
eND iF
iF iNStR("|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|", "|" & i & "|") > 0 tHEn
f=rEPlACe(rEPlACe(rEPlACe(rEPlACe(f," class=""""","")," alt=""""","")," title=""""","")," name=""""","")	
f=rEPlACe(rEPlACe(rEPlACe(rEPlACe(f," class=''","")," alt=''","")," title=''","")," name=''","")
iF i = "img" aND b=tRUe tHEn
iF iNStR(f, " alt") = fALsE tHEn
f = f & " alt="""""
eND iF
f=tRIm(f)
f = f & " /"
eLSeIF i= "script" tHEn	
iF iNStR(f, " type") = fALsE tHEn
f = f & " type=""text/javascript"""
eND iF	
eND iF
eND iF
f = j & f & k
iF i = "script" tHEn
g = mID(e, 1, iNStR(e, "</script>") + 8)
d = d + lEN(g)
f = f & g
eND iF
eND iF
eND iF
h = h & f
nEXt
hANdLEcLOsEHtML = h
eND fUNcTIoN
fUNcTIoN hTMlLAbELtOClEAn(bYVaL a,b,c,d)
dIM e, f, g, h
dIM i
dIM vALuEStR 	
dIM yINgHAoLAbEL	
dIM pAReNTnAMe	
dIM bEHiNDsTR	
dIM nODaNYiNShUAnGYiNStR	
d="|"& d &"|"
a = rEPlACe(a & " ", vBTaB, " ")	
a=rEPlACe(rEPlACe(a," =","=")," =","=")
i = fALsE 	
fOR e = 1 tO lEN(a)
f = mID(a, e, 1) 	
bEHiNDsTR=mID(a,e)	
iF f = "=" aND i = fALsE tHEn	
i = tRUe
vALuEStR = ""
yINgHAoLAbEL = ""
iF g <> "" aND rIGhT(g, 1) <> " " tHEn g = g & " "
pAReNTnAMe=lCAsE(h )	
g = g & pAReNTnAMe & f
h = ""
eLSeIF i = tRUe aND yINgHAoLAbEL = "" tHEn
iF f <> " " tHEn
iF f<>"'" aND f<>"""" tHEn
nODaNYiNShUAnGYiNStR = f	
f=" "
eND iF
yINgHAoLAbEL = f
eND iF
eLSeIF i = tRUe aND yINgHAoLAbEL <> "" tHEn
iF yINgHAoLAbEL = f tHEn
i = fALsE
iF b="a" aND pAReNTnAMe="href" aND iNStR(d,"|处理A链接|")>0 tHEn
iF iNStR(vALuEStR,"?")>0 tHEn
vALuEStR=rEPlACe(vALuEStR,"?","WenHao") & ".html"
eND iF
iF iNStR("|asp|php|aspx|jsp|", "|" & lCAsE(mID(vALuEStR,iNStRReV(vALuEStR,".")+1)) & "|" )>0 tHEn
vALuEStR=vALuEStR & ".html"
eND iF
vALuEStR = aDDtOOrADdHTtPUrL(c,vALuEStR,"替换")
eND iF
iF yINgHAoLAbEL=" " tHEn	
g = g & """" & nODaNYiNShUAnGYiNStR & vALuEStR & """ " 	
eLSe
g = g & yINgHAoLAbEL & vALuEStR & yINgHAoLAbEL 	
eND iF
yINgHAoLAbEL = ""	
nODaNYiNShUAnGYiNStR=""	
eLSe
vALuEStR = vALuEStR & f
eND iF
eLSeIF f = " " tHEn
iF h <> "" tHEn
iF lEFt(tRIm(bEHiNDsTR) & " ",1)="=" tHEn	
eLSe
iF i = fALsE tHEn
h = lCAsE(h) & " " 	
eND iF
g = g & h
h = ""
eND iF
eND iF
eLSe
h = h & f
eND iF
nEXt
g=tRIm(g)
hTMlLAbELtOClEAn = g
eND fUNcTIoN
fUNcTIoN aDDtOOrADdHTtPUrL(a,bYVaL b,c)
dIM d
c="|"& c &"|"
iF iNStR(c,"|替换|")>0 tHEn
d=gETwEBsITe(b)
iF d<>"" tHEn
b=rEPlACe(b,d,"")
eND iF
eND iF
iF iNStR(b,a)=fALsE tHEn
iF rIGhT(a,1)="/" aND (lEFt(b,1)="/" oR lEFt(b,1)="\") tHEn
b=mID(b,2)
eND iF
b = a & b
eND iF
aDDtOOrADdHTtPUrL=b
eND fUNcTIoN
fUNcTIoN rEMoVEbLAnKLiNEs(a)
dIM b,c,d
d=sPLiT(a,vBCrLF)
fOR eACh b iN d
iF rEPlACe(rEPlACe(b,vBTaB,"")," ","")<>"" tHEn
iF c<>"" tHEn c=c & vBCrLF
c=c & b
eND iF
nEXt
rEMoVEbLAnKLiNEs=c
eND fUNcTIoN
fUNcTIoN rEMoVEbLAnKLiNEs_TeST1(a)
dIM b
fOR b=1 tO 9
a=rEPlACe(a,vBCrLF & vBCrLF,vBCrLF)
nEXt
rEMoVEbLAnKLiNEs_TeST1 = a
eND fUNcTIoN
fUNcTIoN bLAnKHtMLbODy(a,b)
dIM c
c= "<!DOCTYPE html PUBLIC>" & vBCrLF
c=c & "<html xmlns=""http://www.w3.org/1999/xhtml"">" & vBCrLF
c=c & "<head>" & vBCrLF
c=c & "<meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312"" />" & vBCrLF
c=c & "<title>"& a &"</title>" & vBCrLF
c=c & "</head>" & vBCrLF
c=c & "<body>" & vBCrLF
c=c & b & vBCrLF
c=c & "</body>" & vBCrLF
c=c & "</html>" & vBCrLF
bLAnKHtMLbODy=c
eND fUNcTIoN
%>
