package kitri.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kitri.project.vo.FoodTypeVO;
import kitri.project.vo.FoodtruckVO;



//DAO - 매핑파일 실행
//MAIN출력, 파라미터 전송
@Component
public class TruckDAO {
	
	@Autowired
	SqlSession session;
	
	public void setSession(SqlSession ss){
		session = ss;
	}
	
	public List<FoodtruckVO> getAllTruck(){
		List<FoodtruckVO> list = session.selectList("Foodtruck.all");
		
		return list;
	}
	
	public List<FoodtruckVO> getSearchTruck(FoodtruckVO vo){
		//System.out.println(vo);
		return session.selectList("Foodtruck.searchtruck", vo);
	}
	
	public int InsertTruck(FoodtruckVO vo){
		return session.insert("Foodtruck.insertTruck", vo);
	}
	
	public int getTruckCode(FoodtruckVO vo){
		int result = session.selectOne("Foodtruck.gettruckcode", vo);
		return result;
	}
	
	public List<FoodTypeVO> getFoodType(){
		List<FoodTypeVO> foodtypelist = session.selectList("Foodtruck.getfoodtype");
		
		return foodtypelist;
	}
	
	public int insertMenuType(Map<String,Integer> temp){
		return session.insert("Foodtruck.insertmenutype", temp);
	}
	
	public List<String> getFoodName(int truck_code){
		return session.selectList("Foodtruck.getfoodname", truck_code);
	}

	public void deleteMenutype(int truck_code) {
		session.delete("Foodtruck.deleteMenutype", truck_code);
	}
	
	
}
