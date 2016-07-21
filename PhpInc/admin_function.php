<?PHP
//后台操作核心程序 添加 删除 修改 列表

//调用function文件函数
function callFunction(){
    switch ( @$_REQUEST['stype'] ){
        case 'updateWebsiteStat' ; updateWebsiteStat() ;break;//更新网站统计
        case 'clearWebsiteStat' ; clearWebsiteStat() ;break;//清空网站统计
        case 'updateTodayWebStat' ; updateTodayWebStat() ;break;//更新网站今天统计
        case 'websiteDetail' ; websiteDetail() ;break;//详细网站统计
        case 'displayAccessDomain' ; displayAccessDomain()										;break;//显示访问域名
        case 'delTemplate' ; delTemplate();										//删除模板


        break;
        default ; Eerr('function1页里没有动作', @$_REQUEST['stype']);
    }
}

//显示访问域名
function displayAccessDomain(){
    $visitWebSite='';$visitWebSiteList='';$urlList='';$nOK='';
    handlePower('显示访问域名');
    $GLOBALS['conn=']=OpenConn();
    $nOK=0;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'websitestat');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $visitWebSite=lCase(getWebSite($rs['visiturl']));
        //call echo("visitWebSite",visitWebSite)
        if( inStr(vbCrlf() . $visitWebSiteList . vbCrlf(),vbCrlf() . $visitWebSite . vbCrlf())==false ){
            if( $visitWebSite<>lCase(getWebSite(webDoMain())) ){
                $visitWebSiteList=$visitWebSiteList . $visitWebSite . vbCrlf();
                $nOK=$nOK+1;
                $urlList=$urlList . $nOK . '、<a href=\'' . $rs['visiturl'] . '\' target=\'_blank\'>' . $rs['visiturl'] . '</a><br>';
            }
        }
    }
    aspEcho('显示访问域名','操作完成 <a href=\'javascript:history.go(-1)\'>点击返回</a>');
    rwEnd($visitWebSiteList . '<br><hr><br>' . $urlList);
}
//获得处理后表列表 20160313
function getHandleTableList(){
    $s=''; $lableStr ='';
    $lableStr= '表列表[' . @$_REQUEST['mdbpath'] . ']';
    if( $GLOBALS['WEB_CACHEContent']== '' ){
        $GLOBALS['WEB_CACHEContent']= getFText($GLOBALS['WEB_CACHEFile']);
    }
    $s= getConfigContentBlock($GLOBALS['WEB_CACHEContent'], '#' . $lableStr . '#');
    if( $s== '' ){
        $s= lCase(getTableList());
        $s= '|' . replace($s, vbCrlf(), '|') . '|';
        $GLOBALS['WEB_CACHEContent']= setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $s, '#' . $lableStr . '#');
        if( $GLOBALS['isCacheTip']==true ){
            aspEcho('缓冲', $lableStr);
        }
    }
    $getHandleTableList= $s;
    return @$getHandleTableList;
}

//获得处理的字段列表   getHandleFieldList("ArticleDetail","字段列表")
function getHandleFieldList($tableName, $sType){
    $s ='';
    if( $GLOBALS['WEB_CACHEContent']== '' ){
        $GLOBALS['WEB_CACHEContent']= getFText($GLOBALS['WEB_CACHEFile']);
    }
    $s= getConfigContentBlock($GLOBALS['WEB_CACHEContent'], '#' . $tableName . $sType . '#');

    if( $s== '' ){
        if( $sType== '字段配置列表' ){
            $s= lCase(getFieldConfigList($tableName));
        }else{
            $s= lCase(getFieldList($tableName));
        }
        $GLOBALS['WEB_CACHEContent']= setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $s, '#' . $tableName . $sType . '#');
        if( $GLOBALS['isCacheTip']==true ){
            aspEcho('缓冲', $tableName . $sType);
        }
    }
    $getHandleFieldList= $s;
    return @$getHandleFieldList;
}
//读模板内容 20160310
function getTemplateContent($templateFileName){
    loadWebConfig();
    //读模板
    $templateFile=''; $customTemplateFile=''; $c='';
    $customTemplateFile= ROOT_PATH . 'template/' . $GLOBALS['db_PREFIX'] . '/' . $templateFileName;
    //为手机端
    if( CheckMobile()== true || @$_REQUEST['m']=='mobile' ){
        $templateFile= ROOT_PATH . '/Template/mobile/' . $templateFileName;
    }
    //判断手机端文件是否存在20160330
    if( CheckFile($templateFile)== false ){
        if( CheckFile($customTemplateFile)== true ){
            $templateFile= $customTemplateFile;
        }else{
            $templateFile= ROOT_PATH . $templateFileName;
        }
    }
    $c= getFText($templateFile);
    $c= replaceLableContent($c);
    $getTemplateContent= $c;
    return @$getTemplateContent;
}
//替换标签内容
function replaceLableContent($content){
    $s='';$c='';$splstr='';$list='';
    $content= replace($content, '{$webVersion$}', $GLOBALS['webVersion']); //网站版本
    $content= replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']); //网站标题
    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //ASP与PHP
    $content= replace($content, '{$adminDir$}', $GLOBALS['adminDir']); //后台目录

    $content= replace($content, '[$adminId$]', @$_SESSION['adminId']); //管理员ID
    $content= replace($content, '{$adminusername$}', @$_SESSION['adminusername']); //管理账号名称
    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //程序类型
    $content= replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL); //前台
    $content= replace($content, '{$webVersion$}', $GLOBALS['webVersion']); //版本
    $content= replace($content, '{$WebsiteStat$}', getConfigFileBlock($GLOBALS['WEB_CACHEFile'], '#访客信息#')); //最近访客信息


    $content= replace($content, '{$DB_PREFIX$}', $GLOBALS['db_PREFIX']); //表前缀
    $content= replace($content, '{$adminflags$}', IIF(@$_SESSION['adminflags']== '|*|', '超级管理员', '普通管理员')); //管理员类型
    $content= replace($content, '{$SERVER_SOFTWARE$}', serverVariables('SERVER_SOFTWARE')); //服务器版本
    $content= replace($content, '{$SERVER_NAME$}', serverVariables('SERVER_NAME')); //服务器网址
    $content= replace($content, '{$LOCAL_ADDR$}', serverVariables('LOCAL_ADDR')); //服务器IP
    $content= replace($content, '{$SERVER_PORT$}', serverVariables('SERVER_PORT')); //服务器端口
    $content= replaceValueParam($content, 'mdbpath', @$_REQUEST['mdbpath']);
    $content= replaceValueParam($content, 'webDir', $GLOBALS['webDir']);

    //20160628
    if( inStr($content,'{$backupDatabaseSelectHtml$}')>0 ){
        $c=getDirTxtNameList($GLOBALS['adminDir'] . '/Data/BackUpDateBases/');
        $splstr=aspSplit($c,vbCrlf());
        foreach( $splstr as $key=>$s){
            $list=$list . '<option value="'. $s .'">'. $s .'</option>' . vbCrlf();
        }
        $content=replace($content,'{$backupDatabaseSelectHtml$}',$list);
    }

    //20160614
    if( EDITORTYPE=='php' ){
        $content= replace($content, '{$EDITORTYPE_PHP$}', 'php'); //给phpinc/用
    }
    $content= replace($content, '{$EDITORTYPE_PHP$}', ''); //给phpinc/用

    $replaceLableContent= $content;
    return @$replaceLableContent;
}

//文章列表旗
function displayFlags($flags){
    $c ='';
    //头条[h]
    if( inStr('|' . $flags . '|', '|h|') > 0 ){
        $c= $c . '头 ';
    }
    //推荐[c]
    if( inStr('|' . $flags . '|', '|c|') > 0 ){
        $c= $c . '推 ';
    }
    //幻灯[f]
    if( inStr('|' . $flags . '|', '|f|') > 0 ){
        $c= $c . '幻 ';
    }
    //特荐[a]
    if( inStr('|' . $flags . '|', '|a|') > 0 ){
        $c= $c . '特 ';
    }
    //滚动[s]
    if( inStr('|' . $flags . '|', '|s|') > 0 ){
        $c= $c . '滚 ';
    }
    //加粗[b]
    if( inStr('|' . $flags . '|', '|b|') > 0 ){
        $c= $c . '粗 ';
    }
    if( $c <> '' ){ $c= '[<font color="red">' . $c . '</font>]' ;}

    $displayFlags= $c;
    return @$displayFlags;
}


