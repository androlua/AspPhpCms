<?php 
/************************************************************
���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
��Ȩ��Դ���빫����������;�������ʹ�á� 
������2016-03-11
��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?php
// ��ȡ�ļ�
function reaFile($file) {
	$file = handlePath ( $file );
	if (@is_file ( $file ) == false) {
		return "";
	} else {
		$data = file_get_contents ( $file );
		
		//�ж��Ƿ���BOM,����ȥ����  ����ûɶ���ã�������(20151201)
		/*
		$charset[1] = substr($data, 0, 1);
		$charset[2] = substr($data, 1, 1);
		$charset[3] = substr($data, 2, 1);
		if (ord($charset[1]) == 239 && ord($charset[2]) == 187 && ord($charset[3]) == 191) {
			$data = substr($data, 3);
		}
		*/		
		return $data; 
	}
}
// &&&�����ļ����������棩
function getFText($file) {
	$file = handlePath ( $file );
	return reaFile ( $file );
}
// &&&�����ļ����������棩
function getFileText($file) {
	$file = handlePath ( $file );
	return reaFile ( $file );
}
//��UTF-8��ʽ���ļ���20151201��
function getFTextUTF($file){
	return toUTFChar(getFText($file));
}

// �����ļ�
function AspSaveFile($file, $text) {
	$file = handlePath ( $file );
	if (! $file || ! $text) {
		return false;
	}
	if (makeDir ( dirname ( $file ) )) {
		if ($fp = @fopen ( $file, "w" )) {
			if (@fwrite ( $fp, $text )) {
				fclose ( $fp );
				return true;
			} else {
				fclose ( $fp );
				return false;
			}
		}
	}
	return false;
}
// &&&�����ļ�
function createFile($file, $text) {
	return AspSaveFile ( $file, $text );
}
// &&&�����ļ� Ĭ�Ͼ���GBK�ļ����������û�ж���һ��
function createFileGBK($file, $text) {
	return AspSaveFile ( $file, $text );
}
// �����ۼ��ļ�
function addToFile($file, $text) {
	$file = handlePath ( $file );
	if (file_exists ( $file ) == true) {
		$text = @file_get_contents ( $file ) . $text;
	}
	aspSaveFile ( $file, $text );
}
// &&&�����ۼ��ļ����������棩
function createAddFile($file, $text) {
	addToFile ( $file, $text );
}
// &&&�����ۼ��ļ����������棩
function createAddUpFile($file, $text) {
	addToFile ( $file, $text );
}

//����UTF�ļ�����BOM
function createUTFFile($file,$content){
	$file = handlePath ( $file );
	echo('fileName='.$file);
	$content=toUTFChar($content);  //תutf-8����
	$f=fopen($file, "wb");
	fputs($f, "\xEF\xBB\xBF".'��');		//���ɵ��ļ�����ΪUTF-8��ʽ
	fclose($f);
	delFileBOM($file,$content); 
} 
//����UTF�ļ�����BOM  ��������
function createFileUTF($file,$content){
	createUTFFile($file,$content);
}


//ɾ��utf-8��BOM
function delFileBOM($file,$content="") {
	$file = handlePath ( $file );
	$contents = file_get_contents($file);
	$charset[1] = substr($contents, 0, 1);
	$charset[2] = substr($contents, 1, 1);
	$charset[3] = substr($contents, 2, 1);
	if (ord($charset[1]) == 239 && ord($charset[2]) == 187 && ord($charset[3]) == 191) {
		if($content==""){
			$content=substr($contents, 3);
		} 
		rewrite ($file, $content);
		return true;
	
	}else{
		return false;
	}
}
//��д
function rewrite($file, $data) {
	$file = handlePath ( $file );
	$filenum = fopen($file, "w");
	flock($filenum, LOCK_EX);
	fwrite($filenum, $data);
	fclose($filenum);
} 

