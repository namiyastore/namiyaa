package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Message;


public interface HistoryMapper {
	public List<History> hListAll(Map<String, String> map, RowBounds rb);
	public int hInsert(History history);
	public int hDelete(int hitorynum);
	public History hSelectOne(int historynum);
	public int hUpdate(History history);
	public History selectHst(int productnum);
	public List<History> selecthListAll();
	public int getHistoryRecordCount(String searchWord);
}