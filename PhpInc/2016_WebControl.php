<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-02-24
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered By �ƶ� 
************************************************************/
?>
<?PHP
//��վ���� 20160223



//����ģ���滻����
function handleModuleReplaceArray( $content){
    $i=''; $startStr=''; $endStr=''; $s=''; $lableName ='';
    for( $i = 1 ; $i<= UBound($GLOBALS['ModuleReplaceArray']) - 1; $i++){
        if( $GLOBALS['ModuleReplaceArray'][$i][ 0] == '' ){
            break;
        }
        //call echo(ModuleReplaceArray(i,0),ModuleReplaceArray(0,i))
        $lableName = $GLOBALS['ModuleReplaceArray'][$i][ 0] ;
        $s = $GLOBALS['ModuleReplaceArray'][0][ $i] ;
        if( $lableName == '��ɾ����' ){
            $content = Replace($content, $s, '') ;
        }else{
            $startStr = '<replacestrname ' . $lableName . '>' ; $endStr = '</replacestrname ' . $lableName . '>' ;
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $content = replaceContentModule($content, $startStr, $endStr, $s, '') ;
            }
            $startStr = '<replacestrname ' . $lableName . '/>' ;
            if( instr($content, $startStr) > 0 ){
                $content = replaceContentRowModule($content, '<replacestrname ' . $lableName . '/>', $s, '') ;
            }
        }
    }
    $handleModuleReplaceArray = $content ;
    return @$handleModuleReplaceArray;
}

//ȥ��ģ���ﲻ��Ҫ��ʾ���� ɾ��ģ�����ҵ�ע�ʹ���
function delTemplateMyNote($code){
    $startStr=''; $endStr=''; $i=''; $s=''; $handleNumb=''; $splStr=''; $Block=''; $id ='';
    $content=''; $DragSortCssStr=''; $DragSortStart=''; $DragSortEnd=''; $DragSortValue=''; $c ='';
    $handleNumb = 99 ;//���ﶨ�����Ҫ

    //���ReadBlockList�������б�����  �����и�����ĵط����������ݿ��Դ��ⲿ�������ݣ�����Ժ���
    //Call Eerr("ReadBlockList",ReadBlockList)
    //д��20141118
    //splStr = Split(ReadBlockList, vbCrLf)                 '�������֣�������
    //�޸���20151230
    for( $i = 1 ; $i<= $handleNumb; $i++){
        $startStr = '<R#��������' ; $endStr = ' start#>' ;
        $Block = StrCut($code, $startStr, $endStr, 2) ;
        if( $Block <> '' ){
            $startStr = '<R#��������' . $Block . ' start#>' ; $endStr = '<R#��������' . $Block . ' end#>' ;
            if( instr($code, $startStr) > 0 && instr($code, $endStr) > 0 ){
                $s = StrCut($code, $startStr, $endStr, 1) ;
                $code = Replace($code, $s, '') ;//�Ƴ�
            }
        }else{
            break;
        }
    }


    if( @$_REQUEST['gl'] == 'yun' ){
        $content = GetFText('/Jquery/dragsort/Config.html') ;
        $content = GetFText('/Jquery/dragsort/ģ����ק.html') ;
        //Css��ʽ
        $startStr = '<style>' ;
        $endStr = '</style>' ;
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $DragSortCssStr = StrCut($content, $startStr, $endStr, 1) ;
        }
        //��ʼ����
        $startStr = '<!--#top start#-->' ;
        $endStr = '<!--#top end#-->' ;
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $DragSortStart = StrCut($content, $startStr, $endStr, 2) ;
        }
        //��������
        $startStr = '<!--#foot start#-->' ;
        $endStr = '<!--#foot end#-->' ;
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $DragSortEnd = StrCut($content, $startStr, $endStr, 2) ;
        }
        //��ʾ������
        $startStr = '<!--#value start#-->' ;
        $endStr = '<!--#value end#-->' ;
        if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
            $DragSortValue = StrCut($content, $startStr, $endStr, 2) ;
        }



        //���ƴ���
        $startStr = '<dIv datid=\'' ;
        $endStr = '</dIv>' ;
        $content = GetArray($code, $startStr, $endStr, false, false) ;
        $splStr = aspSplit($content, '$Array$') ;
        foreach( $splStr as $s){
            $startStr = '��DatId��\'' ;
            $id = mid($s, 1, instr($s, $startStr) - 1) ;
            $s = mid($s, instr($s, $startStr) + strlen($startStr),-1) ;
            //C=C & "<li><div title='"& Id &"'>" & vbcrlf & "<div " & S & "</div>"& vbcrlf &"<div class='clear'></div></div><div class='clear'></div></li>"
            $s = '<div' . $s . '</div>' ;
            //Call Die(S)
            $c = $c . Replace(Replace($DragSortValue, '{$value$}', $s), '{$id$', $id) ;
        }
        $c = Replace($c, '�����С�', "\n") ;
        $c = $DragSortStart . $c . $DragSortEnd ;
        $code = mid($code, 1, instr($code, '<body>') - 1) ;
        $code = Replace($code, '</head>', $DragSortCssStr . '</head></body>' . $c . '</body></html>') ;
    }

    //ɾ��VB������ɵ���������
    $startStr = '<dIv datid=\'' ; $endStr = '��DatId��\'' ;
    for( $i = 1 ; $i<= $handleNumb; $i++){
        if( instr($code, $startStr) > 0 && instr($code, $endStr) > 0 ){
            $id = StrCut($code, $startStr, $endStr, 2) ;
            $code = Replace2($code, $startStr . $id . $endStr, '<div ') ;
        }else{
            break;
        }
    }
    $code = Replace($code, '</dIv>', '</div>') ;//�滻���������div

    //����Χ���
    $startStr = '<!--#dialogteststart#-->' ; $endStr = '<!--#dialogtestend#-->' ;
    $code = Replace($code, '<!--#dialogtest start#-->', $startStr) ;
    $code = Replace($code, '<!--#dialogtest end#-->', $endStr) ;
    for( $i = 1 ; $i<= $handleNumb; $i++){
        if( instr($code, $startStr) > 0 && instr($code, $endStr) > 0 ){
            $s = StrCut($code, $startStr, $endStr, 1) ;
            $code = Replace2($code, $s, '') ;
        }else{
            break;
        }
    }
    //��ת���
    $startStr = '<!--#teststart#-->' ; $endStr = '<!--#testend#-->' ;
    $code = Replace($code, '<!--#del start#-->', $startStr) ;//������һ��
    $code = Replace($code, '<!--#del end#-->', $endStr) ;//������һ�� ����ʽ
    $code = Replace($code, '<!--#test start#-->', $startStr) ;
    $code = Replace($code, '<!--#test end#-->', $endStr) ;

    for( $i = 1 ; $i<= $handleNumb; $i++){
        if( instr($code, $startStr) > 0 && instr($code, $endStr) > 0 ){
            $s = StrCut($code, $startStr, $endStr, 1) ;
            $code = Replace2($code, $s, '') ;
        }else{
            break;
        }
    }
    //ɾ��ע�͵�span
    $code = Replace($code, '<sPAn class="testspan">', '') ;//����Span
    $code = Replace($code, '<sPAn class="testhidde">', '') ;//����Span
    $code = Replace($code, '</sPAn>', '') ;

    //delTemplateMyNote = Code:Exit Function

    $startStr = '<!--#' ; $endStr = '#-->' ;
    for( $i = 1 ; $i<= $handleNumb; $i++){
        if( instr($code, $startStr) > 0 && instr($code, $endStr) > 0 ){
            $s = StrCut($code, $startStr, $endStr, 1) ;
            $code = Replace2($code, $s, '') ;
        }else{
            break;
        }
    }


    $delTemplateMyNote = $code ;
    return @$delTemplateMyNote;
}


