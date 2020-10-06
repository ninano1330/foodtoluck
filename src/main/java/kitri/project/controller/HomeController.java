package kitri.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.soap.Addressing;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.mapping.ParameterMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kitri.project.service.NoticeService;
import kitri.project.vo.BoardVO;
import kitri.project.vo.NoticeVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	NoticeService noticeService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="main")
	public String goMain() {
		return "redirect:/";
	}

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView();
		List<NoticeVO> noticelist = noticeService.noticelist();
		List<BoardVO> boardlist = noticeService.boardlist();
		
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("noticelist", noticelist);
	    map.put("boardlist", boardlist);
	    
	    mav.addObject("map", map);
	    mav.setViewName("main");
		return mav;
	}
	
	@RequestMapping(value="test.main" ,method=RequestMethod.GET)
	public ModelAndView test(ParameterMap map) {
		System.out.println("main입니다");
		System.out.println(map);
		System.out.println(map.getId());
		ModelAndView m = new ModelAndView();
		
		m.setViewName("test/testmain");
		m.addObject("main","main입니다");

//		System.out.println("RequestURI = " + request.getRequestURI());
//		System.out.println("RequestURI = " + request.getRequestURI());
		
		return m;
	}
	
	@RequestMapping(value="test.sub" ,method=RequestMethod.GET)
	public String test2(Model model) {
		System.out.println("test.sub입니다");
		model.addAttribute("sub", "sub입니다");
		
		return "forward:test.main";
	}
	
	@ResponseBody
	@RequestMapping(value="test.main.ajax")
	public String test3(String a) {
		
		return "a";
	}
	
	@RequestMapping(value="modal")
	public String test4() {
		return "test/modal";
	}
	
	@RequestMapping(value="inc2")
	public String test5() {
		return "test/inc";
	}
	
	@RequestMapping(value="inc")
	public String test6() {
		return "test/inc2";
	}
	
	
	@RequestMapping(value = "/search_result", method = RequestMethod.GET)
	public String search_result(Locale locale, Model model) {
		
		return "search_result";
	}
	
	@RequestMapping(value = "/owner_search", method = RequestMethod.GET)
	public String owner_search(Locale locale, Model model) {
		
		return "owner_search";
	}
	
	@RequestMapping(value = "/truck_menu_main", method = RequestMethod.GET)
	public String truck_menu_main(Locale locale, Model model) {
		
		return "truck_menu_main";
	}
	
	@RequestMapping(value = "/truck_menu_detail", method = RequestMethod.GET)
	public String truck_menu_detail(Locale locale, Model model) {
		
		return "truck_menu_detail";
	}
	
	@RequestMapping(value = "/free_board", method = RequestMethod.GET)
	public String free_board(Locale locale, Model model) {
		
		return "free_board";
	}
	
	@RequestMapping(value = "/exam_board", method = RequestMethod.GET)
	public String exam_board(Locale locale, Model model) {
		
		return "exam_board";
	}
	

	
}
