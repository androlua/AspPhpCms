


//<script type="text/javascript" src="/Jquery/Common.js"></script

/*  �������� 20150124

���Ӵ���JS����
try{
	document.all.aasd.innerHTML="sdf"
	alert("11")
}catch(exception){
	alert("sdf")
}

var agent = navigator.userAgent.toLowerCase();   //����������Ϣ20152017
*/


//�ж�ָ��Checkֵ�Ƿ���ѡ�� 20150120 existsCheck('selectPid')
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
//��ʾ��ɫ
function ShowColor(This,Id){
	//��ʱ������
	return false;
	if(This.checked==true){
		$id("TR"+Id).style.backgroundColor="#FF0000";
	}
}
 

//���ñ�����ɫ
function SetBgColor(Obj,Color){
	Obj.style.backgroundColor = Color
}

//�쳣���������� �ٶ�֪���￴����20140703
function message(){
	try{
		alert("aa")
	//�쳣����
	}catch(err){
		txt="��ҳ�д��ڴ���\n\n"
		txt+="�����ȷ���������鿴��ҳ��\n"
		txt+="�����ȡ����������ҳ��\n\n"
		//����������Ǵ���ʲô��˼����ʲô���ã�3Q
		if(!confirm(txt)){
			document.location.href="/index.html"
		}
	}
}
//��ȡԪ��id
function $id(str){
	return document.getElementById(str);
}
// ��ȡԪ��name
function $name(str){
	return document.getElementsByName(str);
}
//�ָ�
function Split(Content,SplLabel){
	return Content.split(SplLabel)
}
//��ȡ���
function Left(mainStr,lngLen) { 
if (lngLen>0) {return mainStr.substring(0,lngLen)} 
else{return null} 
}  
//��ȡ�ұ�
function Right(mainStr,lngLen) { 
	if (mainStr.length-lngLen>=0 && mainStr.length>=0 && mainStr.length-lngLen<=mainStr.length) { 
		return mainStr.substring(mainStr.length-lngLen,mainStr.length)
	}else{
		return null
	} 
} 
//Mid��ʽ��ȡ�ַ�
function Mid(mainStr,starnum,endnum){ 
	if(mainStr.length>=0){ 
		return mainStr.substr(starnum,endnum) 
	}else{
		return null
	}
}
//ɾ���������˵Ŀո�
function trim(str){
    return str.replace(/(^\s*)|(\s*$)/g, "")
}
//ɾ����ߵĿո�
function ltrim(str){
    return str.replace(/(^\s*)/g,"");
}
//ɾ���ұߵĿո�
function rtrim(str){
    return str.replace(/(\s*$)/g,"");
}
//JS����cookies����! 
//дcookies   Days=3000  Ϊ����   86400=һ��
function setCookie(name,value,Days) { 
	if(Days==undefined){
		Days=24*60*60*100*30			//Ϊ30��
	}
	var exp = new Date(); 
	exp.setTime(exp.getTime() + Days); 
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
} 
//��ȡcookies 
function getCookie(name) { 
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)"); 
	if(arr=document.cookie.match(reg)) return unescape(arr[2]); 
	else return null; 
} 
//ɾ��cookies   javascript:alert(document.cookie ="postnum=;expires=" + (new Date(0)).toGMTString())
function delCookie(name) { 
	var exp = new Date(); 
	exp.setTime(exp.getTime() - 1); 
	var cval=getCookie(name); 
	if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString(); 
}
//������ȥ�ı䱳��������ɫ ���Ѷ��Դ�
function onMouseOverOutColor(This,N,BgColor){
	//alert(N + "\n" + typeof(N))
	var J=0;
	var a = document.getElementsByTagName("input"); 
	for (var i=0; i<a.length; i++){  
		if(a[i].type=="checkbox"){ 
			if(J==N){
				if(a[i].checked == false){
					This.style.backgroundColor = BgColor
					//alert("����")
				}
				return false;
			}
			J++
		}	
	} 
}
//����ȥ�ı䱳����������ɫ  onMouseMove="onColor(this,'#FDFAC6','')"
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
//�뿪�ı䱳����������ɫ  onMouseOut="offColor(this,'','')"
function offColor(root,bcolor,wcolor){
	root.style.color=wcolor
	if(bcolor.indexOf(".")==-1){
		root.style.backgroundColor=bcolor
	}else{
		root.style.backgroundImage="url("+bcolor+")";
	}
} 
//���������ɫ  �磺onclick="OnClickBgColorTab(document.all.ID<%=Rs(0)%>,this,'#FFFF99','#FFFFFF')"
function OnClickBgColorTab(ID,This,onColor,OutColor){
	if(This.checked == true){
		ID.style.backgroundColor = onColor
	}else{
		ID.style.backgroundColor = OutColor	
	}
}
//document.oncontextmenu=new Function("event.returnValue=false;");     //
//document.onselectstart=new Function("event.returnValue=false;");
//AjAX XMLHTTP����ʵ��
function createAjax() { 
	var _xmlhttp;
	try {
		_xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");	//IE�Ĵ�����ʽ
	}catch (e) {
		try {
			_xmlhttp=new XMLHttpRequest();	//FF��������Ĵ�����ʽ
		}catch (e) {
			_xmlhttp=false;		//�������ʧ�ܣ�������false
		}
	}
	return _xmlhttp;	//����xmlhttp����ʵ��
}
//Ajax("/Ajax.Asp?act=ShowArticleNumb","ArticleViewNumb")
//Ajax
function Ajax(URL,ShowID) {  
	var xmlhttp=createAjax();
	if (xmlhttp) {
		URL+= "&n="+Math.random() 
		xmlhttp.open('post', URL, true);//��������
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
					alert("��ʾ"+str+URL)
				}
			}
			else {
				if(ShowID!="undefined" && ShowID!=""){
					document.getElementById(ShowID).innerHTML = "<img src=/Images/lodin.gif>���ڼ���..."
				}
			}
		}
		xmlhttp.send(null);	
		//alert("�������");
	}
}
//Ajax2 ���ɹ�  �÷�   Ajax2("1.asp","show","count=mtest&passwd=mtest&name=test")
function Ajax2(URL,ShowID,DataStr) {  
	var xmlhttp=createAjax();
	if (xmlhttp) {
		URL+= "&n="+Math.random() 
		xmlhttp.open('post', URL, true);//��������
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 		
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	 
				document.getElementById(ShowID).innerHTML =  unescape(xmlhttp.responseText);  
			}else {				
				document.getElementById(ShowID).innerHTML = "<img src=/Images/lodin.gif>���ڴ�����..."
			}
		}
		xmlhttp.send(DataStr);	
		//alert("�������");
	}
}
//Ajax�����޷���ֵ
function AjaxNoReturn(URL) {  
	var xmlhttp=createAjax();
	if (xmlhttp) {
		URL+= "&n="+Math.random() 
		xmlhttp.open('post', URL, true);//��������
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 		
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	 
				
			}else {				
				
			}
		}
		xmlhttp.send(null);	
		//alert("�������");
	}
}
/****************��վ����******************/
//��ʾҪ��������<span id="AddTime<%=Rs("Id")%>" onClick="ShowInput('AddTime<%=Rs("Id")%>','AddTime',<%=Rs("ID")%>);"><%=AddTime%></span>
//<span id="AddTime1" onClick="ShowInput('AddTime1','AddTime',1);">111</span>
//S = "<span id=""Title"& Rs("Id") &""" onClick=""ShowInput('../../��վ����/���ݿ�/ZNRobot.mdb','ZNRobot','Title','"& Rs("Id") &"');"">"& Rs("Title") &"</span>"
/*�ڶ���
title="<span onClick=""ShowInput('/../��վ����/���ݿ�/CaiConfig.mdb','CaiConfig','"& fieldName &"','"& Rs("Id") &"');"">"& fieldName &"</span>"
s = "<span id="""& fieldName & Rs("Id") &""" onClick=""ShowInput('/../��վ����/���ݿ�/CaiConfig.mdb','CaiConfig','"& fieldName &"','"& Rs("Id") &"');"">"& Rs(fieldName) &"</span>"
call echo(title,s)
*/
function ShowInput(MDBPath,TableName,FieldName,ID){ 
	var TempContent
	TempContent=""
	//alert(MDBPath)
	ThisObj=document.all[FieldName+ID]
	//ת�ɴ�д����Ϊ��IE11��Сд��  20150227
	if(ThisObj.innerHTML.toUpperCase().indexOf("<TEXTAREA")==-1){
			TempContent=ThisObj.innerHTML
			TempContent=TempContent.replace(/<BR>/g,"\n");	 
			if(TempContent=="&nbsp;"){TempContent=""}
			ThisObj.innerHTML="<Textarea name=TEXT" + ID + " style='width:99%;height:100px;'class=Content onBlur=SaveEditInfo('"+MDBPath+"','"+TableName+"','"+FieldName+"',"+ID+",this.value);>" + TempContent + "</textarea>";
			document.all["TEXT"+ID].focus();
	}
}
//��ʾ�����˵�
function ShowSelect(MDBPath,TableName,FieldName,ID,SplContent,SplType){ 
	var TempContent
	TempContent=""
	//alert(MDBPath)
	ThisObj=document.all[FieldName+ID] 
	//ת�ɴ�д����Ϊ��IE11��Сд��  20150227
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
//�������
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
		xmlhttp.open('get',url ,true);//��������
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 	
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	
				//alert(unescape(xmlhttp.responseText))
			}
			else {	
				//alert("ʧ��")
			}
		}
		xmlhttp.send(null);	
		//alert("�������");
	}
}
//��ʾ�ı��޸Ľ���
function ShowTXT(FilePath,ID){ 
	var TempContent
	TempContent=""
	//alert(MDBPath)
	ThisObj=document.all[ID]
	//ת�ɴ�д����Ϊ��IE11��Сд��  20150227
	if(ThisObj.innerHTML.toUpperCase().indexOf("<TEXTAREA")==-1){
			TempContent=ThisObj.innerHTML
			TempContent=TempContent.replace(/<BR>/g,"\n");
			TempContent=TempContent.replace(/ /g,"&nbsp;");			//�滻�ո�
			if(TempContent=="&nbsp;"){TempContent=""}
			ThisObj.innerHTML="<Textarea name=TEXT" + ID + " style='width:99%;height:100px;'class=Content onBlur=SaveTXTEditInfo('"+FilePath+"','"+ID+"',this.value);>" + TempContent + "</textarea>";
			document.all["TEXT"+ID].focus();
	}
}
//�������
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
		xmlhttp.open('POST', url, true);//�������� 
		xmlhttp.setRequestHeader("cache-control","no-cache"); 
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 	
		xmlhttp.onreadystatechange=function() {		
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {	
				//alert(unescape(xmlhttp.responseText))
			}
			else {	
				//alert("ʧ��")
			}
		}
		//alert(escape(Content))
		xmlhttp.send(DataStr);
		//alert("�������");
	}
}
//���ƴ��
function GetPinYin(textfield, HanZitextfield, URL) {
	var xmlhttp=createAjax();
	if (xmlhttp) { 
		URL+= "&CN="+ $id(HanZitextfield).value +"&n="+Math.random()  
		xmlhttp.open('post', URL, true);//��������
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
		//alert("�������");
	}
}

