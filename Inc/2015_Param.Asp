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









Function newReplaceValueParam(a, b, c)
    Dim d, e, f, g, h, i, j


    If IsNul(c) = True Then c = ""

    d = "[$" & b : e = "$]"
    If InStr(a, d) > 0 And InStr(a, e) > 0 Then
        f = StrCut(a, d, e, 1)

        i = RParam(f, "DelHtml")
        If i = "true" Then c = Replace(DelHtml(c), "<", "&lt;")

        j = RParam(f, "Trim")
        If j = "true" Then c = TrimVbCrlf(c)


        g = RParam(f, "Len")
        g = HandleNumber(g)

        If g <> "" Then c = CutStr(c, g, "...")


        h = RParam(f, "Format_Time")
        If h <> "" Then
            c = Format_Time(c, h)
        End If
        a = Replace(a, f, c)

    End If
    newReplaceValueParam = a
End Function


Function newRParam(a, b, c)
    Dim d, e, f
    d = RParam(b, c)
    e = "<!--#" & d & " start#-->"
    f = "<!--#" & d & " end#-->"

    If d <> "" Then

        If InStr(a, e) > 0 And InStr(a, f) > 0 Then
            d = StrCut(a, e, f, 2)
        Else
            e = "<!--#" & d
            f = "#-->"
            If InStr(a, e) > 0 And InStr(a, f) > 0 Then
                d = StrCut(a, e, f, 2)


            End If
        End If
    End If
    newRParam = d
End Function












Function getContentAllRunStr(a)
    Dim b, c, d
    b = Split(a, vbCrLf)
    For Each c In b
        c = Replace(Replace(c, Chr(10), ""), Chr(13), "")
        d = d & HandleContentCode(c, "")
    Next
    getContentAllRunStr = d
End Function


Function getContentRunStr(ByVal a)
    getContentRunStr = HandleContentCode(a, "")
End Function


Function checkContentRunStr(ByVal a)
    checkContentRunStr = HandleContentCode(a, "check")
End Function

Function handleDoubleQuotation(ByVal a)
    Dim b
    b = PHPTrim(a)
    If Left(b, 1) = """" And Right(b, 1) = """" Then
        a = Mid(b, 2, Len(b) - 2)
    End If
    handleDoubleQuotation = a
End Function

Function strDQ(ByVal a)
    strDQ = handleDoubleQuotation(a)
End Function

Function handleToArray(a)
    Dim b, c
    a = StrCut(a, "(", ")", 2)

    b = Split(a, ",")

    For c = 0 To UBound(b)
        b(c) = strDQ(b(c))

    Next
    handleToArray = b
End Function

Function handleContentCode(ByVal a, b)
    Dim c, d, e, f, g, h, i
    Dim j
    Dim k

    Dim l
    l = LCase(a)

    If b = "check" Or b = "检测" Then
        handleContentCode = False
    End If


