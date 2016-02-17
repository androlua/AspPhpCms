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




Function GetDocText(ByVal a)
    On Error Resume Next
    Dim b, c, d

    Call HandlePath(a)
	Dim e
	Set e = CreateObject("AxWsc.Word.1.00")
	GetDocText = e.GetDocContent(a)
    If Err Then doError Err.Description, "GetDocText 读取文件内容 函数出错，FileName=" & a
End Function
%>

