<?PHP
//��phpͨ��   �ҵĺ�̨

//�����վ�ײ�����aa
function XY_AP_WebSiteBottom($action){
    $s='';$url='';
    if( instr($GLOBALS['cfg_webSiteBottom'], '[$aoutadd$]') > 0 ){
        $GLOBALS['cfg_webSiteBottom']= getDefaultValue($action); //���Ĭ������
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website set websitebottom=\'' . ADSql($GLOBALS['cfg_webSiteBottom']) . '\'');
    }

    $s=$GLOBALS['cfg_webSiteBottom'];
    //��վ�ײ�
    if( @$_REQUEST['gl']== 'edit' ){
        $s= '<span>' . $s . '</span>';
    }
    $url= WEB_ADMINURL . '?act=addEditHandle&switchId=2&id=*&actionType=WebSite&lableTitle=վ������&n=' . getRnd(11);
    $s= handleDisplayOnlineEditDialog($url, $s, '', 'span');

    $XY_AP_WebSiteBottom= $s;
    return @$XY_AP_WebSiteBottom;
}

//asp��php�汾
function XY_EDITORTYPE($action){
    $aspValue='';$phpValue='';$s='';
    $aspValue= strtolower(RParam($action, 'asp'));
    $phpValue= strtolower(RParam($action, 'php'));
    if( EDITORTYPE=='asp' ){
        $s=$aspValue;
    }else{
        $s=$phpValue;
    }
    $XY_EDITORTYPE=$s;
    return @$XY_EDITORTYPE;
}


//�����ļ�
function XY_Include($action){
    $templateFilePath=''; $Block=''; $startStr=''; $endStr=''; $content ='';
    $templateFilePath= strtolower(RParam($action, 'File'));
    $Block= strtolower(RParam($action, 'Block'));

    $findstr=''; $replaceStr ='';//�����ַ����滻�ַ�
    $findstr= moduleFindContent($action, 'findstr'); //���ҿ�
    $replaceStr= moduleFindContent($action, 'replacestr'); //���ҿ�

    $templateFilePath= handleFileUrl($templateFilePath); //�����ļ�·��
    if( checkFile($templateFilePath)== false ){
        $templateFilePath= $GLOBALS['webTemplate'] . $templateFilePath;
    }
    $content= getFText($templateFilePath);
    if( $Block <> '' ){
        $startStr= '<!--#' . $Block . ' start#-->';
        $endStr= '<!--#' . $Block . ' end#-->';
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $content= strCut($content, $startStr, $endStr, 2);
        }
    }
    //�滻������������
    if( $findstr <> '' ){
        $content= Replace($content, $findstr, $replaceStr);
    }

    $XY_Include= $content;
    return @$XY_Include;
}

//��Ŀ�˵�
function XY_AP_ColumnMenu($action){
    $defaultStr=''; $thisId=''; $parentid='';$c='';
    $parentid= aspTrim(RParam($action, 'parentid'));
    $parentid=getColumnId($parentid);

    if( $parentid== '' ){ $parentid= -1 ;}

    $thisId= $GLOBALS['glb_columnId'];
    if( $thisId== '' ){ $thisId= -1 ;}
    $defaultStr= getDefaultValue($action); //���Ĭ������



    $defaultStr=$defaultStr . '[topnav]'. $parentid .'[/topnav]';
    $XY_AP_ColumnMenu= showColumnList( $parentid, 'webcolumn', 'columnname',$thisId , 0, $defaultStr);

    return @$XY_AP_ColumnMenu;
}



