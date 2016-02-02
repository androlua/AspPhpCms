


//<script type="text/javascript" src="/Jquery/Common.js"></script

/*  帮助中心 20150124

忽视错误JS代码
try{
	document.all.aasd.innerHTML="sdf"
	alert("11")
}catch(exception){
	alert("sdf")
}

var agent = navigator.userAgent.toLowerCase();   //获得浏览器信息20152017
*/


//判断指定Check值是否有选中 20150120 existsCheck('selectPid')
function existsCheck(CheckName){
	var c=""
	var a = document.getElementsByTagName("input");
	for (var i=0; i<a.length; i++){
		if(a[i].type=="checkbox"){
			if(a[i].name == CheckName){ 
				//alert(a[i].checked)
				if(a[i].checked==true){
					c+=a[i].name + "=" + a[i].checked+"("+ CheckName +")\n";
				}
			}
		}
	}
	if(c==""){ 
		//alert(c)
		return false
	}else{
		//alert(c)
		return true;
	}
}
//显示颜色
function ShowColor(This,Id){
	//暂时不处理
	return false;
	if(This.checked==true){
		$id("TR"+Id).style.backgroundColor="#FF0000";
	}
}
 

//设置背景颜色
function SetBgColor(Obj,Color){
	Obj.style.backgroundColor = Color
}

