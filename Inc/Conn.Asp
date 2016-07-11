<% 
Public MDBPath, accessPass                                     '数据库路径与密码
Dim databaseType                                               '数据库类型，Access与SqlServer之分
Dim sqlServerHostIP                                            'SQL主机IP地址（服务器名）在2008版本使用
Dim sqlServerDatabaseName                                      'SQL数据库名
Dim sqlServerUsername                                          'SQL数据库用户名
Dim sqlServerPassword                                          'SQL数据库用户密码


'打开数据库
Public Sub openConn()
    Dim connStr 
    If Request("MDBPath") <> "" And isNul(Request("MDBPath")) = False Then
        MDBPath = handlePath(Request("MDBPath")) 
    End If 
    'call eerr("",MDBPath)
    '连接MMD数据库
    If MDBPath <> "" Then
        If InStr(MDBPath, ":") = 0 Then MDBPath = Server.MapPath(Replace(MDBPath, "//", "/")) 
        Set conn = CreateObject("Adodb.Connection")
            conn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & accessPass & "';Data Source = " & MDBPath 
    Else
        'SqlServerDatabaseName,SqlServerUsername,SqlServerPassword,SqlServerHostIP
        If databaseType = "SqlServerWebData" Then
            sqlServerDatabaseName = "WebData"                                               'SQL数据库名
            sqlServerUsername = "sa"                                                        'SQL数据库用户名
            sqlServerPassword = "sa"                                                        'SQL数据库用户密码
            sqlServerHostIP = ".\SQLEXPRESS"                                                'SQL主机IP地址（服务器名）在2008版本使用
            'call eerr("","是我")

        ElseIf databaseType = "SqlServerLocalData" Then
            sqlServerDatabaseName = "LocalData"                                             'SQL数据库名
            sqlServerUsername = "as"                                                        'SQL数据库用户名
            sqlServerPassword = "as"                                                        'SQL数据库用户密码
            sqlServerHostIP = "127.0.0.1,1433"                                              'SQL主机IP地址（服务器名）在2008版本使用

        ElseIf databaseType = "RemoteSqlServer" Then
            '远程SqlServer数据库
            sqlServerDatabaseName = "qds0140159_db" 
            sqlServerUsername = "qds0140159" : sqlServerPassword = "L4dN4eRd" 
            sqlServerHostIP = "qds-014.hichina.com,1433" 

        ElseIf databaseType = "RemoteSqlServer20150727" Then
            '远程SqlServer数据库
            sqlServerDatabaseName = "qds157513275_db" 
            sqlServerUsername = "qds157513275" : sqlServerPassword = "313801120" 
            sqlServerHostIP = "qds157513275.my3w.com,1433" 
            Call echo("", "11") 


        ElseIf sqlServerDatabaseName <> "" Then
            sqlServerHostIP = "127.0.0.1,1433"                                              'SQL主机IP地址（服务器名）在2008版本使用
            'SqlServerHostIP ="(local),1433"  '不可以

        End If 
        connStr = " Password = " & sqlServerPassword & "; user id =" & sqlServerUsername & "; Initial Catalog =" & sqlServerDatabaseName & "; data source =" & sqlServerHostIP & ";Provider = sqloledb;" 
        'Call Echo("ConnStr", ConnStr):Doevents
        Set conn = CreateObject("Adodb.Connection")


            conn.Open connStr 

    End If

    '加个判断目的是为了重复设置，调用时会出错 如GetRecordCount(Table, AddSql)   20150313
    If TypeName(rs) <> "Recordset" Then
		Set rs = CreateObject("Adodb.RecordSet")
		Set rsx = CreateObject("Adodb.RecordSet")
		Set rss = CreateObject("Adodb.RecordSet")
		Set rst = CreateObject("Adodb.RecordSet")
		Set rsd = CreateObject("Adodb.RecordSet")
		Set tempRs = CreateObject("Adodb.RecordSet")
		Set tempRs2 = CreateObject("Adodb.RecordSet")
		Set rsTemp = CreateObject("Adodb.RecordSet")
    End If
End Sub 
'关闭数据库
Function closeConn()
    On Error Resume Next 
    conn.Close 
    Set conn = Nothing 
End Function 
'获得数据库句柄  ThisConn=GetAccessConn(ThisConn,ThisMDBPath,"")
Function getAccessConn(accessConn, thisMDBPath, thisAccessPass)
    thisMDBPath = handlePath(Request("ThisMDBPath")) 
    Set accessConn = CreateObject("Adodb.Connection")
        accessConn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & thisAccessPass & "';Data Source = " & thisMDBPath 
        getAccessConn = accessConn 
End Function
%> 

