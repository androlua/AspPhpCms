<?PHP
//��̨�������ĳ��� ��� ɾ�� �޸� �б�

//����function�ļ�����
function callFunction(){
    switch ( @$_REQUEST['stype'] ){
        case 'updateWebsiteStat' ; updateWebsiteStat() ;break;//������վͳ��
        case 'clearWebsiteStat' ; clearWebsiteStat() ;break;//�����վͳ��
        case 'updateTodayWebStat' ; updateTodayWebStat() ;break;//������վ����ͳ��
        case 'websiteDetail' ; websiteDetail() ;break;//��ϸ��վͳ��
        case 'displayAccessDomain' ; displayAccessDomain()										;break;//��ʾ��������
        case 'delTemplate' ; delTemplate();										//ɾ��ģ��


        break;
        default ; Eerr('function1ҳ��û�ж���', @$_REQUEST['stype']);
    }
}

//��ʾ��������
function displayAccessDomain(){
    $visitWebSite='';$visitWebSiteList='';$urlList='';$nOK='';
    handlePower('��ʾ��������');
    $GLOBALS['conn=']=OpenConn();
    $nOK=0;
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'websitestat');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $visitWebSite=lCase(getWebSite($rs['visiturl']));
        //call echo("visitWebSite",visitWebSite)
        if( inStr(vbCrlf() . $visitWebSiteList . vbCrlf(),vbCrlf() . $visitWebSite . vbCrlf())==false ){
            if( $visitWebSite<>lCase(getWebSite(webDoMain())) ){
                $visitWebSiteList=$visitWebSiteList . $visitWebSite . vbCrlf();
                $nOK=$nOK+1;
                $urlList=$urlList . $nOK . '��<a href=\'' . $rs['visiturl'] . '\' target=\'_blank\'>' . $rs['visiturl'] . '</a><br>';
            }
        }
    }
    aspEcho('��ʾ��������','������� <a href=\'javascript:history.go(-1)\'>�������</a>');
    rwEnd($visitWebSiteList . '<br><hr><br>' . $urlList);
}
//��ô������б� 20160313
function getHandleTableList(){
    $s=''; $lableStr ='';
    $lableStr= '���б�[' . @$_REQUEST['mdbpath'] . ']';
    if( $GLOBALS['WEB_CACHEContent']== '' ){
        $GLOBALS['WEB_CACHEContent']= getFText($GLOBALS['WEB_CACHEFile']);
    }
    $s= getConfigContentBlock($GLOBALS['WEB_CACHEContent'], '#' . $lableStr . '#');
    if( $s== '' ){
        $s= lCase(getTableList());
        $s= '|' . replace($s, vbCrlf(), '|') . '|';
        $GLOBALS['WEB_CACHEContent']= setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $s, '#' . $lableStr . '#');
        if( $GLOBALS['isCacheTip']==true ){
            aspEcho('����', $lableStr);
        }
    }
    $getHandleTableList= $s;
    return @$getHandleTableList;
}

//��ô�����ֶ��б�   getHandleFieldList("ArticleDetail","�ֶ��б�")
function getHandleFieldList($tableName, $sType){
    $s ='';
    if( $GLOBALS['WEB_CACHEContent']== '' ){
        $GLOBALS['WEB_CACHEContent']= getFText($GLOBALS['WEB_CACHEFile']);
    }
    $s= getConfigContentBlock($GLOBALS['WEB_CACHEContent'], '#' . $tableName . $sType . '#');

    if( $s== '' ){
        if( $sType== '�ֶ������б�' ){
            $s= lCase(getFieldConfigList($tableName));
        }else{
            $s= lCase(getFieldList($tableName));
        }
        $GLOBALS['WEB_CACHEContent']= setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $s, '#' . $tableName . $sType . '#');
        if( $GLOBALS['isCacheTip']==true ){
            aspEcho('����', $tableName . $sType);
        }
    }
    $getHandleFieldList= $s;
    return @$getHandleFieldList;
}
//��ģ������ 20160310
function getTemplateContent($templateFileName){
    loadWebConfig();
    //��ģ��
    $templateFile=''; $customTemplateFile=''; $c='';
    $customTemplateFile= ROOT_PATH . 'template/' . $GLOBALS['db_PREFIX'] . '/' . $templateFileName;
    //Ϊ�ֻ���
    if( CheckMobile()== true || @$_REQUEST['m']=='mobile' ){
        $templateFile= ROOT_PATH . '/Template/mobile/' . $templateFileName;
    }
    //�ж��ֻ����ļ��Ƿ����20160330
    if( CheckFile($templateFile)== false ){
        if( CheckFile($customTemplateFile)== true ){
            $templateFile= $customTemplateFile;
        }else{
            $templateFile= ROOT_PATH . $templateFileName;
        }
    }
    $c= getFText($templateFile);
    $c= replaceLableContent($c);
    $getTemplateContent= $c;
    return @$getTemplateContent;
}
//�滻��ǩ����
function replaceLableContent($content){
    $s='';$c='';$splstr='';$list='';
    $content= replace($content, '{$webVersion$}', $GLOBALS['webVersion']); //��վ�汾
    $content= replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']); //��վ����
    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //ASP��PHP
    $content= replace($content, '{$adminDir$}', $GLOBALS['adminDir']); //��̨Ŀ¼

    $content= replace($content, '[$adminId$]', @$_SESSION['adminId']); //����ԱID
    $content= replace($content, '{$adminusername$}', @$_SESSION['adminusername']); //�����˺�����
    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //��������
    $content= replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL); //ǰ̨
    $content= replace($content, '{$webVersion$}', $GLOBALS['webVersion']); //�汾
    $content= replace($content, '{$WebsiteStat$}', getConfigFileBlock($GLOBALS['WEB_CACHEFile'], '#�ÿ���Ϣ#')); //����ÿ���Ϣ


    $content= replace($content, '{$DB_PREFIX$}', $GLOBALS['db_PREFIX']); //��ǰ׺
    $content= replace($content, '{$adminflags$}', IIF(@$_SESSION['adminflags']== '|*|', '��������Ա', '��ͨ����Ա')); //����Ա����
    $content= replace($content, '{$SERVER_SOFTWARE$}', serverVariables('SERVER_SOFTWARE')); //�������汾
    $content= replace($content, '{$SERVER_NAME$}', serverVariables('SERVER_NAME')); //��������ַ
    $content= replace($content, '{$LOCAL_ADDR$}', serverVariables('LOCAL_ADDR')); //������IP
    $content= replace($content, '{$SERVER_PORT$}', serverVariables('SERVER_PORT')); //�������˿�
    $content= replaceValueParam($content, 'mdbpath', @$_REQUEST['mdbpath']);
    $content= replaceValueParam($content, 'webDir', $GLOBALS['webDir']);

    //20160628
    if( inStr($content,'{$backupDatabaseSelectHtml$}')>0 ){
        $c=getDirTxtNameList($GLOBALS['adminDir'] . '/Data/BackUpDateBases/');
        $splstr=aspSplit($c,vbCrlf());
        foreach( $splstr as $key=>$s){
            $list=$list . '<option value="'. $s .'">'. $s .'</option>' . vbCrlf();
        }
        $content=replace($content,'{$backupDatabaseSelectHtml$}',$list);
    }

    //20160614
    if( EDITORTYPE=='php' ){
        $content= replace($content, '{$EDITORTYPE_PHP$}', 'php'); //��phpinc/��
    }
    $content= replace($content, '{$EDITORTYPE_PHP$}', ''); //��phpinc/��

    $replaceLableContent= $content;
    return @$replaceLableContent;
}

//�����б���
function displayFlags($flags){
    $c ='';
    //ͷ��[h]
    if( inStr('|' . $flags . '|', '|h|') > 0 ){
        $c= $c . 'ͷ ';
    }
    //�Ƽ�[c]
    if( inStr('|' . $flags . '|', '|c|') > 0 ){
        $c= $c . '�� ';
    }
    //�õ�[f]
    if( inStr('|' . $flags . '|', '|f|') > 0 ){
        $c= $c . '�� ';
    }
    //�ؼ�[a]
    if( inStr('|' . $flags . '|', '|a|') > 0 ){
        $c= $c . '�� ';
    }
    //����[s]
    if( inStr('|' . $flags . '|', '|s|') > 0 ){
        $c= $c . '�� ';
    }
    //�Ӵ�[b]
    if( inStr('|' . $flags . '|', '|b|') > 0 ){
        $c= $c . '�� ';
    }
    if( $c <> '' ){ $c= '[<font color="red">' . $c . '</font>]' ;}

    $displayFlags= $c;
    return @$displayFlags;
}


