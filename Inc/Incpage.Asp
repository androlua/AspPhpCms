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
'dim nCount,nPageSize,maxpage,page,x,i,PageControl 
Function PageControl(nCount, nPageCount, Page, Table_style, Font_style)
    '������һҳ��һҳ����
    Dim Query, A, X, Temp, Action, I, C 
    Action = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME") 
    Query = Split(Request.ServerVariables("QUERY_STRING"), "&") 
    For Each X In Query
        A = Split(X, "=") 
        If StrComp(A(0), "page", vbTextCompare) <> 0 Then
            Temp = Temp & A(0) & "=" & A(1) & "&" 
        End If 
    Next 
	
    C = C & "<table width=100% border=0 cellpadding=0 cellspacing=0 class=hui>" & vbCrlf 
    C = C & "<TD align=center height=35 class='font'>" & vbCrlf 
    C = C & Font_style & vbCrlf 
    If Page <= 1 Then
        C = C & "�� ҳ " & vbCrlf 
        C = C & "��һҳ " & vbCrlf 
    Else
        C = C & "<A HREF=" & Action & "?" & Temp & "Page=1 class='huilianjie'>�� ҳ</A> " & vbCrlf 
        C = C & "<A HREF=" & Action & "?" & Temp & "Page=" &(Page - 1) & " class='huilianjie'>��һҳ</A> " & vbCrlf 
    End If 
    If Page >= nPageCount Then
        C = C & "��һҳ " & vbCrlf 
        C = C & "β ҳ " & vbCrlf 
    Else
        C = C & "<A HREF=" & Action & "?" & Temp & "Page=" &(Page + 1) & " class='huilianjie'>��һҳ</A> " & vbCrlf 
        C = C & "<A HREF=" & Action & "?" & Temp & "Page=" & nPageCount & " class='huilianjie'>β ҳ</A> " & vbCrlf 
    End If 
    C = C & " ҳ�Σ�<b><font color=red>" & Page & "</font>/" & nPageCount & "</b>ҳ" & vbCrlf 
    C = C & " ����<b>" & nCount & "</b>����¼" & vbCrlf 
    If nPageCount < 10 Then
        C = C & "<SELECT onchange='location.href(this.options[this.selectedIndex].value)'>" 
        For I = 1 To nPageCount
            If Page = I Then
                C = C & "<option value=?" & Temp & "page=" & I & " selected> ��" & I & "ҳ</option>" 
            Else
                C = C & "<option value=?" & Temp & "page=" & I & "> ��" & I & "ҳ</option>" 
            End If 
        Next 
        C = C & "</select>" 
    Else
		Temp = Replace(Temp,"\","\\")
        C = C & "<input name=""GotoPage"" value=""" & Page & """ type=""text"" id=""GotoPage"" size=""5"" style=""text-align:center;"" /> &nbsp;" 
        C = C & "<input type=""button"" name=""button"" id=""button"" value=""��ת"" onclick=""location.href('?" & Temp & "Page=' + document.all.GotoPage.value)"" />" 
    End If 
    C = C & "<!--��ʱ--></TD>" & vbCrlf 
    C = C & "</TR>" & vbCrlf 
    C = C & "</table>" & vbCrlf 
    PageControl = C 
End Function 

'ҳ����  ��¼����  ÿҳ��ʾ��  ��ǰ�� (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
function webPageControl(nRecrodCount, nPageSize, nPage, configPageUrl, action)
	dim s,c,nCountPage,i,nDisplay,nDispalyOK,nTemp
	dim previousPage,nextPage						'������һҳ����һҳ
	dim isDisplayTip		'�Ƿ���ʾ��ʾ��ҳ��Ϣ	
	isDisplayTip=true
	
	dim sPageStart,sPageEnd,sHomePage,sHomePageFocus,sUpPage,sUpPageFocus,sNextPage,sNextPageFocus,sForPage,sForPageFocus,sTailPage,sTailPageFocus
	if action<>"" then
		sPageStart=getStrCut(action, "[sPageStart]", "[/sPageStart]", 2)			'ҳͷ����
		sPageEnd=getStrCut(action, "[sPageEnd]", "[/sPageEnd]", 2)					'ҳβ����
		sHomePage=getStrCut(action, "[sHomePage]", "[/sHomePage]", 2)	'��ҳ
		sHomePageFocus=getStrCut(action, "[sHomePageFocus]", "[/sHomePageFocus]", 2)		'��ҳ����
		sUpPage=getStrCut(action, "[sUpPage]", "[/sUpPage]", 2)						'��һҳ
		sUpPageFocus=getStrCut(action, "[sUpPageFocus]", "[/sUpPageFocus]", 2)				'��һҳ����
		sNextPage=getStrCut(action, "[sNextPage]", "[/sNextPage]", 2)				'��һҳ
		sNextPageFocus=getStrCut(action, "[sNextPageFocus]", "[/sNextPageFocus]", 2)			'��һҳ����
		sForPage=getStrCut(action, "[sForPage]", "[/sForPage]", 2)							'ѭ��ҳ
		sForPageFocus=getStrCut(action, "[sForPageFocus]", "[/sForPageFocus]", 2)				'ѭ��ҳ����
		sTailPage=getStrCut(action, "[sTailPage]", "[/sTailPage]", 2)							'���ҳ
		sTailPageFocus=getStrCut(action, "[sTailPageFocus]", "[/sTailPageFocus]", 2)			'���ҳ����
	end if
	'ҳͷ����
	if sPageStart="" then
		sPageStart="<ul class=""pagecontrolwrap"">" & vbcrlf & "<li class=""pageinfo"">��[$nRecrodCount$]�� [$nPage$]/[$nCountPage$]ҳ</li>" & vbcrlf
	end if
	'ҳβ����
	if sPageEnd="" then
		sPageEnd="</ul><div class=""clear""></div>" & vbcrlf
	end if
	'��ҳ
	if sHomePage="" then
		sHomePage="<li class=""pageli"">��ҳ</li>" & vbcrlf
	end if
	'��ҳ����
	if sHomePageFocus="" then
		sHomePageFocus="<li><a href=""[$url$]"">��ҳ</a></li>" & vbcrlf
	end if
	'��һҳ
	if sUpPage="" then
		sUpPage="<li class=""pageli"">��һҳ</li>" & vbcrlf
	end if
	'��һҳ����
	if sUpPageFocus="" then
		sUpPageFocus="<li><a href=""[$url$]"">��һҳ</a></li>" & vbcrlf
	end if
	'��һҳ
	if sNextPage="" then
		sNextPage="<li class=""pageli"">��һҳ</li>" & vbcrlf
	end if
	'��һҳ����
	if sNextPageFocus="" then
		sNextPageFocus="<li><a href=""[$url$]"">��һҳ</a></li>" & vbcrlf
	end if
	'ѭ��ҳ
	if sForPage="" then
		sForPage="<li><a href=""[$url$]"">[$i$]</a></li>" & vbcrlf
	end if
	'ѭ��ҳ����
	if sForPageFocus="" then
		sForPageFocus="<li class=""pagefocus"">[$i$]</li>" & vbcrlf
	end if
	'���ҳ
	if sTailPage="" then
		sTailPage="<li class=""pageli"">ĩҳ</li>" & vbcrlf
	end if
	'���ҳ����
	if sTailPageFocus="" then
		sTailPageFocus="<li><a href=""[$url$]"">ĩҳ</a></li>" & vbcrlf 
	end if
	
	'����ҳΪ����
    if configPageUrl="" then
        configPageUrl=GetUrlAddToParam( GetUrl(),"?page=[id]","replace")
	end if
	
	nDisplay=6			'��ʾ��
	nDispalyOK=0		'��ʾ�ɹ���
	nPage=HandleNumberType(nPage)
	if nPage="" then 
		nPage=1
	else
		nPage=Cint(nPage)
	end if
	'�����ҳ��
	nCountPage=GetCountPage(nRecrodCount,nPageSize)
	
	
	
	previousPage=nPage-1
	nextPage=nPage+1
	
	'������һҳ
	if previousPage<=0 then
		previousPage=""
	end if
	'������һҳ
	if nextPage>nCountPage then
		nextPage=""
	end if 
	
	'ҳ��ʼ
	c=sPageStart 
	'��ҳ
	if nPage>1 then
		c=c & replace(sHomePageFocus,"[$url$]",replace(configPageUrl,"[id]",""))
	elseif isDisplayTip=true then
		c=c & sHomePage
	end if
	'��һҳ
	if previousPage<>"" then
		nTemp=previousPage
		if previousPage<=1 then
			nTemp=""
		end if
		c=c & replace(sUpPageFocus,"[$url$]",replace(configPageUrl,"[id]",nTemp))
	elseif isDisplayTip=true then
		c=c & sUpPage
	end if
 
 	
	dim n
	'call echo(npage,ncountpage)
	n = (nPage-3)
	'call echo("n",n)
	
	'��ҳѭ��
	for i = n to nCountPage
		if i>=1 then
			nDispalyOK=nDispalyOK+1
			'call echo(i,nPage)
			if i = nPage then
				c=c & replace(sForPageFocus,"[$i$]",i)
			else
				nTemp=i
				if i<=1 then
					nTemp=""
				end if
				c=c & replace(replace(sForPage,"[$url$]",replace(configPageUrl,"[id]",nTemp)),"[$i$]",i)
			end if
			if nDispalyOK>nDisplay then
				exit for
			end if
		end if
	next 
	'��һҳ
	if nCountPage>nPage then
		c=c & replace(sNextPageFocus,"[$url$]",replace(configPageUrl,"[id]",nextPage))
	elseif isDisplayTip=true then
		c=c & sNextPage
	end if
	'ĩҳ
	if nCountPage>nPage then
		c=c & replace(sTailPageFocus,"[$url$]",replace(configPageUrl,"[id]",nCountPage))
	elseif isDisplayTip=true then
		c=c & sTailPage
	end if 
	
	c=c & sPageEnd
	
	
	c = replaceValueParam(c, "nRecrodCount", nRecrodCount)
	c = replaceValueParam(c, "nPage", nPage)
	c = replaceValueParam(c, "nCountPage", nCountPage)
		
	webPageControl=c  & vbcrlf
end function


'���Rsҳ��
Function getRsPageNumber(rs, nCount, nPageSize, page)
	dim maxPage
    Dim x 
	x=0
    rs.PageSize = nPageSize                                                         'ÿҳ��¼���� ���Զ���
    maxPage = rs.PageCount
	if maxPage>0 then 
		If Not IsNumeric(page) Or page = "" Then
			page = 1 
		Else
			page = CInt(page) 
		End If 
		If page < 1 Then
			page = 1 
		ElseIf page > maxPage Then
			page = maxPage 
		End If 
		rs.AbsolutePage = page
		If page = maxPage Then
			x = nCount - (maxPage - 1) * nPageSize 
		Else
			x = nPageSize 
		End If 
	end if
    getRsPageNumber = x 
End Function
%> 
