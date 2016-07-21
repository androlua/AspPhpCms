<% 


'处理替换列表 (ReplaceList改成handleReplaceList)为了兼容php程序
function handleReplaceList(byVal content, yStr, tStr)
    dim ySplStr, tSplStr, i, s 
    ySplStr = split(yStr, "|") 
    tSplStr = split(tStr & "||||||||||||||||||||||||||||||||", "|") 
    for i = 0 to uBound(ySplStr)
        s = ySplStr(i) 
        if s <> "" then
            content = replace(content, s, tSplStr(i)) 
        end if 
    next 
    handleReplaceList = content 
end function 

'从右边开始截取 作用：删除左边空格
function leftSpace(byVal content, byVal addNumb)
    dim i, nCount 
    nCount = 0 
    for i = len(content) to 1 step - 1
        if mid(content, i, 1) <> " " then exit for 
        nCount = nCount + 1 
    next 
    if nCount > addNumb and replace(content, " ", "") <> "" then
        content = left(content, len(content) - nCount + addNumb) 
    elseIf nCount < addNumb and 1 = 1 then
        for i = nCount to addNumb - 1
            content = content & " " 
        next 
    end if 
    leftSpace = content 
end function 
'从右边开始截取 作用：删除右边空格
function rightSpace(byVal content, byVal addNumb)
    dim i, nCount 
    nCount = 0 
    for i = 1 to len(content)
        if mid(content, i, 1) <> " " then exit for 
        nCount = nCount + 1 
    next 
    if nCount > addNumb then
        content = right(content, len(content) - nCount + addNumb) 
    elseIf nCount < addNumb then
        for i = nCount to addNumb - 1
            content = " " & content 
        next 
    end if 
    rightSpace = content 
end function 

'=============== 下面为2013,11,1添加
'获得QQ
function getQQ(byVal content, nOK)
    dim splStr, i, j, s, c, qQ, nErr, qQYes 
    content = replace(replace(lCase(content), "&nbsp;", ""), " ", "") 
    nOK = 0 
    if inStr(content, "qq") > 0 then
        splStr = split(content, "qq") 
        for i = 1 to uBound(splStr)
            s = splStr(i) 
            qQ = "" : nErr = 14 : qQYes = false 
            for j = 1 to len(s)
                if inStr("0123456789", mid(s, j, 1)) = false then
                    if qQYes = true then exit for                                                   'qq开始累加时则退出
                    if nErr = 0 then exit for                                                       '错误大于N退出
                    nErr = nErr - 1 
                    if mid(s, j, 1) = "群" then exit for                                            '为QQ群退出
                else
                    qQYes = true 
                    qQ = qQ & mid(s, j, 1) 
                end if 
                if j > 30 then exit for                                                         'j大于20退出
            next 
            if len(qQ) >= 6 and len(qQ) <= 10 and inStr(vbCrLf & c, vbCrLf & qQ & vbCrLf) = false then
                if inStr(vbCrLf & c, vbCrLf & qQ & vbCrLf) = false then
                    c = c & qQ & vbCrLf 
                    nOK = nOK + 1 
                end if 
            end if 
        next 
    end if 
    getQQ = c 
end function 
'获得手机
function getTel(byVal content, nOK)
    dim splStr, i, j, s, c, tel, nErr, telYes 
    content = replace(replace(lCase(content), "&nbsp;", ""), "手机", "tel") 
    nOK = 0 
    if inStr(content, "tel") > 0 then
        splStr = split(content, "tel") 
        for i = 1 to uBound(splStr)
            s = splStr(i) 
            tel = "" : nErr = 14 : telYes = false 
            for j = 1 to len(s)
                if inStr("0123456789", mid(s, j, 1)) = false then
                    if telYes = true then exit for                                                  'Tel开始累加时则退出
                    if nErr = 0 then exit for                                                       '错误大于N退出
                    nErr = nErr - 1 
                else
                    telYes = true 
                    tel = tel & mid(s, j, 1) 
                end if 
                if j > 30 then exit for                                                         'j大于20退出
            next 
            if len(tel) = 11 then
                if inStr(vbCrLf & c, vbCrLf & tel & vbCrLf) = false then
                    c = c & tel & vbCrLf 
                    nOK = nOK + 1 
                end if 
            end if 
        next 
    end if 
    getTel = c 
