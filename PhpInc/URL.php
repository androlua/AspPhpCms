<?PHP
//URL ��ַ���� (2013,9,27)

//NOVBNet start
//ʹ���ֲ�
//call echo("'��õ�ǰ��ַ��һ�֣�getUrl��",getUrl())
//call echo("'��õ�ǰ��ַ�ڶ��֣�getThisUrl��",getThisUrl())
//call echo("'��õ�ǰ��ַ�޲�����getThisUrlNoParam��",getThisUrlNoParam())
//call echo("'���������ַ��getGoToUrl��",getGoToUrl())
//call echo("'���������ַ�޲�����getGoToUrlNoParam��",getGoToUrlNoParam())
//call echo("'���������ַ���ļ����ƣ�getGoToUrlNoFileName��",getGoToUrlNoFileName())
//call echo("'������webDoMain��",webDoMain())
//call echo("'������host��",host())
//call echo("'��õ�ǰ��ַ�Ӳ�����getUrlAddToParam��",getUrlAddToParam(GetUrl(), "PageSize=20", "replace"))


//��õ�ǰ��ַ��һ�֣�getUrl����http://127.0.0.1/atemp.asp?act=1
//��õ�ǰ��ַ�ڶ��֣�getThisUrl����http://127.0.0.1/atemp.asp?act=1
//��õ�ǰ��ַ�޲�����getThisUrlNoParam����http://127.0.0.1/atemp.asp
//���������ַ��getGoToUrl����http://127.0.0.1/5.asp?act=5&aa=aa&bb=bb
//���������ַ�޲�����getGoToUrlNoParam����http://127.0.0.1/5.asp
//���������ַ���ļ����ƣ�getGoToUrlNoFileName����http://127.0.0.1/
//������webDoMain����http://127.0.0.1
//������host����http://127.0.0.1/
//��õ�ǰ��ַ�Ӳ�����GetUrlAddToParam����http://127.0.0.1/atemp.asp?PageSize=20&act=1
//getThisUrlFileName()    : 4.asp
//getThisUrlFileParam()    : 4.asp?act=11

//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","")        'http://www.baidu.com/?a=1&b=2&c=3
//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","replace")        'http://www.baidu.com/?a=11&b=22&c=333

//��õ�ǰ������ļ��������
function getThisUrlFileParam(){
    $url ='';
    $url= getUrl();
    $url= mid($url, strrpos($url, '/') + 1,-1);
    $getThisUrlFileParam= $url;
    return @$getThisUrlFileParam;
}

//��õ�ǰ��ַ�޲���
function getThisUrlNoParam(){
    $httpType ='';
    if( strtolower(ServerVariables('HTTPS'))== 'off' ){
        $httpType= 'http://';
    }else{
        $httpType= 'https://';
    }
    $getThisUrlNoParam= $httpType . ServerVariables('HTTP_HOST') . ServerVariables('SCRIPT_NAME');
    return @$getThisUrlNoParam;
}

//��ô�������ַ
function getGoToUrl(){
    $getGoToUrl= ServerVariables('HTTP_REFERER');
    return @$getGoToUrl;
}

//��ô�������ַ �޲���
function getGoToUrlNoParam(){
    $url ='';
    $url= getGoToUrl();
    if( instr($url, '?') > 0 ){
        $url= mid($url, 1, instr($url, '?') - 1);
    }
    $getGoToUrlNoParam= $url;
    return @$getGoToUrlNoParam;
}

//��ô�������ַ ���ļ�����
function getGoToUrlNoFileName(){
    $url ='';
    $url= getGoToUrl();
    if( substr($url, - 1) <> '/' ){
        if( strrpos($url, '/') > 0 ){
            $url= mid(getGoToUrlNoParam(), 1, strrpos(getGoToUrlNoParam(), '/'));
        }
    }
    if( substr($url, - 1) <> '/' ){ $url= $url . '/' ;}
    $getGoToUrlNoFileName= $url;
    return @$getGoToUrlNoFileName;
}
//�Ƴ���ַ�ļ�������
function remoteUrlFileName($url){
    if( substr($url, - 1) <> '/' ){
        if( strrpos($url, '/') > 0 ){
            $url= mid($url, 1, strrpos($url, '/'));
        }
    }
    $remoteUrlFileName=$url;
    return @$remoteUrlFileName;
}
//�Ƴ���ַ��������
function remoteUrlParam($url){
    if( substr($url, - 1) <> '?' ){
        if( strrpos($url, '?') > 0 ){
            $url= mid($url, 1, strrpos($url, '?')-1);
        }
    }
    $remoteUrlParam=$url;
    return @$remoteUrlParam;
}
//�����ַĿ¼����
function getUrlDir($url){
    $url=AspTrim($url);
    if( substr($url, 0 ,7)=='http://' ){
        $url= mid($url,8,-1);
    }
    if( instr($url,'/')>0 ){
        $url=mid($url,instr($url,'/')+1,-1);
    }
    $getUrlDir=$url;
    return @$getUrlDir;
}


//��ȡ�ͻ���IP��ַ�ڶ���
function getIP2(){

    $x=''; $y=''; $addr ='';
    $x= ServerVariables('HTTP_X_FORWARDED_FOR');
    $y= ServerVariables('REMOTE_ADDR');
    $addr= IIF(isNul($x) || strtolower($x)== 'unknown', $y, $x);
    if( instr($addr, '.')== 0 ){ $addr= '0.0.0.0' ;}
    $getIP2= $addr;
    return @$getIP2;
}

//��ȡIP��ַ ����д�ú����רҵһ�� ��ȫ
function getIP(){

    $strIPAddr ='';
    if( ServerVariables('HTTP_X_FORWARDED_FOR')== '' || instr(ServerVariables('HTTP_X_FORWARDED_FOR'), 'unknown') > 0 ){
        $strIPAddr= ServerVariables('REMOTE_ADDR');
    }else if( instr(ServerVariables('HTTP_X_FORWARDED_FOR'), ',') > 0 ){
        $strIPAddr= mid(ServerVariables('HTTP_X_FORWARDED_FOR'), 1, instr(ServerVariables('HTTP_X_FORWARDED_FOR'), ',') - 1);
    }else if( instr(ServerVariables('HTTP_X_FORWARDED_FOR'), ';') > 0 ){
        $strIPAddr= mid(ServerVariables('HTTP_X_FORWARDED_FOR'), 1, instr(ServerVariables('HTTP_X_FORWARDED_FOR'), ';') - 1);
    }else{
        $strIPAddr= ServerVariables('HTTP_X_FORWARDED_FOR');
    }
    $getIP= AspTrim(mid($strIPAddr, 1, 30));
    return @$getIP;
}

//��÷�����IP
function getServicerIP(){
    $getServicerIP= ServerVariables('LOCAL_ADDR');
    return @$getServicerIP;
}

