package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Product;

@Repository
public class ProfileRepository {
	@Autowired
	SqlSession session;
	
		
}
