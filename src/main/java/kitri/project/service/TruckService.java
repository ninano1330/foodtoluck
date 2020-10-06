package kitri.project.service;

import java.util.List;

import kitri.project.vo.FoodTypeVO;
import kitri.project.vo.FoodtruckVO;

public interface TruckService {
	
	//전체 트럭 조회
	List<FoodtruckVO> getAllTruck();
	
	List<FoodtruckVO> getSearchTruck(FoodtruckVO vo);
	
	int InsertTruck(FoodtruckVO vo);
	
	int getTruckCode(FoodtruckVO vo);
	
	List<FoodTypeVO> getFoodType();
	
	boolean insertMenuType(int menuValue, int truckCode);
	public void deleteMenutype(int truck_code);
	List<String> getFoodName(int truck_code);
}
