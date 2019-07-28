package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.SurveyInfoService;
import com.chengxusheji.po.SurveyInfo;

//SurveyInfo管理控制层
@Controller
@RequestMapping("/SurveyInfo")
public class SurveyInfoController extends BaseController {

    /*业务层对象*/
    @Resource SurveyInfoService surveyInfoService;

	@InitBinder("surveyInfo")
	public void initBinderSurveyInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("surveyInfo.");
	}
	/*跳转到添加SurveyInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new SurveyInfo());
		return "SurveyInfo_add";
	}

	/*客户端ajax方式提交添加问卷信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated SurveyInfo surveyInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			surveyInfo.setZhutitupian(this.handlePhotoUpload(request, "zhutitupianFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        surveyInfoService.addSurveyInfo(surveyInfo);
        message = "问卷信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询问卷信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String questionPaperName,String faqiren,String startDate,String endDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (questionPaperName == null) questionPaperName = "";
		if (faqiren == null) faqiren = "";
		if (startDate == null) startDate = "";
		if (endDate == null) endDate = "";
		if(rows != 0)surveyInfoService.setRows(rows);
		List<SurveyInfo> surveyInfoList = surveyInfoService.querySurveyInfo(questionPaperName, faqiren, startDate, endDate, page);
	    /*计算总的页数和总的记录数*/
	    surveyInfoService.queryTotalPageAndRecordNumber(questionPaperName, faqiren, startDate, endDate);
	    /*获取到总的页码数目*/
	    int totalPage = surveyInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = surveyInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(SurveyInfo surveyInfo:surveyInfoList) {
			JSONObject jsonSurveyInfo = surveyInfo.getJsonObject();
			jsonArray.put(jsonSurveyInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询问卷信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<SurveyInfo> surveyInfoList = surveyInfoService.queryAllSurveyInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(SurveyInfo surveyInfo:surveyInfoList) {
			JSONObject jsonSurveyInfo = new JSONObject();
			jsonSurveyInfo.accumulate("paperId", surveyInfo.getPaperId());
			jsonSurveyInfo.accumulate("questionPaperName", surveyInfo.getQuestionPaperName());
			jsonArray.put(jsonSurveyInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询问卷信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String questionPaperName,String faqiren,String startDate,String endDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (questionPaperName == null) questionPaperName = "";
		if (faqiren == null) faqiren = "";
		if (startDate == null) startDate = "";
		if (endDate == null) endDate = "";
		List<SurveyInfo> surveyInfoList = surveyInfoService.querySurveyInfo(questionPaperName, faqiren, startDate, endDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    surveyInfoService.queryTotalPageAndRecordNumber(questionPaperName, faqiren, startDate, endDate);
	    /*获取到总的页码数目*/
	    int totalPage = surveyInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = surveyInfoService.getRecordNumber();
	    request.setAttribute("surveyInfoList",  surveyInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("questionPaperName", questionPaperName);
	    request.setAttribute("faqiren", faqiren);
	    request.setAttribute("startDate", startDate);
	    request.setAttribute("endDate", endDate);
		return "SurveyInfo/surveyInfo_frontquery_result"; 
	}

     /*前台查询SurveyInfo信息*/
	@RequestMapping(value="/{paperId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer paperId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键paperId获取SurveyInfo对象*/
        SurveyInfo surveyInfo = surveyInfoService.getSurveyInfo(paperId);

        request.setAttribute("surveyInfo",  surveyInfo);
        return "SurveyInfo/surveyInfo_frontshow";
	}

	/*ajax方式显示问卷信息修改jsp视图页*/
	@RequestMapping(value="/{paperId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer paperId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键paperId获取SurveyInfo对象*/
        SurveyInfo surveyInfo = surveyInfoService.getSurveyInfo(paperId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSurveyInfo = surveyInfo.getJsonObject();
		out.println(jsonSurveyInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新问卷信息信息*/
	@RequestMapping(value = "/{paperId}/update", method = RequestMethod.POST)
	public void update(@Validated SurveyInfo surveyInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String zhutitupianFileName = this.handlePhotoUpload(request, "zhutitupianFile");
		if(!zhutitupianFileName.equals("upload/NoImage.jpg"))surveyInfo.setZhutitupian(zhutitupianFileName); 


		try {
			surveyInfoService.updateSurveyInfo(surveyInfo);
			message = "问卷信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "问卷信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除问卷信息信息*/
	@RequestMapping(value="/{paperId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer paperId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  surveyInfoService.deleteSurveyInfo(paperId);
	            request.setAttribute("message", "问卷信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "问卷信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条问卷信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String paperIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = surveyInfoService.deleteSurveyInfos(paperIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出问卷信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String questionPaperName,String faqiren,String startDate,String endDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(questionPaperName == null) questionPaperName = "";
        if(faqiren == null) faqiren = "";
        if(startDate == null) startDate = "";
        if(endDate == null) endDate = "";
        List<SurveyInfo> surveyInfoList = surveyInfoService.querySurveyInfo(questionPaperName,faqiren,startDate,endDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "SurveyInfo信息记录"; 
        String[] headers = { "问卷名称","发起人","发起日期","结束日期","主题图片","审核标志"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<surveyInfoList.size();i++) {
        	SurveyInfo surveyInfo = surveyInfoList.get(i); 
        	dataset.add(new String[]{surveyInfo.getQuestionPaperName(),surveyInfo.getFaqiren(),surveyInfo.getStartDate(),surveyInfo.getEndDate(),surveyInfo.getZhutitupian(),surveyInfo.getPublishFlag() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"SurveyInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
