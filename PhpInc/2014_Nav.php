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
//����
//������վ����
function handleWebConfig(){
    $did=''; $sql ='';
    $did = IIF($GLOBALS['PubNavDid'] <> '', $GLOBALS['PubNavDid'], $GLOBALS['PubProDid']) ;
    //�����վ��������
    GetNavConfig($did) ;
    if( $GLOBALS['PubId'] <> '' ){
        $sql = 'Select * From [Product] Where Id=' . $GLOBALS['PubId'] ;
        $rsObj=$GLOBALS['conn']->query( $sql);
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            //�����վ��������
            GetNavConfig($rs['bigclassname']) ;
            $GLOBALS['MainNav'] = $rs['bigclassname'] ;//��������
        }

    }
}
//�����վ��������
function getNavConfig($did){
    $RsTempObj=$GLOBALS['conn']->query( 'Select * From [NavBigClass] Where BigClassName=\'' . $did . '\'');
    $rstemp=mysql_fetch_array($rstempObj);
    if( @mysql_num_rows($RsTempObj)!=0 ){
        $GLOBALS['MainNav'] = $GLOBALS['RsTemp']['bigclassname'] ;//��������
        $GLOBALS['PubNavType'] = $GLOBALS['RsTemp']['navtype'] ;//��վ��������
        $GLOBALS['PubNavDid'] = $GLOBALS['MainNav'] ;
    }
}
//�����վ��������
function getNavType($did){
    $RsTempObj=$GLOBALS['conn']->query( 'Select * From [NavBigClass] Where BigClassName=\'' . $did . '\'');
    $rstemp=mysql_fetch_array($rstempObj);
    if( @mysql_num_rows($RsTempObj)!=0 ){
        $getNavType = $GLOBALS['RsTemp']['navtype'] ;//��վ��������
    }
    return @$getNavType;
}

//VB������ Start
//������CSS���� ����VB���ʹ�ã�����վ�������� 20150617
function readNavCSS($id, $styleValue){
}
//VB������ End

