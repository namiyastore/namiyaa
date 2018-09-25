package global.sesoc.namiya.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.namiya.dao.FavoriteRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.MystoreRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.util.FileService;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Favorite;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Mystore;
import global.sesoc.namiya.vo.Product;
import global.sesoc.namiya.vo.Profile;

@Controller
public class MiniRoomController {
	
	
	final String uploadPath = "/home/img/profile";
	
	@Autowired
	MembersRepository mb_repository;
	
	@Autowired
	MystoreRepository m_repository;
	
	@Autowired
	ProfileRepository p_repository;
	
	
	@Autowired
	FavoriteRepository f_repository;
	
	@Autowired
	MyStoreController ms_controller;
	
	/*// myStore 띄우기 
		@RequestMapping(value="/myStore"+"/{miniurl}"+"/{func}")
		public String myStore(Model model, HttpSession session, @PathVariable("miniurl")String miniurl,@PathVariable("func")String func) {
			String userid = (String)session.getAttribute("loginId"); // 로그인유저아이디
			Members m= m_repository.select(miniurl); // 미니룸 멤버
			 				
			if(func.equals("home")) {
				System.out.println("if문");
				home(model,session,miniurl);
			}else if(func.equals("give")) {
				ms_controller.give(model, session, 1, miniurl);
			}else if(func.equals("trade")) {
			//	ms_controller.trade(model, session, 1, miniurl);
			}else if(func.equals("talent")) {
			//	ms_controller.give(model, session, 1, miniurl);
			}else if(func.equals("review")) {
				ms_controller.give(model, session, 1, miniurl);
			}else if(func.equals("setting")) {
				setting(model,session,miniurl);
			}
			return "";
		}*/
	
		@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/home")
		public String home(Model model, HttpSession session,@PathVariable("miniurl")String miniurl) {
			System.out.println("miniurl: "+miniurl);
			String userid = (String)session.getAttribute("loginId"); // 로그인유저아이디
			Members m= m_repository.select(miniurl); // 미니룸 멤버
			System.out.println("member: "+m);
			List<Map<String,String>> list = m_repository.selectAll(m.getUserid());
			System.out.println("list:"+list);
			Profile p = p_repository.select(m.getUserid());
			model.addAttribute("homeuserid", m.getUserid());
			model.addAttribute("myurl", m.getMyurl());
			model.addAttribute("profile", p);
			model.addAttribute("list", list);
			return "mystore/myStore";
		}
	
	
	/** setting 게시판 controller **/
	// 임시 : setting
	@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/setting") // 인터셉터로 현재미니룸주인과 다른아이디이거나 로그인 안된유저면 팅겨버러야함
	public String setting(Model model, HttpSession session,@PathVariable("miniurl")String miniurl) {
		String loginId = (String)session.getAttribute("loginId");
		List<Map<String,String>> list = m_repository.selectAll(loginId);
		Members m= m_repository.select(miniurl);
		model.addAttribute("list", list);
		model.addAttribute("userid", m.getUserid());
		System.out.println("setting: "+list);
		
		return "mystore/setting";
	}
	
	// 프로필 편집창 띄우기 
	@RequestMapping(value="/profileEdit")
	public String profileEdit(Model model, HttpSession session) {
		String userid = (String)session.getAttribute("loginId");
		Profile p = p_repository.select(userid);
		Members m = mb_repository.selectid(userid);
		model.addAttribute("profile", p);
		model.addAttribute("myurl", m.getMyurl());
		return "mystore/profileEdit";
	}
	
	
	// 미니룸 정보 저장
		@ResponseBody
		@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/saveMiniRoom", method=RequestMethod.POST)
		public List<Mystore> saveMiniRoom(@RequestBody List<Mystore> list , Model model, HttpSession session, @PathVariable("miniurl")String miniurl) {
			
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
		@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/reqFurniture", method=RequestMethod.GET)
		public Map<String, Object> reqFurniture(
				@RequestParam(value="currentPage", defaultValue="1") int currentPage,
				@RequestParam(value="searchItem", defaultValue="type") String searchItem,
				@RequestParam(value="searchWord", defaultValue="background") String searchWord,
				Model model, HttpSession session,
				@PathVariable("miniurl")String miniurl) {
			String loginId = (String)session.getAttribute("loginId");
			System.out.println("loginId: "+ loginId);
			int totalItemCount = m_repository.getItemCount(searchItem,searchWord,loginId);
			PageNavigator navi = new PageNavigator(currentPage, totalItemCount,4,4);
			List<Map<String,Object>> list = m_repository.selectUserItem(searchItem,searchWord, navi.getStartRecord(), navi.getCountPerPage(),loginId);
			System.out.println("list: "+ list);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("list", list);
			map.put("totalPage", navi.getTotalRecordCount());
			map.put("navi", navi);
			
			
			//int srow = COUNT_PER_PAGE * (currentPage -1) + 1;
			//int erow = (totalPageCount == currentPage) ?  : COUNT_PER_PAGE * currentPage;
			
			return map;
		}
		
		
	
		@ResponseBody
		@RequestMapping(value="/profileEdit", method=RequestMethod.POST)
		public String Editprofile(MultipartFile upload, HttpSession session, Profile profile, String myurl) {
			String userid = (String)session.getAttribute("loginId");
			Members urlM= new Members();
			urlM.setMyurl(myurl);
			Members um = mb_repository.selectUrl(urlM);
			if(um != null && !um.getUserid().equals(userid)) {
					return "";
			}
			String originalfile = upload.getOriginalFilename();
			String savedfile = FileService.saveFile(upload, uploadPath);
			System.out.println(originalfile+", "+savedfile+", "+userid);
			Profile p = p_repository.select(userid);
			// member xml에서 update문 추가하기
			if(!originalfile.equals("")) { // 파일 첨부가 있을때
				// 기존파일삭제후 넣기
				if(p.getSavedfile() !=null && !p.getSavedfile().equals("")) { // 기존프로필 저장파일이 있으면
					String fullPath = uploadPath + "/" + p.getSavedfile();
					System.out.println(fullPath);
					FileService.deleteFile(fullPath);
				}
				p.setOriginalfile(originalfile);
				p.setSavedfile(savedfile);
			}
			
			p.setContent(profile.getContent());
			p_repository.update(p);
			Members m = new Members();
			m.setMyurl(myurl);
			m.setUserid(userid);
			mb_repository.updateURL(m);
			
			return myurl;
		}
		
		@ResponseBody
		@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/reqFavorite", method=RequestMethod.POST)
		public String reqFavorite(HttpSession session, @RequestBody Map<String,String> idmap, @PathVariable("miniurl")String miniurl) {
			System.out.println("fafafa");
			System.out.println("idmap: " + idmap);
			Favorite tempFavorite = new Favorite();
			Members member = new Members();
			member.setUserid(idmap.get("homeid"));
			Members m = mb_repository.selectOne(member);
			System.out.println("m: "+m);
			tempFavorite.setMyurl(m.getMyurl());
			tempFavorite.setUserid(idmap.get("userid"));
			System.out.println("tempFavorite: "+tempFavorite);
			Favorite f = f_repository.fSelect(tempFavorite);
			System.out.println("f: "+f);
			if(f == null) {
				//insert
				
				tempFavorite.setMyurl(m.getMyurl());
				tempFavorite.setUserid(idmap.get("userid"));
				f_repository.fInsert(tempFavorite);
				return "Favorite insert";
			}else {
				//delete
				f_repository.fDelete(f.getFavoritenum());
				return "Favorite delete";
			}
		}
	
}
