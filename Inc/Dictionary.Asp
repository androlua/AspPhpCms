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



Dim AspD, AspHelpTitle, AspHelpContent
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
AspHelpTitle = AspD.keys
AspHelpContent = AspD.Items

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

Function HandleWrite(a)
	Dim b
	b = Left(a, Len(a) - 1)
	b = Right(b, Len(b) - 1)
	b = LCase(Trim(b))
	If b = "adodb.connection" Then
		a = """Adodb.Connection"""
	ElseIf b = "adodb.recordset" Then
		a = """Adodb.RecordSet"""
	End If
	HandleWrite = a
End Function


Function JianTiTabFanTi(a, b, c)
	Dim d, e, f, g, h, i, j
	j = GetFText(a) & vbCrlf
	c = Cstr(c)
	d = StrCut(j, "简体" & vbCrlf, vbCrlf, 2)
	e = StrCut(j, "繁体" & vbCrlf, vbCrlf, 2)
	If 1 = 2 Then
		If Len(b) * 2 < Len(d) Then
			For h = 1 To Len(b)
				i = Mid(b, h, 1)
				
				If c = "2" And InStr(d, i) > 0 Then
					f = Mid(d, InStr(d, i), 1)
					g = Mid(e, InStr(d, i), 1)
					b = Replace(b, f, g)
					Call Echo("", "")
				ElseIf InStr(e, i) > 0 Then
					f = Mid(d, InStr(e, i), 1)
					g = Mid(e, InStr(e, i), 1)
					b = Replace(b, g, f)
				End If
			Next
			JianTiTabFanTi = b
			Exit Function
		End If
	End If
	For h = 1 To Len(d)
		f = Mid(d, h, 1)
		g = Mid(e, h, 1)
		
		If c = "2" Then
			b = Replace(b, f, g)
		Else
			b = Replace(b, g, f)
		End If
	Next
	JianTiTabFanTi = b
End Function

Function JiYiCiReplace(a, b)
	Dim c, d, e, f, g
	c = Split(GetFText(a), vbCrlf)
	For Each f In c
		If InStr(f, ",") And Left(Trim(f), 1) <> "#" Then
			d = Split(f, ",")
			If UBound(d) >= 1 Then
				b = Replace(b, d(0), d(1))
			End If
		End If
	Next
	JiYiCiReplace = b
End Function

Function CiReplace(a, b)
    Dim c, d, e, f, g
    c = Split(a, vbCrLf)
    For Each f In c
        If InStr(f, ",") And Left(Trim(f), 1) <> "#" Then
            d = Split(f, ",")
            If UBound(d) >= 1 Then
                b = Replace(b, d(0), d(1))
            End If
        End If
    Next
    CiReplace = b
End Function

%>



