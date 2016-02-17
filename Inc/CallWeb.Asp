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
<!--#Include File = "Config.Asp"-->
<%

Dim Temp,Add,Sql,X,I
Dim ThisWebSite
ThisWebSite = Host			

Session("Administrator") = "admin"

Call OpenConn()

Select Case Request("act")
    Case "nav" :  Call Rw(DivNavigation("Where NavTop=True  Order By Sort Asc"))
    Case "foot" :  Call Rw(DivWebBottom())
	Case "article" : Call Rw(DivArticle)
	Case "JSShowWeb" : Call JSShowWeb()				
	Case "articleList","ShowProduct"
		Session("BigClassName")=""
		Session("SmallClassName")=""
		Session("ThreeClassName")=""
		If Rq("Bid")<>"" Then ShowBidId(Rq("Bid"))
		If Rq("Sid")<>"" Then ShowSidId(Rq("Sid"))
		If Rq("Tid")<>"" Then ShowTidId(Rq("Tid"))
		ShowProduct():ArticleList()
End Select

Sub JSShowWeb()
	Dim b,c
	
	b = DivNavigation("Where NavTop=True  Order By Sort Asc")
	b=Replace(b,vbCrlf,"\n")
	b=Replace(b,"/","\/")
	c=c & "document.all.nav.innerHTML="""& b &"""" & vbCrlf
	
	b=Replace(DivWebBottom,vbCrlf,"\n")
	b=Replace(Replace(b,"/","\/"),"""","\""")
	c=c & "document.all.foot.innerHTML="""& b &"""" & vbCrlf
	
	Call Rw(c)
End Sub

Function DivNavigation(a)
	Dim b, c, d, e, f, g, h, i
	Rs.Open "Select * From [NavBigClass] " & a, Conn, 1, 1
	c = c & "<li class=left></li>" & vbCrlf
	For b = 1 To Rs.RecordCount
		e = Rs("FileName")
		If e <> "" And Right(e,1)<>"/" Then e = e & ".html"
	
		f = "/" & Rs("FolderName") & "/" 	
		g = Rs("BigClassName")
		h = FontColorFontB(g, Rs("FontB"), Rs("FontColor"))
		i = Rs("Target")
		
		d = Rs("FileName")
		If CheckRemoteUrl(d)=False Then		
			d = f & e
			d = Replace(Replace(d, "//", "/"), "//", "/")
			d = FullHttpUrl(ThisWebSite,d)	
			Call WebDebug(d,"act=Nav&NavDid=" & g)
		End If
		
		c = c & "<li><a " & AHref(d, "", i) & ">" & h & "</a></li>" &vbCrlf
		c = c & "<li class=line></li>" & vbCrlf
	Rs.MoveNext : Next : Rs.Close
	c = c & "<li class=right></li>" & vbCrlf
	DivNavigation = c
End Function

Function DivWebBottom()
	Rs.Open"Select * From [WebSite]",Conn,1,1
	If Not Rs.Eof Then
		DivWebBottom=Rs("WebSiteBottom")
	End If:Rs.Close
End Function

Function DivArticle()
    Dim b,c
	c=Trim(Request("Id"))
	Rs.Open"Select * From [Product] Where Id=" & c,Conn,1,1
	If Not Rs.Eof Then
		b=b & "<div class=""your_position"">首页 ><Span>信息中心</Span></div>" & vbCrlf
		b=b & "<div class=""allpagenewstitle"">"& Rs("Title") &"</div>" & vbCrlf
		b=b & "<div  class=""allpagenewsinfo"">作者："& Rs("Author") &"　　发布时间："& Rs("AddDateTime") &"</div>" & vbCrlf
		b=b & "<div class=""allpagenewscontent"">" & vbCrlf
		b=b & Rs("Content") & vbCrlf
		b=b & "</div>" & vbCrlf
	Else
		b = "没有文章"
	End If:Rs.Close
	DivArticle = b
End Function
Function ShowTidId(a)
	Rs.Open"Select * From [ThreeClass] Where Id="&a,Conn,1,1
	If Not Rs.Eof Then
		Session("BigClassName")=Rs("BigClassName")
		Session("SmallClassName")=Rs("SmallClassName")
		Session("ThreeClassName")=Rs("ThreeClassName")
	End If:Rs.Close
End Function

Function ShowSidId(a)
	Rs.Open"Select * From [SmallClass] Where Id="&a,Conn,1,1
	If Not Rs.Eof Then
		Session("BigClassName")=Rs("BigClassName")
		Session("SmallClassName")=Rs("SmallClassName")
		Session("ThreeClassName")=""
	End If:Rs.Close
End Function

Function ShowBidId(a)
	Rs.Open"Select * From [BigClass] Where Id="&a,Conn,1,1
	If Not Rs.Eof Then
		Session("BigClassName")=Rs("BigClassName")
		Session("ThreeClassName")=""
		Session("SmallClassName")=""
	End If:Rs.Close
End Function

Function ShowProduct()
	If Session("ThreeClassName")<>"" Then
		Add=" Where BigClassName='"&Session("BigClassName")&"' And SmallClassName='"&Session("SmallClassName")&"' And ThreeClassName='"&Session("ThreeClassName")&"'"
	ElseIf Session("SmallClassName")<>"" Then
		Add=" Where BigClassName='"&Session("BigClassName")&"' And SmallClassName='"&Session("SmallClassName")&"'"
	ElseIf Session("BigClassName")<>"" Then
		Add=" Where BigClassName='"&Session("BigClassName")&"'"
	End If
End Function


Function ArticleList()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title>文章列表</title>
</head>
<body>
<script language="javascript" src=""& adminDir &"Images/Function.Js"></script>
<link href=""& adminDir &"Css/Main.Css" rel="stylesheet"  type="text/css">
<link href=""& adminDir &"Css/BodyCss.Css" rel="stylesheet"  type="text/css">
<div class="ClickYes">
<div class="Div800Center">
<%
Rw("&nbsp;<a href=""?act=ShowProduct"">产品展示 >> </a>")
Rs.Open"Select BigClassName,Id From [BigClass] Order By Sort",Conn,1,1
While Not Rs.Eof
If Session("BigClassName")=Rs(0) Then Temp="<font color=red>"&Rs(0)&"</font>" Else Temp=Rs(0)
Rw("<a href=?act=ShowProduct&Bid="&Rs("Id")&">"&Temp&"</a> | ")
Rs.MoveNext:Wend:Rs.Close
%>
</div>
<div class="div5"></div>
<%If Session("BigClassName")<>"" Then
	Rs.Open"Select BigClassName,SmallClassName,Id From [SmallClass] Where BigClassName='"&Session("BigClassName")&"' Order By Sort",Conn,1,1
	If Not Rs.Eof Then
	Rw("<div class=""Div800Center"" style=""background:#C1CDE3;"">")
	While Not Rs.Eof
	If Session("SmallClassName")=Rs(1) Then Temp="<font color=red>"&Rs(1)&"</font>" Else Temp=Rs(1)
	Rw("<a href=?act=ShowProduct&Sid="&Rs("Id")&">"&Temp&"</a> | ")
	Rs.MoveNext:Wend
	Rw("</div><div class=""div5""></div>")
	End If:Rs.Close
End If
%>
<%If Session("SmallClassName")<>"" Then
	Rs.Open"Select BigClassName,SmallClassName,ThreeClassName,Id From [ThreeClass] Where BigClassName='"&Session("BigClassName")&"' And SmallClassName='"&Session("SmallClassName")&"' Order By Sort",Conn,1,1
	If Not Rs.Eof Then
	Rw("<div class=""Div800Center"" style=""background:#C1CDE3;"">")
	While Not Rs.Eof
	If Session("ThreeClassName")=Rs(2) Then Temp="<font color=red>"&Rs(2)&"</font>" Else Temp=Rs(2)
	Rw("<a href=?act=ShowProduct&Tid="&Rs("Id")&">"&Temp&"</a> | ")
	Rs.MoveNext:Wend
	Rw("</div><div class=""div5""></div>")
	End If:Rs.Close

End If
%>
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" class="border" align="center">
<form id="formPro" name="formPro" method="post" action="?act=aa">
<tr bgcolor="A4B6D7" class="title">
<td width="30" height="25" align="center" bgcolor="A4B6D7"><b>选中</b></td>
<td width="100" height="25" align="center"><span style="font-weight: bold">信息大类</span></td>
<td width="78" align="center" bgcolor="A4B6D7"><span style="font-weight: bold">信息小类</span></td>
<td width="78" align="center"><span style="font-weight: bold">信息子类</span></td>
<td align="center"><span style="font-weight: bold">信息名称</span></td>

<td width="40" align="center"><b>审核</b></td>
<td width="81" align="center"><span style="font-weight: bold">发布时间</span></td>
<td width="92" align="center"><b>操作选项</b></td>
</tr>
<%
If Session("BigClassName")<>"" Or Session("SmallClassName")<>"" Or Session("ThreeClassName")<>"" Then
Add=" Where "
	If Session("BigClassName")<>"" Then Add=Add&" BigClassName='"&Session("BigClassName")&"'"	
	If Session("SmallClassName")<>"" Then Add=Add&" And SmallClassName='"&Session("SmallClassName")&"'"
	If Session("ThreeClassName")<>"" Then Add=Add&" And ThreeClassName='"&Session("ThreeClassName")&"'"
ElseIf Rf("Search")<>"" Then
	Add=" Where Title like '%"&Rf("Search")&"%'"
ElseIf Rf("Sql")<>"" Then
	Add=" "&Rf("Sql")
End If
If Rq("page") <> "" Then Temp = "&page=" & Rq("page") Else Temp = ""
Sql="Select * From [Product]"&Add&" Order By Sort"
Rs.Open Sql,Conn,1,1
If Rs.Eof Then

Else
Rs.PageSize = 11
nCount=Rs.RecordCount
nPageSize=Rs.PageSize
MaxPage=Rs.PageCount
Page=request("page")
If Not IsNumeric(Page) Or Page="" Then
	Page=1
Else
	Page=Cint(Page)
End If
If Page < 1 Then
	Page = 1
ElseIf  Page > MaxPage Then
	Page = MaxPage
End If
Rs.AbsolutePage = Page
If Page = Maxpage Then
	X = nCount-(MaxPage-1)*nPageSize
Else
	X = nPageSize
End If
For I=1 To x
%>
<tr bgcolor="#E8FFED" id="TR83" class="tdbg" onMouseOver="onColor(this);" onMouseOut="offColor(this);">
<td height="22" align="center" >
<input name="selectPid" type="checkbox" id="selectPid" value="<%=Rs(0)%>" onClick="ShowColor(this,1)" />
<input name="Id" type="hidden" id="Id" value="<%=Rs(0)%>"></td>
<td width="100" align="center"><%=Rs("BigClassName")%>&nbsp;</td>
<td width="100" align="center"><%=Rs("SmallClassName")%>&nbsp;</td>
<td width="100" align="center"><%=Rs("ThreeClassName")%>&nbsp;</td>
<td align="left"><a href="#" title="文章标题" name="<%=Rs("ID")%>"><%=Rs("Title")%></a></td>

<td align="center"><%

	Call Rw(ShowOnOffImg(Rs(0), "Product", "Through", Rs("Through"), "/Inc/CallWeb.Asp?act=ShowProduct"))

%></td>
<td align="center"><%=Rs("UpDateTime")%>&nbsp;</td>
<td align="center" bgcolor="#E8FFED"><a href="?act=ShowEditProduct&amp;Id=<%=Rs(0)&Temp%>">修改</a> | <a href="?act=DelId&Id=<%=Rs(0)&Temp%>" onClick="return CheckDel();">删除</a></td>
</tr>
<%Rs.MoveNext:Next:End If:Rs.Close%>
<tr bgcolor="#A4B6D7" class="tdbg">
  <td height="22" colspan="9" align="left" ><a href="javascript:Checkmm('全选');">全选</a> <a href="javascript:Checkmm('反选');">反选</a><span style="text-align:center;">

    <select name="Sel" id="Sel" onchange="javascript:PROonclick();">
      <option>请选择操作</option>
      <%	
	  Rw("<option value=""?act=AllSave"&Temp&""">更新信息</option>")
	  Rw("<option value=""?act=AllDel"&Temp&""">删除选择</option>")
	  %>
    </select>
  </span></td>
</tr></form>
</table>

<div style="text-align:center;">
  <%call Rw(PageControl(nCount,maxpage,page,"border=0 align=center","<p align=center>"))%></div>
</div>
</body></html>
<%End Function%>

