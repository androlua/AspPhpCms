<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-29
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By AspPhpCMS 
************************************************************/
?>
<?PHP
//Js

//远程网站会员统计2010330
//<script>document.writeln("<script src=\'http://127.0.0.1/web_soft/R.Asp?act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \'><\/script>");<'/script>
function showStatJSCode($url){
    $showStatJSCode = '<script>document.writeln("<script src=\\\'' . $url . 'act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \\\'><\\/script>");</script>' ;
    return @$showStatJSCode;
}


//Js定时跳转 Timing = 定时 时间测定 例：Call Rw("账号或密码错误，" & JsTiming("返回", 5))
function jsTiming($url, $seconds){
    $c ='';
    $c = $c . '<span id=mytimeidboyd>倒计时</span>' . "\n" ;
    $c = $c . '<script type="text/javascript">' . "\n" ;
    $c = $c . '//配置Config' . "\n" ;
    $c = $c . 'var coutnumb' . "\n" ;
    $c = $c . 'coutnumb=' . $seconds . '' . "\n" ;
    $c = $c . '' . "\n" ;
    $c = $c . '//定时跳转' . "\n" ;
    $c = $c . 'function Countdown(){' . "\n" ;//Countdown=倒数计秒
    $c = $c . '    coutnumb-=1' . "\n" ;
    $c = $c . '    mytimeidboyd.innerHTML="倒计时<font color=#000000>"+coutnumb+"</font>"' . "\n" ;
    $c = $c . '    if(coutnumb<1){    ' . "\n" ;

    if( $url == 'back' || $url == '返回' ){ //当Action为back是返回上页
        $c = $c . '        history.back();' . "\n" ;
    }else{
        $c = $c . '        location.href=\'' . $url . '\';' . "\n" ;
    }


    $c = $c . '    }else{' . "\n" ;
    $c = $c . '        setTimeout("Countdown()",1000);' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '}setTimeout("Countdown()",1)' . "\n" ;
    $c = $c . '</script>' . "\n" ;
    $jsTiming = $c ;
    return @$jsTiming;
}
//JS弹窗 Call Javascript("返回", "操作成功", "")
function javascript($action, $msg, $url){
    if( $msg <> '' ){ $msg = 'alert(\'' . $msg . '\');' ;}//当Msg不为空则弹出信息
    if( $action == 'back' || $action == '返回' ){ //当Action为back是返回上页
        echo('<script>' . $msg . 'history.back();</script>') ;
    }else if( $url <> '' ){ //当Url不为空
        echo('<script>' . $msg . 'location.href=\'' . $url . '\';</script>') ;//跳转Url页
    }else{
        echo('<script>' . $msg . '</script>') ;
    }
    die() ;
}
//创建Ajax对象实例
function createAjax(){
    $c ='';
    $c = '<script language="javascript">' . "\n" ;
    $c = $c . '//AjAX XMLHTTP对象实例' . "\n" ;
    $c = $c . 'function createAjax() { ' . "\n" ;
    $c = $c . '    var _xmlhttp;' . "\n" ;
    $c = $c . '    try {    ' . "\n" ;
    $c = $c . '        _xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");    //IE的创建方式' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '    catch (e) {' . "\n" ;
    $c = $c . '        try {' . "\n" ;
    $c = $c . '            _xmlhttp=new XMLHttpRequest();    //FF等浏览器的创建方式' . "\n" ;
    $c = $c . '        }' . "\n" ;
    $c = $c . '        catch (e) {' . "\n" ;
    $c = $c . '            _xmlhttp=false;        //如果创建失败，将返回false' . "\n" ;
    $c = $c . '        }' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '    return _xmlhttp;    //返回xmlhttp对象实例' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '//Ajax' . "\n" ;
    $c = $c . 'function Ajax(URL,ShowID) {  ' . "\n" ;
    $c = $c . '    var xmlhttp=createAjax();' . "\n" ;
    $c = $c . '    if (xmlhttp) {' . "\n" ;
    $c = $c . '        URL+= "&n="+Math.random() ' . "\n" ;
    $c = $c . '        xmlhttp.open(\'post\', URL, true);//基本方法' . "\n" ;
    $c = $c . '        xmlhttp.setRequestHeader("cache-control","no-cache"); ' . "\n" ;
    $c = $c . '        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");         ' . "\n" ;
    $c = $c . '        xmlhttp.onreadystatechange=function() {        ' . "\n" ;
    $c = $c . '            if (xmlhttp.readyState==4 && xmlhttp.status==200) {     ' . "\n" ;
    $c = $c . '                document.getElementById(ShowID).innerHTML = "操作完成"// unescape(xmlhttp.responseText); ' . "\n" ;
    $c = $c . '            }' . "\n" ;
    $c = $c . '            else {                ' . "\n" ;
    $c = $c . '                document.getElementById(ShowID).innerHTML = "正在加载中..."' . "\n" ;
    $c = $c . '            }' . "\n" ;
    $c = $c . '        }' . "\n" ;
    //c=c & "alert(document.all.TEXTContent.value)" & vbcrlf
    $c = $c . '        xmlhttp.send("Content="+escape(document.all.TEXTContent.value)+"");    ' . "\n" ;
    $c = $c . '        //alert("网络错误");' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . 'function GetIDHTML(Root){' . "\n" ;
    $c = $c . '    alert(document.all[Root].innerHTML)' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</script>' . "\n" ;
    $createAjax = $c ;
    return @$createAjax;
}
//JS在线编辑
function onLineEditJS(){
    $c ='';
    $c = $c . '<script language="javascript">' . "\n" ;
    $c = $c . '//显示与编辑内容，但不修改，ASP代码分析器用 创作于2013,10,5' . "\n" ;
    $c = $c . 'function TestInput(Root){ ' . "\n" ;
    $c = $c . '    var TempContent' . "\n" ;
    $c = $c . '    TempContent="" ' . "\n" ;
    $c = $c . '    ' . "\n" ;
    $c = $c . '    document.all[Root].title=""' . "\n" ;
    $c = $c . '    if(document.all[Root].innerHTML.indexOf("<TEXTAREA")==-1){' . "\n" ;
    $c = $c . '            TempContent=document.all[Root].innerHTML' . "\n" ;
    $c = $c . '            TempContent=TempContent.replace(/<BR><BR>/g,"<BR>");     ' . "\n" ;
    $c = $c . '            TempContent=TempContent.replace(/<BR>/g,"\\n");     ' . "\n" ;
    $c = $c . '            if(TempContent=="&nbsp;"){TempContent=""}' . "\n" ;
    $c = $c . '            document.all[Root].innerHTML="<textarea name=TEXT"+Root+" style=\'width:50%;height:50%\' onblur=if(this.value!=\'\'){document.all."+Root+".title=\'点击可编辑\';document.all."+Root+".innerHTML=ReplaceNToBR(this.value)}else{document.all."+Root+".innerHTML=\'&nbsp;\'};>" + TempContent + "</textarea>";' . "\n" ;
    $c = $c . '            document.all["TEXT"+Root].focus();' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . 'function ReplaceNToBR(Content){' . "\n" ;
    $c = $c . '    return Content.replace(/\\n/g,"<BR>")' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</script>' . "\n" ;
    $onLineEditJS = $c ;
    return @$onLineEditJS;
}
//在线编辑
function editTXT($content, $jsId){
    $content = IIF($content == '', '&nbsp;', $content) ;
    $editTXT = '<span id=\'' . $jsId . '\' onClick="TestInput(\'' . $jsId . '\');" title=\'点击可编辑\'>' . $content . '</span>' ;
    return @$editTXT;
}
//在线编辑  (辅助)
function onLineEdit($content, $jsId){
    $onLineEdit = editTXT($content, $jsId) ;
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
    if( $title == '' ){ $title = '添加成功' ;}
    if( $setTime == '' ){ $setTime = 4 ;}//默认为4秒
    $c = $c . '<script>' . "\n" ;
    $c = $c . '//通用定时器 如：MyTimer(\'Show\', \'alert(1+1)\', 5)' . "\n" ;
    $c = $c . 'var StopTimer = ""' . "\n" ;
    $c = $c . 'function MyTimer(ID, ActionStr,TimeNumb){' . "\n" ;
    $c = $c . '    if(StopTimer == "停止" || StopTimer == "停止定时器"){' . "\n" ;
    $c = $c . '        StopTimer = ""' . "\n" ;
    $c = $c . '        return false' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '    TimeNumb--' . "\n" ;
    $c = $c . '    document.all[ID].innerHTML = "倒计时：" + TimeNumb' . "\n" ;
    $c = $c . '    if(TimeNumb<1){' . "\n" ;
    $c = $c . '        setTimeout(ActionStr,100);' . "\n" ;
    $c = $c . '    }else{' . "\n" ;
    $c = $c . '        setTimeout("MyTimer(\'"+ID+"\', \'"+ActionStr+"\',"+TimeNumb+")",1000);' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . 'function GotoURL(){' . "\n" ;
    $c = $c . '    location.href=\'' . $url . '\'' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</script>' . "\n" ;
    $c = $c . '<div id="Show">Loading...</div><script>MyTimer(\'Show\', \'GotoURL()\', ' . $setTime . ')</script>' . "\n" ;
    $jsGoTo = $c ;
    return @$jsGoTo;
}

