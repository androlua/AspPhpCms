<?PHP
//Js

//Զ����վ��Աͳ��2010330
//<script>document.writeln("<script src=\'http://127.0.0.1/web_soft/R.Asp?act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \'><\/script>");<'/script>
function showStatJSCode($url){
    $showStatJSCode= '<script>document.writeln("<script src=\\\'' . $url . 'act=Stat&GoToUrl="+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)+"&co="+escape(document.cookie)+" \\\'><\\/script>");</script>';
    return @$showStatJSCode;
}


//Js��ʱ��ת Timing = ��ʱ ʱ��ⶨ ����Call Rw("�˺Ż��������" & JsTiming("����", 5))
function jsTiming($url, $seconds){
    $c ='';
    $c= $c . '<span id=mytimeidboyd>����ʱ</span>' . vbCrlf();
    $c= $c . '<script type="text/javascript">' . vbCrlf();
    $c= $c . '//����Config' . vbCrlf();
    $c= $c . 'var coutnumb' . vbCrlf();
    $c= $c . 'coutnumb=' . $seconds . '' . vbCrlf();
    $c= $c . '' . vbCrlf();
    $c= $c . '//��ʱ��ת' . vbCrlf();
    $c= $c . 'function Countdown(){' . vbCrlf(); //Countdown=��������
    $c= $c . '    coutnumb-=1' . vbCrlf();
    $c= $c . '    mytimeidboyd.innerHTML="����ʱ<font color=#000000>"+coutnumb+"</font>"' . vbCrlf();
    $c= $c . '    if(coutnumb<1){    ' . vbCrlf();

    if( $url== 'back' || $url== '����' ){ //��ActionΪback�Ƿ�����ҳ
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
//JS���� Call Javascript("����", "�����ɹ�", "")
function javascript($action, $msg, $url){
    if( $msg <> '' ){ $msg= 'alert(\'' . $msg . '\');' ;}//��Msg��Ϊ���򵯳���Ϣ
    if( $action== 'back' || $action== '����' ){ //��ActionΪback�Ƿ�����ҳ
        echo('<script>' . $msg . 'history.back();</script>');
    }else if( $url <> '' ){ //��Url��Ϊ��
        echo('<script>' . $msg . 'location.href=\'' . $url . '\';</script>'); //��תUrlҳ
    }else{
        echo('<script>' . $msg . '</script>');
    }
    die();
}
//����Ajax����ʵ��
function createAjax(){
    $c ='';
    $c= '<script language="javascript">' . vbCrlf();
    $c= $c . '//AjAX XMLHTTP����ʵ��' . vbCrlf();
    $c= $c . 'function createAjax() { ' . vbCrlf();
    $c= $c . '    var _xmlhttp;' . vbCrlf();
    $c= $c . '    try {    ' . vbCrlf();
    $c= $c . '        _xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");    //IE�Ĵ�����ʽ' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '    catch (e) {' . vbCrlf();
    $c= $c . '        try {' . vbCrlf();
    $c= $c . '            _xmlhttp=new XMLHttpRequest();    //FF��������Ĵ�����ʽ' . vbCrlf();
    $c= $c . '        }' . vbCrlf();
    $c= $c . '        catch (e) {' . vbCrlf();
    $c= $c . '            _xmlhttp=false;        //�������ʧ�ܣ�������false' . vbCrlf();
    $c= $c . '        }' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '    return _xmlhttp;    //����xmlhttp����ʵ��' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '//Ajax' . vbCrlf();
    $c= $c . 'function Ajax(URL,ShowID) {  ' . vbCrlf();
    $c= $c . '    var xmlhttp=createAjax();' . vbCrlf();
    $c= $c . '    if (xmlhttp) {' . vbCrlf();
    $c= $c . '        URL+= "&n="+Math.random() ' . vbCrlf();
    $c= $c . '        xmlhttp.open(\'post\', URL, true);//��������' . vbCrlf();
    $c= $c . '        xmlhttp.setRequestHeader("cache-control","no-cache"); ' . vbCrlf();
    $c= $c . '        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");         ' . vbCrlf();
    $c= $c . '        xmlhttp.onreadystatechange=function() {        ' . vbCrlf();
    $c= $c . '            if (xmlhttp.readyState==4 && xmlhttp.status==200) {     ' . vbCrlf();
    $c= $c . '                document.getElementById(ShowID).innerHTML = "�������"// unescape(xmlhttp.responseText); ' . vbCrlf();
    $c= $c . '            }' . vbCrlf();
    $c= $c . '            else {                ' . vbCrlf();
    $c= $c . '                document.getElementById(ShowID).innerHTML = "���ڼ�����..."' . vbCrlf();
    $c= $c . '            }' . vbCrlf();
    $c= $c . '        }' . vbCrlf();
    //c=c & "alert(document.all.TEXTContent.value)" & vbcrlf
    $c= $c . '        xmlhttp.send("Content="+escape(document.all.TEXTContent.value)+"");    ' . vbCrlf();
    $c= $c . '        //alert("�������");' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . 'function GetIDHTML(Root){' . vbCrlf();
    $c= $c . '    alert(document.all[Root].innerHTML)' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();
    $createAjax= $c;
    return @$createAjax;
}
//JS���߱༭
function onLineEditJS(){
    $c ='';
    $c= $c . '<script language="javascript">' . vbCrlf();
    $c= $c . '//��ʾ��༭���ݣ������޸ģ�ASP����������� ������2013,10,5' . vbCrlf();
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
    $c= $c . '            document.all[Root].innerHTML="<textarea name=TEXT"+Root+" style=\'width:50%;height:50%\' onblur=if(this.value!=\'\'){document.all."+Root+".title=\'����ɱ༭\';document.all."+Root+".innerHTML=ReplaceNToBR(this.value)}else{document.all."+Root+".innerHTML=\'&nbsp;\'};>" + TempContent + "</textarea>";' . vbCrlf();
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
//���߱༭
function editTXT($content, $jsId){
    $content= IIF($content== '', '&nbsp;', $content);
    $editTXT= '<span id=\'' . $jsId . '\' onClick="TestInput(\'' . $jsId . '\');" title=\'����ɱ༭\'>' . $content . '</span>';
    return @$editTXT;
}
//���߱༭  (����)
function onLineEdit($content, $jsId){
    $onLineEdit= editTXT($content, $jsId);
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
    if( $title== '' ){ $title= '��ӳɹ�' ;}
    if( $setTime== '' ){ $setTime= 4 ;}//Ĭ��Ϊ4��
    $c= $c . '<script>' . vbCrlf();
    $c= $c . '//ͨ�ö�ʱ�� �磺MyTimer(\'Show\', \'alert(1+1)\', 5)' . vbCrlf();
    $c= $c . 'var StopTimer = ""' . vbCrlf();
    $c= $c . 'function MyTimer(ID, ActionStr,TimeNumb){' . vbCrlf();
    $c= $c . '    if(StopTimer == "ֹͣ" || StopTimer == "ֹͣ��ʱ��"){' . vbCrlf();
    $c= $c . '        StopTimer = ""' . vbCrlf();
    $c= $c . '        return false' . vbCrlf();
    $c= $c . '    }' . vbCrlf();
    $c= $c . '    TimeNumb--' . vbCrlf();
    $c= $c . '    document.all[ID].innerHTML = "����ʱ��" + TimeNumb' . vbCrlf();
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

//JSͼƬ����
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
//ͼƬ����������ݲ��ã�
function photoLeftScroll($demo, $demo1, $demo2){
    $c ='';
    $c= $c . '<!--ͼƬ�����ַ�����-->' . vbCrlf();
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