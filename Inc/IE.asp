<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-03
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
fUNcTIoN gETbRTyPE(a)
dIM b, c
gETbRTyPE = "Other Unknown"
iF a = "" tHEn
a = uCAsE(rEQuESt.sERvERvARiABlES("HTTP_USER_AGENT"))
eND iF
iF iNStR(a, uCAsE("mozilla")) > 0 tHEn gETbRTyPE = "Mozilla"
iF iNStR(a, uCAsE("icab")) > 0 tHEn gETbRTyPE = "iCab"
iF iNStR(a, uCAsE("lynx")) > 0 tHEn gETbRTyPE = "Lynx"
iF iNStR(a, uCAsE("links")) > 0 tHEn gETbRTyPE = "Links"
iF iNStR(a, uCAsE("elinks")) > 0 tHEn gETbRTyPE = "ELinks"
iF iNStR(a, uCAsE("jbrowser")) > 0 tHEn gETbRTyPE = "JBrowser"
iF iNStR(a, uCAsE("konqueror")) > 0 tHEn gETbRTyPE = "konqueror"
iF iNStR(a, uCAsE("wget")) > 0 tHEn gETbRTyPE = "wget"
iF iNStR(a, uCAsE("ask jeeves")) > 0 oR iNStR(a, uCAsE("teoma")) > 0 tHEn gETbRTyPE = "Ask Jeeves/Teoma"
iF iNStR(a, uCAsE("wget")) > 0 tHEn gETbRTyPE = "wget"
iF iNStR(a, uCAsE("opera")) > 0 tHEn gETbRTyPE = "opera"
iF iNStR(a, uCAsE("NOKIAN")) > 0 tHEn gETbRTyPE = "NOKIAN(诺基亚手机)"
iF iNStR(a, uCAsE("SPV")) > 0 tHEn gETbRTyPE = "SPV(多普达手机)"
iF iNStR(a, uCAsE("Jakarta Commons")) > 0 tHEn gETbRTyPE = "Jakarta Commons-HttpClient"
iF iNStR(a, uCAsE("Gecko")) > 0 tHEn
b = "[Gecko] "
gETbRTyPE = "Mozilla Series"
iF iNStR(a, uCAsE("aol")) > 0 tHEn gETbRTyPE = "AOL"
iF iNStR(a, uCAsE("netscape")) > 0 tHEn gETbRTyPE = "Netscape"
iF iNStR(a, uCAsE("firefox")) > 0 tHEn gETbRTyPE = "FireFox"
iF iNStR(a, uCAsE("chimera")) > 0 tHEn gETbRTyPE = "Chimera"
iF iNStR(a, uCAsE("camino")) > 0 tHEn gETbRTyPE = "Camino"
iF iNStR(a, uCAsE("galeon")) > 0 tHEn gETbRTyPE = "Galeon"
iF iNStR(a, uCAsE("k-meleon")) > 0 tHEn gETbRTyPE = "K-Meleon"
gETbRTyPE = b & gETbRTyPE
eND iF
iF iNStR(a, uCAsE("bot")) > 0 oR iNStR(a, uCAsE("crawl")) > 0 tHEn
b = "[Bot/Crawler]"
iF iNStR(a, uCAsE("grub")) > 0 tHEn gETbRTyPE = "Grub"
iF iNStR(a, uCAsE("googlebot")) > 0 tHEn gETbRTyPE = "GoogleBot"
iF iNStR(a, uCAsE("msnbot")) > 0 tHEn gETbRTyPE = "MSN Bot"
iF iNStR(a, uCAsE("slurp")) > 0 tHEn gETbRTyPE = "Yahoo! Slurp"
gETbRTyPE = b & gETbRTyPE
eND iF
iF iNStR(a, uCAsE("applewebkit")) > 0 tHEn
b = "[AppleWebKit]"
gETbRTyPE = ""
iF iNStR(a, uCAsE("omniweb")) > 0 tHEn gETbRTyPE = "OmniWeb"
iF iNStR(a, uCAsE("safari")) > 0 tHEn gETbRTyPE = "Safari"
gETbRTyPE = b & gETbRTyPE
eND iF
iF iNStR(a, uCAsE("msie")) > 0 tHEn
b = "[MSIE"
c = mID(a,(iNStR(a, uCAsE("MSIE")) + 4), 6)
c = lEFt(c, iNStR(c, ";") - 1)
b = b & c & "]"
gETbRTyPE = "Internet Explorer"
gETbRTyPE = b & gETbRTyPE
eND iF
iF iNStR(a, uCAsE("msn")) > 0 tHEn gETbRTyPE = "MSN"
iF iNStR(a, uCAsE("aol")) > 0 tHEn gETbRTyPE = "AOL"
iF iNStR(a, uCAsE("webtv")) > 0 tHEn gETbRTyPE = "WebTV"
iF iNStR(a, uCAsE("myie2")) > 0 tHEn gETbRTyPE = "MyIE2"
iF iNStR(a, uCAsE("maxthon")) > 0 tHEn gETbRTyPE = "Maxthon(傲游浏览器)"
iF iNStR(a, uCAsE("gosurf")) > 0 tHEn gETbRTyPE = "GoSurf(冲浪高手浏览器)"
iF iNStR(a, uCAsE("netcaptor")) > 0 tHEn gETbRTyPE = "NetCaptor"
iF iNStR(a, uCAsE("sleipnir")) > 0 tHEn gETbRTyPE = "Sleipnir"
iF iNStR(a, uCAsE("avant browser")) > 0 tHEn gETbRTyPE = "AvantBrowser"
iF iNStR(a, uCAsE("greenbrowser")) > 0 tHEn gETbRTyPE = "GreenBrowser"
iF iNStR(a, uCAsE("slimbrowser")) > 0 tHEn gETbRTyPE = "SlimBrowser"
iF iNStR(a, uCAsE("360SE")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-360SE(360安全浏览器)"
iF iNStR(a, uCAsE("QQDownload")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-QQDownload(QQ下载器)"
iF iNStR(a, uCAsE("TheWorld")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-TheWorld(世界之窗浏览器)"
iF iNStR(a, uCAsE("icafe8")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-icafe8(网维大师网吧管理插件)"
iF iNStR(a, uCAsE("TencentTraveler")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-TencentTraveler(腾讯TT浏览器)"
iF iNStR(a, uCAsE("baiduie8")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-baiduie8(百度IE8.0)"
iF iNStR(a, uCAsE("iCafeMedia")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-iCafeMedia(网吧网媒趋势插件)"
iF iNStR(a, uCAsE("DigExt")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-DigExt(IE5允许脱机阅读模式特殊标记)"
iF iNStR(a, uCAsE("baiduds")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-baiduds(百度硬盘搜索)"
iF iNStR(a, uCAsE("CNCDialer")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-CNCDialer(数控拨号)"
iF iNStR(a, uCAsE("NOKIAN85")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-NOKIAN85(诺基亚手机)"
iF iNStR(a, uCAsE("SPV_C600")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-SPV_C600(多普达C600)"
iF iNStR(a, uCAsE("Smartphone")) > 0 tHEn gETbRTyPE = gETbRTyPE & "-Smartphone(Windows Mobile for Smartphone Edition 操作系统的智能手机)"
eND fUNcTIoN
%>

