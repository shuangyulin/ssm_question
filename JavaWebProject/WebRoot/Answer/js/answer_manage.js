var answer_manage_tool = null; 
$(function () { 
	initAnswerManageTool(); //建立Answer管理对象
	answer_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#answer_manage").datagrid({
		url : 'Answer/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "answerId",
		sortOrder : "desc",
		toolbar : "#answer_manage_tool",
		columns : [[
			{
				field : "answerId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "selectOptionObj",
				title : "选项信息",
				width : 140,
			},
			{
				field : "userObj",
				title : "用户",
				width : 140,
			},
		]],
	});

	$("#answerEditDiv").dialog({
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
				if ($("#answerEditForm").form("validate")) {
					//验证表单 
					if(!$("#answerEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#answerEditForm").form({
						    url:"Answer/" + $("#answer_answerId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#answerEditDiv").dialog("close");
			                        answer_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#answerEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#answerEditDiv").dialog("close");
				$("#answerEditForm").form("reset"); 
			},
		}],
	});
});

function initAnswerManageTool() {
	answer_manage_tool = {
		init: function() {
			$.ajax({
				url : "SelectOption/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#selectOptionObj_optionId_query").combobox({ 
					    valueField:"optionId",
					    textField:"optionContent",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{optionId:0,optionContent:"不限制"});
					$("#selectOptionObj_optionId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_userInfoname_query").combobox({ 
					    valueField:"userInfoname",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{userInfoname:"",name:"不限制"});
					$("#userObj_userInfoname_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#answer_manage").datagrid("reload");
		},
		redo : function () {
			$("#answer_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#answer_manage").datagrid("options").queryParams;
			queryParams["selectOptionObj.optionId"] = $("#selectOptionObj_optionId_query").combobox("getValue");
			queryParams["userObj.userInfoname"] = $("#userObj_userInfoname_query").combobox("getValue");
			$("#answer_manage").datagrid("options").queryParams=queryParams; 
			$("#answer_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#answerQueryForm").form({
			    url:"Answer/OutToExcel",
			});
			//提交表单
			$("#answerQueryForm").submit();
		},
		remove : function () {
			var rows = $("#answer_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var answerIds = [];
						for (var i = 0; i < rows.length; i ++) {
							answerIds.push(rows[i].answerId);
						}
						$.ajax({
							type : "POST",
							url : "Answer/deletes",
							data : {
								answerIds : answerIds.join(","),
							},
							beforeSend : function () {
								$("#answer_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#answer_manage").datagrid("loaded");
									$("#answer_manage").datagrid("load");
									$("#answer_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#answer_manage").datagrid("loaded");
									$("#answer_manage").datagrid("load");
									$("#answer_manage").datagrid("unselectAll");
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
			var rows = $("#answer_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Answer/" + rows[0].answerId +  "/update",
					type : "get",
					data : {
						//answerId : rows[0].answerId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (answer, response, status) {
						$.messager.progress("close");
						if (answer) { 
							$("#answerEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
