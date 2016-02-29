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
'格式化20150212


'Html格式化 简单版 加强于2014 12 09，20150709
Function htmlFormatting(content)
    htmlFormatting = HandleHtmlFormatting(content, False, 0, "") 
End Function 
'处理格式化
Function handleHtmlFormatting(ByVal content, isMsgBox, nErrLevel, action)
    Dim splStr, s, tempS, lCaseS, c, left4Str, left5Str, left6Str, left7Str, left8Str
    Dim nLevel                                                                      '级别
	dim elseS,elseLable

    Dim levelArray(299), keyWord 
    Dim lableName                                                                   '标签名称
    Dim isJavascript                                                                '为javascript
    Dim isTextarea                                                                  '为表单文本域<textarea
	dim isPre																		'为pre
    isJavascript = False                                                            '默认javascript为假
    isTextarea = False                                                              '表单文件域为假
	isPre=False																		'默认pre为假
    nLevel = 0                                                                      '级别数

    action = "|" & action & "|"                                                     '动作
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        tempS = s:elseS=s
        s = TrimVbCrlf(s) : lCaseS = LCase(s) 
        '判断于20150710
        If(Left(lCaseS, 8) = "<script " Or Left(lCaseS, 8) = "<script>") And InStr(s, "</script>") = False And isJavascript = False Then
            isJavascript = True 
            c = c & phptrim(tempS) & vbCrLf 
        ElseIf isJavascript = True Then

            If Left(lCaseS, 9) = "</script>" Then
                isJavascript = False 
                c = c & phptrim(tempS) & vbCrLf                                                 '最后清除两边空格
            Else
                c = c & tempS & vbCrLf                                                          '为js则显示原文本  不处理清空两边空格phptrim(tempS)
            End If 

        '表单文本域判断于20151019
        ElseIf(Left(lCaseS, 10) = "<textarea " Or Left(lCaseS, 10) = "<textarea>") And InStr(s, "</textarea>") = False And isTextarea = False Then
            isTextarea = True 
            c = c & phptrim(tempS) & vbCrLf 
        ElseIf isTextarea = True Then
            c = c & phptrim(tempS) & vbCrLf 
            If Left(lCaseS, 11) = "</textarea>" Then
                isTextarea = False 
            End If 
        '表单文本域判断于20151019
        ElseIf(Left(lCaseS, 5) = "<pre " Or Left(lCaseS, 5) = "<pre>") And InStr(s, "</pre>") = False And isPre = False Then
            isPre = True 
            c = c & phptrim(tempS) & vbCrLf  
        ElseIf isPre = True Then
            c = c & tempS & vbCrLf 
            If Left(lCaseS, 6) = "</pre>" Then
                isPre = False 
            End If  
			

        ElseIf s <> "" And isJavascript = False And isTextarea = False Then
            left4Str = "|" & Left(lCaseS, 4) & "|" : left5Str = "|" & Left(lCaseS, 5) & "|" : left6Str = "|" & Left(lCaseS, 6) & "|" 
            left7Str = "|" & Left(lCaseS, 7) & "|" : left8Str = "|" & Left(lCaseS, 8) & "|" 

            keyWord = ""                                                                    '关键词初始清空
            lableName = ""                                                                  '标签名称
            If InStr("|<ul>|<ul |<li>|<li |<dt>|<dt |<dl>|<dl |<dd>|<dd |<tr>|<tr |<td>|<td |", left4Str) > 0 Then
                keyWord = left4Str 
                lableName = Mid(left4Str, 3, 2) 
            ElseIf InStr("|<div>|<div |", left5Str) > 0 Then
                keyWord = left5Str 
                lableName = Mid(left5Str, 3, 3) 
            ElseIf InStr("|<span>|<span |<form>|<form |", left6Str) > 0 Then
                keyWord = left6Str 
                lableName = Mid(left6Str, 3, 4) 

            ElseIf InStr("|<table>|<table |<tbody>|<tbody |", left7Str) > 0 Then
                keyWord = left7Str 
                lableName = Mid(left7Str, 3, 5) 

            ElseIf InStr("|<center>|<center |", left8Str) > 0 Then
                keyWord = left8Str 
                lableName = Mid(left8Str, 3, 6)
            End If 
            keyWord = Trim(Replace(Replace(keyWord, "<", ""), ">", "")) 
            'call echo(KeyWord,lableName)
            '开始
            If keyWord <> "" Then
                s = CopyStr("    ", nLevel) & s 
                If Right(lCaseS, 3 + Len(lableName)) <> "</" & lableName & ">" And InStr(lCaseS, "</" & lableName & ">") = False Then
                    nLevel = nLevel + 1 
                    If nLevel >= 0 Then
                        levelArray(nLevel) = keyWord 
                    End If 
                End If 
            ElseIf InStr("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|", "|" & Left(lCaseS, 5) & "|") > 0 Or InStr("|</div>|", "|" & Left(lCaseS, 6) & "|") > 0 Or InStr("|</span>|</form>|", "|" & Left(lCaseS, 7) & "|") > 0 Or InStr("|</table>|</tbody>|", "|" & Left(lCaseS, 8) & "|") > 0 Or InStr("|</center>|", "|" & Left(lCaseS, 9) & "|") > 0 Then
                nLevel = nLevel - 1 
                s = CopyStr("    ", nLevel) & s 
            Else
                s = CopyStr("    ", nLevel) & s 
                '最后是结束标签则减一级
                If Right(lCaseS, 6) = "</div>" Then
                    If checkHtmlFormatting(lCaseS) = False Then
                        s = Left(s, Len(s) - 6) 
                        nLevel = nLevel - 1 
                        s = s & vbCrLf & CopyStr("    ", nLevel) & "</div>" 
                    End If 
                ElseIf Right(lCaseS, 7) = "</span>" Then
                    If checkHtmlFormatting(lCaseS) = False Then
                        s = Left(s, Len(s) - 7) 
                        nLevel = nLevel - 1 
                        s = s & vbCrLf & CopyStr("    ", nLevel) & "</span>" 
                    End If 
                ElseIf InStr("|</ul>|</dt>|<dl>|<dd>|", left5Str) > 0 Then
                    s = Left(s, Len(s) - 5) 
                    nLevel = nLevel - 1 
                    s = s & vbCrLf & CopyStr("    ", nLevel) & Right(lCaseS, 5) 
                End If
				
				
 				'对   aaa</li>   这种进处理   20160106
				elseS=phptrim(lcase(elseS))
				if instr(elseS,"</")>0 then
					elseLable=mid(elseS,instr(elseS,"</"))
					if InStr("|</ul>|</li>|</dl>|</dt>|</dd>|</tr>|</td>|</div>|</span>|<form>|", "|" & elseLable & "|") > 0 and nLevel>0 then
						nLevel = nLevel - 1 
					end if
				end if
				'call echo("s",replace(s,"<","&lt;"))
				
				
            End If 
            'call echo("",ShowHtml(temps)
            c = c & s & vbCrLf 
        ElseIf s = "" Then
            If InStr(action, "|delblankline|") = False And InStr(action, "|删除空行|") = False Then'删除空行
                c = c & vbCrLf 
            End If 
        End If 
    Next 
    handleHtmlFormatting = c 
    nErrLevel = nLevel                                                              '获得错误级别
    If nLevel <> 0 And(LCase(isMsgBox) = "1" Or LCase(isMsgBox) = "true") Then
        Call echo("HTML标签有错误", nLevel) 
    End If 