//�����ú������Ӳ���    ������
//Dim Did,Sid,Tid,Title,TopNumb,CutStrNumb,AddSql
//Call HandleFunParameter(Action,Did,Sid,Tid,Title,TopNumb,CutStrNumb,AddSql)
function handleFunParameter($action, $did, $sid, $tid, $title, $topNumb, $cutStrNumb, $addSql){
    $startStr=''; $endStr ='';
    $did = RParam($action, 'Did') ;
    $sid = RParam($action, 'Sid') ;
    $tid = RParam($action, 'Tid') ;

    $did = IIF($did == '[$PubProDid$]', $GLOBALS['PubProDid'], $did) ;
    $sid = IIF($sid == '[$PubProSid$]', $GLOBALS['PubProSid'], $sid) ;
    $tid = IIF($tid == '[$PubProTid$]', $GLOBALS['PubProTid'], $tid) ;

    $title = RParam($action, 'Title') ;
    $topNumb = RParam($action, 'TopNumb') ;
    $cutStrNumb = RParam($action, 'CutStrNumb') ;
    if( $cutStrNumb == '' ){ $cutStrNumb = 28 ;}//Ĭ�Ͻ�ȡ�ַ�Ϊ32
    $addSql = RParam($action, 'AddSql') ;
}
//�����滻����ֵ 20160114
function handleReplaceValueParam($content, $paramName, $replaceStr){
    if( instr($content, '[$' . $paramName) == false ){
        $paramName = LCase($paramName) ;
    }
    $handleReplaceValueParam = replaceValueParam($content, $paramName, $replaceStr) ;
    return @$handleReplaceValueParam;
}

