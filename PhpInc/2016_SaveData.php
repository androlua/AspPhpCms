<?PHP
//��������   ?act=saveData
function saveData($sType){

    if( @$_SESSION['yzm']=='' ){
        Eerr('��ʾ','��֤��ʧЧ');
    }

    //if instr("|"& getFormFieldList() &"|","|yzm|") then
    if( @$_SESSION['yzm']<>@$_POST['yzm'] ){
        Eerr('��ʾ','��֤�����');
    }
    @$_SESSION['yzm']='';			//�����֤��


    //������������
    if( $sType== 'articlecomment' ){
        autoSavePostData('', 'tablecomment', 'tablename||ArticleDetail,adddatetime|now,itemid||'. @$_REQUEST['itemid'] .',adddatetime,ip||'. getIP());
        aspEcho('��ʾ', '�����ύ�ɹ����ȴ�����Ա���');

    }else if( $sType== 'feedback' ){
        if( @$_POST['guestname']=='' ){
            Eerr('��ʾ','����Ϊ��');
        }
        autoSavePostData('', 'feedback', 'isthrough|numb|0,adddatetime|now,ip||'. getIP() .',columnid||' . @$_GET['columnid']);
        aspEcho('��ʾ', '�����ύ�ɹ����ȴ�����Ա���');
    }else if( $sType== 'guestbook' ){
        if( @$_POST['guestname']=='' ){
            Eerr('��ʾ','����Ϊ��');
        }
        autoSavePostData('', 'guestbook', 'isthrough|numb|0,adddatetime|now,ip||'. getIP() .',columnid||' . @$_GET['columnid']);
        aspEcho('��ʾ', '�����ύ�ɹ����ȴ�����Ա���');

    }else if( $sType== 'articledetail' ){
        autoSavePostData('', 'articledetail', 'title|bodycontent,adddatetime|now,ip||'. getIP());
        aspEcho('��ʾ', '�����ύ�ɹ�');
    }
    die();
}
//�Զ�����POST���ݵ���
function autoSavePostData($id, $tableName, $fieldNameList){
    $sql ='';
    $sql=getPostSql($id, $tableName, $fieldNameList);
    //���SQL
    if( checkSql($sql)== false ){
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
    //�Ժ��ٰ����������������ִ������³�һ�ֿ����в���
    $splPost= aspSplit($postFieldList, '|');
    foreach( $splPost as $key=>$fieldName){
        $fieldContent= @$_POST[$fieldName];
        if( inStr($systemFieldList, ',' . $fieldName . '|') > 0 && inStr(',' . $fieldList . ',', ',' . $fieldName . ',')== false ){
            //Ϊ�Զ����
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
            $fieldName= $splxx[0]; //�ֶ�����
            $fieldSetType= $splxx[1]; //�ֶ���������
            $defaultFieldValue= $splxx[2]; //Ĭ���ֶ�ֵ
            $fieldValue= ADSqlRf($fieldName); //�������棬��Ϊ��������'����
            //call echo("fieldValue",fieldValue)
            //�������벻����
            if( $fieldValue<>'#NO******NO#' ){
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
                }else if( $fieldSetType== 'time' || $fieldSetType== 'now' ){
                    if( $fieldValue== '' ){
                        $fieldValue= now();
                    }
                    $fieldValue= '\'' . $fieldValue . '\'';
                    //Ϊʱ��
                }else if( $fieldSetType== 'date' ){
                    if( $fieldValue== '' ){
                        $fieldValue= aspDate();
                    }
                    $fieldValue= '\'' . $fieldValue . '\'';

                }else{
                    $fieldValue= '\'' . $fieldValue . '\'';
                }

                $fieldValue=unescape($fieldValue);			//����20160418

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
    //�Զ����ֶ��Ƿ���Ҫд��Ĭ��ֵ  �е�
    $splStr= aspSplit($fieldNameList, ',');
    foreach( $splStr as $key=>$s){
        if( inStr($s, '|') > 0 ){
            $splxx= aspSplit($s . '|||', '|');
            $fieldName= $splxx[0]; //�ֶ�����
            $fieldSetType= $splxx[1]; //�ֶ���������
            $fieldValue= $splxx[2]; //Ĭ���ֶ�ֵ

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