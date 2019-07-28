package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SelectOption;

public interface SelectOptionMapper {
	/*添加选项信息信息*/
	public void addSelectOption(SelectOption selectOption) throws Exception;

	/*按照查询条件分页查询选项信息记录*/
	public ArrayList<SelectOption> querySelectOption(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有选项信息记录*/
	public ArrayList<SelectOption> querySelectOptionList(@Param("where") String where) throws Exception;

	/*按照查询条件的选项信息记录数*/
	public int querySelectOptionCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条选项信息记录*/
	public SelectOption getSelectOption(int optionId) throws Exception;

	/*更新选项信息记录*/
	public void updateSelectOption(SelectOption selectOption) throws Exception;

	/*删除选项信息记录*/
	public void deleteSelectOption(int optionId) throws Exception;

}
