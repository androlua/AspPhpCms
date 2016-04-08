#默认网页模板列表# start
【加载顶部框架】
<text>
{$Include file='head.html' block='top'$} 
</text>
---------------------
【框架布局】
<dIv style="width:980px;margin:0 auto;">
<!--#左边#-->
<dIv style="width:230px;float:left;">
<text>
{$GetContentModule modulename='module_Left' sourcelist='22[Array]' replacelist='22[Array]'$}
</text>
</dIv>

<!--#右边#-->
<dIv style="width:740px;float:right;">
<text>
{$GetContentModule modulename='module_Right'$}
</text>
</dIv>
<text>
 <div class="clear"></div>

</text>





</dIv>
---------------------
【左边布局】
<text>
<!--#Module module_Left start#-->

    {$ReadColumeSetTitle title='网站公告' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName网站公告\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='产品列表' style='22' contentwidth='220' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName产品列表\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='荣誉资质' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName荣誉资质\' file=\'\'$]'$}
    <div class="clear10"></div>    

    {$ReadColumeSetTitle title='最新动态' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName最新动态\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='常见问题' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName常见问题\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='联系方式' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName联系方式\' file=\'\'$]'$}
    <div class="clear10"></div>


<!--#Module module_Left end#-->
</text>

<text>
<R#读出内容BlockName网站公告 start#>
{$GetOnePageBody title='最新公告' default='没有最新公告' fieldname='aboutcontent' delhtml='true' len='300' $}
<R#读出内容BlockName网站公告 end#>

<R#读出内容BlockName产品列表 start#>
 

                <ul class="ulstyleone">                         

<sPAn class="testspan">{$ColumnList columnname='产品展示' flags='' addsql='order by sortrank' default='[_2016年03月31日 16时27分]'$}</sPAn>

<!--#[_2016年03月31日 16时27分]
[list]<li><a href="[$url$]">[$columnname$]</a></li>
[/list]
[list-focus]<li><a href="[$url$]"><font color=red>[$columnname$]</font></a></li>
[/list-focus]
#-->
        
                </ul>

<R#读出内容BlockName产品列表 end#>

<R#读出内容BlockName荣誉资质 start#>
{$GetContentModule modulename='module_荣誉资质' sourcelist='22[Array]' replacelist='22[Array]'$}
<R#读出内容BlockName荣誉资质 end#>

<R#读出内容BlockName最新动态 start#>

                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList topnumb='8' addsql=' order by adddatetime desc' default='[_2016年01月15日 14时10分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时10分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>


<R#读出内容BlockName最新动态 end#>

<R#读出内容BlockName常见问题 start#>
{$GetContentModule modulename='module_CJWT' sourcelist='22[Array]' replacelist='22[Array]'$}
<R#读出内容BlockName常见问题 end#>

<R#读出内容BlockName联系方式 start#>
{$GetColumnBody columnname='联系作者' fieldname='aboutcontent' default='无栏目内容'$}
<R#读出内容BlockName联系方式 end#>

</text>
---------------------
【右边布局】
<text>
<!--#Module module_Right start#-->

    {$ReadColumeSetTitle title='[\$detailTitle\$]' style='22' contentwidth='720' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName详细内容\' file=\'\'$]'$}
    <div class="clear10"></div>
    
     

<!--#Module module_Right end#-->
</text>

<text>
<R#读出内容BlockName详细内容 start#>


 <div class="articletimes">作者：[$glb_artitleAuthor$] 发表于：[$glb_artitleAdddatetime format_time='1'$]</div>
                [$detailContent$]
                [$glb_aritcleRelatedTags$]
                <ul class=""updownarticlewrap"">
                <li>{$glb_upArticle$}</li>
                <li>{$glb_downArticle$}</li>
                </ul>
 

<R#读出内容BlockName详细内容 end#>

