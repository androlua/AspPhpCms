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
fUNcTIoN sHOwCLaSSnAMe(a, b, c,d, e)
dIM f,g,h,i,j,k
dIM l,m,n,o,p,q,r,s,t,u
dIM v,w,x,y
dIM z,aA,bA,cA, dA,eA, fA
dIM gA,hA,iA,jA,kA,lA,mA,nA,oA
dIM pA,qA,rA,sA,tA,uA,vA
dIM wA,xA,yA,zA,aBB,bBB,cBB,dBB,eBB
dIM fBB,gBB,hBB,iBB,jBB,kBB,lBB,mBB,nBB
dIM oBB,pBB,qBB,rBB,sBB,tBB,uBB,vBB,wBB,xBB,yBB,zBB
dIM aCCc,bCCc,cCCc,dCCc,eCCc,fCCc,gCCc,hCCc,iCCc
dIM jCCc,kCCc,lCCc,mCCc,nCCc,oCCc,pCCc,qCCc,rCCc
dIM sCCc,tCCc,uCCc,vCCc,wCCc,xCCc,yCCc,zCCc,aDDdD,bDDdD
dIM cDDdD,dDDdD,eDDdD
l = "选择|42|,"
dDDdD = "分类|42|Cate|分类重复,"
eDDdD = "发布时间|100|PubTime|日志发布时间重复,"
m = "QQ号码|70|QQ|QQ号码重复|QQ号码搜索,"
n = "QQ名称|200|QQName|QQ名称重复|QQ名称搜索,"
o = "操作||详细|||修改,"
p = "访客列表|80|VisitorsList||访客列表搜索,"
iCCc = "访客数量|80|VisitorsNumb||访客数量搜索,"
q = "空间权限|80|SpacePurview|空间权限重复|空间权限搜索,"
s = "QQ性别|60|QQSex|QQ性别重复|QQ性别搜索,"
t = "QQ年龄|60|QQAge|QQ年龄重复|QQ年龄搜索,"
u = "年龄|60|Age|年龄重复|年龄搜索,"
v = "大类名称|100|BigClassName|大类名称重复|大类名称搜索,"
w = "小类名称|100|SmallClassName|小类名称重复|小类名称搜索,"
fCCc = "子类名称|100|ThreeClassName|子类名称重复|子类名称搜索,"
mCCc = "搜索词|200|BigClassName|搜索词重复|搜索词搜索,"
nCCc = "相关词|200|SmallClassName|相关词重复|相关词搜索,"
x = "好友度|60|CountNumb," 	
y = "存在数|60|QQNumb,"
r = "登录时间|116|OnLineTime|登录时间重复|登录时间搜索,"
z = "日志类型|80|Category|日志类型重复|日志类型搜索,"
aA = "标题|204|Title|标题重复|标题搜索,"
bA = "日志ID|70|Blogid|日志ID重复,"
gA = "缩览图|100|PhotoPre,"
hA = "图片名称|100|PhotoName|图片名称重复|图片名称搜索,"
iA = "图片缩览图|100|BigPhotoUrl||图片缩览图搜索,"
jA = "图片ID|100|PhotoID|图片ID重复|图片ID搜索,"	
nA = "留言者QQ|70|MessageQQ|留言者QQ重复|留言者QQ搜索,"
oA = "留言时间|120|UpDateTime|留言时间重复|留言时间搜索,"
lA = "留言缩览图|100|PhotoUrl,"
cA = "留言内容||Content||留言内容搜索,"
iBB = "存在大小图|80|PhotoShowType|存在大小图重复|存在大小图搜索,"
x = "总数|60|CountNumb,"
pA = "添加时间|120|AddTime|添加时间重复|添加时间搜索,"
qA = "搜索值|100|SearchValue|搜索值重复|搜索值搜索,"
rA = "搜索标题|200|SearchTitle|搜索标题重复|搜索标题搜索,"
sA = "搜索内容|200|SearchContent||搜索内容搜索,"
tA = "搜索时间|80|SearchTime|搜索时间重复|搜索时间搜索,"
uA = "搜索排序|80|SearchSort|搜索排序重复|搜索排序搜索,"
vA = "域名/网址|200|域名/网址|域名重复|网址搜索/域名搜索,"
wA = "用户|100|UserName|用户重复|用户搜索,"
xA = "价格|60|Price|价格重复|价格搜索,"
yA = "运费|60|FarePrice|运费重复|运费搜索,"
zA = "省份|40|Province|省份重复|省份搜索,"
aBB = "城市|40|City|城市重复|城市搜索,"
bBB = "描述值|60|Description|描述值重复|描述值搜索,"
cBB = "评论数|60|ReplyNumb|评论数重复|评论数搜索,"
dBB = "评论者|60|ReplyName|评论者重复|评论者搜索,"
gCCc = "点击数|60|ClickNumb|点击数重复|点击数搜索,"	
mA = "备注|200|Content||备注搜索,"	
kA = "上传时间|80|UpDateTime|上传时间重复|上传时间搜索,"
fBB = "文件大小|60|ZipSize|文件大小重复,"
gBB = "运行平台|80|Windows|运行平台重复|运行平台搜索,"
xBB = "下载数|80|DownNumb|下载数重复|下载数搜索,"
hBB = "排序|60|Sort|排序重复|排序搜索,"
jBB = "招聘职位|100|WorkTitle|招聘职位重复|招聘职位搜索,"
kBB = "公司名称|100|Company|公司名称重复|公司名称搜索,"
lBB = "地区|40|DiQu|地区重复|地区搜索,"
mBB = "工作经验|90|WorkEXP|工作经验重复|工作经验搜索,"
nBB = "QQ备注名|90|QQBeiZhuName|QQ备注名重复|QQ备注名搜索,"
eBB = "QQ头像|100|QQ头像||,"
oBB = "作者|90|Author|作者重复|作者搜索,"
pBB = "人气|90|RenQi|人气重复|人气搜索,"
qBB = "网站标题|200|WebTitle|网站标题重复|网站标题搜索,"
rBB = "网站地址|200|WebUrl|网站地址重复|网站地址搜索,"
sBB = "星期数|200|DayNumb|星期数重复|星期数搜索,"
tBB = "单词|100|Ci|单词重复|单词搜索,"
uBB = "英文解释||Shi|英文解释重复|英文解释搜索,"
vBB = "破解值|80|PoJie|破解值重复|破解值搜索,"
wBB = "破解图片|80|PoJiePhoto,"
yBB = "英文|120|EN|英文重复|英文搜索,"
zBB = "中文|200|CN|中文重复|中文搜索,"
dA = "文件|150|FileName|文件重复|文件搜索,"
eA = "文件夹|120|FolderName|文件夹重复|文件夹搜索,"
fA = "目录路径||DirPath|目录路径重复|目录路径搜索,"
aCCc = "网址|200|HttpUrl|网址重复|网址搜索,"
bCCc = "播放时间|80|PlayTime|播放时间重复|播放时间搜索,"
cCCc = "播放次数|80|PlayNumb|播放次数重复|播放次数搜索,"
dCCc = "发布时间|100|PostingsTime|发布时间重复|发布时间搜索,"
eCCc = "导航名称|100|cname|导航名称重复|导航名称搜索,"
hCCc = "共同好友|60|MutualFriend|共同好友重复|共同好友搜索,"
jCCc = "支持数|80|SupportNumb|支持数重复|支持数搜索,"
kCCc = "提交日期|80|CreateDate|提交日期重复|提交日期搜索,"
lCCc = "是否通过|80|Through|是否通过重复|是否通过搜索,"
oCCc = "采纳率|80|AdoptionRate|采纳率重复|采纳率搜索,"
pCCc = "浏览次数|80|BrowseNumb|浏览次数重复|浏览次数搜索,"
qCCc = "邮箱|120|Email|邮箱重复|邮箱搜索,"
rCCc = "IP|120|IP|IP重复|IP搜索,"
sCCc = "添加时间|120|AddDateTime|添加时间重复|添加时间搜索,"
tCCc = "文件路径|120|FilePath|文件路径重复|文件路径搜索,"
uCCc ="用户积分|120|MyMoney|用户积分重复|用户积分搜索,"
vCCc = "提问时间|120|ReplyTime|提问时间重复|提问时间搜索,"
wCCc = "问问类型|120|AskType|问问类型重复|问问类型搜索,"
xCCc = "问问ID|120|AskId|问问ID重复|问问ID搜索,"
yCCc = "域名|120|WebSite|域名重复|域名搜索,"
zCCc = "页数|120|PageNumber|页数重|复页数搜索,"
aDDdD = "排名|120|Ranking|排名重复|排名搜索,"
bDDdD = "收录时间|120|IncludedTime|收录时间重复|收录时间搜索,"
cDDdD = "搜索引擎网址|120|SearchUrl|搜索引擎网址重复|搜索引擎网址搜索,"
iF cHEcKStR(a, "^Product$") tHEn
b = l & v & w & fCCc & aA & mA  & kA & o
c = "点击数"
d = "标题|内容"
eLSeIF cHEcKStR(a, "^QQNameTable$") tHEn
b = l & m & n & mA & o
c = "QQ号码|QQ名称"
d = "QQ号码|QQ名称|QQ名称和号码"
eLSeIF cHEcKStR(a, "^QQBeiZhu$") tHEn
b = l & m & nBB & o
c = "QQ号码|QQ名称"
d = "QQ号码|QQ备注名|QQ名称和号码"
eLSeIF cHEcKStR(a, "^QQ$") tHEn
iF rQ("Style") = "2" tHEn
b = l & m & n & s & u & kA & t & o
c = "QQ号码|QQ名称|QQ性别|年龄|上传时间|QQ年龄"
d = "QQ号码|QQ访客|QQ和访客"
eLSe
b = l & v & m & n & p & q & r & hCCc & iCCc & o
c = "QQ号码|QQ名称|空间权限|登录时间|访客数量"
d = "QQ号码|QQ访客|QQ和访客"
eND iF
eLSeIF cHEcKStR(a, "^GuanXiQQ$") tHEn
b = l & v & w & m & n & x & y & o
c = "好友度|存在数|好友度＋存在数|[联合查询]"
d = "QQ号码|QQ名称|QQ名称和号码"
eLSeIF cHEcKStR(a, "^DailyRcord$") tHEn
b = l & m & z & aA & cBB & bA & o
c = "QQ号码|评论数"
d = "QQ号码|日志标题|日志地址"
eLSeIF cHEcKStR(a, "^QQPhotoClass$") tHEn
b = l & v & m & gA & iBB & o
c = "QQ号码"
d = "大类名称|QQ号码|缩览图"
eLSeIF cHEcKStR(a, "^QQPhotoProduct$") tHEn
b = l & m & hA & iA & jA & iBB & o
c = "QQ号码"
d = "QQ号码|相册小图|相册大图"
eLSeIF cHEcKStR(a, "^QQPhotoMessage$") tHEn
b = l & nA &  m & n  & oA & lA & iBB & cA
c = "QQ号码|留言时间"
d = "QQ号码|留言图片|留言内容"
eLSeIF cHEcKStR(a, "^QQOnLine") tHEn
b = l &  m & r & o
c = "QQ号码|登录时间"
d = "QQ号码"
eLSeIF cHEcKStR(a, "^QQJournal") tHEn
b = l &  m & dDDdD &  bA & aA & eDDdD & o
c = "QQ号码|登录时间"
d = "QQ号码"
eLSeIF cHEcKStR(a, "^WithTable$") tHEn
b = l & v & w &  aA & x & o
c = "总数"
d = "标题|分析出图"
eLSeIF cHEcKStR(a, "^QQTemp$") tHEn
b = l &  m & pA & o
c = "QQ号码|添加时间"
d = "QQ号码"
eLSeIF cHEcKStR(a, "^SearchEngine$") tHEn
b = l &  qA & rA & tA & uA & sA & vA & o
c = "QQ号码|添加时间"
d = "搜索标题|搜索网址|域名"
eLSeIF cHEcKStR(a, "^TaoBaoProduct$") tHEn
b = l &  qA & wA & xA & yA & zA & aBB & bBB & cBB
c = "价格|运费|描述值|评论"
d = "用户|标题|价格"
eLSeIF cHEcKStR(a, "^Word$") tHEn
b = l &  aA & pA & hBB & o
c = "添加时间|排序"
d = "标题"
eLSeIF cHEcKStR(a, "^JOB_51Job$") tHEn
b = l & qA & jBB & kBB & aBB & lBB & kA & mBB  & o
c = "上传时间|排序"
d = "招聘职位|公司名称|职位简介|招聘职位和职位简介"
eLSeIF cHEcKStR(a, "^QQTouXiang$") tHEn
b = l & eBB & m & iBB & o
c = "添加时间|排序"
d = "标题"
eLSeIF cHEcKStR(a, "^Flash163SWF$") tHEn
b = l & aA & oBB & pBB & iBB & o
c = "标题|人气|作者"
d = "标题|图片地址|SWF地址|下载地址"
eLSeIF cHEcKStR(a, "^QQVisitorsStat$") tHEn
b = l & m & n & x & o
c = "QQ号码|QQ名称|总数"
d = "QQ号码|QQ名称|QQ名称和号码"
eLSeIF cHEcKStR(a, "^TempUrl$") tHEn
b = l & eA & dA & fA & o
c = "文件|文件夹|目录路径"
d = "文件|文件夹|目录路径"
eLSeIF cHEcKStR(a, "^Video$") tHEn
b = l & aA & aCCc & bCCc & cCCc & dCCc & oBB & o
c = "播放时间|播放次数|发布时间"
d = "视频图片|视频标题|视频网址|视频标题加网址"
eLSeIF cHEcKStR(a, "^Web$") tHEn
b = l & qBB & rBB & sBB & o
c = "星期数"
d = "网站标题|网站地址|网站标题加地址"
eLSeIF cHEcKStR(a, "^ce$") tHEn
b = l & tBB & uBB & o
c = "单词"
d = "单词|英文解释|单词加英文解释"
eLSeIF cHEcKStR(a, "^QQYingZheng$") tHEn
b = l & aA & vBB & wBB & o
c = "破解值"
d = "破解值"
eLSeIF cHEcKStR(a, "^CnEnWords$") tHEn
b = l & yBB & zBB & hBB & o
c = "排序"
d = "中英对照"
eLSeIF cHEcKStR(a, "^class$") tHEn
b = l & eCCc & aCCc & o
c = "导航名称"
d = "导航名称"
eLSeIF cHEcKStR(a, "^qqname$") tHEn
b = l & m & n & o
c = "QQ号码|QQ名称"
d = "QQ号码|QQ名称"	
eLSeIF cHEcKStR(a, "^baiduzhidao$") tHEn
b = l & v & w & aA & aCCc & oBB & cBB & dBB & oCCc & jCCc & kCCc & pCCc & lCCc & o
c = "提交日期|评论数|浏览次数|是否通过"
d = "|"
eLSeIF cHEcKStR(a, "^BaiduZhidaoWords$") tHEn
b = l & mCCc & nCCc & o
c = "|"
d = "|"	
eLSeIF cHEcKStR(a, "^StatisticalData$") tHEn
b = l & v & aA & x & o
c = "总数"
d = "|"
eLSeIF cHEcKStR(a, "^SoftTask$") tHEn
b = l & v & qCCc & mA & kA & tCCc & lCCc & o
c = ""
d = "|"	
eLSeIF cHEcKStR(a, "^Member$") tHEn
b = l & wA & uCCc & qCCc & rCCc & o
c = ""
d = "|"
eLSeIF cHEcKStR(a, "^UserLog$") tHEn
b = l & v & mA & rCCc & sCCc & o
c = ""
d = "|"
eLSeIF cHEcKStR(a, "^Feedback$") tHEn
b = l & qCCc & mA & rCCc & sCCc & o
c = ""
d = "|"
eLSeIF cHEcKStR(a, "^Words$") tHEn
b = l & v & qCCc & aA & rCCc & sCCc & o
c = ""
d = "|"
eLSeIF cHEcKStR(a, "^Ask$") tHEn
b = l & wCCc & v & xCCc & aA & cBB & vCCc & o
c = "提问时间"
d = "|"
eLSeIF cHEcKStR(a, "^SearchEngineInfoList$") tHEn
b = l & v & yCCc & aA & zCCc & aDDdD & bDDdD & cDDdD & o
c = ""
d = "|"
eLSe
cALl eERr("【"& a &"】表","未配置，已停止。注意：【请到 Fun_Table.Asp 页找到 ShowClassName 函数修改】")
eND iF
f=sPLiT(b, ",")
j=1
fOR eACh h iN f
iF h <> "" tHEn
g=sPLiT(h & "|||", "|")
e(j) = g(1)
i = i & "<td width="""& g(1) &""" align=""center"" bgcolor=""#FFFFFF"" class=""B14"">"& g(0) &"</td>" & vBCrLF
j = j +1
eND iF
nEXt
sHOwCLaSSnAMe = i
eND fUNcTIoN
fUNcTIoN hANdLEsEArCHsQL(a,b)
dIM c,d,e
iF lEFt(b,1) = """" aND rIGhT(b,1) = """" tHEn
b = lEFt(b, lEN(b)-1)
b = rIGhT(b, lEN(b)-1)
e = "真"
eND iF
iF b <> "" tHEn
iF a = "QQ号码搜索" tHEn
d = "QQ"
eLSeIF a = "QQ名称搜索" tHEn
d = "QQName"
eLSeIF a = "访客列表搜索" tHEn
d = "VisitorsList"
eLSeIF a = "大类名称搜索" tHEn
d = "BigClassName"
eLSeIF a = "小类名称搜索" tHEn
d = "SmallClassName"
eLSeIF a = "图片名称搜索" tHEn
d = "PhotoName"
eLSeIF a = "留言者QQ搜索" tHEn
d = "MessageQQ"
eLSeIF a = "登录时间搜索" tHEn
d = "OnLineTime"
eLSeIF a = "标题搜索" tHEn
d = "Title"
eLSeIF a = "添加时间搜索" tHEn
d = "AddTime"
eLSeIF a = "搜索值搜索" tHEn
d = "SearchValue"
eLSeIF a = "搜索标题搜索" tHEn
d = "SearchTitle"
eLSeIF a = "搜索时间搜索" tHEn
d = "SearchTime"
eLSeIF a = "搜索排序搜索" tHEn
d = "SearchSort"
eLSeIF a = "搜索内容搜索" tHEn
d = "SearchContent"
eLSeIF a = "搜索网址搜索" tHEn
d = "SearchHttpUrl"
eLSeIF a = "网址搜索" tHEn
d = "HttpUrl"
eLSeIF a = "域名搜索" tHEn
d = "WebSite"
eLSeIF a = "备注搜索" tHEn
d = "Content"
eLSeIF a = "上传时间搜索" tHEn
d = "UpDateTime"
eLSeIF a = "运行平台搜索" tHEn
d = "Windows"
eLSeIF a = "存在大小图搜索" tHEn
d = "PhotoShowType"
eLSeIF a = "图片ID搜索" tHEn
d = "PhotoID"
eLSeIF a = "公司名称搜索" tHEn
d = "Company"
eLSeIF a = "招聘职位搜索" tHEn
d = "WorkTitle"
eLSeIF a = "网站标题搜索" tHEn
d = "WebTitle"
eLSeIF a = "网站地址搜索" tHEn
d = "WebUrl"
eLSeIF a = "星期数搜索" tHEn
d = "DayNumb"
eLSeIF a = "单词搜索" tHEn
d = "Ci"
eLSeIF a = "英文解释搜索" tHEn
d = "Shi"
eLSeIF a = "图片缩览图搜索" tHEn
d = "BigPhotoUrl"
eLSeIF a = "QQ性别搜索" tHEn
d = "QQSex"
eLSeIF a = "QQ年龄搜索" tHEn
d = "QQAge"
eLSeIF a = "破解值搜索" tHEn
d = "PoJie"
eLSeIF a = "下载数搜索" tHEn
d = "DownNumb"
eLSeIF a = "评论数搜索" tHEn
d = "ReplyNumb"
eLSeIF a = "日志类型搜索" tHEn
d = "Category"
eLSeIF a = "英文搜索" tHEn
d = "EN"
eLSeIF a = "中文搜索" tHEn
d = "CN"
eLSeIF a = "排序搜索" tHEn
d = "Sort"
eLSeIF a = "文件搜索" tHEn
d = "FileName"
eLSeIF a = "文件夹搜索" tHEn
d = "FolderName"
eLSeIF a = "目录路径搜索" tHEn
d = "DirPath"
eLSeIF a = "播放时间搜索" tHEn
d = "PlayTime"
eLSeIF a = "播放次数搜索" tHEn
d = "PlayNumb"
eLSeIF a = "发布时间搜索" tHEn
d = "PostingsTime"
eLSeIF a = "作者搜索" tHEn
d = "Author"
eLSeIF a = "搜索词搜索" tHEn
d = "BigClassName"
eLSeIF a = "相关词搜索" tHEn
d = "SmallClassName"
eLSeIF a = "采纳率搜索" tHEn
d = "AdoptionRate"
eLSeIF a = "支持数搜索" tHEn
d = "SupportNumb"
eLSeIF a = "提交日期搜索" tHEn
d = "CreateDate"
eLSeIF a = "浏览次数搜索" tHEn
d = "BrowseNumb"
eLSeIF a = "是否通过搜索" tHEn
d = "Through"
eLSeIF a = "提问时间搜索" tHEn
d = "ReplyTime"
eLSeIF a = "问问ID搜索" tHEn
d = "AskId"
eLSeIF a <> "" tHEn
cALl eCHo(a, "搜索不存在")
eND iF
iF d<>"" tHEn
iF mDBpATh = "" tHEn
cALl oPEnCOnN()
iF cONn.eXEcUTe("Select "& d &" From ["& tABlE & "]")(0).tYPe = 3 tHEn
d = "Convert(VarChar, "& d &")"
eND iF
eND iF
c = "Where "& d &" Like '%"& b &"%'"
iF e = "真" tHEn
c = "Where "& d &" = '"& b &"'"
eND iF
eND iF
c = oRAnDSeARcH(c,d,b)
eND iF
hANdLEsEArCHsQL = c
eND fUNcTIoN
fUNcTIoN hANdLEaSCdESc(a, b)
iF b = "" tHEn
hANdLEaSCdESc = a
eXIt fUNcTIoN
eND iF
iF b = "QQ号码正排序" tHEn
a = a & "   Order By Convert(Money, QQ) Asc"	
eLSeIF b = "QQ号码倒排序" tHEn	
a = a & "   Order By Convert(Money, QQ) Desc"
eLSeIF b = "QQ名称正排序" tHEn
a = a & "   Order By QQName Asc"	
eLSeIF b = "QQ名称倒排序" tHEn	
a = a & "   Order By QQName Desc"
eLSeIF b = "备注为空" tHEn
iF iNStR(a, "Where ") > 0 tHEn a = a & "   And" eLSe a = a & "   Where"
a = a & " Content Is Null"	
eLSeIF b = "备注不为空" tHEn
iF iNStR(a, "Where ") > 0 tHEn a = a & "   And" eLSe a = a & "   Where"
a = a & " Content Is Not Null"	
eLSeIF b = "空间权限正排序" tHEn
a = a & "   Order By SpacePurview Asc"	
eLSeIF b = "空间权限倒排序" tHEn	
a = a & "   Order By SpacePurview Desc"
eLSeIF b = "登录时间正排序" tHEn
a = a & "   Order By OnLineTime Asc"	
eLSeIF b = "登录时间倒排序" tHEn	
a = a & "   Order By OnLineTime Desc"
eLSeIF b = "好友度正排序" tHEn
a = a & "   Order By CountNumb"
eLSeIF b = "好友度倒排序" tHEn
a = a & "   Order By CountNumb Desc"
eLSeIF b = "存在数正排序" tHEn
a = a & "   Order By QQNumb"
eLSeIF b = "存在数倒排序" tHEn
a = a & "   Order By QQNumb Desc"
eLSeIF b = "好友度＋存在数正排序" tHEn
a = a & "   Order By CountNumb+QQNumb"
eLSeIF b = "好友度＋存在数倒排序" tHEn
a = a & "   Order By CountNumb+QQNumb Desc"
eLSeIF b = "评论数正排序" tHEn
a = a & "   Order By ReplyNumb Asc"	
eLSeIF b = "评论数倒排序" tHEn	
a = a & "   Order By ReplyNumb Desc"
eLSeIF b = "留言时间正排序" tHEn
a = a & "   Order By UpDateTime Asc"	
eLSeIF b = "留言时间倒排序" tHEn	
a = a & "   Order By UpDateTime Desc"
eLSeIF b = "总数正排序" tHEn
a = a & "   Order By CountNumb Asc"	
eLSeIF b = "总数倒排序" tHEn	
a = a & "   Order By CountNumb Desc"
eLSeIF b = "添加时间正排序" tHEn
a = a & "   Order By AddTime Asc"	
eLSeIF b = "添加时间倒排序" tHEn	
a = a & "   Order By AddTime Desc"
eLSeIF b = "价格正排序" tHEn
a = a & "   Order By Price Asc"	
eLSeIF b = "价格倒排序" tHEn	
a = a & "   Order By Price Desc"
eLSeIF b = "运费正排序" tHEn
a = a & "   Order By FarePrice Asc"	
eLSeIF b = "运费倒排序" tHEn	
a = a & "   Order By FarePrice Desc"
eLSeIF b = "运费正排序" tHEn
a = a & "   Order By FarePrice Asc"	
eLSeIF b = "运费倒排序" tHEn	
a = a & "   Order By FarePrice Desc"
eLSeIF b = "描述值正排序" tHEn
a = a & "   Order By Description Asc"	
eLSeIF b = "描述值倒排序" tHEn	
a = a & "   Order By Description Desc"
eLSeIF b = "评论正排序" tHEn
a = a & "   Order By ReplyNum Asc"	
eLSeIF b = "评论倒排序" tHEn	
a = a & "   Order By ReplyNum Desc"
eLSeIF b = "上传时间正排序" tHEn
a = a & "   Order By UpDateTime Asc"	
eLSeIF b = "上传时间倒排序" tHEn	
a = a & "   Order By UpDateTime Desc"
eLSeIF b = "文件大小正排序" tHEn
a = a & "   Order By ZipSize Asc"	
eLSeIF b = "文件大小倒排序" tHEn	
a = a & "   Order By ZipSize Desc"
eLSeIF b = "运行平台正排序" tHEn
a = a & "   Order By Windows Asc"	
eLSeIF b = "运行平台倒排序" tHEn	
a = a & "   Order By Windows Desc"
eLSeIF b = "排序正排序" tHEn
a = a & "   Order By Sort Asc"	
eLSeIF b = "排序倒排序" tHEn	
a = a & "   Order By Sort Desc"
eLSeIF b = "标题正排序" tHEn
a = a & "   Order By Title Asc"	
eLSeIF b = "标题倒排序" tHEn	
a = a & "   Order By Title Desc"	
eLSeIF b = "人气正排序" tHEn
a = a & "   Order By RenQi Asc"	
eLSeIF b = "人气倒排序" tHEn	
a = a & "   Order By RenQi Desc"
eLSeIF b = "作者正排序" tHEn
a = a & "   Order By Author Asc"	
eLSeIF b = "作者倒排序" tHEn	
a = a & "   Order By Author Desc"
eLSeIF b = "单词正排序" tHEn
a = a & "   Order By Ci Asc"	
eLSeIF b = "单词倒排序" tHEn	
a = a & "   Order By Ci Desc"
eLSeIF b = "破解值正排序" tHEn
a = a & "   Order By PoJie Asc"	
eLSeIF b = "破解值倒排序" tHEn	
a = a & "   Order By PoJie Desc"
eLSeIF b = "QQ性别正排序" tHEn
a = a & "   Order By QQSex Asc"	
eLSeIF b = "QQ性别倒排序" tHEn	
a = a & "   Order By QQSex Desc"
eLSeIF b = "QQ年龄正排序" tHEn
a = a & "   Order By QQAge Asc"	
eLSeIF b = "QQ年龄倒排序" tHEn	
a = a & "   Order By QQAge Desc"
eLSeIF b = "年龄正排序" tHEn
a = a & "   Order By Age Asc"	
eLSeIF b = "年龄倒排序" tHEn	
a = a & "   Order By Age Desc"
eLSeIF b = "下载数正排序" tHEn
a = a & "   Order By DownNumb Asc"	
eLSeIF b = "下载数倒排序" tHEn	
a = a & "   Order By DownNumb Desc"
eLSeIF b = "文件正排序" tHEn
a = a & "   Order By FileName Asc"	
eLSeIF b = "文件倒排序" tHEn	
a = a & "   Order By FileName Desc"
eLSeIF b = "文件夹正排序" tHEn
a = a & "   Order By FolderName Asc"	
eLSeIF b = "文件夹倒排序" tHEn	
a = a & "   Order By FolderName Desc"
eLSeIF b = "目录路径正排序" tHEn
a = a & "   Order By DirPath Asc"	
eLSeIF b = "目录路径倒排序" tHEn	
a = a & "   Order By DirPath Desc"
eLSeIF b = "播放时间正排序" tHEn
a = a & "   Order By PlayTime Asc"	
eLSeIF b = "播放时间倒排序" tHEn	
a = a & "   Order By PlayTime Desc"
eLSeIF b = "播放次数正排序" tHEn
a = a & "   Order By PlayNumb Asc"	
eLSeIF b = "播放次数倒排序" tHEn	
a = a & "   Order By PlayNumb Desc"
eLSeIF b = "发布时间正排序" tHEn
a = a & "   Order By PostingsTime Asc"	
eLSeIF b = "发布时间倒排序" tHEn	
a = a & "   Order By PostingsTime Desc"
eLSeIF b = "点击数正排序" tHEn
a = a & "   Order By ClickNumb Asc"	
eLSeIF b = "点击数倒排序" tHEn	
a = a & "   Order By ClickNumb Desc"
eLSeIF b = "访客数量正排序" tHEn
a = a & "   Order By VisitorsNumb Asc"	
eLSeIF b = "访客数量倒排序" tHEn	
a = a & "   Order By VisitorsNumb Desc"
eLSeIF b = "提交日期正排序" tHEn
a = a & "   Order By CreateDate Asc"	
eLSeIF b = "提交日期倒排序" tHEn	
a = a & "   Order By CreateDate Desc"
eLSeIF b = "浏览次数正排序" tHEn
a = a & "   Order By BrowseNumb Asc"	
eLSeIF b = "浏览次数倒排序" tHEn	
a = a & "   Order By BrowseNumb Desc"
eLSeIF b = "是否通过正排序" tHEn
a = a & "   Order By Through Asc"	
eLSeIF b = "是否通过倒排序" tHEn	
a = a & "   Order By Through Desc"
eLSeIF b = "提问时间正排序" tHEn
a = a & "   Order By ReplyTime Asc"	
eLSeIF b = "提问时间倒排序" tHEn	
a = a & "   Order By ReplyTime Desc"
eLSeIF b = "联合查询" tHEn
cALl lIAnHEsEArCH()
eLSe
cALl eCHo(b, "排序不存在")
eND iF
hANdLEaSCdESc = a
eND fUNcTIoN
fUNcTIoN lIAnHEsEArCH()
dIM b, c
b = rEQuESt("SearchType")
c = rEQuESt("SearchValue")
iF b = "" aND iNStR(c,"|")>0 tHEn
cALl eCHo("", "联合")
dIM d,e,f,g,h,i
g = tRUe
d=sPLiT(c, "|")
fOR eACh f iN d
iF f<> "" tHEn
iF e = "" tHEn
e = "'"& f &"'"
eLSe
e = e & ",'"& f &"'"
eND iF
rS.oPEn"Select BigClassName From [GuanXiQQ] Where BigClassName = '"& f &"'",cONn,1,1
iF rS.eOF tHEn
h = h & "<div align=center><iframe width='800' height=100 frameborder=0 scrolling=no src='Print.Asp?act=处理分析QQ&QQ="&f&"'></iframe></div>"
i=i+1
g = fALsE
eND iF:rS.cLOsE
eND iF
nEXt
iF g = fALsE tHEn
h = h & "<div align=center style='color:red;'>提示：有未处理的关系QQ【<b>"& i &"</b>】个</div>"
cALl rW( h )
rESpONsE.eND()
eND iF
cONn.eXEcUTe("Delete From [GuanXiQQ] Where BigClassName='联合查询'")
rS.oPEn"Select * From [GuanXiQQ] Where BigClassName In("& e &")",cONn,1,1
wHIlE nOT rS.eOF
rSX.oPEn"Select * From [GuanXiQQ] Where BigClassName='联合查询' And QQ='"& rS("QQ") &"'",cONn,1,3
iF rSX.eOF tHEn
rSX.aDDnEW
rSX("BigClassName") = "联合查询"
rSX("SearchList") = c
rSX("SmallClassName") = rS("BigClassName")
rSX("QQ") = rS("QQ")
rSX("QQName") = rS("QQName")
rSX("CountNumb") = rS("CountNumb") + rS("QQNumb")
eLSe
rSX("CountNumb") = rSX("CountNumb") + rS("CountNumb") + rS("QQNumb")
rSX("QQNumb") = rSX("QQNumb") +1
iF iNStR("|"& rSX("SmallClassName") &"|", "|"& rS("QQ") &"|") = fALsE tHEn
rSX("SmallClassName") = rSX("SmallClassName") & "|" & rS("BigClassName")
eND iF
eND iF
rSX.uPDaTE:rSX.cLOsE	
rS.mOVeNExT:wENd:rS.cLOsE
cALl eERr("哈哈","哈哈")
rESpONsE.eND()
eND iF
eND fUNcTIoN
fUNcTIoN hANdLErESeT(a, b, c)
iF b = "" tHEn
hANdLErESeT = a
eXIt fUNcTIoN
eND iF
iF b = "QQ号码重复" tHEn
a = "Select QQ From ["& c &"] Group By QQ Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "QQ名称重复" tHEn
a = "Select QQName  From ["& c &"] Group By QQName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "空间权限重复" tHEn
a = "Select SpacePurview From ["& c &"] Group By SpacePurview Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "登录时间重复" tHEn
a = "Select OnLineTime  From ["& c &"] Group By OnLineTime Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "大类名称重复" tHEn
a = "Select BigClassName From ["& c &"] Group By BigClassName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "小类名称重复" tHEn
a = "Select SmallClassName  From ["& c &"] Group By SmallClassName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "日志类型重复" tHEn
a = "Select QQcategory From ["& c &"] Group By QQcategory Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "标题重复" tHEn
a = "Select Title  From ["& c &"] Group By Title Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "评论数重复" tHEn
a = "Select ReplyNumb  From ["& c &"] Group By ReplyNumb Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "日志ID重复" tHEn
a = "Select Blogid  From ["& c &"] Group By Blogid Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "添加时间重复" tHEn
a = "Select AddTime  From ["& c &"] Group By AddTime Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "域名重复" tHEn
a = "Select WebSite  From ["& c &"] Group By WebSite Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "搜索值重复" tHEn
a = "Select SearchValue  From ["& c &"] Group By SearchValue Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "用户重复" tHEn
a = "Select UserName  From ["& c &"] Group By UserName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "价格重复" tHEn
a = "Select Price  From ["& c &"] Group By Price Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "运费重复" tHEn
a = "Select FarePrice  From ["& c &"] Group By FarePrice Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "省份重复" tHEn
a = "Select Province  From ["& c &"] Group By Province Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "城市重复" tHEn
a = "Select City  From ["& c &"] Group By City Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "描述值重复" tHEn
a = "Select Description  From ["& c &"] Group By Description Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "评论重复" tHEn
a = "Select ReplyNum  From ["& c &"] Group By ReplyNum Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "QQ备注名重复" tHEn
a = "Select QQBeiZhuName  From ["& c &"] Group By QQBeiZhuName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "公司名称重复" tHEn	
a = "Select Company  From ["& c &"] Group By Company Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "招聘职位重复" tHEn	
a = "Select WorkTitle  From ["& c &"] Group By WorkTitle Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "作者重复" tHEn	
a = "Select Author  From ["& c &"] Group By Author Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "人气重复" tHEn	
a = "Select RenQi  From ["& c &"] Group By RenQi Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "存在大小图重复" tHEn	
a = "Select PhotoShowType  From ["& c &"] Group By PhotoShowType Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "网站标题重复" tHEn	
a = "Select WebTitle  From ["& c &"] Group By WebTitle Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "网站地址重复" tHEn	
a = "Select WebUrl  From ["& c &"] Group By WebUrl Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "星期数重复" tHEn	
a = "Select DayNumb  From ["& c &"] Group By DayNumb Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "上传时间重复" tHEn	
a = "Select UpDateTime  From ["& c &"] Group By UpDateTime Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "QQ年龄重复" tHEn	
a = "Select QQAge  From ["& c &"] Group By QQAge Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "QQ性别重复" tHEn	
a = "Select QQSex  From ["& c &"] Group By QQSex Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "年龄重复" tHEn	
a = "Select Age  From ["& c &"] Group By Age Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "运行平台重复" tHEn	
a = "Select Windows  From ["& c &"] Group By Windows Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "下载数重复" tHEn	
a = "Select DownNumb  From ["& c &"] Group By DownNumb Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "文件大小重复" tHEn	
a = "Select ZipSize  From ["& c &"] Group By ZipSize Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "文件重复" tHEn	
a = "Select FileName  From ["& c &"] Group By FileName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "文件夹重复" tHEn	
a = "Select FolderName  From ["& c &"] Group By FolderName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "目录路径重复" tHEn	
a = "Select DirPath  From ["& c &"] Group By DirPath Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "网址重复" tHEn	
a = "Select HttpUrl  From ["& c &"] Group By HttpUrl Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "播放时间重复" tHEn	
a = "Select PlayTime  From ["& c &"] Group By PlayTime Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "播放次数重复" tHEn	
a = "Select PlayNumb  From ["& c &"] Group By PlayNumb Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "发布时间重复" tHEn	
a = "Select PostingsTime  From ["& c &"] Group By PostingsTime Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "子类名称重复" tHEn	
a = "Select ThreeClassName  From ["& c &"] Group By ThreeClassName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "点击数重复" tHEn	
a = "Select ClickNumb  From ["& c &"] Group By ClickNumb Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "搜索词重复" tHEn	
a = "Select BigClassName  From ["& c &"] Group By BigClassName Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "分类重复" tHEn	
a = "Select Cate  From ["& c &"] Group By Cate Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "日志发布时间重复" tHEn	
a = "Select pubTime  From ["& c &"] Group By pubTime Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "单词重复" tHEn	
a = "Select Ci  From ["& c &"] Group By Ci Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "英文解释重复" tHEn	
a = "Select Shi  From ["& c &"] Group By Shi Having(Count(*))>" & cINt(rQ("N"))
eLSeIF b = "英文解释重复" tHEn	
a = "Select Shi  From ["& c &"] Group By Shi Having(Count(*))>" & cINt(rQ("N"))
eLSe
cALl eCHo(b, "重复不存在")
eND iF
hANdLErESeT = a
eND fUNcTIoN
fUNcTIoN sELfSQl(a, b, c)
dIM d
b = rEGeXP_REpLAcE(b, "SQL *=", "Sql ")
iF cHEcKStR(b, "SQL ") = tRUe tHEn
d = tRIm(b)
d = tRIm( rIGhT(d, lEN(d) - 4) )
iF cHEcKStR(d, "Delete ") = tRUe tHEn
d = d & " &nbsp; <a href=""?act=ClearTable&MDBPath="&rEQuESt("MDBPath")&"&SQL="&d&""" target=""_blank"" class=""ARed"" onClick=""return Confirm();"">删除记录</a>"
cALl eERr("删除很危险，请慎重", d)
eLSeIF cHEcKStR(d, "Update ") = tRUe tHEn
cALl eERr("更新表操作", d)
eLSeIF cHEcKStR(d, "Select ") = fALsE tHEn
d = "Select * From ["& c &"] " & d
eND iF
a = d
eND iF
sELfSQl = a
eND fUNcTIoN
fUNcTIoN rEPlACeSEaRChVAlUE(a, b)
dIM c,d
iF iNStR(b," Or ")>0 tHEn
c = sPLiT(b, " Or ")
fOR eACh d iN c
iF d <> "" tHEn
a = rEPlACe(a, d,"<font color=red><b>" & d & "</b></font>")
eND iF
nEXt
eLSeIF iNStR(b," And ")>0 tHEn
c = sPLiT(b, " And ")
fOR eACh d iN c
iF d <> "" tHEn
a = rEPlACe(a, d,"<font color=red><b>" & d & "</b></font>")
eND iF
nEXt
eLSeIF a <> "" tHEn
a = rEPlACe(a, b,"<font color=red><b>" & b & "</b></font>")
eND iF
rEPlACeSEaRChVAlUE = a
eND fUNcTIoN
sUB sHOwCOpYLiST(a,b,c, d)
iF d <> "" tHEn d = "用时：" & pRInTTiMEvALuE(dATeDIfF("s", d, nOW()) ) & "，&nbsp;"
cALl eCHo("【"& a &"】", "共有【"& b &"】条，&nbsp;" & d & "<a href=javascript:CopyTEXT('CopyContent');>复制</a>")
cALl rW("<div style='margin-left:220px;'><textarea name='CopyContent' id='CopyContent' style='width:800px;height:400px;'>"& c &"</textarea></div>")
eND sUB
%>


