 QC.Login({
   //btnId：插入按钮的节点id，必选
   btnId: "qqLoginBtn",
   //按钮尺寸，可用值[A_XL| A_L| A_M| A_S|  B_M| B_S| C_S]，可选，默认B_S
   //   	size: "B_S",
   //用户需要确认的scope授权项，可选，默认all
   scope: "all"
 }, function(reqData, opts) { //登录成功
   //  alert(reqData.nickname)  //昵称
   //  alert(reqData.figureurl)	//头像
   //  alert(typeof(opts))	//头像
   //	writeObj(opts)

   //console.log(数组变量);
   //根据返回数据，更换按钮显示状态方法
   var dom = document.getElementById(opts['btnId']),
     _logoutTemplate = [
       //头像
       '<span><img src="{figureurl}" class="{size_key}" id="pub_photo"/></span>',
       //昵称
       '<span id="pub_nickname">{nickname}</span>',
       //退出
       '<span><a href="javascript:QC.Login.signOut();">退出</a></span>'
     ].join("");

   dom && (dom.innerHTML = QC.String.format(_logoutTemplate, {
     nickname: QC.String.escHTML(reqData.nickname),
     figureurl: reqData.figureurl

   }));
 }, function(opts) { //注销成功
   delCookie("openid")
   alert('QQ登录 注销成功');
     $("#userlogintitle").html("会员登录")
 });


 if (QC.Login.check()) { //如果已登录
   QC.Login.getMe(function(openid, accesstoken) {
     //alert(["当前登录用户的", "openid为：" + openid, "accesstoken为：" + accesstoken].join("\n"));
 
     $("#userlogintitle").html("会员信息")
     //判断QQ就否登录
     if (getCookie("openid") ==null ) {
       //从页面收集OpenAPI必要的参数。get_user_info不需要输入参数，因此paras中没有参数
       var paras = {};
       QC.api("get_user_info", paras)
         //指定接口访问成功的接收函数，s为成功返回Response对象
         .success(function(s) {
           //成功回调，通过s.data获取OpenAPI的返回数据
           //alert("获取用户信息成功！当前用户昵称为：" + s.data.nickname);
 
           var dataStr = "openid=" + openid + "&accesstoken=" + accesstoken + "&nickname=" + escape(s.data.nickname)
           dataStr += "&qqphoto=" + escape(s.data.figureurl) + "&sex=" + escape(s.data.gender) + "&year=" + escape(s.data.year)
           $.ajax({
             type: "POST",
             url: "/qqajax.asp?act=loginuser",
             data: dataStr,
             success: function(result) {
               //alert("aa" + result);
               // document.write(result)
                setCookie("openid", openid, 86400)
                alert("登录成功2");
			    window.opener.location.reload();
				window.close();
             }
           });


         })
         //指定接口访问失败的接收函数，f为失败返回Response对象
         .error(function(f) {
           //失败回调
           alert("获取用户信息失败！");
         })
         //指定接口完成请求后的接收函数，c为完成请求返回Response对象
         .complete(function(c) {
           //完成请求回调
           //         alert("获取用户信息完成！");


         });
     }


   });
 }



 function writeObj(obj) {
   var description = "";
   for (var i in obj) {
     var property = obj[i];
     description += i + " = " + property + "<br>";
   }
   document.write(description);
 }



 //JS操作cookies方法! 
 //写cookies   Days=3000  为三秒   86400=一天
 function setCookie(name, value, Days) {
   if (Days == undefined) {
     Days = 24 * 60 * 60 * 100 * 30 //为30天
   }
   var exp = new Date();
   exp.setTime(exp.getTime() + Days);
   document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
 }
 //读取cookies 
 function getCookie(name) {
   var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
   if (arr = document.cookie.match(reg)) return unescape(arr[2]);
   else return null;
 }
 //删除cookies   javascript:alert(document.cookie ="postnum=;expires=" + (new Date(0)).toGMTString())
 function delCookie(name) {
   var exp = new Date();
   exp.setTime(exp.getTime() - 1);
   var cval = getCookie(name);
   if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
 }