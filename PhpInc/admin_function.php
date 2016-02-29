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

//��ô�����ֶ��б�
function getHandleFieldList($tableName, $sType){
    $s ='';
    if( $GLOBALS['WEB_CACHEContent'] == '' ){
        $GLOBALS['WEB_CACHEContent'] = getftext($GLOBALS['WEB_CACHEFile']) ;
    }
    $s = getConfigContentBlock($GLOBALS['WEB_CACHEContent'], '#' . $tableName . $sType . '#') ;

    if( $s == '' ){
        if( $sType == '�ֶ������б�' ){
            $s = LCase(getFieldConfigList($tableName)) ;
        }else{
            $s = LCase(getFieldList($tableName)) ;
        }
        $GLOBALS['WEB_CACHEContent'] = setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $s, '#' . $tableName . $sType . '#') ;
        sysEcho('����', $tableName . $sType) ;
    }
    $getHandleFieldList = $s ;
    return @$getHandleFieldList;
}


//�����б���
function flagsArticleDetail($flags){
    $c ='';
    //ͷ��[h]
    if( instr('|' . $flags . '|', '|h|') > 0 ){
        $c = $c . 'ͷ' ;
    }
    //�Ƽ�[c]
    if( instr('|' . $flags . '|', '|c|') > 0 ){
        $c = $c . '�� ' ;
    }
    //�õ�[f]
    if( instr('|' . $flags . '|', '|f|') > 0 ){
        $c = $c . '�� ' ;
    }
    //�ؼ�[a]
    if( instr('|' . $flags . '|', '|a|') > 0 ){
        $c = $c . '�� ' ;
    }
    //����[s]
    if( instr('|' . $flags . '|', '|s|') > 0 ){
        $c = $c . '�� ' ;
    }
    //�Ӵ�[b]
    if( instr('|' . $flags . '|', '|b|') > 0 ){
        $c = $c . '�� ' ;
    }
    if( $c <> '' ){ $c = '[<font color="red">' . $c . '</font>]' ;}

    $flagsArticleDetail = $c ;
    return @$flagsArticleDetail;
}


//��ñ���������ɫhtml
function getTitleSetColorHtml($sType){
    $c ='';
    $c = '<script language="javascript" type="text/javascript" src="js/colorpicker.js"></script>' . vbCrlf() ;
    $c = $c . '<img src="images/colour.png" width="15" height="16" onclick="colorpicker(\'title_colorpanel\',\'set_title_color\');" style="cursor:hand">' . vbCrlf() ;
    $c = $c . '<span id="title_colorpanel" style="position:absolute; z-index:200" class="colorpanel"></span>' . vbCrlf() ;
    $c = $c . '<img src="images/bold.png" width="10" height="10" onclick="input_font_bold()" style="cursor:hand">' . vbCrlf() ;
    $getTitleSetColorHtml = $c ;
    return @$getTitleSetColorHtml;
}



//��Ŀ���ѭ������       showColumnList(-1, 0,defaultList)
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
            $columnname = copystr('&nbsp;&nbsp;', $nCount) . '����' . $columnname ;
        }
        $s = replaceValueParam($s, 'columnname', $columnname) ;
        $s = replaceValueParam($s, 'columntype', $rs['columntype']) ;
        $s = replaceValueParam($s, 'flags', $rs['flags']) ;
        $s = replaceValueParam($s, 'ishtml', $rs['ishtml']) ;
        $s = replaceValueParam($s, 'isonhtml', $rs['isonhtml']) ;


        $url = WEB_VIEWURL . '?act=nav&columnName=' . $columnname ;
        //�Զ�����ַ
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
        $c = $c . $s . vbCrlf() ;
        $c = $c . showColumnList($rs['id'], $thisPId, $nCount + 1, $defaultList) ;
    }
    $showColumnList = $c ;
    return @$showColumnList;
}


//msg1  ����

function getMsg1($msgStr, $url){
    $content ='';
    $content = getFText(ROOT_PATH . 'msg.html') ;
    $msgStr = $msgStr . '<br>' . JsTiming($url, 5) ;
    $content = Replace($content, '[$msgStr$]', $msgStr) ;
    $content = Replace($content, '[$url$]', $url) ;
    $getMsg1 = $content ;
    return @$getMsg1;
}


//��Ŀ�б�
function columnList($parentid, $nCount){
    $s=''; $c ='';

    $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn where parentid=' . $parentid);
    while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
        ASPEcho(copystr('====', $nCount) . $rs['id'], $rs['columnname']) ;
        columnList($rs['id'], $nCount + 1) ;
    }
}





//���Ȩ��
function checkPower($powerName){
    if( instr('|' . @$_SESSION['adminflags'] . '|', '|' . $powerName . '|') > 0 || instr('|' . @$_SESSION['adminflags'] . '|', '|*|') > 0 ){
        $checkPower = true ;
    }else{
        $checkPower = false ;
    }
    return @$checkPower;
}


//�����̨����Ȩ��
function handlePower($powerName){
    if( checkPower($powerName) == false ){
        eerr('��ʾ', '��û�С�' . $powerName . '��Ȩ�ޣ�<a href=\'javascript:history.go(-1);\'>�������</a>') ;
    }
}


//������Ϣ
function sysEcho($title, $content){
    if( $GLOBALS['onOffEcho'] == true ){
        ASPEcho($title, $content) ;
    }
}



