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



Function format_Time(a, b)
    Dim c, d, e, f, g, h
    format_Time = ""
    If IsDate(a) = False Then Exit Function
    c = CStr(Year(a))
    d = CStr(Month(a))
    If Len(d) = 1 Then d = "0" & d
    e = CStr(Day(a))
    If Len(e) = 1 Then e = "0" & e
    f = CStr(Hour(a))
    If Len(f) = 1 Then f = "0" & f
    g = CStr(Minute(a))
    If Len(g) = 1 Then g = "0" & g
    h = CStr(Second(a))
    If Len(h) = 1 Then h = "0" & h
    Select Case b
        Case 1

            format_Time = c & "-" & d & "-" & e & " " & f & ":" & g & ":" & h
        Case 2

            format_Time = c & "-" & d & "-" & e
        Case 3

            format_Time = f & ":" & g & ":" & h
        Case 4

            format_Time = c & "年" & d & "月" & e & "日"
        Case 5

            format_Time = c & d & e
        Case 6

            format_Time = c & d & e & f & g & h
        Case 7

            format_Time = d & "-" & e
        Case 8

            format_Time = c & "年" & d & "月" & e & "日" & " " & f & ":" & g & ":" & h
        Case 9

            format_Time = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒，" & GetDayStatus(f, 1)
        Case 10

            format_Time = c & "年" & d & "月" & e & "日" & f & "时"
        Case 11

            format_Time = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒"
        Case 12

            format_Time = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分"
        Case 13

            format_Time = d & "月" & e & "日" & " " & f & ":" & g & " " & GetDayStatus(f, 0)
        Case 14

            format_Time = c & "/" & d & "/" & e
        Case 15

            format_Time = c & "年" & d & "月 第" & GetCountPage(e, 7) & "周"
    End Select
End Function

Function getDayStatus(a, b)
    Dim c
    If Left(a, 1) = "0" Then
        a = Right(a, 1)
    End If
    a = CInt(a)
    If a >= 0 And a <= 5 Then
        c = "凌晨"
    ElseIf a >= 6 And a <= 8 Then
        c = "早上"
    ElseIf a >= 9 And a <= 12 Then
        c = "上午"
    ElseIf a >= 13 And a <= 18 Then
        c = "下午"
    ElseIf a >= 19 And a <= 24 Then
        c = "晚上"
    Else
        c = "深夜"
    End If
    If b = 1 Then c = "<b>" & c & "</b>"
    getDayStatus = c
End Function

Function printTimeValue(a)
    On Error Resume Next
    Dim b, c, d
    b = a : c = ""
    If b >= 86400 Then
        d = b Mod 86400
        b = Fix(b / 60 / 60 / 24)
        c = c & b & "天"
        b = d
    End If
    If b >= 3600 Then
        d = b Mod 3600
        b = Fix(b / 60 / 60)
        c = c & b & "小时"
        b = d
    End If

    If b >= 60 Then
        d = b Mod 60
        b = Fix(b / 60)
        c = c & b & "分"
        b = d
    End If
    If b >= 0 Then
        c = c & b & "秒"
    End If
    If Err.Number <> 0 Then MsgBox(a)
    printTimeValue = c
End Function

Function printAskTime(a)
    On Error Resume Next
    Dim b, c, d
    b = a
    c = ""
    If b >= 3600 Then
        d = b Mod 3600
        b = Fix(b / 60 / 60)
        c = c & b & "小时"
        b = d
        printAskTime = c : Exit Function
    End If
    If b >= 60 Then
        d = b Mod 60
        b = Fix(b / 60)
        c = c & b & "分钟"
        b = d
        printAskTime = c : Exit Function
    End If
    If b >= 0 Then
        c = c & b & "秒钟"
        printAskTime = c : Exit Function
    End If
End Function

Function getTimerSet()
    Dim b
    b = FormatNumber((Timer() - PubTimer) * 1000, 2, - 1) / 1000
    getTimerSet = toNumber(b, 3)
End Function

Function calculationTimer(a)
    Dim b
    b = FormatNumber((Timer() - a) * 1000, 2, - 1) / 1000
    calculationTimer = toNumber(b, 3)
End Function


Function getTimer()
    getTimer = "<br>------------------------------------<br>页面执行时间：" & getTimerSet() & " 秒"
End Function

Function vBGetTimer()
    Dim b
    b = DateDiff("s", PubTimer, Now())
    b = printTimeValue(b)
    vBGetTimer = vbCrLf & "------------------------------------" & vbCrLf & "运行时间：" & b
End Function

Function vBEchoTimer()
    Dim b
    b = DateDiff("s", PubTimer, Now())
    b = printTimeValue(b)
    vBEchoTimer = "运行时间：" & b
End Function

Function vBRunTimer(a)
    Dim b
    b = DateDiff("s", a, Now())
    b = printTimeValue(b)
    vBRunTimer = "运行时间：" & b
End Function
%>



