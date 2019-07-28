package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.SurveyInfo;

import com.chengxusheji.mapper.SurveyInfoMapper;
@Service
public class SurveyInfoService {

	@Resource SurveyInfoMapper surveyInfoMapper;
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

    /*添加问卷信息记录*/
    public void addSurveyInfo(SurveyInfo surveyInfo) throws Exception {
    	surveyInfoMapper.addSurveyInfo(surveyInfo);
    }

    /*按照查询条件分页查询问卷信息记录*/
    public ArrayList<SurveyInfo> querySurveyInfo(String questionPaperName,String faqiren,String startDate,String endDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!questionPaperName.equals("")) where = where + " and t_surveyInfo.questionPaperName like '%" + questionPaperName + "%'";
    	if(!faqiren.equals("")) where = where + " and t_surveyInfo.faqiren like '%" + faqiren + "%'";
    	if(!startDate.equals("")) where = where + " and t_surveyInfo.startDate like '%" + startDate + "%'";
    	if(!endDate.equals("")) where = where + " and t_surveyInfo.endDate like '%" + endDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return surveyInfoMapper.querySurveyInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SurveyInfo> querySurveyInfo(String questionPaperName,String faqiren,String startDate,String endDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!questionPaperName.equals("")) where = where + " and t_surveyInfo.questionPaperName like '%" + questionPaperName + "%'";
    	if(!faqiren.equals("")) where = where + " and t_surveyInfo.faqiren like '%" + faqiren + "%'";
    	if(!startDate.equals("")) where = where + " and t_surveyInfo.startDate like '%" + startDate + "%'";
    	if(!endDate.equals("")) where = where + " and t_surveyInfo.endDate like '%" + endDate + "%'";
    	return surveyInfoMapper.querySurveyInfoList(where);
    }

    /*查询所有问卷信息记录*/
    public ArrayList<SurveyInfo> queryAllSurveyInfo()  throws Exception {
        return surveyInfoMapper.querySurveyInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String questionPaperName,String faqiren,String startDate,String endDate) throws Exception {
     	String where = "where 1=1";
    	if(!questionPaperName.equals("")) where = where + " and t_surveyInfo.questionPaperName like '%" + questionPaperName + "%'";
    	if(!faqiren.equals("")) where = where + " and t_surveyInfo.faqiren like '%" + faqiren + "%'";
    	if(!startDate.equals("")) where = where + " and t_surveyInfo.startDate like '%" + startDate + "%'";
    	if(!endDate.equals("")) where = where + " and t_surveyInfo.endDate like '%" + endDate + "%'";
        recordNumber = surveyInfoMapper.querySurveyInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取问卷信息记录*/
    public SurveyInfo getSurveyInfo(int paperId) throws Exception  {
        SurveyInfo surveyInfo = surveyInfoMapper.getSurveyInfo(paperId);
        return surveyInfo;
    }

    /*更新问卷信息记录*/
    public void updateSurveyInfo(SurveyInfo surveyInfo) throws Exception {
        surveyInfoMapper.updateSurveyInfo(surveyInfo);
    }

    /*删除一条问卷信息记录*/
    public void deleteSurveyInfo (int paperId) throws Exception {
        surveyInfoMapper.deleteSurveyInfo(paperId);
    }

    /*删除多条问卷信息信息*/
    public int deleteSurveyInfos (String paperIds) throws Exception {
    	String _paperIds[] = paperIds.split(",");
    	for(String _paperId: _paperIds) {
    		surveyInfoMapper.deleteSurveyInfo(Integer.parseInt(_paperId));
    	}
    	return _paperIds.length;
    }
}
