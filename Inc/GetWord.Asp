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
dim WordReadContent
'获得关键词 
Function GetKeyWord(ByVal Content)
	GetKeyWord = GetHandleKeyWord(Content,"")
End Function 
'获得处理后关键词  20150224
Function GetHandleKeyWord(ByVal Content, SType)
    Dim nOK, SplStr, I, J, TempContent, C, S 
	If WordReadContent = "" Then      
		WordReadContent = vbCrlf & GetFText("/DataDir/keyWord.txt")  & vbCrlf 
	End If
    'Call Die(WordReadContent)
    nOK = 0 
    If CStr(SType)="1" Then 
        TempContent = Content & "    " 
        For I = 1 To Len(Content)
            For J = 2 To 4
                S = Mid(TempContent, I, J) 
                If InStr(" " & C & " ", " " & S & " ") = False Then
                    If InStr(WordReadContent, vbCrlf & S & vbCrlf) > 0 Then
                        C = C & S & " " 
                        nOK = nOK + 1 
                    End If 
                End If 
            Next 
        Next 
	Else 	'这种方法比上面方法快N倍
        SplStr = Split(WordReadContent, vbCrlf) 
        For Each S In SplStr
			'Call Echo("S",S)
            If S <> "" Then
                If InStr(" " & C & " ", " " & S & " ") = False Then
                    If InStr(Content, S) > 0 Then
                        C = C & S & " " 
                        nOK = nOK + 1 
                    End If 
                End If 
            End If 
        Next
    End If 
	GetHandleKeyWord = C 
End Function 


'获得中文汉字内容 
Function GetChinaStr(Content)
    Dim I, C, J, S
    For I = 1 To Len(Content)
		J = Asc(Mid(Content, I, 1))
		S = Mid(Content, I, 1)
		 '是汉字累加
        If J < 0 Then
			If (J <= - 22033 And J >= - 24158) = False And InStr ("�? ", S) = False Then
            	C = C & S
			End If
		'不是汉字 判断前一个字符是否为空格
        ElseIf Right(C,1)<>" " Then
            C = C & " " 
        End If 
    Next
	
    GetChinaStr = C 
End Function 
%> 
