package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Mystore;



public interface MystoreMapper {
	public List<Map<String,String>> selectAll(String userid);
	public Members select(String myurl);
	public int insert(Mystore store);
	public int deleteAll(String userid);
	public int getTotalItem(Map<String,String> map);
	public List<Map<String,Object>> selectUserItem(Map<String,String> map, RowBounds rb);
	public int insertMinimi(String userid);
	public int insertbackground(String userid);
}