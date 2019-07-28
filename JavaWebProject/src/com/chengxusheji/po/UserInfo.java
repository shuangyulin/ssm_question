package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class UserInfo {
    /*用户名*/
    @NotEmpty(message="用户名不能为空")
    private String userInfoname;
    public String getUserInfoname(){
        return userInfoname;
    }
    public void setUserInfoname(String userInfoname){
        this.userInfoname = userInfoname;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthday;
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /*联系电话*/
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*邮箱地址*/
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    /*用户住址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*个人照片*/
    private String userPhoto;
    public String getUserPhoto() {
        return userPhoto;
    }
    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonUserInfo=new JSONObject(); 
		jsonUserInfo.accumulate("userInfoname", this.getUserInfoname());
		jsonUserInfo.accumulate("password", this.getPassword());
		jsonUserInfo.accumulate("name", this.getName());
		jsonUserInfo.accumulate("sex", this.getSex());
		jsonUserInfo.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonUserInfo.accumulate("telephone", this.getTelephone());
		jsonUserInfo.accumulate("email", this.getEmail());
		jsonUserInfo.accumulate("address", this.getAddress());
		jsonUserInfo.accumulate("userPhoto", this.getUserPhoto());
		return jsonUserInfo;
    }}