//栏目类别循环配置        showColumnList(parentid, "webcolumn", ,"",0, defaultStr,3,"")   nCount为深度值   thisPId为交点的id
function showColumnList( $parentid, $tableName, $showFieldName, $thisPId, $nCount, $action){
    $i=''; $s=''; $c=''; $selectcolumnname=''; $selStr=''; $url=''; $isFocus=''; $sql=''; $addSql='';$listLableStr='';$topnav='';
    $thisColumnName='';$navheaderStr='';$navfooterStr='';
    $parentid=aspTrim($parentid);
    $listLableStr='list';

    $topnav= getStrCut($action, '[topnav]', '[/topnav]', 2);
    $thisColumnName=getColumnName($parentid);
    //call echo(parentid,topnav)

    if( $parentid<>$topnav ){
        if( inStr($action,'[small-list')>0 ){
            $listLableStr='small-list';
        }
    }
    //call echo("listLableStr",listLableStr)

    $fieldNameList=''; $splFieldName=''; $k=''; $fieldName=''; $replaceStr=''; $startStr=''; $endStr=''; $topNumb=''; $modI='';$title='';
    $subHeaderStr=''; $subFooterStr='';$subHeaderStartStr='';$subHeaderEndStr='';$subFooterStartStr='';$subFooterEndStr='';


    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段列表');
    $splFieldName= aspSplit($fieldNameList, ',');
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' where parentid=' . $parentid;
    //  call echo("sql1111111111111",tableName)
    //处理追加SQL
    $startStr= '[sql-' . $nCount . ']' ; $endStr= '[/sql-' . $nCount . ']';
    if( inStr($action, $startStr)== false && inStr($action, $endStr)== false ){
        $startStr= '[sql]' ; $endStr= '[/sql]';
    }
    $addSql= getStrCut($action, $startStr, $endStr, 2);
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $rsObj=$GLOBALS['conn']->query( $sql . ' order by sortrank asc');
    //call echo(sql,rs.recordcount)
    for( $i= 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $startStr= '' ; $endStr= '';
            $selStr= '';
            $isFocus= false;
            if( cStr($rs['id'])== cStr($thisPId) ){
                $selStr= ' selected ';
                $isFocus= true;
            }
            //网址判断
            if( $isFocus== true ){
                $startStr= '['. $listLableStr .'-focus]' ; $endStr= '[/'. $listLableStr .'-focus]';
            }else{

                $startStr= '['. $listLableStr .'-' . $thisColumnName . ']' ; $endStr= '[/'. $listLableStr .'-' . $thisColumnName . ']';

                if( inStr($action, $startStr)== false && inStr($action,$endStr)==false ){
                    $startStr= '['. $listLableStr .'-' . $i . ']' ; $endStr= '[/'. $listLableStr .'-' . $i . ']';
                }else{
                    //call echo(rs("columnname"),startStr)
                }
            }

            //在最后时排序当前交点20160202
            if( $i== $topNumb && $isFocus== false ){
                $startStr= '['. $listLableStr .'-end]' ; $endStr= '[/'. $listLableStr .'-end]';
            }
            //例[list-mod2]  [/list-mod2]    20150112
            for( $modI= 6 ; $modI>= 2 ; $modI--){
                if( inStr($action, $startStr)== false && $i % $modI== 0 ){
                    $startStr= '['. $listLableStr .'-mod' . $modI . ']' ; $endStr= '[/'. $listLableStr .'-mod' . $modI . ']';
                    if( inStr($action, $startStr) > 0 ){
                        break;
                    }
                }
            }

            //没有则用默认
            if( inStr($action, $startStr)== false && inStr($action,$endStr)==false ){
                $startStr= '['. $listLableStr .']' ; $endStr= '[/'. $listLableStr .']';
            }
            //call rwend(action)
            //call echo(startStr,endStr)
            if( inStr($action, $startStr) > 0 && inStr($action, $endStr) > 0 ){
                $s= StrCut($action, $startStr, $endStr, 2);

                $s= replaceValueParam($s, 'id', $rs['id']);
                $s= replaceValueParam($s, 'selected', $selStr);
                $selectcolumnname= $rs[$showFieldName] ;$title=$selectcolumnname;
                if( $nCount >= 1 ){
                    $selectcolumnname= copyStr('&nbsp;&nbsp;', $nCount) . '├─' . $selectcolumnname;
                }
                $s= replaceValueParam($s, 'selectcolumnname', $selectcolumnname);
                $s= replaceValueParam($s, 'title', $title);


                for( $k= 0 ; $k<= uBound($splFieldName); $k++){
                    if( $splFieldName[$k] <> '' ){
                        $fieldName= $splFieldName[$k];
                        $replaceStr= $rs[$fieldName] . '';

                        $s= replaceValueParam($s, $fieldName, $replaceStr);
                    }
                }

                //url = WEB_VIEWURL & "?act=nav&columnName=" & rs(showFieldName)             '以栏目名称显示列表
                $url= WEB_VIEWURL . '?act=nav&id=' . $rs['id']; //以栏目ID显示列表



                //自定义网址
                if( aspTrim($rs['customaurl']) <> '' ){
                    $url= aspTrim($rs['customaurl']);
                }
                $s= replace($s, '[$viewWeb$]', $url);
                $s= replaceValueParam($s, 'url', $url);

                //网站栏目没有page位置处理 追加于20160716 home
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11);
                $s= handleDisplayOnlineEditDialog($url, $s, '', 'div|li|span'); //处理是否添加在线修改管理器


                if( EDITORTYPE== 'php' ){
                    $s= replace($s, '[$phpArray$]', '[]');
                }else{
                    $s= replace($s, '[$phpArray$]', '');
                }

                //s=copystr("",nCount) & rs("columnname") & "<hr>"
                if( $rs['parentid']=='-1' && inStr($action,'[navheader]')>0 ){
                    $navheaderStr= getStrCut($action, '[navheader]', '[/navheader]', 2);
                    $navfooterStr= getStrCut($action, '[navfooter]', '[/navfooter]', 2);
                    //call die(navfooterStr)
                }
                $c= $c . $navheaderStr . $s . vbCrlf();
                $s= showColumnList($rs['id'], $tableName, $showFieldName, $thisPId, $nCount + 1, $action) . $navfooterStr;


                $subHeaderStartStr='[subheader-'. $rs['columnname'] .']' ;$subHeaderEndStr='[/subheader-'. $rs['columnname'] .']';
                if( inStr($action,$subHeaderStartStr)==false && inStr($action,$subHeaderEndStr)==false ){
                    $subHeaderStartStr='[subheader]' ;$subHeaderEndStr='[/subheader]';

                }
                $subFooterStartStr='[subfooter-'. $rs['columnname'] .']' ; $subFooterEndStr='[/subfooter-'. $rs['columnname'] .']';
                if( inStr($action,$subFooterStartStr)==false && inStr($action,$subFooterStartStr)==false ){
                    $subFooterStartStr='[subfooter]' ;$subFooterEndStr='[/subfooter]';
                }
                $subHeaderStr= getStrCut($action, $subHeaderStartStr, $subHeaderEndStr, 2);
                $subFooterStr= getStrCut($action, $subFooterStartStr, $subFooterEndStr, 2);
                //call echo(rs("columnname"),"哈哈")

                if( $s <> '' ){ $s= vbCrlf() . $subHeaderStr . $s . $subFooterStr ;}
                $c= $c . $s;
            }
        }
    }
    $showColumnList= $c;
    return @$showColumnList;
}
//msg1  辅助
function getMsg1($msgStr, $url){
    $content ='';
    $content= getFText(ROOT_PATH . 'msg.html');
    $msgStr= $msgStr . '<br>' . jsTiming($url, 5);
    $content= replace($content, '[$msgStr$]', $msgStr);
    $content= replace($content, '[$url$]', $url);


    $content= replaceL($content, '提示信息');
    $content= replaceL($content, '如果您的浏览器没有自动跳转，请点击这里');
    $content= replaceL($content, '倒计时');


    $getMsg1= $content;
    return @$getMsg1;
}

