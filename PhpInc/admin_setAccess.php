<?PHP
//��#stop#��1     ����Ϊ�����뵱ǰ������

//����callfile_setAccess�ļ�����
function callfile_setAccess(){
    switch ( @$_REQUEST['stype'] ){
        case 'backupDatabase' ; backupDatabase() ;break;//�������ݿ�
        case 'recoveryDatabase' ; recoveryDatabase(); //�ָ����ݿ�

        break;
        default ; eerr('setAccessҳ��û�ж���', @$_REQUEST['stype']);
    }
}

//�ָ����ݿ�
function recoveryDatabase(){
    $backupDir=''; $backupFilePath ='';
    $content=''; $s=''; $splStr=''; $tableName ='';
    handlePower('�ָ����ݿ�');
    $backupDir= $GLOBALS['adminDir'] . '/Data/BackUpDateBases/';
    $backupFilePath= $backupDir . '/' . @$_REQUEST['databaseName'];
    if( CheckFile($backupFilePath)== false ){
        eerr('���ݿ��ļ�������', $backupFilePath);
    }
    $content= GetFText($backupFilePath);
    $splStr= aspSplit($content, '===============================' . vbCrlf());
    foreach( $splStr as $key=>$s){
        $tableName= newGetStrCut($s, 'table');
        if( $tableName <> '' ){
            connexecute('delete from ' . $GLOBALS['db_PREFIX'] . $tableName);
            aspEcho($tableName, importTXTData($s, $tableName, '���'));
        }
    }
    aspEcho('�ָ����ݿ����', '');
}

//�������ݿ�
function backupDatabase(){
    $isUnifyToFile=''; $tableNameList=''; $databaseTableNameList=''; $fieldConfig=''; $fieldName=''; $fieldType=''; $splField=''; $fieldValue='';$nLen='';$isOK='';
    $splStr=''; $splxx=''; $tableName=''; $s=''; $c=''; $backupDir=''; $backupFilePath ='';
    handlePower('�������ݿ�');
    $tableNameList= lCase(@$_REQUEST['tableNameList']); //�Զ��屸�����ݱ��б�
    $isUnifyToFile= @$_REQUEST['isUnifyToFile']; //ͳһ�ŵ�һ���ļ���
    $databaseTableNameList= lCase($GLOBALS['db_PREFIX'] . 'webcolumn'. vbCrlf() . getTableList());		 //��db_PREFIX����ǰ�棬��Ϊ��������Ҫ�������ȡ
    $nLen=len($GLOBALS['db_PREFIX']);

    //�����Զ�����б�
    if( $tableNameList <> '' ){
        $splStr= aspSplit($tableNameList, '|');
        foreach( $splStr as $key=>$tableName){
            if( inStr(vbCrlf() . $databaseTableNameList . vbCrlf(), vbCrlf() . $GLOBALS['db_PREFIX'] . $tableName . vbCrlf()) > 0 ){
                if( $c <> '' ){
                    $c= $c . vbCrlf();
                }
                $c= $c . $GLOBALS['db_PREFIX'] . $tableName;
            }
        }
        if( $c== '' ){
            eerr('�Զ��屸�ݱ���ȷ <a href="javascript:history.go(-1)">�������</a>', $tableNameList);
        }
        $databaseTableNameList= $c;
    }
    $splStr= aspSplit($databaseTableNameList, vbCrlf());
    $c= '';
    foreach( $splStr as $key=>$tableName){
        $tableName= aspTrim($tableName);
        $isOK=true;
        //�ж�ǰ׺�Ƿ�һ��
        if( $nLen>0 ){
            if( mid($tableName,1,$nLen)<>$GLOBALS['db_PREFIX'] ){
                $isOK=false;
            }
        }
        if( $isOK==true ){
            $fieldConfig= lCase(getFieldConfigList($tableName));
            aspEcho($tableName, $fieldConfig);
            $rsObj=$GLOBALS['conn']->query( 'select * from ' . $tableName);
            $c= $c . '��table��' . mid($tableName, len($GLOBALS['db_PREFIX']) + 1,-1) . vbCrlf();
            while( $rs= $GLOBALS['conn']->fetch_array($rsObj)){
                $splField= aspSplit($fieldConfig, ',');
                foreach( $splField as $key=>$s){
                    if( inStr($s, '|') > 0 ){
                        $splxx= aspSplit($s, '|');
                        $fieldName= $splxx[0];
                        $fieldType= $splxx[1];
                        $fieldValue= $rs[$fieldName];
                        if( $fieldType== 'numb' ){
                            $fieldValue= replace(replace($fieldValue, 'True', '1'), 'False', '0');
                        }
                        //��̨�˵�
                        if( $tableName== $GLOBALS['db_PREFIX'] . 'listmenu' && $fieldName== 'parentid' ){
                            $fieldValue= getListMenuName($fieldValue);
                            //��վ��Ŀ
                        }else if( $tableName== $GLOBALS['db_PREFIX'] . 'webcolumn' && $fieldName== 'parentid' ){
                            $fieldValue= getColumnName($fieldValue);
                        }
                        if( $fieldValue <> '' ){
                            if( inStr($fieldValue, vbCrlf()) > 0 ){
                                $fieldValue= $fieldValue . '��/' . $fieldName . '��';
                            }
                            $c= $c . '��' . $fieldName . '��' . $fieldValue . vbCrlf();
                        }
                    }
                }
                $c= $c . '-------------------------------' . vbCrlf();
            }
            $c= $c . '===============================' . vbCrlf();
        }
    }
    $backupDir= $GLOBALS['adminDir'] . '/Data/BackUpDateBases/';
    $backupFilePath= $backupDir . '/' . Format_Time(now(), 4) . '.txt';
    createDirFolder($backupDir);
    deleteFile($backupFilePath); //ɾ���ɱ����ļ�
    createFile($backupFilePath, $c); //���������ļ�
    HR();
    aspEcho('backupDir', $backupDir);
    aspEcho('backupFilePath', $backupFilePath);
    eerr('�������','<a href=\'?act=displayLayout&templateFile=layout_manageDatabases.html&lableTitle=���ݿ�\'>������� ���ݻָ�����</a>');
}

