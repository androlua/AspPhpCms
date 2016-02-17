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
Option Explicit

dim c

c="{$getLableValue title='标题 now()'content=""len(now())""$}"
call rw(HandleAction(c))




Function HandleAction(a)
    Dim b, c, d, e, f, g, h
    b = "{\$" : c = "\$}"
    d = GetArray(a, b, c, True, True)
    e = Split(d, "$Array$")
    For Each g In e
        f = Trim(g)
        If f <> "" Then
          f = Trim(Mid(f,3,Len(f)-4)) & " "
            h = True

            If CheckFunValue(f, "# ") = True Then
                f = ""

            ElseIf CheckFunValue(f, "getLableValue ") = True Then
                f = XY_getLableValue(f)
            Else
                h = False
            End If

            If isNul(f) = True Then f = ""
            If h = True Then
                a = Replace(a, g, f)
            End If
        End If
    Next
    HandleAction = a
End Function

Function XY_getLableValue(a)
    Dim b,c,d
    b = RParam(a, "title")
    c = RParam(a, "content")
	d=d & "title=" & GetContentRunStr(b) & "<hr>"
	d=d & "content=" & GetContentRunStr(c) & "<hr>"
    XY_getLableValue = d
End Function


Function ReplaceValueParam(a,b,c)
	Dim d,e,f,g,h,i,j
	

	If IsNul(c)=True Then c=""
	
	d="[$"& b : e = "$]"
	If InStr(a,d)>0 And InStr(a,e)>0 Then
		f = StrCut(a,d,e,1)
		
		i = RParam(f,"DelHtml")			
		If i="true" Then c = Replace(DelHtml(c),"<","&lt;")			
		
		j = RParam(f,"Trim")			
		If j="true" Then c = TrimVbCrlf(c)
	
		
		g = RParam(f,"Len")			
		g = HandleNumber(g)
		
		If g<>"" Then c = CutStr(c,g,"...")
		
		
		h  = RParam(f,"Format_Time")			
		If h<>"" Then
			c = Format_Time(c, h)
		End If		
		a = Replace(a,f,c)
		
	End If
	ReplaceValueParam = a
End Function
Function DelHtml(ByVal a)
    On Error Resume Next
    Dim b, c
    Set b = CreateObject("VBscript.RegExp")
        b.IgnoreCase = True
        b.Global = True
        b.Pattern = "(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)"
        c = b.Replace(a, "")
        DelHtml = c
    Set b = Nothing
    If Err Then doError Err.Description, "DelHtml 删除HTML标签 函数出错，strHtml=" & a
End Function
Function TrimVbCrlf(a)
    TrimVbCrlf = rtrimVBcrlf(ltrimVBcrlf(a))
End Function

Function HandleNumber(ByVal a)
    Dim b, c, d
    d = ""
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
        If InStr("0123456789", c) > 0 Then
            d = d & c
        End If
    Next
    HandleNumber = d
End Function

Function CutStr(ByVal a, ByVal b, ByVal c)
    Dim d, e, f
    f = 0
    b = Cint(b)
    If c = "" Then c = "..."
    If LCase(c) = "none" Or LCase(c) = "null" Then c = ""
    CutStr = a
    For d = 1 To Len(a)
        e = Asc(Mid(Cstr(a), d, 1))
        If e < 0 Then e = e + 65536
        If e < 255 Then f = f + 1
        If e > 255 Then f = f + 2
        If f >= b Then CutStr = Left(a, d) & c : Exit Function
    Next
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

Function rtrimVBcrlf(a)
    Dim b, c
    b = Len(a)
    c = True
    While c and b >= 2
        If Mid(a, b, 1) = " " or Mid(a, b, 1) = vbTab Then
            b = b - 1
        ElseIf Mid(a, b - 1, 2) = vbCrLf Then
            b = b - 2
        Else
            c = False
        End If
    Wend
    rtrimVBcrlf = RTrim(Left(a, b))
End Function

