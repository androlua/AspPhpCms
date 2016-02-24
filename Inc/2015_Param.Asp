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


'http://127.0.0.1/函数/ClassAspCode.Asp?act=GetFileFunctionStrList    从这里面获得最新设置



'**************************************** 给php用 通用 ****************************************

'替换参数值 2014  12 01
Function newReplaceValueParam(content, ParamName, ReplaceStr)
    Dim StartStr, EndStr, LabelStr, nLen, nTimeFormat, DelHtmlYes, TrimYes 
    'ReplaceStr = ReplaceStr & "这里面放上内容在这时碳呀。"
    'ReplaceStr = CStr(ReplaceStr)            '转成字符类型
    If IsNul(ReplaceStr) = True Then ReplaceStr = "" 

    StartStr = "[$" & ParamName : EndStr = "$]" 
    If InStr(content, StartStr) > 0 And InStr(content, EndStr) > 0 Then
        LabelStr = StrCut(content, StartStr, EndStr, 1) 
        '删除Html
        DelHtmlYes = RParam(LabelStr, "DelHtml")                                        '是否删除Html
        If DelHtmlYes = "true" Then ReplaceStr = Replace(DelHtml(ReplaceStr), "<", "&lt;") 'HTML处理
        '删除两边空格
        TrimYes = RParam(LabelStr, "Trim")                                              '是否删除两边空格
        If TrimYes = "true" Then ReplaceStr = TrimVbCrlf(ReplaceStr) 

        '截取字符处理
        nLen = RParam(LabelStr, "Len")                                                  '字符长度值
        nLen = HandleNumber(nLen) 
        'If nLen<>"" Then ReplaceStr = CutStr(ReplaceStr,nLen,"null")' Left(ReplaceStr,nLen)
        If nLen <> "" Then ReplaceStr = CutStr(ReplaceStr, nLen, "...")                 'Left(ReplaceStr,nLen)

        '时间处理
        nTimeFormat = RParam(LabelStr, "Format_Time")                                   '时间处理值
        If nTimeFormat <> "" Then
            ReplaceStr = Format_Time(ReplaceStr, nTimeFormat) 
        End If 
        content = Replace(content, LabelStr, ReplaceStr) 

    End If 
    newReplaceValueParam = content 
End Function 

