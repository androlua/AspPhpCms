<%
'************************************************************
'作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
'版权：源代码公开，各种用途均可免费使用。 
'创建：2016-02-29
'联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
'更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
'*                                    Powered By AspPhpCMS 
'************************************************************
%>
<% 
'保存文章评论 20160129
Sub saveArticleComment()
    Dim itemid, iP, bodycontent 
    itemid = Request("itemid") 
    bodycontent = ADSql(Request("content")) 
    iP = getIP() 
    Call openconn() 
    conn.Execute("insert into " & db_PREFIX & "tablecomment (tableName,itemid,ip,bodycontent,adddatetime) values('ArticleDetail'," & itemid & ",'" & iP & "','" & bodycontent & "','" & Now() & "')") 
    Call echo("提示", "评论成功，等待管理员审核") 
End Sub 
%> 
