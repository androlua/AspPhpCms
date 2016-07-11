<% 
'调用function2文件函数
Function callFunction_cai()
    Select Case Request("stype")
        Case "cai" : cai()                                                     '采集
		case "clearAllData" : cai_clearAllData()								'清除全部数据
		case "importCaiData" : cai_importCaiData()								'导入采集数据
		
        Case "callFunction_cai_test" : callFunction_cai_test()                 '测试
        Case Else : Call eerr("callFunction_cai页里没有动作", Request("stype"))
    End Select
End Function 

'导入采集数据
function cai_importCaiData()								
	dim id,addTableFieldName,addTableFieldValue,sql,i,articleFieldList,selectSql
	dim fieldname,addCount,parentid
	id=request("id")
	sql="select * from " & db_PREFIX & "caidata"
	if id<>"" then
		sql=sql & " where id=" & id		
	end if
	addCount=0
	articleFieldList=getHandleFieldList(db_PREFIX & "articledetail","字段配置列表")
	call echo("articleFieldList",articleFieldList)
    rs.Open sql, conn, 1, 1
	while not rs.eof
		selectSql=""
		parentid=getColumnId(rs("columnname"))
		if parentid<>"" then
			addTableFieldName="parentid"
			addTableFieldValue=parentid
		end if
		for i =1 to 6
			fieldname=lcase(phptrim(rs("fieldname" & i)))
			if fieldname<>"" and instr(articleFieldList,","& fieldname &"|")>0 then
				if addTableFieldName<>"" then
					addTableFieldName=addTableFieldName&","
				end if
				addTableFieldName=addTableFieldName & fieldname
				if selectSql="" then
					selectSql=" where " & fieldname & "=" & handleSqlValue(articleFieldList,fieldname,ADSql(rs("value" & i)))
				end if
				if addTableFieldValue<>"" then
					addTableFieldValue = addTableFieldValue & ","
				end if
				addTableFieldValue=addTableFieldValue & handleSqlValue(articleFieldList,fieldname,ADSql(rs("value" & i)))
			end if
		next
		
		sql="select * from " & db_PREFIX & "articledetail" & selectSql
		rsx.open sql,conn,1,1
		if rsx.eof then
			sql = "insert into " & db_PREFIX & "articledetail (" & addTableFieldName & ") values(" & addTableFieldValue & ")" 
			conn.execute(sql)
			addCount=addCount+1
			'call echo("sql",sql)
			call echo("导入数据成功", addCount)
		end if:rsx.close
		doevents
		'call eerr(addTableFieldName,addTableFieldValue)
	rs.movenext:wend:rs.close
    Call echo("操作完成", "<a href='?act=dispalyManageHandle&actionType=CaiData&addsql=order by id desc&lableTitle=采集数据'>OK</a>") 
end function
'获得sql赋值 文本与数字类型前后加'符号
function handleSqlValue(fieldConfigList,fieldName,valueStr)
	if instr(fieldConfigList,","& fieldName &"|numb|")>0 then
		handleSqlValue=valueStr
	else
		handleSqlValue="'" & valueStr & "'"
	end if
end function
'测试
Function callFunction_cai_test()
    Call echo("测试", "callFunction_cai_test") 
End Function 
'清除全部数据
function cai_clearAllData()
    Call openconn() 
    conn.Execute("delete from " & db_PREFIX & "caidata") 
    Call echo("操作完成", "<a href='?act=dispalyManageHandle&actionType=CaiData&addsql=order by id desc&lableTitle=采集数据'>OK</a>") 
