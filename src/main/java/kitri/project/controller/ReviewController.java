package kitri.project.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kitri.project.service.FoodtruckService;
import kitri.project.service.ReviewFeedbackServiceImpl;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.MenuVO;
import kitri.project.vo.ReviewFeedbackAjaxVO;
import kitri.project.vo.ReviewFeedbackVO;
import kitri.project.vo.ReviewVO;

@Controller
public class ReviewController {
	@Autowired
	ReviewFeedbackServiceImpl reviewFeedbackServiceImpl;
	@Autowired
	FoodtruckService foodtruckService;	
	@Resource
	HttpSession session;
	
	@RequestMapping("detailedmenu")
	public ModelAndView detailedMenu(@RequestParam(value="menu_no") int menu_no
			,@RequestParam(value="currentPage", defaultValue="1") int currentPage
			,int truck_code) {
		String member_id = getMemberIdFromSession(session);
		
		ModelAndView m = new ModelAndView();
		
		boolean checkOnwer = reviewFeedbackServiceImpl.checkOwner(menu_no, member_id);
		boolean checkReview = reviewFeedbackServiceImpl.checkReview(menu_no, member_id);
		HashMap<String,Integer> pageMap 
		= reviewFeedbackServiceImpl.calcPage(currentPage, menu_no);
		
		
		MenuVO menuVO = reviewFeedbackServiceImpl.selectDatailedMenu(menu_no);
		double avgStar = reviewFeedbackServiceImpl.selectAvgStar(menu_no);

		
		ReviewFeedbackVO myReview = reviewFeedbackServiceImpl.selectMyReview(menu_no, member_id);
		

	
		m.addObject("member_id",member_id);
		m.addObject("checkOwner",checkOnwer); //Owner인지 체크값
		m.addObject("checkReview",checkReview); //Review 썼는지 체크값
		
		m.addObject("startPage", pageMap.get("startPage")); 
		m.addObject("endPage",pageMap.get("endPage"));
		m.addObject("recogNextBlock",pageMap.get("recogNextBlock"));//paging 값
		
		m.addObject("menuVO",menuVO); //MenuVO
		m.addObject("avgStar",avgStar);  //menu_star 평균 값
		m.addObject("myReview",myReview); //myReview
		m.addObject("includeViewName", "../menu/truck_menu_detail.jsp");
		
		ReviewFeedbackAjaxVO reviewFeedbackList = 
				reviewFeedbackServiceImpl.selectReviewFeedbackForAjax(menu_no, currentPage, member_id);
		m.addObject("reviewFeedbackList",reviewFeedbackList);
		
		
		m.setViewName("forward:foodtruck?truck_code="+truck_code);
		return m;
	}	
	
	@RequestMapping(value="review.do",method=RequestMethod.POST)
	public String insertReview(ReviewVO reviewVO,int truck_code){
		String member_id = getMemberIdFromSession(session);
		reviewFeedbackServiceImpl.insertReview(reviewVO,member_id);
		
		return "redirect:detailedmenu?menu_no=" + reviewVO.getMenu_no() + "&truck_code=" + truck_code;
	}
	
	@ResponseBody 
	@RequestMapping(value="reviewPage.do", method=RequestMethod.GET)
	public ReviewFeedbackAjaxVO selectReviewFeedback(@RequestParam(value="menu_no", required=false) int menu_no
			,@RequestParam(value="currentPage") int currentPage, int truck_code) {
		String member_id = getMemberIdFromSession(session);
		
		return reviewFeedbackServiceImpl.selectReviewFeedbackForAjax(menu_no, currentPage, member_id);
	}
	
	@RequestMapping(value="deleteMyReview.do", method=RequestMethod.GET)
	public String deleteMyReview(@RequestParam int menu_no
			,HttpSession session, int truck_code){
		String member_id = getMemberIdFromSession(session);
		reviewFeedbackServiceImpl.deleteReview(menu_no, member_id);
		
		return "redirect:detailedmenu?menu_no=" + menu_no + "&truck_code=" + truck_code;
	}
	
	private String getMemberIdFromSession(HttpSession session){
		
		String member_id;
		if(session.getAttribute("sessionId")== null){
			member_id = "";
		}else{
			MemberVO memberVO = (MemberVO) session.getAttribute("sessionId");
			member_id = memberVO.getMember_id();
		}
		
		return member_id;
	}
}
