package kitri.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kitri.project.dao.BoardDAO;
import kitri.project.vo.BoardVO;
import kitri.project.vo.ReplyVO;

@Service("boardservice")
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword)throws Exception{
		return boardDAO.listAll(start, end, searchOption, keyword);
	}
	
	public int countArticle(String searchOption, String keyword) throws Exception {
  		return boardDAO.countArticle(searchOption, keyword);
  	}
	
	public void write(BoardVO vo){
		boardDAO.write(vo);
	}
	
	public BoardVO read(int board_no){
		return boardDAO.read(board_no);
	}
	
	public void update(BoardVO vo){
		boardDAO.update(vo);
	}
	
	public void delete(int board_no){
		boardDAO.delete(board_no);
	}
	
	public void replyinsert(ReplyVO vo){
		boardDAO.replyinsert(vo);
	}
	
	public List<ReplyVO> replylist(int board_no){
		return boardDAO.replylist(board_no);
	}
	
	public void replydelete(int bcomment_no,int board_no){
		boardDAO.replydelete(bcomment_no,board_no);
	}
	
}
