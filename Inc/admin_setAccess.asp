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

'�µĽ�ȡ�ַ�20160216
Function newGetStrCut(content, title)
    Dim s 
    If InStr(content, "��/" & title & "��") > 0 Then
        s = ADSql(phptrim(getStrCut(content, "��" & title & "��", "��/" & title & "��", 0))) 
    Else
        s = ADSql(phptrim(getStrCut(content, "��" & title & "��", vbCrLf, 0))) 
    End If 
    newGetStrCut = s 
End Function 


'�������ݿ�����
Sub resetAccessData()

	call handlePower("�ָ�ģ������")						'����Ȩ�޴���
	
    Call OpenConn() 
    Dim splStr, i, s, columnname, title, nCount, webdataDir 
    webdataDir = Request("webdataDir") 
    If webdataDir <> "" Then
        If checkFolder(webdataDir) = False Then
            Call eerr("��վ����Ŀ¼�����ڣ��ָ�Ĭ������δ�ɹ�", webdataDir) 
        End If 
    Else
        webdataDir = "/Data/WebData/" 
    End If 

    Call echo("��ʾ", "�ָ��������") 
    Call rw("<hr><a href='../index.asp' target='_blank'>������ҳ</a> | <a href=""?"" target='_blank'>�����̨</a>") 

    Dim content, filePath, parentid, author, adddatetime, fileName, bodycontent, webtitle, webkeywords, webdescription, sortrank, labletitle, target 
    Dim websitebottom, webtemplate, webimages, webcss, webjs, flags, websiteurl, splxx, columntype, relatedtags, npagesize, customaurl, nofollow 
    Dim templatepath, through 
    Dim showreason, ncomputersearch, nmobliesearch, ncountsearch, ndegree           '���۱�
    Dim displaytitle, simpleintroduction, isonhtml                                  '��ҳ��
    Dim columnenname                                                                '������
    Dim smallimage, bigImage, bannerimage                                           '���±�




    '��վ����
    content = getftext(webdataDir & "/website.ini") 
    If content <> "" Then
        webtitle = newGetStrCut(content, "webtitle") 
        webkeywords = newGetStrCut(content, "webkeywords") 
        webdescription = newGetStrCut(content, "webdescription") 
        websitebottom = newGetStrCut(content, "websitebottom") 
        webtemplate = newGetStrCut(content, "webtemplate") 
        webimages = newGetStrCut(content, "webimages") 
        webcss = newGetStrCut(content, "webcss") 
        webjs = newGetStrCut(content, "webjs") 
        flags = newGetStrCut(content, "flags") 
        websiteurl = newGetStrCut(content, "websiteurl") 

        If getRecordCount(db_PREFIX & "website", "") = 0 Then
            conn.Execute("insert into " & db_PREFIX & "website(webtitle) values('����')") 
        End If 

        conn.Execute("update " & db_PREFIX & "website  set webtitle='" & webtitle & "',webkeywords='" & webkeywords & "',webdescription='" & webdescription & "',websitebottom='" & websitebottom & "',webtemplate='" & webtemplate & "',webimages='" & webimages & "',webcss='" & webcss & "',webjs='" & webjs & "',flags='" & flags & "',websiteurl='" & websiteurl & "'") 
    End If 

    '����
    conn.Execute("delete from " & db_PREFIX & "webcolumn") 
    content = getDirTxtList(webdataDir & "/webcolumn/") 
    splStr = Split(content, vbCrLf) 
    Call hr() 
    For Each filePath In splStr
        fileName = getfilename(filePath) 
        If filePath <> "" And InStr("_#", Left(fileName, 1)) = False Then
            Call echo("����", filePath) 
            content = getftext(filePath) 
            splxx = Split(content, vbCrLf & "-------------------------------") 
            For Each s In splxx
                If InStr(s, "��webtitle��") > 0 Then
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 

                    sortrank = newGetStrCut(s, "sortrank") 
                    If sortrank = "" Then sortrank = 0 
                    fileName = newGetStrCut(s, "filename") 
                    columnname = newGetStrCut(s, "columnname") 
                    columnenname = newGetStrCut(s, "columnenname") 
                    columntype = newGetStrCut(s, "columntype") 
                    flags = newGetStrCut(s, "flags") 
                    parentid = newGetStrCut(s, "parentid") 
                    parentid = phptrim(getColumnId(parentid)) 
                    labletitle = newGetStrCut(s, "labletitle") 
                    'ÿҳ��ʾ����
                    npagesize = newGetStrCut(s, "npagesize") 
                    If npagesize = "" Then npagesize = 10                                           'Ĭ�Ϸ�ҳ��Ϊ10��

                    target = newGetStrCut(s, "target") 

                    smallimage = newGetStrCut(s, "smallimage") 
                    bigImage = newGetStrCut(s, "bigImage") 
                    bannerimage = newGetStrCut(s, "bannerimage") 

                    templatepath = newGetStrCut(s, "templatepath") 


                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 
                    '�Ƿ���������html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    If isonhtml = "0" Or LCase(isonhtml) = "false" Then
                        isonhtml = 0 
                    Else
                        isonhtml = 1 
                    End If 
                    '�Ƿ�Ϊnofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    If nofollow = "1" Or LCase(nofollow) = "true" Then
                        nofollow = 1 
                    Else
                        nofollow = 0 
                    End If 


                    simpleintroduction = newGetStrCut(s, "simpleintroduction") 
                    simpleintroduction = contentTranscoding(simpleintroduction) 

                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 

                    conn.Execute("insert into " & db_PREFIX & "webcolumn (webtitle,webkeywords,webdescription,columnname,columnenname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values('" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & columnname & "','" & columnenname & "','" & columntype & "'," & sortrank & ",'" & fileName & "','" & flags & "'," & parentid & ",'" & labletitle & "','" & simpleintroduction & "','" & bodycontent & "'," & npagesize & "," & isonhtml & "," & nofollow & ",'" & target & "','" & smallimage & "','" & bigImage & "','" & bannerimage & "','" & templatepath & "')") 
                End If 
            Next 
        End If 
    Next 

    '����
    conn.Execute("delete from " & db_PREFIX & "articledetail") 
    content = getDirTxtList(webdataDir & "/articledetail/") 
    splStr = Split(content, vbCrLf) 
    Call hr() 
    For Each filePath In splStr
        fileName = getfilename(filePath) 
        If filePath <> "" And InStr("_#", Left(fileName, 1)) = False Then
            Call echo("����", filePath) 
            content = getftext(filePath) 
            splxx = Split(content, vbCrLf & "-------------------------------") 
            For Each s In splxx
                If InStr(s, "��title��") > 0 Then
                    s = s & vbCrLf 
                    parentid = newGetStrCut(s, "parentid") 
                    parentid = getColumnId(parentid) 
                    title = newGetStrCut(s, "title") 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 


                    author = newGetStrCut(s, "author") 
                    sortrank = newGetStrCut(s, "sortrank") 
                    If sortrank = "" Then sortrank = 0 
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
				
				
                    simpleintroduction = newGetStrCut(s, "simpleintroduction") 
                    simpleintroduction = contentTranscoding(simpleintroduction) 

                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 
                    '�Ƿ���������html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    If isonhtml = "0" Or LCase(isonhtml) = "false" Then
                        isonhtml = 0 
                    Else
                        isonhtml = 1 
                    End If 
                    '�Ƿ�Ϊnofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    If nofollow = "1" Or LCase(nofollow) = "true" Then
                        nofollow = 1 
                    Else
                        nofollow = 0 
                    End If 
                    conn.Execute("insert into " & db_PREFIX & "articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,simpleintroduction,bodycontent,updatetime,isonhtml,customaurl,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(" & parentid & ",'" & title & "','" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & author & "'," & sortrank & ",'" & adddatetime & "','" & fileName & "','" & flags & "','" & relatedtags & "','"& simpleintroduction &"','" & bodycontent & "','" & Now() & "'," & isonhtml & ",'" & customaurl & "'," & nofollow & ",'" & target & "','" & smallimage & "','" & bigImage & "','" & bannerimage & "','" & templatepath & "')") 
                End If 
            Next 
        End If 
    Next 

    '��ҳ
    conn.Execute("delete from " & db_PREFIX & "OnePage") 
    content = getDirTxtList(webdataDir & "/OnePage/") 
    splStr = Split(content, vbCrLf) 
    Call hr() 
    For Each filePath In splStr
        fileName = getfilename(filePath) 
        If filePath <> "" And InStr("_#", Left(fileName, 1)) = False Then
            Call echo("��ҳ", filePath) 
            content = getftext(filePath) 
            splxx = Split(content, vbCrLf & "-------------------------------") 
            For Each s In splxx
                If InStr(s, "��webkeywords��") > 0 Then
                    s = s & vbCrLf 
                    title = newGetStrCut(s, "title") 
                    displaytitle = newGetStrCut(s, "displaytitle") 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 



                    adddatetime = newGetStrCut(s, "adddatetime") 
                    fileName = newGetStrCut(s, "filename") 

                    simpleintroduction = newGetStrCut(s, "simpleintroduction") 

                    simpleintroduction = contentTranscoding(simpleintroduction) 
                    target = newGetStrCut(s, "target") 
                    templatepath = newGetStrCut(s, "templatepath") 

                    bodycontent = newGetStrCut(s, "bodycontent") 
                    bodycontent = contentTranscoding(bodycontent) 
                    '�Ƿ���������html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    If isonhtml = "0" Or LCase(isonhtml) = "false" Then
                        isonhtml = 0 
                    Else
                        isonhtml = 1 
                    End If 
                    '�Ƿ�Ϊnofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    If nofollow = "1" Or LCase(nofollow) = "true" Then
                        nofollow = 1 
                    Else
                        nofollow = 0 
                    End If 


                    conn.Execute("insert into " & db_PREFIX & "onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target,templatepath) values('" & title & "','" & displaytitle & "','" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & adddatetime & "','" & fileName & "'," & isonhtml & ",'" & simpleintroduction & "','" & bodycontent & "'," & nofollow & ",'" & target & "','" & templatepath & "')") 
                End If 
            Next 
        End If 
    Next 

    '����
    conn.Execute("delete from " & db_PREFIX & "Bidding") 
    content = getDirTxtList(webdataDir & "/Bidding/") 
    splStr = Split(content, vbCrLf) 
    Call hr() 
    For Each filePath In splStr
        fileName = getfilename(filePath) 
        If filePath <> "" And InStr("_#", Left(fileName, 1)) = False Then
            Call echo("����", filePath) 
            content = getftext(filePath) 
            splxx = Split(content, vbCrLf & "-------------------------------") 
            For Each s In splxx
                If InStr(s, "��webkeywords��") > 0 Then
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    showreason = newGetStrCut(s, "showreason") 
                    ncomputersearch = newGetStrCut(s, "ncomputersearch") 
                    nmobliesearch = newGetStrCut(s, "nmobliesearch") 
                    ncountsearch = newGetStrCut(s, "ncountsearch") 
                    ndegree = newGetStrCut(s, "ndegree") 
                    ndegree = getnumber(ndegree) 
                    If ndegree = "" Then
                        ndegree = 0 
                    End If 
                    conn.Execute("insert into " & db_PREFIX & "Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values('" & webkeywords & "','" & showreason & "'," & ncomputersearch & "," & nmobliesearch & "," & ndegree & ")") 
                End If 
            Next 
        End If 
    Next 

    '����ͳ��
    conn.Execute("delete from " & db_PREFIX & "SearchStat") 
    content = getDirTxtList(webdataDir & "/SearchStat/") 
    splStr = Split(content, vbCrLf) 
    Call hr() 
    For Each filePath In splStr
        fileName = getfilename(filePath) 
        If filePath <> "" And InStr("_#", Left(fileName, 1)) = False Then
            Call echo("����ͳ��", filePath) 
            content = getftext(filePath) 
            splxx = Split(content, vbCrLf & "-------------------------------") 
            For Each s In splxx
                If InStr(s, "��title��") > 0 Then
                    title = newGetStrCut(s, "title") 
                    webtitle = newGetStrCut(s, "webtitle") 
                    webkeywords = newGetStrCut(s, "webkeywords") 
                    webdescription = newGetStrCut(s, "webdescription") 

                    customaurl = newGetStrCut(s, "customaurl") 
                    target = newGetStrCut(s, "target") 
                    through = newGetStrCut(s, "through") 
                    If through = "0" Or LCase(through) = "false" Then
                        through = 0 
                    Else
                        through = 1 
                    End If 
                    sortrank = newGetStrCut(s, "sortrank") 
                    If sortrank = "" Then sortrank = 0 
                    '�Ƿ���������html
                    isonhtml = newGetStrCut(s, "isonhtml") 
                    If isonhtml = "0" Or LCase(isonhtml) = "false" Then
                        isonhtml = 0 
                    Else
                        isonhtml = 1 
                    End If 
                    '�Ƿ�Ϊnofollow
                    nofollow = newGetStrCut(s, "nofollow") 
                    If nofollow = "1" Or LCase(nofollow) = "true" Then
                        nofollow = 1 
                    Else
                        nofollow = 0 
                    End If 
                    'call echo("title",title)
                    conn.Execute("insert into " & db_PREFIX & "SearchStat (title,webtitle,webkeywords,webdescription,customaurl,target,through,sortrank,isonhtml,nofollow) values('" & title & "','" & webtitle & "','" & webkeywords & "','" & webdescription & "','" & customaurl & "','" & target & "'," & through & "," & sortrank & "," & isonhtml & "," & nofollow & ")") 

                End If 
            Next 
        End If 
    Next 

    '����
    conn.Execute("delete from " & db_PREFIX & "TableComment") 



