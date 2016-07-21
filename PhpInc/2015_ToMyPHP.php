<?PHP
//与php通用   我的后台

//获得网站底部内容aa
function XY_AP_WebSiteBottom($action){
    $s='';$url='';
    if( inStr($GLOBALS['cfg_webSiteBottom'], '[$aoutadd$]') > 0 ){
        $GLOBALS['cfg_webSiteBottom']= getDefaultValue($action); //获得默认内容
        connexecute('update ' . $GLOBALS['db_PREFIX'] . 'website set websitebottom=\'' . ADSql($GLOBALS['cfg_webSiteBottom']) . '\'');
    }

    $s=$GLOBALS['cfg_webSiteBottom'];
    //网站底部
    if( @$_REQUEST['gl']== 'edit' ){
        $s= '<span>' . $s . '</span>';
    }
    $url= WEB_ADMINURL . '?act=addEditHandle&switchId=2&id=*&actionType=WebSite&lableTitle=站点配置&n=' . getRnd(11);
    $s= handleDisplayOnlineEditDialog($url, $s, '', 'span');

    $XY_AP_WebSiteBottom= $s;
    return @$XY_AP_WebSiteBottom;
}

//asp与php版本
function XY_EDITORTYPE($action){
    $aspValue='';$phpValue='';$s='';
    $aspValue= lCase(RParam($action, 'asp'));
    $phpValue= lCase(RParam($action, 'php'));
    if( EDITORTYPE=='asp' ){
        $s=$aspValue;
    }else{
        $s=$phpValue;
    }
    $XY_EDITORTYPE=$s;
    return @$XY_EDITORTYPE;
}


//加载文件
function XY_Include($action){
    $templateFilePath=''; $Block=''; $startStr=''; $endStr=''; $content ='';
    $templateFilePath= lCase(RParam($action, 'File'));
    $Block= lCase(RParam($action, 'Block'));

    $findstr=''; $replaceStr ='';//查找字符，替换字符
    $findstr= moduleFindContent($action, 'findstr'); //先找块
    $replaceStr= moduleFindContent($action, 'replacestr'); //先找块

    $templateFilePath= handleFileUrl($templateFilePath); //处理文件路径
    if( CheckFile($templateFilePath)== false ){
        $templateFilePath= $GLOBALS['webTemplate'] . $templateFilePath;
    }
    $content= getFText($templateFilePath);
    if( $Block <> '' ){
        $startStr= '<!--#' . $Block . ' start#-->';
        $endStr= '<!--#' . $Block . ' end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $content= StrCut($content, $startStr, $endStr, 2);
        }
    }
    //替换读出来的内容
    if( $findstr <> '' ){
        $content= replace($content, $findstr, $replaceStr);
    }

    $XY_Include= $content;
    return @$XY_Include;
}

//栏目菜单
function XY_AP_ColumnMenu($action){
    $defaultStr=''; $thisId=''; $parentid='';$c='';
    $parentid= aspTrim(RParam($action, 'parentid'));
    $parentid=getColumnId($parentid);

    if( $parentid== '' ){ $parentid= -1 ;}

    $thisId= $GLOBALS['glb_columnId'];
    if( $thisId== '' ){ $thisId= -1 ;}
    $defaultStr= getDefaultValue($action); //获得默认内容

    $defaultStr=$defaultStr . '[topnav]'. $parentid .'[/topnav]';
    $XY_AP_ColumnMenu= showColumnList( $parentid, 'webcolumn', 'columnname',$thisId , 0, $defaultStr);

    return @$XY_AP_ColumnMenu;
}



//显示栏目列表
function XY_AP_ColumnList($action){
    $sql=''; $flags=''; $addSql=''; $columnname ='';
    $sql= RParam($action, 'sql');
    $flags= RParam($action, 'flags');
    $addSql= RParam($action, 'addSql');
    $columnname= RParam($action, 'columnname');
    if( $flags <> '' ){
        $sql= ' where flags like\'%' . $flags . '%\'';
    }
    if( $columnname <> '' ){
        $sql= getWhereAnd($sql, 'where parentid=' . getColumnId($columnname));
        //call echo(sql,columnName)
    }
    //追加sql
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $XY_AP_ColumnList= XY_AP_GeneralList($action, 'WebColumn', $sql);

    return @$XY_AP_ColumnList;
}

