package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import global.sesoc.namiya.dao.SavingRepository;
import global.sesoc.namiya.vo.Saving;

@Controller
public class SavingController {
	
	@Autowired
	SavingRepository repository;
	
	/*
	 * 포인트 확인(String : type -> '양도' 또는 '기부')
	 * ajax로 호출
	 */
//	@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/pointCheck", method=RequestMethod.POST)
//	public @ResponseBody int pointCheck(String type, HttpSession session, @PathVariable("miniurl")String miniurl) {
//		Saving saving = new Saving();
//		String userid = session.getAttribute("loginId").toString();
//		
//		saving.setType(type);
//		saving.setUserid(userid);
//		
//		
//		int result = repository.pointCheck(saving);
//		
//		return result;
//	}
	
	/*
	 * 포인트 추가(String : type -> '양도' 또는 '재능기부')
	 * ajax로 호출
	 */
//	@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/pointAdd", method=RequestMethod.POST)
//	public @ResponseBody int pointAdd(String type, HttpSession session, @PathVariable("miniurl")String miniurl) {
//		Saving saving = new Saving();
//		String userid = session.getAttribute("loginId").toString();
//		
//		saving.setType(type);
//		saving.setUserid(userid);
//		
//		int result = repository.pointAdd(saving);
//		
//		return result;
//	}
	
	/*
	 * 포인트 사용(int : point -> 사용할 포인트양)
	 * ajax로 호출
	 */
//	@RequestMapping(value="/myStore"+"/{miniurl:.+}"+"/pointMinus", method=RequestMethod.POST)
//	public @ResponseBody int pointMinus(int point, HttpSession session, @PathVariable("miniurl")String miniurl) {
//		Saving saving = new Saving();
//		String userid = session.getAttribute("loginId").toString();
//		
//		saving.setPoint(point);
//		saving.setUserid(userid);
//		
//		int result = repository.pointMinus(saving);
//		
//		return result;
//	}
	
	///////////////// 아래부터는 My Page 에 포인트 내역 보여주는  내용 /////////////////////
	
	/*
	 * 총 포인트
	 * ajax로 호출
	 */
//	@RequestMapping(value="pointTotal", method=RequestMethod.POST)
//	public @ResponseBody int pointTotal(HttpSession session) {
//		String userid = session.getAttribute("loginId").toString();
//		
//		int result = repository.pointTotal(userid);
//		
//		return result;
//	}
	
	/*
	 * 포인트 기록 조회
	 */
	@RequestMapping(value="pointRecord", method=RequestMethod.GET)
	public String pointRecord(HttpSession session, Model model) {
		String userid = session.getAttribute("loginId").toString();
		
		List<Saving> result = repository.pointRecord(userid);
		
		String lang = session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME).toString();
		
		if(result != null) {
			if(!lang.equals("ko")) {
				for(int i=0; i<result.size(); i++) {
					String type = result.get(i).getType();
					
					if(lang.equals("en")) {
						if(type.equals("양도")) {
							result.get(i).setType("Transfer");
						}
						else if(type.equals("재능기부")) {
							result.get(i).setType("Talent donation");
						}
						else if(type.equals("포인트사용")) {
							result.get(i).setType("barter");
						}
					}
					else if(lang.equals("ja")) {
						if(type.equals("양도")) {
							result.get(i).setType("譲渡");
						}
						else if(type.equals("재능기부")) {
							result.get(i).setType("才能寄付");
						}
						else if(type.equals("포인트사용")) {
							result.get(i).setType("才能");
						}
					}
					
				}
			}
			
		}		
		
		model.addAttribute("pointRecord", result);
		
		return "mypage/point";
	}
}
