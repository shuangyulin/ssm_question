<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/surveyInfo.css" />
<div id="surveyInfo_editDiv">
	<form id="surveyInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_paperId_edit" name="surveyInfo.paperId" value="<%=request.getParameter("paperId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">问卷名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_questionPaperName_edit" name="surveyInfo.questionPaperName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发起人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_faqiren_edit" name="surveyInfo.faqiren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">问卷描述:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_description_edit" name="surveyInfo.description" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发起日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_startDate_edit" name="surveyInfo.startDate" />

			</span>

		</div>
		<div>
			<span class="label">结束日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_endDate_edit" name="surveyInfo.endDate" />

			</span>

		</div>
		<div>
			<span class="label">主题图片:</span>
			<span class="inputControl">
				<img id="surveyInfo_zhutitupianImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="surveyInfo_zhutitupian" name="surveyInfo.zhutitupian"/>
				<input id="zhutitupianFile" name="zhutitupianFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">审核标志:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_publishFlag_edit" name="surveyInfo.publishFlag" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="surveyInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SurveyInfo/js/surveyInfo_modify.js"></script> 