//显示文章列表
function XY_AP_ArticleList($action){
    $sql=''; $addSql=''; $columnName=''; $columnId=''; $topNumb=''; $idRand=''; $splStr=''; $s=''; $columnIdList ='';
    $action= replaceGlobleVariable($action); //处理下替换标签
    $sql= RParam($action, 'sql');
    $topNumb= RParam($action, 'topNumb');


    //id随机
    $idRand= lCase(RParam($action, 'rand'));
    if( $idRand== 'true' || $idRand== '1' ){
        $sql= $sql . ' where id in(' . getRandArticleId('', $topNumb) . ')';
    }

    //栏目名称 对栏目数组处理如 模板分享下载[Array]CSS3[Array]HTML5
    $s= RParam($action, 'columnName');
    if( $s== '' ){
        $s= RParam($action, 'did');
    }
    if( $s <> '' ){
        $splStr= aspSplit($s, '[Array]');
        foreach( $splStr as $key=>$columnName){
            $columnId= getColumnId($columnName);
            if( $columnId <> '' ){
                if( $columnIdList <> '' ){
                    $columnIdList= $columnIdList . ',';
                }
                $columnIdList= $columnIdList . $columnId;
            }
        }
    }
    if( $columnIdList <> '' ){
        $sql= getWhereAnd($sql, 'where parentId in(' . $columnIdList . ')');
    }
    //追加sql
    $addSql= RParam($action, 'addSql');
    //call echo("addsql",addsql)
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $sql= replaceGlobleVariable($sql);
    //call echo(RParam(action, "columnName") ,sql)
    $XY_AP_ArticleList= XY_AP_GeneralList($action, 'ArticleDetail', $sql);
    return @$XY_AP_ArticleList;
}

//显示评论列表
function XY_AP_CommentList($action){
    $itemID=''; $sql=''; $addSql ='';
    $addSql= RParam($action, 'addsql');
    $itemID= RParam($action, 'itemID');
    $itemID= replaceGlobleVariable($itemID);

    if( $itemID <> '' ){
        $sql= ' where itemID=' . $itemID;
    }
    //追加sql
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $XY_AP_CommentList= XY_AP_GeneralList($action, 'TableComment', $sql);
    return @$XY_AP_CommentList;
}

//显示搜索统计
function XY_AP_SearchStatList($action){
    $addSql ='';
    $addSql= RParam($action, 'addSql');
    $XY_AP_SearchStatList= XY_AP_GeneralList($action, 'SearchStat', $addSql);
    return @$XY_AP_SearchStatList;
}
//显示友情链接
function XY_AP_Links($action){
    $addSql ='';
    $addSql= RParam($action, 'addSql');
    $XY_AP_Links= XY_AP_GeneralList($action, 'FriendLink', $addSql);
    return @$XY_AP_Links;
}

