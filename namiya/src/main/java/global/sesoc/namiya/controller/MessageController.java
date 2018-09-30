package global.sesoc.namiya.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.namiya.dao.BoardRepository;
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
	@Autowired
	BoardRepository b_repository;
	
	@RequestMapping(value="mInBoxListAll", method = RequestMethod.GET)
	public String mInBoxListAll(@RequestParam(value = "currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchWord", defaultValue = "") String searchWord,Model model
			,HttpSession session) {
		
		String userid = session.getAttribute("loginId").toString();
		int totalRecordCount = repository.getInboxRecordCount(searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchWord", searchWord);
		map.put("userid", userid);
		
		List<Message> InboxList = repository.Inbox_select_result(map,navi.getStartRecord(),navi.getCountPerPage());
		
		model.addAttribute("InboxList", InboxList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		
		//myurl을 가져오는 코드		
		
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
			@RequestParam(value="searchWord", defaultValue = "") String searchWord,Model model
			,HttpSession session) {
		
		String userid = session.getAttribute("loginId").toString();
		int totalRecordCount = repository.getOutboxRecordCount(searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchWord", searchWord);
		map.put("userid", userid);
		
		List<Message> OutboxList = repository.Outbox_select_result(map,navi.getStartRecord(),navi.getCountPerPage());
		
		model.addAttribute("OutboxList", OutboxList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		
		//myurl을 가져오는 코드		
		
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
	
	@RequestMapping(value="/my_page_sendMsg", method=RequestMethod.GET)
	public String sendMsg(String userid, Model model) {
		model.addAttribute("userid", userid);
		
		return "mypage/sendMsg";
	}
	
	//쪽지 전송관련
	@RequestMapping(value="/mypageSendMsg", method=RequestMethod.POST)
	public String mypageSendMsg(Message msg) {
		int result = b_repository.insertMsg(msg);
		
		System.out.println("보낸쪽지 내용  jsp에서 날라온 내용 "+msg);
		
		System.out.println("메세지 전송 결과: " + result);

		/*String writerid = msg.getUserid();
		String userid = msg.getWriterid();
		
		msg.setUserid(userid);
		msg.setWriterid(writerid);*/
		msg.setCopy(0);
		
		int result2 = b_repository.insertMsg(msg);	
		
		System.out.println("메세지 전송 결과2: " + result2);
		
		return "redirect:mInBoxListAll";
	}

}
