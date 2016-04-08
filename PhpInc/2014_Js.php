<?PHP
//Js

//远程网站会员统计2010330
//<script>document.writeln("<script src=\'http://127.0.0.1/web_soft/R.Asp?act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \'><\/script>");<'/script>
function showStatJSCode($url){
    $showStatJSCode= '<script>document.writeln("<script src=\\\'' . $url . 'act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \\\'><\\/script>");</script>';
    return @$showStatJSCode;
}


//Js定时跳转 Timing = 定时 时间测定 例：Call Rw("账号或密码错误，" & JsTiming("返回", 5))
function jsTiming($url, $seconds){
    $c ='';
    $c= $c . '<span id=mytimeidboyd>倒计时</span>' . vbCrlf();
    $c= $c . '<script type="text/javascript">' . vbCrlf();
    $c= $c . '//配置Config' . vbCrlf();
    $c= $c . 'var coutnumb' . vbCrlf();
    $c= $c . 'coutnumb=' . $seconds . '' . vbCrlf();
    $c= $c . '' . vbCrlf();
    $c= $c . '//定时跳转' . vbCrlf();
    $c= $c . 'function Countdown(){' . vbCrlf(); //Countdown=倒数计秒
    $c= $c . '    coutnumb-=1' . vbCrlf();
    $c= $c . '    mytimeidboyd.innerHTML="倒计时<font color=#000000>"+coutnumb+"</font>"' . vbCrlf();
    $c= $c . '    if(coutnumb<1){    ' . vbCrlf();

    if( $url== 'back' || $url== '返回' ){ //当Action为back是返回上页
        $c= $c . '        history.back();' . vbCrlf();
    }else{
        $c= $c . '        location.href=\'' . $url . '\';' . vbCrlf();
    }


    $c= $c . '    }else{' . vbCrlf();
    $c= $c . '        setTimeout("Countdown()",1000);' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '}setTimeout("Countdown()",1)' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();
    $jsTiming= $c;
    return @$jsTiming;
}
//JS弹窗 Call Javascript("返回", "操作成功", "")
function javascript($action, $msg, $url){
    if( $msg <> '' ){ $msg= 'alert(\'' . $msg . '\');' ;}//当Msg不为空则弹出信息
    if( $action== 'back' || $action== '返回' ){ //当Action为back是返回上页
        echo('<script>' . $msg . 'history.back();</script>');
    }else if( $url <> '' ){ //当Url不为空
        echo('<script>' . $msg . 'location.href=\'' . $url . '\';</script>'); //跳转Url页
    }else{
        echo('<script>' . $msg . '</script>');
    }
    die();
}
//创建Ajax对象实例
function createAjax(){
    $c ='';
    $c= '<script language="javascript">' . vbCrlf();
    $c= $c . '//AjAX XMLHTTP对象实例' . vbCrlf();
    $c= $c . 'function createAjax() { ' . vbCrlf();
    $c= $c . '    var _xmlhttp;' . vbCrlf();
    $c= $c . '    try {    ' . vbCrlf();
    $c= $c . '        _xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");    //IE的创建方式' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '    catch (e) {' . vbCrlf();
    $c= $c . '        try {' . vbCrlf();
    $c= $c . '            _xmlhttp=new XMLHttpRequest();    //FF等浏览器的创建方式' . vbCrlf();
    $c= $c . '        }' . vbCrlf();
    $c= $c . '        catch (e) {' . vbCrlf();
    $c= $c . '            _xmlhttp=false;        //如果创建失败，将返回false' . vbCrlf();
    $c= $c . '        }' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '    return _xmlhttp;    //返回xmlhttp对象实例' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '//Ajax' . vbCrlf();
    $c= $c . 'function Ajax(URL,ShowID) {  ' . vbCrlf();
    $c= $c . '    var xmlhttp=createAjax();' . vbCrlf();
    $c= $c . '    if (xmlhttp) {' . vbCrlf();
    $c= $c . '        URL+= "&n="+Math.random() ' . vbCrlf();
    $c= $c . '        xmlhttp.open(\'post\', URL, true);//基本方法' . vbCrlf();
    $c= $c . '        xmlhttp.setRequestHeader("cache-control","no-cache"); ' . vbCrlf();
    $c= $c . '        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");         ' . vbCrlf();
    $c= $c . '        xmlhttp.onreadystatechange=function() {        ' . vbCrlf();
    $c= $c . '            if (xmlhttp.readyState==4 && xmlhttp.status==200) {     ' . vbCrlf();
    $c= $c . '                document.getElementById(ShowID).innerHTML = "操作完成"// unescape(xmlhttp.responseText); ' . vbCrlf();
    $c= $c . '            }' . vbCrlf();
    $c= $c . '            else {                ' . vbCrlf();
    $c= $c . '                document.getElementById(ShowID).innerHTML = "正在加载中..."' . vbCrlf();
    $c= $c . '            }' . vbCrlf();
    $c= $c . '        }' . vbCrlf();
    //c=c & "alert(document.all.TEXTContent.value)" & vbcrlf
    $c= $c . '        xmlhttp.send("Content="+escape(document.all.TEXTContent.value)+"");    ' . vbCrlf();
    $c= $c . '        //alert("网络错误");' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . 'function GetIDHTML(Root){' . vbCrlf();
    $c= $c . '    alert(document.all[Root].innerHTML)' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();
    $createAjax= $c;
    return @$createAjax;
}
//JS在线编辑
function onLineEditJS(){
    $c ='';
    $c= $c . '<script language="javascript">' . vbCrlf();
    $c= $c . '//显示与编辑内容，但不修改，ASP代码分析器用 创作于2013,10,5' . vbCrlf();
    $c= $c . 'function TestInput(Root){ ' . vbCrlf();
    $c= $c . '    var TempContent' . vbCrlf();
    $c= $c . '    TempContent="" ' . vbCrlf();
    $c= $c . '    ' . vbCrlf();
    $c= $c . '    document.all[Root].title=""' . vbCrlf();
    $c= $c . '    if(document.all[Root].innerHTML.indexOf("<TEXTAREA")==-1){' . vbCrlf();
    $c= $c . '            TempContent=document.all[Root].innerHTML' . vbCrlf();
    $c= $c . '            TempContent=TempContent.replace(/<BR><BR>/g,"<BR>");     ' . vbCrlf();
    $c= $c . '            TempContent=TempContent.replace(/<BR>/g,"\\n");     ' . vbCrlf();
    $c= $c . '            if(TempContent=="&nbsp;"){TempContent=""}' . vbCrlf();
    $c= $c . '            document.all[Root].innerHTML="<textarea name=TEXT"+Root+" style=\'width:50%;height:50%\' onblur=if(this.value!=\'\'){document.all."+Root+".title=\'点击可编辑\';document.all."+Root+".innerHTML=ReplaceNToBR(this.value)}else{document.all."+Root+".innerHTML=\'&nbsp;\'};>" + TempContent + "</textarea>";' . vbCrlf();
    $c= $c . '            document.all["TEXT"+Root].focus();' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . 'function ReplaceNToBR(Content){' . vbCrlf();
    $c= $c . '    return Content.replace(/\\n/g,"<BR>")' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();
    $onLineEditJS= $c;
    return @$onLineEditJS;
}
//在线编辑
function editTXT($content, $jsId){
    $content= IIF($content== '', '&nbsp;', $content);
    $editTXT= '<span id=\'' . $jsId . '\' onClick="TestInput(\'' . $jsId . '\');" title=\'点击可编辑\'>' . $content . '</span>';
    return @$editTXT;
}
//在线编辑  (辅助)
function onLineEdit($content, $jsId){
    $onLineEdit= editTXT($content, $jsId);
    return @$onLineEdit;
}
//****************************************************
//函数名：JSGoTo
//作  用：显示文本
//时  间：2013年12月14日
//参  数：Url
//*       SetTime
//返回值：字符串
//调  试：Call Echo("测试函数 JSGoTo", JSGoTo("", "",""))
//****************************************************
function jsGoTo($title, $url, $setTime){
    $c ='';
    if( $title== '' ){ $title= '添加成功' ;}
    if( $setTime== '' ){ $setTime= 4 ;}//默认为4秒
    $c= $c . '<script>' . vbCrlf();
    $c= $c . '//通用定时器 如：MyTimer(\'Show\', \'alert(1+1)\', 5)' . vbCrlf();
    $c= $c . 'var StopTimer = ""' . vbCrlf();
    $c= $c . 'function MyTimer(ID, ActionStr,TimeNumb){' . vbCrlf();
    $c= $c . '    if(StopTimer == "停止" || StopTimer == "停止定时器"){' . vbCrlf();
    $c= $c . '        StopTimer = ""' . vbCrlf();
    $c= $c . '        return false' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '    TimeNumb--' . vbCrlf();
    $c= $c . '    document.all[ID].innerHTML = "倒计时：" + TimeNumb' . vbCrlf();
    $c= $c . '    if(TimeNumb<1){' . vbCrlf();
    $c= $c . '        setTimeout(ActionStr,100);' . vbCrlf();
    $c= $c . '    }else{' . vbCrlf();
    $c= $c . '        setTimeout("MyTimer(\'"+ID+"\', \'"+ActionStr+"\',"+TimeNumb+")",1000);' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . 'function GotoURL(){' . vbCrlf();
    $c= $c . '    location.href=\'' . $url . '\'' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();
    $c= $c . '<div id="Show">Loading...</div><script>MyTimer(\'Show\', \'GotoURL()\', ' . $setTime . ')</script>' . vbCrlf();
    $jsGoTo= $c;
    return @$jsGoTo;
}

