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















Function closeHtml(Byval a)
	on error resume next
	Dim b, c, d, e, f, g, h, i, j, k : b = a
	Set h = CreateObject("VBscript.RegExp")
	h.IgnoreCase = True
	h.Global = True
	c = "p,div,span,table,ul,font,b,u,i,h1,h2,h3,h4,h5,h6"
	d = Split(c,",")
	For e = 0 To UBound(d)
		f = 0
		g = 0
		h.Pattern = "<(" + trim(d(e)) + ")((\s+[^<>])+|)>"
		Set i = h.Execute(b)
		For Each k in i
			f = f + 1
			b = Replace(b, k.Value, "<"& LCase(k.SubMatches(0)) & k.SubMatches(1) &">")
		Next
		h.Pattern = "<\/" + d(e) + ">"
		Set i = h.Execute(b)
		For Each k in i
			g = g + 1
			b = Replace(b, k.Value, "</"& LCase(k.SubMatches(0)) &">")
		Next
		For j = 1 To f - g
			b = b + "</" + d(e) + ">"
		Next
	Next
	closeHtml = b
	Set h = Nothing
End Function
%>

