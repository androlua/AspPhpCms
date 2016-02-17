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



Function UTF2GB(ByVal a)
    Dim b, c
    For b = 1 To Len(a)

        If Mid(a, b, 1) = "%" Then

            If Len(a) >= b + 8 Then
                c = c & ConvChinese(Mid(a, b, 9))
                b = b + 8
            Else
                c = c & Mid(a, b, 1)
            End If
        Else
            c = c & Mid(a, b, 1)
        End If
    Next
    UTF2GB = c
End Function


Function CheckUTFToGB2312(ByVal a)
    Dim b, c
    CheckUTFToGB2312 = True
    For b = 1 To Len(a)

        If Mid(a, b, 1) = "%" Then

            If Len(a) >= b + 8 Then
                If ConvChinese(Mid(a, b, 9)) = "[出错Error]" Then
                    CheckUTFToGB2312 = False : Exit Function
                End If
                b = b + 8
            Else
                c = c & Mid(a, b, 1)
            End If
        Else
            c = c & Mid(a, b, 1)
        End If
    Next
End Function


Function ConvChinese(a)
    On Error Resume Next
    Err.Clear
    Dim b, c, d, e, f
    b = Split(Mid(a, 2), "%")
    c = 0
    d = 0
    For c = 0 To UBound(b)
        b(c) = c16to2(b(c))
    Next
    For c = 0 To UBound(b) - 1
        e = InStr(b(c), "0")
        f = ""
        For d = 1 To e - 1
            If d = 1 Then
                b(c) = Right(b(c), Len(b(c)) - e)
                f = f & b(c)
            Else
                c = c + 1
                b(c) = Right(b(c), Len(b(c)) - 2)
                f = f & b(c)
            End If
        Next

        If Len(c2to16(f)) = 4 Then
            ConvChinese = ConvChinese & ChrW(Int("&H" & c2to16(f)))
        Else
            ConvChinese = ConvChinese & Chr(Int("&H" & c2to16(f)))
        End If
        If Err <> 0 Then ConvChinese = "[出错Error]" : Exit Function
    Next
End Function




Function UTF8_URLEncoding(a)
    Dim b, c, d
    Dim e
    Dim f
    If a = "" Then
        UTF8_URLEncoding = a
        Exit Function
    End If
    For e = 1 To Len(a)
        b = Mid(a, e, 1)
        f = AscW(b)

        If f < 0 Then f = f + 65536

        If(f And &HFF80) = 0 Then
            d = d & b
        Else
            If(f And &HF000) = 0 Then
                c = "%" & Hex(((f \ 2 ^ 6)) Or &HC0) & Hex(f And &H3F Or &H80)
                d = d & c
            Else
                c = "%" & Hex((f \ 2 ^ 12) Or &HE0) & "%" & _
                Hex((f \ 2 ^ 6) And &H3F Or &H80) & "%" & _
                Hex(f And &H3F Or &H80)
                d = d & c
            End If
        End If
    Next
    UTF8_URLEncoding = d
End Function


Function toUTF8(a)
    Dim b, c, d
    Dim e
    Dim f

    If a = "" Then
        toUTF8 = a
        Exit Function
    End If

    For e = 1 To Len(a)

        b = Mid(a, e, 1)


        f = AscW(b)
        If f < 0 Then f = f + 65536

        If(f And &HFF80) = 0 Then
            d = d & b
        Else
            If(f And &HF000) = 0 Then
                c = "%" & Hex(((f / 2 ^ 6)) Or &HC0) & Hex(f And &H3F Or &H80)
                d = d & c
            Else

                c = "%" & Hex((f / 2 ^ 12) Or &HE0) & "%" & _
                Hex((f / 2 ^ 6) And &H3F Or &H80) & "%" & _
                Hex(f And &H3F Or &H80)
                d = d & c
            End If
        End If
    Next

    toUTF8 = d
End Function


Function chinese2unicode(a)
    Dim b
    Dim c
    Dim d
    If(IsNull(a)) Then
        Exit Function
    End If
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        d = d & Chr(38)
        d = d & Chr(35)
        d = d & Chr(120)
        d = d & Hex(AscW(c))
        d = d & Chr(59)
    Next
    chinese2unicode = d
End Function



Function isvalidhex(a)
    Dim b
    isvalidhex = True
    a = UCase(a)
    If Len(a) <> 3 Then isvalidhex = False : Exit Function
    If Left(a, 1) <> "%" Then isvalidhex = False : Exit Function
    b = Mid(a, 2, 1)
    If Not(((b >= "0") and(b <= "9")) Or((b >= "A") and(b <= "Z"))) Then isvalidhex = False : Exit Function
    b = Mid(a, 3, 1)
    If Not(((b >= "0") and(b <= "9")) Or((b >= "A") and(b <= "Z"))) Then isvalidhex = False : Exit Function
End Function



Function escape(a)
    Dim b, c, d, e
    c = ""
    For b = 1 To Len(a)
        d = Mid(a, b, 1)
        e = AscW(d)
        If(e >= 48 And e <= 57) Or(e >= 65 And e <= 90) Or(e >= 97 And e <= 122) Then
            c = c & d
        ElseIf InStr("@*_-./", d) > 0 Then
            c = c & d
        ElseIf e > 0 And e < 16 Then
            c = c & "%0" & Hex(e)
        ElseIf e >= 16 And e < 256 Then
            c = c & "%" & Hex(e)
        Else
            c = c & "%u" & Hex(e)
        End If
    Next
    escape = c
