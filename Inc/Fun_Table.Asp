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
<%






Function ShowClassName(a, b, c,d, e)
	Dim f,g,h,i,j,k
	Dim l,m,n,o,p,q,r,s,t,u
	Dim v,w,x,y
	Dim z,aa,ba,ca, da,ea, fa
	Dim ga,ha,ia,ja,ka,la,ma,na,oa
	Dim pa,qa,ra,sa,ta,ua,va
	Dim wa,xa,ya,za,abb,bbb,cbb,dbb,ebb
	Dim fbb,gbb,hbb,ibb,jbb,kbb,lbb,mbb,nbb
	Dim obb,pbb,qbb,rbb,sbb,tbb,ubb,vbb,wbb,xbb,ybb,zbb
	Dim accc,bccc,cccc,dccc,eccc,fccc,gccc,hccc,iccc
	Dim jccc,kccc,lccc,mccc,nccc,occc,pccc,qccc,rccc
	Dim sccc,tccc,uccc,vccc,wccc,xccc,yccc,zccc,adddd,bdddd
	Dim cdddd,ddddd,edddd
	l = "选择|42|,"
	ddddd = "分类|42|Cate|分类重复,"
	edddd = "发布时间|100|PubTime|日志发布时间重复,"
	m = "QQ号码|70|QQ|QQ号码重复|QQ号码搜索,"
	n = "QQ名称|200|QQName|QQ名称重复|QQ名称搜索,"
	o = "操作||详细|||修改,"
	p = "访客列表|80|VisitorsList||访客列表搜索,"
	iccc = "访客数量|80|VisitorsNumb||访客数量搜索,"
	
	q = "空间权限|80|SpacePurview|空间权限重复|空间权限搜索,"
	s = "QQ性别|60|QQSex|QQ性别重复|QQ性别搜索,"
	t = "QQ年龄|60|QQAge|QQ年龄重复|QQ年龄搜索,"
	u = "年龄|60|Age|年龄重复|年龄搜索,"
	
	v = "大类名称|100|BigClassName|大类名称重复|大类名称搜索,"
	w = "小类名称|100|SmallClassName|小类名称重复|小类名称搜索,"
	fccc = "子类名称|100|ThreeClassName|子类名称重复|子类名称搜索,"
	
	mccc = "搜索词|200|BigClassName|搜索词重复|搜索词搜索,"
	nccc = "相关词|200|SmallClassName|相关词重复|相关词搜索,"
	
	x = "好友度|60|CountNumb," 											
	y = "存在数|60|QQNumb,"
	
	r = "登录时间|116|OnLineTime|登录时间重复|登录时间搜索,"
	z = "日志类型|80|Category|日志类型重复|日志类型搜索,"
	aa = "标题|204|Title|标题重复|标题搜索,"
	ba = "日志ID|70|Blogid|日志ID重复,"
	
	ga = "缩览图|100|PhotoPre,"
	ha = "图片名称|100|PhotoName|图片名称重复|图片名称搜索,"
	ia = "图片缩览图|100|BigPhotoUrl||图片缩览图搜索,"
	ja = "图片ID|100|PhotoID|图片ID重复|图片ID搜索,"	
	na = "留言者QQ|70|MessageQQ|留言者QQ重复|留言者QQ搜索,"
	oa = "留言时间|120|UpDateTime|留言时间重复|留言时间搜索,"
	la = "留言缩览图|100|PhotoUrl,"
	ca = "留言内容||Content||留言内容搜索,"
	ibb = "存在大小图|80|PhotoShowType|存在大小图重复|存在大小图搜索,"
	
	x = "总数|60|CountNumb,"
	pa = "添加时间|120|AddTime|添加时间重复|添加时间搜索,"
	
	qa = "搜索值|100|SearchValue|搜索值重复|搜索值搜索,"
	ra = "搜索标题|200|SearchTitle|搜索标题重复|搜索标题搜索,"
	sa = "搜索内容|200|SearchContent||搜索内容搜索,"
	ta = "搜索时间|80|SearchTime|搜索时间重复|搜索时间搜索,"
	ua = "搜索排序|80|SearchSort|搜索排序重复|搜索排序搜索,"
	va = "域名/网址|200|域名/网址|域名重复|网址搜索/域名搜索,"
	
	wa = "用户|100|UserName|用户重复|用户搜索,"
	xa = "价格|60|Price|价格重复|价格搜索,"
	ya = "运费|60|FarePrice|运费重复|运费搜索,"
	za = "省份|40|Province|省份重复|省份搜索,"
	abb = "城市|40|City|城市重复|城市搜索,"
	bbb = "描述值|60|Description|描述值重复|描述值搜索,"
	cbb = "评论数|60|ReplyNumb|评论数重复|评论数搜索,"
	dbb = "评论者|60|ReplyName|评论者重复|评论者搜索,"
	gccc = "点击数|60|ClickNumb|点击数重复|点击数搜索,"	
	
	ma = "备注|200|Content||备注搜索,"	
	ka = "上传时间|80|UpDateTime|上传时间重复|上传时间搜索,"
	fbb = "文件大小|60|ZipSize|文件大小重复,"
	gbb = "运行平台|80|Windows|运行平台重复|运行平台搜索,"
	xbb = "下载数|80|DownNumb|下载数重复|下载数搜索,"
	
	hbb = "排序|60|Sort|排序重复|排序搜索,"
	
	jbb = "招聘职位|100|WorkTitle|招聘职位重复|招聘职位搜索,"
	kbb = "公司名称|100|Company|公司名称重复|公司名称搜索,"
	lbb = "地区|40|DiQu|地区重复|地区搜索,"
	mbb = "工作经验|90|WorkEXP|工作经验重复|工作经验搜索,"
	
	nbb = "QQ备注名|90|QQBeiZhuName|QQ备注名重复|QQ备注名搜索,"
	ebb = "QQ头像|100|QQ头像||,"
	
	obb = "作者|90|Author|作者重复|作者搜索,"
	pbb = "人气|90|RenQi|人气重复|人气搜索,"
	
	qbb = "网站标题|200|WebTitle|网站标题重复|网站标题搜索,"
	rbb = "网站地址|200|WebUrl|网站地址重复|网站地址搜索,"
	sbb = "星期数|200|DayNumb|星期数重复|星期数搜索,"
	
	tbb = "单词|100|Ci|单词重复|单词搜索,"
	ubb = "英文解释||Shi|英文解释重复|英文解释搜索,"
	
	vbb = "破解值|80|PoJie|破解值重复|破解值搜索,"
	wbb = "破解图片|80|PoJiePhoto,"
	
	ybb = "英文|120|EN|英文重复|英文搜索,"
	zbb = "中文|200|CN|中文重复|中文搜索,"
	
	da = "文件|150|FileName|文件重复|文件搜索,"
	ea = "文件夹|120|FolderName|文件夹重复|文件夹搜索,"
	fa = "目录路径||DirPath|目录路径重复|目录路径搜索,"
	
	accc = "网址|200|HttpUrl|网址重复|网址搜索,"
	bccc = "播放时间|80|PlayTime|播放时间重复|播放时间搜索,"
	cccc = "播放次数|80|PlayNumb|播放次数重复|播放次数搜索,"
	dccc = "发布时间|100|PostingsTime|发布时间重复|发布时间搜索,"
	
	eccc = "导航名称|100|cname|导航名称重复|导航名称搜索,"
	hccc = "共同好友|60|MutualFriend|共同好友重复|共同好友搜索,"
	jccc = "支持数|80|SupportNumb|支持数重复|支持数搜索,"
	kccc = "提交日期|80|CreateDate|提交日期重复|提交日期搜索,"
	lccc = "是否通过|80|Through|是否通过重复|是否通过搜索,"
	occc = "采纳率|80|AdoptionRate|采纳率重复|采纳率搜索,"
	pccc = "浏览次数|80|BrowseNumb|浏览次数重复|浏览次数搜索,"
	qccc = "邮箱|120|Email|邮箱重复|邮箱搜索,"
	rccc = "IP|120|IP|IP重复|IP搜索,"
	sccc = "添加时间|120|AddDateTime|添加时间重复|添加时间搜索,"
	tccc = "文件路径|120|FilePath|文件路径重复|文件路径搜索,"
	uccc ="用户积分|120|MyMoney|用户积分重复|用户积分搜索,"
	vccc = "提问时间|120|ReplyTime|提问时间重复|提问时间搜索,"
	wccc = "问问类型|120|AskType|问问类型重复|问问类型搜索,"
	xccc = "问问ID|120|AskId|问问ID重复|问问ID搜索,"
	yccc = "域名|120|WebSite|域名重复|域名搜索,"
	zccc = "页数|120|PageNumber|页数重|复页数搜索,"
	adddd = "排名|120|Ranking|排名重复|排名搜索,"
	bdddd = "收录时间|120|IncludedTime|收录时间重复|收录时间搜索,"
	cdddd = "搜索引擎网址|120|SearchUrl|搜索引擎网址重复|搜索引擎网址搜索,"
	
	
	If CheckStr(a, "^Product$") Then
		b = l & v & w & fccc & aa & ma  & ka & o
		c = "点击数"
		d = "标题|内容"
	
	ElseIf CheckStr(a, "^QQNameTable$") Then
		b = l & m & n & ma & o
		c = "QQ号码|QQ名称"
		d = "QQ号码|QQ名称|QQ名称和号码"
	
	ElseIf CheckStr(a, "^QQBeiZhu$") Then
		b = l & m & nbb & o
		c = "QQ号码|QQ名称"
		d = "QQ号码|QQ备注名|QQ名称和号码"
	
	ElseIf CheckStr(a, "^QQ$") Then
		If Rq("Style") = "2" Then
			b = l & m & n & s & u & ka & t & o
			c = "QQ号码|QQ名称|QQ性别|年龄|上传时间|QQ年龄"
			d = "QQ号码|QQ访客|QQ和访客"
		Else
			b = l & v & m & n & p & q & r & hccc & iccc & o
			c = "QQ号码|QQ名称|空间权限|登录时间|访客数量"
			d = "QQ号码|QQ访客|QQ和访客"
		End If
	
	ElseIf CheckStr(a, "^GuanXiQQ$") Then
		b = l & v & w & m & n & x & y & o
		c = "好友度|存在数|好友度＋存在数|[联合查询]"
		d = "QQ号码|QQ名称|QQ名称和号码"
	
	ElseIf CheckStr(a, "^DailyRcord$") Then
		b = l & m & z & aa & cbb & ba & o
		c = "QQ号码|评论数"
		d = "QQ号码|日志标题|日志地址"
	
	ElseIf CheckStr(a, "^QQPhotoClass$") Then
		b = l & v & m & ga & ibb & o
		c = "QQ号码"
		d = "大类名称|QQ号码|缩览图"
	
	ElseIf CheckStr(a, "^QQPhotoProduct$") Then
		b = l & m & ha & ia & ja & ibb & o
		c = "QQ号码"
		d = "QQ号码|相册小图|相册大图"
	
	ElseIf CheckStr(a, "^QQPhotoMessage$") Then
		b = l & na &  m & n  & oa & la & ibb & ca
		c = "QQ号码|留言时间"
		d = "QQ号码|留言图片|留言内容"
	
	ElseIf CheckStr(a, "^QQOnLine") Then
		b = l &  m & r & o
		c = "QQ号码|登录时间"
		d = "QQ号码"
	
	ElseIf CheckStr(a, "^QQJournal") Then
		b = l &  m & ddddd &  ba & aa & edddd & o
		c = "QQ号码|登录时间"
		d = "QQ号码"
	
	ElseIf CheckStr(a, "^WithTable$") Then
		b = l & v & w &  aa & x & o
		c = "总数"
		d = "标题|分析出图"
	
	ElseIf CheckStr(a, "^QQTemp$") Then
		b = l &  m & pa & o
		c = "QQ号码|添加时间"
		d = "QQ号码"
	
	ElseIf CheckStr(a, "^SearchEngine$") Then
		b = l &  qa & ra & ta & ua & sa & va & o
		c = "QQ号码|添加时间"
		d = "搜索标题|搜索网址|域名"
	
	ElseIf CheckStr(a, "^TaoBaoProduct$") Then
		b = l &  qa & wa & xa & ya & za & abb & bbb & cbb
		c = "价格|运费|描述值|评论"
		d = "用户|标题|价格"
	
	ElseIf CheckStr(a, "^Word$") Then
		b = l &  aa & pa & hbb & o
		c = "添加时间|排序"
		d = "标题"
	
	ElseIf CheckStr(a, "^JOB_51Job$") Then
		b = l & qa & jbb & kbb & abb & lbb & ka & mbb  & o
		c = "上传时间|排序"
		d = "招聘职位|公司名称|职位简介|招聘职位和职位简介"
	
	ElseIf CheckStr(a, "^QQTouXiang$") Then
		b = l & ebb & m & ibb & o
		c = "添加时间|排序"
		d = "标题"
	
	ElseIf CheckStr(a, "^Flash163SWF$") Then
		b = l & aa & obb & pbb & ibb & o
		c = "标题|人气|作者"
		d = "标题|图片地址|SWF地址|下载地址"
	
	ElseIf CheckStr(a, "^QQVisitorsStat$") Then
		b = l & m & n & x & o
		c = "QQ号码|QQ名称|总数"
		d = "QQ号码|QQ名称|QQ名称和号码"
	
	ElseIf CheckStr(a, "^TempUrl$") Then
		b = l & ea & da & fa & o
		c = "文件|文件夹|目录路径"
		d = "文件|文件夹|目录路径"
	
	ElseIf CheckStr(a, "^Video$") Then
		b = l & aa & accc & bccc & cccc & dccc & obb & o
		c = "播放时间|播放次数|发布时间"
		d = "视频图片|视频标题|视频网址|视频标题加网址"
	
	ElseIf CheckStr(a, "^Web$") Then
		b = l & qbb & rbb & sbb & o
		c = "星期数"
		d = "网站标题|网站地址|网站标题加地址"
	
	ElseIf CheckStr(a, "^ce$") Then
		b = l & tbb & ubb & o
		c = "单词"
		d = "单词|英文解释|单词加英文解释"
	
	ElseIf CheckStr(a, "^QQYingZheng$") Then
		b = l & aa & vbb & wbb & o
		c = "破解值"
		d = "破解值"
	
	ElseIf CheckStr(a, "^CnEnWords$") Then
		b = l & ybb & zbb & hbb & o
		c = "排序"
		d = "中英对照"
	
	ElseIf CheckStr(a, "^class$") Then
		b = l & eccc & accc & o
		c = "导航名称"
		d = "导航名称"
	
	ElseIf CheckStr(a, "^qqname$") Then
		b = l & m & n & o
		c = "QQ号码|QQ名称"
		d = "QQ号码|QQ名称"		
	
	ElseIf CheckStr(a, "^baiduzhidao$") Then
		b = l & v & w & aa & accc & obb & cbb & dbb & occc & jccc & kccc & pccc & lccc & o
		c = "提交日期|评论数|浏览次数|是否通过"
		d = "|"
	
	ElseIf CheckStr(a, "^BaiduZhidaoWords$") Then
		b = l & mccc & nccc & o
		c = "|"
		d = "|"		
	
	ElseIf CheckStr(a, "^StatisticalData$") Then
		b = l & v & aa & x & o
		c = "总数"
		d = "|"
	
	ElseIf CheckStr(a, "^SoftTask$") Then
		b = l & v & qccc & ma & ka & tccc & lccc & o
		c = ""
		d = "|"		
	
	ElseIf CheckStr(a, "^Member$") Then
		b = l & wa & uccc & qccc & rccc & o
		c = ""
		d = "|"
	
	ElseIf CheckStr(a, "^UserLog$") Then
		b = l & v & ma & rccc & sccc & o
		c = ""
		d = "|"
	
	ElseIf CheckStr(a, "^Feedback$") Then
		b = l & qccc & ma & rccc & sccc & o
		c = ""
		d = "|"
	
	ElseIf CheckStr(a, "^Words$") Then
		b = l & v & qccc & aa & rccc & sccc & o
		c = ""
		d = "|"
	
	ElseIf CheckStr(a, "^Ask$") Then
		b = l & wccc & v & xccc & aa & cbb & vccc & o
		c = "提问时间"
		d = "|"
	
	ElseIf CheckStr(a, "^SearchEngineInfoList$") Then
		b = l & v & yccc & aa & zccc & adddd & bdddd & cdddd & o
		c = ""
		d = "|"
		
	
	Else
		Call Eerr("【"& a &"】表","未配置，已停止。注意：【请到 Fun_Table.Asp 页找到 ShowClassName 函数修改】")
		
	End If
	
	f=Split(b, ",")
	j=1
	For Each h In f
		If h <> "" Then
			g=Split(h & "|||", "|")
			e(j) = g(1)
			i = i & "<td width="""& g(1) &""" align=""center"" bgcolor=""#FFFFFF"" class=""B14"">"& g(0) &"</td>" & vbCrlf
			j = j +1
		End If
	Next
	ShowClassName = i
End Function



Function HandleSearchSQL(a,b)
	Dim c,d,e
	
	If Left(b,1) = """" And Right(b,1) = """" Then
		b = Left(b, Len(b)-1)
		b = Right(b, Len(b)-1)
		e = "真"
	End If
	If b <> "" Then
		If a = "QQ号码搜索" Then
			d = "QQ"
		ElseIf a = "QQ名称搜索" Then
			d = "QQName"
		ElseIf a = "访客列表搜索" Then
			d = "VisitorsList"
		ElseIf a = "大类名称搜索" Then
			d = "BigClassName"
		ElseIf a = "小类名称搜索" Then
			d = "SmallClassName"
		ElseIf a = "图片名称搜索" Then
			d = "PhotoName"
		ElseIf a = "留言者QQ搜索" Then
			d = "MessageQQ"
		ElseIf a = "登录时间搜索" Then
			d = "OnLineTime"
		ElseIf a = "标题搜索" Then
			d = "Title"
		ElseIf a = "添加时间搜索" Then
			d = "AddTime"
		ElseIf a = "搜索值搜索" Then
			d = "SearchValue"
		ElseIf a = "搜索标题搜索" Then
			d = "SearchTitle"
		ElseIf a = "搜索时间搜索" Then
			d = "SearchTime"
		ElseIf a = "搜索排序搜索" Then
			d = "SearchSort"
		ElseIf a = "搜索内容搜索" Then
			d = "SearchContent"
		ElseIf a = "搜索网址搜索" Then
			d = "SearchHttpUrl"
		ElseIf a = "网址搜索" Then
			d = "HttpUrl"
		ElseIf a = "域名搜索" Then
			d = "WebSite"
		ElseIf a = "备注搜索" Then
			d = "Content"
		ElseIf a = "上传时间搜索" Then
			d = "UpDateTime"
		ElseIf a = "运行平台搜索" Then
			d = "Windows"
		ElseIf a = "存在大小图搜索" Then
			d = "PhotoShowType"
		ElseIf a = "图片ID搜索" Then
			d = "PhotoID"
		ElseIf a = "公司名称搜索" Then
			d = "Company"
		ElseIf a = "招聘职位搜索" Then
			d = "WorkTitle"
		ElseIf a = "网站标题搜索" Then
			d = "WebTitle"
		ElseIf a = "网站地址搜索" Then
			d = "WebUrl"
		ElseIf a = "星期数搜索" Then
			d = "DayNumb"
		ElseIf a = "单词搜索" Then
			d = "Ci"
		ElseIf a = "英文解释搜索" Then
			d = "Shi"
		ElseIf a = "图片缩览图搜索" Then
			d = "BigPhotoUrl"
		ElseIf a = "QQ性别搜索" Then
			d = "QQSex"
		ElseIf a = "QQ年龄搜索" Then
			d = "QQAge"
		ElseIf a = "破解值搜索" Then
			d = "PoJie"
		ElseIf a = "下载数搜索" Then
			d = "DownNumb"
		ElseIf a = "评论数搜索" Then
			d = "ReplyNumb"
		ElseIf a = "日志类型搜索" Then
			d = "Category"
		ElseIf a = "英文搜索" Then
			d = "EN"
		ElseIf a = "中文搜索" Then
			d = "CN"
		ElseIf a = "排序搜索" Then
			d = "Sort"
		ElseIf a = "文件搜索" Then
			d = "FileName"
		ElseIf a = "文件夹搜索" Then
			d = "FolderName"
		ElseIf a = "目录路径搜索" Then
			d = "DirPath"
		ElseIf a = "播放时间搜索" Then
			d = "PlayTime"
		ElseIf a = "播放次数搜索" Then
			d = "PlayNumb"
		ElseIf a = "发布时间搜索" Then
			d = "PostingsTime"
		ElseIf a = "作者搜索" Then
			d = "Author"
		ElseIf a = "搜索词搜索" Then
			d = "BigClassName"
		ElseIf a = "相关词搜索" Then
			d = "SmallClassName"
		ElseIf a = "采纳率搜索" Then
			d = "AdoptionRate"
		ElseIf a = "支持数搜索" Then
			d = "SupportNumb"
		ElseIf a = "提交日期搜索" Then
			d = "CreateDate"
		ElseIf a = "浏览次数搜索" Then
			d = "BrowseNumb"
		ElseIf a = "是否通过搜索" Then
			d = "Through"
		ElseIf a = "提问时间搜索" Then
			d = "ReplyTime"
		ElseIf a = "问问ID搜索" Then
			d = "AskId"
	
			
			
		ElseIf a <> "" Then
			Call Echo(a, "搜索不存在")
		End If
		
		
		
		If d<>"" Then
			
			If MDBPath = "" Then
				
				Call OpenConn()
				If Conn.Execute("Select "& d &" From ["& Table & "]")(0).Type = 3 Then
					d = "Convert(VarChar, "& d &")"
				End If
			End If
			c = "Where "& d &" Like '%"& b &"%'"
			
			If e = "真" Then
				c = "Where "& d &" = '"& b &"'"
			End If
	 	End If
		
		c = OrAndSearch(c,d,b)
	End If
	HandleSearchSQL = c
End Function


Function HandleAscDesc(a, b)
	If b = "" Then
		HandleAscDesc = a
		Exit Function
	End If
	
	If b = "QQ号码正排序" Then
		a = a & "   Order By Convert(Money, QQ) Asc"	
	ElseIf b = "QQ号码倒排序" Then	
		a = a & "   Order By Convert(Money, QQ) Desc"
		
	ElseIf b = "QQ名称正排序" Then
		a = a & "   Order By QQName Asc"	
	ElseIf b = "QQ名称倒排序" Then	
		a = a & "   Order By QQName Desc"
	
	ElseIf b = "备注为空" Then
		If InStr(a, "Where ") > 0 Then a = a & "   And" Else a = a & "   Where"
		a = a & " Content Is Null"	
	ElseIf b = "备注不为空" Then
		If InStr(a, "Where ") > 0 Then a = a & "   And" Else a = a & "   Where"
		a = a & " Content Is Not Null"	
		
	ElseIf b = "空间权限正排序" Then

		a = a & "   Order By SpacePurview Asc"	
	ElseIf b = "空间权限倒排序" Then	
		a = a & "   Order By SpacePurview Desc"
		
	ElseIf b = "登录时间正排序" Then
		a = a & "   Order By OnLineTime Asc"	
	ElseIf b = "登录时间倒排序" Then	
		a = a & "   Order By OnLineTime Desc"
		
	ElseIf b = "好友度正排序" Then
		a = a & "   Order By CountNumb"
	ElseIf b = "好友度倒排序" Then
		a = a & "   Order By CountNumb Desc"
		
	ElseIf b = "存在数正排序" Then
		a = a & "   Order By QQNumb"
	ElseIf b = "存在数倒排序" Then
		a = a & "   Order By QQNumb Desc"
		
	ElseIf b = "好友度＋存在数正排序" Then
		a = a & "   Order By CountNumb+QQNumb"
	ElseIf b = "好友度＋存在数倒排序" Then
		a = a & "   Order By CountNumb+QQNumb Desc"
		
	ElseIf b = "评论数正排序" Then
		a = a & "   Order By ReplyNumb Asc"	
	ElseIf b = "评论数倒排序" Then	
		a = a & "   Order By ReplyNumb Desc"
		
	ElseIf b = "留言时间正排序" Then
		a = a & "   Order By UpDateTime Asc"	
	ElseIf b = "留言时间倒排序" Then	
		a = a & "   Order By UpDateTime Desc"
		
	ElseIf b = "总数正排序" Then
		a = a & "   Order By CountNumb Asc"	
	ElseIf b = "总数倒排序" Then	
		a = a & "   Order By CountNumb Desc"
		
	ElseIf b = "添加时间正排序" Then
		a = a & "   Order By AddTime Asc"	
	ElseIf b = "添加时间倒排序" Then	
		a = a & "   Order By AddTime Desc"
		
	ElseIf b = "价格正排序" Then
		a = a & "   Order By Price Asc"	
	ElseIf b = "价格倒排序" Then	
		a = a & "   Order By Price Desc"
		
	ElseIf b = "运费正排序" Then
		a = a & "   Order By FarePrice Asc"	
	ElseIf b = "运费倒排序" Then	
		a = a & "   Order By FarePrice Desc"
		
	ElseIf b = "运费正排序" Then
		a = a & "   Order By FarePrice Asc"	
	ElseIf b = "运费倒排序" Then	
		a = a & "   Order By FarePrice Desc"
		
	ElseIf b = "描述值正排序" Then
		a = a & "   Order By Description Asc"	
	ElseIf b = "描述值倒排序" Then	
		a = a & "   Order By Description Desc"
		
	ElseIf b = "评论正排序" Then
		a = a & "   Order By ReplyNum Asc"	
	ElseIf b = "评论倒排序" Then	
		a = a & "   Order By ReplyNum Desc"
		
	ElseIf b = "上传时间正排序" Then
		a = a & "   Order By UpDateTime Asc"	
	ElseIf b = "上传时间倒排序" Then	
		a = a & "   Order By UpDateTime Desc"
		
	ElseIf b = "文件大小正排序" Then
		a = a & "   Order By ZipSize Asc"	
	ElseIf b = "文件大小倒排序" Then	
		a = a & "   Order By ZipSize Desc"
		
	ElseIf b = "运行平台正排序" Then
		a = a & "   Order By Windows Asc"	
	ElseIf b = "运行平台倒排序" Then	
		a = a & "   Order By Windows Desc"
		
	ElseIf b = "排序正排序" Then
		a = a & "   Order By Sort Asc"	
	ElseIf b = "排序倒排序" Then	
		a = a & "   Order By Sort Desc"
		
	ElseIf b = "标题正排序" Then
		a = a & "   Order By Title Asc"	
	ElseIf b = "标题倒排序" Then	
		a = a & "   Order By Title Desc"		
		
	ElseIf b = "人气正排序" Then
		a = a & "   Order By RenQi Asc"	
	ElseIf b = "人气倒排序" Then	
		a = a & "   Order By RenQi Desc"
		
	ElseIf b = "作者正排序" Then
		a = a & "   Order By Author Asc"	
	ElseIf b = "作者倒排序" Then	
		a = a & "   Order By Author Desc"
		
		
	ElseIf b = "单词正排序" Then
		a = a & "   Order By Ci Asc"	
	ElseIf b = "单词倒排序" Then	
		a = a & "   Order By Ci Desc"
		
	ElseIf b = "破解值正排序" Then
		a = a & "   Order By PoJie Asc"	
	ElseIf b = "破解值倒排序" Then	
		a = a & "   Order By PoJie Desc"
		
	ElseIf b = "QQ性别正排序" Then
		a = a & "   Order By QQSex Asc"	
	ElseIf b = "QQ性别倒排序" Then	
		a = a & "   Order By QQSex Desc"
		
	ElseIf b = "QQ年龄正排序" Then
		a = a & "   Order By QQAge Asc"	
	ElseIf b = "QQ年龄倒排序" Then	
		a = a & "   Order By QQAge Desc"
		
	ElseIf b = "年龄正排序" Then
		a = a & "   Order By Age Asc"	
	ElseIf b = "年龄倒排序" Then	
		a = a & "   Order By Age Desc"
		
		
	ElseIf b = "下载数正排序" Then
		a = a & "   Order By DownNumb Asc"	
	ElseIf b = "下载数倒排序" Then	
		a = a & "   Order By DownNumb Desc"
		
	ElseIf b = "文件正排序" Then
		a = a & "   Order By FileName Asc"	
	ElseIf b = "文件倒排序" Then	
		a = a & "   Order By FileName Desc"
		
	ElseIf b = "文件夹正排序" Then
		a = a & "   Order By FolderName Asc"	
	ElseIf b = "文件夹倒排序" Then	
		a = a & "   Order By FolderName Desc"
		
	ElseIf b = "目录路径正排序" Then
		a = a & "   Order By DirPath Asc"	
	ElseIf b = "目录路径倒排序" Then	
		a = a & "   Order By DirPath Desc"
		
	ElseIf b = "播放时间正排序" Then
		a = a & "   Order By PlayTime Asc"	
	ElseIf b = "播放时间倒排序" Then	
		a = a & "   Order By PlayTime Desc"
		
	ElseIf b = "播放次数正排序" Then
		a = a & "   Order By PlayNumb Asc"	
	ElseIf b = "播放次数倒排序" Then	
		a = a & "   Order By PlayNumb Desc"
		
	ElseIf b = "发布时间正排序" Then
		a = a & "   Order By PostingsTime Asc"	
	ElseIf b = "发布时间倒排序" Then	
		a = a & "   Order By PostingsTime Desc"
		
	ElseIf b = "点击数正排序" Then
		a = a & "   Order By ClickNumb Asc"	
	ElseIf b = "点击数倒排序" Then	
		a = a & "   Order By ClickNumb Desc"
		
	ElseIf b = "访客数量正排序" Then
		a = a & "   Order By VisitorsNumb Asc"	
	ElseIf b = "访客数量倒排序" Then	
		a = a & "   Order By VisitorsNumb Desc"
		
	ElseIf b = "提交日期正排序" Then
		a = a & "   Order By CreateDate Asc"	
	ElseIf b = "提交日期倒排序" Then	
		a = a & "   Order By CreateDate Desc"
		
	ElseIf b = "浏览次数正排序" Then
		a = a & "   Order By BrowseNumb Asc"	
	ElseIf b = "浏览次数倒排序" Then	
		a = a & "   Order By BrowseNumb Desc"
		
	ElseIf b = "是否通过正排序" Then
		a = a & "   Order By Through Asc"	
	ElseIf b = "是否通过倒排序" Then	
		a = a & "   Order By Through Desc"
		
	ElseIf b = "提问时间正排序" Then
		a = a & "   Order By ReplyTime Asc"	
	ElseIf b = "提问时间倒排序" Then	
		a = a & "   Order By ReplyTime Desc"
		

		
		
		
		
	ElseIf b = "联合查询" Then
		Call LianHeSearch()
	Else
		Call Echo(b, "排序不存在")
	End If
	
	
	HandleAscDesc = a
End Function

Function LianHeSearch()
	Dim b, c
	b = Request("SearchType")
	c = Request("SearchValue")
	
	If b = "" And InStr(c,"|")>0 Then
		CAll Echo("", "联合")
		Dim d,e,f,g,h,i
		g = True
		d=Split(c, "|")
		For Each f In d
			If f<> "" Then
				If e = "" Then
					e = "'"& f &"'"
				Else
					e = e & ",'"& f &"'"
				End If
				Rs.Open"Select BigClassName From [GuanXiQQ] Where BigClassName = '"& f &"'",Conn,1,1
				If Rs.Eof Then
					h = h & "<div align=center><iframe width='800' height=100 frameborder=0 scrolling=no src='Print.Asp?act=处理分析QQ&QQ="&f&"'></iframe></div>"
					i=i+1
					g = False
				End If:Rs.Close
			End If
		Next
		
		If g = False Then
			h = h & "<div align=center style='color:red;'>提示：有未处理的关系QQ【<b>"& i &"</b>】个</div>"
			Call Rw( h )
			Response.End()
		End If
		Conn.Execute("Delete From [GuanXiQQ] Where BigClassName='联合查询'")
		Rs.Open"Select * From [GuanXiQQ] Where BigClassName In("& e &")",Conn,1,1
		While Not Rs.Eof
			
			Rsx.Open"Select * From [GuanXiQQ] Where BigClassName='联合查询' And QQ='"& Rs("QQ") &"'",Conn,1,3
			If Rsx.Eof Then
				Rsx.AddNew
				Rsx("BigClassName") = "联合查询"
				Rsx("SearchList") = c
				Rsx("SmallClassName") = Rs("BigClassName")
				Rsx("QQ") = Rs("QQ")
				Rsx("QQName") = Rs("QQName")
				Rsx("CountNumb") = Rs("CountNumb") + Rs("QQNumb")
			Else
				Rsx("CountNumb") = Rsx("CountNumb") + Rs("CountNumb") + Rs("QQNumb")
				Rsx("QQNumb") = Rsx("QQNumb") +1
				
				If InStr("|"& Rsx("SmallClassName") &"|", "|"& Rs("QQ") &"|") = False Then
					Rsx("SmallClassName") = Rsx("SmallClassName") & "|" & Rs("BigClassName")
				End If
			End If
			Rsx.Update:Rsx.Close	
		Rs.MoveNext:Wend:Rs.Close
		
		CAll Eerr("哈哈","哈哈")
		
		Response.End()
	End If
	
End Function

Function HandleReset(a, b, c)
	If b = "" Then
		HandleReset = a
		Exit Function
	End If
	
	If b = "QQ号码重复" Then
		a = "Select QQ From ["& c &"] Group By QQ Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "QQ名称重复" Then
		a = "Select QQName  From ["& c &"] Group By QQName Having(Count(*))>" & Cint(Rq("N"))
	
	ElseIf b = "空间权限重复" Then
		a = "Select SpacePurview From ["& c &"] Group By SpacePurview Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "登录时间重复" Then
		a = "Select OnLineTime  From ["& c &"] Group By OnLineTime Having(Count(*))>" & Cint(Rq("N"))
	
	ElseIf b = "大类名称重复" Then
		a = "Select BigClassName From ["& c &"] Group By BigClassName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "小类名称重复" Then
		a = "Select SmallClassName  From ["& c &"] Group By SmallClassName Having(Count(*))>" & Cint(Rq("N"))
	
	ElseIf b = "日志类型重复" Then
		a = "Select QQcategory From ["& c &"] Group By QQcategory Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "标题重复" Then
		a = "Select Title  From ["& c &"] Group By Title Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "评论数重复" Then
		a = "Select ReplyNumb  From ["& c &"] Group By ReplyNumb Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "日志ID重复" Then
		a = "Select Blogid  From ["& c &"] Group By Blogid Having(Count(*))>" & Cint(Rq("N"))
		
	ElseIf b = "添加时间重复" Then
		a = "Select AddTime  From ["& c &"] Group By AddTime Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "域名重复" Then
		a = "Select WebSite  From ["& c &"] Group By WebSite Having(Count(*))>" & Cint(Rq("N"))
		
	ElseIf b = "搜索值重复" Then
		a = "Select SearchValue  From ["& c &"] Group By SearchValue Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "用户重复" Then
		a = "Select UserName  From ["& c &"] Group By UserName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "价格重复" Then
		a = "Select Price  From ["& c &"] Group By Price Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "运费重复" Then
		a = "Select FarePrice  From ["& c &"] Group By FarePrice Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "省份重复" Then
		a = "Select Province  From ["& c &"] Group By Province Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "城市重复" Then
		a = "Select City  From ["& c &"] Group By City Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "描述值重复" Then
		a = "Select Description  From ["& c &"] Group By Description Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "评论重复" Then
		a = "Select ReplyNum  From ["& c &"] Group By ReplyNum Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "QQ备注名重复" Then
		a = "Select QQBeiZhuName  From ["& c &"] Group By QQBeiZhuName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "公司名称重复" Then	
		a = "Select Company  From ["& c &"] Group By Company Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "招聘职位重复" Then	
		a = "Select WorkTitle  From ["& c &"] Group By WorkTitle Having(Count(*))>" & Cint(Rq("N"))
		
		
	ElseIf b = "作者重复" Then	
		a = "Select Author  From ["& c &"] Group By Author Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "人气重复" Then	
		a = "Select RenQi  From ["& c &"] Group By RenQi Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "存在大小图重复" Then	
		a = "Select PhotoShowType  From ["& c &"] Group By PhotoShowType Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "网站标题重复" Then	
		a = "Select WebTitle  From ["& c &"] Group By WebTitle Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "网站地址重复" Then	
		a = "Select WebUrl  From ["& c &"] Group By WebUrl Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "星期数重复" Then	
		a = "Select DayNumb  From ["& c &"] Group By DayNumb Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "上传时间重复" Then	
		a = "Select UpDateTime  From ["& c &"] Group By UpDateTime Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "QQ年龄重复" Then	
		a = "Select QQAge  From ["& c &"] Group By QQAge Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "QQ性别重复" Then	
		a = "Select QQSex  From ["& c &"] Group By QQSex Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "年龄重复" Then	
		a = "Select Age  From ["& c &"] Group By Age Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "运行平台重复" Then	
		a = "Select Windows  From ["& c &"] Group By Windows Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "下载数重复" Then	
		a = "Select DownNumb  From ["& c &"] Group By DownNumb Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "文件大小重复" Then	
		a = "Select ZipSize  From ["& c &"] Group By ZipSize Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "文件重复" Then	
		a = "Select FileName  From ["& c &"] Group By FileName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "文件夹重复" Then	
		a = "Select FolderName  From ["& c &"] Group By FolderName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "目录路径重复" Then	
		a = "Select DirPath  From ["& c &"] Group By DirPath Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "网址重复" Then	
		a = "Select HttpUrl  From ["& c &"] Group By HttpUrl Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "播放时间重复" Then	
		a = "Select PlayTime  From ["& c &"] Group By PlayTime Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "播放次数重复" Then	
		a = "Select PlayNumb  From ["& c &"] Group By PlayNumb Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "发布时间重复" Then	
		a = "Select PostingsTime  From ["& c &"] Group By PostingsTime Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "子类名称重复" Then	
		a = "Select ThreeClassName  From ["& c &"] Group By ThreeClassName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "点击数重复" Then	
		a = "Select ClickNumb  From ["& c &"] Group By ClickNumb Having(Count(*))>" & Cint(Rq("N"))
		
	ElseIf b = "搜索词重复" Then	
		a = "Select BigClassName  From ["& c &"] Group By BigClassName Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "分类重复" Then	
		a = "Select Cate  From ["& c &"] Group By Cate Having(Count(*))>" & Cint(Rq("N"))
	ElseIf b = "日志发布时间重复" Then	
		a = "Select pubTime  From ["& c &"] Group By pubTime Having(Count(*))>" & Cint(Rq("N"))

		
		
	
	ElseIf b = "单词重复" Then	
		a = "Select Ci  From ["& c &"] Group By Ci Having(Count(*))>" & Cint(Rq("N"))
	
	ElseIf b = "英文解释重复" Then	
		a = "Select Shi  From ["& c &"] Group By Shi Having(Count(*))>" & Cint(Rq("N"))
	
	ElseIf b = "英文解释重复" Then	
		a = "Select Shi  From ["& c &"] Group By Shi Having(Count(*))>" & Cint(Rq("N"))
		


	Else
		Call Echo(b, "重复不存在")
	End If
	
	HandleReset = a
End Function


Function SelfSql(a, b, c)
	Dim d
	
	b = RegExp_Replace(b, "SQL *=", "Sql ")
	If CheckStr(b, "SQL ") = True Then
		d = Trim(b)
		d = Trim( Right(d, Len(d) - 4) )
		If CheckStr(d, "Delete ") = True Then
			d = d & " &nbsp; <a href=""?act=ClearTable&MDBPath="&Request("MDBPath")&"&SQL="&d&""" target=""_blank"" class=""ARed"" onClick=""return Confirm();"">删除记录</a>"
			CAll Eerr("删除很危险，请慎重", d)
		ElseIf CheckStr(d, "Update ") = True Then
			CAll Eerr("更新表操作", d)
		ElseIf CheckStr(d, "Select ") = False Then
			d = "Select * From ["& c &"] " & d
		End If
		a = d
	End If
	SelfSql = a
End Function


Function ReplaceSearchValue(a, b)
	Dim c,d
	If InStr(b," Or ")>0 Then
		c = Split(b, " Or ")
		For Each d In c
			If d <> "" Then
				a = Replace(a, d,"<font color=red><b>" & d & "</b></font>")
			End If
		Next
	ElseIf InStr(b," And ")>0 Then
		c = Split(b, " And ")
		For Each d In c
			If d <> "" Then
				a = Replace(a, d,"<font color=red><b>" & d & "</b></font>")
			End If
		Next
	ElseIf a <> "" Then
		a = Replace(a, b,"<font color=red><b>" & b & "</b></font>")
	End If
	ReplaceSearchValue = a
End Function


Sub ShowCopyList(a,b,c, d)
	If d <> "" Then d = "用时：" & PrintTimeValue(DateDiff("s", d, Now()) ) & "，&nbsp;"
	Call Echo("【"& a &"】", "共有【"& b &"】条，&nbsp;" & d & "<a href=javascript:CopyTEXT('CopyContent');>复制</a>")
	CAll Rw("<div style='margin-left:220px;'><textarea name='CopyContent' id='CopyContent' style='width:800px;height:400px;'>"& c &"</textarea></div>")
End Sub
%>