</text>
---------------------
【返回顶部 返回底部】
<style>
/* 浮动面板 */
#floatPanel{}
#floatPanel .ctrolPanel{
    width:36px;
    height:166px;
    border:solid 1px #ddd;
    position:fixed;
    right:25px;
    top:300px;
    overflow:hidden;
    z-index:10000;
    _position:absolute; /* for IE6 */
_top:expression(documentElement.scrollTop + 300);    background-color: #fff;
    background-image: url(float-panel-bg.gif);
    background-repeat: no-repeat;
    background-position: left top;
}
#floatPanel .ctrolPanel a{width:34px;font-size:12px;color:#ff6600;letter-spacing:1px;text-align:center;overflow:hidden;}
#floatPanel .ctrolPanel .arrow{height:29px;line-height:28px;display:block;margin:1px auto;}
#floatPanel .ctrolPanel .arrow span{display:none;}
#floatPanel .ctrolPanel .arrow:hover{background:#f4f4f4;}
#floatPanel .ctrolPanel .arrow:hover span{display:block;}
#floatPanel .ctrolPanel .contact{height:60px;display:block;margin:2px auto;}
#floatPanel .ctrolPanel .contact span{line-height:90px;}
#floatPanel .ctrolPanel .qrcode{height:40px;display:block;margin:2px auto;}
#floatPanel .ctrolPanel .qrcode span{display:none;}

#floatPanel .popPanel{width:230px;height:242px;position:fixed;right:70px;top:300px;z-index:10000;overflow:hidden;display:none;_position:absolute; /* for IE6 */_top:expression(documentElement.scrollTop + 300); }
#floatPanel .popPanel .popPanel-inner{width:230px;height:242px;position:relative;overflow:hidden;}
#floatPanel .popPanel .popPanel-inner .arrowPanel{width:10px;height:240px;position:absolute;right:1px;top:102px;}
#floatPanel .popPanel .popPanel-inner .arrowPanel .arrow01{width:0;height:0;font-size:0;line-height:0;border-top:10px solid transparent;_border-top:10px solid black;_filter:chroma(color=black);border-right:10px solid transparent;_border-right:10px solid black;_filter:chroma(color=black);border-bottom:10px solid transparent;_border-bottom:10px solid black;_filter:chroma(color=black);border-left:10px solid #ddd;position:absolute;bottom:0;position:absolute;left:2px;top:0;}
#floatPanel .popPanel .popPanel-inner .arrowPanel .arrow02{width:0;height:0;font-size:0;line-height:0;border-top:10px solid transparent;_border-top:10px solid black;_filter:chroma(color=black);border-right:10px solid transparent;_border-right:10px solid black;_filter:chroma(color=black);border-bottom:10px solid transparent;_border-bottom:10px solid black;_filter:chroma(color=black);border-left:10px solid #fff;position:absolute;bottom:0;position:absolute;left:0;top:0;}
#floatPanel .popPanel .popPanel-inner .qrcodePanel{width:220px;height:240px;text-align:center;background:#fff;border:solid 1px #ddd;position:absolute;left:0;top:0;overflow:hidden;}
#floatPanel .popPanel .popPanel-inner .qrcodePanel img{width:200px;height:200px;border:none;padding:10px 10px 5px 10px;}
#floatPanel .popPanel .popPanel-inner .qrcodePanel span{font-size:12px;color:#666;line-height:24px;letter-spacing:1px;}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/其它/快速返回点部和底部/' isHandle='true'$}</sPAn>


<script type="text/javascript" src="backtopandbackbutton.js"></script>
 <div id="floatPanel">
    <div class="ctrolPanel">
        <a class="arrow" href="#"><span>顶部</span></a><a class="contact" href="javascript:openWind('/Inc/Create_Html.Asp?act=Nav&NavDidType=首页&MackHtml=False&Debug=True&Template=表单验证&Did=在线反馈','250','230','在线反馈')"><span>反馈</span></a><a class="qrcode" href="#"><span>微信二维码</span></a><a class="arrow" href="#"><span>底部</span></a></div>
    <div class="popPanel">
        <div class="popPanel-inner">
            <div class="qrcodePanel">
            <sPAn class="testspan">{$MainInfo title='浮动面板_返回顶部与底部' showtitle='浮动面板_返回顶部与底部' default='[_浮动面板_返回顶部与底部2014年12月08日 15时36分]' autoadd='true'$}</sPAn>      
