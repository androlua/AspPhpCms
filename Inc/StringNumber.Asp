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

'�ж��Ƿ�Ϊ�ַ�ת��
function isStrTransferred(content)
	dim splstr,i,s,nCount
	nCount=0
	for i = 0 to len(content)-1
		s=mid(content,len(content)-i,1)
		if s="\" then
			nCount=nCount+1
		else
			isStrTransferred=IIF(nCount mod 2=1,true,false)
			exit function
		end if
	next
end function

'������ʣ���Ϸ�������õ� 20150601
Function getBL(setWidth, setHeight, nDanFuXianZhi)
    Dim splStr(3) 
    Dim nWidthZheFu : nWidthZheFu = 1                                               '������
    Dim nHeightZheFu : nHeightZheFu = 1                                             '������
    Dim nBFB                                                                        '�ٷֱ�
    Dim nXXFBX                                                                      'ÿ���ٷֱȣ���ΪҪ�ж������ܳ���10
    If setWidth < 0 Then
        setWidth = setWidth * - 1 
        nWidthZheFu = -1 
    End If 
    If setHeight < 0 Then
        setHeight = setHeight * - 1 
        nHeightZheFu = -1 
    End If 
    If setWidth > setHeight Then
        nBFB = FormatNumber(setWidth / setHeight, 2)                                    '//���� �ٷֱ�
        splStr(0) = nBFB 
        splStr(1) = 1 
    Else
        nBFB = FormatNumber(setHeight / setWidth, 2)                                    '//�߿� �ٷֱ�
        splStr(0) = 1 
        splStr(1) = nBFB 
    End If 
    'ÿ������ָ��ֵ������
    'if nBFB>=nDanFuXianZhi then
    nXXFBX = FormatNumber(nDanFuXianZhi / nBFB, 2) 
    splStr(0) = splStr(0) * nXXFBX 
    splStr(1) = splStr(1) * nXXFBX 
    'end if

    splStr(0) = splStr(0) * nWidthZheFu 
    splStr(1) = splStr(1) * nHeightZheFu 
    splStr(2) = nBFB 
    splStr(3) = GetCountPage(setWidth, splStr(0)) 
    Call echo("page count ҳ��", splStr(3)) 
    splStr(3) = getCountStep(setWidth, setHeight, splStr(0), splStr(1), splStr(3)) 

    getBL = splStr 
End Function 

'����ܲ���
Function getCountStep(nWidthStep, nHeightStep, nWidthBL, nHeightBL, nCountPage)
    Dim i 
    getCountStep = "" 
    If nWidthStep < 0 Then
        nWidthStep = nWidthStep * - 1 
    End If 
    If nHeightStep < 0 Then
        nHeightStep = nHeightStep * - 1 
    End If 
    If nWidthBL < 0 Then
        nWidthBL = nWidthBL * - 1 
    End If 
    If nHeightBL < 0 Then
        nHeightBL = nHeightBL * - 1 
    End If 
    For i = nCountPage - 10 To nCountPage
        'call echo(i & "��nWidthBL*i>=nWidthStep",nWidthBL*i &">="&nWidthStep    & "   |  " & nHeightBL*i &">="& nHeightStep)
        If nWidthBL * i >= nWidthStep Or nHeightBL * i >= nHeightStep Then
            getCountStep = i 
        'call echo("getCountStep",getCountStep)
        End If 
    Next 
End Function 


'������ĺ�������
Function getChina(content)
    Dim i, c, j, s 
    For i = 1 To Len(content)
        j = Asc(Mid(content, i, 1)) 
        s = Mid(content, i, 1) 
        '�Ǻ����ۼ�
        If j < 0 Then
            If(j <= -22033 And j >= -24158) = False Then
                c = c & s 
            End If 
        End If 
    Next 
    getChina = c 
End Function
'�ж��Ƿ�������
Function isChina(content)
    Dim i, j, s 
    For i = 1 To Len(content)
        j = Asc(Mid(content, i, 1)) 
        s = Mid(content, i, 1) 
        '�Ǻ����ۼ�
        If j < 0 Then
            If(j <= -22033 And j >= -24158) = False Then
                isChina=true
				exit function
            End If 
        End If 
    Next 
	isChina=false
End Function
'�ж��Ƿ������� (����)
Function checkChina(content)
	checkChina=isChina(content)
End Function

