<?PHP
//��������   ?act=saveData
function saveData($sType){

    if( @$_SESSION['yzm']=='' ){
        eerr('��ʾ','��֤��ʧЧ');
    }

    //if instr("|"& getFormFieldList() &"|","|yzm|") then
    if( @$_SESSION['yzm']<>@$_POST['yzm'] ){
        eerr('��ʾ','��֤�����');
    }


    //������������
    if( $sType== 'articlecomment' ){
        if( @$_POST['content']=='' ){
            eerr('��ʾ','����Ϊ��');
        }
        saveArticleComment(@$_REQUEST['itemid'], ADSql(@$_REQUEST['content']));
    }else if( $sType== 'feedback' ){
        if( @$_POST['guestname']=='' ){
            eerr('��ʾ','����Ϊ��');
        }
        autoSavePostData('', 'feedback', 'isthrough|numb|0,ip||'. getip() .',columnid||' . @$_GET['columnid']);
        ASPEcho('��ʾ', '�����ύ�ɹ����ȴ�����Ա���');
    }else if( $sType== 'guestbook' ){

        if( @$_POST['guestname']=='' ){
            eerr('��ʾ','����Ϊ��');
        }

        autoSavePostData('', 'guestbook', 'isthrough|numb|0,ip||'. getip() .',columnid||' . @$_GET['columnid']);
        ASPEcho('��ʾ', '�����ύ�ɹ����ȴ�����Ա���');

    }else if( $sType== 'articledetail' ){
        autoSavePostData('', 'articledetail', 'title|bodycontent,ip||'. getip());
        ASPEcho('��ʾ', '�����ύ�ɹ�');
    }
    die();
}
//������������ 20160129
function saveArticleComment($itemid, $bodycontent){
    connExecute('insert into ' . $GLOBALS['db_PREFIX'] . 'tablecomment (tableName,itemid,ip,bodycontent,adddatetime) values(\'ArticleDetail\',' . $itemid . ',\'' . getIP() . '\',\'' . $bodycontent . '\',\'' . Now() . '\')');
    ASPEcho('��ʾ', '�����ύ�ɹ����ȴ�����Ա���');
}
//�Զ�����POST���ݵ���
function autoSavePostData($id, $tableName, $fieldNameList){
    $sql ='';
    $sql=getPostSql($id, $tableName, $fieldNameList);
    //���SQL
    if( checksql($sql)== false ){
        errorLog('������ʾ��<hr>sql=' . $sql . '<br>');
        return '';
    }
    //conn.execute(sql)			'checksql��һ�����Ѿ�ִ���˲���Ҫ��ִ����20160410
}
//���Post���ͱ�����SQL��� 20160309
function getPostSql($id, $tableName, $fieldNameList){
    $valueStr=''; $editValueStr=''; $sql='';
    $splStr=''; $splxx=''; $s=''; $fieldList ='';
    $fieldName=''; $defaultFieldValue ='';//�ֶ�����
    $fieldSetType ='';//�ֶ���������
    $fieldValue ='';//�ֶ�ֵ

    $systemFieldList ='';//���ֶ��б�
    $systemFieldList= getHandleFieldList($GLOBALS['db_PREFIX'] . $tableName, '�ֶ������б�');

    $postFieldList ='';//post�ֶ��б�
    $splPost=''; $fieldContent=''; $fieldConfig ='';
    $postFieldList= getFormFieldList();
    $splPost= aspSplit($postFieldList, '|');
    foreach( $splPost as $key=>$fieldName){
        $fieldContent= @$_POST[$fieldName];
        if( instr($systemFieldList, ',' . $fieldName . '|') > 0 && instr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){
            //Ϊ�Զ����
            if( instr($fieldNameList, ',' . $fieldName . '|') > 0 ){
                $fieldConfig= mid($fieldNameList, instr($fieldNameList, ',' . $fieldName . '|') + 1,-1);
            }else{
                $fieldConfig= mid($systemFieldList, instr($systemFieldList, ',' . $fieldName . '|') + 1,-1);
            }
            $fieldConfig= mid($fieldConfig, 1, instr($fieldConfig, ',') - 1);
            //call echo("config",fieldConfig)
            //call echo(fieldName,fieldContent)

            $splxx= aspSplit($fieldConfig . '|||', '|');
            $fieldName= $splxx[0]; //�ֶ�����
            $fieldSetType= $splxx[1]; //�ֶ���������
            $defaultFieldValue= $splxx[2]; //Ĭ���ֶ�ֵ
            $fieldValue= ADSqlRf($fieldName); //�������棬��Ϊ��������'����
            //md5����
            if( $fieldSetType== 'md5' ){
                $fieldValue= myMD5($fieldValue);
            }

            if( $fieldSetType== 'yesno' ){
                if( $fieldValue== '' ){
                    $fieldValue= $defaultFieldValue;
                }
                //��Ϊ�������ͼӵ�����
            }else if( $fieldSetType== 'numb' ){
                if( $fieldValue== '' ){
                    $fieldValue= $defaultFieldValue;
                }

            }else if( $fieldName== 'flags' ){
                //PHP���÷�
                if( EDITORTYPE== 'php' ){
                    if( $fieldValue <> '' ){
                        $fieldValue= '|' . arrayToString($fieldValue, '|');
                    }
                }else{
                    $fieldValue= '|' . arrayToString(aspSplit($fieldValue, ', '), '|');
                }


                $fieldValue= '\'' . $fieldValue . '\'';

                //Ϊʱ��
            }else if( $fieldSetType== 'date' ){
                if( $fieldValue== '' ){
                    $fieldValue= ASPDate();
                }

            }else{
                $fieldValue= '\'' . $fieldValue . '\'';
            }

            $fieldValue=unescape($fieldValue);			//����20160418

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
    //�Զ����ֶ��Ƿ���Ҫд��Ĭ��ֵ
    $splStr= aspSplit($fieldNameList, ',');
    foreach( $splStr as $key=>$s){
        if( instr($s, '|') > 0 ){
            $splxx= aspSplit($s . '|||', '|');
            $fieldName= $splxx[0]; //�ֶ�����
            $fieldSetType= $splxx[1]; //�ֶ���������
            $fieldValue= $splxx[2]; //Ĭ���ֶ�ֵ

            if( instr($systemFieldList, ',' . $fieldName . '|') > 0 && instr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){
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