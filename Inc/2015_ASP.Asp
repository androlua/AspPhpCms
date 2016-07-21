<% 
'对ASP处理



'批量获得函数 20150402  有点慢，不过正确的，以后慢慢改吧
function batchFindFunction(configPath, variableList)
    dim configContent, lCaseConfigContent, splStr, variableName, c 
    dim objCode, content 
    if checkFile(configPath) = false then
        batchFindFunction = "" 
        call echo("配置文件不存在", configPath) 
        exit function 
    end if 
    configContent = getFText(configPath) 
    lCaseConfigContent = lCase(configContent) 
    lCaseConfigContent = replace(replace(lCaseConfigContent, ",", "|"), vbCrLf, "|") 
    splStr = split(variableList, "|") 
    for each variableName in splStr
        if variableName <> "" and inStr(lCaseConfigContent, "|" & variableName & "|") then
            c = c & getFindFileFunction(configPath, variableName) & vbCrLf 
        end if 
    next 
    batchFindFunction = c 
end function 
'获得指定函数在那个文件里代码 20150402
function getFindFileFunction(byVal configPath, byVal functionName)
    dim filePath, configContent, splStr, splxx, s, s2 
    dim objCode, content 
    functionName = lCase(pHPTrim(functionName)) 
    if checkFile(configPath) = false then
        getFindFileFunction = "" 
        call echo("配置文件不存在", configPath) 
        exit function 
    end if 
    configContent = getFText(configPath) 
    splStr = split(configContent, vbCrLf) 
    for each s in splStr
        if inStr(s, ",") > 0 then
            filePath = mid(s, 1, inStr(s, ",") - 1) 
            if inStr(filePath, "(") > 0 then
                filePath = mid(filePath, 1, inStr(filePath, "(") - 1) 
            end if 
            s2 = lCase(mid(s, inStrRev(s, ",") + 1)) 
            if inStr("|" & s2 & "|", "|" & functionName & "|") > 0 then
                'Call Echo(S,S2)
                set objCode = new aSPCode
                    objCode.setCountRow = 9999 
                    objCode.setAspSetType = "||" 
                    objCode.setFindFunctionList = functionName 
                    content = getFText(filePath) 
                    content = objCode.handleAspCode(content)                                        '获得内容
                    'Call Eerr(FunctionName,ObjCode.FindFunctionContent)
                    getFindFileFunction = objCode.getFindFunctionContent 
                set objCode = nothing 
                exit function 
            end if 
        end if 
    next 
end function 

'获得ASP代码
function getASPCode(byVal content)
    getASPCode = handleGetAspCode(content, "") 
end function 

'处理获得Asp代码 C = HandleGetAspCode(C,"|第一段|去ASP开始结束标签|去注释部分|(每行不为空|去空行)|(全部为ASP|默认ASP自检打开)|处理成Execute代码|")
'以后再加强，可截取只定段数代码，如第二段，最后一段 20150329
function handleGetAspCode(byVal content, sType)
    dim splStr, sx, s, c, i, yesASP, sYHCount, wc, aspCode, tempAspCode, vbCrlfYes 
    yesASP = false                                                                  '是ASP 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    splStr = split(content, vbCrLf)                                                 '分割行

    '20150328
    if inStr("|" & sType & "|", "|全部为ASP|") > 0 or inStr("|" & sType & "|", "|默认ASP自检打开|") > 0 then
        yesASP = true                                                                   '是ASP 默认为真
    end if 
    '循环分行
    for each s in splStr
        '循环每个字符
        aspCode = "" 
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and yesASP = false and wc = "" then
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    sx = "<" & "%" 
                    i = i + 1 
                    if inStr("|" & sType & "|", "|去ASP开始结束标签|") = false then
                        aspCode = aspCode & sx 
                    end if 
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and yesASP = true and wc = "" then
                yesASP = false                                                                  'ASP为假
                sx = "%" & ">" 
                i = i + 1 
                if inStr("|" & sType & "|", "|去ASP开始结束标签|") = false then
                    c = c & sx & vbCrLf 
                end if 
                if inStr("|" & sType & "|", "|第一段|") > 0 or inStr("|" & sType & "|", "|第一段代码|") > 0 or inStr("|" & sType & "|", "|获取第一段|") > 0 or inStr("|" & sType & "|", "|1|") > 0 then
                    handleGetAspCode = c & aspCode 
                    exit function 
                end if 
            'ASP为真
            elseIf yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    wc = wc & sx 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            aspCode = aspCode & wc                                                          '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        end if 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    if inStr("|" & sType & "|", "|去注释部分|") > 0 then
                        exit for 
                    end if 
                    aspCode = aspCode & mid(s, i) 
                    exit for 
                else
                    aspCode = aspCode & sx 
                end if 

            end if 
        next 
        if yesASP = true then                                                           '
            vbCrlfYes = true 
            if trimVbCrlf(aspCode) = "" then
                if inStr("|" & sType & "|", "|每行不为空|") > 0 or inStr("|" & sType & "|", "|去空行|") > 0 then
                    vbCrlfYes = false 
                end if 
            end if 
            if vbCrlfYes = true then
                if inStr("|" & sType & "|", "|处理成Execute代码|") > 0 then
                    aspCode = trimVbCrlf(aspCode) : tempAspCode = lCase(aspCode) 
                    c = c & aspCode & " : " 
                    if left(tempAspCode, 3) = "if " and right(tempAspCode, 5) <> " then" then
                        c = c & " End If : " 
                    end if 
                else

                    aspCode = rTrim(aspCode)                                                        '去除右边空格
                    c = c & aspCode & vbCrLf 
                end if 
            end if 
        end if 
    next 
    if inStr("  " & c, vbCrLf) > 0 then c = left(c, len(c) - 2) 
    handleGetAspCode = c 
end function 

