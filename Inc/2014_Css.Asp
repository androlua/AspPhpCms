<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-29
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'Css

'Cssѹ�� cssCompression(Content,0)
Function cssCompression(content, Level)
    Level = CStr(Level)                                                             'ת���ַ����ж�
    'Css�߼�ѹ��
    If Level = "1" Then
        content = RegExp_Replace(content, "\/\*(.|" & vbCrLf & ")*?\*\/", "") 
        content = RegExp_Replace(content, "\s*([\{\}\:\;\,])\s*", "$1") 
        content = RegExp_Replace(content, "\,[\s\.\#\d]*\{", "{") 
        content = RegExp_Replace(content, ";\s*;", ";") 
    'Css��ѹ��
    Else
        If Level >= 2 Then
            content = RegExp_Replace(content, "\/\*(.|" & vbCrLf & ")*?\*\/", "")           '//ɾ��ע��
        End If 
        content = RegExp_Replace(content, "\s*([\{\}\:\;\,])\s*", "$1") 
        content = RegExp_Replace(content, "\,[\s\.\#\d]*\{", "{")                  '//�ݴ�����
        content = RegExp_Replace(content, ";\s*;", ";")                                 '//��������ֺ�
        content = RegExp_Replace(content, ";\s*}", "}")                                 '//���ĩβ�ֺźʹ�����
        content = RegExp_Replace(content, "([^\s])\{([^\s])", "$1{$2") 
        content = RegExp_Replace(content, "([^\s])\}([^" & vbCrLf & "]s*)", "$1}" & vbCrLf & "$2") 



    End If 
    content = trimVBcrlf(content) 
    cssCompression = content 
End Function 

'ɾ��Css��ע��
Function deleteCssNote(content)
    deleteCssNote = RegExp_Replace(content, "\/\*(.|" & vbCrLf & ")*?\*\/", "")     '//ɾ��ע��
End Function 

'Css��ʽ��  չ��CSS
Function unCssCompression(content)
    content = RegExp_Replace(content, "\s*([\{\}\:\;\,])\s*", "$1") 
    content = RegExp_Replace(content, ";\s*;", ";")                                 '//��������ֺ�
    content = RegExp_Replace(content, "\,[\s\.\#\d]*{", "{") 
    content = RegExp_Replace(content, "([^\s])\{([^\s])", "$1 {" & vbCrLf & "" & vbTab & "$2") 
    content = RegExp_Replace(content, "([^\s])\}([^" & vbCrLf & "]*)", "$1" & vbCrLf & "}" & vbCrLf & "$2") 
    content = RegExp_Replace(content, "([^\s]);([^\s\}])", "$1;" & vbCrLf & "" & vbTab & "$2") 
    unCssCompression = content 
End Function 

'ȥ���ַ���ͷβ�������Ļس��Ϳո�
Function trimVbCrlf(str)
    trimVbCrlf = rtrimVBcrlf(ltrimVBcrlf(str)) 
End Function 

'PHP��Trim����
Function pHPTrim(str)
    pHPTrim = trimVbCrlf(str) 
End Function 

'ȥ���ַ�����ͷ�������Ļس��Ϳո�
Function ltrimVBcrlf(str)
    Dim pos, isBlankChar 
    pos = 1 
    isBlankChar = True 
    While isBlankChar
        If Mid(str, pos, 1) = " " Or Mid(str, pos, 1) = vbTab Then                      '��vbTabҲȥ��
            pos = pos + 1 
        ElseIf Mid(str, pos, 2) = vbCrLf Then
            pos = pos + 2 
        Else
            isBlankChar = False 
        End If 
    Wend 
    ltrimVBcrlf = Right(str, Len(str) - pos + 1) 
End Function 

