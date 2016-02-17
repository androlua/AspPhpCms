
<?PHP

//新的截取字符20160216
function newGetStrCut($content,$title){
    $s='';
    if( instr($content,'【/'. $title .'】')>0 ){
        $s = ADSql(phptrim(getStrCut($content, '【'. $title .'】', '【/'. $title .'】', 0)) );
    }else{
        $s = ADSql(phptrim(getStrCut($content, '【'. $title .'】', "\n", 0) ));
    }
    $newGetStrCut=$s;
    return @$newGetStrCut;
}


//重置数据库数据
function resetAccessData(){
    $GLOBALS['conn=']=OpenConn() ;
    $splStr=''; $i=''; $s=''; $columnname=''; $title=''; $nCount='';$webdataDir='';
    $webdataDir=@$_REQUEST['webdataDir'];
    if( $webdataDir<>'' ){
        if( checkFolder($webdataDir)==false ){
            eerr('网站数据目录不存在，恢复默认数据未成功', $webdataDir);
        }
    }else{
        $webdataDir='/Data/WebData/';
    }

    ASPEcho('提示', '恢复数据完成') ;
    rw('<hr><a href=\'..../index.php\' target=\'_blank\'>进入首页</a> | <a href="?" target=\'_blank\'>进入后台</a>') ;

    $content=''; $filePath=''; $parentid=''; $author=''; $adddatetime=''; $filename=''; $bodycontent=''; $webtitle=''; $webkeywords=''; $webdescription=''; $sortrank=''; $labletitle=''; $target ='';
    $websitebottom=''; $webtemplate=''; $webimages=''; $webcss=''; $webjs=''; $flags=''; $websiteurl=''; $splxx=''; $columntype=''; $relatedtags=''; $npagesize=''; $customaurl=''; $nofollow ='';
    $templatepath='';
    $showreason=''; $ncomputersearch=''; $nmobliesearch=''; $ncountsearch=''; $ndegree ='';//竞价表
    $displaytitle=''; $simpleintroduction=''; $isonhtml ='';//单页表
    $columnenname																='';//导航表
    $smallimage='';$bigImage='';$bannerimage												='';//文章表




    //网站配置
    $content = getftext($webdataDir . '/website.ini') ;
    if( $content <> '' ){
        $webtitle = newGetStrCut($content,'webtitle');
        $webkeywords = newGetStrCut($content,'webkeywords');
        $webdescription = newGetStrCut($content,'webdescription');
        $websitebottom = newGetStrCut($content,'websitebottom');
        $webtemplate = newGetStrCut($content,'webtemplate');
        $webimages = newGetStrCut($content,'webimages');
        $webcss =newGetStrCut($content,'webcss');
        $webjs =newGetStrCut($content,'webjs');
        $flags = newGetStrCut($content,'flags');
        $websiteurl = newGetStrCut($content,'websiteurl');

        if( getRecordCount($GLOBALS['db_PREFIX'] . 'website', '')==0 ){
            connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website(webtitle) values(\'测试\')');
        }

        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'' . $webtitle . '\',webkeywords=\'' . $webkeywords . '\',webdescription=\'' . $webdescription . '\',websitebottom=\'' . $websitebottom . '\',webtemplate=\'' . $webtemplate . '\',webimages=\'' . $webimages . '\',webcss=\'' . $webcss . '\',webjs=\'' . $webjs . '\',flags=\'' . $flags . '\',websiteurl=\'' . $websiteurl . '\'') ;
    }

    //导航
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn') ;
    $content = getDirTxtList($webdataDir . '/NavData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $filename = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($filename, 0 , 1)) == false ){
            ASPEcho('导航', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【webtitle】') > 0 ){
                    $webtitle = newGetStrCut($s,'webtitle');
                    $webkeywords = newGetStrCut($s,'webkeywords');
                    $webdescription = newGetStrCut($s,'webdescription');

                    $sortrank = newGetStrCut($s,'sortrank');
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $filename =newGetStrCut($s,'filename');
                    $columnname =newGetStrCut($s,'columnname');
                    $columnenname=newGetStrCut($s,'columnenname');
                    $columntype = newGetStrCut($s,'columntype');
                    $flags =newGetStrCut($s,'flags');
                    $parentid = newGetStrCut($s,'parentid');
                    $parentid = phptrim(getColumnId($parentid) );
                    $labletitle = newGetStrCut($s,'labletitle');
                    //每页显示条数
                    $npagesize =newGetStrCut($s,'npagesize');
                    if( $npagesize == '' ){ $npagesize = 10 ;}//默认分页数为10条

                    $target = newGetStrCut($s,'target');

                    $smallimage = newGetStrCut($s,'smallimage');
                    $bigImage = newGetStrCut($s,'bigImage');
                    $bannerimage = newGetStrCut($s,'bannerimage');

                    $templatepath = newGetStrCut($s,'templatepath') ;


                    $bodycontent = newGetStrCut($s,'bodycontent');
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //是否启用生成html
                    $isonhtml = newGetStrCut($s,'isonhtml');
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //是否为nofollow
                    $nofollow = newGetStrCut($s,'nofollow');
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    $simpleintroduction = newGetStrCut($s,'simpleintroduction');
                    $simpleintroduction = contentTranscoding($simpleintroduction) ;

                    $bodycontent = newGetStrCut($s,'bodycontent');
                    $bodycontent = contentTranscoding($bodycontent) ;

                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (webtitle,webkeywords,webdescription,columnname,columnenname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $columnname . '\',\'' . $columnenname . '\',\'' . $columntype . '\',' . $sortrank . ',\'' . $filename . '\',\'' . $flags . '\',' . $parentid . ',\'' . $labletitle . '\',\'' . $simpleintroduction . '\',\'' . $bodycontent . '\',' . $npagesize . ',' . $isonhtml . ',' . $nofollow . ',\'' . $target . '\',\'' . $smallimage . '\',\'' . $bigImage . '\',\'' . $bannerimage . '\',\'' . $templatepath . '\')') ;
                }
            }
        }
    }

    //文章
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail') ;
    $content = getDirTxtList($webdataDir . '/ArticleData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $filename = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($filename, 0 , 1)) == false ){
            ASPEcho('文章', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【title】') > 0 ){
                    $s = $s . "\n" ;
                    $parentid = newGetStrCut($s,'parentid');
                    $parentid = getColumnId($parentid) ;
                    $title = newGetStrCut($s,'title');
                    $webtitle = newGetStrCut($s,'webtitle');
                    $webkeywords = newGetStrCut($s,'webkeywords');
                    $webdescription = newGetStrCut($s,'webdescription');


                    $author = newGetStrCut($s,'author');
                    $sortrank =newGetStrCut($s,'sortrank');
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $adddatetime = newGetStrCut($s,'adddatetime');
                    $filename =newGetStrCut($s,'filename');
                    $flags = newGetStrCut($s,'flags');
                    $relatedtags =newGetStrCut($s,'relatedtags');

                    $customaurl = newGetStrCut($s,'customaurl');
                    $target = newGetStrCut($s,'target');


                    $smallimage = newGetStrCut($s,'smallimage');
                    $bigImage = newGetStrCut($s,'bigImage');
                    $bannerimage = newGetStrCut($s,'bannerimage') ;
                    $templatepath = newGetStrCut($s,'templatepath');


                    $bodycontent =newGetStrCut($s,'bodycontent');
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //是否启用生成html
                    $isonhtml =newGetStrCut($s,'isonhtml');
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //是否为nofollow
                    $nofollow = newGetStrCut($s,'nofollow');
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(' . $parentid . ',\'' . $title . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $author . '\',' . $sortrank . ',\'' . $adddatetime . '\',\'' . $filename . '\',\'' . $flags . '\',\'' . $relatedtags . '\',\'' . $bodycontent . '\',\'' . Now() . '\',' . $isonhtml . ',\'' . $customaurl . '\',' . $nofollow . ',\'' . $target . '\',\'' . $smallimage . '\',\'' . $bigImage . '\',\'' . $bannerimage . '\',\'' . $templatepath . '\')') ;
                }
            }
        }
    }

    //单页
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'OnePage') ;
    $content = getDirTxtList($webdataDir . '/OnePageData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $filename = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($filename, 0 , 1)) == false ){
            ASPEcho('单页', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【webkeywords】') > 0 ){
                    $s = $s . "\n" ;
                    $title =newGetStrCut($s,'title');
                    $displaytitle = newGetStrCut($s,'displaytitle');
                    $webtitle = newGetStrCut($s,'webtitle');
                    $webkeywords = newGetStrCut($s,'webkeywords');
                    $webdescription = newGetStrCut($s,'webdescription');



                    $adddatetime = newGetStrCut($s,'adddatetime');
                    $filename = newGetStrCut($s,'filename');

                    $simpleintroduction =newGetStrCut($s,'simpleintroduction') ;

                    $simpleintroduction = contentTranscoding($simpleintroduction) ;
                    $target = newGetStrCut($s,'target');
                    $templatepath = newGetStrCut($s,'templatepath');

                    $bodycontent = newGetStrCut($s,'bodycontent');
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //是否启用生成html
                    $isonhtml =newGetStrCut($s,'isonhtml');
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //是否为nofollow
                    $nofollow =newGetStrCut($s,'nofollow');
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target,templatepath) values(\'' . $title . '\',\'' . $displaytitle . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $adddatetime . '\',\'' . $filename . '\',' . $isonhtml . ',\'' . $simpleintroduction . '\',\'' . $bodycontent . '\',' . $nofollow . ',\'' . $target . '\',\'' . $templatepath . '\')') ;
                }
            }
        }
    }

    //竞价
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'Bidding') ;
    $content = getDirTxtList($webdataDir . '/BiddingData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $filename = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($filename, 0 , 1)) == false ){
            ASPEcho('竞价', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【webkeywords】') > 0 ){
                    $webkeywords =newGetStrCut($s,'webkeywords');
                    $showreason = newGetStrCut($s,'showreason');
                    $ncomputersearch =newGetStrCut($s,'ncomputersearch');
                    $nmobliesearch = newGetStrCut($s,'nmobliesearch');
                    $ncountsearch = newGetStrCut($s,'ncountsearch');
                    $ndegree =newGetStrCut($s,'ndegree');
                    $ndegree = getnumber($ndegree) ;
                    if( $ndegree == '' ){
                        $ndegree = 0 ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values(\'' . $webkeywords . '\',\'' . $showreason . '\',' . $ncomputersearch . ',' . $nmobliesearch . ',' . $ndegree . ')') ;
                }
            }
        }
    }


    //评论
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'TableComment') ;



}