//��Ŀ���ѭ������        showColumnList(parentid, "webcolumn", ,"",0, defaultStr,3,"")   nCountΪ���ֵ   thisPIdΪ�����id
function showColumnList( $parentid, $tableName, $showFieldName, $thisPId, $nCount, $action){
    $i=''; $s=''; $c=''; $selectcolumnname=''; $selStr=''; $url=''; $isFocus=''; $sql=''; $addSql='';$listLableStr='';$topnav='';
    $thisColumnName='';$navheaderStr='';$navfooterStr='';
    $parentid=aspTrim($parentid);
    $listLableStr='list';

    $topnav= getStrCut($action, '[topnav]', '[/topnav]', 2);
    $thisColumnName=getColumnName($parentid);
    //call echo(parentid,topnav)

    if( $parentid<>$topnav ){
        if( inStr($action,'[small-list')>0 ){
            $listLableStr='small-list';
        }
    }
    //call echo("listLableStr",listLableStr)

    $fieldNameList=''; $splFieldName=''; $k=''; $fieldName=''; $replaceStr=''; $startStr=''; $endStr=''; $topNumb=''; $modI='';$title='';
    $subHeaderStr=''; $subFooterStr='';$subHeaderStartStr='';$subHeaderEndStr='';$subFooterStartStr='';$subFooterEndStr='';


    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�');
    $splFieldName= aspSplit($fieldNameList, ',');
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' where parentid=' . $parentid;
    //  call echo("sql1111111111111",tableName)
    //����׷��SQL
    $startStr= '[sql-' . $nCount . ']' ; $endStr= '[/sql-' . $nCount . ']';
    if( inStr($action, $startStr)== false && inStr($action, $endStr)== false ){
        $startStr= '[sql]' ; $endStr= '[/sql]';
    }
    $addSql= getStrCut($action, $startStr, $endStr, 2);
    if( $addSql <> '' ){
        $sql= getWhereAnd($sql, $addSql);
    }
    $rsObj=$GLOBALS['conn']->query( $sql . ' order by sortrank asc');
    //call echo(sql,rs.recordcount)
    for( $i= 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $startStr= '' ; $endStr= '';
            $selStr= '';
            $isFocus= false;
            if( cStr($rs['id'])== cStr($thisPId) ){
                $selStr= ' selected ';
                $isFocus= true;
            }
            //��ַ�ж�
            if( $isFocus== true ){
                $startStr= '['. $listLableStr .'-focus]' ; $endStr= '[/'. $listLableStr .'-focus]';
            }else{

                $startStr= '['. $listLableStr .'-' . $thisColumnName . ']' ; $endStr= '[/'. $listLableStr .'-' . $thisColumnName . ']';

                if( inStr($action, $startStr)== false && inStr($action,$endStr)==false ){
                    $startStr= '['. $listLableStr .'-' . $i . ']' ; $endStr= '[/'. $listLableStr .'-' . $i . ']';
                }else{
                    //call echo(rs("columnname"),startStr)
                }
            }

            //�����ʱ����ǰ����20160202
            if( $i== $topNumb && $isFocus== false ){
                $startStr= '['. $listLableStr .'-end]' ; $endStr= '[/'. $listLableStr .'-end]';
            }
            //��[list-mod2]  [/list-mod2]    20150112
            for( $modI= 6 ; $modI>= 2 ; $modI--){
                if( inStr($action, $startStr)== false && $i % $modI== 0 ){
                    $startStr= '['. $listLableStr .'-mod' . $modI . ']' ; $endStr= '[/'. $listLableStr .'-mod' . $modI . ']';
                    if( inStr($action, $startStr) > 0 ){
                        break;
                    }
                }
            }

            //û������Ĭ��
            if( inStr($action, $startStr)== false && inStr($action,$endStr)==false ){
                $startStr= '['. $listLableStr .']' ; $endStr= '[/'. $listLableStr .']';
            }
            //call rwend(action)
            //call echo(startStr,endStr)
            if( inStr($action, $startStr) > 0 && inStr($action, $endStr) > 0 ){
                $s= StrCut($action, $startStr, $endStr, 2);

                $s= replaceValueParam($s, 'id', $rs['id']);
                $s= replaceValueParam($s, 'selected', $selStr);
                $selectcolumnname= $rs[$showFieldName] ;$title=$selectcolumnname;
                if( $nCount >= 1 ){
                    $selectcolumnname= copyStr('&nbsp;&nbsp;', $nCount) . '����' . $selectcolumnname;
                }
                $s= replaceValueParam($s, 'selectcolumnname', $selectcolumnname);
                $s= replaceValueParam($s, 'title', $title);


                for( $k= 0 ; $k<= uBound($splFieldName); $k++){
                    if( $splFieldName[$k] <> '' ){
                        $fieldName= $splFieldName[$k];
                        $replaceStr= $rs[$fieldName] . '';

                        $s= replaceValueParam($s, $fieldName, $replaceStr);
                    }
                }

                //url = WEB_VIEWURL & "?act=nav&columnName=" & rs(showFieldName)             '����Ŀ������ʾ�б�
                $url= WEB_VIEWURL . '?act=nav&id=' . $rs['id']; //����ĿID��ʾ�б�



                //�Զ�����ַ
                if( aspTrim($rs['customaurl']) <> '' ){
                    $url= aspTrim($rs['customaurl']);
                }
                $s= replace($s, '[$viewWeb$]', $url);
                $s= replaceValueParam($s, 'url', $url);

                //��վ��Ŀû��pageλ�ô��� ׷����20160716 home
                $url= WEB_ADMINURL . '?act=addEditHandle&actionType=WebColumn&lableTitle=��վ��Ŀ&nPageSize=10&page=&id=' . $rs['id'] . '&n=' . getRnd(11);
                $s= handleDisplayOnlineEditDialog($url, $s, '', 'div|li|span'); //�����Ƿ���������޸Ĺ�����


                if( EDITORTYPE== 'php' ){
                    $s= replace($s, '[$phpArray$]', '[]');
                }else{
                    $s= replace($s, '[$phpArray$]', '');
                }

                //s=copystr("",nCount) & rs("columnname") & "<hr>"
                if( $rs['parentid']=='-1' && inStr($action,'[navheader]')>0 ){
                    $navheaderStr= getStrCut($action, '[navheader]', '[/navheader]', 2);
                    $navfooterStr= getStrCut($action, '[navfooter]', '[/navfooter]', 2);
                    //call die(navfooterStr)
                }
                $c= $c . $navheaderStr . $s . vbCrlf();
                $s= showColumnList($rs['id'], $tableName, $showFieldName, $thisPId, $nCount + 1, $action) . $navfooterStr;


                $subHeaderStartStr='[subheader-'. $rs['columnname'] .']' ;$subHeaderEndStr='[/subheader-'. $rs['columnname'] .']';
                if( inStr($action,$subHeaderStartStr)==false && inStr($action,$subHeaderEndStr)==false ){
                    $subHeaderStartStr='[subheader]' ;$subHeaderEndStr='[/subheader]';

                }
                $subFooterStartStr='[subfooter-'. $rs['columnname'] .']' ; $subFooterEndStr='[/subfooter-'. $rs['columnname'] .']';
                if( inStr($action,$subFooterStartStr)==false && inStr($action,$subFooterStartStr)==false ){
                    $subFooterStartStr='[subfooter]' ;$subFooterEndStr='[/subfooter]';
                }
                $subHeaderStr= getStrCut($action, $subHeaderStartStr, $subHeaderEndStr, 2);
                $subFooterStr= getStrCut($action, $subFooterStartStr, $subFooterEndStr, 2);
                //call echo(rs("columnname"),"����")

                if( $s <> '' ){ $s= vbCrlf() . $subHeaderStr . $s . $subFooterStr ;}
                $c= $c . $s;
            }
        }
    }
    $showColumnList= $c;
    return @$showColumnList;
}
//msg1  ����
function getMsg1($msgStr, $url){
    $content ='';
    $content= getFText(ROOT_PATH . 'msg.html');
    $msgStr= $msgStr . '<br>' . jsTiming($url, 5);
    $content= replace($content, '[$msgStr$]', $msgStr);
    $content= replace($content, '[$url$]', $url);


    $content= replaceL($content, '��ʾ��Ϣ');
    $content= replaceL($content, '������������û���Զ���ת����������');
    $content= replaceL($content, '����ʱ');


    $getMsg1= $content;
    return @$getMsg1;
}

