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

Class dllSoftSafe



	private FrmName						
	
	
	Private Sub Class_Initialize()
		
	End Sub
	
	Private Sub Class_Terminate()
	
	End Sub
	
	Public Property Let setFrmName(Str)
		 FrmName=Str
	End Property
	
	Public Property Get getFrmName()
		getFrmName = FrmName
	End Property
	
	
	function isAccessPass(byval a,b)
		isAccessPass=false
        If CheckFile(a) = False Then
            Call MBInfo("出错", "没有数据库"): Exit function
        End If

        b = FileCreateDate(a)
        b = Format_Time(b, 4) & "313801120"
        If (CheckAccessPass(a, b)) = False Then
            Call MBInfo("出错", "数据库密码错误" & b): Exit function
        End If
		isAccessPass=true
	end function


	Function CheckFile(ByVal a)
		On Error Resume Next
		Dim b
		Call HandlePath(a)
		Set b = CreateObject("Scripting.FileSystemObject")
			CheckFile = b.FileExists(a)
		Set b = Nothing
		If Err Then doError Err.Description, "CheckFile 检查文件 函数出错，FileName=" & a
	End Function
	Function FileCreateDate(a)
		FileCreateDate = GetFileCreateDate(a)
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
	Function CheckAccessPass(a, b)
		On Error Resume Next
		Dim c
		CheckAccessPass = True
		Set c = CreateObject("Adodb.Connection")
			c.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & b & "';Data Source = " & a
			c.Close
			If Err <> 0 Then
				Err.Clsoe
				CheckAccessPass = False
			End If
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
	Function GetFileCreateDate(ByVal a)
		On Error Resume Next
		Dim b, c
		Call HandlePath(a)
		Set b = CreateObject("Scripting.FileSystemObject")
			If b.FileExists(a) = True Then
				Set c = b.GetFile(a)
					GetFileCreateDate = c.DateCreated
				Set c = Nothing
			End If
		Set b = Nothing
		If Err Then doError Err.Description, "GetFileCreateDate 获得文件创建时间 函数出错，FileName=" & a
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
	Function Rw(a)
		Response.Write(a)
	End Function
	Function MsgBox(ByVal a)
		a = Replace(Replace(a, Chr(10), "\n"), Chr(13), "\n")
		Response.Write("<script>alert('" & a & "');</script>")
	End Function
	function MBInfo(a, b)
		MBInfo = MsgBox(a)
	End function
End Class


Dim testOBJ : Set testOBJ = New dllSoftSafe	
dim AccessPass



select case request("act")
	case "handle" : call testOBJ.rw(testOBJ.isAccessPass(request("MDBPath"),AccessPass))
	case else:Default()
end select


sub Default()
%>
<form id="form1" name="form1" method="post" action="?act=handle">
  发送内容
  <input name="MDBPath" type="text" id="MDBPath" value="<%="\VB工程\Data\Access.Mdb"%>" />
  <input type="submit" name="button" id="button" value="提交" />
</form>
<%end sub%>

