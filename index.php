<?php 

//绯荤�?
require_once './phpInc/ASP.php';
require_once './phpInc/sys_FSO.php';
require_once './phpInc/Conn.php';
require_once './phpInc/MySqlClass.php';

// 鏇存柊寮曠敤閮ㄥ�?   http://127.0.0.1/php2/admin/%E8%8E%B7%E5%BE%97inc%E5%BC%95%E7%94%A8%E5%86%85%E5%AE%B9.asp

//鐢熸�?
/*
require_once './phpInc/testInc/Common.php';
require_once './phpInc/testInc/StringNumber.php';
require_once './phpInc/testInc/Print.php';
require_once './phpInc/testInc/Time.php';
require_once './phpInc/testInc/2014_Array.php';
require_once './phpInc/testInc/Cai.php';
require_once './phpInc/testInc/Check.php';
require_once './phpInc/testInc/Incpage.php';
require_once './phpInc/testInc/2015_Param.php';
require_once './phpInc/testInc/2014_Action.php';
require_once './phpInc/testInc/2014_Author.php';
require_once './phpInc/testInc/2014_Class.php';
require_once './phpInc/testInc/2014_Css.php';
require_once './phpInc/testInc/2014_Js.php';
require_once './phpInc/testInc/2014_MainInfo.php';
require_once './phpInc/testInc/2014_Nav.php';
require_once './phpInc/testInc/2014_News.php';
require_once './phpInc/testInc/2014_Search.php';
require_once './phpInc/testInc/2014_SiteMap.php';
require_once './phpInc/testInc/2014_Template.php';
require_once './phpInc/testInc/2015_Color.php';
require_once './phpInc/testInc/2015_Formatting.php';
require_once './phpInc/testInc/Access.php';
require_once './phpInc/testInc/AjAx.php';
require_once './phpInc/testInc/AutoAdd.php';
require_once './phpInc/testInc/Check.php';
*/
//寮曠�?
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
require_once './phpInc/admin_setAccess.php';


//end 寮曠�?
$PubProDid='';$PubProSid='';$PubProTid='';
$PubNavDid='';$PubNavSid='';$PubNavTid='';
$ReadBlockList='';
$ModuleReplaceArray=''; //�滻ģ�����飬��ʱû�ã�����Ҫ���ţ�Ҫ��������

 


define('WEBPATH', $_SERVER ['DOCUMENT_ROOT'].DIRECTORY_SEPARATOR);				//褰撳墠鐩綍璺�?
define('WEBTEMPLATE',WEBPATH . '\\Templates2015\\test\\');						//缃戠珯妯℃澘鐩�?
define('WEBIMAGES','http://127.0.0.1\\Templates2015\\test\\Images\\');						//缃戠珯绱犳潗鐩�?


define('WEBURLPREFIX', '/webphp/');												//缃戠珯缃戝潃鍓嶇�?
$tempPath=$_SERVER['REQUEST_URI'];
$tempPath=mid($tempPath,strlen(WEBURLPREFIX)+1,-1);
define('WEBURLFILEPATH', $tempPath);											//缃戠珯缃戝潃鏂囦欢璺緞 
define('EDITORTYPE','php'); 		//�༭�����ͣ���ASP,��PHP,��jSP,��.NET


//=========

$db_PREFIX =''; $db_PREFIX = 'xy_' ;//��ǰ׺
//"& db_PREFIX &"


$cfg_webSiteUrl=''; $cfg_webTemplate=''; $cfg_webImages=''; $cfg_webCss=''; $cfg_webJs=''; $cfg_webTitle=''; $cfg_webKeywords=''; $cfg_webDescription=''; $cfg_webSiteBottom=''; $cfg_flags ='';
$gbl_columnName=''; $gbl_columnId=''; $gbl_id=''; $gbl_columnType=''; $gbl_columnENType=''; $gbl_table=''; $gbl_detailTitle=''; $gbl_flags ='';
$webTemplate ='';//��վģ��·��
$gbl_url=''; $gbl_filePath ='';//��ǰ������ַ,���ļ�·��
$gbl_isonhtml ='';//�Ƿ����ɾ�̬��ҳ

