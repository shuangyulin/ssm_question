<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/answer.css" />
<div id="answerAddDiv">
	<form id="answerAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">选项信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="answer_selectOptionObj_optionId" name="answer.selectOptionObj.optionId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="answer_userObj_userInfoname" name="answer.userObj.userInfoname" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="answerAddButton" class="easyui-linkbutton">添加</a>
			<a id="answerClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Answer/js/answer_add.js"></script> 
