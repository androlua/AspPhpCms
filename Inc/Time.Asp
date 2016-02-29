<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'Time 时间操作类 (2013,9,27)

'时间处理
Function format_Time(timeStr, nType)
    Dim y, m, d, h, mi, s 
    format_Time = "" 
    If IsDate(timeStr) = False Then Exit Function 
    y = CStr(Year(timeStr)) 
    m = CStr(Month(timeStr)) 
    If Len(m) = 1 Then m = "0" & m 
    d = CStr(Day(timeStr))                                                          '在vb.net里要这样用  D = CStr(CDate(timeStr).Day)
    If Len(d) = 1 Then d = "0" & d 
    h = CStr(Hour(timeStr)) 
    If Len(h) = 1 Then h = "0" & h 
    mi = CStr(Minute(timeStr)) 
    If Len(mi) = 1 Then mi = "0" & mi 
    s = CStr(Second(timeStr)) 
    If Len(s) = 1 Then s = "0" & s 
    Select Case nType
        Case 1
            'yyyy-mm-dd hh:mm:ss
            format_Time = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s 
        Case 2
            'yyyy-mm-dd
            format_Time = y & "-" & m & "-" & d 
        Case 3
            'hh:mm:ss
            format_Time = h & ":" & mi & ":" & s 
        Case 4
            'yyyy年mm月dd日
            format_Time = y & "年" & m & "月" & d & "日" 
        Case 5
            'yyyymmdd
            format_Time = y & m & d 
        Case 6
            'yyyymmddhhmmss
            format_Time = y & m & d & h & mi & s 
        Case 7
            'mm-dd
            format_Time = m & "-" & d 
        Case 8
            'yyyy年mm月dd日
            format_Time = y & "年" & m & "月" & d & "日" & " " & h & ":" & mi & ":" & s 
        Case 9
            'yyyy年mm月dd日H时mi分S秒 早上
            format_Time = y & "年" & m & "月" & d & "日" & " " & h & "时" & mi & "分" & s & "秒，" & GetDayStatus(h, 1) 
        Case 10
            'yyyy年mm月dd日H时
            format_Time = y & "年" & m & "月" & d & "日" & h & "时" 
        Case 11
            'yyyy年mm月dd日H时mi分S秒
            format_Time = y & "年" & m & "月" & d & "日" & " " & h & "时" & mi & "分" & s & "秒" 
        Case 12
            'yyyy年mm月dd日H时mi分
            format_Time = y & "年" & m & "月" & d & "日" & " " & h & "时" & mi & "分" 
        Case 13
            'yyyy年mm月dd日H时mi分 早上
            format_Time = m & "月" & d & "日" & " " & h & ":" & mi & " " & GetDayStatus(h, 0) 
        Case 14
            'yyyy年mm月dd日
            format_Time = y & "/" & m & "/" & d 
        Case 15
            'yyyy年mm月 第1周
            format_Time = y & "年" & m & "月 第" & GetCountPage(d, 7) & "周" 
    End Select
End Function 
'获得当前时期还可以计算
function getHandleDate(numb)
	if numb="" then
		numb=0 
	end if
	getHandleDate=format_Time(now()+numb,2)	
end function
'获得当前天状态
Function getDayStatus(h, SType)
    Dim c 
    If Left(h, 1) = "0" Then
        h = Right(h, 1) 
    End If 
    h = CInt(h) 
    If h >= 0 And h <= 5 Then
        c = "凌晨" 
    ElseIf h >= 6 And h <= 8 Then
        c = "早上" 
    ElseIf h >= 9 And h <= 12 Then
        c = "上午" 
    ElseIf h >= 13 And h <= 18 Then
        c = "下午" 
    ElseIf h >= 19 And h <= 24 Then
        c = "晚上" 
    Else
        c = "深夜" 
    End If 
    If SType = 1 Then c = "<b>" & c & "</b>" 
    getDayStatus = c 
End Function 
'时间计算
Function printTimeValue(vv)
    On Error Resume Next 
    Dim v, c, n 
    v = vv : c = "" 
    If v >= 86400 Then
        n = v Mod 86400 
        v = Fix(v / 60 / 60 / 24)        '这里面是除24，不是60，因为一天有24个小时，小云你这个傻X  20150119
        c = c & v & "天" 
        v = n 
    End If 
    If v >= 3600 Then
        n = v Mod 3600 
        v = Fix(v / 60 / 60) 
        c = c & v & "小时" 
        v = n 
    End If 

    If v >= 60 Then
        n = v Mod 60 
        v = Fix(v / 60) 
        c = c & v & "分" 
        v = n 
    End If 
    If v >= 0 Then
        c = c & v & "秒" 
    End If 
    If Err.Number <> 0 Then MsgBox(vv) 
    printTimeValue = c 
End Function 
'计算整时  (问答以小时或分钟显示)
Function printAskTime(vv)
    On Error Resume Next 
    Dim v, c, n 
    v = vv 
    c = "" 
    If v >= 3600 Then
        n = v Mod 3600 
        v = Fix(v / 60 / 60) 
        c = c & v & "小时" 
        v = n 
        printAskTime = c : Exit Function 
    End If 
    If v >= 60 Then
        n = v Mod 60 
        v = Fix(v / 60) 
        c = c & v & "分钟" 
        v = n 
        printAskTime = c : Exit Function 
    End If 
    If v >= 0 Then
        c = c & v & "秒钟" 
        printAskTime = c : Exit Function 
    End If 
End Function 
'获得时间
Function getTimerSet()
    Dim n 
    n = FormatNumber((Timer() - PubTimer) * 1000, 2, - 1) / 1000 
    getTimerSet = toNumber(n, 3) 
End Function 
'计算时间
Function calculationTimer(PubTimer)
    Dim n 
    n = FormatNumber((Timer() - PubTimer) * 1000, 2, - 1) / 1000 
    calculationTimer = toNumber(n, 3) 
End Function 

'获得时间
Function getTimer()
    getTimer = "<br>------------------------------------<br>页面执行时间：" & getTimerSet() & " 秒" 
End Function 
'获得时间
Function vBGetTimer()
    Dim n 
    n = DateDiff("s", PubTimer, Now()) 
    n = printTimeValue(n) 
    vBGetTimer = vbCrLf & "------------------------------------" & vbCrLf & "运行时间：" & n 
End Function 
'获得第三种
Function vBEchoTimer()
    Dim n 
    n = DateDiff("s", PubTimer, Now()) 
    n = printTimeValue(n) 
    vBEchoTimer = "运行时间：" & n 
End Function 
'获得时间第四种
Function vBRunTimer(startTime)
    Dim n 
    n = DateDiff("s", startTime, Now()) 
    n = printTimeValue(n) 
    vBRunTimer = "运行时间：" & n 
End Function 
%>  

