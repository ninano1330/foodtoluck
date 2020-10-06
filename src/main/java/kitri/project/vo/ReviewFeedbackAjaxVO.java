package kitri.project.vo;

import java.util.HashMap;
import java.util.List;

public class ReviewFeedbackAjaxVO {
	private List<ReviewFeedbackVO> reviewFeedbackList;
	private HashMap<String,Integer> pageMap;

	public List<ReviewFeedbackVO> getReviewFeedbackList() {
		return reviewFeedbackList;
	}
	public void setReviewFeedbackList(List<ReviewFeedbackVO> reviewFeedbackList) {
		this.reviewFeedbackList = reviewFeedbackList;
	}
	public HashMap<String, Integer> getPageMap() {
		return pageMap;
	}
	public void setPageMap(HashMap<String, Integer> pageMap) {
		this.pageMap = pageMap;
	}
	@Override
	public String toString() {
		return "ReviewFeedbackAjaxVO\n [reviewFeedbackList=\n" + reviewFeedbackList + "\n pageMap=" + pageMap + "]";
	}
	
	
}
