<%Option Explicit%>
<!--#Include File = "Common.Asp"--> 
<!--#Include File = "Function.Asp"--> 
<!--#Include File = "FSO.Asp"--> 
<!--#Include File = "AdodbStream.Asp"--> 
<!--#Include File = "XML.Asp"--> 
<!--#Include File = "Time.Asp"--> 
<!--#Include File = "RegExp.Asp"--> 
<!--#Include File = "Cai.Asp"--> 
<!--#Include File = "StringNumber.Asp"--> 
<!--#Include File = "EncDec.Asp"--> 
<!--#Include File = "Dictionary.Asp"--> 
<!--#Include File = "Access.Asp"--> 
<!--#Include File = "Incpage.Asp"--> 
<!--#Include File = "Check.Asp"--> 
<!--#Include File = "GetWord.Asp"--> 
<!--#Include File = "Url.Asp"--> 
<!--#Include File = "Conn.Asp"--> 
 
<!--#Include File = "FunHTML.Asp"--> 
 
<!--#Include File = "Html.Asp"-->  
<!--#Include File = "Print.Asp"--> 
<!--#Include File = "Img.Asp"--> 
<!--#Include File = "PinYin.Asp"-->
<!--#Include File = "Md5.Asp"-->  
<!--#Include File = "IE.Asp"-->  
<!--#Include File = "ASPPHPAccess.Asp"-->    
<!--#Include File = "2014_Array.Asp"--> 
<!--#Include File = "2014_Js.Asp"--> 
<!--#Include File = "2014_Css.Asp"--> 
<!--#Include File = "2014_Template.Asp"-->   
   
<!--#Include File = "2014_GBUTF.Asp"-->   
<!--#Include File = "2014_Form.Asp"-->    
<!--#Include File = "2014_Doc.Asp"-->
<!--#Include File = "2014_Xls.Asp"-->
<!--#Include File = "2014_Cache.Asp"-->
<!--#Include File = "2014_Cookies.Asp"-->
<!--#Include File = "2014_Author.Asp"-->
<!--#Include File = "2015_Special.Asp"--> 
<!--#Include File = "2015_Formatting.Asp"--> 
<!--#Include File = "2015_Color.Asp"--> 
<!--#Include File = "2015_Param.Asp"-->
<!--#Include File = "2015_ASP.Asp"-->
<!--#Include File = "2015_BieRen.Asp"--> 
<!--#Include File = "2015_SqlIn.Asp"-->  
<!--#Include File = "2015_Json.Asp"-->
<!--#Include File = "2015_PHP.Asp"-->  
<!--#Include File = "2015_WebSql.Asp"-->
<!--#Include File = "2015_hexSwitch.Asp"-->  
<!--#Include File = "2015_APGeneral.Asp"-->  
<!--#Include File = "2015_ToMyPHP.Asp"-->   
<!--#Include File = "2015_Editor.Asp"-->   
<!--#Include File = "2015_Editor.Asp"-->    
<!--#Include File = "2015_NewWebFunction.Asp"-->   
<!--#Include File = "2016_WebControl.Asp"-->    
<!--#Include File = "2016_SaveData.Asp"-->      
<!--#Include File = "2016_Log.Asp"-->      
<!--#Include File = "SystemInfo.Asp"--> 
<% 

 
Server.ScriptTimeOut = 9999	'超时
Response.Addheader "Content-Type","text/html; charset=gb2312"
	'禁止缓冲
	Response.Buffer = True
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.CacheControl = "no-cache"
	Response.AddHeader "Expires",Date()
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "Cache-Control","private, no-cache, must-revalidate" 
dim Conn, Rs, Rsx, Rss, Rst, Rsd, TempRs, TempRs2, RsTemp
dim PubTimer : PubTimer = now()		'Timer()不要用这个(20150728)

'Note:开发程序原则，能简单，绝对不复杂，能修改html的，绝对不修改asp，能傻瓜式，绝对不要用脑(20160121)
Dim WEBCOLUMNTYPE : WEBCOLUMNTYPE = "首页|文本|产品|新闻|视频|下载|案例|留言|反馈|招聘|订单" 
Dim WEB_VIEWURL : WEB_VIEWURL = "/index.asp"                '前台显示
dim WEB_ADMINURL : WEB_ADMINURL ="/admin/index.asp"				'后台显示
Dim EDITORTYPE : EDITORTYPE = "asp"                                             '程序类型，是ASP,或PHP,或jSP,或.NET
MDBPath = "/Data/Data.mdb"
'=========

dim ReadBlockList

dim SysStyle(9)
SysStyle(0) = "#999999"
dim makeHtmlFileToLCase	 : makeHtmlFileToLCase=true		'生成HTML文件转小写
dim isWebLabelClose : isWebLabelClose=true					'闭合标签(20150831)

dim HandleisCache : HandleisCache=false						'缓冲是否处理了
Dim db_PREFIX : db_PREFIX = "xy_"    		                                         '表前缀
dim adminDir :adminDir="/admin/"							'后台目录


Dim openErrorLog : openErrorLog = true                                             '开启错误日志
Dim openWriteSystemLog : openWriteSystemLog = "|txt|database|"                                             '开启写系统日志 txt写入文本 database写入数据库
dim openTestEcho: openTestEcho=true											'开关测试回显
Dim webVersion : webVersion="ASPPHPCMS V1.02"												'网站版本

 
dim WEB_CACHEFile : WEB_CACHEFile="/admin/"& EDITORTYPE &"cachedata.txt"								'缓冲文件
dim WEB_CACHEContent : WEB_CACHEContent=""								'缓冲文件内容

 

%> 

