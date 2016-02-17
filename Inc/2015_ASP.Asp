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





Function BatchFindFunction(a,b)
	Dim c,d,e,f,g
	Dim h,i
	If CheckFile(a)=False Then
		BatchFindFunction=""
		Call Echo("配置文件不存在", a)
		Exit Function
	End If
	c=GetFText(a)
	d = LCase(c)
	d=Replace(Replace(d, ",","|"), vbCrlf,"|")
	e=Split(b,"|")
	For Each f In e
		If f<>"" And InStr(d,"|"& f &"|") Then
			g=g & GetFindFileFunction(a,f) & vbCrlf
		End If
	Next
	BatchFindFunction = g
End Function

Function GetFindFileFunction(ByVal a,ByVal b)
	Dim c,d,e,f,g,h
	Dim i,j
	b=LCase(PHPTrim(b))
	If CheckFile(a)=False Then
		GetFindFileFunction=""
		Call Echo("配置文件不存在", a)
		Exit Function
	End If
	d=GetFText(a)
	e=Split(d,vbCrlf)
	For Each g In e
		If InStr(g,",")>0 Then
			c=Mid(g,1,InStr(g,",")-1)
			If InStr(c,"(")>0 Then
				c=Mid(c,1,InStr(c,"(")-1)
			End If
			h=LCase(Mid(g,InStrRev(g,",")+1))
			If InStr("|"& h &"|","|"& b &"|")>0 Then
				
				Set i = New ASPCode
				i.SetCountRow = 9999
				i.SetAspSetType = "||"		
				i.SetFindFunctionList=b
				j=GetFText(c)
				j = i.HandleAspCode(j)				
				
				GetFindFileFunction = i.getFindFunctionContent
				Set i=Nothing
				Exit Function
			End If
		End If
	Next
End Function


Function GetASPCode(ByVal a)
    GetASPCode = HandleGetAspCode(a, "")
End Function



