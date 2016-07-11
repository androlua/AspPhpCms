<?PHP
//Js

//Asp代码混淆处理 20160624
function jsCodeConfusion($content){
    $splStr=''; $i=''; $YesJs=''; $YesWord=''; $Sx=''; $s=''; $Wc=''; $Zc=''; $s1=''; $AspCode=''; $SYHCount=''; $UpWord ='';
    $UpWordn=''; $tempS=''; $DimList ='';
    $YesFunction ='';//函数是否为真
    $StartFunction ='';//开始函数 目的是为了让function default 处理函数后面没有()   20150218
    $StartFunction= false; //默认开始函数为假
    //If nType="" Then  nType  = 0
    $yesJs= false; //是ASP 默认为假
    $YesFunction= false; //是函数 默认为假
    $YesWord= false; //是单词 默认为假
    $SYHCount= 0; //双引号默认为0
    $splStr= aspSplit($content, vbCrlf()); //分割行
    $wcType ='';//输入文本类型，如 " 或 '
    $isAddToSYH ='';//是否累加双引号
    $beforeStr=''; $afterStr=''; $endCode='';$nSYHCount='';
    //循环分行
    foreach( $splStr as $key=>$s){
        //循环每个字符
        for( $i= 1 ; $i<= Len($s); $i++){
            $Sx= mid($s, $i, 1);
            //Asp开始
            if( $Sx== '<' && $Wc== '' ){ //输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if( mid($s, $i + 1, 6)== 'script' ){
                    $yesJs= true; //ASP为真
                    $i= $i + 1; //加1而不能加2，要不然<%function Test() 就截取不到
                    $Sx= mid($s, $i, 1);
                    $AspCode= $AspCode . '<';
                }
                //ASP结束
            }else if( $Sx== '<' && mid($s, $i + 1, 8)== '/script>' && $Wc== '' ){ //Wc为输出内容
                $yesJs= false; //ASP为假
                $i= $i + 1; //不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
                $Sx= mid($s, $i, 8);
                $AspCode= $AspCode . '/script>';
            }
            if( $yesJs== true ){

                $beforeStr= Right(Replace(mid($s, 1, $i - 1), ' ', ''), 1); //上一个字符
                $afterStr= Left(Replace(mid($s, $i + 1,-1), ' ', ''), 1); //下一个字符
                $endCode= mid($s, $i + 1,-1); //当前字符往后面代码 一行
                //输入文本
                if(($sx== '"' || $sx== '\'' && $wcType== '') || $sx== $wcType || $wc <> '' ){
                    $isAddToSYH= true;
                    //这是一种简单的方法，等完善(20150914)
                    if( $isAddToSYH== true && $beforeStr== '\\' ){

                        if( Len($wc) >=1 ){
                            if( isStrTransferred($wc)==true ){		//为转义字符为真
                                //call echo(wc,isStrTransferred(wc))
                                $isAddToSYH= false;
                            }
                        }else{
                            $isAddToSYH= false;
                        }
                        //call echo(wc,isAddToSYH)
                    }
                    if( $wc== '' ){
                        $wcType= $sx;
                    }

                    //双引号累加
                    if( $sx== $wcType && $isAddToSYH== true ){ $nSYHCount= $nSYHCount + 1 ;}//排除上一个字符为\这个转义字符(20150914)


                    //判断是否"在最后
                    if( $nSYHCount % 2== 0 && $beforeStr <> '\\' ){
                        if( mid($s, $i + 1, 1) <> $wcType ){
                            $wc= $wc . $sx;
                            $AspCode= $AspCode . $wc; //行代码累加
                            //call echo("wc",wc)
                            $nSYHCount= 0 ; $wc= ''; //清除
                            $wcType= '';
                        }else{
                            $wc= $wc . $sx;
                        }
                    }else{
                        $wc= $wc . $sx;
                    }

                }else if( $Sx== '\'' ){ //注释则退出
                    $AspCode= $AspCode . mid($s, $i,-1);
                    break;
                    //字母
                }else if( checkABC($Sx)== true ||($Sx== '_' && $Zc <> '') || $Zc <> '' ){
                    $Zc= $Zc . $Sx;
                    $s1= strtolower(mid($s . ' ', $i + 1, 1));
                    if( instr('abcdefghijklmnopqrstuvwxyz0123456789', $s1)== 0 && ($s1== '_' && $Zc <> '') ){//最简单判断
                        $tempS= mid($s, $i + 1,-1);

                        if( instr('|function|sub|', '|' . strtolower($Zc) . '|') ){
                            //函数开始
                            if( $YesFunction== false && strtolower($UpWord) <> 'end' ){
                                $YesFunction= true;
                                $DimList= getFunDimName($tempS);
                                $StartFunction= true;
                            }else if( $YesFunction== true && strtolower($UpWord)== 'end' ){ //获得上一个单词
                                $YesFunction= false;
                            }
                        }else if( $YesFunction== true && strtolower($Zc)== 'var' ){
                            $DimList= $DimList . ',' . getVarName($tempS);
                        }else if( $YesFunction== true ){
                            //排除函数后面每一个名称
                            if( $StartFunction== false ){
                                $Zc= replaceDim2($DimList, $Zc);
                            }
                            $StartFunction= false;
                        }
                        $UpWord= $Zc; //记住当前单词
                        $AspCode= $AspCode . $Zc;
                        $Zc= '';
                    }
                }else{
                    $AspCode= $AspCode . $Sx;
                }
            }else{
                $AspCode= $AspCode . $Sx;
            }
            doEvents( );
        }
        $AspCode= aspRTrim($AspCode); //去除右边空格
        $AspCode= $AspCode . vbCrlf(); //Asp换行
        doEvents( );
    }
    $jsCodeConfusion= $AspCode;
    return @$jsCodeConfusion;
}


