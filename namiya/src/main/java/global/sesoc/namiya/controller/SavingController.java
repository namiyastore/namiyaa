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

import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.dao.SavingRepository;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Profile;
import global.sesoc.namiya.vo.Saving;

@Controller
public class SavingController {
	
	@Autowired
	SavingRepository repository;
	
	@Autowired
	MembersRepository Members_repository;
	@Autowired
	ProfileRepository profile_repository;
	
	/*
	 * 총 포인트
	 * ajax로 호출
	 */
	@RequestMapping(value="pointTotal", method=RequestMethod.POST)
	public @ResponseBody int pointTotal(HttpSession session) {
		String userid = session.getAttribute("loginId").toString();
		
		int result = repository.pointTotal(userid);
		
		return result;
	}
	
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
							result.get(i).setType("お譲り");
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
		
		//프로필사진 갱신
		Profile profile = profile_repository.select(userid);
		model.addAttribute("profile",profile);
				
		
		//myurl을 가져오는 코드 시작		
		Members m = new Members();
		
		m.setUserid(userid);
		
		Members result1 = Members_repository.selectOne(m);
		model.addAttribute("myurl", result1.getMyurl());
		//myrul가져오는 코드 여기까지
		
		return "mypage/point";
	}
}