//通用信息列表
function XY_AP_GeneralList($action, $tableName, $addSql){
    $title=''; $topNumb=''; $nTop=''; $isB=''; $sql ='';
    $columnName=''; $columnEnName=''; $aboutcontent=''; $bodyContent=''; $showTitle ='';
    $bannerImage=''; $smallImage=''; $bigImage=''; $id ='';
    $defaultStr=''; $i=''; $j=''; $s=''; $c=''; $startStr=''; $endStr=''; $url ='';
    $noFollow ='';//不追踪 20141222
    $defaultStr= getDefaultValue($action); //获得默认内容
    $modI ='';//余循环20150112
    $noFollow= aspTrim(lCase(RParam($action, 'noFollow'))); //不追踪
    $lableTitle ='';//标题标题
    $target ='';//a链接打开目标方式
    $adddatetime ='';//添加时间
    $isFocus ='';
    $fieldNameList ='';//字段列表
    $abcolorStr ='';//A加粗和颜色
    $atargetStr ='';//A链接打开方式
    $atitleStr ='';//A链接的title20160407
    $anofollowStr ='';//A链接的nofollow
    $splFieldName=''; $fieldName=''; $replaceStr=''; $k='';$idPage='';

    $tableName=lCase($tableName);		//转小写
    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段列表');
    $splFieldName= aspSplit($fieldNameList, ',');

    $topNumb= RParam($action, 'topNumb') ; $nTop= $topNumb;
    if( $nTop <> '' ){
        $nTop= CInt($nTop);
    }else{
        $nTop= 999;
    }
    if( $sql== '' ){
        if( $topNumb <> '' ){
            $topNumb= ' top ' . $topNumb . ' ';
        }
        $sql= 'Select ' . $topNumb . '* From ' . $GLOBALS['db_PREFIX'] . $tableName;
    }
    //追加sql
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $sql= replaceGlobleVariable($sql); //替换全局变量

    //检测SQL
    if( checkSql($sql)== false ){
        errorLog('出错提示：<br>action=' . $action . '<hr>sql=' . $sql . '<br>');
        return '';
    }
    $rsObj=$GLOBALS['conn']->query( $sql);
    for( $i= 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $rs=mysql_fetch_array($rsObj);
        $startStr= '' ; $endStr= '';
        //call echo(sql,i & "," & nTop)
        if( $i > $nTop ){
            break;
        }
        //#【PHP】$rs=mysql_fetch_array($rsObj);                                            //给PHP用，因为在 asptophp转换不完善
        $isFocus= false; //交点为假
        $id= $rs['id'];
        //【导航】
        if( $tableName== 'webcolumn' ){
            if( $GLOBALS['isMakeHtml']== true ){
                $url= getRsUrl($rs['filename'], $rs['customaurl'], '/nav' . $rs['id']);
            }else{
                $url= handleWebUrl('?act=nav&columnName=' . $rs['columnname']); //会追加gl等参数
                if( $rs['customaurl'] <> '' ){
                    $url= $rs['customaurl'];
                    $url= replaceGlobleVariable($url);
                }
            }
            //全局栏目名称为空则为自动定位首页 追加(20160128)
            if( $GLOBALS['glb_columnName']== '' && $rs['columntype']== '首页' ){
                $GLOBALS['glb_columnName']= $rs['columnname'];
            }
            if( $rs['columnname']== $GLOBALS['glb_columnName'] ){
                $isFocus= true;
            }
            //【文章】
        }else if( $tableName== 'articledetail' ){
            if( $GLOBALS['isMakeHtml']== true ){
                $url= getRsUrl($rs['filename'], $rs['customaurl'], 'detail/detail' . $rs['id']);
            }else{
                $url= handleWebUrl('?act=detail&id=' . $rs['id']); //会追加gl等参数
                if( $rs['customaurl'] <> '' ){
                    $url= $rs['customaurl'];
                }
            }
            //评论
        }else if( $tableName== 'tablecomment' ){

        }

        //A链接添加颜色
        $abcolorStr= '';
        if( inStr($fieldNameList, ',titlecolor,') > 0 ){
            //A链接颜色
            if( $rs['titlecolor'] <> '' ){
                $abcolorStr= 'color:' . $rs['titlecolor'] . ';';
            }
        }
        if( inStr($fieldNameList, ',flags,') > 0 ){
            //A链接加粗
            if( inStr($rs['flags'], '|b|') > 0 ){
                $abcolorStr= $abcolorStr . 'font-weight:bold;';
            }
        }
        if( $abcolorStr <> '' ){
            $abcolorStr= ' style="' . $abcolorStr . '"';
        }

        //打开方式2016
        if( inStr($fieldNameList, ',target,') > 0 ){
            $atargetStr= IIF($rs['target'] <> '', ' target="' . $rs['target'] . '"', '');
        }

        //A的title
        if( inStr($fieldNameList, ',title,') > 0 ){
            $atitleStr= IIF($rs['title'] <> '', ' title="' . $rs['title'] . '"', '');
        }

        //A的nofollow
        if( inStr($fieldNameList, ',nofollow,') > 0 ){
            $anofollowStr= IIF($rs['nofollow'] <> 0, ' rel="nofollow"', '');
        }

        //交点判断(给栏目导航用的)
        if( $isFocus== true ){
            $startStr= '[list-focus]' ; $endStr= '[/list-focus]';
        }else{
            $startStr= '[list-' . $i . ']' ; $endStr= '[/list-' . $i . ']';
        }

        //在最后时排序当前交点20160202
        if( $i== $topNumb && $isFocus== false ){
            $startStr= '[list-end]' ; $endStr= '[/list-end]';
        }

        //例[list-mod2]  [/list-mod2]    20150112
        for( $modI= 6 ; $modI>= 2 ; $modI--){
            if( inStr($defaultStr, $startStr)== false && $i % $modI== 0 ){
                $startStr= '[list-mod' . $modI . ']' ; $endStr= '[/list-mod' . $modI . ']';
                if( inStr($defaultStr, $startStr) > 0 ){
                    break;
                }
            }
        }

        //没有则用默认
        if( inStr($defaultStr, $startStr)== false ){
            $startStr= '[list]' ; $endStr= '[/list]';
        }


        if( inStr($defaultStr, $startStr) > 0 && inStr($defaultStr, $endStr) > 0 ){
            $s= StrCut($defaultStr, $startStr, $endStr, 2);

            $s= replaceValueParam($s, 'i', $i); //循环编号
            $s= replaceValueParam($s, '编号', $i); //循环编号
            $s= replaceValueParam($s, 'id', $rs['id']); //id编号 因为获得字段他不获得id
            $s= replaceValueParam($s, 'url', $url); //网址
            $s= replaceValueParam($s, 'aurl', 'href="' . $url . '"'); //网址
            $s= replaceValueParam($s, 'abcolor', $abcolorStr); //A链接加颜色与加粗
            $s= replaceValueParam($s, 'atitle', $atitleStr); //A链接title
            $s= replaceValueParam($s, 'anofollow', $anofollowStr); //A链接nofollow
            $s= replaceValueParam($s, 'atarget', $atargetStr); //A链接打开方式



            for( $k= 0 ; $k<= uBound($splFieldName); $k++){
                if( $splFieldName[$k] <> '' ){
                    $fieldName= $splFieldName[$k];
                    $replaceStr= $rs[$fieldName] . '';
                    $s= replaceValueParam($s, $fieldName, $replaceStr);
                }
            }


            //开始位置加Dialog内容
            $startStr= '[list-' . $i . ' startdialog]' ; $endStr= '[/list-' . $i . ' startdialog]';
            if( inStr($defaultStr, $startStr) > 0 && inStr($defaultStr, $endStr) > 0 ){
                $s= StrCut($defaultStr, $startStr, $endStr, 2) . $s;
            }
            //结束位置加Dialog内容
            $startStr= '[list-' . $i . ' enddialog]' ; $endStr= '[/list-' . $i . ' enddialog]';
            if( inStr($defaultStr, $startStr) > 0 && inStr($defaultStr, $endStr) > 0 ){
                $s= $s . StrCut($defaultStr, $startStr, $endStr, 2);
            }

            //加控制
            //【导航】
            if( $tableName== 'webcolumn' ){
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11);

                //【评论】
            }else if( $tableName=='tablecomment' ){
                $idPage=getThisIdPage($GLOBALS['db_PREFIX'] . $tableName ,$rs['id'],10);
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=TableComment&lableTitle=评论&nPageSize=10&parentid=&searchfield=bodycontent&keyword=&addsql=&page='. $idPage .'&id=' . $rs['id'] . '&n=' . getRnd(11);

                //【文章】
            }else if( $tableName== 'articledetail' ){
                $idPage=getThisIdPage($GLOBALS['db_PREFIX'] . $tableName ,$rs['id'],10);
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page='. $idPage .'&parentid='. $rs['parentid'] .'&id=' . $rs['id'] . '&n=' . getRnd(11);

                $s= replaceValueParam($s, 'columnurl', getColumnUrl($rs['parentid'], '')); //文章对应栏目URL 20160304
                $s= replaceValueParam($s, 'columnname', getColumnName($rs['parentid'])); //文章对应栏目名称 20160304

            }
            $s= handleDisplayOnlineEditDialog($url, $s, '', 'div|li|span'); //处理是否添加在线修改管理器
            $c= $c . $s;
        }
    }

    //开始内容加Dialog内容
    $startStr= '[dialog start]' ; $endStr= '[/dialog start]';
    if( inStr($defaultStr, $startStr) > 0 && inStr($defaultStr, $endStr) > 0 ){
        $c= StrCut($defaultStr, $startStr, $endStr, 2) . $c;
    }
    //结束内容加Dialog内容
    $startStr= '[dialog end]' ; $endStr= '[/dialog end]';
    if( inStr($defaultStr, $startStr) > 0 && inStr($defaultStr, $endStr) > 0 ){
        $c= $c . StrCut($defaultStr, $startStr, $endStr, 2);
    }
    $XY_AP_GeneralList= $c;
    return @$XY_AP_GeneralList;
}