'ȥ���ַ���ĩβ�������Ļس��Ϳո�
Function rtrimVBcrlf(str)
    Dim pos, isBlankChar 
    pos = Len(str) 
    isBlankChar = True 
    While isBlankChar And pos >= 2
        If Mid(str, pos, 1) = " " Or Mid(str, pos, 1) = vbTab Then                      '��vbTabҲȥ��
            pos = pos - 1 
        ElseIf Mid(str, pos - 1, 2) = vbCrLf Then
            pos = pos - 2 
        Else
            isBlankChar = False 
        End If 
    Wend 
    rtrimVBcrlf = RTrim(Left(str, pos)) 
End Function 


'--------------- ���� ��ʱ�����ļ��� ------------------
'ȥ���ַ���ͷβ��������Tab�˸�Ϳո�
Function trimVbTab(str)
    trimVbTab = RTrimVBTab(LTrimVbTab(str)) 
End Function 


'ȥ���ַ�����ͷ��������Tab�˸�Ϳո�
Function lTrimVbTab(str)
    Dim pos, isBlankChar 
    pos = 1 
    isBlankChar = True 
    While isBlankChar
        If Mid(str, pos, 1) = " " Then
            pos = pos + 1 
        ElseIf Mid(str, pos, 1) = vbTab Then
            pos = pos + 1 
        Else
            isBlankChar = False 
        End If 
    Wend 
    lTrimVbTab = Right(str, Len(str) - pos + 1) 
End Function 

'ȥ���ַ���ĩβ��������Tab�˸�Ϳո�
Function rTrimVBTab(str)
    Dim pos, isBlankChar 
    pos = Len(str) 
    isBlankChar = True 
    While isBlankChar And pos >= 2
        If Mid(str, pos, 1) = " " Then
            pos = pos - 1 
        ElseIf Mid(str, pos - 1, 1) = vbTab Then
            pos = pos - 1 
        Else
            isBlankChar = False 
        End If 
    Wend 
    rTrimVBTab = RTrim(Left(str, pos)) 
End Function 


'��Htmlҳ��Css Style
Function getHtmlCssStyle(ByVal content)
    Dim splStr, s, StyleYes, StyleStartStr, StyleEndStr, StyleStr, CssStr 
    splStr = Split(content, vbCrLf)                                                 '�ָ���
    StyleYes = False                                                                'Css��ʽĬ��Ϊ��
    'ѭ������
    For Each s In splStr
        If StyleYes = False Then
            If InStr(LCase(s), "<style") > 0 Then
                StyleStartStr = Mid(s, InStr(LCase(s), "<style")) 
                StyleStartStr = Mid(StyleStartStr, 1, InStr(StyleStartStr, ">")) 
                StyleEndStr = Mid(s, InStr(LCase(s), StyleStartStr) + Len(StyleStartStr)) 
                'HTML�ж����Css��һ��
                If InStr(StyleEndStr, "</style>") > 0 Then
                    StyleStr = Mid(StyleEndStr, 1, InStr(StyleEndStr, "</style>") - 1) 
                    CssStr = CssStr & StyleStr & vbCrLf 
                Else
                    CssStr = CssStr & StyleEndStr & vbCrLf 
                    StyleYes = True                                                       '�ռ�CssStyle��ʽ��ʼ
                End If 
                'Call Echo("StyleStartStr",ShowHtml(StyleStartStr))
                'Call Echo("StyleEndStr",ShowHtml(StyleEndStr))
                'Call Echo("StyleStr",ShowHtml(StyleStr))
                'Call Echo("CssStr",ShowHtml(CssStr))
            'Call RwEnd("")
            End If 
        ElseIf StyleYes = True Then
            If InStr(LCase(s), "</style>") > 0 Then
                StyleStr = Mid(s, 1, InStr(LCase(s), "</style>") - 1) 
                CssStr = CssStr & StyleStr & vbCrLf 
                'Call Echo("StyleStr2",ShowHtml(StyleStr))
                'Call Echo("CssStr2",ShowHtml(CssStr))
                'Call RwEnd("")
                StyleYes = False                                                                '�ռ�CssStyle��ʽ����
            Else
                CssStr = CssStr & s & vbCrLf 
            End If 
        End If 
    Next 
    getHtmlCssStyle = CssStr 
End Function 

