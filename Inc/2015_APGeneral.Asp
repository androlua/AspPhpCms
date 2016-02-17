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





Function XY_Include(a)
    Dim b, c, d, e, f
    b = LCase(RParam(a, "File"))
    c = LCase(RParam(a, "Block"))

    Dim g, h
    g = RParam(a, "findstr")
    h = RParam(a, "replacestr")

    b = HandleFileUrl(b)
    If checkFile(b) = False Then
        b = webTemplate & b
    End If
    f = GetFText(b)
    If c <> "" Then
        d = "<!--#" & c & " start#-->"
        e = "<!--#" & c & " end#-->"
        If InStr(f, d) > 0 And InStr(f, e) > 0 Then
            f = StrCut(f, d, e, 2)
        End If
    End If

    If g <> "" Then
        f = Replace(f, g, h)
    End If

    XY_Include = f
End Function



Function handleModuleReplaceArray(ByVal a)
    Dim b, c, d, e, f
    For b = 1 To UBound(ModuleReplaceArray) - 1
        If ModuleReplaceArray(b, 0) = "" Then
            Exit For
        End If

        f = ModuleReplaceArray(b, 0)
        e = ModuleReplaceArray(0, b)
        If f = "【删除】" Then
            a = Replace(a, e, "")
        Else
            c = "<replacestrname " & f & ">" : d = "</replacestrname " & f & ">"
            If InStr(a, c) > 0 And InStr(a, d) > 0 Then
                a = replaceContentModule(a, c, d, e, "")
            End If
            c = "<replacestrname " & f & "/>"
            If InStr(a, c) > 0 Then
                a = replaceContentRowModule(a, "<replacestrname " & f & "/>", e, "")
            End If
        End If
    Next
    handleModuleReplaceArray = a
End Function


Function delTemplateMyNote(a)
    Dim b, c, d, e, f, g, h, i
    Dim j, k, l, m, n, o
    f = 99






    For d = 1 To f
        b = "<R#读出内容" : c = " start#>"
        h = StrCut(a, b, c, 2)
        If h <> "" Then
            b = "<R#读出内容" & h & " start#>" : c = "<R#读出内容" & h & " end#>"
            If InStr(a, b) > 0 And InStr(a, c) > 0 Then
                e = StrCut(a, b, c, 1)
                a = Replace(a, e, "")
            End If
        Else
            Exit For
        End If
    Next


    If Request("gl") = "yun" Then
        j = GetFText("/Jquery/dragsort/Config.html")
        j = GetFText("/Jquery/dragsort/模块拖拽.html")

        b = "<style>"
        c = "</style>"
        If InStr(j, b) > 0 And InStr(j, c) > 0 Then
            k = StrCut(j, b, c, 1)
        End If

        b = "<!--#top start#-->"
        c = "<!--#top end#-->"
        If InStr(j, b) > 0 And InStr(j, c) > 0 Then
            l = StrCut(j, b, c, 2)
        End If

        b = "<!--#foot start#-->"
        c = "<!--#foot end#-->"
        If InStr(j, b) > 0 And InStr(j, c) > 0 Then
            m = StrCut(j, b, c, 2)
        End If

        b = "<!--#value start#-->"
        c = "<!--#value end#-->"
        If InStr(j, b) > 0 And InStr(j, c) > 0 Then
            n = StrCut(j, b, c, 2)
        End If




        b = "<dIv datid='"
        c = "</dIv>"
        j = GetArray(a, b, c, False, False)
        g = Split(j, "$Array$")
        For Each e In g
            b = "【DatId】'"
            i = Mid(e, 1, InStr(e, b) - 1)
            e = Mid(e, InStr(e, b) + Len(b))

            e = "<div" & e & "</div>"

            o = o & Replace(Replace(n, "{$value$}", e), "{$id$", i)
        Next
        o = Replace(o, "【换行】", vbCrLf)
        o = l & o & m
        a = Mid(a, 1, InStr(a, "<body>") - 1)
        a = Replace(a, "</head>", k & "</head></body>" & o & "</body></html>")
    End If


    b = "<dIv datid='" : c = "【DatId】'"
    For d = 1 To f
        If InStr(a, b) > 0 And InStr(a, c) > 0 Then
            i = StrCut(a, b, c, 2)
            a = Replace2(a, b & i & c, "<div ")
        Else
            Exit For
        End If
    Next
    a = Replace(a, "</dIv>", "</div>")


    b = "<!--#dialogteststart#-->" : c = "<!--#dialogtestend#-->"
    a = Replace(a, "<!--#dialogtest start#-->", b)
    a = Replace(a, "<!--#dialogtest end#-->", c)
    For d = 1 To f
        If InStr(a, b) > 0 And InStr(a, c) > 0 Then
            e = StrCut(a, b, c, 1)
            a = Replace2(a, e, "")
        Else
            Exit For
        End If
    Next

    b = "<!--#teststart#-->" : c = "<!--#testend#-->"
    a = Replace(a, "<!--#del start#-->", b)
    a = Replace(a, "<!--#del end#-->", c)
    a = Replace(a, "<!--#test start#-->", b)
    a = Replace(a, "<!--#test end#-->", c)

    For d = 1 To f
        If InStr(a, b) > 0 And InStr(a, c) > 0 Then
            e = StrCut(a, b, c, 1)
            a = Replace2(a, e, "")
        Else
            Exit For
        End If
    Next

    a = Replace(a, "<sPAn class=""testspan"">", "")
    a = Replace(a, "<sPAn class=""testhidde"">", "")
    a = Replace(a, "</sPAn>", "")



    b = "<!--#" : c = "#-->"
    For d = 1 To f
        If InStr(a, b) > 0 And InStr(a, c) > 0 Then
            e = StrCut(a, b, c, 1)
            a = Replace2(a, e, "")
        Else
            Exit For
        End If
    Next


    delTemplateMyNote = a