//删除JS注释 20160602
function delJsNote($content){
    $splstr='';$s='';$c='';$isMultiLineNote='';$s2='';
    $isMultiLineNote=false;			//多行注释默认为假
    $splstr=aspSplit($content,vbCrlf());
    foreach( $splstr as $key=>$s){
        $s2=phptrim($s);
        if( $isMultiLineNote==true ){
            if( len($s2)>=2 ){
                if( right($s2,2)=='*/' ){
                    $isMultiLineNote=false;
                }
            }
            $s='';
        }else{
            if( left($s2,2)=='/*' ){
                if( right($s2,2)<>'*/' ){
                    $isMultiLineNote=true;
                }
                $s='';
            }else if( left($s2,2)=='//' ){
                $s='';
            }
        }
        $c=$c . $s . vbCrlf();
    }
    $delJsNote=$c;
    return @$delJsNote;
}

//JS转换，引用别人
function JsEncode__( $s){

    if( isNul($s) ){ $JsEncode__= '' ; return @$JsEncode__;}
    $arr1=''; $arr2=''; $i=''; $j=''; $c=''; $p=''; $t='';
    $arr1= array(chr(34),chr(92),chr(47),chr(8),chr(12),chr(10),chr(13),chr(9)); 		//34|",92|\,47|/,8|,12|,10| ,13| ,9|	,
    $arr2= array(chr(34),chr(92),chr(47),chr(98),chr(102),chr(110),chr(114)); 		//34|",92|\,47|/,98|b,102|f,110|n,114|r,1865|,
    for( $i= 1 ; $i<= Len($s); $i++){
        $p= true;
        $c= mid($s, $i, 1);
        for( $j= 0 ; $j<= Ubound($arr1); $j++){
            if( $c== $arr1[$j] ){
                $t= $t . '\\' . $arr2[$j];
                $p= false;
                break;
            }
        }
        if( $p ){ $t= $t . $c;}
    }
    $JsEncode__= $t;
    return @$JsEncode__;
}


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