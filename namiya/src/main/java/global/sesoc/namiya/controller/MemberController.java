package global.sesoc.namiya.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.vo.Members;

@Controller
public class MemberController {
	@Autowired
	MembersRepository repository;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	ProfileRepository prepository;
	
	//region getPage
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String loginPage() {
		System.out.println("문클릭");
		return "member/loginForm";
	}
	
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String joinPage() {
		System.out.println("회원가입");
		return "member/joinForm";
	}
	
	@RequestMapping(value="login_form", method=RequestMethod.POST)
	public String loginCheck(Members member,HttpServletResponse response
			,HttpSession session
			,Model model) {
		System.out.println("로그인확인");
		System.out.println(member);
		Members m = new Members();
		m = repository.selectOne(member);
		
		if(m!=null) {
			System.out.println("로그인성공");
			session.setAttribute("loginId", m.getUserid());
			session.setAttribute("loginName", m.getUsername());
			model.addAttribute("message", "로그인 성공!");
			
			return "redirect:/search";
		}else {
			System.out.println("로그인실패");
			model.addAttribute("message", "아이디와 비밀번호를 확인해주세요.");
			return "member/loginForm";
		}
		
	}
	
	@RequestMapping(value="logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "main";
	}
	
	@RequestMapping(value="editForm",method=RequestMethod.GET)
	public String editMember(HttpSession session, Model model) {
		System.out.println("회원정보수정");
		Members m = new Members();
		m.setUserid((String)session.getAttribute("loginId"));
		m.setUsername((String)session.getAttribute("loginName"));
		
		m = repository.selectOne(m);
		
		model.addAttribute(m);
		return "editForm";//뷰로 넘기는거 해야함
	}
	
	@RequestMapping(value="edit_form",method=RequestMethod.POST)
	public String editForm(Members member, HttpSession session, Model model) {
		System.out.println("회원수정정보");
		System.out.println(member);
		int result = 0;
		String oMsg = null;

		result  = repository.updateMembers(member);
		
		if(result==1) {
			System.out.println("수정완료");
			oMsg="정보 수정 완료. 다시 로그인해주세요.";
		}
		if(result==0) {
			oMsg="정보가 수정되지 않았습니다.";
		}
		model.addAttribute("msg", oMsg);
		session.removeAttribute("loginId");
		session.removeAttribute("loginName");
		session.invalidate();
		
		return "member/loginForm";
	}
	
	@RequestMapping(value="pop", method=RequestMethod.GET)
	public String popup() {
		System.out.println("주소팝팝");
		return "member/jusoPopup";
	}
	
	@RequestMapping(value="pop", method = RequestMethod.POST)
	public String pop2(Model model,HttpServletRequest request) {
		String inputYn = request.getParameter("inputYn");
		String roadFullAddr = request.getParameter("roadFullAddr"); 
		String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
		String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
		String engAddr = request.getParameter("engAddr"); 
		String jibunAddr = request.getParameter("jibunAddr"); 
		String zipNo = request.getParameter("zipNo"); 
		String addrDetail = request.getParameter("addrDetail");
		
		System.out.println("주소전체: "+roadFullAddr);
		System.out.println("우편번호: "+zipNo);
		
		model.addAttribute("inputYn", inputYn);
		model.addAttribute("fullAddr", roadFullAddr);
		model.addAttribute("zipcode", zipNo);
		
		return "redirect:/addrBuffer";
	}
	
	@RequestMapping(value="addrBuffer", method=RequestMethod.GET)
	public String addrBuffer
	(
		String inputYn,
		String fullAddr,
		String roadAddrPart1,
		String roadAddrPart2,
		String engAddr,
		String jibunAddr,
		String zipcode,
		String addrDetail,
		Model model
	)
	{
		System.out.println("값뿌려진다.");
		System.out.println(fullAddr);
		System.out.println(zipcode);
		model.addAttribute("fullAddr", fullAddr);
		model.addAttribute("zipcode",zipcode);
		return "member/addrBuffer";
	}
	
	//endregion
	
	//region formprocessing
	@RequestMapping(value="join_form", method=RequestMethod.POST)
	public String join(Members members) {
		int result = 0;
		System.out.println("가입폼");
		System.out.println(members);
		
		result = repository.insertMembers(members);
		
		if(result!=0) {
			prepository.select(members.getUserid());
			return "member/loginForm";
		}else {
			return "member/joinForm";
		}
	}
	//endregion
	
	//region Ajax
	@RequestMapping(value="checkId", method=RequestMethod.GET)
	public @ResponseBody int idCheck(String id) {
		int result = 1;
		Members m = new Members();
		m.setUserid(id);
		Members member = repository.selectOne(m);
		if(member!=null) {
			result = 0;
		}
		System.out.println(member);
		return result;
	}
	
	@RequestMapping(value="checkEmail", method=RequestMethod.GET)
	public @ResponseBody int emailCheck(String email) {
		System.out.println("이메일 중복 확인");
		System.out.println(email);
		int result = 1;
		Members m = new Members();
		m.setEmail(email);
		Members member = repository.selectOne(m);
		
		if(member != null) {
			result=0;
		}
		System.out.println(member);
		return result;
	}
	
	 @RequestMapping(value = "checkAuthNum", method=RequestMethod.GET)
	  public @ResponseBody int mailSending(String usermail) {
	    int result = 0;
	    String setfrom = "makanai3535";
	    String authNum=null;
	    authNum = makeAuth();
		
	    String tomail  = usermail;     // 받는 사람 이메일
	    String title   = "Makanai Sign Up";      // 제목
	    String content = "AuthNum ["+authNum+"]";    // 내용
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content);  // 메일 내용
	     
	      mailSender.send(message);
	      result = Integer.parseInt(authNum);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	   
	    return result;
	  }

	public String makeAuth() {
		String authNum="";
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<6;i++) {
			int n = (int)(Math.random()*10);
			sb.append(n);
			authNum = sb.toString();
		}
		return authNum;
	}
	
	@RequestMapping(value="getAPI", method = RequestMethod.POST)
    public void getAddrApi(HttpServletRequest req, ModelMap model, HttpServletResponse response) throws Exception {
		// 요청변수 설정
    	System.out.println("에이피아이 컨트롤러");
    	String currentPage = req.getParameter("currentPage");    //요청 변수 설정 (현재 페이지. currentPage : n > 0)
		String countPerPage = req.getParameter("countPerPage");  //요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100)
		String resultType = req.getParameter("resultType");      //요청 변수 설정 (검색결과형식 설정, json)
		String confmKey = req.getParameter("confmKey");          //요청 변수 설정 (승인키)
		String keyword = req.getParameter("keyword");            //요청 변수 설정 (키워드)
		// OPEN API 호출 URL 정보 설정
		String apiUrl = "http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage="+currentPage+"&countPerPage="+countPerPage+"&keyword="+URLEncoder.encode(keyword,"UTF-8")+"&confmKey="+confmKey+"&resultType="+resultType;
		URL url = new URL(apiUrl);
    	BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
    	StringBuffer sb = new StringBuffer();
    	String tempStr = null;

    	while(true){
    		tempStr = br.readLine();
    		if(tempStr == null) break;
    		sb.append(tempStr);								// 응답결과 JSON 저장
    	}
    	br.close();
    	response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml");
		response.getWriter().write(sb.toString());			// 응답결과 반환
    }
	
	//endregion
}
