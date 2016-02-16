<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-01-20
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<!--#iNClUDe fILe = "Config.Asp"-->
<%
sELeCT cASe rEQuESt("act")
cASe "SaveFile" : sAVeFIlE( rEQuESt("FilePath"))	
cASe "GetFunctionCode" : gETfUNcTIoNCoDE(rEQuESt("Lable"))	
cASe "SaveQQDialogue" : cALl sAVeQQdIAlOGuE()	
cASe "UserLogin" : cALl uSErLOgIN()						 	
cASe "UserReg" : cALl uSErREg()	
cASe "MobileArticleList" : cALl mOBiLEaRTiCLeLIsT()	
cASe "ShowArticleNumb" : cALl sHOwARtIClENuMB()	
cASe "SaveAJAXEdit" : cALl sAVeAJaXEdIT()	
cASe "SaveAJAXTEXTEdit" : cALl sAVeAJaXTeXTeDIt()	
cASe "DeleteAction" : cALl dELeTEaCTiON()	
cASe "showArticleList" : cALl sHOwARtIClELiST()	
eND sELeCT
fUNcTIoN sHOwARtIClELiST()
cALl oPEnCOnN()
dIM b,c,d,e
b=rQ("did")
e=hANdLEnUMbER(rQ("Numb")) 	
iF e<>"" tHEn
c = "select top "& e &" * from [product]"
eLSe	
c = "select * from [product]"
eND iF
iF b<>"" tHEn
c=c & " where BigClassName='"& b &"'"
eND iF
rS.oPEn c,cONn,1,1
dIM f : sET f = nEW cLS_AB_JSoN
cALl rW(f.tOJsON(rS))
rS.cLOsE
eND fUNcTIoN
fUNcTIoN sHOwARtIClELiST2()
cALl oPEnCOnN()
dIM b,c,d,e
b=rQ("did")
e=hANdLEnUMbER(rQ("Numb")) 	
iF e<>"" tHEn
c = "select top "& e &" * from [product]"
eLSe	
c = "select * from [product]"
eND iF
iF b<>"" tHEn
c=c & " where BigClassName='"& b &"'"
eND iF
rS.oPEn c,cONn,1,1
dIM f : sET f = nEW cLS_AB_JSoN
cALl rW(f.tOJsON(rS))
rS.cLOsE
eND fUNcTIoN
fUNcTIoN dELeTEaCTiON()
dIM c	
c=c & "MDBPath=" & rQ("MDBPath") & vBCrLF
c=c & "TableName=" & rQ("TableName") & vBCrLF
c=c & "FieldName=" & rQ("FieldName") & vBCrLF
c=c & "ID=" & rQ("ID") & vBCrLF
mDBpATh=rEQuESt("MDBPath")
cALl oPEnCOnN()
dIM c
c = "Select * From ["& rEQuESt("TableName") &"] Where Id=" & rEQuESt("Id")
rS.oPEn c,cONn,1,3
iF nOT rS.eOF tHEn
rS.dELeTE
rS.uPDaTE
cALl rW("删除ID【"& rEQuESt("Id") &"】成功")
eLSe	
cALl rW("ID【"& rEQuESt("Id") &"】不存在，删除失败")
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN sAVeAJaXEdIT()
dIM b
b=b & "MDBPath=" & rQ("MDBPath") & "("& iSNuL(rQ("MDBPath")) &")" & vBCrLF
b=b & "MDBPath=" & hANdLEpATh(rQ("MDBPath")) & vBCrLF
b=b & "TableName=" & rQ("TableName") & vBCrLF
b=b & "FieldName=" & rQ("FieldName") & vBCrLF
b=b & "Content=" & rQ("Content") & vBCrLF
b=b & "ID=" & rQ("ID") & vBCrLF
cALl rW("<pre>"& b &"</pre>"):dOEvENtS
cALl oPEnCOnN()
dIM c
c = "Select * From ["& rEQuESt("TableName") &"] Where Id=" & rEQuESt("Id")
rS.oPEn c,cONn,1,3
iF nOT rS.eOF tHEn
rS(rQ("FieldName")) = rEQuESt("Content")
rS.uPDaTE
eND iF:rS.cLOsE
eND fUNcTIoN
fUNcTIoN sAVeAJaXTeXTeDIt()
dIM c	
c=c & "FilePath=" & rQ("FilePath") & vBCrLF
c=c & "content=" & rEQuESt.fORm("content") & vBCrLF
c=c & "count=" & rEQuESt.fORm("count") & vBCrLF
cALl rW("<pre>"& c &"</pre>"):dOEvENtS
cALl cREaTEfILe(rEQuESt("FilePath"),rEQuESt("content"))
eND fUNcTIoN
sUB sHOwARtIClENuMB()
dIM b
b = rEQuESt("Id")
cALl oPEnCOnN()
rS.oPEn"Select * From [Product] Where Id=" & b,cONn,1,3
iF nOT rS.eOF tHEn
rS("Hits") = rS("Hits")+1
rS.uPDaTE
cALl rW(rS("Hits"))
eND iF:rS.cLOsE
eND sUB
sUB mOBiLEaRTiCLeLIsT()
dIM b,c,d,e
cALl oPEnCOnN()
iF sESsIOn("ShowMobileArticleNumb") = "" tHEn sESsIOn("ShowMobileArticleNumb")=12
d = 0
b=b & "<?xml version=""1.0"" encoding=""gb2312"" ?> " & vBCrLF
b=b & "<clists> " & vBCrLF
c = "Select * From [Product] Where BigClassName='信息中心' Order By Id Desc"
rS.oPEn c,cONn,1,1
fOR e =1 tO rS.rECoRDcOUnT
iF d>10 tHEn eXIt fOR
iF e > sESsIOn("ShowMobileArticleNumb") tHEn
d=d+1
b=b & "<clist id="""& rS("ID") &""" title="""& rS("Title") &""" image=""0"" time="""& rS("AddDateTime") &"""/>" & vBCrLF
eND iF
rS.mOVeNExT:nEXt:rS.cLOsE
sESsIOn("ShowMobileArticleNumb")=sESsIOn("ShowMobileArticleNumb")+d
b=b & "</clists>" & vBCrLF
cALl rW(b)
eND sUB
sUB uSErREg()
dIM b,c,d
b=rEPlACe(rEQuESt("UserName"),"'","")
c=rEPlACe(rEQuESt("PassWord"),"'","")
iF rEQuESt("P")="" tHEn
c = mD5(c,2) & mD5(c,4)
eND iF
d=rEPlACe(rEQuESt("Email"),"'","")	
rESpONsE.cOOkIEs("UserName")=b
rESpONsE.cOOkIEs("UserName").eXPiREs=dATe+10	
cALl oPEnCOnN()
rS.oPEn"Select * From [Member] Where UserName='"& b &"'",cONn,1,3
iF nOT rS.eOF tHEn
cALl rW("用户名已被注册")
eLSe
rS.cLOsE
rS.oPEn"Select * From [Member] Where Email='"& d &"'",cONn,1,3
iF nOT rS.eOF tHEn
cALl rW("邮箱已被注册")
eLSe
rS.aDDnEW
rS("UserName")=b
rS("Pwd")=c
rS("Email")=d
rS("MyMoney") = 100000
rS.uPDaTE
rESpONsE.cOOkIEs("PassWord")=c
rESpONsE.cOOkIEs("PassWord").eXPiREs=dATe+10
sESsIOn("Email")=rS("Email")
sESsIOn("MyMoney")=cLNg(rS("MyMoney"))
cALl rW("OK")
eND iF
rESpONsE.eND()
eND iF:rS.cLOsE
eND sUB
sUB uSErLOgIN()
dIM b,c,d
b=rEPlACe(rEQuESt("UserName"),"'","")
c=rEPlACe(rEQuESt("PassWord"),"'","")
iF rEQuESt("P")="" tHEn
c = mD5(c,2) & mD5(c,4)
eND iF
d=rEPlACe(rEQuESt("autologin"),"'","")
rESpONsE.cOOkIEs("UserName")=b
rESpONsE.cOOkIEs("UserName").eXPiREs=dATe+10
cALl oPEnCOnN()
rS.oPEn"Select * From [Member] Where UserName='"& b &"' Or Email='"& b &"'",cONn,1,3
iF rS.eOF tHEn
cALl rW("用户名不存在")
eLSe
iF rS("Pwd")<>c tHEn
cALl rW("密码不正确")
eLSe
rESpONsE.cOOkIEs("PassWord")=c
rESpONsE.cOOkIEs("PassWord").eXPiREs=dATe+10
sESsIOn("Email")=rS("Email")
sESsIOn("MyMoney")=cLNg(rS("MyMoney"))
cALl rW("OK")
eND iF
eND iF:rS.cLOsE
eND sUB
sUB sAVeQQdIAlOGuE()
dIM b,c
b = rEQuESt("QQ")
c = rEQuESt("ClickStyle")
cALl cREaTEaDDfILe("/QQ/QQ.txt","聊天QQ=" & b & "，样式=" & c & "，时间=" & fORmAT_TImE(nOW(),8))
cALl rW("保存QQ对话成功")
eND sUB
sUB gETfUNcTIoNCoDE(a)
dIM b
b = gETfTExT("FSO.Asp")
b = sTRcUT(b,"Function " & a,"End Function",1)
cALl rW(sHOwASpCOdECoLOr(b))
eND sUB
%>

