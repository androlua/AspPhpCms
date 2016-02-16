<?php 
//系统
require_once './../phpInc/ASP.php';
require_once './../phpInc/sys_FSO.php';
require_once './../phpInc/Conn.php';
require_once './../phpInc/MySqlClass.php';
require_once './../phpInc/sys_System.php'; 



// 更新引用部分    http://127.0.0.1/php2/web/%E8%8E%B7%E5%BE%97inc%E5%BC%95%E7%94%A8%E5%86%85%E5%AE%B9.asp

//生成
/*
*/
//引用
require_once './../phpInc/2014_Array.php';
require_once './../phpInc/2014_Author.php';
require_once './../phpInc/2014_Css.php';
require_once './../phpInc/2014_Js.php';
require_once './../phpInc/2014_Nav.php';
require_once './../phpInc/2015_APGeneral.php';
require_once './../phpInc/2015_Color.php';
require_once './../phpInc/2015_Formatting.php';
require_once './../phpInc/2015_Param.php';
require_once './../phpInc/2015_ToMyPHP.php';
//require_once './phpInc/2015_ToPhpCms.php';
require_once './../phpInc/Cai.php';
require_once './../phpInc/Check.php';
require_once './../phpInc/Common.php';
require_once './../phpInc/Config.php';
require_once './../phpInc/Incpage.php';
require_once './../phpInc/Print.php';
require_once './../phpInc/StringNumber.php';
require_once './../phpInc/Time.php';
require_once './../phpInc/URL.php';
require_once './../phpInc/FunHTML.php'; 
require_once './../phpInc/2015_Editor.php'; 
require_once './../phpInc/2015_NewWebFunction.php'; 
require_once './../phpInc/ASPPHPAccess.php'; 
require_once './../phpInc/IE.php'; 


//                                                  http://127.0.0.1/web/1.php?act=displayAdminLogin

define('ROOT_PATH', dirname(__FILE__).DIRECTORY_SEPARATOR); 		//当前文件路径
define('WEBCOLUMNTYPE','首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单'); 		//网站栏目类型列表
define('EDITORTYPE','php'); 		//编辑器类型，是ASP,或PHP,或jSP,或.NET

if(checkfile(ROOT_PATH.'../phpInc/admin_setAccess.php')){
	require_once './../phpInc/admin_setAccess.php'; 
}
require_once './../phpInc/admin_function.php';
//处理恢复数据
function handleResetAccessData(){
	if(checkfile(ROOT_PATH.'../phpInc/admin_setAccess.php')==false){
		eerr("恢复默认数据失败","../phpInc/admin_setAccess.php 文件不存在");
	}else{
		resetAccessData();
	}
} 
//=========
$db_PREFIX ='';
$db_PREFIX = 'xy_' ;//"& DB_PREFIX &"

$webVersion = 'v1.0011' ;
$cfg_webSiteUrl=''; $cfg_webTitle=''; $cfg_flags=''; $cfg_webtemplate ='';

//加载网址配置
function loadWebConfig(){
    $GLOBALS['conn=']=OpenConn() ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'website');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $GLOBALS['cfg_webSiteUrl'] = $rs['websiteurl'] . '' ;//网址
        $GLOBALS['cfg_webTitle'] = $rs['webtitle'] . '' ;//网址标题
        $GLOBALS['cfg_flags'] = $rs['flags'] . '' ;//旗
        $GLOBALS['cfg_webtemplate'] = $rs['webtemplate'] . '' ;//模板路径
    }
}


//登录判断
if( @$_SESSION['adminusername'] == '' ){
    if( @$_REQUEST['act'] <> '' && @$_REQUEST['act'] <> 'displayAdminLogin' && @$_REQUEST['act'] <> 'login' && @$_REQUEST['act'] <> 'resetAccessData' ){
        RR('?act=displayAdminLogin') ;
    }
}