//��ʾ������Ϣ �ȸĽ�
function Loading(URL){ 
	if(URL == undefined)return false
	//document.write(URL)
	document.title = "���ڼ�����..." 
	//document.body.innerHTML += "<div id=\"apDivBackGround\"></div>"
	document.all.apDivBackGround.style.width = document.body.clientWidth
	document.all.apDivBackGround.style.height = document.body.clientHeight	
	//document.body.innerHTML += "<div id=\"apDivLoading\">&nbsp;���ڴ����� ���Ժ󡭡�&nbsp;</div>"
	//document.body.disabled = true;
	document.all.apDivLoading.style.left = document.body.clientWidth-180
	
	document.all.apDivBackGround.style.display = "block"
	document.all.apDivLoading.style.display = "block"
	window.location.href = URL
	return false;
}
//��ʾ��ϸҳ �������޸�
function ShowInfoEdit(URL){ 
	//�ж� ����Ѿ����ˣ� �Ͳ�Ҫ�ظ���
	if(document.all.apDivHelp.style.display == "block"){
		if(document.all.IframeHelp.src == URL){
			return false;	
		}
	}
	document.all.HelpTitle.innerHTML = "�鿴�޸���Ϣ"  
	document.all.IframeHelp.src = URL 
	document.all.apDivHelp.style.display = "block"
	
	return false;
}
//���س��ύ
function EnterSubmit(ButSubmit){ 
	if(event.keyCode==13){
		document.all[ButSubmit].click()
	}	
	
}
//�ı���ʾ�ĸ�
function EditShowHeight(){	
	var NThreadNumb = Math.floor(document.all.ThreadNumb.value)
	document.all.ShowVisitorsMsg.style.height = 80 + 21 * NThreadNumb
}
//���ÿ�ʼʱ��
var StartTime
function SetStartTime(){
	//���뿪ʼʱ���ϵͳʱ��
	StartTime = new Date();
}
//��ʾ ���㹲��ʱ����
function ShowEndTime(ID,Content){
	//�������ʱ���ϵͳʱ��
	var EndTime = new Date();
	//��ʱ��ת�ɺ���Ȼ��õ����ߺ����
	var haomiao = EndTime.getTime() - StartTime.getTime(); 
	haomiao = Math.floor(haomiao/1000) 
	haomiao = PrintTimeValue(haomiao)
	document.all[ID].innerHTML =  Content + "����ʱ��" + haomiao + "��"	
}
//ͨ�ö�ʱ�� �磺MyTimer('Show', 'alert(1+1)', 5)
var StopTimer = ""
function MyTimer(ID, ActionStr,TimeNumb){
	if(StopTimer == "ֹͣ" || StopTimer == "ֹͣ��ʱ��"){
		StopTimer = ""
		return false
	}
	TimeNumb--
	document.all[ID].innerHTML = "����ʱ��" + TimeNumb
	if(TimeNumb<1){
		setTimeout(ActionStr,100);
	}else{
		setTimeout("MyTimer('"+ID+"', '"+ActionStr+"',"+TimeNumb+")",1000);
	}
}
//�ж�QQ��ȷ�� ������
function GetVisitors��Ч(){ 	
 	var QQ = document.getElementById("qq").value
	var reg = /^[1-9]\d{4,8}$/;
	var qq_Flag = reg.test(QQ);
	if(qq_Flag){
		location.href='?act=SubmitVisitors&qq=' + QQ
	}else{
		alert("�Բ����������QQ�����ʽ����");
		document.all.QQ.focus();
		return false;
	}

}
// ȷ��ɾ��
function DeleteId(){
	if(confirm("��ȷ��Ҫɾ����\nɾ���󽫲��ɻָ�"))
	return true;
	else
	return false;
}
function CheckDel(){
	DeleteId()
}
// ȷ������
function Confirm(){
	if(confirm("��ȷ��Ҫ������\n�����󽫲��ɻָ�"))
	return true;
	else
	return false;
}
// ȷ������
function ConfirmYes(){
	if(confirm("��ȷ��Ҫ������"))
	return true;
	else
	return false;
}
// ͼƬ������ť
function SubmitSearch(){
	if(form1.Search.value == ""){
		alert("��������������")
		form1.Search.focus();
		return false;
	}
	document.form1.submit();
}
//ȫѡ
function Checkmm(Str){
	var a = document.getElementsByTagName("input");
	if(Str=="ȫѡ"){
		for (var i=0; i<a.length; i++){
			if(a[i].type=="checkbox"){
				a[i].checked = false;
				a[i].click();
			}
		}
	}else if(Str=="ȡ��"){
		for (var i=0; i<a.length; i++){
			if(a[i].type=="checkbox"){
				a[i].checked = true;
				a[i].click();
			}
		}
	}
	else if(Str=="��ѡ"){
		for (var i=0; i<a.length; i++){  
			if(a[i].type=="checkbox"){
				a[i].click();	
			}	
		}
	}
}
//Form����
function PROonclick(){
	if(document.formPro.SelectOption.value=="")return false;	//Ϊ���˳�
	document.formPro.action = document.formPro.SelectOption.value;
	document.formPro.submit();
}
//��������
function CopyToClipboard(Content) { 
	var d = Content
	window.clipboardData.setData('text', d); 
}
//����ID����
function CopyToID(ID) { 
	var d = document.all[ID].innerHTML
	d=d.replace(/ /g,"\n");	
	window.clipboardData.setData('text', d); 
}
//����Text����
function CopyTEXT(ID) { 
	var d = document.all[ID].value
	d=d.replace(/ /g,"\n");	
	window.clipboardData.setData('text', d); 
}
//ʱ�����
function PrintTimeValue(v){
	var N,C=""
	if(v>=3600){
		N  = Math.floor(v / 3600)
		v = Math.floor(v%360) 
		C+= N +"Сʱ"
	}
	if(v>=60){
		N  = Math.floor(v / 60)
		v = Math.floor(v%60) 
		C+= N +"��"
	}
	if(v>0){ 
		C+= v +"��"
	}
	if(C=="")C="0��" 
	return C
}
//��ʾ����DIV
function ShowHidden(ID){
	//Ϊ������ʾ
	if(document.all[ID].style.display == "block"){
		document.all[ID].style.display = "none"
	}else{
		document.all[ID].style.display = "block"
	}	
	
}
//Start
//��ʾ����ASP��ע��
function ShowHideNote(){
	//IDObj.style.display = "none" ����Dispaly����Ϊ��ʾ�ǻ��һ��
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
			return true;//�˳�ѭ��	
		}
	}
}
//��Span ����ɫ ��<span id="M1" onclick="AddColor('M', 'green');">���</span>
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
			//��ϵ��Callʹ��
			if(FunObj=="")FunObj=IDObj;FunObjColor=IDObj.style.background
		}
	}
	ObjName = FunObj.name.replace("call","")
	//��Call ʱ�����ҵ��������崦
	if(document.all[ObjName+ObjName+"_1"]!= undefined){ 
		document.all[ObjName+ObjName+"_1"].style.background = FunObjColor
		//location.href="#" + ObjName+ObjName+"_1"			'��ת������λ�ã�����������
	}	
	//Ϊ�˵��Fun���������ҵ�Call
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
				return false;//�˳�ѭ��	
			}
		}
	}
	//�ж��Ƿ�ѱ�������д����ʾ��
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
		This.title = "�������"
		 
	}else{
		RT.style.width = "250px" 
		RT.style.height = "16px" 
		RT.style.overflow= "hidden" 
		RT.style.background= "#ECE9D8" 
		RT.style.border= "1px double #716F64" 
		This.title = "���չ��"
	} 
}
//��ʾ��༭���ݣ�<div onclick="TestInput('TEXTx')" id="TEXT">abbba</div> <div onclick="TestInput(this)" id="TEXTx">abbba</div>
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

