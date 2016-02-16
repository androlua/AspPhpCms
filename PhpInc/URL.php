<?PHP
//URL ��ַ���� (2013,9,27)

//NOVBNet start
//ʹ���ֲ�
//GetUrl()��http://127.0.0.1/admin/ProductManage.Aspact=ShowProduct&Bid=318
//GetThisUrl()��http://127.0.0.1/admin/ProductManage.Asp?act=ShowProduct&Bid=318
//GetThisUrlNoParam()��http://127.0.0.1/admin/ProductManage.Asp
//GetGoToUrl()��http://127.0.0.1/admin/ProductManage.Asp?Page=2
//GetGoToUrlNoParam()��http://127.0.0.1/admin/ProductManage.Asp
//GetGoToUrlNoFileName()��http://127.0.0.1/admin/
//WebDoMain()��http://127.0.0.1
//Host()��http://127.0.0.1/
//WebDoMain()��http://127.0.0.1
//GetUrlAddToParam(GetUrl(), "PageSize=20", "replace")


//��õ�ǰ��ַ�޲���
function getThisUrlNoParam(){
    $HttpType ='';
    if( LCase(ServerVariables('HTTPS')) == 'off' ){
        $HttpType = 'http://' ;
    }else{
        $HttpType = 'https://' ;
    }
    $getThisUrlNoParam = $HttpType . ServerVariables('HTTP_HOST') . ServerVariables('SCRIPT_NAME') ;
    return @$getThisUrlNoParam;
}

//��ô�������ַ
function getGoToUrl(){
    $getGoToUrl = ServerVariables('HTTP_REFERER') ;
    return @$getGoToUrl;
}

//��ô�������ַ �޲���
function getGoToUrlNoParam(){
    $getGoToUrlNoParam = getGoToUrl() ;
    if( instr(getGoToUrlNoParam, '?') > 0 ){
        $getGoToUrlNoParam = mid(getGoToUrlNoParam, 1, instr(getGoToUrlNoParam, '?') - 1) ;
    }
    return @$getGoToUrlNoParam;
}

//��ô�������ַ ���ļ�����
function getGoToUrlNoFileName(){
    $getGoToUrlNoFileName = getGoToUrl() ;
    if( substr(getGoToUrlNoFileName, - 1) <> '/' ){
        if( strrpos(getGoToUrlNoFileName, '/') > 0 ){
            $getGoToUrlNoFileName = mid(getGoToUrlNoParam, 1, strrpos(getGoToUrlNoParam, '/')) ;
        }
    }
    return @$getGoToUrlNoFileName;
}

//��ȡ�ͻ���IP��ַ�ڶ���
function getIP2(){

    $x=''; $y=''; $addr ='';
    $x = ServerVariables('HTTP_X_FORWARDED_FOR') ;
    $y = ServerVariables('REMOTE_ADDR') ;
    $addr = IIF(isNul($x) || LCase($x) == 'unknown', $y, $x) ;
    if( instr($addr, '.') == 0 ){ $addr = '0.0.0.0' ;}
    $getIP2 = $addr ;
    return @$getIP2;
}

//��ȡIP��ַ ����д�ú����רҵһ�� ��ȫ


//��÷�����IP
function getServicerIP(){
    $getServicerIP = ServerVariables('LOCAL_ADDR') ;
    return @$getServicerIP;
}

//��÷�����IP   ����
function getRemoteIP(){
    $getRemoteIP = getServicerIP() ;
    return @$getRemoteIP;
}


//NOVBNet end

//������ַ\ת/  '������
function handleHttpUrl($HttpUrl){
    $headStr ='';
    if( IsNul($HttpUrl) ){ }//Ϊ�����˳�
    $HttpUrl = Replace(AspTrim($HttpUrl), '\\', '/') ;
    $headStr = mid($HttpUrl, 1, instr($HttpUrl, ':') + 2) ;
    $HttpUrl = mid($HttpUrl, instr($HttpUrl, ':') + 3,-1) ;
    $HttpUrl = Replace($HttpUrl, 'http://', '��|http|��') ;
    $HttpUrl = Replace($HttpUrl, 'https://', '��|https|��') ;
    $HttpUrl = Replace($HttpUrl, 'ftp://', '��|ftp|��') ;

    while( instr($HttpUrl, '//') > 0){
        $HttpUrl = Replace($HttpUrl, '//', '/') ;
    }
    $HttpUrl = Replace($HttpUrl, '��|http|��', 'http://') ;
    $HttpUrl = Replace($HttpUrl, '��|https|��', 'https://') ;
    $HttpUrl = Replace($HttpUrl, '��|ftp|��', 'ftp://') ;
    $handleHttpUrl = $headStr . $HttpUrl ;
    return @$handleHttpUrl;
}

//�����ļ�/ת\   ʹ����While�жϣ�������
function handleFileUrl($fileUrl){
    $fileUrl = Replace($fileUrl, '/', '\\') ;
    $i ='';
    for( $i = 1 ; $i<= 99; $i++){
        $fileUrl = Replace($fileUrl, '\\\\', '\\') ;

        if( instr($fileUrl, '\\\\') == false ){
            break;
        }
    }
    $handleFileUrl = $fileUrl ;
    return @$handleFileUrl;
}

//������ַ������
function handleUrlComplete($HttpUrl){
    $LastStr ='';
    $handleUrlComplete = $HttpUrl ;
    if( instr($HttpUrl, '?') > 0 ){ return @$handleUrlComplete; }//��?�������˳�
    //��ַ���û��/  �ж����Ϊ���� ����������/�˳�
    if( substr($HttpUrl, - 1) <> '/' ){
        if( $HttpUrl . '/' == GetWebSite($HttpUrl) ){
            $handleUrlComplete = $HttpUrl . '/' ;
            return @$handleUrlComplete;
        }
    }
    $LastStr = mid($HttpUrl, strrpos($HttpUrl, '/') + 1,-1) ;
    if( $LastStr <> '' && instr($LastStr, '.') == false ){
        $handleUrlComplete = $HttpUrl . '/' ;
    }
    return @$handleUrlComplete;
}

//����ַ�������
function urlAddHttpUrl($HttpUrl, $url){
    $HttpUrl = Replace($HttpUrl, '\\', '/') ;
    $url = handleHttpUrl($url) ;
    if( instr(LCase($url), 'http://') == 0 && instr(LCase($url), 'www.') == 0 ){
        if( substr($HttpUrl, - 1) == '/' && substr($url, 0 , 1) == '/' ){
            $url = $HttpUrl . mid($url, 2,-1) ;
        }else if( substr($HttpUrl, - 1) <> '/' && substr($url, 0 , 1) <> '/' ){
            $url = $HttpUrl . '/' . $url ;
        }else{
            $url = $HttpUrl . $url ;
        }
    }
    $urlAddHttpUrl = $url ;
    return @$urlAddHttpUrl;
}

//�������
function webDoMain(){
    $Port=''; $HttpType ='';
    $Port = ServerVariables('SERVER_PORT') ;
    if( $Port <> 80 ){ $Port = ':' . $Port ;}else{ $Port == '' ;}
    $webDoMain = 'http://' . ServerVariables('SERVER_NAME') . $Port ;
    return @$webDoMain;
}