//JS图片滚动
function jsPhotoScroll($id, $width, $height){
    $c ='';
    $c= $c . '<script type="text/javascript">' . vbCrlf();
    $c= $c . '    var marqueeB = new Marquee("' . $id . '")    ' . vbCrlf();
    $c= $c . '    marqueeB.Direction =2;' . vbCrlf();
    $c= $c . '    marqueeB.Step = 1;' . vbCrlf();
    $c= $c . '    marqueeB.Width = ' . $width . ';' . vbCrlf();
    $c= $c . '    marqueeB.Height = ' . $height . ';' . vbCrlf();
    $c= $c . '    marqueeB.Timer = 1;' . vbCrlf();
    $c= $c . '    marqueeB.DelayTime = 0;' . vbCrlf();
    $c= $c . '    marqueeB.WaitTime = 0;' . vbCrlf();
    $c= $c . '    marqueeB.ScrollStep = 20;' . vbCrlf();
    $c= $c . '    marqueeB.Start();    ' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();
    $jsPhotoScroll= $c;
    return @$jsPhotoScroll;
}
//图片向左滚动（暂不用）
function photoLeftScroll($demo, $demo1, $demo2){
    $c ='';
    $c= $c . '<!--图片向左轮番滚动-->' . vbCrlf();
    $c= $c . '<script language="javascript">' . vbCrlf();
    $c= $c . 'var speed=30' . vbCrlf();
    $c= $c . '' . $demo2 . '.innerHTML=' . $demo1 . '.innerHTML' . vbCrlf();
    $c= $c . 'function Marquee(){' . vbCrlf();
    $c= $c . '    if(' . $demo2 . '.offsetWidth-' . $demo . '.scrollLeft<=0)' . vbCrlf();
    $c= $c . '        ' . $demo . '.scrollLeft-=' . $demo1 . '.offsetWidth' . vbCrlf();
    $c= $c . '    else{' . vbCrlf();
    $c= $c . '        ' . $demo . '.scrollLeft++' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . 'var MyMar=setInterval(Marquee,speed)' . vbCrlf();
    $c= $c . '' . $demo . '.onmouseover=function() {clearInterval(MyMar)}' . vbCrlf();
    $c= $c . '' . $demo . '.onmouseout=function() {MyMar=setInterval(Marquee,speed)}' . vbCrlf();
    $c= $c . '</script> ' . vbCrlf();
    $photoLeftScroll= $c;
    return @$photoLeftScroll;
}
?>