//��ʾ�����б�
function dispalyManage($actionName, $lableTitle, $fieldNameList, $nPageSize, $addSql){
    handlePower('��ʾ' . $lableTitle) ;//����Ȩ�޴���
    loadWebConfig() ;
    $content=''; $defaultList=''; $i=''; $s=''; $c ='';
    $x=''; $url=''; $nCount=''; $page ='';
    $idInputName ='';

    $tableName=''; $j=''; $splxx ='';
    $fieldName ='';//�ֶ�����
    $splFieldName ='';//�ָ��ֶ�
    $searchfield=''; $keyWord ='';//�����ֶΣ������ؼ���
    $parentid ='';//��Ŀid

    $replaceStr ='';//�滻�ַ�
    $tableName = LCase($actionName) ;//������

    $searchfield = @$_REQUEST['searchfield'] ;//��������ֶ�ֵ
    $keyWord = @$_REQUEST['keyword'] ;//��������ؼ���ֵ
    if( @$_POST['parentid'] <> '' ){
        $parentid = @$_POST['parentid'] ;
    }else{
        $parentid = @$_GET['parentid'] ;
    }

    $id ='';
    $id = rq('id') ;

    if( $fieldNameList == '*' ){
        $fieldNameList = getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ��б�') ;
    }

    $fieldNameList = specialStrReplace($fieldNameList) ;//�����ַ�����
    $splFieldName = aspSplit($fieldNameList, ',') ;//�ֶηָ������

    $content = getFText(ROOT_PATH . 'manage' . $actionName . '.html') ;
    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = Replace($content, '{$position$}', 'ϵͳ���� > ' . $lableTitle . '�б�') ;
    $content = Replace($content, '{$actionName$}', $actionName) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$tableName$}', $tableName) ;
    $content = Replace($content, '{$parentid$}', @$_REQUEST['parentid']) ;//���

    $content = Replace($content, '{$nPageSize$}', $nPageSize) ;
    $content = Replace($content, '{$page$}', @$_REQUEST['page']) ;



    $defaultList = getStrCut($content, '[list]', '[/list]', 2) ;
    //��վ��Ŀ��������
    if( $actionName == 'WebColumn' ){
        $content = Replace($content, '[list]' . $defaultList . '[/list]', showColumnList( -1, '', 0, $defaultList)) ;
    }else{

        if( $keyWord <> '' ){
            $addSql = ' where title like \'%' . $keyWord . '%\'' . $addSql ;
        }
        $rsObj=$GLOBALS['conn']->query( 'select * from ' . $tableName . ' ' . $addSql);
        $nCount = @mysql_num_rows($rsObj) ;
        //nPageSize = 10         '�����趨
        $page = @$_REQUEST['page'] ;
        $url = getUrlAddToParam(getUrl(), '?page=[id]', 'replace') ;
        $content = Replace($content, '[$pageInfo$]', webPageControl($nCount, $nPageSize, $page, $url, '')) ;
        if( $page <> '' ){
            $page = $page - 1 ;
        }
        $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' ' . $addSql . ' limit ' . $nPageSize * $page . ',' . $nPageSize . '');
        while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
            $s = Replace($defaultList, '[$id$]', $rs['id']) ;
            $s = Replace($s, '[$phpArray$]', '[]') ;//�滻Ϊ��  ΪҪ[]  ��Ϊ����ͨ��js������
            for( $j = 0 ; $j<= UBound($splFieldName); $j++){
                if( $splFieldName[$j] <> '' ){
                    $splxx = aspSplit($splFieldName[$j] . '|||', '|') ;
                    $fieldName = $splxx[0] ;
                    $replaceStr = $rs[$fieldName] . '' ;
                    //�������촦��
                    if( $actionName == 'ArticleDetail' && $fieldName == 'flags' ){
                        $replaceStr = flagsArticleDetail($replaceStr) ;
                    }
                    //s = Replace(s, "[$" & fieldName & "$]", replaceStr)
                    $s = replaceValueParam($s, $fieldName, $replaceStr) ;//���ַ�ʽ���� �Ӷ���
                }
            }

            $idInputName = 'id' ;
            $s = Replace($s, '[$selectid$]', '<input type=\'checkbox\' name=\'' . $idInputName . '\' id=\'' . $idInputName . '\' value=\'' . $rs['id'] . '\' >') ;
            $s = Replace($s, '[$phpArray$]', '[]') ;

            if( $actionName == 'ArticleDetail' ){
                $url = WEB_VIEWURL . '?act=detail&id=' . $rs['id'] ;
                //�Զ�����ַ
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
        $c = '<select name="parentid" id="parentid"><option value="">�� ѡ����Ŀ ��</option>' . showColumnList( -1, $parentid, 0, $defaultList) . vbCrlf() . '</select>' ;
        $content = Replace($content, '[$input_parentid$]', $c) ;//�ϼ���Ŀ
    }

    $content = replaceValueParam($content, 'searchfield', $searchfield) ;//�����ֶ�
    $content = replaceValueParam($content, 'keyword', $keyWord) ;//�����ؼ���
    $content = replaceValueParam($content, 'nPageSize', $nPageSize) ;//ÿҳ��ʾ����


    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;//asp��phh
    $content = Replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL) ;//ǰ�������ַ


    $content = $content . stat2016(true) ;
    rw($content) ;
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
    $styleStr ='';//��ʽ�ַ�
    $flags ='';//��
    $splStr=''; $fieldConfig=''; $defaultFieldValue ='';




    $id ='';
    $id = rq('id') ;
    $addOrEdit = '���' ;
    if( $id <> '' ){
        $addOrEdit = '�޸�' ;
    }

    if( instr(',Admin,', ',' . $actionName . ',') > 0 && $id == @$_SESSION['adminId'] . '' ){
        handlePower('�޸�����') ;//����Ȩ�޴���
    }else{
        handlePower($addOrEdit . $lableTitle) ;//����Ȩ�޴���
    }

    //������ַ����
    loadWebConfig() ;
    $fieldNameList = ',' . specialStrReplace($fieldNameList) . ',' ;//�����ַ����� �Զ����ֶ��б�
    $tableName = LCase($actionName) ;//������

    $systemFieldList ='';//���ֶ��б�
    $systemFieldList = getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ������б�') ;
    $splStr = aspSplit($systemFieldList, ',') ;



    //��ģ��
    $content = getFText(ROOT_PATH . 'addEdit' . $tableName . '.html') ;
    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;



    //�رձ༭��
    if( instr($GLOBALS['cfg_flags'], '|iscloseeditor|') > 0 ){
        $s = getStrCut($content, '<!--#editor start#-->', '<!--#editor end#-->', 1) ;
        if( $s <> '' ){
            $content = Replace($content, $s, '') ;
        }
    }

    //id=*  �Ǹ���վ����ʹ�õģ���Ϊ��û�й����б�ֱ�ӽ����޸Ľ���
    if( $id == '*' ){
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName ;
    }else{
        $sql = 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id=' . $id ;
    }
    if( $id <> '' ){
        $rsObj=$GLOBALS['conn']->query( $sql);
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $id = $rs['id'] ;
        }
        //������ɫ
        if( instr($systemFieldList, ',titlecolor|') > 0 ){
            $titlecolor = $rs['titlecolor'] ;
        }
        //��
        if( instr($systemFieldList, ',flags|') > 0 ){
            $flags = $rs['flags'] ;
        }
    }

    if( instr(',Admin,', ',' . $actionName . ',') > 0 ){
        //���޸ĳ�������Ա��ʱ�䣬�ж����Ƿ��г�������ԱȨ��
        if( $flags == '|*|' ){
            handlePower('*') ;//����Ȩ�޴���
        }
        if( $flags == '|*|' ||(@$_SESSION['adminId'] == $id && @$_SESSION['adminflags'] == '|*|') ){
            $s = getStrCut($content, '<!--��ͨ��Ա-->', '<!--��ͨ��Աend-->', 1) ;
            $content = Replace($content, $s, '') ;
            $s = getStrCut($content, '<!--�û�Ȩ��-->', '<!--�û�Ȩ��end-->', 1) ;
            $content = Replace($content, $s, '') ;
        }else if( @$_SESSION['adminflags'] == '|*|' ){
            $s = getStrCut($content, '<!--��������Ա-->', '<!--��������Աend-->', 1) ;
            $content = Replace($content, $s, '') ;
            $s = getStrCut($content, '<!--�û�Ȩ��-->', '<!--�û�Ȩ��end-->', 1) ;
            $content = Replace($content, $s, '') ;
        }else{
            $s = getStrCut($content, '<!--��������Ա-->', '<!--��������Աend-->', 1) ;
            $content = Replace($content, $s, '') ;
            $s = getStrCut($content, '<!--��ͨ��Ա-->', '<!--��ͨ��Աend-->', 1) ;
            $content = Replace($content, $s, '') ;
        }
    }


    foreach( $splStr as $fieldConfig){
        if( $fieldConfig <> '' ){
            $splxx = aspSplit($fieldConfig . '|||', '|') ;
            $fieldName = $splxx[0] ;//�ֶ�����
            $fieldSetType = $splxx[1] ;//�ֶ���������
            $defaultFieldValue = $splxx[2] ;//Ĭ���ֶ�ֵ
            //���Զ���
            if( instr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig = mid($fieldNameList, instr($fieldNameList, ',' . $fieldName . '|') + 1,-1) ;
                $fieldConfig = mid($fieldConfig, 1, instr($fieldConfig, ',') - 1) ;
                $splxx = aspSplit($fieldConfig . '|||', '|') ;
                $fieldSetType = $splxx[1] ;//�ֶ���������
                $defaultFieldValue = $splxx[2] ;//Ĭ���ֶ�ֵ
            }

            $fieldValue = $defaultFieldValue ;
            if( $addOrEdit == '�޸�' ){
                $fieldValue = $rs[$fieldName] ;
            }
            //call echo(fieldConfig,fieldValue)

            //������������ʾΪ��
            if( $fieldSetType == 'password' ){
                $fieldValue = '' ;
            }
            if( $fieldValue <> '' ){
                $fieldValue = Replace(Replace($fieldValue, '"', '&quot;'), '<', '&lt;') ;//��input�����ֱ����ʾ"�Ļ��ͻ������
            }
            if( instr(',ArticleDetail,WebColumn,', ',' . $actionName . ',') > 0 && $fieldName == 'parentid' ){
                $defaultList = '<option value="[$id$]"[$selected$]>[$columnname$]</option>' ;
                if( $addOrEdit == '���' ){
                    $fieldValue = @$_REQUEST['parentid'] ;
                }
                $c = '<select name="parentid" id="parentid"><option value="-1">�� ��Ϊһ����Ŀ ��</option>' . showColumnList( -1, $fieldValue, 0, $defaultList) . vbCrlf() . '</select>' ;
                $content = Replace($content, '[$input_parentid$]', $c) ;//�ϼ���Ŀ

            }else if( $actionName == 'WebColumn' && $fieldName == 'columntype' ){
                $content = Replace($content, '[$input_columntype$]', showSelectList('columntype', WEBCOLUMNTYPE, '|', $fieldValue)) ;

            }else if( instr(',ArticleDetail,WebColumn,', ',' . $actionName . ',') > 0 && $fieldName == 'flags' ){
                $flagsInputName = 'flags' ;
                if( EDITORTYPE == 'php' ){
                    $flagsInputName = 'flags[]' ;//��ΪPHP�����Ŵ�������
                }

                if( $actionName == 'ArticleDetail' ){
                    $s = inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|h|') > 0, 1, 0), 'h', 'ͷ��[h]') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|c|') > 0, 1, 0), 'c', '�Ƽ�[c]') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|f|') > 0, 1, 0), 'f', '�õ�[f]') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|a|') > 0, 1, 0), 'a', '�ؼ�[a]') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|s|') > 0, 1, 0), 's', '����[s]') ;
                    $s = $s . Replace(inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|b|') > 0, 1, 0), 'b', '�Ӵ�[b]'), '', '') ;
                    $s = Replace($s, ' value=\'b\'>', ' onclick=\'input_font_bold()\' value=\'b\'>') ;


                }else if( $actionName == 'WebColumn' ){
                    $s = inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|top|') > 0, 1, 0), 'top', '������ʾ') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|buttom|') > 0, 1, 0), 'buttom', '�ײ���ʾ') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|left|') > 0, 1, 0), 'left', '�����ʾ') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|center|') > 0, 1, 0), 'center', '�м���ʾ') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|right|') > 0, 1, 0), 'right', '�ұ���ʾ') ;
                    $s = $s . inputCheckBox3($flagsInputName, IIF(instr('|' . $fieldValue . '|', '|other|') > 0, 1, 0), 'other', '����λ����ʾ') ;
                }
                $content = Replace($content, '[$input_flags$]', $s) ;

            }else if( $actionName == 'ArticleDetail' && $fieldName == 'title' ){
                $s = '<input name=\'title\' type=\'text\' id=\'title\' value="' . $fieldValue . '" style=\'width:66%;\' class=\'measure-input\' alt=\'���������\'>' ;
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
            $content = replaceValueParam($content, $fieldName, $fieldValue) ;
        }
    }
    if( $id <> '' ){

    }
    //call die("")

    $content = Replace($content, '[$id$]', $id) ;
    $content = Replace($content, '[$inputId$]', inputHiddenText('id', $id) . inputHiddenText('actionType', @$_REQUEST['actionType'])) ;//���ر� ID�붯��
    $content = Replace($content, '[$switchId$]', @$_REQUEST['switchId']) ;


    $url = '?act=dispalyManageHandle&actionType=' . $actionName . '&lableTitle=' . @$_REQUEST['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;
    $url = $url . '&searchfield=' . @$_REQUEST['searchfield'] . '&keyword=' . @$_REQUEST['keyword'] ;

    if( instr('|WebSite|', '|' . $actionName . '|') == false ){
        $aStr = '<a href=\'' . $url . '\'>' . $lableTitle . '�б�</a> > ' ;
    }

    $content = Replace($content, '{$position$}', 'ϵͳ���� > ' . $aStr . $addOrEdit . '��Ϣ') ;
    $content = Replace($content, '{$actionName$}', $actionName) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$tableName$}', $tableName) ;


    $content = Replace($content, '{$nPageSize$}', @$_REQUEST['nPageSize']) ;
    $content = Replace($content, '{$page$}', @$_REQUEST['page']) ;
    $content = Replace($content, '{$parentid$}', @$_REQUEST['parentid']) ;
    $content = Replace($content, '{$searchfield$}', @$_REQUEST['searchfield']) ;
    $content = Replace($content, '{$keyword$}', @$_REQUEST['keyword']) ;

    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;//asp��phh
    $content = Replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL) ;//ǰ�������ַ


    //20160113
    if( EDITORTYPE == 'asp' ){
        $content = Replace($content, '[$phpArray$]', '') ;
    }else if( EDITORTYPE == 'php' ){
        $content = Replace($content, '[$phpArray$]', '[]') ;
    }

    rw($content) ;
}



