<?PHP
//ASP PHP数据操作通用文件

//判断追加Sql是加Where 还是And   Sql = GetWhereAnd(Sql,AddSql)        修改于20141007 加强版
function getWhereAnd( $sql, $addSql){
    $LCaseAddSql=''; $AddType ='';
    //追加SQl为空则退出
    if( AspTrim($addSql) == '' ){ $getWhereAnd = $sql ; return @$getWhereAnd; }
    if( instr(LCase($sql), ' where ') > 0 ){
        $AddType = ' And ' ;
    }else{
        $AddType = ' Where ' ;
    }
    if( $addSql <> '' ){
        $addSql = AspTrim($addSql) ;
        $LCaseAddSql = LCase($addSql) ;
        if( substr($LCaseAddSql, 0 , 6) == 'order ' || substr($LCaseAddSql, 0 , 6) == 'group ' ){
            $getWhereAnd = $sql . ' ' . $addSql ; return @$getWhereAnd; 								//改进必需加空格，因为前面已经删除了20160115
        }else if( substr($LCaseAddSql, 0 , 6) == 'where ' ){
            $addSql = mid($addSql, 7,-1) ;
        }else if( substr($LCaseAddSql, 0 , 4) == 'and ' ){
            $addSql = mid($addSql, 5,-1);
        }
        $sql = $sql . $AddType . $addSql ;
    }
    $getWhereAnd = $sql ;
    return @$getWhereAnd;
}
//多个查询 Or 与 And        二次修改于20140703
function orAndSearch($addSql, $SeectField, $SearchValue){
    $splStr=''; $s=''; $c ='';
    $SearchValue = RegExp_Replace($SearchValue, ' or ', ' Or ') ;
    $SearchValue = RegExp_Replace($SearchValue, ' and ', ' And ') ;
    if( instr($SearchValue, ' Or ') > 0 ){
        $splStr = aspSplit($SearchValue, ' Or ') ;
        foreach( $splStr as $s){
            if( $s <> '' ){
                if( $c <> '' ){ $c = $c . ' Or ' ;}
                $c = $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'' ;
            }
        }
    }else if( instr($SearchValue, ' And ') > 0 ){
        $splStr = aspSplit($SearchValue, ' And ') ;
        foreach( $splStr as $s){
            if( $s <> '' ){
                if( $c <> '' ){ $c = $c . ' And ' ;}
                $c = $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'' ;
            }
        }
    }else if( $SearchValue <> '' ){
        $splStr = aspSplit($SearchValue, ' And ') ;
        foreach( $splStr as $s){
            if( $s <> '' ){
                if( $c <> '' ){ $c = $c . ' And ' ;}
                $c = $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'' ;
            }
        }
    }
    if( $c <> '' ){
        if( instr(LCase($addSql), ' where ') == 0 ){
            $c = ' Where ' . $c ;
        }else{
            $c = ' And ' . $c ;
        }
        $addSql = $addSql . $c ;
    }
    $orAndSearch = $addSql ;
    return @$orAndSearch;
}


?>

