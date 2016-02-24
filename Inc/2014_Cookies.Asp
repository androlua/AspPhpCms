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
Function getCookie(ByVal cooName)
    Dim n : n = Easp_Param(cooName) 
    If Response.Cookies(n(0)).HasKeys And Not isN(n(1)) Then
        getCookie = SafeData("", Request.Cookies(n(0))(n(1)), 0) 
    Else
        getCookie = SafeData("", Request.Cookies(n(0)), 0) 
    End If 
    If IsN(getCookie) Then getCookie = "" 
End Function 
Sub removeCookie(ByVal cooName)
    Dim n : n = Easp_Param(cooName) 
    If Response.Cookies(n(0)).HasKeys And Not isN(n(1)) Then
        Response.Cookies(n(0))(n(1)) = Empty 
    Else
        Response.Cookies(n(0)) = Empty 
        Response.Cookies(n(0)).Expires = Now() 
    End If 
End Sub 
Sub setApp(AppName, AppData)
    Application.Lock 
    Application.Contents.Item(AppName) = AppData 
    Application.Unlock 
End Sub
Function getApp(AppName)
    If IsN(AppName) Then getApp = "" : Exit Function 
    getApp = Application.Contents.Item(AppName) 
End Function 
Sub removeApp(AppName)
    Application.Lock 
    Application.Contents.Remove(AppName) 
    Application.Unlock
End Sub 
'设置cookies(20151120)
Function setCookie(cookieName, cookieValue, cookieTime)
    Response.Cookies(cookieName) = cookieValue 
    Response.Cookies(cookieName).Expires = now+1 
End Function 

%>


