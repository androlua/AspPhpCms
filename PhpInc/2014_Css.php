<?PHP
//Css

//Css压缩 cssCompression(Content,0)
function cssCompression($content, $Level){
    $Level= cStr($Level); //转成字符好判断
    //Css高级压缩
    if( $Level== '1' ){
        $content= regExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', '');
        $content= regExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= regExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{');
        $content= regExp_Replace($content, ';\\s*;', ';');
        //Css简单压缩
    }else{
        if( $Level >= 2 ){
            $content= regExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////删除注释
        }
        $content= regExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= regExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{'); ////容错处理
        $content= regExp_Replace($content, ';\\s*;', ';'); ////清除连续分号
        $content= regExp_Replace($content, ';\\s*}', '}'); ////清除末尾分号和大括号
        $content= regExp_Replace($content, '([^\\s])\\{([^\\s])', '$1{$2');
        $content= regExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']s*)', '$1}' . vbCrlf() . '$2');

    }
    $content= trimVbCrlf($content);
    $cssCompression= $content;
    return @$cssCompression;
}

//删除Css里注释
function deleteCssNote($content){
    $deleteCssNote= regExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////删除注释
    return @$deleteCssNote;
}

//Css格式化  展开CSS
function unCssCompression($content){
    $content= regExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
    $content= regExp_Replace($content, ';\\s*;', ';'); ////清除连续分号
    $content= regExp_Replace($content, '\\,[\\s\\.\\#\\d]*{', '{');
    $content= regExp_Replace($content, '([^\\s])\\{([^\\s])', '$1 {' . vbCrlf() . '' . vbTab() . '$2');
    $content= regExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']*)', '$1' . vbCrlf() . '}' . vbCrlf() . '$2');
    $content= regExp_Replace($content, '([^\\s]);([^\\s\\}])', '$1;' . vbCrlf() . '' . vbTab() . '$2');
    $unCssCompression= $content;
    return @$unCssCompression;
}

//去掉字符串头尾的连续的回车和空格
function trimVbCrlf($str){
    $trimVbCrlf= phpRTrim(phpLTrim($str));
    return @$trimVbCrlf;
}

//php里Trim方法


//去掉字符串开头的连续的回车和空格


//去掉字符串末尾的连续的回车和空格



//--------------- 有用 暂时用这文件里 ------------------
//去掉字符串头尾的连续的Tab退格和空格
function trimVbTab($str){
    $trimVbTab= rTrimVBTab(lTrimVbTab($str));
    return @$trimVbTab;
}


//去掉字符串开头的连续的Tab退格和空格
function lTrimVbTab($str){
    $pos=''; $isBlankChar ='';
    $pos= 1;
    $isBlankChar= true;
    while( $isBlankChar){
        if( mid($str, $pos, 1)== ' ' ){
            $pos= $pos + 1;
        }else if( mid($str, $pos, 1)== vbTab() ){
            $pos= $pos + 1;
        }else{
            $isBlankChar= false;
        }
    }
    $lTrimVbTab= right($str, len($str) - $pos + 1);
    return @$lTrimVbTab;
}

//去掉字符串末尾的连续的Tab退格和空格
function rTrimVBTab($str){
    $pos=''; $isBlankChar ='';
    $pos= len($str);
    $isBlankChar= true;
    while( $isBlankChar && $pos >= 2){
        if( mid($str, $pos, 1)== ' ' ){
            $pos= $pos - 1;
        }else if( mid($str, $pos - 1, 1)== vbTab() ){
            $pos= $pos - 1;
        }else{
            $isBlankChar= false;
        }
    }
    $rTrimVBTab= aspRTrim(left($str, $pos));
    return @$rTrimVBTab;
}


