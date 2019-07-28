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
import com.chengxusheji.service.QuestionInfoService;
import com.chengxusheji.po.QuestionInfo;
import com.chengxusheji.service.SurveyInfoService;
import com.chengxusheji.po.SurveyInfo;

//QuestionInfo管理控制层
@Controller
@RequestMapping("/QuestionInfo")
public class QuestionInfoController extends BaseController {

    /*业务层对象*/
    @Resource QuestionInfoService questionInfoService;

    @Resource SurveyInfoService surveyInfoService;
	@InitBinder("questionPaperObj")
	public void initBinderquestionPaperObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("questionPaperObj.");
	}
	@InitBinder("questionInfo")
	public void initBinderQuestionInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("questionInfo.");
	}
	/*跳转到添加QuestionInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new QuestionInfo());
		/*查询所有的SurveyInfo信息*/
		List<SurveyInfo> surveyInfoList = surveyInfoService.queryAllSurveyInfo();
		request.setAttribute("surveyInfoList", surveyInfoList);
		return "QuestionInfo_add";
	}

	/*客户端ajax方式提交添加问题信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated QuestionInfo questionInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        questionInfoService.addQuestionInfo(questionInfo);
        message = "问题信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询问题信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("questionPaperObj") SurveyInfo questionPaperObj,String titleValue,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (titleValue == null) titleValue = "";
		if(rows != 0)questionInfoService.setRows(rows);
		List<QuestionInfo> questionInfoList = questionInfoService.queryQuestionInfo(questionPaperObj, titleValue, page);
	    /*计算总的页数和总的记录数*/
	    questionInfoService.queryTotalPageAndRecordNumber(questionPaperObj, titleValue);
	    /*获取到总的页码数目*/
	    int totalPage = questionInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = questionInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(QuestionInfo questionInfo:questionInfoList) {
			JSONObject jsonQuestionInfo = questionInfo.getJsonObject();
			jsonArray.put(jsonQuestionInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询问题信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<QuestionInfo> questionInfoList = questionInfoService.queryAllQuestionInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(QuestionInfo questionInfo:questionInfoList) {
			JSONObject jsonQuestionInfo = new JSONObject();
			jsonQuestionInfo.accumulate("titileId", questionInfo.getTitileId());
			jsonQuestionInfo.accumulate("titleValue", questionInfo.getTitleValue());
			jsonArray.put(jsonQuestionInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询问题信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("questionPaperObj") SurveyInfo questionPaperObj,String titleValue,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (titleValue == null) titleValue = "";
		List<QuestionInfo> questionInfoList = questionInfoService.queryQuestionInfo(questionPaperObj, titleValue, currentPage);
	    /*计算总的页数和总的记录数*/
	    questionInfoService.queryTotalPageAndRecordNumber(questionPaperObj, titleValue);
	    /*获取到总的页码数目*/
	    int totalPage = questionInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = questionInfoService.getRecordNumber();
	    request.setAttribute("questionInfoList",  questionInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("questionPaperObj", questionPaperObj);
	    request.setAttribute("titleValue", titleValue);
	    List<SurveyInfo> surveyInfoList = surveyInfoService.queryAllSurveyInfo();
	    request.setAttribute("surveyInfoList", surveyInfoList);
		return "QuestionInfo/questionInfo_frontquery_result"; 
	}

     /*前台查询QuestionInfo信息*/
	@RequestMapping(value="/{titileId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer titileId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键titileId获取QuestionInfo对象*/
        QuestionInfo questionInfo = questionInfoService.getQuestionInfo(titileId);

        List<SurveyInfo> surveyInfoList = surveyInfoService.queryAllSurveyInfo();
        request.setAttribute("surveyInfoList", surveyInfoList);
        request.setAttribute("questionInfo",  questionInfo);
        return "QuestionInfo/questionInfo_frontshow";
	}

	/*ajax方式显示问题信息修改jsp视图页*/
	@RequestMapping(value="/{titileId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer titileId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键titileId获取QuestionInfo对象*/
        QuestionInfo questionInfo = questionInfoService.getQuestionInfo(titileId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonQuestionInfo = questionInfo.getJsonObject();
		out.println(jsonQuestionInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新问题信息信息*/
	@RequestMapping(value = "/{titileId}/update", method = RequestMethod.POST)
	public void update(@Validated QuestionInfo questionInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			questionInfoService.updateQuestionInfo(questionInfo);
			message = "问题信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "问题信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除问题信息信息*/
	@RequestMapping(value="/{titileId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer titileId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  questionInfoService.deleteQuestionInfo(titileId);
	            request.setAttribute("message", "问题信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "问题信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条问题信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String titileIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = questionInfoService.deleteQuestionInfos(titileIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出问题信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("questionPaperObj") SurveyInfo questionPaperObj,String titleValue, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(titleValue == null) titleValue = "";
        List<QuestionInfo> questionInfoList = questionInfoService.queryQuestionInfo(questionPaperObj,titleValue);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "QuestionInfo信息记录"; 
        String[] headers = { "记录编号","问卷名称","问题内容"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<questionInfoList.size();i++) {
        	QuestionInfo questionInfo = questionInfoList.get(i); 
        	dataset.add(new String[]{questionInfo.getTitileId() + "",questionInfo.getQuestionPaperObj().getQuestionPaperName(),questionInfo.getTitleValue()});
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
			response.setHeader("Content-disposition","attachment; filename="+"QuestionInfo.xls");//filename是下载的xls的名，建议最好用英文 
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
