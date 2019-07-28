<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/surveyInfo.css" />
<div id="surveyInfoAddDiv">
	<form id="surveyInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">问卷名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_questionPaperName" name="surveyInfo.questionPaperName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发起人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_faqiren" name="surveyInfo.faqiren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">问卷描述:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_description" name="surveyInfo.description" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发起日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_startDate" name="surveyInfo.startDate" />

			</span>

		</div>
		<div>
			<span class="label">结束日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_endDate" name="surveyInfo.endDate" />

			</span>

		</div>
		<div>
			<span class="label">主题图片:</span>
			<span class="inputControl">
				<input id="zhutitupianFile" name="zhutitupianFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">审核标志:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_publishFlag" name="surveyInfo.publishFlag" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="surveyInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="surveyInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SurveyInfo/js/surveyInfo_add.js"></script> 