end function 
'获得邮箱
function getMail(byVal content, nOK)
    dim splStr, i, j, s, c, mail, nErr, mailYes 
    content = replace(replace(lCase(content), "&nbsp;", ""), "邮箱", "mail") 
    nOK = 0 
    if inStr(content, "mail") > 0 then
        splStr = split(content, "mail") 
        for i = 1 to uBound(splStr)
            s = splStr(i) 
            mail = "" : nErr = 14 : mailYes = false 
            for j = 1 to len(s)
                if inStr("0123456789abcdefghijklmnopqrstuvwxyz.@", mid(s, j, 1)) = false then
                    if mailYes = true then exit for                                                 'Mail开始累加时则退出
                    if nErr = 0 then exit for                                                       '错误大于N退出
                    nErr = nErr - 1 
                else
                    mailYes = true 
                    mail = mail & mid(s, j, 1) 
                end if 
                if j > 30 then exit for                                                         'j大于20退出
            next 
            if inStr(mail, ".") > 0 and inStr(mail, "@") > 0 then
                if inStr(vbCrLf & c, vbCrLf & mail & vbCrLf) = false then
                    c = c & mail & vbCrLf 
                    nOK = nOK + 1 
                end if 
            end if 
        next 
    end if 
    getMail = c 
end function 
'获得图片列表
function getImgStr(httpurl, content, nOK)
    dim splStr, i, c, url, urlList 
    content = getIMG(content) 
    splStr = split(content, vbCrLf) 
    nOK = 0 
    for each url in splStr
        if inStr("|" & urlList & "|", "|" & url & "|") = false then
            if left(url, 1) = "/" or(inStr(url, "http://") = false and inStr(url, "www.") = false) then
                url = fullHttpUrl(httpurl, url) 
            end if 
            nOK = nOK + 1 
            c = c & url & "<br>" 
        end if 
    next 
    getImgStr = c 
end function 
'获得Css列表
function getCssStr(httpurl, content, nOK)
    dim splStr, i, c, url, urlList 
    content = getCssHref(content) 
    splStr = split(content, vbCrLf) 
    nOK = 0 
    for each url in splStr
        if inStr("|" & urlList & "|", "|" & url & "|") = false then
            if left(url, 1) = "/" or(inStr(url, "http://") = false and inStr(url, "www.") = false) then
                url = fullHttpUrl(httpurl, url) 
            end if 
            nOK = nOK + 1 
            c = c & url & "<br>" 
        end if 
    next 
    getCssStr = c 
end function 
'获得Js列表
function getJsStr(httpurl, content, nOK)
    dim splStr, i, c, url, urlList 
    content = getJsSrc(content) 
    splStr = split(content, vbCrLf) 
    nOK = 0 
    for each url in splStr
        if inStr("|" & urlList & "|", "|" & url & "|") = false then
            if left(url, 1) = "/" or(inStr(url, "http://") = false and inStr(url, "www.") = false) then
                url = fullHttpUrl(httpurl, url) 
            end if 
            nOK = nOK + 1 
            c = c & url & "<br>" 
        end if 
    next 
    getJsStr = c 
end function 


