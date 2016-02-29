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
//导航
//处理网站配置
function handleWebConfig(){
    $did=''; $sql ='';
    $did = IIF($GLOBALS['PubNavDid'] <> '', $GLOBALS['PubNavDid'], $GLOBALS['PubProDid']) ;
    //获得网站导航配置
    GetNavConfig($did) ;
    if( $GLOBALS['PubId'] <> '' ){
        $sql = 'Select * From [Product] Where Id=' . $GLOBALS['PubId'] ;
        $rsObj=$GLOBALS['conn']->query( $sql);
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            //获得网站导航配置
            GetNavConfig($rs['bigclassname']) ;
            $GLOBALS['MainNav'] = $rs['bigclassname'] ;//导航大类
        }

    }
}
//获得网站导航配置
function getNavConfig($did){
    $RsTempObj=$GLOBALS['conn']->query( 'Select * From [NavBigClass] Where BigClassName=\'' . $did . '\'');
    $rstemp=mysql_fetch_array($rstempObj);
    if( @mysql_num_rows($RsTempObj)!=0 ){
        $GLOBALS['MainNav'] = $GLOBALS['RsTemp']['bigclassname'] ;//导航大类
        $GLOBALS['PubNavType'] = $GLOBALS['RsTemp']['navtype'] ;//网站导航类型
        $GLOBALS['PubNavDid'] = $GLOBALS['MainNav'] ;
    }
}
//获得网站导航类型
function getNavType($did){
    $RsTempObj=$GLOBALS['conn']->query( 'Select * From [NavBigClass] Where BigClassName=\'' . $did . '\'');
    $rstemp=mysql_fetch_array($rstempObj);
    if( @mysql_num_rows($RsTempObj)!=0 ){
        $getNavType = $GLOBALS['RsTemp']['navtype'] ;//网站导航类型
    }
    return @$getNavType;
}

//VB不引用 Start
//读导航CSS内容 配置VB软件使用，在网站里无意义 20150617
function readNavCSS($id, $styleValue){
}
//VB不引用 End

