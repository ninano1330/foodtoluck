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

import kitri.project.service.NoticeServiceImpl;
import kitri.project.vo.BoardPager;
import kitri.project.vo.BoardVO;
import kitri.project.vo.NoticeVO;


@Controller
public class NoticeController {
	

	@Autowired
	NoticeServiceImpl service;
	
	//글작성 화면
	@RequestMapping(value="/write.action",method=RequestMethod.GET)
	public String write(){
		return "/notice/writeNotice";		
	} 
	
	//글작성 실행
	@RequestMapping(value="/insert.action", method=RequestMethod.GET)
	public String insert(@ModelAttribute NoticeVO vo){
		service.write(vo);
		return "redirect:/noticeform.action";
	}

	//게시글 상세화면
	@RequestMapping(value="/view.action",method=RequestMethod.GET)
	public ModelAndView view(@RequestParam int notice_no){
		NoticeVO read = service.read(notice_no);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("notice/viewNotice");
		mav.addObject("read",read);
		
		return mav;
	}
	
	//게시글 수정
	@RequestMapping(value="/read.action", method=RequestMethod.GET)
	public ModelAndView read(@RequestParam int notice_no){
		NoticeVO read = service.read(notice_no);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("notice/modifyNotice");
		mav.addObject("read",read);
		
		return mav;
	}
	
	//글수정 실행
	@RequestMapping(value="/update.action" , method=RequestMethod.GET)
	public String update(@ModelAttribute NoticeVO vo){
		service.update(vo);
		return "redirect:/noticeform.action";
	}
	
	//글삭제 실행
	@RequestMapping(value="deleteform.action" , method=RequestMethod.GET)
	public String delete(@RequestParam int notice_no){
		service.delete(notice_no);
		return "redirect:/noticeform.action";
	}
	
	//공지사항페이지로 이동
	@RequestMapping("noticeform.action")
	public ModelAndView noticeform(@RequestParam(defaultValue="notice_title") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage,HttpSession session) throws Exception{

			// 레코드의 갯수 계산
			int count = service.countArticle(searchOption, keyword);

			
			// 페이지 나누기 관련 처리
			BoardPager boardPager = new BoardPager(count, curPage);
			int start = boardPager.getPageBegin();
			int end = boardPager.getPageEnd();

			List<NoticeVO> list = service.listAll(start, end, searchOption, keyword);

			// 데이터를 맵에 저장
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list); // list
			map.put("count", count); // 레코드의 갯수
			map.put("searchOption", searchOption); // 검색옵션
			map.put("keyword", keyword); // 검색키워드
			map.put("boardPager", boardPager);

			ModelAndView mav = new ModelAndView();
			mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
			mav.setViewName("notice/notice"); // 뷰를 list.jsp로 설정

			return mav;
		}
	
	//사진 업로드
	@ResponseBody
	@RequestMapping(value="file.action", method=RequestMethod.POST)
	public String upload(@RequestParam("file")MultipartFile f,HttpServletRequest request)throws Exception{
			String name =null;
			String fileName=null;
			if(!f.isEmpty() && f.getContentType().startsWith("image")){
				String path = request.getSession().getServletContext().getRealPath("/resources/img/notice");

				File dir = new File(path);
				if(!dir.exists()){
					dir.mkdirs();
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String of = f.getOriginalFilename();
				
				
				fileName = sdf.format(System.currentTimeMillis())+"."+of.substring(of.lastIndexOf(".")+1);
				
				File target = new File(dir,fileName);
				f.transferTo(target);
				
				name = request.getContextPath() + "/resources/img/notice/"+fileName;

			}
		return name;
	}
}
