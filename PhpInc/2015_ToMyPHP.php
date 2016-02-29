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
//与php通用   我的后台

//加载文件
function XY_Include($action){
    $templateFilePath=''; $Block=''; $startStr=''; $endStr=''; $content ='';
    $templateFilePath = LCase(RParam($action, 'File')) ;
    $Block = LCase(RParam($action, 'Block')) ;

    $findstr=''; $replaceStr ='';//查找字符，替换字符
    $findstr = RParam($action, 'findstr') ;
    $replaceStr = RParam($action, 'replacestr') ;

    $templateFilePath = HandleFileUrl($templateFilePath) ;//处理文件路径
    if( checkFile($templateFilePath) == false ){
        $templateFilePath = $GLOBALS['webTemplate'] . $templateFilePath ;
    }
    $content = GetFText($templateFilePath) ;
    if( $Block <> '' ){
        $startStr = '<!--#' . $Block . ' start#-->' ;
        $endStr = '<!--#' . $Block . ' end#-->' ;
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $content = StrCut($content, $startStr, $endStr, 2) ;
        }
    }
    //替换读出来的内容
    if( $findstr <> '' ){
        $content = Replace($content, $findstr, $replaceStr) ;
    }

    $XY_Include = $content ;
    return @$XY_Include;
}

