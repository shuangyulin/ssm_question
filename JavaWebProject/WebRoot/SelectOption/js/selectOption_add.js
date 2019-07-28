$(function () {
	$("#selectOption_questionObj_titileId").combobox({
	    url:'QuestionInfo/listAll',
	    valueField: "titileId",
	    textField: "titleValue",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#selectOption_questionObj_titileId").combobox("getData"); 
            if (data.length > 0) {
                $("#selectOption_questionObj_titileId").combobox("select", data[0].titileId);
            }
        }
	});
	$("#selectOption_optionContent").validatebox({
		required : true, 
		missingMessage : '请输入选项内容',
	});

	//单击添加按钮
	$("#selectOptionAddButton").click(function () {
		//验证表单 
		if(!$("#selectOptionAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#selectOptionAddForm").form({
			    url:"SelectOption/add",
			    onSubmit: function(){
					if($("#selectOptionAddForm").form("validate"))  { 
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
                        $("#selectOptionAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#selectOptionAddForm").submit();
		}
	});

	//单击清空按钮
	$("#selectOptionClearButton").click(function () { 
		$("#selectOptionAddForm").form("clear"); 
	});
});
