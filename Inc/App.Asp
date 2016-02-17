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

Select Case Request("act")
	Case "ViewInfo" : ViewInfo()			
	Case "ViewList" : ViewList()			
	Case "ViewList2" : ViewList2()			
	Case "test" : mytest()					
End Select

Sub mytest()
	Dim b,c,d
	b=Rf("username")
	c=Rq("username")
	d=Rf("userpass")
	Rw("UserName=" & b & vbCrlf)
	Rw("UserName2=" & c & vbCrlf)
	Rw("PassWord=" & d)
End Sub


Sub ViewList2()
	Dim b,c,d,e,f,g,h,i,j,k
	Response.Addheader "Content-Type","text/html; charset=utf-8"
	Dim l,m,n,o,p,q
	
	Call OpenConn()
	l=Conn.Execute("Select Count(*) From [Product]")(0)
	
	For j=0 To 50
		m=Conn.Execute("Select Count(*) From [Product] Where UpDateTime=#"& Date()-j &"#")(0)
		n = n &  "时间(" & Format_Time(Now-j,2) & ")" & vbCrlf & "新添文章("& m &"/" & l & ")" & vbCrlf
		p = GetFText("\Admin\Data\Stat\" & Format_Time(Now()-j,2) & ".txt")
		q=Split(p,"当前：")
		g=0			
		h=0			
		c = 0		
		f = 0		
		
		For Each i In q
			If InStr(i,"IP:")>0 Then
				If InStr(i,vbCrlf & "IE: U" & vbCrlf)>0 Then
					g = g + 1
					d = Mid(i,InStr(i,"XP=")+3)
					d = Mid(d,1,InStr(d,vbCrlf)-2)
					If InStr(vbCrlf & e & vbCrlf, vbCrlf & d & vbCrlf)=0 Then
						e = e & d & vbCrlf
						f = f + 1
					End If
				Else
					h = h + 1
				End If
				k = Mid(i,InStr(i,"IP:")+3)
				k = Mid(k,1,InStr(k,vbCrlf)-2)
				If InStr(vbCrlf & b & vbCrlf, vbCrlf & k & vbCrlf)=0 Then
					b = b & k & vbCrlf
					c = c + 1
				End If
			End If
		Next
		
		n=n & "LogDate="& Format_Time(Now()-j,2) &"" & vbCrlf 		
		n=n & "AddArticle="& m &"" & vbCrlf 				
		n=n & "ArticleSum="& l &"" & vbCrlf 			
		n=n & "WebBrowseSum="& (h + g) &"" & vbCrlf 	
		n=n & "ComputerSum="& h &"" & vbCrlf 				
		n=n & "MobileSum="& g &"" & vbCrlf 					
		n=n & "IndependentIP="& c &"" & vbCrlf 				
		n=n & "IndependentMobileType="& f &"" & vbCrlf 	
		n=n & "MobileTypeList="& e &"" & vbCrlf 			
		n=n & "-----------" & vbCrlf
	Next
	Response.Write(n)
End Sub

Sub ViewList()
	Dim b,c,d,e,f,g,h,i,j,k
	Response.Addheader "Content-Type","text/html; charset=utf-8"
	Dim l,m,n,o,p,q
	Call OpenConn()
	l=Conn.Execute("Select Count(*) From [Product]")(0)

	
	For j=0 To 50
		m=Conn.Execute("Select Count(*) From [Product] Where UpDateTime=#"& Date()-j &"#")(0)
		n = n &  "时间(" & Format_Time(Now-j,2) & ")" & vbCrlf & "新添文章("& m &"/" & l & ")" & vbCrlf
		p = GetFText("\Admin\Data\Stat\" & Format_Time(Now()-j,2) & ".txt")
		q=Split(p,"当前：")
		g=0			
		h=0			
		c = 0		
		f = 0		
		For Each i In q
			If InStr(i,"IP:")>0 Then
				If InStr(i,vbCrlf & "IE: U" & vbCrlf)>0 Then
					g = g + 1
					d = Mid(i,InStr(i,"XP=")+3)
					d = Mid(d,1,InStr(d,vbCrlf)-2)
					If InStr(vbCrlf & e & vbCrlf, vbCrlf & d & vbCrlf)=0 Then
						e = e & d & vbCrlf
						f = f + 1
					End If
				Else
					h = h + 1
				End If
				k = Mid(i,InStr(i,"IP:")+3)
				k = Mid(k,1,InStr(k,vbCrlf)-2)
				If InStr(vbCrlf & b & vbCrlf, vbCrlf & k & vbCrlf)=0 Then
					b = b & k & vbCrlf
					c = c + 1
				End If
			End If
		Next
		n=n & "网页被浏览("& h + g &")次" & vbCrlf
		n=n &"IE浏览("& h &")次" & vbCrlf
		n=n & "手机浏览("& g &")次" & vbCrlf
		n=n & "独立IP数为("& c &")个" & vbCrlf
		n=n & "-----------" & vbCrlf
	Next
	Response.Write(n)
End Sub


Sub ViewInfo()
	Dim b,c,d,e,f,g,h,i,j,k
	Response.Addheader "Content-Type","text/html; charset=utf-8"
	Dim l,m,n,o,p,q
	Call OpenConn()
	l=Conn.Execute("Select Count(*) From [Product]")(0)
	m=Conn.Execute("Select Count(*) From [Product] Where UpDateTime>=#"& Date() &"#")(0)
	

	
	n = "时间(" & Format_Time(Now,2) & ")" & vbCrlf & "新添文章("& m &"/" & l & ")" & vbCrlf
	p = GetFText("\Admin\Data\Stat\" & Format_Time(Now(),2) & ".txt")
	q=Split(p,"当前：")
	g=0			
	h=0			
	c = 0		
	f = 0		
	For Each i In q
		If InStr(i,"IP:")>0 Then
			If InStr(i,vbCrlf & "IE: U" & vbCrlf)>0 Then
				g = g + 1
				d = Mid(i,InStr(i,"XP=")+3)
				d = Mid(d,1,InStr(d,vbCrlf)-2)
				If InStr(vbCrlf & e & vbCrlf, vbCrlf & d & vbCrlf)=0 Then
					e = e & d & vbCrlf
					f = f + 1
				End If
			Else
				h = h + 1
			End If
			k = Mid(i,InStr(i,"IP:")+3)
			k = Mid(k,1,InStr(k,vbCrlf)-2)
			If InStr(vbCrlf & b & vbCrlf, vbCrlf & k & vbCrlf)=0 Then
				b = b & k & vbCrlf
				c = c + 1
			End If
		End If
	Next
	n=n & "网页被浏览("& h + g &")次" & vbCrlf
	n=n &"IE浏览("& h &")次" & vbCrlf
	n=n & "手机浏览("& g &")次" & vbCrlf
	n=n & "独立IP数为("& c &")个" & vbCrlf
	n=n & "不同手机类型数为("& f &")个" & vbCrlf
	n=n & "不同手机列表："& vbCrlf &  e
	Response.Write(n)
End Sub
%>