$gbl_bodyContent ='';//��������
$isMakeHtml ='';//�Ƿ�������ҳ
//������   ReplaceValueParamΪ�����ַ���ʾ��ʽ
function handleAction($content){
    $startStr=''; $endStr=''; $ActionList=''; $splStr=''; $action=''; $s=''; $HandYes ='';
    $startStr = '{$' ; $endStr = '$}' ;
    $ActionList = GetArray($content, $startStr, $endStr, true, true) ;
    //Call echo("ActionList ", ActionList)
    $splStr = aspSplit($ActionList, '$Array$') ;
    foreach( $splStr as $s){
        $action = AspTrim($s) ;
        $action = HandleInModule($action, 'start') ;//����\'�滻��
        if( $action <> '' ){
            $action = AspTrim(mid($action, 3, strlen($action) - 4)) . ' ' ;
            //call echo("",action)
            $HandYes = true ;//����Ϊ��
            //{VB #} �����Ƿ���ͼƬ·���Ŀ����Ϊ����VB�ﲻ�������·��
            if( CheckFunValue($action, '# ') == true ){
                $action = '' ;
                //����
            }else if( CheckFunValue($action, 'GetLableValue ') == true ){
                $action = XY_getLableValue($action) ;

                //�����ļ�
            }else if( CheckFunValue($action, 'Include ') == true ){
                $action = XY_Include($action) ;

                //�����б�
            }else if( CheckFunValue($action, 'CustomNavList ') == true ){
                $action = XY_PHP_NavList($action) ;

                //�����б�
            }else if( CheckFunValue($action, 'DetailList ') == true ){
                $action = XY_PHP_DetailList($action) ;

                //�����б�
            }else if( CheckFunValue($action, 'CommentList ') == true ){
                $action = XY_PHP_CommentList($action) ;



                //��ʾ��ҳ����
            }else if( CheckFunValue($action, 'MainInfo ') == true ){
                $action = XY_PHP_SinglePage($action) ;
                //��ʾ��Ŀ����
            }else if( CheckFunValue($action, 'GetColumnContent ') == true ){
                $action = XY_PHP_GetColumnContent($action) ;


                //��ʾ����
            }else if( CheckFunValue($action, 'Layout ') == true ){
                $action = XY_Layout($action) ;
                //��ʾģ��
            }else if( CheckFunValue($action, 'Module ') == true ){
                $action = XY_Module($action) ;
                //�����ĿURL
            }else if( CheckFunValue($action, 'GetColumnUrl ') == true ){
                $action = XY_GetColumnUrl($action) ;
                //��õ�ҳURL
            }else if( CheckFunValue($action, 'GetOnePageUrl ') == true ){
                $action = XY_GetOnePageUrl($action) ;
                //��ʾ������
            }else if( CheckFunValue($action, 'DisplayWrap ') == true ){
                $action = XY_DisplayWrap($action) ;



                //��ģ����ʽ�����ñ���������   ������и���ĿStyle��������
            }else if( CheckFunValue($action, 'ReadColumeSetTitle ') == true ){
                $action = XY_ReadColumeSetTitle($action) ;

                //��ʾ�༭��
            }else if( CheckFunValue($action, 'displayEditor ') == true ){
                $action = displayEditor($action) ;

                //Js����վͳ��
            }else if( CheckFunValue($action, 'JsWebStat ') == true ){
                $action = XY_JsWebStat($action) ;
                //����
            }else if( CheckFunValue($action, 'XorEnc ') == true ){
                $action = XorEnc(Now(), 31380) ;




                //��ʱ������
            }else if( CheckFunValue($action, 'copyTemplateMaterial ') == true ){
                $action = '' ;
            }else if( CheckFunValue($action, 'clearCache ') == true ){
                $action = '' ;


            }else{
                $HandYes = false ;//����Ϊ��
            }
            //ע���������е�����ʾ �� And IsNul(Action)=False
            if( isNul($action) == true ){ $action = '' ;}
            if( $HandYes == true ){
                $content = Replace($content, $s, $action) ;
            }
        }
    }
    $handleAction = $content ;
    return @$handleAction;
}
//��ʾ������20160127
function XY_DisplayWrap( $action){
    $content ='';
    $content = GetDefaultValue($action) ;
    $XY_DisplayWrap = $content ;
    return @$XY_DisplayWrap;
}
//�����ĿUrl20160126
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
//��õ�ҳUrl20160128
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
//��ñ�ǩ���� ����
function XY_getLableValue($action){
    $title=''; $content=''; $c ='';
    //call echo("Action",Action)
    $title = RParam($action, 'title') ;
    $content = RParam($action, 'content') ;
    $c = $c . 'title=' . GetContentRunStr($title) . '<hr>' ;
    $c = $c . 'content=' . GetContentRunStr($content) . '<hr>' ;
    $XY_getLableValue = $c ;
    ASPEcho('title', $title) ;
    $XY_getLableValue = '��title=����' . $title . '��' ;
    return @$XY_getLableValue;
}
//�滻ȫ�ֱ��� {$cfg_websiteurl$}
function replaceGlobleVariable( $content){
    $content = handleRGV($content, '[$cfg_webSiteUrl$]', $GLOBALS['cfg_webSiteUrl']) ;//��ַ
    $content = handleRGV($content, '[$cfg_webTemplate$]', $GLOBALS['cfg_webTemplate']) ;//ģ��
    $content = handleRGV($content, '[$cfg_webImages$]', $GLOBALS['cfg_webImages']) ;//ͼƬ·��
    $content = handleRGV($content, '[$cfg_webCss$]', $GLOBALS['cfg_webCss']) ;//css·��
    $content = handleRGV($content, '[$cfg_webJs$]', $GLOBALS['cfg_webJs']) ;//js·��
    $content = handleRGV($content, '[$cfg_webTitle$]', $GLOBALS['cfg_webTitle']) ;//��վ����
    $content = handleRGV($content, '[$cfg_webKeywords$]', $GLOBALS['cfg_webKeywords']) ;//��վ�ؼ���
    $content = handleRGV($content, '[$cfg_webDescription$]', $GLOBALS['cfg_webDescription']) ;//��վ����
    $content = handleRGV($content, '[$cfg_webSiteBottom$]', $GLOBALS['cfg_webSiteBottom']) ;//��վ����

    $content = handleRGV($content, '[$gbl_columnId$]', $GLOBALS['gbl_columnId']) ;//��ĿId
    $content = handleRGV($content, '[$gbl_columnName$]', $GLOBALS['gbl_columnName']) ;//��Ŀ����
    $content = handleRGV($content, '[$gbl_columnType$]', $GLOBALS['gbl_columnType']) ;//��Ŀ����
    $content = handleRGV($content, '[$gbl_columnENType$]', $GLOBALS['gbl_columnENType']) ;//��ĿӢ������


    $content = handleRGV($content, '[$gbl_Table$]', $GLOBALS['gbl_table']) ;//��
    $content = handleRGV($content, '[$gbl_Id$]', $GLOBALS['gbl_id']) ;//id


    //���ݾɰ汾
    $content = handleRGV($content, '[$WebImages$]', $GLOBALS['cfg_webImages']) ;//ͼƬ·��
    $content = handleRGV($content, '[$WebCss$]', $GLOBALS['cfg_webCss']) ;//css·��
    $content = handleRGV($content, '[$WebJs$]', $GLOBALS['cfg_webJs']) ;//js·��

    $content = handleRGV($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = handleRGV($content, '{$Web_KeyWords$}', $GLOBALS['cfg_webKeywords']) ;
    $content = handleRGV($content, '{$Web_Description$}', $GLOBALS['cfg_webDescription']) ;
    $content = handleRGV($content, '{$EDITORTYPE$}', EDITORTYPE) ;//��׺


    $replaceGlobleVariable = $content ;
    return @$replaceGlobleVariable;
}
//�����滻
function handleRGV( $content, $findStr, $replaceStr){
    $content = Replace($content, $findStr, $replaceStr) ;
    $content = Replace($content, LCase($findStr), $replaceStr) ;
    //���ݴ���20160129
    if( instr($findStr, '{') > 0 ){
        $findStr = Replace(Replace($findStr, '{', '['), '}', ']') ;
    }else{
        $findStr = Replace(Replace($findStr, '[', '{'), ']', '}') ;
    }
    $content = Replace($content, $findStr, $replaceStr) ;
    $content = Replace($content, LCase($findStr), $replaceStr) ;
    $handleRGV = $content ;
    return @$handleRGV;
}
//������ַ����
function loadWebConfig(){
    $templatedir ='';
    $GLOBALS['conn=']=OpenConn() ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'website');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $GLOBALS['cfg_webSiteUrl'] = phptrim($rs['websiteurl']) ;//��ַ
        $GLOBALS['cfg_webTemplate'] = phptrim($rs['webtemplate']) ;//ģ��·��
        $GLOBALS['cfg_webImages'] = phptrim($rs['webimages']) ;//ͼƬ·��
        $GLOBALS['cfg_webCss'] = phptrim($rs['webcss']) ;//css·��
        $GLOBALS['cfg_webJs'] = phptrim($rs['webjs']) ;//js·��
        $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//��ַ����
        $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//��վ�ؼ���
        $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//��վ����
        $GLOBALS['cfg_webSiteBottom'] = $rs['websitebottom'] ;//��վ�ص�
        $GLOBALS['cfg_flags'] = $rs['flags'] ;//��

        //�Ļ�ģ��20160202
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
//��վλ�� ������
function thisPosition($content){
    $c ='';
    $c = '<a href="/">��ҳ</a>' ;
    if( $GLOBALS['gbl_columnName'] <> '' ){
        $c = $c . ' >> <a href="' . getColumnUrl($GLOBALS['gbl_columnName'], 'name') . '">' . $GLOBALS['gbl_columnName'] . '</a>' ;
    }
    $content = Replace($content, '[$detailPosition$]', $c) ;
    $content = Replace($content, '[$detailTitle$]', $GLOBALS['gbl_detailTitle']) ;
    $content = Replace($content, '[$detailContent$]', $GLOBALS['gbl_bodyContent']) ;

    $thisPosition = $content ;
    return @$thisPosition;
}

//��ʾ�����б�
function getDetailList($action, $content, $actionName, $lableTitle, $fieldNameList, $nPageSize, $nPage, $addSql){
    $GLOBALS['conn=']=OpenConn() ;
    $defaultList=''; $i=''; $s=''; $c=''; $tableName=''; $j=''; $splxx=''; $k ='';
    $x=''; $url=''; $nCount ='';
    $idInputName ='';

    $fieldName ='';//�ֶ�����
    $splFieldName ='';//�ָ��ֶ�

    $replaceStr ='';//�滻�ַ�
    $tableName = LCase($actionName) ;//������
    $listFileName ='';//�б��ļ�����
    $listFileName = RParam($action, 'listFileName') ;

    $id ='';
    $id = rq('id') ;

    if( $fieldNameList == '*' ){
        $fieldNameList = LCase(getFieldList($GLOBALS['db_PREFIX'] . $tableName)) ;
    }

    $fieldNameList = specialStrReplace($fieldNameList) ;//�����ַ�����
    $splFieldName = aspSplit($fieldNameList, ',') ;//�ֶηָ������

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


    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' ' . $addSql);
    $nCount = @mysql_num_rows($rsObj) ;
    //nPageSize = 10         '�����趨
    $GLOBALS['page'] = @$_REQUEST['page'] ;
    $url = getUrlAddToParam(getUrl(), '?page=[id]', 'replace') ;
    $content = Replace($content, '[$pageInfo$]', webPageControl($nCount, $nPageSize, $GLOBALS['page'], $url)) ;
    if( $GLOBALS['page'] <> '' ){
        $GLOBALS['page'] = $GLOBALS['page'] - 1 ;
    }
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' ' . $addSql . ' limit ' . $nPageSize * $GLOBALS['page'] . ',' . $nPageSize . '');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $s = $defaultList ;
        for( $k = 1 ; $k<= 3; $k++){
            $s = Replace($s, '[$id$]', $rs['id']) ;
            $s = Replace($s, '[$phpArray$]', '') ;//�滻Ϊ��  ΪҪ[]  ��Ϊ����ͨ��js������
            for( $j = 0 ; $j<= UBound($splFieldName); $j++){
                if( $splFieldName[$j] <> '' ){
                    $splxx = aspSplit($splFieldName[$j] . '|||', '|') ;
                    $fieldName = $splxx[0] ;
                    $replaceStr = $rs[$fieldName] . '' ;
                    $s = replaceValueParam($s, $fieldName, $replaceStr) ;//���ַ�ʽ���� �Ӷ���
                }

                if( $GLOBALS['isMakeHtml'] == true ){
                    $url = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
                }else{
                    $url = handleWebUrl('?act=detail&id=' . $rs['id']) ;
                }
                $s = replaceValueParam($s, 'url', $url) ;
            }
        }
        //�����б�����߱༭
        $url = '/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
        $s = HandleDisplayOnlineEditDialog($url, $s, '', 'div|li|span') ;

        $c = $c . $s ;
    }
    $content = Replace($content, '[list]' . $defaultList . '[/list]', $c) ;

    $getDetailList = $content ;
    return @$getDetailList;
}