//处理获得表内容
function XY_handleGetTableBody($action, $tableName, $fieldParamName, $defaultFileName, $adminUrl){
    $url=''; $content=''; $id=''; $sql=''; $addSql=''; $fieldName=''; $fieldParamValue=''; $fieldNameList=''; $nLen=''; $delHtmlYes=''; $trimYes='';$defaultStr='';
    $noisonhtml='';$intoFieldStr='';$valuesStr='';$nonull='';
    $fieldName= RParam($action, 'fieldname'); //字段名称
    $noisonhtml= RParam($action, 'noisonhtml');					 //不生成html
    $nonull=RParam($action, 'noisonhtml');							//内容不能为空20160716 home

    if( $noisonhtml=='true' ){
        $intoFieldStr=',isonhtml';
        $valuesStr=',0';
    }

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段列表');
    //字段名称不为空，并且要在表字段里
    if( $fieldName== '' || inStr($fieldNameList, ',' . $fieldName . ',')== false ){
        $fieldName= $defaultFileName;
    }
    $fieldName= lCase($fieldName); //转为小写，因为在PHP里是全小写的

    $fieldParamValue= RParam($action, $fieldParamName); //截取字段内容
    $id= handleNumber(RParam($action, 'id')); //获得ID
    $addSql= ' where ' . $fieldParamName . '=\'' . $fieldParamValue . '\'';
    if( $id <> '' ){
        $addSql= ' where id=' . $id;
    }

    $content= getDefaultValue($action) ;$defaultStr=$content; //获得默认内容
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . $addSql;
    $rsObj=$GLOBALS['conn']->query( $sql);
    if( @mysql_num_rows($rsObj)==0 ){
        $rs=mysql_fetch_array($rsObj);
        //自动添加 20160113
        if( RParam($action, 'autoadd')== 'true' ){
            connexecute('insert into ' . $GLOBALS['db_PREFIX'] . $tableName . ' (' . $fieldParamName . ',' . $fieldName . $intoFieldStr . ') values(\'' . $fieldParamValue . '\',\'' . ADSql($content) . '\''. $valuesStr .')');
        }
    }else{
        $id= $rs['id'];
        $content= $rs[$fieldName];
        if( len($content)<=0 ){
            $content=$defaultStr;
            connexecute('update ' . $GLOBALS['db_PREFIX'] . $tableName . ' set ' . $fieldName . '=\''. $content .'\' where id=' . $rs['id']);
        }
    }

    //删除Html
    $delHtmlYes= RParam($action, 'delHtml'); //是否删除Html
    if( $delHtmlYes== 'true' ){ $content= replace(delHtml($content), '<', '&lt;') ;}//HTML处理
    //删除两边空格
    $trimYes= RParam($action, 'trim'); //是否删除两边空格
    if( $trimYes== 'true' ){ $content= TrimVbCrlf($content) ;}

    //截取字符处理
    $nLen= RParam($action, 'len'); //字符长度值
    $nLen= handleNumber($nLen);
    //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
    if( $nLen <> '' ){ $content= CutStr($content, $nLen, '...') ;}//Left(ReplaceStr,nLen)


    if( $id== '' ){
        $id= XY_AP_GetFieldValue('', $sql, 'id');
    }
    $url= $adminUrl . '&id=' . $id . '&n=' . getRnd(11);
    if( @$_REQUEST['gl']== 'edit' ){
        $content= '<span>' . $content . '</span>';
    }

    //call echo(sql,url)
    $content= handleDisplayOnlineEditDialog($url, $content, '', 'span');
    $XY_handleGetTableBody= $content;

    return @$XY_handleGetTableBody;
}

