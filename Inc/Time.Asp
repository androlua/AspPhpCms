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
<%
fUNcTIoN fORmAT_TImE(a, b)
dIM c, d, e, f, g, h
fORmAT_TImE = ""
iF iSDaTE(a) = fALsE tHEn eXIt fUNcTIoN
c = cSTr(yEAr(a))
d = cSTr(mONtH(a))
iF lEN(d) = 1 tHEn d = "0" & d
e = cSTr(dAY(a))
iF lEN(e) = 1 tHEn e = "0" & e
f = cSTr(hOUr(a))
iF lEN(f) = 1 tHEn f = "0" & f
g = cSTr(mINuTE(a))
iF lEN(g) = 1 tHEn g = "0" & g
h = cSTr(sECoND(a))
iF lEN(h) = 1 tHEn h = "0" & h
sELeCT cASe b
cASe 1
fORmAT_TImE = c & "-" & d & "-" & e & " " & f & ":" & g & ":" & h
cASe 2
fORmAT_TImE = c & "-" & d & "-" & e
cASe 3
fORmAT_TImE = f & ":" & g & ":" & h
cASe 4
fORmAT_TImE = c & "年" & d & "月" & e & "日"
cASe 5
fORmAT_TImE = c & d & e
cASe 6
fORmAT_TImE = c & d & e & f & g & h
cASe 7
fORmAT_TImE = d & "-" & e
cASe 8
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & ":" & g & ":" & h
cASe 9
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒，" & gETdAYsTAtUS(f, 1)
cASe 10
fORmAT_TImE = c & "年" & d & "月" & e & "日" & f & "时"
cASe 11
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分" & h & "秒"
cASe 12
fORmAT_TImE = c & "年" & d & "月" & e & "日" & " " & f & "时" & g & "分"
cASe 13
fORmAT_TImE = d & "月" & e & "日" & " " & f & ":" & g & " " & gETdAYsTAtUS(f, 0)
cASe 14
fORmAT_TImE = c & "/" & d & "/" & e
cASe 15
fORmAT_TImE = c & "年" & d & "月 第" & gETcOUnTPaGE(e, 7) & "周"
eND sELeCT
eND fUNcTIoN
fUNcTIoN gETdAYsTAtUS(a, b)
dIM c
iF lEFt(a, 1) = "0" tHEn
a = rIGhT(a, 1)
eND iF
a = cINt(a)
iF a >= 0 aND a <= 5 tHEn
c = "凌晨"
eLSeIF a >= 6 aND a <= 8 tHEn
c = "早上"
eLSeIF a >= 9 aND a <= 12 tHEn
c = "上午"
eLSeIF a >= 13 aND a <= 18 tHEn
c = "下午"
eLSeIF a >= 19 aND a <= 24 tHEn
c = "晚上"
eLSe
c = "深夜"
eND iF
iF b = 1 tHEn c = "<b>" & c & "</b>"
gETdAYsTAtUS = c
eND fUNcTIoN
fUNcTIoN pRInTTiMEvALuE(a)
oN eRRoR rESuME nEXt
dIM b, c, d
b = a : c = ""
iF b >= 86400 tHEn
d = b mOD 86400
b = fIX(b / 60 / 60 / 24)
c = c & b & "天"
b = d
eND iF
iF b >= 3600 tHEn
d = b mOD 3600
b = fIX(b / 60 / 60)
c = c & b & "小时"
b = d
eND iF
iF b >= 60 tHEn
d = b mOD 60
b = fIX(b / 60)
c = c & b & "分"
b = d
eND iF
iF b >= 0 tHEn
c = c & b & "秒"
eND iF
iF eRR.nUMbER <> 0 tHEn mSGbOX(a)
pRInTTiMEvALuE = c
eND fUNcTIoN
fUNcTIoN pRInTAsKTiME(a)
oN eRRoR rESuME nEXt
dIM b, c, d
b = a
c = ""
iF b >= 3600 tHEn
d = b mOD 3600
b = fIX(b / 60 / 60)
c = c & b & "小时"
b = d
pRInTAsKTiME = c : eXIt fUNcTIoN
eND iF
iF b >= 60 tHEn
d = b mOD 60
b = fIX(b / 60)
c = c & b & "分钟"
b = d
pRInTAsKTiME = c : eXIt fUNcTIoN
eND iF
iF b >= 0 tHEn
c = c & b & "秒钟"
pRInTAsKTiME = c : eXIt fUNcTIoN
eND iF
eND fUNcTIoN
fUNcTIoN gETtIMeRSeT()
dIM b
b = fORmATnUMbER((tIMeR() - pUBtIMeR) * 1000, 2, - 1) / 1000
gETtIMeRSeT = tONuMBeR(b, 3)
eND fUNcTIoN
fUNcTIoN cALcULaTIoNTiMEr(a)
dIM b
b = fORmATnUMbER((tIMeR() - a) * 1000, 2, - 1) / 1000
cALcULaTIoNTiMEr = tONuMBeR(b, 3)
eND fUNcTIoN
fUNcTIoN gETtIMeR()
gETtIMeR = "<br>------------------------------------<br>页面执行时间：" & gETtIMeRSeT() & " 秒"
eND fUNcTIoN
fUNcTIoN vBGeTTiMEr()
dIM b
b = dATeDIfF("s", pUBtIMeR, nOW())
b = pRInTTiMEvALuE(b)
vBGeTTiMEr = vBCrLF & "------------------------------------" & vBCrLF & "运行时间：" & b
eND fUNcTIoN
fUNcTIoN vBEcHOtIMeR()
dIM b
b = dATeDIfF("s", pUBtIMeR, nOW())
b = pRInTTiMEvALuE(b)
vBEcHOtIMeR = "运行时间：" & b
eND fUNcTIoN
fUNcTIoN vBRuNTiMEr(a)
dIM b
b = dATeDIfF("s", a, nOW())
b = pRInTTiMEvALuE(b)
vBRuNTiMEr = "运行时间：" & b
eND fUNcTIoN
%>


