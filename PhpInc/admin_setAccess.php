
<?PHP

//�������ݿ�����
function resetAccessData(){
    $GLOBALS['conn=']=OpenConn() ;
    $splStr=''; $i=''; $s=''; $columnname=''; $title=''; $nCount ='';
    $GLOBALS['conn=']=OpenConn() ;
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,parentid) values(\'���Ʋ�Ʒ\',\'Recommend\',\'��ҳ\',0,\'|top|\',-1)') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid,showtitle,bodycontent) values(\'���ڰ���\',\'About\',\'�ı�\',1,\'|top|\',\'��������������֪���ܶ�\',-1,\'�����԰�Ƽ���չ���޹�˾\',\'��˾ӵ������Ĺ�����ר�ҡ����ڡ���ʿ��˶ʿ��רҵ���з����飬����������������ˮƽ�����Ͳ��ϺͲ�Ʒ�� ��������˾����Ʒ�Ƶ�ս�Ժ��˲ŵ�ս�ԣ��ڼ��ҵ��г�������Ѹ�ٷ�չ��׳���γ����Կ��С�����������������Ӫ��Ϊһ��Ķ�Ԫ�����������רҵ�Ƽ���˾�� ��˾ʵ�������ںϵ�ս�ԣ����ձ����л����������о�����������������ˮƽ�����ﱣ��Ʒ�ͻ�ױƷ�� ����ھ����о�ʵ���Ĺ�����ά�о����������������Ƴ��˹����Ƚ��߶˵����׹���΢�۲��ϼ���άϵ�н�����Ʒ���Լ�����������Ƶ�������ط�������ϵ����������ֹ�˾������ʵʵ���ڵ�������ҵ�����ڶ�������Ͷ������������ͷ��ٮٮ�ߣ��������ص㱣����ҵ��������ҵ��������ӵ�пƼ�����������ʵ��ר��11���ҵ�����ISO9000��ISO14000��֤,�������������Ϊ��������ҵ���͡����Ǽ���ҵ���� \')') ;




    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'���ò�Ʒ\',\'Product\',\'��Ʒ\',2,\'|top|\',\'���ľ���Ϊ�����������õĲ�Ʒ\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'������Ƶ\',\'News\',\'��Ʒ\',3,\'|top|\',\'��˾��Ϣһ��֪��\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'��ϵ����\',\'Contact us\',\'�ı�\',4,\'|top|\',\'���ǿ�����˼�˻�ӭ����ϵ\',-1)') ;




    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'ϸ����̬ѧ\',\'Contact us\',\'����\',4,\'||\',\'\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'���ݳ�ʶ\',\'Contact us\',\'����\',4,\'||\',\'\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'������Ѷ\',\'Contact us\',\'����\',4,\'||\',\'\',-1)') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values(\'������Ƶ\',\'Contact us\',\'��Ƶ\',4,\'||\',\'\',-1)') ;





    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail') ;
    $splStr = aspSplit('ϸ����̬ѧ|���ݳ�ʶ|������Ѷ|���ò�Ʒ', '|') ;
    foreach( $splStr as $columnname){
        if( $columnname == '���ò�Ʒ' ){
            $nCount = 12 ;
        }else{
            $nCount = 6 ;
        }
        for( $i = 1 ; $i<= $nCount; $i++){
            $title = $columnname . $i ;
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values(\'' . $title . '\',' . getColumnId($columnname) . ',\'[$WebImages$]testproduct.jpg\',\'[$WebImages$]biglimage.jpg\',\'[$WebImages$]banner' . $i . '.jpg\',\'||\',\'��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ��������' . $title . '�����������˯��ʱ��4\',\'' . $title . '��������������д\')') ;
        }
    }


    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'��Ƶ1\',' . getColumnId('������Ƶ') . ',\'[$WebImages$]testproduct.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4\')') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'��Ƶ2\',' . getColumnId('������Ƶ') . ',\'[$WebImages$]banner1.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4\')') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'��Ƶ3\',' . getColumnId('������Ƶ') . ',\'[$WebImages$]testproduct.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4\')') ;

    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values(\'��Ƶ4\',' . getColumnId('������Ƶ') . ',\'[$WebImages$]banner1.jpg\',\'[$WebImages$]1.flv\',\'\',\'||\',\'��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4\')') ;

    //��վ����
    $rsObj=$GLOBALS['conn']->query( 'select * from  ' . $GLOBALS['db_PREFIX'] . 'website ');
    $rs=mysql_fetch_array($rsObj);
    if( @mysql_num_rows($rsObj)==0 ){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website (webtitle) values(\'��վ����\')') ;
    }
    connExecute('update  ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'���ù���\',webkeywords=\'���ùؼ���\',webdescription=\'��������\',websitebottom=\'Copyright @ 2014 �����Ϲٷ���վ All Rights Reserved<br>��ICP��09092049��-2\',webtemplate=\'/Templates2015/����/\',webimages=\'/Templates2015/����/Images/\',webcss=\'/Templates2015/����/Css/\',webjs=\'/Templates2015/����/Js/\'') ;
    ASPEcho('��ʾ', '�ָ��������') ;
    rw('<hr><a href=\'../index.php\' target=\'_blank\'>������ҳ</a> | <a href="index.php" target=\'_blank\'>�����̨</a>') ;

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'onePage ') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onePage (title) values(\'���ã���1����ҳ��\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onePage (title) values(\'���ã���2����ҳ��\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onePage (title) values(\'���ã���3����ҳ��\')') ;

    //����Ա
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'admin ') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'admin (username,pwd) values(\'aa\',\'' . myMD5('aa') . '\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'admin (username,pwd) values(\'admin\',\'' . myMD5('admin') . '\')') ;
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'admin (username,pwd) values(\'11\',\'' . myMD5('11') . '\')') ;





    $content=''; $filePath=''; $parentid=''; $author=''; $adddatetime=''; $fileName=''; $bodycontent=''; $webtitle=''; $webkeywords=''; $webdescription=''; $sortrank=''; $labletitle=''; $target ='';
    $websitebottom=''; $webtemplate=''; $webimages=''; $webcss=''; $webjs=''; $flags=''; $websiteurl=''; $splxx=''; $columntype=''; $relatedtags=''; $npagesize=''; $customaurl=''; $nofollow ='';
    $showreason=''; $ncomputersearch=''; $nmobliesearch=''; $ncountsearch=''; $ndegree ='';//����
    $displaytitle=''; $simpleIntroduction=''; $isonhtml ='';//��ҳ


    for( $i = 1 ; $i<= 20; $i++){
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding(nComputerSearch) values(2' . $i . ')') ;
        connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding(nComputerSearch) values(1' . $i . ')') ;
    }

    //��վ����
    $content = getftext('/Data/WebData/website.ini') ;
    if( $content <> '' ){
        $webtitle = phptrim(getStrCut($content, '��webtitle��', "\n", 0) );
        $webkeywords = phptrim(getStrCut($content, '��webkeywords��', "\n", 0) );
        $webdescription = phptrim(getStrCut($content, '��webdescription��', "\n", 0) );
        $websitebottom = phptrim(getStrCut($content, '��websitebottom��', "\n", 0) );
        $webtemplate = phptrim(getStrCut($content, '��webtemplate��', "\n", 0) );
        $webimages = phptrim(getStrCut($content, '��webimages��', "\n", 0) );
        $webcss = phptrim(getStrCut($content, '��webcss��', "\n", 0)) ;
        $webjs = phptrim(getStrCut($content, '��webjs��', "\n", 0) );
        $flags = phptrim(getStrCut($content, '��flags��', "\n", 0) );
        $websiteurl = phptrim(getStrCut($content, '��websiteurl��', "\n", 0));
        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'' . $webtitle . '\',webkeywords=\'' . $webkeywords . '\',webdescription=\'' . $webdescription . '\',websitebottom=\'' . $websitebottom . '\',webtemplate=\'' . $webtemplate . '\',webimages=\'' . $webimages . '\',webcss=\'' . $webcss . '\',webjs=\'' . $webjs . '\',flags=\'' . $flags . '\',websiteurl=\'' . $websiteurl . '\'') ;
    }

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn') ;
    $content = getDirTxtList('/Data/WebData/NavData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��webtitle��') > 0 ){
                    $webtitle = phptrim(getStrCut($s, '��webtitle��', "\n", 0) );
                    $webkeywords = phptrim(getStrCut($s, '��webkeywords��', "\n", 0) );
                    $webdescription = phptrim(getStrCut($s, '��webdescription��', "\n", 0) );

                    $sortrank = phptrim(getStrCut($s, '��sortrank��', "\n", 0) );
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $fileName = phptrim(getStrCut($s, '��filename��', "\n", 0) );
                    $columnname = phptrim(getStrCut($s, '��columnname��', "\n", 0) );
                    $columntype = phptrim(getStrCut($s, '��columntype��', "\n", 0) );
                    $flags = phptrim(getStrCut($s, '��flags��', "\n", 0) );
                    $parentid = phptrim(getStrCut($s, '��parentid��', "\n", 0) );
                    $parentid = phptrim(getColumnId($parentid) );
                    $labletitle = phptrim(getStrCut($s, '��labletitle��', "\n", 0)) ;
                    //ÿҳ��ʾ����
                    $npagesize = phptrim(getStrCut($s, '��npagesize��', "\n", 0) );
                    if( $npagesize == '' ){ $npagesize = 10 ;}//Ĭ�Ϸ�ҳ��Ϊ10��

                    $target = phptrim(getStrCut($s, '��target��', "\n", 0) );

                    $bodycontent = ADSql(phptrim(getStrCut($s, '��bodycontent��', '��/bodycontent��', 0)) );
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //�Ƿ���������html
                    $isonhtml = phptrim(phptrim(getStrCut($s, '��isonhtml��', "\n", 0)) );
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = phptrim(phptrim(getStrCut($s, '��nofollow��', "\n", 0)) );
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    $simpleIntroduction = ADSql(phptrim(getStrCut($s, '��simpleintroduction��', '��/simpleintroduction��', 0)) );
                    $simpleIntroduction = contentTranscoding($simpleIntroduction) ;

                    $bodycontent = ADSql(phptrim(getStrCut($s, '��bodycontent��', '��/bodycontent��', 0)));
                    $bodycontent = contentTranscoding($bodycontent) ;

                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (webtitle,webkeywords,webdescription,columnname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target) values(\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $columnname . '\',\'' . $columntype . '\',' . $sortrank . ',\'' . $fileName . '\',\'' . $flags . '\',' . $parentid . ',\'' . $labletitle . '\',\'' . $simpleIntroduction . '\',\'' . $bodycontent . '\',' . $npagesize . ',' . $isonhtml . ',' . $nofollow . ',\'' . $target . '\')') ;
                }
            }
        }
    }

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail') ;
    $content = getDirTxtList('/Data/WebData/ArticleData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��title��') > 0 ){
                    $s = $s . "\n" ;
                    $parentid = phptrim(getStrCut($s, '��parentid��', "\n", 0));
                    $parentid = getColumnId($parentid) ;
                    $title = ADSql(phptrim(getStrCut($s, '��title��', "\n", 0)) );
                    $webtitle = phptrim(getStrCut($s, '��webtitle��', "\n", 0) );
                    $webkeywords = phptrim(getStrCut($s, '��webkeywords��', "\n", 0) );
                    $webdescription = phptrim(getStrCut($s, '��webdescription��', "\n", 0) );

                    $author = phptrim(getStrCut($s, '��author��', "\n", 0) );
                    $sortrank = phptrim(getStrCut($s, '��sortrank��', "\n", 0) );
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $adddatetime = phptrim(getStrCut($s, '��adddatetime��', "\n", 0) );
                    $fileName = phptrim(getStrCut($s, '��filename��', "\n", 0) );
                    $flags = phptrim(getStrCut($s, '��flags��', "\n", 0) );
                    $relatedtags = phptrim(getStrCut($s, '��relatedtags��', "\n", 0) );

                    $customaurl = ADSql(phptrim(getStrCut($s, '��customaurl��', "\n", 0)) );
                    $target = phptrim(getStrCut($s, '��target��', "\n", 0) );

                    //call echo("flags",flags)

                    $bodycontent = ADSql(phptrim(getStrCut($s, '��bodycontent��', '��/bodycontent��', 0)) );
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //�Ƿ���������html
                    $isonhtml = phptrim(getStrCut($s, '��isonhtml��', "\n", 0)) ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = phptrim(getStrCut($s, '��nofollow��', "\n", 0)) ;
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

    //��ҳ
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'OnePage') ;
    $content = getDirTxtList('/Data/WebData/OnePageData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('��ҳ', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��webkeywords��') > 0 ){
                    $s = $s . "\n" ;
                    $title = ADSql(phptrim(getStrCut($s, '��title��', "\n", 0)) );
                    $displaytitle = ADSql(phptrim(getStrCut($s, '��displaytitle��', "\n", 0)) );
                    $webtitle = phptrim(getStrCut($s, '��webtitle��', "\n", 0) );
                    $webkeywords = phptrim(getStrCut($s, '��webkeywords��', "\n", 0) );
                    $webdescription = phptrim(getStrCut($s, '��webdescription��', "\n", 0) );


                    $adddatetime = phptrim(getStrCut($s, '��adddatetime��', "\n", 0) );
                    $fileName = phptrim(getStrCut($s, '��filename��', "\n", 0) );

                    $simpleIntroduction = ADSql(phptrim(getStrCut($s, '��simpleintroduction��', '��/simpleintroduction��', 0)) );
                    $simpleIntroduction = contentTranscoding($simpleIntroduction) ;
                    $target = phptrim(getStrCut($s, '��target��', "\n", 0) );

                    $bodycontent = ADSql(phptrim(getStrCut($s, '��bodycontent��', '��/bodycontent��', 0)) );
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //�Ƿ���������html
                    $isonhtml = phptrim(getStrCut($s, '��isonhtml��', "\n", 0)) ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = phptrim(getStrCut($s, '��nofollow��', "\n", 0)) ;
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

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'Bidding') ;
    $content = getDirTxtList('/Data/WebData/BiddingData/') ;
    $splStr = aspSplit($content, "\n") ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getFileName($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, "\n" . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��webkeywords��') > 0 ){
                    $webkeywords = phptrim(getStrCut($s, '��webkeywords��', "\n", 0) );
                    $showreason = phptrim(getStrCut($s, '��showreason��', "\n", 0) );
                    $ncomputersearch = phptrim(getStrCut($s, '��ncomputersearch��', "\n", 0) );
                    $nmobliesearch = phptrim(getStrCut($s, '��nmobliesearch��', "\n", 0) );
                    $ncountsearch = phptrim(getStrCut($s, '��ncountsearch��', "\n", 0) );
                    $ndegree = phptrim(getStrCut($s, '��ndegree��', "\n", 0));
                    $ndegree = getnumber($ndegree) ;
                    if( $ndegree == '' ){
                        $ndegree = 0 ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values(\'' . $webkeywords . '\',\'' . $showreason . '\',' . $ncomputersearch . ',' . $nmobliesearch . ',' . $ndegree . ')') ;
                }
            }
        }
    }


    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'TableComment') ;



}

