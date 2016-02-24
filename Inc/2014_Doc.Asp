<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-24
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
'doc文件操作

'读Doc文件内容 20141218
'例：Call Rw( GetDocText("1.docx"))
Function GetDocText(ByVal FileName)
    On Error Resume Next
    Dim Fso, FText, OpenFile 
    'GetFileText = ""   '它默认返回的就是空， 这个是多此一举 (2013,9,30)
    Call HandlePath(FileName)    '获得完整路径 	
	Dim doc
	Set doc = CreateObject("AxWsc.Word.1.00")
	GetDocText = doc.GetDocContent(FileName)
    If Err Then doError Err.Description, "GetDocText 读取文件内容 函数出错，FileName=" & FileName 
End Function
%>
