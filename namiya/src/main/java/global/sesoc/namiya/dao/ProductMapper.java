package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Product;


public interface ProductMapper {

	public int insertPdt(Product product);

	public Product selectOne();
	
}