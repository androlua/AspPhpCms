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

Function Send_Email(a, b, c, d)
    Dim e, f, g
    Response.AddHeader "Content-Type", "text/html; charset=gb2312"
    Set e = CreateObject("JMail.Message")

        e.ContentTransferEncoding = "base64"
        e.Encoding = "base64"
        e.ContentType = "text/html"
        e.silent = True
        e.Logging = True
        e.CharSet = "gb2312"
        e.MailServerUserName = "m18251922007"
        e.MailServerPassword = "mydd3a"
        e.From = "m18251922007@163.com"
        e.FromName = c
        e.AddRecipient a
        e.Subject = b

        g = g & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>"
        g = g & d
        g = g & "</body></html>"
        e.Body = g
        Send_Email = e.Send("smtp.163.com")
        e.Close
    Set e = Nothing
End Function

Function ServerSend_Email(a, b, c, d, e, f)
    Dim g, h, i
    Response.AddHeader "Content-Type", "text/html; charset=gb2312"
    Set g = CreateObject("JMail.Message")

        g.ContentTransferEncoding = "base64"
        g.Encoding = "base64"
        g.ContentType = "text/html"
        g.silent = True
        g.Logging = True
        g.CharSet = "gb2312"
        g.MailServerUserName = a
        g.MailServerPassword = b
        g.From = "m18251922007@163.com"
        g.FromName = e
        g.AddRecipient c
        g.Subject = d

        i = i & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>"
        i = i & f
        i = i & "</body></html>"
        g.Body = i
        ServerSend_Email = g.Send("smtp.163.com")
        g.Close
    Set g = Nothing
End Function

Function FindAspCode(ByVal a)
	a = GetAspCode(a)
    a = GetASPFunctionList(a)
    FindAspCode =a
End Function

Function FindAspFunList(ByVal a)
	Dim b,c,d,e,f,g
	a = FindAspCode(a)				
	b=Split(a,vbCrlf)
	For Each e In b
		f = e : e = LCase(e)
		If e <>"" Then
			c=0
			If InStr(e,"function ")>0 Then
				c=InStr(e,"function ")+8
			ElseIf InStr(e,"sub ")>0 Then
				c=InStr(e,"sub ")+3
			End If
			If c > 0 Then
				f = Mid(f,c)
				If InStr(f,"(")>0 Then
					f=Mid(f,1,InStr(f,"(")-1)
				Else
					f=Mid(f,1,InStr(f & " "," ")-1)
				End If				
                g = g & Trim(f) & vbCrLf
			End If
		End If	
        DoEvents
	Next
	FindAspFunList=g
End Function

Function FindAspFunctionCode(ByVal a, ByVal b)
    Dim c, d, e, f
    If CheckStr(b, "sub ") Then
        c = "end sub"
    Else
        c = "end function"
    End If
    a = Right(a, Len(a) - InStr(LCase(a), LCase(b)) + 1)
    d = Split(a, vbCrlf)
    For Each e In d
        f = f & e & vbCrlf
        If CheckStr(e, c) = True Then Exit For
    Next
    FindAspFunctionCode = f
End Function

Function handleReplaceList(ByVal a, b, c)
    Dim d, e, f, g
    d = Split(b, "|")
    e = Split(c & "||||||||||||||||||||||||||||||||", "|")
    For f = 0 To UBound(d)
        g = d(f)
        If g <> "" Then
            a = Replace(a, g, e(f))
        End If
    Next
    handleReplaceList = a
End Function

Function GetFunNameDim(ByVal a, b, c)
    Dim d, e, f, g
    a = Trim(a)
    If InStr(LCase(a), "sub ") > 0 Then
        d = "sub"
    ElseIf InStr(LCase(a), "function ") > 0 Then
        d = "function"
    Else
        Exit Function
    End If
    a = Replace(a, ":", ")") & ")"
    e = InStr(a, d & " ") + Len(d & " ")
    f = InStr(e, a, ")")
    a = Mid(a, e, f - e)
    g = d & " " & a
    If InStr(a, "(") > 0 Then
        b = Left(a, InStr(a, "(") - 1)
        If InStr(b, " ") Then
            b = Mid(b, InStr(b, " "))
        End If
        g = g & ")"
        e = InStr(g, "(") + 1
        f = InStr(e, g, ")")
        c = Mid(g, e, f - e)
        c = RegExp_Replace(c, "ByVal ", "")
        c = RegExp_Replace(c, "ByRef ", "")
        c = Replace(c, " ", "")
    Else
        b = a
    End If

    GetFunNameDim = g
End Function

Function LeftSpace(ByVal a, ByVal b)
    Dim c, d
    d = 0
    For c = Len(a) To 1 Step - 1
        If Mid(a, c, 1) <> " " Then Exit For
        d = d + 1
    Next
    If d > b And Replace(a, " ", "") <> "" Then
        a = Left(a, Len(a) - d + b)
    ElseIf d < b And 1 = 1 Then
        For c = d To b - 1
            a = a & " "
        Next
    End If
    LeftSpace = a