Function HandleGetAspCode(ByVal a, b)
    Dim c, d, e, f, g, h, i, j, k, l, m
    h = False
    i = 0
    c = Split(a, vbCrLf)
	
	
	If InStr("|" & b & "|", "|全部为ASP|") > 0 Or InStr("|" & b & "|", "|默认ASP自检打开|") > 0 Then
		h = True
	End If

    For Each e In c

        k = ""
        For g = 1 To Len(e)
            d = Mid(e, g, 1)

            If d = "<" And h = False And j = "" Then
                If Mid(e, g + 1, 1) = "%" Then
                    h = True
                    d = "<" & "%"
                    g = g + 1
                    If InStr("|" & b & "|", "|去ASP开始结束标签|") = False Then
                        k = k & d
                    End If
                End If

            ElseIf d = "%" And Mid(e, g + 1, 1) = ">" And h = True And j = "" Then
                h = False
                d = "%" & ">"
                g = g + 1
                If InStr("|" & b & "|", "|去ASP开始结束标签|") = False Then
                    f = f & d & vbCrLf
                End If
                If InStr("|" & b & "|", "|第一段|") > 0 Or InStr("|" & b & "|", "|第一段代码|") > 0 Or InStr("|" & b & "|", "|获取第一段|") > 0 Or InStr("|" & b & "|", "|1|") > 0 Then
                    HandleGetAspCode = f & k
                    Exit Function
                End If

            ElseIf h = True Then

                If(d = """" Or j <> "") Then

                    If d = """" Then i = i + 1
                    j = j & d
				
                    If i Mod 2 = 0 Then
                        If Mid(e, g + 1, 1) <> """" Then
                            k = k & j
                            i = 0 : j = ""
               			End If
                    End If
                ElseIf d = "'" Then
                    If InStr("|" & b & "|", "|去注释部分|") > 0 Then
                        Exit For
                    End If
                    k = k & Mid(e, g)
                    Exit For
                Else
                    k = k & d
                End If

            End If
        Next
        If h = True Then			
            m = True
            If TrimVbCrlf(k) = "" Then
                If InStr("|" & b & "|", "|每行不为空|") > 0 Or InStr("|" & b & "|", "|去空行|") > 0 Then
                    m = False
                End If
            End If
            If m = True Then
                If InStr("|" & b & "|", "|处理成Execute代码|") > 0 Then
                    k = TrimVbCrlf(k) : l = LCase(k)
                    f = f & k & " : "
                    If Left(l, 3) = "if " And Right(l, 5) <> " then" Then
                        f = f & " End If : "
                    End If
                Else
					
        			k = RTrim(k)
                    f = f & k & vbCrlf
                End If
            End If
        End If
    Next
	If InStr("  " & f,vbCrlf)>0 Then f = Left(f,Len(f)-2)
    HandleGetAspCode = f
End Function


Function DelAspNote(ByVal a)
    Dim b, c, d, e, f, g, h, i, j
    Dim k
    d = False
    k = False
    e = False
    j = 0
    b = Split(a, vbCrLf)

    For Each g In b

        For c = 1 To Len(g)
            f = Mid(g, c, 1)

            If f = "<" And h = "" Then
                If Mid(g, c + 1, 1) = "%" Then
                    d = True
                    f = "<" & "%"
                    c = c + 1
                End If

            ElseIf f = "%" And Mid(g, c + 1, 1) = ">" And h = "" Then
                d = False
                f = "%" & ">"
                c = c + 1
            End If
            If d = True Then

                If(f = """" Or h <> "") Then

                    If f = """" Then j = j + 1
                    h = h & f

                    If j Mod 2 = 0 Then
                        If Mid(g, c + 1, 1) <> """" Then
                            i = i & h
                            j = 0 : h = ""
                        End If
                    End If
                ElseIf f = "'" Then
                    Exit For
                Else
                    i = i & f
                End If
            Else
                i = i & f
            End If
            DoEvents
        Next
        i = RTrim(i)
        i = i & vbCrLf
        DoEvents
    Next
    If i <> "" Then i = Left(i, Len(i) - 2)
    DelAspNote = i
End Function




Function FindAspFunction(a, b, c, d)
    Dim e, f, g, h, i, j, k, l, m, n, o
	Dim UpWord																	
    Dim q, r
    Dim s
    g = False
    s = False
    h = False
    o = 0
    e = Split(a, vbCrLf)
    If b = "" Then b = 0
    If c = "" Then c = 0
	
	
	If InStr("|" & d & "|", "|全部为ASP|") > 0 Or InStr("|" & d & "|", "|默认ASP自检打开|") > 0 Then
		g = True
	End If

    For Each j In e

        For f = 1 To Len(j)
            i = Mid(j, f, 1)

            If i = "<" And k = "" Then
                If Mid(j, f + 1, 1) = "%" Then
                    g = True
                    f = f + 1
                End If

            ElseIf i = "%" And Mid(j, f + 1, 1) = ">" And k = "" Then
                g = False
                f = f + 1
            End If
            If g = True Then

                If(i = """" Or k <> "") Then

                    If i = """" Then o = o + 1
                    k = k & i

                    If o Mod 2 = 0 Then
                        If Mid(j, f + 1, 1) <> """" Then
                            m = Right(Replace(Mid(j, 1, f - Len(k)), " ", ""), 1)
                            If s = True Then n = n & k
                            o = 0 : k = ""
                        End If
                    End If
                ElseIf i = "'" Then
                    If s = True Then n = n & Mid(j, f)
                    Exit For

                ElseIf CheckABC(i) = True Or(i = "_" And l <> "") Or l <> "" Then
                    l = l & i
                    m = LCase(Mid(j & " ", f + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", m) = 0 And Not(m = "_" And l <> "") Then
                        q = Mid(j, f + 1)
                        If InStr("|function|sub|", "|" & LCase(l) & "|") Then

                            If s = False And LCase(UpWord) <> "end" Then
                                s = True
                                If LCase(l) = "sub" Then b = b + 1 Else c = c + 1
                                r = GetFunDimName(q)
                            ElseIf s = True And LCase(UpWord) = "end" Then
                                n = n & l & vbCrLf
                                If InStr("|" & d & "|", "|加密变量|") > 0 Then n = n & "'[NOHandle]" & EncCode(r) & vbCrLf & vbCrLf
                                s = False
                            End If
                        ElseIf s = True And LCase(l) = "dim" Then
                            r = r & "," & GetDimName(q)
                        ElseIf s = True And InStr("|" & d & "|", "|变量处理|") > 0 Then
                            l = ReplaceDim2(r, l)
                        End If
                        UpWord = l
                        If s = True Then n = n & l
                        l = ""
                    End If
                ElseIf s = True Then
                    n = n & i
                End If
            End If
            DoEvents
        Next
        n = RTrim(n)
        If s = True Then
            n = n & vbCrLf
        End If
        DoEvents
    Next
    FindAspFunction = n
End Function



Function FirstLetterUppercase(a)
    Dim b, c, d, e, f, g, h, i, j, k, l
    Dim m

    d = False
    m = False
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
                    f = "<%"
                End If

            ElseIf f = "%" And Mid(g, c + 1, 1) = ">" And h = "" Then
                d = False
                c = c + 1
                k = k & "%" & ">"
            End If
            If d = True Then

                If(f = """" Or h <> "") Then

                    If f = """" Then l = l + 1
					h = h & f

                    If l Mod 2 = 0 Then
                        If Mid(g, c + 1, 1) <> """" Then
                            j = Right(Replace(Mid(g, 1, c - Len(h)), " ", ""), 1)
                            If m = True Then k = k & h
                            l = 0 : h = ""
						End If
                    End If
                ElseIf f = "'" Then
                    If m = True Then k = k & Mid(g, c)
                    Exit For

                ElseIf CheckABC(f) = True Or(f = "_" And i <> "") Or i <> "" Then
                    i = i & f
                    j = LCase(Mid(g & " ", c + 1, 1))
                    If InStr("abcdefghijklmnopqrstuvwxyz0123456789", j) = 0 And Not(j = "_" And i <> "") Then
                        k = k & UCase(Left(i, 1)) & Mid(i, 2)
                        i = ""
                    End If
                Else
                    k = k & f
                End If
            End If
            DoEvents
        Next
        k = Rtrim(k)
        If m = True Then
            k = k & vbCrlf
        End If
        k = k & vbCrlf
        DoEvents
    Next
    FirstLetterUppercase = k
End Function


Function ContentLUShow(a)
	Dim b,c,d
    For b = 1 To Len(a)
        c = Mid(a, b, 1)
		c = IIF(PHPRnd(0,1)="0",LCase(c),UCase(c))
		d=d & c
	Next
	ContentLUShow = d
End Function

function ASPToVB(a)
	
	a= deleteStrCut(a,vbCrlf & "'开始",vbCrlf & "'结束",1,0)
	
	a= deleteStrCut(a,vbCrlf & "'VB不引用 Start", vbCrlf & "'VB不引用 End",1,0)
	
	a = Replace(a,"Response.End()","Response.End")
	a = Replace(a,"Server."&"MapPath(Path)","App"&".Path & ""\"" & Path")
	a = Replace(a,"Server."&"MapPath(""/"")","App."&"Path & ""\""")
	a = Replace(a,"Server."&"MapPath(""\"")","App."&"Path & ""\""")
	a = Replace(a,"Server."&"MapPath("".\"")","App."&"Path & "".\""")
	a = Replace(a,"Server."&"MapPath(""./"")","App."&"Path & "".\""")
	
	a = Replace(a,""" & Request."&"ServerVariables(""HTTP_HOST"") & ""","127.0.0.1")
	a = Replace(a,vbTab,"    ")			
	a = Replace(a,"request(""Debug"")"," 1=2 and ""11""")			
	a = Replace(a,"Request(""gl"")"," 1=2 and ""11""")			
	a = Replace(a,"Request."&"QueryString(""Debug"")"," 1=2 and ""11""")			
	ASPToVB = a
end function

function ASPToVBNET(a)
	dim b,c,d,e,f,g,h,i
	dim j,k,l,m
	b=split(a,vbcrlf)
	for each d in b
		h=phptrim(lcase(d)):e=phptrim(d)
			
		if instr(Lcase(d)," doerror ")>0 and instr(Lcase(d),"call ")=false then
			d=RegExp_Replace(d, " doError ", " call doError(") & ")"
			
		end if
		
		if left(h,4)="sub " then
			d=functionParamtoNet(d)						
		elseif left(h,9)="function " then
			d=functionParamtoNet(d)						
			f=mid(d,instr(Lcase(d),"function ") + 9)
			i=phptrim( mid(f,1,instr(f,"(")-1))
			d = d & vbcrlf & i & "="""""
		elseif left(h,4)="set " then
			d=mid(d, instr(lcase(d),"set ")+3)
		elseif left(h,4)="dim " then
			d=dimAddDefaultValue(d)
			
		elseif left(h,1)="." then
			j=mid(d,1,instr(d,".")-1)
			k=""
			if instr(d,"'")>0 then
				k=mid(d,instr(d,"'"))
			end if
			l=mid(d,instr(d,"."))
			if instr(d,"'")>0 then
				l=mid(l,1,instr(l,"'")-1)
			end if
			m=l
			l=j & "call " & mid(l,1,instr(l," ")) & "(" & mid(l,instr(l," ")) & ")" & k
			if instr(m,"=")=false and instr(m,"(")=false  then
				d=l
				
			end if
		
		
		elseif left(h,2)="if" then
			j=mid(d,1,instr(lcase(d),"if")-1)
			k=""
			if instr(d,"'")>0 then
				k=mid(d,instr(d,"'"))
			end if
			l=mid(d,instr(lcase(d),"if"))
			if instr(d,"'")>0 then
				l=mid(l,1,instr(l,"'")-1)
			end if
			if right(RTrimVBTab(lcase(l)),5)<>" then" then
				l=l & " :end if  "
			end if
			l = j & l & k
			
		elseif left(h,4)="wend" then
			d= "end While"
			
		end if
		
		g=g & d & vbcrlf
	next
	ASPToVBNET=g
end function

function dimAddDefaultValue(a)
	dim b,c,d,e,f,g,h
	g=a
	e=mid(a,1,instr(Lcase(a),"dim ")+3)
	a=mid(a,len(e))
	b=split(a,",")
	for each c in b			
		h=""
		if instr(c,":")>0 then
			h=mid(c,instr(c,":"))
			c=mid(c,1,instr(c,":")-1)
			
		elseif instr(c,"'")>0 then
			h=mid(c,instr(c,"'"))
			c=mid(c,1,instr(c,"'")-1)
			
		end if
		
		if instr(lcase("|c|content|html|htmlstr|strhtml|cssstr|strcss|StyleName|parentUrl|parentParentUrl|parentParentParentUrl|szRet|Url|UrlFileName|urlList|UrlParam|WebSite|FanCharSet|s1|s2|s3|c1|c2|c3|c4|c5|En1|En2|En3|En4|s|temp|temp1|temp2|temp3|yinghaoLabel|parentName|valueStr|valueStr1|valueStr2|valueStr3|noDanYinShuangYinStr|PubAHrefList|PubATitleList|yinghaoLabel|parentName|valueStr|nLen|ParamList|ParamNameList|ParamList|Str_unicode|valueLabel||"), "|" & phptrim(lcase(c)) & "|")>0 or right(phptrim(lcase(c)),3)="str" then
			f= f & c & "=""""" & vbCrlf
		end if
		if d<>"" then d=d & ","
		d=d & c & h
	next
	dimAddDefaultValue=g & vbcrlf & f
end function

function functionParamtoNet(a)
	dim b,c,d,e,f,g,h
	b=mid(a,1,instr(a,"("))
	c=mid(a,instr(a,")"))
	d=mid(a,instr(a,"(")+1)
	d=mid(d,1,instr(d,")")-1)
	
	e=split(d,",")
	for each f in e
		f=phptrim(f)
		h=lcase(f)
		if instr(h,"byval")=false and instr(h,"byref")=false then
			f=" byref " & f
		end if
		if g<>"" then g=g & ","
		g=g & f
	next
	
	
	
	functionParamtoNet = b & g & c
end function







function GetBeforeNStr(a,b,c)
    dim d, e, f, g, h, i, j, k, l, m
    dim n
	dim ArrayWC(999)											
	dim ArrayWCCount											
    dim q
	dim ArrayZC(999)											
	dim ArrayZCCount											
    dim t
	dim ArrayNC(999)											
	dim ArrayNCCount											
    dim w
	dim ArrayFC(999)											
	dim ArrayFCCount											
	
	dim ArrayCountStr(999)											
	dim nArrayCount											  	

	
    dim ba
    dim ca
    dim da
    dim ea
    dim fa

    dim ga
    dim ha
    dim ia
    dim ja
    dim ka

    dim la
	
    i = 0
	
	
    ArrayWCCount=0											
    ArrayZCCount=0											
    ArrayNCCount=0											
    ArrayFCCount=0											
	nArrayCount=0											
	
	
	

    d = split(a, vbCrLf)

    for m = 0 to uBound(d)
        f = d(m)
        ca = f
        ia = "" : ja = ""
        la = ""
        ka = ""
        if(m + 1) <= uBound(d) then
            ka = d(m + 1)
        end if
        t = ""


        for h = 1 to len(f)
            e = mid(f, h, 1)
            ga = right(replace(mid(f, 1, h - 1), " ", ""), 1)
            ha = left(replace(mid(f, h + 1), " ", ""), 1)
            fa = mid(f, h + 1)


            if(e = """" or n <> "") then

                if e = """" then i = i + 1

                if i mod 2 = 0 then
                    if mid(f, h + 1, 1) <> """" then
                        n = n & e
                        j = right(replace(mid(f, 1, h - len(n)), " ", ""), 1)


                        n = right(n, len(n) - 1)
                        n = left(n, len(n) - 1)
                        n = replace(n, """""", "\""")
                        n = """" & n & """"
						
						
    ArrayWCCount=ArrayWCCount+1											
	ArrayWC(ArrayWCCount)=n											
	nArrayCount=nArrayCount+1											
	ArrayCountStr(nArrayCount)=n										

                        ia = ia & n
                        i = 0 : n = ""
                    else
                        n = n & e
                    end if
                else
                    n = n & e
                end if


            elseIf inStr(".&=,+-*/:()><", e) > 0 and t = "" then
                if q <> "" then
                    l = q
                    ea = da
                    da = lCase(l)
                    ia = ia & q
                    q = ""
                end if
                ea = da
                da = e
				
    ArrayFCCount=ArrayFCCount+1											
	ArrayFC(ArrayFCCount)=e											
	nArrayCount=nArrayCount+1											
	ArrayCountStr(nArrayCount)=e										
			
            elseIf e = "'" then
                la = "//" & mid(f, h + 1)
                exit for

            elseIf checkABC(e) = true or e = "_" or q <> "" then
                q = q & e
                ba = true
                j = mid(f & " ", h + 1, 1)
                k = mid(q, 1, 1)
                if checkABC(j) <> true and j <> "_" then
                    ba = false
                end if

                if checkNumber(j) = true and checkABC(k) = true then
                    ba = true
                end if
                if ba = false then

                    if lCase(q) = "rem" then
                        e = mid(f, h + 1) : h = h + len(e)
                        q = q & e
                    end if


    ArrayZCCount=ArrayZCCount+1											
	ArrayZC(ArrayZCCount)=q											
	nArrayCount=nArrayCount+1											
	ArrayCountStr(nArrayCount)=q										
	

                    l = q

                    ea = da
                    da = lCase(l)
                    ia = ia & q
                    q = ""
                end if

            elseIf checkNumber(e) = true or t <> "" then
                t = t & e
                if ha <> "." and checkNumber(ha) = false then
                    ia = ia & t
					

    ArrayNCCount=ArrayNCCount+1											
	ArrayNC(ArrayNCCount)=t											
	nArrayCount=nArrayCount+1											
	ArrayCountStr(nArrayCount)=t										
					
					
                    t = ""
                end if
            else
                ia = ia & e
            end if
            ja = ja & e
        next
        g = g & ia
    next

	
	if b="单词" then
		if ubound(ArrayCountStr)>=c then
			GetBeforeNStr=ArrayZC(c)
		end if	
	elseif b="输入" then
		if ubound(ArrayCountStr)>=c then
			GetBeforeNStr=ArrayWC(c)
		end if	
	elseif b="符号" then
		if ubound(ArrayCountStr)>=c then
			GetBeforeNStr=ArrayFC(c)
		end if	
	elseif b="数字" then
		if ubound(ArrayCountStr)>=c then
			GetBeforeNStr=ArrayNC(c)
		end if	
	elseif b="全部" then
		if ubound(ArrayCountStr)>=c then
			GetBeforeNStr=ArrayCountStr(c)	
		end if	
	else
		GetBeforeNStr=g
	end if
end function



function getStrDim(byval a)
	a=replace(replace(a,vbcrlf,":"),vbtab," ")
	if instr(a,":")>0 then
		a=mid(a,1,instr(a,":")-1)
	end if
	if instr(a,"'")>0 then
		a=mid(a,1,instr(a,"'")-1)
	end if
	a=phptrim(a)
	if left(a,3)="dim" then
		a=mid(a,4)
	end if
	a=replace(a," ","")
	dim b,c,d
	if instr(a,"(")>0 then
		b=split(a,",")
		for each c in b
			if c <>"" then
				if d<>"" then d=d & ","
				if instr(c,"(")>0 then
					c=mid(c,1,instr(c,"(")-1)
				end if
				d=d & c
			end if
		next
		a=d
	end if
	getStrDim=a
end function


function getFunctionStrDim(byval a)
	dim b,c,d,e
	if instr(a,")")>0 then
		a=mid(a,1,instr(a,")")-1)
	end if
	if instr(a,"(")>0 then
		a=mid(a,instr(a,"(")+1)
	end if
	a=replace(a,","," ")
	b=split(a," ")
	for each c in b
		e=lcase(c)
		if e<>"" and e<> "byval" and e<>"byref" then
			if d<>"" then d=d & ","
			d=d & c
		end if
	next
	getFunctionStrDim=d
end function

%>