'PHP��Randʹ��20150212
Function pHPRand(nMinimum, nMaximum)
    Randomize 
    pHPRand = "" 
    Dim i 
    For i = 1 To 9
        pHPRand = CInt((nMinimum + nMaximum) * Rnd) 
        If pHPRand >= nMinimum And pHPRand <= nMaximum Then
            Exit For 
        End If 
    Next 
    If pHPRand < nMinimum Then
        pHPRand = nMinimum 
    ElseIf pHPRand > nMaximum Then
        pHPRand = nMaximum 
    End If 
End Function 

'�������棬Ϊʲô����Ϊ����д���������
Function pHPRnd(nMinimum, nMaximum)
    pHPRnd = pHPRand(nMinimum, nMaximum) 
End Function 


'ɾ���ظ�����  20141220
Function deleteRepeatStr(content, SplType)
    Dim splStr, s, c 
    c = "" 
    splStr = Split(content, SplType) 
    For Each s In splStr
        If s <> "" Then
            If InStr(SplType & c & SplType, SplType & s & SplType) = False Then
                c = c & s & SplType 
            End If 
        End If 
    Next 
    If c <> "" Then c = Left(c, Len(c) - Len(SplType)) 
    deleteRepeatStr = c 
End Function 

'�滻����N�� 20141220
Function replaceN(content, YunStr, ReplaceStr, nNumb)
    Dim i 
    nNumb = HandleNumber(nNumb) 
    If nNumb = "" Then
        nNumb = 1 
    Else
        nNumb = CInt(nNumb) 
    End If 
    For i = 1 To nNumb
        content = Replace(content, YunStr, ReplaceStr) 
    Next 

    replaceN = content 
End Function 

'asp���ڲ�0����   ���ñ���20141216
Public Function fillZero(content)
    If Len(content) = 1 Then
        fillZero = "0" & content 
    Else
        fillZero = content 
    End If 
End Function 

'���ִ�Сд�滻�����ߣ�С�ƣ�д��20140925 �÷�Response.Write(CaseInsensitiveReplace("112233aabbbccddee","b","С����ţ"))
Function caseInsensitiveReplace(content, Check_Str, Replace_Str)
    Dim StartLen, EndLen, LowerCase, startStr, endStr, c, i 
    c = "" 
    If LCase(Check_Str) = LCase(Replace_Str) Then
        caseInsensitiveReplace = content 
    End If 
    LowerCase = LCase(content) 
    For i = 1 To 99
        If InStr(LowerCase, Check_Str) > 0 Then
            StartLen = InStr(LowerCase, Check_Str) - 1 
            startStr = Left(content, StartLen) 
            EndLen = StartLen + Len(Check_Str) + 1 
            endStr = Mid(content, EndLen) 
            content = startStr & Replace_Str & endStr 
            'Call Echo(StartLen,EndLen)
            'Call Echo(StartStr,EndStr)
            'Call Echo("Content",Content)
            LowerCase = LCase(content) 
        Else
            Exit For 
        End If 
    Next 
    caseInsensitiveReplace = content 
End Function 

'������������ (2013,10,1)
Function array_Sort(sArray)
    Dim i, j, MinmaxSlot, Minmax, temp 
    For i = UBound(sArray) To 0 Step - 1
        Minmax = sArray(i) 
        MinmaxSlot = 0 
        For j = 1 To i
            If sArray(j) > Minmax Then
                Minmax = sArray(j) 
                MinmaxSlot = j 
            End If 
        Next 
        If MinmaxSlot <> i Then
            temp = sArray(MinmaxSlot) 
            sArray(MinmaxSlot) = sArray(i) 
            sArray(i) = temp 
        End If 
    Next 
    array_Sort = sArray 
End Function 

'����Zip��С
Function handleZipSize(ByVal ZipSize)
    On Error Resume Next 
    Dim nSize 
    ZipSize = LCase(ZipSize) 
    nSize = GetDianNumb(ZipSize) 
    If InStr(ZipSize, "g") Then
        nSize = nSize * 1073741824 
    ElseIf InStr(ZipSize, "m") Then
        nSize = nSize * 1048576 
    ElseIf InStr(ZipSize, "k") Then
        nSize = nSize * 1024 
    End If 
    handleZipSize = nSize 
    If Err Then doError Err.Description, "HandleZipSize ����Zip��С ����������ZipSize=" & ZipSize 
End Function 

'//���������
Function getRnd(ByVal nCount)
    Randomize 
    Dim s, i, c
    For i = 1 To nCount
        If i Mod 2 = 0 Then
            s = ChrW((57 - 48) * Rnd + 48)                                                  '0~9
        ElseIf i Mod 3 = 0 Then
            s = ChrW((90 - 65) * Rnd + 65)                                                  'A~Z
        Else
            s = ChrW((122 - 97) * Rnd + 97)                                                 'a~z
        End If 
        c=c & s 
    Next 
	getRnd=c
