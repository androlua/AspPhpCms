<?PHP
//Html ����HTML���� (2014,1,3)
//��ʾHTML�ṹ        call rw(displayHTmL("<br>aasdfds<br>"))
//�ر���ʾHTML�ṹ   call rwend(unDisplayHtml("&lt;br&gt;aasdfds&lt;br&gt;"))

//��ʾHTML�ṹ
function displayHtml($str){
    $str= Replace($str, '<', '&lt;');
    $str= Replace($str, '>', '&gt;');
    $displayHtml= $str;
    return @$displayHtml;
}
//�ر���ʾHTML�ṹ
function unDisplayHtml($str){
    $str= Replace($str, '&lt;', '<');
    $str= Replace($str, '&gt;', '>');
    $unDisplayHtml= $str;
    return @$unDisplayHtml;
}

//����պ�HTML��ǩ(20150902)  ������ĸ����� �ڶ���
function handleCloseHtml($content, $imgAddAlt, $action){
    $i=''; $endStr=''; $s=''; $s2=''; $c=''; $labelName=''; $startLabel=''; $endLabel ='';
    $action= '|' . $action . '|';
    $startLabel= '<';
    $endLabel= '>';
    for( $i= 1 ; $i<= Len($content); $i++){
        $s= mid($content, $i, 1);
        $endStr= mid($content, $i,-1);
        if( $s== '<' ){
            if( instr($endStr, '>') > 0 ){
                $s= mid($endStr, 1, instr($endStr, '>'));
                $i= $i + Len($s) - 1;
                $s= mid($s, 2, Len($s) - 2);
                $s= phptrim($s);
                if( Right($s, 1)== '/' ){
                    $s= phptrim(Left($s, Len($s) - 1));
                }
                $endStr= Right($endStr, Len($endStr) - Len($s) - 2); //����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                //ע��֮ǰ����labelName����
                $labelName= mid($s, 1, instr($s . ' ', ' ') - 1);
                $labelName= strtolower($labelName);
                //call eerr("s",s)

                if( instr($action, '|����A����|') > 0 ){
                    $s= handleHtmlAHref($s, $labelName, 'http://127.0.0.1/TestWeb/Web/', '����A����'); //����ɾ�html��ǩ
                }else if( instr($action, '|����A���ӵڶ���|') > 0 ){
                    $s= handleHtmlAHref($s, $labelName, 'http://127.0.0.1/debugRemoteWeb.asp?url=', '����A����'); //����ɾ�html��ǩ
                }
                //call echo(s,labelName)   param��embed��Flash�õ�������embed�н�����ǩ��
                if( instr('|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|', '|' . $labelName . '|') > 0 ){
                    $s= Replace(Replace(Replace(Replace($s, ' class=""', ''), ' alt=""', ''), ' title=""', ''), ' name=""', ''); //��ʱ��ô��һ�£��Ժ�Ҫ����ϵͳ����
                    $s= Replace(Replace(Replace(Replace($s, ' class=\'\'', ''), ' alt=\'\'', ''), ' title=\'\'', ''), ' name=\'\'', '');

                    //��vb.net����õ� Ҫ��Ȼ���ᱨ����
                    if( $labelName== 'img' && $imgAddAlt== true ){
                        if( instr($s, ' alt')== false ){
                            $s= $s . ' alt=""';
                        }
                        $s= AspTrim($s);
                        $s= $s . ' /';
                        //����<script>20160106  ��ʱ������������ȸĽ�
                    }else if( $labelName== 'script' ){
                        if( instr($s, ' type')== false ){
                            $s= $s . ' type="text/javascript"';
                        }
                    }else if( Right(AspTrim($s), 1) <> '/' && instr('|meta|link|embed|param|input|img|br|hr|rect|line|area|', '|' . $labelName . '|') > 0 ){
                        $s= AspTrim($s);
                        $s= $s . ' /';
                    }
                }
                $s= $startLabel . $s . $endLabel;
                //����javascript script����
                if( $labelName== 'script' ){
                    $s2= mid($endStr, 1, instr($endStr, '</script>') + 8);

                    //call eerr("",s2)
                    $i= $i + Len($s2);
                    $s= $s . $s2;
                }
                //call echo("s",replace(s,"<","&lt;"))
            }
        }
        $c= $c . $s;
    }
    $handleCloseHtml= $c;
    return @$handleCloseHtml;
}
//����htmlA��ǩ��Href����  ������溯��
function handleHtmlAHref( $content, $labelName, $addToHttpUrl, $action){
    $i=''; $s=''; $c=''; $temp ='';
    $isValue ='';//�Ƿ�Ϊ����ֵ
    $valueStr ='';//�洢����ֵ
    $yinghaoLabel ='';//����������'"
    $parentName ='';//��������
    $behindStr ='';//����ȫ���ַ�
    $noDanYinShuangYinStr ='';//���ǵ����ź�˫�����ַ�
    $action= '|' . $action . '|';
    $content= Replace($content . ' ', "\t", ' '); //�˸��滻�ɿո�����һ���ո񣬷������
    $content= Replace(Replace($content, ' =', '='), ' =', '=');
    $isValue= false; //Ĭ������Ϊ�٣���Ϊ���ǻ�ñ�ǩ����
    for( $i= 1 ; $i<= Len($content); $i++){
        $s= mid($content, $i, 1); //��õ�ǰһ���ַ�
        $behindStr= mid($content, $i,-1); //�����ַ�
        if( $s== '=' && $isValue== false ){ //��������ֵ����Ϊ=��
            $isValue= true;
            $valueStr= '';
            $yinghaoLabel= '';
            if( $c <> '' && Right($c, 1) <> ' ' ){ $c= $c . ' ' ;}
            $parentName= strtolower($temp); //��������תСд
            $c= $c . $parentName . $s;
            $temp= '';
            //���ֵ��һ���ַ�����Ϊ������������
        }else if( $isValue== true && $yinghaoLabel== '' ){
            if( $s <> ' ' ){
                if( $s <> '\'' && $s <> '"' ){
                    $noDanYinShuangYinStr= $s; //���ǵ����ź�˫�����ַ�
                    $s= ' ';
                }
                $yinghaoLabel= $s;
                //call echo("yinghaoLabel",yinghaoLabel)
            }
        }else if( $isValue== true && $yinghaoLabel <> '' ){
            //Ϊ���Ž���
            if( $yinghaoLabel== $s ){
                $isValue= false;
                if( $labelName== 'a' && $parentName== 'href' && instr($action, '|����A����|') > 0 ){
                    //����
                    if( instr($valueStr, '?') > 0 ){
                        $valueStr= Replace($valueStr, '?', 'WenHao') . '.html';
                    }
                    if( instr('|asp|php|aspx|jsp|', '|' . strtolower(mid($valueStr, strrpos($valueStr, '.') + 1,-1)) . '|') > 0 ){
                        $valueStr= $valueStr . '.html';
                    }
                    $valueStr= addToOrAddHttpUrl($addToHttpUrl, $valueStr, '�滻');

                }
                //call echo("labelName",labelName)
                if( $yinghaoLabel== ' ' ){
                    $c= $c . '"' . $noDanYinShuangYinStr . $valueStr . '" '; //׷�� ���ǵ����ź�˫�����ַ�            ��ȫ
                }else{
                    $c= $c . $yinghaoLabel . $valueStr . $yinghaoLabel; //׷�� ���ǵ����ź�˫�����ַ�
                }
                $yinghaoLabel= '';
                $noDanYinShuangYinStr= ''; //���ǵ����ź�˫�����ַ� ���
            }else{
                $valueStr= $valueStr . $s;
            }
            //Ϊ �ָ�
        }else if( $s== ' ' ){
            //�ݴ����ݲ�Ϊ��
            if( $temp <> '' ){
                if( Left(AspTrim($behindStr) . ' ', 1)== '=' ){
                    //����һ���ַ�����=������
                }else{
                    //Ϊ��ǩ
                    if( $isValue== false ){
                        $temp= strtolower($temp) . ' '; //��ǩ��������תСд
                    }
                    $c= $c . $temp;
                    $temp= '';
                }
            }
        }else{
            $temp= $temp . $s;
        }

    }
    $c= AspTrim($c);
    $handleHtmlAHref= $c;
    return @$handleHtmlAHref;
}
//׷�ӻ��滻��ַ(20150922) �������   addToOrAddHttpUrl("http://127.0.0.1/aa/","http://127.0.0.1/4.asp","�滻") = http://127.0.0.1/aa/4.asp
function addToOrAddHttpUrl($httpurl, $url, $action){
    $s ='';
    $action= '|' . $action . '|';
    if( instr($action, '|�滻|') > 0 ){
        $s= getwebsite($url);
        if( $s <> '' ){
            $url= Replace($url, $s, '');
        }
    }
    if( instr($url, $httpurl)== false ){
        if( Right($httpurl, 1)== '/' &&(Left($url, 1)== '/' || Left($url, 1)== '\\') ){
            $url= mid($url, 2,-1);
        }
        $url= $httpurl . $url;
    }

    $addToOrAddHttpUrl= $url;
    return @$addToOrAddHttpUrl;
}

