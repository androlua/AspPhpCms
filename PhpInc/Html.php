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
//Html ����HTML���� (2014,1,3)

//HTML����ת��
function showHTMLCode($str){
    if( IsNull($str) ){
        $str = Replace($str, ' ', '&nbsp;') ;
        $str = Replace($str, '<', '&lt;') ;
        $str = Replace($str, '>', '&gt;') ;
        $str = Replace($str, '��', '&rdquo;') ;
        $str = Replace($str, '��', '&ldquo;') ;
        $str = Replace($str, '&', '&amp;') ;
    }
    $showHTMLCode = $str ;
    return @$showHTMLCode;
}

//��ʾHtml
function showHtml($str){
    $showHtml = Replace($str, '<', '&lt;') ;
    return @$showHtml;
}

//HTML�������
function unHTMLCode($str){
    if( IsNull($str) ){
        $str = Replace($str, '&nbsp;', ' ') ;
        $str = Replace($str, '&lt;', '<') ;
        $str = Replace($str, '&gt;', '>') ;
        $str = Replace($str, '&rdquo;', '��') ;
        $str = Replace($str, '&ldquo;', '��') ;
        $str = Replace($str, '&mdash;', '��') ;
        $str = Replace($str, '&lsquo;', '��') ;
        $str = Replace($str, '&rsquo;', '��') ;

        $str = Replace($str, '&amp;', '&') ;

    }
    $unHTMLCode = $str ;
    return @$unHTMLCode;
}

//��HTML��������ʾ
function echoHTML($str){
    if( IsNull($str) ){
        $str = Replace($str, ' ', '&nbsp;') ;
        $str = Replace($str, '<', '&lt;') ;
    }
    $echoHTML = $str ;
    return @$echoHTML;
}


//ErrorText
function errorText($Refresh, $str, $url){
    if( $Refresh<>'' ){
        rw('<meta http-equiv="refresh" content="' . $Refresh . ';URL=' . $url . '""">') . vbCrlf() ;
    }
    rw('<fieldset>') . vbCrlf() ;
    rw('<legend>&nbsp;Report&nbsp;</legend>') . vbCrlf() ;
    rw('<div style="padding-left:20px;padding-top:10px;color:red;font-weight:bold;text-align:center;">' . $str . '</div>') . vbCrlf() ;
    rw('<div style="height:200p;text-align:center;"><P>') . vbCrlf() ;
    rw('<a href="' . $url . '">�������������û���Զ���ת,�������>></a><P>') . vbCrlf() ;
    rw('</div></fieldset>') ; die() ;
}


//---------------------- Html���� Start ----------------------
//����Html��ʾ20141217 ������
function testHtml(){
    $s ='';
    $s = '<font style="font-size:12px">��ʾ<b>1</b></font>' ;
    ASPEcho('S', $s) ;
    $s = HTMLEncode($s) ;
    ASPEcho('S', $s) ;
    $s = HtmlDecode($s) ;
    ASPEcho('S', $s) ;
    $s = HtmlFilter($s) ;
    ASPEcho('S', $s) ;
}

//Html����
function htmlDecode( $str){
    if( IsNul($str) ){
        $str = regReplace($str, '<br\\s*/?\\s*>', vbCrlf()) ;
        $str = Replace($str, '&nbsp;&nbsp; &nbsp;', Chr(9)) ;
        $str = Replace($str, '&quot;', Chr(34)) ;
        $str = Replace($str, '&nbsp;', Chr(32)) ;
        $str = Replace($str, '&#39;', Chr(39)) ;
        $str = Replace($str, '&apos;', Chr(39)) ;
        $str = Replace($str, '&gt;', '>') ;
        $str = Replace($str, '&lt;', '<') ;
        $str = Replace($str, '&amp;', Chr(38)) ;
        $str = Replace($str, '&#38;', Chr(38)) ;
        $htmlDecode = $str ;
    }
    return @$htmlDecode;
}