End Function

Function RightSpace(ByVal a, ByVal b)
    Dim c, d
    d = 0
    For c = 1 To Len(a)
        If Mid(a, c, 1) <> " " Then Exit For
        d = d + 1
    Next
    If d > b Then
        a = Right(a, Len(a) - d + b)
    ElseIf d < b Then
        For c = d To b - 1
            a = " " & a
        Next
    End If
    RightSpace = a
End Function

Function InFunAddDim(ByVal a)
    Dim b, c, d, e, f, g, h, i, j, k
    c = Split("A_p,B_p,C_4,D_2,E_4,F_9,G_1,H_2,I_2,J_3,K_1,L_o,M_m,N_u,O_o,P_n,Q_o,R_l,S_i,T_2,U_2,V_2,W_2,X_2,Y_2,Z_2", ",")
    b = Split(a, vbCrlf)
    g = UBound(b) - 1
    e = StrCut(a, "(", ")", 2)
    d = Split(e, ",")
    h = UBound(d) + 1

    If h = 0 Then
        InFunAddDim = a
        Exit Function
    End If
    i = CInt(g / h)
    k = 0
    For f = 0 To UBound(b)
        e = b(f)
        If Trim(e) <> "" Then
            j = j & b(f) & vbCrlf
        End If
        If i <> 0 Then
            If f Mod i = 0 And UBound(d) >= k And f <> UBound(b) Then
                j = j & "dIm " & c(k) & vbCrlf
                k = k + 1
            End If
        End If
    Next
    If j <> "" Then j = Left(j, Len(j) - 2)
    InFunAddDim = j
End Function


Function GetQQ(ByVal a, b)
    Dim c, d, e, f, g, h, i, j
    a = Replace(Replace(LCase(a), "&nbsp;", ""), " ", "")
    b = 0
    If InStr(a, "qq") > 0 Then
        c = Split(a, "qq")
        For d = 1 To UBound(c)
            f = c(d)
            h = "" : i = 14 : j = False
            For e = 1 To Len(f)
                If InStr("0123456789", Mid(f, e, 1)) = False Then
                    If j = True Then Exit For
                    If i = 0 Then Exit For
                    i = i - 1
                    If Mid(f, e, 1) = "群" Then Exit For
                Else
                    j = True
                    h = h & Mid(f, e, 1)
                End If
                If e > 30 Then Exit For
            Next
            If Len(h) >= 6 And Len(h) <= 10 And InStr(vbCrlf & g, vbCrlf & h & vbCrlf) = False Then
                If InStr(vbCrlf & g, vbCrlf & h & vbCrlf) = False Then
                    g = g & h & vbCrlf
                    b = b + 1
                End If
            End If
        Next
    End If
    GetQQ = g
End Function

Function GetTel(ByVal a, b)
    Dim c, d, e, f, g, h, i, j
    a = Replace(Replace(LCase(a), "&nbsp;", ""), "手机", "tel")
    b = 0
    If InStr(a, "tel") > 0 Then
        c = Split(a, "tel")
        For d = 1 To UBound(c)
            f = c(d)
            h = "" : i = 14 : j = False
            For e = 1 To Len(f)
                If InStr("0123456789", Mid(f, e, 1)) = False Then
                    If j = True Then Exit For
                    If i = 0 Then Exit For
                    i = i - 1
                Else
                    j = True
                    h = h & Mid(f, e, 1)
                End If
                If e > 30 Then Exit For
            Next
            If Len(h) = 11 Then
                If InStr(vbCrlf & g, vbCrlf & h & vbCrlf) = False Then
                    g = g & h & vbCrlf
                    b = b + 1
                End If
            End If
        Next
    End If
    GetTel = g
End Function

Function GetMail(ByVal a, b)
    Dim c, d, e, f, g, h, i, j
    a = Replace(Replace(LCase(a), "&nbsp;", ""), "邮箱", "mail")
    b = 0
    If InStr(a, "mail") > 0 Then
        c = Split(a, "mail")
        For d = 1 To UBound(c)
            f = c(d)
            h = "" : i = 14 : j = False
            For e = 1 To Len(f)
                If InStr("0123456789abcdefghijklmnopqrstuvwxyz.@", Mid(f, e, 1)) = False Then
                    If j = True Then Exit For
                    If i = 0 Then Exit For
                    i = i - 1
                Else
                    j = True
                    h = h & Mid(f, e, 1)
                End If
                If e > 30 Then Exit For
            Next
            If InStr(h, ".") > 0 And InStr(h, "@") > 0 Then
                If InStr(vbCrlf & g, vbCrlf & h & vbCrlf) = False Then
                    g = g & h & vbCrlf
                    b = b + 1
                End If
            End If
        Next
    End If
    GetMail = g
End Function

