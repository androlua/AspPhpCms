<?PHP


//http://127.0.0.1/����/ClassAspCode.Asp?act=GetFileFunctionStrList    ������������������



//**************************************** ��php�� ͨ�� ****************************************

//�滻����ֵ 2014  12 01
function newReplaceValueParam($content, $paramName, $replaceStr){
    $startStr=''; $endStr=''; $labelStr=''; $nLen=''; $nTimeFormat=''; $delHtmlYes=''; $trimYes ='';
    //ReplaceStr = ReplaceStr & "�����������������ʱ̼ѽ��"
    //ReplaceStr = CStr(ReplaceStr)            'ת���ַ�����
    if( isNul($replaceStr)== true ){ $replaceStr= '' ;}

    $startStr= '[$' . $paramName ; $endStr= '$]';
    if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
        $labelStr= StrCut($content, $startStr, $endStr, 1);
        //ɾ��Html
        $delHtmlYes= rParam($labelStr, 'DelHtml'); //�Ƿ�ɾ��Html
        if( $delHtmlYes== 'true' ){ $replaceStr= replace(delHtml($replaceStr), '<', '&lt;') ;}//HTML����
        //ɾ�����߿ո�
        $trimYes= rParam($labelStr, 'Trim'); //�Ƿ�ɾ�����߿ո�
        if( $trimYes== 'true' ){ $replaceStr= TrimVbCrlf($replaceStr) ;}

        //��ȡ�ַ�����
        $nLen= rParam($labelStr, 'Len'); //�ַ�����ֵ
        $nLen= handleNumber($nLen);
        //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        if( $nLen <> '' ){ $replaceStr= CutStr($replaceStr, $nLen, '...') ;}//Left(ReplaceStr,nLen)


        //ʱ�䴦��
        $nTimeFormat= rParam($labelStr, 'Format_Time'); //ʱ�䴦��ֵ
        if( $nTimeFormat <> '' ){
            $replaceStr= Format_Time($replaceStr, $nTimeFormat);
        }
        $content= replace($content, $labelStr, $replaceStr);

    }
    $newReplaceValueParam= $content;
    return @$newReplaceValueParam;
}

//���ݱ�ǩ�ҵ���Ӧ����
function newRParam($dataCode, $action, $ModuleName){
    $defaultStr=''; $startStr=''; $endStr ='';
    $defaultStr= rParam($action, $ModuleName);
    $startStr= '<!--#' . $defaultStr . ' start#-->';
    $endStr= '<!--#' . $defaultStr . ' end#-->';

    if( $defaultStr <> '' ){
        //�ж��Ƿ����
        if( inStr($dataCode, $startStr) > 0 && inStr($dataCode, $endStr) > 0 ){
            $defaultStr= StrCut($dataCode, $startStr, $endStr, 2);
        }else{
            $startStr= '<!--#' . $defaultStr;
            $endStr= '#-->';
            if( inStr($dataCode, $startStr) > 0 && inStr($dataCode, $endStr) > 0 ){
                $defaultStr= StrCut($dataCode, $startStr, $endStr, 2);

                //Call Echo("��","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
            }
        }
    }
    $newRParam= $defaultStr;
    return @$newRParam;
}




//**************************************** ��php�� ͨ�� **************************************** end


//����ȫ������(20150827)
function getContentAllRunStr($content){
    $splStr=''; $s=''; $c=''; $tempS='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( $s<>'' ){
            $tempS= $s;
            $s= replace(replace($s, chr(10), ''), chr(13), ''); //���Ϊʲô s����� chr(10)��chr(13) �أ�
            $c= $c . $tempS . '=' . handleContentCode($s, '') . vbCrlf();
        }
    }
    $getContentAllRunStr= $c;
    return @$getContentAllRunStr;
}

