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



Function remoteContentJingHao(a, b)
    Dim c, d, e
    c = Split(a, b)
    For Each d In c
        If Left(phpTrim(d), 1) <> "#" And Left(phpTrim(d), 1) <> "_" Then
            If e <> "" Then e = e & b
            e = e & d
        End If
    Next
    remoteContentJingHao = e
End Function

Function remoteArrayJingHao(a)
    Dim b, c, d
    d = "[|-|_]"
    For Each b In a
        If Left(phpTrim(b), 1) <> "#" And Left(phpTrim(b), 1) <> "_" Then
            If c <> "" Then c = c & d
            c = c & b
        End If
    Next
    a = Split(c, d)
    remoteArrayJingHao = a
End Function


Function getEachStrAddValue(a, b)
    Dim c, d, e
    For c = 1 To Len(a)
        d = Mid(a, c, 1)
        e = e & d & b
    Next
    getEachStrAddValue = e
End Function

Function getValueInArrayID(a, b)
    Dim c
    getValueInArrayID = -1
    For c = 0 To UBound(a)
        If a(c) = b Then
            getValueInArrayID = c
            Exit For
        End If
    Next
End Function

Function checkValueInArray(a, b)
    Dim c
    checkValueInArray = False
    For c = 0 To UBound(a)
        If a(c) = b Then
            checkValueInArray = True
            Exit For
        End If
    Next
End Function


Function deleteRepeatArray(a)
    Dim b, c, d
    b = "[|-|_]"
    For Each c In a
        If c <> "" Then
            If InStr(b & d & b, b & c & b) = False Then
                d = d & c & b
            End If
        End If
    Next
    If d <> "" Then d = Left(d, Len(d) - Len(b))
    a = Split(d, b)
    deleteRepeatArray = a
End Function

Function deleteRepeatContent(a, b)
    Dim c, d, e
    c = Split(a, b)
    For Each d In c
        If d <> "" Then
            If InStr(b & e & b, b & d & b) = False Then
                If e <> "" Then e = e & b
                e = e & d
            End If
        End If
    Next
    deleteRepeatContent = e
End Function


Function getArrayCount(a, b)
    Dim c
    If InStr(a, b) > 0 Then
        c = Split(a, b)
        getArrayCount = UBound(c) + 1
    Else
        getArrayCount = 0
    End If
End Function

Function randomShow(a, b,c)
    Dim d, e, f, g, h
    Randomize
    For h = 1 To c
        d = Split(a, b)
        For Each e In d
            g = CInt(Rnd * 100)
            If g > 50 Then
                f = f & e & b
            Else
                f = e & b & f
            End If			
        Next
        If f <> "" Then f = Left(f, Len(f) - Len(b))
        a = f
        f = ""
    Next

    randomShow = a
End Function

Function arrayRandomShow(ByVal a, b)
    Dim c, d, e, f, g
    g = "[|-|_]"
    Randomize
    For f = 1 To b
        For Each c In a
            e = CInt(Rnd * 100)
            If e > 50 Then
                d = d & c & g
            Else
                d = c & g & d
            End If

        Next
        If d <> "" Then d = Left(d, Len(d) - Len(g))
        a = Split(d, g) : d = ""
    Next
    arrayRandomShow = a
End Function

Sub printArray(a)
    Dim b, c
    For b = 0 To UBound(a)
        c = a(b)
        Call echo(b, c)
    Next
End Sub

Sub echoArray(a)
    Call PrintArray(a)
End Sub

Function str_Shuffle(a)
    Dim b, c, d, e
    Randomize
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If d = "" Then
            d = c
        ElseIf Len(d) = 1 Then
            e = CInt(Rnd * 100)
            If e > 50 Then
                d = d & c
            Else
                d = c & d
            End If
        Else
            e = CInt(Rnd * Len(d)) + 1
            d = Mid(d, 1, e) & c & Mid(d, e + 1)
        End If
    Next
    str_Shuffle = d
End Function

Function characterUpset(a)
    characterUpset = str_Shuffle(a)
End Function

Function str_Split(a, b)
    Dim c, d, e, f, ArrStr(99), h
    If b <= 0 Then b = 1
    f = 0 : h = 0
    For c = 1 To Len(a)
        d = Mid(a, c, 1)
        e = e & d
        f = f + 1
        If f = b Then
            ArrStr(h) = e
            e = "" : f = 0
            h = h + 1
        End If
    Next
    str_Split = ArrStr
End Function

Function removeNullValueArray(a, b)
    removeNullValueArray = HandleArray(a, b, "nonull")
End Function

Function removeRepeatValueArray(a, b)
    removeRepeatValueArray = HandleArray(a, b, "norepeat")
End Function

Function handleArray(a, b, c)
    Dim d, e, f, g
    c = "|" & LCase(c) & "|"
    d = Split(a, b)
    For Each e In d
        g = True
        If InStr(c, "|nonull|") > 0 And g = True Then
            If e = "" Then g = False
        End If
        If InStr(c, "|norepeat|") > 0 And g = True Then
            If InStr(b & f & b, b & e & b) > 0 Then g = False
        End If
        If g = True Then f = f & e & b
    Next
    If f <> "" Then f = Left(f, Len(f) - Len(b))
    handleArray = f
End Function

Function arrayToString(a, b)
    Dim c, d
    For Each c In a
        If c <> "" Then
            d = d & c & b
        End If
    Next
    arrayToString = d
End Function

