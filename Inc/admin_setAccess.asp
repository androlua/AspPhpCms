<% 
'【#stop#】1     这种为不导入当前条数据

'调用callfile_setAccess文件函数
function callfile_setAccess()
    select case request("stype")
        case "backupDatabase" : backupDatabase()                                        '备份数据库
        case "recoveryDatabase" : recoveryDatabase()                                    '恢复数据库


        case else : call eerr("setAccess页里没有动作", request("stype"))
    end select
end function 

'恢复数据库
function recoveryDatabase()
    dim backupDir, backupFilePath 
    dim content, s, splStr, tableName 
    backupDir = adminDir & "/Data/BackUpDateBases/" 
    backupFilePath = backupDir & "/" & request("databaseName") 
    if checkFile(backupFilePath) = false then
        call eerr("数据库文件不存在", backupFilePath) 
    end if 
    content = getftext(backupFilePath) 
    splStr = split(content, "===============================" & vbCrLf) 
    for each s in splStr
        tableName = newGetStrCut(s, "table") 
        if tableName <> "" then
            conn.execute("delete from " & db_PREFIX & tableName) 
            call echo(tableName, importTXTData(s, tableName, "添加")) 
        end if 
    next 



    call echo("恢复数据库完成", "") 
end function 

'备份数据库
function backupDatabase()
    dim isUnifyToFile, tableNameList, databaseTableNameList, fieldConfig, fieldName, fieldType, splField, fieldValue 
    dim splStr, splxx, tableName, s, c, backupDir, backupFilePath 
    tableNameList = lcase(request("tableNameList"))                                 '自定义备份数据表列表
    isUnifyToFile = request("isUnifyToFile")                                        '统一放到一个文件里
    databaseTableNameList = lcase(getTableList()) 

    '处理自定义表列表
    if tableNameList <> "" then
        splStr = split(tableNameList, "|") 
        for each tableName in splStr
            tableName = trim(tableName) 
            if instr(vbCrLf & databaseTableNameList & vbCrLf, vbCrLf & db_PREFIX & tableName & vbCrLf) > 0 then
                if c <> "" then
                    c = c & vbCrLf 
                end if 
                c = c & db_PREFIX & tableName 
            end if 
        next 
        if c = "" then
            call eerr("自定义备份表不正确 <a href=""javascript:history.go(-1)"">点击返回</a>", tableNameList) 
        end if 
        databaseTableNameList = c 
    end if 
    splStr = split(databaseTableNameList, vbCrLf) 
    c = "" 
    for each tableName in splStr
        tableName = trim(tableName) 
        fieldConfig = lcase(getFieldConfigList(tableName)) 
        call echo(tableName, fieldConfig) 
        rs.open "select * from " & tableName, conn, 1, 1 
        c = c & "【table】" & mid(tableName, len(db_PREFIX) + 1) & vbCrLf 
        while not rs.eof
            splField = split(fieldConfig, ",") 
            for each s in splField
                if instr(s, "|") > 0 then
                    splxx = split(s, "|") 
                    fieldName = splxx(0) 
                    fieldType = splxx(1) 
                    fieldValue = rs(fieldName) 
                    if fieldType = "numb" then
                        fieldValue = replace(replace(fieldValue, "True", "1"), "False", "0") 
                    end if 
                    '后台菜单
                    if tableName = db_PREFIX & "listmenu" and fieldName = "parentid" then
                        fieldValue = getListMenuName(fieldValue) 
                    '网站栏目
                    elseif tableName = db_PREFIX & "webcolumn" and fieldName = "parentid" then
                        fieldValue = getColumnName(fieldValue) 
                    end if 
                    if fieldValue <> "" then
                        if instr(fieldValue, vbCrLf) > 0 then
                            fieldValue = fieldValue & "【/" & fieldName & "】" 
                        end if 
                        c = c & "【" & fieldName & "】" & fieldValue & vbCrLf 
                    end if 
                end if 
            next 
            c = c & "-------------------------------" & vbCrLf 
        rs.movenext : wend : rs.close 
        c = c & "===============================" & vbCrLf 
    next 
    backupDir = adminDir & "/Data/BackUpDateBases/" 
    backupFilePath = backupDir & "/" & format_Time(now(), 4) & ".txt" 
    call createDirFolder(backupDir) 
    call deleteFile(backupFilePath)                                                 '删除旧备份文件
    call createfile(backupFilePath, c)                                              '创建备份文件
    call echo("backupDir", backupDir) 
    call echo("backupFilePath", backupFilePath) 
    call rwend("操作完成") 
    call echo("tableNameList", tableNameList) 
    call echo("isUnifyToFile", isUnifyToFile) 
    call echo("databaseTableNameList", databaseTableNameList) 
    call echo("backupDatabase", "backupDatabase") 
    call echo("c", c) 