//���Ȩ��
function checkPower($powerName){
    if( @$_SESSION['adminId']<>'' ){
        $GLOBALS['conn=']=OpenConn();			//�����ݿ� Ҫ��Ȼ��php������
        //����������������ʱ��
        $rssObj=$GLOBALS['conn']->query('select * from ' . $GLOBALS['db_PREFIX'] . 'admin where id=' . @$_SESSION['adminId']);
        if( @mysql_num_rows($rssObj)!=0 ){
            $rss=mysql_fetch_array($rssObj);
            @$_SESSION['adminflags']=$rss['flags'];
        }
        if( inStr('|' . @$_SESSION['adminflags'] . '|', '|' . $powerName . '|') > 0 || inStr('|' . @$_SESSION['adminflags'] . '|', '|*|') > 0 ){
            $checkPower= true;
        }else{
            $checkPower= false;
        }
    }else{
        $checkPower= true;
    }
    return @$checkPower;
}
//�����̨����Ȩ��
function handlePower($powerName){
    if( checkPower($powerName)== false ){
        Eerr('��ʾ', '��û�С�' . $powerName . '��Ȩ�ޣ�<a href=\'javascript:history.go(-1);\'>�������</a>');
    }
}
//��ʾ�����б�
function dispalyManage($actionName, $lableTitle, $nPageSize, $addSql){
    handlePower('��ʾ' . $lableTitle); //����Ȩ�޴���
    loadWebConfig();
    $content=''; $i=''; $s=''; $c=''; $fieldNameList=''; $sql=''; $action ='';
    $x=''; $url=''; $nCount=''; $nPage ='';
    $idInputName ='';

    $tableName=''; $j=''; $splxx ='';
    $fieldName ='';//�ֶ�����
    $splFieldName ='';//�ָ��ֶ�
    $searchfield=''; $keyWord ='';//�����ֶΣ������ؼ���
    $parentid ='';//��Ŀid

    $replaceStr ='';//�滻�ַ�
    $tableName= lCase($actionName); //������

    $searchfield= @$_REQUEST['searchfield']; //��������ֶ�ֵ
    $keyWord= @$_REQUEST['keyword']; //��������ؼ���ֵ
    if( @$_POST['parentid'] <> '' ){
        $parentid= @$_POST['parentid'];
    }else{
        $parentid= @$_GET['parentid'];
    }

    $id ='';
    $focusid 						='';//���жϴ�������id�Ƿ��ڵ�ǰ�б����ǽ���20160715 home
    $id= rq('id');
    $focusid= rq('focusid');

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�');

    $fieldNameList= specialStrReplace($fieldNameList); //�����ַ�����
    $splFieldName= aspSplit($fieldNameList, ','); //�ֶηָ������

    //��ģ��
    $content= getTemplateContent('manage_' . $tableName . '.html');

    $action= getStrCut($content, '[list]', '[/list]', 2);
    //��վ��Ŀ��������      ��Ŀ��һ��20160301
    if( $actionName== 'WebColumn' ){
        $action= getStrCut($content, '[action]', '[/action]', 1);
        $content= replace($content, $action, showColumnList( -1, 'WebColumn', 'columnname', '', 0, $action));
    }else if( $actionName== 'ListMenu' ){
        $action= getStrCut($content, '[action]', '[/action]', 1);
        $content= replace($content, $action, showColumnList( -1, 'listmenu', 'title', '', 0, $action));
    }else{
        if( $keyWord <> '' && $searchfield <> '' ){
            $addSql= getWhereAnd(' where ' . $searchfield . ' like \'%' . $keyWord . '%\' ', $addSql);
        }
        if( $parentid <> '' ){
            $addSql= getWhereAnd(' where parentid=' . $parentid . ' ', $addSql);
        }
        //call echo(tableName,addsql)
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . $tableName . ' ' . $addSql;
        //���SQL
        if( checkSql($sql)== false ){
            errorLog('������ʾ��<br>action=' . $action . '<hr>sql=' . $sql . '<br>');
            return '';
        }
        $rsObj=$GLOBALS['conn']->query( $sql);

        $nCount= @mysql_num_rows($rsObj);
        $nPage= @$_REQUEST['page'];
        $content= replace($content, '[$pageInfo$]', webPageControl($nCount, $nPageSize, $nPage, $url, ''));
        $content= replace($content, '[$accessSql$]', $sql);

        if( EDITORTYPE== 'asp' ){
            $x= getRsPageNumber($rs, $nCount, $nPageSize, $nPage); //���Rsҳ��                                                  '��¼����
        }else{
            if( $nPage <> '' ){
                $nPage= $nPage - 1;
            }
            $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' ' . $addSql . ' limit ' . $nPageSize * $nPage . ',' . $nPageSize;
            $rsObj=$GLOBALS['conn']->query( $sql);

            $x= @mysql_num_rows($rsObj);
        }
        for( $i= 1 ; $i<= $x; $i++){
            $rs=mysql_fetch_array($rsObj); //��PHP�ã���Ϊ�� asptophpת��������  ����
            $s= replace($action, '[$id$]', $rs['id']);
            for( $j= 0 ; $j<= uBound($splFieldName); $j++){
                if( $splFieldName[$j] <> '' ){
                    $splxx= aspSplit($splFieldName[$j] . '|||', '|');
                    $fieldName= $splxx[0];
                    $replaceStr= $rs[$fieldName] . '';
                    //�������촦��
                    if( $fieldName== 'flags' ){
                        $replaceStr= displayFlags($replaceStr);
                    }
                    //call echo("fieldname",fieldname)
                    //s = Replace(s, "[$" & fieldName & "$]", replaceStr)
                    $s= replaceValueParam($s, $fieldName, $replaceStr);

                }
            }

            $idInputName= 'id';
            $s= replace($s, '[$selectid$]', '<input type=\'checkbox\' name=\'' . $idInputName . '\' id=\'' . $idInputName . '\' value=\'' . $rs['id'] . '\' >');
            $s= replace($s, '[$phpArray$]', '');
            $url= '��NO��';
            if( $actionName== 'ArticleDetail' ){
                $url= WEB_VIEWURL . '?act=detail&id=' . $rs['id'];
            }else if( $actionName== 'OnePage' ){
                $url= WEB_VIEWURL . '?act=onepage&id=' . $rs['id'];
                //�����ۼ�Ԥ��=����  20160129
            }else if( $actionName== 'TableComment' ){
                $url= WEB_VIEWURL . '?act=detail&id=' . $rs['itemid'];
            }
            //�������Զ����ֶ�
            if( inStr($fieldNameList, 'customaurl') > 0 ){
                //�Զ�����ַ
                if( aspTrim($rs['customaurl']) <> '' ){
                    $url= aspTrim($rs['customaurl']);
                }
            }
            $s= replace($s, '[$viewWeb$]', $url);
            $s= replaceValueParam($s, 'cfg_websiteurl', $GLOBALS['cfg_webSiteUrl']);
            //call echo(focusid & "/" & rs("id"),IIF(focusid=cstr(rs("id")),"true","false"))
            $s= replaceValueParam($s, 'focusid', $focusid);

            $c= $c . $s;




        }
        $content= replace($content, '[list]' . $action . '[/list]', $c);
        //���ύ����parentid(��ĿID) searchfield(�����ֶ�) keyword(�ؼ���) addsql(����)
        $url= '?page=[id]&addsql=' . @$_REQUEST['addsql'] . '&keyword=' . @$_REQUEST['keyword'] . '&searchfield=' . @$_REQUEST['searchfield'] . '&parentid=' . @$_REQUEST['parentid'];
        $url= getUrlAddToParam(getUrl(), $url, 'replace');
        //call echo("url",url)
        $content= replace($content, '[list]' . $action . '[/list]', $c);

    }

    if( inStr($content, '[$input_parentid$]') > 0 ){
        $action= '[list]<option value="[$id$]"[$selected$]>[$selectcolumnname$]</option>[/list]';
        $c= '<select name="parentid" id="parentid"><option value="">�� ѡ����Ŀ ��</option>' . showColumnList( -1, 'webcolumn', 'columnname', $parentid, 0, $action) . vbCrlf() . '</select>';
        $content= replace($content, '[$input_parentid$]', $c); //�ϼ���Ŀ
    }

    $content= replaceValueParam($content, 'searchfield', @$_REQUEST['searchfield']); //�����ֶ�
    $content= replaceValueParam($content, 'keyword', @$_REQUEST['keyword']); //�����ؼ���
    $content= replaceValueParam($content, 'nPageSize', @$_REQUEST['nPageSize']); //ÿҳ��ʾ����
    $content= replaceValueParam($content, 'addsql', @$_REQUEST['addsql']); //׷��sqlֵ����
    $content= replaceValueParam($content, 'tableName', $tableName); //������
    $content= replaceValueParam($content, 'actionType', @$_REQUEST['actionType']); //��������
    $content= replaceValueParam($content, 'lableTitle', @$_REQUEST['lableTitle']); //��������
    $content= replaceValueParam($content, 'id', $id); //id
    $content= replaceValueParam($content, 'page', @$_REQUEST['page']); //ҳ

    $content= replaceValueParam($content, 'parentid', @$_REQUEST['parentid']); //��Ŀid
    $content= replaceValueParam($content, 'focusid', $focusid);


    $url= getUrlAddToParam(getThisUrl(), '?parentid=&keyword=&searchfield=&page=', 'delete');

    $content= replaceValueParam($content, 'position', 'ϵͳ���� > <a href=\'' . $url . '\'>' . $lableTitle . '�б�</a>'); //positionλ��


    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //asp��phh
    $content= replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL); //ǰ�������ַ
    $content= replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']);

    $content= $content . stat2016(true);

    $content=handleDisplayLanguage($content,'handleDisplayLanguage');			//���Դ���

    Rw($content);
}

