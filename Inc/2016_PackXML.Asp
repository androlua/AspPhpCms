<% 

class xmlZIP
    dim zipPathDir, zipPathFile, zipFileExt 
    dim starTime, endTime 
    dim pubXmlZipDir                                                  'xml打包目录
    dim pubIsEchoMsg                                                  '是否回显打印信息
    dim webRootPathDir                                                '网站根目录路径

    sub callRun(thisWebRootPathDir, xmlZipDir, isEchoMsg, xmlFileName)
        pubXmlZipDir = xmlZipDir & "/"                                                  'xml目录
        pubIsEchoMsg = isEchoMsg                                                        '是否回显
        '此为默认当前文件夹
        webRootPathDir = thisWebRootPathDir                                             '等于它
        'call echo("webRootPathDir",webRootPathDir)

        zipPathDir = server.mapPath("./") & "\" 

        '在此更改要打包文件夹的路径
        'ZipPathDir="D:\MYWEB\WEBINFO"
        '生成的xml文件
        zipPathFile = xmlFileName 
        if zipPathFile = "" then
            zipPathFile = "update.xml" 
        end if 
        '不进行打包的文件扩展名
        zipFileExt = "db;bak" 
        if right(zipPathDir, 1) <> "\" then zipPathDir = zipPathDir & "\" 

        response.write("保存路径：" & zipPathDir & zipPathFile & "<hr>") 
        '开始打包
        createXml(zipPathDir & zipPathFile) 
    end sub 
    '遍历目录内的所有文件以及文件夹
    sub loadData(dirPath)
        dim xmlDoc 
        dim fso                                                                         'fso对象
        dim objFolder                                                                   '文件夹对象
        dim objSubFolders                                                               '子文件夹集合
        dim objSubFolder                                                                '子文件夹对象
        dim objFiles                                                                    '文件集合
        dim objFile                                                                     '文件对象
        dim objStream 
        dim pathname, xFolder, xFPath, xFile, xPath, xStream 
        dim pathNameStr 

        if pubIsEchoMsg = true then
            response.write("==========" & dirPath & "==========<br>") 
        end if 
        set fso = createObject("Scripting.FileSystemObject")
            set objFolder = fso.getFolder(dirPath)                                          '创建文件夹对象

                if pubIsEchoMsg = true then
                    response.write(dirPath) 
                    response.flush 
                end if 
                set xmlDoc = createObject("Microsoft.XMLDOM")
                    xmlDoc.load(server.mapPath(zipPathFile)) 
                    xmlDoc.async = false 
                    '写入每个文件夹路径
                    set xFolder = xmlDoc.selectSingleNode("//root").appendChild(xmlDoc.createElement("folder"))
                        set xFPath = xFolder.appendChild(xmlDoc.createElement("path"))
                            xFPath.text = replace(dirPath, webRootPathDir, "") 'zipPathDir  注意
                            set objFiles = objFolder.files
                                for each objFile in objFiles
                                    if lCase(dirPath & objFile.name) <> lCase(request.serverVariables("PATH_TRANSLATED")) and lCase(dirPath & objFile.name) <> lCase(dirPath & zipPathFile) then
                                        if ext(objFile.name) then
                                            pathNameStr = dirPath & "" & objFile.name 
                                            if pubIsEchoMsg = true then
                                                response.write("---<br/>") 
                                                response.write(pathNameStr & "") 
                                                response.flush 
                                            end if 
                                            '================================================

                                            '写入文件的路径及文件内容
                                            set xFile = xmlDoc.selectSingleNode("//root").appendChild(xmlDoc.createElement("file"))
                                                set xPath = xFile.appendChild(xmlDoc.createElement("path"))
                                                    'call echo(zipPathDir,webRootPathDir)
                                                    xPath.text = replace(pathNameStr, webRootPathDir, "") 'zipPathDir  注意
                                                    '创建文件流读入文件内容，并写入XML文件中
                                                    set objStream = createObject("ADODB.Stream")
                                                        objStream.type = 1 
                                                        objStream.open 
                                                        objStream.loadFromFile(pathNameStr) 
                                                        objStream.position = 0 
                                                        set xStream = xFile.appendChild(xmlDoc.createElement("stream"))
                                                            xStream.setAttribute "xmlns:dt", "urn:schemas-microsoft-com:datatypes" 
                                                            '文件内容采用二制方式存放
                                                            xStream.dataType = "bin.base64" 
                                                            xStream.nodeTypedValue = objStream.read() 
                                                        set objStream = nothing 
                                                    set xPath = nothing 
                                                set xStream = nothing 
                                            set xFile = nothing 
                                            '================================================

                                        end if 
                                    end if 
                                next 
                                if pubIsEchoMsg = true then
                                    response.write("<p>") 
                                end if 
                                xmlDoc.save(server.mapPath(zipPathFile)) 
                            set xFPath = nothing 
                        set xFolder = nothing 
                    set xmlDoc = nothing 
                    '创建的子文件夹对象
                    set objSubFolders = objFolder.subFolders
                        '调用递归遍历子文件夹
                        for each objSubFolder in objSubFolders
                            pathname = dirPath & objSubFolder.name & "\" 
                            loadData(pathname) 
                        next 
                    set objFolder = nothing 
                set objSubFolders = nothing 
            set fso = nothing 
    end sub
    '创建一个空的XML文件，为写入文件作准备
    sub createXml(filePath)
        '程序开始执行时间
        starTime = timer() 
        dim xmlDoc, root 
        set xmlDoc = createObject("Microsoft.XMLDOM")
            xmlDoc.async = false 
            set root = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'")
                xmlDoc.appendChild(root) 
                xmlDoc.appendChild(xmlDoc.createElement("root")) 
                if inStr(filePath, ":") = false then filePath = server.mapPath(filePath) 
                xmlDoc.save(filePath) 
            set root = nothing 
        set xmlDoc = nothing 
        'call eerr(ZipPathDir & "inc/",pubXmlZipDir)
        'call echo(ZipPathDir & "newweb/http：揦揦www。thinkphp。cn揦/web/",pubXmlZipDir)
        loadData(pubXmlZipDir) 
        '程序结束时间
        endTime = timer() 
        response.write("页面执行时间：" & formatNumber((endTime - starTime), 3) & "秒") 
    end sub 
    '判断文件类型是否合法
    function ext(fileName)
        ext = true 
        dim temp_ext, e 
        temp_ext = split(zipFileExt, ";") 
        for e = 0 to uBound(temp_ext)
            if mid(fileName, inStrRev(fileName, ".") + 1) = temp_ext(e) then ext = false 
        next 
    end function 
end class 
%> 

