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


function isStrTransferred(a)
	dim b,c,d,e
	e=0
	for c = 0 to len(a)-1
		d=mid(a,len(a)-c,1)
		if d="\" then
			e=e+1
		else
			isStrTransferred=IIF(e mod 2=1,true,false)
			exit function
		end if
	next
end function


Function getBL(a, b, c)
    Dim splStr(3)
    Dim e : e = 1
    Dim f : f = 1
    Dim g
    Dim h
    If a < 0 Then
        a = a * - 1
        e = -1
    End If
    If b < 0 Then
        b = b * - 1
        f = -1
    End If
    If a > b Then
        g = FormatNumber(a / b, 2)
        splStr(0) = g
        splStr(1) = 1
    Else
        g = FormatNumber(b / a, 2)
        splStr(0) = 1
        splStr(1) = g
    End If


    h = FormatNumber(c / g, 2)
    splStr(0) = splStr(0) * h
    splStr(1) = splStr(1) * h


    splStr(0) = splStr(0) * e
    splStr(1) = splStr(1) * f
    splStr(2) = g
    splStr(3) = GetCountPage(a, splStr(0))
    Call echo("page count 页数", splStr(3))
    splStr(3) = getCountStep(a, b, splStr(0), splStr(1), splStr(3))

    getBL = splStr
End Function


Function getCountStep(a, b, c, d, e)
    Dim f
    getCountStep = ""
    If a < 0 Then
        a = a * - 1
    End If
    If b < 0 Then
        b = b * - 1
    End If
    If c < 0 Then
        c = c * - 1
    End If
    If d < 0 Then
        d = d * - 1
    End If
    For f = e - 10 To e

        If c * f >= a Or d * f >= b Then
            getCountStep = f

        End If
    Next
End Function



Function getChina(a)
    Dim b, c, d, e
    For b = 1 To Len(a)
        d = Asc(Mid(a, b, 1))
        e = Mid(a, b, 1)

        If d < 0 Then
            If(d <= -22033 And d >= -24158) = False Then
                c = c & e
            End If
        End If
    Next
    getChina = c
End Function

Function isChina(a)
    Dim b, c, d
    For b = 1 To Len(a)
        c = Asc(Mid(a, b, 1))
        d = Mid(a, b, 1)

        If c < 0 Then
            If(c <= -22033 And c >= -24158) = False Then
                isChina=true
				exit function
            End If
        End If
    Next
	isChina=false
End Function

Function checkChina(a)
	checkChina=isChina(a)
End Function


Function pHPRand(a, b)
    Randomize
    pHPRand = ""
    Dim c
    For c = 1 To 9
        pHPRand = CInt((a + b) * Rnd)
        If pHPRand >= a And pHPRand <= b Then
            Exit For
        End If
    Next
    If pHPRand < a Then
        pHPRand = a
    ElseIf pHPRand > b Then
        pHPRand = b
    End If
End Function


Function pHPRnd(a, b)
    pHPRnd = pHPRand(a, b)
End Function



Function deleteRepeatStr(a, b)
    Dim c, d, e
    e = ""
    c = Split(a, b)
    For Each d In c
        If d <> "" Then
            If InStr(b & e & b, b & d & b) = False Then
                e = e & d & b
            End If
        End If
    Next
    If e <> "" Then e = Left(e, Len(e) - Len(b))
    deleteRepeatStr = e
End Function


Function replaceN(a, b, c, d)
    Dim e
    d = HandleNumber(d)
    If d = "" Then
        d = 1
    Else
        d = CInt(d)
    End If
    For e = 1 To d
        a = Replace(a, b, c)
    Next

    replaceN = a
End Function


Public Function fillZero(a)
    If Len(a) = 1 Then
        fillZero = "0" & a
    Else
        fillZero = a
    End If
End Function


Function caseInsensitiveReplace(a, b, c)
    Dim d, e, f, g, h, i, j
    i = ""
    If LCase(b) = LCase(c) Then
        caseInsensitiveReplace = a
    End If
    f = LCase(a)
    For j = 1 To 99
        If InStr(f, b) > 0 Then
            d = InStr(f, b) - 1
            g = Left(a, d)
            e = d + Len(b) + 1
            h = Mid(a, e)
            a = g & c & h



            f = LCase(a)
        Else
            Exit For
        End If
    Next
    caseInsensitiveReplace = a
End Function


Function array_Sort(a)
    Dim b, c, d, e, f
    For b = UBound(a) To 0 Step - 1
        e = a(b)
        d = 0
        For c = 1 To b
            If a(c) > e Then
                e = a(c)
                d = c
            End If
        Next
        If d <> b Then
            f = a(d)
            a(d) = a(b)
            a(b) = f
        End If
    Next
    array_Sort = a
End Function


