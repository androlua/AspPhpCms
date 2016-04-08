#默认网页模板列表# start
【底部开始标签】
<text>
<!--#foot start#-->
</text>
---------------------
【大客户】 

<dIv style='width:980px;margin:0 auto;'>
<style>
/*产品展示左右切换*/
.pscrollldkh_l{    
    float:left;
    padding: 30px 28px 0 0px;
}
.pscrolllrgal_r{    
    float:right;
    padding: 30px 0px 0px 10px;
}
#PScollNameLH .pproductlist1{
    float:left;
    width:147px; 
}
#PScollNameLH .pproductlist1 img{
    border: 1px solid  #CCCCCC;
    padding:1px;
    width:135px;
    height:70px;
}
#PScollNameLH .pproductlist1 a.tlink{
    display: block;
    height: 24px;
    line-height: 24px;
    color: #FFFFFF;
    text-align: center;
    padding-top: 1px;
    overflow: hidden;
    text-decoration:none;
    width:165px;
}
#PScollNameLH .pproductlist1 a.tlink:hover{
    text-decoration: underline;
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/朗辉/产品滚动2/' isHandle='true'$}</sPAn>


 

<div class="pscrollldkh_l">
    <a href="javascript:;" id="PLeftIDLH"><img src="LR_lh2_L.gif"></a> 
</div>
<div id="PScollNameLH" class="fl">
    
<sPAn class="testhidde">{$CustomInfoList did='大客户' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_产品展示2015年01月06日 15时48分]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_产品展示2015年01月06日 15时48分]
    [list]    
    <div class="pproductlist1">
        <a href="[$url$]"><img src="[$smallimage$]" width="200" height="150" alt="[$title$]" /></a>
        
    </div>    
    [/list] 
#-->

    <div class="clear"></div>
</div>
<div class="pscrolllrgal_r">
    <a href="javascript:;" id="PRightIDLH"><img src="LR_lh2_R.gif"></a>
</div>
<div class="clear"></div>
<script language="javascript" type="text/javascript">
    var adsp1 = new ScrollPicleft();
    adsp1.scrollContId = "PScollNameLH"; // 内容容器ID""
    adsp1.arrLeftId = "PLeftIDLH"; //左箭头ID
    adsp1.arrRightId = "PRightIDLH"; //右箭头ID
    adsp1.frameWidth = 880; //显示框宽度
    adsp1.pageWidth = 147; //翻页宽度
    adsp1.speed = 10; //移动速度(单位毫秒，越小越快)
    adsp1.space = 10; //每次移动像素(单位px，越大越快)
    adsp1.autoPlay = true; //自动播放
    adsp1.autoPlayTime = 3; //自动播放间隔时间(秒)
    adsp1.initialize(); //初始化
</script>

 <div class="clear10"></div>
</text>
</dIv>
---------------------
【友情链接】
<dIv style='width:980px;margin:0 auto;'>
 

<style>
/*友情链接*/
.link{ 
    height: 104px;
    overflow: hidden;
    border: 1px solid #e4e4e4; 
    background-color: #fff;
}
.link h2{ 
    font-size: 26px;
    height: 31px;
    line-height: 31px;
    padding: 0 15px 0 18px;
    font-weight: normal;
}
.link h2 font{ 
    font-variant: small-caps;
    font-size: 24px;
    font-family: "Times New Roman", Times, serif;
    padding-right: 5px;
    color: #919191;
}
.link h2 a{
    font-size: 14px;
    color: #3b1a1d;
    text-decoration:none;
}

.link h2 .ltitle{
    font-size: 14px;
    color: #3b1a1d;
    text-decoration:none;
}
.link h2 a:hover{
    color: #3b1a1d;
    text-decoration:underline;
}
.link .l_con{
    height: 59px;
    line-height: 26px;
    overflow: hidden;
    padding: 10px 10px 0 10px;
    background: url(linkbg.gif) repeat-x left top;
    color: #696969;
}
.link .l_con a{
    font-size: 12px;
    color: #696969;
    text-decoration:none;
}
.link .l_con a:hover{
    text-decoration:underline;
}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/其它/友情链接/' isHandle='true'$}</sPAn>

 