//处理网站导航  当前使用版本  20141215加在线修改控制
function handleNavigation($action, $addSql){
    $i=''; $c=''; $s=''; $url=''; $fileName=''; $bigFolder=''; $did=''; $sid=''; $showDid=''; $target=''; $sql=''; $dropDownMenu=''; $focusType ='';
    $smallMenuStr=''; $j=''; $showSid ='';
    $isConcise ='';//简洁显示20150212
    $styleId=''; $styleValue ='';//样式ID与样式内容
    $cssNameAddId ='';



    $styleId = PHPTrim(RParam($action, 'styleID')) ;
    $styleValue = PHPTrim(RParam($action, 'styleValue')) ;
    if( $styleId <> '' ){
        ReadNavCSS($styleId, $styleValue) ;
    }

    //为数字类型 则自动提取样式内容  20150615
    if( checkStrIsNumberType($styleValue) ){
        $cssNameAddId = '_' . $styleValue ;//Css名称追加Id编号
    }

    //参数SQL为空则  从配置里获得
    if( $addSql == '' ){
        $addSql = RParam($action, 'AddSql') ;
    }
    //追加SQL为空 则用默认
    if( $addSql == '' ){
        $addSql = ' Where NavTop<>0 Order By Sort Asc' ;
    }


    $sql = 'Select * From [NavBigClass]' ;
    if( $GLOBALS['UserId'] <> '' ){ $sql = GetWhereAnd($sql, ' And UserId=' . $GLOBALS['UserId']) ;}//指定用户
    $sql = GetWhereAnd($sql, $addSql) ;
    if( CheckSql($sql) == false ){ eerr('Sql', $sql) ;}
    $dropDownMenu = LCase(RParam($action, 'DropDownMenu')) ;
    $focusType = LCase(RParam($action, 'FocusType')) ;
    $isConcise = LCase(RParam($action, 'isConcise')) ;
    if( $isConcise == 'true' ){
        $isConcise = false ;
    }else{
        $isConcise = true ;
    }


    $rsObj=$GLOBALS['conn']->query( $sql);
    if( $isConcise == true ){ $c = $c . CopyStr(' ', 4) . '<li class=left></li>' . "\n" ;}
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $fileName = AspTrim($rs['filename']) ;

        if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}
        $bigFolder = '/' . GetWebFolderName() . $rs['foldername'] . '/' ;
        $did = $rs['bigclassname'] ;

        $url = $rs['filename'] ;
        if( CheckMakeHtmlFile($url) == true ){
            $url = $bigFolder . $fileName ;
            $url = Replace(Replace($url, '//', '/'), '//', '/') ;
            $url = FullHttpUrl(host, $url) ;
        }
        WebDebug($url, 'act=Nav&NavDid=' . $did) ;//调试
        if( instr('|产品|新闻|下载|', '|' . $rs['navtype'] . '|') > 0 ){
            WebDebug($url, 'act=Nav&NavDid=' . $did . '&Page=1') ;//调试
        }

        $showDid = FontColorFontB($did, $rs['fontb'], $rs['fontcolor']) ;
        $target = $rs['target'] ;
        if( $GLOBALS['PubNavDid'] == $rs['bigclassname'] ){
            if( $focusType == 'a' ){
                $s = CopyStr(' ', 8) . '<li class=focus><a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a>' ;
            }else{
                $s = CopyStr(' ', 8) . '<li class=focus>' . $showDid ;
            }
        }else{
            //Call Eerr("Url",Url)
            $s = CopyStr(' ', 8) . '<li><a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a>' ;
        }
        //S = DisplayOnlineEditDialog("/admin/NavManage.Asp?act=EditNavBig&Id=" & Rs("Id") & "&n=" & GetRnd(11), S)
        $s = DisplayOnlineED2('/admin/NavManage.Asp?act=EditNavBig&Id=' . $rs['id'] . '&n=' . getRnd(11), $s, '<li') ;

        $c = $c . $s ;

        $smallMenuStr = '' ;//小类菜单内容清空
        //导航小类文本菜单
        if( $rs['navtype'] == '文本' && $dropDownMenu == 'true' ){
            $rssObj=$GLOBALS['conn']->query( 'Select * From [NavSmallClass] Where BigClassName=\'' . $rs['bigclassname'] . '\'');
            $rss=mysql_fetch_array($rssObj);
            if( @mysql_num_rows($rssObj)!=0 ){
                //C=C & vbCrlf & CopyStr(" ",8) & "<ul>"& vbCrlf & CopyStr(" ",12) & "<li>" & vbCrlf
                $c = $c . "\n" . CopyStr(' ', 8) . '<ul>' . "\n" . CopyStr(' ', 12) ;
                for( $j = 1 ; $j<= @mysql_num_rows($rssObj); $j++){
                    $fileName = AspTrim($rss['filename']) ;

                    if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}

                    $sid = $rss['smallclassname'] ;

                    $url = $rss['filename'] ;
                    if( CheckMakeHtmlFile($url) == true ){
                        $url = $bigFolder . $fileName ;
                        $url = $bigFolder . '/' . $rss['foldername'] . '/' . $fileName ;
                        $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                        WebDebug($url, 'act=Nav&NavDid=' . $did . '&NavSid=' . $sid) ;//调试
                    }

                    $showSid = FontColorFontB($sid, $rss['fontb'], $rss['fontcolor']) ;
                    $target = $rss['target'] ; $target = '_blank' ;
                    $s = '<a ' . AHref($url, $showSid, $target) . '>' . $showSid . '</a>' ;
                    //Call eerr(ShowSid,Rss("Id"))
                    $s = DisplayOnlineEditDialog('/admin/NavManage.Asp?act=EditNavSmall&Id=' . $rss['id'] . '&n=' . getRnd(11), $s) ;
                    $smallMenuStr = $smallMenuStr . CopyStr(' ', 8) . '<li>' . $s . '</li>' . "\n" ;

                }
            }
            //导航小类产品菜单
        }else if( $rs['navtype'] == '产品' && $dropDownMenu == 'true' ){
            $rssObj=$GLOBALS['conn']->query( 'Select * From [SmallClass] Where BigClassName=\'' . $rs['bigclassname'] . '\'');
            $rss=mysql_fetch_array($rssObj);
            if( @mysql_num_rows($rssObj)!=0 ){
                $c = $c . "\n" . CopyStr(' ', 8) . '<ul>' . "\n" . CopyStr(' ', 12) ;
                for( $j = 1 ; $j<= @mysql_num_rows($rssObj); $j++){
                    $fileName = AspTrim($rss['filename']) ;

                    if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}
                    $sid = $rss['smallclassname'] ;

                    $url = $rss['filename'] ;
                    if( CheckMakeHtmlFile($url) == true ){
                        $url = $bigFolder . $fileName ;
                        $url = $bigFolder . '/' . $rss['foldername'] . '/' . $fileName ;
                        $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                        WebDebug($url, 'act=CreateClass&ProDid=' . $did . '&ProSid=' . $sid . '&Page=1') ;//调试
                    }
                    //Call eerr(ShowSid,Rss("Id"))
                    $showSid = FontColorFontB($sid, $rss['fontb'], $rss['fontcolor']) ;
                    $target = $rss['target'] ; $target = '_blank' ;
                    $s = '<a ' . AHref($url, $showSid, $target) . '>' . $showSid . '</a>' ;
                    $s = DisplayOnlineEditDialog('/admin/ProductClassManage.Asp?act=ShowEditSmallClass&Id=' . $rss['id'] . '&n=' . getRnd(11), $s) ;
                    $smallMenuStr = rtrimVBcrlf($smallMenuStr) . "\n" . CopyStr(' ', 12) . '<li>' . $s . '</li>' . "\n" ;
                }
            }
        }
        if( $smallMenuStr <> '' ){ $c = $c . $smallMenuStr . '</ul>' . "\n" ;}


        $c = $c . CopyStr(' ', 8) . '</li>' . "\n" ;

        if( $isConcise == true ){ $c = $c . CopyStr(' ', 8) . '<li class=line></li>' . "\n" ;}
    }
    if( $isConcise == true ){ $c = $c . CopyStr(' ', 8) . '<li class=right></li>' . "\n" ;}

    if( $styleId <> '' ){
        $c = '<ul class=\'nav' . $styleId . $cssNameAddId . '\'>' . "\n" . $c . "\n" . '</ul>' . "\n" ;
    }

    $handleNavigation = $c ;
    return @$handleNavigation;
}
//Div版网站导航
function divTopNavigation($NavDid, $addSql){
    $i=''; $c=''; $s=''; $url=''; $fileName=''; $bigFolder=''; $did=''; $showDid=''; $target=''; $sql ='';
    $sql = 'Select * From [NavBigClass]' ;
    if( $GLOBALS['UserId'] <> '' ){ $sql = GetWhereAnd($sql, ' And UserId=' . $GLOBALS['UserId']) ;}//指定用户
    $sql = GetWhereAnd($sql, $addSql) ;
    if( CheckSql($sql) == false ){ eerr('Sql', $sql) ;}
    $rsObj=$GLOBALS['conn']->query( $sql);
    $c = $c . '<li class=left></li>' . "\n" ;
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $fileName = $rs['filename'] ;
        if( $fileName <> '' && substr($fileName, - 1) <> '/' ){ $fileName = $fileName . '.html' ;}
        $bigFolder = '/' . GetWebFolderName() . $rs['foldername'] . '/' ;
        $did = $rs['bigclassname'] ;

        $url = $rs['filename'] ;
        if( CheckRemoteUrl($url) == false ){
            $url = $bigFolder . $fileName ;
            $url = Replace(Replace($url, '//', '/'), '//', '/') ;
            $url = FullHttpUrl(host, $url) ;
            WebDebug($url, 'act=Nav&NavDid=' . $did) ;//调试
        }

        $showDid = FontColorFontB($did, $rs['fontb'], $rs['fontcolor']) ;
        $target = $rs['target'] ;
        if( $NavDid == $rs['bigclassname'] ){
            $c = $c . '<li class=focus>' . $showDid . '</li>' . "\n" ;
        }else{
            $c = $c . '<li><a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a></li>' . "\n" ;
        }
        $c = $c . '<li class=line></li>' . "\n" ;
    }
    $c = $c . '<li class=right></li>' . "\n" ;
    $divTopNavigation = $c ;
    return @$divTopNavigation;
}
//网站底部导航            '暂时无用
function webFootNavigation($addSql){
    $i=''; $c=''; $url=''; $fileName=''; $bigFolder=''; $did=''; $showDid=''; $target=''; $sql ='';
    $sql = 'Select * From [NavBigClass] ' ;
    if( $GLOBALS['UserId'] <> '' ){ $sql = GetWhereAnd($sql, ' And UserId=' . $GLOBALS['UserId']) ;}//指定用户
    $sql = GetWhereAnd($sql, $addSql) ;
    $rsObj=$GLOBALS['conn']->query( $sql);
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $fileName = $rs['filename'] ;
        if( $fileName <> '' && substr($fileName, - 1) <> '/' ){ $fileName = $fileName . '.html' ;}

        $bigFolder = '/' . $rs['foldername'] . '/' ;
        $showDid = FontColorFontB($did, $rs['fontb'], $rs['fontcolor']) ;
        $target = $rs['target'] ;
        $did = $rs['bigclassname'] ;

        $url = $rs['filename'] ;
        if( CheckRemoteUrl($url) == false ){
            $url = $bigFolder . $fileName ;
            $url = Replace(Replace($url, '//', '/'), '//', '/') ;
            WebDebug($url, 'act=Nav&NavDid=' . $did) ;//调试
        }

        $c = $c . '<a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a>' ;
        if( $i <> @mysql_num_rows($rsObj) ){ $c = $c . ' &nbsp;| &nbsp; ' ;}
    }
    $webFootNavigation = $c ;
    return @$webFootNavigation;
}
//======================== 辅助区 ==========================
//获得导航类型对应的导航名称  旧
function getNavTypeInName($NavType){
    if( LCase($NavType) == 'home' ){ $NavType = '首页' ;}//追加于20150310
    $getNavTypeInName = GetNavParam('NavBigClass', 'BigClassName', 'Where NavType=\'' . $NavType . '\'') ;
    return @$getNavTypeInName;
}
//获得导航参数
function getNavParam( $TableName, $FieldName, $addSql){
    $sql=''; $fileName=''; $url=''; $bigFolder ='';
    $sql = 'Select * From [' . $TableName . '] ' . $addSql ;
    $TempRsObj=$GLOBALS['conn']->query( $sql);
    $temprs=mysql_fetch_array($temprsObj);
    if( @mysql_num_rows($TempRsObj)!=0 ){
        //根据名称获得网址
        if( $FieldName == '[url]' ){
            $fileName = $TempRs['filename'] ;
            if( $fileName <> '' && substr($fileName, - 1) <> '/' ){ $fileName = $fileName . '.html' ;}
            $bigFolder = '/' . GetWebFolderName() . $TempRs['foldername'] . '/' ;

            $url = $TempRs['filename'] ;
            if( CheckRemoteUrl($url) == false ){
                $url = $bigFolder . $fileName ;
                $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                $url = FullHttpUrl(host, $url) ;
                WebDebug($url, 'act=Nav&NavDid=' . $rs['bigclassname']) ;//调试         Did被改了20150617
            }

            $getNavParam = $url ;
        }else if( $FieldName <> '' ){
            $getNavParam = $TempRs[$FieldName] ;
        }
    }
    return @$getNavParam;
}





