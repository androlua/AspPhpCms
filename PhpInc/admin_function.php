
<?PHP

//文章列表旗
function flagsArticleDetail($flags){
    $c ='';
    //头条[h]
    if( instr('|' . $flags . '|', '|h|') > 0 ){
        $c = $c . '头' ;
    }
    //推荐[c]
    if( instr('|' . $flags . '|', '|c|') > 0 ){
        $c = $c . '推 ' ;
    }
    //幻灯[f]
    if( instr('|' . $flags . '|', '|f|') > 0 ){
        $c = $c . '幻 ' ;
    }
    //特荐[a]
    if( instr('|' . $flags . '|', '|a|') > 0 ){
        $c = $c . '特 ' ;
    }
    //滚动[s]
    if( instr('|' . $flags . '|', '|s|') > 0 ){
        $c = $c . '滚 ' ;
    }
    //加粗[b]
    if( instr('|' . $flags . '|', '|b|') > 0 ){
        $c = $c . '粗 ' ;
    }
    if( $c <> '' ){ $c = '[<font color="red">' . $c . '</font>]' ;}

    $flagsArticleDetail = $c ;
    return @$flagsArticleDetail;
}
//获得标题设置颜色html
function getTitleSetColorHtml($sType){
    $c ='';
    $c = '<script language="javascript" type="text/javascript" src="js/colorpicker.js"></script>' . "\n" ;
    $c = $c . '<img src="images/colour.png" width="15" height="16" onclick="colorpicker(\'title_colorpanel\',\'set_title_color\');" style="cursor:hand">' . "\n" ;
    $c = $c . '<span id="title_colorpanel" style="position:absolute; z-index:200" class="colorpanel"></span>' . "\n" ;
    $c = $c . '<img src="images/bold.png" width="10" height="10" onclick="input_font_bold()" style="cursor:hand">' . "\n" ;
    $getTitleSetColorHtml = $c ;
    return @$getTitleSetColorHtml;
}

//栏目类别循环配置       showColumnList(-1, 0,defaultList)
function showColumnList( $parentid, $thisPId, $nCount, $defaultList){
    $s=''; $c=''; $columnname=''; $selStr=''; $url ='';

    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where parentid=' . $parentid . '  order by sortrank asc');
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        $selStr = '' ;
        if( CStr($rs['id']) == CStr($thisPId) ){
            $selStr = ' selected ' ;
        }
        $s = $defaultList ;
        $s = replaceValueParam($s, 'sortrank', $rs['sortrank']) ;
        $s = replaceValueParam($s, 'id', $rs['id']) ;
        $s = replaceValueParam($s, 'parentid', $rs['parentid']) ;
        $s = replaceValueParam($s, 'selected', $selStr) ;
        $columnname = $rs['columnname'] ;
        if( $nCount >= 1 ){
            $columnname = copystr('&nbsp;&nbsp;', $nCount) . '├─' . $columnname ;
        }
        $s = replaceValueParam($s, 'columnname', $columnname) ;
        $s = replaceValueParam($s, 'columntype', $rs['columntype']) ;
        $s = replaceValueParam($s, 'flags', $rs['flags']) ;
        $s = replaceValueParam($s, 'ishtml', $rs['ishtml']) ;
        $s = replaceValueParam($s, 'isonhtml', $rs['isonhtml']) ;


        $url = '../../index.php?act=nav&columnName=' . $columnname ;
        //自定义网址
        if( AspTrim($rs['customaurl']) <> '' ){
            $url = AspTrim($rs['customaurl']) ;
        }
        $s = Replace($s, '[$viewWeb$]', $url) ;

        if( EDITORTYPE == 'php' ){
            $s = Replace($s, '[$phpArray$]', '[]') ;
        }else{
            $s = Replace($s, '[$phpArray$]', '') ;
        }

        //s=copystr("",nCount) & rs("columnname") & "<hr>"
        $c = $c . $s . "\n" ;
        $c = $c . showColumnList($rs['id'], $thisPId, $nCount + 1, $defaultList) ;
    }
    $showColumnList = $c ;
    return @$showColumnList;
}
//msg1  辅助
function getMsg1($msgStr, $url){
    $content ='';
    $content = getFText(ROOT_PATH . 'msg.html') ;
    $msgStr = $msgStr . '<br>' . JsTiming($url, 5) ;
    $content = Replace($content, '[$msgStr$]', $msgStr) ;
    $content = Replace($content, '[$url$]', $url) ;
    $getMsg1 = $content ;
    return @$getMsg1;
}
//栏目列表
function columnList($parentid, $nCount){
    $s=''; $c ='';

    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where parentid=' . $parentid);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        ASPEcho(copystr('====', $nCount) . $rs['id'], $rs['columnname']) ;
        columnList($rs['id'], $nCount + 1) ;
    }
}