end function 

'重置数据库数据
sub resetAccessData()
    call handlePower("恢复模板数据")                                                '管理权限处理
    call OpenConn() 
    dim splStr, i, s, columnname, title, nCount, webdataDir 
    webdataDir = request("webdataDir") 
    if webdataDir <> "" then
        if checkFolder(webdataDir) = false then
            call eerr("网站数据目录不存在，恢复默认数据未成功", webdataDir) 
        end if 
    else
        webdataDir = "/Data/WebData/" 
    end if 

    '修改网站配置
    call importTXTData(getftext(webdataDir & "/website.txt"), "website", "修改") 
    call batchImportDirTXTData(webdataDir, db_PREFIX & "WebColumn" & vbCrLf & getTableList()) 		'加webcolumn是因为webcolumn必需新导入数据，因为后台文章类型要从里获得20160711

    call echo("提示", "恢复数据完成") 
    call rw("<hr><a href='../index.asp' target='_blank'>进入首页</a> | <a href=""?"" target='_blank'>进入后台</a>") 



    call writeSystemLog("", "恢复默认数据" & db_PREFIX)                             '系统日志
end sub 

'批量导入相应表信息
function batchImportDirTXTData(webdataDir, tableNameList)
    dim folderPath, tableName, splStr, content, splxx, filePath, fileName, handleTableNameList 
    splStr = split(tableNameList, vbCrLf) 
    for each tableName in splStr
        if tableName <> "" then
            if db_PREFIX <> "" then
                tableName = mid(tableName, len(db_PREFIX) + 1) 
            end if 
            tableName = trim(lcase(tableName)) 
            '判断表 不重复操作
            if instr("|" & handleTableNameList & "|", "|" & tableName & "|") = false then
                handleTableNameList = handleTableNameList & tableName & "|" 

                folderPath = handlePath(webdataDir & "/" & tableName) 
                if checkFolder(folderPath) = true then
                    conn.execute("delete from " & db_PREFIX & tableName)                            '删除当前表全部数据
                    call echo("tableName", tableName) 
                    content = getDirAllFileList(folderPath, "txt") 
                    splxx = split(content, vbCrLf) 
                    for each filePath in splxx
                        fileName = getFileName(filePath) 
                        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
                            call echo(tableName, filePath) 
                            call importTXTData(getftext(filePath), tableName, "添加") 
                            doevents 
                        end if 
                    next 
                end if 
            end if 
        end if 
    next 
end function 

