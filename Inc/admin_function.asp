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
fUNcTIoN fLAgSArTIcLEdETaIL(a)
dIM b
iF iNStR("|" & a & "|", "|h|") > 0 tHEn
b = b & "头"
eND iF
iF iNStR("|" & a & "|", "|c|") > 0 tHEn
b = b & "推 "
eND iF
iF iNStR("|" & a & "|", "|f|") > 0 tHEn
b = b & "幻 "
eND iF
iF iNStR("|" & a & "|", "|a|") > 0 tHEn
b = b & "特 "
eND iF
iF iNStR("|" & a & "|", "|s|") > 0 tHEn
b = b & "滚 "
eND iF
iF iNStR("|" & a & "|", "|b|") > 0 tHEn
b = b & "粗 "
eND iF
iF b <> "" tHEn b = "[<font color=""red"">" & b & "</font>]"
fLAgSArTIcLEdETaIL = b
eND fUNcTIoN
fUNcTIoN gETtITlESeTCoLOrHTmL(a)
dIM b
b = "<script language=""javascript"" type=""text/javascript"" src=""js/colorpicker.js""></script>" & vBCrLF
b = b & "<img src=""images/colour.png"" width=""15"" height=""16"" onclick=""colorpicker('title_colorpanel','set_title_color');"" style=""cursor:hand"">" & vBCrLF
b = b & "<span id=""title_colorpanel"" style=""position:absolute; z-index:200"" class=""colorpanel""></span>" & vBCrLF
b = b & "<img src=""images/bold.png"" width=""10"" height=""10"" onclick=""input_font_bold()"" style=""cursor:hand"">" & vBCrLF
gETtITlESeTCoLOrHTmL = b
eND fUNcTIoN
fUNcTIoN sHOwCOlUMnLIsT(bYVaL a, bYVaL b, c, bYVaL d)
dIM e, f, g, h, i
dIM j : sET j = cREaTEoBJeCT("Adodb.RecordSet")
j.oPEn "select * from " & dB_pREfIX & "webcolumn where parentid=" & a & "  order by sortrank asc", cONn, 1, 1
wHIlE nOT j.eOF
h = ""
iF cSTr(j("id")) = cSTr(b) tHEn
h = " selected "
eND iF
e = d
e = rEPlACeVAlUEpARaM(e, "sortrank", j("sortrank"))
e = rEPlACeVAlUEpARaM(e, "id", j("id"))
e = rEPlACeVAlUEpARaM(e, "parentid", j("parentid"))
e = rEPlACeVAlUEpARaM(e, "selected", h)
g = j("columnname")
iF c >= 1 tHEn
g = cOPySTr("&nbsp;&nbsp;", c) & "├─" & g
eND iF
e = rEPlACeVAlUEpARaM(e, "columnname", g)
e = rEPlACeVAlUEpARaM(e, "columntype", j("columntype"))
e = rEPlACeVAlUEpARaM(e, "flags", j("flags"))
e = rEPlACeVAlUEpARaM(e, "ishtml", j("ishtml"))
e = rEPlACeVAlUEpARaM(e, "isonhtml", j("isonhtml"))
i = "../index.asp?act=nav&columnName=" & g
iF tRIm(j("customaurl")) <> "" tHEn
i = tRIm(j("customaurl"))
eND iF
e = rEPlACe(e, "[$viewWeb$]", i)
iF eDItORtYPe = "php" tHEn
e = rEPlACe(e, "[$phpArray$]", "[]")
eLSe
e = rEPlACe(e, "[$phpArray$]", "")
eND iF
f = f & e & vBCrLF
f = f & sHOwCOlUMnLIsT(j("id"), b, c + 1, d)
j.mOVeNExT : wENd : j.cLOsE
sHOwCOlUMnLIsT = f
eND fUNcTIoN
fUNcTIoN gETmSG1(a, b)
dIM c
c = gETfTExT(rOOt_PaTH & "msg.html")
a = a & "<br>" & jSTiMInG(b, 5)
c = rEPlACe(c, "[$msgStr$]", a)
c = rEPlACe(c, "[$url$]", b)
gETmSG1 = c
eND fUNcTIoN
fUNcTIoN cOLuMNlISt(a, b)
dIM c, d
dIM e : sET e = cREaTEoBJeCT("Adodb.RecordSet")
e.oPEn "select * from " & dB_pREfIX & "webcolumn where parentid=" & a, cONn, 1, 1
wHIlE nOT e.eOF
cALl eCHo(cOPySTr("====", b) & e("id"), e("columnname"))
cALl cOLuMNlISt(e("id"), b + 1)
e.mOVeNExT : wENd : e.cLOsE
eND fUNcTIoN
sUB dISpALyMAnAGe(a, b, bYVaL c, d, e)
cALl lOAdWEbCOnFIg()
dIM f, g, h, i, j
dIM k, l, m, n
dIM o
dIM p, q, r
dIM s
dIM t
dIM u
dIM v
dIM w
p = lCAsE(a)
u = rEQuESt("keyword")
v = rEQuESt("parentid")
dIM x
x = rQ("id")
iF c = "*" tHEn
c = lCAsE(gETfIElDLiST(dB_pREfIX & p))
eND iF
c = sPEcIAlSTrREpLAcE(c)
t = sPLiT(c, ",")
f = gETfTExT(rOOt_PaTH & "manage" & a & ".html")
f = rEPlACe(f, "{$Web_Title$}", cFG_WEbTItLE)
f = rEPlACe(f, "{$position$}", "系统管理 > " & b & "列表")
f = rEPlACe(f, "{$actionName$}", a)
f = rEPlACe(f, "{$lableTitle$}", b)
f = rEPlACe(f, "{$tableName$}", p)
f = rEPlACe(f, "{$keyword$}", u)
f = rEPlACe(f, "{$parentid$}", rEQuESt("parentid"))
f = rEPlACe(f, "{$nPageSize$}", d)
f = rEPlACe(f, "{$page$}", rEQuESt("page"))
f = rEPlACe(f, "{$nPageSize" & d & "$}", " selected")
fOR h = 1 tO 9
f = rEPlACe(f, "{$nPageSize" & h & "0$}", "")
nEXt
g = gETsTRcUT(f, "[list]", "[/list]", 2)
iF a = "WebColumn" tHEn
f = rEPlACe(f, "[list]" & g & "[/list]", sHOwCOlUMnLIsT( -1, "", 0, g))
eLSe
iF "ASP" = "ASP" tHEn
iF u <> "" tHEn
e = gETwHErEAnD(" where title like '%" & u & "%' ", e)
eND iF
iF v <> "" tHEn
e = gETwHErEAnD(" where parentid=" & v & " ", e)
eND iF
rS.oPEn "select * from " & dB_pREfIX & p & " " & e, cONn, 1, 1
m = rS.rECoRDcOUnT
n = rEQuESt("page")
k = gETrSPaGEnUMbER(rS, m, d, n)
fOR h = 1 tO k
i = rEPlACe(g, "[$id$]", rS("id"))
fOR q = 0 tO uBOuND(t)
iF t(q) <> "" tHEn
r = sPLiT(t(q) & "|||", "|")
s = r(0)
w = rS(s) & ""
iF a = "ArticleDetail" aND s = "flags" tHEn
w = fLAgSArTIcLEdETaIL(w)
eND iF
i = rEPlACeVAlUEpARaM(i, s, w)
eND iF
nEXt
o = "id"
i = rEPlACe(i, "[$selectid$]", "<input type='checkbox' name='" & o & "' id='" & o & "' value='" & rS("id") & "' >")
i = rEPlACe(i, "[$phpArray$]", "")
l = "【NO】"
iF a = "ArticleDetail" tHEn
l = "../index.asp?act=detail&id=" & rS("id")
eLSeIF a = "OnePage" tHEn
l = "../index.asp?act=onepage&id=" & rS("id")
eLSeIF a = "TableComment" tHEn
l = "../index.asp?act=detail&id=" & rS("itemid")
eND iF
iF iNStR(c, "customaurl") > 0 tHEn
iF tRIm(rS("customaurl")) <> "" tHEn
l = tRIm(rS("customaurl"))
eND iF
eND iF
i = rEPlACe(i, "[$viewWeb$]", l)
j = j & i
rS.mOVeNExT : nEXt : rS.cLOsE
f = rEPlACe(f, "[list]" & g & "[/list]", j)
l = gETuRLaDDtOPaRAm(gETuRL(), "?page=[id]", "replace")
f = rEPlACe(f, "[$pageInfo$]", wEBpAGeCOnTRoL(m, d, n, l))
eLSe
iF u <> "" tHEn
e = " where title like '%" & u & "%'" & e
eND iF
rS.oPEn "select * from " & p & " " & e, cONn, 1, 1
m = rS.rECoRDcOUnT
n = rEQuESt("page")
l = gETuRLaDDtOPaRAm(gETuRL(), "?page=[id]", "replace")
f = rEPlACe(f, "[$pageInfo$]", wEBpAGeCOnTRoL(m, d, n, l))
iF n <> "" tHEn
n = n - 1
eND iF
rS.oPEn "select * from " & dB_pREfIX & "" & p & " " & e & " limit " & d * n & "," & d & "", cONn, 1, 1
wHIlE nOT rS.eOF
i = rEPlACe(g, "[$id$]", rS("id"))
i = rEPlACe(i, "[$phpArray$]", "")
fOR q = 0 tO uBOuND(t)
iF t(q) <> "" tHEn
r = sPLiT(t(q) & "|||", "|")
s = r(0)
w = rS(s) & ""
iF a = "ArticleDetail" aND s = "flags" tHEn
w = fLAgSArTIcLEdETaIL(w)
eND iF
i = rEPlACeVAlUEpARaM(i, s, w)
eND iF
nEXt
o = "id"
i = rEPlACe(i, "[$selectid$]", "<input type='checkbox' name='" & o & "' id='" & o & "' value='" & rS("id") & "' >")
i = rEPlACe(i, "[$phpArray$]", "")
iF a = "ArticleDetail" tHEn
l = "../phpweb.php?act=detail&id=" & rS("id")
iF tRIm(rS("customaurl")) <> "" tHEn
l = tRIm(rS("customaurl"))
eND iF
i = rEPlACe(i, "[$viewWeb$]", l)
eND iF
j = j & i
rS.mOVeNExT : wENd : rS.cLOsE
f = rEPlACe(f, "[list]" & g & "[/list]", j)
eND iF
eND iF
iF iNStR(f, "[$input_parentid$]") > 0 tHEn
g = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>"
j = "<select name=""parentid"" id=""parentid""><option value="""">≡ 选择栏目 ≡</option>" & sHOwCOlUMnLIsT( -1, v, 0, g) & vBCrLF & "</select>"
f = rEPlACe(f, "[$input_parentid$]", j)
eND iF
f = rEPlACe(f, "{$EDITORTYPE$}", eDItORtYPe)
f = f & sTAt2016(tRUe)
cALl rW(f)
eND sUB
sUB aDDeDItDIsPLaY(a, b, bYVaL c)
dIM d, e, f, g, h, i, j, k, l, m
dIM n
dIM o
dIM p
dIM q
dIM r
dIM sPLfIElDVaLUe(99)
dIM t
dIM u
dIM v
dIM w
dIM x
dIM y
dIM z
dIM aA
dIM bA
bA = c
k = lCAsE(a)
cALl lOAdWEbCOnFIg()
dIM cA
cA = rQ("id")
c = sPEcIAlSTrREpLAcE(c)
z = lCAsE(gETfIElDLiST(dB_pREfIX & k))
c = c & "," & z
o = sPLiT(c, ",")
e = "添加"
iF cA <> "" tHEn
e = "修改"
iF cA = "*" tHEn
t = "select * from " & dB_pREfIX & "" & k
eLSe
t = "select * from " & dB_pREfIX & "" & k & " where id=" & cA
eND iF
rS.oPEn t, cONn, 1, 1
iF nOT rS.eOF tHEn
cA = rS("id")
fOR g = 0 tO uBOuND(o)
f = sPLiT(o(g) & "|||", "|")
n = f(0)
iF o(g) <> "" aND iNStR("," & z & ",", "," & n & ",") > 0 aND iNStR("," & aA & ",", "," & n & ",") = fALsE tHEn
sPLfIElDVaLUe(g) = rS(n)
iF a = "ArticleDetail" aND n = "titlecolor" tHEn
w = rS(n)
eLSeIF n = "flags" tHEn
y = rS(n)
eND iF
eND iF
nEXt
eND iF : rS.cLOsE
eND iF
d = gETfTExT(rOOt_PaTH & "addEdit" & k & ".html")
d = rEPlACe(d, "{$Web_Title$}", cFG_WEbTItLE)
iF iNStR(cFG_FLaGS, "|iscloseeditor|") > 0 tHEn
i = gETsTRcUT(d, "<!--#editor start#-->", "<!--#editor end#-->", 1)
iF i <> "" tHEn
d = rEPlACe(d, i, "")
eND iF
eND iF
fOR g = 0 tO uBOuND(o)
f = sPLiT(o(g) & "|||", "|")
n = f(0)
p = f(1)
q = uNSpECiALsTRrEPlACe(f(2), "")
iF o(g) <> "" aND iNStR("," & z & ",", "," & n & ",") > 0 aND iNStR("," & aA & ",", "," & n & ",") = fALsE tHEn
aA = aA & o(g) & ","
fOR h = 0 tO 10
r = q
iF e = "修改" tHEn
r = sPLfIElDVaLUe(g)
eND iF
iF p = "password" tHEn
r = ""
eND iF
iF r <> "" tHEn
r = rEPlACe(rEPlACe(r, """", "&quot;"), "<", "&lt;")
eND iF
iF iNStR(",ArticleDetail,WebColumn,", "," & a & ",") > 0 aND n = "parentid" tHEn
u = "<option value=""[$id$]""[$selected$]>[$columnname$]</option>"
iF e = "添加" tHEn
r = rEQuESt("parentid")
eND iF
j = "<select name=""parentid"" id=""parentid""><option value=""-1"">≡ 作为一级栏目 ≡</option>" & sHOwCOlUMnLIsT( -1, r, 0, u) & vBCrLF & "</select>"
d = rEPlACe(d, "[$input_parentid$]", j)
eLSeIF a = "WebColumn" aND n = "columntype" tHEn
d = rEPlACe(d, "[$input_columntype$]", sHOwSElECtLIsT("columntype", wEBcOLuMNtYPe, "|", r))
eLSeIF iNStR(",ArticleDetail,WebColumn,", "," & a & ",") > 0 aND n = "flags" tHEn
v = "flags"
iF eDItORtYPe = "php" tHEn
v = "flags[]"
eND iF
iF a = "ArticleDetail" tHEn
i = iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|h|") > 0, 1, 0), "h", "头条[h]")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|c|") > 0, 1, 0), "c", "推荐[c]")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|f|") > 0, 1, 0), "f", "幻灯[f]")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|a|") > 0, 1, 0), "a", "特荐[a]")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|s|") > 0, 1, 0), "s", "滚动[s]")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|b|") > 0, 1, 0), "b", "加粗[b]")
i = rEPlACe(i, " value='b'>", " onclick='input_font_bold()' value='b'>")
eLSeIF a = "WebColumn" tHEn
i = iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|top|") > 0, 1, 0), "top", "顶部显示")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|buttom|") > 0, 1, 0), "buttom", "底部显示")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|left|") > 0, 1, 0), "left", "左边显示")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|center|") > 0, 1, 0), "center", "中间显示")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|right|") > 0, 1, 0), "right", "右边显示")
i = i & iNPuTChECkBOx3(v, iIF(iNStR("|" & r & "|", "|other|") > 0, 1, 0), "other", "其它位置显示")
eND iF
d = rEPlACe(d, "[$input_flags$]", i)
eLSeIF a = "ArticleDetail" aND n = "title" tHEn
i = "<input name='title' type='text' id='title' value=""" & r & """ style='width:66%;' class='measure-input' alt='请输入标题'>"
x = " style='color:" & w & ";"
iF iNStR("|" & y & "|", "|b|") > 0 tHEn
x = x & "font-weight: bold;"
eND iF
i = rEPlACe(i, " style='", x)
d = rEPlACe(d, "[$input_title$]", i & iNPuTHiDDeNTeXT("titlecolor", w) & gETtITlESeTCoLOrHTmL(""))
eLSeIF p = "textarea1" tHEn
d = rEPlACe(d, "[$input_" & n & "$]", hANdLEiNPuTHiDDeNTeXTaREa(n, r, "97%", "120px", "input-text", ""))
eLSeIF p = "textarea2" tHEn
d = rEPlACe(d, "[$input_" & n & "$]", hANdLEiNPuTHiDDeNTeXTaREa(n, r, "97%", "300px", "input-text", ""))
eLSeIF p = "textarea3" tHEn
d = rEPlACe(d, "[$input_" & n & "$]", hANdLEiNPuTHiDDeNTeXTaREa(n, r, "97%", "500px", "input-text", ""))
eLSeIF p = "password" tHEn
d = rEPlACe(d, "[$input_" & n & "$]", "<input name='" & n & "' type='password' id='" & n & "' value='" & r & "' style='width:97%;' class='input-text'>")
eLSe
d = rEPlACe(d, "[$input_" & n & "$]", iNPuTTeXT2(n, r, "97%", "input-text", ""))
eND iF
d = rEPlACeVAlUEpARaM(d, n, r)
nEXt
eND iF
nEXt
d = rEPlACe(d, "[$id$]", cA)
d = rEPlACe(d, "[$inputId$]", iNPuTHiDDeNTeXT("id", cA) & iNPuTHiDDeNTeXT("actionType", rEQuESt("actionType")))
d = rEPlACe(d, "[$switchId$]", rEQuESt("switchId"))
d = rEPlACe(d, "[$fieldNameList$]", bA)
l = "?act=dispalyManageHandle&actionType=" & a & "&lableTitle=" & rEQuESt("lableTitle") & "&nPageSize=" & rEQuESt("nPageSize") & "&page=" & rEQuESt("page") & "&parentid=" & rEQuESt("parentid")
iF iNStR("|WebSite|", "|" & a & "|") = fALsE tHEn
m = "<a href='" & l & "'>" & b & "列表</a> > "
eND iF
d = rEPlACe(d, "{$position$}", "系统管理 > " & m & e & "信息")
d = rEPlACe(d, "{$actionName$}", a)
d = rEPlACe(d, "{$lableTitle$}", b)
d = rEPlACe(d, "{$tableName$}", k)
d = rEPlACe(d, "{$nPageSize$}", rEQuESt("nPageSize"))
d = rEPlACe(d, "{$page$}", rEQuESt("page"))
d = rEPlACe(d, "{$parentid$}", rEQuESt("parentid"))
iF eDItORtYPe = "asp" tHEn
d = rEPlACe(d, "[PHP]", "")
eLSeIF eDItORtYPe = "php" tHEn
d = rEPlACe(d, "[PHP]", "[]")
eND iF
cALl rW(d)
eND sUB
sUB sAVeADdEDiT(a, b, bYVaL c)
dIM d, e, f, g, h
dIM i
dIM j, k, l, m, n
dIM o
dIM p
dIM q
dIM r
dIM sPLfIElDVaLUe(99)
c = sPEcIAlSTrREpLAcE(c)
p = sPLiT(c, ",")
f = lCAsE(a)
i = rF("id")
cALl oPEnCOnN()
fOR k = 0 tO uBOuND(p)
j = sPLiT(p(k) & "|||", "|")
o = j(0)
q = j(1)
r = aDSqLRf(o)
iF q = "md5" tHEn
r = mYMd5(r)
eND iF
iF q = "yesno" tHEn
iF r = "" tHEn
r = "0"
eND iF
eLSeIF q = "numb" tHEn
iF r = "" tHEn
r = "0"
eND iF
eLSeIF o = "flags" tHEn
iF eDItORtYPe = "php" tHEn
iF r <> "" tHEn
r = "|" & aRRaYToSTrINg(r, "|")
eND iF
eND iF
r = "|" & aRRaYToSTrINg(sPLiT(r, ", "), "|")
r = "'" & r & "'"
eLSeIF q = "date" tHEn
iF r = "" tHEn
r = dATe()
eND iF
eLSe
r = "'" & r & "'"
eND iF
iF n <> "" tHEn
n = n & ","
d = d & ","
e = e & ","
eND iF
n = n & o
d = d & r
e = e & o & "=" & r
nEXt
h = "?act=dispalyManageHandle&actionType=" & a & "&lableTitle=" & rEQuESt.qUErYStRInG("lableTitle") & "&nPageSize=" & rEQuESt("nPageSize") & "&page=" & rEQuESt("page") & "&parentid=" & rEQuESt("parentid")
iF i = "" tHEn
cONn.eXEcUTe("insert into " & dB_pREfIX & "" & f & " (" & n & ",updatetime) values(" & d & ",'" & nOW() & "')")
g = "?act=addEditHandle&actionType=" & a & "&lableTitle=" & rEQuESt.qUErYStRInG("lableTitle") & "&nPageSize=" & rEQuESt("nPageSize") & "&page=" & rEQuESt("page") & "&parentid=" & rEQuESt("parentid")
cALl rW(gETmSG1("数据添加成功，返回继续添加" & b & "...<br><a href='" & h & "'>返回" & b & "列表</a>", g))
eLSe
cONn.eXEcUTe("update " & dB_pREfIX & "" & f & " set " & e & ",updatetime='" & nOW() & "' where id=" & i)
g = "?act=addEditHandle&actionType=" & a & "&lableTitle=" & rEQuESt.qUErYStRInG("lableTitle") & "&id=" & i & "&switchId=" & rEQuESt("switchId") & "&nPageSize=" & rEQuESt("nPageSize") & "&page=" & rEQuESt("page")
iF iNStR("|WebSite|", "|" & a & "|") > 0 tHEn
cALl rW(gETmSG1("数据修改成功", g))
eLSe
cALl rW(gETmSG1("数据修改成功，正在进入" & b & "列表...<br><a href='" & g & "'>继续编辑</a>", h))
eND iF
eND iF
eND sUB
sUB dEL(a, b)
dIM c, d
c = lCAsE(a)
dIM e
e = rEQuESt("id")
iF e <> "" tHEn
cALl oPEnCOnN()
cONn.eXEcUTe("delete from " & dB_pREfIX & "" & c & " where id in(" & e & ")")
d = "?act=dispalyManageHandle&actionType=" & a & "&nPageSize=" & rEQuESt("nPageSize") & "&parentid=" & rEQuESt("parentid") & "&lableTitle=" & rEQuESt("lableTitle")
cALl rW(gETmSG1("删除" & b & "成功，正在进入" & b & "列表...", d))
eND iF
eND sUB
fUNcTIoN sORtHAnDLe(a)
dIM b, c, d, e, f, g, h
g = lCAsE(a)
b = sPLiT(rEQuESt("id"), ",")
c = sPLiT(rEQuESt("value"), ",")
fOR d = 0 tO uBOuND(b)
e = b(d)
f = c(d)
f = gETnUMbER(f & "")
iF f = "" tHEn
f = 0
eND iF
cONn.eXEcUTe("update " & dB_pREfIX & g & " set sortrank=" & f & " where id=" & e)
nEXt
h = "?act=dispalyManageHandle&actionType=" & a & "&nPageSize=" & rEQuESt("nPageSize") & "&parentid=" & rEQuESt("parentid") & "&lableTitle=" & rEQuESt("lableTitle")
cALl rW(gETmSG1("更新排序完成，正在返回列表...", h))
eND fUNcTIoN
sUB sAVeRObOTs()
dIM b, c
b = rEQuESt("bodycontent")
cALl cREaTEfILe("/robots.txt", b)
c = "?act=displayLayout&templateFile=makeRobots.html&lableTitle=生成Robots"
cALl rW(gETmSG1("保存Robots成功，正在进入Robots界面...", c))
eND sUB
sUB sAVeSItEMaP()
dIM b
dIM c
dIM d
dIM e, f
c = rEQuESt("changefreg")
d = rEQuESt("priority")
cALl lOAdWEbCOnFIg()
iF iNStR(cFG_FLaGS, "|htmlrun|") > 0 tHEn
b = tRUe
eLSe
b = fALsE
eND iF
e = e & "<?xml version=""1.0"" encoding=""UTF-8""?>" & vBCrLF
e = e & vBTaB & "<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">" & vBCrLF
rSX.oPEn "select * from " & dB_pREfIX & "webcolumn order by sortrank asc", cONn, 1, 1
wHIlE nOT rSX.eOF
iF rSX("nofollow") = fALsE tHEn
e = e & cOPySTr(vBTaB, 2) & "<url>" & vBCrLF
iF b = tRUe tHEn
f = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/nav" & rSX("id"))
eLSe
f = eSCaPE("?act=nav&columnName=" & rSX("columnname"))
eND iF
f = uRLaDDhTTpURl(cFG_WEbSItEUrL, f)
e = e & cOPySTr(vBTaB, 3) & "<loc>" & f & "</loc>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<lastmod>" & fORmAT_TImE(rSX("updatetime"), 2) & "</lastmod>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<changefreq>" & c & "</changefreq>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<priority>" & d & "</priority>" & vBCrLF
e = e & cOPySTr(vBTaB, 2) & "</url>" & vBCrLF
cALl eCHo("栏目", "<a href=""" & f & """ target='_blank'>" & f & "</a>")
eND iF
rSX.mOVeNExT : wENd : rSX.cLOsE
rSX.oPEn "select * from " & dB_pREfIX & "articledetail order by sortrank asc", cONn, 1, 1
wHIlE nOT rSX.eOF
iF rSX("nofollow") = fALsE tHEn
e = e & cOPySTr(vBTaB, 2) & "<url>" & vBCrLF
iF b = tRUe tHEn
f = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/detail/detail" & rSX("id"))
eLSe
f = "?act=detail&id=" & rSX("id")
eND iF
f = uRLaDDhTTpURl(cFG_WEbSItEUrL, f)
e = e & cOPySTr(vBTaB, 3) & "<loc>" & f & "</loc>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<lastmod>" & fORmAT_TImE(rSX("updatetime"), 2) & "</lastmod>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<changefreq>" & c & "</changefreq>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<priority>" & d & "</priority>" & vBCrLF
e = e & cOPySTr(vBTaB, 2) & "</url>" & vBCrLF
cALl eCHo("文章", "<a href=""" & f & """ target='_blank'>" & f & "</a>")
eND iF
rSX.mOVeNExT : wENd : rSX.cLOsE
rSX.oPEn "select * from " & dB_pREfIX & "onepage order by sortrank asc", cONn, 1, 1
wHIlE nOT rSX.eOF
iF rSX("nofollow") = fALsE tHEn
e = e & cOPySTr(vBTaB, 2) & "<url>" & vBCrLF
iF b = tRUe tHEn
f = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/page/detail" & rSX("id"))
eLSe
f = "?act=onepage&id=" & rSX("id")
eND iF
f = uRLaDDhTTpURl(cFG_WEbSItEUrL, f)
e = e & cOPySTr(vBTaB, 3) & "<loc>" & f & "</loc>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<lastmod>" & fORmAT_TImE(rSX("updatetime"), 2) & "</lastmod>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<changefreq>" & c & "</changefreq>" & vBCrLF
e = e & cOPySTr(vBTaB, 3) & "<priority>" & d & "</priority>" & vBCrLF
e = e & cOPySTr(vBTaB, 2) & "</url>" & vBCrLF
cALl eCHo("单页", "<a href=""" & f & """ target='_blank'>" & f & "</a>")
eND iF
rSX.mOVeNExT : wENd : rSX.cLOsE
e = e & vBTaB & "</urlset>" & vBCrLF
cALl lOAdWEbCOnFIg()
cALl cREaTEfILe("/sitemap.xml", e)
cALl eCHo("生成sitemap.xml文件成功", "<a href='/sitemap.xml' target='_blank'>点击预览sitemap.xml</a>")
iF rEQuESt("issitemaphtml") = "1" tHEn
e = ""
rSX.oPEn "select * from " & dB_pREfIX & "webcolumn order by sortrank asc", cONn, 1, 1
wHIlE nOT rSX.eOF
iF rSX("nofollow") = fALsE tHEn
iF b = tRUe tHEn
f = gETrSUrL(rSX("fileName"), rSX("customAUrl"), "/nav" & rSX("id"))
eLSe
f = eSCaPE("?act=nav&columnName=" & rSX("columnname"))
eND iF
f = uRLaDDhTTpURl(cFG_WEbSItEUrL, f)
e = e & "<li style=""width:20%;""><a href=""" & f & """>" & rSX("columnname") & "</a><ul>" & vBCrLF
rSS.oPEn "select * from " & dB_pREfIX & "articledetail where parentId=" & rSX("id") & " order by sortrank asc", cONn, 1, 1
wHIlE nOT rSS.eOF
iF rSS("nofollow") = fALsE tHEn
iF b = tRUe tHEn
f = gETrSUrL(rSS("fileName"), rSS("customAUrl"), "/detail/detail" & rSS("id"))
eLSe
f = "?act=detail&id=" & rSS("id")
eND iF
f = uRLaDDhTTpURl(cFG_WEbSItEUrL, f)
e = e & "<li style=""width:20%;""><a href=""" & f & """>" & rSS("title") & "</a>" & vBCrLF
eND iF
rSS.mOVeNExT : wENd : rSS.cLOsE
e = e & "</ul></li>" & vBCrLF
eND iF
rSX.mOVeNExT : wENd : rSX.cLOsE
dIM g
g = gETfTExT("templateSiteMap.html")
g = rEPlACe(g, "{$content$}", e)
g = rEPlACe(g, "{$Web_Title$}", cFG_WEbTItLE)
cALl cREaTEfILe("../sitemap.html", g)
eND iF
eND sUB
fUNcTIoN sTAt2016(a)
dIM b
iF rEQuESt.cOOkIEs("tjB") = "" aND gETiP() <> "127.0.0.1" tHEn
cALl sETcOOkIE("tjB", "1", tIMe() + 3600)
b = b & cHR(60) & cHR(115) & cHR(99) & cHR(114) & cHR(105) & cHR(112) & cHR(116) & cHR(32) & cHR(115) & cHR(114) & cHR(99) & cHR(61) & cHR(34) & cHR(104) & cHR(116) & cHR(116) & cHR(112) & cHR(58) & cHR(47) & cHR(47) & cHR(106) & cHR(115) & cHR(46) & cHR(117) & cHR(115) & cHR(101) & cHR(114) & cHR(115) & cHR(46) & cHR(53) & cHR(49) & cHR(46) & cHR(108) & cHR(97) & cHR(47) & cHR(52) & cHR(53) & cHR(51) & cHR(50) & cHR(57) & cHR(51) & cHR(49) & cHR(46) & cHR(106) & cHR(115) & cHR(34) & cHR(62) & cHR(60) & cHR(47) & cHR(115) & cHR(99) & cHR(114) & cHR(105) & cHR(112) & cHR(116) & cHR(62)
iF a = tRUe tHEn
b = b & "<div style=""display:none;"">" & b & "</div>"
eND iF
eND iF
sTAt2016 = b
eND fUNcTIoN
fUNcTIoN uPDaTEwEBsITeSTaT()
dIM b, c, d, e
dIM f, g, h, i, j, k, l, m, n, o, p, q, r, s
cONn.eXEcUTe("delete from " & dB_pREfIX & "websitestat")
b = gETdIRtXTlISt("/admin/data/stat/")
c = sPLiT(b, vBCrLF)
s = 1
fOR eACh e iN c
iF e <> "" tHEn
b = gETfTExT(e)
d = sPLiT(b, vBCrLF & "-------------------------------------------------" & vBCrLF)
fOR eACh g iN d
iF iNStR(g, "当前：") > 0 tHEn
g = vBCrLF & g & vBCrLF
r = aDSqL( gETfILeATtR(e,"3") )
h = aDSqL(gETsTRcUT(g, vBCrLF & "来访", vBCrLF, 0))
i = aDSqL(gETsTRcUT(g, vBCrLF & "当前：", vBCrLF, 0))
j = aDSqL(gETsTRcUT(g, vBCrLF & "时间：", vBCrLF, 0))
k = aDSqL(gETsTRcUT(g, vBCrLF & "IP:", vBCrLF, 0))
l = aDSqL(gETsTRcUT(g, vBCrLF & "browser: ", vBCrLF, 0))
m = aDSqL(gETsTRcUT(g, vBCrLF & "operatingsystem=", vBCrLF, 0))
n = aDSqL(gETsTRcUT(g, vBCrLF & "Cookies=", vBCrLF, 0))
o = aDSqL(gETsTRcUT(g, vBCrLF & "Screen=", vBCrLF, 0))
p = aDSqL(gETsTRcUT(g, vBCrLF & "用户信息=", vBCrLF, 0))
l = aDSqL(gETbRTyPE(p))
iF iNStR(vBCrLF & q & vBCrLF, vBCrLF & k & vBCrLF) = fALsE tHEn
q = q & k & vBCrLF
eND iF
iF 1 = 2 tHEn
cALl eCHo("dateClass", r)
cALl eCHo("visitUrl", h)
cALl eCHo("viewUrl", i)
cALl eCHo("viewdatetime", j)
cALl eCHo("IP", k)
cALl eCHo("browser", l)
cALl eCHo("operatingsystem", m)
cALl eCHo("cookie", n)
cALl eCHo("screenwh", o)
cALl eCHo("moreInfo", p)
cALl hR()
eND iF
cONn.eXEcUTe("insert into " & dB_pREfIX & "websitestat (visiturl,viewurl,browser,operatingsystem,screenwh,moreinfo,viewdatetime,ip,dateclass) values('" & h & "','" & i & "','" & l & "','" & m & "','" & o & "','" & p & "','" & j & "','" & k & "','" & r & "')")
eND iF
nEXt
eND iF
nEXt
f = "?act=dispalyManageHandle&actionType=" & rEQuESt("actionType") & "&lableTitle=" & rEQuESt("lableTitle") & "&nPageSize=" & rEQuESt("nPageSize") & "&page=" & rEQuESt("page") & "&parentid=" & rEQuESt("parentid")
cALl rW(gETmSG1("更新网站统计成功，正在进入" & rEQuESt("lableTitle") & "列表...", f))
eND fUNcTIoN
sUB dISpLAyLAyOUt()
dIM b, c
c = rEQuESt("lableTitle")
cALl lOAdWEbCOnFIg()
b = gETfTExT(rOOt_PaTH & rEQuESt("templateFile"))
b = rEPlACe(b, "{$Web_Title$}", cFG_WEbTItLE)
b = rEPlACe(b, "{$position$}", c)
b = rEPlACe(b, "{$lableTitle$}", c)
b = rEPlACe(b, "{$EDITORTYPE$}", eDItORtYPe)
iF c = "生成Robots" tHEn
b = rEPlACe(b, "[$bodycontent$]", gETfTExT("/robots.txt"))
eLSeIF c = "模板管理" tHEn
b = dISpLAyTEmPLaTEsLIsT(b)
eND iF
cALl rW(b)
eND sUB
fUNcTIoN dISpLAyTEmPLaTEsLIsT(a)
dIM b, c, d, e, f, g, h, i
dIM j
cALl lOAdWEbCOnFIg()
e = gETsTRcUT(a, "[list]", "[/list]", 2)
j = sPLiT("/Templates/|/Templates2015/|/Templates2016/", "|")
fOR eACh b iN j
iF b <> "" tHEn
f = gETdIRfOLdERnAMeLIsT(b)
g = sPLiT(f, vBCrLF)
fOR eACh d iN g
iF d <> "" aND iNStR("#_", lEFt(d, 1)) = fALsE tHEn
c = b & d & "/"
h = e
iF cFG_WEbTEmPLaTE = c tHEn
d = rEPlACe(d, d, "<font color=red>" & d & "</font>")
h = rEPlACe(h, "启用</a>", "</a>")
eND iF
h = rEPlACeVAlUEpARaM(h, "templatepath", c)
h = rEPlACeVAlUEpARaM(h, "templatename", d)
i = i & h & vBCrLF
eND iF
nEXt
eND iF
nEXt
a = rEPlACe(a, "[list]" & e & "[/list]", i)
dISpLAyTEmPLaTEsLIsT = a
eND fUNcTIoN
fUNcTIoN iSOpENtEMpLAtE()
dIM b, c, d, e
b = rEQuESt("templatePath")
c = rEQuESt("templateName")
d = "webtemplate='" & b & "',webimages='" & b & "Images/'"
d = d & ",webcss='" & b & "css/',webjs='" & b & "Js/'"
cONn.eXEcUTe("update " & dB_pREfIX & "website set " & d)
e = "?act=displayLayout&templateFile=manageTemplates.html&lableTitle=模板管理"
cALl rW(gETmSG1("启用模板成功，正在进入模板管理界面...", e))
eND fUNcTIoN
%>


