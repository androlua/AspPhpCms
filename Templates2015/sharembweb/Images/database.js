//获得配置内容
function getConfig(){
var c='';
c+="#did|sid|tid|title|showtitle|content|default|topnumb|column|ulclass|liclass|spltypestr|addsql|autoadd|autoadddid|autoaddsid|autoaddtid\n";
c+="#target-_blank| \n";
c+="#lalblename--textbox  (单行文本，默认就是这种类型)\n";
c+="#lalblename--checkbox  (检查)\n";
c+="#lalblename--combobox (下拉菜单)\n";
c+="#lalblename--textboxline (多行文本)\n";
c+="#tablename-BigClass|fieldname-BigClassName|addsql-Where NavType=\'首页\'\n";
c+="#|testspan-1|column|inmodule rndshow--checkbox\n";
c+="#[$adddatetime format_time=\'1\' delhtml=\'true\' trim=\'true\' len=\'22\' deltabs=\'true\' $]   参数调用使用方法 len=长度，delhtml=删除html，trim=去除两边空格，deltabs=删除制表符\n";
c+="#smalladdsql   小类追加SQL    selectmodule-[$显示模板模块$]-combobox    isverificationcode-1-checkbox\n";
c+="\n";
c+="ASPPHP\n"; 
c+="	ColumnList (topnumb|default-[$栏目导航列表$]|flags-top|addsql-order by sortrank|testspan-1|inmodule)\n";
c+="	ColumnMenu (parentid--1|default-[$栏目无级菜单列表$]|addsql|testspan-1|inmodule\n";
c+="	ArticleList (parentid|columnname|topnumb-6|default-[$默认自定义导航详细$]|addsql|testspan-1|inmodule\n";
c+="	CommentList (itemid|topnumb-6|default-[$评论列表样式$]|addsql-where isthrough=1 order by adddatetime asc|testspan-1|inmodule\n";
c+="	SearchStatList (topnumb-6|through-1-checkbox|addsql-where isthrough=1 order by sortrank asc|default-[$默认自定义导航详细$]|testspan-1|inmodule\n";
c+="	GetOnePageBody (id|title|fieldname-simpleintroduction|addsql|autoadd|testspan-1|default|inmodule\n";
c+="	GetArticleBody (id|title-AspPhpCMS内容管理系统功能介绍|fieldname-simpleintroduction|addsql|autoadd|testspan-1|default|inmodule\n";
c+="	GetColumnBody (id|columnname-关于作者|fieldname-simpleintroduction|addsql|autoadd|testspan-1|default|inmodule|\n";
c+="	GetOnePageUrl (id|title|addsql|testspan-1|inmodule\n";
c+="	GetArticleUrl (id|title|addsql|testspan-1|inmodule\n";
c+="	GetColumnUrl (id|columnname|addsql|testspan-1|inmodule\n";
c+="	DisplayWrap (testspan-1|default|inmodule|\n";
c+="常用\n";
c+="	Include (file-head.html|findstr-11-textboxline|replacestr-22-textboxline|)\n";
c+="	WebSiteBottom (autoadd-1|default|testspan-1|column|inmodule\n";
c+="\n";
c+="文本\n";
c+="	MainInfo (title|showtitle|fieldname-bodycontent|autoadd-1|testspan-1|default|deletedefault-1-checkbox|delhtml--checkbox|trim--checkbox|onhtml-1-checkbox|len|fieldname|column|inmodule\n";
c+="	MainInfoA (title|showtitle|autoadd-1|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	MainInfoUrl (title|showtitle|autoadd-1|testspan|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	MainInfo_GetShowTitle (title|showtitle|autoadd-1|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	ShowThisText (testspan-1|default|deletedefault-1-checkbox|column|inmodule)\n";
c+="	GetMainParam (tablename-MainInfo|fieldname-Title,ShowTitle,Content,Id,WebTitle,WebKeywords,WebDescription,[url],Content-combobox|addsql-[$文本参数$]-combobox|testspan-1|inmodule\n";
c+="新闻\n";
c+="	News (did|sid|tid|topnumb-6|cutstrnumb-32|contentwidth|addsql|autoadddid-1|autoaddsid|autoaddtid|autoadd-1|dateyes-1|testspan-1|ulclass-ulstyleone|column|inmodule\n";
c+="	ShowNewsList (did|sid|tid|topnumb-6|cutstrnumb-32|autoadddid|autoaddsid|autoaddtid|autoadd|ulclass-ulstyleone|liclass-listyleone|aclass|dateyes-14|newsstyle-default,topphoto,footphoto,topphotonews,footphotonews,default-combobox|textclass-newstextright|imgclass-newsphotoleft|imgwidth|imgheight|testspan|column|inmodule\n";
c+="	RelatedInformationList (defaultrelatedlablelist-产品\\|新闻|selecttype-[$相关信息参数$]-combobox|topnumb-10|addsql- Order By Hits Desc|defaultaddsql- Where \\(BigClassName<>\'Banner\'\\)|cutstrnumb-32|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	CustomInfoList (did|sid|tid|topnumb-6|npagesize-6|cutstrnumb-32|autoadddid-1|autoaddsid|autoaddtid|autoadd-1|dispalypage-0-checkbox|addsql|defaultimage-/UploadFiles/NoImg.jpg|description|rndshow--checkbox|nofollow--checkbox|testspan-1|default|deletedefault-1-checkbox|column|replacestrname|defaultaddcontent--textboxline|inmodule\n";
c+="	GetArticleParam (tablename-Product|fieldname-BigClassName,SmallClassName,ThreeClassName,Content,BigFiles,SmallFiles,Id,Title,WebTitle,WebKeywords,WebDescription,[url],BigClassName-combobox|addsql-[$文章参数$]-combobox|testspan-1|inmodule\n";
c+="	getArticleInfo (default|deletedefault-1-checkbox\n";
c+="\n";
c+="产品\n";
c+="	ShowAppointProductList (did|sid|tid|topnumb-12|cutstrnumb-32|autoadddid|autoaddsid|autoaddtid|autoadd|templateid-产品展示样式一|imgwidth|imgheight|testspan|column|inmodule\n";
c+="	GetArticleParam (tablename-Product|fieldname-BigClassName,SmallClassName,ThreeClassName,Content,BigFiles,SmallFiles,Id,Title,WebTitle,WebKeywords,WebDescription,[url],BigClassName-combobox|addsql-[$文章参数$]-combobox|testspan-1|inmodule\n";
c+="导航\n";
c+="	GetNavParam (tablename-NavBigClass,NavSmallClass,NavBigClass-combobox|fieldname-BigClassName,Content,ImgPath,Id,NavType,WebTitle,WebKeywords,WebDescription,[url],BigClassName-combobox|addsql-[$导航参数$]-combobox|testspan-1|inmodule\n";
c+="	NavDidA (navdid|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	GetNavUrl (did|sid|testspan|inmodule)\n";
c+="	WebTopNav (focustype-text,a-|styleid-98|stylevalue-0|addsql- Where NavTop<>0 Order By Sort Asc|dropdownmenu-1-checkbox|isConcise-1-checkbox|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	WebBottomNav (aclass|spltypestr-&nbsp;\\|&nbsp;|addsql-Where NavButtom<>0  Order By Sort Asc|testspan-1|inmodule\n";
c+="	NavDidExists (navdid|valuestr-aa-textboxline|defaultstr-bb-textboxline)\n";
c+="\n";
c+="类别分类\n";
c+="	SmallClassList (did|autoadddid-1|ulclass|liclass|testspan-1|column|inmodule\n";
c+="	ThreeClassList (did|sid|tidatype-[$类别链接参数$]-combobox|autoadddid-1|autoaddsid-1|ulclass|liclass|testspan-1|column|inmodule\n";
c+="	CustomSmallClassList (did|topnumb-99|cutstrnumb-32|autoadddid-1|addsql|defaultimage-/UploadFiles/NoImg.jpg|rndshow--checkbox|autoadd-1|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	CustomTwoDirectoryClassList (Did-产品展示|sidatype-[$类别链接参数$]-combobox|tidatype-[$类别链接参数$]-combobox|addsql-order by sort|smalladdsql||autoadd-1|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="	FastNavigation (ulclass|liclass|aclass|focusclass|focustext-checkbox|defaultdid-网络营销推广|defaultsqltype-[$默认SQL类型$]-combobox|testspan-1|column|inmodule\n";
c+="	RecommendNavigation (ulclass|default-[$自动添加推荐导航$]|testspan-1|column|inmodule\n";
c+="\n";
c+="\n";
c+="	GetClassParam (tablename-BigClass,SmallClass,ThreeClass,BigClass-combobox|fieldname-BigClassName,SmallClassName,ThreeClassName,Content,ImgPath,Id,WebTitle,WebKeywords,WebDescription,[url],BigClassName-combobox|addsql-[$产品类别参数$]-combobox|testspan-1|inmodule\n";
c+="链接\n";
c+="	HrefA (href-www.baidu.com|title-baidu|class|target|testspan-1|column|inmodule\n";
c+="友情链接\n";
c+="	Links (spltypestr-\\||class|addsql-Where Through<>0 Order By Sort|testspan-1|column|inmodule\n";
c+="	FriendLinkLI (liclass|class|addsql-Where Through<>0 Order By Sort|testspan-1|column|inmodule\n";
c+="	LinkList (title|spltypestr|class|addsql-Where Through<>0 Order By Sort|testspan-1|column|inmodule\n";
c+="数据表\n";
c+="	GetTableList (sql-Select * from [NavBigClass] Where NavTop<>0 Order By Sort Asc|splitstr-vbcrlf|fieldnamelist-bigclassname,id|inmodule\n";
c+="	DeleteTable (tablename-BigClass|addsql-where id>0|operate-1-checkbox\n";
c+="循环\n";
c+="	ForArray (arraylist-aa\\|bb\\|cc|splitstr-\\||nloop-11|operate-1-checkbox|ishide-0-checkbox|default|deletedefault-1-checkbox\n";
c+="控制\n";
c+="	ResetRunAction (operate-1-checkbox)\n";
c+="	onLineViewDialog (operate-1-checkbox)\n";
c+="搜索\n";
c+="	PopularSearchesList (topnumb-12|autoadd|testspan-1|spltypestr|addsql|column|inmodule\n";
c+="图片\n";
c+="	ShowPhotoList (did|topnumb|autoadddid|autoadd|ayes-1-checkbox|aimg-1-checkbox|addsql|imgwidth|imgheight|imgclass|splstartstr|splendstr|column|testspan|inmodule\n";
c+="	zoomImage (imagefilepath-/Templates2015/C站页面设计/Images/welfarelistico.png|nsetwidth-26|nsetheight-26|nleft-40|ntop|stype-imgulmiddel|nwrapwidth|nwrapheight-50)\n";
c+="网站地图\n";
c+="	#SiteMap (class-sitemap|navaddsql-Where NavTop=true Order By Sort Asc|classaddsql|testspan-1|column|inmodule\n";
c+="	SiteMap (shieldnavdidlist|shieldnavsidlist|shielddidlist|shieldsidlist|shieldtidlist|testspan-1|column|inmodule\n";
c+="\n";
c+="网址\n";
c+="	GetDidAHrefUrl (did|testspan|inmodule)\n";
c+="	GetSidAHrefUrl (did|sid|testspan|inmodule)\n";
c+="	GetTidAHrefUrl (did|sid|tid|testspan|inmodule)\n";
c+="	GetProductUrl (did|sid|tid|title|addsql|testspan|inmodule)\n";
c+="留言\n";
c+="	CustomGuestBookList (topnumb-6|addsql|autoadd-1|testspan-1|default|deletedefault-1-checkbox|column|inmodule\n";
c+="\n";
c+="QQ\n";
c+="	QQLIStyleListShow (liclass|aclass|showqqphoto--checkbox|testspan-1|inmodule\n";
c+="	OnLineQQPopup (qqlist-313801120,123456|qqnamelist-技术,腾讯|site-|onqqdialogue-1-checkbox|onqqpopup-1-checkbox|testspan-1|inmodule\n";
c+="	GetOnLineQQUrl (title-在线QQ|qqlist-313801120,123456|autoadd-1|isonlinechat-1-checkbox|isaddfriend-1-checkbox|inmodule\n";
c+="统计\n";
c+="	JsWebStat (testspan-1|filename|inmodule)\n";
c+="Left栏目\n";
c+="	ReadColumeSetTitle (title-网站公告|style-312|stylevalue-0-textboxline|moreclass-leftmore|morestr-More|moreurl- -|titlewidth|titleheight|contentwidth|contentheight|testspan-1|value-[$读出内容 block=\\\'BlockName\\\' file=\\\'\\\'$]-textboxline|inmodule\n";
c+="模板\n";
c+="	ReadTemplateSource (sourceid-新闻列表一|testspan-1|column|inmodule\n";
c+="	ReadTemplateModule (file-[$模块目录$]Banner|moduleid-Banner|testspan-1|inmodule\n";
c+="	GetContentModule (file-|modulename-module_Banner|sourcelist-新闻中心[Array]-textboxline|replacelist--textboxline|testspan-1|inmodule\n";
c+="	ReplaceTemplateContent (sourcestr--textboxline|replacestr--textboxline|testspan-1|inmodule\n";
c+="	ShowTemplateModule (selectmodule-[$显示模板模块$]-combobox|defaultmodule-推荐导航\\|产品展示\\|联系我们【显示新联系】(http://www.baidu.com/)|testspan-1|inmodule\n";
c+="布局模块\n";
c+="	Layout (layoutname-红色)\n";
c+="	Module (moduletype|modulename-网站公告)\n";
c+="其它\n";
c+="	JsAutoUpdateWebPage (testspan-1|column|inmodule\n";
c+="位置\n";
c+="	Position (delimiter-|ndirectory-2|testspan|inmodule\n";
c+="Banner\n";
c+="	DetailBanner (defaultimage-/UploadFiles/Pic/4.jpg|testspan|inmodule\n";
c+="表单\n";
c+="	FormSubmit (did-测试|tablename-InputValue|formname-formdialog|classname-formdialog|Submitname-提交|resetname-重置|isverificationcode-1-checkbox|testspan-1|inmodule\n";
c+="缓存\n";
c+="	clearCache (operate-1-checkbox|testspan-1|inmodule)\n";
c+="调试\n";
c+="	DebugWebSkin (|testspan-1|inmodule\n";
c+="执行SQL\n";
c+="	executeSQL (sql-update [WebSite] set isHtmlFormatting=1,isWebLabelClose=1,isCnToEn=0|testspan-1|inmodule\n";
c+="自动添加\n";
c+="	BatchAutoAddProductClass (rootdiryes-1-checkbox|operate-1-checkbox|testspan-1|inmodule|default-[$自动添加产品分类$]\n";
c+="	BatchAutoAddNavClass (isaddfoldername-1-checkbox|rootdiryes-1-checkbox|isdeltable-0-checkbox|operate-1-checkbox|isfilenametopinyin-0-checkbox|testspan-1|inmodule|default-[$自动添加导航分类$]\n";
c+="	AutoAddDid (did-产品展示[Array]新闻中心|testspan-1|inmodule|default\n";
c+="	AutoAddSid (did-产品展示|sid-经典产品[Array]其它产品|testspan-1|inmodule|default\n";
c+="	AutoAddTid (did-产品展示|sid-经典产品|tid-经典1[Array]经典2|testspan-1|inmodule|default\n";
c+="	AutoAddProduct (did|sid|tid|title-在这里面写上信息标题[id]{@Array@}|topnumb-6|bigimage-[$WebImages$]/[id].jpg|smallimage|keywords|description|autoadddid-1|autoaddsid|originaltitleyes--checkbox|autoaddtid|testspan-1|inmodule|default-在这里面写上信息内容[id]\n";
c+="	AutoAddGuestBook (topnumb-6|guestname-小刘[id]|email-123456@qq.com|tel-025\\-12345[id]|qq|msn|ip|message-留言内容[id]-textboxline|reply-回答内容[id]-textboxline)\n";
c+="	AutoAddMainInfo (title|showtitle|content|testspan-1\n";
c+="	UpdateBigNav (did|content|testspan-1|inmodule\n";
c+="	AutoBatchAddArticle (folderpath|testspan-1|inmodule\n";
c+="	AutoAddInputConfig (did|FrontTitle|BackEndTitle|InputType-单文本,单文本居中,文本域,隐藏域,多选,单选,真假,下拉列表,验证码,单文本-combobox|FieldName-Str1|DefaultValue|InputWidth|InputHeight|VerificationType-无,不为空,电话,手机,邮箱,传真,数字-combobox|VerificationMsg|TipsText||sort-0|ListShow-1-checkbox|Through-1-checkbox|testspan-1|inmodule\n";
c+="	BatchAutoAddDetail (|testspan-1|inmodule|default-[$批量自动添加产品细节$]\n";
c+="	BatchAutoAddNavClass (isaddfoldername-1-checkbox|rootdiryes-1-checkbox|isdeltable-0-checkbox|operate-1-checkbox|isfilenametopinyin-0-checkbox|testspan-1|inmodule|default-[$自动添加导航分类$]\n";
c+="\n";
c+="==========================\n";
c+="::::文本::::\n";
c+="{$MainInfo title=\'联系电话\' showtitle=\'网站顶部联系电话\' default=\'[Tel400]\' autoadd=\'true\'$}\n";
c+="==========================\n";
c+="\n";
c+="\n";
c+="#函数说明帮助#\n";
c+="#帮助文档  单个文本\n";
c+="MainInfo(显示文本内容)\n";
c+="MainInfoA(显示文本链接)\n";
c+="MainInfoUrl(显示文本网址)\n";
c+="MainInfo_GetShowTitle(显示文本显示标题)\n";
c+="ShowThisText(显示模板里指定文本)\n";
c+="GetMainParam(获得单个文本参数内容)\n";
c+="#帮助文档 新闻列表\n";
c+="News(显示新闻 默认版)\n";
c+="ShowNewsList(显示新闻列表 第二种)\n";
c+="CustomInfoList(自定义信息列表)\n";
c+="JsWebStat(JS版网站统计)\n";
c+="GetNavUrl(获得导航网址)\n";
c+="NavDidExists(当前导航大类存在)\n";
c+="\n";
c+="[$CustomInfoList 日志$] start\n";
c+=" 通用样式[list][$title$][$showtitle$][$datetime$][$imgfile$][$url$][$datetime$][$description$][$content$][$price$][/list]  \n";
c+="指定第一条样式[list-1][/list-1]   框架头部代码[dialog start][/dialog start]  框架底部代码[dialog end][/dialog end] \n";
c+="指定列表头部代码[list-2 startdialog][/list-2 startdialog] 指定列表底部代码[list-2 enddialog][/list-2 enddialog]\n";
c+="[$adddatetime format_time=\'2\'$]\n";
c+="[$title len=\'30\' delhtml=\'true\' trim=\'true\' deltabs=\'true\' $]\n";
c+="[$content len=\'60\' delhtml=\'true\' trim=\'true\' deltabs=\'true\' $]\n";
c+="[$articledescription len=\'60\' delhtml=\'true\' trim=\'true\' deltabs=\'true\' $]\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="[defaulthomePageStr] 默认首页 [/defaulthomePageStr]\n";
c+="[defaultparentPageStr] 默认上一页 [/defaultparentPageStr]\n";
c+="\n";
c+="[homePageStr] <a href=[$url$]>首-页</a> [/homePageStr]\n";
c+="[parentPageStr] <a href=[$url$]>上A一A页</a> [/parentPageStr]\n";
c+="\n";
c+="[defaultnextPageStr] 默认下一页 [/defaultnextPageStr]\n";
c+="[defaultendPageStr] 默认尾页 [/defaultendPageStr]\n";
c+="\n";
c+="[nextPageStr] <a href=[$url$]>下A一A页</a> [/nextPageStr]\n";
c+="[endPageStr] <a href=[$url$]>尾-页</a> [/endPageStr]\n";
c+="\n";
c+="[page]\n";
c+="总数：[$nCount$]条&nbsp;&nbsp;当前页数：<span class=\'FontRed\'>[$Page$]</span>/[$MaxPage$] | \n";
c+="[$homePageStr$] | [$parentPageStr$] | [$nextPageStr$] | [$endPageStr$]\n";
c+="[/page]\n";
c+="\n";
c+="[$CustomInfoList 日志$] end\n";
c+="\n";
c+="RelatedInformationList(相关新闻列表)\n";
c+="\n";
c+="[$RelatedInformationList 日志$] start\n";
c+=" 通用样式[list][$title$][$showtitle$][$datetime$][$imgfile$][$url$][$datetime$][$description$][$content$][$price$][/list]  指定第一条样式[list-1][/list-1]   框架头部代码[dialog start][/dialog start]  框架底部代码[dialog end][/dialog end] 指定列表头部代码[list-2 startdialog][/list-2 startdialog] 指定列表底部代码[list-2 enddialog][/list-2 enddialog]\n";
c+="[$RelatedInformationList 日志$] end\n";
c+="\n";
c+="CustomGuestBookList(自定义留言列表)\n";
c+="[$CustomGuestBookList 日志$] start\n";
c+="通用样式[list][$title$][$showtitle$][$datetime$][$imgfile$][$url$][$datetime$][$description$][$content$][$price$][/list]  指定第一条样式[list-1][/list-1]   框架头部代码[dialog start][/dialog start]  框架底部代码[dialog end][/dialog end] 指定列表头部代码[list-2 startdialog][/list-2 startdialog] 指定列表底部代码[list-2 enddialog][/list-2 enddialog]\n";
c+="[$CustomGuestBookList 日志$] end\n";
c+="\n";
c+="GetArticleParam(获得文章参数内容)\n";
c+="#帮助文档 产品列表\n";
c+="ShowAppointProductList(显示动作产品列表 效果好看)\n";
c+="#帮助文档  导航\n";
c+="GetNavParam(获得导航参数值 字段名[url]为显示网址)\n";
c+="#帮助文档  产品类别展示\n";
c+="SmallClassList(展示小类列表)\n";
c+="\n";
c+="CustomSmallClassList(自定义小类类别列表)\n";
c+="[$CustomSmallClassList 日志$] start\n";
c+=" 通用样式[list][$imgfile$][$url$][$datetime$][$description$][/list]  指定第一条样式[list-1][/list-1]   框架头部代码[dialog start][/dialog start]  框架底部代码[dialog end][/dialog end] 指定列表头部代码[list-2 startdialog][/list-2 startdialog] 指定列表底部代码[list-2 enddialog][/list-2 enddialog]\n";
c+="[$CustomSmallClassList 日志$] end\n";
c+="\n";
c+="ThreeClassList(展示子类列表)\n";
c+="CustomTwoDirectoryClassList(自定义二级目录分类列表)\n";
c+="[$CustomTwoDirectoryClassList 日志$] start\n";
c+=" Directory目录\n";
c+="[$CustomTwoDirectoryClassList 日志$] end\n";
c+="\n";
c+="\n";
c+="GetClassParam(获得产品类别参数内容)\n";
c+="FastNavigation(快速导航)\n";
c+="RecommendNavigation(推荐导航，给内页左边使用)\n";
c+="#帮助文档 【友情链接】\n";
c+="Links(显示友情链接列表简单版)\n";
c+="FriendLinkLI(显示友情链接列表自定LI版)\n";
c+="ColumnList(自定义导航列表)\n";
c+="GetTableList(获得表列表)\n";
c+="\n";
c+="[$CustomInfoList 日志$] start\n";
c+="引用值为<replacestrname 1/>  or <replacestrname 1></replacestrname 1>\n";
c+="[$CustomInfoList 日志$] end\n";
c+="\n";
c+="ResetRunAction(重新运行动作)\n";
c+="getArticleInfo(获得文章信息)\n";
c+="DeleteTable(删除表)\n";
c+="onLineViewDialog(在线显示预览面板)\n";
c+="FormSubmit(显示表单提交面板)\n";
c+="[$FormSubmit 日志$] start\n";
c+="http://127.0.0.1/获得数据库数据.Asp  获得表单追加列表\n";
c+="[$FormSubmit 日志$] end\n";
c+="\n";
c+="\n";
c+="#帮助文档  搜索\n";
c+="PopularSearchesList(热门搜索列表展示)\n";
c+="#帮助文档  图片\n";
c+="ShowPhotoList(显示图片列表)\n";
c+="#帮助文档  网址\n";
c+="GetDidAHrefUrl(显示大类链接地址)\n";
c+="GetSidAHrefUrl(显示小类链接地址)\n";
c+="GetTidAHrefUrl(显示子类链接地址)\n";
c+="GetProductUrl(显示产品网址)\n";
c+="#帮助文档 QQ\n";
c+="QQLIStyleListShow(QQ浮动面板显示)\n";
c+="OnLineQQPopup(在线QQ弹窗)\n";
c+="GetOnLineQQUrl(在线QQJS版可添加好友，批量版)\n";
c+="#帮助文档  常用\n";
c+="WebBottomNav(网站底部导航菜单)\n";
c+="WebSiteBottom(网站底部内容)\n";
c+="Include(加载模板 也可以指定一块)\n";
c+="\n";
c+="#帮助文档  Left栏目\n";
c+="ReadColumeSetTitle(读Left栏目)\n";
c+="[$ReadColumeSetTitle 日志$] start\n";
c+="parameter参数  数字 当为文本时就从数组里提取\n";
c+="value=\'[$读出内容 block=\\\'BlockName\\\' file=\\\'\\\'$][$读出内容 block=\\\'BlockName2\\\' file=\\\'\\\'$]\'  简单调用<R#读出内容BlockName Test在这里面写上内容呀#> 复杂调用<R#读出内容BlockName2 start#>第二种调用方法<R#读出内容test end#>\n";
c+="[$ReadColumeSetTitle 日志$] end\n";
c+="\n";
c+="\n";
c+="#帮助文档  模板\n";
c+="ReadTemplateSource(读出模板资源某样式)\n";
c+="ReadTemplateModule(读出模块内容)\n";
c+="GetContentModule(获得内容模块 和ReadTemplateModule效果一样)\n";
c+="[$GetContentModule 日志$] start\n";
c+="<!--#Module 模块名称 Start#-->\n";
c+="模块内容\n";
c+="<!--#Module 模块名称 End#-->\n";
c+="[$GetContentModule 日志$] end\n";
c+="executeSQL(执行SQL)\n";
c+="clearCache(清除缓冲)\n";
c+="DisplayWrap(显示包裹块，主要是引用别的地方内容，常在VB里用到)\n";
c+="\n";
c+="<$result GetContentModule\n";
c+="\n";
c+="#################### 栏目名称 {VB getLableValue labelname=\'modulename\'}\n";
c+="<text default=\'<!--#dialogtest start#--><!--#Module {VB getLableValue labelname=\'modulename\'} Start#-->\'/>\n";
c+="<dIv>\n";
c+="<text default=\'第一种方法\'/>\n";
c+="</dIv>\n";
c+="<text default=\'<!--#Module {VB getLableValue labelname=\'modulename\'} End#--><!--#dialogtest end#-->\'/>\n";
c+="\n";
c+="\n";
c+="<!--#Module {VB getLableValue labelname=\'modulename\'} Start#-->\n";
c+="可以在配置文件里修改\n";
c+="<!--#Module {VB getLableValue labelname=\'modulename\'} End#-->\n";
c+="\n";
c+="\n";
c+="$>\n";
c+="ReplaceTemplateContent(替换模板内容)\n";
c+="ArticleList(细节列表 ASPPHP通用)\n";
c+="Layout(布局)\n";
c+="Module(模块)\n";
c+="GetColumnUrl(获得栏目网址)\n";
c+="GetArticleUrl(获得文章网址)\n";
c+="GetOnePageUrl(获得单页网址)\n";
c+="GetColumnContent(获得栏目内容) \n";
c+="SearchStatList(搜索统计)\n";
c+="CommentList(评论列表)\n";
c+="GetOnePageBody(获得单面内容)\n";
c+="GetArticleBody(获得文章内容)\n";
c+="GetColumnBody(获得栏目内容)\n";
c+="\n";
c+="#帮助文档  自动添加\n";
c+="BatchAutoAddProductClass(批量添加产品类别用VbTab作为级别分类)\n";
c+="AutoAddDid(自动添加大类)\n";
c+="AutoAddSid(自动添加小类)\n";
c+="AutoAddTid(自动添加子类)\n";
c+="AutoAddProduct(自动添加产品信息  图片可以用这个代替 /UploadFiles/NoImg.jpg)\n";
c+="AutoAddGuestBook(自动添加留言信息)\n";
c+="AutoAddMainInfo(自动添加文本信息)\n";
c+="AutoBatchAddArticle(自动批量添加文章)\n";
c+="AutoAddInputConfig(自动添加导入配置,20151110加注释)\n";
c+="BatchAutoAddDetail(批量自动添加产品细节)\n";
c+="JsAutoUpdateWebPage(Javascript自动更新网页)\n";
c+="UpdateBigNav(更新大类导航) \n";
c+="DebugWebSkin(调试网站皮肤)\n";
c+="#帮助文档  Banner\n";
c+="DetailBanner(详细页Banner图)\n";
c+="ShowTemplateModule(显示模板模块)\n";
c+="NavDidA(显示导航大类链接)\n";
c+="WebTopNav(网站导航显示)\n";
c+="\n";
c+="ForArray(循环自定义数组)\n";
c+="[$ForArray 日志$] start\n";
c+="[$i$]=[$id$] 等同   [$title$] [$count$]\n";
c+="[$ForArray 日志$] end\n";
c+="\n";
c+="zoomImage(缩放图片)\n";
c+="DisplayArticle(显示文章)\n";
c+="ColumnMenu(栏目菜单)\n";
c+="\n";
c+="#标签名称说明#\n";
c+="did(大类名称)\n";
c+="sid(小类名称)\n";
c+="tid(子类名称)\n";
c+="defaultsqltype(默认SQL类型)\n";
c+="defaultdid(默认大类名称)\n";
c+="title(标题名称)\n";
c+="showtitle(显示标题)\n";
c+="content(文本内容)\n";
c+="default(默认内容)\n";
c+="topnumb(显示条数)\n";
c+="column(栏目Style)\n";
c+="ulclass(UL Class)\n";
c+="liclass(LI Class)\n";
c+="spltypestr(字符间分割内容)\n";
c+="addsql(追加SQL)\n";
c+="defaultaddsql(默认追加SQL)\n";
c+="autoadd(自动添加)\n";
c+="autoadddid(自动添加大类)\n";
c+="autoaddsid(自动添加小类)\n";
c+="autoaddtid(自动添加子类)\n";
c+="bigimage(大图地址)\n";
c+="smallimage(小图地址)\n";
c+="testspan(测试Span)\n";
c+="inmodule(内部嵌套模块)\n";
c+="width(显示宽度)\n";
c+="height(显示高度)\n";
c+="alt(显示alt )\n";
c+="class(显示Class)\n";
c+="focusclass(交点Class)\n";
c+="target(打开方式)\n";
c+="\n";
c+="ayes(是否显示链接)\n";
c+="aimg(是否显示图片)\n";
c+="imgwidth(图片宽度)\n";
c+="imgheight(图片高度)\n";
c+="imgalt(图片alt )\n";
c+="imgtitle(图片标题)\n";
c+="imgclass(图片Class)\n";
c+="\n";
c+="splstartstr(开始字符)\n";
c+="splendstr(结束字符)\n";
c+="\n";
c+="awidth(链接宽度)\n";
c+="aheight(链接高度)\n";
c+="aalt(链接alt )\n";
c+="atitle(链接标题)\n";
c+="aclass(链接Class)\n";
c+="focusaclass(焦点链接Class)\n";
c+="focustext(焦点以文本显示)\n";
c+="\n";
c+="newsstyle(新闻样式)\n";
c+="onwphotonewsyes(一条图片新闻)\n";
c+="\n";
c+="dateyes(显示时期)\n";
c+="cutstrnumb(截取字符)\n";
c+="\n";
c+="textclass(文本Class)\n";
c+="templateid(读取模板ID)\n";
c+="\n";
c+="keywords(网站关键词)\n";
c+="description(网站描述)\n";
c+="file(文件路径)\n";
c+="\n";
c+="tablename(表名称)\n";
c+="fieldname(字段名称)\n";
c+="\n";
c+="navdid(导航大类名称)\n";
c+="jswebstat(网站统计)\n";
c+="sourceid(资源ID)\n";
c+="moduleid(模块ID)\n";
c+="modulename(模块名称)\n";
c+="showqqphoto(显示QQ头像)\n";
c+="navaddsql(导航追加SQL)\n";
c+="classaddsql(产品类追加SQL)\n";
c+="\n";
c+="guestname(留言者)\n";
c+="email(邮箱)\n";
c+="message(留言内容)\n";
c+="reply(回答内容)\n";
c+="tel(联系电话)\n";
c+="qq(联系QQ)\n";
c+="msn(联系MSN)\n";
c+="ip(IP地址)\n";
c+="defaultimage(默认图片)\n";
c+="rndshow(随机显示)\n";
c+="style(样式)\n";
c+="moreclass(更多链接样式)\n";
c+="moreurl(更多链接网址)\n";
c+="morestr(更多链接文字)\n";
c+="value(内容文本)\n";
c+="selecttype(选择类型)\n";
c+="href(超链接)\n";
c+="delimiter(分隔符)\n";
c+="sidatype(小类链接类型)\n";
c+="tidatype(子类链接类型)\n";
c+="operate(操作)\n";
c+="dropdownmenu(下拉菜单)\n";
c+="focustype(焦点类型)\n";
c+="rootdiryes(是否为主目录文件夹)\n";
c+="folderpath(文件夹路径)\n";
c+="originaltitleyes(是否原标题)\n";
c+="defaultrelatedlablelist(默认相关标签列表)\n";
c+="nofollow(不追踪)\n";
c+="\n";
c+="shieldnavdidlist(屏蔽导航大类列表)\n";
c+="shieldnavsidlist(屏蔽导航小类列表)\n";
c+="shielddidlist(屏蔽类别大类列表)\n";
c+="shieldsidlist(屏蔽类别小类列表)\n";
c+="shieldtidlist(屏蔽类别子类列表)\n";
c+="\n";
c+="ndirectory(显示目录数)\n";
c+="titlewidth(标题宽度)\n";
c+="titleheight(标题高度)\n";
c+="contentwidth(内容宽度)\n";
c+="contentheight(内容高度)\n";
c+="sourcelist(源内容列表)\n";
c+="replacelist(替换内容列表)\n";
c+="qqlist(QQ号列表)\n";
c+="qqnamelist(QQ名称列表)\n";
c+="site(网站)\n";
c+="onqqdialogue(启用QQ对话)\n";
c+="onqqpopup(启用QQ弹窗)\n";
c+="sourcestr(源内容)\n";
c+="replacestr(替换内容)\n";
c+="isonlinechat(是在线聊天)\n";
c+="isaddfriend(是加为好友)\n";
c+="delhtml(是否清除HTML)\n";
c+="trim(清除两边空格)\n";
c+="len(截取字符长度)\n";
c+="smalladdsql(小类追加SQL)\n";
c+="selectmodule(选择模块)\n";
c+="defaultmodule(默认模块 以|分割)\n";
c+="classname(Css样式名称)\n";
c+="isverificationcode(是否需要验证码)\n";
c+="formname(表单名称)\n";
c+="fronttitle(前端标题)\n";
c+="backendtitle(后端标题)\n";
c+="inputtype(input类型)\n";
c+="defaultvalue(默认内容)\n";
c+="inputwidth(input宽度)\n";
c+="inputheight(input高度)\n";
c+="verificationtype(验证类型)\n";
c+="verificationmsg(验证回显信息)\n";
c+="listshow(列表显示)\n";
c+="through(推荐)\n";
c+="tipstext(提示信息)\n";
c+="sort(排序)\n";
c+="submitname(提交按钮名称)\n";
c+="resetname(重置按钮名称)\n";
c+="isconcise(简洁显示)\n";
c+="onhtml(生成HTML文件)\n";
c+="\n";
c+="styleid(样式ID)\n";
c+="stylevalue(样式内容)\n";
c+="valuestr(赋值内容)\n";
c+="isdeltable(是否删除表)\n";
c+="isaddfoldername(是否添加目录名称)\n";
c+="sql(SQL)\n";
c+="splitstr(分割字符)\n";
c+="fieldnamelist(字段名称列表)\n";
c+="ishide(是隐藏)\n";
c+="arraylist(数组列表)\n";
c+="replacestrname(替换字符类型)\n";
c+="deletedefault(删除默认值)\n";
c+="defaultaddcontent(默认添加内容)\n";
c+="parameter(参数)\n";
c+="defaultstr(默认内容)\n";
c+="isfilenametopinyin(生成html文件名称转拼音)\n";
c+="dispalypage(显示翻页信息)\n";
c+="npagesize(每页显示数)\n";
c+="findstr(查的字符)\n";
c+="replacestr(替换字符)\n";
c+="replacetype(替换类型)\n";
c+="nloop(循环数)\n";
c+="imagefilepath(图片路径)\n";
c+="nsetwidth(设置宽)\n";
c+="nsetheight(设置高)\n";
c+="nleft(左边数值)\n";
c+="ntop(顶部数值)\n";
c+="stype(设置类型)\n";
c+="nwrapwidth(包宽=盒子宽)\n";
c+="nwrapheight(包高=盒子高)\n";
c+="layoutname(布局名称)\n";
c+="moduletype(模块类型)\n";
c+="modulename(模块名称)\n";
c+="columnname(栏目名称)\n";
c+="value1(值一)\n";
c+="value2(值二)\n";
c+="filename(文件名称)\n";
c+="id(ID编号)\n";
c+="flags(旗)\n";
c+="parentid(父栏目ID)\n";
c+="itemid(项目ID)\n";
c+="#============ ComboBox列表处理区 ============\n";
c+="[$导航参数$] start\n";
c+="Where NavType=\'首页\'\n";
c+="Where BigClassName=\'微战略首页\'\n";
c+="[$导航参数$] end\n";
c+="\n";
c+="\n";
c+="[$产品类别参数$] start\n";
c+="Where BigClassName=\'Banner\'\n";
c+="Where BigClassName=\'Banner\' And SmallClassName=\'11\'\n";
c+="[$产品类别参数$] end\n";
c+="\n";
c+="\n";
c+="[$文章参数$] start\n";
c+="Where BigClassName=\'Banner\'\n";
c+="Where BigClassName=\'Banner\' And SmallClassName=\'11\' And ThreeClassName=\'22\'\n";
c+="Where BigClassName=\'Logo\' And Recommend=1\n";
c+="Where BigClassName=\'Adv\' And Recommend=1\n";
c+="[$文章参数$] end\n";
c+="\n";
c+="\n";
c+="[$文本参数$] start\n";
c+="Where Title=\'关于我们\'\n";
c+="Where Title=\'联系电话\'\n";
c+="[$文本参数$] end\n";
c+=" \n";
c+="\n";
c+="[$相关信息参数$] start\n";
c+="根据相关信息\n";
c+="根据相关信息\n";
c+="根据相关标签\n";
c+="[$相关信息参数$] end\n";
c+="\n";
c+="[$类别链接参数$] start\n";
c+="产品列表类型\n";
c+="产品列表类型\n";
c+="文本类型\n";
c+="Main文本类型\n";
c+="[$类别链接参数$] end\n";
c+="\n";
c+="\n";
c+="[$显示模板模块$] start\n";
c+="TopModule\n";
c+="BottomModule\n";
c+="LeftModule\n";
c+="MiddleModule\n";
c+="RightModule\n";
c+="[$显示模板模块$] end\n";
c+="\n";
c+="\n";
c+="[$默认SQL类型$] start\n";
c+="nav\n";
c+="product\n";
c+="[$默认SQL类型$] end\n";
c+="\n";
c+="\n";
c+="\n";
c+="[$自动添加推荐导航$] start\n";
c+="\n";
c+="走近元朗|联系元朗(http://www.baidu.com)|服务与支持\n";
c+="公司资质|合作客户|企业相册\n";
c+="元朗动态|行业新闻|技术下载|常见问题\n";
c+="\n";
c+="[$自动添加推荐导航$] end\n";
c+="\n";
c+="[$自动添加产品分类$] start\n";
c+="大\n";
c+="	小\n";
c+="    小2\n";
c+="    小3\n";
c+="    	子\n";
c+="        子2\n";
c+="	二\n";
c+="    	三\n";
c+="        三2\n";
c+="[$自动添加产品分类$] end\n";
c+="\n";
c+="[$自动添加导航分类$] start\n";
c+="\n";
c+="did=\'微战略首页\' navtype=\'首页\' filename=\'\' template=\'\' navlocation=\'顶部\'\n";
c+="did=\'全网代运营\' navtype=\'文本\' filename=\'QuanWangDaiYunYing.html\' navlocation=\'顶部\'\n";
c+="did=\'营销型网站\' navtype=\'文本\' filename=\'YingXiaoXingWangZhan.html\' navlocation=\'顶部\'\n";
c+="did=\'手机网站\' navtype=\'文本\' filename=\'ShouJiWangZhan.html\' content=\'自定义文本\' navlocation=\'顶部\'\n";
c+="did=\'网络营销推广\' navtype=\'新闻\' filename=\'WangLuoYingXiaoTuiGuang.html\' navlocation=\'顶部\'\n";
c+="did=\'热点\' navtype=\'新闻\' filename=\'\' foldername=\'111\' template=\'Index_Model.Html\' navlocation=\'顶部\'\n";
c+="\n";
c+="did=\'经典案例\' navtype=\'产品\' navlocation=\'顶部\'\n";
c+="	sid=\'网站营销案例\'\n";
c+="	sid=\'营销型网站案例\'\n";
c+="	sid=\'合作客户\'\n";
c+="	sid=\'客户见证\'\n";
c+="did=\'关于微战略\' navtype=\'文本\' navlocation=\'顶部\'\n";
c+="	sid=\'微战略风采\'\n";
c+="	sid=\'联系微战略\'\n";
c+="	sid=\'公司动态\'\n";
c+="did=\'小云\' navtype=\'文本\' navlocation=\'顶部\'\n";
c+="	sid=\'二1\'\n";
c+="	sid=\'二2\'\n";
c+="	sid=\'二3\'\n";
c+="\n";
c+="did=\'网站地图\' navtype=\'文本\' navlocation=\'底部\'\n";
c+="\n";
c+="\n";
c+="#did=\'网站地图\' navtype=\'文本\' navlocation=\'底部\' filename=\'this(为当前标题名称)|thistemplate(为当前模板名称)\'\n";
c+="\n";
c+="[$自动添加导航分类$] end\n";
c+=" \n";
c+="\n";
c+="[$批量自动添加产品细节$] start\n";
c+="\n";
c+="========================东方紫 \n";
c+="【title】=东方紫 白兰地 \n";
c+="【url】=http://product.dfz9.com/detail-2.html \n";
c+="【image】=Images/fanlitu/1.png \n";
c+="【price】=￥9980元 \n";
c+="【originalprice】=￥10000元 \n";
c+="----------------------------- \n";
c+="\n";
c+="【title】=东方紫·甜紫 \n";
c+="【url】=http://product.dfz9.com/detail-21.html \n";
c+="【image】=Images/fanlitu/2.png \n";
c+="【price】=￥103元 \n";
c+="【originalprice】=￥128元 \n";
c+="----------------------------- \n";
c+="\n";
c+="【title】=东方紫·紫赢 \n";
c+="【url】=http://product.dfz9.com/detail-22.html \n";
c+="【image】=Images/fanlitu/3.png \n";
c+="【price】=￥135元 \n";
c+="【originalprice】=￥168元 \n";
c+="----------------------------- \n";
c+="\n";
c+="【title】=东方紫·紫宴 \n";
c+="【url】=http://product.dfz9.com/detail-23.html \n";
c+="【image】=Images/fanlitu/4.png \n";
c+="【price】=￥239元 \n";
c+="【originalprice】=￥298元 \n";
c+="----------------------------- \n";
c+="\n";
c+="[$批量自动添加产品细节$] end\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="#============ 函数参数调用帮助信息(帮助信息) ============\n";
c+="\n";
c+="[#显示默认帮助信息#] start\n";
c+="[$adddatetime format_time=\'2\'$]\n";
c+="[$title len=\'30\' delhtml=\'true\' trim=\'true\' deltabs=\'true\' $]\n";
c+="[$content len=\'60\' delhtml=\'true\' trim=\'true\' deltabs=\'true\' $]\n";
c+="[$articledescription len=\'60\' delhtml=\'true\' trim=\'true\' deltabs=\'true\' $]\n";
c+="此处在 模板代码创建生成器.ini  里修改【显示帮助中心】块修改\n";
c+="[dialog start]头部内容[/dialog start]\n";
c+="[dialog end]尾部内容[/dialog end]\n";
c+="\n";
c+="[#显示默认帮助信息#] end\n";
c+="\n";
c+="\n";
c+="[#ReadColumeSetTitle#] start\n";
c+="<!--#[_产品展示2014年11月18日 13时37分]\n";
c+="[$读出内容 block=\'testA\' file=\'\'$]\n";
c+="#--> \n";
c+="<R#读出内容testA start#>\n";
c+="内容\n";
c+="<R#读出内容testA end#>\n";
c+="\n";
c+="标题可切换代码20150115\n";
c+="CSS部分\n";
c+="a.teston{\n";
c+="	color:#FF0000\n";
c+="}\n";
c+="a.testoff{\n";
c+="	color:#0000CC;\n";
c+="}\n";
c+="标题部分\n";
c+="<a href=\"1.asp\" class=\"teston\" id=\"TabM1\" onmousemove=\"switchTab(1, 2, \'TabM\', \'ConM\', \'test\')\">网站公告</a>&nbsp;|&nbsp;<a href=\"1.asp\" class=\"testoff\" id=\"TabM2\" onmousemove=\"switchTab(2, 2, \'TabM\', \'ConM\', \'test\')\">网站新闻</a>\n";
c+="内容部分\n";
c+="<div id=\"ConM1\">\n";
c+="111111\n";
c+="</div>\n";
c+="<div id=\"ConM2\" style=\"display:none\">\n";
c+="2222\n";
c+="</div>\n";
c+="[#ReadColumeSetTitle#] end\n";
c+="\n";
c+="\n";
c+="[#WebTopNav#] start\n";
c+="<!--#moduleHtmlNavStart#-->{$ReadTemplateModule file=\'[$模块目录$]Nav\' moduleid=\'Nav\'$} <!--#moduleHtmlNavStart#-->\n";
c+=" Where NavButtom<>0 Order By Sort Asc\n";
c+="NavTop NavButtom NavLeft NavContent NavRight NavOthre\n";
c+="\n";
c+="navvaluerepeat=\'false\'   导航选中背景图片不重复，在底部居中显示\n";
c+="CssLeftPadding = \"0 0 1px 20px\"     CssLeft Padding样式设置  (注意想让向左边空隙20px，就必需把底设置1px，要不然显示不出效果)\n";
c+="[#WebTopNav#] end\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="[#CustomInfoList#] start\n";
c+="[htmlcode] HTML内容 [/htmlcode]\n";
c+="[list-mod2] 余 [/list-mod2]\n";
c+="\n";
c+="[$Module_1$] [$Module_2$] [$Module_3$] [$Module_4$]    替换指定区域标签\n";
c+="\n";
c+="\n";
c+="[$Array$] [$vbCrlf$]14:56 15-01-12\n";
c+="\n";
c+="[#CustomInfoList#] end\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="\n";
c+="#### 自定义二级目录分类列表 ####\n";
c+="[#CustomTwoDirectoryClassList#] start\n";
c+="\n";
c+="例子：\n";
c+="<sPAn class=\"testspan\">{$CustomTwoDirectoryClassList did=\'产品展示\' default=\'[_产品展示2014年11月27日 14时11分]\'$}</sPAn>\n";
c+="<!--#[_产品展示2014年11月27日 14时11分]\n";
c+="大体框架\n";
c+="[dialog start]<div id=\"firstpane\" class=\"pmenu_list\">[/dialog start] \n";
c+="[dialog end]</div>[/dialog end]\n";
c+="小类内容\n";
c+="[smalllist]    <div class=\"menu_head\">[$smallname$]</div>[/smalllist]\n";
c+="[smalllist-1]    <div class=\"menu_head current\">[$smallname$]</div>[/smalllist-1]\n";
c+="小类框架\n";
c+="[smalldialog start]    <ul style=\"display:none\" class=menu_body >[/smalldialog start] \n";
c+="[smalldialog end]    </ul>[/smalldialog end]\n";
c+="子类内容\n";
c+="[threelist]        <li><a href=\"[$threeurl$]\">[$threename$]</a></li>[/threelist]\n";
c+="#-->\n";
c+="\n";
c+="例子二：\n";
c+="<sPAn class=\"testspan\">{$CustomTwoDirectoryClassList did=\'自定义链接\' default=\'[_产品展示2014年11月27日 14时11分]\'$}</sPAn>\n";
c+="<!--#[_产品展示2014年11月27日 14时11分]\n";
c+="大体框架\n";
c+="[dialog start][/dialog start] \n";
c+="[dialog end][/dialog end]\n";
c+="小类内容\n";
c+="[smalllist]<li>[$smallname$][/smalllist] \n";
c+="小类框架\n";
c+="[smalldialog start]<ul>[/smalldialog start] \n";
c+="[smalldialog end]</ul></li>[/smalldialog end]\n";
c+="子类内容\n";
c+="[threelist]        <li><a href=\"[$threeurl$]\">[$threename$]</a></li>[/threelist]\n";
c+="#-->\n";
c+="\n";
c+="\n";
c+="\n";
c+="[#CustomTwoDirectoryClassList#] end\n";
c+="\n";
c+="\n";
c+="[$栏目导航列表$] start\n";
c+="[list]<li><a href=\"[$url$]\">[$columnname$]</a></li>[/list]\n";
c+="[list-focus]<li><a href=\"[$url$]\"><font color=red>[$columnname$]</font></a></li>[/list-focus]\n";
c+="[$栏目导航列表$] end\n";
c+="\n";
c+="[$栏目无级菜单列表$] start\n";
c+="[list]<li><a href=\"[$url$]\">[$columnname$]</a></li>[/list] \n";
c+="[list-focus]<li><a href=\"[$url$]\"><font color=red>[$columnname$]</font></a></li>[/list-focus]\n";
c+="\n";
c+="[subheader]<ul class=\'aa\'>\n";
c+="[/subheader]\n";
c+="[subfooter]</ul>\n";
c+="[/subfooter]\n";
c+="[$栏目无级菜单列表$] end\n";
c+="\n";
c+="[$评论列表样式$] start\n";
c+="[list]<li>姓名：[$username$] IP：[$ip$] 时间：[$adddatetime$] 评论：[$bodycontent$]<hr>回复：[$reply$]<br><br>[/list] \n";
c+="[$评论列表样式$] end\n";
c+="\n";
c+="[$默认自定义导航详细$] start\n";
c+="[list]<li><a href=\"[$url$]\">[$title$]</a></li>[/list]\n";
c+="[list-focus]<li><a href=\"[$url$]\"><font color=red>[$title$]</font></a></li>[/list-focus]\n";
c+="[$默认自定义导航详细$] end\n";
c+="\n";
c+="\n";
c+="\n";
c+="labelStartStr=\'{$\'\n";
c+="labelEndStr=\'$}\'\n";
c+="isCodeAddNote=\'true\'\n";
c+="\n";
return c;
}