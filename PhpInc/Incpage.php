<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-24
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By 云端 
************************************************************/
?>
<?PHP
//dim nCount,nPageSize,maxpage,page,x,i,PageControl


//页控制  记录总数  每页显示数  当前面 (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl($nRecrodCount, $nPageSize, $nPage, $configPageUrl, $action){
    $s='';$c='';$nCountPage='';$i='';$nDisplay='';$nDispalyOK='';$nTemp='';
    $previousPage='';$nextPage						='';//定义上一页，下一页
    $isDisplayTip		='';//是否显示提示翻页信息
    $isDisplayTip=true;

    $sPageStart='';$sPageEnd='';$sHomePage='';$sHomePageFocus='';$sUpPage='';$sUpPageFocus='';$sNextPage='';$sNextPageFocus='';$sForPage='';$sForPageFocus='';$sTailPage='';$sTailPageFocus='';
    if( $action<>'' ){
        $sPageStart=getStrCut($action, '[sPageStart]', '[/sPageStart]', 2)			;//页头部分
        $sPageEnd=getStrCut($action, '[sPageEnd]', '[/sPageEnd]', 2)					;//页尾部分
        $sHomePage=getStrCut($action, '[sHomePage]', '[/sHomePage]', 2)	;//首页
        $sHomePageFocus=getStrCut($action, '[sHomePageFocus]', '[/sHomePageFocus]', 2)		;//首页交点
        $sUpPage=getStrCut($action, '[sUpPage]', '[/sUpPage]', 2)						;//上一页
        $sUpPageFocus=getStrCut($action, '[sUpPageFocus]', '[/sUpPageFocus]', 2)				;//上一页交点
        $sNextPage=getStrCut($action, '[sNextPage]', '[/sNextPage]', 2)				;//下一页
        $sNextPageFocus=getStrCut($action, '[sNextPageFocus]', '[/sNextPageFocus]', 2)			;//下一页交点
        $sForPage=getStrCut($action, '[sForPage]', '[/sForPage]', 2)							;//循环页
        $sForPageFocus=getStrCut($action, '[sForPageFocus]', '[/sForPageFocus]', 2)				;//循环页交点
        $sTailPage=getStrCut($action, '[sTailPage]', '[/sTailPage]', 2)							;//最后页
        $sTailPageFocus=getStrCut($action, '[sTailPageFocus]', '[/sTailPageFocus]', 2)			;//最后页交点
    }
    //页头部分
    if( $sPageStart=='' ){
        $sPageStart='<ul class="pagecontrolwrap">' . "\n" . '<li class="pageinfo">共[$nRecrodCount$]条 [$nPage$]/[$nCountPage$]页</li>' . "\n";
    }
    //页尾部分
    if( $sPageEnd=='' ){
        $sPageEnd='</ul><div class="clear"></div>' . "\n";
    }
    //首页
    if( $sHomePage=='' ){
        $sHomePage='<li class="pageli">首页</li>' . "\n";
    }
    //首页交点
    if( $sHomePageFocus=='' ){
        $sHomePageFocus='<li><a href="[$url$]">首页</a></li>' . "\n";
    }
    //上一页
    if( $sUpPage=='' ){
        $sUpPage='<li class="pageli">上一页</li>' . "\n";
    }
    //上一页交点
    if( $sUpPageFocus=='' ){
        $sUpPageFocus='<li><a href="[$url$]">上一页</a></li>' . "\n";
    }
    //下一页
    if( $sNextPage=='' ){
        $sNextPage='<li class="pageli">下一页</li>' . "\n";
    }
    //下一页交点
    if( $sNextPageFocus=='' ){
        $sNextPageFocus='<li><a href="[$url$]">下一页</a></li>' . "\n";
    }
    //循环页
    if( $sForPage=='' ){
        $sForPage='<li><a href="[$url$]">[$i$]</a></li>' . "\n";
    }
    //循环页交点
    if( $sForPageFocus=='' ){
        $sForPageFocus='<li class="pagefocus">[$i$]</li>' . "\n";
    }
    //最后页
    if( $sTailPage=='' ){
        $sTailPage='<li class="pageli">末页</li>' . "\n";
    }
    //最后页交点
    if( $sTailPageFocus=='' ){
        $sTailPageFocus='<li><a href="[$url$]">末页</a></li>' . "\n" ;
    }

    //配置页为空则
    if( $configPageUrl=='' ){
        $configPageUrl=GetUrlAddToParam( GetUrl(),'?page=[id]','replace');
    }

    $nDisplay=6			;//显示数
    $nDispalyOK=0		;//显示成功数
    $nPage=HandleNumberType($nPage);
    if( $nPage=='' ){
        $nPage=1;
    }else{
        $nPage=intval($nPage);
    }
    //获得总页数
    $nCountPage=GetCountPage($nRecrodCount,$nPageSize);



    $previousPage=$nPage-1;
    $nextPage=$nPage+1;

    //处理上一页
    if( $previousPage<=0 ){
        $previousPage='';
    }
    //处理下一页
    if( $nextPage>$nCountPage ){
        $nextPage='';
    }

    //页开始
    $c=$sPageStart ;
    //首页
    if( $nPage>1 ){
        $c=$c . replace($sHomePageFocus,'[$url$]',replace($configPageUrl,'[id]',''));
    }else if( $isDisplayTip==true ){
        $c=$c . $sHomePage;
    }
    //上一页
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
    $n = ($nPage-3);
    //call echo("n",n)

    //翻页循环
    for( $i = $n ; $i<= $nCountPage; $i++){
        if( $i>=1 ){
            $nDispalyOK=$nDispalyOK+1;
            //call echo(i,nPage)
            if( $i == $nPage ){
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
    //下一页
    if( $nCountPage>$nPage ){
        $c=$c . replace($sNextPageFocus,'[$url$]',replace($configPageUrl,'[id]',$nextPage));
    }else if( $isDisplayTip==true ){
        $c=$c . $sNextPage;
    }
    //末页
    if( $nCountPage>$nPage ){
        $c=$c . replace($sTailPageFocus,'[$url$]',replace($configPageUrl,'[id]',$nCountPage));
    }else if( $isDisplayTip==true ){
        $c=$c . $sTailPage;
    }

    $c=$c . $sPageEnd;


    $c = replaceValueParam($c, 'nRecrodCount', $nRecrodCount);
    $c = replaceValueParam($c, 'nPage', $nPage);
    $c = replaceValueParam($c, 'nCountPage', $nCountPage);

    $webPageControl=$c . "\n";
    return @$webPageControl;
}


//获得Rs页数

?>

