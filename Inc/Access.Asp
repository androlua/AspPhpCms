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










Function handleAccessData(ByVal a)
    handleAccessData = Replace(a, "'", "''")
End Function

Function aDSql(a)
    aDSql = handleAccessData(a)
End Function

Function checkAccessPass(a, b)
    On Error Resume Next
    Dim c
    checkAccessPass = True
    Set c = CreateObject("Adodb.Connection")
        c.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & b & "';Data Source = " & a
        c.Close
        If Err <> 0 Then
            Err.Clsoe
            checkAccessPass = False
        End If
End Function

Function checkSql(a)
    On Error Resume Next
    conn.Execute(a)
    checkSql = IIF(Err = 0, True, False)
End Function

Function createTable(a)
    Dim b
    If checkSql(a) = False Then
        b = "Create Table " & a & " (Id int Identity(0,1) Primary Key)"
        conn.Execute(b)
        createTable = True
    Else
        createTable = False
    End If
End Function

Function showIsTable(a)
    showIsTable = ExistsTable(a)
    If showIsTable = False Then
        Call rw("创建表[" & a & "]成功√<br>")
    Else
        Call rw("表[" & a & "]已经存在<br>")
    End If
End Function

Function getRecordCount(a, b)

    Call OpenConn()
    getRecordCount = conn.Execute("Select Count(*) From [" & a & "] " & b)(0)
End Function
Function tableCount(a, b)
    tableCount = getRecordCount(a, b)
End Function

Function openTable(a, b)
    rs.Open "Select * From [" & a & "] " & b, conn, 1, 1
End Function

Function insertTable(a, b, c)
    conn.Execute("Insert Into[" & a & "](" & b & ") Values('" & c & "')")
End Function

Function getTableText(a, b, c)
    On Error Resume Next
    getTableText = conn.Execute("Select " & b & " From [" & a & "]" & c)(0)
    If Err.Number <> 0 Then Call eerr("出错了", a & "-" & b & "-" & c)
End Function