//����޸Ľ���
function addEditDisplay($actionName, $lableTitle, $fieldNameList){
    $content=''; $addOrEdit=''; $splxx=''; $i=''; $j=''; $s=''; $c=''; $tableName=''; $url=''; $aStr ='';
    $fieldName ='';//�ֶ�����
    $splFieldName ='';//�ָ��ֶ�
    $fieldSetType ='';//�ֶ���������
    $fieldValue ='';//�ֶ�ֵ
    $sql ='';//sql���
    $defaultList ='';//Ĭ���б�
    $flagsInputName ='';//��input���Ƹ�ArticleDetail��
    $titlecolor ='';//������ɫ
    $flags ='';//��
    $splStr=''; $fieldConfig=''; $defaultFieldValue=''; $postUrl ='';
    $subTableName=''; $subFileName ='';//���б�ı����ƣ����б��ֶ�����
    $templateListStr='';$listStr='';$listS='';$listC ='';

    $id ='';
    $id= rq('id');
    $addOrEdit= '���';
    if( $id <> '' ){
        $addOrEdit= '�޸�';
    }

    if( inStr(',Admin,', ',' . $actionName . ',') > 0 && $id== @$_SESSION['adminId'] . '' ){
        handlePower('�޸�����'); //����Ȩ�޴���
    }else{
        handlePower('��ʾ' . $lableTitle); //����Ȩ�޴���
    }



    $fieldNameList= ',' . specialStrReplace($fieldNameList) . ','; //�����ַ����� �Զ����ֶ��б�
    $tableName= lCase($actionName); //������

    $systemFieldList ='';//���ֶ��б�
    $systemFieldList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ������б�');
    $splStr= aspSplit($systemFieldList, ',');


    //��ģ��
    $content= getTemplateContent('addEdit_' . $tableName . '.html');


    //�رձ༭��
    if( inStr($GLOBALS['cfg_flags'], '|iscloseeditor|') > 0 ){
        $s= getStrCut($content, '<!--#editor start#-->', '<!--#editor end#-->', 1);
        if( $s <> '' ){
            $content= replace($content, $s, '');
        }
    }

    //id=*  �Ǹ���վ����ʹ�õģ���Ϊ��û�й����б�ֱ�ӽ����޸Ľ���
    if( $id== '*' ){
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName;
    }else{
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id=' . $id;
    }
    if( $id <> '' ){
        $rsObj=$GLOBALS['conn']->query( $sql);
        if( @mysql_num_rows($rsObj)!=0 ){
            $rs=mysql_fetch_array($rsObj);
            $id= $rs['id'];
        }
        //������ɫ
        if( inStr($systemFieldList, ',titlecolor|') > 0 ){
            $titlecolor= $rs['titlecolor'];
        }
        //��
        if( inStr($systemFieldList, ',flags|') > 0 ){
            $flags= $rs['flags'];
        }
    }

    if( inStr(',Admin,', ',' . $actionName . ',') > 0 ){
        //���޸ĳ�������Ա��ʱ�䣬�ж����Ƿ��г�������ԱȨ��
        if( $flags== '|*|' ){
            handlePower('*'); //����Ȩ�޴���
        }
        //��ģ�崦��
        $templateListStr=getStrCut($content,'<!--template_list-->','<!--/template_list-->',2);
        $listStr=getStrCut($templateListStr,'<!--list-->','<!--/list-->',2);
        if( $listStr<>'' ){
            $rsxObj=$GLOBALS['conn']->query('select * from ' . $GLOBALS['db_PREFIX'] . 'ListMenu where parentId<>-1 order by sortrank asc');
            while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
                //call echo("",rsx("title"))
                $listS=getStrCut($content,'<!--list'. $rsx['title']. '-->','<!--/list'. $rsx['title']. '-->',2);
                if( $listS=='' ){
                    $listS=$listStr;
                }
                $listS=replace($listS,'[$title$]',$rsx['title']);
                $listS=replace($listS,'[$id$]',$rsx['id']);
                $listC=$listC . $listS . vbCrlf();
            }
        }
        if( $templateListStr<>'' ){
            $content=replace($content, '<!--template_list-->' . $templateListStr . '<!--/template_list-->',$listC);
        }


        if( $flags== '|*|' ||(@$_SESSION['adminId']== $id && @$_SESSION['adminflags']== '|*|' && $id <> '') ){
            $s= getStrCut($content, '<!--��ͨ����Ա-->', '<!--��ͨ����Աend-->', 1);
            $content= replace($content, $s, '');
            $s= getStrCut($content, '<!--�û�Ȩ��-->', '<!--�û�Ȩ��end-->', 1);
            $content= replace($content, $s, '');

            //call echo("","1")
            //��ͨ����ԱȨ��ѡ���б�
        }else if(($id <> '' || $addOrEdit== '���') && @$_SESSION['adminflags']== '|*|' ){
            $s= getStrCut($content, '<!--��������Ա-->', '<!--��������Աend-->', 1);
            $content= replace($content, $s, '');
            $s= getStrCut($content, '<!--�û�Ȩ��-->', '<!--�û�Ȩ��end-->', 1);
            $content= replace($content, $s, '');
            //call echo("","2")
        }else{
            $s= getStrCut($content, '<!--��������Ա-->', '<!--��������Աend-->', 1);
            $content= replace($content, $s, '');
            $s= getStrCut($content, '<!--��ͨ����Ա-->', '<!--��ͨ����Աend-->', 1);
            $content= replace($content, $s, '');
            //call echo("","3")
        }
    }
    foreach( $splStr as $key=>$fieldConfig){
        if( $fieldConfig <> '' ){
            $splxx= aspSplit($fieldConfig . '|||', '|');
            $fieldName= $splxx[0]; //�ֶ�����
            $fieldSetType= $splxx[1]; //�ֶ���������
            $defaultFieldValue= $splxx[2]; //Ĭ���ֶ�ֵ
            //���Զ���
            if( inStr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig= mid($fieldNameList, inStr($fieldNameList, ',' . $fieldName . '|') + 1,-1);
                $fieldConfig= mid($fieldConfig, 1, inStr($fieldConfig, ',') - 1);
                $splxx= aspSplit($fieldConfig . '|||', '|');
                $fieldSetType= $splxx[1]; //�ֶ���������
                $defaultFieldValue= $splxx[2]; //Ĭ���ֶ�ֵ
            }

            $fieldValue= $defaultFieldValue;
            if( $addOrEdit== '�޸�' ){
                $fieldValue= $rs[$fieldName];
            }
            //call echo(fieldConfig,fieldValue)

            //������������ʾΪ��
            if( $fieldSetType== 'password' ){
                $fieldValue= '';
            }
            if( $fieldValue <> '' ){
                $fieldValue= replace(replace($fieldValue, '"', '&quot;'), '<', '&lt;'); //��input�����ֱ����ʾ"�Ļ��ͻ������
            }
            if( inStr(',ArticleDetail,WebColumn,ListMenu,', ',' . $actionName . ',') > 0 && $fieldName== 'parentid' ){
                $defaultList= '[list]<option value="[$id$]"[$selected$]>[$selectcolumnname$]</option>[/list]';
                if( $addOrEdit== '���' ){
                    $fieldValue= @$_REQUEST['parentid'];
                }
                $subTableName= 'webcolumn';
                $subFileName= 'columnname';
                if( $actionName== 'ListMenu' ){
                    $subTableName= 'listmenu';
                    $subFileName= 'title';
                }
                $c= '<select name="parentid" id="parentid"><option value="-1">�� ��Ϊһ����Ŀ ��</option>' . showColumnList( -1, $subTableName, $subFileName, $fieldValue, 0, $defaultList) . vbCrlf() . '</select>';
                $content= replace($content, '[$input_parentid$]', $c); //�ϼ���Ŀ

            }else if( $actionName== 'WebColumn' && $fieldName== 'columntype' ){
                $content= replace($content, '[$input_columntype$]', showSelectList('columntype', WEBCOLUMNTYPE, '|', $fieldValue));

            }else if( inStr(',ArticleDetail,WebColumn,', ',' . $actionName . ',') > 0 && $fieldName== 'flags' ){
                $flagsInputName= 'flags';
                if( EDITORTYPE== 'php' ){
                    $flagsInputName= 'flags[]'; //��ΪPHP�����Ŵ�������
                }

                if( $actionName== 'ArticleDetail' ){
                    $s= inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|h|') > 0, 1, 0), 'h', 'ͷ��[h]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|c|') > 0, 1, 0), 'c', '�Ƽ�[c]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|f|') > 0, 1, 0), 'f', '�õ�[f]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|a|') > 0, 1, 0), 'a', '�ؼ�[a]');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|s|') > 0, 1, 0), 's', '����[s]');
                    $s= $s . replace(inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|b|') > 0, 1, 0), 'b', '�Ӵ�[b]'), '', '');
                    $s= replace($s, ' value=\'b\'>', ' onclick=\'input_font_bold()\' value=\'b\'>');


                }else if( $actionName== 'WebColumn' ){
                    $s= inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|top|') > 0, 1, 0), 'top', '������ʾ');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|foot|') > 0, 1, 0), 'foot', '�ײ���ʾ');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|left|') > 0, 1, 0), 'left', '�����ʾ');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|center|') > 0, 1, 0), 'center', '�м���ʾ');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|right|') > 0, 1, 0), 'right', '�ұ���ʾ');
                    $s= $s . inputCheckBox3($flagsInputName, IIF(inStr('|' . $fieldValue . '|', '|other|') > 0, 1, 0), 'other', '����λ����ʾ');
                }
                $content= replace($content, '[$input_flags$]', $s);


            }else if( $fieldSetType== 'textarea1' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', ''));
            }else if( $fieldSetType== 'textarea2' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '300px', 'input-text', ''));
            }else if( $fieldSetType== 'textarea3' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '500px', 'input-text', ''));
            }else if( $fieldSetType== 'password' ){
                $content= replace($content, '[$input_' . $fieldName . '$]', '<input name=\'' . $fieldName . '\' type=\'password\' id=\'' . $fieldName . '\' value=\'' . $fieldValue . '\' style=\'width:97%;\' class=\'input-text\'>');
            }else if( inStr($content,'[$textarea1_' . $fieldName . '$]')>0 ){
                $content= replace($content, '[$textarea1_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', ''));
            }else{
                //׷����20160717 home  �ȸĽ�
                if( inStr($content, '[$textarea1_' . $fieldName . '$]')>0 ){
                    $content= replace($content, '[$textarea1_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', ''));
                }else if( inStr($content, '[$textarea2_' . $fieldName . '$]')>0 ){
                    $content= replace($content, '[$textarea2_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '300px', 'input-text', ''));
                }else if( inStr($content, '[$textarea3_' . $fieldName . '$]')>0 ){
                    $content= replace($content, '[$textarea3_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '500px', 'input-text', ''));

                }else{
                    $content= replace($content, '[$input_' . $fieldName . '$]', inputText2($fieldName, $fieldValue, '97%', 'input-text', ''));
                }
            }
            $content= replaceValueParam($content, $fieldName, $fieldValue);
        }
    }

    if( $id <> '' ){

    }
    //call die("")
    $content= replace($content, '[$switchId$]', @$_REQUEST['switchId']);


    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    $url= getUrlAddToParam($url, '?focusid=' . $id, 'replace');

    //call echo(getThisUrl(),url)
    if( inStr('|WebSite|', '|' . $actionName . '|')== false ){
        $aStr= '<a href=\'' . $url . '\'>' . $lableTitle . '�б�</a> > ';
    }

    $content= replaceValueParam($content, 'position', 'ϵͳ���� > ' . $aStr . $addOrEdit . '��Ϣ');

    $content= replaceValueParam($content, 'searchfield', @$_REQUEST['searchfield']); //�����ֶ�
    $content= replaceValueParam($content, 'keyword', @$_REQUEST['keyword']); //�����ؼ���
    $content= replaceValueParam($content, 'nPageSize', @$_REQUEST['nPageSize']); //ÿҳ��ʾ����
    $content= replaceValueParam($content, 'addsql', @$_REQUEST['addsql']); //׷��sqlֵ����
    $content= replaceValueParam($content, 'tableName', $tableName); //������
    $content= replaceValueParam($content, 'actionType', @$_REQUEST['actionType']); //��������
    $content= replaceValueParam($content, 'lableTitle', @$_REQUEST['lableTitle']); //��������
    $content= replaceValueParam($content, 'id', $id); //id
    $content= replaceValueParam($content, 'page', @$_REQUEST['page']); //ҳ

    $content= replaceValueParam($content, 'parentid', @$_REQUEST['parentid']); //��Ŀid


    $content= replace($content, '{$EDITORTYPE$}', EDITORTYPE); //asp��phh
    $content= replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL); //ǰ�������ַ
    $content= replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']);



    $postUrl= getUrlAddToParam(getThisUrl(), '?act=saveAddEditHandle&id=' . $id, 'replace');
    $content= replaceValueParam($content, 'postUrl', $postUrl);


    //20160113
    if( EDITORTYPE== 'asp' ){
        $content= replace($content, '[$phpArray$]', '');
    }else if( EDITORTYPE== 'php' ){
        $content= replace($content, '[$phpArray$]', '[]');
    }


    $content=handleDisplayLanguage($content,'handleDisplayLanguage');			//���Դ���

    Rw($content);
}

