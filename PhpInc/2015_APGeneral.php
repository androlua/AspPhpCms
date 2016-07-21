<?PHP
//ASP和PHP通用函数


//文章相关标签 组  待改进
function aritcleRelatedTags($relatedTags){
    $c=''; $splStr=''; $s=''; $url ='';
    $splStr= aspSplit($relatedTags, ',');
    foreach( $splStr as $key=>$s){
        if( $s <> '' ){
            if( $c <> '' ){
                $c= $c . ',';
            }
            $url= getColumnUrl($s, 'name');
            $c= $c . '<a href="' . $url . '" rel="category tag" class="ablue">' . $s . '</a>' . vbCrlf();
        }
    }

    $c= '<footer class="articlefooter">' . vbCrlf() . '标签： ' . $c . '</footer>' . vbCrlf();
    $aritcleRelatedTags= $c;
    return @$aritcleRelatedTags;
}


//获得随机文章id列表
function getRandArticleId($addSql, $topNumb){
    $splStr=''; $s=''; $c=''; $nIndex ='';
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail ' . $addSql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        if( $c <> '' ){ $c= $c . ',' ;}
        $c= $c . $rs['id'];
    }
    $getRandArticleId= randomShow($c, ',', 4);
    $splStr= aspSplit($c, ',') ; $c= '' ; $nIndex= 0;
    foreach( $splStr as $key=>$s){
        if( $c <> '' ){ $c= $c . ',' ;}
        $c= $c . $s;
        $nIndex= $nIndex + 1;
        if( $nIndex >= $topNumb ){ break; }
    }
    $getRandArticleId= $c;
    return @$getRandArticleId;
}
//获得网站栏目排序SQL
function getWebColumnSortSql($id){
    $sql='';
    $tempRs2Obj=$GLOBALS['conn']->query('select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $id);
    if( @mysql_num_rows($tempRs2Obj)!=0 ){
        $tempRs2=mysql_fetch_array($tempRs2Obj);

        $sql=$tempRs2['sortsql'];
    }
    $getWebColumnSortSql=$sql;
    return @$getWebColumnSortSql;
}

//上一篇文章 这里面的sortrank(排序)也可以改为id,在引用的时候就要用id
function upArticle($parentid, $lableName, $lableValue, $ascOrDesc){
    $upArticle= handleUpDownArticle('上一篇：','uppage',$parentid, $lableName,$lableValue,$ascOrDesc);
    return @$upArticle;
}
//下一篇文章
function downArticle($parentid, $lableName, $lableValue,$ascOrDesc){
    $downArticle= handleUpDownArticle('下一篇：','downpage', $parentid,$lableName,$lableValue,$ascOrDesc);
    return @$downArticle;
}
//处理上下页
function handleUpDownArticle($lableTitle,$sType,$parentid, $lableName,$lableValue,$ascOrDesc){
    $c=''; $url='';$target='';$targetStr='';

    $sql='';
    if( $lableName=='adddatetime' ){
        $lableValue='#'. $lableValue .'#';
    }
    //位置互换
    if( $ascOrDesc=='desc' ){
        if( $sType=='uppage' ){
            $sType='downpage';
        }else{
            $sType='uppage';
        }
    }
    if( $sType=='uppage' ){
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentid=' . $parentid . ' and ' . $lableName . '<' . $lableValue . ' order by ' . $lableName . ' desc';
    }else{
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentid=' . $parentid . ' and ' . $lableName . '>' . $lableValue . ' order by ' . $lableName . ' asc';
    }

    //call echo("sql",sql)
    $rsxObj=$GLOBALS['conn']->query( $sql);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $target=$rsx['target'];
        if( $target<>'' ){
            $targetStr=' target="'. $target .'"';
        }
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/detail' . $rsx['id']);
        }else{
            if( $rsx['customaurl']=='' ){
                $url= handleWebUrl('?act=detail&id=' . $rsx['id']);
            }else{
                $url= handleWebUrl($rsx['customaurl']);
            }
        }
        $c= '<a href="' . $url . '"'. $targetStr .'>' . $lableTitle . $rsx['title'] . '</a>';
    }else{
        $c= $lableTitle . '没有';
    }
    $handleUpDownArticle= $c;
    return @$handleUpDownArticle;
}
//获得RS网址 配置上一页 下一页
function getRsUrl( $fileName, $customAUrl, $defaultFileName){
    $url ='';
    //用默认文件名称
    if( $fileName== '' ){
        $fileName= $defaultFileName;
    }
    //网址
    if( $fileName <> '' ){
        $fileName= lCase($fileName); //让文件名称小写20160315
        $url= $fileName;
        if( inStr(lCase($url), '.html')== false && right($url, 1) <> '/' ){
            $url= $url . '.html';
        }
    }
    if( aspTrim($customAUrl) <> '' ){
        $url= aspTrim($customAUrl);
    }
    if( inStr($GLOBALS['cfg_flags'], '|addwebsite|') > 0 ){
        //url = replaceGlobleVariable(url)   '替换全局变量
        if( inStr($url, '$cfg_websiteurl$')== false && inStr($url, '{$GetColumnUrl ')== false && inStr($url, '{$GetArticleUrl ')== false && inStr($url, '{$GetOnePageUrl ')== false ){
            $url= urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url);
        }
    }
    $getRsUrl= $url;
    return @$getRsUrl;
}
//获得处理后RS网址
function getHandleRsUrl($fileName, $customAUrl, $defaultFileName){
    $url ='';
    $url= getRsUrl($fileName, $customAUrl, $defaultFileName);
    //因为URL如果为自定义的则需要处理下全局变量，这样程序运行又会变慢，不就可以使用生成HTML方法解决这个问题，20160308
    $url= replaceGlobleVariable($url);
    $getHandleRsUrl= $url;
    return @$getHandleRsUrl;
}