// ����ļ�
function checkFile($file) {
	$file = handlePath ( $file );
	return is_file ( $file );
}
// &&&����ļ����������棩
function existsFile($file) {
	$file = handlePath ( $file );
	return checkFile ( $file );
}
// ɾ���ļ�
// ʹ�� @ �������δ�����Ϣ��������� ulink ���Ҫɾ�����ļ���·�������ڻ�����ʾ��Ϣ�����ܻᱩ¶ϵͳһЩ��������֪������Ϣ������ @ ����Թ��ⲿ����Ϣ�������
function delFile($file) {
	$file = handlePath ( $file );
	return @unlink ( $file );
}
// &&&ɾ���ļ����������棩
function deleteFile($file) {
	return delFile ( $file );
}
// �ƶ��ļ�
function moveFile($file, $newfile) {
	$file = handlePath ( $file );
	$newfile = handlePath ( $newfile );
	return rename ( $file, $newfile );
}
// �����ļ�
function copyFile($file, $newfile) {
	$file = handlePath ( $file );
	$newfile = handlePath ( $newfile );
	//aspecho($file, $newfile);
	return copy ( $file, $newfile );
}
// ����ļ���С
function getFileSize($file) {
	$file = handlePath ( $file );
	return filesize ( $file );
}
function getFsize($file) {
	return getFileSize ( $file );
}

// ���ļ�������
// �����ļ���
function createFolder($folderPath) {
	$folderPath = handlePath ( $folderPath );
	@mkdir ( $folderPath );
}
// ��������Ŀ¼
function makeDir($dir, $mode = "0777") {
	$dir = handlePath ( $dir );
	if (!$dir) {
		return false;
	}
	if (! file_exists ( $dir )) {
		return @mkdir ( $dir, $mode, true );
	} else {
		return true;
	}
}
// &&&��������Ŀ¼���������棩
function CreateDirFolder($dir) {
	makeDir ( $dir );
}
// ����ļ���
function checkFolder($dir) {
	$dir = handlePath ( $dir );
	return @is_dir ( $dir );
}
// �ƶ��ļ��� (ֱ�����ƶ��ļ������Ϳ�����)
function moveFolder($file, $newfile) {
	$file = handlePath ( $file ); 
	$newfile = handlePath ( $newfile );
	return rename ( $file, $newfile );
}
// �����ļ��� ���ñ���
function copyFolder($src,$des) {	
	$src = handlePath ( $src ); 
	$des = handlePath ( $des ); 
    $dir = opendir($src);
    @mkdir($des);
    while(false !== ( $file = readdir($dir)) ) {
        if (( $file != '.' ) && ( $file != '..' )) {
            if ( is_dir($src . '/' . $file) ) {
                copyFolder($src . '/' . $file,$des . '/' . $file);
            } else {
                copy($src . '/' . $file,$des . '/' . $file);
            }
        }
    }
} 
// ɾ���ļ���
// ˵����ֻ��ɾ���ǿյ�Ŀ¼�����������ɾ��Ŀ¼�µ���Ŀ¼���ļ�����ɾ����Ŀ¼
function deleteFolder($dir) {
	$dir = handlePath ( $dir ); 
	if(is_dir($dir)){
		return @rmdir ( $dir );
	}
}

