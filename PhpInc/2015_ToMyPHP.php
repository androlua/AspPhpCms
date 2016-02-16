<?PHP
//��phpͨ��   �ҵĺ�̨

//��ʾ�����б�
function XY_PHP_NavList($action){
    $sql ='';
    $sql = RParam($action, 'sql') ;
    if( $sql == '' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where flags like\'%top%\' order by sortRank asc' ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_PHP_NavList = XY_PHP_GeneralList($action, 'WebColumn', $sql) ;
    return @$XY_PHP_NavList;
}

//��ʾ�����б�
function XY_PHP_CommentList($action){
    $sql=''; $itemID ='';
    $sql = RParam($action, 'sql') ;
    $itemID = RParam($action, 'itemID') ;
    $itemID = replaceGlobleVariable($itemID) ;
    //call eerr("itemID",itemID)

    if( $sql == '' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'TableComment where itemID=' . $itemID . ' and through=1 order by adddatetime asc' ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_PHP_CommentList = XY_PHP_GeneralList($action, 'TableComment', $sql) ;
    return @$XY_PHP_CommentList;
}

//��ʾϸ���б�
function XY_PHP_DetailList($action){
    $sql=''; $addSql=''; $columnName=''; $columnId=''; $topNumb=''; $idRand=''; $splStr=''; $s=''; $columnIdList ='';

    $action = Replace($action, '[$detailTitle$]', $GLOBALS['gbl_detailTitle']) ;//����ǰ����
    //call echo(gbl_detailTitle,action)
    $sql = RParam($action, 'sql') ;
    $topNumb = RParam($action, 'topNumb') ;
    if( $sql == '' ){
        if( $topNumb <> '' ){
            $topNumb = ' top ' . $topNumb . ' ' ;
        }
        $sql = 'Select ' . $topNumb . '* From ' . $GLOBALS['db_PREFIX'] . 'ArticleDetail' ;
    }
    //id���
    $idRand = LCase(RParam($action, 'rand')) ;
    if( $idRand == 'true' || $idRand == '1' ){
        $sql = $sql . ' where id in(' . getRandArticleId('', $topNumb) . ')' ;
    }

    //��Ŀ���� ����Ŀ���鴦���� ģ���������[Array]CSS3[Array]HTML5
    $s = RParam($action, 'columnName') ;
    if( $s <> '' ){
        $splStr = aspSplit($s, '[Array]') ;
        foreach( $splStr as $columnName){
            $columnId = getColumnId($columnName) ;
            if( $columnId <> '' ){
                if( $columnIdList <> '' ){
                    $columnIdList = $columnIdList . ',' ;
                }
                $columnIdList = $columnIdList . $columnId ;
            }
        }
    }
    if( $columnIdList <> '' ){
        $sql = getWhereAnd($sql, 'where parentId in(' . $columnIdList . ')') ;
    }
    //׷��sql
    $addSql = RParam($action, 'addSql') ;
    if( $addSql <> '' ){
        $sql = getWhereAnd($sql, $addSql) ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_PHP_DetailList = XY_PHP_GeneralList($action, 'ArticleDetail', $sql) ;
    return @$XY_PHP_DetailList;
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

//ͨ����Ϣ�б�
function XY_PHP_GeneralList($action, $tableName, $sql){
    $title=''; $topNumb=''; $addSql=''; $isB=''; $abcolor ='';
    $columnName=''; $columnEnName=''; $simpleIntroduction=''; $bodyContent=''; $showTitle ='';
    $bannerImage=''; $smallImage=''; $bigImage=''; $id ='';
    $defaultStr=''; $i=''; $j=''; $s=''; $c=''; $startStr=''; $endStr=''; $url ='';
    $noFollow ='';//��׷�� 20141222
    $defaultStr = GetDefaultValue($action) ;//���Ĭ������
    $modI ='';//��ѭ��20150112
    $noFollow = AspTrim(LCase(RParam($action, 'noFollow'))) ;//��׷��
    $lableTitle ='';//�������
    $target ='';//a���Ӵ�Ŀ�귽ʽ
    $adddatetime ='';//���ʱ��
    $isFocus ='';
    $fieldNameList ='';//�ֶ��б�
    $splFieldName=''; $fieldName=''; $replaceStr=''; $k ='';

    $fieldNameList = LCase(getFieldList($GLOBALS['db_PREFIX'] . $tableName)) ;
    $splFieldName = aspSplit($fieldNameList, ',') ;

    //call echo("sql",sql)
    $rsObj=$GLOBALS['conn']->query( $sql);
    //��ǿ����
    $topNumb = RParam($action, 'topNumb') ;
    if( $topNumb == '' ){
        $topNumb = @mysql_num_rows($rsObj) ;
    }else{
        $topNumb = intval($topNumb) ;
    }
    if( $topNumb > @mysql_num_rows($rsObj) ){
        $topNumb = @mysql_num_rows($rsObj) ;
    }
    for( $i = 1 ; $i<= $topNumb; $i++){
    $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)==0 ){ break; }
        $isFocus = false ;//����Ϊ��

        $id = $rs['id'] ;
        //��������
        if( $tableName == 'WebColumn' ){
            if( $GLOBALS['isMakeHtml'] == true ){
                $url = getRsUrl($rs['filename'], $rs['customaurl'], '/nav' . $rs['id']) ;
            }else{
                $url = handleWebUrl('?act=nav&columnName=' . $rs['columnname']) ;
                if( $rs['customaurl'] <> '' ){
                    $url = $rs['customaurl'] ;
                }
                if( @$_REQUEST['gl'] <> '' ){
                    $url = $url . '&gl=' . @$_REQUEST['gl'] ;
                }
            }
            //ȫ����Ŀ����Ϊ����Ϊ�Զ���λ��ҳ ׷��(20160128)
            if( $GLOBALS['gbl_columnName'] == '' && $rs['columntype'] == '��ҳ' ){
                $GLOBALS['gbl_columnName'] = $rs['columnname'] ;
            }
            if( $rs['columnname'] == $GLOBALS['gbl_columnName'] ){
                $isFocus = true ;
            }


            //�����¡�
        }else if( $tableName == 'ArticleDetail' ){
            if( $GLOBALS['isMakeHtml'] == true ){
                $url = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
            }else{
                $url = handleWebUrl('?act=detail&id=' . $rs['id']) ;
                if( $rs['customaurl'] <> '' ){
                    $url = $rs['customaurl'] ;
                }
                if( @$_REQUEST['gl'] <> '' ){
                    $url = $url . '&gl=' . @$_REQUEST['gl'] ;
                }
            }
            //A���������ɫ
            $abcolor = '' ;
            if( $rs['titlecolor'] <> '' ){
                $abcolor = 'color:' . $rs['titlecolor'] . ';' ;
            }
            if( instr($rs['flags'], '|b|') > 0 ){
                $abcolor = $abcolor . 'font-weight:bold;' ;
            }
            if( $abcolor <> '' ){
                $abcolor = 'style="' . $abcolor . '"' ;
            }
        }else if( $tableName == 'TableComment' ){
            //call eerr("defaultStr",defaultStr)

        }

        //��ַ�ж�
        if( $url == WEBURLFILEPATH || $isFocus == true ){
            $startStr = '[list-focus]' ; $endStr = '[/list-focus]' ;
        }else{
            $startStr = '[list-' . $i . ']' ; $endStr = '[/list-' . $i . ']' ;
        }

        //�����ʱ����ǰ����20160202
        if( $i == $topNumb && $isFocus == false ){
            $startStr = '[list-end]' ; $endStr = '[/list-end]' ;
        }

        //��[list-mod2]  [/list-mod2]    20150112
        for( $modI = 6 ; $modI>= 2 ; $modI--){
            if( instr($defaultStr, $startStr) == false && $i % $modI == 0 ){
                $startStr = '[list-mod' . $modI . ']' ; $endStr = '[/list-mod' . $modI . ']' ;
                if( instr($defaultStr, $startStr) > 0 ){
                    break;
                }
            }
        }

        //û������Ĭ��
        if( instr($defaultStr, $startStr) == false ){
            $startStr = '[list]' ; $endStr = '[/list]' ;
        }



        if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
            $s = StrCut($defaultStr, $startStr, $endStr, 2) ;
            for( $j = 1 ; $j<= 3; $j++){
                $s = handleReplaceValueParam($s, 'ni', $i) ;//����Ϊi����Ϊi����imgurl��ͻ [$i$]
                $s = handleReplaceValueParam($s, '���-1', $i - 1) ;//����Ϊi����Ϊi����imgurl��ͻ [$i$]
                $s = handleReplaceValueParam($s, '���', $i) ;//����Ϊi����Ϊi����imgurl��ͻ [$i$]
                $s = Replace($s, '[$id$]', $rs['id']) ;
                $s = Replace($s, '[$url$]', $url) ;

                for( $k = 0 ; $k<= UBound($splFieldName); $k++){
                    if( $splFieldName[$k] <> '' ){
                        $fieldName = $splFieldName[$k] ;
                        $replaceStr = $rs[$fieldName] . '' ;

                        $s = replaceValueParam($s, $fieldName, $replaceStr) ;
                    }
                }
                $s = replaceValueParam($s, 'abcolor', $abcolor) ;
            }


            //��ʼλ�ü�Dialog����
            $startStr = '[list-' . $i . ' startdialog]' ; $endStr = '[/list-' . $i . ' startdialog]' ;
            if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
                $s = StrCut($defaultStr, $startStr, $endStr, 2) . $s ;
            }
            //����λ�ü�Dialog����
            $startStr = '[list-' . $i . ' enddialog]' ; $endStr = '[/list-' . $i . ' enddialog]' ;
            if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
                $s = $s . StrCut($defaultStr, $startStr, $endStr, 2) ;
            }

            //�ӿ���
            //��������
            if( $tableName == 'WebColumn' ){
                $url = '/admin/index.php?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
                //�����¡�
            }else if( $tableName == 'ArticleDetail' ){
                $url = '/admin/index.php?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
            }
            $s = HandleDisplayOnlineEditDialog($url, $s, '', 'div|li|span') ;
            $c = $c . $s ;
        }
    }

    //��ʼ���ݼ�Dialog����
    $startStr = '[dialog start]' ; $endStr = '[/dialog start]' ;
    if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
        $c = StrCut($defaultStr, $startStr, $endStr, 2) . $c ;
    }
    //�������ݼ�Dialog����
    $startStr = '[dialog end]' ; $endStr = '[/dialog end]' ;
    if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
        $c = $c . StrCut($defaultStr, $startStr, $endStr, 2) ;
    }
    $XY_PHP_GeneralList = $c ;
    return @$XY_PHP_GeneralList;
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
        $c = '<li><a href="' . $url . '">' . $lableTitle . $rsx['title'] . '</a></li>' ;
    }else{
        $c = '<li>' . $lableTitle . 'û��</li>' ;
    }
    $handleUpDownArticle = $c ;
    return @$handleUpDownArticle;
}


