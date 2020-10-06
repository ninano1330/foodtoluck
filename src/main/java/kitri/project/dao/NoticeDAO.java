package kitri.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kitri.project.vo.BoardVO;
import kitri.project.vo.NoticeVO;

@Repository("mainDAO")
public class NoticeDAO {

	@Autowired
	SqlSession session;
	
	
	public List<NoticeVO> listAll(int start, int end, String searchOption, String keyword) throws Exception {
	    // �??��?��?��, ?��?��?�� 맵에 ???��
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("searchOption", searchOption);
	    map.put("keyword", keyword);
	    // BETWEEN #{start}, #{end}?�� ?��?��?�� 값을 맵에 
	    map.put("start", start);
	    map.put("end", end);
	    return session.selectList("main.listAll", map);
	}
	
	public List<BoardVO> boardlist() throws Exception {
	    // �??��?��?��, ?��?��?�� 맵에 ???��
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    return session.selectList("main.boardlist", map);
	}
	
	public List<NoticeVO> noticelist() throws Exception {
	    // �??��?��?��, ?��?��?�� 맵에 ???��
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    return session.selectList("main.noticelist", map);
	}
	
	public int countArticle(String searchOption, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
  		map.put("searchOption", searchOption);
  		map.put("keyword", keyword);
		return session.selectOne("main.countArticle", map);
		
	}

	
	public void write(NoticeVO vo){
		session.insert("main.write",vo);
	}
	
	public NoticeVO read(int notice_no){
		NoticeVO read = session.selectOne("main.read", notice_no);
		return read;
	}
	
	public void update(NoticeVO vo){
		session.update("main.update", vo);
	}
	
	public void delete(int notice_no){
		session.delete("main.delete", notice_no);
	}
	
	

}
