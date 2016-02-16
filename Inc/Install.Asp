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
dIM oBJaCCeSS : sET oBJaCCeSS = nEW cLAsSAcCEsS
sELeCT cASe rEQuESt("act")
cASe "Web", "web" : mDBpATh = ".."& aDMiNDiR &"Data/Data.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.wEBdATa()
cASe "addwebtable" : mDBpATh = ".."& aDMiNDiR &"Data/Data.mdb" : cALl oPEnCOnN() :cALl oBJaCCeSS.wEBdATa()
cASe "CreateRemoteSqlServerDatabase" : cALl cREaTErEMoTEsQLsERvERdATaBAsE()
cASe "QQ", "qq", "Qq" : mDBpATh = "../Help/QQData.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.qQAcCEsS()
cASe "AdminLog" : mDBpATh = ".."& aDMiNDiR &"Data/AdminLog.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.aDMiNLoG()
cASe "AskDa" : mDBpATh = "../../网站备份/数据库/AskDa.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.aSKdAAcCEsS()
cASe "ZNRobot" : mDBpATh = "../../网站备份/数据库/ZNRobot.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.zNRoBOtACcESs()
cASe "ComputerDir" : mDBpATh = "../../网站备份/数据库/ComputerDir.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.cOMpUTeRDiR()
cASe "WebSoftAccess" : mDBpATh = "../Web_Soft/WebSoftAccess.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.wEBsOFtACcESs()
cASe "CaiConfig" : mDBpATh = "../../网站备份/数据库/CaiConfig.mdb" : cALl oBJaCCeSS.dEFaULtDIsPLaY() : cALl oBJaCCeSS.cAIcONfIG()
cASe eLSe dEFaULtDIsPLaY()
eND sELeCT
sET oBJaCCeSS = nOThINg
sUB dEFaULtDIsPLaY()
dIM b
b="<a href='?act=web&DB_PREFIX=xy_' target='_blank'>点击创建(本地Access)</a> | <a href='?act=addwebtable&DB_PREFIX=test_' target='_blank'>追加test_前缀表</a>"
b=b & " | <a href='?act=addwebtable' target='_blank'>追加前缀表</a>"
cALl eCHo("创建网站数据库", b)
cALl eCHo("创建QQ数据库", "<a href=?act=qq>点击创建</a>")
cALl eCHo("创建网站日志(AdminLog)数据库20150218", "<a href=?act=AdminLog>点击创建</a>")
cALl eCHo("创建自己问答(AskDa)数据库", "<a href=?act=AskDa>点击创建</a>")
cALl eCHo("创建智能机器人(ZNRobot)数据库", "<a href=?act=ZNRobot>点击创建</a>")
cALl eCHo("创建(ComputerDir)数据库", "<a href=?act=ComputerDir>点击创建</a>")
cALl eCHo("创建(WebSoftAccess)数据库", "<a href=?act=WebSoftAccess>点击创建</a>")
cALl eCHo("创建远程SqlServer数据库", "<a href=?act=CreateRemoteSqlServerDatabase>点击创建(SQLServer本地与远程20141120)</a>")
cALl eCHo("创建(CaiConfig)【采集配置】数据库", "<a href=?act=CaiConfig>点击创建</a>")
cALl rW("<hr>")
cALl eCHo("创建(WebUrlScan)数据库", "<a href=/e/E盘/WEB网站/网站备份/数据库/WebUrlScan.Asp?act=CreateAccess>进入WebUrlScan.Asp</a>")
eND sUB
sUB cREaTErEMoTEsQLsERvERdATaBAsE()
mDBpATh = ""
iF 1 = 2 tHEn
dATaBAsETyPE = "SqlServer"
sQLsERvERhOStIP = "hds-113.hichina.com,1433"
sQLsERvERdATaBAsENaME = "hds1130012_db"
sQLsERvERuSErNAmE = "hds1130012"
sQLsERvERpASsWOrD = "L4dN4eRd"
eLSe
dATaBAsETyPE = "SqlServerWebData"
dATaBAsETyPE = "RemoteSqlServer20150727"
eND iF
cALl oPEnCOnN()
cALl oBJaCCeSS.wEBdATa()
eND sUB
cLAsS cLAsSAcCEsS
dIM tABlENaME, sQL, aDDdATa, sPLsTR, sPLxX, i, s, sPLtRUe, bIGcLAsSNaME
dIM sPLuRL, sPLnAVnAMe, nAVcLAsSNaME, sPLiMG, tEMpLAtEInDEx, tEMpLAtEHoME, tEMpLAtEMaIN
dIM dB_pREfIX
sUB dEFaULtDIsPLaY()
mDBpATh = hANdLEpATh(mDBpATh)
cALl dELeTEfILe(mDBpATh)
iF eXIsTSfILe(mDBpATh) = fALsE tHEn cREaTEmDB(mDBpATh)
cALl oPEnCOnN()
eND sUB
sUB wEBdATa()	
dB_pREfIX=rEQuESt("DB_PREFIX")
cALl eCHo("DB_PREFIX",dB_pREfIX)
tABlENaME = dB_pREfIX & "WebColumn"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "columnName VarChar Default """","
sQL = sQL & "columnEnName VarChar Default """","
sQL = sQL & "columnType VarChar Default """","
sQL = sQL & "parentId int Default -1,"
sQL = sQL & "topId int Default -1,"
sQL = sQL & "sortRank int Default 0,"
sQL = sQL & "views int Default 0,"
sQL = sQL & "adminId int Default 0,"
sQL = sQL & "isDisplay YesNo,"
sQL = sQL & "smallImage VarChar Default """","
sQL = sQL & "bigImage VarChar Default """","
sQL = sQL & "bannerImage VarChar Default """","
sQL = sQL & "flags VarChar Default """","
sQL = sQL & "showTitle VarChar Default """","
sQL = sQL & "lableTitle VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "isMakeHtml YesNo Default Yes,"
sQL = sQL & "topModule VarChar Default """","
sQL = sQL & "bottomModule VarChar Default """","
sQL = sQL & "leftModule VarChar Default """","
sQL = sQL & "middleModule VarChar Default """","
sQL = sQL & "rightModule VarChar Default """","
sQL = sQL & "customAUrl VarChar Default """","
sQL = sQL & "nPageSize int Default 10,"
sQL = sQL & "isHtml YesNo Default false,"
sQL = sQL & "isOnHtml YesNo Default Yes,"                                 	
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "noteInfo Text Default """","
sQL = sQL & "simpleIntroduction Text Default """","
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "ArticleDetail"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "parentId int Default -1,"
sQL = sQL & "topId int Default -1,"
sQL = sQL & "sortRank int Default 0,"
sQL = sQL & "views int Default 0,"
sQL = sQL & "adminId int Default 0,"
sQL = sQL & "smallImage VarChar Default """","
sQL = sQL & "bigImage VarChar Default """","
sQL = sQL & "bannerImage VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "titleColor VarChar Default """","
sQL = sQL & "lableTitle VarChar Default """","
sQL = sQL & "isCheck YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Occasions VarChar Default """","
sQL = sQL & "Hotline VarChar Default """","
sQL = sQL & "Model VarChar Default """","
sQL = sQL & "Author VarChar Default """","
sQL = sQL & "ArticleSource VarChar Default """","
sQL = sQL & "Price Int Default 0,"
sQL = sQL & "NewPrice Int Default 0,"
sQL = sQL & "MemberPrice Int Default 0,"
sQL = sQL & "Sold Int Default 0,"
sQL = sQL & "MemberType VarChar Default """","
sQL = sQL & "MemberUser VarChar Default """","
sQL = sQL & "Hits Int Default 0,"
sQL = sQL & "TitleAlt VarChar Default """","
sQL = sQL & "BigFilesAlt VarChar Default """","
sQL = sQL & "SmallFilesAlt VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "ProductAbout Text,"
sQL = sQL & "ArticleDescription Text,"
sQL = sQL & "HttpUrl VarChar Default """","
sQL = sQL & "RecordUrl VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "flags VarChar Default """","
sQL = sQL & "isHtml YesNo Default false,"
sQL = sQL & "isOnHtml YesNo Default Yes,"                                 	
sQL = sQL & "nCount Int Default 0,"
sQL = sQL & "ArticleInfoStyle VarChar Default """","
sQL = sQL & "ArticleInfoPhotoWidth VarChar Default """","
sQL = sQL & "ArticleInfoPhotoHeight VarChar Default """","
sQL = sQL & "RelatedTags VarChar Default """","
sQL = sQL & "weight Int Default 0,"
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "noteInfo Text Default """","
sQL = sQL & "simpleIntroduction Text Default """","
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "OnePage"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "displayTitle VarChar Default """","
sQL = sQL & "adminId int Default 0,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "sortRank Int Default 0,"
sQL = sQL & "views int Default 0,"
sQL = sQL & "isRecommend YesNo Default Yes,"
sQL = sQL & "dispalyEditor YesNo Default Yes,"
sQL = sQL & "lableTitle VarChar Default """","
sQL = sQL & "isHtml YesNo Default false,"
sQL = sQL & "isOnHtml YesNo Default Yes,"                                 	
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "HelpText Text Default """","
sQL = sQL & "customAUrl VarChar Default """","
sQL = sQL & "noteInfo Text Default """","
sQL = sQL & "simpleIntroduction Text Default """","
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "TableComment"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "UserID Int Default 0,"                                    	
sQL = sQL & "itemID Int Default 0,"
sQL = sQL & "parentId int Default -1,"
sQL = sQL & "tableName VarChar Default """","
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "EMail VarChar Default """","
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "ip VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Reply Text Default """","
sQL = sQL & "noteInfo Text Default """","
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "WebsiteStat"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "visiturl VarChar Default """","
sQL = sQL & "viewurl VarChar Default """","
sQL = sQL & "browser VarChar Default """","
sQL = sQL & "operatingSystem VarChar Default """","
sQL = sQL & "screenWH VarChar Default """","
sQL = sQL & "moreInfo VarChar Default """","
sQL = sQL & "viewDateTime DateTime Default Now(),"
sQL = sQL & "ip VarChar Default """","
sQL = sQL & "dateClass VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "noteInfo Text Default """","
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "webLayout"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "layoutName VarChar Default """","
sQL = sQL & "layoutList VarChar Default """","
sQL = sQL & "replaceStyle VarChar Default """","
sQL = sQL & "actionContent Text Default """","
sQL = sQL & "sortRank int Default 0,"
sQL = sQL & "isDisplay YesNo,"
sQL = sQL & "author VarChar Default """","
sQL = sQL & "views int Default 0,"
sQL = sQL & "adminId int Default 0,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "simpleIntroduction Text Default """","
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "webModule"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "moduleType VarChar Default """","
sQL = sQL & "moduleName VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "sortRank int Default 0,"
sQL = sQL & "isDisplay YesNo,"
sQL = sQL & "author VarChar Default """","
sQL = sQL & "views int Default 0,"
sQL = sQL & "adminId int Default 0,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "simpleIntroduction Text Default """","
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Bidding"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "searchWords VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "showReason VarChar Default """","
sQL = sQL & "nComputerSearch int Default 0,"
sQL = sQL & "nMoblieSearch int Default 0,"
sQL = sQL & "nCountSearch int Default 0,"
sQL = sQL & "nWordPrice int Default 0,"
sQL = sQL & "nDegree int Default 0,"
sQL = sQL & "sortRank Int Default 0,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "bodyContent Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Admin"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "Pwd VarChar Default """","
sQL = sQL & "pseudonym VarChar Default """","
sQL = sQL & "adminLevel VarChar Default """","
sQL = sQL & "channel VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "regIP VarChar Default """","
sQL = sQL & "upIP VarChar Default """","
sQL = sQL & "quanXian Text Default """","
sQL = sQL & "verificationMode Int Default 1,"
sQL = sQL & "mtest YesNo Default No,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "ListMenu"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Display YesNo,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "WebSite"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "WebSiteUrl VarChar Default """","
sQL = sQL & "webSiteBottom Text,"
sQL = sQL & "WebSiteFlow int Default 999,"
sQL = sQL & "WebSiteFlowStyle int Default 1,"
sQL = sQL & "WebSiteFlowMedian int Default 6,"
sQL = sQL & "ProductList VarChar Default """","
sQL = sQL & "NewsList VarChar Default """","
sQL = sQL & "NewsDid VarChar Default """","
sQL = sQL & "TZ51La VarChar Default """","
sQL = sQL & "UserEmail VarChar Default """","
sQL = sQL & "ProductDid VarChar Default """","
sQL = sQL & "TemplateIndex Text Default '首页',"
sQL = sQL & "TemplateHome Text Default '内页',"
sQL = sQL & "TemplateMain Text Default '详细页',"
sQL = sQL & "TemplateMain2 Text Default '详细页',"
sQL = sQL & "TemplateMain3 Text Default '详细页',"
sQL = sQL & "UseNumb Text,"
sQL = sQL & "WebRecord VarChar Default """","
sQL = sQL & "ContentWebRecord Text,"
sQL = sQL & "UseHttpUrl VarChar Default """","
sQL = sQL & "TempUseHttpUrl Text,"
sQL = sQL & "WebDate DateTime Default Date(),"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "WebTemplate VarChar Default '\Templates',"
sQL = sQL & "WebSkins VarChar Default '\Skins\Default\',"
sQL = sQL & "WebFolderName VarChar Default 'test3',"
sQL = sQL & "WebImages VarChar Default '\Skins\Default\Images\',"
sQL = sQL & "WebCss VarChar Default '\Skins\Default\Css\',"
sQL = sQL & "WebJs VarChar Default '\Skins\Default\Js\',"
sQL = sQL & "AddWebSite YesNo Default No,"
sQL = sQL & "UpdateHtml YesNo Default No,"
sQL = sQL & "isHtmlFormatting YesNo Default No,"
sQL = sQL & "isWebLabelClose YesNo Default No,"
sQL = sQL & "isCnToEn YesNo Default No,"
sQL = sQL & "flags VarChar Default """","
sQL = sQL & "ModuleSkins VarChar Default """","
sQL = sQL & "FindTpl VarChar Default """","
sQL = sQL & "ReplaceTpl VarChar Default """","
sQL = sQL & "WebCodeFindTpl VarChar Default """","
sQL = sQL & "WebCodeReplaceTpl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "WebHtml VarChar Default 0)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "NavBigClass"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "NavEnglish VarChar Default """","
sQL = sQL & "NavUrl VarChar Default """","
sQL = sQL & "NavType VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Display YesNo,"
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "NavTop YesNo Default Yes,"
sQL = sQL & "NavButtom YesNo,"
sQL = sQL & "NavLeft YesNo,"
sQL = sQL & "NavContent YesNo,"
sQL = sQL & "NavRight YesNo,"
sQL = sQL & "NavOthre YesNo,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "lableTitle VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "NavSmallClass"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "NavUrl VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "NavTitle VarChar Default """","
sQL = sQL & "NavKeywords VarChar Default """","
sQL = sQL & "NavDescription VarChar Default """","
sQL = sQL & "Display YesNo,"
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "lableTitle VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "MainInfo"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "ShowTitle VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Recommend YesNo Default Yes,"
sQL = sQL & "dispalyEditor YesNo Default Yes,"
sQL = sQL & "lableTitle VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "HelpText Text Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "TemplateModule"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "ShowTitle VarChar Default """","
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Recommend YesNo Default Yes,"
sQL = sQL & "dispalyEditor YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "HelpMsg VarChar Default """","
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Job"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "Sex VarChar Default """","
sQL = sQL & "Age VarChar Default """","
sQL = sQL & "Education VarChar Default """","
sQL = sQL & "WorkArea VarChar Default """","
sQL = sQL & "Post VarChar Default """","
sQL = sQL & "Monthly VarChar Default """","
sQL = sQL & "StartDateTime VarChar Default """","
sQL = sQL & "EndDateTime VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "GuestBook"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "GuestName VarChar Default """","
sQL = sQL & "EMail VarChar Default """","
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "QQ VarChar Default """","
sQL = sQL & "Msn VarChar Default """","
sQL = sQL & "Face Int Default 1,"
sQL = sQL & "Through YesNo Default Yes,"
sQL = sQL & "Address VarChar Default """","
sQL = sQL & "IP VarChar Default """","
sQL = sQL & "Reply Text,"
sQL = sQL & "FoZu VarChar Default """","
sQL = sQL & "ToName VarChar Default """","
sQL = sQL & "ToMail VarChar Default """","
sQL = sQL & "ToPhone VarChar Default """","
sQL = sQL & "MyName VarChar Default """","
sQL = sQL & "MyMail VarChar Default """","
sQL = sQL & "MyPhone VarChar Default """","
sQL = sQL & "MyContent VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "FriendLink"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "Alt VarChar Default """","
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "Through YesNo Default Yes,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "noFollow YesNo Default No,"
sQL = sQL & "Sort Int Default 1)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Front"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Content VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Sort int Default 0)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "BigClass"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "Sort int Default 0,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "ArticleListStyle VarChar Default """","
sQL = sQL & "ArticlePageSize VarChar Default """","
sQL = sQL & "ArticleInfoStyle VarChar Default """","
sQL = sQL & "ArticleInfoPhotoWidth VarChar Default """","
sQL = sQL & "ArticleInfoPhotoHeight VarChar Default """","
sQL = sQL & "AddSortType VarChar Default """","
sQL = sQL & "OrderSortType VarChar Default """","
sQL = sQL & "TimeSortType VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SmallClass"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "UpLoadFiles VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "ArticleListStyle VarChar Default """","
sQL = sQL & "ArticlePageSize VarChar Default """","
sQL = sQL & "ArticleInfoStyle VarChar Default """","
sQL = sQL & "ArticleInfoPhotoWidth VarChar Default """","
sQL = sQL & "ArticleInfoPhotoHeight VarChar Default """","
sQL = sQL & "AddSortType VarChar Default """","
sQL = sQL & "OrderSortType VarChar Default """","
sQL = sQL & "TimeSortType VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "ThreeClass"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "ThreeClassName VarChar Default """","
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "ArticleListStyle VarChar Default """","
sQL = sQL & "ArticlePageSize VarChar Default """","
sQL = sQL & "ArticleInfoStyle VarChar Default """","
sQL = sQL & "ArticleInfoPhotoWidth VarChar Default """","
sQL = sQL & "ArticleInfoPhotoHeight VarChar Default """","
sQL = sQL & "AddSortType VarChar Default """","
sQL = sQL & "OrderSortType VarChar Default """","
sQL = sQL & "TimeSortType VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Product"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "ThreeClassName VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Recommend YesNo Default Yes,"
sQL = sQL & "HomeRecommend YesNo Default Yes,"
sQL = sQL & "Through YesNo Default No,"
sQL = sQL & "Hot YesNo Default No,"
sQL = sQL & "Occasions VarChar Default """","
sQL = sQL & "Hotline VarChar Default """","
sQL = sQL & "Model VarChar Default """","
sQL = sQL & "Author VarChar Default """","
sQL = sQL & "ArticleSource VarChar Default """","
sQL = sQL & "Price Int Default 0,"
sQL = sQL & "NewPrice Int Default 0,"
sQL = sQL & "MemberPrice Int Default 0,"
sQL = sQL & "Sold Int Default 0,"
sQL = sQL & "MemberType VarChar Default """","
sQL = sQL & "MemberUser VarChar Default """","
sQL = sQL & "Hits Int Default 0,"
sQL = sQL & "BigFiles VarChar Default """","
sQL = sQL & "SmallFiles VarChar Default """","
sQL = sQL & "TitleAlt VarChar Default """","
sQL = sQL & "BigFilesAlt VarChar Default """","
sQL = sQL & "SmallFilesAlt VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "ProductAbout Text,"
sQL = sQL & "ArticleDescription Text,"
sQL = sQL & "HttpUrl VarChar Default """","
sQL = sQL & "RecordUrl VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "noFollow int Default 0,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "nCount Int Default 0,"
sQL = sQL & "X Int Default 0,"
sQL = sQL & "Y Int Default 0,"
sQL = sQL & "InfoId Int Default 0,"
sQL = sQL & "WBChouTi Int Default 0,"
sQL = sQL & "ExpireTime Int Default 6000,"
sQL = sQL & "JinXinName VarChar Default """","
sQL = sQL & "ArticleInfoStyle VarChar Default """","
sQL = sQL & "ArticleInfoPhotoWidth VarChar Default """","
sQL = sQL & "ArticleInfoPhotoHeight VarChar Default """","
sQL = sQL & "RelatedTags VarChar Default """","
sQL = sQL & "TopModule VarChar Default """","
sQL = sQL & "BottomModule VarChar Default """","
sQL = sQL & "LeftModule VarChar Default """","
sQL = sQL & "MiddleModule VarChar Default """","
sQL = sQL & "RightModule VarChar Default """","
sQL = sQL & "CustomAUrl VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Feedback"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "GuestName VarChar Default """","
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "Fax VarChar Default """","
sQL = sQL & "EMail VarChar Default """","
sQL = sQL & "Mobile VarChar Default """","
sQL = sQL & "QQ VarChar Default """","
sQL = sQL & "MSN VarChar Default """","
sQL = sQL & "Company VarChar Default """","
sQL = sQL & "Address VarChar Default """","
sQL = sQL & "IP VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "QQMSN"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "WebSite VarChar Default """","
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "QQNumber VarChar Default """","
sQL = sQL & "QQName VarChar Default """","
sQL = sQL & "MSNNumber VarChar Default """","
sQL = sQL & "MSNName VarChar Default """","
sQL = sQL & "QQStyle Int,"
sQL = sQL & "QqPicture Int,"
sQL = sQL & "Display YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "OnLineQQ"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "QQ VarChar Default """","
sQL = sQL & "IsOnlineChat YesNo Default No,"
sQL = sQL & "IsAddFriend YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Vote"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Option1 VarChar Default """","
sQL = sQL & "Option2 VarChar Default """","
sQL = sQL & "Option3 VarChar Default """","
sQL = sQL & "Option4 VarChar Default """","
sQL = sQL & "Option5 VarChar Default """","
sQL = sQL & "Option6 VarChar Default """","
sQL = sQL & "Num1 Int,"
sQL = sQL & "Num2 Int,"
sQL = sQL & "Num3 Int,"
sQL = sQL & "Num4 Int,"
sQL = sQL & "Num5 Int,"
sQL = sQL & "Num6 Int,"
sQL = sQL & "Display YesNo Default Yes,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "VoteType YesNo Default Yes)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Member"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "Pwd VarChar Default """","
sQL = sQL & "YunPwd VarChar Default """","
sQL = sQL & "Sex VarChar Default '男',"
sQL = sQL & "Age Int Default 18,"
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "Phone VarChar Default """","
sQL = sQL & "Fax VarChar Default """","
sQL = sQL & "Email VarChar Default """","
sQL = sQL & "ZipCode VarChar Default """","
sQL = sQL & "Address VarChar Default """","
sQL = sQL & "Company VarChar Default """","
sQL = sQL & "RegIP VarChar Default """","
sQL = sQL & "logIp VarChar Default """","
sQL = sQL & "LoginNumb Int Default 0,"
sQL = sQL & "LoginTime DateTime Default Date(),"
sQL = sQL & "LastLoginTime DateTime Default Date(),"
sQL = sQL & "Scene VarChar Default """","
sQL = sQL & "SceneMap VarChar Default """","
sQL = sQL & "RenJB Int Default 1,"
sQL = sQL & "FoBi Int Default 1,"
sQL = sQL & "MyName VarChar Default """","
sQL = sQL & "MyMoney Int Default '666',"
sQL = sQL & "Deposit Int Default 0,"
sQL = sQL & "RenHP Int Default 10,"
sQL = sQL & "RenMP Int Default 10,"
sQL = sQL & "RenEXP Int Default 1,"
sQL = sQL & "WBChouTi Int Default 0,"
sQL = sQL & "TheX VarChar Default """","
sQL = sQL & "TheY VarChar Default """","
sQL = sQL & "OpenID VarChar Default """","
sQL = sQL & "Access_Token VarChar Default """","
sQL = sQL & "QQPhoto VarChar Default """","
sQL = sQL & "Province VarChar Default """","
sQL = sQL & "City VarChar Default """","
sQL = sQL & "Area VarChar Default """","
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "banner VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Content Text Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default Yes)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Payment"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "MemberId VarChar Default """","
sQL = sQL & "Sex VarChar Default '男',"
sQL = sQL & "Age Int Default 18,"
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "Phone VarChar Default """","
sQL = sQL & "Fax VarChar Default """","
sQL = sQL & "Email VarChar Default """","
sQL = sQL & "ZipCode VarChar Default """","
sQL = sQL & "Address VarChar Default """","
sQL = sQL & "Company VarChar Default """","
sQL = sQL & "QQMSN VarChar Default """","
sQL = sQL & "Ip VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Previeworder"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "MemberId VarChar Default """","
sQL = sQL & "OrderId VarChar Default """","
sQL = sQL & "ProductId VarChar Default """","
sQL = sQL & "title VarChar Default '男',"
sQL = sQL & "Total VarChar Default """","
sQL = sQL & "Price Int Default 18,"
sQL = sQL & "ProductSum VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SearchCount"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Through YesNo Default No,"
sQL = sQL & "webTitle VarChar Default """","
sQL = sQL & "webKeywords VarChar Default """","
sQL = sQL & "webDescription VarChar Default """","
sQL = sQL & "folderName VarChar Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "templatePath VarChar Default """","
sQL = sQL & "target VarChar Default """","
sQL = sQL & "fontColor VarChar Default """","
sQL = sQL & "fontB YesNo Default No,"
sQL = sQL & "OnHtml YesNo Default Yes,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Sort Int Default 1)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "ProductComment"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Pid Int,"
sQL = sQL & "PTitle VarChar Default """","
sQL = sQL & "Content Text,"
sQL = sQL & "Sort Int Default 1,"
sQL = sQL & "Ip VarChar Default """","
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "WebLink"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "Url VarChar Default """","
sQL = sQL & "ImgPath VarChar Default """","
sQL = sQL & "Content Text,"
sQL = sQL & "Sort Int Default 1,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SoftTask"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "Email VarChar Default """","
sQL = sQL & "Content Text,"
sQL = sQL & "FilePath VarChar Default """","
sQL = sQL & "nSort Int Default 1,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "WaterMark"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "WaterMarkText VarChar Default """","
sQL = sQL & "WaterMarkTextPosition VarChar Default """","
sQL = sQL & "TextX Int Default 0,"
sQL = sQL & "TextY Int Default 0,"
sQL = sQL & "nTextSize Int Default 0,"
sQL = sQL & "TextRotation Int Default 0,"
sQL = sQL & "TextColor VarChar Default """","
sQL = sQL & "WaterMarkTypeFace VarChar Default """","
sQL = sQL & "WaterMarkImgPath VarChar Default """","
sQL = sQL & "WaterMarkImgPosition VarChar Default """","
sQL = sQL & "ImgX Int Default 0,"
sQL = sQL & "ImgY Int Default 0,"
sQL = sQL & "WaterMarkImgTransparency Int Default 0,"
sQL = sQL & "ZoomWidth Int Default 0,"
sQL = sQL & "ZoomHeight Int Default 0,"
sQL = sQL & "nSort Int Default 1,"
sQL = sQL & "Content Text,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "InputConfig"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "FrontTitle VarChar Default """","
sQL = sQL & "BackEndTitle VarChar Default """","
sQL = sQL & "FieldName VarChar Default """","
sQL = sQL & "CustomFieldName VarChar Default """","
sQL = sQL & "InputType VarChar Default """","
sQL = sQL & "InputWidth VarChar Default """","
sQL = sQL & "InputHeight VarChar Default """","
sQL = sQL & "VerificationType VarChar Default """","
sQL = sQL & "VerificationMsg VarChar Default """","
sQL = sQL & "TipsText VarChar Default """","
sQL = sQL & "DefaultValue VarChar Default """","
sQL = sQL & "Placeholder VarChar Default """","
sQL = sQL & "ListShow YesNo Default No,"
sQL = sQL & "EditDialogShow YesNo Default No,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Through YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "InputValue"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "Str1 VarChar Default """","
sQL = sQL & "Str2 VarChar Default """","
sQL = sQL & "Str3 VarChar Default """","
sQL = sQL & "Str4 VarChar Default """","
sQL = sQL & "Str5 VarChar Default """","
sQL = sQL & "Str6 VarChar Default """","
sQL = sQL & "Str7 VarChar Default """","
sQL = sQL & "Str8 VarChar Default """","
sQL = sQL & "Str9 VarChar Default """","
sQL = sQL & "Str10 VarChar Default """","
sQL = sQL & "Str11 VarChar Default """","
sQL = sQL & "Str12 VarChar Default """","
sQL = sQL & "Str13 VarChar Default """","
sQL = sQL & "Str14 VarChar Default """","
sQL = sQL & "Str15 VarChar Default """","
sQL = sQL & "Numb1 Int Default 0,"
sQL = sQL & "Numb2 Int Default 0,"
sQL = sQL & "Numb3 Int Default 0,"
sQL = sQL & "Numb4 Int Default 0,"
sQL = sQL & "Numb5 Int Default 0,"
sQL = sQL & "Numb6 Int Default 0,"
sQL = sQL & "Numb7 Int Default 0,"
sQL = sQL & "Numb8 Int Default 0,"
sQL = sQL & "Numb9 Int Default 0,"
sQL = sQL & "TrueFalse1 YesNo Default No,"
sQL = sQL & "TrueFalse2 YesNo Default No,"
sQL = sQL & "TrueFalse3 YesNo Default No,"
sQL = sQL & "TrueFalse4 YesNo Default No,"
sQL = sQL & "TrueFalse5 YesNo Default No,"
sQL = sQL & "TrueFalse6 YesNo Default No,"
sQL = sQL & "TrueFalse7 YesNo Default No,"
sQL = sQL & "TrueFalse8 YesNo Default No,"
sQL = sQL & "TrueFalse9 YesNo Default No,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Through YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
iF 1 = 2 tHEn
tABlENaME = dB_pREfIX & "MyTask"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "SetDate Int Default 1,"
sQL = sQL & "Content Text,"
sQL = sQL & "Reply Text,"
sQL = sQL & "Sort Int Default 1,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Through YesNo Default No)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "Diary"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "Weather VarChar Default """","
sQL = sQL & "Through YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND iF
tABlENaME = dB_pREfIX & "ProductParameter"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "PtTitle VarChar Default """","
sQL = sQL & "PtStart VarChar Default """","
sQL = sQL & "PtEnd VarChar Default """","
sQL = sQL & "PId Int,"
sQL = sQL & "HomeRecommend YesNo Default Yes,"
sQL = sQL & "InfoRecommend YesNo Default Yes,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "PtValue1 VarChar Default """","
sQL = sQL & "PtValue2 VarChar Default """","
sQL = sQL & "PtValue3 VarChar Default """","
sQL = sQL & "PtValue4 VarChar Default """","
sQL = sQL & "PtValue5 VarChar Default """","
sQL = sQL & "PtValue6 VarChar Default """","
sQL = sQL & "PtValue7 VarChar Default """","
sQL = sQL & "PtValue8 VarChar Default """","
sQL = sQL & "PtValue9 VarChar Default """","
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "WebTemplate"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "title VarChar Default """","
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "MbParameter Text,"
sQL = sQL & "Recommend YesNo Default Yes,"
sQL = sQL & "MbUpdate YesNo Default No,"
sQL = sQL & "addDateTime DateTime Default Now(),"
sQL = sQL & "upDateTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
aDDdATa = tRUe
iF aDDdATa = tRUe tHEn
sPLsTR = sPLiT("admin|msd|bb", "|")
fOR eACh s iN sPLsTR
rS.oPEn "Select * From "& dB_pREfIX &"Admin Where UserName='" & s & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("UserName") = s
rS("Pwd") = mYMd5(s)
rS.uPDaTE
eND iF : rS.cLOsE
nEXt
rS.oPEn "Select * From "& dB_pREfIX &"ListMenu", cONn, 1, 3
iF rS.eOF tHEn
sPLsTR = sPLiT("系统管理|导航管理|单面管理|总信息管理|招聘管理|留言管理|友情链接|前台配置|在线反馈|生成HTML|图片水印管理|表单管理", "|")
sPLtRUe = sPLiT("True|True|True|True|True|True|True|False|True|True|False|False", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,Sort,Display) Values('" & sPLsTR(i) & "'," & i & "," & sTRtRUeFAlSEtOInT(sPLtRUe(i)) & ")")
nEXt
bIGcLAsSNaME = "系统管理"
sPLsTR = sPLiT("网站配置,WebSiteConfig.Asp,True|账号管理,AdminManage.Asp,True|Robots在线修改,Robots.Asp,True|404页在线修改,Create404.Asp,False|网站空间统计,WebSiteSpaceStat.Asp,False|数据库备份,Data.Asp?act=BackUp,True|恢复库备份,Data.Asp?act=Resume,True|SQL防注入,SqlIn,Asp,False|网站状态,WebSiteStatus.Asp,False|在线QQ聊天,OnLineQQManage.Asp,True|浮动QQ面板,QQMSN.Asp,False|投票管理,VoteManage.Asp,False|生成HTML,Createhtml.Asp,False|帮助中心,http://t.cn/agGbue,False|上传管理,Admin_UploadFileManage.Asp,False|模板模块管理,TableManage.Asp?TableName=TemplateModule,False|", "|")
fOR i = 0 tO uBOuND(sPLsTR)
s = tRIm(sPLsTR(i))
iF s <> "" tHEn
sPLxX = sPLiT(s, ",")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLxX(0) & "'," & i & "," & sTRtRUeFAlSEtOInT(sPLxX(2)) & ",'" & sPLxX(1) & "')")
eND iF
nEXt
bIGcLAsSNaME = "表单管理"
sPLsTR = sPLiT("表单配置管理,TableManage.Asp?TableName=InputConfig,False|表单内容管理,TableManage.Asp?TableName=InputValue,False|", "|")
fOR i = 0 tO uBOuND(sPLsTR)
s = tRIm(sPLsTR(i))
iF s <> "" tHEn
sPLxX = sPLiT(s, ",")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLxX(0) & "'," & i & "," & sTRtRUeFAlSEtOInT(sPLxX(2)) & ",'" & sPLxX(1) & "')")
eND iF
nEXt
bIGcLAsSNaME = "导航管理"
sPLsTR = sPLiT("导航列表", "|")
sPLuRL = sPLiT("NavManage.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
bIGcLAsSNaME = "单面管理"
sPLsTR = sPLiT("单页列表", "|")
sPLuRL = sPLiT("MainInfo.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
bIGcLAsSNaME = "总信息管理"
sPLsTR = sPLiT("添加信息,Product.Asp?act=ShowAdd,True|信息管理,ProductManage.Asp,True|类别管理,ProductClassManage.Asp,True|订单信息,OrderManage.Asp,False|会员信息,MemberManage.Asp,False|产品参数设置,PParameterGl.Asp,False|产品搜索,SearchGl.Asp,True|", "|")
fOR i = 0 tO uBOuND(sPLsTR)
s = tRIm(sPLsTR(i))
iF s <> "" tHEn
sPLxX = sPLiT(s, ",")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLxX(0) & "'," & i & "," & sTRtRUeFAlSEtOInT(sPLxX(2)) & ",'" & sPLxX(1) & "')")
eND iF
nEXt
bIGcLAsSNaME = "图片水印管理"
sPLsTR = sPLiT("添中水印配置,WaterMark.Asp?act=ShowDialog,True|图片水印管理,WaterMarkManage.Asp,True|给图片加水印,WaterMark.Asp,True", "|")
fOR i = 0 tO uBOuND(sPLsTR)
s = tRIm(sPLsTR(i))
iF s <> "" tHEn
sPLxX = sPLiT(s, ",")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLxX(0) & "'," & i & "," & sTRtRUeFAlSEtOInT(sPLxX(2)) & ",'" & sPLxX(1) & "')")
eND iF
nEXt
sPLsTR = sPLiT("添加信息|信息管理|类别管理|订单信息|会员信息|产品参数设置|产品搜索", "|")
sPLtRUe = sPLiT("True|True|True|False|True|False|True", "|")
sPLuRL = sPLiT("Product.Asp?act=ShowAdd|ProductManage.Asp|ProductClassManage.Asp|OrderManage.Asp|MemberManage.Asp|PParameterGl.Asp|SearchGl.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
nEXt
bIGcLAsSNaME = "招聘管理"
sPLsTR = sPLiT("添加招聘职位|招聘职位管理", "|")
sPLuRL = sPLiT("JobManage.Asp?act=ShowJob|JobManage.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
bIGcLAsSNaME = "留言管理"
sPLsTR = sPLiT("浏览留言", "|")
sPLuRL = sPLiT("GuestBook.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
bIGcLAsSNaME = "友情链接"
sPLsTR = sPLiT("友情链接管理", "|")
sPLuRL = sPLiT("FriendLink.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
bIGcLAsSNaME = "前台配置"
sPLsTR = sPLiT("首页产品|首页新闻|滚动图片|Flash图片", "|")
sPLuRL = sPLiT("Front.Asp?NavName=", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(0) & sPLsTR(i) & "')")
nEXt
bIGcLAsSNaME = "在线反馈"
sPLsTR = sPLiT("反馈信息管理", "|")
sPLuRL = sPLiT("FeedbackManage.Asp", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
bIGcLAsSNaME = "生成HTML"
sPLsTR = sPLiT("HTML管理|生成导航", "|")
sPLuRL = sPLiT("../Inc/Create_Html.Asp?act=default|../Inc/Create_Html.Asp?act=ShowNavList", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "'," & i & ",1,'" & sPLuRL(i) & "')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"NavBigClass", cONn, 1, 3
iF rS.eOF tHEn
sPLsTR = sPLiT("首页|文本|产品|新闻|留言|招聘|反馈|文本", "|")
sPLnAVnAMe = sPLiT("网站首页|公司简介|产品展示|新闻中心|在线留言|人才招聘|在线反馈|联系我们", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"NavBigClass (BigClassName,Sort,NavType,NavTop) Values('" & sPLnAVnAMe(i) & "'," & i & ",'" & sPLsTR(i) & "',1)")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"NavSmallClass", cONn, 1, 3
iF rS.eOF tHEn
nAVcLAsSNaME = "联系我们"
sPLsTR = sPLiT("联系中心|关于我们", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"NavSmallClass (BigClassName,SmallClassName) Values('" & nAVcLAsSNaME & "','" & sPLsTR(i) & "')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"MainInfo", cONn, 1, 3
iF rS.eOF tHEn
sPLsTR = sPLiT("网站公告|联系方式|公司简介", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"MainInfo (Title,ShowTitle,Content) Values('" & sPLsTR(i) & "','" & sPLsTR(i) & "','" & sPLsTR(i) & "内容后台修改！')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"GuestBook", cONn, 1, 3
iF rS.eOF tHEn
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"GuestBook (GuestName,Tel,Through,IP,Content,Reply) Values('小云','021-2222',1,'253.25.365.21','留言内容1','这是回复内容1')")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"GuestBook (GuestName,Tel,Through,IP,Content,Reply) Values('小张','010-1111',0,'127.0.0.1','留言内容22','这是回复内容22')")
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"FriendLink", cONn, 1, 3
iF rS.eOF tHEn
sPLiMG = sPLiT("UploadFiles\yahoo.gif|UploadFiles\baidu.gif|UploadFiles\google.gif||||||||||||||||||||||||||||||||||||||||||||||||||||", "|")
sPLsTR = sPLiT("南京微战略|南京麦思德|南京悠口餐饮", "|")
sPLuRL = sPLiT("http://www.wzl99.com/|http://maiside.net/|http://www.youkoucanyin.com/", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"FriendLink (Title,Alt,Url,ImgPath,Sort,Target) Values('" & sPLsTR(i) & "','" & sPLsTR(i) & "详细说明','" & sPLuRL(i) & "','" & sPLiMG(i) & "'," & i & ",'_blank')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"Front", cONn, 1, 3
iF rS.eOF tHEn
sPLsTR = sPLiT("首页产品|首页新闻|滚动图片|Flash图片", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"Front (Title) Values('" & sPLsTR(i) & "')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"BigClass", cONn, 1, 3
iF rS.eOF tHEn
sPLsTR = sPLiT("产品展示|新闻中心", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"BigClass (BigClassName) Values('" & sPLsTR(i) & "')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"SmallClass", cONn, 1, 3
iF rS.eOF tHEn
bIGcLAsSNaME = "产品展示"
sPLsTR = sPLiT("经典产品|促售产品", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"SmallClass (BigClassName,SmallClassName) Values('" & bIGcLAsSNaME & "','" & sPLsTR(i) & "')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"ThreeClass", cONn, 1, 3
iF rS.eOF tHEn
bIGcLAsSNaME = "产品展示"
sPLsTR = sPLiT("经典子类|经典子类二", "|")
fOR i = 0 tO uBOuND(sPLsTR)
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"ThreeClass (BigClassName,SmallClassName,ThreeClassName) Values('" & bIGcLAsSNaME & "','经典产品','" & sPLsTR(i) & "')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"Product", cONn, 1, 3
iF rS.eOF aND 1 = 2 tHEn
fOR i = 1 tO 6
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"Product(BigClassName,SmallClassName,ThreeClassName,Title,Sort,BigFiles) Values('产品展示','经典产品','经典子类','标题" & i & "'," & i & ",'UpLoadFiles/Pic/" & i & ".jpg')")
nEXt
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"Feedback ", cONn, 1, 3
iF rS.eOF tHEn
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"Feedback (GuestName,Tel,Fax,Email,Content) Values('小张','021-1236548','021-88888','123@qq.com','内容')")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"Feedback (GuestName,Tel,Fax,Email,Content) Values('小李','021-1236548','021-88888','888@qq.com','内容')")
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"Feedback (GuestName,Tel,Fax,Email,Content) Values('小孙','021-1236548','021-88888','456@qq.com','内容')")
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"QQMSN", cONn, 1, 3
iF rS.eOF tHEn
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"QQMSN (Title,WebSite,QQNumber,QQName,MSNNumber,MSNName,QQStyle,Display,QqPicture) Values('在线客服','www.baidu.com','313801120|123456','技术QQ|测试QQ','123456@qq.com','测试MSN',1,1,4)")
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"WebSite", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("webTitle") = "网站标题"
rS("webKeywords") = "网站关键词"
rS("webDescription") = "网站描述"
rS("WebSiteUrl") = "http://www.baidu.com"
rS("WebSiteBottom") = "版权所有 上海子映有限公司 电话：021-66666666 传真：021-8888888<br>联系QQ：313801120 邮箱：313801120@qq.com"
rS("TemplateIndex") = tEMpLAtEInDEx
rS("TemplateHome") = tEMpLAtEHoME
rS("TemplateMain") = tEMpLAtEMaIN
rS("ModuleSkins") = ""
rS.uPDaTE
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"Job", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("Sex") = "无限"
rS("Age") = "18-25"
rS("Education") = "大专"
rS("WorkArea") = "本地"
rS("Post") = "工程师"
rS("Monthly") = "5000-8000"
rS("Content") = "面议"
rS.uPDaTE
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"Vote", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("Title") = "你是从哪里来到本站的？"
rS("Option1") = "百度"
rS("Option2") = "Google"
rS("Option3") = "Yahoo"
rS("Option4") = "其它"
rS("Num1") = 25
rS("Num2") = 42
rS("Num3") = 53
rS("Num4") = 86
rS.uPDaTE
eND iF : rS.cLOsE
rS.oPEn "Select * From "& dB_pREfIX &"Member", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("UserName") = "zy"
rS("Pwd") = "zy"
rS.uPDaTE
eND iF : rS.cLOsE
fOR i = 1 tO 60
cONn.eXEcUTe("Insert Into "& dB_pREfIX &"Payment (UserName) Values('" & i & "')")
nEXt
rS.oPEn "Select * From "& dB_pREfIX &"ProductComment", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("UserName") = "小云"
rS("Title") = "测试标题"
rS("Pid") = 1
rS("PTitle") = "产品标题"
rS("Content") = "评论内容"
rS("Ip") = "168.236.5.69"
rS("Through") = fALsE
rS.uPDaTE
eND iF : rS.cLOsE
cONn.eXEcUTe("Update "& dB_pREfIX &"ListMenu Set Display=0 Where BigClassName='前台配置'")
eND iF
cALl hANdLEmODuLEdATa()
eND sUB
sUB hANdLEmODuLEdATa()
dIM b, c, d
b = gETfTExT("ModuleData.txt")
sPLsTR = sPLiT(b, "----------------------------" & vBCrLF)
fOR eACh c iN sPLsTR
c = tRImVBcRLf(c) & vBCrLF
d = mID(c, 1, iNStR(c, vBCrLF) - 1)
b = mID(c, iNStR(c, vBCrLF) + 1)
cALl eCHo("模块标题Title", d)
rS.oPEn "Select * From "& dB_pREfIX &"TempLateModule Where Title='" & d & "'", cONn, 1, 3
iF rS.eOF tHEn
rS.aDDnEW
rS("Title") = d
rS("Content") = b
rS("DispalyEditor") = fALsE
rS.uPDaTE
eND iF : rS.cLOsE
nEXt
eND sUB
sUB qQAcCEsS()
tABlENaME = dB_pREfIX & "QQ"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "ThreeClassName VarChar Default """","
sQL = sQL & "QQ VarChar Default """","
sQL = sQL & "QQName VarChar Default """","
sQL = sQL & "QQSex VarChar Default """","
sQL = sQL & "Age Int Default 0,"
sQL = sQL & "QQAge Int Default 0,"
sQL = sQL & "Birthday VarChar Default """","
sQL = sQL & "Bloodtype VarChar Default """","
sQL = sQL & "Zodiac VarChar Default """","
sQL = sQL & "Constellation VarChar Default """","
sQL = sQL & "Country VarChar Default """","
sQL = sQL & "Province VarChar Default """","
sQL = sQL & "City VarChar Default """","
sQL = sQL & "Tel VarChar Default """","
sQL = sQL & "Phone VarChar Default """","
sQL = sQL & "Fax VarChar Default """","
sQL = sQL & "Email VarChar Default """","
sQL = sQL & "ZipCode VarChar Default """","
sQL = sQL & "Address VarChar Default """","
sQL = sQL & "VisitorsList Text Default """","
sQL = sQL & "VisitorsNumb Text Default """","
sQL = sQL & "SpacePurview Int Default 0,"
sQL = sQL & "OnLineTime DateTime,"
sQL = sQL & "MutualFriend Int Default 0,"
sQL = sQL & "AddTime DateTime Default Date(),"
sQL = sQL & "UpDateTime DateTime,"
sQL = sQL & "Content Text Default """","
sQL = sQL & "Through Int Default 0)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "QQNameTable"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "QQ VarChar Default """","
sQL = sQL & "QQName VarChar Default """","
sQL = sQL & "AddTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SourceCode"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "ThreeClassName VarChar Default """","
sQL = sQL & "title VarChar Default """","
sQL = sQL & "ZipSize Money Default 0,"
sQL = sQL & "ImgUrl VarChar Default """","
sQL = sQL & "HttpUrl VarChar Default """","
sQL = sQL & "Author VarChar Default """","
sQL = sQL & "UpDateTime DateTime,"
sQL = sQL & "Windows VarChar Default """","
sQL = sQL & "RenQi Int Default 0,"
sQL = sQL & "DownNumb Int Default 0,"
sQL = sQL & "ReplyNumb Int Default 0,"
sQL = sQL & "AddTime DateTime Default Date(),"
sQL = sQL & "Content Text Default """","
sQL = sQL & "Through Int Default 0)"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SMSInfo"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "DXName VarChar Default """","
sQL = sQL & "ToName VarChar Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Date(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
sUB aDMiNLoG()
tABlENaME = dB_pREfIX & "AdminLog"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "GoToUrl VarChar Default """","
sQL = sQL & "ThisUrl VarChar Default """","
sQL = sQL & "TableName VarChar Default """","
sQL = sQL & "EditId VarChar Default """","
sQL = sQL & "IP VarChar Default """","
sQL = sQL & "IE VarChar Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Date(),"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "AdminNimble"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "GoToUrl VarChar Default """","
sQL = sQL & "ThisUrl VarChar Default """","
sQL = sQL & "TableName VarChar Default """","
sQL = sQL & "EditId VarChar Default """","
sQL = sQL & "IP VarChar Default """","
sQL = sQL & "IE VarChar Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Date(),"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
sUB aSKdAAcCEsS()
tABlENaME = dB_pREfIX & "AskDa"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "Ask Text Default """","
sQL = sQL & "Da Text Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Date(),"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
sUB zNRoBOtACcESs()
tABlENaME = dB_pREfIX & "ZNRobot"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "SmallClassName VarChar Default """","
sQL = sQL & "ThreeClassName VarChar Default """","
sQL = sQL & "title Text Default """","
sQL = sQL & "Other1 VarChar Default """","
sQL = sQL & "Other2 VarChar Default """","
sQL = sQL & "Other3 VarChar Default """","
sQL = sQL & "Other4 VarChar Default """","
sQL = sQL & "Other5 VarChar Default """","
sQL = sQL & "Hui Text Default """","
sQL = sQL & "Hui2 VarChar Default """","
sQL = sQL & "Hui3 VarChar Default """","
sQL = sQL & "Hui4 VarChar Default """","
sQL = sQL & "Hui5 VarChar Default """","
sQL = sQL & "JB Int Default 9,"
sQL = sQL & "Sort Int Default 0,"
sQL = sQL & "RelatedTags VarChar Default """","
sQL = sQL & "TitleTags Text Default """","
sQL = sQL & "Notes Text Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Date(),"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
sUB cOMpUTeRDiR()
tABlENaME = dB_pREfIX & "ComputerDir"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "FilePath Text Default """","
sQL = sQL & "fileName VarChar Default """","
sQL = sQL & "FileSize Text Default """","
sQL = sQL & "FileType Text Default """","
sQL = sQL & "FileContent Image Default """","
sQL = sQL & "FileAddData DateTime Default Date(),"
sQL = sQL & "FileEditData DateTime Default Date(),"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
sUB wEBsOFtACcESs()
tABlENaME = dB_pREfIX & "SoftUser"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "Pwd VarChar Default """","
sQL = sQL & "FullName VarChar Default """","
sQL = sQL & "RegDateTime DateTime Default Now(),"
sQL = sQL & "UpDateTime DateTime Default Now(),"
sQL = sQL & "RegIP VarChar Default """","
sQL = sQL & "UpIP VarChar Default """","
sQL = sQL & "QuanXian Text Default """","
sQL = sQL & "DayLoginErrCount Int Default 0,"
sQL = sQL & "LimitDayLoginErrCount Int Default 0,"
sQL = sQL & "LoginErrCount Int Default 0,"
sQL = sQL & "LoginCount Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SoftAction"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "title Text Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "SoftLog"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "UserName VarChar Default """","
sQL = sQL & "title Text Default """","
sQL = sQL & "ActionType Text Default """","
sQL = sQL & "IP VarChar Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
tABlENaME = dB_pREfIX & "RemoteUserStat"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "GoToUrl VarChar Default """","
sQL = sQL & "ThisUrl VarChar Default """","
sQL = sQL & "IP VarChar Default """","
sQL = sQL & "IE VarChar Default """","
sQL = sQL & "XP VarChar Default """","
sQL = sQL & "Windows VarChar Default """","
sQL = sQL & "Screen VarChar Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Date(),"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
sUB cAIcONfIG()
tABlENaME = dB_pREfIX & "CaiConfig"
iF sHOwIStABlE(tABlENaME) = fALsE tHEn
sQL = "Create Table " & tABlENaME & " (Id int Identity(0,1) Primary Key,"
sQL = sQL & "BigClassName VarChar Default """","
sQL = sQL & "TableName VarChar Default """","
sQL = sQL & "CheckSql VarChar Default """","
sQL = sQL & "SearchValue VarChar Default """","
sQL = sQL & "CaiConfigUrl VarChar Default """","
sQL = sQL & "StartPage VarChar Default """","
sQL = sQL & "EndPage VarChar Default """","
sQL = sQL & "PageAction VarChar Default """","
sQL = sQL & "nThisPage Int Default 0,"
sQL = sQL & "nCountPage Int Default 0,"
sQL = sQL & "StartBody VarChar Default """","
sQL = sQL & "EndBody VarChar Default """","
sQL = sQL & "StartList VarChar Default """","
sQL = sQL & "EndList VarChar Default """","
sQL = sQL & "LableName1 VarChar Default """","
sQL = sQL & "FieldName1 VarChar Default """","
sQL = sQL & "Action1 VarChar Default """","
sQL = sQL & "Start1 VarChar Default """","
sQL = sQL & "End1 VarChar Default """","
sQL = sQL & "LableName2 VarChar Default """","
sQL = sQL & "FieldName2 VarChar Default """","
sQL = sQL & "Action2 VarChar Default """","
sQL = sQL & "Start2 VarChar Default """","
sQL = sQL & "End2 VarChar Default """","
sQL = sQL & "LableName3 VarChar Default """","
sQL = sQL & "FieldName3 VarChar Default """","
sQL = sQL & "Action3 VarChar Default """","
sQL = sQL & "Start3 VarChar Default """","
sQL = sQL & "End3 VarChar Default """","
sQL = sQL & "LableName4 VarChar Default """","
sQL = sQL & "FieldName4 VarChar Default """","
sQL = sQL & "Action4 VarChar Default """","
sQL = sQL & "Start4 VarChar Default """","
sQL = sQL & "End4 VarChar Default """","
sQL = sQL & "LableName5 VarChar Default """","
sQL = sQL & "FieldName5 VarChar Default """","
sQL = sQL & "Action5 VarChar Default """","
sQL = sQL & "Start5 VarChar Default """","
sQL = sQL & "End5 VarChar Default """","
sQL = sQL & "LableName6 VarChar Default """","
sQL = sQL & "FieldName6 VarChar Default """","
sQL = sQL & "Action6 VarChar Default """","
sQL = sQL & "Start6 VarChar Default """","
sQL = sQL & "End6 VarChar Default """","
sQL = sQL & "LableName7 VarChar Default """","
sQL = sQL & "FieldName7 VarChar Default """","
sQL = sQL & "Action7 VarChar Default """","
sQL = sQL & "Start7 VarChar Default """","
sQL = sQL & "End7 VarChar Default """","
sQL = sQL & "LableName8 VarChar Default """","
sQL = sQL & "FieldName8 VarChar Default """","
sQL = sQL & "Action8 VarChar Default """","
sQL = sQL & "Start8 VarChar Default """","
sQL = sQL & "End8 VarChar Default """","
sQL = sQL & "LableName9 VarChar Default """","
sQL = sQL & "FieldName9 VarChar Default """","
sQL = sQL & "Action9 VarChar Default """","
sQL = sQL & "Start9 VarChar Default """","
sQL = sQL & "End9 VarChar Default """","
sQL = sQL & "LableName10 VarChar Default """","
sQL = sQL & "FieldName10 VarChar Default """","
sQL = sQL & "Action10 VarChar Default """","
sQL = sQL & "Start10 VarChar Default """","
sQL = sQL & "End10 VarChar Default """","
sQL = sQL & "LableName11 VarChar Default """","
sQL = sQL & "FieldName11 VarChar Default """","
sQL = sQL & "Action11 VarChar Default """","
sQL = sQL & "Start11 VarChar Default """","
sQL = sQL & "End11 VarChar Default """","
sQL = sQL & "LableName12 VarChar Default """","
sQL = sQL & "FieldName12 VarChar Default """","
sQL = sQL & "Action12 VarChar Default """","
sQL = sQL & "Start12 VarChar Default """","
sQL = sQL & "End12 VarChar Default """","
sQL = sQL & "AddTime DateTime Default Now(),"
sQL = sQL & "EditTime DateTime Default Now(),"
sQL = sQL & "AddDate DateTime Default Now(),"
sQL = sQL & "EditData DateTime Default Now(),"
sQL = sQL & "EditCount Int Default 0,"
sQL = sQL & "ViewCount Int Default 0,"
sQL = sQL & "Through Int Default 0,"
sQL = sQL & "Content Text Default """")"
iF mDBpATh = "" tHEn sQL = hANdLEsQLsERvER(sQL)
cONn.eXEcUTe sQL
eND iF
eND sUB
eND cLAsS
%>