Function GetImgStr(a, b, c)
    Dim d, e, f, g, h
    b = GetIMG(b)
    d = Split(b, vbCrlf)
    c = 0
    For Each g In d
        If InStr("|" & h & "|", "|" & g & "|") = False Then
            If Left(g, 1) = "/" Or(InStr(g, "http://") = False And InStr(g, "www.") = False) Then
                g = FullHttpUrl(a, g)
            End If
            c = c + 1
            f = f & g & "<br>"
        End If
    Next
    GetImgStr = f
End Function

Function GetCssStr(a, b, c)
    Dim d, e, f, g, h
    b = GetCssHref(b)
    d = Split(b, vbCrlf)
    c = 0
    For Each g In d
        If InStr("|" & h & "|", "|" & g & "|") = False Then
            If Left(g, 1) = "/" Or(InStr(g, "http://") = False And InStr(g, "www.") = False) Then
                g = FullHttpUrl(a, g)
            End If
            c = c + 1
            f = f & g & "<br>"
        End If
    Next
    GetCssStr = f
End Function

Function GetJsStr(a, b, c)
    Dim d, e, f, g, h
    b = GetJsSrc(b)
    d = Split(b, vbCrlf)
    c = 0
    For Each g In d
        If InStr("|" & h & "|", "|" & g & "|") = False Then
            If Left(g, 1) = "/" Or(InStr(g, "http://") = False And InStr(g, "www.") = False) Then
                g = FullHttpUrl(a, g)
            End If
            c = c + 1
            f = f & g & "<br>"
        End If
    Next
    GetJsStr = f
End Function


Function HandleAspExecute(ByVal a)
	Dim b,c,d
	If Left(a,2)="<" & "%" Then
		a = Right(a,Len(a)-2)
	End If	
	If Right(a,2)="%" & ">" Then
		a = Left(a, Len(a)-2)
	End If
	
	b=Split(a,vbCrlf)
	For Each c In b
		c = TrimVbCrlf(c)
		If c <> "" Then
			d=d & c & ":"
		End If
	Next
	If d <>"" Then d=Left(d, Len(d)-1)
	If Left(d,1)="=" Then d = "Response.Write " & Right(d,Len(d)-1)
	HandleAspExecute = d
End Function

Function GetUrlStr(a, b, c, d, e)
    Dim f, g, h, i, j, k, l, m, n, o, p
    If b = "链接" Then
        f = GetAURL(c)
    ElseIf b = "链接标题" Then
        f = GetATitle(c)
    Else
        f = GetAURLTitle(c)
    End If
    g = Split(f, vbCrlf)
    e = 0
    For Each k In g
        If k <> "" Then
            If b = "链接" Then
                i = Trim(k)
                If InStr(LCase(i), "javascript:") = False And i <> "#" And i <> "" Then
                    If InStr("|" & m & "|", "|" & i & "|") = False Then
                        If Left(i, 1) = "/" Or(InStr(i, "http://") = False And InStr(i, "www.") = False) Then
                            i = FullHttpUrl(a, i)
                        End If
                        e = e + 1
                        j = j & i & vbCrlf
                    End If
                End If
            ElseIf b = "链接标题" Then
                If InStr("|" & n & "|", "|" & k & "|") = False Then
                    n = n & k & "|"
                    e = e + 1
                    j = j & k & vbCrlf
                End If
            Else
                If InStr(k, "【_|-】") > 0 Then
                    i = Mid(k, 1, InStr(k, "【_|-】") - 1) : l = i
                    h = Mid(k, Len(i) + 6)
                    If InStr(LCase(l), "javascript:") = False And i <> "#" And i <> "" Then
                        If InStr("|" & m & "|", "|" & i & "|") = False Then
                            If Left(i, 1) = "/" Or(InStr(l, "http://") = False And InStr(l, "www.") = False) Then
                                i = FullHttpUrl(a, i)
                            End If
                            e = e + 1
                            j = j & i & "   &nbsp;  " & h & vbCrlf
                        End If
                    End If
                End If
            End If
        End If
    Next
    If d <> "" Then
        d = Replace(d, " and ", " And ")
        g = Split(d, " And ")
        o = g(0)
        If UBound(g) > 0 Then p = g(1)
        g = Split(j, vbCrlf) : e = 0 : j = ""
        For Each k In g
            If p <> "" Then
                If InStr(k, o) > 0 And InStr(k, p) > 0 Then
                    If InStr(vbCrlf & j & vbCrlf, vbCrlf & k & vbCrlf) = False Then
                        e = e + 1
                        j = j & k & "<br>"
                    End If
                End If
            Else
                If InStr(k, o) > 0 Then
                    If InStr(vbCrlf & j & vbCrlf, vbCrlf & k & vbCrlf) = False Then
                        e = e + 1
                        j = j & k & "<br>"
                    End If
                End If
            End If
        Next
    End If
    GetUrlStr = j
End Function

