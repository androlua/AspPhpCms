<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-24
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By �ƶ� 
************************************************************/
?>
<?PHP
//ASP��PHPͨ�ú���


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
            $c = $c . '<a href="' . $url . '" rel="category tag" class="ablue">' . $s . '</a>' . vbCrlf() ;
        }
    }

    $c = '<footer class="articlefooter">' . vbCrlf() . '��ǩ�� ' . $c . '</footer>' . vbCrlf() ;
    $aritcleRelatedTags = $c ;
    return @$aritcleRelatedTags;
}


//����������id�б�
function getRandArticleId($addSql, $topNumb){
    $splStr=''; $s=''; $c=''; $nIndex ='';
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail ' . $addSql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        if( $c <> '' ){ $c = $c . ',' ;}
        $c = $c . $rs['id'] ;
    }
    $getRandArticleId = RandomShow($c, ',', 4) ;
    $splStr = aspSplit($c, ',') ; $c = '' ; $nIndex = 0 ;
    foreach( $splStr as $s){
        if( $c <> '' ){ $c = $c . ',' ;}
        $c = $c . $s ;
        $nIndex = $nIndex + 1 ;
        if( $nIndex >= $topNumb ){ break; }
    }
    $getRandArticleId = $c ;
    return @$getRandArticleId;
}

//��һƪ���� �������sortrank(����)Ҳ���Ը�Ϊid,�����õ�ʱ���Ҫ��id
function upArticle($parentid, $lableName, $lableValue){
    $sql ='';
    $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentid=' . $parentid . ' and ' . $lableName . '<' . $lableValue . ' order by ' . $lableName . ' desc' ;
    $upArticle = handleUpDownArticle('��һƪ��', $sql) ;
    return @$upArticle;
}
//��һƪ����
function downArticle($parentid, $lableName, $lableValue){
    $sql ='';
    $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentid=' . $parentid . ' and ' . $lableName . '>' . $lableValue . ' order by ' . $lableName . ' asc' ;
    $downArticle = handleUpDownArticle('��һƪ��', $sql) ;
    return @$downArticle;
}
//��������ҳ
function handleUpDownArticle($lableTitle, $sql){
    $c=''; $url ='';
    //call echo("sql",sql)
    $rsxObj=$GLOBALS['conn']->query( $sql);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        if( $GLOBALS['isMakeHtml'] == true ){
            $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/html/detail' . $rsx['id']) ;
        }else{
            $url = handleWebUrl('?act=detail&id=' . $rsx['id']) ;
        }
        $c = '<a href="' . $url . '">' . $lableTitle . $rsx['title'] . '</a>';
    }else{
        $c = $lableTitle . 'û��' ;
    }
    $handleUpDownArticle = $c ;
    return @$handleUpDownArticle;
}

//��õ�ҳurl 20160114
function getOnePageUrl($title){
    $url ='';
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where title=\'' . $title . '\'');
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        if( $GLOBALS['isMakeHtml'] == true ){
            $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/page' . $rsx['id']) ;
        }else{
            $url = handleWebUrl('?act=onepage&id=' . $rsx['id']) ;
            if( $rsx['customaurl'] <> '' ){
                $url = $rsx['customaurl'] ;
            }
        }
    }

    $getOnePageUrl = $url ;
    return @$getOnePageUrl;
}
//���RS��ַ
function getRsUrl($fileName, $customAUrl, $defaultFileName){
    $url ='';
    //��Ĭ���ļ�����
    if( $fileName == '' ){
        $fileName = $defaultFileName ;
    }
    //��ַ
    if( $fileName <> '' ){
        $url = $fileName ;
        if( instr(LCase($url), '.html') == false && substr($url, - 1) <> '/' ){
            $url = $url . '.html' ;
        }
    }
    if( AspTrim($customAUrl) <> '' ){
        $url = AspTrim($customAUrl) ;
    }
    if( instr($GLOBALS['cfg_flags'], '|addwebsite|') > 0 ){
        $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
    }
    $getRsUrl = $url ;
    return @$getRsUrl;
}

//�����Ŀ���ƶ�Ӧ��id
function getColumnId($columnName){
    $columnName = Replace($columnName, '\'', '') ;//ע�⣬���������
    $getColumnId = -1 ;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where columnName=\'' . $columnName . '\'');
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnId = $rsx['id'] ;
    }
    return @$getColumnId;
}


