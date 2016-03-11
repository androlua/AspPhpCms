<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-03-11
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered by ASPPHPCMS 
'************************************************************
%>
<% 
'--------版权说明------------------
'Author:小云
'QQ:313801120
'E-Mail:313801120@qq.com
'--------定义部份------------------
sub SqlIn()
    dim StrIn, splStr, i, j 
    '自定义需要过滤的字串,用 "|" 分隔
    StrIn = "'|;|and|(|)|exec|insert|select|delete|update|count|*|chr|mid|master|truncate|char|declare" 
    splStr = split(StrIn, "|")                                                      '--------Post部份------------------
    if request.queryString <> "" then
        for each j in request.queryString
            for i = 0 to uBound(splStr)
                if inStr(lCase(request.queryString), splStr(i)) <> 0 then
                    call saveSqlInInfo(splStr(i)) 
                    call eerr("Post注入", "你的IP[" & getIP & "]已被收录") 
                end if 
            next 
        next 
    end if 

    '--------Get部份------------------
    if request.form <> "" then
        for each j in request.queryString
            for i = 0 to uBound(splStr)
                if inStr(lCase(request.queryString), splStr(i)) <> 0 then
                    call saveSqlInInfo(splStr(i)) 
                    call eerr("Get注入", "你的IP[" & getIP & "]已被收录") 
                end if 
            next 
        next 
    end if 
    '--------Cookies部份------------------
    '等开发
end sub 
'保存Sqlin注入
function saveSqlInInfo(str)
    dim fileName, OperatingNow, OperatingIP, myFile, MeLoadFile, fso, f 
    fileName = server.mapPath("./SqlIn.Txt") 
    OperatingNow = now() 
    OperatingIP = request.serverVariables("Remote_Addr") 
    str = OperatingNow & " - " & OperatingIP & "   " & str 
    set fso = createObject("Scripting.FileSystemObject")
        if fso.fileExists(fileName) then
            set myFile = fso.openTextFile(fileName, 1)
                set f = fso.GetFile(fileName)
                    if f.size > 0 then MeLoadFile = myFile.ReadAll 
                set f = nothing 
            set myFile = nothing 
            set myFile = fso.createTextFile(fileName, true)
                myFile.WriteLine(MeLoadFile & vbCrLf & str) 
            set myFile = nothing 
        else
            set myFile = fso.createTextFile(fileName, true)
                myFile.WriteLine(str) 
            set myFile = nothing 
        end if 
    set fso = nothing 
end function 
%> 