//显示栏目列表
function XY_AP_ColumnList($action){
    $sql ='';
    $sql = RParam($action, 'sql') ;
    if( $sql == '' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where flags like\'%top%\' order by sortRank asc' ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_AP_ColumnList = XY_AP_GeneralList($action, 'WebColumn', $sql) ;
    return @$XY_AP_ColumnList;
}

//显示文章列表
function XY_AP_ArticleList($action){
    $sql=''; $addSql=''; $columnName=''; $columnId=''; $topNumb=''; $idRand=''; $splStr=''; $s=''; $columnIdList ='';

    //action = Replace(action, "[$detailTitle$]", glb_detailTitle)               '处理当前标题
    $action = replaceGlobleVariable($action) ;//处理下替换标签

    //call echo(glb_detailTitle,action)
    $sql = RParam($action, 'sql') ;
    $topNumb = RParam($action, 'topNumb') ;
    if( $sql == '' ){
        if( $topNumb <> '' ){
            $topNumb = ' top ' . $topNumb . ' ' ;
        }
        $sql = 'Select ' . $topNumb . '* From ' . $GLOBALS['db_PREFIX'] . 'ArticleDetail' ;
    }
    //id随机
    $idRand = LCase(RParam($action, 'rand')) ;
    if( $idRand == 'true' || $idRand == '1' ){
        $sql = $sql . ' where id in(' . getRandArticleId('', $topNumb) . ')' ;
    }

    //栏目名称 对栏目数组处理如 模板分享下载[Array]CSS3[Array]HTML5
    $s = RParam($action, 'columnName') ;
    if( $s <> '' ){
        $splStr = aspSplit($s, '[Array]') ;
        foreach( $splStr as $columnName){
            $columnId = getColumnId($columnName) ;
            if( $columnId <> '' ){
                if( $columnIdList <> '' ){
                    $columnIdList = $columnIdList . ',' ;
                }
                $columnIdList = $columnIdList . $columnId ;
            }
        }
    }
    if( $columnIdList <> '' ){
        $sql = getWhereAnd($sql, 'where parentId in(' . $columnIdList . ')') ;
    }
    //追加sql
    $addSql = RParam($action, 'addSql') ;
    if( $addSql <> '' ){
        $sql = getWhereAnd($sql, $addSql) ;
    }
    $sql = replaceGlobleVariable($sql) ;
    //call echo(RParam(action, "columnName") ,sql)
    $XY_AP_ArticleList = XY_AP_GeneralList($action, 'ArticleDetail', $sql) ;
    return @$XY_AP_ArticleList;
}
//显示评论列表
function XY_AP_CommentList($action){
    $sql=''; $itemID ='';
    $sql = RParam($action, 'sql') ;
    $itemID = RParam($action, 'itemID') ;
    $itemID = replaceGlobleVariable($itemID) ;
    //call eerr("itemID",itemID)

    if( $sql == '' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'TableComment where itemID=' . $itemID . ' and through=1 order by adddatetime asc' ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_AP_CommentList = XY_AP_GeneralList($action, 'TableComment', $sql) ;
    return @$XY_AP_CommentList;
}
//显示搜索统计
function XY_AP_SearchStatList($action){
    $sql=''; $addSql=''; $topNumb ='';

    $topNumb = RParam($action, 'topNumb') ;
    if( $sql == '' ){
        if( $topNumb <> '' ){
            $topNumb = ' top ' . $topNumb . ' ' ;
        }
        $sql = 'Select ' . $topNumb . '* From ' . $GLOBALS['db_PREFIX'] . 'SearchStat' ;
    }
    //追加sql
    $addSql = RParam($action, 'addSql') ;
    if( $addSql <> '' ){
        $sql = getWhereAnd($sql, $addSql) ;
    }
    $sql = replaceGlobleVariable($sql) ;
    //call eerr("sql",sql)
    $XY_AP_SearchStatList = XY_AP_GeneralList($action, 'SearchStat', $sql) ;
    return @$XY_AP_SearchStatList;
}

//通用信息列表
function XY_AP_GeneralList($action, $tableName, $sql){
    $title=''; $topNumb=''; $addSql=''; $isB=''; $abcolor ='';
    $columnName=''; $columnEnName=''; $simpleIntroduction=''; $bodyContent=''; $showTitle ='';
    $bannerImage=''; $smallImage=''; $bigImage=''; $id ='';
    $defaultStr=''; $i=''; $j=''; $s=''; $c=''; $startStr=''; $endStr=''; $url ='';
    $noFollow ='';//不追踪 20141222
    $defaultStr = GetDefaultValue($action) ;//获得默认内容
    $modI ='';//余循环20150112
    $noFollow = AspTrim(LCase(RParam($action, 'noFollow'))) ;//不追踪
    $lableTitle ='';//标题标题
    $target ='';//a链接打开目标方式
    $adddatetime ='';//添加时间
    $isFocus ='';
    $fieldNameList ='';//字段列表
    $splFieldName=''; $fieldName=''; $replaceStr=''; $k ='';

    $fieldNameList = getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段列表') ;
    $splFieldName = aspSplit($fieldNameList, ',') ;

    //call echo("sql",sql)
    $rsObj=$GLOBALS['conn']->query( $sql);
    //加强处理
    $topNumb = RParam($action, 'topNumb') ;
    if( $topNumb == '' ){
        $topNumb = @mysql_num_rows($rsObj) ;
    }else{
        $topNumb = intval($topNumb) ;
    }
    if( $topNumb > @mysql_num_rows($rsObj) ){
        $topNumb = @mysql_num_rows($rsObj) ;
    }
    for( $i = 1 ; $i<= $topNumb; $i++){
    $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)==0 ){ break; }
        $isFocus = false ;//交点为假

        $id = $rs['id'] ;
        //【导航】
        if( $tableName == 'WebColumn' ){
            if( $GLOBALS['isMakeHtml'] == true ){
                $url = getRsUrl($rs['filename'], $rs['customaurl'], '/nav' . $rs['id']) ;
            }else{
                $url = handleWebUrl('?act=nav&columnName=' . $rs['columnname']) ;//会追加gl等参数
                if( $rs['customaurl'] <> '' ){
                    $url = $rs['customaurl'] ;
                }
            }
            //全局栏目名称为空则为自动定位首页 追加(20160128)
            if( $GLOBALS['glb_columnName'] == '' && $rs['columntype'] == '首页' ){
                $GLOBALS['glb_columnName'] = $rs['columnname'] ;
            }
            if( $rs['columnname'] == $GLOBALS['glb_columnName'] ){
                $isFocus = true ;
            }


            //【文章】
        }else if( $tableName == 'ArticleDetail' ){
            if( $GLOBALS['isMakeHtml'] == true ){
                $url = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
            }else{
                $url = handleWebUrl('?act=detail&id=' . $rs['id']) ;//会追加gl等参数
                if( $rs['customaurl'] <> '' ){
                    $url = $rs['customaurl'] ;
                }
            }
            //A链接添加颜色
            $abcolor = '' ;
            if( $rs['titlecolor'] <> '' ){
                $abcolor = 'color:' . $rs['titlecolor'] . ';' ;
            }
            if( instr($rs['flags'], '|b|') > 0 ){
                $abcolor = $abcolor . 'font-weight:bold;' ;
            }
            if( $abcolor <> '' ){
                $abcolor = ' style="' . $abcolor . '"' ;
            }
        }else if( $tableName == 'TableComment' ){
            //call eerr("defaultStr",defaultStr)

        }

        //网址判断
        if( $isFocus == true ){
            $startStr = '[list-focus]' ; $endStr = '[/list-focus]' ;
        }else{
            $startStr = '[list-' . $i . ']' ; $endStr = '[/list-' . $i . ']' ;
        }

        //在最后时排序当前交点20160202
        if( $i == $topNumb && $isFocus == false ){
            $startStr = '[list-end]' ; $endStr = '[/list-end]' ;
        }

        //例[list-mod2]  [/list-mod2]    20150112
        for( $modI = 6 ; $modI>= 2 ; $modI--){
            if( instr($defaultStr, $startStr) == false && $i % $modI == 0 ){
                $startStr = '[list-mod' . $modI . ']' ; $endStr = '[/list-mod' . $modI . ']' ;
                if( instr($defaultStr, $startStr) > 0 ){
                    break;
                }
            }
        }

        //没有则用默认
        if( instr($defaultStr, $startStr) == false ){
            $startStr = '[list]' ; $endStr = '[/list]' ;
        }



        if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
            $s = StrCut($defaultStr, $startStr, $endStr, 2) ;
            for( $j = 1 ; $j<= 3; $j++){
                $s = handleReplaceValueParam($s, 'ni', $i) ;//不对为i，因为i会与imgurl冲突 [$i$]
                $s = handleReplaceValueParam($s, '编号-1', $i - 1) ;//不对为i，因为i会与imgurl冲突 [$i$]
                $s = handleReplaceValueParam($s, '编号', $i) ;//不对为i，因为i会与imgurl冲突 [$i$]
                $s = Replace($s, '[$id$]', $rs['id']) ;
                $s = Replace($s, '[$url$]', $url) ;

                for( $k = 0 ; $k<= UBound($splFieldName); $k++){
                    if( $splFieldName[$k] <> '' ){
                        $fieldName = $splFieldName[$k] ;
                        $replaceStr = $rs[$fieldName] . '' ;

                        $s = replaceValueParam($s, $fieldName, $replaceStr) ;
                    }
                }
                $s = replaceValueParam($s, 'abcolor', $abcolor) ;
            }


            //开始位置加Dialog内容
            $startStr = '[list-' . $i . ' startdialog]' ; $endStr = '[/list-' . $i . ' startdialog]' ;
            if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
                $s = StrCut($defaultStr, $startStr, $endStr, 2) . $s ;
            }
            //结束位置加Dialog内容
            $startStr = '[list-' . $i . ' enddialog]' ; $endStr = '[/list-' . $i . ' enddialog]' ;
            if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
                $s = $s . StrCut($defaultStr, $startStr, $endStr, 2) ;
            }

            //加控制
            //【导航】
            if( $tableName == 'WebColumn' ){
                $url = WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
                //【文章】
            }else if( $tableName == 'ArticleDetail' ){
                $url = WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
            }
            $s = HandleDisplayOnlineEditDialog($url, $s, '', 'div|li|span') ;
            $c = $c . $s ;
        }
    }

    //开始内容加Dialog内容
    $startStr = '[dialog start]' ; $endStr = '[/dialog start]' ;
    if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
        $c = StrCut($defaultStr, $startStr, $endStr, 2) . $c ;
    }
    //结束内容加Dialog内容
    $startStr = '[dialog end]' ; $endStr = '[/dialog end]' ;
    if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
        $c = $c . StrCut($defaultStr, $startStr, $endStr, 2) ;
    }
    $XY_AP_GeneralList = $c ;
    return @$XY_AP_GeneralList;
}

