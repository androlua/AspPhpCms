<?PHP
//系统信息  (2014,05,27)



//操作系统版本
function OperationSystem(){
    $httpAgent='';$SystemVer='';
    $httpAgent= ServerVariables('HTTP_USER_AGENT');
    if( instr($httpAgent, 'NT 5.2') > 0 ){
        $SystemVer= 'Windows Server 2003';
    }else if( instr($httpAgent, 'NT 5.1') > 0 ){
        $SystemVer= 'Windows XP';
    }else if( instr($httpAgent, 'NT 5') > 0 ){
        $SystemVer= 'Windows 2000';
    }else if( instr($httpAgent, 'NT 4') > 0 ){
        $SystemVer= 'Windows NT4';
    }else if( instr($httpAgent, '4.9') > 0 ){
        $SystemVer= 'Windows ME';
    }else if( instr($httpAgent, '98') > 0 ){
        $SystemVer= 'Windows 98';
    }else if( instr($httpAgent, '95') > 0 ){
        $SystemVer= 'Windows 95';
    }else{
        $SystemVer= $httpAgent;
    }
    $OperationSystem= $httpAgent;
    return @$OperationSystem;
}
//检测是否为手机
function CheckMobile(){
    $CheckMobile=false;
    if( ServerVariables('HTTP_X_WAP_PROFILE') <> '' ){
        $CheckMobile=true;
    }
    return @$CheckMobile;
}

//获得IIS版本号
function getIISVersion(){
    $getIISVersion=ServerVariables('SERVER_SOFTWARE');
    return @$getIISVersion;
}

?>