//��ʾ��Ŀ�б�
function XY_AP_ColumnList($action){
    $sql=''; $flags=''; $addSql=''; $columnname ='';
    $sql= RParam($action, 'sql');
    $flags= RParam($action, 'flags');
    $addSql= RParam($action, 'addSql');
    $columnname= RParam($action, 'columnname');
    if( $flags <> '' ){
        $sql= ' where flags like\'%' . $flags . '%\'';
    }
    if( $columnname <> '' ){
        $sql= getWhereAnd($sql, 'where parentid=' . getColumnId($columnname));
        //call echo(sql,columnName)
    }
    //׷��sql
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $XY_AP_ColumnList= XY_AP_GeneralList($action, 'WebColumn', $sql);

    return @$XY_AP_ColumnList;
}

//��ʾ�����б�
function XY_AP_ArticleList($action){
    $sql=''; $addSql=''; $columnName=''; $columnId=''; $topNumb=''; $idRand=''; $splStr=''; $s=''; $columnIdList ='';
    $action= replaceGlobleVariable($action); //�������滻��ǩ
    $sql= RParam($action, 'sql');
    $topNumb= RParam($action, 'topNumb');


    //id���
    $idRand= strtolower(RParam($action, 'rand'));
    if( $idRand== 'true' || $idRand== '1' ){
        $sql= $sql . ' where id in(' . getRandArticleId('', $topNumb) . ')';
    }

    //��Ŀ���� ����Ŀ���鴦���� ģ���������[Array]CSS3[Array]HTML5
    $s= RParam($action, 'columnName');
    if( $s== '' ){
        $s= RParam($action, 'did');
    }
    if( $s <> '' ){
        $splStr= aspSplit($s, '[Array]');
        foreach( $splStr as $key=>$columnName){
            $columnId= getColumnId($columnName);
            if( $columnId <> '' ){
                if( $columnIdList <> '' ){
                    $columnIdList= $columnIdList . ',';
                }
                $columnIdList= $columnIdList . $columnId;
            }
        }
    }
    if( $columnIdList <> '' ){
        $sql= getWhereAnd($sql, 'where parentId in(' . $columnIdList . ')');
    }
    //׷��sql
    $addSql= RParam($action, 'addSql');
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $sql= replaceGlobleVariable($sql);
    //call echo(RParam(action, "columnName") ,sql)
    $XY_AP_ArticleList= XY_AP_GeneralList($action, 'ArticleDetail', $sql);
    return @$XY_AP_ArticleList;
}

//��ʾ�����б�
function XY_AP_CommentList($action){
    $itemID=''; $sql=''; $addSql ='';
    $addSql= RParam($action, 'addsql');
    $itemID= RParam($action, 'itemID');
    $itemID= replaceGlobleVariable($itemID);

    if( $itemID <> '' ){
        $sql= ' where itemID=' . $itemID;
    }
    //׷��sql
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $XY_AP_CommentList= XY_AP_GeneralList($action, 'TableComment', $sql);
    return @$XY_AP_CommentList;
}

//��ʾ����ͳ��
function XY_AP_SearchStatList($action){
    $addSql ='';
    $addSql= RParam($action, 'addSql');
    $XY_AP_SearchStatList= XY_AP_GeneralList($action, 'SearchStat', $addSql);
    return @$XY_AP_SearchStatList;
}
//��ʾ��������
function XY_AP_Links($action){
    $addSql ='';
    $addSql= RParam($action, 'addSql');
    $XY_AP_Links= XY_AP_GeneralList($action, 'FriendLink', $addSql);
    return @$XY_AP_Links;
}