End Function



Function unescape(a)
    Dim b, c, d, e, f, g, h
    e = False
    f = ""
    c = ""
    For b = 1 To Len(a)
        d = Mid(a, b, 1)
        If d = "+" Then
            c = c & " "
        ElseIf Mid(a, b, 2) = "%u" And b <= Len(a) - 5 Then
            If IsNumeric("&H" & Mid(a, b + 2, 4)) Then
                c = c & ChrW(CInt("&H" & Mid(a, b + 2, 4)))
                b = b + 5
            Else
                c = c & d
            End If







        ElseIf d = "%" And b <= Len(a) - 2 Then
            g = Mid(a, b + 1, 2)
            If IsNumeric("&H" & g) Then
                h = CInt("&H" & g)
                If e = True Then
                    e = False
                    c = c & Chr(CInt("&H" & f & g))
                Else
                    If Abs(h) <= 127 Then
                        c = c & Chr(h)
                    Else
                        e = True
                        f = g
                    End If
                End If
                b = b + 2
            Else
                c = c & d
            End If
        Else
            c = c & d
        End If
    Next
    unescape = c
End Function


Function ChineseToUnicode(a)
    Dim b, c, d
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        c = "&#x" & Hex(AscW(c)) & ";"
        d = d & c
    Next
    ChineseToUnicode = d
End Function


Function UnicodeToChinese(a)
    Dim b, c, d
    b = Split(a, ";")
    For Each c In b
        If InStr(c, "&#x") > 0 Then
            c = Right(c, Len(c) - 3)
            d = d & ChrW(CInt("&H" & c))
        End If
    Next
    UnicodeToChinese = d
End Function




Function URLEncode(ByRef a)
    Dim b
    Dim c
    For b = 1 To Len(a)
        If Asc(Mid(a, b, 1)) < 0 Then
            c = "%" & Right(CStr(Hex(Asc(Mid(a, b, 1)))), 2)
            c = "%" & Left(CStr(Hex(Asc(Mid(a, b, 1)))), Len(CStr(Hex(Asc(Mid(a, b, 1))))) - 2) & c
            URLEncode = URLEncode & c
        ElseIf(Asc(Mid(a, b, 1)) >= 65 And Asc(Mid(a, b, 1)) <= 90) Or(Asc(Mid(a, b, 1)) >= 97 And Asc(Mid(a, b, 1)) <= 122) Then
            URLEncode = URLEncode & Mid(a, b, 1)
        Else
            URLEncode = URLEncode & "%" & Hex(Asc(Mid(a, b, 1)))
        End If
    Next
End Function


Function URLDecode(ByRef a)
    Dim b
    If InStr(a, "%") = 0 Then URLDecode = a : Exit Function
    For b = 1 To Len(a)
        If Mid(a, b, 1) = "%" Then
            If Val("&H" & Mid(a, b + 1, 2)) > 127 Then
                URLDecode = URLDecode & Chr(Val("&H" & Mid(a, b + 1, 2) & Mid(a, b + 4, 2)))
                b = b + 5
            Else
                URLDecode = URLDecode & Chr(Val("&H" & Mid(a, b + 1, 2)))
                b = b + 2
            End If
        Else
            URLDecode = URLDecode & Mid(a, b, 1)
        End If
    Next
End Function


Function GBtoUTF8(a)
    Dim b, c, d
    Dim e
    Dim f

    If a = "" Then
        GBtoUTF8 = a
        Exit Function
    End If

    For e = 1 To Len(a)
        b = Mid(a, e, 1)
        f = AscW(b)
        If f < 0 Then f = f + 65536
        If(f And &HFF80) = 0 Then
            d = d & b
        Else
            If(f And &HF000) = 0 Then
                c = "%" & Hex(((f \ 2 ^ 6)) Or &HC0) & Hex(f And &H3F Or &H80)
                d = d & c
            Else
                c = "%" & Hex((f \ 2 ^ 12) Or &HE0) & "%" & _
                Hex((f \ 2 ^ 6) And &H3F Or &H80) & "%" & _
                Hex(f And &H3F Or &H80)
                d = d & c
            End If
        End If
    Next
    GBtoUTF8 = d
End Function


Function EncDecURL(ByVal a, ByVal b)
    Dim c, d, e, f, g, h
    c = "abcdefghijklmnopqrstuvwxyz0123456789:/.=& ()%"
    d = "9ab1cdefghij234klmnopqrst678uvwxyz:/.05*-$[]@"
    If b = "解密" Or b = "0" Then
        e = c
        c = d
        d = e
    End If
    For f = 1 To Len(a)
        g = Mid(a, f, 1)
        If InStr(c, g) > 0 Then
            g = Mid(d, InStr(c, g), 1)
        End If
        h = h & g
    Next
    EncDecURL = h
End Function


Function EncURL(a)
    EncURL = EncDecURL(a, "加密")
End Function


Function DecURL(a)
    DecURL = EncDecURL(a, "解密")
End Function

%>