//检测权力
function checkPower($powerName){
    if( @$_SESSION['adminId']<>'' ){
        $GLOBALS['conn=']=OpenConn();			//打开数据库 要不然在php报错，晕
        //这个做会很慢，测试时用
        $rssObj=$GLOBALS['conn']->query('select * from ' . $GLOBALS['db_PREFIX'] . 'admin where id=' . @$_SESSION['adminId']);
        if( @mysql_num_rows($rssObj)!=0 ){
            $rss=mysql_fetch_array($rssObj);
            @$_SESSION['adminflags']=$rss['flags'];
        }
        if( inStr('|' . @$_SESSION['adminflags'] . '|', '|' . $powerName . '|') > 0 || inStr('|' . @$_SESSION['adminflags'] . '|', '|*|') > 0 ){
            $checkPower= true;
        }else{
            $checkPower= false;
        }
    }else{
        $checkPower= true;
    }
    return @$checkPower;
}
//处理后台管理权限
function handlePower($powerName){
    if( checkPower($powerName)== false ){
        Eerr('提示', '你没有【' . $powerName . '】权限，<a href=\'javascript:history.go(-1);\'>点击返回</a>');
    }
}
//显示管理列表
function dispalyManage($actionName, $lableTitle, $nPageSize, $addSql){
    handlePower('显示' . $lableTitle); //管理权限处理
    loadWebConfig();
    $content=''; $i=''; $s=''; $c=''; $fieldNameList=''; $sql=''; $action ='';
    $x=''; $url=''; $nCount=''; $nPage ='';
    $idInputName ='';

    $tableName=''; $j=''; $splxx ='';
    $fieldName ='';//字段名称
    $splFieldName ='';//分割字段
    $searchfield=''; $keyWord ='';//搜索字段，搜索关键词
    $parentid ='';//栏目id

    $replaceStr ='';//替换字符
    $tableName= lCase($actionName); //表名称

    $searchfield= @$_REQUEST['searchfield']; //获得搜索字段值
    $keyWord= @$_REQUEST['keyword']; //获得搜索关键词值
    if( @$_POST['parentid'] <> '' ){
        $parentid= @$_POST['parentid'];
    }else{
        $parentid= @$_GET['parentid'];
    }

    $id ='';
    $focusid 						='';//是判断传过来的id是否在当前列表中是交点20160715 home
    $id= rq('id');
    $focusid= rq('focusid');

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段列表');

    $fieldNameList= specialStrReplace($fieldNameList); //特殊字符处理
    $splFieldName= aspSplit($fieldNameList, ','); //字段分割成数组

    //读模板
    $content= getTemplateContent('manage_' . $tableName . '.html');

    $action= getStrCut($content, '[list]', '[/list]', 2);
    //网站栏目单独处理      栏目不一样20160301
    if( $actionName== 'WebColumn' ){
        $action= getStrCut($content, '[action]', '[/action]', 1);
        $content= replace($content, $action, showColumnList( -1, 'WebColumn', 'columnname', '', 0, $action));
    }else if( $actionName== 'ListMenu' ){
        $action= getStrCut($content, '[action]', '[/action]', 1);
        $content= replace($content, $action, showColumnList( -1, 'listmenu', 'title', '', 0, $action));
    }else{
        if( $keyWord <> '' && $searchfield <> '' ){
            $addSql= getWhereAnd(' where ' . $searchfield . ' like \'%' . $keyWord . '%\' ', $addSql);
        }
        if( $parentid <> '' ){
            $addSql= getWhereAnd(' where parentid=' . $parentid . ' ', $addSql);
        }
        //call echo(tableName,addsql)
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' ' . $addSql;
        //检测SQL
        if( checkSql($sql)== false ){
            errorLog('出错提示：<br>action=' . $action . '<hr>sql=' . $sql . '<br>');
            return '';
        }
        $rsObj=$GLOBALS['conn']->query( $sql);

        $nCount= @mysql_num_rows($rsObj);
        $nPage= @$_REQUEST['page'];
        $content= replace($content, '[$pageInfo$]', webPageControl($nCount, $nPageSize, $nPage, $url, ''));
        $content= replace($content, '[$accessSql$]', $sql);

        if( EDITORTYPE== 'asp' ){
            $x= getRsPageNumber($rs, $nCount, $nPageSize, $nPage); //获得Rs页数                                                  '记录总数
        }else{
            if( $nPage <> '' ){
                $nPage= $nPage - 1;
            }
            $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' ' . $addSql . ' limit ' . $nPageSize * $nPage . ',' . $nPageSize;
            $rsObj=$GLOBALS['conn']->query( $sql);

            $x= @mysql_num_rows($rsObj);
        }
        for( $i= 1 ; $i<= $x; $i++){
            $rs=mysql_fetch_array($rsObj); //给PHP用，因为在 asptophp转换不完善  特殊
            $s= replace($action, '[$id$]', $rs['id']);
            for( $j= 0 ; $j<= uBound($splFieldName); $j++){
                if( $splFieldName[$j] <> '' ){
                    $splxx= aspSplit($splFieldName[$j] . '|||', '|');
                    $fieldName= $splxx[0];
                    $replaceStr= $rs[$fieldName] . '';
                    //对文章旗处理
                    if( $fieldName== 'flags' ){
                        $replaceStr= displayFlags($replaceStr);
                    }
                    //call echo("fieldname",fieldname)
                    //s = Replace(s, "[$" & fieldName & "$]", replaceStr)
                    $s= replaceValueParam($s, $fieldName, $replaceStr);

                }
            }

            $idInputName= 'id';
            $s= replace($s, '[$selectid$]', '<input type=\'checkbox\' name=\'' . $idInputName . '\' id=\'' . $idInputName . '\' value=\'' . $rs['id'] . '\' >');
            $s= replace($s, '[$phpArray$]', '');
            $url= '【NO】';
            if( $actionName== 'ArticleDetail' ){
                $url= WEB_VIEWURL . '?act=detail&id=' . $rs['id'];
            }else if( $actionName== 'OnePage' ){
                $url= WEB_VIEWURL . '?act=onepage&id=' . $rs['id'];
                //给评论加预览=文章  20160129
            }else if( $actionName== 'TableComment' ){
                $url= WEB_VIEWURL . '?act=detail&id=' . $rs['itemid'];
            }
            //必需有自定义字段
            if( inStr($fieldNameList, 'customaurl') > 0 ){
                //自定义网址
                if( aspTrim($rs['customaurl']) <> '' ){
                    $url= aspTrim($rs['customaurl']);
                }
            }
            $s= replace($s, '[$viewWeb$]', $url);
            $s= replaceValueParam($s, 'cfg_websiteurl', $GLOBALS['cfg_webSiteUrl']);
            //call echo(focusid & "/" & rs("id"),IIF(focusid=cstr(rs("id")),"true","false"))
            $s= replaceValueParam($s, 'focusid', $focusid);

            $c= $c . $s;




        }
        $content= replace($content, '[list]' . $action . '[/list]', $c);
        //表单提交处理，parentid(栏目ID) searchfield(搜索字段) keyword(关键词) addsql(排序)
        $url= '?page=[id]&addsql=' . @$_REQUEST['addsql'] . '&keyword=' . @$_REQUEST['keyword'] . '&searchfield=' . @$_REQUEST['searchfield'] . '&parentid=' . @$_REQUEST['parentid'];
        $url= getUrlAddToParam(getUrl(), $url, 'replace');
        //call echo("url",url)
        $content= replace($content, '[list]' . $action . '[/list]', $c);

    }

    if( inStr($content, '[$input_parentid$]') > 0 ){
        $action= '[list]<option value="[$id$]"[$selected$]>[$selectcolumnname$]</option>[/list]';
        $c= '<select name="parentid" id="parentid"><option value="">≡ 选择栏目 ≡</option>' . showColumnList( -1, 'webcolumn', 'columnname', $parentid, 0, $action) . vbCrlf() . '</select>';
        $content= replace($content, '[$input_parentid$]', $c); //上级栏目
    }

    $content= replaceValueParam($content, 'searchfield', @$_REQUEST['searchfield']); //搜索字段
    $content= replaceValueParam($content, 'keyword', @$_REQUEST['keyword']); //搜索关键词
    $content= replaceValueParam($content, 'nPageSize', @$_REQUEST['nPageSize']); //每页显示条数
    $content= replaceValueParam($content, 'addsql', @$_REQUEST['addsql']); //追加sql值条数
    $content= replaceValueParam($content, 'tableName', $tableName); //表名称
    $content= replaceValueParam($content, 'actionType', @$_REQUEST['actionType']); //动作类型
    $content= replaceValueParam($content, 'lableTitle', @$_REQUEST['lableTitle']); //动作标题
    $content= replaceValueParam($content, 'id', $id); //id
    $content= replaceValueParam($content, 'page', @$_REQUEST['page']); //页

    $content= replaceValueParam($content, 'parentid', @$_REQUEST['parentid']); //栏目id
    $content= replaceValueParam($content, 'focusid', $focusid);


    $url= getUrlAddToParam(getThisUrl(), '?parentid=&keyword=&searchfield=&page=', 'delete');

    $content= replaceValueParam($content, 'position', '系统管理 > <a href=\'' . $url . '\'>' . $lableTitle . '列表</a>'); //position位置


    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //asp与phh
    $content= replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL); //前端浏览网址
    $content= replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']);

    $content= $content . stat2016(true);

    $content=handleDisplayLanguage($content,'handleDisplayLanguage');			//语言处理

    Rw($content);
}

