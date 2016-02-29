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
//格式化20150212


//Html格式化 简单版 加强于2014 12 09，20150709
function htmlFormatting($content){
    $htmlFormatting = HandleHtmlFormatting($content, false, 0, '') ;
    return @$htmlFormatting;
}
//处理格式化
function handleHtmlFormatting( $content, $isMsgBox, $nErrLevel, $action){
    $splStr=''; $s=''; $tempS=''; $lCaseS=''; $c=''; $left4Str=''; $left5Str=''; $left6Str=''; $left7Str=''; $left8Str='';
    $nLevel ='';//级别
    $elseS='';$elseLable='';

    $levelArray=array(299); $keyWord ='';
    $lableName ='';//标签名称
    $isJavascript ='';//为javascript
    $isTextarea ='';//为表单文本域<textarea
    $isPre																		='';//为pre
    $isJavascript = false ;//默认javascript为假
    $isTextarea = false ;//表单文件域为假
    $isPre=false																		;//默认pre为假
    $nLevel = 0 ;//级别数

    $action = '|' . $action . '|' ;//动作
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        $tempS = $s;$elseS=$s;
        $s = TrimVbCrlf($s) ; $lCaseS = LCase($s) ;
        //判断于20150710
        if((substr($lCaseS, 0 , 8) == '<script ' || substr($lCaseS, 0 , 8) == '<script>') && instr($s, '</script>') == false && $isJavascript == false ){
            $isJavascript = true ;
            $c = $c . phptrim($tempS) . "\n" ;
        }else if( $isJavascript == true ){

            if( substr($lCaseS, 0 , 9) == '</script>' ){
                $isJavascript = false ;
                $c = $c . phptrim($tempS) . "\n" ;//最后清除两边空格
            }else{
                $c = $c . $tempS . "\n" ;//为js则显示原文本  不处理清空两边空格phptrim(tempS)
            }

            //表单文本域判断于20151019
        }else if((substr($lCaseS, 0 , 10) == '<textarea ' || substr($lCaseS, 0 , 10) == '<textarea>') && instr($s, '</textarea>') == false && $isTextarea == false ){
            $isTextarea = true ;
            $c = $c . phptrim($tempS) . "\n" ;
        }else if( $isTextarea == true ){
            $c = $c . phptrim($tempS) . "\n" ;
            if( substr($lCaseS, 0 , 11) == '</textarea>' ){
                $isTextarea = false ;
            }
            //表单文本域判断于20151019
        }else if((substr($lCaseS, 0 , 5) == '<pre ' || substr($lCaseS, 0 , 5) == '<pre>') && instr($s, '</pre>') == false && $isPre == false ){
            $isPre = true ;
            $c = $c . phptrim($tempS) . "\n" ;
        }else if( $isPre == true ){
            $c = $c . $tempS . "\n" ;
            if( substr($lCaseS, 0 , 6) == '</pre>' ){
                $isPre = false ;
            }


        }else if( $s <> '' && $isJavascript == false && $isTextarea == false ){
            $left4Str = '|' . substr($lCaseS, 0 , 4) . '|' ; $left5Str = '|' . substr($lCaseS, 0 , 5) . '|' ; $left6Str = '|' . substr($lCaseS, 0 , 6) . '|' ;
            $left7Str = '|' . substr($lCaseS, 0 , 7) . '|' ; $left8Str = '|' . substr($lCaseS, 0 , 8) . '|' ;

            $keyWord = '' ;//关键词初始清空
            $lableName = '' ;//标签名称
            if( instr('|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |', $left4Str) > 0 ){
                $keyWord = $left4Str ;
                $lableName = mid($left4Str, 3, 2) ;
            }else if( instr('|<div>|<div |', $left5Str) > 0 ){
                $keyWord = $left5Str ;
                $lableName = mid($left5Str, 3, 3) ;
            }else if( instr('|<span>|<span |<form>|<form |', $left6Str) > 0 ){
                $keyWord = $left6Str ;
                $lableName = mid($left6Str, 3, 4) ;

            }else if( instr('|<table>|<table |<tbody>|<tbody |', $left7Str) > 0 ){
                $keyWord = $left7Str ;
                $lableName = mid($left7Str, 3, 5) ;

            }else if( instr('|<center>|<center |', $left8Str) > 0 ){
                $keyWord = $left8Str ;
                $lableName = mid($left8Str, 3, 6);
            }
            $keyWord = AspTrim(Replace(Replace($keyWord, '<', ''), '>', '')) ;
            //call echo(KeyWord,lableName)
            //开始
            if( $keyWord <> '' ){
                $s = CopyStr('    ', $nLevel) . $s ;
                if( substr($lCaseS, - 3 + strlen($lableName)) <> '</' . $lableName . '>' && instr($lCaseS, '</' . $lableName . '>') == false ){
                    $nLevel = $nLevel + 1 ;
                    if( $nLevel >= 0 ){
                        $levelArray[$nLevel] = $keyWord ;
                    }
                }
            }else if( instr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|', '|' . substr($lCaseS, 0 , 5) . '|') > 0 || instr('|</div>|', '|' . substr($lCaseS, 0 , 6) . '|') > 0 || instr('|</span>|</form>|', '|' . substr($lCaseS, 0 , 7) . '|') > 0 || instr('|</table>|</tbody>|', '|' . substr($lCaseS, 0 , 8) . '|') > 0 || instr('|</center>|', '|' . substr($lCaseS, 0 , 9) . '|') > 0 ){
                $nLevel = $nLevel - 1 ;
                $s = CopyStr('    ', $nLevel) . $s ;
            }else{
                $s = CopyStr('    ', $nLevel) . $s ;
                //最后是结束标签则减一级
                if( substr($lCaseS, - 6) == '</div>' ){
                    if( checkHtmlFormatting($lCaseS) == false ){
                        $s = substr($s, 0 , strlen($s) - 6) ;
                        $nLevel = $nLevel - 1 ;
                        $s = $s . "\n" . CopyStr('    ', $nLevel) . '</div>' ;
                    }
                }else if( substr($lCaseS, - 7) == '</span>' ){
                    if( checkHtmlFormatting($lCaseS) == false ){
                        $s = substr($s, 0 , strlen($s) - 7) ;
                        $nLevel = $nLevel - 1 ;
                        $s = $s . "\n" . CopyStr('    ', $nLevel) . '</span>' ;
                    }
                }else if( instr('|</ul>|</dt>|<dl>|<dd>|', $left5Str) > 0 ){
                    $s = substr($s, 0 , strlen($s) - 5) ;
                    $nLevel = $nLevel - 1 ;
                    $s = $s . "\n" . CopyStr('    ', $nLevel) . substr($lCaseS, - 5) ;
                }


                //对   aaa</li>   这种进处理   20160106
                $elseS=phptrim(lcase($elseS));
                if( instr($elseS,'</')>0 ){
                    $elseLable=mid($elseS,instr($elseS,'</'),-1);
                    if( instr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|', '|' . $elseLable . '|') > 0 && $nLevel>0 ){
                        $nLevel = $nLevel - 1 ;
                    }
                }
                //call echo("s",replace(s,"<","&lt;"))


            }
            //call echo("",ShowHtml(temps)
            $c = $c . $s . "\n" ;
        }else if( $s == '' ){
            if( instr($action, '|delblankline|') == false && instr($action, '|删除空行|') == false ){//删除空行
                $c = $c . "\n" ;
            }
        }
    }
    $handleHtmlFormatting = $c ;
    $nErrLevel = $nLevel ;//获得错误级别
    if( $nLevel <> 0 &&(LCase($isMsgBox) == '1' || LCase($isMsgBox) == 'true') ){
        ASPEcho('HTML标签有错误', $nLevel) ;
    }
    //Call Echo("nLevel",nLevel & "," & levelArray(nLevel))                '显示错误标题20150212
    return @$handleHtmlFormatting;
}


