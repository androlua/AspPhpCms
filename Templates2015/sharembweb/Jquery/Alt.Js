var sAgent = navigator.userAgent.toUpperCase();
if (sAgent.indexOf("MSIE") != -1) {
var sPop = null;
document.write("<style type='text/css' id='defaultPopStyle'>");
document.write(".cPopText {visibility:hidden;font-family:ËÎÌו,sans-serif;text-align:left;font-size:12px;background:#fff;border: 1px #000 solid;padding:3px 5px 3px 5px;filter:Alpha(Opacity=90);}");
document.write("</style>");
document.write("<div id='popLayer' style='position:absolute;z-index:1000' class='cPopText'></div>");
function showPopupText(event) {
	if(event.srcElement) o = event.srcElement; else o = event.target;
	MouseX=event.clientX;
	MouseY=event.clientY;
	if(o.alt!=null && o.alt!=""){ o.pop=o.alt;o.alt="" }
	if(o.title!=null && o.title!=""){ o.pop=o.title;o.title="" }
	if(o.pop!=sPop) {
		sPop=o.pop;
		if(sPop==null || sPop=="") {
			document.getElementById("popLayer").style.visibility="hidden";        
		} else {
			if(o.dyclass!=null) popStyle=o.dyclass; else popStyle="cPopText";
			document.getElementById("popLayer").style.visibility="visible";
			showIt();
		}
	}
}
function showIt() {
	document.getElementById("popLayer").className=popStyle;
	document.getElementById("popLayer").innerHTML=sPop;
	popWidth=document.getElementById("popLayer").clientWidth;
	popHeight=document.getElementById("popLayer").clientHeight;
	if(MouseX+12+popWidth>document.documentElement.clientWidth) popLeftAdjust=-popWidth-24; else popLeftAdjust=0;
	if(MouseY+12+popHeight>document.documentElement.clientHeight) popTopAdjust=-popHeight-24; else popTopAdjust=0;
	document.getElementById("popLayer").style.left=MouseX+document.documentElement.scrollLeft+popLeftAdjust;
	document.getElementById("popLayer").style.top=MouseY+18+document.documentElement.scrollTop+popTopAdjust;
}
if(!document.onmouseover) {
	document.onmouseover = function(e) {
		if (!e) showPopupText(window.event); else showPopupText(e);
	};
}
}
function setTab(m,n){
    var menu=document.getElementById("tab"+m).getElementsByTagName("li");  
    var div=document.getElementById("tablist"+m).getElementsByTagName("div");
    var showdiv=[];
    for (i=0; j=div[i]; i++){
      if ((" "+div[i].className+" ").indexOf(" tablist ")!=-1){
       showdiv.push(div[i]);
      }
    }
    for(i=0;i<menu.length;i++)
    {
        menu[i].className=i==n?"now":"";
        showdiv[i].style.display=i==n?"block":"none";  
    }
}