end function
'采集
Function cai()
    Dim dirPath, id, url, i, msg, did 
    Dim httpurl, morePageUrl, Charset, thisPage, countPage, content, tempContent, listData, htmlPath 
    Dim startStr, endStr, startAddStr, endAddStr, splStr, s, s1, c, saction 
    Dim value1, value2, value3, value4, value5, value6, value7, value8, sql, addSql, tempAddSql,sqlFields, sqlValues 
    Dim spl1, spl2, spl3, spl4, spl5, spl6, j,fieldname,fieldcheck,isAdd,addSuccessCount
	dim defaultSqlFields, defaultSqlValues,valueStr,columnname
    id = Request("id") 
    dirPath = handlePath("../cache/cai") 
    Call createDirFolder(dirPath) 
    Call echo(dirPath, webDir) 
    Call openconn() 
	addSuccessCount=0				'追加成功总数
    rs.Open "select * from " & db_PREFIX & "caiweb where id=" & id, conn, 1, 1 
    If Not rs.EOF Then
        did = rs("bigclassname") 
        httpurl = rs("httpurl") 
        morePageUrl = rs("morePageUrl") 
        Charset = rs("charset") 
        thisPage = CInt(rs("thisPage")) 
        countPage = CInt(rs("countPage")) 
		columnname=rs("columnname")			'栏目名称
        For i = thisPage To countPage
            url = getHandleCaiUrl(httpurl, morePageUrl, i) 
            htmlPath = dirPath & "/" & setfileName(url) 
            If checkFile(htmlPath) = False Then
                content = gethttpurl(url, Charset) 
                Call createfile(htmlPath, content) 
                msg = "（从网络读取）" 
            Else
                content = getftext(htmlPath) 
                msg = "（从本地读取）" 
            End If 
            tempContent = content 
            Call echo(i & "/" & countPage & msg, url) 

            rsx.Open "select * from " & db_PREFIX & "caiconfig where bigclassname='" & did & "' and isthrough<>0 order by sortRank", conn, 1, 1 
            value1 = "" : value2 = "" : value3 = "" : value4 = "" : value5 = "" : value6 = "" : value7 = "" : value8 = "" '清空值			
			defaultSqlFields = "bigclassname,isthrough,columnname" 
			defaultSqlValues = "'" & did & "',1,'"& columnname &"'" 
			addsql=""
			
            While Not rsx.EOF
                startStr = rsx("startstr") 
                endStr = rsx("endstr") 
                startAddStr = rsx("startAddStr") 
                endAddStr = rsx("endAddStr") 
                saction = rsx("saction")  
                '追加前面
                If startAddStr = "【startstr】" Then
                    startAddStr = startStr 
                End If 
                '追加后面
                If endAddStr = "【endstr】" Then
                    endAddStr = startStr 
                End If 
                If rsx("stype") = "截取" Then
                    content = startAddStr & getStrCut(content, startStr, endStr, 2) & endAddStr 
                ElseIf rsx("stype") = "分割" Then
                    listData = getArray(content, startStr, endStr, False, False) 
                    listData = startAddStr & Replace(listData, "$Array$", endAddStr & "$Array$" & startAddStr) & endAddStr 
                ElseIf InStr(rsx("stype"), "内容") > 0 Then
                    splStr = Split(listData, "$Array$") 
                    For Each s In splStr 
                        If rsx("stype") = "内容1" Then
                            value1 = setThisFieldValue(saction, value1, s, url, startStr, endStr, startAddStr, endAddStr) 
                        ElseIf rsx("stype") = "内容2" Then
                            value2 = setThisFieldValue(saction, value2, s, url, startStr, endStr, startAddStr, endAddStr) 
                        ElseIf rsx("stype") = "内容3" Then
                            value3 = setThisFieldValue(saction, value3, s, url, startStr, endStr, startAddStr, endAddStr) 
                        ElseIf rsx("stype") = "内容4" Then
                            value4 = setThisFieldValue(saction, value4, s, url, startStr, endStr, startAddStr, endAddStr) 
                        ElseIf rsx("stype") = "内容5" Then
                            value5 = setThisFieldValue(saction, value5, s, url, startStr, endStr, startAddStr, endAddStr) 
                        ElseIf rsx("stype") = "内容6" Then
                            value6 = setThisFieldValue(saction, value6, s, url, startStr, endStr, startAddStr, endAddStr) 
                        End If
						fieldname="fieldname" & replace(rsx("stype") ,"内容","")
						if fieldname<>"" and instr(","& defaultSqlFields &",", "," & fieldname &",")=false then
							defaultSqlFields = defaultSqlFields & "," & fieldname
							defaultSqlValues = defaultSqlValues & ",'" & ADSql(rsx("fieldname")) & "'"
						end if
						'字段检测不为假
						if rsx("fieldcheck")<>0 then
							
							fieldname="value" & replace(rsx("stype") ,"内容","")							
							addsql=fieldname & "='【"& rsx("stype") &"】'"
						end if
                    Next 
                End If 
                Call echo("类型", rsx("stype")) 
            rsx.MoveNext : Wend : rsx.Close  

				spl1 = Split(value1, "$Array$") 
				spl2 = Split(value2, "$Array$") 
				spl3 = Split(value3, "$Array$") 
				spl4 = Split(value4, "$Array$") 
				spl5 = Split(value5, "$Array$") 
				spl6 = Split(value6, "$Array$") 
				For j = 0 To UBound(spl1)
					sqlFields =defaultSqlFields
					sqlValues = defaultSqlValues
					tempAddSql=addsql
					valueStr=ADSql(spl1(j))
					sqlFields = sqlFields & ",value1" 
					sqlValues = sqlValues & ",'" & valueStr & "'" 
					tempAddSql=replace(tempAddSql,"【内容1】",valueStr)
					If UBound(spl2) >= j Then
						valueStr=ADSql(spl2(j))
						sqlFields = sqlFields & ",value2" 
						sqlValues = sqlValues & ",'" & valueStr & "'" 
						tempAddSql=replace(tempAddSql,"【内容2】",valueStr)
					End If 
					If UBound(spl3) >= j Then
						valueStr=ADSql(spl3(j))
						sqlFields = sqlFields & ",value3" 
						sqlValues = sqlValues & ",'" & valueStr & "'" 
						tempAddSql=replace(tempAddSql,"【内容3】",valueStr)
					End If 
					If UBound(spl4) >= j Then
						valueStr=ADSql(spl4(j))
						sqlFields = sqlFields & ",value4" 
						sqlValues = sqlValues & ",'" & valueStr & "'" 
						tempAddSql=replace(tempAddSql,"【内容4】",valueStr)
					End If 
					If UBound(spl5) >= j Then
						valueStr=ADSql(spl5(j))
						sqlFields = sqlFields & ",value5" 
						sqlValues = sqlValues & ",'" & valueStr & "'" 
						tempAddSql=replace(tempAddSql,"【内容5】",valueStr)
					End If 
					If UBound(spl6) >= j Then
						valueStr=ADSql(spl6(j))
						sqlFields = sqlFields & ",value6" 
						sqlValues = sqlValues & ",'" & valueStr & "'" 
						tempAddSql=replace(tempAddSql,"【内容6】",valueStr)
					End If 
					
					
					isAdd=true
					if tempAddSql<>"" then
						sql="select * from " & db_PREFIX & "caidata where " & tempAddSql
						rsx.open sql,conn,1,1
						if not rsx.eof then
							isAdd=false
						end if:rsx.close
					end if
					
					'为真则添加到数据库
					if isAdd=true then
						sql = "insert into " & db_PREFIX & "caiData (" & sqlFields & ") values(" & sqlValues & ")" 
						conn.Execute(sql)
						addSuccessCount=addSuccessCount+1
						call echo("添加成功", addSuccessCount)					
					end if
				Next  
            doevents 
        'die(value1)
        Next 
    End If : rs.Close 

End Function 
'给指定内容赋值
Function setThisFieldValue(saction, ByVal valueName, byref s, url, startStr, endStr, startAddStr, endAddStr)
    Dim s1 
    If valueName <> "" Then
        valueName = valueName & "$Array$" 
    End If 
    s1 = startAddStr & getStrCut(s, startStr, endStr, 2) & endAddStr 
    If saction = "处理成完整网址" Then
        s1 = fullHttpUrl(url, s1) 
    End If 
	s=s1
    setThisFieldValue = valueName & s1 
End Function 
'获得处理后配置网址
Function getHandleCaiUrl(httpurl, morePageUrl, id)
    Dim url 
    id = CStr(id) 
    If id = "1" Then
        If httpurl <> "" Then
            url = httpurl 
        Else
            url = morePageUrl 
        End If 
    Else
        If morePageUrl = "" Then
            url = httpurl 
        Else
            url = morePageUrl 
        End If 
    End If 
    url = Replace(Replace(Replace(Replace(url, "{*}", id), "[*]", id), "{id}", id), "[id]", id) 
    getHandleCaiUrl = url 
End Function 
%> 
