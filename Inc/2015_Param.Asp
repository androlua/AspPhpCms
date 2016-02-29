<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 


'http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList    从这里面获得最新设置



'**************************************** 给php用 通用 ****************************************

'替换参数值 2014  12 01
Function newReplaceValueParam(content, paramName, replaceStr)
    Dim startStr, endStr, labelStr, nLen, nTimeFormat, delHtmlYes, trimYes 
    'ReplaceStr = ReplaceStr & "这里面放上内容在这时碳呀。"
    'ReplaceStr = CStr(ReplaceStr)            '转成字符类型
    If IsNul(replaceStr) = True Then replaceStr = "" 

    startStr = "[$" & paramName : endStr = "$]" 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        labelStr = StrCut(content, startStr, endStr, 1) 
        '删除Html
        delHtmlYes = RParam(labelStr, "DelHtml")                                        '是否删除Html
        If delHtmlYes = "true" Then replaceStr = Replace(DelHtml(replaceStr), "<", "&lt;") 'HTML处理
        '删除两边空格
        trimYes = RParam(labelStr, "Trim")                                              '是否删除两边空格
        If trimYes = "true" Then replaceStr = TrimVbCrlf(replaceStr) 

        '截取字符处理
        nLen = RParam(labelStr, "Len")                                                  '字符长度值
        nLen = HandleNumber(nLen) 
        'If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        If nLen <> "" Then replaceStr = CutStr(replaceStr, nLen, "...")                 'Left(ReplaceStr,nLen)

        '时间处理
        nTimeFormat = RParam(labelStr, "Format_Time")                                   '时间处理值
        If nTimeFormat <> "" Then
            replaceStr = format_Time(replaceStr, nTimeFormat) 
        End If 
        content = Replace(content, labelStr, replaceStr) 

    End If 
    newReplaceValueParam = content 
End Function 

'根据标签找到对应内容
Function newRParam(dataCode, action, ModuleName)
    Dim defaultStr, startStr, endStr 
    defaultStr = RParam(action, ModuleName) 
    startStr = "<!--#" & defaultStr & " start#-->" 
    endStr = "<!--#" & defaultStr & " end#-->" 

    If defaultStr <> "" Then
        '判断是否存在
        If InStr(dataCode, startStr) > 0 And InStr(dataCode, endStr) > 0 Then
            defaultStr = StrCut(dataCode, startStr, endStr, 2) 
        Else
            startStr = "<!--#" & defaultStr 
            endStr = "#-->" 
            If InStr(dataCode, startStr) > 0 And InStr(dataCode, endStr) > 0 Then
                defaultStr = StrCut(dataCode, startStr, endStr, 2) 

            'Call Echo("有","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
            End If 
        End If 
    End If 
    newRParam = defaultStr 
End Function 




'**************************************** 给php用 通用 **************************************** end






'运行全部动作(20150827)
Function getContentAllRunStr(content)
    Dim splStr, s, c 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        s = Replace(Replace(s, Chr(10), ""), Chr(13), "") '奇怪为什么 s里会有 chr(10)与chr(13) 呢？
        c = c & HandleContentCode(s, "") 
    Next 
    getContentAllRunStr = c 
End Function 

'获得内容运行后字符  用法 len(aaaa)  没双引单引
Function getContentRunStr(ByVal content)
    getContentRunStr = HandleContentCode(content, "") 
End Function 
'处理内容里有""，则给它删除掉20150329
'检测内容运行后字符
Function checkContentRunStr(ByVal content)
    checkContentRunStr = HandleContentCode(content, "check") 
End Function 
'处理双引号
Function handleDoubleQuotation(ByVal s)
    Dim NewS 
    NewS = PHPTrim(s) 
    If Left(NewS, 1) = """" And Right(NewS, 1) = """" Then
        s = Mid(NewS, 2, Len(NewS) - 2) 
    End If 
    handleDoubleQuotation = s 
End Function 
'辅助上面
Function strDQ(ByVal s)
    strDQ = handleDoubleQuotation(s) 
End Function 
'处理成数据 20150330
Function handleToArray(content)
    Dim splStr, i 
    content = StrCut(content, "(", ")", 2) 
    'Call Rw(Content)
    splStr = Split(content, ",") 
    'Call Rw("<hr>")
    For i = 0 To UBound(splStr)
        splStr(i) = strDQ(splStr(i)) 
    'Call Echo(I,SplStr(I))
    Next 
    handleToArray = splStr 
