package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.SurveyInfo;
import com.chengxusheji.po.QuestionInfo;

import com.chengxusheji.mapper.QuestionInfoMapper;
@Service
public class QuestionInfoService {

	@Resource QuestionInfoMapper questionInfoMapper;
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

    /*添加问题信息记录*/
    public void addQuestionInfo(QuestionInfo questionInfo) throws Exception {
    	questionInfoMapper.addQuestionInfo(questionInfo);
    }

    /*按照查询条件分页查询问题信息记录*/
    public ArrayList<QuestionInfo> queryQuestionInfo(SurveyInfo questionPaperObj,String titleValue,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != questionPaperObj && questionPaperObj.getPaperId()!= null && questionPaperObj.getPaperId()!= 0)  where += " and t_questionInfo.questionPaperObj=" + questionPaperObj.getPaperId();
    	if(!titleValue.equals("")) where = where + " and t_questionInfo.titleValue like '%" + titleValue + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return questionInfoMapper.queryQuestionInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<QuestionInfo> queryQuestionInfo(SurveyInfo questionPaperObj,String titleValue) throws Exception  { 
     	String where = "where 1=1";
    	if(null != questionPaperObj && questionPaperObj.getPaperId()!= null && questionPaperObj.getPaperId()!= 0)  where += " and t_questionInfo.questionPaperObj=" + questionPaperObj.getPaperId();
    	if(!titleValue.equals("")) where = where + " and t_questionInfo.titleValue like '%" + titleValue + "%'";
    	return questionInfoMapper.queryQuestionInfoList(where);
    }

    /*查询所有问题信息记录*/
    public ArrayList<QuestionInfo> queryAllQuestionInfo()  throws Exception {
        return questionInfoMapper.queryQuestionInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(SurveyInfo questionPaperObj,String titleValue) throws Exception {
     	String where = "where 1=1";
    	if(null != questionPaperObj && questionPaperObj.getPaperId()!= null && questionPaperObj.getPaperId()!= 0)  where += " and t_questionInfo.questionPaperObj=" + questionPaperObj.getPaperId();
    	if(!titleValue.equals("")) where = where + " and t_questionInfo.titleValue like '%" + titleValue + "%'";
        recordNumber = questionInfoMapper.queryQuestionInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取问题信息记录*/
    public QuestionInfo getQuestionInfo(int titileId) throws Exception  {
        QuestionInfo questionInfo = questionInfoMapper.getQuestionInfo(titileId);
        return questionInfo;
    }

    /*更新问题信息记录*/
    public void updateQuestionInfo(QuestionInfo questionInfo) throws Exception {
        questionInfoMapper.updateQuestionInfo(questionInfo);
    }

    /*删除一条问题信息记录*/
    public void deleteQuestionInfo (int titileId) throws Exception {
        questionInfoMapper.deleteQuestionInfo(titileId);
    }

    /*删除多条问题信息信息*/
    public int deleteQuestionInfos (String titileIds) throws Exception {
    	String _titileIds[] = titileIds.split(",");
    	for(String _titileId: _titileIds) {
    		questionInfoMapper.deleteQuestionInfo(Integer.parseInt(_titileId));
    	}
    	return _titileIds.length;
    }
}