//��õ�ǰ����


//��õ�ǰ���� (����)


//��õ�ǰ���� (����)


//���õ�ǰ��ַ


//��õ�ǰ��������ַ
function getThisUrl(){
    $url='';
    //vbdel start
    $url = 'http://' . ServerVariables('server_name') . ServerVariables('script_name') ;
    if( ServerVariables('QUERY_STRING') <> '' ){ $url = $url . '?' . ServerVariables('QUERY_STRING') ;}
    //vbdel end
    $getThisUrl=$url;
    return @$getThisUrl;
}

//������ַ �������
function getWebSite( $HttpUrl){
    //On Error Resume Next
    //�°�����������
    $url=''; $TempHttpUrl ='';
    $TempHttpUrl = $HttpUrl ;
    $url = AspTrim(LCase(Replace($HttpUrl, '?', '/'))) ;
    $url = Replace(Replace($url, '\\', '/'), 'http://', '') ;
    if( instr($url, '/') > 0 ){ $url = mid($url, 1, instr($url, '/') - 1) ;}
    $url = 'http://' . $url . '/' ;
    $splStr=''; $s=''; $c ='';
    $HttpUrl = Replace(LCase($HttpUrl), 'http://', '') ;
    if( instr($HttpUrl, '?') > 0 ){ $HttpUrl = mid($HttpUrl, 1, instr($HttpUrl, '?') - 1) ;}
    if( substr($HttpUrl, 0 , 9) == 'localhost' ){
        if( instr($HttpUrl, '/') > 0 ){
            $HttpUrl = mid($HttpUrl, 1, instr($HttpUrl, '/') - 1) ;
        }else{
            $HttpUrl = 'localhost' ;
        }
    }else if( substr($HttpUrl, 0 , 8) == '192.168.' || substr($HttpUrl, 0 , 9) == '127.0.0.1' ){
        $HttpUrl = $HttpUrl . '/' ;
        $HttpUrl = 'http://' . mid($HttpUrl, 1, instr($HttpUrl, '/') - 1) . '/' ;
        $getWebSite = $HttpUrl ; return @$getWebSite;
    }else{
        $splStr = aspSplit($HttpUrl, '.') ;
        if((instr($HttpUrl, 'www.') > 0 && UBound($splStr) >= 2) || UBound($splStr) >= 1 ){
            if( instr($HttpUrl, '/') > 0 ){
                $s = mid($HttpUrl, 1, instr($HttpUrl, '/') - 1) ;
                if( $s == GetDianNumb($s) ){
                    $HttpUrl = $s ;
                }
            }
        }else{
            $HttpUrl = '' ;//û����Ϊ��
        }
    }
    $c = '.com.hk|.sh.cn|.com.cn|.net.cn|.org.cn' ;
    $c = $c . '|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in' ;
    $splStr = aspSplit($c, '|') ;
    foreach( $splStr as $s){
        if( $s <> '' ){
            if( instr($HttpUrl, $s) > 0 ){
                $HttpUrl = 'http://' . substr($HttpUrl, 0 , instr($HttpUrl, $s) + strlen($s) - 1) . '/' ; break;
            }
        }
    }
    $getWebSite = substr($HttpUrl, 0 , 255) ;//���������ڣ���ֻ��ȡ255���ַ�
    //GetWebSite = ""                        '������������Ϊ�� 20150104
    if( $getWebSite == 'http:///' ){ $getWebSite = '' ;}//û���ҵ�����

    return @$getWebSite;
}
//����Ƿ�Ϊ��ַ
function checkUrl($url){
    $checkUrl = IIF(getWebSite($url) == '', false, true) ;
    return @$checkUrl;
}
//����Ƿ�Ϊ��ַ
function checkHttpUrl($url){
    $checkHttpUrl = checkUrl($url) ;
    return @$checkHttpUrl;
}
//����Ƿ�Ϊ��ַ
function isUrl($url){
    $isUrl = checkUrl($url) ;
    return @$isUrl;
}
//����Ƿ�Ϊ��ַ
function isHttpUrl($url){
    $isHttpUrl = checkUrl($url) ;
    return @$isHttpUrl;
}

//������ַ
function fullHttpUrl( $httpUrl, $url){
    //On Error Resume Next
    //������� Ҫ��Ȼ�ᱨ��
    $rootUrl=''; $thisUrl=''; $splStr=''; $i=''; $s=''; $c=''; $parentUrl=''; $parentParentUrl=''; $parentParentParentUrl=''; $rootWebSite=''; $thisWebSite=''; $handleYes ='';
    $httpUrl = pHPTrim($httpUrl) ;//������߿ո�
    $url = pHPTrim($url) ;//������߿ո�

    if( $url == '' ){ $fullHttpUrl = '' ; return @$fullHttpUrl; }//��ַΪ���˳�(20150805)
    if( AspTrim($httpUrl) == '' ){ $fullHttpUrl = $url ; return @$fullHttpUrl; }//����ַΪ���˳� ������ַ
    $httpUrl = Replace($httpUrl, '\\', '/') ;//����ַ\ת/����
    $url = Replace($url, '\\', '/') ;//����ַ\ת/����

    //��ַǰ�����ַ�Ϊ//���˳�
    if( substr($url, 0 , 2) == '//' ){
        $fullHttpUrl = 'http:' . $url ;
        return @$fullHttpUrl;
    }


    $rootUrl = getWebSite($httpUrl) ;//��������Ҳ��������ַ
    $rootWebSite = $rootUrl ;
    $thisWebSite = getWebSite($url) ;
    if( substr($rootUrl, - 1) == '/' ){ $rootUrl = substr($rootUrl, 0 , strlen($rootUrl) - 1) ;}
    $thisUrl = substr($httpUrl, 0 , strrpos($httpUrl, '/')) ;//��ǰ��ַ
    $splStr = aspSplit($httpUrl, '/') ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        if( $i + 1 == UBound($splStr) ){ $parentUrl = $c ;}
        if( $i + 2 == UBound($splStr) ){ $parentParentUrl = $c ;}
        if( $i + 3 == UBound($splStr) ){ $parentParentParentUrl = $c ;}
        $s = $splStr[$i] ;
        $c = $c . $s . '/' ;
    }
    $url = AspTrim($url) ;//ȥ����ַ���ҿո�
    $handleYes = false ;//����Ϊ��
    if( $url <> '' && instr(substr($url, 0 , 10), 'www.') == false && instr(substr($url, 0 , 10), 'http://') == false && instr(substr($url, 0 , 10), 'https://') == false ){
        $handleYes = true ;
        if( $rootWebSite <> $thisWebSite ){
            if( $rootWebSite == Replace($thisWebSite, 'http://', 'http://www.') ){
                $handleYes = false ;
                if( instr(LCase($url), 'http://') > 0 ){
                    $url = 'http://www.' . substr($url, - strlen($url) - 7) ;
                }else{
                    $url = 'http://www.' . $url ;
                }
            }
        }
    }
    //�����Ƿ�Ϊ��
    if( $handleYes == true ){
        if( substr($url, 0 , 1) == '/' ){
            $url = $rootUrl . $url ;
        }else if( substr($url, 0 , 9) == '../../../' ){
            $url = $parentParentParentUrl . substr($url, - strlen($url) - 9) ;
        }else if( substr($url, 0 , 6) == '../../' ){
            $url = $parentParentUrl . substr($url, - strlen($url) - 6) ;
        }else if( substr($url, 0 , 3) == '../' ){
            $url = $parentUrl . substr($url, - strlen($url) - 3) ;
        }else if( substr($url, 0 , 2) == './' ){
            $url = $thisUrl . mid($url, 3,-1) ;
        }else{
            $url = $thisUrl . $url ;
        }
    }
    if( instr(LCase($httpUrl), 'http://') > 0 && instr(LCase($url), 'http://') == 0 ){
        $url = 'http://' . $url ;
    }else if( instr(LCase($httpUrl), 'https://') > 0 && instr(LCase($url), 'https://') == 0 ){
        $url = 'https://' . $url ;
    }
    $fullHttpUrl = $url ;

    return @$fullHttpUrl;
}

