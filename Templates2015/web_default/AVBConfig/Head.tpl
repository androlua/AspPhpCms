#默认网页模板列表# start
【顶部开始标签】
<text>
<!--#top start#-->
</text>
---------------------
【topbar】
<text>
{$GetContentModule modulename='module_topbar'$}
 
</text>
---------------------
【top】
<style>
.top3 {
    height: 150px;
    width: 980px;
    margin: auto;
    vertical-align: top;
    font-size: 20px;
    font-family:"微软雅黑", "黑体", "宋体";
}
.top31{
    font-size: 20px;
    width: 200px;
    height: auto;
    float: right;
    border-top-color: #003399;
    border-right-color: #003399;
    border-bottom-color: #003399;
    border-left-color: #003399;
    font-family:"微软雅黑", "黑体", "宋体";
    line-height: 30px;
    margin-top: 80px;
    background-image: url(top1.png);
    background-repeat: no-repeat;
    text-align: center;
    background-position: 20px -5px;
}
.top31 div{
    font-family:Verdana, Arial, Helvetica, sans-serif;
    font-size:18px;
    font-weight:bold;
    line-height: 30px;
    color: #606060;
}
.top32 {
    float: left;
    width: 600px;
    color: #4c4c4c;
    margin-top: 30px;
}
.top1right {
    float: right;
    width: 230px;
}
.top31a {
    font-family:"微软雅黑", "黑体", "宋体";
    font-size: 24px;
    color:#c40000;
    font-weight: bold;
}
.top321 {
    float: left;
    height: 120px;
    width: 150px;
}
.top322 {
    padding-top: 40px;
    line-height: 35px;
}
.p4 {
    font-family:"微软雅黑", "黑体", "宋体";
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/九拓自动化/顶部/' isHandle='true'$}</sPAn>


<div class="top3">
    <div class="top32">
        <div class="top321"><img src="jy_03.png" width="142" height="104" /></div>
         <div class="top322">
         
<sPAn class="testspan">{$MainInfo title='顶部公司标语' showtitle='顶部公司标语' default='[_顶部公司标语2014年12月05日 11时24分]' autoadd='true'$}</sPAn>
<!--#test start#-->
<!--#[_顶部公司标语2014年12月05日 11时24分] start#-->
            <p class="p4">分享模板网站</p>
            <p>打造国内每一分享平台家园</p>
<!--#[_顶部公司标语2014年12月05日 11时24分] end#-->
<!--#test end#-->
           
         </div>
    </div>
    <div class="top31">
<sPAn class="testhidde">{$MainInfo title='顶部服务热线' showtitle='顶部服务热线' default='[_顶部服务热线2014年12月05日 11时26分]' autoadd='true'$}</sPAn>
<!--#test start#-->
<!--#[_顶部服务热线2014年12月05日 11时26分] start#-->
      <p>服务热线:</p>
       <div>400-800-0000</div>
<!--#[_顶部服务热线2014年12月05日 11时26分] end#-->
<!--#test end#-->

    </div>
    <div class="clear"></div>
</div>
<div class="clear"></div>
</text>
---------------------
【nav】

 

<dIv>
<text> 
{$DisplayWebColumn focustype='text,a' styleid='134' stylevalue='0' addsql=' where parentid\=-1 and flags like\'%top%\' order by sortrank'  navwidth='width:980px;margin:0 auto;' dropdownmenu='true' isconcise='true' deletedefault='true' shopnavidwrap='true'$}
 
</text>
</dIv>
---------------------
【banner】

 


 

<text>
<div>
{$GetContentModule modulename='module_Banner'$}
</div>

<div class="clear10"></div>
</text>
---------------------
【顶部 加入收藏 设为首页】
<style>
.lightbox{

}
.lightbox .black_overlay{
    display: none;
    position: absolute;
    top: 0%;
    left: 0%;
    width: 100%;
    height: 100%;
    background-color: black;
    z-index:1001;
    -moz-opacity: 0.3;
    opacity:.30;
    filter: alpha(opacity=30);
}
.lightbox .white_content {
    display: none;
    position: absolute;
    top: 100px;
    left: 25%;
    width: 450px;
    height: 490px;
    padding: 1px;
    border: 10px solid #000000;
    background-color:#FFFFFF;
    z-index:1002;
    overflow:hidden;
}
/*顶部条*/
.topbarbox{
    width:100%;
    background:#F7F7F7;
    color:#666666;
    height:26px;
    line-height:26px;
    border-bottom:1px solid #D8D8D8;
    font-size:12px;
}
/*默认链接样式*/
.topbarbox a{font-size:12px;color:#666666}
.topbarbox a:hover{text-decoration:none;color:#333333}
/*topbar框架*/
.topbarbox .topbar{
    width:980px;
    margin:0 auto;
}
/*左边布局*/
.topbarbox .topbar .left{
    float:left;
}
    /*微信*/
.topbarbox .topbar .left .weixin{
    color:#333333;
    background-image:url(icon_gz.gif);
    background-position: 0px -75px;
    background-repeat:no-repeat;
    padding-left:24px;
    display:block;
    float:left;
}
    /*绿色关注*/
.topbarbox .topbar .left a.greengz{
    background-image:url(icon_gz.gif);
    background-position: 0px -234px;
    background-repeat:no-repeat;
    width:39px;
    height:16px;
    display:block;
    float:left;
    margin:4px 0 0 4px;
}
    /*微博*/
.topbarbox .topbar .left .weibo{
    color:#333333;
    background-image:url(icon_gz.gif);
    background-position: 0px 3px;
    background-repeat:no-repeat;
    padding-left:24px;
    display:block;
    float:left;
}
    /*红色关注*/
.topbarbox .topbar .left a.redgz{
    background-image:url(icon_gz.gif);
    background-position: 0px -196px;
    background-repeat:no-repeat;
    width:39px;
    height:16px;
    display:block;
    float:left;
    margin:4px 0 0 4px;
}
    /*左边线*/
.topbarbox .topbar .left .line{
    float:left;
    display:block;
    margin:5px 10px 0 0;
    color:#FF0000;
    background:green;
}
#localtime{
    float:left;
    display:block;
}
/*右边布局*/
.topbarbox .topbar .right{
    float:right;
}
.topbarbox .topbar .right a.weiboico{
    background-image:url(icon_gz.gif);
    background-position: 0px -42px;
    background-repeat:no-repeat;
    padding-left:28px;
}
.topbarbox .topbar .right a.tqqico{
    background-image:url(icon_gz.gif);
    background-position: 0px -118px;
    background-repeat:no-repeat;
    padding-left:28px;
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='TopBar/1/' isHandle='true'$}</sPAn>

<!--#Module module_topbar start#-->


<div class="lightbox">
    <div id="light" class="white_content">
        <sPAn class="testspan">{$MainInfo title='微信关注大图' showtitle='微信关注大图' default='[_微信关注大图2015年01月28日 09时59分]' autoadd='true'$}</sPAn>
<!--#test start#-->
<!--#[_微信关注大图2015年01月28日 09时59分] start#-->
<img src="nwwx.jpg">
<!--#[_微信关注大图2015年01月28日 09时59分] end#-->
<!--#test end#--> 
    </div>
    <div id="fade" class="black_overlay" onClick="CloseLightBox('light','fade');"></div>
</div>

<div class="topbarbox">
    <div class="topbar">
        <div class="left">
            <span class="weixin">微信</span><a href="#" class="greengz" onClick="ShowLightBox('light','fade');"></a><span class="line"></span>
            <span class="weibo">微博</span><a href="http://d.weibo.com/" rel="nofollow" target="_blank" class="redgz"></a><span class="line"></span>
            <!--#<span id="localtime"></span><script type="text/javascript">time_tick("南京市微战略科技有限公司")</script>#-->
            <span>{$MainInfo title='顶部公司欢迎语' showtitle='顶部公司欢迎语' default='欢迎访问：ASPPHPCMS内容管理系统官网' autoadd='true'$}</span>
        </div>
        <div class="right">
<sPAn class="testhidde">{$MainInfo title='网站顶部文本TopBar' showtitle='网站顶部文本TopBar' default='[_网站顶部文本TopBar2015年01月26日 09时07分]' autoadd='true'$}
<!--#test start#-->
<!--#[_网站顶部文本TopBar2015年01月26日 09时07分] start#-->
{$HrefA content='加入收藏' title='加入收藏' type='收藏' $}&nbsp;|&nbsp;
{$HrefA content='设为首页' title='设为首页' type='设为首页' $}&nbsp;|&nbsp;
<a href="{$GetColumnUrl columnname='网站地图'$}" target="_blank">网站地图</a>&nbsp;|&nbsp;
{$HrefA href='http://d.weibo.com/' title='新浪微博' rel='nofollow' class='weiboico' target='_blank'$}&nbsp;|&nbsp;
{$HrefA href='http://t.qq.com/' title='腾讯微博' rel='nofollow' class='tqqico' target='_blank'$}
<!--#[_网站顶部文本TopBar2015年01月26日 09时07分] end#-->
<!--#test end#--> 
</sPAn>  
<!--#test start#-->
<a href="#">加入收藏</a> | 
<a href="#">设为首页</a> | 
<a href="#">网站地图</a> | 
<a href="#" class="weiboico">新浪微博</a> | 
<a href="#" class="tqqico">腾讯微博</a>
<!--#test end#-->         
        </div>
    </div>
</div>
<!--#Module module_topbar end#-->
</text>
---------------------
【Banner】


<style>
.banner6{
    height:439px;overflow:hidden; position:relative;width: 99%;
}
#bfocus7 {
    width:100%;
    height:100%;
    overflow:hidden;
    position:relative;
}
#bfocus7 ul {
    height:100%;
    position:absolute;
}
#bfocus7 ul li {
    width:100%;
    height:100%;
    float:left;
    height:439px;
} 
#bfocus7 ul li a{
    height:439px;
    display:block;
}
#bfocus7 ul li div {
    position:absolute;
    overflow:hidden;
}
#bfocus7 .btn {
    position:absolute;
    width:500px;
    height:14px;
    right:50%;
    bottom:8%;
    text-align:right;
}
#bfocus7 .btn span {
    display:inline-block;
    _display:inline;
    _zoom:1;
    width:14px;
    height:14px;
    _font-size:0;
    margin-left:5px;
    cursor:pointer;
    background:url(i-19.png) no-repeat;
}
#bfocus7 .btn .spanon {
    background:url(i-18.png) no-repeat;
}
#bfocus7 .preNext {
    width:45px;
    height:100px;
    position:absolute;
    top:40%;
    background:url(sprite.png) no-repeat 0 0;
    cursor:pointer;
}
#bfocus7 .pre {
    left:10%;
}
#bfocus7 .next {
    right:10%;
    background-position:right top;
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/Banner/106/' isHandle='true'$}</sPAn>

