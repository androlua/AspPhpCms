<?PHP
//ASP��PHPͨ�ú���



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
    if( instr($content, '[$' . $paramName)==false ){
        $paramName=lcase($paramName);
    }
    $handleReplaceValueParam=replaceValueParam($content, $paramName, $replaceStr);
    return @$handleReplaceValueParam;
}

//�滻����ֵ 2014  12 01
function replaceValueParam($content, $paramName, $replaceStr){
    $startStr=''; $endStr=''; $labelStr='';$tempLabelStr=''; $nLen=''; $nTimeFormat=''; $delHtmlYes=''; $funStr=''; $trimYes=''; $s='';
    $ifStr		='';//�ж��ַ�
    $valueStr	='';//��ʾ�ַ�
    $elseStr		='';//�����ַ�
    $instrStr	='';//�����ַ�
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
        $tempLabelStr=$labelStr;
        $labelStr=handleInModule($labelStr,'start');
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
            $replaceStr = Format_Time($replaceStr, $nTimeFormat);
        }

        //�����Ŀ����
        $s = RParam($labelStr, 'getcolumnname');
        if( $s <> '' ){
            $replaceStr = getcolumnname($replaceStr);
        }

        $ifStr=RParam($labelStr,'if');
        $valueStr=RParam($labelStr,'value');
        $elseStr=RParam($labelStr,'else');
        $instrStr=RParam($labelStr,'instr');
        //call echo("ifStr",ifStr)
        //call echo("valueStr",valueStr)
        //call echo("elseStr",elseStr)
        if( $ifStr<>'' || $instrStr<>'' ){
            //call echo(ifstr,replaceStr)
            if( $ifStr==CStr($replaceStr) && $ifStr<>'' ){
                $replaceStr=$valueStr;
            }else if( instr(CStr($replaceStr),$instrStr)>0 && $instrStr<>'' ){
                $replaceStr=$valueStr;
            }else{
                if( $elseStr<>'@ME' ){
                    $replaceStr=$elseStr;
                }
            }
        }

        //��������20151231    [$title  function='left(@ME,40)'$]
        $funStr = RParam($labelStr, 'function') ;//����
        if( $funStr <> '' ){
            $funStr=replace($funStr,'@ME',$replaceStr);
            $replaceStr=handleContentCode($funStr,'');
        }
        $content = Replace($content, $tempLabelStr, $replaceStr) ;
    }
    $replaceValueParam = $content ;
    return @$replaceValueParam;
}
//call rwend(execute("replaceStr=testfunction(""ME"")") & replaceStr)
function testfunction($s){
    $testfunction=$s . '(end)';
    return @$testfunction;
}
?>