//添加修改界面
function addEditDisplay($actionName, $lableTitle, $fieldNameList){
    $content=''; $addOrEdit=''; $splxx=''; $i=''; $j=''; $s=''; $c=''; $tableName=''; $url=''; $aStr ='';
    $fieldName ='';//字段名称
    $splFieldName ='';//分割字段
    $fieldSetType ='';//字段设置类型
    $fieldValue ='';//字段值
    $sql ='';//sql语句
    $defaultList ='';//默认列表
    $flagsInputName ='';//旗input名称给ArticleDetail用
    $titlecolor ='';//标题颜色
    $flags ='';//旗
    $splStr=''; $fieldConfig=''; $defaultFieldValue=''; $postUrl ='';
    $subTableName=''; $subFileName ='';//子列表的表名称，子列表字段名称
    $templateListStr='';$listStr='';$listS='';$listC ='';

    $id ='';
    $id= rq('id');
    $addOrEdit= '添加';
    if( $id <> '' ){
        $addOrEdit= '修改';
    }

    if( inStr(',Admin,', ',' . $actionName . ',') > 0 && $id== @$_SESSION['adminId'] . '' ){
        handlePower('修改自身'); //管理权限处理
    }else{
        handlePower('显示' . $lableTitle); //管理权限处理
    }



    $fieldNameList= ',' . specialStrReplace($fieldNameList) . ','; //特殊字符处理 自定义字段列表
    $tableName= lCase($actionName); //表名称

    $systemFieldList ='';//表字段列表
    $systemFieldList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段配置列表');
    $splStr= aspSplit($systemFieldList, ',');


    //读模板
    $content= getTemplateContent('addEdit_' . $tableName . '.html');


    //关闭编辑器
    if( inStr($GLOBALS['cfg_flags'], '|iscloseeditor|') > 0 ){
        $s= getStrCut($content, '<!--#editor start#-->', '<!--#editor end#-->', 1);
        if( $s <> '' ){
            $content= replace($content, $s, '');
        }
    }

    //id=*  是给网站配置使用的，因为它没有管理列表，直接进入修改界面
    if( $id== '*' ){
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName;
    }else{
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id=' . $id;
    }
    if( $id <> '' ){
        $rsObj=$GLOBALS['conn']->query( $sql);
        if( @mysql_num_rows($rsObj)!=0 ){
            $rs=mysql_fetch_array($rsObj);
            $id= $rs['id'];
        }
        //标题颜色
        if( inStr($systemFieldList, ',titlecolor|') > 0 ){
            $titlecolor= $rs['titlecolor'];
        }
        //旗
        if( inStr($systemFieldList, ',flags|') > 0 ){
            $flags= $rs['flags'];
        }
    }

    if( inStr(',Admin,', ',' . $actionName . ',') > 0 ){
        //当修改超级管理员的时间，判断他是否有超级管理员权限
        if( $flags== '|*|' ){
            handlePower('*'); //管理权限处理
        }
        //对模板处理
        $templateListStr=getStrCut($content,'<!--template_list-->','<!--/template_list-->',2);
        $listStr=getStrCut($templateListStr,'<!--list-->','<!--/list-->',2);
        if( $listStr<>'' ){
            $rsxObj=$GLOBALS['conn']->query('select * from ' . $GLOBALS['db_PREFIX'] . 'ListMenu where parentId<>-1 order by sortrank asc');
            while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
                //call echo("",rsx("title"))
                $listS=getStrCut($content,'<!--list'. $rsx['title']. '-->','<!--/list'. $rsx['title']. '-->',2);
                if( $listS=='' ){
                    $listS=$listStr;
                }
                $listS=replace($listS,'[$title$]',$rsx['title']);
                $listS=replace($listS,'[$id$]',$rsx['id']);
                $listC=$listC . $listS . vbCrlf();
            }
        }
        if( $templateListStr<>'' ){
            $content=replace($content, '<!--template_list-->' . $templateListStr . '<!--/template_list-->',$listC);
        }


        if( $flags== '|*|' ||(@$_SESSION['adminId']== $id && @$_SESSION['adminflags']== '|*|' && $id <> '') ){
            $s= getStrCut($content, '<!--普通管理员-->', '<!--普通管理员end-->', 1);
            $content= replace($content, $s, '');
            $s= getStrCut($content, '<!--用户权限-->', '<!--用户权限end-->', 1);
            $content= replace($content, $s, '');

            //call echo("","1")
            //普通管理员权限选择列表
        }else if(($id <> '' || $addOrEdit== '添加') && @$_SESSION['adminflags']== '|*|' ){
            $s= getStrCut($content, '<!--超级管理员-->', '<!--超级管理员end-->', 1);
            $content= replace($content, $s, '');
            $s= getStrCut($content, '<!--用户权限-->', '<!--用户权限end-->', 1);
            $content= replace($content, $s, '');
            //call echo("","2")
        }else{
            $s= getStrCut($content, '<!--超级管理员-->', '<!--超级管理员end-->', 1);
            $content= replace($content, $s, '');
            $s= getStrCut($content, '<!--普通管理员-->', '<!--普通管理员end-->', 1);
            $content= replace($content, $s, '');
            //call echo("","3")
        }
    }
    foreach( $splStr as $key=>$fieldConfig){
        if( $fieldConfig <> '' ){
            $splxx= aspSplit($fieldConfig . '|||', '|');
            $fieldName= $splxx[0]; //字段名称
            $fieldSetType= $splxx[1]; //字段设置类型
            $defaultFieldValue= $splxx[2]; //默认字段值
            //用自定义
            if( inStr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig= mid($fieldNameList, inStr($fieldNameList, ',' . $fieldName . '|') + 1,-1);
                $fieldConfig= mid($fieldConfig, 1, inStr($fieldConfig, ',') - 1);
                $splxx= aspSplit($fieldConfig . '|||', '|');
                $fieldSetType= $splxx[1]; //字段设置类型
                $defaultFieldValue= $splxx[2]; //默认字段值
            }

            $fieldValue= $defaultFieldValue;
            if( $addOrEdit== '修改' ){
                $fieldValue= $rs[$fieldName];
            }
            //call echo(fieldConfig,fieldValue)

            //密码类型则显示为空
            if( $fieldSetType== 'password' ){
                $fieldValue= '';
            }
            if( $fieldValue <> '' ){
                $fieldValue= replace(replace($fieldValue, '"', '&quot;'), '<', '&lt;'); //在input里如果直接显示"的话就会出错了
            }
            if( inStr(',ArticleDetail,WebColumn,ListMenu,', ',' . $actionName . ',') > 0 && $fieldName== 'parentid' ){
                $defaultList= '[list]<option value="[$id$]"[$selected$]>[$selectcolumnname$]</option>[/list]';
                if( $addOrEdit== '添加' ){
                    $fieldValue= @$_REQUEST['parentid'];
                }
                $subTableName= 'webcolumn';
                $subFileName= 'columnname';
                if( $actionName== 'ListMenu' ){
                    $subTableName= 'listmenu';
                    $subFileName= 'title';
                }
                $c= '<select name="parentid" id="parentid"><option value="-1">≡ 作为一级栏目 ≡</option>' . showColumnList( -1, $subTableName, $subFileName, $fieldValue, 0, $defaultList) . vbCrlf() . '</select>';
                $content= replace($content, '[$input_parentid$]', $c); //上级栏目

            }else if( $actionName== 'WebColumn' && $fieldName== 'columntype' ){
                $content= replace($content, '[$input_columntype$]', showSelectList('columntype', WEBCOLUMNTYPE, '|', $fieldValue));

            }else if( inStr(',ArticleDetail,WebColumn,', ',' . $actionName . ',') > 0 && $fieldName== 'flags' ){
                $flagsInputName= 'flags';
                if( EDITORTYPE== 'php' ){
                    $flagsInputName= 'flags[]'; //因为PHP这样才代表数组
                }

                if( $actionName== 'ArticleDetail' ){
                    $s= inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|h|') > 0, 1, 0), 'h', '头条[h]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|c|') > 0, 1, 0), 'c', '推荐[c]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|f|') > 0, 1, 0), 'f', '幻灯[f]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|a|') > 0, 1, 0), 'a', '特荐[a]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|s|') > 0, 1, 0), 's', '滚动[s]');
                    $s= $s . replace(inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|b|') > 0, 1, 0), 'b', '加粗[b]'), '', '');
                    $s= replace($s, ' value=\'b\'>', ' onclick=\'input_font_bold()\' value=\'b\'>');


                }else if( $actionName== 'WebColumn' ){
                    $s= inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|top|') > 0, 1, 0), 'top', '顶部显示');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|foot|') > 0, 1, 0), 'foot', '底部显示');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|left|') > 0, 1, 0), 'left', '左边显示');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|center|') > 0, 1, 0), 'center', '中间显示');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|right|') > 0, 1, 0), 'right', '右边显示');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|other|') > 0, 1, 0), 'other', '其它位置显示');
                }
                $content= replace($content, '[$input_flags$]', $s);


            }else if( $fieldSetType== 'textarea1' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', ''));
            }else if( $fieldSetType== 'textarea2' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '300px', 'input-text', ''));
            }else if( $fieldSetType== 'textarea3' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '500px', 'input-text', ''));
            }else if( $fieldSetType== 'password' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', '<input name=\'' . $fieldName . '\' type=\'password\' id=\'' . $fieldName . '\' value=\'' . $fieldValue . '\' style=\'width:97%;\' class=\'input-text\'>');
            }else if( inStr($content,'[$textarea1_' . $fieldName . '$]')>0 ){
                $content= replace($content, '[$textarea1_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', ''));
            }else{
                //追加于20160717 home  等改进
                if( inStr($content, '[$textarea1_' . $fieldName . '$]')>0 ){
                    $content= replace($content, '[$textarea1_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', ''));
                }else if( inStr($content, '[$textarea2_' . $fieldName . '$]')>0 ){
                    $content= replace($content, '[$textarea2_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '300px', 'input-text', ''));
                }else if( inStr($content, '[$textarea3_' . $fieldName . '$]')>0 ){
                    $content= replace($content, '[$textarea3_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '500px', 'input-text', ''));

                }else{
                    $content= replace($content, '[$input_' . $fieldName . '$]', inputText2($fieldName, $fieldValue, '97%', 'input-text', ''));
                }
            }
            $content= replaceValueParam($content, $fieldName, $fieldValue);
        }
    }

    if( $id <> '' ){

    }
    //call die("")
    $content= replace($content, '[$switchId$]', @$_REQUEST['switchId']);


    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    $url= getUrlAddToParam($url, '?focusid=' . $id, 'replace');

    //call echo(getThisUrl(),url)
    if( inStr('|WebSite|', '|' . $actionName . '|')== false ){
        $aStr= '<a href=\'' . $url . '\'>' . $lableTitle . '列表</a> > ';
    }

    $content= replaceValueParam($content, 'position', '系统管理 > ' . $aStr . $addOrEdit . '信息');

    $content= replaceValueParam($content, 'searchfield', @$_REQUEST['searchfield']); //搜索字段
    $content= replaceValueParam($content, 'keyword', @$_REQUEST['keyword']); //搜索关键词
    $content= replaceValueParam($content, 'nPageSize', @$_REQUEST['nPageSize']); //每页显示条数
    $content= replaceValueParam($content, 'addsql', @$_REQUEST['addsql']); //追加sql值条数
    $content= replaceValueParam($content, 'tableName', $tableName); //表名称
    $content= replaceValueParam($content, 'actionType', @$_REQUEST['actionType']); //动作类型
    $content= replaceValueParam($content, 'lableTitle', @$_REQUEST['lableTitle']); //动作标题
    $content= replaceValueParam($content, 'id', $id); //id
    $content= replaceValueParam($content, 'page', @$_REQUEST['page']); //页

    $content= replaceValueParam($content, 'parentid', @$_REQUEST['parentid']); //栏目id


    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //asp与phh
    $content= replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL); //前端浏览网址
    $content= replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']);



    $postUrl= getUrlAddToParam(getThisUrl(), '?act=saveAddEditHandle&id=' . $id, 'replace');
    $content= replaceValueParam($content, 'postUrl', $postUrl);


    //20160113
    if( EDITORTYPE== 'asp' ){
        $content= replace($content, '[$phpArray$]', '');
    }else if( EDITORTYPE== 'php' ){
        $content= replace($content, '[$phpArray$]', '[]');
    }


    $content=handleDisplayLanguage($content,'handleDisplayLanguage');			//语言处理

    Rw($content);
}