End Function 

'������������js(20150826)
Function mathRandom()
    Dim i, c 
    c = "" 
    Randomize 
    For i = 1 To 16
        c = c & Int(Rnd() * 9) 
    Next 
    mathRandom = "0." & c 
End Function 


'���ָ��λ�����A��Z�ַ�
Function getRndAZ(nCount)
    Dim ZD, i, s, c 
    c = "" : ZD = "" 
    Randomize 
    ZD = "abcdefghijklmnopqrstuvwxyz" & UCase(ZD) 
    For i = 1 To nCount
        s = Mid(ZD, pHPRnd(1, Len(ZD)), 1) 
        c = c & s 
    Next 
    getRndAZ = c 
End Function 

'�������� ���������棩
Function getRand(ByVal nCount)
    getRand = getRnd(nCount) 
End Function 

'��������N�� InputStr����ֵ  Multiplier������php����һ��2014 12 02
'��� multiplier ������ΪС�ڵ���0���������ؿ��ַ�����
Function copyStrNumb(ByVal InputStr, Multiplier)
    Dim i, s 
    If Multiplier > 0 Then
        s = InputStr 
        For i = 1 To Multiplier - 1
            InputStr = InputStr & s 
        Next 
    Else
        InputStr = "" 
    End If 
    copyStrNumb = InputStr 
End Function 

'��������N��  PHP�ﺯ��
Function str_Repeat(ByVal InputStr, Multiplier)
    str_Repeat = copyStrNumb(InputStr, Multiplier) 
End Function 

'���������
Function copyStr(InputStr, Multiplier)
    copyStr = copyStrNumb(InputStr, Multiplier) 
End Function 

'���ݼ�Tab
Function contentAddTab(ByVal content, nNumb)
    contentAddTab = copyStr("    ", nNumb) & Join(Split(content, vbCrLf), vbCrLf & copyStr("    ", nNumb)) 
End Function 

'ɾ�����ָ���ַ�20150228 Content=DeleteEndStr(Content,2)
Function deleteEndStr(content, nLen)
    If content <> "" Then content = Left(content, Len(content) - nLen) 
    deleteEndStr = content 
End Function 


'StringNumber (2013,9,27)
Function toNumber(ByVal n, ByVal d)
    toNumber = FormatNumber(n, d, - 1) 
End Function 

'����������
Function handleNumber(ByVal content)
    Dim i, s, c 
    c = "" 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If InStr("0123456789", s) > 0 Then
            c = c & s 
        End If 
    Next 
    handleNumber = c 
End Function 

'�ַ�������ȡ���� 20150507
Function strDrawInt(ByVal content)
    strDrawInt = handleNumber(content) 
End Function 

'���������� ���ַ�������-����
Function getFirstNegativeNumber(ByVal content)
    Dim i, s, c 
    c = "" 
    content = Trim(content) 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If s = "-" And c = "" Then
            c = c & s 
        ElseIf InStr("0123456789", s) > 0 Then
            c = c & s 
        End If 
    Next 
    If c = "" Then c = 0 
    getFirstNegativeNumber = c 
End Function 

'����Ƿ�Ϊ��������
Function checkNumberType(ByVal content)
    checkNumberType = handleNumber(content) 
End Function 

'����ַ�����Ϊ��������
Function checkStrIsNumberType(ByVal content)
    Dim i, s 
    checkStrIsNumberType = True 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If InStr("0123456789", s) = False Then
            checkStrIsNumberType = False 
            Exit Function 
        End If 
    Next 
End Function 

'��������������
Function handleNumberType(ByVal content)
    Dim i, s, c 
    c = "" 
    content = Trim(content) 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If i = 1 And InStr("+-*/", Left(content, 1)) > 0 Then
            c = c & s 
        ElseIf i > 1 And s = "." Then
            c = c & s 
        ElseIf InStr("0123456789", s) > 0 Then
            c = c & s 
        End If 
    Next 
    handleNumberType = c 
End Function 

'������� ֻ����������� ���ҵ�һ����������Ϊ��0     20150322
Function getNumber(ByVal content)
    Dim i, s, c 
    c = "" 
    content = Trim(content) 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If InStr("0123456789", s) > 0 Then
            If c = "" And s = "0" Then                                                      '���Ľ�����Ϊ�������Ӳ������ˣ�����ô����20150322
            Else
                c = c & s 
            End If 
        End If 
    Next 
    getNumber = "" 
    If c <> "" Then
        getNumber = Int(c) 
    End If 