//ͨ����Ϣ�б�
function XY_AP_GeneralList($action, $tableName, $addSql){
    $title=''; $topNumb=''; $nTop=''; $isB=''; $sql ='';
    $columnName=''; $columnEnName=''; $aboutcontent=''; $bodyContent=''; $showTitle ='';
    $bannerImage=''; $smallImage=''; $bigImage=''; $id ='';
    $defaultStr=''; $i=''; $j=''; $s=''; $c=''; $startStr=''; $endStr=''; $url ='';
    $noFollow ='';//��׷�� 20141222
    $defaultStr= getDefaultValue($action); //���Ĭ������
    $modI ='';//��ѭ��20150112
    $noFollow= aspTrim(strtolower(RParam($action, 'noFollow'))); //��׷��
    $lableTitle ='';//�������
    $target ='';//a���Ӵ�Ŀ�귽ʽ
    $adddatetime ='';//���ʱ��
    $isFocus ='';
    $fieldNameList ='';//�ֶ��б�
    $abcolorStr ='';//A�Ӵֺ���ɫ
    $atargetStr ='';//A���Ӵ򿪷�ʽ
    $atitleStr ='';//A���ӵ�title20160407
    $anofollowStr ='';//A���ӵ�nofollow
    $splFieldName=''; $fieldName=''; $replaceStr=''; $k ='';

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�');
    $splFieldName= aspSplit($fieldNameList, ',');

    $topNumb= RParam($action, 'topNumb') ; $nTop= $topNumb;
    if( $nTop <> '' ){
        $nTop= intval($nTop);
    }else{
        $nTop= 999;
    }
    if( $sql== '' ){
        if( $topNumb <> '' ){
            $topNumb= ' top ' . $topNumb . ' ';
        }
        $sql= 'Select ' . $topNumb . '* From ' . $GLOBALS['db_PREFIX'] . $tableName;
    }
    //׷��sql
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $sql= replaceGlobleVariable($sql); //�滻ȫ�ֱ���

    //���SQL
    if( checksql($sql)== false ){
        errorLog('������ʾ��<br>action=' . $action . '<hr>sql=' . $sql . '<br>');
        return '';
    }
    $rsObj=$GLOBALS['conn']->query( $sql);
    for( $i= 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $startStr= '' ; $endStr= '';
        //call echo(sql,i & "," & nTop)
        if( $i > $nTop ){
            break;
        }
        $rs=mysql_fetch_array($rsObj); //��PHP�ã���Ϊ�� asptophpת��������
        $isFocus= false; //����Ϊ��
        $id= $rs['id'];
        //��������
        if( $tableName== 'WebColumn' ){
            if( $GLOBALS['isMakeHtml']== true ){
                $url= getRsUrl($rs['filename'], $rs['customaurl'], '/nav' . $rs['id']);
            }else{
                $url= handleWebUrl('?act=nav&columnName=' . $rs['columnname']); //��׷��gl�Ȳ���
                if( $rs['customaurl'] <> '' ){
                    $url= $rs['customaurl'];
                    $url= replaceGlobleVariable($url);
                }
            }
            //ȫ����Ŀ����Ϊ����Ϊ�Զ���λ��ҳ ׷��(20160128)
            if( $GLOBALS['glb_columnName']== '' && $rs['columntype']== '��ҳ' ){
                $GLOBALS['glb_columnName']= $rs['columnname'];
            }
            if( $rs['columnname']== $GLOBALS['glb_columnName'] ){
                $isFocus= true;
            }
            //�����¡�
        }else if( $tableName== 'ArticleDetail' ){
            if( $GLOBALS['isMakeHtml']== true ){
                $url= getRsUrl($rs['filename'], $rs['customaurl'], 'detail/detail' . $rs['id']);
            }else{
                $url= handleWebUrl('?act=detail&id=' . $rs['id']); //��׷��gl�Ȳ���
                if( $rs['customaurl'] <> '' ){
                    $url= $rs['customaurl'];
                }
            }
            //����
        }else if( $tableName== 'TableComment' ){

        }

        //A���������ɫ
        $abcolorStr= '';
        if( instr($fieldNameList, ',titlecolor,') > 0 ){
            //A������ɫ
            if( $rs['titlecolor'] <> '' ){
                $abcolorStr= 'color:' . $rs['titlecolor'] . ';';
            }
        }
        if( instr($fieldNameList, ',flags,') > 0 ){
            //A���ӼӴ�
            if( instr($rs['flags'], '|b|') > 0 ){
                $abcolorStr= $abcolorStr . 'font-weight:bold;';
            }
        }
        if( $abcolorStr <> '' ){
            $abcolorStr= ' style="' . $abcolorStr . '"';
        }

        //�򿪷�ʽ2016
        if( instr($fieldNameList, ',target,') > 0 ){
            $atargetStr= IIF($rs['target'] <> '', ' target="' . $rs['target'] . '"', '');
        }

        //A��title
        if( instr($fieldNameList, ',title,') > 0 ){
            $atitleStr= IIF($rs['title'] <> '', ' title="' . $rs['title'] . '"', '');
        }

        //A��nofollow
        if( instr($fieldNameList, ',nofollow,') > 0 ){
            $anofollowStr= IIF($rs['nofollow'] <> 0, ' rel="nofollow"', '');
        }

        //�����ж�(����Ŀ�����õ�)
        if( $isFocus== true ){
            $startStr= '[list-focus]' ; $endStr= '[/list-focus]';
        }else{
            $startStr= '[list-' . $i . ']' ; $endStr= '[/list-' . $i . ']';
        }

        //�����ʱ����ǰ����20160202
        if( $i== $topNumb && $isFocus== false ){
            $startStr= '[list-end]' ; $endStr= '[/list-end]';
        }

        //��[list-mod2]  [/list-mod2]    20150112
        for( $modI= 6 ; $modI>= 2 ; $modI--){
            if( instr($defaultStr, $startStr)== false && $i % $modI== 0 ){
                $startStr= '[list-mod' . $modI . ']' ; $endStr= '[/list-mod' . $modI . ']';
                if( instr($defaultStr, $startStr) > 0 ){
                    break;
                }
            }
        }

        //û������Ĭ��
        if( instr($defaultStr, $startStr)== false ){
            $startStr= '[list]' ; $endStr= '[/list]';
        }


        if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
            $s= strCut($defaultStr, $startStr, $endStr, 2);

            $s= replaceValueParam($s, 'i', $i); //ѭ�����
            $s= replaceValueParam($s, '���', $i); //ѭ�����
            $s= replaceValueParam($s, 'id', $rs['id']); //id��� ��Ϊ����ֶ��������id
            $s= replaceValueParam($s, 'url', $url); //��ַ
            $s= replaceValueParam($s, 'aurl', 'href="' . $url . '"'); //��ַ
            $s= replaceValueParam($s, 'abcolor', $abcolorStr); //A���Ӽ���ɫ��Ӵ�
            $s= replaceValueParam($s, 'atitle', $atitleStr); //A����title
            $s= replaceValueParam($s, 'anofollow', $anofollowStr); //A����nofollow
            $s= replaceValueParam($s, 'atarget', $atargetStr); //A���Ӵ򿪷�ʽ



            for( $k= 0 ; $k<= UBound($splFieldName); $k++){
                if( $splFieldName[$k] <> '' ){
                    $fieldName= $splFieldName[$k];
                    $replaceStr= $rs[$fieldName] . '';
                    $s= replaceValueParam($s, $fieldName, $replaceStr);
                }
            }


            //��ʼλ�ü�Dialog����
            $startStr= '[list-' . $i . ' startdialog]' ; $endStr= '[/list-' . $i . ' startdialog]';
            if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
                $s= strCut($defaultStr, $startStr, $endStr, 2) . $s;
            }
            //����λ�ü�Dialog����
            $startStr= '[list-' . $i . ' enddialog]' ; $endStr= '[/list-' . $i . ' enddialog]';
            if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
                $s= $s . strCut($defaultStr, $startStr, $endStr, 2);
            }

            //�ӿ���
            //��������
            if( $tableName== 'WebColumn' ){
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11);
                //�����¡�
            }else if( $tableName== 'ArticleDetail' ){
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&parentid=&id=' . $rs['id'] . '&n=' . getRnd(11);

                $s= replaceValueParam($s, 'columnurl', getColumnUrl($rs['parentid'], '')); //���¶�Ӧ��ĿURL 20160304
                $s= replaceValueParam($s, 'columnname', getColumnName($rs['parentid'])); //���¶�Ӧ��Ŀ���� 20160304

            }
            $s= handleDisplayOnlineEditDialog($url, $s, '', 'div|li|span'); //�����Ƿ���������޸Ĺ�����
            $c= $c . $s;
        }
    }

    //��ʼ���ݼ�Dialog����
    $startStr= '[dialog start]' ; $endStr= '[/dialog start]';
    if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
        $c= strCut($defaultStr, $startStr, $endStr, 2) . $c;
    }
    //�������ݼ�Dialog����
    $startStr= '[dialog end]' ; $endStr= '[/dialog end]';
    if( instr($defaultStr, $startStr) > 0 && instr($defaultStr, $endStr) > 0 ){
        $c= $c . strCut($defaultStr, $startStr, $endStr, 2);
    }
    $XY_AP_GeneralList= $c;
    return @$XY_AP_GeneralList;
}


