<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//常用函数大全 (2013,9,27Option Explicit)

//成功永远都是缓慢的 2013,10,4,悟

//显示弹窗对话框20150312
function MsgBox( $Content){
    $Content=Replace(Replace($Content,Chr(10),'\\n'),Chr(13),'\\n');
    echo('<script>alert(\''. $Content .'\');</script>');
}
//提示20150729
function MBInfo($title,$content){	 //留空函数
}
//给Queststring赋值
function AddRq($GookeName,$ValueStr){
    @$_GET[$GookeName] = $ValueStr ;
}
//获得Cookies值
function Rc($GookeName){
    $Rc = @$_COOKIE[$GookeName];
    return @$Rc;
}
//给Cookies赋值
function AddRc($GookeName,$ValueStr,$DateStr){
    @$_COOKIE[$GookeName] = $ValueStr ;
    if( $DateStr<>'' ){ @$_COOKIE[$GookeName] = $DateStr;}
}
//ASP自带的跳转

//替换Request.Form对象
function Rf($Str){
    $Rf = @$_POST[$Str] ;
    return @$Rf;
}

//获得传值
function Rq($Str){
    $Rq = @$_GET[$Str];
    return @$Rq;
}
//获得传值
function Rfq($Str){
    $Rfq = @$_REQUEST[$Str];
    return @$Rfq;
}
//替换Response.Write对象
function Rw($Str){
    echo($Str);
}
//输出内容加换行
function RwBr($Str){
    echo($Str . vbCrlf()) ;
}
//替换Response.Write对象 + Response.End()
function RwEnd($Str){
    echo($Str);
    die();
}
//HTML结束
function HtmEnd($Str){
    RwEnd($Str);
}
//替换Response.Write对象+Response.End()
function PHPDie($Str){
    echo($Str);
    die();
}
//替换Response.Write对象
function Debug($Str){
    echo('<div  style="border:solid 1px #000000;margin-bottom:2px;">调试' . $Str . '</div>' . vbCrlf());
}
//跟踪
function FlashTrace($Str){
    $FlashTrace = Debug($Str);
    return @$FlashTrace;
}
//测试显示信息
function ASPEcho($Word, $Str){
    echoPrompt($Word, $Str);
}
//测试显示信息+红色
function EchoRed($Word, $Str){
    echo('<font color=Red>' . $Word . '</font>：' . $Str . '<br>');
}
//测试显示信息+红色+粗
function EchoRedB($Word, $Str){
    echo('<b><font color=Red>' . $Word . '</font>：' . $Str . '</b><br>');
}
//回显内容
function echoPrompt($Word, $Str){
    echo('<font color=Green>' . $Word . '</font>：' . $Str . '<br>');
}
//回显内容
function echoStr($Word, $Str){
    echoPrompt($Word, $Str);
}
//打印数组 打印PHP里用到
function PHPPrint_R($Content){
    $I='';$C='';
    if( TypeName($Content) == 'Variant()' ){
        for( $I=0 ; $I<= Ubound($Content); $I++){
            $C = $C . '['. $I .'] => ' . $Content[$I] . vbCrlf();
        }
    }else{
        $C = $Content;
    }
    echo($C);
}
//测试显示信息 颜色
function SetColorEcho($Color, $Word, $Str){
    echo('<font color='. $Color .'>' . $Word . '</font>：' . $Str . '<br>');
}
//测试显示信息暂停
function Eerr($Word, $Str){
    //	Response.Write(TypeName(Word) & "-" & TypeName(Str)):Response.End()
    echo('<font color=red>' . $Word . '</font>：' . $Str);
    die() ;
}
//立即回显内容
function DoEvents(){
    PHPFlush() ;
}
//功能:ASP里的IIF 如：IIf(1 = 2, "a", "b")

//Hr
function HR(){
    echo('<hr size=\'1\' color=\'#666666\'> ') ;
}

//输出字符串 引用别人20141217
//Public Sub Echo(ByVal s) : Response.Write(s) : End Sub
//输出字符串和一个换行符
function PHPPrint( $s){
    echo($s . vbCrlf()) ; PHPFlush();
}
//输出字符串和一个html换行符
function Println( $s){
    echo($s . '<br />' . vbCrlf()) ; PHPFlush();
}
//输出字符串并将HTML标签转为普通字符
function PrintHtml( $s){
    echo($GLOBALS['HtmlEncode'][$s] . vbCrlf());
}
function PrintlnHtml( $s){
    echo($GLOBALS['HtmlEncode'][$s] . '<br />') . vbCrlf();
}
//将任意变量直接输出为字符串(Json格式)
//Public Sub PrintString(ByVal s) : Response.Write(Str.ToString(s) & VbCrLf) : End Sub
//Public Sub PrintlnString(ByVal s) : Response.Write(Str.ToString(s)) & "<br />" & VbCrLf : End Sub
//输出经过格式化的字符串
//Public Sub PrintFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & VbCrLf : End Sub
//Public Sub PrintlnFormat(ByVal s, ByVal f) : Response.Write(Str.Format(s, f)) & "<br />" & VbCrLf : End Sub
//输出字符串并终止程序运行
function PrintEnd( $s){
    echo($s) ; die();
}




//判断是否一样，一样返回checked,否者返回空值
function IsChecked( $Str, $Str2){
    if( $Str == $Str2 ){ $IsChecked = 'checked=\'checked\'' ;}else{ $IsChecked == '' ;}
    return @$IsChecked;
}
//判断是否一样，一样返回selected,否者返回空值
function IsSelected( $Str, $Str2){
    if( $Str == $Str2 ){ $IsSelected = 'selected=\'selected\'' ;}else{ $IsSelected == '' ;}
    return @$IsSelected;
}


function DoError($S, $Msg){
    //On Error Resume Next
    $nRnd=''; $C ='';

    $nRnd = CLng(rnd() * 29252888) ;
    $C = '<br />' ;
    $C = $C . '<div style="width:100%; font-size:12px;;line-height:150%">' ;
    $C = $C . '  <label onClick="ERRORDIV' . $nRnd . '.style.display=(ERRORDIV' . $nRnd . '.style.display==\'none\'?\'\':\'none\')">' ;
    $C = $C . '  <span style="background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer">〖 出错 提示信息 ERROR 〗</span><br />' ;
    $C = $C . '  </label>' ;
    $C = $C . '  <div id="ERRORDIV' . $nRnd . '" style="width:100%;border:1px solid #820222;padding:5px;overflow:hidden;">' ;
    $C = $C . ' <span style="color:#FF0000;">出错描述</span> ' . $S . '<br />' ;
    $C = $C . ' <span style="color:#FF0000;">回显信息</span> ' . $Msg . '<br />' ;
    $C = $C . '  </div>' ;
    $C = $C . '</div>' ;
    $C = $C . '<br />' ;
    echo($C) ;
    die() ;//终止，程序停止
}

//执行ASP脚本
function PHPExec( $tStr){
    if( $tStr=='' ){ return ''; }

    Execute($tStr);

}

?>