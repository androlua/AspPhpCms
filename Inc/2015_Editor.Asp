<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-17
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%

Function getEditorStr(a,b)
    Dim c
    c = "<script charset=""utf-8"" src=""Keditor/kindeditor.js""></script> " & vbCrlf
    c = c & "<script charset=""utf-8"" src=""Keditor/lang/zh_CN.js""></script>  " & vbCrlf
    c = c & "<script language=""javascript"">" & vbCrlf
    c = c & "KindEditor.ready(function(K) {" & vbCrlf
    c = c & "	var editor1 = K.create('textarea[name="""& a &"""]', {		//处理让文本域" & vbCrlf
    c = c & "		cssPath : 'Keditor/plugins/code/prettify.css'," & vbCrlf
    c = c & "		uploadJson : 'Keditor/"& b &"/upload_json."& b &"'," & vbCrlf
    c = c & "		fileManagerJson : 'Keditor/"& b &"/file_manager_json."& b &"'," & vbCrlf
    c = c & "		allowFileManager : true," & vbCrlf
    c = c & "		afterCreate : function() {" & vbCrlf
    c = c & "			var self = this;" & vbCrlf
    c = c & "			K.ctrl(document, 13, function() {" & vbCrlf
    c = c & "				self.sync();" & vbCrlf
    c = c & "				K('form[name=example]')[0].submit();" & vbCrlf
    c = c & "			});" & vbCrlf
    c = c & "			K.ctrl(self.edit.doc, 13, function() {" & vbCrlf
    c = c & "				self.sync();" & vbCrlf
    c = c & "				K('form[name=example]')[0].submit();" & vbCrlf
    c = c & "			});" & vbCrlf
    c = c & "		}" & vbCrlf
    c = c & "	});" & vbCrlf
    c = c & "	//prettyPrint();				//因为这个出错，所以给它注释掉 2013,12,12" & vbCrlf
    c = c & "});" & vbCrlf
    c = c & "</script>" & vbCrlf

    getEditorStr = c
End Function

function displayUploadDialog(a,b)
	if b="asp" then
		displayUploadDialog="<iframe style='top:2px' src='"& adminDir &"upload_Photo.asp?PhotoUrlID=1&returnInputName="& a &"' frameborder=0 scrolling='No' width=340 height=25></iframe>"
	elseif b="php" then
		displayUploadDialog="<iframe style='top:2px' src='upfile.php?returnInputName="& a &"' frameborder=0 scrolling='No' width=340 height=25></iframe>"
	end if
end function
%>

