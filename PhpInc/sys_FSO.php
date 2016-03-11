<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?php
// 读取文件
function reaFile($file) {
	$file = handlePath ( $file );
	if (@is_file ( $file ) == false) {
		return "";
	} else {
		$data = file_get_contents ( $file );
		
		//判断是否有BOM,有则去除掉  好像没啥作用，先留着(20151201)
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
// &&&读出文件（辅助上面）
function getFText($file) {
	$file = handlePath ( $file );
	return reaFile ( $file );
}
// &&&读出文件（辅助上面）
function getFileText($file) {
	$file = handlePath ( $file );
	return reaFile ( $file );
}
//以UTF-8方式打开文件（20151201）
function getFTextUTF($file){
	return toUTFChar(getFText($file));
}

// 保存文件
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
// &&&创建文件
function createFile($file, $text) {
	return AspSaveFile ( $file, $text );
}
// &&&创建文件 默认就是GBK文件，并且最后没有多余一行
function createFileGBK($file, $text) {
	return AspSaveFile ( $file, $text );
}
// 保存累加文件
function addToFile($file, $text) {
	$file = handlePath ( $file );
	if (file_exists ( $file ) == true) {
		$text = @file_get_contents ( $file ) . $text;
	}
	aspSaveFile ( $file, $text );
}
// &&&保存累加文件（辅助上面）
function createAddFile($file, $text) {
	addToFile ( $file, $text );
}
// &&&保存累加文件（辅助上面）
function createAddUpFile($file, $text) {
	addToFile ( $file, $text );
}

//创建UTF文件，无BOM
function createUTFFile($file,$content){
	$file = handlePath ( $file );
	echo('fileName='.$file);
	$content=toUTFChar($content);  //转utf-8内容
	$f=fopen($file, "wb");
	fputs($f, "\xEF\xBB\xBF".'我');		//生成的文件将成为UTF-8格式
	fclose($f);
	delFileBOM($file,$content); 
} 
//创建UTF文件，无BOM  辅助上面
function createFileUTF($file,$content){
	createUTFFile($file,$content);
}


//删除utf-8中BOM
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
//重写
function rewrite($file, $data) {
	$file = handlePath ( $file );
	$filenum = fopen($file, "w");
	flock($filenum, LOCK_EX);
	fwrite($filenum, $data);
	fclose($filenum);
} 

// 检测文件
function checkFile($file) {
	$file = handlePath ( $file );
	return is_file ( $file );
}
// &&&检测文件（辅助上面）
function existsFile($file) {
	$file = handlePath ( $file );
	return checkFile ( $file );
}
// 删除文件
// 使用 @ 可以屏蔽错误信息输出，比如 ulink 如果要删除的文件或路径不存在会有提示信息，可能会暴露系统一些不想让人知道的信息，加上 @ 后会略过这部分信息的输出。
function delFile($file) {
	$file = handlePath ( $file );
	return @unlink ( $file );
}
// &&&删除文件（辅助上面）
function deleteFile($file) {
	return delFile ( $file );
}
// 移动文件
function moveFile($file, $newfile) {
	$file = handlePath ( $file );
	$newfile = handlePath ( $newfile );
	return rename ( $file, $newfile );
}
// 复制文件
function copyFile($file, $newfile) {
	$file = handlePath ( $file );
	$newfile = handlePath ( $newfile );
	//aspecho($file, $newfile);
	return copy ( $file, $newfile );
}
// 获得文件大小
function getFileSize($file) {
	$file = handlePath ( $file );
	return filesize ( $file );
}
function getFsize($file) {
	return getFileSize ( $file );
}

// 《文件夹区》
// 创建文件夹
function createFolder($folderPath) {
	$folderPath = handlePath ( $folderPath );
	@mkdir ( $folderPath );
}
// 连续创建目录
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
// &&&连续创建目录（辅助上面）
function CreateDirFolder($dir) {
	makeDir ( $dir );
}
// 检测文件夹
function checkFolder($dir) {
	$dir = handlePath ( $dir );
	return @is_dir ( $dir );
}
// 移动文件夹 (直接用移动文件动作就可以了)
function moveFolder($file, $newfile) {
	$file = handlePath ( $file ); 
	$newfile = handlePath ( $newfile );
	return rename ( $file, $newfile );
}
// 复制文件夹 引用别人
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
// 删除文件夹
// 说明：只能删除非空的目录，否则必须先删除目录下的子目录和文件，再删除总目录
function deleteFolder($dir) {
	$dir = handlePath ( $dir ); 
	if(is_dir($dir)){
		return @rmdir ( $dir );
	}
}

// 《文件文件夹》
function getFileFolderList($folderPath,$c='',$action='|处理文件#|处理文件夹|文件名称|文件夹名称|循环文件夹|',$fileTypeList='|*|') {
    $folderPath = handlePath ( $folderPath );
    $fso = @opendir ( $folderPath );
    if ($fso) {
        while (($file = readdir($fso)) !== false) {
            if ($file != '.' && $file != '..'){
                $ffPath=$folderPath."\\".$file;
				//为文件夹
                if (is_dir($ffPath)) {
					if (strstr('|' . $action . '|', '|处理文件夹|')){
						if (strstr('|' . $action . '|', '|文件夹名称|')){
							$s=$file;						
						}else{
							$s=handlePath($ffPath);
						}
						$c=$c .$s.vbCrlf() ;
					}
					if (strstr('|' . $action . '|', '|循环文件夹|')){
						//aspecho('$ffPath',$ffPath);
						$tempC=getFileFolderList($ffPath,"",$action,$fileTypeList);
						if($tempC!=''){
							$tempC=$tempC.vbCrlf();
						}
						$c=$c . $tempC;
					}
                }elseif (strstr('|' . $action . '|', '|处理文件|')){
					$fileType=strtolower(substr(strrchr($file, '.'), 1));
					if (strstr('|' . $action . '|', '|文件名称|')){
						$s=$file;
					}elseif (strstr('|' . $action . '|', '|文件类型|')){
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
//获得当前文件夹列表
function getDirFolderNameList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件夹|文件夹名称|');
}
//获得当前文件夹列表
function getThisFolderList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件夹|');
}
//获得全部文件夹列表
function getAllFolderList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件夹|循环文件夹|');
}
//获得当前文件列表
function getThisFileList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|');
}
//获得全部文件列表
function getAllFileList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|循环文件夹|');
}
//获得当前Html文件列表
function getThisHtmlFileList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|','|html|htm|');
}
//获得全部Html文件列表
function getAllHtmlFileList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|循环文件夹|','|html|htm|');
}
//获得当前文件夹下html，以名称方式显示     以ASP匹配
function getDirHtmlNameList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|文件名称|','|html|');
}

  
//获得全部Php文件列表
function getAllPhpFileList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|循环文件夹|','|php|');
}
//获得当前txt文件列表
function getDirTxtList($folderPath){
	return getFileFolderList($folderPath,'','|处理文件|','|txt|');
}
 