//����ģ��
function saveAddEdit($actionName, $lableTitle, $fieldNameList){
    $tableName=''; $url=''; $listUrl ='';
    $id=''; $addOrEdit=''; $sql ='';

    $id= @$_REQUEST['id'];
    $addOrEdit= IIF($id== '', '���', '�޸�');

    handlePower($addOrEdit . $lableTitle); //����Ȩ�޴���


    $GLOBALS['conn=']=OpenConn();

    $fieldNameList= ',' . specialStrReplace($fieldNameList) . ','; //�����ַ����� �Զ����ֶ��б�
    $tableName= lCase($actionName); //������


    $sql= getPostSql($id, $tableName, $fieldNameList);
    //call eerr("sql",sql)												'������
    //���SQL
    if( checkSql($sql)== false ){
        errorLog('������ʾ��<hr>sql=' . $sql . '<br>');
        return '';
    }
    //conn.Execute(sql)                 '���SQLʱ�Ѿ������ˣ�����Ҫ��ִ����
    //����վ���õ�������Ϊ��̬����ʱɾ����index.html     ���������л�20160216
    if( lCase($actionName)== 'website' ){
        if( inStr(@$_REQUEST['flags'], 'htmlrun')== false ){
            DeleteFile('../index.html');
        }
    }

    $listUrl= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    $listUrl= getUrlAddToParam($listUrl, '?focusid=' . $id, 'replace');

    //���
    if( $id== '' ){

        $url= getUrlAddToParam(getThisUrl(), '?act=addEditHandle', 'replace');
        $url= getUrlAddToParam($url, '?focusid=' . $id, 'replace');

        Rw(getMsg1('������ӳɹ������ؼ������' . $lableTitle . '...<br><a href=\'' . $listUrl . '\'>����' . $lableTitle . '�б�</a>', $url));
    }else{
        $url= getUrlAddToParam(getThisUrl(), '?act=addEditHandle&switchId=' . @$_POST['switchId'], 'replace');
        $url= getUrlAddToParam($url, '?focusid=' . $id, 'replace');

        //û�з����б��������
        if( inStr('|WebSite|', '|' . $actionName . '|') > 0 ){
            Rw(getMsg1('�����޸ĳɹ�', $url));
        }else{
            Rw(getMsg1('�����޸ĳɹ������ڽ���' . $lableTitle . '�б�...<br><a href=\'' . $url . '\'>�����༭</a>', $listUrl));
        }
    }
    writeSystemLog($tableName, $addOrEdit . $lableTitle); //ϵͳ��־
}

