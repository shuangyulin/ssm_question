$(function () {
	$("#questionInfo_questionPaperObj_paperId").combobox({
	    url:'SurveyInfo/listAll',
	    valueField: "paperId",
	    textField: "questionPaperName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#questionInfo_questionPaperObj_paperId").combobox("getData"); 
            if (data.length > 0) {
                $("#questionInfo_questionPaperObj_paperId").combobox("select", data[0].paperId);
            }
        }
	});
	$("#questionInfo_titleValue").validatebox({
		required : true, 
		missingMessage : '请输入问题内容',
	});

	//单击添加按钮
	$("#questionInfoAddButton").click(function () {
		//验证表单 
		if(!$("#questionInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#questionInfoAddForm").form({
			    url:"QuestionInfo/add",
			    onSubmit: function(){
					if($("#questionInfoAddForm").form("validate"))  { 
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
                        $("#questionInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#questionInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#questionInfoClearButton").click(function () { 
		$("#questionInfoAddForm").form("clear"); 
	});
});
