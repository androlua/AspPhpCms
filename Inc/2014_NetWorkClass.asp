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


Class NetWorkClass
	
	Dim MDBPath, DatabaseType
	Dim Conn
	Dim Rs
	Dim Rss
	Dim Rst
	Dim Rsx
	Dim Rsd
	Dim TempRs
	Dim RsTemp
	Dim SplSpecialUrl
	Dim CacheDir
	
	dim WebSite							
	dim SourceUrlList					
	dim CleanUrlList					
	dim IdenticalUrlList				
	dim DifferentUrlList				
	dim DifferentParameterUrlList		
	dim SqlInUrlList					
	dim WebState						
	dim WebFileSize						
	dim pubHttpUrl						
	dim pubWebTitle						
	dim pubWebSite						
	dim isReadCacheFile					
	dim Depth							
	

	
	Function GetHttpUrlContentUrlList(ByVal a,b,c,d,e)
		Dim f,g,h,i
		a = HandleUrlComplete(a)

		a = HandleSpecialUrl(a)
		a = HandleInvalidUrl(a)
		a = RemoveNonWebpage(a)
 	
		if a<>"" then
			if c<>"" then
				WebSite = c		
			else
				WebSite=getWebSite(a)
			end if
			
			
			if isReadCacheFile=true then			
				h = CacheDir & setFileName(getWebSite(a)) & "/"
				call createFolder(h)
				i = h & setFileName(a)
				
				if checkfile(i)=true then
					g=split(getFText(i & ".txt"),vbCrlf)
					g(0) = getFText(i)
					d = g(2)											
					e = g(3)											
				end if
			end if
			if IsEmpty(g) then
				g = handleXmlGet(a, b)
					call echo(a,i):doevents							
					call createFile(i, g(0))
					call createFile(i & ".txt", vbcrlf & g(1) & vbcrlf & d & vbcrlf & e )
			end if
			f = g(0)												
			WebState = g(1)											
			WebFileSize = stringLength(f)								
			pubHttpUrl=a													
			pubWebTitle = RegExpGetStr("<TITLE>([^<>]*)</TITLE>", f, 1)	
			pubWebSite = getWebSite(a)									
			
			
			if 1=2 then
			f = GetContentAHref(a, f)
			else
			f = GetAUrlTitleList(f,"")                         		
			f = batchFullHttpUrl(WebSite,f)							
			
			end if
			
			
			
			SourceUrlList = f		
			f = HandleSpecialUrl(f)
			f = HandleInvalidUrl(f)
			f = RemoveNonWebpage(f)
			f = RemoveWidthUrl(f)                                 	
			
			
			CleanUrlList = f		
			
			IdenticalUrlList = GetIdenticalWebSiteUrlList(WebSite,f)		
			DifferentUrlList = GetDifferentWebSiteUrlList(WebSite,f)		
			
			
			
		end if
 	end function
	

    Public Property Get getSourceUrlList()
        getSourceUrlList = SourceUrlList
    End Property

    Public Property Get getCleanUrlList()
        getCleanUrlList = CleanUrlList
    End Property

    Public Property Get getIdenticalUrlList()
        getIdenticalUrlList = IdenticalUrlList
    End Property

    Public Property Get getDifferentUrlList()
        getDifferentUrlList = DifferentUrlList
    End Property

    Public Property Get getDifferentParameterUrlList()
        getDifferentParameterUrlList = handleDifferentParameterUrlList(IdenticalUrlList)
    End Property

    Public Property Get getSqlInUrlList()
        getSqlInUrlList = handleSqlInUrlList(IdenticalUrlList)
    End Property

    Public Property Get getWebState()
        getWebState =WebState
    End Property

    Public Property Get getWebFileSize()
        getWebFileSize =WebFileSize
    End Property
	
	Public Property Let setisReadCacheFile(Str)
		isReadCacheFile = Str
	End Property
	
	
	function handleFullHttpUrl(a,b)						
		dim c,d,e,f,g,h
		a=getWebSite(a)
		c = Split(b, vbCrLf)
		b=""
		For Each f In c
			if instr(f,"$Array$")>0 then
				h=split(f,"$Array$")
				d=h(0)
				e=h(1)
			else
				d = f
				e=""
			end if
			d = FullHttpUrl(a,d)
			if instr(vbcrlf & b & vbCrlf, vbcrlf & d & vbCrlf)=false then
				b=b & d & vbcrlf
				if g<>"" then g=g & vbCrlf
				g=g & d & "$Array$" & e
			end if
		next
		handleFullHttpUrl = g
	end function
		
	
	public function getSearchUrl(a,b)
		dim c,d,e,f
		c = Split(a, vbCrLf)
		For Each d In c
			if instr(vbcrlf & e & vbcrlf, vbcrlf & d & vbcrlf)=false and instr(d,b)>0  then
				if e<>"" then e=e & vbCrlf
				e=e & d
			end if
		next
		getSearchUrl=e
	end function		                            	
	
	function RemoveWidthUrl(a)
		dim b,c,d,e
		b = Split(a, vbCrLf)
		For Each c In b
			e=false
			if instr(vbcrlf & d & vbcrlf, vbcrlf & c & vbcrlf)=false  then
				e=true
				if right(c,1)<>"/" then
					if instr(vbcrlf & d & vbcrlf, vbcrlf & c & "/" & vbcrlf)>0  then
						e=false
					end if
				end if
				if e=true then
					
					if d<>"" then d=d & vbCrlf
					d=d & c
				end if
			end if
		next
		RemoveWidthUrl=d
	end function	
	
	function handleSqlInUrlList(a)
		dim b,c,d,e
		b = Split(a, vbCrLf)
		a=""
		For Each c In b
			d=remoteHttpUrlParameter(c)
			
			if instr(d,"?")>0 and instr(vbcrlf & a & vbcrlf, vbcrlf & d & vbcrlf)=false then				
				a=a & d & vbCrlf
				if e<>"" then e=e & vbCrlf
				e=e & c
			end if
		next
		handleSqlInUrlList=e
	end function	
	
	function handleDifferentParameterUrlList(a)
		dim b,c,d,e
		b = Split(a, vbCrLf)
		a=""
		For Each c In b
			d=remoteHttpUrlParameter(c)
			
			if len(d)>3 and instr(vbcrlf & a & vbcrlf, vbcrlf & d & vbcrlf)=false then				
				a=a & d & vbCrlf
				if e<>"" then e=e & vbCrlf
				e=e & c
			end if
		next
		handleDifferentParameterUrlList=e
	end function	
	
	Function HandleSpecialUrl(a)
		Dim b, c, d, e, f
		d = Split(a, vbCrLf)
		a=""			
		For Each e In d
			f = True
			For Each c In SplSpecialUrl
				If c <> "" And Left(c, 1) <> "#" Then
					If InStr(e, c) > 0 Then f = False: Exit For
				End If
			Next
			If f = True Then
				if a<>"" then
					a=a & vbCrlf
				end if
				a = a & HandleHttpUrl(e)
			End If
		Next
		HandleSpecialUrl = a
	End Function
	
	Function HandleInvalidUrl(a)
		Dim b, c, d, e
		b = Split(a, vbCrLf)
		a=""
		For Each c In b
			c = HandleHttpUrl(c)
			d = Mid(c, InStrRev(c, "/") + 1)
			e = True
			
			
			If e = True Then
				e = len(c)>3
			End If
			
			If e = True Then
				e = Left(d, 1) <> "#"
			End If
			
			If e = True Then
				e = InStr(vbCrLf & a & vbCrLf, vbCrLf & c & vbCrLf) = False
			End If
			
			If e = True Then
				e = Left(LCase(d), 11) <> "javascript:"
			End If
			
			If e = True Then
				If InStr(LCase(c), "javascript:") > 0 Or InStr(LCase(c), "'") > 0 Then
					e = False
				End If
			End If
			
			
			If e = True Then
				if a<>"" then
					a=a & vbCrlf
				end if
				a = a & c
			End If
		Next
		HandleInvalidUrl = a
	End Function
	
	Function RemoveNonWebpage(a)
		Dim b, c, d, e, f, g, h
		b = Split(a, vbCrLf)
		For Each c In b
			c = Trim(c)
			h = True
			If c <> "" Then
				c = HandleHttpUrl(c)
				d = LCase(c)
				f = Mid(d, InStrRev(d, "/") + 1)
				
				If InStr(f, "?") Then
					f = Mid(f, 1, InStr(f, "?") - 1)
				End If
				If InStr(f, ".") > 0 Then
					g = Mid(f, InStrRev(f, ".") + 1)
					If InStr("|jpg|gif|png|bmp|zip|rar|js|xml|doc|pdf|ppt|xlsx|xls|exe|txt|", "|" & g & "|") > 0 Then
						h = False
					End If
				End If
			End If
			If h = True Then
				If InStr(vbCrLf & e & vbCrLf, vbCrLf & c & vbCrLf) = False Then
					if e<>"" then
						e=e & vbCrlf
					end if
					e = e & c
				End If
			End If
		Next
		RemoveNonWebpage = e
	End Function
	
	Function GetIdenticalWebSiteUrlList(ByVal a, ByVal b)
		GetIdenticalWebSiteUrlList = GetIdenticalOrDifferentWebSite(a, b, "identica")
	End Function
	
	Function GetDifferentWebSiteUrlList(ByVal a, ByVal b)
		GetDifferentWebSiteUrlList = GetIdenticalOrDifferentWebSite(a, b, "different")
	End Function
	
	Function GetIdenticalOrDifferentWebSite(ByVal a, ByVal b, c)
		Dim d, e, f, g, h
		c = LCase(c)

		d = Split(b, vbCrLf)
		b=""
		For Each e In d
			e = Trim(e)
			g = LCase(GetWebSite(e))
			h = False
			if c = "identica" Or c = "1" then
				If g = a Or instr(g,a)>0 then
					h=true
				end if
			else
				If g <> a  and instr(g,a)=false then
					
					h=true
				end if
			end if
			
			If h = True Then
				If InStr(vbCrLf & b & vbCrLf, vbCrLf & e & vbCrLf) = False Then
					if b<>"" then
						b=b & vbCrlf
					end if
					b = b & e
				End If
			End If
		Next
		GetIdenticalOrDifferentWebSite = b
	End Function	
	
	
	
	
	
	Private Sub Class_Initialize()
		SplSpecialUrl = Split(GetFText("\VB工程\Config\不处理域名列表.ini"), vbCrLf)
		
		CacheDir = "E:\E盘\WEB网站\网站UrlScan\"
		DatabaseType = "Access"
		isReadCacheFile=true										
		if checkFolder(CacheDir)=false then
			call eerr("缓存目录路径不存在", cacheDir)
		end if

		Set Rs = CreateObject("Adodb.RecordSet")
		Set Rsx = CreateObject("Adodb.RecordSet")
		Set Rss = CreateObject("Adodb.RecordSet")
		Set Rst = CreateObject("Adodb.Recordset")
		Set Rsd = CreateObject("Adodb.Recordset")
		Set TempRs = CreateObject("Adodb.RecordSet")
		Set TempRs2 = CreateObject("Adodb.RecordSet")
		Set RsTemp = CreateObject("Adodb.RecordSet")	
		
	End Sub
	
	Private Sub Class_Terminate()
		
	End Sub
	
	Public Property Let SetCacheDir(FolderPath)
		CacheDir = FolderPath
	End Property
	
	Public Property Let setDatabaseType(Str)
		DatabaseType = Str
	End Property

    Public Property Get GetTxtFilePath(Url)
        GetTxtFilePath = CacheDir & SetFileName(Url)
    End Property 	
	
	
	
	Sub OpenConn()
		Dim b, c, d, e, f
		If DatabaseType = "Access" Then
			MDBPath = "/../网站备份\数据库/WebUrlScan.mdb"
			Call HandlePath(MDBPath)
		End If
		
		If MDBPath <> "" Then
			Call HandlePath(MDBPath)
			Set Conn = CreateObject("Adodb.Connection")
			Conn.Open "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & MDBPath
		Else
			If DatabaseType = "SqlServerWebData" Then
				b = "WebData"
				d = "sa"
				c = "aaa"
				e = "127.0.0.1,1433"
				
			ElseIf DatabaseType = "SqlServerLocalData" Then
				b = "LocalData"
				d = "sa"
				c = "aaa"
				e = "127.0.0.1,1433"
			
			ElseIf DatabaseType = "RemoteSqlServer" Then
				
				b = "qds0140159_db"
				d = "qds0140159": c = "L4dN4eRd"
				e = "qds-014.hichina.com"
			End If
			f = " Password = " & c & "; user id =" & d & "; Initial Catalog =" & b & "; data source =" & e & ";Provider = sqloledb;"
			Set Conn = CreateObject("Adodb.Connection")
			Conn.Open f
		End If
		
		Set Rs = CreateObject("Adodb.Recordset")
		Set Rss = CreateObject("Adodb.Recordset")
		Set Rst = CreateObject("Adodb.Recordset")
		Set Rsx = CreateObject("Adodb.Recordset")
		Set Rsd = CreateObject("Adodb.Recordset")
		Set TempRs = CreateObject("Adodb.RecordSet")
		Set RsTemp = CreateObject("Adodb.RecordSet")
	End Sub
	
	Sub ClearDatabases()
		Conn.Execute ("Delete From [WebUrlScan]")
	End Sub
  	
	
	function addUrl(a,b)
		call OpenConn()
		addUrl=false
		rs.open"Select * From [WebUrlScan] Where HttpUrl='"& pubHttpUrl &"'",conn,1,3
		if rs.eof then
			rs.addnew
			
			rs("WebSite")=pubWebSite
			rs("HttpUrl")=pubHttpUrl
			rs("Title")=pubWebTitle
			rs("Title")=pubWebTitle
			rs("WebState")=WebState
			rs("WebFileSize")=WebFileSize
			
			rs("toUrl")=a
			rs("ToTitle")=b
			
			rs.update
			addUrl=true
		end if :rs.close
	end function
	
	function checkUrl(a)
		call OpenConn()
		rs.open"Select * From [WebUrlScan] Where HttpUrl='"& a &"'",conn,1,1
		checkUrl=false
		if not rs.eof then
			checkUrl=true
		end if
		rs.close
	end function
	
	function batchAddUrl(a,b)
		dim c,d,e,f,g,h
		c=split(b,vbCrlf)
		
		for each d in c			
			d=phpTrim(d)	
			if instr(d,"$Array$")	>0 then
				g=split(d,"$Array$")
				d = g(0)
				h=g(1)
			end if
			if len(d)>3 then
				
				if checkUrl(d)=false then
					call GetHttpUrlContentUrlList(d,"","",a,h)	
					f = addUrl(a,h)
					e=e & d & "("& f &")" & vbCrlf
				else				
					e=e & d & "(exist)" & vbCrlf
				end if
			end if
		next
		batchAddUrl = e
	end function
End Class

%>



