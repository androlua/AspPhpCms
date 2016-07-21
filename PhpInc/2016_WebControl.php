<?PHP
//网站控制 20160223



//处理模块替换数组
function handleModuleReplaceArray( $content){
    $i=''; $startStr=''; $endStr=''; $s=''; $lableName ='';
    for( $i= 1 ; $i<= uBound($GLOBALS['ModuleReplaceArray']) - 1; $i++){
        if( $GLOBALS['ModuleReplaceArray'][$i][ 0]== '' ){
            break;
        }
        //call echo(ModuleReplaceArray(i,0),ModuleReplaceArray(0,i))
        $lableName= $GLOBALS['ModuleReplaceArray'][$i][ 0];
        $s= $GLOBALS['ModuleReplaceArray'][0][ $i];
        if( $lableName== '【删除】' ){
            $content= replace($content, $s, '');
        }else{
            $startStr= '<replacestrname ' . $lableName . '>' ; $endStr= '</replacestrname ' . $lableName . '>';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
                $content= replaceContentModule($content, $startStr, $endStr, $s, '');
            }
            $startStr= '<replacestrname ' . $lableName . '/>';
            if( inStr($content, $startStr) > 0 ){
                $content= replaceContentRowModule($content, '<replacestrname ' . $lableName . '/>', $s, '');
            }
        }
    }
    $handleModuleReplaceArray= $content;
    return @$handleModuleReplaceArray;
}

//去掉模板里不需要显示内容 删除模板中我的注释代码
function delTemplateMyNote($code){
    $startStr=''; $endStr=''; $i=''; $s=''; $handleNumb=''; $splStr=''; $Block=''; $id ='';
    $content=''; $DragSortCssStr=''; $DragSortStart=''; $DragSortEnd=''; $DragSortValue=''; $c ='';
    $lableName='';$lableStartStr='';$lableEndStr='';
    $handleNumb= 99; //这里定义很重要

    //加强版  对这个也可以<!--#aaa start#--><!--#aaa end#-->
    $startStr= '<!--#' ; $endStr= '#-->';
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $lableName= StrCut($code, $startStr, $endStr, 2);
            if( inStr($lableName,' start')>0 ){
                $lableName=mid($lableName,1,len($lableName)-6);
            }

            $s=$startStr . $lableName . $endStr;
            $lableStartStr=$startStr . $lableName . ' start' . $endStr;
            $lableEndStr=$startStr . $lableName . ' end' . $endStr;
            if( inStr($code, $lableStartStr) > 0 && inStr($code, $lableEndStr) > 0 ){
                $s= StrCut($code, $lableStartStr, $lableEndStr, 1);
                //call echo(">>",s)
            }
            $code=replace($code,$s,'');
            //call echo("s",s)
            //call echo("lableName",lableName)
            //call echo("lableStartStr",replace(lableStartStr,"<","&lt;"))
            //call echo("lableEndStr",replace(lableEndStr,"<","&lt;"))
        }else{
            break;
        }
    }



    //清除ReadBlockList读出块列表内容  不过有个不足的地方，读出内容可以从外部读出内容，这个以后考虑
    //Call Eerr("ReadBlockList",ReadBlockList)
    //写于20141118
    //splStr = Split(ReadBlockList, vbCrLf)                 '不用这种，复杂了
    //修改于20151230
    for( $i= 1 ; $i<= $handleNumb; $i++){
        $startStr= '<R#读出内容' ; $endStr= ' start#>';
        $Block= StrCut($code, $startStr, $endStr, 2);
        if( $Block <> '' ){
            $startStr= '<R#读出内容' . $Block . ' start#>' ; $endStr= '<R#读出内容' . $Block . ' end#>';
            if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
                $s= StrCut($code, $startStr, $endStr, 1);
                $code= replace($code, $s, ''); //移除
            }
        }else{
            break;
        }
    }

    //删除翻页配置20160309
    $startStr= '<!--#list start#-->';
    $endStr= '<!--#list end#-->';
    if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
        $s=StrCut($code, $startStr, $endStr, 2);
        $code=replace($code,$s,'');
    }

    if( @$_REQUEST['gl']== 'yun' ){
        $content= getFText('/Jquery/dragsort/Config.html');
        $content= getFText('/Jquery/dragsort/模块拖拽.html');
        //Css样式
        $startStr= '<style>';
        $endStr= '</style>';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortCssStr= StrCut($content, $startStr, $endStr, 1);
        }
        //开始部分
        $startStr= '<!--#top start#-->';
        $endStr= '<!--#top end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortStart= StrCut($content, $startStr, $endStr, 2);
        }
        //结束部分
        $startStr= '<!--#foot start#-->';
        $endStr= '<!--#foot end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortEnd= StrCut($content, $startStr, $endStr, 2);
        }
        //显示块内容
        $startStr= '<!--#value start#-->';
        $endStr= '<!--#value end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortValue= StrCut($content, $startStr, $endStr, 2);
        }



        //控制处理
        $startStr= '<dIv datid=\'';
        $endStr= '</dIv>';
        $content= GetArray($code, $startStr, $endStr, false, false);
        $splStr= aspSplit($content, '$Array$');
        foreach( $splStr as $key=>$s){
            $startStr= '【DatId】\'';
            $id= mid($s, 1, inStr($s, $startStr) - 1);
            $s= mid($s, inStr($s, $startStr) + len($startStr),-1);
            //C=C & "<li><div title='"& Id &"'>" & vbcrlf & "<div " & S & "</div>"& vbcrlf &"<div class='clear'></div></div><div class='clear'></div></li>"
            $s= '<div' . $s . '</div>';
            //Call Die(S)
            $c= $c . replace(replace($DragSortValue, '{$value$}', $s), '{$id$', $id);
        }
        $c= replace($c, '【换行】', vbCrlf());
        $c= $DragSortStart . $c . $DragSortEnd;
        $code= mid($code, 1, inStr($code, '<body>') - 1);
        $code= replace($code, '</head>', $DragSortCssStr . '</head></body>' . $c . '</body></html>');
    }

    //删除VB软件生成的垃圾代码
    $startStr= '<dIv datid=\'' ; $endStr= '【DatId】\'';
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $id= StrCut($code, $startStr, $endStr, 2);
            $code= replace2($code, $startStr . $id . $endStr, '<div ');
        }else{
            break;
        }
    }
    $code= replace($code, '</dIv>', '</div>'); //替换成这个结束div

    //最外围清除
    $startStr= '<!--#dialogteststart#-->' ; $endStr= '<!--#dialogtestend#-->';
    $code= replace($code, '<!--#dialogtest start#-->', $startStr);
    $code= replace($code, '<!--#dialogtest end#-->', $endStr);
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $s= StrCut($code, $startStr, $endStr, 1);
            $code= replace2($code, $s, '');
        }else{
            break;
        }
    }
    //内转清除
    $startStr= '<!--#teststart#-->' ; $endStr= '<!--#testend#-->';
    $code= replace($code, '<!--#del start#-->', $startStr); //与下面一样
    $code= replace($code, '<!--#del end#-->', $endStr); //与下面一样 多样式
    $code= replace($code, '<!--#test start#-->', $startStr);
    $code= replace($code, '<!--#test end#-->', $endStr);

    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $s= StrCut($code, $startStr, $endStr, 1);
            $code= replace2($code, $s, '');
        }else{
            break;
        }
    }
    //删除注释的span
    $code= replace($code, '<sPAn class="testspan">', ''); //测试Span
    $code= replace($code, '<sPAn class="testhidde">', ''); //隐藏Span
    $code= replace($code, '</sPAn>', '');

    //delTemplateMyNote = Code:Exit Function

    $startStr= '<!--#' ; $endStr= '#-->';
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $s= StrCut($code, $startStr, $endStr, 1);
            $code= replace2($code, $s, '');
        }else{
            break;
        }
    }


    $delTemplateMyNote= $code;
    return @$delTemplateMyNote;
}