// ���ļ��ļ��С�
function getFileFolderList($folderPath,$c='',$action='|�����ļ�#|�����ļ���|�ļ�����|�ļ�������|ѭ���ļ���|',$fileTypeList='|*|') {
    $folderPath = handlePath ( $folderPath );
    $fso = @opendir ( $folderPath );
    if ($fso) {
        while (($file = readdir($fso)) !== false) {
            if ($file != '.' && $file != '..'){
                $ffPath=$folderPath."\\".$file;
				//Ϊ�ļ���
                if (is_dir($ffPath)) {
					if (strstr('|' . $action . '|', '|�����ļ���|')){
						if (strstr('|' . $action . '|', '|�ļ�������|')){
							$s=$file;						
						}else{
							$s=handlePath($ffPath);
						}
						$c=$c .$s.vbCrlf() ;
					}
					if (strstr('|' . $action . '|', '|ѭ���ļ���|')){
						//aspecho('$ffPath',$ffPath);
						$tempC=getFileFolderList($ffPath,"",$action,$fileTypeList);
						if($tempC!=''){
							$tempC=$tempC.vbCrlf();
						}
						$c=$c . $tempC;
					}
                }elseif (strstr('|' . $action . '|', '|�����ļ�|')){
					$fileType=strtolower(substr(strrchr($file, '.'), 1));
					if (strstr('|' . $action . '|', '|�ļ�����|')){
						$s=$file;
					}elseif (strstr('|' . $action . '|', '|�ļ�����|')){
						$s=$fileType;
					}else{
						$s=handlePath($ffPath);
					}
					if (strstr('|' . $fileTypeList . '|', '|'.$fileType.'|') || strstr('|' . $fileTypeList . '|', '|*|')){
                   		$c=$c . $s. vbCrlf();				
					}
                }
            }
        }
        closedir($fso);
    }
	if( $c <> '' ){ $c = substr($c, 0 , strlen($c) - 2) ;}
    return $c;
}
/*
//��õ�ǰ�ļ����б�
function getDirFolderNameList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ���|�ļ�������|');
}
//��õ�ǰ�ļ����б�
function getThisFolderList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ���|');
}
//���ȫ���ļ����б�
function getAllFolderList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ���|ѭ���ļ���|');
}
//��õ�ǰ�ļ��б�
function getThisFileList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|');
}
//���ȫ���ļ��б�
function getAllFileList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|ѭ���ļ���|');
}
//��õ�ǰHtml�ļ��б�
function getThisHtmlFileList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|','|html|htm|');
}
//���ȫ��Html�ļ��б�
function getAllHtmlFileList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|ѭ���ļ���|','|html|htm|');
}
//��õ�ǰ�ļ�����html�������Ʒ�ʽ��ʾ     ��ASPƥ��
function getDirHtmlNameList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|�ļ�����|','|html|');
}

  
//���ȫ��Php�ļ��б�
function getAllPhpFileList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|ѭ���ļ���|','|php|');
}
//��õ�ǰtxt�ļ��б�
function getDirTxtList($folderPath){
	return getFileFolderList($folderPath,'','|�����ļ�|','|txt|');
}
 
*/

//��õ�ǰĿ¼��ȫ��Jpg�ļ�
function getDirJpgList($folderPath){
	return getDirFileList($folderPath, 'jpg');
}
//��õ�ǰĿ¼��ȫ��Png�ļ�
function getDirPngList($folderPath){
	return getDirFileList($folderPath, 'png');
}
//��õ�ǰĿ¼��ȫ��Ini�ļ�
function getDirIniList($folderPath){
	return getDirFileList($folderPath, 'ini');
}
//��õ�ǰĿ¼��ȫ��Txt�ļ�
function getDirTxtList($folderPath){
	return getDirFileList($folderPath, 'txt');
}
//��õ�ǰĿ¼��ȫ��Js�ļ�
function getDirJsList($folderPath){
	return getDirFileList($folderPath, 'js');
}
//��õ�ǰĿ¼��ȫ��Css�ļ�
function getDirCssList($folderPath){
	return getDirFileList($folderPath, 'css');
}
//��õ�ǰĿ¼��ȫ��Html�ļ�
function getDirHtmlList($folderPath){
	return getDirFileList($folderPath, 'html');
}
//��õ�ǰĿ¼��ȫ��asp�ļ�
function getDirAspList($folderPath){
	return getDirFileList($folderPath, 'asp');
}
//��õ�ǰĿ¼��ȫ��Php�ļ�
function getDirPhpList($folderPath){
	return getDirFileList($folderPath, 'php');
}
//��õ�ǰĿ¼�������ļ��б�
function getDirFileList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|�����ļ�|','|'.$fileTypeList.'|');
} 




