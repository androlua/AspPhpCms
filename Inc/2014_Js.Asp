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
fUNcTIoN sHOwSTaTJsCOdE(a)
sHOwSTaTJsCOdE = "<script>document.writeln(""<script src=\'" & a & "act=Stat&GoToUrl=""+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)+""&co=""+escape(document.cookie)+"" \'><\/script>"");</script>"
eND fUNcTIoN
fUNcTIoN jSTiMInG(a, b)
dIM c
c = c & "<span id=mytimeidboyd>倒计时</span>" & vBCrLF
c = c & "<script type=""text/javascript"">" & vBCrLF
c = c & "//配置Config" & vBCrLF
c = c & "var coutnumb" & vBCrLF
c = c & "coutnumb=" & b & "" & vBCrLF
c = c & "" & vBCrLF
c = c & "//定时跳转" & vBCrLF
c = c & "function Countdown(){" & vBCrLF
c = c & "    coutnumb-=1" & vBCrLF
c = c & "    mytimeidboyd.innerHTML=""倒计时<font color=#000000>""+coutnumb+""</font>""" & vBCrLF
c = c & "    if(coutnumb<1){    " & vBCrLF
iF a = "back" oR a = "返回" tHEn
c = c & "        history.back();" & vBCrLF
eLSe
c = c & "        location.href='" & a & "';" & vBCrLF
eND iF
c = c & "    }else{" & vBCrLF
c = c & "        setTimeout(""Countdown()"",1000);" & vBCrLF
c = c & "    }" & vBCrLF
c = c & "}setTimeout(""Countdown()"",1)" & vBCrLF
c = c & "</script>" & vBCrLF
jSTiMInG = c
eND fUNcTIoN
fUNcTIoN jAVaSCrIPt(a, b, c)
iF b <> "" tHEn b = "alert('" & b & "');"
iF a = "back" oR a = "返回" tHEn
rESpONsE.wRItE("<script>" & b & "history.back();</script>")
eLSeIF c <> "" tHEn
rESpONsE.wRItE("<script>" & b & "location.href='" & c & "';</script>")
eLSe
rESpONsE.wRItE("<script>" & b & "</script>")
eND iF
rESpONsE.eND()
eND fUNcTIoN
fUNcTIoN cREaTEaJAx()
dIM b
b = "<script language=""javascript"">" & vBCrLF
b = b & "//AjAX XMLHTTP对象实例" & vBCrLF
b = b & "function createAjax() { " & vBCrLF
b = b & "    var _xmlhttp;" & vBCrLF
b = b & "    try {    " & vBCrLF
b = b & "        _xmlhttp=new ActiveXObject(""Microsoft.XMLHTTP"");    //IE的创建方式" & vBCrLF
b = b & "    }" & vBCrLF
b = b & "    catch (e) {" & vBCrLF
b = b & "        try {" & vBCrLF
b = b & "            _xmlhttp=new XMLHttpRequest();    //FF等浏览器的创建方式" & vBCrLF
b = b & "        }" & vBCrLF
b = b & "        catch (e) {" & vBCrLF
b = b & "            _xmlhttp=false;        //如果创建失败，将返回false" & vBCrLF
b = b & "        }" & vBCrLF
b = b & "    }" & vBCrLF
b = b & "    return _xmlhttp;    //返回xmlhttp对象实例" & vBCrLF
b = b & "}" & vBCrLF
b = b & "//Ajax" & vBCrLF
b = b & "function Ajax(URL,ShowID) {  " & vBCrLF
b = b & "    var xmlhttp=createAjax();" & vBCrLF
b = b & "    if (xmlhttp) {" & vBCrLF
b = b & "        URL+= ""&n=""+Math.random() " & vBCrLF
b = b & "        xmlhttp.open('post', URL, true);//基本方法" & vBCrLF
b = b & "        xmlhttp.setRequestHeader(""cache-control"",""no-cache""); " & vBCrLF
b = b & "        xmlhttp.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");         " & vBCrLF
b = b & "        xmlhttp.onreadystatechange=function() {        " & vBCrLF
b = b & "            if (xmlhttp.readyState==4 && xmlhttp.status==200) {     " & vBCrLF
b = b & "                document.getElementById(ShowID).innerHTML = ""操作完成""// unescape(xmlhttp.responseText); " & vBCrLF
b = b & "            }" & vBCrLF
b = b & "            else {                " & vBCrLF
b = b & "                document.getElementById(ShowID).innerHTML = ""正在加载中...""" & vBCrLF
b = b & "            }" & vBCrLF
b = b & "        }" & vBCrLF
b = b & "        xmlhttp.send(""Content=""+escape(document.all.TEXTContent.value)+"""");    " & vBCrLF
b = b & "        //alert(""网络错误"");" & vBCrLF
b = b & "    }" & vBCrLF
b = b & "}" & vBCrLF
b = b & "function GetIDHTML(Root){" & vBCrLF
b = b & "    alert(document.all[Root].innerHTML)" & vBCrLF
b = b & "}" & vBCrLF
b = b & "</script>" & vBCrLF
cREaTEaJAx = b
eND fUNcTIoN
fUNcTIoN oNLiNEeDItJS()
dIM b
b = b & "<script language=""javascript"">" & vBCrLF
b = b & "//显示与编辑内容，但不修改，ASP代码分析器用 创作于2013,10,5" & vBCrLF
b = b & "function TestInput(Root){ " & vBCrLF
b = b & "    var TempContent" & vBCrLF
b = b & "    TempContent="""" " & vBCrLF
b = b & "    " & vBCrLF
b = b & "    document.all[Root].title=""""" & vBCrLF
b = b & "    if(document.all[Root].innerHTML.indexOf(""<TEXTAREA"")==-1){" & vBCrLF
b = b & "            TempContent=document.all[Root].innerHTML" & vBCrLF
b = b & "            TempContent=TempContent.replace(/<BR><BR>/g,""<BR>"");     " & vBCrLF
b = b & "            TempContent=TempContent.replace(/<BR>/g,""\n"");     " & vBCrLF
b = b & "            if(TempContent==""&nbsp;""){TempContent=""""}" & vBCrLF
b = b & "            document.all[Root].innerHTML=""<textarea name=TEXT""+Root+"" style='width:50%;height:50%' onblur=if(this.value!=''){document.all.""+Root+"".title='点击可编辑';document.all.""+Root+"".innerHTML=ReplaceNToBR(this.value)}else{document.all.""+Root+"".innerHTML='&nbsp;'};>"" + TempContent + ""</textarea>"";" & vBCrLF
b = b & "            document.all[""TEXT""+Root].focus();" & vBCrLF
b = b & "    }" & vBCrLF
b = b & "}" & vBCrLF
b = b & "function ReplaceNToBR(Content){" & vBCrLF
b = b & "    return Content.replace(/\n/g,""<BR>"")" & vBCrLF
b = b & "}" & vBCrLF
b = b & "</script>" & vBCrLF
oNLiNEeDItJS = b
eND fUNcTIoN
fUNcTIoN eDItTXt(a, b)
a = iIF(a = "", "&nbsp;", a)
eDItTXt = "<span id='" & b & "' onClick=""TestInput('" & b & "');"" title='点击可编辑'>" & a & "</span>"
eND fUNcTIoN
fUNcTIoN oNLiNEeDIt(a, b)
oNLiNEeDIt = eDItTXt(a, b)
eND fUNcTIoN
fUNcTIoN jSGoTO(a, b, c)
dIM d
iF a = "" tHEn a = "添加成功"
iF c = "" tHEn c = 4
d = d & "<script>" & vBCrLF
d = d & "//通用定时器 如：MyTimer('Show', 'alert(1+1)', 5)" & vBCrLF
d = d & "var StopTimer = """"" & vBCrLF
d = d & "function MyTimer(ID, ActionStr,TimeNumb){" & vBCrLF
d = d & "    if(StopTimer == ""停止"" || StopTimer == ""停止定时器""){" & vBCrLF
d = d & "        StopTimer = """"" & vBCrLF
d = d & "        return false" & vBCrLF
d = d & "    }" & vBCrLF
d = d & "    TimeNumb--" & vBCrLF
d = d & "    document.all[ID].innerHTML = ""倒计时："" + TimeNumb" & vBCrLF
d = d & "    if(TimeNumb<1){" & vBCrLF
d = d & "        setTimeout(ActionStr,100);" & vBCrLF
d = d & "    }else{" & vBCrLF
d = d & "        setTimeout(""MyTimer('""+ID+""', '""+ActionStr+""',""+TimeNumb+"")"",1000);" & vBCrLF
d = d & "    }" & vBCrLF
d = d & "}" & vBCrLF
d = d & "function GotoURL(){" & vBCrLF
d = d & "    location.href='" & b & "'" & vBCrLF
d = d & "}" & vBCrLF
d = d & "</script>" & vBCrLF
d = d & "<div id=""Show"">Loading...</div><script>MyTimer('Show', 'GotoURL()', " & c & ")</script>" & vBCrLF
jSGoTO = d
eND fUNcTIoN
fUNcTIoN jSPhOToSCrOLl(a, b, c)
dIM d
d = d & "<script type=""text/javascript"">" & vBCrLF
d = d & "    var marqueeB = new Marquee(""" & a & """)    " & vBCrLF
d = d & "    marqueeB.Direction =2;" & vBCrLF
d = d & "    marqueeB.Step = 1;" & vBCrLF
d = d & "    marqueeB.Width = " & b & ";" & vBCrLF
d = d & "    marqueeB.Height = " & c & ";" & vBCrLF
d = d & "    marqueeB.Timer = 1;" & vBCrLF
d = d & "    marqueeB.DelayTime = 0;" & vBCrLF
d = d & "    marqueeB.WaitTime = 0;" & vBCrLF
d = d & "    marqueeB.ScrollStep = 20;" & vBCrLF
d = d & "    marqueeB.Start();    " & vBCrLF
d = d & "</script>" & vBCrLF
jSPhOToSCrOLl = d
eND fUNcTIoN
fUNcTIoN pHOtOLeFTsCRoLL(a, b, c)
dIM d
d = d & "<!--图片向左轮番滚动-->" & vBCrLF
d = d & "<script language=""javascript"">" & vBCrLF
d = d & "var speed=30" & vBCrLF
d = d & "" & c & ".innerHTML=" & b & ".innerHTML" & vBCrLF
d = d & "function Marquee(){" & vBCrLF
d = d & "    if(" & c & ".offsetWidth-" & a & ".scrollLeft<=0)" & vBCrLF
d = d & "        " & a & ".scrollLeft-=" & b & ".offsetWidth" & vBCrLF
d = d & "    else{" & vBCrLF
d = d & "        " & a & ".scrollLeft++" & vBCrLF
d = d & "    }" & vBCrLF
d = d & "}" & vBCrLF
d = d & "var MyMar=setInterval(Marquee,speed)" & vBCrLF
d = d & "" & a & ".onmouseover=function() {clearInterval(MyMar)}" & vBCrLF
d = d & "" & a & ".onmouseout=function() {MyMar=setInterval(Marquee,speed)}" & vBCrLF
d = d & "</script> " & vBCrLF
pHOtOLeFTsCRoLL = d
eND fUNcTIoN
%>

