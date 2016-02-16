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

