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
<?PHP
//��phpͨ��   �ҵĺ�̨

//�����ļ�
function XY_Include($action){
    $templateFilePath=''; $Block=''; $startStr=''; $endStr=''; $content ='';
    $templateFilePath = LCase(RParam($action, 'File')) ;
    $Block = LCase(RParam($action, 'Block')) ;

    $findstr=''; $replaceStr ='';//�����ַ����滻�ַ�
    $findstr = RParam($action, 'findstr') ;
    $replaceStr = RParam($action, 'replacestr') ;

    $templateFilePath = HandleFileUrl($templateFilePath) ;//�����ļ�·��
    if( checkFile($templateFilePath) == false ){
        $templateFilePath = $GLOBALS['webTemplate'] . $templateFilePath ;
    }
    $content = GetFText($templateFilePath) ;
    if( $Block <> '' ){
        $startStr = '<!--#' . $Block . ' start#-->' ;
        $endStr = '<!--#' . $Block . ' end#-->' ;
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $content = StrCut($content, $startStr, $endStr, 2) ;
        }
    }
    //�滻������������
    if( $findstr <> '' ){
        $content = Replace($content, $findstr, $replaceStr) ;
    }

    $XY_Include = $content ;
    return @$XY_Include;
}

//��ʾ��Ŀ�б�
function XY_AP_ColumnList($action){
    $sql ='';
    $sql = RParam($action, 'sql') ;
    if( $sql == '' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where flags like\'%top%\' order by sortRank asc' ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_AP_ColumnList = XY_AP_GeneralList($action, 'WebColumn', $sql) ;
    return @$XY_AP_ColumnList;
}

//��ʾ�����б�
function XY_AP_ArticleList($action){
    $sql=''; $addSql=''; $columnName=''; $columnId=''; $topNumb=''; $idRand=''; $splStr=''; $s=''; $columnIdList ='';

    //action = Replace(action, "[$detailTitle$]", glb_detailTitle)               '����ǰ����
    $action = replaceGlobleVariable($action) ;//�������滻��ǩ

    //call echo(glb_detailTitle,action)
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
    //call echo(RParam(action, "columnName") ,sql)
    $XY_AP_ArticleList = XY_AP_GeneralList($action, 'ArticleDetail', $sql) ;
    return @$XY_AP_ArticleList;
}
//��ʾ�����б�
function XY_AP_CommentList($action){
    $sql=''; $itemID ='';
    $sql = RParam($action, 'sql') ;
    $itemID = RParam($action, 'itemID') ;
    $itemID = replaceGlobleVariable($itemID) ;
    //call eerr("itemID",itemID)

    if( $sql == '' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . 'TableComment where itemID=' . $itemID . ' and through=1 order by adddatetime asc' ;
    }
    $sql = replaceGlobleVariable($sql) ;
    $XY_AP_CommentList = XY_AP_GeneralList($action, 'TableComment', $sql) ;
    return @$XY_AP_CommentList;
}
//��ʾ����ͳ��
function XY_AP_SearchStatList($action){
    $sql=''; $addSql=''; $topNumb ='';

    $topNumb = RParam($action, 'topNumb') ;
    if( $sql == '' ){
        if( $topNumb <> '' ){
            $topNumb = ' top ' . $topNumb . ' ' ;
        }
        $sql = 'Select ' . $topNumb . '* From ' . $GLOBALS['db_PREFIX'] . 'SearchStat' ;
    }
    //׷��sql
    $addSql = RParam($action, 'addSql') ;
    if( $addSql <> '' ){
        $sql = getWhereAnd($sql, $addSql) ;
    }
    $sql = replaceGlobleVariable($sql) ;
    //call eerr("sql",sql)
    $XY_AP_SearchStatList = XY_AP_GeneralList($action, 'SearchStat', $sql) ;
    return @$XY_AP_SearchStatList;
}

//ͨ����Ϣ�б�
function XY_AP_GeneralList($action, $tableName, $sql){
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

    $fieldNameList = getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�') ;
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
                $url = handleWebUrl('?act=nav&columnName=' . $rs['columnname']) ;//��׷��gl�Ȳ���
                if( $rs['customaurl'] <> '' ){
                    $url = $rs['customaurl'] ;
                }
            }
            //ȫ����Ŀ����Ϊ����Ϊ�Զ���λ��ҳ ׷��(20160128)
            if( $GLOBALS['glb_columnName'] == '' && $rs['columntype'] == '��ҳ' ){
                $GLOBALS['glb_columnName'] = $rs['columnname'] ;
            }
            if( $rs['columnname'] == $GLOBALS['glb_columnName'] ){
                $isFocus = true ;
            }


            //�����¡�
        }else if( $tableName == 'ArticleDetail' ){
            if( $GLOBALS['isMakeHtml'] == true ){
                $url = getRsUrl($rs['filename'], $rs['customaurl'], '/html/detail' . $rs['id']) ;
            }else{
                $url = handleWebUrl('?act=detail&id=' . $rs['id']) ;//��׷��gl�Ȳ���
                if( $rs['customaurl'] <> '' ){
                    $url = $rs['customaurl'] ;
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
                $abcolor = ' style="' . $abcolor . '"' ;
            }
        }else if( $tableName == 'TableComment' ){
            //call eerr("defaultStr",defaultStr)

        }

        //��ַ�ж�
        if( $isFocus == true ){
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
                $url = WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
                //�����¡�
            }else if( $tableName == 'ArticleDetail' ){
                $url = WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=' . $rs['id'] . '&n=' . getRnd(11) ;
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
    $XY_AP_GeneralList = $c ;
    return @$XY_AP_GeneralList;
}

//�����ñ�����
function XY_handleGetTableBody($action, $tableName, $fieldParamName, $defaultFileName, $adminUrl){
    $url=''; $content=''; $id=''; $sql=''; $addSql=''; $fieldName=''; $fieldParamValue ='';
    $fieldName = RParam($action, 'fieldname') ;//�ֶ�����
    if( $fieldName == '' ){
        $fieldName = $defaultFileName ;
    }
    $fieldParamValue = RParam($action, $fieldParamName) ;//��ȡ�ֶ�����
    $id = handleNumber(RParam($action, 'id')) ;//���ID
    $addSql = ' where ' . $fieldParamName . '=\'' . $fieldParamValue . '\'' ;
    if( $id <> '' ){
        $addSql = ' where id=' . $id ;
    }

    $content = GetDefaultValue($action) ;//���Ĭ������
    $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . $addSql ;
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        //�Զ���� 20160113
        if( RParam($action, 'autoadd') == 'true' ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . $tableName . ' (' . $fieldParamName . ',' . $fieldName . ') values(\'' . $fieldParamValue . '\',\'' . ADSql($content) . '\')') ;
        }
    }else{
        $id = $rs['id'] ;
        $content = $rs[$fieldName] ;
    }
    if( $id == '' ){
        $id = XY_AP_GetFieldValue('', $sql, 'id') ;
    }
    $url = $adminUrl . '&id=' . $id . '&n=' . getRnd(11) ;
    if( @$_REQUEST['gl'] == 'edit' ){
        $content = '<span>' . $content . '</span>' ;
    }

    //call echo(sql,url)
    $content = HandleDisplayOnlineEditDialog($url, $content, '', 'span') ;
    $XY_handleGetTableBody = $content ;

    return @$XY_handleGetTableBody;
}
//��õ�ҳ����
function XY_AP_GetOnePageBody($action){
    $adminUrl ='';
    $adminUrl = WEB_ADMINURL . '?act=addEditHandle&actionType=OnePage&lableTitle=��ҳ����&nPageSize=10&page=&switchId=2' ;
    $XY_AP_GetOnePageBody = XY_handleGetTableBody($action, 'onepage', 'title', 'bodycontent', $adminUrl) ;
    return @$XY_AP_GetOnePageBody;
}
//��õ�������
function XY_AP_GetColumnBody($action){
    $adminUrl ='';
    $adminUrl = WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&switchId=2' ;
    $XY_AP_GetColumnBody = XY_handleGetTableBody($action, 'webcolumn', 'columnname', 'bodycontent', $adminUrl) ;
    return @$XY_AP_GetColumnBody;
}
//��ʾ��������
function XY_AP_GetArticleBody($action){
    $adminUrl ='';
    $adminUrl = WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&switchId=2' ;
    $XY_AP_GetArticleBody = XY_handleGetTableBody($action, 'articledetail', 'title', 'bodycontent', $adminUrl) ;
    return @$XY_AP_GetArticleBody;
}