//����������ַ����20150728
function batchFullHttpUrl($website, $urlList){
    $splStr=''; $url=''; $c ='';
    $splStr = aspSplit($urlList, "\n") ;
    foreach( $splStr as $url){
        if( strlen($url) > 3 ){
            if( $c <> '' ){ $c = $c . "\n" ;}
            $c = $c . fullHttpUrl($website, $url) ;
        }
    }
    $batchFullHttpUrl = $c ;
    return @$batchFullHttpUrl;
}


//��ַ�����ַ� ��ദ��
function uRLJianJieHandle( $url){
    $url = Replace($url, '&amp;', '&') ;
    $uRLJianJieHandle = $url ;
    return @$uRLJianJieHandle;
}

//URL���� �������С�������
function urlToAsc($url){
    $i ='';
    for( $i = 1 ; $i<= strlen($url); $i++){
        $urlToAsc = urlToAsc . '%' . Hex(AscW(mid($url, $i, 1))) ;
    }
    return @$urlToAsc;
}


//�����վ����
function getWebTitle($content){
    $getWebTitle = MyStrCut($content, '<title>', '</title>', 0) ;
    return @$getWebTitle;
}

//��ý�ȡ����
function myStrCut($content, $startStr, $endStr, $CutType){
    $TempContent=''; $nLeftLen=''; $nRightLen ='';
    $TempContent = LCase($content) ;
    if( instr($TempContent, $startStr) > 0 && instr($TempContent, $endStr) > 0 ){
        $nLeftLen = instr($TempContent, $startStr) + strlen($startStr) ;
        $nRightLen = instr($TempContent, $endStr) - $nLeftLen ;
        $myStrCut = mid($content, $nLeftLen, $nRightLen) ;
        if( $CutType == 1 || $CutType == 3 ){ $myStrCut = $startStr . myStrCut ;}
        if( $CutType == 2 || $CutType == 3 ){ $myStrCut = myStrCut . $endStr ;}
    }
    return @$myStrCut;
}

//���������ַ�б� (ȱ������ַȫ��Сд��20150728)
function getContentAHref($HttpUrl, $content, $PubAHrefList, $PubATitleList){
    $i=''; $s=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( $s == '<' ){
            $TempS = LCase(mid($content, $i,-1)) ;
            $LalType = LCase(mid($TempS, 1, instr($TempS, ' '))) ;
            if( $LalType == '<a ' ){
                $LalStr = mid($TempS, 1, instr($TempS, '</') + 2) ;
                $nLen = strlen($LalStr) - 1 ;
                $c = $c . HandleLink($HttpUrl, $LalStr, 'href', '', 'url', $PubAHrefList, $PubATitleList) . "\n" ;
                $i = $i + $nLen ;
            }
        }
        DoEvents ;
    }
    if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - 2) ;}
    $getContentAHref = $c ;
    return @$getContentAHref;
}

//���������ͼƬ�б�
function getContentImgSrc($HttpUrl, $content, $PubAHrefList, $PubATitleList){
    $i=''; $s=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( $s == '<' ){
            $TempS = LCase(mid($content, $i,-1)) ;
            $LalType = LCase(mid($TempS, 1, instr($TempS, ' '))) ;
            if( $LalType == '<img ' ){
                $LalStr = mid($TempS, 1, instr($TempS, '>')) ;
                $nLen = strlen($LalStr) - 1 ;
                //Call Echo(I,LalStr)
                $c = $c . HandleLink($HttpUrl, $LalStr, 'src', '', 'url', $PubAHrefList, $PubATitleList) . "\n" ;
                $i = $i + $nLen ;
            }
        }
        DoEvents ;
    }
    if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - 2) ;}
    $getContentImgSrc = $c ;
    return @$getContentImgSrc;
}

//����������ַ����
function handleConentUrl($HttpUrl, $content, $PubAHrefList, $PubATitleList){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( $s == '<' ){
            $YuanStr = mid($content, $i,-1) ;
            $TempS = LCase($YuanStr) ;
            $TempS = Replace(Replace($TempS, Chr(10), ' ' . "\n"), Chr(13), ' ' . "\n") ;//�ô���ͼƬ�زĸ�����  ����  <img����src=""  Ҳ���Ի�� 20150714
            $LalStr = mid($YuanStr, 1, instr($YuanStr, '>')) ;
            $LalType = LCase(mid($TempS, 1, instr($TempS, ' '))) ;
            if( $LalType == '<link ' ){
                $nLen = strlen($LalStr) - 1 ;
                $c = $c . HandleLink($HttpUrl, $LalStr, 'href', '', '', $PubAHrefList, $PubATitleList) ;
                $i = $i + $nLen ;
            }else if( $LalType == '<img ' ){
                $nLen = strlen($LalStr) - 1 ;
                $c = $c . HandleLink($HttpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList) ;
                $i = $i + $nLen ;
            }else if( $LalType == '<a ' ){
                $nLen = strlen($LalStr) - 1 ;
                //û��javascript�����У����ǻ����в���֮��
                if( instr(LCase($LalStr), 'javascript:') == 0 ){
                    $c = $c . HandleLink($HttpUrl, $LalStr, 'href', '', '', $PubAHrefList, $PubATitleList) ;
                }else{
                    $c = $c . $LalStr ;
                }
                $i = $i + $nLen ;
            }else if( $LalType == '<script ' ){
                $nLen = strlen($LalStr) - 1 ;
                if( instr(LCase($LalStr), 'src') > 0 ){
                    $c = $c . HandleLink($HttpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList) ;
                }else{
                    $c = $c . $LalStr ;
                }
                $i = $i + $nLen ;
            }else if( $LalType == '<embed ' ){
                $nLen = strlen($LalStr) - 1 ;
                $c = $c . HandleLink($HttpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList) ;
                $i = $i + $nLen ;
            }else if( $LalType == '<param ' ){
                $nLen = strlen($LalStr) - 1 ;
                if( instr(LCase($LalStr), 'movie') > 0 ){
                    $c = $c . HandleLink($HttpUrl, $LalStr, 'value', '', '', $PubAHrefList, $PubATitleList) ;
                }else{
                    $c = $c . $LalStr ;
                }
                $i = $i + $nLen ;
            }else if( $LalType == '<meta ' ){
                $nLen = strlen($LalStr) - 1 ;
                //�滻�ؼ���
                if( instr(LCase($LalStr), 'keywords') > 0 ){
                    $c = $c . HandleLink($HttpUrl, $LalStr, 'content', $GLOBALS['WebKeywords'], '', $PubAHrefList, $PubATitleList) ;
                    //�滻��վ����
                }else if( instr(LCase($LalStr), 'description') > 0 ){
                    $c = $c . HandleLink($HttpUrl, $LalStr, 'content', $GLOBALS['WebDescription'], '', $PubAHrefList, $PubATitleList) ;
                }else{
                    $c = $c . $LalStr ;
                }
                $i = $i + $nLen ;
            }else{
                $c = $c . $s ;
            }
        }else{
            $c = $c . $s ;
        }
        DoEvents ;
    }
    $handleConentUrl = $c ;
    return @$handleConentUrl;
}


