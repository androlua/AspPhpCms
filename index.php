<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-24
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By 云端 
************************************************************/
?>
<?php 


define('WEBPATH', $_SERVER ['DOCUMENT_ROOT'].DIRECTORY_SEPARATOR);				//网站主目录
 

//系统核心程序
require_once './phpInc/ASP.php';
require_once './phpInc/sys_FSO.php';
require_once './phpInc/sys_URL.php';
require_once './phpInc/sys_Cai.php';
require_once './phpInc/sys_System.php';
require_once './phpInc/Conn.php';
require_once './phpInc/MySqlClass.php';


//引用inc
require_once './phpInc/2014_Array.php';
require_once './phpInc/2014_Author.php';
require_once './phpInc/2014_Css.php';
require_once './phpInc/2014_Js.php';
require_once './phpInc/2014_Nav.php';
require_once './phpInc/2015_APGeneral.php';
require_once './phpInc/2015_Color.php';
require_once './phpInc/2015_Formatting.php';
require_once './phpInc/2015_Param.php';
require_once './phpInc/2015_ToMyPHP.php';
require_once './phpInc/2015_NewWebFunction.php';
require_once './phpInc/2016_SaveData.php'; 
require_once './phpInc/2016_WebControl.php'; 
require_once './phpInc/ASPPHPAccess.php'; 
//require_once './phpInc/2015_ToPhpCms.php';
require_once './phpInc/Cai.php';
require_once './phpInc/Check.php';
require_once './phpInc/Common.php';
require_once './phpInc/Config.php';
require_once './phpInc/Incpage.php';
require_once './phpInc/Print.php';
require_once './phpInc/StringNumber.php';
require_once './phpInc/Time.php';
require_once './phpInc/URL.php';;
require_once './phpInc/EncDec.php';
require_once './phpInc/IE.php';
require_once './phpInc/admin_setAccess.php';


//end 引用inc
$PubProDid='';$PubProSid='';$PubProTid='';
$PubNavDid='';$PubNavSid='';$PubNavTid='';
$ReadBlockList='';
$ModuleReplaceArray=''; //替换模块数组，暂时没用，但是要留着，要不出错了
 
define('WEBTEMPLATE',WEBPATH . '\\Templates2015\\test\\');						//模板路径
define('WEBIMAGES','http://127.0.0.1\\Templates2015\\test\\Images\\');			// 网站图片目录 用得着？


define('WEBURLPREFIX', '/webphp/');												//网站网址后缀，用得到吗？
$tempPath=$_SERVER['REQUEST_URI'];
$tempPath=mid($tempPath,strlen(WEBURLPREFIX)+1,-1);
define('WEBURLFILEPATH', $tempPath);											//缂冩垹鐝純鎴濇絻閺傚洣娆㈢捄顖氱窞 
define('EDITORTYPE','php'); 		//编辑器类型，是ASP,或PHP,或jSP,或.NET
define('WEB_ADMINURL','/admin/1.php'); 		//后端网站，在线编辑用到20160216
define('WEB_VIEWURL','/phpweb.php'); 		//网站显示URL

$adminDir='/admin/';				//后台目录

//=========

$db_PREFIX =''; $db_PREFIX = 'xy_' ;//表前缀


$cfg_webSiteUrl=''; $cfg_webTemplate=''; $cfg_webImages=''; $cfg_webCss=''; $cfg_webJs=''; $cfg_webTitle=''; $cfg_webKeywords=''; $cfg_webDescription=''; $cfg_webSiteBottom=''; $cfg_flags ='';
$gbl_columnName=''; $gbl_columnId=''; $gbl_id=''; $gbl_columnType=''; $gbl_columnENType=''; $gbl_table=''; $gbl_detailTitle=''; $gbl_flags ='';
$webTemplate ='';//网站模板路径
$gbl_url=''; $gbl_filePath ='';//当前链接网址,和文件路径
$gbl_isonhtml ='';//是否生成静态网页

$gbl_bodyContent ='';//主体内容
$gbl_artitleAuthor ='';//文章作者
$gbl_artitleAdddatetime ='';//文章添加时间
$gbl_upArticle ='';//上一篇文章
$gbl_downArticle ='';//下一篇文章
$gbl_aritcleRelatedTags ='';//文章标签组
$gbl_aritcleSmallImage=''; $gbl_aritcleBigImage ='';//文章小图与文章大图
$gbl_searchKeyWord ='';//搜索关键词

$isMakeHtml ='';//是否生成网页
//处理动作   ReplaceValueParam为控制字符显示方式
function handleAction($content){
    $startStr=''; $endStr=''; $ActionList=''; $splStr=''; $action=''; $s=''; $HandYes ='';
    $startStr = '{$' ; $endStr = '$}' ;
    $ActionList = GetArray($content, $startStr, $endStr, true, true) ;
    //Call echo("ActionList ", ActionList)
    $splStr = aspSplit($ActionList, '$Array$');
    foreach( $splStr as $s){
        $action = AspTrim($s) ;
        $action = HandleInModule($action, 'start') ;//处理\'替换掉
        if( $action <> '' ){
            $action = AspTrim(mid($action, 3, strlen($action) - 4)) . ' ' ;
            //call echo("s",s)
            $HandYes = true ;//处理为真
            //{VB #} 这种是放在图片路径里，目的是为了在VB里不处理这个路径
            if( CheckFunValue($action, '# ') == true ){
                $action = '' ;
                //测试
            }else if( CheckFunValue($action, 'GetLableValue ') == true ){
                $action = XY_getLableValue($action) ;

                //加载文件
            }else if( CheckFunValue($action, 'Include ') == true ){
                $action = XY_Include($action) ;

                //栏目列表
            }else if( CheckFunValue($action, 'ColumnList ') == true ){
                $action = XY_AP_ColumnList($action) ;

                //文章列表
            }else if( CheckFunValue($action, 'ArticleList ') == true ){
                $action = XY_AP_ArticleList($action) ;

                //评论列表
            }else if( CheckFunValue($action, 'CommentList ') == true ){
                $action = XY_AP_CommentList($action) ;

                //评论列表
            }else if( CheckFunValue($action, 'SearchStatList ') == true ){
                $action = XY_AP_SearchStatList($action) ;



                //显示单页内容
            }else if( CheckFunValue($action, 'MainInfo ') == true ){
                $action = XY_AP_SinglePage($action) ;

                //显示栏目内容
            }else if( CheckFunValue($action, 'GetColumnContent ') == true ){
                $action = XY_AP_GetColumnContent($action) ;


                //显示布局
            }else if( CheckFunValue($action, 'Layout ') == true ){
                $action = XY_Layout($action) ;
                //显示模块
            }else if( CheckFunValue($action, 'Module ') == true ){
                $action = XY_Module($action) ;
                //获得栏目URL
            }else if( CheckFunValue($action, 'GetColumnUrl ') == true ){
                $action = XY_GetColumnUrl($action) ;
                //获得单页URL
            }else if( CheckFunValue($action, 'GetOnePageUrl ') == true ){
                $action = XY_GetOnePageUrl($action) ;
                //显示包裹块
            }else if( CheckFunValue($action, 'DisplayWrap ') == true ){
                $action = XY_DisplayWrap($action) ;



                //读模板样式并设置标题与内容   软件里有个栏目Style进行设置
            }else if( CheckFunValue($action, 'ReadColumeSetTitle ') == true ){
                $action = XY_ReadColumeSetTitle($action) ;

                //显示编辑器
            }else if( CheckFunValue($action, 'displayEditor ') == true ){
                $action = displayEditor($action) ;

                //Js版网站统计
            }else if( CheckFunValue($action, 'JsWebStat ') == true ){
                $action = XY_JsWebStat($action) ;

                //------------------- 链接区 -----------------------
                //普通链接A
            }else if( CheckFunValue($action, 'HrefA ') == true ){
                $action = XY_HrefA($action) ;

                //暂时不屏蔽
            }else if( CheckFunValue($action, 'copyTemplateMaterial ') == true ){
                $action = '' ;
            }else if( CheckFunValue($action, 'clearCache ') == true ){
                $action = '' ;


            }else{
                $HandYes = false ;//处理为假
            }
            //注意这样，有的则不显示 晕 And IsNul(Action)=False
            if( isNul($action) == true ){ $action = '' ;}
            if( $HandYes == true ){
                $content = Replace($content, $s, $action) ;
            }
        }
    }
    $handleAction = $content ;
    return @$handleAction;
}