//Html����
function htmlEncode( $str){
    if( IsNul($str) ){
        $str = Replace($str, Chr(38), '&#38;') ;
        $str = Replace($str, '<', '&lt;') ;
        $str = Replace($str, '>', '&gt;') ;
        $str = Replace($str, Chr(39), '&#39;') ;
        $str = Replace($str, Chr(32), '&nbsp;') ;
        $str = Replace($str, Chr(34), '&quot;') ;
        $str = Replace($str, Chr(9), '&nbsp;&nbsp; &nbsp;') ;
        $str = Replace($str, vbCrlf(), '<br />') ;
    }
    $htmlEncode = $str ;
    return @$htmlEncode;
}

//HTML����
function htmlFilter( $str){
    $str = regReplace($str, '<[^>]+>', '') ;
    $str = Replace($str, '>', '&gt;') ;
    $str = Replace($str, '<', '&lt;') ;
    $htmlFilter = $str ;
    return @$htmlFilter;
}







//---------------------- Html���� End ----------------------











//����Html��ǩ�պ�(20150831) ��һ�֣���̭
function handleHtmlLabelClose($content, $labelName, $isAddAlt){
    $startStr=''; $endStr=''; $splStr=''; $s=''; $ImgList=''; $imgStr=''; $LCaseImgStr=''; $newImgStr ='';
    $startStr = '<' . $labelName ; $endStr = '>' ;
    $ImgList = GetArray($content, $startStr, $endStr, true, false) ;
    //call rw(ImgList)
    $splStr = aspSplit($ImgList, '$Array$') ;
    foreach( $splStr as $imgStr){
        $newImgStr = phpTrim($imgStr) ;
        if( substr($newImgStr, - 1) == '/' ){
            $newImgStr = PHPTrim(substr($newImgStr, 0 , strlen($newImgStr) - 1)) ;
        }
        if( $isAddAlt == true ){
            $LCaseImgStr = LCase($imgStr) ;
            if( instr($LCaseImgStr, 'alt') == false ){
                $newImgStr = $newImgStr . ' alt=""' ;
            }
        }
        $content = Replace($content, $imgStr . '>', $newImgStr . ' />') ;
    }
    $handleHtmlLabelClose = $content ;
    return @$handleHtmlLabelClose;
}


//����ͼƬ�պ�(20150831)
function handleImgClose($content, $isAddAlt){
    $handleImgClose = handleHtmlLabelClose($content, 'img', $isAddAlt) ;
    return @$handleImgClose;
}

//����BR�պ�(20150831)
function handleBrClose($content, $isAddAlt){
    $handleBrClose = handleHtmlLabelClose($content, 'br', false) ;
    $handleBrClose = Replace(handleBrClose, '<br>', '<br />') ;
    return @$handleBrClose;
}

//����HR�պ�(20150831)
function handleHrClose($content, $isAddAlt){
    $handleHrClose = handleHtmlLabelClose($content, 'hr', false) ;
    $handleHrClose = Replace(handleHrClose, '<hr>', '<hr />') ;
    return @$handleHrClose;
}





