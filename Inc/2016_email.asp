<%
'Email����

'�������� call Send_Email("313801120@qq.com", "����", "111", "����")
Function send_Email(ToMail, ToTitle, MyEmalName, ToContent)
    Dim JMail, isgo, MailBody 
    Response.AddHeader "Content-Type", "text/html; charset=gb2312" 
    Set JMail = CreateObject("JMail.Message")
        'JMail.ISOEncodeHeaders = False ' �Ƿ����ISO���룬Ĭ��ΪTrue
        JMail.ContentTransferEncoding = "base64" 
        JMail.Encoding = "base64" 
        JMail.ContentType = "text/html"                                                 '������ʾ���ݵĴ���
        JMail.silent = True 
        JMail.Logging = True 
        JMail.Charset = "gb2312" 
        JMail.MailServerUserName = "m18251922007"                                       '��Ϊ������ĵ�¼�ʺţ�ʹ��ʱ�����Ϊ�Լ��������¼�ʺ�
        JMail.MailServerPassword = "mydd3a"                                             '��Ϊ������ĵ�¼���룬ʹ��ʱ�����Ϊ�Լ��������¼����
        JMail.From = "m18251922007@163.com"                                             '"m18251922007@163.com" '������Email
        JMail.FromName = MyEmalName                                                     '����������
        JMail.AddRecipient ToMail                                                       '�ռ���Email
        JMail.Subject = ToTitle                                                         '�ʼ�����
        '�ʼ����壨HTML(ע���ż������Ӹ����ķ�ʽ)��
        MailBody = MailBody & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>" 
        MailBody = MailBody & ToContent 
        MailBody = MailBody & "</body></html>" 
        JMail.Body = MailBody                                                           '�ʼ�����
        send_Email = JMail.send("smtp.163.com")                                         'SMTP��������ַ         //���ط����Ƿ�ɹ�
        JMail.Close 
    Set JMail = Nothing 
End Function 
'���䷢�� ����Response.Write( ServerSend_Email("m18251922007","mydd3a","313801120@qq.com", "����", "11@aa.com", "����"  ) )
'���䷢��
Function serverSend_Email(ServerUserName, ServerPassword, ToMail, ToTitle, MyEmalName, ToContent)
    Dim JMail, isgo, MailBody 
    Response.AddHeader "Content-Type", "text/html; charset=gb2312" 
    Set JMail = CreateObject("JMail.Message")
        'JMail.ISOEncodeHeaders = False ' �Ƿ����ISO���룬Ĭ��ΪTrue
        JMail.ContentTransferEncoding = "base64" 
        JMail.Encoding = "base64" 
        JMail.ContentType = "text/html"                                                 '������ʾ���ݵĴ���
        JMail.silent = True 
        JMail.Logging = True 
        JMail.Charset = "gb2312" 
        JMail.MailServerUserName = ServerUserName                                       '��Ϊ������ĵ�¼�ʺţ�ʹ��ʱ�����Ϊ�Լ��������¼�ʺ�
        JMail.MailServerPassword = ServerPassword                                       '��Ϊ������ĵ�¼���룬ʹ��ʱ�����Ϊ�Լ��������¼����
        JMail.From = "m18251922007@163.com"                                             '"m18251922007@163.com" '������Email
        JMail.FromName = MyEmalName                                                     '����������
        JMail.AddRecipient ToMail                                                       '�ռ���Email
        JMail.Subject = ToTitle                                                         '�ʼ�����
        '�ʼ����壨HTML(ע���ż������Ӹ����ķ�ʽ)��
        MailBody = MailBody & "<html><head><META content=zh-cn http-equiv=Content-Language><meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312""><style type=text/css>BODY {FONT-SIZE: 9pt}</style></head><body>" 
        MailBody = MailBody & ToContent 
        MailBody = MailBody & "</body></html>" 
        JMail.Body = MailBody                                                           '�ʼ�����
        serverSend_Email = JMail.send("smtp.163.com")                                   'SMTP��������ַ         //���ط����Ƿ�ɹ�
        JMail.Close 
    Set JMail = Nothing 
End Function 
%>