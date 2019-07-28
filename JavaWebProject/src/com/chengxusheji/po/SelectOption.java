package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SelectOption {
    /*记录编号*/
    private Integer optionId;
    public Integer getOptionId(){
        return optionId;
    }
    public void setOptionId(Integer optionId){
        this.optionId = optionId;
    }

    /*问题信息*/
    private QuestionInfo questionObj;
    public QuestionInfo getQuestionObj() {
        return questionObj;
    }
    public void setQuestionObj(QuestionInfo questionObj) {
        this.questionObj = questionObj;
    }

    /*选项内容*/
    @NotEmpty(message="选项内容不能为空")
    private String optionContent;
    public String getOptionContent() {
        return optionContent;
    }
    public void setOptionContent(String optionContent) {
        this.optionContent = optionContent;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSelectOption=new JSONObject(); 
		jsonSelectOption.accumulate("optionId", this.getOptionId());
		jsonSelectOption.accumulate("questionObj", this.getQuestionObj().getTitleValue());
		jsonSelectOption.accumulate("questionObjPri", this.getQuestionObj().getTitileId());
		jsonSelectOption.accumulate("optionContent", this.getOptionContent());
		return jsonSelectOption;
    }}