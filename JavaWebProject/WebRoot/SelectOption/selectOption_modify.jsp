<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/selectOption.css" />
<div id="selectOption_editDiv">
	<form id="selectOptionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="selectOption_optionId_edit" name="selectOption.optionId" value="<%=request.getParameter("optionId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="selectOptionModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SelectOption/js/selectOption_modify.js"></script> 
