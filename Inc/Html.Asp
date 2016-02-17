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



Function showHTMLCode(a)
    If Not IsNull(a) Then
        a = Replace(a, " ", "&nbsp;")
        a = Replace(a, "<", "&lt;")
        a = Replace(a, ">", "&gt;")
        a = Replace(a, "”", "&rdquo;")
        a = Replace(a, "“", "&ldquo;")
        a = Replace(a, "&", "&amp;")
    End If
    showHTMLCode = a
End Function

Function ShowHtml(a)
	ShowHtml=Replace(a, "<", "&lt;")
End Function

Function unHTMLCode(a)
    If Not IsNull(a) Then
        a = Replace(a, "&nbsp;", " ")
        a = Replace(a, "&lt;", "<")
        a = Replace(a, "&gt;", ">")
        a = Replace(a, "&rdquo;", "”")
        a = Replace(a, "&ldquo;", "“")
        a = Replace(a, "&mdash;", "—")
        a = Replace(a, "&lsquo;", "‘")
        a = Replace(a, "&rsquo;", "’")
		
        a = Replace(a, "&amp;", "&")
		
    End If
    unHTMLCode = a
End Function

Function EchoHTML(a)
    If Not IsNull(a) Then
        a = Replace(a, " ", "&nbsp;")
        a = Replace(a, "<", "&lt;")
	End If
    EchoHTML = a
End Function


