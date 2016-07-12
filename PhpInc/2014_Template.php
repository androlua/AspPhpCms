<?PHP
//删除这种多余标签 <R#读出内容BlockName网站公告 start#>  <R#读出内容BlockName网站公告 end#>
//对模板处理



//读模块内容
function XY_ReadTemplateModule($action){
    $moduleId=''; $filePath=''; $c=''; $i ='';
    $sourceList ='';//源内容列表 20150109
    $replaceList ='';//替换内容列表
    $splSource=''; $splReplace=''; $sourceStr=''; $replaceStr ='';
    $filePath= RParam($action, 'File');
    $moduleId= RParam($action, 'ModuleId');
    $sourceList= RParam($action, 'SourceList');
    $replaceList= RParam($action, 'ReplaceList');
    //Call Echo(SourceList,ReplaceList)

    if( $moduleId== '' ){ $moduleId= RParam($action, 'ModuleName') ;}//用块名称
    $filePath= $filePath . '.html';
    //Call Echo("FilePath",FilePath)
    //Call Echo("ModuleId",ModuleId)
    $c= readTemplateModuleStr($filePath, '', $moduleId);
    //加替换于20160331
    if( $sourceList <> '' && $replaceList <> '' ){
        $splSource= aspSplit($sourceList, '[Array]');
        $splReplace= aspSplit($replaceList, '[Array]');
        for( $i= 0 ; $i<= UBound($splSource); $i++){
            $sourceStr= $splSource[$i];
            $replaceStr= $splReplace[$i];
            $c= Replace($c, $sourceStr, $replaceStr);
        }
    }
    $XY_ReadTemplateModule= $c;
    return @$XY_ReadTemplateModule;
}

//读模块内容
function readTemplateModuleStr($filePath, $defaultContent, $moduleId){
    $startStr=''; $endStr=''; $content ='';
    $startStr= '<!--#Module ' . $moduleId . ' start#-->';
    $endStr= '<!--#Module ' . $moduleId . ' end#-->';
    //FilePath = ReplaceGlobleLable(FilePath)                '替换全部标签        '添加于2014 12 11

    //文件不存在，则追加模板路径 20150616 给VB软件里用
    if( checkFile($filePath)== false ){
        $filePath= $GLOBALS['webTemplate'] . $filePath;
    }

    $filePath= handleRGV($filePath, '[$模块目录$]', 'Module/'); //Module

    if( $defaultContent <> '' ){
        $content= $defaultContent;
    }else if( checkFile($filePath)== true ){
        $content= getFText($filePath);
    }else{
        $content= $GLOBALS['code']; //默认用内容指定内容
    }

    if( instr($content, $startStr)==false ){
        $startStr= '<!--#Module ' . $moduleId . ' Start#-->';
    }
    if( instr($content, $endStr)==false ){
        $endStr= '<!--#Module ' . $moduleId . ' End#-->';
    }
    if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
        $readTemplateModuleStr= strCut($content, $startStr, $endStr, 2);
    }else{
        $readTemplateModuleStr= '模块[' . $moduleId . ']不存在,路径=' . $filePath;
        $GLOBALS['PHPDie']( $readTemplateModuleStr . $content);
    }
    return @$readTemplateModuleStr;
}
//找模块对应内容
function findModuleStr($content, $valueStr){
    $startStr=''; $endStr=''; $YuanStr=''; $replaceStr=''; $i=''; $Block=''; $BlockFile=''; $action ='';
    for( $i= 1 ; $i<= 9; $i++){
        $startStr= '[$读出内容 ' ; $endStr= '$]';
        if( instr($valueStr, $startStr) > 0 && instr($valueStr, $endStr) > 0 ){
            $action= strCut($valueStr, $startStr, $endStr, 2);
            $Block= RParam($action, 'Block');
            $BlockFile= RParam($action, 'File');
            if( instr(vbCrlf() . $GLOBALS['ReadBlockList'] . vbCrlf(), vbCrlf() . $Block . vbCrlf())== false ){
                $GLOBALS['ReadBlockList']= $GLOBALS['ReadBlockList'] . $Block . vbCrlf();
            }
            //块文件存在 则读出内容
            if( $BlockFile <> '' ){
                $content= getFText($BlockFile);
            }
            $YuanStr= $startStr . $action . $endStr;
            $replaceStr= '';

            $startStr= '<R#读出内容' . $Block . ' start#>' ; $endStr= '<R#读出内容' . $Block . ' end#>';
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $replaceStr= strCut($content, $startStr, $endStr, 2);
            }else{
                $startStr= '<!--#读出内容' . $Block ; $endStr= '#-->';
                if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                    $replaceStr= strCut($content, $startStr, $endStr, 2);
                }
            }
            //Call Eerr(YuanStr,ReplaceStr)
            $valueStr= Replace($valueStr, $YuanStr, $replaceStr);
            //Call Echo("ValueStr",ValueStr)
        }else{
            //没有模块要处理了 则退出
            break;
        }
    }
    $findModuleStr= $valueStr;
    return @$findModuleStr;
}

