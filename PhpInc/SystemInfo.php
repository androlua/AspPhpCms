<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-03-11
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//ϵͳ��Ϣ  (2014,05,27)

//����Ƿ�Ϊ�ֻ����
function checkMobile(){
    $http_ACCEPT =''; $http_ACCEPT = ServerVariables('HTTP_ACCEPT') ;//��ȡ�������Ϣ
    $http_USER_AGENT =''; $http_USER_AGENT = LCase(ServerVariables('HTTP_USER_AGENT')) ;//��ȡAGENT
    $http_X_WAP_PROFILE =''; $http_X_WAP_PROFILE = ServerVariables('HTTP_X_WAP_PROFILE') ;//WAP�ض���Ϣ Ʒ�ƻ��Դ������������
    $http_UA_OS =''; $http_UA_OS = ServerVariables('HTTP_UA_OS') ;//�ֻ�ϵͳ ����Ϊ��
    $http_VIA =''; $http_VIA = LCase(ServerVariables('HTTP_VIA')) ;//������Ϣ
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

//����ϵͳ�汾
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


//���IIS�汾��
function getIISVersion(){
    $getIISVersion = ServerVariables('SERVER_SOFTWARE') ;
    return @$getIISVersion;
}


?>