//找Html页中Css Style <style></style> 里css内容
function getHtmlCssStyle( $content){
    $getHtmlCssStyle= handleHtmlStyleCss($content,'','');
    return @$getHtmlCssStyle;
}
//处理html里的css 替换路径
function handleHtmlStyleCss($content,$sType,$imgPath){
    $splStr=''; $s=''; $StyleYes=''; $StyleStartStr=''; $StyleEndStr=''; $StyleStr=''; $CssStr ='';$newCssStr='';
    $splStr= aspSplit($content, vbCrlf()); //分割行
    $StyleYes= false; //Css样式默认为假
    //循环分行
    foreach( $splStr as $key=>$s){
        if( $StyleYes== false ){
            if( inStr(lCase($s), '<style') > 0 ){
                $StyleStartStr= mid($s, inStr(lCase($s), '<style'),-1);
                $StyleStartStr= mid($StyleStartStr, 1, inStr($StyleStartStr, '>'));
                $StyleEndStr= mid($s, inStr(lCase($s), $StyleStartStr) + len($StyleStartStr),-1);
                //HTML中定义的Css在一行
                if( inStr($StyleEndStr, '</style>') > 0 ){
                    $StyleStr= mid($StyleEndStr, 1, inStr($StyleEndStr, '</style>') - 1);
                    $CssStr= $CssStr . $StyleStr . vbCrlf();
                }else{
                    $CssStr= $CssStr . $StyleEndStr . vbCrlf();
                    $StyleYes= true; //收集CssStyle样式开始
                }
                //Call Echo("StyleStartStr",ShowHtml(StyleStartStr))
                //Call Echo("StyleEndStr",ShowHtml(StyleEndStr))
                //Call Echo("StyleStr",ShowHtml(StyleStr))
                //Call Echo("CssStr",ShowHtml(CssStr))
                //Call RwEnd("")
            }
        }else if( $StyleYes== true ){
            if( inStr(lCase($s), '</style>') > 0 ){
                $StyleStr= mid($s, 1, inStr(lCase($s), '</style>') - 1);
                $CssStr= $CssStr . $StyleStr . vbCrlf();

                if( $sType=='替换路径' ){
                    $newCssStr=replaceCssImgPath($CssStr,$imgPath);
                    $content=replace($content,phpTrim($cssstr),$newCssStr);
                }

                $StyleYes= false; //收集CssStyle样式结束
            }else{
                $CssStr= $CssStr . $s . vbCrlf();
            }
        }
    }
    if( $sType=='替换路径' ){
        $handleHtmlStyleCss=$content;
    }else{
        $handleHtmlStyleCss=$cssStr;
    }
    return @$handleHtmlStyleCss;
}

//替换css内容里图片路径 20160718home
function replaceCssImgPath( $cssStr, $imgPath){
    $content='';$splstr='';$s='';$c='';$fileName='';$toImgPath='';
    $content=GetArray($cssStr,'\\(','\\)',false,false);
    $splstr=aspSplit($content,'$Array$');
    foreach( $splstr as $key=>$s){
        if( $s <>'' ){
            $fileName=getFileAttr($s,2);
            //引用图片
            if( inStr(lCase($s),'data:image')==false ){
                $cssStr=replace($cssStr,'('. $s .')','(' . $imgPath . $fileName . ')');
                //fileName="data:image/" & fileName
            }

        }
    }
    $replaceCssImgPath=$cssStr;
    return @$replaceCssImgPath;
}

//处理成干净的Css内容  CSS格式化
function handleCleanCss( $content){
    $splStr=''; $s=''; $c=''; $AddStrYes=''; $CustomS ='';
    $content= replace($content, '{', vbCrlf() . '{' . vbCrlf());
    $content= replace($content, '}', vbCrlf() . '}' . vbCrlf());
    $content= replace($content, ';', ';' . vbCrlf());

    $splStr= aspSplit($content, vbCrlf());
    $AddStrYes= false; //追加字符默认为假
    foreach( $splStr as $key=>$s){
        $s= trimVbCrlf($s);
        $CustomS= ''; //自定义S值
        if( $s <> '' ){
            if( inStr($s, '{') > 0 && inStr($s, '}')== false ){
                $AddStrYes= true;
                $CustomS= $s;
            }else if( inStr($s, '}') > 0 ){
                $AddStrYes= false;
            }
            if( left($s, 1) <> '{' ){ $c= $c . vbCrlf() ;}
            if( $AddStrYes== true ){ $s= '    ' . $s ;}
            if( $CustomS <> '' ){ $s= $CustomS ;}//自定义值不为空则用自定义内容
            $c= $c . $s;

        }
    }
    $c= trimVbCrlf($c);
    $c=replace($c,'    ;'.vbCrlf(),'');			//清除多于的分号
    $c=replace($c,';'. vbCrlf() .'}', vbCrlf() . '}');			//最后一个参数不要分号
    $handleCleanCss= $c;
    return @$handleCleanCss;
}



//移除内容中多除行
function removeExcessRow($content){
    $splStr=''; $s=''; $c=''; $TempS ='';
    $splStr= aspSplit($content, vbCrlf()); //分割行
    foreach( $splStr as $key=>$s){
        $TempS= replace(replace($s, ' ', ''), vbTab(), '');
        if( $TempS <> '' ){
            $c= $c . $s . vbCrlf();
        }
    }
    if( $c <> '' ){ $c= left($c, len($c) - 2); }
    $removeExcessRow= $c;
    return @$removeExcessRow;
}