//��÷�����IP   ����
function getRemoteIP(){
    $getRemoteIP= getServicerIP();
    return @$getRemoteIP;
}


//NOVBNet end

//������ַ\ת/  '������
function handleHttpUrl($httpUrl){
    $headStr=''; $url ='';
    if( isNul($httpUrl) ){ return ''; }//Ϊ�����˳�
    $httpUrl= Replace(AspTrim($httpUrl), '\\', '/');
    $headStr= mid($httpUrl, 1, instr($httpUrl, ':') + 2);
    $httpUrl= mid($httpUrl, instr($httpUrl, ':') + 3,-1);
    $httpUrl= Replace($httpUrl, 'http://', '��|http|��');
    $httpUrl= Replace($httpUrl, 'https://', '��|https|��');
    $httpUrl= Replace($httpUrl, 'ftp://', '��|ftp|��');

    while( instr($httpUrl, '//') > 0){
        $httpUrl= Replace($httpUrl, '//', '/');
    }
    $httpUrl= Replace($httpUrl, '��|http|��', 'http://');
    $httpUrl= Replace($httpUrl, '��|https|��', 'https://');
    $httpUrl= Replace($httpUrl, '��|ftp|��', 'ftp://');

    $url= $headStr . $httpUrl;
    ///"http://www.qibosoft.com/images/qibosoft/loading.gif/"
    if( substr($url, 0 , 2)== '/"' ){
        $url= mid($url, 3,-1);
    }
    if( substr($url, - 2)== '/"' ){
        $url= mid($url, 1, strlen($url) - 2);
    }
    $handleHttpUrl= $url;



    return @$handleHttpUrl;
}

//�����ļ�/ת\   ʹ����While�жϣ�������
function handleFileUrl($fileUrl){
    $fileUrl= Replace($fileUrl, '/', '\\');
    $i ='';
    for( $i= 1 ; $i<= 99; $i++){
        $fileUrl= Replace($fileUrl, '\\\\', '\\');

        if( instr($fileUrl, '\\\\')== false ){
            break;
        }
    }
    $handleFileUrl= $fileUrl;
    return @$handleFileUrl;
}

//������ַ������
function handleUrlComplete($httpUrl){
    $lastStr ='';
    $handleUrlComplete= $httpUrl;
    if( instr($httpUrl, '?') > 0 ){ return @$handleUrlComplete; }//��?�������˳�
    //��ַ���û��/  �ж����Ϊ���� ����������/�˳�
    if( substr($httpUrl, - 1) <> '/' ){
        if( $httpUrl . '/'== getWebSite($httpUrl) ){
            $handleUrlComplete= $httpUrl . '/';
            return @$handleUrlComplete;
        }
    }
    $lastStr= mid($httpUrl, strrpos($httpUrl, '/') + 1,-1);
    if( $lastStr <> '' && instr($lastStr, '.')== false ){
        $handleUrlComplete= $httpUrl . '/';
    }
    return @$handleUrlComplete;
}

//����ַ�������
function urlAddHttpUrl($httpUrl, $url){
    $httpUrl= Replace($httpUrl, '\\', '/');
    $url= handleHttpUrl($url);
    if( instr(strtolower($url), 'http://')== 0 && instr(strtolower($url), 'www.')== 0 ){
        if( substr($httpUrl, - 1)== '/' && substr($url, 0 , 1)== '/' ){
            $url= $httpUrl . mid($url, 2,-1);
        }else if( substr($httpUrl, - 1) <> '/' && substr($url, 0 , 1) <> '/' ){
            $url= $httpUrl . '/' . $url;
        }else{
            $url= $httpUrl . $url;
        }
    }
    $urlAddHttpUrl= $url;
    return @$urlAddHttpUrl;
}
//��������˿ں�
function getPort(){
    $port ='';
    $port= CStr(ServerVariables('SERVER_PORT'));
    if( $port <> '80' && $port <> '8080' ){
        $port= ':' . $port;
    }else{
        $port= '';
    }
    $getPort= $port;
    return @$getPort;
}

//�������
function webDoMain(){
    $webDoMain= 'http://' . ServerVariables('SERVER_NAME') . getPort();
    return @$webDoMain;
}

//��õ�ǰ����
function host(){
    $host= 'http://' . ServerVariables('HTTP_HOST') . '/';
    return @$host;
}

//��õ�ǰ���� (����)


//��õ�ǰ���� (����)


//���õ�ǰ��ַ
function getUrl(){
    $getUrl= getThisUrl();
    //GetUrl = WebDoMain() & Request.ServerVariables("SCRIPT_NAME") & Request.ServerVariables("QUERY_STRING")
    return @$getUrl;
}

//��õ�ǰ��������ַ
function getThisUrl(){
    $url ='';
    //vbdel start
    $url=ServerVariables('server_name');
    //PHP������ֱ�ӻ�ö˿�
    if( instr($url, ':')== false ){
        $url= $url . getPort();
    }
    $url= $url . ServerVariables('script_name');
    if( ServerVariables('QUERY_STRING') <> '' ){ $url= $url . '?' . ServerVariables('QUERY_STRING') ;}
    //vbdel end
    $getThisUrl= 'http://' . $url;
    return @$getThisUrl;
}
//��õ�ǰ���ļ�������ַ
function getThisUrlNoFileName(){
    $url ='';
    $url= getThisUrl();
    if( substr($url, - 1) <> '/' ){
        if( strrpos($url, '/') > 0 ){
            $url= mid($url, 1, strrpos($url, '/'));
        }
    }
    $getThisUrlNoFileName= $url;
    return @$getThisUrlNoFileName;
}

//�����ַ�������� http://www.aaa.bb.mywebname.com/   mywebname
function getWebSiteName($httpUrl){
    $url=''; $splStr=''; $s=''; $domainName ='';
    $url= getWebsite($httpUrl);
    $url= Replace($url, '://', '://.');
    $splStr= aspSplit($url, '.');
    foreach( $splStr as $s){
        if( instr($s, '/')== false && $s <> '' ){
            if( strlen($s) >= 4 ){
                $domainName= $s;
            }
        }
    }
    $getWebSiteName= $domainName;
    return @$getWebSiteName;
}

