<?PHP


//http://127.0.0.1/����/ClassAspCode.Asp?act=GetFileFunctionStrList    ������������������



//**************************************** ��php�� ͨ�� ****************************************

//�滻����ֵ 2014  12 01
function newReplaceValueParam($content, $ParamName, $ReplaceStr){
    $StartStr=''; $EndStr=''; $LabelStr=''; $nLen=''; $nTimeFormat=''; $DelHtmlYes=''; $TrimYes ='';
    //ReplaceStr = ReplaceStr & "�����������������ʱ̼ѽ��"
    //ReplaceStr = CStr(ReplaceStr)            'ת���ַ�����
    if( IsNul($ReplaceStr) == true ){ $ReplaceStr = '' ;}

    $StartStr = '[$' . $ParamName ; $EndStr = '$]' ;
    if( instr($content, $StartStr) > 0 && instr($content, $EndStr) > 0 ){
        $LabelStr = StrCut($content, $StartStr, $EndStr, 1) ;
        //ɾ��Html
        $DelHtmlYes = RParam($LabelStr, 'DelHtml') ;//�Ƿ�ɾ��Html
        if( $DelHtmlYes == 'true' ){ $ReplaceStr = Replace(DelHtml($ReplaceStr), '<', '&lt;') ;}//HTML����
        //ɾ�����߿ո�
        $TrimYes = RParam($LabelStr, 'Trim') ;//�Ƿ�ɾ�����߿ո�
        if( $TrimYes == 'true' ){ $ReplaceStr = TrimVbCrlf($ReplaceStr) ;}

        //��ȡ�ַ�����
        $nLen = RParam($LabelStr, 'Len') ;//�ַ�����ֵ
        $nLen = HandleNumber($nLen) ;
        //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        if( $nLen <> '' ){ $ReplaceStr = CutStr($ReplaceStr, $nLen, '...') ;}//Left(ReplaceStr,nLen)

        //ʱ�䴦��
        $nTimeFormat = RParam($LabelStr, 'Format_Time') ;//ʱ�䴦��ֵ
        if( $nTimeFormat <> '' ){
            $ReplaceStr = Format_Time($ReplaceStr, $nTimeFormat) ;
        }
        $content = Replace($content, $LabelStr, $ReplaceStr) ;

    }
    $newReplaceValueParam = $content ;
    return @$newReplaceValueParam;
}

//���ݱ�ǩ�ҵ���Ӧ����
function newRParam($dataCode, $action, $ModuleName){
    $defaultStr=''; $StartStr=''; $EndStr ='';
    $defaultStr = RParam($action, $ModuleName) ;
    $StartStr = '<!--#' . $defaultStr . ' start#-->' ;
    $EndStr = '<!--#' . $defaultStr . ' end#-->' ;

    if( $defaultStr <> '' ){
        //�ж��Ƿ����
        if( instr($dataCode, $StartStr) > 0 && instr($dataCode, $EndStr) > 0 ){
            $defaultStr = StrCut($dataCode, $StartStr, $EndStr, 2) ;
        }else{
            $StartStr = '<!--#' . $defaultStr ;
            $EndStr = '#-->' ;
            if( instr($dataCode, $StartStr) > 0 && instr($dataCode, $EndStr) > 0 ){
                $defaultStr = StrCut($dataCode, $StartStr, $EndStr, 2) ;

                //Call Echo("��","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
            }
        }
    }
    $newRParam = $defaultStr ;
    return @$newRParam;
}




//**************************************** ��php�� ͨ�� **************************************** end






//����ȫ������(20150827)
function getContentAllRunStr($content){
    $splStr=''; $s=''; $c ='';
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        $s = Replace(Replace($s, Chr(10), ''), Chr(13), '') ;//���Ϊʲô s����� chr(10)��chr(13) �أ�
        $c = $c . HandleContentCode($s, '') ;
    }
    $getContentAllRunStr = $c ;
    return @$getContentAllRunStr;
}