'导入数数
function importTXTData(content, tableName, sType)
    dim fieldConfigList, splList, listStr, splStr, splxx, s, sql, nOK 
    dim fieldName, fieldType, fieldValue, addFieldList, addValueList, updateValueList 
    dim fieldStr 
    tableName = trim(lcase(tableName))                                              '表
    '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
    if instr(content, vbCrLf) = false then
        content = replace(content, chr(10), vbCrLf) 
    end if 
    fieldConfigList = lcase(getFieldConfigList(db_PREFIX & tableName)) 
    splStr = split(fieldConfigList, ",") 
    splList = split(content, vbCrLf & "-------------------------------") 
    nOK = 0 
    for each listStr in splList
        addFieldList = ""                                                               '添加字段列表清空
        addValueList = ""                                                               '添加字段列表值
        updateValueList = ""                                                            '修改字段列表
		
		s = lcase(newGetStrCut(listStr, "#stop#"))
		if s<>"1" and s<>"true" then
			
			for each fieldStr in splStr
				if fieldStr <> "" then
					splxx = split(fieldStr, "|") 
					fieldName = splxx(0) 
					fieldType = splxx(1) 
					if instr(listStr, "【" & fieldName & "】") > 0 then
						listStr = listStr & vbCrLf                                                      '加个换行是为了让最后一个参数能添加进去 20160629
						if addFieldList <> "" then
							addFieldList = addFieldList & "," 
							addValueList = addValueList & "," 
							updateValueList = updateValueList & "," 
						end if 
						addFieldList = addFieldList & fieldName 
	
						fieldValue = newGetStrCut(listStr, fieldName) 
						if fieldType = "textarea" then
							fieldValue = contentTranscoding(fieldValue) 
						end if 
						'call echo(tableName,fieldName)
						'文章大类
						if(tableName = "articledetail" or tableName = "webcolumn") and fieldName = "parentid" then
							'call echo(tableName,fieldName) 
							'call echo("fieldValue",fieldValue) 
							fieldValue = getColumnId(fieldValue)
							'call echo("fieldValue",fieldValue) 
						'后台菜单
						elseif tableName = "listmenu" and fieldName = "parentid" then
							fieldValue = getListMenuId(fieldValue) 
						end if 
						if fieldType = "date" and fieldValue = "" then
							fieldValue = date() 
						elseif(fieldType = "time" or fieldType = "now") and fieldValue = "" then
							fieldValue = now() 
						end if 
						if fieldType <> "yesno" and fieldType <> "numb" then
							fieldValue = "'" & fieldValue & "'" 
						'默认数值类型为0
						elseif fieldValue = "" then
							fieldValue = 0 
						end if 
	
						addValueList = addValueList & fieldValue                                        '添加值
						updateValueList = updateValueList & fieldName & "=" & fieldValue                '修改值
					end if 
				end if 
			next
			'字段列表为空 则退出
			if addFieldList = "" then
				importTXTData = nOK 
				exit function 
			end if 
	
			if sType = "修改" then
				sql = "update " & db_PREFIX & "" & tableName & " set " & updateValueList 
			else
				sql = "insert into " & db_PREFIX & "" & tableName & " (" & addFieldList & ") values(" & addValueList & ")" 
			end if 
			'检测SQL
			if checksql(sql) = false then
				call eerr("出错提示", "<hr>sql=" & sql & "<br>") 
			end if 
			nOK = nOK + 1  
		end if

    next 
    importTXTData = nOK 
    'call echo("sql",sql)
    'call echo("addFieldList",addFieldList)
'call echo("updateValueList",updateValueList)
end function 
'新的截取字符20160216
function newGetStrCut(content, title)
    dim s 
    '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
    if instr(content, vbCrLf) = false then
        content = replace(content, chr(10), vbCrLf) 
    end if 
    if inStr(content, "【/" & title & "】") > 0 then
        s = aDSql(phptrim(getStrCut(content, "【" & title & "】", "【/" & title & "】", 0))) 
    else
        s = aDSql(phptrim(getStrCut(content, "【" & title & "】", vbCrLf, 0))) 
    end if 
    newGetStrCut = s 
end function 

'内容转码
function contentTranscoding(byVal content)
    content = replace(replace(replace(replace(content, "<?", "&lt;?"), "?>", "?&gt;"), "<" & "%", "&lt;%"), "?>", "%&gt;") 


    dim splStr, i, s, c, isTranscoding, isBR 
    isTranscoding = false 
    isBR = false 
    splStr = split(content, vbCrLf) 
    for each s in splStr
        if inStr(s, "[&html转码&]") > 0 then
            isTranscoding = true 
        end if 
        if inStr(s, "[&html转码end&]") > 0 then
            isTranscoding = false 
        end if 
        if inStr(s, "[&全部换行&]") > 0 then
            isBR = true 
        end if 
        if inStr(s, "[&全部换行end&]") > 0 then
            isBR = false 
        end if 

        if isTranscoding = true then
            s = replace(replace(s, "[&html转码&]", ""), "<", "&lt;") 
        else
            s = replace(s, "[&html转码end&]", "") 
        end if 
        if isBR = true then
            s = replace(s, "[&全部换行&]", "") 
            if right(trim(s), 8) <> "【《】/div>" then
                s = s & "<br>" 
            end if 
        else
            s = replace(s, "[&全部换行end&]", "") 
        end if 
        '标签样式超简单添加 20160628
        if instr(s, "【article_lable】") > 0 then
            s = replace(s, "【article_lable】", "") 
            s = "<div class=""article_lable"">" & s & "</div>" 
        elseif instr(s, "【article_blockquote】") > 0 then
            s = replace(s, "【article_blockquote】", "") 
            s = "<div class=""article_blockquote"">" & s & "</div>" 
        end if 


        if c <> "" then
            c = c & vbCrLf 
        end if 
        c = c & s 
    next 
    c = replace(replace(c, "【b】", "<b>"), "【/b】", "</b>") 
    c = replace(c, "【《】", "<") 

    c = replace(replace(c, "【strong】", "<strong>"), "【/strong】", "</strong>") 
    contentTranscoding = c 