//�����ñ�����
function XY_handleGetTableBody($action, $tableName, $fieldParamName, $defaultFileName, $adminUrl){
    $url=''; $content=''; $id=''; $sql=''; $addSql=''; $fieldName=''; $fieldParamValue=''; $fieldNameList=''; $nLen=''; $delHtmlYes=''; $trimYes ='';
    $noisonhtml='';$intoFieldStr='';$valuesStr='';
    $fieldName= RParam($action, 'fieldname'); //�ֶ�����
    $noisonhtml= RParam($action, 'noisonhtml');					 //������html

    if( $noisonhtml=='true' ){
        $intoFieldStr=',isonhtml';
        $valuesStr=',0';
    }

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�');
    //�ֶ����Ʋ�Ϊ�գ�����Ҫ�ڱ��ֶ���
    if( $fieldName== '' || instr($fieldNameList, ',' . $fieldName . ',')== false ){
        $fieldName= $defaultFileName;
    }
    $fieldName= strtolower($fieldName); //תΪСд����Ϊ��PHP����ȫСд��

    $fieldParamValue= RParam($action, $fieldParamName); //��ȡ�ֶ�����
    $id= handleNumber(RParam($action, 'id')); //���ID
    $addSql= ' where ' . $fieldParamName . '=\'' . $fieldParamValue . '\'';
    if( $id <> '' ){
        $addSql= ' where id=' . $id;
    }

    $content= getDefaultValue($action); //���Ĭ������
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . $addSql;
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        //�Զ���� 20160113
        if( RParam($action, 'autoadd')== 'true' ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . $tableName . ' (' . $fieldParamName . ',' . $fieldName . $intoFieldStr . ') values(\'' . $fieldParamValue . '\',\'' . ADSql($content) . '\''. $valuesStr .')');
        }
    }else{
        $id= $rs['id'];
        $content= $rs[$fieldName];
    }

    //ɾ��Html
    $delHtmlYes= RParam($action, 'delHtml'); //�Ƿ�ɾ��Html
    if( $delHtmlYes== 'true' ){ $content= Replace(delHtml($content), '<', '&lt;') ;}//HTML����
    //ɾ�����߿ո�
    $trimYes= RParam($action, 'trim'); //�Ƿ�ɾ�����߿ո�
    if( $trimYes== 'true' ){ $content= trimVbCrlf($content) ;}

    //��ȡ�ַ�����
    $nLen= RParam($action, 'len'); //�ַ�����ֵ
    $nLen= handleNumber($nLen);
    //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
    if( $nLen <> '' ){ $content= cutStr($content, $nLen, '...') ;}//Left(ReplaceStr,nLen)


    if( $id== '' ){
        $id= XY_AP_GetFieldValue('', $sql, 'id');
    }
    $url= $adminUrl . '&id=' . $id . '&n=' . getRnd(11);
    if( @$_REQUEST['gl']== 'edit' ){
        $content= '<span>' . $content . '</span>';
    }

    //call echo(sql,url)
    $content= handleDisplayOnlineEditDialog($url, $content, '', 'span');
    $XY_handleGetTableBody= $content;

    return @$XY_handleGetTableBody;
}

