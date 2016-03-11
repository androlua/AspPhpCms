<?php 
/************************************************************
作者：云端 (精通ASP/VB/PHP/JS/Flash，交流合作可联系本人)
版权：源代码公开，各种用途均可免费使用。 
创建：2016-03-11
联系：QQ313801120  交流群35915100(群里已有几百人)    邮箱313801120@qq.com   个人主页 sharembweb.com
更多帮助，文档，更新　请加群(35915100)或浏览(sharembweb.com)获得
*                                    Powered by ASPPHPCMS 
************************************************************/
?>
<?PHP
//系统
require_once './ASP.php';
require_once './sys_FSO.php';
require_once './Conn.php';
require_once './MySqlClass.php';
require_once './sys_Url.php';
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>安装MYSQL数据库,QQ:313801120:::</title> 
<style type="text/css">
a img{border:none}
/*img{vertical-align:bottom; display:block;} 这种不要了，因为它会让图片成为块*/
.imga{vertical-align:bottom;}
.imgb{vertical-align:bottom; display:block;}/*解决图片下面有空隙的简单方法  以前是img{这样图片就会换行*/
body,div,p,img,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,blockquote{padding:0px;margin:0px}
li{list-style-type:none}
a{font-size:12px;line-height:18px;color:#000000;text-decoration:none}
a:hover{text-decoration:none;color:#000099}
/*PHPCMS表单样式*/
.input-text, .measure-input, textarea, input.date, input.endDate, .input-focus {
  border: 1px solid #A7A6AA;
  height: 22px;
  line-height:22px;
  margin: 0 5px 0 0;
  padding: 2px 0 2px 5px;
  border: 1px solid #d0d0d0;
  background: #FFF url(../images/input.png) repeat-x;
  font-family: Verdana, Geneva, sans-serif,"宋体";
  font-size: 12px;
}
input.date, input.endDate {
  background: #fff url(../images/input_date.png) no-repeat right 3px;
  padding-right: 18px;
  font-size: 12px;
}
select {
  vertical-align: middle;
  background: none repeat scroll 0 0 #F9F9F9;
  border-color: #666666 #CCCCCC #CCCCCC #666666;
  border-style: solid;
  border-width: 1px;
  color: #333;
  padding: 2px;
}
/*自定义按钮 待改进*/
.btnclick1{
	color: #000;
	font-size: 14px;
	padding:0 20px;
	background-color:#fff;
	border:0px;
	border:1px solid #666666;
	text-decoration:none;
	cursor:pointer;
	line-height: 26px;
	font-weight:bold;
	border-radius:5px;-moz-border-radius:5px;-webkit-border-radius:5px;-o-border-radius:5px;
}
.btnclick1:hover{
	background-color:#E6E6E6;
	background-position: 0px -50px;	
}
.btnclick1:active{
	background-color:#fff;
}



.pright {
width: 720px;
margin:0 auto;
}

.pr-title {
width: 720px;
height: 22px;
margin: 8px auto 0px;
background: url(images/boxtitle_bg.gif) 0px 20px repeat-x;
overflow: hidden;
}
.pr-title h3 {
width: 158px;
height: 22px;
line-height: 22px;
overflow: hidden;
display: block;
font-size: 12px;
padding-top: 1px;
text-indent: 10px;
background: url(images/boxtitle_bg.gif) 0px -2px no-repeat;
letter-spacing: 2px;
color: #6D8A4F;
font-weight: bold;
}



input{
vertical-align:middle;
margin-right:3px;
font-size:12px;
}
textarea{
vertical-align:top;
font-size:12px;
line-height:156%;
border:1px solid #AAA;
padding:3px;
letter-spacing:1px;
word-break:break-all;
overflow-y:auto;
}
.input-txt{
padding:4px 8px 4px 6px;
border:1px solid #AAA;
font-size:12px;
color:#000;
width:200px;
}

.textipt_on{
border:1px solid #F90;
}


hr{
height:1px;
line-height:1px;
overflow:hidden;
border-width:1px 0px 0px 0px ;
border-top:1px solid #E6E6E6;/*兼容Opera*/
}
hr:empty {
margin:8px 0px 7px 0px !important;
margin:0px;
}

small{
font-size:12px;
}

.moncolor td{
background:#FFC;
}

.twbox{
width:706px;
border:1px solid #CFDCC9;
font-size:12px;
overflow:hidden;
margin:8px auto;

}


.twbox thead tr td{
background:url(body_title_bg.gif) -1px -1px repeat-x;
height:31px;
line-height:31px;
text-indent:10px;
}

.twbox thead tr td strong{
letter-spacing:2px;
margin-right:14px;
color:#FFF;
font-size:14px;
}


.twbox thead tr td span{
color:#CDA;
}


.twbox thead tr td  p{
height:31px;
display:inline;
float:right;
margin:-31px 10px 0 0;
overflow:hidden;
}
.twbox thead tr td  p *{
float:right;
}
.twbox thead tr td a.thlink{
color:#FFF;
}
.twbox thead tr td a.thlink:hover{
color:#FFFF00;
text-decoration:none;
}


.twbox tbody {
overflow:hidden;
text-align:left;
}

.twbox tbody tr th{
background:#F9FCEF;
color:#6D8A4F;
line-height:21px;
height:21px;
text-indent:30px;
font-weight:normal;
border-bottom:1px solid #EFF7D8;
letter-spacing:2px;
}

.twbox tbody tr td{
padding:7px;
border-bottom:1px solid #F2F2F2;
color:#333;
vertical-align:top;
}

.twbox tbody tr td p{
line-height:21px;
}
.twbox tbody tr td p strong img{
vertical-align:middle;
}
.twbox tbody tr td img{
vertical-align:top;
margin:0px 10px 5px 0px;

}
.twbox tbody tr td small{
color:#888;
}

.twbox tfoot tr td{
padding:10px;
line-height:25px;
text-align:center;
}
.twbox tfoot tr td p{
line-height:21px;
margin-bottom:10px;
}

input.but{
height:26px;
padding-left:6px;
padding-right:6px;
line-height:26px;
font-weight:bold;
letter-spacing:1px;
color:#FFF;
background-color:#FC3;
}

.onetd{
width:120px;
text-align:right;
line-height:25px;
}

.mytipwrap{
	line-height:30px;
	color:#999999;
}
a.mytip {
    line-height: 14px;
    padding: 6px 20px;
    border-style: solid;
    border-width: 1px;
    border-color: #EEE #CCC #CCC #EEE;
    background: #FAFAFA;
    color: #333; 
    margin-right:10px;
    text-decoration: none;
}
</style>
</head>
<body>
<?php
$dbhost='localhost'; $dbuser='root'; $dbpwd=''; $dbname='phpwebdata';
$dbmsg='';$accessMsg='';

//安装
if(isset($_GET['act'])){
	$dbhost=$_POST['dbhost'];
	$dbuser=$_POST['dbuser']; 
	$dbpwd=$_POST['dbpwd'];
	$dbname=$_POST['dbname'];
	
	
    $conn = @mysql_connect($dbhost,$dbuser,$dbpwd);
    if($conn){
		if(empty($dbname)){
			$dbmsg="<font color='green'>信息正确</font>";		
			
		}else{
			if(mysql_select_db($dbname,$conn)){
			}else{
				//创建数据库
				if (mysql_query("CREATE DATABASE ".$dbname,$conn)){
				}else{
				  echo "Error creating database: " . mysql_error();
				} 	
			
			}
			$accessMsg = mysql_select_db($dbname,$conn)?"<font color='red'>数据库已经存在，系统将覆盖数据库</font>":"<font color='green'>数据库不存在,系统将自动创建</font>";		 
			
			
			$content=getftext('conn.php');
			
		 
			
			$s=StrCut($content,'dbhost=',"';",true,true); 
			$content = str_replace($s,'dbhost=\''.$dbhost.'\';',$content); 
			
			$s=StrCut($content,'dbuser=',"';",true,true); 
			$content = str_replace($s,'dbuser=\''.$dbuser.'\';',$content); 
			
			$s=StrCut($content,'dbpwd=',"';",true,true); 
			$content = str_replace($s,'dbpwd=\''.$dbpwd.'\';',$content);
			
			$s=StrCut($content,'dbname=',"';",true,true); 
			
			$content = str_replace($s,'dbname=\''.$dbname.'\';',$content);
			
			if (is_writable('conn.php')) {			
				createFile('conn.php',$content);
			}else{
				echo("出错，没有权限操作文件，手动配置<hr>".handlePath('conn.php').'<hr>配置完成后再点下一步<hr>');
			}
			step2();
			 
			 
			exit();
		}
    }else{
		$dbmsg="<font color='red'>数据库连接失败！</font>";
    }
    @mysql_close($conn); 
}




//截取字符串,CutType为1包括截取值 2为不包括截取值
function StrCut( $Content, $StartStr, $EndStr, $CutType){
    //On Error Resume Next
    $S1=''; $S1Str='';$S2='';$S3='';
    if( instr($Content,$StartStr)==false || instr($Content,$EndStr)==false ){
        $StrCut='';
        return @$StrCut;
    }
    switch ( $CutType ){
        //完善于20150923
        case 1;
        $S1 = instr($Content, $StartStr) ;
        $S1Str=mid($Content,$S1+strlen($StartStr),-1)			;
        $S2 = $S1+instr($S1Str, $EndStr)+strlen($StartStr)+strlen($EndStr)-1				;//为什么要减人
        break;
        case 2; 0; '';
        $S1 = instr($Content, $StartStr) + strlen($StartStr);
        $S1Str=mid($Content,$S1,-1);
        //S2 = InStr(S1, Content, EndStr)
        $S2 = $S1+instr($S1Str, $EndStr)-1;
        //call echo("s2",s2)
    }
    $S3=$S2 - $S1;
    if( $S3>=0 ){
        $StrCut = mid($Content, $S1, $S3);
    }else{
        $StrCut = '';
    }


    return @$StrCut;}
//获得截取内容,20150305
function GetStrCut( $Content, $StartStr, $EndStr, $CutType){
    $GetStrCut='';
    //Content=Replace(Replace(Content,Chr(13),""),Chr(10),"")
    if( instr($Content,$StartStr)>0 && instr($Content,$EndStr)>0 ){
        $GetStrCut = StrCut($Content,$StartStr,$EndStr,$CutType);
    }
    return @$GetStrCut;}
?>
<form id="form1" name="form1" method="post" action="?act=install">
<div class="pright">
    <div class="pr-title"><h3>数据库设定 第一步</h3></div>
    <table width="726" border="0" align="center" cellpadding="0" cellspacing="0" class="twbox">
        <tbody>
            <tr>
                <td class="onetd"><strong>数据库主机：</strong></td>
                <td><input name="dbhost" id="dbhost" type="text" value="<?=$dbhost?>" class="input-txt">
                    <small>一般为localhost</small>
                </td>
            </tr>
            <tr>
                <td class="onetd"><strong>数据库用户：</strong></td>
                <td><input name="dbuser" id="dbuser" type="text" value="<?=$dbuser?>" class="input-txt"></td>
            </tr>
            <tr>
                <td class="onetd"><strong>数据库密码：</strong></td>
                <td>
                  <div style="float:left;margin-right:3px;"><input name="dbpwd" type="text" class="input-txt" id="dbpwd" onchange="TestDb()" value="<?=$dbpwd?>">
                  </div>
                    <div style="float:left" id="dbpwdsta"><font color="red"><?=$dbmsg?></font></div>
                </td>
            </tr>
            <tr>
                <td class="onetd"><strong>数据库名称：</strong></td>
                <td>
                  <div style="float:left;margin-right:3px;"><input name="dbname" id="dbname" type="text" value="<?=$dbname?>" class="input-txt" onchange="HaveDB()">
                    </div>
                    <div style="float:left" id="havedbsta"><font color="red"><?=$accessMsg?></font></div>
                </td>
            </tr>
        </tbody>
    </table> 
    <!--
    <div class="pr-title"><h3>服务器信息</h3></div>
    <table width="726" border="0" align="center" cellpadding="0" cellspacing="0" class="twbox">
        <tbody>
            <tr>
                <th width="300" align="center"><strong>参数</strong></th>
                <th width="424"><strong>值</strong></th>
            </tr>
            <tr>
                <td><strong>服务器域名</strong></td>
                <td>127.0.0.1</td>
            </tr>
            <tr>
                <td><strong>服务器操作系统</strong></td>
                <td>WINNT</td>
            </tr>
            <tr>
                <td><strong>服务器解译引擎</strong></td>
                <td>Microsoft-IIS/7.5</td>
            </tr>
            <tr>
                <td><strong>PHP版本</strong></td>
                <td>5.6.10</td>
            </tr>
            <tr>
                <td><strong>系统安装目录</strong></td>
                <td>E:\E盘\PHP源码\DedeCMS-V5.7-GBK-SP1\uploads</td>
            </tr>
        </tbody>
    </table>
    <div class="pr-title"><h3>系统环境检测</h3></div>
    <div style="padding:2px 8px 0px; line-height:33px; height:23px; overflow:hidden; color:#666;">
        系统环境要求必须满足下列所有条件，否则系统或系统部份功能将无法使用。
    </div>
    <table width="726" border="0" align="center" cellpadding="0" cellspacing="0" class="twbox">
        <tbody>
            <tr>
                <th width="200" align="center"><strong>需开启的变量或函数</strong></th>
                <th width="80"><strong>要求</strong></th>
                <th width="400"><strong>实际状态及建议</strong></th>
            </tr>
            <tr>
                <td>allow_url_fopen</td>
                <td align="center">On </td>
                <td><font color="green">[√]On</font> <small>(不符合要求将导致采集、远程资料本地化等功能无法应用)</small></td>
            </tr>
            <tr>
                <td>safe_mode</td>
                <td align="center">Off</td>
                <td><font color="green">[√]Off</font> <small>(本系统不支持在<span class="STYLE2">非win主机的安全模式</span>下运行)</small></td>
            </tr>

            <tr>
                <td>GD 支持 </td>
                <td align="center">On</td>
                <td><font color="green">[√]On</font> <small>(不支持将导致与图片相关的大多数功能无法使用或引发警告)</small></td>
            </tr>
            <tr>
                <td>MySQL 支持</td>
                <td align="center">On</td>
                <td><font color="green">[√]On</font> <small>(不支持无法使用本系统)</small></td>
            </tr>
        </tbody>
    </table>


    <div class="pr-title"><h3>目录权限检测</h3></div>
    <div style="padding:2px 8px 0px; line-height:33px; height:23px; overflow:hidden; color:#666;">
        系统要求必须满足下列所有的目录权限全部可读写的需求才能使用，其它应用目录可安装后在管理后台检测。
    </div>
    <table width="726" border="0" align="center" cellpadding="0" cellspacing="0" class="twbox">
        <tbody>
            <tr>
                <th width="300" align="center"><strong>目录名</strong></th>
                <th width="212"><strong>读取权限</strong></th>
                <th width="212"><strong>写入权限</strong></th>
            </tr>
            <tr>
                <td>/</td>
                <td><font color="green">[√]读</font></td><td><font color="green">[√]写</font></td>
            </tr>

            <tr>
                <td>/UploadFiles/*</td>
                <td><font color="green">[√]读</font></td><td><font color="green">[√]写</font></td>
            </tr>
        </tbody>
    </table>

	-->
    <div class="btn-box"> 
        <input name="提交" type="submit" class="btnclick1" onclick="window.location.href='index.php?step=3';" value="继续">
    </div>
</div>
</form>
<?php
function step2(){
?>
<form id="form1" name="form1" method="post" action="install.php">
<div class="pright">
    <div class="pr-title"><h3>数据库设定 第二步</h3></div>
    <table width="726" border="0" align="center" cellpadding="0" cellspacing="0" class="twbox">
        <tbody>
            <tr>
                <td class="onetd"><strong>提示：</strong></td>
                <td> <div class="mytipwrap">创建数据库成功。(如果不恢复数据库将退出) &nbsp;<a href="../index.php" class="mytip" target="_blank">访问网站首页</a><a href="../admin/index.php" class="mytip" target="_blank">登录网站后台</a> </div> </td>
            </tr> 
            <tr>
                <td class="onetd"><strong>表前缀：</strong></td>
                <td>
                  <div style="float:left;margin-right:3px;"><input name="db_PREFIX" id="db_PREFIX" type="text" value="xy_" class="input-txt">
                  </div>
                </td>
            </tr>
            <tr>
                <td class="onetd"><strong>登录账号：</strong></td>
                <td>
                  <div style="float:left;margin-right:3px;"><input name="loginname"   type="text" value="admin" class="input-txt">
                  </div>
                </td>
            </tr>
            <tr>
                <td class="onetd"><strong>登录密码：</strong></td>
                <td>
                  <div style="float:left;margin-right:3px;"><input name="loginpwd"  type="text" value="admin" class="input-txt">
                  </div>
                </td>
            </tr>
      </tbody>
    </table>
    <div class="btn-box"> 
        <input name="提交" type="submit" class="btnclick1"  value="下一步创建表">
    </div>
</div>
<?PHP
}
?>


</body>
</html>