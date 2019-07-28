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
import com.chengxusheji.service.SelectOptionService;
import com.chengxusheji.po.SelectOption;
import com.chengxusheji.service.QuestionInfoService;
import com.chengxusheji.po.QuestionInfo;

//SelectOption管理控制层
@Controller
@RequestMapping("/SelectOption")
public class SelectOptionController extends BaseController {

    /*业务层对象*/
    @Resource SelectOptionService selectOptionService;

    @Resource QuestionInfoService questionInfoService;
	@InitBinder("questionObj")
	public void initBinderquestionObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("questionObj.");
	}
	@InitBinder("selectOption")
	public void initBinderSelectOption(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("selectOption.");
	}
	/*跳转到添加SelectOption视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new SelectOption());
		/*查询所有的QuestionInfo信息*/
		List<QuestionInfo> questionInfoList = questionInfoService.queryAllQuestionInfo();
		request.setAttribute("questionInfoList", questionInfoList);
		return "SelectOption_add";
	}

	/*客户端ajax方式提交添加选项信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated SelectOption selectOption, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        selectOptionService.addSelectOption(selectOption);
        message = "选项信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询选项信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("questionObj") QuestionInfo questionObj,String optionContent,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (optionContent == null) optionContent = "";
		if(rows != 0)selectOptionService.setRows(rows);
		List<SelectOption> selectOptionList = selectOptionService.querySelectOption(questionObj, optionContent, page);
	    /*计算总的页数和总的记录数*/
	    selectOptionService.queryTotalPageAndRecordNumber(questionObj, optionContent);
	    /*获取到总的页码数目*/
	    int totalPage = selectOptionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = selectOptionService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(SelectOption selectOption:selectOptionList) {
			JSONObject jsonSelectOption = selectOption.getJsonObject();
			jsonArray.put(jsonSelectOption);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询选项信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<SelectOption> selectOptionList = selectOptionService.queryAllSelectOption();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(SelectOption selectOption:selectOptionList) {
			JSONObject jsonSelectOption = new JSONObject();
			jsonSelectOption.accumulate("optionId", selectOption.getOptionId());
			jsonSelectOption.accumulate("optionContent", selectOption.getOptionContent());
			jsonArray.put(jsonSelectOption);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询选项信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("questionObj") QuestionInfo questionObj,String optionContent,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (optionContent == null) optionContent = "";
		List<SelectOption> selectOptionList = selectOptionService.querySelectOption(questionObj, optionContent, currentPage);
	    /*计算总的页数和总的记录数*/
	    selectOptionService.queryTotalPageAndRecordNumber(questionObj, optionContent);
	    /*获取到总的页码数目*/
	    int totalPage = selectOptionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = selectOptionService.getRecordNumber();
	    request.setAttribute("selectOptionList",  selectOptionList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("questionObj", questionObj);
	    request.setAttribute("optionContent", optionContent);
	    List<QuestionInfo> questionInfoList = questionInfoService.queryAllQuestionInfo();
	    request.setAttribute("questionInfoList", questionInfoList);
		return "SelectOption/selectOption_frontquery_result"; 
	}

     /*前台查询SelectOption信息*/
	@RequestMapping(value="/{optionId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer optionId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键optionId获取SelectOption对象*/
        SelectOption selectOption = selectOptionService.getSelectOption(optionId);

        List<QuestionInfo> questionInfoList = questionInfoService.queryAllQuestionInfo();
        request.setAttribute("questionInfoList", questionInfoList);
        request.setAttribute("selectOption",  selectOption);
        return "SelectOption/selectOption_frontshow";
	}

	/*ajax方式显示选项信息修改jsp视图页*/
	@RequestMapping(value="/{optionId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer optionId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键optionId获取SelectOption对象*/
        SelectOption selectOption = selectOptionService.getSelectOption(optionId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSelectOption = selectOption.getJsonObject();
		out.println(jsonSelectOption.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新选项信息信息*/
	@RequestMapping(value = "/{optionId}/update", method = RequestMethod.POST)
	public void update(@Validated SelectOption selectOption, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			selectOptionService.updateSelectOption(selectOption);
			message = "选项信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "选项信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除选项信息信息*/
	@RequestMapping(value="/{optionId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer optionId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  selectOptionService.deleteSelectOption(optionId);
	            request.setAttribute("message", "选项信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "选项信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条选项信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String optionIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = selectOptionService.deleteSelectOptions(optionIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出选项信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("questionObj") QuestionInfo questionObj,String optionContent, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(optionContent == null) optionContent = "";
        List<SelectOption> selectOptionList = selectOptionService.querySelectOption(questionObj,optionContent);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "SelectOption信息记录"; 
        String[] headers = { "记录编号","问题信息","选项内容"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<selectOptionList.size();i++) {
        	SelectOption selectOption = selectOptionList.get(i); 
        	dataset.add(new String[]{selectOption.getOptionId() + "",selectOption.getQuestionObj().getTitleValue(),selectOption.getOptionContent()});
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
			response.setHeader("Content-disposition","attachment; filename="+"SelectOption.xls");//filename是下载的xls的名，建议最好用英文 
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
