<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/surveyInfo.css" /> 

<div id="surveyInfo_manage"></div>
<div id="surveyInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="surveyInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="surveyInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="surveyInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="surveyInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="surveyInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="surveyInfoQueryForm" method="post">
			问卷名称：<input type="text" class="textbox" id="questionPaperName" name="questionPaperName" style="width:110px" />
			发起人：<input type="text" class="textbox" id="faqiren" name="faqiren" style="width:110px" />
			发起日期：<input type="text" id="startDate" name="startDate" class="easyui-datebox" editable="false" style="width:100px">
			结束日期：<input type="text" id="endDate" name="endDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="surveyInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="surveyInfoEditDiv">
	<form id="surveyInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="surveyInfo_paperId_edit" name="surveyInfo.paperId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="SurveyInfo/js/surveyInfo_manage.js"></script> 
