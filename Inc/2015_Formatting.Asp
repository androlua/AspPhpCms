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




Function htmlFormatting(a)
    htmlFormatting = HandleHtmlFormatting(a, False, 0, "")
End Function

Function handleHtmlFormatting(ByVal a, b, c, d)
    Dim e, f, g, h, i, j, k, l, m, n
    Dim o
	dim p,q

    Dim levelArray(299), s
    Dim t
    Dim u
    Dim v
	dim isPre																		
    u = False
    v = False
	isPre=False																		
    o = 0

    d = "|" & d & "|"
    e = Split(a, vbCrLf)
    For Each f In e
        g = f:p=f
        f = TrimVbCrlf(f) : h = LCase(f)

        If(Left(h, 8) = "<script " Or Left(h, 8) = "<script>") And InStr(f, "</script>") = False And u = False Then
            u = True
            i = i & phptrim(g) & vbCrLf
        ElseIf u = True Then

            If Left(h, 9) = "</script>" Then
                u = False
                i = i & phptrim(g) & vbCrLf
            Else
                i = i & g & vbCrLf
            End If


        ElseIf(Left(h, 10) = "<textarea " Or Left(h, 10) = "<textarea>") And InStr(f, "</textarea>") = False And v = False Then
            v = True
            i = i & phptrim(g) & vbCrLf
        ElseIf v = True Then
            i = i & phptrim(g) & vbCrLf
            If Left(h, 11) = "</textarea>" Then
                v = False
            End If

        ElseIf(Left(h, 5) = "<pre " Or Left(h, 5) = "<pre>") And InStr(f, "</pre>") = False And isPre = False Then
            isPre = True
            i = i & phptrim(g) & vbCrLf
        ElseIf isPre = True Then
            i = i & g & vbCrLf
            If Left(h, 6) = "</pre>" Then
                isPre = False
            End If
			

        ElseIf f <> "" And u = False And v = False Then
            j = "|" & Left(h, 4) & "|" : k = "|" & Left(h, 5) & "|" : l = "|" & Left(h, 6) & "|"
            m = "|" & Left(h, 7) & "|" : n = "|" & Left(h, 8) & "|"

            s = ""
            t = ""
            If InStr("|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |", j) > 0 Then
                s = j
                t = Mid(j, 3, 2)
            ElseIf InStr("|<div>|<div |", k) > 0 Then
                s = k
                t = Mid(k, 3, 3)
            ElseIf InStr("|<span>|<span |<form>|<form |", l) > 0 Then
                s = l
                t = Mid(l, 3, 4)

            ElseIf InStr("|<table>|<table |<tbody>|<tbody |", m) > 0 Then
                s = m
                t = Mid(m, 3, 5)

            ElseIf InStr("|<center>|<center |", n) > 0 Then
                s = n
                t = Mid(n, 3, 6)
            End If
            s = Trim(Replace(Replace(s, "<", ""), ">", ""))


            If s <> "" Then
                f = CopyStr("    ", o) & f
                If Right(h, 3 + Len(t)) <> "</" & t & ">" And InStr(h, "</" & t & ">") = False Then
                    o = o + 1
                    If o >= 0 Then
                        levelArray(o) = s
                    End If
                End If
            ElseIf InStr("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|", "|" & Left(h, 5) & "|") > 0 Or InStr("|</div>|", "|" & Left(h, 6) & "|") > 0 Or InStr("|</span>|</form>|", "|" & Left(h, 7) & "|") > 0 Or InStr("|</table>|</tbody>|", "|" & Left(h, 8) & "|") > 0 Or InStr("|</center>|", "|" & Left(h, 9) & "|") > 0 Then
                o = o - 1
                f = CopyStr("    ", o) & f
            Else
                f = CopyStr("    ", o) & f

                If Right(h, 6) = "</div>" Then
                    If checkHtmlFormatting(h) = False Then
                        f = Left(f, Len(f) - 6)
                        o = o - 1
                        f = f & vbCrLf & CopyStr("    ", o) & "</div>"
                    End If
                ElseIf Right(h, 7) = "</span>" Then
                    If checkHtmlFormatting(h) = False Then
                        f = Left(f, Len(f) - 7)
                        o = o - 1
                        f = f & vbCrLf & CopyStr("    ", o) & "</span>"
                    End If
                ElseIf InStr("|</ul>|</dt>|<dl>|<dd>|", k) > 0 Then
                    f = Left(f, Len(f) - 5)
                    o = o - 1
                    f = f & vbCrLf & CopyStr("    ", o) & Right(h, 5)
                End If
				
				
 				
				p=phptrim(lcase(p))
				if instr(p,"</")>0 then
					q=mid(p,instr(p,"</"))
					if InStr("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|", "|" & q & "|") > 0 and o>0 then
						o = o - 1
					end if
				end if
				
				
				
            End If

            i = i & f & vbCrLf
        ElseIf f = "" Then
            If InStr(d, "|delblankline|") = False And InStr(d, "|删除空行|") = False Then
                i = i & vbCrLf
            End If
        End If
    Next
    handleHtmlFormatting = i
    c = o
    If o <> 0 And(LCase(b) = "1" Or LCase(b) = "true") Then
        Call echo("HTML标签有错误", o)
    End If

End Function



Function checkHtmlFormatting(ByVal a)
    Dim b, c, d, e, f, g
    a = LCase(a)
    b = Split("ul|li|dt|dd|dl|div|span", "|")
    For Each c In b
        c = phptrim(c)
        If c <> "" Then
            f = 0
            g = "<" & c & " "
            If InStr(a, g) > 0 Then
                e = Split(a, g)
                f = f + UBound(e)
            End If
            g = "<" & c & ">"
            If InStr(a, g) > 0 Then
                e = Split(a, g)
                f = f + UBound(e)
            End If
            g = "</" & c & ">"
            If InStr(a, g) > 0 Then
                e = Split(a, g)
                f = f - UBound(e)
            End If

            If f <> 0 Then
                checkHtmlFormatting = False
                Exit Function
            End If
        End If
    Next
    checkHtmlFormatting = True
End Function

%>