//�����ĿURL
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
//�������URL
function XY_GetArticleUrl($action){
    $title=''; $url ='';
    $title = RParam($action, 'title') ;
    $url = getArticleUrl($title) ;
    if( @$_REQUEST['gl'] <> '' ){
        $url = $url . '&gl=' . @$_REQUEST['gl'] ;
    }
    $XY_GetArticleUrl = $url ;
    return @$XY_GetArticleUrl;
}
//��õ�ҳURL
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

//��õ����ֶ�����
function XY_AP_GetFieldValue($action, $sql, $fieldName){
    $title=''; $content ='';
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $content = $rs[$fieldName] ;
    }
    $XY_AP_GetFieldValue = $content ;
    return @$XY_AP_GetFieldValue;
}

//Js����վͳ��
function XY_JsWebStat($action){
    $s=''; $fileName ='';
    $fileName = AspTrim(RParam($action, 'fileName')) ;
    if( $fileName == '' ){
        $fileName = '[$WEB_VIEWURL$]?dataact=WebStat' ;
    }
    $fileName = Replace($fileName, '/', '\\/') ;
    $s = '<script>document.writeln("<script src=\\\'' . $fileName . '&GoToUrl="' ;
    $s = $s . '+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)' ;
    $s = $s . '+"&co="+escape(document.cookie)' ;//�ռ�cookie ����Ҫ�����ε�
    $s = $s . '+" \\\'><\\/script>");</script>' ;
    $XY_JsWebStat = $s ;
    return @$XY_JsWebStat;
}


