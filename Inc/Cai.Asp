<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-03-11
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered by ASPPHPCMS 
'************************************************************
%>
<% 
'Cai采集内容(2014)

'获得采集内容
Function getHttpPage(ByVal HttpUrl, ByVal Char_Set)
    getHttpPage = handleGetHttpPage(HttpUrl, Char_Set)(0) 
End Function 
'处理获得采集内容
Function handleGetHttpPage(ByVal HttpUrl, ByVal Char_Set)
    On Error Resume Next 
    Dim startTime, nStatus, nTime, content, splType, webFileSize 
    startTime = Now()
    Char_Set = handleStrCharSet(Char_Set) 
    If IsNull(HttpUrl) = True Or Len(HttpUrl) < 18 Or HttpUrl = "$False$" Then
        handleGetHttpPage = "$False$" 
        Exit Function 
    End If
    Dim Http 
    Set Http = CreateObject("MSXML2.XMLHTTP")
        Call Http.Open("GET", HttpUrl, False) 
        Http.send 
        If Http.readyState <> 4 Then
            Set Http = Nothing 
            handleGetHttpPage = "$False$" 
            Exit Function 
        End If 

        content = BytesToBstr(Http.responseBody, Char_Set) 
        nStatus = Http.Status 
        nTime = DateDiff("s", startTime, Now()) 
        webFileSize = strLength(content) 

        splType = "|-*ypia=|" 
        handleGetHttpPage = Split(content & splType & nStatus & splType & nTime & splType & webFileSize, splType) 

    Set Http = Nothing 
End Function 

'获得采集内容 (辅助)
Function getURLContent(HttpUrl, Char_Set)
    getURLContent = getHttpPage(HttpUrl, Char_Set) 
End Function 
'获得采集内容 (辅助)
Function getHttpUrl(HttpUrl, Char_Set)
    getHttpUrl = getHttpPage(HttpUrl, Char_Set) 
End Function 
Function bytesToBstr(body, Cset)
    Dim ObjStream 
    If isNul(body) Then Exit Function                                               '为空则退出
    Set ObjStream = CreateObject("ADODB.Stream")
        ObjStream.Type = 1 
        ObjStream.Mode = 3 
        ObjStream.Open 
        Call ObjStream.Write(body) 
        ObjStream.Position = 0 
        ObjStream.Type = 2 
        ObjStream.Charset = Cset 
        bytesToBstr = ObjStream.ReadText 
        ObjStream.Close 
    Set ObjStream = Nothing 
End Function 
'截取字符串 更新20160114
'c=[A]abbccdd[/A]
'0=abbccdd
'1=[A]abbccdd[/A]
'3=[A]abbccdd
'4=abbccdd[/A]
'截取字符串
Function strCut(ByVal content, ByVal startStr, ByVal endStr, ByVal cutType)
    Dim s1, s1Str, s2, s3, c,tempContent,tempStartStr,tempEndStr
	tempStartStr=startStr
	tempEndStr=endStr
	tempContent=content
	cutType="|"& cutType &"|"
	'不区分大小写
	if instr(cutType,"|lu|")>0 then
		content=lcase(content)
		startStr=lcase(startStr)
		endStr=lcase(endStr)
	end if
    If InStr(content, startStr) = False Or InStr(content, endStr) = False Then
        c = "" 
        Exit Function 
    End If 
	if instr(cutType,"|1|")>0 then
            s1 = InStr(content, startStr) 
            s1Str = Mid(content, s1 + Len(startStr)) 
            s2 = s1 + InStr(s1Str, endStr) + Len(startStr) + Len(endStr) - 1 '为什么要减1
	else
            s1 = InStr(content, startStr) + Len(startStr) 
            s1Str = Mid(content, s1) 
            'S2 = InStr(S1, content, EndStr)
            s2 = s1 + InStr(s1Str, endStr) - 1 
    end if
    s3 = s2 - s1 
    If s3 >= 0 Then
        c = Mid(tempContent, s1, s3)
    Else
        c = "" 
    End If 
    if instr(cutType,"|3|")>0 then
        c = tempStartStr & c 
    End If 
    if instr(cutType,"|4|")>0 then
        c = c & tempEndStr 
    End If 
    strCut = c  
End Function 
'获得截取内容,20150305
Function getStrCut(ByVal content, ByVal startStr, ByVal endStr, ByVal CutType)
     getStrCut = strCut(content, startStr, endStr, CutType) 
End Function 
'接取字符 CutStr(Content,22,"null")
Function cutStr(ByVal content, ByVal CutNumb, ByVal MoreStr)
    Dim i, s, n 
    n = 0 
    CutNumb = CInt(CutNumb)                                                         '转换成数字类型    追加于20141107
    If MoreStr = "" Then MoreStr = "..." 
    If LCase(MoreStr) = "none" Or LCase(MoreStr) = "null" Then MoreStr = "" 
    cutStr = content 
    For i = 1 To Len(content)
        s = Asc(Mid(CStr(content), i, 1)) 
        If s < 0 Then s = s + 65536 
        If s < 255 Then n = n + 1 
        If s > 255 Then n = n + 2 
        If n >= CutNumb Then cutStr = Left(content, i) & MoreStr : Exit Function 
    Next 
