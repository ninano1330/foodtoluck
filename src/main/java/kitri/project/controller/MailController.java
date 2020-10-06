package kitri.project.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kitri.project.service.MailService;

@Controller
public class MailController {
    //private MemberService memberService;
	
	@Autowired
    private MailService mailService;
 
    /*public void setUserService(MemberService memberService) {
        this.memberService = memberService;
    }*/
    
//    public void setMailService(MailService mailService) {
//        this.mailService = mailService;
//    }
 
    /*@RequestMapping("ajaxform")
	public String doAjaxForm(){
		return "review/ajax";
	}
	
	@ResponseBody
	@RequestMapping("ajax")
	public UserVO doAjax
	(@ModelAttribute("userlist") ArrayList<UserVO> list, String name){
		for(UserVO vo:list){
			if(vo.getName().equals(name)){
				return vo;
			}
		}
		return new UserVO("1","1","1","1");	
	}*/
    
    // 회원가입 이메일 인증
    @RequestMapping(value = "/sendMail/auth", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public boolean sendMailAuth(HttpSession session, @RequestParam String email) {
        int ran = new Random().nextInt(1000000) + 100000; // 100000 ~ 999999
        String joinCode = String.valueOf(ran);
        session.setAttribute("joinCode", joinCode); 

        String subject = "회원가입 인증 코드 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("귀하의 인증 코드는 " + joinCode + "입니다.");
        boolean isSend = mailService.send(subject, sb.toString(), "foodtoluck@gmail.com", email, null);
        
        return isSend;
    }
    
    @RequestMapping(value = "/sendMail/auth2", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public boolean sendMailAuth2(HttpSession session, @RequestParam String emailCode) {
        if(emailCode.equals(session.getAttribute("joinCode"))){
        	return true;
        }else{
        	return false;
        }
    }
    
    
    /*@RequestMapping(value = "/emailAuth")
    public ModelAndView sendMailAuth(HttpSession session, @RequestParam String email) {
        int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        session.setAttribute("joinCode", joinCode);
        session.setMaxInactiveInterval(60*3); //유효시간 3분
        String subject = "회원가입 인증 코드 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
        mailService.send(subject, sb.toString(), "foodtoluck@gmail.com", email, null);
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("join/emailAuth");
        mv.addObject("email",email);
        mv.addObject("joinCode",joinCode);
        return mv;
    }*/
    
    /*
    // 아이디 찾기
    @RequestMapping(value = "/sendMail/id", method = RequestMethod.POST)
    public String sendMailId(HttpSession session, @RequestParam String email, @RequestParam String captcha, RedirectAttributes ra) {
        String captchaValue = (String) session.getAttribute("captcha");
        if (captchaValue == null || !captchaValue.equals(captcha)) {
            ra.addFlashAttribute("resultMsg", "자동 방지 코드가 일치하지 않습니다.");
            return "redirect:/find/id";
        }
 
        memberVO member = memberService.findAccount(email);
        if (member != null) {
            String subject = "아이디 찾기 안내 입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append("귀하의 아이디는 " + member.getMember_id() + " 입니다.");
            mailService.send(subject, sb.toString(), "foodtoluck@gmail.com", email, null);
            ra.addFlashAttribute("resultMsg", "귀하의 이메일 주소로 해당 이메일로 가입된 아이디를 발송 하였습니다.");
        } else {
            ra.addFlashAttribute("resultMsg", "귀하의 이메일로 가입된 아이디가 존재하지 않습니다.");
        }
        return "redirect:/find/id";
    }
 
    // 비밀번호 찾기
    @RequestMapping(value = "/sendMail/password", method = RequestMethod.POST)
    public String sendMailPassword(HttpSession session, @RequestParam String id, @RequestParam String email, @RequestParam String captcha, RedirectAttributes ra) {
        String captchaValue = (String) session.getAttribute("captcha");
        if (captchaValue == null || !captchaValue.equals(captcha)) {
            ra.addFlashAttribute("resultMsg", "자동 방지 코드가 일치하지 않습니다.");
            return "redirect:/find/password";
        }
 
        memberVO member = memberService.findAccount(email);
        if (member != null) {
            if (!member.getMember_id().equals(id)) {
                ra.addFlashAttribute("resultMsg", "입력하신 이메일의 회원정보와 가입된 아이디가 일치하지 않습니다.");
                return "redirect:/find/password";
            }
            int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
            String password = String.valueOf(ran);
            memberService.updateInfo(member.getMember_pw(), "password", password); // 해당 유저의 DB정보 변경
 
            String subject = "임시 비밀번호 발급 안내 입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append("귀하의 임시 비밀번호는 " + password + " 입니다.");
            mailService.send(subject, sb.toString(), "foodtoluck@gmail.com", email, null);
            ra.addFlashAttribute("resultMsg", "귀하의 이메일 주소로 새로운 임시 비밀번호를 발송 하였습니다.");
        } else {
            ra.addFlashAttribute("resultMsg", "귀하의 이메일로 가입된 아이디가 존재하지 않습니다.");
        }
        return "redirect:/find/password";
    }
    */  
}