//检测HTML标签是否成对出现 如（<div><ul><li>aa</li></ul></div></div>）
function checkHtmlFormatting( $content){
    $splStr=''; $s=''; $c=''; $splxx=''; $nLable=''; $lableStr ='';
    $content = LCase($content) ;
    $splStr = aspSplit('ul|li|dt|dd|dl|div|span', '|') ;
    foreach( $splStr as $s){
        $s = phptrim($s) ;
        if( $s <> '' ){
            $nLable = 0 ;
            $lableStr = '<' . $s . ' ' ;
            if( instr($content, $lableStr) > 0 ){
                $splxx = aspSplit($content, $lableStr) ;
                $nLable = $nLable + UBound($splxx) ;
            }
            $lableStr = '<' . $s . '>' ;
            if( instr($content, $lableStr) > 0 ){
                $splxx = aspSplit($content, $lableStr) ;
                $nLable = $nLable + UBound($splxx) ;
            }
            $lableStr = '</' . $s . '>' ;
            if( instr($content, $lableStr) > 0 ){
                $splxx = aspSplit($content, $lableStr) ;
                $nLable = $nLable - UBound($splxx) ;
            }
            //call echo(ShowHtml(lableStr),nLable)
            if( $nLable <> 0 ){
                $checkHtmlFormatting = false ;
                return @$checkHtmlFormatting;
            }
        }
    }
    $checkHtmlFormatting = true ;
    return @$checkHtmlFormatting;
}

?>