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
//��̬����̬(2013,12,17)

//================ ���ٻ����վ���� ==================
//�����޸� �޸ĵ��ı�
//MainStr = DisplayOnlineED2("/admin/MainInfo.Asp?act=ShowEdit&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainStr, "<li|<a ")
//�����޸� ��Ʒ����
//DidStr = DisplayOnlineED2("/admin/ProductClassManage.Asp?act=ShowEditBigClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), DidStr, "<li|<a ")
//�����޸� ��ƷС��
//SidStr = DisplayOnlineED2("/admin/ProductClassManage.Asp?act=ShowEditSmallClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), SidStr, "<li|<a ")
//�����޸� ��Ʒ����
//S = DisplayOnlineED2("/admin/ProductClassManage.Asp?act=ShowEditThreeClass&Id=" & TempRs("Id") & "&n=" & GetRnd(11), S, "<li|<a ")
//�����޸�  ����
//ProStr = DisplayOnlineED2("/admin/Product.Asp?act=ShowEditProduct&Id=" & TempRs("Id") & "&n=" & GetRnd(11), ProStr, "<li|<a ")
//�����޸� ��������
//NavDidStr = DisplayOnlineED2("/admin/NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), NavDidStr, "<li|<a ")
//�����޸� ����С��
//NavSidStr = DisplayOnlineED2("/admin/NavManage.Asp?act=EditNavSmall&Id=" & TempRs("Id") & "&n=" & GetRnd(11), NavSidStr, "<li|<a ")

//-------------------------------- ����Ϊ��վ��̨���ÿ�ݱ�ǩ������ -------------------------------------------

//����������ɫ
function infoColor($str, $color){
    if( $color <> '' ){ $str = '<font color=' . $color . '>' . $str . '</font>' ;}
    $infoColor = $str ;
    return @$infoColor;
}
//ͼƬ����ʧ����ʾĬ��ͼƬ
function imgError(){
    $imgError = ' onerror="this.src=\'/UploadFiles/NoImg.jpg\'"' ;
    return @$imgError;
}
//���target��ʽ
function targetStr( $SType){
    if( $SType <> '' ){
        $targetStr = ' target=\'' . $SType . '\'' ;
    }
    return @$targetStr;
}
//�򿪷�ʽ  (����)
function aTarget($SType){
    $aTarget = targetStr($SType) ;
    return @$aTarget;
}
//�������Title��ʽ
function aTitle( $title){
    if( $title <> '' ){
        $aTitle = ' Title=\'' . $title . '\'' ;
    }
    return @$aTitle;
}
//�������Title
function imgAlt( $Alt){
    if( $Alt <> '' ){
        $imgAlt = ' alt=\'' . $Alt . '\'' ;
    }
    return @$imgAlt;
}
//ͼƬ������Alt
function imgTitleAlt( $str){
    if( $str <> '' ){
        $imgTitleAlt = ' alt=\'' . $str . '\' title=\'' . $str . '\'' ;
    }
    return @$imgTitleAlt;
}
//���A Relֵ
function aRel( $SType){
    if( $SType == true ){
        $aRel = ' rel=\'nofollow\'' ;
    }
    return @$aRel;
}
//���target��ʽ
function styleClass( $ClassName){
    if( $ClassName <> '' ){
        $styleClass = ' class=\'' . $ClassName . '\'' ;
    }
    return @$styleClass;
}
//�ı��Ӵ�
function textFontB( $text, $BYes){
    if( $BYes == true ){
        $text = '<strong>' . $text . '</strong>' ;
    }
    $textFontB = $text ;
    return @$textFontB;
}
//�ı�����ɫ
function textFontColor( $text, $color){
    if( $color <> '' ){
        $text = '<font color=\'' . $color . '\'>' . $text . '</font>' ;
    }
    $textFontColor = $text ;
    return @$textFontColor;
}
//�����ı���ɫ��Ӵ�
function fontColorFontB($title, $FontB, $FontColor){
    $fontColorFontB = textFontColor(textFontB($title, $FontB), $FontColor) ;
    return @$fontColorFontB;
}
//���Ĭ��������Ϣ�ļ�����
function getDefaultFileName(){
    $getDefaultFileName = Format_Time(Now(), 6) ;
    return @$getDefaultFileName;
}
//�������  ����'"<a " & AHref(Url, TempRs("BigClassName"), TempRs("Target")) & ">" & TempRs("BigClassName") & "</a>"
function aHref($url, $title, $Target){
    $url = HandleHttpUrl($url) ;//����һ��URL ��֮����
    $aHref = 'href=\'' . $url . '\'' . aTitle($title) . aTarget($Target) ;
    return @$aHref;
}
//���ͼƬ·��
function imgSrc($url, $title, $Target){
    $url = HandleHttpUrl($url) ;//����һ��URL ��֮����
    $imgSrc = 'src=\'' . $url . '\'' . aTitle($title) . imgAlt($title) . aTarget($Target) ;
    return @$imgSrc;
}