//异常处理例子在 百度知道里看到的20140703
function message(){
	try{
		alert("aa")
	//异常处理
	}catch(err){
		txt="本页中存在错误。\n\n"
		txt+="点击“确定”继续查看本页，\n"
		txt+="点击“取消”返回首页。\n\n"
		//解释下这里！是代表什么意思？有什么作用，3Q
		if(!confirm(txt)){
			document.location.href="/index.html"
		}
	}
}
//获取元素id
function $id(str){
	return document.getElementById(str);
}
// 获取元素name
function $name(str){
	return document.getElementsByName(str);
}
//分割
function Split(Content,SplLabel){
	return Content.split(SplLabel)
}
//截取左边
function Left(mainStr,lngLen) { 
if (lngLen>0) {return mainStr.substring(0,lngLen)} 
else{return null} 
}  
//截取右边
function Right(mainStr,lngLen) { 
	if (mainStr.length-lngLen>=0 && mainStr.length>=0 && mainStr.length-lngLen<=mainStr.length) { 
		return mainStr.substring(mainStr.length-lngLen,mainStr.length)
	}else{
		return null
	} 
} 
//Mid方式截取字符
function Mid(mainStr,starnum,endnum){ 
	if(mainStr.length>=0){ 
		return mainStr.substr(starnum,endnum) 
	}else{
		return null
	}
}
//删除左右两端的空格
function trim(str){
    return str.replace(/(^\s*)|(\s*$)/g, "")
}
//删除左边的空格
function ltrim(str){
    return str.replace(/(^\s*)/g,"");
}
//删除右边的空格
function rtrim(str){
    return str.replace(/(\s*$)/g,"");
}
//JS操作cookies方法! 
//写cookies   Days=3000  为三秒   86400=一天
function setCookie(name,value,Days) { 
	if(Days==undefined){
		Days=24*60*60*100*30			//为30天
	}
	var exp = new Date(); 
	exp.setTime(exp.getTime() + Days); 
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
} 
//读取cookies 
function getCookie(name) { 
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)"); 
	if(arr=document.cookie.match(reg)) return unescape(arr[2]); 
	else return null; 
} 
//删除cookies   javascript:alert(document.cookie ="postnum=;expires=" + (new Date(0)).toGMTString())
function delCookie(name) { 
	var exp = new Date(); 
	exp.setTime(exp.getTime() - 1); 
	var cval=getCookie(name); 
	if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString(); 
}
//放上移去改变背景背景颜色 高难度自创
function onMouseOverOutColor(This,N,BgColor){
	//alert(N + "\n" + typeof(N))
	var J=0;
	var a = document.getElementsByTagName("input"); 
	for (var i=0; i<a.length; i++){  
		if(a[i].type=="checkbox"){ 
			if(J==N){
				if(a[i].checked == false){
					This.style.backgroundColor = BgColor
					//alert("哈哈")
				}
				return false;
			}
			J++
		}	
	} 
}
//放上去改变背景及文字颜色  onMouseMove="onColor(this,'#FDFAC6','')"
function onColor(root,bcolor,wcolor){
	root.style.color=wcolor	
	if(bcolor != "NO"){
		if(bcolor.indexOf(".")==-1){
			root.style.backgroundColor=bcolor
		}else{
			root.style.backgroundImage="url("+bcolor+")";
		}
	}
}
//离开改变背景及文字颜色  onMouseOut="offColor(this,'','')"
function offColor(root,bcolor,wcolor){
	root.style.color=wcolor
	if(bcolor.indexOf(".")==-1){
		root.style.backgroundColor=bcolor
	}else{
		root.style.backgroundImage="url("+bcolor+")";
	}
} 
//点击背景变色  如：onclick="OnClickBgColorTab(document.all.ID<%=Rs(0)%>,this,'#FFFF99','#FFFFFF')"
function OnClickBgColorTab(ID,This,onColor,OutColor){
	if(This.checked == true){
		ID.style.backgroundColor = onColor
	}else{
		ID.style.backgroundColor = OutColor	
	}
}
//document.oncontextmenu=new Function("event.returnValue=false;");     //
//document.onselectstart=new Function("event.returnValue=false;");
//AjAX XMLHTTP对象实例
function createAjax() { 
	var _xmlhttp;
	try {
		_xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");	//IE的创建方式
	}catch (e) {
		try {
			_xmlhttp=new XMLHttpRequest();	//FF等浏览器的创建方式
		}catch (e) {
			_xmlhttp=false;		//如果创建失败，将返回false
		}
	}
	return _xmlhttp;	//返回xmlhttp对象实例
}
//Ajax("/Ajax.Asp?act=ShowArticleNumb","ArticleViewNumb")
//Ajax
function Ajax(URL,ShowID) {  
	var xmlhttp=createAjax();
	if (xmlhttp) {
		URL+= "&n="+Math.random() 
		xmlhttp.open('post', URL, true);//基本方法
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 		
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	
				var str=unescape(xmlhttp.responseText)
				if(ShowID!="undefined" && ShowID!=""){
					document.getElementById(ShowID).innerHTML = str; 
				}else if(str!=""){
					alert(str)	
				}else{
					alert("显示"+str+URL)
				}
			}
			else {
				if(ShowID!="undefined" && ShowID!=""){
					document.getElementById(ShowID).innerHTML = "<img src=/Images/lodin.gif>正在加载..."
				}
			}
		}
		xmlhttp.send(null);	
		//alert("网络错误");
	}
}
//Ajax2 祈福成功  用法   Ajax2("1.asp","show","count=mtest&passwd=mtest&name=test")
function Ajax2(URL,ShowID,DataStr) {  
	var xmlhttp=createAjax();
	if (xmlhttp) {
		URL+= "&n="+Math.random() 
		xmlhttp.open('post', URL, true);//基本方法
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 		
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	 
				document.getElementById(ShowID).innerHTML =  unescape(xmlhttp.responseText);  
			}else {				
				document.getElementById(ShowID).innerHTML = "<img src=/Images/lodin.gif>正在处理中..."
			}
		}
		xmlhttp.send(DataStr);	
		//alert("网络错误");
	}
}
//Ajax发送无返回值
function AjaxNoReturn(URL) {  
	var xmlhttp=createAjax();
	if (xmlhttp) {
		URL+= "&n="+Math.random() 
		xmlhttp.open('post', URL, true);//基本方法
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 		
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	 
				
			}else {				
				
			}
		}
		xmlhttp.send(null);	
		//alert("网络错误");
	}
}
/****************网站管理******************/
//显示要更新内容<span id="AddTime<%=Rs("Id")%>" onClick="ShowInput('AddTime<%=Rs("Id")%>','AddTime',<%=Rs("ID")%>);"><%=AddTime%></span>
//<span id="AddTime1" onClick="ShowInput('AddTime1','AddTime',1);">111</span>
//S = "<span id=""Title"& Rs("Id") &""" onClick=""ShowInput('../../网站备份/数据库/ZNRobot.mdb','ZNRobot','Title','"& Rs("Id") &"');"">"& Rs("Title") &"</span>"
/*第二种
title="<span onClick=""ShowInput('/../网站备份/数据库/CaiConfig.mdb','CaiConfig','"& fieldName &"','"& Rs("Id") &"');"">"& fieldName &"</span>"
s = "<span id="""& fieldName & Rs("Id") &""" onClick=""ShowInput('/../网站备份/数据库/CaiConfig.mdb','CaiConfig','"& fieldName &"','"& Rs("Id") &"');"">"& Rs(fieldName) &"</span>"
call echo(title,s)
*/
function ShowInput(MDBPath,TableName,FieldName,ID){ 
	var TempContent
	TempContent=""
	//alert(MDBPath)
	ThisObj=document.all[FieldName+ID]
	//转成大写，因为在IE11是小写的  20150227
	if(ThisObj.innerHTML.toUpperCase().indexOf("<TEXTAREA")==-1){
			TempContent=ThisObj.innerHTML
			TempContent=TempContent.replace(/<BR>/g,"\n");	 
			if(TempContent=="&nbsp;"){TempContent=""}
			ThisObj.innerHTML="<Textarea name=TEXT" + ID + " style='width:99%;height:100px;'class=Content onBlur=SaveEditInfo('"+MDBPath+"','"+TableName+"','"+FieldName+"',"+ID+",this.value);>" + TempContent + "</textarea>";
			document.all["TEXT"+ID].focus();
	}
}
//显示下拉菜单
function ShowSelect(MDBPath,TableName,FieldName,ID,SplContent,SplType){ 
	var TempContent
	TempContent=""
	//alert(MDBPath)
	ThisObj=document.all[FieldName+ID] 
	//转成大写，因为在IE11是小写的  20150227
	if(ThisObj.innerHTML.toUpperCase().indexOf("<SELECT")==-1){
			TempContent=ThisObj.innerHTML
			TempContent=TempContent.replace(/<BR>/g,"\n");	 
			if(TempContent=="&nbsp;"){TempContent=""}
			var C="<select name='STEXT" + ID + "' id='select' onBlur=\"SaveEditInfo('"+MDBPath+"','"+TableName+"','"+FieldName+"',"+ID+",this.value);\" >";
			var SplStr=SplContent.split(SplType)
			for(var i=0;i<=SplStr.length;i++){
				var S=SplStr[i]
				if(S!="undefined" && S!=undefined){
					var SelStr=""
					if(S==TempContent){
						var SelStr=" selected"
					}
					C+="<option value='"+ S +"'"+ SelStr +">"+ S +"</option>"
				}
			}
			C+="</select>"
			ThisObj.innerHTML = C
			document.all["STEXT"+ID].focus();
	}
}
//保存更新
function SaveEditInfo(MDBPath,TableName,FieldName,ID,Content) {
	Content=Content.replace(/\n/g,"<br>");
	//alert(MDBPath)
	ThisObj=document.all[FieldName+ID]
	
	var ShowValue = Content
	if(ShowValue=="")ShowValue="&nbsp;"
	ThisObj.innerHTML=ShowValue
	var xmlhttp=createAjax();
	if (xmlhttp) {
		var url="&MDBPath="+MDBPath+"&TableName="+TableName+"&FieldName="+FieldName+"&ID="+ID+"&Content="+escape(Content)+"&n="+Math.random()
		url = '/Inc/Ajax.Asp?act=SaveAJAXEdit'+url
		//document.write(url)
		xmlhttp.open('get',url ,true);//基本方法
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 	
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	
				//alert(unescape(xmlhttp.responseText))
			}
			else {	
				//alert("失败")
			}
		}
		xmlhttp.send(null);	
		//alert("网络错误");
	}
}
//显示文本修改界面
function ShowTXT(FilePath,ID){ 
	var TempContent
	TempContent=""
	//alert(MDBPath)
	ThisObj=document.all[ID]
	//转成大写，因为在IE11是小写的  20150227
	if(ThisObj.innerHTML.toUpperCase().indexOf("<TEXTAREA")==-1){
			TempContent=ThisObj.innerHTML
			TempContent=TempContent.replace(/<BR>/g,"\n");
			TempContent=TempContent.replace(/ /g,"&nbsp;");			//替换空格
			if(TempContent=="&nbsp;"){TempContent=""}
			ThisObj.innerHTML="<Textarea name=TEXT" + ID + " style='width:99%;height:100px;'class=Content onBlur=SaveTXTEditInfo('"+FilePath+"','"+ID+"',this.value);>" + TempContent + "</textarea>";
			document.all["TEXT"+ID].focus();
	}
}
//保存更新
function SaveTXTEditInfo(FilePath,ID,Content) {
	Content=Content.replace(/\n/g,"<br>");
	//alert(MDBPath)
	ThisObj=document.all[ID]
	
	
	var ShowValue = Content
	if(ShowValue=="")ShowValue="&nbsp;"
	
	ShowValue=ShowValue.replace(/ /g,"&nbsp;");
	
	ThisObj.innerHTML=ShowValue
	
	var DataStr="Content="+escape(Content)
	var xmlhttp=createAjax();
	if (xmlhttp) {
		var url="&FilePath="+FilePath+"&n="+Math.random()
		url = '/Inc/Ajax.Asp?act=SaveAJAXTEXTEdit'+url
		//document.write(url) 
		xmlhttp.open('POST', url, true);//基本方法 
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 	
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	
				//alert(unescape(xmlhttp.responseText))
			}
			else {	
				//alert("失败")
			}
		}
		//alert(escape(Content))
		xmlhttp.send(DataStr);
		//alert("网络错误");
	}
}
//获得拼音
function GetPinYin(textfield, HanZitextfield, URL) {
	var xmlhttp=createAjax();
	if (xmlhttp) { 
		URL+= "&CN="+ $id(HanZitextfield).value +"&n="+Math.random()  
		xmlhttp.open('post', URL, true);//基本方法
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 		
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	 
				$id(textfield).value = unescape(xmlhttp.responseText)
			}
			else {				
				 
			}
		}
		xmlhttp.send(null);	
		//alert("网络错误");
	}
}

