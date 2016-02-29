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
'网站控制 20160223



'处理模块替换数组
Function handleModuleReplaceArray(ByVal content)
    Dim i, startStr, endStr, s, lableName 
    For i = 1 To UBound(ModuleReplaceArray) - 1
        If ModuleReplaceArray(i, 0) = "" Then
            Exit For 
        End If 
        'call echo(ModuleReplaceArray(i,0),ModuleReplaceArray(0,i))
        lableName = ModuleReplaceArray(i, 0) 
        s = ModuleReplaceArray(0, i) 
        If lableName = "【删除】" Then
            content = Replace(content, s, "") 
        Else
            startStr = "<replacestrname " & lableName & ">" : endStr = "</replacestrname " & lableName & ">" 
            If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
                content = replaceContentModule(content, startStr, endStr, s, "") 
            End If 
            startStr = "<replacestrname " & lableName & "/>" 
            If InStr(content, startStr) > 0 Then
                content = replaceContentRowModule(content, "<replacestrname " & lableName & "/>", s, "") 
            End If 
        End If 
    Next 
    handleModuleReplaceArray = content 
End Function 

'去掉模板里不需要显示内容 删除模板中我的注释代码
Function delTemplateMyNote(code)
    Dim startStr, endStr, i, s, handleNumb, splStr, Block, id 
    Dim content, DragSortCssStr, DragSortStart, DragSortEnd, DragSortValue, c 
    handleNumb = 99                                                                 '这里定义很重要

    '清除ReadBlockList读出块列表内容  不过有个不足的地方，读出内容可以从外部读出内容，这个以后考虑
    'Call Eerr("ReadBlockList",ReadBlockList)
    '写于20141118
    'splStr = Split(ReadBlockList, vbCrLf)                 '不用这种，复杂了
    '修改于20151230
    For i = 1 To handleNumb
        startStr = "<R#读出内容" : endStr = " start#>" 
        Block = StrCut(code, startStr, endStr, 2) 
        If Block <> "" Then
            startStr = "<R#读出内容" & Block & " start#>" : endStr = "<R#读出内容" & Block & " end#>" 
            If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
                s = StrCut(code, startStr, endStr, 1) 
                code = Replace(code, s, "")                                                     '移除
            End If 
        Else
            Exit For 
        End If 
    Next 


    If Request("gl") = "yun" Then
        content = GetFText("/Jquery/dragsort/Config.html") 
        content = GetFText("/Jquery/dragsort/模块拖拽.html") 
        'Css样式
        startStr = "<style>" 
        endStr = "</style>" 
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            DragSortCssStr = StrCut(content, startStr, endStr, 1) 
        End If 
        '开始部分
        startStr = "<!--#top start#-->" 
        endStr = "<!--#top end#-->" 
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            DragSortStart = StrCut(content, startStr, endStr, 2) 
        End If 
        '结束部分
        startStr = "<!--#foot start#-->" 
        endStr = "<!--#foot end#-->" 
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            DragSortEnd = StrCut(content, startStr, endStr, 2) 
        End If 
        '显示块内容
        startStr = "<!--#value start#-->" 
        endStr = "<!--#value end#-->" 
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            DragSortValue = StrCut(content, startStr, endStr, 2) 
        End If 



        '控制处理
        startStr = "<dIv datid='" 
        endStr = "</dIv>" 
        content = GetArray(code, startStr, endStr, False, False) 
        splStr = Split(content, "$Array$") 
        For Each s In splStr
            startStr = "【DatId】'" 
            id = Mid(s, 1, InStr(s, startStr) - 1) 
            s = Mid(s, InStr(s, startStr) + Len(startStr)) 
            'C=C & "<li><div title='"& Id &"'>" & vbcrlf & "<div " & S & "</div>"& vbcrlf &"<div class='clear'></div></div><div class='clear'></div></li>"
            s = "<div" & s & "</div>" 
            'Call Die(S)
            c = c & Replace(Replace(DragSortValue, "{$value$}", s), "{$id$", id) 
        Next 
        c = Replace(c, "【换行】", vbCrLf) 
        c = DragSortStart & c & DragSortEnd 
        code = Mid(code, 1, InStr(code, "<body>") - 1) 
        code = Replace(code, "</head>", DragSortCssStr & "</head></body>" & c & "</body></html>") 
    End If 

    '删除VB软件生成的垃圾代码
    startStr = "<dIv datid='" : endStr = "【DatId】'" 
    For i = 1 To handleNumb
        If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
            id = StrCut(code, startStr, endStr, 2) 
            code = Replace2(code, startStr & id & endStr, "<div ") 
        Else
            Exit For 
        End If 
    Next 
    code = Replace(code, "</dIv>", "</div>")                                  '替换成这个结束div

    '最外围清除
    startStr = "<!--#dialogteststart#-->" : endStr = "<!--#dialogtestend#-->" 
    code = Replace(code, "<!--#dialogtest start#-->", startStr) 
    code = Replace(code, "<!--#dialogtest end#-->", endStr) 
    For i = 1 To handleNumb
        If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
            s = StrCut(code, startStr, endStr, 1) 
            code = Replace2(code, s, "") 
        Else
            Exit For 
        End If 
    Next 
    '内转清除
    startStr = "<!--#teststart#-->" : endStr = "<!--#testend#-->" 
    code = Replace(code, "<!--#del start#-->", startStr)                         '与下面一样
    code = Replace(code, "<!--#del end#-->", endStr)                             '与下面一样 多样式
    code = Replace(code, "<!--#test start#-->", startStr) 
    code = Replace(code, "<!--#test end#-->", endStr) 

    For i = 1 To handleNumb
        If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
            s = StrCut(code, startStr, endStr, 1) 
            code = Replace2(code, s, "") 
        Else
            Exit For 
        End If 
    Next 
    '删除注释的span
    code = Replace(code, "<sPAn class=""testspan"">", "")                        '测试Span
    code = Replace(code, "<sPAn class=""testhidde"">", "")                       '隐藏Span
    code = Replace(code, "</sPAn>", "") 

    'delTemplateMyNote = Code:Exit Function

    startStr = "<!--#" : endStr = "#-->" 
    For i = 1 To handleNumb
        If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
            s = StrCut(code, startStr, endStr, 1) 
            code = Replace2(code, s, "") 
        Else
            Exit For 
        End If 
    Next 


    delTemplateMyNote = code 