//����պ�HTML��ǩ(20150902)  ������ĸ����� �ڶ���
function handleCloseHtml($content, $ImgAddAlt, $action){
    $i=''; $endStr=''; $s=''; $s2=''; $c=''; $labelName=''; $startLabel=''; $endLabel ='';
    $action = '|' . $action . '|' ;
    $startLabel = '<' ;
    $endLabel = '>' ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $endStr = mid($content, $i,-1) ;
        if( $s == '<' ){
            if( instr($endStr, '>') > 0 ){
                $s = mid($endStr, 1, instr($endStr, '>')) ;
                $i = $i + strlen($s) - 1 ;
                $s = mid($s, 2, strlen($s) - 2) ;
                $s = phptrim($s) ;
                if( substr($s, - 1) == '/' ){
                    $s = phptrim(substr($s, 0 , strlen($s) - 1)) ;
                }
                $endStr = substr($endStr, - strlen($endStr) - strlen($s) - 2) ;//����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                //ע��֮ǰ����labelName����
                $labelName = mid($s, 1, instr($s . ' ', ' ') - 1) ;
                $labelName = LCase($labelName) ;
                //call eerr("s",s)

                if( instr($action, '|����A����|') > 0 ){
                    $s = htmlLabelToClean($s, $labelName, 'http://127.0.0.1/TestWeb/Web/', '����A����') ;//����ɾ�html��ǩ
                }else if( instr($action, '|����A���ӵڶ���|') > 0 ){
                    $s = htmlLabelToClean($s, $labelName, 'http://127.0.0.1/debugRemoteWeb.asp?url=', '����A����') ;//����ɾ�html��ǩ
                }else{
                    $s = htmlLabelToClean($s, $labelName, '', '') ;//����ɾ�html��ǩ
                }

                //call echo(s,labelName)   param��embed��Flash�õ�������embed�н�����ǩ��
                if( instr('|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|', '|' . $labelName . '|') > 0 ){
                    $s = Replace(Replace(Replace(Replace($s, ' class=""', ''), ' alt=""', ''), ' title=""', ''), ' name=""', '') ;//��ʱ��ô��һ�£��Ժ�Ҫ����ϵͳ����
                    $s = Replace(Replace(Replace(Replace($s, ' class=\'\'', ''), ' alt=\'\'', ''), ' title=\'\'', ''), ' name=\'\'', '') ;
                    //��vb.net����õ� Ҫ��Ȼ���ᱨ����
                    if( $labelName == 'img' && $ImgAddAlt == true ){
                        if( instr($s, ' alt') == false ){
                            $s = $s . ' alt=""' ;
                        }
                        $s = AspTrim($s) ;
                        $s = $s . ' /' ;
                        //����<script>20160106  ��ʱ������������ȸĽ�
                    }else if( $labelName == 'script' ){
                        if( instr($s, ' type') == false ){
                            $s = $s . ' type="text/javascript"' ;
                        }
                    }
                }
                $s = $startLabel . $s . $endLabel ;
                //����javascript script����
                if( $labelName == 'script' ){
                    $s2 = mid($endStr, 1, instr($endStr, '</script>') + 8) ;

                    //call eerr("",s2)
                    $i = $i + strlen($s2) ;
                    $s = $s . $s2 ;
                }
                //call echo("s",replace(s,"<","&lt;"))
            }
        }
        $c = $c . $s ;
    }
    $handleCloseHtml = $c ;
    return @$handleCloseHtml;
}

function htmlLabelToClean( $content, $labelName, $addToHttpUrl, $action){
    $i=''; $s=''; $c=''; $temp ='';
    $isValue ='';//�Ƿ�Ϊ����ֵ
    $valueStr ='';//�洢����ֵ
    $yinghaoLabel ='';//����������'"
    $parentName ='';//��������
    $behindStr ='';//����ȫ���ַ�
    $noDanYinShuangYinStr ='';//���ǵ����ź�˫�����ַ�
    $action = '|' . $action . '|' ;
    $content = Replace($content . ' ', "\t", ' ') ;//�˸��滻�ɿո�����һ���ո񣬷������
    $content = Replace(Replace($content, ' =', '='), ' =', '=') ;
    $isValue = false ;//Ĭ������Ϊ�٣���Ϊ���ǻ�ñ�ǩ����
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;//��õ�ǰһ���ַ�
        $behindStr = mid($content, $i,-1) ;//�����ַ�
        if( $s == '=' && $isValue == false ){ //��������ֵ����Ϊ=��
            $isValue = true ;
            $valueStr = '' ;
            $yinghaoLabel = '' ;
            if( $c <> '' && substr($c, - 1) <> ' ' ){ $c = $c . ' ' ;}
            $parentName = LCase($temp) ;//��������תСд
            $c = $c . $parentName . $s ;
            $temp = '' ;
            //���ֵ��һ���ַ�����Ϊ������������
        }else if( $isValue == true && $yinghaoLabel == '' ){
            if( $s <> ' ' ){
                if( $s <> '\'' && $s <> '"' ){
                    $noDanYinShuangYinStr = $s ;//���ǵ����ź�˫�����ַ�
                    $s = ' ' ;
                }
                $yinghaoLabel = $s ;
                //call echo("yinghaoLabel",yinghaoLabel)
            }
        }else if( $isValue == true && $yinghaoLabel <> '' ){
            //Ϊ���Ž���
            if( $yinghaoLabel == $s ){
                $isValue = false ;
                if( $labelName == 'a' && $parentName == 'href' && instr($action, '|����A����|') > 0 ){
                    //����
                    if( instr($valueStr, '?') > 0 ){
                        $valueStr = Replace($valueStr, '?', 'WenHao') . '.html' ;
                    }
                    if( instr('|asp|php|aspx|jsp|', '|' . LCase(mid($valueStr, strrpos($valueStr, '.') + 1,-1)) . '|') > 0 ){
                        $valueStr = $valueStr . '.html' ;
                    }
                    $valueStr = addToOrAddHttpUrl($addToHttpUrl, $valueStr, '�滻') ;

                }
                //call echo("labelName",labelName)
                if( $yinghaoLabel == ' ' ){
                    $c = $c . '"' . $noDanYinShuangYinStr . $valueStr . '" ' ;//׷�� ���ǵ����ź�˫�����ַ�            ��ȫ
                }else{
                    $c = $c . $yinghaoLabel . $valueStr . $yinghaoLabel ;//׷�� ���ǵ����ź�˫�����ַ�
                }
                $yinghaoLabel = '' ;
                $noDanYinShuangYinStr = '' ;//���ǵ����ź�˫�����ַ� ���
            }else{
                $valueStr = $valueStr . $s ;
            }
            //Ϊ �ָ�
        }else if( $s == ' ' ){
            //�ݴ����ݲ�Ϊ��
            if( $temp <> '' ){
                if( substr(AspTrim($behindStr) . ' ', 0 , 1) == '=' ){
                    //����һ���ַ�����=������
                }else{
                    //Ϊ��ǩ
                    if( $isValue == false ){
                        $temp = LCase($temp) . ' ' ;//��ǩ��������תСд
                    }
                    $c = $c . $temp ;
                    $temp = '' ;
                }
            }
        }else{
            $temp = $temp . $s ;
        }

    }
    $c = AspTrim($c) ;
    $htmlLabelToClean = $c ;
    return @$htmlLabelToClean;
}

