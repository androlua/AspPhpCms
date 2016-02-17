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



Function getWhereAnd(ByVal a, ByVal b)
    Dim c, d

    If Trim(b) = "" Then getWhereAnd = a : Exit Function
    If InStr(LCase(a), " where ") > 0 Then
        d = " And "
    Else
        d = " Where "
    End If
    If b <> "" Then
        b = Trim(b)
        c = LCase(b)
        If Left(c, 6) = "order " Or Left(c, 6) = "group " Then
            getWhereAnd = a & " " & b : Exit Function 								
        ElseIf Left(c, 6) = "where " Then
            b = Mid(b, 7)
        ElseIf Left(c, 4) = "and " Then
            b = Mid(b, 5)
        End If
        a = a & d & b
    End If
    getWhereAnd = a
End Function

Function orAndSearch(a, b, c)
    Dim d, e, f
    c = RegExp_Replace(c, " or ", " Or ")
    c = RegExp_Replace(c, " and ", " And ")
    If InStr(c, " Or ") > 0 Then
        d = Split(c, " Or ")
        For Each e In d
            If e <> "" Then
                If f <> "" Then f = f & " Or "
                f = f & " " & b & " Like '%" & e & "%'"
            End If
        Next
    ElseIf InStr(c, " And ") > 0 Then
        d = Split(c, " And ")
        For Each e In d
            If e <> "" Then
                If f <> "" Then f = f & " And "
                f = f & " " & b & " Like '%" & e & "%'"
            End If
        Next
    ElseIf c <> "" Then
        d = Split(c, " And ")
        For Each e In d
            If e <> "" Then
                If f <> "" Then f = f & " And "
                f = f & " " & b & " Like '%" & e & "%'"
            End If
        Next
    End If
    If f <> "" Then
        If InStr(LCase(a), " where ") = 0 Then
            f = " Where " & f
        Else
            f = " And " & f
        End If
        a = a & f
    End If
    orAndSearch = a
End Function


%>

