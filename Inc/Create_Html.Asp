<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-16
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#iNClUDe fILe = "Config.Asp"-->
<%
dIM uSErID
dIM wEBbOTtOM, dISpLAyYEs, pUBcODe,cODe, dID, sID, tID, sHOwTItLE	
dIM tEMpDId, tEMpSId, tEMpTId
dIM dEFaULtWEbTItLE, dEFaULtWEbKEyWOrDS, dEFaULtWEbDEsCRiPTiON 	
dIM wEBnAVtYPe
dISpLAyYEs = tRUe
sERvER.sCRiPTtIMeOUt = 1800
dIM wEBaCTiONtYPe
dIM wEBnAVdID, wEBnAVsID
dIM dEFaULtWEbBAnNEr
dIM wEBfOLdERnAMe
dIM lOCaLTeSTfOLdER
dIM nAVdID, nAVsID, pROdID, pROsID, pROtID
dIM aRTiCLeDId,aRTiCLeSId,aRTiCLeTId,aRTiCLeTItLE	
dIM aRTiCLeID,aRTiCLeDAtETiME,aRTiCLeCOnTEnT,aRTiCLeAUtHOr	
dIM aRTiCLeBIgFIlES,aRTiCLeSMaLLfILeS	
dIM wEBtEMpLAtE, wEBsKInS	
dIM wEBiMAgES,wEBcSS,wEBjS	
dIM tEMpLAtEHtMLcODe	
dIM jSUrL,jSCoNTeNT	
dIM tPLpATh,tPLcONtENt,tPLlIStCOnTEnT	
dIM wEBmODuLEsKInS	
dIM wEBfINdTPl	
dIM wEBrEPlACeTPl	
dIM wEBcODeFInDTpL	
dIM wEBcODeREpLAcETpL	
dIM iSHtMLfORmATtINg	
dIM dB_pREfIX	
cALl oPEnCOnN()
dIM oBJyK : sET oBJyK = nEW cLAsSYoUKoU
dIM oBJmSD : sET oBJmSD = nEW mAIsIDe	
dIM mODuLErEPlACeARrAY(99,99)	
sELeCT cASe rEQuESt("act")
cASe "auto", "autoweb","AutoAddWebInfo" : aUToADdWEbINfO(rEQuESt("DataFolderPath"))	
cASe "Nav"	
nAVdID = rEQuESt("NavDid")
iF nAVdID="" aND rEQuESt("NavDidType")<>"" tHEn
nAVdID = gETnAVtYPeINnAMe(rEQuESt("NavDidType"))
eND iF
cALl mAKeWEbHTmL(nAVdID,rEQuESt("NavSid"),"","","","Nav","","","")	
cASe "ShowNavList" : sHOwNAvLIsT()	
cASe "CreateNavList" : cREaTEnAVlISt()	
cASe "ShowClassList" : sHOwCLaSSlISt()	
cASe "CreateInfo" :
cALl mAKeWEbHTmL(rQ("NavDid"),rQ("NavSid"),rQ("ProDid"),rQ("ProSid"),rQ("ProTid"),rQ("ActionType"),rQ("ID"),rQ("ClassName"),rQ("WD"))
cASe "CreateClass" : cALl mAKeWEbHTmL("","",rEQuESt("ProDid"),rEQuESt("ProSid"),rEQuESt("ProTid"),"Class","","","")	
cASe "CreateClassList" : cREaTEcLAsSLiST()	
cASe "ShowArticleList" : sHOwARtIClELiST()	
cASe "CreateArticle" : cALl mAKeWEbHTmL("","","","","","Article", rEQuESt("Id"),"","")	
cASe "CreateArticleList" : cREaTEaRTiCLeLIsT()	
cASe "Search" : cALl mAKeWEbHTmL("","",rEQuESt("Did"),rEQuESt("Sid"),rEQuESt("Tid"),"Search","",rEQuESt("ClassName"),rEQuESt("wd"))	
cASe "MainInfo" : cALl mAKeWEbHTmL("","","","","","MainInfo",rEQuESt("Id"),"","")	
cASe "MakeSiteMap" : cALl mAKeSItEMaP():rESpONsE.eND()	
cASe "ShowMemberList" : sHOwMEmBErLIsT()	
cASe "ShowDelHtmllist" : sHOwDElHTmLLiST()	
cASe "DelFile": dELfILe(rEQuESt("FileName"))	
cASe "ShowWorkList","工作","work","笔记","工作列表" : sHOwWOrKLiST()	
cASe "ShowWork" : sHOwWOrK(rEQuESt("FilePath"))
cASe "news" : rW(gETfTExT("/Templates/MaiSiDe/QQShare.Html")) : rESpONsE.eND()	
cASe "AddProduct" : aDDpROdUCt()	
cASe "DeleteProduct" : dELeTEpROdUCt("Where Id=" & rEQuESt("Id"))	
cASe "AotuAddKeyWord" : aOTuADdKEyWOrD()	
cASe "WebNavigationUsrList" : wEBnAViGAtIOnUSrLIsT()	
cASe "WebStat" : wEBsTAt(""& aDMiNDiR &"Data/Stat/")	
cASe "FormSubmit" : fORmSUbMIt()	
cASe "RunFile" : rUNfILe()	
cASe "showweb" : rESpONsE.rEDiREcT("/Inc/Create_Html.Asp?act=Nav&NavDidType=首页&MackHtml=False&Debug=True" & iIF(rEQuESt("gl")<>"","&gl=" & rEQuESt("gl"),""))	
cASe "aboutauthor","about","author" : cALl aBOuTAuTHoR()	
cASe "default" : cALl dEFaULt()
eND sELeCT
sUB mAKeWEbHTmL(a,b,c,d,e, f,g,h,i)
dIM j,k,l,m,n,o,p,q
dIM tEMpMAiNCoNTeNT	
dIM cUStOMtEMpLAtEFiLE	
dIM cONtENt	
dIM u : u=tRUe	
pUBnAVdID = a
pUBnAVsID = b
pUBpROdID = c
pUBpROsID = d
pUBpROtID = e
pUBaCTiONtYPe = f	
pUBiD = g
pUBcLAsSNaME = h
pUBwD = i
cALl hANdLEwEBcONfIG()	
jSUrL = "/Inc/Create_Html.Asp?act=CreateInfo&NavDid=" & a & "&NavSid=" & b
jSUrL = jSUrL & "&ProDid=" & c & "&ProSid=" & d & "&ProTid=" & e
jSUrL = jSUrL & "&ActionType=" & f & "&ID=" & g & "&ClassName=" & h & "&WD=" & i
jSUrL = jSUrL & "&MackHtml=" & rQ("MackHtml") & "&Debug=" & rQ("Debug")
jSCoNTeNT = "<script type='text/javascript'>AjaxNoReturn('"& jSUrL &"');</script>"
m=tRUe	
cALl gETwEBcONfIG()	
lOCaLTeSTfOLdER = gETwEBfOLdERnAMe()	
wEBaCTiONtYPe = f	
iF f="Nav" tHEn
iF a = "" tHEn n = rEQuESt("NavType")
tEMpLAtEPaTH = gETnAVtEMpLAtETeXT(a, b, n)
wEBnAVdID=a:wEBnAVsID=b	
eLSeIF f="Class" tHEn	
tEMpLAtEPaTH = gETcLAsSTeMPlATeTExT(c, d, e)
eLSeIF f = "Article" tHEn
cALl cREaTEaRTiCLe(g)
eLSeIF f = "MainInfo" tHEn
cALl cREaTEmAInINfO(g)
eND iF
iF tEMpLAtEPaTH = "" tHEn
tEMpLAtEPaTH = wEBtEMpLAtE & "Main_Model.Html"
eLSe
tEMpLAtEPaTH = rEPlACe(tEMpLAtEPaTH,"/","\")
iF lEFt(tEMpLAtEPaTH,1)<>"\" tHEn tEMpLAtEPaTH = wEBtEMpLAtE & tEMpLAtEPaTH
eND iF
iF rQ("HttpUrl")<>"" tHEn	
cODe = gEThTTpPAgE(rQ("HttpUrl"),"")
eLSeIF rEQuESt("Template")<>"" tHEn
dIM v,w
iF rEQuESt("Template")="表单验证" tHEn
cODe = gETfTExT(wEBtEMpLAtE & "Index_Model.Html")
iF iNStR(cODe,"</head>")>0 tHEn	
cODe = mID(cODe,1,iNStR(cODe,"</head>")+7)
eND iF
o = "{$FormSubmit did='"& rEQuESt("Did") &"' tablename='InputValue' formname='formdialog' classname='formdialog' isverificationcode='true'$}"
cODe=cODe & "<script src=""/Jquery/Function.js""></script>" & vBCrLF
cODe = cODe & "<body>" & o
iF rEQuESt("formedit")="true" tHEn
cODe = cODe & "<div>复制下面代码放到网页里 就可以显示上面的表单了。</div><div>"& rEPlACe(o,"{","&#x7B;") &"</div>"
eND iF
eLSe	
cUStOMtEMpLAtEFiLE = tRImVBcRLf(hANdLEfILeURl(rEQuESt("Template")))
iF lEFt(cUStOMtEMpLAtEFiLE,1)<>"\" tHEn
cUStOMtEMpLAtEFiLE = wEBtEMpLAtE & cUStOMtEMpLAtEFiLE
eND iF
iF rEQuESt("Code")<>"" tHEn
cALl cREaTEfILe(cUStOMtEMpLAtEFiLE,rEQuESt("Code"))
eND iF
cODe = gETfTExT(cUStOMtEMpLAtEFiLE)
eND iF
tPLpATh = rEPlACe(rEQuESt("Template"),"/","\")
iF iNStR(tPLpATh,"\")>0 tHEn tPLpATh = mID(tPLpATh,iNStRReV(tPLpATh,"\")+1)
iF iNStR(tPLpATh,".")>0 tHEn tPLpATh = mID(tPLpATh, 1, iNStRReV(tPLpATh,".")-1)
tPLpATh = wEBtEMpLAtE & "Config\" & tPLpATh & ".tpl"
tPLcONtENt = gETfTExT(tPLpATh)
v="#默认网页模板列表# start" : w="#默认网页模板列表# end"
iF iNStR(tPLcONtENt,v)>0 aND iNStR(tPLcONtENt,w)>0 tHEn
tPLlIStCOnTEnT = sTRcUT(tPLcONtENt,v,w,2)
eND iF
eLSe
cODe = gETfTExT(tEMpLAtEPaTH)
eND iF
cALl hANdLEcODeREpLAcE(cODe)	
pUBcODe = cODe	
iF rEQuESt("MackHtml") <> "False" tHEn
cALl eCHo("模板路径TemplatePath", tEMpLAtEPaTH)
eND iF	
iF tEMpDId <> "" tHEn c = tEMpDId : d = tEMpSId :  e = tEMpTId	
tEMpLAtEHtMLcODe = cODe	
iF wEBsKInS = "\Skins\YouKou\" tHEn
cODe = rEPlACe(cODe, "{$WebBottomNav$}", oBJyK.wEBnAViGAtIOn("Where NavButtom=True  Order By Sort Asc"))
cODe = rEPlACe(cODe, "{$Banner$}", oBJyK.bANnERtAB("Banner",6,"","",""))
cODe = rEPlACe(cODe, "{$热搜关键词$}", hOTsEArCH(""))
cODe = rEPlACe(cODe, "{$产品类别展示$}", rEAdCLaSSlISt("产品展示", d, e, "","菜单移动显示"))
cODe = rEPlACe(cODe, "{$为什么在悠口培训$}", rEAdMAiNInFO("为什么在悠口培训"))
cODe = rEPlACe(cODe, "{$最新学员$}", oBJyK.sHOwHAnDLeUSeRLiST(100))
cODe = rEPlACe(cODe, "{$最新学员$}", rEAdSCrOLlMEmBErLIsT(100,""))
cODe = rEPlACe(cODe, "{$热门技术推荐$}", cASeLIsT("产品展示",12," Where Recommend=True And BigFiles<>'' "))
cODe = rEPlACe(cODe, "{$友情链接$}", oBJyK.fRIeNDlINk())
cODe = rEPlACe(cODe, "{$悠口培训新闻$}", rEAdNEwLIsT("悠口培训新闻",6, 40 ,"Order By Id Desc"))
cODe = rEPlACe(cODe, "{$餐饮行业新闻$}", rEAdNEwLIsT("餐饮行业新闻",6, 40 ,"Order By Id Desc"))
cODe = rEPlACe(cODe, "{$餐饮店面经营管理$}", rEAdNEwLIsT("餐饮店面经营管理",6, 40 ,"Order By Id Desc"))
cODe = rEPlACe(cODe, "{$饮食文化$}", rEAdNEwLIsT("饮食文化",6, 40 ,"Order By Id Desc"))
cODe = rEPlACe(cODe, "{$地方特色美食$}", rEAdNEwLIsT("地方特色美食",6, 40 ,"Order By Id Desc"))
cODe = rEPlACe(cODe, "{$厨艺培训交流$}", rEAdNEwLIsT("厨艺培训交流",6, 40 ,"Order By Id Desc"))
cODe = rEPlACe(cODe, "{$网站地图$}", gETnAVuRL("网站地图",""))
cODe = rEPlACe(cODe, "{$网站地图Target$}", gETnAVtARgET("网站地图",""))	
cODe = rEPlACe(cODe, "{$培训场景More$}", gETbIGcLAsSUrL("培训场景"))
cODe = rEPlACe(cODe, "{$热门技术推荐More$}", gETbIGcLAsSUrL("热门技术推荐"))
cODe = rEPlACe(cODe, "{$悠口培训基地一览More$}", gETbIGcLAsSUrL("悠口培训基地一览"))
cODe = rEPlACe(cODe, "{$学员风采More$}", gETbIGcLAsSUrL("学员风采"))
cODe = rEPlACe(cODe, "{$诱人美味More$}", gETbIGcLAsSUrL("诱人美味"))	
cODe = rEPlACe(cODe, "{$悠口培训新闻More$}", gETbIGcLAsSUrL("悠口培训新闻"))
cODe = rEPlACe(cODe, "{$餐饮行业新闻More$}", gETbIGcLAsSUrL("餐饮行业新闻"))
cODe = rEPlACe(cODe, "{$餐饮店面经营管理More$}", gETbIGcLAsSUrL("餐饮店面经营管理"))
cODe = rEPlACe(cODe, "{$饮食文化More$}", gETbIGcLAsSUrL("饮食文化"))
cODe = rEPlACe(cODe, "{$地方特色美食More$}", gETbIGcLAsSUrL("地方特色美食"))
cODe = rEPlACe(cODe, "{$厨艺培训交流More$}", gETbIGcLAsSUrL("厨艺培训交流"))
dEFaULtWEbBAnNEr = "/Skins/YouKou/Index/Banner.jpg"
cODe = rEPlACe(cODe, "{$MainBanner$}",  oBJyK.mAInBAnNEr(a,b,c,d,e))
cODe = rEPlACe(cODe, "{$培训场景$}", sCRoLLpHOtO("培训场景",12,160,130,"培训场景","") )
cODe = rEPlACe(cODe, "{$培训场景JS$}", jSPhOToSCrOLl("培训场景",740,158) )
cODe = rEPlACe(cODe, "{$诱人美味$}", sCRoLLpHOtO("诱人美味",12,160,130,"诱人美味","") )
cODe = rEPlACe(cODe, "{$诱人美味JS$}", jSPhOToSCrOLl("诱人美味",960,158) )
cODe = rEPlACe(cODe, "{$学员风采$}", sCRoLLpHOtO("学员风采",12,160,130,"学员风采","") )
cODe = rEPlACe(cODe, "{$学员风采JS$}", jSPhOToSCrOLl("学员风采",960,158) )
cODe = rEPlACe(cODe, "{$悠口培训基地一览$}", sCRoLLpHOtO("悠口培训基地一览",12,160,130,"悠口培训基地一览","") )
cODe = rEPlACe(cODe, "{$悠口培训基地一览JS$}", jSPhOToSCrOLl("悠口培训基地一览",960,158) )
o = sTRcUT(gETfTExT("/Templates/PublicModule/QQOnline2/2.html"),"[开始]","[结束]",2)
iF o = "" tHEn cALl eERr("QQ样式二","为空")
cODe = rEPlACe(cODe, "<body>", "<body>" & o)
o = sTRcUT(gETfTExT("../Templates/PublicModule/右下角浮动层.html"),"[开始]","[结束]",2)
cODe = rEPlACe(cODe, "<body>", "<body>" & o)
cODe = rEPlACe(cODe, "{$最新动态标题$}", "悠口最新动态")
cODe = rEPlACe(cODe, "{$最新动态内容$}", lITyPEnEWlISt("悠口最新动态",6, 40 ,""))
tEMpLAtEHtMLcODe = cODe	
eLSeIF wEBsKInS = "\Skins\MaiSiDe\" tHEn
cODe = rEPlACe(cODe, "{$WebTopNav$}", oBJyK.nEWwEBnAViGAtIOn(a,"Where NavTop=True  Order By Sort Asc"))
cODe = rEPlACe(cODe, "{$WebBottomNav$}", oBJyK.wEBnAViGAtIOn("Where NavButtom=True  Order By Sort Asc"))
cODe = rEPlACe(cODe, "{$Banner$}", oBJyK.bANnERtAB("Banner",6,"","",""))
cODe = rEPlACe(cODe, "{$热搜关键词$}", hOTsEArCH(""))
cODe = rEPlACe(cODe, "{$产品类别展示$}", oBJmSD.lEFtCLaSSlISt("副导航", d, e, ""))
cODe = rEPlACe(cODe, "{$为什么在麦思德培训$}", rEAdMAiNInFO("为什么在麦思德培训"))
cODe = rEPlACe(cODe, "{$最新学员$}", oBJyK.sHOwHAnDLeUSeRLiST(100))
cODe = rEPlACe(cODe, "{$最新学员$}", rEAdSCrOLlMEmBErLIsT(100,""))
cODe = rEPlACe(cODe, "{$热门技术推荐$}", cASeLIsT("产品展示",12," Where Recommend=True And BigFiles<>'' "))
cODe = rEPlACe(cODe, "{$友情链接$}", oBJyK.fRIeNDlINk())
cODe = rEPlACe(cODe, "{$麦思德汉堡新闻$}", rEAdNEwLIsT("麦思德汉堡新闻",6, 40 ," Order By AddDateTime Desc"))
cODe = rEPlACe(cODe, "{$餐饮行业新闻$}", rEAdNEwLIsT("餐饮行业新闻",6, 40 ," Order By AddDateTime Desc"))
cODe = rEPlACe(cODe, "{$餐饮店面经营管理$}", rEAdNEwLIsT("餐饮店面经营管理",6, 40 ," Order By AddDateTime Desc"))
cODe = rEPlACe(cODe, "{$饮食文化$}", rEAdNEwLIsT("饮食文化",6, 40 ," Order By Sort Asc"))
cODe = rEPlACe(cODe, "{$地方特色美食$}", rEAdNEwLIsT("地方特色美食",6, 40 ," Order By AddDateTime Desc"))
cODe = rEPlACe(cODe, "{$常见问题解答$}", rEAdNEwLIsT("常见问题解答",6, 40 ," Order By AddDateTime Desc"))
cODe = rEPlACe(cODe, "{$网站地图$}", gETnAVuRL("网站地图",""))
cODe = rEPlACe(cODe, "{$网站地图Target$}", gETnAVtARgET("网站地图",""))	
cODe = rEPlACe(cODe, "{$麦思德汉堡新闻链接$}", gETcLAsSUrL_nAV("麦思德汉堡新闻","",""))
cODe = rEPlACe(cODe, "{$成功案例链接$}", gETcLAsSUrL_nAV("成功案例","",""))	
cODe = rEPlACe(cODe, "{$汉堡加盟菜单副导航链接$}", gETcLAsSUrL_nAV("副导航","汉堡加盟菜单",""))	
cODe = rEPlACe(cODe, "{$麦思德汉堡新闻More$}", gETbIGcLAsSUrL("麦思德汉堡新闻"))
cODe = rEPlACe(cODe, "{$培训场景More$}", gETbIGcLAsSUrL("培训场景"))
cODe = rEPlACe(cODe, "{$热门技术推荐More$}", gETbIGcLAsSUrL("热门技术推荐"))
cODe = rEPlACe(cODe, "{$麦思德培训基地一览More$}", gETbIGcLAsSUrL("麦思德培训基地一览"))
cODe = rEPlACe(cODe, "{$学员风采More$}", gETbIGcLAsSUrL("学员风采"))
cODe = rEPlACe(cODe, "{$诱人美味More$}", gETbIGcLAsSUrL("诱人美味"))	
cODe = rEPlACe(cODe, "{$麦思德培训新闻More$}", gETbIGcLAsSUrL("麦思德培训新闻"))
cODe = rEPlACe(cODe, "{$餐饮行业新闻More$}", gETbIGcLAsSUrL("餐饮行业新闻"))
cODe = rEPlACe(cODe, "{$餐饮店面经营管理More$}", gETbIGcLAsSUrL("餐饮店面经营管理"))
cODe = rEPlACe(cODe, "{$饮食文化More$}", gETbIGcLAsSUrL("饮食文化"))
cODe = rEPlACe(cODe, "{$地方特色美食More$}", gETbIGcLAsSUrL("地方特色美食"))
cODe = rEPlACe(cODe, "{$常见问题解答More$}", gETbIGcLAsSUrL("常见问题解答"))
cODe = rEPlACe(cODe, "{$麦思德培训基地一览More$}", gETbIGcLAsSUrL("麦思德培训基地一览"))
cODe = rEPlACe(cODe, "{$成功案例More$}", gETbIGcLAsSUrL("成功案例"))
dEFaULtWEbBAnNEr = "/DataDir/WebImg/Banner/麦思德理念.jpg"
cODe = rEPlACe(cODe, "{$MainBanner$}",  oBJyK.mAInBAnNEr(a,b,c,d,e))
cODe = rEPlACe(cODe, "{$培训场景$}", sCRoLLpHOtO("培训场景",12,160,130,"培训场景"," Order By AddDateTime Desc") )
cODe = rEPlACe(cODe, "{$培训场景JS$}", jSPhOToSCrOLl("培训场景",740,158) )
cODe = rEPlACe(cODe, "{$成功案例$}", sCRoLLpHOtO("成功案例",12,160,130,"成功案例"," Order By AddDateTime Desc") )
cODe = rEPlACe(cODe, "{$成功案例JS$}", jSPhOToSCrOLl("成功案例",740,158) )
cODe = rEPlACe(cODe, "{$诱人美味$}", sCRoLLpHOtO("诱人美味",12,160,130,"诱人美味"," Order By AddDateTime Desc") )
cODe = rEPlACe(cODe, "{$诱人美味JS$}", jSPhOToSCrOLl("诱人美味",960,158) )
cODe = rEPlACe(cODe, "{$学员风采$}", sCRoLLpHOtO("学员风采",12,160,130,"学员风采"," Order By AddDateTime Desc") )
cODe = rEPlACe(cODe, "{$学员风采JS$}", jSPhOToSCrOLl("学员风采",960,158) )
cODe = rEPlACe(cODe, "{$麦思德培训基地一览$}", sCRoLLpHOtO("麦思德培训基地一览",12,160,130,"麦思德培训基地一览"," Order By AddDateTime Desc") )
cODe = rEPlACe(cODe, "{$麦思德培训基地一览JS$}", jSPhOToSCrOLl("麦思德培训基地一览",960,158) )
cODe = mANyTImEShANdLEtEMpLAtEAcTIoN(cODe)	
iF 1=1 tHEn
o = sTRcUT(gETfTExT("../Templates/PublicModule/右下角浮动层.html"),"[开始]","[结束]",2)
cODe = rEPlACe(cODe, "<body>", "<body>" & o)
cODe = rEPlACe(cODe, "{$最新动态标题$}", "麦思德最新动态")
cODe = rEPlACe(cODe, "{$最新动态内容$}", lITyPEnEWlISt("麦思德最新动态",6, 40 ,""))
o = sTRcUT(gETfTExT("../Templates/PublicModule/餐饮菜单图片.html"),"[开始]","[结束]",2)
cODe = rEPlACe(cODe, "<!--餐饮图片-->", o)
o = sTRcUT(gETfTExT("../Templates/PublicModule/展示Banner.html"),"[开始]","[结束]",2)
cODe = rEPlACe(cODe, "<!--展示Banner-->", o)
o = sTRcUT(gETfTExT("../Templates/PublicModule/展示Banner.html"),"[JS开始]","[JS结束]",2)
cODe = rEPlACe(cODe, "<!--JS展示Banner-->", o)
o = sTRcUT(gETfTExT("../Templates/PublicModule/麦思德视频.html"),"[开始]","[结束]",2)
cODe = rEPlACe(cODe, "<body>", "<body>" & o)
eND iF
tEMpLAtEHtMLcODe = cODe	
eND iF
iF f="Class" oR iNStR("|产品|新闻|下载|","|" & wEBnAVtYPe & "|")>0  tHEn
mAInCOnTEnT = pROdUCtLIsT(c, d, e,f,"","",1)
j = cODe
cODe = mANyTImEShANdLEtEMpLAtEAcTIoN(j)	
mAInCOnTEnT = pROdUCtLIsT(c, d, e,f,"","", 1) : tEMpMAiNCoNTeNT = mAInCOnTEnT
cODe = rEPlACe(tEMpLAtEHtMLcODe, "{$MainContent$}", mAInCOnTEnT)
iF cREaTEhTMlPAtH = "" tHEn
cALl eERr("Class","创建类出问题，可能没有这个类")
eND iF
iF cHEcKMaKEhTMlFIlE(cREaTEhTMlPAtH) = fALsE tHEn
cALl wRItEToFIlE(cREaTEhTMlPAtH, mANyTImEShANdLEtEMpLAtEAcTIoN(j),1)	
cALl hANdLEmAKeHTmLFiLEeDItTImE(cREaTEhTMlPAtH)	
eND iF
iF cREaTEpAGe > 1 tHEn
fOR l=2 tO cREaTEpAGe
iF (rEQuESt("Page")=cSTr(l) oR rEQuESt("Page")="") aND iNStR(tEMpLAtEHtMLcODe,"{$MainContent$}")>0 tHEn
k = cREaTEhTMlPAtH	
mAInCOnTEnT = pROdUCtLIsT(c, d, e,f,"","", l)
cODe = rEPlACe(tEMpLAtEHtMLcODe, "{$MainContent$}", mAInCOnTEnT)
cODe = mANyTImEShANdLEtEMpLAtEAcTIoN(cODe)	
cALl cREaTEdIRfOLdER(k)	
q=k
q=mID(k,1,iNStR(k,".")-1)
q=q & l & mID(k,iNStR(k,"."))
iF rEQuESt("MackHtml") <> "False" tHEn
cALl eCHo("当前第【"& l &"】页",q)
eND iF
iF mAKeHTmLFiLEtOLcASe = tRUe tHEn
q=lCAsE(q)	
eND iF
cONtENt=hANdLEwEBcODeREpLAcETpL(mANyTImEShANdLEtEMpLAtEAcTIoN(cODe))
iF u=tRUe tHEn
iF cHEcKHtMLfORmATtINg(cONtENt)=fALsE tHEn
cALl eCHoREd("检测html标签出错", cREaTEhTMlPAtH)
eND iF
eND iF
cALl wRItEToFIlE(q, cONtENt,1) 	
cALl hANdLEmAKeHTmLFiLEeDItTImE(q)	
eND iF
dOEvENtS
nEXt
iF rEQuESt("Page")="" tHEn
cODe = rEPlACe(tEMpLAtEHtMLcODe, "{$MainContent$}", tEMpMAiNCoNTeNT)
cODe = mANyTImEShANdLEtEMpLAtEAcTIoN(cODe)	
eND iF
eND iF
m=tRUe 	
iF rEQuESt("MackHtml") <> "False" tHEn
cALl eCHo(c & ">>" & d & ">>" & e ,"共生成【"& cREaTEpAGe &"】页")
eND iF
eLSeIF f = "Search" tHEn
pAGe = iIF(rEQuESt("Page")<>"",rEQuESt("Page"),1)
mAInCOnTEnT =  pROdUCtLIsT(c, d, e,f, h, i, pAGe)	
m=fALsE
eND iF
iF rQ("HttpIP")<>"" tHEn	
cODe = rEPlACe(cODe, gETsERvICeRIp, rQ("HttpIP"))
eND iF
cODe = mANyTImEShANdLEtEMpLAtEAcTIoN(cODe)
iF rEQuESt("MackHtml") <> "False" tHEn
iF cHEcKFoLDeR(cREaTEhTMlPAtH)=tRUe tHEn
m=fALsE
eND iF
iF gETiP="127.0.0.1" oR sESsIOn("Administrator") <> "" oR mD5(rEQuESt("P"), 1) = "d7213640" tHEn
cALl eCHo("生成Html路径CreateHtmlPath", "<a href='"& hANdLEhTTpURl(wEBdOMaIN() & cREaTEhTMlPAtH) &"'"& aTArGEt("_blank") &">"& hANdLEpATh(cREaTEhTMlPAtH) &"</a>") 	
dOEvENtS
cALl eCHo("CreateHtmlYes",m)
iF cHEcKFiLE(tEMpLAtEPaTH)=tRUe tHEn
iF m=tRUe tHEn
iF cHEcKMaKEhTMlFIlE(cREaTEhTMlPAtH)=tRUe tHEn
cALl cREaTEdIRfOLdER(cREaTEhTMlPAtH)	
iF mAKeHTmLFiLEtOLcASe = tRUe tHEn
cREaTEhTMlPAtH=lCAsE(cREaTEhTMlPAtH)	
eND iF
cONtENt=hANdLEwEBcODeREpLAcETpL(mANyTImEShANdLEtEMpLAtEAcTIoN(cODe))
iF u=tRUe tHEn
iF cHEcKHtMLfORmATtINg(cONtENt)=fALsE tHEn
cALl eCHoREd("检测html标签出错", cREaTEhTMlPAtH)
eND iF
eND iF
cALl wRItEToFIlE(cREaTEhTMlPAtH, cONtENt,1)	
cALl hANdLEmAKeHTmLFiLEeDItTImE(cREaTEhTMlPAtH)	
eND iF
eND iF
eLSe
cALl sETcOLoREcHO("Green","生成失败", "模板文件【"& tEMpLAtEPaTH  &"】不存在")
eND iF
eLSe
cALl eCHo("生成文件失败","未登录")
eND iF
iF rEQuESt("gotoHtml") = "true" tHEn
cALl eERr("跳转网址" & hANdLEhTTpURl(wEBdOMaIN() & cREaTEhTMlPAtH), "<script>javascript:location='"& hANdLEhTTpURl(wEBdOMaIN() & cREaTEhTMlPAtH) &"'</script>")
eND iF
eND iF
iF rEQuESt("DisplayYes")="False"  tHEn dISpLAyYEs = fALsE
iF dISpLAyYEs = tRUe tHEn
iF rQ("ToHtml")="true" tHEn
cALl dIE("<script>location.href='"& cREaTEhTMlPAtH &"'</script>")
cALl eERr("CreateHtmlPath",cREaTEhTMlPAtH)	
eLSeIF rQ("gl") = "edit" tHEn	
iF iNStR(cODe,"</head>")>0 tHEn
cODe = rEPlACe(cODe,"</head>", "<script src=""/Jquery/Callcontext_menu.js""></script></head>")
eLSe
cODe = cODe & cONtROlDIaLOgCSs()
eND iF
iF iNStR(cODe,"<body>")>0 tHEn
cODe = rEPlACe(cODe,"<body>", "<body onLoad=""ContextMenu.intializeContextMenu()"">")
eLSe
cODe = cODe & cONtROlDIaLOgCSs()
eND iF
eND iF
cALl rW(hANdLEwEBcODeREpLAcETpL(cODe))	
eND iF
eND sUB
fUNcTIoN hANdLEmAKeHTmLFiLEeDItTImE(a)
iF cHEcKFoLDeR("\VB工程\") = fALsE tHEn eXIt fUNcTIoN
iF 1 = 2 tHEn eXIt fUNcTIoN
dIM b, c, tEMpLAtEFiLEeDItTImE 	
b = wEBtEMpLAtE & "/AVBConfig/" & hANdLEfILePAtHArRAy(tEMpLAtEPaTH)(3) & ".tpl"
tEMpLAtEFiLEeDItTImE = gETfILeEDiTDaTE(b)
c = gETsTRcUT(gETfTExT(b), "<VB IncludeTemplateFile path='", "'", 2)
iF c <> "" tHEn
c = gETsTRcUT(gETfTExT("\VB工程\SysInfo.ini"), "DefaultTemplateFolder=", vBCrLF, 2) & c
dIM fILeTImE	
fILeTImE = gETfILeEDiTDaTE(c)
tEMpLAtEFiLEeDItTImE=fILeTImE
iF tEMpLAtEFiLEeDItTImE<>"" tHEn	
iF cDAtE(fILeTImE)<cDAtE(tEMpLAtEFiLEeDItTImE) tHEn
tEMpLAtEFiLEeDItTImE=fILeTImE
eND iF
eLSe
tEMpLAtEFiLEeDItTImE=fILeTImE
eND iF
eND iF
iF tEMpLAtEFiLEeDItTImE <> "" tHEn
cALl mODiFYfILeMOdIFyDAtE(a, tEMpLAtEFiLEeDItTImE)
eND iF
eND fUNcTIoN
sUB dEFaULt()	
iF gETiP<>"127.0.0.1" aND sESsIOn("Administrator") = "" tHEn
cALl eCHo("提示","管理员未登录")
iF rEQuESt("VBPass") <> "" tHEn
sESsIOn("Administrator") = "vbLogin"
eND iF
eXIt sUB
eND iF
dIM b,c
b=b & "<script language=""javascript"">" & vBCrLF
b=b & "// 确定操作" & vBCrLF
b=b & "function Confirm(){" & vBCrLF
b=b & "	if(confirm(""你确定要操作吗？\n操作后将不可恢复""))" & vBCrLF
b=b & "	return true;" & vBCrLF
b=b & "	else" & vBCrLF
b=b & "	return false;" & vBCrLF
b=b & "}" & vBCrLF
b=b & "</script>" & vBCrLF
cALl rW(b)
cALl rW("<div style=""height:400px;"">")
c=" onClick='return Confirm();'"
b = "全部生成</a> &nbsp; | <a "& aHReF("?act=CreateNavList&File=False","","_blank") & c &">生成全部未生成</a>"
b = b & "  | <a href=http://www.maiside.net/Inc/Create_Html.Asp target='_blank'>新页打开</a>"
cALl eCHo("导航生成","<a "& aHReF("?act=ShowNavList","","_blank") &">点击进入</a> &nbsp; | <a "& aHReF("?act=CreateNavList","","_blank") & c & ">" & b)	
cALl rW("<hr>")
b = "全部生成</a> &nbsp; | <a "& aHReF("?act=CreateClassList&File=False","","_blank") & c &">生成全部未生成</a>"
cALl eCHo("类别生成","<a "& aHReF("?act=ShowClassList","","_blank") &">点击进入</a> &nbsp; | <a "& aHReF("?act=CreateClassList","","_blank") & c &">" & b)	
cALl rW("<hr>")
b = "全部生成</a> &nbsp; | <a "& aHReF("?act=CreateArticleList&File=False","","_blank") & c &">生成全部未生成</a>"	
cALl eCHo("文章生成","<a "& aHReF("?act=ShowArticleList","","_blank") &">点击进入</a> &nbsp; | <a "& aHReF("?act=CreateArticleList","","_blank") & c &">" & b)
cALl rW("<hr>")
cALl eCHo("会员生成","<a "& aHReF("?act=ShowMemberList","","_blank") &">点击进入</a> &nbsp; | <a "& aHReF("?act=CreateMemberList","","_blank") & c &">全部生成</a>")
cALl rW("<hr>")
cALl eCHo("生成RSS/Feed.Xml","<a "& aHReF("Rss.Asp","","_blank") & c &">点击生成</a>")
cALl rW("<hr>")
cALl eCHo("删除文件","<a "& aHReF("?act=ShowDelHtmllist","","_blank") &">点击进入</a> &nbsp; | <a "& aHReF("?act=ShowDelHtmllist&All=True","","_blank") & c &">删除全部HTML</a>")
cALl hR()
cALl eCHo("生成网站地图","<a "& aHReF("?act=MakeSiteMap","","_blank") &">点击进入</a>")
cALl rW("</div>")
eND sUB
sUB sHOwNAvLIsT()
dIM b,c
cALl rW("<title>显示生成导航列表</title>")
rS.oPEn "Select * From [NavBigClass] Order By Sort Asc", cONn, 1, 1
wHIlE nOT rS.eOF	
iF rS("OnHtml") = tRUe tHEn
b = rS("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
c =  "<a href=""?act=Nav&NavDid="& rS("BigClassName") &"&DisplayYes=False"" "& aTArGEt("_blank") &">点击生成</a>&nbsp;|&nbsp;"
c=c &  "<a href=""?Debug=1&act=Nav&NavDid="& rS("BigClassName") &"&MackHtml=False"" "& aTArGEt("_blank") &">动态预览</a>"
cALl eCHo( rS("BigClassName") & "("& rS("NavType") &")",c)
eLSe
cALl rW(rS("BigClassName") & " &nbsp; &nbsp; 为网址("& b &")，不生成<br>")
eND iF
eLSe
cALl rW(rS("BigClassName") & " &nbsp; &nbsp; 生成HTML未开启<br>")
eND iF
rSX.oPEn "Select * From [NavSmallClass] Where BigClassName='"& rS("BigClassName") &"' Order By Sort Asc", cONn, 1, 1
wHIlE nOT rSX.eOF
iF rSX("OnHtml") = tRUe tHEn
b = rSX("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
c = "<a href=""?act=Nav&NavDid="& rSX("BigClassName") &"&NavSid="& rSX("SmallClassName") &""" "& aTArGEt("_blank") &">点击生成</a>&nbsp;|&nbsp;"
c=c &  "<a href=""?Debug=1&act=Nav&NavDid="& rS("BigClassName") &"&NavSid="& rSX("SmallClassName") &"&MackHtml=False"" "& aTArGEt("_blank") &">动态预览</a>"
cALl eCHo( " &nbsp; &nbsp;[小类] " & rSX("SmallClassName"), c)
eLSe
cALl rW(" &nbsp; &nbsp;[小类] " & rSX("SmallClassName") & "为网址，不生成<br>")
eND iF
eLSe
cALl rW(" &nbsp; &nbsp;[小类] " & rSX("SmallClassName") & "生成HTML未开启<br>")
eND iF
rSX.mOVeNExT : wENd : rSX.cLOsE
rS.mOVeNExT : wENd : rS.cLOsE
cALl eCHo("全部生成", "<a href=""?act=CreateNavList"" "& aTArGEt("_blank") &">点击生成全部导航</a>")
eND sUB
fUNcTIoN hANdLEcODeREpLAcE(bYVaL a)
dIM b,c,d,e,f,g
b = rEQuESt("FindTpl")
c = rEQuESt("ReplaceTpl")
iF b = "" tHEn
b = "style='312'"
eND iF
iF wEBmODuLEsKInS <> "" tHEn
c = c & "style='"& wEBmODuLEsKInS &"'"	
eND iF
iF c = "" tHEn hANdLEcODeREpLAcE=a : eXIt fUNcTIoN
d=sPLiT(b,"|")
e=sPLiT(c,"|")
fOR f=0 tO uBOuND(d)
g=""
iF uBOuND(e)>=f tHEn
g=e(f)
eND iF
a=rEPlACe(a,d(f),g)
nEXt
d=sPLiT(wEBfINdTPl,"[$Array$]")
e=sPLiT(wEBrEPlACeTPl,"[$Array$]")
fOR f=0 tO uBOuND(d)
g=""
iF uBOuND(e)>=f tHEn
g=e(f)
eND iF
a=rEPlACe(a,d(f),g)
nEXt
hANdLEcODeREpLAcE = a
eND fUNcTIoN
fUNcTIoN hANdLEwEBcODeREpLAcETpL(a)
dIM b,c,d,e
b=sPLiT(wEBcODeFInDTpL,"[$Array$]")
c=sPLiT(wEBcODeREpLAcETpL,"[$Array$]")
fOR d=0 tO uBOuND(b)
e=""
iF uBOuND(c)>=d tHEn
e=c(d)
eND iF
a=rEPlACe(a,b(d),e)
nEXt
hANdLEwEBcODeREpLAcETpL = a
eND fUNcTIoN
sUB rUNfILe()
dIM b,c
b=rEQuESt("File")
c=gETfTExT(b)
c = mANyTImEShANdLEtEMpLAtEAcTIoN(c)	
rW(c)
rESpONsE.eND()
eND sUB
fUNcTIoN  cREaTEnAVlISt()
dIM b, c,d,e,f,g,h
f = 0	
d = nOW ()
dISpLAyYEs = fALsE	
sET b = cREaTEoBJeCT("Adodb.RecordSet")
sET c = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [NavBigClass] Where OnHtml=True Order By Sort", cONn, 1, 1
f = f + b.rECoRDcOUnT
wHIlE nOT b.eOF
g = fALsE
iF lCAsE(rEQuESt("File"))="false" tHEn
cALl gETnAVtEMpLAtETeXT(b("BigClassName"), "", "")
g = cHEcKFiLE(cREaTEhTMlPAtH)
eND iF
e = e + 1
cALl eCHo("当前位置",e & "/" & f)
iF g = fALsE tHEn
h = b("FileName")
iF cHEcKMaKEhTMlFIlE(h)=tRUe tHEn	
cALl eCHo("导航大类", b("BigClassName"))
cALl mAKeWEbHTmL(b("BigClassName"),"","","","","Nav","","","")
eLSe
cALl rW("导航大类：" & b("BigClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
eLSe
cALl eCHo("导航大类("& b("BigClassName") &")", "<a href='"& cREaTEhTMlPAtH &"'"& aTArGEt("_blank") &">"& cREaTEhTMlPAtH &"</a>" & "已经存在")
eND iF
c.oPEn "Select * From [NavSmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", cONn, 1, 1
f = f + c.rECoRDcOUnT
wHIlE nOT c.eOF	
g = fALsE
iF lCAsE(rEQuESt("File"))="false" tHEn
cALl gETnAVtEMpLAtETeXT(c("BigClassName"), c("SmallClassName"), "")
g = cHEcKFiLE(cREaTEhTMlPAtH)
eND iF
e = e + 1
iF g = fALsE tHEn
h = c("FileName")
iF cHEcKMaKEhTMlFIlE(h)=tRUe tHEn	
cALl eCHo(" &nbsp; &nbsp;导航小类", c("SmallClassName"))
cALl mAKeWEbHTmL(c("BigClassName"),c("SmallClassName"),"","","","Nav","","","")
eLSe
cALl rW("导航小类：" & c("SmallClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
eLSe
cALl eCHo(" &nbsp; &nbsp;导航小类", "<a href='"& cREaTEhTMlPAtH &"'"& aTArGEt("_blank") &">"& cREaTEhTMlPAtH &"</a>" & "已经存在")
eND iF
c.mOVeNExT : wENd : c.cLOsE
dOEvENtS
cALl hR()
b.mOVeNExT:wENd:b.cLOsE
sET b = nOThINg
sET c = nOThINg
cALl eCHo("操作完成", "导航，共生成文件【"& f &"】个，用时" & pRInTTiMEvALuE(dATeDIfF("s", d, nOW())) )
eND fUNcTIoN
sUB sHOwCLaSSlISt()
dIM b,s	
cALl rW("<title>显示生成产品类别列表</title>")
rS.oPEn "Select * From [BigClass] Order By Sort Asc", cONn, 1, 1
wHIlE nOT rS.eOF
b = rS("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
s = "<a href=""?act=CreateClass&ProDid="& rS("BigClassName") &""" "& aTArGEt("_blank") &">点击生成</a>&nbsp;|&nbsp;"
s=s & "<a href=""?Debug=1&act=CreateClass&ProDid="& rS("BigClassName") &"&MackHtml=False"" "& aTArGEt("_blank") &">动态预览</a>"
cALl eCHo( rS("BigClassName") & "(大类)", s)
eLSe
cALl rW("类别大类：" & rS("BigClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
rSX.oPEn "Select * From [SmallClass] Where BigClassName='"& rS("BigClassName") &"' Order By Sort Asc", cONn, 1, 1
wHIlE nOT rSX.eOF
b = rSX("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
s = "<a href=""?act=CreateClass&ProDid="& rSX("BigClassName") &"&ProSid="& rSX("SmallClassName") &""" "& aTArGEt("_blank") &">点击生成</a>&nbsp;|&nbsp;"
s=s & "<a href=""?Debug=1&act=CreateClass&ProDid="& rS("BigClassName") &"&ProSid="& rSX("SmallClassName") &"&MackHtml=False"" "& aTArGEt("_blank") &">动态预览</a>"
cALl eCHo( " &nbsp; &nbsp;"&  rSX("SmallClassName") &"[小类] ", s)
eLSe
cALl rW("类别小类：" & rSX("SmallClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
rSS.oPEn "Select * From [ThreeClass] Where BigClassName='"& rSX("BigClassName") &"' And SmallClassName='"& rSX("SmallClassName") &"' Order By Sort Asc", cONn, 1, 1
wHIlE nOT rSS.eOF
b = rSS("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
s = "<a href=""?act=CreateClass&ProDid="& rSS("BigClassName") &"&ProSid="& rSS("SmallClassName") &"&ProTid="& rSS("ThreeClassName") &""" "& aTArGEt("_blank") &">点击生成</a>&nbsp;|&nbsp;"
s=s & "<a href=""?Debug=1&act=CreateClass&ProDid="& rS("BigClassName") &"&ProSid="& rSX("SmallClassName") &"&ProTid=" & rSS("ThreeClassName") &"&MackHtml=False"" "& aTArGEt("_blank") &">动态预览</a>"
cALl eCHo( " &nbsp; &nbsp; &nbsp; &nbsp;"&  rSS("ThreeClassName") &"[子类] ", s)
eLSe
cALl rW("类别子类：" & rSS("ThreeClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
rSS.mOVeNExT : wENd : rSS.cLOsE
rSX.mOVeNExT : wENd : rSX.cLOsE
rS.mOVeNExT : wENd : rS.cLOsE
cALl eCHo("全部生成", "<a href=""?act=CreateClassList"" "& aTArGEt("_blank") &">点击生成全部信息类别列表</a>")
eND sUB
fUNcTIoN  cREaTEcLAsSLiST()
dIM b, c, d,e,f,g,h,i,j
g = 0	
f = 0
e = nOW ()
dISpLAyYEs = fALsE	
sET b = cREaTEoBJeCT("Adodb.RecordSet")
sET c = cREaTEoBJeCT("Adodb.RecordSet")
sET d = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [BigClass] Where OnHtml=True Order By Sort", cONn, 1, 1
g = g + b.rECoRDcOUnT
wHIlE nOT b.eOF
i = fALsE
iF lCAsE(rEQuESt("File"))="false" tHEn
cALl gETcLAsSTeMPlATeTExT(b("BigClassName"), "", "")
i = cHEcKFiLE(cREaTEhTMlPAtH)
eND iF	
f = f + 1
cALl eCHo("当前位置",f & "/" & g)
iF i = fALsE tHEn	
j = b("FileName")
iF cHEcKMaKEhTMlFIlE(j)=tRUe tHEn
cALl eCHo("类别大类", b("BigClassName"))
cALl mAKeWEbHTmL("","",b("BigClassName"),"","","Class","","","")
eLSe
cALl rW("类别大类：" & b("BigClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
eLSe
cREaTEhTMlPAtH = "<a href='"& cREaTEhTMlPAtH &"' target='_blank'>"& cREaTEhTMlPAtH &"</a>"
cALl eCHo("类别大类("& b("BigClassName") &")", cREaTEhTMlPAtH & "已经存在")
eND iF
cALl hR()
dOEvENtS
c.oPEn "Select * From [SmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", cONn, 1, 1
g = g + c.rECoRDcOUnT
wHIlE nOT c.eOF	
i = fALsE
iF lCAsE(rEQuESt("File"))="false" tHEn
cALl gETcLAsSTeMPlATeTExT(c("BigClassName"), c("SmallClassName"), "")
i = cHEcKFiLE(cREaTEhTMlPAtH)
eND iF	
f = f + 1
cALl eCHo("当前位置",f & "/" & g)
iF i = fALsE tHEn	
j = c("FileName")
iF cHEcKMaKEhTMlFIlE(j)=tRUe tHEn
cALl eCHo(" &nbsp; &nbsp;类别小类", c("SmallClassName"))
cALl mAKeWEbHTmL("","",c("BigClassName"),c("SmallClassName"),"","Class","","","")
eLSe
cALl rW("类别子类：" & c("SmallClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
eLSe
cREaTEhTMlPAtH = "<a href='"& cREaTEhTMlPAtH &"' target='_blank'>"& cREaTEhTMlPAtH &"</a>"
cALl eCHo(" &nbsp; &nbsp;类别小类("& c("SmallClassName") &")", cREaTEhTMlPAtH & "已经存在")
eND iF
cALl hR()
dOEvENtS
h = " And SmallClassName='"& c("SmallClassName") &"' And OnHtml=True Order By Sort Asc"
d.oPEn "Select * From [ThreeClass] Where BigClassName='"& b("BigClassName") &"' " & h, cONn, 1, 1
g = g + d.rECoRDcOUnT
wHIlE nOT d.eOF	
i = fALsE
iF lCAsE(rEQuESt("File"))="false" tHEn
cALl eCHo("WebTitle",wEBtITlE)
cALl gETcLAsSTeMPlATeTExT(d("BigClassName"), d("SmallClassName"), d("ThreeClassName"))
i = cHEcKFiLE(cREaTEhTMlPAtH)
eND iF
f = f + 1
cALl eCHo("当前位置",f & "/" & g)
iF i = fALsE tHEn
j = d("FileName")
iF cHEcKMaKEhTMlFIlE(j)=tRUe tHEn
cALl eCHo(" &nbsp; &nbsp; &nbsp; &nbsp;类别子类", d("SmallClassName"))
cALl mAKeWEbHTmL("","",d("BigClassName"),d("SmallClassName"), d("ThreeClassName"),"Class","","","")
eLSe
cALl rW("类别子类：" & d("ThreeClassName") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
eLSe
cREaTEhTMlPAtH = "<a href='"& cREaTEhTMlPAtH &"' target='_blank'>"& cREaTEhTMlPAtH &"</a>"
cALl eCHo(" &nbsp; &nbsp; &nbsp; &nbsp;类别子类("& d("ThreeClassName") &")", cREaTEhTMlPAtH & "已经存在")
eND iF
cALl hR()
dOEvENtS
d.mOVeNExT : wENd : d.cLOsE
dOEvENtS	
c.mOVeNExT : wENd : c.cLOsE 	
b.mOVeNExT:wENd:b.cLOsE
sET b = nOThINg
sET c = nOThINg
sET d = nOThINg
cALl eCHo("操作完成", "产品类别，共生成文件【"& g &"】个，用时" & pRInTTiMEvALuE(dATeDIfF("s", e, nOW())) )
eND fUNcTIoN
sUB sHOwMEmBErLIsT()
dIM b
rS.oPEn "Select * From [Member] Order By Sort Asc", cONn, 1, 1
wHIlE nOT rS.eOF
cALl eCHo( rS("MyName") & "(会员账号)", "<a href=""?act=CreateMember&ID="& rS("ID") &""" "& aTArGEt("_blank") &">点击生成</a>")
rS.mOVeNExT : wENd : rS.cLOsE
cALl eCHo("全部生成", "<a href=""?act=CreateMemeberList"" "& aTArGEt("_blank") &">点击生成全部文章信息</a>")
eND sUB
sUB sHOwDElHTmLLiST()
dIM b,c,d,e,f,g
b=fALsE
iF b = fALsE tHEn
iF gETiP()="127.0.0.1" tHEn b=tRUe
eND iF
c = rEPlACe(rEPlACe(lCAsE(gEThOSt()),"http://",""),"/","")
iF b = fALsE tHEn
iF c="127.0.0.1" oR c = "localhost" oR lEFt(c,8)="192.168." tHEn b=tRUe
eND iF
iF b=tRUe tHEn
cALl eCHo("提示", "为本地，不可操作")	
rESpONsE.eND()
eXIt sUB
eND iF
e=gETdIRhTMlLIsT("/")
d=sPLiT(e,vBCrLF)
fOR eACh f iN d
cALl eCHo("删除文件成功", f)
cALl dELeTEfILe(f)
nEXt
e =gETdIRfOLdERnAMeLIsT("/")
d=sPLiT(e,vBCrLF)
fOR eACh g iN d
iF iNStR(lCAsE("|Action|Admin|AspBox|aspnet_client|BBS|DataDir|Data|Editor|Help|Images|Inc|Jquery|M|Maiside|maisideAPP|Mobile|Module|OtherAsp|QQ|Skins|Templates|UploadFiles|User|WebAdmin|Xinxi|XSS|CGI-BIN|HttpErrors|Web_Soft|"),"|"& lCAsE(g) &"|")=fALsE tHEn
cALl eCHo("删除文件夹成功", g)
cALl dELeTEfOLdER("/" & g)
eND iF
nEXt
cALl eCHo("删除全部HTML","完成")
eND sUB
sUB sHOwDElHTmLLiST2()
dIM b, c,d,e,f,g,h,i,j,k,l
f = 0	
d = nOW ()
dISpLAyYEs = fALsE	
sET b = cREaTEoBJeCT("Adodb.RecordSet")
sET c = cREaTEoBJeCT("Adodb.RecordSet")
sET j = cREaTEoBJeCT("Adodb.RecordSet")
sET l = cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select * From [NavBigClass] Where OnHtml=True Order By Sort", cONn, 1, 1
f=f+b.rECoRDcOUnT
wHIlE nOT b.eOF
e = e + 1
h = gETnAVuRL(b("BigClassName"),"")
iF rIGhT(h,1) = "/" tHEn h=h & "Index.html"	
i = iIF(cHEcKFiLE(h)=tRUe aND rEQuESt("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
i= "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
cALl eCHo(b("BigClassName"), i )
iF rEQuESt("All")= "True" tHEn dELfILe(h) : cALl eCHo("当前位置",e & "/" & f)
cALl hR()	
dOEvENtS
c.oPEn "Select * From [NavSmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", cONn, 1, 1
f=f+c.rECoRDcOUnT
wHIlE nOT c.eOF
e = e + 1
h =  gETnAVuRL(c("BigClassName"),c("SmallClassName"))
iF rIGhT(h,1) = "/" tHEn h=h & "Index.html"
iF rEQuESt("All")= "True" tHEn dELfILe(h) : cALl eCHo("当前位置",e & "/" & f)
i = iIF(cHEcKFiLE(h)=tRUe aND rEQuESt("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
cALl eCHo(c("SmallClassName"),h & i)
cALl hR()
dOEvENtS
c.mOVeNExT : wENd : c.cLOsE
b.mOVeNExT:wENd:b.cLOsE
b.oPEn "Select * From [BigClass] Where OnHtml=True Order By Sort", cONn, 1, 1
f=f+b.rECoRDcOUnT
wHIlE nOT b.eOF
e = e + 1
h = gETbIGcLAsSFoLDeRNaME(b("BigClassName"))
iF rIGhT(h,1) = "/" tHEn h=h & "Index.html"	
i = iIF(cHEcKFiLE(h)=tRUe aND rEQuESt("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
i= "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
cALl eCHo(b("BigClassName"), i )
iF rEQuESt("All")= "True" tHEn dELfILe(h) : cALl eCHo("当前位置",e & "/" & f)
cALl hR()
dOEvENtS
c.oPEn "Select * From [SmallClass] Where BigClassName='"& b("BigClassName") &"' And OnHtml=True Order By Sort Asc", cONn, 1, 1
f=f+c.rECoRDcOUnT
wHIlE nOT c.eOF	
e = e + 1
h = gETsMAlLClASsFOlDErNAmE(c("BigClassName"),c("SmallClassName") )
iF rIGhT(h,1) = "/" tHEn h=h & "Index.html"	
i = iIF(cHEcKFiLE(h)=tRUe aND rEQuESt("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
i = "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
cALl eCHo(" &nbsp; &nbsp; " & c("SmallClassName"), i )
iF rEQuESt("All")= "True" tHEn dELfILe(h) : cALl eCHo("当前位置",e & "/" & f)
cALl hR()
dOEvENtS
k = " And SmallClassName='"& c("SmallClassName") &"' And OnHtml=True Order By Sort Asc"
j.oPEn "Select * From [ThreeClass] Where BigClassName='"& c("BigClassName") &"' " & k, cONn, 1, 1
f=f+j.rECoRDcOUnT
wHIlE nOT j.eOF	
e = e + 1
h = gETtHReEClASsFOlDErNAmE(j("BigClassName"),j("SmallClassName"),j("ThreeClassName") )
iF rIGhT(h,1) = "/" tHEn h=h & "Index.html"
i = iIF(cHEcKFiLE(h)=tRUe aND rEQuESt("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
i = "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
cALl eCHo(" &nbsp; &nbsp; &nbsp; &nbsp; " & j("ThreeClassName"), i )
iF rEQuESt("All")= "True" tHEn dELfILe(h) : cALl eCHo("当前位置",e & "/" & f)
cALl hR()
dOEvENtS
j.mOVeNExT : wENd : j.cLOsE	
c.mOVeNExT : wENd : c.cLOsE
b.mOVeNExT:wENd:b.cLOsE
l.oPEn "Select * From [Product] Where OnHtml=True Order By Sort Asc", cONn, 1, 1
f=f+l.rECoRDcOUnT
wHIlE nOT l.eOF
e = e + 1
h = gETpROdUCtURl("Where Id=" & l("ID"))
iF rIGhT(h,1) = "/" tHEn h=h & "Index.html"
i = iIF(cHEcKFiLE(h)=tRUe aND rEQuESt("All") <> "True", " &nbsp; <a href='?act=DelFile&FileName="& h &"' target='_blank'>删除文件</a>", "")
i = "<a href='"& h &"' target='_blank'>"& h &"</a>" & i
cALl eCHo(l("ID"), i )
iF rEQuESt("All")= "True" tHEn dELfILe(h) : cALl eCHo("当前位置",e & "/" & f)
cALl hR()
dOEvENtS
l.mOVeNExT : wENd : l.cLOsE
iF rEQuESt("All")= "True" tHEn
cALl eCHo("操作完成", "删除，共删除文件【"& f &"】个，用时" & pRInTTiMEvALuE(dATeDIfF("s", d, nOW())) )
eLSe
cALl eCHo("全部删除","<a "& aHReF("?act=ShowDelHtmllist&All=True","","_blank") &">点击删除全部HTML</a>")
eND iF
eND sUB
fUNcTIoN dELfILe(a)
dIM b
b = dELeTEfILe(a)
cALl eCHo("删除文件", a & " &nbsp;" & b)
eND fUNcTIoN
sUB sHOwARtIClELiST()
dIM b,c
rS.oPEn "Select * From [Product] Where OnHtml=True Order By Id Desc", cONn, 1, 1 	
wHIlE nOT rS.eOF	
b = rS("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
c = iIF(rS("OnHtml") = tRUe,"<a href=""?act=CreateArticle&ID="& rS("ID") &""" "& aTArGEt("_blank") &">点击生成</a>&nbsp;|&nbsp;","")	
c = c & "<a href=""?Debug=1&act=CreateArticle&ID="& rS("ID") &"&MackHtml=False"" "& aTArGEt("_blank") &">动态预览</a>"
b = gEThANdLEuRL( rS("FolderName") & rS("FileName"))
b = " &nbsp; <a href='"& b &"' target='_blank'>"& b &"</a>," & cHEcKFiLE(b)	
cALl eCHo( rS("Title") & "(信息标题)", c & b & ",日期" & fORmAT_TImE(rS("AddDateTime"),4))
eLSe
cALl rW("文章信息：" &  rS("Title") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF	
rS.mOVeNExT : wENd : rS.cLOsE
cALl eCHo("全部生成", "<a href=""?act=CreateArticleList"" "& aTArGEt("_blank") &">点击生成全部文章信息</a>")
eND sUB
sUB cREaTEaRTiCLe(a)
dIM b,c,d,e
dIM f,g,h,i
dIM oRIgINaLPhOToWIdTH	
dIM nDEtAIlPHoTOwIDtH	
dIM dETaILpHOtOWiDThSTr	
dIM m,n,o,p,q,r,s
dIM aUThOR	
rS.oPEn"Select * From [Product] Where Id=" & a,cONn,1,1
iF nOT rS.eOF tHEn
tEMpDId = rS("BigClassName")
tEMpSId = rS("SmallClassName")
tEMpTId = rS("ThreeClassName")	
pUBpROdID=tEMpDId
pUBpROsID=tEMpSId
pUBpROtID=tEMpTId
mAInTItLE = rS("Title")	
c = tRIm(iIF(iSNuL(rS("BigFiles")),rS("SmallFiles"),rS("BigFiles")))
c = rEPlACeGLoBLeLAbLE(c) : d = c
dIM tEMpLAtESoURcEId	
tEMpLAtESoURcEId = gETaRTiCLeINfOStYLe(tEMpDId,tEMpSId,tEMpTId,a)
e = rEAdARtIClEInFOsTYlESoURcE(tEMpLAtESoURcEId)
iF (d <> "" aND lEN(d)>5)  tHEn
iF cHEcKUrL(d) = fALsE aND cHEcKFiLE(d)=tRUe tHEn
nDEtAIlPHoTOwIDtH = gETaRTiCLeINfOPhOToWIdTH(tEMpDId,tEMpSId,tEMpTId,a)	
nDEtAIlPHoTOwIDtH = cINt(nDEtAIlPHoTOwIDtH)	
oRIgINaLPhOToWIdTH = gETiMAgEWiDThVAlUE(d)	
nDEtAIlPHoTOwIDtH = iIF(oRIgINaLPhOToWIdTH>nDEtAIlPHoTOwIDtH,nDEtAIlPHoTOwIDtH,oRIgINaLPhOToWIdTH)
iF nDEtAIlPHoTOwIDtH<>"" tHEn dETaILpHOtOWiDThSTr = " width="""& nDEtAIlPHoTOwIDtH &""""
eLSe
nDEtAIlPHoTOwIDtH = ""	
dETaILpHOtOWiDThSTr = ""
eND iF
eND iF
aUThOR = rS("Author")
iF aUThOR="" tHEn aUThOR="本站"
e = rEPlACe(e,"[$updownpage$]",uPPaGE(rS(0)) & dOWnPAgE(rS(0))) 	
e = rEPlACe(e,"[$detilphotowidth$]",nDEtAIlPHoTOwIDtH)	
e = rEPlACe(e,"[$detilphotowidthstr$]",dETaILpHOtOWiDThSTr)	
e = rEPlACeVAlUEpARaM(e,"did",tEMpDId)
e = rEPlACeVAlUEpARaM(e,"id",rS("Id"))	
e = rEPlACeVAlUEpARaM(e,"title",rS("title"))
e = rEPlACeVAlUEpARaM(e,"imgurl",c)
e = rEPlACeVAlUEpARaM(e,"price",rS("Price"))
e = rEPlACeVAlUEpARaM(e,"description",rS("WebDescription"))	
e = rEPlACeVAlUEpARaM(e,"adddatetime",rS("AddDateTime"))
e = rEPlACeVAlUEpARaM(e,"author",aUThOR)
e = rEPlACeVAlUEpARaM(e,"content",rS("Content"))
mAInCOnTEnT = e
iF nDEtAIlPHoTOwIDtH = "" tHEn
h = "<!--#photo start#-->" : i = "<!--#photo end#-->"
iF iNStR(mAInCOnTEnT,h)>0 aND iNStR(mAInCOnTEnT,i)>0 tHEn
e = sTRcUT(mAInCOnTEnT,h,i,2)
eND iF
eND iF
mAInCOnTEnT = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"Product.Asp?act=ShowEditProduct&Id=" & rS("Id") & "&n=" & gETrND(11), mAInCOnTEnT)
aRTiCLeDId=rS("BigClassName")	
aRTiCLeSId=rS("SmallClassName")	
aRTiCLeTId=rS("ThreeClassName")	
aRTiCLeTItLE=rS("Title")	
aRTiCLeBIgFIlES=rS("BigFiles")	
aRTiCLeSMaLLfILeS=rS("SmallFiles")	
aRTiCLeID=rS("Id")	
aRTiCLeDAtETiME=rS("AddDateTime")	
aRTiCLeCOnTEnT=rS("Content")	
aRTiCLeAUtHOr = rS("Author")	
iF tRIm(rS("TemplatePath"))<>"" tHEn
tEMpLAtEPaTH = wEBtEMpLAtE & rS("TemplatePath")
eLSe
tEMpLAtEPaTH = wEBtEMpLAtE & "Main_Model.Html"
eND iF
b = rS("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
b = gEThANdLEfILeNAmE(b)
b = dETaILpAGeADdHTmLPrEFiX(rS("FolderName")) & "/" & b
eND iF
cREaTEhTMlPAtH = b
wEBtITlE = iIF(rS("Title")<>"",rS("Title"),wEBtITlE)
wEBtITlE = iIF(rS("WebTitle")<>"",rS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(rS("WebKeywords")<>"",rS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(rS("WebDescription")<>"",rS("WebDescription"),wEBdEScRIpTIoN)
eND iF:rS.cLOsE
eND sUB
sUB cREaTEmAInINfO(a)
dIM b,c
rS.oPEn"Select * From [MainInfo] Where Id=" & a,cONn,1,1
iF nOT rS.eOF tHEn
mAInCOnTEnT = rS("Content")
mAInCOnTEnT = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"MainInfo.Asp?act=ShowEdit&Id=" & rS("Id") & "&n=" & gETrND(11), mAInCOnTEnT)	
mAInTItLE = rS("ShowTitle")
iF tRIm(rS("TemplatePath"))<>"" tHEn
tEMpLAtEPaTH = wEBtEMpLAtE & rS("TemplatePath")
eLSe
tEMpLAtEPaTH = wEBtEMpLAtE & "Main_Model.Html"
eND iF
b = tRIm(rS("FileName"))
b = gEThANdLEfILeNAmE(b)
cALl cREaTEdIRfOLdER("/Html")
cREaTEhTMlPAtH = dETaILpAGeADdHTmLPrEFiX(rS("FolderName")) & "/" & b
cREaTEhTMlPAtH = gEThANdLEuRL(cREaTEhTMlPAtH)	
wEBtITlE = iIF(rS("Title")<>"",rS("Title"),wEBtITlE)
wEBtITlE = iIF(rS("WebTitle")<>"",rS("WebTitle"),wEBtITlE)
wEBkEYwORdS = iIF(rS("WebKeywords")<>"",rS("WebKeywords"),wEBkEYwORdS)
wEBdEScRIpTIoN = iIF(rS("WebDescription")<>"",rS("WebDescription"),wEBdEScRIpTIoN)
eND iF:rS.cLOsE
eND sUB
sUB cREaTEaRTiCLeLIsT()
dIM b,c,d,e,f
d = 0	
c = nOW ()
dISpLAyYEs = fALsE	
sET b=cREaTEoBJeCT("Adodb.RecordSet")
b.oPEn "Select Top 2999 * From [Product] Where ONHtml=True", cONn, 1, 1
wHIlE nOT b.eOF
e = fALsE
cALl eCHo("文章ID", b("ID"))
iF lCAsE(rEQuESt("File"))="false" tHEn
cALl cREaTEaRTiCLe(b("ID"))
e = cHEcKFiLE(cREaTEhTMlPAtH)
eND iF
d = d + 1
dOEvENtS
iF e = fALsE tHEn
cALl eCHo("当前位置", d & "/" & b.rECoRDcOUnT)
dOEvENtS
f = b("FileName")
iF cHEcKMaKEhTMlFIlE(f)=tRUe tHEn
cALl mAKeWEbHTmL("","","","","","Article", b("Id"),"","")
eLSe
cALl rW("文章信息：" & b("Title") & " &nbsp; &nbsp; 当前为网址，不生成<br>")
eND iF
eLSe
cREaTEhTMlPAtH = "<a href='"& cREaTEhTMlPAtH &"' target='_blank'>"& cREaTEhTMlPAtH &"</a>"
cALl eCHo("文章ID("& b("ID") &")", cREaTEhTMlPAtH & "已经存在，当前位置("& d & "/" & b.rECoRDcOUnT &")")
eND iF
cALl hR()
dOEvENtS
b.mOVeNExT : wENd : b.cLOsE
sET b=nOThINg
cALl eCHo("操作完成", "文章，共生成文件【"& d &"】个，用时" & pRInTTiMEvALuE(dATeDIfF("s", c, nOW())) )
eND sUB
sUB gETwEBcONfIG()
dIM b, c
iF dEFaULtWEbTItLE <> "" tHEn	
wEBtITlE = dEFaULtWEbTItLE
wEBkEYwORdS = dEFaULtWEbKEyWOrDS
wEBdEScRIpTIoN = dEFaULtWEbDEsCRiPTiON
eXIt sUB
eND iF
rS.oPEn "Select * From [WebSite]", cONn, 1, 1
iF nOT rS.eOF tHEn
wEBtEMpLAtE = hANdLEhTTpURl(rS("WebTemplate"))
wEBsKInS = hANdLEhTTpURl(rS("WebSkins")) 	
wEBiMAgES = hANdLEhTTpURl(rS("WebImages")) 	
wEBcSS = hANdLEhTTpURl(rS("WebCss")) 	
wEBjS = hANdLEhTTpURl(rS("WebJs"))
wEBfOLdERnAMe = pHPtRIm(rS("WebFolderName"))	
iSHtMLfORmATtINg = lCAsE(rS("isHtmlFormatting"))
iSHtMLfORmATtINg=iIF(iSHtMLfORmATtINg="0" oR iSHtMLfORmATtINg="false",fALsE,tRUe)
iSWeBLaBElCLoSE = lCAsE(rS("isWebLabelClose"))
iSWeBLaBElCLoSE=iIF(iSWeBLaBElCLoSE="0" oR iSWeBLaBElCLoSE="false",fALsE,tRUe)
wEBuRL = rS("WebSiteUrl")
wEBtITlE = rS("WebTitle")
wEBkEYwORdS = rS("WebKeywords")
wEBdEScRIpTIoN = rS("WebDescription")
wEBbOTtOM = rS("WebSiteBottom")
wEBmODuLEsKInS = rS("ModuleSkins")	
wEBfINdTPl = rS("FindTpl")	
wEBrEPlACeTPl = rS("ReplaceTpl")	
wEBcODeFInDTpL = rS("WebCodeFindTpl")	
wEBcODeREpLAcETpL = rS("WebCodeReplaceTpl")	
iF iSNuL(wEBcODeFInDTpL) tHEn wEBcODeFInDTpL=""
iF iSNuL(wEBcODeREpLAcETpL) tHEn wEBcODeREpLAcETpL=""
c=rS("Id")
b = ""& aDMiNDiR &"WebSiteConfig.Asp?n=" & gETrND(11)	
wEBbOTtOM = dISpLAyONlINeEDiTDiALoG(b, wEBbOTtOM)
eND iF : rS.cLOsE
eND sUB
fUNcTIoN nAViGAtIOn(a)
dIM b,c, d, e, f,g,h,i,j,k,l,m
rS.oPEn "Select * From [NavBigClass]" & a, cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
f = rS("FileName")
iF f <> "" tHEn f = f & ".html"
h = "/" & rS("FolderName") & "/"
e = h & f
e = rEPlACe(rEPlACe(e, "//", "/"), "//", "/")
j = rS("BigClassName")
k = fONtCOlORfONtB(j,rS("FontB"),rS("FontColor"))
i = rS("Target")
g = ""
iF b = 1 tHEn g = " class='CurrentLi'"
c = "<li"& g &"><a "& aHReF(e,"",i) &"{下拉菜单}>" & k & "</a></li> "
iF rS("NavType") = "文本" tHEn
rSS.oPEn "Select * From [NavSmallClass] Where BigClassName='"& rS("BigClassName") &"'", cONn, 1, 1
iF nOT rS.eOF tHEn
c = c & "<div id='m"& b &"' onmouseover='mcancelclosetime()' onmouseout='mclosetime()'>"
wHIlE nOT rSS.eOF
f = rSS("FileName")
iF f <> "" tHEn f = f & ".html"
e = h & f
e = h & "/" & rSS("FolderName") & "/" & f
e = rEPlACe(rEPlACe(e, "//", "/"), "//", "/")
l = rSS("SmallClassName")
m = fONtCOlORfONtB(l,rSS("FontB"),rSS("FontColor"))
i = rSS("Target")
c = c & "<a "& aHReF(e,"",i) &">" & m & "</a>"
rSS.mOVeNExT:wENd:rSS.cLOsE
c = c & "</div>"
c = rEPlACe(c,"{下拉菜单}", " onmouseover=mopen('m"& b &"') onmouseout='mclosetime()' ")
eND iF
eLSeIF rS("NavType") = "产品" oR rS("NavType") = "新闻" tHEn
rSS.oPEn "Select * From [SmallClass] Where BigClassName='"& rS("BigClassName") &"'", cONn, 1, 1
iF nOT rS.eOF tHEn
c = c & "<div id='m"& b &"' onmouseover='mcancelclosetime()' onmouseout='mclosetime()'>"
wHIlE nOT rSS.eOF
f = rSS("FileName")
iF f <> "" tHEn f = f & ".html"
e = h & f
e = h & "/" & rSS("FolderName") & "/" & f
e = rEPlACe(rEPlACe(e, "//", "/"), "//", "/")
l = rSS("SmallClassName")
m = fONtCOlORfONtB(l,rSS("FontB"),rSS("FontColor"))
i = rSS("Target")
c = c & "<a "& aHReF(e,"",i) &">" & m & "</a>"
rSS.mOVeNExT:wENd:rSS.cLOsE
c = c & "</div>"
c = rEPlACe(c,"{下拉菜单}", " onmouseover=mopen('m"& b &"') onmouseout='mclosetime()' ")
eND iF
eND iF
c = rEPlACe(c,"{下拉菜单}","")	
d = d & c
rS.mOVeNExT : nEXt : rS.cLOsE
nAViGAtIOn = d
eND fUNcTIoN
fUNcTIoN bOTtOMnAViGAtIOn(a)
dIM b,c, d, e, f,g,h,i,j,k
rS.oPEn "Select * From [NavBigClass]" & a, cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
f = rS("FileName")
iF f <> "" tHEn f = f & ".html"
h = "/" & rS("FolderName") & "/"
e = h & f
e = rEPlACe(rEPlACe(e, "//", "/"), "//", "/")
i = rS("BigClassName")
j = fONtCOlORfONtB(i,rS("FontB"),rS("FontColor"))
k = rS("Target")
d=d & "<a "& aHReF(e,"",k) &"{下拉菜单}>" & j & "</a>"
iF b <> rS.rECoRDcOUnT tHEn d = d & " &nbsp;| &nbsp; "
rS.mOVeNExT : nEXt : rS.cLOsE
bOTtOMnAViGAtIOn = d
eND fUNcTIoN
fUNcTIoN gETmAInINfO(a, b, c)
dIM d,e
rS.oPEn"Select * From [MainInfo] Where Title='"& b &"' And Recommend=True Order By Sort,ID",cONn,1,1
iF nOT rS.eOF tHEn
a = rEPlACe(a, rEPlACe(c,"$}","Title$}"), rS("Title"))
a = rEPlACe(a, rEPlACe(c,"$}","ShowTitle$}"), rS("ShowTitle"))
a = rEPlACe(a, rEPlACe(c,"$}","Content$}"), rS("Content"))	
eND iF : rS.cLOsE
gETmAInINfO = a
eND fUNcTIoN
fUNcTIoN lOGo(a)
dIM b,c
rS.oPEn"Select * From [Product] Where BigClassName='"& a &"' And Recommend=True Order By Sort,ID",cONn,1,1
iF nOT rS.eOF tHEn
b = gEThANdLEuRL( rS("FileName") )
c = "<a href='"& b &"' target='_blank'><img border=0 src='"& rS("BigFiles") &"' alt='"& rS("Title") &"'></a>"
eND iF : rS.cLOsE
lOGo = c
eND fUNcTIoN
fUNcTIoN bANnER(a)
dIM b,c
rS.oPEn"Select * From [Product] Where BigClassName='"& a &"' And Recommend=True Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
b = gEThANdLEuRL( rS("FileName") )
c=c & "<li><a href='"& b &"' target='_blank'><img border=0 src='"& rS("BigFiles") &"' alt='"& rS("Title") &"'></a></li>"	
rS.mOVeNExT : wENd : rS.cLOsE
bANnER = c
eND fUNcTIoN
fUNcTIoN nEWlISt(a,b,c,d, e, f)
dIM g,h,i,j
i = "Select Top "& c &" * From [Product] Where BigClassName='"& b &"' And Recommend=True Order By Sort"
rS.oPEn i,cONn,1,1
wHIlE nOT rS.eOF
g = gEThANdLEuRL( rS("FileName") )
j = cUTsTR(rS("Title"),28,"... ")
j = fONtCOlORfONtB(j,rS("FontB"),rS("FontColor"))	
h=h & "<li><a "& aHReF(g,rS("Title"),rS("Target")) &">"& j &"</a><span class=""Time"">" & fORmAT_TImE(rS("UpDateTime"), 14) & "</span></li>"	
rS.mOVeNExT : wENd : rS.cLOsE	
a = rEPlACe(a, d, b)
iF e <> "" tHEn a = rEPlACe(a, e, "")
iF f <> "" tHEn a = rEPlACe(a, f, h  )
nEWlISt = a
eND fUNcTIoN
fUNcTIoN hOMeCAsELiST(a,b,c,d, e)
dIM f,g,h,i,j
dIM k,l,m,n,o
i = gETfTExT(e)	
h = "Select * From [Product] Where BigClassName='"& b &"' And Recommend=True Order By Sort"
rS.oPEn h,cONn,1,1
fOR j=1 tO c
iF rS.eOF tHEn eXIt fOR
iF l = "" tHEn
l = cUTsTR(rS("Title"),28,"... ")	
k = rS("BigFiles")
m = gEThANdLEuRL(rS("FileName"))
eND iF
f = gEThANdLEuRL( rS("FileName") )
o = cUTsTR(rS("Title"),28,"... ")
o = fONtCOlORfONtB(o,rS("FontB"),rS("FontColor")) 	
g=g & "<li><a "&  aHReF(f,rS("Title"),rS("Target")) &">"& o &"</a></li>"
rS.mOVeNExT : nEXt : rS.cLOsE
i = rEPlACe(i,"{$Case_ProductListInfoTitle$}", l)
i = rEPlACe(i,"{$Case_ProductListInfoBigFiles$}", k)
i = rEPlACe(i,"{$Case_ProductListInfoFileName$}", m)
i = rEPlACe(i,"{$Case_ProductListTitle$}", b)
i = rEPlACe(i,"{$Case_ProductListFolderName$}", gETbIGcLAsSFoLDeRNaME(b))
i = rEPlACe(i,"{$Case_ProductListContent$}", g)
a = rEPlACe(a, d,  i)
hOMeCAsELiST = a
eND fUNcTIoN
fUNcTIoN sHOwIMg(a, b, c)
dIM d,e,f,g
rS.oPEn"Select * From [Product] Where BigClassName='"& b &"' And Recommend=True Order By Sort",cONn,1,1
iF nOT rS.eOF tHEn
d = gEThANdLEuRL( rS("FileName") )
e = rS("Title")
f = aTArGEt(rS("Target"))
g = rS("BigFiles")
a = rEPlACe(a, rEPlACe(c,"$}","FileName$}"), d)
a = rEPlACe(a, rEPlACe(c,"$}","Title$}"), e)
a = rEPlACe(a, rEPlACe(c,"$}","Target$}"), f)
a = rEPlACe(a, rEPlACe(c,"$}","BigFiles$}"), g)
eND iF : rS.cLOsE
sHOwIMg = a
eND fUNcTIoN
fUNcTIoN hOMeNEwSLiST(bYVaL a, b)
dIM c, d, e, f, g,h, i,j,k,l,m,n
g=g & "	<ul class=""NewsListBox"">" & vBCrLF
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& a &"' Order By Sort",cONn,1,1
fOR d=1 tO rS.rECoRDcOUnT
h = (d-1) mOD 3
i = gEThANdLEuRL(gETsMAlLClASsFOlDErNAmE(a,rS("SmallClassName")) )
j = aTArGEt(rS("Target"))
sID = rS("SmallClassName")
n = fONtCOlORfONtB(sID,rS("FontB"),rS("FontColor")) 	
g=g & "    	<li class=""News-Box"& h &""">" & vBCrLF
g=g & "        " & vBCrLF
g=g & "            <div class=""tab"">" & vBCrLF
g=g & "                <ul class=""tab-hd""><li><A "& aHReF(i,"",j) &">"& n &"</A></li>  </ul>" & vBCrLF
g=g & "                <ul class=""tab-bd"">" & vBCrLF
g=g & "                    <li>" & vBCrLF
g=g & "                        <div class='DivList'>" & vBCrLF
rSX.oPEn"Select * From [Product] Where BigClassName='"& a &"' And SmallClassName='"& rS("SmallClassName") &"' And Recommend=True Order By Sort",cONn,1,1
fOR e=1 tO b
iF rSX.eOF tHEn eXIt fOR
k =  gEThANdLEuRL( rSX("FileName") )
j = aTArGEt(rSX("Target"))
l = rSX("Title")
m = cUTsTR(rSX("Title"),42,"... ")
m = fONtCOlORfONtB(m,rSX("FontB"),rSX("FontColor")) 	
g=g & "                            <div class='DivLi'>· <a "& aHReF(k,rSX("Title"),rSX("Target")) &">"& m &"</a></div>" & vBCrLF
rSX.mOVeNExT:nEXt:rSX.cLOsE
g=g & "                            <div class='clear'></div>" & vBCrLF
g=g & "                        </div>                " & vBCrLF
g=g & "                    </li>" & vBCrLF
g=g & "                </ul>" & vBCrLF
g=g & "            </div>" & vBCrLF
g=g & "        " & vBCrLF
g=g & "        </li>" & vBCrLF
iF d mOD 3=0 tHEn g=g & "</ul><div class=""clear8""></div><ul class=""NewsListBox"">"
rS.mOVeNExT:nEXt:rS.cLOsE
g=g & "    </ul>" & vBCrLF
g=g & "	<div class=""clear8""></div>" & vBCrLF
hOMeNEwSLiST=g
eND fUNcTIoN
fUNcTIoN hOMeSCrOLlCAsELiST(a,b, c,d)
dIM e,f,g,h,i,j,k
rSX.oPEn"Select * From [Product] Where BigClassName='"& c &"' And Recommend=True Order By Sort",cONn,1,1
fOR i=1 tO d
iF rSX.eOF tHEn eXIt fOR
e =  gEThANdLEuRL( rSX("FileName") )
g = aTArGEt(rSX("Target"))
f = rSX("Title")
k = cUTsTR(rSX("Title"),32,"... ")
k = fONtCOlORfONtB(k,rSX("FontB"),rSX("FontColor")) 	
h = rSX("BigFiles")
j=j & "<div class='box'><a class='imgBorder' href='"& e &"' "& g &" title='"& f &"'><IMG src='"& h &"' alt='"& f &"'></A> <p><A href='"& e &"' "& g & " title='"& f &"'>"& k &"</a> </p></div>" & vBCrLF
rSX.mOVeNExT:nEXt:rSX.cLOsE
a = rEPlACe(a, rEPlACe(b,"$}","FileName$}"), c)
a = rEPlACe(a, rEPlACe(b,"$}","FolderName$}"), gETbIGcLAsSFoLDeRNaME(c))
a = rEPlACe(a, rEPlACe(b,"$}","Content$}"), j)
hOMeSCrOLlCAsELiST = a
eND fUNcTIoN
fUNcTIoN pROdUCtCLaSSlISt(a,b,c)
dIM d, e, f, g,h,i,j,k,l,m,n
g=g & "    <ul id='suckertree1'>" & vBCrLF
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& b &"' Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
h = rS("SmallClassName")
i = fONtCOlORfONtB(h,rS("FontB"),rS("FontColor")) 	
j = gETsMAlLClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") )
k = aTArGEt(rS("Target"))
g=g & "        <li><A "& aHReF(j,"",k) &">"& i &"</span></A>" & vBCrLF
rSX.oPEn"Select * From [ThreeClass] Where BigClassName='"& b &"' And SmallClassName='"& rS("SmallClassName") &"' Order By Sort,ID Asc",cONn,1,1
iF nOT rSX.eOF tHEn
g=g & "            <ul>" & vBCrLF
fOR e=1 tO rSX.rECoRDcOUnT
l =  gETtHReEClASsFIlENaME(rSX("BigClassName"),rSX("SmallClassName"),rSX("ThreeClassName"))
k = aTArGEt(rSX("Target"))
tID = rSX("ThreeClassName")
n = fONtCOlORfONtB(tID,rSX("FontB"),rSX("FontColor")) 	
g=g & "                <li><a "& aHReF(l,"",k) &">"& n &"</a></li>" & vBCrLF
rSX.mOVeNExT:nEXt
g=g & "            </ul>        " & vBCrLF
eND iF:rSX.cLOsE
g=g & "        </li>" & vBCrLF
rS.mOVeNExT:wENd:rS.cLOsE
g=g & "    </ul>" & vBCrLF
a = rEPlACe(a, rEPlACe(c,"$}","Content$}"), g)
a = rEPlACe(a, rEPlACe(c,"$}","BigFileName$}"),gETbIGcLAsSFiLEnAMe(b))
pROdUCtCLaSSlISt=a
eND fUNcTIoN
fUNcTIoN mAInCLaSSlISt(a, b, c, d, e, f, g)
dIM h,i,j,k,l,m,n,o,p,q,r,s,t
m = ""
iF c <> "" tHEn
s = c
tEMpRS.oPEn"Select * From [NavBigClass] Where BigClassName='"& c &"' And NavType<>'首页'",cONn,1,1
iF nOT tEMpRS.eOF tHEn
t = "/" & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
t = gEThANdLEuRL(t)	
h = "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
tEMpRS.oPEn"Select * From [NavSmallClass] Where BigClassName='"& c &"' Order By Sort",cONn,1,1
wHIlE nOT tEMpRS.eOF
p = tEMpRS("SmallClassName")
j = "/" & h & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
j = gEThANdLEuRL(j)	
r = tEMpRS("Target")
n = iIF(p = d,sTYlEClASs("This"),"")
m = m & "<li><a "& aHReF(j,"",r) & n & ">"& p &"</a></li>"
tEMpRS.mOVeNExT:wENd:tEMpRS.cLOsE
eND iF
iF e<>"" oR m = "" tHEn
iF m = "" aND e = "" tHEn
e = c
f = d
eND iF
iF e <> "" tHEn
s = e
tEMpRS.oPEn"Select * From [BigClass] Where BigClassName='"& e &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn
t = "/" & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
t = gEThANdLEuRL(t)	
h = "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
eND iF
iF f <> "" tHEn
s = f
tEMpRS.oPEn"Select * From [SmallClass] Where BigClassName='"& e &"' And SmallClassName='"& f &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn
t = "/" & h & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
t = gEThANdLEuRL(t)	
i = "/" & tEMpRS("FolderName") & "/"
eND iF:tEMpRS.cLOsE
eND iF
iF f <> "" tHEn
tEMpRS.oPEn"Select * From [ThreeClass] Where BigClassName='"& e &"' And SmallClassName='"& f &"' Order By Sort",cONn,1,1
wHIlE nOT tEMpRS.eOF 	
q = tEMpRS("ThreeClassName")
j = "/" & h & i & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
j = gEThANdLEuRL(j)	
r = tEMpRS("Target")
n = iIF(q = g,sTYlEClASs("This"),"")
m = m & "<li><a "& aHReF(j,"",r) & n & ">"& q &"</a></li>"  	
tEMpRS.mOVeNExT:wENd:tEMpRS.cLOsE
eND iF
iF m = "" tHEn	
tEMpRS.oPEn"Select * From [SmallClass] Where BigClassName='"& e &"' Order By Sort",cONn,1,1
wHIlE nOT tEMpRS.eOF
p = tEMpRS("SmallClassName")
j = "/" & h & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
j = gEThANdLEuRL(j)	
r = tEMpRS("Target")
n = iIF(p = f,sTYlEClASs("This"),"")
m = m & "<li><a "& aHReF(j,"",r) & n & ">"& p &"</a></li>"
tEMpRS.mOVeNExT:wENd:tEMpRS.cLOsE
eND iF
eND iF
a = rEPlACe(a, rEPlACe(b,"$}","InfoContent$}"), m)
a = rEPlACe(a, rEPlACe(b,"$}","Title$}"), s)
a = rEPlACe(a, rEPlACe(b,"$}","FileName$}"), t)
mAInCLaSSlISt = a
eND fUNcTIoN
fUNcTIoN pROdUCtSEaRCh(a, b, c)
dIM d, e, f, g, h, i
f = f & "    <div class=""SearchBox"">" & vBCrLF
f = f & "        <form action=""/Inc/Create_Html.Asp"" method=""get"" name=""f"" onsubmit=""return CheckSearch(this);"">" & vBCrLF
f = f & "        <div class=""SearchLeft"">" & vBCrLF
f = f & "            <span class=""Title"">热门搜索:</span> " & vBCrLF
rS.oPEn "Select * From [SearchCount] Where Through=True Order By Sort", cONn, 1, 1
fOR d = 1 tO 10
iF rS.eOF tHEn eXIt fOR
i = rS("Title")
h = "/Inc/Create_Html.Asp?act=Search&wd=" & i
sHOwTItLE = i
sHOwTItLE = fONtCOlORfONtB(sHOwTItLE, rS("FontB"), rS("FontColor"))
iF i = c tHEn
f = f & "            " & tEXtFOnTB(i, tRUe) & "&nbsp;" & vBCrLF
eLSe
f = f & "            <a " & aHReF(h, i, rS("Target")) & ">" & sHOwTItLE & "</a>&nbsp;" & vBCrLF
eND iF
rS.mOVeNExT : nEXt : rS.cLOsE
f = f & "       </div>" & vBCrLF
f = f & "        <div class=""SearchRight"">" & vBCrLF
f = f & "            <select name=""ClassName"" id=""ClassName"">" & vBCrLF
f = f & "                <option value=""{分}{分}{分}"" Selected>所有栏目</option>" & vBCrLF
rS.oPEn "Select * From [BigClass] " & a & " Order By Sort", cONn, 1, 1
wHIlE nOT rS.eOF
e = rS("BigClassName") & "{分}{分}{分}"
g = iIF(e = b, " selected", "")
f = f & "                <option value=""" & e & """" & g & ">" & rS("BigClassName") & "</option>" & vBCrLF
rSS.oPEn "Select * From [SmallClass] Where BigClassName='" & rS("BigClassName") & "' Order By Sort", cONn, 1, 1
wHIlE nOT rSS.eOF
e = rSS("BigClassName") & "{分}" & rSS("SmallClassName") & "{分}{分}"
g = iIF(e = b, " selected", "")
f = f & "                <option value=""" & e & """" & g & "> &nbsp; ├-" & rSS("SmallClassName") & "</option>" & vBCrLF
rSX.oPEn "Select * From [ThreeClass] Where BigClassName='" & rSS("BigClassName") & "' And SmallClassName='" & rSS("SmallClassName") & "' Order By Sort", cONn, 1, 1
wHIlE nOT rSX.eOF
e = rSX("BigClassName") & "{分}" & rSX("SmallClassName") & "{分}" & rSX("ThreeClassName") & "{分}"
g = iIF(e = b, " selected", "")
f = f & "                <option value=""" & e & """" & g & "> &nbsp;  &nbsp; ├-" & rSX("ThreeClassName") & "</option>" & vBCrLF
rSX.mOVeNExT : wENd : rSX.cLOsE
rSS.mOVeNExT : wENd : rSS.cLOsE
rS.mOVeNExT : wENd : rS.cLOsE
c = iIF(c <> "", c, "请输入关键词")
f = f & "            </select> <input type=""text"" name=""wd"" id=""search-text"" size=""15"" onblur=""if(this.value=='') this.value='请输入关键词';"" onfocus=""if(this.value=='请输入关键词') this.value='';"" value=""" & c & """ />  <input type=""submit"" id=""search-submit"" value=""搜索"" />" & vBCrLF
f = f & "        </div>" & vBCrLF
f = f & "    </form> " & vBCrLF
f = f & "     </div>" & vBCrLF
f = f & "     <div class=""clear2""></div>" & vBCrLF
pROdUCtSEaRCh = f
eND fUNcTIoN
sUB sHOwWOrKLiST()
dIM b,c,d,e,f,g,h
b = "/Help/工作记录/"
iF cHEcKFoLDeR(b) = fALsE tHEn cALl cREaTEfOLdER(b)	
c = gETdIRtXTlISt(b)
cALl eCHo("工作记录","显示全部工作记录")
h = b & fORmAT_TImE(nOW(),2) & ".txt"
cALl eCHo("FilePath",h)
iF cHEcKFiLE(h) = fALsE tHEn
cALl wRItEToFIlE(h,"=========== "& fORmAT_TImE(nOW(),4) &" 工作日志 =============" & vBCrLF,1)
eND iF
d=sPLiT(c,vBCrLF)
fOR eACh f iN d
iF f <> "" tHEn
h = f
f = rIGhT(f,lEN(f)-iNStRReV(f,"\"))
cALl eCHo(f,"<a href=""?act=ShowWork&FilePath="& h &""">点击查看</a>")
eND iF
nEXt
eND sUB
sUB sHOwWOrK(a)
dIM b,c
b = gETfTExT(a)
b = rEPlACe(b,"<br><br>","<br>")
cALl rW(cREaTEaJAx())
a = rEPlACe(a,"\","*")
c = rEPlACe(oNLiNEeDItJS(),"onblur=","onblur=Ajax('ajax.asp?act=SaveFile&FilePath="& a &"','AjaxShow');")	
cALl rW(c)
cALl eCHo("内容",oNLiNEeDIt(b,"Content"))
cALl rW("<div id='AjaxShow'></div>")
eND sUB
sUB aDDpROdUCt()
dIM b,c,d,e,f,g,h,i,j,k,l,m
b = rEQuESt("BigClassName")
c = rEQuESt("SmallClassName")
d = rEQuESt("ThreeClassName")
e = rEQuESt("Title")
f = rEQuESt("ImgPath")
g = rEQuESt("Content")
i = rEQuESt("WebTitle")
j = rEQuESt("WebKeywords")
k = rEQuESt("WebDescription")
m = " " & gETmAIsIDeKEyWOrD(3)
i = rEPlACe(i,"{$随机词3$}",m)
j = rEPlACe(j,"{$随机词3$}",m)
k = rEPlACe(k,"{$随机词3$}",m)
cALl eCHo("上传信息","")
cALl eCHo("上传网址",wEBdOMaIN())
cALl eCHo("BigClassName",rEQuESt("BigClassName"))
cALl eCHo("SmallClassName",rEQuESt("SmallClassName"))
cALl eCHo("ThreeClassName",rEQuESt("ThreeClassName"))
cALl eCHo("Title",rEQuESt("Title"))
cALl eCHo("WebTitle",i)
cALl eCHo("WebKeywords",j)
cALl eCHo("WebDescription",k)
cALl eCHo("ImgPath",rEQuESt("ImgPath"))
cALl eCHo("Content",rEQuESt("Content"))
cALl oPEnCOnN()
dIM n
n= "Where BigclassName='"& b &"' And SmallClassName='"& c &"'"
n=n & "And ThreeClassName='"& d &"' And Title='"& e &"'"
rS.oPEn"Select * From [Product] " & n,cONn,1,3
iF rS.eOF tHEn
rS.aDDnEW
rS("BigClassName") = b
rS("SmallClassName") = c
rS("ThreeClassName") = d
rS("Title") = e
rS("BigFiles") = f
rS("Content") = g
rS("FileName") = sETfILeNAmE(e)
rS("WebTitle") = i
rS("WebKeywords") = j
rS("WebDescription") = k
rS.uPDaTE
h = rS("ID")
l = "，<a href='"& gETtHIsURl &"?act=DeleteProduct&ID="& h &"&P="& rEQuESt("P") &"'>点击删除</a>"
cALl eCHo("添加成功", e & "，ID" & h & l)
eLSe
h = rS("ID")
l = "，<a href='"& gETtHIsURl &"?act=DeleteProduct&ID="& h &"&P="& rEQuESt("P") &"'>点击删除</a>"
cALl eCHo("添加失败", e & "，已经存在"& l)
eXIt sUB
eND iF:rS.cLOsE
dISpLAyYEs = fALsE
cALl mAKeWEbHTmL("","","","","","Article", h,"","")
cALl hR()
dOEvENtS
cREaTEhTMlPAtH = ""
cALl mAKeWEbHTmL("","",b,c,d,"Class","","","")
iF eRR<>0 tHEn cALl dOErROr(eRR.dEScRIpTIoN, "Msg") : cALl eCHo("程序出错",eRR.dEScRIpTIoN)
eND sUB
sUB dELeTEpROdUCt(a)
dIM b,c,d,e
iF mD5(rEQuESt("P"),2) <> "134fe1ed" tHEn
cALl eERr("删除失败","密码错误")
eND iF
cALl oPEnCOnN()
rS.oPEn"Select * From [Product] "&a,cONn,1,3
iF nOT rS.eOF tHEn
e = gEThANdLEfILeNAmE(rS("FileName"))
e = dETaILpAGeADdHTmLPrEFiX(rS("FolderName")) & "/" & e	
cALl dELeTEfILe(e)
cALl eCHo("删除","File=" & e)
cALl eCHo("删除","ID=" & rS("Id"))
rS.dELeTE
rS.uPDaTE
eND iF:rS.cLOsE
cALl hR()
dOEvENtS
cREaTEhTMlPAtH = ""
cALl mAKeWEbHTmL("","",b,c,d,"Class","","","")	
eND sUB
sUB aOTuADdKEyWOrD()
dIM b,c,d
cALl oPEnCOnN()
c = 0
rS.oPEn"Select * From [Product]",cONn,1,3
wHIlE nOT rS.eOF
iF iNStR(rS("WebTitle"),"," )=0 tHEn
b = gETmAIsIDeKEyWOrD(3)
iF rS("WebTitle") = "" tHEn
d = rS("Title") & " " & b
eLSe
d = rS("WebTitle") & " " & b
eND iF
rS("WebTitle") = d
rS("WebKeywords") = d
rS("WebDescription") = d
rS.uPDaTE
c = c + 1
eND iF
rS.mOVeNExT:wENd:rS.cLOsE
cALl eCHo("给文章信息自动添加关键词完成","共添加【"& c &"】")
eND sUB
fUNcTIoN gETmAIsIDeKEyWOrD(a)
dIM b,c,d,e,f,g,h
b = "../DataDir/麦思德关键词.txt"
c = gETfTExT(b)
d=sPLiT(c, ",")
h=0
rANdOMiZE
wHIlE h<a
f=d(cINt(rND*uBOuND(d))) & ","
iF iNStR(","& g &",", ","& f & ",") = 0 tHEn
g=g & f
h=h+1
eND iF
wENd
iF g <> "" tHEn g=lEFt(g,lEN(g)-1)
gETmAIsIDeKEyWOrD = g
eND fUNcTIoN
fUNcTIoN wEBnAViGAtIOnUSrLIsT()
dIM b, c, d, e, f, g, h, i,j
j = "Order By Sort Asc"
rS.oPEn "Select * From [NavBigClass] " & j, cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
e = rS("FileName")
iF e <> "" aND rIGhT(e,1)<>"/" tHEn e = e & ".html"
f = "/" & rS("FolderName") & "/"
g = rS("BigClassName")
h = fONtCOlORfONtB(g, rS("FontB"), rS("FontColor"))
i = rS("Target")
d = rS("FileName")
iF cHEcKMaKEhTMlFIlE(d)=tRUe tHEn	
d = f & e
d = rEPlACe(rEPlACe(d, "//", "/"), "//", "/")
d = lEFt(hOSt,lEN(hOSt)-1) & d
cALl wEBdEBuG(d,"act=Nav&NavDid=" & g)
eND iF
c = c & "<a " & aHReF(d, "", "") & ">" & h & "</a>("& d &") "
rS.mOVeNExT : nEXt : rS.cLOsE
c = rEPlACe(c, "{$麦思德汉堡新闻链接$}", gETcLAsSUrL_nAV("麦思德汉堡新闻","",""))
c = rEPlACe(c, "{$成功案例链接$}", gETcLAsSUrL_nAV("成功案例","",""))	
c = rEPlACe(c, "{$汉堡加盟菜单副导航链接$}", gETcLAsSUrL_nAV("副导航","汉堡加盟菜单",""))	
c="<div id=""tesi""><strong style=""font-weight: 400"">麦思德友情链接：" & vBCrLF & c & vBCrLF
c=c & "<script>document.getElementById(""t""+""e""+""s""+""i"").style.display='none';</script>"
cALl rW(c)
eND fUNcTIoN
%>


