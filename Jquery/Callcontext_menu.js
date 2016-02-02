 
loadJs("/Jquery/lhgdialog.min.js"); 			//面板
 


//加载Js
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
//普通栏目
function CommonMenu(eobj,This,delUrl)
{
	rightClickObj=This
	
	if($("").length==0){
		var c="<link rel=\"StyleSheet\" type=\"text/css\" href=\"/Jquery/contextmenu.css\"><div class=\"sysmenuwrap\"><a href=\"javascript:showEdit();\">编辑内容</a>"
		if(delUrl!=""){
			c+="<a href=\"javascript:window1('"+delUrl+"','删除内容');\">删除内容</a>"
		}
		c+="<a href=\"javascript:;\" onClick=\"closeWindow();\">关闭菜单</a></div>"
		$("body").prepend(c)	
	}
	$(".sysmenuwrap").hide().show('fast').css("left",nPageX).css("top",nPageY)
    
	eobj = eobj?eobj:event;
	eobj.returnValue=false;
	eobj.cancelBubble = true; 
	
}
 

function closeWindow(){
	$(".sysmenuwrap").hide()
}
//编辑内容
function showEdit(){
	closeWindow();
	$(rightClickObj).dblclick();
}

//定义打开窗口
function window1(Url,Title){	 
	openWind(Url,'980','630',Title)
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
  //fLoadIframe(document.getElementsByTagName("iframe")[0],oDivView);			//注释这个，要不出错20160201
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