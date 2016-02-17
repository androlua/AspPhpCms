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





















Function infoColor(a, b)
    If b <> "" Then a = "<font color=" & b & ">" & a & "</font>"
    infoColor = a
End Function

Function imgError()
    imgError = " onerror=""this.src='/UploadFiles/NoImg.jpg'"""
End Function

Function targetStr(ByVal a)
    If a <> "" Then
        targetStr = " target='" & a & "'"
    End If
End Function

Function aTarget(a)
    aTarget = targetStr(a)
End Function

Function aTitle(ByVal a)
    If a <> "" Then
        aTitle = " Title='" & a & "'"
    End If
End Function

Function imgAlt(ByVal a)
    If a <> "" Then
        imgAlt = " alt='" & a & "'"
    End If
End Function

Function imgTitleAlt(ByVal a)
    If a <> "" Then
        imgTitleAlt = " alt='" & a & "' title='" & a & "'"
    End If
End Function

Function aRel(ByVal a)
    If a = True Then
        aRel = " rel='nofollow'"
    End If
End Function

Function styleClass(ByVal a)
    If a <> "" Then
        styleClass = " class='" & a & "'"
    End If
End Function

Function textFontB(ByVal a, b)
    If b = True Then
        a = "<strong>" & a & "</strong>"
    End If
    textFontB = a
End Function

Function textFontColor(ByVal a, b)
    If b <> "" Then
        a = "<font color='" & b & "'>" & a & "</font>"
    End If
    textFontColor = a
End Function

Function fontColorFontB(a, b, c)
    fontColorFontB = textFontColor(textFontB(a, b), c)
End Function

Function getDefaultFileName()
    getDefaultFileName = Format_Time(Now(), 6)
End Function

Function aHref(a, b, c)
    a = HandleHttpUrl(a)
    aHref = "href='" & a & "'" & aTitle(b) & aTarget(c)
End Function

Function imgSrc(a, b, c)
    a = HandleHttpUrl(a)
    imgSrc = "src='" & a & "'" & aTitle(b) & imgAlt(b) & aTarget(c)
End Function




Function selectTarget(a)
    Dim b, c
    b = b & "<select name=""Target"" id=""Target"">" & vbCrLf
    b = b & "  <option value=''>链接打开方式</option>" & vbCrLf
    If a = "" Then c = " selected" Else c = ""
    b = b & "  <option" & c & " value=''>本页打开</option>" & vbCrLf
    If a = "_blank" Then c = " selected" Else c = ""
    b = b & "  <option value=""_blank""" & c & ">新页打开</option>" & vbCrLf
    If a = "Index" Then c = " selected" Else c = ""
    b = b & "  <option value=""Index""" & c & ">Index页打开</option>" & vbCrLf
    If a = "Main" Then c = " selected" Else c = ""
    b = b & "  <option value=""Main""" & c & ">Main页打开</option>" & vbCrLf
    b = b & "</select>" & vbCrLf
    selectTarget = b
End Function

Function selectFontColor(a)
    Dim b, c
    b = b & "  <select name=""FontColor"" id=""FontColor"">" & vbCrLf
    b = b & "    <option value=''>文本颜色</option>" & vbCrLf
    If a = "Red" Then c = " selected" Else c = ""
    b = b & "    <option value=""Red"" class=""FontColor_Red""" & c & ">红色</option>" & vbCrLf
    If a = "Blue" Then c = " selected" Else c = ""
    b = b & "    <option value=""Blue"" class=""FontColor_Blue""" & c & ">蓝色</option>" & vbCrLf
    If a = "Green" Then c = " selected" Else c = ""
    b = b & "    <option value=""Green"" class=""FontColor_Green""" & c & ">绿色</option>" & vbCrLf
    If a = "Black" Then c = " selected" Else c = ""
    b = b & "    <option value=""Black"" class=""FontColor_Black""" & c & ">黑色</option>" & vbCrLf
    If a = "White" Then c = " selected" Else c = ""
    b = b & "    <option value=""White"" class=""FontColor_White""" & c & ">白色</option>" & vbCrLf
    b = b & "  </select>" & vbCrLf
    selectFontColor = b
End Function

Function selectSex(a)
    Dim b, c
    b = b & "  <select name=""FontColor"" id=""FontColor"">" & vbCrLf
    b = b & "    <option value=""男"">男</option>" & vbCrLf
    c = IIf(a = "女", " selected", "")
    b = b & "    <option value=""女""" & c & ">女</option>" & vbCrLf
    b = b & "  </select>" & vbCrLf
    selectSex = b
End Function

Function selectSessionCookies(a)
    Dim b, c
    b = b & "  <select name=""VerificationMode"" id=""VerificationMode"">" & vbCrLf
    b = b & "    <option value=""1"">Session验证</option>" & vbCrLf
    c = IIf(a = "0", " selected", "")
    b = b & "    <option value=""0""" & c & ">Cookies验证</option>" & vbCrLf
    b = b & "  </select>" & vbCrLf
    selectSessionCookies = b
