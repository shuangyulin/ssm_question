<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SurveyInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SurveyInfo surveyInfo = (SurveyInfo)request.getAttribute("surveyInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改问卷信息信息</TITLE>
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
  		<li class="active">问卷信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="surveyInfoEditForm" id="surveyInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="surveyInfo_paperId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="surveyInfo_paperId_edit" name="surveyInfo.paperId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="surveyInfo_questionPaperName_edit" class="col-md-3 text-right">问卷名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="surveyInfo_questionPaperName_edit" name="surveyInfo.questionPaperName" class="form-control" placeholder="请输入问卷名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="surveyInfo_faqiren_edit" class="col-md-3 text-right">发起人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="surveyInfo_faqiren_edit" name="surveyInfo.faqiren" class="form-control" placeholder="请输入发起人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="surveyInfo_description_edit" class="col-md-3 text-right">问卷描述:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="surveyInfo_description_edit" name="surveyInfo.description" class="form-control" placeholder="请输入问卷描述">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="surveyInfo_startDate_edit" class="col-md-3 text-right">发起日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date surveyInfo_startDate_edit col-md-12" data-link-field="surveyInfo_startDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="surveyInfo_startDate_edit" name="surveyInfo.startDate" size="16" type="text" value="" placeholder="请选择发起日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="surveyInfo_endDate_edit" class="col-md-3 text-right">结束日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date surveyInfo_endDate_edit col-md-12" data-link-field="surveyInfo_endDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="surveyInfo_endDate_edit" name="surveyInfo.endDate" size="16" type="text" value="" placeholder="请选择结束日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="surveyInfo_zhutitupian_edit" class="col-md-3 text-right">主题图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="surveyInfo_zhutitupianImg" border="0px"/><br/>
			    <input type="hidden" id="surveyInfo_zhutitupian" name="surveyInfo.zhutitupian"/>
			    <input id="zhutitupianFile" name="zhutitupianFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="surveyInfo_publishFlag_edit" class="col-md-3 text-right">审核标志:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="surveyInfo_publishFlag_edit" name="surveyInfo.publishFlag" class="form-control" placeholder="请输入审核标志">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSurveyInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#surveyInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改问卷信息界面并初始化数据*/
function surveyInfoEdit(paperId) {
	$.ajax({
		url :  basePath + "SurveyInfo/" + paperId + "/update",
		type : "get",
		dataType: "json",
		success : function (surveyInfo, response, status) {
			if (surveyInfo) {
				$("#surveyInfo_paperId_edit").val(surveyInfo.paperId);
				$("#surveyInfo_questionPaperName_edit").val(surveyInfo.questionPaperName);
				$("#surveyInfo_faqiren_edit").val(surveyInfo.faqiren);
				$("#surveyInfo_description_edit").val(surveyInfo.description);
				$("#surveyInfo_startDate_edit").val(surveyInfo.startDate);
				$("#surveyInfo_endDate_edit").val(surveyInfo.endDate);
				$("#surveyInfo_zhutitupian").val(surveyInfo.zhutitupian);
				$("#surveyInfo_zhutitupianImg").attr("src", basePath +　surveyInfo.zhutitupian);
				$("#surveyInfo_publishFlag_edit").val(surveyInfo.publishFlag);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交问卷信息信息表单给服务器端修改*/
function ajaxSurveyInfoModify() {
	$.ajax({
		url :  basePath + "SurveyInfo/" + $("#surveyInfo_paperId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#surveyInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#surveyInfoQueryForm").submit();
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
    /*发起日期组件*/
    $('.surveyInfo_startDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*结束日期组件*/
    $('.surveyInfo_endDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    surveyInfoEdit("<%=request.getParameter("paperId")%>");
 })
 </script> 
</body>
</html>

