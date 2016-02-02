<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-01
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN pAGeCOnTRoL(a, b, c, d, e)
dIM f, g, h, i, j, k, l
j = "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & rEQuESt.sERvERvARiABlES("SCRIPT_NAME")
f = sPLiT(rEQuESt.sERvERvARiABlES("QUERY_STRING"), "&")
fOR eACh h iN f
g = sPLiT(h, "=")
iF sTRcOMp(g(0), "page", vBTeXTcOMpARe) <> 0 tHEn
i = i & g(0) & "=" & g(1) & "&"
eND iF
nEXt
l = l & "<table width=100% border=0 cellpadding=0 cellspacing=0 class=hui>" & vBCrLF
l = l & "<TD align=center height=35 class='font'>" & vBCrLF
l = l & e & vBCrLF
iF c <= 1 tHEn
l = l & "首 页 " & vBCrLF
l = l & "上一页 " & vBCrLF
eLSe
l = l & "<A HREF=" & j & "?" & i & "Page=1 class='huilianjie'>首 页</A> " & vBCrLF
l = l & "<A HREF=" & j & "?" & i & "Page=" &(c - 1) & " class='huilianjie'>上一页</A> " & vBCrLF
eND iF
iF c >= b tHEn
l = l & "下一页 " & vBCrLF
l = l & "尾 页 " & vBCrLF
eLSe
l = l & "<A HREF=" & j & "?" & i & "Page=" &(c + 1) & " class='huilianjie'>下一页</A> " & vBCrLF
l = l & "<A HREF=" & j & "?" & i & "Page=" & b & " class='huilianjie'>尾 页</A> " & vBCrLF
eND iF
l = l & " 页次：<b><font color=red>" & c & "</font>/" & b & "</b>页" & vBCrLF
l = l & " 共有<b>" & a & "</b>个记录" & vBCrLF
iF b < 10 tHEn
l = l & "<SELECT onchange='location.href(this.options[this.selectedIndex].value)'>"
fOR k = 1 tO b
iF c = k tHEn
l = l & "<option value=?" & i & "page=" & k & " selected> 第" & k & "页</option>"
eLSe
l = l & "<option value=?" & i & "page=" & k & "> 第" & k & "页</option>"
eND iF
nEXt
l = l & "</select>"
eLSe
i = rEPlACe(i,"\","\\")
l = l & "<input name=""GotoPage"" value=""" & c & """ type=""text"" id=""GotoPage"" size=""5"" style=""text-align:center;"" /> &nbsp;"
l = l & "<input type=""button"" name=""button"" id=""button"" value=""跳转"" onclick=""location.href('?" & i & "Page=' + document.all.GotoPage.value)"" />"
eND iF
l = l & "<!--用时--></TD>" & vBCrLF
l = l & "</TR>" & vBCrLF
l = l & "</table>" & vBCrLF
pAGeCOnTRoL = l
eND fUNcTIoN
fUNcTIoN wEBpAGeCOnTRoL(a, b, c, d)
dIM e,f,g,h,i,j,k
dIM l,nEXtPAgE	
dIM iSDiSPlAYtIP	
iSDiSPlAYtIP=tRUe
iF d="" tHEn
d=gETuRLaDDtOPaRAm( gETuRL(),"?page=[id]","replace")
eND iF
i=6	
j=0	
c=hANdLEnUMbERtYPe(c)
iF c="" tHEn
c=1
eLSe
c=cINt(c)
eND iF
g=gETcOUnTPaGE(a,b)
l=c-1
nEXtPAgE=c+1
iF l<=0 tHEn
l=""
eND iF
iF nEXtPAgE>g tHEn
nEXtPAgE=""
eND iF
f=f & "<ul class=""pagecontrolwrap"">" & vBCrLF
f=f & "<li class=""pageinfo"">总数["& a &"]  共["& c &"/"& g &"]页</li>" & vBCrLF
iF c>1 tHEn
f=f & "<li><a href="""&  rEPlACe(d,"[id]","") &""">首页</a></li>" & vBCrLF	
eLSeIF iSDiSPlAYtIP=tRUe tHEn
f=f & "<li class=""pageli"">首页</li>" & vBCrLF
eND iF
iF l<>"" tHEn
k=l
iF l<=1 tHEn
k=""
eND iF
f=f & "<li><a href="""&  rEPlACe(d,"[id]",k) &""">上一页</a></li>" & vBCrLF
eLSeIF iSDiSPlAYtIP=tRUe tHEn
f=f & "<li class=""pageli"">上一页</li>" & vBCrLF
eND iF
dIM o
o = (c-3)
fOR h = o tO g
iF h>=1 tHEn
j=j+1
iF h = c tHEn
f=f & "<li class=""pagefocus"">"& h &"</li>" & vBCrLF
eLSe
k=h
iF h<=1 tHEn
k=""
eND iF
f=f & "<li><a href="""&  rEPlACe(d,"[id]",k) &""">"& h &"</a></li>" & vBCrLF
eND iF
iF j>i tHEn
eXIt fOR
eND iF
eND iF
nEXt
iF g>c tHEn
f=f & "<li><a href="""& rEPlACe(d,"[id]",nEXtPAgE) &""">下一页</a></li>" & vBCrLF
eLSeIF iSDiSPlAYtIP=tRUe tHEn
f=f & "<li class=""pageli"">下一页</li>" & vBCrLF
eND iF
iF g>c tHEn
f=f & "<li><a href="""& rEPlACe(d,"[id]",g) &""">末页</a></li>" & vBCrLF
eLSeIF iSDiSPlAYtIP=tRUe tHEn
f=f & "<li class=""pageli"">末页</li>" & vBCrLF
eND iF
f=f & "</ul><div class=""clear""></div>" & vBCrLF
wEBpAGeCOnTRoL=f  & vBCrLF
eND fUNcTIoN
fUNcTIoN gETrSPaGEnUMbER(a, b, c, d)
dIM e
e=0
a.pAGeSIzE = c
mAXpAGe = a.pAGeCOuNT
iF mAXpAGe>0 tHEn
iF nOT iSNuMErIC(d) oR d = "" tHEn
d = 1
eLSe
d = cINt(d)
eND iF
iF d < 1 tHEn
d = 1
eLSeIF d > mAXpAGe tHEn
d = mAXpAGe
eND iF
a.aBSoLUtEPaGE = d
iF d = mAXpAGe tHEn
e = b - (mAXpAGe - 1) * c
eLSe
e = c
eND iF
eND iF
gETrSPaGEnUMbER = e
eND fUNcTIoN
%>

