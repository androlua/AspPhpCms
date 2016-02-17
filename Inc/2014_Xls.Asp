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



Function BatchImportXlsFile(a,b)
	Dim c,d,e,f,g,h,i,j,k,l,m,n,o
	Dim p,q,r
	
	q =  GetFileFolderList(a, True, "xls", "", "", "", "")
	r = Split(q,vbCrlf)
	For Each p In r
		g="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& p &";Extended Properties='Excel 8.0;HDR=No;IMEX=1';"
		Call CloseConn()
		set conn=server.createobject("adodb.connection")
		Set Rs = CreateObject("Adodb.RecordSet")
		Set Rsx = CreateObject("Adodb.RecordSet")
		Set Rss = CreateObject("Adodb.RecordSet")
		Set Rst = CreateObject("Adodb.Recordset")
		Set Rsd = CreateObject("Adodb.Recordset")
		Set TempRs = CreateObject("Adodb.RecordSet")
		Set TempRs2 = CreateObject("Adodb.RecordSet")
		Set RsTemp = CreateObject("Adodb.RecordSet")	
		
		Conn.Open  g
		
		h = GetTableList_Conn(Conn)
		i = Split(h,vbCrlf)
		For Each j IN i
			If j<>"" Then
				k = GetFieldList(j)
				l = Split(k,",")
				If Ubound(l)<>-1 Then
					
					
					Rsx.Open"Select * From ["& j &"]",Conn,1,1
					
					While Not Rsx.Eof
						c=0
						For Each m In l
							If m <>"" Then
								o = Rsx(c)
								
								If CheckUrl(o) = True And InStr(vbCrlf & n & vbCrlf, vbCrlf & o & vbCrlf)=False Then
									n = n & o & vbCrlf
									Call Echo(j,o):Doevents
								End If
								c=c+1
							End If
						Next
					Rsx.MoveNext:Wend:Rsx.Close
				End If
			End If
		Next
	Next
	n=CStr(n)
	Call Echo("UrlList",n)
	Call WriteToFile(b,n,1)
	
End Function
%>

