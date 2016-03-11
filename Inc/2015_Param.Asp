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


'http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList    从这里面获得最新设置



'**************************************** 给php用 通用 ****************************************

'替换参数值 2014  12 01
Function newReplaceValueParam(content, paramName, replaceStr)
    Dim startStr, endStr, labelStr, nLen, nTimeFormat, delHtmlYes, trimYes 
    'ReplaceStr = ReplaceStr & "这里面放上内容在这时碳呀。"
    'ReplaceStr = CStr(ReplaceStr)            '转成字符类型
    If isNul(replaceStr) = True Then replaceStr = "" 

    startStr = "[$" & paramName : endStr = "$]" 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        labelStr = strCut(content, startStr, endStr, 1) 
        '删除Html
        delHtmlYes = RParam(labelStr, "DelHtml")                                        '是否删除Html
        If delHtmlYes = "true" Then replaceStr = Replace(delHtml(replaceStr), "<", "&lt;") 'HTML处理
        '删除两边空格
        trimYes = RParam(labelStr, "Trim")                                              '是否删除两边空格
        If trimYes = "true" Then replaceStr = trimVbCrlf(replaceStr) 

        '截取字符处理
        nLen = RParam(labelStr, "Len")                                                  '字符长度值
        nLen = handleNumber(nLen) 
        'If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        If nLen <> "" Then replaceStr = cutStr(replaceStr, nLen, "...")                 'Left(ReplaceStr,nLen)

        '时间处理
        nTimeFormat = RParam(labelStr, "Format_Time")                                   '时间处理值
        If nTimeFormat <> "" Then
            replaceStr = format_Time(replaceStr, nTimeFormat) 
        End If 
        content = Replace(content, labelStr, replaceStr) 

    End If 
    newReplaceValueParam = content 
End Function 

'根据标签找到对应内容
Function newRParam(dataCode, action, ModuleName)
    Dim defaultStr, startStr, endStr 
    defaultStr = RParam(action, ModuleName) 
    startStr = "<!--#" & defaultStr & " start#-->" 
    endStr = "<!--#" & defaultStr & " end#-->" 

    If defaultStr <> "" Then
        '判断是否存在
        If InStr(dataCode, startStr) > 0 And InStr(dataCode, endStr) > 0 Then
            defaultStr = strCut(dataCode, startStr, endStr, 2) 
        Else
            startStr = "<!--#" & defaultStr 
            endStr = "#-->" 
            If InStr(dataCode, startStr) > 0 And InStr(dataCode, endStr) > 0 Then
                defaultStr = strCut(dataCode, startStr, endStr, 2) 

            'Call Echo("有","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
            End If 
        End If 
    End If 
    newRParam = defaultStr 
End Function 




'**************************************** 给php用 通用 **************************************** end






'运行全部动作(20150827)
Function getContentAllRunStr(content)
    Dim splStr, s, c 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        s = Replace(Replace(s, Chr(10), ""), Chr(13), "") '奇怪为什么 s里会有 chr(10)与chr(13) 呢？
        c = c & handleContentCode(s, "") 
    Next 
    getContentAllRunStr = c 
End Function 

'获得内容运行后字符  用法 len(aaaa)  没双引单引
Function getContentRunStr(ByVal content)
    getContentRunStr = handleContentCode(content, "") 
End Function 
'处理内容里有""，则给它删除掉20150329
'检测内容运行后字符
Function checkContentRunStr(ByVal content)
    checkContentRunStr = handleContentCode(content, "check") 
End Function 
'处理双引号
Function handleDoubleQuotation(ByVal s)
    Dim NewS 
    NewS = PHPTrim(s) 
    If Left(NewS, 1) = """" And Right(NewS, 1) = """" Then
        s = Mid(NewS, 2, Len(NewS) - 2) 
    End If 
    handleDoubleQuotation = s 
End Function 
'辅助上面
Function strDQ(ByVal s)
    strDQ = handleDoubleQuotation(s) 
