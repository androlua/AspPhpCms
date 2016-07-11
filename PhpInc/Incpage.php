<?PHP
//dim nCount,nPageSize,maxpage,page,x,i,PageControl


//页控制  记录总数  每页显示数  当前面 (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl($nRecrodCount, $nPageSize, $nPage, $configPageUrl, $action){
    $c=''; $nCountPage=''; $i=''; $nDisplay=''; $nDispalyOK=''; $nTemp=''; $cPages=''; $url='';$selStr='';
    $previousPage=''; $nextPage ='';//定义上一页，下一页
    $isDisplayTip ='';//是否显示提示翻页信息
    $isDisplayTip= true;

    $sPageStart=''; $sPageEnd=''; $sHomePage=''; $sHomePageFocus=''; $sUpPage=''; $sUpPageFocus=''; $sNextPage=''; $sNextPageFocus=''; $sForPage=''; $sForPageFocus=''; $sTailPage=''; $sTailPageFocus ='';
    if( $action <> '' ){
        $sPageStart= getStrCut($action, '[sPageStart]', '[/sPageStart]', 2); //页头部分
        $sPageEnd= getStrCut($action, '[sPageEnd]', '[/sPageEnd]', 2); //页尾部分
        $sHomePage= getStrCut($action, '[sHomePage]', '[/sHomePage]', 2); //首页
        $sHomePageFocus= getStrCut($action, '[sHomePageFocus]', '[/sHomePageFocus]', 2); //首页交点
        $sUpPage= getStrCut($action, '[sUpPage]', '[/sUpPage]', 2); //上一页
        $sUpPageFocus= getStrCut($action, '[sUpPageFocus]', '[/sUpPageFocus]', 2); //上一页交点
        $sNextPage= getStrCut($action, '[sNextPage]', '[/sNextPage]', 2); //下一页
        $sNextPageFocus= getStrCut($action, '[sNextPageFocus]', '[/sNextPageFocus]', 2); //下一页交点
        $sForPage= getStrCut($action, '[sForPage]', '[/sForPage]', 2); //循环页
        $sForPageFocus= getStrCut($action, '[sForPageFocus]', '[/sForPageFocus]', 2); //循环页交点
        $sTailPage= getStrCut($action, '[sTailPage]', '[/sTailPage]', 2); //最后页
        $sTailPageFocus= getStrCut($action, '[sTailPageFocus]', '[/sTailPageFocus]', 2); //最后页交点


    }
    //页头部分
    if( $sPageStart== '' ){
        $sPageStart= '<ul class="pagecontrolwrap">' . vbCrlf() . '<li class="pageinfo">共[$nRecrodCount$]条 [$nPage$]/[$nCountPage$]页</li>' . vbCrlf();
    }
    //页尾部分
    if( $sPageEnd== '' ){
        $sPageEnd= '</ul><div class="clear"></div>' . vbCrlf();
    }
    //首页
    if( $sHomePage== '' ){
        $sHomePage= '<li><a href="[$url$]">首页</a></li>' . vbCrlf();
    }
    //首页交点
    if( $sHomePageFocus== '' ){
        $sHomePageFocus= '<li class="pageli">首页</li>' . vbCrlf();
    }
    //上一页
    if( $sUpPage== '' ){
        $sUpPage= '<li><a href="[$url$]">上一页</a></li>' . vbCrlf();
    }
    //上一页交点
    if( $sUpPageFocus== '' ){
        $sUpPageFocus= '<li class="pageli">上一页</li>' . vbCrlf();
    }
    //下一页
    if( $sNextPage== '' ){
        $sNextPage= '<li><a href="[$url$]">下一页</a></li>' . vbCrlf();
    }
    //下一页交点
    if( $sNextPageFocus== '' ){
        $sNextPageFocus= '<li class="pageli">下一页</li>' . vbCrlf();
    }
    //循环页
    if( $sForPage== '' ){
        $sForPage= '<li class="pagefocus">[$i$]</li>' . vbCrlf();
    }
    //循环页交点
    if( $sForPageFocus== '' ){
        $sForPageFocus= '<li><a href="[$url$]">[$i$]</a></li>' . vbCrlf();
    }
    //最后页
    if( $sTailPage== '' ){
        $sTailPage= '<li><a href="[$url$]">末页</a></li>' . vbCrlf();
    }
    //最后页交点
    if( $sTailPageFocus== '' ){
        $sTailPageFocus= '<li class="pageli">末页</li>' . vbCrlf();
    }
    //测试时用到20160630
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
    //配置页为空则
    if( $configPageUrl== '' ){
        $configPageUrl= getUrlAddToParam(getUrl(), '?page=[id]', 'replace');
    }

    $nDisplay= 6; //显示数
    $nDispalyOK= 0; //显示成功数
    $nPage= handleNumberType($nPage);
    if( $nPage== '' ){
        $nPage= 1;
    }else{
        $nPage= intval($nPage);
    }
    //获得总页数
    $nCountPage= getCountPage($nRecrodCount, $nPageSize);



    $previousPage= $nPage - 1;
    $nextPage= $nPage + 1;

    //处理上一页
    if( $previousPage <= 0 ){
        $previousPage= '';
    }
    //处理下一页
    if( $nextPage > $nCountPage ){
        $nextPage= '';
    }

    //页开始
    $c= $sPageStart;
    //首页
    if( $nPage > 1 ){
        $c= $c . Replace($sHomePage, '[$url$]', Replace($configPageUrl, '[id]', ''));
    }else if( $isDisplayTip== true ){
        $c= $c . $sHomePageFocus;
    }
    //上一页
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

    //翻页循环
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
    //下一页
    if( $nCountPage > $nPage ){
        $c= $c . Replace($sNextPage, '[$url$]', Replace($configPageUrl, '[id]', $nextPage));
    }else if( $isDisplayTip== true ){
        $c= $c . $sNextPageFocus;
    }
    //末页
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


//获得Rs页数

?>