//显示后台登录
function displayAdminLogin(){
    //已经登录则直接进入后台
    if( @$_SESSION['adminusername'] <> '' ){
        adminIndex() ;
    }else{
        loadWebConfig() ;
        $content ='';
        $content = getFText(ROOT_PATH . 'login.html') ;
        $content = Replace($content, '{$webVersion$}', $GLOBALS['webVersion']) ;
        $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
        rw($content) ;
    }

}
//登录后台
function login(){
    $userName=''; $passWord=''; $valueStr ='';
    $userName = Replace(@$_POST['username'], '\'', '') ;
    $passWord = Replace(@$_POST['password'], '\'', '') ;
    $passWord = myMD5($passWord) ;
    $nLogin ='';
    $GLOBALS['conn=']=OpenConn() ;
    $rsObj=$GLOBALS['conn']->query( 'Select * From ' . $GLOBALS['db_PREFIX'] . 'admin Where username=\'' . $userName . '\' And pwd=\'' . $passWord . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        if( @$_COOKIE['nLogin'] == '' ){
            setCookie('nLogin', '1', Time() + 3600) ;
            $nLogin = @$_COOKIE['nLogin'] ;
        }else{
            $nLogin = @$_COOKIE['nLogin'] ;
            setCookie('nLogin', intval($nLogin) + 1, Time() + 3600) ;
        }
        rw(getMsg1('账号密码错误<br>这是你第' . $nLogin . '次登录', '?act=displayAdminLogin')) ;
    }else{
        @$_SESSION['adminusername'] = $userName ;
        @$_SESSION['adminId'] = $rs['id'] ;//当前登录管理员ID
        @$_SESSION['DB_PREFIX'] = $GLOBALS['db_PREFIX'] ;//保存前缀
        $valueStr = 'addDateTime=\'' . $rs['updatetime'] . '\',UpDateTime=\'' . Now() . '\',RegIP=\'' . Now() . '\',UpIP=\'' . getIP() . '\'' ;
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'admin set ' . $valueStr . ' where id=' . $rs['id']) ;
        rw(getMsg1('登录成功，正在进入后台...', '?act=adminIndex')) ;
    }

}
//退出登录
function adminOut(){
    @$_SESSION['adminusername'] = '' ;
    @$_SESSION['adminId'] = '' ;
    rw(getMsg1('退出成功，正在进入登录界面...', '?act=displayAdminLogin')) ;
}

//后台首页
function adminIndex(){
    loadWebConfig() ;
    $content ='';
    $content = getFText(ROOT_PATH . 'adminIndex.html') ;
    $content = Replace($content, '{$adminusername$}', @$_SESSION['adminusername']) ;
    $content = Replace($content, '{$frontView$}', "../index.php");
    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;


    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = Replace($content, '{$DB_PREFIX$}', $GLOBALS['db_PREFIX']) ;//表前缀

    rw($content) ;
}
//========================================================

//显示管理处理
function dispalyManageHandle($actionType){
    $nPageSize=''; $lableTitle=''; $addSql ='';
    $nPageSize = @$_REQUEST['nPageSize'] ;
    if( $nPageSize == '' ){
        $nPageSize = 10 ;
    }
    $lableTitle = @$_REQUEST['lableTitle'] ;//标签标题
    $addSql = 'order by sortrank asc' ;
    if( $actionType == 'Bidding' ){
        $addSql = 'order by nComputerSearch desc' ;
    }else if( instr('|TableComment|', '|' . $actionType . '|') > 0 ){
        $addSql = ' order by adddatetime desc' ;
    }else if( instr('|WebsiteStat|', '|' . $actionType . '|') > 0 ){
        $addSql = ' order by viewdatetime desc' ;
    }else if( instr('|Admin|', '|' . $actionType . '|') > 0 ){
        $addSql = '' ;
    }
    //call echo(labletitle,addsql)
    dispalyManage($actionType, $lableTitle, '*', $nPageSize, $addSql) ;
}