'删除ASP里注释 (精)
function delAspNote(byVal content)
    dim splStr, i, yesASP, yesWord, sx, s, wc, aspCode, sYHCount 
    dim yesFunction                                                                 '函数是否为真
    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    sx = "<" & "%" 
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                sx = "%" & ">" 
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    wc = wc & sx 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            aspCode = aspCode & wc                                                          '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        end if 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    exit for 
                else
                    aspCode = aspCode & sx 
                end if 
            else
                aspCode = aspCode & sx 
            end if 
            doEvents 
        next 
        aspCode = rTrim(aspCode)                                                        '去除右边空格
        aspCode = aspCode & vbCrLf 
        doEvents 
    next 
    if aspCode <> "" then aspCode = left(aspCode, len(aspCode) - 2) 
    delAspNote = aspCode 
end function 

'寻找ASP函数列表 20140811
'nSub与nFunction 是为了统计用的，默认为空就好
'Call FindAspFunction(Content,0,0,"(全部为ASP|默认ASP自检打开)|变量处理|加密变量")
function findAspFunction(content, nSub, nFunction, sType)
    dim splStr, i, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount 
    dim upWord                                                                      '上一个词
    dim tempS, dimList 
    dim yesFunction                                                                 '函数是否为真
    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    splStr = split(content, vbCrLf)                                                 '分割行
    if nSub = "" then nSub = 0                                                      '为空则默认为零
    if nFunction = "" then nFunction = 0                                            '为空则默认为零

    '20150328
    if inStr("|" & sType & "|", "|全部为ASP|") > 0 or inStr("|" & sType & "|", "|默认ASP自检打开|") > 0 then
        yesASP = true                                                                   '是ASP 默认为真
    end if 
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    wc = wc & sx 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            if yesFunction = true then aspCode = aspCode & wc                               '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        end if 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    if yesFunction = true then aspCode = aspCode & mid(s, i) 
                    exit for 
                '字母
                elseIf checkABC(sx) = true or(sx = "_" and zc <> "") or zc <> "" then
                    zc = zc & sx 
                    s1 = lCase(mid(s & " ", i + 1, 1)) 
                    if inStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 and not(s1 = "_" and zc <> "") then'最简单判断
                        tempS = mid(s, i + 1) 
                        if inStr("|function|sub|", "|" & lCase(zc) & "|") then
                            '函数开始
                            if yesFunction = false and lCase(upWord) <> "end" then
                                yesFunction = true 
                                if lCase(zc) = "sub" then nSub = nSub + 1 else nFunction = nFunction + 1 
                                dimList = getFunDimName(tempS) 
                            elseIf yesFunction = true and lCase(upWord) = "end" then                        '获得上一个单词
                                aspCode = aspCode & zc & vbCrLf 
                                if inStr("|" & sType & "|", "|加密变量|") > 0 then aspCode = aspCode & "'[NOHandle]" & encCode(dimList) & vbCrLf & vbCrLf 
                                yesFunction = false 
                            end if 
                        elseIf yesFunction = true and lCase(zc) = "dim" then
                            dimList = dimList & "," & getDimName(tempS) 
                        elseIf yesFunction = true and inStr("|" & sType & "|", "|变量处理|") > 0 then
                            zc = replaceDim2(dimList, zc) 
                        end if 
                        upWord = zc                                                                  '记住当前单词
                        if yesFunction = true then aspCode = aspCode & zc 
                        zc = "" 
                    end if 
                elseIf yesFunction = true then
                    aspCode = aspCode & sx 
                end if 
            end if 
            doEvents 
        next 
        aspCode = rTrim(aspCode)                                                        '去除右边空格
        if yesFunction = true then
            aspCode = aspCode & vbCrLf                                                      'Asp换行
        end if 
        doEvents 
    next 
    findAspFunction = aspCode 
end function 


'ASP代码首字母大写 (待完善)
function firstLetterUppercase(content)
    dim splStr, i, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount 
    dim yesFunction                                                                 '函数是否为真

    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                    sx = "<%" 
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
                aspCode = aspCode & "%" & ">" 
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    wc = wc & sx 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            if yesFunction = true then aspCode = aspCode & wc                               '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        end if 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    if yesFunction = true then aspCode = aspCode & mid(s, i) 
                    exit for 
                '字母
                elseIf checkABC(sx) = true or(sx = "_" and zc <> "") or zc <> "" then
                    zc = zc & sx 
                    s1 = lCase(mid(s & " ", i + 1, 1)) 
                    if inStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 and not(s1 = "_" and zc <> "") then'最简单判断
                        aspCode = aspCode & uCase(left(zc, 1)) & mid(zc, 2) 
                        zc = "" 
                    end if 
                else
                    aspCode = aspCode & sx 
                end if 
            end if 
            doEvents 
        next 
        aspCode = rTrim(aspCode)                                                        '去除右边空格
        if yesFunction = true then
            aspCode = aspCode & vbCrLf                                                      'Asp换行
        end if 
        aspCode = aspCode & vbCrLf 
        doEvents 
    next 
    firstLetterUppercase = aspCode 
end function 

'字符大小写随机显示 20150329
function contentLUShow(content)
    dim i, s, c 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        s = IIF(pHPRnd(0, 1) = "0", lCase(s), uCase(s)) 
        c = c & s 
    next 
    contentLUShow = c 
