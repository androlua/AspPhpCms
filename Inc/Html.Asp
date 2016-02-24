<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-24
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
'Html 处理HTML代码 (2014,1,3)
 
'HTML代码转码
Function showHTMLCode(Str)
    If Not IsNull(Str) Then
        Str = Replace(Str, " ", "&nbsp;")
        Str = Replace(Str, "<", "&lt;") 
        Str = Replace(Str, ">", "&gt;") 
        Str = Replace(Str, "”", "&rdquo;") 
        Str = Replace(Str, "“", "&ldquo;") 
        Str = Replace(Str, "&", "&amp;")  
    End If 
    showHTMLCode = Str 
End Function
'显示Html
Function ShowHtml(Str)
	ShowHtml=Replace(Str, "<", "&lt;") 
End Function
'HTML代码解码
Function unHTMLCode(Str)
    If Not IsNull(Str) Then
        Str = Replace(Str, "&nbsp;", " ")
        Str = Replace(Str, "&lt;", "<") 
        Str = Replace(Str, "&gt;", ">") 
        Str = Replace(Str, "&rdquo;", "”") 
        Str = Replace(Str, "&ldquo;", "“") 
        Str = Replace(Str, "&mdash;", "—") 
        Str = Replace(Str, "&lsquo;", "‘") 
        Str = Replace(Str, "&rsquo;", "’") 
		
        Str = Replace(Str, "&amp;", "&") 
		 
    End If 
    unHTMLCode = Str 
End Function 
'让HTML不运行显示
Function EchoHTML(Str)
    If Not IsNull(Str) Then
        Str = Replace(Str, " ", "&nbsp;")
        Str = Replace(Str, "<", "&lt;")  
	End If
    EchoHTML = Str 
End Function 

