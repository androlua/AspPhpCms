<?PHP


//处理替换列表 (ReplaceList改成handleReplaceList)为了兼容php程序
function handleReplaceList( $content, $yStr, $tStr){
    $YSplStr=''; $TSplStr=''; $i=''; $s ='';
    $YSplStr= aspSplit($yStr, '|');
    $TSplStr= aspSplit($tStr . '||||||||||||||||||||||||||||||||', '|');
    for( $i= 0 ; $i<= uBound($YSplStr); $i++){
        $s= $YSplStr[$i];
        if( $s <> '' ){
            $content= replace($content, $s, $TSplStr[$i]);
        }
    }
    $handleReplaceList= $content;
    return @$handleReplaceList;
}

//从右边开始截取 作用：删除左边空格
function leftSpace( $content, $AddNumb){
    $i=''; $nCount ='';
    $nCount= 0;
    for( $i= len($content) ; $i>= 1 ; $i--){
        if( mid($content, $i, 1) <> ' ' ){ break; }
        $nCount= $nCount + 1;
    }
    if( $nCount > $AddNumb && replace($content, ' ', '') <> '' ){
        $content= left($content, len($content) - $nCount + $AddNumb);
    }else if( $nCount < $AddNumb && 1== 1 ){
        for( $i= $nCount ; $i<= $AddNumb - 1; $i++){
            $content= $content . ' ';
        }
    }
    $leftSpace= $content;
    return @$leftSpace;
}
//从右边开始截取 作用：删除右边空格
function rightSpace( $content, $AddNumb){
    $i=''; $nCount ='';
    $nCount= 0;
    for( $i= 1 ; $i<= len($content); $i++){
        if( mid($content, $i, 1) <> ' ' ){ break; }
        $nCount= $nCount + 1;
    }
    if( $nCount > $AddNumb ){
        $content= right($content, len($content) - $nCount + $AddNumb);
    }else if( $nCount < $AddNumb ){
        for( $i= $nCount ; $i<= $AddNumb - 1; $i++){
            $content= ' ' . $content;
        }
    }
    $rightSpace= $content;
    return @$rightSpace;
}

