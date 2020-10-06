package kitri.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kitri.project.dao.TruckDAO;
import kitri.project.vo.FoodTypeVO;
import kitri.project.vo.FoodtruckVO;

@Service("service")
public class TruckServiceImpl implements TruckService{

	@Autowired
	TruckDAO truckDAO;
	
	@Override
	public List<FoodtruckVO> getAllTruck(){
		
		return truckDAO.getAllTruck();
	}
	
	public List<FoodtruckVO> getSearchTruck(FoodtruckVO vo){
		return truckDAO.getSearchTruck(vo);
	}
	
	public int InsertTruck(FoodtruckVO vo){
		return truckDAO.InsertTruck(vo);
	}
	
	public int getTruckCode(FoodtruckVO vo){
		return truckDAO.getTruckCode(vo);
	}
	
	public List<FoodTypeVO> getFoodType() {
		return truckDAO.getFoodType();
	}

	public boolean insertMenuType(int menuValue, int truckCode) {
		Map<String,Integer> temp = new HashMap<String,Integer>();
		temp.put("truck_code", truckCode);
		temp.put("foodtype_code", menuValue);
		return (truckDAO.insertMenuType(temp)==1)?true:false;
	}

	public List<String> getFoodName(int truck_code) {
		return truckDAO.getFoodName(truck_code);
	}

	public void deleteMenutype(int truck_code) {
		truckDAO.deleteMenutype(truck_code);
	}
		
}