//�������ݿ�����
function resetAccessData(){
    handlePower('�ָ�ģ������'); //����Ȩ�޴���
    $GLOBALS['conn=']=OpenConn();
    $splStr=''; $i=''; $s=''; $columnname=''; $title=''; $nCount=''; $webdataDir ='';
    $webdataDir= @$_REQUEST['webdataDir'];
    if( $webdataDir <> '' ){
        if( checkFolder($webdataDir)== false ){
            eerr('��վ����Ŀ¼�����ڣ��ָ�Ĭ������δ�ɹ�', $webdataDir);
        }
    }else{
        $webdataDir= '/Data/WebData/';
    }

    //�޸���վ����
    importTXTData(GetFText($webdataDir . '/website.txt'), 'website', '�޸�');
    batchImportDirTXTData($webdataDir, $GLOBALS['db_PREFIX'] . 'WebColumn' . vbCrlf() . getTableList());		 //��webcolumn����Ϊwebcolumn�����µ������ݣ���Ϊ��̨��������Ҫ������20160711

    aspEcho('��ʾ', '�ָ��������');
    rw('<hr><a href=\'../index.php\' target=\'_blank\'>������ҳ</a> | <a href="?" target=\'_blank\'>�����̨</a>');



    writeSystemLog('', '�ָ�Ĭ������' . $GLOBALS['db_PREFIX']); //ϵͳ��־
}

//����������Ӧ����Ϣ
function batchImportDirTXTData($webdataDir, $tableNameList){
    $folderPath=''; $tableName=''; $splStr=''; $content=''; $splxx=''; $filePath=''; $fileName=''; $handleTableNameList ='';
    $splStr= aspSplit($tableNameList, vbCrlf());
    foreach( $splStr as $key=>$tableName){
        if( $tableName <> '' ){
            if( $GLOBALS['db_PREFIX'] <> '' ){
                $tableName= mid($tableName, len($GLOBALS['db_PREFIX']) + 1,-1);
            }
            $tableName= aspTrim(lCase($tableName));
            //�жϱ� ���ظ�����
            if( inStr('|' . $handleTableNameList . '|', '|' . $tableName . '|')== false ){
                $handleTableNameList= $handleTableNameList . $tableName . '|';

                $folderPath= HandlePath($webdataDir . '/' . $tableName);
                if( checkFolder($folderPath)== true ){
                    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . $tableName); //ɾ����ǰ��ȫ������
                    aspEcho('tableName', $tableName);
                    $content= getDirAllFileList($folderPath, 'txt');
                    $splxx= aspSplit($content, vbCrlf());
                    foreach( $splxx as $key=>$filePath){
                        $fileName= getFileName($filePath);
                        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
                            aspEcho($tableName, $filePath);
                            importTXTData(GetFText($filePath), $tableName, '���');
                            doEvents( );
                        }
                    }
                }
            }
        }
    }
}

