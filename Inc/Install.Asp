<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-17
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#Include File = "Config.Asp"-->
<%
Dim ObjAccess : Set ObjAccess = new ClassAccess

    Select Case Request("act")
        Case "Web", "web" : MDBPath = ".."& adminDir &"Data/Data.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.WebData()
        Case "addwebtable" : MDBPath = ".."& adminDir &"Data/Data.mdb" : Call OpenConn() :Call ObjAccess.WebData()
        Case "CreateRemoteSqlServerDatabase" : Call CreateRemoteSqlServerDatabase()
        Case "QQ", "qq", "Qq" : MDBPath = "../Help/QQData.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.QQAccess()
        Case "AdminLog" : MDBPath = ".."& adminDir &"Data/AdminLog.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.AdminLog()
        Case "AskDa" : MDBPath = "../../网站备份/数据库/AskDa.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.AskDaAccess()
        Case "ZNRobot" : MDBPath = "../../网站备份/数据库/ZNRobot.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.ZNRobotAccess()
        Case "ComputerDir" : MDBPath = "../../网站备份/数据库/ComputerDir.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.ComputerDir()
        Case "WebSoftAccess" : MDBPath = "../Web_Soft/WebSoftAccess.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.WebSoftAccess()
        Case "CaiConfig" : MDBPath = "../../网站备份/数据库/CaiConfig.mdb" : Call ObjAccess.defaultDisplay() : Call ObjAccess.CaiConfig()

        Case Else defaultDisplay()
    End Select
Set ObjAccess = Nothing

Sub defaultDisplay()
	dim b
	b="<a href='?act=web&DB_PREFIX=xy_' target='_blank'>点击创建(本地Access)</a> | <a href='?act=addwebtable&DB_PREFIX=test_' target='_blank'>追加test_前缀表</a>"
	b=b & " | <a href='?act=addwebtable' target='_blank'>追加前缀表</a>"
    Call echo("创建网站数据库", b)
    Call echo("创建QQ数据库", "<a href=?act=qq>点击创建</a>")
    Call echo("创建网站日志(AdminLog)数据库20150218", "<a href=?act=AdminLog>点击创建</a>")
    Call echo("创建自己问答(AskDa)数据库", "<a href=?act=AskDa>点击创建</a>")
    Call echo("创建智能机器人(ZNRobot)数据库", "<a href=?act=ZNRobot>点击创建</a>")
    Call echo("创建(ComputerDir)数据库", "<a href=?act=ComputerDir>点击创建</a>")
    Call echo("创建(WebSoftAccess)数据库", "<a href=?act=WebSoftAccess>点击创建</a>")
    Call echo("创建远程SqlServer数据库", "<a href=?act=CreateRemoteSqlServerDatabase>点击创建(SQLServer本地与远程20141120)</a>")
    Call echo("创建(CaiConfig)【采集配置】数据库", "<a href=?act=CaiConfig>点击创建</a>")
    Call rw("<hr>")
    Call echo("创建(WebUrlScan)数据库", "<a href=/e/E盘/WEB网站/网站备份/数据库/WebUrlScan.Asp?act=CreateAccess>进入WebUrlScan.Asp</a>")
End Sub

Sub createRemoteSqlServerDatabase()
    MDBPath = ""
    If 1 = 2 Then
        DatabaseType = "SqlServer"
        SqlServerHostIP = "hds-113.hichina.com,1433"
        SqlServerDatabaseName = "hds1130012_db"
        SqlServerUsername = "hds1130012"
        SqlServerPassword = "L4dN4eRd"
    Else
        DatabaseType = "SqlServerWebData"
        DatabaseType = "RemoteSqlServer20150727"
    End If

    Call OpenConn()
    Call ObjAccess.WebData()
End Sub

