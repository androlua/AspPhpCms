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

Sub aboutAuthor()
    Dim b
    b = b & "<pre>" & vbCrLf
    b = b & "作者：小孙" & vbCrLf
    b = b & "联系方式" & vbCrLf
    b = b & "QQ：313801120" & vbCrLf
    b = b & "邮箱：313801120@qq.com" & vbCrLf
    b = b & "微信：mq313801120" & vbCrLf
    b = b & "交流群35915100(群里已有几百人)" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "业务及特长" & vbCrLf
    b = b & "精通ASP,VB程序开发，独立开发出一套ASP网站后台和VB辅助软件。" & vbCrLf
    b = b & "熟练掌握HTML、DIV、CSS、JS" & vbCrLf
    b = b & "熟练使用Dreamweaver、Fireworks、 Flash、Photoshop等软件" & vbCrLf
    b = b & "自觉PHP、Android等编程语言" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "自我评价" & vbCrLf
    b = b & "自学能力强、新知识接受快、勇于面对困难，敢于挑战。" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "工作经历" & vbCrLf
    b = b & "2007年1月 至 2012年1月 上海子映网络" & vbCrLf
    b = b & "工作内容：网站开发" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "2013---2014，南京麦思德餐饮有限公司" & vbCrLf
    b = b & "工作内容：网站开发" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "2014---至今，微战略网络有限公司" & vbCrLf
    b = b & "工作内容：网站整站开发，自己用VB开发出一款网站制作辅助软件。" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "" & vbCrLf
    b = b & "网站案例：" & vbCrLf
    b = b & "http://www.863health.com/" & vbCrLf
    b = b & "http://www.wzl99.com/" & vbCrLf
    b = b & "http://www.jfh6666.com/" & vbCrLf

    b = b & "</pre>" & vbCrLf
    Response.Write(b) : Response.End()
End Sub
%>