//������ַ �������
function getWebSite( $httpUrl){
    //On Error Resume Next
    //�°�����������
    $url=''; $tempHttpUrl=''; $is_WebSite ='';
    $tempHttpUrl= $httpUrl;
    $url= AspTrim(strtolower(Replace($httpUrl, '?', '/')));
    $url= Replace(Replace($url, '\\', '/'), 'http://', '');
    if( instr($url, '/') > 0 ){ $url= mid($url, 1, instr($url, '/') - 1) ;}
    $url= 'http://' . $url . '/';
    $splStr=''; $s=''; $c ='';
    $httpUrl= Replace(strtolower($httpUrl), 'http://', '');
    if( instr($httpUrl, '?') > 0 ){ $httpUrl= mid($httpUrl, 1, instr($httpUrl, '?') - 1) ;}
    if( substr($httpUrl, 0 , 9)== 'localhost' ){
        if( instr($httpUrl, '/') > 0 ){
            $httpUrl= mid($httpUrl, 1, instr($httpUrl, '/') - 1);
        }else{
            $httpUrl= 'localhost';
        }
    }else if( substr($httpUrl, 0 , 8)== '192.168.' || substr($httpUrl, 0 , 9)== '127.0.0.1' ){
        $httpUrl= $httpUrl . '/';
        $httpUrl= 'http://' . mid($httpUrl, 1, instr($httpUrl, '/') - 1) . '/';
        $getWebSite= $httpUrl ; return @$getWebSite;
    }else{
        $splStr= aspSplit($httpUrl, '.');
        if((instr($httpUrl, 'www.') > 0 && UBound($splStr) >= 2) || UBound($splStr) >= 1 ){
            if( instr($httpUrl, '/') > 0 ){
                $s= mid($httpUrl, 1, instr($httpUrl, '/') - 1);
                if( $s== getDianNumb($s) ){
                    $httpUrl= $s;
                }
            }
        }else{
            $httpUrl= ''; //û����Ϊ��
        }
    }
    $is_WebSite= false; //������Ϊ��
    $c= '.com.hk|.sh.cn|.com.cn|.net.cn|.org.cn';
    $c= $c . '|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in';
    $splStr= aspSplit($c, '|');
    foreach( $splStr as $s){
        if( $s <> '' ){
            if( instr($httpUrl, $s) > 0 ){
                $httpUrl= 'http://' . substr($httpUrl, 0 , instr($httpUrl, $s) + strlen($s) - 1) . '/' ; $is_WebSite= true ; break;
            }
        }
    }
    $getWebSite= substr($httpUrl, 0 , 255); //���������ڣ���ֻ��ȡ255���ַ�
    //GetWebSite = ""                        '������������Ϊ�� 20150104
    if( $getWebSite== 'http:///' ){ $getWebSite= '' ;}//û���ҵ�����
    if( $is_WebSite== false ){
        $getWebSite= '';
    }

    return @$getWebSite;
}
//����Ƿ�Ϊ��ַ
function checkUrl($url){
    $checkUrl= IIF(getWebSite($url)== '', false, true);
    return @$checkUrl;
}
//����Ƿ�Ϊ��ַ
function checkHttpUrl($url){
    $checkHttpUrl= checkUrl($url);
    return @$checkHttpUrl;
}
//����Ƿ�Ϊ��ַ
function isUrl($url){
    $isUrl= checkUrl($url);
    return @$isUrl;
}
//����Ƿ�Ϊ��ַ
function isHttpUrl($url){
    $isHttpUrl= checkUrl($url);
    return @$isHttpUrl;
}

//������ַ
function fullHttpUrl( $httpUrl, $url){
    //On Error Resume Next
    //������� Ҫ��Ȼ�ᱨ��
    $rootUrl=''; $thisUrl=''; $splStr=''; $i=''; $s=''; $c=''; $parentUrl=''; $parentParentUrl=''; $parentParentParentUrl=''; $rootWebSite=''; $thisWebSite=''; $handleYes ='';
    $httpUrl= pHPTrim($httpUrl); //������߿ո�
    $url= pHPTrim($url); //������߿ո�

    if( $url== '' ){ $fullHttpUrl= '' ; return @$fullHttpUrl; }//��ַΪ���˳�(20150805)
    if( AspTrim($httpUrl)== '' ){ $fullHttpUrl= $url ; return @$fullHttpUrl; }//����ַΪ���˳� ������ַ
    $httpUrl= Replace($httpUrl, '\\', '/'); //����ַ\ת/����
    $url= Replace($url, '\\', '/'); //����ַ\ת/����

    //��ַǰ�����ַ�Ϊ//���˳�
    if( substr($url, 0 , 2)== '//' ){
        $fullHttpUrl= 'http:' . $url;
        return @$fullHttpUrl;
    }


    $rootUrl= getWebSite($httpUrl); //��������Ҳ��������ַ
    $rootWebSite= $rootUrl;
    $thisWebSite= getWebSite($url);
    if( substr($rootUrl, - 1)== '/' ){ $rootUrl= substr($rootUrl, 0 , strlen($rootUrl) - 1) ;}
    $thisUrl= substr($httpUrl, 0 , strrpos($httpUrl, '/')); //��ǰ��ַ
    $splStr= aspSplit($httpUrl, '/');
    for( $i= 0 ; $i<= UBound($splStr); $i++){
        if( $i + 1== UBound($splStr) ){ $parentUrl= $c ;}
        if( $i + 2== UBound($splStr) ){ $parentParentUrl= $c ;}
        if( $i + 3== UBound($splStr) ){ $parentParentParentUrl= $c ;}
        $s= $splStr[$i];
        $c= $c . $s . '/';
    }
    $url= AspTrim($url); //ȥ����ַ���ҿո�
    $handleYes= false; //����Ϊ��
    if( $url <> '' && instr(substr($url, 0 , 10), 'www.')== false && instr(substr($url, 0 , 10), 'http://')== false && instr(substr($url, 0 , 10), 'https://')== false ){
        $handleYes= true;
        if( $rootWebSite <> $thisWebSite ){
            if( $rootWebSite== Replace($thisWebSite, 'http://', 'http://www.') ){
                $handleYes= false;
                if( instr(strtolower($url), 'http://') > 0 ){
                    $url= 'http://www.' . substr($url, - strlen($url) - 7);
                }else{
                    $url= 'http://www.' . $url;
                }
            }
        }
    }
    //�����Ƿ�Ϊ��
    if( $handleYes== true ){
        if( substr($url, 0 , 1)== '/' ){
            $url= $rootUrl . $url;
        }else if( substr($url, 0 , 9)== '../../../' ){
            $url= $parentParentParentUrl . substr($url, - strlen($url) - 9);
        }else if( substr($url, 0 , 6)== '../../' ){
            $url= $parentParentUrl . substr($url, - strlen($url) - 6);
        }else if( substr($url, 0 , 3)== '../' ){
            $url= $parentUrl . substr($url, - strlen($url) - 3);
        }else if( substr($url, 0 , 2)== './' ){
            $url= $thisUrl . mid($url, 3,-1);
        }else{
            $url= $thisUrl . $url;
        }
    }
    if( instr(strtolower($url), 'http://')== false && instr(strtolower($url), 'https://')== false ){
        if( instr(strtolower($httpUrl), 'http://') > 0 && instr(strtolower($url), 'http://')== false ){
            $url= 'http://' . $url;
        }else if( instr(strtolower($httpUrl), 'https://') > 0 && instr(strtolower($url), 'https://')== false ){
            $url= 'https://' . $url;
        }
    }
    $fullHttpUrl= $url;

    return @$fullHttpUrl;
}

