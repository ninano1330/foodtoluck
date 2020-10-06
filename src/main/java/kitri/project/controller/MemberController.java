package kitri.project.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kitri.project.service.MemberServiceImpl;
import kitri.project.service.MenuService;
import kitri.project.vo.BookmarkVO;
import kitri.project.vo.MemberMenuVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.OwnerVO;

@Controller
public class MemberController {

	@Autowired
	MemberServiceImpl memberService;
	
	@Autowired
	MenuService menuService;
	
	@RequestMapping("join")
	public ModelAndView loginForm() {
		ModelAndView m = new ModelAndView();
		//m.setViewName("join/joinform3");
		m.setViewName("join/joinform");
		return m;
	}
	
	@RequestMapping(value="joinStep2Member", method=RequestMethod.POST)
	public ModelAndView join2Memer(
			@RequestParam("memberId") String member_id,
			@RequestParam("memberPwd") String member_pw,
			@RequestParam("memberName") String member_phone,
			String member_emailFirst,
			String member_emailSecond,
			String member_gender,
			@RequestParam("memberNickname") String membernick_name
			){
		String member_email = member_emailFirst+"@"+member_emailSecond;
		String member_code ="U";
		String member_image="resources/img/userImage/default.png";
		
		MemberVO vo = new MemberVO
				(member_id, member_pw, member_phone, member_email, member_gender, 
						membernick_name, member_code,member_image);
		
		memberService.insertMember(vo);
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberName", membernick_name);
		mav.setViewName("join/welcome");
		return mav;
		
	}
	
	@RequestMapping(value="joinStep2Boss", method=RequestMethod.POST)
	public ModelAndView join2Boss(
			@RequestParam("memberId") String member_id,
			@RequestParam("memberPwd") String member_pw,
			@RequestParam("memberName") String member_phone,
			String member_emailFirst,
			String member_emailSecond,
			String member_gender,
			@RequestParam("memberNickname") String membernick_name,
			String joinLicense1,
			String joinLicense2,
			String joinLicense3
			){
		String member_email = member_emailFirst+"@"+member_emailSecond;
		String REG_NUMBER = joinLicense1+"-"+joinLicense2+"-"+joinLicense3;
		String member_code ="O";
		String member_image="resources/img/userImage/default.png";
//		
		MemberVO vo1 = new MemberVO
				(member_id, member_pw, member_phone, member_email, member_gender, 
						membernick_name, member_code,member_image);
		OwnerVO vo2 = new OwnerVO(member_id,REG_NUMBER);
		
		memberService.insertMember(vo1);
		memberService.insertOwner(vo2);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberName", membernick_name);
		mav.setViewName("join/welcome");
		return mav;
		
	}
	
	@RequestMapping(value="info.mypage", method=RequestMethod.GET)
	public ModelAndView mypage(HttpSession session) {
		ModelAndView m = new ModelAndView();
		
		
		MemberVO vo = (MemberVO) session.getAttribute("sessionId");

		session.setAttribute("sessionId", vo);
		if(((MemberVO) session.getAttribute("sessionId")).getMember_code().equalsIgnoreCase("u")){
			System.out.println("user입니다");
			m.setViewName("mypage/user_modify_personelInfo");
		}else if(((MemberVO) session.getAttribute("sessionId")).getMember_code().equalsIgnoreCase("o")){
			System.out.println("owner입니다");
			m.setViewName("mypage/owner_modify_personelInfo");
		}else{
			m.setViewName("mypage/admin");
		}
		return m;
	}
	
	//지금은 직접 세션을 넣지만 세션어트리뷰트로 vo값 받아올수 있도록 하기??
	@RequestMapping(value="info.mypage", method=RequestMethod.POST)
	 public String updateMember(MemberVO vo, HttpSession session) throws Exception{
		vo.setMember_image(memberService.imageUpload(vo));
		memberService.updateMember(vo);
	
		
        return "redirect:info.mypage";
    }
	
	
	@RequestMapping(value="password.mypage", method=RequestMethod.GET)
	public ModelAndView mypwCh(HttpSession session) {

		MemberVO vo = (MemberVO) session.getAttribute("sessionId");
		
		ModelAndView m = new ModelAndView();
		String member_code = vo.getMember_code();
		System.out.println(member_code);
		if(((MemberVO) session.getAttribute("sessionId")).getMember_code().equalsIgnoreCase("U")){
			m.setViewName("mypage/user_modify_pwChange");
		}else if(((MemberVO) session.getAttribute("sessionId")).getMember_code().equalsIgnoreCase("O")){
			m.setViewName("mypage/owner_modify_pwChange");
		}else{
			m.setViewName("mypage/admin");
		}
		return m;
	}
	
	@ResponseBody
	@RequestMapping(value="password.check", method=RequestMethod.POST)
	public boolean mypwCheck(String member_pw_now, HttpSession session) {
		
		String id=((MemberVO) session.getAttribute("sessionId")).getMember_id();
		//System.out.println(id+" 바꿀비번:"+member_pw_now);
		//System.out.println("현재비번"+memberService.pwCheck(id).getMember_pw());
		if(memberService.pwCheck(id).getMember_pw().equals(member_pw_now)){
			return true;
		}else{
			return false;
		}		
	}
	
	@RequestMapping(value="password.mypage", method=RequestMethod.POST)
	public String pwChange(MemberVO vo,HttpSession session){
		vo.setMember_id(((MemberVO) session.getAttribute("sessionId")).getMember_id());
		memberService.pwChange(vo);
		return "redirect:info.mypage";
	}
	
	
	
	@RequestMapping("truck.main")
	public String truckMain(){
		return "menu/truck_main";
	}
	
	@ResponseBody
	@RequestMapping("addFavorite")
	public int addfavorite(int truck_code, HttpSession session){
		String member_id=((MemberVO) session.getAttribute("sessionId")).getMember_id();
		BookmarkVO vo = new BookmarkVO(member_id,truck_code);
		return memberService.insertBookmark(vo);
	}
	
	@ResponseBody
	@RequestMapping("deleteFavorite")
	public int deletefavorite(int truck_code, HttpSession session){
		String member_id=((MemberVO) session.getAttribute("sessionId")).getMember_id();
		BookmarkVO vo = new BookmarkVO(member_id,truck_code);
		return memberService.deleteBookmark(vo);
	}
	
	@ResponseBody
	@RequestMapping(value="addMemberMenu",method=RequestMethod.POST)
	public int addMemberMenu(int menu_no, HttpSession session){
		String member_id=((MemberVO) session.getAttribute("sessionId")).getMember_id();
		MemberMenuVO vo = new MemberMenuVO(menu_no, member_id);
		memberService.addMemberMenu(vo);
		menuService.updateMenulike(menu_no);
		int result = menuService.seleteMenulikeNumber(menu_no);
		System.out.println("addMemberMenu "+result);
		return result;
	}

	@ResponseBody
	@RequestMapping(value="deleteMemberMenu",method=RequestMethod.POST)
	public int deleteMemberMenu(int menu_no, HttpSession session){
		String member_id=((MemberVO) session.getAttribute("sessionId")).getMember_id();
		MemberMenuVO vo = new MemberMenuVO(menu_no, member_id);
		memberService.deleteMemberMenu(vo);
		menuService.updateMenulike(menu_no);
		int result = menuService.seleteMenulikeNumber(menu_no);
		System.out.println("deleteMemberMenu "+result);
		return result;
	}
}