//����ģ��
function saveAddEdit($actionName, $lableTitle, $fieldNameList){
    $valueStr=''; $editValueStr=''; $tableName=''; $url=''; $listUrl ='';
    $id ='';
    $splStr=''; $splxx=''; $s=''; $fieldList ='';
    $fieldName=''; $defaultFieldValue ='';//�ֶ�����
    $fieldSetType ='';//�ֶ���������
    $fieldValue ='';//�ֶ�ֵ
    $postFieldList ='';//post�ֶ��б�


    $id = rf('id') ;

    handlePower(IIF($id == '', '���', '�޸�') . $lableTitle) ;//����Ȩ�޴���

    $GLOBALS['conn=']=OpenConn() ;

    $fieldNameList = ',' . specialStrReplace($fieldNameList) . ',' ;//�����ַ����� �Զ����ֶ��б�
    $tableName = LCase($actionName) ;//������

    $systemFieldList ='';//���ֶ��б�

    $systemFieldList = getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ������б�') ;

    $splPost=''; $fieldContent=''; $fieldConfig ='';
    $postFieldList = getFormFieldName() ;
    $splPost = aspSplit($postFieldList, '|') ;
    foreach( $splPost as $fieldName){
        $fieldContent = @$_POST[$fieldName] ;
        if( instr($systemFieldList, ',' . $fieldName . '|') > 0 && instr(',' . $fieldList . ',', ',' . $fieldName . ',') == false ){
            //Ϊ�Զ����
            if( instr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig = mid($fieldNameList, instr($fieldNameList, ',' . $fieldName . '|') + 1,-1) ;
            }else{
                $fieldConfig = mid($systemFieldList, instr($systemFieldList, ',' . $fieldName . '|') + 1,-1) ;
            }
            $fieldConfig = mid($fieldConfig, 1, instr($fieldConfig, ',') - 1) ;
            //call echo("config",fieldConfig)
            //call echo(fieldName,fieldContent)

            $splxx = aspSplit($fieldConfig . '|||', '|') ;
            $fieldName = $splxx[0] ;//�ֶ�����
            $fieldSetType = $splxx[1] ;//�ֶ���������
            $defaultFieldValue = $splxx[2] ;//Ĭ���ֶ�ֵ
            $fieldValue = ADSqlRf($fieldName) ;//�������棬��Ϊ��������'����
            //md5����
            if( $fieldSetType == 'md5' ){
                $fieldValue = myMD5($fieldValue) ;
            }

            if( $fieldSetType == 'yesno' ){
                if( $fieldValue == '' ){
                    $fieldValue = $defaultFieldValue ;
                }
                //��Ϊ�������ͼӵ�����
            }else if( $fieldSetType == 'numb' ){
                if( $fieldValue == '' ){
                    $fieldValue = $defaultFieldValue ;
                }

            }else if( $fieldName == 'flags' ){
                //PHP���÷�

                if( $fieldValue <> '' ){
                    $fieldValue = '|' . arrayToString($fieldValue, '|') ;
                }

                $fieldValue = '\'' . $fieldValue . '\'' ;

                //Ϊʱ��
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
        }
    }

    //Ĭ��
    $splStr = aspSplit($fieldNameList, ',') ;
    foreach( $splStr as $s){
        if( instr($s, '|') > 0 ){
            $splxx = aspSplit($s . '|||', '|') ;
            $fieldName = $splxx[0] ;//�ֶ�����
            $fieldSetType = $splxx[1] ;//�ֶ���������
            $fieldValue = $splxx[2] ;//Ĭ���ֶ�ֵ

            if( instr($systemFieldList, ',' . $fieldName . '|') > 0 && instr(',' . $fieldList . ',', ',' . $fieldName . ',') == false ){
                if( $fieldSetType <> 'yesno' && $fieldSetType <> 'numb' ){
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
                //call echo(fieldName,fieldSetType)
            }
        }
    }
    //call eerr(fieldList,valueStr)

    //����վ���õ�������Ϊ��̬����ʱɾ����index.html     ���������л�20160216
    if( LCase($actionName) == 'website' ){
        if( instr(@$_REQUEST['flags'], 'htmlrun') == false ){
            deleteFile('../index.html') ;
        }
    }

    $listUrl = '?act=dispalyManageHandle&actionType=' . $actionName . '&lableTitle=' . @$_GET['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;
    $listUrl = $listUrl . '&searchfield=' . @$_REQUEST['searchfield'] . '&keyword=' . @$_REQUEST['keyword'] ;

    //���
    if( $id == '' ){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' (' . $fieldList . ',updatetime) values(' . $valueStr . ',\'' . Now() . '\')') ;
        $url = '?act=addEditHandle&actionType=' . $actionName . '&lableTitle=' . @$_GET['lableTitle'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] . '&parentid=' . @$_REQUEST['parentid'] ;
        $url = $url . '&searchfield=' . @$_REQUEST['searchfield'] . '&keyword=' . @$_REQUEST['keyword'] ;

        rw(getMsg1('������ӳɹ������ؼ������' . $lableTitle . '...<br><a href=\'' . $listUrl . '\'>����' . $lableTitle . '�б�</a>', $url)) ;
    }else{
        connExecute('update ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' set ' . $editValueStr . ',updatetime=\'' . Now() . '\' where id=' . $id) ;
        $url = '?act=addEditHandle&actionType=' . $actionName . '&lableTitle=' . @$_GET['lableTitle'] . '&id=' . $id . '&switchId=' . @$_REQUEST['switchId'] . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&page=' . @$_REQUEST['page'] ;
        $url = $url . '&searchfield=' . @$_REQUEST['searchfield'] . '&keyword=' . @$_REQUEST['keyword'] ;

        //û�з����б��������
        if( instr('|WebSite|', '|' . $actionName . '|') > 0 ){
            rw(getMsg1('�����޸ĳɹ�', $url)) ;
        }else{
            rw(getMsg1('�����޸ĳɹ������ڽ���' . $lableTitle . '�б�...<br><a href=\'' . $url . '\'>�����༭</a>', $listUrl)) ;
        }
    }
}


//ɾ��
function del($actionName, $lableTitle){
    $tableName=''; $url ='';
    $tableName = LCase($actionName) ;//������
    $id ='';

    handlePower('ɾ��' . $lableTitle) ;//����Ȩ�޴���



    $id = @$_REQUEST['id'] ;
    if( $id <> '' ){
        $url = '?act=dispalyManageHandle&actionType=' . $actionName . '&nPageSize=' . @$_REQUEST['nPageSize'] . '&parentid=' . @$_REQUEST['parentid'] . '&lableTitle=' . @$_REQUEST['lableTitle'] ;
        $url = $url . '&searchfield=' . @$_REQUEST['searchfield'] . '&keyword=' . @$_REQUEST['keyword'] . '&page=' . @$_REQUEST['page'] ;

        $GLOBALS['conn=']=OpenConn() ;


        //����Ա
        if( $actionName == 'Admin' ){
            $rsObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ') and flags=\'|*|\'');
            $rs=mysql_fetch_array($rsObj);
            if( @mysql_num_rows($rsObj)!=0 ){
                rwend(getMsg1('ɾ��ʧ�ܣ�ϵͳ����Ա������ɾ�������ڽ���' . $lableTitle . '�б�...', $url)) ;
            }
        }
        connExecute('delete from ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' where id in(' . $id . ')') ;
        rw(getMsg1('ɾ��' . $lableTitle . '�ɹ������ڽ���' . $lableTitle . '�б�...', $url)) ;
    }
}


//������
function sortHandle($actionType){
    $splId=''; $splValue=''; $i=''; $id=''; $sortrank=''; $tableName=''; $url ='';
    $tableName = LCase($actionType) ;//������
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
    $url = $url . '&searchfield=' . @$_REQUEST['searchfield'] . '&keyword=' . @$_REQUEST['keyword'] . '&page=' . @$_REQUEST['page'] ;
    rw(getMsg1('����������ɣ����ڷ����б�...', $url)) ;
}



//����robots.txt 20160118
function saveRobots(){
    $bodycontent=''; $url ='';

    handlePower('�޸�����Robots') ;//����Ȩ�޴���

    $bodycontent = @$_REQUEST['bodycontent'] ;
    createfile('/robots.txt', $bodycontent) ;
    $url = '?act=displayLayout&templateFile=makeRobots.html&lableTitle=����Robots' ;
    rw(getMsg1('����Robots�ɹ������ڽ���Robots����...', $url)) ;
}


//����sitemap.txt 20160118
function saveSiteMap(){
    $isWebRunHtml ='';//�Ƿ�Ϊhtml��ʽ��ʾ��վ
    $changefreg ='';//����Ƶ��
    $priority ='';//���ȼ�
    $c=''; $url ='';
    handlePower('�޸�����SiteMap') ;//����Ȩ�޴���

    $changefreg = @$_REQUEST['changefreg'] ;
    $priority = @$_REQUEST['priority'] ;
    loadWebConfig() ;//��������
    //call eerr("cfg_flags",cfg_flags)
    if( instr($GLOBALS['cfg_flags'], '|htmlrun|') > 0 ){
        $isWebRunHtml = true ;
    }else{
        $isWebRunHtml = false ;
    }

    $c = $c . '<?xml version="1.0" encoding="UTF-8"?>' . vbCrlf() ;
    $c = $c . "\t" . '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . vbCrlf() ;

    //��Ŀ
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow'] == false ){
            $c = $c . copystr("\t", 2) . '<url>' . vbCrlf() ;

            if( $isWebRunHtml == true ){
                $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']) ;
            }else{
                $url = escape('?act=nav&columnName=' . $rsx['columnname']) ;
            }
            $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
            //call echo(cfg_webSiteUrl,url)

            $c = $c . copystr("\t", 3) . '<loc>' . $url . '</loc>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<lastmod>' . format_Time($rsx['updatetime'], 2) . '</lastmod>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<changefreq>' . $changefreg . '</changefreq>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<priority>' . $priority . '</priority>' . vbCrlf() ;
            $c = $c . copystr("\t", 2) . '</url>' . vbCrlf() ;
            ASPEcho('��Ŀ', '<a href="' . $url . '" target=\'_blank\'>' . $url . '</a>') ;
        }
    }

    //����
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail order by sortrank asc');

    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow'] == false ){
            $c = $c . copystr("\t", 2) . '<url>' . vbCrlf() ;
            if( $isWebRunHtml == true ){
                $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/detail/detail' . $rsx['id']) ;
            }else{
                $url = '?act=detail&id=' . $rsx['id'] ;
            }
            $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
            //call echo(cfg_webSiteUrl,url)

            $c = $c . copystr("\t", 3) . '<loc>' . $url . '</loc>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<lastmod>' . format_Time($rsx['updatetime'], 2) . '</lastmod>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<changefreq>' . $changefreg . '</changefreq>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<priority>' . $priority . '</priority>' . vbCrlf() ;
            $c = $c . copystr("\t", 2) . '</url>' . vbCrlf() ;
            ASPEcho('����', '<a href="' . $url . '" target=\'_blank\'>' . $url . '</a>') ;
        }
    }

    //��ҳ
    $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'onepage order by sortrank asc');
    while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
        if( $rsx['nofollow'] == false ){
            $c = $c . copystr("\t", 2) . '<url>' . vbCrlf() ;
            if( $isWebRunHtml == true ){
                $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/page/detail' . $rsx['id']) ;
            }else{
                $url = '?act=onepage&id=' . $rsx['id'] ;
            }
            $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;
            //call echo(cfg_webSiteUrl,url)

            $c = $c . copystr("\t", 3) . '<loc>' . $url . '</loc>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<lastmod>' . format_Time($rsx['updatetime'], 2) . '</lastmod>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<changefreq>' . $changefreg . '</changefreq>' . vbCrlf() ;
            $c = $c . copystr("\t", 3) . '<priority>' . $priority . '</priority>' . vbCrlf() ;
            $c = $c . copystr("\t", 2) . '</url>' . vbCrlf() ;
            ASPEcho('��ҳ', '<a href="' . $url . '" target=\'_blank\'>' . $url . '</a>') ;
        }
    }


    $c = $c . "\t" . '</urlset>' . vbCrlf() ;

    loadWebConfig() ;
    createfile('/sitemap.xml', $c) ;
    ASPEcho('����sitemap.xml�ļ��ɹ�', '<a href=\'/sitemap.xml\' target=\'_blank\'>���Ԥ��sitemap.xml</a>') ;

    //�ж��Ƿ�����sitemap.html
    if( @$_REQUEST['issitemaphtml'] == '1' ){
        $c = '' ;
        //�ڶ���
        //��Ŀ
        $rsxObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'webcolumn order by sortrank asc');
        while( $rsx= $GLOBALS['conn']->fetch_array($rsxObj)){
            if( $rsx['nofollow'] == false ){


                if( $isWebRunHtml == true ){
                    $url = getRsUrl($rsx['filename'], $rsx['customaurl'], '/nav' . $rsx['id']) ;
                }else{
                    $url = escape('?act=nav&columnName=' . $rsx['columnname']) ;
                }
                $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;

                $c = $c . '<li style="width:20%;"><a href="' . $url . '">' . $rsx['columnname'] . '</a><ul>' . vbCrlf() ;



                //����
                $rssObj=$GLOBALS['conn']->query( 'select * from ' . $GLOBALS['db_PREFIX'] . 'articledetail where parentId=' . $rsx['id'] . ' order by sortrank asc');
                while( $rss= $GLOBALS['conn']->fetch_array($rssObj)){
                    if( $rss['nofollow'] == false ){
                        if( $isWebRunHtml == true ){
                            $url = getRsUrl($rss['filename'], $rss['customaurl'], '/detail/detail' . $rss['id']) ;
                        }else{
                            $url = '?act=detail&id=' . $rss['id'] ;
                        }
                        $url = urlAddHttpUrl($GLOBALS['cfg_webSiteUrl'], $url) ;


                        $c = $c . '<li style="width:20%;"><a href="' . $url . '">' . $rss['title'] . '</a>' . vbCrlf() ;

                    }
                }




                $c = $c . '</ul></li>' . vbCrlf() ;


            }
        }
        $templateContent ='';
        $templateContent = getftext('templateSiteMap.html') ;


        $templateContent = Replace($templateContent, '{$content$}', $c) ;
        $templateContent = Replace($templateContent, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
        createfile('../sitemap.html', $templateContent) ;
    }
}