End Function 


'处理常用函数附加参数    辅助类
'Dim Did,Sid,Tid,Title,TopNumb,CutStrNumb,AddSql
'Call HandleFunParameter(Action,Did,Sid,Tid,Title,TopNumb,CutStrNumb,AddSql)
Sub handleFunParameter(action, did, sid, tid, title, topNumb, cutStrNumb, addSql)
    Dim startStr, endStr 
    did = RParam(action, "Did") 
    sid = RParam(action, "Sid") 
    tid = RParam(action, "Tid") 

    did = IIF(did = "[$PubProDid$]", PubProDid, did) 
    sid = IIF(sid = "[$PubProSid$]", PubProSid, sid) 
    tid = IIF(tid = "[$PubProTid$]", PubProTid, tid) 

    title = RParam(action, "Title") 
    topNumb = RParam(action, "TopNumb") 
    cutStrNumb = RParam(action, "CutStrNumb") 
    If cutStrNumb = "" Then cutStrNumb = 28                                         '默认截取字符为32
    addSql = RParam(action, "AddSql") 
End Sub 
'处理替换参数值 20160114
Function handleReplaceValueParam(content, ByVal paramName, replaceStr)
    If InStr(content, "[$" & paramName) = False Then
        paramName = LCase(paramName) 
    End If 
    handleReplaceValueParam = replaceValueParam(content, paramName, replaceStr) 
End Function 

