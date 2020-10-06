package kitri.project.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.Foodtruck_FoodTypeVO;

@Component
public class FoodtruckDAO {
	
	@Autowired
	SqlSession session;
	
	public List<FoodtruckVO> selectAllFoodtruck(String ownerId){
		return session.selectList("Foodtruck.selectAllFoodtruck",ownerId);
	}

	public int insertTruck(FoodtruckVO vo) {
		return session.insert("Foodtruck.insertTruck", vo);
	}

	public int updateTruck(FoodtruckVO vo) {
		return session.update("Foodtruck.updateTruck",vo);
	}

	public int deleteTruck(int truck_code) {
		return session.delete("Foodtruck.deleteTruck",truck_code);
	}

	public int isFavorite(HashMap<String, Object> map) {
		return session.selectOne("Foodtruck.isFavorite", map);
	}

	public FoodtruckVO selectFoodtruck(int truck_code) {
		return session.selectOne("Foodtruck.selectFoodtruck", truck_code);
	}

	public List<Foodtruck_FoodTypeVO> getThistruckFoodtype(int truck_code) {
		return session.selectList("Foodtruck.getThistruckFoodtype", truck_code);
	}

	public List<FoodtruckVO> selectFavoriteFT(String userId) {
		return session.selectList("Foodtruck.selectFavoriteFT",userId);
	}
}
