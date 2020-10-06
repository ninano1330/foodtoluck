package kitri.project.vo;

public class ReviewVO {
	private int menu_no = 0;
	private String member_id = "";
	private int menu_star = 0;
	private String review_content = "";
	private String review_date = "";
	
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getMenu_star() {
		return menu_star;
	}
	public void setMenu_star(int menu_star) {
		this.menu_star = menu_star;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	
	
}
