<?PHP
//ASP��PHPͨ�ú���


//������ر�ǩ ��  ���Ľ�
function aritcleRelatedTags($relatedTags){
    $c=''; $splStr=''; $s=''; $url ='';
    $splStr= aspSplit($relatedTags, ',');
    foreach( $splStr as $key=>$s){
        if( $s <> '' ){
            if( $c <> '' ){
                $c= $c . ',';
            }
            $url= getColumnUrl($s, 'name');
            $c= $c . '<a href="' . $url . '" rel="category tag" class="ablue">' . $s . '</a>' . vbCrlf();
        }
    }

    $c= '<footer class="articlefooter">' . vbCrlf() . '��ǩ�� ' . $c . '</footer>' . vbCrlf();
    $aritcleRelatedTags= $c;
    return @$aritcleRelatedTags;
}


//����������id�б�
function getRandArticleId($addSql, $topNumb){
    $splStr=''; $s=''; $c=''; $nIndex ='';
    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail ' . $addSql);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        if( $c <> '' ){ $c= $c . ',' ;}
        $c= $c . $rs['id'];
    }
    $getRandArticleId= randomShow($c, ',', 4);
    $splStr= aspSplit($c, ',') ; $c= '' ; $nIndex= 0;
    foreach( $splStr as $key=>$s){
        if( $c <> '' ){ $c= $c . ',' ;}
        $c= $c . $s;
        $nIndex= $nIndex + 1;
        if( $nIndex >= $topNumb ){ break; }
    }
    $getRandArticleId= $c;
    return @$getRandArticleId;
}
//�����վ��Ŀ����SQL
function getWebColumnSortSql($id){
    $sql='';
    $tempRs2Obj=$GLOBALS['conn']->query('select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $id);
    if( @mysql_num_rows($tempRs2Obj)!=0 ){
        $tempRs2=mysql_fetch_array($tempRs2Obj);

        $sql=$tempRs2['sortsql'];
    }
    $getWebColumnSortSql=$sql;
    return @$getWebColumnSortSql;
}

//��һƪ���� �������sortrank(����)Ҳ���Ը�Ϊid,�����õ�ʱ���Ҫ��id
function upArticle($parentid, $lableName, $lableValue, $ascOrDesc){
    $upArticle= handleUpDownArticle('��һƪ��','uppage',$parentid, $lableName,$lableValue,$ascOrDesc);
    return @$upArticle;
}
//��һƪ����
function downArticle($parentid, $lableName, $lableValue,$ascOrDesc){
    $downArticle= handleUpDownArticle('��һƪ��','downpage', $parentid,$lableName,$lableValue,$ascOrDesc);
    return @$downArticle;
}
//��������ҳ
function handleUpDownArticle($lableTitle,$sType,$parentid, $lableName,$lableValue,$ascOrDesc){
    $c=''; $url='';$target='';$targetStr='';

    $sql='';
    if( $lableName=='adddatetime' ){
        $lableValue='#'. $lableValue .'#';
    }
    //λ�û���
    if( $ascOrDesc=='desc' ){
        if( $sType=='uppage' ){
            $sType='downpage';
        }else{
            $sType='uppage';
        }
    }
    if( $sType=='uppage' ){
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentid=' . $parentid . ' and ' . $lableName . '<' . $lableValue . ' order by ' . $lableName . ' desc';
    }else{
        $sql= 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentid=' . $parentid . ' and ' . $lableName . '>' . $lableValue . ' order by ' . $lableName . ' asc';
    }

    //call echo("sql",sql)
    $rsxObj=$GLOBALS['conn']->query( $sql);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $target=$rsx['target'];
        if( $target<>'' ){
            $targetStr=' target="'. $target .'"';
        }
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/detail' . $rsx['id']);
        }else{
            if( $rsx['customaurl']=='' ){
                $url= handleWebUrl('?act=detail&id=' . $rsx['id']);
            }else{
                $url= handleWebUrl($rsx['customaurl']);
            }
        }
        $c= '<a href="' . $url . '"'. $targetStr .'>' . $lableTitle . $rsx['title'] . '</a>';
    }else{
        $c= $lableTitle . 'û��';
    }
    $handleUpDownArticle= $c;
    return @$handleUpDownArticle;
}
//���RS��ַ ������һҳ ��һҳ
function getRsUrl( $fileName, $customAUrl, $defaultFileName){
    $url ='';
    //��Ĭ���ļ�����
    if( $fileName== '' ){
        $fileName= $defaultFileName;
    }
    //��ַ
    if( $fileName <> '' ){
        $fileName= lCase($fileName); //���ļ�����Сд20160315
        $url= $fileName;
        if( inStr(lCase($url), '.html')== false && right($url, 1) <> '/' ){
            $url= $url . '.html';
        }
    }
    if( aspTrim($customAUrl) <> '' ){
        $url= aspTrim($customAUrl);
    }
    if( inStr($GLOBALS['cfg_flags'], '|addwebsite|') > 0 ){
        //url = replaceGlobleVariable(url)   '�滻ȫ�ֱ���
        if( inStr($url, '$cfg_websiteurl$')== false && inStr($url, '{$GetColumnUrl ')== false && inStr($url, '{$GetArticleUrl ')== false && inStr($url, '{$GetOnePageUrl ')== false ){
            $url= urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url);
        }
    }
    $getRsUrl= $url;
    return @$getRsUrl;
}
//��ô����RS��ַ
function getHandleRsUrl($fileName, $customAUrl, $defaultFileName){
    $url ='';
    $url= getRsUrl($fileName, $customAUrl, $defaultFileName);
    //��ΪURL���Ϊ�Զ��������Ҫ������ȫ�ֱ������������������ֻ���������Ϳ���ʹ������HTML�������������⣬20160308
    $url= replaceGlobleVariable($url);
    $getHandleRsUrl= $url;
    return @$getHandleRsUrl;
}

