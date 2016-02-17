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



Function getFileText(ByVal a)
    On Error Resume Next
    Dim b, c, d

    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.openTextFile(a, 1)

                Set d = b.GetFile(a)
                    If d.Size = 0 Then getFileText = "" : Exit Function
                Set d = Nothing
                getFileText = c.ReadAll
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFileText 读取文件内容 函数出错，filePath=" & a)
End Function

Function getFText(a)
    getFText = getFileText(a)
End Function

Function getFileType(ByVal a)
    On Error Resume Next
    Dim b, c, d

    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                getFileType = c.Type
        End If
            Set b = Nothing
            If Err Then Call doError(Err.Description, "GetFileText 读取文件类型 函数出错，filePath=" & a)
End Function


Function checkFile(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        checkFile = b.fileExists(a)
    Set b = Nothing
    If Err Then Call doError(Err.Description, "CheckFile 检查文件 函数出错，filePath=" & a)
End Function

Function existsFile(a)
    existsFile = checkFile(a)
End Function

Function createFile(ByVal a, ByVal b)

    Dim c, d
    Call HandlePath(a)
    Set d = CreateObject("Scripting.FileSystemObject")
        If ExistsZhiDuFile(a) = True Then
            Call EditFileAttribute(a, 32)
        End If
		call echo("filePath",a)
        Set c = d.createTextFile(a, True)
            c.WriteLine(b)
            createFile = True
        Set c = Nothing
    Set d = Nothing
    If Err Then createFile = False : Call doError(Err.Description, "CreateFile 创建文件 函数出错，filePath=" & a)
End Function

Function saveFile(a, b)
    saveFile = createFile(a, b)
End Function

Function createAddFile(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) = False Then
            Set d = c.createTextFile(a, True)
                d.WriteLine(b)
            Set d = Nothing
            createAddFile = "创建文件成功"
        Else
            createAddFile = AddToFile(a, b)
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "CreateAddFile 创建文件，存在累加 函数出错，filePath=" & a)
End Function

Function createAddUpFile(a, b)
    createAddUpFile = createAddFile(a, b)
End Function

Function addToFile(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    If ExistsZhiDuFile(a) = True Then
        Call EditFileAttribute(a, 32)
    End If
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) = True Then
            Set d = c.openTextFile(a, 8)
                d.WriteLine(b)
            Set d = Nothing
            addToFile = "追加信息成功"
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "AddToFile 追加文件信息 函数出错，filePath=" & a & "<br>Content字符长" & Len(b) & " Content类型" & TypeName(b) & "【" & b & "】")
End Function

Function saveByteFile(ByVal a, b)
    Dim c
    a = HandlePath(a)
    Set c = CreateObject("ADODB.Stream")
        With c
            .Type = 1
            .Open
            .Write b

            .SaveToFile a, 2
            .Cancel
            .Close
        End With
    Set c = Nothing
End Function
Function createByteFile(a, b)

End Function

Function moveFile(ByVal a, ByVal b)
    On Error Resume Next
    Dim c
    Call HandlePath(a)
    Call HandlePath(b)
    moveFile = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) = True And c.fileExists(b) = False Then
            Call c.moveFile(a, b)
            moveFile = True
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "MoveFile 移动文件 函数出错，Path=" & a & "，ToPath=" & b)
End Function

Function editFile(a, b)
    editFile = moveFile(a, b)
End Function

Function copyFile(ByVal a, ByVal b)
    On Error Resume Next
    Dim c
    Call HandlePath(a)
    Call HandlePath(b)
    copyFile = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) = True And c.fileExists(b) = False Then
            Call c.copyFile(a, b)
            copyFile = True
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "CopyFile 拷贝文件 函数出错，Path=" & a & "，ToPath=" & b)
End Function

Function deleteFile(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    deleteFile = False
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Call b.deleteFile(a, True)
            deleteFile = True
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "DeleteFile 删除文件 函数出错，filePath=" & a)
End Function

Function delSelFile(a, ByVal b)
    Dim c, d, e
    e = ""
    c = Split(b, "|")
    For Each d In c
        If d <> "" Then

            Call deleteFile(a & d)
            e = e & d & vbCrLf
        End If
    Next
    delSelFile = e
End Function
Function delFileList(a, ByVal b)
    delFileList = delSelFile(a, b)
End Function

Function batchDelFile(a, b)
    Dim c, d, e
    For Each c In b
        d = a & c
        e = e & d & vbCrLf
        Call deleteFile(d)
    Next
    batchDelFile = e