//����������ַ����20150728
function batchFullHttpUrl($webSite, $urlList){
    $splStr=''; $url=''; $c ='';
    $splStr= aspSplit($urlList, vbCrlf());
    foreach( $splStr as $url){
        if( strlen($url) > 3 ){
            if( $c <> '' ){ $c= $c . vbCrlf() ;}
            $c= $c . fullHttpUrl($webSite, $url);
        }
    }
    $batchFullHttpUrl= $c;
    return @$batchFullHttpUrl;
}


//��ַ�����ַ� ��ദ��
function uRLJianJieHandle( $url){
    $url= Replace($url, '&amp;', '&');
    $uRLJianJieHandle= $url;
    return @$uRLJianJieHandle;
}

//URL���� �������С�������
function urlToAsc($url){
    $i ='';
    for( $i= 1 ; $i<= strlen($url); $i++){
        $urlToAsc= $urlToAsc . '%' . Hex(AscW(mid($url, $i, 1)));
    }
    return @$urlToAsc;
}


//�����վ����
function getWebTitle($content){
    $getWebTitle= getStrCut($content, '<title>', '</title>', 0);
    return @$getWebTitle;
}

//���������ַ�б� (ȱ������ַȫ��Сд��20150728)
function getContentAHref($httpUrl, $content, $PubAHrefList, $PubATitleList){
    $i=''; $s=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i= 1 ; $i<= strlen($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $TempS= strtolower(mid($content, $i,-1));
            $LalType= strtolower(mid($TempS, 1, instr($TempS, ' ')));
            if( $LalType== '<a ' ){
                $LalStr= mid($TempS, 1, instr($TempS, '</') + 2);
                $nLen= strlen($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'href', '', 'url', $PubAHrefList, $PubATitleList) . vbCrlf();
                $i= $i + $nLen;
            }
        }
        doEvents( );
    }
    if( $c <> '' ){ $c= substr($c, 0 , strlen($c) - 2) ;}
    $getContentAHref= $c;
    return @$getContentAHref;
}

//���������ͼƬ�б�
function getContentImgSrc($httpUrl, $content, $PubAHrefList, $PubATitleList){
    $i=''; $s=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i= 1 ; $i<= strlen($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $TempS= strtolower(mid($content, $i,-1));
            $LalType= strtolower(mid($TempS, 1, instr($TempS, ' ')));
            if( $LalType== '<img ' ){
                $LalStr= mid($TempS, 1, instr($TempS, '>'));
                $nLen= strlen($LalStr) - 1;
                //Call Echo(I,LalStr)
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', 'url', $PubAHrefList, $PubATitleList) . vbCrlf();
                $i= $i + $nLen;
            }
        }
        doEvents( );
    }
    if( $c <> '' ){ $c= substr($c, 0 , strlen($c) - 2) ;}
    $getContentImgSrc= $c;
    return @$getContentImgSrc;
}