//获得单页内容
function XY_AP_GetOnePageBody($action){
    $adminUrl ='';
    $adminUrl= WEB_ADMINURL . '?act=addEditHandle&actionType=OnePage&lableTitle=单页&nPageSize=10&page=&switchId=2';
    $XY_AP_GetOnePageBody= XY_handleGetTableBody($action, 'onepage', 'title', 'bodycontent', $adminUrl);
    return @$XY_AP_GetOnePageBody;
}

//获得导航内容
function XY_AP_GetColumnBody($action){
    $adminUrl ='';
    $adminUrl= WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&switchId=2';
    $XY_AP_GetColumnBody= XY_handleGetTableBody($action, 'webcolumn', 'columnname', 'bodycontent', $adminUrl);
    return @$XY_AP_GetColumnBody;
}

//显示文章内容
function XY_AP_GetArticleBody($action){
    $adminUrl ='';
    $adminUrl= WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&switchId=2';
    $XY_AP_GetArticleBody= XY_handleGetTableBody($action, 'articledetail', 'title', 'bodycontent', $adminUrl);
    return @$XY_AP_GetArticleBody;
}


//获得栏目URL
function XY_GetColumnUrl($action){
    $columnName=''; $url ='';
    $columnName= RParam($action, 'columnName');
    $url= getColumnUrl($columnName, 'name');
    //handleWebUrl  有对gl处理

    //If Request("gl") <> "" Then
    //    url = url & "&gl=" & Request("gl")
    //End If
    $XY_GetColumnUrl= $url;

    return @$XY_GetColumnUrl;
}