End Function 
'截取内容，不区分大小写 20150327  C=CutStrNOLU(c,"<heAd",">")
Function cutStrNOLU(content, startStr, endStr)
    Dim s, LCaseContent, nStartLen, nEndLen, NewStartStr 
    startStr = LCase(startStr) 
    endStr = LCase(endStr) 
    LCaseContent = LCase(content) 

    If InStr(LCaseContent, startStr) > 0 Then
        nStartLen = InStr(LCaseContent, startStr) 
        s = Mid(content, nStartLen) 
        LCaseContent = Mid(s, Len(startStr) + 1) 
        NewStartStr = Mid(s, 1, Len(startStr) + 1)                                      '获得开始字符

        LCaseContent = Replace(LCaseContent, "<", "&lt;") 
        'Call eerr("111",LCaseContent)

        nEndLen = InStr(LCaseContent, endStr) 
        Call echo("nEndLen", nEndLen) 

        s = Mid(content, nStartLen, nEndLen + Len(startStr)) 
        'Call Echo(nStartLen,nEndLen)
        'Call Echo("S",S)
        cutStrNOLU = s 
    End If 
End Function 

'接取TD字符
Function setCutTDStr(ByVal content, ByVal TDWidth, ByVal MoreColor)
    Dim i, s, c, n, EndNumb, YesMore 
    content = CStr(content & "") 
    If content = "" Then setCutTDStr = content : Exit Function 
    If TDWidth = "" Then setCutTDStr = content : Exit Function                      'TDWidth为空，则为自动
    n = 0 : YesMore = False 
    EndNumb = Int(TDWidth / 6.3) 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If n >= EndNumb Then
            YesMore = True 
            Exit For 
        Else
            c = c & s 
        End If 
        If Asc(s) < 0 Then
            n = n + 2 
        Else
            n = n + 1 
        End If 
    Next 
    If YesMore = True Then
        '需要处理Title标题的HTML
        c = "<span Title=""" & showHTMLCode(content) & """ style=""background-color:" & MoreColor & ";"">" & c & "</span>" 
    End If 
    setCutTDStr = c 
End Function 
'接取TD字符 (辅助)
Function cutTDStr(content, TDWidth)
    cutTDStr = setCutTDStr(content, TDWidth, "#FBE3EF") 
End Function 
'分割字符
Function getArrayList(ByVal content, ByVal startStr, ByVal endStr, ByVal StartType, ByVal EndType, ByVal SType)
    'on error resume next
    If IsNull(content) = True Or IsNull(startStr) = True Or IsNull(endStr) = True Then
        getArrayList = "" 
        Exit Function 
    End If 
    Dim c, Rep, Matches, TheMatch 
    content = Replace(Replace(content, Chr(10), "【换行】"), Chr(13), "【换行】") '替换掉换行
    Set Rep = CreateObject("VBscript.RegExp")
        Rep.IgnoreCase = True 
        Rep.Global = True 
        Rep.pattern = "(" & startStr & ").+?(" & endStr & ")" 
        Set Matches = Rep.Execute(content)
            For Each TheMatch In Matches
                c = c & "$Array$" & TheMatch.Value 
            Next 
        Set Matches = Nothing 
        If c = "" Then
            getArrayList = "" 
            Exit Function 
        End If 
        c = Right(c, Len(c) - 7) 
        If StartType = False Then
            Rep.pattern = startStr 
            c = Rep.Replace(c, "") 
        End If 
        If EndType = False Then
            Rep.pattern = endStr 
            c = Rep.Replace(c, "") 
        End If 
    Set Rep = Nothing 
    If SType = "1" Or SType = "去掉字符" Or SType = True Then
        c = Replace(c, """", "") 
        c = Replace(c, "'", "") 
        c = Replace(c, " ", "") 
        c = Replace(c, "(", "") 
        c = Replace(c, ")", "") 
    End If 
    getArrayList = c 
End Function 
'分割字符 不处理字符 (辅助)
Function getArray(content, startStr, endStr, StartType, EndType)
    getArray = getArrayList(content, startStr, endStr, StartType, EndType, "") 
End Function 
'分割字符 去掉字符 (辅助)
Function getArray1(content, startStr, endStr, StartType, EndType)
    getArray1 = getArrayList(content, startStr, endStr, StartType, EndType, "去掉字符") 
End Function 
'截取指定分割值
Function getSplit(ByVal content, ByVal splStr, ByVal n)
    Dim splxx 
    splxx = Split(content, splStr) 
    getSplit = splxx(n) 
End Function 
'获得分数总数
Function getSplitCount(ByVal content, ByVal splStr)
    Dim splxx 
    splxx = Split(content, splStr) 
    getSplitCount = UBound(splxx) 
    If getSplitCount > 0 Then getSplitCount = getSplitCount + 1                     '不为空加一
End Function 

'代理 因为它不能与VB软件共存
Function agent(ByVal HttpUrl)
    'On Error Resume Next
    Server.ScriptTimeout = 999 
    '----------
    '获取远程数据
    Dim http 
    Set http = CreateObject("WinHttp.WinHttpRequest.5.1")

        http.Open "GET", HttpUrl, False 
        If Request.ServerVariables("HTTP_REFERER") <> "" Then
            http.SetRequestHeader "Referer", Request.ServerVariables("HTTP_REFERER") 
        End If 
        If Request.Cookies <> "" Then
            http.SetRequestHeader "Cookie", Request.Cookies 
        End If 
        http.SetRequestHeader "User-Agent", Request.ServerVariables("HTTP_USER_AGENT") 
        http.SetRequestHeader "X-Forwarded-For", Request.ServerVariables("REMOTE_ADDR") & ", " & Request.ServerVariables("LOCAL_ADDR") 
        http.SetRequestHeader "Connection", "Close" 
        http.SetRequestHeader "Nuclear-Atk", "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME") & "?" & Request.QueryString 
        http.SetRequestHeader "Nuclear-Atk-Host", Request.ServerVariables("HTTP_HOST") 
        http.send 

        Response.Status = http.Status & " " & http.StatusText                           '照搬远程HTTP状态码与状态描述文本
        Response.ContentType = http.GetResponseHeader("Content-Type")                   '照搬远程内容类型
        Response.BinaryWrite http.responseBody                                          '输出二进制内容
End Function

%>  

