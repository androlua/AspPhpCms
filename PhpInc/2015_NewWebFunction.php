<?PHP
//新网站函数

//特殊字符替换
function specialStrReplace( $content){
    $content = Replace($content, '\\|', '[$特殊字符A]$') ;
    $content = Replace($content, '\\-', '[$特殊字符B]$') ;
    $content = Replace($content, '\\,', '[$特殊字符C]$') ;
    $content = Replace($content, '\\\'', '[$特殊字符D]$') ;
    $content = Replace($content, '\\"', '[$特殊字符E]$') ;
    $specialStrReplace = $content ;
    return @$specialStrReplace;
}
//解特殊字符替换
function unSpecialStrReplace( $content, $startStr){
    $content = Replace($content, '[$特殊字符A]$', $startStr . '|') ;
    $content = Replace($content, '[$特殊字符B]$', $startStr . '-') ;
    $content = Replace($content, '[$特殊字符C]$', $startStr . ',') ;
    $content = Replace($content, '[$特殊字符D]$', $startStr . '\'') ;
    $content = Replace($content, '[$特殊字符E]$', $startStr . '"') ;
    $unSpecialStrReplace = $content ;
    return @$unSpecialStrReplace;
}

//获得栏目名称对应的id
function getColumnId($columnName){
    $columnName = Replace($columnName, '\'', '') ;//注意，这个不能留
    $getColumnId = -1 ;
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where columnName=\'' . $columnName . '\'');
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnId = $rsx['id'] ;
    }
    return @$getColumnId;
}


//获得栏目ID对应的名称
function getColumnName($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnName = $rsx['columnname'] ;
    }
    return @$getColumnName;
}


//获得栏目url 20160114
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

//获得栏目ID对应的类型
function getColumnType($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnType = $rsx['columntype'] ;
    }
    return @$getColumnType;
}

//获得栏目ID对应的内容
function getColumnBodyContent($columnID){
    $rsxObj=$GLOBALS['conn']->query( 'Select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where id=' . $columnID);
    $rsx=mysql_fetch_array($rsxObj);
    if( @mysql_num_rows($rsxObj)!=0 ){
        $getColumnBodyContent = $rsx['bodycontent'] ;
    }
    return @$getColumnBodyContent;
}

//栏目类型处理 首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单
function handleColumnType($columnName){
    $s ='';
    switch ( $columnName ){
        case '首页' ; $s = 'home';break;
        case '文本' ; $s = 'text';break;
        case '产品' ; $s = 'product';break;
        case '新闻' ; $s = 'news';break;
        case '视频' ; $s = 'video';break;
        case '下载' ; $s = 'download';break;
        case '案例' ; $s = 'case';break;
        case '留言' ; $s = 'message';break;
        case '反馈' ; $s = 'feedback';break;
        case '招聘' ; $s = 'job';break;
        case '订单' ; $s = 'order';
    }
    $handleColumnType = $s ;
    return @$handleColumnType;
}
//显示编辑器20160115
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
//处理网站url20160202
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
//处理在线修改
//MainContent = HandleDisplayOnlineEditDialog("/admin/NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent,"style='float:right;padding:0 4px;'")
function handleDisplayOnlineEditDialog($url, $content, $cssStyle, $replaceStr){
    $controlStr=''; $splStr=''; $s=''; $addOK ='';
    if( @$_REQUEST['gl'] == 'edit' ){
        if( instr($url, '&') > 0 ){
            $url = $url . '&vbgl=true' ;
        }
        $addOK = false ;//添加默认为假
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
            //第一种
            //C = "<div "& ControlStr &">" & vbCrlf
            //C=C & Content & vbCrlf
            //C = C & "</div>" & vbCrlf
            //Content = C
            //第二种
            $content = htmlAddAction($content, $controlStr) ;

            //Content = "<div "& ControlStr &">" & Content & "</div>"
        }
    }
    $handleDisplayOnlineEditDialog = $content ;
    return @$handleDisplayOnlineEditDialog;
}
//获得控制内容
function getControlStr($url){
    if( @$_REQUEST['gl'] == 'edit' ){
        $getControlStr = ' onMouseMove="onColor(this,\'#FDFAC6\',\'red\')" onMouseOut="offColor(this,\'\',\'\')" onDblClick="window1(\'' . $url . '\',\'信息修改\')" title=\'双击在线修改\' oncontextmenu="CommonMenu(event,this,\'\')' ;//删除网址为空
    }
    return @$getControlStr;
}

//html加动作(20151103)  call rw(htmlAddAction("  <a href=""javascript:;"">222222</a>", "onclick=""javascript:alert(111);"" "))
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

