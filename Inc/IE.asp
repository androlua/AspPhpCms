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



Function getBrType(a)
    Dim b, c
    getBrType = "Other Unknown"
    If a = "" Then
        a = UCase(Request.ServerVariables("HTTP_USER_AGENT"))
    End If
    If InStr(a, UCase("mozilla")) > 0 Then getBrType = "Mozilla"
    If InStr(a, UCase("icab")) > 0 Then getBrType = "iCab"
    If InStr(a, UCase("lynx")) > 0 Then getBrType = "Lynx"
    If InStr(a, UCase("links")) > 0 Then getBrType = "Links"
    If InStr(a, UCase("elinks")) > 0 Then getBrType = "ELinks"
    If InStr(a, UCase("jbrowser")) > 0 Then getBrType = "JBrowser"
    If InStr(a, UCase("konqueror")) > 0 Then getBrType = "konqueror"
    If InStr(a, UCase("wget")) > 0 Then getBrType = "wget"
    If InStr(a, UCase("ask jeeves")) > 0 Or InStr(a, UCase("teoma")) > 0 Then getBrType = "Ask Jeeves/Teoma"
    If InStr(a, UCase("wget")) > 0 Then getBrType = "wget"
    If InStr(a, UCase("opera")) > 0 Then getBrType = "opera"
    If InStr(a, UCase("NOKIAN")) > 0 Then getBrType = "NOKIAN(诺基亚手机)"
    If InStr(a, UCase("SPV")) > 0 Then getBrType = "SPV(多普达手机)"
    If InStr(a, UCase("Jakarta Commons")) > 0 Then getBrType = "Jakarta Commons-HttpClient"
    If InStr(a, UCase("Gecko")) > 0 Then
        b = "[Gecko] "
        getBrType = "Mozilla Series"
        If InStr(a, UCase("aol")) > 0 Then getBrType = "AOL"
        If InStr(a, UCase("netscape")) > 0 Then getBrType = "Netscape"
        If InStr(a, UCase("firefox")) > 0 Then getBrType = "FireFox"
        If InStr(a, UCase("chimera")) > 0 Then getBrType = "Chimera"
        If InStr(a, UCase("camino")) > 0 Then getBrType = "Camino"
        If InStr(a, UCase("galeon")) > 0 Then getBrType = "Galeon"
        If InStr(a, UCase("k-meleon")) > 0 Then getBrType = "K-Meleon"
        getBrType = b & getBrType
    End If
    If InStr(a, UCase("bot")) > 0 Or InStr(a, UCase("crawl")) > 0 Then
        b = "[Bot/Crawler]"
        If InStr(a, UCase("grub")) > 0 Then getBrType = "Grub"
        If InStr(a, UCase("googlebot")) > 0 Then getBrType = "GoogleBot"
        If InStr(a, UCase("msnbot")) > 0 Then getBrType = "MSN Bot"
        If InStr(a, UCase("slurp")) > 0 Then getBrType = "Yahoo! Slurp"
        getBrType = b & getBrType
    End If
    If InStr(a, UCase("applewebkit")) > 0 Then
        b = "[AppleWebKit]"
        getBrType = ""
        If InStr(a, UCase("omniweb")) > 0 Then getBrType = "OmniWeb"
        If InStr(a, UCase("safari")) > 0 Then getBrType = "Safari"
        getBrType = b & getBrType
    End If
    If InStr(a, UCase("msie")) > 0 Then
        b = "[MSIE"
        c = Mid(a,(InStr(a, UCase("MSIE")) + 4), 6)
        c = Left(c, InStr(c, ";") - 1)
        b = b & c & "]"
        getBrType = "Internet Explorer"
        getBrType = b & getBrType
    End If
    If InStr(a, UCase("msn")) > 0 Then getBrType = "MSN"
    If InStr(a, UCase("aol")) > 0 Then getBrType = "AOL"
    If InStr(a, UCase("webtv")) > 0 Then getBrType = "WebTV"
    If InStr(a, UCase("myie2")) > 0 Then getBrType = "MyIE2"
    If InStr(a, UCase("maxthon")) > 0 Then getBrType = "Maxthon(傲游浏览器)"
    If InStr(a, UCase("gosurf")) > 0 Then getBrType = "GoSurf(冲浪高手浏览器)"
    If InStr(a, UCase("netcaptor")) > 0 Then getBrType = "NetCaptor"
    If InStr(a, UCase("sleipnir")) > 0 Then getBrType = "Sleipnir"
    If InStr(a, UCase("avant browser")) > 0 Then getBrType = "AvantBrowser"
    If InStr(a, UCase("greenbrowser")) > 0 Then getBrType = "GreenBrowser"
    If InStr(a, UCase("slimbrowser")) > 0 Then getBrType = "SlimBrowser"
    If InStr(a, UCase("360SE")) > 0 Then getBrType = getBrType & "-360SE(360安全浏览器)"
    If InStr(a, UCase("QQDownload")) > 0 Then getBrType = getBrType & "-QQDownload(QQ下载器)"
    If InStr(a, UCase("TheWorld")) > 0 Then getBrType = getBrType & "-TheWorld(世界之窗浏览器)"
    If InStr(a, UCase("icafe8")) > 0 Then getBrType = getBrType & "-icafe8(网维大师网吧管理插件)"
    If InStr(a, UCase("TencentTraveler")) > 0 Then getBrType = getBrType & "-TencentTraveler(腾讯TT浏览器)"
    If InStr(a, UCase("baiduie8")) > 0 Then getBrType = getBrType & "-baiduie8(百度IE8.0)"
    If InStr(a, UCase("iCafeMedia")) > 0 Then getBrType = getBrType & "-iCafeMedia(网吧网媒趋势插件)"
    If InStr(a, UCase("DigExt")) > 0 Then getBrType = getBrType & "-DigExt(IE5允许脱机阅读模式特殊标记)"
    If InStr(a, UCase("baiduds")) > 0 Then getBrType = getBrType & "-baiduds(百度硬盘搜索)"
    If InStr(a, UCase("CNCDialer")) > 0 Then getBrType = getBrType & "-CNCDialer(数控拨号)"
    If InStr(a, UCase("NOKIAN85")) > 0 Then getBrType = getBrType & "-NOKIAN85(诺基亚手机)"
    If InStr(a, UCase("SPV_C600")) > 0 Then getBrType = getBrType & "-SPV_C600(多普达C600)"
    If InStr(a, UCase("Smartphone")) > 0 Then getBrType = getBrType & "-Smartphone(Windows Mobile for Smartphone Edition 操作系统的智能手机)"
End Function
%>