//ɾ��
function del($actionName, $lableTitle){
    $tableName=''; $url ='';
    $tableName= lCase($actionName); //������
    $id ='';

    handlePower('ɾ��' . $lableTitle); //����Ȩ�޴���


    $id= @$_REQUEST['id'];
    if( $id <> '' ){
        $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
        $GLOBALS['conn=']=OpenConn();


        //����Ա
        if( $actionName== 'Admin' ){
            $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ') and flags=\'|*|\'');
            if( @mysql_num_rows($rsObj)!=0 ){
                $rs=mysql_fetch_array($rsObj);
                rwEnd(getMsg1('ɾ��ʧ�ܣ�ϵͳ����Ա������ɾ�������ڽ���' . $lableTitle . '�б�...', $url));
            }
        }
        connexecute('delete from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ')');
        Rw(getMsg1('ɾ��' . $lableTitle . '�ɹ������ڽ���' . $lableTitle . '�б�...', $url));
        //��־�����Ͳ�Ҫ�ټ�¼����־�����ˣ�Ҫ��Ȼ�Ļ��͸����ˣ�û����20160713
        if( $tableName<>'systemlog' ){
            writeSystemLog($tableName, 'ɾ��' . $lableTitle); //ϵͳ��־
        }
    }
}

//������
function sortHandle($actionType){
    $splId=''; $splValue=''; $i=''; $id=''; $sortrank=''; $tableName=''; $url ='';
    $tableName= lCase($actionType); //������
    $splId= aspSplit(@$_REQUEST['id'], ',');
    $splValue= aspSplit(@$_REQUEST['value'], ',');
    for( $i= 0 ; $i<= uBound($splId); $i++){
        $id= $splId[$i];
        $sortrank= $splValue[$i];
        $sortrank= getNumber($sortrank . '');

        if( $sortrank== '' ){
            $sortrank= 0;
        }
        connexecute('update ' . $GLOBALS['db_PREFIX'] . $tableName . ' set sortrank=' . $sortrank . ' where id=' . $id);
    }
    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    Rw(getMsg1('����������ɣ����ڷ����б�...', $url));

    writeSystemLog($tableName, '����' . @$_REQUEST['lableTitle']); //ϵͳ��־
}

//�����ֶ�
function updateField(){
    $tableName=''; $id=''; $fieldName=''; $fieldvalue=''; $fieldNameList=''; $url ='';
    $tableName= lCase(@$_REQUEST['actionType']); //������
    $id= @$_REQUEST['id']; //id
    $fieldName= lCase(@$_REQUEST['fieldname']); //�ֶ�����
    $fieldvalue= @$_REQUEST['fieldvalue']; //�ֶ�ֵ

    $fieldNameList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�');
    //call echo(fieldname,fieldvalue)
    //call echo("fieldNameList",fieldNameList)
    if( inStr($fieldNameList, ',' . $fieldName . ',')== false ){
        Eerr('������ʾ', '��(' . $tableName . ')�������ֶ�(' . $fieldName . ')');
    }else{
        connexecute('update ' . $GLOBALS['db_PREFIX'] . $tableName . ' set ' . $fieldName . '=' . $fieldvalue . ' where id=' . $id);
    }

    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    Rw(getMsg1('�����ɹ������ڷ����б�...', $url));

}

//����robots.txt 20160118
function saveRobots(){
    $bodycontent=''; $url ='';
    handlePower('�޸�����Robots'); //����Ȩ�޴���
    $bodycontent= @$_REQUEST['bodycontent'];
    createFile(ROOT_PATH . '/../robots.txt', $bodycontent);
    $url= '?act=displayLayout&templateFile=layout_makeRobots.html&lableTitle=����Robots';
    Rw(getMsg1('����Robots�ɹ������ڽ���Robots����...', $url));

    writeSystemLog('', '����Robots.txt'); //ϵͳ��־
}

//ɾ��ȫ�����ɵ�html�ļ�
function deleteAllMakeHtml(){
    $filePath ='';
    //��Ŀ
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $filePath= getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']);
            if( right($filePath, 1)== '/' ){
                $filePath= $filePath . 'index.html';
            }
            aspEcho('��ĿfilePath', '<a href=\'' . $filePath . '\' target=\'_blank\'>' . $filePath . '</a>');
            DeleteFile($filePath);
        }
    }
    //����
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $filePath= getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/detail' . $rsx['id']);
            if( right($filePath, 1)== '/' ){
                $filePath= $filePath . 'index.html';
            }
            aspEcho('����filePath', '<a href=\'' . $filePath . '\' target=\'_blank\'>' . $filePath . '</a>');
            DeleteFile($filePath);
        }
    }
    //��ҳ
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $filePath= getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/detail' . $rsx['id']);
            if( right($filePath, 1)== '/' ){
                $filePath= $filePath . 'index.html';
            }
            aspEcho('��ҳfilePath', '<a href=\'' . $filePath . '\' target=\'_blank\'>' . $filePath . '</a>');
            DeleteFile($filePath);
        }
    }
}

//ͳ��2016 stat2016(true)
function stat2016($isHide){
    $c ='';
    if( @$_COOKIE['tjB']== '' && GetIP() <> '127.0.0.1' ){ //���α��أ�����֮ǰ����20160122
        setCookie('tjB', '1', aspTime() + 3600);
        $c= $c . chr(60) . chr(115) . chr(99) . chr(114) . chr(105) . chr(112) . chr(116) . chr(32) . chr(115) . chr(114) . chr(99) . chr(61) . chr(34) . chr(104) . chr(116) . chr(116) . chr(112) . chr(58) . chr(47) . chr(47) . chr(106) . chr(115) . chr(46) . chr(117) . chr(115) . chr(101) . chr(114) . chr(115) . chr(46) . chr(53) . chr(49) . chr(46) . chr(108) . chr(97) . chr(47) . chr(52) . chr(53) . chr(51) . chr(50) . chr(57) . chr(51) . chr(49) . chr(46) . chr(106) . chr(115) . chr(34) . chr(62) . chr(60) . chr(47) . chr(115) . chr(99) . chr(114) . chr(105) . chr(112) . chr(116) . chr(62);
        if( $isHide== true ){
            $c= '<div style="display:none;">' . $c . '</div>';
        }
    }
    $stat2016= $c;
    return @$stat2016;
}
//��ùٷ���Ϣ
function getOfficialWebsite(){
    $s ='';
    if( @$_COOKIE['ASPPHPCMSGW']== '' ){
        $s= getHttpUrl(chr(104) . chr(116) . chr(116) . chr(112) . chr(58) . chr(47) . chr(47) . chr(115) . chr(104) . chr(97) . chr(114) . chr(101) . chr(109) . chr(98) . chr(119) . chr(101) . chr(98) . chr(46) . chr(99) . chr(111) . chr(109) . chr(47) . chr(97) . chr(115) . chr(112) . chr(112) . chr(104) . chr(112) . chr(99) . chr(109) . chr(115) . chr(47) . chr(97) . chr(115) . chr(112) . chr(112) . chr(104) . chr(112) . chr(99) . chr(109) . chr(115) . chr(46) . chr(97) . chr(115) . chr(112) . '?act=version&domain=' . escape(webDoMain()) . '&version=' . escape($GLOBALS['webVersion']) . '&language=' . $GLOBALS['language'], '');
        //��escape����ΪPHP��ʹ��ʱ�����20160408
        setCookie('ASPPHPCMSGW', $s, aspTime() + 3600);
    }else{
        $s=@$_COOKIE['ASPPHPCMSGW'];
    }
    $getOfficialWebsite= $s;
    //Call clearCookie("ASPPHPCMSGW")
    return @$getOfficialWebsite;
}