End Function

Function showSelectList(a, b, c, d)
    Dim e, f, g, h
    a = Trim(a)
    If c = "" Then c = "|_-|"
    If a <> "" Then e = e & "  <select name=""" & a & """ id=""" & a & """>" & vbCrLf

    g = Split(b, c)
    For Each h In g
        f = ""
        If h = d Then f = " selected"
        e = e & "    <option value=""" & h & """" & f & ">" & h & "</option>" & vbCrLf
    Next
    If a <> "" Then e = e & "  </select>" & vbCrLf
    showSelectList = e
End Function


Function showArticleListStyle(ByVal a)
    showArticleListStyle = HandleArticleListStyleOrInfoStyle("文章展示样式", "ArticleListStyle", a)
End Function

Function showArticleInfoStyle(ByVal a)
    showArticleInfoStyle = HandleArticleListStyleOrInfoStyle("文章信息展示样式", "ArticleInfoStyle", a)
End Function

Function handleArticleListStyleOrInfoStyle(a, b, ByVal c)
    Dim d, e, f, g, h, i


    d = getWebImages() & "\" & a & "\"

    e = GetFileFolderList(d, True, "html", "名称", "", "", "")

    c = LCase(c)

    f = f & "  <select name=""" & b & """ id=""" & b & """>" & vbCrLf
    f = f & "    <option value=""""></option>" & vbCrLf
    g = Split(e, vbCrLf)
    For Each h In g
        If h <> "" Then
            i = IIF(LCase(h) = c, " selected", "")
            f = f & "    <option value=""" & h & """" & i & ">" & h & "</option>" & vbCrLf
        End If
    Next
    f = f & "  </select>" & vbCrLf

    handleArticleListStyleOrInfoStyle = f
End Function


Function showWebModuleSkins(a, ByVal b)
    Dim c, d, e, f, g, h
    c = getWebSkins() & "\Index\column"

    d = GetDirFolderNameList(c)


    b = LCase(b)

    e = e & "  <select name=""" & a & """ id=""" & a & """>" & vbCrLf
    e = e & "    <option value=""""></option>" & vbCrLf
    f = Split(d, vbCrLf)
    For Each g In f
        If g <> "" Then
            h = IIF(LCase(g) = b, " selected", "")
            e = e & "    <option value=""" & g & """" & h & ">" & g & "</option>" & vbCrLf
        End If
    Next
    e = e & "  </select>" & vbCrLf

    showWebModuleSkins = e
End Function


Function showRadioList(a, b, c, d)
    Dim e, f, g, h, i
    a = Trim(a)
    If c = "" Then c = "|_-|"
    i = 0
    g = Split(b, c)
    For Each h In g
        f = "" : i = i + 1
        If h = d Then f = " checked"
        e = e & "<input type=""radio"" name=""" & a & """ id=""" & a & i & """ value=""radio"" " & f & "><label for=""" & a & i & """>" & h & "</label>" & vbCrLf
    Next

    showRadioList = e
End Function

Function inputCheckBox(a, b, c)




	inputCheckBox=handleInputCheckBox(a, b, 1, c,"")
End Function

Function inputCheckBox3(a, b, c, d)
   inputCheckBox3=handleInputCheckBox(a, b, c, d,"newidname")
End Function
Function handleInputCheckBox(a, b, c, d,e)
	dim f,g,h
    If CStr(c) = "True" Or CStr(b) = "1" Then g = " checked" Else g = ""
	h=a			
	e="|"& e &"|"
	if instr(e,"|newidname|")>0 then
	    h = a & phprand(1, 9999)
	end if
	f="<input type='checkbox' name='" & a & "' id='" & h & "'" & g & " value='" & c & "'>"
	If d <> "" Then f = "<label for='" & h & "'>" & f & d & "</label> "
	handleInputCheckBox=f
end function


Function inputText(a, b, c, d)
    Dim e

    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        e = " style='width:" & c & ";'"
    End If
    inputText = "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & e & " />" & d
End Function

Function inputText2(a, b, c, d, e)
    Dim f
    If d <> "" Then


        d = " class=""" & d & """"
    End If
    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        f = " style='width:" & c & ";'"
    End If
    inputText2 = "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & f & d & " />" & e
End Function

Function inputLeftText(a, b, c, d)
    Dim e
    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        e = " style='width:" & c & ";'"
    End If
    inputLeftText = d & "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & e & " />" & vbCrLf
End Function

Function inputLeftTextHelpTextRight(a, b, c, d)
    Dim e
    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        e = " style='width:" & c & ";'"
    End If
    inputLeftTextHelpTextRight = "<input name=""" & a & """ type=""text"" id=""" & a & """ value=""" & b & """" & e & " />" & d
End Function

Function inputLeftTextContent(a, b, c, d)
    inputLeftTextContent = HandleInputLeftRightTextContent("左边", a, b, c, d)
End Function

Function inputRightTextContent(a, b, c, d)
    inputRightTextContent = HandleInputLeftRightTextContent("右边", a, b, c, d)
End Function

Function handleInputLeftRightTextContent(a, b, c, d, e)
    Dim f
    d = Trim(LCase(d))
    If d <> "" Then
        If Right(d, 1) <> "%" And Right(d, 2) <> "px" Then
            d = d & "px"
        End If
        f = " style='width:" & d & ";'"
    End If
    If f = "" Then
        f = " style='text-align:center;'"
    Else
        f = Replace(f, ";'", ";text-align:center;'")
    End If
    handleInputLeftRightTextContent = "<input name=""" & b & """ type=""text"" id=""" & b & """ value=""" & c & """" & f & " />"

    If a = "左边" Then
        handleInputLeftRightTextContent = e & handleInputLeftRightTextContent & vbCrLf
    Else
        handleInputLeftRightTextContent = handleInputLeftRightTextContent & e
    End If

End Function


Function inputLeftPassText(a, b, c, d)
    Dim e
    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        e = " style='width:" & c & ";'"
    End If
    inputLeftPassText = d & "<input name=""" & a & """ type=""password"" id=""" & a & """ value=""" & b & """" & e & " />" & vbCrLf
End Function

Function inputLeftPassTextContent(a, b, c, d)
    Dim e
    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        e = " style='width:" & c & ";'"
    End If
    If e = "" Then
        e = " style='text-align:center;'"
    Else
        e = Replace(e, ";'", ";text-align:center;'")
    End If
    inputLeftPassTextContent = d & "<input name=""" & a & """ type=""password"" id=""" & a & """ value=""" & b & """" & e & " />" & vbCrLf
End Function

Function inputHiddenText(a, b)
    inputHiddenText = "<input name=""" & a & """ type=""hidden"" id=""" & a & """ value=""" & b & """ />" & vbCrLf
End Function

Function inputTextArea(a, b, c, d, e)
    Dim f, g
    c = Trim(LCase(c))
    If c <> "" Then
        If Right(c, 1) <> "%" And Right(c, 2) <> "px" Then
            c = c & "px"
        End If
        f = " style='width:" & c & ";'"
    End If
    If d <> "" Then
        If CheckNumber(d) Then
            d = d & "px"
        End If
        g = "height:" & d & ";"
        If f <> "" Then
            f = Replace(f, ";'", ";" & g & ";'")
        Else
            f = " style='height:" & d & ";'"
        End If
    End If
    f = Replace(f, ";;", ";")
    inputTextArea = "<textarea name=""" & a & """ type=""text"" id=""" & a & """" & f & ">" & b & "</textarea>" & e
End Function

Function inputHiddenTextArea(a, b, c, d, e)
    inputHiddenTextArea = handleInputHiddenTextArea(a, b, c, d, "", e)
End Function

Function handleInputHiddenTextArea(a, b, c, d, e, f)
    Dim g, h
    If e <> "" Then
        e = " class=""" & e & """"
    End If
    If c <> "" Then g = " style='width:" & c & ";'"
    If d <> "" Then
        h = "height:" & d & ";"
        If g <> "" Then
            g = Replace(g, ";'", ";" & h & ";'")
        Else
            g = " style='height:" & d & ";display:none;'"
        End If
    End If
    handleInputHiddenTextArea = "<textarea name=""" & a & """ type=""text"" id=""" & a & """" & g & e & ">" & b & "</textarea>" & f
End Function

Function showSelectDirList(a, b)
    Dim c, d, e, f
    c = Split(GetDirFileSort(a), vbCrLf)
    For Each e In c
        If e <> "" Then
            f = IIF(b = e, " selected", "")
            d = d & "<option value=""" & a & e & """ " & f & ">" & e & "</option>" & vbCrLf
        End If
    Next
    showSelectDirList = d
End Function

Function inputDisabled(ByVal a)
    inputDisabled = Replace(a, "<input ", "<input disabled=""disabled"" ")
End Function


Function inputAddAlt(ByVal a, b)
    Dim c, d
    c = "<input "
    d = c & "alt=""" & b & """ "
    If InStr(a, c) > 0 Then
        a = Replace(a, c, d)
    Else
        c = "<textarea "
        d = c & "alt=""" & b & """ "
        If InStr(a, c) > 0 Then
            a = Replace(a, c, d)
        End If
    End If
    inputAddAlt = a
End Function






Function webTitle_InputTextArea(a)
    webTitle_InputTextArea = inputText("WebTitle", a, "70%", "  多个关键词用-隔开")
End Function

Function webKeywords_InputText(a)
    webKeywords_InputText = inputText("WebKeywords", a, "70%", " 请以，隔开(中文逗号)")
End Function

Function webDescription_InputTextArea(a)
    webDescription_InputTextArea = inputTextArea("WebDescription", a, "99%", "100px", "")
End Function

Function folderName_InputText(a)
    folderName_InputText = inputText("FolderName", a, "40%", "")
End Function

Function fileName_InputText(a)
    fileName_InputText = inputText("FileName", a, "40%", ".html 也可以是网络上的链接地址")
End Function


Function templatePath_InputText(a)
    templatePath_InputText = inputText("TemplatePath", a, "40%", " 不填为默认")
End Function

Function clickPinYinHTMLStr(a)
    clickPinYinHTMLStr = "<a href=""javascript:GetPinYin('FolderName','" & a & "','AjAx.Asp?act=GetPinYin')"" >获得拼音</a>"
End Function

Function showFontColorFontB(a, b)
    showFontColorFontB = selectFontColor(a) & inputCheckBox("FontB", b, "加粗")
End Function

Function showSort(a)
    showSort = inputText("Sort", a, "30px", "")
    showSort = Replace(showSort, ";'", ";text-align:center;'")
End Function

Function showWebNavType(a, b, c, d, e, f)
    Dim g
    g = g & inputCheckBox("NavTop", a, "顶部导航")
    g = g & inputCheckBox("NavButtom", b, "底部导航")
    g = g & inputCheckBox("NavLeft", c, "左边导航")
    g = g & inputCheckBox("NavContent", d, "中间导航")
    g = g & inputCheckBox("NavRight", e, "右边导航")
    g = g & inputCheckBox("NavOthre", f, "其它导航")
    showWebNavType = g
End Function
Function showOnHtml(a)
    showOnHtml = inputCheckBox("OnHtml", a, "生成HTML")
End Function
Function showThrough(a)
    showThrough = inputCheckBox("Through", a, "审核")
End Function
Function showRecommend(a)
    showRecommend = inputCheckBox("Recommend", a, "推荐")
End Function

Function showOnOffImg(a, b, c, d, e)
    Dim f, g, h
    If Rq("page") <> "" Then f = "&page=" & Rq("page") Else f = ""
    If d = True Then
        g = "<img src="""& adminDir &"Images/yes.gif"">"
    Else
        g = "<img src="""& adminDir &"Images/webno.gif"">"
    End If

    h = GetUrlAddToParam(GetUrl(), ""& adminDir &"HandleDatabase.Asp?act=SetTrueFalse&Table=" & b & "&FieldName=" & c & "&Url=" & e & "&Id=" & a, "replace")
    showOnOffImg = "<a href=""" & h & """>" & g & "</a>"


End Function

Function newShowOnOffImg(a, b, c, d, e)
    Dim f, g
    If Rq("page") <> "" Then f = "&page=" & Rq("page") Else f = ""
    If d = 1 Then
        g = "<img src=""/Images/yes.gif"">"
    Else
        g = "<img src=""/Images/webno.gif"">"
    End If
    newShowOnOffImg = "<a href=/WebAdmin/ZAction.Asp?act=Through&Table=" & b & "&FieldName=" & c & "&Url=" & e & "&Id=" & a & f & ">" & g & "</a>"
End Function



Function controlDialogCss()
    Dim b
    b = "<style>" & vbCrLf
    b = b & "/*控制Css20150128*/" & vbCrLf
    b = b & ".controlDialog{" & vbCrLf
    b = b & "    position:relative;" & vbCrLf
    b = b & "    height:50px;" & vbCrLf
    b = b & "    width:auto;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & ".controlDialog .menu{" & vbCrLf
    b = b & "    position:absolute;" & vbCrLf
    b = b & "    right:0px;" & vbCrLf
    b = b & "    top:0px;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & ".controlDialog .menu a{" & vbCrLf
    b = b & "    color:#FF0000;" & vbCrLf
    b = b & "    font-size:14px;" & vbCrLf
    b = b & "    text-decoration:none;" & vbCrLf
    b = b & "    background-color:#FFFFFF;" & vbCrLf
    b = b & "    border:1px solid #003300;" & vbCrLf
    b = b & "    padding:4px;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & ".controlDialog .menu a:hover{" & vbCrLf
    b = b & "    color:#C60000;" & vbCrLf
    b = b & "    text-decoration:underline;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "</style>" & vbCrLf
    controlDialogCss = b
End Function



function batchDeleteTempStr(a,b,c)
	dim d,e
	for d = 1 to 9
		if instr(a,b)=false then
			exit for
		end if
		e=getStrCut(a,b,c,1)
		a=replace(a,e,"")		
	next
	batchDeleteTempStr=a
end function
%>





