<?PHP
//ASP PHP���ݲ���ͨ���ļ�

//�ж�׷��Sql�Ǽ�Where ����And   sql = getWhereAnd(sql,addSql)        �޸���20141007 ��ǿ��
function getWhereAnd( $sql, $addSql){
    $LCaseAddSql=''; $AddType ='';
    //׷��SQlΪ�����˳�
    if( AspTrim($addSql)== '' ){ $getWhereAnd= $sql ; return @$getWhereAnd; }
    if( instr(strtolower($sql), ' where ') > 0 ){
        $AddType= ' And ';
    }else{
        $AddType= ' Where ';
    }
    if( $addSql <> '' ){
        $addSql= AspTrim($addSql);
        $LCaseAddSql= strtolower($addSql);
        if( Left($LCaseAddSql, 6)== 'order ' || Left($LCaseAddSql, 6)== 'group ' ){
            $getWhereAnd= $sql . ' ' . $addSql ; return @$getWhereAnd; 								//�Ľ�����ӿո���Ϊǰ���Ѿ�ɾ����20160115
        }else if( Left($LCaseAddSql, 6)== 'where ' ){
            $addSql= mid($addSql, 7,-1);
        }else if( Left($LCaseAddSql, 4)== 'and ' ){
            $addSql= mid($addSql, 5,-1);
        }
        $sql= $sql . $AddType . $addSql;
    }
    $getWhereAnd= $sql;
    return @$getWhereAnd;
}
//�����ѯ Or �� And        �����޸���20140703
function orAndSearch($addSql, $SeectField, $SearchValue){
    $splStr=''; $s=''; $c ='';
    $SearchValue= RegExp_Replace($SearchValue, ' or ', ' Or ');
    $SearchValue= RegExp_Replace($SearchValue, ' and ', ' And ');
    if( instr($SearchValue, ' Or ') > 0 ){
        $splStr= aspSplit($SearchValue, ' Or ');
        foreach( $splStr as $key=>$s){
            if( $s <> '' ){
                if( $c <> '' ){ $c= $c . ' Or ' ;}
                $c= $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'';
            }
        }
    }else if( instr($SearchValue, ' And ') > 0 ){
        $splStr= aspSplit($SearchValue, ' And ');
        foreach( $splStr as $key=>$s){
            if( $s <> '' ){
                if( $c <> '' ){ $c= $c . ' And ' ;}
                $c= $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'';
            }
        }
    }else if( $SearchValue <> '' ){
        $splStr= aspSplit($SearchValue, ' And ');
        foreach( $splStr as $key=>$s){
            if( $s <> '' ){
                if( $c <> '' ){ $c= $c . ' And ' ;}
                $c= $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'';
            }
        }
    }
    if( $c <> '' ){
        if( instr(strtolower($addSql), ' where ')== 0 ){
            $c= ' Where ' . $c;
        }else{
            $c= ' And ' . $c;
        }
        $addSql= $addSql . $c;
    }
    $orAndSearch= $addSql;
    return @$orAndSearch;
}


?>