//��õ�ǰĿ¼��ȫ��Jpg�ļ�����
function getDirJpgNameList($folderPath){
	return getDirFileNameList($folderPath, 'jpg');
}
//��õ�ǰĿ¼��ȫ��Png�ļ�����
function getDirPngNameList($folderPath){
	return getDirFileNameList($folderPath, 'png');
}
//��õ�ǰĿ¼��ȫ��Ini�ļ�����
function getDirIniNameList($folderPath){
	return getDirFileNameList($folderPath, 'ini');
}
//��õ�ǰĿ¼��ȫ��Txt�ļ�����
function getDirTxtNameList($folderPath){
	return getDirFileNameList($folderPath, 'txt');
}
//��õ�ǰĿ¼��ȫ��Js�ļ�����
function getDirJsNameList($folderPath){
	return getDirFileNameList($folderPath, 'js');
}
//��õ�ǰĿ¼��ȫ��Css�ļ�����
function getDirCssNameList($folderPath){
	return getDirFileNameList($folderPath, 'css');
}
//��õ�ǰĿ¼��ȫ��Html�ļ�����
function getDirHtmlNameList($folderPath){
	return getDirFileNameList($folderPath, 'html');
}
//��õ�ǰĿ¼��ȫ��asp�ļ�����
function getDirAspNameList($folderPath){
	return getDirFileNameList($folderPath, 'asp');
}
//��õ�ǰĿ¼��ȫ��Php�ļ�����
function getDirPhpNameList($folderPath){
	return getDirFileNameList($folderPath, 'php');
}
//��õ�ǰĿ¼�������ļ������б�
function getDirFileNameList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|�����ļ�|�ļ�����|','|'.$fileTypeList.'|');
}


 //��õ�ǰĿ¼�������ļ��б�
function getDirAllFileList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|�����ļ�|ѭ���ļ���|hidefolderlist|','|'.$fileTypeList.'|');
} 
//��õ�ǰĿ¼�������ļ������б�
function getDirAllFileNameList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|�����ļ�|�ļ�����|ѭ���ļ���|hidefolderlist|','|'.$fileTypeList.'|');
}

//��õ�ǰĿ¼���ļ���
function getDirFolderList($folderPath){ 
	return getFileFolderList($folderPath,'','|�����ļ���|');
}
//��õ�ǰĿ¼���ļ���
function getDirFolderNameList($folderPath){ 
	return getFileFolderList($folderPath,'','|�����ļ���|�ļ�������|');
}
//��õ�ǰĿ¼��ȫ���ļ���
function getDirAllFolderList($folderPath){ 
	return getFileFolderList($folderPath,'','|�����ļ���|ѭ���ļ���|');
}
//��õ�ǰĿ¼��ȫ���ļ���
function getDirAllFolderNameList($folderPath){ 
	return getFileFolderList($folderPath,'','|�����ļ���|ѭ���ļ���|�ļ�������|');
}
 


// ����ļ��ļ��� �����������Ҳ��
function checkFileFolder($path) {
	$path = handlePath ( $path );
	return file_exists ( $path );
}

// ����������
// ����ռ��С
function checkSize($size) {
	$size = floatval ( $size );
	$rate_k = 1024;
	$rate_m = 1024 * 1024;
	$rate_g = 1024 * 1024 * 1024;
	$new_size = $size / $rate_g;
	if ($new_size < 1) {
		$new_size = $size / $rate_m;
		if ($new_size < 1) {
			$new_size = round ( $size / $rate_k, 2 ) . 'K';
			if ($new_size == '0K') {
				$new_size = "N/A";
			}
		} else
			$new_size = round ( $new_size, 2 ) . 'M';
	} else
		$new_size = round ( $new_size, 2 ) . 'G';
	return $new_size;
}
// ����ռ��С ���������棩
function printSpaceValue($size) {
	return checkSize ( $size );
}
// ����ռ��С ���������棩
function printSpaceSize($size) {
	return checkSize ( $size );
}
// PHP��ȡ�ļ���չ������׺��
function getExtension($file) {
	$myext = substr ( $file, strrpos ( $file, '.' ) );
	return str_replace ( '.', '', $myext );
}

