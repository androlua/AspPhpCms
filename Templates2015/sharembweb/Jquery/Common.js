loadJs("/Jquery/Jquery.Min.js");				//Jquery
loadJs("/Jquery/ShowTime.Js");					//显示时间
loadJs("/Jquery/MSClass.Js"); 					//滚动
loadJs("/Jquery/lhgdialog.min.js"); 			//面板
loadJs("/Jquery/ScrollPicLeft.js");			    //右左滚动
loadJs("/Jquery/swfobject.js");			    	//flash控件
loadJs("/Jquery/Function.js");			    	//加载函数


//加载Js
function loadJs(name) {    
	document.write('<script src="'+name+'" type="text/javascript"></script>');
}