//处理获得表内容
function XY_handleGetTableBody($action, $tableName, $fieldParamName, $defaultFileName, $adminUrl){
    $url=''; $content=''; $id=''; $sql=''; $addSql=''; $fieldName=''; $fieldParamValue ='';
    $fieldName = RParam($action, 'fieldname') ;//字段名称
    if( $fieldName == '' ){
        $fieldName = $defaultFileName ;
    }
    $fieldParamValue = RParam($action, $fieldParamName) ;//截取字段内容
    $id = handleNumber(RParam($action, 'id')) ;//获得ID
    $addSql = ' where ' . $fieldParamName . '=\'' . $fieldParamValue . '\'' ;
    if( $id <> '' ){
        $addSql = ' where id=' . $id ;
    }

    $content = GetDefaultValue($action) ;//获得默认内容
    $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . $addSql ;
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        //自动添加 20160113
        if( RParam($action, 'autoadd') == 'true' ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . $tableName . ' (' . $fieldParamName . ',' . $fieldName . ') values(\'' . $fieldParamValue . '\',\'' . ADSql($content) . '\')') ;
        }
    }else{
        $id = $rs['id'] ;
        $content = $rs[$fieldName] ;
    }
    if( $id == '' ){
        $id = XY_AP_GetFieldValue('', $sql, 'id') ;
    }
    $url = $adminUrl . '&id=' . $id . '&n=' . getRnd(11) ;
    if( @$_REQUEST['gl'] == 'edit' ){
        $content = '<span>' . $content . '</span>' ;
    }

    //call echo(sql,url)
    $content = HandleDisplayOnlineEditDialog($url, $content, '', 'span') ;
    $XY_handleGetTableBody = $content ;

    return @$XY_handleGetTableBody;
}
//获得单页内容
function XY_AP_GetOnePageBody($action){
    $adminUrl ='';
    $adminUrl = WEB_ADMINURL . '?act=addEditHandle&actionType=OnePage&lableTitle=单页管理&nPageSize=10&page=&switchId=2' ;
    $XY_AP_GetOnePageBody = XY_handleGetTableBody($action, 'onepage', 'title', 'bodycontent', $adminUrl) ;
    return @$XY_AP_GetOnePageBody;
}
//获得导航内容
function XY_AP_GetColumnBody($action){
    $adminUrl ='';
    $adminUrl = WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&switchId=2' ;
    $XY_AP_GetColumnBody = XY_handleGetTableBody($action, 'webcolumn', 'columnname', 'bodycontent', $adminUrl) ;
    return @$XY_AP_GetColumnBody;
}
//显示文章内容
function XY_AP_GetArticleBody($action){
    $adminUrl ='';
    $adminUrl = WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&switchId=2' ;
    $XY_AP_GetArticleBody = XY_handleGetTableBody($action, 'articledetail', 'title', 'bodycontent', $adminUrl) ;
    return @$XY_AP_GetArticleBody;
}

