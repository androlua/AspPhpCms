<?PHP
//��վ���� 20160223



//����ģ���滻����
function handleModuleReplaceArray( $content){
    $i=''; $startStr=''; $endStr=''; $s=''; $lableName ='';
    for( $i= 1 ; $i<= uBound($GLOBALS['ModuleReplaceArray']) - 1; $i++){
        if( $GLOBALS['ModuleReplaceArray'][$i][ 0]== '' ){
            break;
        }
        //call echo(ModuleReplaceArray(i,0),ModuleReplaceArray(0,i))
        $lableName= $GLOBALS['ModuleReplaceArray'][$i][ 0];
        $s= $GLOBALS['ModuleReplaceArray'][0][ $i];
        if( $lableName== '��ɾ����' ){
            $content= replace($content, $s, '');
        }else{
            $startStr= '<replacestrname ' . $lableName . '>' ; $endStr= '</replacestrname ' . $lableName . '>';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
                $content= replaceContentModule($content, $startStr, $endStr, $s, '');
            }
            $startStr= '<replacestrname ' . $lableName . '/>';
            if( inStr($content, $startStr) > 0 ){
                $content= replaceContentRowModule($content, '<replacestrname ' . $lableName . '/>', $s, '');
            }
        }
    }
    $handleModuleReplaceArray= $content;
    return @$handleModuleReplaceArray;
}