//替换全局变量 {$cfg_websiteurl$}
function replaceGlobleVariable( $content){
    $content = handleRGV($content, '{$cfg_webSiteUrl$}', $GLOBALS['cfg_webSiteUrl']) ;//网址
    $content = handleRGV($content, '{$cfg_webTemplate$}', $GLOBALS['cfg_webTemplate']) ;//模板
    $content = handleRGV($content, '{$cfg_webImages$}', $GLOBALS['cfg_webImages']) ;//图片路径
    $content = handleRGV($content, '{$cfg_webCss$}', $GLOBALS['cfg_webCss']) ;//css路径
    $content = handleRGV($content, '{$cfg_webJs$}', $GLOBALS['cfg_webJs']) ;//js路径
    $content = handleRGV($content, '{$cfg_webTitle$}', $GLOBALS['cfg_webTitle']) ;//网站标题
    $content = handleRGV($content, '{$cfg_webKeywords$}', $GLOBALS['cfg_webKeywords']) ;//网站关键词
    $content = handleRGV($content, '{$cfg_webDescription$}', $GLOBALS['cfg_webDescription']) ;//网站描述
    $content = handleRGV($content, '{$cfg_webSiteBottom$}', $GLOBALS['cfg_webSiteBottom']) ;//网站描述

    $content = handleRGV($content, '{$gbl_columnId$}', $GLOBALS['gbl_columnId']) ;//栏目Id
    $content = handleRGV($content, '{$gbl_columnName$}', $GLOBALS['gbl_columnName']) ;//栏目名称
    $content = handleRGV($content, '{$gbl_columnType$}', $GLOBALS['gbl_columnType']) ;//栏目类型
    $content = handleRGV($content, '{$gbl_columnENType$}', $GLOBALS['gbl_columnENType']) ;//栏目英文类型


    $content = handleRGV($content, '{$gbl_Table$}', $GLOBALS['gbl_table']) ;//表
    $content = handleRGV($content, '{$gbl_Id$}', $GLOBALS['gbl_id']) ;//id


    //兼容旧版本
    $content = handleRGV($content, '{$WebImages$}', $GLOBALS['cfg_webImages']) ;//图片路径
    $content = handleRGV($content, '{$WebCss$}', $GLOBALS['cfg_webCss']) ;//css路径
    $content = handleRGV($content, '{$WebJs$}', $GLOBALS['cfg_webJs']) ;//js路径

    $content = handleRGV($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = handleRGV($content, '{$Web_KeyWords$}', $GLOBALS['cfg_webKeywords']) ;
    $content = handleRGV($content, '{$Web_Description$}', $GLOBALS['cfg_webDescription']) ;
    $content = handleRGV($content, '{$EDITORTYPE$}', EDITORTYPE) ;//后缀
    $content = handleRGV($content, '{$WEB_VIEWURL$}', WEB_VIEWURL) ;//首页显示网址




    //文章用到
    $content = handleRGV($content, '{$gbl_artitleAuthor$}', $GLOBALS['gbl_artitleAuthor']) ;//文章作者
    $content = handleRGV($content, '{$gbl_artitleAdddatetime$}', $GLOBALS['gbl_artitleAdddatetime']) ;//文章添加时间
    $content = handleRGV($content, '{$gbl_upArticle$}', $GLOBALS['gbl_upArticle']) ;//上一篇文章
    $content = handleRGV($content, '{$gbl_downArticle$}', $GLOBALS['gbl_downArticle']) ;//下一篇文章
    $content = handleRGV($content, '{$gbl_aritcleRelatedTags$}', $GLOBALS['gbl_aritcleRelatedTags']) ;//文章标签组
    $content = handleRGV($content, '{$gbl_aritcleBigImage$}', $GLOBALS['gbl_aritcleBigImage']) ;//文章大图
    $content = handleRGV($content, '{$gbl_aritcleSmallImage$}', $GLOBALS['gbl_aritcleSmallImage']) ;//文章小图
    $content = handleRGV($content, '{$gbl_searchKeyWord$}', $GLOBALS['gbl_searchKeyWord']) ;//首页显示网址


    $replaceGlobleVariable = $content ;
    return @$replaceGlobleVariable;
}
//处理替换
function handleRGV( $content, $findStr, $replaceStr){
    $lableName ='';
    //对[$$]处理
    $lableName = mid($findStr, 3, strlen($findStr) - 4) . ' ' ;
    $lableName = mid($lableName, 1, instr($lableName, ' ') - 1) ;
    $content = replaceValueParam($content, $lableName, $replaceStr) ;
    $content = replaceValueParam($content, LCase($lableName), $replaceStr) ;
    //直接替换{$$}这种方式，兼容之前网站
    $content = Replace($content, $findStr, $replaceStr) ;
    $content = Replace($content, LCase($findStr), $replaceStr) ;
    $handleRGV = $content ;
    return @$handleRGV;
}
//加载网址配置
function loadWebConfig(){
    $templatedir ='';
    $GLOBALS['conn=']=OpenConn() ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'website');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $GLOBALS['cfg_webSiteUrl'] = phptrim($rs['websiteurl']) ;//网址
        $GLOBALS['cfg_webTemplate'] = phptrim($rs['webtemplate']) ;//模板路径
        $GLOBALS['cfg_webImages'] = phptrim($rs['webimages']) ;//图片路径
        $GLOBALS['cfg_webCss'] = phptrim($rs['webcss']) ;//css路径
        $GLOBALS['cfg_webJs'] = phptrim($rs['webjs']) ;//js路径
        $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//网址标题
        $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//网站关键词
        $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//网站描述
        $GLOBALS['cfg_webSiteBottom'] = $rs['websitebottom'] ;//网站地底
        $GLOBALS['cfg_flags'] = $rs['flags'] ;//旗

        //改换模板20160202
        if( @$_REQUEST['templatedir'] <> '' ){
            $templatedir = handlehttpurl(Replace(@$_REQUEST['templatedir'], handlePath('/'), '/')) ;
            $GLOBALS['cfg_webImages'] = Replace($GLOBALS['cfg_webImages'], $GLOBALS['cfg_webTemplate'], $templatedir) ;
            $GLOBALS['cfg_webCss'] = Replace($GLOBALS['cfg_webCss'], $GLOBALS['cfg_webTemplate'], $templatedir) ;
            $GLOBALS['cfg_webJs'] = Replace($GLOBALS['cfg_webJs'], $GLOBALS['cfg_webTemplate'], $templatedir) ;
            $GLOBALS['cfg_webTemplate'] = $templatedir ;
        }
        $GLOBALS['webTemplate'] = $GLOBALS['cfg_webTemplate'] ;
    }
}
//网站位置 待完善
function thisPosition($content){
    $c ='';
    $c = '<a href="/">首页</a>' ;
    if( $GLOBALS['gbl_columnName'] <> '' ){
        $c = $c . ' >> <a href="' . getColumnUrl($GLOBALS['gbl_columnName'], 'name') . '">' . $GLOBALS['gbl_columnName'] . '</a>' ;
    }
    $content = Replace($content, '[$detailPosition$]', $c) ;
    $content = Replace($content, '[$detailTitle$]', $GLOBALS['gbl_detailTitle']) ;
    $content = Replace($content, '[$detailContent$]', $GLOBALS['gbl_bodyContent']) ;

    $thisPosition = $content ;
    return @$thisPosition;
}

