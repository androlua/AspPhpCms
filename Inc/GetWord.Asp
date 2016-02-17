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
dim WordReadContent

Function GetKeyWord(ByVal a)
	GetKeyWord = GetHandleKeyWord(a,"")
End Function

Function GetHandleKeyWord(ByVal a, b)
    Dim c, d, e, f, g, h, i
	If WordReadContent = "" Then
		WordReadContent = vbCrlf & GetFText("/DataDir/keyWord.txt")  & vbCrlf
	End If

    c = 0
    If CStr(b)="1" Then
        g = a & "    "
        For e = 1 To Len(a)
            For f = 2 To 4
                i = Mid(g, e, f)
                If InStr(" " & h & " ", " " & i & " ") = False Then
                    If InStr(WordReadContent, vbCrlf & i & vbCrlf) > 0 Then
                        h = h & i & " "
                        c = c + 1
                    End If
                End If
            Next
        Next
	Else 	
        d = Split(WordReadContent, vbCrlf)
        For Each i In d
			
            If i <> "" Then
                If InStr(" " & h & " ", " " & i & " ") = False Then
                    If InStr(a, i) > 0 Then
                        h = h & i & " "
                        c = c + 1
                    End If
                End If
            End If
        Next
    End If
	GetHandleKeyWord = h
End Function



Function GetChinaStr(a)
    Dim b, c, d, e
    For b = 1 To Len(a)
		d = Asc(Mid(a, b, 1))
		e = Mid(a, b, 1)
		
        If d < 0 Then
			If (d <= - 22033 And d >= - 24158) = False And InStr ("�? ", e) = False Then
            	c = c & e
			End If
		
        ElseIf Right(c,1)<>" " Then
            c = c & " "
        End If
    Next
	
    GetChinaStr = c
End Function
%>


