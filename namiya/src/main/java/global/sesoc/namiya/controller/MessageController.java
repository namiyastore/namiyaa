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
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Message;
import global.sesoc.namiya.vo.Profile;

@Controller
public class MessageController {
	@Autowired
	MessageRepository repository;
	@Autowired
	MembersRepository Members_repository;
	@Autowired
	BoardRepository b_repository;
	@Autowired
	ProfileRepository profile_repository;
	
	@RequestMapping(value="mInBoxListAll", method = RequestMethod.GET)
	public String mInBoxListAll(
			@RequestParam(value = "currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchWord", defaultValue = "") String searchWord,
			Model model,HttpSession session) {
		
		String userid = session.getAttribute("loginId").toString();
		
		Map<String,String> userIdAndSearchWord = new HashMap<String,String>();
		userIdAndSearchWord.put("searchWord", searchWord);
		userIdAndSearchWord.put("userid", userid);
		
		
		int totalRecordCount = repository.getInboxRecordCount(userIdAndSearchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		System.out.println("111111 currentPage and totalRecordCount? " + currentPage +", "+ totalRecordCount);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchWord", searchWord);
		map.put("userid", userid);
		
		List<Message> InboxList = repository.Inbox_select_result(map,navi.getStartRecord(),navi.getCountPerPage());
		
		//프로필사진 갱신
		Profile profile = profile_repository.select(userid);
		model.addAttribute("profile",profile);
		
		model.addAttribute("InboxList", InboxList);
		model.addAttribute("searchWord", searchWord);
		System.out.println("11111검사???"+navi.getStartRecord() +", "+navi.getCountPerPage());
		System.out.println("navui" + navi);
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
		Message rcvMessage = repository.mInBoxSelectOne(messagenum);
		
		model.addAttribute("rcvMessage", rcvMessage);
		return "mypage/receiveMsg";
	}
	
//	보낸쪽지함의 컨트롤러
	@RequestMapping(value="mOutBoxListAll", method = RequestMethod.GET)
	public String mOutBoxListAll(@RequestParam(value = "currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchWord", defaultValue = "") String searchWord,Model model
			,HttpSession session) {
		
		String userid = session.getAttribute("loginId").toString();
		
		Map<String,String> userIdAndSearchWord = new HashMap<String,String>();
		userIdAndSearchWord.put("searchWord", searchWord);
		userIdAndSearchWord.put("userid", userid);
		
		
		int totalRecordCount = repository.getOutboxRecordCount(userIdAndSearchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchWord", searchWord);
		map.put("userid", userid);
		
		List<Message> OutboxList = repository.Outbox_select_result(map,navi.getStartRecord(),navi.getCountPerPage());
		
		//프로필사진 갱신
		Profile profile = profile_repository.select(userid);
		model.addAttribute("profile",profile);
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
		Message sendedmessage = repository.mOutBoxSelectOne(messagenum);
		
		System.out.println("발신한 쪽지 내용? " + sendedmessage);
		model.addAttribute("sendedmessage", sendedmessage);
		return "mypage/SendedMsg";
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
		
		msg.setCopy(0);
		
		int result2 = b_repository.insertMsg(msg);	
		
		/*System.out.println("메세지 전송 결과2: " + result2);*/
		
		return "mypage/writeMsg";
	}

}
