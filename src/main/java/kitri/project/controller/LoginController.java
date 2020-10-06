package kitri.project.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kitri.project.service.LoginService;
import kitri.project.vo.MemberVO;

@Controller
public class LoginController {
	@Autowired
	LoginService loginService;

	@Resource
	HttpSession session;

	@ResponseBody
	@RequestMapping(value = "loginCheck", method = RequestMethod.POST)
	public String loginCheck(MemberVO memberVO, Model model, HttpServletRequest request) {
		if(session.getAttribute("sessionId")!=null) {
			session.removeAttribute("sessionId");
		}

		MemberVO sessionId = loginService.login(memberVO);

		if (sessionId != null) {
			session.setAttribute("sessionId", sessionId);
			return "success";
		} else {
			return "false";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("logout")
	public String logout() {
		session.removeAttribute("sessionId");
		return "success";
	}

}
