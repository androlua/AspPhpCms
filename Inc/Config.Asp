<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-01
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%oPTiON eXPlICiT%>
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
<!--#Include File = "Fun_Table.Asp"-->
<!--#Include File = "FunHTML.Asp"-->
<!--#Include File = "ProductGl.Asp"-->
<!--#Include File = "Html.Asp"-->
<!--#Include File = "AutoAdd.Asp"-->
<!--#Include File = "Web2014.Asp"-->
<!--#Include File = "Print.Asp"-->
<!--#Include File = "Img.Asp"-->
<!--#Include File = "PinYin.Asp"-->
<!--#Include File = "Md5.Asp"-->
<!--#Include File = "Function2014.Asp"-->
<!--#Include File = "2014_Links.Asp"-->
<!--#Include File = "2014_MainInfo.Asp"-->
<!--#Include File = "2014_News.Asp"-->
<!--#Include File = "2014_Banner.Asp"-->
<!--#Include File = "2014_Array.Asp"-->
<!--#Include File = "2014_Js.Asp"-->
<!--#Include File = "2014_Css.Asp"-->
<!--#Include File = "2014_Template.Asp"-->
<!--#Include File = "2014_Action.Asp"-->
<!--#Include File = "2014_Nav.Asp"-->
<!--#Include File = "2014_Class.Asp"-->
<!--#Include File = "2014_Search.Asp"-->
<!--#Include File = "2014_GBUTF.Asp"-->
<!--#Include File = "2014_Form.Asp"-->
<!--#Include File = "2014_SiteMap.Asp"-->
<!--#Include File = "2014_NetWorkClass.Asp"-->
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
<!--#Include File = "ASPPHPAccess.Asp"-->
<!--#Include File = "2015_NewWebFunction.Asp"-->
<!--#Include File = "ZClass_YouKou.Asp"-->
<!--#Include File = "ZClass_Maiside.Asp"-->
<!--#Include File = "SystemInfo.Asp"-->
<%
sERvER.sCRiPTtIMeOUt = 9999	
pUBlIC dB, cONn, rS, rSX, rSS, rST, rSD, tEMpRS, tEMpRS2, rSTeMP
pUBlIC nCOuNT, nPAgESiZE, mAXpAGe, pAGe
pUBlIC wEBtITlE, wEBuRL, wEBkEYwORdS, wEBdEScRIpTIoN, tEMpLAtEPaTH, tEMpLAtECoNTeNT, cREaTEhTMlPAtH, cLAsSStR, cREaTEpAGe
dIM mAInNAv,mAInTItLE,mAInCOnTEnT
pUBlIC sYSsTYlE(9)
pUBlIC pUBtIMeR : pUBtIMeR = nOW()	
pUBlIC pUBnAVdID,pUBnAVsID,pUBpROdID,pUBpROsID,pUBpROtID,pUBaCTiONtYPe,pUBiD,pUBcLAsSNaME,pUBwD
dIM pUBnAVtYPe	
pUBlIC rEAdBLoCKlISt	
pUBlIC eXEcUTeREsUT	
dIM mAKeHTmLFiLEtOLcASe	 : mAKeHTmLFiLEtOLcASe=tRUe	
dIM iSWeBLaBElCLoSE : iSWeBLaBElCLoSE=tRUe	
dIM hANdLEiSCaCHe : hANdLEiSCaCHe=fALsE	
sYSsTYlE(0) = "#999999"
rESpONsE.aDDhEAdER "Content-Type","text/html; charset=gb2312"
rESpONsE.bUFfER = tRUe
rESpONsE.eXPiREs = 0
rESpONsE.eXPiREsABsOLuTE = nOW() - 1
rESpONsE.cAChECoNTrOL = "no-cache"
rESpONsE.aDDhEAdER "Expires",dATe()
rESpONsE.aDDhEAdER "Pragma","no-cache"
rESpONsE.aDDhEAdER "Cache-Control","private, no-cache, must-revalidate"
sELeCT cASe rEQuESt("A")
cASe "HandWebImgPath" : 	
cALl oPEnCOnN()
rS.oPEn"Select * From [Product]",cONn,1,3
cALl eCHo("表[Product]", "共有数据["& rS.rECoRDcOUnT &"]条")
dOEvENtS
wHIlE nOT rS.eOF
rS("Banner") = hANdLEhTTpURl(rS("Banner"))
rS("BigFiles") = hANdLEhTTpURl(rS("BigFiles"))
rS("SmallFiles") = hANdLEhTTpURl(rS("SmallFiles"))
rS.uPDaTE
dOEvENtS
rS.mOVeNExT:wENd:rS.cLOsE
cALl eCHo("把数据库中\改成/","完成")
rESpONsE.eND()
eND sELeCT
%>

