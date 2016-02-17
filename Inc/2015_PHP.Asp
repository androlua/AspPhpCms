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






Function formattingJSPHP(ByVal a)
    Dim b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x,y
    Dim z, aa, ba
    Dim ca
    Dim da
    Dim ea
    Dim fa
    Dim ga, ha, ia
    Dim ja
    ja = ""
    ga = "    " : ha = 0
    k = 0
    Dim ka

    b = Split(a, vbCrLf)

    For i = 0 To UBound(b)
        e = b(i)
        e = phptrim(e)
        e = Replace(Replace(e, Chr(10), ""), Chr(13), "")
        f = PHPTrim(e)
        fa = e
        o = "" : p = ""
        q = ""
        r = ""
        s = ""
        ia = 0
        If(i + 1) <= UBound(b) Then
            r = b(i + 1)
            s = GetBeforeNStr(r, "全部", 1)
        End If
        t = ""
        u = True

        For h = 1 To Len(e)
            c = Mid(e, h, 1) : d = c
            v = Right(Replace(Mid(e, 1, h - 1), " ", ""), 1)
            w = Left(Replace(Mid(e, h + 1), " ", ""), 1)
            x = Mid(e, h + 1)

            If(c = """" Or c = "'" And da = "") Or c = da Or ca <> "" Then
                ka = True

                If ka = True And v = "\" Then
					
                    If Len(ca) >=1 Then
                        If isStrTransferred(ca)=true Then		
							
                            ka = False
                        End If
                    Else
                        ka = False
                    End If
					
                End If
                If ca = "" Then
                    da = c
                End If


                If c = da And ka = True Then k = k + 1



                If k Mod 2 = 0 And v <> "\" Then
                    If Mid(e, h + 1, 1) <> da Then
                        ca = ca & c
                        o = o & ca
						
                        k = 0 : ca = ""
                        da = ""
                    Else
                        ca = ca & c
                    End If
                Else
                    ca = ca & c
                End If


            ElseIf(c = "/" And w = "*") Or ja <> "" Then
                q = Mid(e, h)

                If ja <> "" Then ja = ja & vbCrLf
                ja = ja & q
                If InStr(q, "*/") > 0 Then
                    o = o & ja
                    ja = ""
                End If
                Exit For

            ElseIf c = "/" And w = "/" Then
                q = Mid(e, h)
                o = o & q
                Exit For


            ElseIf InStr(".&=,+-*/:()><;", c) > 0 And t = "" Then
                If ea <> "" Then
                    n = ea
                    aa = z
                    z = LCase(n)
                    o = o & ea
                    ea = ""
                End If
				
				if c=";" and instr("{;",right(trim(o),1))>0 then
					
					c=""
				end if
                o = o & c
                aa = z
                z = c

            ElseIf checkABC(c) = True Or c = "_" Or ea <> "" Then
                ea = ea & c
                ba = True
                l = Mid(e & " ", h + 1, 1)
                m = Mid(ea, 1, 1)
                If checkABC(l) <> True And l <> "_" Then
                    ba = False
                End If

                If checkNumber(l) = True And checkABC(m) = True Then
                    ba = True
                End If
                If ba = False Then

                    If LCase(ea) = "rem" Then
                        c = Mid(e, h + 1) : h = h + Len(c)
                        ea = ea & c
                    End If

                    n = ea

                    aa = z
                    z = LCase(n)
                    o = o & ea
                    ea = ""
                End If

            ElseIf checkNumber(c) = True Or t <> "" Then
                t = t & c
                If w <> "." And checkNumber(w) = False Then
                    o = o & t
                    t = ""
                End If
            Else

                If c = "{" Then 		    	
					If phptrim(o) <> "" Then
						ia = 1
					Else
						ha = ha + 1
					End If
                ElseIf c = "}" Then
                    If ha > 0 Then
                        If phptrim(o) <> "" Then							
							
							y =x
							if instr(y,"//")>0 then
								y=mid(y,1,instr(y,"//")-1)
							end if					

                            If phptrim(y) <> "" Then
                                ia = -1
                            Else
                                ia = 0
                            End If
                        Else
                            ha = ha - 1
                        End If
                    End If
                End If

                ba = True
                If c = " " And h > 1 Then
                    If Mid(e, h - 1, 1) = " " Then
                        ba = False
                    End If
                End If
                If ba = True Then
                    o = o & c

                End If
            End If

            p = p & c
            If u = False Then Exit For
        Next
        If o = ";}" Then
            o = "}"
        End If
        If o <> "" And ha > 0 Then
            o = CopyStrNumb(ga, ha) & Replace(o, vbCrLf, vbCrLf & CopyStrNumb(ga, ha))
        End If
        ha = ha + ia
        If ja = "" Then
            g = g & o & vbCrLf
        End If
    Next
    formattingJSPHP = g
End Function






Sub printAccessToPHPInstallFile()
    Dim b, c, d, e, f, g, h
    Call openconn()
    b = getTableList()

    c = Split(b, vbCrLf)
    For Each d In c
        d = LCase(d)
        b = getFieldList(d)
        Call echo(d, b)
        e = Split(b, ",")
        h = h & """{$mydbpre}" & d & """ => ""CREATE TABLE `{$mydbpre}" & d & "` (" & vbCrLf
        h = h & "`id` int(5) unsigned NOT NULL auto_increment," & vbCrLf
        For Each f In e
            If f <> "" Then
                f = LCase(f)
                g = getFieldAlt(d, f)

                If g = "VarChar" Then
                    h = h & "`" & f & "` varchar(255) NOT NULL default ''," & vbCrLf
                ElseIf g = "Int" Then
                    h = h & "`" & f & "` int(8) NOT NULL default '0'," & vbCrLf

                ElseIf InStr("|simpleintroduction|bodycontent|content|template|", "|" & f & "|") > 0 Or InStr(f, "module") > 0 Then
                    h = h & "`" & f & "` mediumtext," & vbCrLf

                Else
                    h = h & "`" & f & "` varchar(250) NOT NULL default ''," & vbCrLf
                End If
            End If
        Next
        h = h & "PRIMARY KEY  (`Id`)" & vbCrLf
        h = h & "){$char};""," & vbCrLf
    Next
    Dim i, j, k, l, m
    j = "//access start"
    k = "//access end"
    i = "\PHP2\ImageWaterMark\Include\Install.php"
    b = getftext(i)
    l = getStrCut(b, j, k, 1)
    m = j & vbCrLf & h & k
    b = Replace(b, l, m)

    Call createfile(i, b)
    Call echo("操作完成，打印数据库到php能生成文件", "<a href=""http://127.0.0.1/PHP2/ImageWaterMark/Include/Install.php"">http://127.0.0.1/PHP2/ImageWaterMark/Include/Install.php</a>")
End Sub
%>