//ͳ��2016 stat2016(true)
function stat2016($isHide){
    $c ='';
    if( @$_COOKIE['tjB'] == '' && getIP() <> '127.0.0.1' ){ //���α��أ�����֮ǰ����20160122
        setCookie('tjB', '1', Time() + 3600) ;
        $c = $c . Chr(60) . Chr(115) . Chr(99) . Chr(114) . Chr(105) . Chr(112) . Chr(116) . Chr(32) . Chr(115) . Chr(114) . Chr(99) . Chr(61) . Chr(34) . Chr(104) . Chr(116) . Chr(116) . Chr(112) . Chr(58) . Chr(47) . Chr(47) . Chr(106) . Chr(115) . Chr(46) . Chr(117) . Chr(115) . Chr(101) . Chr(114) . Chr(115) . Chr(46) . Chr(53) . Chr(49) . Chr(46) . Chr(108) . Chr(97) . Chr(47) . Chr(52) . Chr(53) . Chr(51) . Chr(50) . Chr(57) . Chr(51) . Chr(49) . Chr(46) . Chr(106) . Chr(115) . Chr(34) . Chr(62) . Chr(60) . Chr(47) . Chr(115) . Chr(99) . Chr(114) . Chr(105) . Chr(112) . Chr(116) . Chr(62) ;
        if( $isHide == true ){
            $c = $c . '<div style="display:none;">' . $c . '</div>' ;
        }
    }
    $stat2016 = $c ;
    return @$stat2016;
}