Function ltrimVBcrlf(a)
    Dim b, c
    b = 1
    c = True
    While c
        If Mid(a, b, 1) = " " Or Mid(a, b, 1) = vbTab Then
            b = b + 1
        ElseIf Mid(a, b, 2) = vbCrLf Then
            b = b + 2
        Else
            c = False
        End If
    Wend
    ltrimVBcrlf = Right(a, Len(a) - b + 1)
End Function

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



Function echoPrompt(a, b)
    Response.Write("<font color=Green>" & a & "</font>：" & b & "<br>")
End Function
Function Echo(a, b)
    Call echoPrompt(a, b)
End Function


Function GetArray(a, b, c, d, e)
    GetArray = GetArrayList(a, b, c, d, e, "")
End Function

Function CheckFunValue(a, b)
    CheckFunValue =(Left(a, Len(b)) = b)
End Function

Function isNul(ByVal a)
    On Error Resume Next : IF Err.Number <> 0 Then Err.Clear
    isNul = False
    Select Case VarType(a)
        Case vbEmpty, vbNull
            isNul = True : Exit Function
        Case vbString
            If a = "" Then isNul = True : Exit Function
        Case vbObject
            Select Case TypeName(a)
                Case "Nothing", "Empty"
                    isNul = True : Exit Function
                Case "Recordset"
                    If a.State = 0 Then isNul = True : Exit Function
                    If a.Bof And a.Eof Then isNul = True : Exit Function
                Case "Dictionary"
                    If a.Count = 0 Then isNul = True : Exit Function
            End Select
    Case vbArray, 8194, 8204, 8209
        If Ubound(a) = -1 Then isNul = True : Exit Function
    End Select
    On Error Goto 0
End Function


