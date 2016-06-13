<?PHP
//常用函数大全 (2013,9,27Option Explicit)

//成功永远都是缓慢的 2013,10,4,悟

//显示弹窗对话框20150312
function msgBox( $content){
    $content= Replace(Replace($content, Chr(10), '\\n'), Chr(13), '\\n');
    echo('<script>alert(\'' . $content . '\');</script>');
}
//提示20150729
function MBInfo($title, $content){ //留空函数
}
//给Queststring赋值
function addRq($GookeName, $valueStr){
    @$_GET[$GookeName]= $valueStr;
}
//获得Cookies值
function rc($GookeName){
    $rc= @$_COOKIE[$GookeName];
    return @$rc;
}
//给Cookies赋值
function addRc($GookeName, $valueStr, $DateStr){
    @$_COOKIE[$GookeName]= $valueStr;
    if( $DateStr <> '' ){ @$_COOKIE[$GookeName]= $DateStr ;}
}
//ASP自带的跳转

//替换Request.Form对象
function rf($str){
    $rf= @$_POST[$str];
    return @$rf;
}

//获得传值
function rq($str){
    $rq= @$_GET[$str];
    return @$rq;
}
//获得传值
function rfq($str){
    $rfq= @$_REQUEST[$str];
    return @$rfq;
}
//替换Response.Write对象
function rw($str){
    echo($str);
}
//输出内容加换行
function rwBr($str){
    echo($str . vbCrlf());
}
//替换Response.Write对象 + Response.End()
function rwEnd($str){
    echo($str);
    die();
}
//HTML结束
function htmEnd($str){
    RwEnd($str);
}
//替换Response.Write对象+Response.End()
function PHPDie($str){
    echo($str);
    die();
}
//替换Response.Write对象
function debug($str){
    echo('<div  style="border:solid 1px #000000;margin-bottom:2px;">调试' . $str . '</div>' . vbCrlf());
}
//跟踪
function FlashTrace($str){
    $FlashTrace= debug($str);
    return @$FlashTrace;
}
//测试显示信息
function ASPEcho($Word, $str){
    echoPrompt($Word, $str);
}
//测试显示信息+红色
function echoRed($Word, $str){
    echo('<font color=Red>' . $Word . '</font>：' . $str . '<br>');
}
//测试显示信息+红色+粗
function echoRedB($Word, $str){
    echo('<b><font color=Red>' . $Word . '</font>：' . $str . '</b><br>');
}
//回显内容
function echoPrompt($Word, $str){
    echo('<font color=Green>' . $Word . '</font>：' . $str . '<br>');
}
//回显内容
function echoStr($Word, $str){
    echoPrompt($Word, $str);
}
//打印数组 打印PHP里用到
function PHPPrint_R($content){
    $i=''; $c ='';
    if( gettype($content)== 'Variant()' ){
        for( $i= 0 ; $i<= UBound($content); $i++){
            $c= $c . '[' . $i . '] => ' . $content[$i] . vbCrlf();
        }
    }else{
        $c= $content;
    }
    echo($c);
}
//测试显示信息 颜色
function setColorEcho($color, $Word, $str){
    echo('<font color=' . $color . '>' . $Word . '</font>：' . $str . '<br>');
}
//测试显示信息暂停
function eerr($Word, $str){
    //Response.Write(TypeName(Word) & "-" & TypeName(Str)):Response.End()
    echo('<font color=red>' . $Word . '</font>：' . $str);
    die();
}
//立即回显内容
function doEvents(){
    PHPFlush();
}
//功能:ASP里的IIF 如：IIf(1 = 2, "a", "b")

//Hr
function HR(){
    echo('<hr size=\'1\' color=\'#666666\'> ');
}
//BR 20160517
function BR(){
    echo('<br/>');
}

//输出字符串 引用别人20141217
//Public Sub Echo(ByVal s) : Response.Write(s) : End Sub
//输出字符串和一个换行符
function PHPPrint( $s){
    echo($s . vbCrlf()) ; PHPFlush();
}
//输出字符串和一个html换行符
function println( $s){
    echo($s . '<br />' . vbCrlf()) ; PHPFlush();
}
//输出字符串并将HTML标签转为普通字符
function printHtml( $s){
    echo(displayHtml($s) . vbCrlf());
}
function printlnHtml( $s){
    echo(displayHtml($s) . '<br />') . vbCrlf();
}
//将任意变量直接输出为字符串(Json格式)
//Public Sub PrintString(ByVal s) : Response.Write(Str.ToString(s) & VbCrLf) : End Sub
//Public Sub PrintlnString(ByVal s) : Response.Write(Str.ToString(s)) & "<br />" & VbCrLf : End Sub
//输出经过格式化的字符串
//Public Sub PrintFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & VbCrLf : End Sub
//Public Sub PrintlnFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & "<br />" & VbCrLf : End Sub
//输出字符串并终止程序运行
function printEnd( $s){
    echo($s) ; die();
}




//判断是否一样，一样返回checked,否者返回空值
function isChecked( $str, $str2){
    if( $str== $str2 ){ $isChecked= 'checked=\'checked\'' ;}else{ $isChecked== '' ;}
    return @$isChecked;
}
//判断是否一样，一样返回selected,否者返回空值
function isSelected( $str, $str2){
    if( $str== $str2 ){ $isSelected= 'selected=\'selected\'' ;}else{ $isSelected== '' ;}
    return @$isSelected;
}


function doError($s, $msg){
    //On Error Resume Next
    $nRnd=''; $c ='';

    $nRnd= intval(rnd() * 29252888);
    $c= '<br />';
    $c= $c . '<div style="width:100%; font-size:12px;;line-height:150%">';
    $c= $c . '  <label onClick="ERRORDIV' . $nRnd . '.style.display=(ERRORDIV' . $nRnd . '.style.display==\'none\'?\'\':\'none\')">';
    $c= $c . '  <span style="background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer">〖 出错 提示信息 ERROR 〗</span><br />';
    $c= $c . '  </label>';
    $c= $c . '  <div id="ERRORDIV' . $nRnd . '" style="width:100%;border:1px solid #820222;padding:5px;overflow:hidden;">';
    $c= $c . ' <span style="color:#FF0000;">出错描述</span> ' . $s . '<br />';
    $c= $c . ' <span style="color:#FF0000;">回显信息</span> ' . $msg . '<br />';
    $c= $c . '  </div>';
    $c= $c . '</div>';
    $c= $c . '<br />';
    echo($c);
    die(); //终止，程序停止
}

//执行ASP脚本
function PHPExec( $tStr){
    if( $tStr== '' ){ return '';  }

    Execute($tStr);

}

?>