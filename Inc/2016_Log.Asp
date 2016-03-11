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
'日志文件

'错误日志
Function errorLog(content)
    If openErrorLog = True Then
        Call rw(content) 
    End If 
End Function 

'写入系统操作日志
Function writeSystemLog(tableName, msgStr)
    Dim logFile, s, url, ip, addDateTime 
    logFile = adminDir & "/data/systemLog/" & format_Time(Now(), 2) & ".txt" 
    url = ADSql(getThisUrlFileParam())
    addDateTime = format_Time(Now(), 1) 
    ip = getIP() 
    If InStr(openWriteSystemLog, "|txt|") > 0 Then
        s = s & "姓名：" & Session("adminusername") & vbCrLf 
        s = s & "表：" & tableName & vbCrLf 
        s = s & "信息：" & msgStr & vbCrLf 
        s = s & "网址：" & url & vbCrLf 
        s = s & "时间：" & addDateTime & vbCrLf 
        s = s & "IP：" & ip & vbCrLf 
        s = s & "------------------------" & vbCrLf 
        Call createAddFile(logFile, s) 
    'call echo(logfile,"log")
    End If 

    If InStr(openWriteSystemLog, "|txt|") > 0 Then
        Call OpenConn() 
        conn.Execute("insert into " & db_PREFIX & "SystemLog (tablename,msgstr,url,adminname,ip,adddatetime) values('" & tableName & "','" & msgStr & "','" & url & "','" & Session("adminusername") & "','" & ip & "','" & addDateTime & "')") 
    End If 

End Function 

%>