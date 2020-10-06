package kitri.project.service;

import java.util.List;

import kitri.project.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword)throws Exception;

	public void write(BoardVO vo) throws Exception;
	
	public BoardVO read(int board_no);
	
}