//=============== 下面为2013,11,1添加
//获得QQ
function getQQ( $content, $nOK){
    $splStr=''; $i=''; $j=''; $s=''; $c=''; $qQ=''; $nErr=''; $QQYes ='';
    $content= replace(replace(lCase($content), '&nbsp;', ''), ' ', '');
    $nOK= 0;
    if( inStr($content, 'qq') > 0 ){
        $splStr= aspSplit($content, 'qq');
        for( $i= 1 ; $i<= uBound($splStr); $i++){
            $s= $splStr[$i];
            $qQ= '' ; $nErr= 14 ; $QQYes= false;
            for( $j= 1 ; $j<= len($s); $j++){
                if( inStr('0123456789', mid($s, $j, 1))== false ){
                    if( $QQYes== true ){ break; }//qq开始累加时则退出
                    if( $nErr== 0 ){ break; }//错误大于N退出
                    $nErr= $nErr - 1;
                    if( mid($s, $j, 1)== '群' ){ break; }//为QQ群退出
                }else{
                    $QQYes= true;
                    $qQ= $qQ . mid($s, $j, 1);
                }
                if( $j > 30 ){ break; }//j大于20退出
            }
            if( len($qQ) >= 6 && len($qQ) <= 10 && inStr(vbCrlf() . $c, vbCrlf() . $qQ . vbCrlf())== false ){
                if( inStr(vbCrlf() . $c, vbCrlf() . $qQ . vbCrlf())== false ){
                    $c= $c . $qQ . vbCrlf();
                    $nOK= $nOK + 1;
                }
            }
        }
    }
    $getQQ= $c;
    return @$getQQ;
}
//获得手机
function getTel( $content, $nOK){
    $splStr=''; $i=''; $j=''; $s=''; $c=''; $tel=''; $nErr=''; $TelYes ='';
    $content= replace(replace(lCase($content), '&nbsp;', ''), '手机', 'tel');
    $nOK= 0;
    if( inStr($content, 'tel') > 0 ){
        $splStr= aspSplit($content, 'tel');
        for( $i= 1 ; $i<= uBound($splStr); $i++){
            $s= $splStr[$i];
            $tel= '' ; $nErr= 14 ; $TelYes= false;
            for( $j= 1 ; $j<= len($s); $j++){
                if( inStr('0123456789', mid($s, $j, 1))== false ){
                    if( $TelYes== true ){ break; }//Tel开始累加时则退出
                    if( $nErr== 0 ){ break; }//错误大于N退出
                    $nErr= $nErr - 1;
                }else{
                    $TelYes= true;
                    $tel= $tel . mid($s, $j, 1);
                }
                if( $j > 30 ){ break; }//j大于20退出
            }
            if( len($tel)== 11 ){
                if( inStr(vbCrlf() . $c, vbCrlf() . $tel . vbCrlf())== false ){
                    $c= $c . $tel . vbCrlf();
                    $nOK= $nOK + 1;
                }
            }
        }
    }
    $getTel= $c;
    return @$getTel;
}
//获得邮箱
function getMail( $content, $nOK){
    $splStr=''; $i=''; $j=''; $s=''; $c=''; $mail=''; $nErr=''; $MailYes ='';
    $content= replace(replace(lCase($content), '&nbsp;', ''), '邮箱', 'mail');
    $nOK= 0;
    if( inStr($content, 'mail') > 0 ){
        $splStr= aspSplit($content, 'mail');
        for( $i= 1 ; $i<= uBound($splStr); $i++){
            $s= $splStr[$i];
            $mail= '' ; $nErr= 14 ; $MailYes= false;
            for( $j= 1 ; $j<= len($s); $j++){
                if( inStr('0123456789abcdefghijklmnopqrstuvwxyz.@', mid($s, $j, 1))== false ){
                    if( $MailYes== true ){ break; }//Mail开始累加时则退出
                    if( $nErr== 0 ){ break; }//错误大于N退出
                    $nErr= $nErr - 1;
                }else{
                    $MailYes= true;
                    $mail= $mail . mid($s, $j, 1);
                }
                if( $j > 30 ){ break; }//j大于20退出
            }
            if( inStr($mail, '.') > 0 && inStr($mail, '@') > 0 ){
                if( inStr(vbCrlf() . $c, vbCrlf() . $mail . vbCrlf())== false ){
                    $c= $c . $mail . vbCrlf();
                    $nOK= $nOK + 1;
                }
            }
        }
    }
    $getMail= $c;
    return @$getMail;
}
//获得图片列表
function getImgStr($httpurl, $content, $nOK){
    $splStr=''; $i=''; $c=''; $url=''; $UrlList ='';
    $content= getIMG($content);
    $splStr= aspSplit($content, vbCrlf());
    $nOK= 0;
    foreach( $splStr as $key=>$url){
        if( inStr('|' . $UrlList . '|', '|' . $url . '|')== false ){
            if( left($url, 1)== '/' ||(inStr($url, 'http://')== false && inStr($url, 'www.')== false) ){
                $url= fullHttpUrl($httpurl, $url);
            }
            $nOK= $nOK + 1;
            $c= $c . $url . '<br>';
        }
    }
    $getImgStr= $c;
    return @$getImgStr;
}
//获得Css列表
function getCssStr($httpurl, $content, $nOK){
    $splStr=''; $i=''; $c=''; $url=''; $UrlList ='';
    $content= getCssHref($content);
    $splStr= aspSplit($content, vbCrlf());
    $nOK= 0;
    foreach( $splStr as $key=>$url){
        if( inStr('|' . $UrlList . '|', '|' . $url . '|')== false ){
            if( left($url, 1)== '/' ||(inStr($url, 'http://')== false && inStr($url, 'www.')== false) ){
                $url= fullHttpUrl($httpurl, $url);
            }
            $nOK= $nOK + 1;
            $c= $c . $url . '<br>';
        }
    }
    $getCssStr= $c;
    return @$getCssStr;
}
//获得Js列表
function getJsStr($httpurl, $content, $nOK){
    $splStr=''; $i=''; $c=''; $url=''; $UrlList ='';
    $content= getJsSrc($content);
    $splStr= aspSplit($content, vbCrlf());
    $nOK= 0;
    foreach( $splStr as $key=>$url){
        if( inStr('|' . $UrlList . '|', '|' . $url . '|')== false ){
            if( left($url, 1)== '/' ||(inStr($url, 'http://')== false && inStr($url, 'www.')== false) ){
                $url= fullHttpUrl($httpurl, $url);
            }
            $nOK= $nOK + 1;
            $c= $c . $url . '<br>';
        }
    }
    $getJsStr= $c;
    return @$getJsStr;
}


