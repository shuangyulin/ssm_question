<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SurveyInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SurveyInfo> surveyInfoList = (List<SurveyInfo>)request.getAttribute("surveyInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String questionPaperName = (String)request.getAttribute("questionPaperName"); //问卷名称查询关键字
    String faqiren = (String)request.getAttribute("faqiren"); //发起人查询关键字
    String startDate = (String)request.getAttribute("startDate"); //发起日期查询关键字
    String endDate = (String)request.getAttribute("endDate"); //结束日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>问卷信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>SurveyInfo/frontlist">问卷信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>SurveyInfo/surveyInfo_frontAdd.jsp" style="display:none;">添加问卷信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<surveyInfoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		SurveyInfo surveyInfo = surveyInfoList.get(i); //获取到问卷信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>SurveyInfo/<%=surveyInfo.getPaperId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=surveyInfo.getZhutitupian()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		问卷名称:<%=surveyInfo.getQuestionPaperName() %>
			     	</div>
			     	<div class="field">
	            		发起人:<%=surveyInfo.getFaqiren() %>
			     	</div>
			     	<div class="field">
	            		发起日期:<%=surveyInfo.getStartDate() %>
			     	</div>
			     	<div class="field">
	            		结束日期:<%=surveyInfo.getEndDate() %>
			     	</div>
			     	<div class="field">
	            		审核标志:<%=surveyInfo.getPublishFlag() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>SurveyInfo/<%=surveyInfo.getPaperId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="surveyInfoEdit('<%=surveyInfo.getPaperId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="surveyInfoDelete('<%=surveyInfo.getPaperId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>问卷信息查询</h1>
		</div>
		<form name="surveyInfoQueryForm" id="surveyInfoQueryForm" action="<%=basePath %>SurveyInfo/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="questionPaperName">问卷名称:</label>
				<input type="text" id="questionPaperName" name="questionPaperName" value="<%=questionPaperName %>" class="form-control" placeholder="请输入问卷名称">
			</div>
			<div class="form-group">
				<label for="faqiren">发起人:</label>
				<input type="text" id="faqiren" name="faqiren" value="<%=faqiren %>" class="form-control" placeholder="请输入发起人">
			</div>
			<div class="form-group">
				<label for="startDate">发起日期:</label>
				<input type="text" id="startDate" name="startDate" class="form-control"  placeholder="请选择发起日期" value="<%=startDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="endDate">结束日期:</label>
				<input type="text" id="endDate" name="endDate" class="form-control"  placeholder="请选择结束日期" value="<%=endDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="surveyInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;问卷信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#surveyInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSurveyInfoModify();">提交</button>
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
    document.surveyInfoQueryForm.currentPage.value = currentPage;
    document.surveyInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.surveyInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.surveyInfoQueryForm.currentPage.value = pageValue;
    documentsurveyInfoQueryForm.submit();
}

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
				$('#surveyInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除问卷信息信息*/
function surveyInfoDelete(paperId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SurveyInfo/deletes",
			data : {
				paperIds : paperId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#surveyInfoQueryForm").submit();
					//location.href= basePath + "SurveyInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

