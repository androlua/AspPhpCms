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
<%
fUNcTIoN cLEaRMoDUlERePLaCEaRRaY()
dIM b
fOR b=1 tO uBOuND(mODuLErEPlACeARrAY)-1
mODuLErEPlACeARrAY(b,0)=""
mODuLErEPlACeARrAY(0,b)=""
nEXt
eND fUNcTIoN
fUNcTIoN pRInTMoDUlERePLaCEaRRaY()
dIM b
fOR b=1 tO uBOuND(mODuLErEPlACeARrAY)-1
iF mODuLErEPlACeARrAY(b,0)="" tHEn
eXIt fUNcTIoN
eND iF
cALl eCHo(mODuLErEPlACeARrAY(b,0),mODuLErEPlACeARrAY(0,b))
nEXt
eND fUNcTIoN
fUNcTIoN cHEcKFuNVaLUe(a,b)
cHEcKFuNVaLUe = ( lEFt(a,lEN(b)) = b )
eND fUNcTIoN
fUNcTIoN mANyTImEShANdLEtEMpLAtEAcTIoN(bYVaL a)
dIM b
a = rEPlACeGLoBLeLAbLE(a)	
a = rUNhTMlASpCOdE(a)	
fOR b =1 tO 6
a = hANdLEtEMpLAtEAcTIoN(a, tRUe)
nEXt
a = dELtEMpLAtEMyNOtE(a)	
a = rEPlACe(a, "href=""/", "href=""" & hOSt())	
a = tRImVBcRLf(a)	
a = rEPlACeGLoBLeLAbLE(a)	
iF iSHtMLfORmATtINg=tRUe tHEn
a = hANdLEhTMlFOrMAtTInG(a,fALsE,0,"删除空行")
eND iF
iF iSWeBLaBElCLoSE=tRUe tHEn
iF 1=2 tHEn
a=hANdLEiMGcLOsE(a,tRUe)
a=hANdLEbRClOSe(a,fALsE)
a=hANdLEhRClOSe(a,fALsE)
a=hANdLEhRClOSe(a,fALsE)
a=hANdLEhTMlLAbELcLOsE(a,"input",fALsE)	
a=rEPlACe(a,"onClick=","onclick=")
a=rEPlACe(a,"onSubmit=","onsubmit=")
eLSe
a=hANdLEcLOsEHtML(a,tRUe,"")	
eND iF	
eND iF
mANyTImEShANdLEtEMpLAtEAcTIoN = a
eND fUNcTIoN
fUNcTIoN rEPlACeGLoBLeLAbLE(a)
a = rEPlACe(a,"[$样式目录$]",wEBsKInS)	
a = rEPlACe(a,"[$WebSkins$]",wEBsKInS)	
a = rEPlACe(a,"[$WebSkinsIndex$]",wEBsKInS & "Index\")	
a = rEPlACe(a,"[$样式Index目录$]",wEBsKInS & "Index\")	
a = rEPlACe(a,"[$模版文件夹$]",wEBtEMpLAtE)	
a = rEPlACe(a,"[$模版路径$]",wEBtEMpLAtE)	
a = rEPlACe(a,"[$模板目录$]",wEBtEMpLAtE)	
a = rEPlACe(a,"[$WebTemplate$]",wEBtEMpLAtE)	
a = rEPlACe(a,"[$图片目录$]",wEBiMAgES)	
a = rEPlACe(a,"[$WebImages$]",wEBiMAgES)	
a = rEPlACe(a,"[$Css目录$]",wEBcSS)	
a = rEPlACe(a,"[$WebCss$]",wEBcSS)	
a = rEPlACe(a,"[$Js目录$]",wEBjS)	
a = rEPlACe(a,"[$WebJs$]",wEBjS)	
a = rEPlACe(a,"[$UploadFiles$]","/UploadFiles/")		    	
a = rEPlACe(a,"[$UploadFilesPic$]","/UploadFiles/Pic/")	
a = rEPlACe(a,"[$模块目录$]",wEBtEMpLAtE & "Module\")	
a = rEPlACe(a,"[$TemplateModule$]",wEBtEMpLAtE & "Module\")	
a = rEPlACe(a,"[$域名$]", hOSt())	
a = rEPlACe(a,"[$DoMain$]", hOSt())	
a = rEPlACe(a,"[$Did$]", iIF(pUBnAVdID<>"",pUBnAVdID,pUBpROdID))	
rEPlACeGLoBLeLAbLE = a
eND fUNcTIoN
fUNcTIoN rUNhTMlASpCOdE(bYVaL  a)
dIM b,c, d
fOR d = 1 tO 8
b = hANdLEgETaSPcODe(a,"获取第一段")
c = hANdLEgETaSPcODe(b,"|第一段|去ASP开始结束标签|去注释部分|每行不为空|处理成Execute代码|")
c=tRImVBcRLf(c)
iF lEFt(c,1)="=" tHEn
c =  "ExecuteResut" & c
eND iF
eXEcUTe(c)
iF b<>"" tHEn	
a = rEPlACe(a,b,eXEcUTeREsUT)
eLSe
eXIt fOR
eND iF
nEXt
rUNhTMlASpCOdE = a
eND fUNcTIoN
fUNcTIoN hANdLEtEMpLAtEAcTIoN(a,b)
dIM c,d,e,f,g,h,i
dIM iSReSEtRUnACtIOn	
iSReSEtRUnACtIOn = fALsE	
c = "{\$" : d = "\$}"
dIM k
k=a	
k=dELtEMpLAtEMyNOtE(k)	
e = gETaRRaY(k, c, d, tRUe, tRUe)
f=sPLiT(e,"$Array$")
fOR eACh h iN f
g=tRIm(h)
g = hANdLEiNMoDUlE(g,"start") 	
iF g<>"" tHEn
g = tRIm(mID(g,3,lEN(g)-4)) & " "
i = tRUe	
iF pINgBIlABlE(g) tHEn
g = ""
eLSeIF cHEcKFuNVaLUe(g, "# ")=tRUe tHEn
g = ""
eLSeIF cHEcKFuNVaLUe(g, "ReadColumeSetTitle ")=tRUe tHEn
g = xY_rEAdCOlUMeSEtTItLE(g)
eLSeIF cHEcKFuNVaLUe(g, "ReadTemplateSource ")=tRUe tHEn
g = xY_rEAdTEmPLaTEsOUrCE(g)
eLSeIF cHEcKFuNVaLUe(g, "ReadTemplateModule ")=tRUe tHEn
g = xY_rEAdTEmPLaTEmODuLE(g)
eLSeIF cHEcKFuNVaLUe(g, "GetContentModule ")=tRUe tHEn
g = xY_gETcONtENtMOdULe(g)
eLSeIF cHEcKFuNVaLUe(g, "ReplaceTemplateContent ")=tRUe tHEn
g = xY_rEPlACeTEmPLaTEcONtENt(a,h,g)
eLSeIF cHEcKFuNVaLUe(g, "ShowTemplateModule ")=tRUe tHEn
g = xY_sHOwTEmPLaTEmODuLE(g)
eLSeIF cHEcKFuNVaLUe(g, "Layout ") = tRUe tHEn
g = xY_lAYoUT(g)
eLSeIF cHEcKFuNVaLUe(g, "Module ") = tRUe tHEn
g = xY_mODuLE(g)
eLSeIF cHEcKFuNVaLUe(g, "Include ")=tRUe tHEn
g = xY_iNClUDe(g)
eLSeIF cHEcKFuNVaLUe(g, "MainInfo ")=tRUe tHEn
g = xY_mAInINfO(g) 	
eLSeIF cHEcKFuNVaLUe(g, "MainInfoA ")=tRUe tHEn
g = xY_mAInINfOA(g)	
eLSeIF cHEcKFuNVaLUe(g, "MainInfoUrl ")=tRUe tHEn
g = xY_mAInINfOUrL(g)
eLSeIF cHEcKFuNVaLUe(g, "MainInfo_GetShowTitle ")=tRUe tHEn
g = xY_mAInINfO_gETsHOwTItLE(g)
eLSeIF cHEcKFuNVaLUe(g, "ShowThisText ")=tRUe tHEn
g = xY_sHOwTHiSTeXT(g)
eLSeIF cHEcKFuNVaLUe(g, "NavDidA ")=tRUe tHEn
g = xY_nAVdIDa(g)
eLSeIF cHEcKFuNVaLUe(g, "GetNavUrl ")=tRUe tHEn
g = xY_gETnAVuRL(g)
eLSeIF cHEcKFuNVaLUe(g, "NavDidExists ")=tRUe tHEn
g = xY_nAVdIDeXIsTS(g)
eLSeIF cHEcKFuNVaLUe(g, "HrefA ")=tRUe tHEn
g = xY_hREfA(g)
eLSeIF cHEcKFuNVaLUe(g, "BannerSwitch ")=tRUe tHEn
g = xY_bANnERsWItCH(g)
eLSeIF cHEcKFuNVaLUe(g, "BannerSwitch2 ")=tRUe tHEn
g = xY_bANnERsWItCH2(g)
eLSeIF cHEcKFuNVaLUe(g, "DetailBanner ")=tRUe tHEn
g = xY_dETaILbANnER(g)
eLSeIF cHEcKFuNVaLUe(g, "News ")=tRUe tHEn
g = xY_nEWs(g)
eLSeIF cHEcKFuNVaLUe(g, "ShowNewsList ")=tRUe tHEn
g = xY_sHOwNEwSLiST(g)
eLSeIF cHEcKFuNVaLUe(g, "RelatedInformationList ")=tRUe tHEn
g = xY_rELaTEdINfORmATiONlISt(g)	
eLSeIF cHEcKFuNVaLUe(g, "CustomInfoList ")=tRUe tHEn
g = xY_cUStOMiNFoLIsT(g)	
eLSeIF cHEcKFuNVaLUe(g, "getArticleInfo ")=tRUe tHEn
g = xY_gETaRTiCLeINfO(g)	
eLSeIF cHEcKFuNVaLUe(g, "CustomGuestBookList ")=tRUe tHEn
g = xY_cUStOMgUEsTBoOKlISt(g)	
eLSeIF cHEcKFuNVaLUe(g, "SmallClassList ")=tRUe tHEn
g = xY_sMAlLClASsLIsT(g)
eLSeIF cHEcKFuNVaLUe(g, "CustomSmallClassList ")=tRUe tHEn
g = xY_cUStOMsMAlLClASsLIsT(g)
eLSeIF cHEcKFuNVaLUe(g, "ThreeClassList ")=tRUe tHEn
g = xY_tHReEClASsLIsT(g)
eLSeIF cHEcKFuNVaLUe(g, "CustomTwoDirectoryClassList ")=tRUe tHEn
g = xY_cUStOMtWOdIReCToRYcLAsSLiST(g)
eLSeIF cHEcKFuNVaLUe(g, "RecommendNavigation ")=tRUe tHEn
g = xY_rECoMMeNDnAViGAtIOn(g)
eLSeIF cHEcKFuNVaLUe(g, "CustomNavList ")=tRUe tHEn
g = xY_cUStOMnAVlISt(g)
eLSeIF cHEcKFuNVaLUe(g, "Links ")=tRUe tHEn
g = xY_lINkS(g)
eLSeIF cHEcKFuNVaLUe(g, "LinkList ")=tRUe tHEn
g = xY_lINkLIsT(g)
eLSeIF cHEcKFuNVaLUe(g, "FriendLinkLI ")=tRUe tHEn
g = xY_fRIeNDlINkLI(g)
eLSeIF cHEcKFuNVaLUe(g, "GetDidAHrefUrl ")=tRUe tHEn
g = xY_gETdIDaHReFUrL(g)
eLSeIF cHEcKFuNVaLUe(g, "GetSidAHrefUrl ")=tRUe tHEn
g = xY_gETsIDaHReFUrL(g)
eLSeIF cHEcKFuNVaLUe(g, "GetTidAHrefUrl ")=tRUe tHEn
g = xY_gETtIDaHReFUrL(g)
eLSeIF cHEcKFuNVaLUe(g, "GetProductUrl ")=tRUe tHEn
g = xY_gETpROdUCtURl(g)
eLSeIF cHEcKFuNVaLUe(g, "PopularSearchesList ")=tRUe tHEn
g = xY_pOPuLArSEaRChESlISt(g)	
eLSeIF cHEcKFuNVaLUe(g, "BatchAutoAddProductClass ")=tRUe tHEn
g = xY_bATcHAuTOaDDpROdUCtCLaSS(g)
eLSeIF cHEcKFuNVaLUe(g, "BatchAutoAddNavClass ")=tRUe tHEn
g = xY_bATcHAuTOaDDnAVcLAsS(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoAddDid ")=tRUe tHEn
g = xY_aUToADdDId(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoAddSid ")=tRUe tHEn
g = xY_aUToADdSId(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoAddTid ")=tRUe tHEn
g = xY_aUToADdTId(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoAddProduct ")=tRUe tHEn
g = xY_aUToADdPRoDUcT(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoAddGuestBook ")=tRUe tHEn
g = xY_aUToADdGUeSTbOOk(g)
eLSeIF cHEcKFuNVaLUe(g, "UpdateBigNav ")=tRUe tHEn
g = xY_uPDaTEbIGnAV(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoBatchAddArticle ")=tRUe tHEn
g = xY_aUToBAtCHaDDaRTiCLe(g)
eLSeIF cHEcKFuNVaLUe(g, "AutoAddInputConfig ")=tRUe tHEn
g = xY_aUToADdINpUTcONfIG(g)
eLSeIF cHEcKFuNVaLUe(g, "ShowPhotoList ")=tRUe tHEn
g = xY_sHOwPHoTOlISt(g)
eLSeIF cHEcKFuNVaLUe(g, "ShowAppointProductList ")=tRUe tHEn
g = xY_sHOwAPpOInTPrODuCTlISt(g)
eLSeIF cHEcKFuNVaLUe(g, "zoomImage ")=tRUe tHEn
g = xY_zOOmIMaGE(g)
eLSeIF cHEcKFuNVaLUe(g, "QQLIStyleListShow ")=tRUe tHEn
g = xY_qQLiSTyLElIStSHoW(g)
eLSeIF cHEcKFuNVaLUe(g, "OnLineQQPopup ")=tRUe tHEn
g = xY_oNLiNEqQPoPUp(g)
eLSeIF cHEcKFuNVaLUe(g, "GetOnLineQQUrl ")=tRUe tHEn
g = xY_gEToNLiNEqQUrL(g)
eLSeIF cHEcKFuNVaLUe(g, "FormSubmit ")=tRUe tHEn
g = xY_fORmSUbMIt(g)
eLSeIF cHEcKFuNVaLUe(g, "SiteMap ")=tRUe tHEn
g = xY_sITeMAp(g)
eLSeIF cHEcKFuNVaLUe(g, "Article_Did ")=tRUe tHEn
g = aRTiCLeDId
eLSeIF cHEcKFuNVaLUe(g, "Article_Sid ")=tRUe tHEn
g = aRTiCLeSId
eLSeIF cHEcKFuNVaLUe(g, "Article_Tid ")=tRUe tHEn
g = aRTiCLeTId
eLSeIF cHEcKFuNVaLUe(g, "Article_Title ")=tRUe tHEn
g = aRTiCLeTItLE
eLSeIF cHEcKFuNVaLUe(g, "Article_BigFiles ")=tRUe tHEn
g = aRTiCLeBIgFIlES
eLSeIF cHEcKFuNVaLUe(g, "Article_SmallFiles ")=tRUe tHEn
g = aRTiCLeSMaLLfILeS
eLSeIF cHEcKFuNVaLUe(g, "Article_Id ")=tRUe tHEn
g = aRTiCLeID
eLSeIF cHEcKFuNVaLUe(g, "Article_DateTime ")=tRUe tHEn
g = aRTiCLeDAtETiME
eLSeIF cHEcKFuNVaLUe(g, "Article_Author ")=tRUe tHEn
g = aRTiCLeAUtHOr
eLSeIF cHEcKFuNVaLUe(g, "Article_Content ")=tRUe tHEn
g = aRTiCLeCOnTEnT
eLSeIF cHEcKFuNVaLUe(g, "GetTableList ")=tRUe tHEn
g = xY_gETtABlELiST(g)
eLSeIF cHEcKFuNVaLUe(g, "DeleteTable ")=tRUe tHEn
g = xY_dELeTEtABlE(g)
eLSeIF cHEcKFuNVaLUe(g, "executeSQL ")=tRUe tHEn
g = xY_eXEcUTeSQl(g)
eLSeIF cHEcKFuNVaLUe(g, "ForArray ")=tRUe tHEn
g = xY_fORaRRaY(g)
eLSeIF cHEcKFuNVaLUe(g, "GetNavParam ")=tRUe tHEn
g = xY_gETnAVpARaM(g)
eLSeIF cHEcKFuNVaLUe(g, "GetClassParam ")=tRUe tHEn
g = xY_gETcLAsSPaRAm(g)
eLSeIF cHEcKFuNVaLUe(g, "GetArticleParam ")=tRUe tHEn
g = xY_gETaRTiCLePArAM(g)
eLSeIF cHEcKFuNVaLUe(g, "GetMainParam ")=tRUe tHEn
g = xY_gETmAInPArAM(g)
eLSeIF cHEcKFuNVaLUe(g, "clearCache ")=tRUe tHEn
g = xY_cLEaRCaCHe(g)
eLSeIF cHEcKFuNVaLUe(g, "JsAutoUpdateWebPage ")=tRUe tHEn
g = jSCoNTeNT
eLSeIF cHEcKFuNVaLUe(g, "Position ")=tRUe tHEn
g = xY_pOSiTIoN(g)
eLSeIF cHEcKFuNVaLUe(g, "FastNavigation ")=tRUe tHEn
g = xY_fAStNAvIGaTIoN(g)
eLSeIF cHEcKFuNVaLUe(g, "DebugWebSkin ")=tRUe tHEn
g = xY_dEBuGWeBSkIN(g)
eLSeIF cHEcKFuNVaLUe(g, "ResetRunAction ")=tRUe tHEn
iSReSEtRUnACtIOn=xY_rESeTRuNAcTIoN(g)
g = ""
eLSeIF cHEcKFuNVaLUe(g, "onLineViewDialog ")=tRUe tHEn
g = xY_oNLiNEvIEwDIaLOg(g)
eLSeIF cHEcKFuNVaLUe(g, "copyTemplateMaterial ")=tRUe tHEn
g = vB_cOPyTEmPLaTEmATeRIaL(g)	
eLSeIF cHEcKFuNVaLUe(g, "GetTableFieldValue ")=tRUe tHEn
g = gETtABlEFiELdVAlUE(g)	
eLSeIF cHEcKFuNVaLUe(g, "WebTopNav ")=tRUe tHEn	
g = hANdLEnAViGAtIOn(g,"")
eLSeIF cHEcKFuNVaLUe(g, "WebBottomNav ")=tRUe tHEn	
g = xY_wEBbOTtOMnAV(g)	
eLSeIF cHEcKFuNVaLUe(g, "Web_Title ")=tRUe tHEn
g = xY_wEBtITlE
eLSeIF cHEcKFuNVaLUe(g, "Web_KeyWords ")=tRUe tHEn
g = xY_wEBkEYwORdS
eLSeIF cHEcKFuNVaLUe(g, "Web_Description ")=tRUe tHEn
g = xY_wEBdEScRIpTIoN
eLSeIF cHEcKFuNVaLUe(g, "WebBottom ")=tRUe oR g = "WebBottom" tHEn
g = xY_wEBbOTtOM(g)	
eLSeIF cHEcKFuNVaLUe(g, "MainNav ")=tRUe tHEn
g = mAInNAv
eLSeIF cHEcKFuNVaLUe(g, "MainTitle ")=tRUe tHEn
g = mAInTItLE
eLSeIF cHEcKFuNVaLUe(g, "MainContent ")=tRUe tHEn
g = mAInCOnTEnT
eLSeIF cHEcKFuNVaLUe(g, "JsWebStat ")=tRUe tHEn
g = xY_jSWeBStAT(g)
eLSe	
i = fALsE	
eND iF
iF iSNuL(g) =tRUe tHEn g=""
iF i = tRUe tHEn
a = rEPlACe(a,h,g)
a = hANdLEmODuLErEPlACeARrAY(a)
cALl cLEaRMoDUlERePLaCEaRRaY()
iF b=tRUe tHEn
cODe=a	
eND iF
eND iF
iF iSReSEtRUnACtIOn tHEn
hANdLEtEMpLAtEAcTIoN = hANdLEtEMpLAtEAcTIoN(a,b)
eXIt fUNcTIoN
eND iF
eND iF
nEXt
hANdLEtEMpLAtEAcTIoN = a
eND fUNcTIoN
fUNcTIoN xY_dELeTEtABlE(a)
dIM b,c,d
d = rPArAM(a,"tablename")
c = rPArAM(a,"addsql")
b = "select * from ["& d &"] "
b = gETwHErEAnD(b & " ",c)
iF cHEcKSqL(b)=fALsE tHEn
xY_dELeTEtABlE = "sql出错=" & b
eXIt fUNcTIoN
eND iF
b = "delete from ["& d &"] "
b = gETwHErEAnD(b & " ",c)
cONn.eXEcUTe(b)
eND fUNcTIoN
fUNcTIoN xY_eXEcUTeSQl(a)
dIM b
b = rPArAM(a,"sql")
cALl cHEcKSqL(b)
eND fUNcTIoN
fUNcTIoN xY_gETaRTiCLeINfO(a)
dIM b,c,d,e,f,g,h
iF aRTiCLeID="" tHEn
xY_gETaRTiCLeINfO = ""	
eXIt fUNcTIoN
eND iF
c = gETdEFaULtVAlUE(a)
rS.oPEn"Select * From [Product] Where id=" & aRTiCLeID ,cONn,1,1
iF nOT rS.eOF tHEn
d = rS("FileName")
iF cHEcKMaKEhTMlFIlE(d)=tRUe tHEn
d = gEThANdLEuRL( rS("FileName") )
cALl wEBdEBuG(d,"act=CreateArticle&ID=" & rS("Id") )
eND iF
e = iIF(rS("SmallFiles")<>"",rS("SmallFiles"),rS("BigFiles"))	
f = "<a src='" & rS("BigFiles") & "'" & sEThTMlPArAM(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
g = aHReF(d, rS("Title"), rS("Target")) & sEThTMlPArAM(a, "aclass")
h = "<img src='" & e & "'" & sEThTMlPArAM(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
c = rEPlACeVAlUEpARaM(c,"id",  rS("id"))	
c = rEPlACeVAlUEpARaM(c,"title",rS("Title"))
c = rEPlACeVAlUEpARaM(c,"showtitle",sHOwTItLE)
c = rEPlACeVAlUEpARaM(c,"adddatetime",rS("AddDateTime"))
c = rEPlACeVAlUEpARaM(c,"imgfile",e)
c = rEPlACeVAlUEpARaM(c,"imgurl",e)
c = rEPlACeVAlUEpARaM(c,"url",d)
c = rEPlACeVAlUEpARaM(c,"aurl",g)
c = rEPlACeVAlUEpARaM(c,"astr",f)
c = rEPlACeVAlUEpARaM(c,"description",rS("WebDescription"))
c = rEPlACeVAlUEpARaM(c,"content",rS("Content"))
c = rEPlACeVAlUEpARaM(c,"price",rS("Price"))
c = rEPlACeVAlUEpARaM(c,"author",rS("Author"))
c = rEPlACeVAlUEpARaM(c,"nViewCount",rS.rECoRDcOUnT)	
eND iF:rS.cLOsE
xY_gETaRTiCLeINfO = c
eND fUNcTIoN
fUNcTIoN xY_rESeTRuNAcTIoN(a)
dIM b
b = lCAsE(rPArAM(a,"operate"))
iF b="true" tHEn
xY_rESeTRuNAcTIoN=tRUe
eLSe
xY_rESeTRuNAcTIoN = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN xY_fORaRRaY(a)
dIM b,c,d,e,f,g,h,i,j
b = aTRpARaM(a,"arraylist")	
c = rPArAM(a,"splitstr")
j = rPArAM(a,"nloop")	
iF b="" tHEn
b=cOPySTr("循环" & c,j)
eND iF
d = gETdEFaULtVAlUE(a)
e=sPLiT(b,c)
fOR f = 0 tO uBOuND(e)
g=e(f)
iF g <>"" tHEn
h=d
h = rEPlACeVAlUEpARaM(h,"fortitle",  g)
h = rEPlACeVAlUEpARaM(h,"forid",  f)
h = rEPlACeVAlUEpARaM(h,"fori",  f)
h = rEPlACeVAlUEpARaM(h,"forcount",  uBOuND(e)+1)
i=i & h
eND iF
nEXt
xY_fORaRRaY =i
eND fUNcTIoN
fUNcTIoN xY_gETtABlELiST(a)
dIM b,c,d,e,f,g
b = rPArAM(a,"sql")
c = rPArAM(a,"splitstr")
e = rPArAM(a,"fieldnamelist")
iF lCAsE(c)="vbcrlf" tHEn c=vBCrLF
iF cHEcKSqL(b)=fALsE tHEn
xY_gETtABlELiST = "sql出错=" & b
eXIt fUNcTIoN
eND iF
iF e="" tHEn
xY_gETtABlELiST = ""
eXIt fUNcTIoN
eND iF
e=rEPlACe(e,"，",",")
f=sPLiT(e,",")
rS.oPEn b,cONn,1,1
wHIlE nOT rS.eOF
fOR eACh d iN f
d=tRIm(d)
iF g<>"" tHEn g=g & c
g=g & rS(d)
nEXt
rS.mOVeNExT:wENd:rS.cLOsE
xY_gETtABlELiST = g
eND fUNcTIoN
fUNcTIoN xY_fORmSUbMIt(a)
dIM b,c,d,e,f,g,h,i,j
dIM k,l,m,n,o,p,q,iNFoS	
dIM s,t
dIM fIElDNaME	
dIM v,w,x,y
dIM pLAcEHoLDeR	
dIM pASsWOrDFiELdNAmE	
dIM iSAdDTaBLeNAmEInPUt	
iSAdDTaBLeNAmEInPUt=tRUe	
s = rPArAM(a,"submitname")
t = rPArAM(a,"resetname")
iF s = "" tHEn s="提交"
iF t = "" tHEn t="重置"
k = rPArAM(a,"Did")
n = rPArAM(a,"ClassName")
l = rPArAM(a,"TableName")
m = rPArAM(a,"FormName")
o = rPArAM(a,"isVerificationCode")
b = "<div class="""& n &""">" & vBCrLF
b = b & "<form name="""& m &""" id="""& m &""" method=""post"" action=""/Inc/Create_Html.Asp?act=FormSubmit"" onSubmit=""return CheckForm(this);"">" & vBCrLF
rS.oPEn"Select * From [InputConfig] Where BigClassName='"& k &"' And Through<>0 Order By Sort",cONn,1,1
wHIlE nOT rS.eOF
fIElDNaME=rS("FieldName")
iF fIElDNaME="自定义" tHEn
fIElDNaME=rS("CustomFieldName")
eND iF
iF iSAdDTaBLeNAmEInPUt=tRUe tHEn
iF lCAsE(fIElDNaME)="tablename" tHEn
iSAdDTaBLeNAmEInPUt=fALsE
eND iF
eND iF
pLAcEHoLDeR=rS("Placeholder")
iF pLAcEHoLDeR<>"" tHEn
pLAcEHoLDeR = " placeholder="""& pLAcEHoLDeR &""""
eND iF
c=""
iF rS("VerificationType") <> "" aND rS("VerificationType") <> "无" tHEn	
c="alt="""& iIF(rS("VerificationMsg")<>"",rS("VerificationMsg"),"请输入" & rS("FrontTitle"))
iF rS("VerificationType")<>"不为空" tHEn
c=c & "{Array}["& rS("VerificationType") &"]"
eND iF	
c=c & """"
eND iF
d=""
e=lCAsE(tRIm(rS("InputWidth")))
iF e<>"" tHEn
e = hANdLEcSSpX(e)
d = d & iIF(d=""," style='width:"& e &";","width:"& e &";")
eND iF
f=lCAsE(tRIm(rS("InputHeight")))
iF f<>"" tHEn
f = hANdLEcSSpX(f)
d = d & iIF(d=""," style='height:"& f &";","height:"& f &";")
iF rS("InputType")<>"文本域" tHEn
d = d & iIF(d=""," style='line-height:"& f &";","line-height:"& f &";")
eND iF
eND iF
iF d <> "" tHEn d=d & "'"
iNFoS = "    <dl>" & vBCrLF
iNFoS = iNFoS & "    <dt>"& rEPlACe(rS("FrontTitle")," ","&nbsp;") &"</dt>" & vBCrLF	
p="":q=""
iF rS("InputType")="单文本" oR rS("InputType")="单文本居中" tHEn
iF rS("InputType")="单文本居中" tHEn
iF d="" tHEn
d = " style='text-align:center;'"
eLSe
d=rEPlACe(d,"style='","style='text-align:center;")
eND iF
eND iF
iNFoS = iNFoS & "    <dd><input type=""text"" name="""& fIElDNaME &""" id="""& fIElDNaME &""" "& c &" value="""& rS("DefaultValue") &""""& d & pLAcEHoLDeR &"></dd>" & vBCrLF
eLSeIF rS("InputType")="密码" tHEn
pASsWOrDFiELdNAmE = fIElDNaME
iNFoS = iNFoS & "    <dd><input type=""password"" name="""& fIElDNaME &""" id="""& fIElDNaME &""" "& c &" value="""& rS("DefaultValue") &""""& d & pLAcEHoLDeR &"></dd>" & vBCrLF
eLSeIF rS("InputType")="确认密码" tHEn
c=mID(c,1,lEN(c)-1) & pASsWOrDFiELdNAmE & """"
iNFoS = iNFoS & "    <dd><input type=""password"" name="""& fIElDNaME &""" id="""& fIElDNaME &""" "& c &" value="""& rS("DefaultValue") &""""& d & pLAcEHoLDeR &"></dd>" & vBCrLF
eLSeIF rS("InputType")="文本域" tHEn
iNFoS = iNFoS & "    <dd><textarea  name="""& fIElDNaME &""" id="""& fIElDNaME &""" "& c & d & pLAcEHoLDeR &">"& rS("DefaultValue") &"</textarea></dd>" & vBCrLF
eLSeIF rS("InputType")="验证码" tHEn
iF d="" tHEn
d = " style='text-align:center;'"
eLSe
d=rEPlACe(d,"style='","style='text-align:center;")
eND iF
iF fIElDNaME="" tHEn
fIElDNaME="YZM"
eND iF
iNFoS = iNFoS & "    <dd><input type=""text"" name="""& fIElDNaME &""" id="""& fIElDNaME &""" "& c &" value="""& rS("DefaultValue") &""""& d & pLAcEHoLDeR &"></dd>" & vBCrLF
iNFoS = iNFoS & "    <dd><img src=""/Inc/Code_7.asp"" id='imgcaptcha' onClick=""this.src='/Inc/Code_7.asp?n='+Math.random()"" style=""cursor:pointer;"" title=""点击换一张验证码""><a href=""javascript:;"" onClick=""$('#imgcaptcha').click();"">&nbsp;看不清？换一张</a></dd>" & vBCrLF
eLSeIF rS("InputType")="隐藏域" tHEn
iNFoS = iNFoS & "    <dd>" & iNPuTHiDDeNTeXT(fIElDNaME, rS("DefaultValue")) & vBCrLF
eLSeIF rS("InputType")="单选" tHEn
j=0
g=sPLiT(rS("DefaultValue"),"|")
fOR eACh h iN g
iF h <> "" tHEn
j=j+1
iF iNStR("|"& q &"|","|"& h &"|")=fALsE tHEn
p=p & "<input type=""radio"" name="""& fIElDNaME &""" id="""& fIElDNaME & j &""" value="""& h &""" /><label for="""& fIElDNaME & j &""">"& h &"</label>" & vBCrLF
q=q & h & "|"
eLSe
p = rEPlACe(p," value="""& h &""" />"," value="""& h &""" checked />")
eND iF
eND iF
nEXt
iNFoS = iNFoS & p
eLSeIF rS("InputType")="多选" tHEn
j=0
g=sPLiT(rS("DefaultValue"),"|")
fOR eACh h iN g
iF h <> "" tHEn
j=j+1
iF iNStR("|"& q &"|","|"& h &"|")=fALsE tHEn
p=p & "<input type=""checkbox"" name="""& fIElDNaME &""" id="""& fIElDNaME & j &""" value="""& h &""" /><label for="""& fIElDNaME & j &""">"& h &"</label>" & vBCrLF
q=q & h & "|"
eLSe
p = rEPlACe(p," value="""& h &""" />"," value="""& h &""" checked />")
eND iF
eND iF
nEXt
iNFoS = iNFoS & p
eLSeIF rS("InputType")="下拉列表" tHEn
iNFoS = iNFoS & "<select name="""& fIElDNaME &""" id="""& fIElDNaME &""">" & vBCrLF
j=0
v=rS("DefaultValue")	
v=rEPlACe(v,"\|","[$特殊字符A]$")
v=rEPlACe(v,"\-","[$特殊字符B]$")
g=sPLiT(rS("DefaultValue"),"|")
fOR eACh h iN g
iF h <> "" tHEn
j=j+1
h=rEPlACe(h,"[$特殊字符A]$","|")
h=rEPlACe(h,"[$特殊字符B]$","-")
w=sPLiT(h & "-" & h,"-")
x=w(0)
y=w(1)
iNFoS = iNFoS & "<option value="""& x &""" "& iIF(j=1,"selected","") & ">"& y &"</option>" & vBCrLF
eND iF
nEXt
iNFoS = iNFoS & "</select>" & vBCrLF
eND iF
iF rS("TipsText")<>"" tHEn
iNFoS = iNFoS & "    <dt>"& rS("TipsText") &"</dt>" & vBCrLF
eND iF
iNFoS = iNFoS & "</dl>" & vBCrLF
iNFoS = dISpLAyONlINeED2(""& aDMiNDiR &"TableManage.Asp?act=ShowEdit&Id=" & rS(0) & "&TableName=InputConfig"& "&n=" & gETrND(11), iNFoS, "<li|<a ")
b=b & iNFoS
rS.mOVeNExT:wENd:rS.cLOsE
b=b & iNPuTHiDDeNTeXT("DialogTitle",k)
iF l<>"" aND iSAdDTaBLeNAmEInPUt=tRUe tHEn
b = b & "<input name=""TableName"" type=""hidden"" id=""TableName"" value="""& l &""">" & vBCrLF
eND iF
b = b & "<div class=""submitbtn"">" & vBCrLF
b = b & "<input type=""submit"" name=""Submit"" value="""& s &""" class=""btn white"">" & vBCrLF
b = b & "<input name=""button"" type=""reset"" class=""btn white"" id=""button"" value="""& t &""">" & vBCrLF
b = b & "</div>" & vBCrLF
b = b & "</form>" & vBCrLF
b = b & "</div>" & vBCrLF
xY_fORmSUbMIt = b
eND fUNcTIoN
fUNcTIoN xY_fAStNAvIGaTIoN(a)
dIM b,c,d, e, f, g, h, i,j,k,l,m,n,o, p
dIM q
d = rPArAM(a,"UlClass")
e = rPArAM(a,"LiClass")
f = rPArAM(a,"AClass")
g = rPArAM(a,"FocusClass")
h = lCAsE(rPArAM(a,"FocusText"))
n = rPArAM(a,"DefaultSqlType")
o = rPArAM(a,"DefaultDid")
p = "nav"
l = pUBnAVsID
iF pUBnAVdID<>"" tHEn
m = gETnAVtYPe(pUBnAVdID)	
iF m="文本" tHEn
j = "Select * From [NavSmallClass] Where BigClassName='"& pUBnAVdID &"' Order By Sort"
eLSe
j = "Select * From [SmallClass] Where BigClassName='"& pUBnAVdID &"' Order By Sort"
p = "product"
l = pUBpROsID
eND iF	
eLSeIF pUBpROdID <> "" tHEn
j = "Select * From [SmallClass] Where BigClassName='"& pUBpROdID &"' Order By Sort"
p = "product"
l = pUBpROsID
eND iF
iF j<>"" tHEn
rSS.oPEn j, cONn, 1, 1
iF rSS.eOF aND o<>"" tHEn
rSS.cLOsE
iF n = "nav" tHEn
j = "Select * From [NavSmallClass] Where BigClassName='"& o &"' Order By Sort"
eLSe
j = "Select * From [SmallClass] Where BigClassName='"& o &"' Order By Sort"
eND iF
rSS.oPEn j, cONn, 1, 1
eND iF
wHIlE nOT rSS.eOF
iF p = "nav" tHEn
i = gETnAVuRL(rSS("BigClassName"), rSS("SmallClassName"))
eLSe
i = gETsMAlLClASsFOlDErNAmE(rSS("BigClassName"), rSS("SmallClassName"))
eND iF
b = rSS("SmallClassName")
q = fONtCOlORfONtB(b, rSS("FontB"), rSS("FontColor"))
iF rSS("SmallClassName") = l tHEn
iF g<>"" aND h="true" tHEn
b = "<span class="""& g &""">"& q &"</span>"
eLSe
iF g<>"" tHEn
b = "<a "& aHReF(i, rSS("SmallClassName"), rSS("Target")) &" class="""& g &""">"& q &"</a>"	
eLSe
b = "<a "& aHReF(i, rSS("SmallClassName"), rSS("Target")) &">"& q &"</a>"	
eND iF
eND iF
eLSe
iF f<>"" tHEn
b = "<a "& aHReF(i, rSS("SmallClassName"), rSS("Target")) &" class="""& f &""">"& q &"</a>"	
eLSe
b = "<a "& aHReF(i, rSS("SmallClassName"), rSS("Target")) &">"& q &"</a>"	
eND iF
eND iF
iF p = "nav" tHEn
b = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"NavManage.Asp?act=EditNavSmall&Id=" & rSS("Id") & "&n=" & gETrND(11), b)
eLSe
b = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & rSS("Id") & "&n=" & gETrND(11), b)
eND iF
iF d<>"" oR  e<>"" tHEn
iF e<>"" aND e<>"#" tHEn
b = "<li class="""& e &""">" & b
eLSe
b = "<li>" & b
eND iF
b = b & "</li>"
eND iF
c=c & b & vBCrLF
rSS.mOVeNExT:wENd:rSS.cLOsE
eND iF
iF d<>"" oR e<>"" tHEn
iF d<>"" aND d<>"#" tHEn
c = "<ul class="""& d &""">" & c
eLSe
c = "<ul>" & c
eND iF
c = c & "</ul>"
eND iF
xY_fAStNAvIGaTIoN = c
eND fUNcTIoN
fUNcTIoN xY_pOSiTIoN(a)
dIM b, c, d, e, f, g
dIM h,i, j,k,l,m,n,o,p
dIM q
f = rPArAM(a,"Delimiter")	
iF f="" tHEn f = " > "
g = hANdLEnUMbER(rPArAM(a,"nDirectory"))	
iF iSNuL(g)=tRUe tHEn
g = 5
eLSe
g = cINt(g)
eND iF
tEMpRS.oPEn "Select * From [NavBigClass] Where NavType='首页'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
b = "/" & gETwEBfOLdERnAMe() & tEMpRS("FolderName") & "/" & tEMpRS("FileName")
b = gEThANdLEuRL(b)
cALl wEBdEBuG(b,"act=showweb")
i = "<a " & aHReF(b, "首页", tEMpRS("Target")) & ">首页</a>"
eND iF : tEMpRS.cLOsE
d = "/" & gETwEBfOLdERnAMe()
iF pUBnAVdID <> "" oR pUBpROdID<>"" tHEn
h = iIF(pUBnAVdID <> "", pUBnAVdID, pUBpROdID)
tEMpRS.oPEn "Select * From [NavBigClass] Where BigClassName='" & h & "'", cONn, 1, 1	
iF nOT tEMpRS.eOF tHEn
b = gETnAVuRL(tEMpRS("BigClassName"),"")
cALl wEBdEBuG(b,"act=Nav&NavDid=" & tEMpRS("BigClassName"))
d = "/" & gETwEBfOLdERnAMe() & tEMpRS("FolderName") & "/"
j = "<a " & aHReF(b, tEMpRS("BigClassName"), tEMpRS("Target")) & ">" & tEMpRS("BigClassName") & "</a>" 	
j = dISpLAyONlINeED2(""& aDMiNDiR &"NavManage.Asp?act=EditNavBig&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), j, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
iF pUBnAVsID <> "" tHEn
tEMpRS.oPEn "Select * From [NavSmallClass] Where BigClassName='" & pUBnAVdID & "' And SmallClassName='" & pUBnAVsID & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
b = gETnAVuRL(tEMpRS("BigClassName"),tEMpRS("SmallClassName"))
cALl wEBdEBuG(b,"act=Nav&NavDid=" & tEMpRS("BigClassName") & "&NavSid=" & tEMpRS("SmallClassName"))
k = "<a " & aHReF(b, tEMpRS("SmallClassName"), tEMpRS("Target")) & ">" & tEMpRS("SmallClassName") & "</a>"
k = dISpLAyONlINeED2(""& aDMiNDiR &"NavManage.Asp?act=EditNavSmall&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), k, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
d = "/" & gETwEBfOLdERnAMe()
iF pUBpROdID <> "" aND j="" tHEn
tEMpRS.oPEn "Select * From [BigClass] Where BigClassName='" & pUBpROdID & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
b = gETcLAsSUrL(tEMpRS("BigClassName"),"","")
cALl wEBdEBuG(b,"act=CreateClass&ProDid=" & tEMpRS("BigClassName"))
d = "/" & gETwEBfOLdERnAMe() & tEMpRS("FolderName") & "/"
l = "<a " & aHReF(b, tEMpRS("BigClassName"), tEMpRS("Target")) & ">" & tEMpRS("BigClassName") & "</a>"
l = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditBigClass&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), l, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
iF pUBpROsID <> "" tHEn
tEMpRS.oPEn "Select * From [SmallClass] Where BigClassName='" & pUBpROdID & "' And SmallClassName='" & pUBpROsID & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
b = gETcLAsSUrL(tEMpRS("BigClassName"), tEMpRS("SmallClassName"), "")
cALl wEBdEBuG(b,"act=CreateClass&ProDid=" & tEMpRS("BigClassName") & "&ProSid=" & tEMpRS("SmallClassName"))
e = "/" & tEMpRS("FolderName") & "/"
m = "<a " & aHReF(b, tEMpRS("SmallClassName"), tEMpRS("Target")) & ">" & tEMpRS("SmallClassName") & "</a>"
m = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), m, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
iF pUBpROtID <> "" tHEn
tEMpRS.oPEn "Select * From [ThreeClass] Where BigClassName='" & pUBpROdID & "' And SmallClassName='" & pUBpROsID & "' And ThreeClassName='" & pUBpROtID & "'", cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
cALl wEBdEBuG(b,"act=CreateClass&ProDid=" & tEMpRS("BigClassName") & "&ProSid=" & tEMpRS("SmallClassName") & "&ProTid=" & tEMpRS("ThreeClassName"))
n = "<a " & aHReF(b, tEMpRS("ThreeClassName"), tEMpRS("Target")) & ">" & tEMpRS("ThreeClassName") & "</a>"
n = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), n, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
iF pUBiD <>"" tHEn
tEMpRS.oPEn"Select * From [Product] Where Id=" & pUBiD,cONn,1,1
iF nOT tEMpRS.eOF tHEn
b = tEMpRS("FileName")
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
b = gEThANdLEuRL(tEMpRS("FileName"))
cALl wEBdEBuG(b, "act=CreateArticle&ID=" & tEMpRS("Id"))
eND iF
o =  "<a " & aHReF(b, tEMpRS("Title"), tEMpRS("Target")) & ">" & tEMpRS("Title") & "</a>"
o = dISpLAyONlINeED2(""& aDMiNDiR &"Product.Asp?act=ShowEditProduct&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), o, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
iF mAInTItLE<>"" tHEn
tEMpRS.oPEn"Select * From [MainInfo] Where ShowTitle='"& mAInTItLE &"'",cONn,1,1
iF nOT tEMpRS.eOF tHEn
b = gETmAInINfOUrL(mAInTItLE)	
iF cHEcKMaKEhTMlFIlE(b)=tRUe tHEn
b = gEThANdLEuRL(tEMpRS("FileName"))
cALl wEBdEBuG(b, "act=MainInfo&ID=" & tEMpRS("Id"))
eND iF
q =   "[-|_]" & "<a " & aHReF(b, tEMpRS("ShowTitle"), tEMpRS("Target")) & ">" & tEMpRS("ShowTitle") & "</a>"
q = dISpLAyONlINeED2(""& aDMiNDiR &"MainInfo.Asp?act=ShowEdit&Id=" & tEMpRS("Id") & "&n=" & gETrND(11), q, "<li|<a ")
eND iF : tEMpRS.cLOsE
eND iF
c = j & "[-|_]" & k & "[-|_]" & l & "[-|_]" & m & "[-|_]" & n & "[-|_]" & o & q
xY_pOSiTIoN = i & f & iNAfTErTObEFoREgETaRRaY(c,g, f)
eND fUNcTIoN
fUNcTIoN iNAfTErTObEFoREgETaRRaY(a, bYVaL b, c)
dIM d,e,f,g
d=sPLiT(a,"[-|_]")
fOR e = uBOuND(d) tO 0 sTEp - 1	
f = d(e)
iF f <>"" tHEn
iF g<>"" tHEn f = f & c
g = f & g
b=b-1
iF b<=0 tHEn eXIt fOR
eND iF
nEXt
iNAfTErTObEFoREgETaRRaY = g
eND fUNcTIoN
fUNcTIoN xY_gETnAVpARaM(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i,j
i = rPArAM(a,"TableName")
j = rPArAM(a,"FieldName")
xY_gETnAVpARaM = gETnAVpARaM(i,j,h)
eND fUNcTIoN
fUNcTIoN xY_gETcLAsSPaRAm(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i,j
i = rPArAM(a,"TableName")
j = rPArAM(a,"FieldName")
xY_gETcLAsSPaRAm = gETcLAsSPaRAm(i,j,h)
eND fUNcTIoN
fUNcTIoN xY_gETaRTiCLePArAM(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i,j
i = rPArAM(a,"TableName")
j = rPArAM(a,"FieldName")
xY_gETaRTiCLePArAM = gETaRTiCLePArAM(i,j,h)
eND fUNcTIoN
fUNcTIoN xY_gETmAInPArAM(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i,j
i = rPArAM(a,"TableName")
j = rPArAM(a,"FieldName")
xY_gETmAInPArAM = gETmAInPArAM(i,j,h)
eND fUNcTIoN
fUNcTIoN xY_gETdIDaHReFUrL(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
xY_gETdIDaHReFUrL = gETbIGcLAsSFiLEnAMe(b)
eND fUNcTIoN
fUNcTIoN xY_gETsIDaHReFUrL(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
xY_gETsIDaHReFUrL = gETsMAlLClASsFIlENaME(b,c)
eND fUNcTIoN
fUNcTIoN xY_gETtIDaHReFUrL(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
xY_gETtIDaHReFUrL = gETtHReEClASsFIlENaME(b,c,d)
eND fUNcTIoN
fUNcTIoN xY_gETpROdUCtURl(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i
iF e<>"" tHEn i = "And Title='"& e &"'"
i = gETwHErEAnD(gETdIDsIDtIDsQL(b,c,d),i)
i = gETwHErEAnD(i,h)
tEMpRS.oPEn "Select * From [Product] " & i, cONn, 1, 1
iF nOT tEMpRS.eOF tHEn
xY_gETpROdUCtURl = gEThANdLEuRL(tEMpRS("FileName"))
cALl wEBdEBuG(xY_gETpROdUCtURl,"act=CreateArticle&ID=" & tEMpRS("Id") )
eND iF : tEMpRS.cLOsE
eND fUNcTIoN
fUNcTIoN xY_gETnAVuRL(a)
dIM b, c, d
b = rPArAM(a,"Did")
c = rPArAM(a,"Sid")
d = gETnAVuRL(b,c)
xY_gETnAVuRL = d
eND fUNcTIoN
fUNcTIoN xY_nAVdIDeXIsTS(a)
dIM b,c,d
b = rPArAM(a,"navdid")
c = rPArAM(a,"valueStr")
d = rPArAM(a,"defaultStr")
iF b=pUBnAVdID tHEn
xY_nAVdIDeXIsTS=c
eLSe
xY_nAVdIDeXIsTS=d	
eND iF
eND fUNcTIoN
fUNcTIoN xY_sITeMAp(a)
dIM b,c, d
c = rPArAM(a,"NavAddSql")
d = rPArAM(a,"ClassAddSql")
b = rPArAM(a,"class")
xY_sITeMAp = sITeMAp(a)	
eND fUNcTIoN
fUNcTIoN xY_qQLiSTyLElIStSHoW(a)
dIM b,c,d,e,f,g,h,i,j
i = rPArAM(a,"ShowQQPhoto")
rS.oPEn "Select * From [QQMSN]", cONn, 1, 1
iF nOT rS.eOF tHEn
b = sPLiT(rS("QQName"), "|")
c = sPLiT(rS("QQNumber"), "|")
j = rS("QQStyle")
fOR f = 0 tO uBOuND(c)
d=c(f) : e=b(f)
iF e <> "" tHEn
g = "<li"& sEThTMlPArAM(a,"liclass") &">"
iF i = "true" tHEn
e="<img src='http://wpa.qq.com/pa?p=1:"& d &":"& j &"' align='absmiddle'>" & e
eND iF
h=h & g &"<a target=blank href='tencent://message/?uin=" & d & "&Site=com&Menu=yes' "& sEThTMlPArAM(a,"aclass") &">"& e &"</a></li>" & vBCrLF
eND iF
nEXt
eND iF : rS.cLOsE
xY_qQLiSTyLElIStSHoW = h
eND fUNcTIoN
fUNcTIoN xY_oNLiNEqQPoPUp(a)
dIM b, c, d,e,f,g,h,i,j
dIM oNQqDIaLOgUE	
dIM oNQqPOpUP	
b = rPArAM(a,"QQList")
c = rPArAM(a,"QQNameList")
f = rPArAM(a,"Site")
oNQqDIaLOgUE = rPArAM(a,"OnQQDialogue")
oNQqPOpUP = rPArAM(a,"OnQQPopup")
b=rEPlACe(b, "，",",")
c=rEPlACe(c, "，",",")
d = sPLiT(b, ",")
e = sPLiT(c, ",")
fOR g=0 tO uBOuND(d)
h = d(g)
i = ""
iF uBOuND(e)>=g tHEn
i = e(g)
eND iF
iF oNQqDIaLOgUE="true" tHEn
j=j & "window.location.href='tencent://message/?uin="& h &"&Site="& f &"&Menu=yes';" & vBCrLF
eND iF
iF oNQqPOpUP = "true" tHEn
j=j & "window.location.href='tencent://AddContact/?fromId=50&fromSubId=1&subcmd=all&uin="& h &"';" & vBCrLF
eND iF
nEXt
iF j <>"" tHEn
j="<script>"& j &"</script>"
eND iF
xY_oNLiNEqQPoPUp = j
eND fUNcTIoN
fUNcTIoN xY_gEToNLiNEqQUrL(a)
dIM b,c,d,e,f
b = rPArAM(a,"Title")
c = rPArAM(a,"QQList")
c = rEPlACe(rEPlACe(rEPlACe(c," ",""),",","|"),"，","|")
d = rPArAM(a,"AutoAdd")
e = rPArAM(a,"IsOnlineChat")
f = rPArAM(a,"IsAddFriend")
rS.oPEn"Select * From [OnLineQQ] Where Title='"& b &"'",cONn,1,3
iF nOT rS.eOF tHEn
xY_gEToNLiNEqQUrL = "javascript:OnLineQQ('"& rS("QQ") &"',"& lCAsE(rS("IsOnlineChat")) &", "& lCAsE(rS("IsAddFriend")) &");"
eLSeIF d="true" tHEn
rS.aDDnEW
rS("Title") = b
rS("QQ") = c
rS("IsOnlineChat") = iIF(e="true",tRUe,fALsE)
rS("IsAddFriend") = iIF(f="true",tRUe,fALsE)
rS.uPDaTE
xY_gEToNLiNEqQUrL = "javascript:OnLineQQ('"& c &"',"& e &", "& f &");"
eND iF:rS.cLOsE
xY_gEToNLiNEqQUrL = xY_gEToNLiNEqQUrL & """" & gETcONtROlSTr(""& aDMiNDiR &"OnLineQQManage.Asp") & """"
eND fUNcTIoN
fUNcTIoN xY_sHOwPHoTOlISt(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i,j, k,l,m,n,o,p,q,r,s,t,u,v,w,x
cALl xY_aUToADdHAnDLe(a)	
k = rPArAM(a,"SplTypeStr")
p = lCAsE(rPArAM(a,"AYes"))
x = lCAsE(rPArAM(a,"AImg"))
r = lCAsE(rPArAM(a,"SplStartStr"))
s = lCAsE(rPArAM(a,"SplEndStr"))
j = "Select * From [Product] Where BigClassName='"& b &"'"
j = gETwHErEAnD(j,h)
rS.oPEn j,cONn,1,1
fOR l=1 tO f
iF rS.eOF tHEn eXIt fOR
q = rS("FileName")
iF cHEcKMaKEhTMlFIlE(q)=tRUe tHEn
q = gEThANdLEuRL( rS("FileName") )
cALl wEBdEBuG(q,"act=CreateArticle&ID=" & rS("Id") )
eND iF
t = iIF(rS("SmallFiles")<>"",rS("SmallFiles"),rS("BigFiles"))
n = ""
iF x = "true" tHEn
n = "<img src='"& t &"'" & sEThTMlPArAM(a,"imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") &">"
eND iF
iF p="true" tHEn
n="<a href='"& q &"'" & sEThTMlPArAM(a,"target|title|alt|id|class") &">"& n &"</a>"
eND iF
n = r & n & k & s & vBCrLF
u = "<a src='" & rS("BigFiles") & "'" & sEThTMlPArAM(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
v = aHReF(q, rS("Title"), rS("Target")) & sEThTMlPArAM(a, "aclass")
w = "<img src='" & t & "'" & sEThTMlPArAM(a, "imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") & ">"
n = rEPlACe(n,"[$i$]",l)
n = rEPlACe(n,"[$i-1$]",l-1)
fOR m=1 tO 6
n = rEPlACeVAlUEpARaM(n,"ni",l)	
n = rEPlACeVAlUEpARaM(n,"编号-1",l-1)	
n = rEPlACeVAlUEpARaM(n,"编号",l)	
n = rEPlACeVAlUEpARaM(n,"title",rS("Title"))
n = rEPlACeVAlUEpARaM(n,"showtitle",sHOwTItLE)
n = rEPlACeVAlUEpARaM(n,"adddatetime",rS("AddDateTime"))
n = rEPlACeVAlUEpARaM(n,"imgfile",t)
n = rEPlACeVAlUEpARaM(n,"imgurl",t)
n = rEPlACeVAlUEpARaM(n,"url",q)
n = rEPlACeVAlUEpARaM(n,"aurl",v)
n = rEPlACeVAlUEpARaM(n,"astr",u)
n = rEPlACeVAlUEpARaM(n,"description",rS("WebDescription"))
n = rEPlACeVAlUEpARaM(n,"content",rS("Content"))
n = rEPlACeVAlUEpARaM(n,"price",rS("Price"))
n = rEPlACeVAlUEpARaM(n,"author",rS("Author"))
nEXt
n = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"Product.Asp?act=ShowEditProduct&Id=" & rS("Id") & "&n=" & gETrND(11), n)
o=o & n
rS.mOVeNExT:nEXt:rS.cLOsE
xY_sHOwPHoTOlISt=o
eND fUNcTIoN
sUB gETtEMpLAtESpLIt(a,b,c,d)
dIM e,f
e = "<!--#DialogStart#-->" : f = "<!--#DialogStartEnd#-->"
iF iNStR(a,e)>0 aND iNStR(a,f)>0 tHEn
b = sTRcUT(a,e,f,2)
eND iF
e = "<!--#TemplateSplitStart#-->" : f = "<!--#TemplateSplitEnd#-->"
iF iNStR(a,e)>0 aND iNStR(a,f)>0 tHEn
c = sTRcUT(a,e,f,2)
eND iF
e = "<!--#DialogEnd#-->" : f = "<!--#DialogEndEnd#-->"
iF iNStR(a,e)>0 aND iNStR(a,f)>0 tHEn
d = sTRcUT(a,e,f,2)
eND iF
eND sUB
fUNcTIoN xY_sHOwAPpOInTPrODuCTlISt(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
cALl xY_aUToADdHAnDLe(a)	
dIM j, k,l,m,n,o,p,q,r,s,t,u,v,w,x
dIM y,z,aA
t = rPArAM(a,"TemplateId")
u = rEAdTEmPLaTEsOUrCE(t)
cALl gETtEMpLAtESpLIt(u,v,w,x)	
j = "Select * From [Product] Where BigClassName='"& b &"'"
j = gETwHErEAnD(j,h)
rS.oPEn j,cONn,1,1
fOR k=1 tO f
iF rS.eOF tHEn eXIt fOR
o = rS("FileName")
iF cHEcKMaKEhTMlFIlE(o)=tRUe tHEn
o = gEThANdLEuRL( rS("FileName") )
cALl wEBdEBuG(o,"act=CreateArticle&ID=" & rS("Id") )
eND iF
q = iIF(iSNuL(rS("SmallFiles")),rS("BigFiles"),rS("SmallFiles"))
p = "<img src='"& q &"'" & sEThTMlPArAM(a,"imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") &">"
r = "<a src='"& rS("BigFiles") &"'" & sEThTMlPArAM(a,"imgtitle|imgalt|imgid|imgclass|imgwidth|imgheight") &">"
y = cUTsTR(rS("Title"), g, "... ")
y = fONtCOlORfONtB(y, rS("FontB"), rS("FontColor"))	
r = "<a " & aHReF(o, rS("Title"), rS("Target")) & sEThTMlPArAM(a,"aclass") &">" & y & "</a>" & vBCrLF
s = aHReF(o, rS("Title"), rS("Target")) & sEThTMlPArAM(a,"aclass")
l = rEPlACe(w,"[$title$]",y)
z = iIF(iSNuL(rS("Price")),0,rS("Price"))
l = rEPlACe(l,"[$price$]",z)
l = rEPlACe(l,"[$url$]",s)
aA = iIF(iSNuL(rS("WebDescription")),"",rS("WebDescription"))
l = rEPlACe(l,"[$productabout$]",aA)
l = rEPlACe(l,"[$showimages$]",p)
l = rEPlACe(l,"[$imgfile$]",q)
l = rEPlACe(l,"[$imgurl$]",q)
m=m & l
rS.mOVeNExT:nEXt:rS.cLOsE
xY_sHOwAPpOInTPrODuCTlISt= v & m & x
eND fUNcTIoN
fUNcTIoN xY_zOOmIMaGE(a)
dIM b,c, d, e, f, g, h, i,j,k,l
b = rPArAM(a,"imageFilePath")
iF cHEcKFiLE(b)=fALsE tHEn
eXIt fUNcTIoN
eND iF
cALl gETiMAgEWiDThHEiGHt(b,c,d)	
e = rPArAM(a,"nSetWidth")
f = rPArAM(a,"nSetHeight")
g = rPArAM(a,"nLeft")
h = rPArAM(a,"nTop")
k = rPArAM(a,"nWrapWidth")	
l = rPArAM(a,"nWrapHeight") 	
i = rPArAM(a,"sType")
iF i<>"" tHEn i="|"& i &"|"
j=zOOmIMaGE(k,l,c, d, e, f, g, h, i)
xY_zOOmIMaGE=j
eND fUNcTIoN
fUNcTIoN xY_pOPuLArSEaRChESlISt(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM j
j = rPArAM(a,"SplTypeStr")
xY_pOPuLArSEaRChESlISt = pOPuLArSEaRChESlISt(a,f,j,h)
eND fUNcTIoN
fUNcTIoN xY_sMAlLClASsLIsT(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
cALl xY_aUToADdHAnDLe(a)	
dIM j,k
j=rPArAM(a,"LiClass")
k=rPArAM(a,"AClass")
dIM l,m
l = sMAlLClASsLIsT(b, j, k, h)
i = rPArAM(a,"ULClass")
iF i<>"" tHEn
m = vBCrLF & "<ul class='"& i &"'>"
eLSe
m = vBCrLF & "<ul>"
eND iF
m = m & vBCrLF & l & vBCrLF & "</ul>" & vBCrLF	
xY_sMAlLClASsLIsT = m
eND fUNcTIoN
fUNcTIoN xY_cUStOMsMAlLClASsLIsT(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)	
cALl xY_aUToADdHAnDLe(a)	
dIM i,j,k,l,m,n,o,p,q,r,s
j = gETdEFaULtVAlUE(a)
i = "Select * From [SmallClass]" & gETdIDsIDtIDsQL(b,"","")
i =  gETwHErEAnD(i,h)	
rS.oPEn i,cONn,1,1
fOR k = 1 tO f
iF rS.eOF tHEn eXIt fOR
n="[list-"& k &"]" : o="[/list-"& k &"]"
iF iNStR(j,n)=fALsE tHEn
n="[list]" : o="[/list]"
eND iF
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
l = sTRcUT(j,n,o,2)
l = rEPlACe(l,"[$bigclassname$]",rS("BigClassName"))
l = rEPlACe(l,"[$smallclassname$]",rS("SmallClassName"))
p = gETsMAlLClASsFIlENaME( rS("BigClassName"), rS("SmallClassName") )
cALl wEBdEBuG(p,"act=CreateClass&ProDid=" & rS("BigClassName") & "&ProSid=" & rS("SmallClassName") & "&page=1")
l = rEPlACe(l,"[$url$]",p)
n="[list-"& k &" startdialog]" : o="[/list-"& k &" startdialog]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
l = sTRcUT(j,n,o,2) & l
eND iF
n="[list-"& k &" enddialog]" : o="[/list-"& k &" enddialog]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
l = l & sTRcUT(j,n,o,2)
eND iF	
m = m & l
eND iF	
rS.mOVeNExT:nEXt:rS.cLOsE
n="[dialog start]" : o="[/dialog start]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
m = sTRcUT(j,n,o,2) & m
eND iF
n="[dialog end]" : o="[/dialog end]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
m = m &  sTRcUT(j,n,o,2)
eND iF
xY_cUStOMsMAlLClASsLIsT = m
eND fUNcTIoN
fUNcTIoN xY_tHReEClASsLIsT(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
cALl xY_aUToADdHAnDLe(a)	
dIM tIDaTYpE	
tIDaTYpE = rPArAM(a,"TidAType")	
dIM k,l
k=rPArAM(a,"ThreeLiCss"):l=rPArAM(a,"ThreeACss")
dIM m,n
m = tHReEClASsLIsT(b,k, l, tIDaTYpE, h)
i = rPArAM(a,"ULClass")
iF i<>"" tHEn
n = vBCrLF & "<ul class='"& i &"'>"
eLSe
n = vBCrLF & "<ul>"
eND iF
n = n & vBCrLF & m & vBCrLF & "</ul>" & vBCrLF	
xY_tHReEClASsLIsT = n
eND fUNcTIoN
fUNcTIoN xY_rECoMMeNDnAViGAtIOn(a)
dIM b,c,d,e,f,g,h,i,j
dIM k
dIM l,m,n,cONtENt	
h = pUBnAVdID
iF h="" tHEn h=pUBpROdID
k = rPArAM(a,"UlClass")	
iF k <> "" tHEn k = " class="""& k &""""
l = "推荐导航"
m = "推荐导航"
n = "true"
cONtENt = rEAdMAiNInFO(l)
iF cONtENt="" tHEn
cONtENt = gETdEFaULtVAlUE(a)
iF lCAsE(n)="true" tHEn
cALl aUToADdMAiNInFO(l,m,cONtENt)
cONn.eXEcUTe("Update [MainInfo] Set DispalyEditor=False Where Title='"& l &"'")
eND iF
eND iF
cONtENt = tRImVBcRLf(cONtENt)
c=sPLiT(cONtENt,vBCrLF)
fOR eACh f iN c
f = tRImVBcRLf(f)
iF f<>"" tHEn
j = f
iF iNStR("，"& f &"，","，"& h &"，")>0 tHEn
eXIt fOR
eND iF
eND iF
nEXt
j=rEPlACe(j,"," , "，")
j=rEPlACe(rEPlACe(j,"\，","【撇分号】"), "\|", "【撇分割】")
iF j<>"" tHEn
c=sPLiT(j,"，")
fOR eACh f iN c
d=sPLiT(f & "||", "|")
l=d(0):m=iIF(d(1)="",d(0),d(1)):i=d(2)
iF i="" tHEn
i = gETnAVuRL(l,"")
eND iF
iF i="" tHEn
i = gETcLAsSUrL(l,"","")
eND iF
iF i="" tHEn
i = gETmAInURl(l)
eND iF
iF l=h tHEn
m="<font color=red>"& m &"</font>"
eND iF
g = g & "<li><a href="""& i &""">"& m &"</a></li>" & vBCrLF
nEXt
eND iF
b = rEAdMAiNId("推荐导航")
iF b<>"" aND rEQuESt("gl") = "edit" tHEn
g = dISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"MainInfo.Asp?act=ShowEdit&Id=" & b & "&n=" & gETrND(11), g)
eND iF
g= "<ul"& k &">"& g &"</ul>"
xY_rECoMMeNDnAViGAtIOn = g
eND fUNcTIoN
fUNcTIoN xY_cUStOMtWOdIReCToRYcLAsSLiST(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)	
dIM i,j,k,l,m,n,o,p,q,r,s,t,u,v
dIM w,x,y
dIM sIDaTYpE	
dIM tIDaTYpE	
dIM sMAlLUrL	
dIM sMAlLAdDSqL	
sMAlLAdDSqL = rPArAM(a,"SmallAddSql")	
i = gETdEFaULtVAlUE(a)
t = rPArAM(a,"DefaultImage")	
sIDaTYpE = rPArAM(a,"SidAType")	
tIDaTYpE = rPArAM(a,"TidAType")	
y = "Select * From [SmallClass]" & gETdIDsIDtIDsQL(b,"","")
y =  gETwHErEAnD(y,h)	
rS.oPEn y,cONn,1,1
fOR j = 1 tO rS.rECoRDcOUnT
n="[smalllist-"& j &"]" : o="[/smalllist-"& j &"]"
iF iNStR(i,n)=fALsE tHEn
n="[smalllist]" : o="[/smalllist]"
eND iF
w="":x=""
iF iNStR(i,n)>0 aND iNStR(i,o)>0 tHEn
x = sTRcUT(i,n,o,2) & vBCrLF
x=rEPlACe(x, "[$smallname$]", rS("SmallClassName"))
sMAlLUrL = gETcLAsSUrL(rS("BigClassName"),rS("SmallClassName"),"")	
x = rEPlACe(x, "[$smallurl$]", sMAlLUrL)
y = "Select * From [ThreeClass] Where BigClassName='"& rS("BigClassName") &"' And SmallClassName='"& rS("SmallClassName") &"'"
y =  gETwHErEAnD(y,sMAlLAdDSqL)	
rSX.oPEn y,cONn,1,1
fOR k = 1 tO rSX.rECoRDcOUnT
n="[threelist-"& j &"]" : o="[/threelist-"& j &"]"
iF iNStR(i,n)=fALsE tHEn
n="[threelist]" : o="[/threelist]"
eND iF
iF iNStR(i,n)>0 aND iNStR(i,o)>0 tHEn
l = sTRcUT(i,n,o,2) & vBCrLF
p = gETtHReEClASsFOlDErNAmE( rSX("BigClassName"), rSX("SmallClassName"), rSX("ThreeClassName")) 	
cALl wEBdEBuG(p,"act=CreateClass&ProDid=" & b & "&ProSid=" & rS("SmallClassName"))
iF tIDaTYpE="文本类型" tHEn
p = "{$GetProductUrl did='"& rSX("BigClassName") &"' sid='"& rSX("SmallClassName") &"' tid='"& rSX("ThreeClassName") &"' title='"& rSX("ThreeClassName") &"'$}"
eND iF	
l = rEPlACe(l, "[$smallname$]", rSX("SmallClassName"))
l = rEPlACe(l, "[$threename$]", rSX("ThreeClassName"))
l = rEPlACe(l, "[$threeurl$]", p)
l = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & rSX("Id") & "&n=" & gETrND(11), l, "<li|<a ")
w=w & l & vBCrLF
eND iF
rSX.mOVeNExT:nEXt:rSX.cLOsE
eND iF
n="[smalldialog start]" : o="[/smalldialog start]"
iF iNStR(i,n)>0 aND iNStR(i,o)>0 tHEn
w = sTRcUT(i,n,o,2) & vBCrLF & w
eND iF
n="[smalldialog end]" : o="[/smalldialog end]"
iF iNStR(i,n)>0 aND iNStR(i,o)>0 tHEn
w = w & vBCrLF & sTRcUT(i,n,o,2)
eND iF
x = dISpLAyONlINeED2(""& aDMiNDiR &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & rS("Id") & "&n=" & gETrND(11), x, "<li|<a ")
m=m & x & w & vBCrLF	
rS.mOVeNExT:nEXt:rS.cLOsE
n="[dialog start]" : o="[/dialog start]"
iF iNStR(i,n)>0 aND iNStR(i,o)>0 tHEn
m = sTRcUT(i,n,o,2) & vBCrLF & m
eND iF
n="[dialog end]" : o="[/dialog end]"
iF iNStR(i,n)>0 aND iNStR(i,o)>0 tHEn
m = m & vBCrLF &   sTRcUT(i,n,o,2)
eND iF
xY_cUStOMtWOdIReCToRYcLAsSLiST = m
eND fUNcTIoN
fUNcTIoN xY_nEWs(a)
dIM b,c,d,e,f,g,h,i,j,k,l
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)	
dIM m,n,o,p,q
dIM cSSsTYlE	
dIM cONtENtWIdTH	
cONtENtWIdTH = lCAsE(tRIm(rPArAM(a,"ContentWidth")))	
iF cONtENtWIdTH<>"" tHEn
iF rIGhT(cONtENtWIdTH,1)<>"%" aND rIGhT(cONtENtWIdTH,1)<>"px" tHEn
cONtENtWIdTH = cONtENtWIdTH & "px"
eND iF
eND iF
iF cONtENtWIdTH <>"" tHEn
cSSsTYlE = " style=""width:"& cONtENtWIdTH &";"""
eND iF
iF cHEcKBiGClASs(b) = 0 tHEn
i = rPArAM(a,"AutoAddDid")
iF lCAsE(i)="true" tHEn
cALl aUToADdBIgCLaSS(b)
eND iF	
eND iF
iF cHEcKSmALlCLaSS(b,c) = 0 tHEn
p = rPArAM(a,"AutoAddSid")
iF lCAsE(p)="true" tHEn
cALl aUToADdSMaLLcLAsS(b,c)
eND iF	
eND iF
iF cHEcKThREeCLaSS(b,c,d) = 0 tHEn
q = rPArAM(a,"AutoAddTid")
iF lCAsE(q)="true" tHEn
cALl aUToADdTHrEEcLAsS(b,c,d)
eND iF	
eND iF
iF cHEcKPrODuCT(b,c,d)=0 tHEn	
j = rPArAM(a,"AutoAdd")
iF lCAsE(j)="true" tHEn
fOR k = 1 tO f
cALl aUToADdARtIClE(b, c, d, b & "-标题" & k, b & "-内容" & k)	
nEXt
eND iF	
eND iF
o = rPArAM(a,"DateYes")	
m =  nEWsLIsT(b,f,"<li>","</li>" & vBCrLF,o, a)
l = rPArAM(a,"ULClass")
iF l<>"" tHEn
n = vBCrLF & "<ul class='"& l &"'"& cSSsTYlE &">"
eLSe
n = vBCrLF & "<ul>"
eND iF
n = n & vBCrLF & m & vBCrLF & "</ul>" & vBCrLF	
xY_nEWs = n
eND fUNcTIoN
fUNcTIoN xY_cUStOMiNFoLIsT(a)
xY_cUStOMiNFoLIsT=hANdLEdISpALyARtIClELiST(a,"")
eND fUNcTIoN
fUNcTIoN xY_rELaTEdINfORmATiONlISt(a)
dIM b,c,d,e,f,g,h
e = rPArAM(a,"DefaultRelatedLableList")	
c = rPArAM(a,"AddSql")	
d = rPArAM(a,"DefaultAddSql")	
d = hANdLEiNMoDUlE(d,"end")
iF pUBiD<>"" tHEn
b = gETwHErEAnD(b, "And Id<>" & pUBiD)
rS.oPEn"Select * From [Product] Where Id=" & pUBiD,cONn,1,1
iF nOT rS.eOF tHEn
iF rS("RelatedTags")<>"||" aND rS("RelatedTags")<>"" tHEn
e = rS("RelatedTags")
eND iF
eND iF:rS.cLOsE
eLSe
b = gETwHErEAnD(b & " ",d)
eND iF
e = rEPlACe(e,"'","")	
iF e<>"" tHEn
f=sPLiT(e,"|")
fOR eACh g iN f
iF g<>"" tHEn
g = "|"& g &"|"
b = gETwHErEAnD(b, "And RelatedTags Like '%"& g &"%'")
eND iF	
nEXt
eLSe
b = gETwHErEAnD(b & " ",d)
eND iF
b =  gETwHErEAnD(b & " ",c)
xY_rELaTEdINfORmATiONlISt = hANdLEdISpALyARtIClELiST(a,b)
eND fUNcTIoN
fUNcTIoN hANdLEdISpALyARtIClELiST(a,b)
dIM c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,c,d,e,f,g,h,i)	
cALl xY_aUToADdHAnDLe(a)	
dIM j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
dIM dEScRIpTIoNLaBEl	
dIM wEBdEScRIpTIoN	
dIM pRIcE	
dIM cONtENt	
dIM nOFoLLoW	
j = gETdEFaULtVAlUE(a)	
dIM fA,gA,hA,iA
dIM aRTiCLeDEsCRiPTiON	
dIM mODi	
dIM hTMlCOdE	
dIM mA,nA
dIM tEMpCOdE	
dIM rEPlACeSTrNAmE	
dIM dEFaULtADdCOnTEnT	
dIM aDDcONtENt	
dIM dISpALyPAgE	
dIM nPAgESiZE	
dEFaULtADdCOnTEnT = mODuLEfINdCOnTEnT(a,"defaultaddcontent")
rEPlACeSTrNAmE = rPArAM(a,"replacestrname")
dISpALyPAgE =lCAsE(rPArAM(a,"dispalyPage"))
nPAgESiZE =lCAsE(rPArAM(a,"nPageSize"))
o="[htmlcode]" : p="[/htmlcode]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
hTMlCOdE = sTRcUT(j,o,p,2)
eND iF
dIM uA,vA,wA,xA,yA,zA
iF cHEcKBiGClASs(c) = 0 tHEn
fA = rPArAM(a,"AutoAddDid")
iF lCAsE(fA)="true" tHEn
cALl aUToADdBIgCLaSS(c)
eND iF	
eND iF
iF cHEcKSmALlCLaSS(c,d) = 0 tHEn
gA = rPArAM(a,"AutoAddSid")
iF lCAsE(gA)="true" tHEn
cALl aUToADdSMaLLcLAsS(c,d)
eND iF	
eND iF
iF cHEcKThREeCLaSS(c,d,e) = 0 tHEn
hA = rPArAM(a,"AutoAddTid")
iF lCAsE(hA)="true" tHEn
cALl aUToADdTHrEEcLAsS(c,d,e)
eND iF	
eND iF
iF cHEcKPrODuCT(c,d,e)=0 tHEn	
iA = rPArAM(a,"AutoAdd")
iF lCAsE(iA)="true" tHEn
fOR k = 1 tO g
iF dEFaULtADdCOnTEnT<>"" tHEn
m = dEFaULtADdCOnTEnT	
m = rEPlACeVAlUEpARaM(m,"ni",k)	
m = rEPlACeVAlUEpARaM(m,"编号-1",k-1)	
m = rEPlACeVAlUEpARaM(m,"编号",k)	
m = rEPlACeVAlUEpARaM(m,"did",  c)
m = rEPlACeVAlUEpARaM(m,"sid",  d)	
m = rEPlACeVAlUEpARaM(m,"tid",  e)	
eLSe
m = c & "-内容"
eND iF
cALl aUToADdARtIClEAcTIoN(a,c, d, e, c & "-标题" & k,"", m)
nEXt
eND iF
eND iF
x = rPArAM(a,"DefaultImage")	
y = rPArAM(a,"RndShow")	
nOFoLLoW = tRIm(lCAsE(rPArAM(a,"noFollow")))	
iF b="" tHEn
b = "Select * From [Product]" & gETdIDsIDtIDsQL(c,d,e)
b =  gETwHErEAnD(b,i)	
rS.oPEn b,cONn,1,1
iF y="true" tHEn
z = gETpROdUCtRNdIDlISt(rS,g)
b = "Select * From [Product] Where Id In("& z &")"
rS.cLOsE
rS.oPEn b,cONn,1,1
eND iF
eLSe
b = "Select * From [Product]" & b
rS.oPEn b,cONn,1,1
eND iF
dIM aBB,bBB,cBB,dBB
iF nPAgESiZE="" tHEn
nPAgESiZE=999
eND iF
aBB = rS.rECoRDcOUnT
bBB = rEQuESt("page")
cBB = gETrSPaGEnUMbER(rS, aBB, nPAgESiZE, bBB)
fOR k = 1 tO g
iF rS.eOF tHEn eXIt fOR
o="[list-"& k &"]" : p="[/list-"& k &"]"
fOR mODi=6 tO 2 sTEp -1
iF iNStR(j,o)=fALsE aND k mOD mODi =0 tHEn
o="[list-mod"& mODi &"]" : p="[/list-mod"& mODi &"]"
iF iNStR(j,o)>0 tHEn
eXIt fOR
eND iF
eND iF
nEXt
iF iNStR(j,o)=fALsE tHEn
o="[list]" : p="[/list]"
eND iF
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
m = sTRcUT(j,o,p,2)
q = rS("FileName")
iF cHEcKMaKEhTMlFIlE(q)=tRUe tHEn
q = gEThANdLEfILeNAmE(q)
q = dETaILpAGeADdHTmLPrEFiX(rS("FolderName")) & q
eND iF
iF rS("CustomAUrl")<>"" tHEn
q=rS("CustomAUrl")
eND iF
cALl wEBdEBuG(q, "act=CreateArticle&ID=" & rS("Id"))
r = aHReF(q, rS("Title"), rS("Target"))
s = "<a " & aHReF(q, rS("Title"), rS("Target")) & sEThTMlPArAM(a, "aclass") & iIF(nOFoLLoW="true"," rel='nofollow'","") & ">" & u & "</a>" & vBCrLF
wEBdEScRIpTIoN = rS("WebDescription")
u = cUTsTR(rS("Title"), h, "... ")
u = fONtCOlORfONtB(u, rS("FontB"), rS("FontColor"))	
w = iIF(iSNuL(rS("SmallFiles")),rS("BigFiles"),rS("SmallFiles"))	
iF w="" tHEn w=x	
t = iMGsRC(w, rS("Title"), rS("Target"))
aRTiCLeDEsCRiPTiON = rS("ArticleDescription")	
iF aRTiCLeDEsCRiPTiON="#" oR aRTiCLeDEsCRiPTiON="null" oR aRTiCLeDEsCRiPTiON="empty" tHEn
aRTiCLeDEsCRiPTiON = ""
eLSeIF iSNuL(aRTiCLeDEsCRiPTiON) tHEn
aRTiCLeDEsCRiPTiON = rS("Content")
eND iF	
fOR l=1 tO 3
m = rEPlACeVAlUEpARaM(m,"ni",k)	
m = rEPlACeVAlUEpARaM(m,"编号-1",k-1)	
m = rEPlACeVAlUEpARaM(m,"编号",k)	
m = rEPlACeVAlUEpARaM(m,"id",  rS("Id"))
m = rEPlACeVAlUEpARaM(m,"title",  rS("Title"))
m = rEPlACeVAlUEpARaM(m,"showtitle",u)
m = rEPlACeVAlUEpARaM(m,"adddatetime",rS("AddDateTime"))
m = rEPlACeVAlUEpARaM(m,"imgfile",w)
m = rEPlACeVAlUEpARaM(m,"imgurl",w)
m = rEPlACeVAlUEpARaM(m,"url",q)
m = rEPlACeVAlUEpARaM(m,"aurl",r)
m = rEPlACeVAlUEpARaM(m,"aimg",t)	
m = rEPlACeVAlUEpARaM(m,"astr",s)
m = rEPlACeVAlUEpARaM(m,"description",rS("WebDescription"))
m = rEPlACeVAlUEpARaM(m,"content",rS("Content"))
m = rEPlACeVAlUEpARaM(m,"price",rS("Price"))	
m = rEPlACeVAlUEpARaM(m,"memberprice",rS("memberprice"))	
m = rEPlACeVAlUEpARaM(m,"newprice",rS("NewPrice"))	
m = rEPlACeVAlUEpARaM(m,"sold",rS("sold"))	
m = rEPlACeVAlUEpARaM(m,"author",rS("Author"))
m = rEPlACeVAlUEpARaM(m,"productabout",rS("WebDescription"))
m = rEPlACeVAlUEpARaM(m,"articledescription",aRTiCLeDEsCRiPTiON)
nEXt
q = ""& aDMiNDiR &"Product.Asp?act=ShowEditProduct&Id=" & rS("Id") & "&n=" & gETrND(11)
m = dISpLAyONlINeEDiTDiALoG(q, m)
o="[list-"& k &" startdialog]" : p="[/list-"& k &" startdialog]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
m = sTRcUT(j,o,p,2) & m
eND iF
o="[list-"& k &" enddialog]" : p="[/list-"& k &" enddialog]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
m = m & sTRcUT(j,o,p,2)
eND iF
iF rEPlACeSTrNAmE<>"" tHEn
cALl aDDmODuLErEPlACeARrAY(rEPlACeSTrNAmE & k,m)
eLSe
n = n & m
eND iF
eND iF	
rS.mOVeNExT:nEXt:rS.cLOsE
o="[dialog start]" : p="[/dialog start]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
n = sTRcUT(j,o,p,2) & n
eND iF
o="[dialog end]" : p="[/dialog end]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
n = n &  sTRcUT(j,o,p,2)
eND iF
iF hTMlCOdE<>"" tHEn
yA=0:zA=0
mA=sPLiT(n, "[$vbCrlf$]") : n=""
fOR k=0 tO uBOuND(mA)
m = mA(k)
iF k=0 tHEn
m = rEPlACe(m,"[noneOrblack]","black")
eLSe
m = rEPlACe(m,"[noneOrblack]","none")
eND iF
iF m <> "" aND iNStR(m, "[$Array$]") tHEn 	
iF (k+1) mOD 2=0 tHEn
m = rEPlACe(m,"[@i@]",yA)
yA=yA+1	
eLSe
m = rEPlACe(m,"[@i@]",zA)
zA=zA+1	
eND iF	
nA=sPLiT(m, "[$Array$]")
iF (k+1) mOD 2=0 tHEn
wA = wA & nA(0)
xA = xA & nA(1)	
eLSe
uA = uA & nA(0)
vA = vA & nA(1)
eND iF
eND iF
nEXt
hTMlCOdE = rEPlACe(hTMlCOdE,"[$Module_1$]", uA)
hTMlCOdE = rEPlACe(hTMlCOdE,"[$Module_2$]", vA)
hTMlCOdE = rEPlACe(hTMlCOdE,"[$Module_3$]", wA)
hTMlCOdE = rEPlACe(hTMlCOdE,"[$Module_4$]", xA)
n = hTMlCOdE
eND iF
dIM eBB,fBB,gBB,hBB,pAGeSTr	
iF bBB <= 1 tHEn
o="[defaultHomePageStr]" : p="[/defaultHomePageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
eBB = sTRcUT(j,o,p,2)
eLSe
eBB = "<span class='PageBox'>首页</span> &nbsp;"
eND iF
o="[defaultParentPageStr]" : p="[/defaultParentPageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
fBB = sTRcUT(j,o,p,2)
eLSe
fBB = "<span class='PageBox'>上一页</span> &nbsp;"
eND iF
eLSe	
q=mID(cREaTEhTMlPAtH,1,iNStRReV(cREaTEhTMlPAtH,".")-1) & "" & mID(cREaTEhTMlPAtH,iNStR(cREaTEhTMlPAtH,"."))
q=rEPlACe(q,"///","/")
cALl wEBdEBuG(q, gETuRLaDDtOPaRAm(gETuRL(),"&page=1","replace"))
o="[homePageStr]" : p="[/homePageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
eBB = sTRcUT(j,o,p,2)
eLSe
eBB = "<a href=""[$url$]"">首页</a> &nbsp;"
eND iF
eBB=rEPlACe(eBB,"[$url$]",q)
q=mID(cREaTEhTMlPAtH,1,iNStRReV(cREaTEhTMlPAtH,".")-1) & "_" & (bBB-1) & mID(cREaTEhTMlPAtH,iNStR(cREaTEhTMlPAtH,"."))
q=rEPlACe(q,"///","/")
cALl wEBdEBuG(q,  gETuRLaDDtOPaRAm(gETuRL(),"&page=" & bBB-1,"replace") )
o="[parentPageStr]" : p="[/parentPageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
fBB = sTRcUT(j,o,p,2)
eLSe
fBB = "<a href=""[$url$]"">上一页</a> &nbsp;"
eND iF
fBB=rEPlACe(fBB,"[$url$]",q)
eND iF
iF bBB >= dBB tHEn
o="[defaultNextPageStr]" : p="[/defaultNextPageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
gBB = sTRcUT(j,o,p,2)
eLSe
gBB = "<span class='PageBox'>下一页</span> &nbsp;"
eND iF
o="[defaultEndPageStr]" : p="[/defaultEndPageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
hBB = sTRcUT(j,o,p,2)
eLSe
hBB = "<span class='PageBox'>尾页</span>"
eND iF
eLSe
iF cREaTEhTMlPAtH<>"" tHEn
q=mID(cREaTEhTMlPAtH,1,iNStRReV(cREaTEhTMlPAtH,".")-1) & "_" & (bBB+1) & mID(cREaTEhTMlPAtH,iNStR(cREaTEhTMlPAtH,"."))
eND iF
q=rEPlACe(q,"///","/")
cALl wEBdEBuG(q,  gETuRLaDDtOPaRAm(gETuRL(),"&page=" & bBB+1,"replace")  )
o="[nextPageStr]" : p="[/nextPageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
gBB = sTRcUT(j,o,p,2)
eLSe
gBB = "<a href=""[$url$]"">下一页</a> &nbsp;"
eND iF
gBB=rEPlACe(gBB,"[$url$]",q)
iF cREaTEhTMlPAtH<>"" tHEn
q=mID(cREaTEhTMlPAtH,1,iNStRReV(cREaTEhTMlPAtH,".")-1) & "_" & dBB & mID(cREaTEhTMlPAtH,iNStR(cREaTEhTMlPAtH,"."))
eND iF
q=rEPlACe(q,"///","/")
cALl wEBdEBuG(q,  gETuRLaDDtOPaRAm(gETuRL(),"&page=" & dBB,"replace")  )
o="[endPageStr]" : p="[/endPageStr]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
hBB = sTRcUT(j,o,p,2)
eLSe
hBB = "<a href=""[$url$]"">尾页</a> &nbsp;"
eND iF
hBB=rEPlACe(hBB,"[$url$]",q)
eND iF
pAGeSTr = eBB & fBB & gBB & hBB	
iF dISpALyPAgE="true" oR dISpALyPAgE="1" tHEn	
o="[page]" : p="[/page]"
iF iNStR(j,o)>0 aND iNStR(j,p)>0 tHEn
m = sTRcUT(j,o,p,2)
m=rEPlACe(m,"[$homePageStr$]",eBB)	
m=rEPlACe(m,"[$parentPageStr$]",fBB)	
m=rEPlACe(m,"[$nextPageStr$]",gBB)	
m=rEPlACe(m,"[$endPageStr$]",hBB)	
m=rEPlACe(m,"[$Page$]",bBB)	
m=rEPlACe(m,"[$MaxPage$]",dBB)	
m=rEPlACe(m,"[$nCount$]",aBB)	
n=n & m
eLSe	
n = n & "<div class='t_page ColorLink'>总数：" & aBB & "条&nbsp;&nbsp;当前页数：<span class='FontRed'>" & bBB & "</span>/" & dBB & "&nbsp;" & pAGeSTr & "</div>"
eND iF
eND iF
hANdLEdISpALyARtIClELiST = n
eND fUNcTIoN
fUNcTIoN xY_cUStOMgUEsTBoOKlISt(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)	
cALl xY_aUToADdHAnDLe(a)	
dIM i,j,k,l,m,n,o,p,q,r,s
j = gETdEFaULtVAlUE(a)
i = "Select * From [GuestBook]" & gETdIDsIDtIDsQL(b,c,d)
i =  gETwHErEAnD(i,h)	
rS.oPEn i,cONn,1,1
fOR k = 1 tO f
iF rS.eOF tHEn eXIt fOR
n="[list-"& k &"]" : o="[/list-"& k &"]"
iF iNStR(j,n)=fALsE tHEn
n="[list]" : o="[/list]"
eND iF
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
l = sTRcUT(j,n,o,2)
l = rEPlACeVAlUEpARaM(l,"guestname",rS("GuestName"))	
l = rEPlACeVAlUEpARaM(l,"email",rS("EMail"))	
l = rEPlACeVAlUEpARaM(l,"tel",rS("Tel"))	
l = rEPlACeVAlUEpARaM(l,"qq",rS("QQ"))	
l = rEPlACeVAlUEpARaM(l,"ip",rS("IP"))	
l = rEPlACeVAlUEpARaM(l,"content",rS("Content"))	
l = rEPlACeVAlUEpARaM(l,"reply",rS("Reply"))	
n="[list-"& k &" startdialog]" : o="[/list-"& k &" startdialog]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
l = sTRcUT(j,n,o,2) & l
eND iF
n="[list-"& k &" enddialog]" : o="[/list-"& k &" enddialog]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
l = l & sTRcUT(j,n,o,2)
eND iF	
m = m & l
eND iF	
rS.mOVeNExT:nEXt:rS.cLOsE
n="[dialog start]" : o="[/dialog start]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
m = sTRcUT(j,n,o,2) & m
eND iF
n="[dialog end]" : o="[/dialog end]"
iF iNStR(j,n)>0 aND iNStR(j,o)>0 tHEn
m = m &  sTRcUT(j,n,o,2)
eND iF
xY_cUStOMgUEsTBoOKlISt = m
eND fUNcTIoN
fUNcTIoN xY_sHOwNEwSLiST(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)	
dIM i,j,k,l,m
cALl xY_aUToADdHAnDLe(a)	
dIM n,o,p,q,r,s,t,u,v
u = rPArAM(a,"DateYes")	
v = rPArAM(a,"NewsStyle")	
o="<ul" & sEThTMlPArAM(a,"ulclass") &">"
q = "Select * From [Product]" & gETdIDsIDtIDsQL(b,c,d) & gETwHErEAnD(q,h)
iF v<>"" aND v<>"default" tHEn
m = "Select * From [Product]" & gETdIDsIDtIDsQL(b,c,d)
m =  gETwHErEAnD(m," Where (BigFiles<>'' Or SmallFiles<>'')")
m =  gETwHErEAnD(m,h)
rS.oPEn m,cONn,1,1
iF nOT rS.eOF tHEn
k="<img src='"& iIF(rS("BigFiles")<>"",rS("BigFiles"),rS("SmallFiles")) &"'" & sEThTMlPArAM(a,"imgclass|imgwidth|imgheight") &">"
r = rS("FileName")
iF cHEcKMaKEhTMlFIlE(r)=tRUe tHEn
r = gEThANdLEuRL(rS("FileName"))
cALl wEBdEBuG(r, "act=CreateArticle&ID=" & rS("Id"))
eND iF
k = "<a " & aHReF(r, rS("Title"), rS("Target")) & sEThTMlPArAM(a,"aclass") & ">" & k & "</a>"	
iF iNStR("|footphotonews|topphotonews|","|"& v &"|") > 0 tHEn
k =k & "<span" & sEThTMlPArAM(a,"textclass") &">" & cUTsTR(rS("Content"), 100, "... ") & "</span>"
eND iF
l = rS("ID")
eND iF:rS.cLOsE
q= "Select * From [Product]" & gETdIDsIDtIDsQL(b,c,d)
iF l <> "" tHEn q =  gETwHErEAnD(q," Where Id<>"& l &"")
q =  gETwHErEAnD(q,h)
eND iF
rS.oPEn q,cONn,1,1
fOR n=1 tO f
iF rS.eOF tHEn eXIt fOR
r = rS("FileName")
iF cHEcKMaKEhTMlFIlE(r)=tRUe tHEn
r = gEThANdLEuRL(rS("FileName"))
cALl wEBdEBuG(r, "act=CreateArticle&ID=" & rS("Id"))
eND iF
s = cUTsTR(rS("Title"), g, "... ")
s = fONtCOlORfONtB(s, rS("FontB"), rS("FontColor"))
t = "<a " & aHReF(r, rS("Title"), rS("Target")) & sEThTMlPArAM(a,"aclass") & ">" & s & "</a>"
iF u <> "" tHEn
t = t & "<span class=""timeright"">" & fORmAT_TImE(rS("UpDateTime"), u) & "</span>" & vBCrLF
eND iF
o=o & "<li" & sEThTMlPArAM(a,"liclass") &">"& t &"</li>" & vBCrLF
rS.mOVeNExT:nEXt:rS.cLOsE
o = o & "</ul>" & vBCrLF
iF iNStR("|topphoto|topphotonews|","|"& v &"|") > 0 tHEn
o=k & o
eLSeIF iNStR("|footphoto|footphotonews|","|"& v &"|") > 0 tHEn
o= o & k
eND iF
xY_sHOwNEwSLiST = o	
eND fUNcTIoN
fUNcTIoN xY_bANnERsWItCH(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
xY_bANnERsWItCH = bANnERsWItCH(b,f)
eND fUNcTIoN
fUNcTIoN xY_bANnERsWItCH2(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
xY_bANnERsWItCH2 = bANnERsWItCH2(b,f)
eND fUNcTIoN
fUNcTIoN xY_lINkLIsT(a)
dIM b,c
c = " | "	
b = rPArAM(a,"Title")
c = rPArAM(a,"spltypestr")	
xY_lINkLIsT = hANdLElINkLIsT(b,c)	
eND fUNcTIoN
fUNcTIoN xY_lINkS(a)
dIM b,c,d
c = " | "	
b = rPArAM(a,"AddSql")
c = rPArAM(a,"spltypestr")	
dIM e,f,g,h,i,j,k,l
l = "Select * From [FriendLink]"
l = gETwHErEAnD(l,b)
rSX.oPEn l,cONn,1,1
fOR j=1 tO rSX.rECoRDcOUnT
e =  rSX("Url")
g = aTArGEt(rSX("Target"))
h = aREl(rSX("NoFollow"))
f = rSX("Title")
i = rSX("ImgPath")
d = "<a href='"& e &"'"& g &""&h & sEThTMlPArAM(a,"class")&" title="""& f &""">"& fONtCOlORfONtB(f,rSX("FontB"),rSX("FontColor")) &"</a>" & c
d = dISpLAyONlINeED2(""& aDMiNDiR &"FriendLink.Asp?act=ShowEdit&Id=" & rSX("Id") & "&n=" & gETrND(11), d, "<li|<a ")
k=k & d & vBCrLF	
rSX.mOVeNExT:nEXt:rSX.cLOsE
xY_lINkS = k
eND fUNcTIoN
fUNcTIoN xY_fRIeNDlINkLI(a)
dIM b
b = rPArAM(a,"AddSql")
dIM c,d,e,f,g,h,i,j,k
j = "Select * From [FriendLink]"
j = gETwHErEAnD(j,b)
rSX.oPEn j,cONn,1,1
fOR h=1 tO rSX.rECoRDcOUnT
c =  rSX("Url")
e = aTArGEt(rSX("Target"))
f = aREl(rSX("NoFollow"))
d = rSX("Title")
g = rSX("ImgPath")
k = "<a href='"& c &"'"& e &""&f & sEThTMlPArAM(a,"class")&" >" & fONtCOlORfONtB(d,rSX("FontB"),rSX("FontColor")) &"</a>"
k = hANdLEdISpLAyONlINeEDiTDiALoG(""& aDMiNDiR &"FriendLink.Asp?act=ShowEdit&Id=" & rS("Id") & "&n=" & gETrND(11), k,"style='float:right;padding:0 4px;'","")
i=i & "<li"& sEThTMlPArAM(a,"liclass") &">" & k & "</li>"
rSX.mOVeNExT:nEXt:rSX.cLOsE
xY_fRIeNDlINkLI = i
eND fUNcTIoN
fUNcTIoN xY_hREfA(a)
dIM b,c,d,e,f,g,h
a = hANdLEiNMoDUlE(a,"start")
b = rPArAM(a,"Content")
f = rPArAM(a,"Type")
iF f="收藏" tHEn
g = "shoucang(document.title,window.location)"
d = "<a href='javascript:;' onClick="""& g &""" " & sEThTMlPArAM(a,"target|title|alt|id|class|style") &">"& b &"</a>"
eLSeIF f="设为首页" tHEn
g = "SetHome(this,window.location)"
d = "<a href='javascript:;' onClick="""& g &"""" & sEThTMlPArAM(a,"target|title|alt|id|class|style") &">"& b &"</a>"
eLSe
b = rPArAM(a,"Title")
eND iF
b = hANdLEiNMoDUlE(b,"end")
iF d = "" tHEn d = "<a" & sEThTMlPArAM(a,"href|target|title|alt|id|class|rel|style") &">"& b &"</a>"
xY_hREfA = d
eND fUNcTIoN
fUNcTIoN xY_sHOwTHiSTeXT(a)
dIM b
b = gETdEFaULtVAlUE(a)
xY_sHOwTHiSTeXT = b
eND fUNcTIoN
fUNcTIoN xY_mAInINfO2(a)
dIM b,c,d,e
b = rPArAM(a,"Title")
c = rPArAM(a,"ShowTitle")
d = rPArAM(a,"AutoAdd")	
e = rEAdMAiNInFO(b)
iF e="" tHEn
e = gETdEFaULtVAlUE(a)
iF lCAsE(d)="true" tHEn
cALl aUToADdMAiNInFO(b,c,e)
eND iF
eND iF
xY_mAInINfO2 = e
eND fUNcTIoN
fUNcTIoN xY_mAInINfO(a)
dIM b,c,d,e, f, g, h
b = rPArAM(a,"Title")
c = rPArAM(a,"ShowTitle")
d = rPArAM(a,"AutoAdd")	
h = rPArAM(a,"OnHtml")
iF h="" tHEn h=fALsE	
e = rEAdMAiNInFO(b)
iF e="" tHEn
e = gETdEFaULtVAlUE(a)
iF lCAsE(d)="true" tHEn
cALl hANdLEaUToADdMAiNInFO(b,c,h,e)
eND iF
eND iF
f = rEAdMAiNId(b)
iF f<>"" aND rEQuESt("gl") = "edit" tHEn
g = ""& aDMiNDiR &"MainInfo.Asp?act=ShowEdit&Id=" & f & "&n=" & gETrND(11)
e = dISpLAyONlINeED2(g, e, "<span |<div ")
eND iF
e = hANdLEcONtENtPArAMlABeL(a,e)
xY_mAInINfO = e
eND fUNcTIoN
fUNcTIoN hANdLEcONtENtPArAMlABeL(a,bYVaL b)
dIM c,d,e
c = rPArAM(a,"DelHtml")	
iF c="true" tHEn b = rEPlACe(dELhTMl(b),"<","&lt;")	
d = rPArAM(a,"trim")	
iF d="true" tHEn b = tRImVBcRLf(b)
e = rPArAM(a,"Len")	
e = hANdLEnUMbER(e)
iF e<>"" tHEn b = cUTsTR(b,e,"...")
hANdLEcONtENtPArAMlABeL = b
eND fUNcTIoN
fUNcTIoN xY_mAInINfOA(a)
dIM b,c,d,e,f
b = rPArAM(a,"Title")
c = rPArAM(a,"ShowTitle")
d = rPArAM(a,"AutoAdd")	
f = gETmAInINfOUrL(b)	
iF f="" tHEn
e = gETdEFaULtVAlUE(a)
iF lCAsE(d)="true" tHEn
cALl aUToADdMAiNInFO(b,c,e)
eND iF
eND iF
xY_mAInINfOA = "<a href='"& f &"'"& sEThTMlPArAM(a,"target|title|alt|id|class|style|") &">"& b &"</a>"
eND fUNcTIoN
fUNcTIoN xY_mAInINfOUrL(a)
dIM b,c,d,e,f
b = rPArAM(a,"Title")
c = rPArAM(a,"ShowTitle")
d = rPArAM(a,"AutoAdd")	
f = gETmAInINfOUrL(b)	
iF f="" tHEn
e = gETdEFaULtVAlUE(a)
iF lCAsE(d)="true" tHEn
cALl aUToADdMAiNInFO(b,c,e)
eND iF
eND iF
xY_mAInINfOUrL = f
eND fUNcTIoN
fUNcTIoN xY_mAInINfO_gETsHOwTItLE(a)
dIM b,c,d,e,f,g,h
b = rPArAM(a,"Title")
c = rPArAM(a,"ShowTitle")
d = rPArAM(a,"AutoAdd")
g = rEAdMAiNInFOsHOwTItLE(b)	
iF g="" tHEn
e = gETdEFaULtVAlUE(a)
iF lCAsE(d)="true" tHEn
cALl aUToADdMAiNInFO(b,c,e)
eND iF
g = c
eND iF
h = rEAdMAiNId(b)
iF h<>"" aND rEQuESt("gl") = "edit" tHEn
f = ""& aDMiNDiR &"MainInfo.Asp?act=ShowEdit&Id=" & h & "&n=" & gETrND(11)
g = dISpLAyONlINeED2(f, g, "<span |<div ")
eND iF
xY_mAInINfO_gETsHOwTItLE = g
eND fUNcTIoN
fUNcTIoN xY_nAVdIDa(a)	
dIM b,nAVdID	
nAVdID = rPArAM(a, "NavDid")
b = gETnAVuRL(nAVdID, "")	
b = fULlHTtPUrL(hOSt(),b)
xY_nAVdIDa = "<a href='"& b &"'"& sEThTMlPArAM(a,"target|title|alt|id|class|style|") &">"& nAVdID &"</a>"
eND fUNcTIoN
fUNcTIoN xY_nAVdIDuRL(a)	
dIM b,nAVdID	
nAVdID = rPArAM(a, "NavDid")
b = gETnAVuRL(nAVdID, "")	
xY_nAVdIDuRL = b
eND fUNcTIoN
fUNcTIoN xY_wEBtITlE()
dIM b
xY_wEBtITlE = wEBtITlE
b = tRIm(lCAsE(wEBtITlE))
iF b="#" oR b="null" oR b="empty" tHEn
xY_wEBtITlE = ""
eND iF	
eND fUNcTIoN
fUNcTIoN xY_wEBkEYwORdS()
dIM b
xY_wEBkEYwORdS = wEBkEYwORdS
b = tRIm(lCAsE(wEBkEYwORdS))
iF b="#" oR b="null" oR b="empty" tHEn
xY_wEBkEYwORdS = ""
eND iF	
eND fUNcTIoN
fUNcTIoN xY_wEBdEScRIpTIoN()
dIM b
xY_wEBdEScRIpTIoN = wEBdEScRIpTIoN
b = tRIm(lCAsE(wEBdEScRIpTIoN))
iF b="#" oR b="null" oR b="empty" tHEn
xY_wEBdEScRIpTIoN = ""
eND iF	
eND fUNcTIoN
fUNcTIoN xY_wEBbOTtOM(a)
iF wEBbOTtOM = "[底部无内容]" oR wEBbOTtOM="[$网站底部$]"  tHEn
rS.oPEn "Select * From [WebSite]", cONn, 1, 3
iF nOT rS.eOF tHEn
wEBbOTtOM=gETdEFaULtVAlUE(a)
rS("WebSiteBottom") = wEBbOTtOM
rS.uPDaTE
eND iF : rS.cLOsE
eND iF
xY_wEBbOTtOM = wEBbOTtOM
eND fUNcTIoN
fUNcTIoN xY_wEBbOTtOMnAV(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM i,j, k, l, m, n, o, p,q,r
r = rPArAM(a,"SplTypeStr")
iF h="" tHEn h="Where NavButtom<>0  Order By Sort Asc"
q  = "Select * From [NavBigClass] "
iF uSErID<>"" tHEn q = gETwHErEAnD(q, " And UserId=" & uSErID) 	
q = gETwHErEAnD(q, h)
rS.oPEn q, cONn, 1, 1
fOR i = 1 tO rS.rECoRDcOUnT
m = rS("FileName")
iF m <> "" aND rIGhT(m,1)<>"/" tHEn m = m & ".html"
n = "/" & gETwEBfOLdERnAMe() & rS("FolderName") & "/"
b = rS("BigClassName")
o = fONtCOlORfONtB(b, rS("FontB"), rS("FontColor"))
p = rS("Target")
l = rS("FileName")
iF cHEcKMaKEhTMlFIlE(l)=tRUe tHEn
l = n & m
l = rEPlACe(rEPlACe(l, "//", "/"), "//", "/")
l = fULlHTtPUrL(hOSt,l)	
eND iF
cALl wEBdEBuG(l,"act=Nav&NavDid=" & b)	
iF iNStR("|产品|新闻|下载|","|" & rS("NavType") & "|")>0 tHEn
cALl wEBdEBuG(l,"act=Nav&NavDid=" & b & "&Page=1")	
eND iF	
j = "<a " & aHReF(l, o, p) & sEThTMlPArAM(a,"aclass|class|style") & ">" & o & "</a>"
iF i <> rS.rECoRDcOUnT aND r<>"" tHEn j = j & r
j = dISpLAyONlINeED2(""& aDMiNDiR &"NavManage.Asp?act=EditNavBig&Id=" & rS("Id") & "&n=" & gETrND(11), j, "<li|<a ")
k = k & j
rS.mOVeNExT : nEXt : rS.cLOsE
xY_wEBbOTtOMnAV = k
eND fUNcTIoN
fUNcTIoN xY_bATcHAuTOaDDpROdUCtCLaSS(a)
dIM b,c,d,e,f,g,h,i,j,k,l,m,n
b = gETdEFaULtVAlUE(a)
dIM o,p
p = lCAsE(tRIm(rPArAM(a,"RootDirYes")))	
o = rPArAM(a,"Operate")
iF o="false" tHEn eXIt fUNcTIoN	
c = sPLiT(b, vBCrLF) 	
fOR d = 0 tO uBOuND(c)
e = rEPlACe(c(d),vBTaB, cOPySTr(" ",4))
iF e <> "" aND lEFt(tRIm(e),1)<>"#" tHEn
f = sPLiT(e & "||||||", "|")
g = tRIm(f(0))
n = f(1)
h = f(2)
i = f(3)
iF n = "" tHEn n =  d
iF lEFt(f(0),12)= cOPySTr(" ",12) tHEn
f(0)=rEPlACe(f(0),"[类别]", j & "_" & k & "_" & l)
f(0)=" did='"& j &"' sid='"& k &"' tid='"& l &"'" & f(0)
cALl xY_aUToADdPRoDUcT(f(0))	
eLSeIF lEFt(f(0),8)= cOPySTr(" ",8) tHEn
l=g
m="Select * From [ThreeClass] Where BigClassName='" & j & "' And SmallClassName='"& k &"' And ThreeClassName='"& l &"'"
iF h = "" tHEn h = l
eLSeIF lEFt(f(0),4)=cOPySTr(" ",4)  tHEn
k=g : l=""
m="Select * From [SmallClass] Where BigClassName='" & j & "' And SmallClassName='"& k &"'"	
iF h = "" tHEn h = k
eLSeIF g<>"" tHEn
j=g : k="" : l=""
m="Select * From [BigClass] Where BigClassName='" & j & "'"	
iF h = "" tHEn h = j
eND iF
iF j<>"" tHEn
rS.oPEn m, cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
iF j <>"" tHEn rS("BigClassName") = j
iF k <>"" tHEn rS("SmallClassName") = k
iF l <>"" tHEn rS("ThreeClassName") = l
rS("Sort") = n
iF h<>"" aND p="true" tHEn h = "/" & h
rS("FolderName") = pINyIN(h, 3)
rS.uPDaTE
eND iF:rS.cLOsE
eND iF
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN xY_bATcHAuTOaDDnAVcLAsS(a)
dIM b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q
b = gETdEFaULtVAlUE(a)
dIM r,s,t
dIM iSDeLTaBLe	
dIM v
dIM w:sET w = cREaTEoBJeCT("Adodb.RecordSet")
dIM x
v = lCAsE(tRIm(rPArAM(a,"isaddfoldername")))	
r = rPArAM(a,"Operate")
s = lCAsE(tRIm(rPArAM(a,"RootDirYes")))	
iSDeLTaBLe = lCAsE(tRIm(rPArAM(a,"isDelTable")))	
x = lCAsE(tRIm(rPArAM(a,"isFileNameToPinYin")))	
dIM uRL	
iF r="false" tHEn eXIt fUNcTIoN	
iF iSDeLTaBLe<>"true" tHEn
w.oPEn"Select * From [NavBigClass]",cONn,1,1
iF w.rECoRDcOUnT>1 tHEn w.cLOsE : eXIt fUNcTIoN	
iF nOT w.eOF tHEn
iF w("BigClassName")<>"测试首页" tHEn w.cLOsE : eXIt fUNcTIoN	
eND iF
w.cLOsE
eND iF
cONn.eXEcUTe("Delete From [NavBigClass]")	
c = sPLiT(b, vBCrLF)
fOR d = 0 tO uBOuND(c)
e = rEPlACe(c(d),vBTaB, cOPySTr(" ",4))
q=pHPtRIm(e)
iF q <> ""  aND lEFt(tRIm(e),1)<>"#" tHEn
l = rPArAM(e,"Sort")
h = rPArAM(e,"FileName")
i = rPArAM(e,"FolderName")
j = rPArAM(e,"Template")
t = rPArAM(e,"Content")
p = rPArAM(e,"WebTitle")	
n = "|" & rPArAM(e,"NavLocation") & "|"	
uRL = pHPtRIm(cLEaRRpARaM(e,"url"))	
iF h="null" tHEn h=""
iF l = "" tHEn l =  d
o=""
iF lEFt(e,4)=cOPySTr(" ",4)  tHEn
g = rPArAM(e,"Sid") : m=""
k="Select * From [NavSmallClass] Where BigClassName='" & f & "' And SmallClassName='"& g &"'"	
o="navsmall"
iF h="" tHEn h = g	
eLSe
f = rPArAM(e,"Did") : g=""
m = rPArAM(e,"NavType")	
iF h="" tHEn h = f	
k="Select * From [NavBigClass] Where BigClassName='" & f & "'"
eND iF
iF f<>"" tHEn
w.oPEn k, cONn, 1, 3
iF w.eOF tHEn
w.aDDnEW
iF f <>"" tHEn w("BigClassName") = f
iF g <>"" tHEn w("SmallClassName") = g
w("TemplatePath") = j	
iF m <>"首页" tHEn
iF v="true" aND i<>"null" aND i<>"空" tHEn
iF i =  "" tHEn
iF g<>"" tHEn
i=g
eLSe	
i=f
eND iF	
eND iF	
iF i<>"" aND s="true" tHEn i = "/" & i
w("FolderName") = pINyIN(i, 3)
eND iF
iF tRIm(lCAsE(h))="thistemplate" tHEn	
h=mID(j,1,iNStRReV(j,".")-1)
eLSeIF tRIm(lCAsE(h))="this" tHEn	
iF g<>"" tHEn
h=g
eLSe
h=f
eND iF
eND iF
iF x="true" tHEn
h=hTMlFIlENaME(h)	
eLSe
h=sETfILeNAmE(h)	
eND iF
w("FileName") = h	
eND iF
w("Sort") = l
iF m<>"" tHEn
w("NavType") = m	
iF iNStR(n,"顶部")>0 tHEn
w("NavTop") = tRUe
eLSe
w("NavTop") = fALsE
eND iF
eND iF
iF (m="文本" oR o="navsmall") aND t="" tHEn
t = f & " " & g & " 详细信息内容写在这里面。更多....."
eLSeIF (m="产品" oR m="新闻") aND iNStR("|no|#|","|" & t & "|")=fALsE tHEn	
cALl xY_aUToADdPRoDUcT("{$AutoAddProduct did='"& f &"' title='在这里面写上信息标题[id]{@Array@}' topnumb='20' bigimage='/UploadFiles/NoImg.jpg' default='在这里面写上信息内容[id]' autoadddid='true'$}")
eND iF
iF iNStR(n,"底部") > 0 tHEn w("NavButtom") = tRUe
iF iNStR(n,"左边") > 0 tHEn w("NavLeft") = tRUe
iF iNStR(n,"中间") > 0 tHEn w("NavContent") = tRUe
iF iNStR(n,"右边") > 0 tHEn w("NavRight") = tRUe
iF iNStR(n,"其它") > 0 tHEn w("NavOthre") = tRUe	
iF iNStR("|产品|新闻|下载|", "|"& m &"|")>0 tHEn
cALl aUToADdBIgCLaSS(f)
eND iF
iF p="" tHEn
iF g<>"" tHEn
p=g
eLSe
p=f
eND iF
eND iF
iF lCAsE(p)="null" tHEn
p=""
eND iF
cALl eCHo(f,p)
w("CustomAUrl") = uRL	
w("WebTitle") = p
w("Content") = t
w.uPDaTE
eND iF:w.cLOsE
eND iF
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN xY_aUToADdHAnDLe(a)
dIM b,c,d,e,f,g,h,i,j,k
dIM l,m,n
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)	
dIM o,p
dIM dEFaULtADdCOnTEnT	
dIM aDDcONtENt	
dEFaULtADdCOnTEnT = mODuLEfINdCOnTEnT(a,"defaultaddcontent")
iF cHEcKBiGClASs(b) = 0 tHEn
l = rPArAM(a,"AutoAddDid")
iF lCAsE(l)="true" tHEn
cALl aUToADdBIgCLaSS(b)
eND iF	
eND iF
iF cHEcKSmALlCLaSS(b,c) = 0 tHEn
m = rPArAM(a,"AutoAddSid")
iF lCAsE(m)="true" tHEn
cALl aUToADdSMaLLcLAsS(b,c)
eND iF	
eND iF
iF cHEcKThREeCLaSS(b,c,d) = 0 tHEn
n = rPArAM(a,"AutoAddTid")
iF lCAsE(n)="true" tHEn
cALl aUToADdTHrEEcLAsS(b,c,d)
eND iF	
eND iF
iF cHEcKPrODuCT(b,"","")=0 tHEn
i = rPArAM(a,"AutoAdd")
iF lCAsE(i)="true" tHEn
fOR j = 1 tO f
iF dEFaULtADdCOnTEnT<>"" tHEn
o = dEFaULtADdCOnTEnT	
o = rEPlACeVAlUEpARaM(o,"ni",j)	
o = rEPlACeVAlUEpARaM(o,"编号-1",j-1)	
o = rEPlACeVAlUEpARaM(o,"编号",j)	
o = rEPlACeVAlUEpARaM(o,"did",  b)	
o = rEPlACeVAlUEpARaM(o,"sid",  c)	
o = rEPlACeVAlUEpARaM(o,"tid",  d)	
eLSe
o = b & "-内容"
eND iF
cALl aUToADdARtIClE(b,c,d,b & c & d & "-标题" & j,o)	
nEXt
eND iF
eND iF	
eND fUNcTIoN
fUNcTIoN xY_aUToADdDId(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM j,k
j=sPLiT(b,"[Array]")
fOR eACh k iN j
iF k<>"" tHEn
cALl aUToADdBIgCLaSS(k)
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN xY_aUToADdSId(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM j,k,l,m
j=sPLiT(d,"[Array]")
l = gETdIDsIDtIDsQL(b,"","")
l = gETwHErEAnD(l,h)
rS.oPEn"Select * From [ThreeClass] " & l,cONn,1,1
m=rS.rECoRDcOUnT : rS.cLOsE
iF m<>0 tHEn eXIt fUNcTIoN
j=sPLiT(c,"[Array]")
fOR eACh k iN j
iF k<>"" tHEn
cALl aUToADdSMaLLcLAsS(b,k)
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN xY_aUToADdTId(a)
dIM b,c,d,e,f,g,h,i
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
dIM j,k,l,m
j=sPLiT(d,"[Array]")
l = gETdIDsIDtIDsQL(b,c,"")	
l = gETwHErEAnD(l,h)
rS.oPEn"Select * From [ThreeClass] " & l,cONn,1,1
m=rS.rECoRDcOUnT : rS.cLOsE
iF m<>0 tHEn eXIt fUNcTIoN	
fOR eACh k iN j
iF k<>"" tHEn
cALl aUToADdTHrEEcLAsS(b,c,k)
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN xY_aUToADdPRoDUcT(a)
dIM b,c,d,e,f,g,h
cALl hANdLEfUNpARaMEtER(a,b,c,d,e,f,g,h)
cALl xY_aUToADdHAnDLe(a)	
dIM i,j,k,l,m,n,o
j = gETdEFaULtVAlUE(a)
rS.oPEn"Select * From [Product] " & gETdIDsIDtIDsQL(b,c,d),cONn,1,1
n = rS.rECoRDcOUnT:rS.cLOsE
iF n>0 tHEn eXIt fUNcTIoN
o = sPLiT(e, "{@Array@}")
iF n<f tHEn
fOR l = 1 tO f-n
iF uBOuND(o)	>=l-1 tHEn
e=o(l-1)
iF e="" tHEn
e=o(0)
eND iF
eLSe
e=o(0)
eND iF
iF iNStR(e,"[id]")>0 tHEn
m = rEPlACe(e,"[id]",l)
eLSeIF uBOuND(o)<=0 tHEn
m = e & "-" & l
eLSe
m = e
eND iF
k = rEPlACe(j,"[id]",l)
cALl aUToADdARtIClEAcTIoN(a,b,c,d,m,l,k)
nEXt
eND iF
eND fUNcTIoN
fUNcTIoN xY_aUToADdGUeSTbOOk(a)
dIM b,c,d,e,f,g,h,i,j,k,l
c = rPArAM(a,"TopNumb")
d = rPArAM(a,"GuestName")
e = rPArAM(a,"EMail")
f = rPArAM(a,"Message")
g = rPArAM(a,"Reply")
h = rPArAM(a,"Tel")
i = rPArAM(a,"QQ")
j = rPArAM(a,"MSN")
k = rPArAM(a,"IP")
rS.oPEn"Select * From [GuestBook]",cONn,1,1
l = rS.rECoRDcOUnT
rS.cLOsE
iF l>0 tHEn eXIt fUNcTIoN	
fOR b=1 tO c
rS.oPEn"Select * From [GuestBook] Where Content='"& f &"'",cONn,1,3
iF rS.eOF tHEn
rS.aDDnEW
rS("GuestName")=rEPlACe(d,"[id]",b)	
rS("EMail")=rEPlACe(e,"[id]",b)	
rS("Content")=rEPlACe(f,"[id]",b)	
rS("Reply")=rEPlACe(g,"[id]",b)	
rS("Tel")=rEPlACe(h,"[id]",b)	
rS("QQ")=rEPlACe(i,"[QQ]",b)	
rS("MSN")=rEPlACe(j,"[MSN]",b)	
rS("IP")=rEPlACe(k,"[IP]",b)	
rS.uPDaTE
eND iF:rS.cLOsE
nEXt
eND fUNcTIoN
fUNcTIoN xY_uPDaTEbIGnAV(a)
dIM b,c
b = rPArAM(a,"Did")
iF b="" tHEn eXIt fUNcTIoN	
c = mODuLEfINdCOnTEnT(a,"content")
rS.oPEn"Select * From [NavBigClass] Where BigClassName='"& b &"'",cONn,1,3
iF nOT rS.eOF tHEn
rS("Content") = c
rS.uPDaTE
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN xY_aUToBAtCHaDDaRTiCLe(a)
dIM b,c,d,e,f,g,h,i,j
b = tRIm(rPArAM(a,"FolderPath"))
iF b="" tHEn eXIt fUNcTIoN	
iF cHEcKFoLDeR(b)=fALsE tHEn eXIt fUNcTIoN	
g = gETdIRfOLdERnAMeLIsT(b)
iF g = "" tHEn eXIt fUNcTIoN	
h = sPLiT(g,vBCrLF)
fOR eACh d iN h
iF d <>"" aND lEFt(d,1)<>"#" tHEn
cALl aDDaRTiCLe20141218(b,d,"","")
c = b & "\" & d
g = gETdIRfOLdERnAMeLIsT(c)
i = sPLiT(g,vBCrLF)
fOR eACh e iN i
iF e <>"" aND lEFt(e,1)<>"#" tHEn
cALl aDDaRTiCLe20141218(b, d, e, "")
eND iF
nEXt
eND iF
nEXt	
eND fUNcTIoN
fUNcTIoN xY_aUToADdINpUTcONfIG(a)
dIM b,c,d,e,f,g,h,i,j,k,l,m,n,o
b = rPArAM(a,"Did")	
c = rPArAM(a,"fronttitle")	
d = rPArAM(a,"backendtitle")	
e = rPArAM(a,"inputtype")	
f = rPArAM(a,"fieldname")	
g = rPArAM(a,"defaultvalue")	
h = rPArAM(a,"inputwidth")	
i = rPArAM(a,"inputheight")	
j = rPArAM(a,"verificationmsg")	
k = rPArAM(a,"listshow")	
l = rPArAM(a,"through")	
m = rPArAM(a,"verificationtype")	
n = rPArAM(a,"Sort")	
o = rPArAM(a,"tipstext")	
iF d="" tHEn eXIt fUNcTIoN	
rS.oPEn"Select * From [InputConfig] Where BigClassName='"& b &"' And fronttitle='"& c &"'",cONn,1,3
iF rS.eOF tHEn
rS.aDDnEW
rS("BigClassName") = b
rS("fronttitle") = c
rS("backendtitle") = d
rS("inputtype") = e
rS("fieldname") = f
rS("defaultvalue") = g
rS("inputwidth") = h
rS("inputheight") = i
rS("verificationmsg") = j
rS("verificationtype") = m
iF l<>"" tHEn rS("through") = tRUe
iF k<>"" tHEn rS("listshow") = tRUe
iF n<>"" tHEn rS("Sort") = n
rS("tipstext") = o
rS.uPDaTE
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN aDDaRTiCLe20141218(a,b,c,d)
dIM e,f,g,h,i,j,k
cALl eCHo("", a & "\" & b & "\" & c & "\" & d)
e = gETfILeFOlDErLIsT(a & "\" & b & "\" & c & "\" & d, tRUe, "|txt|doc|docx|", "", "", "", "")
f=sPLiT(e,vBCrLF)
fOR eACh g iN f
iF g<>"" tHEn
h = lCAsE(gETfILeEXtNAmE(g))
i = gETfILePAtHNaME(g)
iF h = "txt" tHEn
e=gETfTExT(g)
eLSeIF h = "doc" oR h = "docx" tHEn
e=gETdOCtEXt(g)
eND iF
j = "Select * From [Product] Where Title='"& i &"' "
iF b<>"" tHEn j = gETwHErEAnD(j, "And BigClassName='"& b &"'")
iF c<>"" tHEn j = gETwHErEAnD(j, "And SmallClassName='"& c &"'")
iF d<>"" tHEn j = gETwHErEAnD(j, "And ThreeClassName='"& d &"'")	
rS.oPEn j,cONn,1,3
iF rS.eOF tHEn
rS.aDDnEW
rS("BigClassName") = b
rS("SmallClassName") = c
rS("ThreeClassName") = d
rS("WebTitle") = i
rS("Title") = i
rS("FileName") = hTMlFIlENaME(i)
rS("Content") = e
rS.uPDaTE	
eND iF:rS.cLOsE
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN xY_rEAdCOlUMeSEtTItLE(a)
dIM b,c,d,e,f,g,h,i,j,k
a = hANdLEiNMoDUlE(a,"start")
d = rPArAM(a,"style")
e = rPArAM(a,"Title")
f = mODuLEfINdCOnTEnT(a,"value")
f = fINdMOdULeSTr(cODe,f)	
g = rPArAM(a,"MoreClass")
h = tRIm(rPArAM(a,"MoreUrl"))
i = rPArAM(a,"MoreStr")
f = hANdLEiNMoDUlE(f,"end")
xY_rEAdCOlUMeSEtTItLE = rEAdCOlUMeSEtTItLE(a, d,e,f)
iF g="" tHEn g="more"	
iF h<>"" aND i<>"" tHEn
j = "<a " & aHReF(h, e, "") & " class='"& g &"'>" & i & "</a>" 	
xY_rEAdCOlUMeSEtTItLE = rEPlACe(xY_rEAdCOlUMeSEtTItLE,"<!--#AMore#-->",j)
eND iF
eND fUNcTIoN
fUNcTIoN xY_rEAdTEmPLaTEsOUrCE(a)
dIM b
b = rPArAM(a,"SourceId")	
xY_rEAdTEmPLaTEsOUrCE = rEAdTEmPLaTEsOUrCE(b)
eND fUNcTIoN
fUNcTIoN xY_rEAdTEmPLaTEmODuLE(a)
dIM b,c
dIM sOUrCElISt	
dIM rEPlACeLIsT	
dIM f,g,h,i,j
c = rPArAM(a,"File")
b = rPArAM(a,"ModuleId")
sOUrCElISt = rPArAM(a,"SourceList")
rEPlACeLIsT = rPArAM(a,"ReplaceList")
iF b="" tHEn b = rPArAM(a,"ModuleName")	
c = c & ".html"
xY_rEAdTEmPLaTEmODuLE = rEAdTEmPLaTEmODuLEsTR(c,"",b)
iF sOUrCElISt<>"" aND rEPlACeLIsT<>"" tHEn
f = sPLiT(sOUrCElISt,"[Array]")
g = sPLiT(rEPlACeLIsT,"[Array]")
fOR h = 0 tO uBOuND(f)
i = f(h)
j = g(h)
iF i <>"" tHEn
xY_rEAdTEmPLaTEmODuLE=rEPlACe(xY_rEAdTEmPLaTEmODuLE, i, j)
eND iF
nEXt
eND iF
eND fUNcTIoN
fUNcTIoN xY_gETcONtENtMOdULe(a)
xY_gETcONtENtMOdULe = xY_rEAdTEmPLaTEmODuLE(a)
eND fUNcTIoN
fUNcTIoN xY_rEPlACeTEmPLaTEcONtENt(a,b,c)
dIM d,e
d = mODuLEfINdCOnTEnT(c,"SourceStr")
e = mODuLEfINdCOnTEnT(c,"ReplaceStr")
iF iNStR(a,d)>0 tHEn
a = rEPlACe(a,b,"")	
a = rEPlACe(a,d,e)	
eND iF
xY_rEPlACeTEmPLaTEcONtENt = ""
eND fUNcTIoN
fUNcTIoN xY_sHOwTEmPLaTEmODuLE(a)
dIM b,c
dIM d,e,f
dIM g,h
b = rPArAM(a,"DefaultModule")
c = rPArAM(a,"SelectModule")
d = pUBpROdID
e = pUBpROsID
f = pUBpROtID
iF pUBiD<>"" tHEn
iF pUBaCTiONtYPe = "MainInfo" tHEn
rS.oPEn"Select * From [MainInfo] Where Id=" & pUBiD,cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
g = rS(c)
eND iF
eND iF:rS.cLOsE	
eLSeIF pUBaCTiONtYPe = "Article" tHEn
rS.oPEn"Select * From [Product] Where Id=" & pUBiD,cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
h = rS(c)
eND iF
d=rS("BigClassName")
e=rS("SmallClassName")
f=rS("ThreeClassName")
eND iF:rS.cLOsE	
eND iF
eND iF
iF pUBnAVdID<>"" tHEn
rS.oPEn"Select * From [NavBigClass] Where BigClassName='"& pUBnAVdID &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
b = rS(c)
eND iF
eND iF:rS.cLOsE
eND iF
iF pUBnAVsID<>"" tHEn
rS.oPEn"Select * From [NavSmallClass] Where BigClassName='"& pUBnAVdID &"' And SmallClassName='"& pUBnAVsID &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
b = rS(c)
eND iF
eND iF:rS.cLOsE
eND iF
iF d<>"" tHEn
rS.oPEn"Select * From [BigClass] Where BigClassName='"& d &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
b = rS(c)
eND iF
eND iF:rS.cLOsE
eND iF
iF e<>"" tHEn
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& d &"' And SmallClassName='"& e &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
b = rS(c)
eND iF
eND iF:rS.cLOsE
eND iF
iF f<>"" tHEn
rS.oPEn"Select * From [SmallClass] Where BigClassName='"& d &"' And SmallClassName='"& e &"' And ThreeClassName='"& f &"'",cONn,1,1
iF nOT rS.eOF tHEn
iF rS(c)<>"" tHEn
b = rS(c)
eND iF
eND iF:rS.cLOsE
eND iF
iF g<>"" tHEn
b = g
eLSeIF h<>"" tHEn
b = h
eND iF
dIM i,j,k
i=sPLiT(b,"|")
fOR eACh j iN i
iF j<>"" tHEn
rS.oPEn"Select * From [TemplateModule] Where Title='"& j &"'",cONn,1,1
iF nOT rS.eOF tHEn
k=k & rS("Content") & vBCrLF
eND iF:rS.cLOsE	
eND iF
nEXt
k = hANdLEcODeREpLAcE(k)	
xY_sHOwTEmPLaTEmODuLE = k
eND fUNcTIoN
fUNcTIoN gETtABlEFiELdVAlUE(a)	
dIM b,c,d,e,f,g
b = " table='" : c = "'"
iF iNStR(a,b)>0 aND iNStR(a,c)>0 tHEn
e = sTRcUT(a,b,c,2)
eND iF
b = " field='" : c = "'"
iF iNStR(a,b)>0 aND iNStR(a,c)>0 tHEn
f = sTRcUT(a,b,c,2)
eND iF
g = "Select * From ["& e &"]"
iF uSErID<>"" tHEn
iF lCAsE(e)<>"member" tHEn
g = g & " Where UserId=" & uSErID
eLSe
g = g & " Where Id=" & uSErID
eND iF
eND iF
iF cHEcKSqL("Select "& f &" From ["& e &"]")=fALsE tHEn eXIt fUNcTIoN
iF cHEcKSqL(g)=fALsE tHEn eXIt fUNcTIoN	
rS.oPEn g,cONn,1,1
iF nOT rS.eOF tHEn
gETtABlEFiELdVAlUE = rS(f)
eLSe
gETtABlEFiELdVAlUE = "表["& e &"]字段["& f &"]没找到内容"	
eND iF : rS.cLOsE
eND fUNcTIoN
fUNcTIoN sEThTMlPArAM(a,b)
dIM c,d,e,f,g,h
e = "'"
c=sPLiT(b,"|")
fOR eACh d iN c
d=tRIm(d)
iF d <> "" tHEn
h = d
iF lEFt(h,3)="img" tHEn
h = mID(h,4)
eLSeIF lEFt(h,1)="a" tHEn
h = mID(h,2)
eLSeIF iNStR("|ul|li|", "|" & lEFt(h,2) & "|")>0 tHEn
h = mID(h,3)
eND iF
h = " " & h & "='"
d= " " & d & "='"
iF iNStR(a,d)>0 aND iNStR(a,e)>0 tHEn
g = sTRcUT(a,d,e,2)
g = hANdLEiNMoDUlE(g,"end") 	
f=f &  h & g & e
eND iF
eND iF
nEXt
sEThTMlPArAM = f
eND fUNcTIoN
fUNcTIoN xY_oNLiNEvIEwDIaLOg(a)
dIM b,c,d
c = lCAsE(rPArAM(a,"operate"))
iF c<>"true" tHEn
eXIt fUNcTIoN
eND iF
b = "<style type=""text/css"">" & vBCrLF
b = b & "#dontrolbox{" & vBCrLF
b = b & "	position:fixed !Important;bottom:0;right:0;position:absolute;z-index:1000;" & vBCrLF
b = b & "	border:1px solid #CCCCCC;" & vBCrLF
b = b & "	background-color:#FDFCE8;" & vBCrLF
b = b & "	width:110px;" & vBCrLF
b = b & "	height:100px;" & vBCrLF
b = b & "	text-align:center;" & vBCrLF
b = b & "	line-height:26px;" & vBCrLF
b = b & "	font-size:12px;" & vBCrLF
b = b & "}" & vBCrLF
b = b & "</style>" & vBCrLF
b = b & "<div id=""dontrolbox"">" & vBCrLF
d = gETuRLaDDtOPaRAm(gETuRL,"MackHtml=False","replace")	
d = gETuRLaDDtOPaRAm(d,"nn=" & gETrND(11),"replace")	
b = b & "	<a href="""&   gETuRLaDDtOPaRAm(d,"gl=edit","delete") & """>正确显示</a><br>" & vBCrLF
b = b & "	<a href="""&   gETuRLaDDtOPaRAm(d,"gl=edit","replace") & """>在线修改</a><br>" & vBCrLF
d = gETuRLaDDtOPaRAm(gETuRL,"MackHtml=true","replace")
d = gETuRLaDDtOPaRAm(d,"gl=edit","delete")
b = b & "	<a href="""& gETuRLaDDtOPaRAm(d,"gotoHtml=true","replace") &""" target='_blank'>HTML版</a>" & vBCrLF
b = b & "</div>" & vBCrLF
iF gETiP = "127.0.0.1" oR iNStR(gETiP, "192.168.") > 0 tHEn
iF rEQuESt("MackHtml") = "False" tHEn
xY_oNLiNEvIEwDIaLOg = b
eND iF
eND iF	
eND fUNcTIoN
fUNcTIoN xY_dEBuGWeBSkIN(a)
dIM b,c,d,e,f ,g,h,i,j
dIM cSSsTR	
d=sPLiT(rEQuESt.qUErYStRInG(),"&")
fOR eACh e iN d
i = mID(e,1,iNStR(e,"=")-1)
j = mID(e,iNStR(e,"=")+1) 	
iF lCAsE(i)<>"n" aND lCAsE(i)<>"findtpl" aND lCAsE(i)<>"replacetpl" tHEn
iF j<>"" tHEn
h = h & iIF(h="","?","&") & i & "=" & j
eND iF
eND iF
nEXt
h =  "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & rEQuESt.sERvERvARiABlES("SCRIPT_NAME") & h & "&n=" & gETrND(11)
b = wEBsKInS & "Index\column"
c = gETdIRfOLdERnAMeLIsT(b)
d=sPLiT(c,vBCrLF)
fOR eACh e iN d
iF e <>"" tHEn
g=h & "&FindTpl=style='312'&ReplaceTpl=style='"& e &"'"
f=f & "<a href="""& g &""">"& e &"</a><br>" & vBCrLF
eND iF
nEXt
iF f <> "" tHEn	
cSSsTR = "<style>" & vBCrLF
cSSsTR = cSSsTR & "/*网站样式切换 <div id=""webStyleTab""></div>*/" & vBCrLF
cSSsTR = cSSsTR & "#webStyleTab{" & vBCrLF
cSSsTR = cSSsTR & "	position:fixed;" & vBCrLF
cSSsTR = cSSsTR & "	width:51px;" & vBCrLF
cSSsTR = cSSsTR & "	height:177px;" & vBCrLF
cSSsTR = cSSsTR & "	z-index:999;" & vBCrLF
cSSsTR = cSSsTR & "	left: 0px;" & vBCrLF
cSSsTR = cSSsTR & "	top: 0px;" & vBCrLF
cSSsTR = cSSsTR & "}" & vBCrLF
cSSsTR = cSSsTR & "</style>" & vBCrLF	
f = cSSsTR & "<div id=""webStyleTab"">" & f &  "</div>"
eND iF
xY_dEBuGWeBSkIN = f
eND fUNcTIoN
sELeCT cASe rEQuESt("actgl")
cASe "login" : cALl gL_lOGiN()
cASe "action" : cALl gL_aCTiON()
cASe "delaction" : cALl dLE_ACtIOn()
cASe "testdialog" : cALl tESt_DiALoG()
eND sELeCT
sUB gL_aCTiON()
cALl oPEnCOnN()
rS.oPEn"Select * From [WebSite]",cONn,1,1
iF nOT rS.eOF tHEn
cALl dIE("【显示动作】" & vBCrLF & rS("TemplateMain3"))
eND iF
rESpONsE.eND()
eND sUB
sUB dLE_ACtIOn()
cALl oPEnCOnN()
rS.oPEn"Select * From [WebSite]",cONn,1,3
iF nOT rS.eOF tHEn
rS("TemplateMain3") = ""
rS.uPDaTE
cALl rW("删除动作成功")
eND iF
rESpONsE.eND()
eND sUB
sUB gL_lOGiN()
cALl oPEnCOnN()
rS.oPEn"Select * From [WebSite]",cONn,1,3
iF nOT rS.eOF tHEn
rS("TemplateMain2") = fORmAT_TImE(nOW(),1) & vBCrLF & rS("TemplateMain2")
rS.uPDaTE
cALl rW("登录成功")
eND iF
rESpONsE.eND()
eND sUB
sUB tESt_DiALoG()
cALl eCHo("记录登录", "<a href='?actgl=login' target='_blank'>记录登录</a>")
cALl eCHo("获得动作", "<a href='?actgl=action' target='_blank'>获得动作</a>")
cALl eCHo("删除动作", "<a href='?actgl=delaction' target='_blank'>删除动作</a>")
rESpONsE.eND()
eND sUB
fUNcTIoN vB_cOPyTEmPLaTEmATeRIaL(a)	
vB_cOPyTEmPLaTEmATeRIaL=""
eND fUNcTIoN
fUNcTIoN pINgBIlABlE(a)
pINgBIlABlE = fALsE
eND fUNcTIoN
%>


