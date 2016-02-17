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
<!--#Include File="Config.Asp"-->
<%
Call UpWeb()
Sub UpWeb()
    Dim b, c, d, e, f, g, h, i, j, k, l, m

	
    If Request("act") = "getVersionNumber" Then
        Call Die("V1.1")
    End If

	
    If GetIP = "127.0.0.1" Or InStr(GetIP, "192.168.") > 0 Then
        Call Die("为本地，不可以上传文件")
    End If
	
    If MD5(Request("UPEV"), 2) & MD5(Request("UPEV"), 4) <> "6178bbf3bfe62a59" Then
        Call Die("UPEV=" & Request("UPEV") & "(" & MD5(Request("UPEV"), 2) & MD5(Request("UPEV"), 4) & ")")
    End If

	
    If Request("DownFile") <> "" Then
        Call DownRemoteFile(Request("DownFile"))
        Response.End()
	
    ElseIf Request("act") = "delWithout" Then
        c = Rf("Content")
		
        f = Split(c, vbCrLf)
        For Each b In f
			If b<>"" Then
				If CheckFile(b)=True Then
					Call DeleteFile(b)
					i=i & b & "(Del True)" & vbCrlf
				Else
					i=i & b & "(Del NoFile)" & vbCrlf
				End If
			End If
		Next

		Call Die(i)
    End If

	
    If Request("act") = "Comparison" Then
        c = Rf("Content")
        f = Split(c, vbCrLf)
        For Each e In f
            If e <> "" Then
                g = Split(e, "|")
                b = g(0)
                l = g(1)
            	
                If CheckFile(b) = True Then
                    k = GetFileEditDate(b)
                    k = Format_Time(k, 1)
                	
                	
                    If DateDiff("s", l, k) <= 0 Then
                        i = i & b & vbCrLf
                    End If
            	
                Else
                    i = i & b & vbCrLf
                End If
            End If
        Next
        Call Rw(i)
    	
        Response.End()
    End If



    b = Request.Form("FilePath")
    c = Request.Form("Content")
    m = Request.Form("CharSet")

    d = LCase(getFileExtName(b))

    b = HandlePath(b)
    Call CreateDirFolder(b)

	
    If Request("UpType") = "binary" Then
        Call DecSaveBinary(b, c, 2)
        Call Rw(b & "|二进制保存")
    Else
        c = SpecialHtmlUploadEncryptionDecrypt(c, "Decrypt")
        Call WriteToFile(b, c, m)
        Call Rw(b & "|普通保存")
    End If
End Sub
%>




