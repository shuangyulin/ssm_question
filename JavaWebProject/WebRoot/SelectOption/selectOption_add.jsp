<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/selectOption.css" />
<div id="selectOptionAddDiv">
	<form id="selectOptionAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">问题信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="selectOption_questionObj_titileId" name="selectOption.questionObj.titileId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选项内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="selectOption_optionContent" name="selectOption.optionContent" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="selectOptionAddButton" class="easyui-linkbutton">添加</a>
			<a id="selectOptionClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SelectOption/js/selectOption_add.js"></script> 