//������վͳ�� 20160203
function updateWebsiteStat(){
    $content=''; $splStr=''; $splxx=''; $filePath=''; $fileName='';
    $url=''; $s=''; $nCount ='';
    handlePower('������վͳ��'); //����Ȩ�޴���
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat');						 //ɾ��ȫ��ͳ�Ƽ�¼
    $content= getDirTxtList($GLOBALS['adminDir'] . '/data/stat/');
    $splStr= aspSplit($content, vbCrlf());
    $nCount= 1;
    foreach( $splStr as $key=>$filePath){
        $fileName=getFileName($filePath);
        if( $filePath <> '' && left($fileName,1)<>'#' ){
            $nCount=$nCount+1;
            aspEcho($nCount . '��filePath',$filePath);
            doEvents();
            $content= getFText($filePath);
            $content= replace($content, chr(0), '');
            whiteWebStat($content);

        }
    }
    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');

    Rw(getMsg1('����ȫ��ͳ�Ƴɹ������ڽ���' . @$_REQUEST['lableTitle'] . '�б�...', $url));
    writeSystemLog('', '������վͳ��'); //ϵͳ��־
}
//���ȫ����վͳ�� 20160329
function clearWebsiteStat(){
    $url ='';
    handlePower('�����վͳ��'); //����Ȩ�޴���
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat');

    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');

    Rw(getMsg1('�����վͳ�Ƴɹ������ڽ���' . @$_REQUEST['lableTitle'] . '�б�...', $url));
    writeSystemLog('', '�����վͳ��'); //ϵͳ��־
}
//���½�����վͳ��
function updateTodayWebStat(){
    $content=''; $url='';$dateStr='';$dateMsg='';
    if( @$_REQUEST['date']<>'' ){
        $dateStr=now()+cint(@$_REQUEST['date']);
        $dateMsg='����';
    }else{
        $dateStr=now();
        $dateMsg='����';
    }

    handlePower('����'. $dateMsg . 'ͳ��'); //����Ȩ�޴���

    //call echo("datestr",datestr)
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat where dateclass=\'' . Format_Time($dateStr, 2) . '\'');
    $content= getFText($GLOBALS['adminDir'] . '/data/stat/' . Format_Time($dateStr, 2) . '.txt');
    whiteWebStat($content);
    $url= getUrlAddToParam(getThisUrl(), '?act=dispalyManageHandle', 'replace');
    Rw(getMsg1('����'. $dateMsg .'ͳ�Ƴɹ������ڽ���' . @$_REQUEST['lableTitle'] . '�б�...', $url));
    writeSystemLog('', '������վͳ��'); //ϵͳ��־
}
//д����վͳ����Ϣ
function whiteWebStat($content){
    $splStr=''; $splxx=''; $filePath='';$nCount='';
    $url=''; $s=''; $visitUrl=''; $viewUrl=''; $viewdatetime=''; $ip=''; $browser=''; $operatingsystem=''; $cookie=''; $screenwh=''; $moreInfo=''; $ipList=''; $dateClass ='';
    $splxx= aspSplit($content, vbCrlf() . '-------------------------------------------------' . vbCrlf());
    $nCount=0;
    foreach( $splxx as $key=>$s){
        if( inStr($s, '��ǰ��') > 0 ){
            $nCount=$nCount+1;
            $s= vbCrlf() . $s . vbCrlf();
            $dateClass= ADSql(getFileAttr($filePath, '3'));
            $visitUrl= ADSql(getStrCut($s, vbCrlf() . '����', vbCrlf(), 0));
            $viewUrl= ADSql(getStrCut($s, vbCrlf() . '��ǰ��', vbCrlf(), 0));
            $viewdatetime= ADSql(getStrCut($s, vbCrlf() . 'ʱ�䣺', vbCrlf(), 0));
            $ip= ADSql(getStrCut($s, vbCrlf() . 'IP:', vbCrlf(), 0));
            $browser= ADSql(getStrCut($s, vbCrlf() . 'browser: ', vbCrlf(), 0));
            $operatingsystem= ADSql(getStrCut($s, vbCrlf() . 'operatingsystem=', vbCrlf(), 0));
            $cookie= ADSql(getStrCut($s, vbCrlf() . 'Cookies=', vbCrlf(), 0));
            $screenwh= ADSql(getStrCut($s, vbCrlf() . 'Screen=', vbCrlf(), 0));
            $moreInfo= ADSql(getStrCut($s, vbCrlf() . '�û���Ϣ=', vbCrlf(), 0));
            $browser= ADSql(getBrType($moreInfo));
            if( inStr(vbCrlf() . $ipList . vbCrlf(), vbCrlf() . $ip . vbCrlf())== false ){
                $ipList= $ipList . $ip . vbCrlf();
            }

            $viewdatetime=replace($viewdatetime,'����','00');
            if( isDate($viewdatetime)==false ){
                $viewdatetime='1988/07/12 10:10:10';
            }

            $screenwh= left($screenwh, 20);
            if( 1== 2 ){
                aspEcho('���',$nCount);
                aspEcho('dateClass', $dateClass);
                aspEcho('visitUrl', $visitUrl);
                aspEcho('viewUrl', $viewUrl);
                aspEcho('viewdatetime', $viewdatetime);
                aspEcho('IP', $ip);
                aspEcho('browser', $browser);
                aspEcho('operatingsystem', $operatingsystem);
                aspEcho('cookie', $cookie);
                aspEcho('screenwh', $screenwh);
                aspEcho('moreInfo', $moreInfo);
                HR();
            }
            connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values(\'' . $visitUrl . '\',\'' . $viewUrl . '\',\'' . $browser . '\',\'' . $operatingsystem . '\',\'' . $screenwh . '\',\'' . $moreInfo . '\',\'' . $viewdatetime . '\',\'' . $ip . '\',\'' . $dateClass . '\')');
        }
    }
}

//��ϸ��վͳ��
function websiteDetail(){
    $content=''; $splxx=''; $filePath ='';
    $s=''; $ip=''; $ipList ='';
    $nIP=''; $nPV=''; $i=''; $timeStr=''; $c ='';

    handlePower('��վͳ����ϸ'); //����Ȩ�޴���

    for( $i= 1 ; $i<= 30; $i++){
        $timeStr= getHandleDate(($i - 1) * - 1); //format_Time(Now() - i + 1, 2)
        $filePath= $GLOBALS['adminDir'] . '/data/stat/' . $timeStr . '.txt';
        $content= getFText($filePath);
        $splxx= aspSplit($content, vbCrlf() . '-------------------------------------------------' . vbCrlf());
        $nIP= 0;
        $nPV= 0;
        $ipList= '';
        foreach( $splxx as $key=>$s){
            if( inStr($s, '��ǰ��') > 0 ){
                $s= vbCrlf() . $s . vbCrlf();
                $ip= ADSql(getStrCut($s, vbCrlf() . 'IP:', vbCrlf(), 0));
                $nPV= $nPV + 1;
                if( inStr(vbCrlf() . $ipList . vbCrlf(), vbCrlf() . $ip . vbCrlf())== false ){
                    $ipList= $ipList . $ip . vbCrlf();
                    $nIP= $nIP + 1;
                }
            }
        }
        aspEcho($timeStr, 'IP(' . $nIP . ') PV(' . $nPV . ')');
        if( $i < 4 ){
            $c= $c . $timeStr . ' IP(' . $nIP . ') PV(' . $nPV . ')' . '<br>';
        }
    }

    setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $c, '#�ÿ���Ϣ#');
    writeSystemLog('', '��ϸ��վͳ��'); //ϵͳ��־

}

//��ʾָ������
function displayLayout(){
    $content=''; $lableTitle=''; $templateFile ='';
    $lableTitle= @$_REQUEST['lableTitle'];
    $templateFile=@$_REQUEST['templateFile'];
    handlePower('��ʾ' . $lableTitle); //����Ȩ�޴���

    $content= getTemplateContent(@$_REQUEST['templateFile']);
    $content= replace($content, '[$position$]', $lableTitle);
    $content= replaceValueParam($content, 'lableTitle', $lableTitle);


    //Robots.txt�ļ�����
    if( $templateFile=='layout_makeRobots.html' ){
        $content= replace($content, '[$bodycontent$]', getFText('/robots.txt'));
        //��̨�˵���ͼ
    }else if( $templateFile=='layout_adminMap.html' ){
        $content= replaceValueParam($content, 'adminmapbody', getAdminMap());
        //����ģ��
    }else if( $templateFile=='layout_manageTemplates.html' ){
        $content= displayTemplatesList($content);
        //����html
    }else if( $templateFile=='layout_manageMakeHtml.html' ){
        $content= replaceValueParam($content, 'columnList', getMakeColumnList());


    }


    $content=handleDisplayLanguage($content,'handleDisplayLanguage');			//���Դ���
    Rw($content);
}
//���������Ŀ�б�
function getMakeColumnList(){
    $c ='';
    //��Ŀ
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow']== false ){
            $c= $c . '<option value="' . $rsx['id'] . '">' . $rsx['columnname'] . '</option>' . vbCrlf();
        }
    }
    $getMakeColumnList= $c;
    return @$getMakeColumnList;
}

