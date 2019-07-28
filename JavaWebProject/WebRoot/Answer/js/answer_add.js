$(function () {
	$("#answer_selectOptionObj_optionId").combobox({
	    url:'SelectOption/listAll',
	    valueField: "optionId",
	    textField: "optionContent",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#answer_selectOptionObj_optionId").combobox("getData"); 
            if (data.length > 0) {
                $("#answer_selectOptionObj_optionId").combobox("select", data[0].optionId);
            }
        }
	});
	$("#answer_userObj_userInfoname").combobox({
	    url:'UserInfo/listAll',
	    valueField: "userInfoname",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#answer_userObj_userInfoname").combobox("getData"); 
            if (data.length > 0) {
                $("#answer_userObj_userInfoname").combobox("select", data[0].userInfoname);
            }
        }
	});
	//单击添加按钮
	$("#answerAddButton").click(function () {
		//验证表单 
		if(!$("#answerAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#answerAddForm").form({
			    url:"Answer/add",
			    onSubmit: function(){
					if($("#answerAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#answerAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#answerAddForm").submit();
		}
	});

	//单击清空按钮
	$("#answerClearButton").click(function () { 
		$("#answerAddForm").form("clear"); 
	});
});