//****************************************************
//Ĭ���б�ģ��
function defaultListTemplate(){
    $c=''; $templateHtml=''; $listTemplate=''; $lableName=''; $startStr=''; $endStr ='';

    $templateHtml = getFText($GLOBALS['cfg_webTemplate'] . '/' . $GLOBALS['templateName']) ;

    $lableName = '[list]' ;
    $startStr = '<!--#' . $lableName . ' start#-->' ;
    $endStr = '<!--#' . $lableName . ' end#-->' ;
    if( instr($templateHtml, $startStr) > 0 && instr($templateHtml, $endStr) > 0 ){
        $listTemplate = StrCut($templateHtml, $startStr, $endStr, 2) ;
    }else{
        $startStr = '<!--#' . $lableName ;
        $endStr = '#-->' ;
        if( instr($templateHtml, $startStr) > 0 && instr($templateHtml, $endStr) > 0 ){
            $GLOBALS['defaultStr'] = StrCut($templateHtml, $startStr, $endStr, 2) ;
        }
    }
    if( $listTemplate == '' ){
        $c = '<ul class="list">' . "\n" ;
        $c = $c . '[list]    <li><a href="[$url$]" target="[$target$]">[$title$]</a><span class="time">[$adddatetime format_time=\'7\'$]</span></li>' . "\n" ;
        $c = $c . '[/list]' . "\n" ;
        $c = $c . '</ul>' . "\n" ;
        $c = $c . '<div class="clear10"></div>' . "\n" ;
        $c = $c . '<div>[$pageInfo$]</div>' . "\n" ;
        $listTemplate = $c ;
    }

    $defaultListTemplate = $listTemplate ;
    return @$defaultListTemplate;
}
//������ر�ǩ
function aritcleRelatedTags($relatedTags){
    $c=''; $splStr=''; $s=''; $url ='';
    $splStr = aspSplit($relatedTags, ',') ;
    foreach( $splStr as $s){
        if( $s <> '' ){
            if( $c <> '' ){
                $c = $c . ',' ;
            }
            $url = getColumnUrl($s, 'name') ;
            $c = $c . '<a href="' . $url . '" rel="category tag" class="ablue">' . $s . '</a>' . "\n" ;
        }
    }

    $c = '<footer class="articlefooter">' . "\n" . '��ǩ�� ' . $c . '</footer>' . "\n" ;
    $aritcleRelatedTags = $c ;
    return @$aritcleRelatedTags;
}