End Function

Function deleteAppointFileList(ByVal a)

    Dim b, c, d, e
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) = False Then deleteAppointFileList = "" : Exit Function
        Set c = b.GetFolder(a)
            For Each d In c.files
                e = BaseName(d)

                If Left(e, 1) = "#" Then
                    Call deleteFile(d)
                End If
                DoEvents
            Next
        Set c = Nothing
    Set b = Nothing
    deleteAppointFileList = ""
End Function

Function getFileSize(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    getFileSize = 0
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                getFileSize = c.Size
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFileSize 获得文件大小 函数出错，FileName=" & a)
End Function

Function fileSize(a)
    fileSize = getFileSize(a)
End Function

Function getFSize(a)
    getFSize = getFileSize(a)
End Function

Function getFileCreateDate(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                getFileCreateDate = c.DateCreated
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFileCreateDate 获得文件创建时间 函数出错，FileName=" & a)
End Function

Function fileCreateDate(a)
    fileCreateDate = getFileCreateDate(a)
End Function

Function getFileEditDate(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                getFileEditDate = c.DateLastModified
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFileEditDate 获得文件修改时间 函数出错，FileName=" & a)
End Function

Function fileEditDate(a)
    fileEditDate = getFileEditDate(a)
End Function

Function getFileEditTime(a)
    getFileEditTime = getFileEditDate(a)
End Function

Function getDateLastAccessed(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                getDateLastAccessed = c.DateLastAccessed
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFileEditDate 获得文件访问时间 函数出错，FileName=" & a)
End Function

Function modifyFileModifydate(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d, e, f
    Call HandlePath(a)
    If checkFile(a) = False Then
        modifyFileModifydate = False
        Exit Function
    End If
    c = Left(a, InStrRev(a, "\"))
    a = Right(a, Len(a) - Len(c))


    Set d = CreateObject("Shell.Application")
        Set e = d.NameSpace(c)
            Set f = e.ParseName(a)
                f.Modifydate = b
                modifyFileModifydate = True
                If Err Then Call doError(Err.Description, "ModifyFileModifydate 获得文件修改时间 函数出错，FileName=" & c & a)
End Function

Function editFileEditDate(a, b)
    editFileEditDate = modifyFileModifydate(a, b)
End Function

Function existsZhiDuFile(ByVal a)
    On Error Resume Next
    Dim b, c
    existsZhiDuFile = False
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                existsZhiDuFile = c.Attributes
            Set c = Nothing
            If existsZhiDuFile >= 128 Then existsZhiDuFile = existsZhiDuFile - 128
            If existsZhiDuFile >= 64 Then existsZhiDuFile = existsZhiDuFile - 64
            If existsZhiDuFile >= 32 Then existsZhiDuFile = existsZhiDuFile - 32
            If existsZhiDuFile >= 8 Then existsZhiDuFile = existsZhiDuFile - 8
            If existsZhiDuFile >= 4 Then existsZhiDuFile = existsZhiDuFile - 4
            If existsZhiDuFile >= 2 Then existsZhiDuFile = existsZhiDuFile - 2
            existsZhiDuFile = CBool(existsZhiDuFile)
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "ExistsZhiDuFile 判断只读文件 函数出错，FileName=" & a)
End Function

Function getFileAttribute(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    getFileAttribute = -1
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.fileExists(a) = True Then
            Set c = b.GetFile(a)
                getFileAttribute = c.Attributes
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFileAttribute 获得文件属性 函数出错，FileName=" & a)
End Function

Function editFileAttribute(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    editFileAttribute = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) = True Then
            Set d = c.GetFile(a)
                d.Attributes = b
            Set d = Nothing
            editFileAttribute = True
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "EditFileAttribute 修改文件属性 函数出错，FileName=" & a)
End Function

Function existsFileDay(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d, e
    Call HandlePath(a)
    existsFileDay = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) = True Then
            Set d = c.GetFile(a)
                e = DateDiff("d", d.DateLastModified, Now())
                If e <= b Then existsFileDay = True
            Set d = Nothing
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "ExistsFileDay 判断文件天数 函数出错，FileName=" & a)
End Function

Function checkFileDay(a, b)
    checkFileDay = existsFileDay(a, b)
End Function


Function createFolder(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    createFolder = False
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) = False Then
            b.createFolder(a)
            createFolder = True
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "CreateFolder 创建文件夹 函数出错，FolderPath=" & a & ":::" & b.FolderExists(a))
End Function

Function createDirFolder(ByVal a)

    createDirFolder = ""
    If CheckFolder(a) = True Then Exit Function
    Dim b, c, d, e
    e = ""
    Call HandlePath(a)
    b = Split(a, "\")
    For c = 0 To UBound(b)
        d = Trim(b(c))
        If d <> "" Then
            e = e & d & "\"
            If c = UBound(b) And InStr(d, ".") > 0 Then Exit For
            If InStr(d, ":") = False Then

                Call CreateFolder(e)
            End If
        End If
    Next
End Function

Function createDomain(ByVal a, ByVal b)
    On Error Resume Next
    Dim c
    Call HandlePath(a)
    createDomain = False
    b = GetWebSite(b)
    b = Replace(Replace(Replace(b, "http://", ""), "/", ""), ".", "_")
    b = Replace(b, ":", "_")
    c = a & b
    If CheckFolder(c) = False Then
        Call CreateFolder(c)
        createDomain = True
    End If
    If Err Then Call doError(Err.Description, "CreateDoMain 创建以域名命名的文件夹 函数出错，FolderPath=" & a)
End Function

Function createDomainFolder(a, b)
    createDomainFolder = createDomain(a, b)
End Function

Function moveFolder(ByVal a, ByVal b)
    On Error Resume Next
    Dim c
    Call HandlePath(a)
    Call HandlePath(b)
    moveFolder = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FolderExists(a) = True And c.FolderExists(b) = False Then
            Call c.moveFolder(a, b)
            moveFolder = True
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "MoveFolder 移动文件夹 函数出错，Path=" & a & "，ToPath=" & b)
End Function

Function editFolder(a, b)
    editFolder = moveFolder(a, b)
End Function

Function copyFolder(ByVal a, ByVal b)
    On Error Resume Next
    Dim c
    Call HandlePath(a)
    Call HandlePath(b)

    If Right(a, 1) = "\" Then
        a = Left(a, Len(a) - 1)
    End If
    If Right(b, 1) = "\" Then
        b = Left(b, Len(b) - 1)
    End If
    copyFolder = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FolderExists(a) = True And c.FolderExists(b) = False Then
            Call c.copyFolder(a, b)
            copyFolder = True
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "CopyFolder 拷贝文件夹 函数出错，Path=" & a & "，ToPath=" & b)
End Function

Function deleteFolder(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    deleteFolder = False
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) Then
            If Right(a, 1) = "\" Then a = Left(a, Len(a) - 1)
            Call b.deleteFolder(a, True)
            deleteFolder = True
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "DeleteFolder 删除文件夹 函数出错，FolderPath=" & a)
End Function

Function getFolderSize(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    getFolderSize = 0
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) Then
            Set c = b.GetFolder(a)
                getFolderSize = c.Size
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFolderSize 获得文件夹大小 函数出错，FolderName=" & a)
End Function

Function checkFolder(ByVal a)
    On Error Resume Next
    Dim b
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        checkFolder = b.FolderExists(a)
    Set b = Nothing
    If Err Then Call doError(Err.Description, "CheckFolder 检查夹文件 函数出错，FolderName=" & a)
End Function

Function existsFolder(a)
    existsFolder = checkFolder(a)
End Function

Function getFolderCreateDate(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) Then
            Set c = b.GetFolder(a)
                getFolderCreateDate = c.DateCreated
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFolderCreateDate 获得文件创建时间 函数出错，FolderName=" & a)
End Function

Function getFolderEditDate(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) Then
            Set c = b.GetFolder(a)
                getFolderEditDate = c.DateLastModified
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFolderEditDate 获得文件修改时间 函数出错，FolderName=" & a)
End Function

Function getFolderTime(a)
    getFolderTime = getFolderEditDate(a)
End Function

Function getFolderAttribute(ByVal a)
    On Error Resume Next
    Dim b, c
    Call HandlePath(a)
    getFolderAttribute = 0
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) = True Then
            Set c = b.GetFolder(a)
                getFolderAttribute = c.Attributes
            Set c = Nothing
        End If
    Set b = Nothing
    If Err Then Call doError(Err.Description, "GetFolderAttribute 获得文件属性 函数出错，FolderName=" & a)
End Function

Function editFolderAttribute(ByVal a, b)
    On Error Resume Next
    Dim c, d
    Call HandlePath(a)
    editFolderAttribute = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FolderExists(a) Then
            Set d = c.GetFolder(a)
                d.Attributes = b
            Set d = Nothing
            editFolderAttribute = True
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "EditFolderAttribute 修改文件属性 函数出错，FolderName=" & a)
End Function

