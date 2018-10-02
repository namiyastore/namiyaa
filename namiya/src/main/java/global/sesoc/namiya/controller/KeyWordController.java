package global.sesoc.namiya.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.dao.KeywordRepository;
import global.sesoc.namiya.dao.KeywordchkRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Keyword;
import global.sesoc.namiya.vo.Keywordchk;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Product;

@Controller
@Configuration
@EnableScheduling
public class KeyWordController {
	@Autowired
	KeywordRepository repository;
	@Autowired
	MembersRepository Members_repository;
	@Autowired
	BoardRepository board_repository;
	@Autowired
	ProductRepository Product_repository;
	@Autowired
	KeywordchkRepository Keywordchk_repository;
	
	@Scheduled(cron="*/5 * * * * *")
	public void keywordCheck() {
		//System.out.println("***** 키워드 30초마다 호출 스케쥴러 작동 테스트 *****");
		List<Keyword> klist = repository.kListAllWitoutUserid();
		List<Board> boardList = board_repository.selectAll();
		List<Integer> categorynumList = new ArrayList<>();
		
		String userid = klist.get(0).getUserid();
		
		// board 에 등록된 상품 리스트에서 카테고리번호 추출
		for(int i=0; i<boardList.size(); i++) {
			Product tmp  = Product_repository.selectByProductNum(boardList.get(i).getProductnum());
			categorynumList.add(tmp.getCategorynum());
		}
		
		// 추출된 카테고리번호를 board에 productnum컬럼에 적용 
		for(int i=0; i<boardList.size(); i++) {
			boardList.get(i).setProductnum(categorynumList.get(i));
		}
		
		// 최종적으로 키워드에 걸리는 내용이 있는지 확인
		for(Keyword rs : klist) {
			int categorynum = rs.getCategorynum();
			String userid2 = rs.getUserid();
			String keywordname = rs.getKeywordname();
			
			for(int j=0; j<boardList.size(); j++) {
				Board tmp = boardList.get(j);
				
				int tmpCategorynum = tmp.getProductnum();
				String tmpUserid = tmp.getUserid();
				String title = tmp.getTitle();
				
				if(tmpCategorynum == categorynum && tmpUserid.equals(userid2)) {
					if(title.contains(keywordname)) {
						System.out.println(" *** 키워드 감지: " + boardList.get(j));
						
						Keywordchk keywordchk = new Keywordchk();
						keywordchk.setUserid(userid);
						keywordchk.setBoardnum(boardList.get(j).getBoardnum());
						
						int chk = Keywordchk_repository.selectCount(keywordchk);
						System.out.println("chk: " + chk);
						if(chk == 0) {
							System.out.println("유저아이디: " + userid);
							int re = Keywordchk_repository.insertKeywordchk(keywordchk);
							System.out.println("추가됨: " + re);
							Keywordchk_repository.deleteKeywordchk();
						}
					}
				}
			}
			
			
		}
		
	}
	
	@RequestMapping(value="keywordList")
	public String keywordList(HttpSession session ,Model model) {
		String userid = session.getAttribute("loginId").toString();
		
		List<Keyword> klist = repository.kListAll(userid);
		
		model.addAttribute("klist", klist);
		
		//myurl을 가져오는 코드		
				
				Members m = new Members();
				
				m.setUserid(userid);
				
				Members result1 = Members_repository.selectOne(m);
				model.addAttribute("myurl", result1.getMyurl());
		return "mypage/keyword";
	}
	
	@RequestMapping(value="kInserTdata",method = RequestMethod.GET )
	public @ResponseBody String keyInsert(HttpSession session, String keywordname, int categorynum) {
		String userid = session.getAttribute("loginId").toString();
		int result = 0;
		int chk = 0;		
		
		Keyword keyword = new Keyword();
		keyword.setKeywordname(keywordname);
		keyword.setCategorynum(categorynum);
		keyword.setUserid(userid);
		
		chk = repository.chkKeywordDupl(keyword);
		
		if(chk != 1) {
			result = repository.kInsert(keyword);
		}
		
		return result + "";
	}
	
	//키워드 등록할때 창 이동
	@RequestMapping(value="keywordRegistry",method = RequestMethod.GET )
	public String keyInsert() {
		return "mypage/keywordReg";
	}
	
	@RequestMapping(value = "kDelete", method=RequestMethod.GET)
	public String kDelete(int keywordnum) {
		repository.kDelete(keywordnum);
		return "redirect:keywordList";
	}
	
	@RequestMapping(value="kSelectOne", method=RequestMethod.GET)
	public String kSelectOne(int keywordnum,Model model) {
		Keyword selectedkeyword = repository.kSelectOne(keywordnum);
		model.addAttribute("selectedkeyword", selectedkeyword);
		return "mypage/keyword";
	}
	
	@RequestMapping(value="kUpdate", method = RequestMethod.POST)
	public String kUpdate(Keyword keyword) {
		repository.kUpdate(keyword);
		return "redirect:keywordList";
	}

}