<!--#Module module_Banner start#-->

<script type="text/javascript"  src="Banner_Style106.js"></script>
<div class="banner6">
    <div id="bfocus7">
        <ul>

{$ArticleList topnumb='6' did='banner' addsql='' default='[_2016年01月15日 14时11分banner]'$}
                    <!--#[_2016年01月15日 14时11分banner]
                            [list]<li style="background:url([$smallimage$]) 50% no-repeat;"><a href="[$url$]"></a></li>
                            [/list]
                    #-->   

        </ul>
    </div>
</div>

<!--#Module module_Banner end#-->
</text>
---------------------
【顶部结束标签】
<text>
<!--#top end#-->
</text>
---------------------
#默认网页模板列表# end




#Source参数列表# start

#Source参数列表# end
[处理动作设置]{生成并IE打开}
[配置设置]{#dialogbackground='默认' dialogborder='默认' modulebackground='默认' moduleborder='默认' }
[样式前缀设置]{h_}
[帮助信息设置]{}
[Css保存文件设置]{style.css}
[ASP动作处理设置]{不处理动作}
[动作文件设置]{}
[默认HTML设置]{1、Template.Html}
[默认CSS设置]{9、testwebCommon.css}
[自定义模板]{}
[自定义CSS]{}
[自定义模板动作]{}
[自定义CSS动作]{}
[txtIsCodeHtmlTemplate]{1}
[txtIsCodeCssTemplate]{1}
[txtIsDeleteRepeatCssClass]{1}
[txtCopyImageEncryption]{}
