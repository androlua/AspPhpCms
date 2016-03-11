<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//系统信息  (2014,05,27)

//检测是否为手机浏览
function checkMobile(){
    $http_ACCEPT =''; $http_ACCEPT = ServerVariables('HTTP_ACCEPT') ;//获取浏览器信息
    $http_USER_AGENT =''; $http_USER_AGENT = LCase(ServerVariables('HTTP_USER_AGENT')) ;//获取AGENT
    $http_X_WAP_PROFILE =''; $http_X_WAP_PROFILE = ServerVariables('HTTP_X_WAP_PROFILE') ;//WAP特定信息 品牌机自带浏览器都会有
    $http_UA_OS =''; $http_UA_OS = ServerVariables('HTTP_UA_OS') ;//手机系统 电脑为空
    $http_VIA =''; $http_VIA = LCase(ServerVariables('HTTP_VIA')) ;//网关信息
    $isMobile ='';
    $isMobile = false ;
    if( UBound(aspSplit($http_ACCEPT, 'vnd.wap')) > 0 ){ $isMobile = true ;}
    if( $http_USER_AGENT == '' ){ $isMobile = true ;}
    if( $http_X_WAP_PROFILE <> '' ){ $isMobile = true ;}
    if( $http_UA_OS <> '' ){ $isMobile = true ;}
    if( UBound(aspSplit($http_VIA, 'wap')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'netfront')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'iphone')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'opera mini')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'ucweb')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'windows ce')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'symbianos')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'java')) > 0 ){ $isMobile = true ;}
    if( UBound(aspSplit($http_USER_AGENT, 'android')) > 0 ){ $isMobile = true ;}

    $checkMobile = $isMobile ;
    return @$checkMobile;
}

//操作系统版本
function operationSystem(){
    $s=''; $c ='';
    $s = ServerVariables('HTTP_USER_AGENT') ;
    if( instr($s, 'NT 5.2') > 0 ){
        $c = 'Windows Server 2003' ;
    }else if( instr($s, 'NT 5.1') > 0 ){
        $c = 'Windows XP' ;
    }else if( instr($s, 'NT 5') > 0 ){
        $c = 'Windows 2000' ;
    }else if( instr($s, 'NT 4') > 0 ){
        $c = 'Windows NT4' ;
    }else if( instr($s, '4.9') > 0 ){
        $c = 'Windows ME' ;
    }else if( instr($s, '98') > 0 ){
        $c = 'Windows 98' ;
    }else if( instr($s, '95') > 0 ){
        $c = 'Windows 95' ;
    }else{
        $c = $s ;
    }
    $operationSystem = $c;
    return @$operationSystem;
}


//获得IIS版本号
function getIISVersion(){
    $getIISVersion = ServerVariables('SERVER_SOFTWARE') ;
    return @$getIISVersion;
}


?>