//����������к��ַ�  �÷� len(aaaa)  û˫������
function getContentRunStr( $content){
    $getContentRunStr = HandleContentCode($content, '') ;
    return @$getContentRunStr;
}
//������������""�������ɾ����20150329
//����������к��ַ�
function checkContentRunStr( $content){
    $checkContentRunStr = HandleContentCode($content, 'check') ;
    return @$checkContentRunStr;
}
//����˫����
function handleDoubleQuotation( $s){
    $NewS ='';
    $NewS = PHPTrim($s) ;
    if( substr($NewS, 0 , 1) == '"' && substr($NewS, - 1) == '"' ){
        $s = mid($NewS, 2, strlen($NewS) - 2) ;
    }
    $handleDoubleQuotation = $s ;
    return @$handleDoubleQuotation;
}
//��������
function strDQ( $s){
    $strDQ = handleDoubleQuotation($s) ;
    return @$strDQ;
}
//��������� 20150330
function handleToArray($content){
    $splStr=''; $i ='';
    $content = StrCut($content, '(', ')', 2) ;
    //Call Rw(Content)
    $splStr = aspSplit($content, ',') ;
    //Call Rw("<hr>")
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        $splStr[$i] = strDQ($splStr[$i]) ;
        //Call Echo(I,SplStr(I))
    }
    $handleToArray = $splStr ;
    return @$handleToArray;
}
//������������� ����20150324   http://127.0.0.1/����/ClassAspCode.Asp?act=GetFileFunctionStrList  �������    version 1.0
function handleContentCode( $content, $SType){ //���պ���
}


//�ڲ�ģ�鴦�� HandleInModule(Content,"start") HandleInModule(Content,"end")
function handleInModule($content, $SType){
    $SType = LCase(CStr($SType)) ;
    if( $SType == '1' || $SType == 'start' ){
        $content = Replace($content, '\\\'', '\\|*|\\') ;
        $content = Replace($content, '\\=', '\\|&|\\') ;//���20141024
    }else if( $SType == '2' || $SType == 'end' ){
        $content = Replace($content, '\\|*|\\', '\'') ;
        $content = Replace($content, '\\$', '$') ;
        $content = Replace($content, '\\}', '}') ;

        $content = Replace($content, '\\|&|\\', '=') ;//���20141024
    }
    $handleInModule = $content ;
    return @$handleInModule;
}
//���������ʽ���ñ�ǩֵ
function clearRParam( $action, $LableStr){
    $s ='';
    //Action=Replace(Action,"\'","��|\��|��")
    $action = Replace($action, '\\\'', '') ;//���������
    $s = RParam($action, $LableStr) ;
    //s=replace(s,"��|\��|��", "\'")
    $clearRParam = $s ;
    return @$clearRParam;
}
//��ò������ݺ� �ŵ������ﴦ��һ�£�20151023��
function atRParam( $action, $LableStr){
    $atRParam = RParam($action, $LableStr) ;
    if( instr(atRParam, '{$') > 0 && instr(atRParam, '$}') > 0 ){
        $atRParam = HandleTemplateAction(atRParam, false) ;//������
    }
    return @$atRParam;
}
//����������ֵ  Title = RParam(Action,"Title")     ��ǿ���ȡ����ֵ20150723
function rParam( $action, $lableStr){
    $s ='';

    //ԭʼ ������
    $s = handleRParam($action, $lableStr, '\'') ;
    //ԭʼ ˫����
    if( $s == '' ){
        $s = handleRParam($action, $lableStr, '"') ;
    }
    //ԭʼ ��
    if( $s == '' ){
        $s = handleRParam($action, $lableStr, '') ;
    }

    //Сд ������
    if( $s == '' ){
        $s = handleRParam($action, LCase($lableStr), '\'') ;
    }
    //Сд ˫����
    if( $s == '' ){
        $s = handleRParam($action, LCase($lableStr), '"') ;
    }
    //Сд ��
    if( $s == '' ){
        $s = handleRParam($action, LCase($lableStr), '') ;
    }

    //��д ������
    if( $s == '' ){
        $s = handleRParam($action, UCase($lableStr), '\'') ;
    }
    //��д ˫����
    if( $s == '' ){
        $s = handleRParam($action, UCase($lableStr), '"') ;
    }
    //��д ��
    if( $s == '' ){
        $s = handleRParam($action, UCase($lableStr), '') ;
    }
    //��Ҫ�����Ҫ�����ȶ�(20151022)
    //if s=false then s=""
    if( $s == '[#��*ֵ_#]' ){ $s = '' ;}
    $rParam = $s ;
    return @$rParam;
}
//���� ����������ֵ
function handleRParam( $action, $LableStr, $typeStr){
    $LalbeName=''; $endTypeStr=''; $isTrue=''; $s='';
    $isTrue = false ;//�Ƿ�Ϊ��
    $endTypeStr = IIF($typeStr <> '', $typeStr, ' ') ;
    $action = "\n" . ' ' . $action ;//����Ҳ�Ӹ��ո�Ҫ��Ȼ��û�к�����ǰ���û�пո�
    //Ĭ��ǰ��ӿո�
    $LalbeName = ' ' . $LableStr ;//�Ӹ��ո���Ϊ�˾�׼
    //������  ǰ��ӵ�
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = '\'' . $LableStr ;
    }else{
        $isTrue = true ;
    }
    //������ ǰ���˫����
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = '"' . $LableStr ;
    }else{
        $isTrue = true ;
    }
    //������    ǰ���TAB
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = "\t" . $LableStr ;
    }else{
        $isTrue = true ;
    }
    //������    ǰ��ӻ���
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = "\n" . $LableStr ;
    }else{
        $isTrue = true ;
    }
    if( instr($action, $LalbeName . '=' . $typeStr) > 0 && instr($action, $endTypeStr) > 0 ){
        $s = StrCut($action, $LalbeName . '=' . $typeStr, $endTypeStr, 2) ;
        $s = handleInModule($s, 'end') ;//����������� ׷����20141031            ��ԭ����ֵ

        if( $s == '' ){
            $s = '[#��*ֵ_#]' ;
        }

        //�ж��Ƿ�Բ������ж�������
        if( instr($s, '{$') > 0 && instr($s, '$}') > 0 ){

            //handleRParam=HandleTemplateAction(handleRParam,true)        '������
            //handleRParam = handleModuleReplaceArray(handleRParam)'��AddSqL����һ�¶��� ���Ǵ����滻������Ҫ����Ϊ�� HandleTemplateAction���滻��(20151021)

        }
        //��Ҫ�����Ҫ�����ȶ�(20151022)
        //if handleRParam="" then
        //handleRParam=false
        //end if
    }
    $handleRParam=$s;
    return @$handleRParam;
}


