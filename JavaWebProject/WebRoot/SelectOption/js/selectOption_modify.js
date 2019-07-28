$(function () {
	$.ajax({
		url : "SelectOption/" + $("#selectOption_optionId_edit").val() + "/update",
		type : "get",
		data : {
			//optionId : $("#selectOption_optionId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (selectOption, response, status) {
			$.messager.progress("close");
			if (selectOption) { 
				$("#selectOption_optionId_edit").val(selectOption.optionId);
				$("#selectOption_optionId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#selectOption_questionObj_titileId_edit").combobox({
					url:"QuestionInfo/listAll",
					valueField:"titileId",
					textField:"titleValue",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#selectOption_questionObj_titileId_edit").combobox("select", selectOption.questionObjPri);
						//var data = $("#selectOption_questionObj_titileId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#selectOption_questionObj_titileId_edit").combobox("select", data[0].titileId);
						//}
					}
				});
				$("#selectOption_optionContent_edit").val(selectOption.optionContent);
				$("#selectOption_optionContent_edit").validatebox({
					required : true,
					missingMessage : "请输入选项内容",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#selectOptionModifyButton").click(function(){ 
		if ($("#selectOptionEditForm").form("validate")) {
			$("#selectOptionEditForm").form({
			    url:"SelectOption/" +  $("#selectOption_optionId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#selectOptionEditForm").form("validate"))  {
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
			$("#selectOptionEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