//显示管理列表
function getDetailList($action, $content, $actionName, $lableTitle, $fieldNameList, $nPageSize, $nPage, $addSql){
    $GLOBALS['conn=']=OpenConn() ;
    $defaultList=''; $i=''; $s=''; $c=''; $tableName=''; $j=''; $splxx=''; $k ='';
    $x=''; $url=''; $nCount ='';
    $idInputName=''; $pageInfo ='';

    $fieldName ='';//字段名称
    $splFieldName ='';//分割字段

    $replaceStr ='';//替换字符
    $tableName = LCase($actionName) ;//表名称
    $listFileName ='';//列表文件名称
    $listFileName = RParam($action, 'listFileName') ;

    $id ='';
    $id = rq('id') ;

    if( $fieldNameList == '*' ){
        $fieldNameList = LCase(getFieldList($GLOBALS['db_PREFIX'] . $tableName)) ;
    }

    $fieldNameList = specialStrReplace($fieldNameList) ;//特殊字符处理
    $splFieldName = aspSplit($fieldNameList, ',') ;//字段分割成数组

    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$actionName$}', $actionName) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$tableName$}', $tableName) ;



    $content = Replace($content, '{$nPageSize$}', $nPageSize) ;
    $content = Replace($content, '{$page$}', @$_REQUEST['page']) ;
    $content = Replace($content, '{$nPageSize' . $nPageSize . '$}', ' selected') ;
    for( $i = 1 ; $i<= 9; $i++){
        $content = Replace($content, '{$nPageSize' . $i . '0$}', '') ;
    }
    $defaultList = getStrCut($content, '[list]', '[/list]', 2) ;
    $pageInfo = getStrCut($content, '[page]', '[/page]', 1) ;
    if( $pageInfo <> '' ){
        $content = Replace($content, $pageInfo, '') ;
    }

    //call echo("pageInfo",pageInfo)


    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' ' . $addSql);
    $nCount = @mysql_num_rows($rsObj) ;
    //nPageSize = 10         '上面设定
    $GLOBALS['page'] = @$_REQUEST['page'] ;
    $url = getUrlAddToParam(getUrl(), '?page=[id]', 'replace') ;
    $content = Replace($content, '[$pageInfo$]', webPageControl($nCount, $nPageSize, $GLOBALS['page'], $url, $pageInfo)) ;
    if( $GLOBALS['page'] <> '' ){
        $GLOBALS['page'] = $GLOBALS['page'] - 1 ;
    }
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' ' . $addSql . ' limit ' . $nPageSize * $GLOBALS['page'] . ',' . $nPageSize . '');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $s = $defaultList ;
        for( $k = 1 ; $k<= 3; $k++){
            $s = Replace($s, '[$id$]', $rs['id']) ;
            $s = Replace($s, '[$phpArray$]', '') ;//替换为空  为要[]  因为我是通过js处理了
            for( $j = 0 ; $j<= UBound($splFieldName); $j++){
                if( $splFieldName[$j] <> '' ){
                    $splxx = aspSplit($splFieldName[$j] . '|||', '|') ;
                    $fieldName = $splxx[0] ;
                    $replaceStr = $rs[$fieldName] . '' ;
                    $s = replaceValueParam($s, $fieldName, $replaceStr) ;//这种方式处理 加动作
                }

                if( $GLOBALS['isMakeHtml'] == true ){
                    $url = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
                }else{
                    $url = handleWebUrl('?act=detail&id=' . $rs['id']) ;
                }
                $s = replaceValueParam($s, 'url', $url) ;
            }
        }
        //文章列表加在线编辑
        $url = '/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
        $s = HandleDisplayOnlineEditDialog($url, $s, '', 'div|li|span') ;

        $c = $c . $s ;
    }
    $content = Replace($content, '[list]' . $defaultList . '[/list]', $c) ;

    $getDetailList = $content ;
    return @$getDetailList;
}

//****************************************************
//默认列表模板
function defaultListTemplate(){
    $c=''; $templateHtml=''; $listTemplate=''; $lableName=''; $startStr=''; $endStr ='';

    $templateHtml = getFText($GLOBALS['cfg_webTemplate'] . '/' . $GLOBALS['templateName']) ;

    $lableName = 'list' ;
    $startStr = '<!--#' . $lableName . ' start#-->' ;
    $endStr = '<!--#' . $lableName . ' end#-->' ;
    if( instr($templateHtml, $startStr) > 0 && instr($templateHtml, $endStr) > 0 ){
        $listTemplate = StrCut($templateHtml, $startStr, $endStr, 2) ;
    }else{
        $startStr = '<!--#' . $lableName ;
        $endStr = '#-->' ;
        if( instr($templateHtml, $startStr) > 0 && instr($templateHtml, $endStr) > 0 ){
            $listTemplate = StrCut($templateHtml, $startStr, $endStr, 2) ;
        }
    }
    if( $listTemplate == '' ){
        $c = '<ul class="list">' . vbCrlf() ;
        $c = $c . '[list]    <li><a href="[$url$]" target="[$target$]">[$title$]</a><span class="time">[$adddatetime format_time=\'7\'$]</span></li>' . vbCrlf() ;
        $c = $c . '[/list]' . vbCrlf() ;
        $c = $c . '</ul>' . vbCrlf() ;
        $c = $c . '<div class="clear10"></div>' . vbCrlf() ;
        $c = $c . '<div>[$pageInfo$]</div>' . vbCrlf() ;
        $listTemplate = $c ;
    }

    $defaultListTemplate = $listTemplate ;
    return @$defaultListTemplate;
}

