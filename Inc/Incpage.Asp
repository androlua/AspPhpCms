<% 
'dim nCount,nPageSize,maxpage,page,x,i,PageControl
Function pageControl(nCount, nPageCount, page, table_style, font_style)
    '生成上一页下一页链接
    Dim query, a, x, temp, action, i, c 
    action = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("SCRIPT_NAME") 
    query = Split(Request.ServerVariables("QUERY_STRING"), "&") 
    For Each x In query
        a = Split(x, "=") 
        If StrComp(a(0), "page", vbTextCompare) <> 0 Then
            temp = temp & a(0) & "=" & a(1) & "&" 
        End If 
    Next 

    c = c & "<table width=100% border=0 cellpadding=0 cellspacing=0 class=hui>" & vbCrLf 
    c = c & "<TD align=center height=35 class='font'>" & vbCrLf 
    c = c & font_style & vbCrLf 
    If page <= 1 Then
        c = c & "首 页 " & vbCrLf 
        c = c & "上一页 " & vbCrLf 
    Else
        c = c & "<A HREF=" & action & "?" & temp & "Page=1 class='huilianjie'>首 页</A> " & vbCrLf 
        c = c & "<A HREF=" & action & "?" & temp & "Page=" &(page - 1) & " class='huilianjie'>上一页</A> " & vbCrLf 
    End If 
    If page >= nPageCount Then
        c = c & "下一页 " & vbCrLf 
        c = c & "尾 页 " & vbCrLf 
    Else
        c = c & "<A HREF=" & action & "?" & temp & "Page=" &(page + 1) & " class='huilianjie'>下一页</A> " & vbCrLf 
        c = c & "<A HREF=" & action & "?" & temp & "Page=" & nPageCount & " class='huilianjie'>尾 页</A> " & vbCrLf 
    End If 
    c = c & " 页次：<b><font color=red>" & page & "</font>/" & nPageCount & "</b>页" & vbCrLf 
    c = c & " 共有<b>" & nCount & "</b>个记录" & vbCrLf 
    If nPageCount < 10 Then
        c = c & "<SELECT onchange='location.href(this.options[this.selectedIndex].value)'>" 
        For i = 1 To nPageCount
            If page = i Then
                c = c & "<option value=?" & temp & "page=" & i & " selected> 第" & i & "页</option>" 
            Else
                c = c & "<option value=?" & temp & "page=" & i & "> 第" & i & "页</option>" 
            End If 
        Next 
        c = c & "</select>" 
    Else
        temp = Replace(temp, "\", "\\") 
        c = c & "<input name=""GotoPage"" value=""" & page & """ type=""text"" id=""GotoPage"" size=""5"" style=""text-align:center;"" /> &nbsp;" 
        c = c & "<input type=""button"" name=""button"" id=""button"" value=""跳转"" onclick=""location.href('?" & temp & "Page=' + document.all.GotoPage.value)"" />" 
    End If 
    c = c & "<!--用时--></TD>" & vbCrLf 
    c = c & "</TR>" & vbCrLf 
    c = c & "</table>" & vbCrLf 
    pageControl = c 
End Function 

'页控制  记录总数  每页显示数  当前面 (2015117)   webPageControl(59,12,1,"http://www.baidu.com")
Function webPageControl(nRecrodCount, nPageSize, nPage, configPageUrl, action)
    Dim c, nCountPage, i, nDisplay, nDispalyOK, nTemp, cPages, url,selStr
    Dim previousPage, nextPage                                                      '定义上一页，下一页
    Dim isDisplayTip                                                                '是否显示提示翻页信息
    isDisplayTip = True 

    Dim sPageStart, sPageEnd, sHomePage, sHomePageFocus, sUpPage, sUpPageFocus, sNextPage, sNextPageFocus, sForPage, sForPageFocus, sTailPage, sTailPageFocus 
    If action <> "" Then
        sPageStart = getStrCut(action, "[sPageStart]", "[/sPageStart]", 2)    '页头部分
        sPageEnd = getStrCut(action, "[sPageEnd]", "[/sPageEnd]", 2)          '页尾部分
        sHomePage = getStrCut(action, "[sHomePage]", "[/sHomePage]", 2)       '首页
        sHomePageFocus = getStrCut(action, "[sHomePageFocus]", "[/sHomePageFocus]", 2) '首页交点
        sUpPage = getStrCut(action, "[sUpPage]", "[/sUpPage]", 2)             '上一页
        sUpPageFocus = getStrCut(action, "[sUpPageFocus]", "[/sUpPageFocus]", 2) '上一页交点
        sNextPage = getStrCut(action, "[sNextPage]", "[/sNextPage]", 2)       '下一页
        sNextPageFocus = getStrCut(action, "[sNextPageFocus]", "[/sNextPageFocus]", 2) '下一页交点
        sForPage = getStrCut(action, "[sForPage]", "[/sForPage]", 2)          '循环页
        sForPageFocus = getStrCut(action, "[sForPageFocus]", "[/sForPageFocus]", 2) '循环页交点
        sTailPage = getStrCut(action, "[sTailPage]", "[/sTailPage]", 2)       '最后页
        sTailPageFocus = getStrCut(action, "[sTailPageFocus]", "[/sTailPageFocus]", 2) '最后页交点


    End If 
    '页头部分
    If sPageStart = "" Then
        sPageStart = "<ul class=""pagecontrolwrap"">" & vbCrLf & "<li class=""pageinfo"">共[$nRecrodCount$]条 [$nPage$]/[$nCountPage$]页</li>" & vbCrLf 
    End If 
    '页尾部分
    If sPageEnd = "" Then
        sPageEnd = "</ul><div class=""clear""></div>" & vbCrLf 
    End If 
    '首页
    If sHomePage = "" Then
        sHomePage = "<li><a href=""[$url$]"">首页</a></li>" & vbCrLf 
    End If 
    '首页交点
    If sHomePageFocus = "" Then
        sHomePageFocus = "<li class=""pageli"">首页</li>" & vbCrLf 
    End If 
    '上一页
    If sUpPage = "" Then
        sUpPage = "<li><a href=""[$url$]"">上一页</a></li>" & vbCrLf 
    End If 
    '上一页交点
    If sUpPageFocus = "" Then
        sUpPageFocus = "<li class=""pageli"">上一页</li>" & vbCrLf 
    End If 
    '下一页
    If sNextPage = "" Then
        sNextPage = "<li><a href=""[$url$]"">下一页</a></li>" & vbCrLf 
    End If 
    '下一页交点
    If sNextPageFocus = "" Then
        sNextPageFocus = "<li class=""pageli"">下一页</li>" & vbCrLf 
    End If 
    '循环页
    If sForPage = "" Then
        sForPage = "<li class=""pagefocus"">[$i$]</li>" & vbCrLf 
    End If 
    '循环页交点
    If sForPageFocus = "" Then
        sForPageFocus = "<li><a href=""[$url$]"">[$i$]</a></li>" & vbCrLf 
    End If 
    '最后页
    If sTailPage = "" Then
        sTailPage = "<li><a href=""[$url$]"">末页</a></li>" & vbCrLf 
    End If 
    '最后页交点
    If sTailPageFocus = "" Then
        sTailPageFocus = "<li class=""pageli"">末页</li>" & vbCrLf 
    End If 
    '测试时用到20160630
    If 1 = 2 Then
        c = "[sPageStart]" & vbCrLf & sPageStart & "[/sPageStart]" & vbCrLf & vbCrLf 
        c = c & "[sHomePage]" & vbCrLf & sHomePage & "[/sHomePage]" & vbCrLf & vbCrLf 
        c = c & "[sHomePageFocus]" & vbCrLf & sHomePageFocus & "[/sHomePageFocus]" & vbCrLf & vbCrLf 

        c = c & "[sUpPage]" & vbCrLf & sUpPage & "[/sUpPage]" & vbCrLf & vbCrLf 
        c = c & "[sUpPageFocus]" & vbCrLf & sUpPageFocus & vbCrLf & "[/sUpPageFocus]" & vbCrLf 


        c = c & "[sForPage]" & vbCrLf & sForPage & "[/sForPage]" & vbCrLf & vbCrLf 
        c = c & "[sForPageFocus]" & vbCrLf & sForPageFocus & "[/sForPageFocus]" & vbCrLf & vbCrLf 


        c = c & "[sNextPage]" & vbCrLf & sNextPage & "[/sNextPage]" & vbCrLf & vbCrLf 
        c = c & "[sNextPageFocus]" & vbCrLf & sNextPageFocus & "[/sNextPageFocus]" & vbCrLf & vbCrLf 

        c = c & "[sTailPage]" & vbCrLf & sTailPage & "[/sTailPage]" & vbCrLf & vbCrLf 
        c = c & "[sTailPageFocus]" & vbCrLf & sTailPageFocus & "[/sTailPageFocus]" & vbCrLf & vbCrLf 
        c = c & "[sPageEnd]" & vbCrLf & sPageEnd & "[/sPageEnd]" & vbCrLf 
        Call rwend("[page]" & vbCrLf & vbCrLf & c & vbCrLf & "[/page]") 
    End If 
    '配置页为空则
    If configPageUrl = "" Then
        configPageUrl = getUrlAddToParam(getUrl(), "?page=[id]", "replace") 
    End If 

    nDisplay = 6                                                                    '显示数
    nDispalyOK = 0                                                                  '显示成功数
    nPage = handleNumberType(nPage) 
    If nPage = "" Then
        nPage = 1 
    Else
        nPage = CInt(nPage) 
    End If 
    '获得总页数
    nCountPage = getCountPage(nRecrodCount, nPageSize) 



    previousPage = nPage - 1 
    nextPage = nPage + 1 

    '处理上一页
    If previousPage <= 0 Then
        previousPage = "" 
    End If 
    '处理下一页
    If nextPage > nCountPage Then
        nextPage = "" 
    End If 

    '页开始
    c = sPageStart 
    '首页
    If nPage > 1 Then
        c = c & Replace(sHomePage, "[$url$]", Replace(configPageUrl, "[id]", "")) 
    ElseIf isDisplayTip = True Then
        c = c & sHomePageFocus 
    End If 
    '上一页
    If previousPage <> "" Then
        nTemp = previousPage 
        If previousPage <= 1 Then
            nTemp = "" 
        End If 
        c = c & Replace(sUpPage, "[$url$]", Replace(configPageUrl, "[id]", nTemp)) 
    ElseIf isDisplayTip = True Then
        c = c & sUpPageFocus 
    End If 


    Dim n 
    'call echo(npage,ncountpage)
    n =(nPage - 3) 
    'call echo("n",n)

    '翻页循环
    For i = n To nCountPage
        If i >= 1 Then
            nDispalyOK = nDispalyOK + 1 
            'call echo(i,nPage)
            If i = nPage Then
                c = c & Replace(sForPage, "[$i$]", i) 
            Else
                nTemp = i 
                If i <= 1 Then
                    nTemp = "" 
                End If 
                c = c & Replace(Replace(sForPageFocus, "[$url$]", Replace(configPageUrl, "[id]", nTemp)), "[$i$]", i) 
            End If 
            If nDispalyOK > nDisplay Then
                Exit For 
            End If 
        End If 
    Next 
    '下一页
    If nCountPage > nPage Then
        c = c & Replace(sNextPage, "[$url$]", Replace(configPageUrl, "[id]", nextPage)) 
    ElseIf isDisplayTip = True Then
        c = c & sNextPageFocus 
    End If 
    '末页
    If nCountPage > nPage Then
        c = c & Replace(sTailPage, "[$url$]", Replace(configPageUrl, "[id]", nCountPage)) 
    ElseIf isDisplayTip = True Then
        c = c & sTailPageFocus 
    End If 

    c = c & sPageEnd 


    c = replaceValueParam(c, "nRecrodCount", nRecrodCount) 
    c = replaceValueParam(c, "nPage", nPage) 
    If nCountPage = "0" Then
        nCountPage = 1 
    End If 
    c = replaceValueParam(c, "nCountPage", nCountPage) 

    If InStr(c, "[$page-select-openlist$]") > 0 Then
        For i = 1 To nCountPage
            url = Replace(configPageUrl, "[id]", i) 
			selStr=""
			if i =nPage then
				selStr=" selected"
			end if
            cPages = cPages & "<option value=""" & url & """"& selStr &">" & i & "</option>" & vbCrLf 
        Next 
        c = Replace(c, "[$page-select-openlist$]", cPages) 
    End If 

    webPageControl = c & vbCrLf 
End Function 


'获得Rs页数
Function getRsPageNumber(rs, nCount, nPageSize, page)
    Dim maxPage 
    Dim x 
    x = 0 
    rs.PageSize = nPageSize                                                         '每页记录条数 可自定义
    maxPage = rs.PageCount 
    If maxPage > 0 Then
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
    End If 
    getRsPageNumber = x 
End Function 
%>  