//��õ�ҳurl 20160114
function getOnePageUrl($title){
    $url ='';
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage where title=\'' . $title . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/page' . $rsx['id']);
        }else{
            $url= handleWebUrl('?act=onepage&id=' . $rsx['id']);
            if( $rsx['customaurl'] <> '' ){
                $url= $rsx['customaurl'];
            }
        }
    }

    $getOnePageUrl= $url;
    return @$getOnePageUrl;
}
//�������
function getArticleUrl($title){
    $url ='';
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where title=\'' . $title . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/' . $rsx['id']);
        }else{
            $url= handleWebUrl('?act=article&id=' . $rsx['id']);
            if( $rsx['customaurl'] <> '' ){
                $url= $rsx['customaurl'];
            }
        }
    }

    $getArticleUrl= $url;
    return @$getArticleUrl;
}
//�����Ŀurl 20160114
function getColumnUrl($columnNameOrId, $sType){
    $url=''; $addSql ='';

    $columnNameOrId= replaceGlobleVariable($columnNameOrId); //������ <a href="{$GetColumnUrl columnname='[$glb_columnName$]' $}" >����ͼƬ</a>

    if( $sType== 'name' ){
        $addSql= ' where columnname=\'' . replace($columnNameOrId,'\'','\'\'') . '\'';			 //��'�Ŵ���Ҫ��Ȼsql��ѯ����20160716
    }else{
        $addSql= ' where id=' . $columnNameOrId . '';
    }
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn' . $addSql);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        if( $GLOBALS['isMakeHtml']== true ){
            $url= getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']);
        }else{
            $url= handleWebUrl('?act=nav&columnName=' . $rsx['columnname']);
            if( $rsx['customaurl'] <> '' ){
                $url= $rsx['customaurl'];
            }
        }
    }

    $getColumnUrl= $url;
    return @$getColumnUrl;
}

//������±����Ӧ��id
function getArticleId($title){
    $title= replace($title, '\'', ''); //ע�⣬���������
    $getArticleId= -1;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'ArticleDetail where title=\'' . $title . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getArticleId= $rsx['id'];
    }
    return @$getArticleId;
}

//�����Ŀ���ƶ�Ӧ��id
function getColumnId($columnName){
    // columnName = Replace(columnName, "'", "")           'ע�⣬���������  ��Ϊsql���Ѿ������� 20160716 home ����д��Խ��Խ��߼�Խ��
    $getColumnId= -1;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where columnName=\'' . $columnName . '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getColumnId= $rsx['id'];
    }
    return @$getColumnId;
}
//��ú�̨�˵����ƶ�Ӧ��id
function getListMenuId($title){
    $title= replace($title, '\'', ''); //ע�⣬���������
    $getListMenuId= -1;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where title=\'' . $title. '\'');
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getListMenuId= $rsx['id'];
    }
    return @$getListMenuId;
}


//�����ĿID��Ӧ������
function getColumnName($id){
    if( $id <> '' ){
        $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $id);
        if( @mysql_num_rows($rsxObj)!=0 ){
            $rsx=mysql_fetch_array($rsxObj);
            $getColumnName= $rsx['columnname'];
        }
    }
    return @$getColumnName;
}

//��ú�̨�˵�ID��Ӧ������
function getListMenuName($id){
    if( $id <> '' ){
        $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'listmenu where id=' . $id);
        if( @mysql_num_rows($rsxObj)!=0 ){
            $rsx=mysql_fetch_array($rsxObj);
            $getListMenuName= $rsx['title'];
        }
    }
    return @$getListMenuName;
}





//�����ĿID��Ӧ������
function getColumnType($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getColumnType= $rsx['columntype'];
    }
    return @$getColumnType;
}


