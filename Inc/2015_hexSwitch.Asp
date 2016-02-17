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



Function strToHex(ByVal a)
    Dim b, c
    For b = 1 To Len(a)
        c = c & Hex(Asc(Mid(a, b, 1)))
    Next
    strToHex = c
End Function

Function hexToStr(byval a)
    Dim b, c
    For b = 1 To Len(a) Step 2
        c = Mid(a, b, 2)
        if c="DA" then
			hexToStr=hexToStr & vbcrlf
		else
			If IsNumeric(Mid(a, b, 1)) Then
				hexToStr=hexToStr & chr("&H" & c)
			Else
				hexToStr=hexToStr & chr("&H" & c & Mid(a, b + 2, 2))
				b = b + 2
			End If
		end if
    Next
End Function

function bd(a)
	bd=hexToStr(a)
end function







Function c2to16(a)
    Dim b
    b = 1
    For b = 1 To Len(a) Step 4
        c2to16 = c2to16 & Hex(c2to10(Mid(a, b, 4)))
    Next
End Function


Function c2to10(a)
    Dim b
    c2to10 = 0
    If a = "0" Then Exit Function
    b = 0
    For b = 0 To Len(a) - 1
        If Mid(a, Len(a) - b, 1) = "1" Then c2to10 = c2to10 + 2 ^(b)
    Next
End Function


Function c16to2(a)
    Dim b, c
    b = 0
    For b = 1 To Len(Trim(a))
        c = c10to2(CInt(Int("&h" & Mid(a, b, 1))))
        Do While Len(c) < 4
            c = "0" & c
        Loop
        c16to2 = c16to2 & c
    Next
End Function


Function c10to2(a)
    Dim b, c, d, e
    b = Sgn(a)
    a = Abs(a)
    c = 1
    Do
        If a < 2 ^ c Then
            Exit Do
        Else
            c = c + 1
        End If
    Loop
    d = a
    e = 0
    For e = c To 1 Step - 1
        If d >= 2 ^(e - 1) Then
            d = d - 2 ^(e - 1)
            c10to2 = c10to2 & "1"
        Else
            c10to2 = c10to2 & "0"
        End If
    Next
    If b = -1 Then c10to2 = "-" & c10to2
End Function




Function str2bin(a)
    Dim b, c, d, e, f
    str2bin = ""
    For b = 1 To Len(a)
        d = Mid(a, b, 1)
        c = Asc(d)





        If c < 0 Then
            c = c + 65535
        End If

        If c > 255 Then
            e = Left(Hex(Asc(d)), 2)
            f = Right(Hex(Asc(d)), 2)
            str2bin = str2bin & ChrB("&H" & e) & ChrB("&H" & f)
        Else
            str2bin = str2bin & ChrB(AscB(d))
        End If
    Next
End Function


Function bytes2BSTR(a)
    Dim b
    Dim c, d, e
    b = ""
    For c = 1 To LenB(a)
        d = AscB(MidB(a, c, 1))
        If d < &H80 Then
            b = b & Chr(d)
        Else
            e = AscB(MidB(a, c + 1, 1))
            b = b & Chr(CLng(d) * &H100 + CInt(e))
            c = c + 1
        End If
    Next
    bytes2BSTR = b
End Function
%>