//��������
function importTXTData($content, $tableName, $sType){
    $fieldConfigList=''; $splList=''; $listStr=''; $splStr=''; $splxx=''; $s=''; $sql=''; $nOK ='';
    $fieldName=''; $fieldType=''; $fieldValue=''; $addFieldList=''; $addValueList=''; $updateValueList ='';
    $fieldStr ='';
    $tableName= aspTrim(lCase($tableName)); //��
    //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
    if( inStr($content, vbCrlf())== false ){
        $content= replace($content, chr(10), vbCrlf());
    }
    $fieldConfigList= lCase(getFieldConfigList($GLOBALS['db_PREFIX'] . $tableName));
    $splStr= aspSplit($fieldConfigList, ',');
    $splList= aspSplit($content, vbCrlf() . '-------------------------------');
    $nOK= 0;
    foreach( $splList as $key=>$listStr){
        $addFieldList= ''; //����ֶ��б����
        $addValueList= ''; //����ֶ��б�ֵ
        $updateValueList= ''; //�޸��ֶ��б�

        $s= lCase(newGetStrCut($listStr, '#stop#'));
        if( $s<>'1' && $s<>'true' ){
            foreach( $splStr as $key=>$fieldStr){
                if( $fieldStr <> '' ){
                    $splxx= aspSplit($fieldStr, '|');
                    $fieldName= $splxx[0];
                    $fieldType= $splxx[1];
                    if( inStr($listStr, '��' . $fieldName . '��') > 0 ){
                        $listStr= $listStr . vbCrlf(); //�Ӹ�������Ϊ�������һ����������ӽ�ȥ 20160629
                        if( $addFieldList <> '' ){
                            $addFieldList= $addFieldList . ',';
                            $addValueList= $addValueList . ',';
                            $updateValueList= $updateValueList . ',';
                        }
                        $addFieldList= $addFieldList . $fieldName;

                        $fieldValue= newGetStrCut($listStr, $fieldName);
                        if( $fieldType== 'textarea' ){
                            $fieldValue= contentTranscoding($fieldValue);
                        }
                        //call echo(tableName,fieldName)
                        //���´���
                        if(($tableName== 'articledetail' || $tableName== 'webcolumn') && $fieldName== 'parentid' ){
                            //call echo(tableName,fieldName)
                            //call echo("fieldValue",fieldValue)
                            $fieldValue= getColumnId($fieldValue);
                            //call echo("fieldValue",fieldValue)
                            //��̨�˵�
                        }else if( $tableName== 'listmenu' && $fieldName== 'parentid' ){
                            $fieldValue= getListMenuId($fieldValue);
                        }
                        if( $fieldType== 'date' && $fieldValue== '' ){
                            $fieldValue= aspDate();
                        }else if(($fieldType== 'time' || $fieldType== 'now') && $fieldValue== '' ){
                            $fieldValue= now();
                        }
                        if( $fieldType <> 'yesno' && $fieldType <> 'numb' ){
                            $fieldValue= '\'' . $fieldValue . '\'';
                            //Ĭ����ֵ����Ϊ0
                        }else if( $fieldValue== '' ){
                            $fieldValue= 0;
                        }

                        $addValueList= $addValueList . $fieldValue; //���ֵ
                        $updateValueList= $updateValueList . $fieldName . '=' . $fieldValue; //�޸�ֵ
                    }
                }
            }
            //�ֶ��б�Ϊ��
            if( $addFieldList <> '' ){
                if( $sType== '�޸�' ){
                    $sql= 'update ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' set ' . $updateValueList;
                }else{
                    $sql= 'insert into ' . $GLOBALS['db_PREFIX'] . '' . $tableName . ' (' . $addFieldList . ') values(' . $addValueList . ')';
                }
                //���SQL
                if( checkSql($sql)== false ){
                    eerr('������ʾ', '<hr>sql=' . $sql . '<br>');
                }
                $nOK= $nOK + 1;
            }else{
                $nOK=batchImportColumnList($splStr,$listStr,$nOK,$tableName);

            }
        }

    }
    $importTXTData= $nOK;
    //call echo("sql",sql)
    //call echo("addFieldList",addFieldList)
    //call echo("updateValueList",updateValueList)
    return @$importTXTData;
}
//����������Ŀ�б� 20160716
function batchImportColumnList($splField, $listStr,$nOK,$tableName){
    $splstr='';$splxx='';$isColumn='';$columnName='';$s='';$c='';$nLen='';$id='';$parentIdArray=aspArray(99);$columntypeArray=aspArray(99);$flagsArray=aspArray(99);$nIndex='';$fieldStr='';$fieldName='';$valueStr='';$nCount='';
    $isColumn=false;
    $nCount=0;
    $listStr=replace($listStr,vbTab(),'    ');
    $splstr=aspSplit($listStr,vbCrlf());
    foreach( $splstr as $key=>$s){
        if( $s=='��#sub#��' ){
            $isColumn=true;
        }else if( $isColumn==true ){
            $columnName=$s;
            if( inStr($columnName,'��|��')>0 ){
                $columnName=mid($columnName,1,inStr($columnName,'��|��')-1);
            }
            $columnName=aspRTrim($columnName);
            $nLen=len($columnName);
            $columnName=aspLTrim($columnName);
            $nlen=$nLen-len($columnName);
            $nIndex=cint($nLen/4);
            if( $columnName<>'' ){
                $parentIdArray[$nIndex]=$columnName;
                $c=$c . '��columnname��' . $columnName . vbCrlf();
                foreach( $splField as $key=>$fieldStr){
                    $splxx=aspSplit($fieldStr . '|','|');
                    $fieldName=$splxx[0];
                    if( $fieldName<>'' && $fieldName<>'columnname' && inStr($s,$fieldName . '=\'')>0 ){
                        $valueStr=getStrCut($s, $fieldName . '=\'', '\'',2);
                        $c=$c . '��'. $fieldName .'��' . $valueStr . vbCrlf();

                        if( $fieldName=='columntype' ){
                            $columntypeArray[$nIndex]=$valueStr;
                        }else if( $fieldName=='flags' ){
                            $flagsArray[$nIndex]=$valueStr;
                        }
                    }
                }
                if( $nIndex<>0 ){
                    $c=$c . '��parentid��' . $parentIdArray[$nIndex-1] . vbCrlf();
                    $c=$c . '��columntype��' . $columntypeArray[$nIndex-1] . vbCrlf();
                    $c=$c . '��flags��' . $flagsArray[$nIndex-1] . vbCrlf();
                }else{
                    $c=$c . '��parentid��-1' . vbCrlf();
                }
                $c=$c . '��sortrank��' . $nCount . vbCrlf();
                $nCount=$nCount+1;
                $c=$c . '-------------------------------' . vbCrlf();
            }
        }
    }
    //call die(createfile("1.txt",c))
    //��������
    if( $c<>'' ){
        importTXTData($c, $tableName, '���');
    }
}

