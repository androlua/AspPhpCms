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



Function checkCode(ByVal a)
	checkCode=getFileCharset(a)
End Function

Function getFileCharset(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("ADODB.Stream")
        b.Type = 1
        b.Mode = 3
        b.Open
        b.Position = 0
        Call b.loadFromFile(a)
        c = b.read(2)
        If TypeName(c) = "Null" Then getFileCharset = "gb2312" : Exit Function
        If AscB(MidB(c, 1, 1)) = &HEF And AscB(MidB(c, 2, 1)) = &HBB Then
            getFileCharset = "utf-8"
        ElseIf AscB(MidB(c, 1, 1)) = &HFF And AscB(MidB(c, 2, 1)) = &HFE Then
            getFileCharset = "unicode"
        Else
            getFileCharset = "gb2312"
        End If
        b.Close
    Set b = Nothing
    If Err Then doError Err.Description, "getFileCharset，获得文件编码 函数出错，FileName=" & a

End Function

Function seniorCheckCode(ByVal a)




    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("ADODB.Stream")
        b.Type = 1
        b.Mode = 3
        b.Open
        b.Position = 0
        Call b.loadFromFile(a)
        c = b.read(2)
        If TypeName(c) = "Null" Then seniorCheckCode = CheckFileCode(a) : Exit Function


        If AscB(MidB(c, 1, 1)) = &HEF And AscB(MidB(c, 2, 1)) = &HBB Then
            seniorCheckCode = "UTF-8"
        ElseIf AscB(MidB(c, 1, 1)) = &HFF And AscB(MidB(c, 2, 1)) = &HFE Then
            seniorCheckCode = "UNICODE"
        Else
            seniorCheckCode = CheckFileCode(a)
        End If

        b.Close
    Set b = Nothing
    If Err Then doError Err.Description, "CheckCode，获得文件编码 函数出错，FileName=" & a
End Function

Function readFile(ByVal a, ByVal b)
    On Error Resume Next
    If b = "1" Or UCase(b) = "GB2312" Then
        b = "GB2312"
    ElseIf b = "0" Or UCase(b) = "UTF-8" Then
        b = "UTF-8"
    ElseIf b = "2" Or UCase(b) = "UNICODE" Then
        b = "UNICODE"
    Else
        b = checkCode(a)
        If b = "" Then Exit Function
    End If
    Dim c, d, e, f
    Call HandlePath(a)
	if checkfile(a)=false then
		readFile=""
		exit function
	end if
    Set d = CreateObject("ADODB.Stream")
        d.Type = 2
        d.Mode = 3
        d.Charset = b
        d.Open
        Set f = CreateObject("Scripting.FileSystemObject")
            Set e = f.GetFile(a)
                If e.Size > 0 Then
                    Call d.loadFromFile(a)
                End If
                c = d.ReadText
                d.Close
            Set d = Nothing
            readFile = c
            If Err Then doError Err.Description, "ReadFile，数据流读出内容 函数出错，FileName=" & a
        Set f = Nothing
    Set d = Nothing
End Function

Function getStext(a)
    getStext = readFile(a, "")
End Function

function getFTextUTF(a)
	 getFTextUTF=readFile(a,"utf-8")
end function

Function writeToFile(ByVal a, ByVal b, ByVal c)
    On Error Resume Next
    If c = "1" Or UCase(c) = "GB2312" Then
        c = "GB2312"
    ElseIf c = "0" Or UCase(c) = "UTF-8" Then
        c = "UTF-8"
    ElseIf c = "2" Or UCase(c) = "UNICODE" Then
        c = "UNICODE"
    Else
        c = "GB2312"
    End If

    Dim d
    Call HandlePath(a)
    Set d = CreateObject("ADODB.Stream")
        d.Type = 2
        d.Mode = 3
        d.Charset = c
        d.Open
        Call d.WriteText(b)
        Call d.SaveToFile(a, 2)
        d.Flush
        d.Close
        writeToFile = a & "写入成功"
    Set d = Nothing
    If Err Then doError Err.Description, "WriteToFile，数据流写入内容 函数出错，FileName=" & a & "，Content字符" & Len(b)
End Function

function createFileUTF(byval a, byval b)
	call writeToFile(a,b,"utf-8")
end function


Function getUGText(ByVal a)
    Dim b, c, d
    Dim e
    b = checkCode(a)
    e = False

    If b = "utf-8" Then
        c = "gb2312"
    ElseIf b = "gb2312" Then
        c = "utf-8"
    End If
    d = c
    If c <> "" Then
        If CheckStr(LCase(getUGText), "<meta [^>]*charset *= *" & c) = True Then
            getUGText = readFile(a, d)
            e = True
        End If
    End If

    If e = False Then
        getUGText = readFile(a, b)
    End If
End Function

Function checkContentCharset(ByVal a, ByVal b)
    a = LCase(a)
    b = LCase(b)
    checkContentCharset = True
    If InStr(a, "<meta ") > 0 Then
        Dim c, d, e, f, g
        For c = 1 To Len(a)
            d = Mid(a, c, 1)
            If d = "<" Then
                e = LCase(Mid(a, c))
                f = LCase(Mid(e, 1, InStr(e, " ")))
                If f = "<meta " Then
                    g = Mid(e, 1, InStr(e, ">"))
                    If InStr(g, "charset") > 0 Then
                        If InStr(g, b) = 0 Then checkContentCharset = False
                    End If
                End If
            End If
        Next
    End If
End Function

Function checkFileCode(a)
    Dim b, c, d, e, f, g, h
    f = BinaryReadFile(a)





    If Len(f) > 2500 Then
        f = Right(f, 2500)
    End If
    h = Len(f)
    e = a & "_Temp"
    b = Split("GB2312|UTF-8|UNICODE", "|")
    For Each g In b
        d = readFile(a, g)
        Call WriteToFile(e, d, g)
        c = BinaryReadFile(e)
        c = Right(c, h)
        If f = c Then
            checkFileCode = g
            Call deleteFile(e)
            Exit For
        End If
    Next
    Call deleteFile(e)
End Function

Function getFileBinaryContent(a)
    Dim b
    Call HandlePath(a)
    Set b = CreateObject("ADODB.Stream")
        b.Mode = 3
        b.Type = 1
        b.Open
        Call b.loadFromFile(a)
        getFileBinaryContent = b.read
        b.Close
    Set b = Nothing

End Function

Function binaryReadFile(a)
    Dim b, c, d, e
    Call HandlePath(a)
    Set e = CreateObject("ADODB.Stream")
        e.Mode = 3
        e.Type = 1
        e.Open
        Call e.loadFromFile(a)
        d = "" : b = 0 : c = 1
        While b < e.Size
            d = d & AscB(e.read(c))
            b = b + c
            DoEvents
        Wend
    Set e = Nothing
    binaryReadFile = d
End Function

Function readBinary(a, b)
    Dim c, d, e, f
    If b = "" Then b = 0
    Call HandlePath(a)
    Set f = CreateObject("ADODB.Stream")
        f.Mode = 3
        f.Type = 1
        f.Open
        Call f.loadFromFile(a)
        e = "" : c = 0 : d = 1
        While c < f.Size
            e = e &(AscB(f.read(d)) + b) & "|"
            c = c + d
        Wend
        If e <> "" Then e = Left(e, Len(e) - 1)
    Set f = Nothing
    readBinary = e
End Function

Function decSaveBinary(a, b, c)
    Dim d, buf(), f
    If c = "" Then c = 0
    d = Split(b, "|")
    ReDim buf(UBound(d))
    For f = 0 To UBound(d)
        buf(f) = CByte(CInt(d(f)) - c)
    Next
    Call WriteBinary(a, buf)
End Function

Sub writeBinary(a, b)
    Dim c, d, e, f
    Call HandlePath(a)

	if typeName(b)<>"Byte()" then
		e = UBound(b) : ReDim d(e \ 2)
		For c = 0 To e - 1 Step 2
			d(c \ 2) = ChrW(b(c + 1) * 256 + b(c))
		Next
		If c = e Then d(c \ 2) = ChrW(b(c))
		d = Join(d, "")
	else	
		d=b
	end if
	
    Set f = CreateObject("ADODB.Stream")
        f.Type = 1
        f.Open
        With CreateObject("ADODB.Stream")
            .Type = 2
            .Open
            Call.WriteText(d)
            .Position = 2
            Call.CopyTo(f)
            .Close
        End With
        Call f.SaveToFile(a, 2)
        f.Close
    Set f = Nothing
End Sub





Public Function getFileCharset2(ByVal a)
    Dim b

    If Err Then
        Err.Clear
    End If
    Call HandlePath(a)
    Dim c, d
    Set c = CreateObject("ADODB.Stream")
        With c
            .Type = 1
            .Mode = 3
            .Open
            .loadFromFile a
            d =.read(3)
            .Close
        End With
    Set c = Nothing
    If Err.Number <> 0 Then
        Err.Clear : getFileCharset2 = "" : Exit Function
    End If

    b = BinToHex(d)
    If b = "EFBBBF" Then
        getFileCharset2 = "UTF-8"
    Else
        b = Left(b, 4)
        If b = "FEFF" Then
            getFileCharset2 = "UNICODE BIG"
        ElseIf b = "FFFE" Then
            getFileCharset2 = "UNICODE"
        ElseIf b = "3C25" Or b = "3C21" Then
            getFileCharset2 = "GB2312"
        Else
            getFileCharset2 = "GB2312"
        End If
    End If
    If Err.Number <> 0 Then
        Err.Clear : getFileCharset2 = "" : Exit Function
    End If
End Function
Public Function binToHex(ByVal a)
    Dim b, c
    b = 0
    For c = 1 To LenB(a)
        b = b * 256 + AscB(MidB(a, c, 1))
    Next
    binToHex = Hex(b)
End Function




function Base64Encode(a)
    dim b,c
    set b=createobject("adodb.stream")
    b.Type=2
    b.charset="unicode"
    b.mode=3
    call b.open()
    b.writeText a
    b.Position=0
    b.Type=1


    set c=createobject("msxml.domdocument")
    call c.loadXml("<root/>")
    c.DocumentElement.DataType="bin.base64"
    c.DocumentElement.NodeTypedValue=b.read()
    Base64Encode=c.DocumentElement.text
end function

function Base64Decode(a)
    dim b
    set b=createobject("msxml.domdocument")
    call b.loadXml("<root/>")
    b.DocumentElement.DataType="bin.base64"
    b.DocumentElement.text=a
    Base64Decode=b.DocumentElement.NodeTypedValue
end function

%>


