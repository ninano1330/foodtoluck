package kitri.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kitri.project.service.FoodtruckService;
import kitri.project.service.TruckServiceImpl;
import kitri.project.vo.FoodTypeVO;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.Foodtruck_FoodTypeVO;
import kitri.project.vo.MemberVO;

@Controller
public class TruckController {
	
	
	@Autowired
	TruckServiceImpl service;
	@Autowired
	FoodtruckService foodtruckService;
	@Resource
	HttpSession session;
	
	@RequestMapping("alltruck.mybatis")
	public ModelAndView getAllTruck(){
		
		List<FoodtruckVO> list = service.getAllTruck();
		ModelAndView mav = new ModelAndView();
		mav.addObject("alltrucklist", list);//c태그에 쓸 items 이름을 alltrucklist 로 하고..
		mav.setViewName("alltruck");//view로 쓸 jsp 파일명은 alltruck.jsp 로 하기
		return mav;
	}
	
//	@RequestMapping(value="searchtruck.mybatis", method=RequestMethod.GET)
//	public String getSearchForm(){
//		return "main/main3";
//	}
	
	@RequestMapping(value="searchtruck.mybatis", method=RequestMethod.GET)
	   public ModelAndView getSearchTruck(String searchkeyword, String lat, String lng, FoodtruckVO vo, @RequestParam(required=false) String re_searchkeyword){
	    System.out.println("searchkeyword = " + searchkeyword);  
		System.out.println("re_searchkeywork = " + re_searchkeyword);
	      ModelAndView mav = new ModelAndView();
	      
	      
	      /*if(menu_type != null && searchkeyword != null){
	         System.out.println("menu type : "+menu_type);
	         System.out.println("키워드 : "+searchkeyword);
	         
	         mav.addObject("lat", lat);
	         mav.addObject("lng", lng);
	         mav.addObject("searchkeyword", searchkeyword);
	      }*/
	      
	      
	         //vo.setTruck_name("%"+searchkeyword+"%");
	         if(re_searchkeyword != null){
	            vo.setAddress_full("%"+re_searchkeyword+"%");
	         }else{
	            vo.setAddress_full("%"+searchkeyword+"%");
	         }
	         
	         
	         List<FoodtruckVO> list = service.getSearchTruck(vo);
	         //List<String> foodlist = new ArrayList<String>();
	         List<Foodtruck_FoodTypeVO> foodlist = new ArrayList<Foodtruck_FoodTypeVO>();
	         
	         for(FoodtruckVO voo : list){
	        	System.out.println("name  = " + voo.getTruck_name());
	        	System.out.println("image = " + voo.getTruck_image());
	            List<String> foodname = service.getFoodName(voo.getTruck_code());
	            String temp = "";
	            for(String name : foodname){
	                  temp += name+" ";
	            }
	            Foodtruck_FoodTypeVO tf = new Foodtruck_FoodTypeVO(voo.getTruck_code(), temp);
	            foodlist.add(tf);
	            //foodlist.add(temp);
	         }
	         
	         
	         
	         mav.addObject("searchtrucklist", list);         
	         mav.addObject("lat", lat);
	         mav.addObject("lng", lng);
	         mav.addObject("searchkeyword", searchkeyword);
	         //mav.setViewName("searchtruck");
	         
	         mav.addObject("foodlist",foodlist);
	         
	         //mav.setViewName("search_result");
	         //mav.setViewName("search_result2");
	         //mav.setViewName("search_result3");
	         mav.setViewName("search_result/search_result4");
	      
	      
	      return mav;
	      
	   }
	
	@RequestMapping(value="inserttruck.mybatis", method=RequestMethod.GET)
	public ModelAndView getInsertForm(){
		
		List<FoodTypeVO> foodlist = service.getFoodType();
		for(FoodTypeVO vo : foodlist){
			//System.out.println(vo.getFoodtype_code() + " : " + vo.getFoodtype_name());
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("foodlist", foodlist);
		mav.setViewName("inserttruck");
		return mav;
	}
	
	@RequestMapping(value="inserttruck.mybatis", method=RequestMethod.POST)
	public String getInsertTruck(FoodtruckVO vo, @RequestParam(required=true) List<Integer> MenuCheckbox){
		
		
		for(int Menuvalue : MenuCheckbox){
			System.out.println("넘어온 메뉴 타입: " + Menuvalue);
		}
		
		
		int aa = service.InsertTruck(vo);
		if(aa==1){//트럭정보가 잘 삽입되었다면
			int truckCode = service.getTruckCode(vo);//트럭 코드 가져오기
			if(truckCode != 0){
				for(int Menuvalue : MenuCheckbox){
					if(service.insertMenuType(Menuvalue,truckCode)){
						System.out.println("메뉴타입 삽입 성공");
					}else{
						System.out.println("메뉴타입 삽입 실패");
					}
				}
				return "redirect:inserttruck.mybatis";
			}
		}
		

		return "redirect:inserttruck.mybatis";
	}
}
