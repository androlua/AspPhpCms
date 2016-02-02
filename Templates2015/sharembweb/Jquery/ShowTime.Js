//显示日期
function time_showLocale(objD){
	var str,colorhead,colorfoot;
	var yy = objD.getYear();
	if(yy<1900) yy = yy+1900;
	var MM = objD.getMonth()+1;
	if(MM<10) MM = '0' + MM;
	var dd = objD.getDate();
	if(dd<10) dd = '0' + dd;
	var hh = objD.getHours();
	if(hh<10) hh = '0' + hh;
	var mm = objD.getMinutes();
	if(mm<10) mm = '0' + mm;
	var ss = objD.getSeconds();
	if(ss<10) ss = '0' + ss;
	var ww = objD.getDay();
	if ( ww==0 ) colorhead=" ";
	if ( ww > 0 && ww < 6 ) colorhead=" ";
	if ( ww==6 ) colorhead=" ";
	if (ww==0) ww="星期日";
	if (ww==1) ww="星期一";
	if (ww==2) ww="星期二";
	if (ww==3) ww="星期三";
	if (ww==4) ww="星期四";
	if (ww==5) ww="星期五";
	if (ww==6) ww="星期六"; 
	str = colorhead + yy + "-" + MM + "-" + dd + " " + ww 
	return(str);
}
//显示时间 time_tick("南京市微战略科技有限公司") <span id="localtime"></span>
function time_tick(CompanyName){
	var today;
	today = new Date();
	var C = "您好，欢迎来到"+ CompanyName +"&nbsp;今天是:"  + time_showLocale(today);
	document.getElementById("localtime").innerHTML = C;
	//window.setTimeout("time_tick()", 1000);
}