Function handleZipSize(ByVal a)
    On Error Resume Next
    Dim b
    a = LCase(a)
    b = GetDianNumb(a)
    If InStr(a, "g") Then
        b = b * 1073741824
    ElseIf InStr(a, "m") Then
        b = b * 1048576
    ElseIf InStr(a, "k") Then
        b = b * 1024
    End If
    handleZipSize = b
    If Err Then doError Err.Description, "HandleZipSize 处理Zip大小 函数出错，ZipSize=" & a
End Function


Function getRnd(ByVal a)
    Randomize
    Dim b, c, d
    For c = 1 To a
        If c Mod 2 = 0 Then
            b = ChrW((57 - 48) * Rnd + 48)
        ElseIf c Mod 3 = 0 Then
            b = ChrW((90 - 65) * Rnd + 65)
        Else
            b = ChrW((122 - 97) * Rnd + 97)
        End If
        d=d & b
    Next
	getRnd=d
End Function


Function mathRandom()
    Dim b, c
    c = ""
    Randomize
    For b = 1 To 16
        c = c & Int(Rnd() * 9)
    Next
    mathRandom = "0." & c
End Function



Function getRndAZ(a)
    Dim b, c, d, e
    e = "" : b = ""
    Randomize
    b = "abcdefghijklmnopqrstuvwxyz" & UCase(b)
    For c = 1 To a
        d = Mid(b, pHPRnd(1, Len(b)), 1)
        e = e & d
    Next
    getRndAZ = e
End Function


Function getRand(ByVal a)
    getRand = getRnd(a)
End Function



Function copyStrNumb(ByVal a, b)
    Dim c, d
    If b > 0 Then
        d = a
        For c = 1 To b - 1
            a = a & d
        Next
    Else
        a = ""
    End If
    copyStrNumb = a
End Function


Function str_Repeat(ByVal a, b)
    str_Repeat = copyStrNumb(a, b)
End Function


Function copyStr(a, b)
    copyStr = copyStrNumb(a, b)
End Function


Function contentAddTab(ByVal a, b)
    contentAddTab = copyStr("    ", b) & Join(Split(a, vbCrLf), vbCrLf & copyStr("    ", b))
End Function


Function deleteEndStr(a, b)
    If a <> "" Then a = Left(a, Len(a) - b)
    deleteEndStr = a
End Function



Function toNumber(ByVal a, ByVal b)
    toNumber = FormatNumber(a, b, - 1)
End Function


Function handleNumber(ByVal a)
    Dim b, c, d
    d = ""
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789", c) > 0 Then
            d = d & c
        End If
    Next
    handleNumber = d
End Function


Function strDrawInt(ByVal a)
    strDrawInt = handleNumber(a)
End Function


Function getFirstNegativeNumber(ByVal a)
    Dim b, c, d
    d = ""
    a = Trim(a)
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If c = "-" And d = "" Then
            d = d & c
        ElseIf InStr("0123456789", c) > 0 Then
            d = d & c
        End If
    Next
    If d = "" Then d = 0
    getFirstNegativeNumber = d
End Function


Function checkNumberType(ByVal a)
    checkNumberType = handleNumber(a)
End Function


Function checkStrIsNumberType(ByVal a)
    Dim b, c
    checkStrIsNumberType = True
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789", c) = False Then
            checkStrIsNumberType = False
            Exit Function
        End If
    Next
End Function


Function handleNumberType(ByVal a)
    Dim b, c, d
    d = ""
    a = Trim(a)
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If b = 1 And InStr("+-*/", Left(a, 1)) > 0 Then
            d = d & c
        ElseIf b > 1 And c = "." Then
            d = d & c
        ElseIf InStr("0123456789", c) > 0 Then
            d = d & c
        End If
    Next
    handleNumberType = d
End Function


Function getNumber(ByVal a)
    Dim b, c, d
    d = ""
    a = Trim(a)
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789", c) > 0 Then
            If d = "" And c = "0" Then
            Else
                d = d & c
            End If
        End If
    Next
    getNumber = ""
    If d <> "" Then
        getNumber = Int(d)
    End If
End Function


Function checkNumb(a)
    If InStr("0123456789.", a) > 0 Then
        checkNumb = True
    Else
        checkNumb = False
    End If
End Function


Function getDianNumb(ByVal a)
    Dim b, c, d
    d = ""
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789.", c) > 0 Then
            d = d & c
        End If
    Next
    getDianNumb = d
End Function


Function getCountPage(a, b)

	dim c
    If a < 0 Then
        a = a * - 1
    End If
    If b < 0 Then
        b = b * - 1
    End If
    c = Fix(a / b)
    If InStr(a / b, ".") > 0 Then c = c + 1
	getCountPage=c
End Function


Function getPageNumb(a, b)
	dim c
    c = Int(a / b)
    If a Mod b > 0 Then
        c=c + 1
    End If
	getPageNumb=c
End Function


Function getCaiHandleCountPage(a)
    a = DelHtml(a)
    a = handleNumber(a)
    getCaiHandleCountPage = ""
    If Len(a) < 10 Then
        getCaiHandleCountPage = Right(a, 1)
    ElseIf Len(a) < 200 Then
        getCaiHandleCountPage = Right(a, 2)
    End If