//ȥ��ģ���ﲻ��Ҫ��ʾ���� ɾ��ģ�����ҵ�ע�ʹ���
function delTemplateMyNote($code){
    $startStr=''; $endStr=''; $i=''; $s=''; $handleNumb=''; $splStr=''; $Block=''; $id ='';
    $content=''; $DragSortCssStr=''; $DragSortStart=''; $DragSortEnd=''; $DragSortValue=''; $c ='';
    $lableName='';$lableStartStr='';$lableEndStr='';
    $handleNumb= 99; //���ﶨ�����Ҫ

    //��ǿ��  �����Ҳ����<!--#aaa start#--><!--#aaa end#-->
    $startStr= '<!--#' ; $endStr= '#-->';
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $lableName= StrCut($code, $startStr, $endStr, 2);
            if( inStr($lableName,' start')>0 ){
                $lableName=mid($lableName,1,len($lableName)-6);
            }

            $s=$startStr . $lableName . $endStr;
            $lableStartStr=$startStr . $lableName . ' start' . $endStr;
            $lableEndStr=$startStr . $lableName . ' end' . $endStr;
            if( inStr($code, $lableStartStr) > 0 && inStr($code, $lableEndStr) > 0 ){
                $s= StrCut($code, $lableStartStr, $lableEndStr, 1);
                //call echo(">>",s)
            }
            $code=replace($code,$s,'');
            //call echo("s",s)
            //call echo("lableName",lableName)
            //call echo("lableStartStr",replace(lableStartStr,"<","&lt;"))
            //call echo("lableEndStr",replace(lableEndStr,"<","&lt;"))
        }else{
            break;
        }
    }



    //���ReadBlockList�������б�����  �����и�����ĵط����������ݿ��Դ��ⲿ�������ݣ�����Ժ���
    //Call Eerr("ReadBlockList",ReadBlockList)
    //д��20141118
    //splStr = Split(ReadBlockList, vbCrLf)                 '�������֣�������
    //�޸���20151230
    for( $i= 1 ; $i<= $handleNumb; $i++){
        $startStr= '<R#��������' ; $endStr= ' start#>';
        $Block= StrCut($code, $startStr, $endStr, 2);
        if( $Block <> '' ){
            $startStr= '<R#��������' . $Block . ' start#>' ; $endStr= '<R#��������' . $Block . ' end#>';
            if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
                $s= StrCut($code, $startStr, $endStr, 1);
                $code= replace($code, $s, ''); //�Ƴ�
            }
        }else{
            break;
        }
    }

    //ɾ����ҳ����20160309
    $startStr= '<!--#list start#-->';
    $endStr= '<!--#list end#-->';
    if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
        $s=StrCut($code, $startStr, $endStr, 2);
        $code=replace($code,$s,'');
    }

    if( @$_REQUEST['gl']== 'yun' ){
        $content= getFText('/Jquery/dragsort/Config.html');
        $content= getFText('/Jquery/dragsort/ģ����ק.html');
        //Css��ʽ
        $startStr= '<style>';
        $endStr= '</style>';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortCssStr= StrCut($content, $startStr, $endStr, 1);
        }
        //��ʼ����
        $startStr= '<!--#top start#-->';
        $endStr= '<!--#top end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortStart= StrCut($content, $startStr, $endStr, 2);
        }
        //��������
        $startStr= '<!--#foot start#-->';
        $endStr= '<!--#foot end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortEnd= StrCut($content, $startStr, $endStr, 2);
        }
        //��ʾ������
        $startStr= '<!--#value start#-->';
        $endStr= '<!--#value end#-->';
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $DragSortValue= StrCut($content, $startStr, $endStr, 2);
        }



        //���ƴ���
        $startStr= '<dIv datid=\'';
        $endStr= '</dIv>';
        $content= GetArray($code, $startStr, $endStr, false, false);
        $splStr= aspSplit($content, '$Array$');
        foreach( $splStr as $key=>$s){
            $startStr= '��DatId��\'';
            $id= mid($s, 1, inStr($s, $startStr) - 1);
            $s= mid($s, inStr($s, $startStr) + len($startStr),-1);
            //C=C & "<li><div title='"& Id &"'>" & vbcrlf & "<div " & S & "</div>"& vbcrlf &"<div class='clear'></div></div><div class='clear'></div></li>"
            $s= '<div' . $s . '</div>';
            //Call Die(S)
            $c= $c . replace(replace($DragSortValue, '{$value$}', $s), '{$id$', $id);
        }
        $c= replace($c, '�����С�', vbCrlf());
        $c= $DragSortStart . $c . $DragSortEnd;
        $code= mid($code, 1, inStr($code, '<body>') - 1);
        $code= replace($code, '</head>', $DragSortCssStr . '</head></body>' . $c . '</body></html>');
    }

    //ɾ��VB������ɵ���������
    $startStr= '<dIv datid=\'' ; $endStr= '��DatId��\'';
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $id= StrCut($code, $startStr, $endStr, 2);
            $code= replace2($code, $startStr . $id . $endStr, '<div ');
        }else{
            break;
        }
    }
    $code= replace($code, '</dIv>', '</div>'); //�滻���������div

    //����Χ���
    $startStr= '<!--#dialogteststart#-->' ; $endStr= '<!--#dialogtestend#-->';
    $code= replace($code, '<!--#dialogtest start#-->', $startStr);
    $code= replace($code, '<!--#dialogtest end#-->', $endStr);
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $s= StrCut($code, $startStr, $endStr, 1);
            $code= replace2($code, $s, '');
        }else{
            break;
        }
    }
    //��ת���
    $startStr= '<!--#teststart#-->' ; $endStr= '<!--#testend#-->';
    $code= replace($code, '<!--#del start#-->', $startStr); //������һ��
    $code= replace($code, '<!--#del end#-->', $endStr); //������һ�� ����ʽ
    $code= replace($code, '<!--#test start#-->', $startStr);
    $code= replace($code, '<!--#test end#-->', $endStr);

    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $s= StrCut($code, $startStr, $endStr, 1);
            $code= replace2($code, $s, '');
        }else{
            break;
        }
    }
    //ɾ��ע�͵�span
    $code= replace($code, '<sPAn class="testspan">', ''); //����Span
    $code= replace($code, '<sPAn class="testhidde">', ''); //����Span
    $code= replace($code, '</sPAn>', '');

    //delTemplateMyNote = Code:Exit Function

    $startStr= '<!--#' ; $endStr= '#-->';
    for( $i= 1 ; $i<= $handleNumb; $i++){
        if( inStr($code, $startStr) > 0 && inStr($code, $endStr) > 0 ){
            $s= StrCut($code, $startStr, $endStr, 1);
            $code= replace2($code, $s, '');
        }else{
            break;
        }
    }


    $delTemplateMyNote= $code;
    return @$delTemplateMyNote;
}