'获得网址列表 Rw(GetUrlStr("", "链接", Content, "", 0))
function getUrlStr(httpurl, sType, content, searchValue, nOK)
    dim hrefList, splStr, title, url, c, s, lcaseUrl, urlList, titleList, sVal, sVal2 
    if sType = "链接" then
        hrefList = getAURL(content) 
    elseIf sType = "链接标题" then
        hrefList = getATitle(content) 
    else
        hrefList = getAURLTitle(content) 
    end if 
    splStr = split(hrefList, vbCrLf) 
    nOK = 0 
    for each s in splStr
        if s <> "" then
            if sType = "链接" then
                url = trim(s) 
                if inStr(lCase(url), "javascript:") = false and url <> "#" and url <> "" then
                    if inStr("|" & urlList & "|", "|" & url & "|") = false then
                        if left(url, 1) = "/" or(inStr(url, "http://") = false and inStr(url, "www.") = false) then
                            url = fullHttpUrl(httpurl, url) 
                        end if 
                        nOK = nOK + 1 
                        c = c & url & vbCrLf 
                    end if 
                end if 
            elseIf sType = "链接标题" then
                if inStr("|" & titleList & "|", "|" & s & "|") = false then
                    titleList = titleList & s & "|" 
                    nOK = nOK + 1 
                    c = c & s & vbCrLf 
                end if 
            else
                if inStr(s, "【_|-】") > 0 then
                    url = mid(s, 1, inStr(s, "【_|-】") - 1) : lcaseUrl = url 
                    title = mid(s, len(url) + 6) 
                    if inStr(lCase(lcaseUrl), "javascript:") = false and url <> "#" and url <> "" then
                        if inStr("|" & urlList & "|", "|" & url & "|") = false then
                            if left(url, 1) = "/" or(inStr(lcaseUrl, "http://") = false and inStr(lcaseUrl, "www.") = false) then
                                url = fullHttpUrl(httpurl, url) 
                            end if 
                            nOK = nOK + 1 
                            c = c & url & "   &nbsp;  " & title & vbCrLf 
                        end if 
                    end if 
                end if 
            end if 
        end if 
    next 
    if searchValue <> "" then
        searchValue = replace(searchValue, " and ", " And ") 
        splStr = split(searchValue, " And ") 
        sVal = splStr(0) 
        if uBound(splStr) > 0 then sVal2 = splStr(1) 
        splStr = split(c, vbCrLf) : nOK = 0 : c = "" 
        for each s in splStr
            if sVal2 <> "" then
                if inStr(s, sVal) > 0 and inStr(s, sVal2) > 0 then
                    if inStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = false then
                        nOK = nOK + 1 
                        c = c & s & "<br>" 
                    end if 
                end if 
            else
                if inStr(s, sVal) > 0 then
                    if inStr(vbCrLf & c & vbCrLf, vbCrLf & s & vbCrLf) = false then
                        nOK = nOK + 1 
                        c = c & s & "<br>" 
                    end if 
                end if 
            end if 
        next 
    end if 
    getUrlStr = c 
end function 
'获得Html中翻页配置 (采集用到)
function getPageConfig(httpurl, content, sType)
    dim splStr, i, s, s2, s3, c, url, tempUrl, arrUrl(99), urlList, pageUrl, nLen, splxx 
    content = getAURL(content) 
    splStr = split(content, vbCrLf) 
    for each url in splStr
        if url <> "" then
            tempUrl = url 
            if inStr(lCase(url), "javascript:") = false and url <> "#" then
                url = replace(replace(replace(replace(replace(url, "0", ""), "1", ""), "2", ""), "3", ""), "4", "") 
                url = replace(replace(replace(replace(replace(url, "5", ""), "6", ""), "7", ""), "8", ""), "9", "") 
                if sType = "注入" and inStr(url, "?") > 0 then url = handlSqlInUrl(url) 
                c = c & url & vbCrLf 
                nLen = inStr(vbCrLf & urlList, vbCrLf & url & "【】") 
                if nLen > 0 then
                    s = mid(urlList, nLen) 
                    s = mid(s, 1, inStr(s, vbCrLf) - 1) 
                    splxx = split(s, "【】") 
                    s2 = splxx(0) 
                    s3 = splxx(1) + 1 
                    urlList = replace(urlList, s, s2 & "【】" & s3 & "【】" & splxx(2)) 
                    pageUrl = url 
                else
                    urlList = urlList & url & "【】0【】" & fullHttpUrl(httpurl, tempUrl) & vbCrLf 
                end if 
            end if 
        end if 
    next 
    splStr = split(urlList, vbCrLf) : c = "" 
    if sType = "注入" then
        for each s in splStr
            if inStr(s, "【】") > 0 then
                splxx = split(s, "【】") 
                url = trim(splxx(2)) 
                if inStr(url, httpurl) > 0 then
                    if inStr(vbCrLf & c, vbCrLf & url & vbCrLf) = false then
                        c = c & url & vbCrLf 
                    end if 
                end if 
            end if 
        next 
        getPageConfig = c : exit function 
    end if 
    '处理出页配置
    for each s in splStr
        if inStr(s, "【】") > 0 then
            splxx = split(s, "【】") 
            if splxx(1) > 0 then arrUrl(splxx(1)) = splxx(0) & "  &nbsp; | &nbsp; " & splxx(2) 
        end if 
    next 
    for i = 99 to 0 step - 1
        if arrUrl(i) <> "" then
            if inStr(arrUrl(i), httpurl) > 0 then
                c = c & arrUrl(i) & "，   出现[" & i & "]次<br>" 
            end if 
        end if 
    next 
    getPageConfig = c 