'�����ɸɾ���Css����
Function handleCleanCss(ByVal content)
    Dim splStr, s, c, AddStrYes, CustomS 
    content = Replace(content, "{", vbCrLf & "{" & vbCrLf) 
    content = Replace(content, "}", vbCrLf & "}" & vbCrLf) 
    content = Replace(content, ";", ";" & vbCrLf) 

    splStr = Split(content, vbCrLf) 
    AddStrYes = False                                                               '׷���ַ�Ĭ��Ϊ��
    For Each s In splStr
        s = trimVbCrlf(s) 
        CustomS = ""                                                                    '�Զ���Sֵ
        If s <> "" Then
            If InStr(s, "{") > 0 And InStr(s, "}") = False Then
                AddStrYes = True 
                CustomS = s 
            ElseIf InStr(s, "}") > 0 Then
                AddStrYes = False 
            End If 
            If Left(s, 1) <> "{" Then c = c & vbCrLf 
            If AddStrYes = True Then s = "    " & s 
            If CustomS <> "" Then s = CustomS                                               '�Զ���ֵ��Ϊ�������Զ�������
            c = c & s 

        End If 
    Next 
    c = trimVbCrlf(c) 
    handleCleanCss = c 
End Function 



'�Ƴ������ж����
Function removeExcessRow(content)
    Dim splStr, s, c, TempS 
    splStr = Split(content, vbCrLf)                                                 '�ָ���
    For Each s In splStr
        TempS = Replace(Replace(s, " ", ""), vbTab, "") 
        If TempS <> "" Then
            c = c & s & vbCrLf 
        End If 
    Next 
    If c <> "" Then c = Left(c, Len(c) - 2) 
    removeExcessRow = c 
End Function 


'2014 11 30
'��Css��׷����ʽ  a=CssAddToStyle(GetFText("1.html")," .test {color:#FF0f000; font-size:10px; float:left}")
Function cssAddToStyle(content, AddToStyle)
    Dim StyleName, YunStyleStr, ReplaceStyleStr, c 
    If InStr(AddToStyle, "{") > 0 Then
        StyleName = Trim(Mid(AddToStyle, 1, InStr(AddToStyle, "{") - 1)) 
    End If 
    YunStyleStr = FindCssStyle(content, StyleName) 
    ReplaceStyleStr = CssStyleAddToParam(YunStyleStr, AddToStyle)                   'Css��ʽ�ۼӲ���
    content = Replace(content, YunStyleStr, ReplaceStyleStr) 
    'C = C & "<hr>Content=" & Content
    cssAddToStyle = content 
    'CssAddToStyle = YunStyleStr
'CssAddToStyle = "StyleName=" & StyleName & "<hr>YunStyleStr=" & YunStyleStr & "<hr>ReplaceStyleStr=" & ReplaceStyleStr
End Function 

'���Css�������Ƿ���ָ����ʽ
Function checkCssStyle(content, StyleStr)
    Dim StyleName 
    checkCssStyle = True 
    If InStr(StyleStr, "{") > 0 Then
        StyleName = Trim(Mid(StyleStr, 1, InStr(StyleStr, "{") - 1)) 
    End If 
    If StyleName = "" Then
        checkCssStyle = False 
    ElseIf FindCssStyle(content, StyleName) = "" Then
        checkCssStyle = False 
    End If 
End Function 


