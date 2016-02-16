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
sUB fORmSUbMIt()
dIM b,c,d,e,f,g,h
cALl oPEnCOnN()
c=sPLiT(rEQuESt.fORm(),"&")
b = rF("TableName")
h = tRIm(rF("YZM"))
iF h<>"" tHEn
iF sESsIOn("YZM") <>h tHEn
cALl jAVaSCrIPt("返回", "验证码不正确", "")
rESpONsE.eND()
eND iF
eND iF
g = lCAsE(gETfIElDLiST(b))
rS.oPEn"Select * From ["& b &"]",cONn,1,3
rS.aDDnEW
fOR eACh d iN c
e = lCAsE(mID(d,1,iNStR(d,"=")-1))
f = rF(e)
iF iNStR(","& g &",", ","& e &",")>0 tHEn
rS(e)=f
eND iF
nEXt
rS.uPDaTE:rS.cLOsE
cALl jAVaSCrIPt("返回", "提交"& rF("DialogTitle") &"成功", "")
eND sUB
%>


