package kitri.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kitri.project.vo.TimeLineCommentVO;
import kitri.project.vo.TimeLineVO;

@Component
public class TimeLineDAO {
	
	@Autowired
	SqlSession session;

	public String getOwnerId(int truck_code) {

		return session.selectOne("tl.getOwnerId", truck_code);
	}

	public int getMaxRownum(int truck_code) {

		return session.selectOne("tl.getMaxRownum", truck_code);
	}

	public List<TimeLineVO> getTimeLine(Map<String, Integer> trcdmxrn) {

		return session.selectList("tl.getTimeLine", trcdmxrn);
	}

	public List<TimeLineVO> getTimeLineComment(Map<String, Integer> tlparam) {

		return session.selectList("tl.getTimeLineComment", tlparam);
	}

	public void setTimeline(TimeLineVO vo) {
		
		session.insert("tl.setTimeline", vo);
	}

	public String checkMember(String member_id) {

		return session.selectOne("tl.checkMember", member_id);
	}

	public int mdfSetTimeline(TimeLineVO vo) {
		
		System.out.println("DAO mdfSetTimeline 에서 수정 전 vo"+vo);
		//vo.setTimeline_content("임시 테스트");
		//vo.setTimeline_image("img10.jpg");
		
		return session.update("tl.mdfSetTimeline", vo);
	}

	public TimeLineVO mdfGetTimeline(TimeLineVO vo) {
		vo = session.selectOne("tl.mdfGetTimeline", vo);
		System.out.println("DAO mdfGetTimeline vo = "+vo);
		return vo;
	}

	public TimeLineVO mdfTimelineModal(TimeLineVO vo) {

		return session.selectOne("tl.mdfTimelineModal", vo);
	}

	public int inputComment(TimeLineCommentVO vo) {
		
		int result = session.insert("tl.inputComment", vo);
		System.out.println("DAO : inputComment - insert 결과 = "+result);
		//if(result!=0){
			//이렇게 방금 insert 한 row의 값을 가져올 수 있다.
			System.out.println("DAO : 방금 insert 한 댓글 번호 가져오기 = "+vo.getTcomment_no());
			return vo.getTcomment_no();
		//}else{
		//	return 0;
		//}
	}

	public TimeLineCommentVO getComment(int tcomment_no) {

		return session.selectOne("tl.getComment", tcomment_no);
	}

	public TimeLineCommentVO getCommentContent(TimeLineCommentVO vo) {

		return session.selectOne("tl.getCommentContent", vo);
	}

	public int mdfCommentAj(TimeLineCommentVO vo) {

		return session.update("tl.mdfCommentAj", vo);
	}

	public int delTimeline(TimeLineCommentVO vo) {

		return session.update("tl.delTimeline", vo);
	}

	public void delComment(TimeLineCommentVO vo) {
		
		session.delete("tl.delComment", vo);
	}
	
	public int upDelComment(TimeLineCommentVO vo) {
		
		return session.update("tl.upDelComment", vo);
	}

	public int existLowerComment(TimeLineCommentVO vo) {

		return session.selectOne("tl.existLowerComment", vo);
	}

	public int getMaxTimeLineNo(int truck_code) {

		return session.selectOne("tl.getMaxTimeLineNo", truck_code);
	}
}