//�滻������ȫ��JsĿ¼ 20150722
function replaceContentJsDir($content, $dirPath, $PubAHrefList, $PubATitleList){
    $splStr=''; $s=''; $c ='';
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $s){
        if( $c <> '' ){ $c = $c . "\n" ;}
        if( instr($s, '<script ') > 0 && instr($s, '</script>') > 0 ){
            $s = HandleLink($dirPath, $s, 'src', '', 'replaceDir', $PubAHrefList, $PubATitleList) ;
        }
        $c = $c . $s ;
    }
    $replaceContentJsDir = $c ;
    return @$replaceContentJsDir;
}


//�������ӵ�ַ HttpUrl=׷����ַ��Content=����  SType=����
//�滻Ŀ¼����  call rw(HandleLink("Js/", "111111<script src=""js/Jquery.Min.js""></"& "script>","src", "", "replaceDir"))


//�����վĿ¼�ļ������� \Templates\WeiZhanLue\  �õ�WeiZhanLue
function getEndUrlHandleName($FileUrl){
    $url ='';
    $url = Replace(AspTrim($FileUrl), '\\', '/') ;
    if( substr($url, - 1) == '/' ){ $url = mid($url, 1, strlen($url) - 1) ;}
    $url = mid($url, strrpos($url, '/') + 1,-1) ;
    $getEndUrlHandleName = $url ;
    return @$getEndUrlHandleName;
}

//�ж��Ƿ�Ϊ����IP���������Ϊ�����ļ��мӸ���Ӧ��վ����
function getWebFolderName(){
    if( getIP == '127.0.0.1' || instr(getIP, '192.168.') > 0 ){
        $getWebFolderName = '/wwwroot/' . $GLOBALS['WebFolderName'] . '/' ;
    }
    return @$getWebFolderName;
}

//�����վ��ҳ
function getWebHome(){
    $url ='';
    if( getIP == '127.0.0.1' || instr(getIP, '192.168.') > 0 ){
        $GLOBALS['conn=']=OpenConn() ;
        $rsObj=$GLOBALS['conn']->query( 'Select * From [WebSite]');
        $rs=mysql_fetch_array($rsObj);
        if( @mysql_num_rows($rsObj)!=0 ){
            $getWebHome = '/wwwroot/' . getEndUrlHandleName($rs['webskins']) . '/Index.html' ;
        }
    }
    if( $getWebHome == '' ){
        $getWebHome = '/Index.html' ;
    }
    return @$getWebHome;
}

//����б��в�ͬ�����б�
function getUrlListInWebSiteList($content){
    $url=''; $UrlList=''; $splStr ='';
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $url){
        $url = getWebSite($url) ;
        if( $url <> '' && instr("\n" . $UrlList . "\n", "\n" . $url . "\n") == 0 ){
            $UrlList = $UrlList . $url . "\n" ;
        }
        Doevents ;
    }
    $getUrlListInWebSiteList = $UrlList ;
    return @$getUrlListInWebSiteList;
}

//��õ�ǰ��ַ���ļ�����
function getThisUrlFileName(){
    $url ='';
    $url = ServerVariables('SCRIPT_NAME') ;
    if( substr($url, 0 , 1) == '/' ){ $url = substr($url, - strlen($url) - 1) ;}
    $getThisUrlFileName = $url ;
    return @$getThisUrlFileName;
}

//������վHTML��Img    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)
function handleWebHtmlImg($RootPath, $content, $PubAHrefList, $PubATitleList){
    $ImgList=''; $splStr=''; $ImgUrl=''; $NewImgUrl ='';
    $startStr=''; $endStr ='';
    $ImgList = getContentImgSrc('', $content, $PubAHrefList, $PubATitleList) ;
    $splStr = aspSplit($ImgList, "\n") ;
    foreach( $splStr as $ImgUrl){
        if( $ImgUrl <> '' ){
            $NewImgUrl = handleHttpUrl($ImgUrl) ;
            if( instr($NewImgUrl, '/') > 0 ){
                $NewImgUrl = mid($NewImgUrl, strrpos($NewImgUrl, '/') + 1,-1) ;
            }
            $NewImgUrl = $RootPath . $NewImgUrl ;
            //Call Echo(NewImgUrl,ImgUrl)
            $startStr = 'src="' ; $endStr = '"' ;
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $content = RegExp_Replace($content, $startStr . $ImgUrl . $endStr, $startStr . $NewImgUrl . $endStr) ;
            }
            $startStr = 'src=\'' ; $endStr = '\'' ;
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $content = RegExp_Replace($content, $startStr . $ImgUrl . $endStr, $startStr . $NewImgUrl . $endStr) ;
            }
        }
    }
    $handleWebHtmlImg = $content ;
    return @$handleWebHtmlImg;
}

//������վCss��Img    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)
function handleWebCssImg($RootPath, $content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $ImgUrl=''; $NewImgUrl ='';
    $startStr = 'url\\(' ;
    $endStr = '\\)' ;
    $ImgList = GetArray($content, $startStr, $endStr, false, false) ;
    //Call RwEnd(ImgList)
    $splStr = aspSplit($ImgList, '$Array$') ;
    foreach( $splStr as $ImgUrl){
        if( $ImgUrl <> '' ){
            $NewImgUrl = handleHttpUrl($ImgUrl) ;
            if( instr($NewImgUrl, '/') > 0 ){
                $NewImgUrl = mid($NewImgUrl, strrpos($NewImgUrl, '/') + 1,-1) ;
            }
            $NewImgUrl = $RootPath . $NewImgUrl ;
            $startStr = 'url(' ;
            $endStr = ')' ;
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                //call echo(StartStr,"StartStr")
                $content = RegExp_Replace($content, $startStr . $ImgUrl . $endStr, $startStr . $NewImgUrl . $endStr) ;
            }
        }
    }
    $handleWebCssImg = $content ;
    return @$handleWebCssImg;
}

//����������ַ������
function batchHandleUrlIntegrity($HttpUrl, $UrlList){
    $SplUrl=''; $url=''; $c ='';
    $SplUrl = aspSplit($UrlList, "\n") ;
    foreach( $SplUrl as $url){
        if( $url <> '' ){
            $url = fullHttpUrl($HttpUrl, $url) ;
            if( instr("\n" . $c . "\n", "\n" . $url . "\n") == false ){
                $c = $c . $url . "\n" ;
            }
        }
    }
    $batchHandleUrlIntegrity = $c ;
    return @$batchHandleUrlIntegrity;
}