//������վ����  ��ǰʹ�ð汾  20141215�������޸Ŀ���
function handleNavigation($action, $addSql){
    $i=''; $c=''; $s=''; $url=''; $fileName=''; $bigFolder=''; $did=''; $sid=''; $showDid=''; $target=''; $sql=''; $dropDownMenu=''; $focusType ='';
    $smallMenuStr=''; $j=''; $showSid ='';
    $isConcise ='';//�����ʾ20150212
    $styleId=''; $styleValue ='';//��ʽID����ʽ����
    $cssNameAddId ='';



    $styleId = PHPTrim(RParam($action, 'styleID')) ;
    $styleValue = PHPTrim(RParam($action, 'styleValue')) ;
    if( $styleId <> '' ){
        ReadNavCSS($styleId, $styleValue) ;
    }

    //Ϊ�������� ���Զ���ȡ��ʽ����  20150615
    if( checkStrIsNumberType($styleValue) ){
        $cssNameAddId = '_' . $styleValue ;//Css����׷��Id���
    }

    //����SQLΪ����  ����������
    if( $addSql == '' ){
        $addSql = RParam($action, 'AddSql') ;
    }
    //׷��SQLΪ�� ����Ĭ��
    if( $addSql == '' ){
        $addSql = ' Where NavTop<>0 Order By Sort Asc' ;
    }


    $sql = 'Select * From [NavBigClass]' ;
    if( $GLOBALS['UserId'] <> '' ){ $sql = GetWhereAnd($sql, ' And UserId=' . $GLOBALS['UserId']) ;}//ָ���û�
    $sql = GetWhereAnd($sql, $addSql) ;
    if( CheckSql($sql) == false ){ eerr('Sql', $sql) ;}
    $dropDownMenu = LCase(RParam($action, 'DropDownMenu')) ;
    $focusType = LCase(RParam($action, 'FocusType')) ;
    $isConcise = LCase(RParam($action, 'isConcise')) ;
    if( $isConcise == 'true' ){
        $isConcise = false ;
    }else{
        $isConcise = true ;
    }


    $rsObj=$GLOBALS['conn']->query( $sql);
    if( $isConcise == true ){ $c = $c . CopyStr(' ', 4) . '<li class=left></li>' . "\n" ;}
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $fileName = AspTrim($rs['filename']) ;

        if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}
        $bigFolder = '/' . GetWebFolderName() . $rs['foldername'] . '/' ;
        $did = $rs['bigclassname'] ;

        $url = $rs['filename'] ;
        if( CheckMakeHtmlFile($url) == true ){
            $url = $bigFolder . $fileName ;
            $url = Replace(Replace($url, '//', '/'), '//', '/') ;
            $url = FullHttpUrl(host, $url) ;
        }
        WebDebug($url, 'act=Nav&NavDid=' . $did) ;//����
        if( instr('|��Ʒ|����|����|', '|' . $rs['navtype'] . '|') > 0 ){
            WebDebug($url, 'act=Nav&NavDid=' . $did . '&Page=1') ;//����
        }

        $showDid = FontColorFontB($did, $rs['fontb'], $rs['fontcolor']) ;
        $target = $rs['target'] ;
        if( $GLOBALS['PubNavDid'] == $rs['bigclassname'] ){
            if( $focusType == 'a' ){
                $s = CopyStr(' ', 8) . '<li class=focus><a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a>' ;
            }else{
                $s = CopyStr(' ', 8) . '<li class=focus>' . $showDid ;
            }
        }else{
            //Call Eerr("Url",Url)
            $s = CopyStr(' ', 8) . '<li><a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a>' ;
        }
        //S = DisplayOnlineEditDialog("/admin/NavManage.Asp?act=EditNavBig&Id=" & Rs("Id") & "&n=" & GetRnd(11), S)
        $s = DisplayOnlineED2('/admin/NavManage.Asp?act=EditNavBig&Id=' . $rs['id'] . '&n=' . getRnd(11), $s, '<li') ;

        $c = $c . $s ;

        $smallMenuStr = '' ;//С��˵��������
        //����С���ı��˵�
        if( $rs['navtype'] == '�ı�' && $dropDownMenu == 'true' ){
            $rssObj=$GLOBALS['conn']->query( 'Select * From [NavSmallClass] Where BigClassName=\'' . $rs['bigclassname'] . '\'');
            $rss=mysql_fetch_array($rssObj);
            if( @mysql_num_rows($rssObj)!=0 ){
                //C=C & vbCrlf & CopyStr(" ",8) & "<ul>"& vbCrlf & CopyStr(" ",12) & "<li>" & vbCrlf
                $c = $c . "\n" . CopyStr(' ', 8) . '<ul>' . "\n" . CopyStr(' ', 12) ;
                for( $j = 1 ; $j<= @mysql_num_rows($rssObj); $j++){
                    $fileName = AspTrim($rss['filename']) ;

                    if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}

                    $sid = $rss['smallclassname'] ;

                    $url = $rss['filename'] ;
                    if( CheckMakeHtmlFile($url) == true ){
                        $url = $bigFolder . $fileName ;
                        $url = $bigFolder . '/' . $rss['foldername'] . '/' . $fileName ;
                        $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                        WebDebug($url, 'act=Nav&NavDid=' . $did . '&NavSid=' . $sid) ;//����
                    }

                    $showSid = FontColorFontB($sid, $rss['fontb'], $rss['fontcolor']) ;
                    $target = $rss['target'] ; $target = '_blank' ;
                    $s = '<a ' . AHref($url, $showSid, $target) . '>' . $showSid . '</a>' ;
                    //Call eerr(ShowSid,Rss("Id"))
                    $s = DisplayOnlineEditDialog('/admin/NavManage.Asp?act=EditNavSmall&Id=' . $rss['id'] . '&n=' . getRnd(11), $s) ;
                    $smallMenuStr = $smallMenuStr . CopyStr(' ', 8) . '<li>' . $s . '</li>' . "\n" ;

                }
            }
            //����С���Ʒ�˵�
        }else if( $rs['navtype'] == '��Ʒ' && $dropDownMenu == 'true' ){
            $rssObj=$GLOBALS['conn']->query( 'Select * From [SmallClass] Where BigClassName=\'' . $rs['bigclassname'] . '\'');
            $rss=mysql_fetch_array($rssObj);
            if( @mysql_num_rows($rssObj)!=0 ){
                $c = $c . "\n" . CopyStr(' ', 8) . '<ul>' . "\n" . CopyStr(' ', 12) ;
                for( $j = 1 ; $j<= @mysql_num_rows($rssObj); $j++){
                    $fileName = AspTrim($rss['filename']) ;

                    if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}
                    $sid = $rss['smallclassname'] ;

                    $url = $rss['filename'] ;
                    if( CheckMakeHtmlFile($url) == true ){
                        $url = $bigFolder . $fileName ;
                        $url = $bigFolder . '/' . $rss['foldername'] . '/' . $fileName ;
                        $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                        WebDebug($url, 'act=CreateClass&ProDid=' . $did . '&ProSid=' . $sid . '&Page=1') ;//����
                    }
                    //Call eerr(ShowSid,Rss("Id"))
                    $showSid = FontColorFontB($sid, $rss['fontb'], $rss['fontcolor']) ;
                    $target = $rss['target'] ; $target = '_blank' ;
                    $s = '<a ' . AHref($url, $showSid, $target) . '>' . $showSid . '</a>' ;
                    $s = DisplayOnlineEditDialog('/admin/ProductClassManage.Asp?act=ShowEditSmallClass&Id=' . $rss['id'] . '&n=' . getRnd(11), $s) ;
                    $smallMenuStr = rtrimVBcrlf($smallMenuStr) . "\n" . CopyStr(' ', 12) . '<li>' . $s . '</li>' . "\n" ;
                }
            }
        }
        if( $smallMenuStr <> '' ){ $c = $c . $smallMenuStr . '</ul>' . "\n" ;}


        $c = $c . CopyStr(' ', 8) . '</li>' . "\n" ;

        if( $isConcise == true ){ $c = $c . CopyStr(' ', 8) . '<li class=line></li>' . "\n" ;}
    }
    if( $isConcise == true ){ $c = $c . CopyStr(' ', 8) . '<li class=right></li>' . "\n" ;}

    if( $styleId <> '' ){
        $c = '<ul class=\'nav' . $styleId . $cssNameAddId . '\'>' . "\n" . $c . "\n" . '</ul>' . "\n" ;
    }

    $handleNavigation = $c ;
    return @$handleNavigation;
}
//Div����վ����
function divTopNavigation($NavDid, $addSql){
    $i=''; $c=''; $s=''; $url=''; $fileName=''; $bigFolder=''; $did=''; $showDid=''; $target=''; $sql ='';
    $sql = 'Select * From [NavBigClass]' ;
    if( $GLOBALS['UserId'] <> '' ){ $sql = GetWhereAnd($sql, ' And UserId=' . $GLOBALS['UserId']) ;}//ָ���û�
    $sql = GetWhereAnd($sql, $addSql) ;
    if( CheckSql($sql) == false ){ eerr('Sql', $sql) ;}
    $rsObj=$GLOBALS['conn']->query( $sql);
    $c = $c . '<li class=left></li>' . "\n" ;
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $fileName = $rs['filename'] ;
        if( $fileName <> '' && substr($fileName, - 1) <> '/' ){ $fileName = $fileName . '.html' ;}
        $bigFolder = '/' . GetWebFolderName() . $rs['foldername'] . '/' ;
        $did = $rs['bigclassname'] ;

        $url = $rs['filename'] ;
        if( CheckRemoteUrl($url) == false ){
            $url = $bigFolder . $fileName ;
            $url = Replace(Replace($url, '//', '/'), '//', '/') ;
            $url = FullHttpUrl(host, $url) ;
            WebDebug($url, 'act=Nav&NavDid=' . $did) ;//����
        }

        $showDid = FontColorFontB($did, $rs['fontb'], $rs['fontcolor']) ;
        $target = $rs['target'] ;
        if( $NavDid == $rs['bigclassname'] ){
            $c = $c . '<li class=focus>' . $showDid . '</li>' . "\n" ;
        }else{
            $c = $c . '<li><a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a></li>' . "\n" ;
        }
        $c = $c . '<li class=line></li>' . "\n" ;
    }
    $c = $c . '<li class=right></li>' . "\n" ;
    $divTopNavigation = $c ;
    return @$divTopNavigation;
}
//��վ�ײ�����            '��ʱ����
function webFootNavigation($addSql){
    $i=''; $c=''; $url=''; $fileName=''; $bigFolder=''; $did=''; $showDid=''; $target=''; $sql ='';
    $sql = 'Select * From [NavBigClass] ' ;
    if( $GLOBALS['UserId'] <> '' ){ $sql = GetWhereAnd($sql, ' And UserId=' . $GLOBALS['UserId']) ;}//ָ���û�
    $sql = GetWhereAnd($sql, $addSql) ;
    $rsObj=$GLOBALS['conn']->query( $sql);
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $fileName = $rs['filename'] ;
        if( $fileName <> '' && substr($fileName, - 1) <> '/' ){ $fileName = $fileName . '.html' ;}

        $bigFolder = '/' . $rs['foldername'] . '/' ;
        $showDid = FontColorFontB($did, $rs['fontb'], $rs['fontcolor']) ;
        $target = $rs['target'] ;
        $did = $rs['bigclassname'] ;

        $url = $rs['filename'] ;
        if( CheckRemoteUrl($url) == false ){
            $url = $bigFolder . $fileName ;
            $url = Replace(Replace($url, '//', '/'), '//', '/') ;
            WebDebug($url, 'act=Nav&NavDid=' . $did) ;//����
        }

        $c = $c . '<a ' . AHref($url, $showDid, $target) . '>' . $showDid . '</a>' ;
        if( $i <> @mysql_num_rows($rsObj) ){ $c = $c . ' &nbsp;| &nbsp; ' ;}
    }
    $webFootNavigation = $c ;
    return @$webFootNavigation;
}
//======================== ������ ==========================
//��õ������Ͷ�Ӧ�ĵ�������  ��
function getNavTypeInName($NavType){
    if( LCase($NavType) == 'home' ){ $NavType = '��ҳ' ;}//׷����20150310
    $getNavTypeInName = GetNavParam('NavBigClass', 'BigClassName', 'Where NavType=\'' . $NavType . '\'') ;
    return @$getNavTypeInName;
}
//��õ�������
function getNavParam( $TableName, $FieldName, $addSql){
    $sql=''; $fileName=''; $url=''; $bigFolder ='';
    $sql = 'Select * From [' . $TableName . '] ' . $addSql ;
    $TempRsObj=$GLOBALS['conn']->query( $sql);
    $temprs=mysql_fetch_array($temprsObj);
    if( @mysql_num_rows($TempRsObj)!=0 ){
        //�������ƻ����ַ
        if( $FieldName == '[url]' ){
            $fileName = $TempRs['filename'] ;
            if( $fileName <> '' && substr($fileName, - 1) <> '/' ){ $fileName = $fileName . '.html' ;}
            $bigFolder = '/' . GetWebFolderName() . $TempRs['foldername'] . '/' ;

            $url = $TempRs['filename'] ;
            if( CheckRemoteUrl($url) == false ){
                $url = $bigFolder . $fileName ;
                $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                $url = FullHttpUrl(host, $url) ;
                WebDebug($url, 'act=Nav&NavDid=' . $rs['bigclassname']) ;//����         Did������20150617
            }

            $getNavParam = $url ;
        }else if( $FieldName <> '' ){
            $getNavParam = $TempRs[$FieldName] ;
        }
    }
    return @$getNavParam;
}