//��õ�ҳ����
function XY_AP_GetOnePageBody($action){
    $adminUrl ='';
    $adminUrl= WEB_ADMINURL . '?act=addEditHandle&actionType=OnePage&lableTitle=��ҳ����&nPageSize=10&page=&switchId=2';
    $XY_AP_GetOnePageBody= XY_handleGetTableBody($action, 'onepage', 'title', 'bodycontent', $adminUrl);
    return @$XY_AP_GetOnePageBody;
}

//��õ�������
function XY_AP_GetColumnBody($action){
    $adminUrl ='';
    $adminUrl= WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&switchId=2';
    $XY_AP_GetColumnBody= XY_handleGetTableBody($action, 'webcolumn', 'columnname', 'bodycontent', $adminUrl);
    return @$XY_AP_GetColumnBody;
}

//��ʾ��������
function XY_AP_GetArticleBody($action){
    $adminUrl ='';
    $adminUrl= WEB_ADMINURL . '?act=addEditHandle&actionType=ArticleDetail&lableTitle=������Ϣ&nPageSize=10&page=&switchId=2';
    $XY_AP_GetArticleBody= XY_handleGetTableBody($action, 'articledetail', 'title', 'bodycontent', $adminUrl);
    return @$XY_AP_GetArticleBody;
}