//显示导航列表 201507 10 (简单版)  待完善
function XY_CustomNavList($action){
    $did=''; $sid=''; $tid=''; $title=''; $topNumb=''; $cutStrNumb=''; $addSql ='';
    HandleFunParameter($action, $did, $sid, $tid, $title, $topNumb, $cutStrNumb, $addSql) ;//获得这么函数参数
    XY_AutoAddHandle($action) ;//处理添加信息处理
    $defaultContent=''; $i=''; $j=''; $s=''; $c=''; $startStr=''; $endStr=''; $url=''; $aUrl=''; $aStr=''; $aImg=''; $showTitle=''; $dateTime=''; $imgFile=''; $defaultImage=''; $rndShow=''; $idList=''; $sql ='';
    $DescriptionLabel ='';//标签
    $WebDescription ='';//网站描述
    $Price ='';//价格
    $content ='';//内容
    $noFollow ='';//不追踪 20141222
    $defaultContent = GetDefaultValue($action) ;//获得默认内容
    $AutoAddDid=''; $AutoAddSid=''; $AutoAddTid=''; $AutoAdd ='';
    $ArticleDescription ='';//文章描述(简要简介)
    $modI ='';//余循环20150112
    $HtmlCode ='';//HTML代码
    $splStr=''; $splxx ='';
    $bigFolder=''; $fileName ='';

    $noFollow = AspTrim(LCase(RParam($action, 'noFollow'))) ;//不追踪
    $sql = 'Select * From [NavBigClass] Where NavTop<>0 Order By Sort Asc' ;
    //Call Eerr("Sql=",Sql)
    $rsObj=$GLOBALS['conn']->query( $sql);
    //Call eerr("Sql【"& Rs.RecordCount &"】", Sql)
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)==0 ){ break; }
        if( $rs['bigclassname'] == $GLOBALS['PubNavDid'] ){
            $startStr = '[list-focus]' ; $endStr = '[/list-focus]' ;
        }else{
            $startStr = '[list-' . $i . ']' ; $endStr = '[/list-' . $i . ']' ;
        }
        //例[list-mod2]  [/list-mod2]    20150112
        for( $modI = 6 ; $modI>= 2 ; $modI--){
            if( instr($defaultContent, $startStr) == false && $i % $modI == 0 ){
                $startStr = '[list-mod' . $modI . ']' ; $endStr = '[/list-mod' . $modI . ']' ;
                if( instr($defaultContent, $startStr) > 0 ){
                    //Call Echo("ModI=" & ModI & ",I=" & I,StartStr)
                    break;
                }
            }
        }

        //没有则用默认
        if( instr($defaultContent, $startStr) == false ){
            $startStr = '[list]' ; $endStr = '[/list]' ;
        }



        if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
            $s = StrCut($defaultContent, $startStr, $endStr, 2) ;


            $fileName = AspTrim($rs['filename']) ;

            if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}
            $bigFolder = '/' . GetWebFolderName() . $rs['foldername'] . '/' ;
            $did = $rs['bigclassname'] ;

            $url = $rs['filename'] ;
            if( CheckMakeHtmlFile($url) == true ){
                $url = $bigFolder . $fileName ;
                $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                $url = FullHttpUrl(host, $url) ;
            }
            //20151013改进
            if( $rs['customaurl'] <> '' ){
                $url = $rs['customaurl'] ;
            }else{
                WebDebug($url, 'act=Nav&NavDid=' . $did) ;//调试
            }

            if( instr('|产品|新闻|下载|', '|' . $rs['navtype'] . '|') > 0 ){
                WebDebug($url, 'act=Nav&NavDid=' . $did . '&Page=1') ;//调试
            }

            $aUrl = AHref($url, $rs['bigclassname'], $rs['target']) ;

            $aStr = '<a ' . AHref($url, $rs['bigclassname'], $rs['target']) . SetHtmlParam($action, 'aclass') . IIF($noFollow == 'true', ' rel=\'nofollow\'', '') . '>' . $showTitle . '</a>' . "\n" ;


            $WebDescription = $rs['webdescription'] ;

            $showTitle = CutStr($rs['bigclassname'], $cutStrNumb, '... ') ;
            $showTitle = FontColorFontB($showTitle, $rs['fontb'], $rs['fontcolor']) ;



            for( $j = 1 ; $j<= 3; $j++){
                $s = ReplaceValueParam($s, 'ni', $i) ;//不对为i，因为i会与imgurl冲突 [$i$]
                $s = ReplaceValueParam($s, '编号-1', $i - 1) ;//不对为i，因为i会与imgurl冲突 [$i$]
                $s = ReplaceValueParam($s, '编号', $i) ;//不对为i，因为i会与imgurl冲突 [$i$]

                //S = ReplaceValueParam(S,"编号-1%2",Fix(I/2)-1)                    '不对为i，因为i会与imgurl冲突 [$i$]




                $s = ReplaceValueParam($s, 'bigclassname', $rs['bigclassname']) ;
                $s = ReplaceValueParam($s, 'title', $rs['bigclassname']) ;
                $s = ReplaceValueParam($s, 'showtitle', $showTitle) ;
                $s = ReplaceValueParam($s, 'url', $url) ;
                $s = ReplaceValueParam($s, 'aurl', $aUrl) ;
                $s = ReplaceValueParam($s, 'astr', $aStr) ;
            }

            $url = '/admin/Product.Asp?act=ShowEditProduct&Id=' . $rs['id'] . '&n=' . getRnd(11) ;
            //S = DisplayOnlineEditDialog(Url, S)

            $s = DisplayOnlineEditDialog('/admin/NavManage.Asp?act=EditNavBig&Id=' . $rs['id'] . '&n=' . getRnd(11), $s) ;


            //开始位置加Dialog内容
            $startStr = '[list-' . $i . ' startdialog]' ; $endStr = '[/list-' . $i . ' startdialog]' ;
            if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
                $s = StrCut($defaultContent, $startStr, $endStr, 2) . $s ;
            }
            //结束位置加Dialog内容
            $startStr = '[list-' . $i . ' enddialog]' ; $endStr = '[/list-' . $i . ' enddialog]' ;
            if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
                $s = $s . StrCut($defaultContent, $startStr, $endStr, 2) ;
            }
            $c = $c . $s ;
        }
    }

    //开始内容加Dialog内容
    $startStr = '[dialog start]' ; $endStr = '[/dialog start]' ;
    if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
        $c = StrCut($defaultContent, $startStr, $endStr, 2) . $c ;
    }
    //结束内容加Dialog内容
    $startStr = '[dialog end]' ; $endStr = '[/dialog end]' ;
    if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
        $c = $c . StrCut($defaultContent, $startStr, $endStr, 2) ;
    }
    $XY_CustomNavList = $c ;
    return @$XY_CustomNavList;
}

?>