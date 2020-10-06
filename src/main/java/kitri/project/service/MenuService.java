package kitri.project.service;

import java.util.List;

import kitri.project.vo.MenuVO;

public interface MenuService {

	public List<MenuVO> selectAllMenu(int truck_code);
	public int insertMenu(MenuVO vo);
	public int updateMenu(MenuVO vo);
	public int deleteMenu(int menu_no);
	public String imageUpload(MenuVO vo) throws Exception;
	public int updateMenulike(int menu_no);
	public int seleteMenulikeNumber(int menu_no);
}