Function createMdb(a)
    Dim b
    Set b = CreateObject("ADOX.Catalog")
        b.create("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & a)
        Call rw("创建数据库[" & a & "]成功√<br>" & vbCrLf)
    Set b = Nothing
End Function

Function deleteTable(a)
    a = Trim(a)
    deleteTable = False
    If a = "" Then
        Exit Function
    End If
    If CheckTable(a) Then
        deleteTable = True
    End If


End Function

Function deleteAllTable(a)
    Dim b, c, d
    b = Split(a, vbCrLf)
    For Each c In b
        If d <> "" Then d = d & vbCrLf
        d = d & "删除表【" & c & "】" & deleteTable(c)
    Next
    deleteAllTable = d
End Function


Function checkTable(a)
    On Error Resume Next
    conn.Execute("Select * From [" & a & "]")
    If Not Err.Number = 0 Then
        Err.Clear
        checkTable = False
    Else
        checkTable = True
    End If
End Function

Function existsTable(a)
    existsTable = checkTable(a)
End Function

Function editTable(a, b, c)
    Dim d, e, f
    editTable = False
    If checkTable(b) And checkTable(c) = False Then
        d = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & a
        Set e = CreateObject("ADOX.Catalog")
            e.ActiveConnection = d
            Set f = CreateObject("ADOX.Table")
                Set f = e.Tables(b)
                    f.Name = c
                Set e = Nothing
            Set f = Nothing
            editTable = True
        Set e = Nothing
    End If
End Function

Function checkField(a, b)
    checkField = False
    If checkTable(a) Then
        On Error Resume Next
        conn.Execute("Select " & b & " From [" & a & "]")
        If Not Err.Number = 0 Then
            Err.Clear
            checkField = False
        Else
            checkField = True
        End If
        Err.Clear
    End If
End Function

Function existsField(a, b)
    existsField = checkField(a, b)
End Function

Function editField(a, b, c)

    Dim d
    editField = False
    If checkTable(a) Then
        If checkField(a, c) = False And checkField(a, b) Then
            d = GetFieldAlt(a, b)
            If d <> "" Then

                conn.Execute("Alter Table [" & a & "] Add [" & c & "] " & d & "")
                conn.Execute("Update [" & a & "] Set " & c & "=[" & b & "]")
                conn.Execute("Alter Table [" & a & "] Drop [" & b & "]")
            End If
            If Err.Number <> 0 Then MsgBox(a & vbCrLf & b & vbCrLf & c & "类型" & d)
        End If
    End If
End Function

Function getFieldAlt(a, b)
    Dim c, d, e, f
    Set f = CreateObject("Adodb.RecordSet")
        f.Open "Select * From [" & a & "]", conn, 1, 1
        d = f.Fields.Count
        For c = 1 To d - 1
            Set e = f.Fields.Item(c)
                If b = e.Name Then

                    Select Case f.Fields(c).Type
                        Case "202"
                            getFieldAlt = "VarChar"
                        Case "203"
                            getFieldAlt = "Text"
                        Case "7"
                            getFieldAlt = "DateTime"
                        Case "3"
                            getFieldAlt = "Int"
                        Case "11"
                            getFieldAlt = "YesNo"
                        Case Else
                            MsgBox(f.Fields(c).Type & vbCrLf & Table & "没有类型")
                            getFieldAlt = "没类型" & f.Fields(c).Type
                    End Select
                    Exit For
                End If
            Set e = Nothing
        Next : f.Close
End Function

Function getTableList_Conn(a)
    Dim b, c
    Set rs = a.OpenSchema(20)
        rs.MoveFirst
        Do Until rs.EOF
            If rs("TABLE_TYPE") = "TABLE" Then
                b = rs("TABLE_NAME")
                If c <> "" Then c = c & vbCrLf
                c = c & b
            End If
            rs.MoveNext
        Loop
        getTableList_Conn = c
End Function

Function getTableList()
    getTableList = getTableList_Conn(conn)
End Function

Function getFieldList(a)
    Dim b, c, d, e
    On Error Resume Next

    tempRs.Open "Select * From [" & a & "]", conn, 1, 1
    If tempRs.Fields.Count = 0 Then Exit Function
    b = tempRs.Fields.Count
    If Err <> 0 Then Call eerr("字段", tempRs.Fields.Count)
    c = ","
    For e = 1 To b - 1
        Set d = tempRs.Fields.Item(e)
            c = c & d.Name & ","
        Set d = Nothing
    Next : tempRs.Close
    getFieldList = c
End Function

Function getDifferentTableFieldList(a, b)
    Dim c, d, e, f

    If TypeName(a) = "Connection" Then
        Set conn = CreateObject("Adodb.Connection")
            conn.Open(a)
    End If

    rs.Open "Select * From [" & b & "]", conn, 1, 1
    c = rs.Fields.Count
    d = ","
    For f = 1 To c - 1
        Set e = rs.Fields.Item(f)
            d = d & e.Name & ","
        Set e = Nothing
    Next : rs.Close
    getDifferentTableFieldList = d
End Function



Function compactDB(a, b)
    Dim c, d, e, f
    e = Left(a, InStrRev(a, "\"))
    Set c = CreateObject("Scripting.FileSystemObject")
        If c.fileExists(a) Then
            c.CopyFile a, e & "temp.mdb"
            Set d = CreateObject("JRO.JetEngine")
                If b = True Then
                    d.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp.mdb", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp1.mdb;" & "Jet OLEDB:Engine Type=" & f
                Else
                    d.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp.mdb", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp1.mdb"
                End If
                c.CopyFile e & "temp1.mdb", a
                c.deleteFile(e & "temp.mdb")
                c.deleteFile(e & "temp1.mdb")
            Set d = Nothing
            compactDB = "<font color=#FF0000><b>你的数据库, " & a & ", 已经压缩成功!</b></font>" & vbCrLf
        Else
            compactDB = "<font color=#FF0000><b>数据库名称或路径不正确. 请重试!</b></font>" & vbCrLf
        End If
    Set c = Nothing
End Function

Function editAccessPassWord(a, b, c)
    Dim d, e
    Set e = CreateObject("JRO.JetEngine")
        Call HandlePath(a)
        d = "Test_News.Mdb"
        Call HandlePath(d)
        Call deleteFile(d)
        On Error Resume Next
        e.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & a & ";Jet OLEDB:Database Password=" & b, "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & d & ";Jet OLEDB:Database Password=" & c
        If Err.Number <> 0 Then editAccessPassWord = "密码错误" : Err.Clear : Exit Function
        Call deleteFile(a)
        Call MoveFile(d, a)
        editAccessPassWord = "修改成功，新密码为[" & c & "]"
    Set e = Nothing
End Function


Function handleSqlServer(ByVal a)
    Dim b, c, d, e, f, g
    g = Split(a, ",")
    For Each a In g

        a = Replace(a, """""", "''")
        a = Replace(a, "''''", "''")
        a = Replace(a, "Date()", "GetDate()")
        a = Replace(a, "Now()", "GetDate()")




        a = Replace(a, "YesNo Default Yes", " Bit Default 'true'")
        a = Replace(a, "YesNo Default No", " Bit Default 'false'")
        a = Replace(a, " YesNo", "  Bit Default 'true'")
        If InStr(a, "YesNo") > 0 Then
            Call eerr("Content", a)
        End If
        For b = 1 To Len(a)
            c = Mid(a, b, 1)
            If c = " " Then
                d = LCase(Mid(a, b + 1, 7))
                e = LCase(Mid(a, b + 1, 8))
                If d = "varchar" And e <> "varchar(" Then
                    f = f & " VarChar(255)"
                    b = b + 7
                Else
                    f = f & c
                End If
            Else
                f = f & c
            End If
        Next
        f = f & ","
    Next
    If f <> "" Then f = Left(f, Len(f) - 1)
    handleSqlServer = f
End Function





Sub exportToExcel(a)
    Response.ContentType = "application/vnd.ms-Excel"
    Response.AddHeader "Content-Disposition", "attachment;Filename=Results.xls"
    Response.Write("<body>") & vbCrLf
    Response.Write(a) & vbCrLf
    Response.Write("</body>") & vbCrLf
    Response.Write("</html>") & vbCrLf
End Sub

Sub importToDatabase()

    Dim b, c, d
    b = Server.MapPath("1.xls")
    Set c = CreateObject("Adodb.Connection")
        c.Open "Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=Excel 8.0;Data Source=" & b
        Set d = CreateObject("Adodb.RecordSet")

            Dim e, f, g
            e = Server.MapPath(""& adminDir &"Data/Data.mdb")
            Set f = CreateObject("Adodb.Connection")
                f.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & e
                Set g = CreateObject("Adodb.RecordSet")


                    Dim h, i, j, k
                    d.Open "Select * From [Excel$]", c, 1, 1
                    h = d.Fields.Count
                    For i = 1 To h - 1
                        Set j = d.Fields.Item(i)
                            k = k & j.Name & ","
                        Set j = Nothing
                    Next : d.Close
                    Call echo("xlsFieldList", k)

                    Dim l, m
                    l = Split(k, ",")
                    d.Open "Select * From [Excel$]", c, 1, 1
                    Call echo("xls里数据有", d.RecordCount)

                    While Not d.EOF
                        g.Open "Select * From [Product]", f, 1, 3
                        g.AddNew
                        For Each m In l
                            m = Trim(m)
                            If m <> "" Then
                                Call echo("显示字段", m)
                                Doevents
                                g(m) = d(m)
                            End If
                        Next
                        Call echo("添加记录", "")

                        g.Update : g.Close
                    d.MoveNext : Wend : d.Close
End Sub

Function getDataTableList(a, b)
    Dim c, d, e, f, g
    f = f & "<table width=""100%"" border=""1"" cellspacing=""0"" cellpadding=""0"">" & vbCrLf

    c = getFieldList(a)

    d = Split(c, ",")
    f = f & "  <tr>" & vbCrLf
    For e = 1 To UBound(d) - 1
        f = f & "    <td>" & d(e) & "</td>" & vbCrLf
    Next
    f = f & "  </tr>" & vbCrLf

    rs.Open "Select * From [" & a & "] " & b, conn, 1, 1
    While Not rs.EOF
        f = f & "  <tr>" & vbCrLf
        For Each g In d
            If g <> "" Then
                f = f & "    <td>" & rs(g) & "</td>" & vbCrLf
            End If
        Next
        f = f & "  </tr>" & vbCrLf
    rs.MoveNext : Wend : rs.Close
    f = f & "</table>" & vbCrLf
    getDataTableList = f
End Function

Function setTableField(a, b)
    Dim c, d, e, f, g, h, i, j
    c = Split(b, "|")
    For e = 0 To UBound(c)
        f = c(e)
        If f <> "" Then
            d = Split(f, ",")
            h = d(0)
            i = d(1)
            On Error Resume Next
            j = "alter table " & h & " add column " & i & " " & d(2) & ""
            a.Execute j
            If Err.Number = 0 Then
                g = g & "[表" & h & "]【字段" & i & "】添加新字段成功<hr>" & vbCrLf
            Else
                Err.Close
                g = g & "[表" & h & "]【字段" & i & "】添加失败<hr>" & vbCrLf
            End If
        End If
    Next
    setTableField = g
End Function


Function getTypeString(a)
    Select Case a
        Case 0 : getTypeString = "Empty"
        Case 16 : getTypeString = "TinyInt"
        Case 2 : getTypeString = "SmallInt"
        Case 3 : getTypeString = "Int"
        Case 20 : getTypeString = "BigInt"
        Case 17 : getTypeString = "UnsignedTinyInt"
        Case 18 : getTypeString = "UnsignedSmallInt"
        Case 19 : getTypeString = "UnsignedInt"
        Case 21 : getTypeString = "UnsignedBigInt"
        Case 4 : getTypeString = "Single"
        Case 5 : getTypeString = "Double"
        Case 6 : getTypeString = "Currency"
        Case 14 : getTypeString = "Decimal"
        Case 131 : getTypeString = "Numeric"
        Case 11 : getTypeString = "Bit"
        Case 10 : getTypeString = "Error"
        Case 132 : getTypeString = "UserDefined"
        Case 12 : getTypeString = "Variant"
        Case 9 : getTypeString = "IDispatch"
        Case 13 : getTypeString = "IUnknown"
        Case 72 : getTypeString = "GUID"
        Case 7 : getTypeString = "Date"
        Case 133 : getTypeString = "DBDate"
        Case 134 : getTypeString = "DBTime"
        Case 135 : getTypeString = "Datetime"
        Case 8 : getTypeString = "BSTR"
        Case 129 : getTypeString = "Char"
        Case 200 : getTypeString = "VarChar"
        Case 201 : getTypeString = "LongVarChar"
        Case 130 : getTypeString = "WChar"
        Case 202 : getTypeString = "Text"
        Case 203 : getTypeString = "Memo"
        Case 128 : getTypeString = "Binary"
        Case 204 : getTypeString = "VarBinary"
        Case 205 : getTypeString = "LongVarBinary"
        Case Else : getTypeString = "Unknown Type"
    End Select
End Function

Function getProductRndIdList(a, b)
    Dim c, d, e, f, g, h, i, j

    c = a.RecordCount
    b = CInt(b)
    h = 0
    Randomize Timer

    For e = 1 To 3
        For d = 1 To c
            i = Int(Rnd * c + 1)
            If InStr("," & f & ",", "," & i & ",") = False Then
                f = f & i & ","
                h = h + 1
                If h >= b Then

                    Exit For
                End If
            End If
        Next
        If h >= b Then Exit For
    Next

    j = Split(f, ",")
    For d = 1 To c
        If InStr("," & f & ",", "," & d & ",") > 0 Then
            g = g & a(0) & ","
        End If
    a.MoveNext : Next
    If g <> "" Then g = Left(g, Len(g) - 1)
    getProductRndIdList = g

End Function

Function getFieldValue(a, b, c)
    Dim d
    Call OpenConn()
    Set d = CreateObject("Adodb.RecordSet")
        d.Open "Select * From [" & a & "] " & c, conn, 1, 1
        If Not d.EOF Then
            getFieldValue = d(b)
        End If : d.Close
End Function

Function getConnFieldValue(a, b, c, d)
    On Error Resume Next
    Dim e
    Set e = CreateObject("Adodb.RecordSet")
        e.Open "Select * From [" & b & "] " & d, a, 1, 1
        If Not e.EOF Then

            getConnFieldValue = e(c)
        End If : e.Close
        If Err <> 0 Then Call eerr(b, c)
End Function

Function setFieldValue(a, b, c, d)
    Dim e
    Call OpenConn()
    setFieldValue = False
    Set e = CreateObject("Adodb.RecordSet")
        e.Open "Select * From [" & a & "] " & d, conn, 1, 3
        If Not e.EOF Then
            e(b) = c
            e.Update
            setFieldValue = True
        End If : e.Close
End Function


Function fileBinaryAddAccess(a, b, c, d, e, f)
    Dim g, h
    Set h = CreateObject("Adodb.RecordSet")
        g = "Select " & c & " From [" & b & "]"
        g = getWhereAnd(g, e)
        If d <> "" Then
            g = getWhereAnd(g, "Where Id=" & d)
        End If
        h.Open g, a, 1, 3
        If Not h.EOF Then
            h(c).AppendChunk GetFileBinaryContent(f)

            h.Update
        End If : h.Close
End Function

Function showAccessStream(a, b, c, d, e)
    Dim f, g
    Set g = CreateObject("Adodb.RecordSet")
        f = "Select " & c & " From [" & b & "]"
        f = getWhereAnd(f, e)
        If d <> "" Then
            f = getWhereAnd(f, "Where Id=" & d)
        End If
        g.Open f, a, 1, 3
        If Not g.EOF Then

            Response.BinaryWrite g(c).GetChunk(7500000)
        End If : g.Close
End Function
%>







