<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.QuestionInfo" %>
<%@ page import="com.chengxusheji.po.SurveyInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的questionPaperObj信息
    List<SurveyInfo> surveyInfoList = (List<SurveyInfo>)request.getAttribute("surveyInfoList");
    QuestionInfo questionInfo = (QuestionInfo)request.getAttribute("questionInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改问题信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">问题信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="questionInfoEditForm" id="questionInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="questionInfo_titileId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="questionInfo_titileId_edit" name="questionInfo.titileId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="questionInfo_questionPaperObj_paperId_edit" class="col-md-3 text-right">问卷名称:</label>
		  	 <div class="col-md-9">
			    <select id="questionInfo_questionPaperObj_paperId_edit" name="questionInfo.questionPaperObj.paperId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="questionInfo_titleValue_edit" class="col-md-3 text-right">问题内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="questionInfo_titleValue_edit" name="questionInfo.titleValue" class="form-control" placeholder="请输入问题内容">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxQuestionInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#questionInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改问题信息界面并初始化数据*/
function questionInfoEdit(titileId) {
	$.ajax({
		url :  basePath + "QuestionInfo/" + titileId + "/update",
		type : "get",
		dataType: "json",
		success : function (questionInfo, response, status) {
			if (questionInfo) {
				$("#questionInfo_titileId_edit").val(questionInfo.titileId);
				$.ajax({
					url: basePath + "SurveyInfo/listAll",
					type: "get",
					success: function(surveyInfos,response,status) { 
						$("#questionInfo_questionPaperObj_paperId_edit").empty();
						var html="";
		        		$(surveyInfos).each(function(i,surveyInfo){
		        			html += "<option value='" + surveyInfo.paperId + "'>" + surveyInfo.questionPaperName + "</option>";
		        		});
		        		$("#questionInfo_questionPaperObj_paperId_edit").html(html);
		        		$("#questionInfo_questionPaperObj_paperId_edit").val(questionInfo.questionPaperObjPri);
					}
				});
				$("#questionInfo_titleValue_edit").val(questionInfo.titleValue);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交问题信息信息表单给服务器端修改*/
function ajaxQuestionInfoModify() {
	$.ajax({
		url :  basePath + "QuestionInfo/" + $("#questionInfo_titileId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#questionInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#questionInfoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    questionInfoEdit("<%=request.getParameter("titileId")%>");
 })
 </script> 
</body>
</html>

