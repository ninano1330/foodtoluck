package kitri.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kitri.project.service.FoodtruckService;
import kitri.project.service.TimeLineService;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.TimeLineCommentVO;
import kitri.project.vo.TimeLineVO;

@Controller
public class TimeLineController {
	
	//한 화면에 타임라인 10개를 보고싶으면 인덱스 9 까지 ㅇㅋ?
	public static final int gapTimeLine = 9;
	
	@Autowired
	TimeLineService timeLineService;
	@Autowired
	FoodtruckService foodtruckService;
	@Resource
	HttpSession session;
	
	@RequestMapping(value="foodtruck", method=RequestMethod.GET)
	public String foodtruck(int truck_code, Model model){
		FoodtruckVO foodtruck = foodtruckService.selectTruck(truck_code);
		String userId = "";
		if(session.getAttribute("sessionId") !=null && !session.getAttribute("sessionId").equals("")){
			
			userId = ((MemberVO) session.getAttribute("sessionId")).getMember_id();
		}
		
		boolean isFavorite = false;
		boolean isOwner=false;
		
		if(!userId.equals(null) && !userId.equals("") && userId.equals(foodtruck.getOwner_id())) isOwner=true;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId",userId);
		map.put("truck_code",truck_code);
		if(foodtruckService.isFavorite(map)==1) isFavorite=true;
		
		model.addAttribute("isOwner", isOwner);
		model.addAttribute("isFavorite", isFavorite);
		model.addAttribute("truck_code",truck_code);
		model.addAttribute("foodtruck",foodtruck);
		
		return "main/foodtruck_main"; 
	}
	
	//타임라인 불러오기 전 화면세팅(필요한 변수들 가져오기. 사장아이디, 트럭코드, 타임라인 갯수 등)
	@RequestMapping(value="timelines", method=RequestMethod.GET)
	public String begintTimeLine(int truck_code, ModelMap model){
		FoodtruckVO foodtruck = foodtruckService.selectTruck(truck_code);

		session.setAttribute("ownerId", foodtruck.getOwner_id());
		session.setAttribute("ownerId", timeLineService.getOwnerId(truck_code));
		
		int maxRownum = timeLineService.getMaxRownum(truck_code);

		model.addAttribute("maxRownum", maxRownum);
		model.addAttribute("includeViewName", "timeline.jsp");


		return "forward:foodtruck?truck_code="+truck_code;
	}
	
	//타임라인 불러오기
	@RequestMapping("getTimeline")
	@ResponseBody
	public Map<String, Object> getTimeline(int truck_code, int maxRownum){
		Map<String, Integer> trcdmxrn = new HashMap<>();
		trcdmxrn.put("truck_code", truck_code);
		trcdmxrn.put("maxRownum", maxRownum);
		trcdmxrn.put("minRownum", maxRownum-gapTimeLine);

		List<TimeLineVO> TLlist = timeLineService.getTimeLine(trcdmxrn);
//		System.out.println("TLlist = "+TLlist);
//		for (TimeLineVO c : TLlist) {
//			
//			System.out.println("리스트 담긴 vo = "+c);
//		}
		//댓글을 가져오기위해서 위에 미리 불러온 타임라인 리스트에서 최대번호와 최소번호를 가져간다.
		//불러온 타임라인 갯수 TLlist.size()-1 이 가장 마지막 인덱스 
		int max_tlno = timeLineService.getMaxTimeLineNo(truck_code);
		int min_tlno = 0;
		if(maxRownum > 1){
			max_tlno = TLlist.get(0).getTimeline_no();
			min_tlno = TLlist.get(TLlist.size()-1).getTimeline_no();
		}
		
		Map<String, Integer> tlparam = new HashMap<>();
		tlparam.put("truck_code", truck_code);
		tlparam.put("max_tlno", max_tlno);
		tlparam.put("min_tlno", min_tlno);
		
		List<TimeLineVO> TClist = timeLineService.getTimeLineComment(tlparam);
		
		Map<String, Object> result = new HashMap<>();
		result.put("TLlist", TLlist);
		result.put("TClist", TClist);
		
		return result;
	}

	//타임라인 저장 입력 작성
	@RequestMapping(value="setTimeline", method=RequestMethod.POST)
	public String setTimeline(TimeLineVO vo, HttpSession session, RedirectAttributes redirectAttributes){
		//System.out.println("컨트롤러 setTimeline - 세션 확인하기 = "+(MemberVO)(session.getAttribute("sessionId")));
		//MemberVO memberVO = (MemberVO)(session.getAttribute("sessionId"));
		MemberVO memberVO = (MemberVO)(session.getAttribute("sessionId"));
		
		//세션에서 로그인한 아이디 가져오기
		vo.setMember_id(memberVO.getMember_id());

		
		try {
			timeLineService.setTimeline(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		redirectAttributes.addAttribute("truck_code", vo.getTruck_code());
		
		return "redirect:timelines";
	}
	
	
	
	@ResponseBody
	@RequestMapping("mdfTimelineModal")
	public TimeLineVO mdfTimelineModal(TimeLineVO vo){
		
		return timeLineService.mdfTimelineModal(vo);
	}
	
	
	
	@ResponseBody
	@RequestMapping("mdfTimeline")
	public TimeLineVO mdfTimeline(TimeLineVO vo, HttpSession session){
		
		//truck_code, timeline_no가 담겨있는 상태. 추가로 member_id 를 세션에서 얻어와 vo에 넣고, 쿼리까지 들고가서 비교해야한다.
		MemberVO mo = (MemberVO)(session.getAttribute("sessionId"));
		vo.setMember_id(mo.getMember_id());
		
		TimeLineVO ro = new TimeLineVO();
		ro.setTimeline_content("이게 남아있으면 저장 안된거임");
		try {
			ro = timeLineService.mdfTimeline(vo);
			System.out.println("업뎃 결과 ro = "+ro);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("return 할  결과 ro = "+ro);
		return ro;
	}
	
	
	@ResponseBody
	@RequestMapping("inputComment1")
	public TimeLineCommentVO inputComment(TimeLineCommentVO vo){
		
		System.out.println("컨트롤러 writeComment 입력받은 = "+vo);

		TimeLineCommentVO co = timeLineService.inputComment(vo);
		
		System.out.println("컨트롤러 writeComment 세션아이디 저장 후 = "+co);
		
		return co;
	}
	
	
	@ResponseBody                         //ajax 쓸 때 문자열이 깨지면  produces="application/text; charset=utf8" 추가(text 또는 json)
	@RequestMapping("mdfCommentModal")
	public TimeLineCommentVO mdfCommentModal(TimeLineCommentVO vo){
		System.out.println("컨-mdfCommentModal-받은 댓글 vo"+vo);
		
		return timeLineService.getCommentContent(vo);
	}
	
	
	@ResponseBody
	@RequestMapping("mdfCommentAj")
	public TimeLineCommentVO mdfCommentAj(TimeLineCommentVO vo){
	
		return timeLineService.mdfCommentAj(vo);
	}
	
	
	@ResponseBody
	@RequestMapping("delTimeline")
	public int delTimeline(TimeLineCommentVO vo){
		
		return timeLineService.delTimeline(vo);
	}
	
	
	@ResponseBody
	@RequestMapping("delComment")
	public int delComment(TimeLineCommentVO vo){
		
		System.out.println("컨트롤러 delComment 받은 vo = "+ vo);
		return timeLineService.delComment(vo);
	}
	
	
	
	
}