<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-29
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
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
<!--#Include File = "SystemInfo.Asp"--> 
<% 

 
Server.ScriptTimeOut = 9999	'��ʱ
Response.Addheader "Content-Type","text/html; charset=gb2312"
	'��ֹ����
	Response.Buffer = True
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.CacheControl = "no-cache"
	Response.AddHeader "Expires",Date()
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "Cache-Control","private, no-cache, must-revalidate" 
dim Conn, Rs, Rsx, Rss, Rst, Rsd, TempRs, TempRs2, RsTemp
dim PubTimer : PubTimer = now()		'Timer()��Ҫ�����(20150728)

'Note:��������ԭ���ܼ򵥣����Բ����ӣ����޸�html�ģ����Բ��޸�asp����ɵ��ʽ�����Բ�Ҫ����(20160121)
Dim WEBCOLUMNTYPE : WEBCOLUMNTYPE = "��ҳ|�ı�|��Ʒ|����|��Ƶ|����|����|����|����|��Ƹ|����" 
Dim WEB_VIEWURL : WEB_VIEWURL = "/index.asp"                'ǰ̨��ʾ
dim WEB_ADMINURL : WEB_ADMINURL ="/admin/index.asp"				'��̨��ʾ
Dim EDITORTYPE : EDITORTYPE = "asp"                                             '�������ͣ���ASP,��PHP,��jSP,��.NET
'=========


dim SysStyle(9)
SysStyle(0) = "#999999"
dim makeHtmlFileToLCase	 : makeHtmlFileToLCase=true		'����HTML�ļ�תСд
dim isWebLabelClose : isWebLabelClose=true					'�պϱ�ǩ(20150831)

dim HandleisCache : HandleisCache=false						'�����Ƿ�����
Dim db_PREFIX : db_PREFIX = "xy_"    		                                         '��ǰ׺
dim adminDir :adminDir="/admin/"							'��̨Ŀ¼

dim onOffEcho: onOffEcho=true											'���ز��Ի���
Dim webVersion : webVersion="ASPPHPCMS V1.01"												'��վ�汾

 
dim WEB_CACHEFile : WEB_CACHEFile="/admin/"& EDITORTYPE &"cachedata.txt"								'�����ļ�
dim WEB_CACHEContent : WEB_CACHEContent=""								'�����ļ�����

 

%> 
