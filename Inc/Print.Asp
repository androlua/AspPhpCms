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
fUNcTIoN pRInTPrE(a)
a = rEPlACe(a, "<", "&lt;")
pRInTPrE = "<pre>" & a & "</pre>"
eND fUNcTIoN
fUNcTIoN aUThORiNFo(a)
dIM b
b = "'************************************************************" & vBCrLF
iF a <> "" tHEn b = b & "'  文件：" & a & vBCrLF
b = b & "'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)" & vBCrLF
b = b & "'版权：源代码公开，各种用途均可免费使用。 " & vBCrLF
b = b & "'创建：" & fORmAT_TImE(nOW(), 2) & vBCrLF
b = b & "'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com" & vBCrLF
b = b & "'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得" & vBCrLF
b = b & "'*                                    Powered By 云端 " & vBCrLF
b = b & "'************************************************************" & vBCrLF
aUThORiNFo = b
eND fUNcTIoN
fUNcTIoN aUThORiNFo2()
dIM b
b = "                '''" & vBCrLF
b = b & "               (0 0)" & vBCrLF
b = b & "   +-----oOO----(_)------------+" & vBCrLF
b = b & "   |                           |" & vBCrLF
b = b & "   |    让我们一起来体验       |" & vBCrLF
b = b & "   |    QQ:313801120           |" & vBCrLF
b = b & "   |    sharembweb.com         |" & vBCrLF
b = b & "   |                           |" & vBCrLF
b = b & "   +------------------oOO------+" & vBCrLF
b = b & "              |__|__|" & vBCrLF
b = b & "               || ||" & vBCrLF
b = b & "              ooO Ooo" & vBCrLF
aUThORiNFo2 = b
eND fUNcTIoN
fUNcTIoN fOLdINgMEnU(a, b, c)
dIM d, e
iF a = "" tHEn
rANdOMiZE
d = cLNg(rND() * 29252888)
eLSe
d = a
eND iF
e = "<div style=""width:100%; font-size:12px;;line-height:150%;margin-bottom:4px;"">"
e = e & "  <label onClick=""ERRORDIV" & d & ".style.display=(ERRORDIV" & d & ".style.display=='none'?'':'none')"">"
e = e & "  <span style=""background-color:#666;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">〖 " & b & " 〗</span><br />"
e = e & "  </label>"
e = e & "  <div id=""ERRORDIV" & d & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;display:none;"">"
e = e & c
e = e & "  </div>"
e = e & "</div>"
fOLdINgMEnU = e
eND fUNcTIoN
fUNcTIoN rETuRNrEN(a, b)
rETuRNrEN = "<font color=red>" & a & "</font>：" & b
eND fUNcTIoN
fUNcTIoN rETuRNhR()
rETuRNhR = "<hr size='1' color='#666666'> "
eND fUNcTIoN
fUNcTIoN rETuRNrENhR()
rETuRNrENhR = "<hr size='1' color='red'> "
eND fUNcTIoN
sUB sHOwERr(bYVaL a, bYVaL b)
dIM c
c = "<style>.ab-showerr{width:400px;font-size:12px;font-family:Consolas;margin:10px auto;padding:0;background-color:#FFF;}"
c = c & ".ab-showerr h3,.ab-showerr h4{font-size:12px;margin:0;line-height:24px;text-align:center;background-color:#999;border:1px solid #555;color:#FFF;border-bottom:none;}.ab-showerr h4{padding:5px;line-height:1.5em;text-align:left;background-color:#FFC;color:#000; font-weight:normal;}"
c = c & ".ab-showerr h4 strong{color:red;}.ab-showerr table{width:100%;margin:0;padding:0;border-collapse:collapse;border:1px solid #555;border-bottom:none;}.ab-showerr th{background-color:#EEE;white-space:nowrap;}.ab-showerr thead th{background-color:#CCC;}.ab-showerr th,.ab-showerr td{font-size:12px;border:1px solid #999;padding:6px;line-height:20px;word-break:break-all;}.ab-showerr span.info{color:#F30;}</style>"
c = c & "<div class=""ab-showerr""><h3>Microsoft VBScript 编译器错误</h3><h4>程序出错了，错误代码： <strong>" & a & "</strong> ，以下是错误描述：</h4><table><tr><td>" & b & "</td></tr></table></div>"
rESpONsE.wRItE(c) : rESpONsE.eND()
eND sUB
sUB pRInTFoRMiNFo()
dIM b, c, d, e, f, g, h
b = rEQuESt.fORm
dIM i, j, k
dIM l
rEDiM j(rEQuESt.fORm.cOUnT)
rEDiM k(rEQuESt.fORm.cOUnT)
l = rEQuESt.fORm.cOUnT
i = rEQuESt.fORm
d = "Dim "
fOR i = 0 tO l - 1
j(i) = sPLiT(sPLiT(i, "&")(i), "=")(0)
k(i) = sPLiT(sPLiT(i, "&")(i), "=")(1)
c = c & j(i) & "|"
d = d & j(i) & ", "
g = g & j(i) & "=" & k(i) & "<br>"
e = e & cOPySTr("&nbsp;", 4) & j(i) & " = Trim(Rf(""" & j(i) & """))<br>"
f = f & cOPySTr("&nbsp;", 8) & "Rs(""" & j(i) & """) = " & j(i) & "<br>" & vBCrLF
h = h & cOPySTr("&nbsp;", 8) & j(i) & " = Rs(""" & j(i) & """) " & "<br>" & vBCrLF
nEXt
iF rIGhT(d, 2) = ", " tHEn d = mID(d, 1, lEN(d) - 2)
cALl rW("名称列表 ========<br>" & c & "<br>")
cALl rW("定义变量 ========<br>" & d & "<br>")
cALl rW("获得Form ========<br>" & e & "<br>")
cALl rW("ASP代码 ========<br>" & f & "<br>")
cALl rW("打印ASP ========<br>" & h & "<br>")
cALl rW("显示内容 ========<br>" & g & "<br>")
eND sUB
fUNcTIoN dEDeCMsMSg()
dIM b
b = "<style> " & vBCrLF
b = b & ".msgbox {" & vBCrLF
b = b & "    width: 450px;" & vBCrLF
b = b & "    border: 1px solid #DADADA;" & vBCrLF
b = b & "    margin:0 auto;" & vBCrLF
b = b & "    margin-top:20px;" & vBCrLF
b = b & "    line-height:20px;" & vBCrLF
b = b & "}" & vBCrLF
b = b & ".msgbox .ptitle{" & vBCrLF
b = b & "    padding: 6px;" & vBCrLF
b = b & "    font-size: 12px;" & vBCrLF
b = b & "    border-bottom: 1px solid #DADADA;" & vBCrLF
b = b & "    background: #DBEEBD url(/plus/img/wbg.gif);" & vBCrLF
b = b & "    font-weight:bold;" & vBCrLF
b = b & "    text-align:center;" & vBCrLF
b = b & "}" & vBCrLF
b = b & ".msgbox .pcontent{" & vBCrLF
b = b & "    height: 100px;" & vBCrLF
b = b & "    font-size: 10pt;" & vBCrLF
b = b & "    background: #ffffff;" & vBCrLF
b = b & "    text-align:center;" & vBCrLF
b = b & "    padding-top:30px;" & vBCrLF
b = b & "}" & vBCrLF
b = b & "</style> " & vBCrLF
b = b & "<div class=""msgbox"">" & vBCrLF
b = b & "    <div class=""ptitle"">提示信息！</div>" & vBCrLF
b = b & "    <div class=""pcontent"">" & vBCrLF
b = b & "        成功登录，正在转向管理管理主页！<br>" & vBCrLF
b = b & "        <a href=""#"">如果你的浏览器没反应，请点击这里...</a>" & vBCrLF
b = b & "" & vBCrLF
b = b & "    </div>" & vBCrLF
b = b & "</div>" & vBCrLF
dEDeCMsMSg = b
eND fUNcTIoN
%>