//处理替换参数值 20160114
function handleReplaceValueParam($content, $paramName, $replaceStr){
    if( inStr($content, '[$' . $paramName)== false ){
        $paramName= lCase($paramName);
    }
    $handleReplaceValueParam= replaceValueParam($content, $paramName, $replaceStr);
    return @$handleReplaceValueParam;
}

//替换参数值 2014  12 01
function replaceValueParam($content, $paramName, $replaceStr){
    $startStr=''; $endStr=''; $labelStr=''; $tempLabelStr=''; $nLen=''; $nTimeFormat=''; $delHtmlYes=''; $funStr=''; $trimYes='';$isEscape=''; $s ='';$i='';
    $ifStr ='';//判断字符
    $elseIfStr ='';//第二判断字符
    $valueStr ='';//显示字符
    $elseStr ='';//否则字符
    $elseIfValue='';$elseValue																	='';//第二判断值
    $instrStr='';$instr2Str ='';//查找字符
    $tempReplaceStr																='';//暂存
    //ReplaceStr = ReplaceStr & "这里面放上内容在这时碳呀。"
    //ReplaceStr = CStr(ReplaceStr)            '转成字符类型
    if( isNul($replaceStr)== true ){ $replaceStr= '' ;}
    $tempReplaceStr=$replaceStr;

    //最多处理99个  20160225
    for( $i=1 ; $i<= 999 ; $i++){
        $replaceStr=$tempReplaceStr;													//恢复
        $startStr= '[$' . $paramName ; $endStr= '$]';
        //字段名称严格判断 20160226
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 && (inStr($content, $startStr . ' ') > 0 || inStr($content, $startStr . $endStr) > 0) ){
            //获得对应字段加强版20151231
            if( inStr($content, $startStr . $endStr) > 0 ){
                $labelStr= $startStr . $endStr;
            }else if( inStr($content, $startStr . ' ') > 0 ){
                $labelStr= StrCut($content, $startStr . ' ', $endStr, 1);
            }else{
                $labelStr= StrCut($content, $startStr, $endStr, 1);
            }

            $tempLabelStr= $labelStr;
            $labelStr= HandleInModule($labelStr, 'start');
            //删除Html
            $delHtmlYes= RParam($labelStr, 'delHtml'); //是否删除Html
            if( $delHtmlYes== 'true' ){ $replaceStr= replace(delHtml($replaceStr), '<', '&lt;') ;}//HTML处理
            //删除两边空格
            $trimYes= RParam($labelStr, 'trim'); //是否删除两边空格
            if( $trimYes== 'true' ){ $replaceStr= TrimVbCrlf($replaceStr) ;}

            //截取字符处理
            $nLen= RParam($labelStr, 'len'); //字符长度值
            $nLen= handleNumber($nLen);
            //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
            if( $nLen <> '' ){ $replaceStr= CutStr($replaceStr, $nLen, '...') ;}//Left(ReplaceStr,nLen)

            //时间处理
            $nTimeFormat= RParam($labelStr, 'format_time'); //时间处理值
            if( $nTimeFormat <> '' ){
                $replaceStr= Format_Time($replaceStr, $nTimeFormat);
            }

            //获得栏目名称
            $s= RParam($labelStr, 'getcolumnname');
            if( $s <> '' ){
                if( $s== '@ME' ){
                    $s= $replaceStr;
                }
                $replaceStr= getColumnName($s);
            }
            //获得栏目URL
            $s= RParam($labelStr, 'getcolumnurl');
            if( $s <> '' ){
                if( $s== '@ME' ){
                    $s= $replaceStr;
                }
                $replaceStr= getColumnUrl($s, 'id');
            }
            //是否为密码类型
            $s= RParam($labelStr, 'password');
            if( $s <> '' ){
                if( $s<>'' ){
                    $replaceStr= $s;
                }
            }

            $ifStr= RParam($labelStr, 'if');
            $elseIfStr= RParam($labelStr, 'elseif');
            $valueStr= RParam($labelStr, 'value');
            $elseifValue= RParam($labelStr, 'elseifvalue');
            $elseValue= RParam($labelStr, 'elsevalue');
            $instrStr= RParam($labelStr, 'instr');
            $instr2Str= RParam($labelStr, 'instr2');

            //call echo("ifStr",ifStr)
            //call echo("valueStr",valueStr)
            //call echo("elseStr",elseStr)
            //call echo("elseIfStr",elseIfStr)
            //call echo("replaceStr",replaceStr)
            if( $ifStr <> '' || $instrStr <> '' ){
                if(($ifStr== cStr($replaceStr) && $ifStr <> '') ){
                    $replaceStr= $valueStr;
                }else if( $elseIfStr== cStr($replaceStr) && $elseIfStr <> '' ){
                    $replaceStr= $valueStr;
                    if( $elseifValue<>'' ){
                        $replaceStr= $elseifValue;
                    }
                }else if( inStr(cStr($replaceStr), $instrStr) > 0 && $instrStr <> '' ){
                    $replaceStr= $valueStr;
                }else if( inStr(cStr($replaceStr), $instr2Str) > 0 && $instr2Str <> '' ){
                    $replaceStr= $valueStr;
                    if( $elseifValue<>'' ){
                        $replaceStr= $elseifValue;
                    }
                }else{
                    if( $elseValue <> '@ME' ){
                        $replaceStr= $elseValue;
                    }
                }
            }

            //函数处理20151231    [$title  function='left(@ME,40)'$]
            $funStr= RParam($labelStr, 'function'); //函数
            if( $funStr <> '' ){
                $funStr= replace($funStr, '@ME', $replaceStr);
                $replaceStr= HandleContentCode($funStr, '');
            }

            //默认值
            $s= RParam($labelStr, 'default');
            if( $s <> '' && $s<>'@ME' ){
                if( $replaceStr== '' ){
                    $replaceStr= $s;
                }
            }
            //escape转码
            $isEscape=lCase(RParam($labelStr, 'escape'));
            if( $isEscape=='1' || $isEscape=='true' ){
                $replaceStr=escape($replaceStr);
            }

            //文本颜色
            $s= RParam($labelStr, 'fontcolor'); //函数
            if( $s <> '' ){
                $replaceStr= '<font color="' . $s . '">' . $replaceStr . '</font>';
            }




            //call echo(tempLabelStr,replaceStr)
            $content= replace($content, $tempLabelStr, $replaceStr);
        }else{
            break;
        }
    }
    $replaceValueParam= $content;
    return @$replaceValueParam;
}