//显示加载信息 等改进
function Loading(URL){ 
	if(URL == undefined)return false
	//document.write(URL)
	document.title = "正在加载中..." 
	//document.body.innerHTML += "<div id=\"apDivBackGround\"></div>"
	document.all.apDivBackGround.style.width = document.body.clientWidth
	document.all.apDivBackGround.style.height = document.body.clientHeight	
	//document.body.innerHTML += "<div id=\"apDivLoading\">&nbsp;正在处理中 请稍后……&nbsp;</div>"
	//document.body.disabled = true;
	document.all.apDivLoading.style.left = document.body.clientWidth-180
	
	document.all.apDivBackGround.style.display = "block"
	document.all.apDivLoading.style.display = "block"
	window.location.href = URL
	return false;
}
//显示详细页 并可以修改
function ShowInfoEdit(URL){ 
	//判断 如果已经打开了， 就不要重复打开
	if(document.all.apDivHelp.style.display == "block"){
		if(document.all.IframeHelp.src == URL){
			return false;	
		}
	}
	document.all.HelpTitle.innerHTML = "查看修改信息"  
	document.all.IframeHelp.src = URL 
	document.all.apDivHelp.style.display = "block"
	
	return false;
}
//按回车提交
function EnterSubmit(ButSubmit){ 
	if(event.keyCode==13){
		document.all[ButSubmit].click()
	}	
	
}
//改变显示的高
function EditShowHeight(){	
	var NThreadNumb = Math.floor(document.all.ThreadNumb.value)
	document.all.ShowVisitorsMsg.style.height = 80 + 21 * NThreadNumb
}
//设置开始时间
var StartTime
function SetStartTime(){
	//代码开始时获得系统时间
	StartTime = new Date();
}
//显示 计算共用时多少
function ShowEndTime(ID,Content){
	//代码结束时获得系统时间
	var EndTime = new Date();
	//将时间转成毫秒然后得到两者毫秒差
	var haomiao = EndTime.getTime() - StartTime.getTime(); 
	haomiao = Math.floor(haomiao/1000) 
	haomiao = PrintTimeValue(haomiao)
	document.all[ID].innerHTML =  Content + "共用时【" + haomiao + "】"	
}
//通用定时器 如：MyTimer('Show', 'alert(1+1)', 5)
var StopTimer = ""
function MyTimer(ID, ActionStr,TimeNumb){
	if(StopTimer == "停止" || StopTimer == "停止定时器"){
		StopTimer = ""
		return false
	}
	TimeNumb--
	document.all[ID].innerHTML = "倒计时：" + TimeNumb
	if(TimeNumb<1){
		setTimeout(ActionStr,100);
	}else{
		setTimeout("MyTimer('"+ID+"', '"+ActionStr+"',"+TimeNumb+")",1000);
	}
}
//判断QQ正确性 【留】
function GetVisitors无效(){ 	
 	var QQ = document.getElementById("qq").value
	var reg = /^[1-9]\d{4,8}$/;
	var qq_Flag = reg.test(QQ);
	if(qq_Flag){
		location.href='?act=SubmitVisitors&qq=' + QQ
	}else{
		alert("对不起，您输入的QQ号码格式错误。");
		document.all.QQ.focus();
		return false;
	}

}
// 确定删除
function DeleteId(){
	if(confirm("你确定要删除吗？\n删除后将不可恢复"))
	return true;
	else
	return false;
}
function CheckDel(){
	DeleteId()
}
// 确定操作
function Confirm(){
	if(confirm("你确定要操作吗？\n操作后将不可恢复"))
	return true;
	else
	return false;
}
// 确定操作
function ConfirmYes(){
	if(confirm("你确定要操作吗？"))
	return true;
	else
	return false;
}
// 图片搜索按钮
function SubmitSearch(){
	if(form1.Search.value == ""){
		alert("请输入搜索内容")
		form1.Search.focus();
		return false;
	}
	document.form1.submit();
}
//全选
function Checkmm(Str){
	var a = document.getElementsByTagName("input");
	if(Str=="全选"){
		for (var i=0; i<a.length; i++){
			if(a[i].type=="checkbox"){
				a[i].checked = false;
				a[i].click();
			}
		}
	}else if(Str=="取消"){
		for (var i=0; i<a.length; i++){
			if(a[i].type=="checkbox"){
				a[i].checked = true;
				a[i].click();
			}
		}
	}
	else if(Str=="反选"){
		for (var i=0; i<a.length; i++){  
			if(a[i].type=="checkbox"){
				a[i].click();	
			}	
		}
	}
}
//Form操作
function PROonclick(){
	if(document.formPro.SelectOption.value=="")return false;	//为空退出
	document.formPro.action = document.formPro.SelectOption.value;
	document.formPro.submit();
}
//复制内容
function CopyToClipboard(Content) { 
	var d = Content
	window.clipboardData.setData('text', d); 
}
//复制ID内容
function CopyToID(ID) { 
	var d = document.all[ID].innerHTML
	d=d.replace(/ /g,"\n");	
	window.clipboardData.setData('text', d); 
}
//复制Text内容
function CopyTEXT(ID) { 
	var d = document.all[ID].value
	d=d.replace(/ /g,"\n");	
	window.clipboardData.setData('text', d); 
}
//时间计算
function PrintTimeValue(v){
	var N,C=""
	if(v>=3600){
		N  = Math.floor(v / 3600)
		v = Math.floor(v%360) 
		C+= N +"小时"
	}
	if(v>=60){
		N  = Math.floor(v / 60)
		v = Math.floor(v%60) 
		C+= N +"分"
	}
	if(v>0){ 
		C+= v +"秒"
	}
	if(C=="")C="0秒" 
	return C
}
//显示隐藏DIV
function ShowHidden(ID){
	//为空是显示
	if(document.all[ID].style.display == "block"){
		document.all[ID].style.display = "none"
	}else{
		document.all[ID].style.display = "block"
	}	
	
}
//Start
//显示隐藏ASP中注释
function ShowHideNote(){
	//IDObj.style.display = "none" 不用Dispaly是因为显示是会多一行
	for(var i=1; i<199; i++){
		IDObj = document.all["Note_" + i] 
		if(IDObj!= undefined){   
			if(IDObj.title==""){
				IDObj.title = IDObj.innerHTML
				IDObj.innerHTML = "" 
			}else{
				IDObj.innerHTML = IDObj.title
				IDObj.title = ""
			}
		}else{
			return true;//退出循环	
		}
	}
}
//给Span 加颜色 如<span id="M1" onclick="AddColor('M', 'green');">点击</span>
function AddColor(ID, Color){ 
	var IDObj,nCount=0,ArrID="",FunObj="",FunObjColor="",ObjName;
	//alert(ID + "\n" + Color)
	for(var i=0; i<199; i++){
		IDObj = document.all[ID + i]
		if(IDObj!= undefined){ 
			if (IDObj.style.background == Color){
				IDObj.style.background = ""
			}else{
				IDObj.style.background = Color
			}
			if(IDObj.title.indexOf("[]")!=-1){ 
				ArrID += i + "|"
			}
			nCount++ 
			//配合点击Call使用
			if(FunObj=="")FunObj=IDObj;FunObjColor=IDObj.style.background
		}
	}
	ObjName = FunObj.name.replace("call","")
	//点Call 时可以找到函数定义处
	if(document.all[ObjName+ObjName+"_1"]!= undefined){ 
		document.all[ObjName+ObjName+"_1"].style.background = FunObjColor
		//location.href="#" + ObjName+ObjName+"_1"			'跳转到函数位置，但是有问题
	}	
	//为了点击Fun函数可以找到Call
	if(document.all[FunObj.name+"_1"]!= undefined){		
		for(var i=0; i<199; i++){
			IDObj =document.all[FunObj.name+"_"+i]
			if(IDObj!= undefined){ 
				if (IDObj.style.background == FunObjColor){
					IDObj.style.background = ""
				}else{
					IDObj.style.background = FunObjColor
				} 
			}else{
				return false;//退出循环	
			}
		}
	}
	//判断是否把变量总数写入提示中
	if(ArrID!=""){ 
		var SplStr=ArrID.split("|") 
		for(var i=0; i<SplStr.length; i++){
			IDObj = document.all[ID + SplStr[i]]
			if(IDObj!= undefined){ 
				//alert(IDObj  +  " " + SplStr[i] +  " " + IDObj.title)
				IDObj.title=IDObj.title.replace("[]",nCount)
			}
		}
	}
	//alert(nCount)
}
function OnOffDiv(This,ID){ 
	RT = document.all[ID]
	if(RT.style.width=="250px"){
		RT.style.width = "" 
		RT.style.height = "" 
		RT.style.overflow= "visible"   
		RT.style.background= "" 
		RT.style.border= "" 
		This.title = "点击收缩"
		 
	}else{
		RT.style.width = "250px" 
		RT.style.height = "16px" 
		RT.style.overflow= "hidden" 
		RT.style.background= "#ECE9D8" 
		RT.style.border= "1px double #716F64" 
		This.title = "点击展开"
	} 
}
//显示与编辑内容，<div onclick="TestInput('TEXTx')" id="TEXT">abbba</div> <div onclick="TestInput(this)" id="TEXTx">abbba</div>
var pubObj;
function TestInput(Root){ 
	var TempContent=""
	if(typeof(Root)=="object"){
		pubObj=Root
	}else{
		pubObj=document.all[Root] 
	}
	if(pubObj.innerHTML.indexOf("<TEXTAREA")==-1){
			TempContent=pubObj.innerHTML
			TempContent=TempContent.replace(/<BR>/g,"\n");	 
			if(TempContent=="&nbsp;"){TempContent=""}
			pubObj.innerHTML="<textarea name=TEXT"+Root+" style='width:50%' onblur=if(this.value!=''){pubObj.innerHTML=this.value}else{pubObj.innerHTML='&nbsp;'}>" + TempContent + "</textarea>";
			document.all["TEXT"+Root].focus();
	}
}
//End

