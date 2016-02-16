<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-01-20
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
dIM aSPd, aSPhELpTItLE, aSPhELpCOnTEnT
sET aSPd = cREaTEoBJeCT("Scripting.Dictionary")
aSPd.aDD "Abs", "返回数字的绝对值"
aSPd.aDD "Sqr", "返回数值表达式的平方根"
aSPd.aDD "Sgn", "返回表示数字符号的整数"
aSPd.aDD "Rnd", "返回一个随机生成的数字"
aSPd.aDD "Log", "返回指定数值的自然对数"
aSPd.aDD "Exp", "返回e的指定次幂"
aSPd.aDD "Sin", "返回指定弧度的正弦值"
aSPd.aDD "Cos", "返回指定弧度的余弦值"
aSPd.aDD "Tan", "返回指定弧度的正切值"
aSPd.aDD "Atn", "返回指定数值的反正切值"
aSPd.aDD "Int", "返回指定数字的整数部分"
aSPd.aDD "Round", "对参数按指定的位数进行四舍五入"
aSPd.aDD "Fix", "返回指定数值的整数部分"
aSPd.aDD "Now", "返回当前的日期时间"
aSPd.aDD "Date", "返回当前的系统日期"
aSPd.aDD "Time", "返回当前的系统时间"
aSPd.aDD "Year", "从指定的表达式中提取年份"
aSPd.aDD "Month", "从指定的表达式中提取月份"
aSPd.aDD "Day", "从指定表达式中提取日期"
aSPd.aDD "Hour", "从指定的表达式中提取整点值"
aSPd.aDD "Minute", "从指定的表达式中提取分钟数"
aSPd.aDD "Second", "从指定的表达式中提取秒数"
aSPd.aDD "DateAdd", "将指定日期添加上指定时间间隔并返回新值"
aSPd.aDD "DateDiff", "计算两个日期之间的时间间隔"
aSPd.aDD "DatePart", "返回给定日期中的某一部分"
aSPd.aDD "DateSerial", "根据提供的年月日的数值返回一个Date子类型的数据"
aSPd.aDD "DateValue", "将指定的字符串转化为Date子类型的数据"
aSPd.aDD "MonthName", "根据指定的数字返回代表该月份的字符串"
aSPd.aDD "Weekday", "返回代表一周中某一天的整数"
aSPd.aDD "WeekdayName", "根据周次返回代表该周次的字符串"
aSPd.aDD "TimeSerial", "根据提供的时分秒的数值返回一个Date子类型的数据"
aSPd.aDD "TimeValue", "将指定的字符串转化为Date子类型的数据"
aSPd.aDD "CBool", "将表达式转化为Boolean子类型"
aSPd.aDD "CByte", "将表达式转化为Byte子类型"
aSPd.aDD "CDbl", "将表达式转化为Double子类型"
aSPd.aDD "Chr", "将ANSI字符代码（～）转化为对应的字符"
aSPd.aDD "CInt", "将表达式转化为Integer数值子类型"
aSPd.aDD "CLng", "将表达式转化为Long数值子类型"
aSPd.aDD "Cstr", "将表达式转化为String子类型"
aSPd.aDD "CCur", "将表达式转化为Currency子类型"
aSPd.aDD "CDate", "将日期表达式转化为Date子类型"
aSPd.aDD "CSng", "将表达式转化为Single数值子类型"
aSPd.aDD "Asc", "返回与字符串首字母相对应的ANSI字符代码（～）"
aSPd.aDD "Oct", "返回八进制的字符串"
aSPd.aDD "Hex", "返回十六进制的字符串"
aSPd.aDD "FormatNumber", "格式化指定的数值表达式"
aSPd.aDD "FormatDateTime", "格式化指定的日期时间表达式"
aSPd.aDD "FormatCurrency", "格式化指定的货币表达式"
aSPd.aDD "FormatPercent", "格式化某一数值为百分数"
aSPd.aDD "IsArray", "判断某一变量是否为数组变量"
aSPd.aDD "IsDate", "判断某一变量是否为或者可以转化为日期表达式"
aSPd.aDD "IsEmpty", "判断变量是否为空"
aSPd.aDD "IsNull", "判断表达式中是否包含有效数据"
aSPd.aDD "IsNumeric", "判断表达式的值是否为数字"
aSPd.aDD "Is_object_", "判断表达式的值是否为某一对象"
aSPd.aDD "VarType", "返回指定变量的子类型"
aSPd.aDD "TypeName", "返回指定变量子类型的信息"
aSPd.aDD "MsgBox", "弹出含有提示信息的对话框"
aSPd.aDD "InputBox", "弹出可输入数据的对话框"
aSPd.aDD "ScriptEngine", "返回一个代表当前所使用的脚本语言的字符串"
aSPd.aDD "ScriptEngineBuildVersion", "返回所使用的脚本引擎的编译版本号"
aSPd.aDD "ScriptEngineMajorVersion", "返回所使用的脚本引擎的主版本号"
aSPd.aDD "ScriptEngineMinorVersion", "返回所使用脚本引擎的次版本号"
aSPd.aDD "Array", "利用所给的参数返回一个数组"
aSPd.aDD "UBound", "返回数组的最大可用下标"
aSPd.aDD "LBound", "返回数组的最小可用下标"
aSPd.aDD "Filter", "返回一个数组其中包含了满足条件的字符串"
aSPd.aDD "InStr", "返回某字符串在指定字符串中第一次出现的位置"
aSPd.aDD "InStrRev", "返回某字符串在指定字符串中从结尾算起的出现位置"
aSPd.aDD "Join", "将数组中的字符串连接为一个字符串"
aSPd.aDD "LCase", "将字符串中的字母全部转换为小写形式"
aSPd.aDD "Left", "从字符串的左端取指定数目的字符"
aSPd.aDD "Len", "返回字符串的长度或者存储某一变量所需要的字节数"
aSPd.aDD "Ltrim", "返回不带前导空格的字符串"
aSPd.aDD "Replace", "将字符串中指定字符串替换为其他内容"
aSPd.aDD "Right", "从字符串的右侧获取指定数目的字符"
aSPd.aDD "Rtrim", "删除字符串的后续空格"
aSPd.aDD "Mid", "从字符串中指定位置获取指定长度的字符串"
aSPd.aDD "Split", "返回包含指定数目子字符串的一维数组"
aSPd.aDD "StrComp", "对两个指定的字符串进行比较"
aSPd.aDD "StrReverse", "将指定字符串倒序排列并返回重新排列后的字符串"
aSPd.aDD "String", "返回由指定数目的某一字符组成的字符串"
aSPd.aDD "Trim", "删除字符串的前导和后续空格"
aSPd.aDD "Space", "返回由指定数目的空格组成的字符串"
aSPd.aDD "UCase", "将字符串中的字母全部转换为大写形式"
aSPd.aDD "LoadPicture", "返回一个图片对象"
aSPd.aDD "Create_object_", "创建并返回一个对象"
aSPd.aDD "Get_object_", "从指定文件中获得一个Automation对象"
aSPd.aDD "RGB", "返回代表某一颜色的整数"
aSPhELpTItLE = aSPd.kEYs
aSPhELpCOnTEnT = aSPd.iTEmS
fUNcTIoN aSPhELpTIp(bYVaL a, bYVaL b)
dIM c, d, e
fOR c = 0 tO aSPd.cOUnT - 1
iF lCAsE(aSPhELpTItLE(c)) = lCAsE(a) tHEn
iF lCAsE(a) = "chr" tHEn
d = lEFt(b, iNStR(b, ")") - 1)
d = rEPlACe(d, "(", "")
e = vBCrLF & "Chr(" & d & ")="
iF cHEcKNuMBeR(d) = tRUe tHEn
iF d = "10" oR d = "13" tHEn
e = e & "(回车键)"
eLSeIF d = "32" tHEn
e = e & "(空格)"
eLSeIF d = "0" tHEn
e = e & "(中断程序,停止执行)"
eLSe
e = e & "(" & cHR(d) & ")"
eND iF
e = rEPlACe(e, "'", "&#x27;")
eLSe
e = e & d
eND iF
eND iF
aSPhELpTIp = aSPhELpCOnTEnT(c) & e
eXIt fOR
eND iF
nEXt
eND fUNcTIoN
fUNcTIoN hANdLEwRItE(a)
dIM b
b = lEFt(a, lEN(a) - 1)
b = rIGhT(b, lEN(b) - 1)
b = lCAsE(tRIm(b))
iF b = "adodb.connection" tHEn
a = """Adodb.Connection"""
eLSeIF b = "adodb.recordset" tHEn
a = """Adodb.RecordSet"""
eND iF
hANdLEwRItE = a
eND fUNcTIoN
fUNcTIoN jIAnTItABfANtI(a, b, c)
dIM d, e, f, g, h, i, j
j = gETfTExT(a) & vBCrLF
c = cSTr(c)
d = sTRcUT(j, "简体" & vBCrLF, vBCrLF, 2)
e = sTRcUT(j, "繁体" & vBCrLF, vBCrLF, 2)
iF 1 = 2 tHEn
iF lEN(b) * 2 < lEN(d) tHEn
fOR h = 1 tO lEN(b)
i = mID(b, h, 1)
iF c = "2" aND iNStR(d, i) > 0 tHEn
f = mID(d, iNStR(d, i), 1)
g = mID(e, iNStR(d, i), 1)
b = rEPlACe(b, f, g)
cALl eCHo("", "")
eLSeIF iNStR(e, i) > 0 tHEn
f = mID(d, iNStR(e, i), 1)
g = mID(e, iNStR(e, i), 1)
b = rEPlACe(b, g, f)
eND iF
nEXt
jIAnTItABfANtI = b
eXIt fUNcTIoN
eND iF
eND iF
fOR h = 1 tO lEN(d)
f = mID(d, h, 1)
g = mID(e, h, 1)
iF c = "2" tHEn
b = rEPlACe(b, f, g)
eLSe
b = rEPlACe(b, g, f)
eND iF
nEXt
jIAnTItABfANtI = b
eND fUNcTIoN
fUNcTIoN jIYiCIrEPlACe(a, b)
dIM c, d, e, f, g
c = sPLiT(gETfTExT(a), vBCrLF)
fOR eACh f iN c
iF iNStR(f, ",") aND lEFt(tRIm(f), 1) <> "#" tHEn
d = sPLiT(f, ",")
iF uBOuND(d) >= 1 tHEn
b = rEPlACe(b, d(0), d(1))
eND iF
eND iF
nEXt
jIYiCIrEPlACe = b
eND fUNcTIoN
fUNcTIoN cIRePLaCE(a, b)
dIM c, d, e, f, g
c = sPLiT(a, vBCrLF)
fOR eACh f iN c
iF iNStR(f, ",") aND lEFt(tRIm(f), 1) <> "#" tHEn
d = sPLiT(f, ",")
iF uBOuND(d) >= 1 tHEn
b = rEPlACe(b, d(0), d(1))
eND iF
eND iF
nEXt
cIRePLaCE = b
eND fUNcTIoN
%>


