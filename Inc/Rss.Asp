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
<%@ cODePAgE = 65001 %>
<!--#Include File = "Config.Asp"-->
<%
fUNcTIoN rETuRN_RFc822_DaTE(bYVaL a, bYVaL b)
dIM c, d, e, f
dIM g, h, i
a = cDAtE(a)
c = eNWeEKdAYnAMe(a)
d = rIGhT("00" & dAY(a), 2)
e = eNMoNThNAmE(a)
f = yEAr(a)
g = rIGhT("00" & hOUr(a), 2)
h = rIGhT("00" & mINuTE(a), 2)
i = rIGhT("00" & sECoND(a), 2)
rETuRN_RFc822_DaTE = c & ", " & _
d & " " & _
e & " " & _
f & " " & _
g & ":" & _
h & ":" & _
i & " " & _
" " & b
eND fUNcTIoN
fUNcTIoN eNWeEKdAYnAMe(a)
dIM b
sELeCT cASe wEEkDAy(a, 1)
cASe 1 : b = "Sun"
cASe 2 : b = "Mon"
cASe 3 : b = "Tue"
cASe 4 : b = "Wed"
cASe 5 : b = "Thu"
cASe 6 : b = "Fri"
cASe 7 : b = "Sat"
eND sELeCT
eNWeEKdAYnAMe = b
eND fUNcTIoN
fUNcTIoN eNMoNThNAmE(a)
dIM b
sELeCT cASe mONtH(a)
cASe 1 : b = "Jan"
cASe 2 : b = "Feb"
cASe 3 : b = "Mar"
cASe 4 : b = "Apr"
cASe 5 : b = "May"
cASe 6 : b = "Jun"
cASe 7 : b = "Jul"
cASe 8 : b = "Aug"
cASe 9 : b = "Sep"
cASe 10 : b = "Oct"
cASe 11 : b = "Nov"
cASe 12 : b = "Dec"
eND sELeCT
eNMoNThNAmE = b
eND fUNcTIoN
dIM sQL,xMLcONtENt,rSC,wEB_NAmE,wEB_URl,cATeGOrYNaME,uRL,tOPaTH
wEB_NAmE = "南京麦思德餐饮有限公司"
wEB_URl =  hOSt()
cATeGOrYNaME = "餐饮培训"
cALl oPEnCOnN()
sQL = "Select Top 50 * From [Product] Where OnHtml=True Order By [UpDateTime] Desc"
sET rS = cREaTEoBJeCT("Adodb.RecordSet")
rS.oPEn sQL, cONn, 1, 1
xMLcONtENt = xMLcONtENt & "<?xml version=""1.0"" encoding=""utf-8"" ?>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<?xml-stylesheet type=""text/xsl"" href=""/rss/rss.xslt"" version=""1.0"" ?>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<rss version=""2.0"">" & vBCrLF
xMLcONtENt = xMLcONtENt & "<channel>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<title>" & wEB_NAmE & " 的最新动态</title>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<link>" & wEB_URl & "</link>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<language>zh-cn</language>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<copyright>RSS Feed By www.hitux.com</copyright>" & vBCrLF
wHIlE nOT rS.eOF
xMLcONtENt = xMLcONtENt & "<item>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<title><![CDATA[" & rS("title") & "]]></title>" & vBCrLF
uRL = wEB_URl & gEThANdLEuRL(rS("FileName"))	
xMLcONtENt = xMLcONtENt & "<link>" & uRL & "</link>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<description><![CDATA[" & rS("WebDescription") & "]]></description>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<pubDate>" & rETuRN_RFc822_DaTE(rS("UpDateTime"), "08:00") & "</pubDate>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<author>" & wEB_NAmE & "</author>" & vBCrLF
xMLcONtENt = xMLcONtENt & "<category>" & cATeGOrYNaME & "</category>" & vBCrLF
xMLcONtENt = xMLcONtENt & "</item>" & vBCrLF
rS.mOVeNExT
wENd
xMLcONtENt = xMLcONtENt & "</channel>" & vBCrLF
xMLcONtENt = xMLcONtENt & "</rss>" & vBCrLF
rS.cLOsE
sET rS = nOThINg
cALl cREaTEfOLdER("../Rss")
tOPaTH = hANdLEpATh("../Rss/Feed.Xml")
cALl wRItEToFIlE(tOPaTH, xMLcONtENt, "utf-8")
uRL = "<a "& aHReF(wEB_URl & "/Rss/Feed.Xml","点击打开","_blank") &">"& wEB_URl & "Rss/Feed.Xml" &"</a>"
cALl eCHo("Create Rss/Feed.Xml OK", uRL)
%>


