<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-17
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By �ƶ� 
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
    If InStr(a, UCase("NOKIAN")) > 0 Then getBrType = "NOKIAN(ŵ�����ֻ�)"
    If InStr(a, UCase("SPV")) > 0 Then getBrType = "SPV(���մ��ֻ�)"
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
    If InStr(a, UCase("maxthon")) > 0 Then getBrType = "Maxthon(���������)"
    If InStr(a, UCase("gosurf")) > 0 Then getBrType = "GoSurf(���˸��������)"
    If InStr(a, UCase("netcaptor")) > 0 Then getBrType = "NetCaptor"
    If InStr(a, UCase("sleipnir")) > 0 Then getBrType = "Sleipnir"
    If InStr(a, UCase("avant browser")) > 0 Then getBrType = "AvantBrowser"
    If InStr(a, UCase("greenbrowser")) > 0 Then getBrType = "GreenBrowser"
    If InStr(a, UCase("slimbrowser")) > 0 Then getBrType = "SlimBrowser"
    If InStr(a, UCase("360SE")) > 0 Then getBrType = getBrType & "-360SE(360��ȫ�����)"
    If InStr(a, UCase("QQDownload")) > 0 Then getBrType = getBrType & "-QQDownload(QQ������)"
    If InStr(a, UCase("TheWorld")) > 0 Then getBrType = getBrType & "-TheWorld(����֮�������)"
    If InStr(a, UCase("icafe8")) > 0 Then getBrType = getBrType & "-icafe8(��ά��ʦ���ɹ�����)"
    If InStr(a, UCase("TencentTraveler")) > 0 Then getBrType = getBrType & "-TencentTraveler(��ѶTT�����)"
    If InStr(a, UCase("baiduie8")) > 0 Then getBrType = getBrType & "-baiduie8(�ٶ�IE8.0)"
    If InStr(a, UCase("iCafeMedia")) > 0 Then getBrType = getBrType & "-iCafeMedia(������ý���Ʋ��)"
    If InStr(a, UCase("DigExt")) > 0 Then getBrType = getBrType & "-DigExt(IE5�����ѻ��Ķ�ģʽ������)"
    If InStr(a, UCase("baiduds")) > 0 Then getBrType = getBrType & "-baiduds(�ٶ�Ӳ������)"
    If InStr(a, UCase("CNCDialer")) > 0 Then getBrType = getBrType & "-CNCDialer(���ز���)"
    If InStr(a, UCase("NOKIAN85")) > 0 Then getBrType = getBrType & "-NOKIAN85(ŵ�����ֻ�)"
    If InStr(a, UCase("SPV_C600")) > 0 Then getBrType = getBrType & "-SPV_C600(���մ�C600)"
    If InStr(a, UCase("Smartphone")) > 0 Then getBrType = getBrType & "-Smartphone(Windows Mobile for Smartphone Edition ����ϵͳ�������ֻ�)"
End Function
%>

