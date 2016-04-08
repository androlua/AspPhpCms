#默认网页模板列表# start
【加载顶部框架】
<text>
{$Include file='head.html' block='top'$} 
</text>
---------------------
#【处理动作】
<dIv>

<text>
    {$ReadColumeSetTitle title='网站公告' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName网站公告\' file=\'\'$]'$}
  
</text>


</dIv>
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

    {$ReadColumeSetTitle title='公司介绍' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName公司介绍\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='案例展示' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName案例展示\' file=\'\'$]'$}
    <div class="clear10"></div>

<div>
<dIv style="width:360px;float:left;">
    {$ReadColumeSetTitle title='新闻中心' style='22' contentwidth='340'  moreclass='more_white0' morestr='More' moreurl='{\$GetColumnUrl columnname\=\'ASPPHPCMS\'\$\}' stylevalue='0' value='[$读出内容 block=\'BlockName新闻中心\' file=\'\'$]'$}
    <div class="clear10"></div>
</dIv>
<dIv style="width:360px;float:right;">
    {$ReadColumeSetTitle title='行业新闻' style='22' contentwidth='340' moreclass='more_white0' morestr='More' moreurl='{\$GetColumnUrl columnname\=\'ASPPHPCMS\'\$\}' stylevalue='0' value='[$读出内容 block=\'BlockName行业新闻\' file=\'\'$]'$}
    <div class="clear10"></div>
</dIv>
</div>

<div>
<dIv style="width:360px;float:left;">
    {$ReadColumeSetTitle title='ASP' style='22' contentwidth='340'  moreclass='more_white0' morestr='More' moreurl='{\$GetColumnUrl columnname\=\'ASP\'\$\}' stylevalue='0' value='[$读出内容 block=\'BlockNameASP\' file=\'\'$]'$}
    <div class="clear10"></div>
</dIv>
<dIv style="width:360px;float:right;">
    {$ReadColumeSetTitle title='SEO' style='22' contentwidth='340' moreclass='more_white0' morestr='More' moreurl='{\$GetColumnUrl columnname\=\'SEO\'\$\}' stylevalue='0' value='[$读出内容 block=\'BlockNameSEO\' file=\'\'$]'$}
    <div class="clear10"></div>
</dIv>
</div>


<div>
<dIv style="width:360px;float:left;">
    {$ReadColumeSetTitle title='在线ASP转PHP' style='22' contentwidth='340'  moreclass='more_white0' morestr='More' moreurl='{\$GetColumnUrl columnname\=\'在线ASP转PHP\'\$\}' stylevalue='0' value='[$读出内容 block=\'BlockName在线ASP转PHP\' file=\'\'$]'$}
    <div class="clear10"></div>
</dIv>
<dIv style="width:360px;float:right;">
    {$ReadColumeSetTitle title='ASPPHPCMS' style='22' contentwidth='340' moreclass='more_white0' morestr='More' moreurl='{\$GetColumnUrl columnname\=\'ASPPHPCMS\'\$\}' stylevalue='0' value='[$读出内容 block=\'BlockNameASPPHPCMS\' file=\'\'$]'$}
    <div class="clear10"></div>
</dIv>
</div>
<div class="clear"></div>
    {$ReadColumeSetTitle title='推荐新闻' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$读出内容 block=\'BlockName推荐新闻\' file=\'\'$]'$}
    <div class="clear10"></div>


<!--#Module module_Right end#-->
</text>

<text>
<R#读出内容BlockName公司介绍 start#>
{$GetOnePageBody title='最新公告' default='没有最新公告' fieldname='aboutcontent' $}
<R#读出内容BlockName公司介绍 end#>

<R#读出内容BlockName案例展示 start#> 
{$GetContentModule modulename='module_ALZS' sourcelist='22[Array]' replacelist='22[Array]'$}
<R#读出内容BlockName案例展示 end#>


<R#读出内容BlockName新闻中心 start#>


                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList topnumb='6' addsql='' default='[_2016年01月15日 14时11分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时11分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>

<R#读出内容BlockName新闻中心 end#>


<R#读出内容BlockName行业新闻 start#>

                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList topnumb='6' addsql=' order by adddatetime desc' default='[_2016年01月15日 14时12分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时12分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>
<R#读出内容BlockName行业新闻 end#>



<R#读出内容BlockNameASP start#>


                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList did="ASP" topnumb='6' addsql='' default='[_2016年01月15日 14时11分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时11分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>

<R#读出内容BlockNameASP end#>


