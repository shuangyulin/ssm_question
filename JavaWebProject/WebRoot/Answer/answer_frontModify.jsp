<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Answer" %>
<%@ page import="com.chengxusheji.po.SelectOption" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的selectOptionObj信息
    List<SelectOption> selectOptionList = (List<SelectOption>)request.getAttribute("selectOptionList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Answer answer = (Answer)request.getAttribute("answer");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改答卷信息信息</TITLE>
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
  		<li class="active">答卷信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="answerEditForm" id="answerEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="answer_answerId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="answer_answerId_edit" name="answer.answerId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="answer_selectOptionObj_optionId_edit" class="col-md-3 text-right">选项信息:</label>
		  	 <div class="col-md-9">
			    <select id="answer_selectOptionObj_optionId_edit" name="answer.selectOptionObj.optionId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="answer_userObj_userInfoname_edit" class="col-md-3 text-right">用户:</label>
		  	 <div class="col-md-9">
			    <select id="answer_userObj_userInfoname_edit" name="answer.userObj.userInfoname" class="form-control">
			    </select>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxAnswerModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#answerEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改答卷信息界面并初始化数据*/
function answerEdit(answerId) {
	$.ajax({
		url :  basePath + "Answer/" + answerId + "/update",
		type : "get",
		dataType: "json",
		success : function (answer, response, status) {
			if (answer) {
				$("#answer_answerId_edit").val(answer.answerId);
				$.ajax({
					url: basePath + "SelectOption/listAll",
					type: "get",
					success: function(selectOptions,response,status) { 
						$("#answer_selectOptionObj_optionId_edit").empty();
						var html="";
		        		$(selectOptions).each(function(i,selectOption){
		        			html += "<option value='" + selectOption.optionId + "'>" + selectOption.optionContent + "</option>";
		        		});
		        		$("#answer_selectOptionObj_optionId_edit").html(html);
		        		$("#answer_selectOptionObj_optionId_edit").val(answer.selectOptionObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#answer_userObj_userInfoname_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.userInfoname + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#answer_userObj_userInfoname_edit").html(html);
		        		$("#answer_userObj_userInfoname_edit").val(answer.userObjPri);
					}
				});
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交答卷信息信息表单给服务器端修改*/
function ajaxAnswerModify() {
	$.ajax({
		url :  basePath + "Answer/" + $("#answer_answerId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#answerEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#answerQueryForm").submit();
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
    answerEdit("<%=request.getParameter("answerId")%>");
 })
 </script> 
</body>
</html>

