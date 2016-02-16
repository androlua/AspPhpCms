<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-16
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN gETeDItORsTR(a,b)
dIM c
c = "<script charset=""utf-8"" src=""Keditor/kindeditor.js""></script> " & vBCrLF
c = c & "<script charset=""utf-8"" src=""Keditor/lang/zh_CN.js""></script>  " & vBCrLF
c = c & "<script language=""javascript"">" & vBCrLF
c = c & "KindEditor.ready(function(K) {" & vBCrLF
c = c & "	var editor1 = K.create('textarea[name="""& a &"""]', {		//处理让文本域" & vBCrLF
c = c & "		cssPath : 'Keditor/plugins/code/prettify.css'," & vBCrLF
c = c & "		uploadJson : 'Keditor/"& b &"/upload_json."& b &"'," & vBCrLF
c = c & "		fileManagerJson : 'Keditor/"& b &"/file_manager_json."& b &"'," & vBCrLF
c = c & "		allowFileManager : true," & vBCrLF
c = c & "		afterCreate : function() {" & vBCrLF
c = c & "			var self = this;" & vBCrLF
c = c & "			K.ctrl(document, 13, function() {" & vBCrLF
c = c & "				self.sync();" & vBCrLF
c = c & "				K('form[name=example]')[0].submit();" & vBCrLF
c = c & "			});" & vBCrLF
c = c & "			K.ctrl(self.edit.doc, 13, function() {" & vBCrLF
c = c & "				self.sync();" & vBCrLF
c = c & "				K('form[name=example]')[0].submit();" & vBCrLF
c = c & "			});" & vBCrLF
c = c & "		}" & vBCrLF
c = c & "	});" & vBCrLF
c = c & "	//prettyPrint();				//因为这个出错，所以给它注释掉 2013,12,12" & vBCrLF
c = c & "});" & vBCrLF
c = c & "</script>" & vBCrLF
gETeDItORsTR = c
eND fUNcTIoN
fUNcTIoN dISpLAyUPlOAdDIaLOg(a,b)
iF b="asp" tHEn
dISpLAyUPlOAdDIaLOg="<iframe style='top:2px' src='"& aDMiNDiR &"upload_Photo.asp?PhotoUrlID=1&returnInputName="& a &"' frameborder=0 scrolling='No' width=340 height=25></iframe>"
eLSeIF b="php" tHEn
dISpLAyUPlOAdDIaLOg="<iframe style='top:2px' src='upfile.php?returnInputName="& a &"' frameborder=0 scrolling='No' width=340 height=25></iframe>"
eND iF
eND fUNcTIoN
%>

