<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-02-24
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered By 云端 
************************************************************/
?>
<?PHP
//获得编辑器内容
function getEditorStr($inputName,$sType){
    $C='';
    $C = '<script charset="utf-8" src="Keditor/kindeditor.js"></script> ' . "\n";
    $C = $C . '<script charset="utf-8" src="Keditor/lang/zh_CN.js"></script>  ' . "\n";
    $C = $C . '<script language="javascript">' . "\n";
    $C = $C . 'KindEditor.ready(function(K) {' . "\n";
    $C = $C . '	var editor1 = K.create(\'textarea[name="'. $inputName .'"]\', {		//处理让文本域' . "\n";
    $C = $C . '		cssPath : \'Keditor/plugins/code/prettify.css\',' . "\n";
    $C = $C . '		uploadJson : \'Keditor/'. $sType .'/upload_json.'. $sType .'\',' . "\n";
    $C = $C . '		fileManagerJson : \'Keditor/'. $sType .'/file_manager_json.'. $sType .'\',' . "\n";
    $C = $C . '		allowFileManager : true,' . "\n";
    $C = $C . '		afterCreate : function() {' . "\n";
    $C = $C . '			var self = this;' . "\n";
    $C = $C . '			K.ctrl(document, 13, function() {' . "\n";
    $C = $C . '				self.sync();' . "\n";
    $C = $C . '				K(\'form[name=example]\')[0].submit();' . "\n";
    $C = $C . '			});' . "\n";
    $C = $C . '			K.ctrl(self.edit.doc, 13, function() {' . "\n";
    $C = $C . '				self.sync();' . "\n";
    $C = $C . '				K(\'form[name=example]\')[0].submit();' . "\n";
    $C = $C . '			});' . "\n";
    $C = $C . '		}' . "\n";
    $C = $C . '	});' . "\n";
    $C = $C . '	//prettyPrint();				//因为这个出错，所以给它注释掉 2013,12,12' . "\n";
    $C = $C . '});' . "\n";
    $C = $C . '</script>' . "\n";

    $getEditorStr = $C;
    return @$getEditorStr;
}
//上传文件面板
function displayUploadDialog($returnInputName,$sType){
    if( $sType=='asp' ){
        $displayUploadDialog='<iframe style=\'top:2px\' src=\'/admin/upload_Photo.asp?PhotoUrlID=1&returnInputName='. $returnInputName .'\' frameborder=0 scrolling=\'No\' width=340 height=25></iframe>';
    }else if( $sType=='php' ){
        $displayUploadDialog='<iframe style=\'top:2px\' src=\'upfile.php?returnInputName='. $returnInputName .'\' frameborder=0 scrolling=\'No\' width=340 height=25></iframe>';
    }
    return @$displayUploadDialog;
}
?>

