$(function () {
	$("#surveyInfo_questionPaperName").validatebox({
		required : true, 
		missingMessage : '请输入问卷名称',
	});

	$("#surveyInfo_startDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#surveyInfo_endDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#surveyInfo_publishFlag").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入审核标志',
		invalidMessage : '审核标志输入不对',
	});

	//单击添加按钮
	$("#surveyInfoAddButton").click(function () {
		//验证表单 
		if(!$("#surveyInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#surveyInfoAddForm").form({
			    url:"SurveyInfo/add",
			    onSubmit: function(){
					if($("#surveyInfoAddForm").form("validate"))  { 
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
                        $("#surveyInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#surveyInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#surveyInfoClearButton").click(function () { 
		$("#surveyInfoAddForm").form("clear"); 
	});
});
