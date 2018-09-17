package global.sesoc.namiya.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.http.client.ClientProtocolException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import global.sesoc.namiya.util.HttpclientSendMsg;
import global.sesoc.namiya.dao.LinenotifyRepository;
import global.sesoc.namiya.util.Httpclient;
import global.sesoc.namiya.vo.Linenotify;

@Controller
public class LinenotifyController {
	
	@Autowired
	LinenotifyRepository repository;
	
	/**
	 * 라인 인증키 등록
	 * @param code
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "linenotify", method = RequestMethod.GET)
	public String linenotify(String code, HttpSession session) {	    
		
		String url = "";
		String result = "";
		String userid = session.getAttribute("loginId").toString();
		
		url += "https://notify-bot.line.me/oauth/token?";
		url += "grant_type=authorization_code&";
		url += "code=" + code + "&";
		url += "redirect_uri=http://localhost:8081/namiya/linenotify&";
		url += "client_id=j1pv2YPVmD4wAI5oJhXxBp&";
		url += "client_secret=9hQo5dXlluRl3d2e7fZL2Az9h9W6XUacIepEWDOkkeZ";
		
		try {
			Httpclient.url = url;
			result = Httpclient.sendGet();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(result);
		String access_token = element.getAsJsonObject().get("access_token").getAsString();
		
		System.out.println("인증키: " + access_token);
		
		Linenotify linenotify = new Linenotify();
		linenotify.setUserid(userid);
		linenotify.setToken(access_token);
		
		repository.insertNotifyToken(linenotify);
		
		return "linenotify/linenotify";
	}
	
	/**
	 * 인증키 등록여부 확인
	 * @param session
	 * @return 
	 */
	@RequestMapping(value="LinenotifyIdCheck", method=RequestMethod.POST)
	public @ResponseBody int LinenotifyIdCheck(HttpSession session) {
		
		String userid = session.getAttribute("loginId").toString();
		Linenotify result = repository.selectOne(userid);
		int rs = 0;
		
		if(result != null) rs = 1;
		
		return rs;
	}
	
	/**
	 * 라인 메세지 전송
	 * @param session
	 * @param message : 전송할 메세지
	 * @param receive : 메세지를 받는 사용자 아이디
	 * @return
	 */
	@RequestMapping(value="sendMsg", method=RequestMethod.POST)
	public @ResponseBody String sendMsg(HttpSession session, String message, String receive) {
		
		String userid = session.getAttribute("loginId").toString();
		String urlSetting = "https://notify-api.line.me/api/notify?message=" + message;
		String json = "";
		Linenotify rs = repository.selectOne(receive);
		
		try {
			HttpclientSendMsg.url = urlSetting;
			json = HttpclientSendMsg.sendGet(rs.getToken());
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json;
	}
}