//记录表前缀
if( @$_REQUEST['db_PREFIX'] <> '' ){
    $db_PREFIX = @$_REQUEST['db_PREFIX'] ;
}else if( @$_SESSION['db_PREFIX'] <> '' ){
    $db_PREFIX = @$_SESSION['db_PREFIX'] ;
}
//加载网址配置
loadWebConfig() ;
$isMakeHtml = false ;
if( @$_REQUEST['isMakeHtml'] == '1' || @$_REQUEST['isMakeHtml'] == 'true' ){
    $isMakeHtml = true ;
}
$templateName = @$_REQUEST['templateName'] ;//模板名称

//保存数据处理页
switch ( @$_REQUEST['dataact'] ){
    case 'articlecomment' ; SaveArticleComment() ; die() ;break;//保存文章评论
    case 'WebStat' ; WebStat($adminDir . '/Data/Stat/') ; die() ;//网站统计
}

//生成html
if( @$_REQUEST['act'] == 'makehtml' ){
    ASPEcho('makehtml', 'makehtml') ;
    $isMakeHtml = true ;
    makeWebHtml(' action actionType=\'' . @$_REQUEST['act'] . '\' columnName=\'' . @$_REQUEST['columnName'] . '\' id=\'' . @$_REQUEST['id'] . '\' ') ;
    createfile('index.html', $code) ;

    //复制Html到网站
}else if( @$_REQUEST['act'] == 'copyHtmlToWeb' ){
    copyHtmlToWeb() ;
    //全部生成
}else if( @$_REQUEST['act'] == 'makeallhtml' ){
    makeAllHtml('', '', '') ;

    //生成当前页面
}else if( @$_REQUEST['isMakeHtml'] <> '' && @$_REQUEST['isSave'] <> '' ){
    $isMakeHtml = true ;
    rw(makeWebHtml(' action actionType=\'' . @$_REQUEST['act'] . '\' columnName=\'' . @$_REQUEST['columnName'] . '\' columnType=\'' . @$_REQUEST['columnType'] . '\' id=\'' . @$_REQUEST['id'] . '\' npage=\'' . @$_REQUEST['page'] . '\' ')) ;
    $gbl_filePath = Replace($gbl_url, $cfg_webSiteUrl, '') ;
    if( substr($gbl_filePath, - 1) == '/' ){
        $gbl_filePath = $gbl_filePath . 'index.html' ;
    }else if( $gbl_filePath=='' && $gbl_columnType=='首页' ){
        $gbl_filePath = 'index.html' ;
    }
    //文件不为空  并且开启生成html
    if( $gbl_filePath <> '' && $gbl_isonhtml == true ){
        createDirFolder(getFileAttr($gbl_filePath, '1')) ;
        createfile($gbl_filePath, $code) ;
        if( @$_REQUEST['act'] == 'detail' ){
            connExecute('update ' . $db_PREFIX . 'ArticleDetail set ishtml=true where id=' . @$_REQUEST['id']) ;
        }else if( @$_REQUEST['act'] == 'nav' ){
            if( @$_REQUEST['id'] <> '' ){
                connExecute('update ' . $db_PREFIX . 'WebColumn set ishtml=true where id=' . @$_REQUEST['id']) ;
            }else{
                connExecute('update ' . $db_PREFIX . 'WebColumn set ishtml=true where columnname=\'' . @$_REQUEST['columnName'] . '\'') ;
            }
        }
        ASPEcho('生成文件路径', '<a href="' . $gbl_filePath . '" target=\'_blank\'>' . $gbl_filePath . '</a>') ;

        //新闻则批量生成 20160216
        if( $gbl_columnType == '新闻' ){
            makeAllHtml('', '', $gbl_columnId) ;
        }

    }

    //全部生成
}else if( @$_REQUEST['act'] == 'Search' ){
    rw(makeWebHtml('actionType=\'Search\' npage=\'1\' ')) ;
}else{
    if( LCase(@$_REQUEST['issave']) == '1' ){
        makeAllHtml(@$_REQUEST['columnType'], @$_REQUEST['columnName'], @$_REQUEST['columnId']) ;
    }else{
        rw(makeWebHtml(' action actionType=\'' . @$_REQUEST['act'] . '\' columnName=\'' . @$_REQUEST['columnName'] . '\' columnType=\'' . @$_REQUEST['columnType'] . '\' id=\'' . @$_REQUEST['id'] . '\' npage=\'' . @$_REQUEST['page'] . '\' ')) ;
    }
}





