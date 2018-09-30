package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Message;


public interface MessageMapper {
	public List<Message> mInBoxListAll(String userid);
	public int mInBoxInsert(Message message);
	public int mInBoxDelete(int messagenum);
	public Message mInBoxSelectOne(int messagenum);
	
	public List<Message> mOutBoxListAll();
	public int mOutBoxInsert(Message message);
	public int mOutBoxDelete(int messagenum);
	public Message mOutBoxSelectOne(int messagenum);
	
	public int mUpdate(Message message);
	
	public int getInboxRecordCount(Map<String, String> userIdAndSearchWord);
	public int getOutboxRecordCount(Map<String, String> userIdAndSearchWord);
	
	public List<Message> Inbox_select_result(Map<String,String> map, RowBounds rb);
	public List<Message> Outbox_select_result(Map<String,String> map, RowBounds rb);
	
}