//��������������ͼƬ·�� Ŀ¼����ʾͼƬ
function replaceContentImagePath($RootFolder, $content){
    $ImageFile=''; $ToImageFile=''; $ImageList=''; $splxx ='';
    $RootFolder = handleHttpUrl($RootFolder) ;
    if( substr($RootFolder, - 1) <> '/' ){ $RootFolder = $RootFolder . '/' ;}
    $ImageList = GetDirFileNameList($RootFolder) ;
    $splxx = aspSplit($ImageList, "\n") ;
    foreach( $splxx as $ImageFile){
        if( $ImageFile <> '' ){
            $ToImageFile = 'file:///' . $RootFolder . $ImageFile ;
            //html��ͼƬ·���滻
            $content = Replace($content, '"' . $ImageFile . '"', '"' . $ToImageFile . '"') ;
            $content = Replace($content, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"') ;
            $content = Replace($content, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"') ;
            $content = Replace($content, '=' . $ImageFile . '>', '"' . $ToImageFile . '"') ;
            //Css��ͼƬ·���滻
            $content = Replace($content, '(' . $ImageFile . ')', '(' . $ToImageFile . ')') ;
            $content = Replace($content, '(' . $ImageFile . ';', '(' . $ToImageFile . ';') ;
        }
    }
    $replaceContentImagePath = $content ;
    return @$replaceContentImagePath;
}

//���Css�����б� ������
function getCssLinkList( $content){
    $startStr=''; $endStr=''; $splStr=''; $s=''; $c=''; $fileName ='';
    $startStr = '<link' ; $endStr = '/>' ;
    $content = GetArray($content, $startStr, $endStr, false, false) ;
    $splStr = aspSplit($content, '$Array$') ;
    foreach( $splStr as $s){
        if( instr(LCase($s), 'stylesheet') > 0 ){
            $fileName = StrCut($s, 'href="', '"', 2) ;
            ASPEcho($fileName, $s) ;
            $c = $c . $fileName . "\n" ;
        }
    }
    $getCssLinkList = $c ;
    return @$getCssLinkList;
}

//���Html��ͼƬ��ַ�б�
function getHtmlBackGroundUrlList($content){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c=''; $startStr=''; $endStr ='';
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( $s == '<' ){
            $YuanStr = mid($content, $i,-1) ;
            $TempS = LCase($YuanStr) ;
            $LalStr = mid($YuanStr, 1, instr($YuanStr, '>')) ;
            $LalType = LCase(mid($TempS, 1, instr($TempS, ' '))) ;
            if( instr($LalStr, 'url(') > 0 ){
                $startStr = 'url(' ; $endStr = ')' ;
                $c = $c . StrCut($LalStr, $startStr, $endStr, 2) . "\n" ;
                $i = $i + $nLen ;
            }
        }
        DoEvents ;
    }
    $getHtmlBackGroundUrlList = $c ;
    return @$getHtmlBackGroundUrlList;
}

//���ͼƬ��ַ�б�
function getImgUrlList($content){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( $s == '<' ){
            $YuanStr = mid($content, $i,-1) ;
            $TempS = LCase($YuanStr) ;
            $LalStr = mid($YuanStr, 1, instr($YuanStr, '>')) ;
            $LalType = LCase(mid($TempS, 1, instr($TempS, ' '))) ;
            if( $LalType == '<img ' ){
                $c = $c . GetLinkUrl($LalStr, 'src') . "\n" ;
                $i = $i + $nLen ;

            }
        }
        DoEvents ;
    }
    $getImgUrlList = $c ;
    return @$getImgUrlList;
}

//���img��a��ַ ��GetLinkUrl(LalStr, "src")
function getLinkUrl( $LinkStr, $LinkType){
    $TempLinkStr=''; $startStr=''; $endStr=''; $LinkUrl ='';
    $LinkStr = Replace(Replace($LinkStr, '= ', '='), '= ', '=') ;
    $LinkStr = Replace(Replace($LinkStr, ' =', '='), ' =', '=') ;
    $TempLinkStr = LCase($LinkStr) ;

    $startStr = $LinkType . '="' ;
    $endStr = '"' ;
    if( instr($TempLinkStr, $startStr) > 0 && instr($TempLinkStr, $endStr) > 0 ){
        $LinkUrl = StrCut($TempLinkStr, $startStr, $endStr, 2) ;
        $getLinkUrl = $LinkUrl ;
    }
    return @$getLinkUrl;
}

//�Ǳ�����ַ�򱾵���ַ        20141120
function localUrlOrRemoteUrl($filePath, $UrlYes){
    $HttpUrl ='';
    $UrlYes = false ;
    $filePath = AspTrim($filePath) ;
    $HttpUrl = Replace($filePath, '\\', '/') ;
    if( substr(LCase($HttpUrl), 0 , 7) == 'http://' || substr(LCase($HttpUrl), 0 , 4) == 'www.' || substr(LCase($HttpUrl), 0 , 4) == '[��ַ]' ){
        $UrlYes = true ;
    }
    if( $UrlYes == false ){
        $filePath = SetFileName($filePath) ;
    }
    $localUrlOrRemoteUrl = $filePath ;
    return @$localUrlOrRemoteUrl;
}

//����Ƿ�ΪԶ����ַ
function checkRemoteUrl($url){
    $HttpUrl ='';
    $url = AspTrim($url) ;
    $HttpUrl = Replace(UnSetFileName($url), '\\', '/') ;
    $checkRemoteUrl = false ;
    if( substr(LCase($HttpUrl), 0 , 7) == 'http://' || substr(LCase($HttpUrl), 0 , 4) == 'www.' || substr(LCase($HttpUrl), 0 , 4) == '[��ַ]' ){
        if( substr(LCase($HttpUrl), 0 , 4) == '[��ַ]' ){
            $url = mid($url, instr($url, '[��ַ]') + 1,-1) ;
        }
        $checkRemoteUrl = true ;
    }
    return @$checkRemoteUrl;
}

//�ж�Url�����Ƿ��.html��׺
function getHandleUrl( $url){
    $s ='';
    $url = CStr(AspTrim($url)) ;
    if( $url <> '' ){
        $url = Replace(AspTrim($url), '\\', '/') ;
        if( instr($url, '://') == false ){ $url = Replace(Replace($url, '//', '/'), '//', '/') ;}
    }
    if( substr($url, 0 , 1) <> '/' && substr($url, - 1) <> '/' ){
        $url = '/Html/' . $url . '.Html' ;
    }else if( substr(LCase($url), - 4) <> '.html' ){ //����û��.html ������
        $s = mid($url, strrpos($url, '/') + 1,-1) ;
        if( instr($s, '.') == false ){
            if( $s <> '' ){
                $url = $url . '.Html' ;
            }
        }
    }
    $getHandleUrl = $url ;
    return @$getHandleUrl;
}