//保存模块
function saveAddEdit($actionName, $lableTitle, $fieldNameList){
    $tableName=''; $url=''; $listUrl ='';
    $id=''; $addOrEdit=''; $sql ='';

    $id= @$_REQUEST['id'];
    $addOrEdit= IIF($id== '', '添加', '修改');

    handlePower($addOrEdit . $lableTitle); //管理权限处理


    $GLOBALS['conn=']=OpenConn();

    $fieldNameList= ',' . specialStrReplace($fieldNameList) . ','; //特殊字符处理 自定义字段列表
    $tableName= lCase($actionName); //表名称


    $sql= getPostSql($id, $tableName, $fieldNameList);
    //call eerr("sql",sql)												'调试用
    //检测SQL
    if( checkSql($sql)== false ){
        errorLog('出错提示：<hr>sql=' . $sql . '<br>');
        return '';
    }
    //conn.Execute(sql)                 '检测SQL时已经处理了，不需要再执行了
    //对网站配置单独处理，为动态运行时删除，index.html     动，静，切换20160216
    if( lCase($actionName)== 'website' ){
        if( inStr(@$_REQUEST['flags'], 'htmlrun')== false ){
            DeleteFile('../index.html');
        }
    }

    $listUrl= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    $listUrl= getUrlAddToParam($listUrl, '?focusid=' . $id, 'replace');

    //添加
    if( $id== '' ){

        $url= getUrlAddToParam(getThisUrl(), '?act=addEditHandle', 'replace');
        $url= getUrlAddToParam($url, '?focusid=' . $id, 'replace');

        Rw(getMsg1('数据添加成功，返回继续添加' . $lableTitle . '...<br><a href=\'' . $listUrl . '\'>返回' . $lableTitle . '列表</a>', $url));
    }else{
        $url= getUrlAddToParam(getThisUrl(), '?act=addEditHandle&switchId=' . @$_POST['switchId'], 'replace');
        $url= getUrlAddToParam($url, '?focusid=' . $id, 'replace');

        //没有返回列表管理设置
        if( inStr('|WebSite|', '|' . $actionName . '|') > 0 ){
            Rw(getMsg1('数据修改成功', $url));
        }else{
            Rw(getMsg1('数据修改成功，正在进入' . $lableTitle . '列表...<br><a href=\'' . $url . '\'>继续编辑</a>', $listUrl));
        }
    }
    writeSystemLog($tableName, $addOrEdit . $lableTitle); //系统日志
}

