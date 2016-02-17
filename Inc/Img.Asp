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














Class GPS
    Dim aso
    Private Sub class_Initialize()
        Set aso = CreateObject("ADODB.Stream")
            aso.Mode = 3
            aso.Type = 1
            aso.Open
    End Sub
    Private Sub class_Terminate()
        Set aso = Nothing
    End Sub
    Private Function bin2Str(a)
        Dim b, c, d
        For b = 1 To LenB(a)
            d = MidB(a, b, 1)
            If AscB(d) < 128 Then
                c = c & Chr(AscB(d))
            Else
                b = b + 1
                If b <= LenB(a) Then c = c & Chr(AscW(MidB(a, b, 1) & d))
            End If
        Next
        bin2Str = c
    End Function
    Private Function binVal(a)
        Dim b
        Dim c
        b = 0
        For c = LenB(a) To 1 Step - 1
            b = b * 256 + AscB(MidB(a, c, 1))
        Next
        binVal = b
    End Function
    Private Function binVal2(a)
        Dim b, c
        b = 0
        For c = 1 To LenB(a)
            b = b * 256 + AscB(MidB(a, c, 1))
        Next
        binVal2 = b
    End Function

    Function getImageSize(a)
        Dim b, c
        If checkFile(a) = False Then Exit Function

        aso.loadFromFile(a)

        Dim ret(3)

        b = aso.read(3)

        Select Case Hex(binVal(b))
            Case "4E5089"
                aso.read(15)
                ret(0) = "PNG"
                ret(1) = binVal2(aso.read(2))
                aso.read(2)
                ret(2) = binVal2(aso.read(2))
            Case "464947"
                aso.read(3)
                ret(0) = "GIF"
                ret(1) = binVal(aso.read(2))
                ret(2) = binVal(aso.read(2))
            Case "FFD8FF"
                Do
                Do : c = binVal(aso.read(1)) : Loop While c = 255 And Not aso.EOS
                If c > 191 And c < 196 Then Exit Do Else aso.read(binval2(aso.read(2)) - 2)
                Do : c = binVal(aso.read(1)) : Loop While c < 255 And Not aso.EOS
                Loop While True
                aso.read(3)
                ret(0) = "JPG"
                ret(2) = binval2(aso.read(2))
                ret(1) = binval2(aso.read(2))
            Case Else
                If Left(bin2Str(b), 2) = "BM" Then
                    aso.read(15)
                    ret(0) = "BMP"
                    ret(1) = binval(aso.read(4))
                    ret(2) = binval(aso.read(4))
                Else
                    ret(0) = ""
                End If
        End Select
        ret(3) = "width=""" & ret(1) & """ height=""" & ret(2) & """"
        getImageSize = ret
    End Function
End Class



Function handleShowImg(a, b, c, d)
    Dim e
    Dim f

    e = HandlePath(a)


    Dim g
    Set g = new GPS
        Set f = CreateObject("Scripting.FileSystemObject")

            Dim h
            h = f.GetExtensionName(e)
            Dim i
            Dim j, k
            Select Case h
                Case "gif", "bmp", "jpg", "png"


                    i = g.getImageSize(e)
                    j = i(1)
                    k = i(2)
            End Select
        Set f = Nothing
    Set g = Nothing
    Dim l, m
    Dim n

    Call echo("PWidth", j)
    Call echo("PHeight", k)

    Call echo("setWidth", b)
    Call echo("setHeight", c)


    If j = 0 Or j = "" Then
        l = 0
        m = 0
    Else
        If c < b And c > 0 Then
            n = FormatNumber(k / j, 2)

            m = c
            l = FormatNumber(c * n, 0)
        Else
            n = FormatNumber(j / k, 2)

            l = b
            m = FormatNumber(b / n, 0)
            Call echo(n, b & "   " & b / n)
        End If
    End If

    Call echo("宽百分比", FormatNumber(j / k, 2))
    Call echo("高百分比", FormatNumber(k / j, 2))

    Call echo("PXWidth", l)
    Call echo("PXHeight", m)

    If d = "宽" Then
        If b < l Then l = b
        handleShowImg = l
    ElseIf d = "高" Then
        If c < l Then l = c
        handleShowImg = l
    Else
        handleShowImg = "<img onerror=javascript:this.src='product_pic/wutu.jpg';this.width='92';this.height='130' src='" & a & "' border='0' width='" & l & "' height='" & m & "'>显示图片"
    End If





End Function

Function getImageWidthHeight(a, b, c)
    Dim d, e
    Call HandlePath(a)
    Set d = new GPS
        Set e = CreateObject("Scripting.FileSystemObject")
            Dim f
            f = e.GetExtensionName(a)
            Dim g
            Select Case f
                Case "gif", "bmp", "jpg", "png"
                    g = d.getImageSize(a)
                    b = g(1)
                    c = g(2)
            End Select
        Set e = Nothing
    Set d = Nothing
	getImageWidthHeight=split(b & "|" & c,"|")
End Function

Function getImageWidthValue(a)
    Dim b
    Call GetImageWidthHeight(a, b, "")
    getImageWidthValue = b
End Function

Function getFileContentType(a)
    Dim b, c
    Call HandlePath(a)
    Set b = new GPS
        Set c = CreateObject("Scripting.FileSystemObject")
            Dim d
            d = b.getImageSize(a)
            getFileContentType = d(0)
        Set c = Nothing
    Set b = Nothing
End Function

Function imageWaterfall(a, b, c)
    Dim d, e, f, g, h, i, j, k, l, m, n
    Dim SplC(99), SplN(99)
    b = b - 1

    For f = 0 To b
        SplC(f) = ""
        SplN(f) = 0
    Next

    d = GetFileFolderList(a, True, "全部", "", "全部文件夹", "NO", "")
    d = Replace(LCase(d), LCase(Server.MapPath("/")), "")

    e = Split(d, vbCrLf) : a = Replace(a, "\", "/")
    For Each g In e
        i = "<span><img src=" & host & g & " width='" & c & "'></span>"
        Call GetImageWidthHeight(g, k, l)
        If k > c Then
            j = FormatNumber(c / k, 2)
            k = c
            l = FormatNumber(l * j, 0)
        End If
        m = 0 : n = ""
        For f = 0 To b
            If n = "" Then
                n = SplN(f)
            ElseIf SplN(f) < n Then
                m = f
                n = SplN(f)
            End If
        Next
        SplN(m) = SplN(m) + l
        SplC(m) = SplC(m) & i
    Next
    For f = 0 To b
        h = h & "<div class=""ImgDivBox"">" & SplC(f) & "</div>" & vbCrLf
    Next
    h = h & "<div class=clear></div>"
    imageWaterfall = h
End Function


Function zoomImage(a,b, c, d, e, f, g, h, i)
    Dim j, k, l, m
	
	
    If a = "" Then a = 0
    If b = "" Then b = 0
	a=cint(a) : b=cint(b)
	
    If g = "" Then g = 0
    If h = "" Then h = 0
	c=cint(c) : d=cint(d) : e=cint(e) : f=cint(f) : g=cint(g) : h=cint(h)
	
	dim n, temp_nTop				
	n=g : temp_nTop=h
	
    If c / d >= e / f Then
        If c > e Then
            l = e
            m =(d * e) / c
        Else
            l = c
            m = d
        End If
    Else
        If d > f Then
            m = f
            l =(c * f) / d
        Else
            l = c
            m = d
        End If
    End If

    l = Int(l)
    m = Int(m)
    g = g + e - l
    h = h + f - m
    j = " width=""" & l & """ height=""" & m & """"

    if b>0 then
		
			if instr(i,"|imgulmiddel|")>0 then
				h=(b-m)/2
			end if
	end if
	
	
	
	
	
	
	
    If g > 0 and g<>n Then
        k = k & "padding-left:" & g & "px;"
    End If
    If h > 0 and h<>n Then
        k = k & "padding-top:" & h & "px;"
    End If


    If k <> "" Then
        k = " style=""" & k & """"
    End If
    zoomImage = j & k
End Function

%>


