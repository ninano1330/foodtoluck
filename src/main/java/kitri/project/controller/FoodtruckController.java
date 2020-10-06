package kitri.project.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kitri.project.service.FoodtruckServiceImpl;
import kitri.project.service.TruckServiceImpl;
import kitri.project.vo.FoodTypeVO;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.Foodtruck_FoodTypeVO;
import kitri.project.vo.MemberVO;

@Controller
public class FoodtruckController {

	@Autowired
	FoodtruckServiceImpl foodtruckService;
	
	@Autowired
	TruckServiceImpl service;
	
	
	@RequestMapping(value="truckCondition", method=RequestMethod.GET)
	public ModelAndView truckCondition(HttpSession session){
		ModelAndView m = new ModelAndView();
		String ownerId = ((MemberVO) session.getAttribute("sessionId")).getMember_id();
		List<FoodtruckVO> list = foodtruckService.selectAllTruck(ownerId);
		
		List<Foodtruck_FoodTypeVO> foodlist = new ArrayList<Foodtruck_FoodTypeVO>();
		
		for(FoodtruckVO truckVO : list){
			List<String> foodname = service.getFoodName(truckVO.getTruck_code());
			String temp = "";
			for(String name : foodname){
					temp += name+" ";
			}
			System.out.println("음식 이름: "+temp);
			Foodtruck_FoodTypeVO tf = new Foodtruck_FoodTypeVO(truckVO.getTruck_code(), temp);
			foodlist.add(tf);
			//foodlist.add(temp);
		}
		//System.out.println(list.get(0).toString());
		m.addObject("Alltruck", list);
		m.addObject("foodlist",foodlist);
		m.setViewName("mypage/owner_truckCondition");
		return m;
	}
	
	@RequestMapping(value="addTruck", method=RequestMethod.GET)
	public ModelAndView addTruckView(){	
		ModelAndView m = new ModelAndView();
		List<FoodTypeVO> foodlist = service.getFoodType();
		System.out.println(foodlist);
		m.addObject("foodlist", foodlist);
		m.setViewName("mypage/addTruck");
		return m;	
	}
	
	@RequestMapping(value="addTruck", method=RequestMethod.POST)
	public String addTruck(FoodtruckVO vo, HttpSession session,@RequestParam(required=true) List<Integer> MenuCheckbox) throws Exception{
		String owner_id = ((MemberVO)session.getAttribute("sessionId")).getMember_id();
		System.out.println("owner_id = " + owner_id);
		
		vo.setOwner_id(((MemberVO)session.getAttribute("sessionId")).getMember_id());
		if(!foodtruckService.imageUpload(vo).equals("")) {
			vo.setTruck_image(foodtruckService.imageUpload(vo));
		}
		
		int isInsert = foodtruckService.insertTruck(vo);
		if(isInsert==1){//트럭정보가 잘 삽입되었다면
			int truckCode = service.getTruckCode(vo);//트럭 코드 가져오기
			if(truckCode != 0){
				for(int Menuvalue : MenuCheckbox){
					if(service.insertMenuType(Menuvalue,truckCode)){
						System.out.println("메뉴타입 삽입 성공");
					}else{
						System.out.println("메뉴타입 삽입 실패");
					}
				}
			}
		}
		
		return "redirect:truckCondition";	
	}
	
	@RequestMapping(value="modifyTruck", method=RequestMethod.GET)
	public ModelAndView updateFoodtruckView(int truck_code){
		ModelAndView m = new ModelAndView();
		List<FoodTypeVO> allTypelist = service.getFoodType();
		
		List<String> typeList = service.getFoodName(truck_code);
		
		FoodtruckVO vo = foodtruckService.selectTruck(truck_code);
		
		m.addObject("foodtruck", vo);
		m.addObject("allTypelist", allTypelist);
		m.addObject("typelist", typeList);
		m.setViewName("mypage/modifyTruck");
		return m;
	}
	
	@RequestMapping(value="modifyTruck", method=RequestMethod.POST)
	public String updateFoodtruck(FoodtruckVO vo,@RequestParam(required=true) List<Integer> MenuCheckbox) throws Exception{
		vo.setTruck_image(foodtruckService.imageUpload(vo));
		foodtruckService.updateTruck(vo);
		service.deleteMenutype(vo.getTruck_code());
		for(int Menuvalue : MenuCheckbox){
			if(service.insertMenuType(Menuvalue,vo.getTruck_code())){
				System.out.println("메뉴타입 수정 성공");
			}else{
				System.out.println("메뉴타입 수정 실패");
			}
		}
		return "redirect:truckCondition";
	}
	
	@ResponseBody
	@RequestMapping(value="deleteTruck", method=RequestMethod.POST)
	 public int deleteFoodtruck(int truck_code){	
      return foodtruckService.deleteTruck(truck_code);
	}
	
	@RequestMapping("favorite")
	public ModelAndView favoriteTruck(HttpSession session){
		ModelAndView m = new ModelAndView();
		String userId = ((MemberVO) session.getAttribute("sessionId")).getMember_id();
		List<FoodtruckVO> favoriteFoodtruck = foodtruckService.selectFavoriteFT(userId);
		
		List<Foodtruck_FoodTypeVO> foodlist = new ArrayList<Foodtruck_FoodTypeVO>();
		
		for(FoodtruckVO truckVO : favoriteFoodtruck){
			List<String> foodname = service.getFoodName(truckVO.getTruck_code());
			String temp = "";
			for(String name : foodname){
					temp += name+" ";
			}
			System.out.println("음식 이름: "+temp);
			Foodtruck_FoodTypeVO tf = new Foodtruck_FoodTypeVO(truckVO.getTruck_code(), temp);
			foodlist.add(tf);
			//foodlist.add(temp);
		}
		m.addObject("foodlist",foodlist);
		m.addObject("favoriteFoodtruck", favoriteFoodtruck);
		if(((MemberVO) session.getAttribute("sessionId")).getMember_code().equalsIgnoreCase("u")){
			m.setViewName("mypage/user_favorite");
		}else{
			m.setViewName("mypage/owner_favorite");
		}
		return m;
	}
}