'替换参数值 2014  12 01
Function replaceValueParam(content, paramName, replaceStr)
    Dim startStr, endStr, labelStr, tempLabelStr, nLen, nTimeFormat, delHtmlYes, funStr, trimYes, s ,i
    Dim ifStr                                                                       '判断字符
    Dim elseIfStr                                                                   '第二判断字符
    Dim valueStr                                                                    '显示字符
    Dim elseStr                                                                     '否则字符
    Dim instrStr                                                                    '查找字符
	dim tempReplaceStr																'暂存
    'ReplaceStr = ReplaceStr & "这里面放上内容在这时碳呀。"
    'ReplaceStr = CStr(ReplaceStr)            '转成字符类型
    If IsNul(replaceStr) = True Then replaceStr = "" 
	tempReplaceStr=replaceStr
	
	'最多处理99个  20160225
	for i =1 to 99 
		replaceStr=tempReplaceStr													'恢复
		startStr = "[$" & paramName : endStr = "$]" 
		'字段名称严格判断 20160226
		If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 and (InStr(content, startStr & " ") > 0 or InStr(content, startStr & endStr) > 0) Then
			'获得对应字段加强版20151231
			If InStr(content, startStr & endStr) > 0 Then
				labelStr = startStr & endStr 
			ElseIf InStr(content, startStr & " ") > 0 Then
				labelStr = StrCut(content, startStr & " ", endStr, 1) 
			Else
				labelStr = StrCut(content, startStr, endStr, 1) 
			End If 
	 
			tempLabelStr = labelStr 
			labelStr = handleInModule(labelStr, "start") 
			'删除Html
			delHtmlYes = RParam(labelStr, "delHtml")                                        '是否删除Html
			If delHtmlYes = "true" Then replaceStr = Replace(DelHtml(replaceStr), "<", "&lt;") 'HTML处理
			'删除两边空格
			trimYes = RParam(labelStr, "trim")                                              '是否删除两边空格
			If trimYes = "true" Then replaceStr = TrimVbCrlf(replaceStr) 
	
			'截取字符处理
			nLen = RParam(labelStr, "len")                                                  '字符长度值
			nLen = HandleNumber(nLen) 
			'If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
			If nLen <> "" Then replaceStr = CutStr(replaceStr, nLen, "...")                 'Left(ReplaceStr,nLen)
	
			'时间处理
			nTimeFormat = RParam(labelStr, "format_Time")                                   '时间处理值
			If nTimeFormat <> "" Then
				replaceStr = Format_Time(replaceStr, nTimeFormat) 
			End If 
	
			'获得栏目名称
			s = RParam(labelStr, "getcolumnname") 
			If s <> "" Then
				If s = "@ME" Then
					s = replaceStr 
				End If 
				replaceStr = getcolumnname(s) 
			End If 
			'获得栏目URL
			s = RParam(labelStr, "getcolumnurl") 
			If s <> "" Then
				If s = "@ME" Then
					s = replaceStr 
				End If 
				replaceStr = getcolumnurl(s, "id") 
			End If 
	
			ifStr = RParam(labelStr, "if") 
			elseIfStr = RParam(labelStr, "elseif") 
			valueStr = RParam(labelStr, "value") 
			elseStr = RParam(labelStr, "else") 
			instrStr = RParam(labelStr, "instr")
			
			'call echo("ifStr",ifStr)
			'call echo("valueStr",valueStr)
			'call echo("elseStr",elseStr)
			'call echo("elseIfStr",elseIfStr)
			'call echo("replaceStr",replaceStr)
			If ifStr <> "" Or instrStr <> "" Then
				If(ifStr = CStr(replaceStr) And ifStr <> "") Or(elseIfStr = CStr(replaceStr) And elseIfStr <> "") Then
					replaceStr = valueStr 
				ElseIf InStr(CStr(replaceStr), instrStr) > 0 And instrStr <> "" Then
					replaceStr = valueStr 
				Else
					If elseStr <> "@ME" Then
						replaceStr = elseStr 
					End If 
				End If 
			End If 
	
			'函数处理20151231    [$title  function='left(@ME,40)'$]
			funStr = RParam(labelStr, "function")                                           '函数
			If funStr <> "" Then
				funStr = Replace(funStr, "@ME", replaceStr) 
				replaceStr = handleContentCode(funStr, "") 
			End If 
	
			'默认值
			s = RParam(labelStr, "default") 
			If s <> "" Then
				If replaceStr = "" Then
					replaceStr = s 
				End If 
			End If 
	
	
	
			'文本颜色
			s = RParam(labelStr, "fontcolor")                                               '函数
			If s <> "" Then
				replaceStr = "<font color=""" & s & """>" & replaceStr & "</font>" 
			End If 
			'call echo(tempLabelStr,replaceStr)
			content = Replace(content, tempLabelStr, replaceStr) 
		else
			exit for
		End If 
	next
    replaceValueParam = content 
End Function 
'call rwend(execute("replaceStr=testfunction(""ME"")") & replaceStr)
Function testfunction(s)
    testfunction = s & "(end)" 
End Function 



'显示编辑器20160115
Function displayEditor(action)
    Dim c 
    c = c & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shCore.js""></script> " & vbCrLf 
    c = c & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushJScript.js""></script>" & vbCrLf 
    c = c & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushPhp.js""></script> " & vbCrLf 
    c = c & "<script type=""text/javascript"" src=""\Jquery\syntaxhighlighter\scripts/shBrushVb.js""></script> " & vbCrLf 
    c = c & "<link type=""text/css"" rel=""stylesheet"" href=""\Jquery\syntaxhighlighter\styles/shCore.css""/>" & vbCrLf 
    c = c & "<link type=""text/css"" rel=""stylesheet"" href=""\Jquery\syntaxhighlighter\styles/shThemeDefault.css""/>" & vbCrLf 
    c = c & "<script type=""text/javascript"">" & vbCrLf 
    c = c & "    SyntaxHighlighter.config.clipboardSwf = '\Jquery\syntaxhighlighter\scripts/clipboard.swf';" & vbCrLf 
    c = c & "    SyntaxHighlighter.all();" & vbCrLf 
    c = c & "</script>" & vbCrLf 

    displayEditor = c 
End Function 
'处理网站url20160202
Function handleWebUrl(url)
    If Request("gl") <> "" Then
        url = getUrlAddToParam(url, "&gl=" & Request("gl"), "replace") 
    End If 
    If Request("templatedir") <> "" Then
        url = getUrlAddToParam(url, "&templatedir=" & Request("templatedir"), "replace") 
    End If 
    handleWebUrl = url 
End Function 

'
'处理在线修改
'MainContent = HandleDisplayOnlineEditDialog(""& adminDir &"NavManage.Asp?act=EditNavBig&Id=" & TempRs("Id") & "&n=" & GetRnd(11), MainContent,"style='float:right;padding:0 4px;'")
Function handleDisplayOnlineEditDialog(url, content, cssStyle, replaceStr)
    Dim controlStr, splStr, s, addOK 
    If Request("gl") = "edit" Then
        If InStr(url, "&") > 0 Then
            url = url & "&vbgl=true" 
        End If 
        addOK = False                                                                   '添加默认为假
        controlStr = getControlStr(url) & """" & cssStyle 
        If replaceStr <> "" Then
            splStr = Split(replaceStr, "|") 
            For Each s In splStr
                If s <> "" And InStr(content, s) > 0 Then
                    content = Replace2(content, s, s & controlStr) 
                    addOK = True 
                    Exit For 
                End If 
            Next 
        End If 
        If addOK = False Then
            '第一种
            'C = "<div "& ControlStr &">" & vbCrlf
            'C=C & Content & vbCrlf
            'C = C & "</div>" & vbCrlf
            'Content = C
            '第二种
            content = htmlAddAction(content, controlStr) 

        'Content = "<div "& ControlStr &">" & Content & "</div>"
        End If 
    End If 
    handleDisplayOnlineEditDialog = content 
