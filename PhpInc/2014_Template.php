<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-03-11
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//ɾ�����ֶ����ǩ <R#��������BlockName��վ���� start#>  <R#��������BlockName��վ���� end#>
//��ģ�崦��



//��ģ������
function XY_ReadTemplateModule($action){
    $moduleId=''; $filePath ='';
    $sourceList ='';//Դ�����б� 20150109
    $replaceList ='';//�滻�����б�
    $filePath = RParam($action, 'File') ;
    $moduleId = RParam($action, 'ModuleId') ;
    $sourceList = RParam($action, 'SourceList') ;
    $replaceList = RParam($action, 'ReplaceList') ;
    //Call Echo(SourceList,ReplaceList)

    if( $moduleId == '' ){ $moduleId = RParam($action, 'ModuleName') ;}//�ÿ�����
    $filePath = $filePath . '.html' ;
    //Call Echo("FilePath",FilePath)
    //Call Echo("ModuleId",ModuleId)
    $XY_ReadTemplateModule = readTemplateModuleStr($filePath, '', $moduleId) ;
    return @$XY_ReadTemplateModule;
}

//��ģ������
function readTemplateModuleStr($filePath, $defaultContent, $moduleId){
    $startStr=''; $endStr=''; $content ='';
    $startStr = '<!--#Module ' . $moduleId . ' Start#-->' ;
    $endStr = '<!--#Module ' . $moduleId . ' End#-->' ;
    //FilePath = ReplaceGlobleLable(FilePath)                '�滻ȫ����ǩ        '�����2014 12 11

    //�ļ������ڣ���׷��ģ��·�� 20150616 ��VB�������
    if( checkFile($filePath) == false ){
        $filePath = $GLOBALS['WebTemplate'] . $filePath ;
    }

    if( $defaultContent <> '' ){
        $content = $defaultContent ;
    }else if( checkFile($filePath) == true ){
        $content = getFText($filePath) ;
    }else{
        $content = $GLOBALS['code'] ;//Ĭ��������ָ������
    }
    //Call Die("��ʾ" & ModuleId & "," & Content)
    //Call Eerr(filepath & checkfile(filepath), Content)
    if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
        $readTemplateModuleStr = strCut($content, $startStr, $endStr, 2) ;
    }else{
        $readTemplateModuleStr = 'ģ��[' . $moduleId . ']������,·��=' . $filePath ;
    }
    return @$readTemplateModuleStr;
}
//��ģ���Ӧ����
function findModuleStr($content, $valueStr){
    $startStr=''; $endStr=''; $YuanStr=''; $replaceStr=''; $i=''; $Block=''; $BlockFile=''; $action ='';
    for( $i = 1 ; $i<= 9; $i++){
        $startStr = '[$�������� ' ; $endStr = '$]' ;
        if( instr($valueStr, $startStr) > 0 && instr($valueStr, $endStr) > 0 ){
            $action = strCut($valueStr, $startStr, $endStr, 2) ;
            $Block = RParam($action, 'Block') ;
            $BlockFile = RParam($action, 'File') ;
            if( instr(vbCrlf() . $GLOBALS['ReadBlockList'] . vbCrlf(), vbCrlf() . $Block . vbCrlf()) == false ){
                $GLOBALS['ReadBlockList'] = $GLOBALS['ReadBlockList'] . $Block . vbCrlf() ;
            }
            //���ļ����� ���������
            if( $BlockFile <> '' ){
                $content = getFText($BlockFile) ;
            }
            $YuanStr = $startStr . $action . $endStr ;
            $replaceStr = '' ;

            $startStr = '<R#��������' . $Block . ' start#>' ; $endStr = '<R#��������' . $Block . ' end#>' ;
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $replaceStr = strCut($content, $startStr, $endStr, 2) ;
            }else{
                $startStr = '<!--#��������' . $Block ; $endStr = '#-->' ;
                if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                    $replaceStr = strCut($content, $startStr, $endStr, 2) ;
                }
            }
            //Call Eerr(YuanStr,ReplaceStr)
            $valueStr = Replace($valueStr, $YuanStr, $replaceStr) ;
            //Call Echo("ValueStr",ValueStr)
        }else{
            //û��ģ��Ҫ������ ���˳�
            break;
        }
    }
    $findModuleStr = $valueStr ;
    return @$findModuleStr;
}

