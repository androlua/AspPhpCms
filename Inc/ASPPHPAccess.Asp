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
'ASP PHP���ݲ���ͨ���ļ�

'�ж�׷��Sql�Ǽ�Where ����And   Sql = GetWhereAnd(Sql,AddSql)        �޸���20141007 ��ǿ��
Function getWhereAnd(ByVal sql, ByVal addSql)
    Dim LCaseAddSql, AddType 
    '׷��SQlΪ�����˳�
    If Trim(addSql) = "" Then getWhereAnd = sql : Exit Function 
    If InStr(LCase(sql), " where ") > 0 Then
        AddType = " And " 
    Else
        AddType = " Where " 
    End If 
    If addSql <> "" Then 
        addSql = Trim(addSql) 
        LCaseAddSql = LCase(addSql) 
        If Left(LCaseAddSql, 6) = "order " Or Left(LCaseAddSql, 6) = "group " Then
            getWhereAnd = sql & " " & addSql : Exit Function 								'�Ľ�����ӿո���Ϊǰ���Ѿ�ɾ����20160115
        ElseIf Left(LCaseAddSql, 6) = "where " Then
            addSql = Mid(addSql, 7) 
        ElseIf Left(LCaseAddSql, 4) = "and " Then
            addSql = Mid(addSql, 5)
        End If 
        sql = sql & AddType & addSql 
    End If   
    getWhereAnd = sql 
End Function 
'�����ѯ Or �� And        �����޸���20140703
Function orAndSearch(addSql, SeectField, SearchValue)
    Dim splStr, s, c 
    SearchValue = RegExp_Replace(SearchValue, " or ", " Or ") 
    SearchValue = RegExp_Replace(SearchValue, " and ", " And ") 
    If InStr(SearchValue, " Or ") > 0 Then
        splStr = Split(SearchValue, " Or ") 
        For Each s In splStr
            If s <> "" Then
                If c <> "" Then c = c & " Or " 
                c = c & " " & SeectField & " Like '%" & s & "%'" 
            End If 
        Next 
    ElseIf InStr(SearchValue, " And ") > 0 Then
        splStr = Split(SearchValue, " And ") 
        For Each s In splStr
            If s <> "" Then
                If c <> "" Then c = c & " And " 
                c = c & " " & SeectField & " Like '%" & s & "%'" 
            End If 
        Next 
    ElseIf SearchValue <> "" Then
        splStr = Split(SearchValue, " And ") 
        For Each s In splStr
            If s <> "" Then
                If c <> "" Then c = c & " And " 
                c = c & " " & SeectField & " Like '%" & s & "%'" 
            End If 
        Next 
    End If 
    If c <> "" Then
        If InStr(LCase(addSql), " where ") = 0 Then
            c = " Where " & c 
        Else
            c = " And " & c 
        End If 
        addSql = addSql & c 
    End If 
    orAndSearch = addSql 
End Function 


%>