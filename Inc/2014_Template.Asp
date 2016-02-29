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
'删除这种多余标签 <R#读出内容BlockName网站公告 start#>  <R#读出内容BlockName网站公告 end#>
'对模板处理

'VB不引用 Start
'读栏目并赋标题与内容值
Function readColumeSetTitle(action, id, ColumeTitle, ColumeContent)
    Dim TitleWidth                                                                  '标题宽度
    Dim TitleHeight                                                                 '标题高度
    Dim ContentHeight                                                               '内容高度
    Dim ContentWidth                                                                '内容宽度
    Dim ContentCss 

    TitleWidth = RParam(action, "TitleWidth")                                       '获得标题高度    待应用20150715
    TitleHeight = RParam(action, "TitleHeight")                                     '获得标题宽度
    ContentWidth = RParam(action, "ContentWidth")                                   '获得内容宽度
    ContentHeight = RParam(action, "ContentHeight")                                 '获得内容高度

    '标题宽
    TitleWidth = Trim(TitleWidth) 
    '自动加px单位，不加会无效果 20150115
    If Right(TitleHeight, 1) <> "%" And Right(TitleHeight, 2) <> "px" And TitleHeight <> "" And TitleHeight <> "auto" Then
        TitleHeight = TitleHeight & "px" 
    End If 
    If Right(TitleWidth, 1) <> "%" And Right(TitleWidth, 2) <> "px" And TitleWidth <> "" And TitleWidth <> "auto" Then
        TitleWidth = TitleWidth & "px" 
    End If 
    '内容高
    ContentHeight = Trim(ContentHeight) 
    '自动加px单位，不加会无效果 20150115
    If Right(ContentHeight, 1) <> "%" And Right(ContentHeight, 2) <> "px" And ContentHeight <> "" And ContentHeight <> "auto" Then
        ContentHeight = ContentHeight & "px" 
    End If 
    '内容宽
    ContentWidth = Trim(ContentWidth) 
    '自动加px单位，不加会无效果 20150115
    If Right(ContentWidth, 1) <> "%" And Right(ContentWidth, 2) <> "px" And ContentWidth <> "" And ContentWidth <> "auto" Then
        ContentWidth = ContentWidth & "px" 
    End If 

    If ContentHeight <> "" Then
        ContentCss = "height:" & ContentHeight & ";" 
    End If 
    If ContentWidth <> "" Then
        ContentCss = ContentCss & "width:" & ContentWidth & ";" 
    End If 

    Dim content 
    content = ReadColumn(id) 
    '标题宽
    If TitleWidth <> "" Then
        content = Replace(content, "<div class=""tvalue"">", "<div class=""tvalue"" style='width:" & TitleWidth & ";'>") 
    End If 
    '内容高
    If ContentCss <> "" Then
        content = Replace(content, "<div class=""ccontent"">", "<div class=""ccontent"" style='" & ContentCss & "'>") 
    End If 
    'call echo(ContentWidth,ContentCss)

    content = Replace(content, "栏目标题", ColumeTitle) 
    content = Replace(content, "栏目内容", ColumeContent) 
    readColumeSetTitle = content 
End Function 

'读栏目模块
Function readColumn(id)
    Dim templateFilePath, startStr, endStr, s 
    'Call Echo("WebTemplate",WebTemplate)
    templateFilePath = WebTemplate & "\Template_Left.html" 
    startStr = "/*columnlist" & id & "Start*/" 
    endStr = "/*columnlist" & id & "End*/" 
    s = ReadTemplateFileModular(templateFilePath, startStr, endStr) 
    If s = "[$NO$]" Then
        s = "Left样式ID[" & id & "]不存在" 
    End If 
    readColumn = s 
End Function 


'VB不引用 End


'读模板素材
Function readTemplateSource(id)
    Dim templateFilePath, startStr, endStr, s 
    templateFilePath = WebTemplate & "\TemplateSource.html" 
    startStr = "<!--#sourceHtml" & id & "Start#-->" 
    endStr = "<!--#sourceHtml" & id & "End#-->" 
    s = ReadTemplateFileModular(templateFilePath, startStr, endStr) 
    If s = "[$NO$]" Then
        s = "模板资源ID[" & id & "]不存在" 
    End If 
    readTemplateSource = s 
End Function 



'读模板文件中某模块
Function readTemplateFileModular(templateFilePath, startStr, endStr)
    Dim content 
    readTemplateFileModular = "" 
    content = GetFText(templateFilePath) 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        readTemplateFileModular = StrCut(content, startStr, endStr, 2) 
    Else
        readTemplateFileModular = "[$NO$]" 
    End If 
End Function 

'读文件模板素材
Function readTemplateFileSource(templateFilePath, id)
    Dim startStr, endStr, s, c 
    startStr = "<!--#sourceHtml" & Replace(id, ".html", "") & "Start#-->" 
    endStr = "<!--#sourceHtml" & Replace(id, ".html", "") & "End#-->" 
    s = readTemplateFileModular(templateFilePath, startStr, endStr) 
    If s = "[$NO$]" Then
        '加一个读取本文本里配置列表(20150815)
        c = GetStrCut(pubCode, startStr, endStr, 2) 
        If c <> "" Then
            readTemplateFileSource = c 
            'call rwend(c)
            Exit Function 
        End If 
        c = getftext(templateFilePath) 
        '存在 <!--#TemplateSplitStart#-->  就返回当前全部内容
        If InStr(c, "<!--#DialogStart#-->") > 0 Then
            readTemplateFileSource = c 
            Exit Function 
        End If 

        s = "模板资源ID[" & id & "]不存在,路径TemplateFilePath=" & handlePath(templateFilePath) 
    End If 
    readTemplateFileSource = s 
End Function 
'读出文件展示列表资源
Function readArticleListStyleSource(id)
    Dim filePath 
    filePath = getWebImages() & "\文章展示样式\" & id 
    If checkFile(filePath) = False Then
        filePath = WebTemplate & "\Resources\" & id 
    End If 
    'call echo(checkfile(filePath),filePath)
    readArticleListStyleSource = readTemplateFileSource(filePath, id) 

End Function 
'读出文件信息列表资源
Function readArticleInfoStyleSource(id)
    Dim filePath 
    filePath = getWebImages() & "\文章信息展示样式\" & id 
    If checkFile(filePath) = False Then
        filePath = WebTemplate & "\Resources\" & id 
    End If 
    readArticleInfoStyleSource = readTemplateFileSource(filePath, id) 
End Function 

%> 


