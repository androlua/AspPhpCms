<?PHP
//Css

//Cssѹ�� cssCompression(Content,0)
function cssCompression($content, $Level){
    $Level= CStr($Level); //ת���ַ����ж�
    //Css�߼�ѹ��
    if( $Level== '1' ){
        $content= RegExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', '');
        $content= RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{');
        $content= RegExp_Replace($content, ';\\s*;', ';');
        //Css��ѹ��
    }else{
        if( $Level >= 2 ){
            $content= RegExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////ɾ��ע��
        }
        $content= RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
        $content= RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{'); ////�ݴ���
        $content= RegExp_Replace($content, ';\\s*;', ';'); ////��������ֺ�
        $content= RegExp_Replace($content, ';\\s*}', '}'); ////���ĩβ�ֺźʹ�����
        $content= RegExp_Replace($content, '([^\\s])\\{([^\\s])', '$1{$2');
        $content= RegExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']s*)', '$1}' . vbCrlf() . '$2');

    }
    $content= trimVBcrlf($content);
    $cssCompression= $content;
    return @$cssCompression;
}

//ɾ��Css��ע��
function deleteCssNote($content){
    $deleteCssNote= RegExp_Replace($content, '\\/\\*(.|' . vbCrlf() . ')*?\\*\\/', ''); ////ɾ��ע��
    return @$deleteCssNote;
}

//Css��ʽ��  չ��CSS
function unCssCompression($content){
    $content= RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1');
    $content= RegExp_Replace($content, ';\\s*;', ';'); ////��������ֺ�
    $content= RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*{', '{');
    $content= RegExp_Replace($content, '([^\\s])\\{([^\\s])', '$1 {' . vbCrlf() . '' . "\t" . '$2');
    $content= RegExp_Replace($content, '([^\\s])\\}([^' . vbCrlf() . ']*)', '$1' . vbCrlf() . '}' . vbCrlf() . '$2');
    $content= RegExp_Replace($content, '([^\\s]);([^\\s\\}])', '$1;' . vbCrlf() . '' . "\t" . '$2');
    $unCssCompression= $content;
    return @$unCssCompression;
}

//ȥ���ַ���ͷβ�������Ļس��Ϳո�
function trimVbCrlf($str){
    $trimVbCrlf= PHPRTrim(PHPLTrim($str));
    return @$trimVbCrlf;
}

//PHP��Trim����


//ȥ���ַ�����ͷ�������Ļس��Ϳո�


//ȥ���ַ���ĩβ�������Ļس��Ϳո�



//--------------- ���� ��ʱ�����ļ��� ------------------
//ȥ���ַ���ͷβ��������Tab�˸�Ϳո�
function trimVbTab($str){
    $trimVbTab= RTrimVBTab(LTrimVbTab($str));
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
        }else if( mid($str, $pos, 1)== "\t" ){
            $pos= $pos + 1;
        }else{
            $isBlankChar= false;
        }
    }
    $lTrimVbTab= Right($str, Len($str) - $pos + 1);
    return @$lTrimVbTab;
}

//ȥ���ַ���ĩβ��������Tab�˸�Ϳո�
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


//��Htmlҳ��Css Style
function getHtmlCssStyle( $content){
    $splStr=''; $s=''; $StyleYes=''; $StyleStartStr=''; $StyleEndStr=''; $StyleStr=''; $CssStr ='';
    $splStr= aspSplit($content, vbCrlf()); //�ָ���
    $StyleYes= false; //Css��ʽĬ��Ϊ��
    //ѭ������
    foreach( $splStr as $key=>$s){
        if( $StyleYes== false ){
            if( instr(strtolower($s), '<style') > 0 ){
                $StyleStartStr= mid($s, instr(strtolower($s), '<style'),-1);
                $StyleStartStr= mid($StyleStartStr, 1, instr($StyleStartStr, '>'));
                $StyleEndStr= mid($s, instr(strtolower($s), $StyleStartStr) + Len($StyleStartStr),-1);
                //HTML�ж����Css��һ��
                if( instr($StyleEndStr, '</style>') > 0 ){
                    $StyleStr= mid($StyleEndStr, 1, instr($StyleEndStr, '</style>') - 1);
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
            if( instr(strtolower($s), '</style>') > 0 ){
                $StyleStr= mid($s, 1, instr(strtolower($s), '</style>') - 1);
                $CssStr= $CssStr . $StyleStr . vbCrlf();
                //Call Echo("StyleStr2",ShowHtml(StyleStr))
                //Call Echo("CssStr2",ShowHtml(CssStr))
                //Call RwEnd("")
                $StyleYes= false; //�ռ�CssStyle��ʽ����
            }else{
                $CssStr= $CssStr . $s . vbCrlf();
            }
        }
    }
    $getHtmlCssStyle= $CssStr;
    return @$getHtmlCssStyle;
}

//����ɸɾ���Css����  CSS��ʽ��
function handleCleanCss( $content){
    $splStr=''; $s=''; $c=''; $AddStrYes=''; $CustomS ='';
    $content= Replace($content, '{', vbCrlf() . '{' . vbCrlf());
    $content= Replace($content, '}', vbCrlf() . '}' . vbCrlf());
    $content= Replace($content, ';', ';' . vbCrlf());

    $splStr= aspSplit($content, vbCrlf());
    $AddStrYes= false; //׷���ַ�Ĭ��Ϊ��
    foreach( $splStr as $key=>$s){
        $s= trimVbCrlf($s);
        $CustomS= ''; //�Զ���Sֵ
        if( $s <> '' ){
            if( instr($s, '{') > 0 && instr($s, '}')== false ){
                $AddStrYes= true;
                $CustomS= $s;
            }else if( instr($s, '}') > 0 ){
                $AddStrYes= false;
            }
            if( substr($s, 0 , 1) <> '{' ){ $c= $c . vbCrlf() ;}
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
//��Css��׷����ʽ  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
function cssAddToStyle($content, $AddToStyle){
    $StyleName=''; $YunStyleStr=''; $ReplaceStyleStr=''; $c ='';
    if( instr($AddToStyle, '{') > 0 ){
        $StyleName= AspTrim(mid($AddToStyle, 1, instr($AddToStyle, '{') - 1));
    }
    $YunStyleStr= FindCssStyle($content, $StyleName);
    $ReplaceStyleStr= CssStyleAddToParam($YunStyleStr, $AddToStyle); //Css��ʽ�ۼӲ���
    $content= Replace($content, $YunStyleStr, $ReplaceStyleStr);
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


//Css��ʽ�ۼӲ���
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

//����Css�����ҵ���ӦCss��
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
//������վǰ��Ҫ�õ�
//================================================
//�����ȡ����Css
function handleCutCssCode($dirPath, $CssStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $fileName=''; $listStr ='';
    $startStr= 'url\\(' ; $endStr= '\\)';
    $content= getArray($CssStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' && instr($ImageFile, '.') > 0 && instr(vbCrlf() . $listStr . vbCrlf(), vbCrlf() . $ImageFile . vbCrlf())== false ){//���ظ�ʹ�õ�ͼƬ����
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

//�����ȡ����HtmlDiv
function handleCutDivCode($dirPath, $DivStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $ToImageFile=''; $fileName=''; $isHandle ='';
    $startStr= 'url\\(' ; $endStr= '\\)';
    $content= GetArray($DivStr, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$ImageFile){

        if( $ImageFile <> '' && instr($ImageFile, '.') > 0 && instr($ImageFile, '{$#')== false ){
            //�ж��Ƿ������� 20150202
            if( GetWebSite($ImageFile)== '' ){
                $fileName= Replace(Replace(Replace($ImageFile, '"', ''), '\'', ''), '\\', '/');
                if( instr($fileName, '/') > 0 ){
                    $fileName= mid($fileName, strrpos($fileName, '/') + 1,-1);
                }
                $DivStr= Replace($DivStr, $ImageFile, $dirPath . $ImageFile);
            }
        }
    }
    //ͼƬ����
    //Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '�ټӸ�Html����ͼƬ
    $content= GetImgJsUrl($DivStr, '���ظ�') . vbCrlf() . GetHtmlBackGroundImgList($DivStr); //�ټӸ�Html����ͼƬ  ��ǿ��20150126
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$ImageFile){
        if( $ImageFile <> '' ){ //�����ӵ�ַ��ǰΪHTTP:ʱ�򲻴���20150313
            $isHandle= false;

            if( substr($ImageFile, 0 , 1)== '\\' ){
                //�ȴ���20150817
            }else if( instr($ImageFile, '.') > 0 && substr($ImageFile, 0 , 5) <> 'HTTP:' && instr($ImageFile, '{$#')== false ){
                $isHandle= true;
            }
            if( $isHandle== true ){
                $ToImageFile= $dirPath . RemoveFileDir($ImageFile); //�Ƴ��ļ�·��Ŀ¼
                //html��ͼƬ·���滻
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

//���HTMl�ﱳ��ͼƬ 20150116  �磺 <td width="980" height="169" background="kslx3bg.jpg">
function getHtmlBackGroundImgList( $content){
    $content= GetArray($content, ' background="', '"', false, false);
    $content= Replace($content, '$Array$', vbCrlf());
    $getHtmlBackGroundImgList= $content;
    return @$getHtmlBackGroundImgList;
}


//������վHTML��Css����    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)  �ⲿ����
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
            //���Css��ǿ�棬����20141125
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


//���css���ӵ�ַ�б�(20150824)
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
            //���Css��ǿ�棬����20141125
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

//��Css�ļ����ݲ�����(20150824) ��call rwend(handleReadCssContent("E:\E��\WEB��վ\��ǰ��վ\DataDir\VBģ��\������\Template\ģ�鹦���б�\Bվҳ�����\home\home.css","aa",true))
function handleReadCssContent($cssFilePath, $LabelName, $isHandleCss){
    $c=''; $startStr=''; $endStr ='';
    $c= getFText($cssFilePath);
    //��ȡCSS
    $startStr= '/*CssCodeStart*/';
    $endStr= '/*CssCodeEnd*/';
    if( instr($c, $startStr) > 0 && instr($c, $endStr) > 0 ){
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



//����Css��ʽ��PX��T
function handleCssPX( $nValue){
    $nValue= strtolower(AspTrim($nValue));
    if( Right($nValue, 1) <> '%' && Right($nValue, 2) <> 'px' ){
        $nValue= $nValue . 'px';
    }
    $handleCssPX= $nValue;
    return @$handleCssPX;
}

//call rw(handleHtmlStyle(getftext("1.html")))
//ѹ��html���style��ʽ (20151008)
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
    $replaceS= cssCompression($replaceS, 0) . vbCrlf(); //��ʽ��CSS
    $replaceS= removeBlankLines($replaceS);

    $content= Replace($content, $serchS, $replaceS);
    $handleHtmlStyle= $content;
    return @$handleHtmlStyle;
}

?>