Function GetArrayList(ByVal a, ByVal b, ByVal c, ByVal d, ByVal e, ByVal f)

    If IsNull(a) = True Or IsNull(b) = True Or IsNull(c) = True Then
        GetArrayList = ""
        Exit Function
    End If
    Dim g, h, i, j
    a = Replace(Replace(a, Chr(10), "【换行】"), Chr(13), "【换行】")
    Set h = CreateObject("VBscript.RegExp")
        h.IgnoreCase = True
        h.Global = True
        h.Pattern = "(" & b & ").+?(" & c & ")"
        Set i = h.Execute(a)
            For Each j In i
                g = g & "$Array$" & j.Value
            Next
        Set i = Nothing
        If g = "" Then
            GetArrayList = ""
            Exit Function
        End If
        g = Right(g, Len(g) - 7)
        If d = False Then
            h.Pattern = b
            g = h.Replace(g, "")
        End If
        If e = False Then
            h.Pattern = c
            g = h.Replace(g, "")
        End If
    Set h = Nothing
    If f = "1" Or f = "去掉字符" Or f = True Then
        g = Replace(g, """", "")
        g = Replace(g, "'", "")
        g = Replace(g, " ", "")
        g = Replace(g, "(", "")
        g = Replace(g, ")", "")
    End If
    GetArrayList = g
End Function


Function RParam(ByVal a, ByVal b)
    dim c
	
    c = handleRParam(a, b, "'")
	
    if c = "" then
        c = handleRParam(a, b, """")
    end if
	
    if c = "" then
        c = handleRParam(a, b, "")
    end if
	
	
	if c = "" then
	    c = handleRParam(a, LCase(b), "'")
	end if
	
    if c = "" then
        c = handleRParam(a, LCase(b), """")
    end if
	
    if c = "" then
        c = handleRParam(a, LCase(b), "")
    end if
	
	
	if c = "" then
	    c = handleRParam(a, UCase(b), "'")
	end if
	
    if c = "" then
        c = handleRParam(a, UCase(b), """")
    end if
	
    if c = "" then
        c = handleRParam(a, UCase(b), "")
    end if	
    RParam = c
End Function
function handleRParam(ByVal a, ByVal b, ByVal c)
    Dim d,e
	e = IIF(c<>"",c," ")
    a = vbCrLf & " " & a
	
    d = " " & b

    If InStr(a, d & "=" & c) = False Then
        d = "'" & b
    End If

    If InStr(a, d & "=" & c) = False Then
        d = """" & b
    End If

    If InStr(a, d & "=" & c) = False Then
        d = vbTab & b
    End If

    If InStr(a, d & "=" & c) = False Then
        d = vbCrLf & b
    End If
    If InStr(a, d & "=" & c) > 0 And InStr(a, e) > 0 Then
        handleRParam = StrCut(a, d & "=" & c, e, 2)
        handleRParam = HandleInModule(handleRParam, "end")

        If InStr(handleRParam, "{$") > 0 And InStr(handleRParam, "$}") > 0 Then
            handleRParam = HandleAction(handleRParam)
        End If
    End If
End Function
Function IIf(a, b, c)
    If(a) Then IIf = b Else IIf = c
End Function
Function StrCut(ByVal a, ByVal b, ByVal c, ByVal d)
    On Error Resume Next
    Dim e, f, g
    Select Case d
        Case 1
            e = InStr(a, b)
            f = InStr(e, a, c) + Len(c)
        Case 2, 0, ""
            e = InStr(a, b) + Len(b)
            f = InStr(e, a, c)
    End Select
    g = f - e
    If g >= 0 Then
        StrCut = Mid(a, e, g)
    Else
        StrCut = ""
    End If
    If Err <> 0 Then Call Eerr(b, a)

End Function

Function HandleInModule(a, b)
    b = LCase(CStr(b))
    If b = "1" Or b = "start" Then
        a = Replace(a, "\'", "\|*|\")
        a = Replace(a, "\=", "\|&|\")
    ElseIf b = "2" Or b = "end" Then
        a = Replace(a, "\|*|\", "'")
        a = Replace(a, "\$", "$")
        a = Replace(a, "\}", "}")

        a = Replace(a, "\|&|\", "=")
    End If
    HandleInModule = a
End Function

Function Eerr(a, b)

    Response.Write("<font color=red>" & a & "</font>：" & b)
    Response.End()
End Function

Function Rw(a)
    Response.Write(a)
End Function

Function GetFText(a)
    GetFText = GetFileText(a)
End Function
Function GetFileText(ByVal a)
    On Error Resume Next
    Dim b, c, d

    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FileExists(a) = True Then
            Set c = b.OpenTextFile(a, 1)

                Set d = b.GetFile(a)
                    If d.Size = 0 Then Exit Function
                Set d = Nothing
                GetFileText = c.ReadAll
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then doError Err.Description, "GetFileText 读取文件内容 函数出错，FileName=" & a
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
Function GetContentRunStr(ByVal a)
    GetContentRunStr = HandleContentCode(a, "")
End Function
Function HandleContentCode(ByVal a, b)
    Dim c, d, e, f, g, h, i
    Dim j
    Dim k

    Dim l
    l = LCase(a)
	
	
	
    If b = "check" Or b = "检测" Then
        HandleContentCode = False
    End If
    i = "|printpre|authorinfo|foldingmenu|returnren|returnhr|returnrenhr|showerr|printforminfo|dedecmsmsg|getdidsidtidsql|checkbigclass|checksmallclass|checkthreeclass|checkproduct|autoaddmaininfo|handleautoaddmaininfo|"
    i = i & "|autoaddbigclass|autoaddsmallclass|autoaddthreeclass|autoaddarticle|autoaddarticleaction|gethttppage|geturlcontent|gethttpurl|bytestobstr|strcut|getstrcut|cutstr|cutstrnolu|setcuttdstr|specialhtmluploadencryptiondecrypt|"
    i = i & "|encaspcontent|uppercaseorlowercase|enccode|deccode|tounicode|japan|japan26|unjapan26|send_email|serversend_email|findaspcode|findaspfunlist|findaspfunctioncode|handleReplaceList|getfunnamedim|getkeyword|gethandlekeyword|"
    i = i & "|getchinastr|checkstr|regexp_checkstr|existsstr|regexp_replace|replacecolor|delhtml|regexp_delhtml|getaurltitlelist|phprand|phprnd|deleterepeatstr|replacen|fillzero|caseinsensitivereplace|saveremotefile|"
    i = i & "|downfile|xmlgetstatus|xmlpost|utfxmlpost|handlexmlpost|format_time|getthisurlnoparam|getgotourl|getgotourlnoparam|getgotourlnofilename|getip2|getip|getfiletext|getftext|getfiletype|checkfile|existsfile|"
    i = i & "|createfile|checkurl|is_url|checkerr|strtotruefalse|strtruefalsetoint|checkvbcrlf|checkbr|isparity|checkeval|htmlcode|showhtml|unhtmlcode|echohtml|errortext|testhtml|checkcode|seniorcheckcode|readfile|testgetpy|"
    i = i & "|pinyin|deleterepeatarray|getarraycount|randomshow|arrayrandomshow|csscompression|deletecssnote|uncsscompression|trimvbcrlf|phptrim|ltrimvbcrlf|rtrimvbcrlf|utf2gb|checkutftogb2312|convchinese|getwebtemplate|"
    i = i & "|getwebskins|detailpageaddhtmlprefix|gethandlefoldername|getmaininfourl|htmlformatting|getcontentrunstr|checkcontentrunstr|handledoublequotation|strdq|handlecontentcode|getaspcode|handlegetaspcode|getrandcolor|"

i = i & "|now|date|len|left|right|mid|lcase|ucase|"

    g = Split(i, "|")
    For Each j In g
        If j <> "" Then
            c = LCase(j & "(") : d = ")"
            k = InStr(" " & l, " " & c)
            If k > 0 And InStr(l, d) > 0 Then
                If b = "check" Or b = "检测" Then
                    HandleContentCode = True
                    Exit Function
                End If
                Exit For
            End If
        End If
    Next
    If j = "" Then
        If b <> "check" And b <> "检测" Then
            HandleContentCode = a
        End If
        Exit Function
    End If

    j = LCase(j)

    c = j & "(" : d = ")"
    k = InStr(l, c)

    f = Mid(a, InStr(l, c))
    f = Mid(f, 1, InStrRev(f, d))

    e = Mid(a, InStr(l, c) + Len(c))

    e = Mid(e, 1, InStrRev(e, d) - 1)

    If CheckContentRunStr(a) = True Then
        e = GetContentRunStr(e)
    End If

    e = HandleDoubleQuotation(e)

    h = Split(e & ",1", ",")



    If j = "printpre" Then
        e = PrintPre(strDQ(e))

	
	
    ElseIf j = "now" Then
        e = Now()

    ElseIf j = "date" Then
        e = Date

    ElseIf j = "len" Then
        e = Len(e)

    ElseIf j = "lcase" Then
        e = LCase(e)

    ElseIf j = "ucase" Then
        e = UCase(e)

    ElseIf j = "left" Then
        h = Split(e & ",1", ",")
        e = Left(Trim(h(0)), Trim(h(1)))

    ElseIf j = "right" Then
        e = Right(Trim(h(0)), Trim(h(1)))

    ElseIf j = "mid" Then
        h = Split(e & ",99999", ",")
        If UBound(h) >= 2 Then
            e = Mid(Trim(h(0)), Trim(h(1)), Trim(h(2)))
        Else
            e = Mid(Trim(h(0)), Trim(h(1)))
        End If
    End If
    a = Replace(a, f, e)
    HandleContentCode = a
End Function


Function CheckContentRunStr(ByVal a)
    CheckContentRunStr = HandleContentCode(a, "check")
End Function

Function HandleDoubleQuotation(Byval a)
    Dim b
    b = PHPTrim(a)
    If Left(b, 1) = """" And Right(b, 1) = """" Then
        a = Mid(b, 2, Len(b) - 2)
    End If
    HandleDoubleQuotation = a
End Function

Function PrintPre(a)
    a = Replace(a, "<", "&lt;")
    PrintPre = "<pre>" & a & "</pre>"
End Function

Function strDQ(ByVal a)
    strDQ = HandleDoubleQuotation(a)
End Function
Function PHPTrim(a)
    PHPTrim = TrimVbCrlf(a)
End Function


%>