//�ж��Ƿ�Ϊ��дĿ¼
function is_writable_dir($dir,$chmod=true) {
	if(!is_dir($dir)) {
		@mkdir($dir, 0777);
	}
	if(is_dir($dir)) {
		if($fp = @fopen("$dir/test.txt", 'w')) {
			@fclose($fp);
			@unlink("$dir/test.txt");
			return true;
		} 
		elseif($chmod) {
			@chmod($dir,0777);
			return is_writeable_dir($dir,false);
		}
		else 
			return false;
	}
}







// ========================================= ������ =========================================

// ��������·��
function handlePath($path) {
	$path = str_replace ( '/', '\\', $path ); 
	if (! strpos ( $path, ":" )) {
		if (substr ( $path, 0, 1 ) != "\\") {
			//�Զ��嵱ǰĿ¼
			if(isset($GLOBALS['ThisDirName'])){
				$path = $GLOBALS['ThisDirName']. "\\" . $path;
			}else{			
				if (defined('WEBPATH')) {
					$path = WEBPATH . "\\" . $path; 
				}else{				
					$path = dirname ( __FILE__ ) . "\\" . $path;	 
				}
			} 
		} else {
			$path = $_SERVER ['DOCUMENT_ROOT'] . "\\" . $path; 
		}
	}
	$path = str_replace ( '/', '\\', $path );
	$path = str_replace ( '\\\\', '\\', $path );
	$path = fullPath ( $path );
	return $path;
}
// ����·��
function fullPath($path) {
	$C = "";
	$path = str_replace ( '/', '\\', $path );
	$Str = explode ( '\\', $path );
	for($i = 0; $i < count ( $Str ); $i ++) {
		$S = $Str [$i];
		if ($S == '..') {
			$C = substr ( $C, 0, strrpos ( $C, "\\" ) );
		} elseif ($S != '.') {
			if ($C != "") {
				$C = $C . "\\";
			}
			$C = $C . $S;
		}
	}
	return str_replace ( '\\\\', '\\', $C );
}

//�ļ����������20150124  ����0Ϊ�ļ�·��   1Ϊ�ļ�����  2Ϊȥ���ļ������ļ�����   3Ϊ�ļ����ͺ�׺��
/* �÷�
	$arr=HandleFilePathArray($filePath);				
	echo('$FilePath='.$arr[0].'<hr>');					//..\UploadFiles\testimages2015.jpg
	echo('$FileDir='.$arr[1].'<hr>');					//..\UploadFiles\
	echo('$FileName='.$arr[2].'<hr>');					//testimages2015.jpg
	echo('$FileNoTypeName='.$arr[3].'<hr>');			//testimages2015
	echo('$FileType='.$arr[4].'<hr>');					//jpg
	
*/
function handleFilePathArray($FilePath){
	$FilePath = handlePath($FilePath);	
	$FileDir = substr($FilePath,0,strrpos($FilePath,"\\")+1);
	$FileName = substr($FilePath,strrpos($FilePath,"\\")+1);
	$FileNoTypeName = substr($FileName,0,strrpos($FileName,".") );
	$FileType = substr($FileName,strrpos($FileName,".")+1);		
	return array($FilePath,$FileDir,$FileName,$FileNoTypeName,$FileType);
}	
//��ô������ļ�����
function getStrFileName( $filePath){
	$arrayData=handleFilePathArray($filePath);
    $getStrFileName = $arrayData[2] ;
    return @$getStrFileName;
}
//��ô������ļ�����  ��������
function getFileName($filePath){
	return getStrFileName( $filePath);
}
//����ļ�����  handleFilePathArray($filePath)(3)  ��PHP5.2.7�������ò��˵ģ���20160216
function getFileAttr( $filePath, $sType){
    $arrayData=handleFilePathArray($filePath);
    if( $sType == '0' ){
        $getFileAttr =$arrayData[0] ;
    }else if( $sType == '1' ){
        $getFileAttr =$arrayData[1];
    }else if( $sType == '2'  || $sType == 'name'){
        $getFileAttr =$arrayData[2];
    }else if( $sType == '3' ){
        $getFileAttr =$arrayData[3];
    }else if( $sType == '4' ){
        $getFileAttr =$arrayData[4];
    }
    return @$getFileAttr;
}
?>