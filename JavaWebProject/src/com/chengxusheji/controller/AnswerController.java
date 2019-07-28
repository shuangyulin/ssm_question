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
import com.chengxusheji.service.AnswerService;
import com.chengxusheji.po.Answer;
import com.chengxusheji.service.SelectOptionService;
import com.chengxusheji.po.SelectOption;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Answer管理控制层
@Controller
@RequestMapping("/Answer")
public class AnswerController extends BaseController {

    /*业务层对象*/
    @Resource AnswerService answerService;

    @Resource SelectOptionService selectOptionService;
    @Resource UserInfoService userInfoService;
	@InitBinder("selectOptionObj")
	public void initBinderselectOptionObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("selectOptionObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("answer")
	public void initBinderAnswer(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("answer.");
	}
	/*跳转到添加Answer视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Answer());
		/*查询所有的SelectOption信息*/
		List<SelectOption> selectOptionList = selectOptionService.queryAllSelectOption();
		request.setAttribute("selectOptionList", selectOptionList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Answer_add";
	}

	/*客户端ajax方式提交添加答卷信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Answer answer, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        answerService.addAnswer(answer);
        message = "答卷信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询答卷信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("selectOptionObj") SelectOption selectOptionObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)answerService.setRows(rows);
		List<Answer> answerList = answerService.queryAnswer(selectOptionObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    answerService.queryTotalPageAndRecordNumber(selectOptionObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = answerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = answerService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Answer answer:answerList) {
			JSONObject jsonAnswer = answer.getJsonObject();
			jsonArray.put(jsonAnswer);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询答卷信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Answer> answerList = answerService.queryAllAnswer();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Answer answer:answerList) {
			JSONObject jsonAnswer = new JSONObject();
			jsonAnswer.accumulate("answerId", answer.getAnswerId());
			jsonArray.put(jsonAnswer);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询答卷信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("selectOptionObj") SelectOption selectOptionObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Answer> answerList = answerService.queryAnswer(selectOptionObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    answerService.queryTotalPageAndRecordNumber(selectOptionObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = answerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = answerService.getRecordNumber();
	    request.setAttribute("answerList",  answerList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("selectOptionObj", selectOptionObj);
	    request.setAttribute("userObj", userObj);
	    List<SelectOption> selectOptionList = selectOptionService.queryAllSelectOption();
	    request.setAttribute("selectOptionList", selectOptionList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Answer/answer_frontquery_result"; 
	}

     /*前台查询Answer信息*/
	@RequestMapping(value="/{answerId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer answerId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键answerId获取Answer对象*/
        Answer answer = answerService.getAnswer(answerId);

        List<SelectOption> selectOptionList = selectOptionService.queryAllSelectOption();
        request.setAttribute("selectOptionList", selectOptionList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("answer",  answer);
        return "Answer/answer_frontshow";
	}

	/*ajax方式显示答卷信息修改jsp视图页*/
	@RequestMapping(value="/{answerId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer answerId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键answerId获取Answer对象*/
        Answer answer = answerService.getAnswer(answerId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonAnswer = answer.getJsonObject();
		out.println(jsonAnswer.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新答卷信息信息*/
	@RequestMapping(value = "/{answerId}/update", method = RequestMethod.POST)
	public void update(@Validated Answer answer, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			answerService.updateAnswer(answer);
			message = "答卷信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "答卷信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除答卷信息信息*/
	@RequestMapping(value="/{answerId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer answerId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  answerService.deleteAnswer(answerId);
	            request.setAttribute("message", "答卷信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "答卷信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条答卷信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String answerIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = answerService.deleteAnswers(answerIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出答卷信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("selectOptionObj") SelectOption selectOptionObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Answer> answerList = answerService.queryAnswer(selectOptionObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Answer信息记录"; 
        String[] headers = { "记录编号","选项信息","用户"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<answerList.size();i++) {
        	Answer answer = answerList.get(i); 
        	dataset.add(new String[]{answer.getAnswerId() + "",answer.getSelectOptionObj().getOptionContent(),answer.getUserObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Answer.xls");//filename是下载的xls的名，建议最好用英文 
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
