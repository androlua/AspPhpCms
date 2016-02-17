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
<%





sub SqlIn()
    dim b, c, d, e

    b = "'|;|and|(|)|exec|insert|select|delete|update|count|*|chr|mid|master|truncate|char|declare"
    c = split(b, "|")
    if request.queryString <> "" then
        for each e in request.queryString
            for d = 0 to uBound(c)
                if inStr(lCase(request.queryString), c(d)) <> 0 then
                    call saveSqlInInfo(c(d))
                    call eerr("Post注入", "你的IP[" & getIP & "]已被收录")
                end if
            next
        next
    end if


    if request.form <> "" then
        for each e in request.queryString
            for d = 0 to uBound(c)
                if inStr(lCase(request.queryString), c(d)) <> 0 then
                    call saveSqlInInfo(c(d))
                    call eerr("Get注入", "你的IP[" & getIP & "]已被收录")
                end if
            next
        next
    end if


end sub

function saveSqlInInfo(a)
    dim b, c, d, e, f, g, h
    b = server.mapPath("./SqlIn.Txt")
    c = now()
    d = request.serverVariables("Remote_Addr")
    a = c & " - " & d & "   " & a
    set g = createObject("Scripting.FileSystemObject")
        if g.fileExists(b) then
            set e = g.openTextFile(b, 1)
                set h = g.GetFile(b)
                    if h.size > 0 then f = e.ReadAll
                set h = nothing
            set e = nothing
            set e = g.createTextFile(b, true)
                e.WriteLine(f & vbCrLf & a)
            set e = nothing
        else
            set e = g.createTextFile(b, true)
                e.WriteLine(a)
            set e = nothing
        end if
    set g = nothing
end function
%>