//����������ַ���� sType=|*|link|img|a|script|embed|param|meta|
function handleConentUrl($httpUrl, $content, $sType, $PubAHrefList, $PubATitleList){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    $sType= '|' . $sType . '|';
    for( $i= 1 ; $i<= strlen($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= strtolower($YuanStr);
            $TempS= Replace(Replace($TempS, Chr(10), ' ' . vbCrlf()), Chr(13), ' ' . vbCrlf()); //�ô���ͼƬ�زĸ�����  ����  <img����src=""  Ҳ���Ի�� 20150714
            $LalStr= mid($YuanStr, 1, instr($YuanStr, '>'));
            $LalType= strtolower(mid($TempS, 1, instr($TempS, ' ')));
            if( $LalType== '<link ' &&(instr($sType, '|link|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'href', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;
            }else if( $LalType== '<img ' &&(instr($sType, '|img|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;
            }else if( $LalType== '<a ' &&(instr($sType, '|a|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                //û��javascript�����У����ǻ����в���֮��
                if( instr(strtolower($LalStr), 'javascript:')== 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'href', '', '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else if( $LalType== '<script ' &&(instr($sType, '|script|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                if( instr(strtolower($LalStr), 'src') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else if( $LalType== '<embed ' &&(instr($sType, '|embed|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;
            }else if( $LalType== '<param ' &&(instr($sType, '|param|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                if( instr(strtolower($LalStr), 'movie') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'value', '', '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else if( $LalType== '<meta ' &&(instr($sType, '|meta|') > 0 || instr($sType, '|*|') > 0) ){
                $nLen= strlen($LalStr) - 1;
                //�滻�ؼ���
                if( instr(strtolower($LalStr), 'keywords') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'content', $GLOBALS['WebKeywords'], '', $PubAHrefList, $PubATitleList);
                    //�滻��վ����
                }else if( instr(strtolower($LalStr), 'description') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'content', $GLOBALS['WebDescription'], '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else{
                $c= $c . $s;
            }
        }else{
            $c= $c . $s;
        }
        doEvents( );
    }
    $handleConentUrl= $c;
    return @$handleConentUrl;
}


//�滻������ȫ��JsĿ¼ 20150722  call rwend(handleConentUrl("/admin/js/", "<script src='aa/js.js' ><script src=""bb/js.js"" >","",""))
function replaceContentJsDir($content, $dirPath, $PubAHrefList, $PubATitleList){
    $splStr=''; $s=''; $c ='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $s){
        if( $c <> '' ){ $c= $c . vbCrlf() ;}
        if( instr($s, '<script ') > 0 && instr($s, '</script>') > 0 ){
            $s= handleLink($dirPath, $s, 'src', '', 'replaceDir', $PubAHrefList, $PubATitleList);
        }
        $c= $c . $s;
    }
    $replaceContentJsDir= $c;
    return @$replaceContentJsDir;
}


//�������ӵ�ַ HttpUrl=׷����ַ��Content=����  SType=����
//�滻Ŀ¼����  call rw(HandleLink("Js/", "111111<script src=""js/Jquery.Min.js""></"& "script>","src", "newurl", "replaceDir","",""))


//�����վĿ¼�ļ������� \Templates\WeiZhanLue\  �õ�WeiZhanLue
function getEndUrlHandleName($FileUrl){
    $url ='';
    $url= Replace(AspTrim($FileUrl), '\\', '/');
    if( substr($url, - 1)== '/' ){ $url= mid($url, 1, strlen($url) - 1) ;}
    $url= mid($url, strrpos($url, '/') + 1,-1);
    $getEndUrlHandleName= $url;
    return @$getEndUrlHandleName;
}


//����б��в�ͬ�����б�
function getUrlListInWebSiteList($content){
    $url=''; $UrlList=''; $splStr ='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $url){
        $url= getWebSite($url);
        if( $url <> '' && instr(vbCrlf() . $UrlList . vbCrlf(), vbCrlf() . $url . vbCrlf())== 0 ){
            $UrlList= $UrlList . $url . vbCrlf();
        }
        doevents( );
    }
    $getUrlListInWebSiteList= $UrlList;
    return @$getUrlListInWebSiteList;
}

//��õ�ǰ��ַ���ļ�����
function getThisUrlFileName(){
    $url ='';
    $url= ServerVariables('SCRIPT_NAME');
    if( substr($url, 0 , 1)== '/' ){ $url= substr($url, - strlen($url) - 1) ;}
    $getThisUrlFileName= $url;
    return @$getThisUrlFileName;
}

//������վHTML��Img    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)
function handleWebHtmlImg($RootPath, $content, $PubAHrefList, $PubATitleList){
    $ImgList=''; $splStr=''; $imgUrl=''; $NewImgUrl ='';
    $startStr=''; $endStr ='';
    $ImgList= getContentImgSrc('', $content, $PubAHrefList, $PubATitleList);
    $splStr= aspSplit($ImgList, vbCrlf());
    foreach( $splStr as $imgUrl){
        if( $imgUrl <> '' ){
            $NewImgUrl= handleHttpUrl($imgUrl);
            if( instr($NewImgUrl, '/') > 0 ){
                $NewImgUrl= mid($NewImgUrl, strrpos($NewImgUrl, '/') + 1,-1);
            }
            $NewImgUrl= $RootPath . $NewImgUrl;
            //Call Echo(NewImgUrl,ImgUrl)
            $startStr= 'src="' ; $endStr= '"';
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $content= regExp_Replace($content, $startStr . $imgUrl . $endStr, $startStr . $NewImgUrl . $endStr);
            }
            $startStr= 'src=\'' ; $endStr= '\'';
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                $content= regExp_Replace($content, $startStr . $imgUrl . $endStr, $startStr . $NewImgUrl . $endStr);
            }
        }
    }
    $handleWebHtmlImg= $content;
    return @$handleWebHtmlImg;
}

//������վCss��Img    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)
function handleWebCssImg($RootPath, $content){
    $startStr=''; $endStr=''; $ImgList=''; $splStr=''; $c=''; $imgUrl=''; $NewImgUrl ='';
    $startStr= 'url\\(';
    $endStr= '\\)';
    $ImgList= getArray($content, $startStr, $endStr, false, false);
    //Call RwEnd(ImgList)
    $splStr= aspSplit($ImgList, '$Array$');
    foreach( $splStr as $imgUrl){
        if( $imgUrl <> '' ){
            $NewImgUrl= handleHttpUrl($imgUrl);
            if( instr($NewImgUrl, '/') > 0 ){
                $NewImgUrl= mid($NewImgUrl, strrpos($NewImgUrl, '/') + 1,-1);
            }
            $NewImgUrl= $RootPath . $NewImgUrl;
            $startStr= 'url(';
            $endStr= ')';
            if( instr($content, $startStr) > 0 && instr($content, $endStr) > 0 ){
                //call echo(StartStr,"StartStr")
                $content= regExp_Replace($content, $startStr . $imgUrl . $endStr, $startStr . $NewImgUrl . $endStr);
            }
        }
    }
    $handleWebCssImg= $content;
    return @$handleWebCssImg;
}

//����������ַ������
function batchHandleUrlIntegrity($httpUrl, $UrlList){
    $splUrl=''; $url=''; $c ='';
    $splUrl= aspSplit($UrlList, vbCrlf());
    foreach( $splUrl as $url){
        if( $url <> '' ){
            $url= fullHttpUrl($httpUrl, $url);
            if( instr(vbCrlf() . $c . vbCrlf(), vbCrlf() . $url . vbCrlf())== false ){
                $c= $c . $url . vbCrlf();
            }
        }
    }
    $batchHandleUrlIntegrity= $c;
    return @$batchHandleUrlIntegrity;
}

//��������������ͼƬ·�� Ŀ¼����ʾͼƬ
function replaceContentImagePath($RootFolder, $content){
    $ImageFile=''; $ToImageFile=''; $ImageList=''; $splxx ='';
    $RootFolder= handleHttpUrl($RootFolder);
    if( substr($RootFolder, - 1) <> '/' ){ $RootFolder= $RootFolder . '/' ;}
    $ImageList= getDirFileNameList($RootFolder,'');
    $splxx= aspSplit($ImageList, vbCrlf());
    foreach( $splxx as $ImageFile){
        if( $ImageFile <> '' ){
            $ToImageFile= 'file:///' . $RootFolder . $ImageFile;
            //html��ͼƬ·���滻
            $content= Replace($content, '"' . $ImageFile . '"', '"' . $ToImageFile . '"');
            $content= Replace($content, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"');
            $content= Replace($content, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"');
            $content= Replace($content, '=' . $ImageFile . '>', '"' . $ToImageFile . '"');
            //Css��ͼƬ·���滻
            $content= Replace($content, '(' . $ImageFile . ')', '(' . $ToImageFile . ')');
            $content= Replace($content, '(' . $ImageFile . ';', '(' . $ToImageFile . ';');
        }
    }
    $replaceContentImagePath= $content;
    return @$replaceContentImagePath;
}

//���Css�����б� ������
function getCssLinkList( $content){
    $startStr=''; $endStr=''; $splStr=''; $s=''; $c=''; $fileName ='';
    $startStr= '<link' ; $endStr= '/>';
    $content= getArray($content, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $s){
        if( instr(strtolower($s), 'stylesheet') > 0 ){
            $fileName= strCut($s, 'href="', '"', 2);
            ASPEcho($fileName, $s);
            $c= $c . $fileName . vbCrlf();
        }
    }
    $getCssLinkList= $c;
    return @$getCssLinkList;
}

//���Html��ͼƬ��ַ�б�
function getHtmlBackGroundUrlList($content){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c=''; $startStr=''; $endStr ='';
    for( $i= 1 ; $i<= strlen($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= strtolower($YuanStr);
            $LalStr= mid($YuanStr, 1, instr($YuanStr, '>'));
            $LalType= strtolower(mid($TempS, 1, instr($TempS, ' ')));
            if( instr($LalStr, 'url(') > 0 ){
                $startStr= 'url(' ; $endStr= ')';
                $c= $c . strCut($LalStr, $startStr, $endStr, 2) . vbCrlf();
                $i= $i + $nLen;
            }
        }
        doEvents( );
    }
    $getHtmlBackGroundUrlList= $c;
    return @$getHtmlBackGroundUrlList;
}

//���ͼƬ��ַ�б�
function getImgUrlList($content){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i= 1 ; $i<= strlen($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= strtolower($YuanStr);
            $LalStr= mid($YuanStr, 1, instr($YuanStr, '>'));
            $LalType= strtolower(mid($TempS, 1, instr($TempS, ' ')));
            if( $LalType== '<img ' ){
                $c= $c . getLinkUrl($LalStr, 'src') . vbCrlf();
                $i= $i + $nLen;

            }
        }
        doEvents( );
    }
    $getImgUrlList= $c;
    return @$getImgUrlList;
}

//���img��a��ַ ��GetLinkUrl(LalStr, "src")
function getLinkUrl( $LinkStr, $LinkType){
    $TempLinkStr=''; $startStr=''; $endStr=''; $LinkUrl ='';
    $LinkStr= Replace(Replace($LinkStr, '= ', '='), '= ', '=');
    $LinkStr= Replace(Replace($LinkStr, ' =', '='), ' =', '=');
    $TempLinkStr= strtolower($LinkStr);

    $startStr= $LinkType . '="';
    $endStr= '"';
    if( instr($TempLinkStr, $startStr) > 0 && instr($TempLinkStr, $endStr) > 0 ){
        $LinkUrl= strCut($TempLinkStr, $startStr, $endStr, 2);
        $getLinkUrl= $LinkUrl;
    }
    return @$getLinkUrl;
}

//�Ǳ�����ַ��Զ����ַ        20141120
function localUrlOrRemoteUrl($filePath, $UrlYes){
    $httpUrl ='';
    $UrlYes= false;
    $filePath= AspTrim($filePath);
    $httpUrl= Replace($filePath, '\\', '/');
    if( substr(strtolower($httpUrl), 0 , 7)== 'http://' || substr(strtolower($httpUrl), 0 , 4)== 'www.' || substr(strtolower($httpUrl), 0 , 4)== '[��ַ]' ){
        $UrlYes= true;
    }
    if( $UrlYes== false ){
        $filePath= setFileName($filePath);
    }
    $localUrlOrRemoteUrl= $filePath;
    return @$localUrlOrRemoteUrl;
}

//����Ƿ�ΪԶ����ַ
function checkRemoteUrl($url){
    $httpUrl ='';
    $url= AspTrim($url);
    $httpUrl= Replace(unSetFileName($url), '\\', '/');
    $checkRemoteUrl= false;
    if( substr(strtolower($httpUrl), 0 , 7)== 'http://' || substr(strtolower($httpUrl), 0 , 4)== 'www.' || substr(strtolower($httpUrl), 0 , 4)== '[��ַ]' ){
        if( substr(strtolower($httpUrl), 0 , 4)== '[��ַ]' ){
            $url= mid($url, instr($url, '[��ַ]') + 1,-1);
        }
        $checkRemoteUrl= true;
    }
    return @$checkRemoteUrl;
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
function getUrlAddToParam( $url, $AddToUrl, $sType){
    $content=''; $splStr=''; $splxx=''; $s=''; $c=''; $httpUrl=''; $urlFileName=''; $webSite ='';
    $urlParam ='';//��ַ���� �ǻ����ַ��̨����ֵ
    $paramName ='';//��������
    $paramValue ='';//����ֵ
    $paramNameList ='';//���������б���ֹ�ظ�
    $handleYes ='';//����Ϊ��

    $AddToUrl= handleHttpUrl($AddToUrl);

    //������ַ
    $url= AspTrim($url);
    //��ǰ��ַ���һ���ַ�Ϊ?��&��ɾ���� ����
    if( substr($url, - 1)== '?' || substr($url, - 1)== '&' ){
        $url= AspTrim(mid($url, 1, strlen($url) - 1));
    }
    //����׷����ַ
    $AddToUrl= AspTrim($AddToUrl);
    //׷����ַ���һ���ַ�Ϊ?��&��ɾ���� ����
    if( substr($AddToUrl, 0 , 1)== '?' || substr($AddToUrl, 0 , 1)== '&' ){
        $AddToUrl= AspTrim(mid($AddToUrl, 2,-1));
    }
    //��ַΪ���򷵻�׷����ַ ���˳�
    if( $url== '' ){ $getUrlAddToParam= '?' . $AddToUrl ; return @$getUrlAddToParam; }

    $httpUrl= $url;
    if( instr($url, '?') > 0 ){
        $httpUrl= mid($url, 1, instr($url, '?') - 1); //��õ�ǰ·����ַ
        $webSite= getWebSite($url); //��������
        $urlParam= mid($url, instr($url, '?') + 1,-1);

        $httpUrl= handleHttpUrl($httpUrl);
        if( substr($httpUrl, - 1) <> '/' ){
            $urlFileName= mid($httpUrl, strrpos($httpUrl, '/') + 1,-1);
            $httpUrl= substr($httpUrl, 0 , strlen($httpUrl) - strlen($urlFileName));
            //Call Echo(HttpUrl,UrlFileName)
        }
    }

    //����ѡ��  ׷�� �����滻
    if( strtolower($sType)== 'replace' || $sType== '�滻' ){
        $content= $AddToUrl . '&' . $urlParam;
        //Call echo("Content",Content)
        if( instr($AddToUrl, '?') > 0 ){
            $urlFileName= mid($AddToUrl, 1, instr($AddToUrl, '?') - 1);
            //Call Echo(AddToUrl,UrlFileName)
        }
    }else if((strtolower($sType) <> 'delete' || strtolower($sType) <> 'del') ){
        $content= $urlParam . '&' . $AddToUrl;
    }

    $content= Replace($content, '?', '&');

    //����ɾ������ 20150210
    if( strtolower($sType)== 'delete' || strtolower($sType)== 'del' ){
        $splStr= aspSplit(strtolower($AddToUrl), '&') ; $AddToUrl= '&';
        foreach( $splStr as $s){
            if( instr($s, '=') ){
                $s= mid($s, 1, instr($s, '=') - 1);
            }
            if( $s <> '' ){
                $AddToUrl= $AddToUrl . $s . '&';
            }
        }
        //Call Eerr("AddToUrl",AddToUrl)
    }

    //Call Echo("Content",Content)
    $splStr= aspSplit($content, '&');
    foreach( $splStr as $s){
        if( instr($s, '=') > 0 ){
            $splxx= aspSplit($s, '=');
            $paramName= $splxx[0];
            $paramValue= $splxx[1];

            $handleYes= true;

            if( strtolower($sType)== 'delete' || strtolower($sType)== 'del' ){
                if( instr('&' . $AddToUrl . '&', '&' . strtolower($paramName) . '&') > 0 ){
                    $handleYes= false;
                }
            }

            if( instr('|' . $paramNameList . '|', '|' . strtolower($paramName) . '|')== false && $handleYes== true ){
                $paramNameList= $paramNameList . strtolower($paramName) . '|';
                $c= $c . IIF($c== '', '?', '&');
                $c= $c . $paramName . '=' . $paramValue;
            }
        }
    }



    $c= $urlFileName . $c;
    if( getWebSite($c)== '' ){
        if( substr($AddToUrl, 0 , 1)== '/' ){
            $c= $webSite . $c;
        }else{
            $c= $httpUrl . $c;
        }

    }

    $c=replace($c,'\\','/');			//20160313
    $getUrlAddToParam= $c;
    return @$getUrlAddToParam;
}




//�����ַ 20150706 call echo("",groupUrl("www.baidu.com//","/1.asp"))
function groupUrl($url1, $url2){
    $urlType=''; $i ='';
    $urlType= '/';
    $url1= Replace($url1, IIF($urlType== '/', '\\', '/'), $urlType);
    $url2= Replace($url2, IIF($urlType== '/', '\\', '/'), $urlType);
    $url1= phptrim($url1);
    $url2= phptrim($url2);
    for( $i= 0 ; $i<= 99; $i++){
        if( substr($url1, - 1)== $urlType ){
            $url1= mid($url1, 1, strlen($url1) - 1);
        }else{
            break;
        }
    }
    for( $i= 0 ; $i<= 99; $i++){
        if( substr($url2, 0 , 1)== $urlType ){
            $url2= mid($url2, 2,-1);
        }else{
            break;
        }
    }
    $groupUrl= $url1 . $urlType . $url2;
    return @$groupUrl;
}



//����POST��Cookes���ͷ�ʽ�Ĳ�������
function handlePostCookiesParame($Parame, $sType){
    $splStr=''; $s=''; $c=''; $leftC=''; $rightC ='';
    $splStr= aspSplit($Parame, '&');
    foreach( $splStr as $s){
        if( instr($s, '=') > 0 ){
            $leftC= mid($s, 1, instr($s, '='));
            $rightC= mid($s, instr($s, '=') + 1,-1);
            if( strtolower($sType)== 'post' || $sType== '' ){
                if( $c <> '' ){ $c= $c . '&' ;}
                $rightC= escape($rightC);
            }else if( strtolower($sType)== 'cookies' || strtolower($sType)== 'cookie' ){
                if( $c <> '' ){ $c= $c . ';' ;}
                $rightC= URLEncoding($rightC);
            }
            $c= $c . $leftC . $rightC;
            //call echo(leftC,RightC)
        }
    }
    $handlePostCookiesParame= $c;
    return @$handlePostCookiesParame;
}


//�Ƴ���ַ�в���20150724
function remoteHttpUrlParameter($httpUrl){
    $splStr=''; $s=''; $c=''; $leftC=''; $rightC ='';
    //û��?���˳�
    if( instr($httpUrl, '?')== false ){
        $remoteHttpUrlParameter= $httpUrl;
        return @$remoteHttpUrlParameter;
    }
    $splStr= aspSplit($httpUrl, '&');
    foreach( $splStr as $s){
        if( instr($s, '=') > 0 ){
            $leftC= mid($s, 1, instr($s, '='));
            $rightC= mid($s, instr($s, '=') + 1,-1);
            if( $c <> '' ){ $c= $c . '&' ;}
            $c= $c . $leftC;
        }
    }
    $remoteHttpUrlParameter= $c;
    return @$remoteHttpUrlParameter;
}


//��⵱ǰ��ַ���ļ������Ƿ����(20150909)
//�÷� call echo("checkUrlName",checkUrlName("1|2|3|"))      <%=IIF(checkUrlName("1|2|3|"),"111","222")% >
function checkUrlName($searchUrlName){
    $splStr=''; $urlName=''; $url ='';
    $searchUrlName= strtolower($searchUrlName); //������ַ����תСд
    $url= strtolower(ServerVariables('script_name'));
    $splStr= aspSplit($searchUrlName, '|');
    foreach( $splStr as $urlName){
        if( $urlName <> '' ){
            if( instr($url, $urlName) > 0 ){
                $checkUrlName= true;
                return @$checkUrlName;
            }
        }
    }
    $checkUrlName= false;
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
    $url= handleHttpUrl($url);

    $urlDir= mid($url, 1, strrpos($url, '/'));
    $fileStr= mid($url, strrpos($url, '/') + 1,-1) ; $fileName= $fileStr;
    if( instr($fileStr, '?') > 0 ){
        $fileName= mid($fileStr, 1, instr($fileStr, '?') - 1);
    }
    $FileType= mid($fileName, strrpos($fileName, '.') + 1,-1);
    $httpAgreement= mid($url, 1, instr($url, ':') - 1);
    $webSite= getWebSite($url);
    ASPEcho('url', $url);
    $folderDir= mid($urlDir, strlen($webSite),-1);
    //HandleHttpUrlArray = Array(url, urlDir, fileName, fileType, fileStr, HttpAgreement, webSite, folderDir)
    $arrayData ='';
    $arrayData= aspSplit($url . vbCrlf() . $urlDir . vbCrlf() . $fileName . vbCrlf() . $FileType . vbCrlf() . $fileStr . vbCrlf() . $httpAgreement . vbCrlf() . $webSite . vbCrlf() . $folderDir, vbCrlf());
    $handleHttpUrlArray= $arrayData;
    return @$handleHttpUrlArray;
}


//�Ƴ�jsCss��Ĳ���Param (20151019)
function remoteJsCssParam($content, $PubAHrefList){
    $remoteJsCssParam= handleRemoteJsCssParam($content, $PubAHrefList, '|�滻����|�滻��ַ');
    return @$remoteJsCssParam;
}

//�����Ƴ�jsCss��Ĳ���Param (20151019)
function handleRemoteJsCssParam($content, $urlList, $sType){
    $splStr=''; $c=''; $url=''; $dataArray=''; $fileName=''; $fileType=''; $fileStr=''; $replaceStr ='';
    $sType= '|' . $sType . '|';
    $splStr= aspSplit($urlList, vbCrlf());
    foreach( $splStr as $url){
        if( $url <> '' ){
            if( $c <> '' ){ $c= $c . vbCrlf() ;}
            $dataArray= handleHttpUrlArray($url);
            $fileName= $dataArray[2];
            $fileType= strtolower($dataArray[3]);
            $fileStr= strtolower($dataArray[4]);
            if(($fileType== 'js' || $fileType== 'css') && instr($fileStr, '?') > 0 ){
                $replaceStr= mid($url, 1, instr($url, '?') - 1);
                //call echo(replaceStr,fileStr)
                //�����滻�������ǲ���׼�����Ľ�
                if( instr($sType, '|�滻����|') > 0 ){
                    $content= Replace($content, $url, $replaceStr);
                }
                if( instr($sType, '|�滻��ַ|') > 0 ){
                    $urlList= Replace($urlList, $url, $replaceStr);
                }
            }
        }
    }
}


//����������ַ����(20151022)
function batchHandleHttpUrlComplete($httpUrl, $content){
    $webSite=''; $splStr=''; $url=''; $lCaseUrl=''; $c ='';
    $webSite= getwebsite($httpUrl);
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $url){
        $url= phptrim($url);
        $lCaseUrl= strtolower($url);
        if( $lCaseUrl <> '#' && substr($lCaseUrl, 0 , 11) <> 'javascript:' ){
            if( instr(vbCrlf() . strtolower($c) . vbCrlf(), vbCrlf() . $lCaseUrl . vbCrlf())== false ){
                if( $c <> '' ){ $c= $c . vbCrlf() ;}
                $c= $c . urlAddHttpUrl($webSite, $url);
            }
        }
    }
    $batchHandleHttpUrlComplete= $c;
    return @$batchHandleHttpUrlComplete;
}


//���ͬ����(20151023)
function isWebSite( $url1, $url2){
    $isWebSite= handleIsWebSite($url1, $url2, '');
    return @$isWebSite;
}
//���ͬ������(20151023)
function isSonWebSite( $url1, $url2){
    $isSonWebSite= handleIsWebSite($url1, $url2, '������');
    return @$isSonWebSite;
}

//��������ַ�Ƿ�����ͬ��(20151023)
function handleIsWebSite( $url1, $url2, $sType){
    $url1= getwebsite($url1);
    $url2= getwebsite($url2);
    if( instr($url1, '://') > 0 ){
        $url1= mid($url1, instr($url1, '://') + 3,-1);
    }
    if( substr($url1, 0 , 4)== 'www.' ){
        $url1= mid($url1, 5,-1);
    }
    if( instr($url2, '://') > 0 ){
        $url2= mid($url2, instr($url2, '://') + 3,-1);
    }
    if( substr($url2, 0 , 4)== 'www.' ){
        $url2= mid($url2, 5,-1);
    }

    if( $sType== '������' ){
        $splStr=''; $s=''; $c ='';
        $c= '.com.hk|.sh.cn|.com.cn|.net.cn|.org.cn';
        $c= $c . '|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in';
        $splStr= aspSplit($c, '|');
        foreach( $splStr as $s){
            if( $s <> '' ){
                $url1= Replace($url1, $s, '');
                $url2= Replace($url2, $s, '');
            }
        }

        if( instr($url1, '.') ){
            $url1= mid($url1, instr($url1, '.') + 1,-1);
        }
        if( instr($url2, '.') ){
            $url2= mid($url2, instr($url2, '.') + 1,-1);
        }


    }
    $handleIsWebSite= false;
    if( $url1== $url2 ){
        $handleIsWebSite= true;
    }
    return @$handleIsWebSite;
}


//�����������ַ�б�(20161025)
function getContentUrlList($httpUrl, $content){
    $getContentUrlList= handleGetContentUrlList($httpUrl, $content, '|*|����|');
    return @$getContentUrlList;
}
//��������������ַ�б�(20161025)
function handleGetContentUrlList($httpUrl, $content, $sType){
    $i=''; $s=''; $nextS=''; $endSLCase=''; $endS=''; $urlStr=''; $nLen=''; $urlList=''; $url=''; $urlLCase=''; $webSite=''; $labelType=''; $isHandle=''; $valueLabel ='';
    $sType= '|' . strtolower(AspTrim($sType)) . '|';
    $webSite= getwebsite($httpUrl);
    for( $i= 1 ; $i<= strlen($content); $i++){
        $s= mid($content, $i, 1);
        $nextS= mid($content . ' ', $i + 1, 1);
        $endS= mid($content, $i + 1,-1) ; $endSLCase= strtolower($endS);
        if( $s== '<' ){
            $url= '';
            $labelType= '';
            $isHandle= false;
            if( substr($endSLCase, 0 , 2)== 'a ' ){
                $labelType= 'a';
                $valueLabel= 'href';
                $isHandle= true;
            }else if( substr($endSLCase, 0 , 5)== 'link ' ){
                $labelType= 'link';
                $valueLabel= 'href';
                $isHandle= true;
            }else if( substr($endSLCase, 0 , 4)== 'img ' ){
                $labelType= 'img';
                $valueLabel= 'src';
                $isHandle= true;
            }else if( substr($endSLCase, 0 , 7)== 'script ' ){
                $labelType= 'script';
                $valueLabel= 'src';
                $isHandle= true;
            }
            if( $isHandle== true ){
                if( instr($sType, '|' . $labelType . '|') > 0 || instr($sType, '|*|') > 0 ){
                    $nLen= instr($endS, '>');
                    $urlStr= mid($endS, 1, $nLen);
                    $url= RParam($urlStr, $valueLabel);
                    $i= $i + $nLen;
                }
            }
            if( $url <> '' ){
                $urlLCase= strtolower($url);
                if( $urlLCase <> '#' && substr($urlLCase, 0 , 11) <> 'javascript:' ){
                    if( instr(vbCrlf() . $urlList . vbCrlf(), vbCrlf() . $url . vbCrlf())== false ){
                        $url= fullHttpUrl($httpUrl, $url);
                        $isHandle= isSonWebSite($url, $httpUrl);
                        if( instr($sType, '|����|') > 0 ){
                            if( $isHandle== true ){
                                $urlList= $urlList . $url . vbCrlf();
                            }
                        }else if( instr($sType, '|����|') > 0 ){
                            if( $isHandle== false ){
                                $urlList= $urlList . $url . vbCrlf();
                            }
                        }else{
                            $urlList= $urlList . $url . vbCrlf();
                        }
                    }
                }
            }
        }
    }
    if( $urlList <> '' ){ $urlList= substr($urlList, 0 , strlen($urlList) - 2) ;}
    $handleGetContentUrlList= $urlList;
    return @$handleGetContentUrlList;
}
//�����ַ�������������б�
function getInChain($httpUrl, $urlList){
    $splStr=''; $url=''; $c=''; $urlLCase=''; $isHandle ='';
    $splStr= aspSplit($urlList, vbCrlf());
    $urlList= '';
    foreach( $splStr as $url){
        if( $url <> '' ){
            $urlLCase= strtolower($url);
            if( substr($urlLCase, 0 , 1) <> '#' && substr($urlLCase, 0 , 11) <> 'javascript:' ){
                if( instr(vbCrlf() . $urlList . vbCrlf(), vbCrlf() . $url . vbCrlf())== false ){
                    $url= fullHttpUrl($httpUrl, $url);
                    $isHandle= isSonWebSite($url, $httpUrl);
                    if( $isHandle== true ){
                        $urlList= $urlList . $url . vbCrlf();
                    }
                }
            }
        }
    }
    if( $urlList <> '' ){ $urlList= substr($urlList, 0 , strlen($urlList) - 2) ;}
    $getInChain= $urlList;
    return @$getInChain;
}
?>