Function existsFolderDay(ByVal a, ByVal b)
    On Error Resume Next
    Dim c, d, e
    Call HandlePath(a)
    existsFolderDay = False
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FolderExists(a) = True Then
            Set d = c.GetFolder(a)
                e = DateDiff("d", d.DateLastModified, Now())
                If e <= b Then existsFolderDay = True
            Set d = Nothing
        End If
    Set c = Nothing
    If Err Then Call doError(Err.Description, "ExistsFolderDay 判断文件夹天数 函数出错，FolderName=" & a)
End Function

Function checkFolderDay(a, b)
    checkFolderDay = existsFolderDay(a, b)
End Function

Function getFileFolderList(ByVal a, b, c, d, e, f, ByVal g)
    On Error Resume Next
    getFileFolderList = ""
    Dim h, i, j, k, l, m
    Call HandlePath(a)
    c = LCase(c)
    Set h = CreateObject("Scripting.FileSystemObject")
        If Not h.FolderExists(a) Then Exit Function
        Set i = h.GetFolder(a)
            If b = True Then
                For Each k In i.files
                    m = LCase(Right(k.Name, Len(k.Name) - InStrRev(k.Name, ".")))

                    If(InStr("|" & c & "|", "|" & m & "|") > 0 Or c = "" Or c = "全部" Or c = "*") And c <> "0" Then
                        If InStr("|名称|取名称|", "|" & d & "|") > 0 Then
                            g = g & k.Name & vbCrLf
                        Else
                            g = g & k & vbCrLf
                        End If
                    End If
                    DoEvents
                Next
            End If

            If InStr("|当前|全部|文件夹|全部文件夹|", "|" & e & "|") > 0 Then
                Set j = i.subFolders
                    For Each l In j
                        If InStr("|名称|取名称|", "|" & f & "|") > 0 Then
                            g = g & l.Name & vbCrLf
                        ElseIf LCase(f) <> "no" Then
                            g = g & l & vbCrLf
                        End If
                        If InStr("|全部|全部文件夹|", "|" & e & "|") > 0 Then
                            g = getFileFolderList(l, b, c, d, e, f, g) & vbCrLf
                        End If
                        DoEvents
                    Next
                Set j = Nothing
            End If
        Set i = Nothing
    Set h = Nothing
    If g <> "" Then g = Left(g, Len(g) - 2)
    getFileFolderList = g
    If Err Then Call doError(Err.Description, "GetFileFolderList 获得全部文件（夹）列表 函数出错，FolderPath=" & a)