//�滻����ֵ 2014  12 01
function replaceValueParam($content, $paramName, $replaceStr){
    $startStr=''; $endStr=''; $labelStr=''; $tempLabelStr=''; $nLen=''; $nTimeFormat=''; $delHtmlYes=''; $funStr=''; $trimYes=''; $s ='';
    $ifStr ='';//�ж��ַ�
    $elseIfStr ='';//�ڶ��ж��ַ�
    $valueStr ='';//��ʾ�ַ�
    $elseStr ='';//�����ַ�
    $instrStr ='';//�����ַ�
    //ReplaceStr = ReplaceStr & "�����������������ʱ̼ѽ��"
    //ReplaceStr = CStr(ReplaceStr)            'ת���ַ�����
    if( IsNul($replaceStr) == true ){ $replaceStr = '' ;}

    $startStr = '[$' . $paramName ; $endStr = '$]' ;

    if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
        //��ö�Ӧ�ֶμ�ǿ��20151231
        if( instr($content, $startStr . $endStr) > 0 ){
            $labelStr = $startStr . $endStr ;
        }else if( instr($content, $startStr . ' ') > 0 ){
            $labelStr = StrCut($content, $startStr . ' ', $endStr, 1) ;
        }else{
            $labelStr = StrCut($content, $startStr, $endStr, 1) ;
        }
        $tempLabelStr = $labelStr ;
        $labelStr = handleInModule($labelStr, 'start') ;
        //ɾ��Html
        $delHtmlYes = RParam($labelStr, 'delHtml') ;//�Ƿ�ɾ��Html
        if( $delHtmlYes == 'true' ){ $replaceStr = Replace(DelHtml($replaceStr), '<', '&lt;') ;}//HTML����
        //ɾ�����߿ո�
        $trimYes = RParam($labelStr, 'trim') ;//�Ƿ�ɾ�����߿ո�
        if( $trimYes == 'true' ){ $replaceStr = TrimVbCrlf($replaceStr) ;}

        //��ȡ�ַ�����
        $nLen = RParam($labelStr, 'len') ;//�ַ�����ֵ
        $nLen = HandleNumber($nLen) ;
        //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        if( $nLen <> '' ){ $replaceStr = CutStr($replaceStr, $nLen, '...') ;}//Left(ReplaceStr,nLen)

        //ʱ�䴦��
        $nTimeFormat = RParam($labelStr, 'format_Time') ;//ʱ�䴦��ֵ
        if( $nTimeFormat <> '' ){
            $replaceStr = Format_Time($replaceStr, $nTimeFormat) ;
        }

        //�����Ŀ����
        $s = RParam($labelStr, 'getcolumnname') ;
        if( $s <> '' ){
            if( $s == '@ME' ){
                $s = $replaceStr ;
            }
            $replaceStr = getcolumnname($s) ;
        }
        //�����ĿURL
        $s = RParam($labelStr, 'getcolumnurl') ;
        if( $s <> '' ){
            if( $s == '@ME' ){
                $s = $replaceStr ;
            }
            $replaceStr = getcolumnurl($s, 'id') ;
        }

        $ifStr = RParam($labelStr, 'if') ;
        $elseIfStr = RParam($labelStr, 'elseif') ;
        $valueStr = RParam($labelStr, 'value') ;
        $elseStr = RParam($labelStr, 'else') ;
        $instrStr = RParam($labelStr, 'instr') ;
        //call echo("ifStr",ifStr)
        //call echo("valueStr",valueStr)
        //call echo("elseStr",elseStr)
        //call echo("elseIfStr",elseIfStr)
        if( $ifStr <> '' || $instrStr <> '' ){
            if(($ifStr == CStr($replaceStr) && $ifStr <> '') ||($elseIfStr == CStr($replaceStr) && $elseIfStr <> '') ){
                $replaceStr = $valueStr ;
            }else if( instr(CStr($replaceStr), $instrStr) > 0 && $instrStr <> '' ){
                $replaceStr = $valueStr ;
            }else{
                if( $elseStr <> '@ME' ){
                    $replaceStr = $elseStr ;
                }
            }
        }

        //��������20151231    [$title  function='left(@ME,40)'$]
        $funStr = RParam($labelStr, 'function') ;//����
        if( $funStr <> '' ){
            $funStr = Replace($funStr, '@ME', $replaceStr) ;
            $replaceStr = handleContentCode($funStr, '') ;
        }

        //Ĭ��ֵ
        $s = RParam($labelStr, 'default') ;
        if( $s <> '' ){
            if( $replaceStr == '' ){
                $replaceStr = $s ;
            }
        }



        //�ı���ɫ
        $s = RParam($labelStr, 'fontcolor') ;//����
        if( $s <> '' ){
            $replaceStr = '<font color="' . $s . '">' . $replaceStr . '</font>' ;
        }

        $content = Replace($content, $tempLabelStr, $replaceStr) ;
    }
    $replaceValueParam = $content ;
    return @$replaceValueParam;
}
//call rwend(execute("replaceStr=testfunction(""ME"")") & replaceStr)
function testfunction($s){
    $testfunction = $s . '(end)' ;
    return @$testfunction;
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
//MainContent = HandleDisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent,"style='float:right;padding:0 4px;'")
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

