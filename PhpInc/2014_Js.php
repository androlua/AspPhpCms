<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-29
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By AspPhpCMS 
************************************************************/
?>
<?PHP
//Js

//Զ����վ��Աͳ��2010330
//<script>document.writeln("<script src=\'http://127.0.0.1/web_soft/R.Asp?act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \'><\/script>");<'/script>
function showStatJSCode($url){
    $showStatJSCode = '<script>document.writeln("<script src=\\\'' . $url . 'act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \\\'><\\/script>");</script>' ;
    return @$showStatJSCode;
}


//Js��ʱ��ת Timing = ��ʱ ʱ��ⶨ ����Call Rw("�˺Ż��������" & JsTiming("����", 5))
function jsTiming($url, $seconds){
    $c ='';
    $c = $c . '<span id=mytimeidboyd>����ʱ</span>' . "\n" ;
    $c = $c . '<script type="text/javascript">' . "\n" ;
    $c = $c . '//����Config' . "\n" ;
    $c = $c . 'var coutnumb' . "\n" ;
    $c = $c . 'coutnumb=' . $seconds . '' . "\n" ;
    $c = $c . '' . "\n" ;
    $c = $c . '//��ʱ��ת' . "\n" ;
    $c = $c . 'function Countdown(){' . "\n" ;//Countdown=��������
    $c = $c . '    coutnumb-=1' . "\n" ;
    $c = $c . '    mytimeidboyd.innerHTML="����ʱ<font color=#000000>"+coutnumb+"</font>"' . "\n" ;
    $c = $c . '    if(coutnumb<1){    ' . "\n" ;

    if( $url == 'back' || $url == '����' ){ //��ActionΪback�Ƿ�����ҳ
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
//JS���� Call Javascript("����", "�����ɹ�", "")
function javascript($action, $msg, $url){
    if( $msg <> '' ){ $msg = 'alert(\'' . $msg . '\');' ;}//��Msg��Ϊ���򵯳���Ϣ
    if( $action == 'back' || $action == '����' ){ //��ActionΪback�Ƿ�����ҳ
        echo('<script>' . $msg . 'history.back();</script>') ;
    }else if( $url <> '' ){ //��Url��Ϊ��
        echo('<script>' . $msg . 'location.href=\'' . $url . '\';</script>') ;//��תUrlҳ
    }else{
        echo('<script>' . $msg . '</script>') ;
    }
    die() ;
}
//����Ajax����ʵ��
function createAjax(){
    $c ='';
    $c = '<script language="javascript">' . "\n" ;
    $c = $c . '//AjAX XMLHTTP����ʵ��' . "\n" ;
    $c = $c . 'function createAjax() { ' . "\n" ;
    $c = $c . '    var _xmlhttp;' . "\n" ;
    $c = $c . '    try {    ' . "\n" ;
    $c = $c . '        _xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");    //IE�Ĵ�����ʽ' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '    catch (e) {' . "\n" ;
    $c = $c . '        try {' . "\n" ;
    $c = $c . '            _xmlhttp=new XMLHttpRequest();    //FF��������Ĵ�����ʽ' . "\n" ;
    $c = $c . '        }' . "\n" ;
    $c = $c . '        catch (e) {' . "\n" ;
    $c = $c . '            _xmlhttp=false;        //�������ʧ�ܣ�������false' . "\n" ;
    $c = $c . '        }' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '    return _xmlhttp;    //����xmlhttp����ʵ��' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '//Ajax' . "\n" ;
    $c = $c . 'function Ajax(URL,ShowID) {  ' . "\n" ;
    $c = $c . '    var xmlhttp=createAjax();' . "\n" ;
    $c = $c . '    if (xmlhttp) {' . "\n" ;
    $c = $c . '        URL+= "&n="+Math.random() ' . "\n" ;
    $c = $c . '        xmlhttp.open(\'post\', URL, true);//��������' . "\n" ;
    $c = $c . '        xmlhttp.setRequestHeader("cache-control","no-cache"); ' . "\n" ;
    $c = $c . '        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");         ' . "\n" ;
    $c = $c . '        xmlhttp.onreadystatechange=function() {        ' . "\n" ;
    $c = $c . '            if (xmlhttp.readyState==4 && xmlhttp.status==200) {     ' . "\n" ;
    $c = $c . '                document.getElementById(ShowID).innerHTML = "�������"// unescape(xmlhttp.responseText); ' . "\n" ;
    $c = $c . '            }' . "\n" ;
    $c = $c . '            else {                ' . "\n" ;
    $c = $c . '                document.getElementById(ShowID).innerHTML = "���ڼ�����..."' . "\n" ;
    $c = $c . '            }' . "\n" ;
    $c = $c . '        }' . "\n" ;
    //c=c & "alert(document.all.TEXTContent.value)" & vbcrlf
    $c = $c . '        xmlhttp.send("Content="+escape(document.all.TEXTContent.value)+"");    ' . "\n" ;
    $c = $c . '        //alert("�������");' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . 'function GetIDHTML(Root){' . "\n" ;
    $c = $c . '    alert(document.all[Root].innerHTML)' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</script>' . "\n" ;
    $createAjax = $c ;
    return @$createAjax;
}
//JS���߱༭
function onLineEditJS(){
    $c ='';
    $c = $c . '<script language="javascript">' . "\n" ;
    $c = $c . '//��ʾ��༭���ݣ������޸ģ�ASP����������� ������2013,10,5' . "\n" ;
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
    $c = $c . '            document.all[Root].innerHTML="<textarea name=TEXT"+Root+" style=\'width:50%;height:50%\' onblur=if(this.value!=\'\'){document.all."+Root+".title=\'����ɱ༭\';document.all."+Root+".innerHTML=ReplaceNToBR(this.value)}else{document.all."+Root+".innerHTML=\'&nbsp;\'};>" + TempContent + "</textarea>";' . "\n" ;
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
//���߱༭
function editTXT($content, $jsId){
    $content = IIF($content == '', '&nbsp;', $content) ;
    $editTXT = '<span id=\'' . $jsId . '\' onClick="TestInput(\'' . $jsId . '\');" title=\'����ɱ༭\'>' . $content . '</span>' ;
    return @$editTXT;
}
//���߱༭  (����)
function onLineEdit($content, $jsId){
    $onLineEdit = editTXT($content, $jsId) ;
    return @$onLineEdit;
}
//****************************************************
//��������JSGoTo
//��  �ã���ʾ�ı�
//ʱ  �䣺2013��12��14��
//��  ����Url
//*       SetTime
//����ֵ���ַ���
//��  �ԣ�Call Echo("���Ժ��� JSGoTo", JSGoTo("", "",""))
//****************************************************
function jsGoTo($title, $url, $setTime){
    $c ='';
    if( $title == '' ){ $title = '��ӳɹ�' ;}
    if( $setTime == '' ){ $setTime = 4 ;}//Ĭ��Ϊ4��
    $c = $c . '<script>' . "\n" ;
    $c = $c . '//ͨ�ö�ʱ�� �磺MyTimer(\'Show\', \'alert(1+1)\', 5)' . "\n" ;
    $c = $c . 'var StopTimer = ""' . "\n" ;
    $c = $c . 'function MyTimer(ID, ActionStr,TimeNumb){' . "\n" ;
    $c = $c . '    if(StopTimer == "ֹͣ" || StopTimer == "ֹͣ��ʱ��"){' . "\n" ;
    $c = $c . '        StopTimer = ""' . "\n" ;
    $c = $c . '        return false' . "\n" ;
    $c = $c . '    }' . "\n" ;
    $c = $c . '    TimeNumb--' . "\n" ;
    $c = $c . '    document.all[ID].innerHTML = "����ʱ��" + TimeNumb' . "\n" ;
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

//JSͼƬ����
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
//ͼƬ����������ݲ��ã�
function photoLeftScroll($demo, $demo1, $demo2){
    $c ='';
    $c = $c . '<!--ͼƬ�����ַ�����-->' . "\n" ;
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