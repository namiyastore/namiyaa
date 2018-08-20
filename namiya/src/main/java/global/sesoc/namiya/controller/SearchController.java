package global.sesoc.namiya.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SearchController {
	
	@RequestMapping(value="search", method=RequestMethod.GET)
	public String search() {
		
		return "search";
	}
	
	@RequestMapping(value="result", method=RequestMethod.GET)
	public String result() {
		
		return "result";
	}
	
}
