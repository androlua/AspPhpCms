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
iF rEQuESt("title")="手机B站" tHEn
rESpONsE.rEDiREcT("http://sharembweb.com/Tools/mobile/bwebold")
eLSeIF rEQuESt("title")="手机C站" tHEn
rESpONsE.rEDiREcT("http://sharembweb.com/Tools/mobile/cweb")
eLSeIF rEQuESt("title")="东方紫(2015)" tHEn
rESpONsE.rEDiREcT("http://www.dfz9.com/")
eLSeIF rEQuESt("title")="南京微战略(2014)" tHEn
rESpONsE.rEDiREcT("http://www.wzl99.com/")
eLSeIF rEQuESt("title")="南京瑞谷安隆(2014)" tHEn
rESpONsE.rEDiREcT("http://www.863health.com/")
eLSeIF rEQuESt("title")="南京元朗(2014)" tHEn
rESpONsE.rEDiREcT("http://ylkj11.com/")
eLSeIF rEQuESt("title")="金凤凰(2014)" tHEn
rESpONsE.rEDiREcT("http://www.jfh6666.com/")
eLSeIF rEQuESt("title")="南京麦思德(2013)" tHEn
rESpONsE.rEDiREcT("http://maiside.net/")
eLSeIF rEQuESt("title")="企业模板网站一(2010)" tHEn
rESpONsE.rEDiREcT("http://www.wxjiebao.com/")
eLSeIF rEQuESt("title")="企业模板网站二(2010)" tHEn
rESpONsE.rEDiREcT("http://www.laxiang8.com/")
eLSeIF rEQuESt("title")="企业模板网站三(2010)" tHEn
rESpONsE.rEDiREcT("http://www.021chaijiu.com/")
eLSeIF rEQuESt("title")="qq群35915100" tHEn
rESpONsE.rEDiREcT("http://shang.qq.com/wpa/qunwpa?idkey=253822bd485c454811141c731156d2ecd4dba04ecf647ce81dc97d16a563137b")	
eLSeIF rEQuESt("down")="admin5_20vericode" tHEn	
rESpONsE.rEDiREcT("http://down.admin5.com/asp/106437.html")
eLSeIF rEQuESt("down")="chinaz_20vericode" tHEn
rESpONsE.rEDiREcT("http://down.chinaz.com/soft/35264.htm")
eLSeIF rEQuESt("down")="csdn_20vericode" tHEn
rESpONsE.rEDiREcT("http://download.csdn.net/detail/mydd3/6712723")
eLSeIF rEQuESt("down")="jb51_20vericode" tHEn
rESpONsE.rEDiREcT("http://www.jb51.net/codes/118319.html")
eLSeIF rEQuESt("down")="codesky_20vericode" tHEn
rESpONsE.rEDiREcT("http://www.codesky.net/codedown/html/29007.htm")
eLSeIF rEQuESt("down")="onlinedown_20vericode" tHEn
rESpONsE.rEDiREcT("http://www.onlinedown.net/softdown/537626_2.htm")
eLSeIF rEQuESt("down")="mycodes_20vericode" tHEn
rESpONsE.rEDiREcT("http://www.mycodes.net/40/5912.htm")
eLSeIF rEQuESt("down")="fwvv_20vericode" tHEn
rESpONsE.rEDiREcT("http://www.fwvv.net/Software/View-Software-33811.shtml")
eLSeIF rEQuESt("down")="codedown_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://www.codesky.net/codedown/html/30224.htm")
eLSeIF rEQuESt("down")="csdn_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://download.csdn.net/detail/mydd3/9399270")
eLSeIF rEQuESt("down")="jb51_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://www.jb51.net/codes/419460.html")
eLSeIF rEQuESt("down")="codesc_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://www.codesc.net/source/6026.shtml")
eLSeIF rEQuESt("down")="asp300_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://www.asp300.com/SoftView/10/SoftView_59634.html")
eLSeIF rEQuESt("down")="gpxz_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://www.gpxz.com/yuanma/asp/qita/936898.html")
eLSeIF rEQuESt("down")="662p_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://code.662p.com/view/12607.html")
eLSeIF rEQuESt("down")="wei2008_asptophpv1" tHEn
rESpONsE.rEDiREcT("http://www.wei2008.com/downinfo/90364.html")
eLSeIF rEQuESt("baidu")<>"" tHEn	
rESpONsE.rEDiREcT("https://www.baidu.com/s?ie=gb2312&word=" & rEQuESt("baidu"))
eLSeIF rEQuESt("haosou")<>"" tHEn
rESpONsE.rEDiREcT("http://www.haosou.com/s?ie=gb2312&q=" & rEQuESt("haosou"))
eLSeIF rEQuESt("sogou")<>"" tHEn
rESpONsE.rEDiREcT("https://www.sogou.com/sogou?query=" & rEQuESt("sogou"))
eLSeIF rEQuESt("yahoo")<>"" tHEn
rESpONsE.rEDiREcT("https://search.yahoo.com/search;_ylt=A86.JmbkJatWH5YARmebvZx4?p="& rEQuESt("yahoo") &"&toggle=1&cop=mss&ei=gb2312&fr=yfp-t-901&fp=1")
eLSeIF rEQuESt("act")="downaspvbs" tHEn
rESpONsE.rEDiREcT("http://sharembweb.com/Tools/downfile.asp?act=download&downfile=竮竽竤窻竵竧竤窺竢競竧")
eND iF
%> 
