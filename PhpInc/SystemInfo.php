<?PHP
//ϵͳ��Ϣ  (2014,05,27)



//����ϵͳ�汾
function OperationSystem(){
    $httpAgent='';$SystemVer='';
    $httpAgent= serverVariables('HTTP_USER_AGENT');
    if( inStr($httpAgent, 'NT 5.2') > 0 ){
        $SystemVer= 'Windows Server 2003';
    }else if( inStr($httpAgent, 'NT 5.1') > 0 ){
        $SystemVer= 'Windows XP';
    }else if( inStr($httpAgent, 'NT 5') > 0 ){
        $SystemVer= 'Windows 2000';
    }else if( inStr($httpAgent, 'NT 4') > 0 ){
        $SystemVer= 'Windows NT4';
    }else if( inStr($httpAgent, '4.9') > 0 ){
        $SystemVer= 'Windows ME';
    }else if( inStr($httpAgent, '98') > 0 ){
        $SystemVer= 'Windows 98';
    }else if( inStr($httpAgent, '95') > 0 ){
        $SystemVer= 'Windows 95';
    }else{
        $SystemVer= $httpAgent;
    }
    $OperationSystem= $httpAgent;
    return @$OperationSystem;
}
//����Ƿ�Ϊ�ֻ�
function CheckMobile(){
    $CheckMobile=false;
    if( serverVariables('HTTP_X_WAP_PROFILE') <> '' ){
        $CheckMobile=true;
    }
    return @$CheckMobile;
}

//���IIS�汾��
function getIISVersion(){
    $getIISVersion=serverVariables('SERVER_SOFTWARE');
    return @$getIISVersion;
}

?>