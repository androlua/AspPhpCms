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
//��ʽ��20150212


//Html��ʽ�� �򵥰� ��ǿ��2014 12 09��20150709
function htmlFormatting($content){
    $htmlFormatting = HandleHtmlFormatting($content, false, 0, '') ;
    return @$htmlFormatting;
}
//�����ʽ��
function handleHtmlFormatting( $content, $isMsgBox, $nErrLevel, $action){
    $splStr=''; $s=''; $tempS=''; $lCaseS=''; $c=''; $left4Str=''; $left5Str=''; $left6Str=''; $left7Str=''; $left8Str='';
    $nLevel ='';//����
    $elseS='';$elseLable='';

    $levelArray=array(299); $keyWord ='';
    $lableName ='';//��ǩ����
    $isJavascript ='';//Ϊjavascript
    $isTextarea ='';//Ϊ���ı���<textarea
    $isPre																		='';//Ϊpre
    $isJavascript = false ;//Ĭ��javascriptΪ��
    $isTextarea = false ;//���ļ���Ϊ��
    $isPre=false																		;//Ĭ��preΪ��
    $nLevel = 0 ;//������

    $action = '|' . $action . '|' ;//����
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        $tempS = $s;$elseS=$s;
        $s = TrimVbCrlf($s) ; $lCaseS = LCase($s) ;
        //�ж���20150710
        if((substr($lCaseS, 0 , 8) == '<script ' || substr($lCaseS, 0 , 8) == '<script>') && instr($s, '</script>') == false && $isJavascript == false ){
            $isJavascript = true ;
            $c = $c . phptrim($tempS) . "\n" ;
        }else if( $isJavascript == true ){

            if( substr($lCaseS, 0 , 9) == '</script>' ){
                $isJavascript = false ;
                $c = $c . phptrim($tempS) . "\n" ;//���������߿ո�
            }else{
                $c = $c . $tempS . "\n" ;//Ϊjs����ʾԭ�ı�  ������������߿ո�phptrim(tempS)
            }

            //���ı����ж���20151019
        }else if((substr($lCaseS, 0 , 10) == '<textarea ' || substr($lCaseS, 0 , 10) == '<textarea>') && instr($s, '</textarea>') == false && $isTextarea == false ){
            $isTextarea = true ;
            $c = $c . phptrim($tempS) . "\n" ;
        }else if( $isTextarea == true ){
            $c = $c . phptrim($tempS) . "\n" ;
            if( substr($lCaseS, 0 , 11) == '</textarea>' ){
                $isTextarea = false ;
            }
            //���ı����ж���20151019
        }else if((substr($lCaseS, 0 , 5) == '<pre ' || substr($lCaseS, 0 , 5) == '<pre>') && instr($s, '</pre>') == false && $isPre == false ){
            $isPre = true ;
            $c = $c . phptrim($tempS) . "\n" ;
        }else if( $isPre == true ){
            $c = $c . $tempS . "\n" ;
            if( substr($lCaseS, 0 , 6) == '</pre>' ){
                $isPre = false ;
            }


        }else if( $s <> '' && $isJavascript == false && $isTextarea == false ){
            $left4Str = '|' . substr($lCaseS, 0 , 4) . '|' ; $left5Str = '|' . substr($lCaseS, 0 , 5) . '|' ; $left6Str = '|' . substr($lCaseS, 0 , 6) . '|' ;
            $left7Str = '|' . substr($lCaseS, 0 , 7) . '|' ; $left8Str = '|' . substr($lCaseS, 0 , 8) . '|' ;

            $keyWord = '' ;//�ؼ��ʳ�ʼ���
            $lableName = '' ;//��ǩ����
            if( instr('|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |', $left4Str) > 0 ){
                $keyWord = $left4Str ;
                $lableName = mid($left4Str, 3, 2) ;
            }else if( instr('|<div>|<div |', $left5Str) > 0 ){
                $keyWord = $left5Str ;
                $lableName = mid($left5Str, 3, 3) ;
            }else if( instr('|<span>|<span |<form>|<form |', $left6Str) > 0 ){
                $keyWord = $left6Str ;
                $lableName = mid($left6Str, 3, 4) ;

            }else if( instr('|<table>|<table |<tbody>|<tbody |', $left7Str) > 0 ){
                $keyWord = $left7Str ;
                $lableName = mid($left7Str, 3, 5) ;

            }else if( instr('|<center>|<center |', $left8Str) > 0 ){
                $keyWord = $left8Str ;
                $lableName = mid($left8Str, 3, 6);
            }
            $keyWord = AspTrim(Replace(Replace($keyWord, '<', ''), '>', '')) ;
            //call echo(KeyWord,lableName)
            //��ʼ
            if( $keyWord <> '' ){
                $s = CopyStr('    ', $nLevel) . $s ;
                if( substr($lCaseS, - 3 + strlen($lableName)) <> '</' . $lableName . '>' && instr($lCaseS, '</' . $lableName . '>') == false ){
                    $nLevel = $nLevel + 1 ;
                    if( $nLevel >= 0 ){
                        $levelArray[$nLevel] = $keyWord ;
                    }
                }
            }else if( instr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|', '|' . substr($lCaseS, 0 , 5) . '|') > 0 || instr('|</div>|', '|' . substr($lCaseS, 0 , 6) . '|') > 0 || instr('|</span>|</form>|', '|' . substr($lCaseS, 0 , 7) . '|') > 0 || instr('|</table>|</tbody>|', '|' . substr($lCaseS, 0 , 8) . '|') > 0 || instr('|</center>|', '|' . substr($lCaseS, 0 , 9) . '|') > 0 ){
                $nLevel = $nLevel - 1 ;
                $s = CopyStr('    ', $nLevel) . $s ;
            }else{
                $s = CopyStr('    ', $nLevel) . $s ;
                //����ǽ�����ǩ���һ��
                if( substr($lCaseS, - 6) == '</div>' ){
                    if( checkHtmlFormatting($lCaseS) == false ){
                        $s = substr($s, 0 , strlen($s) - 6) ;
                        $nLevel = $nLevel - 1 ;
                        $s = $s . "\n" . CopyStr('    ', $nLevel) . '</div>' ;
                    }
                }else if( substr($lCaseS, - 7) == '</span>' ){
                    if( checkHtmlFormatting($lCaseS) == false ){
                        $s = substr($s, 0 , strlen($s) - 7) ;
                        $nLevel = $nLevel - 1 ;
                        $s = $s . "\n" . CopyStr('    ', $nLevel) . '</span>' ;
                    }
                }else if( instr('|</ul>|</dt>|<dl>|<dd>|', $left5Str) > 0 ){
                    $s = substr($s, 0 , strlen($s) - 5) ;
                    $nLevel = $nLevel - 1 ;
                    $s = $s . "\n" . CopyStr('    ', $nLevel) . substr($lCaseS, - 5) ;
                }


                //��   aaa</li>   ���ֽ�����   20160106
                $elseS=phptrim(lcase($elseS));
                if( instr($elseS,'</')>0 ){
                    $elseLable=mid($elseS,instr($elseS,'</'),-1);
                    if( instr('|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|', '|' . $elseLable . '|') > 0 && $nLevel>0 ){
                        $nLevel = $nLevel - 1 ;
                    }
                }
                //call echo("s",replace(s,"<","&lt;"))


            }
            //call echo("",ShowHtml(temps)
            $c = $c . $s . "\n" ;
        }else if( $s == '' ){
            if( instr($action, '|delblankline|') == false && instr($action, '|ɾ������|') == false ){//ɾ������
                $c = $c . "\n" ;
            }
        }
    }
    $handleHtmlFormatting = $c ;
    $nErrLevel = $nLevel ;//��ô��󼶱�
    if( $nLevel <> 0 &&(LCase($isMsgBox) == '1' || LCase($isMsgBox) == 'true') ){
        ASPEcho('HTML��ǩ�д���', $nLevel) ;
    }
    //Call Echo("nLevel",nLevel & "," & levelArray(nLevel))                '��ʾ�������20150212
    return @$handleHtmlFormatting;
}


