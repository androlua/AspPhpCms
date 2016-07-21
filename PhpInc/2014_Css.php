<?PHP
//Css

//Cssѹ�� cssCompression(Content,0)
function cssCompression($content, $Level){
    $Level= cStr($Level); //ת���ַ����ж�
    //Css�߼�ѹ��
    if( $Level== '1' ){
        $content= regExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', '');
        $content= regExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= regExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{');
        $content= regExp_Replace($content, ';\\s*;', ';');
        //Css��ѹ��
    }else{
        if( $Level >= 2 ){
            $content= regExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////ɾ��ע��
        }
        $content= regExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= regExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{'); ////�ݴ���
        $content= regExp_Replace($content, ';\\s*;', ';'); ////��������ֺ�
        $content= regExp_Replace($content, ';\\s*}', '}'); ////���ĩβ�ֺźʹ�����
        $content= regExp_Replace($content, '([^\\s])\\{([^\\s])', '$1{$2');
        $content= regExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']s*)', '$1}' . vbCrlf() . '$2');

    }
    $content= trimVbCrlf($content);
    $cssCompression= $content;
    return @$cssCompression;
}

//ɾ��Css��ע��
function deleteCssNote($content){
    $deleteCssNote= regExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////ɾ��ע��
    return @$deleteCssNote;
}

//Css��ʽ��  չ��CSS
function unCssCompression($content){
    $content= regExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
    $content= regExp_Replace($content, ';\\s*;', ';'); ////��������ֺ�
    $content= regExp_Replace($content, '\\,[\\s\\.\\#\\d]*{', '{');
    $content= regExp_Replace($content, '([^\\s])\\{([^\\s])', '$1 {' . vbCrlf() . '' . vbTab() . '$2');
    $content= regExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']*)', '$1' . vbCrlf() . '}' . vbCrlf() . '$2');
    $content= regExp_Replace($content, '([^\\s]);([^\\s\\}])', '$1;' . vbCrlf() . '' . vbTab() . '$2');
    $unCssCompression= $content;
    return @$unCssCompression;
}

//ȥ���ַ���ͷβ�������Ļس��Ϳո�
function trimVbCrlf($str){
    $trimVbCrlf= phpRTrim(phpLTrim($str));
    return @$trimVbCrlf;
}

//php��Trim����


//ȥ���ַ�����ͷ�������Ļس��Ϳո�


//ȥ���ַ���ĩβ�������Ļس��Ϳո�



//--------------- ���� ��ʱ�����ļ��� ------------------
//ȥ���ַ���ͷβ��������Tab�˸�Ϳո�
function trimVbTab($str){
    $trimVbTab= rTrimVBTab(lTrimVbTab($str));
    return @$trimVbTab;
}


//ȥ���ַ�����ͷ��������Tab�˸�Ϳո�
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

//ȥ���ַ���ĩβ��������Tab�˸�Ϳո�
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


