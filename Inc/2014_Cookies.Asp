<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-29
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By AspPhpCMS 
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
'����cookies(20151120)
Function setCookie(cookieName, cookieValue, cookieTime)
    Response.Cookies(cookieName) = cookieValue 
    Response.Cookies(cookieName).Expires = now+1 
End Function 

%>
