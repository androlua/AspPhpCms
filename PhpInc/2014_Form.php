<?PHP
//Form

//���ύ
function FormSubmit(){
    $TableName='';$SplStr='';$S='';$FieldName='';$FieldContent='';$FieldList='';$YZM='';
    $GLOBALS['conn=']=OpenConn();
    $SplStr=aspSplit(@$_POST[],'&');
    $TableName= Rf('TableName');
    $YZM= aspTrim(Rf('YZM'));

    if( $YZM<>'' ){
        if( @$_SESSION['YZM'] <>$YZM ){
            javascript('����', '��֤�벻��ȷ', '');
            die();
        }
    }

    $FieldList= lCase(getFieldList($TableName));
    //Call Echo("FieldList",FieldList)
    //Call Echo("TableName", TableName)
    $RsObj=$GLOBALS['conn']->query('Select * From ['. $TableName .']');

    foreach( $SplStr as $key=>$S){
        $FieldName= lCase(mid($S,1,inStr($S,'=')-1));
        //FieldContent = Mid(S,InStr(S,"=")+1)
        $FieldContent= Rf($FieldName);
        if( inStr(','. $FieldList .',', ','. $FieldName .',')>0 ){
            $Rs[$FieldName]=$FieldContent;
        }
        //Call Echo(FieldName,FieldContent & "," & unescape(FieldContent))
    }

    //	Call Echo("DialogTitle",Rf("DialogTitle"))
    //Call Die("��������")

    javascript('����', '�ύ'. Rf('DialogTitle') .'�ɹ�', '');
}

//���POST�ֶ������б� 20160226
function getFormFieldList(){
    $s='';$c='';$splstr='';$fieldName='';
    $splstr=aspSplit(@$_POST,'&');
    foreach( $splstr as $key=>$s){
        $fieldName= lCase(mid($s, 1, inStr($s, '=') - 1));
        if( $c<>'' ){ $c=$c . '|';}
        $c=$c . $fieldName;
    }
    $getFormFieldList=$c;
    return @$getFormFieldList;
}

?>