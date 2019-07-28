$(function () {
	$.ajax({
		url : "Answer/" + $("#answer_answerId_edit").val() + "/update",
		type : "get",
		data : {
			//answerId : $("#answer_answerId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (answer, response, status) {
			$.messager.progress("close");
			if (answer) { 
				$("#answer_answerId_edit").val(answer.answerId);
				$("#answer_answerId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#answer_selectOptionObj_optionId_edit").combobox({
					url:"SelectOption/listAll",
					valueField:"optionId",
					textField:"optionContent",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#answer_selectOptionObj_optionId_edit").combobox("select", answer.selectOptionObjPri);
						//var data = $("#answer_selectOptionObj_optionId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#answer_selectOptionObj_optionId_edit").combobox("select", data[0].optionId);
						//}
					}
				});
				$("#answer_userObj_userInfoname_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"userInfoname",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#answer_userObj_userInfoname_edit").combobox("select", answer.userObjPri);
						//var data = $("#answer_userObj_userInfoname_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#answer_userObj_userInfoname_edit").combobox("select", data[0].userInfoname);
						//}
					}
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#answerModifyButton").click(function(){ 
		if ($("#answerEditForm").form("validate")) {
			$("#answerEditForm").form({
			    url:"Answer/" +  $("#answer_answerId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#answerEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#answerEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
