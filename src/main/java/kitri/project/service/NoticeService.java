package kitri.project.service;

import java.util.List;

import kitri.project.vo.BoardVO;
import kitri.project.vo.NoticeVO;

public interface NoticeService {
	
	public List<NoticeVO> listAll(int start, int end, String searchOption, String keyword)throws Exception;

	public void write(NoticeVO vo) throws Exception;
	
	public NoticeVO read(int notice_no);

	public List<NoticeVO> noticelist() throws Exception;

	public List<BoardVO> boardlist() throws Exception;
	
}