Function testArrayData()
    Dim b
    b = Array(3, 2, 4, 1, 6, 0)
    Call ResponseArray(b, "原来顺序")
    Call ResponseArray(SelectSort(b), "选择排序")
    Call ResponseArray(QuickSort(b), "快速排序")
    Call ResponseArray(InsertSort(b), "插入排序")
    Call ResponseArray(BubbleSort(b), "冒泡排序")
    Call ResponseArray(ReQuickSort(b), "反序排序")
    Response.Write "<b>最 大 值：</b>" & Max(b) & "<hr>"
    Response.Write "<b>最 小 值：</b>" & Min(b) & "<hr>"
End Function



Function selectSort(a)
    Dim b, c, d
    Dim e, f
    e = UBound(a)

    For b = 0 To e - 1
        d = b
        For c = b + 1 To e
            If a(d) > a(c) Then
                d = c
            End If
        Next
        f = a(b)
        a(b) = a(d)
        a(d) = f
    Next
    selectSort = a
End Function



Function quickSort(a)
    Dim b, c
    Dim d, e
    d = UBound(a)
    For b = 0 To d - 1
        For c = b + 1 To d
            If a(b) > a(c) Then
                e = a(b)
                a(b) = a(c)
                a(c) = e
            End If
        Next
    Next
    quickSort = a
End Function



Function bubbleSort(a)
    Dim b
    b = UBound(a)
    Dim c, d, e
    c = False
    Do While b > 0 And c = False
        c = True
        For d = 0 To b - 1
            If a(d) > a(d + 1) Then
                e = a(d)
                a(d) = a(d + 1)
                a(d + 1) = e
                c = False
            End If
        Next
        b = b - 1
    Loop

    bubbleSort = a
End Function



Function insertSort(a)
    Dim b
    b = UBound(a)
    Dim c, d, e

    For c = 1 To b
        e = a(c)
        d = c
        Do While e < a(d - 1) And d > 0
            a(d) = a(d - 1)
            d = d - 1
        Loop
        a(d) = e
    Next
    insertSort = a
End Function



Function reQuickSort(a)
    Dim b, c, d
    a = quickSort(a)
    d = quickSort(a)
    c = UBound(a)
    For b = 0 To c
        a(b) = d(c - b)
    Next
    reQuickSort = a
End Function

Function arrayReverse()
    arrayReverse = reQuickSort(a_Data)
End Function



Sub responseArray(a, b)
    Dim c, d
    c = ""
    Response.Write "<b>" & b & "：</b>"
    For d = 0 To UBound(a)
        c = c & a(d) & ","
    Next
    c = Left(c, Len(c) - 1)
    Response.Write c
    Response.Write "<hr>"
End Sub



Function max(a)
    Dim b, c, d, e
    a = quickSort(a)
    d = UBound(a)
    For b = 0 To d
        For c = b + 1 To d
            If a(c) > a(b) Then
                e = a(b)
                a(b) = a(c)
                a(c) = e
            End If
        Next
    Next
    max = a(0)
End Function



Function min(a)
    Dim b, c, d, e
    a = quickSort(a)
    d = UBound(a)
    For b = 0 To d
        For c = b + 1 To d
            If a(c) > a(b) Then
                e = a(b)
                a(b) = a(c)
                a(c) = e
            End If
        Next
    Next
    min = a(d)
End Function





Function testTwoDimensionalArray()
    Dim b, c
    b = HandleSplitArray("9-g|2-b|3-a|1-中", "|", "-")
    For c = 0 To UBound(b)
        Call echo(b(c, 1), b(c, 0)) : Doevents
    Next
    Call echo("", "Ａｄｃ")
    Call TwoDimensionalArrayAsc(b)
    For c = 0 To UBound(b)
        Call echo(b(c, 1), b(c, 0)) : Doevents
    Next
    Call echo("", "Desc")
    Call TwoDimensionalArrayDesc(b)
    For c = 0 To UBound(b)
        Call echo(b(c, 1), b(c, 0)) : Doevents
    Next
End Function


Function handleSplitArray(a, b, c)
    Dim d, e, f, g, h, i, j, k, l, m
    m = "[|Array|]"
    f = Split(a, b)
    For h = 0 To UBound(f)
        If f(h) <> "" Then
            g = Split(f(h), c)
            d = d & g(0) & m
            e = e & g(1) & m
        End If
    Next
    If d <> "" Then d = Left(d, Len(d) - Len(m))
    If e <> "" Then e = Left(e, Len(e) - Len(m))
    d = Split(d, m)
    e = Split(e, m)

    ReDim f(UBound(d), UBound(e))
    For h = 0 To UBound(d)
        f(h, 0) = d(h)
        f(h, 1) = e(h)
    Next
    handleSplitArray = f
End Function

Function twoDimensionalArrayAsc(a)
    Dim b, c, d
    For b = 0 To UBound(a)
        If IsNul(a(b, 0)) = False Then
            For c = b To UBound(a)
                If a(b, 0) > a(c, 0) Then
                    d = a(b, 0)
                    a(b, 0) = a(c, 0)
                    a(c, 0) = d
                    d = a(b, 1)
                    a(b, 1) = a(c, 1)
                    a(c, 1) = d
                End If
            Next
        End If
    Next
    twoDimensionalArrayAsc = a
End Function

Function twoDimensionalArrayDesc(a)
    Dim b, c, d
    For b = 0 To UBound(a)
        If IsNul(a(b, 0)) = False Then
            For c = b To UBound(a)
                If a(b, 0) < a(c, 0) Then
                    d = a(b, 0)
                    a(b, 0) = a(c, 0)
                    a(c, 0) = d
                    d = a(b, 1)
                    a(b, 1) = a(c, 1)
                    a(c, 1) = d
                End If
            Next
        End If
    Next
    twoDimensionalArrayDesc = a
End Function
%>