//����������к��ַ�  �÷� len(aaaa)  û˫������
function getContentRunStr( $content){
    $getContentRunStr= handleContentCode($content, '');
    return @$getContentRunStr;
}
//������������""�������ɾ����20150329
//����������к��ַ�
function checkContentRunStr( $content){
    $checkContentRunStr= handleContentCode($content, 'check');
    return @$checkContentRunStr;
}
//����˫����
function handleDoubleQuotation( $s){
    $NewS ='';
    $NewS= PHPTrim($s);
    if( left($NewS, 1)== '"' && right($NewS, 1)== '"' ){
        $s= mid($NewS, 2, len($NewS) - 2);
    }
    $handleDoubleQuotation= $s;
    return @$handleDoubleQuotation;
}
//��������
function strDQ( $s){
    $strDQ= handleDoubleQuotation($s);
    return @$strDQ;
}
//��������� 20150330
function handleToArray($content){
    $splStr=''; $i ='';
    $content= StrCut($content, '(', ')', 2);
    //Call Rw(Content)
    $splStr= aspSplit($content, ',');
    //Call Rw("<hr>")
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        $splStr[$i]= strDQ($splStr[$i]);
        //Call Echo(I,SplStr(I))
    }
    $handleToArray= $splStr;
    return @$handleToArray;
}
//������������� ����20150324   http://127.0.0.1/����/ClassAspCode.Asp?act=GetFileFunctionStrList  �������    version 1.0
function handleContentCode( $content, $sType){ return ''; return ''; //���պ���
}


//�ڲ�ģ�鴦�� HandleInModule(Content,"start") HandleInModule(Content,"end")
function handleInModule($content, $sType){
    $sType= lCase(cStr($sType));
    if( $sType== '1' || $sType== 'start' ){
        $content= replace($content, '\\\'', '\\|*|\\');
        $content= replace($content, '\\=', '\\|&|\\'); //���20141024
    }else if( $sType== '2' || $sType== 'end' ){
        $content= replace($content, '\\|*|\\', '\'');
        $content= replace($content, '\\$', '$');
        $content= replace($content, '\\}', '}');

        $content= replace($content, '\\|&|\\', '='); //���20141024
    }
    $handleInModule= $content;
    return @$handleInModule;
}
//���������ʽ���ñ�ǩֵ
function clearRParam( $action, $LableStr){
    $s ='';
    //Action=Replace(Action,"\'","��|\��|��")
    $action= replace($action, '\\\'', ''); //���������
    $s= rParam($action, $LableStr);
    //s=replace(s,"��|\��|��", "\'")
    $clearRParam= $s;
    return @$clearRParam;
}
//��ò������ݺ� �ŵ������ﴦ��һ�£�20151023��
function atRParam( $action, $LableStr){
    $atRParam= rParam($action, $LableStr);
    if( inStr(atRParam, '{$') > 0 && inStr(atRParam, '$}') > 0 ){
        $atRParam= HandleTemplateAction(atRParam, false); //������
    }
    return @$atRParam;
}
//����������ֵ  Title = RParam(Action,"Title")     ��ǿ���ȡ����ֵ20150723
function rParam( $action, $lableStr){
    $s ='';

    //ԭʼ ������
    $s= handleRParam($action, $lableStr, '\'');
    //ԭʼ ˫����
    if( $s== '' ){
        $s= handleRParam($action, $lableStr, '"');
    }
    //ԭʼ ��
    if( $s== '' ){
        $s= handleRParam($action, $lableStr, '');
    }

    //Сд ������
    if( $s== '' ){
        $s= handleRParam($action, lCase($lableStr), '\'');
    }
    //Сд ˫����
    if( $s== '' ){
        $s= handleRParam($action, lCase($lableStr), '"');
    }
    //Сд ��
    if( $s== '' ){
        $s= handleRParam($action, lCase($lableStr), '');
    }

    //��д ������
    if( $s== '' ){
        $s= handleRParam($action, uCase($lableStr), '\'');
    }
    //��д ˫����
    if( $s== '' ){
        $s= handleRParam($action, uCase($lableStr), '"');
    }
    //��д ��
    if( $s== '' ){
        $s= handleRParam($action, uCase($lableStr), '');
    }
    //��Ҫ�����Ҫ�����ȶ�(20151022)
    //if s=false then s=""
    if( $s== '[#��*ֵ_#]' ){ $s= '' ;}
    $rParam= $s;
    return @$rParam;
}
//���� ����������ֵ
function handleRParam( $action, $LableStr, $typeStr){
    $LalbeName=''; $endTypeStr=''; $isTrue=''; $s ='';
    $isTrue= false; //�Ƿ�Ϊ��
    $endTypeStr= IIF($typeStr <> '', $typeStr, ' ');
    $action= vbCrlf() . ' ' . $action; //����Ҳ�Ӹ��ո�Ҫ��Ȼ��û�к�����ǰ���û�пո�
    //Ĭ��ǰ��ӿո�
    $LalbeName= ' ' . $LableStr; //�Ӹ��ո���Ϊ�˾�׼
    //������  ǰ��ӵ�
    if( inStr($action, $LalbeName . '=' . $typeStr)== false && $isTrue== false ){
        $LalbeName= '\'' . $LableStr;
    }else{
        $isTrue= true;
    }
    //������ ǰ���˫����
    if( inStr($action, $LalbeName . '=' . $typeStr)== false && $isTrue== false ){
        $LalbeName= '"' . $LableStr;
    }else{
        $isTrue= true;
    }
    //������    ǰ���TAB
    if( inStr($action, $LalbeName . '=' . $typeStr)== false && $isTrue== false ){
        $LalbeName= vbTab() . $LableStr;
    }else{
        $isTrue= true;
    }
    //������    ǰ��ӻ���
    if( inStr($action, $LalbeName . '=' . $typeStr)== false && $isTrue== false ){
        $LalbeName= vbCrlf() . $LableStr;
    }else{
        $isTrue= true;
    }
    if( inStr($action, $LalbeName . '=' . $typeStr) > 0 && inStr($action, $endTypeStr) > 0 ){
        $s= StrCut($action, $LalbeName . '=' . $typeStr, $endTypeStr, 2);
        $s= handleInModule($s, 'end'); //����������� ׷����20141031            ��ԭ����ֵ

        if( $s== '' ){
            $s= '[#��*ֵ_#]';
        }

        //�ж��Ƿ�Բ������ж�������
        if( inStr($s, '{$') > 0 && inStr($s, '$}') > 0 ){

            //handleRParam=HandleTemplateAction(handleRParam,true)        '������
            //handleRParam = handleModuleReplaceArray(handleRParam)'��AddSqL����һ�¶��� ���Ǵ����滻������Ҫ����Ϊ�� HandleTemplateAction���滻��(20151021)

        }
        //��Ҫ�����Ҫ�����ȶ�(20151022)
        //if handleRParam="" then
        //handleRParam=false
        //end if
    }
    $handleRParam= $s;
    return @$handleRParam;
}


