package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.SelectOption;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Answer;

import com.chengxusheji.mapper.AnswerMapper;
@Service
public class AnswerService {

	@Resource AnswerMapper answerMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加答卷信息记录*/
    public void addAnswer(Answer answer) throws Exception {
    	answerMapper.addAnswer(answer);
    }

    /*按照查询条件分页查询答卷信息记录*/
    public ArrayList<Answer> queryAnswer(SelectOption selectOptionObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != selectOptionObj && selectOptionObj.getOptionId()!= null && selectOptionObj.getOptionId()!= 0)  where += " and t_answer.selectOptionObj=" + selectOptionObj.getOptionId();
    	if(null != userObj &&  userObj.getUserInfoname() != null  && !userObj.getUserInfoname().equals(""))  where += " and t_answer.userObj='" + userObj.getUserInfoname() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return answerMapper.queryAnswer(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Answer> queryAnswer(SelectOption selectOptionObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != selectOptionObj && selectOptionObj.getOptionId()!= null && selectOptionObj.getOptionId()!= 0)  where += " and t_answer.selectOptionObj=" + selectOptionObj.getOptionId();
    	if(null != userObj &&  userObj.getUserInfoname() != null && !userObj.getUserInfoname().equals(""))  where += " and t_answer.userObj='" + userObj.getUserInfoname() + "'";
    	return answerMapper.queryAnswerList(where);
    }

    /*查询所有答卷信息记录*/
    public ArrayList<Answer> queryAllAnswer()  throws Exception {
        return answerMapper.queryAnswerList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(SelectOption selectOptionObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != selectOptionObj && selectOptionObj.getOptionId()!= null && selectOptionObj.getOptionId()!= 0)  where += " and t_answer.selectOptionObj=" + selectOptionObj.getOptionId();
    	if(null != userObj &&  userObj.getUserInfoname() != null && !userObj.getUserInfoname().equals(""))  where += " and t_answer.userObj='" + userObj.getUserInfoname() + "'";
        recordNumber = answerMapper.queryAnswerCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取答卷信息记录*/
    public Answer getAnswer(int answerId) throws Exception  {
        Answer answer = answerMapper.getAnswer(answerId);
        return answer;
    }

    /*更新答卷信息记录*/
    public void updateAnswer(Answer answer) throws Exception {
        answerMapper.updateAnswer(answer);
    }

    /*删除一条答卷信息记录*/
    public void deleteAnswer (int answerId) throws Exception {
        answerMapper.deleteAnswer(answerId);
    }

    /*删除多条答卷信息信息*/
    public int deleteAnswers (String answerIds) throws Exception {
    	String _answerIds[] = answerIds.split(",");
    	for(String _answerId: _answerIds) {
    		answerMapper.deleteAnswer(Integer.parseInt(_answerId));
    	}
    	return _answerIds.length;
    }
}
