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










Const nMaxSaturation = 100		
Const nBlankNoisyDotOdds = 0.2  	
Const nColorNoisyDotOdds = 0.1  	
Const nCharCount = 4			
Const nPixelWidth = 22			
Const nPixelHeight = 22			
Const nColorHue = -1			
Const nAngleRandom = 10         	
Const nLengthRandom = 30        	
Const cCharSet = "0123456789"



Dim Buf(), DigtalStr
Dim Lines(), LineCount
Dim CursorX, CursorY, DirX, DirY

Randomize
Call CreatValidCode("YZM")

Sub CDGen_Reset()
	
	LineCount = 0
	CursorX = 0
	CursorY = 0
	
	DirX = 0
	DirY = 1
End Sub

Sub CDGen_Clear()
	
	Dim b, c
	ReDim Buf(nPixelHeight - 1, nCharCount * nPixelWidth - 1)

	For c = 0 To nPixelHeight - 1
		For b = 0 To nCharCount * nPixelWidth - 1
			Buf(c, b) = 0
		Next
	Next
End Sub

Sub CDGen_PSet(a, b)
	
	Buf(b, a) = 1
End Sub

Sub CDGen_Line(a, b, c, d)
	
	Dim e, f, g, h
	
	e = c - a
	f = d - b
	If Abs(e) > Abs(f) Then g = Abs(e) Else g = Abs(f)
	For h = 0 To g
		CDGen_PSet a + e * h / g, b + f * h / g
	Next
End Sub

Sub CDGen_FowardDraw(a)
	
	a = Sgn(a) * Abs(a) * (1 - nLengthRandom / 100 + Rnd * nLenghtRandom * 2 / 100)
	ReDim Preserve Lines(3, LineCount)
	Lines(0, LineCount) = CursorX
	Lines(1, LineCount) = CursorY
	CursorX = CursorX + DirX * a
	CursorY = CursorY + DirY * a
	Lines(2, LineCount) = CursorX
	Lines(3, LineCount) = CursorY
	LineCount = LineCount + 1
End Sub

Sub CDGen_SetDirection(a)
	
	Dim b, c
	
	a = Sgn(a) * (Abs(a) - nAngleRandom + Rnd * nAngleRandom * 2) / 180 * 3.1415926
	b = DirX
	c = DirY
	DirX = b * Cos(a) - c * Sin(a)
	DirY = b * Sin(a) + c * Cos(a)
End Sub

Sub CDGen_MoveToMiddle(a, b)
	
	Dim c, d
	
	c = Lines(2, a) - Lines(0, a)
	d = Lines(3, a) - Lines(1, a)
	CursorX = Lines(0, a) + Sgn(c) * Abs(c) * b / 100
	CursorY = Lines(1, a) + Sgn(d) * Abs(d) * b / 100
End Sub

Sub CDGen_MoveCursor(a)
	
	CursorX = Lines(0, a)
	CursorY = Lines(1, a)
End Sub

Sub CDGen_Close(a)
	
	ReDim Preserve Lines(3, LineCount)
	Lines(0, LineCount) = CursorX
	Lines(1, LineCount) = CursorY
	CursorX = Lines(0, a)
	CursorY = Lines(1, a)
	Lines(2, LineCount) = CursorX
	Lines(3, LineCount) = CursorY
	LineCount = LineCount + 1
End Sub

Sub CDGen_CloseToMiddle(a, b)
	
	Dim c, d
	
	ReDim Preserve Lines(3, LineCount)
	Lines(0, LineCount) = CursorX
	Lines(1, LineCount) = CursorY
	c = Lines(2, a) - Lines(0, a)
	d = Lines(3, a) - Lines(1, a)
	CursorX = Lines(0, a) + Sgn(c) * Abs(c) * b / 100
	CursorY = Lines(1, a) + Sgn(d) * Abs(d) * b / 100
	Lines(2, LineCount) = CursorX
	Lines(3, LineCount) = CursorY
	LineCount = LineCount + 1
End Sub