//�������ʾ��� ������2013,10,26  undefined ���Ľ��棨�ڱ��˴�������ϸĽ���
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
//���ز���Span��ǩ
function HiddeTestSpan(){
	var a = document.getElementsByTagName("span");
	for(var i=0; i<a.length; i++){
		if(a[i].className="testspan"){
			a[i].style.display = "none";
		}
	}
}
//�߼�����
function CheckSearch(formName){
	This = document.all[formName]
	if(This.wd.value=="" || This.wd.value=="������ؼ���"){ 
		alert("�����������ؼ���") 
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
//ͼƬ�������DIV��
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
// ����Ϊ��ҳ  <a href="javascript:void(0)" onclick="SetHome(this,window.location)">��Ϊ��ҳ</a>
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
				var msg="�˲�����������ܾ���\n�����������ַ�����롰about:config�����س�\nȻ��"
				msg+=" [signed.applets.codebase_principal_support]��ֵ����Ϊ'true',˫�����ɡ�";
				alert(msg); 
			} 
			var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
			prefs.setCharPref('browser.startup.homepage',vrl); 
		}else{ 
			alert("�����������֧�֣��밴�����沽�������1.����������á�2.���������ҳ��3.���룺"+vrl+"���ȷ����"); 
		} 
	} 
} 
// �����ղ� ����360��IE6 <a href="javascript:void(0)" onclick="shoucang(document.title,window.location)">�����ղ�</a>
function shoucang(sTitle,sURL){
	try{
		window.external.addFavorite(sURL, sTitle);
	}catch (e){
		try{
			window.sidebar.addPanel(sTitle, sURL, "");
		}catch (e){
			alert("�����ղ�ʧ�ܣ���ʹ��Ctrl+D�������");
		}
	}
}
//��֤����
function CheckEmail(str){
    var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
    if(re.test(str)){
        return true;
    }else{
        return false;
    }
}
//��֤�绰��01088888888,010-88888888,0955-7777777 
function CheckPhone(str){
    var re = /^0\d{2,3}-?\d{7,8}$/;
    if(re.test(str)){
        return true;
    }else{
         return false;
    }
}
//��֤�ֻ�������13800138000
function CheckMobile(str) {
    var  re = /^1\d{10}$/
    if(re.test(str)){
        return true;
    }else{
         return false;
    }
}
//��QQ���ԶԻ���   <script>setTimeout("OpenQQMessage('123456')",8000);<'/script>    ��ʱ������QQ����Ի���
function OpenQQMessage(QQ){
	window.open("http://wpa.qq.com/msgrd?v=3&uin="+ QQ +"&site=&menu=yes");
}
//����ַ
function OpenHttpUrl(HttpUrl){
	window.open(HttpUrl);
}
//���ύ
function FormSubmit(Form,Url){ 
	Form.action = Url;
	Form.submit();
}

