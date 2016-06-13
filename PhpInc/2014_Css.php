<?PHP
//Css

//Css压缩 cssCompression(Content,0)
function cssCompression($content, $Level){
    $Level= CStr($Level); //转成字符好判断
    //Css高级压缩
    if( $Level== '1' ){
        $content= RegExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', '');
        $content= RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{');
        $content= RegExp_Replace($content, ';\\s*;', ';');
        //Css简单压缩
    }else{
        if( $Level >= 2 ){
            $content= RegExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////删除注释
        }
        $content= RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{'); ////容错处理
        $content= RegExp_Replace($content, ';\\s*;', ';'); ////清除连续分号
        $content= RegExp_Replace($content, ';\\s*}', '}'); ////清除末尾分号和大括号
        $content= RegExp_Replace($content, '([^\\s])\\{([^\\s])', '$1{$2');
        $content= RegExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']s*)', '$1}' . vbCrlf() . '$2');

    }
    $content= trimVBcrlf($content);
    $cssCompression= $content;
    return @$cssCompression;
}

//删除Css里注释
function deleteCssNote($content){
    $deleteCssNote= RegExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////删除注释
    return @$deleteCssNote;
}

//Css格式化  展开CSS
function unCssCompression($content){
    $content= RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
    $content= RegExp_Replace($content, ';\\s*;', ';'); ////清除连续分号
    $content= RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*{', '{');
    $content= RegExp_Replace($content, '([^\\s])\\{([^\\s])', '$1 {' . vbCrlf() . '' . "\t" . '$2');
    $content= RegExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']*)', '$1' . vbCrlf() . '}' . vbCrlf() . '$2');
    $content= RegExp_Replace($content, '([^\\s]);([^\\s\\}])', '$1;' . vbCrlf() . '' . "\t" . '$2');
    $unCssCompression= $content;
    return @$unCssCompression;
}

//去掉字符串头尾的连续的回车和空格
function trimVbCrlf($str){
    $trimVbCrlf= PHPRTrim(PHPLTrim($str));
    return @$trimVbCrlf;
}

//PHP里Trim方法


//去掉字符串开头的连续的回车和空格


//去掉字符串末尾的连续的回车和空格



//--------------- 有用 暂时用这文件里 ------------------
//去掉字符串头尾的连续的Tab退格和空格
function trimVbTab($str){
    $trimVbTab= RTrimVBTab(LTrimVbTab($str));
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
        }else if( mid($str, $pos, 1)== "\t" ){
            $pos= $pos + 1;
        }else{
            $isBlankChar= false;
        }
    }
    $lTrimVbTab= Right($str, Len($str) - $pos + 1);
    return @$lTrimVbTab;
}

//去掉字符串末尾的连续的Tab退格和空格
function rTrimVBTab($str){
    $pos=''; $isBlankChar ='';
    $pos= Len($str);
    $isBlankChar= true;
    while( $isBlankChar && $pos >= 2){
        if( mid($str, $pos, 1)== ' ' ){
            $pos= $pos - 1;
        }else if( mid($str, $pos - 1, 1)== "\t" ){
            $pos= $pos - 1;
        }else{
            $isBlankChar= false;
        }
    }
    $rTrimVBTab= AspRTrim(substr($str, 0 , $pos));
    return @$rTrimVBTab;
}


