#Ĭ����ҳģ���б�# start
�����ض�����ܡ�
<text>
{$Include file='head.html' block='top'$} 
</text>
---------------------
����ܲ��֡�
<dIv style="width:980px;margin:0 auto;">
<!--#���#-->
<dIv style="width:230px;float:left;">
<text>
{$GetContentModule modulename='module_Left' sourcelist='22[Array]' replacelist='22[Array]'$}
</text>
</dIv>

<!--#�ұ�#-->
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
����߲��֡�
<text>
<!--#Module module_Left start#-->

    {$ReadColumeSetTitle title='��վ����' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName��վ����\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='��Ʒ�б�' style='22' contentwidth='220' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName��Ʒ�б�\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='��������' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName��������\' file=\'\'$]'$}
    <div class="clear10"></div>    

    {$ReadColumeSetTitle title='���¶�̬' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName���¶�̬\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='��������' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName��������\' file=\'\'$]'$}
    <div class="clear10"></div>
    
    {$ReadColumeSetTitle title='��ϵ��ʽ' style='22' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName��ϵ��ʽ\' file=\'\'$]'$}
    <div class="clear10"></div>


<!--#Module module_Left end#-->
</text>

<text>
<R#��������BlockName��վ���� start#>
{$GetOnePageBody title='���¹���' default='û�����¹���' fieldname='aboutcontent' delhtml='true' len='300' $}
<R#��������BlockName��վ���� end#>

<R#��������BlockName��Ʒ�б� start#>
 

                <ul class="ulstyleone">                         

<sPAn class="testspan">{$ColumnList columnname='��Ʒչʾ' flags='' addsql='order by sortrank' default='[_2016��03��31�� 16ʱ27��]'$}</sPAn>

<!--#[_2016��03��31�� 16ʱ27��]
[list]<li><a href="[$url$]">[$columnname$]</a></li>
[/list]
[list-focus]<li><a href="[$url$]"><font color=red>[$columnname$]</font></a></li>
[/list-focus]
#-->
        
                </ul>

<R#��������BlockName��Ʒ�б� end#>

<R#��������BlockName�������� start#>
{$GetContentModule modulename='module_��������' sourcelist='22[Array]' replacelist='22[Array]'$}
<R#��������BlockName�������� end#>

<R#��������BlockName���¶�̬ start#>

                <ul class="ulstyleone">                         
                    <sPAn class="testhidde">{$ArticleList topnumb='8' addsql=' order by adddatetime desc' default='[_2016��01��15�� 14ʱ10��]'$}</sPAn>        
                    <!--#[_2016��01��15�� 14ʱ10��]
                            [list]<li><a href="[$url$]" title="[$title$]"[$atarget$][$abcolor$]>[$title len='80'$]</a></li>
                            [/list]
                    #-->            
                </ul>


<R#��������BlockName���¶�̬ end#>

<R#��������BlockName�������� start#>
{$GetContentModule modulename='module_CJWT' sourcelist='22[Array]' replacelist='22[Array]'$}
<R#��������BlockName�������� end#>

<R#��������BlockName��ϵ��ʽ start#>
{$GetColumnBody columnname='��ϵ����' fieldname='aboutcontent' default='����Ŀ����'$}
<R#��������BlockName��ϵ��ʽ end#>

</text>
---------------------
���ұ߲��֡�
<text>
<!--#Module module_Right start#-->

    {$ReadColumeSetTitle title='[\$detailTitle\$]' style='22' contentwidth='720' moreclass='leftmore' morestr='More' moreurl=' ' stylevalue='0' value='[$�������� block=\'BlockName��ϸ����\' file=\'\'$]'$}
    <div class="clear10"></div>
    
     

<!--#Module module_Right end#-->
</text>

<text>
<R#��������BlockName��ϸ���� start#>


 <div class="articletimes">���ߣ�[$glb_artitleAuthor$] �����ڣ�[$glb_artitleAdddatetime format_time='1'$]</div>
                [$detailContent$]
                [$glb_aritcleRelatedTags$]
                <ul class=""updownarticlewrap"">
                <li>{$glb_upArticle$}</li>
                <li>{$glb_downArticle$}</li>
                </ul>
 

<R#��������BlockName��ϸ���� end#>

</text>
---------------------
�����ض��� ���صײ���
<style>
/* ������� */
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
<sPAn class="testspan">{$copyTemplateMaterial dir='ģ�鹦���б�/����/���ٷ��ص㲿�͵ײ�/' isHandle='true'$}</sPAn>


<script type="text/javascript" src="backtopandbackbutton.js"></script>
 <div id="floatPanel">
    <div class="ctrolPanel">
        <a class="arrow" href="#"><span>����</span></a><a class="contact" href="javascript:openWind('/Inc/Create_Html.Asp?act=Nav&NavDidType=��ҳ&MackHtml=False&Debug=True&Template=����֤&Did=���߷���','250','230','���߷���')"><span>����</span></a><a class="qrcode" href="#"><span>΢�Ŷ�ά��</span></a><a class="arrow" href="#"><span>�ײ�</span></a></div>
    <div class="popPanel">
        <div class="popPanel-inner">
            <div class="qrcodePanel">
            <sPAn class="testspan">{$MainInfo title='�������_���ض�����ײ�' showtitle='�������_���ض�����ײ�' default='[_�������_���ض�����ײ�2014��12��08�� 15ʱ36��]' autoadd='true'$}</sPAn>      
