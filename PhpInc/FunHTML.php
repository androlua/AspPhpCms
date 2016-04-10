<?PHP
//动态生静态(2013,12,17)

//================ 快速获得网站操作 ==================
//在线修改 修改单文本
//MainStr = DisplayOnlineED2(WEB_ADMINURL &"MainInfo.Asp?act=ShowEdit&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainStr, "<li|<a ")
//在线修改 产品大类
//DidStr = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditBigClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), DidStr, "<li|<a ")
//在线修改 产品小类
//SidStr = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), SidStr, "<li|<a ")
//在线修改 产品子类
//S = DisplayOnlineED2(WEB_ADMINURL &"ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), S, "<li|<a ")
//在线修改  文章
//ProStr = DisplayOnlineED2(WEB_ADMINURL &"Product.Asp?act=ShowEditProduct&Id=" & TempRs("Id") & "&n=" & GetRnd(11), ProStr, "<li|<a ")
//在线修改 导航大类
//NavDidStr = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), NavDidStr, "<li|<a ")
//在线修改 导航小类
//NavSidStr = DisplayOnlineED2(WEB_ADMINURL &"NavManage.Asp?act=EditNavSmall&Id=" & TempRs("Id") & "&n=" & GetRnd(11), NavSidStr, "<li|<a ")

//-------------------------------- 下面为网站后台常用快捷标签代码区 -------------------------------------------

//符加文字颜色
function infoColor($str, $color){
    if( $color <> '' ){ $str= '<font color=' . $color . '>' . $str . '</font>' ;}
    $infoColor= $str;
    return @$infoColor;
}
//图片加载失败显示默认图片
function imgError(){
    $imgError= ' onerror="this.src=\'/UploadFiles/NoImg.jpg\'"';
    return @$imgError;
}
//获得target样式
function targetStr( $sType){
    if( $sType <> '' ){
        $targetStr= ' target=\'' . $sType . '\'';
    }
    return @$targetStr;
}
//打开方式  (辅助)
function aTarget($sType){
    $aTarget= targetStr($sType);
    return @$aTarget;
}
//获得链接Title样式
function aTitle( $title){
    if( $title <> '' ){
        $aTitle= ' Title=\'' . $title . '\'';
    }
    return @$aTitle;
}
//获得链接Title
function imgAlt( $Alt){
    if( $Alt <> '' ){
        $imgAlt= ' alt=\'' . $Alt . '\'';
    }
    return @$imgAlt;
}
//图片标题与Alt
function imgTitleAlt( $str){
    if( $str <> '' ){
        $imgTitleAlt= ' alt=\'' . $str . '\' title=\'' . $str . '\'';
    }
    return @$imgTitleAlt;
}
//获得A Rel值
function aRel( $sType){
    if( $sType== true ){
        $aRel= ' rel=\'nofollow\'';
    }
    return @$aRel;
}
//获得target样式
function styleClass( $ClassName){
    if( $ClassName <> '' ){
        $styleClass= ' class=\'' . $ClassName . '\'';
    }
    return @$styleClass;
}
//文本加粗
function textFontB( $text, $BYes){
    if( $BYes== true ){
        $text= '<strong>' . $text . '</strong>';
    }
    $textFontB= $text;
    return @$textFontB;
}
//文本加颜色
function textFontColor( $text, $color){
    if( $color <> '' ){
        $text= '<font color=\'' . $color . '\'>' . $text . '</font>';
    }
    $textFontColor= $text;
    return @$textFontColor;
}
//处理文本颜色与加粗
function fontColorFontB($title, $FontB, $FontColor){
    $fontColorFontB= textFontColor(textFontB($title, $FontB), $FontColor);
    return @$fontColorFontB;
}
//获得默认文章信息文件名称
function getDefaultFileName(){
    $getDefaultFileName= format_Time(Now(), 6);
    return @$getDefaultFileName;
}
//获得链接  例：'"<a " & AHref(Url, TempRs("BigClassName"), TempRs("Target")) & ">" & TempRs("BigClassName") & "</a>"
function aHref($url, $title, $target){
    $url= handleHttpUrl($url); //处理一下URL 让之完整
    $aHref= 'href=\'' . $url . '\'' . aTitle($title) . aTarget($target);
    return @$aHref;
}
//获得图片路径
function imgSrc($url, $title, $target){
    $url= handleHttpUrl($url); //处理一下URL 让之完整
    $imgSrc= 'src=\'' . $url . '\'' . aTitle($title) . imgAlt($title) . aTarget($target);
    return @$imgSrc;
}