//获得文章URL
function XY_GetArticleUrl($action){
    $title=''; $url ='';
    $title= RParam($action, 'title');
    $url= getArticleUrl($title);
    //If Request("gl") <> "" Then
    //    url = url & "&gl=" & Request("gl")
    //End If
    $XY_GetArticleUrl= $url;
    return @$XY_GetArticleUrl;
}

//获得单页URL
function XY_GetOnePageUrl($action){
    $title=''; $url ='';
    $title= RParam($action, 'title');
    $url= getOnePageUrl($title);
    //If Request("gl") <> "" Then
    //    url = url & "&gl=" & Request("gl")
    //End If
    $XY_GetOnePageUrl= $url;
    return @$XY_GetOnePageUrl;
}


//获得单个字段内容
function XY_AP_GetFieldValue($action, $sql, $fieldName){
    $title=''; $content ='';
    $rsObj=$GLOBALS['conn']->query( $sql);
    if( @mysql_num_rows($rsObj)!=0 ){
        $rs=mysql_fetch_array($rsObj);
        $content= $rs[$fieldName];
    }
    $XY_AP_GetFieldValue= $content;
    return @$XY_AP_GetFieldValue;
}


//Js版网站统计
function XY_JsWebStat($action){
    $s=''; $fileName=''; $sType ='';
    $sType= RParam($action, 'stype');
    $fileName= aspTrim(RParam($action, 'fileName'));
    if( $fileName== '' ){
        $fileName= '[$WEB_VIEWURL$]?act=webstat&stype=' . $sType;
    }
    $fileName= replace($fileName, '/', '\\/');
    $s= '<script>document.writeln("<script src=\\\'' . $fileName . '&GoToUrl="';
    $s= $s . '+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)';
    $s= $s . '+"&co="+escape(document.cookie)'; //收集cookie 不需要则屏蔽掉
    $s= $s . '+" \\\'><\\/script>");</script>';
    $XY_JsWebStat= $s;
    return @$XY_JsWebStat;
}



