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

//�µĽ�ȡ�ַ�20160216
function newGetStrCut($content, $title){
    $s ='';
    if( instr($content, '��/' . $title . '��') > 0 ){
        $s = ADSql(phptrim(getStrCut($content, '��' . $title . '��', '��/' . $title . '��', 0))) ;
    }else{
        $s = ADSql(phptrim(getStrCut($content, '��' . $title . '��', vbCrlf(), 0))) ;
    }
    $newGetStrCut = $s ;
    return @$newGetStrCut;
}


//�������ݿ�����
function resetAccessData(){

    handlePower('�ָ�ģ������')						;//����Ȩ�޴���

    $GLOBALS['conn=']=OpenConn() ;
    $splStr=''; $i=''; $s=''; $columnname=''; $title=''; $nCount=''; $webdataDir ='';
    $webdataDir = @$_REQUEST['webdataDir'] ;
    if( $webdataDir <> '' ){
        if( checkFolder($webdataDir) == false ){
            eerr('��վ����Ŀ¼�����ڣ��ָ�Ĭ������δ�ɹ�', $webdataDir) ;
        }
    }else{
        $webdataDir = '/Data/WebData/' ;
    }

    ASPEcho('��ʾ', '�ָ��������') ;
    rw('<hr><a href=\'..../index.php\' target=\'_blank\'>������ҳ</a> | <a href="?" target=\'_blank\'>�����̨</a>') ;

    $content=''; $filePath=''; $parentid=''; $author=''; $adddatetime=''; $fileName=''; $bodycontent=''; $webtitle=''; $webkeywords=''; $webdescription=''; $sortrank=''; $labletitle=''; $target ='';
    $websitebottom=''; $webtemplate=''; $webimages=''; $webcss=''; $webjs=''; $flags=''; $websiteurl=''; $splxx=''; $columntype=''; $relatedtags=''; $npagesize=''; $customaurl=''; $nofollow ='';
    $templatepath=''; $through ='';
    $showreason=''; $ncomputersearch=''; $nmobliesearch=''; $ncountsearch=''; $ndegree ='';//���۱�
    $displaytitle=''; $simpleintroduction=''; $isonhtml ='';//��ҳ��
    $columnenname ='';//������
    $smallimage=''; $bigImage=''; $bannerimage ='';//���±�




    //��վ����
    $content = getftext($webdataDir . '/website.ini') ;
    if( $content <> '' ){
        $webtitle = newGetStrCut($content, 'webtitle') ;
        $webkeywords = newGetStrCut($content, 'webkeywords') ;
        $webdescription = newGetStrCut($content, 'webdescription') ;
        $websitebottom = newGetStrCut($content, 'websitebottom') ;
        $webtemplate = newGetStrCut($content, 'webtemplate') ;
        $webimages = newGetStrCut($content, 'webimages') ;
        $webcss = newGetStrCut($content, 'webcss') ;
        $webjs = newGetStrCut($content, 'webjs') ;
        $flags = newGetStrCut($content, 'flags') ;
        $websiteurl = newGetStrCut($content, 'websiteurl') ;

        if( getRecordCount($GLOBALS['db_PREFIX'] . 'website', '') == 0 ){
            connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website(webtitle) values(\'����\')') ;
        }

        connExecute('update ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'' . $webtitle . '\',webkeywords=\'' . $webkeywords . '\',webdescription=\'' . $webdescription . '\',websitebottom=\'' . $websitebottom . '\',webtemplate=\'' . $webtemplate . '\',webimages=\'' . $webimages . '\',webcss=\'' . $webcss . '\',webjs=\'' . $webjs . '\',flags=\'' . $flags . '\',websiteurl=\'' . $websiteurl . '\'') ;
    }

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn') ;
    $content = getDirTxtList($webdataDir . '/webcolumn/') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, vbCrlf() . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��webtitle��') > 0 ){
                    $webtitle = newGetStrCut($s, 'webtitle') ;
                    $webkeywords = newGetStrCut($s, 'webkeywords') ;
                    $webdescription = newGetStrCut($s, 'webdescription') ;

                    $sortrank = newGetStrCut($s, 'sortrank') ;
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $fileName = newGetStrCut($s, 'filename') ;
                    $columnname = newGetStrCut($s, 'columnname') ;
                    $columnenname = newGetStrCut($s, 'columnenname') ;
                    $columntype = newGetStrCut($s, 'columntype') ;
                    $flags = newGetStrCut($s, 'flags') ;
                    $parentid = newGetStrCut($s, 'parentid') ;
                    $parentid = phptrim(getColumnId($parentid)) ;
                    $labletitle = newGetStrCut($s, 'labletitle') ;
                    //ÿҳ��ʾ����
                    $npagesize = newGetStrCut($s, 'npagesize') ;
                    if( $npagesize == '' ){ $npagesize = 10 ;}//Ĭ�Ϸ�ҳ��Ϊ10��

                    $target = newGetStrCut($s, 'target') ;

                    $smallimage = newGetStrCut($s, 'smallimage') ;
                    $bigImage = newGetStrCut($s, 'bigImage') ;
                    $bannerimage = newGetStrCut($s, 'bannerimage') ;

                    $templatepath = newGetStrCut($s, 'templatepath') ;


                    $bodycontent = newGetStrCut($s, 'bodycontent') ;
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //�Ƿ���������html
                    $isonhtml = newGetStrCut($s, 'isonhtml') ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = newGetStrCut($s, 'nofollow') ;
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    $simpleintroduction = newGetStrCut($s, 'simpleintroduction') ;
                    $simpleintroduction = contentTranscoding($simpleintroduction) ;

                    $bodycontent = newGetStrCut($s, 'bodycontent') ;
                    $bodycontent = contentTranscoding($bodycontent) ;

                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (webtitle,webkeywords,webdescription,columnname,columnenname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $columnname . '\',\'' . $columnenname . '\',\'' . $columntype . '\',' . $sortrank . ',\'' . $fileName . '\',\'' . $flags . '\',' . $parentid . ',\'' . $labletitle . '\',\'' . $simpleintroduction . '\',\'' . $bodycontent . '\',' . $npagesize . ',' . $isonhtml . ',' . $nofollow . ',\'' . $target . '\',\'' . $smallimage . '\',\'' . $bigImage . '\',\'' . $bannerimage . '\',\'' . $templatepath . '\')') ;
                }
            }
        }
    }

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail') ;
    $content = getDirTxtList($webdataDir . '/articledetail/') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, vbCrlf() . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��title��') > 0 ){
                    $s = $s . vbCrlf() ;
                    $parentid = newGetStrCut($s, 'parentid') ;
                    $parentid = getColumnId($parentid) ;
                    $title = newGetStrCut($s, 'title') ;
                    $webtitle = newGetStrCut($s, 'webtitle') ;
                    $webkeywords = newGetStrCut($s, 'webkeywords') ;
                    $webdescription = newGetStrCut($s, 'webdescription') ;


                    $author = newGetStrCut($s, 'author') ;
                    $sortrank = newGetStrCut($s, 'sortrank') ;
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    $adddatetime = newGetStrCut($s, 'adddatetime') ;
                    $fileName = newGetStrCut($s, 'filename') ;
                    $flags = newGetStrCut($s, 'flags') ;
                    $relatedtags = newGetStrCut($s, 'relatedtags') ;

                    $customaurl = newGetStrCut($s, 'customaurl') ;
                    $target = newGetStrCut($s, 'target') ;


                    $smallimage = newGetStrCut($s, 'smallimage') ;
                    $bigImage = newGetStrCut($s, 'bigImage') ;
                    $bannerimage = newGetStrCut($s, 'bannerimage') ;
                    $templatepath = newGetStrCut($s, 'templatepath') ;


                    $bodycontent = newGetStrCut($s, 'bodycontent') ;
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //�Ƿ���������html
                    $isonhtml = newGetStrCut($s, 'isonhtml') ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = newGetStrCut($s, 'nofollow') ;
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(' . $parentid . ',\'' . $title . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $author . '\',' . $sortrank . ',\'' . $adddatetime . '\',\'' . $fileName . '\',\'' . $flags . '\',\'' . $relatedtags . '\',\'' . $bodycontent . '\',\'' . Now() . '\',' . $isonhtml . ',\'' . $customaurl . '\',' . $nofollow . ',\'' . $target . '\',\'' . $smallimage . '\',\'' . $bigImage . '\',\'' . $bannerimage . '\',\'' . $templatepath . '\')') ;
                }
            }
        }
    }

    //��ҳ
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'OnePage') ;
    $content = getDirTxtList($webdataDir . '/OnePage/') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('��ҳ', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, vbCrlf() . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��webkeywords��') > 0 ){
                    $s = $s . vbCrlf() ;
                    $title = newGetStrCut($s, 'title') ;
                    $displaytitle = newGetStrCut($s, 'displaytitle') ;
                    $webtitle = newGetStrCut($s, 'webtitle') ;
                    $webkeywords = newGetStrCut($s, 'webkeywords') ;
                    $webdescription = newGetStrCut($s, 'webdescription') ;



                    $adddatetime = newGetStrCut($s, 'adddatetime') ;
                    $fileName = newGetStrCut($s, 'filename') ;

                    $simpleintroduction = newGetStrCut($s, 'simpleintroduction') ;

                    $simpleintroduction = contentTranscoding($simpleintroduction) ;
                    $target = newGetStrCut($s, 'target') ;
                    $templatepath = newGetStrCut($s, 'templatepath') ;

                    $bodycontent = newGetStrCut($s, 'bodycontent') ;
                    $bodycontent = contentTranscoding($bodycontent) ;
                    //�Ƿ���������html
                    $isonhtml = newGetStrCut($s, 'isonhtml') ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = newGetStrCut($s, 'nofollow') ;
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }


                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target,templatepath) values(\'' . $title . '\',\'' . $displaytitle . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $adddatetime . '\',\'' . $fileName . '\',' . $isonhtml . ',\'' . $simpleintroduction . '\',\'' . $bodycontent . '\',' . $nofollow . ',\'' . $target . '\',\'' . $templatepath . '\')') ;
                }
            }
        }
    }

    //����
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'Bidding') ;
    $content = getDirTxtList($webdataDir . '/Bidding/') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, vbCrlf() . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��webkeywords��') > 0 ){
                    $webkeywords = newGetStrCut($s, 'webkeywords') ;
                    $showreason = newGetStrCut($s, 'showreason') ;
                    $ncomputersearch = newGetStrCut($s, 'ncomputersearch') ;
                    $nmobliesearch = newGetStrCut($s, 'nmobliesearch') ;
                    $ncountsearch = newGetStrCut($s, 'ncountsearch') ;
                    $ndegree = newGetStrCut($s, 'ndegree') ;
                    $ndegree = getnumber($ndegree) ;
                    if( $ndegree == '' ){
                        $ndegree = 0 ;
                    }
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values(\'' . $webkeywords . '\',\'' . $showreason . '\',' . $ncomputersearch . ',' . $nmobliesearch . ',' . $ndegree . ')') ;
                }
            }
        }
    }

    //����ͳ��
    connExecute('delete from ' . $GLOBALS['db_PREFIX'] . 'SearchStat') ;
    $content = getDirTxtList($webdataDir . '/SearchStat/') ;
    $splStr = aspSplit($content, vbCrlf()) ;
    hr() ;
    foreach( $splStr as $filePath){
        $fileName = getfilename($filePath) ;
        if( $filePath <> '' && instr('_#', substr($fileName, 0 , 1)) == false ){
            ASPEcho('����ͳ��', $filePath) ;
            $content = getftext($filePath) ;
            $splxx = aspSplit($content, vbCrlf() . '-------------------------------') ;
            foreach( $splxx as $s){
                if( instr($s, '��title��') > 0 ){
                    $title = newGetStrCut($s, 'title') ;
                    $webtitle = newGetStrCut($s, 'webtitle') ;
                    $webkeywords = newGetStrCut($s, 'webkeywords') ;
                    $webdescription = newGetStrCut($s, 'webdescription') ;

                    $customaurl = newGetStrCut($s, 'customaurl') ;
                    $target = newGetStrCut($s, 'target') ;
                    $through = newGetStrCut($s, 'through') ;
                    if( $through == '0' || LCase($through) == 'false' ){
                        $through = 0 ;
                    }else{
                        $through = 1 ;
                    }
                    $sortrank = newGetStrCut($s, 'sortrank') ;
                    if( $sortrank == '' ){ $sortrank = 0 ;}
                    //�Ƿ���������html
                    $isonhtml = newGetStrCut($s, 'isonhtml') ;
                    if( $isonhtml == '0' || LCase($isonhtml) == 'false' ){
                        $isonhtml = 0 ;
                    }else{
                        $isonhtml = 1 ;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow = newGetStrCut($s, 'nofollow') ;
                    if( $nofollow == '1' || LCase($nofollow) == 'true' ){
                        $nofollow = 1 ;
                    }else{
                        $nofollow = 0 ;
                    }
                    //call echo("title",title)
                    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'SearchStat (title,webtitle,webkeywords,webdescription,customaurl,target,through,sortrank,isonhtml,nofollow) values(\'' . $title . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $customaurl . '\',\'' . $target . '\',' . $through . ',' . $sortrank . ',' . $isonhtml . ',' . $nofollow . ')') ;

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
    $splStr = aspSplit($content, vbCrlf()) ;
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
        $c = $c . $s . vbCrlf() ;
    }
    $contentTranscoding = $c ;
    return @$contentTranscoding;
}
?>