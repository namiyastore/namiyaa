package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Message;

@Repository
public class MessageRepository{
	@Autowired
	SqlSession session;
	
	/*public int mInBoxInsert(Message message) {
	MessageMapper mapper = session.getMapper(MessageMapper.class);
	int result = mapper.mInsert(message);
	return result;
}*/

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

}
