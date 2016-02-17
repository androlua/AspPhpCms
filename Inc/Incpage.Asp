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

Function PageControl(a, b, c, d, e)

    Dim f, g, h, i, j, k, l
    j = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME")
    f = Split(Request.ServerVariables("QUERY_STRING"), "&")
    For Each h In f
        g = Split(h, "=")
        If StrComp(g(0), "page", vbTextCompare) <> 0 Then
            i = i & g(0) & "=" & g(1) & "&"
        End If
    Next
	
    l = l & "<table width=100% border=0 cellpadding=0 cellspacing=0 class=hui>" & vbCrlf
    l = l & "<TD align=center height=35 class='font'>" & vbCrlf
    l = l & e & vbCrlf
    If c <= 1 Then
        l = l & "首 页 " & vbCrlf
        l = l & "上一页 " & vbCrlf
    Else
        l = l & "<A HREF=" & j & "?" & i & "Page=1 class='huilianjie'>首 页</A> " & vbCrlf
        l = l & "<A HREF=" & j & "?" & i & "Page=" &(c - 1) & " class='huilianjie'>上一页</A> " & vbCrlf
    End If
    If c >= b Then
        l = l & "下一页 " & vbCrlf
        l = l & "尾 页 " & vbCrlf
    Else
        l = l & "<A HREF=" & j & "?" & i & "Page=" &(c + 1) & " class='huilianjie'>下一页</A> " & vbCrlf
        l = l & "<A HREF=" & j & "?" & i & "Page=" & b & " class='huilianjie'>尾 页</A> " & vbCrlf
    End If
    l = l & " 页次：<b><font color=red>" & c & "</font>/" & b & "</b>页" & vbCrlf
    l = l & " 共有<b>" & a & "</b>个记录" & vbCrlf
    If b < 10 Then
        l = l & "<SELECT onchange='location.href(this.options[this.selectedIndex].value)'>"
        For k = 1 To b
            If c = k Then
                l = l & "<option value=?" & i & "page=" & k & " selected> 第" & k & "页</option>"
            Else
                l = l & "<option value=?" & i & "page=" & k & "> 第" & k & "页</option>"
            End If
        Next
        l = l & "</select>"
    Else
		i = Replace(i,"\","\\")
        l = l & "<input name=""GotoPage"" value=""" & c & """ type=""text"" id=""GotoPage"" size=""5"" style=""text-align:center;"" /> &nbsp;"
        l = l & "<input type=""button"" name=""button"" id=""button"" value=""跳转"" onclick=""location.href('?" & i & "Page=' + document.all.GotoPage.value)"" />"
    End If
    l = l & "<!--用时--></TD>" & vbCrlf
    l = l & "</TR>" & vbCrlf
    l = l & "</table>" & vbCrlf
    PageControl = l
End Function


function webPageControl(a, b, c, d)
	dim e,f,g,h,i,j,k
	dim l,nextPage						
	dim isDisplayTip		
	
	isDisplayTip=true
	
	
    if d="" then
        d=GetUrlAddToParam( GetUrl(),"?page=[id]","replace")
	end if
	
	i=6			
	j=0		
	c=HandleNumberType(c)
	if c="" then
		c=1
	else
		c=Cint(c)
	end if
	
	g=GetCountPage(a,b)
	
	
	
	l=c-1
	nextPage=c+1
	
	
	if l<=0 then
		l=""
	end if
	
	if nextPage>g then
		nextPage=""
	end if
	
	f=f & "<ul class=""pagecontrolwrap"">" & vbcrlf
	
	f=f & "<li class=""pageinfo"">总数["& a &"]  共["& c &"/"& g &"]页</li>" & vbcrlf
	
	if c>1 then
		f=f & "<li><a href="""&  replace(d,"[id]","") &""">首页</a></li>" & vbcrlf			
	elseif isDisplayTip=true then
		f=f & "<li class=""pageli"">首页</li>" & vbcrlf
	end if
	
	if l<>"" then
		k=l
		if l<=1 then
			k=""
		end if
		f=f & "<li><a href="""&  replace(d,"[id]",k) &""">上一页</a></li>" & vbcrlf
	elseif isDisplayTip=true then
		f=f & "<li class=""pageli"">上一页</li>" & vbcrlf
	end if

 	
	dim o
	
	o = (c-3)
	
	
	
	for h = o to g
		if h>=1 then
			j=j+1
			
			if h = c then
				f=f & "<li class=""pagefocus"">"& h &"</li>" & vbcrlf
			else
				k=h
				if h<=1 then
					k=""
				end if
				f=f & "<li><a href="""&  replace(d,"[id]",k) &""">"& h &"</a></li>" & vbcrlf
			end if
			if j>i then
				exit for
			end if
		end if
	next
	
	if g>c then
		f=f & "<li><a href="""& replace(d,"[id]",nextPage) &""">下一页</a></li>" & vbcrlf
	elseif isDisplayTip=true then
		f=f & "<li class=""pageli"">下一页</li>" & vbcrlf
	end if
	
	if g>c then
		f=f & "<li><a href="""& replace(d,"[id]",g) &""">末页</a></li>" & vbcrlf
	elseif isDisplayTip=true then
		f=f & "<li class=""pageli"">末页</li>" & vbcrlf
	end if
	
	f=f & "</ul><div class=""clear""></div>" & vbcrlf
	webPageControl=f  & vbcrlf
end function



Function getRsPageNumber(a, b, c, d)
    Dim e
	e=0
    a.PageSize = c
    maxPage = a.PageCount
	if maxPage>0 then
		If Not IsNumeric(d) Or d = "" Then
			d = 1
		Else
			d = CInt(d)
		End If
		If d < 1 Then
			d = 1
		ElseIf d > maxPage Then
			d = maxPage
		End If
		a.AbsolutePage = d
		If d = maxPage Then
			e = b - (maxPage - 1) * c
		Else
			e = c
		End If
	end if
    getRsPageNumber = e
End Function
%>



