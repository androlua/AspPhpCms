<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-16
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By �ƶ� 
'************************************************************
%>
<%
sUB rESeTAcCEsSDaTA()
cALl oPEnCOnN()
dIM b, c, d, e, f, g
cALl oPEnCOnN()
cONn.eXEcUTe("delete from " & dB_pREfIX & "webcolumn")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,parentid) values('���Ʋ�Ʒ','Recommend','��ҳ',0,'|top|',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid,showtitle,bodycontent) values('���ڰ���','About','�ı�',1,'|top|','��������������֪���ܶ�',-1,'�����԰�Ƽ���չ���޹�˾','��˾ӵ������Ĺ�����ר�ҡ����ڡ���ʿ��˶ʿ��רҵ���з����飬����������������ˮƽ�����Ͳ��ϺͲ�Ʒ�� ��������˾����Ʒ�Ƶ�ս�Ժ��˲ŵ�ս�ԣ��ڼ��ҵ��г�������Ѹ�ٷ�չ��׳���γ����Կ��С�����������������Ӫ��Ϊһ��Ķ�Ԫ�����������רҵ�Ƽ���˾�� ��˾ʵ�������ںϵ�ս�ԣ����ձ����л����������о�����������������ˮƽ�����ﱣ��Ʒ�ͻ�ױƷ�� ����ھ����о�ʵ���Ĺ�����ά�о����������������Ƴ��˹����Ƚ��߶˵����׹���΢�۲��ϼ���άϵ�н�����Ʒ���Լ�����������Ƶ�������ط�������ϵ����������ֹ�˾������ʵʵ���ڵ�������ҵ�����ڶ�������Ͷ������������ͷ��ٮٮ�ߣ��������ص㱣����ҵ��������ҵ��������ӵ�пƼ�����������ʵ��ר��11���ҵ�����ISO9000��ISO14000��֤,�������������Ϊ��������ҵ���͡����Ǽ���ҵ���� ')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('���ò�Ʒ','Product','��Ʒ',2,'|top|','���ľ���Ϊ�����������õĲ�Ʒ',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('������Ƶ','News','��Ʒ',3,'|top|','��˾��Ϣһ��֪��',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('��ϵ����','Contact us','�ı�',4,'|top|','���ǿ�����˼�˻�ӭ����ϵ',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('ϸ����̬ѧ','Contact us','����',4,'||','',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('���ݳ�ʶ','Contact us','����',4,'||','',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('������Ѷ','Contact us','����',4,'||','',-1)")
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('������Ƶ','Contact us','��Ƶ',4,'||','',-1)")
cONn.eXEcUTe("delete from " & dB_pREfIX & "articledetail")
b = sPLiT("ϸ����̬ѧ|���ݳ�ʶ|������Ѷ|���ò�Ʒ", "|")
fOR eACh e iN b
iF e = "���ò�Ʒ" tHEn
g = 12
eLSe
g = 6
eND iF
fOR c = 1 tO g
f = e & c
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values('" & f & "'," & gETcOLuMNiD(e) & ",'[$WebImages$]testproduct.jpg','[$WebImages$]biglimage.jpg','[$WebImages$]banner" & c & ".jpg','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ��������" & f & "�����������˯��ʱ��4','" & f & "��������������д')")
nEXt
nEXt
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ1'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ2'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]banner1.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ3'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ4'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]banner1.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
rS.oPEn "select * from  " & dB_pREfIX & "website ", cONn, 1, 1
iF rS.eOF tHEn
cONn.eXEcUTe("insert into " & dB_pREfIX & "website (webtitle) values('��վ����')")
eND iF : rS.cLOsE
cONn.eXEcUTe("update  " & dB_pREfIX & "website  set webtitle='���ù���',webkeywords='���ùؼ���',webdescription='��������',websitebottom='Copyright @ 2014 �����Ϲٷ���վ All Rights Reserved<br>��ICP��09092049��-2',webtemplate='/Templates2015/����/',webimages='/Templates2015/����/Images/',webcss='/Templates2015/����/Css/',webjs='/Templates2015/����/Js/'")
cALl eCHo("��ʾ", "�ָ��������")
cALl rW("<hr><a href='../" & eDItORtYPe & "web." & eDItORtYPe & "' target='_blank'>������ҳ</a> | <a href=""?"" target='_blank'>�����̨</a>")
cONn.eXEcUTe("delete from " & dB_pREfIX & "onePage ")
cONn.eXEcUTe("insert into " & dB_pREfIX & "onePage (title) values('���ã���1����ҳ��')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "onePage (title) values('���ã���2����ҳ��')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "onePage (title) values('���ã���3����ҳ��')")
cONn.eXEcUTe("delete from " & dB_pREfIX & "admin ")
cONn.eXEcUTe("insert into " & dB_pREfIX & "admin (username,pwd) values('aa','" & mYMd5("aa") & "')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "admin (username,pwd) values('admin','" & mYMd5("admin") & "')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "admin (username,pwd) values('11','" & mYMd5("11") & "')")
iF 1 = 1 tHEn
fOR c = 1 tO 320
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values('" & c & "'," & gETcOLuMNiD("ϸ����̬ѧ") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]biglimage.jpg','[$WebImages$]banner" & c & ".jpg','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ��������" & c & "�����������˯��ʱ��4','" & c & "��������������д')")
nEXt
cONn.eXEcUTe("delete from " & dB_pREfIX & "weblayout")
d = gETfTExT("zcase_layout.txt")
d = aDSqL(d)
cONn.eXEcUTe("insert into " & dB_pREfIX & "weblayout(layoutname,layoutlist,bodycontent) values('��ɫ', '��վ����|��������|��Ʒչʾ|����չʾ','" & d & "')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "weblayout(layoutname,layoutlist,bodycontent) values('��ɫ', '��վ����|��������|��Ʒչʾ|����չʾ','" & d & "')")
cONn.eXEcUTe("insert into " & dB_pREfIX & "weblayout(layoutname,layoutlist,bodycontent) values('��ɫ', '��վ����|��������|��Ʒչʾ|����չʾ','" & d & "')")
cONn.eXEcUTe("delete from " & dB_pREfIX & "webmodule")
b = sPLiT("��վ����|��������|��Ʒչʾ|����չʾ", "|")
fOR eACh f iN b
d = "{$ReadColumeSetTitle title='" & f & "' style='312' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName\' file=\'\'$]'$}<!--#��������BlockName" & f & " �����������, ��һ�ֵ��÷���#-->"
d = aDSqL(d)
cONn.eXEcUTe("insert into " & dB_pREfIX & "webmodule(moduletype,modulename,bodycontent) values('��ɫ','" & f & "','" & d & "')")
nEXt
eND iF
dIM h, i, j, k, l, m, n, o, p, q, r, s, t
dIM u, v, w, x, y, z, aA, bA, cA, dA, eA, fA, gA
dIM hA, iA, jA, kA, lA
dIM mA, nA, oA
fOR c = 1 tO 20
cONn.eXEcUTe("insert into " & dB_pREfIX & "Bidding(nComputerSearch) values(2" & c & ")")
cONn.eXEcUTe("insert into " & dB_pREfIX & "Bidding(nComputerSearch) values(1" & c & ")")
nEXt
h = gETfTExT("/Data/WebData/website.ini")
iF h <> "" tHEn
o = pHPtRIm(gETsTRcUT(h, "��webtitle��", vBCrLF, 0) )
p = pHPtRIm(gETsTRcUT(h, "��webkeywords��", vBCrLF, 0) )
q = pHPtRIm(gETsTRcUT(h, "��webdescription��", vBCrLF, 0) )
u = pHPtRIm(gETsTRcUT(h, "��websitebottom��", vBCrLF, 0) )
v = pHPtRIm(gETsTRcUT(h, "��webtemplate��", vBCrLF, 0) )
w = pHPtRIm(gETsTRcUT(h, "��webimages��", vBCrLF, 0) )
x = pHPtRIm(gETsTRcUT(h, "��webcss��", vBCrLF, 0))
y = pHPtRIm(gETsTRcUT(h, "��webjs��", vBCrLF, 0) )
z = pHPtRIm(gETsTRcUT(h, "��flags��", vBCrLF, 0) )
aA = pHPtRIm(gETsTRcUT(h, "��websiteurl��", vBCrLF, 0))
cONn.eXEcUTe("update " & dB_pREfIX & "website  set webtitle='" & o & "',webkeywords='" & p & "',webdescription='" & q & "',websitebottom='" & u & "',webtemplate='" & v & "',webimages='" & w & "',webcss='" & x & "',webjs='" & y & "',flags='" & z & "',websiteurl='" & aA & "'")
eND iF
cONn.eXEcUTe("delete from " & dB_pREfIX & "webcolumn")
h = gETdIRtXTlISt("/Data/WebData/NavData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m = gETfILeNAmE(i)
iF i <> "" aND iNStR("_#", lEFt(m, 1)) = fALsE tHEn
cALl eCHo("����", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��webtitle��") > 0 tHEn
o = pHPtRIm(gETsTRcUT(d, "��webtitle��", vBCrLF, 0) )
p = pHPtRIm(gETsTRcUT(d, "��webkeywords��", vBCrLF, 0) )
q = pHPtRIm(gETsTRcUT(d, "��webdescription��", vBCrLF, 0) )
r = pHPtRIm(gETsTRcUT(d, "��sortrank��", vBCrLF, 0) )
iF r = "" tHEn r = 0
m = pHPtRIm(gETsTRcUT(d, "��filename��", vBCrLF, 0) )
e = pHPtRIm(gETsTRcUT(d, "��columnname��", vBCrLF, 0) )
cA = pHPtRIm(gETsTRcUT(d, "��columntype��", vBCrLF, 0) )
z = pHPtRIm(gETsTRcUT(d, "��flags��", vBCrLF, 0) )
j = pHPtRIm(gETsTRcUT(d, "��parentid��", vBCrLF, 0) )
j = pHPtRIm(gETcOLuMNiD(j) )
s = pHPtRIm(gETsTRcUT(d, "��labletitle��", vBCrLF, 0))
eA = pHPtRIm(gETsTRcUT(d, "��npagesize��", vBCrLF, 0) )
iF eA = "" tHEn eA = 10
t = pHPtRIm(gETsTRcUT(d, "��target��", vBCrLF, 0) )
n = aDSqL(pHPtRIm(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0)) )
n = cONtENtTRaNScODiNG(n)
oA = pHPtRIm(pHPtRIm(gETsTRcUT(d, "��isonhtml��", vBCrLF, 0)) )
iF oA = "0" oR lCAsE(oA) = "false" tHEn
oA = 0
eLSe
oA = 1
eND iF
gA = pHPtRIm(pHPtRIm(gETsTRcUT(d, "��nofollow��", vBCrLF, 0)) )
iF gA = "1" oR lCAsE(gA) = "true" tHEn
gA = 1
eLSe
gA = 0
eND iF
nA = aDSqL(pHPtRIm(gETsTRcUT(d, "��simpleintroduction��", "��/simpleintroduction��", 0)) )
nA = cONtENtTRaNScODiNG(nA)
n = aDSqL(pHPtRIm(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0)))
n = cONtENtTRaNScODiNG(n)
cONn.eXEcUTe("insert into " & dB_pREfIX & "webcolumn (webtitle,webkeywords,webdescription,columnname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target) values('" & o & "','" & p & "','" & q & "','" & e & "','" & cA & "'," & r & ",'" & m & "','" & z & "'," & j & ",'" & s & "','" & nA & "','" & n & "'," & eA & "," & oA & "," & gA & ",'" & t & "')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from " & dB_pREfIX & "articledetail")
h = gETdIRtXTlISt("/Data/WebData/ArticleData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m = gETfILeNAmE(i)
iF i <> "" aND iNStR("_#", lEFt(m, 1)) = fALsE tHEn
cALl eCHo("����", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��title��") > 0 tHEn
d = d & vBCrLF
j = pHPtRIm(gETsTRcUT(d, "��parentid��", vBCrLF, 0))
j = gETcOLuMNiD(j)
f = aDSqL(pHPtRIm(gETsTRcUT(d, "��title��", vBCrLF, 0)) )
o = pHPtRIm(gETsTRcUT(d, "��webtitle��", vBCrLF, 0) )
p = pHPtRIm(gETsTRcUT(d, "��webkeywords��", vBCrLF, 0) )
q = pHPtRIm(gETsTRcUT(d, "��webdescription��", vBCrLF, 0) )
k = pHPtRIm(gETsTRcUT(d, "��author��", vBCrLF, 0) )
r = pHPtRIm(gETsTRcUT(d, "��sortrank��", vBCrLF, 0) )
iF r = "" tHEn r = 0
l = pHPtRIm(gETsTRcUT(d, "��adddatetime��", vBCrLF, 0) )
m = pHPtRIm(gETsTRcUT(d, "��filename��", vBCrLF, 0) )
z = pHPtRIm(gETsTRcUT(d, "��flags��", vBCrLF, 0) )
dA = pHPtRIm(gETsTRcUT(d, "��relatedtags��", vBCrLF, 0) )
fA = aDSqL(pHPtRIm(gETsTRcUT(d, "��customaurl��", vBCrLF, 0)) )
t = pHPtRIm(gETsTRcUT(d, "��target��", vBCrLF, 0) )
n = aDSqL(pHPtRIm(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0)) )
n = cONtENtTRaNScODiNG(n)
oA = pHPtRIm(gETsTRcUT(d, "��isonhtml��", vBCrLF, 0))
iF oA = "0" oR lCAsE(oA) = "false" tHEn
oA = 0
eLSe
oA = 1
eND iF
gA = pHPtRIm(gETsTRcUT(d, "��nofollow��", vBCrLF, 0))
iF gA = "1" oR lCAsE(gA) = "true" tHEn
gA = 1
eLSe
gA = 0
eND iF
cONn.eXEcUTe("insert into " & dB_pREfIX & "articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target) values(" & j & ",'" & f & "','" & o & "','" & p & "','" & q & "','" & k & "'," & r & ",'" & l & "','" & m & "','" & z & "','" & dA & "','" & n & "','" & nOW() & "'," & oA & ",'" & fA & "'," & gA & ",'" & t & "')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from " & dB_pREfIX & "OnePage")
h = gETdIRtXTlISt("/Data/WebData/OnePageData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m = gETfILeNAmE(i)
iF i <> "" aND iNStR("_#", lEFt(m, 1)) = fALsE tHEn
cALl eCHo("��ҳ", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��webkeywords��") > 0 tHEn
d = d & vBCrLF
f = aDSqL(pHPtRIm(gETsTRcUT(d, "��title��", vBCrLF, 0)) )
mA = aDSqL(pHPtRIm(gETsTRcUT(d, "��displaytitle��", vBCrLF, 0)) )
o = pHPtRIm(gETsTRcUT(d, "��webtitle��", vBCrLF, 0) )
p = pHPtRIm(gETsTRcUT(d, "��webkeywords��", vBCrLF, 0) )
q = pHPtRIm(gETsTRcUT(d, "��webdescription��", vBCrLF, 0) )
l = pHPtRIm(gETsTRcUT(d, "��adddatetime��", vBCrLF, 0) )
m = pHPtRIm(gETsTRcUT(d, "��filename��", vBCrLF, 0) )
nA = aDSqL(pHPtRIm(gETsTRcUT(d, "��simpleintroduction��", "��/simpleintroduction��", 0)) )
nA = cONtENtTRaNScODiNG(nA)
t = pHPtRIm(gETsTRcUT(d, "��target��", vBCrLF, 0) )
n = aDSqL(pHPtRIm(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0)) )
n = cONtENtTRaNScODiNG(n)
oA = pHPtRIm(gETsTRcUT(d, "��isonhtml��", vBCrLF, 0))
iF oA = "0" oR lCAsE(oA) = "false" tHEn
oA = 0
eLSe
oA = 1
eND iF
gA = pHPtRIm(gETsTRcUT(d, "��nofollow��", vBCrLF, 0))
iF gA = "1" oR lCAsE(gA) = "true" tHEn
gA = 1
eLSe
gA = 0
eND iF
cONn.eXEcUTe("insert into " & dB_pREfIX & "onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target) values('" & f & "','" & mA & "','" & o & "','" & p & "','" & q & "','" & l & "','" & m & "'," & oA & ",'" & nA & "','" & n & "'," & gA & ",'" & t & "')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from " & dB_pREfIX & "Bidding")
h = gETdIRtXTlISt("/Data/WebData/BiddingData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m = gETfILeNAmE(i)
iF i <> "" aND iNStR("_#", lEFt(m, 1)) = fALsE tHEn
cALl eCHo("����", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��webkeywords��") > 0 tHEn
p = pHPtRIm(gETsTRcUT(d, "��webkeywords��", vBCrLF, 0) )
hA = pHPtRIm(gETsTRcUT(d, "��showreason��", vBCrLF, 0) )
iA = pHPtRIm(gETsTRcUT(d, "��ncomputersearch��", vBCrLF, 0) )
jA = pHPtRIm(gETsTRcUT(d, "��nmobliesearch��", vBCrLF, 0) )
kA = pHPtRIm(gETsTRcUT(d, "��ncountsearch��", vBCrLF, 0) )
lA = pHPtRIm(gETsTRcUT(d, "��ndegree��", vBCrLF, 0))
lA = gETnUMbER(lA)
iF lA = "" tHEn
lA = 0
eND iF
cONn.eXEcUTe("insert into " & dB_pREfIX & "Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values('" & p & "','" & hA & "'," & iA & "," & jA & "," & lA & ")")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from " & dB_pREfIX & "TableComment")
eND sUB
fUNcTIoN cONtENtTRaNScODiNG(bYVaL a)
a = rEPlACe(rEPlACe(rEPlACe(rEPlACe(a, "<?", "&lt;?"), "?>", "?&gt;"), "<" & "%", "&lt;%"), "?>", "%&gt;")
dIM b, c, d, e, f, g
f = fALsE
g = fALsE
b = sPLiT(a, vBCrLF)
fOR eACh d iN b
iF iNStR(d, "[&htmlת��&]") > 0 tHEn
f = tRUe
eND iF
iF iNStR(d, "[&htmlת��end&]") > 0 tHEn
f = fALsE
eND iF
iF iNStR(d, "[&ȫ������&]") > 0 tHEn
g = tRUe
eND iF
iF iNStR(d, "[&ȫ������end&]") > 0 tHEn
g = fALsE
eND iF
iF f = tRUe tHEn
d = rEPlACe(rEPlACe(d, "[&htmlת��&]", ""), "<", "&lt;")
eLSe
d = rEPlACe(d, "[&htmlת��end&]", "")
eND iF
iF g = tRUe tHEn
d = rEPlACe(d, "[&ȫ������&]", "") & "<br>"
eLSe
d = rEPlACe(d, "[&ȫ������end&]", "")
eND iF
e = e & d & vBCrLF
nEXt
cONtENtTRaNScODiNG = e
eND fUNcTIoN
%>