End Sub 

'����ת��
Function contentTranscoding(ByVal content)
    content = Replace(Replace(Replace(Replace(content, "<?", "&lt;?"), "?>", "?&gt;"), "<" & "%", "&lt;%"), "?>", "%&gt;") 


    Dim splStr, i, s, c, isTranscoding, isBR 
    isTranscoding = False 
    isBR = False 
    splStr = Split(content, vbCrLf) 
    For Each s In splStr
        If InStr(s, "[&htmlת��&]") > 0 Then
            isTranscoding = True 
        End If 
        If InStr(s, "[&htmlת��end&]") > 0 Then
            isTranscoding = False 
        End If 
        If InStr(s, "[&ȫ������&]") > 0 Then
            isBR = True 
        End If 
        If InStr(s, "[&ȫ������end&]") > 0 Then
            isBR = False 
        End If 

        If isTranscoding = True Then
            s = Replace(Replace(s, "[&htmlת��&]", ""), "<", "&lt;") 
        Else
            s = Replace(s, "[&htmlת��end&]", "") 
        End If 
        If isBR = True Then
            s = Replace(s, "[&ȫ������&]", "") & "<br>" 
        Else
            s = Replace(s, "[&ȫ������end&]", "") 
        End If 
        c = c & s & vbCrLf 
    Next 
    contentTranscoding = c 
End Function 
%>   