//��ͨ����A
function XY_HrefA($action){
    $content=''; $Href=''; $c=''; $AContent=''; $AType=''; $url=''; $title ='';
    $action = HandleInModule($action, 'start') ;
    $content = RParam($action, 'Content') ;
    $AType = RParam($action, 'Type') ;
    if( $AType == '�ղ�' ){
        //��һ�ַ���
        //Url = "window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"
        $url = 'shoucang(document.title,window.location)' ;
        $c = '<a href=\'javascript:;\' onClick="' . $url . '" ' . SetHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>' ;
    }else if( $AType == '��Ϊ��ҳ' ){
        //��һ�ַ���
        //Url = "var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"
        $url = 'SetHome(this,window.location)' ;
        $c = '<a href=\'javascript:;\' onClick="' . $url . '"' . SetHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>' ;
    }else{
        $content = RParam($action, 'Title') ;
    }

    $content = HandleInModule($content, 'end') ;
    if( $c == '' ){ $c = '<a' . SetHtmlParam($action, 'href|target|title|alt|id|class|rel|style') . '>' . $content . '</a>' ;}

    $XY_HrefA = $c ;
    return @$XY_HrefA;
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
//��ʾ������20160127
function XY_DisplayWrap( $action){
    $content ='';
    $content = GetDefaultValue($action) ;
    $XY_DisplayWrap = $content ;
    return @$XY_DisplayWrap;
}
//��ģ������
function XY_ReadTemplateModule($action){
    $ModuleId=''; $filePath ='';
    $SourceList ='';//Դ�����б� 20150109
    $ReplaceList ='';//�滻�����б�
    $SplSource=''; $SplReplace=''; $i=''; $SourceStr=''; $replaceStr ='';
    //Call die(Action)

    $filePath = RParam($action, 'File') ;
    $ModuleId = RParam($action, 'ModuleId') ;
    $SourceList = RParam($action, 'SourceList') ;
    $ReplaceList = RParam($action, 'ReplaceList') ;
    //Call Echo(SourceList,ReplaceList)

    if( $ModuleId == '' ){ $ModuleId = RParam($action, 'ModuleName') ;}//�ÿ�����
    $filePath = $filePath . '.html' ;
    //Call Echo("FilePath",FilePath)
    //Call Echo("ModuleId",ModuleId)
    $XY_ReadTemplateModule = ReadTemplateModuleStr($filePath, '', $ModuleId) ;
    return @$XY_ReadTemplateModule;
}



//Ƕ�ױ��� ����
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
?>