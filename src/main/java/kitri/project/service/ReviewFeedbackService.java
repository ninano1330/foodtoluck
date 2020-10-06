package kitri.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import kitri.project.vo.FeedbackVO;
import kitri.project.vo.MenuVO;
import kitri.project.vo.ReviewFeedbackAjaxVO;
import kitri.project.vo.ReviewFeedbackVO;
import kitri.project.vo.ReviewVO;


public interface ReviewFeedbackService {
	public ReviewFeedbackAjaxVO selectReviewFeedbackForAjax(int menu_no, int currentPage
			,String member_id);
	public ReviewFeedbackAjaxVO insertReview(ReviewVO reviewVO, String member_id);
	public ReviewFeedbackAjaxVO insertFeedback(FeedbackVO feedbackVO, int currentPage);
	public void deleteReview(int menu_no, String member_id);
	public ReviewFeedbackAjaxVO deleteFeedback(FeedbackVO feedbackVO, int currentPage);
	
	public ReviewFeedbackVO selectMyReview(int menu_no, String member_id);
	
	
	public Boolean checkOwner(int menu_no, String member_id);
	public Boolean checkReview(int menu_no, String member_id);
	
	public HashMap<String,Integer> calcPage(int currentPage, int reviewCount);
	public MenuVO selectDatailedMenu(int menu_no);
	public double selectAvgStar(int menu_no);
	public List<ReviewFeedbackVO> selectReviewFeedbackList(int menu_no, int currentPage
			,String member_id);	
}
