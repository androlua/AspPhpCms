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
'���ñ���

'@ *****************************************************************************
'@ ������:  Util.UBB.closeHtml(s)
'@ ��  ��:  String (�ַ���)
'@ ��  ��:  �Զ��պ�html
'@ 			Ŀǰ֧�ֱպϵı�ǩ��:
'@ 			 p,DIV,span,table,ul,font,b,u,i,h1,h2,h3,h4,h5,h6
'==Param========================================================================
'@ s 	: �ַ��� [String]
'==DEMO=========================================================================
'@ AB.use "Mvc" : Util.use "UBB" : AB.C.Print Util.UBB.closeHtml("<span><a href='#'>��</a>")
'@ *****************************************************************************
'call rw(closeHtml("<b><b></b>"))  ���ֻᱨ��20150718
'�պϱ�ǩ�������ۼӴ�������
Function closeHtml(Byval s)
	on error resume next
	Dim str, Tags, arrTags, i, OpenPos, ClosePos, re, strMatchs, j, Match : str = s
	Set re = CreateObject("VBscript.RegExp")
	re.IgnoreCase = True
	re.Global = True
	Tags = "p,div,span,table,ul,font,b,u,i,h1,h2,h3,h4,h5,h6" '������Ҫ�պϵı�ǩ
	arrTags = Split(Tags,",")
	For i = 0 To UBound(arrTags)
		OpenPos = 0 '��ǩ��ʼ��Ǹ���
		ClosePos = 0 '��ǩ������Ǹ���
		re.Pattern = "<(" + trim(arrTags(i)) + ")((\s+[^<>])+|)>"
		Set strMatchs = re.Execute(str)
		For Each Match in strMatchs
			OpenPos = OpenPos + 1
			str = Replace(str, Match.Value, "<"& LCase(Match.SubMatches(0)) & Match.SubMatches(1) &">") 'תΪСд
		Next
		re.Pattern = "<\/" + arrTags(i) + ">"
		Set strMatchs = re.Execute(str)
		For Each Match in strMatchs
			ClosePos = ClosePos + 1
			str = Replace(str, Match.Value, "</"& LCase(Match.SubMatches(0)) &">") 'תΪСд
		Next
		For j = 1 To OpenPos - ClosePos '����ʼ��������������һ��ʱ���պϵ�ǰ��ǩ
			str = str + "</" + arrTags(i) + ">"
		Next
	Next
	closeHtml = str
	Set re = Nothing
End Function
%>