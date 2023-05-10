<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/questionInfo.css" /> 

<div id="questionInfo_manage"></div>
<div id="questionInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="questionInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="questionInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="questionInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="questionInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="questionInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="questionInfoQueryForm" method="post">
			问卷名称：<input class="textbox" type="text" id="questionPaperObj_paperId_query" name="questionPaperObj.paperId" style="width: auto"/>
			问题内容：<input type="text" class="textbox" id="titleValue" name="titleValue" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="questionInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="questionInfoEditDiv">
	<form id="questionInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="questionInfo_titileId_edit" name="questionInfo.titileId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">问卷名称:</span>
			<span class="inputControl">
				<input class="textbox"  id="questionInfo_questionPaperObj_paperId_edit" name="questionInfo.questionPaperObj.paperId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">问题内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="questionInfo_titleValue_edit" name="questionInfo.titleValue" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="QuestionInfo/js/questionInfo_manage.js"></script> 
