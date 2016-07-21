<%
'Email邮箱

'发送邮箱 call Send_Email("313801120@qq.com", "标题", "111", "内容")
Function send_Email(ToMail, ToTitle, MyEmalName, ToContent)
    Dim JMail, isgo, MailBody 
    Response.AddHeader "Content-Type", "text/html; charset=gb2312" 
    Set JMail = CreateObject("JMail.Message")
        'JMail.ISOEncodeHeaders = False ' 是否进行ISO编码，默认为True
        JMail.ContentTransferEncoding = "base64" 
        JMail.Encoding = "base64" 
        JMail.ContentType = "text/html"                                                 '正常显示内容的代码
        JMail.silent = True 
        JMail.Logging = True 
        JMail.Charset = "gb2312" 
        JMail.MailServerUserName = "m18251922007"                                       '此为您邮箱的登录帐号，使用时请更改为自己的邮箱登录帐号
        JMail.MailServerPassword = "mydd3a"                                             '此为您邮箱的登录密码，使用时请更改为自己的邮箱登录密码
        JMail.From = "m18251922007@163.com"                                             '"m18251922007@163.com" '发件人Email
        JMail.FromName = MyEmalName                                                     '发件人姓名
        JMail.AddRecipient ToMail                                                       '收件人Email
        JMail.Subject = ToTitle                                                         '邮件主题
        '邮件主体（HTML(注意信件内链接附件的方式)）
        MailBody = MailBody & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>" 
        MailBody = MailBody & ToContent 
        MailBody = MailBody & "</body></html>" 
        JMail.Body = MailBody                                                           '邮件正文
        send_Email = JMail.send("smtp.163.com")                                         'SMTP服务器地址         //返回发送是否成功
        JMail.Close 
    Set JMail = Nothing 
End Function 
'邮箱发送 例：Response.Write( ServerSend_Email("m18251922007","mydd3a","313801120@qq.com", "标题", "11@aa.com", "内容"  ) )
'邮箱发送
Function serverSend_Email(ServerUserName, ServerPassword, ToMail, ToTitle, MyEmalName, ToContent)
    Dim JMail, isgo, MailBody 
    Response.AddHeader "Content-Type", "text/html; charset=gb2312" 
    Set JMail = CreateObject("JMail.Message")
        'JMail.ISOEncodeHeaders = False ' 是否进行ISO编码，默认为True
        JMail.ContentTransferEncoding = "base64" 
        JMail.Encoding = "base64" 
        JMail.ContentType = "text/html"                                                 '正常显示内容的代码
        JMail.silent = True 
        JMail.Logging = True 
        JMail.Charset = "gb2312" 
        JMail.MailServerUserName = ServerUserName                                       '此为您邮箱的登录帐号，使用时请更改为自己的邮箱登录帐号
        JMail.MailServerPassword = ServerPassword                                       '此为您邮箱的登录密码，使用时请更改为自己的邮箱登录密码
        JMail.From = "m18251922007@163.com"                                             '"m18251922007@163.com" '发件人Email
        JMail.FromName = MyEmalName                                                     '发件人姓名
        JMail.AddRecipient ToMail                                                       '收件人Email
        JMail.Subject = ToTitle                                                         '邮件主题
        '邮件主体（HTML(注意信件内链接附件的方式)）
        MailBody = MailBody & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>" 
        MailBody = MailBody & ToContent 
        MailBody = MailBody & "</body></html>" 
        JMail.Body = MailBody                                                           '邮件正文
        serverSend_Email = JMail.send("smtp.163.com")                                   'SMTP服务器地址         //返回发送是否成功
        JMail.Close 
    Set JMail = Nothing 
End Function 
%>