//����Leftģ����ʽ        �������ַ� ' ���ظ��ƻ�������������� \|*|\ ���洦��
function XY_ReadColumeSetTitle($action){
    $startStr=''; $endStr=''; $Style=''; $title=''; $valueStr=''; $MoreClass=''; $MoreUrl=''; $MoreStr=''; $aStr ='';
    $action = handleInModule($action, 'start') ;
    $Style = RParam($action, 'style') ;
    $title = RParam($action, 'Title') ;
    //Call Echo("ContentHeight",ContentHeight)
    //ValueStr = RParam(Action,"value")
    //����ģ��������
    $valueStr = moduleFindContent($action, 'value') ;
    //Call Eerr("ValueStr",ValueStr)
    $valueStr = findModuleStr($GLOBALS['code'], $valueStr) ;//��ģ���Ӧ����

    $MoreClass = RParam($action, 'MoreClass') ;
    $MoreUrl = AspTrim(RParam($action, 'MoreUrl')) ;
    $MoreStr = RParam($action, 'MoreStr') ;
    $valueStr = handleInModule($valueStr, 'end') ;
    $XY_ReadColumeSetTitle = readColumeSetTitle($action, $Style, $title, $valueStr) ;

    if( $MoreClass == '' ){ $MoreClass = 'more' ;}//More����Ϊ�� ����Ĭ�ϴ���
    //If MoreUrl="" Then MoreUrl="#"                    'More������ַΪ�� ����Ĭ��#����
    //More������ʽ����Ϊ�գ���Ϊû����ʽ���Ͳ�����More�������
    if( $MoreUrl <> '' && $MoreStr <> '' ){
        //AStr = "<a href='"& MoreUrl &"' class='"& MoreClass &"'>"& MoreStr &"</a>"
        $aStr = '<a ' . AHref($MoreUrl, $title, '') . ' class=\'' . $MoreClass . '\'>' . $MoreStr . '</a>' ;
        $XY_ReadColumeSetTitle = Replace(XY_ReadColumeSetTitle, '<!--#AMore#-->', $aStr) ;
    }
    return @$XY_ReadColumeSetTitle;
}

//����Ŀ��������������ֵ
function readColumeSetTitle($action, $id, $ColumeTitle, $ColumeContent){
    $TitleWidth ='';//������
    $TitleHeight ='';//����߶�
    $ContentHeight ='';//���ݸ߶�
    $ContentWidth ='';//���ݿ��
    $ContentCss ='';

    $TitleWidth = RParam($action, 'TitleWidth') ;//��ñ���߶�    ��Ӧ��20150715
    $TitleHeight = RParam($action, 'TitleHeight') ;//��ñ�����
    $ContentWidth = RParam($action, 'ContentWidth') ;//������ݿ��
    $ContentHeight = RParam($action, 'ContentHeight') ;//������ݸ߶�

    //�����
    $TitleWidth = AspTrim($TitleWidth) ;
    //�Զ���px��λ�����ӻ���Ч�� 20150115
    if( substr($TitleHeight, - 1) <> '%' && substr($TitleHeight, - 2) <> 'px' && $TitleHeight <> '' && $TitleHeight <> 'auto' ){
        $TitleHeight = $TitleHeight . 'px' ;
    }
    if( substr($TitleWidth, - 1) <> '%' && substr($TitleWidth, - 2) <> 'px' && $TitleWidth <> '' && $TitleWidth <> 'auto' ){
        $TitleWidth = $TitleWidth . 'px' ;
    }
    //���ݸ�
    $ContentHeight = AspTrim($ContentHeight) ;
    //�Զ���px��λ�����ӻ���Ч�� 20150115
    if( substr($ContentHeight, - 1) <> '%' && substr($ContentHeight, - 2) <> 'px' && $ContentHeight <> '' && $ContentHeight <> 'auto' ){
        $ContentHeight = $ContentHeight . 'px' ;
    }
    //���ݿ�
    $ContentWidth = AspTrim($ContentWidth) ;
    //�Զ���px��λ�����ӻ���Ч�� 20150115
    if( substr($ContentWidth, - 1) <> '%' && substr($ContentWidth, - 2) <> 'px' && $ContentWidth <> '' && $ContentWidth <> 'auto' ){
        $ContentWidth = $ContentWidth . 'px' ;
    }

    if( $ContentHeight <> '' ){
        $ContentCss = 'height:' . $ContentHeight . ';' ;
    }
    if( $ContentWidth <> '' ){
        $ContentCss = $ContentCss . 'width:' . $ContentWidth . ';' ;
    }

    $content ='';
    $content = readColumn($id) ;
    //�����
    if( $TitleWidth <> '' ){
        $content = Replace($content, '<div class="tvalue">', '<div class="tvalue" style=\'width:' . $TitleWidth . ';\'>') ;
    }
    //���ݸ�
    if( $ContentCss <> '' ){
        $content = Replace($content, '<div class="ccontent">', '<div class="ccontent" style=\'' . $ContentCss . '\'>') ;
    }
    //call echo(ContentWidth,ContentCss)

    $content = Replace($content, '��Ŀ����', $ColumeTitle) ;
    $content = Replace($content, '��Ŀ����', $ColumeContent) ;
    $readColumeSetTitle = $content ;
    return @$readColumeSetTitle;
}