Function GetPageConfig(a, b, c)
    Dim d, e, f, g, h, i, j, k, ArrUrl(99), m, n, o, p
    b = GetAURL(b)
    d = Split(b, vbCrlf)
    For Each j In d
        If j <> "" Then
            k = j
            If InStr(LCase(j), "javascript:") = False And j <> "#" Then
                j = Replace(Replace(Replace(Replace(Replace(j, "0", ""), "1", ""), "2", ""), "3", ""), "4", "")
                j = Replace(Replace(Replace(Replace(Replace(j, "5", ""), "6", ""), "7", ""), "8", ""), "9", "")
                If c = "注入" And InStr(j, "?") > 0 Then j = HandlSqlInUrl(j)
                i = i & j & vbCrlf
                o = InStr(vbCrlf & m, vbCrlf & j & "【】")
                If o > 0 Then
                    f = Mid(m, o)
                    f = Mid(f, 1, InStr(f, vbCrlf) - 1)
                    p = Split(f, "【】")
                    g = p(0)
                    h = p(1) + 1
                    m = Replace(m, f, g & "【】" & h & "【】" & p(2))
                    n = j
                Else
                    m = m & j & "【】0【】" & FullHttpUrl(a, k) & vbCrlf
                End If
            End If
        End If
    Next
    d = Split(m, vbCrlf) : i = ""
    If c = "注入" Then
        For Each f In d
            If InStr(f, "【】") > 0 Then
                p = Split(f, "【】")
                j = Trim(p(2))
                If InStr(j, a) > 0 Then
                    If InStr(vbCrlf & i, vbCrlf & j & vbCrlf) = False Then
                        i = i & j & vbCrlf
                    End If
                End If
            End If
        Next
        GetPageConfig = i : Exit Function
    End If

    For Each f In d
        If InStr(f, "【】") > 0 Then
            p = Split(f, "【】")
            If p(1) > 0 Then ArrUrl(p(1)) = p(0) & "  &nbsp; | &nbsp; " & p(2)
        End If
    Next
    For e = 99 To 0 Step - 1
        If ArrUrl(e) <> "" Then
            If InStr(ArrUrl(e), a) > 0 Then
                i = i & ArrUrl(e) & "，   出现[" & e & "]次<br>"
            End If
        End If
    Next
    GetPageConfig = i
End Function

Function GetSqlInUrl(a, b, c)
    Dim d, e, f, g, h, i, j, k, ArrUrl(99), m, n, o, p
    b = GetAURL(b)
    d = Split(b, vbCrlf)
    For Each j In d
        If j <> "" Then
            k = j
            If InStr(j, "?") > 0 Then
                i = i & j & vbCrlf
                j = HandlSqlInUrl(j)
                o = InStr(vbCrlf & m, vbCrlf & j & "【】")
                If o > 0 Then
                    f = Mid(m, o)
                    f = Mid(f, 1, InStr(f, vbCrlf) - 1)
                    p = Split(f, "【】")
                    g = p(0)
                    h = p(1) + 1
                    m = Replace(m, f, g & "【】" & h & "【】" & p(2))
                    n = j
                Else
                    m = m & j & "【】0【】" & FullHttpUrl(a, k) & vbCrlf
                End If
            End If
        End If
    Next
    d = Split(m, vbCrlf)
    For Each f In d
        If InStr(f, "【】") > 0 Then
            p = Split(f, "【】")
            If h > 0 Then
                If c = "注入" Then
                    ArrUrl(p(1)) = p(2)
                Else
                    ArrUrl(p(1)) = p(0) & "  &nbsp; | &nbsp; " & p(2)
                End If
            End If
        End If
    Next
    i = ""
    For e = 99 To 0 Step - 1
        If ArrUrl(e) <> "" Then
            If c = "注入" Then
                i = i & ArrUrl(e) & vbCrlf
            Else
                i = i & ArrUrl(e) & "，   出现[" & e & "]次<br>"
            End If
        End If
    Next
    GetSqlInUrl = i
End Function

Function HandlSqlInUrl(a)
    Dim b, c, d, e
    c = Split(a, "=")
    For d = 0 To UBound(c)
        If d = UBound(c) Then b = b & "=" : Exit For
        e = c(d)
        If d Mod 2 = 0 Then
            b = b & c(d)
        Else
            If InStr(e, "&") > 0 Then
                b = b & "=" & Mid(e, InStr(e, "&"))
            End If
        End If
    Next
    HandlSqlInUrl = b
End Function