Function ErrorText(a, b, c)
    If IsNull(a) Then Rw "<meta http-equiv=""refresh"" content=""" & a & ";URL=" & c & """"""">" & vbCrlf
    Rw("<fieldset>") & vbCrlf
    Rw("<legend>&nbsp;Report&nbsp;</legend>") & vbCrlf
    Rw("<div style=""padding-left:20px;padding-top:10px;color:red;font-weight:bold;text-align:center;"">" & b & "</div>") & vbCrlf
    Rw("<div style=""height:200p;text-align:center;""><P>") & vbCrlf
    Rw("<a href=""" & c & """>如果您的游览器没有自动跳转,请点这里>></a><P>") & vbCrlf  	
    Rw("</div></fieldset>") : Response.End()
End Function



Sub TestHtml()
	Dim b
	b = "<font style=""font-size:12px"">显示<b>1</b></font>"
	Call Echo("S",b)
	b = HtmlEncode(b)
	Call Echo("S",b)
	b = HtmlDecode(b)
	Call Echo("S",b)
	b = HtmlFilter(b)
	Call Echo("S",b)
End Sub

Function HtmlDecode(ByVal a)
	If Not IsNul(a) Then
		a = regReplace(a, "<br\s*/?\s*>", vbCrLf)
		a = Replace(a, "&nbsp;&nbsp; &nbsp;", Chr(9))
		a = Replace(a, "&quot;", Chr(34))
		a = Replace(a, "&nbsp;", Chr(32))
		a = Replace(a, "&#39;", Chr(39))
		a = Replace(a, "&apos;", Chr(39))
		a = Replace(a, "&gt;", ">")
		a = Replace(a, "&lt;", "<")
		a = Replace(a, "&amp;", Chr(38))
		a = Replace(a, "&#38;", Chr(38))
		HtmlDecode = a
	End If
End Function

Function HtmlEncode(ByVal a)
	If Not IsNul(a) Then
		a = Replace(a, Chr(38), "&#38;")
		a = Replace(a, "<", "&lt;")
		a = Replace(a, ">", "&gt;")
		a = Replace(a, Chr(39), "&#39;")
		a = Replace(a, Chr(32), "&nbsp;")
		a = Replace(a, Chr(34), "&quot;")
		a = Replace(a, Chr(9), "&nbsp;&nbsp; &nbsp;")
		a = Replace(a, vbCrLf, "<br />")
	End If
	HtmlEncode = a
End Function

Function HtmlFilter(ByVal a)
	a = regReplace(a,"<[^>]+>","")
	a = Replace(a, ">", "&gt;")
	a = Replace(a, "<", "&lt;")
	HtmlFilter = a
End Function
Function regReplace(ByVal a, ByVal b, Byval c)
	regReplace = Easp_Replace(a,b,c,0)
End Function
Function Easp_Replace(ByVal a, ByVal b, Byval c, ByVal d)
	Dim e,f : e = a
	If Not IsNul(a) Then
		Set f = CreateObject("VBscript.RegExp")
		f.Global = True
		f.IgnoreCase = True
		If d = 1 Then f.Multiline = True
		f.Pattern = b
		e = f.Replace(e,c)
		Set f = Nothing
	End If
	Easp_Replace = e
End Function













function handleHtmlLabelClose(a,b,c)
	dim d,e,f,g,h,i,j,k,l
	d = "<" & b : e = ">"
	i = GetArray(a, d, e, True, false)
	
	f=Split(i,"$Array$")
	for each j in f
		l=phpTrim(j)
		if right(l,1)="/" then
			l=PHPTrim(left(l,len(l)-1))
		end if
		if c=true then
			k = lcase(j)
			if instr(k,"alt")=false then
				l = l & " alt="""""
			end if
		end if
		a = replace(a,j & ">", l & " />")
	next
	handleHtmlLabelClose=a
end function


function handleImgClose(a,b)
	handleImgClose=handleHtmlLabelClose(a,"img",b)
end function

function handleBrClose(a,b)
	handleBrClose=handleHtmlLabelClose(a,"br",false)
	handleBrClose=replace(handleBrClose,"<br>","<br />")
end function

function handleHrClose(a,b)
	handleHrClose=handleHtmlLabelClose(a,"hr",false)
	handleHrClose=replace(handleHrClose,"<hr>","<hr />")
end function





Function handleCloseHtml(a,b,c)
    Dim d, e, f, g, h, i, j, k
	c="|"& c &"|"
    j = "<"
    k = ">"
    For d = 1 To Len(a)
        f = Mid(a, d, 1)
        e = Mid(a, d)
        If f = "<" Then
            If InStr(e, ">") > 0 Then
                f = Mid(e, 1, InStr(e, ">"))
                d = d + Len(f) - 1
                f = Mid(f, 2, Len(f) - 2)
                f = phptrim(f)
                If Right(f, 1) = "/" Then
                    f = phptrim(Left(f, Len(f) - 1))
                End If
                e = Right(e, Len(e) - Len(f) - 2)
				
                i = Mid(f, 1, InStr(f & " ", " ") - 1)
                i = LCase(i)

				
				if  instr(c,"|处理A链接|")>0 then
					f = htmlLabelToClean(f,i,"http://127.0.0.1/TestWeb/Web/","处理A链接")
				elseif  instr(c,"|处理A链接第二种|")>0 then
					f = htmlLabelToClean(f,i,"http://127.0.0.1/debugRemoteWeb.asp?url=","处理A链接")
				else
					f = htmlLabelToClean(f,i,"","")
				end if
				

                If InStr("|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|", "|" & i & "|") > 0 Then
					f=replace(replace(replace(replace(f," class=""""","")," alt=""""","")," title=""""","")," name=""""","")		
					f=replace(replace(replace(replace(f," class=''","")," alt=''","")," title=''","")," name=''","")
					
                    If i = "img" and b=true Then
                        If InStr(f, " alt") = False Then
                            f = f & " alt="""""
                        End If
						f=trim(f)
						f = f & " /"
					
					elseif i= "script" then					
                        If InStr(f, " type") = False Then
                            f = f & " type=""text/javascript"""
                        End If						
                    End If
                End If
                f = j & f & k

                If i = "script" Then
                    g = Mid(e, 1, InStr(e, "</script>") + 8)


                    d = d + Len(g)
                    f = f & g
                End If

            End If
        End If
        h = h & f
    Next
    handleCloseHtml = h
End Function
Function htmlLabelToClean(ByVal a,b,c,d)
    Dim e, f, g, h
    Dim i
    Dim valueStr 					
    Dim yinghaoLabel				
	dim parentName					
	dim behindStr					
	dim noDanYinShuangYinStr		
	d="|"& d &"|"
    a = Replace(a & " ", vbTab, " ")				
	a=replace(replace(a," =","=")," =","=")
    i = False 										
    For e = 1 To Len(a)
        f = Mid(a, e, 1) 						
		behindStr=Mid(a,e)					
        If f = "=" and i = false Then				
            i = True
            valueStr = ""
            yinghaoLabel = ""
            If g <> "" and Right(g, 1) <> " " Then g = g & " "
			parentName=Lcase(h )					
            g = g & parentName & f
            h = ""

        ElseIf i = True and yinghaoLabel = "" Then
            If f <> " " Then
				if f<>"'" and f<>"""" then
					noDanYinShuangYinStr = f			
					f=" "
				end if
                yinghaoLabel = f
				
            End If
        ElseIf i = True and yinghaoLabel <> "" Then
			
            If yinghaoLabel = f Then
                i = False
				if b="a" and parentName="href" and instr(d,"|处理A链接|")>0 then
					
					if instr(valueStr,"?")>0 then
						valueStr=replace(valueStr,"?","WenHao") & ".html"
					end if
					if instr("|asp|php|aspx|jsp|", "|" & lcase(mid(valueStr,instrrev(valueStr,".")+1)) & "|" )>0 then
						valueStr=valueStr & ".html"
					end if
					valueStr = addToOrAddHttpUrl(c,valueStr,"替换")
					
				end if
				
				if yinghaoLabel=" " then		
				    g = g & """" & noDanYinShuangYinStr & valueStr & """ " 			
				else
	                g = g & yinghaoLabel & valueStr & yinghaoLabel 			
				end if
                yinghaoLabel = ""		
				noDanYinShuangYinStr=""						
            Else
                valueStr = valueStr & f
            End If

        ElseIf f = " " Then
			
            If h <> "" Then
				if left(trim(behindStr) & " ",1)="=" then				
					
				else
					
					If i = False Then
						 h = Lcase(h) & " " 		
					End If
					g = g & h
					h = ""
				end if
            End If
        Else
            h = h & f
        End If
		
    Next
	g=trim(g)
    htmlLabelToClean = g
End Function

function addToOrAddHttpUrl(a,byval b,c)
	dim d
	c="|"& c &"|"
	if instr(c,"|替换|")>0 then
		d=getwebsite(b)
		if d<>"" then
			b=replace(b,d,"")
		end if
	end if
	if instr(b,a)=false then
		if right(a,1)="/" and (left(b,1)="/" or left(b,1)="\") then
			b=mid(b,2)
		end if
		b = a & b
	end if
	
	addToOrAddHttpUrl=b
end function

function removeBlankLines(a)
	dim b,c,d
	d=split(a,vbcrlf)
	for each b in d
		if replace(replace(b,vbtab,"")," ","")<>"" then
			if c<>"" then c=c & vbcrlf
			c=c & b
		end if
	next
	removeBlankLines=c
end function
function removeBlankLines_test1(a)
	dim b
	for b=1 to 9
		a=replace(a,vbcrlf & vbcrlf,vbcrlf)
	next
	removeBlankLines_test1 = a
end function

Function blankHtmlBody(a,b)
    Dim c
    c= "<!DOCTYPE html PUBLIC>" & vbCrlf
    c=c & "<html xmlns=""http://www.w3.org/1999/xhtml"">" & vbCrlf
    c=c & "<head>" & vbCrlf
    c=c & "<meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312"" />" & vbCrlf
    c=c & "<title>"& a &"</title>" & vbCrlf
    c=c & "</head>" & vbCrlf
    c=c & "<body>" & vbCrlf
	c=c & b & vbcrlf
    c=c & "</body>" & vbCrlf
    c=c & "</html>" & vbCrlf
    blankHtmlBody=c
End Function


%>