//���HTML��ǩ�� call rwend(getHtmlLableName("<img src><a href=>",0))    ����  img
function getHtmlLableName($content, $nThisLabel){
    $i=''; $endStr=''; $s=''; $c=''; $labelName=''; $nLabelCount ='';
    $nLabelCount= 0;
    for( $i= 1 ; $i<= Len($content); $i++){
        $s= mid($content, $i, 1);
        $endStr= mid($content, $i,-1);
        if( $s== '<' ){
            if( instr($endStr, '>') > 0 ){
                $s= mid($endStr, 1, instr($endStr, '>'));
                $i= $i + Len($s) - 1;
                $s= mid($s, 2, Len($s) - 2);
                $s= phptrim($s);
                if( Right($s, 1)== '/' ){
                    $s= phptrim(Left($s, Len($s) - 1));
                }
                $endStr= Right($endStr, Len($endStr) - Len($s) - 2); //����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                //ע��֮ǰ����labelName����
                $labelName= mid($s, 1, instr($s . ' ', ' ') - 1);
                $labelName= strtolower($labelName);
                if( $nThisLabel== $nLabelCount ){
                    break;
                }
                $nLabelCount= $nLabelCount + 1;
            }
        }
        $c= $c . $s;
    }
    $getHtmlLableName= $labelName;
    return @$getHtmlLableName;
}

