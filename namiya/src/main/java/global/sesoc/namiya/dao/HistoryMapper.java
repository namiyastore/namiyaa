package global.sesoc.namiya.dao;

import java.util.List;

import global.sesoc.namiya.vo.History;


public interface HistoryMapper {
	public List<History> hListAll();
	public int hInsert(History history);
	public int hDelete(int hitorynum);
	public History hSelectOne(int historynum);
	public int hUpdate(History history);
}