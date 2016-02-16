
<?PHP

//重置数据库数据
function resetAccessData(){
    $GLOBALS['conn=']=OpenConn() ;
    $splStr=''; $i=''; $s=''; $columnname=''; $title=''; $nCount ='';
    $GLOBALS['conn=']=OpenConn() ;
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,parentid) values(\'首推产品\',\'Recommend\',\'首页\',0,\'|top|\',-1)') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid,showtitle,bodycontent) values(\'关于安颐\',\'About\',\'文本\',1,\'|top|\',\'关于我们您可以知道很多\',-1,\'天津华林园科技发展有限公司\',\'公司拥有资深的国内外专家、教授、博士、硕士等专业的研发队伍，开发具有世界领先水平的新型材料和产品。 多年来公司立足品牌的战略和人才的战略，在激烈的市场竞争中迅速发展和壮大，形成了以科研、开发、生产、复合营销为一体的多元化、多领域的专业科技公司。 公司实行外联内合的战略，与日本科研机构合作，研究开发出具有世界尖端水平的生物保健品和化妆品； 与国内具有研究实力的功能纤维研究所合作，开发研制出了国内先进高端的纳米光能微粉材料及纤维系列健康产品，以及现已完成研制的软体面控发射体材料的制作。华林公司是我们实实在在的民族企业，她在多项领域和多项科研中是领头羊佼佼者，是天津的重点保护企业、诚信企业。她现在拥有科技发明及新型实用专利11项，企业获得了ISO9000与ISO14000认证,被天津市政府评为“明星企业”和“五星级企业”。 \')') ;




    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'安颐产品\',\'Product\',\'产品\',2,\'|top|\',\'尽心尽力为你你制作更好的产品\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'新闻视频\',\'News\',\'产品\',3,\'|top|\',\'公司信息一手知道\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'联系我们\',\'Contact us\',\'文本\',4,\'|top|\',\'我们可有意思了欢迎来联系\',-1)') ;




    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'细胞生态学\',\'Contact us\',\'新闻\',4,\'||\',\'\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'美容常识\',\'Contact us\',\'新闻\',4,\'||\',\'\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'新闻资讯\',\'Contact us\',\'新闻\',4,\'||\',\'\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'精彩视频\',\'Contact us\',\'视频\',4,\'||\',\'\',-1)') ;





    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail') ;
    $splStr = aspSplit('细胞生态学|美容常识|新闻资讯|安颐产品', '|') ;
    foreach( $splStr as $columnname){
        if( $columnname == '安颐产品' ){
            $nCount = 12 ;
        }else{
            $nCount = 6 ;
        }
        for( $i = 1 ; $i<= $nCount; $i++){
            $title = $columnname . $i ;
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values(\'' . $title . '\',' . getColumnId($columnname) . ',\'[$WebImages$]testproduct.jpg\',\'[$WebImages$]biglimage.jpg\',\'[$WebImages$]banner' . $i . '.jpg\',\'||\',\'产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，' . $title . '，以增加深度睡眠时间4\',\'' . $title . '更多内容在这里写\')') ;
        }
    }


    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'视频1\',' . getColumnId('精彩视频') . ',\'[$WebImages$]testproduct.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4\')') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'视频2\',' . getColumnId('精彩视频') . ',\'[$WebImages$]banner1.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4\')') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'视频3\',' . getColumnId('精彩视频') . ',\'[$WebImages$]testproduct.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4\')') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'视频4\',' . getColumnId('精彩视频') . ',\'[$WebImages$]banner1.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'产品柔顺绵爽、透气透湿、防臭去味，防御病菌与螨虫的侵袭，<br>够通过其产生的生物波效应来畅通气血、平衡阴阳，并能对周身穴位产生静态按摩作用，以增加深度睡眠时间4\')') ;

    //网站设置
    $rsObj=$GLOBALS['conn']->query( 'select * from  ' . $GLOBALS['db_PREFIX'] . 'website ');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website (webtitle) values(\'网站标题\')') ;
    }
    connExecute('update  ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'安颐官网\',webkeywords=\'安颐关键词\',webdescription=\'安颐描述\',websitebottom=\'Copyright @ 2014 东方紫官方网站 All Rights Reserved<br>苏ICP备09092049号-2\',webtemplate=\'/Templates2015/安颐/\',webimages=\'/Templates2015/安颐/Images/\',webcss=\'/Templates2015/安颐/Css/\',webjs=\'/Templates2015/安颐/Js/\'') ;
    ASPEcho('提示', '恢复数据完成') ;
    rw('<hr><a href=\'../index.php\' target=\'_blank\'>进入首页</a> | <a href="index.php" target=\'_blank\'>进入后台</a>') ;

    //单面
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'onePage ') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onePage (title) values(\'安颐，第1条单页面\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onePage (title) values(\'安颐，第2条单页面\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onePage (title) values(\'安颐，第3条单页面\')') ;

    //管理员
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'admin ') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'admin (username,pwd) values(\'aa\',\'' . myMD5('aa') . '\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'admin (username,pwd) values(\'admin\',\'' . myMD5('admin') . '\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'admin (username,pwd) values(\'11\',\'' . myMD5('11') . '\')') ;





    $content=''; $filePath=''; $parentid=''; $author=''; $adddatetime=''; $fileName=''; $bodycontent=''; $webtitle=''; $webkeywords=''; $webdescription=''; $sortrank=''; $labletitle=''; $target ='';
    $websitebottom=''; $webtemplate=''; $webimages=''; $webcss=''; $webjs=''; $flags=''; $websiteurl=''; $splxx=''; $columntype=''; $relatedtags=''; $npagesize=''; $customaurl=''; $nofollow ='';
    $showreason=''; $ncomputersearch=''; $nmobliesearch=''; $ncountsearch=''; $ndegree ='';//竞价
    $displaytitle=''; $simpleIntroduction=''; $isonhtml ='';//单页


    for( $i = 1 ; $i<= 20; $i++){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding(nComputerSearch) values(2' . $i . ')') ;
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding(nComputerSearch) values(1' . $i . ')') ;
    }

    //网站配置
    $content = getftext('/Data/WebData/website.ini') ;
    if( $content <> '' ){
        $webtitle = phptrim(getStrCut($content, '【webtitle】', "\n", 0) );
        $webkeywords = phptrim(getStrCut($content, '【webkeywords】', "\n", 0) );
        $webdescription = phptrim(getStrCut($content, '【webdescription】', "\n", 0) );
        $websitebottom = phptrim(getStrCut($content, '【websitebottom】', "\n", 0) );
        $webtemplate = phptrim(getStrCut($content, '【webtemplate】', "\n", 0) );
        $webimages = phptrim(getStrCut($content, '【webimages】', "\n", 0) );
        $webcss = phptrim(getStrCut($content, '【webcss】', "\n", 0)) ;
        $webjs = phptrim(getStrCut($content, '【webjs】', "\n", 0) );
        $flags = phptrim(getStrCut($content, '【flags】', "\n", 0) );
        $websiteurl = phptrim(getStrCut($content, '【websiteurl】', "\n", 0));
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'' . $webtitle . '\',webkeywords=\'' . $webkeywords . '\',webdescription=\'' . $webdescription . '\',websitebottom=\'' . $websitebottom . '\',webtemplate=\'' . $webtemplate . '\',webimages=\'' . $webimages . '\',webcss=\'' . $webcss . '\',webjs=\'' . $webjs . '\',flags=\'' . $flags . '\',websiteurl=\'' . $websiteurl . '\'') ;
    }

    //导航
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn') ;
    $content = getDirTxtList('/Data/WebData/NavData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('导航', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【webtitle】') > 0 ){
                    $webtitle = phptrim(getStrCut($s, '【webtitle】', "\n", 0) );
                    $webkeywords = phptrim(getStrCut($s, '【webkeywords】', "\n", 0) );
                    $webdescription = phptrim(getStrCut($s, '【webdescription】', "\n", 0) );

                    $sortrank = phptrim(getStrCut($s, '【sortrank】', "\n", 0) );
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $fileName = phptrim(getStrCut($s, '【filename】', "\n", 0) );
                    $columnname = phptrim(getStrCut($s, '【columnname】', "\n", 0) );
                    $columntype = phptrim(getStrCut($s, '【columntype】', "\n", 0) );
                    $flags = phptrim(getStrCut($s, '【flags】', "\n", 0) );
                    $parentid = phptrim(getStrCut($s, '【parentid】', "\n", 0) );
                    $parentid = phptrim(getColumnId($parentid) );
                    $labletitle = phptrim(getStrCut($s, '【labletitle】', "\n", 0)) ;
                    //每页显示条数
                    $npagesize = phptrim(getStrCut($s, '【npagesize】', "\n", 0) );
                    if( $npagesize == '' ){ $npagesize = 10 ;}//默认分页数为10条

                    $target = phptrim(getStrCut($s, '【target】', "\n", 0) );

                    $bodycontent = ADSql(phptrim(getStrCut($s, '【bodycontent】', '【/bodycontent】', 0)) );
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //是否启用生成html
                    $isonhtml = phptrim(phptrim(getStrCut($s, '【isonhtml】', "\n", 0)) );
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //是否为nofollow
                    $nofollow = phptrim(phptrim(getStrCut($s, '【nofollow】', "\n", 0)) );
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    $simpleIntroduction = ADSql(phptrim(getStrCut($s, '【simpleintroduction】', '【/simpleintroduction】', 0)) );
                    $simpleIntroduction = contentTranscoding($simpleIntroduction) ;

                    $bodycontent = ADSql(phptrim(getStrCut($s, '【bodycontent】', '【/bodycontent】', 0)));
                    $bodycontent = contentTranscoding($bodycontent) ;

                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (webtitle,webkeywords,webdescription,columnname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target) values(\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $columnname . '\',\'' . $columntype . '\',' . $sortrank . ',\'' . $fileName . '\',\'' . $flags . '\',' . $parentid . ',\'' . $labletitle . '\',\'' . $simpleIntroduction . '\',\'' . $bodycontent . '\',' . $npagesize . ',' . $isonhtml . ',' . $nofollow . ',\'' . $target . '\')') ;
                }
            }
        }
    }

    //文章
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail') ;
    $content = getDirTxtList('/Data/WebData/ArticleData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('文章', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【title】') > 0 ){
                    $s = $s . "\n" ;
                    $parentid = phptrim(getStrCut($s, '【parentid】', "\n", 0));
                    $parentid = getColumnId($parentid) ;
                    $title = ADSql(phptrim(getStrCut($s, '【title】', "\n", 0)) );
                    $webtitle = phptrim(getStrCut($s, '【webtitle】', "\n", 0) );
                    $webkeywords = phptrim(getStrCut($s, '【webkeywords】', "\n", 0) );
                    $webdescription = phptrim(getStrCut($s, '【webdescription】', "\n", 0) );

                    $author = phptrim(getStrCut($s, '【author】', "\n", 0) );
                    $sortrank = phptrim(getStrCut($s, '【sortrank】', "\n", 0) );
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $adddatetime = phptrim(getStrCut($s, '【adddatetime】', "\n", 0) );
                    $fileName = phptrim(getStrCut($s, '【filename】', "\n", 0) );
                    $flags = phptrim(getStrCut($s, '【flags】', "\n", 0) );
                    $relatedtags = phptrim(getStrCut($s, '【relatedtags】', "\n", 0) );

                    $customaurl = ADSql(phptrim(getStrCut($s, '【customaurl】', "\n", 0)) );
                    $target = phptrim(getStrCut($s, '【target】', "\n", 0) );

                    //call echo("flags",flags)

                    $bodycontent = ADSql(phptrim(getStrCut($s, '【bodycontent】', '【/bodycontent】', 0)) );
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //是否启用生成html
                    $isonhtml = phptrim(getStrCut($s, '【isonhtml】', "\n", 0)) ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //是否为nofollow
                    $nofollow = phptrim(getStrCut($s, '【nofollow】', "\n", 0)) ;
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target) values(' . $parentid . ',\'' . $title . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $author . '\',' . $sortrank . ',\'' . $adddatetime . '\',\'' . $fileName . '\',\'' . $flags . '\',\'' . $relatedtags . '\',\'' . $bodycontent . '\',\'' . Now() . '\',' . $isonhtml . ',\'' . $customaurl . '\',' . $nofollow . ',\'' . $target . '\')') ;
                }
            }
        }
    }

    //单页
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'OnePage') ;
    $content = getDirTxtList('/Data/WebData/OnePageData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('单页', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【webkeywords】') > 0 ){
                    $s = $s . "\n" ;
                    $title = ADSql(phptrim(getStrCut($s, '【title】', "\n", 0)) );
                    $displaytitle = ADSql(phptrim(getStrCut($s, '【displaytitle】', "\n", 0)) );
                    $webtitle = phptrim(getStrCut($s, '【webtitle】', "\n", 0) );
                    $webkeywords = phptrim(getStrCut($s, '【webkeywords】', "\n", 0) );
                    $webdescription = phptrim(getStrCut($s, '【webdescription】', "\n", 0) );


                    $adddatetime = phptrim(getStrCut($s, '【adddatetime】', "\n", 0) );
                    $fileName = phptrim(getStrCut($s, '【filename】', "\n", 0) );

                    $simpleIntroduction = ADSql(phptrim(getStrCut($s, '【simpleintroduction】', '【/simpleintroduction】', 0)) );
                    $simpleIntroduction = contentTranscoding($simpleIntroduction) ;
                    $target = phptrim(getStrCut($s, '【target】', "\n", 0) );

                    $bodycontent = ADSql(phptrim(getStrCut($s, '【bodycontent】', '【/bodycontent】', 0)) );
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //是否启用生成html
                    $isonhtml = phptrim(getStrCut($s, '【isonhtml】', "\n", 0)) ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //是否为nofollow
                    $nofollow = phptrim(getStrCut($s, '【nofollow】', "\n", 0)) ;
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target) values(\'' . $title . '\',\'' . $displaytitle . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $adddatetime . '\',\'' . $fileName . '\',' . $isonhtml . ',\'' . $simpleIntroduction . '\',\'' . $bodycontent . '\',' . $nofollow . ',\'' . $target . '\')') ;
                }
            }
        }
    }

    //竞价
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'Bidding') ;
    $content = getDirTxtList('/Data/WebData/BiddingData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('竞价', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '【webkeywords】') > 0 ){
                    $webkeywords = phptrim(getStrCut($s, '【webkeywords】', "\n", 0) );
                    $showreason = phptrim(getStrCut($s, '【showreason】', "\n", 0) );
                    $ncomputersearch = phptrim(getStrCut($s, '【ncomputersearch】', "\n", 0) );
                    $nmobliesearch = phptrim(getStrCut($s, '【nmobliesearch】', "\n", 0) );
                    $ncountsearch = phptrim(getStrCut($s, '【ncountsearch】', "\n", 0) );
                    $ndegree = phptrim(getStrCut($s, '【ndegree】', "\n", 0));
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




