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
Class ClassYouKou

	
	Function DivNavigation(a,b)
		Dim c, d, e, f, g, h, i, j, k
		Rs.Open "Select * From [NavBigClass] " & b, Conn, 1, 1
		d = d & "<li class=left></li>" & vbCrlf
		For c = 1 To Rs.RecordCount
			g = Rs("FileName")
			If g <> "" And Right(g,1)<>"/" Then g = g & ".html"
		
			h = "/" & Rs("FolderName") & "/"
			i = Rs("BigClassName")
			j = FontColorFontB(i, Rs("FontB"), Rs("FontColor"))
			k = Rs("Target")
			
			f = Rs("FileName")
			If CheckRemoteUrl(f)=False Then
				f = h & g
				f = Replace(Replace(f, "//", "/"), "//", "/")
				f = FullHttpUrl(Host,f)
				Call WebDebug(f,"act=Nav&NavDid=" & i)
			End If
			
			
			If a=Rs("BigClassName") Then
				
				d = d & "<li class=focus>"& j &"</li>" &vbCrlf
			Else
				d = d & "<li><a " & AHref(f, "", k) & ">" & j & "</a></li>" &vbCrlf
			End If
			d = d & "<li class=line></li>" & vbCrlf
		Rs.MoveNext : Next : Rs.Close
		d = d & "<li class=right></li>" & vbCrlf
		DivNavigation = d
	End Function

	
	Function ShowHandleUserList(a)
		Dim b,c,d,e,f,g
		b=Split("王|李|张|刘|陈|杨|黄|吴|赵|周|徐|孙|马|朱|胡|林|郭|何|高|罗|郑|梁|谢|宋|唐|许|邓|冯|韩|曹|曾|彭|萧|蔡|潘|田|董|袁|于|余|叶|蒋|杜|苏|魏|程|吕|丁|沈|任|姚|卢|傅|钟|姜|崔|谭|廖|范|汪|陆|金|石|戴|贾|韦|夏|邱|方|侯|邹|熊|孟|秦|白|江|阎|薛|尹|段|雷|黎|史|龙|陶|贺|顾|毛|郝|龚|邵|万|钱|严|赖|覃|洪","|")
		c=Split("武北京市|天津市|辽宁省沈阳市|吉林省长春市|黑龙江省哈尔滨市|上海市|江苏省南京市|湖北省武汉市|广东省广州市|重庆市|四川省成都市|陕西省西安市|河北省石家庄市|河北省唐山市|山西省太原市|内蒙包头市|辽宁省大连市|辽宁省鞍山市|辽宁省抚顺市|吉林省吉林市|黑龙江省齐齐哈尔市|江苏省徐州市|浙江省杭州市|福建省福州市|江西省南昌市|山东省济南市|山东省青岛市|山东省淄博市|河南省郑州市|湖南省长沙市|贵州省贵阳市|云南省昆明市|甘肃省兰州市|新疆乌鲁木齐市|河北省邯郸市|河北省保定市|河北省张家口市|山西省大同市|内蒙呼和浩特市|辽宁省本溪市|辽宁省丹东市|辽宁省锦州市|辽宁省阜新市|辽宁省辽阳市|黑龙江省鸡西市|黑龙江省鹤岗市|黑龙江省大庆市|黑龙江省伊春市|黑龙江省佳木斯市|黑龙江省牡丹|江市江苏省无锡市|江苏省常州市|江苏省苏州市|浙江省宁波市|安徽省合肥市|安徽省淮南市|安徽省淮北市|福建省厦门市|山东省枣庄市|山东省烟台市|山东省潍坊市|山东省泰安市|山东省临沂市|河南省开封市|河南省洛阳市|河南省平顶山市|河南省安阳市|河南省新乡市|河南省焦作市|湖北省黄石市|湖北省襄樊市|湖北省荆州市|湖南省株洲市|湖南省湘潭市|湖南省衡阳市|广东省深圳市|","|")
		Randomize
		For e=0 To a
			f = "来自 " &  c(Int(Rnd*Ubound(c))) & " "
			f = f & b(Int(Rnd*Ubound(b)))
			f = f & IIF( Int(Rnd*2)=1, "先生", "女士" )
			g = g & "<li>" & f & "</li>"		
		Next
		ShowHandleUserList = g
	End Function
	
	
	Function MainBanner(a,b,c,d,e)
		Dim f, g
		If e <> "" Then
			f="Select * From [ThreeClass] Where BigClassName='"& c &"' And SmallClassName='"& d &"' And ThreeClassName='" & e & "'"
		ElseIf d <> "" Then
			f="Select * From [SmallClass] Where BigClassName='"& c &"' And SmallClassName='"& d &"'"
		ElseIf c <> "" Then
			f="Select * From [BigClass] Where BigClassName='"& c &"'"
		ElseIf b <> "" Then	
			f="Select * From [NavSmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"'"
		ElseIf a <> "" Then	
			f="Select * From [NavBigClass] Where BigClassName='"& a &"'"
		End If
		If f <> "" Then
			Rs.Open f,Conn,1,1
			If Not Rs.Eof Then
				g = Rs("ImgPath")
			End If : Rs.Close			
		End If
		
		If g = "" Then
			g = DefaultWebBanner
		End If
		
		If InStr(Lcase(g),"http://") = False And InStr(Lcase(g),"http://") = False Then
			g = "http://" & Request.ServerVariables("HTTP_HOST") & g
		End If
		MainBanner = g
	End Function


	
	
	
	Function NewWebNavigation(a,b)
		Dim c, d, e, f, g, h, i, j
		Rs.Open "Select * From [NavBigClass] " & b, Conn, 1, 1
		For c = 1 To Rs.RecordCount
			f = Rs("FileName")
			If f <> "" And Right(f,1)<>"/" Then f = f & ".html"
		
			g = "/" & Rs("FolderName") & "/"
			h = Rs("BigClassName")
			i = FontColorFontB(h, Rs("FontB"), Rs("FontColor"))
			j = Rs("Target")

			e = Rs("FileName")
			If CheckRemoteUrl(e)=False Then
				e = g & f
				e = Replace(Replace(e, "//", "/"), "//", "/")
				Call WebDebug(e,"act=Nav&NavDid=" & h)
			End If
			
			If a=Rs("BigClassName") Then
				d = d & "<span class='NavValue'>" & i & "</span>"
			Else
				d = d & "<a " & AHref(e, "", j) & " class='nav'>" & i & "</a>"
			End If
			If c <> Rs.RecordCount Then d = d & "<span class=""NavLine""></span>"
		Rs.MoveNext : Next : Rs.Close
		NewWebNavigation = d
	End Function
	
	
	
	
	Function WebNavigation(a)
		Dim b, c, d, e, f, g, h, i
		Rs.Open "Select * From [NavBigClass] " & a, Conn, 1, 1
		For b = 1 To Rs.RecordCount
			e = Rs("FileName")
			If e <> "" And Right(e,1)<>"/" Then e = e & ".html"
		
			f = "/" & Rs("FolderName") & "/"
			g = Rs("BigClassName")
			h = FontColorFontB(g, Rs("FontB"), Rs("FontColor"))
			i = Rs("Target")
			
			d = Rs("FileName")
			If CheckRemoteUrl(d)=False Then
				d = f & e
				d = Replace(Replace(d, "//", "/"), "//", "/")
				Call WebDebug(d,"act=Nav&NavDid=" & g)
			End If
			
			c = c & "<a " & AHref(d, "", i) & ">" & h & "</a>"
			If b <> Rs.RecordCount Then c = c & " &nbsp;| &nbsp; "
		Rs.MoveNext : Next : Rs.Close
		WebNavigation = c
	End Function
	
	
	
	Function FriendLink()
		Dim b,c,d,e,f,g,h
		Rsx.Open"Select * From [FriendLink] Where Through=True Order By Sort",Conn,1,1
		For g=1 To Rsx.RecordCount
			b =  Rsx("Url")
			d = ATarget(Rsx("Target"))
			e = ARel(Rsx("NoFollow"))
			c = Rsx("Title")
			f = Rsx("ImgPath")
			h=h & "<div class='LinkBlock'><a href='"& b &"'"& d &""&e&"><img src="& f &"></a><br>"
			h=h & "<a href='"& b &"'"& d &""&e&">"& FontColorFontB(c,Rsx("FontB"),Rsx("FontColor")) &"</a></div>" & vbCrlf		
		Rsx.MoveNext:Next:Rsx.Close
		FriendLink = h
	End Function
	
	
	Function BannerTab(a, b, c,d,e)
		Dim f, g, h, i
		If c="" Then c = 980
		If d="" Then d=230
		i=i & "<style type=""text/css""> " & vbCrlf
		i=i & ".container, .container *{margin:0; padding:0;}" & vbCrlf
		i=i & ".container{width:"& c &"px; height:"& d &"px; overflow:hidden;position:relative;}" & vbCrlf
		i=i & ".slider{position:absolute;}" & vbCrlf
		i=i & ".slider li{ list-style:none;display:inline;}" & vbCrlf
		i=i & ".slider img{ width:"& c &"px; height:"& d &"px; display:block;}" & vbCrlf
		i=i & ".slider2{width:8000px;}" & vbCrlf
		i=i & ".slider2 li{float:left;}" & vbCrlf
		i=i & ".num{ position:absolute; right:5px; bottom:5px;}" & vbCrlf
		i=i & ".num li{" & vbCrlf
		i=i & "	float: left;" & vbCrlf
		i=i & "	color: #FF7300;" & vbCrlf
		i=i & "	text-align: center;" & vbCrlf
		i=i & "	line-height: 16px;" & vbCrlf
		i=i & "	width: 16px;" & vbCrlf
		i=i & "	height: 16px;" & vbCrlf
		i=i & "	font-family: Arial;" & vbCrlf
		i=i & "	font-size: 12px;" & vbCrlf
		i=i & "	cursor: pointer;" & vbCrlf
		i=i & "	overflow: hidden;" & vbCrlf
		i=i & "	margin: 3px 1px;" & vbCrlf
		i=i & "	border: 1px solid #FF7300;" & vbCrlf
		i=i & "	background-color: #fff;" & vbCrlf
		i=i & "}" & vbCrlf
		i=i & ".num li.on{" & vbCrlf
		i=i & "	color: #fff;" & vbCrlf
		i=i & "	line-height: 21px;" & vbCrlf
		i=i & "	width: 21px;" & vbCrlf
		i=i & "	height: 21px;" & vbCrlf
		i=i & "	font-size: 16px;" & vbCrlf
		i=i & "	margin: 0 1px;" & vbCrlf
		i=i & "	border: 0;" & vbCrlf
		i=i & "	background-color: #FF7300;" & vbCrlf
		i=i & "	font-weight: bold;" & vbCrlf
		i=i & "}" & vbCrlf
		i=i & "</style>" & vbCrlf
		
		
	    Rs.Open "Select * From[Product] Where BigClassName='" & a & "'", Conn, 1, 1
		
		i=i & "<div class=""container"" id=""idTransformView2"">" & vbCrlf
		i=i & "  <ul class=""slider slider2"" id=""idSlider2"">" & vbCrlf
		For g=1 To b
			If Rs.Eof Then b=g-1 : Exit For
			i=i & "    <li><img src="""& Rs("BigFiles") &"""/></li>" & vbCrlf
 		Rs.MoveNext:Next : Rs.Close
		i=i & "  </ul>" & vbCrlf
		i=i & "  <ul class=""num"" id=""idNum2"">" & vbCrlf
		
		For g=1 To b
			i=i & "    <li>"& g &"</li>" & vbCrlf
		Next
		i=i & "  </ul>" & vbCrlf
		i=i & "</div>" & vbCrlf
		i=i & "<script type=""text/javascript"">" & vbCrlf
		i=i & "var $Mid = function (id) {" & vbCrlf
		i=i & "	return ""string"" == typeof id ? document.getElementById(id) : id;" & vbCrlf
		i=i & "};" & vbCrlf
		i=i & "var Class = {" & vbCrlf
		i=i & "  create: function() {" & vbCrlf
		i=i & "	return function() {" & vbCrlf
		i=i & "	  this.initialize.apply(this, arguments);" & vbCrlf
		i=i & "	}" & vbCrlf
		i=i & "  }" & vbCrlf
		i=i & "}" & vbCrlf
		i=i & "Object.extend = function(destination, source) {" & vbCrlf
		i=i & "	for (var property in source) {" & vbCrlf
		i=i & "		destination[property] = source[property];" & vbCrlf
		i=i & "	}" & vbCrlf
		i=i & "	return destination;" & vbCrlf
		i=i & "}" & vbCrlf
		i=i & "var TransformView = Class.create();" & vbCrlf
		i=i & "TransformView.prototype = {" & vbCrlf
		i=i & "  //容器对象,滑动对象,切换参数,切换数量" & vbCrlf
		i=i & "  initialize: function(container, slider, parameter, count, options) {" & vbCrlf
		i=i & "	if(parameter <= 0 || count <= 0) return;" & vbCrlf
		i=i & "	var oContainer = $Mid(container), oSlider = $Mid(slider), oThis = this;" & vbCrlf
		i=i & "	this.Index = 0;//当前索引" & vbCrlf
		i=i & "	" & vbCrlf
		i=i & "	this._timer = null;//定时器" & vbCrlf
		i=i & "	this._slider = oSlider;//滑动对象" & vbCrlf
		i=i & "	this._parameter = parameter;//切换参数" & vbCrlf
		i=i & "	this._count = count || 0;//切换数量" & vbCrlf
		i=i & "	this._target = 0;//目标参数" & vbCrlf
		i=i & "	" & vbCrlf
		i=i & "	this.SetOptions(options);" & vbCrlf
		i=i & "	" & vbCrlf
		i=i & "	this.Up = !!this.options.Up;" & vbCrlf
		i=i & "	this.Step = Math.abs(this.options.Step);" & vbCrlf
		i=i & "	this.Time = Math.abs(this.options.Time);" & vbCrlf
		i=i & "	this.Auto = !!this.options.Auto;" & vbCrlf
		i=i & "	this.Pause = Math.abs(this.options.Pause);" & vbCrlf
		i=i & "	this.onStart = this.options.onStart;" & vbCrlf
		i=i & "	this.onFinish = this.options.onFinish;" & vbCrlf
		i=i & "	oContainer.style.overflow = ""hidden"";" & vbCrlf
		i=i & "	oContainer.style.position = ""relative"";" & vbCrlf
		i=i & "	oSlider.style.position = ""absolute"";" & vbCrlf
		i=i & "	oSlider.style.top = oSlider.style.left = 0;" & vbCrlf
		i=i & "  }," & vbCrlf
		i=i & "  //设置默认属性" & vbCrlf
		i=i & "  SetOptions: function(options) {" & vbCrlf
		i=i & "	this.options = {//默认值" & vbCrlf
		i=i & "		Up:		true,//是否向上(否则向左)" & vbCrlf
		i=i & "		Step:		5,//滑动变化率" & vbCrlf
		i=i & "		Time:		10,//滑动延时" & vbCrlf
		i=i & "		Auto:		true,//是否自动转换" & vbCrlf
		i=i & "		Pause:		2000,//停顿时间(Auto为true时有效)" & vbCrlf
		i=i & "		onStart:	function(){},//开始转换时执行" & vbCrlf
		i=i & "		onFinish:	function(){}//完成转换时执行" & vbCrlf
		i=i & "	};" & vbCrlf
		i=i & "	Object.extend(this.options, options || {});" & vbCrlf
		i=i & "  }," & vbCrlf
		i=i & "  //开始切换设置" & vbCrlf
		i=i & "  Start: function() {" & vbCrlf
		i=i & "	if(this.Index < 0){" & vbCrlf
		i=i & "		this.Index = this._count - 1;" & vbCrlf
		i=i & "	} else if (this.Index >= this._count){ this.Index = 0; }" & vbCrlf
		i=i & "	" & vbCrlf
		i=i & "	this._target = -1 * this._parameter * this.Index;" & vbCrlf
		i=i & "	this.onStart();" & vbCrlf
		i=i & "	this.Move();" & vbCrlf
		i=i & "  }," & vbCrlf
		i=i & "  //移动" & vbCrlf
		i=i & "  Move: function() {" & vbCrlf
		i=i & "	clearTimeout(this._timer);" & vbCrlf
		i=i & "	var oThis = this, style = this.Up ? ""top"" : ""left"", iNow = parseInt(this._slider.style[style]) || 0, iStep = this.GetStep(this._target, iNow);" & vbCrlf
		i=i & "	" & vbCrlf
		i=i & "	if (iStep != 0) {" & vbCrlf
		i=i & "		this._slider.style[style] = (iNow + iStep) + ""px"";" & vbCrlf
		i=i & "		this._timer = setTimeout(function(){ oThis.Move(); }, this.Time);" & vbCrlf
		i=i & "	} else {" & vbCrlf
		i=i & "		this._slider.style[style] = this._target + ""px"";" & vbCrlf
		i=i & "		this.onFinish();" & vbCrlf
		i=i & "		if (this.Auto) { this._timer = setTimeout(function(){ oThis.Index++; oThis.Start(); }, this.Pause); }" & vbCrlf
		i=i & "	}" & vbCrlf
		i=i & "  }," & vbCrlf
		i=i & "  //获取步长" & vbCrlf
		i=i & "  GetStep: function(iTarget, iNow) {" & vbCrlf
		i=i & "	var iStep = (iTarget - iNow) / this.Step;" & vbCrlf
		i=i & "	if (iStep == 0) return 0;" & vbCrlf
		i=i & "	if (Math.abs(iStep) < 1) return (iStep > 0 ? 1 : -1);" & vbCrlf
		i=i & "	return iStep;" & vbCrlf
		i=i & "  }," & vbCrlf
		i=i & "  //停止" & vbCrlf
		i=i & "  Stop: function(iTarget, iNow) {" & vbCrlf
		i=i & "	clearTimeout(this._timer);" & vbCrlf
		i=i & "	this._slider.style[this.Up ? ""top"" : ""left""] = this._target + ""px"";" & vbCrlf
		i=i & "  }" & vbCrlf
		i=i & "};" & vbCrlf
		i=i & "window.onload=function(){" & vbCrlf
		i=i & "	function Each(list, fun){" & vbCrlf
		i=i & "		for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }" & vbCrlf
		i=i & "	};" & vbCrlf
		i=i & "	var objs = $Mid(""idNum2"").getElementsByTagName(""li"");" & vbCrlf
		i=i & "	var tv = new TransformView(""idTransformView2"", ""idSlider2"", 980, "& b &", {" & vbCrlf
		i=i & "		onStart: function(){ Each(objs, function(o, i){ o.className = tv.Index == i ? ""on"" : """"; }) },//按钮样式" & vbCrlf
		i=i & "		Up: false" & vbCrlf
		i=i & "	});" & vbCrlf
		i=i & "	tv.Start();" & vbCrlf
		i=i & "	Each(objs, function(o, i){" & vbCrlf
		i=i & "		o.onmouseover = function(){" & vbCrlf
		i=i & "			o.className = ""on"";" & vbCrlf
		i=i & "			tv.Auto = false;" & vbCrlf
		i=i & "			tv.Index = i;" & vbCrlf
		i=i & "			tv.Start();" & vbCrlf
		i=i & "		}" & vbCrlf
		i=i & "		o.onmouseout = function(){" & vbCrlf
		i=i & "			o.className = """";" & vbCrlf
		i=i & "			tv.Auto = true;" & vbCrlf
		i=i & "			tv.Start();" & vbCrlf
		i=i & "		}" & vbCrlf
		i=i & "	})" & vbCrlf
		i=i & "}" & vbCrlf
		i=i & "</script>" & vbCrlf
	
		BannerTab=i
	End Function

	
	

End Class
%>

