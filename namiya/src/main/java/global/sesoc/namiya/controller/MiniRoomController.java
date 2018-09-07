package global.sesoc.namiya.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.namiya.dao.MystoreRepository;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Mystore;

@Controller
public class MiniRoomController {
	
	@Autowired
	MystoreRepository m_repository;
	
	// 미니룸 정보 저장
		@ResponseBody
		@RequestMapping(value="/saveMiniRoom", method=RequestMethod.POST)
		public List<Mystore> saveMiniRoom(@RequestBody List<Mystore> list , Model model, HttpSession session) {
			
			//System.out.println(list.get(0));
			String loginId = (String)session.getAttribute("loginId");
			m_repository.deleteAll(loginId);
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setUserid(loginId);
				list.get(i).setImageorder(i);
				System.out.println("list.get(i): "+list.get(i));
				m_repository.insert(list.get(i));
			}
			
			return list;
		}
		
		// 가구 반환
		@ResponseBody
		@RequestMapping(value="/reqFurniture", method=RequestMethod.GET)
		public Map<String, Object> reqFurniture(
				@RequestParam(value="currentPage",defaultValue="1") int currentPage,
				@RequestParam(value="searchItem", defaultValue="type") String searchItem,
				@RequestParam(value="searchWord", defaultValue="background") String searchWord,
				Model model) {
			
			int totalItemCount = m_repository.getItemCount(searchItem,searchWord);
			PageNavigator navi = new PageNavigator(currentPage, totalItemCount,4,4);
			List<Map<String,Object>> list = m_repository.selectUserItem(searchItem,searchWord, navi.getStartRecord(), navi.getCountPerPage());
			System.out.println("list: "+ list);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("list", list);
			map.put("totalPage", navi.getTotalRecordCount());
			map.put("navi", navi);
			
			
			//int srow = COUNT_PER_PAGE * (currentPage -1) + 1;
			//int erow = (totalPageCount == currentPage) ?  : COUNT_PER_PAGE * currentPage;
			
			return map;
		}
		
		
		@RequestMapping(value="/profileEdit", method=RequestMethod.GET)
		public String profileForm() {
			return "mystore/profileEdit";
		}
	
}
