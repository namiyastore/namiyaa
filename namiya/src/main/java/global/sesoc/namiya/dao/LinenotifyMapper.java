package global.sesoc.namiya.dao;

import global.sesoc.namiya.vo.Linenotify;

public interface LinenotifyMapper {

	public int insertNotifyToken(Linenotify linenotify);

	public Linenotify selectOne(String userid);
	
}
