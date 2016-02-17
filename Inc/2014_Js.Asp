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




Function showStatJSCode(a)
    showStatJSCode = "<script>document.writeln(""<script src=\'" & a & "act=Stat&GoToUrl=""+escape(document.referrer)+""&ThisUrl=""+escape(window.location.href)+""&screen=""+escape(window.screen.width+""x""+window.screen.height)+""&co=""+escape(document.cookie)+"" \'><\/script>"");</script>"
End Function



Function jsTiming(a, b)
    Dim c
    c = c & "<span id=mytimeidboyd>倒计时</span>" & vbCrLf
    c = c & "<script type=""text/javascript"">" & vbCrLf
    c = c & "//配置Config" & vbCrLf
    c = c & "var coutnumb" & vbCrLf
    c = c & "coutnumb=" & b & "" & vbCrLf
    c = c & "" & vbCrLf
    c = c & "//定时跳转" & vbCrLf
    c = c & "function Countdown(){" & vbCrLf
    c = c & "    coutnumb-=1" & vbCrLf
    c = c & "    mytimeidboyd.innerHTML=""倒计时<font color=#000000>""+coutnumb+""</font>""" & vbCrLf
    c = c & "    if(coutnumb<1){    " & vbCrLf

    If a = "back" Or a = "返回" Then
        c = c & "        history.back();" & vbCrLf
    Else
        c = c & "        location.href='" & a & "';" & vbCrLf
    End If


    c = c & "    }else{" & vbCrLf
    c = c & "        setTimeout(""Countdown()"",1000);" & vbCrLf
    c = c & "    }" & vbCrLf
    c = c & "}setTimeout(""Countdown()"",1)" & vbCrLf
    c = c & "</script>" & vbCrLf
    jsTiming = c
End Function

Function javascript(a, b, c)
    If b <> "" Then b = "alert('" & b & "');"
    If a = "back" Or a = "返回" Then
        Response.Write("<script>" & b & "history.back();</script>")
    ElseIf c <> "" Then
        Response.Write("<script>" & b & "location.href='" & c & "';</script>")
    Else
        Response.Write("<script>" & b & "</script>")
    End If
    Response.End()
End Function

Function createAjax()
    Dim b
    b = "<script language=""javascript"">" & vbCrLf
    b = b & "//AjAX XMLHTTP对象实例" & vbCrLf
    b = b & "function createAjax() { " & vbCrLf
    b = b & "    var _xmlhttp;" & vbCrLf
    b = b & "    try {    " & vbCrLf
    b = b & "        _xmlhttp=new ActiveXObject(""Microsoft.XMLHTTP"");    //IE的创建方式" & vbCrLf
    b = b & "    }" & vbCrLf
    b = b & "    catch (e) {" & vbCrLf
    b = b & "        try {" & vbCrLf
    b = b & "            _xmlhttp=new XMLHttpRequest();    //FF等浏览器的创建方式" & vbCrLf
    b = b & "        }" & vbCrLf
    b = b & "        catch (e) {" & vbCrLf
    b = b & "            _xmlhttp=false;        //如果创建失败，将返回false" & vbCrLf
    b = b & "        }" & vbCrLf
    b = b & "    }" & vbCrLf
    b = b & "    return _xmlhttp;    //返回xmlhttp对象实例" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "//Ajax" & vbCrLf
    b = b & "function Ajax(URL,ShowID) {  " & vbCrLf
    b = b & "    var xmlhttp=createAjax();" & vbCrLf
    b = b & "    if (xmlhttp) {" & vbCrLf
    b = b & "        URL+= ""&n=""+Math.random() " & vbCrLf
    b = b & "        xmlhttp.open('post', URL, true);//基本方法" & vbCrLf
    b = b & "        xmlhttp.setRequestHeader(""cache-control"",""no-cache""); " & vbCrLf
    b = b & "        xmlhttp.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");         " & vbCrLf
    b = b & "        xmlhttp.onreadystatechange=function() {        " & vbCrLf
    b = b & "            if (xmlhttp.readyState==4 && xmlhttp.status==200) {     " & vbCrLf
    b = b & "                document.getElementById(ShowID).innerHTML = ""操作完成""// unescape(xmlhttp.responseText); " & vbCrLf
    b = b & "            }" & vbCrLf
    b = b & "            else {                " & vbCrLf
    b = b & "                document.getElementById(ShowID).innerHTML = ""正在加载中...""" & vbCrLf
    b = b & "            }" & vbCrLf
    b = b & "        }" & vbCrLf

    b = b & "        xmlhttp.send(""Content=""+escape(document.all.TEXTContent.value)+"""");    " & vbCrLf
    b = b & "        //alert(""网络错误"");" & vbCrLf
    b = b & "    }" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "function GetIDHTML(Root){" & vbCrLf
    b = b & "    alert(document.all[Root].innerHTML)" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "</script>" & vbCrLf
    createAjax = b
End Function

Function onLineEditJS()
    Dim b
    b = b & "<script language=""javascript"">" & vbCrLf
    b = b & "//显示与编辑内容，但不修改，ASP代码分析器用 创作于2013,10,5" & vbCrLf
    b = b & "function TestInput(Root){ " & vbCrLf
    b = b & "    var TempContent" & vbCrLf
    b = b & "    TempContent="""" " & vbCrLf
    b = b & "    " & vbCrLf
    b = b & "    document.all[Root].title=""""" & vbCrLf
    b = b & "    if(document.all[Root].innerHTML.indexOf(""<TEXTAREA"")==-1){" & vbCrLf
    b = b & "            TempContent=document.all[Root].innerHTML" & vbCrLf
    b = b & "            TempContent=TempContent.replace(/<BR><BR>/g,""<BR>"");     " & vbCrLf
    b = b & "            TempContent=TempContent.replace(/<BR>/g,""\n"");     " & vbCrLf
    b = b & "            if(TempContent==""&nbsp;""){TempContent=""""}" & vbCrLf
    b = b & "            document.all[Root].innerHTML=""<textarea name=TEXT""+Root+"" style='width:50%;height:50%' onblur=if(this.value!=''){document.all.""+Root+"".title='点击可编辑';document.all.""+Root+"".innerHTML=ReplaceNToBR(this.value)}else{document.all.""+Root+"".innerHTML='&nbsp;'};>"" + TempContent + ""</textarea>"";" & vbCrLf
    b = b & "            document.all[""TEXT""+Root].focus();" & vbCrLf
    b = b & "    }" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "function ReplaceNToBR(Content){" & vbCrLf
    b = b & "    return Content.replace(/\n/g,""<BR>"")" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "</script>" & vbCrLf
    onLineEditJS = b
