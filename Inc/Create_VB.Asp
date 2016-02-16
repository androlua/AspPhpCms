<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-15
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#iNClUDe fILe = "Config.Asp"-->
<%
sELeCT cASe rEQuESt("act")
cASe "CreateVBDialog","vb1" : cREaTEvBDiALoG()	
eND sELeCT
rESpONsE.eND()
sUB cREaTEvBDiALoG()
dIM sPLsTR,i,s,c,cONtENt,rOOtFOlDEr,zFOrMFoLDeR,dATaFOlDEr,pATh,tOPaTH,fORmNAmE,bASlISt,fRMlISt,tOOlSMeNU,fRMlIStSTr,oPEnFRoM,nTOoLS,tOOlSClICk,mENuTItLE
dIM yESsORtPLuG,tEMpSTr,tABlECoNFiG,fORmSTrLIsT,fORmSEtLIsT,tABlENaME,sOFtVErSIoN,tHIsMDbPAtH,tHIsACcESsPAsS,cTLfILeLIsT,sTArTStR,eNDsTR
dIM cONfIGfOLdER
dIM hELpFOlDEr	
dIM tOOlSNaME	
dIM nTOoLS2	
dIM nTOoLS3	
dIM tEMpCOnTEnT
sOFtVErSIoN = "Version1.1"
rOOtFOlDEr = "/VB工程/"
dIM tOFoLDeR	
iF cHEcKFoLDeR(rOOtFOlDEr) tHEn
fOR i=0 tO 90
s = "/VB工程_"& i &"/"
iF cHEcKFoLDeR(s)=fALsE aND tOFoLDeR="" tHEn
tOFoLDeR=s
eLSeIF cHEcKFoLDeR(s)=tRUe aND tOFoLDeR<>"" tHEn
tOFoLDeR=""
eND iF
nEXt
eND iF
cALl mOVeFOlDEr(rOOtFOlDEr, tOFoLDeR)
cALl dELeTEfOLdER(rOOtFOlDEr)
cALl cREaTEfOLdER(rOOtFOlDEr)
zFOrMFoLDeR = rOOtFOlDEr & "zForm/"
cALl cREaTEfOLdER(zFOrMFoLDeR)
hELpFOlDEr = rOOtFOlDEr & "Help/"
cALl cREaTEfOLdER(hELpFOlDEr)	
cALl cOPyFIlE("/DataDir/VB模块/Help/SystemLogin.ini", hELpFOlDEr & "SystemLogin.ini")
cALl cOPyFIlE("/DataDir/VB模块/Help/Js处理.html", hELpFOlDEr & "Js处理.html")
cALl cOPyFIlE("/DataDir/VB模块/右键下拉菜单代码.txt", rOOtFOlDEr & "右键下拉菜单代码.txt")
cALl cOPyFIlE("/DataDir/VB模块/快速登录.vbs", rOOtFOlDEr & "快速登录.vbs")
c="|Print.Asp|Access.Asp|Cai.Asp|EncDec.Asp|Function.Asp|GetWord.Asp|RegExp.Asp|StringNumber.Asp|XML.Asp|Time.Asp|URL.Asp|FSO.Asp|Check.Asp|Html.Asp|AdodbStream.Asp|Dictionary.Asp|PinYin.Asp|2014_Array.Asp|2014_Css.Asp|2014_GBUTF.Asp|2015_Formatting.Asp|2015_Param.Asp|2015_ASP.Asp|2015_Color.Asp|FunHTML.Asp|2015_PHP.Asp|2015_WebSql.Asp|2015_hexSwitch.Asp|ASPPHPAccess.Asp"
dIM sEArCHsTR,rEPlACeSTr
sPLsTR=sPLiT(c,"|")
fOR eACh pATh iN sPLsTR
iF pATh <> "" aND 1=1 tHEn
fORmNAmE = mID(pATh,1,iNStRReV(pATh,".")-1)
iF iNStR("0123456789",lEFt(fORmNAmE,1))>0 tHEn
fORmNAmE="y_" & fORmNAmE	
eND iF
cONtENt = rEAdFIlE(pATh,"")	
sEArCHsTR = gETsTRcUT(cONtENt,"'footer start","'footer end",2)
iF sEArCHsTR<>"" tHEn
rEPlACeSTr=vBCrLF & gETfTExT("\DataDir\VB模块\2015_Param.Asp.txt")
cONtENt=rEPlACe(cONtENt,sEArCHsTR,rEPlACeSTr)
cALl eCHo(pATh,"替换footer成功")
eND iF
fOR i =1 tO 10
sEArCHsTR = gETsTRcUT(cONtENt,"'vbdel start","'vbdel end",1)
iF sEArCHsTR<>"" tHEn
cONtENt=rEPlACe(cONtENt,sEArCHsTR,"")
eND iF
nEXt
iF pATh = "ZClassAspCode.Asp" tHEn
tOPaTH = zFOrMFoLDeR & fORmNAmE & ".cls"
cONtENt = sTRcUT(cONtENt,"'VB开始","'VB结束",2)
c=""
c=c & "VERSION 1.0 CLASS" & vBCrLF
c=c & "BEGIN" & vBCrLF
c=c & "  MultiUse = -1  'True" & vBCrLF
c=c & "  Persistable = 0  'NotPersistable" & vBCrLF
c=c & "  DataBindingBehavior = 0  'vbNone" & vBCrLF
c=c & "  DataSourceBehavior  = 0  'vbNone" & vBCrLF
c=c & "  MTSTransactionMode  = 0  'NotAnMTSObject" & vBCrLF
c=c & "END" & vBCrLF
c=c & "Attribute VB_Name = ""Z_"& fORmNAmE &"""" & vBCrLF	
c=c & "Attribute VB_GlobalNameSpace = False" & vBCrLF
c=c & "Attribute VB_Creatable = False" & vBCrLF
c=c & "Attribute VB_PredeclaredId = False" & vBCrLF
c=c & "Attribute VB_Exposed = False" & vBCrLF
cONtENt=c & cONtENt
bASlISt=bASlISt & "class="& fORmNAmE &"; zForm\"& fORmNAmE &".cls" & vBCrLF
eLSe
tOPaTH = zFOrMFoLDeR & fORmNAmE & ".bas"
cONtENt = sTRcUT(cONtENt,"<" & "%","%" & ">",2)
cONtENt = "Attribute VB_Name = ""Z_"& fORmNAmE &"""" & vBCrLF & cONtENt
bASlISt=bASlISt & "Module=Z_"& fORmNAmE &"; zForm\"& fORmNAmE &".bas" & vBCrLF
eND iF
tEMpCOnTEnT=cONtENt
cONtENt=aSPtOVb(cONtENt)
iF cONtENt="" tHEn
cALl eERr(fORmNAmE,tEMpCOnTEnT)
eND iF
sTArTStR="Function GetThisUrl()"
eNDsTR="End Function"
s=gETsTRcUT(cONtENt,sTArTStR,eNDsTR,1)
iF s<>"" tHEn
cONtENt=rEPlACe(cONtENt,s,  sTArTStR & vBCrLF & eNDsTR)
eND iF
cONtENt = rEPlACe(cONtENt,vBTaB,"    ")	
cALl eCHo(fORmNAmE,tOPaTH)
cALl cREaTEfILe(tOPaTH,cONtENt)
eND iF
nEXt
pATh = "/DataDir/VB模块/Manage.vbp"
cONtENt = gETfTExT(pATh)
sPLsTR=sPLiT(cONtENt,vBCrLF) : cONtENt = ""
fOR eACh s iN sPLsTR
iF lEFt(tRIm(s),1)<>"'" tHEn
cONtENt=cONtENt & s & vBCrLF
eND iF
nEXt
cONtENt = rEPlACe(cONtENt,"{Bas列表}",bASlISt)
fRMlIStSTr = "MDIForm1|Notepad|FrmHide|Login|IE|AutoAddTable|WebLog|WebIP|Eval|SortPlug|Test|Share|ShareEdition2|QQShareConfig|QQShareUrl|FrmEdit|QQShareSendUrl|YingZheng|"
fRMlIStSTr="MDIForm1|Notepad|FrmHide|Login|IE|Share|ShareEdition2|QQShareConfig|QQShareUrl|QQShareSendUrl|FrmEdit"
fRMlIStSTr="MDIForm1|FrmHide|FrmEdit|Login|TableDialog|Notepad|IE|-|ShareEdition2|QQShareConfig|QQShareUrl|QQShareSendUrl|-|FrmCai|CaiManage|UpDateWebConfig|-|XiCiWebDialog|XiCiWebMDB|-|CaiBaiduUrl|BaiduCai|-|#SortPlug|WebCrack|Test|DownList|IEDebug|-|AutoAddTable|Ying|-|SortPlug|PseudoOriginal|-|Scan|WebShell|Eval|WebServer|-|QQ|Qzone|-|"
fRMlIStSTr=      "MDIForm1|FrmHide|FrmEdit|Login|TableDialog|Notepad|IE|InputLocalFile|InputSqlTable|-|FrmCrateNewWeb|WebUrlScan|FrmCreateFunction|WebIeBox|-|Test|IEDebug|IEAutomatic|IEAutoHandle|-|Eval|-|FrmCai|CaiManage|-|WebAdminScan|ExcellentUrl|SmallTool|ColorPicker|TxtEdit|-|FrmSortPlug|AskDa|ZNRobot|JobWeb|JobCompany|FormJobCai|ComputerDir|analogBatchUP|"
fRMlIStSTr=fRMlIStSTr & "|FrmCrateNewHtmlPage|SinglePage|FrameLayout|FrmWebTemplateView|FrmCreateWebLable|UserMakeNav|--2|FileScan2015|HTML5CSS2|XyWebUp|MYProgram|--2|FrmAutoAddWebDefaultInfo|--2|FrmControlDialog|FrmSqlIn|FrmProgrameTransformation|IMitationWebInGoogleSEO|WebShell|FrmEvScan|FrmTestDialog1|FrmTestDialog2|FrmDown|FrmCrateNewHtmlPageOLD|"
nTOoLS = 0	
sPLsTR=sPLiT(fRMlIStSTr,"|")
fOR eACh s iN sPLsTR
iF s <> "" aND lEFt(s,1)<>"#" tHEn
iF iNStR("|-|IE|AutoAddTable|WebLog|WebIP|WebSite|Eval|SortPlug|Test|Share|QQShareConfig|QQShareUrl|QQShareSendUrl|ShareEdition2|FrmCai|CaiManage|UpDateWebConfig|XiCiWebDialog|XiCiWebMDB|IEDebug|IEAutomatic|IEAutoHandle|BaiduCai|CaiBaiduUrl|Ying|PseudoOriginal|Scan|WebShell|WebServer|WebCrack|DownList|QQ|QQName|QQVisitors|Qzone|BaiduZhidao|BaiduZhidaoWords|StatisticalData|BaiduZhidaoData|BaiduZhidaoWordsData|BaiduZhidaoMain|SearchEngine|SearchEngineInfoList|WebAdminScan|WebManage|WebIeBox|SinglePage|FrmSMS|SMSInfo|LocaDir|MYProgram|SmallTool|HTML5CSS2|FrmCrateNewWeb|FrmCrateNewHtmlPageOLD|TemplateCodeCreate|WebSiteList|SqlServerWebUrl|ShieldWebSiteList|AsynchDown|WebSiteInfo|FrmSortPlug|ExcellentUrl|WebUrlScan|FrmHangUp|XyWebUp|FrameLayout|FrmCreateFunction|QQJournal|AskDa|ZNRobot|JobWeb|FormJobCai|UserMakeNav|JobCompany|IMitationWebInGoogleSEO|FrmCrateNewHtmlPage|FileScan2015|FrmCreateWebLable||FrmWebTemplateView|ComputerDir|FrmAutoAddWebDefaultInfo|FrmControlDialog|FrmSqlIn|FrmProgrameTransformation|analogBatchUP|jiayuan|FrmEvScan|FrmTestDialog1|FrmTestDialog2|FrmDown|","|"& s &"|") > 0 oR lEFt(s,2)="--" tHEn
mENuTItLE="" : tABlECoNFiG="" : tABlENaME="" : tHIsACcESsPAsS="" : tHIsMDbPAtH=""
iF s = "SortPlug" tHEn
mENuTItLE = "模拟点击"
yESsORtPLuG = "OK"	
cALl cOPyFIlE("/DataDir/VB模块/Action.ini", rOOtFOlDEr & "Action.ini")	
eLSeIF s = "UserMakeNav" tHEn
mENuTItLE = "网站导航生成"
eLSeIF s = "FileScan2015" tHEn
mENuTItLE = "文件搜索2015"
eLSeIF s = "FrmControlDialog" tHEn
mENuTItLE = "控制面板"
eLSeIF s = "FrmSqlIn" tHEn
mENuTItLE = "Sql注入"
eLSeIF s = "FrmProgrameTransformation" tHEn
mENuTItLE = "程序转换"
eLSeIF s = "analogBatchUP" tHEn
mENuTItLE = "模似批量上传"
eLSeIF s = "FrmEvScan" tHEn
mENuTItLE = "EvScan"
eLSeIF s = "FrmTestDialog1" tHEn
mENuTItLE = "测试面板1"
eLSeIF s = "FrmTestDialog2" tHEn
mENuTItLE = "测试面板2"
eLSeIF s = "FrmDown" tHEn
mENuTItLE = "下载文件"
eLSeIF s = "IMitationWebInGoogleSEO" tHEn
mENuTItLE = "仿站在Google优化"
cALl cOPyFOlDEr("/DataDir/VB模块/IMitationWebInGoogleSEO",rOOtFOlDEr & "/IMitationWebInGoogleSEO")	
eLSeIF s = "XyWebUp" tHEn
mENuTItLE = "批量上传网站"
eLSeIF s = "FrmCreateFunction" tHEn
mENuTItLE = "生成函数面板"
eLSeIF s = "FrmSortPlug" tHEn
mENuTItLE = "模拟操作软件"	
eLSeIF s = "FrameLayout" tHEn
mENuTItLE = "网页框架布局"
eLSeIF s = "FrmHangUp" tHEn
mENuTItLE = "禁止窗口必需验证"	
eLSeIF s = "MYProgram" tHEn
mENuTItLE = "我的程序"
cALl cOPyFIlE("/DataDir/VB模块/AspFunction.ini", hELpFOlDEr & "/AspFunction.ini")	
eLSeIF s = "SmallTool" tHEn
mENuTItLE = "小工具"
eLSeIF s = "HTML5CSS2" tHEn
mENuTItLE = "Html5+Css2快速生成工具"
cTLfILeLIsT = cTLfILeLIsT & "UserControl=zForm\ControlDialog.ctl" & vBCrLF	
cALl cOPyFIlE("\DataDir\VB模块\ControlDialog.ctl", zFOrMFoLDeR & "ControlDialog.ctl")	
cALl cOPyFIlE("\DataDir\VB模块\ControlDialog.ctx", zFOrMFoLDeR & "ControlDialog.ctx")	
eLSeIF s = "FrmCrateNewWeb" tHEn
mENuTItLE = "创建新网页"	
eLSeIF s = "FrmCrateNewHtmlPageOLD" tHEn
mENuTItLE = "创建新网页(旧版)"	
eLSeIF s = "FrmCreateWebLable" tHEn
mENuTItLE = "生成网站嵌套标签"	
eLSeIF s = "FrmCrateNewHtmlPage" tHEn
mENuTItLE = "创建HTML页面"
eLSeIF s = "TemplateCodeCreate" tHEn
mENuTItLE = "模板代码创建生成器"
eLSeIF s = "FrmWebTemplateView" tHEn
mENuTItLE = "网站模板预览"
eLSeIF s = "FrmAutoAddWebDefaultInfo" tHEn
mENuTItLE = "自动添加网站默认信息"
eLSeIF s = "IE" tHEn
mENuTItLE = "浏览器"
eLSeIF s = "Test" tHEn
mENuTItLE = "测试窗口"
eLSeIF s = "AutoAddTable" tHEn
mENuTItLE = "自动填表"
eLSeIF s = "YingZheng" tHEn
mENuTItLE = "破解验证码"
eLSeIF s = "Ying" tHEn
mENuTItLE = "简易验证码识别系统"	
cALl cOPyFOlDEr("/DataDir/VB模块/图片破解", rOOtFOlDEr & "图片破解")	
eLSeIF s = "XiCiWebDialog" tHEn
mENuTItLE = "西祠论坛群发"	
eLSeIF s = "FrmSMS" tHEn
mENuTItLE = "短信"	
eLSeIF s = "SMSInfo" tHEn
mENuTItLE = "短信管理"	
tABlENaME = "SMSInfo"
tHIsACcESsPAsS="****"	
tHIsMDbPAtH = " ""I:\个人制作\个人\短信\SMS.mdb"""
tABlECoNFiG = tABlECoNFiG & "发信人|DXName|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "收信人|ToName|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "发信时期|AddDate|1000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "留言内容|Content|4000|True[分]" 	
eLSeIF s = "LocaDir" tHEn
mENuTItLE = "本地目录"	
tABlENaME = "LocaDir" 	
tHIsMDbPAtH = "App.Path & ""/../../网站备份\数据库\LocaDir.Mdb"""
tHIsMDbPAtH="""SqlServer数据库"""
tABlECoNFiG = tABlECoNFiG & "文件夹|FolderPath|5000|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件名称|FileName|3500|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件大小|FileSize|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件类型|FileType|1200|True[分]"
eLSeIF s = "ComputerDir" tHEn
mENuTItLE = "电脑Scan"	
tABlENaME = "ComputerDir" 	
tHIsMDbPAtH = "App.Path & ""/../../网站备份\数据库\ComputerDir.mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|1600|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件路径|FilePath|3500|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件名称|FileName|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件大小|FileSize|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "文件类型|FileType|1200|True[分]"
eLSeIF s = "XiCiWebMDB" tHEn
mENuTItLE = "西祠论坛数据管理"	
tABlENaME = "XiCiWeb"
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|6000|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "是否使用|Through|1000|True[分]" 	
eLSeIF s = "WebLog" tHEn
mENuTItLE = "网站日志"	
tABlENaME = "WebLog"	
tHIsMDbPAtH = "GetIniS(""init"", ""DefaultQQAccessPath"", """") & ""\WebLog.Mdb"""
tABlECoNFiG = tABlECoNFiG & "来访网址|GoUrl|3500|True[分]"
tABlECoNFiG = tABlECoNFiG & "当前浏览网址|HttpUrl|3500|True[分]"
tABlECoNFiG = tABlECoNFiG & "访问时间|GoDateTime|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "搜索引擎类型|SearchEngineType|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "搜索关键词|SearchWord|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "IP|IP|1600|True[分]"
tABlECoNFiG = tABlECoNFiG & "IE|IE|2200|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "日期|AddDate|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|2000|True[分]" 	
eLSeIF s = "WebIP" tHEn
mENuTItLE = "网站流量"
tABlENaME = "WebIP"
tHIsMDbPAtH = "GetIniS(""init"", ""DefaultQQAccessPath"", """") & ""\WebLog.Mdb"""
tABlECoNFiG = tABlECoNFiG & "添加日期|AddDate|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "浏览次数|PVCount|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名数|WebSiteCount|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "IP|IPCount|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "IE|IECount|1000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "百度数|Baidu|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "Google数|Google|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "Yahoo数|Yahoo|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "搜搜数|Soso|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "360数|Cn360|1000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "QQ空间数|Qzone|1000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "微信数|WeiXin|1000|True[分]" 	
eLSeIF s = "jiayuan" tHEn
mENuTItLE = "世纪佳缘"
tABlENaME = "jiayuan"
tHIsMDbPAtH = """../../网站备份/数据库/jiayuan.mdb"""
tABlECoNFiG = tABlECoNFiG & "会员ID|uid|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "昵称|nickname|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "性别|sex|800|True[分]"
tABlECoNFiG = tABlECoNFiG & "年龄|Age|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "身高|height|800|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "体重|Weight|1000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "婚姻|marriage|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "教育|education|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "工资|minMonthlySalary|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "兄弟姐妹|BrothersAndSisters|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "个人介绍|shortnote|2000|True[分]"
eLSeIF s = "AskDa" tHEn
mENuTItLE = "遇到问题和解决"
tABlENaME = "AskDa"
tHIsMDbPAtH = """../../网站备份/数据库/AskDa.mdb"""
tABlECoNFiG = tABlECoNFiG & "问|Ask|5000|True[分]"
tABlECoNFiG = tABlECoNFiG & "答|Da|5000|True[分]"
tABlECoNFiG = tABlECoNFiG & "添加日期|AddDate|3000|True[分]"
eLSeIF s = "ZNRobot" tHEn
mENuTItLE = "智慧机器人"
tABlENaME = "ZNRobot"
tHIsMDbPAtH = """../../网站备份/数据库/ZNRobot.mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|1600|True[分]"	
tABlECoNFiG = tABlECoNFiG & "标题|Title|4000|True[分]"	
tABlECoNFiG = tABlECoNFiG & "相关标签|RelatedTags|4000|True[分]"
eLSeIF s = "JobWeb" tHEn
mENuTItLE = "招聘岗位管理"
tABlENaME = "JobWeb"
tHIsMDbPAtH = """../../网站备份/数据库/JobAccess.mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|1600|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "搜索关键词|SearchWord|1300|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "标题|Title|3500|True[分]"	
tABlECoNFiG = tABlECoNFiG & "城市|City|800|True[分]"
tABlECoNFiG = tABlECoNFiG & "区域|Area|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "公司规模|CompanyScale|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "经验|Experience|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "学历|Education|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "职位月薪|MonthlySalary|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "招聘时间|JobTime|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "公司名称|CompanyName|3800|True[分]"
eLSeIF s = "JobCompany" tHEn
mENuTItLE = "招聘公司管理"
tABlENaME = "JobCompany"
tHIsMDbPAtH = """../../网站备份/数据库/JobAccess.mdb"""	
tABlECoNFiG = tABlECoNFiG & "公司名称|CompanyName|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "公司网址|CompanyUrl|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "城市|City|800|True[分]"
tABlECoNFiG = tABlECoNFiG & "区域|Area|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "公司规模|CompanyScale|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "公司性质|CompanyNature|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "公司行业|CompanyIndustry|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "最新发布|NewJobTime|1600|True[分]"	
tABlECoNFiG = tABlECoNFiG & "发布天数|ReleaseJobDay|1200|True[分]"
eLSeIF s = "FormJobCai" tHEn
mENuTItLE = "招聘网站采集"
eLSeIF s = "WebSite" tHEn
mENuTItLE = "域名统计"
tABlENaME = "WebSite"
tHIsMDbPAtH = "GetIniS(""init"", ""DefaultQQAccessPath"", """") & ""\WebLog.Mdb"""
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|5000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "数量|WebSiteCount|1000|True[分]"
eLSeIF s = "WebUrlScan" tHEn
mENuTItLE = "网站链接Scan"
tABlENaME = "WebUrlScan"
tHIsMDbPAtH = "App.Path & ""\..\..\网站备份\数据库\WebUrlScan.Mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|1600|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "标题|Title|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网页状态|WebState|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "打开时间|OpenSpeed|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件大小|WebFileSize|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "链接类型|LinkType|1200|True[分]"	
eLSeIF s = "ExcellentUrl" tHEn
mENuTItLE = "优秀网站"
tABlENaME = "ExcellentUrl"
tHIsMDbPAtH = "App.Path & ""\..\..\网站备份\数据库\ExcellentUrl.Mdb"""
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|8000|True[分]"
tABlECoNFiG = tABlECoNFiG & "IP|IP|2200|True[分]"
eLSeIF s = "SearchEngine" tHEn
mENuTItLE = "搜索引擎"
tABlENaME = "SearchEngine"
tHIsMDbPAtH = """SqlServer"""	
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|6000|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "收录时间|IncludedTime|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "Table数|TableNumb|1300|True[分]"
tABlECoNFiG = tABlECoNFiG & "Div数|DivNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "Span数|SpanNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "Ul数|UlNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "Dl数|DlNumb|1000|True[分]"
eLSeIF s = "SqlServerWebUrl" tHEn
mENuTItLE = "网站网址"
tABlENaME = "WebUrl"
tHIsMDbPAtH = """SqlServer"""	
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名ID|WebSiteID|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "状态|WebStatus|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "打开时间|OpenTime|1800|True[分]"
tABlECoNFiG = tABlECoNFiG & "处理|Handle|1000|True[分]"
eLSeIF s = "WebSiteList" tHEn
mENuTItLE = "域名列表"
tABlENaME = "WebSiteList"
tHIsMDbPAtH = """SqlServer"""	
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "状态|WebStatus|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "IP|IP|2200|True[分]"
tABlECoNFiG = tABlECoNFiG & "IP地址|IPAddress|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "打开时间|OpenTime|1400|True[分]"
tABlECoNFiG = tABlECoNFiG & "处理|Handle|1000|True[分]"
eLSeIF s = "WebSiteInfo" tHEn
mENuTItLE = "域名列表"
tABlENaME = "WebSiteInfo"
tHIsMDbPAtH = """SqlServer"""	
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "总页数|WebCountPage|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "首页内链数|HomeStationLink|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "首页外链数|HomeInboundLink|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "全部内链数|StationLink|1500|True[分]"
tABlECoNFiG = tABlECoNFiG & "全部外链数|InboundLink|1500|True[分]"	
eLSeIF s = "ShieldWebSiteList" tHEn
mENuTItLE = "屏蔽域名列表"
tABlENaME = "ShieldWebSiteList"
tHIsMDbPAtH = """SqlServer"""	
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "IP|IP|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "状态|WebStatus|1200|True[分]"
tABlECoNFiG = tABlECoNFiG & "打开时间|OpenTime|1800|True[分]"
tABlECoNFiG = tABlECoNFiG & "处理|Handle|1000|True[分]"	
eLSeIF s = "SearchEngineInfoList" tHEn
mENuTItLE = "搜索引擎列表"
tABlENaME = "SearchEngineInfoList"
tHIsMDbPAtH = "App.Path & ""/../../网站备份\数据库\SearchEngineInfoList.Mdb"""
tABlECoNFiG = tABlECoNFiG & "大类|BigClassName|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "标题|Title|6000|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "收录时间|IncludedTime|1300|True[分]"
tABlECoNFiG = tABlECoNFiG & "页数|PageNumber|800|True[分]"
tABlECoNFiG = tABlECoNFiG & "排名|Ranking|800|True[分]"	
eLSeIF s = "WebAdminScan" tHEn
mENuTItLE = "网站后台Scan"
tABlENaME = "WebAdminScan"
tHIsMDbPAtH = "App.Path & ""/../../网站备份\数据库\WebAdminScan.Mdb"""
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|7000|True[分]"	
tABlECoNFiG = tABlECoNFiG & "响应状态|WebState|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "打开时间|OpenSpeed|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "文件大小|WebFileSize|1200|True[分]"	
eLSeIF s = "Eval" tHEn
mENuTItLE = "Eval"
eLSeIF s = "WebManage" tHEn
mENuTItLE = "模板网页制作"
eLSeIF s = "WebIeBox" tHEn
mENuTItLE = "模板样式管理"
eLSeIF s = "ShareEdition2" tHEn
mENuTItLE = "QQ点赞批量分享 改进版"
eLSeIF s = "QQShareConfig" tHEn
mENuTItLE = "QQ分享配置"
tABlENaME = "QQShareConfig"	
tABlECoNFiG = tABlECoNFiG & "网站标题|WebTitle|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网站描述|WebDescription|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网站图片地址|ImgPath|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "评语|PingYu|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "是否使用|Through|2000|True[分]"	
eLSeIF s = "QQShareUrl" tHEn
mENuTItLE = "QQ分享网址"
tABlENaME = "QQShareUrl"	
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|6000|True[分]"
tABlECoNFiG = tABlECoNFiG & "审核|Through|800|True[分]"
eLSeIF s = "QQShareSendUrl" tHEn
mENuTItLE = "已分享网址"
tABlENaME = "QQShareSendUrl"	
tABlECoNFiG = tABlECoNFiG & "已分享网址|HttpUrl|6000|True[分]"
tABlECoNFiG = tABlECoNFiG & "通过|Through|800|True[分]"
eLSeIF s = "FrmCai" tHEn
mENuTItLE = "采集"	
eLSeIF s = "CaiManage" tHEn
mENuTItLE = "采集管理"
tABlENaME = "Cai"
tHIsMDbPAtH = "App.Path & ""/../../网站备份\数据库\Cai.Mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "小类名称|SmallClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "子类名称|ThreeClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "内容|Content|4000|True[分]"
eLSeIF s = "UpDateWebConfig" tHEn
mENuTItLE = "批量上传到网站配置"
tABlENaME = "UpDateWebConfig"
tABlECoNFiG = tABlECoNFiG & "批量上传到网站|WebSite|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网站标题|WebTitle|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网站关键词|WebKeywords|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网站描述|WebDescription|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "文章追加后缀|SuffixCustom|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "上传|Through|800|True[分]"
eLSeIF s = "BaiduCai" tHEn
mENuTItLE = "百度网址管理"
tABlENaME = "BaiduCai"
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "小类名称|SmallClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "子类名称|ThreeClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "百度网址|BaiduUrl|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "网址|HttpUrl|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|2000|True[分]"
eLSeIF s = "BaiduZhidaoMain" tHEn
mENuTItLE = "百度知道Main" 	
eLSeIF s = "BaiduZhidaoData" tHEn
mENuTItLE = "百度知道数据"
tABlENaME = "BaiduZhidaoData"	
tHIsMDbPAtH = "DefaultQQAccessPath & ""\BaiduZhidaoData.Mdb"""
tABlECoNFiG = tABlECoNFiG & "百度ID|ZhidaoID|2200|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|6000|True[分]"
tABlECoNFiG = tABlECoNFiG & "回答数|ReplyNumb|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "支持顶数|SupportNumb|2000|True[分]"
eLSeIF s = "BaiduZhidaoWordsData" tHEn
mENuTItLE = "百度知道关键词数据"
tABlENaME = "BaiduZhidaoWordsData"	
tHIsMDbPAtH = "DefaultQQAccessPath & ""\BaiduZhidaoWordsData.Mdb"""
tABlECoNFiG = tABlECoNFiG & "关键词|Word|2000|True[分]"
eLSeIF s = "WebShell" tHEn
mENuTItLE = "WebShell管理"
tABlENaME = "WebShell"
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|1800|True[分]"
tABlECoNFiG = tABlECoNFiG & "小马|Ev1|6500|True[分]"
tABlECoNFiG = tABlECoNFiG & "域名|WebSite|3200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "通过|Through|800|True[分]"	
eLSeIF s = "WebServer" tHEn
mENuTItLE = "WebServer网站服务器"
tABlENaME = "WebServer"
tABlECoNFiG = tABlECoNFiG & "IP|IP|2000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "组件|Assembly|2000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "安全级别|AnQuan|1200|True[分]"	
eLSeIF s = "QQ" tHEn
mENuTItLE = "QQ管理"
tABlENaME = "QQ"
tHIsMDbPAtH = "DefaultQQAccessPath & ""\QQ.Mdb"""
tABlECoNFiG = tABlECoNFiG & "QQ|QQ|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "QQ名称|QQName|2000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "性别|QQSex|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "年龄|Age|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "空间极限|SpacePurview|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "相册数|PhotoNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "说说数|ShuaShuaNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "日志数|BlogNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "赞|QzoneZai|800|True[分]"
tABlECoNFiG = tABlECoNFiG & "等级|QzoneLevel|800|True[分]"
tABlECoNFiG = tABlECoNFiG & "积分|QzoneIntegral|800|True[分]"
eLSeIF s = "QQName" tHEn
mENuTItLE = "QQ名称管理"
tABlENaME = "QQName"
tHIsMDbPAtH = "DefaultQQAccessPath & ""\QQName.Mdb"""
tABlECoNFiG = tABlECoNFiG & "QQ|QQ|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "QQ名称|QQName|2000|True[分]"
eLSeIF s = "QQVisitors" tHEn
mENuTItLE = "QQ访客管理"
tABlENaME = "QQVisitors"
tHIsMDbPAtH = "DefaultQQAccessPath & ""\QQVisitors.Mdb"""
tABlECoNFiG = tABlECoNFiG & "QQ|QQ|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "访客QQ|FQQ|15000|True[分]"
eLSeIF s = "QQJournal" tHEn
mENuTItLE = "QQ日志"
tABlENaME = "QQJournal"
tHIsMDbPAtH = """SqlServer"""	
tABlECoNFiG = tABlECoNFiG & "QQ|QQ|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "类型|cate|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "日志ID|blogId|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "标题|title|3000|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "日志ID|blogId|1500|True[分]" 	
tABlECoNFiG = tABlECoNFiG & "发布时间|pubTime|1500|True[分]" 	
eLSeIF s = "BaiduZhidao" tHEn
mENuTItLE = "百度知道管理"
tABlENaME = "BaiduZhidao"
tHIsMDbPAtH = "DefaultQQAccessPath & ""\BaiduZhidao.Mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "提问标题|Title|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "提问网址|HttpUrl|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "发布者|Author|1800|True[分]"
tABlECoNFiG = tABlECoNFiG & "回答数|ReplyNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "回答者|ReplyName|1800|True[分]"
tABlECoNFiG = tABlECoNFiG & "采纳率|AdoptionRate|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "支持数|SupportNumb|1000|True[分]"
tABlECoNFiG = tABlECoNFiG & "浏览次数|BrowseNumb|1200|True[分]"	
tABlECoNFiG = tABlECoNFiG & "通过|Through|800|True[分]"	
eLSeIF s = "BaiduZhidaoWords" tHEn
mENuTItLE = "百度知道相关词管理"
tABlENaME = "BaiduZhidaoWords"
tHIsMDbPAtH = "DefaultQQAccessPath & ""\BaiduZhidaoWords.Mdb"""
tABlECoNFiG = tABlECoNFiG & "搜索词|SearchWord|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "相关词|RelatedWord|3000|True[分]"
tABlECoNFiG = tABlECoNFiG & "排序|nSort|800|True[分]"
eLSeIF s = "StatisticalData" tHEn
mENuTItLE = "数据统计管理"
tABlENaME = "StatisticalData"
tHIsMDbPAtH = "DefaultQQAccessPath & ""\StatisticalData.Mdb"""
tABlECoNFiG = tABlECoNFiG & "大类名称|BigClassName|2000|True[分]"
tABlECoNFiG = tABlECoNFiG & "标题|Title|4000|True[分]"
tABlECoNFiG = tABlECoNFiG & "数值|CountNumb|2000|True[分]"
eLSeIF s = "CaiBaiduUrl" tHEn
mENuTItLE = "采集百度网址"
eLSeIF s = "IEDebug" tHEn
mENuTItLE = "IE调试"
eLSeIF s = "WebCrack" tHEn
mENuTItLE = "网站破解"
eLSeIF s = "DownList" tHEn
mENuTItLE = "批量下载"	
eLSeIF s = "PseudoOriginal" tHEn
mENuTItLE = "仿原创工具"
cALl cREaTEfOLdER(rOOtFOlDEr & "/Data")
cALl cOPyFIlE("\DataDir\VB模块\服务器\Dict字典未用\默认字典.txt", rOOtFOlDEr & "/DataDir/默认字典.txt")	
cALl cOPyFIlE("\DataDir\VB模块\服务器\Dict字典未用\字符替换字典.txt", rOOtFOlDEr & "/DataDir/字符替换字典.txt")	
cALl cOPyFIlE("\DataDir\VB模块\服务器\Dict字典未用\简体繁体转换.txt", rOOtFOlDEr & "/DataDir/简体繁体转换.txt")	
eLSeIF s = "Scan" tHEn
mENuTItLE = "Scan扫描"	
eLSeIF s = "Qzone" tHEn
mENuTItLE = "QQ空间"
eLSeIF s = "SinglePage" tHEn
mENuTItLE = "网站单页制作"
eLSeIF s = "IEAutomatic" tHEn
mENuTItLE = "IE自动操作"
cALl cOPyFIlE("\DataDir\VB模块\任务动作代码.ini", rOOtFOlDEr & "任务动作代码.ini")	
cALl cOPyFIlE("\DataDir\VB模块\问问关键词列表.ini", rOOtFOlDEr & "问问关键词列表.ini")	
cALl cOPyFIlE("\DataDir\VB模块\自动运行动作.ini", rOOtFOlDEr & "自动运行动作.ini")	
cALl cOPyFIlE("\DataDir\VB模块\网站后台登录字典.ini", rOOtFOlDEr & "网站后台登录字典.ini")	
eLSeIF s = "IEAutoHandle" tHEn
mENuTItLE = "IE自动处理2015"
eLSeIF s = "AsynchDown" tHEn
mENuTItLE = "测试自动下载"
eLSeIF s = "-" oR lEFt(s,2)="--" tHEn
mENuTItLE = "-"	
eND iF
iF s <>"-" aND lEFt(s,2) <> "--" tHEn
tOOlSMeNU=tOOlSMeNU & "    ElseIf S = """& mENuTItLE &""" Then" & vBCrLF
tOOlSMeNU=tOOlSMeNU & "        " & s &".Show: "& s &".SetFocus" & vBCrLF
iF tABlECoNFiG <> "" tHEn
tOOlSMeNU=tOOlSMeNU & "        If " & s & ".Caption <> ""$表面板$"" Then Exit Sub" & vBCrLF
tOOlSMeNU=tOOlSMeNU & "        " & s & ".ThisFormName=""" & s & """" & vBCrLF	
tOOlSMeNU=tOOlSMeNU & "        " & s & ".Caption=""" & mENuTItLE & """" & vBCrLF	
tOOlSMeNU=tOOlSMeNU & "        " & s & ".FrameManage.Caption=""" & mENuTItLE & """" & vBCrLF	
tOOlSMeNU=tOOlSMeNU & "        " & s & ".TableName=""" & tABlENaME & """" & vBCrLF	
iF tHIsACcESsPAsS<>"" tHEn tOOlSMeNU=tOOlSMeNU & "        " & s & ".ThisAccessPass=""" & tHIsACcESsPAsS & """" & vBCrLF	
iF tHIsMDbPAtH <> "" tHEn tOOlSMeNU=tOOlSMeNU & "        " & s & ".ThisMDBPath="& tHIsMDbPAtH & vBCrLF	
tOOlSMeNU=tOOlSMeNU & "        " & s & ".TableConfig=""" & tABlECoNFiG & """" & vBCrLF
tOOlSMeNU=tOOlSMeNU & "        " & s & ".TableConfig=""" & tABlECoNFiG & """" & vBCrLF
tOOlSMeNU=tOOlSMeNU & "        Call " & s & ".FormLoad()" & vBCrLF
eND iF
eND iF
iF tABlECoNFiG<> "" tHEn
fORmSTrLIsT = fORmSTrLIsT & vBCrLF & "Public "& s &" As Form"	
fORmSEtLIsT = fORmSEtLIsT & vBCrLF & "Set " & s & "=New TableDialog"	
eND iF
iF iNStR("|AskDa|ZNRobot|JobWeb|JobCompany|FormJobCai|FrmTestDialog1|FrmTestDialog2|FrmDown|","|"& s &"|")>0 tHEn
iF nTOoLS2 = 0 tHEn
tOOlSClICk=tOOlSClICk & "    if checkAdminQuanXian("""& mENuTItLE &""") then Frm.Tools2Menu(0).Caption = """& mENuTItLE &"""" & vBCrLF
eLSe
tOOlSClICk=tOOlSClICk & "    if checkAdminQuanXian("""& mENuTItLE &""") then Load Frm.Tools2Menu("& nTOoLS2 &"): Frm.Tools2Menu("& nTOoLS2 &").Caption = """& mENuTItLE &"""" & vBCrLF
eND iF
nTOoLS2 = nTOoLS2 + 1
eLSeIF iNStR("|UserMakeNav|SinglePage|FrmCrateNewHtmlPage|FileScan2015|FrameLayout|FrmCreateWebLable|HTML5CSS2|XyWebUp|MYProgram|FrameLayout|FrmCreateWebLable|FrmWebTemplateView|--2|FrmAutoAddWebDefaultInfo|FrmControlDialog|FrmSqlIn|FrmProgrameTransformation|WebShell|FrmEvScan|","|"& s &"|")>0 tHEn
iF nTOoLS3 = 0 tHEn
tOOlSClICk=tOOlSClICk & "    if checkAdminQuanXian("""& mENuTItLE &""") then Frm.Tools3Menu(0).Caption = """& mENuTItLE &"""" & vBCrLF
eLSe
tOOlSClICk=tOOlSClICk & "    if checkAdminQuanXian("""& mENuTItLE &""") then Load Frm.Tools3Menu("& nTOoLS3 &"): Frm.Tools3Menu("& nTOoLS3 &").Caption = """& mENuTItLE &"""" & vBCrLF
eND iF
nTOoLS3 = nTOoLS3 + 1
eLSe
iF nTOoLS = 0 tHEn
tOOlSClICk=tOOlSClICk & "    if checkAdminQuanXian("""& mENuTItLE &""") then Frm.ToolsMenu(0).Caption = """& mENuTItLE &"""" & vBCrLF
eLSe
tOOlSClICk=tOOlSClICk & "    if checkAdminQuanXian("""& mENuTItLE &""") then Load Frm.ToolsMenu("& nTOoLS &"): Frm.ToolsMenu("& nTOoLS &").Caption = """& mENuTItLE &"""" & vBCrLF
eND iF
nTOoLS = nTOoLS + 1
eND iF
eND iF
iF iNStR("|WebManage|HTML5CSS2|FrmCrateNewWeb|FrmCrateNewHtmlPageOLD|","|"& s &"|")>0 tHEn
cALl cOPyFOlDEr("\DataDir\VB模块\Template", rOOtFOlDEr & "/Template")	
eND iF
iF s <> "MDIForm1" aND s <> "-"  aND lEFt(s,2) <> "--" tHEn
oPEnFRoM=oPEnFRoM & "    ElseIf Tag = LCase("""& s &""") Then" & vBCrLF & "        " & s &".Show: "& s &".SetFocus" & vBCrLF
eND iF
iF s <>"-" aND lEFt(s,2) <> "--" aND tABlECoNFiG = "" tHEn
s = s & ".frm"
iF cHEcKFiLE("/DataDir/VB模块/"& s)=fALsE tHEn
cALl eERr("没有窗体","/DataDir/VB模块/"& s)
eND iF
fRMlISt = fRMlISt & "Form=zForm\"& s & vBCrLF
cALl cOPyFIlE("/DataDir/VB模块/"& s, zFOrMFoLDeR & s)
s=rEPlACe(s,".frm",".frx")
cALl cOPyFIlE("/DataDir/VB模块/"& s, zFOrMFoLDeR & s)
eND iF
eND iF
nEXt
cTLfILeLIsT = cTLfILeLIsT & "UserControl=zForm\Downloader.ctl" & vBCrLF	
cALl cOPyFIlE("\DataDir\VB模块\Downloader.ctl", zFOrMFoLDeR & "Downloader.ctl")	
cALl cOPyFIlE("\DataDir\VB模块\Downloader.ctx", zFOrMFoLDeR & "Downloader.ctx")	
cTLfILeLIsT = cTLfILeLIsT & "UserControl=zForm\ControlParam.ctl" & vBCrLF	
cALl cOPyFIlE("\DataDir\VB模块\ControlParam.ctl", zFOrMFoLDeR & "ControlParam.ctl")	
cALl cOPyFIlE("\DataDir\VB模块\ControlParam.ctx", zFOrMFoLDeR & "ControlParam.ctx")	
cTLfILeLIsT = cTLfILeLIsT & "UserControl=zForm\ControlUrl.ctl" & vBCrLF	
cALl cOPyFIlE("\DataDir\VB模块\ControlUrl.ctl", zFOrMFoLDeR & "ControlUrl.ctl")	
cALl cOPyFIlE("\DataDir\VB模块\ControlUrl.ctx", zFOrMFoLDeR & "ControlUrl.ctx")	
cONtENt = rEPlACe(cONtENt,"Manage.exe","网站制作软件.exe")
cONtENt = rEPlACe(cONtENt,"{Frm列表}",fRMlISt & cTLfILeLIsT)
cALl cREaTEfILe(rOOtFOlDEr & "Manage.vbp", cONtENt)
cALl eCHo("FormStrList",fORmSTrLIsT)
pATh = "/DataDir/VB模块/MDIForm1.frm"
cONtENt = gETfTExT(pATh)
cONtENt = rEPlACe(cONtENt,"{工具}",tOOlSMeNU)
cONtENt = rEPlACe(cONtENt,"{工具导航}",tOOlSClICk)
cONtENt = rEPlACe(cONtENt,"{默认打开窗体}",oPEnFRoM)
cONtENt = rEPlACe(cONtENt,"{加载窗体}",fORmSEtLIsT)
cONtENt = rEPlACe(cONtENt,"Version1.0","网站制作软件")   	
iF iNStR(fRMlIStSTr,"PseudoOriginal")=0 tHEn
tEMpSTr = sTRcUT(cONtENt, vBCrLF & "'伪原创","End Sub",1)
cONtENt = rEPlACe(cONtENt,tEMpSTr, vBCrLF)
eND iF
iF yESsORtPLuG = "OK" tHEn	
cONtENt = rEPlACe(rEPlACe(cONtENt,"[SortPlug开始]",""),"[SortPlug结束]","")	
eLSe
tEMpSTr = sTRcUT(cONtENt,"[SortPlug开始]","[SortPlug结束]",1)
cONtENt = rEPlACe(cONtENt,tEMpSTr,"")
eND iF
cALl cREaTEfILe(zFOrMFoLDeR & "MDIForm1.frm", cONtENt)
sPLsTR=sPLiT("VB_Img.bas|CloseEXE.bas|Ying1.bas|Ying2.bas|VB_Config.bas|API.bas|VB_Conn.bas|WinMain.bas|Md5.bas|VB_Common.bas|Tp.bas|FindEXE.bas|Input.bas|Rwini.bas|clsWaitableTimer.cls|GPS.cls|Request.cls|AspCode.cls|NetWorkClass.cls|modExcel.bas|VB_ImportAndExportWeb.bas|WebSiteGetIP.bas|cx_extractor.bas|PingIP.bas|RT.bas|DomainNameToIP.bas|VB_Computer.bas|VB_CaiClass.bas|VB_VBControl.bas|ClassRichTextBox.cls|VBJSScript.bas|AspToPhpClass.cls|AspActionClass.cls|ControlTemplateStyle.ctl|VB_ModuleFunction.bas|VB_CallCommand.bas","|")
fOR eACh s iN sPLsTR
iF s <> "" tHEn
cALl cOPyFIlE("/DataDir/VB模块/"& s, zFOrMFoLDeR & s)
eND iF
nEXt
cALl cOPyFOlDEr("/DataDir/VB模块/Images", rOOtFOlDEr & "Images")
cALl cOPyFOlDEr("/DataDir/VB模块/Edit", rOOtFOlDEr & "Edit") 	
cALl cOPyFOlDEr("/DataDir/VB模块/Config", rOOtFOlDEr & "Config")
cALl cOPyFIlE("/DataDir/VB模块/SysInfo.ini", rOOtFOlDEr & "SysInfo.ini")
pATh = zFOrMFoLDeR & "/VB_Config.bas"
cONtENt = gETfTExT(pATh)
s = sTRcUT(cONtENt,"'{$窗体开始$}","'{$窗体结束$}",1)
cONtENt = rEPlACe(cONtENt, s , "'{$窗体开始$}" & fORmSTrLIsT & vBCrLF & "'{$窗体结束$}")
s = sTRcUT(cONtENt,"Public Const SoftVersion = """,""" '软件版本",1)
cONtENt = rEPlACe(cONtENt, s , "Public Const SoftVersion = """ & sOFtVErSIoN & """ '软件版本")
cALl cREaTEfILe(pATh,cONtENt)
iF 1=2 tHEn
dATaFOlDEr = rOOtFOlDEr & "DataDir/"
cALl cREaTEfOLdER(dATaFOlDEr)
cALl cREaTEfOLdER(dATaFOlDEr & "Log")	
cALl cOPyFIlE("/DataDir/VB模块/最近打开文档.ini", dATaFOlDEr & "最近打开文档.ini")
cALl cOPyFIlE("/DataDir/VB模块/sql.txt", dATaFOlDEr & "sql.txt")
cALl cOPyFIlE("/DataDir/VB模块/Desk.jpg", dATaFOlDEr & "Desk.jpg")	
eND iF
eND sUB
%>