End Function 

'����Ƿ�Ϊ����
Function checkNumb(s)
    If InStr("0123456789.", s) > 0 Then
        checkNumb = True 
    Else
        checkNumb = False 
    End If 
End Function 

'�����С��������
Function getDianNumb(ByVal content)
    Dim i, s, c 
    c = "" 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If InStr("0123456789.", s) > 0 Then
            c = c & s 
        End If 
    Next 
    getDianNumb = c 
End Function 

'�����ҳ��
Function getCountPage(nCount, nPageSize)
    '�Ѹ���ת����ȷ���м���20150502
	dim nCountPage
    If nCount < 0 Then
        nCount = nCount * - 1 
    End If 
    If nPageSize < 0 Then
        nPageSize = nPageSize * - 1 
    End If 
    nCountPage = Fix(nCount / nPageSize) 
    If InStr(nCount / nPageSize, ".") > 0 Then nCountPage = nCountPage + 1 
	getCountPage=nCountPage
End Function 

'��ô�����ҳ��
Function getPageNumb(nRecordCount, nPageSize)
	dim n
    n = Int(nRecordCount / nPageSize) 
    If nRecordCount Mod nPageSize > 0 Then
        n=n + 1 
    End If 
	getPageNumb=n
End Function 

'������òɼ���ҳ��
Function getCaiHandleCountPage(content)
    content = DelHtml(content) 
    content = handleNumber(content) 
    getCaiHandleCountPage = "" 
    If Len(content) < 10 Then
        getCaiHandleCountPage = Right(content, 1) 
    ElseIf Len(content) < 200 Then
        getCaiHandleCountPage = Right(content, 2) 
    End If 
End Function 

'��òɼ�������ҳ�� 20150312
Function getCaiSortCountPage(ByVal content)
    Dim i, s 
    getCaiSortCountPage = "" 
    content = DelHtml(content) 
    content = handleNumber(content) 
    For i = 1 To 30
        s = Mid(content, 1, Len(i)) 
        If s = CStr(i) Then
            getCaiSortCountPage = i 
            'Call Echo(i,s)
            content = Right(content, Len(content) - Len(i)) 
        End If 
    Next 
End Function 

'�������С֮�� Between the minimum and maximum
Function minMaxBetween(Minimum, Maximum, ValueNumb)
    Minimum = CInt(Minimum)                                                         '��С��
    Maximum = CInt(Maximum)                                                         '�����
    ValueNumb = CInt(ValueNumb)                                                     '��ǰ��
    If Minimum > Maximum Then
        minMaxBetween = Maximum 
    ElseIf ValueNumb > Minimum Then
        minMaxBetween = ValueNumb 
        If ValueNumb > Maximum Then
            minMaxBetween = Maximum 
        End If 
    Else
        minMaxBetween = Minimum 
    End If 
End Function 

'��������ļ�����������  (��FSO�ļ����Ѿ������������20141220)
Function getStrFileType(fileName)
    Dim c 
    c = "" 
    If InStr(fileName, ".") > 0 Then
        c = LCase(Mid(fileName, InStrRev(fileName, ".") + 1)) 
        If InStr(c, "?") > 0 Then
            c = Mid(c, 1, InStr(c, "?") - 1) 
        End If 
    End If 
    getStrFileType = c 
End Function 

'���ַ�����ת����������
Function val(ByVal s)
    If s & "" = "" Or Not IsNumeric(s) Then
        val = 0 
    Else
        val = CLng(s) 
    End If 
End Function 

'�����ַ������N��byte
Function strLen(str)
    If IsNull(str) Or str = "" Then
        strLen = 0 
    Else
        Dim i, n, k, chrA 
        k = 0 
        n = Len(str) 
        For i = 1 To n


            chrA = Mid(str, i, 1) 

            'If Asc(chrA) >= 0 And Asc(chrA) <= 255 Then
            'K = K + 1
            'Else
            'K = K + 2
            'End If

            If chrA < 0 Then chrA = chrA + 65536 
            If chrA < 255 Then k = k + 1 
            If chrA > 255 Then k = k + 2 

        Next 
        strLen = k 
    End If 
End Function 

'ѭ�������� AddIndent(Content,"    ")
Function addIndent(content, IndentStr)
    Dim splStr, s, c 
    c = "" 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        c = c & IndentStr & s & vbCrLf 
    Next 
    addIndent = TrimVbCrlf(c) 
