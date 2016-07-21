var thisLableName = ''; //当前标签名称

$(function() {
		$("#didlist").append("<option value=''>选择大类列表</option>");
		var splstr, splxx;
		splstr = getConfig().split("==========================");
		splxx = splstr[0].split("\n");
		var c = '';
		for (var i = 0; i < splxx.length; i++) {
			var s = splxx[i].replace("\t", "    ");
			if (s.substr(0, 1) != "#") {
				if (s.substr(0, 1) != " " && $.trim(s) != '') {
					c += s + '\n<br>';
					//追加选择大类
					$("#didlist").append("<option value='" + s + "'>" + s + "</option>");

				}
			}
		}
		//$("#navwrap").html(c);

		//选择大类改变
		$('#didlist').change(function() {
				displaySidList($(this).children('option:selected').val());
			})
			//选择小类改变
		$('#sidlist').change(function() {
			var sid = $(this).children('option:selected').html();
			var sidValue = $(this).children('option:selected').val();
			thisLableName = sid; //记录当前标签名称
			//处理字符里标签关闭
			sidValue = handleLable(sidValue);

			sidValue = sidValue.substr(sidValue.indexOf("(") + 1); 
			if (sidValue.indexOf("\)") != -1) {
				sidValue = sidValue.substr(0, sidValue.indexOf("\)"));
			}
			sidValue = $.trim(sidValue);
			
			var helpStr = "<br>动作名称："+getStrCut(getConfig(), sid+"(", ")",2)  +"<br><br>"
			displayLayoutframe(sidValue,helpStr); 
			
			
		})

	})
//显示输入框架
function displayLayoutframe(content,helpStr) {
	var splstr, splxx, s, c = '';
	var inputName, inputValue, inputType, selStr, findStr,lableTitle;
	splstr = content.split("|");
	for (var i = 0; i < splstr.length; i++) {
		s = splstr[i];
		if (s != '') {
			s += "--";
			splxx = s.split("-");
			inputName = splxx[0];
			inputValue = splxx[1];
			inputType = splxx[2];
			selStr = '';
			//指定内容
			if (inputValue != '') {
				findStr = getStrCut(getConfig(), inputValue + " start\n", inputValue + " end\n");
				if (findStr != '') {
					inputValue = findStr;
				}
			}
			//标签名称
			lableTitle= getStrCut(getConfig(), inputName + "(", ")");
			if(lableTitle==''){
				lableTitle=inputName;
			}
			//为单选项
			if ("|autoadd||autoadddid|autoaddsid|autoaddtid|testspan|inmodule|".indexOf('|' + inputName + '|') != -1) {
				inputType = "checkbox";
				//为多行
			} else if ("|content|default|".indexOf('|' + inputName + '|') != -1) {
				inputType = "textboxline";
			}

			//处理字符里标签打开
			inputValue = handleLable(inputValue, "on");
			//单选
			if (inputType == "checkbox") {
				if (inputValue == '1') {
					selStr = ' checked';
				}
				c += '<div style="margin:10px 0 0 0"><label for="' + inputName + '"><input type="checkbox" name="' + inputName + '" id="' + inputName + '" ' + selStr + ' onclick="createLableStr()" class="inputstyle">' + lableTitle + '</label></div>';
				//多行
			} else if (inputType == "textboxline") {
				c += '<div style="margin:10px 0 0 0">' + lableTitle + '<textarea name="' + inputName + '" style="width:80%" rows="6" id="' + inputName + '"  onchange="createLableStr()" class="inputstyle">' + inputValue + '</textarea></div>';
				//单行
			} else {
				c += '<div style="margin:10px 0 0 0">' + lableTitle + '<input type="text" style="width:80%" name="' + inputName + '" id="' + inputName + '" value="' + inputValue + '"  onchange="createLableStr()" class="inputstyle" /></div>';
			}
		}
	} 
	$("#bodywrap").html(helpStr+c);
	createLableStr()		//生成标签

}