//������ÿ� 20150105 GetConfigBlock(ConfigContent, BlockName)
function getConfigBlock($ConfigContent, $BlockName){
    $getConfigBlock = GetCutConfigBlock($ConfigContent, $BlockName, '#', '#') ;
    return @$getConfigBlock;
}
//������ÿ� 20150105
function getConfigBlock2($ConfigContent, $BlockName){
    $getConfigBlock2 = GetCutConfigBlock($ConfigContent, $BlockName, '[#', '#]') ;
    return @$getConfigBlock2;
}
//������ÿ� 20150105
function getConfigBlock3($ConfigContent, $BlockName){
    $getConfigBlock3 = GetCutConfigBlock($ConfigContent, $BlockName, '[$', '$]') ;
    return @$getConfigBlock3;
}
//��ȡ���������п� 20150105
function getCutConfigBlock($ConfigContent, $BlockName, $StartLable, $EndLable){
    $StartStr=''; $EndStr ='';
    $StartStr = $StartLable . $BlockName . $EndLable ;
    $EndStr = $StartLable . $BlockName . $EndLable ;
    //��ʼ��ǩ����
    if( instr($ConfigContent, $StartStr . ' start') > 0 ){
        $StartStr = $StartStr . ' start' ;
    }else{
        $StartStr = $StartStr . ' Start' ;
    }
    //������ǩ����
    if( instr($ConfigContent, $EndStr . ' end') > 0 ){
        $EndStr = $EndStr . ' end' ;
    }else{
        $EndStr = $EndStr . ' End' ;
    }

    if( instr($ConfigContent, $StartStr) > 0 && instr($ConfigContent, $EndStr) > 0 ){
        $getCutConfigBlock = StrCut($ConfigContent, $StartStr, $EndStr, 2) ;
    }
    return @$getCutConfigBlock;
}
//����������ݿ�20150401
function getConfigContentBlock( $ConfigContent, $BlockName){
    $getConfigContentBlock = getCutConfigBlock($ConfigContent, $BlockName, '', '') ;
    return @$getConfigContentBlock;
}
//��������ļ����20150401  GetConfigFileBlock(ConfigPath, "#txtRunCode#")  ���Ա�ǩ��ʱ���Զ�����
function getConfigFileBlock( $ConfigFile, $BlockName){
    $content=''; $FindStr=''; $ReplaceStr=''; $StartStr=''; $EndStr ='';
    $content = GetFText($ConfigFile) ;
    //MsgBox ("ConfigFile=" & ConfigFile & "(" & CheckFile(ConfigFile) & "��" & GetFSize(ConfigFile) & ")" & vbCrLf & "Content=" & Content)
    $StartStr = $BlockName . ' start' ;
    $EndStr = $BlockName . ' end' ;
    $ReplaceStr = $StartStr . '' . $EndStr ;
    if( instr($content, $StartStr) > 0 && instr($content, $EndStr) > 0 ){
        $FindStr = StrCut($content, $StartStr, $EndStr, 2) ;
        $getConfigFileBlock = $FindStr ;
    }else{
        CreateFile($ConfigFile, $content . $ReplaceStr) ;
    }
    return @$getConfigFileBlock;
}
//���������ļ���� 20150401 call SetConfigFileBlock(ConfigFile, "aaabbc", "#�ϴ�Ŀ¼�б�#")  ���������
function setConfigFileBlock( $ConfigFile, $WriteContent, $BlockName){
    $content=''; $FindStr=''; $ReplaceStr=''; $StartStr=''; $EndStr ='';
    $content = GetFText($ConfigFile) ;
    $StartStr = $BlockName . ' start' ;
    $EndStr = $BlockName . ' end' ;
    $ReplaceStr = $StartStr . $WriteContent . $EndStr ;
    if( instr($content, $StartStr) > 0 && instr($content, $EndStr) > 0 ){
        $FindStr = StrCut($content, $StartStr, $EndStr, 1) ;
        $content = Replace($content, $FindStr, $ReplaceStr) ;
        CreateFile($ConfigFile, $content) ;
    }else{
        CreateFile($ConfigFile, $content . $ReplaceStr) ;
    }
}

