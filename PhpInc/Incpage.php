<?PHP
//dim nCount,nPageSize,maxpage,page,x,i,PageControl


//ҳ����  ��¼����  ÿҳ��ʾ��  ��ǰ�� (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl($nRecrodCount, $nPageSize, $nPage, $configPageUrl, $action){
    $s='';$c='';$nCountPage='';$i='';$nDisplay='';$nDispalyOK='';$nTemp='';
    $previousPage='';$nextPage						='';//������һҳ����һҳ
    $isDisplayTip		='';//�Ƿ���ʾ��ʾ��ҳ��Ϣ
    $isDisplayTip=true;

    $sPageStart='';$sPageEnd='';$sHomePage='';$sHomePageFocus='';$sUpPage='';$sUpPageFocus='';$sNextPage='';$sNextPageFocus='';$sForPage='';$sForPageFocus='';$sTailPage='';$sTailPageFocus='';
    if( $action<>'' ){
        $sPageStart=getStrCut($action, '[sPageStart]', '[/sPageStart]', 2);			//ҳͷ����
        $sPageEnd=getStrCut($action, '[sPageEnd]', '[/sPageEnd]', 2);					//ҳβ����
        $sHomePage=getStrCut($action, '[sHomePage]', '[/sHomePage]', 2);	//��ҳ
        $sHomePageFocus=getStrCut($action, '[sHomePageFocus]', '[/sHomePageFocus]', 2);		//��ҳ����
        $sUpPage=getStrCut($action, '[sUpPage]', '[/sUpPage]', 2);						//��һҳ
        $sUpPageFocus=getStrCut($action, '[sUpPageFocus]', '[/sUpPageFocus]', 2);				//��һҳ����
        $sNextPage=getStrCut($action, '[sNextPage]', '[/sNextPage]', 2);				//��һҳ
        $sNextPageFocus=getStrCut($action, '[sNextPageFocus]', '[/sNextPageFocus]', 2);			//��һҳ����
        $sForPage=getStrCut($action, '[sForPage]', '[/sForPage]', 2);							//ѭ��ҳ
        $sForPageFocus=getStrCut($action, '[sForPageFocus]', '[/sForPageFocus]', 2);				//ѭ��ҳ����
        $sTailPage=getStrCut($action, '[sTailPage]', '[/sTailPage]', 2);							//���ҳ
        $sTailPageFocus=getStrCut($action, '[sTailPageFocus]', '[/sTailPageFocus]', 2);			//���ҳ����
    }
    //ҳͷ����
    if( $sPageStart=='' ){
        $sPageStart='<ul class="pagecontrolwrap">' . vbCrlf() . '<li class="pageinfo">��[$nRecrodCount$]�� [$nPage$]/[$nCountPage$]ҳ</li>' . vbCrlf();
    }
    //ҳβ����
    if( $sPageEnd=='' ){
        $sPageEnd='</ul><div class="clear"></div>' . vbCrlf();
    }
    //��ҳ
    if( $sHomePage=='' ){
        $sHomePage='<li class="pageli">��ҳ</li>' . vbCrlf();
    }
    //��ҳ����
    if( $sHomePageFocus=='' ){
        $sHomePageFocus='<li><a href="[$url$]">��ҳ</a></li>' . vbCrlf();
    }
    //��һҳ
    if( $sUpPage=='' ){
        $sUpPage='<li class="pageli">��һҳ</li>' . vbCrlf();
    }
    //��һҳ����
    if( $sUpPageFocus=='' ){
        $sUpPageFocus='<li><a href="[$url$]">��һҳ</a></li>' . vbCrlf();
    }
    //��һҳ
    if( $sNextPage=='' ){
        $sNextPage='<li class="pageli">��һҳ</li>' . vbCrlf();
    }
    //��һҳ����
    if( $sNextPageFocus=='' ){
        $sNextPageFocus='<li><a href="[$url$]">��һҳ</a></li>' . vbCrlf();
    }
    //ѭ��ҳ
    if( $sForPage=='' ){
        $sForPage='<li><a href="[$url$]">[$i$]</a></li>' . vbCrlf();
    }
    //ѭ��ҳ����
    if( $sForPageFocus=='' ){
        $sForPageFocus='<li class="pagefocus">[$i$]</li>' . vbCrlf();
    }
    //���ҳ
    if( $sTailPage=='' ){
        $sTailPage='<li class="pageli">ĩҳ</li>' . vbCrlf();
    }
    //���ҳ����
    if( $sTailPageFocus=='' ){
        $sTailPageFocus='<li><a href="[$url$]">ĩҳ</a></li>' . vbCrlf();
    }

    //����ҳΪ����
    if( $configPageUrl=='' ){
        $configPageUrl=GetUrlAddToParam( GetUrl(),'?page=[id]','replace');
    }

    $nDisplay=6;			//��ʾ��
    $nDispalyOK=0;		//��ʾ�ɹ���
    $nPage=HandleNumberType($nPage);
    if( $nPage=='' ){
        $nPage=1;
    }else{
        $nPage=intval($nPage);
    }
    //�����ҳ��
    $nCountPage=GetCountPage($nRecrodCount,$nPageSize);



    $previousPage=$nPage-1;
    $nextPage=$nPage+1;

    //������һҳ
    if( $previousPage<=0 ){
        $previousPage='';
    }
    //������һҳ
    if( $nextPage>$nCountPage ){
        $nextPage='';
    }

    //ҳ��ʼ
    $c=$sPageStart;
    //��ҳ
    if( $nPage>1 ){
        $c=$c . replace($sHomePageFocus,'[$url$]',replace($configPageUrl,'[id]',''));
    }else if( $isDisplayTip==true ){
        $c=$c . $sHomePage;
    }
    //��һҳ
    if( $previousPage<>'' ){
        $nTemp=$previousPage;
        if( $previousPage<=1 ){
            $nTemp='';
        }
        $c=$c . replace($sUpPageFocus,'[$url$]',replace($configPageUrl,'[id]',$nTemp));
    }else if( $isDisplayTip==true ){
        $c=$c . $sUpPage;
    }


    $n='';
    //call echo(npage,ncountpage)
    $n= ($nPage-3);
    //call echo("n",n)

    //��ҳѭ��
    for( $i= $n ; $i<= $nCountPage; $i++){
        if( $i>=1 ){
            $nDispalyOK=$nDispalyOK+1;
            //call echo(i,nPage)
            if( $i== $nPage ){
                $c=$c . replace($sForPageFocus,'[$i$]',$i);
            }else{
                $nTemp=$i;
                if( $i<=1 ){
                    $nTemp='';
                }
                $c=$c . replace(replace($sForPage,'[$url$]',replace($configPageUrl,'[id]',$nTemp)),'[$i$]',$i);
            }
            if( $nDispalyOK>$nDisplay ){
                break;
            }
        }
    }
    //��һҳ
    if( $nCountPage>$nPage ){
        $c=$c . replace($sNextPageFocus,'[$url$]',replace($configPageUrl,'[id]',$nextPage));
    }else if( $isDisplayTip==true ){
        $c=$c . $sNextPage;
    }
    //ĩҳ
    if( $nCountPage>$nPage ){
        $c=$c . replace($sTailPageFocus,'[$url$]',replace($configPageUrl,'[id]',$nCountPage));
    }else if( $isDisplayTip==true ){
        $c=$c . $sTailPage;
    }

    $c=$c . $sPageEnd;


    $c= replaceValueParam($c, 'nRecrodCount', $nRecrodCount);
    $c= replaceValueParam($c, 'nPage', $nPage);
    if( $nCountPage=='0' ){
        $nCountPage=1;
    }
    $c= replaceValueParam($c, 'nCountPage', $nCountPage);

    $webPageControl=$c . vbCrlf();
    return @$webPageControl;
}


//���Rsҳ��

?>