//�����ĿURL
function XY_GetColumnUrl($action){
    $columnName=''; $url ='';
    $columnName= RParam($action, 'columnName');
    $url= getColumnUrl($columnName, 'name');
    //handleWebUrl  �ж�gl����

    //If Request("gl") <> "" Then
    //    url = url & "&gl=" & Request("gl")
    //End If
    $XY_GetColumnUrl= $url;

    return @$XY_GetColumnUrl;
}

//�������URL
function XY_GetArticleUrl($action){
    $title=''; $url ='';
    $title= RParam($action, 'title');
    $url= getArticleUrl($title);
    //If Request("gl") <> "" Then
    //    url = url & "&gl=" & Request("gl")
    //End If
    $XY_GetArticleUrl= $url;
    return @$XY_GetArticleUrl;
}

//��õ�ҳURL
function XY_GetOnePageUrl($action){
    $title=''; $url ='';
    $title= RParam($action, 'title');
    $url= getOnePageUrl($title);
    //If Request("gl") <> "" Then
    //    url = url & "&gl=" & Request("gl")
    //End If
    $XY_GetOnePageUrl= $url;
    return @$XY_GetOnePageUrl;
}


//��õ����ֶ�����
function XY_AP_GetFieldValue($action, $sql, $fieldName){
    $title=''; $content ='';
    $rsObj=$GLOBALS['conn']->query( $sql);
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $content= $rs[$fieldName];
    }
    $XY_AP_GetFieldValue= $content;
    return @$XY_AP_GetFieldValue;
}


//Js����վͳ��
function XY_JsWebStat($action){
    $s=''; $fileName=''; $sType ='';
    $sType= RParam($action, 'stype');
    $fileName= aspTrim(RParam($action, 'fileName'));
    if( $fileName== '' ){
        $fileName= '[$WEB_VIEWURL$]?act=webstat&stype=' . $sType;
    }
    $fileName= Replace($fileName, '/', '\\/');
    $s= '<script>document.writeln("<script src=\\\'' . $fileName . '&GoToUrl="';
    $s= $s . '+escape(document.referrer)+"&ThisUrl="+escape(window.location.href)+"&screen="+escape(window.screen.width+"x"+window.screen.height)';
    $s= $s . '+"&co="+escape(document.cookie)'; //�ռ�cookie ����Ҫ�����ε�
    $s= $s . '+" \\\'><\\/script>");</script>';
    $XY_JsWebStat= $s;
    return @$XY_JsWebStat;
}



