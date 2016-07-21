<?PHP
//URL 网址处理 (2013,9,27)

//  byref PubAHrefList, byref PubATitleList   为为什么要加上byref  是因为在转PHP时需要这个判断，请明它是地址传递 是关联变量

//NOVBNet start
//使用手册
//call echo("'获得当前网址第一种（getUrl）",getUrl())
//call echo("'获得当前网址第二种（getThisUrl）",getThisUrl())
//call echo("'获得当前网址无参数（getThisUrlNoParam）",getThisUrlNoParam())
//call echo("'获得来访网址（getGoToUrl）",getGoToUrl())
//call echo("'获得来访网址无参数（getGoToUrlNoParam）",getGoToUrlNoParam())
//call echo("'获得来访网址无文件名称（getGoToUrlNoFileName）",getGoToUrlNoFileName())
//call echo("'域名（webDoMain）",webDoMain())
//call echo("'主机（host）",host())
//call echo("'获得当前网址加参数（getUrlAddToParam）",getUrlAddToParam(GetUrl(), "PageSize=20", "replace"))


//获得当前网址第一种（getUrl）：http://127.0.0.1/atemp.asp?act=1
//获得当前网址第二种（getThisUrl）：http://127.0.0.1/atemp.asp?act=1
//获得当前网址无参数（getThisUrlNoParam）：http://127.0.0.1/atemp.asp
//获得来访网址（getGoToUrl）：http://127.0.0.1/5.asp?act=5&aa=aa&bb=bb
//获得来访网址无参数（getGoToUrlNoParam）：http://127.0.0.1/5.asp
//获得来访网址无文件名称（getGoToUrlNoFileName）：http://127.0.0.1/
//域名（webDoMain）：http://127.0.0.1
//主机（host）：http://127.0.0.1/
//获得当前网址加参数（GetUrlAddToParam）：http://127.0.0.1/atemp.asp?PageSize=20&act=1
//getThisUrlFileName()    : 4.asp
//getThisUrlFileParam()    : 4.asp?act=11

//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","")        'http://www.baidu.com/?a=1&b=2&c=3
//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","replace")        'http://www.baidu.com/?a=11&b=22&c=333

//获得当前网后的文件名与参数
function getThisUrlFileParam(){
    $url ='';
    $url= getUrl();
    $url= mid($url, inStrRev($url, '/') + 1,-1);
    $getThisUrlFileParam= $url;
    return @$getThisUrlFileParam;
}

//获得当前网址无参数
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

//获得传过来网址
function getGoToUrl(){
    $getGoToUrl= serverVariables('HTTP_REFERER');
    return @$getGoToUrl;
}

//获得传过来网址 无参数
function getGoToUrlNoParam(){
    $url ='';
    $url= getGoToUrl();
    if( inStr($url, '?') > 0 ){
        $url= mid($url, 1, inStr($url, '?') - 1);
    }
    $getGoToUrlNoParam= $url;
    return @$getGoToUrlNoParam;
}

