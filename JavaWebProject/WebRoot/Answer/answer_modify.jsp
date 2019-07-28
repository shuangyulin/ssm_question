<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/answer.css" />
<div id="answer_editDiv">
	<form id="answerEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="answer_answerId_edit" name="answer.answerId" value="<%=request.getParameter("answerId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">选项信息:</span>
			<span class="inputControl">
				<input class="textbox"  id="answer_selectOptionObj_optionId_edit" name="answer.selectOptionObj.optionId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="answer_userObj_userInfoname_edit" name="answer.userObj.userInfoname" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="answerModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Answer/js/answer_modify.js"></script> 