//ɾ�����ÿ� 20150322
function delConfigBlock($Config, $BlockName){
    $delConfigBlock = DelCutConfigBlock($Config, $BlockName, '#', '#') ;
    return @$delConfigBlock;
}
//ɾ�����ÿ� 20150322
function delConfigBlock2($Config, $BlockName){
    $delConfigBlock2 = DelCutConfigBlock($Config, $BlockName, '[#', '#]') ;
    return @$delConfigBlock2;
}
//ɾ�����ÿ� 20150322
function delConfigBlock3($Config, $BlockName){
    $delConfigBlock3 = DelCutConfigBlock($Config, $BlockName, '[$', '$]') ;
    return @$delConfigBlock3;
}
//ɾ���������� 20150322
function delCutConfigBlock($Config, $BlockName, $StartLable, $EndLable){
    $StartStr=''; $EndStr=''; $s ='';
    $StartStr = $StartLable . $BlockName . $EndLable . ' start' ;
    $EndStr = $StartLable . $BlockName . $EndLable . ' end' ;
    if( instr($Config, $StartStr) > 0 && instr($Config, $EndStr) > 0 ){
        $s = StrCut($Config, $StartStr, $EndStr, 1) ;
        $Config = Replace($Config, $s, '') ;
    }
    $delCutConfigBlock = $Config ;
    return @$delCutConfigBlock;
}