//������ÿ� 20150105 GetConfigBlock(ConfigContent, BlockName)
function getConfigBlock($ConfigContent, $BlockName){
    $getConfigBlock= getCutConfigBlock($ConfigContent, $BlockName, '#', '#');
    return @$getConfigBlock;
}
//������ÿ� 20150105
function getConfigBlock2($ConfigContent, $BlockName){
    $getConfigBlock2= getCutConfigBlock($ConfigContent, $BlockName, '[#', '#]');
    return @$getConfigBlock2;
}
//������ÿ� 20150105
function getConfigBlock3($ConfigContent, $BlockName){
    $getConfigBlock3= getCutConfigBlock($ConfigContent, $BlockName, '[$', '$]');
    return @$getConfigBlock3;
}
//��ȡ���������п� 20150105
function getCutConfigBlock($ConfigContent, $BlockName, $StartLable, $EndLable){
    $startStr=''; $endStr ='';
    $startStr= $StartLable . $BlockName . $EndLable;
    $endStr= $StartLable . $BlockName . $EndLable;
    //��ʼ��ǩ����
    if( inStr($ConfigContent, $startStr . ' start') > 0 ){
        $startStr= $startStr . ' start';
    }else{
        $startStr= $startStr . ' Start';
    }
    //������ǩ����
    if( inStr($ConfigContent, $endStr . ' end') > 0 ){
        $endStr= $endStr . ' end';
    }else{
        $endStr= $endStr . ' End';
    }

    if( inStr($ConfigContent, $startStr) > 0 && inStr($ConfigContent, $endStr) > 0 ){
        $getCutConfigBlock= StrCut($ConfigContent, $startStr, $endStr, 2);
    }
    return @$getCutConfigBlock;
}
//����������ݿ�20150401
function getConfigContentBlock( $ConfigContent, $BlockName){
    $getConfigContentBlock= getCutConfigBlock($ConfigContent, $BlockName, '', '');
    return @$getConfigContentBlock;
}
//��������ļ����20150401  getConfigFileBlock(ConfigPath, "#txtRunCode#")  ���Ա�ǩ��ʱ���Զ�����
function getConfigFileBlock( $ConfigFile, $BlockName){
    $content=''; $FindStr=''; $replaceStr=''; $startStr=''; $endStr ='';
    $content= getFText($ConfigFile);
    //MsgBox ("ConfigFile=" & ConfigFile & "(" & CheckFile(ConfigFile) & "��" & GetFSize(ConfigFile) & ")" & vbCrLf & "Content=" & Content)
    $startStr= $BlockName . ' start';
    $endStr= $BlockName . ' end';
    $replaceStr= $startStr . '' . $endStr;
    if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
        $FindStr= StrCut($content, $startStr, $endStr, 2);
        $getConfigFileBlock= $FindStr;
    }else{
        createFile($ConfigFile, $content . $replaceStr);
    }
    return @$getConfigFileBlock;
}
//���������ļ���� 20150401 call setConfigFileBlock(ConfigFile, "aaabbc", "#�ϴ�Ŀ¼�б�#")  ���������
function setConfigFileBlock( $ConfigFile, $WriteContent, $BlockName){
    $content=''; $FindStr=''; $replaceStr=''; $startStr=''; $endStr ='';
    $content= getFText($ConfigFile);
    $startStr= $BlockName . ' start';
    $endStr= $BlockName . ' end';
    $replaceStr= $startStr . $WriteContent . $endStr;
    if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
        $FindStr= StrCut($content, $startStr, $endStr, 1);
        $content= replace($content, $FindStr, $replaceStr);
    }else{
        $content= $content . $replaceStr;
    }
    createFile($ConfigFile, $content);
    $setConfigFileBlock= $content;
    return @$setConfigFileBlock;
}