//�߼���֤����alt="����������{Array}[����]"      alt="������绰{Array}[�绰]"
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
//����֤����
function Formvalidation(Form,tagElements){
	//alert(tagElements.length)
	for (var j = 0; j < tagElements.length; j++){
		//alert(tagElements[j].name + "=" + tagElements[j].alt)
		if(tagElements[j].alt!=""){		
			ValueStr = tagElements[j].value						//Input���� 
			if(tagElements[j].alt!=undefined){
				AltStr = tagElements[j].alt + "{Array}"
			}else{
				AltStr = "{Array}"
			}
			var SplStr=AltStr.split("{Array}")
			Tag = SplStr[0].replace(/\\n/g, '\n')
			Action = SplStr[1]
			//alert("����=" + tagElements[j].name + "\nAltStr=" + AltStr + "\n��" + SplStr.length + "\nTag=" + Tag + "\nAction=" + Action)
			if(Action=="[����]"){
				if(CheckEmail(ValueStr)==false){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//��������
					return false; 
				}
			}else if(Action=="[�绰]" || Action=="[����]"){
				if(CheckPhone(ValueStr)==false){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//��������
					return false; 
				}
			}else if(Action=="[�ֻ�]"){
				if(CheckMobile(ValueStr)==false){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//��������
					return false; 
				}
			}else if(Action=="[�˺�]"){ 
				if(ValueStr=="" || ValueStr.length<5){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//��������
					return false; 
				}
			}else if(Action=="[����]"){  
				if(ValueStr=="" || isNaN(ValueStr)){
					alert(Tag)	
					tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//��������
					return false; 
				}
			}else if(Action.indexOf("[ȷ������]") !=-1 ){				
				var confirmPassword=Action.substr(6)				
				if(Form[confirmPassword].value !=tagElements[j].value){
					alert("������ȷ�ϲ�һ��,����������")
					tagElements[j].value=""
					Form[confirmPassword].value=""
					//tagElements[j].focus()
					Form[confirmPassword].focus();
					return false;
				}
				
			}else if(ValueStr==""){
				alert(Tag)	
				tagElements[j].focus(); 
					tagElements[j].value=tagElements[j].value			//��������
				return false; 
			}		
		}
	}
}

