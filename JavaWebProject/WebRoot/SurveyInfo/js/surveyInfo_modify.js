$(function () {
	$.ajax({
		url : "SurveyInfo/" + $("#surveyInfo_paperId_edit").val() + "/update",
		type : "get",
		data : {
			//paperId : $("#surveyInfo_paperId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (surveyInfo, response, status) {
			$.messager.progress("close");
			if (surveyInfo) { 
				$("#surveyInfo_paperId_edit").val(surveyInfo.paperId);
				$("#surveyInfo_paperId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#surveyInfo_questionPaperName_edit").val(surveyInfo.questionPaperName);
				$("#surveyInfo_questionPaperName_edit").validatebox({
					required : true,
					missingMessage : "请输入问卷名称",
				});
				$("#surveyInfo_faqiren_edit").val(surveyInfo.faqiren);
				$("#surveyInfo_description_edit").val(surveyInfo.description);
				$("#surveyInfo_startDate_edit").datebox({
					value: surveyInfo.startDate,
					required: true,
					showSeconds: true,
				});
				$("#surveyInfo_endDate_edit").datebox({
					value: surveyInfo.endDate,
					required: true,
					showSeconds: true,
				});
				$("#surveyInfo_zhutitupian").val(surveyInfo.zhutitupian);
				$("#surveyInfo_zhutitupianImg").attr("src", surveyInfo.zhutitupian);
				$("#surveyInfo_publishFlag_edit").val(surveyInfo.publishFlag);
				$("#surveyInfo_publishFlag_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入审核标志",
					invalidMessage : "审核标志输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#surveyInfoModifyButton").click(function(){ 
		if ($("#surveyInfoEditForm").form("validate")) {
			$("#surveyInfoEditForm").form({
			    url:"SurveyInfo/" +  $("#surveyInfo_paperId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#surveyInfoEditForm").form("validate"))  {
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
			$("#surveyInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