//ɾ�����ÿ� 20150322
function delConfigBlock($Config, $BlockName){
    $delConfigBlock= delCutConfigBlock($Config, $BlockName, '#', '#');
    return @$delConfigBlock;
}
//ɾ�����ÿ� 20150322
function delConfigBlock2($Config, $BlockName){
    $delConfigBlock2= delCutConfigBlock($Config, $BlockName, '[#', '#]');
    return @$delConfigBlock2;
}
//ɾ�����ÿ� 20150322
function delConfigBlock3($Config, $BlockName){
    $delConfigBlock3= delCutConfigBlock($Config, $BlockName, '[$', '$]');
    return @$delConfigBlock3;
}
//ɾ���������� 20150322
function delCutConfigBlock($Config, $BlockName, $StartLable, $EndLable){
    $startStr=''; $endStr=''; $s ='';
    $startStr= $StartLable . $BlockName . $EndLable . ' start';
    $endStr= $StartLable . $BlockName . $EndLable . ' end';
    if( inStr($Config, $startStr) > 0 && inStr($Config, $endStr) > 0 ){
        $s= StrCut($Config, $startStr, $endStr, 1);
        $Config= replace($Config, $s, '');
    }
    $delCutConfigBlock= $Config;
    return @$delCutConfigBlock;
}




