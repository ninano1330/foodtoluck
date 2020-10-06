package kitri.project.vo;

import org.springframework.web.multipart.MultipartFile;

public class MenuVO {
	private int menu_no;
	private int truck_code;
	private String menu_name;
	private String menu_origin;
	private int menu_like;
	private String menu_intro;
	private String menu_image;
	private int menu_price;
	private String user_like = "unlike";
	
	MultipartFile image_file;
	
	
	public MenuVO() {
	}
	public MultipartFile getImage_file() {
		return image_file;
	}
	public void setImage_file(MultipartFile image_file) {
		this.image_file = image_file;
	}
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public int getTruck_code() {
		return truck_code;
	}
	public void setTruck_code(int truck_code) {
		this.truck_code = truck_code;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_origin() {
		return menu_origin;
	}
	public void setMenu_origin(String menu_origin) {
		this.menu_origin = menu_origin;
	}
	public int getMenu_like() {
		return menu_like;
	}
	public void setMenu_like(int menu_like) {
		this.menu_like = menu_like;
	}
	public String getMenu_intro() {
		return menu_intro;
	}
	public void setMenu_intro(String menu_intro) {
		this.menu_intro = menu_intro;
	}
	public String getMenu_image() {
		return menu_image;
	}
	public void setMenu_image(String menu_image) {
		this.menu_image = menu_image;
	}
	public int getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	
	public String getUser_like() {
		return user_like;
	}
	public void setUser_like(String user_like) {
		this.user_like = user_like;
	}
	
	@Override
	public String toString() {
		return this.menu_image;
	}
	
	
	
	
}
