package kitri.project.vo;

public class FoodTypeVO {
	int foodtype_code;
	String foodtype_name;
	
	public FoodTypeVO() {super();}
	
	
	public FoodTypeVO(int foodtype_code, String foodtype_name) {
		super();
		this.foodtype_code = foodtype_code;
		this.foodtype_name = foodtype_name;
	}
	

	public int getFoodtype_code() {return foodtype_code;}
	public void setFoodtype_code(int foodtype_code) {this.foodtype_code = foodtype_code;}
	public String getFoodtype_name() {return foodtype_name;}
	public void setFoodtype_name(String foodtype_name) {this.foodtype_name = foodtype_name;}


	@Override
	public String toString() {
		return "FoodTypeVO [foodtype_code=" + foodtype_code + ", foodtype_name=" + foodtype_name + "]";
	}	
	
}