//����ת��
function contentTranscoding( $content){
    $content = Replace(Replace(Replace(Replace($content, '<?', '&lt;?'), '?>', '?&gt;'), '<' . '%', '&lt;%'), '?>', '%&gt;') ;


    $splStr=''; $i=''; $s=''; $c=''; $isTranscoding=''; $isBR ='';
    $isTranscoding = false ;
    $isBR = false ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        if( instr($s, '[&htmlת��&]') > 0 ){
            $isTranscoding = true ;
        }
        if( instr($s, '[&htmlת��end&]') > 0 ){
            $isTranscoding = false ;
        }
        if( instr($s, '[&ȫ������&]') > 0 ){
            $isBR = true ;
        }
        if( instr($s, '[&ȫ������end&]') > 0 ){
            $isBR = false ;
        }

        if( $isTranscoding == true ){
            $s = Replace(Replace($s, '[&htmlת��&]', ''), '<', '&lt;') ;
        }else{
            $s = Replace($s, '[&htmlת��end&]', '') ;
        }
        if( $isBR == true ){
            $s = Replace($s, '[&ȫ������&]', '') . '<br>' ;
        }else{
            $s = Replace($s, '[&ȫ������end&]', '') ;
        }
        $c = $c . $s . "\n" ;
    }
    $contentTranscoding = $c ;
    return @$contentTranscoding;
}
?>




