<% 
'引用别人

'@ *****************************************************************************
'@ 过程名:  Util.UBB.closeHtml(s)
'@ 返  回:  String (字符串)
'@ 作  用:  自动闭合html
'@             目前支持闭合的标签有:
'@              p,DIV,span,table,ul,font,b,u,i,h1,h2,h3,h4,h5,h6
'==Param========================================================================
'@ s     : 字符串 [String]
'==DEMO=========================================================================
'@ AB.use "Mvc" : Util.use "UBB" : AB.C.Print Util.UBB.closeHtml("<span><a href='#'>我</a>")
'@ *****************************************************************************
'call rw(closeHtml("<b><b></b>"))  这种会报错20150718
'闭合标签，但对累加处理不行
function closeHtml(byval s)
    on error resume next 
    dim str, tags, arrTags, i, openPos, closePos, re, strMatchs, j, match : str = s 
    set re = createObject("VBscript.RegExp")
        re.ignoreCase = true 
        re.global = true 
        tags = "p,div,span,table,ul,font,b,u,i,h1,h2,h3,h4,h5,h6" '设置需要闭合的标签
        arrTags = split(tags, ",") 
        for i = 0 to uBound(arrTags)
            openPos = 0                                                          '标签开始标记个数
            closePos = 0                                                         '标签结束标记个数
            re.pattern = "<(" + trim(arrTags(i)) + ")((\s+[^<>])+|)>" 
            set strMatchs = re.execute(str)
                for each match in strMatchs
                    openPos = openPos + 1 
                    str = replace(str, match.value, "<" & lCase(match.subMatches(0)) & match.subMatches(1) & ">") '转为小写
                next 
                re.pattern = "<\/" + arrTags(i) + ">" 
                set strMatchs = re.execute(str)
                    for each match in strMatchs
                        closePos = closePos + 1 
                        str = replace(str, match.value, "</" & lCase(match.subMatches(0)) & ">") '转为小写
                    next 
                    for j = 1 to openPos - closePos                                                 '当开始与结束标记数量不一致时，闭合当前标签
                        str = str + "</" + arrTags(i) + ">" 
                    next 
                set strMatchs = nothing 
            set strMatchs = nothing 
        next 
        closeHtml = str 
    set re = nothing 
end function 
%>  

