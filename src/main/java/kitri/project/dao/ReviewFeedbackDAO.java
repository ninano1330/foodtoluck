package kitri.project.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kitri.project.vo.FeedbackVO;
import kitri.project.vo.MenuVO;
import kitri.project.vo.ReviewFeedbackVO;
import kitri.project.vo.ReviewVO;

@Repository
public class ReviewFeedbackDAO {
	@Autowired
	SqlSession session;
	
	//SELECT
	public MenuVO selectDetailedMenu(int menu_no){
		MenuVO menuVO = session.selectOne("review.selectDetailedMenu",menu_no);
		return menuVO;
	}
	
	public void insertReview(ReviewVO reviewVO) {

		session.insert("review.insertReview",reviewVO);
	}
	
	public ReviewFeedbackVO selectMyReview(HashMap<String,Object> parameters) {
		ReviewFeedbackVO myReview = session.selectOne("review.selectMyReview",parameters);
		return myReview;
	}
	
	public List<ReviewFeedbackVO> selectReviewFeedbackList(HashMap<String,Object> parameters){
		List<ReviewFeedbackVO> reviewFeedbackList = session.selectList("review.selectReviewFeedbackList",parameters);

		return reviewFeedbackList;
	}
	
	
	public int selectReviewCount(int menu_no) {
		int reviewCount = session.selectOne("review.selectReviewCount",menu_no);
		return reviewCount;
	}
	
	public int selectCheckReview(ReviewVO reviewVO){
		System.out.println("dao 시작");
		int checkReview = session.selectOne("review.selectCheckReview",reviewVO);
		System.out.println("dao 끝");
		return checkReview;
	}
	
	public double selectAvgStar(int menu_no){
		double avgStar = 0;
		if(session.selectOne("review.selectAvgStar",menu_no)==null){
			return avgStar;
		}else{
			avgStar = session.selectOne("review.selectAvgStar",menu_no);
			return avgStar;
		}
	}
	

	public String selectOwnerId(int menu_no) {
		String owner_id = session.selectOne("review.selectOwnerId",menu_no);
		return owner_id;
	}
	
	
	//INSERT
	public void insertFeedback(FeedbackVO feedbackVO){
		session.insert("feedback.insertFeedback",feedbackVO);
	}
	
	
	//DELETE
	public void deleteReview(HashMap<String,Object> parameters) {
		session.delete("review.deleteReview",parameters);
	}
	
	public void deleteFeedback(FeedbackVO feedbackVO) {
		session.delete("feedback.deleteFeedback",feedbackVO);
	}

}