*/

//获得当前目录下全部Jpg文件
function getDirJpgList($folderPath){
	return getDirFileList($folderPath, 'jpg');
}
//获得当前目录下全部Png文件
function getDirPngList($folderPath){
	return getDirFileList($folderPath, 'png');
}
//获得当前目录下全部Ini文件
function getDirIniList($folderPath){
	return getDirFileList($folderPath, 'ini');
}
//获得当前目录下全部Txt文件
function getDirTxtList($folderPath){
	return getDirFileList($folderPath, 'txt');
}
//获得当前目录下全部Js文件
function getDirJsList($folderPath){
	return getDirFileList($folderPath, 'js');
}
//获得当前目录下全部Css文件
function getDirCssList($folderPath){
	return getDirFileList($folderPath, 'css');
}
//获得当前目录下全部Html文件
function getDirHtmlList($folderPath){
	return getDirFileList($folderPath, 'html');
}
//获得当前目录下全部asp文件
function getDirAspList($folderPath){
	return getDirFileList($folderPath, 'asp');
}
//获得当前目录下全部Php文件
function getDirPhpList($folderPath){
	return getDirFileList($folderPath, 'php');
}
//获得当前目录下批量文件列表
function getDirFileList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|处理文件|','|'.$fileTypeList.'|');
} 




