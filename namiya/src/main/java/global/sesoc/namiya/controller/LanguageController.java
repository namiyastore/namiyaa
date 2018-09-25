package global.sesoc.namiya.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Controller
public class LanguageController {
	
	@RequestMapping(value = "/ko", method = RequestMethod.GET)
	public String ko(HttpSession session) {
		session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.KOREAN);
		//System.out.println(session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
		
		return "redirect:/loginForm";
	}
	
	@RequestMapping(value = "/en", method = RequestMethod.GET)
	public String en(HttpSession session) {
		session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.ENGLISH);
		//System.out.println(session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
		
		return "redirect:/loginForm";
	}
	
	@RequestMapping(value = "/ja", method = RequestMethod.GET)
	public String jp(HttpSession session) {
		session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, Locale.JAPANESE);
		//System.out.println(session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
		
		return "redirect:/loginForm";
	}
	
}
