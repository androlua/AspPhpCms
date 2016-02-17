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
Function getCookie(ByVal a)
    Dim b : b = Easp_Param(a)
    If Response.Cookies(b(0)).HasKeys And Not isN(b(1)) Then
        getCookie = SafeData("", Request.Cookies(b(0))(b(1)), 0)
    Else
        getCookie = SafeData("", Request.Cookies(b(0)), 0)
    End If
    If IsN(getCookie) Then getCookie = ""
End Function
Sub removeCookie(ByVal a)
    Dim b : b = Easp_Param(a)
    If Response.Cookies(b(0)).HasKeys And Not isN(b(1)) Then
        Response.Cookies(b(0))(b(1)) = Empty
    Else
        Response.Cookies(b(0)) = Empty
        Response.Cookies(b(0)).Expires = Now()
    End If
End Sub
Sub setApp(a, b)
    Application.Lock
    Application.Contents.Item(a) = b
    Application.Unlock
End Sub
Function getApp(a)
    If IsN(a) Then getApp = "" : Exit Function
    getApp = Application.Contents.Item(a)
End Function
Sub removeApp(a)
    Application.Lock
    Application.Contents.Remove(a)
    Application.Unlock
End Sub

Function setCookie(a, b, c)
    Response.Cookies(a) = b
    Response.Cookies(a).Expires = now+1
End Function

%>