//�����滻����ֵ 20160114
function handleReplaceValueParam($content, $paramName, $replaceStr){
    if( inStr($content, '[$' . $paramName)== false ){
        $paramName= lCase($paramName);
    }
    $handleReplaceValueParam= replaceValueParam($content, $paramName, $replaceStr);
    return @$handleReplaceValueParam;
}

//�滻����ֵ 2014  12 01
function replaceValueParam($content, $paramName, $replaceStr){
    $startStr=''; $endStr=''; $labelStr=''; $tempLabelStr=''; $nLen=''; $nTimeFormat=''; $delHtmlYes=''; $funStr=''; $trimYes='';$isEscape=''; $s ='';$i='';
    $ifStr ='';//�ж��ַ�
    $elseIfStr ='';//�ڶ��ж��ַ�
    $valueStr ='';//��ʾ�ַ�
    $elseStr ='';//�����ַ�
    $elseIfValue='';$elseValue																	='';//�ڶ��ж�ֵ
    $instrStr='';$instr2Str ='';//�����ַ�
    $tempReplaceStr																='';//�ݴ�
    //ReplaceStr = ReplaceStr & "�����������������ʱ̼ѽ��"
    //ReplaceStr = CStr(ReplaceStr)            'ת���ַ�����
    if( isNul($replaceStr)== true ){ $replaceStr= '' ;}
    $tempReplaceStr=$replaceStr;

    //��ദ��99��  20160225
    for( $i=1 ; $i<= 999 ; $i++){
        $replaceStr=$tempReplaceStr;													//�ָ�
        $startStr= '[$' . $paramName ; $endStr= '$]';
        //�ֶ������ϸ��ж� 20160226
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 && (inStr($content, $startStr . ' ') > 0 || inStr($content, $startStr . $endStr) > 0) ){
            //��ö�Ӧ�ֶμ�ǿ��20151231
            if( inStr($content, $startStr . $endStr) > 0 ){
                $labelStr= $startStr . $endStr;
            }else if( inStr($content, $startStr . ' ') > 0 ){
                $labelStr= StrCut($content, $startStr . ' ', $endStr, 1);
            }else{
                $labelStr= StrCut($content, $startStr, $endStr, 1);
            }

            $tempLabelStr= $labelStr;
            $labelStr= HandleInModule($labelStr, 'start');
            //ɾ��Html
            $delHtmlYes= RParam($labelStr, 'delHtml'); //�Ƿ�ɾ��Html
            if( $delHtmlYes== 'true' ){ $replaceStr= replace(delHtml($replaceStr), '<', '&lt;') ;}//HTML����
            //ɾ�����߿ո�
            $trimYes= RParam($labelStr, 'trim'); //�Ƿ�ɾ�����߿ո�
            if( $trimYes== 'true' ){ $replaceStr= TrimVbCrlf($replaceStr) ;}

            //��ȡ�ַ�����
            $nLen= RParam($labelStr, 'len'); //�ַ�����ֵ
            $nLen= handleNumber($nLen);
            //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
            if( $nLen <> '' ){ $replaceStr= CutStr($replaceStr, $nLen, '...') ;}//Left(ReplaceStr,nLen)

            //ʱ�䴦��
            $nTimeFormat= RParam($labelStr, 'format_time'); //ʱ�䴦��ֵ
            if( $nTimeFormat <> '' ){
                $replaceStr= Format_Time($replaceStr, $nTimeFormat);
            }

            //�����Ŀ����
            $s= RParam($labelStr, 'getcolumnname');
            if( $s <> '' ){
                if( $s== '@ME' ){
                    $s= $replaceStr;
                }
                $replaceStr= getColumnName($s);
            }
            //�����ĿURL
            $s= RParam($labelStr, 'getcolumnurl');
            if( $s <> '' ){
                if( $s== '@ME' ){
                    $s= $replaceStr;
                }
                $replaceStr= getColumnUrl($s, 'id');
            }
            //�Ƿ�Ϊ��������
            $s= RParam($labelStr, 'password');
            if( $s <> '' ){
                if( $s<>'' ){
                    $replaceStr= $s;
                }
            }

            $ifStr= RParam($labelStr, 'if');
            $elseIfStr= RParam($labelStr, 'elseif');
            $valueStr= RParam($labelStr, 'value');
            $elseifValue= RParam($labelStr, 'elseifvalue');
            $elseValue= RParam($labelStr, 'elsevalue');
            $instrStr= RParam($labelStr, 'instr');
            $instr2Str= RParam($labelStr, 'instr2');

            //call echo("ifStr",ifStr)
            //call echo("valueStr",valueStr)
            //call echo("elseStr",elseStr)
            //call echo("elseIfStr",elseIfStr)
            //call echo("replaceStr",replaceStr)
            if( $ifStr <> '' || $instrStr <> '' ){
                if(($ifStr== cStr($replaceStr) && $ifStr <> '') ){
                    $replaceStr= $valueStr;
                }else if( $elseIfStr== cStr($replaceStr) && $elseIfStr <> '' ){
                    $replaceStr= $valueStr;
                    if( $elseifValue<>'' ){
                        $replaceStr= $elseifValue;
                    }
                }else if( inStr(cStr($replaceStr), $instrStr) > 0 && $instrStr <> '' ){
                    $replaceStr= $valueStr;
                }else if( inStr(cStr($replaceStr), $instr2Str) > 0 && $instr2Str <> '' ){
                    $replaceStr= $valueStr;
                    if( $elseifValue<>'' ){
                        $replaceStr= $elseifValue;
                    }
                }else{
                    if( $elseValue <> '@ME' ){
                        $replaceStr= $elseValue;
                    }
                }
            }

            //��������20151231    [$title  function='left(@ME,40)'$]
            $funStr= RParam($labelStr, 'function'); //����
            if( $funStr <> '' ){
                $funStr= replace($funStr, '@ME', $replaceStr);
                $replaceStr= HandleContentCode($funStr, '');
            }

            //Ĭ��ֵ
            $s= RParam($labelStr, 'default');
            if( $s <> '' && $s<>'@ME' ){
                if( $replaceStr== '' ){
                    $replaceStr= $s;
                }
            }
            //escapeת��
            $isEscape=lCase(RParam($labelStr, 'escape'));
            if( $isEscape=='1' || $isEscape=='true' ){
                $replaceStr=escape($replaceStr);
            }

            //�ı���ɫ
            $s= RParam($labelStr, 'fontcolor'); //����
            if( $s <> '' ){
                $replaceStr= '<font color="' . $s . '">' . $replaceStr . '</font>';
            }




            //call echo(tempLabelStr,replaceStr)
            $content= replace($content, $tempLabelStr, $replaceStr);
        }else{
            break;
        }
    }
    $replaceValueParam= $content;
    return @$replaceValueParam;
}


