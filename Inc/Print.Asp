<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-17
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%



Function printPre(a)
    a = Replace(a, "<", "&lt;")
    printPre = "<pre>" & a & "</pre>"
End Function


Function authorInfo(a)
    Dim b
    b = "'************************************************************" & vbCrLf
    If a <> "" Then b = b & "'  文件：" & a & vbCrLf
    b = b & "'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)" & vbCrlf
    b = b & "'版权：源代码公开，各种用途均可免费使用。 " & vbCrlf
    b = b & "'创建：" & Format_Time(Now(), 2) & vbCrLf
    b = b & "'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com" & vbCrlf
    b = b & "'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得" & vbCrlf
    b = b & "'*                                    Powered By 云端 " & vbCrlf
    b = b & "'************************************************************" & vbCrlf
    authorInfo = b
End Function


Function authorInfo2()
    Dim b
    b = "                '''" & vbCrLf
    b = b & "               (0 0)" & vbCrLf
    b = b & "   +-----oOO----(_)------------+" & vbCrLf
    b = b & "   |                           |" & vbCrLf
    b = b & "   |    让我们一起来体验       |" & vbCrLf
    b = b & "   |    QQ:313801120           |" & vbCrLf
    b = b & "   |    sharembweb.com         |" & vbCrLf
    b = b & "   |                           |" & vbCrLf
    b = b & "   +------------------oOO------+" & vbCrLf
    b = b & "              |__|__|" & vbCrLf
    b = b & "               || ||" & vbCrLf
    b = b & "              ooO Ooo" & vbCrLf

    authorInfo2 = b
End Function

Function foldingMenu(a, b, c)

    Dim d, e
    If a = "" Then
        Randomize
        d = CLng(Rnd() * 29252888)
    Else
        d = a
    End If
    e = "<div style=""width:100%; font-size:12px;;line-height:150%;margin-bottom:4px;"">"
    e = e & "  <label onClick=""ERRORDIV" & d & ".style.display=(ERRORDIV" & d & ".style.display=='none'?'':'none')"">"
    e = e & "  <span style=""background-color:#666;color:#FFFFFF;height:23px;font-size:14px;cursor:pointer"">〖 " & b & " 〗</span><br />"
    e = e & "  </label>"
    e = e & "  <div id=""ERRORDIV" & d & """ style=""width:100%;border:1px solid #820222;padding:5px;overflow:hidden;display:none;"">"
    e = e & c
    e = e & "  </div>"
    e = e & "</div>"
    foldingMenu = e
End Function

Function returnRen(a, b)
    returnRen = "<font color=red>" & a & "</font>：" & b
End Function

Function returnHr()
    returnHr = "<hr size='1' color='#666666'> "
End Function

Function returnRenHr()
    returnRenHr = "<hr size='1' color='red'> "
End Function

Sub showErr(ByVal a, ByVal b)
    Dim c
    c = "<style>.ab-showerr{width:400px;font-size:12px;font-family:Consolas;margin:10px auto;padding:0;background-color:#FFF;}"
    c = c & ".ab-showerr h3,.ab-showerr h4{font-size:12px;margin:0;line-height:24px;text-align:center;background-color:#999;border:1px solid #555;color:#FFF;border-bottom:none;}.ab-showerr h4{padding:5px;line-height:1.5em;text-align:left;background-color:#FFC;color:#000; font-weight:normal;}"
    c = c & ".ab-showerr h4 strong{color:red;}.ab-showerr table{width:100%;margin:0;padding:0;border-collapse:collapse;border:1px solid #555;border-bottom:none;}.ab-showerr th{background-color:#EEE;white-space:nowrap;}.ab-showerr thead th{background-color:#CCC;}.ab-showerr th,.ab-showerr td{font-size:12px;border:1px solid #999;padding:6px;line-height:20px;word-break:break-all;}.ab-showerr span.info{color:#F30;}</style>"
    c = c & "<div class=""ab-showerr""><h3>Microsoft VBScript 编译器错误</h3><h4>程序出错了，错误代码： <strong>" & a & "</strong> ，以下是错误描述：</h4><table><tr><td>" & b & "</td></tr></table></div>"
    Response.Write(c) : Response.End()
End Sub


Sub printFormInfo()
    Dim b, c, d, e, f, g, h
    b = Request.Form
    Dim i, j, k
    Dim l
    ReDim j(Request.Form.Count)
    ReDim k(Request.Form.Count)
    l = Request.Form.Count
    i = Request.Form
    d = "Dim "
    For i = 0 To l - 1
        j(i) = Split(Split(i, "&")(i), "=")(0)
        k(i) = Split(Split(i, "&")(i), "=")(1)
        c = c & j(i) & "|"
        d = d & j(i) & ", "
        g = g & j(i) & "=" & k(i) & "<br>"
        e = e & CopyStr("&nbsp;", 4) & j(i) & " = Trim(Rf(""" & j(i) & """))<br>"
        f = f & CopyStr("&nbsp;", 8) & "Rs(""" & j(i) & """) = " & j(i) & "<br>" & vbCrLf
        h = h & CopyStr("&nbsp;", 8) & j(i) & " = Rs(""" & j(i) & """) " & "<br>" & vbCrLf
    Next
    If Right(d, 2) = ", " Then d = Mid(d, 1, Len(d) - 2)
    Call rw("名称列表 ========<br>" & c & "<br>")
    Call rw("定义变量 ========<br>" & d & "<br>")
    Call rw("获得Form ========<br>" & e & "<br>")
    Call rw("ASP代码 ========<br>" & f & "<br>")
    Call rw("打印ASP ========<br>" & h & "<br>")
    Call rw("显示内容 ========<br>" & g & "<br>")
End Sub



Function dedeCMSMsg()
    Dim b
    b = "<style> " & vbCrLf
    b = b & ".msgbox {" & vbCrLf
    b = b & "    width: 450px;" & vbCrLf
    b = b & "    border: 1px solid #DADADA;" & vbCrLf
    b = b & "    margin:0 auto;" & vbCrLf
    b = b & "    margin-top:20px;" & vbCrLf
    b = b & "    line-height:20px;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & ".msgbox .ptitle{" & vbCrLf
    b = b & "    padding: 6px;" & vbCrLf
    b = b & "    font-size: 12px;" & vbCrLf
    b = b & "    border-bottom: 1px solid #DADADA;" & vbCrLf
    b = b & "    background: #DBEEBD url(/plus/img/wbg.gif);" & vbCrLf
    b = b & "    font-weight:bold;" & vbCrLf
    b = b & "    text-align:center;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & ".msgbox .pcontent{" & vbCrLf
    b = b & "    height: 100px;" & vbCrLf
    b = b & "    font-size: 10pt;" & vbCrLf
    b = b & "    background: #ffffff;" & vbCrLf
    b = b & "    text-align:center;" & vbCrLf
    b = b & "    padding-top:30px;" & vbCrLf
    b = b & "}" & vbCrLf
    b = b & "</style> " & vbCrLf
    b = b & "<div class=""msgbox"">" & vbCrLf
    b = b & "    <div class=""ptitle"">提示信息！</div>" & vbCrLf
    b = b & "    <div class=""pcontent"">" & vbCrLf
    b = b & "        成功登录，正在转向管理管理主页！<br>" & vbCrLf
    b = b & "        <a href=""#"">如果你的浏览器没反应，请点击这里...</a>" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "    </div>" & vbCrLf
    b = b & "</div>" & vbCrLf
    dedeCMSMsg = b
End Function
%>