//显示编辑器20160115
function displayEditor($action){
    $c ='';
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shCore.js"></script> ' . vbCrlf();
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushJScript.js"></script>' . vbCrlf();
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushPhp.js"></script> ' . vbCrlf();
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushVb.js"></script> ' . vbCrlf();
    $c= $c . '<link type="text/css" rel="stylesheet" href="\\Jquery\\syntaxhighlighter\\styles/shCore.css"/>' . vbCrlf();
    $c= $c . '<link type="text/css" rel="stylesheet" href="\\Jquery\\syntaxhighlighter\\styles/shThemeDefault.css"/>' . vbCrlf();
    $c= $c . '<script type="text/javascript">' . vbCrlf();
    $c= $c . '    SyntaxHighlighter.config.clipboardSwf = \'\\Jquery\\syntaxhighlighter\\scripts/clipboard.swf\';' . vbCrlf();
    $c= $c . '    SyntaxHighlighter.all();' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();

    $displayEditor= $c;
    return @$displayEditor;
}
//处理网站url20160202
function handleWebUrl($url){
    if( @$_REQUEST['gl'] <> '' ){
        $url= getUrlAddToParam($url, '&gl=' . @$_REQUEST['gl'], 'replace');
    }
    if( @$_REQUEST['templatedir'] <> '' ){
        $url= getUrlAddToParam($url, '&templatedir=' . @$_REQUEST['templatedir'], 'replace');
    }
    $handleWebUrl= $url;
    return @$handleWebUrl;
}

