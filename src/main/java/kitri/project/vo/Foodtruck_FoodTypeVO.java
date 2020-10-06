package kitri.project.vo;

public class Foodtruck_FoodTypeVO {
	
	int truck_code;
	String foodtype_name;
	
	public Foodtruck_FoodTypeVO(){}
	public Foodtruck_FoodTypeVO(int truck_code, String foodtype_name) {
		this.truck_code = truck_code;
		this.foodtype_name = foodtype_name;
	}

	public int getTruck_code() {
		return truck_code;
	}

	public void setTruck_code(int truck_code) {
		this.truck_code = truck_code;
	}

	public String getfoodtype_name() {
		return foodtype_name;
	}

	public void getfoodtype_name(String foodtype_name) {
		this.foodtype_name = foodtype_name;
	}

	@Override
	public String toString() {
		return "Truck_FoodTypeVO [truck_code=" + truck_code + ", foodtype_code=" + foodtype_name + "]";
	}
}