Sub CDGen_Flush(a, b)
	
	Dim c, d, e, f
	Dim g, h, i, j, k, l
	Dim m

	c = d = e = f = 0
	For m = 0 To LineCount - 1
		If c < Lines(0, m) Then c = Lines(0, m)
		If c < Lines(2, m) Then c = Lines(2, m)
		If d > Lines(0, m) Then d = Lines(0, m)
		If d > Lines(2, m) Then d = Lines(2, m)
		If e < Lines(1, m) Then e = Lines(1, m)
		If e < Lines(3, m) Then e = Lines(3, m)
		If f > Lines(1, m) Then f = Lines(1, m)
		If f > Lines(3, m) Then f = Lines(3, m)
	Next
	g = c - d
	h = e - f
	If g = 0 Then g = 1
	If h = 0 Then h = 1
	c = d
	e = f
	If g > h Then
		i = (nPixelWidth - 2) / g
		j = (nPixelHeight - 2) / g
		k = 0
		l = (g - h) / 2
	Else
		i = (nPixelWidth - 2) / h
		j = (nPixelHeight - 2) / h
		k = (h - g) / 2
		l = 0
	End If
	For m = 0 To LineCount - 1
		Lines(0, m) = Round((Lines(0, m) - c + k) * i, 0)
		If Lines(0, m) < 0 Then Lines(0, m) = 0
		If Lines(0, m) >= nPixelWidth - 2 Then Lines(0, m) = nPixelWidth - 3
		Lines(1, m) = Round((Lines(1, m) - e + l) * j, 0)
		If Lines(1, m) < 0 Then Lines(1, m) = 0
		If Lines(1, m) >= nPixelHeight - 2 Then Lines(1, m) = nPixelHeight - 3
		Lines(2, m) = Round((Lines(2, m) - d + k) * i, 0)
		If Lines(2, m) < 0 Then Lines(2, m) = 0
		If Lines(2, m) >= nPixelWidth - 2 Then Lines(2, m) = nPixelWidth - 3
		Lines(3, m) = Round((Lines(3, m) - f + l) * j, 0)
		If Lines(3, m) < 0 Then Lines(3, m) = 0
		If Lines(3, m) >= nPixelHeight - 2 Then Lines(3, m) = nPixelHeight - 3
		CDGen_Line Lines(0, m) + a + 1, Lines(1, m) + b + 1, Lines(2, m) + a + 1, Lines(3, m) + b + 1
	Next
End Sub