//显示小类列表
function displaySidList(did) {
	var splstr, splxx, thisDid;
	//清空选择小类
	$("#sidlist").empty();
	$("#sidlist").append("<option value=''>选择小类列表</option>");
	splstr = getConfig().split("==========================");
	splxx = splstr[0].split("\n");
	for (var i = 0; i < splxx.length; i++) {
		var s = splxx[i].replace("\t", "    ");
		if (s.substr(0, 1) != "#") {
			if (s.substr(0, 1) != " " && $.trim(s) != '') {
				thisDid = s;
			} else if (s.substr(0, 4) == "    " && did == thisDid) {
				var sid = $.trim(s);
				sid = sid.substr(0, sid.indexOf(" "));
				//追加选择大类
				$("#sidlist").append("<option value='" + s + "'>" + sid + "</option>");
			}
		}
	}
}
//标签处理
function handleLable(sidValue, sType) {
	if (sType == "on") {
		sidValue = sidValue.replace(/\[#1#\]/g, "\\\|");
		sidValue = sidValue.replace(/\[#2#\]/g, "\\\-");
		sidValue = sidValue.replace(/\[#3#\]/g, "\\\(");
		sidValue = sidValue.replace(/\[#4#\]/g, "\\\)");
	} else {
		sidValue = sidValue.replace(/\\\|/g, "[#1#]");
		sidValue = sidValue.replace(/\\-/g, "[#2#]");
		sidValue = sidValue.replace(/\\\(/g, "[#3#]");
		sidValue = sidValue.replace(/\\\)/g, "[#4#]");
	}
	return sidValue;
}



//生成代码
function createLableStr() {
	var c = "{$" + thisLableName + " "
	var a = document.control
	var infoStr = "" //信息内容
	var labelStartStr = "" //标签开始字符
	var labelEndStr = "" //标签结束字符
	var isModuleYes = false; //内部模块

	for (var i = 0; i < a.length; i++) {
		if (a[i].type == "text") {
			if (a[i].value != '') {
				var value = a[i].value.replace(/'/g, "\\'");
				c = c + a[i].name + '=\'' + value + '\' '
			}
		} else if (a[i].type == "checkbox") {
			if (a[i].checked == true) {
				if (a[i].name == "testspan") {
					labelStartStr = '<sPAn class="testspan">'
					labelEndStr = "</sPAn>"
				} else if (a[i].name == "inmodule") {
					isModuleYes = true;
				} else {
					c = c + a[i].name + '=\'true\' '
				}
			}
		} else if (a[i].type == "textarea") {
			var value = a[i].value.replace(/'/g, "\\'");
			if (value.indexOf("\n") != -1) {
				var TemplateID = format_Time("", 12)
				infoStr += "<!--#test start#-->\n<!--#" + TemplateID + " start#-->\n\n<!--#" + TemplateID + " end#-->\n<!--#test end#-->\n"
				infoStr += "\n\n第二种方法：\n<!--#" + TemplateID + a[i].value + "#-->"
				value = TemplateID


			}
			if(value!=''){
				c = c + a[i].name + '=\'' + value + '\' ';
			}
		}
	}
	c += "$}";
	if (isModuleYes == true) {
		//c = Replace(Replace(Replace(c, "{$", "{\$"), "$}", "$\}"), "'", "\'") 
		c = c.replace(/\{\$/g, "\{\\\$");
		c = c.replace(/\$\}/g, "\$\\\}");
		c = c.replace(/\'/g, "\\\'");
	}
	
	//20160629	
	var sid = $("#sidlist").children('option:selected').html();			
	var helpStr = "<!--#"+getStrCut(getConfig(), sid+"(", ")",2)  +"#-->\n"
	 
	//内容模块
	document.all.txtEchoInfo.value = helpStr + labelStartStr + c + labelEndStr + "\n\n" + infoStr
	
	//显示帮助信息
	var sid = $.trim(document.all.sidlist.value);
	sid=sid.substr(0, sid.indexOf(" "));	
	var s=getStrCut(getConfig(),"[#显示"+sid+"帮助信息#] start","[#显示"+sid+"帮助信息#] end",2);
	if(s==""){
		s=getStrCut(getConfig(),"[#显示默认帮助信息#] start","[#显示默认帮助信息#] end",2);
	}
	document.all.txtHelpInfo.value=s;

}
//格式化时间
function format_Time(timeStr, nType) {
	var timeObj = new Date()
		//2015-10-28 13:19:18 不行  Tue Jul 16 01:07:00 CST 2013才行
		//var timeObj = new Date(timeStr)
	var Y = timeObj.getFullYear().toString()
	var M = (timeObj.getMonth() + 1).toString()
	if (M.length == 1) {
		M = "0" + M
	}
	var D = timeObj.getDate().toString()
	if (D.length == 1) {
		D = "0" + D
	}
	var H = timeObj.getHours().toString()
	if (H.length == 1) {
		H = "0" + H
	}
	var Mi = timeObj.getMinutes().toString()
	if (Mi.length == 1) {
		Mi = "0" + Mi
	}
	var S = timeObj.getSeconds().toString()
	if (S.length == 1) {
		S = "0" + S
	}
	switch (nType) {
		case 1:
			return Y + "-" + M + "-" + D + " " + H + ":" + Mi + ":" + S
		case 2:
			return Y + "-" + M + "-" + D
		case 3:
			return H + ":" + Mi + ":" + S
		case 4:
			return Y + "年" + M + "月" + D + "日"
		case 5:
			return Y + M + D
		case 6:
			return Y + M + D + H + Mi + S
		case 7:
			return Y + "-" + M
		case 8:
			return Y + "年" + M + "月" + D + "日" + " " + H + ":" + Mi + ":" + S
		case 9:
			return Y + "年" + M + "月" + D + "日" + " " + H + "时" + Mi + "分" + S + "秒"
		case 10:
			return Y + "年" + M + "月" + D + "日" + H + "时"
		case 12:
			return Y + "年" + M + "月" + D + "日" + " " + H + "时" + Mi + "分"
		case 14:
			return Y + "/" + M + "/" + D
	}
}
/*alert(getStrCut("{$aabb$}", "{$", "$}", 0));
alert(getStrCut("{$aabb$}", "{$", "$}", 1));
alert(getStrCut("{$aabb$}", "{$", "$}", 3));
alert(getStrCut("{$aabb$}", "{$", "$}", 4));
*/
//截取内容201600316
function getStrCut(content, startStr, endStr, cutType) {
	var s = '';
	cutType = cutType + '';
	if (content.indexOf(startStr) != -1 && content.indexOf(endStr) != -1) {
		s = content.substr(content.indexOf(startStr) + startStr.length);
		s = s.substr(0, s.indexOf(endStr));
	}
	if (cutType == '1') {
		s = startStr + s + endStr;
	} else if (cutType == '3') {
		s = startStr + s;
	} else if (cutType == '4') {
		s = s + endStr;
	}
	return s;
}