'Call Echo("nLevel",nLevel & "," & levelArray(nLevel))                '显示错误标题20150212
End Function 


'检测HTML标签是否成对出现 如（<div><ul><li>aa</li></ul></div></div>）
Function checkHtmlFormatting(ByVal content)
    Dim splStr, s, c, splxx, nLable, lableStr 
    content = LCase(content) 
    splStr = Split("ul|li|dt|dd|dl|div|span", "|") 
    For Each s In splStr
        s = phptrim(s) 
        If s <> "" Then
            nLable = 0 
            lableStr = "<" & s & " " 
            If InStr(content, lableStr) > 0 Then
                splxx = Split(content, lableStr) 
                nLable = nLable + UBound(splxx) 
            End If 
            lableStr = "<" & s & ">" 
            If InStr(content, lableStr) > 0 Then
                splxx = Split(content, lableStr) 
                nLable = nLable + UBound(splxx) 
            End If 
            lableStr = "</" & s & ">" 
            If InStr(content, lableStr) > 0 Then
                splxx = Split(content, lableStr) 
                nLable = nLable - UBound(splxx) 
            End If 
            'call echo(ShowHtml(lableStr),nLable)
            If nLable <> 0 Then
                checkHtmlFormatting = False 
                Exit Function 
            End If 
        End If 
    Next 
    checkHtmlFormatting = True 
End Function 

%>  
