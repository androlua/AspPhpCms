<?PHP
//��ʽ��20150212


//Html��ʽ�� �򵥰� ��ǿ��2014 12 09��20150709
function htmlFormatting($content){
    $htmlFormatting= handleHtmlFormatting($content, false, 0, '');
    return @$htmlFormatting;
}

//�����ʽ��
function handleHtmlFormatting( $content, $isMsgBox, $nErrLevel, $action){
    $splStr=''; $s=''; $tempS=''; $lCaseS=''; $c=''; $left4Str=''; $left5Str=''; $left6Str=''; $left7Str=''; $left8Str ='';
    $nLevel ='';//����
    $elseS=''; $elseLable ='';

    $levelArray=array(299); $keyWord ='';
    $lableName ='';//��ǩ����
    $isJavascript ='';//Ϊjavascript
    $isTextarea ='';//Ϊ���ı���<textarea
    $isPre ='';//Ϊpre
    $isJavascript= false; //Ĭ��javascriptΪ��
    $isTextarea= false; //���ļ���Ϊ��
    $isPre= false; //Ĭ��preΪ��
    $nLevel= 0; //������

    $action= '|' . $action . '|'; //����
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        $tempS= $s ; $elseS= $s;
        $s= trimVbCrlf($s) ; $lCaseS= strtolower($s);
        //�ж���20150710
        if((Left($lCaseS, 8)== '<script ' || Left($lCaseS, 8)== '<script>') && instr($s, '</script>')== false && $isJavascript== false ){
            $isJavascript= true;
            $c= $c . phptrim($tempS) . vbCrlf();
        }else if( $isJavascript== true ){

            if( Left($lCaseS, 9)== '</script>' ){
                $isJavascript= false;
                $c= $c . phptrim($tempS) . vbCrlf(); //���������߿ո�
            }else{
                $c= $c . $tempS . vbCrlf(); //Ϊjs����ʾԭ�ı�  ������������߿ո�phptrim(tempS)
            }

            //���ı����ж���20151019
        }else if((Left($lCaseS, 10)== '<textarea ' || Left($lCaseS, 10)== '<textarea>') && instr($s, '</textarea>')== false && $isTextarea== false ){
            $isTextarea= true;
            $c= $c . phptrim($tempS) . vbCrlf();
        }else if( $isTextarea== true ){
            $c= $c . phptrim($tempS) . vbCrlf();
            if( Left($lCaseS, 11)== '</textarea>' ){
                $isTextarea= false;
            }
            //���ı����ж���20151019
        }else if((Left($lCaseS, 5)== '<pre ' || Left($lCaseS, 5)== '<pre>') && instr($s, '</pre>')== false && $isPre== false ){
            $isPre= true;
            $c= $c . phptrim($tempS) . vbCrlf();
        }else if( $isPre== true ){
            $c= $c . $tempS . vbCrlf();
            if( Left($lCaseS, 6)== '</pre>' ){
                $isPre= false;
            }


        }else if( $s <> '' && $isJavascript== false && $isTextarea== false ){
            $left4Str= '|' . Left($lCaseS, 4) . '|' ; $left5Str= '|' . Left($lCaseS, 5) . '|' ; $left6Str= '|' . Left($lCaseS, 6) . '|';
            $left7Str= '|' . Left($lCaseS, 7) . '|' ; $left8Str= '|' . Left($lCaseS, 8) . '|';

            $keyWord= ''; //�ؼ��ʳ�ʼ���
            $lableName= ''; //��ǩ����
            if( instr('|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |', $left4Str) > 0 ){
                $keyWord= $left4Str;
                $lableName= mid($left4Str, 3, 2);
            }else if( instr('|<div>|<div |', $left5Str) > 0 ){
                $keyWord= $left5Str;
                $lableName= mid($left5Str, 3, 3);
            }else if( instr('|<span>|<span |<form>|<form |', $left6Str) > 0 ){
                $keyWord= $left6Str;
                $lableName= mid($left6Str, 3, 4);

            }else if( instr('|<table>|<table |<tbody>|<tbody |', $left7Str) > 0 ){
                $keyWord= $left7Str;
                $lableName= mid($left7Str, 3, 5);

            }else if( instr('|<center>|<center |', $left8Str) > 0 ){
                $keyWord= $left8Str;
                $lableName= mid($left8Str, 3, 6);
            }
            $keyWord= aspTrim(Replace(Replace($keyWord, '<', ''), '>', ''));
            //call echo(KeyWord,lableName)
            //��ʼ
            if( $keyWord <> '' ){
                $s= copyStr('    ', $nLevel) . $s;
                if( Right($lCaseS, 3 + Len($lableName)) <> '</' . $lableName . '>' && instr($lCaseS, '</' . $lableName . '>')== false ){
                    $nLevel= $nLevel + 1;
                    if( $nLevel >= 0 ){
                        $levelArray[$nLevel]= $keyWord;
                    }
                }
            }else if( instr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|', '|' . Left($lCaseS, 5) . '|') > 0 || instr('|</div>|', '|' . Left($lCaseS, 6) . '|') > 0 || instr('|</span>|</form>|', '|' . Left($lCaseS, 7) . '|') > 0 || instr('|</table>|</tbody>|', '|' . Left($lCaseS, 8) . '|') > 0 || instr('|</center>|', '|' . Left($lCaseS, 9) . '|') > 0 ){
                $nLevel= $nLevel - 1;
                $s= copyStr('    ', $nLevel) . $s;
            }else{
                $s= copyStr('    ', $nLevel) . $s;
                //����ǽ�����ǩ���һ��
                if( Right($lCaseS, 6)== '</div>' ){
                    if( checkHtmlFormatting($lCaseS)== false ){
                        $s= Left($s, Len($s) - 6);
                        $nLevel= $nLevel - 1;
                        $s= $s . vbCrlf() . copyStr('    ', $nLevel) . '</div>';
                    }
                }else if( Right($lCaseS, 7)== '</span>' ){
                    if( checkHtmlFormatting($lCaseS)== false ){
                        $s= Left($s, Len($s) - 7);
                        $nLevel= $nLevel - 1;
                        $s= $s . vbCrlf() . copyStr('    ', $nLevel) . '</span>';
                    }
                }else if( instr('|</ul>|</dt>|<dl>|<dd>|', $left5Str) > 0 ){
                    $s= Left($s, Len($s) - 5);
                    $nLevel= $nLevel - 1;
                    $s= $s . vbCrlf() . copyStr('    ', $nLevel) . Right($lCaseS, 5);
                }


                //��   aaa</li>   ���ֽ�����   20160106
                $elseS= phptrim(strtolower($elseS));
                if( instr($elseS, '</') > 0 ){
                    $elseLable= mid($elseS, instr($elseS, '</'),-1);
                    if( instr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|', '|' . $elseLable . '|') > 0 && $nLevel > 0 ){
                        $nLevel= $nLevel - 1;
                    }
                }
                //call echo("s",replace(s,"<","&lt;"))


            }
            //call echo("",ShowHtml(temps)
            $c= $c . $s . vbCrlf();
        }else if( $s== '' ){
            if( instr($action, '|delblankline|')== false && instr($action, '|ɾ������|')== false ){//ɾ������
                $c= $c . vbCrlf();
            }
        }
    }
    $handleHtmlFormatting= $c;
    $nErrLevel= $nLevel; //��ô��󼶱�
    if( $nLevel <> 0 &&(strtolower($isMsgBox)== '1' || strtolower($isMsgBox)== 'true') ){
        ASPEcho('HTML��ǩ�д���', $nLevel);
    }
    //Call Echo("nLevel",nLevel & "," & levelArray(nLevel))                '��ʾ�������20150212
    return @$handleHtmlFormatting;
}