//============== ��վ��̨ʹ�� ==================

//ѡ��Target�򿪷�ʽ
function selectTarget($Target){
    $c=''; $sel ='';
    $c = $c . '<select name="Target" id="Target">' . "\n" ;
    $c = $c . '  <option value=\'\'>���Ӵ򿪷�ʽ</option>' . "\n" ;
    if( $Target == '' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '  <option' . $sel . ' value=\'\'>��ҳ��</option>' . "\n" ;
    if( $Target == '_blank' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '  <option value="_blank"' . $sel . '>��ҳ��</option>' . "\n" ;
    if( $Target == 'Index' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '  <option value="Index"' . $sel . '>Indexҳ��</option>' . "\n" ;
    if( $Target == 'Main' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '  <option value="Main"' . $sel . '>Mainҳ��</option>' . "\n" ;
    $c = $c . '</select>' . "\n" ;
    $selectTarget = $c ;
    return @$selectTarget;
}
//ѡ���ı���ɫ
function selectFontColor($FontColor){
    $c=''; $sel ='';
    $c = $c . '  <select name="FontColor" id="FontColor">' . "\n" ;
    $c = $c . '    <option value=\'\'>�ı���ɫ</option>' . "\n" ;
    if( $FontColor == 'Red' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '    <option value="Red" class="FontColor_Red"' . $sel . '>��ɫ</option>' . "\n" ;
    if( $FontColor == 'Blue' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '    <option value="Blue" class="FontColor_Blue"' . $sel . '>��ɫ</option>' . "\n" ;
    if( $FontColor == 'Green' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '    <option value="Green" class="FontColor_Green"' . $sel . '>��ɫ</option>' . "\n" ;
    if( $FontColor == 'Black' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '    <option value="Black" class="FontColor_Black"' . $sel . '>��ɫ</option>' . "\n" ;
    if( $FontColor == 'White' ){ $sel = ' selected' ;}else{ $sel == '' ;}
    $c = $c . '    <option value="White" class="FontColor_White"' . $sel . '>��ɫ</option>' . "\n" ;
    $c = $c . '  </select>' . "\n" ;
    $selectFontColor = $c ;
    return @$selectFontColor;
}
//ѡ����Ů
function selectSex($sex){
    $c=''; $sel ='';
    $c = $c . '  <select name="FontColor" id="FontColor">' . "\n" ;
    $c = $c . '    <option value="��">��</option>' . "\n" ;
    $sel = IIF($sex == 'Ů', ' selected', '') ;
    $c = $c . '    <option value="Ů"' . $sel . '>Ů</option>' . "\n" ;
    $c = $c . '  </select>' . "\n" ;
    $selectSex = $c ;
    return @$selectSex;
}
//ѡ��Session��Cookies��֤
function selectSessionCookies($VerificationMode){
    $c=''; $sel ='';
    $c = $c . '  <select name="VerificationMode" id="VerificationMode">' . "\n" ;
    $c = $c . '    <option value="1">Session��֤</option>' . "\n" ;
    $sel = IIF($VerificationMode == '0', ' selected', '') ;
    $c = $c . '    <option value="0"' . $sel . '>Cookies��֤</option>' . "\n" ;
    $c = $c . '  </select>' . "\n" ;
    $selectSessionCookies = $c ;
    return @$selectSessionCookies;
}
//��ʾѡ��ָ�����  showSelectList("aa","aa|bb|cc","|","bb")
function showSelectList($IDName, $content, $SplType, $ThisValue){
    $c=''; $sel=''; $splStr=''; $s ='';
    $IDName = AspTrim($IDName) ;
    if( $SplType == '' ){ $SplType = '|_-|' ;}
    if( $IDName <> '' ){ $c = $c . '  <select name="' . $IDName . '" id="' . $IDName . '">' . "\n" ;}

    $splStr = aspSplit($content, $SplType) ;
    foreach( $splStr as $s){
        $sel = '' ;
        if( $s == $ThisValue ){ $sel = ' selected' ;}
        $c = $c . '    <option value="' . $s . '"' . $sel . '>' . $s . '</option>' . "\n" ;
    }
    if( $IDName <> '' ){ $c = $c . '  </select>' . "\n" ;}
    $showSelectList = $c ;
    return @$showSelectList;
}

//��ʾ����չʾ�б���ʽ 20150114   �� Call Rw(ShowArticleListStyle("�����б��.html"))
function showArticleListStyle( $ThisValue){
    $showArticleListStyle = HandleArticleListStyleOrInfoStyle('����չʾ��ʽ', 'ArticleListStyle', $ThisValue) ;
    return @$showArticleListStyle;
}
//��ʾ������Ϣչʾ��ʽ 20150114   �� Call Rw(ShowArticleInfoStyle("�����б��.html"))
function showArticleInfoStyle( $ThisValue){
    $showArticleInfoStyle = HandleArticleListStyleOrInfoStyle('������Ϣչʾ��ʽ', 'ArticleInfoStyle', $ThisValue) ;
    return @$showArticleInfoStyle;
}
//��������չʾ�б���ʽ��������Ϣ��ʽ
function handleArticleListStyleOrInfoStyle($folderName, $InputName, $ThisValue){
    $ResourceDir=''; $content=''; $c=''; $splStr=''; $fileName=''; $sel ='';
    //ResourceDir = GetWebSkins() & "\Index\"& FolderName &"\"

    $ResourceDir = getWebImages() . '\\' . $folderName . '\\' ;

    $content = GetFileFolderList($ResourceDir, true, 'html', '����', '', '', '') ;

    $ThisValue = LCase($ThisValue) ;//ת��Сд �öԱ�

    $c = $c . '  <select name="' . $InputName . '" id="' . $InputName . '">' . "\n" ;
    $c = $c . '    <option value=""></option>' . "\n" ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $fileName){
        if( $fileName <> '' ){
            $sel = IIF(LCase($fileName) == $ThisValue, ' selected', '') ;
            $c = $c . '    <option value="' . $fileName . '"' . $sel . '>' . $fileName . '</option>' . "\n" ;
        }
    }
    $c = $c . '  </select>' . "\n" ;

    $handleArticleListStyleOrInfoStyle = $c ;
    return @$handleArticleListStyleOrInfoStyle;
}

//���ģ��Ƥ�� ShowWebModuleSkins("ModuleSkins", ModuleSkins)
function showWebModuleSkins($InputName, $ThisValue){
    $ResourceDir=''; $content=''; $c=''; $splStr=''; $fileName=''; $sel ='';
    $ResourceDir = getWebSkins() . '\\Index\\column' ;
    //Call Echo("ResourceDir",ResourceDir)
    $content = GetDirFolderNameList($ResourceDir) ;
    //Call Echo("Content",Content)

    $ThisValue = LCase($ThisValue) ;//ת��Сд �öԱ�

    $c = $c . '  <select name="' . $InputName . '" id="' . $InputName . '">' . "\n" ;
    $c = $c . '    <option value=""></option>' . "\n" ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $fileName){
        if( $fileName <> '' ){
            $sel = IIF(LCase($fileName) == $ThisValue, ' selected', '') ;
            $c = $c . '    <option value="' . $fileName . '"' . $sel . '>' . $fileName . '</option>' . "\n" ;
        }
    }
    $c = $c . '  </select>' . "\n" ;

    $showWebModuleSkins = $c ;
    return @$showWebModuleSkins;
}

//��ʾ��ѡ���б�
function showRadioList($IDName, $content, $SplType, $ThisValue){
    $c=''; $sel=''; $splStr=''; $s=''; $i ='';
    $IDName = AspTrim($IDName) ;
    if( $SplType == '' ){ $SplType = '|_-|' ;}
    $i = 0 ;
    $splStr = aspSplit($content, $SplType) ;
    foreach( $splStr as $s){
        $sel = '' ; $i = $i + 1 ;
        if( $s == $ThisValue ){ $sel = ' checked' ;}
        $c = $c . '<input type="radio" name="' . $IDName . '" id="' . $IDName . $i . '" value="radio" ' . $sel . '><label for="' . $IDName . $i . '">' . $s . '</label>' . "\n" ;
    }

    $showRadioList = $c ;
    return @$showRadioList;
}
//��ʾInput��ѡ InputCheckBox("Id",ID,"")
function inputCheckBox($textName, $checked, $helpStr){
    //Dim sel
    //If CStr(valueStr) = "True" Or CStr(checked) = "1" Then sel = " checked" Else sel = ""
    //inputCheckBox = "<input type='checkbox' name='" & textName & "' id='" & textName & "'" & sel & " value='1'>"
    //If helpStr <> "" Then inputCheckBox = "<label for='" & textName & "'>" & inputCheckBox & helpStr & "</label> "
    $inputCheckBox=handleInputCheckBox($textName, $checked, 1, $helpStr,'') ;
    return @$inputCheckBox;
}
//��ʾInput��ѡ InputCheckBox("Id",ID,"")
function inputCheckBox3($textName, $checked, $valueStr, $helpStr){
    $inputCheckBox3=handleInputCheckBox($textName, $checked, $valueStr, $helpStr,'newidname') ;
    return @$inputCheckBox3;
}
function handleInputCheckBox($textName, $checked, $valueStr, $helpStr,$sType){
    $s='';$sel='';$idName='';
    if( CStr($valueStr) == 'True' || CStr($checked) == '1' ){ $sel = ' checked' ;}else{ $sel == '' ;}
    $idName=$textName			;//id�������ļ�����
    $sType='|'. $sType .'|';
    if( instr($sType,'|newidname|')>0 ){
        $idName = $textName . phprand(1, 9999);
    }
    $s='<input type=\'checkbox\' name=\'' . $textName . '\' id=\'' . $idName . '\'' . $sel . ' value=\'' . $valueStr . '\'>' ;
    if( $helpStr <> '' ){ $s = '<label for=\'' . $idName . '\'>' . $s . $helpStr . '</label> ' ;}
    $handleInputCheckBox=$s;
    return @$handleInputCheckBox;
}

//��ʾInput�ı�  InputText("FolderName", FolderName, "40px", "��������")
function inputText($textName, $valueStr, $width, $helpStr){
    $Css ='';

    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    $inputText = '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . $helpStr;
    return @$inputText;
}
//��ʾInput�ı�  InputText("FolderName", FolderName, "40px", "��������")
function inputText2($textName, $valueStr, $width, $className, $helpStr){
    $Css ='';
    if( $className <> '' ){


        $className = ' class="' . $className . '"' ;
    }
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    $inputText2 = '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . $className . ' />' . $helpStr;
    return @$inputText2;
}
//��ʾInput�ı������  InputLeftText(TextName, ValueStr, "98%", "")
function inputLeftText($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    $inputLeftText = $helpStr . '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . "\n" ;
    return @$inputLeftText;
}
//��ʾInput�ı������ �����������ұ�
function inputLeftTextHelpTextRight($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    $inputLeftTextHelpTextRight = '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . $helpStr;
    return @$inputLeftTextHelpTextRight;
}
//��ʾInput�ı����б� ��ʾ�ı������
function inputLeftTextContent($textName, $valueStr, $width, $helpStr){
    $inputLeftTextContent = HandleInputLeftRightTextContent('���', $textName, $valueStr, $width, $helpStr) ;
    return @$inputLeftTextContent;
}
//��ʾInput�ı����б� ��ʾ�ı����ұ�
function inputRightTextContent($textName, $valueStr, $width, $helpStr){
    $inputRightTextContent = HandleInputLeftRightTextContent('�ұ�', $textName, $valueStr, $width, $helpStr) ;
    return @$inputRightTextContent;
}
//��ʾInput�ı����б� ��ʾ�ı������ �� ��ʾ�ı����ұ� 20150114
function handleInputLeftRightTextContent($SType, $textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    if( $Css == '' ){
        $Css = ' style=\'text-align:center;\'' ;
    }else{
        $Css = Replace($Css, ';\'', ';text-align:center;\'') ;
    }
    $handleInputLeftRightTextContent = '<input name="' . $textName . '" type="text" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' ;

    if( $SType == '���' ){
        $handleInputLeftRightTextContent = $helpStr . handleInputLeftRightTextContent . "\n" ;
    }else{
        $handleInputLeftRightTextContent = handleInputLeftRightTextContent . $helpStr;
    }

    return @$handleInputLeftRightTextContent;
}

//��ʾInput�ı����������
function inputLeftPassText($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    $inputLeftPassText = $helpStr . '<input name="' . $textName . '" type="password" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . "\n" ;
    return @$inputLeftPassText;
}
//��ʾInput�ı��������������
function inputLeftPassTextContent($textName, $valueStr, $width, $helpStr){
    $Css ='';
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    if( $Css == '' ){
        $Css = ' style=\'text-align:center;\'' ;
    }else{
        $Css = Replace($Css, ';\'', ';text-align:center;\'') ;
    }
    $inputLeftPassTextContent = $helpStr . '<input name="' . $textName . '" type="password" id="' . $textName . '" value="' . $valueStr . '"' . $Css . ' />' . "\n" ;
    return @$inputLeftPassTextContent;
}
//��ʾInput�����ı�
function inputHiddenText($textName, $valueStr){
    $inputHiddenText = '<input name="' . $textName . '" type="hidden" id="' . $textName . '" value="' . $valueStr . '" />' . "\n" ;
    return @$inputHiddenText;
}
//��ʾInput�ı��� InputTextArea("FindTpl", FindTpl, "60%" , "120px", "")
function inputTextArea($textName, $valueStr, $width, $height, $helpStr){
    $Css=''; $HeightStr ='';
    $width = AspTrim(LCase($width)) ;
    if( $width <> '' ){
        if( substr($width, - 1) <> '%' && substr($width, - 2) <> 'px' ){
            $width = $width . 'px' ;
        }
        $Css = ' style=\'width:' . $width . ';\'' ;
    }
    if( $height <> '' ){
        if( CheckNumber($height) ){ //�Զ��Ӹ�px����
            $height = $height . 'px' ;
        }
        $HeightStr = 'height:' . $height . ';' ;
        if( $Css <> '' ){
            $Css = Replace($Css, ';\'', ';' . $HeightStr . ';\'') ;
        }else{
            $Css = ' style=\'height:' . $height . ';\'' ;
        }
    }
    $Css = Replace($Css, ';;', ';') ;//ȥ�������ֵ
    $inputTextArea = '<textarea name="' . $textName . '" type="text" id="' . $textName . '"' . $Css . '>' . $valueStr . '</textarea>' . $helpStr;
    return @$inputTextArea;
}
//��ʾ����Input�ı��� InputTextArea("WebDescription", WebDescription, "99%", "100px", "")
function inputHiddenTextArea($textName, $valueStr, $width, $height, $helpStr){
    $inputHiddenTextArea = handleInputHiddenTextArea($textName, $valueStr, $width, $height, '', $helpStr) ;
    return @$inputHiddenTextArea;
}
//��ʾ����Input�ı��� InputTextArea("WebDescription", WebDescription, "99%", "100px", "")
function handleInputHiddenTextArea($textName, $valueStr, $width, $height, $className, $helpStr){
    $Css=''; $HeightStr ='';
    if( $className <> '' ){
        $className = ' class="' . $className . '"' ;
    }
    if( $width <> '' ){ $Css = ' style=\'width:' . $width . ';\'' ;}
    if( $height <> '' ){
        $HeightStr = 'height:' . $height . ';' ;
        if( $Css <> '' ){
            $Css = Replace($Css, ';\'', ';' . $HeightStr . ';\'') ;
        }else{
            $Css = ' style=\'height:' . $height . ';display:none;\'' ;
        }
    }
    $handleInputHiddenTextArea = '<textarea name="' . $textName . '" type="text" id="' . $textName . '"' . $Css . $className . '>' . $valueStr . '</textarea>' . $helpStr;
    return @$handleInputHiddenTextArea;
}
//��ʾĿ¼�б� ��Select��ʽ��ʾ
function showSelectDirList($folderPath, $valueStr){
    $splStr=''; $c=''; $fileName=''; $sel ='';
    $splStr = aspSplit(GetDirFileSort($folderPath), "\n") ;
    foreach( $splStr as $fileName){
        if( $fileName <> '' ){
            $sel = IIF($valueStr == $fileName, ' selected', '') ;
            $c = $c . '<option value="' . $folderPath . $fileName . '" ' . $sel . '>' . $fileName . '</option>' . "\n" ;
        }
    }
    $showSelectDirList = $c ;
    return @$showSelectDirList;
}
//��Input�Ӹ�Disabled���ɲ���
function inputDisabled( $content){
    $inputDisabled = Replace($content, '<input ', '<input disabled="disabled" ') ;
    return @$inputDisabled;
}

//��Input�Ӹ�rel��ϵ����
function inputAddAlt( $content, $AltStr){
    $SearchStr=''; $ReplaceStr ='';
    $SearchStr = '<input ' ;
    $ReplaceStr = $SearchStr . 'alt="' . $AltStr . '" ' ;
    if( instr($content, $SearchStr) > 0 ){
        $content = Replace($content, $SearchStr, $ReplaceStr) ;
    }else{
        $SearchStr = '<textarea ' ;
        $ReplaceStr = $SearchStr . 'alt="' . $AltStr . '" ' ;
        if( instr($content, $SearchStr) > 0 ){
            $content = Replace($content, $SearchStr, $ReplaceStr) ;
        }
    }
    $inputAddAlt = $content ;
    return @$inputAddAlt;
}



//���ٵ�������====================================================

//��վ����
function webTitle_InputTextArea($WebTitle){
    $webTitle_InputTextArea = inputText('WebTitle', $WebTitle, '70%', '  ����ؼ�����-����') ;//����Ϊ��վĬ�ϱ���
    return @$webTitle_InputTextArea;
}
//��վ�ؼ���
function webKeywords_InputText($WebKeywords){
    $webKeywords_InputText = inputText('WebKeywords', $WebKeywords, '70%', ' ���ԣ�����(���Ķ���)') ;
    return @$webKeywords_InputText;
}
//��վ����
function webDescription_InputTextArea($WebDescription){
    $webDescription_InputTextArea = inputTextArea('WebDescription', $WebDescription, '99%', '100px', '') ;
    return @$webDescription_InputTextArea;
}
//��̬�ļ�����
function folderName_InputText($folderName){
    $folderName_InputText = inputText('FolderName', $folderName, '40%', '') ;
    return @$folderName_InputText;
}
//��̬�ļ���
function fileName_InputText($fileName){
    $fileName_InputText = inputText('FileName', $fileName, '40%', '.html Ҳ�����������ϵ����ӵ�ַ') ;
    return @$fileName_InputText;
}
//ģ���ļ���

function templatePath_InputText($TemplatePath){
    $templatePath_InputText = inputText('TemplatePath', $TemplatePath, '40%', ' ����ΪĬ��') ;
    return @$templatePath_InputText;
}
//���ƴ����ť����
function clickPinYinHTMLStr($did){
    $clickPinYinHTMLStr = '<a href="javascript:GetPinYin(\'FolderName\',\'' . $did . '\',\'AjAx.Asp?act=GetPinYin\')" >���ƴ��</a>' ;
    return @$clickPinYinHTMLStr;
}
//ѡ���ı���ɫ���ı��Ӵ�
function showFontColorFontB($FontColor, $FontB){
    $showFontColorFontB = selectFontColor($FontColor) . inputCheckBox('FontB', $FontB, '�Ӵ�') ;
    return @$showFontColorFontB;
}
//��ʾ�ı�TEXT����
function showSort($sort){
    $showSort = inputText('Sort', $sort, '30px', '') ;
    $showSort = Replace(showSort, ';\'', ';text-align:center;\'') ;
    return @$showSort;
}
//��վ�������Ͷ����ײ���
function showWebNavType($NavTop, $NavButtom, $NavLeft, $NavContent, $NavRight, $NavOthre){
    $c ='';
    $c = $c . inputCheckBox('NavTop', $NavTop, '��������') ;
    $c = $c . inputCheckBox('NavButtom', $NavButtom, '�ײ�����') ;
    $c = $c . inputCheckBox('NavLeft', $NavLeft, '��ߵ���') ;
    $c = $c . inputCheckBox('NavContent', $NavContent, '�м䵼��') ;
    $c = $c . inputCheckBox('NavRight', $NavRight, '�ұߵ���') ;
    $c = $c . inputCheckBox('NavOthre', $NavOthre, '��������') ;
    $showWebNavType = $c ;
    return @$showWebNavType;
}
function showOnHtml($OnHtml){
    $showOnHtml = inputCheckBox('OnHtml', $OnHtml, '����HTML') ;
    return @$showOnHtml;
}
function showThrough($Through){
    $showThrough = inputCheckBox('Through', $Through, '���') ;
    return @$showThrough;
}
function showRecommend($Recommend){
    $showRecommend = inputCheckBox('Recommend', $Recommend, '�Ƽ�') ;
    return @$showRecommend;
}
//��ʾ������ر�ͼƬ
function showOnOffImg($id, $Table, $FieldName, $Recommend, $url){
    $temp=''; $Img=''; $AUrl ='';
    if( Rq('page') <> '' ){ $temp = '&page=' . Rq('page') ;}else{ $temp == '' ;}
    if( $Recommend == true ){
        $Img = '<img src="/Admin/Images/yes.gif">' ;
    }else{
        $Img = '<img src="/Admin/Images/webno.gif">' ;
    }
    //Call Echo(GetUrl(),"/Admin/HandleDatabase.Asp?act=SetTrueFalse&Table=" & Table & "&FieldName=" & FieldName & "&Url=" & Url & "&Id=" & Id)
    $AUrl = GetUrlAddToParam(GetUrl(), '/Admin/HandleDatabase.Asp?act=SetTrueFalse&Table=' . $Table . '&FieldName=' . $FieldName . '&Url=' . $url . '&Id=' . $id, 'replace') ;
    $showOnOffImg = '<a href="' . $AUrl . '">' . $Img . '</a>' ;
    //�ɰ�
    //ShowOnOffImg = "<a href=/Admin/HandleDatabase.Asp?act=SetTrueFalse&Table=" & Table & "&FieldName=" & FieldName & "&Url=" & Url & "&Id=" & Id & Temp & ">" & Img & "</a>"
    return @$showOnOffImg;
}
//��ʾ������ر�ͼƬ
function newShowOnOffImg($id, $Table, $FieldName, $Recommend, $url){
    $temp=''; $Img ='';
    if( Rq('page') <> '' ){ $temp = '&page=' . Rq('page') ;}else{ $temp == '' ;}
    if( $Recommend == 1 ){
        $Img = '<img src="/Images/yes.gif">' ;
    }else{
        $Img = '<img src="/Images/webno.gif">' ;
    }
    $newShowOnOffImg = '<a href=/WebAdmin/ZAction.Asp?act=Through&Table=' . $Table . '&FieldName=' . $FieldName . '&Url=' . $url . '&Id=' . $id . $temp . '>' . $Img . '</a>' ;
    return @$newShowOnOffImg;
}


//��ÿ���Css��ʽ 20150128  ��ʱ����
function controlDialogCss(){
    $c ='';
    $c = '<style>' . "\n" ;
    $c = $c . '/*����Css20150128*/' . "\n" ;
    $c = $c . '.controlDialog{' . "\n" ;
    $c = $c . '    position:relative;' . "\n" ;
    $c = $c . '    height:50px;' . "\n" ;
    $c = $c . '    width:auto;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.controlDialog .menu{' . "\n" ;
    $c = $c . '    position:absolute;' . "\n" ;
    $c = $c . '    right:0px;' . "\n" ;
    $c = $c . '    top:0px;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.controlDialog .menu a{' . "\n" ;
    $c = $c . '    color:#FF0000;' . "\n" ;
    $c = $c . '    font-size:14px;' . "\n" ;
    $c = $c . '    text-decoration:none;' . "\n" ;
    $c = $c . '    background-color:#FFFFFF;' . "\n" ;
    $c = $c . '    border:1px solid #003300;' . "\n" ;
    $c = $c . '    padding:4px;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '.controlDialog .menu a:hover{' . "\n" ;
    $c = $c . '    color:#C60000;' . "\n" ;
    $c = $c . '    text-decoration:underline;' . "\n" ;
    $c = $c . '}' . "\n" ;
    $c = $c . '</style>' . "\n" ;
    $controlDialogCss = $c ;
    return @$controlDialogCss;
}


//ɾ�����ݴ����
function batchDeleteTempStr($content,$startStr,$endStr){
    $i='';$s='';
    for( $i = 1 ; $i<= 9; $i++){
        if( instr($content,$startStr)==false ){
            break;
        }
        $s=getStrCut($content,$startStr,$endStr,1);
        $content=replace($content,$s,'')		;
    }
    $batchDeleteTempStr=$content;
    return @$batchDeleteTempStr;
}
?>