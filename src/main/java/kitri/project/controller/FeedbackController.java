package kitri.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kitri.project.service.ReviewFeedbackServiceImpl;
import kitri.project.vo.FeedbackVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.ReviewFeedbackAjaxVO;

@Controller
public class FeedbackController {
	@Autowired
	ReviewFeedbackServiceImpl reviewFeedbackServiceImpl;
	
	@ResponseBody
	@RequestMapping(value="feedback.do", method=RequestMethod.POST)
	public ReviewFeedbackAjaxVO insertFeedback(FeedbackVO feedbackVO, int currentPage
			,HttpSession session){
		MemberVO sessionId = (MemberVO) session.getAttribute("sessionId");
		String owner_id = sessionId.getMember_id();
		
		feedbackVO.setOwner_id(owner_id);

		return reviewFeedbackServiceImpl.insertFeedback(feedbackVO, currentPage);
	}
	//deleteMyFeedback.do
	@ResponseBody
	@RequestMapping(value="deleteMyFeedback.do", method=RequestMethod.POST) //에러
	public ReviewFeedbackAjaxVO deleteMyFeedback(FeedbackVO feedbackVO, int currentPage
			,HttpSession session) {
		MemberVO sessionId = (MemberVO) session.getAttribute("sessionId");
		String owner_id = sessionId.getMember_id();
		feedbackVO.setOwner_id(owner_id);
		
		ReviewFeedbackAjaxVO vo = reviewFeedbackServiceImpl.deleteFeedback(feedbackVO, currentPage);
		System.out.println(vo);
		
		return vo;
	}
}
