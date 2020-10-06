package kitri.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kitri.project.dao.ReviewFeedbackDAO;
import kitri.project.vo.FeedbackVO;
import kitri.project.vo.MenuVO;
import kitri.project.vo.ReviewFeedbackAjaxVO;
import kitri.project.vo.ReviewFeedbackVO;
import kitri.project.vo.ReviewVO;

@Service
public class ReviewFeedbackServiceImpl implements ReviewFeedbackService {
	@Autowired
	ReviewFeedbackDAO dao;
	
	//SELECT
	@Override
	public MenuVO selectDatailedMenu(int menu_no) {
		return dao.selectDetailedMenu(menu_no);
	}

	@Override
	public List<ReviewFeedbackVO> selectReviewFeedbackList(int menu_no, int currentPage
			,String member_id) {
		int rownum = calcRownum(currentPage);
		
		HashMap<String,Object> parameters = new HashMap<String, Object>();
		parameters.put("menu_no", menu_no);
		parameters.put("review_end", rownum+4);
		parameters.put("review_start", rownum);
		parameters.put("member_id", member_id);
		
		return dao.selectReviewFeedbackList(parameters);
	}

	@Override
	public double selectAvgStar(int menu_no) {
		return dao.selectAvgStar(menu_no);
	}
	
	
	
	@Override
	public Boolean checkOwner(int menu_no, String member_id) {
		if(member_id != null && !member_id.equals("")) {
			String owner_id = dao.selectOwnerId(menu_no);
			if(member_id.equals(owner_id)) {
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}

	@Override
	public Boolean checkReview(int menu_no, String member_id) {
		if(member_id == null || member_id.equals("") ) {
			return false;
		}else {
		
			ReviewVO reviewVO = new ReviewVO();
			reviewVO.setMenu_no(menu_no);
			reviewVO.setMember_id(member_id);
		
			int checkReview = dao.selectCheckReview(reviewVO);
			if(checkReview == 1){
				return true;
			}else{
				return false;
			}
		}
	}
	
	@Override
	public ReviewFeedbackVO selectMyReview(int menu_no, String member_id) {
		if(member_id == null || member_id.equals("") ) {
			return null;
		}else {
			HashMap<String,Object> parameters = new HashMap<String,Object>();
			
			parameters.put("menu_no", menu_no);
			parameters.put("member_id", member_id);
			
			ReviewFeedbackVO myReview = dao.selectMyReview(parameters);
			return myReview;
		}
	}

	@Override
	public ReviewFeedbackAjaxVO insertReview(ReviewVO reviewVO, String member_id) {
		reviewVO.setMember_id(member_id);
		dao.insertReview(reviewVO);
		return makeReviewFeedbackAjaxVO(reviewVO.getMenu_no(), 1, member_id);
	}

	@Override
	public ReviewFeedbackAjaxVO insertFeedback(FeedbackVO feedbackVO, int currentPage) {
		dao.insertFeedback(feedbackVO);
		return makeReviewFeedbackAjaxVO(feedbackVO.getMenu_no(), currentPage, feedbackVO.getOwner_id());
	}

	@Override
	public ReviewFeedbackAjaxVO deleteFeedback(FeedbackVO feedbackVO, int currentPage) {
		dao.deleteFeedback(feedbackVO);
		return makeReviewFeedbackAjaxVO(feedbackVO.getMenu_no(), currentPage, feedbackVO.getOwner_id());
	}
	
	@Override
	public ReviewFeedbackAjaxVO selectReviewFeedbackForAjax(int menu_no, int currentPage
			,String member_id) {
		return makeReviewFeedbackAjaxVO(menu_no, currentPage, member_id);
	}
	
	
	
	//DELETE
	@Override
	public void deleteReview(int menu_no, String member_id) {
		HashMap<String,Object> parameters = new HashMap<String,Object>();
		parameters.put("menu_no", menu_no);
		parameters.put("member_id", member_id);
		dao.deleteReview(parameters);	
	}

	
	
	
	
	
	@Override
	public HashMap<String,Integer> calcPage(int currentPage, int menu_no) {
		int reviewCount = dao.selectReviewCount(menu_no);
		
		HashMap<String,Integer> pageMap = new HashMap<String,Integer>();
		int recogNextBlock = 0;
		
		int totalPage = (int) Math.ceil((double)reviewCount/5);     
		int startBlock = (int) Math.ceil((double)currentPage/5);    

		int startPage = (startBlock-1) * 5 + 1;     
		int endPage = 0;          
		
		if(startBlock*5<totalPage) {         
			endPage = startPage+4;           
			recogNextBlock = 1;              
		}else if(startBlock*5>=totalPage) { 
			endPage = startPage + (totalPage - ((startBlock-1) * 5) -1);  
		}
	
		pageMap.put("startPage", startPage);
		pageMap.put("endPage", endPage);
		pageMap.put("recogNextBlock", recogNextBlock);
		
		return pageMap;
	}

	

	

	private ReviewFeedbackAjaxVO makeReviewFeedbackAjaxVO(int menu_no, int currentPage
			,String member_id){
		ReviewFeedbackAjaxVO reviewFeedbackAjaxVO = new ReviewFeedbackAjaxVO();
		
		HashMap<String,Object> parameters = new HashMap<String, Object>();
		int rownum = calcRownum(currentPage); 
		parameters.put("menu_no", menu_no);
		parameters.put("review_end", rownum+4);
		parameters.put("review_start", rownum);
		parameters.put("member_id", member_id);
		
		List<ReviewFeedbackVO> reviewFeedbackList = dao.selectReviewFeedbackList(parameters);
		reviewFeedbackAjaxVO.setReviewFeedbackList(reviewFeedbackList);
		
		HashMap<String,Integer> pageMap = calcPage(currentPage, menu_no); 
		
		reviewFeedbackAjaxVO.setPageMap(pageMap);
		
		
		return reviewFeedbackAjaxVO;
	}
	
	
	private int calcRownum(int currentPage) {
		int rownum = 5 * (currentPage-1) + 1;
		return rownum;
	}


	
}
