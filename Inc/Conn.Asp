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
Public MDBPath,AccessPass					
Dim DatabaseType						
Dim SqlServerHostIP  					
Dim SqlServerDatabaseName 				
Dim SqlServerUsername  					
Dim SqlServerPassword 					



Public Sub OpenConn()
	MDBPath = adminDir &"/Data/Data.mdb"
	Dim b
	If Request("MDBPath")<>"" And IsNul(Request("MDBPath"))=False Then
		MDBPath=HandlePath(Request("MDBPath"))
	End If
	
	
	If MDBPath<>"" Then		
    	If Instr(MDBPath, ":") = 0 Then MDBPath = Server.MapPath(Replace(MDBPath, "//", "/"))
		Set Conn = CreateObject("Adodb.Connection")
		Conn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '"& AccessPass &"';Data Source = "& MDBPath
	Else	
		
		If DatabaseType = "SqlServerWebData" Then
			SqlServerDatabaseName = "WebData"
			SqlServerUsername = "sa"
			SqlServerPassword = "sa"
			SqlServerHostIP = ".\SQLEXPRESS"
			
						
		ElseIf DatabaseType = "SqlServerLocalData" Then
			SqlServerDatabaseName = "LocalData"
			SqlServerUsername = "as"
			SqlServerPassword = "as"
			SqlServerHostIP = "127.0.0.1,1433"
			
		ElseIf DatabaseType = "RemoteSqlServer" Then
			
			SqlServerDatabaseName = "qds0140159_db"
			SqlServerUsername = "qds0140159": SqlServerPassword = "L4dN4eRd"
			SqlServerHostIP = "qds-014.hichina.com,1433"
			
		ElseIf DatabaseType = "RemoteSqlServer20150727" Then
			
			SqlServerDatabaseName = "qds157513275_db"
			SqlServerUsername = "qds157513275": SqlServerPassword = "313801120"
			SqlServerHostIP = "qds157513275.my3w.com,1433"
			call echo("","11")

			
		ElseIf SqlServerDatabaseName<>"" Then
			SqlServerHostIP = "127.0.0.1,1433"
			
			
			
		End If
		b = " Password = " & SqlServerPassword & "; user id =" & SqlServerUsername & "; Initial Catalog =" & SqlServerDatabaseName & "; data source =" & SqlServerHostIP & ";Provider = sqloledb;"
		
		Set Conn = CreateObject("Adodb.Connection")
		
		
		Conn.Open b

	End If
	
	
	If TypeName(Rs) <> "Recordset" Then
		Set Rs = CreateObject("Adodb.RecordSet")
		Set Rsx = CreateObject("Adodb.RecordSet")
		Set Rss = CreateObject("Adodb.RecordSet")
		Set Rst = CreateObject("Adodb.Recordset")
		Set Rsd = CreateObject("Adodb.Recordset")
		Set TempRs = CreateObject("Adodb.RecordSet")
		Set TempRs2 = CreateObject("Adodb.RecordSet")
		Set RsTemp = CreateObject("Adodb.RecordSet")	
	End If
End Sub

Function CloseConn()
	On Error Resume Next
    Conn.Close
    Set Conn = Nothing
End Function

Function GetAccessConn(a,b,c)
	b=HandlePath(Request("ThisMDBPath"))
	Set a = CreateObject("Adodb.Connection")
	a.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '"& c &"';Data Source = "& b
	GetAccessConn = a
End Function
%>


