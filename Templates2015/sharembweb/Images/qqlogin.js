 QC.Login({
   //btnId�����밴ť�Ľڵ�id����ѡ
   btnId: "qqLoginBtn",
   //��ť�ߴ磬����ֵ[A_XL| A_L| A_M| A_S|  B_M| B_S| C_S]����ѡ��Ĭ��B_S
   //   	size: "B_S",
   //�û���Ҫȷ�ϵ�scope��Ȩ���ѡ��Ĭ��all
   scope: "all"
 }, function(reqData, opts) { //��¼�ɹ�
   //  alert(reqData.nickname)  //�ǳ�
   //  alert(reqData.figureurl)	//ͷ��
   //  alert(typeof(opts))	//ͷ��
   //	writeObj(opts)

   //console.log(�������);
   //���ݷ������ݣ�������ť��ʾ״̬����
   var dom = document.getElementById(opts['btnId']),
     _logoutTemplate = [
       //ͷ��
       '<span><img src="{figureurl}" class="{size_key}" id="pub_photo"/></span>',
       //�ǳ�
       '<span id="pub_nickname">{nickname}</span>',
       //�˳�
       '<span><a href="javascript:QC.Login.signOut();">�˳�</a></span>'
     ].join("");

   dom && (dom.innerHTML = QC.String.format(_logoutTemplate, {
     nickname: QC.String.escHTML(reqData.nickname),
     figureurl: reqData.figureurl

   }));
 }, function(opts) { //ע���ɹ�
   delCookie("openid")
   alert('QQ��¼ ע���ɹ�');
     $("#userlogintitle").html("��Ա��¼")
 });


 if (QC.Login.check()) { //����ѵ�¼
   QC.Login.getMe(function(openid, accesstoken) {
     //alert(["��ǰ��¼�û���", "openidΪ��" + openid, "accesstokenΪ��" + accesstoken].join("\n"));
 
     $("#userlogintitle").html("��Ա��Ϣ")
     //�ж�QQ�ͷ��¼
     if (getCookie("openid") ==null ) {
       //��ҳ���ռ�OpenAPI��Ҫ�Ĳ�����get_user_info����Ҫ������������paras��û�в���
       var paras = {};
       QC.api("get_user_info", paras)
         //ָ���ӿڷ��ʳɹ��Ľ��պ�����sΪ�ɹ�����Response����
         .success(function(s) {
           //�ɹ��ص���ͨ��s.data��ȡOpenAPI�ķ�������
           //alert("��ȡ�û���Ϣ�ɹ�����ǰ�û��ǳ�Ϊ��" + s.data.nickname);
 
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
                alert("��¼�ɹ�2");
			    window.opener.location.reload();
				window.close();
             }
           });


         })
         //ָ���ӿڷ���ʧ�ܵĽ��պ�����fΪʧ�ܷ���Response����
         .error(function(f) {
           //ʧ�ܻص�
           alert("��ȡ�û���Ϣʧ�ܣ�");
         })
         //ָ���ӿ���������Ľ��պ�����cΪ������󷵻�Response����
         .complete(function(c) {
           //�������ص�
           //         alert("��ȡ�û���Ϣ��ɣ�");


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



 //JS����cookies����! 
 //дcookies   Days=3000  Ϊ����   86400=һ��
 function setCookie(name, value, Days) {
   if (Days == undefined) {
     Days = 24 * 60 * 60 * 100 * 30 //Ϊ30��
   }
   var exp = new Date();
   exp.setTime(exp.getTime() + Days);
   document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
 }
 //��ȡcookies 
 function getCookie(name) {
   var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
   if (arr = document.cookie.match(reg)) return unescape(arr[2]);
   else return null;
 }
 //ɾ��cookies   javascript:alert(document.cookie ="postnum=;expires=" + (new Date(0)).toGMTString())
 function delCookie(name) {
   var exp = new Date();
   exp.setTime(exp.getTime() - 1);
   var cval = getCookie(name);
   if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
 }