//�µĽ�ȡ�ַ�20160216
function newGetStrCut($content, $title){
    $s ='';
    //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
    if( inStr($content, vbCrlf())== false ){
        $content= replace($content, chr(10), vbCrlf());
    }
    if( inStr($content, '��/' . $title . '��') > 0 ){
        $s= aDSql(phpTrim(getStrCut($content, '��' . $title . '��', '��/' . $title . '��', 0)));
    }else{
        $s= aDSql(phpTrim(getStrCut($content, '��' . $title . '��', vbCrlf(), 0)));
    }
    $newGetStrCut= $s;
    return @$newGetStrCut;
}

//����ת��
function contentTranscoding( $content){
    $content= replace(replace(replace(replace($content, '<?', '&lt;?'), '?>', '?&gt;'), '<' . '%', '&lt;%'), '?>', '%&gt;');


    $splStr=''; $i=''; $s=''; $c=''; $isTranscoding=''; $isBR ='';
    $isTranscoding= false;
    $isBR= false;
    $splStr= aspSplit($content, vbCrlf());
    foreach( $splStr as $key=>$s){
        if( inStr($s, '[&htmlת��&]') > 0 ){
            $isTranscoding= true;
        }
        if( inStr($s, '[&htmlת��end&]') > 0 ){
            $isTranscoding= false;
        }
        if( inStr($s, '[&ȫ������&]') > 0 ){
            $isBR= true;
        }
        if( inStr($s, '[&ȫ������end&]') > 0 ){
            $isBR= false;
        }

        if( $isTranscoding== true ){
            $s= replace(replace($s, '[&htmlת��&]', ''), '<', '&lt;');
        }else{
            $s= replace($s, '[&htmlת��end&]', '');
        }
        if( $isBR== true ){
            $s= replace($s, '[&ȫ������&]', '');
            if( right(aspTrim($s), 8) <> '������/div>' ){
                $s= $s . '<br>';
            }
        }else{
            $s= replace($s, '[&ȫ������end&]', '');
        }
        //��ǩ��ʽ������� 20160628
        if( inStr($s, '��article_lable��') > 0 ){
            $s= replace($s, '��article_lable��', '');
            $s= '<div class="article_lable">' . $s . '</div>';
        }else if( inStr($s, '��article_blockquote��') > 0 ){
            $s= replace($s, '��article_blockquote��', '');
            $s= '<div class="article_blockquote">' . $s . '</div>';
        }


        if( $c <> '' ){
            $c= $c . vbCrlf();
        }
        $c= $c . $s;
    }
    $c= replace(replace($c, '��b��', '<b>'), '��/b��', '</b>');
    $c= replace($c, '������', '<');

    $c= replace(replace($c, '��strong��', '<strong>'), '��/strong��', '</strong>');
    $contentTranscoding= $c;
    return @$contentTranscoding;
}



