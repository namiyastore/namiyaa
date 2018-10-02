package global.sesoc.namiya.dao;

import java.util.List;

import global.sesoc.namiya.vo.Keyword;


public interface KeywordMapper {
	public List<Keyword> kListAll(String userid);
	public int kInsert(Keyword keyword);
	public int kDelete(int keywordnum);
	public Keyword kSelectOne(int keywordnum);
	public int kUpdate(Keyword keyword);
	public List<Keyword> kListAllWitoutUserid();
}