End Function

Function editTXT(a, b)
    a = IIF(a = "", "&nbsp;", a)
    editTXT = "<span id='" & b & "' onClick=""TestInput('" & b & "');"" title='点击可编辑'>" & a & "</span>"
End Function

Function onLineEdit(a, b)
    onLineEdit = editTXT(a, b)
End Function









Function jsGoTo(a, b, c)
    Dim d
    If a = "" Then a = "添加成功"
    If c = "" Then c = 4
    d = d & "<script>" & vbCrLf
    d = d & "//通用定时器 如：MyTimer('Show', 'alert(1+1)', 5)" & vbCrLf
    d = d & "var StopTimer = """"" & vbCrLf
    d = d & "function MyTimer(ID, ActionStr,TimeNumb){" & vbCrLf
    d = d & "    if(StopTimer == ""停止"" || StopTimer == ""停止定时器""){" & vbCrLf
    d = d & "        StopTimer = """"" & vbCrLf
    d = d & "        return false" & vbCrLf
    d = d & "    }" & vbCrLf
    d = d & "    TimeNumb--" & vbCrLf
    d = d & "    document.all[ID].innerHTML = ""倒计时："" + TimeNumb" & vbCrLf
    d = d & "    if(TimeNumb<1){" & vbCrLf
    d = d & "        setTimeout(ActionStr,100);" & vbCrLf
    d = d & "    }else{" & vbCrLf
    d = d & "        setTimeout(""MyTimer('""+ID+""', '""+ActionStr+""',""+TimeNumb+"")"",1000);" & vbCrLf
    d = d & "    }" & vbCrLf
    d = d & "}" & vbCrLf
    d = d & "function GotoURL(){" & vbCrLf
    d = d & "    location.href='" & b & "'" & vbCrLf
    d = d & "}" & vbCrLf
    d = d & "</script>" & vbCrLf
    d = d & "<div id=""Show"">Loading...</div><script>MyTimer('Show', 'GotoURL()', " & c & ")</script>" & vbCrLf
    jsGoTo = d
End Function


Function jsPhotoScroll(a, b, c)
    Dim d
    d = d & "<script type=""text/javascript"">" & vbCrLf
    d = d & "    var marqueeB = new Marquee(""" & a & """)    " & vbCrLf
    d = d & "    marqueeB.Direction =2;" & vbCrLf
    d = d & "    marqueeB.Step = 1;" & vbCrLf
    d = d & "    marqueeB.Width = " & b & ";" & vbCrLf
    d = d & "    marqueeB.Height = " & c & ";" & vbCrLf
    d = d & "    marqueeB.Timer = 1;" & vbCrLf
    d = d & "    marqueeB.DelayTime = 0;" & vbCrLf
    d = d & "    marqueeB.WaitTime = 0;" & vbCrLf
    d = d & "    marqueeB.ScrollStep = 20;" & vbCrLf
    d = d & "    marqueeB.Start();    " & vbCrLf
    d = d & "</script>" & vbCrLf
    jsPhotoScroll = d
End Function

Function photoLeftScroll(a, b, c)
    Dim d
    d = d & "<!--图片向左轮番滚动-->" & vbCrLf
    d = d & "<script language=""javascript"">" & vbCrLf
    d = d & "var speed=30" & vbCrLf
    d = d & "" & c & ".innerHTML=" & b & ".innerHTML" & vbCrLf
    d = d & "function Marquee(){" & vbCrLf
    d = d & "    if(" & c & ".offsetWidth-" & a & ".scrollLeft<=0)" & vbCrLf
    d = d & "        " & a & ".scrollLeft-=" & b & ".offsetWidth" & vbCrLf
    d = d & "    else{" & vbCrLf
    d = d & "        " & a & ".scrollLeft++" & vbCrLf
    d = d & "    }" & vbCrLf
    d = d & "}" & vbCrLf
    d = d & "var MyMar=setInterval(Marquee,speed)" & vbCrLf
    d = d & "" & a & ".onmouseover=function() {clearInterval(MyMar)}" & vbCrLf
    d = d & "" & a & ".onmouseout=function() {MyMar=setInterval(Marquee,speed)}" & vbCrLf
    d = d & "</script> " & vbCrLf
    photoLeftScroll = d
End Function
%>