//����ļ������ò�����20150315
function getFileParamValue($ConfigPath, $ParamName){
    $getFileParamValue = HandleGetSetFileParameValue($ConfigPath, $ParamName, '', '���') ;
    return @$getFileParamValue;
}
//�����ļ������ò�����20150315
function setFileParamValue($ConfigPath, $ParamName, $ValueStr){
    $setFileParamValue = HandleGetSetFileParameValue($ConfigPath, $ParamName, $ValueStr, '����') ;
    return @$setFileParamValue;
}
//�����������ļ�����ֵ��20150315
function handleGetSetFileParameValue($ConfigPath, $ParamName, $ValueStr, $SType){
    $content=''; $StartStr=''; $EndStr=''; $YunStr=''; $ReplaceStr ='';
    //�ļ�Ϊ��ʱ������һ�����ļ�������������ܴ�������ļ���˵������ļ���ַ�����⣬���˳�20150324
    if( checkFile($ConfigPath) == false ){
        CreateFile($ConfigPath, '') ;
    }
    if( checkFile($ConfigPath) == false ){ }//�ļ����������˳�

    $content = TrimVbCrlf(GetFText($ConfigPath)) ;
    $StartStr = "\n" . $ParamName . '=' ; $EndStr = "\n" ;
    $ReplaceStr = "\n" . $ParamName . '=' . $ValueStr . "\n" ;
    if( instr("\n" . $content, $StartStr) > 0 && instr($content . "\n", $EndStr) > 0 ){
        $YunStr = StrCut("\n" . $content . "\n", $StartStr, $EndStr, 2) ;
        if( $SType == '���' ){
            $handleGetSetFileParameValue = $YunStr ;
            return @$handleGetSetFileParameValue;
        }
        $YunStr = $StartStr . $YunStr . $EndStr ;
        $content = Replace("\n" . $content . "\n", $YunStr, $ReplaceStr) ;
        CreateFile($ConfigPath, $content) ;
    }else{
        CreateFile($ConfigPath, $content . "\n" . TrimVbCrlf($ReplaceStr)) ;
    }
    return @$handleGetSetFileParameValue;
}

//������������� 20150611
function setRParam($ConfigPath, $paramName, $paramValue, $isNoAdd){
    $content=''; $StartStr=''; $EndStr=''; $s ='';
    $content = PHPTrim(GetFText($ConfigPath)) ;
    $StartStr = $paramName . '=\'' ; $EndStr = '\'' ;
    if( instr($content, $StartStr) > 0 && instr($content, $EndStr) > 0 ){
        $s = StrCut($content, $StartStr, $EndStr, 2) ;
        $content = Replace($content, $StartStr . $s . $EndStr, $StartStr . $paramValue . $EndStr) ;
        CreateFile($ConfigPath, $content) ;

    }else if( AspTrim($isNoAdd) == '1' ){
        CreateAddFile($ConfigPath, $StartStr . $paramValue . $EndStr) ;
    }
}

//׷�ӻ��滻����ֵ 20150615
function addReplaceRParam( $content, $startStr, $endStr, $valueStr){
    $s ='';
    $valueStr = $startStr . $valueStr . $endStr ;
    if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
        $s = StrCut($content, $startStr, $endStr, 1) ;
        $content = Replace($content, $s, $valueStr) ;
    }else{
        $content = $content . "\n" . $valueStr ;
    }
    $addReplaceRParam = $content ;
    return @$addReplaceRParam;
}
//ɾ��ָ���ַ�N��
function deleteStrCut( $content, $StartStr, $EndStr, $CutType, $nDelCount){
    $i=''; $s ='';
    if( $nDelCount == 0 ){
        $nDelCount = 99 ;
    }
    for( $i = 0 ; $i<= $nDelCount; $i++){
        $s = getStrCut($content, $StartStr, $EndStr, 1) ;
        if( $s <> '' ){
            $content = Replace($content, $s, '') ;
        }else{
            break;
        }
    }
    $deleteStrCut = $content ;
    return @$deleteStrCut;
}