//��վ������ַ���� (20140408�Ľ�)
function webDebug($url, $DebugUrl){
    if( @$_GET['Debug'] <> '' ){
        if( getwebsite($DebugUrl) <> '' ){
            $url = $DebugUrl ;
            $webDebug = $url ;
            return @$webDebug;
        }else{
            $url = '/Inc/Create_Html.Asp?Debug=1&' . $DebugUrl ;
        }
        if( @$_REQUEST['MackHtml'] == 'False' ){
            $url = $url . '&MackHtml=False' ;
        }
        if( @$_REQUEST['gl'] <> '' ){
            $url = $url . '&gl=' . @$_REQUEST['gl'] ;
        }
    }else{
        if( CheckMakeHtmlFile($url) == true ){
            $url = LCase($url) ;//��URL����Сдת��
        }
    }
    if( CheckMakeHtmlFile($url) == true ){
        $url = fullHttpUrl(host(), $url) ;//����ַ����
    }else{
        //׷����20141231  ԭ����Ϊ�ļ����ƿ��Զ�����ַ url:
        $url = AspTrim($url) ;
        if( substr(LCase($url), 0 , 4) == 'url:' ){
            $url = mid($url, 5,-1) ;
        }
        if( substr(LCase($url), 0 , 5) == '/url:' ){
            $url = mid($url, 6,-1) ;
        }
        $url = HandleTemplateAction($url, false) ;

    }

    $webDebug = $url ;
    return @$webDebug;
}

//�������ƣ�AsaiLinkAdd   20141217���ñ���
//�������ã������Զ��������
//����Response.Write AsaiLinkAdd("http://www.wzl99.com/С�С��http://www.wzl99.com/С�С��http://www.wzl99.com//С�С��http://www.wzl99.com/С�С��http://www.wzl99.com/С�С��www.wzl99.com/С�С��fengying789@126.comС�С��")
function asaiLinkAdd($str){ //���պ���
}

//�������ƣ�AsaiLinkDel Asai(ǳ��)   20141217���ñ���
//�������ã������Զ�ȥ������
//����Response.Write AsaiLinkDel("<a href='http://www.wzl99.com/' target='_blank'>http://www.wzl99.com/</a>С�С��<a href='http://www.wzl99.com/' target='_blank'>http://www.wzl99.com/</a>С�")
function asaiLinkDel($htmlStr){ //���պ���
}

//�ж������Ƿ�Ϸ�  �ݴ�
function iswww($strng){ //���պ���
}


//��ǿ��20150220
//׷����ַ����20150121  getUrlAddToParam("aa","&a=b","replace")   addto replace    STypeΪ׷�ӻ����滻
//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","")        'http://www.baidu.com/?a=1&b=2&c=3
//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","replace")        'http://www.baidu.com/?a=11&b=22&c=333
//Url = getUrlAddToParam(GetUrl(),"id=" & Rs("Id"),"replace")
//Call Echo(Url,getUrlAddToParam(Url,"id=1&aa=1&bb=2","delete"))          ����ɾ������
function getUrlAddToParam( $url, $AddToUrl, $SType){
    $content=''; $splStr=''; $splxx=''; $s=''; $c=''; $HttpUrl=''; $UrlFileName=''; $WebSite ='';
    $UrlParam ='';//��ַ���� �ǻ����ַ��̨����ֵ
    $ParamName ='';//��������
    $ParamValue ='';//����ֵ
    $ParamNameList ='';//���������б���ֹ�ظ�
    $HandleYes ='';//����Ϊ��

    $AddToUrl = handleHttpUrl($AddToUrl) ;

    //������ַ
    $url = AspTrim($url) ;
    //��ǰ��ַ���һ���ַ�Ϊ?��&��ɾ���� ����
    if( substr($url, - 1) == '?' || substr($url, - 1) == '&' ){
        $url = AspTrim(mid($url, 1, strlen($url) - 1)) ;
    }
    //����׷����ַ
    $AddToUrl = AspTrim($AddToUrl) ;
    //׷����ַ���һ���ַ�Ϊ?��&��ɾ���� ����
    if( substr($AddToUrl, 0 , 1) == '?' || substr($AddToUrl, 0 , 1) == '&' ){
        $AddToUrl = AspTrim(mid($AddToUrl, 2,-1)) ;
    }
    //��ַΪ���򷵻�׷����ַ ���˳�
    if( $url == '' ){ $getUrlAddToParam = '?' . $AddToUrl ; return @$getUrlAddToParam; }

    $HttpUrl = $url ;
    if( instr($url, '?') > 0 ){
        $HttpUrl = mid($url, 1, instr($url, '?') - 1) ;//��õ�ǰ·����ַ
        $WebSite = getWebSite($url) ;//��������
        $UrlParam = mid($url, instr($url, '?') + 1,-1) ;

        $HttpUrl = handleHttpUrl($HttpUrl) ;
        if( substr($HttpUrl, - 1) <> '/' ){
            $UrlFileName = mid($HttpUrl, strrpos($HttpUrl, '/') + 1,-1) ;
            $HttpUrl = substr($HttpUrl, 0 , strlen($HttpUrl) - strlen($UrlFileName)) ;
            //Call Echo(HttpUrl,UrlFileName)
        }
    }

    //����ѡ��  ׷�� �����滻
    if( LCase($SType) == 'replace' || $SType == '�滻' ){
        $content = $AddToUrl . '&' . $UrlParam ;
        //Call echo("Content",Content)
        if( instr($AddToUrl, '?') > 0 ){
            $UrlFileName = mid($AddToUrl, 1, instr($AddToUrl, '?') - 1) ;
            //Call Echo(AddToUrl,UrlFileName)
        }
    }else if((LCase($SType) <> 'delete' || LCase($SType) <> 'del') ){
        $content = $UrlParam . '&' . $AddToUrl ;
    }

    $content = Replace($content, '?', '&') ;

    //����ɾ������ 20150210
    if( LCase($SType) == 'delete' || LCase($SType) == 'del' ){
        $splStr = aspSplit(LCase($AddToUrl), '&') ; $AddToUrl = '&' ;
        foreach( $splStr as $s){
            if( instr($s, '=') ){
                $s = mid($s, 1, instr($s, '=') - 1) ;
            }
            if( $s <> '' ){
                $AddToUrl = $AddToUrl . $s . '&' ;
            }
        }
        //Call Eerr("AddToUrl",AddToUrl)
    }

    //Call Echo("Content",Content)
    $splStr = aspSplit($content, '&') ;
    foreach( $splStr as $s){
        if( instr($s, '=') > 0 ){
            $splxx = aspSplit($s, '=') ;
            $ParamName = $splxx[0] ;
            $ParamValue = $splxx[1] ;

            $HandleYes = true ;

            if( LCase($SType) == 'delete' || LCase($SType) == 'del' ){
                if( instr('&' . $AddToUrl . '&', '&' . LCase($ParamName) . '&') > 0 ){
                    $HandleYes = false ;
                }
            }

            if( instr('|' . $ParamNameList . '|', '|' . LCase($ParamName) . '|') == false && $HandleYes == true ){
                $ParamNameList = $ParamNameList . LCase($ParamName) . '|' ;
                $c = $c . IIF($c == '', '?', '&') ;
                $c = $c . $ParamName . '=' . $ParamValue ;
            }
        }
    }



    $c = $UrlFileName . $c ;
    if( getWebSite($c) == '' ){
        if( substr($AddToUrl, 0 , 1) == '/' ){
            $c = $WebSite . $c ;
        }else{
            $c = $HttpUrl . $c ;
        }

    }


    $getUrlAddToParam = $c ;
    return @$getUrlAddToParam;
}




