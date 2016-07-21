<?PHP
//保存数据   ?act=saveData
function saveData($sType){

    if( @$_SESSION['yzm']=='' ){
        Eerr('提示','验证码失效');
    }

    //if instr("|"& getFormFieldList() &"|","|yzm|") then
    if( @$_SESSION['yzm']<>@$_POST['yzm'] ){
        Eerr('提示','验证码错误');
    }
    @$_SESSION['yzm']='';			//清空验证码


    //保存文章评论
    if( $sType== 'articlecomment' ){
        autoSavePostData('', 'tablecomment', 'tablename||ArticleDetail,adddatetime|now,itemid||'. @$_REQUEST['itemid'] .',adddatetime,ip||'. getIP());
        aspEcho('提示', '评论提交成功，等待管理员审核');

    }else if( $sType== 'feedback' ){
        if( @$_POST['guestname']=='' ){
            Eerr('提示','姓名为空');
        }
        autoSavePostData('', 'feedback', 'isthrough|numb|0,adddatetime|now,ip||'. getIP() .',columnid||' . @$_GET['columnid']);
        aspEcho('提示', '反馈提交成功，等待管理员审核');
    }else if( $sType== 'guestbook' ){
        if( @$_POST['guestname']=='' ){
            Eerr('提示','姓名为空');
        }
        autoSavePostData('', 'guestbook', 'isthrough|numb|0,adddatetime|now,ip||'. getIP() .',columnid||' . @$_GET['columnid']);
        aspEcho('提示', '留言提交成功，等待管理员审核');

    }else if( $sType== 'articledetail' ){
        autoSavePostData('', 'articledetail', 'title|bodycontent,adddatetime|now,ip||'. getIP());
        aspEcho('提示', '文章提交成功');
    }
    die();
}
//自动保存POST数据到表
function autoSavePostData($id, $tableName, $fieldNameList){
    $sql ='';
    $sql=getPostSql($id, $tableName, $fieldNameList);
    //检测SQL
    if( checkSql($sql)== false ){
        errorLog('出错提示：<hr>sql=' . $sql . '<br>');
        return '';
    }
    //conn.execute(sql)			'checksql这一步就已经执行了不需要再执行了20160410
}
//获得Post发送表单处理SQL语句 20160309
function getPostSql($id, $tableName, $fieldNameList){
    $valueStr=''; $editValueStr=''; $sql='';
    $splStr=''; $splxx=''; $s=''; $fieldList ='';
    $fieldName=''; $defaultFieldValue ='';//字段名称
    $fieldSetType ='';//字段设置类型
    $fieldValue ='';//字段值

    $systemFieldList ='';//表字段列表
    $systemFieldList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '字段配置列表');

    $postFieldList ='';//post字段列表
    $splPost=''; $fieldContent=''; $fieldConfig ='';
    $postFieldList= getFormFieldList();
    //以后再把下面与上面这两种处理方法事成一种看看行不行
    $splPost= aspSplit($postFieldList, '|');
    foreach( $splPost as $key=>$fieldName){
        $fieldContent= @$_POST[$fieldName];
        if( inStr($systemFieldList, ',' . $fieldName . '|') > 0 && inStr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){
            //为自定义的
            if( inStr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig= mid($fieldNameList, inStr($fieldNameList, ',' . $fieldName . '|') + 1,-1);
            }else{
                $fieldConfig= mid($systemFieldList, inStr($systemFieldList, ',' . $fieldName . '|') + 1,-1);
            }
            $fieldConfig= mid($fieldConfig, 1, inStr($fieldConfig, ',') - 1);
            //call echo("config",fieldConfig)
            //call echo(fieldName,fieldContent)
            //call echo("fieldConfig",fieldConfig)
            $splxx= aspSplit($fieldConfig . '|||', '|');
            $fieldName= $splxx[0]; //字段名称
            $fieldSetType= $splxx[1]; //字段设置类型
            $defaultFieldValue= $splxx[2]; //默认字段值
            $fieldValue= ADSqlRf($fieldName); //代替上面，因为它处理了'符号
            //call echo("fieldValue",fieldValue)
            //排序密码不处理
            if( $fieldValue<>'#NO******NO#' ){
                //md5加密
                if( $fieldSetType== 'md5' ){
                    $fieldValue= myMD5($fieldValue);
                }

                if( $fieldSetType== 'yesno' ){
                    if( $fieldValue== '' ){
                        $fieldValue= $defaultFieldValue;
                    }
                    //不为数字类型加单引号
                }else if( $fieldSetType== 'numb' ){
                    if( $fieldValue== '' ){
                        $fieldValue= $defaultFieldValue;
                    }

                }else if( $fieldName== 'flags' ){
                    //PHP里用法
                    if( EDITORTYPE== 'php' ){
                        if( $fieldValue <> '' ){
                            $fieldValue= '|' . arrayToString($fieldValue, '|');
                        }
                    }else{
                        $fieldValue= '|' . arrayToString(aspSplit($fieldValue, ', '), '|');
                    }


                    $fieldValue= '\'' . $fieldValue . '\'';

                    //为时间
                }else if( $fieldSetType== 'time' || $fieldSetType== 'now' ){
                    if( $fieldValue== '' ){
                        $fieldValue= now();
                    }
                    $fieldValue= '\'' . $fieldValue . '\'';
                    //为时期
                }else if( $fieldSetType== 'date' ){
                    if( $fieldValue== '' ){
                        $fieldValue= aspDate();
                    }
                    $fieldValue= '\'' . $fieldValue . '\'';

                }else{
                    $fieldValue= '\'' . $fieldValue . '\'';
                }

                $fieldValue=unescape($fieldValue);			//解码20160418

                if( $valueStr <> '' ){
                    $valueStr= $valueStr . ',';
                    $editValueStr= $editValueStr . ',';
                }
                $valueStr= $valueStr . $fieldValue;
                $editValueStr= $editValueStr . $fieldName . '=' . $fieldValue;
            }
            if( $fieldList <> '' ){
                $fieldList= $fieldList . ',';
            }
            $fieldList= $fieldList . $fieldName;


        }
    }
    //自定义字段是否需要写入默认值  有的
    $splStr= aspSplit($fieldNameList, ',');
    foreach( $splStr as $key=>$s){
        if( inStr($s, '|') > 0 ){
            $splxx= aspSplit($s . '|||', '|');
            $fieldName= $splxx[0]; //字段名称
            $fieldSetType= $splxx[1]; //字段设置类型
            $fieldValue= $splxx[2]; //默认字段值

            if( inStr($systemFieldList, ',' . $fieldName . '|') > 0 && inStr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){

                if( $fieldSetType== 'date' && $fieldValue=='' ){
                    $fieldValue= aspDate();
                }else if( ($fieldSetType== 'time' || $fieldSetType== 'now') && $fieldValue=='' ){
                    $fieldValue= now();
                }
                if( $fieldSetType <> 'yesno' && $fieldSetType <> 'numb' ){
                    $fieldValue= '\'' . $fieldValue . '\'';
                }
                if( $fieldList <> '' ){
                    $fieldList= $fieldList . ',';
                    $valueStr= $valueStr . ',';
                    $editValueStr= $editValueStr . ',';
                }
                $fieldList= $fieldList . $fieldName;
                $valueStr= $valueStr . $fieldValue;
                $editValueStr= $editValueStr . $fieldName . '=' . $fieldValue;
                //call echo(fieldName,fieldSetType)
            }
        }
    }

    if( $id== '' ){
        $sql= 'insert into ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' (' . $fieldList . ',updatetime) values(' . $valueStr . ',\'' . now() . '\')';
    }else{
        $sql= 'update ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' set ' . $editValueStr . ',updatetime=\'' . now() . '\' where id=' . $id;
    }
    $getPostSql= $sql;
    return @$getPostSql;
}
?>