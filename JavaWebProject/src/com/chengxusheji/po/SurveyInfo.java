package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SurveyInfo {
    /*记录编号*/
    private Integer paperId;
    public Integer getPaperId(){
        return paperId;
    }
    public void setPaperId(Integer paperId){
        this.paperId = paperId;
    }

    /*问卷名称*/
    @NotEmpty(message="问卷名称不能为空")
    private String questionPaperName;
    public String getQuestionPaperName() {
        return questionPaperName;
    }
    public void setQuestionPaperName(String questionPaperName) {
        this.questionPaperName = questionPaperName;
    }

    /*发起人*/
    private String faqiren;
    public String getFaqiren() {
        return faqiren;
    }
    public void setFaqiren(String faqiren) {
        this.faqiren = faqiren;
    }

    /*问卷描述*/
    private String description;
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    /*发起日期*/
    @NotEmpty(message="发起日期不能为空")
    private String startDate;
    public String getStartDate() {
        return startDate;
    }
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    /*结束日期*/
    @NotEmpty(message="结束日期不能为空")
    private String endDate;
    public String getEndDate() {
        return endDate;
    }
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    /*主题图片*/
    private String zhutitupian;
    public String getZhutitupian() {
        return zhutitupian;
    }
    public void setZhutitupian(String zhutitupian) {
        this.zhutitupian = zhutitupian;
    }

    /*审核标志*/
    @NotNull(message="必须输入审核标志")
    private Integer publishFlag;
    public Integer getPublishFlag() {
        return publishFlag;
    }
    public void setPublishFlag(Integer publishFlag) {
        this.publishFlag = publishFlag;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSurveyInfo=new JSONObject(); 
		jsonSurveyInfo.accumulate("paperId", this.getPaperId());
		jsonSurveyInfo.accumulate("questionPaperName", this.getQuestionPaperName());
		jsonSurveyInfo.accumulate("faqiren", this.getFaqiren());
		jsonSurveyInfo.accumulate("description", this.getDescription());
		jsonSurveyInfo.accumulate("startDate", this.getStartDate().length()>19?this.getStartDate().substring(0,19):this.getStartDate());
		jsonSurveyInfo.accumulate("endDate", this.getEndDate().length()>19?this.getEndDate().substring(0,19):this.getEndDate());
		jsonSurveyInfo.accumulate("zhutitupian", this.getZhutitupian());
		jsonSurveyInfo.accumulate("publishFlag", this.getPublishFlag());
		return jsonSurveyInfo;
    }}