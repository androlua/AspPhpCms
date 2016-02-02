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
cLAsS cLAsSYoUKoU
fUNcTIoN dIVnAViGAtIOn(a,b)
dIM c, d, e, f, g, h, i, j, k
rS.oPEn "Select * From [NavBigClass] " & b, cONn, 1, 1
d = d & "<li class=left></li>" & vBCrLF
fOR c = 1 tO rS.rECoRDcOUnT
g = rS("FileName")
iF g <> "" aND rIGhT(g,1)<>"/" tHEn g = g & ".html"
h = "/" & rS("FolderName") & "/"
i = rS("BigClassName")
j = fONtCOlORfONtB(i, rS("FontB"), rS("FontColor"))
k = rS("Target")
f = rS("FileName")
iF cHEcKReMOtEUrL(f)=fALsE tHEn
f = h & g
f = rEPlACe(rEPlACe(f, "//", "/"), "//", "/")
f = fULlHTtPUrL(hOSt,f)
cALl wEBdEBuG(f,"act=Nav&NavDid=" & i)
eND iF
iF a=rS("BigClassName") tHEn
d = d & "<li class=focus>"& j &"</li>" &vBCrLF
eLSe
d = d & "<li><a " & aHReF(f, "", k) & ">" & j & "</a></li>" &vBCrLF
eND iF
d = d & "<li class=line></li>" & vBCrLF
rS.mOVeNExT : nEXt : rS.cLOsE
d = d & "<li class=right></li>" & vBCrLF
dIVnAViGAtIOn = d
eND fUNcTIoN
fUNcTIoN sHOwHAnDLeUSeRLiST(a)
dIM b,c,d,e,f,g
b=sPLiT("王|李|张|刘|陈|杨|黄|吴|赵|周|徐|孙|马|朱|胡|林|郭|何|高|罗|郑|梁|谢|宋|唐|许|邓|冯|韩|曹|曾|彭|萧|蔡|潘|田|董|袁|于|余|叶|蒋|杜|苏|魏|程|吕|丁|沈|任|姚|卢|傅|钟|姜|崔|谭|廖|范|汪|陆|金|石|戴|贾|韦|夏|邱|方|侯|邹|熊|孟|秦|白|江|阎|薛|尹|段|雷|黎|史|龙|陶|贺|顾|毛|郝|龚|邵|万|钱|严|赖|覃|洪","|")
c=sPLiT("武北京市|天津市|辽宁省沈阳市|吉林省长春市|黑龙江省哈尔滨市|上海市|江苏省南京市|湖北省武汉市|广东省广州市|重庆市|四川省成都市|陕西省西安市|河北省石家庄市|河北省唐山市|山西省太原市|内蒙包头市|辽宁省大连市|辽宁省鞍山市|辽宁省抚顺市|吉林省吉林市|黑龙江省齐齐哈尔市|江苏省徐州市|浙江省杭州市|福建省福州市|江西省南昌市|山东省济南市|山东省青岛市|山东省淄博市|河南省郑州市|湖南省长沙市|贵州省贵阳市|云南省昆明市|甘肃省兰州市|新疆乌鲁木齐市|河北省邯郸市|河北省保定市|河北省张家口市|山西省大同市|内蒙呼和浩特市|辽宁省本溪市|辽宁省丹东市|辽宁省锦州市|辽宁省阜新市|辽宁省辽阳市|黑龙江省鸡西市|黑龙江省鹤岗市|黑龙江省大庆市|黑龙江省伊春市|黑龙江省佳木斯市|黑龙江省牡丹|江市江苏省无锡市|江苏省常州市|江苏省苏州市|浙江省宁波市|安徽省合肥市|安徽省淮南市|安徽省淮北市|福建省厦门市|山东省枣庄市|山东省烟台市|山东省潍坊市|山东省泰安市|山东省临沂市|河南省开封市|河南省洛阳市|河南省平顶山市|河南省安阳市|河南省新乡市|河南省焦作市|湖北省黄石市|湖北省襄樊市|湖北省荆州市|湖南省株洲市|湖南省湘潭市|湖南省衡阳市|广东省深圳市|","|")
rANdOMiZE
fOR e=0 tO a
f = "来自 " &  c(iNT(rND*uBOuND(c))) & " "
f = f & b(iNT(rND*uBOuND(b)))
f = f & iIF( iNT(rND*2)=1, "先生", "女士" )
g = g & "<li>" & f & "</li>"	
nEXt
sHOwHAnDLeUSeRLiST = g
eND fUNcTIoN
fUNcTIoN mAInBAnNEr(a,b,c,d,e)
dIM f, g
iF e <> "" tHEn
f="Select * From [ThreeClass] Where BigClassName='"& c &"' And SmallClassName='"& d &"' And ThreeClassName='" & e & "'"
eLSeIF d <> "" tHEn
f="Select * From [SmallClass] Where BigClassName='"& c &"' And SmallClassName='"& d &"'"
eLSeIF c <> "" tHEn
f="Select * From [BigClass] Where BigClassName='"& c &"'"
eLSeIF b <> "" tHEn	
f="Select * From [NavSmallClass] Where BigClassName='"& a &"' And SmallClassName='"& b &"'"
eLSeIF a <> "" tHEn	
f="Select * From [NavBigClass] Where BigClassName='"& a &"'"
eND iF
iF f <> "" tHEn
rS.oPEn f,cONn,1,1
iF nOT rS.eOF tHEn
g = rS("ImgPath")
eND iF : rS.cLOsE	
eND iF
iF g = "" tHEn
g = dEFaULtWEbBAnNEr
eND iF
iF iNStR(lCAsE(g),"http://") = fALsE aND iNStR(lCAsE(g),"http://") = fALsE tHEn
g = "http://" & rEQuESt.sERvERvARiABlES("HTTP_HOST") & g
eND iF
mAInBAnNEr = g
eND fUNcTIoN
fUNcTIoN nEWwEBnAViGAtIOn(a,b)
dIM c, d, e, f, g, h, i, j
rS.oPEn "Select * From [NavBigClass] " & b, cONn, 1, 1
fOR c = 1 tO rS.rECoRDcOUnT
f = rS("FileName")
iF f <> "" aND rIGhT(f,1)<>"/" tHEn f = f & ".html"
g = "/" & rS("FolderName") & "/"
h = rS("BigClassName")
i = fONtCOlORfONtB(h, rS("FontB"), rS("FontColor"))
j = rS("Target")
e = rS("FileName")
iF cHEcKReMOtEUrL(e)=fALsE tHEn
e = g & f
e = rEPlACe(rEPlACe(e, "//", "/"), "//", "/")
cALl wEBdEBuG(e,"act=Nav&NavDid=" & h)
eND iF
iF a=rS("BigClassName") tHEn
d = d & "<span class='NavValue'>" & i & "</span>"
eLSe
d = d & "<a " & aHReF(e, "", j) & " class='nav'>" & i & "</a>"
eND iF
iF c <> rS.rECoRDcOUnT tHEn d = d & "<span class=""NavLine""></span>"
rS.mOVeNExT : nEXt : rS.cLOsE
nEWwEBnAViGAtIOn = d
eND fUNcTIoN
fUNcTIoN wEBnAViGAtIOn(a)
dIM b, c, d, e, f, g, h, i
rS.oPEn "Select * From [NavBigClass] " & a, cONn, 1, 1
fOR b = 1 tO rS.rECoRDcOUnT
e = rS("FileName")
iF e <> "" aND rIGhT(e,1)<>"/" tHEn e = e & ".html"
f = "/" & rS("FolderName") & "/"
g = rS("BigClassName")
h = fONtCOlORfONtB(g, rS("FontB"), rS("FontColor"))
i = rS("Target")
d = rS("FileName")
iF cHEcKReMOtEUrL(d)=fALsE tHEn
d = f & e
d = rEPlACe(rEPlACe(d, "//", "/"), "//", "/")
cALl wEBdEBuG(d,"act=Nav&NavDid=" & g)
eND iF
c = c & "<a " & aHReF(d, "", i) & ">" & h & "</a>"
iF b <> rS.rECoRDcOUnT tHEn c = c & " &nbsp;| &nbsp; "
rS.mOVeNExT : nEXt : rS.cLOsE
wEBnAViGAtIOn = c
eND fUNcTIoN
fUNcTIoN fRIeNDlINk()
dIM b,c,d,e,f,g,h
rSX.oPEn"Select * From [FriendLink] Where Through=True Order By Sort",cONn,1,1
fOR g=1 tO rSX.rECoRDcOUnT
b =  rSX("Url")
d = aTArGEt(rSX("Target"))
e = aREl(rSX("NoFollow"))
c = rSX("Title")
f = rSX("ImgPath")
h=h & "<div class='LinkBlock'><a href='"& b &"'"& d &""&e&"><img src="& f &"></a><br>"
h=h & "<a href='"& b &"'"& d &""&e&">"& fONtCOlORfONtB(c,rSX("FontB"),rSX("FontColor")) &"</a></div>" & vBCrLF	
rSX.mOVeNExT:nEXt:rSX.cLOsE
fRIeNDlINk = h
eND fUNcTIoN
fUNcTIoN bANnERtAB(a, b, c,d,e)
dIM f, g, h, i
iF c="" tHEn c = 980
iF d="" tHEn d=230
i=i & "<style type=""text/css""> " & vBCrLF
i=i & ".container, .container *{margin:0; padding:0;}" & vBCrLF
i=i & ".container{width:"& c &"px; height:"& d &"px; overflow:hidden;position:relative;}" & vBCrLF
i=i & ".slider{position:absolute;}" & vBCrLF
i=i & ".slider li{ list-style:none;display:inline;}" & vBCrLF
i=i & ".slider img{ width:"& c &"px; height:"& d &"px; display:block;}" & vBCrLF
i=i & ".slider2{width:8000px;}" & vBCrLF
i=i & ".slider2 li{float:left;}" & vBCrLF
i=i & ".num{ position:absolute; right:5px; bottom:5px;}" & vBCrLF
i=i & ".num li{" & vBCrLF
i=i & "	float: left;" & vBCrLF
i=i & "	color: #FF7300;" & vBCrLF
i=i & "	text-align: center;" & vBCrLF
i=i & "	line-height: 16px;" & vBCrLF
i=i & "	width: 16px;" & vBCrLF
i=i & "	height: 16px;" & vBCrLF
i=i & "	font-family: Arial;" & vBCrLF
i=i & "	font-size: 12px;" & vBCrLF
i=i & "	cursor: pointer;" & vBCrLF
i=i & "	overflow: hidden;" & vBCrLF
i=i & "	margin: 3px 1px;" & vBCrLF
i=i & "	border: 1px solid #FF7300;" & vBCrLF
i=i & "	background-color: #fff;" & vBCrLF
i=i & "}" & vBCrLF
i=i & ".num li.on{" & vBCrLF
i=i & "	color: #fff;" & vBCrLF
i=i & "	line-height: 21px;" & vBCrLF
i=i & "	width: 21px;" & vBCrLF
i=i & "	height: 21px;" & vBCrLF
i=i & "	font-size: 16px;" & vBCrLF
i=i & "	margin: 0 1px;" & vBCrLF
i=i & "	border: 0;" & vBCrLF
i=i & "	background-color: #FF7300;" & vBCrLF
i=i & "	font-weight: bold;" & vBCrLF
i=i & "}" & vBCrLF
i=i & "</style>" & vBCrLF
rS.oPEn "Select * From[Product] Where BigClassName='" & a & "'", cONn, 1, 1
i=i & "<div class=""container"" id=""idTransformView2"">" & vBCrLF
i=i & "  <ul class=""slider slider2"" id=""idSlider2"">" & vBCrLF
fOR g=1 tO b
iF rS.eOF tHEn b=g-1 : eXIt fOR
i=i & "    <li><img src="""& rS("BigFiles") &"""/></li>" & vBCrLF
rS.mOVeNExT:nEXt : rS.cLOsE
i=i & "  </ul>" & vBCrLF
i=i & "  <ul class=""num"" id=""idNum2"">" & vBCrLF
fOR g=1 tO b
i=i & "    <li>"& g &"</li>" & vBCrLF
nEXt
i=i & "  </ul>" & vBCrLF
i=i & "</div>" & vBCrLF
i=i & "<script type=""text/javascript"">" & vBCrLF
i=i & "var $Mid = function (id) {" & vBCrLF
i=i & "	return ""string"" == typeof id ? document.getElementById(id) : id;" & vBCrLF
i=i & "};" & vBCrLF
i=i & "var Class = {" & vBCrLF
i=i & "  create: function() {" & vBCrLF
i=i & "	return function() {" & vBCrLF
i=i & "	  this.initialize.apply(this, arguments);" & vBCrLF
i=i & "	}" & vBCrLF
i=i & "  }" & vBCrLF
i=i & "}" & vBCrLF
i=i & "Object.extend = function(destination, source) {" & vBCrLF
i=i & "	for (var property in source) {" & vBCrLF
i=i & "		destination[property] = source[property];" & vBCrLF
i=i & "	}" & vBCrLF
i=i & "	return destination;" & vBCrLF
i=i & "}" & vBCrLF
i=i & "var TransformView = Class.create();" & vBCrLF
i=i & "TransformView.prototype = {" & vBCrLF
i=i & "  //容器对象,滑动对象,切换参数,切换数量" & vBCrLF
i=i & "  initialize: function(container, slider, parameter, count, options) {" & vBCrLF
i=i & "	if(parameter <= 0 || count <= 0) return;" & vBCrLF
i=i & "	var oContainer = $Mid(container), oSlider = $Mid(slider), oThis = this;" & vBCrLF
i=i & "	this.Index = 0;//当前索引" & vBCrLF
i=i & "	" & vBCrLF
i=i & "	this._timer = null;//定时器" & vBCrLF
i=i & "	this._slider = oSlider;//滑动对象" & vBCrLF
i=i & "	this._parameter = parameter;//切换参数" & vBCrLF
i=i & "	this._count = count || 0;//切换数量" & vBCrLF
i=i & "	this._target = 0;//目标参数" & vBCrLF
i=i & "	" & vBCrLF
i=i & "	this.SetOptions(options);" & vBCrLF
i=i & "	" & vBCrLF
i=i & "	this.Up = !!this.options.Up;" & vBCrLF
i=i & "	this.Step = Math.abs(this.options.Step);" & vBCrLF
i=i & "	this.Time = Math.abs(this.options.Time);" & vBCrLF
i=i & "	this.Auto = !!this.options.Auto;" & vBCrLF
i=i & "	this.Pause = Math.abs(this.options.Pause);" & vBCrLF
i=i & "	this.onStart = this.options.onStart;" & vBCrLF
i=i & "	this.onFinish = this.options.onFinish;" & vBCrLF
i=i & "	oContainer.style.overflow = ""hidden"";" & vBCrLF
i=i & "	oContainer.style.position = ""relative"";" & vBCrLF
i=i & "	oSlider.style.position = ""absolute"";" & vBCrLF
i=i & "	oSlider.style.top = oSlider.style.left = 0;" & vBCrLF
i=i & "  }," & vBCrLF
i=i & "  //设置默认属性" & vBCrLF
i=i & "  SetOptions: function(options) {" & vBCrLF
i=i & "	this.options = {//默认值" & vBCrLF
i=i & "		Up:		true,//是否向上(否则向左)" & vBCrLF
i=i & "		Step:		5,//滑动变化率" & vBCrLF
i=i & "		Time:		10,//滑动延时" & vBCrLF
i=i & "		Auto:		true,//是否自动转换" & vBCrLF
i=i & "		Pause:		2000,//停顿时间(Auto为true时有效)" & vBCrLF
i=i & "		onStart:	function(){},//开始转换时执行" & vBCrLF
i=i & "		onFinish:	function(){}//完成转换时执行" & vBCrLF
i=i & "	};" & vBCrLF
i=i & "	Object.extend(this.options, options || {});" & vBCrLF
i=i & "  }," & vBCrLF
i=i & "  //开始切换设置" & vBCrLF
i=i & "  Start: function() {" & vBCrLF
i=i & "	if(this.Index < 0){" & vBCrLF
i=i & "		this.Index = this._count - 1;" & vBCrLF
i=i & "	} else if (this.Index >= this._count){ this.Index = 0; }" & vBCrLF
i=i & "	" & vBCrLF
i=i & "	this._target = -1 * this._parameter * this.Index;" & vBCrLF
i=i & "	this.onStart();" & vBCrLF
i=i & "	this.Move();" & vBCrLF
i=i & "  }," & vBCrLF
i=i & "  //移动" & vBCrLF
i=i & "  Move: function() {" & vBCrLF
i=i & "	clearTimeout(this._timer);" & vBCrLF
i=i & "	var oThis = this, style = this.Up ? ""top"" : ""left"", iNow = parseInt(this._slider.style[style]) || 0, iStep = this.GetStep(this._target, iNow);" & vBCrLF
i=i & "	" & vBCrLF
i=i & "	if (iStep != 0) {" & vBCrLF
i=i & "		this._slider.style[style] = (iNow + iStep) + ""px"";" & vBCrLF
i=i & "		this._timer = setTimeout(function(){ oThis.Move(); }, this.Time);" & vBCrLF
i=i & "	} else {" & vBCrLF
i=i & "		this._slider.style[style] = this._target + ""px"";" & vBCrLF
i=i & "		this.onFinish();" & vBCrLF
i=i & "		if (this.Auto) { this._timer = setTimeout(function(){ oThis.Index++; oThis.Start(); }, this.Pause); }" & vBCrLF
i=i & "	}" & vBCrLF
i=i & "  }," & vBCrLF
i=i & "  //获取步长" & vBCrLF
i=i & "  GetStep: function(iTarget, iNow) {" & vBCrLF
i=i & "	var iStep = (iTarget - iNow) / this.Step;" & vBCrLF
i=i & "	if (iStep == 0) return 0;" & vBCrLF
i=i & "	if (Math.abs(iStep) < 1) return (iStep > 0 ? 1 : -1);" & vBCrLF
i=i & "	return iStep;" & vBCrLF
i=i & "  }," & vBCrLF
i=i & "  //停止" & vBCrLF
i=i & "  Stop: function(iTarget, iNow) {" & vBCrLF
i=i & "	clearTimeout(this._timer);" & vBCrLF
i=i & "	this._slider.style[this.Up ? ""top"" : ""left""] = this._target + ""px"";" & vBCrLF
i=i & "  }" & vBCrLF
i=i & "};" & vBCrLF
i=i & "window.onload=function(){" & vBCrLF
i=i & "	function Each(list, fun){" & vBCrLF
i=i & "		for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }" & vBCrLF
i=i & "	};" & vBCrLF
i=i & "	var objs = $Mid(""idNum2"").getElementsByTagName(""li"");" & vBCrLF
i=i & "	var tv = new TransformView(""idTransformView2"", ""idSlider2"", 980, "& b &", {" & vBCrLF
i=i & "		onStart: function(){ Each(objs, function(o, i){ o.className = tv.Index == i ? ""on"" : """"; }) },//按钮样式" & vBCrLF
i=i & "		Up: false" & vBCrLF
i=i & "	});" & vBCrLF
i=i & "	tv.Start();" & vBCrLF
i=i & "	Each(objs, function(o, i){" & vBCrLF
i=i & "		o.onmouseover = function(){" & vBCrLF
i=i & "			o.className = ""on"";" & vBCrLF
i=i & "			tv.Auto = false;" & vBCrLF
i=i & "			tv.Index = i;" & vBCrLF
i=i & "			tv.Start();" & vBCrLF
i=i & "		}" & vBCrLF
i=i & "		o.onmouseout = function(){" & vBCrLF
i=i & "			o.className = """";" & vBCrLF
i=i & "			tv.Auto = true;" & vBCrLF
i=i & "			tv.Start();" & vBCrLF
i=i & "		}" & vBCrLF
i=i & "	})" & vBCrLF
i=i & "}" & vBCrLF
i=i & "</script>" & vBCrLF
bANnERtAB=i
eND fUNcTIoN
eND cLAsS
%>
