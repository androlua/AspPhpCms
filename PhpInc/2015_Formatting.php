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

    $levelArray=aspArray(299); $keyWord ='';
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
        $s= TrimVbCrlf($s) ; $lCaseS= lCase($s);
        //�ж���20150710
        if((left($lCaseS, 8)== '<script ' || left($lCaseS, 8)== '<script>') && inStr($s, '</script>')== false && $isJavascript== false ){
            $isJavascript= true;
            $c= $c . PHPTrim($tempS) . vbCrlf();
        }else if( $isJavascript== true ){

            if( left($lCaseS, 9)== '</script>' ){
                $isJavascript= false;
                $c= $c . PHPTrim($tempS) . vbCrlf(); //���������߿ո�
            }else{
                $c= $c . $tempS . vbCrlf(); //Ϊjs����ʾԭ�ı�  ������������߿ո�phptrim(tempS)
            }

            //���ı����ж���20151019
        }else if((left($lCaseS, 10)== '<textarea ' || left($lCaseS, 10)== '<textarea>') && inStr($s, '</textarea>')== false && $isTextarea== false ){
            $isTextarea= true;
            $c= $c . PHPTrim($tempS) . vbCrlf();
        }else if( $isTextarea== true ){
            $c= $c . PHPTrim($tempS) . vbCrlf();
            if( left($lCaseS, 11)== '</textarea>' ){
                $isTextarea= false;
            }
            //���ı����ж���20151019
        }else if((left($lCaseS, 5)== '<pre ' || left($lCaseS, 5)== '<pre>') && inStr($s, '</pre>')== false && $isPre== false ){
            $isPre= true;
            $c= $c . PHPTrim($tempS) . vbCrlf();
        }else if( $isPre== true ){
            $c= $c . $tempS . vbCrlf();
            if( left($lCaseS, 6)== '</pre>' ){
                $isPre= false;
            }


        }else if( $s <> '' && $isJavascript== false && $isTextarea== false ){
            $left4Str= '|' . left($lCaseS, 4) . '|' ; $left5Str= '|' . left($lCaseS, 5) . '|' ; $left6Str= '|' . left($lCaseS, 6) . '|';
            $left7Str= '|' . left($lCaseS, 7) . '|' ; $left8Str= '|' . left($lCaseS, 8) . '|';

            $keyWord= ''; //�ؼ��ʳ�ʼ���
            $lableName= ''; //��ǩ����
            if( inStr('|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |', $left4Str) > 0 ){
                $keyWord= $left4Str;
                $lableName= mid($left4Str, 3, 2);
            }else if( inStr('|<div>|<div |', $left5Str) > 0 ){
                $keyWord= $left5Str;
                $lableName= mid($left5Str, 3, 3);
            }else if( inStr('|<span>|<span |<form>|<form |', $left6Str) > 0 ){
                $keyWord= $left6Str;
                $lableName= mid($left6Str, 3, 4);

            }else if( inStr('|<table>|<table |<tbody>|<tbody |', $left7Str) > 0 ){
                $keyWord= $left7Str;
                $lableName= mid($left7Str, 3, 5);

            }else if( inStr('|<center>|<center |', $left8Str) > 0 ){
                $keyWord= $left8Str;
                $lableName= mid($left8Str, 3, 6);
            }
            $keyWord= aspTrim(replace(replace($keyWord, '<', ''), '>', ''));
            //call echo(KeyWord,lableName)
            //��ʼ
            if( $keyWord <> '' ){
                $s= copyStr('    ', $nLevel) . $s;
                if( right($lCaseS, 3 + len($lableName)) <> '</' . $lableName . '>' && inStr($lCaseS, '</' . $lableName . '>')== false ){
                    $nLevel= $nLevel + 1;
                    if( $nLevel >= 0 ){
                        $levelArray[$nLevel]= $keyWord;
                    }
                }
            }else if( inStr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|', '|' . left($lCaseS, 5) . '|') > 0 || inStr('|</div>|', '|' . left($lCaseS, 6) . '|') > 0 || inStr('|</span>|</form>|', '|' . left($lCaseS, 7) . '|') > 0 || inStr('|</table>|</tbody>|', '|' . left($lCaseS, 8) . '|') > 0 || inStr('|</center>|', '|' . left($lCaseS, 9) . '|') > 0 ){
                $nLevel= $nLevel - 1;
                $s= copyStr('    ', $nLevel) . $s;
            }else{
                $s= copyStr('    ', $nLevel) . $s;
                //����ǽ�����ǩ���һ��
                if( right($lCaseS, 6)== '</div>' ){
                    if( checkHtmlFormatting($lCaseS)== false ){
                        $s= left($s, len($s) - 6);
                        $nLevel= $nLevel - 1;
                        $s= $s . vbCrlf() . copyStr('    ', $nLevel) . '</div>';
                    }
                }else if( right($lCaseS, 7)== '</span>' ){
                    if( checkHtmlFormatting($lCaseS)== false ){
                        $s= left($s, len($s) - 7);
                        $nLevel= $nLevel - 1;
                        $s= $s . vbCrlf() . copyStr('    ', $nLevel) . '</span>';
                    }
                }else if( inStr('|</ul>|</dt>|<dl>|<dd>|', $left5Str) > 0 ){
                    $s= left($s, len($s) - 5);
                    $nLevel= $nLevel - 1;
                    $s= $s . vbCrlf() . copyStr('    ', $nLevel) . right($lCaseS, 5);
                }


                //��   aaa</li>   ���ֽ�����   20160106
                $elseS= PHPTrim(lCase($elseS));
                if( inStr($elseS, '</') > 0 ){
                    $elseLable= mid($elseS, inStr($elseS, '</'),-1);
                    if( inStr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|', '|' . $elseLable . '|') > 0 && $nLevel > 0 ){
                        $nLevel= $nLevel - 1;
                    }
                }
                //call echo("s",replace(s,"<","&lt;"))


            }
            //call echo("",ShowHtml(temps)
            $c= $c . $s . vbCrlf();
        }else if( $s== '' ){
            if( inStr($action, '|delblankline|')== false && inStr($action, '|ɾ������|')== false ){//ɾ������
                $c= $c . vbCrlf();
            }
        }
    }
    $handleHtmlFormatting= $c;
    $nErrLevel= $nLevel; //��ô��󼶱�
    if( $nLevel <> 0 &&(lCase($isMsgBox)== '1' || lCase($isMsgBox)== 'true') ){
        aspEcho('HTML��ǩ�д���', $nLevel);
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
    $content= replace(replace($content, vbCrlf(), chr(10)), vbTab(), '    ');

    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        $endStr= mid($content, $i,-1);
        if( $s== '<' ){
            if( inStr($endStr, '>') > 0 ){
                $s= mid($endStr, 1, inStr($endStr, '>'));
                $i= $i + len($s) - 1;
                $s= mid($s, 2, len($s) - 2);
                if( right($s, 1)== '/' ){
                    $s= PHPTrim(left($s, len($s) - 1));
                }
                $endStr= right($endStr, len($endStr) - len($s) - 2); //����ַ���ȥ��ǰ��ǩ  -2����Ϊ����<>�����ַ�
                //ע��֮ǰ����labelName����
                $labelName= mid($s, 1, inStr($s . ' ', ' ') - 1);
                $labelName= lCase($labelName);

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
                if( inStr($action, '|ziphtml|')== false && $isPre== false ){
                    if( $isA== false ){
                        if( inStr('|a|strong|u|i|s|script|', '|' . $labelName . '|')== false && '/' . $labelName <> $nextLableName && inStr('|/a|/strong|/u|/i|/s|/script|', '|' . $nextLableName . '|')== false ){
                            $endLabelStr= $endLabelStr . chr(10);
                        }
                    }
                }
                //����ǩ���Ӹ� /   20160615
                if( inStr('|br|hr|img|input|param|meta|link|','|' . $labelName . '|')>0 ){
                    $s=$s . ' /';
                }

                $s= $startLabel . $s . $endLabelStr;
                //��Ϊѹ��HTML
                if( inStr($action, '|ziphtml|')== false && $isPre== false ){
                    //�������            aaaaa</span>
                    if( $isA== false && $isYes== false && left($labelName, 1)== '/' && $labelName <> '/script' && $labelName <> '/a' ){
                        //�ų�����    <span>���췢��</span>     �����ж���һ���ֶβ�����vbcrlf����
                        if( '/' . $parentLableName <> $labelName && right(aspTrim($c), 1) <> chr(10) ){
                            $s= chr(10) . $s;
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
                if( $s== chr(10) ){
                    if( $isTextarea== false && $isScript== false && $isStyle== false ){
                        $s= '';
                    }else if( $isScript== true ){
                        if( inStr($action, '|zipscripthtml|') > 0 ){
                            $s= ' ';
                        }
                    }else if( $isStyle== true ){
                        if( inStr($action, '|zipstylehtml|') > 0 ){
                            $s= '';
                        }
                    }else if( $isTextarea== true ){
                        if( inStr($action, '|ziptextareahtml|') > 0 ){
                            $s= '';
                        }
                    }else{
                        $s= chr(10);
                    }
                    // Right(Trim(c), 1) = ">")   Ϊ��ѹ��ʱ�õ�
                }else if( (right(aspTrim($c), 1)== chr(10) || right(aspTrim($c), 1)== '>') && PHPTrim($s)== '' && $isTextarea== false && $isScript== false ){
                    $s= '';
                }
            }
        }
        $c= $c . $s;
    }
    $c= replace($c, chr(10), vbCrlf());
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
    $content= lCase($content);
    $splStr= aspSplit('ul|li|dt|dd|dl|div|span', '|');
    foreach( $splStr as $key=>$s){
        $s= PHPTrim($s);
        if( $s <> '' ){
            $nLable= 0;
            $lableStr= '<' . $s . ' ';
            if( inStr($content, $lableStr) > 0 ){
                $splxx= aspSplit($content, $lableStr);
                $nLable= $nLable + uBound($splxx);
            }
            $lableStr= '<' . $s . '>';
            if( inStr($content, $lableStr) > 0 ){
                $splxx= aspSplit($content, $lableStr);
                $nLable= $nLable + uBound($splxx);
            }
            $lableStr= '</' . $s . '>';
            if( inStr($content, $lableStr) > 0 ){
                $splxx= aspSplit($content, $lableStr);
                $nLable= $nLable - uBound($splxx);
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