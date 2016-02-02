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
cLAsS gPS
dIM aSO
pRIvATe sUB cLAsS_iNItIAlIZe()
sET aSO = cREaTEoBJeCT("ADODB.Stream")
aSO.mODe = 3
aSO.tYPe = 1
aSO.oPEn
eND sUB
pRIvATe sUB cLAsS_tERmINaTE()
sET aSO = nOThINg
eND sUB
pRIvATe fUNcTIoN bIN2STr(a)
dIM b, c, d
fOR b = 1 tO lENb(a)
d = mIDb(a, b, 1)
iF aSCb(d) < 128 tHEn
c = c & cHR(aSCb(d))
eLSe
b = b + 1
iF b <= lENb(a) tHEn c = c & cHR(aSCw(mIDb(a, b, 1) & d))
eND iF
nEXt
bIN2STr = c
eND fUNcTIoN
pRIvATe fUNcTIoN bINvAL(a)
dIM b
dIM c
b = 0
fOR c = lENb(a) tO 1 sTEp - 1
b = b * 256 + aSCb(mIDb(a, c, 1))
nEXt
bINvAL = b
eND fUNcTIoN
pRIvATe fUNcTIoN bINvAL2(a)
dIM b, c
b = 0
fOR c = 1 tO lENb(a)
b = b * 256 + aSCb(mIDb(a, c, 1))
nEXt
bINvAL2 = b
eND fUNcTIoN
fUNcTIoN gETiMAgESiZE(a)
dIM b, c
iF cHEcKFiLE(a) = fALsE tHEn eXIt fUNcTIoN
aSO.lOAdFRoMFiLE(a)
dIM rET(3)
b = aSO.rEAd(3)
sELeCT cASe hEX(bINvAL(b))
cASe "4E5089"
aSO.rEAd(15)
rET(0) = "PNG"
rET(1) = bINvAL2(aSO.rEAd(2))
aSO.rEAd(2)
rET(2) = bINvAL2(aSO.rEAd(2))
cASe "464947"
aSO.rEAd(3)
rET(0) = "GIF"
rET(1) = bINvAL(aSO.rEAd(2))
rET(2) = bINvAL(aSO.rEAd(2))
cASe "FFD8FF"
dO
dO : c = bINvAL(aSO.rEAd(1)) : lOOp wHIlE c = 255 aND nOT aSO.eOS
iF c > 191 aND c < 196 tHEn eXIt dO eLSe aSO.rEAd(bINvAL2(aSO.rEAd(2)) - 2)
dO : c = bINvAL(aSO.rEAd(1)) : lOOp wHIlE c < 255 aND nOT aSO.eOS
lOOp wHIlE tRUe
aSO.rEAd(3)
rET(0) = "JPG"
rET(2) = bINvAL2(aSO.rEAd(2))
rET(1) = bINvAL2(aSO.rEAd(2))
cASe eLSe
iF lEFt(bIN2STr(b), 2) = "BM" tHEn
aSO.rEAd(15)
rET(0) = "BMP"
rET(1) = bINvAL(aSO.rEAd(4))
rET(2) = bINvAL(aSO.rEAd(4))
eLSe
rET(0) = ""
eND iF
eND sELeCT
rET(3) = "width=""" & rET(1) & """ height=""" & rET(2) & """"
gETiMAgESiZE = rET
eND fUNcTIoN
eND cLAsS
fUNcTIoN hANdLEsHOwIMg(a, b, c, d)
dIM e
dIM f
e = hANdLEpATh(a)
dIM g
sET g = nEW gPS
sET f = cREaTEoBJeCT("Scripting.FileSystemObject")
dIM h
h = f.gETeXTeNSiONnAMe(e)
dIM i
dIM j, k
sELeCT cASe h
cASe "gif", "bmp", "jpg", "png"
i = g.gETiMAgESiZE(e)
j = i(1)
k = i(2)
eND sELeCT
sET f = nOThINg
sET g = nOThINg
dIM l, m
dIM n
cALl eCHo("PWidth", j)
cALl eCHo("PHeight", k)
cALl eCHo("setWidth", b)
cALl eCHo("setHeight", c)
iF j = 0 oR j = "" tHEn
l = 0
m = 0
eLSe
iF c < b aND c > 0 tHEn
n = fORmATnUMbER(k / j, 2)
m = c
l = fORmATnUMbER(c * n, 0)
eLSe
n = fORmATnUMbER(j / k, 2)
l = b
m = fORmATnUMbER(b / n, 0)
cALl eCHo(n, b & "   " & b / n)
eND iF
eND iF
cALl eCHo("宽百分比", fORmATnUMbER(j / k, 2))
cALl eCHo("高百分比", fORmATnUMbER(k / j, 2))
cALl eCHo("PXWidth", l)
cALl eCHo("PXHeight", m)
iF d = "宽" tHEn
iF b < l tHEn l = b
hANdLEsHOwIMg = l
eLSeIF d = "高" tHEn
iF c < l tHEn l = c
hANdLEsHOwIMg = l
eLSe
hANdLEsHOwIMg = "<img onerror=javascript:this.src='product_pic/wutu.jpg';this.width='92';this.height='130' src='" & a & "' border='0' width='" & l & "' height='" & m & "'>显示图片"
eND iF
eND fUNcTIoN
fUNcTIoN gETiMAgEWiDThHEiGHt(a, b, c)
dIM d, e
cALl hANdLEpATh(a)
sET d = nEW gPS
sET e = cREaTEoBJeCT("Scripting.FileSystemObject")
dIM f
f = e.gETeXTeNSiONnAMe(a)
dIM g
sELeCT cASe f
cASe "gif", "bmp", "jpg", "png"
g = d.gETiMAgESiZE(a)
b = g(1)
c = g(2)
eND sELeCT
sET e = nOThINg
sET d = nOThINg
gETiMAgEWiDThHEiGHt=sPLiT(b & "|" & c,"|")
eND fUNcTIoN
fUNcTIoN gETiMAgEWiDThVAlUE(a)
dIM b
cALl gETiMAgEWiDThHEiGHt(a, b, "")
gETiMAgEWiDThVAlUE = b
eND fUNcTIoN
fUNcTIoN gETfILeCOnTEnTTyPE(a)
dIM b, c
cALl hANdLEpATh(a)
sET b = nEW gPS
sET c = cREaTEoBJeCT("Scripting.FileSystemObject")
dIM d
d = b.gETiMAgESiZE(a)
gETfILeCOnTEnTTyPE = d(0)
sET c = nOThINg
sET b = nOThINg
eND fUNcTIoN
fUNcTIoN iMAgEWaTErFAlL(a, b, c)
dIM d, e, f, g, h, i, j, k, l, m, n
dIM sPLc(99), sPLn(99)
b = b - 1
fOR f = 0 tO b
sPLc(f) = ""
sPLn(f) = 0
nEXt
d = gETfILeFOlDErLIsT(a, tRUe, "全部", "", "全部文件夹", "NO", "")
d = rEPlACe(lCAsE(d), lCAsE(sERvER.mAPpATh("/")), "")
e = sPLiT(d, vBCrLF) : a = rEPlACe(a, "\", "/")
fOR eACh g iN e
i = "<span><img src=" & hOSt & g & " width='" & c & "'></span>"
cALl gETiMAgEWiDThHEiGHt(g, k, l)
iF k > c tHEn
j = fORmATnUMbER(c / k, 2)
k = c
l = fORmATnUMbER(l * j, 0)
eND iF
m = 0 : n = ""
fOR f = 0 tO b
iF n = "" tHEn
n = sPLn(f)
eLSeIF sPLn(f) < n tHEn
m = f
n = sPLn(f)
eND iF
nEXt
sPLn(m) = sPLn(m) + l
sPLc(m) = sPLc(m) & i
nEXt
fOR f = 0 tO b
h = h & "<div class=""ImgDivBox"">" & sPLc(f) & "</div>" & vBCrLF
nEXt
h = h & "<div class=clear></div>"
iMAgEWaTErFAlL = h
eND fUNcTIoN
fUNcTIoN zOOmIMaGE(a,b, c, d, e, f, g, h, i)
dIM j, k, l, m
iF a = "" tHEn a = 0
iF b = "" tHEn b = 0
a=cINt(a) : b=cINt(b)
iF g = "" tHEn g = 0
iF h = "" tHEn h = 0
c=cINt(c) : d=cINt(d) : e=cINt(e) : f=cINt(f) : g=cINt(g) : h=cINt(h)
dIM n, tEMp_NtOP	
n=g : tEMp_NtOP=h
iF c / d >= e / f tHEn
iF c > e tHEn
l = e
m =(d * e) / c
eLSe
l = c
m = d
eND iF
eLSe
iF d > f tHEn
m = f
l =(c * f) / d
eLSe
l = c
m = d
eND iF
eND iF
l = iNT(l)
m = iNT(m)
g = g + e - l
h = h + f - m
j = " width=""" & l & """ height=""" & m & """"
iF b>0 tHEn
iF iNStR(i,"|imgulmiddel|")>0 tHEn
h=(b-m)/2
eND iF
eND iF
iF g > 0 aND g<>n tHEn
k = k & "padding-left:" & g & "px;"
eND iF
iF h > 0 aND h<>n tHEn
k = k & "padding-top:" & h & "px;"
eND iF
iF k <> "" tHEn
k = " style=""" & k & """"
eND iF
zOOmIMaGE = j & k
eND fUNcTIoN
%>