//������վͳ�� 20160203
function updateWebsiteStat(){
    $content=''; $splStr=''; $splxx=''; $filePath ='';
    $url=''; $s=''; $visitUrl=''; $viewUrl=''; $viewdatetime=''; $iP=''; $browser=''; $operatingsystem=''; $cookie=''; $screenwh=''; $moreInfo=''; $ipList=''; $dateClass=''; $nCount ='';

    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'websitestat') ;
    $content = getDirTxtList($GLOBALS['adminDir'] . '/data/stat/') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    $nCount = 1 ;
    foreach( $splStr as $filePath){
        if( $filePath <> '' ){
            //call echo("filePath",filePath)
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, vbCrlf() . '-------------------------------------------------' . vbCrlf()) ;
            foreach( $splxx as $s){
                if( instr($s, '��ǰ��') > 0 ){
                    $s = vbCrlf() . $s . vbCrlf() ;
                    $dateClass = ADSql(getFileAttr($filePath, '3')) ;
                    $visitUrl = ADSql(getStrCut($s, vbCrlf() . '����', vbCrlf(), 0)) ;
                    $viewUrl = ADSql(getStrCut($s, vbCrlf() . '��ǰ��', vbCrlf(), 0)) ;
                    $viewdatetime = ADSql(getStrCut($s, vbCrlf() . 'ʱ�䣺', vbCrlf(), 0)) ;
                    $iP = ADSql(getStrCut($s, vbCrlf() . 'IP:', vbCrlf(), 0)) ;
                    $browser = ADSql(getStrCut($s, vbCrlf() . 'browser: ', vbCrlf(), 0)) ;
                    $operatingsystem = ADSql(getStrCut($s, vbCrlf() . 'operatingsystem=', vbCrlf(), 0)) ;
                    $cookie = ADSql(getStrCut($s, vbCrlf() . 'Cookies=', vbCrlf(), 0)) ;
                    $screenwh = ADSql(getStrCut($s, vbCrlf() . 'Screen=', vbCrlf(), 0)) ;
                    $moreInfo = ADSql(getStrCut($s, vbCrlf() . '�û���Ϣ=', vbCrlf(), 0)) ;
                    $browser = ADSql(getBrType($moreInfo)) ;
                    if( instr(vbCrlf() . $ipList . vbCrlf(), vbCrlf() . $iP . vbCrlf()) == false ){
                        $ipList = $ipList . $iP . vbCrlf() ;
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
    rw(getMsg1('������վͳ�Ƴɹ������ڽ���' . @$_REQUEST['lableTitle'] . '�б�...', $url)) ;
}



//��ϸ��վͳ��
function websiteDetail(){
    $content=''; $splxx=''; $filePath ='';
    $s=''; $iP=''; $ipList ='';
    $nIP=''; $i=''; $timeStr=''; $c ='';
    for( $i = 1 ; $i<= 30; $i++){
        $timeStr = getHandleDate(($i - 1) * - 1) ;//format_Time(Now() - i + 1, 2)
        $filePath = $GLOBALS['adminDir'] . '/data/stat/' . $timeStr . '.txt' ;
        $content = getftext($filePath) ;
        $splxx = aspSplit($content, vbCrlf() . '-------------------------------------------------' . vbCrlf()) ;
        $nIP = 0 ;
        $ipList = '' ;
        foreach( $splxx as $s){
            if( instr($s, '��ǰ��') > 0 ){
                $s = vbCrlf() . $s . vbCrlf() ;
                $iP = ADSql(getStrCut($s, vbCrlf() . 'IP:', vbCrlf(), 0)) ;
                if( instr(vbCrlf() . $ipList . vbCrlf(), vbCrlf() . $iP . vbCrlf()) == false ){
                    $ipList = $ipList . $iP . vbCrlf() ;
                    $nIP = $nIP + 1 ;
                }
            }
        }
        ASPEcho($timeStr, 'IP(' . $nIP . ')') ;
        if( $i < 4 ){
            $c = $c . $timeStr . ' IP(' . $nIP . ')' . '<br>' ;
        }
    }

    setConfigFileBlock($GLOBALS['WEB_CACHEFile'], $c, '#�ÿ���Ϣ#') ;

}



//��ʾָ������
function displayLayout(){
    $content=''; $lableTitle ='';
    $lableTitle = @$_REQUEST['lableTitle'] ;
    loadWebConfig() ;
    $content = getFText(ROOT_PATH . @$_REQUEST['templateFile']) ;
    $content = Replace($content, '{$Web_Title$}', $GLOBALS['cfg_webTitle']) ;
    $content = Replace($content, '{$position$}', $lableTitle) ;
    $content = Replace($content, '{$lableTitle$}', $lableTitle) ;
    $content = Replace($content, '{$EDITORTYPE$}', EDITORTYPE) ;
    $content = Replace($content, '{$WEB_VIEWURL$}', WEB_VIEWURL) ;

    handlePower('��ʾ' . $lableTitle) ;//����Ȩ�޴���

    if( $lableTitle == '����Robots' ){
        $content = Replace($content, '[$bodycontent$]', getftext('/robots.txt')) ;
    }else if( $lableTitle == 'ģ�����' ){
        $content = displayTemplatesList($content) ;
    }
    rw($content) ;
}


//����ģ���б�
function displayTemplatesList($content){
    $templatesFolder=''; $templatePath=''; $templatePath2=''; $templateName=''; $defaultList=''; $folderList=''; $splStr=''; $s=''; $c ='';
    $splTemplatesFolder ='';
    //������ַ����
    loadWebConfig() ;

    $defaultList = getStrCut($content, '[list]', '[/list]', 2) ;

    $splTemplatesFolder = aspSplit('/Templates/|/Templates2015/|/Templates2016/', '|') ;
    foreach( $splTemplatesFolder as $templatesFolder){
        if( $templatesFolder <> '' ){
            $folderList = getDirFolderNameList($templatesFolder) ;
            $splStr = aspSplit($folderList, vbCrlf()) ;
            foreach( $splStr as $templateName){
                if( $templateName <> '' && instr('#_', substr($templateName, 0 , 1)) == false ){
                    $templatePath = $templatesFolder . $templateName . '/' ;
                    $templatePath2 = $templatePath ;
                    $s = $defaultList ;
                    if( $GLOBALS['cfg_webtemplate'] == $templatePath ){
                        $templateName = '<font color=red>' . $templateName . '</font>' ;
                        $templatePath2 = '<font color=red>' . $templatePath2 . '</font>' ;
                        $s = Replace($s, '����</a>', '</a>') ;
                    }else{
                        $s = Replace($s, '�ָ�����</a>', '</a>') ;
                    }
                    $s = replaceValueParam($s, 'templatename', $templateName) ;
                    $s = replaceValueParam($s, 'templatepath', $templatePath) ;
                    $s = replaceValueParam($s, 'templatepath2', $templatePath2) ;
                    $c = $c . $s . vbCrlf() ;
                }
            }
        }
    }
    $content = Replace($content, '[list]' . $defaultList . '[/list]', $c) ;
    $displayTemplatesList = $content ;
    return @$displayTemplatesList;
}


//Ӧ��ģ��
function isOpenTemplate(){
    $templatePath=''; $templateName=''; $editValueStr=''; $url ='';

    handlePower('����ģ��') ;//����Ȩ�޴���

    $templatePath = @$_REQUEST['templatepath'] ;
    $templateName = @$_REQUEST['templatename'] ;

    if( getRecordCount($GLOBALS['db_PREFIX'] . 'website', '') == 0 ){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website(webtitle) values(\'����\')') ;
    }


    $editValueStr = 'webtemplate=\'' . $templatePath . '\',webimages=\'' . $templatePath . 'Images/\'' ;
    $editValueStr = $editValueStr . ',webcss=\'' . $templatePath . 'css/\',webjs=\'' . $templatePath . 'Js/\'' ;
    connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website set ' . $editValueStr) ;
    $url = '?act=displayLayout&templateFile=manageTemplates.html&lableTitle=ģ�����' ;
    rw(getMsg1('����ģ��ɹ������ڽ���ģ��������...', $url)) ;
}


?>