//读出Left模板样式        这里面字符 ' 来回复制会出错，所以我们用 \|*|\ 代替处理
function XY_ReadColumeSetTitle($action){
    $startStr=''; $endStr=''; $Style=''; $title=''; $valueStr=''; $MoreClass=''; $MoreUrl=''; $MoreStr=''; $aStr='';$c='';
    $action= handleInModule($action, 'start');
    $Style= RParam($action, 'style');
    $title= RParam($action, 'Title');
    //Call Echo("ContentHeight",ContentHeight)
    //ValueStr = RParam(Action,"value")
    //根据模块找内容
    $valueStr= moduleFindContent($action, 'value');
    //Call Eerr("ValueStr",ValueStr)
    $valueStr= findModuleStr($GLOBALS['code'], $valueStr); //找模块对应内容

    $MoreClass= RParam($action, 'MoreClass');
    $MoreUrl= PHPTrim(RParam($action, 'MoreUrl'));
    $MoreStr= RParam($action, 'MoreStr');
    $valueStr= handleInModule($valueStr, 'end');
    $c= readColumeSetTitle($action, $Style, $title, $valueStr);

    if( $MoreClass== '' ){ $MoreClass= 'more' ;}//More链接为空 则用默认代替
    //If MoreUrl="" Then MoreUrl="#"                    'More链接网址为空 则用默认#代替
    //More链接样式不能为空，因为没有样式它就不能让More在最近边
    if( $MoreUrl <> '' && $MoreStr <> '' ){
        //AStr = "<a href='"& MoreUrl &"' class='"& MoreClass &"'>"& MoreStr &"</a>"
        $aStr= '<a ' . AHref($MoreUrl, $title, '') . ' class=\'' . $MoreClass . '\'>' . $MoreStr . '</a>';
        $c= Replace($c, '<!--#AMore#-->', $aStr);
    }
    $XY_ReadColumeSetTitle=$c;
    return @$XY_ReadColumeSetTitle;
}

//读栏目并赋标题与内容值
function readColumeSetTitle($action, $id, $ColumeTitle, $ColumeContent){
    $TitleWidth ='';//标题宽度
    $TitleHeight ='';//标题高度
    $ContentHeight ='';//内容高度
    $ContentWidth ='';//内容宽度
    $ContentCss ='';

    $TitleWidth= RParam($action, 'TitleWidth'); //获得标题高度    待应用20150715
    $TitleHeight= RParam($action, 'TitleHeight'); //获得标题宽度
    $ContentWidth= RParam($action, 'ContentWidth'); //获得内容宽度
    $ContentHeight= RParam($action, 'ContentHeight'); //获得内容高度

    //标题宽
    $TitleWidth= aspTrim($TitleWidth);
    //自动加px单位，不加会无效果 20150115
    if( Right($TitleHeight, 1) <> '%' && Right($TitleHeight, 2) <> 'px' && $TitleHeight <> '' && $TitleHeight <> 'auto' ){
        $TitleHeight= $TitleHeight . 'px';
    }
    if( Right($TitleWidth, 1) <> '%' && Right($TitleWidth, 2) <> 'px' && $TitleWidth <> '' && $TitleWidth <> 'auto' ){
        $TitleWidth= $TitleWidth . 'px';
    }
    //内容高
    $ContentHeight= aspTrim($ContentHeight);
    //自动加px单位，不加会无效果 20150115
    if( Right($ContentHeight, 1) <> '%' && Right($ContentHeight, 2) <> 'px' && $ContentHeight <> '' && $ContentHeight <> 'auto' ){
        $ContentHeight= $ContentHeight . 'px';
    }
    //内容宽
    $ContentWidth= aspTrim($ContentWidth);
    //自动加px单位，不加会无效果 20150115
    if( Right($ContentWidth, 1) <> '%' && Right($ContentWidth, 2) <> 'px' && $ContentWidth <> '' && $ContentWidth <> 'auto' ){
        $ContentWidth= $ContentWidth . 'px';
    }

    if( $ContentHeight <> '' ){
        $ContentCss= 'height:' . $ContentHeight . ';';
    }
    if( $ContentWidth <> '' ){
        $ContentCss= $ContentCss . 'width:' . $ContentWidth . ';';
    }

    $content ='';
    $content= readColumn($id);
    //标题宽
    if( $TitleWidth <> '' ){
        $content= Replace($content, '<div class="tvalue">', '<div class="tvalue" style=\'width:' . $TitleWidth . ';\'>');
    }
    //内容高
    if( $ContentCss <> '' ){
        $content= Replace($content, '<div class="ccontent">', '<div class="ccontent" style=\'' . $ContentCss . '\'>');
    }
    //call echo(ContentWidth,ContentCss)

    $content= Replace($content, '栏目标题', $ColumeTitle);
    $content= Replace($content, '栏目内容', $ColumeContent);
    $readColumeSetTitle= $content;
    return @$readColumeSetTitle;
}