//����ı����� ����Ǹ�ʲô�õã�����20150121           �Ľ������߹���(20160127)
function XY_PHP_SinglePage($action){
    $title=''; $url=''; $content=''; $id=''; $sql=''; $fieldName ='';
    $fieldName = RParam($action, 'fieldname') ;//�ֶ�����
    if( $fieldName == '' ){
        $fieldName = 'bodycontent' ;
    }
    $title = RParam($action, 'title') ;//��ñ���
    $content = GetDefaultValue($action) ;//���Ĭ������
    $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where title=\'' . $title . '\'' ;
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        //�Զ���� 20160113
        if( RParam($action, 'autoadd') == 'true' ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onepage (title,displaytitle,' . $fieldName . ') values(\'' . $title . '\',\'' . $title . '\',\'' . ADSql($content) . '\')') ;
        }
    }else{
        $id = $rs['id'] ;
        $content = $rs[$fieldName] ;
    }
    if( $id == '' ){
        $id = XY_PHP_GetFieldValue('', $sql, 'id') ;
    }
    $url = '/admin/index.php?act=addEditHandle&actionType=OnePage&lableTitle=��ҳ����&nPageSize=10&page=&id=' . $id . '&n=' . getRnd(11) ;
    if( @$_REQUEST['gl'] == 'edit' ){
        $content = '<span>' . $content . '</span>' ;
    }

    $content = HandleDisplayOnlineEditDialog($url, $content, '', 'span') ;
    $XY_PHP_SinglePage = $content ;
    return @$XY_PHP_SinglePage;
}
//��õ�������
function XY_PHP_GetColumnContent($action){
    $columnname=''; $url=''; $content=''; $id=''; $sql=''; $fieldName ='';
    $fieldName = RParam($action, 'fieldname') ;//�ֶ�����
    if( $fieldName == '' ){
        $fieldName = 'bodycontent' ;
    }
    $columnname = RParam($action, 'columnname') ;//��Ŀ����
    $content = GetDefaultValue($action) ;//���Ĭ������
    $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where columnname=\'' . $columnname . '\'' ;
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $id = $rs['id'] ;
        $content = $rs[$fieldName] ;
    }
    if( $id == '' ){
        $id = XY_PHP_GetFieldValue('', $sql, 'id') ;
    }
    $url = '/admin/index.php?act=addEditHandle&actionType=OnePage&lableTitle=��ҳ����&nPageSize=10&page=&id=' . $id . '&n=' . getRnd(11) ;
    if( @$_REQUEST['gl'] == 'edit' ){
        $content = '<span>' . $content . '</span>' ;
    }

    $content = HandleDisplayOnlineEditDialog($url, $content, '', 'span') ;
    $XY_PHP_GetColumnContent = $content ;
    return @$XY_PHP_GetColumnContent;
}

