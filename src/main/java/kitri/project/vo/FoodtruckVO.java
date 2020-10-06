package kitri.project.vo;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FoodtruckVO {
   private int truck_code;
   private String truck_name;
   private String truck_image = "resources/img/truckImage/default.png";
   private String truck_intro;
   private int truck_like;
   private String truck_x;
   private String truck_y;
   private String owner_id;
   
   private String address_first;
   private String address_second;
   private String address_third;
   private String address_full;
   
   MultipartFile image_file;
   
   public FoodtruckVO() {
   }
   
   
   public FoodtruckVO(int truck_code, String truck_name, String truck_image, String truck_intro, int truck_like,
		String truck_x, String truck_y, String owner_id, String address_first, String address_second,
		String address_third, String address_full) {
	super();
	this.truck_code = truck_code;
	this.truck_name = truck_name;
	this.truck_image = truck_image;
	this.truck_intro = truck_intro;
	this.truck_like = truck_like;
	this.truck_x = truck_x;
	this.truck_y = truck_y;
	this.owner_id = owner_id;
	this.address_first = address_first;
	this.address_second = address_second;
	this.address_third = address_third;
	this.address_full = address_full;
   }
   
   public FoodtruckVO(int truck_code, String truck_name, String truck_intro, String truck_x, String truck_y, String address_full) {
		super();
		this.truck_code = truck_code;
		this.truck_name = truck_name;
		this.truck_intro = truck_intro;
		this.truck_x = truck_x;
		this.truck_y = truck_y;
		this.address_full = address_full;
   }
   public FoodtruckVO(String truck_name, String address_first, String address_second, String address_third) {
		super();
		this.truck_name = truck_name;
		this.address_first = address_first;
		this.address_second = address_second;
		this.address_third = address_third;
	}
	
	
	public FoodtruckVO(String truck_name, String truck_x, String truck_y, String address_first, String address_second,
			String address_third) {
		super();
		this.truck_name = truck_name;
		this.truck_x = truck_x;
		this.truck_y = truck_y;
		this.address_first = address_first;
		this.address_second = address_second;
		this.address_third = address_third;
	}

	
	public FoodtruckVO(String truck_name, String truck_intro, String truck_x, String truck_y, String address_first,
			String address_second, String address_third, String address_full) {
		super();
		this.truck_name = truck_name;
		this.truck_intro = truck_intro;
		this.truck_x = truck_x;
		this.truck_y = truck_y;
		this.address_first = address_first;
		this.address_second = address_second;
		this.address_third = address_third;
		this.address_full = address_full;
	}
   
   public MultipartFile getImage_file() {
      return image_file;
   }
   public void setImage_file(MultipartFile image_file) {
      this.image_file = image_file;
   }

   public String getAddress_full() {
      return address_full;
   }
   public void setAddress_full(String address_full) {
      this.address_full = address_full;
   }
   public int getTruck_code() {
      return truck_code;
   }
   public void setTruck_code(int truck_code) {
      this.truck_code = truck_code;
   }
   public String getTruck_name() {
      return truck_name;
   }
   public void setTruck_name(String truck_name) {
      this.truck_name = truck_name;
   }
   public String getTruck_image() {
      return truck_image;
   }
   public void setTruck_image(String truck_image) {
      this.truck_image = truck_image;
   }
   public String getTruck_intro() {
      return truck_intro;
   }
   public void setTruck_intro(String truck_intro) {
      this.truck_intro = truck_intro;
   }
   public int getTruck_like() {
      return truck_like;
   }
   public void setTruck_like(int truck_like) {
      this.truck_like = truck_like;
   }
   public String getTruck_x() {
      return truck_x;
   }
   public void setTruck_x(String truck_x) {
      this.truck_x = truck_x;
   }
   public String getTruck_y() {
      return truck_y;
   }
   public void setTruck_y(String truck_y) {
      this.truck_y = truck_y;
   }
   
   public String getAddress_first() {
	return address_first;
   }
   public void setAddress_first(String address_first) {
		this.address_first = address_first;
	}
	
	
   public String getAddress_second() {
		return address_second;
   }


	public void setAddress_second(String address_second) {
		this.address_second = address_second;
	}


	public String getAddress_third() {
		return address_third;
	}


	public void setAddress_third(String address_third) {
		this.address_third = address_third;
	}
	
	public String getOwner_id() {
	      return owner_id;
	}
	public void setOwner_id(String owner_id) {
	   this.owner_id = owner_id;
	}


}