//����պ�HTML��ǩ(20150902)  ������ĸ����� �������
function formatting($content, $action){
    $i=''; $endStr=''; $s=''; $c=''; $labelName=''; $startLabel=''; $endLabel=''; $endLabelStr=''; $nLevel=''; $isYes=''; $parentLableName ='';
    $nextLableName ='';//��һ����������
    $isA ='';//�Ƿ�ΪA����
    $isTextarea ='';//�Ƿ�Ϊ���������ı���
    $isScript ='';//�ű�����
    $isStyle ='';//Css�����ʽ��
    $isPre ='';//�Ƿ�Ϊpre
    $startLabel= '<';
    $endLabel= '>';
    $nLevel= 0;
    $action= '|' . $action . '|'; //�㼶
    $isA= false ; $isTextarea= false ; $isScript= false ; $isStyle= false ; $isPre= false;
    $content= Replace(Replace($content, vbCrlf(), Chr(10)), "\t", '    ');

    for( $i= 1 ; $i<= Len($content); $i++){
        $s= mid($content, $i, 1);
        $endStr= mid($content, $i,-1);
        if( $s== '<' ){
            if( instr($endStr, '>') > 0 ){
                $s= mid($endStr, 1, instr($endStr, '>'));
                $i= $i + Len($s) - 1;
                $s= mid($s, 2, Len($s) - 2);
                if( Right($s, 1)== '/' ){
                    $s= phptrim(Left($s, Len($s) - 1));
                }
                $endStr= Right($endStr, Len($endStr) - Len($s) - 2); //����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                //ע��֮ǰ����labelName����
                $labelName= mid($s, 1, instr($s . ' ', ' ') - 1);
                $labelName= strtolower($labelName);

                //call echo("labelName",labelName)
                if( $labelName== 'a' ){
                    $isA= true;
                }else if( $labelName== '/a' ){
                    $isA= false;
                }else if( $labelName== 'textarea' ){
                    $isTextarea= true;
                }else if( $labelName== '/textarea' ){
                    $isTextarea= false;
                }else if( $labelName== 'script' ){
                    $isScript= true;
                }else if( $labelName== '/script' ){
                    $isScript= false;
                }else if( $labelName== 'style' ){
                    $isStyle= true;
                }else if( $labelName== '/style' ){
                    $isStyle= false;
                }else if( $labelName== 'pre' ){
                    $isPre= true;
                }else if( $labelName== '/pre' ){
                    $isPre= false;
                }

                $endLabelStr= $endLabel;
                $nextLableName= getHtmlLableName($endStr, 0);
                //��Ϊѹ��HTML
                if( instr($action, '|ziphtml|')== false && $isPre== false ){
                    if( $isA== false ){
                        if( instr('|a|strong|u|i|s|script|', '|' . $labelName . '|')== false && '/' . $labelName <> $nextLableName && instr('|/a|/strong|/u|/i|/s|/script|', '|' . $nextLableName . '|')== false ){
                            $endLabelStr= $endLabelStr . Chr(10);
                        }
                    }
                }
                //����ǩ���Ӹ� /   20160615
                if( instr('|br|hr|img|input|param|meta|link|','|' . $labelName . '|')>0 ){
                    $s=$s . ' /';
                }

                $s= $startLabel . $s . $endLabelStr;
                //��Ϊѹ��HTML
                if( instr($action, '|ziphtml|')== false && $isPre== false ){
                    //�������            aaaaa</span>
                    if( $isA== false && $isYes== false && Left($labelName, 1)== '/' && $labelName <> '/script' && $labelName <> '/a' ){
                        //�ų�����    <span>���췢��</span>     �����ж���һ���ֶβ�����vbcrlf����
                        if( '/' . $parentLableName <> $labelName && Right(aspTrim($c), 1) <> Chr(10) ){
                            $s= Chr(10) . $s;
                        }
                    }
                }
                $parentLableName= $labelName;
                $isYes= true;
            }
        }else if( $s <> '' ){
            $isYes= false;
            //call echo("isPre",isPre)
            if( $isPre== false ){
                if( $s== Chr(10) ){
                    if( $isTextarea== false && $isScript== false && $isStyle== false ){
                        $s= '';
                    }else if( $isScript== true ){
                        if( instr($action, '|zipscripthtml|') > 0 ){
                            $s= ' ';
                        }
                    }else if( $isStyle== true ){
                        if( instr($action, '|zipstylehtml|') > 0 ){
                            $s= '';
                        }
                    }else if( $isTextarea== true ){
                        if( instr($action, '|ziptextareahtml|') > 0 ){
                            $s= '';
                        }
                    }else{
                        $s= Chr(10);
                    }
                    // Right(Trim(c), 1) = ">")   Ϊ��ѹ��ʱ�õ�
                }else if( (Right(aspTrim($c), 1)== Chr(10) || Right(aspTrim($c), 1)== '>') && phptrim($s)== '' && $isTextarea== false && $isScript== false ){
                    $s= '';
                }
            }
        }
        $c= $c . $s;
    }
    $c= Replace($c, Chr(10), vbCrlf());
    $formatting= $c;
    return @$formatting;
}