//============== 网站后台使用 ==================

//选择Target打开方式
function selectTarget($target){
    $c=''; $sel ='';
    $c= $c . '<select name="Target" id="Target">' . vbCrlf();
    $c= $c . '  <option value=\'\'>链接打开方式</option>' . vbCrlf();
    if( $target== '' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '  <option' . $sel . ' value=\'\'>本页打开</option>' . vbCrlf();
    if( $target== '_blank' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '  <option value="_blank"' . $sel . '>新页打开</option>' . vbCrlf();
    if( $target== 'Index' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '  <option value="Index"' . $sel . '>Index页打开</option>' . vbCrlf();
    if( $target== 'Main' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '  <option value="Main"' . $sel . '>Main页打开</option>' . vbCrlf();
    $c= $c . '</select>' . vbCrlf();
    $selectTarget= $c;
    return @$selectTarget;
}
//选择文本颜色
function selectFontColor($FontColor){
    $c=''; $sel ='';
    $c= $c . '  <select name="FontColor" id="FontColor">' . vbCrlf();
    $c= $c . '    <option value=\'\'>文本颜色</option>' . vbCrlf();
    if( $FontColor== 'Red' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '    <option value="Red" class="FontColor_Red"' . $sel . '>红色</option>' . vbCrlf();
    if( $FontColor== 'Blue' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '    <option value="Blue" class="FontColor_Blue"' . $sel . '>蓝色</option>' . vbCrlf();
    if( $FontColor== 'Green' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '    <option value="Green" class="FontColor_Green"' . $sel . '>绿色</option>' . vbCrlf();
    if( $FontColor== 'Black' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '    <option value="Black" class="FontColor_Black"' . $sel . '>黑色</option>' . vbCrlf();
    if( $FontColor== 'White' ){ $sel= ' selected' ;}else{ $sel== '' ;}
    $c= $c . '    <option value="White" class="FontColor_White"' . $sel . '>白色</option>' . vbCrlf();
    $c= $c . '  </select>' . vbCrlf();
    $selectFontColor= $c;
    return @$selectFontColor;
}
//选择男女
function selectSex($sex){
    $c=''; $sel ='';
    $c= $c . '  <select name="FontColor" id="FontColor">' . vbCrlf();
    $c= $c . '    <option value="男">男</option>' . vbCrlf();
    $sel= IIF($sex== '女', ' selected', '');
    $c= $c . '    <option value="女"' . $sel . '>女</option>' . vbCrlf();
    $c= $c . '  </select>' . vbCrlf();
    $selectSex= $c;
    return @$selectSex;
}
//选择Session或Cookies验证
function selectSessionCookies($VerificationMode){
    $c=''; $sel ='';
    $c= $c . '  <select name="VerificationMode" id="VerificationMode">' . vbCrlf();
    $c= $c . '    <option value="1">Session验证</option>' . vbCrlf();
    $sel= IIF($VerificationMode== '0', ' selected', '');
    $c= $c . '    <option value="0"' . $sel . '>Cookies验证</option>' . vbCrlf();
    $c= $c . '  </select>' . vbCrlf();
    $selectSessionCookies= $c;
    return @$selectSessionCookies;
}
//显示选择分割内容  showSelectList("aa","aa|bb|cc","|","bb")
function showSelectList($IDName, $content, $SplType, $ThisValue){
    $c=''; $sel=''; $splStr=''; $s ='';
    $IDName= AspTrim($IDName);
    if( $SplType== '' ){ $SplType= '|_-|' ;}
    if( $IDName <> '' ){ $c= $c . '  <select name="' . $IDName . '" id="' . $IDName . '">' . vbCrlf() ;}

    $splStr= aspSplit($content, $SplType);
    foreach( $splStr as $s){
        $sel= '';
        if( $s== $ThisValue ){ $sel= ' selected' ;}
        $c= $c . '    <option value="' . $s . '"' . $sel . '>' . $s . '</option>' . vbCrlf();
    }
    if( $IDName <> '' ){ $c= $c . '  </select>' . vbCrlf() ;}
    $showSelectList= $c;
    return @$showSelectList;
}

//显示文章展示列表样式 20150114   例 Call Rw(ShowArticleListStyle("下载列表二.html"))
function showArticleListStyle( $ThisValue){
    $showArticleListStyle= handleArticleListStyleOrInfoStyle('文章展示样式', 'ArticleListStyle', $ThisValue);
    return @$showArticleListStyle;
}
//显示文章信息展示样式 20150114   例 Call Rw(ShowArticleInfoStyle("下载列表二.html"))
function showArticleInfoStyle( $ThisValue){
    $showArticleInfoStyle= handleArticleListStyleOrInfoStyle('文章信息展示样式', 'ArticleInfoStyle', $ThisValue);
    return @$showArticleInfoStyle;
}
//处理文章展示列表样式和文章信息样式
function handleArticleListStyleOrInfoStyle($folderName, $InputName, $ThisValue){
    $ResourceDir=''; $content=''; $c=''; $splStr=''; $fileName=''; $sel ='';
    //ResourceDir = GetWebSkins() & "\Index\"& FolderName &"\"

    $ResourceDir= getWebImages() . '\\' . $folderName . '\\';

    $content= getFileFolderList($ResourceDir, true, 'html', '名称', '', '', '');

    $ThisValue= strtolower($ThisValue); //转成小写 好对比

    $c= $c . '  <select name="' . $InputName . '" id="' . $InputName . '">' . vbCrlf();
    $c= $c . '    <option value=""></option>' . vbCrlf();
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $fileName){
        if( $fileName <> '' ){
            $sel= IIF(strtolower($fileName)== $ThisValue, ' selected', '');
            $c= $c . '    <option value="' . $fileName . '"' . $sel . '>' . $fileName . '</option>' . vbCrlf();
        }
    }
    $c= $c . '  </select>' . vbCrlf();

    $handleArticleListStyleOrInfoStyle= $c;
    return @$handleArticleListStyleOrInfoStyle;
}

//获得模块皮肤 ShowWebModuleSkins("ModuleSkins", ModuleSkins)
function showWebModuleSkins($InputName, $ThisValue){
    $ResourceDir=''; $content=''; $c=''; $splStr=''; $fileName=''; $sel ='';
    $ResourceDir= getWebSkins() . '\\Index\\column';
    //Call Echo("ResourceDir",ResourceDir)
    $content= getDirFolderNameList($ResourceDir);
    //Call Echo("Content",Content)

    $ThisValue= strtolower($ThisValue); //转成小写 好对比

    $c= $c . '  <select name="' . $InputName . '" id="' . $InputName . '">' . vbCrlf();
    $c= $c . '    <option value=""></option>' . vbCrlf();
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $fileName){
        if( $fileName <> '' ){
            $sel= IIF(strtolower($fileName)== $ThisValue, ' selected', '');
            $c= $c . '    <option value="' . $fileName . '"' . $sel . '>' . $fileName . '</option>' . vbCrlf();
        }
    }
    $c= $c . '  </select>' . vbCrlf();

    $showWebModuleSkins= $c;
    return @$showWebModuleSkins;
}

//显示单选项列表
function showRadioList($IDName, $content, $SplType, $ThisValue){
    $c=''; $sel=''; $splStr=''; $s=''; $i ='';
    $IDName= AspTrim($IDName);
    if( $SplType== '' ){ $SplType= '|_-|' ;}
    $i= 0;
    $splStr= aspSplit($content, $SplType);
    foreach( $splStr as $s){
        $sel= '' ; $i= $i + 1;
        if( $s== $ThisValue ){ $sel= ' checked' ;}
        $c= $c . '<input type="radio" name="' . $IDName . '" id="' . $IDName . $i . '" value="radio" ' . $sel . '><label for="' . $IDName . $i . '">' . $s . '</label>' . vbCrlf();
    }

    $showRadioList= $c;
    return @$showRadioList;
}
//显示Input复选 InputCheckBox("Id",ID,"")
function inputCheckBox($textName, $checked, $helpStr){
    //Dim sel
    //If CStr(valueStr) = "True" Or CStr(checked) = "1" Then sel = " checked" Else sel = ""
    //inputCheckBox = "<input type='checkbox' name='" & textName & "' id='" & textName & "'" & sel & " value='1'>"
    //If helpStr <> "" Then inputCheckBox = "<label for='" & textName & "'>" & inputCheckBox & helpStr & "</label> "
    $inputCheckBox= handleInputCheckBox($textName, $checked, 1, $helpStr, '');
    return @$inputCheckBox;
}
//显示Input复选 InputCheckBox("Id",ID,"")
function inputCheckBox3($textName, $checked, $valueStr, $helpStr){
    $inputCheckBox3= handleInputCheckBox($textName, $checked, $valueStr, $helpStr, 'newidname');
    return @$inputCheckBox3;
}
function handleInputCheckBox($textName, $checked, $valueStr, $helpStr, $sType){
    $s=''; $sel=''; $idName ='';
    if( CStr($valueStr)== 'True' || CStr($checked)== '1' ){ $sel= ' checked' ;}else{ $sel== '' ;}
    $idName= $textName; //id名等于文件名称
    $sType= '|' . $sType . '|';
    if( instr($sType, '|newidname|') > 0 ){
        $idName= $textName . phprand(1, 9999);
    }
    $s= '<input type=\'checkbox\' name=\'' . $textName . '\' id=\'' . $idName . '\'' . $sel . ' value=\'' . $valueStr . '\'>';
    if( $helpStr <> '' ){ $s= '<label for=\'' . $idName . '\'>' . $s . $helpStr . '</label> ' ;}
    $handleInputCheckBox= $s;
    return @$handleInputCheckBox;
}

//显示Input文本  InputText("FolderName", FolderName, "40px", "帮助文字")
function inputText($textName, $valueStr, $width, $helpStr){
    $Css ='';

    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    $inputText= '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . $helpStr;
    return @$inputText;
}
//显示Input文本  InputText("FolderName", FolderName, "40px", "帮助文字")
function inputText2($textName, $valueStr, $width, $className, $helpStr){
    $Css ='';
    if( $className <> '' ){


        $className= ' class="' . $className . '"';
    }
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    $inputText2= '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . $className . ' />' . $helpStr;
    return @$inputText2;
}
//显示Input文本在左边  InputLeftText(TextName, ValueStr, "98%", "")
function inputLeftText($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    $inputLeftText= $helpStr . '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . vbCrlf();
    return @$inputLeftText;
}
//显示Input文本在左边 帮助文字在右边
function inputLeftTextHelpTextRight($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    $inputLeftTextHelpTextRight= '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . $helpStr;
    return @$inputLeftTextHelpTextRight;
}
//显示Input文本在中边 提示文本在左边
function inputLeftTextContent($textName, $valueStr, $width, $helpStr){
    $inputLeftTextContent= handleInputLeftRightTextContent('左边', $textName, $valueStr, $width, $helpStr);
    return @$inputLeftTextContent;
}
//显示Input文本在中边 提示文本在右边
function inputRightTextContent($textName, $valueStr, $width, $helpStr){
    $inputRightTextContent= handleInputLeftRightTextContent('右边', $textName, $valueStr, $width, $helpStr);
    return @$inputRightTextContent;
}
//显示Input文本在中边 提示文本在左边 或 提示文本在右边 20150114
function handleInputLeftRightTextContent($sType, $textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    if( $Css== '' ){
        $Css= ' style=\'text-align:center;\'';
    }else{
        $Css= Replace($Css, ';\'', ';text-align:center;\'');
    }
    $handleInputLeftRightTextContent= '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />';

    if( $sType== '左边' ){
        $handleInputLeftRightTextContent= $helpStr . $handleInputLeftRightTextContent . vbCrlf();
    }else{
        $handleInputLeftRightTextContent= $handleInputLeftRightTextContent . $helpStr;
    }

    return @$handleInputLeftRightTextContent;
}

//显示Input文本在左边密码
function inputLeftPassText($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    $inputLeftPassText= $helpStr . '<input name="' . $textName . '" type="password" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . vbCrlf();
    return @$inputLeftPassText;
}
//显示Input文本在左边密码类型
function inputLeftPassTextContent($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    if( $Css== '' ){
        $Css= ' style=\'text-align:center;\'';
    }else{
        $Css= Replace($Css, ';\'', ';text-align:center;\'');
    }
    $inputLeftPassTextContent= $helpStr . '<input name="' . $textName . '" type="password" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . vbCrlf();
    return @$inputLeftPassTextContent;
}
//显示Input隐藏文本
function inputHiddenText($textName, $valueStr){
    $inputHiddenText= '<input name="' . $textName . '" type="hidden" id="' . $textName . '" value="' . $valueStr . '" />' . vbCrlf();
    return @$inputHiddenText;
}
//显示Input文本域 InputTextArea("FindTpl", FindTpl, "60%" , "120px", "")
function inputTextArea($textName, $valueStr, $width, $height, $helpStr){
    $Css=''; $HeightStr ='';
    $width= AspTrim(strtolower($width));
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width= $width . 'px';
        }
        $Css= ' style=\'width:' . $width . ';\'';
    }
    if( $height <> '' ){
        if( checkNumber($height) ){ //自动加个px像素
            $height= $height . 'px';
        }
        $HeightStr= 'height:' . $height . ';';
        if( $Css <> '' ){
            $Css= Replace($Css, ';\'', ';' . $HeightStr . ';\'');
        }else{
            $Css= ' style=\'height:' . $height . ';\'';
        }
    }
    $Css= Replace($Css, ';;', ';'); //去掉多余的值
    $inputTextArea= '<textarea name="' . $textName . '" type="text" id="' . $textName . '"' . $Css . '>' . $valueStr . '</textarea>' . $helpStr;
    return @$inputTextArea;
}
//显示隐藏Input文本域 InputTextArea("WebDescription", WebDescription, "99%", "100px", "")
function inputHiddenTextArea($textName, $valueStr, $width, $height, $helpStr){
    $inputHiddenTextArea= handleInputHiddenTextArea($textName, $valueStr, $width, $height, '', $helpStr);
    return @$inputHiddenTextArea;
}
//显示隐藏Input文本域 InputTextArea("WebDescription", WebDescription, "99%", "100px", "")
function handleInputHiddenTextArea($textName, $valueStr, $width, $height, $className, $helpStr){
    $Css=''; $HeightStr ='';
    if( $className <> '' ){
        $className= ' class="' . $className . '"';
    }
    if( $width <> '' ){ $Css= ' style=\'width:' . $width . ';\'' ;}
    if( $height <> '' ){
        $HeightStr= 'height:' . $height . ';';
        if( $Css <> '' ){
            $Css= Replace($Css, ';\'', ';' . $HeightStr . ';\'');
        }else{
            $Css= ' style=\'height:' . $height . ';display:none;\'';
        }
    }
    $handleInputHiddenTextArea= '<textarea name="' . $textName . '" type="text" id="' . $textName . '"' . $Css . $className . '>' . $valueStr . '</textarea>' . $helpStr;
    return @$handleInputHiddenTextArea;
}
//显示目录列表 以Select方式显示
function showSelectDirList($folderPath, $valueStr){
    $splStr=''; $c=''; $fileName=''; $sel ='';
    $splStr= aspSplit(getDirFileSort($folderPath), vbCrlf());
    foreach( $splStr as $fileName){
        if( $fileName <> '' ){
            $sel= IIF($valueStr== $fileName, ' selected', '');
            $c= $c . '<option value="' . $folderPath . $fileName . '" ' . $sel . '>' . $fileName . '</option>' . vbCrlf();
        }
    }
    $showSelectDirList= $c;
    return @$showSelectDirList;
}
//给Input加个Disabled不可操作
function inputDisabled( $content){
    $inputDisabled= Replace($content, '<input ', '<input disabled="disabled" ');
    return @$inputDisabled;
}

//给Input加个rel关系内容
function inputAddAlt( $content, $AltStr){
    $SearchStr=''; $replaceStr ='';
    $SearchStr= '<input ';
    $replaceStr= $SearchStr . 'alt="' . $AltStr . '" ';
    if( instr($content, $SearchStr) > 0 ){
        $content= Replace($content, $SearchStr, $replaceStr);
    }else{
        $SearchStr= '<textarea ';
        $replaceStr= $SearchStr . 'alt="' . $AltStr . '" ';
        if( instr($content, $SearchStr) > 0 ){
            $content= Replace($content, $SearchStr, $replaceStr);
        }
    }
    $inputAddAlt= $content;
    return @$inputAddAlt;
}



//快速调用设置====================================================

//网站描述
function webTitle_InputTextArea($WebTitle){
    $webTitle_InputTextArea= inputText('WebTitle', $WebTitle, '70%', '  多个关键词用-隔开'); //不填为网站默认标题
    return @$webTitle_InputTextArea;
}
//网站关键词
function webKeywords_InputText($WebKeywords){
    $webKeywords_InputText= inputText('WebKeywords', $WebKeywords, '70%', ' 请以，隔开(中文逗号)');
    return @$webKeywords_InputText;
}
//网站描述
function webDescription_InputTextArea($WebDescription){
    $webDescription_InputTextArea= inputTextArea('WebDescription', $WebDescription, '99%', '100px', '');
    return @$webDescription_InputTextArea;
}
//静态文件夹名
function folderName_InputText($folderName){
    $folderName_InputText= inputText('FolderName', $folderName, '40%', '');
    return @$folderName_InputText;
}
//静态文件名
function fileName_InputText($fileName){
    $fileName_InputText= inputText('FileName', $fileName, '40%', '.html 也可以是网络上的链接地址');
    return @$fileName_InputText;
}
//模板文件名

function templatePath_InputText($TemplatePath){
    $templatePath_InputText= inputText('TemplatePath', $TemplatePath, '40%', ' 不填为默认');
    return @$templatePath_InputText;
}
//获得拼音按钮内容
function clickPinYinHTMLStr($did){
    $clickPinYinHTMLStr= '<a href="javascript:GetPinYin(\'FolderName\',\'' . $did . '\',\'AjAx.Asp?act=GetPinYin\')" >获得拼音</a>';
    return @$clickPinYinHTMLStr;
}
//选择文本颜色与文本加粗
function showFontColorFontB($FontColor, $FontB){
    $showFontColorFontB= selectFontColor($FontColor) . inputCheckBox('FontB', $FontB, '加粗');
    return @$showFontColorFontB;
}
//显示文本TEXT排序
function showSort($sort){
    $showSort= inputText('Sort', $sort, '30px', '');
    $showSort= Replace(showSort, ';\'', ';text-align:center;\'');
    return @$showSort;
}
//网站导航类型顶部底部等
function showWebNavType($NavTop, $NavButtom, $NavLeft, $NavContent, $NavRight, $NavOthre){
    $c ='';
    $c= $c . inputCheckBox('NavTop', $NavTop, '顶部导航');
    $c= $c . inputCheckBox('NavButtom', $NavButtom, '底部导航');
    $c= $c . inputCheckBox('NavLeft', $NavLeft, '左边导航');
    $c= $c . inputCheckBox('NavContent', $NavContent, '中间导航');
    $c= $c . inputCheckBox('NavRight', $NavRight, '右边导航');
    $c= $c . inputCheckBox('NavOthre', $NavOthre, '其它导航');
    $showWebNavType= $c;
    return @$showWebNavType;
}
function showOnHtml($OnHtml){
    $showOnHtml= inputCheckBox('OnHtml', $OnHtml, '生成HTML');
    return @$showOnHtml;
}
function showThrough($Through){
    $showThrough= inputCheckBox('Through', $Through, '审核');
    return @$showThrough;
}
function showRecommend($Recommend){
    $showRecommend= inputCheckBox('Recommend', $Recommend, '推荐');
    return @$showRecommend;
}
//显示开户与关闭图片
function showOnOffImg($id, $Table, $fieldName, $Recommend, $url){
    $temp=''; $Img=''; $aUrl ='';
    if( rq('page') <> '' ){ $temp= '&page=' . rq('page') ;}else{ $temp== '' ;}
    if( $Recommend== true ){
        $Img= '<img src="' . $GLOBALS['adminDir'] . 'Images/yes.gif">';
    }else{
        $Img= '<img src="' . $GLOBALS['adminDir'] . 'Images/webno.gif">';
    }
    //Call Echo(GetUrl(),""& adminDir &"HandleDatabase.Asp?act=SetTrueFalse&Table=" & Table & "&FieldName=" & FieldName & "&Url=" & Url & "&Id=" & Id)
    $aUrl= getUrlAddToParam(getUrl(), '' . $GLOBALS['adminDir'] . 'HandleDatabase.Asp?act=SetTrueFalse&Table=' . $Table . '&FieldName=' . $fieldName . '&Url=' . $url . '&Id=' . $id, 'replace');
    $showOnOffImg= '<a href="' . $aUrl . '">' . $Img . '</a>';
    //旧版
    //ShowOnOffImg = "<a href="& adminDir &"HandleDatabase.Asp?act=SetTrueFalse&Table=" & Table & "&FieldName=" & FieldName & "&Url=" & Url & "&Id=" & Id & Temp & ">" & Img & "</a>"
    return @$showOnOffImg;
}
//显示开户与关闭图片
function newShowOnOffImg($id, $Table, $fieldName, $Recommend, $url){
    $temp=''; $Img ='';
    if( rq('page') <> '' ){ $temp= '&page=' . rq('page') ;}else{ $temp== '' ;}
    if( $Recommend== 1 ){
        $Img= '<img src="/Images/yes.gif">';
    }else{
        $Img= '<img src="/Images/webno.gif">';
    }
    $newShowOnOffImg= '<a href=/WebAdmin/ZAction.Asp?act=Through&Table=' . $Table . '&FieldName=' . $fieldName . '&Url=' . $url . '&Id=' . $id . $temp . '>' . $Img . '</a>';
    return @$newShowOnOffImg;
}


//获得控制Css样式 20150128  暂时不用
function controlDialogCss(){
    $c ='';
    $c= '<style>' . vbCrlf();
    $c= $c . '/*控制Css20150128*/' . vbCrlf();
    $c= $c . '.controlDialog{' . vbCrlf();
    $c= $c . '    position:relative;' . vbCrlf();
    $c= $c . '    height:50px;' . vbCrlf();
    $c= $c . '    width:auto;' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '.controlDialog .menu{' . vbCrlf();
    $c= $c . '    position:absolute;' . vbCrlf();
    $c= $c . '    right:0px;' . vbCrlf();
    $c= $c . '    top:0px;' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '.controlDialog .menu a{' . vbCrlf();
    $c= $c . '    color:#FF0000;' . vbCrlf();
    $c= $c . '    font-size:14px;' . vbCrlf();
    $c= $c . '    text-decoration:none;' . vbCrlf();
    $c= $c . '    background-color:#FFFFFF;' . vbCrlf();
    $c= $c . '    border:1px solid #003300;' . vbCrlf();
    $c= $c . '    padding:4px;' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '.controlDialog .menu a:hover{' . vbCrlf();
    $c= $c . '    color:#C60000;' . vbCrlf();
    $c= $c . '    text-decoration:underline;' . vbCrlf();
    $c= $c . '}' . vbCrlf();
    $c= $c . '</style>' . vbCrlf();
    $controlDialogCss= $c;
    return @$controlDialogCss;
}


//删除里暂存代码
function batchDeleteTempStr($content, $startStr, $endStr){
    $i=''; $s ='';
    for( $i= 1 ; $i<= 9; $i++){
        if( instr($content, $startStr)== false ){
            break;
        }
        $s= getStrCut($content, $startStr, $endStr, 1);
        $content= Replace($content, $s, '');
    }
    $batchDeleteTempStr= $content;
    return @$batchDeleteTempStr;
}
?>