<!--#test start#-->
<!--#[_�������_���ض�����ײ�2014��12��08�� 15ʱ36��] start#-->
                <img src="weixin.jpg" />
<span>ɨ���ά���ע��Ϊ����</span>
<!--#[_�������_���ض�����ײ�2014��12��08�� 15ʱ36��] end#-->
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
�������������Ϲ���-��Դ��
<style>
/*swer(�ش����)Ask(��) Answer(��)*/
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

<sPAn class="testspan">{$copyTemplateMaterial dir='ģ�鹦���б�/����/���ⳣ������/' isHandle='true'$}</sPAn>


<div id="swer">   
    
<sPAn class="testspan">{$ArticleList columnname='' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_��������2015��01��06�� 15ʱ48��]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_��������2015��01��06�� 15ʱ48��]
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
������չʾ��
<style>
/*��Ʒչʾ�����л�*/
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

<sPAn class="testspan">{$copyTemplateMaterial dir='ģ�鹦���б�/��Ʒ/��Ʒ�߼�����3/' isHandle='true'$}</sPAn>


<div class="pscrolllr1_l">
    <a href="javascript:;" id="PLeftID1"><img src="LR_L.gif"></a> 
</div>
<div id="PScollName1" class="fl">

<sPAn class="testspan">{$ArticleList columnname='' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_����չʾ2015��01��06�� 15ʱ48��]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_����չʾ2015��01��06�� 15ʱ48��]
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
    adsp1.scrollContId = "PScollName1"; // ��������ID""
    adsp1.arrLeftId = "PLeftID1"; //���ͷID
    adsp1.arrRightId = "PRightID1"; //�Ҽ�ͷID
    adsp1.frameWidth = 650; //��ʾ����
    adsp1.pageWidth = 217; //��ҳ���
    adsp1.speed = 10; //�ƶ��ٶ�(��λ���룬ԽСԽ��)
    adsp1.space = 10; //ÿ���ƶ�����(��λpx��Խ��Խ��)
    adsp1.autoPlay = true; //�Զ�����
    adsp1.autoPlayTime = 3; //�Զ����ż��ʱ��(��)
    adsp1.initialize(); //��ʼ��
</script>

<!--#Module module_ALZS end#-->
</text>
---------------------
���������ʡ�
<style>
/*�������������л�*/
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
<sPAn class="testspan">{$copyTemplateMaterial dir='ģ�鹦���б�/����/�������������л�/' isHandle='true'$}</sPAn>

<!--#Module module_�������� start#-->


<div class="scrolllr_l">
    <a href="javascript:;" id="LeftID4"><img src="LR_L.gif"></a> 
</div>
<div id="ScollName4" class="fl">
    
<sPAn class="testspan">{$CustomInfoList did='��������' topnumb='10' cutstrnumb='22' defaultimage='/UploadFiles/NoImg.jpg' default='[_��������2015��01��06�� 15ʱ48��]' autoadddid='true' autoadd='true'$}</sPAn>
<!--#[_��������2015��01��06�� 15ʱ48��]
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
    ads.scrollContId = "ScollName4"; // ��������ID""
    ads.arrLeftId = "LeftID4"; //���ͷID
    ads.arrRightId = "RightID4"; //�Ҽ�ͷID
    ads.frameWidth = 140; //��ʾ����
    ads.pageWidth = 140; //��ҳ���
    ads.speed = 10; //�ƶ��ٶ�(��λ���룬ԽСԽ��)
    ads.space = 10; //ÿ���ƶ�����(��λpx��Խ��Խ��)
    ads.autoPlay = true; //�Զ�����
    ads.autoPlayTime = 3; //�Զ����ż��ʱ��(��)
    ads.initialize(); //��ʼ��
</script>
<!--#Module module_�������� end#-->

</text>
---------------------
�����صײ���ܡ�
<text>
{$Include file='Foot.html' block='foot'$} 
</text>
---------------------
#Ĭ����ҳģ���б�# end




#Source�����б�# start

#Source�����б�# end
[����������]{���ɲ�IE��}
[��������]{#dialogbackground='Ĭ��' dialogborder='Ĭ��' modulebackground='Ĭ��' moduleborder='Ĭ��' }
[��ʽǰ׺����]{news_}
[������Ϣ����]{}
[Css�����ļ�����]{style.css}
[ASP������������]{��������}
[�����ļ�����]{end
\Config\ASPAction\��ʽ��HTML.Asp
�������ļ��С�/../Jquery��|��[$ģ��·��$][$��վĿ¼����$]/Jquery}
[Ĭ��HTML����]{1��Template.Html}
[Ĭ��CSS����]{9��testwebCommon.css}
[�Զ���ģ��]{}
[�Զ���CSS]{}
[�Զ���ģ�嶯��]{}
[�Զ���CSS����]{}
[txtIsCodeHtmlTemplate]{1}
[txtIsCodeCssTemplate]{0}
[txtIsDeleteRepeatCssClass]{1}
[txtCopyImageEncryption]{|left|nav|module| }
