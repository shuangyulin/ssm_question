<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SelectOption" %>
<%@ page import="com.chengxusheji.po.QuestionInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SelectOption> selectOptionList = (List<SelectOption>)request.getAttribute("selectOptionList");
    //获取所有的questionObj信息
    List<QuestionInfo> questionInfoList = (List<QuestionInfo>)request.getAttribute("questionInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    QuestionInfo questionObj = (QuestionInfo)request.getAttribute("questionObj");
    String optionContent = (String)request.getAttribute("optionContent"); //选项内容查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>选项信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#selectOptionListPanel" aria-controls="selectOptionListPanel" role="tab" data-toggle="tab">选项信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>SelectOption/selectOption_frontAdd.jsp" style="display:none;">添加选项信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="selectOptionListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>问题信息</td><td>选项内容</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<selectOptionList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		SelectOption selectOption = selectOptionList.get(i); //获取到选项信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=selectOption.getOptionId() %></td>
 											<td><%=selectOption.getQuestionObj().getTitleValue() %></td>
 											<td><%=selectOption.getOptionContent() %></td>
 											<td>
 												<a href="<%=basePath  %>SelectOption/<%=selectOption.getOptionId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="selectOptionEdit('<%=selectOption.getOptionId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="selectOptionDelete('<%=selectOption.getOptionId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>选项信息查询</h1>
		</div>
		<form name="selectOptionQueryForm" id="selectOptionQueryForm" action="<%=basePath %>SelectOption/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="questionObj_titileId">问题信息：</label>
                <select id="questionObj_titileId" name="questionObj.titileId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(QuestionInfo questionInfoTemp:questionInfoList) {
	 					String selected = "";
 					if(questionObj!=null && questionObj.getTitileId()!=null && questionObj.getTitileId().intValue()==questionInfoTemp.getTitileId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=questionInfoTemp.getTitileId() %>" <%=selected %>><%=questionInfoTemp.getTitleValue() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="optionContent">选项内容:</label>
				<input type="text" id="optionContent" name="optionContent" value="<%=optionContent %>" class="form-control" placeholder="请输入选项内容">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="selectOptionEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;选项信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#selectOptionEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSelectOptionModify();">提交</button>
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
    document.selectOptionQueryForm.currentPage.value = currentPage;
    document.selectOptionQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.selectOptionQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.selectOptionQueryForm.currentPage.value = pageValue;
    documentselectOptionQueryForm.submit();
}

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
				$('#selectOptionEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除选项信息信息*/
function selectOptionDelete(optionId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SelectOption/deletes",
			data : {
				optionIds : optionId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#selectOptionQueryForm").submit();
					//location.href= basePath + "SelectOption/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