//找Html页中Css Style
function getHtmlCssStyle( $content){
    $splStr=''; $s=''; $StyleYes=''; $StyleStartStr=''; $StyleEndStr=''; $StyleStr=''; $CssStr ='';
    $splStr= aspSplit($content, vbCrlf()); //分割行
    $StyleYes= false; //Css样式默认为假
    //循环分行
    foreach( $splStr as $key=>$s){
        if( $StyleYes== false ){
            if( instr(strtolower($s), '<style') > 0 ){
                $StyleStartStr= mid($s, instr(strtolower($s), '<style'),-1);
                $StyleStartStr= mid($StyleStartStr, 1, instr($StyleStartStr, '>'));
                $StyleEndStr= mid($s, instr(strtolower($s), $StyleStartStr) + Len($StyleStartStr),-1);
                //HTML中定义的Css在一行
                if( instr($StyleEndStr, '</style>') > 0 ){
                    $StyleStr= mid($StyleEndStr, 1, instr($StyleEndStr, '</style>') - 1);
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
            if( instr(strtolower($s), '</style>') > 0 ){
                $StyleStr= mid($s, 1, instr(strtolower($s), '</style>') - 1);
                $CssStr= $CssStr . $StyleStr . vbCrlf();
                //Call Echo("StyleStr2",ShowHtml(StyleStr))
                //Call Echo("CssStr2",ShowHtml(CssStr))
                //Call RwEnd("")
                $StyleYes= false; //收集CssStyle样式结束
            }else{
                $CssStr= $CssStr . $s . vbCrlf();
            }
        }
    }
    $getHtmlCssStyle= $CssStr;
    return @$getHtmlCssStyle;
}

//处理成干净的Css内容  CSS格式化
function handleCleanCss( $content){
    $splStr=''; $s=''; $c=''; $AddStrYes=''; $CustomS ='';
    $content= Replace($content, '{', vbCrlf() . '{' . vbCrlf());
    $content= Replace($content, '}', vbCrlf() . '}' . vbCrlf());
    $content= Replace($content, ';', ';' . vbCrlf());

    $splStr= aspSplit($content, vbCrlf());
    $AddStrYes= false; //追加字符默认为假
    foreach( $splStr as $key=>$s){
        $s= trimVbCrlf($s);
        $CustomS= ''; //自定义S值
        if( $s <> '' ){
            if( instr($s, '{') > 0 && instr($s, '}')== false ){
                $AddStrYes= true;
                $CustomS= $s;
            }else if( instr($s, '}') > 0 ){
                $AddStrYes= false;
            }
            if( substr($s, 0 , 1) <> '{' ){ $c= $c . vbCrlf() ;}
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
        $TempS= Replace(Replace($s, ' ', ''), "\t", '');
        if( $TempS <> '' ){
            $c= $c . $s . vbCrlf();
        }
    }
    if( $c <> '' ){ $c= substr($c, 0 , Len($c) - 2) ;}
    $removeExcessRow= $c;
    return @$removeExcessRow;
}


//2014 11 30
//向Css里追加样式  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
function cssAddToStyle($content, $AddToStyle){
    $StyleName=''; $YunStyleStr=''; $ReplaceStyleStr=''; $c ='';
    if( instr($AddToStyle, '{') > 0 ){
        $StyleName= AspTrim(mid($AddToStyle, 1, instr($AddToStyle, '{') - 1));
    }
    $YunStyleStr= FindCssStyle($content, $StyleName);
    $ReplaceStyleStr= CssStyleAddToParam($YunStyleStr, $AddToStyle); //Css样式累加参数
    $content= Replace($content, $YunStyleStr, $ReplaceStyleStr);
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
    if( instr($StyleStr, '{') > 0 ){
        $StyleName= AspTrim(mid($StyleStr, 1, instr($StyleStr, '{') - 1));
    }
    if( $StyleName== '' ){
        $checkCssStyle= false;
    }else if( FindCssStyle($content, $StyleName)== '' ){
        $checkCssStyle= false;
    }
    return @$checkCssStyle;
}


//Css样式累加参数
function cssStyleAddToParam( $CssStyleStr, $CssStyleStrTwo){
    $splStr=''; $CssStr=''; $s=''; $ParamList=''; $ParamName=''; $CssStyleName ='';
    $CssStyleName= mid($CssStyleStr, 1, instr($CssStyleStr, '{'));
    if( instr($CssStyleStr, '{') > 0 ){
        $CssStyleStr= mid($CssStyleStr, instr($CssStyleStr, '{') + 1,-1);
    }
    if( instr($CssStyleStr, '}') > 0 ){
        $CssStyleStr= mid($CssStyleStr, 1, instr($CssStyleStr, '}') - 1);
    }
    if( instr($CssStyleStrTwo, '{') > 0 ){
        $CssStyleStrTwo= mid($CssStyleStrTwo, instr($CssStyleStrTwo, '{') + 1,-1);
    }
    if( instr($CssStyleStrTwo, '}') > 0 ){
        $CssStyleStrTwo= mid($CssStyleStrTwo, 1, instr($CssStyleStrTwo, '}') - 1);
    }
    $splStr= aspSplit(Replace($CssStyleStr . ';' . $CssStyleStrTwo, vbCrlf(), ''), ';');
    foreach( $splStr as $key=>$s){
        $s= AspTrim($s);
        if( instr($s, ':') > 0 && $s <> '' ){
            $ParamName= AspTrim(mid($s, 1, instr($s, ':') - 1));
            if( instr('|' . $ParamList . '|', '|' . $ParamName . '|')== false ){
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
    $StyleName= AspTrim($StyleName);
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( instr($s, $StyleName) > 0 ){
            $FindStyleName= AspTrim($s);
            if( instr($FindStyleName, '{') > 0 ){
                $FindStyleName= AspTrim(mid($FindStyleName, 1, instr($FindStyleName, '{') - 1));
            }
            if( $FindStyleName== $StyleName ){
                //Call Eerr( FindStyleName , StyleName)
                if( instr($s, '}') > 0 ){
                    $findCssStyle= mid($s, 1, instr($s, '}') + 1);
                    //Call EErr(s,FindCssStyle)
                    return @$findCssStyle;
                }else{
                    $TempS= mid($content, instr($content, $s . vbCrlf()) + 1,-1);
                    $TempS= mid($TempS, 1, instr($TempS, '}') + 1);
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
    $content= getArray($CssStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' && instr($ImageFile, '.') > 0 && instr(vbCrlf() . $listStr . vbCrlf(), vbCrlf() . $ImageFile . vbCrlf())== false ){//对重复使用的图片处理
            $listStr= $listStr . $ImageFile . vbCrlf();
            $fileName= Replace(Replace(Replace($ImageFile, '"', ''), '\'', ''), '\\', '/');
            if( instr($fileName, '/') > 0 ){
                $fileName= mid($fileName, strrpos($fileName, '/') + 1,-1);
            }
            $CssStr= Replace($CssStr, $ImageFile, $dirPath . $fileName);
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

        if( $ImageFile <> '' && instr($ImageFile, '.') > 0 && instr($ImageFile, '{$#')== false ){
            //判断是否有域名 20150202
            if( GetWebSite($ImageFile)== '' ){
                $fileName= Replace(Replace(Replace($ImageFile, '"', ''), '\'', ''), '\\', '/');
                if( instr($fileName, '/') > 0 ){
                    $fileName= mid($fileName, strrpos($fileName, '/') + 1,-1);
                }
                $DivStr= Replace($DivStr, $ImageFile, $dirPath . $ImageFile);
            }
        }
    }
    //图片处理
    //Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '再加个Html背景图片
    $content= GetImgJsUrl($DivStr, '不重复') . vbCrlf() . GetHtmlBackGroundImgList($DivStr); //再加个Html背景图片  加强版20150126
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' ){ //当链接地址当前为HTTP:时则不处理20150313
            $isHandle= false;

            if( substr($ImageFile, 0 , 1)== '\\' ){
                //等处理20150817
            }else if( instr($ImageFile, '.') > 0 && substr($ImageFile, 0 , 5) <> 'HTTP:' && instr($ImageFile, '{$#')== false ){
                $isHandle= true;
            }
            if( $isHandle== true ){
                $ToImageFile= $dirPath . RemoveFileDir($ImageFile); //移除文件路径目录
                //html中图片路径替换
                $DivStr= Replace($DivStr, '"' . $ImageFile . '"', '"' . $ToImageFile . '"');
                $DivStr= Replace($DivStr, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"');
                $DivStr= Replace($DivStr, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"');
                $DivStr= Replace($DivStr, '=' . $ImageFile . '>', '"' . $ToImageFile . '"');
            }
        }
    }
    $handleCutDivCode= $DivStr;
    return @$handleCutDivCode;
}

//获得HTMl里背景图片 20150116  如： <td width="980" height="169" background="kslx3bg.jpg">
function getHtmlBackGroundImgList( $content){
    $content= GetArray($content, ' background="', '"', false, false);
    $content= Replace($content, '$Array$', vbCrlf());
    $getHtmlBackGroundImgList= $content;
    return @$getHtmlBackGroundImgList;
}


//处理网站HTML中Css链接    写得不是特别的完善好  Content = HandleWebHtmlImg("/aa/bb/",Content)  外部调用
function getHandleWebHtmlLink($RootPath, $content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $CssUrl=''; $NewCssUrl=''; $CssStr ='';
    $startStr= '<link ';
    $CssStr= '';
    $endStr= '>';
    $ImgList= GetArray($content, $startStr, $endStr, false, false);
    //Call RwEnd(ImgList)
    $splStr= aspSplit($ImgList, '$Array$');
    foreach( $splStr as $key=>$CssUrl){
        if( $CssUrl <> '' && instr(strtolower($CssUrl), 'stylesheet') > 0 ){
            //获得Css加强版，改于20141125
            $CssUrl= strtolower(Replace(Replace(Replace($CssUrl, '"', ''), '\'', ''), '>', ' ')) . ' ';
            $startStr= 'href=' ; $endStr= ' ';
            if( instr($CssUrl, $startStr) > 0 && instr($CssUrl, $endStr) > 0 ){
                $CssUrl= StrCut($CssUrl, $startStr, $endStr, 2);
            }
            $NewCssUrl= HandleHttpUrl($CssUrl);
            if( instr($NewCssUrl, '/') > 0 ){
                $NewCssUrl= mid($NewCssUrl, strrpos($NewCssUrl, '/') + 1,-1);
            }
            if( strtolower($NewCssUrl) <> 'common.css' && strtolower($NewCssUrl) <> 'public.css' ){
                $NewCssUrl= $RootPath . $NewCssUrl;
                $CssStr= $CssStr . '<link href="' . $NewCssUrl . '" rel="stylesheet" type="text/css" />' . vbCrlf();
            }
        }
    }
    if( $CssStr <> '' ){ $CssStr= substr($CssStr, 0 , Len($CssStr) - 2) ;}
    $getHandleWebHtmlLink= $CssStr;
    return @$getHandleWebHtmlLink;
}


//获得css链接地址列表(20150824)
function getCssListUrlList($content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $CssUrl=''; $CssStr=''; $urlList ='';
    $startStr= '<link ';
    $CssStr= '';
    $endStr= '>';
    $ImgList= GetArray($content, $startStr, $endStr, false, false);
    //Call RwEnd(ImgList)
    $splStr= aspSplit($ImgList, '$Array$');
    foreach( $splStr as $key=>$CssUrl){
        if( $CssUrl <> '' && instr(strtolower($CssUrl), 'stylesheet') > 0 ){
            //获得Css加强版，改于20141125
            $CssUrl= strtolower(Replace(Replace(Replace($CssUrl, '"', ''), '\'', ''), '>', ' ')) . ' ';
            $startStr= 'href=' ; $endStr= ' ';
            if( instr($CssUrl, $startStr) > 0 && instr($CssUrl, $endStr) > 0 ){
                $CssUrl= StrCut($CssUrl, $startStr, $endStr, 2);
            }
            if( instr(vbCrlf() . $urlList . vbCrlf(), vbCrlf() . $CssUrl . vbCrlf())== false ){
                if( $urlList <> '' ){ $urlList= $urlList . vbCrlf() ;}
                $urlList= $urlList . $CssUrl . vbCrlf();
            }
        }
    }
    $getCssListUrlList= $urlList;
    return @$getCssListUrlList;
}

//读Css文件内容并处理(20150824) 如call rwend(handleReadCssContent("E:\E盘\WEB网站\至前网站\DataDir\VB模块\服务器\Template\模块功能列表\B站页面设计\home\home.css","aa",true))
function handleReadCssContent($cssFilePath, $LabelName, $isHandleCss){
    $c=''; $startStr=''; $endStr ='';
    $c= getFText($cssFilePath);
    //截取CSS
    $startStr= '/*CssCodeStart*/';
    $endStr= '/*CssCodeEnd*/';
    if( instr($c, $startStr) > 0 && instr($c, $endStr) > 0 ){
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



//处理Css样式里PX或T
function handleCssPX( $nValue){
    $nValue= strtolower(AspTrim($nValue));
    if( Right($nValue, 1) <> '%' && Right($nValue, 2) <> 'px' ){
        $nValue= $nValue . 'px';
    }
    $handleCssPX= $nValue;
    return @$handleCssPX;
}

//call rw(handleHtmlStyle(getftext("1.html")))
//压缩html里的style样式 (20151008)
function handleHtmlStyle($content){
    $serchS=''; $replaceS=''; $nLength ='';
    $serchS= $content;
    $nLength= instr(strtolower($serchS), '</style>') + 7;
    $serchS= mid($serchS, 1, $nLength);

    $nLength= strrpos(strtolower($serchS), '<style');
    if( $nLength > 0 ){
        $serchS= mid($serchS, $nLength,-1);
    }
    $replaceS= $serchS;
    $replaceS= cssCompression($replaceS, 0) . vbCrlf(); //格式化CSS
    $replaceS= removeBlankLines($replaceS);

    $content= Replace($content, $serchS, $replaceS);
    $handleHtmlStyle= $content;
    return @$handleHtmlStyle;
}

?>