//�������ݿ�����
function resetAccessData_temp(){

    handlePower('�ָ�ģ������'); //����Ȩ�޴���

    $GLOBALS['conn=']=OpenConn();
    $splStr=''; $i=''; $s=''; $columnname=''; $title=''; $nCount=''; $webdataDir ='';
    $webdataDir= @$_REQUEST['webdataDir'];
    if( $webdataDir <> '' ){
        if( checkFolder($webdataDir)== false ){
            eerr('��վ����Ŀ¼�����ڣ��ָ�Ĭ������δ�ɹ�', $webdataDir);
        }
    }else{
        $webdataDir= '/Data/WebData/';
    }

    aspEcho('��ʾ', '�ָ��������');
    rw('<hr><a href=\'../index.php\' target=\'_blank\'>������ҳ</a> | <a href="?" target=\'_blank\'>�����̨</a>');

    $content=''; $filePath=''; $parentid=''; $author=''; $adddatetime=''; $fileName=''; $bodycontent=''; $webtitle=''; $webkeywords=''; $webdescription=''; $sortrank=''; $labletitle=''; $target ='';
    $websitebottom=''; $webTemplate=''; $webimages=''; $webcss=''; $webjs=''; $flags=''; $websiteurl=''; $splxx=''; $columntype=''; $relatedtags=''; $npagesize=''; $customaurl=''; $nofollow ='';
    $templatepath=''; $isthrough=''; $titlecolor ='';
    $showreason=''; $ncomputersearch=''; $nmobliesearch=''; $ncountsearch=''; $ndegree ='';//���۱�
    $displaytitle=''; $aboutcontent=''; $isonhtml ='';//��ҳ��
    $columnenname ='';//������
    $smallimage=''; $bigImage=''; $bannerimage ='';//���±�
    $httpurl=''; $price=''; $morepageurl=''; $charset=''; $thispage=''; $countpage=''; $bigClassName=''; $startStr=''; $endStr=''; $startaddstr=''; $endaddstr=''; $sType=''; $saction=''; $fieldName=''; $fieldcheck ='';

    //��վ����
    $content= GetFText($webdataDir . '/website.txt');
    //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
    if( inStr($content, vbCrlf())== false ){
        $content= replace($content, chr(10), vbCrlf());
    }
    if( $content <> '' ){
        $webtitle= newGetStrCut($content, 'webtitle');
        $webkeywords= newGetStrCut($content, 'webkeywords');
        $webdescription= newGetStrCut($content, 'webdescription');
        $websitebottom= newGetStrCut($content, 'websitebottom');
        $webTemplate= newGetStrCut($content, 'webtemplate');
        $webimages= newGetStrCut($content, 'webimages');
        $webcss= newGetStrCut($content, 'webcss');
        $webjs= newGetStrCut($content, 'webjs');
        $flags= newGetStrCut($content, 'flags');
        $websiteurl= newGetStrCut($content, 'websiteurl');

        if( getRecordCount($GLOBALS['db_PREFIX'] . 'website', '')== 0 ){
            connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'website(webtitle) values(\'����\')');
        }

        connexecute('update ' . $GLOBALS['db_PREFIX'] . 'website  set webtitle=\'' . $webtitle . '\',webkeywords=\'' . $webkeywords . '\',webdescription=\'' . $webdescription . '\',websitebottom=\'' . $websitebottom . '\',webtemplate=\'' . $webTemplate . '\',webimages=\'' . $webimages . '\',webcss=\'' . $webcss . '\',webjs=\'' . $webjs . '\',flags=\'' . $flags . '\',websiteurl=\'' . $websiteurl . '\'');
    }

    //����
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'webcolumn');
    $content= getDirTxtList($webdataDir . '/webcolumn/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��webtitle��') > 0 ){
                    $s= $s . vbCrlf();
                    $webtitle= newGetStrCut($s, 'webtitle');
                    $webkeywords= newGetStrCut($s, 'webkeywords');
                    $webdescription= newGetStrCut($s, 'webdescription');
                    $customaurl= newGetStrCut($s, 'customaurl');

                    $sortrank= newGetStrCut($s, 'sortrank');
                    if( $sortrank== '' ){ $sortrank= 0 ;}
                    $fileName= newGetStrCut($s, 'filename');
                    $columnname= newGetStrCut($s, 'columnname');
                    $columnenname= newGetStrCut($s, 'columnenname');
                    $columntype= newGetStrCut($s, 'columntype');
                    $flags= newGetStrCut($s, 'flags');
                    $parentid= newGetStrCut($s, 'parentid');

                    $parentid= phpTrim(getColumnId($parentid)); //�ɸ�����Ŀ�����ҵ���ӦID   ������Ϊ-1
                    //call echo("parentid",parentid)
                    $labletitle= newGetStrCut($s, 'labletitle');
                    //ÿҳ��ʾ����
                    $npagesize= newGetStrCut($s, 'npagesize');
                    if( $npagesize== '' ){ $npagesize= 10 ;}//Ĭ�Ϸ�ҳ��Ϊ10��

                    $target= newGetStrCut($s, 'target');

                    $smallimage= newGetStrCut($s, 'smallimage');
                    $bigImage= newGetStrCut($s, 'bigImage');
                    $bannerimage= newGetStrCut($s, 'bannerimage');

                    $templatepath= newGetStrCut($s, 'templatepath');


                    $bodycontent= newGetStrCut($s, 'bodycontent');
                    $bodycontent= contentTranscoding($bodycontent);
                    //�Ƿ���������html
                    $isonhtml= newGetStrCut($s, 'isonhtml');
                    if( $isonhtml== '0' || lCase($isonhtml)== 'false' ){
                        $isonhtml= 0;
                    }else{
                        $isonhtml= 1;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow= newGetStrCut($s, 'nofollow');
                    if( $nofollow== '1' || lCase($nofollow)== 'true' ){
                        $nofollow= 1;
                    }else{
                        $nofollow= 0;
                    }
                    //call echo(columnname,nofollow)


                    $aboutcontent= newGetStrCut($s, 'aboutcontent');
                    $aboutcontent= contentTranscoding($aboutcontent);

                    $bodycontent= newGetStrCut($s, 'bodycontent');
                    $bodycontent= contentTranscoding($bodycontent);

                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'webcolumn (webtitle,webkeywords,webdescription,columnname,columnenname,columntype,sortrank,filename,customaurl,flags,parentid,labletitle,aboutcontent,bodycontent,npagesize,isonhtml,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $columnname . '\',\'' . $columnenname . '\',\'' . $columntype . '\',' . $sortrank . ',\'' . $fileName . '\',\'' . $customaurl . '\',\'' . $flags . '\',' . $parentid . ',\'' . $labletitle . '\',\'' . $aboutcontent . '\',\'' . $bodycontent . '\',' . $npagesize . ',' . $isonhtml . ',' . $nofollow . ',\'' . $target . '\',\'' . $smallimage . '\',\'' . $bigImage . '\',\'' . $bannerimage . '\',\'' . $templatepath . '\')');
                }
            }
        }
    }

    //����
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'articledetail');
    $content= getDirAllFileList($webdataDir . '/articledetail/', 'txt');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��title��') > 0 ){
                    $s= $s . vbCrlf();
                    $parentid= newGetStrCut($s, 'parentid');
                    $parentid= getColumnId($parentid);
                    $title= newGetStrCut($s, 'title');
                    $titlecolor= newGetStrCut($s, 'titlecolor');
                    $webtitle= newGetStrCut($s, 'webtitle');
                    $webkeywords= newGetStrCut($s, 'webkeywords');
                    $webdescription= newGetStrCut($s, 'webdescription');


                    $author= newGetStrCut($s, 'author');
                    $sortrank= newGetStrCut($s, 'sortrank');
                    if( $sortrank== '' ){ $sortrank= 0 ;}
                    $adddatetime= newGetStrCut($s, 'adddatetime');
                    $fileName= newGetStrCut($s, 'filename');
                    $templatepath= newGetStrCut($s, 'templatepath');
                    $flags= newGetStrCut($s, 'flags');
                    $relatedtags= newGetStrCut($s, 'relatedtags');

                    $customaurl= newGetStrCut($s, 'customaurl');
                    $target= newGetStrCut($s, 'target');


                    $smallimage= newGetStrCut($s, 'smallimage');
                    $bigImage= newGetStrCut($s, 'bigImage');
                    $bannerimage= newGetStrCut($s, 'bannerimage');
                    $labletitle= newGetStrCut($s, 'labletitle');

                    $aboutcontent= newGetStrCut($s, 'aboutcontent');
                    $aboutcontent= contentTranscoding($aboutcontent);

                    $bodycontent= newGetStrCut($s, 'bodycontent');
                    $bodycontent= contentTranscoding($bodycontent);
                    //�Ƿ���������html
                    $isonhtml= newGetStrCut($s, 'isonhtml');
                    if( $isonhtml== '0' || lCase($isonhtml)== 'false' ){
                        $isonhtml= 0;
                    }else{
                        $isonhtml= 1;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow= newGetStrCut($s, 'nofollow');
                    if( $nofollow== '1' || lCase($nofollow)== 'true' ){
                        $nofollow= 1;
                    }else{
                        $nofollow= 0;
                    }

                    //�۸�
                    $price= getDianNumb(newGetStrCut($s, 'price'));
                    if( $price== '' ){
                        $price= 0;
                    }
                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'articledetail (parentid,title,titlecolor,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,aboutcontent,bodycontent,updatetime,isonhtml,customaurl,nofollow,target,smallimage,bigImage,bannerimage,templatepath,labletitle,price) values(' . $parentid . ',\'' . $title . '\',\'' . $titlecolor . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $author . '\',' . $sortrank . ',\'' . $adddatetime . '\',\'' . $fileName . '\',\'' . $flags . '\',\'' . $relatedtags . '\',\'' . $aboutcontent . '\',\'' . $bodycontent . '\',\'' . now() . '\',' . $isonhtml . ',\'' . $customaurl . '\',' . $nofollow . ',\'' . $target . '\',\'' . $smallimage . '\',\'' . $bigImage . '\',\'' . $bannerimage . '\',\'' . $templatepath . '\',\'' . $labletitle . '\',' . $price . ')');
                }
            }
        }
    }

    //��ҳ
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'OnePage');
    $content= getDirTxtList($webdataDir . '/OnePage/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('��ҳ', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��webkeywords��') > 0 ){
                    $s= $s . vbCrlf();
                    $title= newGetStrCut($s, 'title');
                    $displaytitle= newGetStrCut($s, 'displaytitle');
                    $webtitle= newGetStrCut($s, 'webtitle');
                    $webkeywords= newGetStrCut($s, 'webkeywords');
                    $webdescription= newGetStrCut($s, 'webdescription');



                    $adddatetime= newGetStrCut($s, 'adddatetime');
                    $fileName= newGetStrCut($s, 'filename');

                    $aboutcontent= newGetStrCut($s, 'aboutcontent');

                    $aboutcontent= contentTranscoding($aboutcontent);
                    $target= newGetStrCut($s, 'target');
                    $templatepath= newGetStrCut($s, 'templatepath');

                    $bodycontent= newGetStrCut($s, 'bodycontent');
                    $bodycontent= contentTranscoding($bodycontent);
                    //�Ƿ���������html
                    $isonhtml= newGetStrCut($s, 'isonhtml');
                    if( $isonhtml== '0' || lCase($isonhtml)== 'false' ){
                        $isonhtml= 0;
                    }else{
                        $isonhtml= 1;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow= newGetStrCut($s, 'nofollow');
                    if( $nofollow== '1' || lCase($nofollow)== 'true' ){
                        $nofollow= 1;
                    }else{
                        $nofollow= 0;
                    }


                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,aboutcontent,bodycontent,nofollow,target,templatepath) values(\'' . $title . '\',\'' . $displaytitle . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $adddatetime . '\',\'' . $fileName . '\',' . $isonhtml . ',\'' . $aboutcontent . '\',\'' . $bodycontent . '\',' . $nofollow . ',\'' . $target . '\',\'' . $templatepath . '\')');
                }
            }
        }
    }

    //����
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'Bidding');
    $content= getDirTxtList($webdataDir . '/Bidding/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��webkeywords��') > 0 ){
                    $s= $s . vbCrlf();
                    $webkeywords= newGetStrCut($s, 'webkeywords');
                    $showreason= newGetStrCut($s, 'showreason');
                    $ncomputersearch= newGetStrCut($s, 'ncomputersearch');
                    $nmobliesearch= newGetStrCut($s, 'nmobliesearch');
                    $ncountsearch= newGetStrCut($s, 'ncountsearch');
                    $ndegree= newGetStrCut($s, 'ndegree');
                    $ndegree= getNumber($ndegree);
                    if( $ndegree== '' ){
                        $ndegree= 0;
                    }
                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values(\'' . $webkeywords . '\',\'' . $showreason . '\',' . $ncomputersearch . ',' . $nmobliesearch . ',' . $ndegree . ')');
                }
            }
        }
    }

    //����ͳ��
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'SearchStat');
    $content= getDirTxtList($webdataDir . '/SearchStat/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����ͳ��', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��title��') > 0 ){
                    $s= $s . vbCrlf();
                    $title= newGetStrCut($s, 'title');
                    $webtitle= newGetStrCut($s, 'webtitle');
                    $webkeywords= newGetStrCut($s, 'webkeywords');
                    $webdescription= newGetStrCut($s, 'webdescription');

                    $customaurl= newGetStrCut($s, 'customaurl');
                    $target= newGetStrCut($s, 'target');
                    $isthrough= newGetStrCut($s, 'isthrough');
                    if( $isthrough== '0' || lCase($isthrough)== 'false' ){
                        $isthrough= 0;
                    }else{
                        $isthrough= 1;
                    }
                    $sortrank= newGetStrCut($s, 'sortrank');
                    if( $sortrank== '' ){ $sortrank= 0 ;}
                    //�Ƿ���������html
                    $isonhtml= newGetStrCut($s, 'isonhtml');
                    if( $isonhtml== '0' || lCase($isonhtml)== 'false' ){
                        $isonhtml= 0;
                    }else{
                        $isonhtml= 1;
                    }
                    //�Ƿ�Ϊnofollow
                    $nofollow= newGetStrCut($s, 'nofollow');
                    if( $nofollow== '1' || lCase($nofollow)== 'true' ){
                        $nofollow= 1;
                    }else{
                        $nofollow= 0;
                    }
                    //call echo("title",title)
                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'SearchStat (title,webtitle,webkeywords,webdescription,customaurl,target,isthrough,sortrank,isonhtml,nofollow) values(\'' . $title . '\',\'' . $webtitle . '\',\'' . $webkeywords . '\',\'' . $webdescription . '\',\'' . $customaurl . '\',\'' . $target . '\',' . $isthrough . ',' . $sortrank . ',' . $isonhtml . ',' . $nofollow . ')');

                }
            }
        }
    }
    $itemid=''; $userName=''; $ip=''; $reply=''; $tableName ='';//����
    //����
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'TableComment');
    $content= getDirTxtList($webdataDir . '/TableComment/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��title��') > 0 ){
                    $s= $s . vbCrlf();

                    $tableName= newGetStrCut($s, 'tablename');
                    $title= newGetStrCut($s, 'title');
                    $itemid= getArticleId(newGetStrCut($s, 'itemid'));
                    if( $itemid== '' ){ $itemid= 0 ;}
                    //call echo("itemID",itemID)
                    $adddatetime= newGetStrCut($s, 'adddatetime');
                    $userName= newGetStrCut($s, 'username');
                    $ip= newGetStrCut($s, 'ip');
                    $bodycontent= newGetStrCut($s, 'bodycontent');
                    $reply= newGetStrCut($s, 'reply');



                    $isthrough= newGetStrCut($s, 'isthrough');
                    if( $isthrough== '0' || lCase($isthrough)== 'false' ){
                        $isthrough= 0;
                    }else{
                        $isthrough= 1;
                    }

                    //call echo("title",title)
                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'TableComment (tablename,title,itemid,adddatetime,username,ip,bodycontent,reply,isthrough) values(\'' . $tableName . '\',\'' . $title . '\',' . $itemid . ',\'' . $adddatetime . '\',\'' . $userName . '\',\'' . $ip . '\',\'' . $bodycontent . '\',\'' . $reply . '\',' . $isthrough . ')');

                }
            }
        }
    }

    //��������
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'FriendLink');
    $content= getDirTxtList($webdataDir . '/FriendLink/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��title��') > 0 ){
                    $s= $s . vbCrlf();

                    $title= newGetStrCut($s, 'title');
                    $httpurl= newGetStrCut($s, 'httpurl');
                    $smallimage= newGetStrCut($s, 'smallimage');
                    $flags= newGetStrCut($s, 'flags');
                    $target= newGetStrCut($s, 'target');


                    $sortrank= newGetStrCut($s, 'sortrank');
                    if( $sortrank== '0' || lCase($sortrank)== 'false' ){
                        $sortrank= 0;
                    }else{
                        $sortrank= 1;
                    }
                    $isthrough= newGetStrCut($s, 'isthrough');
                    if( $isthrough== '0' || lCase($isthrough)== 'false' ){
                        $isthrough= 0;
                    }else{
                        $isthrough= 1;
                    }
                    //call echo("title",title)
                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'FriendLink (title,httpurl,smallimage,flags,sortrank,isthrough,target) values(\'' . $title . '\',\'' . $httpurl . '\',\'' . $smallimage . '\',\'' . $flags . '\',' . $sortrank . ',' . $isthrough . ',\'' . $target . '\')');

                }
            }
        }
    }

    //����
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'GuestBook');
    $content= getDirTxtList($webdataDir . '/GuestBook/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��adddatetime��') > 0 ){
                    $s= $s . vbCrlf();

                    $adddatetime= newGetStrCut($s, 'adddatetime');
                    $bodycontent= newGetStrCut($s, 'bodycontent');
                    $reply= newGetStrCut($s, 'reply');
                    $isthrough= newGetStrCut($s, 'isthrough');
                    if( $isthrough== '0' || lCase($isthrough)== 'false' ){
                        $isthrough= 0;
                    }else{
                        $isthrough= 1;
                    }
                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'GuestBook (adddatetime,bodycontent,reply,isthrough) values(\'' . $adddatetime . '\',\'' . $bodycontent . '\',\'' . $reply . '\',' . $isthrough . ')');

                }
            }
        }
    }


    //�ɼ���վ
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'CaiWeb');
    $content= getDirTxtList($webdataDir . '/CaiWeb/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('�ɼ���վ', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��bigclassname��') > 0 ){
                    $s= $s . vbCrlf();


                    $bigClassName= newGetStrCut($s, 'bigclassname');
                    $httpurl= newGetStrCut($s, 'httpurl');
                    $morepageurl= newGetStrCut($s, 'morepageurl');
                    $charset= newGetStrCut($s, 'charset');


                    $adddatetime= newGetStrCut($s, 'adddatetime');
                    $bodycontent= newGetStrCut($s, 'bodycontent');

                    $sortrank= newGetStrCut($s, 'sortrank');
                    if( $sortrank== '' ){ $sortrank= 0 ;}

                    $thispage= newGetStrCut($s, 'thispage');
                    if( $thispage== '' ){ $thispage= 0 ;}
                    $countpage= newGetStrCut($s, 'countpage');
                    if( $countpage== '' ){ $thispage= 0 ;}

                    $columnname= newGetStrCut($s, 'columnname');



                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'CaiWeb (adddatetime,bodycontent,httpurl,morepageurl,charset,sortrank,thispage,countpage,bigclassname,columnname) values(\'' . $adddatetime . '\',\'' . $bodycontent . '\',\'' . $httpurl . '\',\'' . $morepageurl . '\',\'' . $charset . '\',' . $sortrank . ',' . $thispage . ',' . $countpage . ',\'' . $bigClassName . '\',\'' . $columnname . '\')');

                }
            }
        }
    }


    //�ɼ�����
    connexecute('delete from ' . $GLOBALS['db_PREFIX'] . 'CaiConfig');
    $content= getDirTxtList($webdataDir . '/CaiConfig/');
    $content= contentNameSort($content, '');
    $splStr= aspSplit($content, vbCrlf());
    HR();
    foreach( $splStr as $key=>$filePath){
        $fileName= getFileName($filePath);
        if( $filePath <> '' && inStr('_#', left($fileName, 1))== false ){
            aspEcho('�ɼ�����', $filePath);
            $content= GetFText($filePath);
            //��������Ϊ�˴�GitHub����ʱ����vbcrlfת�� chr(10)  20160409
            if( inStr($content, vbCrlf())== false ){
                $content= replace($content, chr(10), vbCrlf());
            }
            $splxx= aspSplit($content, vbCrlf() . '-------------------------------');
            foreach( $splxx as $key=>$s){
                if( inStr($s, '��bigclassname��') > 0 ){
                    $s= $s . vbCrlf();


                    $bigClassName= newGetStrCut($s, 'bigclassname');
                    $sType= newGetStrCut($s, 'stype');
                    $startStr= newGetStrCut($s, 'startstr');
                    $endStr= newGetStrCut($s, 'endstr');
                    $startaddstr= newGetStrCut($s, 'startaddstr');
                    $endaddstr= newGetStrCut($s, 'endaddstr');

                    $adddatetime= newGetStrCut($s, 'adddatetime');
                    $sortrank= newGetStrCut($s, 'sortrank');
                    if( $sortrank== '' ){ $sortrank= 0 ;}
                    $saction= newGetStrCut($s, 'saction');
                    $isthrough= newGetStrCut($s, 'isthrough');
                    $isthrough= IIF($isthrough== '0' || lCase($isthrough)== 'false', 0, 1);

                    $fieldName= newGetStrCut($s, 'fieldname');
                    $fieldcheck= newGetStrCut($s, 'fieldcheck');
                    if( $fieldcheck== '' ){ $fieldcheck= 0 ;}


                    connexecute('insert into ' . $GLOBALS['db_PREFIX'] . 'CaiConfig (adddatetime,sortrank,bigclassname,stype,startstr,endstr,startaddstr,endaddstr,saction,isthrough,fieldname,fieldcheck) values(\'' . $adddatetime . '\',' . $sortrank . ',\'' . $bigClassName . '\',\'' . $sType . '\',\'' . $startStr . '\',\'' . $endStr . '\',\'' . $startaddstr . '\',\'' . $endaddstr . '\',\'' . $saction . '\',' . $isthrough . ',\'' . $fieldName . '\',' . $fieldcheck . ')');

                }
            }
        }
    }


    writeSystemLog('', '�ָ�Ĭ������' . $GLOBALS['db_PREFIX']); //ϵͳ��־

}

?>