//读栏目模块
function readColumn($id){
    $templateFilePath=''; $startStr=''; $endStr=''; $s ='';
    //Call Echo("WebTemplate",WebTemplate)
    $templateFilePath= $GLOBALS['webTemplate'] . '\\Template_Left.html';
    $startStr= '/*columnlist' . $id . 'Start*/';
    $endStr= '/*columnlist' . $id . 'End*/';
    $s= readTemplateFileModular($templateFilePath, $startStr, $endStr);
    if( $s== '[$NO$]' ){
        $s= 'Left样式ID[' . $id . ']不存在';
    }
    $readColumn= $s;
    return @$readColumn;
}


//读模板素材
function readTemplateSource($id){
    $templateFilePath=''; $startStr=''; $endStr=''; $s ='';
    $templateFilePath= $GLOBALS['webTemplate'] . '\\TemplateSource.html';
    $startStr= '<!--#sourceHtml' . $id . 'Start#-->';
    $endStr= '<!--#sourceHtml' . $id . 'End#-->';
    $s= readTemplateFileModular($templateFilePath, $startStr, $endStr);
    if( $s== '[$NO$]' ){
        $s= '模板资源ID[' . $id . ']不存在';
    }
    $readTemplateSource= $s;
    return @$readTemplateSource;
}



//读模板文件中某模块
function readTemplateFileModular($templateFilePath, $startStr, $endStr){
    $content ='';
    $readTemplateFileModular= '';
    $content= getFText($templateFilePath);
    if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
        $readTemplateFileModular= strCut($content, $startStr, $endStr, 2);
    }else{
        $readTemplateFileModular= '[$NO$]';
    }
    return @$readTemplateFileModular;
}

//读文件模板素材
function readTemplateFileSource($templateFilePath, $id){
    $startStr=''; $endStr=''; $s=''; $c ='';
    $startStr= '<!--#sourceHtml' . Replace($id, '.html', '') . 'Start#-->';
    $endStr= '<!--#sourceHtml' . Replace($id, '.html', '') . 'End#-->';
    $s= readTemplateFileModular($templateFilePath, $startStr, $endStr);
    if( $s== '[$NO$]' ){
        //加一个读取本文本里配置列表(20150815)
        $c= getStrCut($GLOBALS['pubCode'], $startStr, $endStr, 2);
        if( $c <> '' ){
            $readTemplateFileSource= $c;
            //call rwend(c)
            return @$readTemplateFileSource;
        }
        $c= getftext($templateFilePath);
        //存在 <!--#TemplateSplitStart#-->  就返回当前全部内容
        if( instr($c, '<!--#DialogStart#-->') > 0 ){
            $readTemplateFileSource= $c;
            return @$readTemplateFileSource;
        }

        $s= '模板资源ID[' . $id . ']不存在,路径TemplateFilePath=' . handlePath($templateFilePath);
    }
    $readTemplateFileSource= $s;
    return @$readTemplateFileSource;
}
//读出文件展示列表资源
function readArticleListStyleSource($id){
    $filePath ='';
    $filePath= getWebImages() . '\\文章展示样式\\' . $id;
    if( checkFile($filePath)== false ){
        $filePath= $GLOBALS['webTemplate'] . '\\Resources\\' . $id;
    }
    //call echo(checkfile(filePath),filePath)
    $readArticleListStyleSource= readTemplateFileSource($filePath, $id);

    return @$readArticleListStyleSource;
}
//读出文件信息列表资源
function readArticleInfoStyleSource($id){
    $filePath ='';
    $filePath= getWebImages() . '\\文章信息展示样式\\' . $id;
    if( checkFile($filePath)== false ){
        $filePath= $GLOBALS['webTemplate'] . '\\Resources\\' . $id;
    }
    $readArticleInfoStyleSource= readTemplateFileSource($filePath, $id);
    return @$readArticleInfoStyleSource;
}


?>