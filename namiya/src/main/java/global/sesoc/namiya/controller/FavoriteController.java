package global.sesoc.namiya.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.omg.CORBA.RepositoryIdHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.FavoriteRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.MystoreRepository;
import global.sesoc.namiya.vo.Favorite;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Profile;

@Controller
public class FavoriteController {
	@Autowired
	FavoriteRepository repository;
	
	@Autowired
	MembersRepository mb_repository;
	
	@Autowired
	MystoreRepository m_repository;
	
	@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/favorite")
	public String home(Model model, HttpSession session,@PathVariable("miniurl")String miniurl) {
		System.out.println("favorite::miniurl: "+miniurl);
		String userid = (String)session.getAttribute("loginId"); // 로그인유저아이디
		Members m= m_repository.select(miniurl); // 미니룸 멤버
		System.out.println("m.getUserid():"+m.getUserid());
		List<Map<String,String>> list = repository.fList(m.getUserid());
		//model.addAttribute("homeuserid", m.getUserid());
		model.addAttribute("url", m.getMyurl());
		model.addAttribute("list", list);
		model.addAttribute("userid", m.getUserid());
		return "mystore/favorite";
	}
	
	@RequestMapping(value="favoriteList", method = RequestMethod.GET)
	public String fListAll(Model model) {
		
		//List<Favorite> flist = repository.fListAll();
		//model.addAttribute("flist", flist);
		List<String> list = new ArrayList<String>();
		list.add("bt_320");
		list.add("butterfly0");
		list.add("cat0");
		list.add("dog0");
		list.add("girin0");
		list.add("goat0");
		list.add("gora0");
		list.add("home0");
		list.add("tori0");
		list.add("sheep0");
		list.add("rabit0");
		
		model.addAttribute("list", list);
		return "mypage/favorite";
	}
	
	@RequestMapping(value="fInsert", method = RequestMethod.POST)
	public String fInsert(Favorite favorite) {
//		System.out.println("넘어오는가?" + favorite);
		repository.fInsert(favorite);
		return "redirect:favoriteList";
	}
	
	@RequestMapping(value = "fDelete", method = RequestMethod.GET)
	public String fDelete(int favoritenum) {
		repository.fDelete(favoritenum);
		return "redirect:favoriteList";
	}
	
	@RequestMapping(value= "fSelectOne", method = RequestMethod.GET)
	public String fSelectOne(int favoritenum, Model model) {
//		System.out.println("넘어오나?3"+favoritenum);
		Favorite selectedfavorite = repository.fSelectOne(favoritenum);
		model.addAttribute("selectedfavorite", selectedfavorite);
		return "mypage/favorite";
	}
	
	@RequestMapping(value = "fUpdate", method = RequestMethod.POST)
	public String fUpdate(Favorite favorite) {
		System.out.println("넘어오나?4" +favorite);
		repository.fUpdate(favorite);
		return "redirect:favoriteList";
	}

}