//��ʾ�༭��20160115
function displayEditor($action){
    $c ='';
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shCore.js"></script> ' . vbCrlf();
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushJScript.js"></script>' . vbCrlf();
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushPhp.js"></script> ' . vbCrlf();
    $c= $c . '<script type="text/javascript" src="\\Jquery\\syntaxhighlighter\\scripts/shBrushVb.js"></script> ' . vbCrlf();
    $c= $c . '<link type="text/css" rel="stylesheet" href="\\Jquery\\syntaxhighlighter\\styles/shCore.css"/>' . vbCrlf();
    $c= $c . '<link type="text/css" rel="stylesheet" href="\\Jquery\\syntaxhighlighter\\styles/shThemeDefault.css"/>' . vbCrlf();
    $c= $c . '<script type="text/javascript">' . vbCrlf();
    $c= $c . '    SyntaxHighlighter.config.clipboardSwf = \'\\Jquery\\syntaxhighlighter\\scripts/clipboard.swf\';' . vbCrlf();
    $c= $c . '    SyntaxHighlighter.all();' . vbCrlf();
    $c= $c . '</script>' . vbCrlf();

    $displayEditor= $c;
    return @$displayEditor;
}
//������վurl20160202
function handleWebUrl($url){
    if( @$_REQUEST['gl'] <> '' ){
        $url= getUrlAddToParam($url, '&gl=' . @$_REQUEST['gl'], 'replace');
    }
    if( @$_REQUEST['templatedir'] <> '' ){
        $url= getUrlAddToParam($url, '&templatedir=' . @$_REQUEST['templatedir'], 'replace');
    }
    $handleWebUrl= $url;
    return @$handleWebUrl;
}