//�����ַ 20150706 call echo("",groupUrl("www.baidu.com//","/1.asp"))
function groupUrl($url1, $url2){
    $urlType=''; $i ='';
    $urlType = '/' ;
    $url1 = Replace($url1, IIF($urlType == '/', '\\', '/'), $urlType) ;
    $url2 = Replace($url2, IIF($urlType == '/', '\\', '/'), $urlType) ;
    $url1 = phptrim($url1) ;
    $url2 = phptrim($url2) ;
    for( $i = 0 ; $i<= 99; $i++){
        if( substr($url1, - 1) == $urlType ){
            $url1 = mid($url1, 1, strlen($url1) - 1) ;
        }else{
            break;
        }
    }
    for( $i = 0 ; $i<= 99; $i++){
        if( substr($url2, 0 , 1) == $urlType ){
            $url2 = mid($url2, 2,-1) ;
        }else{
            break;
        }
    }
    $groupUrl = $url1 . $urlType . $url2 ;
    return @$groupUrl;
}



//����POST��Cookes���ͷ�ʽ�Ĳ�������
function handlePostCookiesParame($Parame, $sType){
    $splStr=''; $s=''; $c=''; $leftC=''; $rightC ='';
    $splStr = aspSplit($Parame, '&') ;
    foreach( $splStr as $s){
        if( instr($s, '=') > 0 ){
            $leftC = mid($s, 1, instr($s, '=')) ;
            $rightC = mid($s, instr($s, '=') + 1,-1) ;
            if( LCase($sType) == 'post' || $sType == '' ){
                if( $c <> '' ){ $c = $c . '&' ;}
                $rightC = escape($rightC) ;
            }else if( LCase($sType) == 'cookies' || LCase($sType) == 'cookie' ){
                if( $c <> '' ){ $c = $c . ';' ;}
                $rightC = URLEncoding($rightC) ;
            }
            $c = $c . $leftC . $rightC ;
            //call echo(leftC,RightC)
        }
    }
    $handlePostCookiesParame = $c ;
    return @$handlePostCookiesParame;
}


//�Ƴ���ַ�в���20150724
function remoteHttpUrlParameter($HttpUrl){
    $splStr=''; $s=''; $c=''; $leftC=''; $rightC ='';
    //û��?���˳�
    if( instr($HttpUrl, '?') == false ){
        $remoteHttpUrlParameter = $HttpUrl ;
        return @$remoteHttpUrlParameter;
    }
    $splStr = aspSplit($HttpUrl, '&') ;
    foreach( $splStr as $s){
        if( instr($s, '=') > 0 ){
            $leftC = mid($s, 1, instr($s, '=')) ;
            $rightC = mid($s, instr($s, '=') + 1,-1) ;
            if( $c <> '' ){ $c = $c . '&' ;}
            $c = $c . $leftC ;
        }
    }
    $remoteHttpUrlParameter = $c ;
    return @$remoteHttpUrlParameter;
}


//��⵱ǰ��ַ���ļ������Ƿ����(20150909)
//�÷� call echo("checkUrlName",checkUrlName("1|2|3|"))      <%=IIF(checkUrlName("1|2|3|"),"111","222")% >
function checkUrlName($searchUrlName){
    $splStr=''; $urlName=''; $url ='';
    $searchUrlName = LCase($searchUrlName) ;//������ַ����תСд
    $url = LCase(ServerVariables('script_name')) ;
    $splStr = aspSplit($searchUrlName, '|') ;
    foreach( $splStr as $urlName){
        if( $urlName <> '' ){
            if( instr($url, $urlName) > 0 ){
                $checkUrlName = true ;
                return @$checkUrlName;
            }
        }
    }
    $checkUrlName = false ;
    return @$checkUrlName;
}





//0 url��http://127.0.0.1/aa/4.asp?act=sdf&v=sdf
//1 urlDir��http://127.0.0.1/
//2 fileName��4.asp
//3 FileType��asp
//4 fileStr��4.asp?act=sdf&v=sdf
//5 HttpAgreement��http
//6 webSite��http://127.0.0.1/
//7 folderDir��aa/

//��ַ���������20150124  ����  0ԭ�ļ�·�� 1Ϊ�ļ�·��   2Ϊ�ļ�����  3Ϊȥ���ļ������ļ�����   4Ϊ�ļ����ͺ�׺��
function handleHttpUrlArray( $url){
    $urlDir=''; $fileName=''; $FileType=''; $fileStr=''; $httpAgreement=''; $webSite=''; $folderDir ='';
    $url = handleHttpUrl($url) ;
    $urlDir = mid($url, 1, strrpos($url, '/')) ;
    $fileStr = mid($url, strrpos($url, '/') + 1,-1) ; $fileName = $fileStr ;
    if( instr($fileStr, '?') > 0 ){
        $fileName = mid($fileStr, 1, instr($fileStr, '?') - 1) ;
    }
    $FileType = mid($fileName, strrpos($fileName, '.') + 1,-1) ;
    $httpAgreement = mid($url, 1, instr($url, ':') - 1) ;
    $webSite = getWebSite($url) ;
    $folderDir = mid($urlDir, strlen($webSite),-1) ;
    //HandleHttpUrlArray = Array(url, urlDir, fileName, fileType, fileStr, HttpAgreement, webSite, folderDir)
    $arrayData='';
    $arrayData=aspSplit($url . "\n" . $urlDir . "\n" . $fileName . "\n" . $FileType . "\n" . $fileStr . "\n" . $httpAgreement . "\n" . $webSite . "\n" . $folderDir, "\n") ;
    $handleHttpUrlArray = $arrayData;
    return @$handleHttpUrlArray;
}


//�Ƴ�jsCss��Ĳ���Param (20151019)
function remoteJsCssParam($content, $PubAHrefList){
    $remoteJsCssParam = handleRemoteJsCssParam($content, $PubAHrefList, '|�滻����|�滻��ַ') ;
    return @$remoteJsCssParam;
}

//�����Ƴ�jsCss��Ĳ���Param (20151019)
function handleRemoteJsCssParam($content, $urlList, $sType){
    $splStr=''; $c=''; $url=''; $dataArray=''; $fileName=''; $fileType=''; $fileStr=''; $replaceStr ='';
    $sType = '|' . $sType . '|' ;
    $splStr = aspSplit($urlList, "\n") ;
    foreach( $splStr as $url){
        if( $url <> '' ){
            if( $c <> '' ){ $c = $c . "\n" ;}
            $dataArray = handleHttpUrlArray($url) ;
            $fileName = $dataArray[2] ;
            $fileType = LCase($dataArray[3]) ;
            $fileStr = LCase($dataArray[4]) ;
            if(($fileType == 'js' || $fileType == 'css') && instr($fileStr, '?') > 0 ){
                $replaceStr = mid($url, 1, instr($url, '?') - 1) ;
                //call echo(replaceStr,fileStr)
                //�����滻�������ǲ���׼�����Ľ�
                if( instr($sType, '|�滻����|') > 0 ){
                    $content = Replace($content, $url, $replaceStr) ;
                }
                if( instr($sType, '|�滻��ַ|') > 0 ){
                    $urlList = Replace($urlList, $url, $replaceStr) ;
                }
            }
        }
    }
}


