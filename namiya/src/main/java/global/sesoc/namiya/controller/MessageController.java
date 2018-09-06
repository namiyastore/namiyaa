package global.sesoc.namiya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.MessageRepository;
import global.sesoc.namiya.vo.Message;

@Controller
public class MessageController {
	@Autowired
	MessageRepository repository;
	
	@RequestMapping(value="mInBoxListAll", method = RequestMethod.GET)
	public String mInBoxListAll(Model model) {
		List<Message> InboxList = repository.mInBoxListAll();
		model.addAttribute("InboxList", InboxList);
		return "mypage/InBoxMessage";
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
	@RequestMapping(value="mOutBoxListAll", method = RequestMethod.GET)
	public String mOutBoxListAll(Model model) {
		List<Message> OutBoxList = repository.mOutBoxListAll();
		model.addAttribute("OutBoxList", OutBoxList);
		return "mypage/OutBoxMessage";
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