<R#读出内容BlockNameSEO start#>

                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList did="SEO" topnumb='6' addsql=' order by adddatetime desc' default='[_2016年01月15日 14时12分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时12分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>
<R#读出内容BlockNameSEO end#>


<R#读出内容BlockName在线ASP转PHP start#>


                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList did="在线ASP转PHP" topnumb='6' addsql='' default='[_2016年01月15日 14时11分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时11分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>

<R#读出内容BlockName在线ASP转PHP end#>


<R#读出内容BlockNameASPPHPCMS start#>

                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList did="ASPPHPCMS" topnumb='6' addsql=' order by adddatetime desc' default='[_2016年01月15日 14时12分]'$}</sPAn>        
                    <!--#[_2016年01月15日 14时12分]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>
<R#读出内容BlockNameASPPHPCMS end#>



<R#读出内容BlockName推荐新闻 start#> 
{$GetContentModule modulename='module_推荐新闻' $}
<div class="clear10"></div>
<R#读出内容BlockName推荐新闻 end#>
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
.pscrolllt2_l{    
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


<div class="pscrolllt2_l">
    <a href="javascript:;" id="PLeftIDt2"><img src="LR_L.gif"></a> 
</div>
<div id="PScollName1" class="fl">

<sPAn class="testspan">{$ArticleList columnname='模板下载' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_案例展示2015年01月06日 15时48分]' autoadddid='true' autoadd='true'$}</sPAn>
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
<div class="pscrolllt2_l">
    <a href="javascript:;" id="PRightIDt3"><img src="LR_R.gif"></a>
</div>
<div class="clear"></div>
<script language="javascript" type="text/javascript">
    var adsp1 = new ScrollPicleft();
    adsp1.scrollContId = "PScollName1"; // 内容容器ID""
    adsp1.arrLeftId = "PLeftIDt2"; //左箭头ID
    adsp1.arrRightId = "PRightIDt3"; //右箭头ID
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
【推荐新闻】
<style>
/*新闻展示 这里面核心是.subnr dd{里面的宽 */ 
.subnr{
    font-size:12px; 
    width: 720px;
}
.subnr dl{
    height: 112px;
    overflow: hidden;
}
.subnr dl img{
    width: 130px;
    height: 100px;
    border: 1px solid #C1C1C1;
    padding: 1px;
}
.subnr dl h5{
    height: 20px;
    overflow: hidden;
    font-size:12px;
}
.subnr dl a{
    color: #616262;
    text-decoration: none;
}
.subnr dl a:hover{
    text-decoration:underline;
}
.subnr dt{
    width: 134px;
    height: 104px;
    float: left;
}
.subnr dd{
    float: left;
    line-height: 22px;
    padding-left:10px;
     width:570px;
}
.subnr dd p{
    height: 66px;
    overflow: hidden;
    color: #616262;
}
.subnr dl dd a{
    line-height:18px;    
    color: #616262;
    text-decoration:none;
}
.subnr dl dd a:hover{
    text-decoration:underline;
}
.subnr dl dd a:hover{
    text-decoration:underline;
}
.subnr dl dd a.more{
    font-size:12px;
    line-height:18px;
    color:#FF0000;
    text-decoration: none;
}
.subnr dd a.more:hover{
    text-decoration:underline;
}
/*更多列表*/
.subnr .ulss{

}
.subnr .ulss span{
    float: right;
    color: #CBCBCB;
}
.subnr .ulss li{
    line-height: 30px;
    font-family: "宋体";
    border-bottom:1px dashed #999999;
    color:#616262;
}
.subnr .ulss li a{
    color: #616262;
    text-decoration: none;
}
.subnr .ulss li a:hover{
    text-decoration:underline;
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/新闻/新闻样式一/' isHandle='true'$}</sPAn>

<!--#Module module_推荐新闻 start#-->
<div class="subnr">
    
<sPAn class="testspan">{$CustomInfoList did='模板下载' topnumb='4' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_最新推荐新闻2015年01月06日 15时48分]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_最新推荐新闻2015年01月06日 15时48分]

    [list-1]<dl>
        <dt><a [$aurl$]><img src="[$smallimage$]" alt="[$title$]"></a></dt>
        <dd>
            <h5><a [$aurl$]>[$title len='30' delhtml='true' trim='true' deltabs='true' $]</a></h5>
            <p>[$bodycontent len='255' delhtml='true' trim='true' deltabs='true' $]</p>
            <a href="[$url$]" title="了解详情" class="more">[了解详情]</a>
        </dd>
    </dl>
    <ul class="ulss">
[/list-1]
 
        [list]<li><span>[[$adddatetime format_time='2'$]]</span>·<a [$aurl$]>[$title len='30' delhtml='true' trim='true' deltabs='true' $]</a></li>[/list]
    [dialog end]</ul>[/dialog end]
#-->
    
</div>

<!--#Module module_推荐新闻 end#-->
</text>
---------------------
【加载底部框架】
<text>
{$Include file='Foot.html' block='foot'$} 
</text>
---------------------
【更多 样式】

<style>
a.more_red0{font-size:12px;color:#FF0000; float:right; height:auto;}
a.more_red0:hover{text-decoration:none;color:#DB0000}

a.more_red1{font-size:12px;color:#CC3333; float:right; height:auto;}
a.more_red1:hover{text-decoration:none;color:#BD2F2F}

a.more_red2{font-size:12px;color:#FF6666; float:right; height:auto;}
a.more_red2:hover{text-decoration:none;color:#FF4A4A}

a.more_red3{font-size:12px;color:#CC0033; float:right; height:auto;}
a.more_red3:hover{text-decoration:none;color:#BD0030}

a.more_red4{font-size:12px;color:#990033; float:right; height:auto;}
a.more_red4:hover{text-decoration:none;color:#88002D}

a.more_green0{font-size:12px;color:#99CC00; float:right; height:auto;}
a.more_green0:hover{text-decoration:none;color:#8FBF00}

a.more_green1{font-size:12px;color:#339933; float:right; height:auto;}
a.more_green1:hover{text-decoration:none;color:#2F8E2F}

a.more_green2{font-size:12px;color:#336600; float:right; height:auto;}
a.more_green2:hover{text-decoration:none;color:#2C5700}

a.more_green3{font-size:12px;color:#006633; float:right; height:auto;}
a.more_green3:hover{text-decoration:none;color:#00552B}

a.more_green4{font-size:12px;color:#006600; float:right; height:auto;}
a.more_green4:hover{text-decoration:none;color:#00371C}

a.more_blue0{font-size:12px;color:#003060; float:right; height:auto;}
a.more_blue0:hover{text-decoration:none;color:#002142}

a.more_blue1{font-size:12px;color:#3399CC; float:right; height:auto;}
a.more_blue1:hover{text-decoration:none;color:#2F8CB9}

a.more_blue2{font-size:12px;color:#336699; float:right; height:auto;}
a.more_blue2:hover{text-decoration:none;color:#2E5B89}

a.more_blue3{font-size:12px;color:#006699; float:right; height:auto;}
a.more_blue3:hover{text-decoration:none;color:#005B88;}

a.more_blue4{font-size:12px;color:#99CCFF; float:right; height:auto;}
a.more_blue4:hover{text-decoration:none;color:#84C1FF}

a.more_yellow0{font-size:12px;color:#FFCC00; float:right; height:auto;}
a.more_yellow0:hover{text-decoration:none;color:#EABB00}

a.more_yellow1{font-size:12px;color:#FFFFB0; float:right; height:auto;}
a.more_yellow1:hover{text-decoration:none;color:#FFFF8E}

a.more_yellow2{font-size:12px;color:#FFFF75; float:right; height:auto;}
a.more_yellow2:hover{text-decoration:none;color:#FFFF4D}

a.more_yellow3{font-size:12px;color:#E3E300; float:right; height:auto;}
a.more_yellow3:hover{text-decoration:none;color:#BBBB00;}

a.more_yellow4{font-size:12px;color:#919100; float:right; height:auto;}
a.more_yellow4:hover{text-decoration:none;color:#6F6F00}

a.more_white0{font-size:12px;color:#FFFFFF; float:right; height:auto;}
a.more_white0:hover{text-decoration:none;color:#F3F3F3}

a.more_black0{font-size:12px;color:#000000; float:right; height:auto;}
a.more_black0:hover{text-decoration:none;color:#2D2D2D}

a.more_gray0{font-size:12px;color:#999999; float:right; height:auto;}
a.more_gray0:hover{text-decoration:none;color:#333333}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/More更多按钮/默认版/' isHandle='true'$}</sPAn>



</text>
---------------------
#默认网页模板列表# end




#Source参数列表# start

#Source参数列表# end
[处理动作设置]{生成并IE打开}
[配置设置]{#dialogbackground='默认' dialogborder='默认' modulebackground='默认' moduleborder='默认' }
[样式前缀设置]{ind_}
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

