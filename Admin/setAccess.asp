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
sUB rESeTAcCEsSDaTA()
cALl oPEnCOnN()
dIM b, c, d, e, f, g
cALl oPEnCOnN()
cONn.eXEcUTe("delete from "& dB_pREfIX &"webcolumn")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,parentid) values('首推产品','Recommend','首页',0,'|top|',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid,showtitle,bodycontent) values('关于安颐','About','文本',1,'|top|','关于我们您可以知道很多',-1,'天津华林园科技发展有限公司','公司拥有资深的国内外专家、教授、博士、硕士等专业的研发队伍，开发具有世界领先水平的新型材料和产品。 多年来公司立足品牌的战略和人才的战略，在激烈的市场竞争中迅速发展和壮大，形成了以科研、开发、生产、复合营销为一体的多元化、多领域的专业科技公司。 公司实行外联内合的战略，与日本科研机构合作，研究开发出具有世界尖端水平的生物保健品和化妆品； 与国内具有研究实力的功能纤维研究所合作，开发研制出了国内先进高端的纳米光能微粉材料及纤维系列健康产品，以及现已完成研制的软体面控发射体材料的制作。华林公司是我们实实在在的民族企业，她在多项领域和多项科研中是领头羊佼佼者，是天津的重点保护企业、诚信企业。她现在拥有科技发明及新型实用专利11项，企业获得了ISO9000与ISO14000认证,被天津市政府评为“明星企业”和“五星级企业”。 ')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('安颐产品','Product','产品',2,'|top|','尽心尽力为你你制作更好的产品',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('新闻视频','News','产品',3,'|top|','公司信息一手知道',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('联系我们','Contact us','文本',4,'|top|','我们可有意思了欢迎来联系',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('细胞生态学','Contact us','新闻',4,'||','',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('美容常识','Contact us','新闻',4,'||','',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('新闻资讯','Contact us','新闻',4,'||','',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('精彩视频','Contact us','视频',4,'||','',-1)")
cONn.eXEcUTe("delete from "& dB_pREfIX &"articledetail")
b = sPLiT("细胞生态学|美容常识|新闻资讯|安颐产品", "|")
fOR eACh e iN b
iF e = "安颐产品" tHEn
g = 12
eLSe
g = 6
eND iF
fOR c = 1 tO g
f = e & c
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values('" & f & "'," & gETcOLuMNiD(e) & ",'[$WebImages$]testproduct.jpg','[$WebImages$]biglimage.jpg','[$WebImages$]banner" & c & ".jpg','||','产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，" & f & "，以增加深度睡眠时间4','" & f & "更多内容在这里写')")
nEXt
nEXt
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('视频1'," & gETcOLuMNiD("精彩视频") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]1.flv','','||','产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('视频2'," & gETcOLuMNiD("精彩视频") & ",'[$WebImages$]banner1.jpg','[$WebImages$]1.flv','','||','产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('视频3'," & gETcOLuMNiD("精彩视频") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]1.flv','','||','产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('视频4'," & gETcOLuMNiD("精彩视频") & ",'[$WebImages$]banner1.jpg','[$WebImages$]1.flv','','||','产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4')")
rS.oPEn "select * from  "& dB_pREfIX &"website ", cONn, 1, 1
iF rS.eOF tHEn
cONn.eXEcUTe("insert into "& dB_pREfIX &"website (webtitle) values('网站标题')")
eND iF : rS.cLOsE
cONn.eXEcUTe("update  "& dB_pREfIX &"website  set webtitle='安颐官网',webkeywords='安颐关键词',webdescription='安颐描述',websitebottom='Copyright @ 2014 东方紫官方网站 All Rights Reserved<br>苏ICP备09092049号-2',webtemplate='/Templates2015/安颐/',webimages='/Templates2015/安颐/Images/',webcss='/Templates2015/安颐/Css/',webjs='/Templates2015/安颐/Js/'")
cALl eCHo("提示", "恢复数据完成")
cALl rW("<hr><a href='/" & eDItORtYPe & "web." & eDItORtYPe & "' target='_blank'>进入首页</a> | <a href=""1." & eDItORtYPe & """ target='_blank'>进入后台</a>")
cONn.eXEcUTe("delete from "& dB_pREfIX &"onePage ")
cONn.eXEcUTe("insert into "& dB_pREfIX &"onePage (title) values('安颐，第1条单页面')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"onePage (title) values('安颐，第2条单页面')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"onePage (title) values('安颐，第3条单页面')")
cONn.eXEcUTe("delete from "& dB_pREfIX &"admin ")
cONn.eXEcUTe("insert into "& dB_pREfIX &"admin (username,pwd) values('aa','" & mYMd5("aa") & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"admin (username,pwd) values('admin','" & mYMd5("admin") & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"admin (username,pwd) values('11','" & mYMd5("11") & "')")
iF 1 = 2 tHEn
fOR c = 1 tO 320
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values('" & c & "'," & gETcOLuMNiD("细胞生态学") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]biglimage.jpg','[$WebImages$]banner" & c & ".jpg','||','产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，" & c & "，以增加深度睡眠时间4','" & c & "更多内容在这里写')")
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"weblayout")
d = gETfTExT("zcase_layout.txt")
d = aDSqL(d)
cONn.eXEcUTe("insert into "& dB_pREfIX &"weblayout(layoutname,layoutlist,bodycontent) values('蓝色', '网站公告|新闻中心|产品展示|案例展示','" & d & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"weblayout(layoutname,layoutlist,bodycontent) values('绿色', '网站公告|新闻中心|产品展示|案例展示','" & d & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"weblayout(layoutname,layoutlist,bodycontent) values('红色', '网站公告|新闻中心|产品展示|案例展示','" & d & "')")
cONn.eXEcUTe("delete from "& dB_pREfIX &"webmodule")
b = sPLiT("网站公告|新闻中心|产品展示|案例展示", "|")
fOR eACh f iN b
d = "{$ReadColumeSetTitle title='" & f & "' style='312' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName\' file=\'\'$]'$}<!--#读出内容BlockName" & f & " 这里面放内容, 第一种调用方法#-->"
d = aDSqL(d)
cONn.eXEcUTe("insert into "& dB_pREfIX &"webmodule(moduletype,modulename,bodycontent) values('红色','" & f & "','" & d & "')")
nEXt
eND iF
dIM h, i, j, k, l, m, n, o, p, q, r, s,t
dIM u, v, w, x, y, z, aA, bA, cA,dA,eA,fA,gA
dIM hA,iA,jA,kA,lA
dIM mA,nA,iSOnHTmL	
fOR c =1 tO 20
cONn.eXEcUTe("insert into "& dB_pREfIX &"Bidding(nComputerSearch) values(2"& c &")")
cONn.eXEcUTe("insert into "& dB_pREfIX &"Bidding(nComputerSearch) values(1"& c &")")
nEXt
h = gETfTExT("/Data/WebData/website.ini")
iF h <> "" tHEn
o = gETsTRcUT(h, "【webtitle】", vBCrLF, 0)
p = gETsTRcUT(h, "【webkeywords】", vBCrLF, 0)
q = gETsTRcUT(h, "【webdescription】", vBCrLF, 0)
u = gETsTRcUT(h, "【websitebottom】", vBCrLF, 0)
v = gETsTRcUT(h, "【webtemplate】", vBCrLF, 0)
w = gETsTRcUT(h, "【webimages】", vBCrLF, 0)
x = gETsTRcUT(h, "【webcss】", vBCrLF, 0)
y = gETsTRcUT(h, "【webjs】", vBCrLF, 0)
z = gETsTRcUT(h, "【flags】", vBCrLF, 0)
aA = gETsTRcUT(h, "【websiteurl】", vBCrLF, 0)
eND iF
cONn.eXEcUTe("update "& dB_pREfIX &"website  set webtitle='" & o & "',webkeywords='" & p & "',webdescription='" & q & "',websitebottom='" & u & "',webtemplate='" & v & "',webimages='" & w & "',webcss='" & x & "',webjs='" & y & "',flags='" & z & "',websiteurl='" & aA & "'")
cONn.eXEcUTe("delete from "& dB_pREfIX &"webcolumn")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle,target) values('ASPToPHP','新闻',1,'/asptophp/','|top|',-1,'在线ASP转PHP','_blank')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('ASP','新闻',2,'/asp/','|top|',-1,'ASP文章列表')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('PHP','新闻',3,'/php/','|top|',-1,'PHP文章列表')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('JS','新闻',4,'/js/','|top|',-1,'JS文章列表')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('HTML5','新闻',5,'/html5/','|top|',-1,'HTML5文章列表')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('CSS3','新闻',6,'/css3/','|top|',-1,'CSS3文章列表')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('问答专区','新闻',7,'/ask/','|top|',-1,'问答专区')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('联系作者','文本',8,'/contactauthor.html','|top|',-1,'联系作者')")
cONn.eXEcUTe("delete from "& dB_pREfIX &"webcolumn")
h = gETdIRtXTlISt("/Data/WebData/NavData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("导航", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "【webtitle】") > 0 tHEn
o = gETsTRcUT(d, "【webtitle】", vBCrLF, 0)
p = gETsTRcUT(d, "【webkeywords】", vBCrLF, 0)
q = gETsTRcUT(d, "【webdescription】", vBCrLF, 0)
r = gETsTRcUT(d, "【sortrank】", vBCrLF, 0)
iF r = "" tHEn r = 0
m = gETsTRcUT(d, "【filename】", vBCrLF, 0)
e = gETsTRcUT(d, "【columnname】", vBCrLF, 0)
cA = gETsTRcUT(d, "【columntype】", vBCrLF, 0)
z = gETsTRcUT(d, "【flags】", vBCrLF, 0)
j = gETsTRcUT(d, "【parentid】", vBCrLF, 0)
j = gETcOLuMNiD(j)
s = gETsTRcUT(d, "【labletitle】", vBCrLF, 0)
eA = gETsTRcUT(d, "【npagesize】", vBCrLF, 0)
iF eA="" tHEn eA = 10	
t=gETsTRcUT(d, "【target】", vBCrLF, 0)
n = aDSqL(gETsTRcUT(d, "【bodycontent】", "【/bodycontent】", 0))
n = cONtENtTRaNScODiNG(n)
iSOnHTmL=pHPtRIm(gETsTRcUT(d, "【isonhtml】", vBCrLF, 0))
iF iSOnHTmL="0" oR lCAsE(iSOnHTmL)="false" tHEn
iSOnHTmL=0
eLSe
iSOnHTmL=1
eND iF
gA=pHPtRIm(gETsTRcUT(d, "【nofollow】", vBCrLF, 0))
iF gA="1" oR lCAsE(gA)="true" tHEn
gA=tRUe
eLSe
gA=fALsE
eND iF
nA = aDSqL(gETsTRcUT(d, "【simpleintroduction】", "【/simpleintroduction】", 0))
nA = cONtENtTRaNScODiNG(nA)
n = aDSqL(gETsTRcUT(d, "【bodycontent】", "【/bodycontent】", 0))
n = cONtENtTRaNScODiNG(n)
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (webtitle,webkeywords,webdescription,columnname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target) values('" & o & "','" & p & "','" & q & "','" & e & "','" & cA & "'," & r & ",'" & m & "','" & z & "'," & j & ",'" & s & "','"& nA &"','" & n & "',"& eA &","& iSOnHTmL &","& gA &",'"& t &"')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"articledetail")
h = gETdIRtXTlISt("/Data/WebData/ArticleData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("文章", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "【title】") > 0 tHEn
d=d & vBCrLF
j = gETsTRcUT(d, "【parentid】", vBCrLF, 0)
j = gETcOLuMNiD(j)
f = aDSqL(gETsTRcUT(d, "【title】", vBCrLF, 0))
o = gETsTRcUT(d, "【webtitle】", vBCrLF, 0)
p = gETsTRcUT(d, "【webkeywords】", vBCrLF, 0)
q = gETsTRcUT(d, "【webdescription】", vBCrLF, 0)
k = gETsTRcUT(d, "【author】", vBCrLF, 0)
r = gETsTRcUT(d, "【sortrank】", vBCrLF, 0)
iF r = "" tHEn r = 0
l = gETsTRcUT(d, "【adddatetime】", vBCrLF, 0)
m = gETsTRcUT(d, "【filename】", vBCrLF, 0)
z = gETsTRcUT(d, "【flags】", vBCrLF, 0)
dA = gETsTRcUT(d, "【relatedtags】", vBCrLF, 0)
fA = aDSqL(gETsTRcUT(d, "【customaurl】", vBCrLF, 0))
t=gETsTRcUT(d, "【target】", vBCrLF, 0)
n = aDSqL(gETsTRcUT(d, "【bodycontent】", "【/bodycontent】", 0))
n = cONtENtTRaNScODiNG(n)
iSOnHTmL=pHPtRIm(gETsTRcUT(d, "【isonhtml】", vBCrLF, 0))
iF iSOnHTmL="0" oR lCAsE(iSOnHTmL)="false" tHEn
iSOnHTmL=0
eLSe
iSOnHTmL=1
eND iF
gA=pHPtRIm(gETsTRcUT(d, "【nofollow】", vBCrLF, 0))
iF gA="1" oR lCAsE(gA)="true" tHEn
gA=1
eLSe
gA=0
eND iF
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target) values(" & j & ",'" & f & "','" & o & "','" & p & "','" & q & "','" & k & "'," & r & ",'" & l & "','" & m & "','"& z &"','"& dA &"','" & n & "','" & nOW() & "',"& iSOnHTmL &",'"& fA &"',"& gA & ",'"& t &"')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"OnePage")
h = gETdIRtXTlISt("/Data/WebData/OnePageData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("单页", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "【webkeywords】") > 0 tHEn
d=d & vBCrLF
f = aDSqL(gETsTRcUT(d, "【title】", vBCrLF, 0))
mA = aDSqL(gETsTRcUT(d, "【displaytitle】", vBCrLF, 0))
o = gETsTRcUT(d, "【webtitle】", vBCrLF, 0)
p = gETsTRcUT(d, "【webkeywords】", vBCrLF, 0)
q = gETsTRcUT(d, "【webdescription】", vBCrLF, 0)
l = gETsTRcUT(d, "【adddatetime】", vBCrLF, 0)
m = gETsTRcUT(d, "【filename】", vBCrLF, 0)
nA = aDSqL(gETsTRcUT(d, "【simpleintroduction】", "【/simpleintroduction】", 0))
nA = cONtENtTRaNScODiNG(nA)
t=gETsTRcUT(d, "【target】", vBCrLF, 0)
n = aDSqL(gETsTRcUT(d, "【bodycontent】", "【/bodycontent】", 0))
n = cONtENtTRaNScODiNG(n)
iSOnHTmL=pHPtRIm(gETsTRcUT(d, "【isonhtml】", vBCrLF, 0))
iF iSOnHTmL="0" oR lCAsE(iSOnHTmL)="false" tHEn
iSOnHTmL=0
eLSe
iSOnHTmL=1
eND iF
gA=pHPtRIm(gETsTRcUT(d, "【nofollow】", vBCrLF, 0))
iF gA="1" oR lCAsE(gA)="true" tHEn
gA=1
eLSe
gA=0
eND iF
cONn.eXEcUTe("insert into "& dB_pREfIX &"onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target) values('" & f & "','"& mA &"','"& o &"','"& p &"','"& q &"','"& l &"','"& m &"',"& iSOnHTmL &",'"& nA &"','"& n &"',"& gA &",'"& t &"')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"Bidding")
h = gETdIRtXTlISt("/Data/WebData/BiddingData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("竞价", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "【webkeywords】") > 0 tHEn
p = gETsTRcUT(d, "【webkeywords】", vBCrLF, 0)
hA = gETsTRcUT(d, "【showreason】", vBCrLF, 0)
iA = gETsTRcUT(d, "【ncomputersearch】", vBCrLF, 0)
jA = gETsTRcUT(d, "【nmobliesearch】", vBCrLF, 0)
kA = gETsTRcUT(d, "【ncountsearch】", vBCrLF, 0)
lA = gETsTRcUT(d, "【ndegree】", vBCrLF, 0)
lA=gETnUMbER(lA)
iF lA="" tHEn
lA=0
eND iF
cONn.eXEcUTe("insert into "& dB_pREfIX &"Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values('" & p & "','"& hA &"',"& iA &","& jA &","& lA &")")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"TableComment")
eND sUB
fUNcTIoN cONtENtTRaNScODiNG(bYVaL a)
a = rEPlACe(rEPlACe(rEPlACe(rEPlACe(a, "<?", "&lt;?"), "?>", "?&gt;"), "<" & "%", "&lt;%"), "?>", "%&gt;")
iF iNStR(a, "[&html转码&]") > 0 tHEn
a = rEPlACe(rEPlACe(a, "[&html转码&]", ""), "<", "&lt;")
eND iF
iF iNStR(a, "[&全部换行&]") > 0 tHEn
a = rEPlACe(rEPlACe(a, "[&全部换行&]", ""), vBCrLF, vBCrLF & "<br>")
eND iF
cONtENtTRaNScODiNG=a
eND fUNcTIoN
%>