'根据标签找到对应内容
Function newRParam(dataCode, action, ModuleName)
    Dim defaultStr, StartStr, EndStr 
    defaultStr = RParam(action, ModuleName) 
    StartStr = "<!--#" & defaultStr & " start#-->" 
    EndStr = "<!--#" & defaultStr & " end#-->" 

    If defaultStr <> "" Then
        '判断是否存在
        If InStr(dataCode, StartStr) > 0 And InStr(dataCode, EndStr) > 0 Then
            defaultStr = StrCut(dataCode, StartStr, EndStr, 2) 
        Else
            StartStr = "<!--#" & defaultStr 
            EndStr = "#-->" 
            If InStr(dataCode, StartStr) > 0 And InStr(dataCode, EndStr) > 0 Then
                defaultStr = StrCut(dataCode, StartStr, EndStr, 2) 

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
Function handleContentCode(ByVal content, SType)
    Dim StartStr, EndStr, s, YunStr, splStr, splxx, SplContent 
    Dim LabelName                                                                   '标签名称
    Dim nStartStr                                                                   '开始字符

    Dim ContentLCase                                                                '定义内容小写
    ContentLCase = LCase(content)                                                   '内容小写

    If SType = "check" Or SType = "检测" Then
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
            StartStr = LCase(LabelName & "(") : EndStr = ")" 
            nStartStr = InStr(" " & ContentLCase, " " & StartStr) 
            If nStartStr > 0 And InStr(ContentLCase, EndStr) > 0 Then
                If SType = "check" Or SType = "检测" Then
                    handleContentCode = True                 '为检测 有函数  退出
                    Exit Function 
                End If 
                Exit For 
            End If 
        End If 
    Next 
    If LabelName = "" Then
        If SType <> "check" And SType <> "检测" Then
            handleContentCode = content 
        End If 
        Exit Function 
    End If 

    LabelName = LCase(LabelName)                                                    '小写

    StartStr = LabelName & "(" : EndStr = ")" 
    nStartStr = InStr(ContentLCase, StartStr) 
    '记录查的原值，不分大小写
    YunStr = Mid(content, InStr(ContentLCase, StartStr)) 
    YunStr = Mid(YunStr, 1, InStrRev(YunStr, EndStr)) 

    s = Mid(content, InStr(ContentLCase, StartStr) + Len(StartStr)) 

    s = Mid(s, 1, InStrRev(s, EndStr) - 1) 
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
        S = printPre(strDQ(S))
    ElseIf LabelName = "foldingmenu" Then
        S = foldingMenu(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "returnren" Then
        S = returnRen(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "returnhr" Then
        S = returnHr()
    ElseIf LabelName = "returnrenhr" Then
        S = returnRenHr()
    ElseIf LabelName = "showerr" Then
        Call showErr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "printforminfo" Then
        Call printFormInfo()
    ElseIf LabelName = "dedecmsmsg" Then
        S = dedeCMSMsg()
    ElseIf LabelName = "handleaccessdata" Then
        S = handleAccessData(strDQ(S))
    ElseIf LabelName = "adsql" Then
        S = aDSql(strDQ(S))
    ElseIf LabelName = "checkaccesspass" Then
        S = checkAccessPass(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checksql" Then
        S = checkSql(strDQ(S))
    ElseIf LabelName = "createtable" Then
        S = createTable(strDQ(S))
    ElseIf LabelName = "showistable" Then
        S = showIsTable(strDQ(S))
    ElseIf LabelName = "getrecordcount" Then
        S = getRecordCount(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "tablecount" Then
        S = tableCount(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "opentable" Then
        S = openTable(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "inserttable" Then
        S = insertTable(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "gettabletext" Then
        S = getTableText(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "createmdb" Then
        S = createMdb(strDQ(S))
    ElseIf LabelName = "deletetable" Then
        S = deleteTable(strDQ(S))
    ElseIf LabelName = "deletealltable" Then
        S = deleteAllTable(strDQ(S))
    ElseIf LabelName = "checktable" Then
        S = checkTable(strDQ(S))
    ElseIf LabelName = "existstable" Then
        S = existsTable(strDQ(S))
    ElseIf LabelName = "edittable" Then
        S = editTable(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "checkfield" Then
        S = checkField(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "existsfield" Then
        S = existsField(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "editfield" Then
        S = editField(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getfieldalt" Then
        S = getFieldAlt(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "gettablelist_conn" Then
        S = getTableList_Conn(strDQ(S))
    ElseIf LabelName = "gettablelist" Then
        S = getTableList()
    ElseIf LabelName = "getfieldlist" Then
        S = getFieldList(strDQ(S))
    ElseIf LabelName = "getdifferenttablefieldlist" Then
        S = getDifferentTableFieldList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "compactdb" Then
        S = compactDB(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "editaccesspassword" Then
        S = editAccessPassWord(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "handlesqlserver" Then
        S = handleSqlServer(strDQ(S))
    ElseIf LabelName = "exporttoexcel" Then
        Call exportToExcel(strDQ(S))
    ElseIf LabelName = "importtodatabase" Then
        Call importToDatabase()
    ElseIf LabelName = "getdatatablelist" Then
        S = getDataTableList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "settablefield" Then
        S = setTableField(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "gettypestring" Then
        S = getTypeString(strDQ(S))
    ElseIf LabelName = "getproductrndidlist" Then
        S = getProductRndIdList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getfieldvalue" Then
        S = getFieldValue(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getconnfieldvalue" Then
        S = getConnFieldValue(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "setfieldvalue" Then
        S = setFieldValue(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "filebinaryaddaccess" Then
        S = fileBinaryAddAccess(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)))
    ElseIf LabelName = "showaccessstream" Then
        S = showAccessStream(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "gethttppage" Then
        S = getHttpPage(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlegethttppage" Then
        S = handleGetHttpPage(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "geturlcontent" Then
        S = getURLContent(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "gethttpurl" Then
        S = getHttpUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "bytestobstr" Then
        S = bytesToBstr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "strcut" Then
        S = strCut(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "getstrcut" Then
        S = getStrCut(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "cutstr" Then
        S = cutStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "cutstrnolu" Then
        S = cutStrNOLU(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "setcuttdstr" Then
        S = setCutTDStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "cuttdstr" Then
        S = cutTDStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getarraylist" Then
        S = getArrayList(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)))
    ElseIf LabelName = "getarray" Then
        S = getArray(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "getarray1" Then
        S = getArray1(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "getsplit" Then
        S = getSplit(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getsplitcount" Then
        S = getSplitCount(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "agent" Then
        S = agent(strDQ(S))
    ElseIf LabelName = "specialhtmluploadencryptiondecrypt" Then
        S = specialHtmlUploadEncryptionDecrypt(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "encaspcontent" Then
        S = encAspContent(strDQ(S))
    ElseIf LabelName = "uppercaseorlowercase" Then
        S = upperCaseORLowerCase(strDQ(S))
    ElseIf LabelName = "enccode" Then
        S = encCode(strDQ(S))
    ElseIf LabelName = "deccode" Then
        S = decCode(strDQ(S))
    ElseIf LabelName = "tounicode" Then
        S = toUnicode(strDQ(S))
    ElseIf LabelName = "japan" Then
        S = japan(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "japan26" Then
        S = japan26(strDQ(S))
    ElseIf LabelName = "unjapan26" Then
        S = unJapan26(strDQ(S))
    ElseIf LabelName = "handlehtml" Then
        S = handleHTML(strDQ(S))
    ElseIf LabelName = "unhandlehtml" Then
        S = unHandleHTML(strDQ(S))
    ElseIf LabelName = "lcaseenc" Then
        S = lcaseEnc(strDQ(S))
    ElseIf LabelName = "lcasedec" Then
        S = lcaseDec(strDQ(S))
    ElseIf LabelName = "htmltojs" Then
        S = htmlToJs(strDQ(S))
    ElseIf LabelName = "jstohtml" Then
        S = jsToHtml(strDQ(S))
    ElseIf LabelName = "htmltoasp" Then
        S = htmlToAsp(strDQ(S))
    ElseIf LabelName = "htmltoaspdim" Then
        S = htmlToAspDim(strDQ(S))
    ElseIf LabelName = "asptohtml" Then
        S = aspToHtml(strDQ(S))
    ElseIf LabelName = "setfilename" Then
        S = setFileName(strDQ(S))
    ElseIf LabelName = "unsetfilename" Then
        S = unSetFileName(strDQ(S))
    ElseIf LabelName = "htmltoascchr" Then
        S = HTMLToAscChr(strDQ(S))
    ElseIf LabelName = "unhtmltoascchr" Then
        S = unHTMLToAscChr(strDQ(S))
    ElseIf LabelName = "variabledisplacement" Then
        S = variableDisplacement(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "xorenc" Then
        S = xorEnc(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "xordec" Then
        S = xorDec(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handleevaladddec" Then
        S = handleEvalAddDec(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "evaladddec" Then
        S = evalAddDec(strDQ(S))
    ElseIf LabelName = "vbevaladddec" Then
        S = VBEvalAddDec(strDQ(S))
    ElseIf LabelName = "xdec" Then
        S = XDec(strDQ(S))
    ElseIf LabelName = "tohexcolor" Then
        S = toHexColor(strDQ(S))
    ElseIf LabelName = "colorrgb" Then
        S = colorRGB(strDQ(S))
    ElseIf LabelName = "simpleenc" Then
        S = simpleEnc(strDQ(S))
    ElseIf LabelName = "simpledec" Then
        S = simpleDec(strDQ(S))
    ElseIf LabelName = "encaspevalrun" Then
        S = encAspEvalRun(strDQ(S))
    ElseIf LabelName = "send_email" Then
        S = Send_Email(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "serversend_email" Then
        S = ServerSend_Email(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)))
    ElseIf LabelName = "findaspcode" Then
        S = FindAspCode(strDQ(S))
    ElseIf LabelName = "findaspfunlist" Then
        S = FindAspFunList(strDQ(S))
    ElseIf LabelName = "findaspfunctioncode" Then
        S = FindAspFunctionCode(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlereplacelist" Then
        S = handleReplaceList(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getfunnamedim" Then
        S = GetFunNameDim(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "leftspace" Then
        S = LeftSpace(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "rightspace" Then
        S = RightSpace(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "infunadddim" Then
        S = InFunAddDim(strDQ(S))
    ElseIf LabelName = "getqq" Then
        S = GetQQ(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "gettel" Then
        S = GetTel(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getmail" Then
        S = GetMail(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getimgstr" Then
        S = GetImgStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getcssstr" Then
        S = GetCssStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getjsstr" Then
        S = GetJsStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "handleaspexecute" Then
        S = HandleAspExecute(strDQ(S))
    ElseIf LabelName = "geturlstr" Then
        S = GetUrlStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "getpageconfig" Then
        S = GetPageConfig(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getsqlinurl" Then
        S = GetSqlInUrl(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "handlsqlinurl" Then
        S = HandlSqlInUrl(strDQ(S))
    ElseIf LabelName = "getscanfunctionnamelist" Then
        S = GetScanFunctionNameList(strDQ(S))
    ElseIf LabelName = "getfunname" Then
        S = GetFunName(strDQ(S))
    ElseIf LabelName = "getfundimname" Then
        S = GetFunDimName(strDQ(S))
    ElseIf LabelName = "getdimname" Then
        S = GetDimName(strDQ(S))
    ElseIf LabelName = "getsetname" Then
        S = GetSetName(strDQ(S))
    ElseIf LabelName = "replacedim" Then
        S = ReplaceDim(strDQ(S))
    ElseIf LabelName = "replacedim2" Then
        S = ReplaceDim2(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "findfolderrepeatfunction" Then
        S = FindFolderRepeatFunction(strDQ(S))
    ElseIf LabelName = "findfilerepeatfunction" Then
        S = FindFileRepeatFunction(strDQ(S))
    ElseIf LabelName = "findcontentrepeatfunction" Then
        S = FindContentRepeatFunction(strDQ(S))
    ElseIf LabelName = "handlecontentrepeatfunction" Then
        S = HandleContentRepeatFunction(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "replace2" Then
        S = Replace2(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "allreplace" Then
        S = AllReplace(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "replaceonenolu" Then
        S = ReplaceOneNOLU(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "optimizeaspcode" Then
        S = OptimizeAspCode(strDQ(S))
    ElseIf LabelName = "aspcodeconfusion" Then
        S = AspCodeConfusion(strDQ(S))
    ElseIf LabelName = "aspvariablegarbled" Then
        S = ASPVariableGarbled(strDQ(S))
    ElseIf LabelName = "lucasegarbled" Then
        S = LUCaseGarbled(strDQ(S))
    ElseIf LabelName = "aspfunctionconfusion" Then
        S = AspFunctionConfusion(strDQ(S))
    ElseIf LabelName = "getaspfunnamelist" Then
        S = getAspFunNameList(strDQ(S))
    ElseIf LabelName = "aspcodesafe" Then
        S = AspCodeSafe(strDQ(S))
    ElseIf LabelName = "cutdakuohao" Then
        S = cutDaKuoHao(strDQ(S))
    ElseIf LabelName = "cutxiankuohao" Then
        S = cutXianKuoHao(strDQ(S))
    ElseIf LabelName = "cutfunctionvvalue" Then
        S = cutFunctionvValue(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getstrintcontentnumb" Then
        S = getStrIntContentNumb(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getkeyword" Then
        S = GetKeyWord(strDQ(S))
    ElseIf LabelName = "gethandlekeyword" Then
        S = GetHandleKeyWord(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getchinastr" Then
        S = GetChinaStr(strDQ(S))
    ElseIf LabelName = "checkstr" Then
        S = checkStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "regexp_checkstr" Then
        S = regExp_CheckStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "existsstr" Then
        S = existsStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "regexp_instr" Then
        S = regExp_Instr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "regexp_replace" Then
        S = regExp_Replace(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "replacecolor" Then
        S = replaceColor(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "delhtml" Then
        S = delHtml(strDQ(S))
    ElseIf LabelName = "regexp_delhtml" Then
        S = regExp_DelHtml(strDQ(S))
    ElseIf LabelName = "getaurltitlelist" Then
        S = getAUrlTitleList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getaurl" Then
        S = getAURL(strDQ(S))
    ElseIf LabelName = "getatitle" Then
        S = getATitle(strDQ(S))
    ElseIf LabelName = "getaurltitle" Then
        S = getAURLTitle(strDQ(S))
    ElseIf LabelName = "getcontentaurllist" Then
        S = getContentAUrlList(strDQ(S))
    ElseIf LabelName = "regexp_getimgurllist" Then
        S = regExp_GetImgUrlList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getimg" Then
        S = getIMG(strDQ(S))
    ElseIf LabelName = "getimgjpg" Then
        S = getIMGJpg(strDQ(S))
    ElseIf LabelName = "getimggif" Then
        S = getIMGGif(strDQ(S))
    ElseIf LabelName = "getimgbmp" Then
        S = getIMGBmp(strDQ(S))
    ElseIf LabelName = "getaspfunctionlist" Then
        S = getASPFunctionList(strDQ(S))
    ElseIf LabelName = "getaspdimfunction" Then
        S = getASPDimFunction(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "strlength" Then
        S = strLength(strDQ(S))
    ElseIf LabelName = "regexpgetlenght" Then
        S = regExpGetLenght(strDQ(S))
    ElseIf LabelName = "stringlength" Then
        S = stringLength(strDQ(S))
    ElseIf LabelName = "getcsshref" Then
        S = getCssHref(strDQ(S))
    ElseIf LabelName = "getjssrc" Then
        S = getJsSrc(strDQ(S))
    ElseIf LabelName = "delhtmlscript" Then
        S = delHTMLScript(strDQ(S))
    ElseIf LabelName = "getmeta" Then
        S = getMeta(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "delhtmlnote" Then
        S = delHtmlNote(strDQ(S))
    ElseIf LabelName = "delhtmlmynote" Then
        S = delHtmlMyNote(strDQ(S))
    ElseIf LabelName = "getstrimglist" Then
        S = getStrImgList(strDQ(S))
    ElseIf LabelName = "getemaillist" Then
        S = getEMailList(strDQ(S))
    ElseIf LabelName = "oflink_lcasetag" Then
        S = oflink_lcasetag(strDQ(S))
    ElseIf LabelName = "scripthtml" Then
        S = scriptHtml(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getregexp" Then
        S = getRegExp(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "getimgjsurl" Then
        S = getImgJsUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "regexpgetstr" Then
        S = regExpGetStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "newgetpingip" Then
        S = newGetPingIP(strDQ(S))
    ElseIf LabelName = "getpingip" Then
        S = getPingIP(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getpinginfo" Then
        S = getPingInfo(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "regexptest" Then
        S = regExpTest(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getregexpstr" Then
        S = getRegExpStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "regexpreplacecssdir" Then
        S = regExpReplaceCssDir(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deletenullrow" Then
        S = deleteNullRow(strDQ(S))
    ElseIf LabelName = "isstrtransferred" Then
        S = isStrTransferred(strDQ(S))
    ElseIf LabelName = "getbl" Then
        S = getBL(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getcountstep" Then
        S = getCountStep(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "getchina" Then
        S = getChina(strDQ(S))
    ElseIf LabelName = "ischina" Then
        S = isChina(strDQ(S))
    ElseIf LabelName = "checkchina" Then
        S = checkChina(strDQ(S))
    ElseIf LabelName = "phprand" Then
        S = pHPRand(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "phprnd" Then
        S = pHPRnd(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deleterepeatstr" Then
        S = deleteRepeatStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "replacen" Then
        S = replaceN(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "fillzero" Then
        S = fillZero(strDQ(S))
    ElseIf LabelName = "caseinsensitivereplace" Then
        S = caseInsensitiveReplace(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "array_sort" Then
        S = array_Sort(strDQ(S))
    ElseIf LabelName = "handlezipsize" Then
        S = handleZipSize(strDQ(S))
    ElseIf LabelName = "getrnd" Then
        S = getRnd(strDQ(S))
    ElseIf LabelName = "mathrandom" Then
        S = mathRandom()
    ElseIf LabelName = "getrndaz" Then
        S = getRndAZ(strDQ(S))
    ElseIf LabelName = "getrand" Then
        S = getRand(strDQ(S))
    ElseIf LabelName = "copystrnumb" Then
        S = copyStrNumb(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "str_repeat" Then
        S = str_Repeat(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "copystr" Then
        S = copyStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "contentaddtab" Then
        S = contentAddTab(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deleteendstr" Then
        S = deleteEndStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "tonumber" Then
        S = toNumber(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlenumber" Then
        S = handleNumber(strDQ(S))
    ElseIf LabelName = "strdrawint" Then
        S = strDrawInt(strDQ(S))
    ElseIf LabelName = "getfirstnegativenumber" Then
        S = getFirstNegativeNumber(strDQ(S))
    ElseIf LabelName = "checknumbertype" Then
        S = checkNumberType(strDQ(S))
    ElseIf LabelName = "checkstrisnumbertype" Then
        S = checkStrIsNumberType(strDQ(S))
    ElseIf LabelName = "handlenumbertype" Then
        S = handleNumberType(strDQ(S))
    ElseIf LabelName = "getnumber" Then
        S = getNumber(strDQ(S))
    ElseIf LabelName = "checknumb" Then
        S = checkNumb(strDQ(S))
    ElseIf LabelName = "getdiannumb" Then
        S = getDianNumb(strDQ(S))
    ElseIf LabelName = "getcountpage" Then
        S = getCountPage(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getpagenumb" Then
        S = getPageNumb(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getcaihandlecountpage" Then
        S = getCaiHandleCountPage(strDQ(S))
    ElseIf LabelName = "getcaisortcountpage" Then
        S = getCaiSortCountPage(strDQ(S))
    ElseIf LabelName = "minmaxbetween" Then
        S = minMaxBetween(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getstrfiletype" Then
        S = getStrFileType(strDQ(S))
    ElseIf LabelName = "val" Then
        S = val(strDQ(S))
    ElseIf LabelName = "strlen" Then
        S = strLen(strDQ(S))
    ElseIf LabelName = "addindent" Then
        S = addIndent(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getnumberbeforestr" Then
        S = getNumberBeforeStr(strDQ(S))
    ElseIf LabelName = "makepassword" Then
        S = makePassword(strDQ(S))
    ElseIf LabelName = "rndcode" Then
        S = rndcode(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getrandomphonenumber" Then
        S = getRandomPhoneNumber(strDQ(S))
    ElseIf LabelName = "lenstr" Then
        S = lenStr(strDQ(S))
    ElseIf LabelName = "tostring" Then
        S = toString(strDQ(S))
    ElseIf LabelName = "remotenumber" Then
        S = remoteNumber(strDQ(S))
    ElseIf LabelName = "handlehavestr" Then
        S = handleHaveStr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "havelowercase" Then
        S = haveLowerCase(strDQ(S))
    ElseIf LabelName = "haveuppercase" Then
        S = haveUpperCase(strDQ(S))
    ElseIf LabelName = "havenumber" Then
        S = haveNumber(strDQ(S))
    ElseIf LabelName = "havechina" Then
        S = haveChina(strDQ(S))
    ElseIf LabelName = "saveremotefile" Then
        S = SaveRemoteFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "downfile" Then
        S = DownFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "popupdownfile" Then
        S = popupDownFile(strDQ(S))
    ElseIf LabelName = "xmlgetstatus" Then
        S = XMLGetStatus(strDQ(S))
    ElseIf LabelName = "xmlpost" Then
        S = XMLPost(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "utfxmlpost" Then
        S = UTFXMLPost(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlexmlpost" Then
        S = HandleXMLPost(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "xmlget" Then
        S = XmlGet(strDQ(S))
    ElseIf LabelName = "handlexmlget" Then
        S = handleXmlGet(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "cookiespost" Then
        S = CookiesPost(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlecookiespost" Then
        S = handleCookiesPost(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getremotefilesize" Then
        S = getRemoteFileSize(strDQ(S))
    ElseIf LabelName = "downremotefile" Then
        S = DownRemoteFile(strDQ(S))
    ElseIf LabelName = "imagestobase64" Then
        S = ImagesToBase64(strDQ(S))
    ElseIf LabelName = "base64toimages" Then
        S = Base64ToImages(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getsqlincontent" Then
        S = getSqlInContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handlesqlin" Then
        S = handleSqlIn(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "sqlinurl" Then
        S = SqlInUrl(strDQ(S))
    ElseIf LabelName = "handlurlcanshu" Then
        S = HandlUrlCanShu(strDQ(S))
    ElseIf LabelName = "handlestrcharset" Then
        S = handleStrCharSet(strDQ(S))
    ElseIf LabelName = "urlencoding" Then
        S = URLEncoding(strDQ(S))
    ElseIf LabelName = "getwinhttp" Then
        S = getWinHttp(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "format_time" Then
        S = format_Time(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getdaystatus" Then
        S = getDayStatus(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "printtimevalue" Then
        S = printTimeValue(strDQ(S))
    ElseIf LabelName = "printasktime" Then
        S = printAskTime(strDQ(S))
    ElseIf LabelName = "gettimerset" Then
        S = getTimerSet()
    ElseIf LabelName = "calculationtimer" Then
        S = calculationTimer(strDQ(S))
    ElseIf LabelName = "gettimer" Then
        S = getTimer()
    ElseIf LabelName = "vbgettimer" Then
        S = vBGetTimer()
    ElseIf LabelName = "vbechotimer" Then
        S = vBEchoTimer()
    ElseIf LabelName = "vbruntimer" Then
        S = vBRunTimer(strDQ(S))
    ElseIf LabelName = "getthisurlnoparam" Then
        S = getThisUrlNoParam()
    ElseIf LabelName = "getgotourl" Then
        S = getGoToUrl()
    ElseIf LabelName = "getgotourlnoparam" Then
        S = getGoToUrlNoParam()
    ElseIf LabelName = "getgotourlnofilename" Then
        S = getGoToUrlNoFileName()
    ElseIf LabelName = "getip2" Then
        S = getIP2()
    ElseIf LabelName = "getip" Then
        S = getIP()
    ElseIf LabelName = "getservicerip" Then
        S = getServicerIP()
    ElseIf LabelName = "getremoteip" Then
        S = getRemoteIP()
    ElseIf LabelName = "handlehttpurl" Then
        S = handleHttpUrl(strDQ(S))
    ElseIf LabelName = "handlefileurl" Then
        S = handleFileUrl(strDQ(S))
    ElseIf LabelName = "handleurlcomplete" Then
        S = handleUrlComplete(strDQ(S))
    ElseIf LabelName = "urladdhttpurl" Then
        S = urlAddHttpUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "webdomain" Then
        S = webDoMain()
    ElseIf LabelName = "host" Then
        S = host()
    ElseIf LabelName = "httphost" Then
        S = httpHost()
    ElseIf LabelName = "gethost" Then
        S = getHost()
    ElseIf LabelName = "geturl" Then
        S = getUrl()
    ElseIf LabelName = "getthisurl" Then
        S = getThisUrl()
    ElseIf LabelName = "getthisurlnofilename" Then
        S = getThisUrlNoFileName()
    ElseIf LabelName = "getwebsite" Then
        S = getWebSite(strDQ(S))
    ElseIf LabelName = "checkurl" Then
        S = checkUrl(strDQ(S))
    ElseIf LabelName = "checkhttpurl" Then
        S = checkHttpUrl(strDQ(S))
    ElseIf LabelName = "isurl" Then
        S = isUrl(strDQ(S))
    ElseIf LabelName = "ishttpurl" Then
        S = isHttpUrl(strDQ(S))
    ElseIf LabelName = "fullhttpurl" Then
        S = fullHttpUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "batchfullhttpurl" Then
        S = batchFullHttpUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "urljianjiehandle" Then
        S = uRLJianJieHandle(strDQ(S))
    ElseIf LabelName = "urltoasc" Then
        S = urlToAsc(strDQ(S))
    ElseIf LabelName = "getwebtitle" Then
        S = getWebTitle(strDQ(S))
    ElseIf LabelName = "mystrcut" Then
        S = myStrCut(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "getcontentahref" Then
        S = getContentAHref(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "getcontentimgsrc" Then
        S = getContentImgSrc(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handleconenturl" Then
        S = handleConentUrl(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "replacecontentjsdir" Then
        S = replaceContentJsDir(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handlelink" Then
        S = handleLink(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)),strDQ(Splxx(6)))
    ElseIf LabelName = "getendurlhandlename" Then
        S = getEndUrlHandleName(strDQ(S))
    ElseIf LabelName = "getwebfoldername" Then
        S = getWebFolderName()
    ElseIf LabelName = "getwebhome" Then
        S = getWebHome()
    ElseIf LabelName = "geturllistinwebsitelist" Then
        S = getUrlListInWebSiteList(strDQ(S))
    ElseIf LabelName = "getthisurlfilename" Then
        S = getThisUrlFileName()
    ElseIf LabelName = "handlewebhtmlimg" Then
        S = handleWebHtmlImg(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handlewebcssimg" Then
        S = handleWebCssImg(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "batchhandleurlintegrity" Then
        S = batchHandleUrlIntegrity(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "replacecontentimagepath" Then
        S = replaceContentImagePath(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getcsslinklist" Then
        S = getCssLinkList(strDQ(S))
    ElseIf LabelName = "gethtmlbackgroundurllist" Then
        S = getHtmlBackGroundUrlList(strDQ(S))
    ElseIf LabelName = "getimgurllist" Then
        S = getImgUrlList(strDQ(S))
    ElseIf LabelName = "getlinkurl" Then
        S = getLinkUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "localurlorremoteurl" Then
        S = localUrlOrRemoteUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkremoteurl" Then
        S = checkRemoteUrl(strDQ(S))
    ElseIf LabelName = "gethandleurl" Then
        S = getHandleUrl(strDQ(S))
    ElseIf LabelName = "webdebug" Then
        S = webDebug(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "asailinkadd" Then
        S = asaiLinkAdd(strDQ(S))
    ElseIf LabelName = "asailinkdel" Then
        S = asaiLinkDel(strDQ(S))
    ElseIf LabelName = "iswww" Then
        S = iswww(strDQ(S))
    ElseIf LabelName = "geturladdtoparam" Then
        S = getUrlAddToParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "groupurl" Then
        S = groupUrl(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlepostcookiesparame" Then
        S = handlePostCookiesParame(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "remotehttpurlparameter" Then
        S = remoteHttpUrlParameter(strDQ(S))
    ElseIf LabelName = "checkurlname" Then
        S = checkUrlName(strDQ(S))
    ElseIf LabelName = "handlehttpurlarray" Then
        S = handleHttpUrlArray(strDQ(S))
    ElseIf LabelName = "remotejscssparam" Then
        S = remoteJsCssParam(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handleremotejscssparam" Then
        S = handleRemoteJsCssParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "batchhandlehttpurlcomplete" Then
        S = batchHandleHttpUrlComplete(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "iswebsite" Then
        S = isWebSite(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "issonwebsite" Then
        S = isSonWebSite(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handleiswebsite" Then
        S = handleIsWebSite(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getcontenturllist" Then
        S = getContentUrlList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlegetcontenturllist" Then
        S = handleGetContentUrlList(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getinchain" Then
        S = getInChain(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getfiletext" Then
        S = getFileText(strDQ(S))
    ElseIf LabelName = "getftext" Then
        S = getFText(strDQ(S))
    ElseIf LabelName = "getfiletype" Then
        S = getFileType(strDQ(S))
    ElseIf LabelName = "checkfile" Then
        S = checkFile(strDQ(S))
    ElseIf LabelName = "existsfile" Then
        S = existsFile(strDQ(S))
    ElseIf LabelName = "createfile" Then
        S = createFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "savefile" Then
        S = saveFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "createaddfile" Then
        S = createAddFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "createaddupfile" Then
        S = createAddUpFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "addtofile" Then
        S = addToFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "savebytefile" Then
        S = saveByteFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "createbytefile" Then
        S = createByteFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "movefile" Then
        S = moveFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "editfile" Then
        S = editFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "copyfile" Then
        S = copyFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deletefile" Then
        S = deleteFile(strDQ(S))
    ElseIf LabelName = "delselfile" Then
        S = delSelFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "delfilelist" Then
        S = delFileList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "batchdelfile" Then
        S = batchDelFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deleteappointfilelist" Then
        S = deleteAppointFileList(strDQ(S))
    ElseIf LabelName = "getfilesize" Then
        S = getFileSize(strDQ(S))
    ElseIf LabelName = "filesize" Then
        S = fileSize(strDQ(S))
    ElseIf LabelName = "getfsize" Then
        S = getFSize(strDQ(S))
    ElseIf LabelName = "getfilecreatedate" Then
        S = getFileCreateDate(strDQ(S))
    ElseIf LabelName = "filecreatedate" Then
        S = fileCreateDate(strDQ(S))
    ElseIf LabelName = "getfileeditdate" Then
        S = getFileEditDate(strDQ(S))
    ElseIf LabelName = "fileeditdate" Then
        S = fileEditDate(strDQ(S))
    ElseIf LabelName = "getfileedittime" Then
        S = getFileEditTime(strDQ(S))
    ElseIf LabelName = "getdatelastaccessed" Then
        S = getDateLastAccessed(strDQ(S))
    ElseIf LabelName = "modifyfilemodifydate" Then
        S = modifyFileModifydate(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "editfileeditdate" Then
        S = editFileEditDate(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "existszhidufile" Then
        S = existsZhiDuFile(strDQ(S))
    ElseIf LabelName = "getfileattribute" Then
        S = getFileAttribute(strDQ(S))
    ElseIf LabelName = "editfileattribute" Then
        S = editFileAttribute(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "existsfileday" Then
        S = existsFileDay(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkfileday" Then
        S = checkFileDay(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "createfolder" Then
        S = createFolder(strDQ(S))
    ElseIf LabelName = "createdirfolder" Then
        S = createDirFolder(strDQ(S))
    ElseIf LabelName = "createdomain" Then
        S = createDomain(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "createdomainfolder" Then
        S = createDomainFolder(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "movefolder" Then
        S = moveFolder(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "editfolder" Then
        S = editFolder(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "copyfolder" Then
        S = copyFolder(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deletefolder" Then
        S = deleteFolder(strDQ(S))
    ElseIf LabelName = "getfoldersize" Then
        S = getFolderSize(strDQ(S))
    ElseIf LabelName = "checkfolder" Then
        S = checkFolder(strDQ(S))
    ElseIf LabelName = "existsfolder" Then
        S = existsFolder(strDQ(S))
    ElseIf LabelName = "getfoldercreatedate" Then
        S = getFolderCreateDate(strDQ(S))
    ElseIf LabelName = "getfoldereditdate" Then
        S = getFolderEditDate(strDQ(S))
    ElseIf LabelName = "getfoldertime" Then
        S = getFolderTime(strDQ(S))
    ElseIf LabelName = "getfolderattribute" Then
        S = getFolderAttribute(strDQ(S))
    ElseIf LabelName = "editfolderattribute" Then
        S = editFolderAttribute(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "existsfolderday" Then
        S = existsFolderDay(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkfolderday" Then
        S = checkFolderDay(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getfilefolderlist" Then
        S = getFileFolderList(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)),strDQ(Splxx(6)))
    ElseIf LabelName = "getdirjpglist" Then
        S = getDirJpgList(strDQ(S))
    ElseIf LabelName = "getdirinilist" Then
        S = getDirIniList(strDQ(S))
    ElseIf LabelName = "getdirtxtlist" Then
        S = getDirTxtList(strDQ(S))
    ElseIf LabelName = "getdirhtmllist" Then
        S = getDirHtmlList(strDQ(S))
    ElseIf LabelName = "getdircsslist" Then
        S = getDirCssList(strDQ(S))
    ElseIf LabelName = "getdirjslist" Then
        S = getDirJsList(strDQ(S))
    ElseIf LabelName = "getdirfilelist" Then
        S = getDirFileList(strDQ(S))
    ElseIf LabelName = "getdirhtmllistname" Then
        S = getDirHtmlListName(strDQ(S))
    ElseIf LabelName = "getdirfilenamelist" Then
        S = getDirFileNameList(strDQ(S))
    ElseIf LabelName = "getdirallfilenamelist" Then
        S = getDirAllFileNameList(strDQ(S))
    ElseIf LabelName = "getdirfolderlist" Then
        S = getDirFolderList(strDQ(S))
    ElseIf LabelName = "getdirfoldernamelist" Then
        S = getDirFolderNameList(strDQ(S))
    ElseIf LabelName = "getthisallfolder" Then
        S = getThisAllFolder(strDQ(S))
    ElseIf LabelName = "getthisallfoldername" Then
        S = getThisAllFolderName(strDQ(S))
    ElseIf LabelName = "getfilefoldernumb" Then
        S = getFileFolderNumb(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getdirfoldernumb" Then
        S = getDirFolderNumb(strDQ(S))
    ElseIf LabelName = "getdirfoldersize" Then
        S = getDirFolderSize(strDQ(S))
    ElseIf LabelName = "getdirfilenumb" Then
        S = getDirFileNumb(strDQ(S))
    ElseIf LabelName = "getdirallfilenumb" Then
        S = getDirAllFileNumb(strDQ(S))
    ElseIf LabelName = "getdirallfoldernumb" Then
        S = getDirAllFolderNumb(strDQ(S))
    ElseIf LabelName = "getfolderlist" Then
        S = getFolderList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getdirfilesort" Then
        S = getDirFileSort(strDQ(S))
    ElseIf LabelName = "getdirfoldersort" Then
        S = getDirFolderSort(strDQ(S))
    ElseIf LabelName = "deldirallfile" Then
        Call delDirAllFile(strDQ(S))
    ElseIf LabelName = "deleteallfile" Then
        Call deleteAllFile(strDQ(S))
    ElseIf LabelName = "getupdatefile" Then
        S = getUpdateFile(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "handlepath" Then
        S = handlePath(strDQ(S))
    ElseIf LabelName = "realpath" Then
        S = realPath(strDQ(S))
    ElseIf LabelName = "fullpath" Then
        S = fullPath(strDQ(S))
    ElseIf LabelName = "handlerelativepath" Then
        S = handleRelativePath(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "dirname" Then
        S = dirName(strDQ(S))
    ElseIf LabelName = "isobjinstalled" Then
        S = isObjInstalled(strDQ(S))
    ElseIf LabelName = "existsobject" Then
        S = existsObject(strDQ(S))
    ElseIf LabelName = "getfileobject" Then
        S = getFileObject()
    ElseIf LabelName = "getdictionary" Then
        S = getDictionary()
    ElseIf LabelName = "getstream" Then
        S = getStream()
    ElseIf LabelName = "showattributetip" Then
        S = showAttributeTip(strDQ(S))
    ElseIf LabelName = "printspacevalue" Then
        S = printSpaceValue(strDQ(S))
    ElseIf LabelName = "printspacesize" Then
        S = printSpaceSize(strDQ(S))
    ElseIf LabelName = "printfilesize" Then
        S = printFileSize(strDQ(S))
    ElseIf LabelName = "getdeskpath" Then
        S = getDeskPath()
    ElseIf LabelName = "createurlshortcut" Then
        S = createUrlShortcut(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "createfoldershortcut" Then
        S = createFolderShortcut(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "finddirfilename" Then
        S = findDirFileName(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "findsubdirfilename" Then
        S = findSubDirFileName(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getarticlefillcontent" Then
        S = getArticleFillContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getfilepathname" Then
        S = getFilePathName(strDQ(S))
    ElseIf LabelName = "getextension" Then
        S = getExtension(strDQ(S))
    ElseIf LabelName = "removefiledir" Then
        S = removeFileDir(strDQ(S))
    ElseIf LabelName = "basename" Then
        S = baseName(strDQ(S))
    ElseIf LabelName = "getfileextname" Then
        S = getFileExtName(strDQ(S))
    ElseIf LabelName = "handlefilepatharray" Then
        S = handleFilePathArray(strDQ(S))
    ElseIf LabelName = "getstrfilename" Then
        S = getStrFileName(strDQ(S))
    ElseIf LabelName = "getfilename" Then
        S = getFileName(strDQ(S))
    ElseIf LabelName = "getfileattr" Then
        S = getFileAttr(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getfileext" Then
        S = getFileExt(strDQ(S))
    ElseIf LabelName = "getparentpath" Then
        S = getParentPath(strDQ(S))
    ElseIf LabelName = "isucase" Then
        S = isUCase(strDQ(S))
    ElseIf LabelName = "islcase" Then
        S = isLCase(strDQ(S))
    ElseIf LabelName = "checkerr" Then
        Call checkErr(strDQ(S))
    ElseIf LabelName = "strtotruefalse" Then
        S = strToTrueFalse(strDQ(S))
    ElseIf LabelName = "strtruefalsetoint" Then
        S = strTrueFalseToInt(strDQ(S))
    ElseIf LabelName = "checkvbcrlf" Then
        S = checkVbCrlf(strDQ(S))
    ElseIf LabelName = "checkbr" Then
        S = checkBr(strDQ(S))
    ElseIf LabelName = "isparity" Then
        S = isParity(strDQ(S))
    ElseIf LabelName = "checkeval" Then
        S = checkEval(strDQ(S))
    ElseIf LabelName = "replace_sqltext" Then
        S = replace_SQLText(strDQ(S))
    ElseIf LabelName = "chkpost" Then
        S = chkPost()
    ElseIf LabelName = "ismail" Then
        S = isMail(strDQ(S))
    ElseIf LabelName = "isvalidemail" Then
        S = isValidEmail(strDQ(S))
    ElseIf LabelName = "iscode" Then
        S = isCode(strDQ(S))
    ElseIf LabelName = "checknumber" Then
        S = checkNumber(strDQ(S))
    ElseIf LabelName = "isnumber" Then
        S = isNumber(strDQ(S))
    ElseIf LabelName = "checkabc" Then
        S = checkABC(strDQ(S))
    ElseIf LabelName = "getlen" Then
        S = getLen(strDQ(S))
    ElseIf LabelName = "checktime" Then
        S = checkTime(strDQ(S))
    ElseIf LabelName = "isnul" Then
        S = isNul(strDQ(S))
    ElseIf LabelName = "foundinarr" Then
        S = foundInArr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "showhtmlcode" Then
        S = showHTMLCode(strDQ(S))
    ElseIf LabelName = "showhtml" Then
        S = ShowHtml(strDQ(S))
    ElseIf LabelName = "unhtmlcode" Then
        S = unHTMLCode(strDQ(S))
    ElseIf LabelName = "echohtml" Then
        S = EchoHTML(strDQ(S))
    ElseIf LabelName = "errortext" Then
        S = ErrorText(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "testhtml" Then
        Call TestHtml()
    ElseIf LabelName = "htmldecode" Then
        S = HtmlDecode(strDQ(S))
    ElseIf LabelName = "htmlencode" Then
        S = HtmlEncode(strDQ(S))
    ElseIf LabelName = "htmlfilter" Then
        S = HtmlFilter(strDQ(S))
    ElseIf LabelName = "regreplace" Then
        S = regReplace(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "easp_replace" Then
        S = Easp_Replace(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handlehtmllabelclose" Then
        S = handleHtmlLabelClose(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "handleimgclose" Then
        S = handleImgClose(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlebrclose" Then
        S = handleBrClose(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlehrclose" Then
        S = handleHrClose(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handleclosehtml" Then
        S = handleCloseHtml(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "htmllabeltoclean" Then
        S = htmlLabelToClean(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "addtooraddhttpurl" Then
        S = addToOrAddHttpUrl(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "removeblanklines" Then
        S = removeBlankLines(strDQ(S))
    ElseIf LabelName = "removeblanklines_test1" Then
        S = removeBlankLines_test1(strDQ(S))
    ElseIf LabelName = "blankhtmlbody" Then
        S = blankHtmlBody(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkcode" Then
        S = checkCode(strDQ(S))
    ElseIf LabelName = "getfilecharset" Then
        S = getFileCharset(strDQ(S))
    ElseIf LabelName = "seniorcheckcode" Then
        S = seniorCheckCode(strDQ(S))
    ElseIf LabelName = "readfile" Then
        S = readFile(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getstext" Then
        S = getStext(strDQ(S))
    ElseIf LabelName = "getftextutf" Then
        S = getFTextUTF(strDQ(S))
    ElseIf LabelName = "writetofile" Then
        S = writeToFile(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "createfileutf" Then
        S = createFileUTF(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getugtext" Then
        S = getUGText(strDQ(S))
    ElseIf LabelName = "checkcontentcharset" Then
        S = checkContentCharset(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkfilecode" Then
        S = checkFileCode(strDQ(S))
    ElseIf LabelName = "getfilebinarycontent" Then
        S = getFileBinaryContent(strDQ(S))
    ElseIf LabelName = "binaryreadfile" Then
        S = binaryReadFile(strDQ(S))
    ElseIf LabelName = "readbinary" Then
        S = readBinary(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "decsavebinary" Then
        S = decSaveBinary(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "writebinary" Then
        Call writeBinary(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getfilecharset2" Then
        S = getFileCharset2(strDQ(S))
    ElseIf LabelName = "bintohex" Then
        S = binToHex(strDQ(S))
    ElseIf LabelName = "base64encode" Then
        S = Base64Encode(strDQ(S))
    ElseIf LabelName = "base64decode" Then
        S = Base64Decode(strDQ(S))
    ElseIf LabelName = "asphelptip" Then
        S = ASPHelpTip(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlewrite" Then
        S = HandleWrite(strDQ(S))
    ElseIf LabelName = "jiantitabfanti" Then
        S = JianTiTabFanTi(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "jiyicireplace" Then
        S = JiYiCiReplace(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "cireplace" Then
        S = CiReplace(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "testgetpy" Then
        Call testGetPY()
    ElseIf LabelName = "pinyin" Then
        S = pinYin(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "pinyin2" Then
        S = pinYin2(strDQ(S))
    ElseIf LabelName = "entocompany" Then
        S = enToCompany(strDQ(S))
    ElseIf LabelName = "remotecontentjinghao" Then
        S = remoteContentJingHao(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "remotearrayjinghao" Then
        S = remoteArrayJingHao(strDQ(S))
    ElseIf LabelName = "geteachstraddvalue" Then
        S = getEachStrAddValue(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getvalueinarrayid" Then
        S = getValueInArrayID(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkvalueinarray" Then
        S = checkValueInArray(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deleterepeatarray" Then
        S = deleteRepeatArray(strDQ(S))
    ElseIf LabelName = "deleterepeatcontent" Then
        S = deleteRepeatContent(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getarraycount" Then
        S = getArrayCount(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "randomshow" Then
        S = randomShow(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "arrayrandomshow" Then
        S = arrayRandomShow(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "printarray" Then
        Call printArray(strDQ(S))
    ElseIf LabelName = "echoarray" Then
        Call echoArray(strDQ(S))
    ElseIf LabelName = "str_shuffle" Then
        S = str_Shuffle(strDQ(S))
    ElseIf LabelName = "characterupset" Then
        S = characterUpset(strDQ(S))
    ElseIf LabelName = "str_split" Then
        S = str_Split(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "removenullvaluearray" Then
        S = removeNullValueArray(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "removerepeatvaluearray" Then
        S = removeRepeatValueArray(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlearray" Then
        S = handleArray(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "arraytostring" Then
        S = arrayToString(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "testarraydata" Then
        S = testArrayData()
    ElseIf LabelName = "selectsort" Then
        S = selectSort(strDQ(S))
    ElseIf LabelName = "quicksort" Then
        S = quickSort(strDQ(S))
    ElseIf LabelName = "bubblesort" Then
        S = bubbleSort(strDQ(S))
    ElseIf LabelName = "insertsort" Then
        S = insertSort(strDQ(S))
    ElseIf LabelName = "requicksort" Then
        S = reQuickSort(strDQ(S))
    ElseIf LabelName = "arrayreverse" Then
        S = arrayReverse()
    ElseIf LabelName = "responsearray" Then
        Call responseArray(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "max" Then
        S = max(strDQ(S))
    ElseIf LabelName = "min" Then
        S = min(strDQ(S))
    ElseIf LabelName = "testtwodimensionalarray" Then
        S = testTwoDimensionalArray()
    ElseIf LabelName = "handlesplitarray" Then
        S = handleSplitArray(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "twodimensionalarrayasc" Then
        S = twoDimensionalArrayAsc(strDQ(S))
    ElseIf LabelName = "twodimensionalarraydesc" Then
        S = twoDimensionalArrayDesc(strDQ(S))
    ElseIf LabelName = "csscompression" Then
        S = cssCompression(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "deletecssnote" Then
        S = deleteCssNote(strDQ(S))
    ElseIf LabelName = "uncsscompression" Then
        S = unCssCompression(strDQ(S))
    ElseIf LabelName = "trimvbcrlf" Then
        S = trimVbCrlf(strDQ(S))
    ElseIf LabelName = "phptrim" Then
        S = pHPTrim(strDQ(S))
    ElseIf LabelName = "ltrimvbcrlf" Then
        S = ltrimVBcrlf(strDQ(S))
    ElseIf LabelName = "rtrimvbcrlf" Then
        S = rtrimVBcrlf(strDQ(S))
    ElseIf LabelName = "trimvbtab" Then
        S = trimVbTab(strDQ(S))
    ElseIf LabelName = "ltrimvbtab" Then
        S = lTrimVbTab(strDQ(S))
    ElseIf LabelName = "rtrimvbtab" Then
        S = rTrimVBTab(strDQ(S))
    ElseIf LabelName = "gethtmlcssstyle" Then
        S = getHtmlCssStyle(strDQ(S))
    ElseIf LabelName = "handlecleancss" Then
        S = handleCleanCss(strDQ(S))
    ElseIf LabelName = "removeexcessrow" Then
        S = removeExcessRow(strDQ(S))
    ElseIf LabelName = "cssaddtostyle" Then
        S = cssAddToStyle(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "checkcssstyle" Then
        S = checkCssStyle(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "cssstyleaddtoparam" Then
        S = cssStyleAddToParam(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "findcssstyle" Then
        S = findCssStyle(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlecutcsscode" Then
        S = handleCutCssCode(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlecutdivcode" Then
        S = handleCutDivCode(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "gethtmlbackgroundimglist" Then
        S = getHtmlBackGroundImgList(strDQ(S))
    ElseIf LabelName = "gethandlewebhtmllink" Then
        S = getHandleWebHtmlLink(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getcsslisturllist" Then
        S = getCssListUrlList(strDQ(S))
    ElseIf LabelName = "handlereadcsscontent" Then
        S = handleReadCssContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "handlecsspx" Then
        S = handleCssPX(strDQ(S))
    ElseIf LabelName = "handlehtmlstyle" Then
        S = handleHtmlStyle(strDQ(S))
    ElseIf LabelName = "utf2gb" Then
        S = UTF2GB(strDQ(S))
    ElseIf LabelName = "checkutftogb2312" Then
        S = CheckUTFToGB2312(strDQ(S))
    ElseIf LabelName = "convchinese" Then
        S = ConvChinese(strDQ(S))
    ElseIf LabelName = "utf8_urlencoding" Then
        S = UTF8_URLEncoding(strDQ(S))
    ElseIf LabelName = "toutf8" Then
        S = toUTF8(strDQ(S))
    ElseIf LabelName = "chinese2unicode" Then
        S = chinese2unicode(strDQ(S))
    ElseIf LabelName = "isvalidhex" Then
        S = isvalidhex(strDQ(S))
    ElseIf LabelName = "escape" Then
        S = escape(strDQ(S))
    ElseIf LabelName = "unescape" Then
        S = unescape(strDQ(S))
    ElseIf LabelName = "chinesetounicode" Then
        S = ChineseToUnicode(strDQ(S))
    ElseIf LabelName = "unicodetochinese" Then
        S = UnicodeToChinese(strDQ(S))
    ElseIf LabelName = "urlencode" Then
        S = URLEncode(strDQ(S))
    ElseIf LabelName = "urldecode" Then
        S = URLDecode(strDQ(S))
    ElseIf LabelName = "gbtoutf8" Then
        S = GBtoUTF8(strDQ(S))
    ElseIf LabelName = "encdecurl" Then
        S = EncDecURL(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "encurl" Then
        S = EncURL(strDQ(S))
    ElseIf LabelName = "decurl" Then
        S = DecURL(strDQ(S))
    ElseIf LabelName = "infocolor" Then
        S = infoColor(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "imgerror" Then
        S = imgError()
    ElseIf LabelName = "targetstr" Then
        S = targetStr(strDQ(S))
    ElseIf LabelName = "atarget" Then
        S = aTarget(strDQ(S))
    ElseIf LabelName = "atitle" Then
        S = aTitle(strDQ(S))
    ElseIf LabelName = "imgalt" Then
        S = imgAlt(strDQ(S))
    ElseIf LabelName = "imgtitlealt" Then
        S = imgTitleAlt(strDQ(S))
    ElseIf LabelName = "arel" Then
        S = aRel(strDQ(S))
    ElseIf LabelName = "styleclass" Then
        S = styleClass(strDQ(S))
    ElseIf LabelName = "textfontb" Then
        S = textFontB(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "textfontcolor" Then
        S = textFontColor(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "fontcolorfontb" Then
        S = fontColorFontB(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getdefaultfilename" Then
        S = getDefaultFileName()
    ElseIf LabelName = "ahref" Then
        S = aHref(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "imgsrc" Then
        S = imgSrc(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "selecttarget" Then
        S = selectTarget(strDQ(S))
    ElseIf LabelName = "selectfontcolor" Then
        S = selectFontColor(strDQ(S))
    ElseIf LabelName = "selectsex" Then
        S = selectSex(strDQ(S))
    ElseIf LabelName = "selectsessioncookies" Then
        S = selectSessionCookies(strDQ(S))
    ElseIf LabelName = "showselectlist" Then
        S = showSelectList(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "showarticleliststyle" Then
        S = showArticleListStyle(strDQ(S))
    ElseIf LabelName = "showarticleinfostyle" Then
        S = showArticleInfoStyle(strDQ(S))
    ElseIf LabelName = "handlearticleliststyleorinfostyle" Then
        S = handleArticleListStyleOrInfoStyle(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "showwebmoduleskins" Then
        S = showWebModuleSkins(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "showradiolist" Then
        S = showRadioList(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputcheckbox" Then
        S = inputCheckBox(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "inputcheckbox3" Then
        S = inputCheckBox3(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handleinputcheckbox" Then
        S = handleInputCheckBox(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "inputtext" Then
        S = inputText(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputtext2" Then
        S = inputText2(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "inputlefttext" Then
        S = inputLeftText(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputlefttexthelptextright" Then
        S = inputLeftTextHelpTextRight(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputlefttextcontent" Then
        S = inputLeftTextContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputrighttextcontent" Then
        S = inputRightTextContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handleinputleftrighttextcontent" Then
        S = handleInputLeftRightTextContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "inputleftpasstext" Then
        S = inputLeftPassText(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputleftpasstextcontent" Then
        S = inputLeftPassTextContent(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "inputhiddentext" Then
        S = inputHiddenText(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "inputtextarea" Then
        S = inputTextArea(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "inputhiddentextarea" Then
        S = inputHiddenTextArea(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "handleinputhiddentextarea" Then
        S = handleInputHiddenTextArea(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)))
    ElseIf LabelName = "showselectdirlist" Then
        S = showSelectDirList(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "inputdisabled" Then
        S = inputDisabled(strDQ(S))
    ElseIf LabelName = "inputaddalt" Then
        S = inputAddAlt(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "webtitle_inputtextarea" Then
        S = webTitle_InputTextArea(strDQ(S))
    ElseIf LabelName = "webkeywords_inputtext" Then
        S = webKeywords_InputText(strDQ(S))
    ElseIf LabelName = "webdescription_inputtextarea" Then
        S = webDescription_InputTextArea(strDQ(S))
    ElseIf LabelName = "foldername_inputtext" Then
        S = folderName_InputText(strDQ(S))
    ElseIf LabelName = "filename_inputtext" Then
        S = fileName_InputText(strDQ(S))
    ElseIf LabelName = "templatepath_inputtext" Then
        S = templatePath_InputText(strDQ(S))
    ElseIf LabelName = "clickpinyinhtmlstr" Then
        S = clickPinYinHTMLStr(strDQ(S))
    ElseIf LabelName = "showfontcolorfontb" Then
        S = showFontColorFontB(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "showsort" Then
        S = showSort(strDQ(S))
    ElseIf LabelName = "showwebnavtype" Then
        S = showWebNavType(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)),strDQ(Splxx(5)))
    ElseIf LabelName = "showonhtml" Then
        S = showOnHtml(strDQ(S))
    ElseIf LabelName = "showthrough" Then
        S = showThrough(strDQ(S))
    ElseIf LabelName = "showrecommend" Then
        S = showRecommend(strDQ(S))
    ElseIf LabelName = "showonoffimg" Then
        S = showOnOffImg(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "newshowonoffimg" Then
        S = newShowOnOffImg(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "controldialogcss" Then
        S = controlDialogCss()
    ElseIf LabelName = "batchdeletetempstr" Then
        S = batchDeleteTempStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "htmlformatting" Then
        S = htmlFormatting(strDQ(S))
    ElseIf LabelName = "handlehtmlformatting" Then
        S = handleHtmlFormatting(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "checkhtmlformatting" Then
        S = checkHtmlFormatting(strDQ(S))
    ElseIf LabelName = "newreplacevalueparam" Then
        S = newReplaceValueParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "newrparam" Then
        S = newRParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getcontentallrunstr" Then
        S = getContentAllRunStr(strDQ(S))
    ElseIf LabelName = "getcontentrunstr" Then
        S = getContentRunStr(strDQ(S))
    ElseIf LabelName = "checkcontentrunstr" Then
        S = checkContentRunStr(strDQ(S))
    ElseIf LabelName = "handledoublequotation" Then
        S = handleDoubleQuotation(strDQ(S))
    ElseIf LabelName = "strdq" Then
        S = strDQ(strDQ(S))
    ElseIf LabelName = "handletoarray" Then
        S = handleToArray(strDQ(S))
    ElseIf LabelName = "handlecontentcode" Then
        S = handleContentCode(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handleinmodule" Then
        S = handleInModule(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "clearrparam" Then
        S = clearRParam(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "atrparam" Then
        S = atRParam(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "rparam" Then
        S = rParam(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "handlerparam" Then
        S = handleRParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getconfigblock" Then
        S = getConfigBlock(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getconfigblock2" Then
        S = getConfigBlock2(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getconfigblock3" Then
        S = getConfigBlock3(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getcutconfigblock" Then
        S = getCutConfigBlock(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "getconfigcontentblock" Then
        S = getConfigContentBlock(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getconfigfileblock" Then
        S = getConfigFileBlock(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "setconfigfileblock" Then
        S = setConfigFileBlock(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "delconfigblock" Then
        S = delConfigBlock(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "delconfigblock2" Then
        S = delConfigBlock2(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "delconfigblock3" Then
        S = delConfigBlock3(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "delcutconfigblock" Then
        S = delCutConfigBlock(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "getfileparamvalue" Then
        S = getFileParamValue(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "setfileparamvalue" Then
        S = setFileParamValue(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "handlegetsetfileparamevalue" Then
        S = handleGetSetFileParameValue(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "setrparam" Then
        S = setRParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "addreplacerparam" Then
        S = addReplaceRParam(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "deletestrcut" Then
        S = deleteStrCut(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "replacecontentmodule" Then
        S = replaceContentModule(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)),strDQ(Splxx(4)))
    ElseIf LabelName = "replacecontentrowmodule" Then
        S = replaceContentRowModule(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "handleconfigfile" Then
        Call handleConfigFile(strDQ(S))
    ElseIf LabelName = "getrparam" Then
        S = getRParam(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getdefaultvalue" Then
        S = getDefaultValue(strDQ(S))
    ElseIf LabelName = "addmodulereplacearray" Then
        Call addModuleReplaceArray(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "modulefindcontent" Then
        S = moduleFindContent(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "batchfindfunction" Then
        S = BatchFindFunction(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getfindfilefunction" Then
        S = GetFindFileFunction(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "getaspcode" Then
        S = GetASPCode(strDQ(S))
    ElseIf LabelName = "handlegetaspcode" Then
        S = HandleGetAspCode(strDQ(Splxx(0)),strDQ(Splxx(1)))
    ElseIf LabelName = "delaspnote" Then
        S = DelAspNote(strDQ(S))
    ElseIf LabelName = "findaspfunction" Then
        S = FindAspFunction(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)),strDQ(Splxx(3)))
    ElseIf LabelName = "firstletteruppercase" Then
        S = FirstLetterUppercase(strDQ(S))
    ElseIf LabelName = "contentlushow" Then
        S = ContentLUShow(strDQ(S))
    ElseIf LabelName = "asptovb" Then
        S = ASPToVB(strDQ(S))
    ElseIf LabelName = "asptovbnet" Then
        S = ASPToVBNET(strDQ(S))
    ElseIf LabelName = "dimadddefaultvalue" Then
        S = dimAddDefaultValue(strDQ(S))
    ElseIf LabelName = "functionparamtonet" Then
        S = functionParamtoNet(strDQ(S))
    ElseIf LabelName = "getbeforenstr" Then
        S = GetBeforeNStr(strDQ(Splxx(0)),strDQ(Splxx(1)),strDQ(Splxx(2)))
    ElseIf LabelName = "getstrdim" Then
        S = getStrDim(strDQ(S))
    ElseIf LabelName = "getfunctionstrdim" Then
        S = getFunctionStrDim(strDQ(S))
    ElseIf LabelName = "getrandcolor" Then
        S = getRandColor()
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
Function handleInModule(content, SType)
    SType = LCase(CStr(SType)) 
    If SType = "1" Or SType = "start" Then
        content = Replace(content, "\'", "\|*|\") 
        content = Replace(content, "\=", "\|&|\")                                   '后加20141024
    ElseIf SType = "2" Or SType = "end" Then
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
    If InStr(action, LalbeName & "=" & typeStr) = False and isTrue = False Then
        LalbeName = "'" & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在 前面加双引号
    If InStr(action, LalbeName & "=" & typeStr) = False and isTrue = False Then
        LalbeName = """" & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在    前面加TAB
    If InStr(action, LalbeName & "=" & typeStr) = False and isTrue = False Then
        LalbeName = vbTab & LableStr 
    Else
        isTrue = True 
    End If 
    '不存在    前面加换行
    If InStr(action, LalbeName & "=" & typeStr) = False and isTrue = False Then
        LalbeName = vbCrLf & LableStr 
    Else
        isTrue = True 
    End If 
    If InStr(action, LalbeName & "=" & typeStr) > 0 And InStr(action, endTypeStr) > 0 Then
        s = StrCut(action, LalbeName & "=" & typeStr, endTypeStr, 2) 
        s = handleInModule(s, "end")                              '处理里面参数 追加于20141031            还原内容值

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
	handleRParam=s
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
    Dim StartStr, EndStr 
    StartStr = StartLable & BlockName & EndLable 
    EndStr = StartLable & BlockName & EndLable 
    '开始标签处理
    If InStr(ConfigContent, StartStr & " start") > 0 Then
        StartStr = StartStr & " start" 
    Else
        StartStr = StartStr & " Start" 
    End If 
    '结束标签处理
    If InStr(ConfigContent, EndStr & " end") > 0 Then
        EndStr = EndStr & " end" 
    Else
        EndStr = EndStr & " End" 
    End If 

    If InStr(ConfigContent, StartStr) > 0 And InStr(ConfigContent, EndStr) > 0 Then
        getCutConfigBlock = StrCut(ConfigContent, StartStr, EndStr, 2) 
    End If 
End Function 
'获得配置内容块20150401
Function getConfigContentBlock(ByVal ConfigContent, BlockName)
    getConfigContentBlock = getCutConfigBlock(ConfigContent, BlockName, "", "") 
End Function 
'获得配置文件里块20150401  GetConfigFileBlock(ConfigPath, "#txtRunCode#")  测试标签块时则自动创建
Function getConfigFileBlock(ByVal ConfigFile, BlockName)
    Dim content, FindStr, ReplaceStr, StartStr, EndStr 
    content = GetFText(ConfigFile) 
    'MsgBox ("ConfigFile=" & ConfigFile & "(" & CheckFile(ConfigFile) & "，" & GetFSize(ConfigFile) & ")" & vbCrLf & "Content=" & Content)
    StartStr = BlockName & " start" 
    EndStr = BlockName & " end" 
    ReplaceStr = StartStr & "" & EndStr 
    If InStr(content, StartStr) > 0 And InStr(content, EndStr) > 0 Then
        FindStr = StrCut(content, StartStr, EndStr, 2) 
        getConfigFileBlock = FindStr 
    Else
        Call CreateFile(ConfigFile, content & ReplaceStr) 
    End If 
End Function 
'设置配置文件里块 20150401 call SetConfigFileBlock(ConfigFile, "aaabbc", "#上传目录列表#")  存在则更新
Function setConfigFileBlock(ByVal ConfigFile, ByVal WriteContent, BlockName)
    Dim content, FindStr, ReplaceStr, StartStr, EndStr 
    content = GetFText(ConfigFile) 
    StartStr = BlockName & " start" 
    EndStr = BlockName & " end" 
    ReplaceStr = StartStr & WriteContent & EndStr 
    If InStr(content, StartStr) > 0 And InStr(content, EndStr) > 0 Then
        FindStr = StrCut(content, StartStr, EndStr, 1) 
        content = Replace(content, FindStr, ReplaceStr) 
        Call CreateFile(ConfigFile, content) 
    Else
        Call CreateFile(ConfigFile, content & ReplaceStr) 
    End If 
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
    Dim StartStr, EndStr, s 
    StartStr = StartLable & BlockName & EndLable & " start" 
    EndStr = StartLable & BlockName & EndLable & " end" 
    If InStr(Config, StartStr) > 0 And InStr(Config, EndStr) > 0 Then
        s = StrCut(Config, StartStr, EndStr, 1) 
        Config = Replace(Config, s, "") 
    End If 
    delCutConfigBlock = Config 
End Function 




'获得文件里设置参数　20150315
Function getFileParamValue(ConfigPath, ParamName)
    getFileParamValue = HandleGetSetFileParameValue(ConfigPath, ParamName, "", "获得") 
End Function 
'设置文件里设置参数　20150315
Function setFileParamValue(ConfigPath, ParamName, ValueStr)
    setFileParamValue = HandleGetSetFileParameValue(ConfigPath, ParamName, ValueStr, "设置") 
End Function 
'处理获得设置文件参数值　20150315
Function handleGetSetFileParameValue(ConfigPath, ParamName, ValueStr, SType)
    Dim content, StartStr, EndStr, YunStr, ReplaceStr 
    '文件为假时，创建一个空文件看看，如果不能创建这个文件则说明这个文件地址有问题，则退出20150324
    If checkFile(ConfigPath) = False Then
        Call CreateFile(ConfigPath, "") 
    End If 
    If checkFile(ConfigPath) = False Then Exit Function                             '文件不存在则退出

    content = TrimVbCrlf(GetFText(ConfigPath)) 
    StartStr = vbCrLf & ParamName & "=" : EndStr = vbCrLf 
    ReplaceStr = vbCrLf & ParamName & "=" & ValueStr & vbCrLf 
    If InStr(vbCrLf & content, StartStr) > 0 And InStr(content & vbCrLf, EndStr) > 0 Then
        YunStr = StrCut(vbCrLf & content & vbCrLf, StartStr, EndStr, 2) 
        If SType = "获得" Then
            handleGetSetFileParameValue = YunStr 
            Exit Function 
        End If 
        YunStr = StartStr & YunStr & EndStr 
        content = Replace(vbCrLf & content & vbCrLf, YunStr, ReplaceStr) 
        Call CreateFile(ConfigPath, content) 
    Else
        Call CreateFile(ConfigPath, content & vbCrLf & TrimVbCrlf(ReplaceStr)) 
    End If 
End Function 

'设置内容里参数 20150611
Function setRParam(ConfigPath, paramName, paramValue, isNoAdd)
    Dim content, StartStr, EndStr, s 
    content = PHPTrim(GetFText(ConfigPath)) 
    StartStr = paramName & "='" : EndStr = "'" 
    If InStr(content, StartStr) > 0 And InStr(content, EndStr) > 0 Then
        s = StrCut(content, StartStr, EndStr, 2) 
        content = Replace(content, StartStr & s & EndStr, StartStr & paramValue & EndStr) 
        Call CreateFile(ConfigPath, content) 

    ElseIf Trim(isNoAdd) = "1" Then
        Call CreateAddFile(ConfigPath, StartStr & paramValue & EndStr) 
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
Function deleteStrCut(ByVal content, ByVal StartStr, ByVal EndStr, ByVal CutType, nDelCount)
    Dim i, s 
    If nDelCount = 0 Then
        nDelCount = 99 
    End If 
    For i = 0 To nDelCount
        s = getStrCut(content, StartStr, EndStr, 1) 
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
Function replaceContentModule(ByVal content, StartStr, EndStr, ReplaceValue, ReplaceType)
    Dim splStr, splxx, s, i, splType, valueList, newStartStr, newEndStr, sourceValueList, sourceValue, tempS, newReplaceValue 
    If InStr(content, StartStr) = False and InStr(content, EndStr) = False Then
        replaceContentModule = content 
        Exit Function 
    End If 
    splType = "$Array$" 
    For i = 1 To 99
        If InStr(content, StartStr) > 0 and InStr(content, EndStr) > 0 Then
            s = StrCut(content, StartStr, EndStr, 1) : tempS = s 
            s = Mid(s, Len(StartStr) + 1, Len(s) - Len(StartStr) - Len(EndStr)) 
            newStartStr = getEachStrAddValue(StartStr, "|*|") 
            If InStr(splType & valueList & splType, splType & newStartStr & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newStartStr 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & StartStr 
            End If 
            newEndStr = getEachStrAddValue(EndStr, "|*|") 
            If InStr(splType & valueList & splType, splType & newEndStr & splType) = False Then
                If valueList <> "" Then valueList = valueList & splType 
                valueList = valueList & newEndStr 
                If sourceValueList <> "" Then sourceValueList = sourceValueList & splType 
                sourceValueList = sourceValueList & EndStr 
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
                    ElseIf s = " " and c = "" Then

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
sub addModuleReplaceArray(title,content)
	dim i
	for i=1 to ubound(ModuleReplaceArray)-1
		if ModuleReplaceArray(i,0)="" then
			ModuleReplaceArray(i,0)=title
			ModuleReplaceArray(0,i)=content
			exit sub
		end if
	next
end sub

'根据标签找到对应内容
Function moduleFindContent(action, ModuleName)
    Dim defaultStr, StartStr, EndStr 
    defaultStr = rParam(action, ModuleName)                                         '把转小写LCase去掉 （20151008） 

    StartStr = "<!--#" & defaultStr & " start#-->" 
    EndStr = "<!--#" & defaultStr & " end#-->"  
    '[_18年独家一次性祛斑第一品牌2014年10月21日 10时59分]
    'Call Echo("Default",Default)
    '判断是否存在
    If InStr(code, StartStr) > 0 And InStr(code, EndStr) > 0 Then
        defaultStr = StrCut(code, StartStr, EndStr, 2) 
    Else
        StartStr = "<!--#" & defaultStr 
        EndStr = "#-->" 
        If InStr(code, StartStr) > 0 And InStr(code, EndStr) > 0 Then
            defaultStr = StrCut(code, StartStr, EndStr, 2) 

        'Call Echo("有","StartStr=" & StartStr & ",EndStr=" & EndStr  & ",Default=" & Default)
        End If 
    End If 

    '删除默认值20150712
    Dim deletedefault 
    deletedefault = rParam(action, "deletedefault") 
    If deletedefault = "true" Then
        Call addModuleReplaceArray("【删除】", StartStr & defaultStr & EndStr) 
    End If 
    moduleFindContent = defaultStr 
End Function 
%>  





