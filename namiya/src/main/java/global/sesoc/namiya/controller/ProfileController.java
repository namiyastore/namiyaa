package global.sesoc.namiya.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Profile;

@Controller
public class ProfileController {
	
	@Autowired
	ProfileRepository p_repository;
	
	@Autowired
	MembersRepository mb_repository;
	
	final String uploadPath = "/home/img/profile";
	
	
	
	// 사진 보여주기 
	@RequestMapping(value=uploadPath+"/{image_name:.+}", method= RequestMethod.GET) 
	public String getContentMediaImage(@PathVariable("image_name")String image_name, HttpServletResponse response) throws UnsupportedEncodingException, IOException {
		// 확장자 확인 // 
			System.out.println("!!!!!!!!!!!!!!!!!!image_name:"+ image_name);
		 String[] filename_seperate = image_name.split("\\."); 
		 String exp = "";
		   
		 if( filename_seperate.length <= 1 ) { 
		      // 확장자 에러 // 
		      /*String resultMsg = new MessageMaker().getErrorMessage("Wrong file name.");
		      response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING)); */
		      response.getOutputStream().flush();
		    return null; 
		 } else { 
		    exp = filename_seperate[1]; 
		 } 
		   // 파일 세팅 and 송신 //
		 File file = new File(uploadPath+"/"+image_name );
		 if( ! file.exists() ) {
		      // 파일 없음 //
		      /*String resultMsg = new MessageMaker().getErrorMessage("Not exist that file.");
		      response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING)); */
		    response.getOutputStream().flush(); 
		    return null; 
	  } 
		 response.setContentType("image/"+exp);
		 int cur;
		 try{
		    FileInputStream fileIn = new FileInputStream(file); 
		    BufferedInputStream bufIn = new BufferedInputStream(fileIn);
		    ServletOutputStream ostream = response.getOutputStream(); 
		    while( (cur=bufIn.read()) != -1 ){ 
		       ostream.write(cur);
		    } 
		    ostream.flush();
		    bufIn.close(); 
		 }catch(Exception e){
		      e.printStackTrace();
		 } 
		 return null;
	}
	
	
	
	
		@ResponseBody
		@RequestMapping(value="/reqProfile", method=RequestMethod.POST)
		public Map<String,Object> reqProfile(Model model, HttpSession session) {
			System.out.println("profile:sss");
			String userid = (String)session.getAttribute("loginId");
			Profile p = p_repository.select(userid);
			Members m = mb_repository.selectid(userid); 
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("profile", p);
			map.put("myurl", m.getMyurl());
			System.out.println("map: "+map);
			return map;
		}
		
		@RequestMapping(value="/checkNickname", method=RequestMethod.GET)
		public @ResponseBody int checkNickname(String nickname) {
			int result = 1;
			Profile p = p_repository.selectNickname(nickname);
			if(p!=null) {
				result = 0;
			}
			System.out.println(p);
			return result;
		}
	
}
