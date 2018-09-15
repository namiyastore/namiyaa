package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Product;

@Repository
public class ProductRepository {
	@Autowired
	SqlSession session;
	
	public int insertPdt(Product product) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.insertPdt(product);
		return result;
	}

	public Product selectOne() {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		Product product = mapper.selectOne();
		return product;
	}

	public HashMap<String, Object> seletPC(int productnum) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		HashMap<String, Object> map = mapper.seletPC(productnum);
		
		return map;
	}

	public int updatePdt(Product product) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.updatePdt(product);
		
		return result;
	}

	public Product selectPdt(int productnum) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		Product product = mapper.selectPdt(productnum);
		
		return product;
	}

	public int updatePstt(Product product) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.updatePstt(product);
		
		return result;
	}

	public int updatePstt2(String date) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.updatePstt2(date);
		
		return result;
	}

	
	
	
		
}
