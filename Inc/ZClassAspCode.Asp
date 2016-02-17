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




Sub AnQuanWeb(a)
    Dim b, c
    If a <> "" Then
    ElseIf Request("Folder") <> "" Then
        a = Request("Folder")
    ElseIf Request("FolderPath") <> "" Then
        a = Request("FolderPath")
    End If
    Call Echo("文件夹路径", a)
    b = a & "\Inc\"
    Call Echo("操作文件夹", b)
    Call DelSelFile(b, "Install.Asp")
    Call HandleAnQuan(b)
    c = a & "\Admin\"
    Call Echo("操作文件夹", c)
    Call DelSelFile(c, "test.html|复件 MemberManage.Asp")
    Call HandleAnQuan(c)
    Response.End()
End Sub

Function HandleAnQuan(a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n
    n = vbCrlf & "'******** 压缩处理 ********" & vbCrlf
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If Not b.FolderExists(a) Then Exit Function
        Set c = b.GetFolder(a)
            For Each e In c.Files
                g = LCase(Right(e.Name, Len(e.Name) - InStrRev(e.Name, ".")))
                If g = "asp" Then
                    i = GetFText(e)
                    If InStr(i, "<" & "%") > 0 Then
                        j = CheckCode(e)
                        i = ReadFile(e, j)
                        If InStr(i, n) > 0 Then
                            Call Echo(e, "已经压缩[" & j & "]")
                        ElseIf i <> "" Then

                            i = GetAnquanContent(e, j)
                            k = InStr(i, "<" & "%" & vbCrlf)
                            If k > 0 Then
                                l = Mid(i, 1, k + 2)
                                m = Mid(i, k + 2)
                                i = l & n & m
                            Else
                                i = i & vbCrlf & "<" & "%" & n & "%" & ">"
                            End If
                            Call WriteToFile(e, i, j)
                            Call Echo(e, "修改成功[" & j & "]")
                        End If
                        Doevents
                    End If
                End If
            Next
            Call Echo(a, "共有文件数【" & c.Files.Count & "】<hr>")
            Set d = c.SubFolders
                For Each f In d

                Next
            Set d = Nothing
        Set c = Nothing
    Set b = Nothing
    If Err Then doError Err.Description, "GetFileFolderList 获得全部文件（夹）列表 函数出错，FolderName=" & FolderName
End Function

Function GetAnquanContent(a, b)

    Dim c, d, e, f, g, h, i, j, k, l, m
    Set c = New ASPCode
        m = 19999
        c.SetCountRow = m
        c.SetAnQuanType = "|行不退格|NO处理成一行|NO函数变量简洁处理|函数全部小写|"
        Action = "|note=false|color=false|clickdim=false|html=false|code=true|anquan=true|"
        c.SetAspSetType = Action
        e = c.HandleAspCode(ReadFile(a, b))
        e = Replace(Replace(Replace(e, "&lt;", "<"), "&#x5B;", "["), "&amp;", "&")
        GetAnquanContent = e
End Function

Function ShowAspCodeColor(a)
    Dim b, c, d, e, f, g, h, i, j, k
    Set b = New ASPCode
        k = 19999
        b.SetCountRow = k
        Action = "|note=false|color=true|clickdim=false|html=false|code=true|anquan=true|"
        b.SetAspSetType = Action
        a = b.HandleAspCode(a)
        a = "<pre>" & a & "</pre>"
        ShowAspCodeColor = a
End Function

Function ASPShowCode(a)
    Dim b, c, d, e, f, g, h, i, j, k
    Set b = New ASPCode
        k = 19999
        b.SetCountRow = k
        Action = "|note=true|color=true|clickdim=false|html=false|code=true|anquan=true|"
        b.SetAspSetType = Action
        a = b.HandleAspCode(a)
        a = "<pre>" & a & "</pre>"
        ASPShowCode = a
End Function


Function OptimizationAspCode(a)
    Dim b, c, d
    Set b = New AspCode
        c = 19999
        b.SetCountRow = c
        d = "|empty=true|fuhao=false|note=true|color=false|clickdim=true|html=false|code=true|anquan=false|"
        b.SetAspSetType = d
 		
        a = b.HandleAspCode(a)
		
		a=Replace(a,"&lt;","<")
        OptimizationAspCode = a
End Function


Private Char_Set, FileName, Action, Note, Color, ClickDim, Html, Code

Class ASPCode

    Private AspD, AspHelpTitle, AspHelpContent, CountRow, RowMsg
    Private ArrayColor(199), BlueStr, RedStr, MyDimList, WriteList
    Private FunValue, FunName, FunDim, FunDimStr, FunDimNumb, OKFunDim, NOFunDim, NoDimNumb
    Private RootFunDim, RootFunDimStr, RootFunDimNumb, OKRootFunDim, NORootFunDim, AspSetType, CaseNumb
    Private RSpaceStr, RSpaceNumb, ARF
    Private ArrStr(20), ArrNumb, Css, nRow, NoteC, TempNote, nLen, nLen1, nLen2, nLen3
    Private EvalList, BadDimList, ReplaceDimList, AnQuanDim, AnQuanType, BR

    Function HandleAspCode(ByVal a)

        Dim b, c, d, e, f, g, h, i, j, k, l
        Dim m, n, o, p, q, r, s, t, u, v
        Dim w, x, y, z, aa, ba, ca
        Dim da, ea, fa, ga, ha, ia, ja, ka, la, ma, na, oa, pa
        Dim qa, ra, sa, ta, ua
        Dim va, wa, xa, ya


        a = Replace(a, vbTab, "    ")
        da = Split(a, vbCrlf)
        qa = True
        nRow = 0 : CaseNumb = 0
        RSpaceStr = "    " : RSpaceNumb = 0
        ra = False : sa = False
        NoDimNumb = 0
        OKFunDim = "," : OKRootFunDim = ","
        If UBound(da) > CountRow Then
            RowMsg = "显示[" & CountRow & "/" & UBound(da) & "]"
        Else
            CountRow = UBound(da)
        End If
        For ca = 0 To CountRow
            b = da(ca) : c = b

            If InStr(AspSetType, "|code=false|") = False Then
                b = Trim(b)
            End If
            va = Trim(b)
            ARF = ","
            pa = 0
            wa = "" : xa = 0 : ya = 0
            aa = "" : ba = 1
            f = LCase(b)

            If qa = True And ta <> "" Then
                ta = ta & vbCrlf
            End If
            ka = "" : na = "" : la = "" : oa = ""

            For ga = 1 To Len(b)
                ja = Mid(b, ga, 1)

                If qa = True Then
                    ta = ta & ja
                End If

                u = Replace(Mid(b, 1, ga - 1), " ", "")
                v = Replace(Mid(b, ga + 1), " ", "")

                If ja = "<" Then

                    If Mid(b, ga + 1, 2) = "%@" Then
                        qa = True
                        sa = True
                        ka = ka & "&lt;%@"
                        ta = ta & "&lt;%@"
                        ga = ga + 3
                        ja = Mid(b, ga, 1)

                    ElseIf Mid(b, ga + 1, 1) = "%" Then
                        d = Left(Replace(Mid(b, ga), " ", ""), 4)
                        If d = "<" & "%%" & ">" Then
                            ga = ga + InStr(Mid(b, ga), "%" & ">") + 1
                        Else
                            qa = True
                            ka = ka & "&lt;%"
                            ta = ta & "&lt;%"
                            ga = ga + 2
                        End If
                        ja = Mid(b, ga, 1)

                    ElseIf LCase(Mid(b, ga, 4)) = "<!--" And InStr(LCase(Mid(b, ga)), "#include ") > 0 And na = "" Then
                        ua = Mid(b, ga)
                        g = InStr(LCase(ua), "#include ") + 8


                        ua = "&lt;!--" & "#Include "
                        ka = ka & ua
                        qa = True
                        ra = True
                        ga = ga + g
                        ja = Mid(b, ga, 1)
                    ElseIf ka = "" Then
                        qa = False
                    End If
                End If

                If qa = False Then
                    If ja = "<" Then
                        ja = "&lt;"
                    ElseIf ja = "&" Then
                        ja = "&amp;"
                    End If
                    ka = ka & ja

                ElseIf ja = "%" And Mid(b, ga + 1, 1) = ">" Then
                    qa = False : ra = False : sa = False
                    ja = ja & ">"

                    If InStr(AspSetType, "|code=false|") = False Then

                        If InStr(ta, vbCrlf) > 0 Then
                            If InStr(AspSetType, "|html=false|") = False Then
                                ja = ja & "<br>"
                            End If
                            nRow = nRow + 1
                        End If

                    End If
                    ka = ka & ja
                    ga = ga + 1
                    ja = Mid(b, ga, 1)
                    ta = ""

                ElseIf ja = ">" And ra = True Then
                    qa = False : ra = False
                    d = LCase(Trim(Mid(b & " ", ga + 1)))
                    If d <> "" Then
                        If Left(d, 5) = "<!--#" Then
                            ja = ja & vbCrlf
                        Else
                            ja = ja & "<br>"
                        End If
                        nRow = nRow + 1
                    End If
                    ka = ka & ja

                ElseIf(ja = """" Or na <> "") And qa = True Then

                    If ja = """" Then pa = pa + 1

                    If pa Mod 2 = 0 Then
                        If Mid(b, ga + 1, 1) <> """" Then
                            na = na & ja
                            x = 1
                            d = Right(Replace(Mid(b, 1, ga - Len(na)), " ", ""), 1)
                            na = Replace(na, "&", "&amp;")
                            na = Replace(na, "<", "&lt;")
                            na = Replace(na, "[", "&#x5B;")

                            If InStr(Mid(b, 1, ga), "CreateObject") > 0 Then
                                na = HandleWrite(na)
                            End If

                            If InStr(AspSetType, "|color=false|") = False Then
                                na = "<font color=#008000>" & na & "</font>"
                            End If
                            If d = "(" Then
                                x = 0
                            End If
                            ka = LeftSpace(ka, x)
                            If ra = True Then
                                na = Replace(na, ".asp", ".Asp")
                            End If
                            ka = ka & na
                            pa = 0 : na = ""
                        Else
                            na = na & ja
                        End If
                    Else
                        na = na & ja
                    End If

                    If ga = Len(b) Then

                        If InStr(AspSetType, "|color=false|") = False Then
                            na = Replace(na, "&", "&amp;")
                            na = Replace(na, "<", "&lt;")
                            ka = ka & "<span style=""background:#FFB3B0;"" title=""错误：双引号有问题"">" & na & "</span>"
                        End If
                    End If

                ElseIf ja = "'" Then
                    d = Trim(Mid(b, ga + 1))
                    va = Mid(b, 1, ga - 1)
                    ja = ja & d
                    y = Right(Trim(d), 1)
                    If y = "=" Or y = "/" Or((y = ")" Or y = "）") And InStr(d, "(201") > 0) Then
                        ja = ja & vbCrlf
                    End If
                    ja = Replace(ja, "&", "&amp;")
                    ja = Replace(ja, "<", "&lt;")
                    ja = Replace(ja, "[", "&#x5B;")

                    If InStr(AspSetType, "|color=false|") = False Then
                        w = w + 1
                        ja = "<span id=""Note_" & w & """ style=""color:#999999"">" & ja & "</span>"
                    End If

                    If InStr(AspSetType, "|code=false|") = False Then

                        If InStr(AspSetType, "|note=false|") = False Then
                            If ga <> 1 Then ka = LeftSpace(ka, 4)
                            ka = ka & ja
                        End If
                    Else
                        ka = ka & ja
                    End If
                    Exit For

                ElseIf InStr("+-*/\=&<>()^,%:", ja) > 0 And qa = True And ra = False Or(ra = True And ja = "=") Then
                    d = Right(u, 1) : i = True
                    j = "" : x = 1
                    If(ja = ">" And d = "<") Or ja = "(" Or ja = ")" Then
                        x = 0
                        If ja = "(" And ga > 1 Then
                            e = Mid(b, 1, ga - 1)
                            e = Right(Trim(e), 1)
                            If InStr("+-*\/", e) > 0 Then
                                ja = " " & ja
                            End If
                        End If
                    ElseIf(ja = "=" And d = "<") Or(ja = "=" And d = ">") Then
                        x = 0
                    ElseIf ja = "," Then
                        x = 0
                    End If
                    If ja = ":" Then
                        If d = ":" Or Replace(v, ":", "") = "" Then
                            i = False
                        Else
                            xa = xa + 1
                            y = Mid(b, ya + 1, ga - ya - 1)
                            y = Replace(y, "&", "&amp;")
                            y = Replace(y, "<", "&lt;")
                            y = Replace(y, "[", "&#x5B;")
                            y = Replace(y, "%", "&#x25;")
                            ya = ga
                            wa = wa & y & "[云端]"
                        End If
                    ElseIf ja = "-" Then
                        y = LCase(Replace(Mid(b, 1, ga), " ", ""))
                        If y = "chr(-" Then x = 0
                    End If

                    If InStr(AspSetType, "|color=false|") = False Then
                        If ja = "," Or ja = ":" Then
                            j = "#000000"
                        ElseIf ja = "(" Or ja = ")" Then
                            j = "#000099"
                        Else
                            j = "#0000FF"
                        End If
                        If ja <> "" Then ja = "<font color=" & j & ">" & ja & "</font>"
                    End If
                    If i = True Then
                        ka = LeftSpace(ka, x)
                        ka = ka & ja
                    End If

                ElseIf CheckABC(ja) = True Or ja = "_" Or oa <> "" Then
                    oa = oa & ja
                    i = True
                    d = Mid(b & " ", ga + 1, 1)
                    e = Mid(oa, 1, 1)
                    If CheckABC(d) <> True And d <> "_" Then
                        i = False
                    End If

                    If CheckNumber(d) = True And CheckABC(e) = True Then
                        i = True
                    End If
                    If i = False Then

                        If xa = 0 And(LCase(oa) = "then" Or LCase(oa) = "else" Or LCase(oa) = "end") Then
                            If ba = 1 Then
                                d = Mid(b, ba, ga - Len(oa) - ba + 1)
                                aa = Mid(b, 1, ga) & "[云端]"
                            Else
                                d = Mid(b, ba + 1, ga - Len(oa) - ba)
                                aa = aa & Trim(d) & "[云端]" & oa & "[云端]"
                            End If
                            ba = ga
                        End If
                        ua = oa

                        j = "" : x = 1
                        d = Replace(Mid(b, 1, ga - Len(oa)), " ", "")
                        e = Right(d, 1)
                        If d = "" Or e = "." Then
                            x = 0
                        ElseIf UCase(oa) = "LANGUAGE" And e = "@" Then
                            x = 0
                            j = "#990033"
                        ElseIf UCase(oa) = "CODEPAGE" And InStr(b, "@") > 0 Then
                            x = 1
                            j = "#990033"
                        ElseIf e = "(" Or Right(d, 3) = "<" & "%=" Then
                            x = 0
                        ElseIf UCase(Left(oa, 1)) = "H" And Mid(b, ga - Len(oa), 1) = "&" And oa <> "Hour" Then
                            x = 0
                        End If
                        d = oa
                        i =(LCase(oa) = "eval" Or LCase(oa) = "execute") And Mid(" " & b, ga - Len(oa) + 1, 1) = " "
                        ka = LeftSpace(ka, x)
                        oa = ASPColor(b, ga, oa, AspSetType, j)
                        If InStr(AspSetType, "|html=false|") = False Then
                            If i = True Then
                                oa = "<font style=""background:#FFB3B0;"" title=""注意：" & d & "后门程序"">" & oa & "</font>"
                                Call HandleEvalList(c, "<font color=red>" & d & "()函数可以执行任意ASP代码</font>", ca)
                            ElseIf LCase(oa) = "createtextfile" Then
                                Call HandleEvalList(c, "使用了FSO的CreateTextFile写文件", ca)
                            ElseIf LCase(oa) = "savetofile" And Mid(" " & b, ga - Len(d) + 1, 1) = "." Then
                                Call HandleEvalList(c, "使用了Stream的SaveToFile函数写文件", ca)
                            ElseIf LCase(oa) = "save" And Mid(" " & b, ga - Len(d) + 1, 1) = "." Then
                                Call HandleEvalList(c, "使用了XMLHTTP的Save函数写文件", ca)
                            End If
                        End If

                        If LCase(ua) = "rem" Then
                            ja = Mid(b, ga + 1) : ga = ga + Len(ja)


                            w = w + 1

                            If InStr(AspSetType, "|note=false|") = False Then
                                ja = "<span id=""Note_" & w & """ style=""color:#999999"">" & ja & "</span>"
                                ka = ka & oa & ja
                            Else
                                oa = ""
                            End If
                        Else
                            ka = ka & oa : oa = ""
                        End If
                    End If

                ElseIf CheckNumber(ja) = True Or la <> "" Then
                    la = la & ja
                    d = Right(Replace(Mid(b, 1, ga - Len(la)), " ", ""), 2)
                    e = Mid(b & " ", ga + 1, 1)
                    j = "" : x = 1
                    If CheckNumber(e) = False And e <> "." Then

                        If InStr(AspSetType, "|color=false|") = False Then
                            la = "<font color=#FF0000>" & la & "</font>"
                        End If
                        If Right(d, 1) = "(" Then
                            x = 0
                        ElseIf Right(d, 2) = "(-" Then
                            x = 0
                        ElseIf d = "=-" Then
                            x = 0
                        End If
                        ka = LeftSpace(ka, x)
                        ka = ka & la
                        la = ""
                    End If

                Else
                    If ja = "<" Then ja = "&lt;"
                    ka = ka & ja
                End If
            Next

            If ka <> "" Then
                i = True

                If xa > 1 And 1 = 2 Then
                    ea = Split(wa, "[云端]")
                    z = ""
                    For ha = 0 To UBound(ea)
                        If ha = 1 Or ha = 3 Then
                            z = z & CopyStrNumb(RSpaceStr, RSpaceNumb + 1) & ea(ha) & vbCrlf
                        Else
                            z = z & CopyStrNumb(RSpaceStr, RSpaceNumb) & ea(ha) & vbCrlf
                        End If
                    Next
                    ka = z

                ElseIf InStr(ARF, ",end,function,") > 0 Or InStr(ARF, ",end,sub,") > 0 Then
                    d = "Function" : e = "End Function"
                    If InStr(ARF, ",end,sub,") > 0 Then
                        d = "Sub" : e = "End Sub"
                    End If
                    Call RowLocation(ka, d, e, i, True)
                    nRow = nRow + 1

                    If InStr(AspSetType, "|html=false|") = False Then
                        ka = ka & "</div>"
                    End If
                    If NOFunDim <> "," Then
                        ea = Split(NOFunDim, ",")
                        For Each d In ea
                            If d <> "" Then
                                Css = Css & "." & FunName & d & "{background:#333333;color:#666666}"
                                NoDimNumb = NoDimNumb + 1
                            End If
                        Next
                    End If
                    FunName = ""


                ElseIf(InStr(ARF, ",function,") > 0 Or InStr(ARF, ",sub,") > 0) And InStr(ARF, ",exit,") = False Then
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka

                    For ha = RSpaceNumb To 20
                        ArrStr(ha) = ""
                    Next
                    d = "Function"
                    If InStr(ARF, ",sub,") > 0 Then d = "Sub"
                    ArrStr(RSpaceNumb) = d
                    RSpaceNumb = RSpaceNumb + 1
                    i = False

                    If InStr(AspSetType, "|html=false|") = False Then
                        d = "style='cursor:hand' title='点击收缩'"
                        ka = Replace(ka, "Function</", "<font " & d & " onclick=""OnOffDiv(this,'ID" & FunName & "')"">Function</font></")
                        ka = Replace(ka, "Sub</", "<font " & d & " onclick=""OnOffDiv(this,'ID" & FunName & "')"">Sub</font></")
                        ka = "<div id=""ID" & FunName & """>" & ka
                    End If


                ElseIf InStr(ARF, ",end,class,") > 0 Then
                    Call RowLocation(ka, "Class", "End Class", i, True)

                ElseIf InStr(ARF, ",class,") > 0 Then
                    ArrStr(RSpaceNumb) = "Class"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",get,") > 0 Or InStr(ARF, ",let,") > 0 Then
                    ArrStr(RSpaceNumb) = "GetLet"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",end,") > 0 And InStr(LCase(va), "end property") > 0 Then
                    Call RowLocation(ka, "GetLet", "End Property", i, True)

                ElseIf InStr(ARF, ",if,") > 0 And InStr(ARF, ",then,") > 0 And(InStr(ARF, ",end,if,") > 0 Or InStr(ARF, ",else,") > 0) Then
                    If xa = 0 Then

                        y = Replace(aa, "[云端] [云端]", " ")
                        ea = Split(y, "[云端]")
                        z = ""
                        For ha = 0 To UBound(ea) - 1
                            If ha = 1 Or ha = 3 Then
                                z = z & CopyStrNumb(RSpaceStr, RSpaceNumb + 1) & ea(ha) & vbCrlf
                            Else
                                z = z & CopyStrNumb(RSpaceStr, RSpaceNumb) & ea(ha) & vbCrlf
                            End If
                        Next
                        z = Left(z, Len(z) - 2) & " If"


                    End If

                ElseIf(InStr(ARF, ",else,") > 0 Or InStr(ARF, ",elseif,") > 0) And InStr(ARF, ",case,else,") = False Then
                    Call RowLocation(ka, "IF", "ElseIf", i, "else")

                ElseIf InStr(ARF, ",if,") > 0 And InStr(ARF, ",then,") > 0 And Right(LCase(Replace(Replace(Trim(va), "%" & ">", ""), " ", "")), 4) = "then" Then
                    ArrStr(RSpaceNumb) = "IF"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",end,if,") > 0 Then
                    Call RowLocation(ka, "IF", "End IF", i, True)

                ElseIf InStr(ARF, ",for,") > 0 And InStr(ARF, ",exit,for,") = False Then
                    ArrStr(RSpaceNumb) = "For"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",next,") > 0 And InStr(ARF, ",on,resume,next,") = False And InStr(ARF, ",for,next,") = False Then
                    Call RowLocation(ka, "For", "Next", i, True)

                ElseIf InStr(ARF, ",do,while,") > 0 Or InStr(ARF, ",do,until,") > 0 Or ARF = ",do," Then
                    ArrStr(RSpaceNumb) = "Do"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",loop,") > 0 Then
                    Call RowLocation(ka, "Do", "Loop", i, True)

                ElseIf InStr(ARF, ",while,") > 0 Then
                    ArrStr(RSpaceNumb) = "While"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",wend,") > 0 Then
                    Call RowLocation(ka, "While", "Wend", i, True)

                ElseIf InStr(ARF, ",set,nothing,") > 0 Then
                    Call RowLocation(ka, "Set", "Set Nothing", i, True)

                ElseIf InStr(ARF, "set,") > 0 Then
                    ArrStr(RSpaceNumb) = "Set"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",end,with,") > 0 Then
                    Call RowLocation(ka, "With", "End Width", i, True)

                ElseIf InStr(ARF, "with,") > 0 Then
                    ArrStr(RSpaceNumb) = "With"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 1 : i = False

                ElseIf InStr(ARF, ",select,case,") > 0 Then
                    ArrStr(RSpaceNumb) = "Case"
                    ka = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    RSpaceNumb = RSpaceNumb + 2 : CaseNumb = 1 : i = False

                ElseIf InStr(ARF, ",case,") > 0 Then
                    Call RowLocation(ka, "Case", "Case", i, "else")

                ElseIf InStr(ARF, ",end,select,") > 0 Then
                    CaseNumb = 0
                    Call RowLocation(ka, "Case", "End Select", i, True)

                ElseIf ka = "%" & ">" Then
                    RSpaceNumb = 0
                End If

                If i = True Then
                    TempNote = NoteC : NoteC = ""
                    If Left(b, 1) = "'" And RSpaceNumb > 0 Then
                        NoteC = ka : ka = ""
                    End If
                    If TempNote <> "" Then
                        y = ka
                        y = GetNoteC(TempNote, "")
                        If ka = "" Then
                            y = Left(y, Len(y) - 2)
                        End If
                        ka = y & CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    Else
                        If ka <> "" Then ka = CopyStrNumb(RSpaceStr, RSpaceNumb) & ka
                    End If
                    If Trim(ka) = "&lt;%" Then ka = Trim(ka)
                    If ka <> "" And InStr(AspSetType, "|html=false|") = False Then ka = ka & "<span id=""Id" & nRow & """ onClick=""TestInput('Id" & nRow & "');"" style=""color:red;"" title=点击写笔记>&nbsp;</span>"
                End If
            End If
            If InStr(AnQuanType, "|行不退格|") > 0 Then
                ka = Trim(ka)
            End If
            BR = vbCrlf
            If InStr(AnQuanType, "|处理成一行|") > 0 Then
                BR = ": "
            End If

            If InStr(AspSetType, "|code=false|") = False Then
                If ka <> "" Then
                    If qa = False And Right(Trim(c), 2) <> "%" & ">" Then
                        d = Ltrim(c)
                        e = Left(c, Len(c) - Len(d))
                        ka = e & Trim(ka)
                    ElseIf qa = False And Right(Trim(c), 2) = "%" & ">" Then
                        ka = Trim(ka)
                    End If
                    fa = fa & ka & BR : nRow = nRow + 1
                End If
            Else
                fa = fa & ka & BR : nRow = nRow + 1
            End If
        Next

        If NORootFunDim <> "," Then
            ea = Split(NORootFunDim, ",")
            For Each d In ea
                If d <> "" Then
                    Css = Css & ".call" & d & "{background:#333333;color:#666666}"
                    NoDimNumb = NoDimNumb + 1
                End If
            Next
        End If

        If BadDimList <> "" Then
            Call CreateAddFile("自定变量里没有的变量列表.ini", BadDimList)
        End If
        HandleAspCode = fa
    End Function

    Function GetNoteC(a, b)
        Dim c, d, e
        If a = "" Then Exit Function
        e = RSpaceNumb
        For c = 20 To 0 Step - 1
            If ArrStr(c) <> "" Then
                e = c
                Exit For
            End If
        Next
        d = RSpaceNumb
        If b = "else" Then d = d - 1
        GetNoteC = CopyStrNumb(RSpaceStr, d) & a & vbCrlf
        a = ""
    End Function

    Function ASPColor(ByVal a, ByVal b, c, d, e)
        Dim f, g, h, i, j, k, l, m, n, o, p, q, r
        Dim s, t, u, v, w, x, y, z
        w = c
        c = ""
        p = LCase(w)
        x = ""

        t = InStr(LCase(BlueStr), "," & p & ",")

        u = InStr(LCase(RedStr), "," & p & ",")

        If p = "vbcrlf" Then
            ASPColor = "vbCrlf"

            If InStr(d, "|color=false|") = False Then
                ASPColor = "<font color=#009999>vbCrlf</font>"
            End If
            Exit Function

        ElseIf t > 0 Then
            If p = "dim" Then
                f = Replace(Mid(a, b + 1), " ", "") & ","
                If InStr(f, "'") > 0 Then
                    f = Left(f, InStr(f, "'") - 1) & ","
                End If
                If InStr(f, ":") > 0 Then
                    f = Left(f, InStr(f, ":") - 1) & ","
                End If
                If FunName <> "" Then f = ReplaceDim(f) & ","
                f = MyFunDim(f) & ","

                If FunName = "" Then
                    If RootFunDimStr = "" Then f = "," & f
                    RootFunDimStr = RootFunDimStr & f
                    RootFunDim = RootFunDim & f
                    NORootFunDim = NORootFunDim & f

                Else
                    If FunDimStr = "" Then f = "," & f
                    FunDimStr = FunDimStr & f
                    FunDim = FunDim & f
                    NOFunDim = NOFunDim & f
                    AnQuanDim = AnQuanDim & f & ","
                End If
            ElseIf p = "set" Then
                f = Replace(Mid(a, b + 1), " ", "") & ","

                If InStr(f, "=") Then
                    f = Left(f, InStr(f, "=") - 1)

                    f = MyFunDim(f) & ","
                End If

                If FunName = "" Or InStr(FunDim, "," & f) = False Then
                    If RootFunDimStr = "" Then f = "," & f
                    RootFunDimStr = RootFunDimStr & f
                    RootFunDim = RootFunDim & f
                    NORootFunDim = Replace(NORootFunDim, "," & MyFunDim(f) & ",", ",")

                Else
                    If FunDimStr = "" Then f = "," & f
                    FunDimStr = FunDimStr & f

                    NOFunDim = Replace(NOFunDim, "," & MyFunDim(f) & ",", ",")
                End If
            ElseIf p = "const" Then
                f = Replace(Mid(a, b + 1), " ", "") & ","
                If InStr(f, "=") > 0 Then
                    f = Left(f, InStr(f, "=") - 1)
                    f = Replace(f, " ", "")

                    f = MyFunDim(f) & ","

                    If FunName = "" Then
                        If RootFunDimStr = "" Then f = "," & f
                        RootFunDimStr = RootFunDimStr & f
                        RootFunDim = RootFunDim & f
                        NORootFunDim = NORootFunDim & f

                    Else
                        If FunDimStr = "" Then f = "," & f
                        FunDimStr = FunDimStr & f
                        FunDim = FunDim & f
                        RootFunDim = RootFunDim & f
                    End If
                End If
            ElseIf p = "call" Then
                f = Replace(Mid(a, b + 1), " ", "") & ","
                If InStr(f, "(") > 0 Then
                    f = Left(f, InStr(f, "(") - 1)
                    f = Replace(f, " ", "")

                    f = MyFunDim(f) & ","

                    If RootFunDimStr = "" Then f = "," & f
                    RootFunDimStr = RootFunDimStr & f
                    RootFunDim = RootFunDim & f
                End If

            ElseIf(p = "sub" Or p = "function") And FunName = "" Then
                If GetFunNameDim(a, FunName, FunDim) <> "" Then
                    FunName = Replace(Trim(FunName), vbCrlf, "")
                    If InStr(FunName, " ") Then
                        FunName = Mid(FunName, InStrRev(FunName, " ") + 1)
                    End If
                    FunDim = Replace(FunDim, vbCrlf, "")
                    AnQuanDim = FunDim & ","
                    FunDim = "," & ReplaceDim(FunName & "," & FunDim) & ","
                    FunDim = "," & MyFunDim(FunDim) & ","
                    NOFunDim = ","
                    FunDimStr = FunDim
                    FunDimNumb = 0
                End If
            End If
            ARF = ARF & p & ","

            If InStr(d, "|code=false|") = False Then
                ASPColor = Mid(BlueStr, t + 1, Len(p))
                w = ASPColor
            Else
                ASPColor = w
            End If

            If InStr(d, "|color=false|") = False Then
                If e = "" Then e = "#0000FF"
                ASPColor = "<font color=" & e & ">" & ASPColor & "</font>"
            End If
            x = "错误 ASP内置函数不能用 "

        ElseIf u > 0 Then
            v = ASPHelpTip(w, Mid(a, b + 1))
            If v <> "" Then v = "title=""" & v & """"

            If InStr(d, "|code=false|") = False Then
                ASPColor = Mid(RedStr, u + 1, Len(p))
                w = ASPColor
            Else
                ASPColor = w
            End If

            If InStr(d, "|color=false|") = False Then
                If e = "" Then e = "#990099"

                ASPColor = "<font color=" & e & " " & v & ">" & ASPColor & "</font>"
            End If
            x = "注意 ASP内置函数 "
        End If


        If InStr(d, "|clickdim=false|") = False Then

            If FunDim <> "" Then
                i = Split(FunDim, ",")
                For h = 0 To UBound(i)
                    r = i(h)
                    If p = LCase(r) Then
                        FunDimNumb = FunDimNumb + 1
                        q = ""

                        If InStr(FunDimStr, "," & r & ",") > 0 Then

                            q = " title='" & x & "点击让变量突出显示" & h & "-" & FunDimNumb & "_有[]处' onclick=""AddColor('" & FunName & r & "_', '" & LCase(ArrayColor(h)) & "');"""
                            FunDimStr = Replace(FunDimStr, "," & r & ",", ",")
                            If InStr(OKFunDim, "," & r & ",") = False Then
                                OKFunDim = OKFunDim & r & ","
                            Else
                                NOFunDim = Replace(NOFunDim, "," & r & ",", ",")
                            End If
                        Else
                            NOFunDim = Replace(NOFunDim, "," & r & ",", ",")
                        End If
                        If x <> "" Then
                            y = ASPColor
                        Else
                            y = MyFunDim(r)
                        End If
                        v = ASPHelpTip(y, "")
                        If v <> "" Then v = "title=""" & v & """"
                        If InStr(AnQuanType, "|函数变量简洁处理|") > 0 Then

                            If InStr("," & AnQuanDim, "," & y & ",") > 0 Then
                                z = Split(AnQuanDim, ",")
                                For b = 0 To UBound(z)
                                    If z(b) = y Then
                                        If b + 1 > 26 Then
                                            y = Mid("ABCDEFGHIJKLMNOPQRSTUVWXYZ",(b + 1) / 26, 1)
                                            y = y & Mid("ABCDEFGHIJKLMNOPQRSTUVWXYZ",(b + 1) Mod 26, 1)
                                        Else
                                            y = Mid("ABCDEFGHIJKLMNOPQRSTUVWXYZ", b + 1, 1)
                                        End If
                                        Exit For
                                    End If
                                Next
                            End If
                        End If

                        ASPColor = "<span name='" & r & "' id='" & FunName & r & "_" & FunDimNumb & "' " & v & " class='" & FunName & r & "' " & q & ">" & y & "</span>"
                        Exit Function
                    End If
                Next
            End If

            If RootFunDim <> "" And InStr(d, "|clickdim=false|") = False Then
                i = Split(RootFunDim, ",")
                For h = 0 To UBound(i)
                    r = i(h)
                    If p = LCase(r) Then
                        RootFunDimNumb = RootFunDimNumb + 1
                        q = ""

                        If InStr(RootFunDimStr, "," & r & ",") > 0 Then

                            q = " title='" & x & "点击让变量突出显示" & h & "-" & RootFunDimNumb & "_有[]处' onclick=""AddColor('" & r & "_', '" & LCase(ArrayColor(h)) & "');"""
                            RootFunDimStr = Replace(RootFunDimStr, "," & r & ",", ",")
                            If InStr(OKRootFunDim, "," & r & ",") = False Then
                                OKRootFunDim = OKRootFunDim & r & ","
                            Else

                                NORootFunDim = Replace("," & NORootFunDim, "," & r & ",", ",")
                            End If
                        Else
                            NORootFunDim = Replace("," & NORootFunDim, "," & r & ",", ",")
                        End If
                        If x <> "" Then
                            y = ASPColor
                        Else
                            y = MyFunDim(r)
                        End If
                        v = ASPHelpTip(y, "")
                        If v <> "" Then v = "title=""" & v & """"

                        ASPColor = "<span name='call" & r & "' id='" & r & "_" & RootFunDimNumb & "' " & v & " class='call" & r & "' " & q & ">" & y & "</span>"
                        Exit Function
                    End If
                Next
            End If
        End If

        If ASPColor = "" Then
            ASPColor = w

            If InStr(d, "|code=false|") = False Then
                ASPColor = MyFunDim(ASPColor)
            End If
            ASPColor = ASPColor
        End If
        If InStr(AnQuanType, "|函数全部小写|") > 0 Then
            ASPColor = LCase(ASPColor)
        End If
    End Function

    Sub RowLocation(a, ByVal b, c, d, e)
        Dim f, g, h, i, j, k,l
        k = "|"
        ArrNumb = -1
        For f = 20 To 0 Step - 1
            If ArrStr(f) = b Then
                ArrNumb = f
                Exit For
            ElseIf ArrStr(f) <> "" Then
                k = k & ArrStr(f) & "|"
            End If
        Next
        g = RSpaceNumb - 1 - CaseNumb
        If g < 0 Then g = -9
        If ArrNumb = g Then
            If e = "else" Then
                a = GetNoteC(NoteC, "else") & CopyStrNumb(RSpaceStr, RSpaceNumb - 1) & a
                d = False
            Else
                If e = True Then ArrStr(ArrNumb) = ""
                RSpaceNumb = RSpaceNumb - 1
            End If
        Else
            h = False
            If ArrNumb >= 0 Then

                If(InStr(k, "|IF|") > 0 Or InStr(k, "|Function|") > 0) And ArrStr(ArrNumb) = "Set" Then
                    h = "不操作"
                Else
                    RSpaceNumb = ArrNumb
                    h = GetNoteC(NoteC, "") & CopyStrNumb(RSpaceStr, ArrNumb)
                    RSpaceNumb = ArrNumb
                    If e = True Then ArrStr(ArrNumb) = ""
                    d = False
                    If e = "else" Then
                        RSpaceNumb = RSpaceNumb + 1
                    End If
                End If
            End If
            If h <> "不操作" Then
                i = ""
                If ArrNumb >= 0 Then
                    For f = 10 To ArrNumb + 1 Step - 1
                        If ArrStr(f) <> "" Then
                            i = i & ArrStr(f) & "|"
                        End If
                    Next
                Else
                    h = False
                    k = ""
                End If
                If h <> False Then
                    l = "#CCCCCC" : j = "注意：" & c & "前面有【" & i & "】未关闭"
                Else
                    l = "#FFB3B0" : j = "错误：" & c & "，未定义" & b
                    h = ""
                End If
                If k <> "|" And InStr(AspSetType, "|html=false|") = False Then
                    a = h & "<font style=""border:1px #000000 dotted;background:" & l & ";"" title=""" & j & """>" & a & "</font>"
                Else
                    a = h & a
                End If
            End If
        End If
    End Sub

    Private Sub Class_Initialize()
        Dim b, c, d
        Set AspD = CreateObject("Scripting.Dictionary")
            AspD.Add "Abs", "返回数字的绝对值"
            AspD.Add "Sqr", "返回数值表达式的平方根"
            AspD.Add "Sgn", "返回表示数字符号的整数"
            AspD.Add "Rnd", "返回一个随机生成的数字"
            AspD.Add "Log", "返回指定数值的自然对数"
            AspD.Add "Exp", "返回e的指定次幂"
            AspD.Add "Sin", "返回指定弧度的正弦值"
            AspD.Add "Cos", "返回指定弧度的余弦值"
            AspD.Add "Tan", "返回指定弧度的正切值"
            AspD.Add "Atn", "返回指定数值的反正切值"
            AspD.Add "Int", "返回指定数字的整数部分"
            AspD.Add "Round", "对参数按指定的位数进行四舍五入"
            AspD.Add "Fix", "返回指定数值的整数部分"
            AspD.Add "Now", "返回当前的日期时间"
            AspD.Add "Date", "返回当前的系统日期"
            AspD.Add "Time", "返回当前的系统时间"
            AspD.Add "Year", "从指定的表达式中提取年份"
            AspD.Add "Month", "从指定的表达式中提取月份"
            AspD.Add "Day", "从指定表达式中提取日期"
            AspD.Add "Hour", "从指定的表达式中提取整点值"
            AspD.Add "Minute", "从指定的表达式中提取分钟数"
            AspD.Add "Second", "从指定的表达式中提取秒数"
            AspD.Add "DateAdd", "将指定日期添加上指定时间间隔并返回新值"
            AspD.Add "DateDiff", "计算两个日期之间的时间间隔"
            AspD.Add "DatePart", "返回给定日期中的某一部分"
            AspD.Add "DateSerial", "根据提供的年月日的数值返回一个Date子类型的数据"
            AspD.Add "DateValue", "将指定的字符串转化为Date子类型的数据"
            AspD.Add "MonthName", "根据指定的数字返回代表该月份的字符串"
            AspD.Add "Weekday", "返回代表一周中某一天的整数"
            AspD.Add "WeekdayName", "根据周次返回代表该周次的字符串"
            AspD.Add "TimeSerial", "根据提供的时分秒的数值返回一个Date子类型的数据"
            AspD.Add "TimeValue", "将指定的字符串转化为Date子类型的数据"
            AspD.Add "CBool", "将表达式转化为Boolean子类型"
            AspD.Add "CByte", "将表达式转化为Byte子类型"
            AspD.Add "CDbl", "将表达式转化为Double子类型"
            AspD.Add "Chr", "将ANSI字符代码（～）转化为对应的字符"
            AspD.Add "CInt", "将表达式转化为Integer数值子类型"
            AspD.Add "CLng", "将表达式转化为Long数值子类型"
            AspD.Add "Cstr", "将表达式转化为String子类型"
            AspD.Add "CCur", "将表达式转化为Currency子类型"
            AspD.Add "CDate", "将日期表达式转化为Date子类型"
            AspD.Add "CSng", "将表达式转化为Single数值子类型"
            AspD.Add "Asc", "返回与字符串首字母相对应的ANSI字符代码（～）"
            AspD.Add "Oct", "返回八进制的字符串"
            AspD.Add "Hex", "返回十六进制的字符串"
            AspD.Add "FormatNumber", "格式化指定的数值表达式"
            AspD.Add "FormatDateTime", "格式化指定的日期时间表达式"
            AspD.Add "FormatCurrency", "格式化指定的货币表达式"
            AspD.Add "FormatPercent", "格式化某一数值为百分数"
            AspD.Add "IsArray", "判断某一变量是否为数组变量"
            AspD.Add "IsDate", "判断某一变量是否为或者可以转化为日期表达式"
            AspD.Add "IsEmpty", "判断变量是否为空"
            AspD.Add "IsNull", "判断表达式中是否包含有效数据"
            AspD.Add "IsNumeric", "判断表达式的值是否为数字"
            AspD.Add "Is_object_", "判断表达式的值是否为某一对象"
            AspD.Add "VarType", "返回指定变量的子类型"
            AspD.Add "TypeName", "返回指定变量子类型的信息"
            AspD.Add "MsgBox", "弹出含有提示信息的对话框"
            AspD.Add "InputBox", "弹出可输入数据的对话框"
            AspD.Add "ScriptEngine", "返回一个代表当前所使用的脚本语言的字符串"
            AspD.Add "ScriptEngineBuildVersion", "返回所使用的脚本引擎的编译版本号"
            AspD.Add "ScriptEngineMajorVersion", "返回所使用的脚本引擎的主版本号"
            AspD.Add "ScriptEngineMinorVersion", "返回所使用脚本引擎的次版本号"
            AspD.Add "Array", "利用所给的参数返回一个数组"
            AspD.Add "UBound", "返回数组的最大可用下标"
            AspD.Add "LBound", "返回数组的最小可用下标"
            AspD.Add "Filter", "返回一个数组其中包含了满足条件的字符串"
            AspD.Add "InStr", "返回某字符串在指定字符串中第一次出现的位置"
            AspD.Add "InStrRev", "返回某字符串在指定字符串中从结尾算起的出现位置"
            AspD.Add "Join", "将数组中的字符串连接为一个字符串"
            AspD.Add "LCase", "将字符串中的字母全部转换为小写形式"
            AspD.Add "Left", "从字符串的左端取指定数目的字符"
            AspD.Add "Len", "返回字符串的长度或者存储某一变量所需要的字节数"
            AspD.Add "Ltrim", "返回不带前导空格的字符串"
            AspD.Add "Replace", "将字符串中指定字符串替换为其他内容"
            AspD.Add "Right", "从字符串的右侧获取指定数目的字符"
            AspD.Add "Rtrim", "删除字符串的后续空格"
            AspD.Add "Mid", "从字符串中指定位置获取指定长度的字符串"
            AspD.Add "Split", "返回包含指定数目子字符串的一维数组"
            AspD.Add "StrComp", "对两个指定的字符串进行比较"
            AspD.Add "StrReverse", "将指定字符串倒序排列并返回重新排列后的字符串"
            AspD.Add "String", "返回由指定数目的某一字符组成的字符串"
            AspD.Add "Trim", "删除字符串的前导和后续空格"
            AspD.Add "Space", "返回由指定数目的空格组成的字符串"
            AspD.Add "UCase", "将字符串中的字母全部转换为大写形式"
            AspD.Add "LoadPicture", "返回一个图片对象"
            AspD.Add "Create_object_", "创建并返回一个对象"
            AspD.Add "Get_object_", "从指定文件中获得一个Automation对象"
            AspD.Add "RGB", "返回代表某一颜色的整数"

            AspD.Add "Angle", "翻译：角度,观点"
            AspHelpTitle = AspD.keys
            AspHelpContent = AspD.Items

            b = "#990000,#999900,#333366,#663300,#669966,#FF6600,#CC33CC,#993366,#FF0099,#669900,#336699,#99CCCC,#CC3366,#FF9900,#9933FF,#669900,#6699FF,#333366,#99CC66,#996600,#000033,#003300,#330000,#660000,#000099,#330099,#6600FF,#990000,#CC0000,#FF0000,#990066,#FF0066,#CC00CC,"
            c = Split(b, ",")
            For d = 1 To UBound(c)
                ArrayColor(d) = c(d)
            Next

            BlueStr = ",If,Then,ElseIf,Else,End,Function,Sub,ByVal,,Dim,Nothing,On,Resume,Call,True,False,Not,Is,Or,And,For,Next,Exit,Execute,Randomize,Do,While,Loop,Set,Mod,To,Each,In,Select,Case,Until,With,Wend,Step,Option,Explicit,Class,Private,Public,Get,Let,Const,ByRef,ReDim,Preserve,LANGUAGE,Rem,Execute,,"

            RedStr = ",Abs,Sqr,Sgn,Rnd,Log,Exp,Sin,Cos,Tan,Atn,Int,Round,Fix,Now,Date,Time,Year,Month,Day,Hour,Minute,Second,DateAdd,DateDiff,DatePart,DateSerial,DateValue,MonthName,Weekday,WeekdayName,TimeSerial,TimeValue,CBool,CByte,CDbl,Chr,CInt,CLng,Cstr,CCur,CDate,CSng,Asc,Oct,Hex,FormatNumber,FormatDateTime,FormatCurrency,FormatPercent,IsArray,IsDate,IsEmpty,IsNull,IsNumeric,Is_object_,VarType,TypeName,MsgBox,InputBox,ScriptEngine,ScriptEngineBuildVersion,ScriptEngineMajorVersion,ScriptEngineMinorVersion,Array,UBound,LBound,Filter,InStr,InStrRev,Join,LCase,Left,Len,Ltrim,Replace,Right,Rtrim,Mid,Split,StrComp,StrReverse,String,Trim,Space,UCase,LoadPicture,Create_object_,Get_object_,RGB,Request,ServerVariables,"
            RedStr = RedStr & ",Response,Write,MoveNext,Close,Eof,Bof,Server,MapPath,Server,CreateObject,Err,Error,Description,CInt,CStr,String,CDate,Size,Session,Open,AddNew,Update,HTMLEncode,File,Test,Type,Mode,CharSet,Form,InStrB,URLEncode,Field,RegExp,Number,QueryString,Name,Item,AscB,MidB,LenB,Buffer,Expires,AddHeader,Timer,BinaryWrite,Redirect,Version,Property,ChrB,Cookies,Value,Clear,ContentType,AscW,AppliCation,Lock,UnLock,Contents,CodePage,ScriptTimeOut,Cancel,ExpiresAbsolute,CacheControl,ChrW,Source,Eval,Name,Count,Match,Fields,"

            MyDimList = ",A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,nCount,Code,Id,IP,Str,Length,Txt,Title,Content,Age,Sex,CountNumb,UserName,UserPass,PassWord,UserAdmin,AdminName,AdminPass,UserPassWord,Tel,Fax,Mail,ListCode,Regex,Reg,Re,Values,StrChar,TempChar,Fso,Fs,Fc,Ts,Path,FileName,FolderName,ClsCache,CacheObj,Obj,Conn,Rs,Rss,Rsx,Sql,AddSql,SetCache,CacheName,CacheValue,GetCache,CacheData,Flag,CacheFlag,CacheTime,FilterStr,CheckFile,FilePath,Html,HtmlStr,HtmlName,ServerMap,StrBadChar,ArrBadChar,YY,Mi,StrDateTime,IsHtml,AA,Ret,S1,S2,C1,C2,PosX,PosY,sUserName,sPassWord,MyArray,Page,SiteInfo,PageUrl,MakeName,FName,MakeFolder,Folder,Class_Initialize,Class_Terminate,"
			MyDimList=MyDimList &"MakeFile,HtmlMaker,GetName,ConnStr,UserIp,UserIp2,GetBody,XmlHttp,ResponseBody,ReadyState,SetTimeOuts,SaveImage,ToFile,Action,Act,Step1,Step2,Step3,Step4,Step5,Success,Check_Install,Install,GetRnd,N1,N2,N3,N4,N5,T0,Check_Write,ObjFolder,ObjSubFolders,SubFCount,ObjTest,Ver,IntVal,Color,StrTemp,Arr,Ch,Cnf,Co,SS,Tp,Dire,V1,V2,V3,Ma,FolderPath,db,Eval,Execute,Include,Inc,Did,Sid,Tid,Folders,Files,Fl,File_F,SubFolders,MyFile,F1,F2,F3,F4,F5,RemoveIframe,RemoveScript,FileTxt,File_W,IframeStr,TempStr,TempC,Days,StrLen,StrUrl,TotalNumber,MaxperPage,CurrentPage,Email,Names,NoHtml,New,Text,FindWord,RsClass,StrNoResult,StrWord,ClassId,MM,DD,RiQi,XiaoShi,FenZhong,Miao,Info,Pass,"
			MyDimList=MyDimList &"ServerList,SetDot,Px,Py,Graph,Width,Height,SetDraw,PIndex,PNumber,DotData,Angle,SitePath,SiteCharset,RsId,Rs1,Xx,Add,Edit,Del,AddSub,Sql1,Admin,cName,MaxPage,Cn,En,NewStr,HaveChar,LastChar,DirPath,Strng,Temp,Echo,ToPic,ChkStr,Val,Str0,Str1,Str2,Str3,GetIP,ShowMsg,ShowPage,StrLength,Fso1,Fso2,StrField,KeyWord,Main,SplStr,Splxx,LCaseS,ArrID,DoMain,Url,Url1,StrPage,Host,Iswww,"
			MyDimList=MyDimList & "Pattern,Send,Pos,Dec,Res,LoopCount,TempResult,II,OpenTextFile,ReadLine,FileExists,DeleteFile,CloseDB,ComeUrl,Cook,StyleId,FText,CreateTextFile,StarTime,EndTime,DBPath,BB,File,Stm,Read,Width,Height,LoadFromFile,FoundErr,ErrMsg,Msg,FsoType,Search,QQ,Rw,Echo,Eerr,mCode,OutPut,Margin,Create,Border,OffSet,III,Ex,Pth,NewCnt,AddCode,Stream,ThePath,TheFolder,SysFileList,MMMM,AAA,WS,SI,Timer1,Tmp,Hu,StartN,EndN,GPath,PortNum,FC2,OFile,TFile,TFile2,FSubFolers,RenameFolder,Rs_1,Rs_2,Rs_3,Rsp,Rsl,Web_Name,Web_Url,Web_Image,Web_Title,Web_Keywords,Web_Description,Web_Copyright,Web_Theme,Web_Consult,Web_TopHTML,Web_BottomHTML,Web_Tel,HtmlWrite,ErrNo,,,,"

            WriteList = ",Adodb.Connection,Adodb.RecordSet,Scripting.FileSystemObject,ADODB.Stream,"

            ReplaceDimList = ",NumbCount=nCount,OKNumb=nOK,ErrNumb=nErr,StrErr=C,ErrMsg=C,StrTemp=C,fString=C,,,,,,,"
    End Sub

    Function ASPHelpTip(ByVal a, ByVal b)
        Dim c, d, e
        For c = 0 To AspD.Count - 1
            If LCase(AspHelpTitle(c)) = LCase(a) Then
                If LCase(a) = "chr" Then
                    d = Left(b, InStr(b, ")") - 1)
                    d = Replace(d, "(", "")
                    e = vbCrlf & "Chr(" & d & ")="
                    If CheckNumber(d) = True Then
                        If d = "10" Or d = "13" Then
                            e = e & "(回车键)"
                        ElseIf d = "32" Then
                            e = e & "(空格)"
                        ElseIf d = "0" Then
                            e = e & "(中断程序,停止执行)"
                        Else
                            e = e & "(" & Chr(d) & ")"
                        End If
                        e = Replace(e, "'", "&#x27;")
                    Else
                        e = e & d
                    End If
                End If
                ASPHelpTip = AspHelpContent(c) & e
                Exit For
            End If
        Next
    End Function

    Function MyFunDim(ByVal a)
        Dim b, c, d, e, f, g, h, i
        b = Split(a, ",")
        For Each c In b
            c = Trim(c)
            f = LCase(c)
            If c <> "" Then

                If InStr(c, "(") > 0 Then
                    c = Mid(c, 1, InStr(c, "(") - 1)
                End If
                i = True
                h = InStr(LCase(ReplaceDimList), "," & f & "=")
                g = InStr(LCase(MyDimList), "," & f & ",")
                If h > 0 Then
                    e = Mid(ReplaceDimList, h + 1)
                    e = Mid(e, 1, InStr(e, ",") - 1)
                    e = Mid(e, InStr(e, "=") + 1)
                    If InStr(FunDim & RootFunDim, "," & e & ",") > 0 Then
                        c = e
                        i = False
                    End If
                End If
                If i = True Then
                    If g > 0 Then
                        c = Mid(MyDimList, g + 1, Len(f))
                    ElseIf InStr("," & BadDimList, "," & c & ",") = False Then
                        BadDimList = BadDimList & c & ","
                    End If
                End If
                d = d & c & ","
            End If
        Next
        If d <> "" Then d = Left(d, Len(d) - 1)
        MyFunDim = d
    End Function


    Function HandleWrite(a)
        Dim b, c
        b = Left(a, Len(a) - 1)
        b = Right(b, Len(b) - 1)
        b = LCase(Trim(b))
        c = InStr(LCase(WriteList), "," & b & ",")
        If c > 0 Then
            a = """" & Mid(WriteList, c + 1, Len(b)) & """"
        End If
        HandleWrite = a
    End Function

    Function CopyStrNumb(ByVal a, b)

        If InStr(AspSetType, "|code=false|") > 0 Then CopyStrNumb = "" : Exit Function
        Dim c, d
        If b > 0 Then
            d = a
            For c = 1 To b - 1
                a = a & d
            Next
        Else
            a = ""
        End If
        CopyStrNumb = a
    End Function

    Function LeftSpace(ByVal a, ByVal b)

        If InStr(AspSetType, "|code=false|") > 0 Then LeftSpace = a : Exit Function
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

    Sub HandleEvalList(ByVal a, b, c)
        a = Replace(a, "<", "&lt;")
        EvalList = EvalList & "【" & a & "】" & b & "|在第[" & c + 1 & "]行<br>"
    End Sub

    Public Property Let SetAspSetType(Str)
        AspSetType = Str
    End Property

    Public Property Let SetCountRow(Str)
        CountRow = CInt(Str)
    End Property

    Public Property Let SetReplaceDimList(Str)
        ReplaceDimList = Str
    End Property

    Public Property Let SetAnQuanType(Str)
        AnQuanType = Str
    End Property

    Public Property Get GetCss
        GetCss = Css
    End Property

    Public Property Get GetnRow
        GetnRow = nRow
    End Property

    Public Property Get GetNoDimNumb
        GetNoDimNumb = NoDimNumb
    End Property

    Public Property Get GetRowMsg
        GetRowMsg = RowMsg
    End Property

    Public Property Get GetEvalList
        GetEvalList = EvalList
    End Property

    Private Sub Class_Terminate()




    End Sub

End Class
%>