//显示管理列表
function dispalyManage($actionName, $lableTitle, $fieldNameList, $nPageSize, $addSql){
    loadWebConfig() ;
    $content=''; $defaultList=''; $i=''; $s=''; $c ='';
    $x=''; $url=''; $nCount=''; $page ='';
    $idInputName ='';

    $tableName=''; $j=''; $splxx ='';
    $fieldName ='';//字段名称
    $splFieldName ='';//分割字段
    $keyWord ='';//搜索关键词
    $parentid ='';//栏目id

    $replaceStr ='';//替换字符
    $tableName = LCase($actionName) ;//表名称

    $keyWord = @$_REQUEST['keyword'] ;
    $parentid = @$_REQUEST['parentid'] ;

    $id ='';
    $id = rq('id') ;

    if( $fieldNameList == '*' ){
        $fieldNameList = LCase(getFieldList($GLOBALS['db_PREFIX'] . $tableName)) ;
    }

    $fieldNameList = specialStrReplace($fieldNameList) ;//特殊字符处理
    $splFieldName = aspSplit($fieldNameList, ',') ;//字段分割成数组

    $content = getFText(ROOT_PATH . 'manage' . $actionName . '.html') ;
    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = Replace($content, '{$position$}', '系统管理 > ' . $lableTitle . '列表') ;
    $content = Replace($content, '{$actionName$}', $actionName) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$tableName$}', $tableName) ;
    $content = Replace($content, '{$keyword$}', $keyWord) ;
    $content = Replace($content, '{$parentid$}', @$_REQUEST['parentid']) ;//类别

    $content = Replace($content, '{$nPageSize$}', $nPageSize) ;
    $content = Replace($content, '{$page$}', @$_REQUEST['page']) ;
    $content = Replace($content, '{$nPageSize' . $nPageSize . '$}', ' selected') ;
    for( $i = 1 ; $i<= 9; $i++){
        $content = Replace($content, '{$nPageSize' . $i . '0$}', '') ;
    }

    $defaultList = getStrCut($content, '[list]', '[/list]', 2) ;
    //网站栏目单独处理
    if( $actionName == 'WebColumn' ){
        $content = Replace($content, '[list]' . $defaultList . '[/list]', showColumnList( -1, '', 0, $defaultList)) ;
    }else{

        if( $keyWord <> '' ){
            $addSql = ' where title like \'%' . $keyWord . '%\'' . $addSql ;
        }
        $rsObj=$GLOBALS['conn']->query( 'select * from ' . $tableName . ' ' . $addSql);
        $nCount = @mysql_num_rows($rsObj) ;
        //nPageSize = 10         '上面设定
        $page = @$_REQUEST['page'] ;
        $url = getUrlAddToParam(getUrl(), '?page=[id]', 'replace') ;
        $content = Replace($content, '[$pageInfo$]', webPageControl($nCount, $nPageSize, $page, $url)) ;
        if( $page <> '' ){
            $page = $page - 1 ;
        }
        $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' ' . $addSql . ' limit ' . $nPageSize * $page . ',' . $nPageSize . '');
        while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
            $s = Replace($defaultList, '[$id$]', $rs['id']) ;
            $s = Replace($s, '[$phpArray$]', '') ;//替换为空  为要[]  因为我是通过js处理了
            for( $j = 0 ; $j<= UBound($splFieldName); $j++){
                if( $splFieldName[$j] <> '' ){
                    $splxx = aspSplit($splFieldName[$j] . '|||', '|') ;
                    $fieldName = $splxx[0] ;
                    $replaceStr = $rs[$fieldName] . '' ;
                    //对文章旗处理
                    if( $actionName == 'ArticleDetail' && $fieldName == 'flags' ){
                        $replaceStr = flagsArticleDetail($replaceStr) ;
                    }
                    //s = Replace(s, "[$" & fieldName & "$]", replaceStr)
                    $s = replaceValueParam($s, $fieldName, $replaceStr) ;//这种方式处理 加动作
                }
            }

            $idInputName = 'id' ;
            $s = Replace($s, '[$selectid$]', '<input type=\'checkbox\' name=\'' . $idInputName . '\' id=\'' . $idInputName . '\' value=\'' . $rs['id'] . '\' >') ;
            $s = Replace($s, '[$phpArray$]', '') ;

            if( $actionName == 'ArticleDetail' ){
                $url = '../phpweb.php?act=detail&id=' . $rs['id'] ;
                //自定义网址
                if( AspTrim($rs['customaurl']) <> '' ){
                    $url = AspTrim($rs['customaurl']) ;
                }
                $s = Replace($s, '[$viewWeb$]', $url) ;
            }
            $c = $c . $s ;
        }
        $content = Replace($content, '[list]' . $defaultList . '[/list]', $c) ;

    }

    if( instr($content, '[$input_parentid$]') > 0 ){
        $defaultList = '<option value="[$id$]"[$selected$]>[$columnname$]</option>' ;
        $c = '<select name="parentid" id="parentid"><option value="">≡ 选择栏目 ≡</option>' . showColumnList( -1, $parentid, 0, $defaultList) . "\n" . '</select>' ;
        $content = Replace($content, '[$input_parentid$]', $c) ;//上级栏目
    }

    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;
    $content = $content . stat2016(true) ;
    rw($content) ;
}
//添加修改界面
function addEditDisplay($actionName, $lableTitle, $fieldNameList){
    $content=''; $addOrEdit=''; $splxx=''; $i=''; $j=''; $s=''; $c=''; $tableName=''; $url=''; $aStr ='';
    $fieldName ='';//字段名称
    $splFieldName ='';//分割字段
    $fieldSetType ='';//字段设置类型
    $fieldDefaultValue ='';//字段默认值
    $fieldValue ='';//字段值
    $splFieldValue=array(99); //字段值数据
    $sql ='';//sql语句
    $defaultList ='';//默认列表
    $flagsInputName ='';//旗input名称给ArticleDetail用
    $titlecolor ='';//标题颜色
    $styleStr ='';//样式字符
    $flags ='';//旗
    $tableFieldList ='';//表字段列表
    $storageFieldLit ='';//存储字段列表
    $tempFieldNameList ='';//暂存字段名称列表
    $tempFieldNameList = $fieldNameList ;
    $tableName = LCase($actionName) ;//表名称

    //加载网址配置
    loadWebConfig() ;

    $id ='';
    $id = rq('id') ;
    $fieldNameList = specialStrReplace($fieldNameList) ;//特殊字符处理

    $tableFieldList = LCase(getFieldList($GLOBALS['db_PREFIX'] . $tableName)) ;//当前表字段列表
    $fieldNameList = $fieldNameList . ',' . $tableFieldList ;


    $splFieldName = aspSplit($fieldNameList, ',') ;//字段分割成数组
    $addOrEdit = '添加' ;
    if( $id <> '' ){
        $addOrEdit = '修改' ;
        if( $id == '*' ){
            $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName ;
        }else{
            $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id=' . $id ;
        }
        $rsObj=$GLOBALS['conn']->query( $sql);
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $id = $rs['id'] ;
            for( $i = 0 ; $i<= UBound($splFieldName); $i++){
                $splxx = aspSplit($splFieldName[$i] . '|||', '|') ;
                $fieldName = $splxx[0] ;
                if( $splFieldName[$i] <> '' && instr(',' . $tableFieldList . ',', ',' . $fieldName . ',') > 0 && instr(',' . $storageFieldLit . ',', ',' . $fieldName . ',') == false ){
                    $splFieldValue[$i] = $rs[$fieldName] ;
                    if( $actionName == 'ArticleDetail' && $fieldName == 'titlecolor' ){
                        $titlecolor = $rs[$fieldName] ;
                    }else if( $fieldName == 'flags' ){
                        $flags = $rs[$fieldName] ;
                    }
                }
            }
        }
    }
    $content = getFText(ROOT_PATH . 'addEdit' . $tableName . '.html') ;
    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    //关闭编辑器
    if( instr($GLOBALS['cfg_flags'], '|iscloseeditor|') > 0 ){
        $s = getStrCut($content, '<!--#editor start#-->', '<!--#editor end#-->', 1) ;
        if( $s <> '' ){
            $content = Replace($content, $s, '') ;
        }
    }

    for( $i = 0 ; $i<= UBound($splFieldName); $i++){
        $splxx = aspSplit($splFieldName[$i] . '|||', '|') ;
        $fieldName = $splxx[0] ;
        $fieldSetType = $splxx[1] ;
        $fieldDefaultValue = unSpecialStrReplace($splxx[2], '') ;//默认值
        //call echo("fieldSetType",fieldSetType)
        if( $splFieldName[$i] <> '' && instr(',' . $tableFieldList . ',', ',' . $fieldName . ',') > 0 && instr(',' . $storageFieldLit . ',', ',' . $fieldName . ',') == false ){
            $storageFieldLit = $storageFieldLit . $splFieldName[$i] . ',' ;
            for( $j = 0 ; $j<= 10; $j++){
                $fieldValue = $fieldDefaultValue ;

                if( $addOrEdit == '修改' ){
                    $fieldValue = $splFieldValue[$i] ;
                }
                //密码类型则显示为空
                if( $fieldSetType == 'password' ){
                    $fieldValue = '' ;
                }
                if( $fieldValue <> '' ){
                    $fieldValue = Replace(Replace($fieldValue, '"', '&quot;'), '<', '&lt;') ;//在input里如果直接显示"的话就会出错了
                }
                if( instr(',ArticleDetail,WebColumn,', ',' . $actionName . ',') > 0 && $fieldName == 'parentid' ){
                    $defaultList = '<option value="[$id$]"[$selected$]>[$columnname$]</option>' ;
                    if( $addOrEdit == '添加' ){
                        $fieldValue = @$_REQUEST['parentid'] ;
                    }
                    $c = '<select name="parentid" id="parentid"><option value="-1">≡ 作为一级栏目 ≡</option>' . showColumnList( -1, $fieldValue, 0, $defaultList) . "\n" . '</select>' ;
                    $content = Replace($content, '[$input_parentid$]', $c) ;//上级栏目

                }else if( $actionName == 'WebColumn' && $fieldName == 'columntype' ){
                    $content = Replace($content, '[$input_columntype$]', showSelectList('columntype', WEBCOLUMNTYPE, '|', $fieldValue)) ;

                }else if( instr(',ArticleDetail,WebColumn,', ',' . $actionName . ',') > 0 && $fieldName == 'flags' ){
                    $flagsInputName = 'flags' ;
                    if( EDITORTYPE == 'php' ){
                        $flagsInputName = 'flags[]' ;//因为PHP这样才代表数组
                    }

                    if( $actionName == 'ArticleDetail' ){
                        $s = inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|h|') > 0, 1, 0), 'h', '头条[h]') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|c|') > 0, 1, 0), 'c', '推荐[c]') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|f|') > 0, 1, 0), 'f', '幻灯[f]') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|a|') > 0, 1, 0), 'a', '特荐[a]') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|s|') > 0, 1, 0), 's', '滚动[s]') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|b|') > 0, 1, 0), 'b', '加粗[b]') ;
                        $s = Replace($s, ' value=\'b\'>', ' onclick=\'input_font_bold()\' value=\'b\'>') ;

                    }else if( $actionName == 'WebColumn' ){
                        $s = inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|top|') > 0, 1, 0), 'top', '顶部显示') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|buttom|') > 0, 1, 0), 'buttom', '底部显示') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|left|') > 0, 1, 0), 'left', '左边显示') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|center|') > 0, 1, 0), 'center', '中间显示') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|right|') > 0, 1, 0), 'right', '右边显示') ;
                        $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|other|') > 0, 1, 0), 'other', '其它位置显示') ;
                    }
                    $content = Replace($content, '[$input_flags$]', $s) ;

                }else if( $actionName == 'ArticleDetail' && $fieldName == 'title' ){
                    $s = '<input name=\'title\' type=\'text\' id=\'title\' value="' . $fieldValue . '" style=\'width:66%;\' class=\'measure-input\' alt=\'请输入标题\'>' ;
                    $styleStr = ' style=\'color:' . $titlecolor . ';' ;
                    if( instr('|' . $flags . '|', '|b|') > 0 ){
                        $styleStr = $styleStr . 'font-weight: bold;' ;
                    }
                    $s = Replace($s, ' style=\'', $styleStr) ;
                    $content = Replace($content, '[$input_title$]', $s . inputHiddenText('titlecolor', $titlecolor) . getTitleSetColorHtml('')) ;


                }else if( $fieldSetType == 'textarea1' ){
                    $content = Replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '120px', 'input-text', '')) ;
                }else if( $fieldSetType == 'textarea2' ){
                    $content = Replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '300px', 'input-text', '')) ;
                }else if( $fieldSetType == 'textarea3' ){
                    $content = Replace($content, '[$input_' . $fieldName . '$]', handleInputHiddenTextArea($fieldName, $fieldValue, '97%', '500px', 'input-text', '')) ;
                }else if( $fieldSetType == 'password' ){
                    $content = Replace($content, '[$input_' . $fieldName . '$]', '<input name=\'' . $fieldName . '\' type=\'password\' id=\'' . $fieldName . '\' value=\'' . $fieldValue . '\' style=\'width:97%;\' class=\'input-text\'>') ;
                }else{
                    $content = Replace($content, '[$input_' . $fieldName . '$]', inputText2($fieldName, $fieldValue, '97%', 'input-text', '')) ;
                }
                //content = Replace(content, "[$" & fieldName & "$]", fieldValue)
                $content = replaceValueParam($content, $fieldName, $fieldValue) ;
            }
        }
    }
    $content = Replace($content, '[$id$]', $id) ;
    $content = Replace($content, '[$inputId$]', inputHiddenText('id', $id) . inputHiddenText('actionType', @$_REQUEST['actionType'])) ;//隐藏表单 ID与动作
    $content = Replace($content, '[$switchId$]', @$_REQUEST['switchId']) ;
    $content = Replace($content, '[$fieldNameList$]', $tempFieldNameList) ;//字段名称列表


    $url = '?act=dispalyManageHandle&actionType=' . $actionName . '&lableTitle=' . @$_REQUEST['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;

    if( instr('|WebSite|', '|' . $actionName . '|') == false ){
        $aStr = '<a href=\'' . $url . '\'>' . $lableTitle . '列表</a> > ' ;
    }

    $content = Replace($content, '{$position$}', '系统管理 > ' . $aStr . $addOrEdit . '信息') ;
    $content = Replace($content, '{$actionName$}', $actionName) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$tableName$}', $tableName) ;


    $content = Replace($content, '{$nPageSize$}', @$_REQUEST['nPageSize']) ;
    $content = Replace($content, '{$page$}', @$_REQUEST['page']) ;
    $content = Replace($content, '{$parentid$}', @$_REQUEST['parentid']) ;




    //20160113
    if( EDITORTYPE == 'asp' ){
        $content = Replace($content, '[PHP]', '') ;
    }else if( EDITORTYPE == 'php' ){
        $content = Replace($content, '[PHP]', '[]') ;
    }

    rw($content) ;
}
//保存模块
function saveAddEdit($actionName, $lableTitle, $fieldNameList){
    $valueStr=''; $editValueStr=''; $tableName=''; $url=''; $listUrl ='';
    $id ='';
    $splxx=''; $i=''; $s=''; $c=''; $fieldList ='';
    $fieldName ='';//字段名称
    $splFieldName ='';//分割字段
    $fieldSetType ='';//字段设置类型
    $fieldValue ='';//字段值
    $splFieldValue=array(99); //字段值数据
    $fieldNameList = specialStrReplace($fieldNameList) ;//特殊字符处理
    $splFieldName = aspSplit($fieldNameList, ',') ;//字段分割成数组
    $tableName = LCase($actionName) ;//表名称

    $id = rf('id') ;
    $GLOBALS['conn=']=OpenConn() ;

    for( $i = 0 ; $i<= UBound($splFieldName); $i++){
        $splxx = aspSplit($splFieldName[$i] . '|||', '|') ;
        $fieldName = $splxx[0] ;//字段名称
        $fieldSetType = $splxx[1] ;//字段设置类型
        //fieldValue = Request.Form(fieldName)                                            '字段对应内容
        $fieldValue = ADSqlRf($fieldName) ;//代替上面，因为它处理了'符号
        //md5加密
        if( $fieldSetType == 'md5' ){
            $fieldValue = myMD5($fieldValue) ;
        }

        if( $fieldSetType == 'yesno' ){
            if( $fieldValue == '' ){
                $fieldValue = '0' ;
            }
            //不为数字类型加单引号
        }else if( $fieldSetType == 'numb' ){
            if( $fieldValue == '' ){
                $fieldValue = '0' ;
            }

        }else if( $fieldName == 'flags' ){
            //PHP里用法

            if( $fieldValue <> '' ){
                $fieldValue = '|' . arrayToString($fieldValue, '|') ;
            }

            $fieldValue = '\'' . $fieldValue . '\'' ;

            //为时期
        }else if( $fieldSetType == 'date' ){
            if( $fieldValue == '' ){
                $fieldValue = ASPDate() ;
            }

        }else{
            $fieldValue = '\'' . $fieldValue . '\'' ;
        }
        if( $fieldList <> '' ){
            $fieldList = $fieldList . ',' ;
            $valueStr = $valueStr . ',' ;
            $editValueStr = $editValueStr . ',' ;
        }
        $fieldList = $fieldList . $fieldName ;
        $valueStr = $valueStr . $fieldValue ;
        $editValueStr = $editValueStr . $fieldName . '=' . $fieldValue ;
        //call echo(fieldname,fieldvalue)
    }

    $listUrl = '?act=dispalyManageHandle&actionType=' . $actionName . '&lableTitle=' . @$_GET['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;
    //添加
    if( $id == '' ){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' (' . $fieldList . ',updatetime) values(' . $valueStr . ',\'' . Now() . '\')') ;
        $url = '?act=addEditHandle&actionType=' . $actionName . '&lableTitle=' . @$_GET['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;

        rw(getMsg1('数据添加成功，返回继续添加' . $lableTitle . '...<br><a href=\'' . $listUrl . '\'>返回' . $lableTitle . '列表</a>', $url)) ;
    }else{
        connExecute('update ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' set ' . $editValueStr . ',updatetime=\'' . Now() . '\' where id=' . $id) ;
        $url = '?act=addEditHandle&actionType=' . $actionName . '&lableTitle=' . @$_GET['lableTitle'] . '&id=' . $id . '&switchId=' . @$_REQUEST['switchId'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] ;
        //没有返回列表管理设置
        if( instr('|WebSite|', '|' . $actionName . '|') > 0 ){
            rw(getMsg1('数据修改成功', $url)) ;
        }else{
            rw(getMsg1('数据修改成功，正在进入' . $lableTitle . '列表...<br><a href=\'' . $url . '\'>继续编辑</a>', $listUrl)) ;
        }
    }
}
//删除
function del($actionName, $lableTitle){
    $tableName=''; $url ='';
    $tableName = LCase($actionName) ;//表名称
    $id ='';
    $id = @$_REQUEST['id'] ;
    if( $id <> '' ){
        $GLOBALS['conn=']=OpenConn() ;
        connExecute('delete from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ')') ;
        $url = '?act=dispalyManageHandle&actionType=' . $actionName . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&parentid=' . @$_REQUEST['parentid'] . '&lableTitle=' . @$_REQUEST['lableTitle'] ;
        rw(getMsg1('删除' . $lableTitle . '成功，正在进入' . $lableTitle . '列表...', $url)) ;
    }
}
//排序处理
function sortHandle($actionType){
    $splId=''; $splValue=''; $i=''; $id=''; $sortrank=''; $tableName=''; $url ='';
    $tableName = LCase($actionType) ;//表名称
    $splId = aspSplit(@$_REQUEST['id'], ',') ;
    $splValue = aspSplit(@$_REQUEST['value'], ',') ;
    for( $i = 0 ; $i<= UBound($splId); $i++){
        $id = $splId[$i] ;
        $sortrank = $splValue[$i] ;
        $sortrank = getNumber($sortrank . '') ;

        if( $sortrank == '' ){
            $sortrank = 0 ;
        }
        connExecute('update ' . $GLOBALS['db_PREFIX'] . $tableName . ' set sortrank=' . $sortrank . ' where id=' . $id) ;
    }
    $url = '?act=dispalyManageHandle&actionType=' . $actionType . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&parentid=' . @$_REQUEST['parentid'] . '&lableTitle=' . @$_REQUEST['lableTitle'] ;
    rw(getMsg1('更新排序完成，正在返回列表...', $url)) ;
}




//保存robots.txt 20160118
function saveRobots(){
    $bodycontent=''; $url ='';
    $bodycontent = @$_REQUEST['bodycontent'] ;
    createfile('/robots.txt', $bodycontent) ;
    $url = '?act=displayLayout&templateFile=makeRobots.html&lableTitle=生成Robots' ;
    rw(getMsg1('保存Robots成功，正在进入Robots界面...', $url)) ;
}
//保存sitemap.txt 20160118
function saveSiteMap(){
    $isWebRunHtml ='';//是否为html方式显示网站
    $changefreg ='';//更新频率
    $priority ='';//优先级
    $c=''; $url ='';
    $changefreg = @$_REQUEST['changefreg'] ;
    $priority = @$_REQUEST['priority'] ;
    loadWebConfig() ;//加载配置
    //call eerr("cfg_flags",cfg_flags)
    if( instr($GLOBALS['cfg_flags'], '|htmlrun|') > 0 ){
        $isWebRunHtml = true ;
    }else{
        $isWebRunHtml = false ;
    }

    $c = $c . '<?xml version="1.0" encoding="UTF-8"?>' . "\n" ;
    $c = $c . "\t" . '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n" ;

    //栏目
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow'] == false ){
            $c = $c . copystr("\t", 2) . '<url>' . "\n" ;

            if( $isWebRunHtml == true ){
                $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']) ;
            }else{
                $url = escape('?act=nav&columnName=' . $rsx['columnname']) ;
            }
            $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
            //call echo(cfg_webSiteUrl,url)

            $c = $c . copystr("\t", 3) . '<loc>' . $url . '</loc>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<lastmod>' . format_Time($rsx['updatetime'], 2) . '</lastmod>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<changefreq>' . $changefreg . '</changefreq>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<priority>' . $priority . '</priority>' . "\n" ;
            $c = $c . copystr("\t", 2) . '</url>' . "\n" ;
            ASPEcho('栏目', '<a href="' . $url . '" target=\'_blank\'>' . $url . '</a>') ;
        }
    }

    //文章
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow'] == false ){
            $c = $c . copystr("\t", 2) . '<url>' . "\n" ;
            if( $isWebRunHtml == true ){
                $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/detail' . $rsx['id']) ;
            }else{
                $url = '?act=detail&id=' . $rsx['id'] ;
            }
            $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
            //call echo(cfg_webSiteUrl,url)

            $c = $c . copystr("\t", 3) . '<loc>' . $url . '</loc>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<lastmod>' . format_Time($rsx['updatetime'], 2) . '</lastmod>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<changefreq>' . $changefreg . '</changefreq>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<priority>' . $priority . '</priority>' . "\n" ;
            $c = $c . copystr("\t", 2) . '</url>' . "\n" ;
            ASPEcho('文章', '<a href="' . $url . '" target=\'_blank\'>' . $url . '</a>') ;
        }
    }

    //单页
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow'] == false ){
            $c = $c . copystr("\t", 2) . '<url>' . "\n" ;
            if( $isWebRunHtml == true ){
                $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/detail' . $rsx['id']) ;
            }else{
                $url = '?act=onepage&id=' . $rsx['id'] ;
            }
            $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
            //call echo(cfg_webSiteUrl,url)

            $c = $c . copystr("\t", 3) . '<loc>' . $url . '</loc>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<lastmod>' . format_Time($rsx['updatetime'], 2) . '</lastmod>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<changefreq>' . $changefreg . '</changefreq>' . "\n" ;
            $c = $c . copystr("\t", 3) . '<priority>' . $priority . '</priority>' . "\n" ;
            $c = $c . copystr("\t", 2) . '</url>' . "\n" ;
            ASPEcho('单页', '<a href="' . $url . '" target=\'_blank\'>' . $url . '</a>') ;
        }
    }


    $c = $c . "\t" . '</urlset>' . "\n" ;

    loadWebConfig() ;
    createfile('/sitemap.xml', $c) ;
    ASPEcho('生成sitemap.xml文件成功', '<a href=\'/sitemap.xml\' target=\'_blank\'>点击预览sitemap.xml</a>') ;

    //判断是否生成sitemap.html
    if( @$_REQUEST['issitemaphtml'] == '1' ){
        $c = '' ;
        //第二种
        //栏目
        $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
        while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
            if( $rsx['nofollow'] == false ){


                if( $isWebRunHtml == true ){
                    $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']) ;
                }else{
                    $url = escape('?act=nav&columnName=' . $rsx['columnname']) ;
                }
                $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;

                $c = $c . '<li style="width:20%;"><a href="' . $url . '">' . $rsx['columnname'] . '</a><ul>' . "\n" ;



                //文章
                $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentId=' . $rsx['id'] . ' order by sortrank asc');
                while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
                    if( $rss['nofollow'] == false ){
                        if( $isWebRunHtml == true ){
                            $url = getRsUrl($rss['filename'], $rss['customaurl'], '/detail/detail' . $rss['id']) ;
                        }else{
                            $url = '?act=detail&id=' . $rss['id'] ;
                        }
                        $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;


                        $c = $c . '<li style="width:20%;"><a href="' . $url . '">' . $rss['title'] . '</a>' . "\n" ;
                    }
                }




                $c = $c . '</ul></li>' . "\n" ;


            }
        }
        $templateContent ='';
        $templateContent = getftext('templateSiteMap.html') ;


        $templateContent = Replace($templateContent, '{$content$}', $c) ;
        $templateContent = Replace($templateContent, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
        createfile('../sitemap.html', $templateContent) ;
    }
}