End Function

Function getDirJpgList(ByVal a)
    getDirJpgList = getFileFolderList(a, True, "jpg", "", "", "", "")
End Function

Function getDirIniList(ByVal a)
    getDirIniList = getFileFolderList(a, True, "ini", "", "", "", "")
End Function

Function getDirTxtList(ByVal a)
    getDirTxtList = getFileFolderList(a, True, "txt", "", "", "", "")
End Function

Function getDirHtmlList(ByVal a)
    getDirHtmlList = getFileFolderList(a, True, "html", "", "", "", "")
End Function

Function getDirCssList(ByVal a)
    getDirCssList = getFileFolderList(a, True, "css", "", "", "", "")
End Function

Function getDirJsList(ByVal a)
    getDirJsList = getFileFolderList(a, True, "js", "", "", "", "")
End Function

Function getDirFileList(ByVal a)
    getDirFileList = getFileFolderList(a, True, "全部", "", "", "", "")
End Function

Function getDirHtmlListName(ByVal a)
    getDirHtmlListName = getFileFolderList(a, True, "html", "名称", "", "", "")
End Function

Function getDirFileNameList(ByVal a)
    getDirFileNameList = getFileFolderList(a, True, "全部", "名称", "", "", "")
End Function

Function getDirAllFileNameList(ByVal a)
    getDirAllFileNameList = getFileFolderList(a, True, "全部", "名称", "全部文件夹", "", "")
End Function

Function getDirFolderList(ByVal a)
    getDirFolderList = getFileFolderList(a, False, "", "", "文件夹", "", "")
End Function

