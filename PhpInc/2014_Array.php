<?PHP
//���ݴ�������

//ɾ��������#���б�(20150818)
function remoteContentJingHao($content, $splType){
    $splStr=''; $s=''; $c ='';
    $splStr = aspSplit($content, $splType) ;
    foreach( $splStr as $s){
        if( substr(phpTrim($s), 0 , 1) <> '#' && substr(phpTrim($s), 0 , 1) <> '_' ){
            if( $c <> '' ){ $c = $c . $splType ;}
            $c = $c . $s ;
        }
    }
    $remoteContentJingHao = $c ;
    return @$remoteContentJingHao;
}
//ɾ��������#�Ż����_���б�(20150818)
function remoteArrayJingHao($splStr){
    $s=''; $c=''; $splType ='';
    $splType = '[|-|_]' ;
    foreach( $splStr as $s){
        if( substr(phpTrim($s), 0 , 1) <> '#' && substr(phpTrim($s), 0 , 1) <> '_' ){
            if( $c <> '' ){ $c = $c . $splType ;}
            $c = $c . $s ;
        }
    }
    $splStr = aspSplit($c, $splType) ;
    $remoteArrayJingHao = $splStr ;
    return @$remoteArrayJingHao;
}

//ÿ���ַ���ָ��ֵ
function getEachStrAddValue($content, $valueStr){
    $i=''; $s=''; $c ='';
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $c = $c . $s . $valueStr ;
    }
    $getEachStrAddValue = $c ;
    return @$getEachStrAddValue;
}
//���ֵ��������λ�� 20150708
function getValueInArrayID($splStr, $valueStr){
    $i ='';
    $getValueInArrayID = -1 ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        if( $splStr[$i] == $valueStr ){
            $getValueInArrayID = $i ;
            break;
        }
    }
    return @$getValueInArrayID;
}
//�ж�ֵ�Ƿ���������
function checkValueInArray($splStr, $valueStr){
    $i ='';
    $checkValueInArray = false ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        if( $splStr[$i] == $valueStr ){
            $checkValueInArray = true ;
            break;
        }
    }
    return @$checkValueInArray;
}

//ɾ���ظ�����  20141220
function deleteRepeatArray($splStr){
    $SplType=''; $s=''; $c ='';
    $SplType = '[|-|_]' ;
    foreach( $splStr as $s){
        if( $s <> '' ){
            if( instr($SplType . $c . $SplType, $SplType . $s . $SplType) == false ){
                $c = $c . $s . $SplType ;
            }
        }
    }
    if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - strlen($SplType)) ;}
    $splStr = aspSplit($c, $SplType) ;
    $deleteRepeatArray = $splStr ;
    return @$deleteRepeatArray;
}
//ɾ���ظ����� �Զ��ָ����� 20150724
function deleteRepeatContent($content, $splType){
    $splStr=''; $s=''; $c ='';
    $splStr = aspSplit($content, $splType) ;
    foreach( $splStr as $s){
        if( $s <> '' ){
            if( instr($splType . $c . $splType, $splType . $s . $splType) == false ){
                if( $c <> '' ){ $c = $c . $splType ;}
                $c = $c . $s ;
            }
        }
    }
    $deleteRepeatContent = $c ;
    return @$deleteRepeatContent;
}