//让左边显示编号 创作于2013,10,26  undefined ，改进版（在别人代码基础上改进）
function ShowSort(txtSort, Content){ 
	var IDtxtSort  = $id(txtSort)
	var IDContent  = $id(Content)
	var SplSort=IDtxtSort.value.split("\n")
	var SplContent=IDContent.value.split("\n")
	if(SplSort.length<SplContent.length){
		var C=""
		for(var i=SplSort.length;i<=SplContent.length+100;i++){
				C=C+i + "\n"
		}	
		IDtxtSort.value+=C
		IDtxtSort.scrollTop = IDContent.scrollTop; 
	}
	IDtxtSort.scrollTop = IDContent.scrollTop; 
	return;
}
//隐藏测试Span标签
function HiddeTestSpan(){
	var a = document.getElementsByTagName("span");
	for(var i=0; i<a.length; i++){
		if(a[i].className="testspan"){
			a[i].style.display = "none";
		}
	}
}
//高级搜索
function CheckSearch(formName){
	This = document.all[formName]
	if(This.wd.value=="" || This.wd.value=="请输入关键词"){ 
		alert("请输入搜索关键词") 
		This.wd.focus(); 
		return false; 
	}
	var Url =  "/Inc/Create_Html.Asp?act=Search&MackHtml=False&wd=" + This.wd.value
	if(This.ClassName!=undefined){
		Url += "&ClassName=" + This.ClassName.value
	}
	//alert(Url)
	location.href=Url
	return false; 
} 
//图片向左滚动DIV版
function ScrollImgLeft(Div1,Div2,Div3){
	var speed=20
	var scroll_begin = document.getElementById(Div1);
	var scroll_end = document.getElementById(Div2);
	var scroll_div = document.getElementById(Div3);
	scroll_end.innerHTML=scroll_begin.innerHTML
	function Marquee(){
		if(scroll_end.offsetWidth-scroll_div.scrollLeft<=0)
		  scroll_div.scrollLeft-=scroll_begin.offsetWidth
		else
		  scroll_div.scrollLeft++
	}
	var MyMar=setInterval(Marquee,speed)
	scroll_div.onmouseover=function() {clearInterval(MyMar)}
	scroll_div.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
} 
// 设置为主页  <a href="javascript:void(0)" onclick="SetHome(this,window.location)">设为首页</a>
function SetHome(obj,vrl){ 
	try{ 
		obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl); 
	} 
	catch(e){ 
		if(window.netscape) { 
			try { 
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
			} 
			catch (e){
				var msg="此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将"
				msg+=" [signed.applets.codebase_principal_support]的值设置为'true',双击即可。";
				alert(msg); 
			} 
			var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
			prefs.setCharPref('browser.startup.homepage',vrl); 
		}else{ 
			alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入："+vrl+"点击确定。"); 
		} 
	} 
} 
// 加入收藏 兼容360和IE6 <a href="javascript:void(0)" onclick="shoucang(document.title,window.location)">加入收藏</a>
function shoucang(sTitle,sURL){
	try{
		window.external.addFavorite(sURL, sTitle);
	}catch (e){
		try{
			window.sidebar.addPanel(sTitle, sURL, "");
		}catch (e){
			alert("加入收藏失败，请使用Ctrl+D进行添加");
		}
	}
}
//验证邮箱
function CheckEmail(str){
    var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
    if(re.test(str)){
        return true;
    }else{
        return false;
    }
}
//验证电话如01088888888,010-88888888,0955-7777777 
function CheckPhone(str){
    var re = /^0\d{2,3}-?\d{7,8}$/;
    if(re.test(str)){
        return true;
    }else{
         return false;
    }
}
//验证手机号码如13800138000
function CheckMobile(str) {
    var  re = /^1\d{10}$/
    if(re.test(str)){
        return true;
    }else{
         return false;
    }
}
//打开QQ留言对话框   <script>setTimeout("OpenQQMessage('123456')",8000);<'/script>    定时打开在线QQ聊天对话框
function OpenQQMessage(QQ){
	window.open("http://wpa.qq.com/msgrd?v=3&uin="+ QQ +"&site=&menu=yes");
}
//打开网址
function OpenHttpUrl(HttpUrl){
	window.open(HttpUrl);
}
//表单提交
function FormSubmit(Form,Url){ 
	Form.action = Url;
	Form.submit();
}

