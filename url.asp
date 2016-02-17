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



dim url

if request("title")="手机B站" then
	response.Redirect("http://sharembweb.com/Tools/mobile/bwebold")
	
elseif request("title")="手机C站" then
	response.Redirect("http://sharembweb.com/Tools/mobile/cweb")

elseif request("title")="东方紫(2015)" then
	response.Redirect("http://www.dfz9.com/")

elseif request("title")="南京微战略(2014)" then
	response.Redirect("http://www.wzl99.com/")
	
elseif request("title")="南京瑞谷安隆(2014)" then
	response.Redirect("http://www.863health.com/")
	
elseif request("title")="南京元朗(2014)" then
	response.Redirect("http://ylkj11.com/")
	
elseif request("title")="金凤凰(2014)" then
	response.Redirect("http://www.jfh6666.com/")
	
	
	
elseif request("title")="南京麦思德(2013)" then
	response.Redirect("http://maiside.net/")
	
elseif request("title")="企业模板网站一(2010)" then
	response.Redirect("http://www.wxjiebao.com/")
	
elseif request("title")="企业模板网站二(2010)" then
	response.Redirect("http://www.laxiang8.com/")
	
elseif request("title")="企业模板网站三(2010)" then
	response.Redirect("http://www.021chaijiu.com/")

elseif request("title")="qq群35915100" then
	response.Redirect("http://shang.qq.com/wpa/qunwpa?idkey=253822bd485c454811141c731156d2ecd4dba04ecf647ce81dc97d16a563137b")	


elseif request("down")="admin5_20vericode" then				
	response.Redirect("http://down.admin5.com/asp/106437.html")
	
elseif request("down")="chinaz_20vericode" then
	response.Redirect("http://down.chinaz.com/soft/35264.htm")
	
elseif request("down")="csdn_20vericode" then
	response.Redirect("http://download.csdn.net/detail/mydd3/6712723")
	
elseif request("down")="jb51_20vericode" then
	response.Redirect("http://www.jb51.net/codes/118319.html")
	
elseif request("down")="codesky_20vericode" then
	response.Redirect("http://www.codesky.net/codedown/html/29007.htm")
	
elseif request("down")="onlinedown_20vericode" then
	response.Redirect("http://www.onlinedown.net/softdown/537626_2.htm")
	
elseif request("down")="mycodes_20vericode" then
	response.Redirect("http://www.mycodes.net/40/5912.htm")
	
elseif request("down")="fwvv_20vericode" then
	response.Redirect("http://www.fwvv.net/Software/View-Software-33811.shtml")
	

elseif request("down")="codedown_asptophpv1" then
	response.Redirect("http://www.codesky.net/codedown/html/30224.htm")
elseif request("down")="csdn_asptophpv1" then
	response.Redirect("http://download.csdn.net/detail/mydd3/9399270")
elseif request("down")="jb51_asptophpv1" then
	response.Redirect("http://www.jb51.net/codes/419460.html")
elseif request("down")="codesc_asptophpv1" then
	response.Redirect("http://www.codesc.net/source/6026.shtml")
elseif request("down")="asp300_asptophpv1" then
	response.Redirect("http://www.asp300.com/SoftView/10/SoftView_59634.html")
elseif request("down")="gpxz_asptophpv1" then
	response.Redirect("http://www.gpxz.com/yuanma/asp/qita/936898.html")
elseif request("down")="662p_asptophpv1" then
	response.Redirect("http://code.662p.com/view/12607.html")
elseif request("down")="wei2008_asptophpv1" then
	response.Redirect("http://www.wei2008.com/downinfo/90364.html")
	

elseif request("baidu")<>"" then			
	response.Redirect("https://www.baidu.com/s?ie=gb2312&word=" & request("baidu"))
	
elseif request("haosou")<>"" then
	response.Redirect("http://www.haosou.com/s?ie=gb2312&q=" & request("haosou"))
	
elseif request("sogou")<>"" then
	response.Redirect("https://www.sogou.com/sogou?query=" & request("sogou"))
	
elseif request("yahoo")<>"" then
	response.Redirect("https://search.yahoo.com/search;_ylt=A86.JmbkJatWH5YARmebvZx4?p="& request("yahoo") &"&toggle=1&cop=mss&ei=gb2312&fr=yfp-t-901&fp=1")
	
	
elseif request("act")="downaspvbs" then
	response.Redirect("http://sharembweb.com/Tools/downfile.asp?act=download&downfile=竮竽竤窻竵竧竤窺竢競竧")
	
elseif request("act")="fangzhan" then
	url = request("selectServer") & "?act=downweb&httpurl=" & request("httpurl") & "&verificationTime=" &  XorEnc(Now(), 31380) & "&Char_Set=" & request("Char_Set")
	response.Redirect(url)
end if


Function xorEnc(a, b)
    Dim c, d, e, f, g
    c = a
    d = Len(c) : f = ""
    For g = 0 To d - 1
        e = AscW(Right(c, d - g)) Xor b
        f = f & ChrW(Int(e))
    Next

    f = Replace(f, ChrW(34), "ㄨ")
    xorEnc = f
End Function

%>

