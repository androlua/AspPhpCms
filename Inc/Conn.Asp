<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-16
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
pUBlIC mDBpATh,aCCeSSpASs	
dIM dATaBAsETyPE	
dIM sQLsERvERhOStIP  	
dIM sQLsERvERdATaBAsENaME 	
dIM sQLsERvERuSErNAmE  	
dIM sQLsERvERpASsWOrD 	
pUBlIC sUB oPEnCOnN()
mDBpATh = aDMiNDiR &"/Data/Data.mdb"
dIM b
iF rEQuESt("MDBPath")<>"" aND iSNuL(rEQuESt("MDBPath"))=fALsE tHEn
mDBpATh=hANdLEpATh(rEQuESt("MDBPath"))
eND iF
iF mDBpATh<>"" tHEn	
iF iNStR(mDBpATh, ":") = 0 tHEn mDBpATh = sERvER.mAPpATh(rEPlACe(mDBpATh, "//", "/"))
sET cONn = cREaTEoBJeCT("Adodb.Connection")
cONn.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '"& aCCeSSpASs &"';Data Source = "& mDBpATh
eLSe	
iF dATaBAsETyPE = "SqlServerWebData" tHEn
sQLsERvERdATaBAsENaME = "WebData"
sQLsERvERuSErNAmE = "sa"
sQLsERvERpASsWOrD = "sa"
sQLsERvERhOStIP = ".\SQLEXPRESS"
eLSeIF dATaBAsETyPE = "SqlServerLocalData" tHEn
sQLsERvERdATaBAsENaME = "LocalData"
sQLsERvERuSErNAmE = "as"
sQLsERvERpASsWOrD = "as"
sQLsERvERhOStIP = "127.0.0.1,1433"
eLSeIF dATaBAsETyPE = "RemoteSqlServer" tHEn
sQLsERvERdATaBAsENaME = "qds0140159_db"
sQLsERvERuSErNAmE = "qds0140159": sQLsERvERpASsWOrD = "L4dN4eRd"
sQLsERvERhOStIP = "qds-014.hichina.com,1433"
eLSeIF dATaBAsETyPE = "RemoteSqlServer20150727" tHEn
sQLsERvERdATaBAsENaME = "qds157513275_db"
sQLsERvERuSErNAmE = "qds157513275": sQLsERvERpASsWOrD = "313801120"
sQLsERvERhOStIP = "qds157513275.my3w.com,1433"
cALl eCHo("","11")
eLSeIF sQLsERvERdATaBAsENaME<>"" tHEn
sQLsERvERhOStIP = "127.0.0.1,1433"
eND iF
b = " Password = " & sQLsERvERpASsWOrD & "; user id =" & sQLsERvERuSErNAmE & "; Initial Catalog =" & sQLsERvERdATaBAsENaME & "; data source =" & sQLsERvERhOStIP & ";Provider = sqloledb;"
sET cONn = cREaTEoBJeCT("Adodb.Connection")
cONn.oPEn b
eND iF
iF tYPeNAmE(rS) <> "Recordset" tHEn
sET rS = cREaTEoBJeCT("Adodb.RecordSet")
sET rSX = cREaTEoBJeCT("Adodb.RecordSet")
sET rSS = cREaTEoBJeCT("Adodb.RecordSet")
sET rST = cREaTEoBJeCT("Adodb.Recordset")
sET rSD = cREaTEoBJeCT("Adodb.Recordset")
sET tEMpRS = cREaTEoBJeCT("Adodb.RecordSet")
sET tEMpRS2 = cREaTEoBJeCT("Adodb.RecordSet")
sET rSTeMP = cREaTEoBJeCT("Adodb.RecordSet")	
eND iF
eND sUB
fUNcTIoN cLOsECoNN()
oN eRRoR rESuME nEXt
cONn.cLOsE
sET cONn = nOThINg
eND fUNcTIoN
fUNcTIoN gETaCCeSScONn(a,b,c)
b=hANdLEpATh(rEQuESt("ThisMDBPath"))
sET a = cREaTEoBJeCT("Adodb.Connection")
a.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '"& c &"';Data Source = "& b
gETaCCeSScONn = a
eND fUNcTIoN
%>