Sub CDGen_Char(a, b, c)
	
	CDGen_Reset
	Select Case a
	Case "0"
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 1.5
		CDGen_SetDirection -60
		CDGen_FowardDraw 0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw 0.7
		CDGen_Close 0
	Case "1"
		CDGen_SetDirection -90
		CDGen_FowardDraw 0.5
		CDGen_MoveToMiddle 0, 50
		CDGen_SetDirection 90
		CDGen_FowardDraw -1.4
		CDGen_SetDirection 30
		CDGen_FowardDraw 0.4
	Case "2"
		CDGen_SetDirection 45
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -120
		CDGen_FowardDraw 0.4
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.6
		CDGen_SetDirection 60
		CDGen_FowardDraw 1.6
		CDGen_SetDirection -135
		CDGen_FowardDraw 1.0
	Case "3"
		CDGen_SetDirection -90
		CDGen_FowardDraw 0.8
		CDGen_SetDirection 135
		CDGen_FowardDraw 0.8
		CDGen_SetDirection -120
		CDGen_FowardDraw 0.6
		CDGen_SetDirection 80
		CDGen_FowardDraw 0.5
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.5
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.5
	Case "4"
		CDGen_SetDirection 20
		CDGen_FowardDraw 0.8
		CDGen_SetDirection -110
		CDGen_FowardDraw 1.2
		CDGen_MoveToMiddle 1, 60
		CDGen_SetDirection 90
		CDGen_FowardDraw 0.7
		CDGen_MoveCursor 2
		CDGen_FowardDraw -1.5
	Case "5"
		CDGen_SetDirection 90
		CDGen_FowardDraw 1.0
		CDGen_SetDirection -90
		CDGen_FowardDraw 0.8
		CDGen_SetDirection -90
		CDGen_FowardDraw 0.8
		CDGen_SetDirection 30
		CDGen_FowardDraw 0.4
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.4
		CDGen_SetDirection 30
		CDGen_FowardDraw 0.5
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.8
	Case "6"
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 1.5
		CDGen_SetDirection 120
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 0.5
		CDGen_CloseToMiddle 2, 50
	Case "7"
		CDGen_SetDirection 180
		CDGen_FowardDraw 0.3
		CDGen_SetDirection 90
		CDGen_FowardDraw 0.9
		CDGen_SetDirection 120
		CDGen_FowardDraw 1.3
	Case "8"
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.8
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.8
		CDGen_SetDirection 120
		CDGen_FowardDraw 0.8
		CDGen_SetDirection 110
		CDGen_FowardDraw -1.5
		CDGen_SetDirection -110
		CDGen_FowardDraw 0.9
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.8
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.8
		CDGen_SetDirection 60
		CDGen_FowardDraw 0.9
		CDGen_SetDirection 70
		CDGen_FowardDraw 1.5	
		CDGen_Close 0
	Case "9"
		CDGen_SetDirection 120
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw -1.5
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw 0.5
		CDGen_CloseToMiddle 2, 50
	
	Case "A"
		CDGen_SetDirection -(Rnd * 20 + 150)
		CDGen_FowardDraw Rnd * 0.2 + 1.1
		CDGen_SetDirection Rnd * 20 + 140
		CDGen_FowardDraw Rnd * 0.2 + 1.1
		CDGen_MoveToMiddle 0, 30
		CDGen_CloseToMiddle 1, 70
	Case "B"
		CDGen_SetDirection -(Rnd * 20 + 50)
		CDGen_FowardDraw Rnd * 0.4 + 0.8
		CDGen_SetDirection Rnd * 20 + 110
		CDGen_FowardDraw Rnd * 0.2 + 0.6
		CDGen_SetDirection -(Rnd * 20 + 110)
		CDGen_FowardDraw Rnd * 0.2 + 0.6
		CDGen_SetDirection Rnd * 20 + 110
		CDGen_FowardDraw Rnd * 0.4 + 0.8
		CDGen_Close 0
	Case "C"
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection -60
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 1.5
		CDGen_SetDirection 120
		CDGen_FowardDraw -0.7
		CDGen_SetDirection 120
		CDGen_FowardDraw 0.7
	End Select
	CDGen_Flush b, c
End Sub

Sub CDGen_Blur()
	
	Dim b, c
	
	For c = 1 To nPixelHeight - 2
		For b = 1 To nCharCount * nPixelWidth - 2
			If Buf(c, b) = 0 Then
				If ((Buf(c, b - 1) Or Buf(c + 1, b)) And 1) <> 0 Then
					
					Buf(c, b) = 2
				End If
			End If
		Next
	Next
End Sub

Sub CDGen_NoisyDot()
	
	Dim b, c, d, e
	
	For c = 0 To nPixelHeight - 1
		For b = 0 To nCharCount * nPixelWidth - 1
			If Buf(c, b) <> 0 Then
				d = Int(Rnd * Rnd * nMaxSaturation)
				Select Case nColorNoisyDotOdds
				Case 0
					e = nMaxSaturation
				Case 1
					e = 0
				Case Else
					e = d
				End Select
				If Rnd < nColorNoisyDotOdds Then Buf(c, b) = e Else Buf(c, b) = nMaxSaturation
			Else
				d = Int(Rnd * nMaxSaturation)
				Select Case nBlankNoisyDotOdds
				Case 0
					e = 0
				Case 1
					e = nMaxSaturation
				Case Else
					e = d
				End Select
				If Rnd < nBlankNoisyDotOdds Then Buf(c, b) = e Else Buf(c, b) = 0
			End If
		Next
	Next
End Sub

Sub CDGen()
	
	Dim b, c
	
	DigtalStr = ""
	CDGen_Clear
	For b = 0 To nCharCount - 1
		c = Mid(cCharSet, Int(Rnd * Len(cCharSet)) + 1, 1)
		DigtalStr = DigtalStr + c
		CDGen_Char c, b * nPixelWidth, 0
	Next
	CDGen_Blur
	CDGen_NoisyDot
End Sub

