package global.sesoc.namiya.dao;

import java.util.List;

import global.sesoc.namiya.vo.Keyword;
import global.sesoc.namiya.vo.Keywordchk;


public interface KeywordchkMapper {

	int selectCount(Keywordchk keywordchk);
	int insertKeywordchk(Keywordchk keywordchk);
	int deleteKeywordchk();
	
}