//���HTML��ǩ�Ƿ�ɶԳ��� �磨<div><ul><li>aa</li></ul></div></div>��
function checkHtmlFormatting( $content){
    $splStr=''; $s=''; $c=''; $splxx=''; $nLable=''; $lableStr ='';
    $content = LCase($content) ;
    $splStr = aspSplit('ul|li|dt|dd|dl|div|span', '|') ;
    foreach( $splStr as $s){
        $s = phptrim($s) ;
        if( $s <> '' ){
            $nLable = 0 ;
            $lableStr = '<' . $s . ' ' ;
            if( instr($content, $lableStr) > 0 ){
                $splxx = aspSplit($content, $lableStr) ;
                $nLable = $nLable + UBound($splxx) ;
            }
            $lableStr = '<' . $s . '>' ;
            if( instr($content, $lableStr) > 0 ){
                $splxx = aspSplit($content, $lableStr) ;
                $nLable = $nLable + UBound($splxx) ;
            }
            $lableStr = '</' . $s . '>' ;
            if( instr($content, $lableStr) > 0 ){
                $splxx = aspSplit($content, $lableStr) ;
                $nLable = $nLable - UBound($splxx) ;
            }
            //call echo(ShowHtml(lableStr),nLable)
            if( $nLable <> 0 ){
                $checkHtmlFormatting = false ;
                return @$checkHtmlFormatting;
            }
        }
    }
    $checkHtmlFormatting = true ;
    return @$checkHtmlFormatting;
}

?>