<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.QuestionInfo" %>
<%@ page import="com.chengxusheji.po.SurveyInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<QuestionInfo> questionInfoList = (List<QuestionInfo>)request.getAttribute("questionInfoList");
    //获取所有的questionPaperObj信息
    List<SurveyInfo> surveyInfoList = (List<SurveyInfo>)request.getAttribute("surveyInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    SurveyInfo questionPaperObj = (SurveyInfo)request.getAttribute("questionPaperObj");
    String titleValue = (String)request.getAttribute("titleValue"); //问题内容查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>问题信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#questionInfoListPanel" aria-controls="questionInfoListPanel" role="tab" data-toggle="tab">问题信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>QuestionInfo/questionInfo_frontAdd.jsp" style="display:none;">添加问题信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="questionInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>问卷名称</td><td>问题内容</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<questionInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		QuestionInfo questionInfo = questionInfoList.get(i); //获取到问题信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=questionInfo.getTitileId() %></td>
 											<td><%=questionInfo.getQuestionPaperObj().getQuestionPaperName() %></td>
 											<td><%=questionInfo.getTitleValue() %></td>
 											<td>
 												<a href="<%=basePath  %>QuestionInfo/<%=questionInfo.getTitileId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="questionInfoEdit('<%=questionInfo.getTitileId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="questionInfoDelete('<%=questionInfo.getTitileId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>问题信息查询</h1>
		</div>
		<form name="questionInfoQueryForm" id="questionInfoQueryForm" action="<%=basePath %>QuestionInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="questionPaperObj_paperId">问卷名称：</label>
                <select id="questionPaperObj_paperId" name="questionPaperObj.paperId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(SurveyInfo surveyInfoTemp:surveyInfoList) {
	 					String selected = "";
 					if(questionPaperObj!=null && questionPaperObj.getPaperId()!=null && questionPaperObj.getPaperId().intValue()==surveyInfoTemp.getPaperId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=surveyInfoTemp.getPaperId() %>" <%=selected %>><%=surveyInfoTemp.getQuestionPaperName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="titleValue">问题内容:</label>
				<input type="text" id="titleValue" name="titleValue" value="<%=titleValue %>" class="form-control" placeholder="请输入问题内容">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="questionInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;问题信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#questionInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxQuestionInfoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.questionInfoQueryForm.currentPage.value = currentPage;
    document.questionInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.questionInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.questionInfoQueryForm.currentPage.value = pageValue;
    documentquestionInfoQueryForm.submit();
}

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
				$('#questionInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除问题信息信息*/
function questionInfoDelete(titileId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "QuestionInfo/deletes",
			data : {
				titileIds : titileId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#questionInfoQueryForm").submit();
					//location.href= basePath + "QuestionInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