Class ClassAccess
    Dim tableName, sql, AddData, splStr, splxx, i, s, SplTrue, BigClassName
    Dim SplUrl, SplNavName, NavClassName, SplImg, TemplateIndex, TemplateHome, TemplateMain
	dim DB_PREFIX

    Sub defaultDisplay()
        MDBPath = HandlePath(MDBPath)
        Call deleteFile(MDBPath)
        If ExistsFile(MDBPath) = False Then CreateMdb(MDBPath)
        Call OpenConn()
    End Sub


    Sub webData()	
	DB_PREFIX=request("DB_PREFIX")
	call echo("DB_PREFIX",DB_PREFIX)

        tableName = DB_PREFIX & "WebColumn"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"

            sql = sql & "columnName VarChar Default """","
            sql = sql & "columnEnName VarChar Default """","
            sql = sql & "columnType VarChar Default """","
            sql = sql & "parentId int Default -1,"
            sql = sql & "topId int Default -1,"
            sql = sql & "sortRank int Default 0,"
            sql = sql & "views int Default 0,"
            sql = sql & "adminId int Default 0,"

            sql = sql & "isDisplay YesNo,"
            sql = sql & "smallImage VarChar Default """","
            sql = sql & "bigImage VarChar Default """","
            sql = sql & "bannerImage VarChar Default """","

            sql = sql & "flags VarChar Default """","
            sql = sql & "showTitle VarChar Default """","
            sql = sql & "lableTitle VarChar Default """","


            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "noFollow int Default 0,"
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "isMakeHtml YesNo Default Yes,"



            sql = sql & "topModule VarChar Default """","
            sql = sql & "bottomModule VarChar Default """","
            sql = sql & "leftModule VarChar Default """","
            sql = sql & "middleModule VarChar Default """","
            sql = sql & "rightModule VarChar Default """","


            sql = sql & "customAUrl VarChar Default """","


            sql = sql & "nPageSize int Default 10,"

            sql = sql & "isHtml YesNo Default false,"
            sql = sql & "isOnHtml YesNo Default Yes,"                                 		

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"


            sql = sql & "noteInfo Text Default """","
			
            sql = sql & "simpleIntroduction Text Default """","
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "ArticleDetail"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "parentId int Default -1,"
            sql = sql & "topId int Default -1,"
            sql = sql & "sortRank int Default 0,"
            sql = sql & "views int Default 0,"
            sql = sql & "adminId int Default 0,"

            sql = sql & "smallImage VarChar Default """","
            sql = sql & "bigImage VarChar Default """","
            sql = sql & "bannerImage VarChar Default """","


            sql = sql & "title VarChar Default """","
            sql = sql & "titleColor VarChar Default """","
            sql = sql & "lableTitle VarChar Default """","

            sql = sql & "isCheck YesNo Default No,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"

            sql = sql & "Occasions VarChar Default """","
            sql = sql & "Hotline VarChar Default """","
            sql = sql & "Model VarChar Default """","
            sql = sql & "Author VarChar Default """","
            sql = sql & "ArticleSource VarChar Default """","

            sql = sql & "Price Int Default 0,"
            sql = sql & "NewPrice Int Default 0,"
            sql = sql & "MemberPrice Int Default 0,"
            sql = sql & "Sold Int Default 0,"

            sql = sql & "MemberType VarChar Default """","
            sql = sql & "MemberUser VarChar Default """","
            sql = sql & "Hits Int Default 0,"

            sql = sql & "TitleAlt VarChar Default """","
            sql = sql & "BigFilesAlt VarChar Default """","
            sql = sql & "SmallFilesAlt VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "ProductAbout Text,"
            sql = sql & "ArticleDescription Text,"

            sql = sql & "HttpUrl VarChar Default """","
            sql = sql & "RecordUrl VarChar Default """","
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "noFollow int Default 0,"

            sql = sql & "flags VarChar Default """","

            sql = sql & "isHtml YesNo Default false,"
            sql = sql & "isOnHtml YesNo Default Yes,"                                 		
            sql = sql & "nCount Int Default 0,"



            sql = sql & "ArticleInfoStyle VarChar Default """","
            sql = sql & "ArticleInfoPhotoWidth VarChar Default """","
            sql = sql & "ArticleInfoPhotoHeight VarChar Default """","


            sql = sql & "RelatedTags VarChar Default """","
            sql = sql & "weight Int Default 0,"




            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","


            sql = sql & "CustomAUrl VarChar Default """","
			
            sql = sql & "noteInfo Text Default """","
            sql = sql & "simpleIntroduction Text Default """","
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
		

        tableName = DB_PREFIX & "OnePage"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "displayTitle VarChar Default """","
            sql = sql & "adminId int Default 0,"

            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "sortRank Int Default 0,"
            sql = sql & "views int Default 0,"
            sql = sql & "isRecommend YesNo Default Yes,"
            sql = sql & "dispalyEditor YesNo Default Yes,"
            sql = sql & "lableTitle VarChar Default """","

            sql = sql & "isHtml YesNo Default false,"
            sql = sql & "isOnHtml YesNo Default Yes,"                                 		
			
            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"


            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","
            sql = sql & "HelpText Text Default """","


            sql = sql & "customAUrl VarChar Default """","
            sql = sql & "noteInfo Text Default """","
            sql = sql & "simpleIntroduction Text Default """","
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
		

        tableName = DB_PREFIX & "TableComment"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "UserID Int Default 0,"                                    			
            sql = sql & "itemID Int Default 0,"
            sql = sql & "parentId int Default -1,"
			sql = sql & "tableName VarChar Default """","
            sql = sql & "UserName VarChar Default """","
            sql = sql & "title VarChar Default """","
            sql = sql & "EMail VarChar Default """","
            sql = sql & "Tel VarChar Default """","
            sql = sql & "ip VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
			
            sql = sql & "Reply Text Default """","
            sql = sql & "noteInfo Text Default """","
			
            sql = sql & "Through Int Default 0,"
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
		

        tableName = DB_PREFIX & "WebsiteStat"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
			sql = sql & "visiturl VarChar Default """","
            sql = sql & "viewurl VarChar Default """","
            sql = sql & "browser VarChar Default """","
            sql = sql & "operatingSystem VarChar Default """","
            sql = sql & "screenWH VarChar Default """","
            sql = sql & "moreInfo VarChar Default """","
            sql = sql & "viewDateTime DateTime Default Now(),"
            sql = sql & "ip VarChar Default """","

            sql = sql & "dateClass VarChar Default """","
			
            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
			

			
            sql = sql & "Through Int Default 0,"
            sql = sql & "noteInfo Text Default """","
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "webLayout"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "layoutName VarChar Default """","
            sql = sql & "layoutList VarChar Default """","
            sql = sql & "replaceStyle VarChar Default """","
            sql = sql & "actionContent Text Default """","

            sql = sql & "sortRank int Default 0,"
            sql = sql & "isDisplay YesNo,"
            sql = sql & "author VarChar Default """","
            sql = sql & "views int Default 0,"
            sql = sql & "adminId int Default 0,"


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"

            sql = sql & "simpleIntroduction Text Default """","
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "webModule"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "moduleType VarChar Default """","
            sql = sql & "moduleName VarChar Default """","
            sql = sql & "title VarChar Default """","
            sql = sql & "sortRank int Default 0,"
            sql = sql & "isDisplay YesNo,"
            sql = sql & "author VarChar Default """","
            sql = sql & "views int Default 0,"
            sql = sql & "adminId int Default 0,"


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"

            sql = sql & "simpleIntroduction Text Default """","
            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Bidding"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "searchWords VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "showReason VarChar Default """","
            sql = sql & "nComputerSearch int Default 0,"
            sql = sql & "nMoblieSearch int Default 0,"
            sql = sql & "nCountSearch int Default 0,"

            sql = sql & "nWordPrice int Default 0,"
            sql = sql & "nDegree int Default 0,"

            sql = sql & "sortRank Int Default 0,"
            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"


            sql = sql & "bodyContent Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
		

        tableName = DB_PREFIX & "Admin"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "UserName VarChar Default """","
            sql = sql & "Pwd VarChar Default """","

            sql = sql & "pseudonym VarChar Default """","
            sql = sql & "adminLevel VarChar Default """","
            sql = sql & "channel VarChar Default """","


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"

            sql = sql & "regIP VarChar Default """","
            sql = sql & "upIP VarChar Default """","
            sql = sql & "quanXian Text Default """","
            sql = sql & "verificationMode Int Default 1,"

            sql = sql & "mtest YesNo Default No,"
			

            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "ListMenu"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "Url VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "Display YesNo,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "WebSite"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "WebSiteUrl VarChar Default """","
            sql = sql & "webSiteBottom Text,"
            sql = sql & "WebSiteFlow int Default 999,"
            sql = sql & "WebSiteFlowStyle int Default 1,"
            sql = sql & "WebSiteFlowMedian int Default 6,"
            sql = sql & "ProductList VarChar Default """","
            sql = sql & "NewsList VarChar Default """","
            sql = sql & "NewsDid VarChar Default """","

            sql = sql & "TZ51La VarChar Default """","
            sql = sql & "UserEmail VarChar Default """","
            sql = sql & "ProductDid VarChar Default """","
            sql = sql & "TemplateIndex Text Default '首页',"
            sql = sql & "TemplateHome Text Default '内页',"
            sql = sql & "TemplateMain Text Default '详细页',"
            sql = sql & "TemplateMain2 Text Default '详细页',"
            sql = sql & "TemplateMain3 Text Default '详细页',"
            sql = sql & "UseNumb Text,"

            sql = sql & "WebRecord VarChar Default """","
            sql = sql & "ContentWebRecord Text,"

            sql = sql & "UseHttpUrl VarChar Default """","
            sql = sql & "TempUseHttpUrl Text,"
            sql = sql & "WebDate DateTime Default Date(),"

            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","

            sql = sql & "WebTemplate VarChar Default '\Templates',"
            sql = sql & "WebSkins VarChar Default '\Skins\Default\',"

            sql = sql & "WebFolderName VarChar Default 'test3',"


            sql = sql & "WebImages VarChar Default '\Skins\Default\Images\',"
            sql = sql & "WebCss VarChar Default '\Skins\Default\Css\',"
            sql = sql & "WebJs VarChar Default '\Skins\Default\Js\',"

            sql = sql & "AddWebSite YesNo Default No,"
            sql = sql & "UpdateHtml YesNo Default No,"
            sql = sql & "isHtmlFormatting YesNo Default No,"
            sql = sql & "isWebLabelClose YesNo Default No,"
            sql = sql & "isCnToEn YesNo Default No,"
            sql = sql & "flags VarChar Default """","



            sql = sql & "ModuleSkins VarChar Default """","
            sql = sql & "FindTpl VarChar Default """","
            sql = sql & "ReplaceTpl VarChar Default """","

            sql = sql & "WebCodeFindTpl VarChar Default """","
            sql = sql & "WebCodeReplaceTpl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"


            sql = sql & "WebHtml VarChar Default 0)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql



        End If

        tableName = DB_PREFIX & "NavBigClass"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "NavEnglish VarChar Default """","
            sql = sql & "NavUrl VarChar Default """","
            sql = sql & "NavType VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "Display YesNo,"
            sql = sql & "ImgPath VarChar Default """","
            sql = sql & "NavTop YesNo Default Yes,"
            sql = sql & "NavButtom YesNo,"
            sql = sql & "NavLeft YesNo,"
            sql = sql & "NavContent YesNo,"
            sql = sql & "NavRight YesNo,"
            sql = sql & "NavOthre YesNo,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "lableTitle VarChar Default """","



            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","


            sql = sql & "CustomAUrl VarChar Default """","


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"

            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "NavSmallClass"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "NavUrl VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "NavTitle VarChar Default """","
            sql = sql & "NavKeywords VarChar Default """","
            sql = sql & "NavDescription VarChar Default """","
            sql = sql & "Display YesNo,"
            sql = sql & "ImgPath VarChar Default """","


            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "lableTitle VarChar Default """","


            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","

            sql = sql & "CustomAUrl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "MainInfo"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "ShowTitle VarChar Default """","
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "Sort Int Default 0,"
            sql = sql & "Recommend YesNo Default Yes,"
            sql = sql & "dispalyEditor YesNo Default Yes,"
            sql = sql & "lableTitle VarChar Default """","


            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","

            sql = sql & "HelpText Text Default """","


            sql = sql & "CustomAUrl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "TemplateModule"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "ShowTitle VarChar Default """","
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "Sort Int Default 0,"
            sql = sql & "Recommend YesNo Default Yes,"
            sql = sql & "dispalyEditor YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "HelpMsg VarChar Default """","
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "Job"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "Sex VarChar Default """","
            sql = sql & "Age VarChar Default """","
            sql = sql & "Education VarChar Default """","
            sql = sql & "WorkArea VarChar Default """","
            sql = sql & "Post VarChar Default """","
            sql = sql & "Monthly VarChar Default """","
            sql = sql & "StartDateTime VarChar Default """","
            sql = sql & "EndDateTime VarChar Default """","
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "OnHtml YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "GuestBook"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "GuestName VarChar Default """","
            sql = sql & "EMail VarChar Default """","
            sql = sql & "Tel VarChar Default """","
            sql = sql & "QQ VarChar Default """","
            sql = sql & "Msn VarChar Default """","
            sql = sql & "Face Int Default 1,"
            sql = sql & "Through YesNo Default Yes,"
            sql = sql & "Address VarChar Default """","
            sql = sql & "IP VarChar Default """","
            sql = sql & "Reply Text,"
            sql = sql & "FoZu VarChar Default """","
            sql = sql & "ToName VarChar Default """","
            sql = sql & "ToMail VarChar Default """","
            sql = sql & "ToPhone VarChar Default """","
            sql = sql & "MyName VarChar Default """","
            sql = sql & "MyMail VarChar Default """","
            sql = sql & "MyPhone VarChar Default """","
            sql = sql & "MyContent VarChar Default """","
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "OnHtml YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "FriendLink"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "Url VarChar Default """","
            sql = sql & "Alt VarChar Default """","
            sql = sql & "ImgPath VarChar Default """","
            sql = sql & "Through YesNo Default Yes,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "noFollow YesNo Default No,"

            sql = sql & "Sort Int Default 1)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Front"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "Content VarChar Default """","
            sql = sql & "Url VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Sort int Default 0)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "BigClass"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "ImgPath VarChar Default """","
            sql = sql & "Url VarChar Default """","
            sql = sql & "Sort int Default 0,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"



            sql = sql & "ArticleListStyle VarChar Default """","
            sql = sql & "ArticlePageSize VarChar Default """","
            sql = sql & "ArticleInfoStyle VarChar Default """","
            sql = sql & "ArticleInfoPhotoWidth VarChar Default """","
            sql = sql & "ArticleInfoPhotoHeight VarChar Default """","

            sql = sql & "AddSortType VarChar Default """","
            sql = sql & "OrderSortType VarChar Default """","
            sql = sql & "TimeSortType VarChar Default """","


            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","


            sql = sql & "CustomAUrl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "SmallClass"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "ImgPath VarChar Default """","
            sql = sql & "UpLoadFiles VarChar Default """","
            sql = sql & "Url VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","

            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"


            sql = sql & "ArticleListStyle VarChar Default """","
            sql = sql & "ArticlePageSize VarChar Default """","
            sql = sql & "ArticleInfoStyle VarChar Default """","
            sql = sql & "ArticleInfoPhotoWidth VarChar Default """","
            sql = sql & "ArticleInfoPhotoHeight VarChar Default """","

            sql = sql & "AddSortType VarChar Default """","
            sql = sql & "OrderSortType VarChar Default """","
            sql = sql & "TimeSortType VarChar Default """","



            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","


            sql = sql & "CustomAUrl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "ThreeClass"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "ThreeClassName VarChar Default """","
            sql = sql & "ImgPath VarChar Default """","
            sql = sql & "Url VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"

            sql = sql & "ArticleListStyle VarChar Default """","
            sql = sql & "ArticlePageSize VarChar Default """","
            sql = sql & "ArticleInfoStyle VarChar Default """","
            sql = sql & "ArticleInfoPhotoWidth VarChar Default """","
            sql = sql & "ArticleInfoPhotoHeight VarChar Default """","

            sql = sql & "AddSortType VarChar Default """","
            sql = sql & "OrderSortType VarChar Default """","
            sql = sql & "TimeSortType VarChar Default """","



            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","


            sql = sql & "CustomAUrl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Product"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "ThreeClassName VarChar Default """","
            sql = sql & "title VarChar Default """","
            sql = sql & "Recommend YesNo Default Yes,"
            sql = sql & "HomeRecommend YesNo Default Yes,"
            sql = sql & "Through YesNo Default No,"
            sql = sql & "Hot YesNo Default No,"
            sql = sql & "Occasions VarChar Default """","
            sql = sql & "Hotline VarChar Default """","
            sql = sql & "Model VarChar Default """","
            sql = sql & "Author VarChar Default """","
            sql = sql & "ArticleSource VarChar Default """","

            sql = sql & "Price Int Default 0,"
            sql = sql & "NewPrice Int Default 0,"
            sql = sql & "MemberPrice Int Default 0,"
            sql = sql & "Sold Int Default 0,"

            sql = sql & "MemberType VarChar Default """","
            sql = sql & "MemberUser VarChar Default """","
            sql = sql & "Hits Int Default 0,"
            sql = sql & "BigFiles VarChar Default """","
            sql = sql & "SmallFiles VarChar Default """","

            sql = sql & "TitleAlt VarChar Default """","
            sql = sql & "BigFilesAlt VarChar Default """","
            sql = sql & "SmallFilesAlt VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "ProductAbout Text,"
            sql = sql & "ArticleDescription Text,"

            sql = sql & "HttpUrl VarChar Default """","
            sql = sql & "RecordUrl VarChar Default """","
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "noFollow int Default 0,"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "nCount Int Default 0,"

            sql = sql & "X Int Default 0,"
            sql = sql & "Y Int Default 0,"
            sql = sql & "InfoId Int Default 0,"
            sql = sql & "WBChouTi Int Default 0,"
            sql = sql & "ExpireTime Int Default 6000,"
            sql = sql & "JinXinName VarChar Default """","


            sql = sql & "ArticleInfoStyle VarChar Default """","
            sql = sql & "ArticleInfoPhotoWidth VarChar Default """","
            sql = sql & "ArticleInfoPhotoHeight VarChar Default """","


            sql = sql & "RelatedTags VarChar Default """","



            sql = sql & "TopModule VarChar Default """","
            sql = sql & "BottomModule VarChar Default """","
            sql = sql & "LeftModule VarChar Default """","
            sql = sql & "MiddleModule VarChar Default """","
            sql = sql & "RightModule VarChar Default """","


            sql = sql & "CustomAUrl VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Feedback"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "GuestName VarChar Default """","
            sql = sql & "Tel VarChar Default """","
            sql = sql & "Fax VarChar Default """","
            sql = sql & "EMail VarChar Default """","
            sql = sql & "Mobile VarChar Default """","
            sql = sql & "QQ VarChar Default """","
            sql = sql & "MSN VarChar Default """","
            sql = sql & "Company VarChar Default """","
            sql = sql & "Address VarChar Default """","
            sql = sql & "IP VarChar Default """","
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "QQMSN"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "WebSite VarChar Default """","
            sql = sql & "Tel VarChar Default """","
            sql = sql & "QQNumber VarChar Default """","
            sql = sql & "QQName VarChar Default """","
            sql = sql & "MSNNumber VarChar Default """","
            sql = sql & "MSNName VarChar Default """","
            sql = sql & "QQStyle Int,"
            sql = sql & "QqPicture Int,"
            sql = sql & "Display YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "OnLineQQ"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "title VarChar Default """","
            sql = sql & "QQ VarChar Default """","
            sql = sql & "IsOnlineChat YesNo Default No,"
            sql = sql & "IsAddFriend YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Vote"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "Option1 VarChar Default """","
            sql = sql & "Option2 VarChar Default """","
            sql = sql & "Option3 VarChar Default """","
            sql = sql & "Option4 VarChar Default """","
            sql = sql & "Option5 VarChar Default """","
            sql = sql & "Option6 VarChar Default """","
            sql = sql & "Num1 Int,"
            sql = sql & "Num2 Int,"
            sql = sql & "Num3 Int,"
            sql = sql & "Num4 Int,"
            sql = sql & "Num5 Int,"
            sql = sql & "Num6 Int,"
            sql = sql & "Display YesNo Default Yes,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "OnHtml YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "VoteType YesNo Default Yes)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Member"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "UserName VarChar Default """","
            sql = sql & "Pwd VarChar Default """","
            sql = sql & "YunPwd VarChar Default """","
            sql = sql & "Sex VarChar Default '男',"
            sql = sql & "Age Int Default 18,"
            sql = sql & "Tel VarChar Default """","
            sql = sql & "Phone VarChar Default """","
            sql = sql & "Fax VarChar Default """","
            sql = sql & "Email VarChar Default """","
            sql = sql & "ZipCode VarChar Default """","
            sql = sql & "Address VarChar Default """","
            sql = sql & "Company VarChar Default """","

            sql = sql & "RegIP VarChar Default """","
            sql = sql & "logIp VarChar Default """","

            sql = sql & "LoginNumb Int Default 0,"
            sql = sql & "LoginTime DateTime Default Date(),"
            sql = sql & "LastLoginTime DateTime Default Date(),"




            sql = sql & "Scene VarChar Default """","
            sql = sql & "SceneMap VarChar Default """","
            sql = sql & "RenJB Int Default 1,"
            sql = sql & "FoBi Int Default 1,"
            sql = sql & "MyName VarChar Default """","
            sql = sql & "MyMoney Int Default '666',"
            sql = sql & "Deposit Int Default 0,"
            sql = sql & "RenHP Int Default 10,"
            sql = sql & "RenMP Int Default 10,"
            sql = sql & "RenEXP Int Default 1,"
            sql = sql & "WBChouTi Int Default 0,"
            sql = sql & "TheX VarChar Default """","
            sql = sql & "TheY VarChar Default """","
            sql = sql & "OpenID VarChar Default """","
            sql = sql & "Access_Token VarChar Default """","
            sql = sql & "QQPhoto VarChar Default """","
            sql = sql & "Province VarChar Default """","
            sql = sql & "City VarChar Default """","
            sql = sql & "Area VarChar Default """","


            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "banner VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "OnHtml YesNo Default Yes,"
            sql = sql & "Sort Int Default 0,"
            sql = sql & "Content Text Default """","


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default Yes)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Payment"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "UserName VarChar Default """","
            sql = sql & "MemberId VarChar Default """","
            sql = sql & "Sex VarChar Default '男',"
            sql = sql & "Age Int Default 18,"
            sql = sql & "Tel VarChar Default """","
            sql = sql & "Phone VarChar Default """","
            sql = sql & "Fax VarChar Default """","
            sql = sql & "Email VarChar Default """","
            sql = sql & "ZipCode VarChar Default """","
            sql = sql & "Address VarChar Default """","
            sql = sql & "Company VarChar Default """","
            sql = sql & "QQMSN VarChar Default """","
            sql = sql & "Ip VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default No)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "Previeworder"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "MemberId VarChar Default """","
            sql = sql & "OrderId VarChar Default """","
            sql = sql & "ProductId VarChar Default """","
            sql = sql & "title VarChar Default '男',"
            sql = sql & "Total VarChar Default """","
            sql = sql & "Price Int Default 18,"
            sql = sql & "ProductSum VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default No)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "SearchCount"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "Through YesNo Default No,"
            sql = sql & "webTitle VarChar Default """","
            sql = sql & "webKeywords VarChar Default """","
            sql = sql & "webDescription VarChar Default """","
            sql = sql & "folderName VarChar Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "templatePath VarChar Default """","
            sql = sql & "target VarChar Default """","
            sql = sql & "fontColor VarChar Default """","
            sql = sql & "fontB YesNo Default No,"
            sql = sql & "OnHtml YesNo Default Yes,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Sort Int Default 1)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "ProductComment"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "UserName VarChar Default """","
            sql = sql & "title VarChar Default """","
            sql = sql & "Pid Int,"
            sql = sql & "PTitle VarChar Default """","
            sql = sql & "Content Text,"
            sql = sql & "Sort Int Default 1,"
            sql = sql & "Ip VarChar Default """","

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default No)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "WebLink"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "Url VarChar Default """","
            sql = sql & "ImgPath VarChar Default """","
            sql = sql & "Content Text,"
            sql = sql & "Sort Int Default 1,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default No)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "SoftTask"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "Email VarChar Default """","
            sql = sql & "Content Text,"
            sql = sql & "FilePath VarChar Default """","
            sql = sql & "nSort Int Default 1,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default No)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "WaterMark"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "WaterMarkText VarChar Default """","

            sql = sql & "WaterMarkTextPosition VarChar Default """","
            sql = sql & "TextX Int Default 0,"
            sql = sql & "TextY Int Default 0,"
            sql = sql & "nTextSize Int Default 0,"
            sql = sql & "TextRotation Int Default 0,"
            sql = sql & "TextColor VarChar Default """","
            sql = sql & "WaterMarkTypeFace VarChar Default """","

            sql = sql & "WaterMarkImgPath VarChar Default """","
            sql = sql & "WaterMarkImgPosition VarChar Default """","
            sql = sql & "ImgX Int Default 0,"
            sql = sql & "ImgY Int Default 0,"
            sql = sql & "WaterMarkImgTransparency Int Default 0,"

            sql = sql & "ZoomWidth Int Default 0,"
            sql = sql & "ZoomHeight Int Default 0,"

            sql = sql & "nSort Int Default 1,"
            sql = sql & "Content Text,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Through YesNo Default No)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "InputConfig"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "FrontTitle VarChar Default """","
            sql = sql & "BackEndTitle VarChar Default """","
            sql = sql & "FieldName VarChar Default """","
            sql = sql & "CustomFieldName VarChar Default """","


            sql = sql & "InputType VarChar Default """","
            sql = sql & "InputWidth VarChar Default """","
            sql = sql & "InputHeight VarChar Default """","
            sql = sql & "VerificationType VarChar Default """","
            sql = sql & "VerificationMsg VarChar Default """","
            sql = sql & "TipsText VarChar Default """","
            sql = sql & "DefaultValue VarChar Default """","

            sql = sql & "Placeholder VarChar Default """","


            sql = sql & "ListShow YesNo Default No,"
            sql = sql & "EditDialogShow YesNo Default No,"

            sql = sql & "Sort Int Default 0,"
            sql = sql & "Through YesNo Default No,"

            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "InputValue"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","

            sql = sql & "Str1 VarChar Default """","
            sql = sql & "Str2 VarChar Default """","
            sql = sql & "Str3 VarChar Default """","
            sql = sql & "Str4 VarChar Default """","
            sql = sql & "Str5 VarChar Default """","
            sql = sql & "Str6 VarChar Default """","
            sql = sql & "Str7 VarChar Default """","
            sql = sql & "Str8 VarChar Default """","
            sql = sql & "Str9 VarChar Default """","
            sql = sql & "Str10 VarChar Default """","
            sql = sql & "Str11 VarChar Default """","
            sql = sql & "Str12 VarChar Default """","
            sql = sql & "Str13 VarChar Default """","
            sql = sql & "Str14 VarChar Default """","
            sql = sql & "Str15 VarChar Default """","


            sql = sql & "Numb1 Int Default 0,"
            sql = sql & "Numb2 Int Default 0,"
            sql = sql & "Numb3 Int Default 0,"
            sql = sql & "Numb4 Int Default 0,"
            sql = sql & "Numb5 Int Default 0,"
            sql = sql & "Numb6 Int Default 0,"
            sql = sql & "Numb7 Int Default 0,"
            sql = sql & "Numb8 Int Default 0,"
            sql = sql & "Numb9 Int Default 0,"



            sql = sql & "TrueFalse1 YesNo Default No,"
            sql = sql & "TrueFalse2 YesNo Default No,"
            sql = sql & "TrueFalse3 YesNo Default No,"
            sql = sql & "TrueFalse4 YesNo Default No,"
            sql = sql & "TrueFalse5 YesNo Default No,"
            sql = sql & "TrueFalse6 YesNo Default No,"
            sql = sql & "TrueFalse7 YesNo Default No,"
            sql = sql & "TrueFalse8 YesNo Default No,"
            sql = sql & "TrueFalse9 YesNo Default No,"

            sql = sql & "Sort Int Default 0,"
            sql = sql & "Through YesNo Default No,"


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        If 1 = 2 Then

            tableName = DB_PREFIX & "MyTask"
            If ShowIsTable(tableName) = False Then
                sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
                sql = sql & "title VarChar Default """","
                sql = sql & "SetDate Int Default 1,"
                sql = sql & "Content Text,"
                sql = sql & "Reply Text,"
                sql = sql & "Sort Int Default 1,"


                sql = sql & "addDateTime DateTime Default Now(),"
                sql = sql & "upDateTime DateTime Default Date(),"
                sql = sql & "Through YesNo Default No)"
                If MDBPath = "" Then sql = HandleSqlServer(sql)
                conn.Execute sql
            End If

            tableName = DB_PREFIX & "Diary"
            If ShowIsTable(tableName) = False Then
                sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
                sql = sql & "Weather VarChar Default """","
                sql = sql & "Through YesNo Default No,"

                sql = sql & "addDateTime DateTime Default Now(),"
                sql = sql & "upDateTime DateTime Default Date(),"
                sql = sql & "Content Text Default """")"
                If MDBPath = "" Then sql = HandleSqlServer(sql)
                conn.Execute sql
            End If
        End If

        tableName = DB_PREFIX & "ProductParameter"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "PtTitle VarChar Default """","
            sql = sql & "PtStart VarChar Default """","
            sql = sql & "PtEnd VarChar Default """","
            sql = sql & "PId Int,"
            sql = sql & "HomeRecommend YesNo Default Yes,"
            sql = sql & "InfoRecommend YesNo Default Yes,"
            sql = sql & "Sort Int Default 0,"
            sql = sql & "PtValue1 VarChar Default """","
            sql = sql & "PtValue2 VarChar Default """","
            sql = sql & "PtValue3 VarChar Default """","
            sql = sql & "PtValue4 VarChar Default """","
            sql = sql & "PtValue5 VarChar Default """","
            sql = sql & "PtValue6 VarChar Default """","
            sql = sql & "PtValue7 VarChar Default """","
            sql = sql & "PtValue8 VarChar Default """","
            sql = sql & "PtValue9 VarChar Default """","
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "WebTemplate"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "title VarChar Default """","
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "Sort Int Default 0,"
            sql = sql & "MbParameter Text,"
            sql = sql & "Recommend YesNo Default Yes,"
            sql = sql & "MbUpdate YesNo Default No,"


            sql = sql & "addDateTime DateTime Default Now(),"
            sql = sql & "upDateTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        AddData = True
        If AddData = True Then
			

			splStr = Split("admin|msd|bb", "|")
			For Each s In splStr
				rs.Open "Select * From "& DB_PREFIX &"Admin Where UserName='" & s & "'", conn, 1, 3
				If rs.EOF Then
					rs.AddNew
					rs("UserName") = s
					rs("Pwd") = myMD5(s)
					rs.Update
				End If : rs.Close
			Next

            rs.Open "Select * From "& DB_PREFIX &"ListMenu", conn, 1, 3
            If rs.EOF Then
                splStr = Split("系统管理|导航管理|单面管理|总信息管理|招聘管理|留言管理|友情链接|前台配置|在线反馈|生成HTML|图片水印管理|表单管理", "|")
                SplTrue = Split("True|True|True|True|True|True|True|False|True|True|False|False", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,Sort,Display) Values('" & splStr(i) & "'," & i & "," & StrTrueFalseToInt(SplTrue(i)) & ")")
                Next

                BigClassName = "系统管理"
                splStr = Split("网站配置,WebSiteConfig.Asp,True|账号管理,AdminManage.Asp,True|Robots在线修改,Robots.Asp,True|404页在线修改,Create404.Asp,False|网站空间统计,WebSiteSpaceStat.Asp,False|数据库备份,Data.Asp?act=BackUp,True|恢复库备份,Data.Asp?act=Resume,True|SQL防注入,SqlIn,Asp,False|网站状态,WebSiteStatus.Asp,False|在线QQ聊天,OnLineQQManage.Asp,True|浮动QQ面板,QQMSN.Asp,False|投票管理,VoteManage.Asp,False|生成HTML,Createhtml.Asp,False|帮助中心,http://t.cn/agGbue,False|上传管理,Admin_UploadFileManage.Asp,False|模板模块管理,TableManage.Asp?TableName=TemplateModule,False|", "|")
                For i = 0 To UBound(splStr)
                    s = Trim(splStr(i))
                    If s <> "" Then
                        splxx = Split(s, ",")
                        conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splxx(0) & "'," & i & "," & StrTrueFalseToInt(splxx(2)) & ",'" & splxx(1) & "')")
                    End If
                Next


                BigClassName = "表单管理"
                splStr = Split("表单配置管理,TableManage.Asp?TableName=InputConfig,False|表单内容管理,TableManage.Asp?TableName=InputValue,False|", "|")


                For i = 0 To UBound(splStr)
                    s = Trim(splStr(i))
                    If s <> "" Then
                        splxx = Split(s, ",")
                        conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splxx(0) & "'," & i & "," & StrTrueFalseToInt(splxx(2)) & ",'" & splxx(1) & "')")
                    End If
                Next



                BigClassName = "导航管理"
                splStr = Split("导航列表", "|")
                SplUrl = Split("NavManage.Asp", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
                BigClassName = "单面管理"
                splStr = Split("单页列表", "|")
                SplUrl = Split("MainInfo.Asp", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
                BigClassName = "总信息管理"
                splStr = Split("添加信息,Product.Asp?act=ShowAdd,True|信息管理,ProductManage.Asp,True|类别管理,ProductClassManage.Asp,True|订单信息,OrderManage.Asp,False|会员信息,MemberManage.Asp,False|产品参数设置,PParameterGl.Asp,False|产品搜索,SearchGl.Asp,True|", "|")
                For i = 0 To UBound(splStr)
                    s = Trim(splStr(i))
                    If s <> "" Then
                        splxx = Split(s, ",")
                        conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splxx(0) & "'," & i & "," & StrTrueFalseToInt(splxx(2)) & ",'" & splxx(1) & "')")
                    End If
                Next


                BigClassName = "图片水印管理"
                splStr = Split("添中水印配置,WaterMark.Asp?act=ShowDialog,True|图片水印管理,WaterMarkManage.Asp,True|给图片加水印,WaterMark.Asp,True", "|")
                For i = 0 To UBound(splStr)
                    s = Trim(splStr(i))
                    If s <> "" Then
                        splxx = Split(s, ",")
                        conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splxx(0) & "'," & i & "," & StrTrueFalseToInt(splxx(2)) & ",'" & splxx(1) & "')")
                    End If
                Next


                splStr = Split("添加信息|信息管理|类别管理|订单信息|会员信息|产品参数设置|产品搜索", "|")
                SplTrue = Split("True|True|True|False|True|False|True", "|")
                SplUrl = Split("Product.Asp?act=ShowAdd|ProductManage.Asp|ProductClassManage.Asp|OrderManage.Asp|MemberManage.Asp|PParameterGl.Asp|SearchGl.Asp", "|")
                For i = 0 To UBound(splStr)

                Next
                BigClassName = "招聘管理"
                splStr = Split("添加招聘职位|招聘职位管理", "|")
                SplUrl = Split("JobManage.Asp?act=ShowJob|JobManage.Asp", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
                BigClassName = "留言管理"
                splStr = Split("浏览留言", "|")
                SplUrl = Split("GuestBook.Asp", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
                BigClassName = "友情链接"
                splStr = Split("友情链接管理", "|")
                SplUrl = Split("FriendLink.Asp", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
                BigClassName = "前台配置"
                splStr = Split("首页产品|首页新闻|滚动图片|Flash图片", "|")
                SplUrl = Split("Front.Asp?NavName=", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(0) & splStr(i) & "')")
                Next
                BigClassName = "在线反馈"
                splStr = Split("反馈信息管理", "|")
                SplUrl = Split("FeedbackManage.Asp", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
                BigClassName = "生成HTML"
                splStr = Split("HTML管理|生成导航", "|")
                SplUrl = Split("../Inc/Create_Html.Asp?act=default|../Inc/Create_Html.Asp?act=ShowNavList", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ListMenu (BigClassName,SmallClassName,Sort,Display,Url) Values('" & BigClassName & "','" & splStr(i) & "'," & i & ",1,'" & SplUrl(i) & "')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"NavBigClass", conn, 1, 3
            If rs.EOF Then
                splStr = Split("首页|文本|产品|新闻|留言|招聘|反馈|文本", "|")
                SplNavName = Split("网站首页|公司简介|产品展示|新闻中心|在线留言|人才招聘|在线反馈|联系我们", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"NavBigClass (BigClassName,Sort,NavType,NavTop) Values('" & SplNavName(i) & "'," & i & ",'" & splStr(i) & "',1)")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"NavSmallClass", conn, 1, 3
            If rs.EOF Then
                NavClassName = "联系我们"
                splStr = Split("联系中心|关于我们", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"NavSmallClass (BigClassName,SmallClassName) Values('" & NavClassName & "','" & splStr(i) & "')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"MainInfo", conn, 1, 3
            If rs.EOF Then
                splStr = Split("网站公告|联系方式|公司简介", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"MainInfo (Title,ShowTitle,Content) Values('" & splStr(i) & "','" & splStr(i) & "','" & splStr(i) & "内容后台修改！')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"GuestBook", conn, 1, 3
            If rs.EOF Then
                conn.Execute("Insert Into "& DB_PREFIX &"GuestBook (GuestName,Tel,Through,IP,Content,Reply) Values('小云','021-2222',1,'253.25.365.21','留言内容1','这是回复内容1')")
                conn.Execute("Insert Into "& DB_PREFIX &"GuestBook (GuestName,Tel,Through,IP,Content,Reply) Values('小张','010-1111',0,'127.0.0.1','留言内容22','这是回复内容22')")
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"FriendLink", conn, 1, 3
            If rs.EOF Then


                SplImg = Split("UploadFiles\yahoo.gif|UploadFiles\baidu.gif|UploadFiles\google.gif||||||||||||||||||||||||||||||||||||||||||||||||||||", "|")
                splStr = Split("南京微战略|南京麦思德|南京悠口餐饮", "|")
                SplUrl = Split("http://www.wzl99.com/|http://maiside.net/|http://www.youkoucanyin.com/", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"FriendLink (Title,Alt,Url,ImgPath,Sort,Target) Values('" & splStr(i) & "','" & splStr(i) & "详细说明','" & SplUrl(i) & "','" & SplImg(i) & "'," & i & ",'_blank')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"Front", conn, 1, 3
            If rs.EOF Then
                splStr = Split("首页产品|首页新闻|滚动图片|Flash图片", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"Front (Title) Values('" & splStr(i) & "')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"BigClass", conn, 1, 3
            If rs.EOF Then
                splStr = Split("产品展示|新闻中心", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"BigClass (BigClassName) Values('" & splStr(i) & "')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"SmallClass", conn, 1, 3
            If rs.EOF Then
                BigClassName = "产品展示"
                splStr = Split("经典产品|促售产品", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"SmallClass (BigClassName,SmallClassName) Values('" & BigClassName & "','" & splStr(i) & "')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"ThreeClass", conn, 1, 3
            If rs.EOF Then
                BigClassName = "产品展示"
                splStr = Split("经典子类|经典子类二", "|")
                For i = 0 To UBound(splStr)
                    conn.Execute("Insert Into "& DB_PREFIX &"ThreeClass (BigClassName,SmallClassName,ThreeClassName) Values('" & BigClassName & "','经典产品','" & splStr(i) & "')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"Product", conn, 1, 3
            If rs.EOF And 1 = 2 Then
                For i = 1 To 6
                    conn.Execute("Insert Into "& DB_PREFIX &"Product(BigClassName,SmallClassName,ThreeClassName,Title,Sort,BigFiles) Values('产品展示','经典产品','经典子类','标题" & i & "'," & i & ",'UpLoadFiles/Pic/" & i & ".jpg')")
                Next
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"Feedback ", conn, 1, 3
            If rs.EOF Then
                conn.Execute("Insert Into "& DB_PREFIX &"Feedback (GuestName,Tel,Fax,Email,Content) Values('小张','021-1236548','021-88888','123@qq.com','内容')")
                conn.Execute("Insert Into "& DB_PREFIX &"Feedback (GuestName,Tel,Fax,Email,Content) Values('小李','021-1236548','021-88888','888@qq.com','内容')")
                conn.Execute("Insert Into "& DB_PREFIX &"Feedback (GuestName,Tel,Fax,Email,Content) Values('小孙','021-1236548','021-88888','456@qq.com','内容')")
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"QQMSN", conn, 1, 3
            If rs.EOF Then
                conn.Execute("Insert Into "& DB_PREFIX &"QQMSN (Title,WebSite,QQNumber,QQName,MSNNumber,MSNName,QQStyle,Display,QqPicture) Values('在线客服','www.baidu.com','313801120|123456','技术QQ|测试QQ','123456@qq.com','测试MSN',1,1,4)")
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"WebSite", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("webTitle") = "网站标题"
                rs("webKeywords") = "网站关键词"
                rs("webDescription") = "网站描述"
                rs("WebSiteUrl") = "http://www.baidu.com"
                rs("WebSiteBottom") = "版权所有 上海子映有限公司 电话：021-66666666 传真：021-8888888<br>联系QQ：313801120 邮箱：313801120@qq.com"
                rs("TemplateIndex") = TemplateIndex
                rs("TemplateHome") = TemplateHome
                rs("TemplateMain") = TemplateMain
                rs("ModuleSkins") = ""
                rs.Update
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"Job", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("Sex") = "无限"
                rs("Age") = "18-25"
                rs("Education") = "大专"
                rs("WorkArea") = "本地"
                rs("Post") = "工程师"
                rs("Monthly") = "5000-8000"
                rs("Content") = "面议"
                rs.Update
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"Vote", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("Title") = "你是从哪里来到本站的？"
                rs("Option1") = "百度"
                rs("Option2") = "Google"
                rs("Option3") = "Yahoo"
                rs("Option4") = "其它"
                rs("Num1") = 25
                rs("Num2") = 42
                rs("Num3") = 53
                rs("Num4") = 86
                rs.Update
            End If : rs.Close

            rs.Open "Select * From "& DB_PREFIX &"Member", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("UserName") = "zy"
                rs("Pwd") = "zy"
                rs.Update
            End If : rs.Close

            For i = 1 To 60
                conn.Execute("Insert Into "& DB_PREFIX &"Payment (UserName) Values('" & i & "')")
            Next

            rs.Open "Select * From "& DB_PREFIX &"ProductComment", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("UserName") = "小云"
                rs("Title") = "测试标题"
                rs("Pid") = 1
                rs("PTitle") = "产品标题"
                rs("Content") = "评论内容"
                rs("Ip") = "168.236.5.69"
                rs("Through") = False
                rs.Update
            End If : rs.Close

            conn.Execute("Update "& DB_PREFIX &"ListMenu Set Display=0 Where BigClassName='前台配置'")
        End If
        Call HandleModuleData()
    End Sub


    Sub handleModuleData()
        Dim b, c, d
        b = GetFText("ModuleData.txt")
        splStr = Split(b, "----------------------------" & vbCrLf)
        For Each c In splStr
            c = TrimvbCrlf(c) & vbCrLf
            d = Mid(c, 1, InStr(c, vbCrLf) - 1)
            b = Mid(c, InStr(c, vbCrLf) + 1)
            Call echo("模块标题Title", d)

            rs.Open "Select * From "& DB_PREFIX &"TempLateModule Where Title='" & d & "'", conn, 1, 3
            If rs.EOF Then
                rs.AddNew
                rs("Title") = d
                rs("Content") = b
                rs("DispalyEditor") = False
                rs.Update
            End If : rs.Close
        Next
    End Sub




    Sub qQAccess()

        tableName = DB_PREFIX & "QQ"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "ThreeClassName VarChar Default """","
            sql = sql & "QQ VarChar Default """","
            sql = sql & "QQName VarChar Default """","
            sql = sql & "QQSex VarChar Default """","
            sql = sql & "Age Int Default 0,"
            sql = sql & "QQAge Int Default 0,"
            sql = sql & "Birthday VarChar Default """","
            sql = sql & "Bloodtype VarChar Default """","
            sql = sql & "Zodiac VarChar Default """","
            sql = sql & "Constellation VarChar Default """","
            sql = sql & "Country VarChar Default """","
            sql = sql & "Province VarChar Default """","
            sql = sql & "City VarChar Default """","
            sql = sql & "Tel VarChar Default """","
            sql = sql & "Phone VarChar Default """","
            sql = sql & "Fax VarChar Default """","
            sql = sql & "Email VarChar Default """","
            sql = sql & "ZipCode VarChar Default """","
            sql = sql & "Address VarChar Default """","
            sql = sql & "VisitorsList Text Default """","
            sql = sql & "VisitorsNumb Text Default """","
            sql = sql & "SpacePurview Int Default 0,"
            sql = sql & "OnLineTime DateTime,"


            sql = sql & "MutualFriend Int Default 0,"


            sql = sql & "AddTime DateTime Default Date(),"
            sql = sql & "UpDateTime DateTime,"
            sql = sql & "Content Text Default """","
            sql = sql & "Through Int Default 0)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "QQNameTable"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "QQ VarChar Default """","
            sql = sql & "QQName VarChar Default """","
            sql = sql & "AddTime DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "SourceCode"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "ThreeClassName VarChar Default """","

            sql = sql & "title VarChar Default """","
            sql = sql & "ZipSize Money Default 0,"
            sql = sql & "ImgUrl VarChar Default """","
            sql = sql & "HttpUrl VarChar Default """","
            sql = sql & "Author VarChar Default """","
            sql = sql & "UpDateTime DateTime,"
            sql = sql & "Windows VarChar Default """","

            sql = sql & "RenQi Int Default 0,"
            sql = sql & "DownNumb Int Default 0,"
            sql = sql & "ReplyNumb Int Default 0,"

            sql = sql & "AddTime DateTime Default Date(),"
            sql = sql & "Content Text Default """","
            sql = sql & "Through Int Default 0)"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If


        tableName = DB_PREFIX & "SMSInfo"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "DXName VarChar Default """","
            sql = sql & "ToName VarChar Default """","
            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Date(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub

    Sub adminLog()

        tableName = DB_PREFIX & "AdminLog"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "GoToUrl VarChar Default """","
            sql = sql & "ThisUrl VarChar Default """","
            sql = sql & "TableName VarChar Default """","
            sql = sql & "EditId VarChar Default """","
            sql = sql & "IP VarChar Default """","
            sql = sql & "IE VarChar Default """","
            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Date(),"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "AdminNimble"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "GoToUrl VarChar Default """","
            sql = sql & "ThisUrl VarChar Default """","
            sql = sql & "TableName VarChar Default """","
            sql = sql & "EditId VarChar Default """","
            sql = sql & "IP VarChar Default """","
            sql = sql & "IE VarChar Default """","
            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Date(),"
            sql = sql & "Sort Int Default 0,"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub

    Sub askDaAccess()

        tableName = DB_PREFIX & "AskDa"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "Ask Text Default """","
            sql = sql & "Da Text Default """","

            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Date(),"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub

    Sub zNRobotAccess()

        tableName = DB_PREFIX & "ZNRobot"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "SmallClassName VarChar Default """","
            sql = sql & "ThreeClassName VarChar Default """","
            sql = sql & "title Text Default """","
            sql = sql & "Other1 VarChar Default """","
            sql = sql & "Other2 VarChar Default """","
            sql = sql & "Other3 VarChar Default """","
            sql = sql & "Other4 VarChar Default """","
            sql = sql & "Other5 VarChar Default """","

            sql = sql & "Hui Text Default """","
            sql = sql & "Hui2 VarChar Default """","
            sql = sql & "Hui3 VarChar Default """","
            sql = sql & "Hui4 VarChar Default """","
            sql = sql & "Hui5 VarChar Default """","

            sql = sql & "JB Int Default 9,"
            sql = sql & "Sort Int Default 0,"
            sql = sql & "RelatedTags VarChar Default """","
            sql = sql & "TitleTags Text Default """","
            sql = sql & "Notes Text Default """","

            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Date(),"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub


    Sub computerDir()

        tableName = DB_PREFIX & "ComputerDir"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "FilePath Text Default """","
            sql = sql & "fileName VarChar Default """","
            sql = sql & "FileSize Text Default """","
            sql = sql & "FileType Text Default """","
            sql = sql & "FileContent Image Default """","

            sql = sql & "FileAddData DateTime Default Date(),"
            sql = sql & "FileEditData DateTime Default Date(),"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub


    Sub webSoftAccess()

        tableName = DB_PREFIX & "SoftUser"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "UserName VarChar Default """","
            sql = sql & "Pwd VarChar Default """","
            sql = sql & "FullName VarChar Default """","

            sql = sql & "RegDateTime DateTime Default Now(),"
            sql = sql & "UpDateTime DateTime Default Now(),"
            sql = sql & "RegIP VarChar Default """","
            sql = sql & "UpIP VarChar Default """","
            sql = sql & "QuanXian Text Default """","

            sql = sql & "DayLoginErrCount Int Default 0,"
            sql = sql & "LimitDayLoginErrCount Int Default 0,"
            sql = sql & "LoginErrCount Int Default 0,"
            sql = sql & "LoginCount Int Default 0,"

            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "SoftAction"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "title Text Default """","

            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "SoftLog"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "UserName VarChar Default """","
            sql = sql & "title Text Default """","
            sql = sql & "ActionType Text Default """","
            sql = sql & "IP VarChar Default """","

            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If

        tableName = DB_PREFIX & "RemoteUserStat"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "GoToUrl VarChar Default """","
            sql = sql & "ThisUrl VarChar Default """","
            sql = sql & "IP VarChar Default """","
            sql = sql & "IE VarChar Default """","
            sql = sql & "XP VarChar Default """","
            sql = sql & "Windows VarChar Default """","
            sql = sql & "Screen VarChar Default """","

            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Date(),"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"
            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub

    Sub caiConfig()

        tableName = DB_PREFIX & "CaiConfig"
        If ShowIsTable(tableName) = False Then
            sql = "Create Table " & tableName & " (Id int Identity(0,1) Primary Key,"
            sql = sql & "BigClassName VarChar Default """","
            sql = sql & "TableName VarChar Default """","
            sql = sql & "CheckSql VarChar Default """","
            sql = sql & "SearchValue VarChar Default """","
            sql = sql & "CaiConfigUrl VarChar Default """","




            sql = sql & "StartPage VarChar Default """","
            sql = sql & "EndPage VarChar Default """","
            sql = sql & "PageAction VarChar Default """","
            sql = sql & "nThisPage Int Default 0,"
            sql = sql & "nCountPage Int Default 0,"

            sql = sql & "StartBody VarChar Default """","
            sql = sql & "EndBody VarChar Default """","
            sql = sql & "StartList VarChar Default """","
            sql = sql & "EndList VarChar Default """","

            sql = sql & "LableName1 VarChar Default """","
            sql = sql & "FieldName1 VarChar Default """","
            sql = sql & "Action1 VarChar Default """","
            sql = sql & "Start1 VarChar Default """","
            sql = sql & "End1 VarChar Default """","

            sql = sql & "LableName2 VarChar Default """","
            sql = sql & "FieldName2 VarChar Default """","
            sql = sql & "Action2 VarChar Default """","
            sql = sql & "Start2 VarChar Default """","
            sql = sql & "End2 VarChar Default """","

            sql = sql & "LableName3 VarChar Default """","
            sql = sql & "FieldName3 VarChar Default """","
            sql = sql & "Action3 VarChar Default """","
            sql = sql & "Start3 VarChar Default """","
            sql = sql & "End3 VarChar Default """","

            sql = sql & "LableName4 VarChar Default """","
            sql = sql & "FieldName4 VarChar Default """","
            sql = sql & "Action4 VarChar Default """","
            sql = sql & "Start4 VarChar Default """","
            sql = sql & "End4 VarChar Default """","

            sql = sql & "LableName5 VarChar Default """","
            sql = sql & "FieldName5 VarChar Default """","
            sql = sql & "Action5 VarChar Default """","
            sql = sql & "Start5 VarChar Default """","
            sql = sql & "End5 VarChar Default """","

            sql = sql & "LableName6 VarChar Default """","
            sql = sql & "FieldName6 VarChar Default """","
            sql = sql & "Action6 VarChar Default """","
            sql = sql & "Start6 VarChar Default """","
            sql = sql & "End6 VarChar Default """","

            sql = sql & "LableName7 VarChar Default """","
            sql = sql & "FieldName7 VarChar Default """","
            sql = sql & "Action7 VarChar Default """","
            sql = sql & "Start7 VarChar Default """","
            sql = sql & "End7 VarChar Default """","

            sql = sql & "LableName8 VarChar Default """","
            sql = sql & "FieldName8 VarChar Default """","
            sql = sql & "Action8 VarChar Default """","
            sql = sql & "Start8 VarChar Default """","
            sql = sql & "End8 VarChar Default """","

            sql = sql & "LableName9 VarChar Default """","
            sql = sql & "FieldName9 VarChar Default """","
            sql = sql & "Action9 VarChar Default """","
            sql = sql & "Start9 VarChar Default """","
            sql = sql & "End9 VarChar Default """","

            sql = sql & "LableName10 VarChar Default """","
            sql = sql & "FieldName10 VarChar Default """","
            sql = sql & "Action10 VarChar Default """","
            sql = sql & "Start10 VarChar Default """","
            sql = sql & "End10 VarChar Default """","

            sql = sql & "LableName11 VarChar Default """","
            sql = sql & "FieldName11 VarChar Default """","
            sql = sql & "Action11 VarChar Default """","
            sql = sql & "Start11 VarChar Default """","
            sql = sql & "End11 VarChar Default """","

            sql = sql & "LableName12 VarChar Default """","
            sql = sql & "FieldName12 VarChar Default """","
            sql = sql & "Action12 VarChar Default """","
            sql = sql & "Start12 VarChar Default """","
            sql = sql & "End12 VarChar Default """","

            sql = sql & "AddTime DateTime Default Now(),"
            sql = sql & "EditTime DateTime Default Now(),"
            sql = sql & "AddDate DateTime Default Now(),"
            sql = sql & "EditData DateTime Default Now(),"
            sql = sql & "EditCount Int Default 0,"
            sql = sql & "ViewCount Int Default 0,"
            sql = sql & "Through Int Default 0,"
            sql = sql & "Content Text Default """")"


            If MDBPath = "" Then sql = HandleSqlServer(sql)
            conn.Execute sql
        End If
    End Sub

End Class



%>



