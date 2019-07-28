package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.QuestionInfo;
import com.chengxusheji.po.SelectOption;

import com.chengxusheji.mapper.SelectOptionMapper;
@Service
public class SelectOptionService {

	@Resource SelectOptionMapper selectOptionMapper;
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

    /*添加选项信息记录*/
    public void addSelectOption(SelectOption selectOption) throws Exception {
    	selectOptionMapper.addSelectOption(selectOption);
    }

    /*按照查询条件分页查询选项信息记录*/
    public ArrayList<SelectOption> querySelectOption(QuestionInfo questionObj,String optionContent,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != questionObj && questionObj.getTitileId()!= null && questionObj.getTitileId()!= 0)  where += " and t_selectOption.questionObj=" + questionObj.getTitileId();
    	if(!optionContent.equals("")) where = where + " and t_selectOption.optionContent like '%" + optionContent + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return selectOptionMapper.querySelectOption(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SelectOption> querySelectOption(QuestionInfo questionObj,String optionContent) throws Exception  { 
     	String where = "where 1=1";
    	if(null != questionObj && questionObj.getTitileId()!= null && questionObj.getTitileId()!= 0)  where += " and t_selectOption.questionObj=" + questionObj.getTitileId();
    	if(!optionContent.equals("")) where = where + " and t_selectOption.optionContent like '%" + optionContent + "%'";
    	return selectOptionMapper.querySelectOptionList(where);
    }

    /*查询所有选项信息记录*/
    public ArrayList<SelectOption> queryAllSelectOption()  throws Exception {
        return selectOptionMapper.querySelectOptionList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(QuestionInfo questionObj,String optionContent) throws Exception {
     	String where = "where 1=1";
    	if(null != questionObj && questionObj.getTitileId()!= null && questionObj.getTitileId()!= 0)  where += " and t_selectOption.questionObj=" + questionObj.getTitileId();
    	if(!optionContent.equals("")) where = where + " and t_selectOption.optionContent like '%" + optionContent + "%'";
        recordNumber = selectOptionMapper.querySelectOptionCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取选项信息记录*/
    public SelectOption getSelectOption(int optionId) throws Exception  {
        SelectOption selectOption = selectOptionMapper.getSelectOption(optionId);
        return selectOption;
    }

    /*更新选项信息记录*/
    public void updateSelectOption(SelectOption selectOption) throws Exception {
        selectOptionMapper.updateSelectOption(selectOption);
    }

    /*删除一条选项信息记录*/
    public void deleteSelectOption (int optionId) throws Exception {
        selectOptionMapper.deleteSelectOption(optionId);
    }

    /*删除多条选项信息信息*/
    public int deleteSelectOptions (String optionIds) throws Exception {
    	String _optionIds[] = optionIds.split(",");
    	for(String _optionId: _optionIds) {
    		selectOptionMapper.deleteSelectOption(Integer.parseInt(_optionId));
    	}
    	return _optionIds.length;
    }
}
