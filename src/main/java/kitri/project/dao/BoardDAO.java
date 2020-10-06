package kitri.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kitri.project.vo.BoardVO;
import kitri.project.vo.ReplyVO;

@Repository("boardDAO")
public class BoardDAO {

	@Autowired
	SqlSession session;
	
	
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword) throws Exception {
	    // 검색옵션, 키워드 맵에 저장
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("searchOption", searchOption);
	    map.put("keyword", keyword);
	    // BETWEEN #{start}, #{end}에 입력될 값을 맵에 
	    map.put("start", start);
	    map.put("end", end);
	    return session.selectList("board.listAll", map);
	}
	
	public int countArticle(String searchOption, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
  		map.put("searchOption", searchOption);
  		map.put("keyword", keyword);
		return session.selectOne("board.countArticle", map);
		
	}

	
	public void write(BoardVO vo){
		session.insert("board.write",vo);
	}
	
	public BoardVO read(int board_no){
		BoardVO read = session.selectOne("board.read", board_no);
		return read;
	}
	
	public void update(BoardVO vo){
		session.update("board.update", vo);
	}
	
	public void delete(int board_no){
		session.delete("board.delete", board_no);
	}
	
	public void replyinsert(ReplyVO vo){
		session.insert("board.replyinsert",vo);
	}
	
	public List<ReplyVO> replylist(int board_no){
		return session.selectList("board.replylist", board_no);
	}
	
	public void replydelete(int bcomment_no,int board_no){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bcomment_no", bcomment_no);
		map.put("board_no", board_no);
		session.delete("board.replydelete", map);
	}

}