Function getDirFolderNameList(ByVal a)
    getDirFolderNameList = getFileFolderList(a, False, "", True, "文件夹", "名称", "")
End Function

Function getThisAllFolder(a)
    getThisAllFolder = getDirFolderList(a)
End Function

Function getThisAllFolderName(a)
    getThisAllFolderName = getDirFolderNameList(a)
End Function

Function getFileFolderNumb(ByVal a, b, ByVal c)
    On Error Resume Next
    Dim d, e, f, g
    getFileFolderNumb = c
    Call HandlePath(a)
    Set d = CreateObject("Scripting.FileSystemObject")
        If d.FolderExists(a) = True Then
            Set e = d.GetFolder(a)
                Set f = e.subFolders
                    If b = "文件数量" Or b = "全部文件数量" Then
                        c = c + e.files.Count
                    ElseIf b = "文件夹数量" Or b = "全部文件夹数量" Then
                        c = c + f.Count
                    ElseIf b = "文件夹大小" Then
                        c = e.Size
                    End If
                    If b = "全部文件数量" Or b = "全部文件夹数量" Then
                        For Each g In f
                            c = getFileFolderNumb(g, b, c)
                            DoEvents
                        Next
                    End If
                Set e = Nothing
            Set f = Nothing
        End If
        getFileFolderNumb = c
    Set d = Nothing
    If Err Then Call doError(Err.Description, "GetDirFolderNumb 获得当前目录文件夹数量 函数出错，FolderPath=" & a)
End Function

Function getDirFolderNumb(a)
    getDirFolderNumb = getFileFolderNumb(a, "文件夹数量", 0)
End Function

Function getDirFolderSize(a)
    getDirFolderSize = getFileFolderNumb(a, "文件夹大小", 0)
End Function

Function getDirFileNumb(a)
    getDirFileNumb = getFileFolderNumb(a, "文件数量", 0)
End Function

Function getDirAllFileNumb(a)
    getDirAllFileNumb = getFileFolderNumb(a, "全部文件数量", 0)
End Function

Function getDirAllFolderNumb(a)
    getDirAllFolderNumb = getFileFolderNumb(a, "全部文件夹数量", 0)
End Function

Function getFolderList(ByVal a, b)

    Dim c, d, e, f, g
    g = ""
    b = CStr(b)
    Call HandlePath(a)
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.FolderExists(a) = True Then
            Set d = c.GetFolder(a)
                Set e = d.subFolders
                    For Each f In e
                        If b = "名称" Or b = "0" Then
                            g = g & f.Name & vbCrLf
                        Else
                            g = g & f & vbCrLf
                        End If
                        DoEvents
                    Next
                Set d = Nothing
            Set e = Nothing
        End If
        If g <> "" Then g = Left(g, Len(g) - 2)
        getFolderList = g
    Set c = Nothing
    If Err Then Call doError(Err.Description, "GetDirFolderNumb 获得当前目录文件夹数量 函数出错，FolderPath=" & a)
End Function

Function getDirFileSort(ByVal a)
    On Error Resume Next
    getDirFileSort = ""
    Dim b, c, d, e, f, ArrayStr(99), h, i
    i = ""
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) = False Then Exit Function
        Set c = b.GetFolder(a)
            For Each e In c.files
                If InStr(e.Name, "#") = False And InStr(e.Name, "、") > 0 Then
                    f = Replace(Left(e.Name, 2), "、", "")
                    ArrayStr(f) = e.Name
                End If
                DoEvents
            Next
            For h = 0 To UBound(ArrayStr)
                If ArrayStr(h) <> "" Then
                    i = i & ArrayStr(h) & vbCrLf
                End If
            Next
        Set c = Nothing
    Set b = Nothing
    getDirFileSort = i
    If Err Then Call doError(Err.Description, "GetDirFileSort 获得文件列表排序 函数出错，FolderPath=" & a)
End Function

Function getDirFolderSort(ByVal a)
    On Error Resume Next
    getDirFolderSort = ""
    Dim b, c, d, e, f, ArrayStr(99), h, i, j
    i = ""
    Call HandlePath(a)
    Set b = CreateObject("Scripting.FileSystemObject")
        If b.FolderExists(a) = False Then Exit Function
        Set c = b.GetFolder(a)
            Set d = c.subFolders
                For Each j In d
                    If InStr(j.Name, "#") = 0 And InStr(j.Name, "、") > 0 Then
                        f = Replace(Left(j.Name, 2), "、", "")
                        ArrayStr(f) = j.Name
                        DoEvents
                    End If
                Next
                For h = 0 To UBound(ArrayStr)
                    If ArrayStr(h) <> "" Then
                        i = i & ArrayStr(h) & vbCrLf
                    End If
                Next
            Set c = Nothing
        Set d = Nothing
    Set b = Nothing
    getDirFolderSort = i
    If Err Then Call doError(Err.Description, "GetDirFileSort 获得文件列表排序 函数出错，FolderPath=" & a)