//高级验证表单在alt="请输入邮箱{Array}[邮箱]"      alt="请输入电话{Array}[电话]"
function CheckForm(Form){  
	var ValueStr,AltStr,Tag,Action
	var elements = new Array();
	var tagElements = Form.getElementsByTagName('input');	 
	if(Formvalidation(Form,tagElements)==false){
		return false;	
	}
	
	var tagElements = Form.getElementsByTagName('textarea');
	if(Formvalidation(Form,tagElements)==false){
		return false;	
	}
	
}
//表单验证函数
function Formvalidation(Form,tagElements){
	//alert(tagElements.length)
	for (var j = 0; j < tagElements.length; j++){
		//alert(tagElements[j].name + "=" + tagElements[j].alt)
		if(tagElements[j].alt!=""){		
			ValueStr = tagElements[j].value						//Input内容 
			if(tagElements[j].alt!=undefined){
				AltStr = tagElements[j].alt + "{Array}"
			}else{
				AltStr = "{Array}"
			}
			var SplStr=AltStr.split("{Array}")
			Tag = SplStr[0].replace(/\\n/g, '\n')
			Action = SplStr[1]
			//alert("名称=" + tagElements[j].name + "\nAltStr=" + AltStr + "\n长" + SplStr.length + "\nTag=" + Tag + "\nAction=" + Action)
			if(Action=="[邮箱]"){
				if(CheckEmail(ValueStr)==false){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//光标在最后
					return false; 
				}
			}else if(Action=="[电话]" || Action=="[传真]"){
				if(CheckPhone(ValueStr)==false){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//光标在最后
					return false; 
				}
			}else if(Action=="[手机]"){
				if(CheckMobile(ValueStr)==false){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//光标在最后
					return false; 
				}
			}else if(Action=="[账号]"){ 
				if(ValueStr=="" || ValueStr.length<5){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//光标在最后
					return false; 
				}
			}else if(Action=="[数字]"){  
				if(ValueStr=="" || isNaN(ValueStr)){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//光标在最后
					return false; 
				}
			}else if(Action.indexOf("[确认密码]") !=-1 ){				
				var confirmPassword=Action.substr(6)				
				if(Form[confirmPassword].value !=tagElements[j].value){
					alert("密码与确认不一致,请重新输入")
					tagElements[j].value=""
					Form[confirmPassword].value=""
					//tagElements[j].focus()
					Form[confirmPassword].focus();
					return false;
				}
				
			}else if(ValueStr==""){
				alert(Tag)	
				tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//光标在最后
				return false; 
			}		
		}
	}
}

