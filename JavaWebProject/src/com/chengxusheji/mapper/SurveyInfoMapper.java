package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SurveyInfo;

public interface SurveyInfoMapper {
	/*添加问卷信息信息*/
	public void addSurveyInfo(SurveyInfo surveyInfo) throws Exception;

	/*按照查询条件分页查询问卷信息记录*/
	public ArrayList<SurveyInfo> querySurveyInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有问卷信息记录*/
	public ArrayList<SurveyInfo> querySurveyInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的问卷信息记录数*/
	public int querySurveyInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条问卷信息记录*/
	public SurveyInfo getSurveyInfo(int paperId) throws Exception;

	/*更新问卷信息记录*/
	public void updateSurveyInfo(SurveyInfo surveyInfo) throws Exception;

	/*删除问卷信息记录*/
	public void deleteSurveyInfo(int paperId) throws Exception;

}
