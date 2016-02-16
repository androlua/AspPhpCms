<?PHP
//dim nCount,nPageSize,maxpage,page,x,i,PageControl


//页控制  记录总数  每页显示数  当前面 (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl($nRecrodCount, $nPageSize, $nPage, $configPageUrl){
    $s='';$c='';$nCountPage='';$i='';$nDisplay='';$nDispalyOK='';
    $previousPage='';$nextPage						='';//定义上一页，下一页
    $isDisplayTip		='';//是否显示提示翻页信息
    $isDisplayTip=true;

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

    $c=$c . '<ul class="pagecontrolwrap">' . "\n";
    //翻页信息
    $c=$c . '<li class="pageinfo">总数['. $nRecrodCount .']  共['. $nPage .'/'. $nCountPage .']页</li>' . "\n";
    //首页
    if( $nPage>1 ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',1) .'">首页</a></li>' . "\n";
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">首页</li>' . "\n";
    }
    //上一页
    if( $previousPage<>'' ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$previousPage) .'">上一页</a></li>' . "\n";
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">上一页</li>' . "\n";
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
                $c=$c . '<li class="pagefocus">'. $i .'</li>' . "\n";
            }else{
                $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$i) .'">'. $i .'</a></li>' . "\n";
            }
            if( $nDispalyOK>$nDisplay ){
                break;
            }
        }
    }
    //下一页
    if( $nCountPage>$nPage ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$nextPage) .'">下一页</a></li>' . "\n";
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">下一页</li>' . "\n";
    }
    //末页
    if( $nCountPage>$nPage ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$nCountPage) .'">末页</a></li>' . "\n" ;
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">末页</li>' . "\n";
    }

    $c=$c . '</ul>' . "\n";
    $webPageControl=$c . "\n";
    return @$webPageControl;
}


//获得Rs页数

?>