//添加修改处理
function addEditHandle($actionType, $lableTitle){
    if( $actionType == 'Admin' ){
        addEditDisplay($actionType, $lableTitle, '') ;
    }else if( $actionType == 'WebSite' ){
        addEditDisplay($actionType, $lableTitle, 'webdescription,websitebottom|textarea2') ;

    }else if( $actionType == 'ArticleDetail' ){
        addEditDisplay($actionType, $lableTitle, 'sortrank||0,simpleintroduction|textarea1,bodycontent|textarea2') ;
    }else if( $actionType == 'WebColumn' ){
        addEditDisplay($actionType, $lableTitle, 'npagesize|numb|10,sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2') ;
    }else if( $actionType == 'OnePage' ){
        addEditDisplay($actionType, $lableTitle, 'sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2') ;

    }else if( $actionType == 'TableComment' ){
        addEditDisplay($actionType, $lableTitle, 'reply|textarea2,bodycontent|textarea2') ;


    }else if( $actionType == 'WebLayout' ){
        addEditDisplay($actionType, $lableTitle, 'sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2,actioncontent|textarea2') ;//||网站公告\|关于我们\|新闻中心
    }else if( $actionType == 'WebModule' ){
        addEditDisplay($actionType, $lableTitle, 'sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2') ;

        //ElseIf actionType = "WebsiteStat" Then
        //默认用这种
    }else{
        addEditDisplay($actionType, $lableTitle, '') ;

    }
}
//保存模块处理
function saveAddEditHandle($actionType, $lableTitle){
    if( $actionType == 'Admin' ){
        saveAddEdit($actionType, $lableTitle, 'username,pseudonym,pwd|md5') ;
    }else if( $actionType == 'WebSite' ){
        saveAddEdit($actionType, $lableTitle, 'flags,websiteurl,webtemplate,webimages,webcss,webjs,webtitle,webkeywords,webdescription,websitebottom') ;
    }else if( $actionType == 'ArticleDetail' ){
        saveAddEdit($actionType, $lableTitle, 'relatedtags,labletitle,target,nofollow|numb|0,isonhtml|numb|0,parentid,title,foldername,filename,customaurl,smallimage,bigimage,author,sortrank||0,flags,webtitle,webkeywords,webdescription,bannerimage,simpleintroduction,bodycontent,titlecolor,noteinfo') ;
    }else if( $actionType == 'WebColumn' ){
        saveAddEdit($actionType, $lableTitle, 'npagesize|numb|10,labletitle,target,nofollow|numb|0,isonhtml|numb|0,columntype,parentid,columnname,columnenname,foldername,filename,customaurl,sortrank||0,webtitle,webkeywords,webdescription,showtitle,flags,simpleintroduction,bodycontent,noteinfo') ;
    }else if( $actionType == 'OnePage' ){
        saveAddEdit($actionType, $lableTitle, 'labletitle,target,nofollow|numb|0,isonhtml|numb|0,title,displaytitle,foldername,filename,customaurl,webtitle,webkeywords,webdescription,simpleintroduction,bodycontent,noteinfo') ;

    }else if( $actionType == 'TableComment' ){
        saveAddEdit($actionType, $lableTitle, 'through|numb|0,reply,bodycontent') ;

    }else if( $actionType == 'WebLayout' ){
        saveAddEdit($actionType, $lableTitle, 'layoutlist,layoutname,sortrank|numb,isdisplay|yesno,simpleintroduction,bodycontent,actioncontent,replacestyle') ;
    }else if( $actionType == 'WebModule' ){
        saveAddEdit($actionType, $lableTitle, 'modulename,moduletype,sortrank|numb,simpleintroduction,bodycontent') ;

    }else if( $actionType == 'WebsiteStat' ){
        saveAddEdit($actionType, $lableTitle, 'visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime|date,ip,dateclass,noteinfo') ;
    }
}





$conn=OpenConn() ;
switch ( @$_REQUEST['act'] ){
    case 'dispalyManageHandle' ; dispalyManageHandle(@$_REQUEST['actionType']) ;break;//显示管理处理         ?act=dispalyManageHandle&actionType=WebLayout
    case 'addEditHandle' ; addEditHandle(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']);break;//添加修改处理      ?act=addEditHandle&actionType=WebLayout
    case 'saveAddEditHandle' ; saveAddEditHandle(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']);break;//保存模块处理  ?act=saveAddEditHandle&actionType=WebLayout
    case 'delHandle' ; del(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']) ;break;//删除处理  ?act=delHandle&actionType=WebLayout
    case 'sortHandle' ; sortHandle(@$_REQUEST['actionType']) ;//排序处理  ?act=sortHandle&actionType=WebLayout

    break;
    case 'displayLayout' ; displayLayout() ;break;//显示布局
    case 'saveRobots' ; saveRobots() ;break;//保存robots.txt
    case 'saveSiteMap' ; saveSiteMap() ;break;//保存sitemap.xml
    case 'isOpenTemplate' ; isOpenTemplate() ;break;//更换模板
    case 'updateWebsiteStat' ; updateWebsiteStat() ;//更新网站统计


    break;
    case 'setAccess' ; handleResetAccessData() ;//恢复数据
    break;
    case 'login' ; login() ;break;//登录
    case 'adminOut' ; adminOut() ;break;//退出登录
    case 'adminIndex' ; adminIndex() ;break;//管理首页
    default ; displayAdminLogin() ;//显示后台登录
}

?>