//获得网址列表 Rw(GetUrlStr("", "链接", Content, "", 0))
function getUrlStr($httpurl, $sType, $content, $SearchValue, $nOK){
    $HrefList=''; $splStr=''; $title=''; $url=''; $c=''; $s=''; $LcaseUrl=''; $UrlList=''; $TitleList=''; $SVal=''; $SVal2 ='';
    if( $sType== '链接' ){
        $HrefList= getAURL($content);
    }else if( $sType== '链接标题' ){
        $HrefList= getATitle($content);
    }else{
        $HrefList= getAURLTitle($content);
    }
    $splStr= aspSplit($HrefList, vbCrlf());
    $nOK= 0;
    foreach( $splStr as $key=>$s){
        if( $s <> '' ){
            if( $sType== '链接' ){
                $url= aspTrim($s);
                if( inStr(lCase($url), 'javascript:')== false && $url <> '#' && $url <> '' ){
                    if( inStr('|' . $UrlList . '|', '|' . $url . '|')== false ){
                        if( left($url, 1)== '/' ||(inStr($url, 'http://')== false && inStr($url, 'www.')== false) ){
                            $url= fullHttpUrl($httpurl, $url);
                        }
                        $nOK= $nOK + 1;
                        $c= $c . $url . vbCrlf();
                    }
                }
            }else if( $sType== '链接标题' ){
                if( inStr('|' . $TitleList . '|', '|' . $s . '|')== false ){
                    $TitleList= $TitleList . $s . '|';
                    $nOK= $nOK + 1;
                    $c= $c . $s . vbCrlf();
                }
            }else{
                if( inStr($s, '【_|-】') > 0 ){
                    $url= mid($s, 1, inStr($s, '【_|-】') - 1) ; $LcaseUrl= $url;
                    $title= mid($s, len($url) + 6,-1);
                    if( inStr(lCase($LcaseUrl), 'javascript:')== false && $url <> '#' && $url <> '' ){
                        if( inStr('|' . $UrlList . '|', '|' . $url . '|')== false ){
                            if( left($url, 1)== '/' ||(inStr($LcaseUrl, 'http://')== false && inStr($LcaseUrl, 'www.')== false) ){
                                $url= fullHttpUrl($httpurl, $url);
                            }
                            $nOK= $nOK + 1;
                            $c= $c . $url . '   &nbsp;  ' . $title . vbCrlf();
                        }
                    }
                }
            }
        }
    }
    if( $SearchValue <> '' ){
        $SearchValue= replace($SearchValue, ' and ', ' And ');
        $splStr= aspSplit($SearchValue, ' And ');
        $SVal= $splStr[0];
        if( uBound($splStr) > 0 ){ $SVal2= $splStr[1] ;}
        $splStr= aspSplit($c, vbCrlf()) ; $nOK= 0 ; $c= '';
        foreach( $splStr as $key=>$s){
            if( $SVal2 <> '' ){
                if( inStr($s, $SVal) > 0 && inStr($s, $SVal2) > 0 ){
                    if( inStr(vbCrlf() . $c . vbCrlf(), vbCrlf() . $s . vbCrlf())== false ){
                        $nOK= $nOK + 1;
                        $c= $c . $s . '<br>';
                    }
                }
            }else{
                if( inStr($s, $SVal) > 0 ){
                    if( inStr(vbCrlf() . $c . vbCrlf(), vbCrlf() . $s . vbCrlf())== false ){
                        $nOK= $nOK + 1;
                        $c= $c . $s . '<br>';
                    }
                }
            }
        }
    }
    $getUrlStr= $c;
    return @$getUrlStr;
}
//获得Html中翻页配置 (采集用到)
function getPageConfig($httpurl, $content, $sType){
    $splStr=''; $i=''; $s=''; $s2=''; $s3=''; $c=''; $url=''; $TempUrl=''; $ArrUrl=aspArray(99); $UrlList=''; $pageUrl=''; $nLen=''; $splxx ='';
    $content= getAURL($content);
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$url){
        if( $url <> '' ){
            $TempUrl= $url;
            if( inStr(lCase($url), 'javascript:')== false && $url <> '#' ){
                $url= replace(replace(replace(replace(replace($url, '0', ''), '1', ''), '2', ''), '3', ''), '4', '');
                $url= replace(replace(replace(replace(replace($url, '5', ''), '6', ''), '7', ''), '8', ''), '9', '');
                if( $sType== '注入' && inStr($url, '?') > 0 ){ $url= handlSqlInUrl($url) ;}
                $c= $c . $url . vbCrlf();
                $nLen= inStr(vbCrlf() . $UrlList, vbCrlf() . $url . '【】');
                if( $nLen > 0 ){
                    $s= mid($UrlList, $nLen,-1);
                    $s= mid($s, 1, inStr($s, vbCrlf()) - 1);
                    $splxx= aspSplit($s, '【】');
                    $s2= $splxx[0];
                    $s3= $splxx[1] + 1;
                    $UrlList= replace($UrlList, $s, $s2 . '【】' . $s3 . '【】' . $splxx[2]);
                    $pageUrl= $url;
                }else{
                    $UrlList= $UrlList . $url . '【】0【】' . fullHttpUrl($httpurl, $TempUrl) . vbCrlf();
                }
            }
        }
    }
    $splStr= aspSplit($UrlList, vbCrlf()) ; $c= '';
    if( $sType== '注入' ){
        foreach( $splStr as $key=>$s){
            if( inStr($s, '【】') > 0 ){
                $splxx= aspSplit($s, '【】');
                $url= aspTrim($splxx[2]);
                if( inStr($url, $httpurl) > 0 ){
                    if( inStr(vbCrlf() . $c, vbCrlf() . $url . vbCrlf())== false ){
                        $c= $c . $url . vbCrlf();
                    }
                }
            }
        }
        $getPageConfig= $c ; return @$getPageConfig;
    }
    //处理出页配置
    foreach( $splStr as $key=>$s){
        if( inStr($s, '【】') > 0 ){
            $splxx= aspSplit($s, '【】');
            if( $splxx[1] > 0 ){ $ArrUrl[$splxx[1]]= $splxx[0] . '  &nbsp; | &nbsp; ' . $splxx[2] ;}
        }
    }
    for( $i= 99 ; $i>= 0 ; $i--){
        if( $ArrUrl[$i] <> '' ){
            if( inStr($ArrUrl[$i], $httpurl) > 0 ){
                $c= $c . $ArrUrl[$i] . '，   出现[' . $i . ']次<br>';
            }
        }
    }
    $getPageConfig= $c;
    return @$getPageConfig;
}
//获得网页中注入网址
function getSqlInUrl($httpurl, $content, $sType){
    $splStr=''; $i=''; $s=''; $s2=''; $s3=''; $c=''; $url=''; $TempUrl=''; $ArrUrl=aspArray(99); $UrlList=''; $pageUrl=''; $nLen=''; $splxx ='';
    $content= getAURL($content);
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$url){
        if( $url <> '' ){
            $TempUrl= $url;
            if( inStr($url, '?') > 0 ){
                $c= $c . $url . vbCrlf();
                $url= handlSqlInUrl($url);
                $nLen= inStr(vbCrlf() . $UrlList, vbCrlf() . $url . '【】');
                if( $nLen > 0 ){
                    $s= mid($UrlList, $nLen,-1);
                    $s= mid($s, 1, inStr($s, vbCrlf()) - 1);
                    $splxx= aspSplit($s, '【】');
                    $s2= $splxx[0];
                    $s3= $splxx[1] + 1;
                    $UrlList= replace($UrlList, $s, $s2 . '【】' . $s3 . '【】' . $splxx[2]);
                    $pageUrl= $url;
                }else{
                    $UrlList= $UrlList . $url . '【】0【】' . fullHttpUrl($httpurl, $TempUrl) . vbCrlf();
                }
            }
        }
    }
    $splStr= aspSplit($UrlList, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( inStr($s, '【】') > 0 ){
            $splxx= aspSplit($s, '【】');
            if( $s3 > 0 ){
                if( $sType== '注入' ){
                    $ArrUrl[$splxx[1]]= $splxx[2];
                }else{
                    $ArrUrl[$splxx[1]]= $splxx[0] . '  &nbsp; | &nbsp; ' . $splxx[2];
                }
            }
        }
    }
    $c= '';
    for( $i= 99 ; $i>= 0 ; $i--){
        if( $ArrUrl[$i] <> '' ){
            if( $sType== '注入' ){
                $c= $c . $ArrUrl[$i] . vbCrlf();
            }else{
                $c= $c . $ArrUrl[$i] . '，   出现[' . $i . ']次<br>';
            }
        }
    }
    $getSqlInUrl= $c;
    return @$getSqlInUrl;
}
//处理注入网址，配置获得网站注入网址
function handlSqlInUrl($httpurl){
    $url=''; $splStr=''; $i=''; $s ='';
    $splStr= aspSplit($httpurl, '=');
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        if( $i== uBound($splStr) ){ $url= $url . '=' ; break; }
        $s= $splStr[$i];
        if( $i % 2== 0 ){
            $url= $url . $splStr[$i];
        }else{
            if( inStr($s, '&') > 0 ){
                $url= $url . '=' . mid($s, inStr($s, '&'),-1);
            }
        }
    }
    $handlSqlInUrl= $url;
    return @$handlSqlInUrl;
}

