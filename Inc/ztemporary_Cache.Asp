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



CONST CACHEPREFIX = "CACHE_"













Function AddCache(a)
	Dim b,ary(4)
	If Not IsArray(a) Then
		Response.Write "Error:AddCache(varAry)参数错误，参数不是数组"
		Response.End()
	End If
	If UBound(a) <> 3 Then
		Response.Write "Error:AddCache(varAry)参数错误，数组长度错误"
		Response.End()
	End If
	If a(0) = "" Then
		Response.Write "Error:AddCache(varAry)错误，key不能为空"
		Response.End()
	End If
	If a(1) = "" or Not IsNumeric(a(1)) Then a(1) = 1200
	Application.Lock()
	Application(CACHEPREFIX & a(0)) = array(a(0),a(1),a(2),a(3),DateAdd("s",a(1),Now()))
	Application.UnLock()
End Function



Function CheckCache(a)
	Dim b
	For Each b In Application.Contents
		If LCase(b) = LCase(CACHEPREFIX & a) Then CheckCache = True : Exit Function
	Next
	CheckCache = False
End Function


Function RemoveCache(a)
	Application.Lock()
	Application.Contents.Remove(CACHEPREFIX & a)
	Application.UnLock()
End Function









Function UpdateCache(a)
	Dim b
	b = GetCache(a(0))
	If Not IsNull(a(1)) Then b(1) = a(1)
	If Not IsNull(a(2)) Then b(2) = a(2)
	If Not IsNull(a(3)) Then b(3) = a(3)
	If b(1) = "" or Not IsNumeric(b(1)) Then b(1) = 1200
	Application.Lock()
	Application(CACHEPREFIX & b(0)) = array(b(0),b(1),b(2),b(3),DateAdd("s",b(1),Now()))
	Application.UnLock()
End Function


Function PrintCache(a)
    Dim b, c, d
    If CheckCache(a) Then
        b = GetCache(a)
        Response.Write "<pre>{" & Chr(10)
        Response.Write Chr(32) & "缓存名称" & Chr(32) & ":" & Chr(32) & CACHEPREFIX & b(0) & Chr(10)
        Response.Write Chr(32) & "缓存key " & Chr(32) & ":" & Chr(32) & b(0) & Chr(10)
        Response.Write Chr(32) & "缓存时间" & Chr(32) & ":" & Chr(32) & b(1) & Chr(10)
        Response.Write Chr(32) & "到期时间" & Chr(32) & ":" & Chr(32) & b(4) & Chr(10)
        Response.Write Chr(32) & "是否到期" & Chr(32) & ":" & Chr(32) & b(5) & Chr(10)
        Response.Write Chr(32) & "缓存说明" & Chr(32) & ":" & Chr(32) & b(3) & Chr(10)

        Response.Write Chr(32) & "缓存内容" & Chr(32) & ":" & Chr(32)
        d = VarType(b(2))
        If InStr(",0,1,2,3,4,5,6,7,8,11,", "," & d & ",") > 0 Then
            Response.Write b(2)
        Else
            Response.Write TypeName(b(2))
        End If
        Response.Write Chr(10)

        Response.Write "}</pre>" & Chr(10)
    Else
        Response.Write "不存在该缓存"
    End If
 End Function




Function GetCache(a)
    Dim b, c
    b = Application(CACHEPREFIX & a)
    c = False
    If DateDiff("s", Now(), b(4)) <= 0 Then c = True
    GetCache = Array(b(0), b(1), b(2), b(3), b(4), c)
End Function




Function HcShow(a)
    Dim b, c, d
    If CheckCache(a) Then
        b = GetCache(a)

        d = VarType(b(2))
        If InStr(",0,1,2,3,4,5,6,7,8,11,", "," & d & ",") > 0 Then
            HcShow = b(2)
        Else
            HcShow = TypeName(b(2))
        End If
    Else
        HcShow = "不存在该缓存"
    End If
End Function


Sub Br(a)
    Response.Write a & "<br />" & vbCrLf
End Sub


Function RemoveAllCache()
    Application.Lock
    Application.Contents.RemoveAll
    Application.Unlock
End Function
%>