//����ļ������ò�����20150315
function getFileParamValue($ConfigPath, $paramName){
    $getFileParamValue= handleGetSetFileParameValue($ConfigPath, $paramName, '', '���');
    return @$getFileParamValue;
}
//�����ļ������ò�����20150315
function setFileParamValue($ConfigPath, $paramName, $valueStr){
    $setFileParamValue= handleGetSetFileParameValue($ConfigPath, $paramName, $valueStr, '����');
    return @$setFileParamValue;
}
//�����������ļ�����ֵ��20150315
function handleGetSetFileParameValue($ConfigPath, $paramName, $valueStr, $sType){
    $content=''; $startStr=''; $endStr=''; $YunStr=''; $replaceStr ='';
    //�ļ�Ϊ��ʱ������һ�����ļ�������������ܴ�������ļ���˵������ļ���ַ�����⣬���˳�20150324
    if( CheckFile($ConfigPath)== false ){
        createFile($ConfigPath, '');
    }
    if( CheckFile($ConfigPath)== false ){ return ''; }//�ļ����������˳�

    $content= TrimVbCrlf(getFText($ConfigPath));
    $startStr= vbCrlf() . $paramName . '=' ; $endStr= vbCrlf();
    $replaceStr= vbCrlf() . $paramName . '=' . $valueStr . vbCrlf();
    if( inStr(vbCrlf() . $content, $startStr) > 0 && inStr($content . vbCrlf(), $endStr) > 0 ){
        $YunStr= StrCut(vbCrlf() . $content . vbCrlf(), $startStr, $endStr, 2);
        if( $sType== '���' ){
            $handleGetSetFileParameValue= $YunStr;
            return @$handleGetSetFileParameValue;
        }
        $YunStr= $startStr . $YunStr . $endStr;
        $content= replace(vbCrlf() . $content . vbCrlf(), $YunStr, $replaceStr);
        createFile($ConfigPath, $content);
    }else{
        createFile($ConfigPath, $content . vbCrlf() . TrimVbCrlf($replaceStr));
    }
    return @$handleGetSetFileParameValue;
}

//������������� 20150611
function setRParam($ConfigPath, $paramName, $paramValue, $isNoAdd){
    $content=''; $startStr=''; $endStr=''; $s ='';
    $content= PHPTrim(getFText($ConfigPath));
    $startStr= $paramName . '=\'' ; $endStr= '\'';
    if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
        $s= StrCut($content, $startStr, $endStr, 2);
        $content= replace($content, $startStr . $s . $endStr, $startStr . $paramValue . $endStr);
        createFile($ConfigPath, $content);

    }else if( aspTrim($isNoAdd)== '1' ){
        CreateAddFile($ConfigPath, $startStr . $paramValue . $endStr);
    }
}

//׷�ӻ��滻����ֵ 20150615
function addReplaceRParam( $content, $startStr, $endStr, $valueStr){
    $s ='';
    $valueStr= $startStr . $valueStr . $endStr;
    if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
        $s= StrCut($content, $startStr, $endStr, 1);
        $content= replace($content, $s, $valueStr);
    }else{
        $content= $content . vbCrlf() . $valueStr;
    }
    $addReplaceRParam= $content;
    return @$addReplaceRParam;
}
//ɾ��ָ���ַ�N��
function deleteStrCut( $content, $startStr, $endStr, $cutType, $nDelCount){
    $i=''; $s ='';
    if( $nDelCount== 0 ){
        $nDelCount= 99;
    }
    for( $i= 0 ; $i<= $nDelCount; $i++){
        $s= getStrCut($content, $startStr, $endStr, 1);
        if( $s <> '' ){
            $content= replace($content, $s, '');
        }else{
            break;
        }
    }
    $deleteStrCut= $content;
    return @$deleteStrCut;
}



