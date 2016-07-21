#默认网页模板列表# start
【加载顶部框架】
<text>
{$Include file='head.html' block='top'$} 
</text>
---------------------
【home_asptophplist】
<VB IncludeTemplateFile path='模块功能列表\sharembweb\home\index_GuestBookList.html' operate='true' />
---------------------
【加载底部框架】
<text>
{$Include file='Foot.html' block='foot'$} 
</text>
---------------------
#默认网页模板列表# end




#Source参数列表# start

#Source参数列表# end
[处理动作设置]{生成并IE打开}
[配置设置]{#dialogbackground='默认' dialogborder='默认' modulebackground='默认' moduleborder='默认' }
[样式前缀设置]{test_}
[帮助信息设置]{}
[Css保存文件设置]{style.css}
[ASP动作处理设置]{不处理动作}
[动作文件设置]{end
\Config\ASPAction\格式化HTML.Asp
【拷贝文件夹】/../Jquery【|】[$模板路径$][$网站目录名称$]/Jquery}
[默认HTML设置]{3、手机端.Html}
[默认CSS设置]{10、2016style.css}
[自定义模板]{}
[自定义CSS]{\../DataDir\VB模块\服务器\Template\模块功能列表\sharembweb\home\_style.css}
[自定义模板动作]{}
[自定义CSS动作]{}
[txtIsCodeHtmlTemplate]{1}
[txtIsCodeCssTemplate]{1}
[txtIsDeleteRepeatCssClass]{1}
[txtCopyImageEncryption]{}