end function 
'获得网页中注入网址
function getSqlInUrl(httpurl, content, sType)
    dim splStr, i, s, s2, s3, c, url, tempUrl, arrUrl(99), urlList, pageUrl, nLen, splxx 
    content = getAURL(content) 
    splStr = split(content, vbCrLf) 
    for each url in splStr
        if url <> "" then
            tempUrl = url 
            if inStr(url, "?") > 0 then
                c = c & url & vbCrLf 
                url = handlSqlInUrl(url) 
                nLen = inStr(vbCrLf & urlList, vbCrLf & url & "【】") 
                if nLen > 0 then
                    s = mid(urlList, nLen) 
                    s = mid(s, 1, inStr(s, vbCrLf) - 1) 
                    splxx = split(s, "【】") 
                    s2 = splxx(0) 
                    s3 = splxx(1) + 1 
                    urlList = replace(urlList, s, s2 & "【】" & s3 & "【】" & splxx(2)) 
                    pageUrl = url 
                else
                    urlList = urlList & url & "【】0【】" & fullHttpUrl(httpurl, tempUrl) & vbCrLf 
                end if 
            end if 
        end if 
    next 
    splStr = split(urlList, vbCrLf) 
    for each s in splStr
        if inStr(s, "【】") > 0 then
            splxx = split(s, "【】") 
            if s3 > 0 then
                if sType = "注入" then
                    arrUrl(splxx(1)) = splxx(2) 
                else
                    arrUrl(splxx(1)) = splxx(0) & "  &nbsp; | &nbsp; " & splxx(2) 
                end if 
            end if 
        end if 
    next 
    c = "" 
    for i = 99 to 0 step - 1
        if arrUrl(i) <> "" then
            if sType = "注入" then
                c = c & arrUrl(i) & vbCrLf 
            else
                c = c & arrUrl(i) & "，   出现[" & i & "]次<br>" 
            end if 
        end if 
    next 
    getSqlInUrl = c 
end function 
'处理注入网址，配置获得网站注入网址
function handlSqlInUrl(httpurl)
    dim url, splStr, i, s 
    splStr = split(httpurl, "=") 
    for i = 0 to uBound(splStr)
        if i = uBound(splStr) then url = url & "=" : exit for 
        s = splStr(i) 
        if i mod 2 = 0 then
            url = url & splStr(i) 
        else
            if inStr(s, "&") > 0 then
                url = url & "=" & mid(s, inStr(s, "&")) 
            end if 
        end if 
    next 
    handlSqlInUrl = url 
end function 