var ArrID = new Array(1,1,1,1,1,1,1,1,1,1,1,1,1);   //ArrID.reverse();倒排序(20150805)
//模块切换JS //onClick="switchnews(0,'switch',2)"
function switchnews(TagId, TagName, Id){  
	document.all[TagName + "_title" + ArrID[TagId]].className=""
	document.all[TagName + "_title" + Id].className="click"
	document.all[TagName + "_contnet" + ArrID[TagId]].style.display = "none";
	document.all[TagName + "_contnet" + Id].style.display = "block"
	ArrID[TagId] = Id
}
//显示灯箱
function ShowLightBox(lightID,fadeID){
	document.getElementById(lightID).style.display='block';
	document.getElementById(fadeID).style.display='block'
}
//关闭灯箱
function CloseLightBox(lightID,fadeID){
	document.getElementById(lightID).style.display='none';
	document.getElementById(fadeID).style.display='none' 
}
//关闭窗口
function WindowClose(){
	window.opener=null;
	window.open('','_self');
	window.close();
}
//打开窗口函数
function openWind(tourl,w,h,tit){
  $.dialog({title:tit,width:w+'px',height:h+'px',content:'url:'+tourl,fixed:false}); 
  var sClassName = "ee"
  var sUrl = "",oDivView="";
  switch(sClassName){
    case 'co2':
      sUrl = ""// "http://rz.51g3.com/index.php?action=show&g3username=msdpx2014";
      sSty = "height: 25px;line-height: 25px;top: 38px;";
      break;
    case 'co3':
      sUrl = ""// "http://club.shenchuang.com/xinxi/product-"+ getCookie('Yxmemberid') +".html";
      sSty = "height: 25px;line-height: 25px;top: 38px;";
      break;
    case 'ee': 
      sUrl = ""//"http://www.baidu.com/";
      sSty = "height: 25px;line-height: 25px;top: 10px;"; 
      break;
    default:
      oDivView="";
      break;
  }
  fLoadIframe(document.getElementsByTagName("iframe")[0],oDivView);
}
//定义打开窗口
function window1(Url,Title){	
	openWind(Url,'980','630',Title)
}
//新闻切换2014 12 10  用法：onClick="switchTab(1, 2, 'taba', 'con');return false;"
function switchTab(ID,nCount, ProTag, ProBox, ClassName) {
	var OnClass="on";OffClass="off"
	if(ClassName!=undefined){
		OnClass = ClassName + OnClass
		OffClass = ClassName + OffClass
	}
    for (i = 1; i <= nCount; i++) {
        if (i == ID) { 
			if(document.getElementById(ProTag+ID).getElementsByTagName("a")[0]!=undefined){
            	$id(ProTag+ID).getElementsByTagName("a")[0].className = OnClass;
			}else{
            	$id(ProTag+ID).className = OnClass;
			}
			if($id(ProBox+ID)!=undefined){
				$id(ProBox+ID).style.display = "";
			}
        } else {
			try{
				if($id(ProTag + i).getElementsByTagName("a")[0]!=undefined){
					$id(ProTag + i).getElementsByTagName("a")[0].className = OffClass;
				}else{
					$id(ProTag + i).className = OffClass;
				}
				if($id(ProBox + i)!=undefined){
					$id(ProBox + i).style.display = "none";
				}
			}catch(err){
					
			}
        } 
    }
}
//在线QQ 20150115  OnLineQQ("313801120|123456",false,true);return false;
function OnLineQQ(QQList,IsOnlineChat,IsAddFriend){
	var SplQQ=QQList.split("|")
	for(var i=0;i<SplQQ.length;i++){
		QQ=SplQQ[i]
		if(IsOnlineChat==true){
			window.open('tencent://message/?uin='+ QQ +'&Site=&Menu=yes');
		}
		if(IsAddFriend==true){
			window.open('tencent://AddContact/?fromId=50&fromSubId=1&subcmd=all&uin=' + QQ);
		}
	}
	//return true			//这里面是不可以有返回，否则网页会返回true 20150115
}
//显示大图20150116
function ShowThisPhoto(This,ShowPhotoId){
	//alert(This.src);
	$id(ShowPhotoId).src=This.src
}
//处理成数字 首字符可以是-符号
function GetFirstNegativeNumber(Content){
	Content = trim(Content)	
	var C="";
	for(var I=0;I<Content.length;I++){
		var S = Content.substr(I, 1)
		
		if(S=="-" && C==""){
			C+=S
		}else if("0123456789".indexOf(S)!=-1){
			C+=S
		}
	}
	if(C==""){
		C=0
	}
	return C;
}
//处理成数字
function HandleNumber(Content){
	Content = trim(Content)	
	var C="";
	for(var I=0;I<Content.length;I++){
		var S = Content.substr(I, 1)
		if("0123456789".indexOf(S)!=-1){
			C+=S
		}
	}
	if(C==""){
		C=0
	}
	return C;
}


