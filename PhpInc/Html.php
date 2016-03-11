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
//Html 处理HTML代码 (2014,1,3)
//显示HTML结构        call rw(displayHTmL("<br>aasdfds<br>"))
//关闭显示HTML结构   call rwend(unDisplayHtml("&lt;br&gt;aasdfds&lt;br&gt;"))

//显示HTML结构
function displayHtml($str){
    $str = Replace($str, '<', '&lt;') ;
    $str = Replace($str, '>', '&gt;') ;
    $displayHtml = $str ;
    return @$displayHtml;
}
//关闭显示HTML结构
function unDisplayHtml($str){
    $str = Replace($str, '&lt;', '<') ;
    $str = Replace($str, '&gt;', '>') ;
    $unDisplayHtml = $str ;
    return @$unDisplayHtml;
}

//处理闭合HTML标签(20150902)  比上面的更好用 第二种
function handleCloseHtml($content, $ImgAddAlt, $action){
    $i=''; $endStr=''; $s=''; $s2=''; $c=''; $labelName=''; $startLabel=''; $endLabel ='';
    $action = '|' . $action . '|' ;
    $startLabel = '<' ;
    $endLabel = '>' ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $endStr = mid($content, $i,-1) ;
        if( $s == '<' ){
            if( instr($endStr, '>') > 0 ){
                $s = mid($endStr, 1, instr($endStr, '>')) ;
                $i = $i + strlen($s) - 1 ;
                $s = mid($s, 2, strlen($s) - 2) ;
                $s = phptrim($s) ;
                if( substr($s, - 1) == '/' ){
                    $s = phptrim(substr($s, 0 , strlen($s) - 1)) ;
                }
                $endStr = substr($endStr, - strlen($endStr) - strlen($s) - 2) ;//最后字符减去当前标签  -2是因为它有<>二个字符
                //注意之前放在labelName下面
                $labelName = mid($s, 1, instr($s . ' ', ' ') - 1) ;
                $labelName = LCase($labelName) ;
                //call eerr("s",s)

                if( instr($action, '|处理A链接|') > 0 ){
                    $s = handleHtmlAHref($s, $labelName, 'http://127.0.0.1/TestWeb/Web/', '处理A链接') ;//处理干净html标签
                }else if( instr($action, '|处理A链接第二种|') > 0 ){
                    $s = handleHtmlAHref($s, $labelName, 'http://127.0.0.1/debugRemoteWeb.asp?url=', '处理A链接') ;//处理干净html标签
                }

                //call echo(s,labelName)   param与embed是Flash用到，不过embed有结束标签的
                if( instr('|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|', '|' . $labelName . '|') > 0 ){
                    $s = Replace(Replace(Replace(Replace($s, ' class=""', ''), ' alt=""', ''), ' title=""', ''), ' name=""', '') ;//临时这么做一下，以后要完整系统的做
                    $s = Replace(Replace(Replace(Replace($s, ' class=\'\'', ''), ' alt=\'\'', ''), ' title=\'\'', ''), ' name=\'\'', '') ;
                    //给vb.net软件用的 要不然它会报错，晕
                    if( $labelName == 'img' && $ImgAddAlt == true ){
                        if( instr($s, ' alt') == false ){
                            $s = $s . ' alt=""' ;
                        }
                        $s = AspTrim($s) ;
                        $s = $s . ' /' ;
                        //补齐<script>20160106  暂时不能用这个，等改进
                    }else if( $labelName == 'script' ){
                        if( instr($s, ' type') == false ){
                            $s = $s . ' type="text/javascript"' ;
                        }
                    }
                }
                $s = $startLabel . $s . $endLabel ;
                //处理javascript script部分
                if( $labelName == 'script' ){
                    $s2 = mid($endStr, 1, instr($endStr, '</script>') + 8) ;

                    //call eerr("",s2)
                    $i = $i + strlen($s2) ;
                    $s = $s . $s2 ;
                }
                //call echo("s",replace(s,"<","&lt;"))
            }
        }
        $c = $c . $s ;
    }
    $handleCloseHtml = $c ;
    return @$handleCloseHtml;
}
//处理htmlA标签的Href链接  配合上面函数
function handleHtmlAHref( $content, $labelName, $addToHttpUrl, $action){
    $i=''; $s=''; $c=''; $temp ='';
    $isValue ='';//是否为内容值
    $valueStr ='';//存储内容值
    $yinghaoLabel ='';//引号类型如'"
    $parentName ='';//参数名称
    $behindStr ='';//后面全部字符
    $noDanYinShuangYinStr ='';//不是单引号和双引号字符
    $action = '|' . $action . '|' ;
    $content = Replace($content . ' ', "\t", ' ') ;//退格替换成空格，最后加一个空格，方便计算
    $content = Replace(Replace($content, ' =', '='), ' =', '=') ;
    $isValue = false ;//默认内容为假，因为先是获得标签名称
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;//获得当前一个字符
        $behindStr = mid($content, $i,-1) ;//后面字符
        if( $s == '=' && $isValue == false ){ //不是内容值，并为=号
            $isValue = true ;
            $valueStr = '' ;
            $yinghaoLabel = '' ;
            if( $c <> '' && substr($c, - 1) <> ' ' ){ $c = $c . ' ' ;}
            $parentName = LCase($temp) ;//参数名称转小写
            $c = $c . $parentName . $s ;
            $temp = '' ;
            //获得值第一个字符，因为它是引号类型
        }else if( $isValue == true && $yinghaoLabel == '' ){
            if( $s <> ' ' ){
                if( $s <> '\'' && $s <> '"' ){
                    $noDanYinShuangYinStr = $s ;//不是单引号和双引号字符
                    $s = ' ' ;
                }
                $yinghaoLabel = $s ;
                //call echo("yinghaoLabel",yinghaoLabel)
            }
        }else if( $isValue == true && $yinghaoLabel <> '' ){
            //为引号结束
            if( $yinghaoLabel == $s ){
                $isValue = false ;
                if( $labelName == 'a' && $parentName == 'href' && instr($action, '|处理A链接|') > 0 ){
                    //处理
                    if( instr($valueStr, '?') > 0 ){
                        $valueStr = Replace($valueStr, '?', 'WenHao') . '.html' ;
                    }
                    if( instr('|asp|php|aspx|jsp|', '|' . LCase(mid($valueStr, strrpos($valueStr, '.') + 1,-1)) . '|') > 0 ){
                        $valueStr = $valueStr . '.html' ;
                    }
                    $valueStr = addToOrAddHttpUrl($addToHttpUrl, $valueStr, '替换') ;

                }
                //call echo("labelName",labelName)
                if( $yinghaoLabel == ' ' ){
                    $c = $c . '"' . $noDanYinShuangYinStr . $valueStr . '" ' ;//追加 不是单引号和双引号字符            补全
                }else{
                    $c = $c . $yinghaoLabel . $valueStr . $yinghaoLabel ;//追加 不是单引号和双引号字符
                }
                $yinghaoLabel = '' ;
                $noDanYinShuangYinStr = '' ;//不是单引号和双引号字符 清空
            }else{
                $valueStr = $valueStr . $s ;
            }
            //为 分割
        }else if( $s == ' ' ){
            //暂存内容不为空
            if( $temp <> '' ){
                if( substr(AspTrim($behindStr) . ' ', 0 , 1) == '=' ){
                    //后面一个字符等于=不处理
                }else{
                    //为标签
                    if( $isValue == false ){
                        $temp = LCase($temp) . ' ' ;//标签类型名称转小写
                    }
                    $c = $c . $temp ;
                    $temp = '' ;
                }
            }
        }else{
            $temp = $temp . $s ;
        }

    }
    $c = AspTrim($c) ;
    $handleHtmlAHref = $c ;
    return @$handleHtmlAHref;
}
//追加或替换网址(20150922) 配合上面   addToOrAddHttpUrl("http://127.0.0.1/aa/","http://127.0.0.1/4.asp","替换") = http://127.0.0.1/aa/4.asp
function addToOrAddHttpUrl($httpUrl, $url, $action){
    $s ='';
    $action = '|' . $action . '|' ;
    if( instr($action, '|替换|') > 0 ){
        $s = getwebsite($url) ;
        if( $s <> '' ){
            $url = Replace($url, $s, '') ;
        }
    }
    if( instr($url, $httpUrl) == false ){
        if( substr($httpUrl, - 1) == '/' &&(substr($url, 0 , 1) == '/' || substr($url, 0 , 1) == '\\') ){
            $url = mid($url, 2,-1) ;
        }
        $url = $httpUrl . $url ;
    }

    $addToOrAddHttpUrl = $url ;
    return @$addToOrAddHttpUrl;
}

