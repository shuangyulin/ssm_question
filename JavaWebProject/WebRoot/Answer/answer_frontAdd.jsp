<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SelectOption" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
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
<title>答卷信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Answer/frontlist">答卷信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#answerAdd" aria-controls="answerAdd" role="tab" data-toggle="tab">添加答卷信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="answerList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="answerAdd"> 
				      	<form class="form-horizontal" name="answerAddForm" id="answerAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="answer_selectOptionObj_optionId" class="col-md-2 text-right">选项信息:</label>
						  	 <div class="col-md-8">
							    <select id="answer_selectOptionObj_optionId" name="answer.selectOptionObj.optionId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="answer_userObj_userInfoname" class="col-md-2 text-right">用户:</label>
						  	 <div class="col-md-8">
							    <select id="answer_userObj_userInfoname" name="answer.userObj.userInfoname" class="form-control">
							    </select>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxAnswerAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#answerAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加答卷信息信息
	function ajaxAnswerAdd() { 
		//提交之前先验证表单
		$("#answerAddForm").data('bootstrapValidator').validate();
		if(!$("#answerAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Answer/add",
			dataType : "json" , 
			data: new FormData($("#answerAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#answerAddForm").find("input").val("");
					$("#answerAddForm").find("textarea").val("");
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
	//验证答卷信息添加表单字段
	$('#answerAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
		}
	}); 
	//初始化选项信息下拉框值 
	$.ajax({
		url: basePath + "SelectOption/listAll",
		type: "get",
		success: function(selectOptions,response,status) { 
			$("#answer_selectOptionObj_optionId").empty();
			var html="";
    		$(selectOptions).each(function(i,selectOption){
    			html += "<option value='" + selectOption.optionId + "'>" + selectOption.optionContent + "</option>";
    		});
    		$("#answer_selectOptionObj_optionId").html(html);
    	}
	});
	//初始化用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#answer_userObj_userInfoname").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.userInfoname + "'>" + userInfo.name + "</option>";
    		});
    		$("#answer_userObj_userInfoname").html(html);
    	}
	});
})
</script>
</body>
</html>
