 //���õ���jquery�ظ����أ���Ϊjs�����ж���
loadJs("/Jquery/lhgdialog.min.js"); 			//�������
//����Js
function loadJs(name) {    
	document.write('<script src="'+name+'" type="text/javascript"></script>');
} 

var nPageX=0,nPageY=0
$( document ).on( "mousemove", function( event ) {
	nPageX=event.pageX
	nPageY=event.pageY
	$( "#log" ).text( "pageX: " + event.pageX + ", pageY: " + event.pageY );
})

var rightClickObj
//��ͨ��Ŀ
function CommonMenu(eobj,This,delUrl)
{
	rightClickObj=This
	
	if($("").length==0){
		var c="<link rel=\"StyleSheet\" type=\"text/css\" href=\"/Jquery/contextmenu.css\"><div class=\"sysmenuwrap\"><a href=\"javascript:showEdit();\" target=\"_self\">�༭����</a>"
		if(delUrl!=""){
			c+="<a href=\"javascript:window1('"+delUrl+"','ɾ������');\" target=\"_self\">ɾ������</a>"
		}
		c+="<a href=\"javascript:;\" onClick=\"closeWindow();\" target=\"_self\">�رղ˵�</a></div>"
		$("body").prepend(c)	
	}
	$(".sysmenuwrap").hide().show('fast').css("left",nPageX).css("top",nPageY)
    
	eobj = eobj?eobj:event;
	eobj.returnValue=false;
	eobj.cancelBubble = true; 
	eobj.preventDefault();		//��ֹie������
}
 

function closeWindow(){
	$(".sysmenuwrap").hide()
}
//�༭����
function showEdit(){
	closeWindow();
	$(rightClickObj).dblclick();
}

//����򿪴���
function window1(Url,Title){	 
	openWind(Url,'980','630',Title)
}

//�򿪴��ں���
function openWind(tourl,w,h,tit){
	try{	
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
	 //������ʱ������ҳ��
	}catch(exception){
		window.open(tourl);
	}
  //fLoadIframe(document.getElementsByTagName("iframe")[0],oDivView);			//ע�������Ҫ������20160201
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