<!--#test start#-->
<!--#[_浮动面板_返回顶部与底部2014年12月08日 15时36分] start#-->
                <img src="weixin.jpg" />
<span>扫描二维码关注我为好友</span>
<!--#[_浮动面板_返回顶部与底部2014年12月08日 15时36分] end#-->
<!--#test end#-->
             </div>
            <div class="arrowPanel">
                <div class="arrow01">                </div>
                <div class="arrow02">                </div>
            </div>
        </div>
    </div>
</div>
</text>
---------------------
【常见问题向上滚动-资源】
<style>
/*swer(回答的人)Ask(问) Answer(答)*/
#swer{
    width:auto;
}
#swer dl{
    margin: 0 0;
    padding-bottom: 7px;
    border-bottom: dashed 1px #cfcbcc;
    padding: 13px 0;
}
#swer dl dt{
    display: block;
}

#swer dl dt a {
    display: block;
    height: 24px;
    line-height: 24px;
    padding-left: 24px;
    color: #a00000;
    overflow: hidden;
    background: url(wd_w2.jpg) no-repeat 0 5px;
}
#swer dl dt a:hover{ 
    text-decoration:underline;
}
#swer dl dd {
    line-height: 22px;
    color: #777777;
    padding-left: 24px;
    font-size:12px;
    background: url(wd_d2.jpg) no-repeat 0 5px;
}
</style>
<body>
<text>
<!--#Module module_CJWT start#-->

<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/其它/问题常见问题/' isHandle='true'$}</sPAn>


<div id="swer">   
    
<sPAn class="testspan">{$ArticleList columnname='' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_常见问题2015年01月06日 15时48分]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_常见问题2015年01月06日 15时48分]
    [list]<dl>
        <dt><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='30' delhtml='true' trim='true' deltabs='true' $]</a></dt>
        <dd>[$bodycontent len='60' delhtml='true' trim='true' deltabs='true' $]</dd>
    </dl>
[/list] 
#-->
      
</div>
<script type="text/javascript">
    new Marquee("swer", 0, 1, 210, 250, 20, 0, 1000, 22);
</script>

<!--#Module module_CJWT end#-->
</text>
---------------------
【案例展示】
<style>
/*产品展示左右切换*/
.pscrolllr1_l{    
    float:left;
    padding:80px 10px 0 10px;
}
.pproductlist1{
    float:left;
     width:217px;
}
.pproductlist1 img{
    border: 1px solid #DFDDC5;
    padding: 2px;
}
.pproductlist1 a.tlink{
    display: block;
    height: 24px;
    line-height: 24px;
    color: #666;
    text-align: center;
    padding-top: 1px;
    overflow: hidden;
    text-decoration:none;
}
.pproductlist1 a.tlink:hover{
    text-decoration: underline;
}
</style>
<body>
<text>
<!--#Module module_ALZS start#-->

<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/产品/产品高级滚动3/' isHandle='true'$}</sPAn>


<div class="pscrolllr1_l">
    <a href="javascript:;" id="PLeftID1"><img src="LR_L.gif"></a> 
</div>
<div id="PScollName1" class="fl">

<sPAn class="testspan">{$ArticleList columnname='' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_案例展示2015年01月06日 15时48分]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_案例展示2015年01月06日 15时48分]
    [list]
    <div class="pproductlist1">
        <a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]><img src="[$smallimage$]" width="200" height="150" alt="[$title$]" /></a>
        <a href="[$url$]" class="tlink">[$title len='30' delhtml='true' trim='true' deltabs='true' $]</a>
    </div>   
[/list] 
#-->

    <div class="clear"></div>
</div>
<div class="pscrolllr1_l">
    <a href="javascript:;" id="PRightID1"><img src="LR_R.gif"></a>