Function HSBToRGB(a, b, c)
	
	Dim aRGB(3), e, f, g
	Dim h, i, j
	Dim k, l, m, n, o

	a = (a Mod 360)
	If b > 100 Then
		b = 100
	ElseIf b < 0 Then
		b = 0
	End If
	If c > 100 Then
		c = 100
	ElseIf c < 0 Then
		c = 0
	End If
	If b > 0 Then
		h = a / 60
		i = b / 100
		j = c / 100
		k = Int(h)
		l = h - k
		m = j * (1 - i)
		n = j * (1 - i * l)
		o = j * (1 - i * (1 - l))
		Select Case k
		Case 0
			aRGB(0) = j * 255
			aRGB(1) = o * 255
			aRGB(2) = m * 255
		Case 1
			aRGB(0) = n * 255
			aRGB(1) = j * 255
			aRGB(2) = m * 255
		Case 2
			aRGB(0) = m * 255
			aRGB(1) = j * 255		
			aRGB(2) = o * 255
		Case 3
			aRGB(0) = m * 255
			aRGB(1) = n * 255
			aRGB(2) = j * 255
		Case 4
			aRGB(0) = o * 255
			aRGB(1) = m * 255
			aRGB(2) = j * 255
		Case 5
			aRGB(0) = j * 255
			aRGB(1) = m * 255
			aRGB(2) = n * 255
		End Select			
	Else
		aRGB(0) = (c * 255) / 100
		aRGB(1) = aRGB(0)
		aRGB(2) = aRGB(0)
	End If
	HSBToRGB = ChrB(Round(aRGB(2), 0)) & ChrB(Round(aRGB(1), 0)) & ChrB(Round(aRGB(0), 0))
End Function

Sub CreatValidCode(a)
	Dim b, c, d
	
	
	Response.Expires = -9999
	Response.AddHeader "pragma", "no-cache"
	Response.AddHeader "cache-ctrol", "no-cache"
	Response.ContentType = "image/bmp"
	
	Call CDGen
	Session(a) = DigtalStr	

	Dim e, f, g, h
	e = nCharCount * nPixelWidth
	f = nPixelHeight
	h = e * f * 3
	g = h + 54

	
	Response.BinaryWrite ChrB(66) & ChrB(77) & _
		ChrB(g Mod 256) & ChrB((g \ 256) Mod 256) & ChrB((g \ 256 \ 256) Mod 256) & ChrB(g \ 256 \ 256 \ 256) & _
		ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & _
		ChrB(54) & ChrB(0) & ChrB(0) & ChrB(0)

	
	Response.BinaryWrite ChrB(40) & ChrB(0) & ChrB(0) & ChrB(0) & _
		ChrB(e Mod 256) & ChrB((e \ 256) Mod 256) & ChrB((e \ 256 \ 256) Mod 256) & ChrB(e \ 256 \ 256 \ 256) & _
		ChrB(f Mod 256) & ChrB((f \ 256) Mod 256) & ChrB((f \ 256 \ 256) Mod 256) & ChrB(f \ 256 \ 256 \ 256) & _
		ChrB(1) & ChrB(0) & _
		ChrB(24) & ChrB(0) & _
		ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & _
		ChrB(h Mod 256) & ChrB((h \ 256) Mod 256) & ChrB((h \ 256 \ 256) Mod 256) & ChrB(h \ 256 \ 256 \ 256) & _
		ChrB(18) & ChrB(11) & ChrB(0) & ChrB(0) & _
		ChrB(18) & ChrB(11) & ChrB(0) & ChrB(0) & _
		ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & _
		ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0)

	
	If nColorHue = -1 Then
		d = Int(Rnd * 360)
	ElseIf nColorHue = -2 Then
		d = 0
	Else
		d = nColorHue
	End If
	For c = 0 To nPixelHeight - 1
		For b = 0 To Len(DigtalStr) * nPixelWidth - 1
			If nColorHue = -2 Then
				Response.BinaryWrite HSBToRGB(d, 0, 100 - Buf(nPixelHeight - 1 - c, b))
			Else
				Response.BinaryWrite HSBToRGB(d, Buf(nPixelHeight - 1 - c, b), 100)
			End If
		Next
	Next
End Sub
%>


