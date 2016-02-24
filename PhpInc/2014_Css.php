<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-24
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By �ƶ� 
************************************************************/
?>
<?PHP
//Css

//Cssѹ�� CssCompression(Content,0)
function cssCompression($content, $Level){
    $Level = CStr($Level) ;//ת���ַ����ж�
    //Css�߼�ѹ��
    if( $Level == '1' ){
        $content = RegExp_Replace($content, '\\/\\*(.|' . "\n" . ')*?\\*\\/', '') ;
        $content = RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1') ;
        $content = RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{') ;
        $content = RegExp_Replace($content, ';\\s*;', ';') ;
        //Css��ѹ��
    }else{
        if( $Level >= 2 ){
            $content = RegExp_Replace($content, '\\/\\*(.|' . "\n" . ')*?\\*\\/', '') ;////ɾ��ע��
        }
        $content = RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1') ;
        $content = RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*\\{', '{') ;////�ݴ���
        $content = RegExp_Replace($content, ';\\s*;', ';') ;////��������ֺ�
        $content = RegExp_Replace($content, ';\\s*}', '}') ;////���ĩβ�ֺźʹ�����
        $content = RegExp_Replace($content, '([^\\s])\\{([^\\s])', '$1{$2') ;
        $content = RegExp_Replace($content, '([^\\s])\\}([^' . "\n" . ']s*)', '$1}' . "\n" . '$2') ;



    }
    $content = trimVBcrlf($content) ;
    $cssCompression = $content ;
    return @$cssCompression;
}

//ɾ��Css��ע��
function deleteCssNote($content){
    $deleteCssNote = RegExp_Replace($content, '\\/\\*(.|' . "\n" . ')*?\\*\\/', '') ;////ɾ��ע��
    return @$deleteCssNote;
}

//Css��ʽ��  չ��CSS
function unCssCompression($content){
    $content = RegExp_Replace($content, '\\s*([\\{\\}\\:\\;\\,])\\s*', '$1') ;
    $content = RegExp_Replace($content, ';\\s*;', ';') ;////��������ֺ�
    $content = RegExp_Replace($content, '\\,[\\s\\.\\#\\d]*{', '{') ;
    $content = RegExp_Replace($content, '([^\\s])\\{([^\\s])', '$1 {' . "\n" . '' . "\t" . '$2') ;
    $content = RegExp_Replace($content, '([^\\s])\\}([^' . "\n" . ']*)', '$1' . "\n" . '}' . "\n" . '$2') ;
    $content = RegExp_Replace($content, '([^\\s]);([^\\s\\}])', '$1;' . "\n" . '' . "\t" . '$2') ;
    $unCssCompression = $content ;
    return @$unCssCompression;
}

//ȥ���ַ���ͷβ�������Ļس��Ϳո�
function trimVbCrlf($str){
    $trimVbCrlf = rtrimVBcrlf(ltrimVBcrlf($str)) ;
    return @$trimVbCrlf;
}

//PHP��Trim����


//ȥ���ַ�����ͷ�������Ļس��Ϳո�
function ltrimVBcrlf($str){
    $pos=''; $isBlankChar ='';
    $pos = 1 ;
    $isBlankChar = true ;
    while( $isBlankChar){
        if( mid($str, $pos, 1) == ' ' || mid($str, $pos, 1) == "\t" ){ //��vbTabҲȥ��
            $pos = $pos + 1 ;
        }else if( mid($str, $pos, 2) == "\n" ){
            $pos = $pos + 2 ;
        }else{
            $isBlankChar = false ;
        }
    }
    $ltrimVBcrlf = substr($str, - strlen($str) - $pos + 1) ;
    return @$ltrimVBcrlf;
}

//ȥ���ַ���ĩβ�������Ļس��Ϳո�
function rtrimVBcrlf($str){
    $pos=''; $isBlankChar ='';
    $pos = strlen($str) ;
    $isBlankChar = true ;
    while( $isBlankChar && $pos >= 2){
        if( mid($str, $pos, 1) == ' ' || mid($str, $pos, 1) == "\t" ){ //��vbTabҲȥ��
            $pos = $pos - 1 ;
        }else if( mid($str, $pos - 1, 2) == "\n" ){
            $pos = $pos - 2 ;
        }else{
            $isBlankChar = false ;
        }
    }
    $rtrimVBcrlf = AspRTrim(substr($str, 0 , $pos)) ;
    return @$rtrimVBcrlf;
}


//--------------- ���� ��ʱ�����ļ��� ------------------
//ȥ���ַ���ͷβ��������Tab�˸�Ϳո�
function trimVbTab($str){
    $trimVbTab = RTrimVBTab(LTrimVbTab($str)) ;
    return @$trimVbTab;
}


//ȥ���ַ�����ͷ��������Tab�˸�Ϳո�
function lTrimVbTab($str){
    $pos=''; $isBlankChar ='';
    $pos = 1 ;
    $isBlankChar = true ;
    while( $isBlankChar){
        if( mid($str, $pos, 1) == ' ' ){
            $pos = $pos + 1 ;
        }else if( mid($str, $pos, 1) == "\t" ){
            $pos = $pos + 1 ;
        }else{
            $isBlankChar = false ;
        }
    }
    $lTrimVbTab = substr($str, - strlen($str) - $pos + 1) ;
    return @$lTrimVbTab;
}

//ȥ���ַ���ĩβ��������Tab�˸�Ϳո�
function rTrimVBTab($str){
    $pos=''; $isBlankChar ='';
    $pos = strlen($str) ;
    $isBlankChar = true ;
    while( $isBlankChar && $pos >= 2){
        if( mid($str, $pos, 1) == ' ' ){
            $pos = $pos - 1 ;
        }else if( mid($str, $pos - 1, 1) == "\t" ){
            $pos = $pos - 1 ;
        }else{
            $isBlankChar = false ;
        }
    }
    $rTrimVBTab = AspRTrim(substr($str, 0 , $pos)) ;
    return @$rTrimVBTab;
}


//��Htmlҳ��Css Style
function getHtmlCssStyle( $content){
    $splStr=''; $s=''; $StyleYes=''; $StyleStartStr=''; $StyleEndStr=''; $StyleStr=''; $CssStr ='';
    $splStr = aspSplit($content, "\n") ;//�ָ���
    $StyleYes = false ;//Css��ʽĬ��Ϊ��
    //ѭ������
    foreach( $splStr as $s){
        if( $StyleYes == false ){
            if( instr(LCase($s), '<style') > 0 ){
                $StyleStartStr = mid($s, instr(LCase($s), '<style'),-1) ;
                $StyleStartStr = mid($StyleStartStr, 1, instr($StyleStartStr, '>')) ;
                $StyleEndStr = mid($s, instr(LCase($s), $StyleStartStr) + strlen($StyleStartStr),-1) ;
                //HTML�ж����Css��һ��
                if( instr($StyleEndStr, '</style>') > 0 ){
                    $StyleStr = mid($StyleEndStr, 1, instr($StyleEndStr, '</style>') - 1) ;
                    $CssStr = $CssStr . $StyleStr . "\n" ;
                }else{
                    $CssStr = $CssStr . $StyleEndStr . "\n" ;
                    $StyleYes = true ;//�ռ�CssStyle��ʽ��ʼ
                }
                //Call Echo("StyleStartStr",ShowHtml(StyleStartStr))
                //Call Echo("StyleEndStr",ShowHtml(StyleEndStr))
                //Call Echo("StyleStr",ShowHtml(StyleStr))
                //Call Echo("CssStr",ShowHtml(CssStr))
                //Call RwEnd("")
            }
        }else if( $StyleYes == true ){
            if( instr(LCase($s), '</style>') > 0 ){
                $StyleStr = mid($s, 1, instr(LCase($s), '</style>') - 1) ;
                $CssStr = $CssStr . $StyleStr . "\n" ;
                //Call Echo("StyleStr2",ShowHtml(StyleStr))
                //Call Echo("CssStr2",ShowHtml(CssStr))
                //Call RwEnd("")
                $StyleYes = false ;//�ռ�CssStyle��ʽ����
            }else{
                $CssStr = $CssStr . $s . "\n" ;
            }
        }
    }
    $getHtmlCssStyle = $CssStr ;
    return @$getHtmlCssStyle;
}

//����ɸɾ���Css����
function handleCleanCss( $content){
    $splStr=''; $s=''; $c=''; $AddStrYes=''; $CustomS ='';
    $content = Replace($content, '{', "\n" . '{' . "\n") ;
    $content = Replace($content, '}', "\n" . '}' . "\n") ;
    $content = Replace($content, ';', ';' . "\n") ;

    $splStr = aspSplit($content, "\n") ;
    $AddStrYes = false ;//׷���ַ�Ĭ��Ϊ��
    foreach( $splStr as $s){
        $s = trimVbCrlf($s) ;
        $CustomS = '' ;//�Զ���Sֵ
        if( $s <> '' ){
            if( instr($s, '{') > 0 && instr($s, '}') == false ){
                $AddStrYes = true ;
                $CustomS = $s ;
            }else if( instr($s, '}') > 0 ){
                $AddStrYes = false ;
            }
            if( substr($s, 0 , 1) <> '{' ){ $c = $c . "\n" ;}
            if( $AddStrYes == true ){ $s = '    ' . $s ;}
            if( $CustomS <> '' ){ $s = $CustomS ;}//�Զ���ֵ��Ϊ�������Զ�������
            $c = $c . $s ;

        }
    }
    $c = trimVbCrlf($c) ;
    $handleCleanCss = $c ;
    return @$handleCleanCss;
}



//�Ƴ������ж����
function removeExcessRow($content){
    $splStr=''; $s=''; $c=''; $TempS ='';
    $splStr = aspSplit($content, "\n") ;//�ָ���
    foreach( $splStr as $s){
        $TempS = Replace(Replace($s, ' ', ''), "\t", '') ;
        if( $TempS <> '' ){
            $c = $c . $s . "\n" ;
        }
    }
    if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - 2) ;}
    $removeExcessRow = $c ;
    return @$removeExcessRow;
}


//2014 11 30
//��Css��׷����ʽ  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
function cssAddToStyle($content, $AddToStyle){
    $StyleName=''; $YunStyleStr=''; $ReplaceStyleStr=''; $c ='';
    if( instr($AddToStyle, '{') > 0 ){
        $StyleName = AspTrim(mid($AddToStyle, 1, instr($AddToStyle, '{') - 1)) ;
    }
    $YunStyleStr = FindCssStyle($content, $StyleName) ;
    $ReplaceStyleStr = CssStyleAddToParam($YunStyleStr, $AddToStyle) ;//Css��ʽ�ۼӲ���
    $content = Replace($content, $YunStyleStr, $ReplaceStyleStr) ;
    //C = C & "<hr>Content=" & Content
    $cssAddToStyle = $content ;
    //CssAddToStyle = YunStyleStr
    //CssAddToStyle = "StyleName=" & StyleName & "<hr>YunStyleStr=" & YunStyleStr & "<hr>ReplaceStyleStr=" & ReplaceStyleStr
    return @$cssAddToStyle;
}

//���Css�������Ƿ���ָ����ʽ
function checkCssStyle($content, $StyleStr){
    $StyleName ='';
    $checkCssStyle = true ;
    if( instr($StyleStr, '{') > 0 ){
        $StyleName = AspTrim(mid($StyleStr, 1, instr($StyleStr, '{') - 1)) ;
    }
    if( $StyleName == '' ){
        $checkCssStyle = false ;
    }else if( FindCssStyle($content, $StyleName) == '' ){
        $checkCssStyle = false ;
    }
    return @$checkCssStyle;
}


//Css��ʽ�ۼӲ���
function cssStyleAddToParam( $CssStyleStr, $CssStyleStrTwo){
    $splStr=''; $CssStr=''; $s=''; $ParamList=''; $ParamName=''; $CssStyleName ='';
    $CssStyleName = mid($CssStyleStr, 1, instr($CssStyleStr, '{')) ;
    if( instr($CssStyleStr, '{') > 0 ){
        $CssStyleStr = mid($CssStyleStr, instr($CssStyleStr, '{') + 1,-1) ;
    }
    if( instr($CssStyleStr, '}') > 0 ){
        $CssStyleStr = mid($CssStyleStr, 1, instr($CssStyleStr, '}') - 1) ;
    }
    if( instr($CssStyleStrTwo, '{') > 0 ){
        $CssStyleStrTwo = mid($CssStyleStrTwo, instr($CssStyleStrTwo, '{') + 1,-1) ;
    }
    if( instr($CssStyleStrTwo, '}') > 0 ){
        $CssStyleStrTwo = mid($CssStyleStrTwo, 1, instr($CssStyleStrTwo, '}') - 1) ;
    }
    $splStr = aspSplit(Replace($CssStyleStr . ';' . $CssStyleStrTwo, "\n", ''), ';') ;
    foreach( $splStr as $s){
        $s = AspTrim($s) ;
        if( instr($s, ':') > 0 && $s <> '' ){
            $ParamName = AspTrim(mid($s, 1, instr($s, ':') - 1)) ;
            if( instr('|' . $ParamList . '|', '|' . $ParamName . '|') == false ){
                $ParamList = $ParamList . $ParamName . '|' ;
                //Call Echo("ParamName",ParamName)
                $CssStr = $CssStr . '    ' . $s . ';' . "\n" ;
            }
        }
    }
    if( $CssStyleName <> '' ){
        $CssStr = $CssStyleName . "\n" . $CssStr . '}' ;
    }
    $cssStyleAddToParam = $CssStr ;
    //Call Echo(CssStyleStr,CssStyleStrTwo)
    return @$cssStyleAddToParam;
}

//����Css�����ҵ���ӦCss��
function findCssStyle( $content, $StyleName){
    $splStr=''; $s=''; $TempS=''; $FindStyleName ='';
    //CAll Echo("StyleName",StyleName)
    //CAll Echo("Content",Content)
    $StyleName = AspTrim($StyleName) ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        if( instr($s, $StyleName) > 0 ){
            $FindStyleName = AspTrim($s) ;
            if( instr($FindStyleName, '{') > 0 ){
                $FindStyleName = AspTrim(mid($FindStyleName, 1, instr($FindStyleName, '{') - 1)) ;
            }
            if( $FindStyleName == $StyleName ){
                //Call Eerr( FindStyleName , StyleName)
                if( instr($s, '}') > 0 ){
                    $findCssStyle = mid($s, 1, instr($s, '}') + 1) ;
                    //Call EErr(s,FindCssStyle)
                    return @$findCssStyle;
                }else{
                    $TempS = mid($content, instr($content, $s . "\n") + 1,-1) ;
                    $TempS = mid($TempS, 1, instr($TempS, '}') + 1) ;
                    $findCssStyle = $TempS ;
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
    $startStr = 'url\\(' ; $endStr = '\\)' ;
    $content = getArray($CssStr, $startStr, $endStr, false, false) ;
    $splStr = aspSplit($content, '$Array$') ;
    foreach( $splStr as $ImageFile){
        if( $ImageFile <> '' && instr($ImageFile, '.') > 0 && instr("\n" . $listStr . "\n", "\n" . $ImageFile . "\n") == false ){//���ظ�ʹ�õ�ͼƬ����
            $listStr = $listStr . $ImageFile . "\n" ;
            $fileName = Replace(Replace(Replace($ImageFile, '"', ''), '\'', ''), '\\', '/') ;
            if( instr($fileName, '/') > 0 ){
                $fileName = mid($fileName, strrpos($fileName, '/') + 1,-1) ;
            }
            $CssStr = Replace($CssStr, $ImageFile, $dirPath . $fileName) ;
        }
    }
    $handleCutCssCode = $CssStr ;
    return @$handleCutCssCode;
}

//�����ȡ����HtmlDiv
function handleCutDivCode($dirPath, $DivStr){
    $content=''; $startStr=''; $endStr=''; $splStr=''; $ImageFile=''; $ToImageFile=''; $fileName=''; $isHandle ='';
    $startStr = 'url\\(' ; $endStr = '\\)' ;
    $content = GetArray($DivStr, $startStr, $endStr, false, false) ;
    $splStr = aspSplit($content, '$Array$') ;
    foreach( $splStr as $ImageFile){

        if( $ImageFile <> '' && instr($ImageFile, '.') > 0 && instr($ImageFile, '{$#') == false ){
            //�ж��Ƿ������� 20150202
            if( GetWebSite($ImageFile) == '' ){
                $fileName = Replace(Replace(Replace($ImageFile, '"', ''), '\'', ''), '\\', '/') ;
                if( instr($fileName, '/') > 0 ){
                    $fileName = mid($fileName, strrpos($fileName, '/') + 1,-1) ;
                }
                $DivStr = Replace($DivStr, $ImageFile, $dirPath . $ImageFile) ;
            }
        }
    }
    //ͼƬ����
    //Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '�ټӸ�Html����ͼƬ
    $content = GetImgJsUrl($DivStr, '���ظ�') . "\n" . GetHtmlBackGroundImgList($DivStr) ;//�ټӸ�Html����ͼƬ  ��ǿ��20150126
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $ImageFile){
        if( $ImageFile <> '' ){ //�����ӵ�ַ��ǰΪHTTP:ʱ�򲻴���20150313
            $isHandle = false ;

            if( substr($ImageFile, 0 , 1) == '\\' ){
                //�ȴ���20150817
            }else if( instr($ImageFile, '.') > 0 && substr($ImageFile, 0 , 5) <> 'HTTP:' && instr($ImageFile, '{$#') == false ){
                $isHandle = true ;
            }
            if( $isHandle == true ){
                $ToImageFile = $dirPath . RemoveFileDir($ImageFile) ;//�Ƴ��ļ�·��Ŀ¼
                //html��ͼƬ·���滻
                $DivStr = Replace($DivStr, '"' . $ImageFile . '"', '"' . $ToImageFile . '"') ;
                $DivStr = Replace($DivStr, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"') ;
                $DivStr = Replace($DivStr, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"') ;
                $DivStr = Replace($DivStr, '=' . $ImageFile . '>', '"' . $ToImageFile . '"') ;
            }
        }
    }
    $handleCutDivCode = $DivStr ;
    return @$handleCutDivCode;
}

//���HTMl�ﱳ��ͼƬ 20150116  �磺 <td width="980" height="169" background="kslx3bg.jpg">
function getHtmlBackGroundImgList( $content){
    $content = GetArray($content, ' background="', '"', false, false) ;
    $content = Replace($content, '$Array$', "\n") ;
    $getHtmlBackGroundImgList = $content ;
    return @$getHtmlBackGroundImgList;
}


//������վHTML��Css����    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)  �ⲿ����
function getHandleWebHtmlLink($RootPath, $content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $CssUrl=''; $NewCssUrl=''; $CssStr ='';
    $startStr = '<link ' ;
    $CssStr = '' ;
    $endStr = '>' ;
    $ImgList = GetArray($content, $startStr, $endStr, false, false) ;
    //Call RwEnd(ImgList)
    $splStr = aspSplit($ImgList, '$Array$') ;
    foreach( $splStr as $CssUrl){
        if( $CssUrl <> '' && instr(LCase($CssUrl), 'stylesheet') > 0 ){
            //���Css��ǿ�棬����20141125
            $CssUrl = LCase(Replace(Replace(Replace($CssUrl, '"', ''), '\'', ''), '>', ' ')) . ' ' ;
            $startStr = 'href=' ; $endStr = ' ' ;
            if( instr($CssUrl, $startStr) > 0 && instr($CssUrl, $endStr) > 0 ){
                $CssUrl = StrCut($CssUrl, $startStr, $endStr, 2) ;
            }
            $NewCssUrl = HandleHttpUrl($CssUrl) ;
            if( instr($NewCssUrl, '/') > 0 ){
                $NewCssUrl = mid($NewCssUrl, strrpos($NewCssUrl, '/') + 1,-1) ;
            }
            if( LCase($NewCssUrl) <> 'common.css' && LCase($NewCssUrl) <> 'public.css' ){
                $NewCssUrl = $RootPath . $NewCssUrl ;
                $CssStr = $CssStr . '<link href="' . $NewCssUrl . '" rel="stylesheet" type="text/css" />' . "\n" ;
            }
        }
    }
    if( $CssStr <> '' ){ $CssStr = substr($CssStr, 0 , strlen($CssStr) - 2) ;}
    $getHandleWebHtmlLink = $CssStr ;
    return @$getHandleWebHtmlLink;
}


//���css���ӵ�ַ�б�(20150824)
function getCssListUrlList($content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $CssUrl=''; $CssStr=''; $urlList ='';
    $startStr = '<link ' ;
    $CssStr = '' ;
    $endStr = '>' ;
    $ImgList = GetArray($content, $startStr, $endStr, false, false) ;
    //Call RwEnd(ImgList)
    $splStr = aspSplit($ImgList, '$Array$') ;
    foreach( $splStr as $CssUrl){
        if( $CssUrl <> '' && instr(LCase($CssUrl), 'stylesheet') > 0 ){
            //���Css��ǿ�棬����20141125
            $CssUrl = LCase(Replace(Replace(Replace($CssUrl, '"', ''), '\'', ''), '>', ' ')) . ' ' ;
            $startStr = 'href=' ; $endStr = ' ' ;
            if( instr($CssUrl, $startStr) > 0 && instr($CssUrl, $endStr) > 0 ){
                $CssUrl = StrCut($CssUrl, $startStr, $endStr, 2) ;
            }
            if( instr("\n" . $urlList . "\n", "\n" . $CssUrl . "\n") == false ){
                if( $urlList <> '' ){ $urlList = $urlList . "\n" ;}
                $urlList = $urlList . $CssUrl . "\n" ;
            }
        }
    }
    $getCssListUrlList = $urlList ;
    return @$getCssListUrlList;
}

//��Css�ļ����ݲ�����(20150824) ��call rwend(handleReadCssContent("E:\E��\WEB��վ\��ǰ��վ\DataDir\VBģ��\������\Template\ģ�鹦���б�\Bվҳ�����\home\home.css","aa",true))
function handleReadCssContent($cssFilePath, $LabelName, $isHandleCss){
    $c=''; $startStr=''; $endStr ='';
    $c = getFText($cssFilePath) ;
    //��ȡCSS
    $startStr = '/*CssCodeStart*/' ;
    $endStr = '/*CssCodeEnd*/' ;
    if( instr($c, $startStr) > 0 && instr($c, $endStr) > 0 ){
        $c = StrCut($c, $startStr, $endStr, 2) ;
    }
    //����CSS
    if( $isHandleCss == true ){
        $c = cssCompression($c, 0) ;
    }
    if( $LabelName <> '' ){
        $c = '/*' . $LabelName . ' start*/' . $c . '/*' . $LabelName . ' end*/' ;
    }
    $handleReadCssContent = $c ;
    return @$handleReadCssContent;
}



//����Css��ʽ��PX��T
function handleCssPX( $nValue){
    $nValue = LCase(AspTrim($nValue)) ;
    if( substr($nValue, - 1) <> '%' && substr($nValue, - 2) <> 'px' ){
        $nValue = $nValue . 'px' ;
    }
    $handleCssPX = $nValue ;
    return @$handleCssPX;
}



//call rw(handleHtmlStyle(getftext("1.html")))
//ѹ��html���style��ʽ (20151008)
function handleHtmlStyle($content){
    $serchS=''; $replaceS=''; $nLength ='';
    $serchS = $content ;
    $nLength = instr(LCase($serchS), '</style>') + 7 ;
    $serchS = mid($serchS, 1, $nLength) ;

    $nLength = strrpos(LCase($serchS), '<style') ;
    if( $nLength > 0 ){
        $serchS = mid($serchS, $nLength,-1) ;
    }
    $replaceS = $serchS ;
    $replaceS = cssCompression($replaceS, 0) . "\n" ;//��ʽ��CSS
    $replaceS = removeBlankLines($replaceS) ;

    $content = Replace($content, $serchS, $replaceS) ;
    $handleHtmlStyle = $content ;
    return @$handleHtmlStyle;
}

?>