//JS图片滚动
function jsPhotoScroll($id, $width, $height){
    $c ='';
    $c = $c . '<script type="text/javascript">' . "\n" ;
    $c = $c . '    var marqueeB = new Marquee("' . $id . '")    ' . "\n" ;
    $c = $c . '    marqueeB.Direction =2;' . "\n" ;
    $c = $c . '    marqueeB.Step = 1;' . "\n" ;
    $c = $c . '    marqueeB.Width = ' . $width . ';' . "\n" ;
    $c = $c . '    marqueeB.Height = ' . $height . ';' . "\n" ;
    $c = $c . '    marqueeB.Timer = 1;' . "\n" ;
    $c = $c . '    marqueeB.DelayTime = 0;' . "\n" ;
    $c = $c . '    marqueeB.WaitTime = 0;' . "\n" ;
    $c = $c . '    marqueeB.ScrollStep = 20;' . "\n" ;
    $c = $c . '    marqueeB.Start();    ' . "\n" ;
    $c = $c . '</script>' . "\n" ;
    $jsPhotoScroll = $c ;
    return @$jsPhotoScroll;
}
//图片向左滚动（暂不用）
function photoLeftScroll($demo, $demo1, $demo2){
    $c ='';
    $c = $c . '<!--图片向左轮番滚动-->' . "\n" ;
    $c = $c . '<script language="javascript">' . "\n" ;
    $c = $c . 'var speed=30' . "\n" ;
    $c = $c . '' . $demo2 . '.innerHTML=' . $demo1 . '.innerHTML' . "\n" ;
    $c = $c . 'function Marquee(){' . "\n" ;
    $c = $c . '    if(' . $demo2 . '.offsetWidth-' . $demo . '.scrollLeft<=0)' . "\n" ;
    $c = $c . '        ' . $demo . '.scrollLeft-=' . $demo1 . '.offsetWidth' . "\n" ;
    $c = $c . '    else{' . "\n" ;
    $c = $c . '        ' . $demo . '.scrollLeft++' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . 'var MyMar=setInterval(Marquee,speed)' . "\n" ;
    $c = $c . '' . $demo . '.onmouseover=function() {clearInterval(MyMar)}' . "\n" ;
    $c = $c . '' . $demo . '.onmouseout=function() {MyMar=setInterval(Marquee,speed)}' . "\n" ;
    $c = $c . '</script> ' . "\n" ;
    $photoLeftScroll = $c ;
    return @$photoLeftScroll;
}
?>