//获得HTML标签名 call rwend(getHtmlLableName("<img src><a href=>",0))    输入  img
function getHtmlLableName($content, $nThisLabel){
    $i=''; $endStr=''; $s=''; $c=''; $labelName=''; $nLabelCount ='';
    $nLabelCount = 0 ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $endStr = mid($content, $i,-1) ;
        if( $s == '<' ){
            if( instr($endStr, '>') > 0 ){
                $s = mid($endStr, 1, instr($endStr, '>')) ;
                $i = $i + strlen($s) - 1 ;
                $s = mid($s, 2, strlen($s) - 2) ;
                $s = phptrim($s) ;
                if( substr($s, - 1) == '/' ){
                    $s = phptrim(substr($s, 0 , strlen($s) - 1)) ;
                }
                $endStr = substr($endStr, - strlen($endStr) - strlen($s) - 2) ;//最后字符减去当前标签  -2是因为它有<>二个字符
                //注意之前放在labelName下面
                $labelName = mid($s, 1, instr($s . ' ', ' ') - 1) ;
                $labelName = LCase($labelName) ;
                if( $nThisLabel == $nLabelCount ){
                    break;
                }
                $nLabelCount = $nLabelCount + 1 ;
            }
        }
        $c = $c . $s ;
    }
    $getHtmlLableName = $labelName ;
    return @$getHtmlLableName;
}

//删除html里空行 最笨的方法 删除空行
function removeBlankLines($content){
    $s=''; $c=''; $splStr ='';
    $splStr = aspSplit($content, vbCrlf()) ;
    foreach( $splStr as $s){
        if( Replace(Replace($s, "\t", ''), ' ', '') <> '' ){
            if( $c <> '' ){ $c = $c . vbCrlf() ;}
            $c = $c . $s ;
        }
    }
    $removeBlankLines = $c ;
    return @$removeBlankLines;
}




?>