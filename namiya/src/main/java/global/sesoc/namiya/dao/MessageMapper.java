package global.sesoc.namiya.dao;

import java.util.List;

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
	
}