//����Ŀģ��
function readColumn($id){
    $templateFilePath=''; $startStr=''; $endStr=''; $s ='';
    //Call Echo("WebTemplate",WebTemplate)
    $templateFilePath = $GLOBALS['WebTemplate'] . '\\Template_Left.html' ;
    $startStr = '/*columnlist' . $id . 'Start*/' ;
    $endStr = '/*columnlist' . $id . 'End*/' ;
    $s = readTemplateFileModular($templateFilePath, $startStr, $endStr) ;
    if( $s == '[$NO$]' ){
        $s = 'Left��ʽID[' . $id . ']������' ;
    }
    $readColumn = $s ;
    return @$readColumn;
}


//��ģ���ز�
function readTemplateSource($id){
    $templateFilePath=''; $startStr=''; $endStr=''; $s ='';
    $templateFilePath = $GLOBALS['WebTemplate'] . '\\TemplateSource.html' ;
    $startStr = '<!--#sourceHtml' . $id . 'Start#-->' ;
    $endStr = '<!--#sourceHtml' . $id . 'End#-->' ;
    $s = readTemplateFileModular($templateFilePath, $startStr, $endStr) ;
    if( $s == '[$NO$]' ){
        $s = 'ģ����ԴID[' . $id . ']������' ;
    }
    $readTemplateSource = $s ;
    return @$readTemplateSource;
}



//��ģ���ļ���ĳģ��
function readTemplateFileModular($templateFilePath, $startStr, $endStr){
    $content ='';
    $readTemplateFileModular = '' ;
    $content = getFText($templateFilePath) ;
    if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
        $readTemplateFileModular = strCut($content, $startStr, $endStr, 2) ;
    }else{
        $readTemplateFileModular = '[$NO$]' ;
    }
    return @$readTemplateFileModular;
}

//���ļ�ģ���ز�
function readTemplateFileSource($templateFilePath, $id){
    $startStr=''; $endStr=''; $s=''; $c ='';
    $startStr = '<!--#sourceHtml' . Replace($id, '.html', '') . 'Start#-->' ;
    $endStr = '<!--#sourceHtml' . Replace($id, '.html', '') . 'End#-->' ;
    $s = readTemplateFileModular($templateFilePath, $startStr, $endStr) ;
    if( $s == '[$NO$]' ){
        //��һ����ȡ���ı��������б�(20150815)
        $c = getStrCut($GLOBALS['pubCode'], $startStr, $endStr, 2) ;
        if( $c <> '' ){
            $readTemplateFileSource = $c ;
            //call rwend(c)
            return @$readTemplateFileSource;
        }
        $c = getftext($templateFilePath) ;
        //���� <!--#TemplateSplitStart#-->  �ͷ��ص�ǰȫ������
        if( instr($c, '<!--#DialogStart#-->') > 0 ){
            $readTemplateFileSource = $c ;
            return @$readTemplateFileSource;
        }

        $s = 'ģ����ԴID[' . $id . ']������,·��TemplateFilePath=' . handlePath($templateFilePath) ;
    }
    $readTemplateFileSource = $s ;
    return @$readTemplateFileSource;
}
//�����ļ�չʾ�б���Դ
function readArticleListStyleSource($id){
    $filePath ='';
    $filePath = getWebImages() . '\\����չʾ��ʽ\\' . $id ;
    if( checkFile($filePath) == false ){
        $filePath = $GLOBALS['WebTemplate'] . '\\Resources\\' . $id ;
    }
    //call echo(checkfile(filePath),filePath)
    $readArticleListStyleSource = readTemplateFileSource($filePath, $id) ;

    return @$readArticleListStyleSource;
}
//�����ļ���Ϣ�б���Դ
function readArticleInfoStyleSource($id){
    $filePath ='';
    $filePath = getWebImages() . '\\������Ϣչʾ��ʽ\\' . $id ;
    if( checkFile($filePath) == false ){
        $filePath = $GLOBALS['WebTemplate'] . '\\Resources\\' . $id ;
    }
    $readArticleInfoStyleSource = readTemplateFileSource($filePath, $id) ;
    return @$readArticleInfoStyleSource;
}

?>