//获得扫描后函数名称列表
function getScanFunctionNameList($content){

    $splStr=''; $i=''; $YesASP=''; $YesWord=''; $Sx=''; $s=''; $Wc=''; $Zc=''; $s1=''; $AspCode=''; $SYHCount=''; $UpWord=''; $FunList=''; $s2 ='';
    $UpWordn=''; $tempS=''; $DimList ='';
    $YesFunction ='';//函数是否为真
    $YesASP= false; //是ASP 默认为假
    $YesFunction= false; //是函数 默认为假
    $YesWord= false; //是单词 默认为假
    $SYHCount= 0; //双引号默认为0
    $splStr= aspSplit($content, vbCrlf()); //分割行
    //循环分行
    foreach( $splStr as $key=>$s){
        //循环每个字符
        for( $i= 1 ; $i<= len($s); $i++){
            $Sx= mid($s, $i, 1);
            //Asp开始
            if( $Sx== '<' && $Wc== '' ){ //输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if( mid($s, $i + 1, 1)== '%' ){
                    $YesASP= true; //ASP为真
                    $i= $i + 1; //加1而不能加2，要不然<%function Test() 就截取不到
                }
                //ASP结束
            }else if( $Sx== '%' && mid($s, $i + 1, 1)== '>' && $Wc== '' ){ //Wc为输出内容
                $YesASP= false; //ASP为假
                $i= $i + 1; //不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
            }
            if( $YesASP== true ){
                //输入文本
                if(($Sx== '"' || $Wc <> '') ){
                    //双引号累加
                    if( $Sx== '"' ){ $SYHCount= $SYHCount + 1 ;}
                    //判断是否"在最后
                    if( $SYHCount % 2== 0 ){
                        if( mid($s, $i + 1, 1) <> '"' ){
                            $Wc= $Wc . $Sx;
                            $s1= right(replace(mid($s, 1, $i - len($Wc)), ' ', ''), 1); //必需放在这里，要不会出错
                            if( $YesFunction== true ){ $AspCode= $AspCode . $Wc ;}//函数代码累加
                            $SYHCount= 0 ; $Wc= ''; //清除
                        }else{
                            $Wc= $Wc . $Sx;
                        }
                    }else{
                        $Wc= $Wc . $Sx;
                    }
                }else if( $Sx== '\'' ){ //注释则退出
                    if( $YesFunction== true ){ $AspCode= $AspCode . mid($s, $i,-1) ;}
                    break;
                    //字母
                }else if( checkABC($Sx)== true ||($Sx== '_' && $Zc <> '') || $Zc <> '' ){
                    $Zc= $Zc . $Sx;
                    $s1= lCase(mid($s . ' ', $i + 1, 1));
                    if( inStr('abcdefghijklmnopqrstuvwxyz0123456789', $s1)== 0 && ($s1== '_' && $Zc <> '') ){//最简单判断
                        $tempS= mid($s, $i + 1,-1);
                        if( inStr('|function|sub|', '|' . lCase($Zc) . '|') ){
                            //函数开始
                            if( $YesFunction== false && lCase($UpWord) <> 'end' ){
                                $YesFunction= true;
                                $s2= mid($s, $i + 2,-1);
                                $s2= mid($s2, 1, inStr($s2, '(') - 1);
                                $FunList= $FunList . $s2 . vbCrlf();
                            }else if( $YesFunction== true && lCase($UpWord)== 'end' ){ //获得上一个单词
                                $AspCode= $AspCode . $Zc . vbCrlf();

                                $YesFunction= false;
                            }

                        }
                        $UpWord= $Zc; //记住当前单词
                        if( $YesFunction== true ){ $AspCode= $AspCode . $Zc ;}
                        $Zc= '';
                    }

                }
            }
            doEvents( );
        }

    }
    $getScanFunctionNameList= $FunList;
    return @$getScanFunctionNameList;
}
//获得函数名称20150402
function getFunName( $c){
    if( inStr($c, '(') > 0 ){
        $c= mid($c, 1, inStr($c, '(') - 1);
        $c= PHPTrim($c);
    }
    $getFunName= $c;
    return @$getFunName;
}
//获得函数名称中变量
function getFunDimName( $c){
    $startStr=''; $endStr=''; $s ='';
    $c= lCase($c);
    $startStr= '(';
    $endStr= ')';
    if( inStr($c, $startStr) > 0 && inStr($c, $endStr) > 0 ){
        $c= StrCut($c, $startStr, $endStr, 2);
    }
    if( $c <> '' ){
        $c= replace(replace($c, 'byref ', ''), 'byref,', '');
        $c= replace(replace($c, 'byval ', ''), 'byval,', '');
        $c= replace($c, ' ', '');
    }
    $getFunDimName= $c;
    return @$getFunDimName;
}
//获得变量定义的名称
function getDimName( $c){
    $startStr=''; $endStr=''; $s ='';
    $c= lCase($c);
    $startStr= ':';
    if( inStr($c, $startStr) > 0 ){
        $c= mid($c, 1, inStr($c, ':') - 1);
    }
    if( $c <> '' ){
        $c= replace(replace($c, 'byref ', ''), 'byref,', '');
        $c= replace(replace($c, 'byval ', ''), 'byval,', '');
        $c= replace($c, ' ', '');
    }
    if( inStr($c, '\'') > 0 ){
        $c= PHPTrim(mid($c, 1, inStr($c, '\'') - 1)); //刪除里面的'注释部分    20150330
    }
    $getDimName= $c;
    return @$getDimName;
}