'ErrorText 
Function ErrorText(Refresh, Str, Url)
    If IsNull(Refresh) Then Rw "<meta http-equiv=""refresh"" content=""" & Refresh & ";URL=" & Url & """"""">" & vbCrlf 
    Rw("<fieldset>") & vbCrlf 
    Rw("<legend>&nbsp;Report&nbsp;</legend>") & vbCrlf 
    Rw("<div style=""padding-left:20px;padding-top:10px;color:red;font-weight:bold;text-align:center;"">" & Str & "</div>") & vbCrlf 
    Rw("<div style=""height:200p;text-align:center;""><P>") & vbCrlf 
    Rw("<a href=""" & Url & """>如果您的游览器没有自动跳转,请点这里>></a><P>") & vbCrlf  	
    Rw("</div></fieldset>") : Response.End() 
End Function 

'---------------------- Html处理 Start ----------------------
'测试Html显示20141217 待测试
Sub TestHtml()
	Dim S
	S = "<font style=""font-size:12px"">显示<b>1</b></font>"
	Call Echo("S",S)
	S = HtmlEncode(S)
	Call Echo("S",S)
	S = HtmlDecode(S)
	Call Echo("S",S)
	S = HtmlFilter(S)
	Call Echo("S",S)
End Sub
'Html解密
Function HtmlDecode(ByVal str)
	If Not IsNul(str) Then
		str = regReplace(str, "<br\s*/?\s*>", vbCrLf)
		str = Replace(str, "&nbsp;&nbsp; &nbsp;", Chr(9))
		str = Replace(str, "&quot;", Chr(34))
		str = Replace(str, "&nbsp;", Chr(32))
		str = Replace(str, "&#39;", Chr(39))
		str = Replace(str, "&apos;", Chr(39))
		str = Replace(str, "&gt;", ">")
		str = Replace(str, "&lt;", "<")
		str = Replace(str, "&amp;", Chr(38))
		str = Replace(str, "&#38;", Chr(38))
		HtmlDecode = str
	End If
End Function
'Html加密
Function HtmlEncode(ByVal str)
	If Not IsNul(str) Then
		str = Replace(str, Chr(38), "&#38;")
		str = Replace(str, "<", "&lt;")
		str = Replace(str, ">", "&gt;")
		str = Replace(str, Chr(39), "&#39;")
		str = Replace(str, Chr(32), "&nbsp;")
		str = Replace(str, Chr(34), "&quot;")
		str = Replace(str, Chr(9), "&nbsp;&nbsp; &nbsp;")
		str = Replace(str, vbCrLf, "<br />")
	End If
	HtmlEncode = str
End Function
'HTML过虑
Function HtmlFilter(ByVal str)
	str = regReplace(str,"<[^>]+>","")
	str = Replace(str, ">", "&gt;")
	str = Replace(str, "<", "&lt;")
	HtmlFilter = str
End Function
Function regReplace(ByVal Str, ByVal rule, Byval Result)
	regReplace = Easp_Replace(Str,rule,Result,0)
End Function
Function Easp_Replace(ByVal Str, ByVal rule, Byval Result, ByVal isM)
	Dim tmpStr,Reg : tmpStr = Str
	If Not IsNul(Str) Then
		Set Reg = CreateObject("VBscript.RegExp")
		Reg.Global = True
		Reg.IgnoreCase = True
		If isM = 1 Then Reg.Multiline = True
		Reg.Pattern = rule
		tmpStr = Reg.Replace(tmpStr,Result)
		Set Reg = Nothing
	End If
	Easp_Replace = tmpStr
End Function
'---------------------- Html处理 End ----------------------











'处理Html标签闭合(20150831) 第一种，淘汰
function handleHtmlLabelClose(content,labelName,isAddAlt)
	dim StartStr,EndStr,SplStr,s,c,ImgList,imgStr,LCaseImgStr,newImgStr
	StartStr = "<" & labelName : EndStr = ">"
	ImgList = GetArray(Content, StartStr, EndStr, True, false)
	'call rw(ImgList)
	SplStr=Split(ImgList,"$Array$")
	for each imgStr in splstr
		newImgStr=phpTrim(imgStr)
		if right(newImgStr,1)="/" then
			newImgStr=PHPTrim(left(newImgStr,len(newImgStr)-1))
		end if
		if isAddAlt=true then
			LCaseImgStr = lcase(imgStr)
			if instr(LCaseImgStr,"alt")=false then
				newImgStr = newImgStr & " alt="""""
			end if
		end if
		content = replace(content,imgStr & ">", newImgStr & " />")
	next
	handleHtmlLabelClose=content
end function

'处理图片闭合(20150831)
function handleImgClose(content,isAddAlt)
	handleImgClose=handleHtmlLabelClose(content,"img",isAddAlt)
end function
'处理BR闭合(20150831)
function handleBrClose(content,isAddAlt)
	handleBrClose=handleHtmlLabelClose(content,"br",false)
	handleBrClose=replace(handleBrClose,"<br>","<br />")
end function
'处理HR闭合(20150831)
function handleHrClose(content,isAddAlt)
	handleHrClose=handleHtmlLabelClose(content,"hr",false)
	handleHrClose=replace(handleHrClose,"<hr>","<hr />")
end function




'处理闭合HTML标签(20150902)  比上面的更好用 第二种
Function handleCloseHtml(content,ImgAddAlt,action) 
    Dim i, endStr, s, s2, c, labelName, startLabel, endLabel
	action="|"& action &"|"
    startLabel = "<" 
    endLabel = ">" 
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 
        endStr = Mid(content, i) 
        If s = "<" Then
            If InStr(endStr, ">") > 0 Then
                s = Mid(endStr, 1, InStr(endStr, ">")) 
                i = i + Len(s) - 1 
                s = Mid(s, 2, Len(s) - 2) 
                s = phptrim(s) 
                If Right(s, 1) = "/" Then
                    s = phptrim(Left(s, Len(s) - 1)) 
                End If 
                endStr = Right(endStr, Len(endStr) - Len(s) - 2)                                '最后字符减去当前标签  -2是因为它有<>二个字符
				'注意之前放在labelName下面
                labelName = Mid(s, 1, InStr(s & " ", " ") - 1)
                labelName = LCase(labelName) 
                'call eerr("s",s)
				
				if  instr(action,"|处理A链接|")>0 then
					s = htmlLabelToClean(s,labelName,"http://127.0.0.1/TestWeb/Web/","处理A链接")                                                         '处理干净html标签
				elseif  instr(action,"|处理A链接第二种|")>0 then
					s = htmlLabelToClean(s,labelName,"http://127.0.0.1/debugRemoteWeb.asp?url=","处理A链接")                                                         '处理干净html标签
				else
					s = htmlLabelToClean(s,labelName,"","")                                                         '处理干净html标签
				end if
				
                'call echo(s,labelName)   param与embed是Flash用到，不过embed有结束标签的
                If InStr("|meta|link|embed|param|input|img|br|hr|rect|line|area|script|div|span|a|", "|" & labelName & "|") > 0 Then 
					s=replace(replace(replace(replace(s," class=""""","")," alt=""""","")," title=""""","")," name=""""","")		'临时这么做一下，以后要完整系统的做
					s=replace(replace(replace(replace(s," class=''","")," alt=''","")," title=''","")," name=''","")
					'给vb.net软件用的 要不然它会报错，晕
                    If labelName = "img" and ImgAddAlt=true Then
                        If InStr(s, " alt") = False Then
                            s = s & " alt=""""" 
                        End If
						s=trim(s)
						s = s & " /" 
					'补齐<script>20160106  暂时不能用这个，等改进
					elseif labelname= "script" then					
                        If InStr(s, " type") = False Then
                            s = s & " type=""text/javascript""" 
                        End If						
                    End If 
                End If 
                s = startLabel & s & endLabel 
                '处理javascript script部分
                If labelName = "script" Then
                    s2 = Mid(endStr, 1, InStr(endStr, "</script>") + 8) 

                    'call eerr("",s2)
                    i = i + Len(s2) 
                    s = s & s2 
                End If 
            'call echo("s",replace(s,"<","&lt;"))
            End If 
        End If 
        c = c & s 
    Next 
    handleCloseHtml = c 
End Function 
Function htmlLabelToClean(ByVal content,labelName,addToHttpUrl,action)
    Dim i, s, c, temp 
    Dim isValue                     '是否为内容值
    Dim valueStr 					'存储内容值
    Dim yinghaoLabel				'引号类型如'"
	dim parentName					'参数名称
	dim behindStr					'后面全部字符
	dim noDanYinShuangYinStr		'不是单引号和双引号字符
	action="|"& action &"|"
    content = Replace(content & " ", vbTab, " ")				'退格替换成空格，最后加一个空格，方便计算
	content=replace(replace(content," =","=")," =","=")
    isValue = False 										'默认内容为假，因为先是获得标签名称
    For i = 1 To Len(content)
        s = Mid(content, i, 1) 						'获得当前一个字符
		behindStr=Mid(content,i)					'后面字符
        If s = "=" and isValue = false Then				'不是内容值，并为=号
            isValue = True 
            valueStr = "" 
            yinghaoLabel = "" 
            If c <> "" and Right(c, 1) <> " " Then c = c & " " 
			parentName=Lcase(temp )					'参数名称转小写
            c = c & parentName & s
            temp = "" 
        '获得值第一个字符，因为它是引号类型
        ElseIf isValue = True and yinghaoLabel = "" Then
            If s <> " " Then
				if s<>"'" and s<>"""" then
					noDanYinShuangYinStr = s			'不是单引号和双引号字符
					s=" "
				end if
                yinghaoLabel = s
				'call echo("yinghaoLabel",yinghaoLabel)
            End If 
        ElseIf isValue = True and yinghaoLabel <> "" Then
			'为引号结束
            If yinghaoLabel = s Then
                isValue = False
				if labelName="a" and parentName="href" and instr(action,"|处理A链接|")>0 then
					'处理
					if instr(valueStr,"?")>0 then
						valueStr=replace(valueStr,"?","WenHao") & ".html"
					end if
					if instr("|asp|php|aspx|jsp|", "|" & lcase(mid(valueStr,instrrev(valueStr,".")+1)) & "|" )>0 then
						valueStr=valueStr & ".html"
					end if
					valueStr = addToOrAddHttpUrl(addToHttpUrl,valueStr,"替换")
					
				end if
				'call echo("labelName",labelName)
				if yinghaoLabel=" " then		
				    c = c & """" & noDanYinShuangYinStr & valueStr & """ " 			'追加 不是单引号和双引号字符			补全
				else
	                c = c & yinghaoLabel & valueStr & yinghaoLabel 			'追加 不是单引号和双引号字符
				end if
                yinghaoLabel = ""		
				noDanYinShuangYinStr=""						'不是单引号和双引号字符 清空
            Else
                valueStr = valueStr & s
            End If 
        '为 分割
        ElseIf s = " " Then
			'暂存内容不为空
            If temp <> "" Then
				if left(trim(behindStr) & " ",1)="=" then				 
					'后面一个字符等于=不处理
				else
					'为标签
					If isValue = False Then
						 temp = Lcase(temp) & " " 		'标签类型名称转小写
					End If 
					c = c & temp
					temp = "" 
				end if
            End If 
        Else
            temp = temp & s 
        End If
		
    Next 
	c=trim(c)
    htmlLabelToClean = c 
End Function
'追加或替换网址(20150922)   addToOrAddHttpUrl("http://127.0.0.1/aa/","http://127.0.0.1/4.asp","替换")
function addToOrAddHttpUrl(HttpUrl,byval url,action)
	dim s
	action="|"& action &"|"
	if instr(action,"|替换|")>0 then
		s=getwebsite(url)
		if s<>"" then
			url=replace(url,s,"")
		end if
	end if
	if instr(url,httpurl)=false then
		if right(httpurl,1)="/" and (left(url,1)="/" or left(url,1)="\") then
			url=mid(url,2)
		end if
		url = httpurl & url
	end if
	
	addToOrAddHttpUrl=url 
end function
'删除html里空行 最笨的方法 删除空行
function removeBlankLines(content)
	dim s,c,splstr
	splstr=split(content,vbcrlf)
	for each s in splstr
		if replace(replace(s,vbtab,"")," ","")<>"" then
			if c<>"" then c=c & vbcrlf
			c=c & s
		end if
	next
	removeBlankLines=c
end function
function removeBlankLines_test1(content)
	dim i
	for i=1 to 9
		content=replace(content,vbcrlf & vbcrlf,vbcrlf)
	next
	removeBlankLines_test1 = content
end function 
'空网页内容 20160108
Function blankHtmlBody(webTitle,webBody)
    Dim c
    c= "<!DOCTYPE html PUBLIC>" & vbCrlf
    c=c & "<html xmlns=""http://www.w3.org/1999/xhtml"">" & vbCrlf
    c=c & "<head>" & vbCrlf
    c=c & "<meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312"" />" & vbCrlf
    c=c & "<title>"& webTitle &"</title>" & vbCrlf
    c=c & "</head>" & vbCrlf
    c=c & "<body>" & vbCrlf
	c=c & webBody & vbcrlf
    c=c & "</body>" & vbCrlf
    c=c & "</html>" & vbCrlf
    blankHtmlBody=c
End Function 


%>