End Function 
'处理成数据 20150330
Function handleToArray(content)
    Dim splStr, i 
    content = strCut(content, "(", ")", 2) 
    'Call Rw(Content)
    splStr = Split(content, ",") 
    'Call Rw("<hr>")
    For i = 0 To UBound(splStr)
        splStr(i) = strDQ(splStr(i)) 
    'Call Echo(I,SplStr(I))
    Next 
    handleToArray = splStr 
End Function 
'处理内容里代码 引擎20150324   http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList  获得最新    version 1.0
Function handleContentCode(ByVal content, sType)
    Dim startStr, endStr, s, YunStr, splStr, splxx, SplContent 
    Dim LabelName                                                                   '标签名称
    Dim nStartStr                                                                   '开始字符

    Dim ContentLCase                                                                '定义内容小写
    ContentLCase = LCase(content)                                                   '内容小写

    If sType = "check" Or sType = "检测" Then
        handleContentCode = False 
    End If 

    '系统自带 不可删除
    SplContent = SplContent & "|now|date|len|left|right|mid|lcase|ucase|ltrim|rtrim|trim|" 


    splStr = Split(SplContent, "|") 
    For Each LabelName In splStr
        If LabelName <> "" Then
            startStr = LCase(LabelName & "(") : endStr = ")" 
            nStartStr = InStr(" " & ContentLCase, " " & startStr) 
            If nStartStr > 0 And InStr(ContentLCase, endStr) > 0 Then
                If sType = "check" Or sType = "检测" Then
                    handleContentCode = True                 '为检测 有函数  退出
                    Exit Function 
                End If 
                Exit For 
            End If 
        End If 
    Next 
    If LabelName = "" Then
        If sType <> "check" And sType <> "检测" Then
            handleContentCode = content 
        End If 
        Exit Function 
    End If 

    LabelName = LCase(LabelName)                                                    '小写

    startStr = LabelName & "(" : endStr = ")" 
    nStartStr = InStr(ContentLCase, startStr) 
    '记录查的原值，不分大小写
    YunStr = Mid(content, InStr(ContentLCase, startStr)) 
    YunStr = Mid(YunStr, 1, InStrRev(YunStr, endStr)) 

    s = Mid(content, InStr(ContentLCase, startStr) + Len(startStr)) 

    s = Mid(s, 1, InStrRev(s, endStr) - 1) 
    '多次处理 注意和下面的判断
    If checkContentRunStr(content) = True Then
        s = getContentRunStr(s) 
    End If 
    '处理内容里有""，则给它删除掉20150329
    s = handleDoubleQuotation(s) 

    splxx = Split(s & ",1", ",") 

    '-----------------------------------------------------------

    'footer start
    If LabelName = "sadfasdfsdf" Then

        '----------------------- ASP自身内部函数处理 -----------------------------
    '系统函数 Now
    ElseIf LabelName = "now" Then
        s = Now() 
    '系统函数 Date
    ElseIf LabelName = "date" Then
        s = Date 
    '系统函数 Len
    ElseIf LabelName = "len" Then
        s = Len(s) 
    '系统函数 LCase
    ElseIf LabelName = "lcase" Then
        s = LCase(s) 
    '系统函数 UCase
    ElseIf LabelName = "ucase" Then
        s = UCase(s) 
    '系统函数 ltrim
    ElseIf LabelName = "ltrim" Then
        s = LTrim(s) 
    '系统函数 rtrim
    ElseIf LabelName = "rtrim" Then
        s = RTrim(s) 
    '系统函数 trim
    ElseIf LabelName = "trim" Then
        s = Trim(s) 
    '系统函数 Left
    ElseIf LabelName = "left" Then
        splxx = Split(s & ",1", ",") 
        s = Left(Trim(splxx(0)), Trim(splxx(1))) 
    '系统函数 Right
    ElseIf LabelName = "right" Then
        s = Right(Trim(splxx(0)), Trim(splxx(1))) 
    '系统函数 Mid
    ElseIf LabelName = "mid" Then
        splxx = Split(s & ",99999", ",") 
        If UBound(splxx) >= 2 Then
            s = Mid(Trim(splxx(0)), Trim(splxx(1)), Trim(splxx(2))) 
        Else
            s = Mid(Trim(splxx(0)), Trim(splxx(1))) 
        End If 
    End If 
    content = Replace(content, YunStr, s) 
    handleContentCode = content 