//
//���������޸�
//MainContent = HandleDisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent,"style='float:right;padding:0 4px;'")
function handleDisplayOnlineEditDialog($url, $content, $cssStyle, $replaceStr){
    $controlStr=''; $splStr=''; $s=''; $addOK ='';
    if( @$_REQUEST['gl']== 'edit' ){
        if( inStr($url, '&') > 0 ){
            $url= $url . '&vbgl=true';
        }
        $addOK= false; //���Ĭ��Ϊ��
        $controlStr= getControlStr($url) . '"' . $cssStyle;
        if( $replaceStr <> '' ){
            $splStr= aspSplit($replaceStr, '|');
            foreach( $splStr as $key=>$s){
                if( $s <> '' && inStr($content, $s) > 0 ){
                    $content= replace2($content, $s, $s . $controlStr);
                    $addOK= true;
                    break;
                }
            }
        }
        if( $addOK== false ){
            //��һ��
            //C = "<div "& ControlStr &">" & vbCrlf
            //C=C & Content & vbCrlf
            //C = C & "</div>" & vbCrlf
            //Content = C
            //�ڶ���
            $content= htmlAddAction($content, $controlStr);

            //Content = "<div "& ControlStr &">" & Content & "</div>"
        }
    }
    $handleDisplayOnlineEditDialog= $content;
    return @$handleDisplayOnlineEditDialog;
}
//��ÿ�������
function getControlStr($url){
    if( @$_REQUEST['gl']== 'edit' ){
        $getControlStr= ' onMouseMove="onColor(this,\'#FDFAC6\',\'red\')" onMouseOut="offColor(this,\'\',\'\')" onDblClick="window1(\'' . $url . '\',\'��Ϣ�޸�\')" title=\'˫�����Ҽ������޸�\' oncontextmenu="CommonMenu(event,this,\'\')'; //ɾ����ַΪ��
    }
    return @$getControlStr;
}

//html�Ӷ���(20151103)  call rw(htmlAddAction("  <a href=""javascript:;"">222222</a>", "onclick=""javascript:alert(111);"" "))
function htmlAddAction($content, $jsAction){
    $s=''; $startStr=''; $endStr=''; $isHandle=''; $lableName ='';
    $s= $content;
    $s= PHPTrim($s);
    $startStr= mid($s, 1, inStr($s, ' '));
    $endStr= '>';
    $isHandle= true;

    $lableName= aspTrim(lCase(replace($startStr, '<', '')));
    if( inStr($s, $startStr)== false || inStr($s, $endStr)== false || inStr('|a|div|span|font|h1|h2|h3|h4|h5|h6|dt|dd|dl|li|ul|table|tr|td|', '|' . $lableName . '|')== false ){
        $isHandle= false;
    }

    if( $isHandle== true ){
        $content= $startStr . $jsAction . right($s, len($s) - len($startStr));
    }
    $htmlAddAction= $content;
    return @$htmlAddAction;
}


?>