//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����",""))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","׷����ǰ"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","׷��"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","׷����ǰ"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","�滻����","�ⲿ׷����ǰ"))
//call Rwend(replaceContentModule(getftext("1.html"), "<div>", "</div>", "�滻����", "�ⲿ׷��"))
//�滻������ģ��   ReplaceType(��Ϊ�滻��׷����ǰ��׷���ں�(׷��)���ⲿ׷����ǰ���ⲿ׷���ں�(�ⲿ׷��))
function replaceContentModule( $content, $StartStr, $EndStr, $ReplaceValue, $ReplaceType){
    $splStr=''; $splxx=''; $s=''; $i=''; $splType=''; $valueList=''; $newStartStr=''; $newEndStr=''; $sourceValueList=''; $sourceValue=''; $tempS=''; $newReplaceValue ='';
    if( instr($content, $StartStr) == false && instr($content, $EndStr) == false ){
        $replaceContentModule = $content ;
        return @$replaceContentModule;
    }
    $splType = '$Array$' ;
    for( $i = 1 ; $i<= 99; $i++){
        if( instr($content, $StartStr) > 0 && instr($content, $EndStr) > 0 ){
            $s = StrCut($content, $StartStr, $EndStr, 1) ; $tempS = $s ;
            $s = mid($s, strlen($StartStr) + 1, strlen($s) - strlen($StartStr) - strlen($EndStr)) ;
            $newStartStr = getEachStrAddValue($StartStr, '|*|') ;
            if( instr($splType . $valueList . $splType, $splType . $newStartStr . $splType) == false ){
                if( $valueList <> '' ){ $valueList = $valueList . $splType ;}
                $valueList = $valueList . $newStartStr ;
                if( $sourceValueList <> '' ){ $sourceValueList = $sourceValueList . $splType ;}
                $sourceValueList = $sourceValueList . $StartStr ;
            }
            $newEndStr = getEachStrAddValue($EndStr, '|*|') ;
            if( instr($splType . $valueList . $splType, $splType . $newEndStr . $splType) == false ){
                if( $valueList <> '' ){ $valueList = $valueList . $splType ;}
                $valueList = $valueList . $newEndStr ;
                if( $sourceValueList <> '' ){ $sourceValueList = $sourceValueList . $splType ;}
                $sourceValueList = $sourceValueList . $EndStr ;
            }

            if( $ReplaceType == '׷����ǰ' ){
                $newReplaceValue = $newStartStr . $ReplaceValue . $s . $newEndStr ;
            }else if( $ReplaceType == '׷���ں�' || $ReplaceType == '׷��' ){
                $newReplaceValue = $newStartStr . $s . $ReplaceValue . $newEndStr ;
            }else if( $ReplaceType == '�ⲿ׷����ǰ' ){
                $newReplaceValue = $ReplaceValue . $newStartStr . $s . $newEndStr ;

            }else if( $ReplaceType == '�ⲿ׷���ں�' || $ReplaceType == '�ⲿ׷��' ){
                $newReplaceValue = $newStartStr . $s . $newEndStr . $ReplaceValue ;
            }else{
                $newReplaceValue = $ReplaceValue ;
            }

            $content = Replace($content, $tempS, $newReplaceValue) ;
        }else{
            break;
        }
    }
    //call rwend(content)
    $splStr = aspSplit($valueList, $splType) ;
    $splxx = aspSplit($sourceValueList, $splType) ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        $sourceValue = $splStr[$i] ;
        $ReplaceValue = $splxx[$i] ;
        $content = Replace($content, $sourceValue, $ReplaceValue) ;
    }
    $replaceContentModule = $content ;
    return @$replaceContentModule;
}

//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "�滻����", "׷����ǰ"))
//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "�滻����", "׷��"))
//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "�滻����", ""))
//�滻������һ��ģ��   ReplaceType(��Ϊ�滻��׷����ǰ��׷���ں�(׷��))
function replaceContentRowModule($content, $searchValue, $ReplaceValue, $ReplaceType){
    $splStr=''; $splxx=''; $i=''; $splType=''; $valueList=''; $sourceValueList=''; $sourceValue=''; $newReplaceValue=''; $newSearchValue ='';
    $splType = '$Array$' ;
    for( $i = 1 ; $i<= 99; $i++){
        if( instr($content, $searchValue) > 0 ){
            $newSearchValue = getEachStrAddValue($searchValue, '|*|') ;
            if( instr($splType . $valueList . $splType, $splType . $newSearchValue . $splType) == false ){
                if( $valueList <> '' ){ $valueList = $valueList . $splType ;}
                $valueList = $valueList . $newSearchValue ;
                if( $sourceValueList <> '' ){ $sourceValueList = $sourceValueList . $splType ;}
                $sourceValueList = $sourceValueList . $searchValue ;
            }
            if( $ReplaceType == '׷����ǰ' ){
                $newReplaceValue = $ReplaceValue . $newSearchValue ;
            }else if( $ReplaceType == '׷���ں�' || $ReplaceType == '׷��' ){
                $newReplaceValue = $newSearchValue . $ReplaceValue ;
            }else{
                $newReplaceValue = $ReplaceValue ;
            }
            $content = Replace($content, $searchValue, $newReplaceValue) ;
        }else{
            break;
        }
    }

    //call rwend(content)
    $splStr = aspSplit($valueList, $splType) ;
    $splxx = aspSplit($sourceValueList, $splType) ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        $sourceValue = $splStr[$i] ;
        $ReplaceValue = $splxx[$i] ;
        $content = Replace($content, $sourceValue, $ReplaceValue) ;
    }
    $replaceContentRowModule = $content ;

    return @$replaceContentRowModule;
}
//���������ĵ�(20150804)
function handleConfigFile($ConfigPath){
    $c ='';
    if( checkFile($ConfigPath) == false ){
        $c = '#Help����# start' . "\n" . 'Ĭ�ϰ�������' . "\n" . '#Help����# end' ;
        CreateFile($ConfigPath, $c) ;
    }
}