//普通链接A
function XY_HrefA($action){
    $content=''; $Href=''; $c=''; $AContent=''; $AType=''; $url=''; $title ='';
    $action= HandleInModule($action, 'start');
    $content= RParam($action, 'Content');
    $AType= RParam($action, 'Type');
    if( $AType== '收藏' ){
        //第一种方法
        //Url = "window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"
        $url= 'shoucang(document.title,window.location)';
        $c= '<a href=\'javascript:;\' onClick="' . $url . '" ' . setHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>';
    }else if( $AType== '设为首页' ){
        //第一种方法
        //Url = "var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"
        $url= 'SetHome(this,window.location)';
        $c= '<a href=\'javascript:;\' onClick="' . $url . '"' . setHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>';
    }else{
        $content= RParam($action, 'Title');
    }

    $content= HandleInModule($content, 'end');
    if( $c== '' ){ $c= '<a' . setHtmlParam($action, 'href|target|title|alt|id|class|rel|style') . '>' . $content . '</a>' ;}

    $XY_HrefA= $c;
    return @$XY_HrefA;
}



//布局20151231
function XY_Layout($action){
    $layoutName=''; $s=''; $c=''; $sourceStr=''; $replaceStr=''; $splSource=''; $splReplace=''; $i ='';

    $layoutName= RParam($action, 'layoutname');
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'weblayout where layoutname=\'' . $layoutName . '\'');
    if( @mysql_num_rows($rsObj)!=0 ){
        $rs=mysql_fetch_array($rsObj);
        $c= $rs['bodycontent'];

        $sourceStr= $rs['sourcestr']; //源内容 被替换内容
        $replaceStr= $rs['replacestr']; //替换内容
        $splSource= aspSplit($sourceStr, '[Array]'); //源内容数组
        $splReplace= aspSplit($replaceStr, '[Array]'); //替换内容数组

        for( $i= 0 ; $i<= uBound($splSource); $i++){
            $sourceStr= $splSource[$i];
            $replaceStr= $splReplace[$i];
            if( $sourceStr <> '' ){
                $c= replace($c, $sourceStr, $replaceStr);
                //call echo(sourceStr,replaceStr)
                //call echo(c,instr(c,sourcestr))
            }
        }
        //call rwend(c)
    }
    $XY_Layout= $c;
    return @$XY_Layout;
}

//模块20151231
function XY_Module($action){
    $moduleName=''; $s=''; $c=''; $sourceStr=''; $replaceStr=''; $splSource=''; $splReplace=''; $i ='';
    $moduleName= RParam($action, 'modulename');
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webmodule where modulename=\'' . $moduleName . '\'');
    if( @mysql_num_rows($rsObj)!=0 ){
        $rs=mysql_fetch_array($rsObj);
        $c= $rs['bodycontent'];

        $sourceStr= RParam($action, 'sourceStr'); //源内容 被替换内容
        $replaceStr= RParam($action, 'replaceStr'); //替换内容

        $splSource= aspSplit($sourceStr, '[Array]'); //源内容数组
        $splReplace= aspSplit($replaceStr, '[Array]'); //替换内容数组

        for( $i= 0 ; $i<= uBound($splSource); $i++){
            $sourceStr= $splSource[$i];
            $replaceStr= $splReplace[$i];
            if( $sourceStr <> '' ){
                $c= replace($c, $sourceStr, $replaceStr);
                //call echo(sourceStr,replaceStr)
                //call echo(c,instr(c,sourcestr))
            }
        }
        //call rwend(c)
    }
    $XY_Module= $c;
    return @$XY_Module;
}

//显示包裹块20160127
function XY_DisplayWrap( $action){
    $content ='';
    $content= getDefaultValue($action);
    $XY_DisplayWrap= $content;
    return @$XY_DisplayWrap;
}




