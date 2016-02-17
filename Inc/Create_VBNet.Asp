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
<!--#Include File = "Config.Asp"-->

<%


call CreateVBDialog()
Sub CreateVBDialog()
	Dim b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r
	dim s,t,u,v,w,x
	e="|Print.Asp|Access.Asp|Cai.Asp|EncDec.Asp|Function.Asp|GetWord.Asp|RegExp.Asp|StringNumber.Asp|XML.Asp|Time.Asp|URL.Asp|FSO.Asp|Check.Asp|Html.Asp|AdodbStream.Asp|Dictionary.Asp|PinYin.Asp|2014_Array.Asp|2014_Css.Asp|2014_GBUTF.Asp|2015_Formatting.Asp|2015_Param.Asp|2015_ASP.Asp|2015_Color.Asp|FunHTML.Asp|2015_PHP.Asp|2015_WebSql.Asp|2015_hexSwitch.Asp"
	
	h="D:\WindowsApplication1\WindowsApplication1\zForm\Z_"
	
	
	dim y,z
	
	b=Split(e,"|")
	For Each j In b
		If j <> "" And 1=1 Then
			l = Mid(j,1,InStrRev(j,".")-1)
			
			If InStr("0123456789",Left(l,1))>0 Then
				l="y_" & l							
			End If
			f = ReadFile("/inc/" & j,"")		
			
			y = getStrCut(f,"'footer start","'footer end",2)
			if y<>"" then
				z=vbcrlf & getftext("\DataDir\VB模块\2015_Param.Asp.txt")
				f=replace(f,y,z)
				call echo(j,"替换footer成功")
			end if
			
			for c = 1 to 3
				y = getStrCut(f,"'NOVBNet start","'NOVBNet end",2)
				if y<>"" then
					f=replace(f,y,"")
				else
					exit for
				end if
			next
			
			If j = "ZClassAspCode.Asp" Then

			
			Else
				k = h & l & ".vb"
				f = StrCut(f,"<" & "%","%" & ">",2)
				f = "Module "& l & vbCrlf & f & vbcrlf & "End Module"
			End If
			s=f
			f=replace(f,vbtab,"    ")
			f=ASPToVB(f)
			f=ASPToVBNET(f)
			
			
			if f="" then
				call eerr(l,s)
			end if
			


			
			v=split("GetThisUrl|ChkPost|GetUpdateFile|ShowErr|PrintFormInfo|popupDownFile|DownRemoteFile|c10to2|Agent|GetWebHome|WebDebug|GetThisUrlFileName|WebDoMain|checkUrlName|checkUrlName|HandleContentCode|replaceContentModule|replaceContentRowModule|||||||||","|")
			for each w in v
				if w<>"" then
					t="Function " & w
					u="End Function"
					d=GetStrCut(f,t,u,1)
					if d<>"" then
						x=""
					
					 	t=mid(d,1,instr(d,")"))
						if w="GetFileText" then					
							x= vbcrlf & "Call HandlePath(filePath)    '获得完整路径 "& vbcrlf &"If IO.File.Exists(filePath) = True Then" & vbcrlf
							x=x & "    Dim TxtReader As IO.StreamReader = New IO.StreamReader(filePath, System.Text.Encoding.Default)" & vbcrlf
							x=x & "    MyTxtReader = TxtReader.ReadToEnd" & vbcrlf
							x=x & "    TxtReader.Close()" & vbcrlf
							x=x & "End If" & vbcrlf
						end if
						f=replace(f,d,  t & vbcrlf  & w & "=""" & x & vbcrlf & u)
					end if
					
					t="Sub " & w
					u="End Sub"
					d=GetStrCut(f,t,u,1)
					if d<>"" then
						f=replace(f,d,  t & vbcrlf & u)
					end if
				end if
			next

			
			v=split("GetTimerSet|CalculationTimer|GetTimer|VBGetTimer|VBEchoTimer|ErrorText|||||||||||||","|")
			for each w in v
				if w<>"" then
					t="Sub " & w
					u="End Sub"
					d=GetStrCut(f,t,u,1)
					if d<>"" then
						f=replace(f,d,  "")
					end if
					
					t="Function " & w
					u="End Function"
					d=GetStrCut(f,t,u,1)
					if d<>"" then
						f=replace(f,d,  "")
					end if
				end if
			next
			
			
			f=RegExp_Replace(f,"If Err Then","If Err.Number Then")
			f=RegExp_Replace(f," Err <> 0 "," Err.Number <> 0 ")
			f=RegExp_Replace(f,"If Err Then","If Err.Numbe Then")
			f=RegExp_Replace(f,"Set xml ","xml")
			f=RegExp_Replace(f,"Set Stm ","Stm")
			
			
			
			
			
			f=replace(f,"App.Path ","Application.StartupPath() ")				
			f=replace(f,"C2 = ""撇揦：星？“左右横。，""","C2 = ""撇揦：星？"" &  chr(""-24144"") &  ""左右横。，""")
			
			f=replace(f,"Cstr(Day(s_Time))","Cstr(Format(Now(), ""dd""))")				
			
			
			
			f=replace(f," LenB("," Len(")
			f=replace(f," AscB("," Asc(")
			f=replace(f," MidB("," Mid(")
			f=replace(f," ChrB("," Chr(")	
			
			f=replace(f,"(LenB(","(Len(")
			f=replace(f,"(AscB(","(Asc(")
			f=replace(f,"(MidB(","(Mid(")
			f=replace(f,"(ChrB(","(Chr(")	
			
			f=replace(f,"""”""", "chr(-24143)" )	
			f=replace(f,"""“""", "chr(-24144)" )	
			f=replace(f,"D = Cstr(Day(timeStr))", "D = CStr(CDate(timeStr).Day)" )	 	
			
			
			
			f = Replace(f,vbTab,"    ")			
			Call Echo(l,k)
			Call CreateFile(k,f)
		End If
	Next
end sub
%>

