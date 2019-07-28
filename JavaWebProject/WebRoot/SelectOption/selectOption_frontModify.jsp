<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SelectOption" %>
<%@ page import="com.chengxusheji.po.QuestionInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的questionObj信息
    List<QuestionInfo> questionInfoList = (List<QuestionInfo>)request.getAttribute("questionInfoList");
    SelectOption selectOption = (SelectOption)request.getAttribute("selectOption");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改选项信息信息</TITLE>
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
  		<li class="active">选项信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="selectOptionEditForm" id="selectOptionEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="selectOption_optionId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="selectOption_optionId_edit" name="selectOption.optionId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="selectOption_questionObj_titileId_edit" class="col-md-3 text-right">问题信息:</label>
		  	 <div class="col-md-9">
			    <select id="selectOption_questionObj_titileId_edit" name="selectOption.questionObj.titileId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="selectOption_optionContent_edit" class="col-md-3 text-right">选项内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="selectOption_optionContent_edit" name="selectOption.optionContent" class="form-control" placeholder="请输入选项内容">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSelectOptionModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#selectOptionEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改选项信息界面并初始化数据*/
function selectOptionEdit(optionId) {
	$.ajax({
		url :  basePath + "SelectOption/" + optionId + "/update",
		type : "get",
		dataType: "json",
		success : function (selectOption, response, status) {
			if (selectOption) {
				$("#selectOption_optionId_edit").val(selectOption.optionId);
				$.ajax({
					url: basePath + "QuestionInfo/listAll",
					type: "get",
					success: function(questionInfos,response,status) { 
						$("#selectOption_questionObj_titileId_edit").empty();
						var html="";
		        		$(questionInfos).each(function(i,questionInfo){
		        			html += "<option value='" + questionInfo.titileId + "'>" + questionInfo.titleValue + "</option>";
		        		});
		        		$("#selectOption_questionObj_titileId_edit").html(html);
		        		$("#selectOption_questionObj_titileId_edit").val(selectOption.questionObjPri);
					}
				});
				$("#selectOption_optionContent_edit").val(selectOption.optionContent);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交选项信息信息表单给服务器端修改*/
function ajaxSelectOptionModify() {
	$.ajax({
		url :  basePath + "SelectOption/" + $("#selectOption_optionId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#selectOptionEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#selectOptionQueryForm").submit();
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
    selectOptionEdit("<%=request.getParameter("optionId")%>");
 })
 </script> 
</body>
</html>

