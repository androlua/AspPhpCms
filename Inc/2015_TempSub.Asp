<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-24
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By 云端 
'************************************************************
%>
<%
'2015暂存函数

'读取二进制文件处理成数字方式  测试
Function BinaryReadFile2(FilePath)
    Dim I, nR, C, Stm,s,n,buf()
	'on error resume next
    Call HandlePath(FilePath)                                                       '获得完整路径
    Set Stm = CreateObject("ADODB.Stream")
        Stm.Mode = 3 
        Stm.Type = 1 
        Stm.Open 
        Stm.LoadFromFile(FilePath) 
        C = "" : I = 0 : nR = 1
		ReDim buf(Stm.Size)
        While I < Stm.Size
            s = ascB(Stm.Read(nR))
			n=Cint(s)
			if n=13 then
				n=10
			end if
			call echo(i,s)
            DoEvents 
			buf(I) = CByte(CInt(n))
			C = C & s & "|"
            I = I + nR
            DoEvents 
        Wend 
    Set Stm = Nothing 
    BinaryReadFile2 = C 
	Call WriteBinary("/222.html", buf) 
End Function 

'获得本地收藏夹列表
Sub GetFavoritesUrlList()
	Dim Content,FolderPath,UrlList,S,C,SplStr,Url,nOK
	FolderPath="E:\E盘\WEB网站\至前网站\Favorites"
	Content=GetFileFolderList(FolderPath, True, "url", "", "全部文件夹", "", "") 
	SplStr=Split(Content,vbCrlf)
	nOK=0
	For Each S In SplStr
		If S<>"" Then
			C=GetFText(S)
			Url = GetStrCut(C,"BASEURL=",vbCrlf,0)
			If Url<>"" And InStr(Url,"127.0.0.1")=False And InStr(vbCrlf & UrlList & vbcrlf, vbCrlf & Url & vbCrlf)=False And Len(Url)<200 Then
				UrlList=UrlList & Url & "|" & nOK & ".html" & vbCrlf
				nOK=nOK+1
			End If
		End If
	Next
	Call Echo("共有记录",nOK):Call Rw(CopyStr(vbCrlf,5))
	Call RwEnd(UrlList)
	Call Echo("显示",Content)
End Sub
%>