end function 



'重置数据库数据
sub resetAccessData_temp()

    call handlePower("恢复模板数据")                                                '管理权限处理

    call OpenConn() 
    dim splStr, i, s, columnname, title, nCount, webdataDir 
    webdataDir = request("webdataDir") 
    if webdataDir <> "" then
        if checkFolder(webdataDir) = false then
            call eerr("网站数据目录不存在，恢复默认数据未成功", webdataDir) 
        end if 
    else
        webdataDir = "/Data/WebData/" 
    end if 

    call echo("提示", "恢复数据完成") 
    call rw("<hr><a href='../index.asp' target='_blank'>进入首页</a> | <a href=""?"" target='_blank'>进入后台</a>") 

    dim content, filePath, parentid, author, adddatetime, fileName, bodycontent, webtitle, webkeywords, webdescription, sortrank, labletitle, target 
    dim websitebottom, webTemplate, webimages, webcss, webjs, flags, websiteurl, splxx, columntype, relatedtags, npagesize, customaurl, nofollow 
    dim templatepath, isthrough, titlecolor 
    dim showreason, ncomputersearch, nmobliesearch, ncountsearch, ndegree           '竞价表
    dim displaytitle, aboutcontent, isonhtml                                        '单页表
    dim columnenname                                                                '导航表
    dim smallimage, bigImage, bannerimage                                           '文章表
    dim httpurl, price, morepageurl, charset, thispage, countpage, bigClassName, startStr, endStr, startaddstr, endaddstr, sType, saction, fieldName, fieldcheck 

    '网站配置
    content = getftext(webdataDir & "/website.txt") 
    '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
    if instr(content, vbCrLf) = false then
        content = replace(content, chr(10), vbCrLf) 
    end if 
    if content <> "" then
        webtitle = newGetStrCut(content, "webtitle") 
        webkeywords = newGetStrCut(content, "webkeywords") 
        webdescription = newGetStrCut(content, "webdescription") 
        websitebottom = newGetStrCut(content, "websitebottom") 
        webTemplate = newGetStrCut(content, "webtemplate") 
        webimages = newGetStrCut(content, "webimages") 
        webcss = newGetStrCut(content, "webcss") 
        webjs = newGetStrCut(content, "webjs") 
        flags = newGetStrCut(content, "flags") 
        websiteurl = newGetStrCut(content, "websiteurl") 

        if getRecordCount(db_PREFIX & "website", "") = 0 then
            conn.execute("insert into " & db_PREFIX & "website(webtitle) values('测试')") 
        end if 

        conn.execute("update " & db_PREFIX & "website  set webtitle='" & webtitle & "',webkeywords='" & webkeywords & "',webdescription='" & webdescription & "',websitebottom='" & websitebottom & "',webtemplate='" & webTemplate & "',webimages='" & webimages & "',webcss='" & webcss & "',webjs='" & webjs & "',flags='" & flags & "',websiteurl='" & websiteurl & "'") 
    end if 

    '导航
    conn.execute("delete from " & db_PREFIX & "webcolumn") 
    content = getDirTxtList(webdataDir & "/webcolumn/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("导航", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【webtitle】") > 0 then
                    s = s & vbCrLf 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 
                    customaurl = newGetStrCut(s, "customaurl") 

                    sortrank = newGetStrCut(s, "sortrank") 
                    if sortrank = "" then sortrank = 0 
                    fileName = newGetStrCut(s, "filename") 
                    columnname = newGetStrCut(s, "columnname") 
                    columnenname = newGetStrCut(s, "columnenname") 
                    columntype = newGetStrCut(s, "columntype") 
                    flags = newGetStrCut(s, "flags") 
                    parentid = newGetStrCut(s, "parentid") 

                    parentid = phptrim(getColumnId(parentid))                                       '可根据栏目名称找到对应ID   不存在为-1
                    'call echo("parentid",parentid)
                    labletitle = newGetStrCut(s, "labletitle") 
                    '每页显示条数
                    npagesize = newGetStrCut(s, "npagesize") 
                    if npagesize = "" then npagesize = 10                                           '默认分页数为10条

                    target = newGetStrCut(s, "target") 

                    smallimage = newGetStrCut(s, "smallimage") 
                    bigImage = newGetStrCut(s, "bigImage") 
                    bannerimage = newGetStrCut(s, "bannerimage") 

                    templatepath = newGetStrCut(s, "templatepath") 


                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 
                    '是否启用生成html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    if isonhtml = "0" or lCase(isonhtml) = "false" then
                        isonhtml = 0 
                    else
                        isonhtml = 1 
                    end if 
                    '是否为nofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    if nofollow = "1" or lCase(nofollow) = "true" then
                        nofollow = 1 
                    else
                        nofollow = 0 
                    end if 
                    'call echo(columnname,nofollow)


                    aboutcontent = newGetStrCut(s, "aboutcontent") 
                    aboutcontent = contentTranscoding(aboutcontent) 

                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 

                    conn.execute("insert into " & db_PREFIX & "webcolumn (webtitle,webkeywords,webdescription,columnname,columnenname,columntype,sortrank,filename,customaurl,flags,parentid,labletitle,aboutcontent,bodycontent,npagesize,isonhtml,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values('" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & columnname & "','" & columnenname & "','" & columntype & "'," & sortrank & ",'" & fileName & "','" & customaurl & "','" & flags & "'," & parentid & ",'" & labletitle & "','" & aboutcontent & "','" & bodycontent & "'," & npagesize & "," & isonhtml & "," & nofollow & ",'" & target & "','" & smallimage & "','" & bigImage & "','" & bannerimage & "','" & templatepath & "')") 
                end if 
            next 
        end if 
    next 

    '文章
    conn.execute("delete from " & db_PREFIX & "articledetail") 
    content = getDirAllFileList(webdataDir & "/articledetail/", "txt") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("文章", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【title】") > 0 then
                    s = s & vbCrLf 
                    parentid = newGetStrCut(s, "parentid") 
                    parentid = getColumnId(parentid) 
                    title = newGetStrCut(s, "title") 
                    titlecolor = newGetStrCut(s, "titlecolor") 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 


                    author = newGetStrCut(s, "author") 
                    sortrank = newGetStrCut(s, "sortrank") 
                    if sortrank = "" then sortrank = 0 
                    adddatetime = newGetStrCut(s, "adddatetime") 
                    fileName = newGetStrCut(s, "filename") 
                    templatepath = newGetStrCut(s, "templatepath") 
                    flags = newGetStrCut(s, "flags") 
                    relatedtags = newGetStrCut(s, "relatedtags") 

                    customaurl = newGetStrCut(s, "customaurl") 
                    target = newGetStrCut(s, "target") 


                    smallimage = newGetStrCut(s, "smallimage") 
                    bigImage = newGetStrCut(s, "bigImage") 
                    bannerimage = newGetStrCut(s, "bannerimage") 
                    labletitle = newGetStrCut(s, "labletitle") 

                    aboutcontent = newGetStrCut(s, "aboutcontent") 
                    aboutcontent = contentTranscoding(aboutcontent) 

                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 
                    '是否启用生成html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    if isonhtml = "0" or lCase(isonhtml) = "false" then
                        isonhtml = 0 
                    else
                        isonhtml = 1 
                    end if 
                    '是否为nofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    if nofollow = "1" or lCase(nofollow) = "true" then
                        nofollow = 1 
                    else
                        nofollow = 0 
                    end if 

                    '价格
                    price = getDianNumb(newGetStrCut(s, "price")) 
                    if price = "" then
                        price = 0 
                    end if 
                    conn.execute("insert into " & db_PREFIX & "articledetail (parentid,title,titlecolor,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,aboutcontent,bodycontent,updatetime,isonhtml,customaurl,nofollow,target,smallimage,bigImage,bannerimage,templatepath,labletitle,price) values(" & parentid & ",'" & title & "','" & titlecolor & "','" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & author & "'," & sortrank & ",'" & adddatetime & "','" & fileName & "','" & flags & "','" & relatedtags & "','" & aboutcontent & "','" & bodycontent & "','" & now() & "'," & isonhtml & ",'" & customaurl & "'," & nofollow & ",'" & target & "','" & smallimage & "','" & bigImage & "','" & bannerimage & "','" & templatepath & "','" & labletitle & "'," & price & ")") 
                end if 
            next 
        end if 
    next 

    '单页
    conn.execute("delete from " & db_PREFIX & "OnePage") 
    content = getDirTxtList(webdataDir & "/OnePage/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("单页", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【webkeywords】") > 0 then
                    s = s & vbCrLf 
                    title = newGetStrCut(s, "title") 
                    displaytitle = newGetStrCut(s, "displaytitle") 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 



                    adddatetime = newGetStrCut(s, "adddatetime") 
                    fileName = newGetStrCut(s, "filename") 

                    aboutcontent = newGetStrCut(s, "aboutcontent") 

                    aboutcontent = contentTranscoding(aboutcontent) 
                    target = newGetStrCut(s, "target") 
                    templatepath = newGetStrCut(s, "templatepath") 

                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 
                    '是否启用生成html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    if isonhtml = "0" or lCase(isonhtml) = "false" then
                        isonhtml = 0 
                    else
                        isonhtml = 1 
                    end if 
                    '是否为nofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    if nofollow = "1" or lCase(nofollow) = "true" then
                        nofollow = 1 
                    else
                        nofollow = 0 
                    end if 


                    conn.execute("insert into " & db_PREFIX & "onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,aboutcontent,bodycontent,nofollow,target,templatepath) values('" & title & "','" & displaytitle & "','" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & adddatetime & "','" & fileName & "'," & isonhtml & ",'" & aboutcontent & "','" & bodycontent & "'," & nofollow & ",'" & target & "','" & templatepath & "')") 
                end if 
            next 
        end if 
    next 

    '竞价
    conn.execute("delete from " & db_PREFIX & "Bidding") 
    content = getDirTxtList(webdataDir & "/Bidding/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("竞价", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【webkeywords】") > 0 then
                    s = s & vbCrLf 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    showreason = newGetStrCut(s, "showreason") 
                    ncomputersearch = newGetStrCut(s, "ncomputersearch") 
                    nmobliesearch = newGetStrCut(s, "nmobliesearch") 
                    ncountsearch = newGetStrCut(s, "ncountsearch") 
                    ndegree = newGetStrCut(s, "ndegree") 
                    ndegree = getnumber(ndegree) 
                    if ndegree = "" then
                        ndegree = 0 
                    end if 
                    conn.execute("insert into " & db_PREFIX & "Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values('" & webkeywords & "','" & showreason & "'," & ncomputersearch & "," & nmobliesearch & "," & ndegree & ")") 
                end if 
            next 
        end if 
    next 

    '搜索统计
    conn.execute("delete from " & db_PREFIX & "SearchStat") 
    content = getDirTxtList(webdataDir & "/SearchStat/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("搜索统计", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【title】") > 0 then
                    s = s & vbCrLf 
                    title = newGetStrCut(s, "title") 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 

                    customaurl = newGetStrCut(s, "customaurl") 
                    target = newGetStrCut(s, "target") 
                    isthrough = newGetStrCut(s, "isthrough") 
                    if isthrough = "0" or lCase(isthrough) = "false" then
                        isthrough = 0 
                    else
                        isthrough = 1 
                    end if 
                    sortrank = newGetStrCut(s, "sortrank") 
                    if sortrank = "" then sortrank = 0 
                    '是否启用生成html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    if isonhtml = "0" or lCase(isonhtml) = "false" then
                        isonhtml = 0 
                    else
                        isonhtml = 1 
                    end if 
                    '是否为nofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    if nofollow = "1" or lCase(nofollow) = "true" then
                        nofollow = 1 
                    else
                        nofollow = 0 
                    end if 
                    'call echo("title",title)
                    conn.execute("insert into " & db_PREFIX & "SearchStat (title,webtitle,webkeywords,webdescription,customaurl,target,isthrough,sortrank,isonhtml,nofollow) values('" & title & "','" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & customaurl & "','" & target & "'," & isthrough & "," & sortrank & "," & isonhtml & "," & nofollow & ")") 

                end if 
            next 
        end if 
    next 
    dim itemid, userName, ip, reply, tableName                                      '评论
    '评论
    conn.execute("delete from " & db_PREFIX & "TableComment") 
    content = getDirTxtList(webdataDir & "/TableComment/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("评论", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【title】") > 0 then
                    s = s & vbCrLf 

                    tableName = newGetStrCut(s, "tablename") 
                    title = newGetStrCut(s, "title") 
                    itemid = getArticleId(newGetStrCut(s, "itemid")) 
                    if itemid = "" then itemid = 0 
                    'call echo("itemID",itemID)
                    adddatetime = newGetStrCut(s, "adddatetime") 
                    userName = newGetStrCut(s, "username") 
                    ip = newGetStrCut(s, "ip") 
                    bodycontent = newGetStrCut(s, "bodycontent") 
                    reply = newGetStrCut(s, "reply") 



                    isthrough = newGetStrCut(s, "isthrough") 
                    if isthrough = "0" or lCase(isthrough) = "false" then
                        isthrough = 0 
                    else
                        isthrough = 1 
                    end if 

                    'call echo("title",title)
                    conn.execute("insert into " & db_PREFIX & "TableComment (tablename,title,itemid,adddatetime,username,ip,bodycontent,reply,isthrough) values('" & tableName & "','" & title & "'," & itemid & ",'" & adddatetime & "','" & userName & "','" & ip & "','" & bodycontent & "','" & reply & "'," & isthrough & ")") 

                end if 
            next 
        end if 
    next 

    '友情链接
    conn.execute("delete from " & db_PREFIX & "FriendLink") 
    content = getDirTxtList(webdataDir & "/FriendLink/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("评论", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【title】") > 0 then
                    s = s & vbCrLf 

                    title = newGetStrCut(s, "title") 
                    httpurl = newGetStrCut(s, "httpurl") 
                    smallimage = newGetStrCut(s, "smallimage") 
                    flags = newGetStrCut(s, "flags") 
                    target = newGetStrCut(s, "target") 


                    sortrank = newGetStrCut(s, "sortrank") 
                    if sortrank = "0" or lCase(sortrank) = "false" then
                        sortrank = 0 
                    else
                        sortrank = 1 
                    end if 
                    isthrough = newGetStrCut(s, "isthrough") 
                    if isthrough = "0" or lCase(isthrough) = "false" then
                        isthrough = 0 
                    else
                        isthrough = 1 
                    end if 
                    'call echo("title",title)
                    conn.execute("insert into " & db_PREFIX & "FriendLink (title,httpurl,smallimage,flags,sortrank,isthrough,target) values('" & title & "','" & httpurl & "','" & smallimage & "','" & flags & "'," & sortrank & "," & isthrough & ",'" & target & "')") 

                end if 
            next 
        end if 
    next 

    '留言
    conn.execute("delete from " & db_PREFIX & "GuestBook") 
    content = getDirTxtList(webdataDir & "/GuestBook/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("留言", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【adddatetime】") > 0 then
                    s = s & vbCrLf 

                    adddatetime = newGetStrCut(s, "adddatetime") 
                    bodycontent = newGetStrCut(s, "bodycontent") 
                    reply = newGetStrCut(s, "reply") 
                    isthrough = newGetStrCut(s, "isthrough") 
                    if isthrough = "0" or lCase(isthrough) = "false" then
                        isthrough = 0 
                    else
                        isthrough = 1 
                    end if 
                    conn.execute("insert into " & db_PREFIX & "GuestBook (adddatetime,bodycontent,reply,isthrough) values('" & adddatetime & "','" & bodycontent & "','" & reply & "'," & isthrough & ")") 

                end if 
            next 
        end if 
    next 


    '采集网站
    conn.execute("delete from " & db_PREFIX & "CaiWeb") 
    content = getDirTxtList(webdataDir & "/CaiWeb/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("采集网站", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【bigclassname】") > 0 then
                    s = s & vbCrLf 


                    bigClassName = newGetStrCut(s, "bigclassname") 
                    httpurl = newGetStrCut(s, "httpurl") 
                    morepageurl = newGetStrCut(s, "morepageurl") 
                    charset = newGetStrCut(s, "charset") 


                    adddatetime = newGetStrCut(s, "adddatetime") 
                    bodycontent = newGetStrCut(s, "bodycontent") 

                    sortrank = newGetStrCut(s, "sortrank") 
                    if sortrank = "" then sortrank = 0 

                    thispage = newGetStrCut(s, "thispage") 
                    if thispage = "" then thispage = 0 
                    countpage = newGetStrCut(s, "countpage") 
                    if countpage = "" then thispage = 0 

                    columnname = newGetStrCut(s, "columnname") 



                    conn.execute("insert into " & db_PREFIX & "CaiWeb (adddatetime,bodycontent,httpurl,morepageurl,charset,sortrank,thispage,countpage,bigclassname,columnname) values('" & adddatetime & "','" & bodycontent & "','" & httpurl & "','" & morepageurl & "','" & charset & "'," & sortrank & "," & thispage & "," & countpage & ",'" & bigClassName & "','" & columnname & "')") 

                end if 
            next 
        end if 
    next 


    '采集配置
    conn.execute("delete from " & db_PREFIX & "CaiConfig") 
    content = getDirTxtList(webdataDir & "/CaiConfig/") 
    content = contentNameSort(content, "") 
    splStr = split(content, vbCrLf) 
    call hr() 
    for each filePath in splStr
        fileName = getfilename(filePath) 
        if filePath <> "" and inStr("_#", left(fileName, 1)) = false then
            call echo("采集配置", filePath) 
            content = getftext(filePath) 
            '这样做是为了从GitHub下载时它把vbcrlf转成 chr(10)  20160409
            if instr(content, vbCrLf) = false then
                content = replace(content, chr(10), vbCrLf) 
            end if 
            splxx = split(content, vbCrLf & "-------------------------------") 
            for each s in splxx
                if inStr(s, "【bigclassname】") > 0 then
                    s = s & vbCrLf 


                    bigClassName = newGetStrCut(s, "bigclassname") 
                    sType = newGetStrCut(s, "stype") 
                    startStr = newGetStrCut(s, "startstr") 
                    endStr = newGetStrCut(s, "endstr") 
                    startaddstr = newGetStrCut(s, "startaddstr") 
                    endaddstr = newGetStrCut(s, "endaddstr") 

                    adddatetime = newGetStrCut(s, "adddatetime") 
                    sortrank = newGetStrCut(s, "sortrank") 
                    if sortrank = "" then sortrank = 0 
                    saction = newGetStrCut(s, "saction") 
                    isthrough = newGetStrCut(s, "isthrough") 
                    isthrough = IIF(isthrough = "0" or lCase(isthrough) = "false", 0, 1) 

                    fieldName = newGetStrCut(s, "fieldname") 
                    fieldcheck = newGetStrCut(s, "fieldcheck") 
                    if fieldcheck = "" then fieldcheck = 0 


                    conn.execute("insert into " & db_PREFIX & "CaiConfig (adddatetime,sortrank,bigclassname,stype,startstr,endstr,startaddstr,endaddstr,saction,isthrough,fieldname,fieldcheck) values('" & adddatetime & "'," & sortrank & ",'" & bigClassName & "','" & sType & "','" & startStr & "','" & endStr & "','" & startaddstr & "','" & endaddstr & "','" & saction & "'," & isthrough & ",'" & fieldName & "'," & fieldcheck & ")") 

                end if 
            next 
        end if 
    next 


    call writeSystemLog("", "恢复默认数据" & db_PREFIX)                             '系统日志

end sub 

%>    