End Function 
'处理内容里代码 引擎20150324   http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList  获得最新    version 1.0
Function handleContentCode(ByVal content, sType)
    Dim startStr, endStr, s, YunStr, splStr, splxx, SplContent 
    Dim LabelName                                                                   '标签名称
    Dim nStartStr                                                                   '开始字符

    Dim ContentLCase                                                                '定义内容小写
    ContentLCase = LCase(content)                                                   '内容小写

    If sType = "check" Or sType = "检测" Then
        handleContentCode = False 
    End If 

    'head start
    SplContent = "|printpre|foldingmenu|returnren|returnhr|returnrenhr|showerr|printforminfo|dedecmsmsg|handleaccessdata|adsql|checkaccesspass|checksql|createtable|showistable|getrecordcount|tablecount|opentable|inserttable|" 
    SplContent = SplContent & "|gettabletext|createmdb|deletetable|deletealltable|checktable|existstable|edittable|checkfield|existsfield|editfield|getfieldalt|gettablelist_conn|gettablelist|getfieldlist|getdifferenttablefieldlist|compactdb|" 
    SplContent = SplContent & "|editaccesspassword|handlesqlserver|exporttoexcel|importtodatabase|getdatatablelist|settablefield|gettypestring|getproductrndidlist|getfieldvalue|getconnfieldvalue|setfieldvalue|filebinaryaddaccess|showaccessstream|" 
    SplContent = SplContent & "|gethttppage|handlegethttppage|geturlcontent|gethttpurl|bytestobstr|strcut|getstrcut|cutstr|cutstrnolu|setcuttdstr|cuttdstr|getarraylist|getarray|getarray1|getsplit|getsplitcount|agent|specialhtmluploadencryptiondecrypt|" 
    SplContent = SplContent & "|encaspcontent|uppercaseorlowercase|enccode|deccode|tounicode|japan|japan26|unjapan26|handlehtml|unhandlehtml|lcaseenc|lcasedec|htmltojs|jstohtml|htmltoasp|htmltoaspdim|asptohtml|setfilename|unsetfilename|" 
    SplContent = SplContent & "|htmltoascchr|unhtmltoascchr|variabledisplacement|xorenc|xordec|handleevaladddec|evaladddec|vbevaladddec|xdec|tohexcolor|colorrgb|simpleenc|simpledec|encaspevalrun|send_email|serversend_email|findaspcode|" 
    SplContent = SplContent & "|findaspfunlist|findaspfunctioncode|handlereplacelist|getfunnamedim|leftspace|rightspace|infunadddim|getqq|gettel|getmail|getimgstr|getcssstr|getjsstr|handleaspexecute|geturlstr|getpageconfig|getsqlinurl|" 
    SplContent = SplContent & "|handlsqlinurl|getscanfunctionnamelist|getfunname|getfundimname|getdimname|getsetname|replacedim|replacedim2|findfolderrepeatfunction|findfilerepeatfunction|findcontentrepeatfunction|handlecontentrepeatfunction|" 
    SplContent = SplContent & "|replace2|allreplace|replaceonenolu|optimizeaspcode|aspcodeconfusion|aspvariablegarbled|lucasegarbled|aspfunctionconfusion|getaspfunnamelist|aspcodesafe|cutdakuohao|cutxiankuohao|cutfunctionvvalue|getstrintcontentnumb|" 
    SplContent = SplContent & "|getkeyword|gethandlekeyword|getchinastr|checkstr|regexp_checkstr|existsstr|regexp_instr|regexp_replace|replacecolor|delhtml|regexp_delhtml|getaurltitlelist|getaurl|getatitle|getaurltitle|getcontentaurllist|" 
    SplContent = SplContent & "|regexp_getimgurllist|getimg|getimgjpg|getimggif|getimgbmp|getaspfunctionlist|getaspdimfunction|strlength|regexpgetlenght|stringlength|getcsshref|getjssrc|delhtmlscript|getmeta|delhtmlnote|delhtmlmynote|" 
    SplContent = SplContent & "|getstrimglist|getemaillist|oflink_lcasetag|scripthtml|getregexp|getimgjsurl|regexpgetstr|newgetpingip|getpingip|getpinginfo|regexptest|getregexpstr|regexpreplacecssdir|deletenullrow|isstrtransferred|getbl|" 
    SplContent = SplContent & "|getcountstep|getchina|ischina|checkchina|phprand|phprnd|deleterepeatstr|replacen|fillzero|caseinsensitivereplace|array_sort|handlezipsize|getrnd|mathrandom|getrndaz|getrand|copystrnumb|str_repeat|copystr|" 
    SplContent = SplContent & "|contentaddtab|deleteendstr|tonumber|handlenumber|strdrawint|getfirstnegativenumber|checknumbertype|checkstrisnumbertype|handlenumbertype|getnumber|checknumb|getdiannumb|getcountpage|getpagenumb|getcaihandlecountpage|" 
    SplContent = SplContent & "|getcaisortcountpage|minmaxbetween|getstrfiletype|val|strlen|addindent|getnumberbeforestr|makepassword|rndcode|getrandomphonenumber|lenstr|tostring|remotenumber|handlehavestr|havelowercase|haveuppercase|" 
    SplContent = SplContent & "|havenumber|havechina|saveremotefile|downfile|popupdownfile|xmlgetstatus|xmlpost|utfxmlpost|handlexmlpost|xmlget|handlexmlget|cookiespost|handlecookiespost|getremotefilesize|downremotefile|imagestobase64|" 
    SplContent = SplContent & "|base64toimages|getsqlincontent|handlesqlin|sqlinurl|handlurlcanshu|handlestrcharset|urlencoding|getwinhttp|format_time|getdaystatus|printtimevalue|printasktime|gettimerset|calculationtimer|gettimer|vbgettimer|" 
    SplContent = SplContent & "|vbechotimer|vbruntimer|getthisurlnoparam|getgotourl|getgotourlnoparam|getgotourlnofilename|getip2|getip|getservicerip|getremoteip|handlehttpurl|handlefileurl|handleurlcomplete|urladdhttpurl|webdomain|host|" 
    SplContent = SplContent & "|httphost|gethost|geturl|getthisurl|getthisurlnofilename|getwebsite|checkurl|checkhttpurl|isurl|ishttpurl|fullhttpurl|batchfullhttpurl|urljianjiehandle|urltoasc|getwebtitle|mystrcut|getcontentahref|getcontentimgsrc|" 
    SplContent = SplContent & "|handleconenturl|replacecontentjsdir|handlelink|getendurlhandlename|getwebfoldername|getwebhome|geturllistinwebsitelist|getthisurlfilename|handlewebhtmlimg|handlewebcssimg|batchhandleurlintegrity|replacecontentimagepath|" 
    SplContent = SplContent & "|getcsslinklist|gethtmlbackgroundurllist|getimgurllist|getlinkurl|localurlorremoteurl|checkremoteurl|gethandleurl|webdebug|asailinkadd|asailinkdel|iswww|geturladdtoparam|groupurl|handlepostcookiesparame|" 
    SplContent = SplContent & "|remotehttpurlparameter|checkurlname|handlehttpurlarray|remotejscssparam|handleremotejscssparam|batchhandlehttpurlcomplete|iswebsite|issonwebsite|handleiswebsite|getcontenturllist|handlegetcontenturllist|" 
    SplContent = SplContent & "|getinchain|getfiletext|getftext|getfiletype|checkfile|existsfile|createfile|savefile|createaddfile|createaddupfile|addtofile|savebytefile|createbytefile|movefile|editfile|copyfile|deletefile|delselfile|" 
    SplContent = SplContent & "|delfilelist|batchdelfile|deleteappointfilelist|getfilesize|filesize|getfsize|getfilecreatedate|filecreatedate|getfileeditdate|fileeditdate|getfileedittime|getdatelastaccessed|modifyfilemodifydate|editfileeditdate|" 
    SplContent = SplContent & "|existszhidufile|getfileattribute|editfileattribute|existsfileday|checkfileday|createfolder|createdirfolder|createdomain|createdomainfolder|movefolder|editfolder|copyfolder|deletefolder|getfoldersize|checkfolder|" 
    SplContent = SplContent & "|existsfolder|getfoldercreatedate|getfoldereditdate|getfoldertime|getfolderattribute|editfolderattribute|existsfolderday|checkfolderday|getfilefolderlist|getdirjpglist|getdirinilist|getdirtxtlist|getdirhtmllist|" 
    SplContent = SplContent & "|getdircsslist|getdirjslist|getdirfilelist|getdirhtmllistname|getdirfilenamelist|getdirallfilenamelist|getdirfolderlist|getdirfoldernamelist|getthisallfolder|getthisallfoldername|getfilefoldernumb|getdirfoldernumb|" 
    SplContent = SplContent & "|getdirfoldersize|getdirfilenumb|getdirallfilenumb|getdirallfoldernumb|getfolderlist|getdirfilesort|getdirfoldersort|deldirallfile|deleteallfile|getupdatefile|handlepath|realpath|fullpath|handlerelativepath|" 
    SplContent = SplContent & "|dirname|isobjinstalled|existsobject|getfileobject|getdictionary|getstream|showattributetip|printspacevalue|printspacesize|printfilesize|getdeskpath|createurlshortcut|createfoldershortcut|finddirfilename|" 
    SplContent = SplContent & "|findsubdirfilename|getarticlefillcontent|getfilepathname|getextension|removefiledir|basename|getfileextname|handlefilepatharray|getstrfilename|getfilename|getfileattr|getfileext|getparentpath|isucase|islcase|" 
    SplContent = SplContent & "|checkerr|strtotruefalse|strtruefalsetoint|checkvbcrlf|checkbr|isparity|checkeval|replace_sqltext|chkpost|ismail|isvalidemail|iscode|checknumber|isnumber|checkabc|getlen|checktime|isnul|foundinarr|showhtmlcode|" 
    SplContent = SplContent & "|showhtml|unhtmlcode|echohtml|errortext|testhtml|htmldecode|htmlencode|htmlfilter|regreplace|easp_replace|handlehtmllabelclose|handleimgclose|handlebrclose|handlehrclose|handleclosehtml|htmllabeltoclean|" 
    SplContent = SplContent & "|addtooraddhttpurl|removeblanklines|removeblanklines_test1|blankhtmlbody|checkcode|getfilecharset|seniorcheckcode|readfile|getstext|getftextutf|writetofile|createfileutf|getugtext|checkcontentcharset|checkfilecode|" 
    SplContent = SplContent & "|getfilebinarycontent|binaryreadfile|readbinary|decsavebinary|writebinary|getfilecharset2|bintohex|base64encode|base64decode|asphelptip|handlewrite|jiantitabfanti|jiyicireplace|cireplace|testgetpy|pinyin|" 
    SplContent = SplContent & "|pinyin2|entocompany|remotecontentjinghao|remotearrayjinghao|geteachstraddvalue|getvalueinarrayid|checkvalueinarray|deleterepeatarray|deleterepeatcontent|getarraycount|randomshow|arrayrandomshow|printarray|" 
    SplContent = SplContent & "|echoarray|str_shuffle|characterupset|str_split|removenullvaluearray|removerepeatvaluearray|handlearray|arraytostring|testarraydata|selectsort|quicksort|bubblesort|insertsort|requicksort|arrayreverse|responsearray|" 
    SplContent = SplContent & "|max|min|testtwodimensionalarray|handlesplitarray|twodimensionalarrayasc|twodimensionalarraydesc|csscompression|deletecssnote|uncsscompression|trimvbcrlf|phptrim|ltrimvbcrlf|rtrimvbcrlf|trimvbtab|ltrimvbtab|" 
    SplContent = SplContent & "|rtrimvbtab|gethtmlcssstyle|handlecleancss|removeexcessrow|cssaddtostyle|checkcssstyle|cssstyleaddtoparam|findcssstyle|handlecutcsscode|handlecutdivcode|gethtmlbackgroundimglist|gethandlewebhtmllink|getcsslisturllist|" 
    SplContent = SplContent & "|handlereadcsscontent|handlecsspx|handlehtmlstyle|utf2gb|checkutftogb2312|convchinese|utf8_urlencoding|toutf8|chinese2unicode|isvalidhex|escape|unescape|chinesetounicode|unicodetochinese|urlencode|urldecode|" 
    SplContent = SplContent & "|gbtoutf8|encdecurl|encurl|decurl|infocolor|imgerror|targetstr|atarget|atitle|imgalt|imgtitlealt|arel|styleclass|textfontb|textfontcolor|fontcolorfontb|getdefaultfilename|ahref|imgsrc|selecttarget|selectfontcolor|" 
    SplContent = SplContent & "|selectsex|selectsessioncookies|showselectlist|showarticleliststyle|showarticleinfostyle|handlearticleliststyleorinfostyle|showwebmoduleskins|showradiolist|inputcheckbox|inputcheckbox3|handleinputcheckbox|" 
    SplContent = SplContent & "|inputtext|inputtext2|inputlefttext|inputlefttexthelptextright|inputlefttextcontent|inputrighttextcontent|handleinputleftrighttextcontent|inputleftpasstext|inputleftpasstextcontent|inputhiddentext|inputtextarea|" 
    SplContent = SplContent & "|inputhiddentextarea|handleinputhiddentextarea|showselectdirlist|inputdisabled|inputaddalt|webtitle_inputtextarea|webkeywords_inputtext|webdescription_inputtextarea|foldername_inputtext|filename_inputtext|" 
    SplContent = SplContent & "|templatepath_inputtext|clickpinyinhtmlstr|showfontcolorfontb|showsort|showwebnavtype|showonhtml|showthrough|showrecommend|showonoffimg|newshowonoffimg|controldialogcss|batchdeletetempstr|htmlformatting|" 
    SplContent = SplContent & "|handlehtmlformatting|checkhtmlformatting|newreplacevalueparam|newrparam|getcontentallrunstr|getcontentrunstr|checkcontentrunstr|handledoublequotation|strdq|handletoarray|handlecontentcode|handleinmodule|" 
    SplContent = SplContent & "|clearrparam|atrparam|rparam|handlerparam|getconfigblock|getconfigblock2|getconfigblock3|getcutconfigblock|getconfigcontentblock|getconfigfileblock|setconfigfileblock|delconfigblock|delconfigblock2|delconfigblock3|" 
    SplContent = SplContent & "|delcutconfigblock|getfileparamvalue|setfileparamvalue|handlegetsetfileparamevalue|setrparam|addreplacerparam|deletestrcut|replacecontentmodule|replacecontentrowmodule|handleconfigfile|getrparam|getdefaultvalue|" 
    SplContent = SplContent & "|addmodulereplacearray|modulefindcontent|batchfindfunction|getfindfilefunction|getaspcode|handlegetaspcode|delaspnote|findaspfunction|firstletteruppercase|contentlushow|asptovb|asptovbnet|dimadddefaultvalue|" 
    'head end

    '系统自带 不可删除
    SplContent = SplContent & "|now|date|len|left|right|mid|lcase|ucase|ltrim|rtrim|trim|" 


    splStr = Split(SplContent, "|") 
    For Each LabelName In splStr
        If LabelName <> "" Then
            startStr = LCase(LabelName & "(") : endStr = ")" 
            nStartStr = InStr(" " & ContentLCase, " " & startStr) 
            If nStartStr > 0 And InStr(ContentLCase, endStr) > 0 Then
                If sType = "check" Or sType = "检测" Then
                    handleContentCode = True                 '为检测 有函数  退出
                    Exit Function 
                End If 
                Exit For 
            End If 
        End If 
    Next 
    If LabelName = "" Then
        If sType <> "check" And sType <> "检测" Then
            handleContentCode = content 
        End If 
        Exit Function 
    End If 

    LabelName = LCase(LabelName)                                                    '小写

    startStr = LabelName & "(" : endStr = ")" 
    nStartStr = InStr(ContentLCase, startStr) 
    '记录查的原值，不分大小写
    YunStr = Mid(content, InStr(ContentLCase, startStr)) 
    YunStr = Mid(YunStr, 1, InStrRev(YunStr, endStr)) 

    s = Mid(content, InStr(ContentLCase, startStr) + Len(startStr)) 

    s = Mid(s, 1, InStrRev(s, endStr) - 1) 
    '多次处理 注意和下面的判断
    If checkContentRunStr(content) = True Then
        s = getContentRunStr(s) 
    End If 
    '处理内容里有""，则给它删除掉20150329
    s = handleDoubleQuotation(s) 

    splxx = Split(s & ",1", ",") 

    '-----------------------------------------------------------

    'footer start
    If LabelName = "printpre" Then
        s = printPre(strDQ(s)) 
    ElseIf LabelName = "foldingmenu" Then
        s = foldingMenu(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "returnren" Then
        s = returnRen(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "returnhr" Then
        s = returnHr() 
    ElseIf LabelName = "returnrenhr" Then
        s = returnRenHr() 
    ElseIf LabelName = "showerr" Then
        Call showErr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "printforminfo" Then
        Call printFormInfo() 
    ElseIf LabelName = "dedecmsmsg" Then
        s = dedeCMSMsg() 
    ElseIf LabelName = "handleaccessdata" Then
        s = handleAccessData(strDQ(s)) 
    ElseIf LabelName = "adsql" Then
        s = aDSql(strDQ(s)) 
    ElseIf LabelName = "checkaccesspass" Then
        s = checkAccessPass(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checksql" Then
        s = checkSql(strDQ(s)) 
    ElseIf LabelName = "createtable" Then
        s = createTable(strDQ(s)) 
    ElseIf LabelName = "showistable" Then
        s = showIsTable(strDQ(s)) 
    ElseIf LabelName = "getrecordcount" Then
        s = getRecordCount(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "tablecount" Then
        s = tableCount(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "opentable" Then
        s = openTable(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "inserttable" Then
        s = insertTable(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "gettabletext" Then
        s = getTableText(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "createmdb" Then
        s = createMdb(strDQ(s)) 
    ElseIf LabelName = "deletetable" Then
        s = deleteTable(strDQ(s)) 
    ElseIf LabelName = "deletealltable" Then
        s = deleteAllTable(strDQ(s)) 
    ElseIf LabelName = "checktable" Then
        s = checkTable(strDQ(s)) 
    ElseIf LabelName = "existstable" Then
        s = existsTable(strDQ(s)) 
    ElseIf LabelName = "edittable" Then
        s = editTable(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "checkfield" Then
        s = checkField(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "existsfield" Then
        s = existsField(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "editfield" Then
        s = editField(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getfieldalt" Then
        s = getFieldAlt(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "gettablelist_conn" Then
        s = getTableList_Conn(strDQ(s)) 
    ElseIf LabelName = "gettablelist" Then
        s = getTableList() 
    ElseIf LabelName = "getfieldlist" Then
        s = getFieldList(strDQ(s)) 
    ElseIf LabelName = "getdifferenttablefieldlist" Then
        s = getDifferentTableFieldList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "compactdb" Then
        s = compactDB(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "editaccesspassword" Then
        s = editAccessPassWord(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "handlesqlserver" Then
        s = handleSqlServer(strDQ(s)) 
    ElseIf LabelName = "exporttoexcel" Then
        Call exportToExcel(strDQ(s)) 
    ElseIf LabelName = "importtodatabase" Then
        Call importToDatabase() 
    ElseIf LabelName = "getdatatablelist" Then
        s = getDataTableList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "settablefield" Then
        s = setTableField(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "gettypestring" Then
        s = getTypeString(strDQ(s)) 
    ElseIf LabelName = "getproductrndidlist" Then
        s = getProductRndIdList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getfieldvalue" Then
        s = getFieldValue(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getconnfieldvalue" Then
        s = getConnFieldValue(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "setfieldvalue" Then
        s = setFieldValue(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "filebinaryaddaccess" Then
        s = fileBinaryAddAccess(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5))) 
    ElseIf LabelName = "showaccessstream" Then
        s = showAccessStream(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "gethttppage" Then
        s = getHttpPage(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlegethttppage" Then
        s = handleGetHttpPage(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "geturlcontent" Then
        s = getURLContent(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "gethttpurl" Then
        s = getHttpUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "bytestobstr" Then
        s = bytesToBstr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "strcut" Then
        s = strCut(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "getstrcut" Then
        s = getStrCut(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "cutstr" Then
        s = cutStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "cutstrnolu" Then
        s = cutStrNOLU(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "setcuttdstr" Then
        s = setCutTDStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "cuttdstr" Then
        s = cutTDStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getarraylist" Then
        s = getArrayList(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5))) 
    ElseIf LabelName = "getarray" Then
        s = getArray(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "getarray1" Then
        s = getArray1(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "getsplit" Then
        s = getSplit(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getsplitcount" Then
        s = getSplitCount(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "agent" Then
        s = agent(strDQ(s)) 
    ElseIf LabelName = "specialhtmluploadencryptiondecrypt" Then
        s = specialHtmlUploadEncryptionDecrypt(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "encaspcontent" Then
        s = encAspContent(strDQ(s)) 
    ElseIf LabelName = "uppercaseorlowercase" Then
        s = upperCaseORLowerCase(strDQ(s)) 
    ElseIf LabelName = "enccode" Then
        s = encCode(strDQ(s)) 
    ElseIf LabelName = "deccode" Then
        s = decCode(strDQ(s)) 
    ElseIf LabelName = "tounicode" Then
        s = toUnicode(strDQ(s)) 
    ElseIf LabelName = "japan" Then
        s = japan(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "japan26" Then
        s = japan26(strDQ(s)) 
    ElseIf LabelName = "unjapan26" Then
        s = unJapan26(strDQ(s)) 
    ElseIf LabelName = "handlehtml" Then
        s = handleHTML(strDQ(s)) 
    ElseIf LabelName = "unhandlehtml" Then
        s = unHandleHTML(strDQ(s)) 
    ElseIf LabelName = "lcaseenc" Then
        s = lcaseEnc(strDQ(s)) 
    ElseIf LabelName = "lcasedec" Then
        s = lcaseDec(strDQ(s)) 
    ElseIf LabelName = "htmltojs" Then
        s = htmlToJs(strDQ(s)) 
    ElseIf LabelName = "jstohtml" Then
        s = jsToHtml(strDQ(s)) 
    ElseIf LabelName = "htmltoasp" Then
        s = htmlToAsp(strDQ(s)) 
    ElseIf LabelName = "htmltoaspdim" Then
        s = htmlToAspDim(strDQ(s)) 
    ElseIf LabelName = "asptohtml" Then
        s = aspToHtml(strDQ(s)) 
    ElseIf LabelName = "setfilename" Then
        s = setFileName(strDQ(s)) 
    ElseIf LabelName = "unsetfilename" Then
        s = unSetFileName(strDQ(s)) 
    ElseIf LabelName = "htmltoascchr" Then
        s = HTMLToAscChr(strDQ(s)) 
    ElseIf LabelName = "unhtmltoascchr" Then
        s = unHTMLToAscChr(strDQ(s)) 
    ElseIf LabelName = "variabledisplacement" Then
        s = variableDisplacement(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "xorenc" Then
        s = xorEnc(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "xordec" Then
        s = xorDec(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handleevaladddec" Then
        s = handleEvalAddDec(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "evaladddec" Then
        s = evalAddDec(strDQ(s)) 
    ElseIf LabelName = "vbevaladddec" Then
        s = VBEvalAddDec(strDQ(s)) 
    ElseIf LabelName = "xdec" Then
        s = XDec(strDQ(s)) 
    ElseIf LabelName = "tohexcolor" Then
        s = toHexColor(strDQ(s)) 
    ElseIf LabelName = "colorrgb" Then
        s = colorRGB(strDQ(s)) 
    ElseIf LabelName = "simpleenc" Then
        s = simpleEnc(strDQ(s)) 
    ElseIf LabelName = "simpledec" Then
        s = simpleDec(strDQ(s)) 
    ElseIf LabelName = "encaspevalrun" Then
        s = encAspEvalRun(strDQ(s)) 
    ElseIf LabelName = "send_email" Then
        s = Send_Email(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "serversend_email" Then
        s = ServerSend_Email(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5))) 
    ElseIf LabelName = "findaspcode" Then
        s = FindAspCode(strDQ(s)) 
    ElseIf LabelName = "findaspfunlist" Then
        s = FindAspFunList(strDQ(s)) 
    ElseIf LabelName = "findaspfunctioncode" Then
        s = FindAspFunctionCode(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlereplacelist" Then
        s = handleReplaceList(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getfunnamedim" Then
        s = GetFunNameDim(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "leftspace" Then
        s = LeftSpace(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "rightspace" Then
        s = RightSpace(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "infunadddim" Then
        s = InFunAddDim(strDQ(s)) 
    ElseIf LabelName = "getqq" Then
        s = GetQQ(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "gettel" Then
        s = GetTel(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getmail" Then
        s = GetMail(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getimgstr" Then
        s = GetImgStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getcssstr" Then
        s = GetCssStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getjsstr" Then
        s = GetJsStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "handleaspexecute" Then
        s = HandleAspExecute(strDQ(s)) 
    ElseIf LabelName = "geturlstr" Then
        s = GetUrlStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "getpageconfig" Then
        s = GetPageConfig(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getsqlinurl" Then
        s = GetSqlInUrl(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "handlsqlinurl" Then
        s = HandlSqlInUrl(strDQ(s)) 
    ElseIf LabelName = "getscanfunctionnamelist" Then
        s = GetScanFunctionNameList(strDQ(s)) 
    ElseIf LabelName = "getfunname" Then
        s = GetFunName(strDQ(s)) 
    ElseIf LabelName = "getfundimname" Then
        s = GetFunDimName(strDQ(s)) 
    ElseIf LabelName = "getdimname" Then
        s = GetDimName(strDQ(s)) 
    ElseIf LabelName = "getsetname" Then
        s = GetSetName(strDQ(s)) 
    ElseIf LabelName = "replacedim" Then
        s = ReplaceDim(strDQ(s)) 
    ElseIf LabelName = "replacedim2" Then
        s = ReplaceDim2(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "findfolderrepeatfunction" Then
        s = FindFolderRepeatFunction(strDQ(s)) 
    ElseIf LabelName = "findfilerepeatfunction" Then
        s = FindFileRepeatFunction(strDQ(s)) 
    ElseIf LabelName = "findcontentrepeatfunction" Then
        s = FindContentRepeatFunction(strDQ(s)) 
    ElseIf LabelName = "handlecontentrepeatfunction" Then
        s = HandleContentRepeatFunction(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "replace2" Then
        s = Replace2(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "allreplace" Then
        s = AllReplace(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "replaceonenolu" Then
        s = ReplaceOneNOLU(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "optimizeaspcode" Then
        s = OptimizeAspCode(strDQ(s)) 
    ElseIf LabelName = "aspcodeconfusion" Then
        s = AspCodeConfusion(strDQ(s)) 
    ElseIf LabelName = "aspvariablegarbled" Then
        s = ASPVariableGarbled(strDQ(s)) 
    ElseIf LabelName = "lucasegarbled" Then
        s = LUCaseGarbled(strDQ(s)) 
    ElseIf LabelName = "aspfunctionconfusion" Then
        s = AspFunctionConfusion(strDQ(s)) 
    ElseIf LabelName = "getaspfunnamelist" Then
        s = getAspFunNameList(strDQ(s)) 
    ElseIf LabelName = "aspcodesafe" Then
        s = AspCodeSafe(strDQ(s)) 
    ElseIf LabelName = "cutdakuohao" Then
        s = cutDaKuoHao(strDQ(s)) 
    ElseIf LabelName = "cutxiankuohao" Then
        s = cutXianKuoHao(strDQ(s)) 
    ElseIf LabelName = "cutfunctionvvalue" Then
        s = cutFunctionvValue(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getstrintcontentnumb" Then
        s = getStrIntContentNumb(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getkeyword" Then
        s = GetKeyWord(strDQ(s)) 
    ElseIf LabelName = "gethandlekeyword" Then
        s = GetHandleKeyWord(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getchinastr" Then
        s = GetChinaStr(strDQ(s)) 
    ElseIf LabelName = "checkstr" Then
        s = checkStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "regexp_checkstr" Then
        s = regExp_CheckStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "existsstr" Then
        s = existsStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "regexp_instr" Then
        s = regExp_Instr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "regexp_replace" Then
        s = regExp_Replace(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "replacecolor" Then
        s = replaceColor(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "delhtml" Then
        s = delHtml(strDQ(s)) 
    ElseIf LabelName = "regexp_delhtml" Then
        s = regExp_DelHtml(strDQ(s)) 
    ElseIf LabelName = "getaurltitlelist" Then
        s = getAUrlTitleList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getaurl" Then
        s = getAURL(strDQ(s)) 
    ElseIf LabelName = "getatitle" Then
        s = getATitle(strDQ(s)) 
    ElseIf LabelName = "getaurltitle" Then
        s = getAURLTitle(strDQ(s)) 
    ElseIf LabelName = "getcontentaurllist" Then
        s = getContentAUrlList(strDQ(s)) 
    ElseIf LabelName = "regexp_getimgurllist" Then
        s = regExp_GetImgUrlList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getimg" Then
        s = getIMG(strDQ(s)) 
    ElseIf LabelName = "getimgjpg" Then
        s = getIMGJpg(strDQ(s)) 
    ElseIf LabelName = "getimggif" Then
        s = getIMGGif(strDQ(s)) 
    ElseIf LabelName = "getimgbmp" Then
        s = getIMGBmp(strDQ(s)) 
    ElseIf LabelName = "getaspfunctionlist" Then
        s = getASPFunctionList(strDQ(s)) 
    ElseIf LabelName = "getaspdimfunction" Then
        s = getASPDimFunction(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "strlength" Then
        s = strLength(strDQ(s)) 
    ElseIf LabelName = "regexpgetlenght" Then
        s = regExpGetLenght(strDQ(s)) 
    ElseIf LabelName = "stringlength" Then
        s = stringLength(strDQ(s)) 
    ElseIf LabelName = "getcsshref" Then
        s = getCssHref(strDQ(s)) 
    ElseIf LabelName = "getjssrc" Then
        s = getJsSrc(strDQ(s)) 
    ElseIf LabelName = "delhtmlscript" Then
        s = delHTMLScript(strDQ(s)) 
    ElseIf LabelName = "getmeta" Then
        s = getMeta(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "delhtmlnote" Then
        s = delHtmlNote(strDQ(s)) 
    ElseIf LabelName = "delhtmlmynote" Then
        s = delHtmlMyNote(strDQ(s)) 
    ElseIf LabelName = "getstrimglist" Then
        s = getStrImgList(strDQ(s)) 
    ElseIf LabelName = "getemaillist" Then
        s = getEMailList(strDQ(s)) 
    ElseIf LabelName = "oflink_lcasetag" Then
        s = oflink_lcasetag(strDQ(s)) 
    ElseIf LabelName = "scripthtml" Then
        s = scriptHtml(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getregexp" Then
        s = getRegExp(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "getimgjsurl" Then
        s = getImgJsUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "regexpgetstr" Then
        s = regExpGetStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "newgetpingip" Then
        s = newGetPingIP(strDQ(s)) 
    ElseIf LabelName = "getpingip" Then
        s = getPingIP(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getpinginfo" Then
        s = getPingInfo(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "regexptest" Then
        s = regExpTest(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getregexpstr" Then
        s = getRegExpStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "regexpreplacecssdir" Then
        s = regExpReplaceCssDir(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deletenullrow" Then
        s = deleteNullRow(strDQ(s)) 
    ElseIf LabelName = "isstrtransferred" Then
        s = isStrTransferred(strDQ(s)) 
    ElseIf LabelName = "getbl" Then
        s = getBL(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getcountstep" Then
        s = getCountStep(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "getchina" Then
        s = getChina(strDQ(s)) 
    ElseIf LabelName = "ischina" Then
        s = isChina(strDQ(s)) 
    ElseIf LabelName = "checkchina" Then
        s = checkChina(strDQ(s)) 
    ElseIf LabelName = "phprand" Then
        s = pHPRand(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "phprnd" Then
        s = pHPRnd(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deleterepeatstr" Then
        s = deleteRepeatStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "replacen" Then
        s = replaceN(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "fillzero" Then
        s = fillZero(strDQ(s)) 
    ElseIf LabelName = "caseinsensitivereplace" Then
        s = caseInsensitiveReplace(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "array_sort" Then
        s = array_Sort(strDQ(s)) 
    ElseIf LabelName = "handlezipsize" Then
        s = handleZipSize(strDQ(s)) 
    ElseIf LabelName = "getrnd" Then
        s = getRnd(strDQ(s)) 
    ElseIf LabelName = "mathrandom" Then
        s = mathRandom() 
    ElseIf LabelName = "getrndaz" Then
        s = getRndAZ(strDQ(s)) 
    ElseIf LabelName = "getrand" Then
        s = getRand(strDQ(s)) 
    ElseIf LabelName = "copystrnumb" Then
        s = copyStrNumb(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "str_repeat" Then
        s = str_Repeat(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "copystr" Then
        s = copyStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "contentaddtab" Then
        s = contentAddTab(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deleteendstr" Then
        s = deleteEndStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "tonumber" Then
        s = toNumber(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlenumber" Then
        s = handleNumber(strDQ(s)) 
    ElseIf LabelName = "strdrawint" Then
        s = strDrawInt(strDQ(s)) 
    ElseIf LabelName = "getfirstnegativenumber" Then
        s = getFirstNegativeNumber(strDQ(s)) 
    ElseIf LabelName = "checknumbertype" Then
        s = checkNumberType(strDQ(s)) 
    ElseIf LabelName = "checkstrisnumbertype" Then
        s = checkStrIsNumberType(strDQ(s)) 
    ElseIf LabelName = "handlenumbertype" Then
        s = handleNumberType(strDQ(s)) 
    ElseIf LabelName = "getnumber" Then
        s = getNumber(strDQ(s)) 
    ElseIf LabelName = "checknumb" Then
        s = checkNumb(strDQ(s)) 
    ElseIf LabelName = "getdiannumb" Then
        s = getDianNumb(strDQ(s)) 
    ElseIf LabelName = "getcountpage" Then
        s = getCountPage(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getpagenumb" Then
        s = getPageNumb(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getcaihandlecountpage" Then
        s = getCaiHandleCountPage(strDQ(s)) 
    ElseIf LabelName = "getcaisortcountpage" Then
        s = getCaiSortCountPage(strDQ(s)) 
    ElseIf LabelName = "minmaxbetween" Then
        s = minMaxBetween(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getstrfiletype" Then
        s = getStrFileType(strDQ(s)) 
    ElseIf LabelName = "val" Then
        s = val(strDQ(s)) 
    ElseIf LabelName = "strlen" Then
        s = strLen(strDQ(s)) 
    ElseIf LabelName = "addindent" Then
        s = addIndent(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getnumberbeforestr" Then
        s = getNumberBeforeStr(strDQ(s)) 
    ElseIf LabelName = "makepassword" Then
        s = makePassword(strDQ(s)) 
    ElseIf LabelName = "rndcode" Then
        s = rndcode(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getrandomphonenumber" Then
        s = getRandomPhoneNumber(strDQ(s)) 
    ElseIf LabelName = "lenstr" Then
        s = lenStr(strDQ(s)) 
    ElseIf LabelName = "tostring" Then
        s = toString(strDQ(s)) 
    ElseIf LabelName = "remotenumber" Then
        s = remoteNumber(strDQ(s)) 
    ElseIf LabelName = "handlehavestr" Then
        s = handleHaveStr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "havelowercase" Then
        s = haveLowerCase(strDQ(s)) 
    ElseIf LabelName = "haveuppercase" Then
        s = haveUpperCase(strDQ(s)) 
    ElseIf LabelName = "havenumber" Then
        s = haveNumber(strDQ(s)) 
    ElseIf LabelName = "havechina" Then
        s = haveChina(strDQ(s)) 
    ElseIf LabelName = "saveremotefile" Then
        s = SaveRemoteFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "downfile" Then
        s = DownFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "popupdownfile" Then
        s = popupDownFile(strDQ(s)) 
    ElseIf LabelName = "xmlgetstatus" Then
        s = XMLGetStatus(strDQ(s)) 
    ElseIf LabelName = "xmlpost" Then
        s = XMLPost(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "utfxmlpost" Then
        s = UTFXMLPost(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlexmlpost" Then
        s = HandleXMLPost(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "xmlget" Then
        s = XmlGet(strDQ(s)) 
    ElseIf LabelName = "handlexmlget" Then
        s = handleXmlGet(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "cookiespost" Then
        s = CookiesPost(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlecookiespost" Then
        s = handleCookiesPost(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getremotefilesize" Then
        s = getRemoteFileSize(strDQ(s)) 
    ElseIf LabelName = "downremotefile" Then
        s = DownRemoteFile(strDQ(s)) 
    ElseIf LabelName = "imagestobase64" Then
        s = ImagesToBase64(strDQ(s)) 
    ElseIf LabelName = "base64toimages" Then
        s = Base64ToImages(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getsqlincontent" Then
        s = getSqlInContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handlesqlin" Then
        s = handleSqlIn(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "sqlinurl" Then
        s = SqlInUrl(strDQ(s)) 
    ElseIf LabelName = "handlurlcanshu" Then
        s = HandlUrlCanShu(strDQ(s)) 
    ElseIf LabelName = "handlestrcharset" Then
        s = handleStrCharSet(strDQ(s)) 
    ElseIf LabelName = "urlencoding" Then
        s = URLEncoding(strDQ(s)) 
    ElseIf LabelName = "getwinhttp" Then
        s = getWinHttp(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "format_time" Then
        s = format_Time(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getdaystatus" Then
        s = getDayStatus(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "printtimevalue" Then
        s = printTimeValue(strDQ(s)) 
    ElseIf LabelName = "printasktime" Then
        s = printAskTime(strDQ(s)) 
    ElseIf LabelName = "gettimerset" Then
        s = getTimerSet() 
    ElseIf LabelName = "calculationtimer" Then
        s = calculationTimer(strDQ(s)) 
    ElseIf LabelName = "gettimer" Then
        s = getTimer() 
    ElseIf LabelName = "vbgettimer" Then
        s = vBGetTimer() 
    ElseIf LabelName = "vbechotimer" Then
        s = vBEchoTimer() 
    ElseIf LabelName = "vbruntimer" Then
        s = vBRunTimer(strDQ(s)) 
    ElseIf LabelName = "getthisurlnoparam" Then
        s = getThisUrlNoParam() 
    ElseIf LabelName = "getgotourl" Then
        s = getGoToUrl() 
    ElseIf LabelName = "getgotourlnoparam" Then
        s = getGoToUrlNoParam() 
    ElseIf LabelName = "getgotourlnofilename" Then
        s = getGoToUrlNoFileName() 
    ElseIf LabelName = "getip2" Then
        s = getIP2() 
    ElseIf LabelName = "getip" Then
        s = getIP() 
    ElseIf LabelName = "getservicerip" Then
        s = getServicerIP() 
    ElseIf LabelName = "getremoteip" Then
        s = getRemoteIP() 
    ElseIf LabelName = "handlehttpurl" Then
        s = handleHttpUrl(strDQ(s)) 
    ElseIf LabelName = "handlefileurl" Then
        s = handleFileUrl(strDQ(s)) 
    ElseIf LabelName = "handleurlcomplete" Then
        s = handleUrlComplete(strDQ(s)) 
    ElseIf LabelName = "urladdhttpurl" Then
        s = urlAddHttpUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "webdomain" Then
        s = webDoMain() 
    ElseIf LabelName = "host" Then
        s = host() 
    ElseIf LabelName = "httphost" Then
        s = httpHost() 
    ElseIf LabelName = "gethost" Then
        s = getHost() 
    ElseIf LabelName = "geturl" Then
        s = getUrl() 
    ElseIf LabelName = "getthisurl" Then
        s = getThisUrl() 
    ElseIf LabelName = "getthisurlnofilename" Then
        s = getThisUrlNoFileName() 
    ElseIf LabelName = "getwebsite" Then
        s = getWebSite(strDQ(s)) 
    ElseIf LabelName = "checkurl" Then
        s = checkUrl(strDQ(s)) 
    ElseIf LabelName = "checkhttpurl" Then
        s = checkHttpUrl(strDQ(s)) 
    ElseIf LabelName = "isurl" Then
        s = isUrl(strDQ(s)) 
    ElseIf LabelName = "ishttpurl" Then
        s = isHttpUrl(strDQ(s)) 
    ElseIf LabelName = "fullhttpurl" Then
        s = fullHttpUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "batchfullhttpurl" Then
        s = batchFullHttpUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "urljianjiehandle" Then
        s = uRLJianJieHandle(strDQ(s)) 
    ElseIf LabelName = "urltoasc" Then
        s = urlToAsc(strDQ(s)) 
    ElseIf LabelName = "getwebtitle" Then
        s = getWebTitle(strDQ(s)) 
    ElseIf LabelName = "mystrcut" Then
        s = myStrCut(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "getcontentahref" Then
        s = getContentAHref(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "getcontentimgsrc" Then
        s = getContentImgSrc(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handleconenturl" Then
        s = handleConentUrl(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "replacecontentjsdir" Then
        s = replaceContentJsDir(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handlelink" Then
        s = handleLink(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5)), strDQ(splxx(6))) 
    ElseIf LabelName = "getendurlhandlename" Then
        s = getEndUrlHandleName(strDQ(s)) 
    ElseIf LabelName = "getwebfoldername" Then
        s = getWebFolderName() 
    ElseIf LabelName = "getwebhome" Then
        s = getWebHome() 
    ElseIf LabelName = "geturllistinwebsitelist" Then
        s = getUrlListInWebSiteList(strDQ(s)) 
    ElseIf LabelName = "getthisurlfilename" Then
        s = getThisUrlFileName() 
    ElseIf LabelName = "handlewebhtmlimg" Then
        s = handleWebHtmlImg(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handlewebcssimg" Then
        s = handleWebCssImg(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "batchhandleurlintegrity" Then
        s = batchHandleUrlIntegrity(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "replacecontentimagepath" Then
        s = replaceContentImagePath(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getcsslinklist" Then
        s = getCssLinkList(strDQ(s)) 
    ElseIf LabelName = "gethtmlbackgroundurllist" Then
        s = getHtmlBackGroundUrlList(strDQ(s)) 
    ElseIf LabelName = "getimgurllist" Then
        s = getImgUrlList(strDQ(s)) 
    ElseIf LabelName = "getlinkurl" Then
        s = getLinkUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "localurlorremoteurl" Then
        s = localUrlOrRemoteUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkremoteurl" Then
        s = checkRemoteUrl(strDQ(s)) 
    ElseIf LabelName = "gethandleurl" Then
        s = getHandleUrl(strDQ(s)) 
    ElseIf LabelName = "webdebug" Then
        s = webDebug(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "asailinkadd" Then
        s = asaiLinkAdd(strDQ(s)) 
    ElseIf LabelName = "asailinkdel" Then
        s = asaiLinkDel(strDQ(s)) 
    ElseIf LabelName = "iswww" Then
        s = iswww(strDQ(s)) 
    ElseIf LabelName = "geturladdtoparam" Then
        s = getUrlAddToParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "groupurl" Then
        s = groupUrl(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlepostcookiesparame" Then
        s = handlePostCookiesParame(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "remotehttpurlparameter" Then
        s = remoteHttpUrlParameter(strDQ(s)) 
    ElseIf LabelName = "checkurlname" Then
        s = checkUrlName(strDQ(s)) 
    ElseIf LabelName = "handlehttpurlarray" Then
        s = handleHttpUrlArray(strDQ(s)) 
    ElseIf LabelName = "remotejscssparam" Then
        s = remoteJsCssParam(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handleremotejscssparam" Then
        s = handleRemoteJsCssParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "batchhandlehttpurlcomplete" Then
        s = batchHandleHttpUrlComplete(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "iswebsite" Then
        s = isWebSite(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "issonwebsite" Then
        s = isSonWebSite(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handleiswebsite" Then
        s = handleIsWebSite(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getcontenturllist" Then
        s = getContentUrlList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlegetcontenturllist" Then
        s = handleGetContentUrlList(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getinchain" Then
        s = getInChain(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getfiletext" Then
        s = getFileText(strDQ(s)) 
    ElseIf LabelName = "getftext" Then
        s = getFText(strDQ(s)) 
    ElseIf LabelName = "getfiletype" Then
        s = getFileType(strDQ(s)) 
    ElseIf LabelName = "checkfile" Then
        s = checkFile(strDQ(s)) 
    ElseIf LabelName = "existsfile" Then
        s = existsFile(strDQ(s)) 
    ElseIf LabelName = "createfile" Then
        s = createFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "savefile" Then
        s = saveFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "createaddfile" Then
        s = createAddFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "createaddupfile" Then
        s = createAddUpFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "addtofile" Then
        s = addToFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "savebytefile" Then
        s = saveByteFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "createbytefile" Then
        s = createByteFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "movefile" Then
        s = moveFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "editfile" Then
        s = editFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "copyfile" Then
        s = copyFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deletefile" Then
        s = deleteFile(strDQ(s)) 
    ElseIf LabelName = "delselfile" Then
        s = delSelFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "delfilelist" Then
        s = delFileList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "batchdelfile" Then
        s = batchDelFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deleteappointfilelist" Then
        s = deleteAppointFileList(strDQ(s)) 
    ElseIf LabelName = "getfilesize" Then
        s = getFileSize(strDQ(s)) 
    ElseIf LabelName = "filesize" Then
        s = fileSize(strDQ(s)) 
    ElseIf LabelName = "getfsize" Then
        s = getFSize(strDQ(s)) 
    ElseIf LabelName = "getfilecreatedate" Then
        s = getFileCreateDate(strDQ(s)) 
    ElseIf LabelName = "filecreatedate" Then
        s = fileCreateDate(strDQ(s)) 
    ElseIf LabelName = "getfileeditdate" Then
        s = getFileEditDate(strDQ(s)) 
    ElseIf LabelName = "fileeditdate" Then
        s = fileEditDate(strDQ(s)) 
    ElseIf LabelName = "getfileedittime" Then
        s = getFileEditTime(strDQ(s)) 
    ElseIf LabelName = "getdatelastaccessed" Then
        s = getDateLastAccessed(strDQ(s)) 
    ElseIf LabelName = "modifyfilemodifydate" Then
        s = modifyFileModifydate(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "editfileeditdate" Then
        s = editFileEditDate(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "existszhidufile" Then
        s = existsZhiDuFile(strDQ(s)) 
    ElseIf LabelName = "getfileattribute" Then
        s = getFileAttribute(strDQ(s)) 
    ElseIf LabelName = "editfileattribute" Then
        s = editFileAttribute(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "existsfileday" Then
        s = existsFileDay(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkfileday" Then
        s = checkFileDay(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "createfolder" Then
        s = createFolder(strDQ(s)) 
    ElseIf LabelName = "createdirfolder" Then
        s = createDirFolder(strDQ(s)) 
    ElseIf LabelName = "createdomain" Then
        s = createDomain(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "createdomainfolder" Then
        s = createDomainFolder(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "movefolder" Then
        s = moveFolder(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "editfolder" Then
        s = editFolder(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "copyfolder" Then
        s = copyFolder(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deletefolder" Then
        s = deleteFolder(strDQ(s)) 
    ElseIf LabelName = "getfoldersize" Then
        s = getFolderSize(strDQ(s)) 
    ElseIf LabelName = "checkfolder" Then
        s = checkFolder(strDQ(s)) 
    ElseIf LabelName = "existsfolder" Then
        s = existsFolder(strDQ(s)) 
    ElseIf LabelName = "getfoldercreatedate" Then
        s = getFolderCreateDate(strDQ(s)) 
    ElseIf LabelName = "getfoldereditdate" Then
        s = getFolderEditDate(strDQ(s)) 
    ElseIf LabelName = "getfoldertime" Then
        s = getFolderTime(strDQ(s)) 
    ElseIf LabelName = "getfolderattribute" Then
        s = getFolderAttribute(strDQ(s)) 
    ElseIf LabelName = "editfolderattribute" Then
        s = editFolderAttribute(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "existsfolderday" Then
        s = existsFolderDay(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkfolderday" Then
        s = checkFolderDay(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getfilefolderlist" Then
        s = getFileFolderList(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5)), strDQ(splxx(6))) 
    ElseIf LabelName = "getdirjpglist" Then
        s = getDirJpgList(strDQ(s)) 
    ElseIf LabelName = "getdirinilist" Then
        s = getDirIniList(strDQ(s)) 
    ElseIf LabelName = "getdirtxtlist" Then
        s = getDirTxtList(strDQ(s)) 
    ElseIf LabelName = "getdirhtmllist" Then
        s = getDirHtmlList(strDQ(s)) 
    ElseIf LabelName = "getdircsslist" Then
        s = getDirCssList(strDQ(s)) 
    ElseIf LabelName = "getdirjslist" Then
        s = getDirJsList(strDQ(s)) 
    ElseIf LabelName = "getdirfilelist" Then
        s = getDirFileList(strDQ(s)) 
    ElseIf LabelName = "getdirhtmllistname" Then
        s = getDirHtmlListName(strDQ(s)) 
    ElseIf LabelName = "getdirfilenamelist" Then
        s = getDirFileNameList(strDQ(s)) 
    ElseIf LabelName = "getdirallfilenamelist" Then
        s = getDirAllFileNameList(strDQ(s)) 
    ElseIf LabelName = "getdirfolderlist" Then
        s = getDirFolderList(strDQ(s)) 
    ElseIf LabelName = "getdirfoldernamelist" Then
        s = getDirFolderNameList(strDQ(s)) 
    ElseIf LabelName = "getthisallfolder" Then
        s = getThisAllFolder(strDQ(s)) 
    ElseIf LabelName = "getthisallfoldername" Then
        s = getThisAllFolderName(strDQ(s)) 
    ElseIf LabelName = "getfilefoldernumb" Then
        s = getFileFolderNumb(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getdirfoldernumb" Then
        s = getDirFolderNumb(strDQ(s)) 
    ElseIf LabelName = "getdirfoldersize" Then
        s = getDirFolderSize(strDQ(s)) 
    ElseIf LabelName = "getdirfilenumb" Then
        s = getDirFileNumb(strDQ(s)) 
    ElseIf LabelName = "getdirallfilenumb" Then
        s = getDirAllFileNumb(strDQ(s)) 
    ElseIf LabelName = "getdirallfoldernumb" Then
        s = getDirAllFolderNumb(strDQ(s)) 
    ElseIf LabelName = "getfolderlist" Then
        s = getFolderList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getdirfilesort" Then
        s = getDirFileSort(strDQ(s)) 
    ElseIf LabelName = "getdirfoldersort" Then
        s = getDirFolderSort(strDQ(s)) 
    ElseIf LabelName = "deldirallfile" Then
        Call delDirAllFile(strDQ(s)) 
    ElseIf LabelName = "deleteallfile" Then
        Call deleteAllFile(strDQ(s)) 
    ElseIf LabelName = "getupdatefile" Then
        s = getUpdateFile(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "handlepath" Then
        s = handlePath(strDQ(s)) 
    ElseIf LabelName = "realpath" Then
        s = realPath(strDQ(s)) 
    ElseIf LabelName = "fullpath" Then
        s = fullPath(strDQ(s)) 
    ElseIf LabelName = "handlerelativepath" Then
        s = handleRelativePath(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "dirname" Then
        s = dirName(strDQ(s)) 
    ElseIf LabelName = "isobjinstalled" Then
        s = isObjInstalled(strDQ(s)) 
    ElseIf LabelName = "existsobject" Then
        s = existsObject(strDQ(s)) 
    ElseIf LabelName = "getfileobject" Then
        s = getFileObject() 
    ElseIf LabelName = "getdictionary" Then
        s = getDictionary() 
    ElseIf LabelName = "getstream" Then
        s = getStream() 
    ElseIf LabelName = "showattributetip" Then
        s = showAttributeTip(strDQ(s)) 
    ElseIf LabelName = "printspacevalue" Then
        s = printSpaceValue(strDQ(s)) 
    ElseIf LabelName = "printspacesize" Then
        s = printSpaceSize(strDQ(s)) 
    ElseIf LabelName = "printfilesize" Then
        s = printFileSize(strDQ(s)) 
    ElseIf LabelName = "getdeskpath" Then
        s = getDeskPath() 
    ElseIf LabelName = "createurlshortcut" Then
        s = createUrlShortcut(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "createfoldershortcut" Then
        s = createFolderShortcut(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "finddirfilename" Then
        s = findDirFileName(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "findsubdirfilename" Then
        s = findSubDirFileName(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getarticlefillcontent" Then
        s = getArticleFillContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getfilepathname" Then
        s = getFilePathName(strDQ(s)) 
    ElseIf LabelName = "getextension" Then
        s = getExtension(strDQ(s)) 
    ElseIf LabelName = "removefiledir" Then
        s = removeFileDir(strDQ(s)) 
    ElseIf LabelName = "basename" Then
        s = baseName(strDQ(s)) 
    ElseIf LabelName = "getfileextname" Then
        s = getFileExtName(strDQ(s)) 
    ElseIf LabelName = "handlefilepatharray" Then
        s = handleFilePathArray(strDQ(s)) 
    ElseIf LabelName = "getstrfilename" Then
        s = getStrFileName(strDQ(s)) 
    ElseIf LabelName = "getfilename" Then
        s = getFileName(strDQ(s)) 
    ElseIf LabelName = "getfileattr" Then
        s = getFileAttr(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getfileext" Then
        s = getFileExt(strDQ(s)) 
    ElseIf LabelName = "getparentpath" Then
        s = getParentPath(strDQ(s)) 
    ElseIf LabelName = "isucase" Then
        s = isUCase(strDQ(s)) 
    ElseIf LabelName = "islcase" Then
        s = isLCase(strDQ(s)) 
    ElseIf LabelName = "checkerr" Then
        Call checkErr(strDQ(s)) 
    ElseIf LabelName = "strtotruefalse" Then
        s = strToTrueFalse(strDQ(s)) 
    ElseIf LabelName = "strtruefalsetoint" Then
        s = strTrueFalseToInt(strDQ(s)) 
    ElseIf LabelName = "checkvbcrlf" Then
        s = checkVbCrlf(strDQ(s)) 
    ElseIf LabelName = "checkbr" Then
        s = checkBr(strDQ(s)) 
    ElseIf LabelName = "isparity" Then
        s = isParity(strDQ(s)) 
    ElseIf LabelName = "checkeval" Then
        s = checkEval(strDQ(s)) 
    ElseIf LabelName = "replace_sqltext" Then
        s = replace_SQLText(strDQ(s)) 
    ElseIf LabelName = "chkpost" Then
        s = chkPost() 
    ElseIf LabelName = "ismail" Then
        s = isMail(strDQ(s)) 
    ElseIf LabelName = "isvalidemail" Then
        s = isValidEmail(strDQ(s)) 
    ElseIf LabelName = "iscode" Then
        s = isCode(strDQ(s)) 
    ElseIf LabelName = "checknumber" Then
        s = checkNumber(strDQ(s)) 
    ElseIf LabelName = "isnumber" Then
        s = isNumber(strDQ(s)) 
    ElseIf LabelName = "checkabc" Then
        s = checkABC(strDQ(s)) 
    ElseIf LabelName = "getlen" Then
        s = getLen(strDQ(s)) 
    ElseIf LabelName = "checktime" Then
        s = checkTime(strDQ(s)) 
    ElseIf LabelName = "isnul" Then
        s = isNul(strDQ(s)) 
    ElseIf LabelName = "foundinarr" Then
        s = foundInArr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "showhtmlcode" Then
        s = showHTMLCode(strDQ(s)) 
    ElseIf LabelName = "showhtml" Then
        s = ShowHtml(strDQ(s)) 
    ElseIf LabelName = "unhtmlcode" Then
        s = unHTMLCode(strDQ(s)) 
    ElseIf LabelName = "echohtml" Then
        s = EchoHTML(strDQ(s)) 
    ElseIf LabelName = "errortext" Then
        s = ErrorText(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "testhtml" Then
        Call TestHtml() 
    ElseIf LabelName = "htmldecode" Then
        s = HtmlDecode(strDQ(s)) 
    ElseIf LabelName = "htmlencode" Then
        s = HTMLEncode(strDQ(s)) 
    ElseIf LabelName = "htmlfilter" Then
        s = HtmlFilter(strDQ(s)) 
    ElseIf LabelName = "regreplace" Then
        s = regReplace(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "easp_replace" Then
        s = Easp_Replace(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handlehtmllabelclose" Then
        s = handleHtmlLabelClose(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "handleimgclose" Then
        s = handleImgClose(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlebrclose" Then
        s = handleBrClose(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlehrclose" Then
        s = handleHrClose(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handleclosehtml" Then
        s = handleCloseHtml(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "htmllabeltoclean" Then
        s = htmlLabelToClean(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "addtooraddhttpurl" Then
        s = addToOrAddHttpUrl(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "removeblanklines" Then
        s = removeBlankLines(strDQ(s)) 
    ElseIf LabelName = "removeblanklines_test1" Then
        s = removeBlankLines_test1(strDQ(s)) 
    ElseIf LabelName = "blankhtmlbody" Then
        s = blankHtmlBody(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkcode" Then
        s = checkCode(strDQ(s)) 
    ElseIf LabelName = "getfilecharset" Then
        s = getFileCharset(strDQ(s)) 
    ElseIf LabelName = "seniorcheckcode" Then
        s = seniorCheckCode(strDQ(s)) 
    ElseIf LabelName = "readfile" Then
        s = readFile(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getstext" Then
        s = getStext(strDQ(s)) 
    ElseIf LabelName = "getftextutf" Then
        s = getFTextUTF(strDQ(s)) 
    ElseIf LabelName = "writetofile" Then
        s = writeToFile(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "createfileutf" Then
        s = createFileUTF(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getugtext" Then
        s = getUGText(strDQ(s)) 
    ElseIf LabelName = "checkcontentcharset" Then
        s = checkContentCharset(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkfilecode" Then
        s = checkFileCode(strDQ(s)) 
    ElseIf LabelName = "getfilebinarycontent" Then
        s = getFileBinaryContent(strDQ(s)) 
    ElseIf LabelName = "binaryreadfile" Then
        s = binaryReadFile(strDQ(s)) 
    ElseIf LabelName = "readbinary" Then
        s = readBinary(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "decsavebinary" Then
        s = decSaveBinary(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "writebinary" Then
        Call writeBinary(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getfilecharset2" Then
        s = getFileCharset2(strDQ(s)) 
    ElseIf LabelName = "bintohex" Then
        s = binToHex(strDQ(s)) 
    ElseIf LabelName = "base64encode" Then
        s = Base64Encode(strDQ(s)) 
    ElseIf LabelName = "base64decode" Then
        s = Base64Decode(strDQ(s)) 
    ElseIf LabelName = "asphelptip" Then
        s = ASPHelpTip(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlewrite" Then
        s = HandleWrite(strDQ(s)) 
    ElseIf LabelName = "jiantitabfanti" Then
        s = JianTiTabFanTi(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "jiyicireplace" Then
        s = JiYiCiReplace(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "cireplace" Then
        s = CiReplace(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "testgetpy" Then
        Call testGetPY() 
    ElseIf LabelName = "pinyin" Then
        s = pinYin(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "pinyin2" Then
        s = pinYin2(strDQ(s)) 
    ElseIf LabelName = "entocompany" Then
        s = enToCompany(strDQ(s)) 
    ElseIf LabelName = "remotecontentjinghao" Then
        s = remoteContentJingHao(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "remotearrayjinghao" Then
        s = remoteArrayJingHao(strDQ(s)) 
    ElseIf LabelName = "geteachstraddvalue" Then
        s = getEachStrAddValue(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getvalueinarrayid" Then
        s = getValueInArrayID(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkvalueinarray" Then
        s = checkValueInArray(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deleterepeatarray" Then
        s = deleteRepeatArray(strDQ(s)) 
    ElseIf LabelName = "deleterepeatcontent" Then
        s = deleteRepeatContent(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getarraycount" Then
        s = getArrayCount(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "randomshow" Then
        s = randomShow(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "arrayrandomshow" Then
        s = arrayRandomShow(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "printarray" Then
        Call printArray(strDQ(s)) 

    ElseIf LabelName = "echoarray" Then
        Call echoArray(strDQ(s)) 
    ElseIf LabelName = "str_shuffle" Then
        s = str_Shuffle(strDQ(s)) 
    ElseIf LabelName = "characterupset" Then
        s = characterUpset(strDQ(s)) 
    ElseIf LabelName = "str_split" Then
        s = str_Split(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "removenullvaluearray" Then
        s = removeNullValueArray(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "removerepeatvaluearray" Then
        s = removeRepeatValueArray(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlearray" Then
        s = handleArray(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "arraytostring" Then
        s = arrayToString(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "testarraydata" Then
        s = testArrayData() 
    ElseIf LabelName = "selectsort" Then
        s = selectSort(strDQ(s)) 
    ElseIf LabelName = "quicksort" Then
        s = quickSort(strDQ(s)) 
    ElseIf LabelName = "bubblesort" Then
        s = bubbleSort(strDQ(s)) 
    ElseIf LabelName = "insertsort" Then
        s = insertSort(strDQ(s)) 
    ElseIf LabelName = "requicksort" Then
        s = reQuickSort(strDQ(s)) 
    ElseIf LabelName = "arrayreverse" Then
        s = arrayReverse() 
    ElseIf LabelName = "responsearray" Then
        Call responseArray(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "max" Then
        s = max(strDQ(s)) 
    ElseIf LabelName = "min" Then
        s = min(strDQ(s)) 
    ElseIf LabelName = "testtwodimensionalarray" Then
        s = testTwoDimensionalArray() 
    ElseIf LabelName = "handlesplitarray" Then
        s = handleSplitArray(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "twodimensionalarrayasc" Then
        s = twoDimensionalArrayAsc(strDQ(s)) 
    ElseIf LabelName = "twodimensionalarraydesc" Then
        s = twoDimensionalArrayDesc(strDQ(s)) 
    ElseIf LabelName = "csscompression" Then
        s = cssCompression(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "deletecssnote" Then
        s = deleteCssNote(strDQ(s)) 
    ElseIf LabelName = "uncsscompression" Then
        s = unCssCompression(strDQ(s)) 
    ElseIf LabelName = "trimvbcrlf" Then
        s = trimVbCrlf(strDQ(s)) 
    ElseIf LabelName = "phptrim" Then
        s = pHPTrim(strDQ(s)) 
    ElseIf LabelName = "ltrimvbcrlf" Then
        s = ltrimVBcrlf(strDQ(s)) 
    ElseIf LabelName = "rtrimvbcrlf" Then
        s = rtrimVBcrlf(strDQ(s)) 
    ElseIf LabelName = "trimvbtab" Then
        s = trimVbTab(strDQ(s)) 
    ElseIf LabelName = "ltrimvbtab" Then
        s = lTrimVbTab(strDQ(s)) 
    ElseIf LabelName = "rtrimvbtab" Then
        s = rTrimVBTab(strDQ(s)) 
    ElseIf LabelName = "gethtmlcssstyle" Then
        s = getHtmlCssStyle(strDQ(s)) 
    ElseIf LabelName = "handlecleancss" Then
        s = handleCleanCss(strDQ(s)) 
    ElseIf LabelName = "removeexcessrow" Then
        s = removeExcessRow(strDQ(s)) 
    ElseIf LabelName = "cssaddtostyle" Then
        s = cssAddToStyle(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "checkcssstyle" Then
        s = checkCssStyle(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "cssstyleaddtoparam" Then
        s = cssStyleAddToParam(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "findcssstyle" Then
        s = findCssStyle(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlecutcsscode" Then
        s = handleCutCssCode(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlecutdivcode" Then
        s = handleCutDivCode(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "gethtmlbackgroundimglist" Then
        s = getHtmlBackGroundImgList(strDQ(s)) 
    ElseIf LabelName = "gethandlewebhtmllink" Then
        s = getHandleWebHtmlLink(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getcsslisturllist" Then
        s = getCssListUrlList(strDQ(s)) 
    ElseIf LabelName = "handlereadcsscontent" Then
        s = handleReadCssContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "handlecsspx" Then
        s = handleCssPX(strDQ(s)) 
    ElseIf LabelName = "handlehtmlstyle" Then
        s = handleHtmlStyle(strDQ(s)) 
    ElseIf LabelName = "utf2gb" Then
        s = UTF2GB(strDQ(s)) 
    ElseIf LabelName = "checkutftogb2312" Then
        s = CheckUTFToGB2312(strDQ(s)) 
    ElseIf LabelName = "convchinese" Then
        s = ConvChinese(strDQ(s)) 
    ElseIf LabelName = "utf8_urlencoding" Then
        s = UTF8_URLEncoding(strDQ(s)) 
    ElseIf LabelName = "toutf8" Then
        s = toUTF8(strDQ(s)) 
    ElseIf LabelName = "chinese2unicode" Then
        s = chinese2unicode(strDQ(s)) 
    ElseIf LabelName = "isvalidhex" Then
        s = isvalidhex(strDQ(s)) 
    ElseIf LabelName = "escape" Then
        s = escape(strDQ(s)) 
    ElseIf LabelName = "unescape" Then
        s = unescape(strDQ(s)) 
    ElseIf LabelName = "chinesetounicode" Then
        s = ChineseToUnicode(strDQ(s)) 
    ElseIf LabelName = "unicodetochinese" Then
        s = UnicodeToChinese(strDQ(s)) 
    ElseIf LabelName = "urlencode" Then
        s = URLEncode(strDQ(s)) 
    ElseIf LabelName = "urldecode" Then
        s = URLDecode(strDQ(s)) 
    ElseIf LabelName = "gbtoutf8" Then
        s = GBtoUTF8(strDQ(s)) 
    ElseIf LabelName = "encdecurl" Then
        s = EncDecURL(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "encurl" Then
        s = EncURL(strDQ(s)) 
    ElseIf LabelName = "decurl" Then
        s = DecURL(strDQ(s)) 
    ElseIf LabelName = "infocolor" Then
        s = infoColor(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "imgerror" Then
        s = imgError() 
    ElseIf LabelName = "targetstr" Then
        s = targetStr(strDQ(s)) 
    ElseIf LabelName = "atarget" Then
        s = aTarget(strDQ(s)) 
    ElseIf LabelName = "atitle" Then
        s = aTitle(strDQ(s)) 
    ElseIf LabelName = "imgalt" Then
        s = imgAlt(strDQ(s)) 
    ElseIf LabelName = "imgtitlealt" Then
        s = imgTitleAlt(strDQ(s)) 
    ElseIf LabelName = "arel" Then
        s = aRel(strDQ(s)) 
    ElseIf LabelName = "styleclass" Then
        s = styleClass(strDQ(s)) 
    ElseIf LabelName = "textfontb" Then
        s = textFontB(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "textfontcolor" Then
        s = textFontColor(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "fontcolorfontb" Then
        s = fontColorFontB(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getdefaultfilename" Then
        s = getDefaultFileName() 
    ElseIf LabelName = "ahref" Then
        s = aHref(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "imgsrc" Then
        s = imgSrc(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "selecttarget" Then
        s = selectTarget(strDQ(s)) 
    ElseIf LabelName = "selectfontcolor" Then
        s = selectFontColor(strDQ(s)) 
    ElseIf LabelName = "selectsex" Then
        s = selectSex(strDQ(s)) 
    ElseIf LabelName = "selectsessioncookies" Then
        s = selectSessionCookies(strDQ(s)) 
    ElseIf LabelName = "showselectlist" Then
        s = showSelectList(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "showarticleliststyle" Then
        s = showArticleListStyle(strDQ(s)) 
    ElseIf LabelName = "showarticleinfostyle" Then
        s = showArticleInfoStyle(strDQ(s)) 
    ElseIf LabelName = "handlearticleliststyleorinfostyle" Then
        s = handleArticleListStyleOrInfoStyle(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "showwebmoduleskins" Then
        s = showWebModuleSkins(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "showradiolist" Then
        s = showRadioList(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputcheckbox" Then
        s = inputCheckBox(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "inputcheckbox3" Then
        s = inputCheckBox3(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handleinputcheckbox" Then
        s = handleInputCheckBox(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "inputtext" Then
        s = inputText(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputtext2" Then
        s = inputText2(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "inputlefttext" Then
        s = inputLeftText(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputlefttexthelptextright" Then
        s = inputLeftTextHelpTextRight(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputlefttextcontent" Then
        s = inputLeftTextContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputrighttextcontent" Then
        s = inputRightTextContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handleinputleftrighttextcontent" Then
        s = handleInputLeftRightTextContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "inputleftpasstext" Then
        s = inputLeftPassText(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputleftpasstextcontent" Then
        s = inputLeftPassTextContent(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "inputhiddentext" Then
        s = inputHiddenText(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "inputtextarea" Then
        s = inputTextArea(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "inputhiddentextarea" Then
        s = inputHiddenTextArea(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "handleinputhiddentextarea" Then
        s = handleInputHiddenTextArea(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5))) 
    ElseIf LabelName = "showselectdirlist" Then
        s = showSelectDirList(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "inputdisabled" Then
        s = inputDisabled(strDQ(s)) 
    ElseIf LabelName = "inputaddalt" Then
        s = inputAddAlt(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "webtitle_inputtextarea" Then
        s = webTitle_InputTextArea(strDQ(s)) 
    ElseIf LabelName = "webkeywords_inputtext" Then
        s = webKeywords_InputText(strDQ(s)) 
    ElseIf LabelName = "webdescription_inputtextarea" Then
        s = webDescription_InputTextArea(strDQ(s)) 
    ElseIf LabelName = "foldername_inputtext" Then
        s = folderName_InputText(strDQ(s)) 
    ElseIf LabelName = "filename_inputtext" Then
        s = fileName_InputText(strDQ(s)) 
    ElseIf LabelName = "templatepath_inputtext" Then
        s = templatePath_InputText(strDQ(s)) 
    ElseIf LabelName = "clickpinyinhtmlstr" Then
        s = clickPinYinHTMLStr(strDQ(s)) 
    ElseIf LabelName = "showfontcolorfontb" Then
        s = showFontColorFontB(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "showsort" Then
        s = showSort(strDQ(s)) 
    ElseIf LabelName = "showwebnavtype" Then
        s = showWebNavType(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4)), strDQ(splxx(5))) 
    ElseIf LabelName = "showonhtml" Then
        s = showOnHtml(strDQ(s)) 
    ElseIf LabelName = "showthrough" Then
        s = showThrough(strDQ(s)) 
    ElseIf LabelName = "showrecommend" Then
        s = showRecommend(strDQ(s)) 
    ElseIf LabelName = "showonoffimg" Then
        s = showOnOffImg(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "newshowonoffimg" Then
        s = newShowOnOffImg(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "controldialogcss" Then
        s = controlDialogCss() 
    ElseIf LabelName = "batchdeletetempstr" Then
        s = batchDeleteTempStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "htmlformatting" Then
        s = htmlFormatting(strDQ(s)) 
    ElseIf LabelName = "handlehtmlformatting" Then
        s = handleHtmlFormatting(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "checkhtmlformatting" Then
        s = checkHtmlFormatting(strDQ(s)) 
    ElseIf LabelName = "newreplacevalueparam" Then
        s = newReplaceValueParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "newrparam" Then
        s = newRParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getcontentallrunstr" Then
        s = getContentAllRunStr(strDQ(s)) 
    ElseIf LabelName = "getcontentrunstr" Then
        s = getContentRunStr(strDQ(s)) 
    ElseIf LabelName = "checkcontentrunstr" Then
        s = checkContentRunStr(strDQ(s)) 
    ElseIf LabelName = "handledoublequotation" Then
        s = handleDoubleQuotation(strDQ(s)) 
    ElseIf LabelName = "strdq" Then
        s = strDQ(strDQ(s)) 
    ElseIf LabelName = "handletoarray" Then
        s = handleToArray(strDQ(s)) 
    ElseIf LabelName = "handlecontentcode" Then
        s = handleContentCode(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handleinmodule" Then
        s = handleInModule(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "clearrparam" Then
        s = clearRParam(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "atrparam" Then
        s = atRParam(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "rparam" Then
        s = rParam(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "handlerparam" Then
        s = handleRParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getconfigblock" Then
        s = getConfigBlock(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getconfigblock2" Then
        s = getConfigBlock2(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getconfigblock3" Then
        s = getConfigBlock3(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getcutconfigblock" Then
        s = getCutConfigBlock(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "getconfigcontentblock" Then
        s = getConfigContentBlock(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getconfigfileblock" Then
        s = getConfigFileBlock(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "setconfigfileblock" Then
        s = setConfigFileBlock(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "delconfigblock" Then
        s = delConfigBlock(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "delconfigblock2" Then
        s = delConfigBlock2(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "delconfigblock3" Then
        s = delConfigBlock3(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "delcutconfigblock" Then
        s = delCutConfigBlock(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "getfileparamvalue" Then
        s = getFileParamValue(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "setfileparamvalue" Then
        s = setFileParamValue(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "handlegetsetfileparamevalue" Then
        s = handleGetSetFileParameValue(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "setrparam" Then
        s = setRParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "addreplacerparam" Then
        s = addReplaceRParam(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "deletestrcut" Then
        s = deleteStrCut(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "replacecontentmodule" Then
        s = replaceContentModule(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3)), strDQ(splxx(4))) 
    ElseIf LabelName = "replacecontentrowmodule" Then
        s = replaceContentRowModule(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "handleconfigfile" Then
        Call handleConfigFile(strDQ(s)) 
    ElseIf LabelName = "getrparam" Then
        s = getRParam(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getdefaultvalue" Then
        s = getDefaultValue(strDQ(s)) 
    ElseIf LabelName = "addmodulereplacearray" Then
        Call addModuleReplaceArray(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "modulefindcontent" Then
        s = moduleFindContent(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "batchfindfunction" Then
        s = BatchFindFunction(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getfindfilefunction" Then
        s = GetFindFileFunction(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "getaspcode" Then
        s = GetASPCode(strDQ(s)) 
    ElseIf LabelName = "handlegetaspcode" Then
        s = HandleGetAspCode(strDQ(splxx(0)), strDQ(splxx(1))) 
    ElseIf LabelName = "delaspnote" Then
        s = DelAspNote(strDQ(s)) 
    ElseIf LabelName = "findaspfunction" Then
        s = FindAspFunction(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2)), strDQ(splxx(3))) 
    ElseIf LabelName = "firstletteruppercase" Then
        s = FirstLetterUppercase(strDQ(s)) 
    ElseIf LabelName = "contentlushow" Then
        s = ContentLUShow(strDQ(s)) 
    ElseIf LabelName = "asptovb" Then
        s = ASPToVB(strDQ(s)) 
    ElseIf LabelName = "asptovbnet" Then
        s = ASPToVBNET(strDQ(s)) 
    ElseIf LabelName = "dimadddefaultvalue" Then
        s = dimAddDefaultValue(strDQ(s)) 
    ElseIf LabelName = "functionparamtonet" Then
        s = functionParamtoNet(strDQ(s)) 
    ElseIf LabelName = "getbeforenstr" Then
        s = GetBeforeNStr(strDQ(splxx(0)), strDQ(splxx(1)), strDQ(splxx(2))) 
    ElseIf LabelName = "getstrdim" Then
        s = getStrDim(strDQ(s)) 
    ElseIf LabelName = "getfunctionstrdim" Then
        s = getFunctionStrDim(strDQ(s)) 
    ElseIf LabelName = "getrandcolor" Then
        s = getRandColor() 
        'footer end



        '----------------------- ASP自身内部函数处理 -----------------------------
    '系统函数 Now
    ElseIf LabelName = "now" Then
        s = Now() 
    '系统函数 Date
    ElseIf LabelName = "date" Then
        s = Date 
    '系统函数 Len
    ElseIf LabelName = "len" Then
        s = Len(s) 
    '系统函数 LCase
    ElseIf LabelName = "lcase" Then
        s = LCase(s) 
    '系统函数 UCase
    ElseIf LabelName = "ucase" Then
        s = UCase(s) 
    '系统函数 ltrim
    ElseIf LabelName = "ltrim" Then
        s = LTrim(s) 
    '系统函数 rtrim
    ElseIf LabelName = "rtrim" Then
        s = RTrim(s) 
    '系统函数 trim
    ElseIf LabelName = "trim" Then
        s = Trim(s) 
    '系统函数 Left
    ElseIf LabelName = "left" Then
        splxx = Split(s & ",1", ",") 
        s = Left(Trim(splxx(0)), Trim(splxx(1))) 
    '系统函数 Right
    ElseIf LabelName = "right" Then
        s = Right(Trim(splxx(0)), Trim(splxx(1))) 
    '系统函数 Mid
    ElseIf LabelName = "mid" Then
        splxx = Split(s & ",99999", ",") 
        If UBound(splxx) >= 2 Then
            s = Mid(Trim(splxx(0)), Trim(splxx(1)), Trim(splxx(2))) 
        Else
            s = Mid(Trim(splxx(0)), Trim(splxx(1))) 
        End If 
    End If 
    content = Replace(content, YunStr, s) 
    handleContentCode = content 
End Function 


'内部模块处理 HandleInModule(Content,"start") HandleInModule(Content,"end")
Function handleInModule(content, sType)
    sType = LCase(CStr(sType)) 
    If sType = "1" Or sType = "start" Then
        content = Replace(content, "\'", "\|*|\") 
        content = Replace(content, "\=", "\|&|\")                                   '后加20141024
    ElseIf sType = "2" Or sType = "end" Then
        content = Replace(content, "\|*|\", "'") 
        content = Replace(content, "\$", "$") 
        content = Replace(content, "\}", "}") 

        content = Replace(content, "\|&|\", "=")                                    '后加20141024
    End If 
    handleInModule = content 
End Function 
'清除特殊样式后获得标签值
Function clearRParam(ByVal action, ByVal LableStr)
    Dim s 
    'Action=Replace(Action,"\'","【|\‘|】")
    action = Replace(action, "\'", "")                                              '把这种清掉
    s = RParam(action, LableStr) 
    's=replace(s,"【|\‘|】", "\'")
    clearRParam = s 
End Function 
'获得参数内容后 放到动作里处理一下（20151023）
Function atRParam(ByVal action, ByVal LableStr)
    atRParam = RParam(action, LableStr) 
    If InStr(atRParam, "{$") > 0 And InStr(atRParam, "$}") > 0 Then
        atRParam = HandleTemplateAction(atRParam, False)                                '处理动作
    End If 
End Function 
'读单个参数值  Title = RParam(Action,"Title")     起强版获取参数值20150723
Function rParam(ByVal action, ByVal lableStr)
    Dim s 

    '原始 单引号
    s = handleRParam(action, lableStr, "'") 
    '原始 双引号
    If s = "" Then
        s = handleRParam(action, lableStr, """") 
    End If 
    '原始 空
    If s = "" Then
        s = handleRParam(action, lableStr, "") 
    End If 

    '小写 单引号
    If s = "" Then
        s = handleRParam(action, LCase(lableStr), "'") 
    End If 
    '小写 双引号
    If s = "" Then
        s = handleRParam(action, LCase(lableStr), """") 
    End If 
    '小写 空
    If s = "" Then
        s = handleRParam(action, LCase(lableStr), "") 
    End If 

    '大写 单引号
    If s = "" Then
        s = handleRParam(action, UCase(lableStr), "'") 
    End If 
    '大写 双引号
    If s = "" Then
        s = handleRParam(action, UCase(lableStr), """") 
    End If 
    '大写 空
    If s = "" Then
        s = handleRParam(action, UCase(lableStr), "") 
    End If 
    '不要这个，要不不稳定(20151022)
    'if s=false then s=""
    If s = "[#空*值_#]" Then s = "" 
    rParam = s 
End Function 
'处理 读单个参数值
Function handleRParam(ByVal action, ByVal LableStr, ByVal typeStr)
    Dim LalbeName, endTypeStr, isTrue, s 
    isTrue = False                                                                  '是否为真
    endTypeStr = IIF(typeStr <> "", typeStr, " ") 
    action = vbCrLf & " " & action                                                  '给它也加个空格，要不然在没有函数，前面就没有空格
    '默认前面加空格
    LalbeName = " " & LableStr                                                      '加个空格是为了精准
    '不存在  前面加点
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = "'" & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在 前面加双引号
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = """" & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在    前面加TAB
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = vbTab & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在    前面加换行
    If InStr(action, LalbeName & "=" & typeStr) = False And isTrue = False Then
        LalbeName = vbCrLf & LableStr 
    Else
        isTrue = True 
    End If 
    If InStr(action, LalbeName & "=" & typeStr) > 0 And InStr(action, endTypeStr) > 0 Then
        s = StrCut(action, LalbeName & "=" & typeStr, endTypeStr, 2) 
        s = handleInModule(s, "end")                                                    '处理里面参数 追加于20141031            还原内容值

        If s = "" Then
            s = "[#空*值_#]" 
        End If 

        '判断是否对参数进行动作制作
        If InStr(s, "{$") > 0 And InStr(s, "$}") > 0 Then

            'handleRParam=HandleTemplateAction(handleRParam,true)        '处理动作
            'handleRParam = handleModuleReplaceArray(handleRParam)'给AddSqL处理一下动作 这是处理替换，不需要，因为在 HandleTemplateAction有替换了(20151021)

        End If 
        '不要这个，要不不稳定(20151022)
        'if handleRParam="" then
        'handleRParam=false
    'end if
    End If 
    handleRParam = s 
End Function 


'获得配置块 20150105 GetConfigBlock(ConfigContent, BlockName)
Function getConfigBlock(ConfigContent, BlockName)
    getConfigBlock = GetCutConfigBlock(ConfigContent, BlockName, "#", "#") 
End Function 
'获得配置块 20150105
Function getConfigBlock2(ConfigContent, BlockName)
    getConfigBlock2 = GetCutConfigBlock(ConfigContent, BlockName, "[#", "#]") 
End Function 
'获得配置块 20150105
Function getConfigBlock3(ConfigContent, BlockName)
    getConfigBlock3 = GetCutConfigBlock(ConfigContent, BlockName, "[$", "$]") 
End Function 
'截取配置内容中块 20150105
Function getCutConfigBlock(ConfigContent, BlockName, StartLable, EndLable)
    Dim startStr, endStr 
    startStr = StartLable & BlockName & EndLable 
    endStr = StartLable & BlockName & EndLable 
    '开始标签处理
    If InStr(ConfigContent, startStr & " start") > 0 Then
        startStr = startStr & " start" 
    Else
        startStr = startStr & " Start" 
    End If 
    '结束标签处理
    If InStr(ConfigContent, endStr & " end") > 0 Then
        endStr = endStr & " end" 
    Else
        endStr = endStr & " End" 
    End If 

    If InStr(ConfigContent, startStr) > 0 And InStr(ConfigContent, endStr) > 0 Then
        getCutConfigBlock = StrCut(ConfigContent, startStr, endStr, 2) 
    End If 
End Function 
'获得配置内容块20150401
Function getConfigContentBlock(ByVal ConfigContent, BlockName)
    getConfigContentBlock = getCutConfigBlock(ConfigContent, BlockName, "", "") 
End Function 
'获得配置文件里块20150401  getConfigFileBlock(ConfigPath, "#txtRunCode#")  测试标签块时则自动创建
Function getConfigFileBlock(ByVal ConfigFile, BlockName)
    Dim content, FindStr, replaceStr, startStr, endStr 
    content = GetFText(ConfigFile) 
    'MsgBox ("ConfigFile=" & ConfigFile & "(" & CheckFile(ConfigFile) & "，" & GetFSize(ConfigFile) & ")" & vbCrLf & "Content=" & Content)
    startStr = BlockName & " start" 
    endStr = BlockName & " end" 
    replaceStr = startStr & "" & endStr 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        FindStr = StrCut(content, startStr, endStr, 2) 
        getConfigFileBlock = FindStr 
    Else
        Call CreateFile(ConfigFile, content & replaceStr) 
    End If 
End Function 
'设置配置文件里块 20150401 call setConfigFileBlock(ConfigFile, "aaabbc", "#上传目录列表#")  存在则更新
Function setConfigFileBlock(ByVal ConfigFile, ByVal WriteContent, BlockName)
    Dim content, FindStr, replaceStr, startStr, endStr 
    content = GetFText(ConfigFile) 
    startStr = BlockName & " start" 
    endStr = BlockName & " end" 
    replaceStr = startStr & WriteContent & endStr 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        FindStr = StrCut(content, startStr, endStr, 1) 
        content = Replace(content, FindStr, replaceStr) 
    Else
		content=content & replaceStr 
    End If 
    Call CreateFile(ConfigFile, content) 
	setConfigFileBlock=content
End Function 

'删除配置块 20150322
Function delConfigBlock(Config, BlockName)
    delConfigBlock = DelCutConfigBlock(Config, BlockName, "#", "#") 
End Function 
'删除配置块 20150322
Function delConfigBlock2(Config, BlockName)
    delConfigBlock2 = DelCutConfigBlock(Config, BlockName, "[#", "#]") 
End Function 
'删除配置块 20150322
Function delConfigBlock3(Config, BlockName)
    delConfigBlock3 = DelCutConfigBlock(Config, BlockName, "[$", "$]") 
End Function 
'删除配置内容 20150322
Function delCutConfigBlock(Config, BlockName, StartLable, EndLable)
    Dim startStr, endStr, s 
    startStr = StartLable & BlockName & EndLable & " start" 
    endStr = StartLable & BlockName & EndLable & " end" 
    If InStr(Config, startStr) > 0 And InStr(Config, endStr) > 0 Then
        s = StrCut(Config, startStr, endStr, 1) 
        Config = Replace(Config, s, "") 
    End If 
    delCutConfigBlock = Config 
End Function 




'获得文件里设置参数　20150315
Function getFileParamValue(ConfigPath, paramName)
    getFileParamValue = HandleGetSetFileParameValue(ConfigPath, paramName, "", "获得") 
End Function 
'设置文件里设置参数　20150315
Function setFileParamValue(ConfigPath, paramName, valueStr)
    setFileParamValue = HandleGetSetFileParameValue(ConfigPath, paramName, valueStr, "设置") 
End Function 
'处理获得设置文件参数值　20150315
Function handleGetSetFileParameValue(ConfigPath, paramName, valueStr, sType)
    Dim content, startStr, endStr, YunStr, replaceStr 
    '文件为假时，创建一个空文件看看，如果不能创建这个文件则说明这个文件地址有问题，则退出20150324
    If checkFile(ConfigPath) = False Then
        Call CreateFile(ConfigPath, "") 
    End If 
    If checkFile(ConfigPath) = False Then Exit Function                             '文件不存在则退出

    content = TrimVbCrlf(GetFText(ConfigPath)) 
    startStr = vbCrLf & paramName & "=" : endStr = vbCrLf 
    replaceStr = vbCrLf & paramName & "=" & valueStr & vbCrLf 
    If InStr(vbCrLf & content, startStr) > 0 And InStr(content & vbCrLf, endStr) > 0 Then
        YunStr = StrCut(vbCrLf & content & vbCrLf, startStr, endStr, 2) 
        If sType = "获得" Then
            handleGetSetFileParameValue = YunStr 
            Exit Function 
        End If 
        YunStr = startStr & YunStr & endStr 
        content = Replace(vbCrLf & content & vbCrLf, YunStr, replaceStr) 
        Call CreateFile(ConfigPath, content) 
    Else
        Call CreateFile(ConfigPath, content & vbCrLf & TrimVbCrlf(replaceStr)) 
    End If 
End Function 

'设置内容里参数 20150611
Function setRParam(ConfigPath, paramName, paramValue, isNoAdd)
    Dim content, startStr, endStr, s 
    content = PHPTrim(GetFText(ConfigPath)) 
    startStr = paramName & "='" : endStr = "'" 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        s = StrCut(content, startStr, endStr, 2) 
        content = Replace(content, startStr & s & endStr, startStr & paramValue & endStr) 
        Call CreateFile(ConfigPath, content) 

    ElseIf Trim(isNoAdd) = "1" Then
        Call createAddFile(ConfigPath, startStr & paramValue & endStr) 
    End If 
End Function 

'追加或替换参数值 20150615
Function addReplaceRParam(ByVal content, startStr, endStr, ByVal valueStr)
    Dim s 
    valueStr = startStr & valueStr & endStr 
    If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
        s = StrCut(content, startStr, endStr, 1) 
        content = Replace(content, s, valueStr) 
    Else
        content = content & vbCrLf & valueStr 
    End If 
    addReplaceRParam = content 
End Function 
'删除指定字符N次
Function deleteStrCut(ByVal content, ByVal startStr, ByVal endStr, ByVal cutType, nDelCount)
    Dim i, s 
    If nDelCount = 0 Then
        nDelCount = 99 
    End If 
    For i = 0 To nDelCount
        s = getStrCut(content, startStr, endStr, 1) 
        If s <> "" Then
            content = Replace(content, s, "") 
        Else
            Exit For 
        End If 
    Next 
    deleteStrCut = content 
End Function 



'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容",""))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加在前"))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加"))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","追加在前"))
'call Rwend(replaceContentModule(getftext("1.html"),"<div>","</div>","替换内容","外部追加在前"))
'call Rwend(replaceContentModule(getftext("1.html"), "<div>", "</div>", "替换内容", "外部追加"))
'替换内容里模块   ReplaceType(空为替换，追加在前，追加在后(追加)，外部追加在前，外部追加在后(外部追加))
Function replaceContentModule(ByVal content, startStr, endStr, ReplaceValue, ReplaceType)
    Dim splStr, splxx, s, i, splType, valueList, newStartStr, newEndStr, sourceValueList, sourceValue, tempS, newReplaceValue 
    If InStr(content, startStr) = False And InStr(content, endStr) = False Then
        replaceContentModule = content 
        Exit Function 
    End If 
    splType = "$Array$" 
    For i = 1 To 99
        If InStr(content, startStr) > 0 And InStr(content, endStr) > 0 Then
            s = StrCut(content, startStr, endStr, 1) : tempS = s 
            s = Mid(s, Len(startStr) + 1, Len(s) - Len(startStr) - Len(endStr)) 
            newStartStr = getEachStrAddValue(startStr, "|*|") 
            If InStr(splType & valueList & splType, splType & newStartStr & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newStartStr 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & startStr 
            End If 
            newEndStr = getEachStrAddValue(endStr, "|*|") 
            If InStr(splType & valueList & splType, splType & newEndStr & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newEndStr 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & endStr 
            End If 

            If ReplaceType = "追加在前" Then
                newReplaceValue = newStartStr & ReplaceValue & s & newEndStr 
            ElseIf ReplaceType = "追加在后" Or ReplaceType = "追加" Then
                newReplaceValue = newStartStr & s & ReplaceValue & newEndStr 
            ElseIf ReplaceType = "外部追加在前" Then
                newReplaceValue = ReplaceValue & newStartStr & s & newEndStr 

            ElseIf ReplaceType = "外部追加在后" Or ReplaceType = "外部追加" Then
                newReplaceValue = newStartStr & s & newEndStr & ReplaceValue 
            Else
                newReplaceValue = ReplaceValue 
            End If 

            content = Replace(content, tempS, newReplaceValue) 
        Else
            Exit For 
        End If 
    Next 
    'call rwend(content)
    splStr = Split(valueList, splType) 
    splxx = Split(sourceValueList, splType) 
    For i = 0 To UBound(splStr)
        sourceValue = splStr(i) 
        ReplaceValue = splxx(i) 
        content = Replace(content, sourceValue, ReplaceValue) 
    Next 
    replaceContentModule = content 
End Function 

'call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", "追加在前"))
'call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", "追加"))
'call rwend(replaceContentRowModule(getftext("1.html"),"<div>11</div>", "替换内容", ""))
'替换内容里一行模块   ReplaceType(空为替换，追加在前，追加在后(追加))
Function replaceContentRowModule(content, searchValue, ReplaceValue, ReplaceType)
    Dim splStr, splxx, i, splType, valueList, sourceValueList, sourceValue, newReplaceValue, newSearchValue 
    splType = "$Array$" 
    For i = 1 To 99
        If InStr(content, searchValue) > 0 Then
            newSearchValue = getEachStrAddValue(searchValue, "|*|") 
            If InStr(splType & valueList & splType, splType & newSearchValue & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newSearchValue 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & searchValue 
            End If 
            If ReplaceType = "追加在前" Then
                newReplaceValue = ReplaceValue & newSearchValue 
            ElseIf ReplaceType = "追加在后" Or ReplaceType = "追加" Then
                newReplaceValue = newSearchValue & ReplaceValue 
            Else
                newReplaceValue = ReplaceValue 
            End If 
            content = Replace(content, searchValue, newReplaceValue) 
        Else
            Exit For 
        End If 
    Next 

    'call rwend(content)
    splStr = Split(valueList, splType) 
    splxx = Split(sourceValueList, splType) 
    For i = 0 To UBound(splStr)
        sourceValue = splStr(i) 
        ReplaceValue = splxx(i) 
        content = Replace(content, sourceValue, ReplaceValue) 
    Next 
    replaceContentRowModule = content 

End Function 
'处理配置文档(20150804)
Sub handleConfigFile(ConfigPath)
    Dim c 
    If checkFile(ConfigPath) = False Then
        c = "#Help帮助# start" & vbCrLf & "默认帮助内容" & vbCrLf & "#Help帮助# end" 
        Call CreateFile(ConfigPath, c) 
    End If 
End Sub 

'获得内容里指定类型值   RParam加强版(20161025)
Function getRParam(ByVal content, ByVal lableStr)
    Dim contentLCase, endS, i, s, c, isStart, startStr, isValue 
    content = " " & content & " "                                                   '避免更精准获得值
    contentLCase = LCase(content) 
    lableStr = LCase(lableStr) 
    endS = Mid(content, InStr(contentLCase, lableStr) + Len(lableStr)) 
    'call echo("ends",ends)
    isStart = False                                                                 '是否有开始类型值
    isValue = False                                                                 '是否有值
    For i = 1 To Len(endS)
        s = Mid(endS, i, 1) 
        If isStart = True Then
            If s <> "" Then
                If startStr = "" Then
                    startStr = s 
                Else
                    If startStr = """" Or startStr = "'" Then
                        If s = startStr Then
                            isValue = True 
                            Exit For 
                        End If 
                    ElseIf s = " " And c = "" Then

                    ElseIf s = " " Or s = "/" Or s = ">" Then
                        isValue = True 
                        Exit For 
                    End If 
                    If s <> " " Then
                        c = c & s 
                    End If 
                End If 
            End If 
        End If 

        If s = "=" Then
            isStart = True 
        End If 
    Next 
    If isValue = False Then
        c = "" 
    End If 
    getRParam = c 
'call echo("c",c)
End Function 

'获得模板某标签默认内容 代码进行了二次查找 会在HTML模板里二次查找默认值
Function getDefaultValue(action)
    getDefaultValue = ModuleFindContent(action, "default") 
End Function 

'添加模块替换数组
Sub addModuleReplaceArray(title, content)
    Dim i 
    For i = 1 To UBound(ModuleReplaceArray) - 1
        If ModuleReplaceArray(i, 0) = "" Then
            ModuleReplaceArray(i, 0) = title 
            ModuleReplaceArray(0, i) = content 
            Exit Sub 
        End If 
    Next 
End Sub 

'根据标签找到对应内容
Function moduleFindContent(action, ModuleName)
    Dim defaultStr, startStr, endStr 
    defaultStr = rParam(action, ModuleName)                                         '把转小写LCase去掉 （20151008）

    startStr = "<!--#" & defaultStr & " start#-->" 
    endStr = "<!--#" & defaultStr & " end#-->" 
    '[_18年独家一次性祛斑第一品牌2014年10月21日 10时59分]
    'Call Echo("Default",Default)
    '判断是否存在
    If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
        defaultStr = StrCut(code, startStr, endStr, 2) 
    Else
        startStr = "<!--#" & defaultStr 
        endStr = "#-->" 
        If InStr(code, startStr) > 0 And InStr(code, endStr) > 0 Then
            defaultStr = StrCut(code, startStr, endStr, 2) 

        'Call Echo("有","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
        End If 
    End If 

    '删除默认值20150712
    Dim deletedefault 
    deletedefault = rParam(action, "deletedefault") 
    If deletedefault = "true" Then
        Call addModuleReplaceArray("【删除】", startStr & defaultStr & endStr) 
    End If 
    moduleFindContent = defaultStr 
End Function 
%>   