//�����ĿID��Ӧ������
function getColumnName($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnName = $rsx['columnname'] ;
    }
    return @$getColumnName;
}


//�����Ŀurl 20160114
function getColumnUrl($columnNameOrId, $sType){
    $url=''; $addSql ='';

    $columnNameOrId=replaceGlobleVariable($columnNameOrId)			;//������ <a href="{$GetColumnUrl columnname='[$gbl_columnName$]' $}" >����ͼƬ</a>

    if( $sType == 'name' ){
        $addSql = ' where columnname=\'' . $columnNameOrId . '\'' ;
    }else{
        $addSql = ' where id=' . $columnNameOrId . '' ;
    }
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn' . $addSql);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        if( $GLOBALS['isMakeHtml'] == true ){
            $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']) ;
        }else{
            $url = handleWebUrl('?act=nav&columnName=' . $rsx['columnname']) ;
            if( $rsx['customaurl'] <> '' ){
                $url = $rsx['customaurl'] ;
            }
        }
    }

    $getColumnUrl = $url ;
    return @$getColumnUrl;
}

//�����ĿID��Ӧ������
function getColumnType($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnType = $rsx['columntype'] ;
    }
    return @$getColumnType;
}

//�����ĿID��Ӧ������
function getColumnBodyContent($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnBodyContent = $rsx['bodycontent'] ;
    }
    return @$getColumnBodyContent;
}







//��վͳ��2014
function webStat($folderPath){
    $dateTime=''; $content=''; $splStr ='';
    $thisUrl=''; $goToUrl=''; $caiShu=''; $c=''; $fileName=''; $co=''; $IE=''; $XP ='';
    $goToUrl = ServerVariables('HTTP_REFERER') ;
    $thisUrl = 'http://' . ServerVariables('HTTP_HOST') . ServerVariables('SCRIPT_NAME') ;
    $caiShu = ServerVariables('QUERY_STRING') ;
    if( $caiShu <> '' ){
        $thisUrl = $thisUrl . '?' . $caiShu ;
    }
    $goToUrl = @$_REQUEST['GoToUrl'] ;
    $thisUrl = @$_REQUEST['ThisUrl'] ;
    $co = @$_GET['co'] ;
    $dateTime = Now() ;
    $content = ServerVariables('HTTP_USER_AGENT') ;
    $content = Replace($content, 'MSIE', 'Internet Explorer') ;
    $content = Replace($content, 'NT 5.0', '2000') ;
    $content = Replace($content, 'NT 5.1', 'XP') ;
    $content = Replace($content, 'NT 5.2', '2003') ;

    $splStr = aspSplit($content . ';;;;', ';') ;
    $IE = $splStr[1] ;
    $XP = AspTrim($splStr[2]) ;
    if( substr($XP, - 1) == ')' ){ $XP = mid($XP, 1, strlen($XP) - 1) ;}
    $c = '����' . $goToUrl . vbCrlf() ;
    $c = $c . '��ǰ��' . $thisUrl . vbCrlf() ;
    $c = $c . 'ʱ�䣺' . $dateTime . vbCrlf() ;
    $c = $c . 'IP:' . getIP() . vbCrlf() ;
    $c = $c . 'IE:' . getBrType('') . vbCrlf() ;
    $c = $c . 'Cookies=' . $co . vbCrlf() ;
    $c = $c . 'XP=' . $XP . vbCrlf() ;
    $c = $c . 'Screen=' . @$_REQUEST['screen'] . vbCrlf() ;//��Ļ�ֱ���
    $c = $c . '�û���Ϣ=' . ServerVariables('HTTP_USER_AGENT') . vbCrlf() ;//�û���Ϣ

    $c = $c . '-------------------------------------------------' . vbCrlf() ;
    //c=c & "CaiShu=" & CaiShu & vbcrlf
    $fileName = $folderPath . format_Time(Now(), 2) . '.txt' ;
    createAddFile($fileName, $c) ;
    $c = $c . vbCrlf() . $fileName ;
    $c = Replace($c, vbCrlf(), '\\n') ;
    $c = Replace($c, '"', '\\"') ;
    //Response.Write("eval(""var MyWebStat=\""" & C & "\"""")")
    $webStat = $c ;
    return @$webStat;
}
?>

