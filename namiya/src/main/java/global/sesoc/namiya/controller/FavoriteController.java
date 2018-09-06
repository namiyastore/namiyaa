package global.sesoc.namiya.controller;

import java.util.List;

import org.omg.CORBA.RepositoryIdHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.FavoriteRepository;
import global.sesoc.namiya.vo.Favorite;

@Controller
public class FavoriteController {
	@Autowired
	FavoriteRepository repository;
	
	
	@RequestMapping(value="favoriteList", method = RequestMethod.GET)
	public String fListAll(Model model) {
		
		List<Favorite> flist = repository.fListAll();
		model.addAttribute("flist", flist);
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
