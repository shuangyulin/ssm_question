var selectOption_manage_tool = null; 
$(function () { 
	initSelectOptionManageTool(); //建立SelectOption管理对象
	selectOption_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#selectOption_manage").datagrid({
		url : 'SelectOption/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "optionId",
		sortOrder : "desc",
		toolbar : "#selectOption_manage_tool",
		columns : [[
			{
				field : "optionId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "questionObj",
				title : "问题信息",
				width : 140,
			},
			{
				field : "optionContent",
				title : "选项内容",
				width : 140,
			},
		]],
	});

	$("#selectOptionEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#selectOptionEditForm").form("validate")) {
					//验证表单 
					if(!$("#selectOptionEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#selectOptionEditForm").form({
						    url:"SelectOption/" + $("#selectOption_optionId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#selectOptionEditDiv").dialog("close");
			                        selectOption_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#selectOptionEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#selectOptionEditDiv").dialog("close");
				$("#selectOptionEditForm").form("reset"); 
			},
		}],
	});
});

function initSelectOptionManageTool() {
	selectOption_manage_tool = {
		init: function() {
			$.ajax({
				url : "QuestionInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#questionObj_titileId_query").combobox({ 
					    valueField:"titileId",
					    textField:"titleValue",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{titileId:0,titleValue:"不限制"});
					$("#questionObj_titileId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#selectOption_manage").datagrid("reload");
		},
		redo : function () {
			$("#selectOption_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#selectOption_manage").datagrid("options").queryParams;
			queryParams["questionObj.titileId"] = $("#questionObj_titileId_query").combobox("getValue");
			queryParams["optionContent"] = $("#optionContent").val();
			$("#selectOption_manage").datagrid("options").queryParams=queryParams; 
			$("#selectOption_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#selectOptionQueryForm").form({
			    url:"SelectOption/OutToExcel",
			});
			//提交表单
			$("#selectOptionQueryForm").submit();
		},
		remove : function () {
			var rows = $("#selectOption_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var optionIds = [];
						for (var i = 0; i < rows.length; i ++) {
							optionIds.push(rows[i].optionId);
						}
						$.ajax({
							type : "POST",
							url : "SelectOption/deletes",
							data : {
								optionIds : optionIds.join(","),
							},
							beforeSend : function () {
								$("#selectOption_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#selectOption_manage").datagrid("loaded");
									$("#selectOption_manage").datagrid("load");
									$("#selectOption_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#selectOption_manage").datagrid("loaded");
									$("#selectOption_manage").datagrid("load");
									$("#selectOption_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#selectOption_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SelectOption/" + rows[0].optionId +  "/update",
					type : "get",
					data : {
						//optionId : rows[0].optionId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (selectOption, response, status) {
						$.messager.progress("close");
						if (selectOption) { 
							$("#selectOptionEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