//���������ָ������ֵ   RParam��ǿ��(20161025)
function getRParam( $content, $lableStr){
    $contentLCase=''; $endS=''; $i=''; $s=''; $c=''; $isStart=''; $startStr=''; $isValue ='';
    $content = ' ' . $content . ' ' ;//�������׼���ֵ
    $contentLCase = LCase($content) ;
    $lableStr = LCase($lableStr) ;
    $endS = mid($content, instr($contentLCase, $lableStr) + strlen($lableStr),-1) ;
    //call echo("ends",ends)
    $isStart = false ;//�Ƿ��п�ʼ����ֵ
    $isValue = false ;//�Ƿ���ֵ
    for( $i = 1 ; $i<= strlen($endS); $i++){
        $s = mid($endS, $i, 1) ;
        if( $isStart == true ){
            if( $s <> '' ){
                if( $startStr == '' ){
                    $startStr = $s ;
                }else{
                    if( $startStr == '"' || $startStr == '\'' ){
                        if( $s == $startStr ){
                            $isValue = true ;
                            break;
                        }
                    }else if( $s == ' ' && $c == '' ){

                    }else if( $s == ' ' || $s == '/' || $s == '>' ){
                        $isValue = true ;
                        break;
                    }
                    if( $s <> ' ' ){
                        $c = $c . $s ;
                    }
                }
            }
        }

        if( $s == '=' ){
            $isStart = true ;
        }
    }
    if( $isValue == false ){
        $c = '' ;
    }
    $getRParam = $c ;
    //call echo("c",c)
    return @$getRParam;
}

//���ģ��ĳ��ǩĬ������ ��������˶��β��� ����HTMLģ������β���Ĭ��ֵ
function getDefaultValue($action){
    $getDefaultValue = ModuleFindContent($action, 'default') ;
    return @$getDefaultValue;
}

//���ģ���滻����
function addModuleReplaceArray($title,$content){
    $i='';
    for( $i=1 ; $i<= ubound($GLOBALS['ModuleReplaceArray'])-1; $i++){
        if( $GLOBALS['ModuleReplaceArray'][$i][0]=='' ){
            $GLOBALS['ModuleReplaceArray'][$i][0]=$title;
            $GLOBALS['ModuleReplaceArray'][0][$i]=$content;

        }
    }
}
//���ݱ�ǩ�ҵ���Ӧ����
function moduleFindContent($action, $ModuleName){
    $defaultStr=''; $StartStr=''; $EndStr ='';
    $defaultStr = rParam($action, $ModuleName) ;//��תСдLCaseȥ�� ��20151008��
    //Call Echo("Action",Action)

    $StartStr = '<!--#' . $defaultStr . ' start#-->' ;
    $EndStr = '<!--#' . $defaultStr . ' end#-->' ;
    //[_18�����һ������ߵ�һƷ��2014��10��21�� 10ʱ59��]
    //Call Echo("Default",Default)
    //�ж��Ƿ����
    if( instr($GLOBALS['code'], $StartStr) > 0 && instr($GLOBALS['code'], $EndStr) > 0 ){
        $defaultStr = StrCut($GLOBALS['code'], $StartStr, $EndStr, 2) ;
    }else{
        $StartStr = '<!--#' . $defaultStr ;
        $EndStr = '#-->' ;
        if( instr($GLOBALS['code'], $StartStr) > 0 && instr($GLOBALS['code'], $EndStr) > 0 ){
            $defaultStr = StrCut($GLOBALS['code'], $StartStr, $EndStr, 2) ;

            //Call Echo("��","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
        }
    }


    //ɾ��Ĭ��ֵ20150712
    $deletedefault ='';
    $deletedefault = rParam($action, 'deletedefault') ;
    if( $deletedefault == 'true' ){
        addModuleReplaceArray('��ɾ����', $StartStr . $defaultStr . $EndStr) ;
    }
    $moduleFindContent = $defaultStr ;
    return @$moduleFindContent;
}
?>