//内容转码
function contentTranscoding( $content){
    $content = Replace(Replace(Replace(Replace($content, '<?', '&lt;?'), '?>', '?&gt;'), '<' . '%', '&lt;%'), '?>', '%&gt;') ;


    $splStr=''; $i=''; $s=''; $c=''; $isTranscoding=''; $isBR ='';
    $isTranscoding = false ;
    $isBR = false ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        if( instr($s, '[&html转码&]') > 0 ){
            $isTranscoding = true ;
        }
        if( instr($s, '[&html转码end&]') > 0 ){
            $isTranscoding = false ;
        }
        if( instr($s, '[&全部换行&]') > 0 ){
            $isBR = true ;
        }
        if( instr($s, '[&全部换行end&]') > 0 ){
            $isBR = false ;
        }

        if( $isTranscoding == true ){
            $s = Replace(Replace($s, '[&html转码&]', ''), '<', '&lt;') ;
        }else{
            $s = Replace($s, '[&html转码end&]', '') ;
        }
        if( $isBR == true ){
            $s = Replace($s, '[&全部换行&]', '') . '<br>' ;
        }else{
            $s = Replace($s, '[&全部换行end&]', '') ;
        }
        $c = $c . $s . "\n" ;
    }
    $contentTranscoding = $c ;
    return @$contentTranscoding;
}
?>




