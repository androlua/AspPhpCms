<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-24
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By 云端 
************************************************************/
?>
<?PHP
//输出内容(2014,03,28)

//愿意显示内容
function printPre($content){
    $content = Replace($content, '<', '&lt;') ;
    $printPre = '<pre>' . $content . '</pre>' ;
    return @$printPre;
}

//作者信息
function authorInfo($FileInfo){
    $c ='';
    $c = '\'************************************************************' . "\n" ;
    if( $FileInfo <> '' ){ $c = $c . '\'  文件：' . $FileInfo . "\n" ;}
    $c = $c . '\'  作者：云端' . "\n" ;
    $c = $c . '\'  版权：源代码公开，各种用途均可免费使用。' . "\n" ;
    $c = $c . '\'  创建：' . Format_Time(Now(), 2) . "\n" ;
    $c = $c . '\'  联系：QQ313801120  交流群35915100    邮箱313801120@qq.com' . "\n" ;
    $c = $c . '\'                                       Powered By 云端 ' . "\n" ;
    $c = $c . '\'************************************************************' . "\n" ;
    $authorInfo = $c ;
    return @$authorInfo;
}
function authorInfo2(){
    $c ='';
    $c = '                \'\'\'' . "\n" ;
    $c = $c . '               (0 0)' . "\n" ;
    $c = $c . '   +-----oOO----(_)------------+' . "\n" ;
    $c = $c . '   |                           |' . "\n" ;
    $c = $c . '   |    让我们一起来体验       |' . "\n" ;
    $c = $c . '   |    QQ:313801120           |' . "\n" ;
    $c = $c . '   |                           |' . "\n" ;
    $c = $c . '   +------------------oOO------+' . "\n" ;
    $c = $c . '              |__|__|' . "\n" ;
    $c = $c . '               || ||' . "\n" ;
    $c = $c . '              ooO Ooo' . "\n" ;

    $authorInfo2 = $c ;
    return @$authorInfo2;
}
//折叠菜单
function foldingMenu($id, $s, $msg){
    //On Error Resume Next
    $nRnd=''; $c ='';
    if( $id == '' ){

        $nRnd = CLng(rnd() * 29252888) ;
    }else{
        $nRnd = $id ;
    }
    $c = '<div style="width:100%; font-size:12px;;line-height:150%;margin-bottom:4px;">' ;
    $c = $c . '  <label onClick="ERRORDIV' . $nRnd . '.style.display=(ERRORDIV' . $nRnd . '.style.display==\'none\'?\'\':\'none\')">' ;
    $c = $c . '  <span style="background-color:#666;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer">〖 ' . $s . ' 〗</span><br />' ;
    $c = $c . '  </label>' ;
    $c = $c . '  <div id="ERRORDIV' . $nRnd . '" style="width:100%;border:1px solid #820222;padding:5px;overflow:hidden;display:none;">' ;
    $c = $c . $msg ;
    $c = $c . '  </div>' ;
    $c = $c . '</div>' ;
    $foldingMenu = $c ;
    return @$foldingMenu;
}
//返回标题红色
function returnRen($Lable, $msg){
    $returnRen = '<font color=red>' . $Lable . '</font>：' . $msg ;
    return @$returnRen;
}
//返回Hr
function returnHr(){
    $returnHr = '<hr size=\'1\' color=\'#666666\'> ' ;
    return @$returnHr;
}
//返回Hr
function returnRenHr(){
    $returnRenHr = '<hr size=\'1\' color=\'red\'> ' ;
    return @$returnRenHr;
}
//处理错误信息 第二种
function showErr( $ErrCode, $ErrDesc){
    $c ='';
    $c = '<style>.ab-showerr{width:400px;font-size:12px;font-family:Consolas;margin:10px auto;padding:0;background-color:#FFF;}' ;
    $c = $c . '.ab-showerr h3,.ab-showerr h4{font-size:12px;margin:0;line-height:24px;text-align:center;background-color:#999;border:1px solid #555;color:#FFF;border-bottom:none;}.ab-showerr h4{padding:5px;line-height:1.5em;text-align:left;background-color:#FFC;color:#000; font-weight:normal;}' ;
    $c = $c . '.ab-showerr h4 strong{color:red;}.ab-showerr table{width:100%;margin:0;padding:0;border-collapse:collapse;border:1px solid #555;border-bottom:none;}.ab-showerr th{background-color:#EEE;white-space:nowrap;}.ab-showerr thead th{background-color:#CCC;}.ab-showerr th,.ab-showerr td{font-size:12px;border:1px solid #999;padding:6px;line-height:20px;word-break:break-all;}.ab-showerr span.info{color:#F30;}</style>' ;
    $c = $c . '<div class="ab-showerr"><h3>Microsoft VBScript 编译器错误</h3><h4>程序出错了，错误代码： <strong>' . $ErrCode . '</strong> ，以下是错误描述：</h4><table><tr><td>' . $ErrDesc . '</td></tr></table></div>' ;
    echo($c) ; die() ;
}

//打印Form表单转送的值，方便写程序  因为它不能与VB软件共存  从Print.Asp引用过来
function printFormInfo(){ //留空函数
}


//DedeCms回显样式 20150113
function dedeCMSMsg(){
    $c ='';
    $c = '<style> ' . "\n" ;
    $c = $c . '.msgbox {' . "\n" ;
    $c = $c . '    width: 450px;' . "\n" ;
    $c = $c . '    border: 1px solid #DADADA;' . "\n" ;
    $c = $c . '    margin:0 auto;' . "\n" ;
    $c = $c . '    margin-top:20px;' . "\n" ;
    $c = $c . '    line-height:20px;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.msgbox .ptitle{' . "\n" ;
    $c = $c . '    padding: 6px;' . "\n" ;
    $c = $c . '    font-size: 12px;' . "\n" ;
    $c = $c . '    border-bottom: 1px solid #DADADA;' . "\n" ;
    $c = $c . '    background: #DBEEBD url(/plus/img/wbg.gif);' . "\n" ;
    $c = $c . '    font-weight:bold;' . "\n" ;
    $c = $c . '    text-align:center;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.msgbox .pcontent{' . "\n" ;
    $c = $c . '    height: 100px;' . "\n" ;
    $c = $c . '    font-size: 10pt;' . "\n" ;
    $c = $c . '    background: #ffffff;' . "\n" ;
    $c = $c . '    text-align:center;' . "\n" ;
    $c = $c . '    padding-top:30px;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</style> ' . "\n" ;
    $c = $c . '<div class="msgbox">' . "\n" ;
    $c = $c . '    <div class="ptitle">提示信息！</div>' . "\n" ;
    $c = $c . '    <div class="pcontent">' . "\n" ;
    $c = $c . '        成功登录，正在转向管理管理主页！<br>' . "\n" ;
    $c = $c . '        <a href="#">如果你的浏览器没反应，请点击这里...</a>' . "\n" ;
    $c = $c . '' . "\n" ;
    $c = $c . '    </div>' . "\n" ;
    $c = $c . '</div>' . "\n" ;
    $dedeCMSMsg = $c ;
    return @$dedeCMSMsg;
}
?>