//删除
function del($actionName, $lableTitle){
    $tableName=''; $url ='';
    $tableName= lCase($actionName); //表名称
    $id ='';

    handlePower('删除' . $lableTitle); //管理权限处理


    $id= @$_REQUEST['id'];
    if( $id <> '' ){
        $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
        $GLOBALS['conn=']=OpenConn();


        //管理员
        if( $actionName== 'Admin' ){
            $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ') and flags=\'|*|\'');
            if( @mysql_num_rows($rsObj)!=0 ){
                $rs=mysql_fetch_array($rsObj);
                rwEnd(getMsg1('删除失败，系统管理员不可以删除，正在进入' . $lableTitle . '列表...', $url));
            }
        }
        connexecute('delete from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ')');
        Rw(getMsg1('删除' . $lableTitle . '成功，正在进入' . $lableTitle . '列表...', $url));
        //日志操作就不要再记录到日志表里了，要不然的话就复制了，没意义20160713
        if( $tableName<>'systemlog' ){
            writeSystemLog($tableName, '删除' . $lableTitle); //系统日志
        }
    }
}

//排序处理
function sortHandle($actionType){
    $splId=''; $splValue=''; $i=''; $id=''; $sortrank=''; $tableName=''; $url ='';
    $tableName= lCase($actionType); //表名称
    $splId= aspSplit(@$_REQUEST['id'], ',');
    $splValue= aspSplit(@$_REQUEST['value'], ',');
    for( $i= 0 ; $i<= uBound($splId); $i++){
        $id= $splId[$i];
        $sortrank= $splValue[$i];
        $sortrank= getNumber($sortrank . '');

        if( $sortrank== '' ){
            $sortrank= 0;
        }
        connexecute('update ' . $GLOBALS['db_PREFIX'] . $tableName . ' set sortrank=' . $sortrank . ' where id=' . $id);
    }
    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    Rw(getMsg1('更新排序完成，正在返回列表...', $url));

    writeSystemLog($tableName, '排序' . @$_REQUEST['lableTitle']); //系统日志
}

//更新字段
function updateField(){
    $tableName=''; $id=''; $fieldName=''; $fieldvalue=''; $fieldNameList=''; $url ='';
    $tableName= lCase(@$_REQUEST['actionType']); //表名称
    $id= @$_REQUEST['id']; //id
    $fieldName= lCase(@$_REQUEST['fieldname']); //字段名称
    $fieldvalue= @$_REQUEST['fieldvalue']; //字段值

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段列表');
    //call echo(fieldname,fieldvalue)
    //call echo("fieldNameList",fieldNameList)
    if( inStr($fieldNameList, ',' . $fieldName . ',')== false ){
        Eerr('出错提示', '表(' . $tableName . ')不存在字段(' . $fieldName . ')');
    }else{
        connexecute('update ' . $GLOBALS['db_PREFIX'] . $tableName . ' set ' . $fieldName . '=' . $fieldvalue . ' where id=' . $id);
    }

    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    Rw(getMsg1('操作成功，正在返回列表...', $url));

}

//保存robots.txt 20160118
function saveRobots(){
    $bodycontent=''; $url ='';
    handlePower('修改生成Robots'); //管理权限处理
    $bodycontent= @$_REQUEST['bodycontent'];
    createFile(ROOT_PATH . '/../robots.txt', $bodycontent);
    $url= '?act=displayLayout&templateFile=layout_makeRobots.html&lableTitle=生成Robots';
    Rw(getMsg1('保存Robots成功，正在进入Robots界面...', $url));

    writeSystemLog('', '保存Robots.txt'); //系统日志
}

//删除全部生成的html文件
function deleteAllMakeHtml(){
    $filePath ='';
    //栏目
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $filePath= getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']);
            if( right($filePath, 1)== '/' ){
                $filePath= $filePath . 'index.html';
            }
            aspEcho('栏目filePath', '<a href=\'' . $filePath . '\' target=\'_blank\'>' . $filePath . '</a>');
            DeleteFile($filePath);
        }
    }
    //文章
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $filePath= getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/detail' . $rsx['id']);
            if( right($filePath, 1)== '/' ){
                $filePath= $filePath . 'index.html';
            }
            aspEcho('文章filePath', '<a href=\'' . $filePath . '\' target=\'_blank\'>' . $filePath . '</a>');
            DeleteFile($filePath);
        }
    }
    //单页
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $filePath= getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/detail' . $rsx['id']);
            if( right($filePath, 1)== '/' ){
                $filePath= $filePath . 'index.html';
            }
            aspEcho('单页filePath', '<a href=\'' . $filePath . '\' target=\'_blank\'>' . $filePath . '</a>');
            DeleteFile($filePath);
        }
    }
}

//统计2016 stat2016(true)
function stat2016($isHide){
    $c ='';
    if( @$_COOKIE['tjB']== '' && GetIP() <> '127.0.0.1' ){ //屏蔽本地，引用之前代码20160122
        setCookie('tjB', '1', aspTime() + 3600);
        $c= $c . chr(60) . chr(115) . chr(99) . chr(114) . chr(105) . chr(112) . chr(116) . chr(32) . chr(115) . chr(114) . chr(99) . chr(61) . chr(34) . chr(104) . chr(116) . chr(116) . chr(112) . chr(58) . chr(47) . chr(47) . chr(106) . chr(115) . chr(46) . chr(117) . chr(115) . chr(101) . chr(114) . chr(115) . chr(46) . chr(53) . chr(49) . chr(46) . chr(108) . chr(97) . chr(47) . chr(52) . chr(53) . chr(51) . chr(50) . chr(57) . chr(51) . chr(49) . chr(46) . chr(106) . chr(115) . chr(34) . chr(62) . chr(60) . chr(47) . chr(115) . chr(99) . chr(114) . chr(105) . chr(112) . chr(116) . chr(62);
        if( $isHide== true ){
            $c= '<div style="display:none;">' . $c . '</div>';
        }
    }
    $stat2016= $c;
    return @$stat2016;
}
//获得官方信息
function getOfficialWebsite(){
    $s ='';
    if( @$_COOKIE['ASPPHPCMSGW']== '' ){
        $s= getHttpUrl(chr(104) . chr(116) . chr(116) . chr(112) . chr(58) . chr(47) . chr(47) . chr(115) . chr(104) . chr(97) . chr(114) . chr(101) . chr(109) . chr(98) . chr(119) . chr(101) . chr(98) . chr(46) . chr(99) . chr(111) . chr(109) . chr(47) . chr(97) . chr(115) . chr(112) . chr(112) . chr(104) . chr(112) . chr(99) . chr(109) . chr(115) . chr(47) . chr(97) . chr(115) . chr(112) . chr(112) . chr(104) . chr(112) . chr(99) . chr(109) . chr(115) . chr(46) . chr(97) . chr(115) . chr(112) . '?act=version&domain=' . escape(webDoMain()) . '&version=' . escape($GLOBALS['webVersion']) . '&language=' . $GLOBALS['language'], '');
        //用escape是因为PHP在使用时会出错20160408
        setCookie('ASPPHPCMSGW', $s, aspTime() + 3600);
    }else{
        $s=@$_COOKIE['ASPPHPCMSGW'];
    }
    $getOfficialWebsite= $s;
    //Call clearCookie("ASPPHPCMSGW")
    return @$getOfficialWebsite;
}