//��Htmlҳ��Css Style <style></style> ��css����
function getHtmlCssStyle( $content){
    $getHtmlCssStyle= handleHtmlStyleCss($content,'','');
    return @$getHtmlCssStyle;
}
//����html���css �滻·��
function handleHtmlStyleCss($content,$sType,$imgPath){
    $splStr=''; $s=''; $StyleYes=''; $StyleStartStr=''; $StyleEndStr=''; $StyleStr=''; $CssStr ='';$newCssStr='';
    $splStr= aspSplit($content, vbCrlf()); //�ָ���
    $StyleYes= false; //Css��ʽĬ��Ϊ��
    //ѭ������
    foreach( $splStr as $key=>$s){
        if( $StyleYes== false ){
            if( inStr(lCase($s), '<style') > 0 ){
                $StyleStartStr= mid($s, inStr(lCase($s), '<style'),-1);
                $StyleStartStr= mid($StyleStartStr, 1, inStr($StyleStartStr, '>'));
                $StyleEndStr= mid($s, inStr(lCase($s), $StyleStartStr) + len($StyleStartStr),-1);
                //HTML�ж����Css��һ��
                if( inStr($StyleEndStr, '</style>') > 0 ){
                    $StyleStr= mid($StyleEndStr, 1, inStr($StyleEndStr, '</style>') - 1);
                    $CssStr= $CssStr . $StyleStr . vbCrlf();
                }else{
                    $CssStr= $CssStr . $StyleEndStr . vbCrlf();
                    $StyleYes= true; //�ռ�CssStyle��ʽ��ʼ
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

                if( $sType=='�滻·��' ){
                    $newCssStr=replaceCssImgPath($CssStr,$imgPath);
                    $content=replace($content,phpTrim($cssstr),$newCssStr);
                }

                $StyleYes= false; //�ռ�CssStyle��ʽ����
            }else{
                $CssStr= $CssStr . $s . vbCrlf();
            }
        }
    }
    if( $sType=='�滻·��' ){
        $handleHtmlStyleCss=$content;
    }else{
        $handleHtmlStyleCss=$cssStr;
    }
    return @$handleHtmlStyleCss;
}

//�滻css������ͼƬ·�� 20160718home
function replaceCssImgPath( $cssStr, $imgPath){
    $content='';$splstr='';$s='';$c='';$fileName='';$toImgPath='';
    $content=GetArray($cssStr,'\\(','\\)',false,false);
    $splstr=aspSplit($content,'$Array$');
    foreach( $splstr as $key=>$s){
        if( $s <>'' ){
            $fileName=getFileAttr($s,2);
            //����ͼƬ
            if( inStr(lCase($s),'data:image')==false ){
                $cssStr=replace($cssStr,'('. $s .')','(' . $imgPath . $fileName . ')');
                //fileName="data:image/" & fileName
            }

        }
    }
    $replaceCssImgPath=$cssStr;
    return @$replaceCssImgPath;
}

//����ɸɾ���Css����  CSS��ʽ��
function handleCleanCss( $content){
    $splStr=''; $s=''; $c=''; $AddStrYes=''; $CustomS ='';
    $content= replace($content, '{', vbCrlf() . '{' . vbCrlf());
    $content= replace($content, '}', vbCrlf() . '}' . vbCrlf());
    $content= replace($content, ';', ';' . vbCrlf());

    $splStr= aspSplit($content, vbCrlf());
    $AddStrYes= false; //׷���ַ�Ĭ��Ϊ��
    foreach( $splStr as $key=>$s){
        $s= trimVbCrlf($s);
        $CustomS= ''; //�Զ���Sֵ
        if( $s <> '' ){
            if( inStr($s, '{') > 0 && inStr($s, '}')== false ){
                $AddStrYes= true;
                $CustomS= $s;
            }else if( inStr($s, '}') > 0 ){
                $AddStrYes= false;
            }
            if( left($s, 1) <> '{' ){ $c= $c . vbCrlf() ;}
            if( $AddStrYes== true ){ $s= '    ' . $s ;}
            if( $CustomS <> '' ){ $s= $CustomS ;}//�Զ���ֵ��Ϊ�������Զ�������
            $c= $c . $s;

        }
    }
    $c= trimVbCrlf($c);
    $c=replace($c,'    ;'.vbCrlf(),'');			//������ڵķֺ�
    $c=replace($c,';'. vbCrlf() .'}', vbCrlf() . '}');			//���һ��������Ҫ�ֺ�
    $handleCleanCss= $c;
    return @$handleCleanCss;
}



//�Ƴ������ж����
function removeExcessRow($content){
    $splStr=''; $s=''; $c=''; $TempS ='';
    $splStr= aspSplit($content, vbCrlf()); //�ָ���
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
//��Css��׷����ʽ  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
function cssAddToStyle($content, $AddToStyle){
    $StyleName=''; $YunStyleStr=''; $ReplaceStyleStr=''; $c ='';
    if( inStr($AddToStyle, '{') > 0 ){
        $StyleName= aspTrim(mid($AddToStyle, 1, inStr($AddToStyle, '{') - 1));
    }
    $YunStyleStr= findCssStyle($content, $StyleName);
    $ReplaceStyleStr= cssStyleAddToParam($YunStyleStr, $AddToStyle); //Css��ʽ�ۼӲ���
    $content= replace($content, $YunStyleStr, $ReplaceStyleStr);
    //C = C & "<hr>Content=" & Content
    $cssAddToStyle= $content;
    //CssAddToStyle = YunStyleStr
    //CssAddToStyle = "StyleName=" & StyleName & "<hr>YunStyleStr=" & YunStyleStr & "<hr>ReplaceStyleStr=" & ReplaceStyleStr
    return @$cssAddToStyle;
}

//���Css�������Ƿ���ָ����ʽ
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


//Css��ʽ�ۼӲ���
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

//����Css�����ҵ���ӦCss��
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
//������վǰ��Ҫ�õ�
//================================================
//�����ȡ����Css
function handleCutCssCode($dirPath, $CssStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $fileName=''; $listStr ='';
    $startStr= 'url\\(' ; $endStr= '\\)';
    $content= GetArray($CssStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' && inStr($ImageFile, '.') > 0 && inStr(vbCrlf() . $listStr . vbCrlf(), vbCrlf() . $ImageFile . vbCrlf())== false ){//���ظ�ʹ�õ�ͼƬ����
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

//�����ȡ����HtmlDiv
function handleCutDivCode($dirPath, $DivStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $ToImageFile=''; $fileName=''; $isHandle ='';
    $startStr= 'url\\(' ; $endStr= '\\)';
    $content= GetArray($DivStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){

        if( $ImageFile <> '' && inStr($ImageFile, '.') > 0 && inStr($ImageFile, '{$#')== false ){
            //�ж��Ƿ������� 20150202
            if( getWebSite($ImageFile)== '' ){
                $fileName= replace(replace(replace($ImageFile, '"', ''), '\'', ''), '\\', '/');
                if( inStr($fileName, '/') > 0 ){
                    $fileName= mid($fileName, inStrRev($fileName, '/') + 1,-1);
                }
                $DivStr= replace($DivStr, $ImageFile, $dirPath . $ImageFile);
            }
        }
    }
    //ͼƬ����
    //Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '�ټӸ�Html����ͼƬ
    $content= getImgJsUrl($DivStr, '���ظ�') . vbCrlf() . getHtmlBackGroundImgList($DivStr); //�ټӸ�Html����ͼƬ  ��ǿ��20150126
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' ){ //�����ӵ�ַ��ǰΪHTTP:ʱ�򲻴���20150313
            $isHandle= false;

            if( left($ImageFile, 1)== '\\' ){
                //�ȴ���20150817
            }else if( inStr($ImageFile, '.') > 0 && left($ImageFile, 5) <> 'HTTP:' && inStr($ImageFile, '{$#')== false ){
                $isHandle= true;
            }
            if( $isHandle== true ){
                $ToImageFile= $dirPath . removeFileDir($ImageFile); //�Ƴ��ļ�·��Ŀ¼
                //html��ͼƬ·���滻
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

//���HTMl�ﱳ��ͼƬ 20150116  �磺 <td width="980" height="169" background="kslx3bg.jpg">
function getHtmlBackGroundImgList( $content){
    $content= GetArray($content, ' background="', '"', false, false);
    $content= replace($content, '$Array$', vbCrlf());
    $getHtmlBackGroundImgList= $content;
    return @$getHtmlBackGroundImgList;
}


//����html��link css���� Content = getHandleWebHtmlLink("/aa/bb/",Content)  �ⲿ����
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
            //���Css��ǿ�棬����20141125
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


//���css���ӵ�ַ�б�(20150824)  ��<link>
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
            //���Css��ǿ�棬����20141125
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
//ѹ��html���style��ʽ (20151008)
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
    $replaceS= cssCompression($replaceS, 0) . vbCrlf(); //��ʽ��CSS
    $replaceS= removeBlankLines($replaceS);

    $content= replace($content, $serchS, $replaceS);
    $handleHtmlStyle= $content;
    return @$handleHtmlStyle;
}



//��Css�ļ����ݲ�����(20150824) �������¼��ǩ   ������
//��call rwend(handleReadCssContent("E:\E��\WEB��վ\��ǰ��վ\DataDir\VBģ��\������\Template\ģ�鹦���б�\Bվҳ�����\home\home.css","aa",true))
function handleReadCssContent($cssFilePath, $LabelName, $isHandleCss){
    $c=''; $startStr=''; $endStr ='';
    $c= getFText($cssFilePath);
    //��ȡCSS
    $startStr= '/*CssCodeStart*/';
    $endStr= '/*CssCodeEnd*/';
    if( inStr($c, $startStr) > 0 && inStr($c, $endStr) > 0 ){
        $c= StrCut($c, $startStr, $endStr, 2);
    }
    //����CSS
    if( $isHandleCss== true ){
        $c= cssCompression($c, 0);
    }
    if( $LabelName <> '' ){
        $c= '/*' . $LabelName . ' start*/' . $c . '/*' . $LabelName . ' end*/';
    }
    $handleReadCssContent= $c;
    return @$handleReadCssContent;
}

//����Css��ʽ��PX��%
function handleCssPX( $nValue){
    $nValue= lCase(aspTrim($nValue));
    if( right($nValue, 1) <> '%' && right($nValue, 2) <> 'px' ){
        $nValue= $nValue . 'px';
    }
    $handleCssPX= $nValue;
    return @$handleCssPX;
}

?>