'Css��ʽ�ۼӲ���
Function cssStyleAddToParam(ByVal CssStyleStr, ByVal CssStyleStrTwo)
    Dim splStr, CssStr, s, ParamList, ParamName, CssStyleName 
    CssStyleName = Mid(CssStyleStr, 1, InStr(CssStyleStr, "{")) 
    If InStr(CssStyleStr, "{") > 0 Then
        CssStyleStr = Mid(CssStyleStr, InStr(CssStyleStr, "{") + 1) 
    End If 
    If InStr(CssStyleStr, "}") > 0 Then
        CssStyleStr = Mid(CssStyleStr, 1, InStr(CssStyleStr, "}") - 1) 
    End If 
    If InStr(CssStyleStrTwo, "{") > 0 Then
        CssStyleStrTwo = Mid(CssStyleStrTwo, InStr(CssStyleStrTwo, "{") + 1) 
    End If 
    If InStr(CssStyleStrTwo, "}") > 0 Then
        CssStyleStrTwo = Mid(CssStyleStrTwo, 1, InStr(CssStyleStrTwo, "}") - 1) 
    End If 
    splStr = Split(Replace(CssStyleStr & ";" & CssStyleStrTwo, vbCrLf, ""), ";") 
    For Each s In splStr
        s = Trim(s) 
        If InStr(s, ":") > 0 And s <> "" Then
            ParamName = Trim(Mid(s, 1, InStr(s, ":") - 1)) 
            If InStr("|" & ParamList & "|", "|" & ParamName & "|") = False Then
                ParamList = ParamList & ParamName & "|" 
                'Call Echo("ParamName",ParamName)
                CssStr = CssStr & "    " & s & ";" & vbCrLf 
            End If 
        End If 
    Next 
    If CssStyleName <> "" Then
        CssStr = CssStyleName & vbCrLf & CssStr & "}" 
    End If 
    cssStyleAddToParam = CssStr 
'Call Echo(CssStyleStr,CssStyleStrTwo)
End Function 

'����Css�����ҵ���ӦCss��
Function findCssStyle(ByVal content, ByVal StyleName)
    Dim splStr, s, TempS, FindStyleName 
    'CAll Echo("StyleName",StyleName)
    'CAll Echo("Content",Content)
    StyleName = Trim(StyleName) 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        If InStr(s, StyleName) > 0 Then
            FindStyleName = Trim(s) 
            If InStr(FindStyleName, "{") > 0 Then
                FindStyleName = Trim(Mid(FindStyleName, 1, InStr(FindStyleName, "{") - 1)) 
            End If 
            If FindStyleName = StyleName Then
                'Call Eerr( FindStyleName , StyleName)
                If InStr(s, "}") > 0 Then
                    findCssStyle = Mid(s, 1, InStr(s, "}") + 1) 
                    'Call EErr(s,FindCssStyle)
                    Exit Function 
                Else
                    TempS = Mid(content, InStr(content, s & vbCrLf) + 1) 
                    TempS = Mid(TempS, 1, InStr(TempS, "}") + 1) 
                    findCssStyle = TempS 
                    Exit Function 
                End If 
            'Call Eerr("temps",Temps)
            End If 
        'Call Echo(FindStyleName,StyleName)
        End If 
    Next 
End Function 