End Function





Sub handleFunParameter(a, b, c, d, e, f, g, h)
    Dim i, j
    b = RParam(a, "Did")
    c = RParam(a, "Sid")
    d = RParam(a, "Tid")

    b = IIF(b = "[$PubProDid$]", PubProDid, b)
    c = IIF(c = "[$PubProSid$]", PubProSid, c)
    d = IIF(d = "[$PubProTid$]", PubProTid, d)

    e = RParam(a, "Title")
    f = RParam(a, "TopNumb")
    g = RParam(a, "CutStrNumb")
    If g = "" Then g = 28
    h = RParam(a, "AddSql")
End Sub

function handleReplaceValueParam(a, byval b, c)
	If InStr(a, "[$" & b)=false then
		b=lcase(b)
	end if
	handleReplaceValueParam=replaceValueParam(a, b, c)
end function


Function replaceValueParam(a, b, c)
    Dim d, e, f,g, h, i, j, k, l, m
	dim ifStr		
	dim o
	dim valueStr	
	dim elseStr		
	dim instrStr	


    If IsNul(c) = True Then c = ""

    d = "[$" & b : e = "$]"

    If InStr(a, d) > 0 And InStr(a, e) > 0 Then

        If InStr(a, d & e) > 0 Then
            f = d & e
        ElseIf InStr(a, d & " ") > 0 Then
            f = StrCut(a, d & " ", e, 1)
        Else
            f = StrCut(a, d, e, 1)
        End If
		g=f
		f=handleInModule(f,"start")

        j = RParam(f, "delHtml")
        If j = "true" Then c = Replace(DelHtml(c), "<", "&lt;")

        l = RParam(f, "trim")
        If l = "true" Then c = TrimVbCrlf(c)


        h = RParam(f, "len")
        h = HandleNumber(h)

        If h <> "" Then c = CutStr(c, h, "...")


        i = RParam(f, "format_Time")
        If i <> "" Then
            c = Format_Time(c, i)
        End If
		
		
        m = RParam(f, "getcolumnname")
        If m <> "" Then
			if m="@ME" then
				m=c
			end if
            c = getcolumnname(m)
        End If	
		
        m = RParam(f, "getcolumnurl")
        If m <> "" Then
			if m="@ME" then
				m=c
			end if
            c = getcolumnurl(m,"id")
        End If		
		
		ifStr=RParam(f,"if")
		o=RParam(f,"elseif")		
		valueStr=RParam(f,"value")
		elseStr=RParam(f,"else")
		instrStr=RParam(f,"instr")
		
		
		
		
		if ifStr<>"" or instrStr<>"" then
			if (ifStr=CStr(c) and ifStr<>"") or (o=CStr(c) and o<>"") then
				c=valueStr
			elseif instr(CStr(c),instrStr)>0 and instrStr<>"" then
				c=valueStr
			else
				if elseStr<>"@ME" then
					c=elseStr
				end if
			end if
		end if
		
		
        k = RParam(f, "function")
        If k <> "" Then
			k=replace(k,"@ME",c)
			c=handleContentCode(k,"")
        End If
        a = Replace(a, g, c)
    End If
    replaceValueParam = a
End Function

function testfunction(a)
	testfunction=a & "(end)"
end function






%>