//更新网站统计 20160203
function updateWebsiteStat(){
    $content=''; $splStr=''; $splxx=''; $filePath=''; $fileName='';
    $url=''; $s=''; $nCount ='';
    handlePower('更新网站统计'); //管理权限处理
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat');						 //删除全部统计记录
    $content= getDirTxtList($GLOBALS['adminDir'] . '/data/stat/');
    $splStr= aspSplit($content, vbCrlf());
    $nCount= 1;
    foreach( $splStr as $key=>$filePath){
        $fileName=getFileName($filePath);
        if( $filePath <> '' && left($fileName,1)<>'#' ){
            $nCount=$nCount+1;
            aspEcho($nCount . '、filePath',$filePath);
            doEvents();
            $content= getFText($filePath);
            $content= replace($content, chr(0), '');
            whiteWebStat($content);

        }
    }
    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');

    Rw(getMsg1('更新全部统计成功，正在进入' . @$_REQUEST['lableTitle'] . '列表...', $url));
    writeSystemLog('', '更新网站统计'); //系统日志
}
//清除全部网站统计 20160329
function clearWebsiteStat(){
    $url ='';
    handlePower('清空网站统计'); //管理权限处理
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat');

    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');

    Rw(getMsg1('清空网站统计成功，正在进入' . @$_REQUEST['lableTitle'] . '列表...', $url));
    writeSystemLog('', '清空网站统计'); //系统日志
}
//更新今天网站统计
function updateTodayWebStat(){
    $content=''; $url='';$dateStr='';$dateMsg='';
    if( @$_REQUEST['date']<>'' ){
        $dateStr=now()+cint(@$_REQUEST['date']);
        $dateMsg='昨天';
    }else{
        $dateStr=now();
        $dateMsg='今天';
    }

    handlePower('更新'. $dateMsg . '统计'); //管理权限处理

    //call echo("datestr",datestr)
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat where dateclass=\'' . Format_Time($dateStr, 2) . '\'');
    $content= getFText($GLOBALS['adminDir'] . '/data/stat/' . Format_Time($dateStr, 2) . '.txt');
    whiteWebStat($content);
    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    Rw(getMsg1('更新'. $dateMsg .'统计成功，正在进入' . @$_REQUEST['lableTitle'] . '列表...', $url));
    writeSystemLog('', '更新网站统计'); //系统日志
}
//写入网站统计信息
function whiteWebStat($content){
    $splStr=''; $splxx=''; $filePath='';$nCount='';
    $url=''; $s=''; $visitUrl=''; $viewUrl=''; $viewdatetime=''; $ip=''; $browser=''; $operatingsystem=''; $cookie=''; $screenwh=''; $moreInfo=''; $ipList=''; $dateClass ='';
    $splxx= aspSplit($content, vbCrlf() . '-------------------------------------------------' . vbCrlf());
    $nCount=0;
    foreach( $splxx as $key=>$s){
        if( inStr($s, '当前：') > 0 ){
            $nCount=$nCount+1;
            $s= vbCrlf() . $s . vbCrlf();
            $dateClass= ADSql(getFileAttr($filePath, '3'));
            $visitUrl= ADSql(getStrCut($s, vbCrlf() . '来访', vbCrlf(), 0));
            $viewUrl= ADSql(getStrCut($s, vbCrlf() . '当前：', vbCrlf(), 0));
            $viewdatetime= ADSql(getStrCut($s, vbCrlf() . '时间：', vbCrlf(), 0));
            $ip= ADSql(getStrCut($s, vbCrlf() . 'IP:', vbCrlf(), 0));
            $browser= ADSql(getStrCut($s, vbCrlf() . 'browser: ', vbCrlf(), 0));
            $operatingsystem= ADSql(getStrCut($s, vbCrlf() . 'operatingsystem=', vbCrlf(), 0));
            $cookie= ADSql(getStrCut($s, vbCrlf() . 'Cookies=', vbCrlf(), 0));
            $screenwh= ADSql(getStrCut($s, vbCrlf() . 'Screen=', vbCrlf(), 0));
            $moreInfo= ADSql(getStrCut($s, vbCrlf() . '用户信息=', vbCrlf(), 0));
            $browser= ADSql(getBrType($moreInfo));
            if( inStr(vbCrlf() . $ipList . vbCrlf(), vbCrlf() . $ip . vbCrlf())== false ){
                $ipList= $ipList . $ip . vbCrlf();
            }

            $viewdatetime=replace($viewdatetime,'来访','00');
            if( isDate($viewdatetime)==false ){
                $viewdatetime='1988/07/12 10:10:10';
            }

            $screenwh= left($screenwh, 20);
            if( 1== 2 ){
                aspEcho('编号',$nCount);
                aspEcho('dateClass', $dateClass);
                aspEcho('visitUrl', $visitUrl);
                aspEcho('viewUrl', $viewUrl);
                aspEcho('viewdatetime', $viewdatetime);
                aspEcho('IP', $ip);
                aspEcho('browser', $browser);
                aspEcho('operatingsystem', $operatingsystem);
                aspEcho('cookie', $cookie);
                aspEcho('screenwh', $screenwh);
                aspEcho('moreInfo', $moreInfo);
                HR();
            }
            connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values(\'' . $visitUrl . '\',\'' . $viewUrl . '\',\'' . $browser . '\',\'' . $operatingsystem . '\',\'' . $screenwh . '\',\'' . $moreInfo . '\',\'' . $viewdatetime . '\',\'' . $ip . '\',\'' . $dateClass . '\')');
        }
    }
}

//详细网站统计
function websiteDetail(){
    $content=''; $splxx=''; $filePath ='';
    $s=''; $ip=''; $ipList ='';
    $nIP=''; $nPV=''; $i=''; $timeStr=''; $c ='';

    handlePower('网站统计详细'); //管理权限处理

    for( $i= 1 ; $i<= 30; $i++){
        $timeStr= getHandleDate(($i - 1) * - 1); //format_Time(Now() - i + 1, 2)
        $filePath= $GLOBALS['adminDir'] . '/data/stat/' . $timeStr . '.txt';
        $content= getFText($filePath);
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
        aspEcho($timeStr, 'IP(' . $nIP . ') PV(' . $nPV . ')');
        if( $i < 4 ){
            $c= $c . $timeStr . ' IP(' . $nIP . ') PV(' . $nPV . ')' . '<br>';
        }
    }

    setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $c, '#访客信息#');
    writeSystemLog('', '详细网站统计'); //系统日志

}

//显示指定布局
function displayLayout(){
    $content=''; $lableTitle=''; $templateFile ='';
    $lableTitle= @$_REQUEST['lableTitle'];
    $templateFile=@$_REQUEST['templateFile'];
    handlePower('显示' . $lableTitle); //管理权限处理

    $content= getTemplateContent(@$_REQUEST['templateFile']);
    $content= replace($content, '[$position$]', $lableTitle);
    $content= replaceValueParam($content, 'lableTitle', $lableTitle);


    //Robots.txt文件创建
    if( $templateFile=='layout_makeRobots.html' ){
        $content= replace($content, '[$bodycontent$]', getFText('/robots.txt'));
        //后台菜单地图
    }else if( $templateFile=='layout_adminMap.html' ){
        $content= replaceValueParam($content, 'adminmapbody', getAdminMap());
        //管理模板
    }else if( $templateFile=='layout_manageTemplates.html' ){
        $content= displayTemplatesList($content);
        //生成html
    }else if( $templateFile=='layout_manageMakeHtml.html' ){
        $content= replaceValueParam($content, 'columnList', getMakeColumnList());


    }


    $content=handleDisplayLanguage($content,'handleDisplayLanguage');			//语言处理
    Rw($content);
}
//获得生成栏目列表
function getMakeColumnList(){
    $c ='';
    //栏目
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $c= $c . '<option value="' . $rsx['id'] . '">' . $rsx['columnname'] . '</option>' . vbCrlf();
        }
    }
    $getMakeColumnList= $c;
    return @$getMakeColumnList;
}

