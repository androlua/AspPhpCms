<%
'************************************************************
'���ߣ��ƶ� (��ͨASP/VB/PHP/JS/Flash��������������ϵ����)
'��Ȩ��Դ���빫����������;�������ʹ�á� 
'������2016-02-29
'��ϵ��QQ313801120  ����Ⱥ35915100(Ⱥ�����м�����)    ����313801120@qq.com   ������ҳ sharembweb.com
'����������ĵ������¡����Ⱥ(35915100)�����(sharembweb.com)���
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'������������ 20160129
Sub saveArticleComment()
    Dim itemid, iP, bodycontent 
    itemid = Request("itemid") 
    bodycontent = ADSql(Request("content")) 
    iP = getIP() 
    Call openconn() 
    conn.Execute("insert into " & db_PREFIX & "tablecomment (tableName,itemid,ip,bodycontent,adddatetime) values('ArticleDetail'," & itemid & ",'" & iP & "','" & bodycontent & "','" & Now() & "')") 
    Call echo("��ʾ", "���۳ɹ����ȴ�����Ա���") 
End Sub 
%> 