//��õ����ֶ�����
function XY_PHP_GetFieldValue($action, $sql, $fieldName){
    $title=''; $content ='';
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $content = $rs[$fieldName] ;
    }
    $XY_PHP_GetFieldValue = $content ;
    return @$XY_PHP_GetFieldValue;
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

//����20151231
function XY_Layout($action){
    $layoutName=''; $s=''; $c ='';
    $layoutName = RParam($action, 'layoutname') ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'weblayout where layoutname=\'' . $layoutName . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $XY_Layout = $rs['bodycontent'] ;
    }
    //rs.open"select * from webmodule where moduletype='"& layoutname &"'",conn,1,1
    //while not rs.eof
    //c=c & rs("bodycontent")
    //rs.movenext:wend:rs.close
    //XY_Layout=c
    return @$XY_Layout;
}
//ģ��20151231
function XY_Module($action){
    $moduleName=''; $s=''; $c ='';
    $moduleName = RParam($action, 'modulename') ;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webmodule where modulename=\'' . $moduleName . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $XY_Module = $rs['bodycontent'] ;
    }
    return @$XY_Module;
}
//Js����վͳ��
function XY_JsWebStat($action){
    $s=''; $fileName ='';
    $fileName = AspTrim(RParam($action, 'fileName')) ;
    if( $fileName == '' ){
        $fileName = '/inc/Create_Html.Asp' ;
    }
    $fileName = Replace($fileName, '/', '\\/') ;
    $s = '<script>document.writeln("<script src=\\\'' . $fileName . '?act=WebStat&GoToUrl="' ;
    $s = $s . '+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)' ;
    $s = $s . '+"&co="+escape(document.cookie)' ;//�ռ�cookie ����Ҫ�����ε�
    $s = $s . '+" \\\'><\\/script>");</script>' ;
    $XY_JsWebStat = $s ;
    return @$XY_JsWebStat;
}

?>

