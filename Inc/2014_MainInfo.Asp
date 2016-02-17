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

Function ReadMainInfoShowTitle(a)
    Dim b
    b = "Select * From [MainInfo] Where Title='" & a & "' And Recommend<>0 "
    If UserId <> "" Then b = b & " And UserId=" & UserId
    Rs.Open b & " Order By Sort,ID", Conn, 1, 1
    If Not Rs.EOF Then
        ReadMainInfoShowTitle = Rs("ShowTitle")
    End If : Rs.Close
End Function


Function ReadMainInfo(a)
    Dim b
    b = "Select * From [MainInfo] Where Title='" & a & "' And Recommend<>0 "
    If UserId <> "" Then b = b & " And UserId=" & UserId
    b = b & " Order By Sort,ID"
    Rs.Open b, Conn, 1, 1
    If Not Rs.EOF Then
        ReadMainInfo = Rs("Content")
    End If : Rs.Close
End Function


Function ReadMainId(a)
    Dim b
    b = "Select * From [MainInfo] Where Title='" & a & "' And Recommend<>0 "
    If UserId <> "" Then b = b & " And UserId=" & UserId
    Rs.Open b, Conn, 1, 1
    If Not Rs.EOF Then
        ReadMainId = Rs("Id")
    End If : Rs.Close
End Function


Function GetMainParam(ByVal a, ByVal b, ByVal c)
    Dim d, e, f
    d = "Select * From [" & a & "] " & c
    TempRs.Open d, Conn, 1, 1
    If Not TempRs.EOF Then

        If b = "[url]" Then
            e = Trim(TempRs("FileName"))
            If e = "" Then e = "MainInfo" & TempRs("Id")
            f = GetHandleFileName(e)
            f = WebDebug(f, "act=MainInfo&Id=" & TempRs("Id"))
            GetMainParam = f
        ElseIf b <> "" Then
            GetMainParam = TempRs(b)
        End If
    End If : TempRs.Close
End Function

%>


