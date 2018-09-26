package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Message;

@Repository
public class MessageRepository{
	@Autowired
	SqlSession session;

	public List<Message> mInBoxListAll() {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		List<Message> inboxList = mapper.mInBoxListAll();
		return inboxList;
	}

	public int mInBoxInsert(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.mInBoxInsert(message);
		return result;
	}

	public int mInBoxDelete(int messagenum) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.mInBoxDelete(messagenum);
		return result;
	}

	public Message mInBoxSelectOne(int messagenum) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		Message selectedInBoxMsg = mapper.mInBoxSelectOne(messagenum);
		return selectedInBoxMsg;
	}

	public List<Message> mOutBoxListAll() {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		List<Message> outBoxList = mapper.mOutBoxListAll();
		return outBoxList;
	}

	public int mOutBoxInsert(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.mOutBoxInsert(message);
		return result;
	}

	public int mOutBoxDelete(int messagenum) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.mOutBoxDelete(messagenum);
		return result;
	}

	public Message mOutBoxSelectOne(int messagenum) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		Message selectedOutBoxmsg = mapper.mOutBoxSelectOne(messagenum);
		return selectedOutBoxmsg;
	}

	public int mUpdate(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.mUpdate(message);
		return result;
	}
	
	// 전체 받은 쪽지함의 글갯수를 얻어온다
		public int getInboxRecordCount(String searchWord) {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			
//			Map<String,String> map = new HashMap<>();
//			map.put("searchWord", searchWord);
			int recordCount =  mapper.getInboxRecordCount(searchWord);
			return recordCount;
		}
		
		// 전체 보낸 쪽지함의 글갯수를 얻어온다
		public int getOutboxRecordCount(String searchWord) {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
//			Map<String,String> map = new HashMap<>();
//			map.put("searchWord", searchWord);
			int recordCount =  mapper.getOutboxRecordCount(searchWord);
			
			return recordCount;
		}
		
		//받은 쪽지함 검색결과
		public List<Message> Inbox_select_result(String searchWord,int startRecord, int countPerPage){
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			RowBounds rb = new RowBounds(startRecord,countPerPage);
			List<Message> list = mapper.Inbox_select_result(searchWord,rb);
			System.out.println("searchword? "+searchWord + "startRecord? " +startRecord+"countPerPage? "+countPerPage);
			System.out.println("받은쪽지함의 리스트0920" +  list);
			return list;
		}
		
		//보낸 쪽지함 검색결과
		public List<Message> Outbox_select_result(String searchWord,int startRecord, int countPerPage){
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			List<Message> list = mapper.Outbox_select_result(searchWord,rb);
			return list;
		}

}