//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����",""))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","׷����ǰ"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","׷��"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","׷����ǰ"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","�ⲿ׷����ǰ"))
//call Rwend(replaceContentModule(getftext("1.html"), "<div>", "</div>", "�滻����", "�ⲿ׷��"))
//�滻������ģ��   ReplaceType(��Ϊ�滻��׷����ǰ��׷���ں�(׷��)���ⲿ׷����ǰ���ⲿ׷���ں�(�ⲿ׷��))
function replaceContentModule( $content, $startStr, $endStr, $ReplaceValue, $ReplaceType){
    $splStr=''; $splxx=''; $s=''; $i=''; $splType=''; $valueList=''; $newStartStr=''; $newEndStr=''; $sourceValueList=''; $sourceValue=''; $tempS=''; $newReplaceValue ='';
    if( inStr($content, $startStr)== false && inStr($content, $endStr)== false ){
        $replaceContentModule= $content;
        return @$replaceContentModule;
    }
    $splType= '$Array$';
    for( $i= 1 ; $i<= 99; $i++){
        if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
            $s= StrCut($content, $startStr, $endStr, 1) ; $tempS= $s;
            $s= mid($s, len($startStr) + 1, len($s) - len($startStr) - len($endStr));
            $newStartStr= getEachStrAddValue($startStr, '|*|');
            if( inStr($splType . $valueList . $splType, $splType . $newStartStr . $splType)== false ){
                if( $valueList <> '' ){ $valueList= $valueList . $splType ;}
                $valueList= $valueList . $newStartStr;
                if( $sourceValueList <> '' ){ $sourceValueList= $sourceValueList . $splType ;}
                $sourceValueList= $sourceValueList . $startStr;
            }
            $newEndStr= getEachStrAddValue($endStr, '|*|');
            if( inStr($splType . $valueList . $splType, $splType . $newEndStr . $splType)== false ){
                if( $valueList <> '' ){ $valueList= $valueList . $splType ;}
                $valueList= $valueList . $newEndStr;
                if( $sourceValueList <> '' ){ $sourceValueList= $sourceValueList . $splType ;}
                $sourceValueList= $sourceValueList . $endStr;
            }

            if( $ReplaceType== '׷����ǰ' ){
                $newReplaceValue= $newStartStr . $ReplaceValue . $s . $newEndStr;
            }else if( $ReplaceType== '׷���ں�' || $ReplaceType== '׷��' ){
                $newReplaceValue= $newStartStr . $s . $ReplaceValue . $newEndStr;
            }else if( $ReplaceType== '�ⲿ׷����ǰ' ){
                $newReplaceValue= $ReplaceValue . $newStartStr . $s . $newEndStr;

            }else if( $ReplaceType== '�ⲿ׷���ں�' || $ReplaceType== '�ⲿ׷��' ){
                $newReplaceValue= $newStartStr . $s . $newEndStr . $ReplaceValue;
            }else{
                $newReplaceValue= $ReplaceValue;
            }

            $content= replace($content, $tempS, $newReplaceValue);
        }else{
            break;
        }
    }
    //call rwend(content)
    $splStr= aspSplit($valueList, $splType);
    $splxx= aspSplit($sourceValueList, $splType);
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        $sourceValue= $splStr[$i];
        $ReplaceValue= $splxx[$i];
        $content= replace($content, $sourceValue, $ReplaceValue);
    }
    $replaceContentModule= $content;
    return @$replaceContentModule;
}

//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "�滻����", "׷����ǰ"))
//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "�滻����", "׷��"))
//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "�滻����", ""))
//�滻������һ��ģ��   ReplaceType(��Ϊ�滻��׷����ǰ��׷���ں�(׷��))
function replaceContentRowModule($content, $searchValue, $ReplaceValue, $ReplaceType){
    $splStr=''; $splxx=''; $i=''; $splType=''; $valueList=''; $sourceValueList=''; $sourceValue=''; $newReplaceValue=''; $newSearchValue ='';
    $splType= '$Array$';
    for( $i= 1 ; $i<= 99; $i++){
        if( inStr($content, $searchValue) > 0 ){
            $newSearchValue= getEachStrAddValue($searchValue, '|*|');
            if( inStr($splType . $valueList . $splType, $splType . $newSearchValue . $splType)== false ){
                if( $valueList <> '' ){ $valueList= $valueList . $splType ;}
                $valueList= $valueList . $newSearchValue;
                if( $sourceValueList <> '' ){ $sourceValueList= $sourceValueList . $splType ;}
                $sourceValueList= $sourceValueList . $searchValue;
            }
            if( $ReplaceType== '׷����ǰ' ){
                $newReplaceValue= $ReplaceValue . $newSearchValue;
            }else if( $ReplaceType== '׷���ں�' || $ReplaceType== '׷��' ){
                $newReplaceValue= $newSearchValue . $ReplaceValue;
            }else{
                $newReplaceValue= $ReplaceValue;
            }
            $content= replace($content, $searchValue, $newReplaceValue);
        }else{
            break;
        }
    }

    //call rwend(content)
    $splStr= aspSplit($valueList, $splType);
    $splxx= aspSplit($sourceValueList, $splType);
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        $sourceValue= $splStr[$i];
        $ReplaceValue= $splxx[$i];
        $content= replace($content, $sourceValue, $ReplaceValue);
    }
    $replaceContentRowModule= $content;

    return @$replaceContentRowModule;
}
//���������ĵ�(20150804)
function handleConfigFile($ConfigPath){
    $c ='';
    if( CheckFile($ConfigPath)== false ){
        $c= '#Help����# start' . vbCrlf() . 'Ĭ�ϰ�������' . vbCrlf() . '#Help����# end';
        createFile($ConfigPath, $c);
    }
}