//����������ַ����(20151022)
function batchHandleHttpUrlComplete($httpurl, $content){
    $website=''; $splStr=''; $url=''; $lCaseUrl=''; $c ='';
    $website = getwebsite($httpurl) ;
    $splStr = aspSplit($content, "\n") ;
    foreach( $splStr as $url){
        $url = phptrim($url) ;
        $lCaseUrl = LCase($url) ;
        if( $lCaseUrl <> '#' && substr($lCaseUrl, 0 , 11) <> 'javascript:' ){
            if( instr("\n" . LCase($c) . "\n", "\n" . $lCaseUrl . "\n") == false ){
                if( $c <> '' ){ $c = $c . "\n" ;}
                $c = $c . urlAddHttpUrl($website, $url) ;
            }
        }
    }
    $batchHandleHttpUrlComplete = $c ;
    return @$batchHandleHttpUrlComplete;
}


//���ͬ����(20151023)
function isWebSite( $url1, $url2){
    $isWebSite = handleIsWebSite($url1, $url2, '') ;
    return @$isWebSite;
}
//���ͬ������(20151023)
function isSonWebSite( $url1, $url2){
    $isSonWebSite = handleIsWebSite($url1, $url2, '������') ;
    return @$isSonWebSite;
}

//��������ַ�Ƿ�����ͬ��(20151023)
function handleIsWebSite( $url1, $url2, $sType){
    $url1 = getwebsite($url1) ;
    $url2 = getwebsite($url2) ;
    if( instr($url1, '://') > 0 ){
        $url1 = mid($url1, instr($url1, '://') + 3,-1) ;
    }
    if( substr($url1, 0 , 4) == 'www.' ){
        $url1 = mid($url1, 5,-1) ;
    }
    if( instr($url2, '://') > 0 ){
        $url2 = mid($url2, instr($url2, '://') + 3,-1) ;
    }
    if( substr($url2, 0 , 4) == 'www.' ){
        $url2 = mid($url2, 5,-1) ;
    }

    if( $sType == '������' ){
        $splStr=''; $s=''; $c ='';
        $c = '.com.hk|.sh.cn|.com.cn|.net.cn|.org.cn' ;
        $c = $c . '|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in' ;
        $splStr = aspSplit($c, '|') ;
        foreach( $splStr as $s){
            if( $s <> '' ){
                $url1 = Replace($url1, $s, '') ;
                $url2 = Replace($url2, $s, '') ;
            }
        }

        if( instr($url1, '.') ){
            $url1 = mid($url1, instr($url1, '.') + 1,-1) ;
        }
        if( instr($url2, '.') ){
            $url2 = mid($url2, instr($url2, '.') + 1,-1) ;
        }


    }
    $handleIsWebSite = false ;
    if( $url1 == $url2 ){
        $handleIsWebSite = true ;
    }
    return @$handleIsWebSite;
}



















//�����������ַ�б�(20161025)
function getContentUrlList($httpurl, $content){
    $getContentUrlList = HandleGetContentUrlList($httpurl, $content, '|*|����|') ;
    return @$getContentUrlList;
}
//��������������ַ�б�(20161025)
function handleGetContentUrlList($httpurl, $content, $sType){
    $i=''; $s=''; $nextS=''; $endSLCase=''; $endS=''; $urlStr=''; $nLen=''; $urlList=''; $url=''; $urlLCase=''; $website=''; $labelType=''; $isHandle=''; $valueLabel ='';
    $sType = '|' . LCase(AspTrim($sType)) . '|' ;
    $website = getwebsite($httpurl) ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $nextS = mid($content . ' ', $i + 1, 1) ;
        $endS = mid($content, $i + 1,-1) ; $endSLCase = LCase($endS) ;
        if( $s == '<' ){
            $url = '' ;
            $labelType = '' ;
            $isHandle = false ;
            if( substr($endSLCase, 0 , 2) == 'a ' ){
                $labelType = 'a' ;
                $valueLabel = 'href' ;
                $isHandle = true ;
            }else if( substr($endSLCase, 0 , 5) == 'link ' ){
                $labelType = 'link' ;
                $valueLabel = 'href' ;
                $isHandle = true ;
            }else if( substr($endSLCase, 0 , 4) == 'img ' ){
                $labelType = 'img' ;
                $valueLabel = 'src' ;
                $isHandle = true ;
            }else if( substr($endSLCase, 0 , 7) == 'script ' ){
                $labelType = 'script' ;
                $valueLabel = 'src' ;
                $isHandle = true ;
            }
            if( $isHandle == true ){
                if( instr($sType, '|' . $labelType . '|') > 0 || instr($sType, '|*|') > 0 ){
                    $nLen = instr($endS, '>') ;
                    $urlStr = mid($endS, 1, $nLen) ;
                    $url = RParam($urlStr, $valueLabel) ;
                    $i = $i + $nLen ;
                }
            }
            if( $url <> '' ){
                $urlLCase = LCase($url) ;
                if( $urlLCase <> '#' && substr($urlLCase, 0 , 11) <> 'javascript:' ){
                    if( instr("\n" . $urlList . "\n", "\n" . $url . "\n") == false ){
                        $url = fullHttpUrl($httpurl, $url) ;
                        $isHandle = isSonWebSite($url, $httpurl) ;
                        if( instr($sType, '|����|') > 0 ){
                            if( $isHandle == true ){
                                $urlList = $urlList . $url . "\n" ;
                            }
                        }else if( instr($sType, '|����|') > 0 ){
                            if( $isHandle == false ){
                                $urlList = $urlList . $url . "\n" ;
                            }
                        }else{
                            $urlList = $urlList . $url . "\n" ;
                        }
                    }
                }
            }
        }
    }
    if( $urlList <> '' ){ $urlList = substr($urlList, 0 , strlen($urlList) - 2) ;}
    $handleGetContentUrlList = $urlList ;
    return @$handleGetContentUrlList;
}
//�����ַ�������������б�
function getInChain($httpurl, $urlList){
    $splStr=''; $url=''; $c=''; $urlLCase=''; $isHandle ='';
    $splStr = aspSplit($urlList, "\n") ;
    $urlList = '' ;
    foreach( $splStr as $url){
        if( $url <> '' ){
            $urlLCase = LCase($url) ;
            if( substr($urlLCase, 0 , 1) <> '#' && substr($urlLCase, 0 , 11) <> 'javascript:' ){
                if( instr("\n" . $urlList . "\n", "\n" . $url . "\n") == false ){
                    $url = fullHttpUrl($httpurl, $url) ;
                    $isHandle = isSonWebSite($url, $httpurl) ;
                    if( $isHandle == true ){
                        $urlList = $urlList . $url . "\n" ;
                    }
                }
            }
        }
    }
    if( $urlList <> '' ){ $urlList = substr($urlList, 0 , strlen($urlList) - 2) ;}
    $getInChain = $urlList ;
    return @$getInChain;
}
?>

