<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'Html 处理HTML代码 (2014,1,3)

'HTML代码转码
Function showHTMLCode(str)
    If Not IsNull(str) Then
        str = Replace(str, " ", "&nbsp;") 
        str = Replace(str, "<", "&lt;") 
        str = Replace(str, ">", "&gt;") 
        str = Replace(str, "”", "&rdquo;") 
        str = Replace(str, "“", "&ldquo;") 
        str = Replace(str, "&", "&amp;") 
    End If 
    showHTMLCode = str 
End Function
 
'显示Html
Function showHtml(str)
    showHtml = Replace(str, "<", "&lt;") 
End Function
 
'HTML代码解码
Function unHTMLCode(str)
    If Not IsNull(str) Then
        str = Replace(str, "&nbsp;", " ") 
        str = Replace(str, "&lt;", "<") 
        str = Replace(str, "&gt;", ">") 
        str = Replace(str, "&rdquo;", "”") 
        str = Replace(str, "&ldquo;", "“") 
        str = Replace(str, "&mdash;", "—") 
        str = Replace(str, "&lsquo;", "‘") 
        str = Replace(str, "&rsquo;", "’") 

        str = Replace(str, "&amp;", "&") 

    End If 
    unHTMLCode = str 
End Function
 
'让HTML不运行显示
Function echoHTML(str)
    If Not IsNull(str) Then
        str = Replace(str, " ", "&nbsp;") 
        str = Replace(str, "<", "&lt;") 
    End If 
    echoHTML = str 
End Function
 