//获得单页url 20160114
function getOnePageUrl($title){
    $url ='';
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where title=\'' . $title . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/page' . $rsx['id']);
        }else{
            $url= handleWebUrl('?act=onepage&id=' . $rsx['id']);
            if( $rsx['customaurl'] <> '' ){
                $url= $rsx['customaurl'];
            }
        }
    }

    $getOnePageUrl= $url;
    return @$getOnePageUrl;
}
//获得文章
function getArticleUrl($title){
    $url ='';
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where title=\'' . $title . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/' . $rsx['id']);
        }else{
            $url= handleWebUrl('?act=article&id=' . $rsx['id']);
            if( $rsx['customaurl'] <> '' ){
                $url= $rsx['customaurl'];
            }
        }
    }

    $getArticleUrl= $url;
    return @$getArticleUrl;
}
//获得栏目url 20160114
function getColumnUrl($columnNameOrId, $sType){
    $url=''; $addSql ='';

    $columnNameOrId= replaceGlobleVariable($columnNameOrId); //处理动作 <a href="{$GetColumnUrl columnname='[$glb_columnName$]' $}" >更多图片</a>

    if( $sType== 'name' ){
        $addSql= ' where columnname=\'' . replace($columnNameOrId,'\'','\'\'') . '\'';			 //对'号处理，要不然sql查询出错20160716
    }else{
        $addSql= ' where id=' . $columnNameOrId . '';
    }
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn' . $addSql);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']);
        }else{
            $url= handleWebUrl('?act=nav&columnName=' . $rsx['columnname']);
            if( $rsx['customaurl'] <> '' ){
                $url= $rsx['customaurl'];
            }
        }
    }

    $getColumnUrl= $url;
    return @$getColumnUrl;
}

//获得文章标题对应的id
function getArticleId($title){
    $title= replace($title, '\'', ''); //注意，这个不能留
    $getArticleId= -1;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'ArticleDetail where title=\'' . $title . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getArticleId= $rsx['id'];
    }
    return @$getArticleId;
}

//获得栏目名称对应的id
function getColumnId($columnName){
    // columnName = Replace(columnName, "'", "")           '注意，这个不能留  因为sql里已经处理了 20160716 home 程序写得越来越深，逻辑越多
    $getColumnId= -1;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where columnName=\'' . $columnName . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getColumnId= $rsx['id'];
    }
    return @$getColumnId;
}
//获得后台菜单名称对应的id
function getListMenuId($title){
    $title= replace($title, '\'', ''); //注意，这个不能留
    $getListMenuId= -1;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where title=\'' . $title. '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getListMenuId= $rsx['id'];
    }
    return @$getListMenuId;
}


//获得栏目ID对应的名称
function getColumnName($id){
    if( $id <> '' ){
        $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $id);
        if( @mysql_num_rows($rsxObj)!=0 ){
            $rsx=mysql_fetch_array($rsxObj);
            $getColumnName= $rsx['columnname'];
        }
    }
    return @$getColumnName;
}

//获得后台菜单ID对应的名称
function getListMenuName($id){
    if( $id <> '' ){
        $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where id=' . $id);
        if( @mysql_num_rows($rsxObj)!=0 ){
            $rsx=mysql_fetch_array($rsxObj);
            $getListMenuName= $rsx['title'];
        }
    }
    return @$getListMenuName;
}





//获得栏目ID对应的类型
function getColumnType($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getColumnType= $rsx['columntype'];
    }
    return @$getColumnType;
}


//获得栏目ID对应的内容
function getColumnBodyContent($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getColumnBodyContent= $rsx['bodycontent'];
    }
    return @$getColumnBodyContent;
}