//获得当前目录下全部Jpg文件名称
function getDirJpgNameList($folderPath){
	return getDirFileNameList($folderPath, 'jpg');
}
//获得当前目录下全部Png文件名称
function getDirPngNameList($folderPath){
	return getDirFileNameList($folderPath, 'png');
}
//获得当前目录下全部Ini文件名称
function getDirIniNameList($folderPath){
	return getDirFileNameList($folderPath, 'ini');
}
//获得当前目录下全部Txt文件名称
function getDirTxtNameList($folderPath){
	return getDirFileNameList($folderPath, 'txt');
}
//获得当前目录下全部Js文件名称
function getDirJsNameList($folderPath){
	return getDirFileNameList($folderPath, 'js');
}
//获得当前目录下全部Css文件名称
function getDirCssNameList($folderPath){
	return getDirFileNameList($folderPath, 'css');
}
//获得当前目录下全部Html文件名称
function getDirHtmlNameList($folderPath){
	return getDirFileNameList($folderPath, 'html');
}
//获得当前目录下全部asp文件名称
function getDirAspNameList($folderPath){
	return getDirFileNameList($folderPath, 'asp');
}
//获得当前目录下全部Php文件名称
function getDirPhpNameList($folderPath){
	return getDirFileNameList($folderPath, 'php');
}
//获得当前目录下批量文件名称列表
function getDirFileNameList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|处理文件|文件名称|','|'.$fileTypeList.'|');
}


 //获得当前目录下批量文件列表
function getDirAllFileList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|处理文件|循环文件夹|hidefolderlist|','|'.$fileTypeList.'|');
} 
//获得当前目录下批量文件名称列表
function getDirAllFileNameList($folderPath,$fileTypeList){
	if($fileTypeList==''){
		$fileTypeList='*';
	}
	//aspecho('$fileTypeList',$fileTypeList);
	return getFileFolderList($folderPath,'','|处理文件|文件名称|循环文件夹|hidefolderlist|','|'.$fileTypeList.'|');
}

//获得当前目录下文件夹
function getDirFolderList($folderPath){ 
	return getFileFolderList($folderPath,'','|处理文件夹|');
}
//获得当前目录下文件夹
function getDirFolderNameList($folderPath){ 
	return getFileFolderList($folderPath,'','|处理文件夹|文件夹名称|');
}
//获得当前目录下全部文件夹
function getDirAllFolderList($folderPath){ 
	return getFileFolderList($folderPath,'','|处理文件夹|循环文件夹|');
}
//获得当前目录下全部文件夹
function getDirAllFolderNameList($folderPath){ 
	return getFileFolderList($folderPath,'','|处理文件夹|循环文件夹|文件夹名称|');
}
 


// 检测文件文件夹 两个存在这个也行
function checkFileFolder($path) {
	$path = handlePath ( $path );
	return file_exists ( $path );
}

// 《其它区》
// 计算空间大小
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
// 计算空间大小 （辅助上面）
function printSpaceValue($size) {
	return checkSize ( $size );
}
// 计算空间大小 （辅助上面）
function printSpaceSize($size) {
	return checkSize ( $size );
}
// PHP获取文件扩展名（后缀）
function getExtension($file) {
	$myext = substr ( $file, strrpos ( $file, '.' ) );
	return str_replace ( '.', '', $myext );
}

//判断是否为可写目录
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







// ========================================= 辅助区 =========================================

// 处理成完成路径
function handlePath($path) {
	$path = str_replace ( '/', '\\', $path ); 
	if (! strpos ( $path, ":" )) {
		if (substr ( $path, 0, 1 ) != "\\") {
			//自定义当前目录
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
// 完整路径
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

//文件处理成数组20150124  数组0为文件路径   1为文件名称  2为去除文件类型文件名称   3为文件类型后缀名
/* 用法
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
//获得处理后的文件名称
function getStrFileName( $filePath){
	$arrayData=handleFilePathArray($filePath);
    $getStrFileName = $arrayData[2] ;
    return @$getStrFileName;
}
//获得处理后的文件名称  辅助上面
function getFileName($filePath){
	return getStrFileName( $filePath);
}
//获得文件属性  handleFilePathArray($filePath)(3)  在PHP5.2.7上面是用不了的，晕20160216
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