//��¼��ǰ׺
if( @$_REQUEST['db_PREFIX'] <> '' ){
    $db_PREFIX = @$_REQUEST['db_PREFIX'] ;
}else if( @$_SESSION['db_PREFIX'] <> '' ){
    $db_PREFIX = @$_SESSION['db_PREFIX'] ;
}
//������ַ����
loadWebConfig() ;
$isMakeHtml = false ;
if( @$_REQUEST['isMakeHtml'] == '1' || @$_REQUEST['isMakeHtml'] == 'true' ){
    $isMakeHtml = true ;
}
$templateName = @$_REQUEST['templateName'] ;//ģ������


//����html
if( @$_REQUEST['act'] == 'makehtml' ){
    ASPEcho('makehtml', 'makehtml') ;
    $isMakeHtml = true ;
    makeWebHtml(' action actionType=\'' . @$_REQUEST['act'] . '\' columnName=\'' . @$_REQUEST['columnName'] . '\' id=\'' . @$_REQUEST['id'] . '\' ') ;
    createfile('index.html', $code) ;

    //����Html����վ
}else if( @$_REQUEST['act'] == 'copyHtmlToWeb' ){
    copyHtmlToWeb() ;
    //ȫ������
}else if( @$_REQUEST['act'] == 'makeallhtml' ){
    makeAllHtml('', '', '') ;

    //���ɵ�ǰҳ��
}else if( @$_REQUEST['isMakeHtml'] <> '' && @$_REQUEST['isSave'] <> '' ){
    $isMakeHtml = true ;
    rw(makeWebHtml(' action actionType=\'' . @$_REQUEST['act'] . '\' columnName=\'' . @$_REQUEST['columnName'] . '\' columnType=\'' . @$_REQUEST['columnType'] . '\' id=\'' . @$_REQUEST['id'] . '\' npage=\'' . @$_REQUEST['page'] . '\' ')) ;

    $gbl_filePath = Replace($gbl_url, $cfg_webSiteUrl, '') ;
    if( substr($gbl_filePath, - 1) == '/' ){
        $gbl_filePath = $gbl_filePath . 'index.html' ;
    }
    //�ļ���Ϊ��  ���ҿ�������html
    if( $gbl_filePath <> '' && $gbl_isonhtml == true ){
        createDirFolder($gbl_filePath) ;
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
        ASPEcho('�����ļ�·��', '<a href="' . $gbl_filePath . '" target=\'_blank\'>' . $gbl_filePath . '</a>') ;
    }
}else{
    if( LCase(@$_REQUEST['issave']) == '1' ){
        makeAllHtml(@$_REQUEST['columnType'], @$_REQUEST['columnName'], @$_REQUEST['columnId']) ;
    }else{
        rw(makeWebHtml(' action actionType=\'' . @$_REQUEST['act'] . '\' columnName=\'' . @$_REQUEST['columnName'] . '\' columnType=\'' . @$_REQUEST['columnType'] . '\' id=\'' . @$_REQUEST['id'] . '\' npage=\'' . @$_REQUEST['page'] . '\' ')) ;
    }
}