end function 
'ASP转VB内容 20150727
function ASPToVB(content)
    '判断是否移除 '开始'结束 中间内容
    content = deleteStrCut(content, vbCrLf & "'开始", vbCrLf & "'结束", 1, 0) 
    '判断是否移除 '开始'结束 中间内容
    content = deleteStrCut(content, vbCrLf & "'VB不引用 Start", vbCrLf & "'VB不引用 End", 1, 0) 
    'Content = getStrCut(Content,"<" & "%","%" & ">",2)
    content = replace(content, "Response.End()", "Response.End") 
    content = replace(content, "Server." & "MapPath(Path)", "App" & ".Path & ""\"" & Path") 
    content = replace(content, "Server." & "MapPath(""/"")", "App." & "Path & ""\""") 
    content = replace(content, "Server." & "MapPath(""\"")", "App." & "Path & ""\""") 
    content = replace(content, "Server." & "MapPath("".\"")", "App." & "Path & "".\""") 
    content = replace(content, "Server." & "MapPath(""./"")", "App." & "Path & "".\""") 
    content = replace(content, "Server." & "MapPath(", "handlePath(") 
    content = replace(content, "server." & "mapPath(", "handlePath(") 
    content = replace(content, "Response.Flush", "") 
    content = replace(content, "fesponse.flush", "") 


    '20150614
    content = replace(content, """ & Request." & "ServerVariables(""HTTP_HOST"") & """, "127.0.0.1") 
    content = replace(content, vbTab, "    ")                                       '替换Tab
    content = replace(content, "request(""Debug"")", " 1=2 and ""11""")             '屏蔽管理
    content = replace(content, "Request(""gl"")", " 1=2 and ""11""")                '屏蔽管理
    content = replace(content, "Request." & "QueryString(""Debug"")", " 1=2 and ""11""") '屏蔽管理

    content = replace(content, "Response.Write", "call rw") 
    content = replace(content, "response.write", "call rw") 
    content = replace(content, "Response.Flush", "") 
    content = replace(content, "response.flush", "") 



    '再加一种
    content = replace(content, "response.end()", "Response.End") 
    content = replace(content, "server." & "mapPath(Path)", "App" & ".Path & ""\"" & Path") 
    content = replace(content, "server." & "mapPath(""/"")", "App." & "Path & ""\""") 
    content = replace(content, "server." & "mapPath(""\"")", "App." & "Path & ""\""") 
    content = replace(content, "server." & "mapPath("".\"")", "App." & "Path & "".\""") 
    content = replace(content, "server." & "mapPath(""./"")", "App." & "Path & "".\""") 


    '20150614
    content = replace(content, """ & request." & "serverVariables(""HTTP_HOST"") & """, "127.0.0.1") 
    content = replace(content, vbTab, "    ")                                       '替换Tab
    content = replace(content, "request(""Debug"")", " 1=2 and ""11""")             '屏蔽管理
    content = replace(content, "request(""gl"")", " 1=2 and ""11""")                '屏蔽管理
    content = replace(content, "request." & "QueryString(""Debug"")", " 1=2 and ""11""") '屏蔽管理

    ASPToVB = content 
end function 
'asp转VB.net内容
function ASPToVBNET(content)
    dim splStr, i, s, noSpaceS, s2, c, lCaseS, functionName 
    dim leftS, noteS, centerS, tempCenterS 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        lCaseS = phptrim(lcase(s)) : noSpaceS = phptrim(s) 
        's=centerS
        if instr(lcase(s), " doerror ") > 0 and instr(lcase(s), "call ") = false then
            s = regExp_Replace(s, " doError ", " call doError(") & ")" 
        'call echo("s",s)
        end if 

        if left(lCaseS, 4) = "sub " then
            s = functionParamtoNet(s)                                                       '处理函数里参数
        elseif left(lCaseS, 9) = "function " then
            s = functionParamtoNet(s)                                                       '处理函数里参数
            s2 = mid(s, instr(lcase(s), "function ") + 9) 
            functionName = phptrim(mid(s2, 1, instr(s2, "(") - 1)) 
            s = s & vbCrLf & functionName & "=""""" 
        elseif left(lCaseS, 4) = "set " then
            s = mid(s, instr(lcase(s), "set ") + 3) 
        elseif left(lCaseS, 4) = "dim " then
            s = dimAddDefaultValue(s) 

        elseif left(lCaseS, 1) = "." then
            leftS = mid(s, 1, instr(s, ".") - 1) 
            noteS = "" 
            if instr(s, "'") > 0 then
                noteS = mid(s, instr(s, "'")) 
            end if 
            centerS = mid(s, instr(s, ".")) 
            if instr(s, "'") > 0 then
                centerS = mid(centerS, 1, instr(centerS, "'") - 1) 
            end if 
            tempCenterS = centerS 
            centerS = leftS & "call " & mid(centerS, 1, instr(centerS, " ")) & "(" & mid(centerS, instr(centerS, " ")) & ")" & noteS 
            if instr(tempCenterS, "=") = false and instr(tempCenterS, "(") = false then
                s = centerS 
            'call echo(s,centerS)
            end if 


        elseif left(lCaseS, 2) = "if" then
            leftS = mid(s, 1, instr(lcase(s), "if") - 1) 
            noteS = "" 
            if instr(s, "'") > 0 then
                noteS = mid(s, instr(s, "'")) 
            end if 
            centerS = mid(s, instr(lcase(s), "if")) 
            if instr(s, "'") > 0 then
                centerS = mid(centerS, 1, instr(centerS, "'") - 1) 
            end if 
            if right(rTrimVBTab(lcase(centerS)), 5) <> " then" then
                centerS = centerS & " :end if  " 
            end if 
            centerS = leftS & centerS & noteS 

        elseif left(lCaseS, 4) = "wend" then
            s = "end While" 

        end if 

        c = c & s & vbCrLf 
    next 
    ASPToVBNET = c 
end function 
'定义变量加默认值，指定
function dimAddDefaultValue(dimList)
    dim splStr, s, c, startStr, dimValue, tempDimList, noteS 
    tempDimList = dimList 
    startStr = mid(dimList, 1, instr(lcase(dimList), "dim ") + 3) 
    dimList = mid(dimList, len(startStr)) 
    splStr = split(dimList, ",") 
    for each s in splStr
        noteS = "" 
        if instr(s, ":") > 0 then
            noteS = mid(s, instr(s, ":")) 
            s = mid(s, 1, instr(s, ":") - 1) 
        'call echo("s",s)
        elseif instr(s, "'") > 0 then
            noteS = mid(s, instr(s, "'")) 
            s = mid(s, 1, instr(s, "'") - 1) 
        'call echo("s",s)
        end if 

        if instr(lcase("|c|content|html|htmlstr|strhtml|cssstr|strcss|StyleName|parentUrl|parentParentUrl|parentParentParentUrl|szRet|Url|UrlFileName|urlList|UrlParam|WebSite|FanCharSet|s1|s2|s3|c1|c2|c3|c4|c5|En1|En2|En3|En4|s|temp|temp1|temp2|temp3|yinghaoLabel|parentName|valueStr|valueStr1|valueStr2|valueStr3|noDanYinShuangYinStr|PubAHrefList|PubATitleList|yinghaoLabel|parentName|valueStr|nLen|ParamList|ParamNameList|ParamList|Str_unicode|valueLabel|domainName|labelName|"), "|" & phptrim(lcase(s)) & "|") > 0 or right(phptrim(lcase(s)), 3) = "str" then
            dimValue = dimValue & s & "=""""" & vbCrLf 
        end if 
        if c <> "" then c = c & "," 
        c = c & s & noteS 
    next 
    dimAddDefaultValue = tempDimList & vbCrLf & dimValue 
end function 
'函数参数转Net里能用(20151021)
function functionParamtoNet(content)
    dim leftStr, rightStr, valueStr, splStr, s, c, lCaseS 
    leftStr = mid(content, 1, instr(content, "(")) 
    rightStr = mid(content, instr(content, ")")) 
    valueStr = mid(content, instr(content, "(") + 1) 
    valueStr = mid(valueStr, 1, instr(valueStr, ")") - 1) 

    splStr = split(valueStr, ",") 
    for each s in splStr
        s = phptrim(s) 
        lCaseS = lcase(s) 
        if instr(lCaseS, "byval") = false and instr(lCaseS, "byref") = false then
            s = " byref " & s 
        end if 
        if c <> "" then c = c & "," 
        c = c & s 
    next 
    'call echo("leftStr",leftStr)
    'call echo("rightStr",rightStr)
    'call echo("valueStr",valueStr)
    functionParamtoNet = leftStr & c & rightStr 
end function 

'call echo("单词",GetBeforeNStr("aa bb cc", "单词", 2))
'call echo("输入",GetBeforeNStr("""a a"" ""b b"" ""c  c""", "输入", 2))
'call echo("符号",GetBeforeNStr(" + - * / \ ", "符号", 2))
'call echo("数字",GetBeforeNStr(" 1 222.22 3 44", "数字", 2))
'call echo("数字",GetBeforeNStr(" aa - 333 ""a b c""", "全部", 2))
'获得下N个单词或其它等 (20050810)
function getBeforeNStr(content, sType, nNumb)
    dim splStr, sx, s, c, i, sYHCount, s1, s2, tempZc, nI 
    dim wc                                                                          '输入文本存储内容
    dim arrayWC(999)                                                                '输入文本数组内容
    dim arrayWCCount                                                                '输入文本数组内容总数
    dim zc                                                                          '单词存储内容
    dim arrayZC(999)                                                                '单词存储内容 数组
    dim arrayZCCount                                                                '单词存储内容 数组总数
    dim nc                                                                          '为数字累加
    dim arrayNC(999)                                                                '为数字累加 数组
    dim arrayNCCount                                                                '为数字累加 数组总数
    dim fc                                                                          '符号
    dim arrayFC(999)                                                                '符号 数组
    dim arrayFCCount                                                                '符号 数组总数

    dim arrayCountStr(999)                                                          '数组总内容
    dim nArrayCount                                                                 '数组总数


    dim yesOK                                                                       '是否OK
    dim tempS 
    dim upWord                                                                      '上一个变量
    dim upWord2                                                                     '上上一个变量
    dim endCode                                                                     '当前行字符往后面代码

    dim beforeStr                                                                   '前一个字符
    dim afterStr                                                                    '后一个字符
    dim rowC                                                                        '每行代码
    dim tempRow                                                                     '每行完整代码
    dim downRow                                                                     '下一行代码

    dim noteCode 

    sYHCount = 0                                                                    '双引号默认为0


    arrayWCCount = 0                                                                '输入文本数组内容总数
    arrayZCCount = 0                                                                '单词存储内容 数组总数
    arrayNCCount = 0                                                                '为数字累加 数组总数
    arrayFCCount = 0                                                                '符号 数组总数
    nArrayCount = 0                                                                 '数组总数




    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for nI = 0 to uBound(splStr)
        s = splStr(nI) 
        tempS = s 
        rowC = "" : tempRow = ""                                                        '清空每行ASP代码和暂存完整行代码
        noteCode = ""                                                                   '默认注释代码为空
        downRow = ""                                                                    '下一行代码
        if(nI + 1) <= uBound(splStr) then
            downRow = splStr(nI + 1) 
        end if 
        nc = ""                                                                         '数字为空

        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            beforeStr = right(replace(mid(s, 1, i - 1), " ", ""), 1)                        '上一个字符
            afterStr = left(replace(mid(s, i + 1), " ", ""), 1)                             '下一个字符
            endCode = mid(s, i + 1)                                                         '当前字符往后面代码 一行

            '输入文本
            if(sx = """" or wc <> "") then
                '双引号累加
                if sx = """" then sYHCount = sYHCount + 1 
                '判断是否"在最后
                if sYHCount mod 2 = 0 then
                    if mid(s, i + 1, 1) <> """" then
                        wc = wc & sx 
                        s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                      '必需放在这里，要不会出错

                        '处理输入内容
                        wc = right(wc, len(wc) - 1) 
                        wc = left(wc, len(wc) - 1) 
                        wc = replace(wc, """""", "\""") 
                        wc = """" & wc & """" 


                        arrayWCCount = arrayWCCount + 1                                              '输入文本数组内容总数
                        arrayWC(arrayWCCount) = wc                                                   '输入文本数组内容
                        nArrayCount = nArrayCount + 1                                                '数组总数
                        arrayCountStr(nArrayCount) = wc                                              '数组总内容

                        rowC = rowC & wc                                                             '函数代码累加
                        sYHCount = 0 : wc = ""                                                       '清除
                    else
                        wc = wc & sx 
                    end if 
                else
                    wc = wc & sx 
                end if 

            '+-*\=&   字符特殊处理
            elseIf inStr(".&=,+-*/:()><", sx) > 0 and nc = "" then
                if zc <> "" then
                    tempZc = zc 
                    upWord2 = upWord                                                                '记录上上一个变量
                    upWord = lCase(tempZc)                                                          '记录上一个变量名称   为小写
                    rowC = rowC & zc 
                    zc = ""                                                                         '清空字母内容
                end if 
                upWord2 = upWord                                                                '记录上上一个变量
                upWord = sx 

                arrayFCCount = arrayFCCount + 1                                                 '符号 数组总数
                arrayFC(arrayFCCount) = sx                                                      '符号 数组
                nArrayCount = nArrayCount + 1                                                   '数组总数
                arrayCountStr(nArrayCount) = sx                                                 '数组总内容

            elseIf sx = "'" then
                noteCode = "//" & mid(s, i + 1) 
                exit for 
            '字母
            elseIf checkABC(sx) = true or sx = "_" or zc <> "" then
                zc = zc & sx 
                yesOK = true 
                s1 = mid(s & " ", i + 1, 1) 
                s2 = mid(zc, 1, 1) 
                if checkABC(s1) <> true and s1 <> "_" then
                    yesOK = false 
                end if 
                '允许变量后面是数字
                if checkNumber(s1) = true and checkABC(s2) = true then
                    yesOK = true 
                end if 
                if yesOK = false then
                    'Rem注释
                    if lCase(zc) = "rem" then
                        sx = mid(s, i + 1) : i = i + len(sx) 
                        zc = zc & sx 
                    end if 


                    arrayZCCount = arrayZCCount + 1                                                 '单词存储内容 数组总数
                    arrayZC(arrayZCCount) = zc                                                      '单词存储内容 数组
                    nArrayCount = nArrayCount + 1                                                   '数组总数
                    arrayCountStr(nArrayCount) = zc                                                 '数组总内容

                    '注释则退出
                    tempZc = zc 

                    upWord2 = upWord                                                                '记录上上一个变量
                    upWord = lCase(tempZc)                                                          '记录上一个变量名称   为小写
                    rowC = rowC & zc 
                    zc = ""                                                                         '清空字母内容
                end if 
            '为数字
            elseIf checkNumber(sx) = true or nc <> "" then
                nc = nc & sx 
                if afterStr <> "." and checkNumber(afterStr) = false then
                    rowC = rowC & nc 


                    arrayNCCount = arrayNCCount + 1                                                 '为数字累加 数组总数
                    arrayNC(arrayNCCount) = nc                                                      '为数字累加 数组
                    nArrayCount = nArrayCount + 1                                                   '数组总数
                    arrayCountStr(nArrayCount) = nc                                                 '数组总内容


                    nc = "" 
                end if 
            else
                rowC = rowC & sx 
            end if 
            tempRow = tempRow & sx 
        next 
        c = c & rowC 
    next 


    if sType = "单词" then
        if uBound(arrayCountStr) >= nNumb then
            getBeforeNStr = arrayZC(nNumb) 
        end if 
    elseif sType = "输入" then
        if uBound(arrayCountStr) >= nNumb then
            getBeforeNStr = arrayWC(nNumb) 
        end if 
    elseif sType = "符号" then
        if uBound(arrayCountStr) >= nNumb then
            getBeforeNStr = arrayFC(nNumb) 
        end if 
    elseif sType = "数字" then
        if uBound(arrayCountStr) >= nNumb then
            getBeforeNStr = arrayNC(nNumb) 
        end if 
    elseif sType = "全部" then
        if uBound(arrayCountStr) >= nNumb then
            getBeforeNStr = arrayCountStr(nNumb) 
        end if 
    else
        getBeforeNStr = c 
    end if 
end function 


'获得字符串里的第一次出现的Dim变量组   call rw(getStrDim("  dim a, b,        c,d   "  & vbcrlf &" ss    'sdfasdf"))
function getStrDim(byval content)
    content = replace(replace(content, vbCrLf, ":"), vbTab, " ") 
    if instr(content, ":") > 0 then
        content = mid(content, 1, instr(content, ":") - 1) 
    end if 
    if instr(content, "'") > 0 then
        content = mid(content, 1, instr(content, "'") - 1) 
    end if 
    content = phptrim(content) 
    if left(content, 3) = "dim" then
        content = mid(content, 4) 
    end if 
    content = replace(content, " ", "") 
    dim splStr, s, c 
    if instr(content, "(") > 0 then
        splStr = split(content, ",") 
        for each s in splStr
            if s <> "" then
                if c <> "" then c = c & "," 
                if instr(s, "(") > 0 then
                    s = mid(s, 1, instr(s, "(") - 1) 
                end if 
                c = c & s 
            end if 
        next 
        content = c 
    end if 
    getStrDim = content 
end function 

'获得函数字符串里的变量组 call rw(getFunctionStrDim("aaa(ByVal Content,a,b,c,d)"))
function getFunctionStrDim(byval content)
    dim splStr, s, c, lCaseS 
    if instr(content, ")") > 0 then
        content = mid(content, 1, instr(content, ")") - 1) 
    end if 
    if instr(content, "(") > 0 then
        content = mid(content, instr(content, "(") + 1) 
    end if 
    content = replace(content, ",", " ") 
    splStr = split(content, " ") 
    for each s in splStr
        lCaseS = lcase(s) 
        if lCaseS <> "" and lCaseS <> "byval" and lCaseS <> "byref" then
            if c <> "" then c = c & "," 
            c = c & s 
        end if 
    next 
    getFunctionStrDim = c 
end function 



'Asp代码混淆处理
function aspCodeConfusion(content)
    dim splStr, i, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount, upWord 
    dim upWordn, tempS, dimList 
    dim yesFunction                                                                 '函数是否为真
    dim startFunction                                                               '开始函数 目的是为了让function default 处理函数后面没有()   20150218
    startFunction = false                                                           '默认开始函数为假
    'If nType="" Then  nType  = 0
    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                    sx = mid(s, i, 1) 
                    aspCode = aspCode & "<" 
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
                sx = mid(s, i, 1) 
                aspCode = aspCode & "%" 
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            wc = wc & sx 
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            aspCode = aspCode & wc                                                          '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        else
                            wc = wc & sx 
                        end if 
                    else
                        wc = wc & sx 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    aspCode = aspCode & mid(s, i) 
                    exit for 
                '字母
                elseIf checkABC(sx) = true or(sx = "_" and zc <> "") or zc <> "" then
                    zc = zc & sx 
                    s1 = lCase(mid(s & " ", i + 1, 1)) 
                    if inStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 and not(s1 = "_" and zc <> "") then'最简单判断
                        tempS = mid(s, i + 1) 

                        if inStr("|function|sub|", "|" & lCase(zc) & "|") then
                            '函数开始
                            if yesFunction = false and lCase(upWord) <> "end" then
                                yesFunction = true 
                                dimList = getFunDimName(tempS) 
                                startFunction = true 
                            elseIf yesFunction = true and lCase(upWord) = "end" then                        '获得上一个单词
                                yesFunction = false 
                            end if 
                        elseIf yesFunction = true and lCase(zc) = "dim" then
                            dimList = dimList & "," & getDimName(tempS) 
                        elseIf yesFunction = true then
                            '排除函数后面每一个名称
                            if startFunction = false then
                                zc = replaceDim2(dimList, zc) 
                            end if 
                            startFunction = false 
                        end if 
                        upWord = zc                                                                  '记住当前单词
                        aspCode = aspCode & zc 
                        zc = "" 
                    end if 
                else
                    aspCode = aspCode & sx 
                end if 
            else
                aspCode = aspCode & sx 
            end if 
            doEvents 
        next 
        aspCode = rTrim(aspCode)                                                        '去除右边空格
        aspCode = aspCode & vbCrLf                                                      'Asp换行
        doEvents 
    next 
    aspCodeConfusion = aspCode 
end function 
'Asp变量乱码 只对大小写乱
function ASPVariableGarbled(content)
    dim splStr, i, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount, upWord 
    dim upWordn, tempS, dimList 
    dim yesFunction                                                                 '函数是否为真
    'If nType="" Then  nType  = 0
    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                    sx = mid(s, i, 1) 
                    aspCode = aspCode & "<" 
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
                sx = mid(s, i, 1) 
                aspCode = aspCode & "%" 
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            wc = wc & sx 
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            aspCode = aspCode & wc                                                          '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        else
                            wc = wc & sx 
                        end if 
                    else
                        wc = wc & sx 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    aspCode = aspCode & mid(s, i) 
                    exit for 
                '字母
                elseIf checkABC(sx) = true or(sx = "_" and zc <> "") or zc <> "" then
                    zc = zc & sx 
                    s1 = lCase(mid(s & " ", i + 1, 1)) 
                    if inStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 and not(s1 = "_" and zc <> "") then'最简单判断
                        tempS = mid(s, i + 1) 

                        aspCode = aspCode & lUCaseGarbled(zc) 
                        zc = "" 
                    end if 
                else
                    aspCode = aspCode & sx 
                end if 
            else
                aspCode = aspCode & sx 
            end if 
            doEvents 
        next 
        aspCode = rTrim(aspCode)                                                        '去除右边空格
        aspCode = aspCode & vbCrLf                                                      'Asp换行
        doEvents 
    next 
    ASPVariableGarbled = aspCode 
end function 
'让大小写乱掉
function LUCaseGarbled(content)
    dim lenStr, splStr, i, s, c, numb 
    numb = 0 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        numb = numb + 1 

        if numb = 1 then
            s = lCase(s) 
        elseIf numb = 2 or numb = 3 then
            s = uCase(s) 
        elseIf numb = 4 then
            s = lCase(s) : numb = 1 
        end if 
        c = c & s 
    next 
    LUCaseGarbled = c 
end function 

'Asp函数名称混淆处理20160120   call rw(AspFunctionConfusion(getftext("5.asp")))
function aspFunctionConfusion(content)
    dim splStr, splxx, i, j, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount, upWord, nNumb 
    dim upWordn, tempS, funList 
    dim yesFunction                                                                 '函数是否为真
    dim startFunction                                                               '开始函数 目的是为了让function default 处理函数后面没有()   20150218
    startFunction = false                                                           '默认开始函数为假
    dim nFunIndex                                                                   '函数索引
    nFunIndex = 0 
    dim splNewFun 
    '注意as是不能用的
    splNewFun = split("aa|ab|ac|ad|ae|af|ag|ah|ai|aj|ak|al|am|an|ao|ap|aq|ar|at|au|av|aw|ax|ay|az|ba|bb|bc|bd|be|bf|bg|bh|bi|bj|bk|bl|bm|bn|bo|bp|bq|br|bs|bt|bu|bv|bw|bx|by|bz|ca|cb|cc|cd|ce|cf|cg|ch|ci|cj|ck|cl|cm|cn|co|cp|cq|cr|cs|ct|cu|cv", "|") 
    dim splYunFun, yunFunList 
    yunFunList = "|" & lCase(getAspFunNameList(content)) & "|" 
    splYunFun = split(yunFunList, "|") 

    'If nType="" Then  nType  = 0
    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0
    funList = "|"                                                                   '函数名称列表
    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                    sx = mid(s, i, 1) 
                    aspCode = aspCode & "<" 
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
                sx = mid(s, i, 1) 
                aspCode = aspCode & "%" 
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            wc = wc & sx 
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            aspCode = aspCode & wc                                                          '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        else
                            wc = wc & sx 
                        end if 
                    else
                        wc = wc & sx 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    aspCode = aspCode & mid(s, i) 
                    exit for 
                '字母
                elseIf checkABC(sx) = true or(sx = "_" and zc <> "") or zc <> "" then
                    zc = zc & sx 
                    s1 = lCase(mid(s & " ", i + 1, 1)) 
                    if inStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 and not(s1 = "_" and zc <> "") then'最简单判断
                        tempS = mid(s, i + 1) 
                        if inStr("|function|sub|", "|" & lCase(zc) & "|") then
                            '函数开始
                            if yesFunction = false and lCase(upWord) <> "end" and lCase(upWord) <> "exit" then
                                funList = funList & lCase(getFunName(tempS)) & "," & splNewFun(nFunIndex) & "|" 
                                nFunIndex = nFunIndex + 1 
                                'call echo("funList",funList)
                                startFunction = true 
                            elseIf yesFunction = true and lCase(upWord) = "end" then                        '获得上一个单词
                                startFunction = false 
                            end if 
                        elseIf yesFunction = true and lCase(zc) = "dim" then


                        end if 

                        nNumb = inStr(yunFunList, "|" & lCase(zc) & "|") 
                        if nNumb > 0 then
                            for j = 1 to uBound(splYunFun)
                                if splYunFun(j) = lCase(zc) then
                                    'call echo(zc,splNewFun(j))
                                    zc = splNewFun(j) 
                                    exit for 
                                end if 
                            next 
                        end if 

                        upWord = zc                                                                  '记住当前单词
                        aspCode = aspCode & zc 
                        zc = "" 
                    end if 
                else
                    aspCode = aspCode & sx 
                end if 
            else
                aspCode = aspCode & sx 
            end if 
            doEvents 
        next 
        aspCode = rTrim(aspCode)                                                        '去除右边空格
        aspCode = aspCode & vbCrLf                                                      'Asp换行
        doEvents 
    next 
    aspFunctionConfusion = aspCode 
end function 

'找ASP函数列表如：Sub a(b,c)
function findAspCode(byVal content)
    content = getAspCode(content) 
    content = getASPFunctionList(content)                                           '获得函数列表
    findAspCode = content 
end function 
'扫描ASP中函数名称列表
function findAspFunList(byVal content)
    dim splStr, nLen, subStr, s, tempS, c 
    content = findAspCode(content)                                                  '获得ASP代码
    splStr = split(content, vbCrLf) 
    for each s in splStr
        tempS = s : s = lCase(s) 
        if s <> "" then
            nLen = 0 
            if inStr(s, "function ") > 0 then
                nLen = inStr(s, "function ") + 8 
            elseIf inStr(s, "sub ") > 0 then
                nLen = inStr(s, "sub ") + 3 
            end if 
            if nLen > 0 then
                tempS = mid(tempS, nLen) 
                if inStr(tempS, "(") > 0 then
                    tempS = mid(tempS, 1, inStr(tempS, "(") - 1) 
                else
                    tempS = mid(tempS, 1, inStr(tempS & " ", " ") - 1) 
                end if 
                c = c & trim(tempS) & vbCrLf                                                    '去除函数名称两边空格
            end if 
        end if 
        doEvents 
    next 
    findAspFunList = c 
end function 

'找到指定Asp函数全部代码 感觉不精准
function findAspFunctionCode(byVal content, byVal functionName)
    dim functionType, splStr, s, c 
    if checkStr(functionName, "sub ") then
        functionType = "end sub" 
    else
        functionType = "end function" 
    end if 
    content = right(content, len(content) - inStr(lCase(content), lCase(functionName)) + 1) 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        c = c & s & vbCrLf 
        if checkStr(s, functionType) = true then exit for 
    next 
    findAspFunctionCode = c 
end function 
'获得函数名称与变量 ，加强版,添加于2013,10,5
function getFunNameDim(byVal c, funName, funDim)
    dim funType, s1, s2, funValue 
    c = trim(c) 
    if inStr(lCase(c), "sub ") > 0 then
        funType = "sub" 
    elseIf inStr(lCase(c), "function ") > 0 then
        funType = "function" 
    else
        exit function 
    end if 
    c = replace(c, ":", ")") & ")" 
    s1 = inStr(c, funType & " ") + len(funType & " ") 
    s2 = inStr(s1, c, ")") 
    c = mid(c, s1, s2 - s1) 
    funValue = funType & " " & c 
    if inStr(c, "(") > 0 then
        funName = left(c, inStr(c, "(") - 1) 
        if inStr(funName, " ") then
            funName = mid(funName, inStr(funName, " "))                                     '可把Priver与Public去除掉
        end if 
        funValue = funValue & ")" 
        s1 = inStr(funValue, "(") + 1 
        s2 = inStr(s1, funValue, ")") 
        funDim = mid(funValue, s1, s2 - s1) 
        funDim = regExp_Replace(funDim, "ByVal ", "")                                   'ByVal重新定义变更
        funDim = regExp_Replace(funDim, "ByRef ", "")                                   'ByRef为不重新定义变量,默认为它，也就量用上一级函数变量
        funDim = replace(funDim, " ", "") 
    else
        funName = c 
    end if 
    'Response.Write("FunType=" & FunType & "|C="&C&"|FunValue="&FunValue&"|FunName="&FunName&"|FunDim="&FunDim&"<hr>")
    getFunNameDim = funValue 
end function 
'在函数里加乱的Dim，这个Dim出现次数等于函数参数值，这个Dim是没有任何意思的
function inFunAddDim(byVal content)
    dim splStr, splxx, splTemp, s, i, vbCrlfNumb, funDimNumb, exceptNumb, c, rootNumb 
    splxx = split("A_p,B_p,C_4,D_2,E_4,F_9,G_1,H_2,I_2,J_3,K_1,L_o,M_m,N_u,O_o,P_n,Q_o,R_l,S_i,T_2,U_2,V_2,W_2,X_2,Y_2,Z_2", ",") 
    splStr = split(content, vbCrLf) 
    vbCrlfNumb = uBound(splStr) - 1                                                 '换行数
    s = strCut(content, "(", ")", 2) 
    splTemp = split(s, ",") 
    funDimNumb = uBound(splTemp) + 1                                                '函数
    '为0表示没有则退出，
    if funDimNumb = 0 then
        inFunAddDim = content 
        exit function 
    end if 
    exceptNumb = cInt(vbCrlfNumb / funDimNumb)                                      '除数
    rootNumb = 0 
    for i = 0 to uBound(splStr)
        s = splStr(i) 
        if trim(s) <> "" then
            c = c & splStr(i) & vbCrLf 
        end if 
        if exceptNumb <> 0 then
            if i mod exceptNumb = 0 and uBound(splTemp) >= rootNumb and i <> uBound(splStr) then
                c = c & "dIm " & splxx(rootNumb) & vbCrLf 
                rootNumb = rootNumb + 1 
            end if 
        end if 
    next 
    if c <> "" then c = left(c, len(c) - 2) 
    inFunAddDim = c 
end function 

'处理成AspExecute
function handleAspExecute(byVal content)
    dim splStr, s, c 
    if left(content, 2) = "<" & "%" then
        content = right(content, len(content) - 2) 
    end if 
    if right(content, 2) = "%" & ">" then
        content = left(content, len(content) - 2) 
    end if 
    'Content=Replace(Content,"""","""""")                '这个不需要，要不会出错
    splStr = split(content, vbCrLf) 
    for each s in splStr
        s = trimVbCrlf(s) 
        if s <> "" then
            c = c & s & ":" 
        end if 
    next 
    if c <> "" then c = left(c, len(c) - 1) 
    if left(c, 1) = "=" then c = "Response.Write " & right(c, len(c) - 1) 
    handleAspExecute = c 
end function 

'获得ASP函数名称列表 20160120 如  aa|bb|cc
function getAspFunNameList(content)
    dim splStr, splxx, i, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount, upWord, nNumb 
    dim upWordn, tempS, funList 
    dim yesFunction                                                                 '函数是否为真
    dim startFunction                                                               '开始函数 目的是为了让function default 处理函数后面没有()   20150218
    startFunction = false                                                           '默认开始函数为假
    'If nType="" Then  nType  = 0
    yesASP = false                                                                  '是ASP 默认为假
    yesFunction = false                                                             '是函数 默认为假
    yesWord = false                                                                 '是单词 默认为假
    sYHCount = 0                                                                    '双引号默认为0

    splStr = split(content, vbCrLf)                                                 '分割行
    '循环分行
    for each s in splStr
        '循环每个字符
        for i = 1 to len(s)
            sx = mid(s, i, 1) 
            'Asp开始
            if sx = "<" and wc = "" then                                                 '输出文本必需为空 Wc为输出内容 如"<%" 排除 修改于20140412
                if mid(s, i + 1, 1) = "%" then
                    yesASP = true                                                                   'ASP为真
                    i = i + 1                                                                       '加1而不能加2，要不然<%function Test() 就截取不到
                    sx = mid(s, i, 1) 
                    aspCode = aspCode & "<" 
                end if 
            'ASP结束
            elseIf sx = "%" and mid(s, i + 1, 1) = ">" and wc = "" then                     'Wc为输出内容
                yesASP = false                                                                  'ASP为假
                i = i + 1                                                                       '不能加2，只能加1，因为这里定义ASP为假，它会在下一次显示上面的 'ASP运行为假
                sx = mid(s, i, 1) 
                aspCode = aspCode & "%" 
            end if 
            if yesASP = true then
                '输入文本
                if(sx = """" or wc <> "") then
                    '双引号累加
                    if sx = """" then sYHCount = sYHCount + 1 
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            wc = wc & sx 
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            aspCode = aspCode & wc                                                          '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        else
                            wc = wc & sx 
                        end if 
                    else
                        wc = wc & sx 
                    end if 
                elseIf sx = "'" then                                                            '注释则退出
                    aspCode = aspCode & mid(s, i) 
                    exit for 
                '字母
                elseIf checkABC(sx) = true or(sx = "_" and zc <> "") or zc <> "" then
                    zc = zc & sx 
                    s1 = lCase(mid(s & " ", i + 1, 1)) 
                    if inStr("abcdefghijklmnopqrstuvwxyz0123456789", s1) = 0 and not(s1 = "_" and zc <> "") then'最简单判断
                        tempS = mid(s, i + 1) 
                        if inStr("|function|sub|", "|" & lCase(zc) & "|") then
                            '函数开始
                            if yesFunction = false and lCase(upWord) <> "end" and lCase(upWord) <> "exit" then
                                funList = funList & getFunName(tempS) & "|" 

                            end if 
                        end if 
                        upWord = zc                                                                  '记住当前单词
                        zc = "" 
                    end if 
                end if 
            end if 
            doEvents 
        next 
    next 
    getAspFunNameList = funList 
end function 
'ASP安全处理
function aspCodeSafe(content)

    '这是处理后会出错，因为它调用了多个文件了
    if inStr(content, "'【Asp函数" & "名称混淆】") > 0 then                         '不分开的话会处理此页
        content = aspFunctionConfusion(content)                                         'Asp函数名称混淆处理 20160120
    end if 
    content = delAspNote(content)                                                   '删除ASP里注释
    content = optimizeAspCode(content)                                              '优化ASP代码
    content = aspCodeConfusion(content)                                             'Asp代码混淆处理
    content = aSPVariableGarbled(content)                                           'Asp变量乱码 只对大小写乱
    aspCodeSafe = content 
end function 

%> 