//2014 11 30
//向Css里追加样式  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
function cssAddToStyle($content, $AddToStyle){
    $StyleName=''; $YunStyleStr=''; $ReplaceStyleStr=''; $c ='';
    if( inStr($AddToStyle, '{') > 0 ){
        $StyleName= aspTrim(mid($AddToStyle, 1, inStr($AddToStyle, '{') - 1));
    }
    $YunStyleStr= findCssStyle($content, $StyleName);
    $ReplaceStyleStr= cssStyleAddToParam($YunStyleStr, $AddToStyle); //Css样式累加参数
    $content= replace($content, $YunStyleStr, $ReplaceStyleStr);
    //C = C & "<hr>Content=" & Content
    $cssAddToStyle= $content;
    //CssAddToStyle = YunStyleStr
    //CssAddToStyle = "StyleName=" & StyleName & "<hr>YunStyleStr=" & YunStyleStr & "<hr>ReplaceStyleStr=" & ReplaceStyleStr
    return @$cssAddToStyle;
}

//检测Css内容中是否有指定样式
function checkCssStyle($content, $StyleStr){
    $StyleName ='';
    $checkCssStyle= true;
    if( inStr($StyleStr, '{') > 0 ){
        $StyleName= aspTrim(mid($StyleStr, 1, inStr($StyleStr, '{') - 1));
    }
    if( $StyleName== '' ){
        $checkCssStyle= false;
    }else if( findCssStyle($content, $StyleName)== '' ){
        $checkCssStyle= false;
    }
    return @$checkCssStyle;
}


//Css样式累加参数
function cssStyleAddToParam( $CssStyleStr, $CssStyleStrTwo){
    $splStr=''; $CssStr=''; $s=''; $ParamList=''; $ParamName=''; $CssStyleName ='';
    $CssStyleName= mid($CssStyleStr, 1, inStr($CssStyleStr, '{'));
    if( inStr($CssStyleStr, '{') > 0 ){
        $CssStyleStr= mid($CssStyleStr, inStr($CssStyleStr, '{') + 1,-1);
    }
    if( inStr($CssStyleStr, '}') > 0 ){
        $CssStyleStr= mid($CssStyleStr, 1, inStr($CssStyleStr, '}') - 1);
    }
    if( inStr($CssStyleStrTwo, '{') > 0 ){
        $CssStyleStrTwo= mid($CssStyleStrTwo, inStr($CssStyleStrTwo, '{') + 1,-1);
    }
    if( inStr($CssStyleStrTwo, '}') > 0 ){
        $CssStyleStrTwo= mid($CssStyleStrTwo, 1, inStr($CssStyleStrTwo, '}') - 1);
    }
    $splStr= aspSplit(replace($CssStyleStr . ';' . $CssStyleStrTwo, vbCrlf(), ''), ';');
    foreach( $splStr as $key=>$s){
        $s= aspTrim($s);
        if( inStr($s, ':') > 0 && $s <> '' ){
            $ParamName= aspTrim(mid($s, 1, inStr($s, ':') - 1));
            if( inStr('|' . $ParamList . '|', '|' . $ParamName . '|')== false ){
                $ParamList= $ParamList . $ParamName . '|';
                //Call Echo("ParamName",ParamName)
                $CssStr= $CssStr . '    ' . $s . ';' . vbCrlf();
            }
        }
    }
    if( $CssStyleName <> '' ){
        $CssStr= $CssStyleName . vbCrlf() . $CssStr . '}';
    }
    $cssStyleAddToParam= $CssStr;
    //Call Echo(CssStyleStr,CssStyleStrTwo)
    return @$cssStyleAddToParam;
}

//根据Css名称找到对应Css块
function findCssStyle( $content, $StyleName){
    $splStr=''; $s=''; $TempS=''; $FindStyleName ='';
    //CAll Echo("StyleName",StyleName)
    //CAll Echo("Content",Content)
    $StyleName= aspTrim($StyleName);
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( inStr($s, $StyleName) > 0 ){
            $FindStyleName= aspTrim($s);
            if( inStr($FindStyleName, '{') > 0 ){
                $FindStyleName= aspTrim(mid($FindStyleName, 1, inStr($FindStyleName, '{') - 1));
            }
            if( $FindStyleName== $StyleName ){
                //Call Eerr( FindStyleName , StyleName)
                if( inStr($s, '}') > 0 ){
                    $findCssStyle= mid($s, 1, inStr($s, '}') + 1);
                    //Call EErr(s,FindCssStyle)
                    return @$findCssStyle;
                }else{
                    $TempS= mid($content, inStr($content, $s . vbCrlf()) + 1,-1);
                    $TempS= mid($TempS, 1, inStr($TempS, '}') + 1);
                    $findCssStyle= $TempS;
                    return @$findCssStyle;
                }
                //Call Eerr("temps",Temps)
            }
            //Call Echo(FindStyleName,StyleName)
        }
    }
    return @$findCssStyle;
}

