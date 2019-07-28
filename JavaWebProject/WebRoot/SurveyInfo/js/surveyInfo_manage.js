var surveyInfo_manage_tool = null; 
$(function () { 
	initSurveyInfoManageTool(); //建立SurveyInfo管理对象
	surveyInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#surveyInfo_manage").datagrid({
		url : 'SurveyInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "paperId",
		sortOrder : "desc",
		toolbar : "#surveyInfo_manage_tool",
		columns : [[
			{
				field : "questionPaperName",
				title : "问卷名称",
				width : 140,
			},
			{
				field : "faqiren",
				title : "发起人",
				width : 140,
			},
			{
				field : "startDate",
				title : "发起日期",
				width : 140,
			},
			{
				field : "endDate",
				title : "结束日期",
				width : 140,
			},
			{
				field : "zhutitupian",
				title : "主题图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "publishFlag",
				title : "审核标志",
				width : 70,
			},
		]],
	});

	$("#surveyInfoEditDiv").dialog({
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
				if ($("#surveyInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#surveyInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#surveyInfoEditForm").form({
						    url:"SurveyInfo/" + $("#surveyInfo_paperId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#surveyInfoEditDiv").dialog("close");
			                        surveyInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#surveyInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#surveyInfoEditDiv").dialog("close");
				$("#surveyInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initSurveyInfoManageTool() {
	surveyInfo_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#surveyInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#surveyInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#surveyInfo_manage").datagrid("options").queryParams;
			queryParams["questionPaperName"] = $("#questionPaperName").val();
			queryParams["faqiren"] = $("#faqiren").val();
			queryParams["startDate"] = $("#startDate").datebox("getValue"); 
			queryParams["endDate"] = $("#endDate").datebox("getValue"); 
			$("#surveyInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#surveyInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#surveyInfoQueryForm").form({
			    url:"SurveyInfo/OutToExcel",
			});
			//提交表单
			$("#surveyInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#surveyInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var paperIds = [];
						for (var i = 0; i < rows.length; i ++) {
							paperIds.push(rows[i].paperId);
						}
						$.ajax({
							type : "POST",
							url : "SurveyInfo/deletes",
							data : {
								paperIds : paperIds.join(","),
							},
							beforeSend : function () {
								$("#surveyInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#surveyInfo_manage").datagrid("loaded");
									$("#surveyInfo_manage").datagrid("load");
									$("#surveyInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#surveyInfo_manage").datagrid("loaded");
									$("#surveyInfo_manage").datagrid("load");
									$("#surveyInfo_manage").datagrid("unselectAll");
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
			var rows = $("#surveyInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SurveyInfo/" + rows[0].paperId +  "/update",
					type : "get",
					data : {
						//paperId : rows[0].paperId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (surveyInfo, response, status) {
						$.messager.progress("close");
						if (surveyInfo) { 
							$("#surveyInfoEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
