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
'XML Microsoft.XMLHTTP组件操作大全 (2013,9,27)
'下载远程文件  [出错时 待完善] Call SaveRemoteFile(RemoteFileUrl, LocalFileName)
Function SaveRemoteFile(ByVal RemoteFileurl, ByVal LocalFileName)
    On Error Resume Next
    SaveRemoteFile = 0 
    Dim Ads, xmlHTTP, GetRemoteData 
    Call HandlePath(LocalFileName) '获得完整路径
    Set xmlHTTP = CreateObject("Microsoft.XMLHTTP")
        With xmlHTTP
            .Open "Get", RemoteFileurl, False, "", "" 'Flase同步,True异步
            .send 
            If Err Then
                SaveRemoteFile = 9999 : Exit Function '[网址错误]
            End If 
            GetRemoteData =.responseBody 
            SaveRemoteFile =.Status 
        End With 
    Set xmlHTTP = Nothing 
    Set Ads = CreateObject("ADODB.Stream")
        With Ads
            .Type = 1 
            .Open 
            .Write GetRemoteData 
            'Response.Write("<br><b>["&LocalFileName&"]</b><br>")
            .SaveToFile LocalFileName, 2 
            .Cancel 
            .Close 
        End With 
    Set Ads = Nothing 
    If Err Then DoError Err.Description, "SaveRemoteFile 下载远程文件 函数出错，RemoteFileUrl=" & RemoteFileurl & "<hr>LocalFileName=" & LocalFileName 
End Function
 

'下载远程文件 (辅助)
Function DownFile(RemoteFileurl, LocalFileName)
    DownFile = SaveRemoteFile(RemoteFileurl, LocalFileName) 
End Function
 

