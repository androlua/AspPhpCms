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




Function specialHtmlUploadEncryptionDecrypt(a, b)
    Dim c, d, e, f
    e = "·|[*-24156*]" & vbCrLf
    c = Split(e, vbCrLf)
    For Each f In c
        If InStr(f, "|") > 0 Then
            d = Split(f, "|")
            If b = "1" Or b = "解密" Or b = "Decrypt" Then
                a = Replace(a, d(1), d(0))
            Else
                a = Replace(a, d(0), d(1))
            End If
        End If
    Next
    specialHtmlUploadEncryptionDecrypt = a
End Function


Function encAspContent(ByVal a)
    Dim b, c, d, e
    c = "Str=Str&""|Str=Str & |If | Then|End If|&vbCrlf|Temp |Rs(|Rs.|.AddNew|(""Title"")|(""Content"")|=False|ElseIf|"
    c = c & "Conn.Execute(""| Exit For|[Product]|.Open|.Close|Exit For|Exit Function|MoveNext:Next:|Str "
    b = Split(c, "|")
    For Each d In b
        If d <> "" Then
            e = UpperCaseORLowerCase(d)
            a = Replace(a, Chr(9), "")
            a = Replace(a, d, e)
        End If
    Next
    encAspContent = a
End Function

Function upperCaseORLowerCase(ByVal a)
    Dim b, c, d, e
    d = ""
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        Randomize
        e = CInt(Rnd() * 1)
        If e = 0 Then
            d = d & LCase(c)
        Else
            d = d & UCase(c)
        End If
    Next
    upperCaseORLowerCase = d
End Function

Function encCode(ByVal a)
    Dim b, c
    c = ""
    For b = 1 To Len(a)
        c = c & "%" & Hex(Asc(Mid(a, b, 1)))
    Next
    encCode = c
End Function

Function decCode(ByVal a)
    Dim b, c, d
    c = ""
    d = Split(a, "%")
    For b = 1 To UBound(d)
        If d(b) <> "" Then
            c = c & Chr(CInt("&H" & d(b)))
        End If
    Next
    decCode = c
End Function

Public Function toUnicode(a)
    Dim b, c, d, e
    toUnicode = ""
    d = ""
    e = ""
    For b = 1 To Len(a)
        d = Mid(a, b, 1)
        c = AscW(d)
        If c < 0 Then
            c = c + 65536
        End If
        If c >= 0 And c <= 128 Then
            If e = "c" Then
                toUnicode = " " & toUnicode
                e = "e"
            End If
            toUnicode = toUnicode & d
        Else
            If e = "e" Then
                toUnicode = toUnicode & " "
                e = "c"
            End If
            toUnicode = toUnicode & "&#" & c & ";"
        End If
    Next
End Function

Function japan(ByVal a, b)
    If IsNull(a) Or IsEmpty(a) Then
        japan = ""
        Exit Function
    End If
    Dim c, d, e
    If b = "" Then b = 0




    e = Split("Jn0;,Jn1;,Jn2;,Jn3;,Jn4;,Jn5;,Jn6;,Jn7;,Jn8;,Jn9;,Jn10;,Jn11;,Jn12;,Jn13;,Jn14;,Jn15;,Jn16;,Jn17;,Jn18;,Jn19;,Jn20;,Jn21;,Jn22;,Jn23;,Jn24;,Jn25;", ",")


    c = Split(Chr( -23116) & "," & Chr( -23124) & "," & Chr( -23122) & "," & Chr( -23120) & "," & Chr( -23118) & "," & Chr( -23114) & "," & Chr( -23112) & "," & Chr( -23110) & "," & Chr( -23099) & "," & Chr( -23097) & "," & Chr( -23095) & "," & Chr( -23075) & "," & Chr( -23079) & "," & Chr( -23081) & "," & Chr( -23085) & "," & Chr( -23087) & "," & Chr( -23052) & "," & Chr( -23076) & "," & Chr( -23078) & "," & Chr( -23082) & "," & Chr( -23084) & "," & Chr( -23088) & "," & Chr( -23102) & "," & Chr( -23104) & "," & Chr( -23106) & "," & Chr( -23108), ",")
    japan = a
    For d = 0 To 25
        If b = 0 Then
            japan = Replace(japan, c(d), e(d))
        Else
            japan = Replace(japan, e(d), c(d))
        End If
    Next
End Function

Function japan26(a)
    japan26 = japan(a, 0)
End Function

Function unJapan26(a)
    unJapan26 = japan(a, 1)
End Function

Function handleHTML(ByVal a)

    a = Replace(a, "<", "&lt;")
    handleHTML = a
End Function

Function unHandleHTML(ByVal a)

    a = Replace(a, "&lt;", "<")
    unHandleHTML = a
End Function

Function lcaseEnc(a)
    Dim b, c, d, e
    e = ""
    For b = 1 To Len(a)
        d = Mid(a, b, 1)
        c = AscW(d)
        If c >= 97 And c <= 122 Then
            e = e & ChrW(c + 1)
        Else
            e = e & d
        End If
    Next
    e = Replace(e, vbCrLf, "＠")
    lcaseEnc = e