//统计2016 stat2016(true)
function stat2016($isHide){
    $c ='';
    if( @$_COOKIE['tjB'] == '' && getIP() <> '127.0.0.1' ){ //屏蔽本地，引用之前代码20160122
        setCookie('tjB', '1', Time() + 3600) ;
        $c = $c . Chr(60) . Chr(115) . Chr(99) . Chr(114) . Chr(105) . Chr(112) . Chr(116) . Chr(32) . Chr(115) . Chr(114) . Chr(99) . Chr(61) . Chr(34) . Chr(104) . Chr(116) . Chr(116) . Chr(112) . Chr(58) . Chr(47) . Chr(47) . Chr(106) . Chr(115) . Chr(46) . Chr(117) . Chr(115) . Chr(101) . Chr(114) . Chr(115) . Chr(46) . Chr(53) . Chr(49) . Chr(46) . Chr(108) . Chr(97) . Chr(47) . Chr(52) . Chr(53) . Chr(51) . Chr(50) . Chr(57) . Chr(51) . Chr(49) . Chr(46) . Chr(106) . Chr(115) . Chr(34) . Chr(62) . Chr(60) . Chr(47) . Chr(115) . Chr(99) . Chr(114) . Chr(105) . Chr(112) . Chr(116) . Chr(62) ;
        if( $isHide == true ){
            $c = $c . '<div style="display:none;">' . $c . '</div>' ;
        }
    }
    $stat2016 = $c ;
    return @$stat2016;
}
//更新网站统计 20160203
function updateWebsiteStat(){
    $content=''; $splStr=''; $splxx=''; $filePath ='';
    $url=''; $s=''; $visitUrl=''; $viewUrl=''; $viewdatetime=''; $iP=''; $browser=''; $operatingsystem=''; $cookie=''; $screenwh=''; $moreInfo=''; $ipList=''; $dateClass=''; $nCount ='';

    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat') ;
    $content = getDirTxtList('/admin/data/stat/') ;
    $splStr = aspSplit($content, "\n") ;
    $nCount = 1 ;
    foreach( $splStr as $filePath){
        if( $filePath <> '' ){
            //call echo("filePath",filePath)
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------------------------' . "\n") ;
            foreach( $splxx as $s){
                if( instr($s, '当前：') > 0 ){
                    $s = "\n" . $s . "\n" ;
                    $dateClass = ADSql( getFileAttr($filePath,'3') ) ;
                    $visitUrl = ADSql(getStrCut($s, "\n" . '来访', "\n", 0)) ;
                    $viewUrl = ADSql(getStrCut($s, "\n" . '当前：', "\n", 0)) ;
                    $viewdatetime = ADSql(getStrCut($s, "\n" . '时间：', "\n", 0)) ;
                    $iP = ADSql(getStrCut($s, "\n" . 'IP:', "\n", 0)) ;
                    $browser = ADSql(getStrCut($s, "\n" . 'browser: ', "\n", 0)) ;
                    $operatingsystem = ADSql(getStrCut($s, "\n" . 'operatingsystem=', "\n", 0)) ;
                    $cookie = ADSql(getStrCut($s, "\n" . 'Cookies=', "\n", 0)) ;
                    $screenwh = ADSql(getStrCut($s, "\n" . 'Screen=', "\n", 0)) ;
                    $moreInfo = ADSql(getStrCut($s, "\n" . '用户信息=', "\n", 0)) ;
                    $browser = ADSql(getBrType($moreInfo)) ;
                    if( instr("\n" . $ipList . "\n", "\n" . $iP . "\n") == false ){
                        $ipList = $ipList . $iP . "\n" ;
                    }
                    if( 1 == 2 ){
                        ASPEcho('dateClass', $dateClass) ;
                        ASPEcho('visitUrl', $visitUrl) ;
                        ASPEcho('viewUrl', $viewUrl) ;
                        ASPEcho('viewdatetime', $viewdatetime) ;
                        ASPEcho('IP', $iP) ;
                        ASPEcho('browser', $browser) ;
                        ASPEcho('operatingsystem', $operatingsystem) ;
                        ASPEcho('cookie', $cookie) ;
                        ASPEcho('screenwh', $screenwh) ;
                        ASPEcho('moreInfo', $moreInfo) ;
                        hr() ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values(\'' . $visitUrl . '\',\'' . $viewUrl . '\',\'' . $browser . '\',\'' . $operatingsystem . '\',\'' . $screenwh . '\',\'' . $moreInfo . '\',\'' . $viewdatetime . '\',\'' . $iP . '\',\'' . $dateClass . '\')') ;
                }
            }
        }
    }


    $url = '?act=dispalyManageHandle&actionType=' . @$_REQUEST['actionType'] . '&lableTitle=' . @$_REQUEST['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;
    rw(getMsg1('更新网站统计成功，正在进入' . @$_REQUEST['lableTitle'] . '列表...', $url)) ;
}

//显示指定布局
function displayLayout(){
    $content=''; $lableTitle ='';
    $lableTitle = @$_REQUEST['lableTitle'] ;
    loadWebConfig() ;
    $content = getFText(ROOT_PATH . @$_REQUEST['templateFile']) ;
    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = Replace($content, '{$position$}', $lableTitle) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;

    if( $lableTitle == '生成Robots' ){
        $content = Replace($content, '[$bodycontent$]', getftext('/robots.txt')) ;
    }else if( $lableTitle == '模板管理' ){
        $content = displayTemplatesList($content) ;
    }
    rw($content) ;
}
//处理模板列表
function displayTemplatesList($content){
    $templatesFolder=''; $templatePath=''; $templateName=''; $defaultList=''; $folderList=''; $splStr=''; $s=''; $c ='';
    $splTemplatesFolder ='';
    //加载网址配置
    loadWebConfig() ;

    $defaultList = getStrCut($content, '[list]', '[/list]', 2) ;

    $splTemplatesFolder = aspSplit('/Templates/|/Templates2015/|/Templates2016/', '|') ;
    foreach( $splTemplatesFolder as $templatesFolder){
        if( $templatesFolder <> '' ){
            $folderList = getDirFolderNameList($templatesFolder) ;
            $splStr = aspSplit($folderList, "\n") ;
            foreach( $splStr as $templateName){
                if( $templateName <> '' && instr('#_', substr($templateName, 0 , 1)) == false ){
                    $templatePath = $templatesFolder . $templateName . '/' ;
                    $s = $defaultList ;
                    if( $GLOBALS['cfg_webtemplate'] == $templatePath ){
                        $templateName = Replace($templateName, $templateName, '<font color=red>' . $templateName . '</font>') ;
                        $s = Replace($s, '启用</a>', '</a>') ;
                    }
                    $s = replaceValueParam($s, 'templatepath', $templatePath) ;
                    $s = replaceValueParam($s, 'templatename', $templateName) ;
                    $c = $c . $s . "\n" ;
                }
            }
        }
    }
    $content = Replace($content, '[list]' . $defaultList . '[/list]', $c) ;
    $displayTemplatesList = $content ;
    return @$displayTemplatesList;
}
//应用模板
function isOpenTemplate(){
    $templatePath=''; $templateName=''; $editValueStr=''; $url ='';
    $templatePath = @$_REQUEST['templatePath'] ;
    $templateName = @$_REQUEST['templateName'] ;
    //call echo(templatePath,templateName)
    $editValueStr = 'webtemplate=\'' . $templatePath . '\',webimages=\'' . $templatePath . 'Images/\'' ;
    $editValueStr = $editValueStr . ',webcss=\'' . $templatePath . 'css/\',webjs=\'' . $templatePath . 'Js/\'' ;
    connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website set ' . $editValueStr) ;
    $url = '?act=displayLayout&templateFile=manageTemplates.html&lableTitle=模板管理' ;
    rw(getMsg1('启用模板成功，正在进入模板管理界面...', $url)) ;
}
?>





