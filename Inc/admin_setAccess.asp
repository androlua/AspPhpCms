<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-17
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By �ƶ� 
'************************************************************
%>
<%


function newGetStrCut(a,b)
	dim c
	if instr(a,"��/"& b &"��")>0 then
		c = ADSql(phptrim(getStrCut(a, "��"& b &"��", "��/"& b &"��", 0)) )
	else
		c = ADSql(phptrim(getStrCut(a, "��"& b &"��", vbCrLf, 0) ))
	end if
	newGetStrCut=c
end function



Sub resetAccessData()
    Call OpenConn()
    Dim b, c, d, e, f, g,h
	h=request("webdataDir")
	if h<>"" then
		if checkFolder(h)=false then
			call eerr("��վ����Ŀ¼�����ڣ��ָ�Ĭ������δ�ɹ�", h)
		end if
	else
		h="/Data/WebData/"
	end if
	
    Call echo("��ʾ", "�ָ��������")
    Call rw("<hr><a href='../index.asp' target='_blank'>������ҳ</a> | <a href=""?"" target='_blank'>�����̨</a>")

    Dim i, j, k, l, m, n, o, p, q, r, s, t, u
    Dim v, w, x, y, z, aa, ba, ca, da, ea, fa, ga, ha
	dim ia
    Dim ja, ka, la, ma, na
    Dim oa, pa, qa
	dim columnenname																
	dim sa,ta,bannerimage												
	
	


	
    i = getftext(h & "/website.ini")
    If i <> "" Then
        p =  newGetStrCut(i,"webtitle")
        q = newGetStrCut(i,"webkeywords")
        r = newGetStrCut(i,"webdescription")
        v = newGetStrCut(i,"websitebottom")
        w = newGetStrCut(i,"webtemplate")
        x = newGetStrCut(i,"webimages")
        y =newGetStrCut(i,"webcss")
        z =newGetStrCut(i,"webjs")
        aa = newGetStrCut(i,"flags")
        ba = newGetStrCut(i,"websiteurl")
		
		if getRecordCount(db_PREFIX & "website", "")=0 then
			conn.execute("insert into " & db_PREFIX & "website(webtitle) values('����')")
		end if
		
    conn.Execute("update " & db_PREFIX & "website  set webtitle='" & p & "',webkeywords='" & q & "',webdescription='" & r & "',websitebottom='" & v & "',webtemplate='" & w & "',webimages='" & x & "',webcss='" & y & "',webjs='" & z & "',flags='" & aa & "',websiteurl='" & ba & "'")
	End If


    conn.Execute("delete from " & db_PREFIX & "webcolumn")
    i = getDirTxtList(h & "/NavData/")
    b = Split(i, vbCrLf)
    Call hr()
    For Each j In b
        n = getfilename(j)
        If j <> "" And InStr("_#", Left(n, 1)) = False Then
            Call echo("����", j)
            i = getftext(j)
            ca = Split(i, vbCrLf & "-------------------------------")
            For Each d In ca
                If InStr(d, "��webtitle��") > 0 Then
					p =  newGetStrCut(d,"webtitle")
					q = newGetStrCut(d,"webkeywords")
					r = newGetStrCut(d,"webdescription")

                    s = newGetStrCut(d,"sortrank")
                    If s = "" Then s = 0
                    n =newGetStrCut(d,"filename")
                    e =newGetStrCut(d,"columnname")
					columnenname=newGetStrCut(d,"columnenname")
                    da = newGetStrCut(d,"columntype")
                    aa =newGetStrCut(d,"flags")
                    k = newGetStrCut(d,"parentid")
                    k = phptrim(getColumnId(k) )
                    t = newGetStrCut(d,"labletitle")

                    fa =newGetStrCut(d,"npagesize")
                    If fa = "" Then fa = 10

                    u = newGetStrCut(d,"target")
					
                    sa = newGetStrCut(d,"smallimage")
                    ta = newGetStrCut(d,"bigImage")
                    bannerimage = newGetStrCut(d,"bannerimage")
					
                    ia = newGetStrCut(d,"templatepath")
					

                    o = newGetStrCut(d,"bodycontent")
                    o = contentTranscoding(o)

                    qa = newGetStrCut(d,"isonhtml")
                    If qa = "0" Or LCase(qa) = "false" Then
                        qa = 0
                    Else
                        qa = 1
                    End If

                    ha = newGetStrCut(d,"nofollow")
                    If ha = "1" Or LCase(ha) = "true" Then
                        ha = 1
                    Else
                        ha = 0
                    End If


                    pa = newGetStrCut(d,"simpleintroduction")
                    pa = contentTranscoding(pa)

                    o = newGetStrCut(d,"bodycontent")
                    o = contentTranscoding(o)

                    conn.Execute("insert into " & db_PREFIX & "webcolumn (webtitle,webkeywords,webdescription,columnname,columnenname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values('" & p & "','" & q & "','" & r & "','" & e & "','" & columnenname & "','" & da & "'," & s & ",'" & n & "','" & aa & "'," & k & ",'" & t & "','" & pa & "','" & o & "'," & fa & "," & qa & "," & ha & ",'" & u & "','" & sa & "','" & ta & "','" & bannerimage & "','" & ia & "')")
                End If
            Next
        End If
    Next


    conn.Execute("delete from " & db_PREFIX & "articledetail")
    i = getDirTxtList(h & "/ArticleData/")
    b = Split(i, vbCrLf)
    Call hr()
    For Each j In b
        n = getfilename(j)
        If j <> "" And InStr("_#", Left(n, 1)) = False Then
            Call echo("����", j)
            i = getftext(j)
            ca = Split(i, vbCrLf & "-------------------------------")
            For Each d In ca
                If InStr(d, "��title��") > 0 Then
                    d = d & vbCrLf
                    k = newGetStrCut(d,"parentid")
                    k = getColumnId(k)
                    f = newGetStrCut(d,"title")
					p =  newGetStrCut(d,"webtitle")
					q = newGetStrCut(d,"webkeywords")
					r = newGetStrCut(d,"webdescription")


                    l = newGetStrCut(d,"author")
                    s =newGetStrCut(d,"sortrank")
                    If s = "" Then s = 0
                    m = newGetStrCut(d,"adddatetime")
                    n =newGetStrCut(d,"filename")
                    aa = newGetStrCut(d,"flags")
                    ea =newGetStrCut(d,"relatedtags")

                    ga = newGetStrCut(d,"customaurl")
                    u = newGetStrCut(d,"target")

					
                    sa = newGetStrCut(d,"smallimage")
                    ta = newGetStrCut(d,"bigImage")
                    bannerimage = newGetStrCut(d,"bannerimage")
                    ia = newGetStrCut(d,"templatepath")


                    o =newGetStrCut(d,"bodycontent")
                    o = contentTranscoding(o)

                    qa =newGetStrCut(d,"isonhtml")
                    If qa = "0" Or LCase(qa) = "false" Then
                        qa = 0
                    Else
                        qa = 1
                    End If

                    ha = newGetStrCut(d,"nofollow")
                    If ha = "1" Or LCase(ha) = "true" Then
                        ha = 1
                    Else
                        ha = 0
                    End If
                    conn.Execute("insert into " & db_PREFIX & "articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target,smallimage,bigImage,bannerimage,templatepath) values(" & k & ",'" & f & "','" & p & "','" & q & "','" & r & "','" & l & "'," & s & ",'" & m & "','" & n & "','" & aa & "','" & ea & "','" & o & "','" & Now() & "'," & qa & ",'" & ga & "'," & ha & ",'" & u & "','" & sa & "','" & ta & "','" & bannerimage & "','" & ia & "')")
                End If
            Next
        End If
    Next


    conn.Execute("delete from " & db_PREFIX & "OnePage")
    i = getDirTxtList(h & "/OnePageData/")
    b = Split(i, vbCrLf)
    Call hr()
    For Each j In b
        n = getfilename(j)
        If j <> "" And InStr("_#", Left(n, 1)) = False Then
            Call echo("��ҳ", j)
            i = getftext(j)
            ca = Split(i, vbCrLf & "-------------------------------")
            For Each d In ca
                If InStr(d, "��webkeywords��") > 0 Then
                    d = d & vbCrLf
                    f =newGetStrCut(d,"title")
                    oa = newGetStrCut(d,"displaytitle")
					p =  newGetStrCut(d,"webtitle")
					q = newGetStrCut(d,"webkeywords")
					r = newGetStrCut(d,"webdescription")



                    m = newGetStrCut(d,"adddatetime")
                    n = newGetStrCut(d,"filename")

                    pa =newGetStrCut(d,"simpleintroduction")
					
                    pa = contentTranscoding(pa)
                    u = newGetStrCut(d,"target")
                    ia = newGetStrCut(d,"templatepath")

                    o = newGetStrCut(d,"bodycontent")
                    o = contentTranscoding(o)

                    qa =newGetStrCut(d,"isonhtml")
                    If qa = "0" Or LCase(qa) = "false" Then
                        qa = 0
                    Else
                        qa = 1
                    End If

                    ha =newGetStrCut(d,"nofollow")
                    If ha = "1" Or LCase(ha) = "true" Then
                        ha = 1
                    Else
                        ha = 0
                    End If


                    conn.Execute("insert into " & db_PREFIX & "onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target,templatepath) values('" & f & "','" & oa & "','" & p & "','" & q & "','" & r & "','" & m & "','" & n & "'," & qa & ",'" & pa & "','" & o & "'," & ha & ",'" & u & "','" & ia & "')")
                End If
            Next
        End If
    Next


    conn.Execute("delete from " & db_PREFIX & "Bidding")
    i = getDirTxtList(h & "/BiddingData/")
    b = Split(i, vbCrLf)
    Call hr()
    For Each j In b
        n = getfilename(j)
        If j <> "" And InStr("_#", Left(n, 1)) = False Then
            Call echo("����", j)
            i = getftext(j)
            ca = Split(i, vbCrLf & "-------------------------------")
            For Each d In ca
                If InStr(d, "��webkeywords��") > 0 Then
                    q =newGetStrCut(d,"webkeywords")
                    ja = newGetStrCut(d,"showreason")
                    ka =newGetStrCut(d,"ncomputersearch")
                    la = newGetStrCut(d,"nmobliesearch")
                    ma = newGetStrCut(d,"ncountsearch")
                    na =newGetStrCut(d,"ndegree")
                    na = getnumber(na)
                    If na = "" Then
                        na = 0
                    End If
                    conn.Execute("insert into " & db_PREFIX & "Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values('" & q & "','" & ja & "'," & ka & "," & la & "," & na & ")")
                End If
            Next
        End If
    Next



    conn.Execute("delete from " & db_PREFIX & "TableComment")



End Sub


Function contentTranscoding(ByVal a)
    a = Replace(Replace(Replace(Replace(a, "<?", "&lt;?"), "?>", "?&gt;"), "<" & "%", "&lt;%"), "?>", "%&gt;")


    Dim b, c, d, e, f, g
    f = False
    g = False
    b = Split(a, vbCrLf)
    For Each d In b
        If InStr(d, "[&htmlת��&]") > 0 Then
            f = True
        End If
        If InStr(d, "[&htmlת��end&]") > 0 Then
            f = False
        End If
        If InStr(d, "[&ȫ������&]") > 0 Then
            g = True
        End If
        If InStr(d, "[&ȫ������end&]") > 0 Then
            g = False
        End If

        If f = True Then
            d = Replace(Replace(d, "[&htmlת��&]", ""), "<", "&lt;")
        Else
            d = Replace(d, "[&htmlת��end&]", "")
        End If
        If g = True Then
            d = Replace(d, "[&ȫ������&]", "") & "<br>"
        Else
            d = Replace(d, "[&ȫ������end&]", "")
        End If
        e = e & d & vbCrLf
    Next
    contentTranscoding = e
End Function
%>


