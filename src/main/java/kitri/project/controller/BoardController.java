package kitri.project.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kitri.project.service.BoardServiceImpl;
import kitri.project.vo.BoardPager;
import kitri.project.vo.BoardVO;
import kitri.project.vo.ReplyVO;

@Controller
public class BoardController {

	@Autowired
	BoardServiceImpl boardservice;
		
	//글작성 화면
	@RequestMapping(value="/boardwrite.action",method=RequestMethod.GET)
	public String write(){
		return "board/writeBoard";
	} 
	
	//글작성 실행
	@RequestMapping(value="/boardinsert.action", method=RequestMethod.GET)
	public String insert(@ModelAttribute BoardVO vo) throws Exception{
		boardservice.write(vo);
		return "redirect:/boardform.action";
	}

	//게시글 상세화면
	@RequestMapping(value="/boardview.action",method=RequestMethod.GET)
	public ModelAndView view(@RequestParam int board_no){
		BoardVO read = boardservice.read(board_no);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/viewBoard");
		mav.addObject("read",read);
		
		return mav;
	}
	
	//게시글 수정화면
	@RequestMapping(value="/boardread.action", method=RequestMethod.GET)
	public ModelAndView read(@RequestParam int board_no){
		BoardVO read = boardservice.read(board_no);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/modifyBoard");
		mav.addObject("read",read);
		
		return mav;
	}
	
	
	//글수정 실행
	@RequestMapping(value="boardupdate.action" , method=RequestMethod.GET)
	public String update(@ModelAttribute BoardVO vo){
		boardservice.update(vo);
		return "redirect:/boardview.action?board_no="+vo.board_no;
	}
	
	//글삭제 실행
	@RequestMapping(value="boarddeleteform.action" , method=RequestMethod.GET)
	public String delete(@RequestParam int board_no){
		boardservice.delete(board_no);
		return "redirect:/boardform.action";
	}
	
	//자유게시판 페이지로 이동
	@RequestMapping("boardform.action")
	public ModelAndView noticeform(@RequestParam(defaultValue="board_title") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage,HttpSession session) throws Exception{

		/*session.setAttribute("id", 1);*/
			// 레코드의 갯수 계산
			int count = boardservice.countArticle(searchOption, keyword);

			// 페이지 나누기 관련 처리
			BoardPager boardPager = new BoardPager(count, curPage);
			int start = boardPager.getPageBegin();
			int end = boardPager.getPageEnd();

			List<BoardVO> boardlist = boardservice.listAll(start, end, searchOption, keyword);

			// 데이터를 맵에 저장
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("boardlist", boardlist); // list
			map.put("count", count); // 레코드의 갯수
			map.put("searchOption", searchOption); // 검색옵션
			map.put("keyword", keyword); // 검색키워드
			map.put("boardPager", boardPager);

			ModelAndView mav = new ModelAndView();
			mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
			mav.setViewName("/board/board"); // 뷰를 list.jsp로 설정

			return mav;
		}
	
	
	//summernote 이미지 업로드
	@ResponseBody
	@RequestMapping(value="boardfile.action", method=RequestMethod.POST)
	public String upload(@RequestParam("file")MultipartFile f,HttpServletRequest request)throws Exception{
			String name =null;
			String fileName=null;
			if(!f.isEmpty() && f.getContentType().startsWith("image")){
				String path = request.getSession().getServletContext().getRealPath("/resources/img/board");
				File dir = new File(path);
				if(!dir.exists()){
					dir.mkdirs();
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String of = f.getOriginalFilename();
				
				
				fileName = sdf.format(System.currentTimeMillis())+"."+of.substring(of.lastIndexOf(".")+1);
				
				File target = new File(dir,fileName);
				f.transferTo(target);
				
				name = request.getContextPath() + "/resources/img/board/"+fileName;
				

			}
		return name;
	}
	
	//댓글 작성
	@ResponseBody
	@RequestMapping(value="replyinsert.action",method=RequestMethod.POST )
	public void reply(@ModelAttribute ReplyVO vo){
		
		boardservice.replyinsert(vo);
	}
	
	//댓글 목록
	@ResponseBody
	@RequestMapping("listJson.action")
    public List<ReplyVO> listJson(@RequestParam int board_no){
        List<ReplyVO> list = boardservice.replylist(board_no);
        return list;
    }
	
	//댓글 삭제
	@RequestMapping("replydelete.action")
	public String replydelete(@RequestParam int bcomment_no,@RequestParam int board_no){
		boardservice.replydelete(bcomment_no,board_no);
		return "redirect:/boardview.action?board_no="+board_no;
	}
	
	
	
}
