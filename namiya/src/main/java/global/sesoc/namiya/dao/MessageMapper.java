package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Message;


public interface MessageMapper {
	public List<Message> mInBoxListAll();
	public int mInBoxInsert(Message message);
	public int mInBoxDelete(int messagenum);
	public Message mInBoxSelectOne(int messagenum);
	
	public List<Message> mOutBoxListAll();
	public int mOutBoxInsert(Message message);
	public int mOutBoxDelete(int messagenum);
	public Message mOutBoxSelectOne(int messagenum);
	
	public int mUpdate(Message message);
	
	public int getInboxRecordCount(@Param("searchWord") String word);
	public int getOutboxRecordCount(@Param("searchWord") String word);
	
	public List<Message> Inbox_select_result(@Param("searchWord") String word, String userid, RowBounds rb);
	public List<Message> Outbox_select_result(@Param("searchWord") String word, RowBounds rb);
	
}