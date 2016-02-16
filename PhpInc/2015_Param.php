<?PHP


//http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList    从这里面获得最新设置



//**************************************** 给php用 通用 ****************************************

//替换参数值 2014  12 01
function newReplaceValueParam($content, $ParamName, $ReplaceStr){
    $StartStr=''; $EndStr=''; $LabelStr=''; $nLen=''; $nTimeFormat=''; $DelHtmlYes=''; $TrimYes ='';
    //ReplaceStr = ReplaceStr & "这里面放上内容在这时碳呀。"
    //ReplaceStr = CStr(ReplaceStr)            '转成字符类型
    if( IsNul($ReplaceStr) == true ){ $ReplaceStr = '' ;}

    $StartStr = '[$' . $ParamName ; $EndStr = '$]' ;
    if( instr($content, $StartStr) > 0 && instr($content, $EndStr) > 0 ){
        $LabelStr = StrCut($content, $StartStr, $EndStr, 1) ;
        //删除Html
        $DelHtmlYes = RParam($LabelStr, 'DelHtml') ;//是否删除Html
        if( $DelHtmlYes == 'true' ){ $ReplaceStr = Replace(DelHtml($ReplaceStr), '<', '&lt;') ;}//HTML处理
        //删除两边空格
        $TrimYes = RParam($LabelStr, 'Trim') ;//是否删除两边空格
        if( $TrimYes == 'true' ){ $ReplaceStr = TrimVbCrlf($ReplaceStr) ;}

        //截取字符处理
        $nLen = RParam($LabelStr, 'Len') ;//字符长度值
        $nLen = HandleNumber($nLen) ;
        //If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        if( $nLen <> '' ){ $ReplaceStr = CutStr($ReplaceStr, $nLen, '...') ;}//Left(ReplaceStr,nLen)

        //时间处理
        $nTimeFormat = RParam($LabelStr, 'Format_Time') ;//时间处理值
        if( $nTimeFormat <> '' ){
            $ReplaceStr = Format_Time($ReplaceStr, $nTimeFormat) ;
        }
        $content = Replace($content, $LabelStr, $ReplaceStr) ;

    }
    $newReplaceValueParam = $content ;
    return @$newReplaceValueParam;
}

//根据标签找到对应内容
function newRParam($dataCode, $action, $ModuleName){
    $defaultStr=''; $StartStr=''; $EndStr ='';
    $defaultStr = RParam($action, $ModuleName) ;
    $StartStr = '<!--#' . $defaultStr . ' start#-->' ;
    $EndStr = '<!--#' . $defaultStr . ' end#-->' ;

    if( $defaultStr <> '' ){
        //判断是否存在
        if( instr($dataCode, $StartStr) > 0 && instr($dataCode, $EndStr) > 0 ){
            $defaultStr = StrCut($dataCode, $StartStr, $EndStr, 2) ;
        }else{
            $StartStr = '<!--#' . $defaultStr ;
            $EndStr = '#-->' ;
            if( instr($dataCode, $StartStr) > 0 && instr($dataCode, $EndStr) > 0 ){
                $defaultStr = StrCut($dataCode, $StartStr, $EndStr, 2) ;

                //Call Echo("有","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
            }
        }
    }
    $newRParam = $defaultStr ;
    return @$newRParam;
}




//**************************************** 给php用 通用 **************************************** end






//运行全部动作(20150827)
function getContentAllRunStr($content){
    $splStr=''; $s=''; $c ='';
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        $s = Replace(Replace($s, Chr(10), ''), Chr(13), '') ;//奇怪为什么 s里会有 chr(10)与chr(13) 呢？
        $c = $c . HandleContentCode($s, '') ;
    }
    $getContentAllRunStr = $c ;
    return @$getContentAllRunStr;
}

//获得内容运行后字符  用法 len(aaaa)  没双引单引
function getContentRunStr( $content){
    $getContentRunStr = HandleContentCode($content, '') ;
    return @$getContentRunStr;
}
//处理内容里有""，则给它删除掉20150329
//检测内容运行后字符
function checkContentRunStr( $content){
    $checkContentRunStr = HandleContentCode($content, 'check') ;
    return @$checkContentRunStr;
}
//处理双引号
function handleDoubleQuotation( $s){
    $NewS ='';
    $NewS = PHPTrim($s) ;
    if( substr($NewS, 0 , 1) == '"' && substr($NewS, - 1) == '"' ){
        $s = mid($NewS, 2, strlen($NewS) - 2) ;
    }
    $handleDoubleQuotation = $s ;
    return @$handleDoubleQuotation;
}
//辅助上面
function strDQ( $s){
    $strDQ = handleDoubleQuotation($s) ;
    return @$strDQ;
}
//处理成数据 20150330
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
//处理内容里代码 引擎20150324   http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList  获得最新    version 1.0
function handleContentCode( $content, $SType){ //留空函数
}