//��ͨ����A
function XY_HrefA($action){
    $content=''; $Href=''; $c=''; $AContent=''; $AType=''; $url=''; $title ='';
    $action= handleInModule($action, 'start');
    $content= RParam($action, 'Content');
    $AType= RParam($action, 'Type');
    if( $AType== '�ղ�' ){
        //��һ�ַ���
        //Url = "window.external.addFavorite('"& WebUrl &"','"& WebTitle &"')"
        $url= 'shoucang(document.title,window.location)';
        $c= '<a href=\'javascript:;\' onClick="' . $url . '" ' . setHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>';
    }else if( $AType== '��Ϊ��ҳ' ){
        //��һ�ַ���
        //Url = "var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('"& WebUrl &"');"
        $url= 'SetHome(this,window.location)';
        $c= '<a href=\'javascript:;\' onClick="' . $url . '"' . setHtmlParam($action, 'target|title|alt|id|class|style') . '>' . $content . '</a>';
    }else{
        $content= RParam($action, 'Title');
    }

    $content= handleInModule($content, 'end');
    if( $c== '' ){ $c= '<a' . setHtmlParam($action, 'href|target|title|alt|id|class|rel|style') . '>' . $content . '</a>' ;}

    $XY_HrefA= $c;
    return @$XY_HrefA;
}



//����20151231
function XY_Layout($action){
    $layoutName=''; $s=''; $c=''; $sourceStr=''; $replaceStr=''; $splSource=''; $splReplace=''; $i ='';

    $layoutName= RParam($action, 'layoutname');
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'weblayout where layoutname=\'' . $layoutName . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $c= $rs['bodycontent'];

        $sourceStr= $rs['sourcestr']; //Դ���� ���滻����
        $replaceStr= $rs['replacestr']; //�滻����
        $splSource= aspSplit($sourceStr, '[Array]'); //Դ��������
        $splReplace= aspSplit($replaceStr, '[Array]'); //�滻��������

        for( $i= 0 ; $i<= UBound($splSource); $i++){
            $sourceStr= $splSource[$i];
            $replaceStr= $splReplace[$i];
            if( $sourceStr <> '' ){
                $c= Replace($c, $sourceStr, $replaceStr);
                //call echo(sourceStr,replaceStr)
                //call echo(c,instr(c,sourcestr))
            }
        }
        //call rwend(c)
    }
    $XY_Layout= $c;
    return @$XY_Layout;
}

//ģ��20151231
function XY_Module($action){
    $moduleName=''; $s=''; $c=''; $sourceStr=''; $replaceStr=''; $splSource=''; $splReplace=''; $i ='';
    $moduleName= RParam($action, 'modulename');
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webmodule where modulename=\'' . $moduleName . '\'');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)!=0 ){
        $c= $rs['bodycontent'];

        $sourceStr= RParam($action, 'sourceStr'); //Դ���� ���滻����
        $replaceStr= RParam($action, 'replaceStr'); //�滻����

        $splSource= aspSplit($sourceStr, '[Array]'); //Դ��������
        $splReplace= aspSplit($replaceStr, '[Array]'); //�滻��������

        for( $i= 0 ; $i<= UBound($splSource); $i++){
            $sourceStr= $splSource[$i];
            $replaceStr= $splReplace[$i];
            if( $sourceStr <> '' ){
                $c= Replace($c, $sourceStr, $replaceStr);
                //call echo(sourceStr,replaceStr)
                //call echo(c,instr(c,sourcestr))
            }
        }
        //call rwend(c)
    }
    $XY_Module= $c;
    return @$XY_Module;
}