//���������ָ������ֵ   RParam��ǿ��(20161025)
function getRParam( $content, $lableStr){
    $contentLCase=''; $endS=''; $i=''; $s=''; $c=''; $isStart=''; $startStr=''; $isValue ='';
    $content= ' ' . $content . ' '; //�������׼���ֵ
    $contentLCase= lCase($content);
    $lableStr= lCase($lableStr);
    $endS= mid($content, inStr($contentLCase, $lableStr) + len($lableStr),-1);
    //call echo("ends",ends)
    $isStart= false; //�Ƿ��п�ʼ����ֵ
    $isValue= false; //�Ƿ���ֵ
    for( $i= 1 ; $i<= len($endS); $i++){
        $s= mid($endS, $i, 1);
        if( $isStart== true ){
            if( $s <> '' ){
                if( $startStr== '' ){
                    $startStr= $s;
                }else{
                    if( $startStr== '"' || $startStr== '\'' ){
                        if( $s== $startStr ){
                            $isValue= true;
                            break;
                        }
                    }else if( $s== ' ' && $c== '' ){

                    }else if( $s== ' ' || $s== '/' || $s== '>' ){
                        $isValue= true;
                        break;
                    }
                    if( $s <> ' ' ){
                        $c= $c . $s;
                    }
                }
            }
        }

        if( $s== '=' ){
            $isStart= true;
        }
    }
    if( $isValue== false ){
        $c= '';
    }
    $getRParam= $c;
    //call echo("c",c)
    return @$getRParam;
}

//���ģ��ĳ��ǩĬ������ ��������˶��β��� ����HTMLģ������β���Ĭ��ֵ
function getDefaultValue($action){
    $getDefaultValue= moduleFindContent($action, 'default');
    return @$getDefaultValue;
}

//���ģ���滻����
function addModuleReplaceArray($title, $content){
    $i ='';
    for( $i= 1 ; $i<= uBound($GLOBALS['ModuleReplaceArray']) - 1; $i++){
        if( $GLOBALS['ModuleReplaceArray'][$i][ 0]== '' ){
            $GLOBALS['ModuleReplaceArray'][$i][ 0]= $title;
            $GLOBALS['ModuleReplaceArray'][0][ $i]= $content;
            return '';
        }
    }
}

//���ݱ�ǩ�ҵ���Ӧ����
function moduleFindContent($action, $ModuleName){
    $defaultStr=''; $startStr=''; $endStr ='';
    $defaultStr= rParam($action, $ModuleName); //��תСдLCaseȥ�� ��20151008��

    $startStr= '<!--#' . $defaultStr . ' start#-->';
    $endStr= '<!--#' . $defaultStr . ' end#-->';
    //[_18�����һ������ߵ�һƷ��2014��10��21�� 10ʱ59��]
    //Call Echo("Default",Default)
    //�ж��Ƿ����
    if( inStr($GLOBALS['code'], $startStr) > 0 && inStr($GLOBALS['code'], $endStr) > 0 ){
        $defaultStr= getStrCut($GLOBALS['code'], $startStr, $endStr, 2);
    }else if( $defaultStr <> '' ){
        $startStr= '<!--#' . $defaultStr;
        $endStr= '#-->';
        if( inStr($GLOBALS['code'], $startStr) > 0 && inStr($GLOBALS['code'], $endStr) > 0 ){
            $defaultStr= getStrCut($GLOBALS['code'], $startStr, $endStr, 2);
        }
    }

    //ɾ��Ĭ��ֵ20150712
    $deletedefault ='';
    $deletedefault= rParam($action, 'deletedefault');
    if( $deletedefault== 'true' ){
        addModuleReplaceArray('��ɾ����', $startStr . $defaultStr . $endStr);
    }
    $moduleFindContent= $defaultStr;
    return @$moduleFindContent;
}
?>