End Function 


'内部模块处理 HandleInModule(Content,"start") HandleInModule(Content,"end")
Function handleInModule(content, sType)
    sType = LCase(CStr(sType)) 
    If sType = "1" Or sType = "start" Then
        content = Replace(content, "\'", "\|*|\") 
        content = Replace(content, "\=", "\|&|\")                                   '后加20141024
    ElseIf sType = "2" Or sType = "end" Then
        content = Replace(content, "\|*|\", "'") 
        content = Replace(content, "\$", "$") 
        content = Replace(content, "\}", "}") 

        content = Replace(content, "\|&|\", "=")                                    '后加20141024
    End If 
    handleInModule = content 
End Function 
'清除特殊样式后获得标签值
Function clearRParam(ByVal action, ByVal LableStr)
    Dim s 
    'Action=Replace(Action,"\'","【|\‘|】")
    action = Replace(action, "\'", "")                                              '把这种清掉
    s = RParam(action, LableStr) 
    's=replace(s,"【|\‘|】", "\'")
    clearRParam = s 
End Function 
'获得参数内容后 放到动作里处理一下（20151023）
Function atRParam(ByVal action, ByVal LableStr)
    atRParam = RParam(action, LableStr) 
    If InStr(atRParam, "{$") > 0 And InStr(atRParam, "$}") > 0 Then
        atRParam = handleTemplateAction(atRParam, False)                                '处理动作
    End If 
End Function 
'读单个参数值  Title = RParam(Action,"Title")     起强版获取参数值20150723
Function rParam(ByVal action, ByVal lableStr)
    Dim s 

    '原始 单引号
    s = handleRParam(action, lableStr, "'") 
    '原始 双引号
    If s = "" Then
        s = handleRParam(action, lableStr, """") 
    End If 
    '原始 空
    If s = "" Then
        s = handleRParam(action, lableStr, "") 
    End If 

    '小写 单引号
    If s = "" Then
        s = handleRParam(action, LCase(lableStr), "'") 
    End If 
    '小写 双引号
    If s = "" Then
        s = handleRParam(action, LCase(lableStr), """") 
    End If 
    '小写 空
    If s = "" Then
        s = handleRParam(action, LCase(lableStr), "") 
    End If 

    '大写 单引号
    If s = "" Then
        s = handleRParam(action, UCase(lableStr), "'") 
    End If 
    '大写 双引号
    If s = "" Then
        s = handleRParam(action, UCase(lableStr), """") 
    End If 
    '大写 空
    If s = "" Then
        s = handleRParam(action, UCase(lableStr), "") 
    End If 
    '不要这个，要不不稳定(20151022)
    'if s=false then s=""
    If s = "[#空*值_#]" Then s = "" 
    rParam = s 
End Function 
'处理 读单个参数值
Function handleRParam(ByVal action, ByVal LableStr, ByVal typeStr)
    Dim LalbeName, endTypeStr, isTrue, s 
    isTrue = False                                                                  '是否为真
    endTypeStr = IIF(typeStr <> "", typeStr, " ") 
    action = vbCrLf & " " & action                                                  '给它也加个空格，要不然在没有函数，前面就没有空格
    '默认前面加空格
    LalbeName = " " & LableStr                                                      '加个空格是为了精准
    '不存在  前面加点
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = "'" & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在 前面加双引号
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = """" & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在    前面加TAB
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = vbTab & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在    前面加换行
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = vbCrLf & LableStr 
    Else
        isTrue = True 
    End If 
    If InStr(action, LalbeName & "=" & typeStr) > 0 And InStr(action, endTypeStr) > 0 Then
        s = strCut(action, LalbeName & "=" & typeStr, endTypeStr, 2) 
        s = handleInModule(s, "end")                                                    '处理里面参数 追加于20141031            还原内容值

        If s = "" Then
            s = "[#空*值_#]" 
        End If 

        '判断是否对参数进行动作制作
        If InStr(s, "{$") > 0 And InStr(s, "$}") > 0 Then

            'handleRParam=HandleTemplateAction(handleRParam,true)        '处理动作
            'handleRParam = handleModuleReplaceArray(handleRParam)'给AddSqL处理一下动作 这是处理替换，不需要，因为在 HandleTemplateAction有替换了(20151021)

        End If 
        '不要这个，要不不稳定(20151022)
        'if handleRParam="" then
        'handleRParam=false
    'end if
    End If 
    handleRParam = s 
End Function 


'获得配置块 20150105 GetConfigBlock(ConfigContent, BlockName)
Function getConfigBlock(ConfigContent, BlockName)
    getConfigBlock = getCutConfigBlock(ConfigContent, BlockName, "#", "#") 
End Function 
'获得配置块 20150105
Function getConfigBlock2(ConfigContent, BlockName)
    getConfigBlock2 = getCutConfigBlock(ConfigContent, BlockName, "[#", "#]") 
End Function 
'获得配置块 20150105
Function getConfigBlock3(ConfigContent, BlockName)
    getConfigBlock3 = getCutConfigBlock(ConfigContent, BlockName, "[$", "$]") 
End Function 
'截取配置内容中块 20150105
Function getCutConfigBlock(ConfigContent, BlockName, StartLable, EndLable)
    Dim startStr, endStr 
    startStr = StartLable & BlockName & EndLable 
    endStr = StartLable & BlockName & EndLable 
    '开始标签处理
    If InStr(ConfigContent, startStr & " start") > 0 Then
        startStr = startStr & " start" 
    Else
        startStr = startStr & " Start" 
    End If 
    '结束标签处理
    If InStr(ConfigContent, endStr & " end") > 0 Then
        endStr = endStr & " end" 
    Else
        endStr = endStr & " End" 
    End If 

    If InStr(ConfigContent, startStr) > 0 And InStr(ConfigContent, endStr) > 0 Then
        getCutConfigBlock = strCut(ConfigContent, startStr, endStr, 2) 
    End If 
End Function 
'获得配置内容块20150401
Function getConfigContentBlock(ByVal ConfigContent, BlockName)
    getConfigContentBlock = getCutConfigBlock(ConfigContent, BlockName, "", "") 
End Function 
'获得配置文件里块20150401  getConfigFileBlock(ConfigPath, "#txtRunCode#")  测试标签块时则自动创建
Function getConfigFileBlock(ByVal ConfigFile, BlockName)
    Dim content, FindStr, replaceStr, startStr, endStr 
    content = getFText(ConfigFile) 
    'MsgBox ("ConfigFile=" & ConfigFile & "(" & CheckFile(ConfigFile) & "，" & GetFSize(ConfigFile) & ")" & vbCrLf & "Content=" & Content)
    startStr = BlockName & " start" 
    endStr = BlockName & " end" 
    replaceStr = startStr & "" & endStr 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        FindStr = strCut(content, startStr, endStr, 2) 
        getConfigFileBlock = FindStr 
    Else
        Call CreateFile(ConfigFile, content & replaceStr) 
    End If 
End Function 
'设置配置文件里块 20150401 call setConfigFileBlock(ConfigFile, "aaabbc", "#上传目录列表#")  存在则更新
Function setConfigFileBlock(ByVal ConfigFile, ByVal WriteContent, BlockName)
    Dim content, FindStr, replaceStr, startStr, endStr 
    content = getFText(ConfigFile) 
    startStr = BlockName & " start" 
    endStr = BlockName & " end" 
    replaceStr = startStr & WriteContent & endStr 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        FindStr = strCut(content, startStr, endStr, 1) 
        content = Replace(content, FindStr, replaceStr) 
    Else
        content = content & replaceStr 
    End If 
    Call CreateFile(ConfigFile, content) 
    setConfigFileBlock = content 
End Function 

'删除配置块 20150322
Function delConfigBlock(Config, BlockName)
    delConfigBlock = delCutConfigBlock(Config, BlockName, "#", "#") 
End Function 
'删除配置块 20150322
Function delConfigBlock2(Config, BlockName)
    delConfigBlock2 = delCutConfigBlock(Config, BlockName, "[#", "#]") 
End Function 
'删除配置块 20150322
Function delConfigBlock3(Config, BlockName)
    delConfigBlock3 = delCutConfigBlock(Config, BlockName, "[$", "$]") 
End Function 
'删除配置内容 20150322
Function delCutConfigBlock(Config, BlockName, StartLable, EndLable)
    Dim startStr, endStr, s 
    startStr = StartLable & BlockName & EndLable & " start" 
    endStr = StartLable & BlockName & EndLable & " end" 
    If InStr(Config, startStr) > 0 And InStr(Config, endStr) > 0 Then
        s = strCut(Config, startStr, endStr, 1) 
        Config = Replace(Config, s, "") 
    End If 
    delCutConfigBlock = Config 
End Function 




'获得文件里设置参数　20150315
Function getFileParamValue(ConfigPath, paramName)
    getFileParamValue = handleGetSetFileParameValue(ConfigPath, paramName, "", "获得") 
End Function 
'设置文件里设置参数　20150315
Function setFileParamValue(ConfigPath, paramName, valueStr)
    setFileParamValue = handleGetSetFileParameValue(ConfigPath, paramName, valueStr, "设置") 
End Function 
'处理获得设置文件参数值　20150315
Function handleGetSetFileParameValue(ConfigPath, paramName, valueStr, sType)
    Dim content, startStr, endStr, YunStr, replaceStr 
    '文件为假时，创建一个空文件看看，如果不能创建这个文件则说明这个文件地址有问题，则退出20150324
    If checkFile(ConfigPath) = False Then
        Call CreateFile(ConfigPath, "") 
    End If 
    If checkFile(ConfigPath) = False Then Exit Function                             '文件不存在则退出

    content = trimVbCrlf(getFText(ConfigPath)) 
    startStr = vbCrLf & paramName & "=" : endStr = vbCrLf 
    replaceStr = vbCrLf & paramName & "=" & valueStr & vbCrLf 
    If InStr(vbCrLf & content, startStr) > 0 And InStr(content & vbCrLf, endStr) > 0 Then
        YunStr = strCut(vbCrLf & content & vbCrLf, startStr, endStr, 2) 
        If sType = "获得" Then
            handleGetSetFileParameValue = YunStr 
            Exit Function 
        End If 
        YunStr = startStr & YunStr & endStr 
        content = Replace(vbCrLf & content & vbCrLf, YunStr, replaceStr) 
        Call CreateFile(ConfigPath, content) 
    Else
        Call CreateFile(ConfigPath, content & vbCrLf & trimVbCrlf(replaceStr)) 
    End If 
End Function 

'设置内容里参数 20150611
Function setRParam(ConfigPath, paramName, paramValue, isNoAdd)
    Dim content, startStr, endStr, s 
    content = PHPTrim(getFText(ConfigPath)) 
    startStr = paramName & "='" : endStr = "'" 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        s = strCut(content, startStr, endStr, 2) 
        content = Replace(content, startStr & s & endStr, startStr & paramValue & endStr) 
        Call CreateFile(ConfigPath, content) 

    ElseIf Trim(isNoAdd) = "1" Then
        Call createAddFile(ConfigPath, startStr & paramValue & endStr) 
    End If 
End Function 

'追加或替换参数值 20150615
Function addReplaceRParam(ByVal content, startStr, endStr, ByVal valueStr)
    Dim s 
    valueStr = startStr & valueStr & endStr 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        s = strCut(content, startStr, endStr, 1) 
        content = Replace(content, s, valueStr) 
    Else
        content = content & vbCrLf & valueStr 
    End If 
    addReplaceRParam = content 
End Function 
'删除指定字符N次
Function deleteStrCut(ByVal content, ByVal startStr, ByVal endStr, ByVal cutType, nDelCount)
    Dim i, s 
    If nDelCount = 0 Then
        nDelCount = 99 
    End If 
    For i = 0 To nDelCount
        s = getStrCut(content, startStr, endStr, 1) 
        If s <> "" Then
            content = Replace(content, s, "") 
        Else
            Exit For 
        End If 
    Next 
    deleteStrCut = content 
End Function 



'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容",""))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加在前"))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加"))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加在前"))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","外部追加在前"))
'call Rwend(replaceContentModule(getftext("1.html"), "<div>", "</div>", "替换内容", "外部追加"))
'替换内容里模块   ReplaceType(空为替换，追加在前，追加在后(追加)，外部追加在前，外部追加在后(外部追加))
Function replaceContentModule(ByVal content, startStr, endStr, ReplaceValue, ReplaceType)
    Dim splStr, splxx, s, i, splType, valueList, newStartStr, newEndStr, sourceValueList, sourceValue, tempS, newReplaceValue 
    If InStr(content, startStr) = False And InStr(content, endStr) = False Then
        replaceContentModule = content 
        Exit Function 
    End If 
    splType = "$Array$" 
    For i = 1 To 99
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            s = strCut(content, startStr, endStr, 1) : tempS = s 
            s = Mid(s, Len(startStr) + 1, Len(s) - Len(startStr) - Len(endStr)) 
            newStartStr = getEachStrAddValue(startStr, "|*|") 
            If InStr(splType & valueList & splType, splType & newStartStr & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newStartStr 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & startStr 
            End If 
            newEndStr = getEachStrAddValue(endStr, "|*|") 
            If InStr(splType & valueList & splType, splType & newEndStr & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newEndStr 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & endStr 
            End If 

            If ReplaceType = "追加在前" Then
                newReplaceValue = newStartStr & ReplaceValue & s & newEndStr 
            ElseIf ReplaceType = "追加在后" Or ReplaceType = "追加" Then
                newReplaceValue = newStartStr & s & ReplaceValue & newEndStr 
            ElseIf ReplaceType = "外部追加在前" Then
                newReplaceValue = ReplaceValue & newStartStr & s & newEndStr 

            ElseIf ReplaceType = "外部追加在后" Or ReplaceType = "外部追加" Then
                newReplaceValue = newStartStr & s & newEndStr & ReplaceValue 
            Else
                newReplaceValue = ReplaceValue 
            End If 

            content = Replace(content, tempS, newReplaceValue) 
        Else
            Exit For 
        End If 
    Next 
    'call rwend(content)
    splStr = Split(valueList, splType) 
    splxx = Split(sourceValueList, splType) 
    For i = 0 To UBound(splStr)
        sourceValue = splStr(i) 
        ReplaceValue = splxx(i) 
        content = Replace(content, sourceValue, ReplaceValue) 
    Next 
    replaceContentModule = content 
End Function 

'call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", "追加在前"))
'call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", "追加"))
'call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", ""))
'替换内容里一行模块   ReplaceType(空为替换，追加在前，追加在后(追加))
Function replaceContentRowModule(content, searchValue, ReplaceValue, ReplaceType)
    Dim splStr, splxx, i, splType, valueList, sourceValueList, sourceValue, newReplaceValue, newSearchValue 
    splType = "$Array$" 
    For i = 1 To 99
        If InStr(content, searchValue) > 0 Then
            newSearchValue = getEachStrAddValue(searchValue, "|*|") 
            If InStr(splType & valueList & splType, splType & newSearchValue & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newSearchValue 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & searchValue 
            End If 
            If ReplaceType = "追加在前" Then
                newReplaceValue = ReplaceValue & newSearchValue 
            ElseIf ReplaceType = "追加在后" Or ReplaceType = "追加" Then
                newReplaceValue = newSearchValue & ReplaceValue 
            Else
                newReplaceValue = ReplaceValue 
            End If 
            content = Replace(content, searchValue, newReplaceValue) 
        Else
            Exit For 
        End If 
    Next 

    'call rwend(content)
    splStr = Split(valueList, splType) 
    splxx = Split(sourceValueList, splType) 
    For i = 0 To UBound(splStr)
        sourceValue = splStr(i) 
        ReplaceValue = splxx(i) 
        content = Replace(content, sourceValue, ReplaceValue) 
    Next 
    replaceContentRowModule = content 

End Function 
'处理配置文档(20150804)
Sub handleConfigFile(ConfigPath)
    Dim c 
    If checkFile(ConfigPath) = False Then
        c = "#Help帮助# start" & vbCrLf & "默认帮助内容" & vbCrLf & "#Help帮助# end" 
        Call CreateFile(ConfigPath, c) 
    End If 
End Sub 

'获得内容里指定类型值   RParam加强版(20161025)
Function getRParam(ByVal content, ByVal lableStr)
    Dim contentLCase, endS, i, s, c, isStart, startStr, isValue 
    content = " " & content & " "                                                   '避免更精准获得值
    contentLCase = LCase(content) 
    lableStr = LCase(lableStr) 
    endS = Mid(content, InStr(contentLCase, lableStr) + Len(lableStr)) 
    'call echo("ends",ends)
    isStart = False                                                                 '是否有开始类型值
    isValue = False                                                                 '是否有值
    For i = 1 To Len(endS)
        s = Mid(endS, i, 1) 
        If isStart = True Then
            If s <> "" Then
                If startStr = "" Then
                    startStr = s 
                Else
                    If startStr = """" Or startStr = "'" Then
                        If s = startStr Then
                            isValue = True 
                            Exit For 
                        End If 
                    ElseIf s = " " And c = "" Then

                    ElseIf s = " " Or s = "/" Or s = ">" Then
                        isValue = True 
                        Exit For 
                    End If 
                    If s <> " " Then
                        c = c & s 
                    End If 
                End If 
            End If 
        End If 

        If s = "=" Then
            isStart = True 
        End If 
    Next 
    If isValue = False Then
        c = "" 
    End If 
    getRParam = c 
'call echo("c",c)
End Function 

'获得模板某标签默认内容 代码进行了二次查找 会在HTML模板里二次查找默认值
Function getDefaultValue(action)
    getDefaultValue = moduleFindContent(action, "default") 
End Function 

'添加模块替换数组
Sub addModuleReplaceArray(title, content)
    Dim i 
    For i = 1 To UBound(ModuleReplaceArray) - 1
        If ModuleReplaceArray(i, 0) = "" Then
            ModuleReplaceArray(i, 0) = title 
            ModuleReplaceArray(0, i) = content 
            Exit Sub 
        End If 
    Next 
End Sub 

'根据标签找到对应内容
Function moduleFindContent(action, ModuleName)
    Dim defaultStr, startStr, endStr 
    defaultStr = rParam(action, ModuleName)                                         '把转小写LCase去掉 （20151008）

    startStr = "<!--#" & defaultStr & " start#-->" 
    endStr = "<!--#" & defaultStr & " end#-->" 
    '[_18年独家一次性祛斑第一品牌2014年10月21日 10时59分]
    'Call Echo("Default",Default)
    '判断是否存在
    If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
        defaultStr = getStrCut(code, startStr, endStr, 2) 
    ElseIf defaultStr <> "" Then
        startStr = "<!--#" & defaultStr 
        endStr = "#-->" 
        If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
            defaultStr = getStrCut(code, startStr, endStr, 2) 
        End If 
    End If 

    '删除默认值20150712
    Dim deletedefault 
    deletedefault = rParam(action, "deletedefault") 
    If deletedefault = "true" Then
        Call addModuleReplaceArray("【删除】", startStr & defaultStr & endStr) 
    End If 
    moduleFindContent = defaultStr 
End Function 
%>     