End Function 
'获得控制内容
Function getControlStr(url)
    If Request("gl") = "edit" Then
        getControlStr = " onMouseMove=""onColor(this,'#FDFAC6','red')"" onMouseOut=""offColor(this,'','')"" onDblClick=""window1('" & url & "','信息修改')"" title='双击在线修改' oncontextmenu=""CommonMenu(event,this,'')" '删除网址为空
    End If 
End Function 

'html加动作(20151103)  call rw(htmlAddAction("  <a href=""javascript:;"">222222</a>", "onclick=""javascript:alert(111);"" "))
Function htmlAddAction(content, jsAction)
    Dim s, startStr, endStr, isHandle, lableName 
    s = content 
    s = phptrim(s) 
    startStr = Mid(s, 1, InStr(s, " ")) 
    endStr = ">" 
    isHandle = True 

    lableName = Trim(LCase(Replace(startStr, "<", ""))) 
    If InStr(s, startStr) = False Or InStr(s, endStr) = False Or InStr("|a|div|span|font|h1|h2|h3|h4|h5|h6|dt|dd|dl|li|ul|table|tr|td|", "|" & lableName & "|") = False Then
        isHandle = False 
    End If 

    If isHandle = True Then
        content = startStr & jsAction & Right(s, Len(s) - Len(startStr)) 
    End If 
    htmlAddAction = content 
End Function 


%> 
