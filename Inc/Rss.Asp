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
<%@ CodePage = 65001 %>
<!--#Include File = "Config.Asp"-->
<%

Function return_RFC822_Date(ByVal a, ByVal b)
    Dim c, d, e, f
    Dim g, h, i
    a = CDate(a)
    c = EnWeekDayName(a)
    d = Right("00" & Day(a), 2)
    e = EnMonthName(a)
    f = Year(a)
    g = Right("00" & Hour(a), 2)
    h = Right("00" & Minute(a), 2)
    i = Right("00" & Second(a), 2)
    return_RFC822_Date = c & ", " & _
    d & " " & _
    e & " " & _
    f & " " & _
    g & ":" & _
    h & ":" & _
    i & " " & _
     " " & b
End Function

Function EnWeekDayName(a)
    Dim b
    Select Case Weekday(a, 1)
        Case 1 : b = "Sun"
        Case 2 : b = "Mon"
        Case 3 : b = "Tue"
        Case 4 : b = "Wed"
        Case 5 : b = "Thu"
        Case 6 : b = "Fri"
        Case 7 : b = "Sat"
    End Select
    EnWeekDayName = b
End Function

Function EnMonthName(a)
    Dim b
    Select Case Month(a)
        Case 1 : b = "Jan"
        Case 2 : b = "Feb"
        Case 3 : b = "Mar"
        Case 4 : b = "Apr"
        Case 5 : b = "May"
        Case 6 : b = "Jun"
        Case 7 : b = "Jul"
        Case 8 : b = "Aug"
        Case 9 : b = "Sep"
        Case 10 : b = "Oct"
        Case 11 : b = "Nov"
        Case 12 : b = "Dec"
    End Select
    EnMonthName = b
End Function
	Dim Sql,XMLContent,rsc,Web_Name,Web_Url,CategoryName,Url,ToPath
	Web_Name = "南京麦思德餐饮有限公司"
	Web_Url =  Host()
	CategoryName = "餐饮培训"
	Call OpenConn()
	
	Sql = "Select Top 50 * From [Product] Where OnHtml=True Order By [UpDateTime] Desc"
	
	Set Rs = CreateObject("Adodb.RecordSet")
    Rs.Open Sql, Conn, 1, 1

    XMLContent = XMLContent & "<?xml version=""1.0"" encoding=""utf-8"" ?>" & vbCrlf
    XMLContent = XMLContent & "<?xml-stylesheet type=""text/xsl"" href=""/rss/rss.xslt"" version=""1.0"" ?>" & vbCrlf
    XMLContent = XMLContent & "<rss version=""2.0"">" & vbCrlf
    XMLContent = XMLContent & "<channel>" & vbCrlf
    XMLContent = XMLContent & "<title>" & Web_Name & " 的最新动态</title>" & vbCrlf
    XMLContent = XMLContent & "<link>" & Web_Url & "</link>" & vbCrlf
    XMLContent = XMLContent & "<language>zh-cn</language>" & vbCrlf
    XMLContent = XMLContent & "<copyright>RSS Feed By www.hitux.com</copyright>" & vbCrlf
    While Not Rs.Eof
        XMLContent = XMLContent & "<item>" & vbCrlf
        XMLContent = XMLContent & "<title><![CDATA[" & Rs("title") & "]]></title>" & vbCrlf
		Url = Web_Url & GetHandleUrl(Rs("FileName"))	
        XMLContent = XMLContent & "<link>" & Url & "</link>" & vbCrlf
        XMLContent = XMLContent & "<description><![CDATA[" & Rs("WebDescription") & "]]></description>" & vbCrlf
        XMLContent = XMLContent & "<pubDate>" & return_RFC822_Date(Rs("UpDateTime"), "08:00") & "</pubDate>" & vbCrlf
        XMLContent = XMLContent & "<author>" & Web_Name & "</author>" & vbCrlf
        XMLContent = XMLContent & "<category>" & CategoryName & "</category>" & vbCrlf
        XMLContent = XMLContent & "</item>" & vbCrlf
        Rs.MoveNext
    Wend
    XMLContent = XMLContent & "</channel>" & vbCrlf
    XMLContent = XMLContent & "</rss>" & vbCrlf
    Rs.Close
Set Rs = Nothing
Call CreateFolder("../Rss")
ToPath = HandlePath("../Rss/Feed.Xml")
Call WriteToFile(ToPath, XMLContent, "utf-8")
Url = "<a "& AHref(Web_Url & "/Rss/Feed.Xml","点击打开","_blank") &">"& Web_Url & "Rss/Feed.Xml" &"</a>"

Call Echo("Create Rss/Feed.Xml OK", Url)

%>



