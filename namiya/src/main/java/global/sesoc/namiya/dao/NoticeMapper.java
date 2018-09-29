package global.sesoc.namiya.dao;

import java.util.List;

import global.sesoc.namiya.vo.Notice;


public interface NoticeMapper {
	public List<Notice> nListAll(String userid);
	public int nInsert(Notice notice);
	public int nDelete(int noticenum);
	public Notice nSelectOne(int noticenum);
	public int nUpdate(Notice notice);
	
}