//׷�ӻ��滻��ַ(20150922)   addToOrAddHttpUrl("http://127.0.0.1/aa/","http://127.0.0.1/4.asp","�滻")
function addToOrAddHttpUrl($httpUrl, $url, $action){
    $s ='';
    $action = '|' . $action . '|' ;
    if( instr($action, '|�滻|') > 0 ){
        $s = getwebsite($url) ;
        if( $s <> '' ){
            $url = Replace($url, $s, '') ;
        }
    }
    if( instr($url, $httpUrl) == false ){
        if( substr($httpUrl, - 1) == '/' &&(substr($url, 0 , 1) == '/' || substr($url, 0 , 1) == '\\') ){
            $url = mid($url, 2,-1) ;
        }
        $url = $httpUrl . $url ;
    }

    $addToOrAddHttpUrl = $url ;
    return @$addToOrAddHttpUrl;
}

//ɾ��html����� ��ķ��� ɾ������
function removeBlankLines($content){
    $s=''; $c=''; $splStr ='';
    $splStr = aspSplit($content, vbCrlf()) ;
    foreach( $splStr as $s){
        if( Replace(Replace($s, "\t", ''), ' ', '') <> '' ){
            if( $c <> '' ){ $c = $c . vbCrlf() ;}
            $c = $c . $s ;
        }
    }
    $removeBlankLines = $c ;
    return @$removeBlankLines;
}

function removeBlankLines_test1($content){
    $i ='';
    for( $i = 1 ; $i<= 9; $i++){
        $content = Replace($content, vbCrlf() . vbCrlf(), vbCrlf()) ;
    }
    $removeBlankLines_test1 = $content ;
    return @$removeBlankLines_test1;
}

//����ҳ���� 20160108
function blankHtmlBody($webTitle, $webBody){
    $c ='';
    $c = '<!DOCTYPE html PUBLIC>' . vbCrlf() ;
    $c = $c . '<html xmlns="http://www.w3.org/1999/xhtml">' . vbCrlf() ;
    $c = $c . '<head>' . vbCrlf() ;
    $c = $c . '<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />' . vbCrlf() ;
    $c = $c . '<title>' . $webTitle . '</title>' . vbCrlf() ;
    $c = $c . '</head>' . vbCrlf() ;
    $c = $c . '<body>' . vbCrlf() ;
    $c = $c . $webBody . vbCrlf() ;
    $c = $c . '</body>' . vbCrlf() ;
    $c = $c . '</html>' . vbCrlf() ;
    $blankHtmlBody = $c ;
    return @$blankHtmlBody;
}



?>