//�����������
function getArrayCount($content, $SplC){
    $splStr ='';
    if( instr($content, $SplC) > 0 ){
        $splStr = aspSplit($content, $SplC) ;
        $getArrayCount = UBound($splStr) + 1 ;
    }else{
        $getArrayCount = 0 ;
    }
    return @$getArrayCount;
}
//�����ʾ���� RandomShow("1,2,3,4,5,6,7,8,9", ",", 2)
function randomShow($content, $SplType, $NSwitch){
    $splStr=''; $s=''; $c=''; $n=''; $i ='';

    for( $i = 1 ; $i<= $NSwitch; $i++){
        $splStr = aspSplit($content, $SplType) ;
        foreach( $splStr as $s){
            $n = intval(rnd() * 100) ;
            if( $n > 50 ){
                $c = $c . $s . $SplType ;
            }else{
                $c = $s . $SplType . $c ;
            }
            //Call Echo(S,N)
        }
        if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - strlen($SplType)) ;}
        $content = $c ;
        $c = '' ;
    }
    //Call Echo("C",C)
    $randomShow = $content ;
    return @$randomShow;
}
//���������ʾ ArrayRandomShow("1,2,3,4,5,6,7,8,9", 2)
function arrayRandomShow( $splStr, $NSwitch){
    $s=''; $c=''; $n=''; $i=''; $SplType ='';
    $SplType = '[|-|_]' ;

    for( $i = 1 ; $i<= $NSwitch; $i++){
        foreach( $splStr as $s){
            $n = intval(rnd() * 100) ;
            if( $n > 50 ){
                $c = $c . $s . $SplType ;
            }else{
                $c = $s . $SplType . $c ;
            }
            //Call Echo(S,N)
        }
        if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - strlen($SplType)) ;}
        $splStr = aspSplit($c, $SplType) ; $c = '' ;
    }
    $arrayRandomShow = $splStr ;
    return @$arrayRandomShow;
}
//��ӡ��������
function printArray($splStr){
    $i=''; $s ='';
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        $s = $splStr[$i] ;
        ASPEcho($i, $s) ;
    }
}
//��ʾ��������  (��������)
function echoArray($splStr){
    PrintArray($splStr) ;
}
//���ش��Һ���ַ�����Shuffle=ϴ��  2014 12 02
function PHPStr_Shuffle($content){
    $i=''; $s=''; $c=''; $n ='';

    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        if( $c == '' ){
            $c = $s ;
        }else if( strlen($c) == 1 ){
            $n = intval(rnd() * 100) ;
            if( $n > 50 ){
                $c = $c . $s ;
            }else{
                $c = $s . $c ;
            }
        }else{
            $n = intval(rnd() * strlen($c)) + 1 ;
            $c = mid($c, 1, $n) . $s . mid($c, $n + 1,-1) ;
        }
    }
    $PHPStr_Shuffle = $c ;
    return @$PHPStr_Shuffle;
}
//�ַ�����
function characterUpset($content){
    $characterUpset = PHPStr_Shuffle($content) ;
    return @$characterUpset;
}
//���ַ���ת��Ϊ����   PHP���õ�����ʱ����   �������뼸���ַ��ָ������  ��  abcefg,2     0=ab 1=ce 2=fg
function PHPStr_Split($content, $Split_Length){
    $i=''; $s=''; $c=''; $n=''; $ArrStr=array(99); $nArray ='';
    if( $Split_Length <= 0 ){ $Split_Length = 1 ;}
    $n = 0 ; $nArray = 0 ;
    for( $i = 1 ; $i<= strlen($content); $i++){
        $s = mid($content, $i, 1) ;
        $c = $c . $s ;
        $n = $n + 1 ;
        if( $n == $Split_Length ){
            $ArrStr[$nArray] = $c ;
            $c = '' ; $n = 0 ;
            $nArray = $nArray + 1 ;
        }
    }
    $PHPStr_Split = $ArrStr ;
    return @$PHPStr_Split;
}
//�Ƴ���ֵ����
function removeNullValueArray($content, $SplType){
    $removeNullValueArray = HandleArray($content, $SplType, 'nonull') ;
    return @$removeNullValueArray;
}
//�Ƴ��ظ�����
function removeRepeatValueArray($content, $SplType){
    $removeRepeatValueArray = HandleArray($content, $SplType, 'norepeat') ;
    return @$removeRepeatValueArray;
}
//��������
function handleArray($content, $SplType, $SType){
    $splStr=''; $s=''; $c=''; $OKYes ='';
    $SType = '|' . LCase($SType) . '|' ;
    $splStr = aspSplit($content, $SplType) ;
    foreach( $splStr as $s){
        $OKYes = true ;
        if( instr($SType, '|nonull|') > 0 && $OKYes == true ){
            if( $s == '' ){ $OKYes = false ;}
        }
        if( instr($SType, '|norepeat|') > 0 && $OKYes == true ){
            if( instr($SplType . $c . $SplType, $SplType . $s . $SplType) > 0 ){ $OKYes = false ;}
        }
        if( $OKYes == true ){ $c = $c . $s . $SplType ;}
    }
    if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - strlen($SplType)) ;}
    $handleArray = $c ;
    return @$handleArray;
}
//����ת�ַ�(20151124)
function arrayToString($splStr, $addtoStr){
    $s=''; $c ='';
    foreach( $splStr as $s){
        if( $s <> '' ){
            $c = $c . $s . $addtoStr ;
        }
    }
    $arrayToString = $c ;
    return @$arrayToString;
}
//������������ 20141217
function testArrayData(){
    $aData ='';
    $aData = array(3, 2, 4, 1, 6, 0) ;
    ResponseArray($aData, 'ԭ��˳��') ;
    ResponseArray(SelectSort($aData), 'ѡ������') ;
    ResponseArray(QuickSort($aData), '��������') ;
    ResponseArray(InsertSort($aData), '��������') ;
    ResponseArray(BubbleSort($aData), 'ð������') ;
    ResponseArray(ReQuickSort($aData), '��������') ;
    echo '<b>�� �� ֵ��</b>' . $GLOBALS['PHPMax']($aData) . '<hr>' ;
    echo '<b>�� С ֵ��</b>' . $GLOBALS['PHPMin']($aData) . '<hr>' ;
}
//===================================
//ѡ������
//===================================
function selectSort($a_Data){
    $i=''; $j=''; $k ='';
    $bound=''; $t ='';
    $bound = UBound($a_Data) ;

    for( $i = 0 ; $i<= $bound - 1; $i++){
        $k = $i ;
        for( $j = $i + 1 ; $j<= $bound; $j++){
            if( $a_Data[$k] > $a_Data[$j] ){
                $k = $j ;
            }
        }
        $t = $a_Data[$i] ;
        $a_Data[$i] = $a_Data[$k] ;
        $a_Data[$k] = $t ;
    }
    $selectSort = $a_Data ;
    return @$selectSort;
}
//===================================
//��������
//===================================
function quickSort($a_Data){
    $i=''; $j ='';
    $bound=''; $t ='';
    $bound = UBound($a_Data) ;
    for( $i = 0 ; $i<= $bound - 1; $i++){
        for( $j = $i + 1 ; $j<= $bound; $j++){
            if( $a_Data[$i] > $a_Data[$j] ){
                $t = $a_Data[$i] ;
                $a_Data[$i] = $a_Data[$j] ;
                $a_Data[$j] = $t ;
            }
        }
    }
    $quickSort = $a_Data ;
    return @$quickSort;
}
//===================================
//ð������
//===================================
function bubbleSort($a_Data){
    $bound ='';
    $bound = UBound($a_Data) ;
    $bSorted=''; $i=''; $t ='';
    $bSorted = false ;
    while( $bound > 0 && $bSorted = false){
        $bSorted == true ;
        for( $i = 0 ; $i<= $bound - 1; $i++){
            if( $a_Data[$i] > $a_Data[$i + 1] ){
                $t = $a_Data[$i] ;
                $a_Data[$i] = $a_Data[$i + 1] ;
                $a_Data[$i + 1] = $t ;
                $bSorted = false ;
            }
        }
        $bound = $bound - 1 ;
    }

    $bubbleSort = $a_Data ;
    return @$bubbleSort;
}
//===================================
//��������
//===================================
function insertSort($a_Data){
    $bound ='';
    $bound = UBound($a_Data) ;
    $i=''; $j=''; $t ='';

    for( $i = 1 ; $i<= $bound; $i++){
        $t = $a_Data[$i] ;
        $j = $i ;
        while( $t < $a_Data[$j - 1] && $j > 0){
            $a_Data[$j] = $a_Data[$j - 1] ;
            $j = $j - 1 ;
        }
        $a_Data[$j] = $t ;
    }
    $insertSort = $a_Data ;
    return @$insertSort;
}
//===================================
//��������-��������
//===================================
function reQuickSort($a_Data){
    $i=''; $Bound=''; $TempArr ='';
    $a_Data = quickSort($a_Data) ;
    $TempArr = quickSort($a_Data) ;
    $Bound = UBound($a_Data) ;
    for( $i = 0 ; $i<= $Bound; $i++){
        $a_Data[$i] = $TempArr[$Bound - $i] ;
    }
    $reQuickSort = $a_Data ;
    return @$reQuickSort;
}
//���鷴��
function arrayReverse(){
    $arrayReverse = reQuickSort($GLOBALS['a_Data']) ;
    return @$arrayReverse;
}
//===================================
//�������
//===================================
function responseArray($a_Data, $str){
    $s=''; $i ='';
    $s = '' ;
    echo '<b>' . $str . '��</b>' ;
    for( $i = 0 ; $i<= UBound($a_Data); $i++){
        $s = $s . $a_Data[$i] . ',' ;
    }
    $s = substr($s, 0 , strlen($s) - 1) ;
    echo $s ;
    echo '<hr>' ;
}
//===================================
//���������ֵ
//===================================
function PHPMax($a_Data){
    $i=''; $j=''; $Bound=''; $temp ='';
    $a_Data = quickSort($a_Data) ;
    $Bound = UBound($a_Data) ;
    for( $i = 0 ; $i<= $Bound; $i++){
        for( $j = $i + 1 ; $j<= $Bound; $j++){
            if( $a_Data[$j] > $a_Data[$i] ){
                $temp = $a_Data[$i] ;
                $a_Data[$i] = $a_Data[$j] ;
                $a_Data[$j] = $temp ;
            }
        }
    }
    $PHPMax = $a_Data[0] ;
    return @$PHPMax;
}
//===================================
//��������Сֵ
//===================================
function PHPMin($a_Data){
    $i=''; $j=''; $Bound=''; $temp ='';
    $a_Data = quickSort($a_Data) ;
    $Bound = UBound($a_Data) ;
    for( $i = 0 ; $i<= $Bound; $i++){
        for( $j = $i + 1 ; $j<= $Bound; $j++){
            if( $a_Data[$j] > $a_Data[$i] ){
                $temp = $a_Data[$i] ;
                $a_Data[$i] = $a_Data[$j] ;
                $a_Data[$j] = $temp ;
            }
        }
    }
    $PHPMin = $a_Data[$Bound] ;
    return @$PHPMin;
}