//��ʾ������20160127
function XY_DisplayWrap( $action){
    $content ='';
    $content= getDefaultValue($action);
    $XY_DisplayWrap= $content;
    return @$XY_DisplayWrap;
}




//Ƕ�ױ��� ����
function XY_getLableValue($action){
    $title=''; $content=''; $c ='';
    //call echo("Action",Action)
    $title= RParam($action, 'title');
    $content= RParam($action, 'content');
    $c= $c . 'title=' . getContentRunStr($title) . '<hr>';
    $c= $c . 'content=' . getContentRunStr($content) . '<hr>';
    $XY_getLableValue= $c;
    ASPEcho('title', $title);
    $XY_getLableValue= '��title=����' . $title . '��';
    return @$XY_getLableValue;
}
//���������������������б�
function XY_TitleInSearchEngineList($action){
    $title=''; $sType='';$divclass='';$spanclass='';$s='';$c='';

    $title= RParam($action, 'title');
    $sType= RParam($action, 'sType');
    $divclass= RParam($action, 'divclass');
    $spanclass= RParam($action, 'spanclass');

    $s='<strong>������ڡ�' . $title . '��</strong>';
    if( $divclass<>'' ){
        $s='<div class="'. $divclass .'">'. $s .'</div>';
    }else if( $spanclass<>'' ){
        $s='<span class="'. $spanclass .'">'. $s .'</span>' . '<br>';
    }else{
        $s=$s . '<br>';
    }
    $c= $c . $s . vbCrlf();
    $c= $c . '<ul class="list"> ' . vbCrlf();
    $c= $c . '<li><a href="https://www.baidu.com/s?ie=gb2312&word=' . $title . '" rel="nofollow" target="_blank">��baidu�������ڰٶ�������(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="http://www.haosou.com/s?ie=gb2312&q=' . $title . '" rel="nofollow" target="_blank">��haosou�������ں���������(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="https://search.yahoo.com/search;_ylt=A86.JmbkJatWH5YARmebvZx4?toggle=1&cop=mss&ei=gb2312&fr=yfp-t-901&fp=1&p=' . $title . '" rel="nofollow" target="_blank">��yahoo���������Ż�������(' . $title . ')</a></li>' . vbCrlf();

    $c= $c . '<li><a href="https://www.sogou.com/sogou?ie=utf8&query=' . GBtoUTF8($title) . '" rel="nofollow" target="_blank">��sogou���������ѹ�������(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="http://www.youdao.com/search?ue=utf8&q=' . GBtoUTF8($title) . '" rel="nofollow" target="_blank">��youdao���������е�������(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '<li><a href="http://search.yam.com/Search/Web/DefaultKSA.aspx?SearchType=web&l=0&p=0&k=' . GBtoUTF8($title) . '" rel="nofollow" target="_blank">��yam����(google�ṩ����)����ެ����������(' . $title . ')</a></li>' . vbCrlf();


    $c= $c . '<li><a href="http://cn.bing.com/search?q=' . GBtoUTF8($title) . '" rel="nofollow" target="_blank">��bing�������ڱ�Ӧ������(' . $title . ')</a></li>' . vbCrlf();
    $c= $c . '</ul>' . vbCrlf();

    $XY_TitleInSearchEngineList= $c;
    return @$XY_TitleInSearchEngineList;
}

//URL����
function XY_escape($action){
    $content ='';
    $content= RParam($action, 'content');
    $XY_escape= escape($content);
    return @$XY_escape;
}
//URL����
function XY_unescape($action){
    $content ='';
    $content= RParam($action, 'content');
    $XY_unescape= escape($content);
    return @$XY_unescape;
}
//�����ַ
function XY_getUrl($action){
    $stype ='';
    $stype= RParam($action, 'stype');
    $XY_getUrl=getThisUrlNoParam();
    return @$XY_getUrl;
}
?>