//================================================
//导入网站前端要用到
//================================================
//处理截取到的Css
function handleCutCssCode($dirPath, $CssStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $fileName=''; $listStr ='';
    $startStr= 'url\\(' ; $endStr= '\\)';
    $content= GetArray($CssStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' && inStr($ImageFile, '.') > 0 && inStr(vbCrlf() . $listStr . vbCrlf(), vbCrlf() . $ImageFile . vbCrlf())== false ){//对重复使用的图片处理
            $listStr= $listStr . $ImageFile . vbCrlf();
            $fileName= replace(replace(replace($ImageFile, '"', ''), '\'', ''), '\\', '/');
            if( inStr($fileName, '/') > 0 ){
                $fileName= mid($fileName, inStrRev($fileName, '/') + 1,-1);
            }
            $CssStr= replace($CssStr, $ImageFile, $dirPath . $fileName);
        }
    }
    $handleCutCssCode= $CssStr;
    return @$handleCutCssCode;
}

//处理截取到的HtmlDiv
function handleCutDivCode($dirPath, $DivStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $ToImageFile=''; $fileName=''; $isHandle ='';
    $startStr= 'url\\(' ; $endStr= '\\)';
    $content= GetArray($DivStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){

        if( $ImageFile <> '' && inStr($ImageFile, '.') > 0 && inStr($ImageFile, '{$#')== false ){
            //判断是否有域名 20150202
            if( getWebSite($ImageFile)== '' ){
                $fileName= replace(replace(replace($ImageFile, '"', ''), '\'', ''), '\\', '/');
                if( inStr($fileName, '/') > 0 ){
                    $fileName= mid($fileName, inStrRev($fileName, '/') + 1,-1);
                }
                $DivStr= replace($DivStr, $ImageFile, $dirPath . $ImageFile);
            }
        }
    }
    //图片处理
    //Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '再加个Html背景图片
    $content= getImgJsUrl($DivStr, '不重复') . vbCrlf() . getHtmlBackGroundImgList($DivStr); //再加个Html背景图片  加强版20150126
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' ){ //当链接地址当前为HTTP:时则不处理20150313
            $isHandle= false;

            if( left($ImageFile, 1)== '\\' ){
                //等处理20150817
            }else if( inStr($ImageFile, '.') > 0 && left($ImageFile, 5) <> 'HTTP:' && inStr($ImageFile, '{$#')== false ){
                $isHandle= true;
            }
            if( $isHandle== true ){
                $ToImageFile= $dirPath . removeFileDir($ImageFile); //移除文件路径目录
                //html中图片路径替换
                $DivStr= replace($DivStr, '"' . $ImageFile . '"', '"' . $ToImageFile . '"');
                $DivStr= replace($DivStr, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"');
                $DivStr= replace($DivStr, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"');
                $DivStr= replace($DivStr, '=' . $ImageFile . '>', '"' . $ToImageFile . '"');
            }
        }
    }
    $handleCutDivCode= $DivStr;
    return @$handleCutDivCode;
}

//获得HTMl里背景图片 20150116  如： <td width="980" height="169" background="kslx3bg.jpg">
function getHtmlBackGroundImgList( $content){
    $content= GetArray($content, ' background="', '"', false, false);
    $content= replace($content, '$Array$', vbCrlf());
    $getHtmlBackGroundImgList= $content;
    return @$getHtmlBackGroundImgList;
}