//获得后台地图
function getAdminMap(){
    $s=''; $c=''; $url=''; $addSql ='';
    if( @$_SESSION['adminflags'] <> '|*|' ){
        $addSql= ' and isDisplay<>0 ';
    }
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=-1 ' . $addSql . ' order by sortrank');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $c= $c . '<div class="map-menu fl"><ul>' . vbCrlf();
        $c= $c . '<li class="title">' . $rs['title'] . '</li><div>' . vbCrlf();
        $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=' . $rs['id'] . ' ' . $addSql . '  order by sortrank');
        while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
            $url= PHPTrim($rsx['customaurl']);
            if( $rsx['lablename'] <> '' ){
                $url= $url . '&lableTitle=' . $rsx['lablename'];
            }
            $c= $c . '<li><a href="' . $url . '">' . $rsx['title'] . '</a></li>' . vbCrlf();
        }
        $c= $c . '</div></ul></div>' . vbCrlf();
    }
    $c= replaceLableContent($c);
    $getAdminMap= $c;
    return @$getAdminMap;
}

//获得后台一级菜单列表
function getAdminOneMenuList(){
    $c=''; $focusStr=''; $addSql=''; $sql ='';
    if( @$_SESSION['adminflags'] <> '|*|' ){
        $addSql= ' and isDisplay<>0 ';
    }
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=-1 ' . $addSql . ' order by sortrank';
    //检测SQL
    if( checkSql($sql)== false ){
        errorLog('出错提示：<br>function=getAdminOneMenuList<hr>sql=' . $sql . '<br>');
        return '';
    }
    $rsObj=$GLOBALS['conn']->query( $sql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $focusStr= '';
        if( $c== '' ){
            $focusStr= ' class="focus"';
        }
        $c= $c . '<li' . $focusStr . '>' . $rs['title'] . '</li>' . vbCrlf();
    }
    $c= replaceLableContent($c);
    $getAdminOneMenuList= $c;
    return @$getAdminOneMenuList;
}
//获得后台菜单列表
function getAdminMenuList(){
    $s=''; $c=''; $url=''; $selStr=''; $addSql=''; $sql ='';
    if( @$_SESSION['adminflags'] <> '|*|' ){
        $addSql= ' and isDisplay<>0 ';
    }
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=-1 ' . $addSql . ' order by sortrank';
    //检测SQL
    if( checkSql($sql)== false ){
        errorLog('出错提示：<br>function=getAdminMenuList<hr>sql=' . $sql . '<br>');
        return '';
    }
    $rsObj=$GLOBALS['conn']->query( $sql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $selStr= 'didoff';
        if( $c== '' ){
            $selStr= 'didon';
        }

        $c= $c . '<ul class="navwrap">' . vbCrlf();
        $c= $c . '<li class="' . $selStr . '">' . $rs['title'] . '</li>' . vbCrlf();


        $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=' . $rs['id'] . '  ' . $addSql . ' order by sortrank');
        while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
            $url= PHPTrim($rsx['customaurl']);
            $c= $c . ' <li class="item" onClick="window1(\'' . $url . '\',\'' . $rsx['lablename'] . '\');">' . $rsx['title'] . '</li>' . vbCrlf();

        }
        $c= $c . '</ul>' . vbCrlf();
    }
    $c= replaceLableContent($c);
    $getAdminMenuList= $c;
    return @$getAdminMenuList;
}
//处理模板列表
function displayTemplatesList($content){
    $templatesFolder=''; $templatePath=''; $templatePath2=''; $templateName=''; $defaultList=''; $folderList=''; $splStr=''; $s=''; $c ='';$s1='';$s2='';$s3='';
    $splTemplatesFolder ='';
    //加载网址配置
    loadWebConfig();

    $defaultList= getStrCut($content, '[list]', '[/list]', 2);
    $splTemplatesFolder= aspSplit('/Templates/|/Templates2015/|/Templates2016/', '|');
    foreach( $splTemplatesFolder as $key=>$templatesFolder){
        if( $templatesFolder <> '' ){
            $folderList= getDirFolderNameList($templatesFolder);
            $splStr= aspSplit($folderList, vbCrlf());
            foreach( $splStr as $key=>$templateName){
                if( $templateName <> '' && inStr('#_', left($templateName, 1))== false ){
                    $templatePath= $templatesFolder . $templateName;
                    $templatePath2= $templatePath;
                    $s= $defaultList;

                    $s1= getStrCut($content, '<!--启用 start-->', '<!--启用 end-->', 2);
                    $s2= getStrCut($content, '<!--恢复数据 start-->', '<!--恢复数据 end-->', 2);
                    $s3= getStrCut($content, '<!--删除模板 start-->', '<!--删除模板 end-->', 2);

                    if( lCase($GLOBALS['cfg_webtemplate'])== lCase($templatePath) ){
                        $templateName= '<font color=red>' . $templateName . '</font>';
                        $templatePath2= '<font color=red>' . $templatePath2 . '</font>';
                        $s= replace(replace($s, $s1, ''),$s3,'');
                    }else{
                        $s= replace($s,$s2,'');
                    }
                    $s= replaceValueParam($s, 'templatename', $templateName);
                    $s= replaceValueParam($s, 'templatepath', $templatePath);
                    $s= replaceValueParam($s, 'templatepath2', $templatePath2);
                    $c= $c . $s . vbCrlf();
                }
            }
        }
    }
    $content= replace($content, '[list]' . $defaultList . '[/list]', $c);
    $displayTemplatesList= $content;
    return @$displayTemplatesList;
}
//应用模板
function isOpenTemplate(){
    $templatePath=''; $templateName=''; $editValueStr=''; $url ='';

    handlePower('启用模板'); //管理权限处理

    $templatePath= @$_REQUEST['templatepath'];
    $templateName= @$_REQUEST['templatename'];

    if( getRecordCount($GLOBALS['db_PREFIX'] . 'website', '')== 0 ){
        connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website(webtitle) values(\'测试\')');
    }


    $editValueStr= 'webtemplate=\'' . $templatePath . '\',webimages=\'' . $templatePath . 'Images/\'';
    $editValueStr= $editValueStr . ',webcss=\'' . $templatePath . 'css/\',webjs=\'' . $templatePath . 'Js/\'';
    connexecute('update ' . $GLOBALS['db_PREFIX'] . 'website set ' . $editValueStr);
    $url= '?act=displayLayout&templateFile=layout_manageTemplates.html&lableTitle=模板';



    Rw(getMsg1('启用模板成功，正在进入模板界面...', $url));
    writeSystemLog('', '应用模板' . $templatePath); //系统日志
}
//删除模板
function delTemplate(){
    $templateDir='';$toTemplateDir='';$url='';
    $templateDir=replace(@$_REQUEST['templateDir'],'\\','/');
    handlePower('删除模板'); //管理权限处理
    $toTemplateDir= mid($templateDir,1,inStrRev($templateDir,'/')) . '#' . mid($templateDir,inStrRev($templateDir,'/')+1,-1) . '_' . Format_Time(now(),11);
    //call die(toTemplateDir)
    moveFolder($templateDir,$toTemplateDir);

    $url= '?act=displayLayout&templateFile=layout_manageTemplates.html&lableTitle=模板';
    Rw(getMsg1('删除模板完成，正在进入模板界面...', $url));
}
//执行SQL
function executeSQL(){
    $sqlvalue ='';
    $sqlvalue= 'delete from ' . $GLOBALS['db_PREFIX'] . 'WebSiteStat';
    if( @$_REQUEST['sqlvalue'] <> '' ){
        $sqlvalue= @$_REQUEST['sqlvalue'];
        $GLOBALS['conn=']=OpenConn();
        //检测SQL
        if( checkSql($sqlvalue)== false ){
            errorLog('出错提示：<br>sql=' . $sqlvalue . '<br>');
            return '';
        }
        aspEcho('执行SQL语句成功', $sqlvalue);
    }
    if( @$_SESSION['adminusername']== 'ASPPHPCMS' ){
        Rw('<form id="form1" name="form1" method="post" action="?act=executeSQL"  onSubmit="if(confirm(\'你确定要操作吗？\\n操作后将不可恢复\')){return true}else{return false}">SQL<input name="sqlvalue" type="text" id="sqlvalue" value="' . $sqlvalue . '" size="80%" /><input type="submit" name="button" id="button" value="执行" /></form>');
    }else{
        Rw('你没有权限执行SQL语句');
    }
}





?>