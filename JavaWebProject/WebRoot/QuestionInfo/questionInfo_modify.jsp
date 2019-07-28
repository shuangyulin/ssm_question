<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/questionInfo.css" />
<div id="questionInfo_editDiv">
	<form id="questionInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="questionInfo_titileId_edit" name="questionInfo.titileId" value="<%=request.getParameter("titileId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="questionInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/QuestionInfo/js/questionInfo_modify.js"></script> 
