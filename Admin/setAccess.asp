<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-01
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
cONn.eXEcUTe("delete from "& dB_pREfIX &"webcolumn")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,parentid) values('���Ʋ�Ʒ','Recommend','��ҳ',0,'|top|',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid,showtitle,bodycontent) values('���ڰ���','About','�ı�',1,'|top|','��������������֪���ܶ�',-1,'�����԰�Ƽ���չ���޹�˾','��˾ӵ������Ĺ�����ר�ҡ����ڡ���ʿ��˶ʿ��רҵ���з����飬����������������ˮƽ�����Ͳ��ϺͲ�Ʒ�� ��������˾����Ʒ�Ƶ�ս�Ժ��˲ŵ�ս�ԣ��ڼ��ҵ��г�������Ѹ�ٷ�չ��׳���γ����Կ��С�����������������Ӫ��Ϊһ��Ķ�Ԫ�����������רҵ�Ƽ���˾�� ��˾ʵ�������ںϵ�ս�ԣ����ձ����л����������о�����������������ˮƽ�����ﱣ��Ʒ�ͻ�ױƷ�� ����ھ����о�ʵ���Ĺ�����ά�о����������������Ƴ��˹����Ƚ��߶˵����׹���΢�۲��ϼ���άϵ�н�����Ʒ���Լ�����������Ƶ�������ط�������ϵ����������ֹ�˾������ʵʵ���ڵ�������ҵ�����ڶ�������Ͷ������������ͷ��ٮٮ�ߣ��������ص㱣����ҵ��������ҵ��������ӵ�пƼ�����������ʵ��ר��11���ҵ�����ISO9000��ISO14000��֤,�������������Ϊ��������ҵ���͡����Ǽ���ҵ���� ')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('���ò�Ʒ','Product','��Ʒ',2,'|top|','���ľ���Ϊ�����������õĲ�Ʒ',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('������Ƶ','News','��Ʒ',3,'|top|','��˾��Ϣһ��֪��',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('��ϵ����','Contact us','�ı�',4,'|top|','���ǿ�����˼�˻�ӭ����ϵ',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('ϸ����̬ѧ','Contact us','����',4,'||','',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('���ݳ�ʶ','Contact us','����',4,'||','',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('������Ѷ','Contact us','����',4,'||','',-1)")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columnenname,columntype,sortrank,flags,simpleintroduction,parentid) values('������Ƶ','Contact us','��Ƶ',4,'||','',-1)")
cONn.eXEcUTe("delete from "& dB_pREfIX &"articledetail")
b = sPLiT("ϸ����̬ѧ|���ݳ�ʶ|������Ѷ|���ò�Ʒ", "|")
fOR eACh e iN b
iF e = "���ò�Ʒ" tHEn
g = 12
eLSe
g = 6
eND iF
fOR c = 1 tO g
f = e & c
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values('" & f & "'," & gETcOLuMNiD(e) & ",'[$WebImages$]testproduct.jpg','[$WebImages$]biglimage.jpg','[$WebImages$]banner" & c & ".jpg','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ��������" & f & "�����������˯��ʱ��4','" & f & "��������������д')")
nEXt
nEXt
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ1'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ2'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]banner1.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ3'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction) values('��Ƶ4'," & gETcOLuMNiD("������Ƶ") & ",'[$WebImages$]banner1.jpg','[$WebImages$]1.flv','','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ�����������ܶ�����Ѩλ������̬��Ħ���ã����������˯��ʱ��4')")
rS.oPEn "select * from  "& dB_pREfIX &"website ", cONn, 1, 1
iF rS.eOF tHEn
cONn.eXEcUTe("insert into "& dB_pREfIX &"website (webtitle) values('��վ����')")
eND iF : rS.cLOsE
cONn.eXEcUTe("update  "& dB_pREfIX &"website  set webtitle='���ù���',webkeywords='���ùؼ���',webdescription='��������',websitebottom='Copyright @ 2014 �����Ϲٷ���վ All Rights Reserved<br>��ICP��09092049��-2',webtemplate='/Templates2015/����/',webimages='/Templates2015/����/Images/',webcss='/Templates2015/����/Css/',webjs='/Templates2015/����/Js/'")
cALl eCHo("��ʾ", "�ָ��������")
cALl rW("<hr><a href='/" & eDItORtYPe & "web." & eDItORtYPe & "' target='_blank'>������ҳ</a> | <a href=""1." & eDItORtYPe & """ target='_blank'>�����̨</a>")
cONn.eXEcUTe("delete from "& dB_pREfIX &"onePage ")
cONn.eXEcUTe("insert into "& dB_pREfIX &"onePage (title) values('���ã���1����ҳ��')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"onePage (title) values('���ã���2����ҳ��')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"onePage (title) values('���ã���3����ҳ��')")
cONn.eXEcUTe("delete from "& dB_pREfIX &"admin ")
cONn.eXEcUTe("insert into "& dB_pREfIX &"admin (username,pwd) values('aa','" & mYMd5("aa") & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"admin (username,pwd) values('admin','" & mYMd5("admin") & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"admin (username,pwd) values('11','" & mYMd5("11") & "')")
iF 1 = 2 tHEn
fOR c = 1 tO 320
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail(title,parentid,smallimage,bigImage,bannerimage,flags,simpleintroduction,bodycontent) values('" & c & "'," & gETcOLuMNiD("ϸ����̬ѧ") & ",'[$WebImages$]testproduct.jpg','[$WebImages$]biglimage.jpg','[$WebImages$]banner" & c & ".jpg','||','��Ʒ��˳��ˬ��͸��͸ʪ������ȥζ�������������������Ϯ��<br>��ͨ������������ﲨЧӦ����ͨ��Ѫ��ƽ��������" & c & "�����������˯��ʱ��4','" & c & "��������������д')")
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"weblayout")
d = gETfTExT("zcase_layout.txt")
d = aDSqL(d)
cONn.eXEcUTe("insert into "& dB_pREfIX &"weblayout(layoutname,layoutlist,bodycontent) values('��ɫ', '��վ����|��������|��Ʒչʾ|����չʾ','" & d & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"weblayout(layoutname,layoutlist,bodycontent) values('��ɫ', '��վ����|��������|��Ʒչʾ|����չʾ','" & d & "')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"weblayout(layoutname,layoutlist,bodycontent) values('��ɫ', '��վ����|��������|��Ʒչʾ|����չʾ','" & d & "')")
cONn.eXEcUTe("delete from "& dB_pREfIX &"webmodule")
b = sPLiT("��վ����|��������|��Ʒչʾ|����չʾ", "|")
fOR eACh f iN b
d = "{$ReadColumeSetTitle title='" & f & "' style='312' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName\' file=\'\'$]'$}<!--#��������BlockName" & f & " �����������, ��һ�ֵ��÷���#-->"
d = aDSqL(d)
cONn.eXEcUTe("insert into "& dB_pREfIX &"webmodule(moduletype,modulename,bodycontent) values('��ɫ','" & f & "','" & d & "')")
nEXt
eND iF
dIM h, i, j, k, l, m, n, o, p, q, r, s,t
dIM u, v, w, x, y, z, aA, bA, cA,dA,eA,fA,gA
dIM hA,iA,jA,kA,lA
dIM mA,nA,iSOnHTmL	
fOR c =1 tO 20
cONn.eXEcUTe("insert into "& dB_pREfIX &"Bidding(nComputerSearch) values(2"& c &")")
cONn.eXEcUTe("insert into "& dB_pREfIX &"Bidding(nComputerSearch) values(1"& c &")")
nEXt
h = gETfTExT("/Data/WebData/website.ini")
iF h <> "" tHEn
o = gETsTRcUT(h, "��webtitle��", vBCrLF, 0)
p = gETsTRcUT(h, "��webkeywords��", vBCrLF, 0)
q = gETsTRcUT(h, "��webdescription��", vBCrLF, 0)
u = gETsTRcUT(h, "��websitebottom��", vBCrLF, 0)
v = gETsTRcUT(h, "��webtemplate��", vBCrLF, 0)
w = gETsTRcUT(h, "��webimages��", vBCrLF, 0)
x = gETsTRcUT(h, "��webcss��", vBCrLF, 0)
y = gETsTRcUT(h, "��webjs��", vBCrLF, 0)
z = gETsTRcUT(h, "��flags��", vBCrLF, 0)
aA = gETsTRcUT(h, "��websiteurl��", vBCrLF, 0)
eND iF
cONn.eXEcUTe("update "& dB_pREfIX &"website  set webtitle='" & o & "',webkeywords='" & p & "',webdescription='" & q & "',websitebottom='" & u & "',webtemplate='" & v & "',webimages='" & w & "',webcss='" & x & "',webjs='" & y & "',flags='" & z & "',websiteurl='" & aA & "'")
cONn.eXEcUTe("delete from "& dB_pREfIX &"webcolumn")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle,target) values('ASPToPHP','����',1,'/asptophp/','|top|',-1,'����ASPתPHP','_blank')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('ASP','����',2,'/asp/','|top|',-1,'ASP�����б�')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('PHP','����',3,'/php/','|top|',-1,'PHP�����б�')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('JS','����',4,'/js/','|top|',-1,'JS�����б�')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('HTML5','����',5,'/html5/','|top|',-1,'HTML5�����б�')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('CSS3','����',6,'/css3/','|top|',-1,'CSS3�����б�')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('�ʴ�ר��','����',7,'/ask/','|top|',-1,'�ʴ�ר��')")
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (columnname,columntype,sortrank,filename,flags,parentid,labletitle) values('��ϵ����','�ı�',8,'/contactauthor.html','|top|',-1,'��ϵ����')")
cONn.eXEcUTe("delete from "& dB_pREfIX &"webcolumn")
h = gETdIRtXTlISt("/Data/WebData/NavData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("����", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��webtitle��") > 0 tHEn
o = gETsTRcUT(d, "��webtitle��", vBCrLF, 0)
p = gETsTRcUT(d, "��webkeywords��", vBCrLF, 0)
q = gETsTRcUT(d, "��webdescription��", vBCrLF, 0)
r = gETsTRcUT(d, "��sortrank��", vBCrLF, 0)
iF r = "" tHEn r = 0
m = gETsTRcUT(d, "��filename��", vBCrLF, 0)
e = gETsTRcUT(d, "��columnname��", vBCrLF, 0)
cA = gETsTRcUT(d, "��columntype��", vBCrLF, 0)
z = gETsTRcUT(d, "��flags��", vBCrLF, 0)
j = gETsTRcUT(d, "��parentid��", vBCrLF, 0)
j = gETcOLuMNiD(j)
s = gETsTRcUT(d, "��labletitle��", vBCrLF, 0)
eA = gETsTRcUT(d, "��npagesize��", vBCrLF, 0)
iF eA="" tHEn eA = 10	
t=gETsTRcUT(d, "��target��", vBCrLF, 0)
n = aDSqL(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0))
n = cONtENtTRaNScODiNG(n)
iSOnHTmL=pHPtRIm(gETsTRcUT(d, "��isonhtml��", vBCrLF, 0))
iF iSOnHTmL="0" oR lCAsE(iSOnHTmL)="false" tHEn
iSOnHTmL=0
eLSe
iSOnHTmL=1
eND iF
gA=pHPtRIm(gETsTRcUT(d, "��nofollow��", vBCrLF, 0))
iF gA="1" oR lCAsE(gA)="true" tHEn
gA=tRUe
eLSe
gA=fALsE
eND iF
nA = aDSqL(gETsTRcUT(d, "��simpleintroduction��", "��/simpleintroduction��", 0))
nA = cONtENtTRaNScODiNG(nA)
n = aDSqL(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0))
n = cONtENtTRaNScODiNG(n)
cONn.eXEcUTe("insert into "& dB_pREfIX &"webcolumn (webtitle,webkeywords,webdescription,columnname,columntype,sortrank,filename,flags,parentid,labletitle,simpleintroduction,bodycontent,npagesize,isonhtml,nofollow,target) values('" & o & "','" & p & "','" & q & "','" & e & "','" & cA & "'," & r & ",'" & m & "','" & z & "'," & j & ",'" & s & "','"& nA &"','" & n & "',"& eA &","& iSOnHTmL &","& gA &",'"& t &"')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"articledetail")
h = gETdIRtXTlISt("/Data/WebData/ArticleData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("����", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��title��") > 0 tHEn
d=d & vBCrLF
j = gETsTRcUT(d, "��parentid��", vBCrLF, 0)
j = gETcOLuMNiD(j)
f = aDSqL(gETsTRcUT(d, "��title��", vBCrLF, 0))
o = gETsTRcUT(d, "��webtitle��", vBCrLF, 0)
p = gETsTRcUT(d, "��webkeywords��", vBCrLF, 0)
q = gETsTRcUT(d, "��webdescription��", vBCrLF, 0)
k = gETsTRcUT(d, "��author��", vBCrLF, 0)
r = gETsTRcUT(d, "��sortrank��", vBCrLF, 0)
iF r = "" tHEn r = 0
l = gETsTRcUT(d, "��adddatetime��", vBCrLF, 0)
m = gETsTRcUT(d, "��filename��", vBCrLF, 0)
z = gETsTRcUT(d, "��flags��", vBCrLF, 0)
dA = gETsTRcUT(d, "��relatedtags��", vBCrLF, 0)
fA = aDSqL(gETsTRcUT(d, "��customaurl��", vBCrLF, 0))
t=gETsTRcUT(d, "��target��", vBCrLF, 0)
n = aDSqL(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0))
n = cONtENtTRaNScODiNG(n)
iSOnHTmL=pHPtRIm(gETsTRcUT(d, "��isonhtml��", vBCrLF, 0))
iF iSOnHTmL="0" oR lCAsE(iSOnHTmL)="false" tHEn
iSOnHTmL=0
eLSe
iSOnHTmL=1
eND iF
gA=pHPtRIm(gETsTRcUT(d, "��nofollow��", vBCrLF, 0))
iF gA="1" oR lCAsE(gA)="true" tHEn
gA=1
eLSe
gA=0
eND iF
cONn.eXEcUTe("insert into "& dB_pREfIX &"articledetail (parentid,title,webtitle,webkeywords,webdescription,author,sortrank,adddatetime,filename,flags,relatedtags,bodycontent,updatetime,isonhtml,customaurl,nofollow,target) values(" & j & ",'" & f & "','" & o & "','" & p & "','" & q & "','" & k & "'," & r & ",'" & l & "','" & m & "','"& z &"','"& dA &"','" & n & "','" & nOW() & "',"& iSOnHTmL &",'"& fA &"',"& gA & ",'"& t &"')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"OnePage")
h = gETdIRtXTlISt("/Data/WebData/OnePageData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("��ҳ", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��webkeywords��") > 0 tHEn
d=d & vBCrLF
f = aDSqL(gETsTRcUT(d, "��title��", vBCrLF, 0))
mA = aDSqL(gETsTRcUT(d, "��displaytitle��", vBCrLF, 0))
o = gETsTRcUT(d, "��webtitle��", vBCrLF, 0)
p = gETsTRcUT(d, "��webkeywords��", vBCrLF, 0)
q = gETsTRcUT(d, "��webdescription��", vBCrLF, 0)
l = gETsTRcUT(d, "��adddatetime��", vBCrLF, 0)
m = gETsTRcUT(d, "��filename��", vBCrLF, 0)
nA = aDSqL(gETsTRcUT(d, "��simpleintroduction��", "��/simpleintroduction��", 0))
nA = cONtENtTRaNScODiNG(nA)
t=gETsTRcUT(d, "��target��", vBCrLF, 0)
n = aDSqL(gETsTRcUT(d, "��bodycontent��", "��/bodycontent��", 0))
n = cONtENtTRaNScODiNG(n)
iSOnHTmL=pHPtRIm(gETsTRcUT(d, "��isonhtml��", vBCrLF, 0))
iF iSOnHTmL="0" oR lCAsE(iSOnHTmL)="false" tHEn
iSOnHTmL=0
eLSe
iSOnHTmL=1
eND iF
gA=pHPtRIm(gETsTRcUT(d, "��nofollow��", vBCrLF, 0))
iF gA="1" oR lCAsE(gA)="true" tHEn
gA=1
eLSe
gA=0
eND iF
cONn.eXEcUTe("insert into "& dB_pREfIX &"onepage (title,displaytitle,webtitle,webkeywords,webdescription,adddatetime,filename,isonhtml,simpleintroduction,bodycontent,nofollow,target) values('" & f & "','"& mA &"','"& o &"','"& p &"','"& q &"','"& l &"','"& m &"',"& iSOnHTmL &",'"& nA &"','"& n &"',"& gA &",'"& t &"')")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"Bidding")
h = gETdIRtXTlISt("/Data/WebData/BiddingData/")
b = sPLiT(h, vBCrLF)
cALl hR()
fOR eACh i iN b
m=gETfILeNAmE(i)
iF i <> "" aND iNStR("_#",lEFt(m,1))=fALsE tHEn
cALl eCHo("����", i)
h = gETfTExT(i)
bA = sPLiT(h, vBCrLF & "-------------------------------")
fOR eACh d iN bA
iF iNStR(d, "��webkeywords��") > 0 tHEn
p = gETsTRcUT(d, "��webkeywords��", vBCrLF, 0)
hA = gETsTRcUT(d, "��showreason��", vBCrLF, 0)
iA = gETsTRcUT(d, "��ncomputersearch��", vBCrLF, 0)
jA = gETsTRcUT(d, "��nmobliesearch��", vBCrLF, 0)
kA = gETsTRcUT(d, "��ncountsearch��", vBCrLF, 0)
lA = gETsTRcUT(d, "��ndegree��", vBCrLF, 0)
lA=gETnUMbER(lA)
iF lA="" tHEn
lA=0
eND iF
cONn.eXEcUTe("insert into "& dB_pREfIX &"Bidding (webkeywords,showreason,ncomputersearch,nmobliesearch,ndegree) values('" & p & "','"& hA &"',"& iA &","& jA &","& lA &")")
eND iF
nEXt
eND iF
nEXt
cONn.eXEcUTe("delete from "& dB_pREfIX &"TableComment")
eND sUB
fUNcTIoN cONtENtTRaNScODiNG(bYVaL a)
a = rEPlACe(rEPlACe(rEPlACe(rEPlACe(a, "<?", "&lt;?"), "?>", "?&gt;"), "<" & "%", "&lt;%"), "?>", "%&gt;")
iF iNStR(a, "[&htmlת��&]") > 0 tHEn
a = rEPlACe(rEPlACe(a, "[&htmlת��&]", ""), "<", "&lt;")
eND iF
iF iNStR(a, "[&ȫ������&]") > 0 tHEn
a = rEPlACe(rEPlACe(a, "[&ȫ������&]", ""), vBCrLF, vBCrLF & "<br>")
eND iF
cONtENtTRaNScODiNG=a
eND fUNcTIoN
%>