//内部模块处理 HandleInModule(Content,"start") HandleInModule(Content,"end")
function handleInModule($content, $SType){
    $SType = LCase(CStr($SType)) ;
    if( $SType == '1' || $SType == 'start' ){
        $content = Replace($content, '\\\'', '\\|*|\\') ;
        $content = Replace($content, '\\=', '\\|&|\\') ;//后加20141024
    }else if( $SType == '2' || $SType == 'end' ){
        $content = Replace($content, '\\|*|\\', '\'') ;
        $content = Replace($content, '\\$', '$') ;
        $content = Replace($content, '\\}', '}') ;

        $content = Replace($content, '\\|&|\\', '=') ;//后加20141024
    }
    $handleInModule = $content ;
    return @$handleInModule;
}
//清除特殊样式后获得标签值
function clearRParam( $action, $LableStr){
    $s ='';
    //Action=Replace(Action,"\'","【|\‘|】")
    $action = Replace($action, '\\\'', '') ;//把这种清掉
    $s = RParam($action, $LableStr) ;
    //s=replace(s,"【|\‘|】", "\'")
    $clearRParam = $s ;
    return @$clearRParam;
}
//获得参数内容后 放到动作里处理一下（20151023）
function atRParam( $action, $LableStr){
    $atRParam = RParam($action, $LableStr) ;
    if( instr(atRParam, '{$') > 0 && instr(atRParam, '$}') > 0 ){
        $atRParam = HandleTemplateAction(atRParam, false) ;//处理动作
    }
    return @$atRParam;
}
//读单个参数值  Title = RParam(Action,"Title")     起强版获取参数值20150723
function rParam( $action, $lableStr){
    $s ='';

    //原始 单引号
    $s = handleRParam($action, $lableStr, '\'') ;
    //原始 双引号
    if( $s == '' ){
        $s = handleRParam($action, $lableStr, '"') ;
    }
    //原始 空
    if( $s == '' ){
        $s = handleRParam($action, $lableStr, '') ;
    }

    //小写 单引号
    if( $s == '' ){
        $s = handleRParam($action, LCase($lableStr), '\'') ;
    }
    //小写 双引号
    if( $s == '' ){
        $s = handleRParam($action, LCase($lableStr), '"') ;
    }
    //小写 空
    if( $s == '' ){
        $s = handleRParam($action, LCase($lableStr), '') ;
    }

    //大写 单引号
    if( $s == '' ){
        $s = handleRParam($action, UCase($lableStr), '\'') ;
    }
    //大写 双引号
    if( $s == '' ){
        $s = handleRParam($action, UCase($lableStr), '"') ;
    }
    //大写 空
    if( $s == '' ){
        $s = handleRParam($action, UCase($lableStr), '') ;
    }
    //不要这个，要不不稳定(20151022)
    //if s=false then s=""
    if( $s == '[#空*值_#]' ){ $s = '' ;}
    $rParam = $s ;
    return @$rParam;
}
//处理 读单个参数值
function handleRParam( $action, $LableStr, $typeStr){
    $LalbeName=''; $endTypeStr=''; $isTrue=''; $s='';
    $isTrue = false ;//是否为真
    $endTypeStr = IIF($typeStr <> '', $typeStr, ' ') ;
    $action = "\n" . ' ' . $action ;//给它也加个空格，要不然在没有函数，前面就没有空格
    //默认前面加空格
    $LalbeName = ' ' . $LableStr ;//加个空格是为了精准
    //不存在  前面加点
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = '\'' . $LableStr ;
    }else{
        $isTrue = true ;
    }
    //不存在 前面加双引号
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = '"' . $LableStr ;
    }else{
        $isTrue = true ;
    }
    //不存在    前面加TAB
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = "\t" . $LableStr ;
    }else{
        $isTrue = true ;
    }
    //不存在    前面加换行
    if( instr($action, $LalbeName . '=' . $typeStr) == false && $isTrue == false ){
        $LalbeName = "\n" . $LableStr ;
    }else{
        $isTrue = true ;
    }
    if( instr($action, $LalbeName . '=' . $typeStr) > 0 && instr($action, $endTypeStr) > 0 ){
        $s = StrCut($action, $LalbeName . '=' . $typeStr, $endTypeStr, 2) ;
        $s = handleInModule($s, 'end') ;//处理里面参数 追加于20141031            还原内容值

        if( $s == '' ){
            $s = '[#空*值_#]' ;
        }

        //判断是否对参数进行动作制作
        if( instr($s, '{$') > 0 && instr($s, '$}') > 0 ){

            //handleRParam=HandleTemplateAction(handleRParam,true)        '处理动作
            //handleRParam = handleModuleReplaceArray(handleRParam)'给AddSqL处理一下动作 这是处理替换，不需要，因为在 HandleTemplateAction有替换了(20151021)

        }
        //不要这个，要不不稳定(20151022)
        //if handleRParam="" then
        //handleRParam=false
        //end if
    }
    $handleRParam=$s;
    return @$handleRParam;
}