'ErrorText
Function errorText(Refresh, str, url)
    If Refresh<>"" Then 
		rw("<meta http-equiv=""refresh"" content=""" & Refresh & ";URL=" & url & """"""">") & vbCrLf 
    end if
	rw("<fieldset>") & vbCrLf 
    rw("<legend>&nbsp;Report&nbsp;</legend>") & vbCrLf 
    rw("<div style=""padding-left:20px;padding-top:10px;color:red;font-weight:bold;text-align:center;"">" & str & "</div>") & vbCrLf 
    rw("<div style=""height:200p;text-align:center;""><P>") & vbCrLf 
    rw("<a href=""" & url & """>如果您的游览器没有自动跳转,请点这里>></a><P>") & vbCrLf 
    rw("</div></fieldset>") : Response.End() 
End Function
 

'---------------------- Html处理 Start ----------------------
'测试Html显示20141217 待测试
Sub testHtml()
    Dim s 
    s = "<font style=""font-size:12px"">显示<b>1</b></font>" 
    Call echo("S", s) 
    s = HTMLEncode(s) 
    Call echo("S", s) 
    s = HtmlDecode(s) 
    Call echo("S", s) 
    s = HtmlFilter(s) 
    Call echo("S", s) 
End Sub
 
'Html解密
Function htmlDecode(ByVal str)
    If Not IsNul(str) Then
        str = regReplace(str, "<br\s*/?\s*>", vbCrLf) 
        str = Replace(str, "&nbsp;&nbsp; &nbsp;", Chr(9)) 
        str = Replace(str, "&quot;", Chr(34)) 
        str = Replace(str, "&nbsp;", Chr(32)) 
        str = Replace(str, "&#39;", Chr(39)) 
        str = Replace(str, "&apos;", Chr(39)) 
        str = Replace(str, "&gt;", ">") 
        str = Replace(str, "&lt;", "<") 
        str = Replace(str, "&amp;", Chr(38)) 
        str = Replace(str, "&#38;", Chr(38)) 
        htmlDecode = str 
    End If 
End Function
 
'Html加密
Function htmlEncode(ByVal str)
    If Not IsNul(str) Then
        str = Replace(str, Chr(38), "&#38;") 
        str = Replace(str, "<", "&lt;") 
        str = Replace(str, ">", "&gt;") 
        str = Replace(str, Chr(39), "&#39;") 
        str = Replace(str, Chr(32), "&nbsp;") 
        str = Replace(str, Chr(34), "&quot;") 
        str = Replace(str, Chr(9), "&nbsp;&nbsp; &nbsp;") 
        str = Replace(str, vbCrLf, "<br />") 
    End If 
    htmlEncode = str 
End Function
 
'HTML过虑
Function htmlFilter(ByVal str)
    str = regReplace(str, "<[^>]+>", "") 
    str = Replace(str, ">", "&gt;") 
    str = Replace(str, "<", "&lt;") 
    htmlFilter = str 
End Function



Function regReplace(ByVal str, ByVal rule, ByVal Result)
    regReplace = Easp_Replace(str, rule, Result, 0) 
End Function
 
Function easp_Replace(ByVal str, ByVal rule, ByVal Result, ByVal isM)
    Dim tmpStr, reg : tmpStr = str 
    If Not IsNul(str) Then
        Set reg = CreateObject("VBscript.RegExp")
            reg.Global = True 
            reg.IgnoreCase = True 
            If isM = 1 Then reg.Multiline = True 
            reg.pattern = rule 
            tmpStr = reg.Replace(tmpStr, Result) 
        Set reg = Nothing 
    End If 
    easp_Replace = tmpStr 

End Function
 
'---------------------- Html处理 End ----------------------











'处理Html标签闭合(20150831) 第一种，淘汰
Function handleHtmlLabelClose(content, labelName, isAddAlt)
    Dim startStr, endStr, splStr, s, ImgList, imgStr, LCaseImgStr, newImgStr 
    startStr = "<" & labelName : endStr = ">" 
    ImgList = GetArray(content, startStr, endStr, True, False) 
    'call rw(ImgList)
    splStr = Split(ImgList, "$Array$") 
    For Each imgStr In splStr
        newImgStr = phpTrim(imgStr) 
        If Right(newImgStr, 1) = "/" Then
            newImgStr = PHPTrim(Left(newImgStr, Len(newImgStr) - 1)) 
        End If 
        If isAddAlt = True Then
            LCaseImgStr = LCase(imgStr) 
            If InStr(LCaseImgStr, "alt") = False Then
                newImgStr = newImgStr & " alt=""""" 
            End If 
        End If 
        content = Replace(content, imgStr & ">", newImgStr & " />") 
    Next 
    handleHtmlLabelClose = content 
End Function
 

'处理图片闭合(20150831)
Function handleImgClose(content, isAddAlt)
    handleImgClose = handleHtmlLabelClose(content, "img", isAddAlt) 
End Function
 
'处理BR闭合(20150831)
Function handleBrClose(content, isAddAlt)
    handleBrClose = handleHtmlLabelClose(content, "br", False) 
    handleBrClose = Replace(handleBrClose, "<br>", "<br />") 
End Function
 
'处理HR闭合(20150831)
Function handleHrClose(content, isAddAlt)
    handleHrClose = handleHtmlLabelClose(content, "hr", False) 
    handleHrClose = Replace(handleHrClose, "<hr>", "<hr />") 
End Function
 




'处理闭合HTML标签(20150902)  比上面的更好用 第二种
Function handleCloseHtml(content, ImgAddAlt, action)
    Dim i, endStr, s, s2, c, labelName, startLabel, endLabel 
    action = "|" & action & "|" 
    startLabel = "<" 
    endLabel = ">" 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        endStr = Mid(content, i) 
        If s = "<" Then
            If InStr(endStr, ">") > 0 Then
                s = Mid(endStr, 1, InStr(endStr, ">")) 
                i = i + Len(s) - 1 
                s = Mid(s, 2, Len(s) - 2) 
                s = phptrim(s) 
                If Right(s, 1) = "/" Then
                    s = phptrim(Left(s, Len(s) - 1)) 
                End If 
                endStr = Right(endStr, Len(endStr) - Len(s) - 2)                                '最后字符减去当前标签  -2是因为它有<>二个字符
                '注意之前放在labelName下面
                labelName = Mid(s, 1, InStr(s & " ", " ") - 1) 
                labelName = LCase(labelName) 
                'call eerr("s",s)

                If InStr(action, "|处理A链接|") > 0 Then
                    s = htmlLabelToClean(s, labelName, "http://127.0.0.1/TestWeb/Web/", "处理A链接") '处理干净html标签
                ElseIf InStr(action, "|处理A链接第二种|") > 0 Then
                    s = htmlLabelToClean(s, labelName, "http://127.0.0.1/debugRemoteWeb.asp?url=", "处理A链接") '处理干净html标签
                Else
                    s = htmlLabelToClean(s, labelName, "", "")                                      '处理干净html标签
                End If 

                'call echo(s,labelName)   param与embed是Flash用到，不过embed有结束标签的
                If InStr("|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|", "|" & labelName & "|") > 0 Then
                    s = Replace(Replace(Replace(Replace(s, " class=""""", ""), " alt=""""", ""), " title=""""", ""), " name=""""", "") '临时这么做一下，以后要完整系统的做
                    s = Replace(Replace(Replace(Replace(s, " class=''", ""), " alt=''", ""), " title=''", ""), " name=''", "") 
                    '给vb.net软件用的 要不然它会报错，晕
                    If labelName = "img" And ImgAddAlt = True Then
                        If InStr(s, " alt") = False Then
                            s = s & " alt=""""" 
                        End If 
                        s = Trim(s) 
                        s = s & " /" 
                    '补齐<script>20160106  暂时不能用这个，等改进
                    ElseIf labelName = "script" Then
                        If InStr(s, " type") = False Then
                            s = s & " type=""text/javascript""" 
                        End If 
                    End If 
                End If 
                s = startLabel & s & endLabel 
                '处理javascript script部分
                If labelName = "script" Then
                    s2 = Mid(endStr, 1, InStr(endStr, "</script>") + 8) 

                    'call eerr("",s2)
                    i = i + Len(s2) 
                    s = s & s2 
                End If 
            'call echo("s",replace(s,"<","&lt;"))
            End If 
        End If 
        c = c & s 
    Next 
    handleCloseHtml = c 
End Function
 
Function htmlLabelToClean(ByVal content, labelName, addToHttpUrl, action)
    Dim i, s, c, temp 
    Dim isValue                                                                     '是否为内容值
    Dim valueStr                                                                    '存储内容值
    Dim yinghaoLabel                                                                '引号类型如'"
    Dim parentName                                                                  '参数名称
    Dim behindStr                                                                   '后面全部字符
    Dim noDanYinShuangYinStr                                                        '不是单引号和双引号字符
    action = "|" & action & "|" 
    content = Replace(content & " ", vbTab, " ")                                    '退格替换成空格，最后加一个空格，方便计算
    content = Replace(Replace(content, " =", "="), " =", "=") 
    isValue = False                                                                 '默认内容为假，因为先是获得标签名称
    For i = 1 To Len(content)
        s = Mid(content, i, 1)                                                          '获得当前一个字符
        behindStr = Mid(content, i)                                                     '后面字符
        If s = "=" And isValue = False Then                                             '不是内容值，并为=号
            isValue = True 
            valueStr = "" 
            yinghaoLabel = "" 
            If c <> "" And Right(c, 1) <> " " Then c = c & " " 
            parentName = LCase(temp)                                 '参数名称转小写
            c = c & parentName & s 
            temp = "" 
        '获得值第一个字符，因为它是引号类型
        ElseIf isValue = True And yinghaoLabel = "" Then
            If s <> " " Then
                If s <> "'" And s <> """" Then
                    noDanYinShuangYinStr = s                                                        '不是单引号和双引号字符
                    s = " " 
                End If 
                yinghaoLabel = s 
            'call echo("yinghaoLabel",yinghaoLabel)
            End If 
        ElseIf isValue = True And yinghaoLabel <> "" Then
            '为引号结束
            If yinghaoLabel = s Then
                isValue = False 
                If labelName = "a" And parentName = "href" And InStr(action, "|处理A链接|") > 0 Then
                    '处理
                    If InStr(valueStr, "?") > 0 Then
                        valueStr = Replace(valueStr, "?", "WenHao") & ".html" 
                    End If 
                    If InStr("|asp|php|aspx|jsp|", "|" & LCase(Mid(valueStr, InStrRev(valueStr, ".") + 1)) & "|") > 0 Then
                        valueStr = valueStr & ".html" 
                    End If 
                    valueStr = addToOrAddHttpUrl(addToHttpUrl, valueStr, "替换") 

                End If 
                'call echo("labelName",labelName)
                If yinghaoLabel = " " Then
                    c = c & """" & noDanYinShuangYinStr & valueStr & """ "                          '追加 不是单引号和双引号字符            补全
                Else
                    c = c & yinghaoLabel & valueStr & yinghaoLabel                                  '追加 不是单引号和双引号字符
                End If 
                yinghaoLabel = "" 
                noDanYinShuangYinStr = ""                                                       '不是单引号和双引号字符 清空
            Else
                valueStr = valueStr & s 
            End If 
        '为 分割
        ElseIf s = " " Then
            '暂存内容不为空
            If temp <> "" Then
                If Left(Trim(behindStr) & " ", 1) = "=" Then
                '后面一个字符等于=不处理
                Else
                    '为标签
                    If isValue = False Then
                        temp = LCase(temp) & " "                              '标签类型名称转小写
                    End If 
                    c = c & temp 
                    temp = "" 
                End If 
            End If 
        Else
            temp = temp & s 
        End If 

    Next 
    c = Trim(c) 
    htmlLabelToClean = c 
End Function
 
'追加或替换网址(20150922)   addToOrAddHttpUrl("http://127.0.0.1/aa/","http://127.0.0.1/4.asp","替换")
Function addToOrAddHttpUrl(httpUrl, ByVal url, action)
    Dim s 
    action = "|" & action & "|" 
    If InStr(action, "|替换|") > 0 Then
        s = getwebsite(url) 
        If s <> "" Then
            url = Replace(url, s, "") 
        End If 
    End If 
    If InStr(url, httpUrl) = False Then
        If Right(httpUrl, 1) = "/" And(Left(url, 1) = "/" Or Left(url, 1) = "\") Then
            url = Mid(url, 2) 
        End If 
        url = httpUrl & url 
    End If 

    addToOrAddHttpUrl = url 
End Function
 
'删除html里空行 最笨的方法 删除空行
Function removeBlankLines(content)
    Dim s, c, splStr 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        If Replace(Replace(s, vbTab, ""), " ", "") <> "" Then
            If c <> "" Then c = c & vbCrLf 
            c = c & s 
        End If 
    Next 
    removeBlankLines = c 
End Function
 
Function removeBlankLines_test1(content)
    Dim i 
    For i = 1 To 9
        content = Replace(content, vbCrLf & vbCrLf, vbCrLf) 
    Next 
    removeBlankLines_test1 = content 
End Function
 
'空网页内容 20160108
Function blankHtmlBody(webTitle, webBody)
    Dim c 
    c = "<!DOCTYPE html PUBLIC>" & vbCrLf 
    c = c & "<html xmlns=""http://www.w3.org/1999/xhtml"">" & vbCrLf 
    c = c & "<head>" & vbCrLf 
    c = c & "<meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312"" />" & vbCrLf 
    c = c & "<title>" & webTitle & "</title>" & vbCrLf 
    c = c & "</head>" & vbCrLf 
    c = c & "<body>" & vbCrLf 
    c = c & webBody & vbCrLf 
    c = c & "</body>" & vbCrLf 
    c = c & "</html>" & vbCrLf 
    blankHtmlBody = c 
End Function
 


%> 

