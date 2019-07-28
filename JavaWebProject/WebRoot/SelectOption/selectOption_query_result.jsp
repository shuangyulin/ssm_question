<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/selectOption.css" /> 

<div id="selectOption_manage"></div>
<div id="selectOption_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="selectOption_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="selectOption_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="selectOption_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="selectOption_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="selectOption_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="selectOptionQueryForm" method="post">
			问题信息：<input class="textbox" type="text" id="questionObj_titileId_query" name="questionObj.titileId" style="width: auto"/>
			选项内容：<input type="text" class="textbox" id="optionContent" name="optionContent" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="selectOption_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="selectOptionEditDiv">
	<form id="selectOptionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="selectOption_optionId_edit" name="selectOption.optionId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">问题信息:</span>
			<span class="inputControl">
				<input class="textbox"  id="selectOption_questionObj_titileId_edit" name="selectOption.questionObj.titileId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选项内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="selectOption_optionContent_edit" name="selectOption.optionContent" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="SelectOption/js/selectOption_manage.js"></script> 
