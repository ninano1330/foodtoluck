package kitri.project.service;

import java.util.HashMap;
import java.util.List;

import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.Foodtruck_FoodTypeVO;

public interface FoodtruckService {
	
	public List<FoodtruckVO> selectAllTruck(String ownerId);
	public FoodtruckVO selectTruck(int truck_code);
	public int insertTruck(FoodtruckVO vo);
	public int updateTruck(FoodtruckVO vo);
	public int deleteTruck(int truck_code);	
	public List<Foodtruck_FoodTypeVO> getThistruckFoodtype(int truck_code);
	public int isFavorite(HashMap<String, Object> map);
	public String imageUpload(FoodtruckVO vo) throws Exception;
	public List<FoodtruckVO> selectFavoriteFT(String userId);
}