//获得栏目URL
function XY_GetColumnUrl($action){
    $columnName=''; $url ='';
    $columnName = RParam($action, 'columnName') ;
    $url = getColumnUrl($columnName, 'name') ;
    if( @$_REQUEST['gl'] <> '' ){
        $url = $url . '&gl=' . @$_REQUEST['gl'] ;
    }
    $XY_GetColumnUrl = $url ;

    return @$XY_GetColumnUrl;
}
//获得文章URL
function XY_GetArticleUrl($action){
    $title=''; $url ='';
    $title = RParam($action, 'title') ;
    $url = getArticleUrl($title) ;
    if( @$_REQUEST['gl'] <> '' ){
        $url = $url . '&gl=' . @$_REQUEST['gl'] ;
    }
    $XY_GetArticleUrl = $url ;
    return @$XY_GetArticleUrl;
}
//获得单页URL
function XY_GetOnePageUrl($action){
    $title=''; $url ='';
    $title = RParam($action, 'title') ;
    $url = getOnePageUrl($title) ;
    if( @$_REQUEST['gl'] <> '' ){
        $url = $url . '&gl=' . @$_REQUEST['gl'] ;
    }
    $XY_GetOnePageUrl = $url ;
    return @$XY_GetOnePageUrl;
}

//获得单个字段内容
function XY_AP_GetFieldValue($action, $sql, $fieldName){
    $title=''; $content ='';
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $content = $rs[$fieldName] ;
    }
    $XY_AP_GetFieldValue = $content ;
    return @$XY_AP_GetFieldValue;
}