var ArrID = new Array(1,1,1,1,1,1,1,1,1,1,1,1,1);   //ArrID.reverse();������(20150805)
//ģ���л�JS //onClick="switchnews(0,'switch',2)"
function switchnews(TagId, TagName, Id){  
	document.all[TagName + "_title" + ArrID[TagId]].className=""
	document.all[TagName + "_title" + Id].className="click"
	document.all[TagName + "_contnet" + ArrID[TagId]].style.display = "none";
	document.all[TagName + "_contnet" + Id].style.display = "block"
	ArrID[TagId] = Id
}
//��ʾ����
function ShowLightBox(lightID,fadeID){
	document.getElementById(lightID).style.display='block';
	document.getElementById(fadeID).style.display='block'
}
//�رյ���
function CloseLightBox(lightID,fadeID){
	document.getElementById(lightID).style.display='none';
	document.getElementById(fadeID).style.display='none' 
}
//�رմ���
function WindowClose(){
	window.opener=null;
	window.open('','_self');
	window.close();
}
//�򿪴��ں���
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
//����򿪴���
function window1(Url,Title){	
	openWind(Url,'980','630',Title)
}
//�����л�2014 12 10  �÷���onClick="switchTab(1, 2, 'taba', 'con');return false;"
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
//����QQ 20150115  OnLineQQ("313801120|123456",false,true);return false;
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
	//return true			//�������ǲ������з��أ�������ҳ�᷵��true 20150115
}
//��ʾ��ͼ20150116
function ShowThisPhoto(This,ShowPhotoId){
	//alert(This.src);
	$id(ShowPhotoId).src=This.src
}
//��������� ���ַ�������-����
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
//���������
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
* �����ı���ֻ����������(���ּ�)   ���ñ���
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
* �����ı���ֻ����������       ���ñ���
* src : �����¼���ԴԪ��
* ʹ�÷����� <input onkeyup="digiOnly(this)" />
********************/
function digiOnly(src) {
    src.value = src.value.replace(/[^0-9]/g, '')
}
//��ʾ��֤�� 20150715
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

//�ַ�����Json���� 20150724
function strToJson(str){  
   var json = (new Function("return " + str))();  
     return json;  
}  
//���� var c=xorEnc("abcdefg",3)
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
//���� var c=xorDec(c,3)
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
//���� ascii(20150508)
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
			alert("��ֹˢ��ҳ��");
			return false;
		}
	}
	document.onmousedown=function(){
		if(event.button==2){
			alert("�Ͼ����Ͷ����������걨ϵͳ");
			return false;
		}
	}
}


//���������֮��������(20150915)
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


document.write(encodeURI("��+��"))   //URL���������
//decodeURI
encodeURIComponent   ��+��Ҳ������
decodeURIComponent

*/

