<?PHP
//URL ��ַ���� (2013,9,27)

//  byref PubAHrefList, byref PubATitleList   ΪΪʲôҪ����byref  ����Ϊ��תPHPʱ��Ҫ����жϣ��������ǵ�ַ���� �ǹ�������

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
    $url= mid($url, inStrRev($url, '/') + 1,-1);
    $getThisUrlFileParam= $url;
    return @$getThisUrlFileParam;
}

//��õ�ǰ��ַ�޲���
function getThisUrlNoParam(){
    $httpType ='';
    if( lCase(serverVariables('HTTPS'))== 'off' ){
        $httpType= 'http://';
    }else{
        $httpType= 'https://';
    }
    $getThisUrlNoParam= $httpType . serverVariables('HTTP_HOST') . serverVariables('SCRIPT_NAME');
    return @$getThisUrlNoParam;
}

//��ô�������ַ
function getGoToUrl(){
    $getGoToUrl= serverVariables('HTTP_REFERER');
    return @$getGoToUrl;
}

//��ô�������ַ �޲���
function getGoToUrlNoParam(){
    $url ='';
    $url= getGoToUrl();
    if( inStr($url, '?') > 0 ){
        $url= mid($url, 1, inStr($url, '?') - 1);
    }
    $getGoToUrlNoParam= $url;
    return @$getGoToUrlNoParam;
}

//��ô�������ַ ���ļ�����
function getGoToUrlNoFileName(){
    $url ='';
    $url= getGoToUrl();
    if( right($url, 1) <> '/' ){
        if( inStrRev($url, '/') > 0 ){
            $url= mid(getGoToUrlNoParam(), 1, inStrRev(getGoToUrlNoParam(), '/'));
        }
    }
    if( right($url, 1) <> '/' ){ $url= $url . '/' ;}
    $getGoToUrlNoFileName= $url;
    return @$getGoToUrlNoFileName;
}
//�Ƴ���ַ�ļ�������
function remoteUrlFileName( $url){
    if( right($url, 1) <> '/' ){
        if( inStrRev($url, '/') > 0 ){
            $url= mid($url, 1, inStrRev($url, '/'));
        }
    }
    $remoteUrlFileName=$url;
    return @$remoteUrlFileName;
}
//�Ƴ���ַ��������
function remoteUrlParam( $url){
    if( right($url, 1) <> '?' ){
        if( inStrRev($url, '?') > 0 ){
            $url= mid($url, 1, inStrRev($url, '?')-1);
        }
    }
    $remoteUrlParam=$url;
    return @$remoteUrlParam;
}
//�����ַĿ¼����
function getUrlDir( $url){
    $getUrlDir=getHandleUrlValue($url,'��ַĿ¼');
    return @$getUrlDir;
}
//��ô����urlֵ 20160701
function getHandleUrlValue( $url, $sType){
    $sType='|'. $sType .'|';
    if( inStr($url,'://')>0 ){
        $url=mid($url,inStr($url,'://')+3,-1);
    }
    //ȥ������
    if( inStr($url,'/')>0 ){
        $url=mid($url,inStr($url,'/')+1,-1);
    }

    if( inStr($sType,'|��ַĿ¼|')>0 ){
        if( inStr($url,'/')>0 ){
            $url=mid($url,1,inStrRev($url,'/')-1);
        }
    }else{
        if( inStr($url,'/')>0 ){
            $url=mid($url,inStrRev($url,'/')+1,-1);
        }
        if( inStr($url,'?')>0 ){
            $url=mid($url,1,inStr($url,'?')-1);
        }
    }
    if( inStr($sType,'|����|')>0 || inStr($sType,'|name|')>0 ){
        if( inStr($url,'.')>0 ){
            $url=mid($url,1,inStrRev($url,'.')-1);
        }
    }
    $getHandleUrlValue=$url;
    return @$getHandleUrlValue;
}

//��ȡ�ͻ���IP��ַ�ڶ���
function getIP2(){

    $x=''; $y=''; $addr ='';
    $x= serverVariables('HTTP_X_FORWARDED_FOR');
    $y= serverVariables('REMOTE_ADDR');
    $addr= IIF(isNul($x) || lCase($x)== 'unknown', $y, $x);
    if( inStr($addr, '.')== 0 ){ $addr= '0.0.0.0' ;}
    $getIP2= $addr;
    return @$getIP2;
}

//��ȡIP��ַ ����д�ú����רҵһ�� ��ȫ
function getIP(){

    $strIPAddr ='';
    if( serverVariables('HTTP_X_FORWARDED_FOR')== '' || inStr(serverVariables('HTTP_X_FORWARDED_FOR'), 'unknown') > 0 ){
        $strIPAddr= serverVariables('REMOTE_ADDR');
    }else if( inStr(serverVariables('HTTP_X_FORWARDED_FOR'), ',') > 0 ){
        $strIPAddr= mid(serverVariables('HTTP_X_FORWARDED_FOR'), 1, inStr(serverVariables('HTTP_X_FORWARDED_FOR'), ',') - 1);
    }else if( inStr(serverVariables('HTTP_X_FORWARDED_FOR'), ';') > 0 ){
        $strIPAddr= mid(serverVariables('HTTP_X_FORWARDED_FOR'), 1, inStr(serverVariables('HTTP_X_FORWARDED_FOR'), ';') - 1);
    }else{
        $strIPAddr= serverVariables('HTTP_X_FORWARDED_FOR');
    }
    $getIP= aspTrim(mid($strIPAddr, 1, 30));
    return @$getIP;
}

//��÷�����IP
function getServicerIP(){
    $getServicerIP= serverVariables('LOCAL_ADDR');
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
    $httpUrl= replace(aspTrim($httpUrl), '\\', '/');
    $headStr= mid($httpUrl, 1, inStr($httpUrl, ':') + 2);
    $httpUrl= mid($httpUrl, inStr($httpUrl, ':') + 3,-1);
    $httpUrl= replace($httpUrl, 'http://', '��|http|��');
    $httpUrl= replace($httpUrl, 'https://', '��|https|��');
    $httpUrl= replace($httpUrl, 'ftp://', '��|ftp|��');

    while( inStr($httpUrl, '//') > 0){
        $httpUrl= replace($httpUrl, '//', '/');
    }
    $httpUrl= replace($httpUrl, '��|http|��', 'http://');
    $httpUrl= replace($httpUrl, '��|https|��', 'https://');
    $httpUrl= replace($httpUrl, '��|ftp|��', 'ftp://');

    $url= $headStr . $httpUrl;
    ///"http://www.qibosoft.com/images/qibosoft/loading.gif/"
    if( left($url, 2)== '/"' ){
        $url= mid($url, 3,-1);
    }
    if( right($url, 2)== '/"' ){
        $url= mid($url, 1, len($url) - 2);
    }
    $handleHttpUrl= $url;
    return @$handleHttpUrl;
}

