<?PHP
//dim nCount,nPageSize,maxpage,page,x,i,PageControl


//ҳ����  ��¼����  ÿҳ��ʾ��  ��ǰ�� (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl($nRecrodCount, $nPageSize, $nPage, $configPageUrl){
    $s='';$c='';$nCountPage='';$i='';$nDisplay='';$nDispalyOK='';
    $previousPage='';$nextPage						='';//������һҳ����һҳ
    $isDisplayTip		='';//�Ƿ���ʾ��ʾ��ҳ��Ϣ
    $isDisplayTip=true;

    //����ҳΪ����
    if( $configPageUrl=='' ){
        $configPageUrl=GetUrlAddToParam( GetUrl(),'?page=[id]','replace');
    }

    $nDisplay=6			;//��ʾ��
    $nDispalyOK=0		;//��ʾ�ɹ���
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

    $c=$c . '<ul class="pagecontrolwrap">' . "\n";
    //��ҳ��Ϣ
    $c=$c . '<li class="pageinfo">����['. $nRecrodCount .']  ��['. $nPage .'/'. $nCountPage .']ҳ</li>' . "\n";
    //��ҳ
    if( $nPage>1 ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',1) .'">��ҳ</a></li>' . "\n";
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">��ҳ</li>' . "\n";
    }
    //��һҳ
    if( $previousPage<>'' ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$previousPage) .'">��һҳ</a></li>' . "\n";
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">��һҳ</li>' . "\n";
    }


    $n='';
    //call echo(npage,ncountpage)
    $n = ($nPage-3);
    //call echo("n",n)

    //��ҳѭ��
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
    //��һҳ
    if( $nCountPage>$nPage ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$nextPage) .'">��һҳ</a></li>' . "\n";
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">��һҳ</li>' . "\n";
    }
    //ĩҳ
    if( $nCountPage>$nPage ){
        $c=$c . '<li><a href="'. replace($configPageUrl,'[id]',$nCountPage) .'">ĩҳ</a></li>' . "\n" ;
    }else if( $isDisplayTip==true ){
        $c=$c . '<li class="pageli">ĩҳ</li>' . "\n";
    }

    $c=$c . '</ul>' . "\n";
    $webPageControl=$c . "\n";
    return @$webPageControl;
}


//���Rsҳ��

?>

