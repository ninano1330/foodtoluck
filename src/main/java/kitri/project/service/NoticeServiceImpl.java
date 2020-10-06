package kitri.project.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kitri.project.dao.NoticeDAO;
import kitri.project.vo.BoardVO;
import kitri.project.vo.NoticeVO;


@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO mainDAO;

	public List<NoticeVO> noticelist() throws Exception{
		return mainDAO.noticelist();
	}
	
	public List<BoardVO> boardlist() throws Exception{
		return mainDAO.boardlist();
	}
	
	public List<NoticeVO> listAll(int start, int end, String searchOption, String keyword)throws Exception{
		return mainDAO.listAll(start, end, searchOption, keyword);
	}
	
		
	public int countArticle(String searchOption, String keyword) throws Exception {
  		return mainDAO.countArticle(searchOption, keyword);
  	}
	
	public void write(NoticeVO vo){
		mainDAO.write(vo);
	}
	
	public NoticeVO read(int notice_no){
		return mainDAO.read(notice_no);
	}
	
	public void update(NoticeVO vo){
		mainDAO.update(vo);
	}
	
	public void delete(int notice_no){
		mainDAO.delete(notice_no);
	}
}
