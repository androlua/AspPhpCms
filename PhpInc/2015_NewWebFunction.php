<?PHP
//����վ����

//�����ַ��滻
function specialStrReplace( $content){
    $content = Replace($content, '\\|', '[$�����ַ�A]$') ;
    $content = Replace($content, '\\-', '[$�����ַ�B]$') ;
    $content = Replace($content, '\\,', '[$�����ַ�C]$') ;
    $content = Replace($content, '\\\'', '[$�����ַ�D]$') ;
    $content = Replace($content, '\\"', '[$�����ַ�E]$') ;
    $specialStrReplace = $content ;
    return @$specialStrReplace;
}
//�������ַ��滻
function unSpecialStrReplace( $content, $startStr){
    $content = Replace($content, '[$�����ַ�A]$', $startStr . '|') ;
    $content = Replace($content, '[$�����ַ�B]$', $startStr . '-') ;
    $content = Replace($content, '[$�����ַ�C]$', $startStr . ',') ;
    $content = Replace($content, '[$�����ַ�D]$', $startStr . '\'') ;
    $content = Replace($content, '[$�����ַ�E]$', $startStr . '"') ;
    $unSpecialStrReplace = $content ;
    return @$unSpecialStrReplace;
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

//��Ŀ���ʹ��� ��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����
function handleColumnType($columnName){
    $s ='';
    switch ( $columnName ){
        case '��ҳ' ; $s = 'home';break;
        case '�ı�' ; $s = 'text';break;
        case '��Ʒ' ; $s = 'product';break;
        case '����' ; $s = 'news';break;
        case '��Ƶ' ; $s = 'video';break;
        case '����' ; $s = 'download';break;
        case '����' ; $s = 'case';break;
        case '����' ; $s = 'message';break;
        case '����' ; $s = 'feedback';break;
        case '��Ƹ' ; $s = 'job';break;
        case '����' ; $s = 'order';
    }
    $handleColumnType = $s ;
    return @$handleColumnType;
}
//��ʾ�༭��20160115
function displayEditor($action){
    $c ='';
    $c = $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shCore.js"></script> ' . "\n" ;
    $c = $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushJScript.js"></script>' . "\n" ;
    $c = $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushPhp.js"></script> ' . "\n" ;
    $c = $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushVb.js"></script> ' . "\n" ;
    $c = $c . '<link type="text/css" rel="stylesheet" href="\\Jquery\\syntaxhighlighter\\styles/shCore.css"/>' . "\n" ;
    $c = $c . '<link type="text/css" rel="stylesheet" href="\\Jquery\\syntaxhighlighter\\styles/shThemeDefault.css"/>' . "\n" ;
    $c = $c . '<script type="text/javascript">' . "\n" ;
    $c = $c . '    SyntaxHighlighter.config.clipboardSwf = \'\\Jquery\\syntaxhighlighter\\scripts/clipboard.swf\';' . "\n" ;
    $c = $c . '    SyntaxHighlighter.all();' . "\n" ;
    $c = $c . '</script>' . "\n" ;

    $displayEditor = $c ;
    return @$displayEditor;
}
//������վurl20160202
function handleWebUrl($url){

    if( @$_REQUEST['gl'] <> '' ){
        $url = getUrlAddToParam($url, '&gl=' . @$_REQUEST['gl'], 'replace') ;
    }
    if( @$_REQUEST['templatedir'] <> '' ){
        $url = getUrlAddToParam($url, '&templatedir=' . @$_REQUEST['templatedir'], 'replace') ;
    }
    $handleWebUrl = $url ;
    return @$handleWebUrl;
}



//
//���������޸�
//MainContent = HandleDisplayOnlineEditDialog("/admin/NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent,"style='float:right;padding:0 4px;'")
function handleDisplayOnlineEditDialog($url, $content, $cssStyle, $replaceStr){
    $controlStr=''; $splStr=''; $s=''; $addOK ='';
    if( @$_REQUEST['gl'] == 'edit' ){
        if( instr($url, '&') > 0 ){
            $url = $url . '&vbgl=true' ;
        }
        $addOK = false ;//���Ĭ��Ϊ��
        $controlStr = getControlStr($url) . '"' . $cssStyle ;
        if( $replaceStr <> '' ){
            $splStr = aspSplit($replaceStr, '|') ;
            foreach( $splStr as $s){
                if( $s <> '' && instr($content, $s) > 0 ){
                    $content = Replace2($content, $s, $s . $controlStr) ;
                    $addOK = true ;
                    break;
                }
            }
        }
        if( $addOK == false ){
            //��һ��
            //C = "<div "& ControlStr &">" & vbCrlf
            //C=C & Content & vbCrlf
            //C = C & "</div>" & vbCrlf
            //Content = C
            //�ڶ���
            $content = htmlAddAction($content, $controlStr) ;

            //Content = "<div "& ControlStr &">" & Content & "</div>"
        }
    }
    $handleDisplayOnlineEditDialog = $content ;
    return @$handleDisplayOnlineEditDialog;
}
//��ÿ�������
function getControlStr($url){
    if( @$_REQUEST['gl'] == 'edit' ){
        $getControlStr = ' onMouseMove="onColor(this,\'#FDFAC6\',\'red\')" onMouseOut="offColor(this,\'\',\'\')" onDblClick="window1(\'' . $url . '\',\'��Ϣ�޸�\')" title=\'˫�������޸�\' oncontextmenu="CommonMenu(event,this,\'\')' ;//ɾ����ַΪ��
    }
    return @$getControlStr;
}

//html�Ӷ���(20151103)  call rw(htmlAddAction("  <a href=""javascript:;"">222222</a>", "onclick=""javascript:alert(111);"" "))
function htmlAddAction($content, $jsAction){
    $s=''; $startStr=''; $endStr=''; $isHandle=''; $lableName ='';
    $s = $content ;
    $s = phptrim($s) ;
    $startStr = mid($s, 1, instr($s, ' ')) ;
    $endStr = '>' ;
    $isHandle = true ;

    $lableName = AspTrim(LCase(Replace($startStr, '<', ''))) ;
    if( instr($s, $startStr) == false || instr($s, $endStr) == false || instr('|a|div|span|font|h1|h2|h3|h4|h5|h6|dt|dd|dl|li|ul|table|tr|td|', '|' . $lableName . '|') == false ){
        $isHandle = false ;
    }

    if( $isHandle == true ){
        $content = $startStr . $jsAction . substr($s, - strlen($s) - strlen($startStr)) ;
    }
    $htmlAddAction = $content ;
    return @$htmlAddAction;
}

?>