//网站统计2014
function webStat($folderPath){
    $dateTime=''; $content=''; $splStr ='';
    $thisUrl=''; $goToUrl=''; $caiShu=''; $c=''; $fileName=''; $co=''; $ie=''; $xp ='';
    $goToUrl= serverVariables('HTTP_REFERER');
    $thisUrl= 'http://' . serverVariables('HTTP_HOST') . serverVariables('SCRIPT_NAME');
    $caiShu= serverVariables('QUERY_STRING');
    if( $caiShu <> '' ){
        $thisUrl= $thisUrl . '?' . $caiShu;
    }
    $goToUrl= @$_REQUEST['GoToUrl'];
    $thisUrl= @$_REQUEST['ThisUrl'];
    $co= @$_GET['co'];
    $dateTime= now();
    $content= serverVariables('HTTP_USER_AGENT');
    $content= replace($content, 'MSIE', 'Internet Explorer');
    $content= replace($content, 'NT 5.0', '2000');
    $content= replace($content, 'NT 5.1', 'XP');
    $content= replace($content, 'NT 5.2', '2003');

    $splStr= aspSplit($content . ';;;;', ';');
    $ie= $splStr[1];
    $xp= aspTrim($splStr[2]);
    if( right($xp, 1)== ')' ){ $xp= mid($xp, 1, len($xp) - 1) ;}
    $c= '来访' . $goToUrl . vbCrlf();
    $c= $c . '当前：' . $thisUrl . vbCrlf();
    $c= $c . '时间：' . $dateTime . vbCrlf();
    $c= $c . 'IP:' . getIP() . vbCrlf();
    $c= $c . 'IE:' . getBrType('') . vbCrlf();
    $c= $c . 'Cookies=' . $co . vbCrlf();
    $c= $c . 'XP=' . $xp . vbCrlf();
    $c= $c . 'Screen=' . @$_REQUEST['screen'] . vbCrlf(); //屏幕分辨率
    $c= $c . '用户信息=' . serverVariables('HTTP_USER_AGENT') . vbCrlf(); //用户信息

    $c= $c . '-------------------------------------------------' . vbCrlf();
    //c=c & "CaiShu=" & CaiShu & vbcrlf
    $fileName= $folderPath . Format_Time(now(), 2) . '.txt';
    CreateAddFile($fileName, $c);
    $c= $c . vbCrlf() . $fileName;
    $c= replace($c, vbCrlf(), '\\n');
    $c= replace($c, '"', '\\"');
    //Response.Write("eval(""var MyWebStat=\""" & C & "\"""")")

    $splxx=''; $nIP=''; $nPV=''; $ipList=''; $s=''; $ip ='';
    //判断是否显示回显记录
    if( @$_REQUEST['stype']== 'display' ){
        $content= getFText($fileName);
        $splxx= aspSplit($content, vbCrlf() . '-------------------------------------------------' . vbCrlf());
        $nIP= 0;
        $nPV= 0;
        $ipList= '';
        foreach( $splxx as $key=>$s){
            if( inStr($s, '当前：') > 0 ){
                $s= vbCrlf() . $s . vbCrlf();
                $ip= ADSql(getStrCut($s, vbCrlf() . 'IP:', vbCrlf(), 0));
                $nPV= $nPV + 1;
                if( inStr(vbCrlf() . $ipList . vbCrlf(), vbCrlf() . $ip . vbCrlf())== false ){
                    $ipList= $ipList . $ip . vbCrlf();
                    $nIP= $nIP + 1;
                }
            }
        }
        Rw('document.write(\'网长统计 | 今日IP[' . $nIP . '] | 今日PV[' . $nPV . '] \')');
    }
    $webStat= $c;
    return @$webStat;
}

//判断传值是否相等

//HTML标签参数自动添加(target|title|alt|id|class|style|)    辅助类
function setHtmlParam($content, $ParamList){
    $splStr=''; $startStr=''; $endStr=''; $c=''; $paramValue=''; $ReplaceStartStr ='';
    $endStr= '\'';
    $splStr= aspSplit($ParamList, '|');
    foreach( $splStr as $key=>$startStr){
        $startStr= aspTrim($startStr);
        if( $startStr <> '' ){
            //替换开始字符   因为开始字符类型可变 不同
            $ReplaceStartStr= $startStr;
            if( left($ReplaceStartStr, 3)== 'img' ){
                $ReplaceStartStr= mid($ReplaceStartStr, 4,-1);
            }else if( left($ReplaceStartStr, 1)== 'a' ){
                $ReplaceStartStr= mid($ReplaceStartStr, 2,-1);
            }else if( inStr('|ul|li|', '|' . left($ReplaceStartStr, 2) . '|') > 0 ){
                $ReplaceStartStr= mid($ReplaceStartStr, 3,-1);
            }
            $ReplaceStartStr= ' ' . $ReplaceStartStr . '=\'';

            $startStr= ' ' . $startStr . '=\'';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
                $paramValue= StrCut($content, $startStr, $endStr, 2);
                $paramValue= HandleInModule($paramValue, 'end'); //处理内部模块
                $c= $c . $ReplaceStartStr . $paramValue . $endStr;
            }
        }
    }
    $setHtmlParam= $c;
    return @$setHtmlParam;
}
?>