End Function

Function lcaseDec(a)
    Dim b, c, d, e
    e = ""
    For b = 1 To Len(a)
        d = Mid(a, b, 1)
        c = AscW(d)
        If c >= 97 And c <= 123 Then
            e = e & ChrW(c - 1)
        Else
            e = e & d
        End If
    Next
    e = Replace(e, "＠", vbCrLf)
    lcaseDec = e
End Function




Function htmlToJs(ByVal a)
    a = Replace("" & a, "\", "\\")
    a = Replace(a, "/", "\/")
    a = Replace(a, "'", "\'")
    a = Replace(a, """", "\""")
    a = Join(Split(a, vbCrLf), """);" & vbCrLf & "document.write(""")
    a = "document.write(""" & a & """);"
    htmlToJs = a
End Function

Function jsToHtml(ByVal a)
    a = Replace(a, "document.write(""", "")
    a = Replace(a, """);", "")
    a = Replace(a, "\""", """")
    a = Replace(a, "\'", "'")
    a = Replace(a, "\/", "/")
    a = Replace(a, "\\", "\")
    jsToHtml = a
End Function

Function htmlToAsp(ByVal a)
    a = Replace(a, """", """""")
    a = Join(Split(a, vbCrLf), """)" & vbCrLf & "Response.Write(""")
    a = "Response.Write(""" & a & """)"
    htmlToAsp = a
End Function

Function htmlToAspDim(ByVal a)
    a = Replace(a, """", """""")
    a = Join(Split(a, vbCrLf), """" & vbCrLf & "C=C & """)
    a = "C=C & """ & a & """"
    htmlToAspDim = a
End Function

Function aspToHtml(ByVal a)
    a = Replace(a, "Response.Write(""", "")
    a = Replace(a, """""", """")
    aspToHtml = a
End Function

Function setFileName(ByVal a)
    Dim b, c, d, e, f
    d = "\/:*?""<>|.,"
    f = "撇揦：星？“左右横。，"
    For b = 1 To Len(d)
        c = Mid(d, b, 1)
        e = Mid(f, b, 1)
        a = Replace(a, c, e)
    Next
    a = Replace(a, "&nbsp;", " ")
    a = Replace(a, "&quot;", "双")
    a = Replace(a, vbCrLf, "")
    setFileName = a
End Function

Function unSetFileName(ByVal a)
    Dim b, c, d, e, f
    d = "\/:*?""<>|."
    f = "撇揦：星？“左右横。，"

    For b = 1 To Len(d)
        c = Mid(f, b, 1)
        e = Mid(d, b, 1)
        a = Replace(a, c, e)
    Next
    unSetFileName = a
End Function


Function HTMLToAscChr(a)
    Dim b, c, d
    d = ""
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        d = d & "Chr(" & Asc(c) & ")&"
    Next
    If d <> "" Then d = Left(d, Len(d) - 1)
    HTMLToAscChr = d

End Function

Function unHTMLToAscChr(a)
    Dim b, c, d, e, f
    d = a : f = ""
    d = Replace(d, "Chr(", "")
    d = Replace(d, ")&", " ")
    d = Replace(d, ")", " ")
    e = Split(d, " ")
    For b = 0 To UBound(e) - 1
        c = e(b)
        f = f & Chr(c)
    Next
    unHTMLToAscChr = f
End Function


Function variableDisplacement(a, b)
    Dim c, d, e, f, g, h, i, j, k, l


    f = "yzoehijklmfgqrstuvpabnwxcd"

    h = Len(f)


    g = "4539671820"

    i = Len(g)
    c = ""
    For d = 1 To Len(a)
        e = Mid(a, d, 1)
        j = InStr(f, e)
        k = InStr(g, e)

        If j > 0 Then
            l = j + b
            If l > h Then
                l = l - h
            ElseIf l <= 0 Then

                l = l + h
            End If
            e = Mid(f, l, 1)

        ElseIf k > 0 Then
            l = k + b
            If l > i Then
                l = l - i
            ElseIf l <= 0 Then

                l = l + i
            End If
            e = Mid(g, l, 1)


        End If
        c = c & e
    Next
    variableDisplacement = c
End Function










Function xorEnc(a, b)
    Dim c, d, e, f, g
    c = a
    d = Len(c) : f = ""
    For g = 0 To d - 1
        e = AscW(Right(c, d - g)) Xor b
        f = f & ChrW(Int(e))
    Next

    f = Replace(f, ChrW(34), "ㄨ")
    xorEnc = f
End Function

Function xorDec(a, b)
    Dim c, d, e, f, g
    c = a : f = ""
    c = Replace(c, "ㄨ", ChrW(34))
    d = Len(c)
    For g = 0 To d - 1
        e = AscW(Right(c, d - g)) Xor b
        f = f & ChrW(Int(e))
    Next
    f = Replace(f, "＠", vbCrLf)
    xorDec = f
End Function



Function handleEvalAddDec(ByVal a, b)
    Dim c
    c = b & "Execute unDec_log(""" & encCode(a) & """)" & b
    c = c & "Function unDec_log(ByVal Content)" & b
    c = c & "    Dim I, C, SplStr " & b
    c = c & "    SplStr = Split(Content, ""%"") " & b
    c = c & "    For I = 1 To UBound(SplStr)" & b
    c = c & "        C = C & Chr(CInt(""&H"" & SplStr(I))) " & b
    c = c & "    Next " & b
    c = c & "    unDec_log = C " & b
    c = c & "End Function " & b
    handleEvalAddDec = c
End Function

Function evalAddDec(ByVal a)
    evalAddDec = handleEvalAddDec(a, vbCrLf)
End Function

Function VBEvalAddDec(ByVal a)
    VBEvalAddDec = escape(handleEvalAddDec(a, ":"))
End Function


Function XDec(a)
    Dim b, c, d, e, f
    b = a
    b = Replace(b, "ㄨ", Chr(34))
    c = Len(b) : d = "" : e = ""
    For f = 0 To c - 1
        d = Asc(Right(b, c - f)) Xor 20
        e = e & Chr(Int(d))
    Next
    e = Replace(e, "＠", vbCrLf)
    XDec = e
End Function



Public Function toHexColor(a)
    Dim b
    toHexColor = ""
    b = CStr(Hex(a))
    Select Case Len(b)
        Case 1 : toHexColor = "&H00000" & b
        Case 2 : toHexColor = "&H0000" & b
        Case 3 : toHexColor = "&H000" & b
        Case 4 : toHexColor = "&H00" & b
        Case 5 : toHexColor = "&H0" & b
        Case 6 : toHexColor = "&H" & b
    End Select
End Function

Public Function colorRGB(a)
    Dim b, c
    b = "" : c = ""
    Dim ArrayStr(2)
    ArrayStr(0) =(a Mod b)
    ArrayStr(1) =((a Mod c) \ b)
    ArrayStr(2) =(a \ c)
    colorRGB = ArrayStr
End Function


Function simpleEnc(a)
    a = Replace(a, "x", "輕")
    a = Replace(a, "f", "蚛")
    a = Replace(a, "s", "鋋")
    a = Replace(a, "h", "孿")
    a = Replace(a, "t", "謣")
    a = Replace(a, "o", "薺")
    a = Replace(a, "<", "讞")
    a = Replace(a, ">", "旻")
    a = Replace(a, "a", "艓")
    a = Replace(a, "c", "襋")
    a = Replace(a, "n", "贁")
    a = Replace(a, "m", "曁")
    a = Replace(a, vbCrLf, "樞")
    simpleEnc = a
End Function

Function simpleDec(a)
    a = Replace(a, "輕", "x")
    a = Replace(a, "蚛", "f")
    a = Replace(a, "鋋", "s")
    a = Replace(a, "孿", "h")
    a = Replace(a, "謣", "t")
    a = Replace(a, "薺", "o")
    a = Replace(a, "讞", "<")
    a = Replace(a, "旻", ">")
    a = Replace(a, "艓", "a")
    a = Replace(a, "襋", "c")
    a = Replace(a, "贁", "n")
    a = Replace(a, "曁", "m")
    a = Replace(a, "樞", vbCrLf)
    simpleDec = a
End Function

Function encAspEvalRun(ByVal a)
    Dim b, c, d

    a = Replace(a, "<" & "%", "")
    a = Replace(a, "%" & ">", "")
    a = Replace(a, """", """""")
    a = Replace(a, "x", "輕")
    a = Replace(a, "f", "蚛")
    a = Replace(a, "s", "鋋")
    a = Replace(a, "o", "薺")
    a = Replace(a, "e", "療")
    b = Split(a, vbCrLf)
    d = ""
    For c = 0 To UBound(b)
        If InStr(b(c), "'") = False And Len(b(c)) > 1 Then
            d = d & b(c) & "⊙"
        End If
    Next
    d = Left(d, Len(d) - 1)
    d = "Execute MyEval(""" & d & """)" & vbCrLf
    d = d & "Function MyEval(HtmlStr)" & vbCrLf
    d = d & vbTab & "MyEval=Replace(HtmlStr,""⊙"",vbCrlf)" & vbCrLf
    d = d & vbTab & "MyEval=Replace(MyEval,""輕"",""x"")" & vbCrLf
    d = d & vbTab & "MyEval=Replace(MyEval,""蚛"",""f"")" & vbCrLf
    d = d & vbTab & "MyEval=Replace(MyEval,""鋋"",""s"")" & vbCrLf
    d = d & vbTab & "MyEval=Replace(MyEval,""薺"",""o"")" & vbCrLf
    d = d & vbTab & "MyEval=Replace(MyEval,""療"",""e"")" & vbCrLf
    d = d & "End Function" & vbCrLf
    encAspEvalRun = "<" & "%" & vbCrLf & d & "%" & ">"
End Function


%>