//ɾ��html����� ��ķ��� ɾ������
function removeBlankLines($content){
    $s=''; $c=''; $splStr ='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( Replace(Replace($s, "\t", ''), ' ', '') <> '' ){
            if( $c <> '' ){ $c= $c . vbCrlf() ;}
            $c= $c . $s;
        }
    }
    $removeBlankLines= $c;
    return @$removeBlankLines;
}


//call echo("webtitle",getHtmlValue(content,"webtitle"))
//call echo("webdescription",getHtmlValue(content,"webdescription"))
//call echo("webkeywords",getHtmlValue(content,"webkeywords"))
//���html����ָ��ֵ20160520 call echo("webtitle",getHtmlValue(content,"webtitle"))
function getHtmlValue($content, $sType){
    $i=''; $endStr=''; $s=''; $labelName=''; $startLabel=''; $endLabel=''; $LCaseEndStr=''; $paramName ='';
    $startLabel= '<';
    $endLabel= '>';
    for( $i= 1 ; $i<= Len($content); $i++){
        $s= mid($content, $i, 1);
        $endStr= mid($content, $i,-1);
        if( $s== '<' ){
            if( instr($endStr, '>') > 0 ){
                $s= mid($endStr, 1, instr($endStr, '>'));
                $i= $i + Len($s) - 1;
                $s= mid($s, 2, Len($s) - 2);
                $s= phptrim($s);
                if( Right($s, 1)== '/' ){
                    $s= phptrim(Left($s, Len($s) - 1));
                }
                $endStr= Right($endStr, Len($endStr) - Len($s) - 2); //����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                //ע��֮ǰ����labelName����
                $labelName= mid($s, 1, instr($s . ' ', ' ') - 1);
                $labelName= strtolower($labelName);

                if( $labelName== 'title' && $sType== 'webtitle' ){
                    $LCaseEndStr= strtolower($endStr);
                    if( instr($LCaseEndStr, '</title>')>0 ){
                        $s= mid($endStr, 1, instr($LCaseEndStr, '</title>') - 1);
                    }else{
                        $s='';
                    }
                    $getHtmlValue= $s;
                    return @$getHtmlValue;
                }else if( $labelName== 'meta' &&($sType== 'webkeywords' || $sType== 'webdescription') ){
                    $LCaseEndStr= strtolower($endStr);
                    $paramName= phptrim(strtolower(getParamValue($s, 'name')));
                    if( 'web' . $paramName== $sType ){
                        $getHtmlValue= getParamValue($s, 'content');
                        return @$getHtmlValue;
                    }


                }

            }
        }
    }
    $getHtmlValue= '';
    return @$getHtmlValue;
}

//��ò���ֵ20160520  call rwend(getParamValue("meta name=""keywords"" content=""{$web_keywords$}""","name"))
function getParamValue($content, $paramName){
    $LCaseContent=''; $s=''; $splStart=''; $splEnd=''; $i=''; $startStr=''; $endStr ='';
    $LCaseContent= strtolower($content);

    $splStart= array('="', '=\'', '=');
    $splEnd= array('"', '\'', '>');
    for( $i= 0 ; $i<= UBound($splStart); $i++){
        $startStr= $paramName . $splStart[$i];
        $endStr= $splEnd[$i];
        if( instr($LCaseContent, $startStr) > 0 && instr($LCaseContent, $endStr) > 0 ){
            $s= strCut($content, $startStr, $endStr, 2);
            if( $s <> '' ){
                $getParamValue= $s;
                return @$getParamValue;
            }
        }
    }
    return @$getParamValue;
}

?>