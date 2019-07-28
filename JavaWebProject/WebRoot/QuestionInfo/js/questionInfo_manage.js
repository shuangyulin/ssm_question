var questionInfo_manage_tool = null; 
$(function () { 
	initQuestionInfoManageTool(); //建立QuestionInfo管理对象
	questionInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#questionInfo_manage").datagrid({
		url : 'QuestionInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "titileId",
		sortOrder : "desc",
		toolbar : "#questionInfo_manage_tool",
		columns : [[
			{
				field : "titileId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "questionPaperObj",
				title : "问卷名称",
				width : 140,
			},
			{
				field : "titleValue",
				title : "问题内容",
				width : 140,
			},
		]],
	});

	$("#questionInfoEditDiv").dialog({
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
				if ($("#questionInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#questionInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#questionInfoEditForm").form({
						    url:"QuestionInfo/" + $("#questionInfo_titileId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#questionInfoEditDiv").dialog("close");
			                        questionInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#questionInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#questionInfoEditDiv").dialog("close");
				$("#questionInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initQuestionInfoManageTool() {
	questionInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "SurveyInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#questionPaperObj_paperId_query").combobox({ 
					    valueField:"paperId",
					    textField:"questionPaperName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{paperId:0,questionPaperName:"不限制"});
					$("#questionPaperObj_paperId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#questionInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#questionInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#questionInfo_manage").datagrid("options").queryParams;
			queryParams["questionPaperObj.paperId"] = $("#questionPaperObj_paperId_query").combobox("getValue");
			queryParams["titleValue"] = $("#titleValue").val();
			$("#questionInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#questionInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#questionInfoQueryForm").form({
			    url:"QuestionInfo/OutToExcel",
			});
			//提交表单
			$("#questionInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#questionInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var titileIds = [];
						for (var i = 0; i < rows.length; i ++) {
							titileIds.push(rows[i].titileId);
						}
						$.ajax({
							type : "POST",
							url : "QuestionInfo/deletes",
							data : {
								titileIds : titileIds.join(","),
							},
							beforeSend : function () {
								$("#questionInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#questionInfo_manage").datagrid("loaded");
									$("#questionInfo_manage").datagrid("load");
									$("#questionInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#questionInfo_manage").datagrid("loaded");
									$("#questionInfo_manage").datagrid("load");
									$("#questionInfo_manage").datagrid("unselectAll");
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
			var rows = $("#questionInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "QuestionInfo/" + rows[0].titileId +  "/update",
					type : "get",
					data : {
						//titileId : rows[0].titileId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (questionInfo, response, status) {
						$.messager.progress("close");
						if (questionInfo) { 
							$("#questionInfoEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