'================================================
'������վǰ��Ҫ�õ�
'================================================
'������ȡ����Css
Function handleCutCssCode(dirPath, CssStr)
    Dim content, startStr, endStr, splStr, ImageFile, fileName, listStr 
    startStr = "url\(" : endStr = "\)" 
    content = getArray(CssStr, startStr, endStr, False, False) 
    splStr = Split(content, "$Array$") 
    For Each ImageFile In splStr
        If ImageFile <> "" And InStr(ImageFile, ".") > 0 And InStr(vbCrLf & listStr & vbCrLf, vbCrLf & ImageFile & vbCrLf) = False Then'���ظ�ʹ�õ�ͼƬ����
            listStr = listStr & ImageFile & vbCrLf 
            fileName = Replace(Replace(Replace(ImageFile, """", ""), "'", ""), "\", "/") 
            If InStr(fileName, "/") > 0 Then
                fileName = Mid(fileName, InStrRev(fileName, "/") + 1) 
            End If 
            CssStr = Replace(CssStr, ImageFile, dirPath & fileName) 
        End If 
    Next 
    handleCutCssCode = CssStr 
End Function 

'������ȡ����HtmlDiv
Function handleCutDivCode(dirPath, DivStr)
    Dim content, startStr, endStr, splStr, ImageFile, ToImageFile, fileName, isHandle 
    startStr = "url\(" : endStr = "\)" 
    content = GetArray(DivStr, startStr, endStr, False, False) 
    splStr = Split(content, "$Array$") 
    For Each ImageFile In splStr

        If ImageFile <> "" And InStr(ImageFile, ".") > 0 And InStr(ImageFile, "{$#") = False Then
            '�ж��Ƿ������� 20150202
            If GetWebSite(ImageFile) = "" Then
                fileName = Replace(Replace(Replace(ImageFile, """", ""), "'", ""), "\", "/") 
                If InStr(fileName, "/") > 0 Then
                    fileName = Mid(fileName, InStrRev(fileName, "/") + 1) 
                End If 
                DivStr = Replace(DivStr, ImageFile, dirPath & ImageFile) 
            End If 
        End If 
    Next 
    'ͼƬ����
    'Content = GetIMG(DivStr) & vbCrlf & GetHtmlBackGroundImgList(DivStr)        '�ټӸ�Html����ͼƬ
    content = GetImgJsUrl(DivStr, "���ظ�") & vbCrLf & GetHtmlBackGroundImgList(DivStr) '�ټӸ�Html����ͼƬ  ��ǿ��20150126
    splStr = Split(content, vbCrLf) 
    For Each ImageFile In splStr
        If ImageFile <> "" Then                                                         '�����ӵ�ַ��ǰΪHTTP:ʱ�򲻴���20150313
            isHandle = False 

            If Left(ImageFile, 1) = "\" Then
            '�ȴ���20150817
            ElseIf InStr(ImageFile, ".") > 0 And Left(ImageFile, 5) <> "HTTP:" And InStr(ImageFile, "{$#") = False Then
                isHandle = True 
            End If 
            If isHandle = True Then
                ToImageFile = dirPath & RemoveFileDir(ImageFile)                                '�Ƴ��ļ�·��Ŀ¼
                'html��ͼƬ·���滻
                DivStr = Replace(DivStr, """" & ImageFile & """", """" & ToImageFile & """") 
                DivStr = Replace(DivStr, "'" & ImageFile & "'", """" & ToImageFile & """") 
                DivStr = Replace(DivStr, "=" & ImageFile & " ", """" & ToImageFile & """") 
                DivStr = Replace(DivStr, "=" & ImageFile & ">", """" & ToImageFile & """") 
            End If 
        End If 
    Next 
    handleCutDivCode = DivStr 
End Function 

'���HTMl�ﱳ��ͼƬ 20150116  �磺 <td width="980" height="169" background="kslx3bg.jpg">
Function getHtmlBackGroundImgList(ByVal content)
    content = GetArray(content, " background=""", """", False, False) 
    content = Replace(content, "$Array$", vbCrLf) 
    getHtmlBackGroundImgList = content 
End Function 


'������վHTML��Css����    д�ò����ر�����ƺ�  Content = HandleWebHtmlImg("/aa/bb/",Content)  �ⲿ����
Function getHandleWebHtmlLink(RootPath, content)
    Dim startStr, endStr, ImgList, splStr, c, CssUrl, NewCssUrl, CssStr 
    startStr = "<link " 
    CssStr = "" 
    endStr = ">" 
    ImgList = GetArray(content, startStr, endStr, False, False) 
    'Call RwEnd(ImgList)
    splStr = Split(ImgList, "$Array$") 
    For Each CssUrl In splStr
        If CssUrl <> "" And InStr(LCase(CssUrl), "stylesheet") > 0 Then
            '���Css��ǿ�棬����20141125
            CssUrl = LCase(Replace(Replace(Replace(CssUrl, """", ""), "'", ""), ">", " ")) & " " 
            startStr = "href=" : endStr = " " 
            If InStr(CssUrl, startStr) > 0 And InStr(CssUrl, endStr) > 0 Then
                CssUrl = StrCut(CssUrl, startStr, endStr, 2) 
            End If 
            NewCssUrl = HandleHttpUrl(CssUrl) 
            If InStr(NewCssUrl, "/") > 0 Then
                NewCssUrl = Mid(NewCssUrl, InStrRev(NewCssUrl, "/") + 1) 
            End If 
            If LCase(NewCssUrl) <> "common.css" And LCase(NewCssUrl) <> "public.css" Then
                NewCssUrl = RootPath & NewCssUrl 
                CssStr = CssStr & "<link href=""" & NewCssUrl & """ rel=""stylesheet"" type=""text/css"" />" & vbCrLf 
            End If 
        End If 
    Next 
    If CssStr <> "" Then CssStr = Left(CssStr, Len(CssStr) - 2) 
    getHandleWebHtmlLink = CssStr 
End Function 


'���css���ӵ�ַ�б�(20150824)
Function getCssListUrlList(content)
    Dim startStr, endStr, ImgList, splStr, c, CssUrl, CssStr, urlList 
    startStr = "<link " 
    CssStr = "" 
    endStr = ">" 
    ImgList = GetArray(content, startStr, endStr, False, False) 
    'Call RwEnd(ImgList)
    splStr = Split(ImgList, "$Array$") 
    For Each CssUrl In splStr
        If CssUrl <> "" And InStr(LCase(CssUrl), "stylesheet") > 0 Then
            '���Css��ǿ�棬����20141125
            CssUrl = LCase(Replace(Replace(Replace(CssUrl, """", ""), "'", ""), ">", " ")) & " " 
            startStr = "href=" : endStr = " " 
            If InStr(CssUrl, startStr) > 0 And InStr(CssUrl, endStr) > 0 Then
                CssUrl = StrCut(CssUrl, startStr, endStr, 2) 
            End If 
            If InStr(vbCrLf & urlList & vbCrLf, vbCrLf & CssUrl & vbCrLf) = False Then
                If urlList <> "" Then urlList = urlList & vbCrLf 
                urlList = urlList & CssUrl & vbCrLf 
            End If 
        End If 
    Next 
    getCssListUrlList = urlList 
End Function 

'��Css�ļ����ݲ�����(20150824) ��call rwend(handleReadCssContent("E:\E��\WEB��վ\��ǰ��վ\DataDir\VBģ��\������\Template\ģ�鹦���б�\Bվҳ�����\home\home.css","aa",true))
Function handleReadCssContent(cssFilePath, LabelName, isHandleCss)
    Dim c, startStr, endStr 
    c = getFText(cssFilePath) 
    '��ȡCSS
    startStr = "/*CssCodeStart*/" 
    endStr = "/*CssCodeEnd*/" 
    If InStr(c, startStr) > 0 And InStr(c, endStr) > 0 Then
        c = StrCut(c, startStr, endStr, 2) 
    End If 
    '����CSS
    If isHandleCss = True Then
        c = cssCompression(c, 0) 
    End If 
    If LabelName <> "" Then
        c = "/*" & LabelName & " start*/" & c & "/*" & LabelName & " end*/" 
    End If 
    handleReadCssContent = c 
End Function 



'����Css��ʽ��PX��T
Function handleCssPX(ByVal nValue)
    nValue = LCase(Trim(nValue)) 
    If Right(nValue, 1) <> "%" And Right(nValue, 2) <> "px" Then
        nValue = nValue & "px" 
    End If 
    handleCssPX = nValue 
End Function 



'call rw(handleHtmlStyle(getftext("1.html")))
'ѹ��html���style��ʽ (20151008)
Function handleHtmlStyle(content)
    Dim serchS, replaceS, nLength 
    serchS = content 
    nLength = InStr(LCase(serchS), "</style>") + 7 
    serchS = Mid(serchS, 1, nLength) 

    nLength = InStrRev(LCase(serchS), "<style") 
    If nLength > 0 Then
        serchS = Mid(serchS, nLength) 
    End If 
    replaceS = serchS 
    replaceS = cssCompression(replaceS, 0) & vbCrLf                                 '��ʽ��CSS
    replaceS = removeBlankLines(replaceS) 

    content = Replace(content, serchS, replaceS) 
    handleHtmlStyle = content 
End Function 

%>  