//�����ĿID��Ӧ������
function getColumnBodyContent($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $rsx=mysql_fetch_array($rsxObj);
        $getColumnBodyContent= $rsx['bodycontent'];
    }
    return @$getColumnBodyContent;
}







//��վͳ��2014
function webStat($folderPath){
    $dateTime=''; $content=''; $splStr ='';
    $thisUrl=''; $goToUrl=''; $caiShu=''; $c=''; $fileName=''; $co=''; $ie=''; $xp ='';
    $goToUrl= serverVariables('HTTP_REFERER');
    $thisUrl= 'http://' . serverVariables('HTTP_HOST') . serverVariables('SCRIPT_NAME');
    $caiShu= serverVariables('QUERY_STRING');
    if( $caiShu <> '' ){
        $thisUrl= $thisUrl . '?' . $caiShu;
    }
    $goToUrl= @$_REQUEST['GoToUrl'];
    $thisUrl= @$_REQUEST['ThisUrl'];
    $co= @$_GET['co'];
    $dateTime= now();
    $content= serverVariables('HTTP_USER_AGENT');
    $content= replace($content, 'MSIE', 'Internet Explorer');
    $content= replace($content, 'NT 5.0', '2000');
    $content= replace($content, 'NT 5.1', 'XP');
    $content= replace($content, 'NT 5.2', '2003');

    $splStr= aspSplit($content . ';;;;', ';');
    $ie= $splStr[1];
    $xp= aspTrim($splStr[2]);
    if( right($xp, 1)== ')' ){ $xp= mid($xp, 1, len($xp) - 1) ;}
    $c= '����' . $goToUrl . vbCrlf();
    $c= $c . '��ǰ��' . $thisUrl . vbCrlf();
    $c= $c . 'ʱ�䣺' . $dateTime . vbCrlf();
    $c= $c . 'IP:' . getIP() . vbCrlf();
    $c= $c . 'IE:' . getBrType('') . vbCrlf();
    $c= $c . 'Cookies=' . $co . vbCrlf();
    $c= $c . 'XP=' . $xp . vbCrlf();
    $c= $c . 'Screen=' . @$_REQUEST['screen'] . vbCrlf(); //��Ļ�ֱ���
    $c= $c . '�û���Ϣ=' . serverVariables('HTTP_USER_AGENT') . vbCrlf(); //�û���Ϣ

    $c= $c . '-------------------------------------------------' . vbCrlf();
    //c=c & "CaiShu=" & CaiShu & vbcrlf
    $fileName= $folderPath . Format_Time(now(), 2) . '.txt';
    CreateAddFile($fileName, $c);
    $c= $c . vbCrlf() . $fileName;
    $c= replace($c, vbCrlf(), '\\n');
    $c= replace($c, '"', '\\"');
    //Response.Write("eval(""var MyWebStat=\""" & C & "\"""")")

    $splxx=''; $nIP=''; $nPV=''; $ipList=''; $s=''; $ip ='';
    //�ж��Ƿ���ʾ���Լ�¼
    if( @$_REQUEST['stype']== 'display' ){
        $content= getFText($fileName);
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
        Rw('document.write(\'����ͳ�� | ����IP[' . $nIP . '] | ����PV[' . $nPV . '] \')');
    }
    $webStat= $c;
    return @$webStat;
}

//�жϴ�ֵ�Ƿ����

//HTML��ǩ�����Զ����(target|title|alt|id|class|style|)    ������
function setHtmlParam($content, $ParamList){
    $splStr=''; $startStr=''; $endStr=''; $c=''; $paramValue=''; $ReplaceStartStr ='';
    $endStr= '\'';
    $splStr= aspSplit($ParamList, '|');
    foreach( $splStr as $key=>$startStr){
        $startStr= aspTrim($startStr);
        if( $startStr <> '' ){
            //�滻��ʼ�ַ�   ��Ϊ��ʼ�ַ����Ϳɱ� ��ͬ
            $ReplaceStartStr= $startStr;
            if( left($ReplaceStartStr, 3)== 'img' ){
                $ReplaceStartStr= mid($ReplaceStartStr, 4,-1);
            }else if( left($ReplaceStartStr, 1)== 'a' ){
                $ReplaceStartStr= mid($ReplaceStartStr, 2,-1);
            }else if( inStr('|ul|li|', '|' . left($ReplaceStartStr, 2) . '|') > 0 ){
                $ReplaceStartStr= mid($ReplaceStartStr, 3,-1);
            }
            $ReplaceStartStr= ' ' . $ReplaceStartStr . '=\'';

            $startStr= ' ' . $startStr . '=\'';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
                $paramValue= StrCut($content, $startStr, $endStr, 2);
                $paramValue= HandleInModule($paramValue, 'end'); //�����ڲ�ģ��
                $c= $c . $ReplaceStartStr . $paramValue . $endStr;
            }
        }
    }
    $setHtmlParam= $c;
    return @$setHtmlParam;
}
?>