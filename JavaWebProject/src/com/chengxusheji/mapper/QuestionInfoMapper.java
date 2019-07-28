package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.QuestionInfo;

public interface QuestionInfoMapper {
	/*添加问题信息信息*/
	public void addQuestionInfo(QuestionInfo questionInfo) throws Exception;

	/*按照查询条件分页查询问题信息记录*/
	public ArrayList<QuestionInfo> queryQuestionInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有问题信息记录*/
	public ArrayList<QuestionInfo> queryQuestionInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的问题信息记录数*/
	public int queryQuestionInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条问题信息记录*/
	public QuestionInfo getQuestionInfo(int titileId) throws Exception;

	/*更新问题信息记录*/
	public void updateQuestionInfo(QuestionInfo questionInfo) throws Exception;

	/*删除问题信息记录*/
	public void deleteQuestionInfo(int titileId) throws Exception;

}