//http://127.0.0.1/aspweb.asp?act=nav&columnName=ASP
//http://127.0.0.1/aspweb.asp?act=detail&id=75
//生成html静态页
function makeWebHtml($action){
    $actionType=''; $npagesize=''; $npage=''; $url=''; $addSql ='';
    $actionType = RParam($action, 'actionType') ;
    $npage = RParam($action, 'npage') ;
    $npage = getnumber($npage) ;
    if( $npage == '' ){
        $npage = 1 ;
    }else{
        $npage = intval($npage) ;
    }
    //导航
    if( $actionType == 'nav' ){
        $GLOBALS['gbl_columnType'] = RParam($action, 'columnType') ;
        $GLOBALS['gbl_columnName'] = RParam($action, 'columnName') ;
        $GLOBALS['gbl_columnId'] = RParam($action, 'columnId') ;
        if( $GLOBALS['gbl_columnType'] <> '' ){
            $addSql = 'where columnType=\'' . $GLOBALS['gbl_columnType'] . '\'' ;
        }
        if( $GLOBALS['gbl_columnName'] <> '' ){
            $addSql = getWhereAnd($addSql, 'where columnName=\'' . $GLOBALS['gbl_columnName'] . '\'') ;
        }
        if( $GLOBALS['gbl_columnId'] <> '' ){
            $addSql = getWhereAnd($addSql, 'where columnId=\'' . $GLOBALS['gbl_columnId'] . '\'') ;
        }
        $rsObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn ' . $addSql);
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $GLOBALS['gbl_columnId'] = $rs['id'] ;
            $GLOBALS['gbl_columnName'] = $rs['columnname'] ;
            $GLOBALS['gbl_columnType'] = $rs['columntype'] ;
            $GLOBALS['gbl_bodyContent'] = $rs['bodycontent'] ;
            $GLOBALS['gbl_detailTitle'] = $GLOBALS['gbl_columnName'] ;
            $GLOBALS['gbl_flags'] = $rs['flags'] ;
            $npagesize = $rs['npagesize'] ;//每页显示条数
            $GLOBALS['gbl_isonhtml'] = $rs['isonhtml'] ;//是否生成静态网页

            if( $rs['webtitle'] <> '' ){
                $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//网址标题
            }
            if( $rs['webkeywords'] <> '' ){
                $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//网站关键词
            }
            if( $rs['webdescription'] <> '' ){
                $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//网站描述
            }
            if( $GLOBALS['templateName'] == '' ){
                if( AspTrim($rs['templatepath']) <> '' ){
                    $GLOBALS['templateName'] = $rs['templatepath'] ;
                }else if( $rs['columntype'] <> '首页' ){
                    $GLOBALS['templateName'] = getDateilTemplate($rs['id'], 'List') ;
                }
            }
        }
        $GLOBALS['gbl_columnENType'] = handleColumnType($GLOBALS['gbl_columnType']) ;
        $GLOBALS['gbl_url'] = getColumnUrl($GLOBALS['gbl_columnName'], 'name') ;

        //列表
        if( instr('|新闻|产品|下载|视频|', '|' . $GLOBALS['gbl_columnType'] . '|') > 0 ){
            $GLOBALS['gbl_bodyContent'] = getDetailList($action, defaultListTemplate(), 'ArticleDetail', '网站栏目', '*', $npagesize, $npage, 'where parentid=' . $GLOBALS['gbl_columnId'] . ' order by sortrank asc') ;
        }else if( $GLOBALS['gbl_columnType'] == '文本' ){
            //航行栏目加管理
            if( @$_REQUEST['gl'] == 'edit' ){
                $GLOBALS['gbl_bodyContent'] = '<span>' . $GLOBALS['gbl_bodyContent'] . '</span>' ;
            }
            $url = '/admin/1.asp?act=addEditHandle&actionType=WebColumn&lableTitle=网站栏目&nPageSize=10&page=&id=' . $GLOBALS['gbl_columnId'] . '&n=' . getRnd(11) ;
            $GLOBALS['gbl_bodyContent'] = HandleDisplayOnlineEditDialog($url, $GLOBALS['gbl_bodyContent'], '', 'span') ;

        }
        //细节
    }else if( $actionType == 'detail' ){
        $rsObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where id=' . RParam($action, 'id'));
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $GLOBALS['gbl_columnName'] = getColumnName($rs['parentid']) ;
            $GLOBALS['gbl_detailTitle'] = $rs['title'] ;
            $GLOBALS['gbl_flags'] = $rs['flags'] ;
            $GLOBALS['gbl_isonhtml'] = $rs['isonhtml'] ;//是否生成静态网页
            $GLOBALS['gbl_id'] = $rs['id'] ;//文章ID
            if( $GLOBALS['isMakeHtml'] == true ){
                $GLOBALS['gbl_url'] = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
            }else{
                $GLOBALS['gbl_url'] = handleWebUrl('?act=detail&id=' . $rs['id']) ;
            }

            if( $rs['webtitle'] <> '' ){
                $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//网址标题
            }
            if( $rs['webkeywords'] <> '' ){
                $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//网站关键词
            }
            if( $rs['webdescription'] <> '' ){
                $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//网站描述
            }

            $GLOBALS['gbl_artitleAuthor'] = $rs['author'] ;
            $GLOBALS['gbl_artitleAdddatetime'] = $rs['adddatetime'] ;
            $GLOBALS['gbl_upArticle'] = upArticle($rs['parentid'], 'sortrank', $rs['sortrank']) ;
            $GLOBALS['gbl_downArticle'] = downArticle($rs['parentid'], 'sortrank', $rs['sortrank']) ;
            $GLOBALS['gbl_aritcleRelatedTags'] = aritcleRelatedTags($rs['relatedtags']) ;
            $GLOBALS['gbl_aritcleSmallImage'] = $rs['smallimage'] ;
            $GLOBALS['gbl_aritcleBigImage'] = $rs['bigimage'] ;

            //文章内容
            //gbl_bodyContent = "<div class=""articleinfowrap"">[$articleinfowrap$]</div>" & rs("bodycontent") & "[$relatedtags$]<ul class=""updownarticlewrap"">[$updownArticle$]</ul>"
            //上一篇文章，下一篇文章
            //gbl_bodyContent = Replace(gbl_bodyContent, "[$updownArticle$]", upArticle(rs("parentid"), "sortrank", rs("sortrank")) & downArticle(rs("parentid"), "sortrank", rs("sortrank")))
            //gbl_bodyContent = Replace(gbl_bodyContent, "[$articleinfowrap$]", "来源：" & rs("author") & " &nbsp; 发布时间：" & format_Time(rs("adddatetime"), 1))
            //gbl_bodyContent = Replace(gbl_bodyContent, "[$relatedtags$]", aritcleRelatedTags(rs("relatedtags")))

            $GLOBALS['gbl_bodyContent'] = $rs['bodycontent'] ;

            //文章详细加控制
            if( @$_REQUEST['gl'] == 'edit' ){
                $GLOBALS['gbl_bodyContent'] = '<span>' . $GLOBALS['gbl_bodyContent'] . '</span>' ;
            }
            $url = '/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=' . RParam($action, 'id') . '&n=' . getRnd(11) ;
            $GLOBALS['gbl_bodyContent'] = HandleDisplayOnlineEditDialog($url, $GLOBALS['gbl_bodyContent'], '', 'span') ;

            if( $GLOBALS['templateName'] == '' ){
                if( AspTrim($rs['templatepath']) <> '' ){
                    $GLOBALS['templateName'] = $rs['templatepath'] ;
                }else{
                    $GLOBALS['templateName'] = getDateilTemplate($rs['parentid'], 'Detail') ;
                }
            }

        }

        //单页
    }else if( $actionType == 'onepage' ){
        $rsObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where id=' . RParam($action, 'id'));
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $GLOBALS['gbl_detailTitle'] = $rs['title'] ;
            $GLOBALS['gbl_isonhtml'] = $rs['isonhtml'] ;//是否生成静态网页
            if( $GLOBALS['isMakeHtml'] == true ){
                $GLOBALS['gbl_url'] = getRsUrl($rs['filename'], $rs['customaurl'], '/page/page' . $rs['id']) ;
            }else{
                $GLOBALS['gbl_url'] = handleWebUrl('?act=detail&id=' . $rs['id']) ;
            }

            if( $rs['webtitle'] <> '' ){
                $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//网址标题
            }
            if( $rs['webkeywords'] <> '' ){
                $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//网站关键词
            }
            if( $rs['webdescription'] <> '' ){
                $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//网站描述
            }
            //内容
            $GLOBALS['gbl_bodyContent'] = $rs['bodycontent'] ;


            //文章详细加控制
            if( @$_REQUEST['gl'] == 'edit' ){
                $GLOBALS['gbl_bodyContent'] = '<span>' . $GLOBALS['gbl_bodyContent'] . '</span>' ;
            }
            $url = '/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=分类信息&nPageSize=10&page=&parentid=&id=' . RParam($action, 'id') . '&n=' . getRnd(11) ;
            $GLOBALS['gbl_bodyContent'] = HandleDisplayOnlineEditDialog($url, $GLOBALS['gbl_bodyContent'], '', 'span') ;


            if( $GLOBALS['templateName'] == '' ){
                if( AspTrim($rs['templatepath']) <> '' ){
                    $GLOBALS['templateName'] = $rs['templatepath'] ;
                }else{
                    $GLOBALS['templateName'] = 'Main_Model.html' ;
                    //call echo(templateName,"templateName")
                }
            }

        }

        //搜索
    }else if( $actionType == 'Search' ){
        $GLOBALS['templateName'] = 'Main_Model.html' ;
        $GLOBALS['gbl_searchKeyWord'] = @$_REQUEST['wd'] ;
        $addSql = ' where title like \'%' . $GLOBALS['gbl_searchKeyWord'] . '%\'' ;
        $npagesize = 20 ;
        //call echo(npagesize, npage)
        $GLOBALS['gbl_bodyContent'] = getDetailList($action, defaultListTemplate(), 'ArticleDetail', '网站栏目', '*', $npagesize, $npage, $addSql) ;

        //加载等待
    }else if( $actionType == 'loading' ){
        rwend('页面正在加载中。。。') ;
    }
    //模板为空，则用默认首页模板
    if( $GLOBALS['templateName'] == '' ){
        $GLOBALS['templateName'] = 'Index_Model.html' ;//默认模板
    }
    //检测当前路径是否有模板
    if( instr($GLOBALS['templateName'], '/') == false ){
        $GLOBALS['templateName'] = $GLOBALS['cfg_webTemplate'] . '/' . $GLOBALS['templateName'] ;
    }
    //call echo("templateName",templateName)
    $GLOBALS['code'] = getftext($GLOBALS['templateName']) ;


    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//处理动作
    $GLOBALS['code'] = thisPosition($GLOBALS['code']) 														;//位置
    $GLOBALS['code'] = replaceGlobleVariable($GLOBALS['code']) ;//替换全局标签
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//处理动作	'再来一次，处理数据内容里动作

    $GLOBALS['code'] = thisPosition($GLOBALS['code']) 														;//位置
    $GLOBALS['code'] = replaceGlobleVariable($GLOBALS['code']) ;//替换全局标签
    $GLOBALS['code'] = delTemplateMyNote($GLOBALS['code']) ;//删除无用内容

    //格式化
    if( instr($GLOBALS['cfg_flags'], '|formattinghtml|') > 0 ){
        //code = HtmlFormatting(code)        '简单
        $GLOBALS['code'] = HandleHtmlFormatting($GLOBALS['code'], false, 0, '删除空行') ;//自定义
    }
    //闭合标签
    if( instr($GLOBALS['cfg_flags'], '|labelclose|') > 0 ){
        $GLOBALS['code'] = handleCloseHtml($GLOBALS['code'], true, '') ;//图片自动加alt  "|*|",
    }

    //在线编辑20160127
    if( Rq('gl') == 'edit' ){
        if( instr($GLOBALS['code'], '</head>') > 0 ){
            if( instr($GLOBALS['code'], 'jquery.Min.js') == false ){
                $GLOBALS['code'] = Replace($GLOBALS['code'], '</head>', '<script src="/Jquery/jquery.Min.js"></script></head>') ;
            }
            $GLOBALS['code'] = Replace($GLOBALS['code'], '</head>', '<script src="/Jquery/Callcontext_menu.js"></script></head>') ;
        }
        if( instr($GLOBALS['code'], '<body>') > 0 ){
            //Code = Replace(Code,"<body>", "<body onLoad=""ContextMenu.intializeContextMenu()"">")
        }
    }

    $makeWebHtml = $GLOBALS['code'] ;
    return @$makeWebHtml;
}
//获得默认细节模板页
function getDateilTemplate($parentid, $templateType){
    $templateName ='';
    $templateName = 'Main_Model.html' ;
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $parentid);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        //call echo("columntype",rsx("columntype"))
        if( $rsx['columntype'] == '新闻' ){
            //新闻细节页
            if( checkFile($GLOBALS['cfg_webTemplate'] . '/News_' . $templateType . '.html') == true ){
                $templateName = 'News_' . $templateType . '.html' ;
            }
        }else if( $rsx['columntype'] == '产品' ){
            //产品细节页
            if( checkFile($GLOBALS['cfg_webTemplate'] . '/Product_' . $templateType . '.html') == true ){
                $templateName = 'Product_' . $templateType . '.html' ;
            }
        }else if( $rsx['columntype'] == '下载' ){
            //下载细节页
            if( checkFile($GLOBALS['cfg_webTemplate'] . '/Down_' . $templateType . '.html') == true ){
                $templateName = 'Down_' . $templateType . '.html' ;
            }
        }else if( $rsx['columntype'] == '视频' ){
            //视频细节页
            if( checkFile($GLOBALS['cfg_webTemplate'] . '/Video_' . $templateType . '.html') == true ){
                $templateName = 'Video_' . $templateType . '.html' ;
            }
        }else if( $rsx['columntype'] == '文本' ){
            //视频细节页
            if( checkFile($GLOBALS['cfg_webTemplate'] . '/Page_' . $templateType . '.html') == true ){
                $templateName = 'Page_' . $templateType . '.html' ;
            }
        }
    }
    //call echo(templateType,templateName)
    $getDateilTemplate = $templateName ;

    return @$getDateilTemplate;
}