//获得配置块 20150105 GetConfigBlock(ConfigContent, BlockName)
function getConfigBlock($ConfigContent, $BlockName){
    $getConfigBlock = GetCutConfigBlock($ConfigContent, $BlockName, '#', '#') ;
    return @$getConfigBlock;
}
//获得配置块 20150105
function getConfigBlock2($ConfigContent, $BlockName){
    $getConfigBlock2 = GetCutConfigBlock($ConfigContent, $BlockName, '[#', '#]') ;
    return @$getConfigBlock2;
}
//获得配置块 20150105
function getConfigBlock3($ConfigContent, $BlockName){
    $getConfigBlock3 = GetCutConfigBlock($ConfigContent, $BlockName, '[$', '$]') ;
    return @$getConfigBlock3;
}
//截取配置内容中块 20150105
function getCutConfigBlock($ConfigContent, $BlockName, $StartLable, $EndLable){
    $StartStr=''; $EndStr ='';
    $StartStr = $StartLable . $BlockName . $EndLable ;
    $EndStr = $StartLable . $BlockName . $EndLable ;
    //开始标签处理
    if( instr($ConfigContent, $StartStr . ' start') > 0 ){
        $StartStr = $StartStr . ' start' ;
    }else{
        $StartStr = $StartStr . ' Start' ;
    }
    //结束标签处理
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
//获得配置内容块20150401
function getConfigContentBlock( $ConfigContent, $BlockName){
    $getConfigContentBlock = getCutConfigBlock($ConfigContent, $BlockName, '', '') ;
    return @$getConfigContentBlock;
}
//获得配置文件里块20150401  GetConfigFileBlock(ConfigPath, "#txtRunCode#")  测试标签块时则自动创建
function getConfigFileBlock( $ConfigFile, $BlockName){
    $content=''; $FindStr=''; $ReplaceStr=''; $StartStr=''; $EndStr ='';
    $content = GetFText($ConfigFile) ;
    //MsgBox ("ConfigFile=" & ConfigFile & "(" & CheckFile(ConfigFile) & "，" & GetFSize(ConfigFile) & ")" & vbCrLf & "Content=" & Content)
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
//设置配置文件里块 20150401 call SetConfigFileBlock(ConfigFile, "aaabbc", "#上传目录列表#")  存在则更新
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

//删除配置块 20150322
function delConfigBlock($Config, $BlockName){
    $delConfigBlock = DelCutConfigBlock($Config, $BlockName, '#', '#') ;
    return @$delConfigBlock;
}
//删除配置块 20150322
function delConfigBlock2($Config, $BlockName){
    $delConfigBlock2 = DelCutConfigBlock($Config, $BlockName, '[#', '#]') ;
    return @$delConfigBlock2;
}
//删除配置块 20150322
function delConfigBlock3($Config, $BlockName){
    $delConfigBlock3 = DelCutConfigBlock($Config, $BlockName, '[$', '$]') ;
    return @$delConfigBlock3;
}
//删除配置内容 20150322
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




//获得文件里设置参数　20150315
function getFileParamValue($ConfigPath, $ParamName){
    $getFileParamValue = HandleGetSetFileParameValue($ConfigPath, $ParamName, '', '获得') ;
    return @$getFileParamValue;
}
//设置文件里设置参数　20150315
function setFileParamValue($ConfigPath, $ParamName, $ValueStr){
    $setFileParamValue = HandleGetSetFileParameValue($ConfigPath, $ParamName, $ValueStr, '设置') ;
    return @$setFileParamValue;
}
//处理获得设置文件参数值　20150315
function handleGetSetFileParameValue($ConfigPath, $ParamName, $ValueStr, $SType){
    $content=''; $StartStr=''; $EndStr=''; $YunStr=''; $ReplaceStr ='';
    //文件为假时，创建一个空文件看看，如果不能创建这个文件则说明这个文件地址有问题，则退出20150324
    if( checkFile($ConfigPath) == false ){
        CreateFile($ConfigPath, '') ;
    }
    if( checkFile($ConfigPath) == false ){ }//文件不存在则退出

    $content = TrimVbCrlf(GetFText($ConfigPath)) ;
    $StartStr = "\n" . $ParamName . '=' ; $EndStr = "\n" ;
    $ReplaceStr = "\n" . $ParamName . '=' . $ValueStr . "\n" ;
    if( instr("\n" . $content, $StartStr) > 0 && instr($content . "\n", $EndStr) > 0 ){
        $YunStr = StrCut("\n" . $content . "\n", $StartStr, $EndStr, 2) ;
        if( $SType == '获得' ){
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

//设置内容里参数 20150611
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

//追加或替换参数值 20150615
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
//删除指定字符N次
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



//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容",""))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加在前"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加在前"))
//call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","外部追加在前"))
//call Rwend(replaceContentModule(getftext("1.html"), "<div>", "</div>", "替换内容", "外部追加"))
//替换内容里模块   ReplaceType(空为替换，追加在前，追加在后(追加)，外部追加在前，外部追加在后(外部追加))
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

            if( $ReplaceType == '追加在前' ){
                $newReplaceValue = $newStartStr . $ReplaceValue . $s . $newEndStr ;
            }else if( $ReplaceType == '追加在后' || $ReplaceType == '追加' ){
                $newReplaceValue = $newStartStr . $s . $ReplaceValue . $newEndStr ;
            }else if( $ReplaceType == '外部追加在前' ){
                $newReplaceValue = $ReplaceValue . $newStartStr . $s . $newEndStr ;

            }else if( $ReplaceType == '外部追加在后' || $ReplaceType == '外部追加' ){
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

//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", "追加在前"))
//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", "追加"))
//call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", ""))
//替换内容里一行模块   ReplaceType(空为替换，追加在前，追加在后(追加))
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
            if( $ReplaceType == '追加在前' ){
                $newReplaceValue = $ReplaceValue . $newSearchValue ;
            }else if( $ReplaceType == '追加在后' || $ReplaceType == '追加' ){
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
//处理配置文档(20150804)
function handleConfigFile($ConfigPath){
    $c ='';
    if( checkFile($ConfigPath) == false ){
        $c = '#Help帮助# start' . "\n" . '默认帮助内容' . "\n" . '#Help帮助# end' ;
        CreateFile($ConfigPath, $c) ;
    }
}

//获得内容里指定类型值   RParam加强版(20161025)
function getRParam( $content, $lableStr){
    $contentLCase=''; $endS=''; $i=''; $s=''; $c=''; $isStart=''; $startStr=''; $isValue ='';
    $content = ' ' . $content . ' ' ;//避免更精准获得值
    $contentLCase = LCase($content) ;
    $lableStr = LCase($lableStr) ;
    $endS = mid($content, instr($contentLCase, $lableStr) + strlen($lableStr),-1) ;
    //call echo("ends",ends)
    $isStart = false ;//是否有开始类型值
    $isValue = false ;//是否有值
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

//获得模板某标签默认内容 代码进行了二次查找 会在HTML模板里二次查找默认值
function getDefaultValue($action){
    $getDefaultValue = ModuleFindContent($action, 'default') ;
    return @$getDefaultValue;
}

//添加模块替换数组
function addModuleReplaceArray($title,$content){
    $i='';
    for( $i=1 ; $i<= ubound($GLOBALS['ModuleReplaceArray'])-1; $i++){
        if( $GLOBALS['ModuleReplaceArray'][$i][0]=='' ){
            $GLOBALS['ModuleReplaceArray'][$i][0]=$title;
            $GLOBALS['ModuleReplaceArray'][0][$i]=$content;

        }
    }
}
//根据标签找到对应内容
function moduleFindContent($action, $ModuleName){
    $defaultStr=''; $StartStr=''; $EndStr ='';
    $defaultStr = rParam($action, $ModuleName) ;//把转小写LCase去掉 （20151008）
    //Call Echo("Action",Action)

    $StartStr = '<!--#' . $defaultStr . ' start#-->' ;
    $EndStr = '<!--#' . $defaultStr . ' end#-->' ;
    //[_18年独家一次性祛斑第一品牌2014年10月21日 10时59分]
    //Call Echo("Default",Default)
    //判断是否存在
    if( instr($GLOBALS['code'], $StartStr) > 0 && instr($GLOBALS['code'], $EndStr) > 0 ){
        $defaultStr = StrCut($GLOBALS['code'], $StartStr, $EndStr, 2) ;
    }else{
        $StartStr = '<!--#' . $defaultStr ;
        $EndStr = '#-->' ;
        if( instr($GLOBALS['code'], $StartStr) > 0 && instr($GLOBALS['code'], $EndStr) > 0 ){
            $defaultStr = StrCut($GLOBALS['code'], $StartStr, $EndStr, 2) ;

            //Call Echo("有","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
        }
    }


    //删除默认值20150712
    $deletedefault ='';
    $deletedefault = rParam($action, 'deletedefault') ;
    if( $deletedefault == 'true' ){
        addModuleReplaceArray('【删除】', $StartStr . $defaultStr . $EndStr) ;
    }
    $moduleFindContent = $defaultStr ;
    return @$moduleFindContent;
}
?>