//�����ļ�/ת\   ʹ����While�жϣ�������
function handleFileUrl($fileUrl){
    $fileUrl= replace($fileUrl, '/', '\\');
    $i ='';
    for( $i= 1 ; $i<= 99; $i++){
        $fileUrl= replace($fileUrl, '\\\\', '\\');

        if( inStr($fileUrl, '\\\\')== false ){
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
    if( inStr($httpUrl, '?') > 0 ){ return @$handleUrlComplete; }//��?�������˳�
    //��ַ���û��/  �ж����Ϊ���� ����������/�˳�
    if( right($httpUrl, 1) <> '/' ){
        if( $httpUrl . '/'== getWebSite($httpUrl) ){
            $handleUrlComplete= $httpUrl . '/';
            return @$handleUrlComplete;
        }
    }
    $lastStr= mid($httpUrl, inStrRev($httpUrl, '/') + 1,-1);
    if( $lastStr <> '' && inStr($lastStr, '.')== false ){
        $handleUrlComplete= $httpUrl . '/';
    }
    return @$handleUrlComplete;
}

//����ַ�������
function urlAddHttpUrl($httpUrl, $url){
    $httpUrl= replace($httpUrl, '\\', '/');
    $url= handleHttpUrl($url);
    if( inStr(lCase($url), 'http://')== 0 && inStr(lCase($url), 'www.')== 0 ){
        if( right($httpUrl, 1)== '/' && left($url, 1)== '/' ){
            $url= $httpUrl . mid($url, 2,-1);
        }else if( right($httpUrl, 1) <> '/' && left($url, 1) <> '/' ){
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
    $port= cStr(serverVariables('SERVER_PORT'));
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
    $webDoMain= 'http://' . serverVariables('SERVER_NAME') . getPort();
    return @$webDoMain;
}

//��õ�ǰ����
function host(){
    $host= 'http://' . serverVariables('HTTP_HOST') . '/';
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
    $url=serverVariables('server_name');
    //PHP������ֱ�ӻ�ö˿�
    if( inStr($url, ':')== false ){
        $url= $url . getPort();
    }
    $url= $url . serverVariables('script_name');
    if( serverVariables('QUERY_STRING') <> '' ){ $url= $url . '?' . serverVariables('QUERY_STRING') ;}
    //vbdel end
    $getThisUrl= 'http://' . $url;
    return @$getThisUrl;
}
//��õ�ǰ���ļ�������ַ
function getThisUrlNoFileName(){
    $url ='';
    $url= getThisUrl();
    if( right($url, 1) <> '/' ){
        if( inStrRev($url, '/') > 0 ){
            $url= mid($url, 1, inStrRev($url, '/'));
        }
    }
    $getThisUrlNoFileName= $url;
    return @$getThisUrlNoFileName;
}

//�����ַ�������� http://www.aaa.bb.mywebname.com/   mywebname
function getWebSiteName($httpUrl){
    $url=''; $splStr=''; $s=''; $domainName ='';
    $url= getWebSite($httpUrl);
    $url= replace($url, '://', '://.');
    $splStr= aspSplit($url, '.');
    foreach( $splStr as $key=>$s){
        if( inStr($s, '/')== false && $s <> '' ){
            if( len($s) >= 4 ){
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
    $url=''; $tempHttpUrl=''; $is_WebSite='';$httpHead='';
    $tempHttpUrl= $httpUrl;
    $url= aspTrim(lCase(replace($httpUrl, '?', '/')));
    $url= replace(replace($url, '\\', '/'), 'http://', '');
    if( inStr($url, '/') > 0 ){ $url= mid($url, 1, inStr($url, '/') - 1) ;}
    $url= 'http://' . $url . '/';
    $splStr=''; $s=''; $c ='';
    $httpUrl= replace(lCase($httpUrl), 'http://', '');
    $httpHead='http://';
    //������https://���ְ�ȫ����ʽ  20160526
    if( inStr(lCase($httpUrl), 'https://')>0 ){
        $httpUrl= replace(lCase($httpUrl), 'https://', '');
        $httpHead='https://';
    }
    //ɾ��/��̨��ֵ20160526
    if( inStr($httpUrl,'/')>0 ){
        $httpUrl=mid($httpUrl,1,inStr($httpUrl,'/')-1);
    }
    if( inStr($httpUrl, '?') > 0 ){ $httpUrl= mid($httpUrl, 1, inStr($httpUrl, '?') - 1) ;}
    if( left($httpUrl, 9)== 'localhost' ){
        if( inStr($httpUrl, '/') > 0 ){
            $httpUrl= mid($httpUrl, 1, inStr($httpUrl, '/') - 1);
        }else{
            $httpUrl= 'localhost';
        }
    }else if( left($httpUrl, 8)== '192.168.' || left($httpUrl, 9)== '127.0.0.1' ){
        $httpUrl= $httpUrl . '/';
        $httpUrl= 'http://' . mid($httpUrl, 1, inStr($httpUrl, '/') - 1) . '/';
        $getWebSite= $httpUrl ; return @$getWebSite;
    }else{
        $splStr= aspSplit($httpUrl, '.');
        if((inStr($httpUrl, 'www.') > 0 && uBound($splStr) >= 2) || uBound($splStr) >= 1 ){
            if( inStr($httpUrl, '/') > 0 ){
                $s= mid($httpUrl, 1, inStr($httpUrl, '/') - 1);
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
    $c= $c . '|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in|.top|.win|.vip|.pw|.me|.wiki';
    $splStr= aspSplit($c, '|');
    foreach( $splStr as $key=>$s){
        if( $s <> '' ){
            if( inStr($httpUrl, $s) > 0 ){
                $httpUrl= $httpHead . left($httpUrl, inStr($httpUrl, $s) + len($s) - 1) . '/' ; $is_WebSite= true ; break;
            }
        }
    }
    $getWebSite= left($httpUrl, 255); //���������ڣ���ֻ��ȡ255���ַ�
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
//��������� style="background: url(20130510162636_96168.jpg) no-repeat scroll center top; height: 426px;cursor:pointer; width: 100%; margin:0 auto;" 20160701
function fullHttpUrl( $httpUrl, $url){
    //On Error Resume Next
    //������� Ҫ��Ȼ�ᱨ��
    $rootUrl=''; $thisUrl=''; $splStr=''; $i=''; $s=''; $c=''; $parentUrl=''; $parentParentUrl=''; $parentParentParentUrl=''; $rootWebSite=''; $thisWebSite=''; $handleYes='';$lCaseUrl='';
    $styleStart='';$styleEnd='';
    $httpUrl= PHPTrim($httpUrl); //������߿ո�
    $url= PHPTrim($url); //������߿ո�
    $lCaseUrl=lCase($url);
    if( $url== '' ){ $fullHttpUrl= '' ; return @$fullHttpUrl; }//��ַΪ���˳�(20150805)
    if( aspTrim($httpUrl)== '' ){ $fullHttpUrl= $url ; return @$fullHttpUrl; }//����ַΪ���˳� ������ַ
    $httpUrl= replace($httpUrl, '\\', '/'); //����ַ\ת/����
    $url= replace($url, '\\', '/'); //����ַ\ת/����

    //��ַǰ�����ַ�Ϊ//���˳�
    if( left($url, 2)== '//' ){
        $fullHttpUrl= 'http:' . $url;
        return @$fullHttpUrl;
    }
    //����style��ʽ�ﱳ��ͼƬ
    $url=hanldeStyleBackgroundUrl($url,$styleStart,$styleEnd);
    $rootUrl= getWebSite($httpUrl); //��������Ҳ��������ַ
    $rootWebSite= $rootUrl;
    $thisWebSite= getWebSite($url);
    if( right($rootUrl, 1)== '/' ){ $rootUrl= left($rootUrl, len($rootUrl) - 1); }
    $thisUrl= left($httpUrl, inStrRev($httpUrl, '/')); //��ǰ��ַ
    $splStr= aspSplit($httpUrl, '/');
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        if( $i + 1== uBound($splStr) ){ $parentUrl= $c ;}
        if( $i + 2== uBound($splStr) ){ $parentParentUrl= $c ;}
        if( $i + 3== uBound($splStr) ){ $parentParentParentUrl= $c ;}
        $s= $splStr[$i];
        $c= $c . $s . '/';
    }
    $url= aspTrim($url); //ȥ����ַ���ҿո�
    $handleYes= false; //����Ϊ��
    if( $url <> '' && inStr(left($url, 10), 'www.')== false && inStr(left($url, 10), 'http://')== false && inStr(left($url, 10), 'https://')== false ){
        $handleYes= true;
        if( $rootWebSite <> $thisWebSite ){
            if( $rootWebSite== replace($thisWebSite, 'http://', 'http://www.') ){
                $handleYes= false;
                if( inStr(lCase($url), 'http://') > 0 ){
                    $url= 'http://www.' . right($url, len($url) - 7);
                }else{
                    $url= 'http://www.' . $url;
                }
            }
        }
    }
    //�����Ƿ�Ϊ��
    if( $handleYes== true ){
        if( left($url, 1)== '/' ){
            $url= $rootUrl . $url;
        }else if( left($url, 9)== '../../../' ){
            $url= $parentParentParentUrl . right($url, len($url) - 9);
        }else if( left($url, 6)== '../../' ){
            $url= $parentParentUrl . right($url, len($url) - 6);
        }else if( left($url, 3)== '../' ){
            $url= $parentUrl . right($url, len($url) - 3);
        }else if( left($url, 2)== './' ){
            $url= $thisUrl . mid($url, 3,-1);
        }else{
            $url= $thisUrl . $url;
        }
    }
    if( inStr(lCase($url), 'http://')== false && inStr(lCase($url), 'https://')== false ){
        if( inStr(lCase($httpUrl), 'http://') > 0 && inStr(lCase($url), 'http://')== false ){
            $url= 'http://' . $url;
        }else if( inStr(lCase($httpUrl), 'https://') > 0 && inStr(lCase($url), 'https://')== false ){
            $url= 'https://' . $url;
        }
    }
    $fullHttpUrl= $styleStart . $url . $styleEnd;

    return @$fullHttpUrl;
}
//������ʽ�ﱳ��ͼƬ20160701
function hanldeStyleBackgroundUrl( $url,$styleStart,$styleEnd){
    $lCaseUrl='';
    $url= PHPTrim($url); //������߿ո�
    $lCaseUrl=lCase($url);
    $url= replace($url, '\\', '/'); //����ַ\ת/����
    if( inStr($url,'background:')>0 && inStr($url,'(')>0 && inStr($url,')')>0 ){
        $styleStart=mid($url,1,inStr($url,'('));
        $styleEnd=mid($url,inStr($url,')'),-1);
        $url=mid($url,len($styleStart)+1,-1);
        $url=PHPTrim(mid($url,1,inStr($url,')')-1));
        $url=replace(replace($url,'\'',''),'"','');
    }
    $hanldeStyleBackgroundUrl=$url;
    return @$hanldeStyleBackgroundUrl;
}

//����������ַ����20150728
function batchFullHttpUrl($webSite, $urlList){
    $splStr=''; $url=''; $c ='';
    $splStr= aspSplit($urlList, vbCrlf());
    foreach( $splStr as $key=>$url){
        if( len($url) > 3 ){
            if( $c <> '' ){ $c= $c . vbCrlf() ;}
            $c= $c . fullHttpUrl($webSite, $url);
        }
    }
    $batchFullHttpUrl= $c;
    return @$batchFullHttpUrl;
}


//��ַ�����ַ� ��ദ��
function uRLJianJieHandle( $url){
    $url= replace($url, '&amp;', '&');
    $uRLJianJieHandle= $url;
    return @$uRLJianJieHandle;
}

//URL���� �������С�������
function urlToAsc($url){
    $i ='';
    for( $i= 1 ; $i<= len($url); $i++){
        $urlToAsc= $urlToAsc . '%' . hex(ascW(mid($url, $i, 1)));
    }
    return @$urlToAsc;
}


//�����վ����
function getWebTitle($content){
    $getWebTitle= getStrCut($content, '<title>', '</title>', 0);
    return @$getWebTitle;
}

//���������ַ�б� (ȱ������ַȫ��Сд��20150728)
function getContentAHref($httpUrl, $content, &$PubAHrefList, &$PubATitleList){
    $i=''; $s=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $TempS= lCase(mid($content, $i,-1));
            $LalType= lCase(mid($TempS, 1, inStr($TempS, ' ')));
            if( $LalType== '<a ' ){
                $LalStr= mid($TempS, 1, inStr($TempS, '</') + 2);
                $nLen= len($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'href', '', 'url', $PubAHrefList, $PubATitleList) . vbCrlf();
                $i= $i + $nLen;
            }
        }
        doEvents( );
    }
    if( $c <> '' ){ $c= left($c, len($c) - 2); }
    $getContentAHref= $c;
    return @$getContentAHref;
}

//���������ͼƬ�б�
function getContentImgSrc($httpUrl, $content, &$PubAHrefList, &$PubATitleList){
    $i=''; $s=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $TempS= lCase(mid($content, $i,-1));
            $LalType= lCase(mid($TempS, 1, inStr($TempS, ' ')));
            if( $LalType== '<img ' ){
                $LalStr= mid($TempS, 1, inStr($TempS, '>'));
                $nLen= len($LalStr) - 1;
                //Call Echo(I,LalStr)
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', 'url', $PubAHrefList, $PubATitleList) . vbCrlf();
                $i= $i + $nLen;
            }
        }
        doEvents( );
    }
    if( $c <> '' ){ $c= left($c, len($c) - 2); }
    $getContentImgSrc= $c;
    return @$getContentImgSrc;
}

//����������ַ���� sType=|*|link|img|a|script|embed|param|meta|
function handleConentUrl($httpUrl, $content, $sType, &$PubAHrefList, &$PubATitleList){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    $sType= '|' . $sType . '|';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= lCase($YuanStr);
            $TempS= replace(replace($TempS, chr(10), ' ' . vbCrlf()), chr(13), ' ' . vbCrlf()); //�ô���ͼƬ�زĸ�����  ����  <img����src=""  Ҳ���Ի�� 20150714
            $LalStr= mid($YuanStr, 1, inStr($YuanStr, '>'));
            $LalType= lCase(mid($TempS, 1, inStr($TempS, ' ')));
            if( $LalType== '<link ' &&(inStr($sType, '|link|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'href', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;
            }else if( $LalType== '<img ' &&(inStr($sType, '|img|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;
            }else if( $LalType== '<a ' &&(inStr($sType, '|a|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                //û��javascript�����У����ǻ����в���֮��
                if( inStr(lCase($LalStr), 'javascript:')== 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'href', '', '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else if( $LalType== '<script ' &&(inStr($sType, '|script|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                if( inStr(lCase($LalStr), 'src') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else if( $LalType== '<embed ' &&(inStr($sType, '|embed|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;
            }else if( $LalType== '<param ' &&(inStr($sType, '|param|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                if( inStr(lCase($LalStr), 'movie') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'value', '', '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;
            }else if( $LalType== '<meta ' &&(inStr($sType, '|meta|') > 0 || inStr($sType, '|*|') > 0) ){
                $nLen= len($LalStr) - 1;
                //�滻�ؼ���
                if( inStr(lCase($LalStr), 'keywords') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'content', $GLOBALS['WebKeywords'], '', $PubAHrefList, $PubATitleList);
                    //�滻��վ����
                }else if( inStr(lCase($LalStr), 'description') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'content', $GLOBALS['WebDescription'], '', $PubAHrefList, $PubATitleList);
                }else{
                    $c= $c . $LalStr;
                }
                $i= $i + $nLen;

            }else if( $LalType== '<input ' &&(inStr($sType, '|src|') > 0 || inStr($sType, '|*|') > 0) && inStr(lCase($LalStr),' src=')>0 ){
                $nLen= len($LalStr) - 1;
                $c= $c . handleLink($httpUrl, $LalStr, 'src', '', '', $PubAHrefList, $PubATitleList);
                $i= $i + $nLen;

            }else if( inStr($sType, '|imgstyle|') > 0 ){
                $nLen= len($LalStr) - 1;
                if( inStr(lCase($LalStr),'url')>0 && inStr(lCase($LalStr),':')>0 && inStr(lCase($LalStr),'(')>0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'style', '', '', $PubAHrefList, $PubATitleList);
                    $i= $i + $nLen;
                }else{
                    $c= $c . $s;
                }
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
function replaceContentJsDir($content, $dirPath, &$PubAHrefList, &$PubATitleList){
    $splStr=''; $s=''; $c ='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( $c <> '' ){ $c= $c . vbCrlf() ;}
        if( inStr($s, '<script ') > 0 && inStr($s, '</script>') > 0 ){
            $s= handleLink($dirPath, $s, 'src', '', 'replaceDir', $PubAHrefList, $PubATitleList);
        }
        $c= $c . $s;
    }
    $replaceContentJsDir= $c;
    return @$replaceContentJsDir;
}


//�������ӵ�ַ HttpUrl=׷����ַ��Content=����  SType=����
//�滻Ŀ¼����  call rw(HandleLink("Js/", "111111<script src=""js/Jquery.Min.js""></"& "script>","src", "newurl", "replaceDir","",""))
function handleLink($httpUrl, $content, $sType, $SetStr, $UrlOrContent, &$PubAHrefList, &$PubATitleList){

    $splStr=''; $i=''; $s=''; $c=''; $TempContent=''; $FindUrl=''; $HandleUrl=''; $startStr=''; $endStr=''; $s1=''; $s2=''; $tempHttpUrl ='';
    $tempHttpUrl= $httpUrl;
    $UrlOrContent= lCase($UrlOrContent);
    $content= replace(replace($content, '= ', '='), '= ', '=');
    $content= replace(replace($content, ' =', '='), ' =', '=');
    $TempContent= lCase($content);
    //û�������˳�
    if( inStr($TempContent, ' href=')== 0 && inStr($TempContent, ' src=')== 0 && $sType<>'style' ){
        $handleLink= '';
        return @$handleLink;
    }else if( inStr($TempContent, ' href=\\"') > 0 ){
        $content= replace($content, '\\"', '"') ; $TempContent= lCase($content);
    }
    $startStr= $sType . '="';
    $endStr= '"';
    if( inStr($TempContent, $startStr) > 0 && inStr($TempContent, $endStr) > 0 ){
        //call echo("��ʾ","1")
        $FindUrl= StrCut($content, $startStr, $endStr, 2);
        if( $SetStr <> '' ){
            $HandleUrl= $SetStr;
        }else{
            $HandleUrl= fullHttpUrl($httpUrl, $FindUrl);
            //�滻Ŀ¼
            if( $UrlOrContent== 'replacedir' ){
                $HandleUrl= $tempHttpUrl . handleFilePathArray($HandleUrl)[2];
            }
            $PubAHrefList= $PubAHrefList . hanldeStyleBackgroundUrl($HandleUrl,'','') . vbCrlf();
            //���ӱ���
            $s1= inStr($content, '>');
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, 1, inStrRev($s2, '</') - 1);
            $s2= replace($s2, vbCrlf(), '�����С�');
            $PubATitleList= $PubATitleList . $s2 . vbCrlf();
        }
        if( $FindUrl <> $HandleUrl ){
            //ǿǿǿ���滻
            $s1= inStr($content, $startStr) - 1 + len($startStr); //��������TempContent������Content��Ϊ�д�Сд������20140726
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, inStr($s2, $endStr),-1);
            $s1= left($content, $s1);
            $content= $s1 . $HandleUrl . $s2;
        }
        if( $UrlOrContent== 'url' ){
            $handleLink= $HandleUrl;
        }else{
            $handleLink= $content;
        }
        return @$handleLink;
    }
    $startStr= $sType . '=\'';
    $endStr= '\'';
    if( inStr($TempContent, $startStr) > 0 && inStr($TempContent, $endStr) > 0 ){
        //call echo("��ʾ","2")
        $FindUrl= StrCut($TempContent, $startStr, $endStr, 2);
        if( $SetStr <> '' ){
            $HandleUrl= $SetStr;
        }else{
            $HandleUrl= fullHttpUrl($httpUrl, $FindUrl);
            //�滻Ŀ¼
            if( $UrlOrContent== 'replacedir' ){
                $HandleUrl= $tempHttpUrl . handleFilePathArray($HandleUrl)[2];
            }
            $PubAHrefList= $PubAHrefList . hanldeStyleBackgroundUrl($HandleUrl,'','') . vbCrlf();
            //���ӱ���
            $s1= inStr($content, '>');
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, 1, inStrRev($s2, '</') - 1);
            $s2= replace($s2, vbCrlf(), '�����С�');
            $PubATitleList= $PubATitleList . $s2 . vbCrlf();
        }
        if( $FindUrl <> $HandleUrl ){
            //ǿǿǿ���滻
            $s1= inStr($content, $startStr) - 1 + len($startStr);
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, inStr($s2, $endStr),-1);
            $s1= left($content, $s1);
            $content= $s1 . $HandleUrl . $s2;
        }
        if( $UrlOrContent== 'url' ){
            $handleLink= $HandleUrl;
        }else{
            $handleLink= $content;
        }
        return @$handleLink;
    }
    $startStr= $sType . '=';
    $endStr= '>'; //�������֮�ҵ� �ո񻻳�>
    if( inStr($TempContent, $startStr) > 0 && inStr($TempContent, $endStr) > 0 ){
        $FindUrl= StrCut($TempContent, $startStr, $endStr, 2);

        if( $SetStr <> '' ){
            $HandleUrl= $SetStr;
        }else{
            $HandleUrl= fullHttpUrl($httpUrl, $FindUrl);
            //�滻Ŀ¼
            if( $UrlOrContent== 'replacedir' ){
                $HandleUrl= $tempHttpUrl . handleFilePathArray($HandleUrl)[2];
            }
            $PubAHrefList= $PubAHrefList . hanldeStyleBackgroundUrl(handleHttpUrl($HandleUrl),'','') . vbCrlf();
            //���ӱ���
            $s1= inStr($content, '>');
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, 1, inStrRev($s2, '</') - 1);
            $s2= replace($s2, vbCrlf(), '�����С�');
            $PubATitleList= $PubATitleList . $s2 . vbCrlf();
        }
        if( $FindUrl <> $HandleUrl ){
            //ǿǿǿ���滻
            $s1= inStr($content, $startStr) - 1 + len($startStr);
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, inStr($s2, $endStr),-1);
            $s1= left($content, $s1);
            $content= $s1 . $HandleUrl . $s2;
        }
        if( $UrlOrContent== 'url' ){
            $handleLink= $HandleUrl;
        }else{
            $handleLink= $content;
        }
        return @$handleLink;
    }

    if( $UrlOrContent <> 'url' ){ $handleLink= $content ;}
    CreateAddFile('���������б�.txt', $httpUrl . vbCrlf() . $content . vbCrlf() . $sType . vbCrlf() . $SetStr . vbCrlf() . $UrlOrContent . vbCrlf() . '----------------------' . vbCrlf());
    return @$handleLink;
}


//�����վĿ¼�ļ������� \Templates\WeiZhanLue\  �õ�WeiZhanLue
function getEndUrlHandleName($FileUrl){
    $url ='';
    $url= replace(aspTrim($FileUrl), '\\', '/');
    if( right($url, 1)== '/' ){ $url= mid($url, 1, len($url) - 1) ;}
    $url= mid($url, inStrRev($url, '/') + 1,-1);
    $getEndUrlHandleName= $url;
    return @$getEndUrlHandleName;
}


//����б��в�ͬ�����б�
function getUrlListInWebSiteList($content){
    $url=''; $UrlList=''; $splStr ='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$url){
        $url= getWebSite($url);
        if( $url <> '' && inStr(vbCrlf() . $UrlList . vbCrlf(), vbCrlf() . $url . vbCrlf())== 0 ){
            $UrlList= $UrlList . $url . vbCrlf();
        }
        doEvents( );
    }
    $getUrlListInWebSiteList= $UrlList;
    return @$getUrlListInWebSiteList;
}

//��õ�ǰ��ַ���ļ�����
function getThisUrlFileName(){
    $url ='';
    $url= serverVariables('SCRIPT_NAME');
    if( left($url, 1)== '/' ){ $url= right($url, len($url) - 1); }
    $getThisUrlFileName= $url;
    return @$getThisUrlFileName;
}

//������վHTML��Img    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)
function handleWebHtmlImg($RootPath, $content, &$PubAHrefList, &$PubATitleList){
    $ImgList=''; $splStr=''; $imgUrl=''; $NewImgUrl ='';
    $startStr=''; $endStr ='';
    $ImgList= getContentImgSrc('', $content, $PubAHrefList, $PubATitleList);
    $splStr= aspSplit($ImgList, vbCrlf());
    foreach( $splStr as $key=>$imgUrl){
        if( $imgUrl <> '' ){
            $NewImgUrl= handleHttpUrl($imgUrl);
            if( inStr($NewImgUrl, '/') > 0 ){
                $NewImgUrl= mid($NewImgUrl, inStrRev($NewImgUrl, '/') + 1,-1);
            }
            $NewImgUrl= $RootPath . $NewImgUrl;
            //Call Echo(NewImgUrl,ImgUrl)
            $startStr= 'src="' ; $endStr= '"';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
                $content= regExp_Replace($content, $startStr . $imgUrl . $endStr, $startStr . $NewImgUrl . $endStr);
            }
            $startStr= 'src=\'' ; $endStr= '\'';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
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
    $ImgList= GetArray($content, $startStr, $endStr, false, false);
    //Call RwEnd(ImgList)
    $splStr= aspSplit($ImgList, '$Array$');
    foreach( $splStr as $key=>$imgUrl){
        if( $imgUrl <> '' ){
            $NewImgUrl= handleHttpUrl($imgUrl);
            if( inStr($NewImgUrl, '/') > 0 ){
                $NewImgUrl= mid($NewImgUrl, inStrRev($NewImgUrl, '/') + 1,-1);
            }
            $NewImgUrl= $RootPath . $NewImgUrl;
            $startStr= 'url(';
            $endStr= ')';
            if( inStr($content, $startStr) > 0 && inStr($content, $endStr) > 0 ){
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
    foreach( $splUrl as $key=>$url){
        if( $url <> '' ){
            $url= fullHttpUrl($httpUrl, $url);
            if( inStr(vbCrlf() . $c . vbCrlf(), vbCrlf() . $url . vbCrlf())== false ){
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
    if( right($RootFolder, 1) <> '/' ){ $RootFolder= $RootFolder . '/' ;}
    $ImageList= getDirFileNameList($RootFolder,'');
    $splxx= aspSplit($ImageList, vbCrlf());
    foreach( $splxx as $key=>$ImageFile){
        if( $ImageFile <> '' ){
            $ToImageFile= 'file:///' . $RootFolder . $ImageFile;
            //html��ͼƬ·���滻
            $content= replace($content, '"' . $ImageFile . '"', '"' . $ToImageFile . '"');
            $content= replace($content, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"');
            $content= replace($content, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"');
            $content= replace($content, '=' . $ImageFile . '>', '"' . $ToImageFile . '"');
            //Css��ͼƬ·���滻
            $content= replace($content, '(' . $ImageFile . ')', '(' . $ToImageFile . ')');
            $content= replace($content, '(' . $ImageFile . ';', '(' . $ToImageFile . ';');
        }
    }
    $replaceContentImagePath= $content;
    return @$replaceContentImagePath;
}

//���Css�����б� ������
function getCssLinkList( $content){
    $startStr=''; $endStr=''; $splStr=''; $s=''; $c=''; $fileName ='';
    $startStr= '<link' ; $endStr= '/>';
    $content= GetArray($content, $startStr, $endStr, false, false);
    $splStr= aspSplit($content, '$Array$');
    foreach( $splStr as $key=>$s){
        if( inStr(lCase($s), 'stylesheet') > 0 ){
            $fileName= StrCut($s, 'href="', '"', 2);
            aspEcho($fileName, $s);
            $c= $c . $fileName . vbCrlf();
        }
    }
    $getCssLinkList= $c;
    return @$getCssLinkList;
}

//���Html��ͼƬ��ַ�б�
function getHtmlBackGroundUrlList($content){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c=''; $startStr=''; $endStr ='';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= lCase($YuanStr);
            $LalStr= mid($YuanStr, 1, inStr($YuanStr, '>'));
            $LalType= lCase(mid($TempS, 1, inStr($TempS, ' ')));
            if( inStr($LalStr, 'url(') > 0 ){
                $startStr= 'url(' ; $endStr= ')';
                $c= $c . StrCut($LalStr, $startStr, $endStr, 2) . vbCrlf();
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
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= lCase($YuanStr);
            $LalStr= mid($YuanStr, 1, inStr($YuanStr, '>'));
            $LalType= lCase(mid($TempS, 1, inStr($TempS, ' ')));
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
    $LinkStr= replace(replace($LinkStr, '= ', '='), '= ', '=');
    $LinkStr= replace(replace($LinkStr, ' =', '='), ' =', '=');
    $TempLinkStr= lCase($LinkStr);

    $startStr= $LinkType . '="';
    $endStr= '"';
    if( inStr($TempLinkStr, $startStr) > 0 && inStr($TempLinkStr, $endStr) > 0 ){
        $LinkUrl= StrCut($TempLinkStr, $startStr, $endStr, 2);
        $getLinkUrl= $LinkUrl;
    }
    return @$getLinkUrl;
}

//�Ǳ�����ַ��Զ����ַ        20141120
function localUrlOrRemoteUrl($filePath, $UrlYes){
    $httpUrl ='';
    $UrlYes= false;
    $filePath= aspTrim($filePath);
    $httpUrl= replace($filePath, '\\', '/');
    if( left(lCase($httpUrl), 7)== 'http://' || left(lCase($httpUrl), 4)== 'www.' || left(lCase($httpUrl), 4)== '[��ַ]' ){
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
    $url= aspTrim($url);
    $httpUrl= replace(unSetFileName($url), '\\', '/');
    $checkRemoteUrl= false;
    if( left(lCase($httpUrl), 7)== 'http://' || left(lCase($httpUrl), 4)== 'www.' || left(lCase($httpUrl), 4)== '[��ַ]' ){
        if( left(lCase($httpUrl), 4)== '[��ַ]' ){
            $url= mid($url, inStr($url, '[��ַ]') + 1,-1);
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
    $url= aspTrim($url);
    //��ǰ��ַ���һ���ַ�Ϊ?��&��ɾ���� ����
    if( right($url, 1)== '?' || right($url, 1)== '&' ){
        $url= aspTrim(mid($url, 1, len($url) - 1));
    }
    //����׷����ַ
    $AddToUrl= aspTrim($AddToUrl);
    //׷����ַ���һ���ַ�Ϊ?��&��ɾ���� ����
    if( left($AddToUrl, 1)== '?' || left($AddToUrl, 1)== '&' ){
        $AddToUrl= aspTrim(mid($AddToUrl, 2,-1));
    }
    //��ַΪ���򷵻�׷����ַ ���˳�
    if( $url== '' ){ $getUrlAddToParam= '?' . $AddToUrl ; return @$getUrlAddToParam; }

    $httpUrl= $url;
    if( inStr($url, '?') > 0 ){
        $httpUrl= mid($url, 1, inStr($url, '?') - 1); //��õ�ǰ·����ַ
        $webSite= getWebSite($url); //��������
        $urlParam= mid($url, inStr($url, '?') + 1,-1);

        $httpUrl= handleHttpUrl($httpUrl);
        if( right($httpUrl, 1) <> '/' ){
            $urlFileName= mid($httpUrl, inStrRev($httpUrl, '/') + 1,-1);
            $httpUrl= left($httpUrl, len($httpUrl) - len($urlFileName));
            //Call Echo(HttpUrl,UrlFileName)
        }
    }

    //����ѡ��  ׷�� �����滻
    if( lCase($sType)== 'replace' || $sType== '�滻' ){
        $content= $AddToUrl . '&' . $urlParam;
        //Call echo("Content",Content)
        if( inStr($AddToUrl, '?') > 0 ){
            $urlFileName= mid($AddToUrl, 1, inStr($AddToUrl, '?') - 1);
            //Call Echo(AddToUrl,UrlFileName)
        }
    }else if((lCase($sType) <> 'delete' || lCase($sType) <> 'del') ){
        $content= $urlParam . '&' . $AddToUrl;
    }

    $content= replace($content, '?', '&');

    //����ɾ������ 20150210
    if( lCase($sType)== 'delete' || lCase($sType)== 'del' ){
        $splStr= aspSplit(lCase($AddToUrl), '&') ; $AddToUrl= '&';
        foreach( $splStr as $key=>$s){
            if( inStr($s, '=') ){
                $s= mid($s, 1, inStr($s, '=') - 1);
            }
            if( $s <> '' ){
                $AddToUrl= $AddToUrl . $s . '&';
            }
        }
        //Call Eerr("AddToUrl",AddToUrl)
    }

    //Call Echo("Content",Content)
    $splStr= aspSplit($content, '&');
    foreach( $splStr as $key=>$s){
        if( inStr($s, '=') > 0 ){
            $splxx= aspSplit($s, '=');
            $paramName= $splxx[0];
            $paramValue= $splxx[1];

            $handleYes= true;

            if( lCase($sType)== 'delete' || lCase($sType)== 'del' ){
                if( inStr('&' . $AddToUrl . '&', '&' . lCase($paramName) . '&') > 0 ){
                    $handleYes= false;
                }
            }

            if( inStr('|' . $paramNameList . '|', '|' . lCase($paramName) . '|')== false && $handleYes== true ){
                $paramNameList= $paramNameList . lCase($paramName) . '|';
                $c= $c . IIF($c== '', '?', '&');
                $c= $c . $paramName . '=' . $paramValue;
            }
        }
    }



    $c= $urlFileName . $c;
    if( getWebSite($c)== '' ){
        if( left($AddToUrl, 1)== '/' ){
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
    $url1= replace($url1, IIF($urlType== '/', '\\', '/'), $urlType);
    $url2= replace($url2, IIF($urlType== '/', '\\', '/'), $urlType);
    $url1= PHPTrim($url1);
    $url2= PHPTrim($url2);
    for( $i= 0 ; $i<= 99; $i++){
        if( right($url1, 1)== $urlType ){
            $url1= mid($url1, 1, len($url1) - 1);
        }else{
            break;
        }
    }
    for( $i= 0 ; $i<= 99; $i++){
        if( left($url2, 1)== $urlType ){
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
    foreach( $splStr as $key=>$s){
        if( inStr($s, '=') > 0 ){
            $leftC= mid($s, 1, inStr($s, '='));
            $rightC= mid($s, inStr($s, '=') + 1,-1);
            if( lCase($sType)== 'post' || $sType== '' ){
                if( $c <> '' ){ $c= $c . '&' ;}
                $rightC= escape($rightC);
            }else if( lCase($sType)== 'cookies' || lCase($sType)== 'cookie' ){
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
    if( inStr($httpUrl, '?')== false ){
        $remoteHttpUrlParameter= $httpUrl;
        return @$remoteHttpUrlParameter;
    }
    $splStr= aspSplit($httpUrl, '&');
    foreach( $splStr as $key=>$s){
        if( inStr($s, '=') > 0 ){
            $leftC= mid($s, 1, inStr($s, '='));
            $rightC= mid($s, inStr($s, '=') + 1,-1);
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
    $searchUrlName= lCase($searchUrlName); //������ַ����תСд
    $url= lCase(serverVariables('script_name'));
    $splStr= aspSplit($searchUrlName, '|');
    foreach( $splStr as $key=>$urlName){
        if( $urlName <> '' ){
            if( inStr($url, $urlName) > 0 ){
                $checkUrlName= true;
                return @$checkUrlName;
            }
        }
    }
    $checkUrlName= false;
    return @$checkUrlName;
}



//ע��   �������������

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
    //on error resume next
    $urlDir=''; $fileName=''; $FileType=''; $fileStr=''; $httpAgreement=''; $webSite=''; $folderDir ='';
    $url= handleHttpUrl($url);

    $urlDir= mid($url, 1, inStrRev($url, '/'));
    $fileStr= mid($url, inStrRev($url, '/') + 1,-1) ; $fileName= $fileStr;
    if( inStr($fileStr, '?') > 0 ){
        $fileName= mid($fileStr, 1, inStr($fileStr, '?') - 1);
    }
    $FileType= mid($fileName, inStrRev($fileName, '.') + 1,-1);
    $httpAgreement= mid($url, 1, inStr($url, ':') - 1);
    $webSite= getWebSite($url);
    //Call echo("url", url)
    //����Ϊ���򷢴ֻ���ļ���Ŀ¼20160613
    if( $webSite<>'' ){
        $folderDir= mid($urlDir, len($webSite),-1);
    }else{
        echoYellowB('ע�⣺������Ч��ַ',$url);
    }
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
    foreach( $splStr as $key=>$url){
        if( $url <> '' ){
            if( $c <> '' ){ $c= $c . vbCrlf() ;}
            $dataArray= handleHttpUrlArray($url);
            $fileName= $dataArray[2];
            $fileType= lCase($dataArray[3]);
            $fileStr= lCase($dataArray[4]);
            if(($fileType== 'js' || $fileType== 'css') && inStr($fileStr, '?') > 0 && inStr($fileName,'.')>0 ){
                $replaceStr= mid($url, 1, inStr($url, '?') - 1);
                //call echo(replaceStr,fileStr)
                //�����滻�������ǲ���׼�����Ľ�
                if( inStr($sType, '|�滻����|') > 0 ){
                    $content= replace($content, $url, $replaceStr);
                }
                if( inStr($sType, '|�滻��ַ|') > 0 ){
                    $urlList= replace($urlList, $url, $replaceStr);
                }
            }
        }
    }
}


//����������ַ����(20151022)
function batchHandleHttpUrlComplete($httpUrl, $content){
    $webSite=''; $splStr=''; $url=''; $lCaseUrl=''; $c ='';
    $webSite= getWebSite($httpUrl);
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$url){
        $url= PHPTrim($url);
        $lCaseUrl= lCase($url);
        if( $lCaseUrl <> '#' && left($lCaseUrl, 11) <> 'javascript:' ){
            if( inStr(vbCrlf() . lCase($c) . vbCrlf(), vbCrlf() . $lCaseUrl . vbCrlf())== false ){
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
    $url1= getWebSite($url1);
    $url2= getWebSite($url2);
    if( inStr($url1, '://') > 0 ){
        $url1= mid($url1, inStr($url1, '://') + 3,-1);
    }
    if( left($url1, 4)== 'www.' ){
        $url1= mid($url1, 5,-1);
    }
    if( inStr($url2, '://') > 0 ){
        $url2= mid($url2, inStr($url2, '://') + 3,-1);
    }
    if( left($url2, 4)== 'www.' ){
        $url2= mid($url2, 5,-1);
    }

    if( $sType== '������' ){
        $splStr=''; $s=''; $c ='';
        $c= '.com.hk|.sh.cn|.com.cn|.net.cn|.org.cn';
        $c= $c . '|.com|.net|.org|.tv|.cc|.info|.cn|.tw|:81|:99|.biz|.mobi|.hk|.us|.la|.gl|.in';
        $splStr= aspSplit($c, '|');
        foreach( $splStr as $key=>$s){
            if( $s <> '' ){
                $url1= replace($url1, $s, '');
                $url2= replace($url2, $s, '');
            }
        }

        if( inStr($url1, '.') ){
            $url1= mid($url1, inStr($url1, '.') + 1,-1);
        }
        if( inStr($url2, '.') ){
            $url2= mid($url2, inStr($url2, '.') + 1,-1);
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
    $sType= '|' . lCase(aspTrim($sType)) . '|';
    $webSite= getWebSite($httpUrl);
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        $nextS= mid($content . ' ', $i + 1, 1);
        $endS= mid($content, $i + 1,-1) ; $endSLCase= lCase($endS);
        if( $s== '<' ){
            $url= '';
            $labelType= '';
            $isHandle= false;
            if( left($endSLCase, 2)== 'a ' ){
                $labelType= 'a';
                $valueLabel= 'href';
                $isHandle= true;
            }else if( left($endSLCase, 5)== 'link ' ){
                $labelType= 'link';
                $valueLabel= 'href';
                $isHandle= true;
            }else if( left($endSLCase, 4)== 'img ' ){
                $labelType= 'img';
                $valueLabel= 'src';
                $isHandle= true;
            }else if( left($endSLCase, 7)== 'script ' ){
                $labelType= 'script';
                $valueLabel= 'src';
                $isHandle= true;
            }
            if( $isHandle== true ){
                if( inStr($sType, '|' . $labelType . '|') > 0 || inStr($sType, '|*|') > 0 ){
                    $nLen= inStr($endS, '>');
                    $urlStr= mid($endS, 1, $nLen);
                    $url= RParam($urlStr, $valueLabel);
                    $i= $i + $nLen;
                }
            }
            if( $url <> '' ){
                $urlLCase= lCase($url);
                if( $urlLCase <> '#' && left($urlLCase, 11) <> 'javascript:' ){
                    if( inStr(vbCrlf() . $urlList . vbCrlf(), vbCrlf() . $url . vbCrlf())== false ){
                        $url= fullHttpUrl($httpUrl, $url);
                        $isHandle= isSonWebSite($url, $httpUrl);
                        if( inStr($sType, '|����|') > 0 ){
                            if( $isHandle== true ){
                                $urlList= $urlList . $url . vbCrlf();
                            }
                        }else if( inStr($sType, '|����|') > 0 ){
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
    if( $urlList <> '' ){ $urlList= left($urlList, len($urlList) - 2); }
    $handleGetContentUrlList= $urlList;
    return @$handleGetContentUrlList;
}
//�����ַ�������������б�
function getInChain($httpUrl, $urlList){
    $splStr=''; $url=''; $c=''; $urlLCase=''; $isHandle ='';
    $splStr= aspSplit($urlList, vbCrlf());
    $urlList= '';
    foreach( $splStr as $key=>$url){
        if( $url <> '' ){
            $urlLCase= lCase($url);
            if( left($urlLCase, 1) <> '#' && left($urlLCase, 11) <> 'javascript:' ){
                if( inStr(vbCrlf() . $urlList . vbCrlf(), vbCrlf() . $url . vbCrlf())== false ){
                    $url= fullHttpUrl($httpUrl, $url);
                    $isHandle= isSonWebSite($url, $httpUrl);
                    if( $isHandle== true ){
                        $urlList= $urlList . $url . vbCrlf();
                    }
                }
            }
        }
    }
    if( $urlList <> '' ){ $urlList= left($urlList, len($urlList) - 2); }
    $getInChain= $urlList;
    return @$getInChain;
}


//����ɨ�����ַ�б� 20160428
function handleScanUrlList($httpurl,$urlList){
    $splstr='';$url='';$c='';$lCaseUrl='';
    $splstr=aspSplit($urlList,vbCrlf());
    foreach( $splstr as $key=>$url){
        $url=PHPTrim($url);
        $lCaseUrl=lCase($url);
        if( $url<>'' && left($url,10)<>'tencent://' && left($url,11)<>'javascript:' && left($url,1)<>'#' ){
            $url= fullHttpUrl($httpurl,$url);
            if( inStr(vbCrlf() . $c . vbCrlf(),vbCrlf() . $url . vbCrlf())==false ){
                $c=$c . $url . vbCrlf();
            }
        }
    }
    $handleScanUrlList=$c;
    return @$handleScanUrlList;
}

//������ͬ�����б� 20160501
function handleWithWebSiteList($httpurl,$urllist){
    $website='';$splstr='';$url='';$c='';$urlWebsite='';$s='';
    $website=lCase(getWebSite($httpurl));
    $splstr=aspSplit($urllist,vbCrlf());
    foreach( $splstr as $key=>$url){
        if( $url <>'' ){
            if( right($url,1)<>'/' && inStr($url,'?')==false ){
                $s=mid($url,inStrRev($url,'/'),-1);
                //call echo("s",s)
                if( (inStr($s,'.')==false || inStr($s,'.com')>0 || inStr($s,'.cn')>0 || inStr($s,'.net')>0) && inStr($s,'@')==false ){
                    $url= $url . '/';
                }
                //call echo("url",url)
            }
            $urlWebsite=lCase(getWebSite($url));
            if( $website==$urlWebsite && inStr(vbCrlf() . $c . vbCrlf(),vbCrlf() . $url . vbCrlf())==false ){
                if( $c<>'' ){
                    $c=$c . vbCrlf();
                }
                $c=$c . $url;
            }
        }
    }
    $handleWithWebSiteList=$c;
    return @$handleWithWebSiteList;
}
//����ͬ�����б� 20160501
function handleDifferenceWebSiteList($httpurl,$urllist){
    $website='';$splstr='';$url='';$c='';$urlWebsite='';$websiteList='';
    $website=lCase(getWebSite($httpurl));
    $splstr=aspSplit($urllist,vbCrlf());
    foreach( $splstr as $key=>$url){
        $urlWebsite=lCase(getWebSite($url));
        if( $urlWebsite <>'' && $website<>$urlWebsite && inStr(vbCrlf() . $websiteList . vbCrlf(),vbCrlf() . $urlWebsite . vbCrlf())==false ){
            $websiteList=$websiteList . $urlWebsite . vbCrlf();
        }
    }
    $handleDifferenceWebSiteList=$websiteList;
    return @$handleDifferenceWebSiteList;
}

//����������� 20160511   ����checkDomainName('http://www.baidu.com/a/b/sdf')


//���url״̬˵��
function getHttpUrlStateAbout($nState){
    $s='';$c='';
    $s=cStr(aspTrim($nState));
    switch ( $s ){
        case '100' ; $c='����';break;
        case '101' ; $c='����Э��';break;
        case '200' ; $c='�ɹ�';break;
        case '201' ; $c='����';break;
        case '202' ; $c='����';break;
        case '203' ; $c='��Ȩ����Ϣ';break;
        case '204' ; $c='��������';break;
        case '205' ; $c='��������';break;
        case '206' ; $c='��������';break;
        case '300' ; $c='����ѡ��';break;
        case '301' ; $c='�ƶ�����';break;
        case '302' ; $c='��ʱ�ƶ�';break;
        case '303' ; $c='��������';break;
        case '304' ; $c='δ�޸�';break;
        case '305' ; $c='ʹ�ô���';break;
        case '307' ; $c='��ʱ�ض���';
        break;
        case '400' ; $c='����Ҫ��';break;
        case '401' ; $c='δ����Ȩ';break;
        case '402' ; $c='����Ҫ��';break;
        case '403' ; $c='��ֹ';break;
        case '404' ; $c='δ�ҵ�';break;
        case '405' ; $c='������ķ���';break;
        case '406' ; $c='���ɽ���';break;
        case '407' ; $c='������֤����';break;
        case '408' ; $c='����ʱ';break;
        case '409' ; $c='��ͻ';break;
        case '410' ; $c='��ʧ';break;
        case '411' ; $c='���賤��';break;
        case '412' ; $c='�Ⱦ�����';break;
        case '413' ; $c='����ʵ�����';break;
        case '414' ; $c='������URI̫��';break;
        case '415' ; $c='��֧�ֵ�ý������';break;
        case '416' ; $c='������Χ������';break;
        case '417' ; $c='����ʧ��';
        break;
        case '500' ; $c='�ڲ�����������';break;
        case '501' ; $c='δʵʩ';break;
        case '502' ; $c='������';break;
        case '503' ; $c='���񲻿���';break;
        case '504' ; $c='���س�ʱ';break;
        case '505' ; $c='��HTTP�汾��֧��';break;
        case '509' ; $c='�������Ƴ���';
    }
    $getHttpUrlStateAbout=$c;
    return @$getHttpUrlStateAbout;
}

?>