//获得JS变量定义的名称
function getVarName( $content){
    $splstr='';$i='';$s='';$c='';
    $content= lCase($content);
    if( inStr($content, ';') > 0 ){
        $content= mid($content, 1, inStr($content, ';') - 1);
    }
    $splstr=aspSplit($content,',');
    foreach( $splstr as $key=>$s){
        if( inStr($s,'=')>0 ){
            $s=mid($s,1,inStr($s,'=')-1);
        }
        $s=aspTrim($s);
        if( $c<>'' ){
            $c=$c . ',';
        }
        if( $s <>'' ){
            $c=$c . $s;
        }
    }
    //call rwend(c)
    $getVarName= $c;
    return @$getVarName;
}


//获得Set变量定义的名称 暂时用不上
function getSetName( $c){
    $c= PHPTrim(lCase($c));
    $c= mid($c, 1, inStr($c, '=') - 1);
    $getSetName= aspTrim($c);
    return @$getSetName;
}
//替换变量
function replaceDim( $content){
    $splStr=''; $s=''; $tempS=''; $c=''; $lCaseS=''; $DimInTHNumb ='';
    $splStr= aspSplit($content, ',');
    foreach( $splStr as $key=>$s){
        $s= aspTrim($s);
        $lCaseS= lCase($s);
        if( $s <> '' ){
            //对变量中()处理，
            if( inStr($s, '(') > 0 ){
                $s= mid($s, 1, inStr($s, '(') - 1);
            }
            $DimInTHNumb= inStr(lCase($GLOBALS['ReplaceDimList']), ',' . $lCaseS . '='); //替换变量
            if( $DimInTHNumb > 0 ){ //替换变量
                $tempS= mid($GLOBALS['ReplaceDimList'], $DimInTHNumb + 1,-1);
                $tempS= mid($tempS, 1, inStr($tempS, ',') - 1);
                $tempS= mid($tempS, inStr($tempS, '=') + 1,-1);
                if( inStr($GLOBALS['FunDim'] . $GLOBALS['RootFunDim'], ',' . $tempS . ',')== false ){
                    $s= $tempS;
                }
            }
            $c= $c . $s . ',';
        }
    }
    if( $c <> '' ){ $c= left($c, len($c) - 1); }
    $replaceDim= $c;
    return @$replaceDim;
}
//替换变量名称(最优化处理) 加强于20141017
function replaceDim2( $DimList, $DimName){
    $ZD=''; $splStr=''; $i=''; $s=''; $nMod=''; $nInt=''; $c ='';
    $replaceDim2= $DimName;
    $ZD= 'abcdefghijklmnopqrstuvwxyz';
    $DimName= lCase($DimName);
    $splStr= aspSplit($DimList, ',');
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        $s= $splStr[$i];
        if( $s== $DimName ){
            $nMod=($i) % len($ZD) + 1;
            $nInt= fix(($i) / len($ZD));

            if( $nMod <> 0 ){
                $c= $c . mid($ZD, $nMod, 1);
            }
            if( $nInt <> 0 ){
                $c= $c . copyStr(mid($ZD, $nInt, 1), $nInt);
            }
            //Call Echo(I,Len(ZD))
            //Call Echo("nMod",nMod)
            //Call Echo("nInt",nInt)
            //Call Echo("C",C)
            $replaceDim2= $c;
            return @$replaceDim2;
        }
    }
    return @$replaceDim2;
}
//找当前文件夹重复函数主程序
function findFolderRepeatFunction($folderPath){
    $filePath=''; $s=''; $c=''; $content=''; $Funs=''; $FunList=''; $AllFunList=''; $nOK=''; $nErr=''; $splStr=''; $splxx=''; $nAllOK=''; $nAllErr=''; $nI ='';
    $ErrFunList=''; $AllErrFunList ='';
    HandlePath($folderPath); //获得完整路径
    $c= '操作文件夹' . $folderPath . vbCrlf();
    $content= getDirFileList($folderPath, '');
    $splStr= aspSplit($content, vbCrlf()) ; $nI= 0;
    foreach( $splStr as $key=>$filePath){
        $nI= $nI + 1;
        $s= $nI . '、' . $filePath;
        $content= getFText($filePath);
        $content= getScanFunctionNameList($content); //获得ASP函数名称列表
        $nOK= 0 ; $nErr= 0 ; $nAllOK= 0 ; $nAllErr= 0 ; $FunList= '' ; $ErrFunList= '' ; $AllErrFunList= '';
        $splxx= aspSplit($content, vbCrlf());
        foreach( $splxx as $key=>$Funs){
            if( $Funs <> '' ){
                if( inStr('|' . $FunList . '|', '|' . $Funs . '|')== 0 ){
                    $FunList= $FunList . $Funs . '|';
                    $nOK= $nOK + 1;
                }else{
                    $ErrFunList= $ErrFunList . $Funs . '|';
                    $nErr= $nErr + 1;
                }
                if( inStr('|' . $AllFunList . '|', '|' . $Funs . '|')== 0 ){
                    $AllFunList= $AllFunList . $Funs . '|'; //全部函数
                    $nAllOK= $nAllOK + 1;
                }else{
                    $AllErrFunList= $AllErrFunList . $Funs . '|';
                    $nAllErr= $nAllErr + 1;
                }
            }
            doEvents( );
        }
        //Call CreateFile("allfun.txt", AllFunList)
        $c= $c . $s . '，函数（' . uBound($splStr) + 1 . '），重复(' . $nErr . '[' . $ErrFunList . '])全部函数重复(' . $nAllErr . '[' . $AllErrFunList . '])' . vbCrlf();
        doEvents( );
    }
    $findFolderRepeatFunction= $c;
    return @$findFolderRepeatFunction;
}
//找当前文件重复函数 (辅助)
function findFileRepeatFunction($filePath){
    $findFileRepeatFunction= handleContentRepeatFunction(getFText('FilePath'), 2);
    return @$findFileRepeatFunction;
}
//找当前内容重复函数
function findContentRepeatFunction($content){
    $findContentRepeatFunction= handleContentRepeatFunction($GLOBALS['Contnet'], 2);
    return @$findContentRepeatFunction;
}
//处理内容重复函数列表 sType为0为不显示，1为显示函数列表，2为显示重复函数列表，3为显示函数与重复函数列表
function handleContentRepeatFunction($content, $sType){
    $c=''; $Funs=''; $FunList=''; $nOK=''; $nErr=''; $splxx=''; $ErrFunList ='';
    $sType= cStr($sType);
    $content= getScanFunctionNameList($content); //获得ASP函数名称列表
    $nOK= 0 ; $nErr= 0;
    $splxx= aspSplit($content, vbCrlf());
    foreach( $splxx as $key=>$Funs){
        if( $Funs <> '' ){
            if( inStr('|' . $FunList . '|', '|' . $Funs . '|')== 0 ){
                $FunList= $FunList . $Funs . '|';
                $nOK= $nOK + 1;
            }else{
                $ErrFunList= $ErrFunList . $Funs . vbCrlf();
                $nErr= $nErr + 1;
            }
        }
        doEvents( );
    }
    $c= '找到函数共（' . uBound($splxx) + 1 . '），重复(' . $nErr . ')' . vbCrlf();
    //函数列表
    if( $sType== '1' || $sType== '3' ){
        $c= $c . vbCrlf() . '函数列表' . vbCrlf() . $FunList;
    }
    //重复函数列表
    if( $ErrFunList <> '' &&($sType== '1' || $sType== '3') ){
        $c= $c . vbCrlf() . '重复函数列表' . vbCrlf() . $ErrFunList;
    }
    $handleContentRepeatFunction= $c;
    return @$handleContentRepeatFunction;
}
//替换字符内容2 自己写得一个 区分大小写
function replace2($content, $SearchStr, $replaceStr){
    $LeftStr=''; $RightStr ='';
    if( inStr($content, $SearchStr) > 0 ){
        $LeftStr= mid($content, 1, inStr($content, $SearchStr) - 1);
        $RightStr= mid($content, len($LeftStr) + len($SearchStr) + 1,-1);
        $content= $LeftStr . $replaceStr . $RightStr;
    }
    $replace2= $content;
    return @$replace2;
}
//替换全部字符内容2 自己写得一个 区分大小写
function allReplace($content, $SearchStr, $replaceStr){
    $LeftStr=''; $RightStr=''; $i ='';
    for( $i= 1 ; $i<= 99; $i++){
        if( inStr($content, $SearchStr) > 0 ){
            $LeftStr= mid($content, 1, inStr($content, $SearchStr) - 1);
            $RightStr= mid($content, len($LeftStr) + len($SearchStr) + 1,-1);
            $content= $LeftStr . $replaceStr . $RightStr;
        }else{
            break;
        }
    }
    $allReplace= $content;
    return @$allReplace;
}
//替换一次，不区分大小写
function replaceOneNOLU($content, $SearchStr, $replaceStr){
    $LeftStr=''; $RightStr=''; $LCaseContent ='';
    $SearchStr= lCase($SearchStr);
    $LCaseContent= lCase($content);
    if( inStr($LCaseContent, $SearchStr) > 0 ){
        $LeftStr= mid($content, 1, inStr($LCaseContent, $SearchStr) - 1);
        $RightStr= mid($content, len($LeftStr) + len($SearchStr) + 1,-1);
        $content= $LeftStr . $replaceStr . $RightStr;
    }
    $replaceOneNOLU= $content;
    return @$replaceOneNOLU;
}
//优化ASP代码 删除左右空格
function optimizeAspCode($content){
    $splStr=''; $s=''; $c=''; $i ='';
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        $s= trimVbTab($s);
        if( $s <> '' ){ $c= $c . trimVbTab($s) . vbCrlf() ;}
    }
    $optimizeAspCode= $c;
    return @$optimizeAspCode;
}