//完善html里link css链接 Content = getHandleWebHtmlLink("/aa/bb/",Content)  外部调用
function getHandleWebHtmlLink($RootPath, $content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $CssUrl=''; $NewCssUrl=''; $CssStr ='';
    $startStr= '<link ';
    $CssStr= '';
    $endStr= '>';
    $ImgList= GetArray($content, $startStr, $endStr, false, false);
    //Call RwEnd(ImgList)
    $splStr= aspSplit($ImgList, '$Array$');
    foreach( $splStr as $key=>$CssUrl){
        if( $CssUrl <> '' && inStr(lCase($CssUrl), 'stylesheet') > 0 ){
            //获得Css加强版，改于20141125
            $CssUrl= lCase(replace(replace(replace($CssUrl, '"', ''), '\'', ''), '>', ' ')) . ' ';
            $startStr= 'href=' ; $endStr= ' ';
            if( inStr($CssUrl, $startStr) > 0 && inStr($CssUrl, $endStr) > 0 ){
                $CssUrl= StrCut($CssUrl, $startStr, $endStr, 2);
            }
            $NewCssUrl= handleHttpUrl($CssUrl);
            if( inStr($NewCssUrl, '/') > 0 ){
                $NewCssUrl= mid($NewCssUrl, inStrRev($NewCssUrl, '/') + 1,-1);
            }
            if( lCase($NewCssUrl) <> 'common.css' && lCase($NewCssUrl) <> 'public.css' ){
                $NewCssUrl= $RootPath . $NewCssUrl;
                $CssStr= $CssStr . '<link href="' . $NewCssUrl . '" rel="stylesheet" type="text/css" />' . vbCrlf();
            }
        }
    }
    if( $CssStr <> '' ){ $CssStr= left($CssStr, len($CssStr) - 2); }
    $getHandleWebHtmlLink= $CssStr;
    return @$getHandleWebHtmlLink;
}


//获得css链接地址列表(20150824)  找<link>
function getCssListUrlList($content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $CssUrl=''; $CssStr=''; $urlList ='';
    $startStr= '<link ';
    $CssStr= '';
    $endStr= '>';
    $ImgList= GetArray($content, $startStr, $endStr, false, false);
    //Call RwEnd(ImgList)
    $splStr= aspSplit($ImgList, '$Array$');
    foreach( $splStr as $key=>$CssUrl){
        if( $CssUrl <> '' && inStr(lCase($CssUrl), 'stylesheet') > 0 ){
            //获得Css加强版，改于20141125
            $CssUrl= lCase(replace(replace(replace($CssUrl, '"', ''), '\'', ''), '>', ' ')) . ' ';
            $startStr= 'href=' ; $endStr= ' ';
            if( inStr($CssUrl, $startStr) > 0 && inStr($CssUrl, $endStr) > 0 ){
                $CssUrl= StrCut($CssUrl, $startStr, $endStr, 2);
            }
            if( inStr(vbCrlf() . $urlList . vbCrlf(), vbCrlf() . $CssUrl . vbCrlf())== false ){
                if( $urlList <> '' ){ $urlList= $urlList . vbCrlf() ;}
                $urlList= $urlList . $CssUrl . vbCrlf();
            }
        }
    }
    $getCssListUrlList= $urlList;
    return @$getCssListUrlList;
}
//call rw(handleHtmlStyle(getftext("1.html")))
//压缩html里的style样式 (20151008)
function handleHtmlStyle($content){
    $serchS=''; $replaceS=''; $nLength ='';
    $serchS= $content;
    $nLength= inStr(lCase($serchS), '</style>') + 7;
    $serchS= mid($serchS, 1, $nLength);

    $nLength= inStrRev(lCase($serchS), '<style');
    if( $nLength > 0 ){
        $serchS= mid($serchS, $nLength,-1);
    }
    $replaceS= $serchS;
    $replaceS= cssCompression($replaceS, 0) . vbCrlf(); //格式化CSS
    $replaceS= removeBlankLines($replaceS);

    $content= replace($content, $serchS, $replaceS);
    $handleHtmlStyle= $content;
    return @$handleHtmlStyle;
}



//读Css文件内容并处理(20150824) 加特殊记录标签   不常用
//如call rwend(handleReadCssContent("E:\E盘\WEB网站\至前网站\DataDir\VB模块\服务器\Template\模块功能列表\B站页面设计\home\home.css","aa",true))
function handleReadCssContent($cssFilePath, $LabelName, $isHandleCss){
    $c=''; $startStr=''; $endStr ='';
    $c= getFText($cssFilePath);
    //截取CSS
    $startStr= '/*CssCodeStart*/';
    $endStr= '/*CssCodeEnd*/';
    if( inStr($c, $startStr) > 0 && inStr($c, $endStr) > 0 ){
        $c= StrCut($c, $startStr, $endStr, 2);
    }
    //处理CSS
    if( $isHandleCss== true ){
        $c= cssCompression($c, 0);
    }
    if( $LabelName <> '' ){
        $c= '/*' . $LabelName . ' start*/' . $c . '/*' . $LabelName . ' end*/';
    }
    $handleReadCssContent= $c;
    return @$handleReadCssContent;
}

//处理Css样式里PX或%
function handleCssPX( $nValue){
    $nValue= lCase(aspTrim($nValue));
    if( right($nValue, 1) <> '%' && right($nValue, 2) <> 'px' ){
        $nValue= $nValue . 'px';
    }
    $handleCssPX= $nValue;
    return @$handleCssPX;
}

?>