End Function


Function getCaiSortCountPage(ByVal a)
    Dim b, c
    getCaiSortCountPage = ""
    a = DelHtml(a)
    a = handleNumber(a)
    For b = 1 To 30
        c = Mid(a, 1, Len(b))
        If c = CStr(b) Then
            getCaiSortCountPage = b

            a = Right(a, Len(a) - Len(b))
        End If
    Next
End Function


Function minMaxBetween(a, b, c)
    a = CInt(a)
    b = CInt(b)
    c = CInt(c)
    If a > b Then
        minMaxBetween = b
    ElseIf c > a Then
        minMaxBetween = c
        If c > b Then
            minMaxBetween = b
        End If
    Else
        minMaxBetween = a
    End If
End Function


Function getStrFileType(a)
    Dim b
    b = ""
    If InStr(a, ".") > 0 Then
        b = LCase(Mid(a, InStrRev(a, ".") + 1))
        If InStr(b, "?") > 0 Then
            b = Mid(b, 1, InStr(b, "?") - 1)
        End If
    End If
    getStrFileType = b
End Function


Function val(ByVal a)
    If a & "" = "" Or Not IsNumeric(a) Then
        val = 0
    Else
        val = CLng(a)
    End If
End Function


Function strLen(a)
    If IsNull(a) Or a = "" Then
        strLen = 0
    Else
        Dim b, c, d, e
        d = 0
        c = Len(a)
        For b = 1 To c


            e = Mid(a, b, 1)







            If e < 0 Then e = e + 65536
            If e < 255 Then d = d + 1
            If e > 255 Then d = d + 2

        Next
        strLen = d
    End If
End Function


Function addIndent(a, b)
    Dim c, d, e
    e = ""
    c = Split(a, vbCrLf)
    For Each d In c
        e = e & b & d & vbCrLf
    Next
    addIndent = TrimVbCrlf(e)
End Function


Function getNumberBeforeStr(a)
    Dim b, c, d
    d = ""
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789", c) > 0 Then Exit For
        d = d & c
    Next
    getNumberBeforeStr = d
End Function



Function makePassword(ByVal a)
    Dim b
    Dim c, d, e, f
    Randomize
    b = ""
    For f = 1 To a
        c = Int((1 - 0 + 1) * Rnd + 0)
        If c = 0 Then
            d = 90
            e = 65
        Else
            d = 57
            e = 48
        End If
        b = b & Chr(Int((d - e + 1) * Rnd + e))
    Next
    makePassword = b
End Function




Function rndcode(ByVal a, ByVal b)
    Dim c, d
    Randomize
    rndcode = ""
    c = Int(a * Rnd + b - a)
    For d = 1 To c
        Randomize
        rndcode = rndcode & Chr(Int(127 * Rnd + 1))
    Next
End Function



Function getRandomPhoneNumber(a)
    Dim b, c, d, e
    e = "" : c = ""
    d = 1
    Do While d < a
        Randomize
        Do While Len(c) < 9
            b = CStr(Chr((57 - 48) * Rnd + 48))
            c = c & b
        Loop
        e = e & 13 & c & vbCrLf
        c = ""
        d = d + 1
    Loop
    If e <> "" Then e = Left(e, Len(e) - 2)
    getRandomPhoneNumber = e
End Function


Function lenStr(a)
    Dim b, c, d
    d = ""
    Dim e
    b = Len(a)
    c = 0
    For e = 1 To b
        d = Asc(Mid(a, e, 1))
        If d < 0 Then d = d + 65536
        If d < 255 Then c = c + 1
        If d > 255 Then c = c + 2
    Next
    lenStr = c
End Function


Function toString(ByVal a)
    If IsArray(a) Then
        Dim b
        b = Join(a, ",")
        toString = b
    Else
        toString = a
    End If
End Function

Function remoteNumber(a)
    Dim b, c, d
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789.", c) = False Then
            d = d & c
        End If
    Next
    remoteNumber = d
End Function




Function handleHaveStr(a, b)
    Dim c, d
    handleHaveStr = False
    For d = 1 To Len(b)
        c = Mid(b, d, 1)
        If InStr(a, c) > 0 Then
            handleHaveStr = True
            Exit Function
        End If
    Next
End Function

Function haveLowerCase(a)
    haveLowerCase = handleHaveStr(a, "abcdefghijklmnopqrstuvwxyz")
End Function

Function haveUpperCase(a)
    haveUpperCase = handleHaveStr(a, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
End Function

Function haveNumber(a)
    haveNumber = handleHaveStr(a, "0123456789")
End Function

Function haveChina(a)
    Dim b, c
    haveChina = False
    For b = 1 To Len(a)
        c = Asc(Mid(a, b, 1))

        If c < 0 Then
            If(c <= -22033 And c >= -24158) = False Then
                haveChina = True
                Exit Function
            End If
        End If
    Next
End Function

%>




