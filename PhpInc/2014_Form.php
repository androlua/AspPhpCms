<?PHP
//Form

//���ύ
function FormSubmit(){
    $TableName='';$SplStr='';$S='';$FieldName='';$FieldContent='';$FieldList='';$YZM='';
    $GLOBALS['conn=']=OpenConn();
    $SplStr=aspSplit(@$_POST[],'&');
    $TableName= Rf('TableName');
    $YZM= AspTrim(Rf('YZM'));

    if( $YZM<>'' ){
        if( @$_SESSION['YZM'] <>$YZM ){
            Javascript('����', '��֤�벻��ȷ', '');
            die();
        }
    }

    $FieldList= strtolower(GetFieldList($TableName));
    //Call Echo("FieldList",FieldList)
    //Call Echo("TableName", TableName)
    $RsObj=$GLOBALS['conn']->query('Select * From ['. $TableName .']');

    foreach( $SplStr as $key=>$S){
        $FieldName= strtolower(mid($S,1,instr($S,'=')-1));
        //FieldContent = Mid(S,InStr(S,"=")+1)
        $FieldContent= Rf($FieldName);
        if( instr(','. $FieldList .',', ','. $FieldName .',')>0 ){
            $Rs[$FieldName]=$FieldContent;
        }
        //Call Echo(FieldName,FieldContent & "," & unescape(FieldContent))
    }

    //	Call Echo("DialogTitle",Rf("DialogTitle"))
    //Call Die("��������")

    Javascript('����', '�ύ'. Rf('DialogTitle') .'�ɹ�', '');
}

//���POST�ֶ������б� 20160226
function getFormFieldList(){
    $s='';$c='';$splstr='';$fieldName='';
    $splstr=aspSplit(@$_POST,'&');
    foreach( $splstr as $key=>$s){
        $fieldName= strtolower(mid($s, 1, instr($s, '=') - 1));
        if( $c<>'' ){ $c=$c . '|';}
        $c=$c . $fieldName;
    }
    $getFormFieldList=$c;
    return @$getFormFieldList;
}

?>