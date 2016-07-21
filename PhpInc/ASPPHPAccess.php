<?PHP
//ASP PHP数据操作通用文件

//判断追加Sql是加Where 还是And   sql = getWhereAnd(sql,addSql)        修改于20141007 加强版
function getWhereAnd( $sql, $addSql){
    $LCaseAddSql=''; $AddType='';$s='';
    //追加SQl为空则退出
    if( aspTrim($addSql)== '' ){ $getWhereAnd= $sql ; return @$getWhereAnd; }
    if( inStr(lCase($sql), ' where ') > 0 ){
        $AddType= ' And ';
    }else{
        $AddType= ' Where ';
    }
    if( $addSql <> '' ){
        $addSql= aspTrim($addSql);
        $LCaseAddSql= lCase($addSql);
        if( left($LCaseAddSql, 6)== 'order ' || left($LCaseAddSql, 6)== 'group ' ){
            $getWhereAnd= $sql . ' ' . $addSql ; return @$getWhereAnd; 								//改进必需加空格，因为前面已经删除了20160115
        }else if( left($LCaseAddSql, 6)== 'where ' ){
            $addSql= mid($addSql, 7,-1);
        }else if( left($LCaseAddSql, 4)== 'and ' ){
            $addSql= mid($addSql, 5,-1);
        }
        //对where 改进   20160623
        $s=lCase($addSql);
        if( $s<>'and' && $s<>'or' && $s<>'where' ){
            $sql= $sql . $AddType . $addSql;
        }
    }
    $getWhereAnd= $sql;
    return @$getWhereAnd;
}
//多个查询 Or 与 And        二次修改于20140703
function orAndSearch($addSql, $SeectField, $SearchValue){
    $splStr=''; $s=''; $c ='';
    $SearchValue= regExp_Replace($SearchValue, ' or ', ' Or ');
    $SearchValue= regExp_Replace($SearchValue, ' and ', ' And ');
    if( inStr($SearchValue, ' Or ') > 0 ){
        $splStr= aspSplit($SearchValue, ' Or ');
        foreach( $splStr as $key=>$s){
            if( $s <> '' ){
                if( $c <> '' ){ $c= $c . ' Or ' ;}
                $c= $c . ' ' . $SeectField . ' Like \'%' . $s . '%\'';
            }
        }
    }else if( inStr($SearchValue, ' And ') > 0 ){
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
        if( inStr(lCase($addSql), ' where ')== 0 ){
            $c= ' Where ' . $c;
        }else{
            $c= ' And ' . $c;
        }
        $addSql= $addSql . $c;
    }
    $orAndSearch= $addSql;
    return @$orAndSearch;
}



//获得当前id当前页数 默认每页显示10条 20160716
function getThisIdPage($tableName,$id,$nPageSize){
	if($id==''){
		return 1;
	}
    $nCount='';
    if( $nPageSize=='' ){
        $nPageSize=10;
    }
    $nCount=connexecute('select count(*) from ' . $tableName . ' where id<=' . $id)[0];
    $getThisIdPage=GetCountPage(cint($nCount), $nPageSize);
    //call echo("tableName=" & tableName & "id=" & id &",ncount=" & ncount,npagesize & "               ," & getThisIdPage)
    return @$getThisIdPage;
}
?>