//��ʾ�����б� 201507 10 (�򵥰�)  ������
function XY_CustomNavList($action){
    $did=''; $sid=''; $tid=''; $title=''; $topNumb=''; $cutStrNumb=''; $addSql ='';
    HandleFunParameter($action, $did, $sid, $tid, $title, $topNumb, $cutStrNumb, $addSql) ;//�����ô��������
    XY_AutoAddHandle($action) ;//���������Ϣ����
    $defaultContent=''; $i=''; $j=''; $s=''; $c=''; $startStr=''; $endStr=''; $url=''; $aUrl=''; $aStr=''; $aImg=''; $showTitle=''; $dateTime=''; $imgFile=''; $defaultImage=''; $rndShow=''; $idList=''; $sql ='';
    $DescriptionLabel ='';//��ǩ
    $WebDescription ='';//��վ����
    $Price ='';//�۸�
    $content ='';//����
    $noFollow ='';//��׷�� 20141222
    $defaultContent = GetDefaultValue($action) ;//���Ĭ������
    $AutoAddDid=''; $AutoAddSid=''; $AutoAddTid=''; $AutoAdd ='';
    $ArticleDescription ='';//��������(��Ҫ���)
    $modI ='';//��ѭ��20150112
    $HtmlCode ='';//HTML����
    $splStr=''; $splxx ='';
    $bigFolder=''; $fileName ='';

    $noFollow = AspTrim(LCase(RParam($action, 'noFollow'))) ;//��׷��
    $sql = 'Select * From [NavBigClass] Where NavTop<>0 Order By Sort Asc' ;
    //Call Eerr("Sql=",Sql)
    $rsObj=$GLOBALS['conn']->query( $sql);
    //Call eerr("Sql��"& Rs.RecordCount &"��", Sql)
    for( $i = 1 ; $i<= @mysql_num_rows($rsObj); $i++){
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)==0 ){ break; }
        if( $rs['bigclassname'] == $GLOBALS['PubNavDid'] ){
            $startStr = '[list-focus]' ; $endStr = '[/list-focus]' ;
        }else{
            $startStr = '[list-' . $i . ']' ; $endStr = '[/list-' . $i . ']' ;
        }
        //��[list-mod2]  [/list-mod2]    20150112
        for( $modI = 6 ; $modI>= 2 ; $modI--){
            if( instr($defaultContent, $startStr) == false && $i % $modI == 0 ){
                $startStr = '[list-mod' . $modI . ']' ; $endStr = '[/list-mod' . $modI . ']' ;
                if( instr($defaultContent, $startStr) > 0 ){
                    //Call Echo("ModI=" & ModI & ",I=" & I,StartStr)
                    break;
                }
            }
        }

        //û������Ĭ��
        if( instr($defaultContent, $startStr) == false ){
            $startStr = '[list]' ; $endStr = '[/list]' ;
        }



        if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
            $s = StrCut($defaultContent, $startStr, $endStr, 2) ;


            $fileName = AspTrim($rs['filename']) ;

            if( $fileName <> '' && substr($fileName, - 1) <> '/' && substr($fileName, - 1) <> '\\' ){ $fileName = $fileName . '.html' ;}
            $bigFolder = '/' . GetWebFolderName() . $rs['foldername'] . '/' ;
            $did = $rs['bigclassname'] ;

            $url = $rs['filename'] ;
            if( CheckMakeHtmlFile($url) == true ){
                $url = $bigFolder . $fileName ;
                $url = Replace(Replace($url, '//', '/'), '//', '/') ;
                $url = FullHttpUrl(host, $url) ;
            }
            //20151013�Ľ�
            if( $rs['customaurl'] <> '' ){
                $url = $rs['customaurl'] ;
            }else{
                WebDebug($url, 'act=Nav&NavDid=' . $did) ;//����
            }

            if( instr('|��Ʒ|����|����|', '|' . $rs['navtype'] . '|') > 0 ){
                WebDebug($url, 'act=Nav&NavDid=' . $did . '&Page=1') ;//����
            }

            $aUrl = AHref($url, $rs['bigclassname'], $rs['target']) ;

            $aStr = '<a ' . AHref($url, $rs['bigclassname'], $rs['target']) . SetHtmlParam($action, 'aclass') . IIF($noFollow == 'true', ' rel=\'nofollow\'', '') . '>' . $showTitle . '</a>' . "\n" ;


            $WebDescription = $rs['webdescription'] ;

            $showTitle = CutStr($rs['bigclassname'], $cutStrNumb, '... ') ;
            $showTitle = FontColorFontB($showTitle, $rs['fontb'], $rs['fontcolor']) ;



            for( $j = 1 ; $j<= 3; $j++){
                $s = ReplaceValueParam($s, 'ni', $i) ;//����Ϊi����Ϊi����imgurl��ͻ [$i$]
                $s = ReplaceValueParam($s, '���-1', $i - 1) ;//����Ϊi����Ϊi����imgurl��ͻ [$i$]
                $s = ReplaceValueParam($s, '���', $i) ;//����Ϊi����Ϊi����imgurl��ͻ [$i$]

                //S = ReplaceValueParam(S,"���-1%2",Fix(I/2)-1)                    '����Ϊi����Ϊi����imgurl��ͻ [$i$]




                $s = ReplaceValueParam($s, 'bigclassname', $rs['bigclassname']) ;
                $s = ReplaceValueParam($s, 'title', $rs['bigclassname']) ;
                $s = ReplaceValueParam($s, 'showtitle', $showTitle) ;
                $s = ReplaceValueParam($s, 'url', $url) ;
                $s = ReplaceValueParam($s, 'aurl', $aUrl) ;
                $s = ReplaceValueParam($s, 'astr', $aStr) ;
            }

            $url = '/admin/Product.Asp?act=ShowEditProduct&Id=' . $rs['id'] . '&n=' . getRnd(11) ;
            //S = DisplayOnlineEditDialog(Url, S)

            $s = DisplayOnlineEditDialog('/admin/NavManage.Asp?act=EditNavBig&Id=' . $rs['id'] . '&n=' . getRnd(11), $s) ;


            //��ʼλ�ü�Dialog����
            $startStr = '[list-' . $i . ' startdialog]' ; $endStr = '[/list-' . $i . ' startdialog]' ;
            if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
                $s = StrCut($defaultContent, $startStr, $endStr, 2) . $s ;
            }
            //����λ�ü�Dialog����
            $startStr = '[list-' . $i . ' enddialog]' ; $endStr = '[/list-' . $i . ' enddialog]' ;
            if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
                $s = $s . StrCut($defaultContent, $startStr, $endStr, 2) ;
            }
            $c = $c . $s ;
        }
    }

    //��ʼ���ݼ�Dialog����
    $startStr = '[dialog start]' ; $endStr = '[/dialog start]' ;
    if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
        $c = StrCut($defaultContent, $startStr, $endStr, 2) . $c ;
    }
    //�������ݼ�Dialog����
    $startStr = '[dialog end]' ; $endStr = '[/dialog end]' ;
    if( instr($defaultContent, $startStr) > 0 && instr($defaultContent, $endStr) > 0 ){
        $c = $c . StrCut($defaultContent, $startStr, $endStr, 2) ;
    }
    $XY_CustomNavList = $c ;
    return @$XY_CustomNavList;
}

?>