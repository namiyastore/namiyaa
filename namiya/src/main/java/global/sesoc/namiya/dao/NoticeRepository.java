package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Notice;

@Repository
public class NoticeRepository implements NoticeMapper{
	@Autowired
	SqlSession session;

	public List<Notice> nListAll(String userid) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		List<Notice> nlist = mapper.nListAll(userid);
		return nlist;
	}

	public int nInsert(Notice notice) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		int result = mapper.nInsert(notice);
		return result;
	}

	public int nDelete(int noticenum) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		int result = mapper.nDelete(noticenum);
		return result;
	}

	public Notice nSelectOne(int noticenum) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		Notice notice = mapper.nSelectOne(noticenum);
		return notice;
	}

	public int nUpdate(Notice notice) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		int result = mapper.nUpdate(notice);
		return result;
	}
}
