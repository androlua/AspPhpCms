<?php 
//ϵͳ
require_once './../phpInc/ASP.php';
require_once './../phpInc/sys_FSO.php';
require_once './../phpInc/Conn.php';
require_once './../phpInc/MySqlClass.php';
require_once './../phpInc/sys_System.php'; 



// �������ò���    http://127.0.0.1/php2/web/%E8%8E%B7%E5%BE%97inc%E5%BC%95%E7%94%A8%E5%86%85%E5%AE%B9.asp

//����
/*
*/
//����
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

define('ROOT_PATH', dirname(__FILE__).DIRECTORY_SEPARATOR); 		//��ǰ�ļ�·��
define('WEBCOLUMNTYPE','��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����'); 		//��վ��Ŀ�����б�
define('EDITORTYPE','php'); 		//�༭�����ͣ���ASP,��PHP,��jSP,��.NET

if(checkfile(ROOT_PATH.'../phpInc/admin_setAccess.php')){
	require_once './../phpInc/admin_setAccess.php'; 
}
require_once './../phpInc/admin_function.php';
//����ָ�����
function handleResetAccessData(){
	if(checkfile(ROOT_PATH.'../phpInc/admin_setAccess.php')==false){
		eerr("�ָ�Ĭ������ʧ��","../phpInc/admin_setAccess.php �ļ�������");
	}else{
		resetAccessData();
	}
} 
//=========
$db_PREFIX ='';
$db_PREFIX = 'xy_' ;//"& DB_PREFIX &"

$webVersion = 'v1.0011' ;
$cfg_webSiteUrl=''; $cfg_webTitle=''; $cfg_flags=''; $cfg_webtemplate ='';

//������ַ����
function loadWebConfig(){
    $GLOBALS['conn=']=OpenConn() ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'website');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $GLOBALS['cfg_webSiteUrl'] = $rs['websiteurl'] . '' ;//��ַ
        $GLOBALS['cfg_webTitle'] = $rs['webtitle'] . '' ;//��ַ����
        $GLOBALS['cfg_flags'] = $rs['flags'] . '' ;//��
        $GLOBALS['cfg_webtemplate'] = $rs['webtemplate'] . '' ;//ģ��·��
    }
}


//��¼�ж�
if( @$_SESSION['adminusername'] == '' ){
    if( @$_REQUEST['act'] <> '' && @$_REQUEST['act'] <> 'displayAdminLogin' && @$_REQUEST['act'] <> 'login' && @$_REQUEST['act'] <> 'resetAccessData' ){
        RR('?act=displayAdminLogin') ;
    }
}

//��ʾ��̨��¼
function displayAdminLogin(){
    //�Ѿ���¼��ֱ�ӽ����̨
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
//��¼��̨
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
        rw(getMsg1('�˺��������<br>�������' . $nLogin . '�ε�¼', '?act=displayAdminLogin')) ;
    }else{
        @$_SESSION['adminusername'] = $userName ;
        @$_SESSION['adminId'] = $rs['id'] ;//��ǰ��¼����ԱID
        @$_SESSION['DB_PREFIX'] = $GLOBALS['db_PREFIX'] ;//����ǰ׺
        $valueStr = 'addDateTime=\'' . $rs['updatetime'] . '\',UpDateTime=\'' . Now() . '\',RegIP=\'' . Now() . '\',UpIP=\'' . getIP() . '\'' ;
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'admin set ' . $valueStr . ' where id=' . $rs['id']) ;
        rw(getMsg1('��¼�ɹ������ڽ����̨...', '?act=adminIndex')) ;
    }

}
//�˳���¼
function adminOut(){
    @$_SESSION['adminusername'] = '' ;
    @$_SESSION['adminId'] = '' ;
    rw(getMsg1('�˳��ɹ������ڽ����¼����...', '?act=displayAdminLogin')) ;
}

//��̨��ҳ
function adminIndex(){
    loadWebConfig() ;
    $content ='';
    $content = getFText(ROOT_PATH . 'adminIndex.html') ;
    $content = Replace($content, '{$adminusername$}', @$_SESSION['adminusername']) ;
    $content = Replace($content, '{$frontView$}', "../index.php");
    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;


    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = Replace($content, '{$DB_PREFIX$}', $GLOBALS['db_PREFIX']) ;//��ǰ׺

    rw($content) ;
}
//========================================================

//��ʾ������
function dispalyManageHandle($actionType){
    $nPageSize=''; $lableTitle=''; $addSql ='';
    $nPageSize = @$_REQUEST['nPageSize'] ;
    if( $nPageSize == '' ){
        $nPageSize = 10 ;
    }
    $lableTitle = @$_REQUEST['lableTitle'] ;//��ǩ����
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

//����޸Ĵ���
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
        addEditDisplay($actionType, $lableTitle, 'sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2,actioncontent|textarea2') ;//||��վ����\|��������\|��������
    }else if( $actionType == 'WebModule' ){
        addEditDisplay($actionType, $lableTitle, 'sortrank|numb|0,simpleintroduction|textarea1,bodycontent|textarea2') ;

        //ElseIf actionType = "WebsiteStat" Then
        //Ĭ��������
    }else{
        addEditDisplay($actionType, $lableTitle, '') ;

    }
}
//����ģ�鴦��
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
    case 'dispalyManageHandle' ; dispalyManageHandle(@$_REQUEST['actionType']) ;break;//��ʾ������         ?act=dispalyManageHandle&actionType=WebLayout
    case 'addEditHandle' ; addEditHandle(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']);break;//����޸Ĵ���      ?act=addEditHandle&actionType=WebLayout
    case 'saveAddEditHandle' ; saveAddEditHandle(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']);break;//����ģ�鴦��  ?act=saveAddEditHandle&actionType=WebLayout
    case 'delHandle' ; del(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']) ;break;//ɾ������  ?act=delHandle&actionType=WebLayout
    case 'sortHandle' ; sortHandle(@$_REQUEST['actionType']) ;//������  ?act=sortHandle&actionType=WebLayout

    break;
    case 'displayLayout' ; displayLayout() ;break;//��ʾ����
    case 'saveRobots' ; saveRobots() ;break;//����robots.txt
    case 'saveSiteMap' ; saveSiteMap() ;break;//����sitemap.xml
    case 'isOpenTemplate' ; isOpenTemplate() ;break;//����ģ��
    case 'updateWebsiteStat' ; updateWebsiteStat() ;//������վͳ��


    break;
    case 'setAccess' ; handleResetAccessData() ;//�ָ�����
    break;
    case 'login' ; login() ;break;//��¼
    case 'adminOut' ; adminOut() ;break;//�˳���¼
    case 'adminIndex' ; adminIndex() ;break;//������ҳ
    default ; displayAdminLogin() ;//��ʾ��̨��¼
}

?>