</div>
<div class="clear"></div>
<script language="javascript" type="text/javascript">
    var adsp1 = new ScrollPicleft();
    adsp1.scrollContId = "PScollName1"; // 内容容器ID""
    adsp1.arrLeftId = "PLeftID1"; //左箭头ID
    adsp1.arrRightId = "PRightID1"; //右箭头ID
    adsp1.frameWidth = 650; //显示框宽度
    adsp1.pageWidth = 217; //翻页宽度
    adsp1.speed = 10; //移动速度(单位毫秒，越小越快)
    adsp1.space = 10; //每次移动像素(单位px，越大越快)
    adsp1.autoPlay = true; //自动播放
    adsp1.autoPlayTime = 3; //自动播放间隔时间(秒)
    adsp1.initialize(); //初始化
</script>

<!--#Module module_ALZS end#-->
</text>
---------------------
【荣誉资质】
<style>
/*荣誉资质左右切换*/
.scrolllr_l{    
    float:left;
    padding:80px 10px 0 10px;
}
.productlist{
    float:left;
    width:140px;
}
.productlist img{
    border: 1px solid #DFDDC5;
    padding: 2px;
}
.productlist a.tlink{
    display: block;
    height: 24px;
    line-height: 24px;
    color: #666;
    text-align: center;
    padding-top: 1px;
    overflow: hidden;
    text-decoration:none;
}
.productlist a.tlink:hover{
    text-decoration: underline;
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/其它/荣誉资质左右切换/' isHandle='true'$}</sPAn>

<!--#Module module_荣誉资质 start#-->


<div class="scrolllr_l">
    <a href="javascript:;" id="LeftID4"><img src="LR_L.gif"></a> 
</div>
<div id="ScollName4" class="fl">
    
<sPAn class="testspan">{$CustomInfoList did='荣誉资质' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_荣誉资质2015年01月06日 15时48分]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_荣誉资质2015年01月06日 15时48分]
    [list]    
    <div class="productlist">
        <a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]><img src="[$smallimage$]" width="130" height="180" alt="[$title$]" /></a>
        <a href="[$url$]" class="tlink">[$title len='30' delhtml='true' trim='true' deltabs='true' $]</a>


    </div>    
    [/list] 
#-->
      
    <div class="clear"></div>
</div>
<div class="scrolllr_l">
    <a href="javascript:;" id="RightID4"><img src="LR_R.gif"></a>
</div>
<div class="clear"></div>
<script language="javascript" type="text/javascript">
    var ads = new ScrollPicleft();
    ads.scrollContId = "ScollName4"; // 内容容器ID""
    ads.arrLeftId = "LeftID4"; //左箭头ID
    ads.arrRightId = "RightID4"; //右箭头ID
    ads.frameWidth = 140; //显示框宽度
    ads.pageWidth = 140; //翻页宽度
    ads.speed = 10; //移动速度(单位毫秒，越小越快)
    ads.space = 10; //每次移动像素(单位px，越大越快)
    ads.autoPlay = true; //自动播放
    ads.autoPlayTime = 3; //自动播放间隔时间(秒)
    ads.initialize(); //初始化
</script>
<!--#Module module_荣誉资质 end#-->

</text>
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
[样式前缀设置]{news_}
[帮助信息设置]{}
[Css保存文件设置]{style.css}
[ASP动作处理设置]{不处理动作}
[动作文件设置]{end
\Config\ASPAction\格式化HTML.Asp
【拷贝文件夹】/../Jquery【|】[$模板路径$][$网站目录名称$]/Jquery}
[默认HTML设置]{1、Template.Html}
[默认CSS设置]{9、testwebCommon.css}
[自定义模板]{}
[自定义CSS]{}
[自定义模板动作]{}
[自定义CSS动作]{}
[txtIsCodeHtmlTemplate]{1}
[txtIsCodeCssTemplate]{0}
[txtIsDeleteRepeatCssClass]{1}
[txtCopyImageEncryption]{|left|nav|module| }