//生成全部html页面
function makeAllHtml($columnType, $columnName, $columnId){
    $action=''; $s=''; $i=''; $nPageSize=''; $nCountSize=''; $nPage=''; $addSql=''; $url ='';
    $GLOBALS['isMakeHtml'] = true ;
    //栏目
    ASPEcho('栏目', '') ;
    if( $columnType <> '' ){
        $addSql = 'where columnType=\'' . $columnType . '\'' ;
    }
    if( $columnName <> '' ){
        $addSql = getWhereAnd($addSql, 'where columnName=\'' . $columnName . '\'') ;
    }
    if( $columnId <> '' ){
        $addSql = getWhereAnd($addSql, 'where id=' . $columnId . '') ;
    }
    $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn ' . $addSql . ' order by sortrank asc');
    while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
        $GLOBALS['gbl_columnName'] = '' ;
        //开启生成html
        if( $rss['isonhtml'] == true ){
            if( $rss['columntype'] == '新闻' ){
                $nCountSize = getRecordCount($GLOBALS['db_PREFIX'] . 'articledetail', ' where parentid=' . $rss['id']) ;//记录数
                $nPageSize = $rss['npagesize'] ;
                $nPage = getPageNumb(intval($nCountSize), intval($nPageSize)) ;
                for( $i = 1 ; $i<= $nPage; $i++){
                    $url = getRsUrl($rss['filename'], $rss['customaurl'], '/nav' . $rss['id']) ;
                    $GLOBALS['gbl_filePath'] = Replace($url, $GLOBALS['cfg_webSiteUrl'], '') ;
                    if( substr($GLOBALS['gbl_filePath'], - 1) == '/' || $GLOBALS['gbl_filePath'] == '' ){
                        $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
                    }
                    //call echo("gbl_filePath",gbl_filePath)
                    $action = ' action actionType=\'nav\' columnName=\'' . $rss['columnname'] . '\' npage=\'' . $i . '\' listfilename=\'' . $GLOBALS['gbl_filePath'] . '\' ' ;
                    //call echo("action",action)
                    makeWebHtml($action) ;
                    if( $i > 1 ){
                        $GLOBALS['gbl_filePath'] = mid($GLOBALS['gbl_filePath'], 1, strlen($GLOBALS['gbl_filePath']) - 5) . $i . '.html' ;
                    }
                    $s = '<a href="' . $GLOBALS['gbl_filePath'] . '" target=\'_blank\'>' . $GLOBALS['gbl_filePath'] . '</a>(' . $rss['isonhtml'] . ')' ;
                    ASPEcho($action, $s) ;
                    if( $GLOBALS['gbl_filePath'] <> '' ){
                        createDirFolder(getFileAttr($GLOBALS['gbl_filePath'], '1')) ;
                        createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                    }
                    doevents() ;
                    $GLOBALS['templateName'] = '' ;//清空模板文件名称
                }
            }else{
                $action = ' action actionType=\'nav\' columnName=\'' . $rss['columnname'] . '\'' ;
                makeWebHtml($action) ;
                $GLOBALS['gbl_filePath'] = Replace(getColumnUrl($rss['columnname'], 'name'), $GLOBALS['cfg_webSiteUrl'], '') ;
                if( substr($GLOBALS['gbl_filePath'], - 1) == '/' ){
                    $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
                }
                $s = '<a href="' . $GLOBALS['gbl_filePath'] . '" target=\'_blank\'>' . $GLOBALS['gbl_filePath'] . '</a>(' . $rss['isonhtml'] . ')' ;
                ASPEcho($action, $s) ;
                if( $GLOBALS['gbl_filePath'] <> '' ){
                    createDirFolder(getFileAttr($GLOBALS['gbl_filePath'], '1')) ;
                    createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                }
                doevents() ;
                $GLOBALS['templateName'] = '' ;
            }
            connExecute('update ' . $GLOBALS['db_PREFIX'] . 'WebColumn set ishtml=true where id=' . $rss['id']) ;//更新导航为生成状态
        }
    }
    if( $addSql == '' ){
        //文章
        ASPEcho('文章', '') ;
        $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail order by sortrank asc');
        while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
            $GLOBALS['gbl_columnName'] = '' ;
            $action = ' action actionType=\'detail\' columnName=\'' . $rss['parentid'] . '\' id=\'' . $rss['id'] . '\'' ;
            //call echo("action",action)
            makeWebHtml($action) ;
            $GLOBALS['gbl_filePath'] = Replace($GLOBALS['gbl_url'], $GLOBALS['cfg_webSiteUrl'], '') ;
            if( substr($GLOBALS['gbl_filePath'], - 1) == '/' ){
                $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
            }
            $s = '<a href="' . $GLOBALS['gbl_filePath'] . '" target=\'_blank\'>' . $GLOBALS['gbl_filePath'] . '</a>(' . $rss['isonhtml'] . ')' ;
            ASPEcho($action, $s) ;
            //文件不为空  并且开启生成html
            if( $GLOBALS['gbl_filePath'] <> '' && $rss['isonhtml'] == true ){
                createDirFolder(getFileAttr($GLOBALS['gbl_filePath'], '1')) ;
                createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                connExecute('update ' . $GLOBALS['db_PREFIX'] . 'ArticleDetail set ishtml=true where id=' . $rss['id']) ;//更新文章为生成状态
            }
            $GLOBALS['templateName'] = '' ;//清空模板文件名称
        }

        //单页
        ASPEcho('单页', '') ;
        $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage order by sortrank asc');
        while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
            $GLOBALS['gbl_columnName'] = '' ;
            $action = ' action actionType=\'onepage\' id=\'' . $rss['id'] . '\'' ;
            //call echo("action",action)
            makeWebHtml($action) ;
            $GLOBALS['gbl_filePath'] = Replace($GLOBALS['gbl_url'], $GLOBALS['cfg_webSiteUrl'], '') ;
            if( substr($GLOBALS['gbl_filePath'], - 1) == '/' ){
                $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
            }
            $s = '<a href="' . $GLOBALS['gbl_filePath'] . '" target=\'_blank\'>' . $GLOBALS['gbl_filePath'] . '</a>(' . $rss['isonhtml'] . ')' ;
            ASPEcho($action, $s) ;
            //文件不为空  并且开启生成html
            if( $GLOBALS['gbl_filePath'] <> '' && $rss['isonhtml'] == true ){
                createDirFolder(getFileAttr($GLOBALS['gbl_filePath'], '1')) ;
                createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                connExecute('update ' . $GLOBALS['db_PREFIX'] . 'onepage set ishtml=true where id=' . $rss['id']) ;//更新单页为生成状态
            }
            $GLOBALS['templateName'] = '' ;//清空模板文件名称
        }

    }


}