//����ȫ��htmlҳ��
function makeAllHtml($columnType, $columnName, $columnId){
    $action=''; $s=''; $i=''; $nPageSize=''; $nCountSize=''; $nPage=''; $addSql=''; $url ='';
    $GLOBALS['isMakeHtml'] = true ;
    //��Ŀ
    ASPEcho('��Ŀ', '') ;
    if( $columnType <> '' ){
        $addSql = 'where columnType=\'' . $columnType . '\'' ;
    }
    if( $columnName <> '' ){
        $addSql = getWhereAnd($addSql, 'where columnName=\'' . $columnName . '\'') ;
    }
    if( $columnId <> '' ){
        $addSql = getWhereAnd($addSql, 'where id=\'' . $columnId . '\'') ;
    }
    $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn ' . $addSql . ' order by sortrank asc');
    while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
        $GLOBALS['gbl_columnName'] = '' ;
        //��������html
        if( $rss['isonhtml'] == true ){
            if( $rss['columntype'] == '����' ){
                $nCountSize=getRecordCount($GLOBALS['db_PREFIX'] . 'articledetail', ' where parentid=' . $rss['id'])			;//��¼��
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
                        createDirFolder($GLOBALS['gbl_filePath']) ;
                        createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                    }
                    doevents() ;
                    $GLOBALS['templateName'] = '' ;//���ģ���ļ�����
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
                    createDirFolder($GLOBALS['gbl_filePath']) ;
                    createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                }
                doevents() ;
                $GLOBALS['templateName'] = '' ;
            }
            connExecute('update ' . $GLOBALS['db_PREFIX'] . 'WebColumn set ishtml=true where id=' . $rss['id']) ;//���µ���Ϊ����״̬
        }
    }
    if( $addSql == '' ){
        //����
        ASPEcho('����', '') ;
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
            //�ļ���Ϊ��  ���ҿ�������html
            if( $GLOBALS['gbl_filePath'] <> '' && $rss['isonhtml'] == true ){
                createDirFolder($GLOBALS['gbl_filePath']) ;
                createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                connExecute('update ' . $GLOBALS['db_PREFIX'] . 'ArticleDetail set ishtml=true where id=' . $rss['id']) ;//��������Ϊ����״̬
            }
            $GLOBALS['templateName'] = '' ;//���ģ���ļ�����
        }

        //��ҳ
        ASPEcho('��ҳ', '') ;
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
            //�ļ���Ϊ��  ���ҿ�������html
            if( $GLOBALS['gbl_filePath'] <> '' && $rss['isonhtml'] == true ){
                createDirFolder($GLOBALS['gbl_filePath']) ;
                createfile($GLOBALS['gbl_filePath'], $GLOBALS['code']) ;
                connExecute('update ' . $GLOBALS['db_PREFIX'] . 'onepage set ishtml=true where id=' . $rss['id']) ;//���µ�ҳΪ����״̬
            }
            $GLOBALS['templateName'] = '' ;//���ģ���ļ�����
        }

    }


}
//����html����վ
function copyHtmlToWeb(){
    $webDir=''; $toFilePath=''; $filePath=''; $fileName=''; $fileList=''; $cssFileList=''; $splStr=''; $content=''; $s=''; $c=''; $webImages=''; $webCss=''; $webJs=''; $splJs ='';
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
    createFolder($webJs) ;//����Js�ļ���

    //����Css�ļ���
    $content = getFileFolderList($GLOBALS['cfg_webCss'], true, 'css', '', '', '', '') ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $filePath){
        if( $filePath <> '' ){
            ASPEcho('css', $filePath) ;
            $content = getftext($filePath) ;
            $content = Replace($content, $GLOBALS['cfg_webImages'], '../') ;//ɾ��ģ��·��
            createfile($filePath, $content) ;
        }
    }
    //����Js�ļ���
    $content = getFileFolderList($webImages, true, 'js', '', '', '', '') ;
    $splJs = aspSplit($content, "\n") ;
    foreach( $splJs as $filePath){
        if( $filePath <> '' ){
            $toFilePath = $webJs . getFileName($filePath) ;
            ASPEcho('js', $filePath) ;
            moveFile($filePath, $toFilePath) ;
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
            $fileList = $fileList . $GLOBALS['gbl_filePath'] . "\n" ;
            $fileName = Replace($GLOBALS['gbl_filePath'], '/', '_') ;
            $toFilePath = $webDir . $fileName ;
            copyfile($GLOBALS['gbl_filePath'], $toFilePath) ;
            ASPEcho('����', $GLOBALS['gbl_filePath']) ;
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
            $fileList = $fileList . $GLOBALS['gbl_filePath'] . "\n" ;
            $fileName = Replace($GLOBALS['gbl_filePath'], '/', '_') ;
            $toFilePath = $webDir . $fileName ;
            copyfile($GLOBALS['gbl_filePath'], $toFilePath) ;
            ASPEcho('����' . $rss['title'], $GLOBALS['gbl_filePath']) ;
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
            $fileList = $fileList . $GLOBALS['gbl_filePath'] . "\n" ;
            $fileName = Replace($GLOBALS['gbl_filePath'], '/', '_') ;
            $toFilePath = $webDir . $fileName ;
            copyfile($GLOBALS['gbl_filePath'], $toFilePath) ;
            ASPEcho('��ҳ' . $rss['title'], $GLOBALS['gbl_filePath']) ;
        }
    }

    $splStr = aspSplit($fileList, "\n") ;
    foreach( $splStr as $filePath){
        if( $filePath <> '' ){
            $filePath = $webDir . Replace($filePath, '/', '_') ;
            ASPEcho('filePath', $filePath) ;
            $content = getftext($filePath) ;
            $content = Replace($content, $GLOBALS['cfg_webSiteUrl'], '') ;//ɾ����ַ
            $content = Replace($content, $GLOBALS['cfg_webTemplate'], '') ;//ɾ��ģ��·��
            foreach( $splStr as $s){
                $content = Replace($content, $s, Replace($s, '/', '_')) ;
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
//ʹhtmlWeb�ļ�����phpѹ��
function makeHtmlWebToZip($webDir){
    $content=''; $splStr=''; $filePath=''; $c=''; $fileArray=''; $fileName=''; $fileType=''; $isTrue ='';
    $cleanFileList ='';//�ɾ��ļ��б� Ϊ��ɾ����ҳ�ļ�
    $content = GetFileFolderList($webDir, true, 'ȫ��', '', 'ȫ���ļ���', '', '') ;
    $splStr = aspSplit($content, "\n") ;
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

//http://127.0.0.1/aspweb.asp?act=nav&columnName=ASP
//http://127.0.0.1/aspweb.asp?act=detail&id=75
//����html��̬ҳ
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
    //����
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
            $npagesize = $rs['npagesize'] ;//ÿҳ��ʾ����
            $GLOBALS['gbl_isonhtml'] = $rs['isonhtml'] ;//�Ƿ����ɾ�̬��ҳ

            if( $rs['webtitle'] <> '' ){
                $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//��ַ����
            }
            if( $rs['webkeywords'] <> '' ){
                $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//��վ�ؼ���
            }
            if( $rs['webdescription'] <> '' ){
                $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//��վ����
            }
            if( $GLOBALS['templateName'] == '' ){
                if( AspTrim($rs['templatepath']) <> '' ){
                    $GLOBALS['templateName'] = $rs['templatepath'] ;
                }else if( $rs['columntype'] == '��ҳ' ){
                    $GLOBALS['templateName'] = 'Index_Model.html' ;
                }else{
                    $GLOBALS['templateName'] = 'Main_Model.html' ;
                }
            }
        }
        $GLOBALS['gbl_columnENType'] = handleColumnType($GLOBALS['gbl_columnType']) ;
        $GLOBALS['gbl_url'] = getColumnUrl($GLOBALS['gbl_columnName'], 'name') ;

        if( $GLOBALS['gbl_columnType'] == '����' ){
            $GLOBALS['gbl_bodyContent'] = getDetailList($action, defaultListTemplate(), 'ArticleDetail', '��վ��Ŀ', '*', $npagesize, $npage, 'where parentid=' . $GLOBALS['gbl_columnId'] . ' order by sortrank asc') ;
        }else if( $GLOBALS['gbl_columnType'] == '�ı�' ){

            //������Ŀ�ӹ���
            if( @$_REQUEST['gl'] == 'edit' ){
                $GLOBALS['gbl_bodyContent'] = '<span>' . $GLOBALS['gbl_bodyContent'] . '</span>' ;
            }
            $url = '/admin/1.asp?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=' . $GLOBALS['gbl_columnId'] . '&n=' . getRnd(11) ;
            $GLOBALS['gbl_bodyContent'] = HandleDisplayOnlineEditDialog($url, $GLOBALS['gbl_bodyContent'], '', 'span') ;

        }
        //ϸ��
    }else if( $actionType == 'detail' ){
        $rsObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where id=' . RParam($action, 'id'));
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $GLOBALS['gbl_columnName'] = getColumnName($rs['parentid']) ;
            $GLOBALS['gbl_detailTitle'] = $rs['title'] ;
            $GLOBALS['gbl_flags'] = $rs['flags'] ;
            $GLOBALS['gbl_isonhtml'] = $rs['isonhtml'] ;//�Ƿ����ɾ�̬��ҳ
            $GLOBALS['gbl_id'] = $rs['id'] ;//����ID
            if( $GLOBALS['isMakeHtml'] == true ){
                $GLOBALS['gbl_url'] = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
            }else{
                $GLOBALS['gbl_url'] = handleWebUrl('?act=detail&id=' . $rs['id']) ;
            }

            if( $rs['webtitle'] <> '' ){
                $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//��ַ����
            }
            if( $rs['webkeywords'] <> '' ){
                $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//��վ�ؼ���
            }
            if( $rs['webdescription'] <> '' ){
                $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//��վ����
            }
            //��������
            $GLOBALS['gbl_bodyContent'] = '<div class="articleinfowrap">[$articleinfowrap$]</div>' . $rs['bodycontent'] . '[$relatedtags$]<ul class="updownarticlewrap">[$updownArticle$]</ul>' ;
            //��һƪ���£���һƪ����
            $GLOBALS['gbl_bodyContent'] = Replace($GLOBALS['gbl_bodyContent'], '[$updownArticle$]', upArticle($rs['parentid'], 'sortrank', $rs['sortrank']) . downArticle($rs['parentid'], 'sortrank', $rs['sortrank'])) ;
            $GLOBALS['gbl_bodyContent'] = Replace($GLOBALS['gbl_bodyContent'], '[$articleinfowrap$]', '��Դ��' . $rs['author'] . ' &nbsp; ����ʱ�䣺' . format_Time($rs['adddatetime'], 1)) ;
            $GLOBALS['gbl_bodyContent'] = Replace($GLOBALS['gbl_bodyContent'], '[$relatedtags$]', aritcleRelatedTags($rs['relatedtags'])) ;

            //������ϸ�ӿ���
            if( @$_REQUEST['gl'] == 'edit' ){
                $GLOBALS['gbl_bodyContent'] = '<span>' . $GLOBALS['gbl_bodyContent'] . '</span>' ;
            }
            $url = '/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=' . RParam($action, 'id') . '&n=' . getRnd(11) ;
            $GLOBALS['gbl_bodyContent'] = HandleDisplayOnlineEditDialog($url, $GLOBALS['gbl_bodyContent'], '', 'span') ;


            if( $GLOBALS['templateName'] == '' ){
                if( AspTrim($rs['templatepath']) <> '' ){
                    $GLOBALS['templateName'] = $rs['templatepath'] ;
                }else{
                    //����ϸ�ڣ����û������Ĭ��
                    if( checkFile($GLOBALS['cfg_webTemplate'] . '/Article_Detail.html') == true ){
                        $GLOBALS['templateName'] = 'Article_Detail.html' ;
                    }else{
                        $GLOBALS['templateName'] = 'Main_Model.html' ;
                    }
                    //call echo(templateName,"templateName")
                }
            }

        }

        //��ҳ
    }else if( $actionType == 'onepage' ){
        $rsObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where id=' . RParam($action, 'id'));
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $GLOBALS['gbl_detailTitle'] = $rs['title'] ;
            $GLOBALS['gbl_isonhtml'] = $rs['isonhtml'] ;//�Ƿ����ɾ�̬��ҳ
            if( $GLOBALS['isMakeHtml'] == true ){
                $GLOBALS['gbl_url'] = getRsUrl($rs['filename'], $rs['customaurl'], '/page/page' . $rs['id']) ;
            }else{
                $GLOBALS['gbl_url'] = handleWebUrl('?act=detail&id=' . $rs['id']) ;
            }

            if( $rs['webtitle'] <> '' ){
                $GLOBALS['cfg_webTitle'] = $rs['webtitle'] ;//��ַ����
            }
            if( $rs['webkeywords'] <> '' ){
                $GLOBALS['cfg_webKeywords'] = $rs['webkeywords'] ;//��վ�ؼ���
            }
            if( $rs['webdescription'] <> '' ){
                $GLOBALS['cfg_webDescription'] = $rs['webdescription'] ;//��վ����
            }
            //����
            $GLOBALS['gbl_bodyContent'] = $rs['bodycontent'] ;


            //������ϸ�ӿ���
            if( @$_REQUEST['gl'] == 'edit' ){
                $GLOBALS['gbl_bodyContent'] = '<span>' . $GLOBALS['gbl_bodyContent'] . '</span>' ;
            }
            $url = '/admin/1.asp?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=' . RParam($action, 'id') . '&n=' . getRnd(11) ;
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
        //��Ƶ��ϸ
    }else if( $actionType == 'video' ){
        $GLOBALS['gbl_id'] = RParam($action, 'id') ;

        if( $GLOBALS['templateName'] == '' ){
            $GLOBALS['templateName'] = 'videoDetail.html' ;
        }
        //��Ƶ��ϸ
    }else if( $actionType == 'news' ){
        $GLOBALS['gbl_id'] = RParam($action, 'id') ;

        if( $GLOBALS['templateName'] == '' ){
            $GLOBALS['templateName'] = 'newsDetail.html' ;
        }
        //�ı���ϸ
    }else if( $actionType == 'text' ){
        $GLOBALS['gbl_columnName'] = RParam($action, 'columnName') ;
        $GLOBALS['gbl_columnId'] = getColumnId($GLOBALS['gbl_columnName']) ;
        $GLOBALS['gbl_columnType'] = getColumnType($GLOBALS['gbl_columnId']) ;
        $GLOBALS['gbl_columnENType'] = handleColumnType($GLOBALS['gbl_columnType']) ;

        if( $GLOBALS['templateName'] == '' ){
            $GLOBALS['templateName'] = 'textDetail.html' ;
        }
        //�ı���ϸ
    }else if( $actionType == 'test' ){
        $GLOBALS['templateName'] = 'test.html' ;
        //���صȴ�
    }else if( $actionType == 'loading' ){
        rwend('ҳ�����ڼ����С�����') ;
    }
    //ģ��Ϊ�գ�����Ĭ����ҳģ��
    if( $GLOBALS['templateName'] == '' ){
        $GLOBALS['templateName'] = 'Index_Model.html' ;//Ĭ��ģ��
    }
    //��⵱ǰ·���Ƿ���ģ��
    if( instr($GLOBALS['templateName'], '/') == false ){
        $GLOBALS['templateName'] = $GLOBALS['cfg_webTemplate'] . '/' . $GLOBALS['templateName'] ;
    }
    //call echo("templateName",templateName)
    $GLOBALS['code'] = getftext($GLOBALS['templateName']) ;


    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = replaceGlobleVariable($GLOBALS['code']) ;//�滻ȫ�ֱ�ǩ
    $GLOBALS['code'] = thisPosition($GLOBALS['code']) ;
    $GLOBALS['code'] = delTemplateMyNote($GLOBALS['code']) ;
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������  �ٴδ���
    $GLOBALS['code'] = replaceGlobleVariable($GLOBALS['code']) ;//�滻ȫ�ֱ�ǩ


    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = handleAction($GLOBALS['code']) ;//������
    $GLOBALS['code'] = replaceGlobleVariable($GLOBALS['code']) ;//�滻ȫ�ֱ�ǩ


    //��ʽ��
    if( instr($GLOBALS['cfg_flags'], '|formattinghtml|') > 0 ){
        //code = HtmlFormatting(code)        '��
        $GLOBALS['code'] = HandleHtmlFormatting($GLOBALS['code'], false, 0, 'ɾ������') ;//�Զ���
    }
    //�պϱ�ǩ

    if( instr($GLOBALS['cfg_flags'], '|labelclose|') > 0 ){
        $GLOBALS['code'] = handleCloseHtml($GLOBALS['code'], true, '') ;//ͼƬ�Զ���alt  "|*|",
    }

    //���߱༭20160127
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

?>




