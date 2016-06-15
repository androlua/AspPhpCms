<?PHP
//保存数据   ?act=saveData
function saveData($sType){

    if( @$_SESSION['yzm']=='' ){
        eerr('提示','验证码失效');
    }

    //if instr("|"& getFormFieldList() &"|","|yzm|") then
    if( @$_SESSION['yzm']<>@$_POST['yzm'] ){
        eerr('提示','验证码错误');
    }
    @$_SESSION['yzm']='';			//清空验证码


    //保存文章评论
    if( $sType== 'articlecomment' ){
        autoSavePostData('', 'tablecomment', 'tablename||ArticleDetail,adddatetime|now,itemid||'. @$_REQUEST['itemid'] .',adddatetime,ip||'. getip());
        ASPEcho('提示', '评论提交成功，等待管理员审核');

    }else if( $sType== 'feedback' ){
        if( @$_POST['guestname']=='' ){
            eerr('提示','姓名为空');
        }
        autoSavePostData('', 'feedback', 'isthrough|numb|0,adddatetime|now,ip||'. getip() .',columnid||' . @$_GET['columnid']);
        ASPEcho('提示', '反馈提交成功，等待管理员审核');
    }else if( $sType== 'guestbook' ){
        if( @$_POST['guestname']=='' ){
            eerr('提示','姓名为空');
        }
        autoSavePostData('', 'guestbook', 'isthrough|numb|0,adddatetime|now,ip||'. getip() .',columnid||' . @$_GET['columnid']);
        ASPEcho('提示', '留言提交成功，等待管理员审核');

    }else if( $sType== 'articledetail' ){
        autoSavePostData('', 'articledetail', 'title|bodycontent,adddatetime|now,ip||'. getip());
        ASPEcho('提示', '文章提交成功');
    }
    die();
}
//自动保存POST数据到表
function autoSavePostData($id, $tableName, $fieldNameList){
    $sql ='';
    $sql=getPostSql($id, $tableName, $fieldNameList);
    //检测SQL
    if( checksql($sql)== false ){
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
    $splPost= aspSplit($postFieldList, '|');
    foreach( $splPost as $key=>$fieldName){
        $fieldContent= @$_POST[$fieldName];
        if( instr($systemFieldList, ',' . $fieldName . '|') > 0 && instr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){
            //为自定义的
            if( instr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig= mid($fieldNameList, instr($fieldNameList, ',' . $fieldName . '|') + 1,-1);
            }else{
                $fieldConfig= mid($systemFieldList, instr($systemFieldList, ',' . $fieldName . '|') + 1,-1);
            }
            $fieldConfig= mid($fieldConfig, 1, instr($fieldConfig, ',') - 1);
            //call echo("config",fieldConfig)
            //call echo(fieldName,fieldContent)

            $splxx= aspSplit($fieldConfig . '|||', '|');
            $fieldName= $splxx[0]; //字段名称
            $fieldSetType= $splxx[1]; //字段设置类型
            $defaultFieldValue= $splxx[2]; //默认字段值
            $fieldValue= ADSqlRf($fieldName); //代替上面，因为它处理了'符号
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
                    $fieldValue= ASPDate();
                }
                $fieldValue= '\'' . $fieldValue . '\'';

            }else{
                $fieldValue= '\'' . $fieldValue . '\'';
            }

            $fieldValue=unescape($fieldValue);			//解码20160418

            if( $fieldList <> '' ){
                $fieldList= $fieldList . ',';
                $valueStr= $valueStr . ',';
                $editValueStr= $editValueStr . ',';
            }
            $fieldList= $fieldList . $fieldName;
            $valueStr= $valueStr . $fieldValue;
            $editValueStr= $editValueStr . $fieldName . '=' . $fieldValue;
        }
    }
    //自定义字段是否需要写入默认值
    $splStr= aspSplit($fieldNameList, ',');
    foreach( $splStr as $key=>$s){
        if( instr($s, '|') > 0 ){
            $splxx= aspSplit($s . '|||', '|');
            $fieldName= $splxx[0]; //字段名称
            $fieldSetType= $splxx[1]; //字段设置类型
            $fieldValue= $splxx[2]; //默认字段值

            if( instr($systemFieldList, ',' . $fieldName . '|') > 0 && instr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){







                if( $fieldSetType== 'date' && $fieldValue=='' ){
                    $fieldValue= ASPDate();
                }else if( ($fieldSetType== 'time' || $fieldSetType== 'now') && $fieldValue=='' ){
                    $fieldValue= Now();
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
        $sql= 'insert into ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' (' . $fieldList . ',updatetime) values(' . $valueStr . ',\'' . Now() . '\')';
    }else{
        $sql= 'update ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' set ' . $editValueStr . ',updatetime=\'' . Now() . '\' where id=' . $id;
    }
    $getPostSql= $sql;
    return @$getPostSql;
}
?>