<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-02
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN nEWrEPlACeVAlUEpARaM(a, b, c)
dIM d, e, f, g, h, i, j
iF iSNuL(c) = tRUe tHEn c = ""
d = "[$" & b : e = "$]"
iF iNStR(a, d) > 0 aND iNStR(a, e) > 0 tHEn
f = sTRcUT(a, d, e, 1)
i = rPArAM(f, "DelHtml")
iF i = "true" tHEn c = rEPlACe(dELhTMl(c), "<", "&lt;")
j = rPArAM(f, "Trim")
iF j = "true" tHEn c = tRImVBcRLf(c)
g = rPArAM(f, "Len")
g = hANdLEnUMbER(g)
iF g <> "" tHEn c = cUTsTR(c, g, "...")
h = rPArAM(f, "Format_Time")
iF h <> "" tHEn
c = fORmAT_TImE(c, h)
eND iF
a = rEPlACe(a, f, c)
eND iF
nEWrEPlACeVAlUEpARaM = a
eND fUNcTIoN
fUNcTIoN nEWrPArAM(a, b, c)
dIM d, e, f
d = rPArAM(b, c)
e = "<!--#" & d & " start#-->"
f = "<!--#" & d & " end#-->"
iF d <> "" tHEn
iF iNStR(a, e) > 0 aND iNStR(a, f) > 0 tHEn
d = sTRcUT(a, e, f, 2)
eLSe
e = "<!--#" & d
f = "#-->"
iF iNStR(a, e) > 0 aND iNStR(a, f) > 0 tHEn
d = sTRcUT(a, e, f, 2)
eND iF
eND iF
eND iF
nEWrPArAM = d
eND fUNcTIoN
fUNcTIoN gETcONtENtALlRUnSTr(a)
dIM b, c, d
b = sPLiT(a, vBCrLF)
fOR eACh c iN b
c = rEPlACe(rEPlACe(c, cHR(10), ""), cHR(13), "")
d = d & hANdLEcONtENtCOdE(c, "")
nEXt
gETcONtENtALlRUnSTr = d
eND fUNcTIoN
fUNcTIoN gETcONtENtRUnSTr(bYVaL a)
gETcONtENtRUnSTr = hANdLEcONtENtCOdE(a, "")
eND fUNcTIoN
fUNcTIoN cHEcKCoNTeNTrUNsTR(bYVaL a)
cHEcKCoNTeNTrUNsTR = hANdLEcONtENtCOdE(a, "check")
eND fUNcTIoN
fUNcTIoN hANdLEdOUbLEqUOtATiON(bYVaL a)
dIM b
b = pHPtRIm(a)
iF lEFt(b, 1) = """" aND rIGhT(b, 1) = """" tHEn
a = mID(b, 2, lEN(b) - 2)
eND iF
hANdLEdOUbLEqUOtATiON = a
eND fUNcTIoN
fUNcTIoN sTRdQ(bYVaL a)
sTRdQ = hANdLEdOUbLEqUOtATiON(a)
eND fUNcTIoN
fUNcTIoN hANdLEtOArRAy(a)
dIM b, c
a = sTRcUT(a, "(", ")", 2)
b = sPLiT(a, ",")
fOR c = 0 tO uBOuND(b)
b(c) = sTRdQ(b(c))
nEXt
hANdLEtOArRAy = b
eND fUNcTIoN
fUNcTIoN hANdLEcONtENtCOdE(bYVaL a, b)
dIM c, d, e, f, g, h, i
dIM j
dIM k
dIM l
l = lCAsE(a)
iF b = "check" oR b = "检测" tHEn
hANdLEcONtENtCOdE = fALsE
eND iF
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
g = sPLiT(i, "|")
fOR eACh j iN g
iF j <> "" tHEn
c = lCAsE(j & "(") : d = ")"
k = iNStR(" " & l, " " & c)
iF k > 0 aND iNStR(l, d) > 0 tHEn
iF b = "check" oR b = "检测" tHEn
hANdLEcONtENtCOdE = tRUe
eXIt fUNcTIoN
eND iF
eXIt fOR
eND iF
eND iF
nEXt
iF j = "" tHEn
iF b <> "check" aND b <> "检测" tHEn
hANdLEcONtENtCOdE = a
eND iF
eXIt fUNcTIoN
eND iF
j = lCAsE(j)
c = j & "(" : d = ")"
k = iNStR(l, c)
f = mID(a, iNStR(l, c))
f = mID(f, 1, iNStRReV(f, d))
e = mID(a, iNStR(l, c) + lEN(c))
e = mID(e, 1, iNStRReV(e, d) - 1)
iF cHEcKCoNTeNTrUNsTR(a) = tRUe tHEn
e = gETcONtENtRUnSTr(e)
eND iF
e = hANdLEdOUbLEqUOtATiON(e)
h = sPLiT(e & ",1", ",")
iF j = "printpre" tHEn
e = pRInTPrE(sTRdQ(e))
eLSeIF j = "authorinfo" tHEn
e = aUThORiNFo(sTRdQ(e))
eLSeIF j = "authorinfo2" tHEn
e = aUThORiNFo2()
eLSeIF j = "foldingmenu" tHEn
e = fOLdINgMEnU(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "returnren" tHEn
e = rETuRNrEN(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "returnhr" tHEn
e = rETuRNhR()
eLSeIF j = "returnrenhr" tHEn
e = rETuRNrENhR()
eLSeIF j = "showerr" tHEn
cALl sHOwERr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "printforminfo" tHEn
cALl pRInTFoRMiNFo()
eLSeIF j = "dedecmsmsg" tHEn
e = dEDeCMsMSg()
eLSeIF j = "handleaccessdata" tHEn
e = hANdLEaCCeSSdATa(sTRdQ(e))
eLSeIF j = "adsql" tHEn
e = aDSqL(sTRdQ(e))
eLSeIF j = "getwhereand" tHEn
e = gETwHErEAnD(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "orandsearch" tHEn
e = oRAnDSeARcH(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "checkaccesspass" tHEn
e = cHEcKAcCEsSPaSS(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checksql" tHEn
e = cHEcKSqL(sTRdQ(e))
eLSeIF j = "createtable" tHEn
e = cREaTEtABlE(sTRdQ(e))
eLSeIF j = "showistable" tHEn
e = sHOwIStABlE(sTRdQ(e))
eLSeIF j = "getrecordcount" tHEn
e = gETrECoRDcOUnT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "tablecount" tHEn
e = tABlECoUNt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "opentable" tHEn
e = oPEnTAbLE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "inserttable" tHEn
e = iNSeRTtABlE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "gettabletext" tHEn
e = gETtABlETeXT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "createmdb" tHEn
e = cREaTEmDB(sTRdQ(e))
eLSeIF j = "deletetable" tHEn
e = dELeTEtABlE(sTRdQ(e))
eLSeIF j = "deletealltable" tHEn
e = dELeTEaLLtABlE(sTRdQ(e))
eLSeIF j = "checktable" tHEn
e = cHEcKTaBLe(sTRdQ(e))
eLSeIF j = "existstable" tHEn
e = eXIsTStABlE(sTRdQ(e))
eLSeIF j = "edittable" tHEn
e = eDItTAbLE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "checkfield" tHEn
e = cHEcKFiELd(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "existsfield" tHEn
e = eXIsTSfIElD(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "editfield" tHEn
e = eDItFIeLD(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getfieldalt" tHEn
e = gETfIElDAlT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "gettablelist_conn" tHEn
e = gETtABlELiST_COnN(sTRdQ(e))
eLSeIF j = "gettablelist" tHEn
e = gETtABlELiST()
eLSeIF j = "getfieldlist" tHEn
e = gETfIElDLiST(sTRdQ(e))
eLSeIF j = "getdifferenttablefieldlist" tHEn
e = gETdIFfEReNTtABlEFiELdLIsT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "compactdb" tHEn
e = cOMpACtDB(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "editaccesspassword" tHEn
e = eDItACcESsPAsSWoRD(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "handlesqlserver" tHEn
e = hANdLEsQLsERvER(sTRdQ(e))
eLSeIF j = "exporttoexcel" tHEn
cALl eXPoRTtOExCEl(sTRdQ(e))
eLSeIF j = "importtodatabase" tHEn
cALl iMPoRTtODaTAbASe()
eLSeIF j = "getdatatablelist" tHEn
e = gETdATaTAbLElISt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "settablefield" tHEn
e = sETtABlEFiELd(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "gettypestring" tHEn
e = gETtYPeSTrINg(sTRdQ(e))
eLSeIF j = "getproductrndidlist" tHEn
e = gETpROdUCtRNdIDlISt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getfieldvalue" tHEn
e = gETfIElDVaLUe(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getconnfieldvalue" tHEn
e = gETcONnFIeLDvALuE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "setfieldvalue" tHEn
e = sETfIElDVaLUe(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "filebinaryaddaccess" tHEn
e = fILeBInARyADdACcESs(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)))
eLSeIF j = "showaccessstream" tHEn
e = sHOwACcESsSTrEAm(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "gethttppage" tHEn
e = gEThTTpPAgE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlegethttppage" tHEn
e = hANdLEgEThTTpPAgE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "geturlcontent" tHEn
e = gETuRLcONtENt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "gethttpurl" tHEn
e = gEThTTpURl(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "bytestobstr" tHEn
e = bYTeSToBStR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "strcut" tHEn
e = sTRcUT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "getstrcut" tHEn
e = gETsTRcUT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "cutstr" tHEn
e = cUTsTR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "cutstrnolu" tHEn
e = cUTsTRnOLu(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "setcuttdstr" tHEn
e = sETcUTtDStR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "cuttdstr" tHEn
e = cUTtDStR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getarraylist" tHEn
e = gETaRRaYLiST(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)))
eLSeIF j = "getarray" tHEn
e = gETaRRaY(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "getarray1" tHEn
e = gETaRRaY1(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "getsplit" tHEn
e = gETsPLiT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getsplitcount" tHEn
e = gETsPLiTCoUNt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "agent" tHEn
e = aGEnT(sTRdQ(e))
eLSeIF j = "specialhtmluploadencryptiondecrypt" tHEn
e = sPEcIAlHTmLUpLOaDEnCRyPTiONdECrYPt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "encaspcontent" tHEn
e = eNCaSPcONtENt(sTRdQ(e))
eLSeIF j = "uppercaseorlowercase" tHEn
e = uPPeRCaSEoRLoWErCAsE(sTRdQ(e))
eLSeIF j = "enccode" tHEn
e = eNCcODe(sTRdQ(e))
eLSeIF j = "deccode" tHEn
e = dECcODe(sTRdQ(e))
eLSeIF j = "tounicode" tHEn
e = tOUnICoDE(sTRdQ(e))
eLSeIF j = "japan" tHEn
e = jAPaN(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "japan26" tHEn
e = jAPaN26(sTRdQ(e))
eLSeIF j = "unjapan26" tHEn
e = uNJaPAn26(sTRdQ(e))
eLSeIF j = "handlehtml" tHEn
e = hANdLEhTMl(sTRdQ(e))
eLSeIF j = "unhandlehtml" tHEn
e = uNHaNDlEHtML(sTRdQ(e))
eLSeIF j = "lcaseenc" tHEn
e = lCAsEEnC(sTRdQ(e))
eLSeIF j = "lcasedec" tHEn
e = lCAsEDeC(sTRdQ(e))
eLSeIF j = "simpleenc" tHEn
e = sIMpLEeNC(sTRdQ(e))
eLSeIF j = "simpledec" tHEn
e = sIMpLEdEC(sTRdQ(e))
eLSeIF j = "encaspevalrun" tHEn
e = eNCaSPeVAlRUn(sTRdQ(e))
eLSeIF j = "htmltojs" tHEn
e = hTMlTOjS(sTRdQ(e))
eLSeIF j = "jstohtml" tHEn
e = jSToHTmL(sTRdQ(e))
eLSeIF j = "htmltoasp" tHEn
e = hTMlTOaSP(sTRdQ(e))
eLSeIF j = "htmltoaspdim" tHEn
e = hTMlTOaSPdIM(sTRdQ(e))
eLSeIF j = "asptohtml" tHEn
e = aSPtOHtML(sTRdQ(e))
eLSeIF j = "setfilename" tHEn
e = sETfILeNAmE(sTRdQ(e))
eLSeIF j = "unsetfilename" tHEn
e = uNSeTFiLEnAMe(sTRdQ(e))
eLSeIF j = "xorenc" tHEn
e = xOReNC(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "xordec" tHEn
e = xORdEC(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "htmltoascchr" tHEn
e = hTMlTOaSCcHR(sTRdQ(e))
eLSeIF j = "unhtmltoascchr" tHEn
e = uNHtMLtOAsCChR(sTRdQ(e))
eLSeIF j = "handleevaladddec" tHEn
e = hANdLEeVAlADdDEc(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "evaladddec" tHEn
e = eVAlADdDEc(sTRdQ(e))
eLSeIF j = "vbevaladddec" tHEn
e = vBEvALaDDdEC(sTRdQ(e))
eLSeIF j = "tohexcolor" tHEn
e = tOHeXCoLOr(sTRdQ(e))
eLSeIF j = "colorrgb" tHEn
e = cOLoRRgB(sTRdQ(e))
eLSeIF j = "xdec" tHEn
e = xDEc(sTRdQ(e))
eLSeIF j = "variabledisplacement" tHEn
e = vARiABlEDiSPlACeMEnT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "send_email" tHEn
e = sENd_EmAIl(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "serversend_email" tHEn
e = sERvERsENd_EmAIl(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)))
eLSeIF j = "findaspcode" tHEn
e = fINdASpCOdE(sTRdQ(e))
eLSeIF j = "findaspfunlist" tHEn
e = fINdASpFUnLIsT(sTRdQ(e))
eLSeIF j = "findaspfunctioncode" tHEn
e = fINdASpFUnCTiONcODe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlereplacelist" tHEn
e = hANdLErEPlACeLIsT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getfunnamedim" tHEn
e = gETfUNnAMeDIm(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "leftspace" tHEn
e = lEFtSPaCE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "rightspace" tHEn
e = rIGhTSpACe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "infunadddim" tHEn
e = iNFuNAdDDiM(sTRdQ(e))
eLSeIF j = "getqq" tHEn
e = gETqQ(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "gettel" tHEn
e = gETtEL(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getmail" tHEn
e = gETmAIl(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getimgstr" tHEn
e = gETiMGsTR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getcssstr" tHEn
e = gETcSSsTR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getjsstr" tHEn
e = gETjSStR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "handleaspexecute" tHEn
e = hANdLEaSPeXEcUTe(sTRdQ(e))
eLSeIF j = "geturlstr" tHEn
e = gETuRLsTR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "getpageconfig" tHEn
e = gETpAGeCOnFIg(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getsqlinurl" tHEn
e = gETsQLiNUrL(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "handlsqlinurl" tHEn
e = hANdLSqLInURl(sTRdQ(e))
eLSeIF j = "getscanfunctionnamelist" tHEn
e = gETsCAnFUnCTiONnAMeLIsT(sTRdQ(e))
eLSeIF j = "getfunname" tHEn
e = gETfUNnAMe(sTRdQ(e))
eLSeIF j = "getfundimname" tHEn
e = gETfUNdIMnAMe(sTRdQ(e))
eLSeIF j = "getdimname" tHEn
e = gETdIMnAMe(sTRdQ(e))
eLSeIF j = "getsetname" tHEn
e = gETsETnAMe(sTRdQ(e))
eLSeIF j = "replacedim" tHEn
e = rEPlACeDIm(sTRdQ(e))
eLSeIF j = "replacedim2" tHEn
e = rEPlACeDIm2(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "findfolderrepeatfunction" tHEn
e = fINdFOlDErREpEAtFUnCTiON(sTRdQ(e))
eLSeIF j = "findfilerepeatfunction" tHEn
e = fINdFIlERePEaTFuNCtIOn(sTRdQ(e))
eLSeIF j = "findcontentrepeatfunction" tHEn
e = fINdCOnTEnTRePEaTFuNCtIOn(sTRdQ(e))
eLSeIF j = "handlecontentrepeatfunction" tHEn
e = hANdLEcONtENtREpEAtFUnCTiON(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "replace2" tHEn
e = rEPlACe2(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "allreplace" tHEn
e = aLLrEPlACe(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "replaceonenolu" tHEn
e = rEPlACeONeNOlU(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "optimizeaspcode" tHEn
e = oPTiMIzEAsPCoDE(sTRdQ(e))
eLSeIF j = "aspcodeconfusion" tHEn
e = aSPcODeCOnFUsIOn(sTRdQ(e))
eLSeIF j = "aspvariablegarbled" tHEn
e = aSPvARiABlEGaRBlED(sTRdQ(e))
eLSeIF j = "lucasegarbled" tHEn
e = lUCaSEgARbLEd(sTRdQ(e))
eLSeIF j = "aspcodesafe" tHEn
e = aSPcODeSAfE(sTRdQ(e))
eLSeIF j = "cutdakuohao" tHEn
e = cUTdAKuOHaO(sTRdQ(e))
eLSeIF j = "cutxiankuohao" tHEn
e = cUTxIAnKUoHAo(sTRdQ(e))
eLSeIF j = "cutfunctionvvalue" tHEn
e = cUTfUNcTIoNVvALuE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getstrintcontentnumb" tHEn
e = gETsTRiNTcONtENtNUmB(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getkeyword" tHEn
e = gETkEYwORd(sTRdQ(e))
eLSeIF j = "gethandlekeyword" tHEn
e = gEThANdLEkEYwORd(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getchinastr" tHEn
e = gETcHInAStR(sTRdQ(e))
eLSeIF j = "checkstr" tHEn
e = cHEcKStR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "regexp_checkstr" tHEn
e = rEGeXP_CHeCKsTR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "existsstr" tHEn
e = eXIsTSsTR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "regexp_instr" tHEn
e = rEGeXP_INsTR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "regexp_replace" tHEn
e = rEGeXP_REpLAcE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "replacecolor" tHEn
e = rEPlACeCOlOR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "delhtml" tHEn
e = dELhTMl(sTRdQ(e))
eLSeIF j = "regexp_delhtml" tHEn
e = rEGeXP_DElHTmL(sTRdQ(e))
eLSeIF j = "getaurltitlelist" tHEn
e = gETaURlTItLElISt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getaurl" tHEn
e = gETaURl(sTRdQ(e))
eLSeIF j = "getatitle" tHEn
e = gETaTItLE(sTRdQ(e))
eLSeIF j = "getaurltitle" tHEn
e = gETaURlTItLE(sTRdQ(e))
eLSeIF j = "getcontentaurllist" tHEn
e = gETcONtENtAUrLLiST(sTRdQ(e))
eLSeIF j = "regexp_getimgurllist" tHEn
e = rEGeXP_GEtIMgURlLIsT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getimg" tHEn
e = gETiMG(sTRdQ(e))
eLSeIF j = "getimgjpg" tHEn
e = gETiMGjPG(sTRdQ(e))
eLSeIF j = "getimggif" tHEn
e = gETiMGgIF(sTRdQ(e))
eLSeIF j = "getimgbmp" tHEn
e = gETiMGbMP(sTRdQ(e))
eLSeIF j = "getaspfunctionlist" tHEn
e = gETaSPfUNcTIoNLiST(sTRdQ(e))
eLSeIF j = "getaspdimfunction" tHEn
e = gETaSPdIMfUNcTIoN(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "strlength" tHEn
e = sTRlENgTH(sTRdQ(e))
eLSeIF j = "regexpgetlenght" tHEn
e = rEGeXPgETlENgHT(sTRdQ(e))
eLSeIF j = "stringlength" tHEn
e = sTRiNGlENgTH(sTRdQ(e))
eLSeIF j = "getcsshref" tHEn
e = gETcSShREf(sTRdQ(e))
eLSeIF j = "getjssrc" tHEn
e = gETjSSrC(sTRdQ(e))
eLSeIF j = "delhtmlscript" tHEn
e = dELhTMlSCrIPt(sTRdQ(e))
eLSeIF j = "getmeta" tHEn
e = gETmETa(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "delhtmlnote" tHEn
e = dELhTMlNOtE(sTRdQ(e))
eLSeIF j = "delhtmlmynote" tHEn
e = dELhTMlMYnOTe(sTRdQ(e))
eLSeIF j = "getstrimglist" tHEn
e = gETsTRiMGlISt(sTRdQ(e))
eLSeIF j = "getemaillist" tHEn
e = gETeMAiLLiST(sTRdQ(e))
eLSeIF j = "oflink_lcasetag" tHEn
e = oFLiNK_LCaSEtAG(sTRdQ(e))
eLSeIF j = "scripthtml" tHEn
e = sCRiPThTMl(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getregexp" tHEn
e = gETrEGeXP(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "getimgjsurl" tHEn
e = gETiMGjSUrL(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "regexpgetstr" tHEn
e = rEGeXPgETsTR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "newgetpingip" tHEn
e = nEWgETpINgIP(sTRdQ(e))
eLSeIF j = "getpingip" tHEn
e = gETpINgIP(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getpinginfo" tHEn
e = gETpINgINfO(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "regexptest" tHEn
e = rEGeXPtESt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getregexpstr" tHEn
e = gETrEGeXPsTR(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "regexpreplacecssdir" tHEn
e = rEGeXPrEPlACeCSsDIr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deletenullrow" tHEn
e = dELeTEnULlROw(sTRdQ(e))
eLSeIF j = "getbl" tHEn
e = gETbL(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getcountstep" tHEn
e = gETcOUnTStEP(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "getchina" tHEn
e = gETcHInA(sTRdQ(e))
eLSeIF j = "phprand" tHEn
e = pHPrANd(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "phprnd" tHEn
e = pHPrND(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deleterepeatstr" tHEn
e = dELeTErEPeATsTR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "replacen" tHEn
e = rEPlACeN(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "fillzero" tHEn
e = fILlZErO(sTRdQ(e))
eLSeIF j = "caseinsensitivereplace" tHEn
e = cASeINsENsITiVErEPlACe(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "array_sort" tHEn
e = aRRaY_sORt(sTRdQ(e))
eLSeIF j = "handlezipsize" tHEn
e = hANdLEzIPsIZe(sTRdQ(e))
eLSeIF j = "getrnd" tHEn
e = gETrND(sTRdQ(e))
eLSeIF j = "mathrandom" tHEn
e = mAThRAnDOm()
eLSeIF j = "getrndaz" tHEn
e = gETrNDaZ(sTRdQ(e))
eLSeIF j = "getrand" tHEn
e = gETrANd(sTRdQ(e))
eLSeIF j = "copystrnumb" tHEn
e = cOPySTrNUmB(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "str_repeat" tHEn
e = sTR_REpEAt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "copystr" tHEn
e = cOPySTr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "contentaddtab" tHEn
e = cONtENtADdTAb(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deleteendstr" tHEn
e = dELeTEeNDsTR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "tonumber" tHEn
e = tONuMBeR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlenumber" tHEn
e = hANdLEnUMbER(sTRdQ(e))
eLSeIF j = "strdrawint" tHEn
e = sTRdRAwINt(sTRdQ(e))
eLSeIF j = "getfirstnegativenumber" tHEn
e = gETfIRsTNeGAtIVeNUmBEr(sTRdQ(e))
eLSeIF j = "checknumbertype" tHEn
e = cHEcKNuMBeRTyPE(sTRdQ(e))
eLSeIF j = "checkstrisnumbertype" tHEn
e = cHEcKStRIsNUmBErTYpE(sTRdQ(e))
eLSeIF j = "handlenumbertype" tHEn
e = hANdLEnUMbERtYPe(sTRdQ(e))
eLSeIF j = "getnumber" tHEn
e = gETnUMbER(sTRdQ(e))
eLSeIF j = "checknumb" tHEn
e = cHEcKNuMB(sTRdQ(e))
eLSeIF j = "getdiannumb" tHEn
e = gETdIAnNUmB(sTRdQ(e))
eLSeIF j = "getcountpage" tHEn
e = gETcOUnTPaGE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getpagenumb" tHEn
e = gETpAGeNUmB(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getcaihandlecountpage" tHEn
e = gETcAIhANdLEcOUnTPaGE(sTRdQ(e))
eLSeIF j = "getcaisortcountpage" tHEn
e = gETcAIsORtCOuNTpAGe(sTRdQ(e))
eLSeIF j = "minmaxbetween" tHEn
e = mINmAXbETwEEn(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getstrfiletype" tHEn
e = gETsTRfILeTYpE(sTRdQ(e))
eLSeIF j = "val" tHEn
e = vAL(sTRdQ(e))
eLSeIF j = "strlen" tHEn
e = sTRlEN(sTRdQ(e))
eLSeIF j = "addindent" tHEn
e = aDDiNDeNT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getnumberbeforestr" tHEn
e = gETnUMbERbEFoREsTR(sTRdQ(e))
eLSeIF j = "makepassword" tHEn
e = mAKePAsSWoRD(sTRdQ(e))
eLSeIF j = "rndcode" tHEn
e = rNDcODe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getrandomphonenumber" tHEn
e = gETrANdOMpHOnENuMBeR(sTRdQ(e))
eLSeIF j = "lenstr" tHEn
e = lENsTR(sTRdQ(e))
eLSeIF j = "tostring" tHEn
e = tOStRInG(sTRdQ(e))
eLSeIF j = "remotenumber" tHEn
e = rEMoTEnUMbER(sTRdQ(e))
eLSeIF j = "saveremotefile" tHEn
e = sAVeREmOTeFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "downfile" tHEn
e = dOWnFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "popupdownfile" tHEn
e = pOPuPDoWNfILe(sTRdQ(e))
eLSeIF j = "xmlgetstatus" tHEn
e = xMLgETsTAtUS(sTRdQ(e))
eLSeIF j = "xmlpost" tHEn
e = xMLpOSt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "utfxmlpost" tHEn
e = uTFxMLpOSt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlexmlpost" tHEn
e = hANdLExMLpOSt(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "xmlget" tHEn
e = xMLgET(sTRdQ(e))
eLSeIF j = "handlexmlget" tHEn
e = hANdLExMLgET(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "cookiespost" tHEn
e = cOOkIEsPOsT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlecookiespost" tHEn
e = hANdLEcOOkIEsPOsT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getremotefilesize" tHEn
e = gETrEMoTEfILeSIzE(sTRdQ(e))
eLSeIF j = "downremotefile" tHEn
e = dOWnREmOTeFIlE(sTRdQ(e))
eLSeIF j = "imagestobase64" tHEn
e = iMAgEStOBaSE64(sTRdQ(e))
eLSeIF j = "base64toimages" tHEn
e = bASe64tOImAGeS(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getsqlincontent" tHEn
e = gETsQLiNCoNTeNT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handlesqlin" tHEn
e = hANdLEsQLiN(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "sqlinurl" tHEn
e = sQLiNUrL(sTRdQ(e))
eLSeIF j = "handlurlcanshu" tHEn
e = hANdLUrLCaNShU(sTRdQ(e))
eLSeIF j = "handlestrcharset" tHEn
e = hANdLEsTRcHArSEt(sTRdQ(e))
eLSeIF j = "urlencoding" tHEn
e = uRLeNCoDInG(sTRdQ(e))
eLSeIF j = "getwinhttp" tHEn
e = gETwINhTTp(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "format_time" tHEn
e = fORmAT_TImE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getdaystatus" tHEn
e = gETdAYsTAtUS(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "printtimevalue" tHEn
e = pRInTTiMEvALuE(sTRdQ(e))
eLSeIF j = "printasktime" tHEn
e = pRInTAsKTiME(sTRdQ(e))
eLSeIF j = "gettimerset" tHEn
e = gETtIMeRSeT()
eLSeIF j = "calculationtimer" tHEn
e = cALcULaTIoNTiMEr(sTRdQ(e))
eLSeIF j = "gettimer" tHEn
e = gETtIMeR()
eLSeIF j = "vbgettimer" tHEn
e = vBGeTTiMEr()
eLSeIF j = "vbechotimer" tHEn
e = vBEcHOtIMeR()
eLSeIF j = "vbruntimer" tHEn
e = vBRuNTiMEr(sTRdQ(e))
eLSeIF j = "getthisurlnoparam" tHEn
e = gETtHIsURlNOpARaM()
eLSeIF j = "getgotourl" tHEn
e = gETgOToURl()
eLSeIF j = "getgotourlnoparam" tHEn
e = gETgOToURlNOpARaM()
eLSeIF j = "getgotourlnofilename" tHEn
e = gETgOToURlNOfILeNAmE()
eLSeIF j = "getip2" tHEn
e = gETiP2()
eLSeIF j = "getip" tHEn
e = gETiP()
eLSeIF j = "getservicerip" tHEn
e = gETsERvICeRIp()
eLSeIF j = "getremoteip" tHEn
e = gETrEMoTEiP()
eLSeIF j = "handlehttpurl" tHEn
e = hANdLEhTTpURl(sTRdQ(e))
eLSeIF j = "handlefileurl" tHEn
e = hANdLEfILeURl(sTRdQ(e))
eLSeIF j = "handleurlcomplete" tHEn
e = hANdLEuRLcOMpLEtE(sTRdQ(e))
eLSeIF j = "urladdhttpurl" tHEn
e = uRLaDDhTTpURl(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "webdomain" tHEn
e = wEBdOMaIN()
eLSeIF j = "host" tHEn
e = hOSt()
eLSeIF j = "httphost" tHEn
e = hTTpHOsT()
eLSeIF j = "gethost" tHEn
e = gEThOSt()
eLSeIF j = "geturl" tHEn
e = gETuRL()
eLSeIF j = "getthisurl" tHEn
e = gETtHIsURl()
eLSeIF j = "getwebsite" tHEn
e = gETwEBsITe(sTRdQ(e))
eLSeIF j = "checkurl" tHEn
e = cHEcKUrL(sTRdQ(e))
eLSeIF j = "checkhttpurl" tHEn
e = cHEcKHtTPuRL(sTRdQ(e))
eLSeIF j = "isurl" tHEn
e = iSUrL(sTRdQ(e))
eLSeIF j = "ishttpurl" tHEn
e = iSHtTPuRL(sTRdQ(e))
eLSeIF j = "fullhttpurl" tHEn
e = fULlHTtPUrL(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "batchfullhttpurl" tHEn
e = bATcHFuLLhTTpURl(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "urljianjiehandle" tHEn
e = uRLjIAnJIeHAnDLe(sTRdQ(e))
eLSeIF j = "urltoasc" tHEn
e = uRLtOAsC(sTRdQ(e))
eLSeIF j = "getwebtitle" tHEn
e = gETwEBtITlE(sTRdQ(e))
eLSeIF j = "mystrcut" tHEn
e = mYStRCuT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "getcontentahref" tHEn
e = gETcONtENtAHrEF(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "getcontentimgsrc" tHEn
e = gETcONtENtIMgSRc(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handleconenturl" tHEn
e = hANdLEcONeNTuRL(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "replacecontentjsdir" tHEn
e = rEPlACeCOnTEnTJsDIr(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handlelink" tHEn
e = hANdLElINk(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)),sTRdQ(h(6)))
eLSeIF j = "getendurlhandlename" tHEn
e = gETeNDuRLhANdLEnAMe(sTRdQ(e))
eLSeIF j = "getwebfoldername" tHEn
e = gETwEBfOLdERnAMe()
eLSeIF j = "getwebhome" tHEn
e = gETwEBhOMe()
eLSeIF j = "geturllistinwebsitelist" tHEn
e = gETuRLlIStINwEBsITeLIsT(sTRdQ(e))
eLSeIF j = "getthisurlfilename" tHEn
e = gETtHIsURlFIlENaME()
eLSeIF j = "handlewebhtmlimg" tHEn
e = hANdLEwEBhTMlIMg(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handlewebcssimg" tHEn
e = hANdLEwEBcSSiMG(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "batchhandleurlintegrity" tHEn
e = bATcHHaNDlEUrLInTEgRItY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "replacecontentimagepath" tHEn
e = rEPlACeCOnTEnTImAGePAtH(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getcsslinklist" tHEn
e = gETcSSlINkLIsT(sTRdQ(e))
eLSeIF j = "gethtmlbackgroundurllist" tHEn
e = gEThTMlBAcKGrOUnDUrLLiST(sTRdQ(e))
eLSeIF j = "getimgurllist" tHEn
e = gETiMGuRLlISt(sTRdQ(e))
eLSeIF j = "getlinkurl" tHEn
e = gETlINkURl(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "localurlorremoteurl" tHEn
e = lOCaLUrLOrREmOTeURl(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checkremoteurl" tHEn
e = cHEcKReMOtEUrL(sTRdQ(e))
eLSeIF j = "gethandleurl" tHEn
e = gEThANdLEuRL(sTRdQ(e))
eLSeIF j = "webdebug" tHEn
e = wEBdEBuG(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "asailinkadd" tHEn
e = aSAiLInKAdD(sTRdQ(e))
eLSeIF j = "asailinkdel" tHEn
e = aSAiLInKDeL(sTRdQ(e))
eLSeIF j = "iswww" tHEn
e = iSWwW(sTRdQ(e))
eLSeIF j = "geturladdtoparam" tHEn
e = gETuRLaDDtOPaRAm(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "groupurl" tHEn
e = gROuPUrL(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlepostcookiesparame" tHEn
e = hANdLEpOStCOoKIeSPaRAmE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "remotehttpurlparameter" tHEn
e = rEMoTEhTTpURlPArAMeTEr(sTRdQ(e))
eLSeIF j = "checkurlname" tHEn
e = cHEcKUrLNaME(sTRdQ(e))
eLSeIF j = "handlehttpurlarray" tHEn
e = hANdLEhTTpURlARrAY(sTRdQ(e))
eLSeIF j = "remotejscssparam" tHEn
e = rEMoTEjSCsSPaRAm(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handleremotejscssparam" tHEn
e = hANdLErEMoTEjSCsSPaRAm(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "batchhandlehttpurlcomplete" tHEn
e = bATcHHaNDlEHtTPuRLcOMpLEtE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "iswebsite" tHEn
e = iSWeBSiTE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "issonwebsite" tHEn
e = iSSoNWeBSiTE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handleiswebsite" tHEn
e = hANdLEiSWeBSiTE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getcontenturllist" tHEn
e = gETcONtENtURlLIsT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlegetcontenturllist" tHEn
e = hANdLEgETcONtENtURlLIsT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getinchain" tHEn
e = gETiNChAIn(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getfiletext" tHEn
e = gETfILeTExT(sTRdQ(e))
eLSeIF j = "getftext" tHEn
e = gETfTExT(sTRdQ(e))
eLSeIF j = "getfiletype" tHEn
e = gETfILeTYpE(sTRdQ(e))
eLSeIF j = "checkfile" tHEn
e = cHEcKFiLE(sTRdQ(e))
eLSeIF j = "existsfile" tHEn
e = eXIsTSfILe(sTRdQ(e))
eLSeIF j = "createfile" tHEn
e = cREaTEfILe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "savefile" tHEn
e = sAVeFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "createaddfile" tHEn
e = cREaTEaDDfILe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "createaddupfile" tHEn
e = cREaTEaDDuPFiLE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "addtofile" tHEn
e = aDDtOFiLE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "savebytefile" tHEn
e = sAVeBYtEFiLE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "createbytefile" tHEn
e = cREaTEbYTeFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "movefile" tHEn
e = mOVeFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "editfile" tHEn
e = eDItFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "copyfile" tHEn
e = cOPyFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deletefile" tHEn
e = dELeTEfILe(sTRdQ(e))
eLSeIF j = "delselfile" tHEn
e = dELsELfILe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "delfilelist" tHEn
e = dELfILeLIsT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deleteappointfilelist" tHEn
e = dELeTEaPPoINtFIlELiST(sTRdQ(e))
eLSeIF j = "getfilesize" tHEn
e = gETfILeSIzE(sTRdQ(e))
eLSeIF j = "filesize" tHEn
e = fILeSIzE(sTRdQ(e))
eLSeIF j = "getfsize" tHEn
e = gETfSIzE(sTRdQ(e))
eLSeIF j = "getfilecreatedate" tHEn
e = gETfILeCReATeDAtE(sTRdQ(e))
eLSeIF j = "filecreatedate" tHEn
e = fILeCReATeDAtE(sTRdQ(e))
eLSeIF j = "getfileeditdate" tHEn
e = gETfILeEDiTDaTE(sTRdQ(e))
eLSeIF j = "fileeditdate" tHEn
e = fILeEDiTDaTE(sTRdQ(e))
eLSeIF j = "getfileedittime" tHEn
e = gETfILeEDiTTiME(sTRdQ(e))
eLSeIF j = "getdatelastaccessed" tHEn
e = gETdATeLAsTAcCEsSEd(sTRdQ(e))
eLSeIF j = "modifyfilemodifydate" tHEn
e = mODiFYfILeMOdIFyDAtE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "editfileeditdate" tHEn
e = eDItFIlEEdITdATe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "existszhidufile" tHEn
e = eXIsTSzHIdUFiLE(sTRdQ(e))
eLSeIF j = "getfileattribute" tHEn
e = gETfILeATtRIbUTe(sTRdQ(e))
eLSeIF j = "editfileattribute" tHEn
e = eDItFIlEAtTRiBUtE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "existsfileday" tHEn
e = eXIsTSfILeDAy(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checkfileday" tHEn
e = cHEcKFiLEdAY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "createfolder" tHEn
e = cREaTEfOLdER(sTRdQ(e))
eLSeIF j = "createdirfolder" tHEn
e = cREaTEdIRfOLdER(sTRdQ(e))
eLSeIF j = "createdomain" tHEn
e = cREaTEdOMaIN(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "createdomainfolder" tHEn
e = cREaTEdOMaINfOLdER(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "movefolder" tHEn
e = mOVeFOlDEr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "editfolder" tHEn
e = eDItFOlDEr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "copyfolder" tHEn
e = cOPyFOlDEr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deletefolder" tHEn
e = dELeTEfOLdER(sTRdQ(e))
eLSeIF j = "getfoldersize" tHEn
e = gETfOLdERsIZe(sTRdQ(e))
eLSeIF j = "checkfolder" tHEn
e = cHEcKFoLDeR(sTRdQ(e))
eLSeIF j = "existsfolder" tHEn
e = eXIsTSfOLdER(sTRdQ(e))
eLSeIF j = "getfoldercreatedate" tHEn
e = gETfOLdERcREaTEdATe(sTRdQ(e))
eLSeIF j = "getfoldereditdate" tHEn
e = gETfOLdEReDItDAtE(sTRdQ(e))
eLSeIF j = "getfoldertime" tHEn
e = gETfOLdERtIMe(sTRdQ(e))
eLSeIF j = "getfolderattribute" tHEn
e = gETfOLdERaTTrIBuTE(sTRdQ(e))
eLSeIF j = "editfolderattribute" tHEn
e = eDItFOlDErATtRIbUTe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "existsfolderday" tHEn
e = eXIsTSfOLdERdAY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checkfolderday" tHEn
e = cHEcKFoLDeRDaY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getfilefolderlist" tHEn
e = gETfILeFOlDErLIsT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)),sTRdQ(h(6)))
eLSeIF j = "getdirjpglist" tHEn
e = gETdIRjPGlISt(sTRdQ(e))
eLSeIF j = "getdirinilist" tHEn
e = gETdIRiNIlISt(sTRdQ(e))
eLSeIF j = "getdirtxtlist" tHEn
e = gETdIRtXTlISt(sTRdQ(e))
eLSeIF j = "getdirhtmllist" tHEn
e = gETdIRhTMlLIsT(sTRdQ(e))
eLSeIF j = "getdirfilelist" tHEn
e = gETdIRfILeLIsT(sTRdQ(e))
eLSeIF j = "getdirhtmllistname" tHEn
e = gETdIRhTMlLIsTNaME(sTRdQ(e))
eLSeIF j = "getdirfilenamelist" tHEn
e = gETdIRfILeNAmELiST(sTRdQ(e))
eLSeIF j = "getdirallfilenamelist" tHEn
e = gETdIRaLLfILeNAmELiST(sTRdQ(e))
eLSeIF j = "getdirfolderlist" tHEn
e = gETdIRfOLdERlISt(sTRdQ(e))
eLSeIF j = "getdirfoldernamelist" tHEn
e = gETdIRfOLdERnAMeLIsT(sTRdQ(e))
eLSeIF j = "getthisallfolder" tHEn
e = gETtHIsALlFOlDEr(sTRdQ(e))
eLSeIF j = "getthisallfoldername" tHEn
e = gETtHIsALlFOlDErNAmE(sTRdQ(e))
eLSeIF j = "getfilefoldernumb" tHEn
e = gETfILeFOlDErNUmB(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getdirfoldernumb" tHEn
e = gETdIRfOLdERnUMb(sTRdQ(e))
eLSeIF j = "getdirfoldersize" tHEn
e = gETdIRfOLdERsIZe(sTRdQ(e))
eLSeIF j = "getdirfilenumb" tHEn
e = gETdIRfILeNUmB(sTRdQ(e))
eLSeIF j = "getdirallfilenumb" tHEn
e = gETdIRaLLfILeNUmB(sTRdQ(e))
eLSeIF j = "getdirallfoldernumb" tHEn
e = gETdIRaLLfOLdERnUMb(sTRdQ(e))
eLSeIF j = "getfolderlist" tHEn
e = gETfOLdERlISt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getdirfilesort" tHEn
e = gETdIRfILeSOrT(sTRdQ(e))
eLSeIF j = "getdirfoldersort" tHEn
e = gETdIRfOLdERsORt(sTRdQ(e))
eLSeIF j = "deldirallfile" tHEn
cALl dELdIRaLLfILe(sTRdQ(e))
eLSeIF j = "deleteallfile" tHEn
cALl dELeTEaLLfILe(sTRdQ(e))
eLSeIF j = "getupdatefile" tHEn
e = gETuPDaTEfILe(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "handlepath" tHEn
e = hANdLEpATh(sTRdQ(e))
eLSeIF j = "realpath" tHEn
e = rEAlPAtH(sTRdQ(e))
eLSeIF j = "fullpath" tHEn
e = fULlPAtH(sTRdQ(e))
eLSeIF j = "handlerelativepath" tHEn
e = hANdLErELaTIvEPaTH(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "dirname" tHEn
e = dIRnAMe(sTRdQ(e))
eLSeIF j = "isobjinstalled" tHEn
e = iSObJInSTaLLeD(sTRdQ(e))
eLSeIF j = "existsobject" tHEn
e = eXIsTSoBJeCT(sTRdQ(e))
eLSeIF j = "getfileobject" tHEn
e = gETfILeOBjECt()
eLSeIF j = "getdictionary" tHEn
e = gETdICtIOnARy()
eLSeIF j = "getstream" tHEn
e = gETsTReAM()
eLSeIF j = "showattributetip" tHEn
e = sHOwATtRIbUTeTIp(sTRdQ(e))
eLSeIF j = "printspacevalue" tHEn
e = pRInTSpACeVAlUE(sTRdQ(e))
eLSeIF j = "printspacesize" tHEn
e = pRInTSpACeSIzE(sTRdQ(e))
eLSeIF j = "printfilesize" tHEn
e = pRInTFiLEsIZe(sTRdQ(e))
eLSeIF j = "getdeskpath" tHEn
e = gETdESkPAtH()
eLSeIF j = "createurlshortcut" tHEn
e = cREaTEuRLsHOrTCuT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "createfoldershortcut" tHEn
e = cREaTEfOLdERsHOrTCuT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "finddirfilename" tHEn
e = fINdDIrFIlENaME(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "findsubdirfilename" tHEn
e = fINdSUbDIrFIlENaME(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getarticlefillcontent" tHEn
e = gETaRTiCLeFIlLCoNTeNT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getfilepathname" tHEn
e = gETfILePAtHNaME(sTRdQ(e))
eLSeIF j = "getextension" tHEn
e = gETeXTeNSiON(sTRdQ(e))
eLSeIF j = "removefiledir" tHEn
e = rEMoVEfILeDIr(sTRdQ(e))
eLSeIF j = "basename" tHEn
e = bASeNAmE(sTRdQ(e))
eLSeIF j = "getfileextname" tHEn
e = gETfILeEXtNAmE(sTRdQ(e))
eLSeIF j = "handlefilepatharray" tHEn
e = hANdLEfILePAtHArRAy(sTRdQ(e))
eLSeIF j = "getstrfilename" tHEn
e = gETsTRfILeNAmE(sTRdQ(e))
eLSeIF j = "getfileattr" tHEn
e = gETfILeATtR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "fileext" tHEn
e = fILeEXt(sTRdQ(e))
eLSeIF j = "getparentpath" tHEn
e = gETpAReNTpATh(sTRdQ(e))
eLSeIF j = "checkerr" tHEn
cALl cHEcKErR(sTRdQ(e))
eLSeIF j = "strtotruefalse" tHEn
e = sTRtOTrUEfALsE(sTRdQ(e))
eLSeIF j = "strtruefalsetoint" tHEn
e = sTRtRUeFAlSEtOInT(sTRdQ(e))
eLSeIF j = "checkvbcrlf" tHEn
e = cHEcKVbCRlF(sTRdQ(e))
eLSeIF j = "checkbr" tHEn
e = cHEcKBr(sTRdQ(e))
eLSeIF j = "isparity" tHEn
e = iSPaRItY(sTRdQ(e))
eLSeIF j = "checkeval" tHEn
e = cHEcKEvAL(sTRdQ(e))
eLSeIF j = "replace_sqltext" tHEn
e = rEPlACe_SqLTeXT(sTRdQ(e))
eLSeIF j = "chkpost" tHEn
e = cHKpOSt()
eLSeIF j = "ismail" tHEn
e = iSMaIL(sTRdQ(e))
eLSeIF j = "isvalidemail" tHEn
e = iSVaLIdEMaIL(sTRdQ(e))
eLSeIF j = "iscode" tHEn
e = iSCoDE(sTRdQ(e))
eLSeIF j = "checknumber" tHEn
e = cHEcKNuMBeR(sTRdQ(e))
eLSeIF j = "isnumber" tHEn
e = iSNuMBeR(sTRdQ(e))
eLSeIF j = "checkabc" tHEn
e = cHEcKAbC(sTRdQ(e))
eLSeIF j = "getlen" tHEn
e = gETlEN(sTRdQ(e))
eLSeIF j = "checktime" tHEn
e = cHEcKTiME(sTRdQ(e))
eLSeIF j = "isnul" tHEn
e = iSNuL(sTRdQ(e))
eLSeIF j = "foundinarr" tHEn
e = fOUnDInARr(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "showhtmlcode" tHEn
e = sHOwHTmLCoDE(sTRdQ(e))
eLSeIF j = "showhtml" tHEn
e = sHOwHTmL(sTRdQ(e))
eLSeIF j = "unhtmlcode" tHEn
e = uNHtMLcODe(sTRdQ(e))
eLSeIF j = "echohtml" tHEn
e = eCHoHTmL(sTRdQ(e))
eLSeIF j = "errortext" tHEn
e = eRRoRTeXT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "testhtml" tHEn
cALl tEStHTmL()
eLSeIF j = "htmldecode" tHEn
e = hTMlDEcODe(sTRdQ(e))
eLSeIF j = "htmlencode" tHEn
e = hTMlENcODe(sTRdQ(e))
eLSeIF j = "htmlfilter" tHEn
e = hTMlFIlTEr(sTRdQ(e))
eLSeIF j = "regreplace" tHEn
e = rEGrEPlACe(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "easp_replace" tHEn
e = eASp_RePLaCE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handlehtmllabelclose" tHEn
e = hANdLEhTMlLAbELcLOsE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "handleimgclose" tHEn
e = hANdLEiMGcLOsE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlebrclose" tHEn
e = hANdLEbRClOSe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlehrclose" tHEn
e = hANdLEhRClOSe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handleclosehtml" tHEn
e = hANdLEcLOsEHtML(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "htmllabeltoclean" tHEn
e = hTMlLAbELtOClEAn(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "addtooraddhttpurl" tHEn
e = aDDtOOrADdHTtPUrL(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "removeblanklines" tHEn
e = rEMoVEbLAnKLiNEs(sTRdQ(e))
eLSeIF j = "removeblanklines_test1" tHEn
e = rEMoVEbLAnKLiNEs_TeST1(sTRdQ(e))
eLSeIF j = "checkcode" tHEn
e = cHEcKCoDE(sTRdQ(e))
eLSeIF j = "seniorcheckcode" tHEn
e = sENiORcHEcKCoDE(sTRdQ(e))
eLSeIF j = "readfile" tHEn
e = rEAdFIlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getstext" tHEn
e = gETsTExT(sTRdQ(e))
eLSeIF j = "writetofile" tHEn
e = wRItEToFIlE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getugtext" tHEn
e = gETuGTeXT(sTRdQ(e))
eLSeIF j = "checkcontentcharset" tHEn
e = cHEcKCoNTeNTcHArSEt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checkfilecode" tHEn
e = cHEcKFiLEcODe(sTRdQ(e))
eLSeIF j = "getfilebinarycontent" tHEn
e = gETfILeBInARyCOnTEnT(sTRdQ(e))
eLSeIF j = "binaryreadfile" tHEn
e = bINaRYrEAdFIlE(sTRdQ(e))
eLSeIF j = "readbinary" tHEn
e = rEAdBInARy(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "decsavebinary" tHEn
e = dECsAVeBInARy(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "writebinary" tHEn
cALl wRItEBiNArY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getfilecharset" tHEn
e = gETfILeCHaRSeT(sTRdQ(e))
eLSeIF j = "bintohex" tHEn
e = bINtOHeX(sTRdQ(e))
eLSeIF j = "asphelptip" tHEn
e = aSPhELpTIp(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlewrite" tHEn
e = hANdLEwRItE(sTRdQ(e))
eLSeIF j = "jiantitabfanti" tHEn
e = jIAnTItABfANtI(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "jiyicireplace" tHEn
e = jIYiCIrEPlACe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "cireplace" tHEn
e = cIRePLaCE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "testgetpy" tHEn
cALl tEStGEtPY()
eLSeIF j = "pinyin" tHEn
e = pINyIN(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "pinyin2" tHEn
e = pINyIN2(sTRdQ(e))
eLSeIF j = "entocompany" tHEn
e = eNToCOmPAnY(sTRdQ(e))
eLSeIF j = "remotecontentjinghao" tHEn
e = rEMoTEcONtENtJInGHaO(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "remotearrayjinghao" tHEn
e = rEMoTEaRRaYJiNGhAO(sTRdQ(e))
eLSeIF j = "geteachstraddvalue" tHEn
e = gETeAChSTrADdVAlUE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getvalueinarrayid" tHEn
e = gETvALuEInARrAYiD(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checkvalueinarray" tHEn
e = cHEcKVaLUeINaRRaY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deleterepeatarray" tHEn
e = dELeTErEPeATaRRaY(sTRdQ(e))
eLSeIF j = "deleterepeatcontent" tHEn
e = dELeTErEPeATcONtENt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getarraycount" tHEn
e = gETaRRaYCoUNt(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "randomshow" tHEn
e = rANdOMsHOw(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "arrayrandomshow" tHEn
e = aRRaYRaNDoMShOW(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "printarray" tHEn
cALl pRInTArRAy(sTRdQ(e))
eLSeIF j = "echoarray" tHEn
cALl eCHoARrAY(sTRdQ(e))
eLSeIF j = "str_shuffle" tHEn
e = sTR_SHuFFlE(sTRdQ(e))
eLSeIF j = "characterupset" tHEn
e = cHArACtERuPSeT(sTRdQ(e))
eLSeIF j = "str_split" tHEn
e = sTR_SPlIT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "removenullvaluearray" tHEn
e = rEMoVEnULlVAlUEaRRaY(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "removerepeatvaluearray" tHEn
e = rEMoVErEPeATvALuEArRAy(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlearray" tHEn
e = hANdLEaRRaY(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "testarraydata" tHEn
e = tEStARrAYdATa()
eLSeIF j = "selectsort" tHEn
e = sELeCTsORt(sTRdQ(e))
eLSeIF j = "quicksort" tHEn
e = qUIcKSoRT(sTRdQ(e))
eLSeIF j = "bubblesort" tHEn
e = bUBbLEsORt(sTRdQ(e))
eLSeIF j = "insertsort" tHEn
e = iNSeRTsORt(sTRdQ(e))
eLSeIF j = "requicksort" tHEn
e = rEQuICkSOrT(sTRdQ(e))
eLSeIF j = "arrayreverse" tHEn
e = aRRaYReVErSE()
eLSeIF j = "responsearray" tHEn
cALl rESpONsEArRAy(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "max" tHEn
e = mAX(sTRdQ(e))
eLSeIF j = "min" tHEn
e = mIN(sTRdQ(e))
eLSeIF j = "testtwodimensionalarray" tHEn
e = tEStTWoDImENsIOnALaRRaY()
eLSeIF j = "handlesplitarray" tHEn
e = hANdLEsPLiTArRAy(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "twodimensionalarrayasc" tHEn
e = tWOdIMeNSiONaLArRAyASc(sTRdQ(e))
eLSeIF j = "twodimensionalarraydesc" tHEn
e = tWOdIMeNSiONaLArRAyDEsC(sTRdQ(e))
eLSeIF j = "csscompression" tHEn
e = cSScOMpREsSIoN(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "deletecssnote" tHEn
e = dELeTEcSSnOTe(sTRdQ(e))
eLSeIF j = "uncsscompression" tHEn
e = uNCsSCoMPrESsIOn(sTRdQ(e))
eLSeIF j = "trimvbcrlf" tHEn
e = tRImVBcRLf(sTRdQ(e))
eLSeIF j = "phptrim" tHEn
e = pHPtRIm(sTRdQ(e))
eLSeIF j = "ltrimvbcrlf" tHEn
e = lTRiMVbCRlF(sTRdQ(e))
eLSeIF j = "rtrimvbcrlf" tHEn
e = rTRiMVbCRlF(sTRdQ(e))
eLSeIF j = "trimvbtab" tHEn
e = tRImVBtAB(sTRdQ(e))
eLSeIF j = "ltrimvbtab" tHEn
e = lTRiMVbTAb(sTRdQ(e))
eLSeIF j = "rtrimvbtab" tHEn
e = rTRiMVbTAb(sTRdQ(e))
eLSeIF j = "gethtmlcssstyle" tHEn
e = gEThTMlCSsSTyLE(sTRdQ(e))
eLSeIF j = "handlecleancss" tHEn
e = hANdLEcLEaNCsS(sTRdQ(e))
eLSeIF j = "removeexcessrow" tHEn
e = rEMoVEeXCeSSrOW(sTRdQ(e))
eLSeIF j = "cssaddtostyle" tHEn
e = cSSaDDtOStYLe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "checkcssstyle" tHEn
e = cHEcKCsSStYLe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "cssstyleaddtoparam" tHEn
e = cSSsTYlEAdDToPArAM(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "findcssstyle" tHEn
e = fINdCSsSTyLE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlecutcsscode" tHEn
e = hANdLEcUTcSScODe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlecutdivcode" tHEn
e = hANdLEcUTdIVcODe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "gethtmlbackgroundimglist" tHEn
e = gEThTMlBAcKGrOUnDImGLiST(sTRdQ(e))
eLSeIF j = "gethandlewebhtmllink" tHEn
e = gEThANdLEwEBhTMlLInK(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getcsslisturllist" tHEn
e = gETcSSlIStURlLIsT(sTRdQ(e))
eLSeIF j = "handlereadcsscontent" tHEn
e = hANdLErEAdCSsCOnTEnT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "handlecsspx" tHEn
e = hANdLEcSSpX(sTRdQ(e))
eLSeIF j = "handlehtmlstyle" tHEn
e = hANdLEhTMlSTyLE(sTRdQ(e))
eLSeIF j = "utf2gb" tHEn
e = uTF2GB(sTRdQ(e))
eLSeIF j = "checkutftogb2312" tHEn
e = cHEcKUtFToGB2312(sTRdQ(e))
eLSeIF j = "convchinese" tHEn
e = cONvCHiNEsE(sTRdQ(e))
eLSeIF j = "utf8_urlencoding" tHEn
e = uTF8_UrLEnCOdINg(sTRdQ(e))
eLSeIF j = "toutf8" tHEn
e = tOUtF8(sTRdQ(e))
eLSeIF j = "chinese2unicode" tHEn
e = cHInESe2UnICoDE(sTRdQ(e))
eLSeIF j = "isvalidhex" tHEn
e = iSVaLIdHEx(sTRdQ(e))
eLSeIF j = "escape" tHEn
e = eSCaPE(sTRdQ(e))
eLSeIF j = "unescape" tHEn
e = uNEsCApE(sTRdQ(e))
eLSeIF j = "chinesetounicode" tHEn
e = cHInESeTOuNIcODe(sTRdQ(e))
eLSeIF j = "unicodetochinese" tHEn
e = uNIcODeTOcHInESe(sTRdQ(e))
eLSeIF j = "urlencode" tHEn
e = uRLeNCoDE(sTRdQ(e))
eLSeIF j = "urldecode" tHEn
e = uRLdECoDE(sTRdQ(e))
eLSeIF j = "gbtoutf8" tHEn
e = gBToUTf8(sTRdQ(e))
eLSeIF j = "encdecurl" tHEn
e = eNCdECuRL(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "encurl" tHEn
e = eNCuRL(sTRdQ(e))
eLSeIF j = "decurl" tHEn
e = dECuRL(sTRdQ(e))
eLSeIF j = "infocolor" tHEn
e = iNFoCOlOR(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "imgerror" tHEn
e = iMGeRRoR()
eLSeIF j = "targetstr" tHEn
e = tARgETsTR(sTRdQ(e))
eLSeIF j = "atarget" tHEn
e = aTArGEt(sTRdQ(e))
eLSeIF j = "atitle" tHEn
e = aTItLE(sTRdQ(e))
eLSeIF j = "imgalt" tHEn
e = iMGaLT(sTRdQ(e))
eLSeIF j = "imgtitlealt" tHEn
e = iMGtITlEAlT(sTRdQ(e))
eLSeIF j = "arel" tHEn
e = aREl(sTRdQ(e))
eLSeIF j = "styleclass" tHEn
e = sTYlEClASs(sTRdQ(e))
eLSeIF j = "textfontb" tHEn
e = tEXtFOnTB(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "textfontcolor" tHEn
e = tEXtFOnTCoLOr(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "fontcolorfontb" tHEn
e = fONtCOlORfONtB(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getdefaultfilename" tHEn
e = gETdEFaULtFIlENaME()
eLSeIF j = "ahref" tHEn
e = aHReF(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "imgsrc" tHEn
e = iMGsRC(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "selecttarget" tHEn
e = sELeCTtARgET(sTRdQ(e))
eLSeIF j = "selectfontcolor" tHEn
e = sELeCTfONtCOlOR(sTRdQ(e))
eLSeIF j = "selectsex" tHEn
e = sELeCTsEX(sTRdQ(e))
eLSeIF j = "selectsessioncookies" tHEn
e = sELeCTsESsIOnCOoKIeS(sTRdQ(e))
eLSeIF j = "showselectlist" tHEn
e = sHOwSElECtLIsT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "showarticleliststyle" tHEn
e = sHOwARtIClELiSTsTYlE(sTRdQ(e))
eLSeIF j = "showarticleinfostyle" tHEn
e = sHOwARtIClEInFOsTYlE(sTRdQ(e))
eLSeIF j = "handlearticleliststyleorinfostyle" tHEn
e = hANdLEaRTiCLeLIsTStYLeORiNFoSTyLE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "showwebmoduleskins" tHEn
e = sHOwWEbMOdULeSKiNS(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "showradiolist" tHEn
e = sHOwRAdIOlISt(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputcheckbox" tHEn
e = iNPuTChECkBOx(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "inputtext" tHEn
e = iNPuTTeXT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputtext2" tHEn
e = iNPuTTeXT2(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "inputlefttext" tHEn
e = iNPuTLeFTtEXt(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputlefttexthelptextright" tHEn
e = iNPuTLeFTtEXtHElPTeXTrIGhT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputlefttextcontent" tHEn
e = iNPuTLeFTtEXtCOnTEnT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputrighttextcontent" tHEn
e = iNPuTRiGHtTExTCoNTeNT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handleinputleftrighttextcontent" tHEn
e = hANdLEiNPuTLeFTrIGhTTeXTcONtENt(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "inputleftpasstext" tHEn
e = iNPuTLeFTpASsTExT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputleftpasstextcontent" tHEn
e = iNPuTLeFTpASsTExTCoNTeNT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "inputhiddentext" tHEn
e = iNPuTHiDDeNTeXT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "inputtextarea" tHEn
e = iNPuTTeXTaREa(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "inputhiddentextarea" tHEn
e = iNPuTHiDDeNTeXTaREa(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "handleinputhiddentextarea" tHEn
e = hANdLEiNPuTHiDDeNTeXTaREa(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)))
eLSeIF j = "showselectdirlist" tHEn
e = sHOwSElECtDIrLIsT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "inputdisabled" tHEn
e = iNPuTDiSAbLEd(sTRdQ(e))
eLSeIF j = "inputaddalt" tHEn
e = iNPuTAdDAlT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "webtitle_inputtextarea" tHEn
e = wEBtITlE_iNPuTTeXTaREa(sTRdQ(e))
eLSeIF j = "webkeywords_inputtext" tHEn
e = wEBkEYwORdS_iNPuTTeXT(sTRdQ(e))
eLSeIF j = "webdescription_inputtextarea" tHEn
e = wEBdEScRIpTIoN_iNPuTTeXTaREa(sTRdQ(e))
eLSeIF j = "foldername_inputtext" tHEn
e = fOLdERnAMe_InPUtTExT(sTRdQ(e))
eLSeIF j = "filename_inputtext" tHEn
e = fILeNAmE_iNPuTTeXT(sTRdQ(e))
eLSeIF j = "templatepath_inputtext" tHEn
e = tEMpLAtEPaTH_INpUTtEXt(sTRdQ(e))
eLSeIF j = "clickpinyinhtmlstr" tHEn
e = cLIcKPiNYiNHtMLsTR(sTRdQ(e))
eLSeIF j = "showfontcolorfontb" tHEn
e = sHOwFOnTCoLOrFOnTB(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "showsort" tHEn
e = sHOwSOrT(sTRdQ(e))
eLSeIF j = "showwebnavtype" tHEn
e = sHOwWEbNAvTYpE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)),sTRdQ(h(5)))
eLSeIF j = "showonhtml" tHEn
e = sHOwONhTMl(sTRdQ(e))
eLSeIF j = "showthrough" tHEn
e = sHOwTHrOUgH(sTRdQ(e))
eLSeIF j = "showrecommend" tHEn
e = sHOwREcOMmENd(sTRdQ(e))
eLSeIF j = "showonoffimg" tHEn
e = sHOwONoFFiMG(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "newshowonoffimg" tHEn
e = nEWsHOwONoFFiMG(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "controldialogcss" tHEn
e = cONtROlDIaLOgCSs()
eLSeIF j = "htmlformatting" tHEn
e = hTMlFOrMAtTInG(sTRdQ(e))
eLSeIF j = "handlehtmlformatting" tHEn
e = hANdLEhTMlFOrMAtTInG(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "checkhtmlformatting" tHEn
e = cHEcKHtMLfORmATtINg(sTRdQ(e))
eLSeIF j = "newreplacevalueparam" tHEn
e = nEWrEPlACeVAlUEpARaM(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "newrparam" tHEn
e = nEWrPArAM(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getcontentallrunstr" tHEn
e = gETcONtENtALlRUnSTr(sTRdQ(e))
eLSeIF j = "getcontentrunstr" tHEn
e = gETcONtENtRUnSTr(sTRdQ(e))
eLSeIF j = "checkcontentrunstr" tHEn
e = cHEcKCoNTeNTrUNsTR(sTRdQ(e))
eLSeIF j = "handledoublequotation" tHEn
e = hANdLEdOUbLEqUOtATiON(sTRdQ(e))
eLSeIF j = "strdq" tHEn
e = sTRdQ(sTRdQ(e))
eLSeIF j = "handletoarray" tHEn
e = hANdLEtOArRAy(sTRdQ(e))
eLSeIF j = "handlecontentcode" tHEn
e = hANdLEcONtENtCOdE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handleinmodule" tHEn
e = hANdLEiNMoDUlE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "clearrparam" tHEn
e = cLEaRRpARaM(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "atrparam" tHEn
e = aTRpARaM(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "rparam" tHEn
e = rPArAM(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "handlerparam" tHEn
e = hANdLErPArAM(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getconfigblock" tHEn
e = gETcONfIGbLOcK(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getconfigblock2" tHEn
e = gETcONfIGbLOcK2(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getconfigblock3" tHEn
e = gETcONfIGbLOcK3(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getcutconfigblock" tHEn
e = gETcUTcONfIGbLOcK(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "getconfigcontentblock" tHEn
e = gETcONfIGcONtENtBLoCK(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getconfigfileblock" tHEn
e = gETcONfIGfILeBLoCK(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "setconfigfileblock" tHEn
e = sETcONfIGfILeBLoCK(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "delconfigblock" tHEn
e = dELcONfIGbLOcK(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "delconfigblock2" tHEn
e = dELcONfIGbLOcK2(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "delconfigblock3" tHEn
e = dELcONfIGbLOcK3(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "delcutconfigblock" tHEn
e = dELcUTcONfIGbLOcK(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "getfileparamvalue" tHEn
e = gETfILePArAMvALuE(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "setfileparamvalue" tHEn
e = sETfILePArAMvALuE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "handlegetsetfileparamevalue" tHEn
e = hANdLEgETsETfILePArAMeVAlUE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "setrparam" tHEn
e = sETrPArAM(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "addreplacerparam" tHEn
e = aDDrEPlACeRPaRAm(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "deletestrcut" tHEn
e = dELeTEsTRcUT(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "replacecontentmodule" tHEn
e = rEPlACeCOnTEnTMoDUlE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)),sTRdQ(h(4)))
eLSeIF j = "replacecontentrowmodule" tHEn
e = rEPlACeCOnTEnTRoWMoDUlE(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "handleconfigfile" tHEn
cALl hANdLEcONfIGfILe(sTRdQ(e))
eLSeIF j = "getrparam" tHEn
e = gETrPArAM(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getdefaultvalue" tHEn
e = gETdEFaULtVAlUE(sTRdQ(e))
eLSeIF j = "modulefindcontent" tHEn
e = mODuLEfINdCOnTEnT(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "batchfindfunction" tHEn
e = bATcHFiNDfUNcTIoN(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getfindfilefunction" tHEn
e = gETfINdFIlEFuNCtIOn(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "getaspcode" tHEn
e = gETaSPcODe(sTRdQ(e))
eLSeIF j = "handlegetaspcode" tHEn
e = hANdLEgETaSPcODe(sTRdQ(h(0)),sTRdQ(h(1)))
eLSeIF j = "delaspnote" tHEn
e = dELaSPnOTe(sTRdQ(e))
eLSeIF j = "findaspfunction" tHEn
e = fINdASpFUnCTiON(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)),sTRdQ(h(3)))
eLSeIF j = "firstletteruppercase" tHEn
e = fIRsTLeTTeRUpPErCAsE(sTRdQ(e))
eLSeIF j = "contentlushow" tHEn
e = cONtENtLUsHOw(sTRdQ(e))
eLSeIF j = "asptovb" tHEn
e = aSPtOVb(sTRdQ(e))
eLSeIF j = "asptovbnet" tHEn
e = aSPtOVbNEt(sTRdQ(e))
eLSeIF j = "dimadddefaultvalue" tHEn
e = dIMaDDdEFaULtVAlUE(sTRdQ(e))
eLSeIF j = "functionparamtonet" tHEn
e = fUNcTIoNPaRAmTOnET(sTRdQ(e))
eLSeIF j = "getbeforenstr" tHEn
e = gETbEFoREnSTr(sTRdQ(h(0)),sTRdQ(h(1)),sTRdQ(h(2)))
eLSeIF j = "getstrdim" tHEn
e = gETsTRdIM(sTRdQ(e))
eLSeIF j = "getfunctionstrdim" tHEn
e = gETfUNcTIoNStRDiM(sTRdQ(e))
eLSeIF j = "getrandcolor" tHEn
e = gETrANdCOlOR()
eLSeIF j = "now" tHEn
e = nOW()
eLSeIF j = "date" tHEn
e = dATe
eLSeIF j = "len" tHEn
e = lEN(e)
eLSeIF j = "lcase" tHEn
e = lCAsE(e)
eLSeIF j = "ucase" tHEn
e = uCAsE(e)
eLSeIF j = "ltrim" tHEn
e = lTRiM(e)
eLSeIF j = "rtrim" tHEn
e = rTRiM(e)
eLSeIF j = "trim" tHEn
e = tRIm(e)
eLSeIF j = "left" tHEn
h = sPLiT(e & ",1", ",")
e = lEFt(tRIm(h(0)), tRIm(h(1)))
eLSeIF j = "right" tHEn
e = rIGhT(tRIm(h(0)), tRIm(h(1)))
eLSeIF j = "mid" tHEn
h = sPLiT(e & ",99999", ",")
iF uBOuND(h) >= 2 tHEn
e = mID(tRIm(h(0)), tRIm(h(1)), tRIm(h(2)))
eLSe
e = mID(tRIm(h(0)), tRIm(h(1)))
eND iF
eND iF
a = rEPlACe(a, f, e)
hANdLEcONtENtCOdE = a
eND fUNcTIoN
fUNcTIoN hANdLEiNMoDUlE(a, b)
b = lCAsE(cSTr(b))
iF b = "1" oR b = "start" tHEn
a = rEPlACe(a, "\'", "\|*|\")
a = rEPlACe(a, "\=", "\|&|\")
eLSeIF b = "2" oR b = "end" tHEn
a = rEPlACe(a, "\|*|\", "'")
a = rEPlACe(a, "\$", "$")
a = rEPlACe(a, "\}", "}")
a = rEPlACe(a, "\|&|\", "=")
eND iF
hANdLEiNMoDUlE = a
eND fUNcTIoN
fUNcTIoN cLEaRRpARaM(bYVaL a, bYVaL b)
dIM c
a = rEPlACe(a, "\'", "")
c = rPArAM(a, b)
cLEaRRpARaM = c
eND fUNcTIoN
fUNcTIoN aTRpARaM(bYVaL a, bYVaL b)
aTRpARaM = rPArAM(a, b)
iF iNStR(aTRpARaM, "{$") > 0 aND iNStR(aTRpARaM, "$}") > 0 tHEn
aTRpARaM = hANdLEtEMpLAtEAcTIoN(aTRpARaM, fALsE)
eND iF
eND fUNcTIoN
fUNcTIoN rPArAM(bYVaL a, bYVaL b)
dIM c
c = hANdLErPArAM(a, b, "'")
iF c = "" tHEn
c = hANdLErPArAM(a, b, """")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, b, "")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, lCAsE(b), "'")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, lCAsE(b), """")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, lCAsE(b), "")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, uCAsE(b), "'")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, uCAsE(b), """")
eND iF
iF c = "" tHEn
c = hANdLErPArAM(a, uCAsE(b), "")
eND iF
iF c = "[#空*值_#]" tHEn c = ""
rPArAM = c
eND fUNcTIoN
fUNcTIoN hANdLErPArAM(bYVaL a, bYVaL b, bYVaL c)
dIM d, e, f, g
f = fALsE
e = iIF(c <> "", c, " ")
a = vBCrLF & " " & a
d = " " & b
iF iNStR(a, d & "=" & c) = fALsE aND f = fALsE tHEn
d = "'" & b
eLSe
f = tRUe
eND iF
iF iNStR(a, d & "=" & c) = fALsE aND f = fALsE tHEn
d = """" & b
eLSe
f = tRUe
eND iF
iF iNStR(a, d & "=" & c) = fALsE aND f = fALsE tHEn
d = vBTaB & b
eLSe
f = tRUe
eND iF
iF iNStR(a, d & "=" & c) = fALsE aND f = fALsE tHEn
d = vBCrLF & b
eLSe
f = tRUe
eND iF
iF iNStR(a, d & "=" & c) > 0 aND iNStR(a, e) > 0 tHEn
g = sTRcUT(a, d & "=" & c, e, 2)
g = hANdLEiNMoDUlE(g, "end")
iF g = "" tHEn
g = "[#空*值_#]"
eND iF
iF iNStR(g, "{$") > 0 aND iNStR(g, "$}") > 0 tHEn
eND iF
eND iF
hANdLErPArAM=g
eND fUNcTIoN
fUNcTIoN gETcONfIGbLOcK(a, b)
gETcONfIGbLOcK = gETcUTcONfIGbLOcK(a, b, "#", "#")
eND fUNcTIoN
fUNcTIoN gETcONfIGbLOcK2(a, b)
gETcONfIGbLOcK2 = gETcUTcONfIGbLOcK(a, b, "[#", "#]")
eND fUNcTIoN
fUNcTIoN gETcONfIGbLOcK3(a, b)
gETcONfIGbLOcK3 = gETcUTcONfIGbLOcK(a, b, "[$", "$]")
eND fUNcTIoN
fUNcTIoN gETcUTcONfIGbLOcK(a, b, c, d)
dIM e, f
e = c & b & d
f = c & b & d
iF iNStR(a, e & " start") > 0 tHEn
e = e & " start"
eLSe
e = e & " Start"
eND iF
iF iNStR(a, f & " end") > 0 tHEn
f = f & " end"
eLSe
f = f & " End"
eND iF
iF iNStR(a, e) > 0 aND iNStR(a, f) > 0 tHEn
gETcUTcONfIGbLOcK = sTRcUT(a, e, f, 2)
eND iF
eND fUNcTIoN
fUNcTIoN gETcONfIGcONtENtBLoCK(bYVaL a, b)
gETcONfIGcONtENtBLoCK = gETcUTcONfIGbLOcK(a, b, "", "")
eND fUNcTIoN
fUNcTIoN gETcONfIGfILeBLoCK(bYVaL a, b)
dIM c, d, e, f, g
c = gETfTExT(a)
f = b & " start"
g = b & " end"
e = f & "" & g
iF iNStR(c, f) > 0 aND iNStR(c, g) > 0 tHEn
d = sTRcUT(c, f, g, 2)
gETcONfIGfILeBLoCK = d
eLSe
cALl cREaTEfILe(a, c & e)
eND iF
eND fUNcTIoN
fUNcTIoN sETcONfIGfILeBLoCK(bYVaL a, bYVaL b, c)
dIM d, e, f, g, h
d = gETfTExT(a)
g = c & " start"
h = c & " end"
f = g & b & h
iF iNStR(d, g) > 0 aND iNStR(d, h) > 0 tHEn
e = sTRcUT(d, g, h, 1)
d = rEPlACe(d, e, f)
cALl cREaTEfILe(a, d)
eLSe
cALl cREaTEfILe(a, d & f)
eND iF
eND fUNcTIoN
fUNcTIoN dELcONfIGbLOcK(a, b)
dELcONfIGbLOcK = dELcUTcONfIGbLOcK(a, b, "#", "#")
eND fUNcTIoN
fUNcTIoN dELcONfIGbLOcK2(a, b)
dELcONfIGbLOcK2 = dELcUTcONfIGbLOcK(a, b, "[#", "#]")
eND fUNcTIoN
fUNcTIoN dELcONfIGbLOcK3(a, b)
dELcONfIGbLOcK3 = dELcUTcONfIGbLOcK(a, b, "[$", "$]")
eND fUNcTIoN
fUNcTIoN dELcUTcONfIGbLOcK(a, b, c, d)
dIM e, f, g
e = c & b & d & " start"
f = c & b & d & " end"
iF iNStR(a, e) > 0 aND iNStR(a, f) > 0 tHEn
g = sTRcUT(a, e, f, 1)
a = rEPlACe(a, g, "")
eND iF
dELcUTcONfIGbLOcK = a
eND fUNcTIoN
fUNcTIoN gETfILePArAMvALuE(a, b)
gETfILePArAMvALuE = hANdLEgETsETfILePArAMeVAlUE(a, b, "", "获得")
eND fUNcTIoN
fUNcTIoN sETfILePArAMvALuE(a, b, c)
sETfILePArAMvALuE = hANdLEgETsETfILePArAMeVAlUE(a, b, c, "设置")
eND fUNcTIoN
fUNcTIoN hANdLEgETsETfILePArAMeVAlUE(a, b, c, d)
dIM e, f, g, h, i
iF cHEcKFiLE(a) = fALsE tHEn
cALl cREaTEfILe(a, "")
eND iF
iF cHEcKFiLE(a) = fALsE tHEn eXIt fUNcTIoN
e = tRImVBcRLf(gETfTExT(a))
f = vBCrLF & b & "=" : g = vBCrLF
i = vBCrLF & b & "=" & c & vBCrLF
iF iNStR(vBCrLF & e, f) > 0 aND iNStR(e & vBCrLF, g) > 0 tHEn
h = sTRcUT(vBCrLF & e & vBCrLF, f, g, 2)
iF d = "获得" tHEn
hANdLEgETsETfILePArAMeVAlUE = h
eXIt fUNcTIoN
eND iF
h = f & h & g
e = rEPlACe(vBCrLF & e & vBCrLF, h, i)
cALl cREaTEfILe(a, e)
eLSe
cALl cREaTEfILe(a, e & vBCrLF & tRImVBcRLf(i))
eND iF
eND fUNcTIoN
fUNcTIoN sETrPArAM(a, b, c, d)
dIM e, f, g, h
e = pHPtRIm(gETfTExT(a))
f = b & "='" : g = "'"
iF iNStR(e, f) > 0 aND iNStR(e, g) > 0 tHEn
h = sTRcUT(e, f, g, 2)
e = rEPlACe(e, f & h & g, f & c & g)
cALl cREaTEfILe(a, e)
eLSeIF tRIm(d) = "1" tHEn
cALl cREaTEaDDfILe(a, f & c & g)
eND iF
eND fUNcTIoN
fUNcTIoN aDDrEPlACeRPaRAm(bYVaL a, b, c, bYVaL d)
dIM e
d = b & d & c
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
e = sTRcUT(a, b, c, 1)
a = rEPlACe(a, e, d)
eLSe
a = a & vBCrLF & d
eND iF
aDDrEPlACeRPaRAm = a
eND fUNcTIoN
fUNcTIoN dELeTEsTRcUT(bYVaL a, bYVaL b, bYVaL c, bYVaL d, e)
dIM f, g
iF e = 0 tHEn
e = 99
eND iF
fOR f = 0 tO e
g = gETsTRcUT(a, b, c, 1)
iF g <> "" tHEn
a = rEPlACe(a, g, "")
eLSe
eXIt fOR
eND iF
nEXt
dELeTEsTRcUT = a
eND fUNcTIoN
fUNcTIoN rEPlACeCOnTEnTMoDUlE(bYVaL a, b, c, d, e)
dIM f, g, h, i, j, k, l, m, n, o, p, q
iF iNStR(a, b) = fALsE aND iNStR(a, c) = fALsE tHEn
rEPlACeCOnTEnTMoDUlE = a
eXIt fUNcTIoN
eND iF
j = "$Array$"
fOR i = 1 tO 99
iF iNStR(a, b) > 0 aND iNStR(a, c) > 0 tHEn
h = sTRcUT(a, b, c, 1) : p = h
h = mID(h, lEN(b) + 1, lEN(h) - lEN(b) - lEN(c))
l = gETeAChSTrADdVAlUE(b, "|*|")
iF iNStR(j & k & j, j & l & j) = fALsE tHEn
iF k <> "" tHEn k = k & j
k = k & l
iF n <> "" tHEn n = n & j
n = n & b
eND iF
m = gETeAChSTrADdVAlUE(c, "|*|")
iF iNStR(j & k & j, j & m & j) = fALsE tHEn
iF k <> "" tHEn k = k & j
k = k & m
iF n <> "" tHEn n = n & j
n = n & c
eND iF
iF e = "追加在前" tHEn
q = l & d & h & m
eLSeIF e = "追加在后" oR e = "追加" tHEn
q = l & h & d & m
eLSeIF e = "外部追加在前" tHEn
q = d & l & h & m
eLSeIF e = "外部追加在后" oR e = "外部追加" tHEn
q = l & h & m & d
eLSe
q = d
eND iF
a = rEPlACe(a, p, q)
eLSe
eXIt fOR
eND iF
nEXt
f = sPLiT(k, j)
g = sPLiT(n, j)
fOR i = 0 tO uBOuND(f)
o = f(i)
d = g(i)
a = rEPlACe(a, o, d)
nEXt
rEPlACeCOnTEnTMoDUlE = a
eND fUNcTIoN
fUNcTIoN rEPlACeCOnTEnTRoWMoDUlE(a, b, c, d)
dIM e, f, g, h, i, j, k, l, m
h = "$Array$"
fOR g = 1 tO 99
iF iNStR(a, b) > 0 tHEn
m = gETeAChSTrADdVAlUE(b, "|*|")
iF iNStR(h & i & h, h & m & h) = fALsE tHEn
iF i <> "" tHEn i = i & h
i = i & m
iF j <> "" tHEn j = j & h
j = j & b
eND iF
iF d = "追加在前" tHEn
l = c & m
eLSeIF d = "追加在后" oR d = "追加" tHEn
l = m & c
eLSe
l = c
eND iF
a = rEPlACe(a, b, l)
eLSe
eXIt fOR
eND iF
nEXt
e = sPLiT(i, h)
f = sPLiT(j, h)
fOR g = 0 tO uBOuND(e)
k = e(g)
c = f(g)
a = rEPlACe(a, k, c)
nEXt
rEPlACeCOnTEnTRoWMoDUlE = a
eND fUNcTIoN
sUB hANdLEcONfIGfILe(a)
dIM b
iF cHEcKFiLE(a) = fALsE tHEn
b = "#Help帮助# start" & vBCrLF & "默认帮助内容" & vBCrLF & "#Help帮助# end"
cALl cREaTEfILe(a, b)
eND iF
eND sUB
fUNcTIoN gETrPArAM(bYVaL a, bYVaL b)
dIM c, d, e, f, g, h, i, j
a = " " & a & " "
c = lCAsE(a)
b = lCAsE(b)
d = mID(a, iNStR(c, b) + lEN(b))
h = fALsE
j = fALsE
fOR e = 1 tO lEN(d)
f = mID(d, e, 1)
iF h = tRUe tHEn
iF f <> "" tHEn
iF i = "" tHEn
i = f
eLSe
iF i = """" oR i = "'" tHEn
iF f = i tHEn
j = tRUe
eXIt fOR
eND iF
eLSeIF f = " " aND g = "" tHEn
eLSeIF f = " " oR f = "/" oR f = ">" tHEn
j = tRUe
eXIt fOR
eND iF
iF f <> " " tHEn
g = g & f
eND iF
eND iF
eND iF
eND iF
iF f = "=" tHEn
h = tRUe
eND iF
nEXt
iF j = fALsE tHEn
g = ""
eND iF
gETrPArAM = g
eND fUNcTIoN
fUNcTIoN gETdEFaULtVAlUE(a)
gETdEFaULtVAlUE = mODuLEfINdCOnTEnT(a, "default")
eND fUNcTIoN
sUB aDDmODuLErEPlACeARrAY(a,b)
dIM c
fOR c=1 tO uBOuND(mODuLErEPlACeARrAY)-1
iF mODuLErEPlACeARrAY(c,0)="" tHEn
mODuLErEPlACeARrAY(c,0)=a
mODuLErEPlACeARrAY(0,c)=b
eXIt sUB
eND iF
nEXt
eND sUB
fUNcTIoN mODuLEfINdCOnTEnT(a, b)
dIM c, d, e
c = rPArAM(a, b)
d = "<!--#" & c & " start#-->"
e = "<!--#" & c & " end#-->"
iF iNStR(cODe, d) > 0 aND iNStR(cODe, e) > 0 tHEn
c = sTRcUT(cODe, d, e, 2)
eLSe
d = "<!--#" & c
e = "#-->"
iF iNStR(cODe, d) > 0 aND iNStR(cODe, e) > 0 tHEn
c = sTRcUT(cODe, d, e, 2)
eND iF
eND iF
dIM f
f = rPArAM(a, "deletedefault")
iF f = "true" tHEn
cALl aDDmODuLErEPlACeARrAY("【删除】", d & c & e)
eND iF
mODuLEfINdCOnTEnT = c
eND fUNcTIoN
%>