//嵌套标题 测试
function XY_getLableValue($action){
    $title=''; $content=''; $c ='';
    //call echo("Action",Action)
    $title= RParam($action, 'title');
    $content= RParam($action, 'content');
    $c= $c . 'title=' . GetContentRunStr($title) . '<hr>';
    $c= $c . 'content=' . GetContentRunStr($content) . '<hr>';
    $XY_getLableValue= $c;
    aspEcho('title', $title);
    $XY_getLableValue= '【title=】【' . $title . '】';
    return @$XY_getLableValue;
}
//标题在搜索引擎中搜索列表
function XY_TitleInSearchEngineList($action){
    $title=''; $sType='';$divclass='';$spanclass='';$s='';$c='';

    $title= RParam($action, 'title');
    $sType= RParam($action, 'sType');
    $divclass= RParam($action, 'divclass');
    $spanclass= RParam($action, 'spanclass');

    $s='<strong>更多关于《' . $title . '》</strong>';
    if( $divclass<>'' ){
        $s='<div class="'. $divclass .'">'. $s .'</div>';
    }else if( $spanclass<>'' ){
        $s='<span class="'. $spanclass .'">'. $s .'</span>' . '<br>';
    }else{
        $s=$s . '<br>';
    }
    $c= $c . $s . vbCrlf();
    $c= $c . '<ul class="list"> ' . vbCrlf();
    $c= $c . '<li><a href="https://www.baidu.com/s?ie=gb2312&word=' . $title . '" rel="nofollow" target="_blank">【baidu搜索】在百度里搜索(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="http://www.haosou.com/s?ie=gb2312&q=' . $title . '" rel="nofollow" target="_blank">【haosou搜索】在好搜里搜索(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="https://search.yahoo.com/search;_ylt=A86.JmbkJatWH5YARmebvZx4?toggle=1&cop=mss&ei=gb2312&fr=yfp-t-901&fp=1&p=' . $title . '" rel="nofollow" target="_blank">【yahoo搜索】在雅虎里搜索(' . $title . ')</a></li>' . vbCrlf();

    $c= $c . '<li><a href="https://www.sogou.com/sogou?ie=utf8&query=' . toUTFChar($title) . '" rel="nofollow" target="_blank">【sogou搜索】在搜狗里搜索(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="http://www.youdao.com/search?ue=utf8&q=' . toUTFChar($title) . '" rel="nofollow" target="_blank">【youdao搜索】在有道里搜索(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="http://search.yam.com/Search/Web/DefaultKSA.aspx?SearchType=web&l=0&p=0&k=' . toUTFChar($title) . '" rel="nofollow" target="_blank">【yam搜索(google提供技术)】在蕃薯藤里搜索(' . $title . ')</a></li>' . vbCrlf();


    $c= $c . '<li><a href="http://cn.bing.com/search?q=' . toUTFChar($title) . '" rel="nofollow" target="_blank">【bing搜索】在必应里搜索(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '</ul>' . vbCrlf();

    $XY_TitleInSearchEngineList= $c;
    return @$XY_TitleInSearchEngineList;
}

//URL加密
function XY_escape($action){
    $content ='';
    $content= RParam($action, 'content');
    $XY_escape= escape($content);
    return @$XY_escape;
}
//URL解密
function XY_unescape($action){
    $content ='';
    $content= RParam($action, 'content');
    $XY_unescape= escape($content);
    return @$XY_unescape;
}
//获得网址
function XY_getUrl($action){
    $stype ='';
    $stype= RParam($action, 'stype');
    $XY_getUrl=getThisUrlNoParam();
    return @$XY_getUrl;
}



//For循环处理
function XY_ForArray($action){
    $arrayList=''; $splitStr=''; $defaultStr=''; $splStr=''; $forI=''; $title=''; $s=''; $c=''; $nloop ='';
    $arrayList= atRParam($action, 'arraylist'); //atRParam获得结果处理动作，但不替换动作内容
    $splitStr= RParam($action, 'splitstr');
    $nloop= RParam($action, 'nloop'); //循环数

    if( $arrayList== '' ){
        $arrayList= copyStr('循环' . $splitStr, $nloop);
    }

    $defaultStr= getDefaultValue($action);

    $splStr= aspSplit($arrayList, $splitStr);
    for( $forI= 0 ; $forI<= uBound($splStr); $forI++){
        $title= $splStr[$forI];
        if( $title <> '' ){
            $s= $defaultStr;
            $s= replaceValueParam($s, 'fortitle', $title);
            $s= replaceValueParam($s, 'forid', $forI+1);
            $s= replaceValueParam($s, 'fori', $forI);
            $s= replaceValueParam($s, 'forcount', uBound($splStr) + 1);
            $c= $c . $s;
        }
    }
    $XY_ForArray= $c;
    return @$XY_ForArray;
}

?>