$(function () {
	$.ajax({
		url : "QuestionInfo/" + $("#questionInfo_titileId_edit").val() + "/update",
		type : "get",
		data : {
			//titileId : $("#questionInfo_titileId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (questionInfo, response, status) {
			$.messager.progress("close");
			if (questionInfo) { 
				$("#questionInfo_titileId_edit").val(questionInfo.titileId);
				$("#questionInfo_titileId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#questionInfo_questionPaperObj_paperId_edit").combobox({
					url:"SurveyInfo/listAll",
					valueField:"paperId",
					textField:"questionPaperName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#questionInfo_questionPaperObj_paperId_edit").combobox("select", questionInfo.questionPaperObjPri);
						//var data = $("#questionInfo_questionPaperObj_paperId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#questionInfo_questionPaperObj_paperId_edit").combobox("select", data[0].paperId);
						//}
					}
				});
				$("#questionInfo_titleValue_edit").val(questionInfo.titleValue);
				$("#questionInfo_titleValue_edit").validatebox({
					required : true,
					missingMessage : "请输入问题内容",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#questionInfoModifyButton").click(function(){ 
		if ($("#questionInfoEditForm").form("validate")) {
			$("#questionInfoEditForm").form({
			    url:"QuestionInfo/" +  $("#questionInfo_titileId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#questionInfoEditForm").form("validate"))  {
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
			$("#questionInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
