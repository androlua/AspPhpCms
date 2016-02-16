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
fUNcTIoN hANdLEaCCeSSdATa(bYVaL a)
hANdLEaCCeSSdATa = rEPlACe(a, "'", "''")
eND fUNcTIoN
fUNcTIoN aDSqL(a)
aDSqL = hANdLEaCCeSSdATa(a)
eND fUNcTIoN
fUNcTIoN cHEcKAcCEsSPaSS(a, b)
oN eRRoR rESuME nEXt
dIM c
cHEcKAcCEsSPaSS = tRUe
sET c = cREaTEoBJeCT("Adodb.Connection")
c.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '" & b & "';Data Source = " & a
c.cLOsE
iF eRR <> 0 tHEn
eRR.cLSoE
cHEcKAcCEsSPaSS = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKSqL(a)
oN eRRoR rESuME nEXt
cONn.eXEcUTe(a)
cHEcKSqL = iIF(eRR = 0, tRUe, fALsE)
eND fUNcTIoN
fUNcTIoN cREaTEtABlE(a)
dIM b
iF cHEcKSqL(a) = fALsE tHEn
b = "Create Table " & a & " (Id int Identity(0,1) Primary Key)"
cONn.eXEcUTe(b)
cREaTEtABlE = tRUe
eLSe
cREaTEtABlE = fALsE
eND iF
eND fUNcTIoN
fUNcTIoN sHOwIStABlE(a)
sHOwIStABlE = eXIsTStABlE(a)
iF sHOwIStABlE = fALsE tHEn
cALl rW("创建表[" & a & "]成功√<br>")
eLSe
cALl rW("表[" & a & "]已经存在<br>")
eND iF
eND fUNcTIoN
fUNcTIoN gETrECoRDcOUnT(a, b)
cALl oPEnCOnN()
gETrECoRDcOUnT = cONn.eXEcUTe("Select Count(*) From [" & a & "] " & b)(0)
eND fUNcTIoN
fUNcTIoN tABlECoUNt(a, b)
tABlECoUNt = gETrECoRDcOUnT(a, b)
eND fUNcTIoN
fUNcTIoN oPEnTAbLE(a, b)
rS.oPEn "Select * From [" & a & "] " & b, cONn, 1, 1
eND fUNcTIoN
fUNcTIoN iNSeRTtABlE(a, b, c)
cONn.eXEcUTe("Insert Into[" & a & "](" & b & ") Values('" & c & "')")
eND fUNcTIoN
fUNcTIoN gETtABlETeXT(a, b, c)
oN eRRoR rESuME nEXt
gETtABlETeXT = cONn.eXEcUTe("Select " & b & " From [" & a & "]" & c)(0)
iF eRR.nUMbER <> 0 tHEn cALl eERr("出错了", a & "-" & b & "-" & c)
eND fUNcTIoN
fUNcTIoN cREaTEmDB(a)
dIM b
sET b = cREaTEoBJeCT("ADOX.Catalog")
b.cREaTE("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & a)
cALl rW("创建数据库[" & a & "]成功√<br>" & vBCrLF)
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN dELeTEtABlE(a)
a = tRIm(a)
dELeTEtABlE = fALsE
iF a = "" tHEn
eXIt fUNcTIoN
eND iF
iF cHEcKTaBLe(a) tHEn
dELeTEtABlE = tRUe
eND iF
eND fUNcTIoN
fUNcTIoN dELeTEaLLtABlE(a)
dIM b, c, d
b = sPLiT(a, vBCrLF)
fOR eACh c iN b
iF d <> "" tHEn d = d & vBCrLF
d = d & "删除表【" & c & "】" & dELeTEtABlE(c)
nEXt
dELeTEaLLtABlE = d
eND fUNcTIoN
fUNcTIoN cHEcKTaBLe(a)
oN eRRoR rESuME nEXt
cONn.eXEcUTe("Select * From [" & a & "]")
iF nOT eRR.nUMbER = 0 tHEn
eRR.cLEaR
cHEcKTaBLe = fALsE
eLSe
cHEcKTaBLe = tRUe
eND iF
eND fUNcTIoN
fUNcTIoN eXIsTStABlE(a)
eXIsTStABlE = cHEcKTaBLe(a)
eND fUNcTIoN
fUNcTIoN eDItTAbLE(a, b, c)
dIM d, e, f
eDItTAbLE = fALsE
iF cHEcKTaBLe(b) aND cHEcKTaBLe(c) = fALsE tHEn
d = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & a
sET e = cREaTEoBJeCT("ADOX.Catalog")
e.aCTiVEcONnECtIOn = d
sET f = cREaTEoBJeCT("ADOX.Table")
sET f = e.tABlES(b)
f.nAMe = c
sET e = nOThINg
sET f = nOThINg
eDItTAbLE = tRUe
sET e = nOThINg
eND iF
eND fUNcTIoN
fUNcTIoN cHEcKFiELd(a, b)
cHEcKFiELd = fALsE
iF cHEcKTaBLe(a) tHEn
oN eRRoR rESuME nEXt
cONn.eXEcUTe("Select " & b & " From [" & a & "]")
iF nOT eRR.nUMbER = 0 tHEn
eRR.cLEaR
cHEcKFiELd = fALsE
eLSe
cHEcKFiELd = tRUe
eND iF
eRR.cLEaR
eND iF
eND fUNcTIoN
fUNcTIoN eXIsTSfIElD(a, b)
eXIsTSfIElD = cHEcKFiELd(a, b)
eND fUNcTIoN
fUNcTIoN eDItFIeLD(a, b, c)
dIM d
eDItFIeLD = fALsE
iF cHEcKTaBLe(a) tHEn
iF cHEcKFiELd(a, c) = fALsE aND cHEcKFiELd(a, b) tHEn
d = gETfIElDAlT(a, b)
iF d <> "" tHEn
cONn.eXEcUTe("Alter Table [" & a & "] Add [" & c & "] " & d & "")
cONn.eXEcUTe("Update [" & a & "] Set " & c & "=[" & b & "]")
cONn.eXEcUTe("Alter Table [" & a & "] Drop [" & b & "]")
eND iF
iF eRR.nUMbER <> 0 tHEn mSGbOX(a & vBCrLF & b & vBCrLF & c & "类型" & d)
eND iF
eND iF
eND fUNcTIoN
fUNcTIoN gETfIElDAlT(a, b)
dIM c, d, e, f
sET f = cREaTEoBJeCT("Adodb.RecordSet")
f.oPEn "Select * From [" & a & "]", cONn, 1, 1
d = f.fIElDS.cOUnT
fOR c = 1 tO d - 1
sET e = f.fIElDS.iTEm(c)
iF b = e.nAMe tHEn
sELeCT cASe f.fIElDS(c).tYPe
cASe "202"
gETfIElDAlT = "VarChar"
cASe "203"
gETfIElDAlT = "Text"
cASe "7"
gETfIElDAlT = "DateTime"
cASe "3"
gETfIElDAlT = "Int"
cASe "11"
gETfIElDAlT = "YesNo"
cASe eLSe
mSGbOX(f.fIElDS(c).tYPe & vBCrLF & tABlE & "没有类型")
gETfIElDAlT = "没类型" & f.fIElDS(c).tYPe
eND sELeCT
eXIt fOR
eND iF
sET e = nOThINg
nEXt : f.cLOsE
eND fUNcTIoN
fUNcTIoN gETtABlELiST_COnN(a)
dIM b, c
sET rS = a.oPEnSChEMa(20)
rS.mOVeFIrST
dO uNTiL rS.eOF
iF rS("TABLE_TYPE") = "TABLE" tHEn
b = rS("TABLE_NAME")
iF c <> "" tHEn c = c & vBCrLF
c = c & b
eND iF
rS.mOVeNExT
lOOp
gETtABlELiST_COnN = c
eND fUNcTIoN
fUNcTIoN gETtABlELiST()
gETtABlELiST = gETtABlELiST_COnN(cONn)
eND fUNcTIoN
fUNcTIoN gETfIElDLiST(a)
dIM b, c, d, e
oN eRRoR rESuME nEXt
tEMpRS.oPEn "Select * From [" & a & "]", cONn, 1, 1
iF tEMpRS.fIElDS.cOUnT = 0 tHEn eXIt fUNcTIoN
b = tEMpRS.fIElDS.cOUnT
iF eRR <> 0 tHEn cALl eERr("字段", tEMpRS.fIElDS.cOUnT)
c = ","
fOR e = 1 tO b - 1
sET d = tEMpRS.fIElDS.iTEm(e)
c = c & d.nAMe & ","
sET d = nOThINg
nEXt : tEMpRS.cLOsE
gETfIElDLiST = c
eND fUNcTIoN
fUNcTIoN gETdIFfEReNTtABlEFiELdLIsT(a, b)
dIM c, d, e, f
iF tYPeNAmE(a) = "Connection" tHEn
sET cONn = cREaTEoBJeCT("Adodb.Connection")
cONn.oPEn(a)
eND iF
rS.oPEn "Select * From [" & b & "]", cONn, 1, 1
c = rS.fIElDS.cOUnT
d = ","
fOR f = 1 tO c - 1
sET e = rS.fIElDS.iTEm(f)
d = d & e.nAMe & ","
sET e = nOThINg
nEXt : rS.cLOsE
gETdIFfEReNTtABlEFiELdLIsT = d
eND fUNcTIoN
fUNcTIoN cOMpACtDB(a, b)
dIM c, d, e, f
e = lEFt(a, iNStRReV(a, "\"))
sET c = cREaTEoBJeCT("Scripting.FileSystemObject")
iF c.fILeEXiSTs(a) tHEn
c.cOPyFIlE a, e & "temp.mdb"
sET d = cREaTEoBJeCT("JRO.JetEngine")
iF b = tRUe tHEn
d.cOMpACtDAtABaSE "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp.mdb", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp1.mdb;" & "Jet OLEDB:Engine Type=" & f
eLSe
d.cOMpACtDAtABaSE "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp.mdb", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & e & "temp1.mdb"
eND iF
c.cOPyFIlE e & "temp1.mdb", a
c.dELeTEfILe(e & "temp.mdb")
c.dELeTEfILe(e & "temp1.mdb")
sET d = nOThINg
cOMpACtDB = "<font color=#FF0000><b>你的数据库, " & a & ", 已经压缩成功!</b></font>" & vBCrLF
eLSe
cOMpACtDB = "<font color=#FF0000><b>数据库名称或路径不正确. 请重试!</b></font>" & vBCrLF
eND iF
sET c = nOThINg
eND fUNcTIoN
fUNcTIoN eDItACcESsPAsSWoRD(a, b, c)
dIM d, e
sET e = cREaTEoBJeCT("JRO.JetEngine")
cALl hANdLEpATh(a)
d = "Test_News.Mdb"
cALl hANdLEpATh(d)
cALl dELeTEfILe(d)
oN eRRoR rESuME nEXt
e.cOMpACtDAtABaSE "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & a & ";Jet OLEDB:Database Password=" & b, "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & d & ";Jet OLEDB:Database Password=" & c
iF eRR.nUMbER <> 0 tHEn eDItACcESsPAsSWoRD = "密码错误" : eRR.cLEaR : eXIt fUNcTIoN
cALl dELeTEfILe(a)
cALl mOVeFIlE(d, a)
eDItACcESsPAsSWoRD = "修改成功，新密码为[" & c & "]"
sET e = nOThINg
eND fUNcTIoN
fUNcTIoN hANdLEsQLsERvER(bYVaL a)
dIM b, c, d, e, f, g
g = sPLiT(a, ",")
fOR eACh a iN g
a = rEPlACe(a, """""", "''")
a = rEPlACe(a, "''''", "''")
a = rEPlACe(a, "Date()", "GetDate()")
a = rEPlACe(a, "Now()", "GetDate()")
a = rEPlACe(a, "YesNo Default Yes", " Bit Default 'true'")
a = rEPlACe(a, "YesNo Default No", " Bit Default 'false'")
a = rEPlACe(a, " YesNo", "  Bit Default 'true'")
iF iNStR(a, "YesNo") > 0 tHEn
cALl eERr("Content", a)
eND iF
fOR b = 1 tO lEN(a)
c = mID(a, b, 1)
iF c = " " tHEn
d = lCAsE(mID(a, b + 1, 7))
e = lCAsE(mID(a, b + 1, 8))
iF d = "varchar" aND e <> "varchar(" tHEn
f = f & " VarChar(255)"
b = b + 7
eLSe
f = f & c
eND iF
eLSe
f = f & c
eND iF
nEXt
f = f & ","
nEXt
iF f <> "" tHEn f = lEFt(f, lEN(f) - 1)
hANdLEsQLsERvER = f
eND fUNcTIoN
sUB eXPoRTtOExCEl(a)
rESpONsE.cONtENtTYpE = "application/vnd.ms-Excel"
rESpONsE.aDDhEAdER "Content-Disposition", "attachment;Filename=Results.xls"
rESpONsE.wRItE("<body>") & vBCrLF
rESpONsE.wRItE(a) & vBCrLF
rESpONsE.wRItE("</body>") & vBCrLF
rESpONsE.wRItE("</html>") & vBCrLF
eND sUB
sUB iMPoRTtODaTAbASe()
dIM b, c, d
b = sERvER.mAPpATh("1.xls")
sET c = cREaTEoBJeCT("Adodb.Connection")
c.oPEn "Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=Excel 8.0;Data Source=" & b
sET d = cREaTEoBJeCT("Adodb.RecordSet")
dIM e, f, g
e = sERvER.mAPpATh(""& aDMiNDiR &"Data/Data.mdb")
sET f = cREaTEoBJeCT("Adodb.Connection")
f.oPEn "Provider = Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database PassWord = '';Data Source = " & e
sET g = cREaTEoBJeCT("Adodb.RecordSet")
dIM h, i, j, k
d.oPEn "Select * From [Excel$]", c, 1, 1
h = d.fIElDS.cOUnT
fOR i = 1 tO h - 1
sET j = d.fIElDS.iTEm(i)
k = k & j.nAMe & ","
sET j = nOThINg
nEXt : d.cLOsE
cALl eCHo("xlsFieldList", k)
dIM l, m
l = sPLiT(k, ",")
d.oPEn "Select * From [Excel$]", c, 1, 1
cALl eCHo("xls里数据有", d.rECoRDcOUnT)
wHIlE nOT d.eOF
g.oPEn "Select * From [Product]", f, 1, 3
g.aDDnEW
fOR eACh m iN l
m = tRIm(m)
iF m <> "" tHEn
cALl eCHo("显示字段", m)
dOEvENtS
g(m) = d(m)
eND iF
nEXt
cALl eCHo("添加记录", "")
g.uPDaTE : g.cLOsE
d.mOVeNExT : wENd : d.cLOsE
eND sUB
fUNcTIoN gETdATaTAbLElISt(a, b)
dIM c, d, e, f, g
f = f & "<table width=""100%"" border=""1"" cellspacing=""0"" cellpadding=""0"">" & vBCrLF
c = gETfIElDLiST(a)
d = sPLiT(c, ",")
f = f & "  <tr>" & vBCrLF
fOR e = 1 tO uBOuND(d) - 1
f = f & "    <td>" & d(e) & "</td>" & vBCrLF
nEXt
f = f & "  </tr>" & vBCrLF
rS.oPEn "Select * From [" & a & "] " & b, cONn, 1, 1
wHIlE nOT rS.eOF
f = f & "  <tr>" & vBCrLF
fOR eACh g iN d
iF g <> "" tHEn
f = f & "    <td>" & rS(g) & "</td>" & vBCrLF
eND iF
nEXt
f = f & "  </tr>" & vBCrLF
rS.mOVeNExT : wENd : rS.cLOsE
f = f & "</table>" & vBCrLF
gETdATaTAbLElISt = f
eND fUNcTIoN
fUNcTIoN sETtABlEFiELd(a, b)
dIM c, d, e, f, g, h, i, j
c = sPLiT(b, "|")
fOR e = 0 tO uBOuND(c)
f = c(e)
iF f <> "" tHEn
d = sPLiT(f, ",")
h = d(0)
i = d(1)
oN eRRoR rESuME nEXt
j = "alter table " & h & " add column " & i & " " & d(2) & ""
a.eXEcUTe j
iF eRR.nUMbER = 0 tHEn
g = g & "[表" & h & "]【字段" & i & "】添加新字段成功<hr>" & vBCrLF
eLSe
eRR.cLOsE
g = g & "[表" & h & "]【字段" & i & "】添加失败<hr>" & vBCrLF
eND iF
eND iF
nEXt
sETtABlEFiELd = g
eND fUNcTIoN
fUNcTIoN gETtYPeSTrINg(a)
sELeCT cASe a
cASe 0 : gETtYPeSTrINg = "Empty"
cASe 16 : gETtYPeSTrINg = "TinyInt"
cASe 2 : gETtYPeSTrINg = "SmallInt"
cASe 3 : gETtYPeSTrINg = "Int"
cASe 20 : gETtYPeSTrINg = "BigInt"
cASe 17 : gETtYPeSTrINg = "UnsignedTinyInt"
cASe 18 : gETtYPeSTrINg = "UnsignedSmallInt"
cASe 19 : gETtYPeSTrINg = "UnsignedInt"
cASe 21 : gETtYPeSTrINg = "UnsignedBigInt"
cASe 4 : gETtYPeSTrINg = "Single"
cASe 5 : gETtYPeSTrINg = "Double"
cASe 6 : gETtYPeSTrINg = "Currency"
cASe 14 : gETtYPeSTrINg = "Decimal"
cASe 131 : gETtYPeSTrINg = "Numeric"
cASe 11 : gETtYPeSTrINg = "Bit"
cASe 10 : gETtYPeSTrINg = "Error"
cASe 132 : gETtYPeSTrINg = "UserDefined"
cASe 12 : gETtYPeSTrINg = "Variant"
cASe 9 : gETtYPeSTrINg = "IDispatch"
cASe 13 : gETtYPeSTrINg = "IUnknown"
cASe 72 : gETtYPeSTrINg = "GUID"
cASe 7 : gETtYPeSTrINg = "Date"
cASe 133 : gETtYPeSTrINg = "DBDate"
cASe 134 : gETtYPeSTrINg = "DBTime"
cASe 135 : gETtYPeSTrINg = "Datetime"
cASe 8 : gETtYPeSTrINg = "BSTR"
cASe 129 : gETtYPeSTrINg = "Char"
cASe 200 : gETtYPeSTrINg = "VarChar"
cASe 201 : gETtYPeSTrINg = "LongVarChar"
cASe 130 : gETtYPeSTrINg = "WChar"
cASe 202 : gETtYPeSTrINg = "Text"
cASe 203 : gETtYPeSTrINg = "Memo"
cASe 128 : gETtYPeSTrINg = "Binary"
cASe 204 : gETtYPeSTrINg = "VarBinary"
cASe 205 : gETtYPeSTrINg = "LongVarBinary"
cASe eLSe : gETtYPeSTrINg = "Unknown Type"
eND sELeCT
eND fUNcTIoN
fUNcTIoN gETpROdUCtRNdIDlISt(a, b)
dIM c, d, e, f, g, h, i, j
c = a.rECoRDcOUnT
b = cINt(b)
h = 0
rANdOMiZE tIMeR
fOR e = 1 tO 3
fOR d = 1 tO c
i = iNT(rND * c + 1)
iF iNStR("," & f & ",", "," & i & ",") = fALsE tHEn
f = f & i & ","
h = h + 1
iF h >= b tHEn
eXIt fOR
eND iF
eND iF
nEXt
iF h >= b tHEn eXIt fOR
nEXt
j = sPLiT(f, ",")
fOR d = 1 tO c
iF iNStR("," & f & ",", "," & d & ",") > 0 tHEn
g = g & a(0) & ","
eND iF
a.mOVeNExT : nEXt
iF g <> "" tHEn g = lEFt(g, lEN(g) - 1)
gETpROdUCtRNdIDlISt = g
eND fUNcTIoN
fUNcTIoN gETfIElDVaLUe(a, b, c)
dIM d
cALl oPEnCOnN()
sET d = cREaTEoBJeCT("Adodb.RecordSet")
d.oPEn "Select * From [" & a & "] " & c, cONn, 1, 1
iF nOT d.eOF tHEn
gETfIElDVaLUe = d(b)
eND iF : d.cLOsE
eND fUNcTIoN
fUNcTIoN gETcONnFIeLDvALuE(a, b, c, d)
oN eRRoR rESuME nEXt
dIM e
sET e = cREaTEoBJeCT("Adodb.RecordSet")
e.oPEn "Select * From [" & b & "] " & d, a, 1, 1
iF nOT e.eOF tHEn
gETcONnFIeLDvALuE = e(c)
eND iF : e.cLOsE
iF eRR <> 0 tHEn cALl eERr(b, c)
eND fUNcTIoN
fUNcTIoN sETfIElDVaLUe(a, b, c, d)
dIM e
cALl oPEnCOnN()
sETfIElDVaLUe = fALsE
sET e = cREaTEoBJeCT("Adodb.RecordSet")
e.oPEn "Select * From [" & a & "] " & d, cONn, 1, 3
iF nOT e.eOF tHEn
e(b) = c
e.uPDaTE
sETfIElDVaLUe = tRUe
eND iF : e.cLOsE
eND fUNcTIoN
fUNcTIoN fILeBInARyADdACcESs(a, b, c, d, e, f)
dIM g, h
sET h = cREaTEoBJeCT("Adodb.RecordSet")
g = "Select " & c & " From [" & b & "]"
g = gETwHErEAnD(g, e)
iF d <> "" tHEn
g = gETwHErEAnD(g, "Where Id=" & d)
eND iF
h.oPEn g, a, 1, 3
iF nOT h.eOF tHEn
h(c).aPPeNDcHUnK gETfILeBInARyCOnTEnT(f)
h.uPDaTE
eND iF : h.cLOsE
eND fUNcTIoN
fUNcTIoN sHOwACcESsSTrEAm(a, b, c, d, e)
dIM f, g
sET g = cREaTEoBJeCT("Adodb.RecordSet")
f = "Select " & c & " From [" & b & "]"
f = gETwHErEAnD(f, e)
iF d <> "" tHEn
f = gETwHErEAnD(f, "Where Id=" & d)
eND iF
g.oPEn f, a, 1, 3
iF nOT g.eOF tHEn
rESpONsE.bINaRYwRItE g(c).gETcHUnK(7500000)
eND iF : g.cLOsE
eND fUNcTIoN
%>


