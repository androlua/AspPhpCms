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
Public MDBPath,AccessPass					'���ݿ�·�������� 
Dim DatabaseType						'���ݿ����ͣ�Access��SqlServer֮��
Dim SqlServerHostIP  					'SQL����IP��ַ��������������2008�汾ʹ��
Dim SqlServerDatabaseName 				'SQL���ݿ���
Dim SqlServerUsername  					'SQL���ݿ��û���
Dim SqlServerPassword 					'SQL���ݿ��û����� 
 

'�����ݿ�
Public Sub OpenConn() 
	MDBPath = adminDir &"/Data/Data.mdb" 
	Dim ConnStr 
	If Request("MDBPath")<>"" And IsNul(Request("MDBPath"))=False Then
		MDBPath=HandlePath(Request("MDBPath"))
	End If
	
	'����MMD���ݿ�
	If MDBPath<>"" Then		
    	If Instr(MDBPath, ":") = 0 Then MDBPath = Server.MapPath(Replace(MDBPath, "//", "/")) 
		Set Conn = CreateObject("Adodb.Connection") 
		Conn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '"& AccessPass &"';Data Source = "& MDBPath
	Else	
		'SqlServerDatabaseName,SqlServerUsername,SqlServerPassword,SqlServerHostIP
		If DatabaseType = "SqlServerWebData" Then
			SqlServerDatabaseName = "WebData" 'SQL���ݿ���
			SqlServerUsername = "sa" 'SQL���ݿ��û���
			SqlServerPassword = "sa" 'SQL���ݿ��û�����
			SqlServerHostIP = ".\SQLEXPRESS" 'SQL����IP��ַ��������������2008�汾ʹ�� 
			'call eerr("","����")
						
		ElseIf DatabaseType = "SqlServerLocalData" Then
			SqlServerDatabaseName = "LocalData" 'SQL���ݿ���
			SqlServerUsername = "as" 'SQL���ݿ��û���
			SqlServerPassword = "as" 'SQL���ݿ��û�����
			SqlServerHostIP = "127.0.0.1,1433" 'SQL����IP��ַ��������������2008�汾ʹ��
			
		ElseIf DatabaseType = "RemoteSqlServer" Then
			'Զ��SqlServer���ݿ�
			SqlServerDatabaseName = "qds0140159_db"
			SqlServerUsername = "qds0140159": SqlServerPassword = "L4dN4eRd"
			SqlServerHostIP = "qds-014.hichina.com,1433"
			
		ElseIf DatabaseType = "RemoteSqlServer20150727" Then
			'Զ��SqlServer���ݿ�
			SqlServerDatabaseName = "qds157513275_db"
			SqlServerUsername = "qds157513275": SqlServerPassword = "313801120"
			SqlServerHostIP = "qds157513275.my3w.com,1433"
			call echo("","11")

			
		ElseIf SqlServerDatabaseName<>"" Then 
			SqlServerHostIP = "127.0.0.1,1433" 'SQL����IP��ַ��������������2008�汾ʹ�� 
			'SqlServerHostIP ="(local),1433"  '������
			
			
		End If 
		ConnStr = " Password = " & SqlServerPassword & "; user id =" & SqlServerUsername & "; Initial Catalog =" & SqlServerDatabaseName & "; data source =" & SqlServerHostIP & ";Provider = sqloledb;"
		'Call Echo("ConnStr", ConnStr):Doevents
		Set Conn = CreateObject("Adodb.Connection")
		 
		
		Conn.Open ConnStr 

	End If
	 
	'�Ӹ��ж�Ŀ����Ϊ���ظ����ã�����ʱ����� ��GetRecordCount(Table, AddSql)   20150313
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
'�ر����ݿ�
Function CloseConn()
	On Error Resume Next
    Conn.Close
    Set Conn = Nothing
End Function
'������ݿ���  ThisConn=GetAccessConn(ThisConn,ThisMDBPath,"")
Function GetAccessConn(AccessConn,ThisMDBPath,ThisAccessPass)
	ThisMDBPath=HandlePath(Request("ThisMDBPath"))
	Set AccessConn = CreateObject("Adodb.Connection")
	AccessConn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '"& ThisAccessPass &"';Data Source = "& ThisMDBPath
	GetAccessConn = AccessConn
End Function
%>