//
//处理在线修改
//MainContent = HandleDisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent,"style='float:right;padding:0 4px;'")
function handleDisplayOnlineEditDialog($url, $content, $cssStyle, $replaceStr){
    $controlStr=''; $splStr=''; $s=''; $addOK ='';
    if( @$_REQUEST['gl']== 'edit' ){
        if( inStr($url, '&') > 0 ){
            $url= $url . '&vbgl=true';
        }
        $addOK= false; //添加默认为假
        $controlStr= getControlStr($url) . '"' . $cssStyle;
        if( $replaceStr <> '' ){
            $splStr= aspSplit($replaceStr, '|');
            foreach( $splStr as $key=>$s){
                if( $s <> '' && inStr($content, $s) > 0 ){
                    $content= replace2($content, $s, $s . $controlStr);
                    $addOK= true;
                    break;
                }
            }
        }
        if( $addOK== false ){
            //第一种
            //C = "<div "& ControlStr &">" & vbCrlf
            //C=C & Content & vbCrlf
            //C = C & "</div>" & vbCrlf
            //Content = C
            //第二种
            $content= htmlAddAction($content, $controlStr);

            //Content = "<div "& ControlStr &">" & Content & "</div>"
        }
    }
    $handleDisplayOnlineEditDialog= $content;
    return @$handleDisplayOnlineEditDialog;
}
//获得控制内容
function getControlStr($url){
    if( @$_REQUEST['gl']== 'edit' ){
        $getControlStr= ' onMouseMove="onColor(this,\'#FDFAC6\',\'red\')" onMouseOut="offColor(this,\'\',\'\')" onDblClick="window1(\'' . $url . '\',\'信息修改\')" title=\'双击或右键在线修改\' oncontextmenu="CommonMenu(event,this,\'\')'; //删除网址为空
    }
    return @$getControlStr;
}

//html加动作(20151103)  call rw(htmlAddAction("  <a href=""javascript:;"">222222</a>", "onclick=""javascript:alert(111);"" "))
function htmlAddAction($content, $jsAction){
    $s=''; $startStr=''; $endStr=''; $isHandle=''; $lableName ='';
    $s= $content;
    $s= PHPTrim($s);
    $startStr= mid($s, 1, inStr($s, ' '));
    $endStr= '>';
    $isHandle= true;

    $lableName= aspTrim(lCase(replace($startStr, '<', '')));
    if( inStr($s, $startStr)== false || inStr($s, $endStr)== false || inStr('|a|div|span|font|h1|h2|h3|h4|h5|h6|dt|dd|dl|li|ul|table|tr|td|', '|' . $lableName . '|')== false ){
        $isHandle= false;
    }

    if( $isHandle== true ){
        $content= $startStr . $jsAction . right($s, len($s) - len($startStr));
    }
    $htmlAddAction= $content;
    return @$htmlAddAction;
}


?>