package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.MessageRepository;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Message;

@Controller
public class MessageController {
	@Autowired
	MessageRepository repository;
	@Autowired
	MembersRepository Members_repository;
	
	@RequestMapping(value="mInBoxListAll", method = RequestMethod.GET)
	public String mInBoxListAll(@RequestParam(value = "currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchWord", defaultValue = "") String searchWord,Model model
			,HttpSession session) {
		
		int totalRecordCount = repository.getInboxRecordCount(searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		System.out.println("0926 currentpage? "+currentPage);
		List<Message> InboxList = repository.Inbox_select_result(searchWord,navi.getStartRecord(),navi.getCountPerPage());
		System.out.println("0921 받은쪽지 리스트?"+InboxList);
		
		model.addAttribute("InboxList", InboxList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		
		//myurl을 가져오는 코드		
		String userid = session.getAttribute("loginId").toString();
		Members m = new Members();
		
		m.setUserid(userid);
		
		Members result1 = Members_repository.selectOne(m);
		model.addAttribute("myurl", result1.getMyurl());
		return "mypage/inBoxMessage";
	}
	@RequestMapping(value="mInBoxInsert", method = RequestMethod.POST)
	public String mInBoxInsert(Message message) {
		repository.mInBoxInsert(message);
		return "redirect:mInBoxListAll";
	}
	@RequestMapping(value="mInBoxDelete", method = RequestMethod.GET)
	public String mInBoxDelete(int messagenum) {
		repository.mInBoxDelete(messagenum);
		return "redirect:mInBoxListAll";
	}
	@RequestMapping(value="mInBoxSelectOne", method = RequestMethod.GET)
	public String mInBoxSelectOne(int messagenum,Model model) {
		Message message = repository.mInBoxSelectOne(messagenum);
		model.addAttribute("message", message);
		return "redirect:mInBoxListAll";
	}
	
//	보낸쪽지함의 컨트롤러
	@RequestMapping(value="mOutBoxListAll", method = RequestMethod.GET)
	public String mOutBoxListAll(@RequestParam(value = "currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchWord",defaultValue = "") String searchWord,Model model,
			HttpSession session) {
		
		int totalRecordCount = repository.getOutboxRecordCount(searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		List<Message> OutboxList = repository.Outbox_select_result(searchWord,navi.getStartRecord(),navi.getCountPerPage());
		
		model.addAttribute("OutboxList", OutboxList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		//myurl을 가져오는 코드		
				String userid = session.getAttribute("loginId").toString();
				Members m = new Members();
				
				m.setUserid(userid);
				
				Members result1 = Members_repository.selectOne(m);
				model.addAttribute("myurl", result1.getMyurl());
		
		return "mypage/outBoxMessage";
	}
	@RequestMapping(value="mOutBoxInsert", method = RequestMethod.POST)
	public String mOutBoxInsert(Message message) {
		repository.mOutBoxInsert(message);
		return "redirect:mOutBoxListAll";
	}
	@RequestMapping(value="mOutBoxDelete", method = RequestMethod.GET)
	public String mOutBoxDelete(int messagenum) {
		repository.mOutBoxDelete(messagenum);
		return "redirect:mOutBoxListAll";
	}
	@RequestMapping(value="mOutBoxSelectOne", method = RequestMethod.GET)
	public String mOutBoxSelectOne(int messagenum,Model model) {
		Message message = repository.mOutBoxSelectOne(messagenum);
		model.addAttribute("message", message);
		return "redirect:messageList";
	}
	
	@RequestMapping(value="mUpdate", method = RequestMethod.POST)
	public String mUpdate(Message message) {
		repository.mUpdate(message);
		return "mypage/message";
	}

}
