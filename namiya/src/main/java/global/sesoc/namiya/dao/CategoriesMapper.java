package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;

public interface CategoriesMapper {
	public List<Categories> selectClist();
	public List<Categories> selectMlist(int categorynum);
	public List<Categories> selectSlist(int categorynum);
}