//Js版网站统计
function XY_JsWebStat($action){
    $s=''; $fileName ='';
    $fileName = AspTrim(RParam($action, 'fileName')) ;
    if( $fileName == '' ){
        $fileName = '[$WEB_VIEWURL$]?dataact=WebStat' ;
    }
    $fileName = Replace($fileName, '/', '\\/') ;
    $s = '<script>document.writeln("<script src=\\\'' . $fileName . '&GoToUrl="' ;
    $s = $s . '+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)' ;
    $s = $s . '+"&co="+escape(document.cookie)' ;//收集cookie 不需要则屏蔽掉
    $s = $s . '+" \\\'><\\/script>");</script>' ;
    $XY_JsWebStat = $s ;
    return @$XY_JsWebStat;
}


//普通链接A
function XY_HrefA($action){
    $content=''; $Href=''; $c=''; $AContent=''; $AType=''; $url=''; $title ='';
    $action = HandleInModule($action, 'start') ;
    $content = RParam($action, 'Content') ;
    $AType = RParam($action, 'Type') ;
    if( $AType == '收藏' ){
        //第一种方法
        //Url = "window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"
        $url = 'shoucang(document.title,window.location)' ;
        $c = '<a href=\'javascript:;\' onClick="' . $url . '" ' . SetHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>' ;
    }else if( $AType == '设为首页' ){
        //第一种方法
        //Url = "var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"
        $url = 'SetHome(this,window.location)' ;
        $c = '<a href=\'javascript:;\' onClick="' . $url . '"' . SetHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>' ;
    }else{
        $content = RParam($action, 'Title') ;
    }

    $content = HandleInModule($content, 'end') ;
    if( $c == '' ){ $c = '<a' . SetHtmlParam($action, 'href|target|title|alt|id|class|rel|style') . '>' . $content . '</a>' ;}

    $XY_HrefA = $c ;
    return @$XY_HrefA;
}


//布局20151231
function XY_Layout($action){
    $layoutName=''; $s=''; $c ='';
    $layoutName = RParam($action, 'layoutname') ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'weblayout where layoutname=\'' . $layoutName . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $XY_Layout = $rs['bodycontent'] ;
    }
    //rs.open"select * from webmodule where moduletype='"& layoutname &"'",conn,1,1
    //while not rs.eof
    //c=c & rs("bodycontent")
    //rs.movenext:wend:rs.close
    //XY_Layout=c
    return @$XY_Layout;
}
//模块20151231
function XY_Module($action){
    $moduleName=''; $s=''; $c ='';
    $moduleName = RParam($action, 'modulename') ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webmodule where modulename=\'' . $moduleName . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $XY_Module = $rs['bodycontent'] ;
    }
    return @$XY_Module;
}
//显示包裹块20160127
function XY_DisplayWrap( $action){
    $content ='';
    $content = GetDefaultValue($action) ;
    $XY_DisplayWrap = $content ;
    return @$XY_DisplayWrap;
}
//读模块内容
function XY_ReadTemplateModule($action){
    $ModuleId=''; $filePath ='';
    $SourceList ='';//源内容列表 20150109
    $ReplaceList ='';//替换内容列表
    $SplSource=''; $SplReplace=''; $i=''; $SourceStr=''; $replaceStr ='';
    //Call die(Action)

    $filePath = RParam($action, 'File') ;
    $ModuleId = RParam($action, 'ModuleId') ;
    $SourceList = RParam($action, 'SourceList') ;
    $ReplaceList = RParam($action, 'ReplaceList') ;
    //Call Echo(SourceList,ReplaceList)

    if( $ModuleId == '' ){ $ModuleId = RParam($action, 'ModuleName') ;}//用块名称
    $filePath = $filePath . '.html' ;
    //Call Echo("FilePath",FilePath)
    //Call Echo("ModuleId",ModuleId)
    $XY_ReadTemplateModule = ReadTemplateModuleStr($filePath, '', $ModuleId) ;
    return @$XY_ReadTemplateModule;
}



//嵌套标题 测试
function XY_getLableValue($action){
    $title=''; $content=''; $c ='';
    //call echo("Action",Action)
    $title = RParam($action, 'title') ;
    $content = RParam($action, 'content') ;
    $c = $c . 'title=' . GetContentRunStr($title) . '<hr>' ;
    $c = $c . 'content=' . GetContentRunStr($content) . '<hr>' ;
    $XY_getLableValue = $c ;
    ASPEcho('title', $title) ;
    $XY_getLableValue = '【title=】【' . $title . '】' ;
    return @$XY_getLableValue;
}
?>