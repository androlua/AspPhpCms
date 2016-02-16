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
<!--#iNClUDe fILe="Config.Asp"-->
<%
sELeCT cASe rEQuESt("act")
cASe "ViewInfo" : vIEwINfO()	
cASe "ViewList" : vIEwLIsT()	
cASe "ViewList2" : vIEwLIsT2()	
cASe "test" : mYTeST()	
eND sELeCT
sUB mYTeST()
dIM b,c,d
b=rF("username")
c=rQ("username")
d=rF("userpass")
rW("UserName=" & b & vBCrLF)
rW("UserName2=" & c & vBCrLF)
rW("PassWord=" & d)
eND sUB
sUB vIEwLIsT2()
dIM b,c,d,e,f,g,h,i,j,k
rESpONsE.aDDhEAdER "Content-Type","text/html; charset=utf-8"
dIM l,m,n,o,p,q
cALl oPEnCOnN()
l=cONn.eXEcUTe("Select Count(*) From [Product]")(0)
fOR j=0 tO 50
m=cONn.eXEcUTe("Select Count(*) From [Product] Where UpDateTime=#"& dATe()-j &"#")(0)
n = n &  "时间(" & fORmAT_TImE(nOW-j,2) & ")" & vBCrLF & "新添文章("& m &"/" & l & ")" & vBCrLF
p = gETfTExT("\Admin\Data\Stat\" & fORmAT_TImE(nOW()-j,2) & ".txt")
q=sPLiT(p,"当前：")
g=0	
h=0	
c = 0	
f = 0	
fOR eACh i iN q
iF iNStR(i,"IP:")>0 tHEn
iF iNStR(i,vBCrLF & "IE: U" & vBCrLF)>0 tHEn
g = g + 1
d = mID(i,iNStR(i,"XP=")+3)
d = mID(d,1,iNStR(d,vBCrLF)-2)
iF iNStR(vBCrLF & e & vBCrLF, vBCrLF & d & vBCrLF)=0 tHEn
e = e & d & vBCrLF
f = f + 1
eND iF
eLSe
h = h + 1
eND iF
k = mID(i,iNStR(i,"IP:")+3)
k = mID(k,1,iNStR(k,vBCrLF)-2)
iF iNStR(vBCrLF & b & vBCrLF, vBCrLF & k & vBCrLF)=0 tHEn
b = b & k & vBCrLF
c = c + 1
eND iF
eND iF
nEXt
n=n & "LogDate="& fORmAT_TImE(nOW()-j,2) &"" & vBCrLF 	
n=n & "AddArticle="& m &"" & vBCrLF 	
n=n & "ArticleSum="& l &"" & vBCrLF 	
n=n & "WebBrowseSum="& (h + g) &"" & vBCrLF 	
n=n & "ComputerSum="& h &"" & vBCrLF 	
n=n & "MobileSum="& g &"" & vBCrLF 	
n=n & "IndependentIP="& c &"" & vBCrLF 	
n=n & "IndependentMobileType="& f &"" & vBCrLF 	
n=n & "MobileTypeList="& e &"" & vBCrLF 	
n=n & "-----------" & vBCrLF
nEXt
rESpONsE.wRItE(n)
eND sUB
sUB vIEwLIsT()
dIM b,c,d,e,f,g,h,i,j,k
rESpONsE.aDDhEAdER "Content-Type","text/html; charset=utf-8"
dIM l,m,n,o,p,q
cALl oPEnCOnN()
l=cONn.eXEcUTe("Select Count(*) From [Product]")(0)
fOR j=0 tO 50
m=cONn.eXEcUTe("Select Count(*) From [Product] Where UpDateTime=#"& dATe()-j &"#")(0)
n = n &  "时间(" & fORmAT_TImE(nOW-j,2) & ")" & vBCrLF & "新添文章("& m &"/" & l & ")" & vBCrLF
p = gETfTExT("\Admin\Data\Stat\" & fORmAT_TImE(nOW()-j,2) & ".txt")
q=sPLiT(p,"当前：")
g=0	
h=0	
c = 0	
f = 0	
fOR eACh i iN q
iF iNStR(i,"IP:")>0 tHEn
iF iNStR(i,vBCrLF & "IE: U" & vBCrLF)>0 tHEn
g = g + 1
d = mID(i,iNStR(i,"XP=")+3)
d = mID(d,1,iNStR(d,vBCrLF)-2)
iF iNStR(vBCrLF & e & vBCrLF, vBCrLF & d & vBCrLF)=0 tHEn
e = e & d & vBCrLF
f = f + 1
eND iF
eLSe
h = h + 1
eND iF
k = mID(i,iNStR(i,"IP:")+3)
k = mID(k,1,iNStR(k,vBCrLF)-2)
iF iNStR(vBCrLF & b & vBCrLF, vBCrLF & k & vBCrLF)=0 tHEn
b = b & k & vBCrLF
c = c + 1
eND iF
eND iF
nEXt
n=n & "网页被浏览("& h + g &")次" & vBCrLF
n=n &"IE浏览("& h &")次" & vBCrLF
n=n & "手机浏览("& g &")次" & vBCrLF
n=n & "独立IP数为("& c &")个" & vBCrLF
n=n & "-----------" & vBCrLF
nEXt
rESpONsE.wRItE(n)
eND sUB
sUB vIEwINfO()
dIM b,c,d,e,f,g,h,i,j,k
rESpONsE.aDDhEAdER "Content-Type","text/html; charset=utf-8"
dIM l,m,n,o,p,q
cALl oPEnCOnN()
l=cONn.eXEcUTe("Select Count(*) From [Product]")(0)
m=cONn.eXEcUTe("Select Count(*) From [Product] Where UpDateTime>=#"& dATe() &"#")(0)
n = "时间(" & fORmAT_TImE(nOW,2) & ")" & vBCrLF & "新添文章("& m &"/" & l & ")" & vBCrLF
p = gETfTExT("\Admin\Data\Stat\" & fORmAT_TImE(nOW(),2) & ".txt")
q=sPLiT(p,"当前：")
g=0	
h=0	
c = 0	
f = 0	
fOR eACh i iN q
iF iNStR(i,"IP:")>0 tHEn
iF iNStR(i,vBCrLF & "IE: U" & vBCrLF)>0 tHEn
g = g + 1
d = mID(i,iNStR(i,"XP=")+3)
d = mID(d,1,iNStR(d,vBCrLF)-2)
iF iNStR(vBCrLF & e & vBCrLF, vBCrLF & d & vBCrLF)=0 tHEn
e = e & d & vBCrLF
f = f + 1
eND iF
eLSe
h = h + 1
eND iF
k = mID(i,iNStR(i,"IP:")+3)
k = mID(k,1,iNStR(k,vBCrLF)-2)
iF iNStR(vBCrLF & b & vBCrLF, vBCrLF & k & vBCrLF)=0 tHEn
b = b & k & vBCrLF
c = c + 1
eND iF
eND iF
nEXt
n=n & "网页被浏览("& h + g &")次" & vBCrLF
n=n &"IE浏览("& h &")次" & vBCrLF
n=n & "手机浏览("& g &")次" & vBCrLF
n=n & "独立IP数为("& c &")个" & vBCrLF
n=n & "不同手机类型数为("& f &")个" & vBCrLF
n=n & "不同手机列表："& vBCrLF &  e
rESpONsE.wRItE(n)
eND sUB
%>

