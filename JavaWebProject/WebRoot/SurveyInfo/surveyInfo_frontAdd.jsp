<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>问卷信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>SurveyInfo/frontlist">问卷信息管理</a></li>
  			<li class="active">添加问卷信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="surveyInfoAddForm" id="surveyInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="surveyInfo_questionPaperName" class="col-md-2 text-right">问卷名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="surveyInfo_questionPaperName" name="surveyInfo.questionPaperName" class="form-control" placeholder="请输入问卷名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="surveyInfo_faqiren" class="col-md-2 text-right">发起人:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="surveyInfo_faqiren" name="surveyInfo.faqiren" class="form-control" placeholder="请输入发起人">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="surveyInfo_description" class="col-md-2 text-right">问卷描述:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="surveyInfo_description" name="surveyInfo.description" class="form-control" placeholder="请输入问卷描述">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="surveyInfo_startDateDiv" class="col-md-2 text-right">发起日期:</label>
				  	 <div class="col-md-8">
		                <div id="surveyInfo_startDateDiv" class="input-group date surveyInfo_startDate col-md-12" data-link-field="surveyInfo_startDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="surveyInfo_startDate" name="surveyInfo.startDate" size="16" type="text" value="" placeholder="请选择发起日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="surveyInfo_endDateDiv" class="col-md-2 text-right">结束日期:</label>
				  	 <div class="col-md-8">
		                <div id="surveyInfo_endDateDiv" class="input-group date surveyInfo_endDate col-md-12" data-link-field="surveyInfo_endDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="surveyInfo_endDate" name="surveyInfo.endDate" size="16" type="text" value="" placeholder="请选择结束日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="surveyInfo_zhutitupian" class="col-md-2 text-right">主题图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="surveyInfo_zhutitupianImg" border="0px"/><br/>
					    <input type="hidden" id="surveyInfo_zhutitupian" name="surveyInfo.zhutitupian"/>
					    <input id="zhutitupianFile" name="zhutitupianFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="surveyInfo_publishFlag" class="col-md-2 text-right">审核标志:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="surveyInfo_publishFlag" name="surveyInfo.publishFlag" class="form-control" placeholder="请输入审核标志">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxSurveyInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#surveyInfoAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加问卷信息信息
	function ajaxSurveyInfoAdd() { 
		//提交之前先验证表单
		$("#surveyInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#surveyInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "SurveyInfo/add",
			dataType : "json" , 
			data: new FormData($("#surveyInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#surveyInfoAddForm").find("input").val("");
					$("#surveyInfoAddForm").find("textarea").val("");
				} else {
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
	//验证问卷信息添加表单字段
	$('#surveyInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"surveyInfo.questionPaperName": {
				validators: {
					notEmpty: {
						message: "问卷名称不能为空",
					}
				}
			},
			"surveyInfo.startDate": {
				validators: {
					notEmpty: {
						message: "发起日期不能为空",
					}
				}
			},
			"surveyInfo.endDate": {
				validators: {
					notEmpty: {
						message: "结束日期不能为空",
					}
				}
			},
			"surveyInfo.publishFlag": {
				validators: {
					notEmpty: {
						message: "审核标志不能为空",
					},
					integer: {
						message: "审核标志不正确"
					}
				}
			},
		}
	}); 
	//发起日期组件
	$('#surveyInfo_startDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#surveyInfoAddForm').data('bootstrapValidator').updateStatus('surveyInfo.startDate', 'NOT_VALIDATED',null).validateField('surveyInfo.startDate');
	});
	//结束日期组件
	$('#surveyInfo_endDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#surveyInfoAddForm').data('bootstrapValidator').updateStatus('surveyInfo.endDate', 'NOT_VALIDATED',null).validateField('surveyInfo.endDate');
	});
})
</script>
</body>
</html>
