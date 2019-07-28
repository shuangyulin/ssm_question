package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Answer {
    /*记录编号*/
    private Integer answerId;
    public Integer getAnswerId(){
        return answerId;
    }
    public void setAnswerId(Integer answerId){
        this.answerId = answerId;
    }

    /*选项信息*/
    private SelectOption selectOptionObj;
    public SelectOption getSelectOptionObj() {
        return selectOptionObj;
    }
    public void setSelectOptionObj(SelectOption selectOptionObj) {
        this.selectOptionObj = selectOptionObj;
    }

    /*用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonAnswer=new JSONObject(); 
		jsonAnswer.accumulate("answerId", this.getAnswerId());
		jsonAnswer.accumulate("selectOptionObj", this.getSelectOptionObj().getOptionContent());
		jsonAnswer.accumulate("selectOptionObjPri", this.getSelectOptionObj().getOptionId());
		jsonAnswer.accumulate("userObj", this.getUserObj().getName());
		jsonAnswer.accumulate("userObjPri", this.getUserObj().getUserInfoname());
		return jsonAnswer;
    }}