End Function 

'�������ǰ�ַ� 2014 12 12(������Ϊ����ǿ�л��ֿ�����)
Function getNumberBeforeStr(content)
    Dim i, s, c 
    c = "" 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If InStr("0123456789", s) > 0 Then Exit For 
        c = c & s 
    Next 
    getNumberBeforeStr = c 
End Function 

'�������� 20141212
'�÷�response.write makePassword(6)
Function makePassword(ByVal maxLen)
    Dim strNewPass 
    Dim whatsNext, upper, lower, intCounter 
    Randomize 
    strNewPass = "" 
    For intCounter = 1 To maxLen
        whatsNext = Int((1 - 0 + 1) * Rnd + 0) 
        If whatsNext = 0 Then
            upper = 90 
            lower = 65 
        Else
            upper = 57 
            lower = 48 
        End If 
        strNewPass = strNewPass & Chr(Int((upper - lower + 1) * Rnd + lower)) 
    Next 
    makePassword = strNewPass 
End Function 

'����˵������������ַ�����������Сд��ĸ�����֣����������ϣ������ڸ����롣 20141212
'����˵����stars--��������С���ȣ�ends--��������󳤶�
'�÷�'Response.Write rndcode(20, 330)
Function rndcode(ByVal stars, ByVal ends)
    Dim rndlen, i 
    Randomize 
    rndcode = "" 
    rndlen = Int(stars * Rnd + ends - stars) 
    For i = 1 To rndlen
        Randomize 
        rndcode = rndcode & Chr(Int(127 * Rnd + 1)) 
    Next 
End Function 

'�������ֻ����� ûʲô���壬���ñ��˵�  20141217
'��:CAll Rw(GetRandomPhoneNumber(41))
Function getRandomPhoneNumber(nCount)
    Dim num1, rndnum, j, c 
    c = "" : rndnum = "" 
    j = 1 
    Do While j < nCount
        Randomize 
        Do While Len(rndnum) < 9                                                        '����������ĸ���
            num1 = CStr(Chr((57 - 48) * Rnd + 48)) 
            rndnum = rndnum & num1 
        Loop 
        c = c & 13 & rndnum & vbCrLf 
        rndnum = "" 
        j = j + 1 
    Loop 
    If c <> "" Then c = Left(c, Len(c) - 2) 
    getRandomPhoneNumber = c 
End Function 

'����ַ�����
Function lenStr(content)
    Dim l, t, c 
    c = "" 
    Dim i 
    l = Len(content) 
    t = 0 
    For i = 1 To l
        c = Asc(Mid(content, i, 1)) 
        If c < 0 Then c = c + 65536 
        If c < 255 Then t = t + 1 
        If c > 255 Then t = t + 2 
    Next 
    lenStr = t 
End Function 

'����ת�ַ���
Function toString(ByVal arr)
    If IsArray(arr) Then
        Dim tmp 
        tmp = Join(arr, ",") 
        toString = tmp 
    Else
        toString = arr 
    End If 
End Function 
'�Ƴ�����(20151022)
Function remoteNumber(content)
    Dim i, s, c 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        If InStr("0123456789.", s) = False Then
            c = c & s 
        End If 
    Next 
    remoteNumber = c 
End Function 


'================================================= �ж��������ַ� start
'��������ָ���ַ�
Function handleHaveStr(content, zd)
    Dim s, i 
    handleHaveStr = False 
    For i = 1 To Len(zd)
        s = Mid(zd, i, 1) 
        If InStr(content, s) > 0 Then
            handleHaveStr = True 
            Exit Function 
        End If
    Next 
End Function 
'��Сд(20151224)
Function haveLowerCase(content)
    haveLowerCase = handleHaveStr(content, "abcdefghijklmnopqrstuvwxyz") 
End Function 
'�д�д(20151224)
Function haveUpperCase(content)
    haveUpperCase = handleHaveStr(content, "ABCDEFGHIJKLMNOPQRSTUVWXYZ") 
End Function 
'������(20151224)
Function haveNumber(content)
    haveNumber = handleHaveStr(content, "0123456789") 
End Function 
'�к���(20151224)
Function haveChina(content)
    Dim i, j 
    haveChina = False 
    For i = 1 To Len(content)
        j = Asc(Mid(content, i, 1)) 
        '�Ǻ����ۼ�
        If j < 0 Then
            If(j <= -22033 And j >= -24158) = False Then
                haveChina = True 
                Exit Function 
            End If 
        End If 
    Next 
End Function 
'================================================= �ж��������ַ� end
%>  