i = "|printpre|authorinfo|authorinfo2|foldingmenu|returnren|returnhr|returnrenhr|showerr|printforminfo|dedecmsmsg|handleaccessdata|adsql|getwhereand|orandsearch|checkaccesspass|checksql|createtable|showistable|"
i = i & "|getrecordcount|tablecount|opentable|inserttable|gettabletext|createmdb|deletetable|deletealltable|checktable|existstable|edittable|checkfield|existsfield|editfield|getfieldalt|gettablelist_conn|gettablelist|"
i = i & "|getfieldlist|getdifferenttablefieldlist|compactdb|editaccesspassword|handlesqlserver|exporttoexcel|importtodatabase|getdatatablelist|settablefield|gettypestring|getproductrndidlist|getfieldvalue|getconnfieldvalue|"
i = i & "|setfieldvalue|filebinaryaddaccess|showaccessstream|gethttppage|handlegethttppage|geturlcontent|gethttpurl|bytestobstr|strcut|getstrcut|cutstr|cutstrnolu|setcuttdstr|cuttdstr|getarraylist|getarray|getarray1|"
i = i & "|getsplit|getsplitcount|agent|specialhtmluploadencryptiondecrypt|encaspcontent|uppercaseorlowercase|enccode|deccode|tounicode|japan|japan26|unjapan26|handlehtml|unhandlehtml|lcaseenc|lcasedec|simpleenc|"
i = i & "|simpledec|encaspevalrun|htmltojs|jstohtml|htmltoasp|htmltoaspdim|asptohtml|setfilename|unsetfilename|xorenc|xordec|htmltoascchr|unhtmltoascchr|handleevaladddec|evaladddec|vbevaladddec|tohexcolor|colorrgb|"
i = i & "|xdec|variabledisplacement|send_email|serversend_email|findaspcode|findaspfunlist|findaspfunctioncode|handlereplacelist|getfunnamedim|leftspace|rightspace|infunadddim|getqq|gettel|getmail|getimgstr|getcssstr|"
i = i & "|getjsstr|handleaspexecute|geturlstr|getpageconfig|getsqlinurl|handlsqlinurl|getscanfunctionnamelist|getfunname|getfundimname|getdimname|getsetname|replacedim|replacedim2|findfolderrepeatfunction|findfilerepeatfunction|"
i = i & "|findcontentrepeatfunction|handlecontentrepeatfunction|replace2|allreplace|replaceonenolu|optimizeaspcode|aspcodeconfusion|aspvariablegarbled|lucasegarbled|aspcodesafe|cutdakuohao|cutxiankuohao|cutfunctionvvalue|"
i = i & "|getstrintcontentnumb|getkeyword|gethandlekeyword|getchinastr|checkstr|regexp_checkstr|existsstr|regexp_instr|regexp_replace|replacecolor|delhtml|regexp_delhtml|getaurltitlelist|getaurl|getatitle|getaurltitle|"
i = i & "|getcontentaurllist|regexp_getimgurllist|getimg|getimgjpg|getimggif|getimgbmp|getaspfunctionlist|getaspdimfunction|strlength|regexpgetlenght|stringlength|getcsshref|getjssrc|delhtmlscript|getmeta|delhtmlnote|"
i = i & "|delhtmlmynote|getstrimglist|getemaillist|oflink_lcasetag|scripthtml|getregexp|getimgjsurl|regexpgetstr|newgetpingip|getpingip|getpinginfo|regexptest|getregexpstr|regexpreplacecssdir|deletenullrow|getbl|"
i = i & "|getcountstep|getchina|phprand|phprnd|deleterepeatstr|replacen|fillzero|caseinsensitivereplace|array_sort|handlezipsize|getrnd|mathrandom|getrndaz|getrand|copystrnumb|str_repeat|copystr|contentaddtab|deleteendstr|"
i = i & "|tonumber|handlenumber|strdrawint|getfirstnegativenumber|checknumbertype|checkstrisnumbertype|handlenumbertype|getnumber|checknumb|getdiannumb|getcountpage|getpagenumb|getcaihandlecountpage|getcaisortcountpage|"
i = i & "|minmaxbetween|getstrfiletype|val|strlen|addindent|getnumberbeforestr|makepassword|rndcode|getrandomphonenumber|lenstr|tostring|remotenumber|saveremotefile|downfile|popupdownfile|xmlgetstatus|xmlpost|utfxmlpost|"
i = i & "|handlexmlpost|xmlget|handlexmlget|cookiespost|handlecookiespost|getremotefilesize|downremotefile|imagestobase64|base64toimages|getsqlincontent|handlesqlin|sqlinurl|handlurlcanshu|handlestrcharset|urlencoding|"
i = i & "|getwinhttp|format_time|getdaystatus|printtimevalue|printasktime|gettimerset|calculationtimer|gettimer|vbgettimer|vbechotimer|vbruntimer|getthisurlnoparam|getgotourl|getgotourlnoparam|getgotourlnofilename|"
i = i & "|getip2|getip|getservicerip|getremoteip|handlehttpurl|handlefileurl|handleurlcomplete|urladdhttpurl|webdomain|host|httphost|gethost|geturl|getthisurl|getwebsite|checkurl|checkhttpurl|isurl|ishttpurl|fullhttpurl|"
i = i & "|batchfullhttpurl|urljianjiehandle|urltoasc|getwebtitle|mystrcut|getcontentahref|getcontentimgsrc|handleconenturl|replacecontentjsdir|handlelink|getendurlhandlename|getwebfoldername|getwebhome|geturllistinwebsitelist|"
i = i & "|getthisurlfilename|handlewebhtmlimg|handlewebcssimg|batchhandleurlintegrity|replacecontentimagepath|getcsslinklist|gethtmlbackgroundurllist|getimgurllist|getlinkurl|localurlorremoteurl|checkremoteurl|gethandleurl|"
i = i & "|webdebug|asailinkadd|asailinkdel|iswww|geturladdtoparam|groupurl|handlepostcookiesparame|remotehttpurlparameter|checkurlname|handlehttpurlarray|remotejscssparam|handleremotejscssparam|batchhandlehttpurlcomplete|"
i = i & "|iswebsite|issonwebsite|handleiswebsite|getcontenturllist|handlegetcontenturllist|getinchain|getfiletext|getftext|getfiletype|checkfile|existsfile|createfile|savefile|createaddfile|createaddupfile|addtofile|"
i = i & "|savebytefile|createbytefile|movefile|editfile|copyfile|deletefile|delselfile|delfilelist|deleteappointfilelist|getfilesize|filesize|getfsize|getfilecreatedate|filecreatedate|getfileeditdate|fileeditdate|"
i = i & "|getfileedittime|getdatelastaccessed|modifyfilemodifydate|editfileeditdate|existszhidufile|getfileattribute|editfileattribute|existsfileday|checkfileday|createfolder|createdirfolder|createdomain|createdomainfolder|"
i = i & "|movefolder|editfolder|copyfolder|deletefolder|getfoldersize|checkfolder|existsfolder|getfoldercreatedate|getfoldereditdate|getfoldertime|getfolderattribute|editfolderattribute|existsfolderday|checkfolderday|"
i = i & "|getfilefolderlist|getdirjpglist|getdirinilist|getdirtxtlist|getdirhtmllist|getdirfilelist|getdirhtmllistname|getdirfilenamelist|getdirallfilenamelist|getdirfolderlist|getdirfoldernamelist|getthisallfolder|"
i = i & "|getthisallfoldername|getfilefoldernumb|getdirfoldernumb|getdirfoldersize|getdirfilenumb|getdirallfilenumb|getdirallfoldernumb|getfolderlist|getdirfilesort|getdirfoldersort|deldirallfile|deleteallfile|getupdatefile|"
i = i & "|handlepath|realpath|fullpath|handlerelativepath|dirname|isobjinstalled|existsobject|getfileobject|getdictionary|getstream|showattributetip|printspacevalue|printspacesize|printfilesize|getdeskpath|createurlshortcut|"
i = i & "|createfoldershortcut|finddirfilename|findsubdirfilename|getarticlefillcontent|getfilepathname|getextension|removefiledir|basename|getfileextname|handlefilepatharray|getstrfilename|getfileattr|fileext|getparentpath|"
i = i & "|checkerr|strtotruefalse|strtruefalsetoint|checkvbcrlf|checkbr|isparity|checkeval|replace_sqltext|chkpost|ismail|isvalidemail|iscode|checknumber|isnumber|checkabc|getlen|checktime|isnul|foundinarr|showhtmlcode|"
i = i & "|showhtml|unhtmlcode|echohtml|errortext|testhtml|htmldecode|htmlencode|htmlfilter|regreplace|easp_replace|handlehtmllabelclose|handleimgclose|handlebrclose|handlehrclose|handleclosehtml|htmllabeltoclean|"
i = i & "|addtooraddhttpurl|removeblanklines|removeblanklines_test1|checkcode|seniorcheckcode|readfile|getstext|writetofile|getugtext|checkcontentcharset|checkfilecode|getfilebinarycontent|binaryreadfile|readbinary|"
i = i & "|decsavebinary|writebinary|getfilecharset|bintohex|asphelptip|handlewrite|jiantitabfanti|jiyicireplace|cireplace|testgetpy|pinyin|pinyin2|entocompany|remotecontentjinghao|remotearrayjinghao|geteachstraddvalue|"
i = i & "|getvalueinarrayid|checkvalueinarray|deleterepeatarray|deleterepeatcontent|getarraycount|randomshow|arrayrandomshow|printarray|echoarray|str_shuffle|characterupset|str_split|removenullvaluearray|removerepeatvaluearray|"
i = i & "|handlearray|testarraydata|selectsort|quicksort|bubblesort|insertsort|requicksort|arrayreverse|responsearray|max|min|testtwodimensionalarray|handlesplitarray|twodimensionalarrayasc|twodimensionalarraydesc|"
i = i & "|csscompression|deletecssnote|uncsscompression|trimvbcrlf|phptrim|ltrimvbcrlf|rtrimvbcrlf|trimvbtab|ltrimvbtab|rtrimvbtab|gethtmlcssstyle|handlecleancss|removeexcessrow|cssaddtostyle|checkcssstyle|cssstyleaddtoparam|"
i = i & "|findcssstyle|handlecutcsscode|handlecutdivcode|gethtmlbackgroundimglist|gethandlewebhtmllink|getcsslisturllist|handlereadcsscontent|handlecsspx|handlehtmlstyle|utf2gb|checkutftogb2312|convchinese|utf8_urlencoding|"
i = i & "|toutf8|chinese2unicode|isvalidhex|escape|unescape|chinesetounicode|unicodetochinese|urlencode|urldecode|gbtoutf8|encdecurl|encurl|decurl|infocolor|imgerror|targetstr|atarget|atitle|imgalt|imgtitlealt|arel|"
i = i & "|styleclass|textfontb|textfontcolor|fontcolorfontb|getdefaultfilename|ahref|imgsrc|selecttarget|selectfontcolor|selectsex|selectsessioncookies|showselectlist|showarticleliststyle|showarticleinfostyle|handlearticleliststyleorinfostyle|"
i = i & "|showwebmoduleskins|showradiolist|inputcheckbox|inputtext|inputtext2|inputlefttext|inputlefttexthelptextright|inputlefttextcontent|inputrighttextcontent|handleinputleftrighttextcontent|inputleftpasstext|"
i = i & "|inputleftpasstextcontent|inputhiddentext|inputtextarea|inputhiddentextarea|handleinputhiddentextarea|showselectdirlist|inputdisabled|inputaddalt|webtitle_inputtextarea|webkeywords_inputtext|webdescription_inputtextarea|"
i = i & "|foldername_inputtext|filename_inputtext|templatepath_inputtext|clickpinyinhtmlstr|showfontcolorfontb|showsort|showwebnavtype|showonhtml|showthrough|showrecommend|showonoffimg|newshowonoffimg|controldialogcss|"
i = i & "|htmlformatting|handlehtmlformatting|checkhtmlformatting|newreplacevalueparam|newrparam|getcontentallrunstr|getcontentrunstr|checkcontentrunstr|handledoublequotation|strdq|handletoarray|handlecontentcode|"
i = i & "|handleinmodule|clearrparam|atrparam|rparam|handlerparam|getconfigblock|getconfigblock2|getconfigblock3|getcutconfigblock|getconfigcontentblock|getconfigfileblock|setconfigfileblock|delconfigblock|delconfigblock2|"
i = i & "|delconfigblock3|delcutconfigblock|getfileparamvalue|setfileparamvalue|handlegetsetfileparamevalue|setrparam|addreplacerparam|deletestrcut|replacecontentmodule|replacecontentrowmodule|handleconfigfile|getrparam|"
i = i & "|getdefaultvalue|modulefindcontent|batchfindfunction|getfindfilefunction|getaspcode|handlegetaspcode|delaspnote|findaspfunction|firstletteruppercase|contentlushow|asptovb|asptovbnet|dimadddefaultvalue|functionparamtonet|"



    i = i & "|now|date|len|left|right|mid|lcase|ucase|ltrim|rtrim|trim|"


    g = Split(i, "|")
    For Each j In g
        If j <> "" Then
            c = LCase(j & "(") : d = ")"
            k = InStr(" " & l, " " & c)
            If k > 0 And InStr(l, d) > 0 Then
                If b = "check" Or b = "检测" Then
                    handleContentCode = True
                    Exit Function
                End If
                Exit For
            End If
        End If
    Next
    If j = "" Then
        If b <> "check" And b <> "检测" Then
            handleContentCode = a
        End If
        Exit Function
    End If

    j = LCase(j)

    c = j & "(" : d = ")"
    k = InStr(l, c)

    f = Mid(a, InStr(l, c))
    f = Mid(f, 1, InStrRev(f, d))

    e = Mid(a, InStr(l, c) + Len(c))

    e = Mid(e, 1, InStrRev(e, d) - 1)

    If checkContentRunStr(a) = True Then
        e = getContentRunStr(e)
    End If

    e = handleDoubleQuotation(e)

    h = Split(e & ",1", ",")




    If j = "printpre" Then
        e = PrintPre(strDQ(e))
    ElseIf j = "authorinfo" Then
        e = AuthorInfo(strDQ(e))
    ElseIf j = "authorinfo2" Then
        e = AuthorInfo2()
    ElseIf j = "foldingmenu" Then
        e = FoldingMenu(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "returnren" Then
        e = ReturnRen(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "returnhr" Then
        e = ReturnHr()
    ElseIf j = "returnrenhr" Then
        e = ReturnRenHr()
    ElseIf j = "showerr" Then
        Call ShowErr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "printforminfo" Then
        Call PrintFormInfo()
    ElseIf j = "dedecmsmsg" Then
        e = DedeCMSMsg()
    ElseIf j = "handleaccessdata" Then
        e = handleAccessData(strDQ(e))
    ElseIf j = "adsql" Then
        e = ADSql(strDQ(e))
    ElseIf j = "getwhereand" Then
        e = GetWhereAnd(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "orandsearch" Then
        e = OrAndSearch(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "checkaccesspass" Then
        e = CheckAccessPass(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checksql" Then
        e = CheckSql(strDQ(e))
    ElseIf j = "createtable" Then
        e = CreateTable(strDQ(e))
    ElseIf j = "showistable" Then
        e = ShowIsTable(strDQ(e))
    ElseIf j = "getrecordcount" Then
        e = GetRecordCount(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "tablecount" Then
        e = TableCount(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "opentable" Then
        e = OpenTable(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "inserttable" Then
        e = InsertTable(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "gettabletext" Then
        e = GetTableText(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "createmdb" Then
        e = CreateMdb(strDQ(e))
    ElseIf j = "deletetable" Then
        e = deleteTable(strDQ(e))
    ElseIf j = "deletealltable" Then
        e = deleteAllTable(strDQ(e))
    ElseIf j = "checktable" Then
        e = CheckTable(strDQ(e))
    ElseIf j = "existstable" Then
        e = ExistsTable(strDQ(e))
    ElseIf j = "edittable" Then
        e = EditTable(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "checkfield" Then
        e = CheckField(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "existsfield" Then
        e = ExistsField(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "editfield" Then
        e = EditField(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getfieldalt" Then
        e = GetFieldAlt(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "gettablelist_conn" Then
        e = GetTableList_Conn(strDQ(e))
    ElseIf j = "gettablelist" Then
        e = GetTableList()
    ElseIf j = "getfieldlist" Then
        e = GetFieldList(strDQ(e))
    ElseIf j = "getdifferenttablefieldlist" Then
        e = GetDifferentTableFieldList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "compactdb" Then
        e = CompactDB(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "editaccesspassword" Then
        e = EditAccessPassWord(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "handlesqlserver" Then
        e = HandleSqlServer(strDQ(e))
    ElseIf j = "exporttoexcel" Then
        Call ExportToExcel(strDQ(e))
    ElseIf j = "importtodatabase" Then
        Call ImportToDatabase()
    ElseIf j = "getdatatablelist" Then
        e = GetDataTableList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "settablefield" Then
        e = SetTableField(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "gettypestring" Then
        e = GetTypeString(strDQ(e))
    ElseIf j = "getproductrndidlist" Then
        e = GetProductRndIdList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getfieldvalue" Then
        e = getFieldValue(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getconnfieldvalue" Then
        e = getConnFieldValue(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "setfieldvalue" Then
        e = setFieldValue(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "filebinaryaddaccess" Then
        e = FileBinaryAddAccess(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)))
    ElseIf j = "showaccessstream" Then
        e = ShowAccessStream(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "gethttppage" Then
        e = getHttpPage(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlegethttppage" Then
        e = handleGetHttpPage(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "geturlcontent" Then
        e = getURLContent(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "gethttpurl" Then
        e = getHttpUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "bytestobstr" Then
        e = bytesToBstr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "strcut" Then
        e = strCut(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "getstrcut" Then
        e = getStrCut(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "cutstr" Then
        e = cutStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "cutstrnolu" Then
        e = cutStrNOLU(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "setcuttdstr" Then
        e = setCutTDStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "cuttdstr" Then
        e = cutTDStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getarraylist" Then
        e = getArrayList(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)))
    ElseIf j = "getarray" Then
        e = getArray(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "getarray1" Then
        e = getArray1(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "getsplit" Then
        e = getSplit(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getsplitcount" Then
        e = getSplitCount(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "agent" Then
        e = agent(strDQ(e))
    ElseIf j = "specialhtmluploadencryptiondecrypt" Then
        e = SpecialHtmlUploadEncryptionDecrypt(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "encaspcontent" Then
        e = EncAspContent(strDQ(e))
    ElseIf j = "uppercaseorlowercase" Then
        e = UpperCaseORLowerCase(strDQ(e))
    ElseIf j = "enccode" Then
        e = EncCode(strDQ(e))
    ElseIf j = "deccode" Then
        e = DecCode(strDQ(e))
    ElseIf j = "tounicode" Then
        e = ToUnicode(strDQ(e))
    ElseIf j = "japan" Then
        e = Japan(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "japan26" Then
        e = Japan26(strDQ(e))
    ElseIf j = "unjapan26" Then
        e = UnJapan26(strDQ(e))
    ElseIf j = "handlehtml" Then
        e = HandleHTML(strDQ(e))
    ElseIf j = "unhandlehtml" Then
        e = UnHandleHTML(strDQ(e))
    ElseIf j = "lcaseenc" Then
        e = LcaseEnc(strDQ(e))
    ElseIf j = "lcasedec" Then
        e = LcaseDec(strDQ(e))
    ElseIf j = "simpleenc" Then
        e = SimpleEnc(strDQ(e))
    ElseIf j = "simpledec" Then
        e = SimpleDec(strDQ(e))
    ElseIf j = "encaspevalrun" Then
        e = EncAspEvalRun(strDQ(e))
    ElseIf j = "htmltojs" Then
        e = HtmlToJs(strDQ(e))
    ElseIf j = "jstohtml" Then
        e = JsToHtml(strDQ(e))
    ElseIf j = "htmltoasp" Then
        e = HtmlToAsp(strDQ(e))
    ElseIf j = "htmltoaspdim" Then
        e = HtmlToAspDim(strDQ(e))
    ElseIf j = "asptohtml" Then
        e = AspToHtml(strDQ(e))
    ElseIf j = "setfilename" Then
        e = SetFileName(strDQ(e))
    ElseIf j = "unsetfilename" Then
        e = UnSetFileName(strDQ(e))
    ElseIf j = "xorenc" Then
        e = XorEnc(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "xordec" Then
        e = XorDec(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "htmltoascchr" Then
        e = HTMLToAscChr(strDQ(e))
    ElseIf j = "unhtmltoascchr" Then
        e = UnHTMLToAscChr(strDQ(e))
    ElseIf j = "handleevaladddec" Then
        e = HandleEvalAddDec(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "evaladddec" Then
        e = EvalAddDec(strDQ(e))
    ElseIf j = "vbevaladddec" Then
        e = VBEvalAddDec(strDQ(e))
    ElseIf j = "tohexcolor" Then
        e = toHexColor(strDQ(e))
    ElseIf j = "colorrgb" Then
        e = ColorRGB(strDQ(e))
    ElseIf j = "xdec" Then
        e = XDec(strDQ(e))
    ElseIf j = "variabledisplacement" Then
        e = VariableDisplacement(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "send_email" Then
        e = Send_Email(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "serversend_email" Then
        e = ServerSend_Email(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)))
    ElseIf j = "findaspcode" Then
        e = FindAspCode(strDQ(e))
    ElseIf j = "findaspfunlist" Then
        e = FindAspFunList(strDQ(e))
    ElseIf j = "findaspfunctioncode" Then
        e = FindAspFunctionCode(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlereplacelist" Then
        e = handleReplaceList(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getfunnamedim" Then
        e = GetFunNameDim(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "leftspace" Then
        e = LeftSpace(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "rightspace" Then
        e = RightSpace(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "infunadddim" Then
        e = InFunAddDim(strDQ(e))
    ElseIf j = "getqq" Then
        e = GetQQ(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "gettel" Then
        e = GetTel(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getmail" Then
        e = GetMail(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getimgstr" Then
        e = GetImgStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getcssstr" Then
        e = GetCssStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getjsstr" Then
        e = GetJsStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "handleaspexecute" Then
        e = HandleAspExecute(strDQ(e))
    ElseIf j = "geturlstr" Then
        e = GetUrlStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "getpageconfig" Then
        e = GetPageConfig(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getsqlinurl" Then
        e = GetSqlInUrl(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "handlsqlinurl" Then
        e = HandlSqlInUrl(strDQ(e))
    ElseIf j = "getscanfunctionnamelist" Then
        e = GetScanFunctionNameList(strDQ(e))
    ElseIf j = "getfunname" Then
        e = GetFunName(strDQ(e))
    ElseIf j = "getfundimname" Then
        e = GetFunDimName(strDQ(e))
    ElseIf j = "getdimname" Then
        e = GetDimName(strDQ(e))
    ElseIf j = "getsetname" Then
        e = GetSetName(strDQ(e))
    ElseIf j = "replacedim" Then
        e = ReplaceDim(strDQ(e))
    ElseIf j = "replacedim2" Then
        e = ReplaceDim2(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "findfolderrepeatfunction" Then
        e = FindFolderRepeatFunction(strDQ(e))
    ElseIf j = "findfilerepeatfunction" Then
        e = FindFileRepeatFunction(strDQ(e))
    ElseIf j = "findcontentrepeatfunction" Then
        e = FindContentRepeatFunction(strDQ(e))
    ElseIf j = "handlecontentrepeatfunction" Then
        e = HandleContentRepeatFunction(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "replace2" Then
        e = Replace2(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "allreplace" Then
        e = AllReplace(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "replaceonenolu" Then
        e = ReplaceOneNOLU(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "optimizeaspcode" Then
        e = OptimizeAspCode(strDQ(e))
    ElseIf j = "aspcodeconfusion" Then
        e = AspCodeConfusion(strDQ(e))
    ElseIf j = "aspvariablegarbled" Then
        e = ASPVariableGarbled(strDQ(e))
    ElseIf j = "lucasegarbled" Then
        e = LUCaseGarbled(strDQ(e))
    ElseIf j = "aspcodesafe" Then
        e = AspCodeSafe(strDQ(e))
    ElseIf j = "cutdakuohao" Then
        e = cutDaKuoHao(strDQ(e))
    ElseIf j = "cutxiankuohao" Then
        e = cutXianKuoHao(strDQ(e))
    ElseIf j = "cutfunctionvvalue" Then
        e = cutFunctionvValue(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getstrintcontentnumb" Then
        e = getStrIntContentNumb(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getkeyword" Then
        e = GetKeyWord(strDQ(e))
    ElseIf j = "gethandlekeyword" Then
        e = GetHandleKeyWord(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getchinastr" Then
        e = GetChinaStr(strDQ(e))
    ElseIf j = "checkstr" Then
        e = CheckStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "regexp_checkstr" Then
        e = RegExp_CheckStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "existsstr" Then
        e = ExistsStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "regexp_instr" Then
        e = RegExp_Instr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "regexp_replace" Then
        e = RegExp_Replace(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "replacecolor" Then
        e = ReplaceColor(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "delhtml" Then
        e = DelHtml(strDQ(e))
    ElseIf j = "regexp_delhtml" Then
        e = RegExp_DelHtml(strDQ(e))
    ElseIf j = "getaurltitlelist" Then
        e = GetAUrlTitleList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getaurl" Then
        e = GetAURL(strDQ(e))
    ElseIf j = "getatitle" Then
        e = GetATitle(strDQ(e))
    ElseIf j = "getaurltitle" Then
        e = GetAURLTitle(strDQ(e))
    ElseIf j = "getcontentaurllist" Then
        e = getContentAUrlList(strDQ(e))
    ElseIf j = "regexp_getimgurllist" Then
        e = RegExp_GetImgUrlList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getimg" Then
        e = GetIMG(strDQ(e))
    ElseIf j = "getimgjpg" Then
        e = GetIMGJpg(strDQ(e))
    ElseIf j = "getimggif" Then
        e = GetIMGGif(strDQ(e))
    ElseIf j = "getimgbmp" Then
        e = GetIMGBmp(strDQ(e))
    ElseIf j = "getaspfunctionlist" Then
        e = GetASPFunctionList(strDQ(e))
    ElseIf j = "getaspdimfunction" Then
        e = GetASPDimFunction(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "strlength" Then
        e = StrLength(strDQ(e))
    ElseIf j = "regexpgetlenght" Then
        e = regExpGetLenght(strDQ(e))
    ElseIf j = "stringlength" Then
        e = stringLength(strDQ(e))
    ElseIf j = "getcsshref" Then
        e = GetCssHref(strDQ(e))
    ElseIf j = "getjssrc" Then
        e = GetJsSrc(strDQ(e))
    ElseIf j = "delhtmlscript" Then
        e = DelHTMLScript(strDQ(e))
    ElseIf j = "getmeta" Then
        e = GetMeta(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "delhtmlnote" Then
        e = DelHtmlNote(strDQ(e))
    ElseIf j = "delhtmlmynote" Then
        e = DelHtmlMyNote(strDQ(e))
    ElseIf j = "getstrimglist" Then
        e = GetStrImgList(strDQ(e))
    ElseIf j = "getemaillist" Then
        e = GetEMailList(strDQ(e))
    ElseIf j = "oflink_lcasetag" Then
        e = oflink_lcasetag(strDQ(e))
    ElseIf j = "scripthtml" Then
        e = ScriptHtml(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getregexp" Then
        e = GetRegExp(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "getimgjsurl" Then
        e = GetImgJsUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "regexpgetstr" Then
        e = RegExpGetStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "newgetpingip" Then
        e = NewGetPingIP(strDQ(e))
    ElseIf j = "getpingip" Then
        e = GetPingIP(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getpinginfo" Then
        e = GetPingInfo(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "regexptest" Then
        e = RegExpTest(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getregexpstr" Then
        e = getRegExpStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "regexpreplacecssdir" Then
        e = regExpReplaceCssDir(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deletenullrow" Then
        e = deleteNullRow(strDQ(e))
    ElseIf j = "getbl" Then
        e = getBL(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getcountstep" Then
        e = getCountStep(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "getchina" Then
        e = GetChina(strDQ(e))
    ElseIf j = "phprand" Then
        e = PHPRand(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "phprnd" Then
        e = PHPRnd(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deleterepeatstr" Then
        e = DeleteRepeatStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "replacen" Then
        e = ReplaceN(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "fillzero" Then
        e = FillZero(strDQ(e))
    ElseIf j = "caseinsensitivereplace" Then
        e = CaseInsensitiveReplace(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "array_sort" Then
        e = Array_Sort(strDQ(e))
    ElseIf j = "handlezipsize" Then
        e = HandleZipSize(strDQ(e))
    ElseIf j = "getrnd" Then
        e = GetRnd(strDQ(e))
    ElseIf j = "mathrandom" Then
        e = MathRandom()
    ElseIf j = "getrndaz" Then
        e = GetRndAZ(strDQ(e))
    ElseIf j = "getrand" Then
        e = GetRand(strDQ(e))
    ElseIf j = "copystrnumb" Then
        e = CopyStrNumb(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "str_repeat" Then
        e = Str_Repeat(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "copystr" Then
        e = CopyStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "contentaddtab" Then
        e = ContentAddTab(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deleteendstr" Then
        e = DeleteEndStr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "tonumber" Then
        e = toNumber(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlenumber" Then
        e = HandleNumber(strDQ(e))
    ElseIf j = "strdrawint" Then
        e = strDrawInt(strDQ(e))
    ElseIf j = "getfirstnegativenumber" Then
        e = GetFirstNegativeNumber(strDQ(e))
    ElseIf j = "checknumbertype" Then
        e = CheckNumberType(strDQ(e))
    ElseIf j = "checkstrisnumbertype" Then
        e = checkStrIsNumberType(strDQ(e))
    ElseIf j = "handlenumbertype" Then
        e = HandleNumberType(strDQ(e))
    ElseIf j = "getnumber" Then
        e = GetNumber(strDQ(e))
    ElseIf j = "checknumb" Then
        e = checkNumb(strDQ(e))
    ElseIf j = "getdiannumb" Then
        e = GetDianNumb(strDQ(e))
    ElseIf j = "getcountpage" Then
        e = GetCountPage(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getpagenumb" Then
        e = GetPageNumb(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getcaihandlecountpage" Then
        e = GetCaiHandleCountPage(strDQ(e))
    ElseIf j = "getcaisortcountpage" Then
        e = GetCaiSortCountPage(strDQ(e))
    ElseIf j = "minmaxbetween" Then
        e = MinMaxBetween(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getstrfiletype" Then
        e = GetStrFileType(strDQ(e))
    ElseIf j = "val" Then
        e = Val(strDQ(e))
    ElseIf j = "strlen" Then
        e = StrLen(strDQ(e))
    ElseIf j = "addindent" Then
        e = AddIndent(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getnumberbeforestr" Then
        e = GetNumberBeforeStr(strDQ(e))
    ElseIf j = "makepassword" Then
        e = makePassword(strDQ(e))
    ElseIf j = "rndcode" Then
        e = rndcode(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getrandomphonenumber" Then
        e = GetRandomPhoneNumber(strDQ(e))
    ElseIf j = "lenstr" Then
        e = lenStr(strDQ(e))
    ElseIf j = "tostring" Then
        e = ToString(strDQ(e))
    ElseIf j = "remotenumber" Then
        e = remoteNumber(strDQ(e))
    ElseIf j = "saveremotefile" Then
        e = SaveRemoteFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "downfile" Then
        e = DownFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "popupdownfile" Then
        e = popupDownFile(strDQ(e))
    ElseIf j = "xmlgetstatus" Then
        e = XMLGetStatus(strDQ(e))
    ElseIf j = "xmlpost" Then
        e = XMLPost(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "utfxmlpost" Then
        e = UTFXMLPost(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlexmlpost" Then
        e = HandleXMLPost(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "xmlget" Then
        e = XmlGet(strDQ(e))
    ElseIf j = "handlexmlget" Then
        e = handleXmlGet(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "cookiespost" Then
        e = CookiesPost(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlecookiespost" Then
        e = handleCookiesPost(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getremotefilesize" Then
        e = getRemoteFileSize(strDQ(e))
    ElseIf j = "downremotefile" Then
        e = DownRemoteFile(strDQ(e))
    ElseIf j = "imagestobase64" Then
        e = ImagesToBase64(strDQ(e))
    ElseIf j = "base64toimages" Then
        e = Base64ToImages(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getsqlincontent" Then
        e = getSqlInContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handlesqlin" Then
        e = handleSqlIn(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "sqlinurl" Then
        e = SqlInUrl(strDQ(e))
    ElseIf j = "handlurlcanshu" Then
        e = HandlUrlCanShu(strDQ(e))
    ElseIf j = "handlestrcharset" Then
        e = handleStrCharSet(strDQ(e))
    ElseIf j = "urlencoding" Then
        e = URLEncoding(strDQ(e))
    ElseIf j = "getwinhttp" Then
        e = getWinHttp(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "format_time" Then
        e = Format_Time(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getdaystatus" Then
        e = GetDayStatus(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "printtimevalue" Then
        e = PrintTimeValue(strDQ(e))
    ElseIf j = "printasktime" Then
        e = PrintAskTime(strDQ(e))
    ElseIf j = "gettimerset" Then
        e = GetTimerSet()
    ElseIf j = "calculationtimer" Then
        e = CalculationTimer(strDQ(e))
    ElseIf j = "gettimer" Then
        e = GetTimer()
    ElseIf j = "vbgettimer" Then
        e = VBGetTimer()
    ElseIf j = "vbechotimer" Then
        e = VBEchoTimer()
    ElseIf j = "vbruntimer" Then
        e = VBRunTimer(strDQ(e))
    ElseIf j = "getthisurlnoparam" Then
        e = GetThisUrlNoParam()
    ElseIf j = "getgotourl" Then
        e = GetGoToUrl()
    ElseIf j = "getgotourlnoparam" Then
        e = GetGoToUrlNoParam()
    ElseIf j = "getgotourlnofilename" Then
        e = GetGoToUrlNoFileName()
    ElseIf j = "getip2" Then
        e = GetIP2()
    ElseIf j = "getip" Then
        e = GetIP()
    ElseIf j = "getservicerip" Then
        e = GetServicerIP()
    ElseIf j = "getremoteip" Then
        e = GetRemoteIP()
    ElseIf j = "handlehttpurl" Then
        e = HandleHttpUrl(strDQ(e))
    ElseIf j = "handlefileurl" Then
        e = HandleFileUrl(strDQ(e))
    ElseIf j = "handleurlcomplete" Then
        e = HandleUrlComplete(strDQ(e))
    ElseIf j = "urladdhttpurl" Then
        e = UrlAddHttpUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "webdomain" Then
        e = WebDoMain()
    ElseIf j = "host" Then
        e = Host()
    ElseIf j = "httphost" Then
        e = HttpHost()
    ElseIf j = "gethost" Then
        e = GetHost()
    ElseIf j = "geturl" Then
        e = GetUrl()
    ElseIf j = "getthisurl" Then
        e = GetThisUrl()
    ElseIf j = "getwebsite" Then
        e = GetWebSite(strDQ(e))
    ElseIf j = "checkurl" Then
        e = checkUrl(strDQ(e))
    ElseIf j = "checkhttpurl" Then
        e = checkHttpUrl(strDQ(e))
    ElseIf j = "isurl" Then
        e = isUrl(strDQ(e))
    ElseIf j = "ishttpurl" Then
        e = isHttpUrl(strDQ(e))
    ElseIf j = "fullhttpurl" Then
        e = FullHttpUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "batchfullhttpurl" Then
        e = batchFullHttpUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "urljianjiehandle" Then
        e = URLJianJieHandle(strDQ(e))
    ElseIf j = "urltoasc" Then
        e = UrlToAsc(strDQ(e))
    ElseIf j = "getwebtitle" Then
        e = GetWebTitle(strDQ(e))
    ElseIf j = "mystrcut" Then
        e = MyStrCut(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "getcontentahref" Then
        e = GetContentAHref(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "getcontentimgsrc" Then
        e = GetContentImgSrc(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handleconenturl" Then
        e = HandleConentUrl(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "replacecontentjsdir" Then
        e = replaceContentJsDir(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handlelink" Then
        e = HandleLink(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)),strDQ(h(6)))
    ElseIf j = "getendurlhandlename" Then
        e = GetEndUrlHandleName(strDQ(e))
    ElseIf j = "getwebfoldername" Then
        e = GetWebFolderName()
    ElseIf j = "getwebhome" Then
        e = GetWebHome()
    ElseIf j = "geturllistinwebsitelist" Then
        e = GetUrlListInWebSiteList(strDQ(e))
    ElseIf j = "getthisurlfilename" Then
        e = GetThisUrlFileName()
    ElseIf j = "handlewebhtmlimg" Then
        e = HandleWebHtmlImg(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handlewebcssimg" Then
        e = HandleWebCssImg(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "batchhandleurlintegrity" Then
        e = BatchHandleUrlIntegrity(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "replacecontentimagepath" Then
        e = ReplaceContentImagePath(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getcsslinklist" Then
        e = GetCssLinkList(strDQ(e))
    ElseIf j = "gethtmlbackgroundurllist" Then
        e = GetHtmlBackGroundUrlList(strDQ(e))
    ElseIf j = "getimgurllist" Then
        e = GetImgUrlList(strDQ(e))
    ElseIf j = "getlinkurl" Then
        e = GetLinkUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "localurlorremoteurl" Then
        e = LocalUrlOrRemoteUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checkremoteurl" Then
        e = CheckRemoteUrl(strDQ(e))
    ElseIf j = "gethandleurl" Then
        e = GetHandleUrl(strDQ(e))
    ElseIf j = "webdebug" Then
        e = WebDebug(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "asailinkadd" Then
        e = AsaiLinkAdd(strDQ(e))
    ElseIf j = "asailinkdel" Then
        e = AsaiLinkDel(strDQ(e))
    ElseIf j = "iswww" Then
        e = Iswww(strDQ(e))
    ElseIf j = "geturladdtoparam" Then
        e = GetUrlAddToParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "groupurl" Then
        e = groupUrl(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlepostcookiesparame" Then
        e = handlePostCookiesParame(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "remotehttpurlparameter" Then
        e = remoteHttpUrlParameter(strDQ(e))
    ElseIf j = "checkurlname" Then
        e = checkUrlName(strDQ(e))
    ElseIf j = "handlehttpurlarray" Then
        e = HandleHttpUrlArray(strDQ(e))
    ElseIf j = "remotejscssparam" Then
        e = remoteJsCssParam(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handleremotejscssparam" Then
        e = handleRemoteJsCssParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "batchhandlehttpurlcomplete" Then
        e = batchHandleHttpUrlComplete(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "iswebsite" Then
        e = isWebSite(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "issonwebsite" Then
        e = isSonWebSite(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handleiswebsite" Then
        e = handleIsWebSite(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getcontenturllist" Then
        e = getContentUrlList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlegetcontenturllist" Then
        e = HandleGetContentUrlList(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getinchain" Then
        e = getInChain(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getfiletext" Then
        e = GetFileText(strDQ(e))
    ElseIf j = "getftext" Then
        e = GetFText(strDQ(e))
    ElseIf j = "getfiletype" Then
        e = GetFileType(strDQ(e))
    ElseIf j = "checkfile" Then
        e = CheckFile(strDQ(e))
    ElseIf j = "existsfile" Then
        e = ExistsFile(strDQ(e))
    ElseIf j = "createfile" Then
        e = CreateFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "savefile" Then
        e = SaveFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "createaddfile" Then
        e = CreateAddFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "createaddupfile" Then
        e = CreateAddUpFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "addtofile" Then
        e = AddToFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "savebytefile" Then
        e = saveByteFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "createbytefile" Then
        e = createByteFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "movefile" Then
        e = MoveFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "editfile" Then
        e = EditFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "copyfile" Then
        e = CopyFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deletefile" Then
        e = DeleteFile(strDQ(e))
    ElseIf j = "delselfile" Then
        e = DelSelFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "delfilelist" Then
        e = DelFileList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deleteappointfilelist" Then
        e = DeleteAppointFileList(strDQ(e))
    ElseIf j = "getfilesize" Then
        e = GetFileSize(strDQ(e))
    ElseIf j = "filesize" Then
        e = FileSize(strDQ(e))
    ElseIf j = "getfsize" Then
        e = GetFSize(strDQ(e))
    ElseIf j = "getfilecreatedate" Then
        e = GetFileCreateDate(strDQ(e))
    ElseIf j = "filecreatedate" Then
        e = FileCreateDate(strDQ(e))
    ElseIf j = "getfileeditdate" Then
        e = GetFileEditDate(strDQ(e))
    ElseIf j = "fileeditdate" Then
        e = FileEditDate(strDQ(e))
    ElseIf j = "getfileedittime" Then
        e = GetFileEditTime(strDQ(e))
    ElseIf j = "getdatelastaccessed" Then
        e = GetDateLastAccessed(strDQ(e))
    ElseIf j = "modifyfilemodifydate" Then
        e = ModifyFileModifydate(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "editfileeditdate" Then
        e = EditFileEditDate(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "existszhidufile" Then
        e = ExistsZhiDuFile(strDQ(e))
    ElseIf j = "getfileattribute" Then
        e = GetFileAttribute(strDQ(e))
    ElseIf j = "editfileattribute" Then
        e = EditFileAttribute(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "existsfileday" Then
        e = ExistsFileDay(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checkfileday" Then
        e = CheckFileDay(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "createfolder" Then
        e = CreateFolder(strDQ(e))
    ElseIf j = "createdirfolder" Then
        e = createDirFolder(strDQ(e))
    ElseIf j = "createdomain" Then
        e = CreateDomain(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "createdomainfolder" Then
        e = CreateDomainFolder(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "movefolder" Then
        e = MoveFolder(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "editfolder" Then
        e = EditFolder(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "copyfolder" Then
        e = CopyFolder(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deletefolder" Then
        e = DeleteFolder(strDQ(e))
    ElseIf j = "getfoldersize" Then
        e = GetFolderSize(strDQ(e))
    ElseIf j = "checkfolder" Then
        e = CheckFolder(strDQ(e))
    ElseIf j = "existsfolder" Then
        e = ExistsFolder(strDQ(e))
    ElseIf j = "getfoldercreatedate" Then
        e = GetFolderCreateDate(strDQ(e))
    ElseIf j = "getfoldereditdate" Then
        e = GetFolderEditDate(strDQ(e))
    ElseIf j = "getfoldertime" Then
        e = getFolderTime(strDQ(e))
    ElseIf j = "getfolderattribute" Then
        e = GetFolderAttribute(strDQ(e))
    ElseIf j = "editfolderattribute" Then
        e = EditFolderAttribute(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "existsfolderday" Then
        e = ExistsFolderDay(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checkfolderday" Then
        e = CheckFolderDay(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getfilefolderlist" Then
        e = GetFileFolderList(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)),strDQ(h(6)))
    ElseIf j = "getdirjpglist" Then
        e = GetDirJpgList(strDQ(e))
    ElseIf j = "getdirinilist" Then
        e = GetDirIniList(strDQ(e))
    ElseIf j = "getdirtxtlist" Then
        e = GetDirTxtList(strDQ(e))
    ElseIf j = "getdirhtmllist" Then
        e = GetDirHtmlList(strDQ(e))
    ElseIf j = "getdirfilelist" Then
        e = GetDirFileList(strDQ(e))
    ElseIf j = "getdirhtmllistname" Then
        e = GetDirHtmlListName(strDQ(e))
    ElseIf j = "getdirfilenamelist" Then
        e = GetDirFileNameList(strDQ(e))
    ElseIf j = "getdirallfilenamelist" Then
        e = GetDirAllFileNameList(strDQ(e))
    ElseIf j = "getdirfolderlist" Then
        e = GetDirFolderList(strDQ(e))
    ElseIf j = "getdirfoldernamelist" Then
        e = GetDirFolderNameList(strDQ(e))
    ElseIf j = "getthisallfolder" Then
        e = getThisAllFolder(strDQ(e))
    ElseIf j = "getthisallfoldername" Then
        e = getThisAllFolderName(strDQ(e))
    ElseIf j = "getfilefoldernumb" Then
        e = GetFileFolderNumb(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getdirfoldernumb" Then
        e = GetDirFolderNumb(strDQ(e))
    ElseIf j = "getdirfoldersize" Then
        e = GetDirFolderSize(strDQ(e))
    ElseIf j = "getdirfilenumb" Then
        e = GetDirFileNumb(strDQ(e))
    ElseIf j = "getdirallfilenumb" Then
        e = GetDirAllFileNumb(strDQ(e))
    ElseIf j = "getdirallfoldernumb" Then
        e = GetDirAllFolderNumb(strDQ(e))
    ElseIf j = "getfolderlist" Then
        e = GetFolderList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getdirfilesort" Then
        e = GetDirFileSort(strDQ(e))
    ElseIf j = "getdirfoldersort" Then
        e = GetDirFolderSort(strDQ(e))
    ElseIf j = "deldirallfile" Then
        Call DelDirAllFile(strDQ(e))
    ElseIf j = "deleteallfile" Then
        Call DeleteAllFile(strDQ(e))
    ElseIf j = "getupdatefile" Then
        e = GetUpdateFile(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "handlepath" Then
        e = HandlePath(strDQ(e))
    ElseIf j = "realpath" Then
        e = RealPath(strDQ(e))
    ElseIf j = "fullpath" Then
        e = FullPath(strDQ(e))
    ElseIf j = "handlerelativepath" Then
        e = handleRelativePath(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "dirname" Then
        e = DirName(strDQ(e))
    ElseIf j = "isobjinstalled" Then
        e = IsObjInstalled(strDQ(e))
    ElseIf j = "existsobject" Then
        e = ExistsObject(strDQ(e))
    ElseIf j = "getfileobject" Then
        e = GetFileObject()
    ElseIf j = "getdictionary" Then
        e = GetDictionary()
    ElseIf j = "getstream" Then
        e = GetStream()
    ElseIf j = "showattributetip" Then
        e = ShowAttributeTip(strDQ(e))
    ElseIf j = "printspacevalue" Then
        e = PrintSpaceValue(strDQ(e))
    ElseIf j = "printspacesize" Then
        e = PrintSpaceSize(strDQ(e))
    ElseIf j = "printfilesize" Then
        e = PrintFileSize(strDQ(e))
    ElseIf j = "getdeskpath" Then
        e = GetDeskPath()
    ElseIf j = "createurlshortcut" Then
        e = CreateUrlShortcut(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "createfoldershortcut" Then
        e = CreateFolderShortcut(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "finddirfilename" Then
        e = FindDirFileName(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "findsubdirfilename" Then
        e = FindSubDirFileName(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getarticlefillcontent" Then
        e = GetArticleFillContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getfilepathname" Then
        e = GetFilePathName(strDQ(e))
    ElseIf j = "getextension" Then
        e = getExtension(strDQ(e))
    ElseIf j = "removefiledir" Then
        e = RemoveFileDir(strDQ(e))
    ElseIf j = "basename" Then
        e = BaseName(strDQ(e))
    ElseIf j = "getfileextname" Then
        e = getFileExtName(strDQ(e))
    ElseIf j = "handlefilepatharray" Then
        e = HandleFilePathArray(strDQ(e))
    ElseIf j = "getstrfilename" Then
        e = getStrFileName(strDQ(e))
    ElseIf j = "getfileattr" Then
        e = getFileAttr(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "fileext" Then
        e = FileExt(strDQ(e))
    ElseIf j = "getparentpath" Then
        e = getParentPath(strDQ(e))
    ElseIf j = "checkerr" Then
        Call CheckErr(strDQ(e))
    ElseIf j = "strtotruefalse" Then
        e = StrToTrueFalse(strDQ(e))
    ElseIf j = "strtruefalsetoint" Then
        e = StrTrueFalseToInt(strDQ(e))
    ElseIf j = "checkvbcrlf" Then
        e = CheckVbCrlf(strDQ(e))
    ElseIf j = "checkbr" Then
        e = CheckBr(strDQ(e))
    ElseIf j = "isparity" Then
        e = isParity(strDQ(e))
    ElseIf j = "checkeval" Then
        e = CheckEval(strDQ(e))
    ElseIf j = "replace_sqltext" Then
        e = Replace_SQLText(strDQ(e))
    ElseIf j = "chkpost" Then
        e = ChkPost()
    ElseIf j = "ismail" Then
        e = IsMail(strDQ(e))
    ElseIf j = "isvalidemail" Then
        e = IsValidEmail(strDQ(e))
    ElseIf j = "iscode" Then
        e = IsCode(strDQ(e))
    ElseIf j = "checknumber" Then
        e = CheckNumber(strDQ(e))
    ElseIf j = "isnumber" Then
        e = IsNumber(strDQ(e))
    ElseIf j = "checkabc" Then
        e = CheckABC(strDQ(e))
    ElseIf j = "getlen" Then
        e = GetLen(strDQ(e))
    ElseIf j = "checktime" Then
        e = CheckTime(strDQ(e))
    ElseIf j = "isnul" Then
        e = isNul(strDQ(e))
    ElseIf j = "foundinarr" Then
        e = FoundInArr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "showhtmlcode" Then
        e = showHTMLCode(strDQ(e))
    ElseIf j = "showhtml" Then
        e = ShowHtml(strDQ(e))
    ElseIf j = "unhtmlcode" Then
        e = unHTMLCode(strDQ(e))
    ElseIf j = "echohtml" Then
        e = EchoHTML(strDQ(e))
    ElseIf j = "errortext" Then
        e = ErrorText(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "testhtml" Then
        Call TestHtml()
    ElseIf j = "htmldecode" Then
        e = HtmlDecode(strDQ(e))
    ElseIf j = "htmlencode" Then
        e = HtmlEncode(strDQ(e))
    ElseIf j = "htmlfilter" Then
        e = HtmlFilter(strDQ(e))
    ElseIf j = "regreplace" Then
        e = regReplace(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "easp_replace" Then
        e = Easp_Replace(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handlehtmllabelclose" Then
        e = handleHtmlLabelClose(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "handleimgclose" Then
        e = handleImgClose(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlebrclose" Then
        e = handleBrClose(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlehrclose" Then
        e = handleHrClose(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handleclosehtml" Then
        e = handleCloseHtml(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "htmllabeltoclean" Then
        e = htmlLabelToClean(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "addtooraddhttpurl" Then
        e = addToOrAddHttpUrl(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "removeblanklines" Then
        e = removeBlankLines(strDQ(e))
    ElseIf j = "removeblanklines_test1" Then
        e = removeBlankLines_test1(strDQ(e))
    ElseIf j = "checkcode" Then
        e = CheckCode(strDQ(e))
    ElseIf j = "seniorcheckcode" Then
        e = SeniorCheckCode(strDQ(e))
    ElseIf j = "readfile" Then
        e = ReadFile(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getstext" Then
        e = GetStext(strDQ(e))
    ElseIf j = "writetofile" Then
        e = WriteToFile(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getugtext" Then
        e = GetUGText(strDQ(e))
    ElseIf j = "checkcontentcharset" Then
        e = CheckContentCharset(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checkfilecode" Then
        e = CheckFileCode(strDQ(e))
    ElseIf j = "getfilebinarycontent" Then
        e = GetFileBinaryContent(strDQ(e))
    ElseIf j = "binaryreadfile" Then
        e = BinaryReadFile(strDQ(e))
    ElseIf j = "readbinary" Then
        e = ReadBinary(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "decsavebinary" Then
        e = DecSaveBinary(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "writebinary" Then
        Call WriteBinary(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getfilecharset" Then
        e = GetFileCharset(strDQ(e))
    ElseIf j = "bintohex" Then
        e = BinToHex(strDQ(e))
    ElseIf j = "asphelptip" Then
        e = ASPHelpTip(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlewrite" Then
        e = HandleWrite(strDQ(e))
    ElseIf j = "jiantitabfanti" Then
        e = JianTiTabFanTi(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "jiyicireplace" Then
        e = JiYiCiReplace(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "cireplace" Then
        e = CiReplace(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "testgetpy" Then
        Call TestGetPY()
    ElseIf j = "pinyin" Then
        e = PinYin(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "pinyin2" Then
        e = PinYin2(strDQ(e))
    ElseIf j = "entocompany" Then
        e = EnToCompany(strDQ(e))
    ElseIf j = "remotecontentjinghao" Then
        e = remoteContentJingHao(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "remotearrayjinghao" Then
        e = remoteArrayJingHao(strDQ(e))
    ElseIf j = "geteachstraddvalue" Then
        e = getEachStrAddValue(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getvalueinarrayid" Then
        e = getValueInArrayID(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checkvalueinarray" Then
        e = checkValueInArray(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deleterepeatarray" Then
        e = DeleteRepeatArray(strDQ(e))
    ElseIf j = "deleterepeatcontent" Then
        e = DeleteRepeatContent(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getarraycount" Then
        e = GetArrayCount(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "randomshow" Then
        e = RandomShow(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "arrayrandomshow" Then
        e = ArrayRandomShow(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "printarray" Then
        Call PrintArray(strDQ(e))
    ElseIf j = "echoarray" Then
        Call EchoArray(strDQ(e))
    ElseIf j = "str_shuffle" Then
        e = Str_Shuffle(strDQ(e))
    ElseIf j = "characterupset" Then
        e = CharacterUpset(strDQ(e))
    ElseIf j = "str_split" Then
        e = Str_Split(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "removenullvaluearray" Then
        e = RemoveNullValueArray(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "removerepeatvaluearray" Then
        e = RemoveRepeatValueArray(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlearray" Then
        e = HandleArray(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "testarraydata" Then
        e = TestArrayData()
    ElseIf j = "selectsort" Then
        e = SelectSort(strDQ(e))
    ElseIf j = "quicksort" Then
        e = QuickSort(strDQ(e))
    ElseIf j = "bubblesort" Then
        e = BubbleSort(strDQ(e))
    ElseIf j = "insertsort" Then
        e = InsertSort(strDQ(e))
    ElseIf j = "requicksort" Then
        e = ReQuickSort(strDQ(e))
    ElseIf j = "arrayreverse" Then
        e = arrayReverse()
    ElseIf j = "responsearray" Then
        Call ResponseArray(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "max" Then
        e = Max(strDQ(e))
    ElseIf j = "min" Then
        e = Min(strDQ(e))
    ElseIf j = "testtwodimensionalarray" Then
        e = TestTwoDimensionalArray()
    ElseIf j = "handlesplitarray" Then
        e = HandleSplitArray(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "twodimensionalarrayasc" Then
        e = TwoDimensionalArrayAsc(strDQ(e))
    ElseIf j = "twodimensionalarraydesc" Then
        e = TwoDimensionalArrayDesc(strDQ(e))
    ElseIf j = "csscompression" Then
        e = CssCompression(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "deletecssnote" Then
        e = DeleteCssNote(strDQ(e))
    ElseIf j = "uncsscompression" Then
        e = UnCssCompression(strDQ(e))
    ElseIf j = "trimvbcrlf" Then
        e = TrimVbCrlf(strDQ(e))
    ElseIf j = "phptrim" Then
        e = PHPTrim(strDQ(e))
    ElseIf j = "ltrimvbcrlf" Then
        e = ltrimVBcrlf(strDQ(e))
    ElseIf j = "rtrimvbcrlf" Then
        e = rtrimVBcrlf(strDQ(e))
    ElseIf j = "trimvbtab" Then
        e = TrimVbTab(strDQ(e))
    ElseIf j = "ltrimvbtab" Then
        e = LTrimVbTab(strDQ(e))
    ElseIf j = "rtrimvbtab" Then
        e = RTrimVBTab(strDQ(e))
    ElseIf j = "gethtmlcssstyle" Then
        e = GetHtmlCssStyle(strDQ(e))
    ElseIf j = "handlecleancss" Then
        e = HandleCleanCss(strDQ(e))
    ElseIf j = "removeexcessrow" Then
        e = RemoveExcessRow(strDQ(e))
    ElseIf j = "cssaddtostyle" Then
        e = CssAddToStyle(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "checkcssstyle" Then
        e = CheckCssStyle(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "cssstyleaddtoparam" Then
        e = CssStyleAddToParam(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "findcssstyle" Then
        e = FindCssStyle(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlecutcsscode" Then
        e = HandleCutCssCode(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlecutdivcode" Then
        e = HandleCutDivCode(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "gethtmlbackgroundimglist" Then
        e = GetHtmlBackGroundImgList(strDQ(e))
    ElseIf j = "gethandlewebhtmllink" Then
        e = GetHandleWebHtmlLink(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getcsslisturllist" Then
        e = getCssListUrlList(strDQ(e))
    ElseIf j = "handlereadcsscontent" Then
        e = handleReadCssContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "handlecsspx" Then
        e = HandleCssPX(strDQ(e))
    ElseIf j = "handlehtmlstyle" Then
        e = handleHtmlStyle(strDQ(e))
    ElseIf j = "utf2gb" Then
        e = UTF2GB(strDQ(e))
    ElseIf j = "checkutftogb2312" Then
        e = CheckUTFToGB2312(strDQ(e))
    ElseIf j = "convchinese" Then
        e = ConvChinese(strDQ(e))
    ElseIf j = "utf8_urlencoding" Then
        e = UTF8_URLEncoding(strDQ(e))
    ElseIf j = "toutf8" Then
        e = toUTF8(strDQ(e))
    ElseIf j = "chinese2unicode" Then
        e = chinese2unicode(strDQ(e))
    ElseIf j = "isvalidhex" Then
        e = isvalidhex(strDQ(e))
    ElseIf j = "escape" Then
        e = escape(strDQ(e))
    ElseIf j = "unescape" Then
        e = unescape(strDQ(e))
    ElseIf j = "chinesetounicode" Then
        e = ChineseToUnicode(strDQ(e))
    ElseIf j = "unicodetochinese" Then
        e = UnicodeToChinese(strDQ(e))
    ElseIf j = "urlencode" Then
        e = URLEncode(strDQ(e))
    ElseIf j = "urldecode" Then
        e = URLDecode(strDQ(e))
    ElseIf j = "gbtoutf8" Then
        e = GBtoUTF8(strDQ(e))
    ElseIf j = "encdecurl" Then
        e = EncDecURL(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "encurl" Then
        e = EncURL(strDQ(e))
    ElseIf j = "decurl" Then
        e = DecURL(strDQ(e))
    ElseIf j = "infocolor" Then
        e = infoColor(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "imgerror" Then
        e = imgError()
    ElseIf j = "targetstr" Then
        e = targetStr(strDQ(e))
    ElseIf j = "atarget" Then
        e = aTarget(strDQ(e))
    ElseIf j = "atitle" Then
        e = aTitle(strDQ(e))
    ElseIf j = "imgalt" Then
        e = imgAlt(strDQ(e))
    ElseIf j = "imgtitlealt" Then
        e = imgTitleAlt(strDQ(e))
    ElseIf j = "arel" Then
        e = aRel(strDQ(e))
    ElseIf j = "styleclass" Then
        e = styleClass(strDQ(e))
    ElseIf j = "textfontb" Then
        e = textFontB(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "textfontcolor" Then
        e = textFontColor(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "fontcolorfontb" Then
        e = fontColorFontB(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getdefaultfilename" Then
        e = getDefaultFileName()
    ElseIf j = "ahref" Then
        e = aHref(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "imgsrc" Then
        e = imgSrc(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "selecttarget" Then
        e = selectTarget(strDQ(e))
    ElseIf j = "selectfontcolor" Then
        e = selectFontColor(strDQ(e))
    ElseIf j = "selectsex" Then
        e = selectSex(strDQ(e))
    ElseIf j = "selectsessioncookies" Then
        e = selectSessionCookies(strDQ(e))
    ElseIf j = "showselectlist" Then
        e = showSelectList(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "showarticleliststyle" Then
        e = showArticleListStyle(strDQ(e))
    ElseIf j = "showarticleinfostyle" Then
        e = showArticleInfoStyle(strDQ(e))
    ElseIf j = "handlearticleliststyleorinfostyle" Then
        e = handleArticleListStyleOrInfoStyle(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "showwebmoduleskins" Then
        e = showWebModuleSkins(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "showradiolist" Then
        e = showRadioList(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputcheckbox" Then
        e = inputCheckBox(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "inputtext" Then
        e = inputText(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputtext2" Then
        e = inputText2(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "inputlefttext" Then
        e = inputLeftText(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputlefttexthelptextright" Then
        e = inputLeftTextHelpTextRight(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputlefttextcontent" Then
        e = inputLeftTextContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputrighttextcontent" Then
        e = inputRightTextContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handleinputleftrighttextcontent" Then
        e = handleInputLeftRightTextContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "inputleftpasstext" Then
        e = inputLeftPassText(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputleftpasstextcontent" Then
        e = inputLeftPassTextContent(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "inputhiddentext" Then
        e = inputHiddenText(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "inputtextarea" Then
        e = inputTextArea(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "inputhiddentextarea" Then
        e = inputHiddenTextArea(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "handleinputhiddentextarea" Then
        e = handleInputHiddenTextArea(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)))
    ElseIf j = "showselectdirlist" Then
        e = showSelectDirList(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "inputdisabled" Then
        e = inputDisabled(strDQ(e))
    ElseIf j = "inputaddalt" Then
        e = inputAddAlt(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "webtitle_inputtextarea" Then
        e = webTitle_InputTextArea(strDQ(e))
    ElseIf j = "webkeywords_inputtext" Then
        e = webKeywords_InputText(strDQ(e))
    ElseIf j = "webdescription_inputtextarea" Then
        e = webDescription_InputTextArea(strDQ(e))
    ElseIf j = "foldername_inputtext" Then
        e = folderName_InputText(strDQ(e))
    ElseIf j = "filename_inputtext" Then
        e = fileName_InputText(strDQ(e))
    ElseIf j = "templatepath_inputtext" Then
        e = templatePath_InputText(strDQ(e))
    ElseIf j = "clickpinyinhtmlstr" Then
        e = clickPinYinHTMLStr(strDQ(e))
    ElseIf j = "showfontcolorfontb" Then
        e = showFontColorFontB(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "showsort" Then
        e = showSort(strDQ(e))
    ElseIf j = "showwebnavtype" Then
        e = showWebNavType(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)),strDQ(h(5)))
    ElseIf j = "showonhtml" Then
        e = showOnHtml(strDQ(e))
    ElseIf j = "showthrough" Then
        e = showThrough(strDQ(e))
    ElseIf j = "showrecommend" Then
        e = showRecommend(strDQ(e))
    ElseIf j = "showonoffimg" Then
        e = showOnOffImg(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "newshowonoffimg" Then
        e = newShowOnOffImg(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "controldialogcss" Then
        e = controlDialogCss()
    ElseIf j = "htmlformatting" Then
        e = htmlFormatting(strDQ(e))
    ElseIf j = "handlehtmlformatting" Then
        e = HandleHtmlFormatting(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "checkhtmlformatting" Then
        e = checkHtmlFormatting(strDQ(e))
    ElseIf j = "newreplacevalueparam" Then
        e = newReplaceValueParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "newrparam" Then
        e = newRParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getcontentallrunstr" Then
        e = getContentAllRunStr(strDQ(e))
    ElseIf j = "getcontentrunstr" Then
        e = getContentRunStr(strDQ(e))
    ElseIf j = "checkcontentrunstr" Then
        e = checkContentRunStr(strDQ(e))
    ElseIf j = "handledoublequotation" Then
        e = handleDoubleQuotation(strDQ(e))
    ElseIf j = "strdq" Then
        e = strDQ(strDQ(e))
    ElseIf j = "handletoarray" Then
        e = handleToArray(strDQ(e))
    ElseIf j = "handlecontentcode" Then
        e = handleContentCode(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handleinmodule" Then
        e = handleInModule(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "clearrparam" Then
        e = clearRParam(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "atrparam" Then
        e = atRParam(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "rparam" Then
        e = rParam(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "handlerparam" Then
        e = handleRParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getconfigblock" Then
        e = getConfigBlock(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getconfigblock2" Then
        e = getConfigBlock2(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getconfigblock3" Then
        e = getConfigBlock3(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getcutconfigblock" Then
        e = getCutConfigBlock(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "getconfigcontentblock" Then
        e = getConfigContentBlock(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getconfigfileblock" Then
        e = getConfigFileBlock(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "setconfigfileblock" Then
        e = setConfigFileBlock(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "delconfigblock" Then
        e = delConfigBlock(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "delconfigblock2" Then
        e = delConfigBlock2(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "delconfigblock3" Then
        e = delConfigBlock3(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "delcutconfigblock" Then
        e = delCutConfigBlock(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "getfileparamvalue" Then
        e = getFileParamValue(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "setfileparamvalue" Then
        e = setFileParamValue(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "handlegetsetfileparamevalue" Then
        e = handleGetSetFileParameValue(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "setrparam" Then
        e = setRParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "addreplacerparam" Then
        e = addReplaceRParam(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "deletestrcut" Then
        e = deleteStrCut(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "replacecontentmodule" Then
        e = replaceContentModule(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)),strDQ(h(4)))
    ElseIf j = "replacecontentrowmodule" Then
        e = replaceContentRowModule(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "handleconfigfile" Then
        Call handleConfigFile(strDQ(e))
    ElseIf j = "getrparam" Then
        e = getRParam(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getdefaultvalue" Then
        e = getDefaultValue(strDQ(e))
    ElseIf j = "modulefindcontent" Then
        e = moduleFindContent(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "batchfindfunction" Then
        e = BatchFindFunction(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getfindfilefunction" Then
        e = GetFindFileFunction(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "getaspcode" Then
        e = GetASPCode(strDQ(e))
    ElseIf j = "handlegetaspcode" Then
        e = HandleGetAspCode(strDQ(h(0)),strDQ(h(1)))
    ElseIf j = "delaspnote" Then
        e = DelAspNote(strDQ(e))
    ElseIf j = "findaspfunction" Then
        e = FindAspFunction(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)),strDQ(h(3)))
    ElseIf j = "firstletteruppercase" Then
        e = FirstLetterUppercase(strDQ(e))
    ElseIf j = "contentlushow" Then
        e = ContentLUShow(strDQ(e))
    ElseIf j = "asptovb" Then
        e = ASPToVB(strDQ(e))
    ElseIf j = "asptovbnet" Then
        e = ASPToVBNET(strDQ(e))
    ElseIf j = "dimadddefaultvalue" Then
        e = dimAddDefaultValue(strDQ(e))
    ElseIf j = "functionparamtonet" Then
        e = functionParamtoNet(strDQ(e))
    ElseIf j = "getbeforenstr" Then
        e = GetBeforeNStr(strDQ(h(0)),strDQ(h(1)),strDQ(h(2)))
    ElseIf j = "getstrdim" Then
        e = getStrDim(strDQ(e))
    ElseIf j = "getfunctionstrdim" Then
        e = getFunctionStrDim(strDQ(e))
    ElseIf j = "getrandcolor" Then
        e = GetRandColor()






    ElseIf j = "now" Then
        e = Now()

    ElseIf j = "date" Then
        e = Date

    ElseIf j = "len" Then
        e = Len(e)

    ElseIf j = "lcase" Then
        e = LCase(e)

    ElseIf j = "ucase" Then
        e = UCase(e)

    ElseIf j = "ltrim" Then
        e = LTrim(e)

    ElseIf j = "rtrim" Then
        e = RTrim(e)

    ElseIf j = "trim" Then
        e = Trim(e)

    ElseIf j = "left" Then
        h = Split(e & ",1", ",")
        e = Left(Trim(h(0)), Trim(h(1)))

    ElseIf j = "right" Then
        e = Right(Trim(h(0)), Trim(h(1)))

    ElseIf j = "mid" Then
        h = Split(e & ",99999", ",")
        If UBound(h) >= 2 Then
            e = Mid(Trim(h(0)), Trim(h(1)), Trim(h(2)))
        Else
            e = Mid(Trim(h(0)), Trim(h(1)))
        End If
    End If
    a = Replace(a, f, e)
    handleContentCode = a
End Function



Function handleInModule(a, b)
    b = LCase(CStr(b))
    If b = "1" Or b = "start" Then
        a = Replace(a, "\'", "\|*|\")
        a = Replace(a, "\=", "\|&|\")
    ElseIf b = "2" Or b = "end" Then
        a = Replace(a, "\|*|\", "'")
        a = Replace(a, "\$", "$")
        a = Replace(a, "\}", "}")

        a = Replace(a, "\|&|\", "=")
    End If
    handleInModule = a
End Function

Function clearRParam(ByVal a, ByVal b)
    Dim c

    a = Replace(a, "\'", "")
    c = RParam(a, b)

    clearRParam = c
End Function

Function atRParam(ByVal a, ByVal b)
    atRParam = RParam(a, b)
    If InStr(atRParam, "{$") > 0 And InStr(atRParam, "$}") > 0 Then
        atRParam = HandleTemplateAction(atRParam, False)
    End If
End Function

Function rParam(ByVal a, ByVal b)
    Dim c
	

    c = handleRParam(a, b, "'")

    If c = "" Then
        c = handleRParam(a, b, """")
    End If

    If c = "" Then
        c = handleRParam(a, b, "")
    End If


    If c = "" Then
        c = handleRParam(a, LCase(b), "'")
    End If

    If c = "" Then
        c = handleRParam(a, LCase(b), """")
    End If

    If c = "" Then
        c = handleRParam(a, LCase(b), "")
    End If


    If c = "" Then
        c = handleRParam(a, UCase(b), "'")
    End If

    If c = "" Then
        c = handleRParam(a, UCase(b), """")
    End If

    If c = "" Then
        c = handleRParam(a, UCase(b), "")
    End If


    If c = "[#空*值_#]" Then c = ""
    rParam = c
End Function

Function handleRParam(ByVal a, ByVal b, ByVal c)
    Dim d, e, f, g
    f = False
    e = IIF(c <> "", c, " ")
    a = vbCrLf & " " & a

    d = " " & b

    If InStr(a, d & "=" & c) = False and f = False Then
        d = "'" & b
    Else
        f = True
    End If

    If InStr(a, d & "=" & c) = False and f = False Then
        d = """" & b
    Else
        f = True
    End If

    If InStr(a, d & "=" & c) = False and f = False Then
        d = vbTab & b
    Else
        f = True
    End If

    If InStr(a, d & "=" & c) = False and f = False Then
        d = vbCrLf & b
    Else
        f = True
    End If
    If InStr(a, d & "=" & c) > 0 And InStr(a, e) > 0 Then
        g = StrCut(a, d & "=" & c, e, 2)
        g = handleInModule(g, "end")

        If g = "" Then
            g = "[#空*值_#]"
        End If


        If InStr(g, "{$") > 0 And InStr(g, "$}") > 0 Then




        End If




    End If
	handleRParam=g
End Function



Function getConfigBlock(a, b)
    getConfigBlock = GetCutConfigBlock(a, b, "#", "#")
End Function

Function getConfigBlock2(a, b)
    getConfigBlock2 = GetCutConfigBlock(a, b, "[#", "#]")
End Function

Function getConfigBlock3(a, b)
    getConfigBlock3 = GetCutConfigBlock(a, b, "[$", "$]")
End Function

Function getCutConfigBlock(a, b, c, d)
    Dim e, f
    e = c & b & d
    f = c & b & d

    If InStr(a, e & " start") > 0 Then
        e = e & " start"
    Else
        e = e & " Start"
    End If

    If InStr(a, f & " end") > 0 Then
        f = f & " end"
    Else
        f = f & " End"
    End If

    If InStr(a, e) > 0 And InStr(a, f) > 0 Then
        getCutConfigBlock = StrCut(a, e, f, 2)
    End If
End Function

Function getConfigContentBlock(ByVal a, b)
    getConfigContentBlock = getCutConfigBlock(a, b, "", "")
End Function

Function getConfigFileBlock(ByVal a, b)
    Dim c, d, e, f, g
    c = GetFText(a)

    f = b & " start"
    g = b & " end"
    e = f & "" & g
    If InStr(c, f) > 0 And InStr(c, g) > 0 Then
        d = StrCut(c, f, g, 2)
        getConfigFileBlock = d
    Else
        Call CreateFile(a, c & e)
    End If
End Function

Function setConfigFileBlock(ByVal a, ByVal b, c)
    Dim d, e, f, g, h
    d = GetFText(a)
    g = c & " start"
    h = c & " end"
    f = g & b & h
    If InStr(d, g) > 0 And InStr(d, h) > 0 Then
        e = StrCut(d, g, h, 1)
        d = Replace(d, e, f)
        Call CreateFile(a, d)
    Else
        Call CreateFile(a, d & f)
    End If
End Function


Function delConfigBlock(a, b)
    delConfigBlock = DelCutConfigBlock(a, b, "#", "#")
End Function

Function delConfigBlock2(a, b)
    delConfigBlock2 = DelCutConfigBlock(a, b, "[#", "#]")
End Function

Function delConfigBlock3(a, b)
    delConfigBlock3 = DelCutConfigBlock(a, b, "[$", "$]")
End Function

Function delCutConfigBlock(a, b, c, d)
    Dim e, f, g
    e = c & b & d & " start"
    f = c & b & d & " end"
    If InStr(a, e) > 0 And InStr(a, f) > 0 Then
        g = StrCut(a, e, f, 1)
        a = Replace(a, g, "")
    End If
    delCutConfigBlock = a
End Function





Function getFileParamValue(a, b)
    getFileParamValue = HandleGetSetFileParameValue(a, b, "", "获得")
End Function

Function setFileParamValue(a, b, c)
    setFileParamValue = HandleGetSetFileParameValue(a, b, c, "设置")
End Function

Function handleGetSetFileParameValue(a, b, c, d)
    Dim e, f, g, h, i

    If checkFile(a) = False Then
        Call CreateFile(a, "")
    End If
    If checkFile(a) = False Then Exit Function

    e = TrimVbCrlf(GetFText(a))
    f = vbCrLf & b & "=" : g = vbCrLf
    i = vbCrLf & b & "=" & c & vbCrLf
    If InStr(vbCrLf & e, f) > 0 And InStr(e & vbCrLf, g) > 0 Then
        h = StrCut(vbCrLf & e & vbCrLf, f, g, 2)
        If d = "获得" Then
            handleGetSetFileParameValue = h
            Exit Function
        End If
        h = f & h & g
        e = Replace(vbCrLf & e & vbCrLf, h, i)
        Call CreateFile(a, e)
    Else
        Call CreateFile(a, e & vbCrLf & TrimVbCrlf(i))
    End If
End Function


Function setRParam(a, b, c, d)
    Dim e, f, g, h
    e = PHPTrim(GetFText(a))
    f = b & "='" : g = "'"
    If InStr(e, f) > 0 And InStr(e, g) > 0 Then
        h = StrCut(e, f, g, 2)
        e = Replace(e, f & h & g, f & c & g)
        Call CreateFile(a, e)

    ElseIf Trim(d) = "1" Then
        Call CreateAddFile(a, f & c & g)
    End If
End Function


Function addReplaceRParam(ByVal a, b, c, ByVal d)
    Dim e
    d = b & d & c
    If InStr(a, b) > 0 And InStr(a, c) > 0 Then
        e = StrCut(a, b, c, 1)
        a = Replace(a, e, d)
    Else
        a = a & vbCrLf & d
    End If
    addReplaceRParam = a
End Function

Function deleteStrCut(ByVal a, ByVal b, ByVal c, ByVal d, e)
    Dim f, g
    If e = 0 Then
        e = 99
    End If
    For f = 0 To e
        g = getStrCut(a, b, c, 1)
        If g <> "" Then
            a = Replace(a, g, "")
        Else
            Exit For
        End If
    Next
    deleteStrCut = a
End Function










Function replaceContentModule(ByVal a, b, c, d, e)
    Dim f, g, h, i, j, k, l, m, n, o, p, q
    If InStr(a, b) = False and InStr(a, c) = False Then
        replaceContentModule = a
        Exit Function
    End If
    j = "$Array$"
    For i = 1 To 99
        If InStr(a, b) > 0 and InStr(a, c) > 0 Then
            h = StrCut(a, b, c, 1) : p = h
            h = Mid(h, Len(b) + 1, Len(h) - Len(b) - Len(c))
            l = getEachStrAddValue(b, "|*|")
            If InStr(j & k & j, j & l & j) = False Then
                If k <> "" Then k = k & j
                k = k & l
                If n <> "" Then n = n & j
                n = n & b
            End If
            m = getEachStrAddValue(c, "|*|")
            If InStr(j & k & j, j & m & j) = False Then
                If k <> "" Then k = k & j
                k = k & m
                If n <> "" Then n = n & j
                n = n & c
            End If

            If e = "追加在前" Then
                q = l & d & h & m
            ElseIf e = "追加在后" Or e = "追加" Then
                q = l & h & d & m
            ElseIf e = "外部追加在前" Then
                q = d & l & h & m

            ElseIf e = "外部追加在后" Or e = "外部追加" Then
                q = l & h & m & d
            Else
                q = d
            End If

            a = Replace(a, p, q)
        Else
            Exit For
        End If
    Next

    f = Split(k, j)
    g = Split(n, j)
    For i = 0 To UBound(f)
        o = f(i)
        d = g(i)
        a = Replace(a, o, d)
    Next
    replaceContentModule = a
End Function





Function replaceContentRowModule(a, b, c, d)
    Dim e, f, g, h, i, j, k, l, m
    h = "$Array$"
    For g = 1 To 99
        If InStr(a, b) > 0 Then
            m = getEachStrAddValue(b, "|*|")
            If InStr(h & i & h, h & m & h) = False Then
                If i <> "" Then i = i & h
                i = i & m
                If j <> "" Then j = j & h
                j = j & b
            End If
            If d = "追加在前" Then
                l = c & m
            ElseIf d = "追加在后" Or d = "追加" Then
                l = m & c
            Else
                l = c
            End If
            a = Replace(a, b, l)
        Else
            Exit For
        End If
    Next


    e = Split(i, h)
    f = Split(j, h)
    For g = 0 To UBound(e)
        k = e(g)
        c = f(g)
        a = Replace(a, k, c)
    Next
    replaceContentRowModule = a

End Function

Sub handleConfigFile(a)
    Dim b
    If checkFile(a) = False Then
        b = "#Help帮助# start" & vbCrLf & "默认帮助内容" & vbCrLf & "#Help帮助# end"
        Call CreateFile(a, b)
    End If
End Sub


Function getRParam(ByVal a, ByVal b)
    Dim c, d, e, f, g, h, i, j
    a = " " & a & " "
    c = LCase(a)
    b = LCase(b)
    d = Mid(a, InStr(c, b) + Len(b))

    h = False
    j = False
    For e = 1 To Len(d)
        f = Mid(d, e, 1)
        If h = True Then
            If f <> "" Then
                If i = "" Then
                    i = f
                Else
                    If i = """" Or i = "'" Then
                        If f = i Then
                            j = True
                            Exit For
                        End If
                    ElseIf f = " " and g = "" Then

                    ElseIf f = " " Or f = "/" Or f = ">" Then
                        j = True
                        Exit For
                    End If
                    If f <> " " Then
                        g = g & f
                    End If
                End If
            End If
        End If

        If f = "=" Then
            h = True
        End If
    Next
    If j = False Then
        g = ""
    End If
    getRParam = g

End Function


Function getDefaultValue(a)
    getDefaultValue = ModuleFindContent(a, "default")
End Function


sub addModuleReplaceArray(a,b)
	dim c
	for c=1 to ubound(ModuleReplaceArray)-1
		if ModuleReplaceArray(c,0)="" then
			ModuleReplaceArray(c,0)=a
			ModuleReplaceArray(0,c)=b
			exit sub
		end if
	next
end sub


Function moduleFindContent(a, b)
    Dim c, d, e
    c = rParam(a, b)

    d = "<!--#" & c & " start#-->"
    e = "<!--#" & c & " end#-->"



    If InStr(code, d) > 0 And InStr(code, e) > 0 Then
        c = StrCut(code, d, e, 2)
    Else
        d = "<!--#" & c
        e = "#-->"
        If InStr(code, d) > 0 And InStr(code, e) > 0 Then
            c = StrCut(code, d, e, 2)


        End If
    End If


    Dim f
    f = rParam(a, "deletedefault")
    If f = "true" Then
        Call addModuleReplaceArray("【删除】", d & c & e)
    End If
    moduleFindContent = c
End Function
%>





