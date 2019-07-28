package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class QuestionInfo {
    /*记录编号*/
    private Integer titileId;
    public Integer getTitileId(){
        return titileId;
    }
    public void setTitileId(Integer titileId){
        this.titileId = titileId;
    }

    /*问卷名称*/
    private SurveyInfo questionPaperObj;
    public SurveyInfo getQuestionPaperObj() {
        return questionPaperObj;
    }
    public void setQuestionPaperObj(SurveyInfo questionPaperObj) {
        this.questionPaperObj = questionPaperObj;
    }

    /*问题内容*/
    @NotEmpty(message="问题内容不能为空")
    private String titleValue;
    public String getTitleValue() {
        return titleValue;
    }
    public void setTitleValue(String titleValue) {
        this.titleValue = titleValue;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonQuestionInfo=new JSONObject(); 
		jsonQuestionInfo.accumulate("titileId", this.getTitileId());
		jsonQuestionInfo.accumulate("questionPaperObj", this.getQuestionPaperObj().getQuestionPaperName());
		jsonQuestionInfo.accumulate("questionPaperObjPri", this.getQuestionPaperObj().getPaperId());
		jsonQuestionInfo.accumulate("titleValue", this.getTitleValue());
		return jsonQuestionInfo;
    }}