//复制html到网站
function copyHtmlToWeb(){
    $webDir=''; $toFilePath=''; $filePath=''; $fileName=''; $fileList=''; $cssFileList=''; $splStr=''; $content=''; $s=''; $s1=''; $c=''; $webImages=''; $webCss=''; $webJs=''; $splJs ='';
    $GLOBALS['WebFolderName'] = $GLOBALS['cfg_webTemplate'] ;
    if( substr($GLOBALS['WebFolderName'], 0 , 1) == '/' ){
        $GLOBALS['WebFolderName'] = mid($GLOBALS['WebFolderName'], 2,-1) ;
    }
    if( substr($GLOBALS['WebFolderName'], - 1) == '/' ){
        $GLOBALS['WebFolderName'] = mid($GLOBALS['WebFolderName'], 1, strlen($GLOBALS['WebFolderName']) - 1) ;
    }
    if( instr($GLOBALS['WebFolderName'], '/') > 0 ){
        $GLOBALS['WebFolderName'] = mid($GLOBALS['WebFolderName'], instr($GLOBALS['WebFolderName'], '/') + 1,-1) ;
    }
    $webDir = '/htmladmin/' . $GLOBALS['WebFolderName'] . '/' ;
    deleteFolder($webDir) ;
    createDirFolder($webDir) ;
    $webImages = $webDir . 'Images/' ;
    $webCss = $webDir . 'Css/' ;
    $webJs = $webDir . 'Js/' ;
    copyFolder($GLOBALS['cfg_webImages'], $webImages) ;
    copyFolder($GLOBALS['cfg_webCss'], $webCss) ;
    createFolder($webJs) ;//创建Js文件夹


    //处理Js文件夹
    $splJs = aspSplit(getDirJsList($webJs), vbCrlf()) ;
    foreach( $splJs as $filePath){
        if( $filePath <> '' ){
            $toFilePath = $webJs . getFileName($filePath) ;
            ASPEcho('js', $filePath) ;
            moveFile($filePath, $toFilePath) ;
        }
    }
    //处理Css文件夹
    $splStr = aspSplit(getDirCssList($webCss), vbCrlf()) ;
    foreach( $splStr as $filePath){
        if( $filePath <> '' ){
            $content = getftext($filePath) ;
            $content = Replace($content, $GLOBALS['cfg_webImages'], '../images/') ;
            createfile($filePath, $content) ;
            ASPEcho('css', $GLOBALS['cfg_webImages']) ;
        }
    }

    $GLOBALS['isMakeHtml'] = true ;
    $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where isonhtml=true');
    while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
        $GLOBALS['gbl_filePath'] = Replace(getColumnUrl($rss['columnname'], 'name'), $GLOBALS['cfg_webSiteUrl'], '') ;
        if( substr($GLOBALS['gbl_filePath'], - 1) == '/' ){
            $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
        }
        if( substr($GLOBALS['gbl_filePath'], - 5) == '.html' ){
            $fileList = $fileList . $GLOBALS['gbl_filePath'] . vbCrlf() ;
            $fileName = Replace($GLOBALS['gbl_filePath'], '/', '_') ;
            $toFilePath = $webDir . $fileName ;
            copyfile($GLOBALS['gbl_filePath'], $toFilePath) ;
            ASPEcho('导航', $GLOBALS['gbl_filePath']) ;
        }
    }
    $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where isonhtml=true');
    while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
        $GLOBALS['gbl_url'] = getRsUrl($rss['filename'], $rss['customaurl'], '/html/detail' . $rss['id']) ;
        $GLOBALS['gbl_filePath'] = Replace($GLOBALS['gbl_url'], $GLOBALS['cfg_webSiteUrl'], '') ;
        if( substr($GLOBALS['gbl_filePath'], - 1) == '/' ){
            $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
        }
        if( substr($GLOBALS['gbl_filePath'], - 5) == '.html' ){
            $fileList = $fileList . $GLOBALS['gbl_filePath'] . vbCrlf() ;
            $fileName = Replace($GLOBALS['gbl_filePath'], '/', '_') ;
            $toFilePath = $webDir . $fileName ;
            copyfile($GLOBALS['gbl_filePath'], $toFilePath) ;
            ASPEcho('文章' . $rss['title'], $GLOBALS['gbl_filePath']) ;
        }
    }

    $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where isonhtml=true');
    while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
        $GLOBALS['gbl_url'] = getRsUrl($rss['filename'], $rss['customaurl'], '/page/page' . $rss['id']) ;
        $GLOBALS['gbl_filePath'] = Replace($GLOBALS['gbl_url'], $GLOBALS['cfg_webSiteUrl'], '') ;
        if( substr($GLOBALS['gbl_filePath'], - 1) == '/' ){
            $GLOBALS['gbl_filePath'] = $GLOBALS['gbl_filePath'] . 'index.html' ;
        }
        if( substr($GLOBALS['gbl_filePath'], - 5) == '.html' ){
            $fileList = $fileList . $GLOBALS['gbl_filePath'] . vbCrlf() ;
            $fileName = Replace($GLOBALS['gbl_filePath'], '/', '_') ;
            $toFilePath = $webDir . $fileName ;
            copyfile($GLOBALS['gbl_filePath'], $toFilePath) ;
            ASPEcho('单页' . $rss['title'], $GLOBALS['gbl_filePath']) ;
        }
    }
    //批量处理html文件列表
    $splStr = aspSplit($fileList, vbCrlf()) ;
    foreach( $splStr as $filePath){
        if( $filePath <> '' ){
            $filePath = $webDir . Replace($filePath, '/', '_') ;
            ASPEcho('filePath', $filePath) ;
            $content = getftext($filePath) ;
            $content = Replace($content, $GLOBALS['cfg_webSiteUrl'], '') ;//删除网址
            $content = Replace($content, $GLOBALS['cfg_webTemplate'], '') ;//删除模板路径
            foreach( $splStr as $s){
                $s1 = $s ;
                if( substr($s1, - 11) == '/index.html' ){
                    $s1 = substr($s1, 0 , strlen($s1) - 11) . '/' ;
                }
                $content = Replace($content, $s1, Replace($s, '/', '_')) ;
            }

            foreach( $splJs as $s){
                if( $s <> '' ){
                    $fileName = getFileName($s) ;
                    $content = Replace($content, 'Images/' . $fileName, 'js/' . $fileName) ;
                }
            }
            if( instr($content, '/Jquery/Jquery.Min.js') > 0 ){
                $content = Replace($content, '/Jquery/Jquery.Min.js', 'js/Jquery.Min.js') ;
                copyfile('/Jquery/Jquery.Min.js', $webJs . '/Jquery.Min.js') ;
            }
            createfile($filePath, $content) ;
        }
    }




    ASPEcho('webFolderName', $GLOBALS['WebFolderName']) ;
    makeHtmlWebToZip($webDir) ;
}
//使htmlWeb文件夹用php压缩
function makeHtmlWebToZip($webDir){
    $content=''; $splStr=''; $filePath=''; $c=''; $fileArray=''; $fileName=''; $fileType=''; $isTrue ='';
    $cleanFileList ='';//干净文件列表 为了删除翻页文件
    $content = GetFileFolderList($webDir, true, '全部', '', '全部文件夹', '', '') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    foreach( $splStr as $filePath){
        if( checkfolder($filePath) == false ){
            $fileArray = HandleFilePathArray($filePath) ;
            $fileName = LCase($fileArray[2]) ;
            $fileType = LCase($fileArray[4]) ;
            $fileName = remoteNumber($fileName) ;
            $isTrue = true ;

            if( instr('|' . $cleanFileList . '|', '|' . $fileName . '|') > 0 && $fileType == 'html' ){
                $isTrue = false ;
            }
            if( $isTrue == true ){
                //call echo(fileType,fileName)
                if( $c <> '' ){ $c = $c . '|' ;}
                $c = $c . Replace($filePath, HandlePath('/'), '') ;
                $cleanFileList = $cleanFileList . $fileName . '|' ;
            }
        }
    }
    rw($c) ;
    $c = $c . '|||||' ;
    createfile('htmladmin/1.txt', $c) ;
    ASPEcho('<hr>cccccccccccc', $c) ;
    //Call Echo("",XMLPost("http://127.0.0.1/7.asp", "content=" & escape(c)))
    ASPEcho('', XMLPost('http://127.0.0.1/myZIP.php?webFolderName=' . $GLOBALS['WebFolderName'], 'content=' . escape($c))) ;
    //call DeleteFile("htmladmin/1.txt")
}
?>