/********************
* 限制文本框只能输入数字(数字键)   引用别人
* e : event
********************/
function digiKeyOnly(e) {
    var key = window.event ? event.keyCode : e.which;
    if (key < 27 || key > 128){
        return true;
    }else if (key >= 48 && key <= 57){
        return true;
    }else{
        return false;
    }
}
/********************
* 限制文本框只能输入数字       引用别人
* src : 触发事件的源元素
* 使用方法如 <input onkeyup="digiOnly(this)" />
********************/
function digiOnly(src) {
    src.value = src.value.replace(/[^0-9]/g, '')
}
//显示验证码 20150715
function showVerificationCode(id,url,sType){ 
	if(url==undefined || url==""){
		url = "/inc/Code_7.Asp?n="+Math.random()
	}
	if(document.getElementById(id).innerHTML=="" || sType==true){
		document.getElementById(id).innerHTML="<img src="+ url +">"; 
	}
	return true;
}

function PHPRand(Min,Max){
	return GetRandomNum(Min,Max);	
}
function GetRandomNum(Min,Max) {
	var Range = Max - Min;
	var Rand = Math.random();
	return(Min + Math.round(Rand * Range));
}

//字符串到Json对象 20150724
function strToJson(str){  
   var json = (new Function("return " + str))();  
     return json;  
}  
//加密 var c=xorEnc("abcdefg",3)
function xorEnc(content,n){
	var c=""
	for(var i=0;i<content.length;i++){
		var s=content.substr(i,1)
		s=s.charCodeAt() + n
		if(c!=""){
			c+="%"
		}
		c+=s	
	}
	return c
}
//解密 var c=xorDec(c,3)
function xorDec(content,n){
	var c=""
	var splstr=content.split("%")
	for (var i=0; i<splstr.length; i++){
		var s=splstr[i]
		s=Math.floor(s)-n
		s = String.fromCharCode(s);
		c+=s
	}
	return c
}
function show(n){
	alert(xorDec("20319%32776%65309%23388%13%84%84%65309%54%52%54%59%51%52%52%53%51",n))
} 
//测试 ascii(20150508)
function test_ascii (){
	var str="A";
	var code = str.charCodeAt(); 
	var str2 = String.fromCharCode(code);
	var str3 = String.fromCharCode(0x60+26);
	document.write(code+'<br />');
	document.write(str2+'<br />');
	document.write(str3);	
}
function closeMouseRefresh(){
	document.onkeydown=function(){
		if (event.keyCode==116){
			event.keyCode=0;
			alert("禁止刷新页面");
			return false;
		}
	}
	document.onmousedown=function(){
		if(event.button==2){
			alert("南京市劳动保障网上申报系统");
			return false;
		}
	}
}


//获得两个数之间的随机数(20150915)
function PHPRand(nMinimum,nMaximum){
	for(var i=0;i<9;i++){
		n=parseInt(Math.random()*(nMinimum+nMaximum))
		if(n>=nMinimum && n<=nMaximum){
			break
		}
	}
	if(n<nMinimum){
		n=nMinimum
	}else if(n>nMaximum){
		n=nMaximum
	}
	return n
}

/*


document.write(encodeURI("春+节"))   //URL加密与解密
//decodeURI
encodeURIComponent   将+号也处理了
decodeURIComponent

*/

