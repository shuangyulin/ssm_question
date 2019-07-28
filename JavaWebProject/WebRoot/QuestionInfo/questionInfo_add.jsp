<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/questionInfo.css" />
<div id="questionInfoAddDiv">
	<form id="questionInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">问卷名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="questionInfo_questionPaperObj_paperId" name="questionInfo.questionPaperObj.paperId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">问题内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="questionInfo_titleValue" name="questionInfo.titleValue" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="questionInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="questionInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/QuestionInfo/js/questionInfo_add.js"></script> 