'获得扫描后函数名称列表
function getScanFunctionNameList(content)
    on error resume next 
    dim splStr, i, yesASP, yesWord, sx, s, wc, zc, s1, aspCode, sYHCount, upWord, funList, s2 
    dim upWordn, tempS, dimList 
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
                    '判断是否"在最后
                    if sYHCount mod 2 = 0 then
                        if mid(s, i + 1, 1) <> """" then
                            wc = wc & sx 
                            s1 = right(replace(mid(s, 1, i - len(wc)), " ", ""), 1)                         '必需放在这里，要不会出错
                            if yesFunction = true then aspCode = aspCode & wc                               '函数代码累加
                            sYHCount = 0 : wc = ""                                                          '清除
                        else
                            wc = wc & sx 
                        end if 
                    else
                        wc = wc & sx 
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
                                s2 = mid(s, i + 2) 
                                s2 = mid(s2, 1, inStr(s2, "(") - 1) 
                                funList = funList & s2 & vbCrLf 
                            elseIf yesFunction = true and lCase(upWord) = "end" then                        '获得上一个单词
                                aspCode = aspCode & zc & vbCrLf 

                                yesFunction = false 
                            end if 

                        end if 
                        upWord = zc                                                                     '记住当前单词
                        if yesFunction = true then aspCode = aspCode & zc 
                        zc = "" 
                    end if 

                end if 
            end if 
            doEvents 
        next 

    next 
    getScanFunctionNameList = funList 
end function 
'获得函数名称20150402
function getFunName(byVal c)
    if inStr(c, "(") > 0 then
        c = mid(c, 1, inStr(c, "(") - 1) 
        c = pHPTrim(c) 
    end if 
    getFunName = c 
end function 
'获得函数名称中变量
function getFunDimName(byVal c)
    dim startStr, endStr, s 
    c = lCase(c) 
    startStr = "(" 
    endStr = ")" 
    if inStr(c, startStr) > 0 and inStr(c, endStr) > 0 then
        c = strCut(c, startStr, endStr, 2) 
    end if 
    if c <> "" then
        c = replace(replace(c, "byref ", ""), "byref,", "") 
        c = replace(replace(c, "byval ", ""), "byval,", "") 
        c = replace(c, " ", "") 
    end if 
    getFunDimName = c 
end function 
'获得变量定义的名称
function getDimName(byVal c)
    dim startStr, endStr, s 
    c = lCase(c) 
    startStr = ":" 
    if inStr(c, startStr) > 0 then
        c = mid(c, 1, inStr(c, ":") - 1) 
    end if 
    if c <> "" then
        c = replace(replace(c, "byref ", ""), "byref,", "") 
        c = replace(replace(c, "byval ", ""), "byval,", "") 
        c = replace(c, " ", "") 
    end if 
    if inStr(c, "'") > 0 then
        c = pHPTrim(mid(c, 1, inStr(c, "'") - 1))                                       '刪除里面的'注释部分    20150330
    end if 
    getDimName = c 
end function 

'获得JS变量定义的名称
function getVarName(byVal content)
    dim splStr, i, s, c 
    content = lCase(content) 
    if inStr(content, ";") > 0 then
        content = mid(content, 1, inStr(content, ";") - 1) 
    end if 
    splStr = split(content, ",") 
    for each s in splStr
        if instr(s, "=") > 0 then
            s = mid(s, 1, instr(s, "=") - 1) 
        end if 
        s = trim(s) 
        if c <> "" then
            c = c & "," 
        end if 
        if s <> "" then
            c = c & s 
        end if 
    next 
    'call rwend(c)
    getVarName = c 
end function 


'获得Set变量定义的名称 暂时用不上
function getSetName(byVal c)
    c = pHPTrim(lCase(c)) 
    c = mid(c, 1, inStr(c, "=") - 1) 
    getSetName = trim(c) 
end function 
'替换变量
function replaceDim(byVal content)
    dim splStr, s, tempS, c, lCaseS, dimInTHNumb 
    splStr = split(content, ",") 
    for each s in splStr
        s = trim(s) 
        lCaseS = lCase(s) 
        if s <> "" then
            '对变量中()处理，
            if inStr(s, "(") > 0 then
                s = mid(s, 1, inStr(s, "(") - 1) 
            end if 
            dimInTHNumb = inStr(lCase(replaceDimList), "," & lCaseS & "=")                  '替换变量
            if dimInTHNumb > 0 then                                                         '替换变量
                tempS = mid(replaceDimList, dimInTHNumb + 1) 
                tempS = mid(tempS, 1, inStr(tempS, ",") - 1) 
                tempS = mid(tempS, inStr(tempS, "=") + 1) 
                if inStr(funDim & rootFunDim, "," & tempS & ",") = false then
                    s = tempS 
                end if 
            end if 
            c = c & s & "," 
        end if 
    next 
    if c <> "" then c = left(c, len(c) - 1) 
    replaceDim = c 
end function 
'替换变量名称(最优化处理) 加强于20141017
function replaceDim2(byVal dimList, dimName)
    dim ZD, splStr, i, s, nMod, nInt, c 
    replaceDim2 = dimName 
    ZD = "abcdefghijklmnopqrstuvwxyz" 
    dimName = lCase(dimName) 
    splStr = split(dimList, ",") 
    for i = 0 to uBound(splStr)
        s = splStr(i) 
        if s = dimName then
            nMod =(i) mod len(ZD) + 1 
            nInt = fix((i) / len(ZD)) 

            if nMod <> 0 then
                c = c & mid(ZD, nMod, 1) 
            end if 
            if nInt <> 0 then
                c = c & copyStr(mid(ZD, nInt, 1), nInt) 
            end if 
            'Call Echo(I,Len(ZD))
            'Call Echo("nMod",nMod)
            'Call Echo("nInt",nInt)
            'Call Echo("C",C)
            replaceDim2 = c 
            exit function 
        end if 
    next 
end function 
'找当前文件夹重复函数主程序
function findFolderRepeatFunction(folderPath)
    dim filePath, s, c, content, funs, funList, allFunList, nOK, nErr, splStr, splxx, nAllOK, nAllErr, nI 
    dim errFunList, allErrFunList 
    call handlePath(folderPath)                                                     '获得完整路径
    c = "操作文件夹" & folderPath & vbCrLf 
    content = getDirFileList(folderPath, "") 
    splStr = split(content, vbCrLf) : nI = 0 
    for each filePath in splStr
        nI = nI + 1 
        s = nI & "、" & filePath 
        content = getFText(filePath) 
        content = getScanFunctionNameList(content)                                      '获得ASP函数名称列表
        nOK = 0 : nErr = 0 : nAllOK = 0 : nAllErr = 0 : funList = "" : errFunList = "" : allErrFunList = "" 
        splxx = split(content, vbCrLf) 
        for each funs in splxx
            if funs <> "" then
                if inStr("|" & funList & "|", "|" & funs & "|") = 0 then
                    funList = funList & funs & "|" 
                    nOK = nOK + 1 
                else
                    errFunList = errFunList & funs & "|" 
                    nErr = nErr + 1 
                end if 
                if inStr("|" & allFunList & "|", "|" & funs & "|") = 0 then
                    allFunList = allFunList & funs & "|"                                            '全部函数
                    nAllOK = nAllOK + 1 
                else
                    allErrFunList = allErrFunList & funs & "|" 
                    nAllErr = nAllErr + 1 
                end if 
            end if 
            doEvents 
        next 
        'Call CreateFile("allfun.txt", AllFunList)
        c = c & s & "，函数（" & uBound(splStr) + 1 & "），重复(" & nErr & "[" & errFunList & "])全部函数重复(" & nAllErr & "[" & allErrFunList & "])" & vbCrLf 
        doEvents 
    next 
    findFolderRepeatFunction = c 
end function 
'找当前文件重复函数 (辅助)
function findFileRepeatFunction(filePath)
    findFileRepeatFunction = handleContentRepeatFunction(getFText("FilePath"), 2) 
end function 
'找当前内容重复函数
function findContentRepeatFunction(content)
    findContentRepeatFunction = handleContentRepeatFunction(contnet, 2) 
end function 
'处理内容重复函数列表 sType为0为不显示，1为显示函数列表，2为显示重复函数列表，3为显示函数与重复函数列表
function handleContentRepeatFunction(content, sType)
    dim c, funs, funList, nOK, nErr, splxx, errFunList 
    sType = cStr(sType) 
    content = getScanFunctionNameList(content)                                      '获得ASP函数名称列表
    nOK = 0 : nErr = 0 
    splxx = split(content, vbCrLf) 
    for each funs in splxx
        if funs <> "" then
            if inStr("|" & funList & "|", "|" & funs & "|") = 0 then
                funList = funList & funs & "|" 
                nOK = nOK + 1 
            else
                errFunList = errFunList & funs & vbCrLf 
                nErr = nErr + 1 
            end if 
        end if 
        doEvents 
    next 
    c = "找到函数共（" & uBound(splxx) + 1 & "），重复(" & nErr & ")" & vbCrLf 
    '函数列表
    if sType = "1" or sType = "3" then
        c = c & vbCrLf & "函数列表" & vbCrLf & funList 
    end if 
    '重复函数列表
    if errFunList <> "" and(sType = "1" or sType = "3") then
        c = c & vbCrLf & "重复函数列表" & vbCrLf & errFunList 
    end if 
    handleContentRepeatFunction = c 
end function 
'替换字符内容2 自己写得一个 区分大小写
function replace2(content, searchStr, replaceStr)
    dim leftStr, rightStr 
    if inStr(content, searchStr) > 0 then
        leftStr = mid(content, 1, inStr(content, searchStr) - 1) 
        rightStr = mid(content, len(leftStr) + len(searchStr) + 1) 
        content = leftStr & replaceStr & rightStr 
    end if 
    replace2 = content 
end function 
'替换全部字符内容2 自己写得一个 区分大小写
function allReplace(content, searchStr, replaceStr)
    dim leftStr, rightStr, i 
    for i = 1 to 99
        if inStr(content, searchStr) > 0 then
            leftStr = mid(content, 1, inStr(content, searchStr) - 1) 
            rightStr = mid(content, len(leftStr) + len(searchStr) + 1) 
            content = leftStr & replaceStr & rightStr 
        else
            exit for 
        end if 
    next 
    allReplace = content 
end function 
'替换一次，不区分大小写
function replaceOneNOLU(content, searchStr, replaceStr)
    dim leftStr, rightStr, lCaseContent 
    searchStr = lCase(searchStr) 
    lCaseContent = lCase(content) 
    if inStr(lCaseContent, searchStr) > 0 then
        leftStr = mid(content, 1, inStr(lCaseContent, searchStr) - 1) 
        rightStr = mid(content, len(leftStr) + len(searchStr) + 1) 
        content = leftStr & replaceStr & rightStr 
    end if 
    replaceOneNOLU = content 
end function 
'优化ASP代码 删除左右空格
function optimizeAspCode(content)
    dim splStr, s, c, i 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        s = trimVbTab(s) 
        if s <> "" then c = c & trimVbTab(s) & vbCrLf 
    next 
    optimizeAspCode = c 
end function 

'截取函数里大括号
function cutDaKuoHao(content)
    cutDaKuoHao = cutFunctionvValue(content, "{", "}") 
end function 
'截取函数里小括号
function cutXianKuoHao(content)
    cutXianKuoHao = cutFunctionvValue(content, "(", ")") 
end function 

'截取函数值20150716
function cutFunctionvValue(content, startStr, endStr)
    dim ku1, ku2, i, s, c 
    ku1 = 1 : ku2 = 0 
    for i = 1 to len(content)
        s = mid(content, i, 1) 
        c = c & s 
        if s = startStr then
            ku1 = ku1 + 1 
        elseIf s = endStr then 
            ku2 = ku2 + 1 
            if ku1 = ku2 then
                exit for 
            end if 
        end if 
    next 
    cutFunctionvValue = c 
end function 
'获得字符在内容里出现次数20150721
function getStrIntContentNumb(content, findStr)
    dim splStr 
    if inStr(content, findStr) > 0 then
        splStr = split(content, findStr) 
        getStrIntContentNumb = uBound(splStr) 
    else
        getStrIntContentNumb = 0 
    end if 
end function 
%>  
