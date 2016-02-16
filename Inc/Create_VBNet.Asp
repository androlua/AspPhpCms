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
<!--#iNClUDe fILe = "Config.Asp"-->
<%
cALl cREaTEvBDiALoG()
sUB cREaTEvBDiALoG()
dIM b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r
dIM s,t,u,v,w,x
e="|Print.Asp|Access.Asp|Cai.Asp|EncDec.Asp|Function.Asp|GetWord.Asp|RegExp.Asp|StringNumber.Asp|XML.Asp|Time.Asp|URL.Asp|FSO.Asp|Check.Asp|Html.Asp|AdodbStream.Asp|Dictionary.Asp|PinYin.Asp|2014_Array.Asp|2014_Css.Asp|2014_GBUTF.Asp|2015_Formatting.Asp|2015_Param.Asp|2015_ASP.Asp|2015_Color.Asp|FunHTML.Asp|2015_PHP.Asp|2015_WebSql.Asp|2015_hexSwitch.Asp"
h="D:\WindowsApplication1\WindowsApplication1\zForm\Z_"
dIM y,z
b=sPLiT(e,"|")
fOR eACh j iN b
iF j <> "" aND 1=1 tHEn
l = mID(j,1,iNStRReV(j,".")-1)
iF iNStR("0123456789",lEFt(l,1))>0 tHEn
l="y_" & l	
eND iF
f = rEAdFIlE("/inc/" & j,"")	
y = gETsTRcUT(f,"'footer start","'footer end",2)
iF y<>"" tHEn
z=vBCrLF & gETfTExT("\DataDir\VB模块\2015_Param.Asp.txt")
f=rEPlACe(f,y,z)
cALl eCHo(j,"替换footer成功")
eND iF
fOR c = 1 tO 3
y = gETsTRcUT(f,"'NOVBNet start","'NOVBNet end",2)
iF y<>"" tHEn
f=rEPlACe(f,y,"")
eLSe
eXIt fOR
eND iF
nEXt
iF j = "ZClassAspCode.Asp" tHEn
eLSe
k = h & l & ".vb"
f = sTRcUT(f,"<" & "%","%" & ">",2)
f = "Module "& l & vBCrLF & f & vBCrLF & "End Module"
eND iF
s=f
f=rEPlACe(f,vBTaB,"    ")
f=aSPtOVb(f)
f=aSPtOVbNEt(f)
iF f="" tHEn
cALl eERr(l,s)
eND iF
v=sPLiT("GetThisUrl|ChkPost|GetUpdateFile|ShowErr|PrintFormInfo|popupDownFile|DownRemoteFile|c10to2|Agent|GetWebHome|WebDebug|GetThisUrlFileName|WebDoMain|checkUrlName|checkUrlName|HandleContentCode|replaceContentModule|replaceContentRowModule|||||||||","|")
fOR eACh w iN v
iF w<>"" tHEn
t="Function " & w
u="End Function"
d=gETsTRcUT(f,t,u,1)
iF d<>"" tHEn
x=""
t=mID(d,1,iNStR(d,")"))
iF w="GetFileText" tHEn	
x= vBCrLF & "Call HandlePath(filePath)    '获得完整路径 "& vBCrLF &"If IO.File.Exists(filePath) = True Then" & vBCrLF
x=x & "    Dim TxtReader As IO.StreamReader = New IO.StreamReader(filePath, System.Text.Encoding.Default)" & vBCrLF
x=x & "    MyTxtReader = TxtReader.ReadToEnd" & vBCrLF
x=x & "    TxtReader.Close()" & vBCrLF
x=x & "End If" & vBCrLF
eND iF
f=rEPlACe(f,d,  t & vBCrLF  & w & "=""" & x & vBCrLF & u)
eND iF
t="Sub " & w
u="End Sub"
d=gETsTRcUT(f,t,u,1)
iF d<>"" tHEn
f=rEPlACe(f,d,  t & vBCrLF & u)
eND iF
eND iF
nEXt
v=sPLiT("GetTimerSet|CalculationTimer|GetTimer|VBGetTimer|VBEchoTimer|ErrorText|||||||||||||","|")
fOR eACh w iN v
iF w<>"" tHEn
t="Sub " & w
u="End Sub"
d=gETsTRcUT(f,t,u,1)
iF d<>"" tHEn
f=rEPlACe(f,d,  "")
eND iF
t="Function " & w
u="End Function"
d=gETsTRcUT(f,t,u,1)
iF d<>"" tHEn
f=rEPlACe(f,d,  "")
eND iF
eND iF
nEXt
f=rEGeXP_REpLAcE(f,"If Err Then","If Err.Number Then")
f=rEGeXP_REpLAcE(f," Err <> 0 "," Err.Number <> 0 ")
f=rEGeXP_REpLAcE(f,"If Err Then","If Err.Numbe Then")
f=rEGeXP_REpLAcE(f,"Set xml ","xml")
f=rEGeXP_REpLAcE(f,"Set Stm ","Stm")
f=rEPlACe(f,"App.Path ","Application.StartupPath() ")	
f=rEPlACe(f,"C2 = ""撇揦：星？“左右横。，""","C2 = ""撇揦：星？"" &  chr(""-24144"") &  ""左右横。，""")
f=rEPlACe(f,"Cstr(Day(s_Time))","Cstr(Format(Now(), ""dd""))")	
f=rEPlACe(f," LenB("," Len(")
f=rEPlACe(f," AscB("," Asc(")
f=rEPlACe(f," MidB("," Mid(")
f=rEPlACe(f," ChrB("," Chr(")	
f=rEPlACe(f,"(LenB(","(Len(")
f=rEPlACe(f,"(AscB(","(Asc(")
f=rEPlACe(f,"(MidB(","(Mid(")
f=rEPlACe(f,"(ChrB(","(Chr(")	
f=rEPlACe(f,"""”""", "chr(-24143)" )	
f=rEPlACe(f,"""“""", "chr(-24144)" )	
f=rEPlACe(f,"D = Cstr(Day(timeStr))", "D = CStr(CDate(timeStr).Day)" )	 	
f = rEPlACe(f,vBTaB,"    ")	
cALl eCHo(l,k)
cALl cREaTEfILe(k,f)
eND iF
nEXt
eND sUB
%>

