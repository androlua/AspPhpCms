<?PHP
//dim nCount,nPageSize,maxpage,page,x,i,PageControl


//ҳ����  ��¼����  ÿҳ��ʾ��  ��ǰ�� (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl($nRecrodCount, $nPageSize, $nPage, $configPageUrl, $action){
    $c=''; $nCountPage=''; $i=''; $nDisplay=''; $nDispalyOK=''; $nTemp=''; $cPages=''; $url='';$selStr='';
    $previousPage=''; $nextPage ='';//������һҳ����һҳ
    $isDisplayTip ='';//�Ƿ���ʾ��ʾ��ҳ��Ϣ
    $isDisplayTip= true;

    $sPageStart=''; $sPageEnd=''; $sHomePage=''; $sHomePageFocus=''; $sUpPage=''; $sUpPageFocus=''; $sNextPage=''; $sNextPageFocus=''; $sForPage=''; $sForPageFocus=''; $sTailPage=''; $sTailPageFocus ='';
    if( $action <> '' ){
        $sPageStart= getStrCut($action, '[sPageStart]', '[/sPageStart]', 2); //ҳͷ����
        $sPageEnd= getStrCut($action, '[sPageEnd]', '[/sPageEnd]', 2); //ҳβ����
        $sHomePage= getStrCut($action, '[sHomePage]', '[/sHomePage]', 2); //��ҳ
        $sHomePageFocus= getStrCut($action, '[sHomePageFocus]', '[/sHomePageFocus]', 2); //��ҳ����
        $sUpPage= getStrCut($action, '[sUpPage]', '[/sUpPage]', 2); //��һҳ
        $sUpPageFocus= getStrCut($action, '[sUpPageFocus]', '[/sUpPageFocus]', 2); //��һҳ����
        $sNextPage= getStrCut($action, '[sNextPage]', '[/sNextPage]', 2); //��һҳ
        $sNextPageFocus= getStrCut($action, '[sNextPageFocus]', '[/sNextPageFocus]', 2); //��һҳ����
        $sForPage= getStrCut($action, '[sForPage]', '[/sForPage]', 2); //ѭ��ҳ
        $sForPageFocus= getStrCut($action, '[sForPageFocus]', '[/sForPageFocus]', 2); //ѭ��ҳ����
        $sTailPage= getStrCut($action, '[sTailPage]', '[/sTailPage]', 2); //���ҳ
        $sTailPageFocus= getStrCut($action, '[sTailPageFocus]', '[/sTailPageFocus]', 2); //���ҳ����


    }
    //ҳͷ����
    if( $sPageStart== '' ){
        $sPageStart= '<ul class="pagecontrolwrap">' . vbCrlf() . '<li class="pageinfo">��[$nRecrodCount$]�� [$nPage$]/[$nCountPage$]ҳ</li>' . vbCrlf();
    }
    //ҳβ����
    if( $sPageEnd== '' ){
        $sPageEnd= '</ul><div class="clear"></div>' . vbCrlf();
    }
    //��ҳ
    if( $sHomePage== '' ){
        $sHomePage= '<li><a href="[$url$]">��ҳ</a></li>' . vbCrlf();
    }
    //��ҳ����
    if( $sHomePageFocus== '' ){
        $sHomePageFocus= '<li class="pageli">��ҳ</li>' . vbCrlf();
    }
    //��һҳ
    if( $sUpPage== '' ){
        $sUpPage= '<li><a href="[$url$]">��һҳ</a></li>' . vbCrlf();
    }
    //��һҳ����
    if( $sUpPageFocus== '' ){
        $sUpPageFocus= '<li class="pageli">��һҳ</li>' . vbCrlf();
    }
    //��һҳ
    if( $sNextPage== '' ){
        $sNextPage= '<li><a href="[$url$]">��һҳ</a></li>' . vbCrlf();
    }
    //��һҳ����
    if( $sNextPageFocus== '' ){
        $sNextPageFocus= '<li class="pageli">��һҳ</li>' . vbCrlf();
    }
    //ѭ��ҳ
    if( $sForPage== '' ){
        $sForPage= '<li class="pagefocus">[$i$]</li>' . vbCrlf();
    }
    //ѭ��ҳ����
    if( $sForPageFocus== '' ){
        $sForPageFocus= '<li><a href="[$url$]">[$i$]</a></li>' . vbCrlf();
    }
    //���ҳ
    if( $sTailPage== '' ){
        $sTailPage= '<li><a href="[$url$]">ĩҳ</a></li>' . vbCrlf();
    }
    //���ҳ����
    if( $sTailPageFocus== '' ){
        $sTailPageFocus= '<li class="pageli">ĩҳ</li>' . vbCrlf();
    }
    //����ʱ�õ�20160630
    if( 1== 2 ){
        $c= '[sPageStart]' . vbCrlf() . $sPageStart . '[/sPageStart]' . vbCrlf() . vbCrlf();
        $c= $c . '[sHomePage]' . vbCrlf() . $sHomePage . '[/sHomePage]' . vbCrlf() . vbCrlf();
        $c= $c . '[sHomePageFocus]' . vbCrlf() . $sHomePageFocus . '[/sHomePageFocus]' . vbCrlf() . vbCrlf();

        $c= $c . '[sUpPage]' . vbCrlf() . $sUpPage . '[/sUpPage]' . vbCrlf() . vbCrlf();
        $c= $c . '[sUpPageFocus]' . vbCrlf() . $sUpPageFocus . vbCrlf() . '[/sUpPageFocus]' . vbCrlf();


        $c= $c . '[sForPage]' . vbCrlf() . $sForPage . '[/sForPage]' . vbCrlf() . vbCrlf();
        $c= $c . '[sForPageFocus]' . vbCrlf() . $sForPageFocus . '[/sForPageFocus]' . vbCrlf() . vbCrlf();


        $c= $c . '[sNextPage]' . vbCrlf() . $sNextPage . '[/sNextPage]' . vbCrlf() . vbCrlf();
        $c= $c . '[sNextPageFocus]' . vbCrlf() . $sNextPageFocus . '[/sNextPageFocus]' . vbCrlf() . vbCrlf();

        $c= $c . '[sTailPage]' . vbCrlf() . $sTailPage . '[/sTailPage]' . vbCrlf() . vbCrlf();
        $c= $c . '[sTailPageFocus]' . vbCrlf() . $sTailPageFocus . '[/sTailPageFocus]' . vbCrlf() . vbCrlf();
        $c= $c . '[sPageEnd]' . vbCrlf() . $sPageEnd . '[/sPageEnd]' . vbCrlf();
        rwend('[page]' . vbCrlf() . vbCrlf() . $c . vbCrlf() . '[/page]');
    }
    //����ҳΪ����
    if( $configPageUrl== '' ){
        $configPageUrl= getUrlAddToParam(getUrl(), '?page=[id]', 'replace');
    }

    $nDisplay= 6; //��ʾ��
    $nDispalyOK= 0; //��ʾ�ɹ���
    $nPage= handleNumberType($nPage);
    if( $nPage== '' ){
        $nPage= 1;
    }else{
        $nPage= intval($nPage);
    }
    //�����ҳ��
    $nCountPage= getCountPage($nRecrodCount, $nPageSize);



    $previousPage= $nPage - 1;
    $nextPage= $nPage + 1;

    //������һҳ
    if( $previousPage <= 0 ){
        $previousPage= '';
    }
    //������һҳ
    if( $nextPage > $nCountPage ){
        $nextPage= '';
    }

    //ҳ��ʼ
    $c= $sPageStart;
    //��ҳ
    if( $nPage > 1 ){
        $c= $c . Replace($sHomePage, '[$url$]', Replace($configPageUrl, '[id]', ''));
    }else if( $isDisplayTip== true ){
        $c= $c . $sHomePageFocus;
    }
    //��һҳ
    if( $previousPage <> '' ){
        $nTemp= $previousPage;
        if( $previousPage <= 1 ){
            $nTemp= '';
        }
        $c= $c . Replace($sUpPage, '[$url$]', Replace($configPageUrl, '[id]', $nTemp));
    }else if( $isDisplayTip== true ){
        $c= $c . $sUpPageFocus;
    }


    $n ='';
    //call echo(npage,ncountpage)
    $n=($nPage - 3);
    //call echo("n",n)

    //��ҳѭ��
    for( $i= $n ; $i<= $nCountPage; $i++){
        if( $i >= 1 ){
            $nDispalyOK= $nDispalyOK + 1;
            //call echo(i,nPage)
            if( $i== $nPage ){
                $c= $c . Replace($sForPage, '[$i$]', $i);
            }else{
                $nTemp= $i;
                if( $i <= 1 ){
                    $nTemp= '';
                }
                $c= $c . Replace(Replace($sForPageFocus, '[$url$]', Replace($configPageUrl, '[id]', $nTemp)), '[$i$]', $i);
            }
            if( $nDispalyOK > $nDisplay ){
                break;
            }
        }
    }
    //��һҳ
    if( $nCountPage > $nPage ){
        $c= $c . Replace($sNextPage, '[$url$]', Replace($configPageUrl, '[id]', $nextPage));
    }else if( $isDisplayTip== true ){
        $c= $c . $sNextPageFocus;
    }
    //ĩҳ
    if( $nCountPage > $nPage ){
        $c= $c . Replace($sTailPage, '[$url$]', Replace($configPageUrl, '[id]', $nCountPage));
    }else if( $isDisplayTip== true ){
        $c= $c . $sTailPageFocus;
    }

    $c= $c . $sPageEnd;


    $c= replaceValueParam($c, 'nRecrodCount', $nRecrodCount);
    $c= replaceValueParam($c, 'nPage', $nPage);
    if( $nCountPage== '0' ){
        $nCountPage= 1;
    }
    $c= replaceValueParam($c, 'nCountPage', $nCountPage);

    if( instr($c, '[$page-select-openlist$]') > 0 ){
        for( $i= 1 ; $i<= $nCountPage; $i++){
            $url= Replace($configPageUrl, '[id]', $i);
            $selStr='';
            if( $i==$nPage ){
                $selStr=' selected';
            }
            $cPages= $cPages . '<option value="' . $url . '"'. $selStr .'>' . $i . '</option>' . vbCrlf();
        }
        $c= Replace($c, '[$page-select-openlist$]', $cPages);
    }

    $webPageControl= $c . vbCrlf();
    return @$webPageControl;
}


//���Rsҳ��

?>