'下载文件程序
Function popupDownFile(Path)
    Dim OSM, SZ 
    Call HandlePath(Path) '获得完整路径
    Response.Clear 
    Set OSM = CreateObject("ADODB.Stream")
        OSM.Open 
        OSM.Type = 1 
        OSM.LoadFromFile Path 
        SZ = InStrRev(Path, "\") + 1 
        Response.AddHeader "Content-Disposition", "attachment; filename=" & Mid(Path, SZ) 
        Response.AddHeader "Content-Length", OSM.Size 
        Response.Charset = "UTF-8" 
        Response.ContentType = "application/octet-stream" 
        Response.BinaryWrite OSM.Read 
        Response.Flush 
        Response.Write("") 
        OSM.Close 
    Set OSM = Nothing 
End Function
 



'用xml获得网页状态
Function XMLGetStatus(ByVal Url)
    On Error Resume Next 
    Dim Http 
    Set Http = CreateObject("Microsoft.XMLHTTP")
        With Http
            .Open "Get", Url, False 
            .setRequestHeader "cache-control", "no-cache" 
            .setRequestHeader "Content-Type", "application/x-www-form-urlencoded" 
            .send 
            XMLGetStatus =.Status 
        End With 
    Set Http = Nothing 
    'responseBody： 结果返回为无符号整数数组。
    'responseStream： 结果返回为IStream流。
    'responseText ： 结果返回为字符串。
'responseXML： 结果返回为XML格式数据。
End Function
 


'Post发送以Gb2312方式
'例20150105 Call Echo(Url,XMLPost("http://127.0.0.1/5.asp", "title='"& escape("标题"& vbCrlf &"1") & "'&content='内容'&UpDateTime='时间'"))
Function XMLPost(Url, PostStr)
    XMLPost = HandleXMLPost(Url, PostStr, "gb2312")(0) 
End Function
 

'Post发送以Utf-8方式
Function UTFXMLPost(Url, PostStr)
    UTFXMLPost = HandleXMLPost(Url, PostStr, "utf-8")(0) 
End Function
 

'用xml传网页表单数据, 发送中文耍处理(如 桌=%D7%C0) (已完善)
Function HandleXMLPost(ByVal Url, ByVal PostStr, sSetChar)
    Dim Http, dataArray(6), content 
    sSetChar = handleStrCharSet(sSetChar) 
    Set Http = CreateObject("Microsoft.XMLHTTP")
        Call Http.Open("POST", Url, False) 
        Call Http.setRequestHeader("cache-control", "no-cache") 
        Call Http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") 
        Call Http.setRequestHeader("Connection", "close") 

        Call Http.send(PostStr) 
        If Http.ReadyState <> 4 Then
            content = "error" 
        Else
            content = BytesToBstr(Http.responseBody, sSetChar)
        'content = bytes2BSTR(Http.responseBody)    '这个要比上面那个好用   有时也不好用
        End If 
        dataArray(0) = content 
        dataArray(1) = Http.Status 
        dataArray(2) = Http.responseBody			'字节
        HandleXMLPost = dataArray 
    Set Http = Nothing 
End Function
 

'用xml传网页表单数据, 发送中文耍处理(如 桌=%D7%C0) (已完善)
Function XmlGet(ByVal Url)
    XmlGet = handleXmlGet(Url, "gb2312")(0) 
End Function
 

'处理get方法获得内容
Function handleXmlGet(ByVal Url, sSetChar)
    'on error resume next
    Dim Http, dataArray(1), content 
    'call echo("sSetChar",sSetChar)
    sSetChar = handleStrCharSet(sSetChar) 
    Set Http = CreateObject("Microsoft.XMLHTTP")
        Call Http.Open("Get", Url, False) 
        Call Http.setRequestHeader("cache-control", "no-cache") 
        Call Http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") 
        Call Http.SetRequestHeader("Cookie", "Admin%5FPassWord=admin; Admin%5FUserName=admin; CNZZDATA5865366=cnzz_eid%3D1338721452-1438760869-%26ntime%3D1438760869; style=default; sswbr=1; Hm_lvt_c39492dd0d3beab26d196a53cbd72d54=1440725802,1442725700; BD_UPN=112451; ASPSESSIONIDSCDQDRAC=CNOHMAHANIPHOFLHKCIKFIGH") 
        Call Http.send 
        If Http.ReadyState <> 4 Then
            content = "error" 
        Else
            'call eerr("sSetChar",sSetChar)
            content = BytesToBstr(Http.responseBody, sSetChar) 
        'content = bytes2BSTR(Http.responseBody)        '这个要比上面那个好用我了   有时也不好用
        End If 
        dataArray(0) = content 
        dataArray(1) = Http.Status 
    Set Http = Nothing 
    If Err Then
        dataArray(0) = "" 
        dataArray(1) = -1 
    End If 
    handleXmlGet = dataArray 
End Function
 

'Cookies提交 (已完善)
Function CookiesPost(PostUrl, PostCok)
    CookiesPost = handleCookiesPost(PostUrl, PostCok, "gb2312") 
End Function
 

'处理Cookies提交
Function handleCookiesPost(PostUrl, PostCok, sSetChar)
    Dim Http, dataArray(1), content 
    sSetChar = handleStrCharSet(sSetChar) 
    PostCok = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;" & PostCok 
    Set Http = CreateObject("msxml2.serverXMLHTTP")
        Call Http.Open("POST", PostUrl, False) 
        '.SetRequestHeader "Content-Length", Len(PostStr)        '可以不需要
        Call Http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") 
        '.SetRequestHeader "Referer", PostRef
        Call Http.setRequestHeader("Cookie", PostCok) 
        Call Http.send 
        If Http.ReadyState <> 4 Then
            content = "error" 
        Else
            content = BytesToBstr(Http.Responsebody, sSetChar) 
        'content = bytes2BSTR(Http.responseBody)    '这个要比上面那个好用我了   有时也不好用
        End If 
        dataArray(0) = content 
        dataArray(1) = Http.Status 
    Set Http = Nothing 
    handleCookiesPost = dataArray 
End Function
 

'功能：ASP获取远程文件大小   待测试
'参数：url 远程文件地址
'返回：远程文件大小(单位：字节)
Function getRemoteFileSize(Url)
    Dim xmlHTTP 
    Set xmlHTTP = CreateObject("MSXML2.XMLHTTP")
        With xmlHTTP
            .Open "get", Url, False 
            call .setRequestHeader("range", "bytes=-1") 
            .send 
            getRemoteFileSize = Split(.getResponseHeader("Content-Range"), "/")(1) 
        End With 
    Set xmlHTTP = Nothing 
End Function
 



'下载远程文件
Function DownRemoteFile(Path)
    Dim OSM, SZ 
    Call HandlePath(Path) '获得完整路径
    Response.Clear 
    Set OSM = CreateObject("ADODB.Stream")
        With OSM
            .Open 
            .Type = 1 
            .LoadFromFile Path 
            SZ = InStrRev(Path, "\") + 1 
            Response.AddHeader "Content-Disposition", "attachment; filename=" & Mid(Path, SZ) 
            Response.AddHeader "Content-Length",.Size 
            Response.Charset = "UTF-8" 
            Response.ContentType = "application/octet-stream" 
            Response.BinaryWrite.Read 
            Response.Flush 
            Response.Write("") 
            .Close 
        End With 
    Set OSM = Nothing 
End Function
 




'图片转Base64 20150722引用网上 call echo("images/error.gif",ImagesToBase64("images/error.gif"))
Function ImagesToBase64(FileName)
    Dim xml 
    Dim root 
    Dim Fs 
    Dim FilePath 
    Dim objStream 
    Dim objXMLDoc 
    Dim Base64 
    Dim getFileExt 
    '定义变量完结
    '创建对像
    FilePath = HandlePath(FileName) 
    getFileExt = Mid(FilePath, InStrRev(FilePath, ".") + 1) 
    Set objXMLDoc = CreateObject("msxml2.FreeThreadedDOMDocument")
        '设定生成XML文档的根为 Base64Data
        call objXMLDoc.loadxml("<?xml version='1.0'?><Base64Data />") 
        Set Fs = CreateObject("Scripting.FileSystemObject")''服务器需要FSO组件
            If Fs.FileExists(FilePath) Then'判断File文件是否存在
                '用 stream 来读取数据
                Set objStream = CreateObject("ADODB.Stream")
                    objStream.Type = 1 
                    objStream.Open 
                    call objStream.LoadFromFile(FilePath) 


                    objXMLDoc.documentElement.DataType = "bin.base64" 
                    objXMLDoc.documentElement.nodeTypedValue = objStream.Read 
                    '数据流读取结束.得到了值 objXMLDoc
                    '创建XML文件
                    Set xml = CreateObject("msxml2.FreeThreadedDOMDocument")
                        call xml.Load(objXMLDoc) 
                        If xml.ReadyState > 2 Then
                            Set root = xml.getElementsByTagName("Base64Data")
                                'Base64="<img src=""data:image/"&getFileExt&";base64,"&vbcrlf&root.Item(0).Text&""">"
                                'Base64 = "data:image/" & getFileExt & ";base64," & vbCrLf & root.item(0).text
                                Base64 = root.Item(0).Text 
                        Else
                            Base64 = "" 
                        End If 
                            Set xml = Nothing
                    Set objStream = Nothing
            Else
                Base64 = "" 
            End If 

                Set Fs = Nothing
        Set objXMLDoc = Nothing


        ImagesToBase64 = Base64 
End Function



'Base64转图片 20150722 引用网上   call Base64ToImages("1.jpg",Base64Data)
Function Base64ToImages(saveImagePath, Base64Data)
    Dim XmlStr 
    saveImagePath = HandlePath(saveImagePath) 
    XmlStr = "<data>" & Base64Data & "</data>" 
    Dim xml : Set xml = CreateObject("MSXML2.DOMDocument")
        Dim Stm : Set Stm = CreateObject("ADODB.Stream")
            xml.resolveExternals = False 
            Call xml.loadxml(XmlStr) 
            Call xml.documentElement.setAttribute("xmlns:dt", "urn:schemas-microsoft-com:datatypes") 
            xml.documentElement.DataType = "bin.base64" 
            Stm.Type = 1 'adTypeBinary
            Stm.Open 
            Call Stm.Write(xml.documentElement.nodeTypedValue) 
            Call Stm.SaveToFile(saveImagePath) 
            Stm.Close 
        Set xml = Nothing 
    Set Stm = Nothing 
End Function
 























'SQL注入部分

'获得SQL注入内容
Function getSqlInContent(HttpUrl, CanShu, MethodType, SelectWebShowType)
    getSqlInContent = handleSqlIn(HttpUrl, CanShu, MethodType, SelectWebShowType, "gb2312")(0) 
End Function
 

'处理获得SQL注入信息 如 call rwend( handleSqlIn("http://127.0.0.1/4.asp?act=b", "&url=aaa3222333&url2=sss333333", "cookies", 1, "utf-8")(0) )
Function handleSqlIn(HttpUrl, CanShu, MethodType, SelectWebShowType, txtCharSet)
    Dim content, dataArray				'这个(9)不能要，要不然就会报错，不能给数组赋值
    MethodType = LCase(MethodType) 
    'Post不行  待从家里弄
    If MethodType = "post" Then
        dataArray = HandleXMLPost(HttpUrl, handlePostCookiesParame(CanShu, "post"), txtCharSet) 
    'Get这样可以
    ElseIf MethodType = "get" Then
        CanShu = HandlUrlCanShu(CanShu) '参数处理
        dataArray = handleXmlGet(HttpUrl & CanShu, txtCharSet) 

    'Cookies可以用
    ElseIf MethodType = "cookies" Then
        dataArray = handleCookiesPost(HttpUrl, handlePostCookiesParame(CanShu, "cookies"), txtCharSet) 

    End If 
    If CStr(SelectWebShowType) = "0" Then
        dataArray(0) = Replace(dataArray(0), "<", "&lt;") 
    ElseIf CStr(SelectWebShowType) = "1" Then
        dataArray(0) = Replace(dataArray(0), "<br>", vbCrLf) 
        dataArray(0) = DelHtml(dataArray(0)) 
    End If 
    handleSqlIn = dataArray 
End Function
 


'判断是否可以注入
Function SqlInUrl(ByVal HttpUrl)
    Dim XMLObject, IsTrue1, IsTrue2 
    SqlInUrl = False 
    IsTrue1 = False : IsTrue2 = False 
    Set XMLObject = CreateObject("Microsoft.XMLHTTP")
		with XMLObject
        .Open "GET", HttpUrl, False '测试页面是否存在
        .send 
        If XMLObject.Status <> 200 Then
            Exit Function 
        End If 
        call .Open("GET", HttpUrl & " And 1=1", False) '测试页面是否存在
        .send 
        IsTrue1 = .Status 

        call.Open("GET", HttpUrl & " And 1=2", False) '测试页面是否存在
        .send "" 
        IsTrue2 = .Status 
	end with
	set XMLObject=nothing
        If IsTrue1 = 200 And IsTrue2 = 500 Then SqlInUrl = True 
End Function



'处理注入网址，配置获得网站注意网址
Function HandlUrlCanShu(HttpUrl)
    Dim Url, splstr, I, S, S1, S2 
    splstr = Split(HttpUrl, "=") 
    For I = 0 To UBound(splstr)
        S = splstr(I) 
        If Url <> "" Then Url = Url & "=" 
        If InStr(S, "&") Then
            S1 = Mid(S, 1, InStr(S, "&") - 1) 
            S2 = Mid(S, InStr(S, "&")) 
            S = escape(S1) & S2 
        ElseIf I = UBound(splstr) Then
            S = escape(S) 
        End If 
        Url = Url & S 
    Next 
    HandlUrlCanShu = Url 
End Function
 








'处理字符编码 20150723
Function handleStrCharSet(sSetChar)
    If sSetChar = "1" Or UCase(sSetChar) = "GB2312" Or sSetChar = "" Then
        sSetChar = "GB2312" 
    ElseIf sSetChar = "0" Or UCase(sSetChar) = "UTF-8" Then
        sSetChar = "UTF-8" 
    ElseIf sSetChar = "2" Or UCase(sSetChar) = "UNICODE" Then
        sSetChar = "UNICODE" 
    End If 
    handleStrCharSet = sSetChar 
End Function
 

'URL加密  自己写得不再使用，UTF8_URLEncoding没有它好用
Function URLEncoding(Str)
    '追加可不要
    Str = Replace(Str, "1", "%31") 
    Str = Replace(Str, "0", "%30") 
    Str = Replace(Str, "A", "%41") 
    Str = Replace(Str, "我", "%CE%D2") 
    Str = Replace(Str, "#", "%23") 
    '原始
    Str = Replace(Str, "a", "%61") 
    Str = Replace(Str, "n", "%6E") 
    Str = Replace(Str, "d", "%64") 
    Str = Replace(Str, " ", "%20") 
    Str = Replace(Str, "=", "%3D") 
    Str = Replace(Str, "e", "%65") 
    Str = Replace(Str, "x", "%78") 
    Str = Replace(Str, "i", "%69") 
    Str = Replace(Str, "s", "%73") 
    Str = Replace(Str, "t", "%74") 
    Str = Replace(Str, "(", "%28") 
    Str = Replace(Str, ")", "%29") 
    Str = Replace(Str, "l", "%6C") 
    Str = Replace(Str, "c", "%63") 
    Str = Replace(Str, "*", "%2A") 
    Str = Replace(Str, "f", "%66") 
    Str = Replace(Str, "r", "%72") 
    Str = Replace(Str, "o", "%6F") 
    Str = Replace(Str, "m", "%6D") 
    Str = Replace(Str, "w", "%77") 
    Str = Replace(Str, "h", "%68") 
    URLEncoding = Str 
End Function
 





'伪造来访网址20150922  call rw(getWinHttp("http://127.0.0.1/4.asp","","Admin%5FPassWord=admin; Admin%5FUserName=admin; CNZZDATA5865366=cnzz_eid%3D1338721452-1438760869-%26ntime%3D1438760869; style=default; sswbr=1; Hm_lvt_c39492dd0d3beab26d196a53cbd72d54=1440725802,1442725700; BD_UPN=112451; ASPSESSIONIDSCDQDRAC=CNOHMAHANIPHOFLHKCIKFIGH",""))
Function getWinHttp(HttpUrl, RefererUrl, cookiesStr, postStr, sSetChar)
    Dim WinHttp, content 
    Set WinHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
        With WinHttp
            '来路网址为空 则为当前网址域名
            If RefererUrl = "" Then
                RefererUrl = getwebsite(HttpUrl) 
            End If 
            '设置cookies字符串不能为空
            If cookiesStr = "" Then
                cookiesStr = "ASPSESSIONIDAQACTAQB=HKFHJOPDOMAIKGMPGBJJDKLJ;" 
            End If 
            '字符编号
            sSetChar = Trim(sSetChar) 
            If sSetChar = "" Or sSetChar = "1" Or sSetChar = "gb2312" Then
                sSetChar = "gb2312" 
            Else
                sSetChar = "utf-8" 
            End If 

            '设置参数
            .SetTimeouts 60000, 60000, 60000, 3000 '设置操作超时时间
            '.SetTimeouts resolveTimeout, connectTimeout, sendTimeout, receiveTimeout
            'resolveTimeout = 10000 '解析 DNS 名字的超时时间，10000 毫秒。
            'connectTimeout = 10000 '建立 Winsock 连接的超时时间，10000 毫秒。
            'sendTimeout = 120000 '发送数据的超时时间，120000 毫秒。
            'receiveTimeout = 60000 '接收 response 的超时时间，60000 毫秒。
            .Option(4) = 13056 '忽略错误标志
            .Option(6) = False '为 True 时，当请求页面重定向跳转时自动跳转，False 不自动跳转，截取服务端返回的302状态。
            '.Open "GET", "http://www.baidu.com/", False 'GET 或 POST, Url, False 同步方式；True 异步方式
            .Open "GET", HttpUrl, False 
            '组成 HTTP 头信息
            .SetRequestHeader "Accept", "*/*" '接受数据类型
            .SetRequestHeader "Accept-Language", "zh-cn,zh" '用户系统语言
            .SetRequestHeader "User-Agent", "Mozilla/6.0" '用户浏览器信息
            .SetRequestHeader "Content-Type", "application/x-www-form-urlencoded" '编码方式
            .SetRequestHeader "Referer", RefererUrl '来路
            .SetRequestHeader "Connection", "Close" 'Close = 不保持连接，Keep-Alive = 保持连接(持久连接)
            '.SetRequestHeader "Accept-Encoding", "gzip, deflate" '如果发送，会返回 gzip, deflate 压缩过的编码
            '.SetRequestHeader "Content-Length", Len(Str) '内容长度，Post 方式用的。
            .SetRequestHeader "Cookie", cookiesStr '设置 Cookie   直接把cookies字符串放进去就可以了，  获得方法:IE》F12》网络

            postStr = handlePostCookiesParame(postStr, "post") 

            '发送数据
            .Send(postStr) 'Post 方式：.Send (参数)
            .WaitForResponse '等待返回请求，XMLHTTP中也可以使用
            '输出结果
            'Response.Write .Status '当前 HTTP 状态
            'Response.Write .ResponseText '文本数据
            content = BytesToBstr(.Responsebody, sSetChar) 

        'Response.BinaryWrite .ResponseBody '二进制数据流数据   好方法
        End With 
        getWinHttp = content 
End Function


%>   