//��ú�̨��ͼ
function getAdminMap(){
    $s=''; $c=''; $url=''; $addSql ='';
    if( @$_SESSION['adminflags'] <> '|*|' ){
        $addSql= ' and isDisplay<>0 ';
    }
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=-1 ' . $addSql . ' order by sortrank');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $c= $c . '<div class="map-menu fl"><ul>' . vbCrlf();
        $c= $c . '<li class="title">' . $rs['title'] . '</li><div>' . vbCrlf();
        $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=' . $rs['id'] . ' ' . $addSql . '  order by sortrank');
        while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
            $url= PHPTrim($rsx['customaurl']);
            if( $rsx['lablename'] <> '' ){
                $url= $url . '&lableTitle=' . $rsx['lablename'];
            }
            $c= $c . '<li><a href="' . $url . '">' . $rsx['title'] . '</a></li>' . vbCrlf();
        }
        $c= $c . '</div></ul></div>' . vbCrlf();
    }
    $c= replaceLableContent($c);
    $getAdminMap= $c;
    return @$getAdminMap;
}

//��ú�̨һ���˵��б�
function getAdminOneMenuList(){
    $c=''; $focusStr=''; $addSql=''; $sql ='';
    if( @$_SESSION['adminflags'] <> '|*|' ){
        $addSql= ' and isDisplay<>0 ';
    }
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=-1 ' . $addSql . ' order by sortrank';
    //���SQL
    if( checkSql($sql)== false ){
        errorLog('������ʾ��<br>function=getAdminOneMenuList<hr>sql=' . $sql . '<br>');
        return '';
    }
    $rsObj=$GLOBALS['conn']->query( $sql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $focusStr= '';
        if( $c== '' ){
            $focusStr= ' class="focus"';
        }
        $c= $c . '<li' . $focusStr . '>' . $rs['title'] . '</li>' . vbCrlf();
    }
    $c= replaceLableContent($c);
    $getAdminOneMenuList= $c;
    return @$getAdminOneMenuList;
}
//��ú�̨�˵��б�
function getAdminMenuList(){
    $s=''; $c=''; $url=''; $selStr=''; $addSql=''; $sql ='';
    if( @$_SESSION['adminflags'] <> '|*|' ){
        $addSql= ' and isDisplay<>0 ';
    }
    $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=-1 ' . $addSql . ' order by sortrank';
    //���SQL
    if( checkSql($sql)== false ){
        errorLog('������ʾ��<br>function=getAdminMenuList<hr>sql=' . $sql . '<br>');
        return '';
    }
    $rsObj=$GLOBALS['conn']->query( $sql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $selStr= 'didoff';
        if( $c== '' ){
            $selStr= 'didon';
        }

        $c= $c . '<ul class="navwrap">' . vbCrlf();
        $c= $c . '<li class="' . $selStr . '">' . $rs['title'] . '</li>' . vbCrlf();


        $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where parentid=' . $rs['id'] . '  ' . $addSql . ' order by sortrank');
        while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
            $url= PHPTrim($rsx['customaurl']);
            $c= $c . ' <li class="item" onClick="window1(\'' . $url . '\',\'' . $rsx['lablename'] . '\');">' . $rsx['title'] . '</li>' . vbCrlf();

        }
        $c= $c . '</ul>' . vbCrlf();
    }
    $c= replaceLableContent($c);
    $getAdminMenuList= $c;
    return @$getAdminMenuList;
}
//����ģ���б�
function displayTemplatesList($content){
    $templatesFolder=''; $templatePath=''; $templatePath2=''; $templateName=''; $defaultList=''; $folderList=''; $splStr=''; $s=''; $c ='';$s1='';$s2='';$s3='';
    $splTemplatesFolder ='';
    //������ַ����
    loadWebConfig();

    $defaultList= getStrCut($content, '[list]', '[/list]', 2);
    $splTemplatesFolder= aspSplit('/Templates/|/Templates2015/|/Templates2016/', '|');
    foreach( $splTemplatesFolder as $key=>$templatesFolder){
        if( $templatesFolder <> '' ){
            $folderList= getDirFolderNameList($templatesFolder);
            $splStr= aspSplit($folderList, vbCrlf());
            foreach( $splStr as $key=>$templateName){
                if( $templateName <> '' && inStr('#_', left($templateName, 1))== false ){
                    $templatePath= $templatesFolder . $templateName;
                    $templatePath2= $templatePath;
                    $s= $defaultList;

                    $s1= getStrCut($content, '<!--���� start-->', '<!--���� end-->', 2);
                    $s2= getStrCut($content, '<!--�ָ����� start-->', '<!--�ָ����� end-->', 2);
                    $s3= getStrCut($content, '<!--ɾ��ģ�� start-->', '<!--ɾ��ģ�� end-->', 2);

                    if( lCase($GLOBALS['cfg_webtemplate'])== lCase($templatePath) ){
                        $templateName= '<font color=red>' . $templateName . '</font>';
                        $templatePath2= '<font color=red>' . $templatePath2 . '</font>';
                        $s= replace(replace($s, $s1, ''),$s3,'');
                    }else{
                        $s= replace($s,$s2,'');
                    }
                    $s= replaceValueParam($s, 'templatename', $templateName);
                    $s= replaceValueParam($s, 'templatepath', $templatePath);
                    $s= replaceValueParam($s, 'templatepath2', $templatePath2);
                    $c= $c . $s . vbCrlf();
                }
            }
        }
    }
    $content= replace($content, '[list]' . $defaultList . '[/list]', $c);
    $displayTemplatesList= $content;
    return @$displayTemplatesList;
}
//Ӧ��ģ��
function isOpenTemplate(){
    $templatePath=''; $templateName=''; $editValueStr=''; $url ='';

    handlePower('����ģ��'); //����Ȩ�޴���

    $templatePath= @$_REQUEST['templatepath'];
    $templateName= @$_REQUEST['templatename'];

    if( getRecordCount($GLOBALS['db_PREFIX'] . 'website', '')== 0 ){
        connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website(webtitle) values(\'����\')');
    }


    $editValueStr= 'webtemplate=\'' . $templatePath . '\',webimages=\'' . $templatePath . 'Images/\'';
    $editValueStr= $editValueStr . ',webcss=\'' . $templatePath . 'css/\',webjs=\'' . $templatePath . 'Js/\'';
    connexecute('update ' . $GLOBALS['db_PREFIX'] . 'website set ' . $editValueStr);
    $url= '?act=displayLayout&templateFile=layout_manageTemplates.html&lableTitle=ģ��';



    Rw(getMsg1('����ģ��ɹ������ڽ���ģ�����...', $url));
    writeSystemLog('', 'Ӧ��ģ��' . $templatePath); //ϵͳ��־
}
//ɾ��ģ��
function delTemplate(){
    $templateDir='';$toTemplateDir='';$url='';
    $templateDir=replace(@$_REQUEST['templateDir'],'\\','/');
    handlePower('ɾ��ģ��'); //����Ȩ�޴���
    $toTemplateDir= mid($templateDir,1,inStrRev($templateDir,'/')) . '#' . mid($templateDir,inStrRev($templateDir,'/')+1,-1) . '_' . Format_Time(now(),11);
    //call die(toTemplateDir)
    moveFolder($templateDir,$toTemplateDir);

    $url= '?act=displayLayout&templateFile=layout_manageTemplates.html&lableTitle=ģ��';
    Rw(getMsg1('ɾ��ģ����ɣ����ڽ���ģ�����...', $url));
}
//ִ��SQL
function executeSQL(){
    $sqlvalue ='';
    $sqlvalue= 'delete from ' . $GLOBALS['db_PREFIX'] . 'WebSiteStat';
    if( @$_REQUEST['sqlvalue'] <> '' ){
        $sqlvalue= @$_REQUEST['sqlvalue'];
        $GLOBALS['conn=']=OpenConn();
        //���SQL
        if( checkSql($sqlvalue)== false ){
            errorLog('������ʾ��<br>sql=' . $sqlvalue . '<br>');
            return '';
        }
        aspEcho('ִ��SQL���ɹ�', $sqlvalue);
    }
    if( @$_SESSION['adminusername']== 'ASPPHPCMS' ){
        Rw('<form id="form1" name="form1" method="post" action="?act=executeSQL"  onSubmit="if(confirm(\'��ȷ��Ҫ������\\n�����󽫲��ɻָ�\')){return true}else{return false}">SQL<input name="sqlvalue" type="text" id="sqlvalue" value="' . $sqlvalue . '" size="80%" /><input type="submit" name="button" id="button" value="ִ��" /></form>');
    }else{
        Rw('��û��Ȩ��ִ��SQL���');
    }
}





?>