End Function

Sub delDirAllFile(a)
    Dim b, c, d
    Set b = CreateObject("Scripting.FileSystemObject")
        Set c = b.GetFolder(a)
            Set d = c.files
                For Each c In d
                    If b.fileExists(c) Then b.deleteFile(c)
                Next
            Set d = Nothing
        Set c = Nothing
    Set b = Nothing
End Sub

Sub deleteAllFile(a)
    Call DelDirAllFile(a)
End Sub


Function getUpdateFile(ByVal a, b, c, d, ByVal e)

    Dim f, g, h, i, j, k, l, m, n, o, p
    getUpdateFile = ""
    n = ""
    p = ""
    Call HandlePath(a)
    If InStr(d, ",") Then
        o = Split(d, ",")
        n = Trim(o(0))
        d = Trim(o(1))
        If UBound(o) >= 2 Then p = Trim(o(2))
    End If
    If n = "" Then
        n = "s"
    End If
    If d = "" Then
        d = -1
    Else
        d = CLng(d)
    End If

    b = LCase(b)
    Set f = CreateObject("Scripting.FileSystemObject")
        If Not f.FolderExists(a) Then Exit Function
        Set g = f.GetFolder(a)
            For Each i In g.files
                If Left(i.Name, 1) <> "#" Then


                    l = DateDiff(n, i.DateLastModified, Now())

                    If l <= d Or d = -1 Then
                        k = LCase(Right(i.Name, Len(i.Name) - InStrRev(i.Name, ".")))

                        If(InStr("|" & b & "|", "|" & k & "|") > 0 Or b = "" Or b = "全部" Or b = "*") And b <> "0" Then
                            If p = "文件路径" Then
                                m = i
                            Else
                                m = i & "|" & CheckCode(i) & "|" & PrintSpaceValue(i.Size) & "|" & Format_Time(i.DateLastModified, 1) & "|" & l & "/" & d & "(" & d - l & ")"
                            End If
                            e = e & m & vbCrLf
                        End If
                    End If
                End If
                DoEvents
            Next

            If InStr("|当前|全部|文件夹|全部文件夹|", "|" & c & "|") > 0 Then
                Set h = g.subFolders
                    For Each j In h
                        If InStr("|全部|全部文件夹|", "|" & c & "|") > 0 Then
                            e = getUpdateFile(j, b, c, d, e) & vbCrLf
                        End If
                        DoEvents
                    Next
                Set h = Nothing
            End If
        Set g = Nothing
    Set f = Nothing
    If e <> "" Then e = Left(e, Len(e) - 2)
    getUpdateFile = e

End Function