function zipHTML($c){
    $zipHTML= formatting($c, 'ziphtml|zipscripthtml|zipstylehtml'); //ziphtml|zipscripthtml|zipstylehtml|ziptextareahtml
    return @$zipHTML;
}

//���HTML��ǩ�Ƿ�ɶԳ��� �磨<div><ul><li>aa</li></ul></div></div>��
function checkHtmlFormatting( $content){
    $splStr=''; $s=''; $c=''; $splxx=''; $nLable=''; $lableStr ='';
    $content= strtolower($content);
    $splStr= aspSplit('ul|li|dt|dd|dl|div|span', '|');
    foreach( $splStr as $key=>$s){
        $s= phptrim($s);
        if( $s <> '' ){
            $nLable= 0;
            $lableStr= '<' . $s . ' ';
            if( instr($content, $lableStr) > 0 ){
                $splxx= aspSplit($content, $lableStr);
                $nLable= $nLable + UBound($splxx);
            }
            $lableStr= '<' . $s . '>';
            if( instr($content, $lableStr) > 0 ){
                $splxx= aspSplit($content, $lableStr);
                $nLable= $nLable + UBound($splxx);
            }
            $lableStr= '</' . $s . '>';
            if( instr($content, $lableStr) > 0 ){
                $splxx= aspSplit($content, $lableStr);
                $nLable= $nLable - UBound($splxx);
            }
            //call echo(ShowHtml(lableStr),nLable)
            if( $nLable <> 0 ){
                $checkHtmlFormatting= false;
                return @$checkHtmlFormatting;
            }
        }
    }
    $checkHtmlFormatting= true;
    return @$checkHtmlFormatting;
}


?>