Function GetScanFunctionNameList(a)
	On Error Resume Next
    Dim b, c, d, e, f, g, h, i, j, k, l, m,n,o
    Dim p ,q,r
	Dim YesFunction								
    d = False
    YesFunction = False
    e = False
    l = 0
    b = Split(a, vbCrlf)

    For Each g In b

        For c = 1 To Len(g)
            f = Mid(g, c, 1)

            If f = "<" And h = "" Then
                If Mid(g, c + 1, 1) = "%" Then
                     d = True
                     c = c + 1
                End If

            ElseIf f = "%" And Mid(g, c + 1, 1) = ">" And h = "" Then				
                d = False
                c = c + 1
            End If
            If d = True Then

                If(f = """" Or h <> "") Then

                    If f = """" Then l = l + 1

                    If l Mod 2 = 0 Then
                        If Mid(g, c + 1, 1) <> """" Then
                            h = h & f
                            j = Right(Replace(Mid(g, 1, c - Len(h)), " ", ""), 1)
                            If YesFunction = True Then k = k & h 			
                            l = 0 : h = ""
                        Else
                            h = h & f
                        End If
                    Else
                        h = h & f
                    End If
                ElseIf f = "'" Then
                    If YesFunction = True Then k = k & Mid(g, c)
                    Exit For

				ElseIf CheckABC(f) = True Or (f = "_" And i<>"") Or i <> "" Then
                    i = i & f
                    j = LCase(Mid(g & " ", c + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 And Not(j = "_" And i <> "") Then
						q = Mid(g,c+1)
                        If InStr("|function|sub|", "|" & LCase(i) & "|") Then							
							
                            If YesFunction = False And LCase(m) <> "end" Then
                                YesFunction = True
								o = Mid(g,c+2)
								o = Mid(o,1,InStr(o,"(")-1)
								n = n & o & vbCrlf
                            ElseIf YesFunction = True And LCase(m) = "end" Then
                                k = k & i & vbCrlf
								
                                YesFunction = False
                            End If
						
                        End If
                        m = i
                        If YesFunction = True Then k = k & i
                        i = ""
                    End If

                End If
            End If	
        	DoEvents
        Next		

    Next
	GetScanFunctionNameList = n
End Function

Function GetFunName(ByVal a)
	If InStr(a,"(")>0 Then
		a=Mid(a,1,InStr(a,"(")-1)
		a=PHPTrim(a)
	End If
	GetFunName = a
End Function

Function GetFunDimName(ByVal a)
	Dim b,c,d
	a = LCase(a)
	b = "("
	c = ")"
 	If InStr(a, b)>0 And InStr(a, c)>0 Then
		a = StrCut(a,b,c,2)
	End If
	If a <> "" Then
		a=Replace(Replace(a,"byref ",""),"byref,","")
		a=Replace(Replace(a,"byval ",""),"byval,","")
		a=Replace(a," ","")
	End If
	GetFunDimName = a
End Function

Function GetDimName(ByVal a)
	Dim b,c,d
	a = LCase(a)
	b = ":"
 	If InStr(a, b)>0 Then
		a = Mid(a,1,InStr(a,":")-1)
	End If
	If a <> "" Then
		a=Replace(Replace(a,"byref ",""),"byref,","")
		a=Replace(Replace(a,"byval ",""),"byval,","")
		a=Replace(a," ","")
	End If
	If InStr(a,"'")>0 Then
		a= PHPTrim(Mid(a,1,InStr(a,"'")-1))				
	End If
	GetDimName = a
End Function

Function GetSetName(ByVal a)
	a = PHPTrim(LCase(a))
 	a=Mid(a, 1,InStr(a,"=")-1)
	GetSetName=Trim(a)
End Function

Function ReplaceDim(ByVal a)
	Dim b, c, d, e, f, g
	b = Split(a, ",")
	For Each c In b
		c = Trim(c)
		f = LCase(c)
		If c <> "" Then
			
			If InStr(c, "(") > 0 Then
				c = Mid(c, 1, InStr(c, "(") - 1)
			End If
			g = InStr(LCase(ReplaceDimList), "," & f & "=")
			If g > 0 Then
				d = Mid(ReplaceDimList, g + 1)
				d = Mid(d, 1, InStr(d, ",") - 1)
				d = Mid(d, InStr(d, "=") + 1)
				If InStr(FunDim & RootFunDim, "," & d & ",") = False Then
					c = d
				End If
			End If
			e = e & c & ","
		End If
	Next
	If e <> "" Then e = Left(e, Len(e) - 1)
	ReplaceDim = e
End Function

Function ReplaceDim2(ByVal a,b)
	Dim c,d,e,f,g,h,i
	ReplaceDim2  = b
	c="abcdefghijklmnopqrstuvwxyz"
	b=LCase(b)
	d=Split(a,",")
	For e=0 To Ubound(d)
		f = d(e)
		If f = b Then
			g = (e) Mod Len(c)+1
			h = Fix((e)/Len(c))
			
			If g<>0 Then
				i=i & Mid(c,g,1)
			End If
			If h<>0 Then
				i=i & CopyStr(Mid(c,h,1),h)
			End If
			
			
			
			
			ReplaceDim2 = i
			Exit Function
		End If
	Next
End Function

Function FindFolderRepeatFunction(a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n, o
	Dim p,q
    Call HandlePath(a)
    d = "操作文件夹" & a & vbCrLf
    e = GetDirFileList(a)
    k = Split(e, vbCrLf) : o = 0
    For Each b In k
        o = o + 1
        c = o & "、" & b
    	e = GetFText(b)
	    e = GetScanFunctionNameList(e)				
        i = 0 : j = 0 : m = 0 : n = 0 : g = "" : p = "" : q=""
        l = Split(e, vbCrLf)
        For Each f In l
            If f <> "" Then
                If InStr("|" & g & "|", "|" & f & "|") = 0 Then
                    g = g & f & "|"
                    i = i + 1
                Else
					p=p & f & "|"
                    j = j + 1
                End If
                If InStr("|" & h & "|", "|" & f & "|") = 0 Then
                    h = h & f & "|"
                    m = m + 1
                Else
					q=q & f & "|"
                    n = n + 1
                End If
            End If
            DoEvents
        Next
		
        d = d & c & "，函数（" & UBound(k) + 1 & "），重复(" & j & "["& p &"])全部函数重复(" & n & "["& q &"])" & vbCrLf
        DoEvents
    Next
    FindFolderRepeatFunction = d
End Function

Function FindFileRepeatFunction(a)
    FindFileRepeatFunction = HandleContentRepeatFunction(GetFText("FilePath"), 2)
End Function

Function FindContentRepeatFunction(a)
    FindContentRepeatFunction = HandleContentRepeatFunction(Contnet, 2)
End Function

Function HandleContentRepeatFunction(a, b)
    Dim c, d, e, f, g, h, i
    b = CStr(b)
    a = GetScanFunctionNameList(a)
    f = 0 : g = 0
    h = Split(a, vbCrLf)
    For Each d In h
        If d <> "" Then
            If InStr("|" & e & "|", "|" & d & "|") = 0 Then
                e = e & d & "|"
                f = f + 1
            Else
                i = i & d & vbCrLf
                g = g + 1
            End If
        End If
        DoEvents
    Next
    c = "找到函数共（" & UBound(h) + 1 & "），重复(" & g & ")" & vbCrLf
	
	If b = "1" Or b="3" Then
		 c = c & vbCrLf & "函数列表" & vbCrLf & e
	End If
	
    If i <> "" And (b = "1" Or b="3") Then
        c = c & vbCrLf & "重复函数列表" & vbCrLf & i
    End If
    HandleContentRepeatFunction = c
End Function

Function Replace2(a,b,c)
	Dim d,e
	If InStr(a,b) > 0 Then
		d = Mid(a, 1, InStr(a,b)-1)
		e = Mid(a, Len(d)+Len(b)+1)
		a = d & c & e
	End If
	Replace2 = a
End Function

Function AllReplace(a,b,c)
	Dim d,e,f
	For f = 1 To 99
		If InStr(a,b) > 0 Then
			d = Mid(a, 1, InStr(a,b)-1)
			e = Mid(a, Len(d)+Len(b)+1)
			a = d & c & e
		Else
			Exit For
		End If
	Next
	AllReplace = a
End Function

Function ReplaceOneNOLU(a,b,c)
	Dim d,e,f
	b=LCase(b)
	f=LCase(a)
	If InStr(f,b) > 0 Then
		d = Mid(a, 1, InStr(f,b)-1)
		e = Mid(a, Len(d)+Len(b)+1)
		a = d & c & e
	End If
	ReplaceOneNOLU = a
End Function

Function OptimizeAspCode(a)
    Dim b,c,d,e
	b=Split(a,vbCrlf)
	For Each c In b
		c = TrimVbTab(c)
		If c <> "" Then d=d & TrimVbTab(c) & vbCrlf
	Next
    OptimizeAspCode = d
End Function

Function AspCodeConfusion(a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m
    Dim n ,o,p
	Dim YesFunction								
	Dim StartFunction							
	StartFunction = False						
	
    d = False
    YesFunction = False
    e = False
    l = 0
    b = Split(a, vbCrlf)

    For Each g In b

        For c = 1 To Len(g)
            f = Mid(g, c, 1)

            If f = "<" And h = "" Then
                If Mid(g, c + 1, 1) = "%" Then
                     d = True
                     c = c + 1
					 f = Mid(g, c, 1)
					 k = k & "<"
                End If

            ElseIf f = "%" And Mid(g, c + 1, 1) = ">" And h = "" Then				
                d = False
                c = c + 1
				f = Mid(g, c, 1)
				k = k & "%"
            End If
            If d = True Then

                If(f = """" Or h <> "") Then

                    If f = """" Then l = l + 1

                    If l Mod 2 = 0 Then
                        If Mid(g, c + 1, 1) <> """" Then
                            h = h & f
                            j = Right(Replace(Mid(g, 1, c - Len(h)), " ", ""), 1)
                            k = k & h 			
                            l = 0 : h = ""
                        Else
                            h = h & f
                        End If
                    Else
                        h = h & f
                    End If
                ElseIf f = "'" Then
                    k = k & Mid(g, c)
                    Exit For

				ElseIf CheckABC(f) = True Or (f = "_" And i<>"") Or i <> "" Then
                    i = i & f
                    j = LCase(Mid(g & " ", c + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 And Not(j = "_" And i <> "") Then
						o = Mid(g,c+1)
                        If InStr("|function|sub|", "|" & LCase(i) & "|") Then					
							
                            If YesFunction = False And LCase(m) <> "end" Then
                                YesFunction = True
								p = GetFunDimName(o)
								StartFunction=True
                            ElseIf YesFunction = True And LCase(m) = "end" Then
                                YesFunction = False
                            End If
						ElseIf YesFunction = True And LCase(i) = "dim" Then
							p = p & "," & GetDimName(o)
						ElseIf YesFunction = True  Then
							
							If StartFunction=False Then
								i = ReplaceDim2(p, i)
							End If
							StartFunction=False
                        End If
                        m = i
                        k = k & i
                        i = ""
                    End If
				Else
					k = k & f
                End If
			Else
				k = k & f
            End If
        	DoEvents
        Next		
        k = RTrim(k)
        k = k & vbCrlf
        DoEvents
    Next
    AspCodeConfusion = k
End Function

Function ASPVariableGarbled(a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m
    Dim n ,o,p
	Dim YesFunction								
	
    d = False
    YesFunction = False
    e = False
    l = 0
    b = Split(a, vbCrlf)

    For Each g In b

        For c = 1 To Len(g)
            f = Mid(g, c, 1)

            If f = "<" And h = "" Then
                If Mid(g, c + 1, 1) = "%" Then
                     d = True
                     c = c + 1
					 f = Mid(g, c, 1)
					 k = k & "<"
                End If

            ElseIf f = "%" And Mid(g, c + 1, 1) = ">" And h = "" Then				
                d = False
                c = c + 1
				f = Mid(g, c, 1)
				k = k & "%"
            End If
            If d = True Then

                If(f = """" Or h <> "") Then

                    If f = """" Then l = l + 1

                    If l Mod 2 = 0 Then
                        If Mid(g, c + 1, 1) <> """" Then
                            h = h & f
                            j = Right(Replace(Mid(g, 1, c - Len(h)), " ", ""), 1)
                            k = k & h 			
                            l = 0 : h = ""
                        Else
                            h = h & f
                        End If
                    Else
                        h = h & f
                    End If
                ElseIf f = "'" Then
                    k = k & Mid(g, c)
                    Exit For

				ElseIf CheckABC(f) = True Or (f = "_" And i<>"") Or i <> "" Then
                    i = i & f
                    j = LCase(Mid(g & " ", c + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 And Not(j = "_" And i <> "") Then
						o = Mid(g,c+1)

                        k = k & LUCaseGarbled(i)
                        i = ""
                    End If
				Else
					k = k & f
                End If
			Else
				k = k & f
            End If
        	DoEvents
        Next		
        k = RTrim(k)
        k = k & vbCrlf
        DoEvents
    Next
    ASPVariableGarbled = k
End Function

Function LUCaseGarbled(a)
    Dim b, c, d, e, f, g
    g = 0
    For d = 1 To Len(a)
        e = Mid(a, d, 1)
        g = g + 1
        If g = 1 Then
            e = LCase(e)
        ElseIf g = 2 Or g = 3 Then
            e = UCase(e)
        ElseIf g = 4 Then
            e = LCase(e): g = 1
        End If
        f = f & e
    Next
    LUCaseGarbled = f
End Function


Function AspFunctionConfusion(a)
    Dim b, c,d,e, f, g, h, i, j, k, l, m, n, o,p
    Dim q ,r,s
	Dim YesFunction								
	Dim StartFunction							
	StartFunction = False						
	dim nFunIndex								
	nFunIndex=0
	dim w
	
	w=split("aa|ab|ac|ad|ae|af|ag|ah|ai|aj|ak|al|am|an|ao|ap|aq|ar|at|au|av|aw|ax|ay|az|ba|bb|bc|bd|be|bf|bg|bh|bi|bj|bk|bl|bm|bn|bo|bp|bq|br|bs|bt|bu|bv|bw|bx|by|bz|ca|cb|cc|cd|ce|cf|cg|ch|ci|cj|ck|cl|cm|cn|co|cp|cq|cr|cs|ct|cu|cv","|")
	dim x,y
	y= "|"& lcase(getAspFunNameList(a)) &"|"
	x=split(y,"|")

	
    f = False
    YesFunction = False
    g = False
    n = 0
	s="|"			
    b = Split(a, vbCrlf)

    For Each i In b

        For d = 1 To Len(i)
            h = Mid(i, d, 1)

            If h = "<" And j = "" Then
                If Mid(i, d + 1, 1) = "%" Then
                     f = True
                     d = d + 1
					 h = Mid(i, d, 1)
					 m = m & "<"
                End If

            ElseIf h = "%" And Mid(i, d + 1, 1) = ">" And j = "" Then				
                f = False
                d = d + 1
				h = Mid(i, d, 1)
				m = m & "%"
            End If
            If f = True Then

                If(h = """" Or j <> "") Then

                    If h = """" Then n = n + 1

                    If n Mod 2 = 0 Then
                        If Mid(i, d + 1, 1) <> """" Then
                            j = j & h
                            l = Right(Replace(Mid(i, 1, d - Len(j)), " ", ""), 1)
                            m = m & j 			
                            n = 0 : j = ""
                        Else
                            j = j & h
                        End If
                    Else
                        j = j & h
                    End If
                ElseIf h = "'" Then
                    m = m & Mid(i, d)
                    Exit For

				ElseIf CheckABC(h) = True Or (h = "_" And k<>"") Or k <> "" Then
                    k = k & h
                    l = LCase(Mid(i & " ", d + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", l) = 0 And Not(l = "_" And k <> "") Then
						r = Mid(i,d+1)
                        If InStr("|function|sub|", "|" & LCase(k) & "|") Then					
							
                            If YesFunction = False And LCase(o) <> "end" and LCase(o) <> "exit" Then
                               s=s & lcase(GetFunName(r)) & "," & w(nFunIndex)  & "|"
							   nFunIndex=nFunIndex+1
							
								StartFunction=True
                            ElseIf YesFunction = True And LCase(o) = "end" Then
								StartFunction=False
                            End If
						ElseIf YesFunction = True And LCase(k) = "dim" Then
							
					
                        End If
						
						p=instr(y ,"|" & lcase(k) & "|")
						if p>0 then
							for e=1 to ubound(x)
								if x(e)=lcase(k) then
									
									k=w(e)
									exit for
								end if
							next
						end if
						
                        o = k
                        m = m & k
                        k = ""
                    End If
				Else
					m = m & h
                End If
			Else
				m = m & h
            End If
        	DoEvents
        Next		
        m = RTrim(m)
        m = m & vbCrlf
        DoEvents
    Next
    AspFunctionConfusion = m
End Function


Function getAspFunNameList(a)
    Dim b, c,d, e, f, g, h, i, j, k, l, m, n,o
    Dim p ,q,r
	Dim YesFunction								
	Dim StartFunction							
	StartFunction = False						
	
    e = False
    YesFunction = False
    f = False
    m = 0
	
    b = Split(a, vbCrlf)

    For Each h In b

        For d = 1 To Len(h)
            g = Mid(h, d, 1)

            If g = "<" And i = "" Then
                If Mid(h, d + 1, 1) = "%" Then
                     e = True
                     d = d + 1
					 g = Mid(h, d, 1)
					 l = l & "<"
                End If

            ElseIf g = "%" And Mid(h, d + 1, 1) = ">" And i = "" Then				
                e = False
                d = d + 1
				g = Mid(h, d, 1)
				l = l & "%"
            End If
            If e = True Then

                If(g = """" Or i <> "") Then

                    If g = """" Then m = m + 1

                    If m Mod 2 = 0 Then
                        If Mid(h, d + 1, 1) <> """" Then
                            i = i & g
                            k = Right(Replace(Mid(h, 1, d - Len(i)), " ", ""), 1)
                            l = l & i 			
                            m = 0 : i = ""
                        Else
                            i = i & g
                        End If
                    Else
                        i = i & g
                    End If
                ElseIf g = "'" Then
                    l = l & Mid(h, d)
                    Exit For

				ElseIf CheckABC(g) = True Or (g = "_" And j<>"") Or j <> "" Then
                    j = j & g
                    k = LCase(Mid(h & " ", d + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", k) = 0 And Not(k = "_" And j <> "") Then
						q = Mid(h,d+1)
                        If InStr("|function|sub|", "|" & LCase(j) & "|") Then					
							
                            If YesFunction = False And LCase(n) <> "end" and LCase(n) <> "exit" Then
                               r=r & GetFunName(q) & "|"
							
                            End If					
                        End If
                        n = j
						j=""
                    End If
                End If
            End If
        	DoEvents
        Next		
    Next
    getAspFunNameList = r
End Function

Function AspCodeSafe(a)
	
	if instr(a,"'【Asp函数" & "名称混淆】")>0 then			
		a = AspFunctionConfusion(a )	
	end if
	a = DelAspNote(a)			
	a = OptimizeAspCode(a)		
	a = AspCodeConfusion(a )	
	a = ASPVariableGarbled(a )	
	AspCodeSafe = a
End Function


function cutDaKuoHao(a)
	cutDaKuoHao=cutFunctionvValue(a,"{","}")
end function

function cutXianKuoHao(a)
	cutXianKuoHao=cutFunctionvValue(a,"(",")")
end function


function cutFunctionvValue(a,b,c)
	dim d,e,f,g,h
	d=1:e=0
	for f=1 to len(a)
		g=mid(a,f,1)
		h=h & g
		if g=b then
			d=d+1
		elseif g=c then
			e=e+1
			if d=e then
				exit for
			end if
		end if
	next
	cutFunctionvValue = h
end function

function getStrIntContentNumb(a,b)
	dim c
	if instr(a,b)>0 then
		c=split(a,b)
		getStrIntContentNumb = Ubound(c)
	else
		getStrIntContentNumb=0
	end if
end function
%>







