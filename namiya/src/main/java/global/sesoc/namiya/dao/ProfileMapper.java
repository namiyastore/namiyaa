package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Profile;


public interface ProfileMapper {
	
	public Profile select(String userid);
	public int update(Profile profile);
	public int insert(Profile profile);
	
}