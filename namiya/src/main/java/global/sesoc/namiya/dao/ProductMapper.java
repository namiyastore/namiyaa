package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Product;


public interface ProductMapper {

	public int insertPdt(Product product);

	public Product selectOne();

	public HashMap<String, Object> seletPC(int productnum);

	public int updatePdt(Product product);

	public Product selectPdt(int productnum);

	public int updatePstt(Product product);

	public int updatePstt2(String date);


	
}