//截取函数里大括号
function cutDaKuoHao($content){
    $cutDaKuoHao= cutFunctionvValue($content, '{', '}');
    return @$cutDaKuoHao;
}
//截取函数里小括号
function cutXianKuoHao($content){
    $cutXianKuoHao= cutFunctionvValue($content, '(', ')');
    return @$cutXianKuoHao;
}

//截取函数值20150716
function cutFunctionvValue($content, $startStr, $endStr){
    $ku1=''; $ku2=''; $i=''; $s=''; $c ='';
    $ku1= 1 ; $ku2= 0;
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        $c= $c . $s;
        if( $s== $startStr ){
            $ku1= $ku1 + 1;
        }else if( $s== $endStr ){
            $ku2= $ku2 + 1;
            if( $ku1== $ku2 ){
                break;
            }
        }
    }
    $cutFunctionvValue= $c;
    return @$cutFunctionvValue;
}
//获得字符在内容里出现次数20150721
function getStrIntContentNumb($content, $findStr){
    $splStr ='';
    if( inStr($content, $findStr) > 0 ){
        $splStr= aspSplit($content, $findStr);
        $getStrIntContentNumb= uBound($splStr);
    }else{
        $getStrIntContentNumb= 0;
    }
    return @$getStrIntContentNumb;
}
?>