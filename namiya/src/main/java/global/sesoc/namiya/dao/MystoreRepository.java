package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Mystore;


@Repository
public class MystoreRepository {

	@Autowired
	SqlSession session;
	
	/*
	 * 전체 글 조회
	 * @return list 조회된 전체 글	
	*/
	public List<Map<String,String>> selectAll(String userid) {
		
		MystoreMapper mapper = session.getMapper(MystoreMapper.class);
		
		List<Map<String,String>> list = mapper.selectAll(userid);
		
		return list;
	}
	
public Members select(String myurl) {
		
		MystoreMapper mapper = session.getMapper(MystoreMapper.class);
		
		Members member = mapper.select(myurl);
		
		return member;
	}
	
	public int insert(Mystore store) {
		int cnt;
		MystoreMapper mapper = session.getMapper(MystoreMapper.class);
		
		cnt = mapper.insert(store);
		
		return cnt;
	}
	
	public int deleteAll(String userid) {
		int cnt;
		MystoreMapper mapper = session.getMapper(MystoreMapper.class);
		
		cnt = mapper.deleteAll(userid);
		
		return cnt;
		
	}
	
	// 전체 글갯수를 얻어온다
		public int getItemCount(String searchItem, String searchWord, String userid) {
			MystoreMapper mapper = session.getMapper(MystoreMapper.class);
			
			Map<String,String> map = new HashMap<String,String>();
			
			map.put("searchItem", searchItem);
			map.put("searchWord", searchWord);
			// userid 세션에서 받기
			map.put("userid", userid);
			
			int itemCount =  mapper.getTotalItem(map);
			
			return itemCount;
		}
		
		public List<Map<String,Object>> selectUserItem(String searchItem, String searchWord, int startRecord, int countPerPage, String userid) {
			// RowBound는 start레코드와 end레코드를 전달받게 되어있다.
			// 
			RowBounds rb = new RowBounds(startRecord,countPerPage);
			
			MystoreMapper mapper = session.getMapper(MystoreMapper.class);
			Map<String,String> map = new HashMap<String,String>();
			
			map.put("searchItem", searchItem);
			map.put("searchWord", searchWord);
			map.put("userid", userid);
			
			
			List<Map<String,Object>>  list = mapper.selectUserItem(map,rb);
			System.out.println("repuserid: "+userid);
			return list;
		}
		
		public int MinimiSetting(String userid) {
			int cnt;
			MystoreMapper mapper = session.getMapper(MystoreMapper.class);
			
			cnt = mapper.insertMinimi(userid);
			cnt = mapper.insertbackground(userid);
			
			return cnt;
		}
	
		
}