//���Զ�ά������ʾ
function testTwoDimensionalArray(){
    $splStr=''; $i ='';
    $splStr = HandleSplitArray('9-g|2-b|3-a|1-��', '|', '-') ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        ASPEcho($splStr[$i][ 1], $splStr[$i][ 0]) ; Doevents ;
    }
    ASPEcho('', '�����') ;
    TwoDimensionalArrayAsc($splStr) ;//��ά����������
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        ASPEcho($splStr[$i][ 1], $splStr[$i][ 0]) ; Doevents ;
    }
    ASPEcho('', 'Desc') ;
    TwoDimensionalArrayDesc($splStr) ;//��ά���鵹����
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        ASPEcho($splStr[$i][ 1], $splStr[$i][ 0]) ; Doevents ;
    }
}

//����ָ��ά���� 20150313
function handleSplitArray($content, $SplOneType, $SplTowType){
    $SplA=''; $SplB=''; $splStr=''; $splxx=''; $i=''; $s=''; $c=''; $j=''; $t=''; $SplType ='';
    $SplType = '[|Array|]' ;
    $splStr = aspSplit($content, $SplOneType) ;
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        if( $splStr[$i] <> '' ){
            $splxx = aspSplit($splStr[$i], $SplTowType) ;
            $SplA = $SplA . $splxx[0] . $SplType ;
            $SplB = $SplB . $splxx[1] . $SplType ;
        }
    }
    if( $SplA <> '' ){ $SplA = substr($SplA, 0 , strlen($SplA) - strlen($SplType)) ;}
    if( $SplB <> '' ){ $SplB = substr($SplB, 0 , strlen($SplB) - strlen($SplType)) ;}
    $SplA = aspSplit($SplA, $SplType) ;
    $SplB = aspSplit($SplB, $SplType) ;

    $splStr[UBound($SplA)][ UBound($SplB)] ;
    for( $i = 0 ; $i<= UBound($SplA); $i++){
        $splStr[$i][ 0] = $SplA[$i] ;
        $splStr[$i][ 1] = $SplB[$i] ;
    }
    $handleSplitArray = $splStr ;
    return @$handleSplitArray;
}
//��ά���������� 20150313
function twoDimensionalArrayAsc($splStr){
    $i=''; $j=''; $t ='';
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        if( IsNul($splStr[$i][ 0]) == false ){
            for( $j = $i ; $j<= UBound($splStr); $j++){
                if( $splStr[$i][ 0] > $splStr[$j][ 0] ){
                    $t = $splStr[$i][ 0] ;
                    $splStr[$i][ 0] = $splStr[$j][ 0] ;
                    $splStr[$j][ 0] = $t ;
                    $t = $splStr[$i][ 1] ;
                    $splStr[$i][ 1] = $splStr[$j][ 1] ;
                    $splStr[$j][ 1] = $t ;
                }
            }
        }
    }
    $twoDimensionalArrayAsc = $splStr ;
    return @$twoDimensionalArrayAsc;
}
//��ά���鵹���� 20150313
function twoDimensionalArrayDesc($splStr){
    $i=''; $j=''; $t ='';
    for( $i = 0 ; $i<= UBound($splStr); $i++){
        if( IsNul($splStr[$i][ 0]) == false ){
            for( $j = $i ; $j<= UBound($splStr); $j++){
                if( $splStr[$i][ 0] < $splStr[$j][ 0] ){
                    $t = $splStr[$i][ 0] ;
                    $splStr[$i][ 0] = $splStr[$j][ 0] ;
                    $splStr[$j][ 0] = $t ;
                    $t = $splStr[$i][ 1] ;
                    $splStr[$i][ 1] = $splStr[$j][ 1] ;
                    $splStr[$j][ 1] = $t ;
                }
            }
        }
    }
    $twoDimensionalArrayDesc = $splStr ;
    return @$twoDimensionalArrayDesc;
}
?>