Function handlePath(a)
    a = Replace(a, "/", "\")
    a = Replace(a, "\\", "\")
    a = Replace(a, "\\", "\")
    Dim b
    b = False
    If Right(a, 1) = "\" Then
        b = True
    End If
    If InStr(a, ":") = 0 Then
        If Left(a, 1) = "\" Then
            a = Server.MapPath("\") & "\" & a
        Else
            a = Server.MapPath(".\") & "\" & a
        End If
    End If
    a = Replace(a, "/", "\")
    a = Replace(a, "\\", "\")
    a = Replace(a, "\\", "\")
    a = FullPath(a)
    If b = True Then
        a = a & "\"
    End If
    handlePath = a
End Function

Function realPath(ByVal a)
    realPath = ""
    If checkFile(a) Then
        realPath = a
        Exit Function
    End If
    If checkFolder(a) Then
        realPath = a
        Exit Function
    End If
End Function

Function fullPath(ByVal a)
    Dim b, c, d
    d = ""
    a = Replace(a, "/", "\")
    b = Split(a, "\")
    For Each c In b
        c = Trim(c)
        If c <> "" And c <> "." Then
            If InStr(d, "\") > 0 And c = ".." Then
                d = Mid(d, 1, InStrRev(d, "\") - 1)
            Else
                If d <> "" And Right(d, 1) <> "\" Then d = d & "\"
                d = d & c
            End If
        End If
    Next
    fullPath = d
End Function

Function handleRelativePath(a, ByVal b)
    If a = "" Then a = "\"
    a = HandlePath(a)
    b = Replace(b, a, "\")
    handleRelativePath = b
End Function

Function dirName(a)
    a = HandleFileUrl(a)
    If Right(a, 1) <> "\" Then
        a = Mid(a, 1, InStrRev(a, "\"))
    End If
    dirName = a
End Function

Function isObjInstalled(a)
    On Error Resume Next
    isObjInstalled = False
    Dim b
    Set b = CreateObject(a)
        If 0 = Err.Number Then isObjInstalled = True
    Set b = Nothing
End Function

Function existsObject(a)
    existsObject = isObjInstalled(a)
End Function

Function getFileObject()
    If existsObject("Scripting.FileSystemObject") Then
        getFileObject = "Scripting.FileSystemObject"
    Else
        getFileObject = "Scripting.wang198060FileSystemObject"
    End If
End Function

Function getDictionary()
    If existsObject("Scripting.Dictionary") Then
        getDictionary = "Scripting.Dictionary"
    Else
        getDictionary = "Scripting.wang198060Dictionary"
    End If
End Function

Function getStream()
    If existsObject("Adodb.Stream") Then
        getStream = "Adodb.Stream"
    Else
        getStream = "Adodb.wang198060Stream"
    End If
End Function

Function showAttributeTip(a)
    Dim b
    b = ""
    If a = 0 Then b = "0普通文件，"
    If a >= 128 Then
        a = a - 128
        b = b & "128压缩文件，"
    End If
    If a >= 64 Then
        a = a - 64
        b = b & "64快捷键，"
    End If
    If a >= 32 Then
        a = a - 32
        b = b & "32存档，"
    End If
    If a >= 16 Then
        a = a - 16
        b = b & "16文件夹，"
    End If
    If a >= 8 Then
        a = a - 8
        b = b & "8卷材，"
    End If
    If a >= 4 Then
        a = a - 4
        b = b & "4系统，"
    End If
    If a >= 2 Then
        a = a - 2
        b = b & "2为隐藏，"
    End If
    If a >= 1 Then
        a = a - 1
        b = b & "1只读，"
    End If
    If b <> "" Then b = Left(b, Len(b) - 1)
    showAttributeTip = b
End Function

Function printSpaceValue(ByVal a)
    Dim b
    b = a
    If b >= 1073741824 Then
        b = b / 1073741824
        If InStr(b, ".") Then
            b = Left(b, InStr(b, ".") + 2)
        End If
        b = b & " G"
    ElseIf b >= 1048576 Then
        b = b / 1048576
        If InStr(b, ".") Then
            b = Left(b, InStr(b, ".") + 2)
        End If
        b = b & " M"
    Else
        b = Fix(b / 1024) & " K"
    End If
    If b = "0 K" Then b = a & "Bet"
    printSpaceValue = b
End Function

Function printSpaceSize(a)
    printSpaceSize = printSpaceValue(a)
End Function

Function printFileSize(a)
    printFileSize = printSpaceValue(a)
End Function

Function getDeskPath()
    Dim b
    Set b = CreateObject("Wscript.shell")
        getDeskPath = b.SpecialFolders("Desktop") & "\"
End Function

Function createUrlShortcut(a, ByVal b)
    Dim c
    c = "[InternetShortcut] " & vbCrLf
    c = c & "URL=" & b & vbCrLf
    c = c & "IDList= " & vbCrLf
    c = c & "[{000214A0-0000-0000-C000-000000000046}] " & vbCrLf
    c = c & "Prop3=19,2 " & vbCrLf


    Call CreateFile(a, c)
    createUrlShortcut = c
End Function

Function createFolderShortcut(a, b)
    Dim c
    c = "[InternetShortcut]  " & vbCrLf
    c = c & "URL=file:///" & b & vbCrLf
    c = c & "HotKey=0" & vbCrLf
    c = c & "IDList=" & vbCrLf
    c = c & "IconFile=C:\WINDOWS\system32\SHELL32.dll" & vbCrLf
    c = c & "IconIndex=3" & vbCrLf
    c = c & "[{000214A0-0000-0000-C000-000000000046}]" & vbCrLf
    c = c & "Prop3=19,9" & vbCrLf
    c = c & "[InternetShortcut.A]" & vbCrLf
    c = c & "URL=file:///" & b & vbCrLf
    c = c & "[InternetShortcut.W]" & vbCrLf
    c = c & "URL=file:///" & b & vbCrLf


    Call CreateFile(a, c)
    createFolderShortcut = c
End Function

Function findDirFileName(a, b)
    Dim c, d, e, f
    findDirFileName = ""
    b = LCase(b)
    Call HandlePath(a)
    Set c = CreateObject("Scripting.FileSystemObject")
        If Not c.FolderExists(a) Then Exit Function
        Set d = c.GetFolder(a)
            For Each e In d.files
                f = LCase(Mid(e.Name, 1, InStrRev(e.Name, ".") - 1))
                If b = f Then
                    findDirFileName = e.Name
                    Exit Function
                End If
                DoEvents
            Next
        Set d = Nothing
    Set c = Nothing
End Function

Function findSubDirFileName(a, b)
    Dim c, d
    findSubDirFileName = ""
    c = Split(b, "|")
    For Each d In c
        d = Trim(d)
        If d <> "" Then
            findSubDirFileName = findDirFileName(a, d)
            If findSubDirFileName <> "" Then Exit Function
        End If
    Next
End Function



Function getArticleFillContent(a, b, c)
    Dim d, e, f, g
    e = ""
    If a <> "" Then
        b = getFText(a)
    ElseIf b = "" Then
        b = getFText("\DataDir\自动填文章内容数据.txt")
    End If
    d = Split(b, vbCrLf)
    Randomize
    For g = 0 To c
        f = CInt(UBound(d) * Rnd)

        e = e & d(f)
    Next
    getArticleFillContent = e
End Function







Function getFilePathName(ByVal a)
    a = Replace(a, "\", "/")
    If InStr(a, "/") > 0 Then
        a = Mid(a, InStrRev(a, "/") + 1)
    End If
    If InStr(a, ".") > 0 Then
        a = Mid(a, 1, InStrRev(a, ".") - 1)
    End If
    getFilePathName = a
End Function

Function getExtension(a)
    getExtension = getFilePathName(a)
End Function

Function removeFileDir(ByVal a)
    a = Replace(a, "\", "/")
    If InStr(a, "/") > 0 Then
        a = Mid(a, InStrRev(a, "/") + 1)
    End If
    removeFileDir = a
End Function

Function baseName(ByVal a)
    baseName = removeFileDir(a)
End Function

Function getFileExtName(a)
    Dim b
    b = InStrRev(a, ".")
    If b > 0 Then
        getFileExtName = Mid(a, b + 1)
    Else
        getFileExtName = ""
    End If
End Function








Function handleFilePathArray(ByVal a)
    Dim b, c, d, e
    a = HandleFileUrl(a)

    b = Mid(a, 1, InStrRev(a, "\"))
    c = Mid(a, InStrRev(a, "\") + 1)
    If InStrRev(c, ".") > 0 Then
        d = Mid(c, 1, InStrRev(c, ".") - 1)
    Else
        d = ""
    End If
    e = Mid(c, InStrRev(c, ".") + 1)







    handleFilePathArray = Split(a & vbCrLf & b & vbCrLf & c & vbCrLf & d & vbCrLf & e, vbCrLf)

End Function

Function getStrFileName(ByVal a)
    getStrFileName = handleFilePathArray(a)(2)
End Function

function getFileName(byval a)
	getFileName=handleFilePathArray(a)(2)
end function

Function getFileAttr(ByVal a, b)
    getFileAttr = ""
    If b = "0" Then
        getFileAttr = handleFilePathArray(a)(0)
    ElseIf b = "1" Then
        getFileAttr = handleFilePathArray(a)(1)
    ElseIf b = "name" or "2" Then
        getFileAttr = handleFilePathArray(a)(2)
    ElseIf b = "3" Then
        getFileAttr = handleFilePathArray(a)(3)
    ElseIf b = "4" Then
        getFileAttr = handleFilePathArray(a)(4)
    End If
End Function





Function getFileExt(a)
    Dim b : b = Split(a, ".")
    getFileExt = b(UBound(b))
End Function

Function getParentPath(ByVal a)
    a = HandlePath(a)
    getParentPath = ""
    If InStr(a, "\") > 0 Then
        If Right(a, 1) = "\" Then
            a = Left(a, Len(a) - 1)
        End If
        getParentPath = Mid(a, 1, InStrRev(a, "\"))
    End If
End Function
%>




