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




Class Cls_AB_JSON
	Public Collection, Count, QuotedVars, Kind, StrEncode
	Private s_charset

	Private Sub Class_Initialize
		
	End Sub

	Private Sub Class_Terminate
		Set Collection = Nothing
	End Sub

	Public Property Let CharSet(ByVal s)
		s_charset = Ucase(s)
	End Property
	Public Property Get CharSet()
		CharSet = s_charset
	End Property

	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function [New](ByVal a)
		Set [New] = New Cls_AB_JSON
		Select Case LCase(a)
			Case "0", "object" [New].Kind = 0
			Case "1", "array"  [New].Kind = 1
		End Select
	End Function

	Private Property Get Counter
		Counter = Count
		Count = Count + 1
	End Property

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Property Let Pair(Byval p, Byval v)
		If IsNull(p) Then p = Counter
		If vartype(v) = 9 Then
			If TypeName(v) = "Cls_AB_JSON" Then
				Set Collection(p) = v
			Else
				Collection(p) = v
			End If
		Else
			Collection(p) = v
		End If
	End Property

	Public Default Property Get Pair(Byval p)
		If IsNull(p) Then p = Count - 1
		If IsObject(Collection(p)) Then
			Set Pair = Collection(p)
		Else
			Pair = Collection(p)
		End If
	End Property

	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Sub Clean
		Collection.RemoveAll
	End Sub

	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Sub Remove(Byval a)
		If Collection.Exists(a) Then Collection.Remove a
	End Sub

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function toJSON(Byval a)
		
		Dim b,c,d : c = 0 : d = 0
		Dim e, f, g, h, i
		Dim j : j = "/"
		Dim k : k = "json2.js"			
		Dim l : l = j&k
		
		Select Case VarType(a)
			Case 1
				toJSON = "null"
			Case 7
				toJSON = """" & JsEncode__(CStr(a)) & """"
			Case 8
				Select Case TypeName(a)
					Case "IRequest", "IRequestDictionary"
						If a = Request.QueryString Or a = Request.Form Or a = Request.Cookies Then
							e = True
							toJSON = toJSON & "{"
							For Each c In a
								If e Then e = False Else toJSON = toJSON & ","
								toJSON = toJSON & IIF(QuotedVars, """" & IIF(StrEncode,JSEncode(c),JSEncode__(c)) & """", JsEncode__(c)) & ":" & toJSON(a(c))
							Next
							toJSON = toJSON & "}"
						End If
					Case "JScriptTypeInfo"
						If isFile(l) Then
							AB.Use "jsLib"
							Set h = AB.h.New
							h.BasePath = j
							h.Inc(k)
							Set i = h.Object
							toJSON = i.toString(a)
							Set i = Nothing
							Set h = Nothing
						Else
							toJSON = a
						End If
					Case Else
						If a="" Then
							toJSON = """"""
						Else
							toJSON = """" & IIF(StrEncode,JSEncode(a),JSEncode__(a)) & """"
						End If
				End Select
			Case 9
				Select Case TypeName(a)
					Case "Nothing","Empty"
						toJSON = "{}"
					Case "Recordset"
						If a.State = 0 Then
							toJSON = "[]"
						Else
							If IsNul(a) Then
								toJSON = "[]"
							Else
								On Error Resume Next
								Set a = a.Clone
								On Error Goto 0
								If a.RecordCount = 1 Then
									e = True
									toJSON = toJSON & "[{"
									For d = 0 To a.Fields.Count-1
										If e Then e = False Else toJSON = toJSON & ","
										If QuotedVars Then
											toJSON = toJSON & """" & IIF(StrEncode,JSEncode(lcase(a.Fields(d).Name)),JSEncode__(lcase(a.Fields(d).Name))) & """:" & toJSON(a.Fields(d).Value)
										Else
											toJSON = toJSON & IIF(StrEncode,JSEncode(lcase(a.Fields(d).Name)),JSEncode__(lcase(a.Fields(d).Name))) & ":" & toJSON(a.Fields(d).Value)
										End If
									Next
									toJSON = toJSON & "}]"
								Else
									f = True
									toJSON = toJSON & "["
									a.MoveFirst
									Do While Not a.Eof
										If f Then f = False Else toJSON = toJSON & ","
										e = True
										toJSON = toJSON & "{"
										For d = 0 To a.Fields.Count-1
											If e Then e = False Else toJSON = toJSON & ","
											If QuotedVars Then
												toJSON = toJSON & """" & IIF(StrEncode,JSEncode(lcase(a.Fields(d).Name)),JSEncode__(lcase(a.Fields(d).Name))) & """:" & toJSON(a.Fields(d).Value)
											Else
												toJSON = toJSON & IIF(StrEncode,JSEncode(lcase(a.Fields(d).Name)),JSEncode__(lcase(a.Fields(d).Name))) & ":" & toJSON(a.Fields(d).Value)
											End If
										Next
										toJSON = toJSON & "}"
										c = c + 1
										a.MoveNext
									Loop
									toJSON = toJSON & "]"
								End If
							End If
						End If
					Case "Dictionary", "IRequest", "IRequestDictionary", "IApplicationObject", "ISessionObject"
						If TypeName(a) = "IRequest" Then
							Dim m : Set m = Server.CreateObject(AB.dictName)
							m.add "clientcertificate", a.ClientCertificate
							m.add "cookies", a.cookies
							m.add "form", a.form
							m.add "querystring", a.queryString
							m.add "servervariables", a.serverVariables
							m.add "totalbytes", a.totalBytes
							toJSON = toJSON(m)
						ElseIf TypeName(a) = "IApplicationObject" Or TypeName(a) = "ISessionObject" Then
							g = a.Contents.Count
							If g = 0 Then
								toJSON = "{}"
							Else
								e = True
								toJSON = toJSON & "{"
								For Each c In a.Contents
									If e Then e = False Else toJSON = toJSON & ","
									toJSON = toJSON & IIF(QuotedVars, """" & IIF(StrEncode,JSEncode(c),JSEncode__(c)) & """", IIF(StrEncode,JSEncode(c),JSEncode__(c))) & ":" & toJSON(a(c))
								Next
								toJSON = toJSON & "}"
							End If
						ElseIf TypeName(a) = "Dictionary" Then
							g = a.Count
							If g = 0 Then
								toJSON = "{}"
							Else
								e = True
								toJSON = toJSON & "{"
								For Each c In a
									If e Then e = False Else toJSON = toJSON & ","
									toJSON = toJSON & IIF(QuotedVars, """" & IIF(StrEncode,JSEncode(c),JSEncode__(c)) & """", IIF(StrEncode,JSEncode(c),JSEncode__(c))) & ":" & toJSON(a(c))
								Next
								toJSON = toJSON & "}"
							End If
						Else
							e = True
							toJSON = toJSON & "{"
							For Each c In a
								If e Then e = False Else toJSON = toJSON & ","
								toJSON = toJSON & IIF(QuotedVars, """" & IIF(StrEncode,JSEncode(c),JSEncode__(c)) & """", IIF(StrEncode,JSEncode(c),JSEncode__(c))) & ":" & toJSON(a(c))
							Next
							toJSON = toJSON & "}"
						End If
					Case "Cls_AB_JSON"
						e = True
						toJSON = toJSON & IIF(a.Kind, "[", "{")
						For Each c In a.Collection
							If e Then e = False Else toJSON = toJSON & ","
							toJSON = toJSON & IfThen(a.Kind=0, IIF(QuotedVars, """" & IIF(StrEncode,JSEncode(c),JSEncode__(c)) & """", IIF(StrEncode,JSEncode(c),JSEncode__(c))) & ":") & toJSON(a(c))
						Next
						toJSON = toJSON & IIF(a.Kind, "]", "}")
					Case "JScriptTypeInfo"
						If isFile(l) Then
							AB.Use "jsLib"
							Set h = AB.h.New
							h.BasePath = j
							h.Inc(k)
							Set i = h.Object
							toJSON = i.toString(a)
							Set i = Nothing
							Set h = Nothing
						Else
							toJSON = "{}"
						End If
					Case "VBScriptTypeInfo"
						toJSON = "{}"
					Case Else
						toJSON = "{}"
				End Select
			Case 11
				toJSON = IIF(a, "true", "false")
			Case 12, 8192, 8204, 8209
				toJSON = RenderArray(a, 1, "")
			Case 2, 3, 17, 19
				toJSON = CLng(a)
			Case 4, 5, 6, 14
				toJSON = Replace(CDbl(a), ",", ".")
			Case Else
				toJSON = """" & IIF(StrEncode,JSEncode(Cstr(a)),JSEncode__(Cstr(a))) & """"
		End select
		
	End Function
	
	
	function fieldToJson(a,byval b)
		dim c, d,e,f,g
		b = "|" & LCase(b) & "|"
		c = True
		d = d & "{"
		while not a.eof
		For g = 0 To a.Fields.Count-1
			e = a.Fields(g).Name
			f = a.Fields(g).Value
			
			if instr(b,"|"& LCase(e) &"|")>0 then
				If c Then c = False Else d = d & ","
				If QuotedVars Then
					d = d & """" & IIF(StrEncode,JSEncode(e),JSEncode__(e)) & """:" & toJSON(f)
				Else
					d = d & IIF(StrEncode,JSEncode(e),JSEncode__(e)) & ":" & toJSON(f)
				End If
			end if
		Next
		d = d & "}"
		a.movenext:wend:a.close
		d= "["& d &"]"		
		fieldToJson = d
	end function
	
	
	Private Function RenderArray(Byval a, Byval b, Byval c)
		
		Dim d : d = LBound(a, b)
		Dim e : e = UBound(a, b)
		Dim f, g
		Dim h : h = ","
		RenderArray = "["
		For f = d To e
			If f = e Then
				h = ""
			End If
			On Error Resume Next
			g = RenderArray(a, b + 1, c & f & "," )
			If Err = 9 Then
				On Error GoTo 0
				RenderArray = RenderArray & toJSON(Eval("arr(" & c & f & ")")) & h
			Else
				RenderArray = RenderArray & g & "" & h
			End If
		Next
		RenderArray = RenderArray & "]"
	End Function
	
	Public Function JsEncode(ByVal a)
		If isNul(a) Then JsEncode = "" : Exit Function
		Dim b, c, d, e, f, g, h
		b = Array(&h27,&h22,&h5C,&h2F,&h08,&h0C,&h0A,&h0D,&h09)
		c = Array(&h27,&h22,&h5C,&h2F,&h62,&h66,&h6E,&h72,&h749)
		For d = 1 To Len(a)
			g = True
			f = Mid(a, d, 1)
			For e = 0 To Ubound(b)
				If f = Chr(b(e)) Then
					h = h & "\" & Chr(c(e))
					g = False
					Exit For
				End If
			Next
			If g Then
				Dim i
				i = AscW(f)
				If i > 31 And i < 127 Then
					h = h & f
				ElseIf i > -1 Or i < 65535 Then
					h = h & "\u" & String(4 - Len(Hex(i)), "0") & Hex(i)
				End If
			End If
		Next
		JsEncode = h
		
	End Function
	Private Function JsEncode__(ByVal a)
		
		If isNul(a) Then JsEncode__ = "" : Exit Function
		Dim b, c, d, e, f, g, h
		b = Array(&h27,&h22,&h5C,&h2F,&h08,&h0C,&h0A,&h0D,&h09)
		c = Array(&h27,&h22,&h5C,&h2F,&h62,&h66,&h6E,&h72,&h749)
		For d = 1 To Len(a)
			g = True
			f = Mid(a, d, 1)
			For e = 0 To Ubound(b)
				If f = Chr(b(e)) Then
					h = h & "\" & Chr(c(e))
					g = False
					Exit For
				End If
			Next
			If g Then h = h & f
		Next
		JsEncode__ = h
	End Function
	
	Public Function Stringify(Byval a)
		Stringify = toJSON(a)
	End Function

	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Property Get jsString
		jsString = toJSON(Me)
	End Property

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function toObject(Byval a)
		On Error Resume Next
		If Err Then Err.Clear
		Dim b,c : b = 0 : c = 0
		Dim d, e, f, g
		Dim h : h = AB.BasePath & "jsLib/core/"
		Dim i : i = "json2.js"
		Dim j : j = h&i
		Select Case VarType(a)
			Case 9
				Set toObject = a
			Case 8
				Select Case TypeName(a)
					Case "JScriptTypeInfo"
						If isFile(j) Then
							AB.Use "jsLib"
							Set e = AB.e.New
							e.BasePath = h
							e.Inc(i)
							Set f = e.Object
							If IsObject(f.toObject(a)) Then Set toObject = f.toObject(a) Else toObject = f.toObject(a)
							Set f = Nothing
							Set e = Nothing
						Else
							toObject = a
						End If
					Case "String"
						If LCase(a) = "null" Then
							toObject = Null
						ElseIf LCase(a) = "empty" Then
							toObject = Empty
						ElseIf a = "" Or a = """""" Then
							toObject = ""
						ElseIf LCase(a) = "nothing" Then
							Set toObject = Nothing
						ElseIf LCase(a) = "true" Or LCase(a) = "false" Then
							toObject = CBool(a)
						ElseIf isInt(a) Then
							toObject = CLng(a)
						ElseIf Test(a,"double") Then
							toObject = CDbl(a)
						ElseIf Test(a,"date") Then
							toObject = CDate(a)
						Else
							
								
								
								
									
									
									
									
									
									
									
									
								
									
								
								
							
							
							
							AB.Use "Sc"
							Set d = AB.d.New
							d.Lang = "js"
							d.Add "var jsonObject = " & a & ";"
							If IsObject(d.CodeObject.jsonObject) Then Set toObject = d.CodeObject.jsonObject Else Set toObject = Nothing
						End If
					Case Else
						
						If IsObject(Me.jsEval(a)) Then Set g = Me.jsEval(a) Else g = Me.jsEval(a)
						If IsObject(g) Then Set toObject = g Else toObject = g
				End Select
			Case Else
				
				If IsObject(Me.jsEval(a)) Then Set g = Me.jsEval(a) Else g = Me.jsEval(a)
				If IsObject(g) Then Set toObject = g Else toObject = g
		End select
		If Err Then : toObject = a : Err.Clear : End If
		On Error Goto 0
	End Function


	Public Function Parse(Byval a)
		If IsObject(toObject(a)) Then Set Parse = toObject(a) Else Parse = toObject(a)
	End Function

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Sub setJSArrayItem(ByRef a, ByVal b, ByVal c)
		On Error Resume Next
		AB.Use "Sc"
		Dim d : Set d = AB.d.New
		d.Lang = "js"
		d.Add "var itemTemp=null; function setJSArray(arr, index){try { itemTemp = arr[index]; } catch(e) { itemTemp = null; }}"
		d.Run "setJSArray", Array(b, c)
		Set a = d.CodeObject.itemTemp
		If Err.number=0 Then
			Exit Sub
		End If
		a = d.CodeObject.itemTemp
		On Error Goto 0
	End Sub

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function getJSArrayItem(ByVal a, ByVal b)
		On Error Resume Next
		AB.Use "Sc"
		Dim c : Set c = AB.c.New
		c.Lang = "js"
		c.Add "function getJSArray(arr, index){var temp=null; try { temp = arr[index]; } catch(e) {} return temp;}"
		If IsObject(c.Run("getJSArray", Array(a, b))) Then
			Set getJSArrayItem = c.Run("getJSArray", Array(a, b))
		Else
			getJSArrayItem = c.Run("getJSArray", Array(a, b))
		End If
		On Error Goto 0
	End Function

	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function jsEval(Byval a)
		On Error Resume Next
		If Err Then Err.Clear
		Dim b, c, d, e
		AB.Use "Sc"
		Set b = AB.b.New
		b.Lang = "js"
		b.Add "function toEval(str) { var _temp = null; try { eval('_temp = (' + str + ');'); } catch(e) { _temp = null; } return (_temp);}"
		Set d = b.Object
		If IsObject(d.toEval(a)) Then Set jsEval = d.toEval(a) Else jsEval = d.toEval(a)
		Set d = Nothing
		Set b = Nothing
		If Err.Number <> 0 Then : Err.Clear : jsEval = a : End If
		On Error Goto 0
	End Function

	Public Function vbEval(Byval a)
		On Error Resume Next
		If Err Then Err.Clear
		If IsObject(Eval(a)) Then Set vbEval = Eval(a) Else vbEval = Eval(a)
		If Err.Number <> 0 Then : Err.Clear : vbEval = a : End If
		On Error Goto 0
	End Function

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function JSArrayToVBArray(ByVal a)
		On Error Resume Next
		Dim b, c
		If TypeName(a) = "JScriptTypeInfo" Then
			b = a.join("{@Lx.Split@}")
			c = Split(b, "{@Lx.Split@}")
		End If
		JSArrayToVBArray = c
		On Error Goto 0
	End Function

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function VBArrayToJSArray(ByVal a)
		On Error Resume Next
		AB.Use "Sc"
		Dim b : Set b = AB.Sc.New
		b.Lang = "js"
		Dim c : Set c = b.Modules.Add("NewModule")
		c.AddCode "function jsVBArrayToJSArray(vbArr){ var temp = new VBArray(vbArr); return temp.toArray(); }"
		Dim d : Set d = c.CodeObject
		If IsObject(d.jsVBArrayToJSArray(a)) Then
			Set VBArrayToJSArray = d.jsVBArrayToJSArray(a)
		Else
			VBArrayToJSArray = d.jsVBArrayToJSArray(a)
		End If
		On Error Goto 0
	End Function

	
	
	
	
	
	
	
	
	
	

	Public Sub Flush
		Response.Clear()
		Response.Charset = s_charset
		Response.ContentType = "application/json"
		NoCache()
		If TypeName(Response) <> "Empty" Then
			Put jsString
		ElseIf WScript <> Empty Then
			WScript.Echo(jsString)
		End If
	End Sub

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function Clone
		Set a = ColClone(Me)
	End Function

	
	
	
	
	
	
	
	
	
	
	
	
	
	

	Public Function jsObject
		Set a = AB.Json.New(0)
	End Function

	
	
	
	
	
	
	
	
	
	
	

	Public Function jsArray
		Set a = AB.Json.New(1)
	End Function

	
	
	
	
	
	
	
	
	
	
	
	

	Public Function toStr(Byval a)
		toStr = AB.Json.toJSON(a)
	End Function

	
	
	
	
	
	
	
	
	
	
	
	

	Public Function QueryToJSON(Byval a, Byval b)
		On Error Resume Next
		Dim c, d, e, f
		Set d = jsArray()
		If Not IsObject(a) Or TypeName(a)<>"Connection" Then:Err.Clear:Set QueryToJSON=d:Exit Function:End If
		Set c = a.Execute(b)
		If Err.Number<>0 Then : Err.Clear : Set QueryToJSON = d : Exit Function : End If
		Dim g : g = 0
		Do While Not (c.EOF Or c.BOF)
			Set f = jsObject()
			d(g) = f
			For Each e In c.Fields
				d(g)(e.Name) = e.Value
			Next
			g = g + 1
			Set f = Nothing
			c.MoveNext
		Loop
		c.Close : Set c = Nothing
		Set QueryToJSON = d
		On Error Goto 0
	End Function



	Private Function ColClone(Byval a)
		Dim b, c
		Set b = new Cls_AB_JSON
		b.Kind = a.Kind
		For Each c In a.Collection
			If IsObject(a(c)) Then
				Set b(c) = ColClone(a(c))
			Else
				b(c) = a(c)
			End If
		Next
		Set ColClone = b
	End Function



	Private Function Escape__(Byval a)
		Dim b, c, d
		b = &h22
		c = &h5C
		d = &h2F
		Dim e, f, g
		For e = 1 To (Len(a))
			f = Mid(a, e, 1)
			If AscW(f) > &h00 and AscW(f) < &h1F Then
				f = EscapeQuence(f)
			ElseIf AscW(f) >= &hC280 and AscW(f) <= &hC2BF Then
				f = "\u00" + Right(padLeft(hex(AscW(f) - &hC200), 2, 0), 2)
			ElseIf AscW(f) >= &hC380 and AscW(f) <= &hC3BF Then
				f = "\u00" + Right(padLeft(hex(AscW(f) - &hC2C0), 2, 0), 2)
			Else
				Select Case AscW(f)
					Case b: f = EscapeQuence(f)
					Case c: f = EscapeQuence(f)
					Case d: f = EscapeQuence(f)
				End Select
			End If
			g = g & f
		Next
		Escape__ = g
	End Function
	Private Function EscapeQuence(Byval a)
		EscapeQuence = "\u00" + Right(padLeft(hex(AscW(a)), 2, 0), 2)
	End Function
	Private Function padLeft(Byval a, Byval b, Byval c)
		padLeft = Right(cloneIt(c, b) & a, b)
	End Function
	private Function cloneIt(Byval a, Byval b)
		Dim c:For c = 1 To b : cloneIt = cloneIt & a : Next
	End Function

End Class
%>

