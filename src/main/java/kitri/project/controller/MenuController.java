package kitri.project.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kitri.project.service.FoodtruckServiceImpl;
import kitri.project.service.MemberService;
import kitri.project.service.MenuServiceImpl;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.MemberMenuVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.MenuVO;

@Controller
public class MenuController {
	
	@Autowired
	MenuServiceImpl menuService;
	
	@Autowired
	FoodtruckServiceImpl foodtruckService;
	
	@Autowired
	MemberService memberService;
	
	
	
	@RequestMapping("truck.menu")
	public ModelAndView truckMenu(int truck_code, HttpSession session){
		ModelAndView m = new ModelAndView();
		String userId = null;
		if((MemberVO) session.getAttribute("sessionId") !=null) {
			userId = ((MemberVO) session.getAttribute("sessionId")).getMember_id();
		}
		
		List<MenuVO> list = menuService.selectAllMenu(truck_code);
		
		List<MemberMenuVO> memberMenu = null;
		
		if(userId !=null) {
			memberMenu = memberService.selectMemberMenu(userId);
			for(MenuVO menuVO : list) {
				for(MemberMenuVO memberMenuVO : memberMenu) {
					if(menuVO.getMenu_no() == memberMenuVO.getMenu_no()) {
						menuVO.setUser_like("like");
						break;
					}
				}
			}
		}
		
		m.addObject("allMenu", list);
		m.addObject("truck_code", truck_code);
		m.addObject("includeViewName","../menu/truck_menu.jsp" );
		m.setViewName("forward:foodtruck?truck_code="+truck_code);
		
		return m;
	}
	
	@RequestMapping(value="addMenu",method=RequestMethod.POST)
	public String addMenu(MenuVO vo, int truck_code, RedirectAttributes ra) throws Exception{
		vo.setMenu_image(menuService.imageUpload(vo));
		menuService.insertMenu(vo);
		System.out.println(vo.getMenu_origin());
		ra.addAttribute("truck_code", truck_code);
		return "redirect:truck.menu";
	}
	
	@RequestMapping(value="modifyMenu", method=RequestMethod.POST)
	 public String updateFoodtruck(MenuVO vo,int truck_code, RedirectAttributes ra) throws Exception{
		vo.setMenu_image(menuService.imageUpload(vo));
		menuService.updateMenu(vo);
		ra.addAttribute("truck_code", truck_code);
		return "redirect:truck.menu";
	} 
	
	@ResponseBody
	@RequestMapping(value="deleteMenu", method=RequestMethod.POST)
	 public int deleteFoodtruck(int menu_no,int truck_code, RedirectAttributes ra){	
		ra.addAttribute("truck_code", truck_code);
		return menuService.deleteMenu(menu_no);
	}
}
