package kitri.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.MenuVO;

@Component
public class MenuDAO {
	
	@Autowired
	SqlSession session;

	public List<MenuVO> selectAllMenu(int truck_code){
		return session.selectList("Menu.selectAllMenu",truck_code);
	}

	public int insertMenu(MenuVO vo) {
		return session.insert("Menu.insertMenu", vo);
	}

	public int updateMenu(MenuVO vo) {
		return session.update("Menu.updateMenu", vo);
	}

	public int deleteMenu(int menu_no) {
		return session.delete("Menu.deleteMenu",menu_no);
	}

	public int updateMenulike(int menu_no) {
		return session.update("Menu.updateMenulike",menu_no);
	}

	public int seleteMenulikeNumber(int menu_no) {
		return session.selectOne("Menu.seleteMenulikeNumber", menu_no);
	}
}