//获得传过来网址 无文件名称
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
//移除网址文件名部分
function remoteUrlFileName( $url){
    if( right($url, 1) <> '/' ){
        if( inStrRev($url, '/') > 0 ){
            $url= mid($url, 1, inStrRev($url, '/'));
        }
    }
    $remoteUrlFileName=$url;
    return @$remoteUrlFileName;
}
//移除网址参数部分
function remoteUrlParam( $url){
    if( right($url, 1) <> '?' ){
        if( inStrRev($url, '?') > 0 ){
            $url= mid($url, 1, inStrRev($url, '?')-1);
        }
    }
    $remoteUrlParam=$url;
    return @$remoteUrlParam;
}
//获得网址目录部分
function getUrlDir( $url){
    $getUrlDir=getHandleUrlValue($url,'网址目录');
    return @$getUrlDir;
}
//获得处理后url值 20160701
function getHandleUrlValue( $url, $sType){
    $sType='|'. $sType .'|';
    if( inStr($url,'://')>0 ){
        $url=mid($url,inStr($url,'://')+3,-1);
    }
    //去掉域名
    if( inStr($url,'/')>0 ){
        $url=mid($url,inStr($url,'/')+1,-1);
    }

    if( inStr($sType,'|网址目录|')>0 ){
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
    if( inStr($sType,'|名称|')>0 || inStr($sType,'|name|')>0 ){
        if( inStr($url,'.')>0 ){
            $url=mid($url,1,inStrRev($url,'.')-1);
        }
    }
    $getHandleUrlValue=$url;
    return @$getHandleUrlValue;
}

//获取客户端IP地址第二种
function getIP2(){

    $x=''; $y=''; $addr ='';
    $x= serverVariables('HTTP_X_FORWARDED_FOR');
    $y= serverVariables('REMOTE_ADDR');
    $addr= IIF(isNul($x) || lCase($x)== 'unknown', $y, $x);
    if( inStr($addr, '.')== 0 ){ $addr= '0.0.0.0' ;}
    $getIP2= $addr;
    return @$getIP2;
}

//获取IP地址 别人写得好像很专业一样 很全
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

//获得服务器IP
function getServicerIP(){
    $getServicerIP= serverVariables('LOCAL_ADDR');
    return @$getServicerIP;
}

//获得服务器IP   辅助
function getRemoteIP(){
    $getRemoteIP= getServicerIP();
    return @$getRemoteIP;
}


//NOVBNet end

//处理网址\转/  '待完善
function handleHttpUrl($httpUrl){
    $headStr=''; $url ='';
    if( isNul($httpUrl) ){ return ''; }//为空则退出
    $httpUrl= replace(aspTrim($httpUrl), '\\', '/');
    $headStr= mid($httpUrl, 1, inStr($httpUrl, ':') + 2);
    $httpUrl= mid($httpUrl, inStr($httpUrl, ':') + 3,-1);
    $httpUrl= replace($httpUrl, 'http://', '【|http|】');
    $httpUrl= replace($httpUrl, 'https://', '【|https|】');
    $httpUrl= replace($httpUrl, 'ftp://', '【|ftp|】');

    while( inStr($httpUrl, '//') > 0){
        $httpUrl= replace($httpUrl, '//', '/');
    }
    $httpUrl= replace($httpUrl, '【|http|】', 'http://');
    $httpUrl= replace($httpUrl, '【|https|】', 'https://');
    $httpUrl= replace($httpUrl, '【|ftp|】', 'ftp://');

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

//处理文件/转\   使用了While判断，再完善
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

//处理网址完善性
function handleUrlComplete($httpUrl){
    $lastStr ='';
    $handleUrlComplete= $httpUrl;
    if( inStr($httpUrl, '?') > 0 ){ return @$handleUrlComplete; }//有?符号则退出
    //网址最后没有/  判断如果为域名 则在最后加上/退出
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

//给网址添加域名
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
//获得主机端口号
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

//获得域名
function webDoMain(){
    $webDoMain= 'http://' . serverVariables('SERVER_NAME') . getPort();
    return @$webDoMain;
}

//获得当前域名
function host(){
    $host= 'http://' . serverVariables('HTTP_HOST') . '/';
    return @$host;
}

//获得当前域名 (辅助)


//获得当前域名 (辅助)


//网得当前网址
function getUrl(){
    $getUrl= getThisUrl();
    //GetUrl = WebDoMain() & Request.ServerVariables("SCRIPT_NAME") & Request.ServerVariables("QUERY_STRING")
    return @$getUrl;
}

//获得当前带参数网址
function getThisUrl(){
    $url ='';
    //vbdel start
    $url=serverVariables('server_name');
    //PHP版上面直接获得端口
    if( inStr($url, ':')== false ){
        $url= $url . getPort();
    }
    $url= $url . serverVariables('script_name');
    if( serverVariables('QUERY_STRING') <> '' ){ $url= $url . '?' . serverVariables('QUERY_STRING') ;}
    //vbdel end
    $getThisUrl= 'http://' . $url;
    return @$getThisUrl;
}
//获得当前无文件名称网址
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

//获得网址域名名称 http://www.aaa.bb.mywebname.com/   mywebname
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

//分析网址 获得域名
function getWebSite( $httpUrl){
    //On Error Resume Next
    //新版获得域名方法
    $url=''; $tempHttpUrl=''; $is_WebSite='';$httpHead='';
    $tempHttpUrl= $httpUrl;
    $url= aspTrim(lCase(replace($httpUrl, '?', '/')));
    $url= replace(replace($url, '\\', '/'), 'http://', '');
    if( inStr($url, '/') > 0 ){ $url= mid($url, 1, inStr($url, '/') - 1) ;}
    $url= 'http://' . $url . '/';
    $splStr=''; $s=''; $c ='';
    $httpUrl= replace(lCase($httpUrl), 'http://', '');
    $httpHead='http://';
    //增加了https://这种安全请求方式  20160526
    if( inStr(lCase($httpUrl), 'https://')>0 ){
        $httpUrl= replace(lCase($httpUrl), 'https://', '');
        $httpHead='https://';
    }
    //删除/后台的值20160526
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
            $httpUrl= ''; //没有则为空
        }
    }
    $is_WebSite= false; //是域名为假
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
    $getWebSite= left($httpUrl, 255); //域名不存在，则只截取255个字符
    //GetWebSite = ""                        '域名不存在则为空 20150104
    if( $getWebSite== 'http:///' ){ $getWebSite= '' ;}//没有找到域名
    if( $is_WebSite== false ){
        $getWebSite= '';
    }

    return @$getWebSite;
}
//检测是否为网址
function checkUrl($url){
    $checkUrl= IIF(getWebSite($url)== '', false, true);
    return @$checkUrl;
}
//检测是否为网址
function checkHttpUrl($url){
    $checkHttpUrl= checkUrl($url);
    return @$checkHttpUrl;
}
//检测是否为网址
function isUrl($url){
    $isUrl= checkUrl($url);
    return @$isUrl;
}
//检测是否为网址
function isHttpUrl($url){
    $isHttpUrl= checkUrl($url);
    return @$isHttpUrl;
}

//完整网址
//对这个处理 style="background: url(20130510162636_96168.jpg) no-repeat scroll center top; height: 426px;cursor:pointer; width: 100%; margin:0 auto;" 20160701
function fullHttpUrl( $httpUrl, $url){
    //On Error Resume Next
    //清除错误 要不然会报错
    $rootUrl=''; $thisUrl=''; $splStr=''; $i=''; $s=''; $c=''; $parentUrl=''; $parentParentUrl=''; $parentParentParentUrl=''; $rootWebSite=''; $thisWebSite=''; $handleYes='';$lCaseUrl='';
    $styleStart='';$styleEnd='';
    $httpUrl= PHPTrim($httpUrl); //清除两边空格
    $url= PHPTrim($url); //清除两边空格
    $lCaseUrl=lCase($url);
    if( $url== '' ){ $fullHttpUrl= '' ; return @$fullHttpUrl; }//网址为空退出(20150805)
    if( aspTrim($httpUrl)== '' ){ $fullHttpUrl= $url ; return @$fullHttpUrl; }//主网址为空退出 返回网址
    $httpUrl= replace($httpUrl, '\\', '/'); //把网址\转/符号
    $url= replace($url, '\\', '/'); //把网址\转/符号

    //网址前两个字符为//则退出
    if( left($url, 2)== '//' ){
        $fullHttpUrl= 'http:' . $url;
        return @$fullHttpUrl;
    }
    //处理style样式里背景图片
    $url=hanldeStyleBackgroundUrl($url,$styleStart,$styleEnd);
    $rootUrl= getWebSite($httpUrl); //主域名，也就是主网址
    $rootWebSite= $rootUrl;
    $thisWebSite= getWebSite($url);
    if( right($rootUrl, 1)== '/' ){ $rootUrl= left($rootUrl, len($rootUrl) - 1); }
    $thisUrl= left($httpUrl, inStrRev($httpUrl, '/')); //当前网址
    $splStr= aspSplit($httpUrl, '/');
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        if( $i + 1== uBound($splStr) ){ $parentUrl= $c ;}
        if( $i + 2== uBound($splStr) ){ $parentParentUrl= $c ;}
        if( $i + 3== uBound($splStr) ){ $parentParentParentUrl= $c ;}
        $s= $splStr[$i];
        $c= $c . $s . '/';
    }
    $url= aspTrim($url); //去除网址左右空格
    $handleYes= false; //操作为假
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
    //操作是否为真
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
//处理样式里背景图片20160701
function hanldeStyleBackgroundUrl( $url,$styleStart,$styleEnd){
    $lCaseUrl='';
    $url= PHPTrim($url); //清除两边空格
    $lCaseUrl=lCase($url);
    $url= replace($url, '\\', '/'); //把网址\转/符号
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

//批量处理网址完整20150728
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


//网址特殊字符 简洁处理
function uRLJianJieHandle( $url){
    $url= replace($url, '&amp;', '&');
    $uRLJianJieHandle= $url;
    return @$uRLJianJieHandle;
}

//URL加密 待完善中。。。。
function urlToAsc($url){
    $i ='';
    for( $i= 1 ; $i<= len($url); $i++){
        $urlToAsc= $urlToAsc . '%' . hex(ascW(mid($url, $i, 1)));
    }
    return @$urlToAsc;
}


//获得网站标题
function getWebTitle($content){
    $getWebTitle= getStrCut($content, '<title>', '</title>', 0);
    return @$getWebTitle;
}

//获得容中网址列表 (缺陷是网址全部小写了20150728)
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

//获得内容中图片列表
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

//让内容中网址完整 sType=|*|link|img|a|script|embed|param|meta|
function handleConentUrl($httpUrl, $content, $sType, &$PubAHrefList, &$PubATitleList){
    $i=''; $s=''; $YuanStr=''; $TempS=''; $LalType=''; $nLen=''; $LalStr=''; $c ='';
    $sType= '|' . $sType . '|';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( $s== '<' ){
            $YuanStr= mid($content, $i,-1);
            $TempS= lCase($YuanStr);
            $TempS= replace(replace($TempS, chr(10), ' ' . vbCrlf()), chr(13), ' ' . vbCrlf()); //让处理图片素材更完整  比如  <img换行src=""  也可以获得 20150714
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
                //没有javascript就运行，但是还是有不足之处
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
                //替换关键词
                if( inStr(lCase($LalStr), 'keywords') > 0 ){
                    $c= $c . handleLink($httpUrl, $LalStr, 'content', $GLOBALS['WebKeywords'], '', $PubAHrefList, $PubATitleList);
                    //替换网站描述
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


//替换内容里全部Js目录 20150722  call rwend(handleConentUrl("/admin/js/", "<script src='aa/js.js' ><script src=""bb/js.js"" >","",""))
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


//处理链接地址 HttpUrl=追加网址，Content=内容  SType=类型
//替换目录方法  call rw(HandleLink("Js/", "111111<script src=""js/Jquery.Min.js""></"& "script>","src", "newurl", "replaceDir","",""))
function handleLink($httpUrl, $content, $sType, $SetStr, $UrlOrContent, &$PubAHrefList, &$PubATitleList){

    $splStr=''; $i=''; $s=''; $c=''; $TempContent=''; $FindUrl=''; $HandleUrl=''; $startStr=''; $endStr=''; $s1=''; $s2=''; $tempHttpUrl ='';
    $tempHttpUrl= $httpUrl;
    $UrlOrContent= lCase($UrlOrContent);
    $content= replace(replace($content, '= ', '='), '= ', '=');
    $content= replace(replace($content, ' =', '='), ' =', '=');
    $TempContent= lCase($content);
    //没有链接退出
    if( inStr($TempContent, ' href=')== 0 && inStr($TempContent, ' src=')== 0 && $sType<>'style' ){
        $handleLink= '';
        return @$handleLink;
    }else if( inStr($TempContent, ' href=\\"') > 0 ){
        $content= replace($content, '\\"', '"') ; $TempContent= lCase($content);
    }
    $startStr= $sType . '="';
    $endStr= '"';
    if( inStr($TempContent, $startStr) > 0 && inStr($TempContent, $endStr) > 0 ){
        //call echo("提示","1")
        $FindUrl= StrCut($content, $startStr, $endStr, 2);
        if( $SetStr <> '' ){
            $HandleUrl= $SetStr;
        }else{
            $HandleUrl= fullHttpUrl($httpUrl, $FindUrl);
            //替换目录
            if( $UrlOrContent== 'replacedir' ){
                $HandleUrl= $tempHttpUrl . handleFilePathArray($HandleUrl)[2];
            }
            $PubAHrefList= $PubAHrefList . hanldeStyleBackgroundUrl($HandleUrl,'','') . vbCrlf();
            //链接标题
            $s1= inStr($content, '>');
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, 1, inStrRev($s2, '</') - 1);
            $s2= replace($s2, vbCrlf(), '【换行】');
            $PubATitleList= $PubATitleList . $s2 . vbCrlf();
        }
        if( $FindUrl <> $HandleUrl ){
            //强强强旱替换
            $s1= inStr($content, $startStr) - 1 + len($startStr); //这里面用TempContent而不用Content因为有大小写在里面20140726
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
        //call echo("提示","2")
        $FindUrl= StrCut($TempContent, $startStr, $endStr, 2);
        if( $SetStr <> '' ){
            $HandleUrl= $SetStr;
        }else{
            $HandleUrl= fullHttpUrl($httpUrl, $FindUrl);
            //替换目录
            if( $UrlOrContent== 'replacedir' ){
                $HandleUrl= $tempHttpUrl . handleFilePathArray($HandleUrl)[2];
            }
            $PubAHrefList= $PubAHrefList . hanldeStyleBackgroundUrl($HandleUrl,'','') . vbCrlf();
            //链接标题
            $s1= inStr($content, '>');
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, 1, inStrRev($s2, '</') - 1);
            $s2= replace($s2, vbCrlf(), '【换行】');
            $PubATitleList= $PubATitleList . $s2 . vbCrlf();
        }
        if( $FindUrl <> $HandleUrl ){
            //强强强旱替换
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
    $endStr= '>'; //这里面把之家的 空格换成>
    if( inStr($TempContent, $startStr) > 0 && inStr($TempContent, $endStr) > 0 ){
        $FindUrl= StrCut($TempContent, $startStr, $endStr, 2);

        if( $SetStr <> '' ){
            $HandleUrl= $SetStr;
        }else{
            $HandleUrl= fullHttpUrl($httpUrl, $FindUrl);
            //替换目录
            if( $UrlOrContent== 'replacedir' ){
                $HandleUrl= $tempHttpUrl . handleFilePathArray($HandleUrl)[2];
            }
            $PubAHrefList= $PubAHrefList . hanldeStyleBackgroundUrl(handleHttpUrl($HandleUrl),'','') . vbCrlf();
            //链接标题
            $s1= inStr($content, '>');
            $s2= right($content, len($content) - $s1);
            $s2= mid($s2, 1, inStrRev($s2, '</') - 1);
            $s2= replace($s2, vbCrlf(), '【换行】');
            $PubATitleList= $PubATitleList . $s2 . vbCrlf();
        }
        if( $FindUrl <> $HandleUrl ){
            //强强强旱替换
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
    CreateAddFile('出错内容列表.txt', $httpUrl . vbCrlf() . $content . vbCrlf() . $sType . vbCrlf() . $SetStr . vbCrlf() . $UrlOrContent . vbCrlf() . '----------------------' . vbCrlf());
    return @$handleLink;
}


//获得网站目录文件夹名称 \Templates\WeiZhanLue\  得到WeiZhanLue
function getEndUrlHandleName($FileUrl){
    $url ='';
    $url= replace(aspTrim($FileUrl), '\\', '/');
    if( right($url, 1)== '/' ){ $url= mid($url, 1, len($url) - 1) ;}
    $url= mid($url, inStrRev($url, '/') + 1,-1);
    $getEndUrlHandleName= $url;
    return @$getEndUrlHandleName;
}


//获得列表中不同域名列表
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

//获得当前网址的文件名称
function getThisUrlFileName(){
    $url ='';
    $url= serverVariables('SCRIPT_NAME');
    if( left($url, 1)== '/' ){ $url= right($url, len($url) - 1); }
    $getThisUrlFileName= $url;
    return @$getThisUrlFileName;
}

//处理网站HTML中Img    写得不是特别的完善好  Content = HandleWebHtmlImg("/aa/bb/",Content)
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

//处理网站Css中Img    写得不是特别的完善好  Content = HandleWebHtmlImg("/aa/bb/",Content)
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

//批量处理网址完整性
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

//处理内容中链接图片路径 目录是显示图片
function replaceContentImagePath($RootFolder, $content){
    $ImageFile=''; $ToImageFile=''; $ImageList=''; $splxx ='';
    $RootFolder= handleHttpUrl($RootFolder);
    if( right($RootFolder, 1) <> '/' ){ $RootFolder= $RootFolder . '/' ;}
    $ImageList= getDirFileNameList($RootFolder,'');
    $splxx= aspSplit($ImageList, vbCrlf());
    foreach( $splxx as $key=>$ImageFile){
        if( $ImageFile <> '' ){
            $ToImageFile= 'file:///' . $RootFolder . $ImageFile;
            //html中图片路径替换
            $content= replace($content, '"' . $ImageFile . '"', '"' . $ToImageFile . '"');
            $content= replace($content, '\'' . $ImageFile . '\'', '"' . $ToImageFile . '"');
            $content= replace($content, '=' . $ImageFile . ' ', '"' . $ToImageFile . '"');
            $content= replace($content, '=' . $ImageFile . '>', '"' . $ToImageFile . '"');
            //Css中图片路径替换
            $content= replace($content, '(' . $ImageFile . ')', '(' . $ToImageFile . ')');
            $content= replace($content, '(' . $ImageFile . ';', '(' . $ToImageFile . ';');
        }
    }
    $replaceContentImagePath= $content;
    return @$replaceContentImagePath;
}

//获得Css链接列表 是名称
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

//获得Html中图片地址列表
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

//获得图片地址列表
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

//获得img或a地址 如GetLinkUrl(LalStr, "src")
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

//是本地网址或远程网址        20141120
function localUrlOrRemoteUrl($filePath, $UrlYes){
    $httpUrl ='';
    $UrlYes= false;
    $filePath= aspTrim($filePath);
    $httpUrl= replace($filePath, '\\', '/');
    if( left(lCase($httpUrl), 7)== 'http://' || left(lCase($httpUrl), 4)== 'www.' || left(lCase($httpUrl), 4)== '[网址]' ){
        $UrlYes= true;
    }
    if( $UrlYes== false ){
        $filePath= setFileName($filePath);
    }
    $localUrlOrRemoteUrl= $filePath;
    return @$localUrlOrRemoteUrl;
}

//检测是否为远程网址
function checkRemoteUrl($url){
    $httpUrl ='';
    $url= aspTrim($url);
    $httpUrl= replace(unSetFileName($url), '\\', '/');
    $checkRemoteUrl= false;
    if( left(lCase($httpUrl), 7)== 'http://' || left(lCase($httpUrl), 4)== 'www.' || left(lCase($httpUrl), 4)== '[网址]' ){
        if( left(lCase($httpUrl), 4)== '[网址]' ){
            $url= mid($url, inStr($url, '[网址]') + 1,-1);
        }
        $checkRemoteUrl= true;
    }
    return @$checkRemoteUrl;
}



//函数名称：AsaiLinkAdd   20141217引用别人
//函数作用：正则自动添加链接
//例：Response.Write AsaiLinkAdd("http://www.wzl99.com/小孙、小孙http://www.wzl99.com/小孙、小孙http://www.wzl99.com//小孙、小孙http://www.wzl99.com/小孙、小孙http://www.wzl99.com/小孙、小孙www.wzl99.com/小孙、小孙fengying789@126.com小孙、小孙")
function asaiLinkAdd($str){ //留空函数
}

//函数名称：AsaiLinkDel Asai(浅井)   20141217引用别人
//函数作用：正则自动去除链接
//例：Response.Write AsaiLinkDel("<a href='http://www.wzl99.com/' target='_blank'>http://www.wzl99.com/</a>小孙、小孙<a href='http://www.wzl99.com/' target='_blank'>http://www.wzl99.com/</a>小孙、")
function asaiLinkDel($htmlStr){ //留空函数
}

//判断域名是否合法  暂存
function iswww($strng){ //留空函数
}


//加强于20150220
//追加网址参数20150121  getUrlAddToParam("aa","&a=b","replace")   addto replace    SType为追加还是替换
//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","")        'http://www.baidu.com/?a=1&b=2&c=3
//Url = getUrlAddToParam("http://www.baidu.com/?a=1&b=2&c=3","?a=11&b=22&c=333","replace")        'http://www.baidu.com/?a=11&b=22&c=333
//Url = getUrlAddToParam(GetUrl(),"id=" & Rs("Id"),"replace")
//Call Echo(Url,getUrlAddToParam(Url,"id=1&aa=1&bb=2","delete"))          批量删除参数
function getUrlAddToParam( $url, $AddToUrl, $sType){
    $content=''; $splStr=''; $splxx=''; $s=''; $c=''; $httpUrl=''; $urlFileName=''; $webSite ='';
    $urlParam ='';//网址参数 是获得网址后台参数值
    $paramName ='';//参数名称
    $paramValue ='';//参数值
    $paramNameList ='';//参数名称列表，防止重复
    $handleYes ='';//处理为真

    $AddToUrl= handleHttpUrl($AddToUrl);

    //处理网址
    $url= aspTrim($url);
    //当前网址最后一个字符为?或&给删除掉 无用
    if( right($url, 1)== '?' || right($url, 1)== '&' ){
        $url= aspTrim(mid($url, 1, len($url) - 1));
    }
    //处理追加网址
    $AddToUrl= aspTrim($AddToUrl);
    //追加网址最后一个字符为?或&给删除掉 无用
    if( left($AddToUrl, 1)== '?' || left($AddToUrl, 1)== '&' ){
        $AddToUrl= aspTrim(mid($AddToUrl, 2,-1));
    }
    //网址为空则返回追加网址 并退出
    if( $url== '' ){ $getUrlAddToParam= '?' . $AddToUrl ; return @$getUrlAddToParam; }

    $httpUrl= $url;
    if( inStr($url, '?') > 0 ){
        $httpUrl= mid($url, 1, inStr($url, '?') - 1); //获得当前路径网址
        $webSite= getWebSite($url); //处理域名
        $urlParam= mid($url, inStr($url, '?') + 1,-1);

        $httpUrl= handleHttpUrl($httpUrl);
        if( right($httpUrl, 1) <> '/' ){
            $urlFileName= mid($httpUrl, inStrRev($httpUrl, '/') + 1,-1);
            $httpUrl= left($httpUrl, len($httpUrl) - len($urlFileName));
            //Call Echo(HttpUrl,UrlFileName)
        }
    }

    //类型选择  追加 不是替换
    if( lCase($sType)== 'replace' || $sType== '替换' ){
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

    //处理删除参数 20150210
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




//组合网址 20150706 call echo("",groupUrl("www.baidu.com//","/1.asp"))
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



//处理POST或Cookes发送方式的参数处理
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


//移除网址中参数20150724
function remoteHttpUrlParameter($httpUrl){
    $splStr=''; $s=''; $c=''; $leftC=''; $rightC ='';
    //没有?号退出
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


//检测当前网址里文件名称是否存在(20150909)
//用法 call echo("checkUrlName",checkUrlName("1|2|3|"))      <%=IIF(checkUrlName("1|2|3|"),"111","222")% >
function checkUrlName($searchUrlName){
    $splStr=''; $urlName=''; $url ='';
    $searchUrlName= lCase($searchUrlName); //搜索网址名称转小写
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



//注意   这里面有问题的

//0 url：http://127.0.0.1/aa/4.asp?act=sdf&v=sdf
//1 urlDir：http://127.0.0.1/
//2 fileName：4.asp
//3 FileType：asp
//4 fileStr：4.asp?act=sdf&v=sdf
//5 HttpAgreement：http
//6 webSite：http://127.0.0.1/
//7 folderDir：aa/

//网址处理成数组20150124  数组  0原文件路径 1为文件路径   2为文件名称  3为去除文件类型文件名称   4为文件类型后缀名
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
    //域名为空则发粗获得文件夹目录20160613
    if( $webSite<>'' ){
        $folderDir= mid($urlDir, len($webSite),-1);
    }else{
        echoYellowB('注意：不是有效网址',$url);
    }
    //HandleHttpUrlArray = Array(url, urlDir, fileName, fileType, fileStr, HttpAgreement, webSite, folderDir)
    $arrayData ='';
    $arrayData= aspSplit($url . vbCrlf() . $urlDir . vbCrlf() . $fileName . vbCrlf() . $FileType . vbCrlf() . $fileStr . vbCrlf() . $httpAgreement . vbCrlf() . $webSite . vbCrlf() . $folderDir, vbCrlf());
    $handleHttpUrlArray= $arrayData;
    return @$handleHttpUrlArray;
}


//移除jsCss后的参数Param (20151019)
function remoteJsCssParam($content, $PubAHrefList){
    $remoteJsCssParam= handleRemoteJsCssParam($content, $PubAHrefList, '|替换内容|替换网址');
    return @$remoteJsCssParam;
}

//处理移除jsCss后的参数Param (20151019)
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
                //这种替换方法还是不精准，待改进
                if( inStr($sType, '|替换内容|') > 0 ){
                    $content= replace($content, $url, $replaceStr);
                }
                if( inStr($sType, '|替换网址|') > 0 ){
                    $urlList= replace($urlList, $url, $replaceStr);
                }
            }
        }
    }
}


//批量处理网址完整(20151022)
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


//检测同域名(20151023)
function isWebSite( $url1, $url2){
    $isWebSite= handleIsWebSite($url1, $url2, '');
    return @$isWebSite;
}
//检测同子域名(20151023)
function isSonWebSite( $url1, $url2){
    $isSonWebSite= handleIsWebSite($url1, $url2, '子域名');
    return @$isSonWebSite;
}

//处理两网址是否域名同等(20151023)
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

    if( $sType== '子域名' ){
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


//获得内容里网址列表(20161025)
function getContentUrlList($httpUrl, $content){
    $getContentUrlList= handleGetContentUrlList($httpUrl, $content, '|*|内链|');
    return @$getContentUrlList;
}
//处理获得内容里网址列表(20161025)
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
                        if( inStr($sType, '|内链|') > 0 ){
                            if( $isHandle== true ){
                                $urlList= $urlList . $url . vbCrlf();
                            }
                        }else if( inStr($sType, '|外链|') > 0 ){
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
//获得网址中内链与外链列表
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


//处理扫描后网址列表 20160428
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

//处理相同域名列表 20160501
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
//处理不同域名列表 20160501
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

//检测域名存在 20160511   例：checkDomainName('http://www.baidu.com/a/b/sdf')


//获得url状态说明
function getHttpUrlStateAbout($nState){
    $s='';$c='';
    $s=cStr(aspTrim($nState));
    switch ( $s ){
        case '100' ; $c='继续';break;
        case '101' ; $c='开关协议';break;
        case '200' ; $c='成功';break;
        case '201' ; $c='创建';break;
        case '202' ; $c='接受';break;
        case '203' ; $c='非权威信息';break;
        case '204' ; $c='不含内容';break;
        case '205' ; $c='重置内容';break;
        case '206' ; $c='部分内容';break;
        case '300' ; $c='多项选择';break;
        case '301' ; $c='移动永久';break;
        case '302' ; $c='暂时移动';break;
        case '303' ; $c='看其他的';break;
        case '304' ; $c='未修改';break;
        case '305' ; $c='使用代理';break;
        case '307' ; $c='临时重定向';
        break;
        case '400' ; $c='坏的要求';break;
        case '401' ; $c='未经授权';break;
        case '402' ; $c='付款要求';break;
        case '403' ; $c='禁止';break;
        case '404' ; $c='未找到';break;
        case '405' ; $c='不允许的方法';break;
        case '406' ; $c='不可接受';break;
        case '407' ; $c='代理验证所需';break;
        case '408' ; $c='请求超时';break;
        case '409' ; $c='冲突';break;
        case '410' ; $c='消失';break;
        case '411' ; $c='所需长度';break;
        case '412' ; $c='先决条件';break;
        case '413' ; $c='请求实体过大';break;
        case '414' ; $c='的请求URI太长';break;
        case '415' ; $c='不支持的媒体类型';break;
        case '416' ; $c='的请求范围不满足';break;
        case '417' ; $c='期望失败';
        break;
        case '500' ; $c='内部服务器错误';break;
        case '501' ; $c='未实施';break;
        case '502' ; $c='坏网关';break;
        case '503' ; $c='服务不可用';break;
        case '504' ; $c='网关超时';break;
        case '505' ; $c='的HTTP版本不支持';break;
        case '509' ; $c='带宽限制超过';
    }
    $getHttpUrlStateAbout=$c;
    return @$getHttpUrlStateAbout;
}

?>