<div class="link">
    <h2>
    <!--#test start#-->
    <!--
    <span class="fr"><a href="/FriendLink/Apply.aspx" target="_blank">申请友情链接入口 &gt;&gt;</a></span><a href="#">友情链接</a>
    -->
    <!--#test end#-->
    <font>links</font><span class="ltitle">友情链接</span>
    </h2>    
    <div class="l_con">
       

<!--#显示友情链接列表简单版#-->
<sPAn class="testspan">{$Links addsql=" where isthrough<>0" default='[_2016年03月31日 17时20分]'$}</sPAn> 
<!--#[_2016年03月31日 17时20分]
[list]<a href="[$httpurl$]" title="[$title$]"[$atarget$][$abcolor$]>[$title$]</a> | 
[/list] 
#-->


      
    </div>        
</div>
 <div class="clear10"></div>
</text>
</dIv>
---------------------
【foot content】
<style>
.footboxbg{
    background-color:#666666; 
} 
.footbox{
    width:980px; 
    margin:0 auto;
    position:relative;
    color:#FFFFFF;
    font-size:12px;
    line-height:20px;
} 
.footbox .footnav{
    padding:20px 0 20px 0;
}
.footbox .line{
    height:1px;
    background-image:url(footline.png);
    background-repeat:no-repeat;
    background-position:center top;
    overflow:hidden;
}
.footbox .textbox{
    padding:20px 0 12px 0;
}
.footbox .textbox .textcontent{
    float:left;
    padding:0 0 0 10px;
}
.footboxbg a{font-size:12px;color:#FFFFFF;  }
.footboxbg a:hover{color:#F3F3F3;text-decoration: underline;}
</style>
<body>
<text>
<sPAn class="testspan">{$copyTemplateMaterial dir='模块功能列表/朗辉/Foot/' isHandle='true'$}</sPAn>


<div class="footboxbg">
    <div class="footbox">
        <div class="footnav">

<sPAn class="testspan">{$ColumnList flags='foot' addsql='order by sortrank' default='[_2016年03月09日 13时42分]'$}</sPAn>
<!--#[_2016年03月09日 13时42分]
[list]<a href="[$url$]">[$columnname$]</a>&nbsp;|&nbsp;[/list]
[list-focus][$columnname$]&nbsp;|&nbsp;[/list-focus]
#-->

        </div>
        <div class="line"></div>
        <div class="textbox">
            <div class="fl">
<sPAn class="testspan">{$MainInfo title='底部LOGO' showtitle='底部LOGO' default='[_底部LOGO2015年02月12日 15时58分]' autoadd='true'$}</sPAn>
<!--#test start#-->
<!--#[_底部LOGO2015年02月12日 15时58分] start#-->
<img src="Footlogo.png" />
<!--#[_底部LOGO2015年02月12日 15时58分] end#-->
<!--#test end#-->
            </div>
            <div class="textcontent">
            
            
<sPAn class="testspan">[$cfg_websitebottom default='[_2015年02月12日 16时06分]'$]</sPAn>
<!--#test start#-->
<!--#[_2015年02月12日 16时06分] start#-->
南京朗辉光电科技有限公司  苏ICP备 0216431465号-5<br />
地址：南京市秦淮区应天大街188号晨光1865创意产业园A9幢<br />
电话：025-83112009       传真：025-83112019      照明热线：400 025 8988<br />
技术支持：南京微战略信息科技有限公司<br />
<!--#[_2015年02月12日 16时06分] end#-->
<!--#test end#--> 
 
            
            
            </div>
            <div class="fr">
            
            
            
<sPAn class="testspan">{$MainInfo title='底部WX' showtitle='底部WX' default='[_底部WX2015年02月12日 15时59分]' autoadd='true'$}</sPAn>
<!--#test start#-->
<!--#[_底部WX2015年02月12日 15时59分] start#-->
<img src="wx.gif" />
<!--#[_底部WX2015年02月12日 15时59分] end#-->
<!--#test end#-->







            </div>
            <div class="clear"></div>
        </div>
    </div>  
</div>
</text>
---------------------
【底部结束标签】
<text>
<!--#foot end#-->
</text>
---------------------
#默认网页模板列表# end




#Source参数列表# start

#Source参数列表# end
[处理动作设置]{生成并IE打开}
[配置设置]{#dialogbackground='默认' dialogborder='默认' modulebackground='默认' moduleborder='默认' }
[样式前缀设置]{f_}
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
